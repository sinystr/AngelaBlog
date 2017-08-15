include FileUtils::Verbose

before do
    path = request.path_info.split('/')
    
    if !user_signed_in? && path[1] == 'admin'
        flash[:error] = I18n.t('no_rights')
        redirect '/users/login'
    end

    if user_signed_in? && path[1] == 'admin' && !current_user.admin?
        flash[:error] = I18n.t('no_rights')
        redirect '/'
    end
end

get '/admin/users' do
    @users = User.all
    erb :'admin/control_users'
end

get '/admin/users/delete/:id' do
    User.destroy(params[:id])
    flash[:success] = I18n.t('delete_user_success')
    redirect '/admin/users'
end

post '/admin/users/set_rank' do
    user = User.find(params[:user_id]);
    user.rank = params[:rank]
    user.save

    if !user
        flash[:error] = I18n.t('rang_change_fail')
    end

    redirect '/admin/users'
end

get '/admin/articles/create' do  
    erb :'admin/create_edit_article'
end

get '/admin/articles/edit/:id' do
    @article = Article.find(params[:id])
    erb :'admin/create_edit_article'
end


post '/admin/articles/create' do
    picturesController = PicturesController.new
    picture = picturesController.upload_picture params[:picture]

    article = Article.new picture: picture, title_en: params[:title_en], text_en: params[:text_en],
                title_bg: params[:title_bg], text_bg: params[:text_bg]
    
    article.tags << params[:tags].split(',').map {|tag| Tag.find_or_create_by(name: tag)}

    if article.save
        flash[:success] = I18n.t('article_published')
        redirect '/'
    else  
        erb :'admin/create_edit_article', locals: {errors: article.errors}
    end
end


post '/admin/articles/update/:id' do
    if params[:picture]
        picturesController = PicturesController.new
        picture = picturesController.upload_picture params[:picture]
    end

    article = Article.find(params[:id]);
    article.picture = params[:picture] unless picture.nil?
    article.title_bg = params[:title_bg]
    article.text_bg = params[:text_bg]
    article.title_en = params[:title_en]
    article.text_en = params[:text_en]
    article.active = params[:active]

    if article.save
        article.tags.destroy_all
        article.tags << params[:tags].split(',').map {|tag| Tag.find_or_create_by(name: tag)}
        flash[:success] = I18n.t('article_updated')
        redirect '/'
    else  
        erb :'admin/create_edit_article', locals: {errors: article.errors}
    end

end

get '/admin/articles/delete/:id' do
    Article.destroy(params[:id])
    flash[:success] = I18n.t('article_deleted')
    redirect '/'
end

get '/admin/comments/delete/:id' do
    comment = Comment.find(params[:id])
    article_id = comment.article_id
    comment.destroy
    flash[:success] = I18n.t('comment_deleted')
    redirect "/articles/#{article_id}"
end


get '/admin/comments/edit/:id' do
    @comment = Comment.find(params[:id])
    erb :'admin/edit_comment'
end

post '/admin/comments/edit/:id' do
    @comment = Comment.find(params[:id])
    @comment.text = params[:text]

    if @comment.save
        flash[:success] = I18n.t('comment_edited')
        redirect "/articles/#{@comment.article_id}"
    else  
        erb :'admin/edit_comment', locals: {errors: @comment.errors}
    end
end
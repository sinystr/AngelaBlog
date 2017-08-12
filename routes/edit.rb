include FileUtils::Verbose

before do
    path = request.path_info.split('/')
    
    if !user_signed_in? && path[1] == 'edit'
        flash[:error] = 'Нямате права да достъпите тази страница!'
        redirect '/users/login'
    end

    if user_signed_in? && path[1] == 'edit' && path[2] == 'users' && !current_user.can_control_users?
        flash[:error] = 'Нямате права да достъпите тази страница!'
        redirect '/'
    end

    if user_signed_in? && path[2] == 'edit' && path[2] == 'articles' && !current_user.can_control_articles?
        flash[:error] = 'Нямате права да достъпите тази страница!'
        redirect '/'
    end
end

get '/edit/users/' do
    @users = User.all 
    erb :'edit/users'
end

post '/edit/users/set_rank/' do
    user = User.find(params[:user]);
    user.rank = params[:rank]
    user.save
    if !user
        flash[:error] = 'Възникна грешка при обновяването на ранга на потребителя'
    end
    redirect '/edit/users/'
end

get '/edit/articles/create' do  
    erb :'edit/articles/create'
end

get '/edit/articles/edit' do
    @article = Article.find(params[:id])
    erb :'edit/articles/create'
end


post '/edit/articles/create' do
    picturesController = PicturesController.new
    picture = picturesController.upload_picture params[:picture]

    article = Article.new picture: picture, title_en: params[:title_en], text_en: params[:text_en],
                title_bg: params[:title_bg], text_bg: params[:text_bg]
    
        if article.save
            flash[:success] = 'Успешно публикувахте статията!'
            redirect '/'
        else  
            erb :'edit/articles/create', locals: {errors: article.errors}
        end

    erb :'edit/articles/create'
end

get '/edit/articles/delete' do
    Article.destroy(params[:id])
    flash[:success] = 'Успешно изтрихте статията!'
    redirect '/'
end

get '/edit/article/comment/delete' do
    comment = Comment.find(params[:id])
    article_id = comment.article_id
    comment.destroy
    flash[:success] = 'Успешно изтрихте коментара!'
    redirect "/articles/?article_id=#{article_id}"
end


get '/edit/article/comment/edit' do
    @comment = Comment.find(params[:id])
    erb :'edit/articles/comment'
end

post '/edit/article/comment/edit' do
    @comment = Comment.find(params[:id])
    @comment.text = params[:text]

    if @comment.save
        flash[:success] = 'Коментара успешно е променен!'
        redirect "/articles/?article_id=#{@comment.article_id}"
    else  
        erb :'edit/articles/comment', locals: {errors: @comment.errors}
    end
end
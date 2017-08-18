get '/articles' do
  @title = I18n.t('articles')
  articles_controller = ArticlesController.new
  @articles = articles_controller.articles_for_params(params)
  @articles = @articles.select(&:active) unless user_signed_in? && current_user.admin?
  erb :'articles/list'
end

get '/articles/tag/:id' do
  tag = Tag.find(params[:id])
  @articles = tag.articles
  @title = I18n.t('articles_with_tag', tag: tag.name)
  erb :'articles/list'
end

get '/articles/:id' do
  @article = Article.find(params[:id])
  erb :'articles/single'
end

post '/articles/add_comment/' do
  comment = Comment.new text: params[:comment], user_id: session[:user_id], article_id: params[:article_id]

  if comment.save
    flash[:success] = I18n.t('comment_successfuly_added')
    redirect "/articles/#{params[:article_id]}"
  else
    flash[:error] = I18n.t('comment_not_successfuly_added')
    redirect '/'
  end
end

get '/tags' do
  @tags = Tag.all.select { |tag| tag.articles.count > 0 }
  erb :'tags/list'
end

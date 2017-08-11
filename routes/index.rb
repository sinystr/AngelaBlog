get '/' do
    @articles = Article.all
    erb :index
end

get '/articles/' do
    @article = Article.find(params[:article_id])
    erb :article
end
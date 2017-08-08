get '/' do
    @articles = Article.all
    erb :index
end
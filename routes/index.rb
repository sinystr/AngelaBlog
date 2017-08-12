get '/' do
    redirect '/articles'
end

get '/articles' do
    if !params[:tag].nil?
        tag =  Tag.find(params[:tag])
        @articles = tag.articles
        @title = "Статии съдържащи таг: <b>#{tag.name}</b>"
        erb :index
    else
        @title = "Статии"
        @articles = Article.all
        erb :index
    end
end

get '/articles/' do
    @article = Article.find(params[:article_id])
    erb :article
end

post '/articles/add_comment/' do
    comment = Comment.new text: params[:comment], user_id: session[:user_id], article_id: params[:article_id]
    
    if comment.save
        flash[:success] = 'Коментара е добавен успешно!'
        redirect "/articles/?article_id=#{params[:article_id]}"
    else  
        flash[:error] = 'Коментара не е добавен успешно!'
        redirect '/'
    end
end

get '/tags/' do
    @tags = Tag.all.select {|tag| tag.articles.count > 0}
    erb :tags
end

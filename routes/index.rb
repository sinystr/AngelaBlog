get '/' do
    @articles = Article.all
    erb :index
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
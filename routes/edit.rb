get '/edit/users'
    @users = User.all
    erb :users
end
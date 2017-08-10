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

post '/edit/articles/create' do
    tempfile = params[:picture][:tempfile] 
    filename = params[:picture][:filename] 
    cp(tempfile.path, "public/uploads/#{filename}")
    puts '-' * 33, params, '-' * 33
    erb :'edit/articles/create'
end
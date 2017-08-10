get '/users/register' do
  erb :'users/register'
end

post '/users/register' do
  user = User.new email: params[:email], name: params[:name], password: params[:password]
  if user.save
    flash[:success] = 'Регистрирахте се успешно! Може да влезете в акаунта си.'
    redirect '/users/login'
  else  
    puts user.errors
    erb :'users/register', locals: {errors: user.errors}
  end
end

get '/users/login' do
  erb :'users/login'
end

get '/users/logout' do
  session[:user_id] = nil
  flash[:success] = 'Успешно излязохте от акаунта си!'
  redirect '/users/login'
end

post '/users/login' do
  user = User.find_by(:email => params[:email], :password => params[:password]);

  if user
      session[:user_id] = user.id
      redirect '/'
  else
      flash[:error] = 'Невалидно потребителско име или парола!'
      redirect '/users/login'
  end

  erb :'users/login'
end

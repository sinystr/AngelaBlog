get '/users/register' do
  erb :'users/register'
end

post '/users/register' do
  user = User.new email: params[:email], 
                  name: params[:name], password: params[:password], secret_answer: params[:secret_answer]
  if user.save
    flash[:success] = 'Регистрирахте се успешно! Може да влезете в акаунта си.'
    redirect '/users/login'
  else  
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

get '/users/forgotten_password' do
  erb :'users/forgotten_password'
end

post '/users/forgotten_password' do
  user = User.find_by email: params[:email]
  
  if !user
    flash[:error] = 'Потребителя не съществува!'
    redirect '/users/forgotten_password'
  end
    
  if user.secret_answer != params[:secret_answer]
    flash[:error] = 'Отговора на тайния въпрос е грешен!'
    redirect '/users/forgotten_password'
  end

  flash[:success] = "Усешно възстановихте паролата си! Паролата ви за вход е '#{user.password}'."
  redirect '/users/login'
end
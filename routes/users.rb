get '/users/register' do
  erb :'users/register'
end

post '/users/register' do
  user = User.new email: params[:email],
                  name: params[:name], secret_answer: params[:secret_answer]

  unless user.password_valid?(params[:password])
    flash[:error] = I18n.t('password_invalid')
    redirect '/users/register'
  end

  user.password_to_be_hashed = params[:password]

  if user.save
    flash[:success] = I18n.t('register_success')
    redirect '/users/login'
  else
    erb :'users/register', locals: { errors: user.errors }
  end
end

get '/users/login' do
  erb :'users/login'
end

get '/users/logout' do
  session[:user_id] = nil
  flash[:success] = I18n.t('logout_success')
  redirect '/users/login'
end

post '/users/login' do
  user = User.find_by(email: params[:email])

  if user && user.password_correct?(params[:password])
    session[:user_id] = user.id
    redirect '/'
  else
    flash[:error] = I18n.t('invalid_user_or_password')
    redirect '/users/login'
  end

  erb :'users/login'
end

get '/users/forgotten_password' do
  erb :'users/forgotten_password'
end

post '/users/forgotten_password' do
  user = User.find_by email: params[:email]

  unless user
    flash[:error] = I18n.t('user_does_not_exist')
    redirect '/users/forgotten_password'
  end

  if user.secret_answer != params[:secret_answer]
    flash[:error] = I18n.t('wrong_secret_answer')
    redirect '/users/forgotten_password'
  end

  user.password_to_be_hashed = params[:new_password]

  if user.save
    flash[:success] = I18n.t('restore_password_success')
  else
    flash[:fail] = I18n.t('restore_password_fail')
  end

  redirect '/users/login'
end

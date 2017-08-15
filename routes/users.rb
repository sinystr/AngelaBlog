get '/users/register' do
  erb :'users/register'
end

post '/users/register' do
  password_salt = BCrypt::Engine.generate_salt
  password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)

  user = User.new email: params[:email], 
                  name: params[:name], password: password_hash, password_salt: password_salt, secret_answer: params[:secret_answer]
  if user.save
    flash[:success] = I18n.t('register_success')
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
  flash[:success] = I18n.t('logout_success')
  redirect '/users/login'
end

post '/users/login' do
  user = User.find_by(:email => params[:email]);

  if user
    if user[:password] == BCrypt::Engine.hash_secret(params[:password], user[:password_salt])
      session[:user_id] = user.id
      redirect '/'
    end
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
  
  if !user
    flash[:error] = I18n.t('user_does_not_exist')
    redirect '/users/forgotten_password'
  end
    
  if user.secret_answer != params[:secret_answer]
    flash[:error] = I18n.t('wrong_secret_answer')
    redirect '/users/forgotten_password'
  end

  password_salt = BCrypt::Engine.generate_salt
  password_hash = BCrypt::Engine.hash_secret(params[:new_password], password_salt)

  user.password = password_hash;
  user.password_salt = password_salt;
  
  if user.save
    flash[:success] = I18n.t('restore_password_success')
  else
    flash[:fail] = I18n.t('restore_password_fail')
  end

  redirect '/users/login'
end
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'i18n'
require 'i18n/backend/fallbacks'
require 'securerandom'
require 'rmagick'

# Routes
require_relative 'routes/users'
require_relative 'routes/index'
require_relative 'routes/edit'

# Models
require_relative 'models/user'
require_relative 'models/article'
require_relative 'models/comment'
require_relative 'models/tag'

require_relative 'lib/pictures_controller'

configure do
  I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
  I18n.load_path = Dir[File.join(settings.root, 'locales', '*.yml')]
  I18n.backend.load_translations
end

enable :sessions

@current_user

before do
  set_locale
end

helpers do
  def set_locale
    if params[:locale]
      # Save the selected locale on session
      session[:locale] = params[:locale]
      # Set the selected locale
      I18n.locale = params[:locale]
      # Redirect to the referer url
      redirect '/'
    end

    I18n.locale = session[:locale] || "bg"
  end

  def user_signed_in?
    !session[:user_id].nil?
  end

  def current_user
    
    if @current_user.nil? && user_signed_in?
      @current_user = User.find(session[:user_id]);
    end

    @current_user;
  end

  

  def option_select(value, text)
    selected = session[:locale] == value ? ' selected' : ''
    "<option value=#{value}#{selected}>#{text}</option>"
  end
end
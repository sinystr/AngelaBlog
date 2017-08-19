require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'i18n'
require 'i18n/backend/fallbacks'
require 'securerandom'
require 'rmagick'
require 'bcrypt'

# Routes
require_relative 'routes/users'
require_relative 'routes/articles'
require_relative 'routes/admin'

# Models
require_relative 'models/user'
require_relative 'models/article'
require_relative 'models/comment'
require_relative 'models/tag'

require_relative 'lib/pictures_controller'
require_relative 'lib/articles_controller'
require_relative 'helpers/i18n_helper'

enable :sessions

configure do
  I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
  I18n.load_path = Dir[File.join(settings.root, 'locales', '*.yml')]
  I18n.backend.load_translations
end

before do
  set_locale
end

get '/' do
  redirect '/articles'
end

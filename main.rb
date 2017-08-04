require 'sinatra'
require "sinatra/activerecord"

get '/' do
    erb :index, locals: {title: 'Fly me to the moon!'}
end
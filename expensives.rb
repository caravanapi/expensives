require 'sinatra'
require 'active_record'

require File.expand_path('../models/post', __FILE__)
configure do
  require File.expand_path('../models/database', __FILE__)
end

get '/' do
  erb :index
end

get '/noticia/:title' do
  erb :show
end

# Administração

get '/new' do
  erb :new
end

post '/create' do
  
end

post '/ativar/:id' do
  
end

post '/desativar/:id' do
  
end
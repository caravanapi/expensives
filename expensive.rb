require 'rubygems'
require 'sinatra'


get '/' do
  erb :index
end

get '/noticia/:title' do
  erb :show
end

# Administração

get '/new' do
  
end

post '/create' do
  
end

post '/ativar/:id' do
  
end

post '/desativar/:id' do
  
end
require 'sinatra'
require 'active_record'
$LOAD_PATH << '.'

require 'models/post'
configure do
  require 'models/database'
end

get '/' do
  @posts = Post.all
  erb :index
end

get '/:slug' do
  erb :show
end

# Administração

get '/admin/new' do
  erb :new
end

post '/admin/create' do
  
end

post '/ativar/:id' do
  
end

post '/desativar/:id' do
  
end
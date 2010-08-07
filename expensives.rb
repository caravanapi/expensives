require 'rubygems'
require 'sinatra'
require 'active_record'

=begin
require 'models/post'
configure do
  require 'models/database'
end
=end

get '/' do
  # @posts = Post.all
  erb :index
end

get '/:slug' do
  @post = Post.find_by_slug(params[:slug]).first
  erb :show
end

# Administração

get '/admin/new' do
  erb :new
end

post '/admin/create' do
  @post = Post.new(params[:post])
  if @post.save
    redirect "/#{@post.slug}" 
  end
end

post '/ativar/:id' do
  
end

post '/desativar/:id' do
  
end
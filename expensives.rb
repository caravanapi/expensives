require 'rubygems'
require 'sinatra'
require 'active_record'
require 'active_support'
require 'active_support/all'

$KCODE = 'UTF8'

require 'models/post'
configure do
  require 'models/database'
end

# Administração

get '/noticias/nova' do
  erb :new
end

post '/noticias' do
  @post = Post.new(params[:post])
  if @post.save
    redirect "/noticias/#{@post.slug}" 
  end
end

post '/ativar/:id' do
  @post = Post.find(params[:id])
  @post.active = true
  if @post.save
    redirect "/noticias/#{@post.slug}"
  end
end

post '/desativar/:id' do
  @post = Post.find(params[:id])
  @post.active = false
  if @post.save
    redirect "/noticias"
  end
end  

get '/' do
  @posts = Post.all
  @issue = 1
  erb :index
end

get '/noticias/:slug' do
  @post = Post.by_slug(params[:slug]).first
  erb :show
end

require 'rubygems'
require 'sinatra'
require 'active_record'

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
  
end

post '/desativar/:id' do

end  
get '/' do
  @posts = Post.all
  erb :index
end

get '/noticias/:slug' do
  @post = Post.by_slug(params[:slug])
  erb :show
end

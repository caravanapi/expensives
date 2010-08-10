#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'

configure do
  require File.expand_path('config/run', File.dirname(__FILE__))
end

# Administração

get '/edicao/:edition' do
  @post = Issue.find_by_edition(params[:edition]).highlight
  erb :'posts/show'
end

get '/noticias/nova' do
  erb :'posts/new'
end

post '/noticias' do
  @post = Post.new(params[:post])
  @post.issue = Issue.most_recent.first
  if @post.save
    redirect "/edicao/#{@post.issue.edition}/#{@post.slug}"
  end
end

post '/ativar/:id' do
  @post = Post.find(params[:id])
  @post.active = true
  if @post.save
    redirect "/edicao/#{@post.issue.edition}/#{@post.slug}"
  end
end

post '/desativar/:id' do
  @post = Post.find(params[:id])
  @post.active = false
  if @post.save
    redirect "/edicao/#{@post.issue.edition}"
  end
end  

get '/' do
  @issue = Issue.most_recent.first
  redirect "/edicao/#{@issue.edition}"
end

get '/edicao/:edition/:slug' do
  @post = Post.by_slug(params[:slug]).first
  @posts = Post.all
  erb :'posts/show'
end

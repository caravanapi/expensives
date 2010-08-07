require 'spec_helper'
require 'expensives'

describe "Expensives" do  
  include Rack::Test::Methods
  
  before(:each) do
    @post = Post.new({
      :title => "This is a title",
      :subtitle => "This is a subtitle",
      :image_url => "http://picasa.google.com/image.jpg",
      :slug => 'this-is-a-title'
    })
  end
  
  def app
    @app ||= Sinatra::Application
  end
  
  describe "GET /index" do
    it "should be succesfull" do
      get '/'
      last_response.should be_ok
    end
    
    it "should display a list of posts" do
      Post.should_receive(:all).with(no_args).and_return([@post])
      get '/'
      last_response.body.should =~ /This is a title/
    end
  end
  
  describe "GET /this-is-a-title" do
    it "should display a post" do
      Post.should_receive(:by_slug).with('this-is-a-title').and_return(@post)
      get '/this-is-a-title'
      last_response.should be_ok
      last_response.body.should =~ /This is a title/
    end
  end
  
  describe "GET /admin/new" do
    it "should display a form to create a new post" do
      get '/admin/new'
      last_response.should be_ok
      last_response.body.should =~ /<form action=\"\/admin\/create\" method=\"post\">/
    end
  end
  
  describe "POST /admin/create" do
    it "should create a new post" do
      Post.should_receive(:create).with({
        'title' => 'This is a titile',
        'subtitle' => 'This is a subtitle',
        'image_url' => 'http://www.google.com'
      }).and_return(@post)
      
      post '/admin/create', :post => {
        :title => 'This is a titile',
        :subtitle => 'This is a subtitle',
        :image_url => 'http://www.google.com'
      }
      follow_redirect!
      last_response.should be_ok
    end
  end
end
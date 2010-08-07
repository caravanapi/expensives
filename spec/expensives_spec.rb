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
  
  describe "GET /noticias/this-is-a-title" do
    it "should display a post" do
      Post.should_receive(:by_slug).with('this-is-a-title').and_return(@post)
      get '/noticias/this-is-a-title'
      last_response.should be_ok
      last_response.body.should =~ /This is a title/
    end
  end
  
  describe "GET /noticias/nova" do
    it "should display a form to create a new post" do
      get '/noticias/nova'
      last_response.should be_ok
      last_response.body.should =~ /<form action=\"\/noticias\" method=\"post\">/
    end
  end
  
  describe "POST /noticias" do
    before(:each) do
      @params = {
        'title' => 'This is a titile',
        'subtitle' => 'This is a subtitle',
        'image_url' => 'http://www.google.com'
      }
    end
    
    describe "with valid params" do
      it "should redirect to post page" do
        Post.should_receive(:new).with(@params).and_return(@post)
        @post.should_receive(:save).and_return(true)
      
        post '/noticias', :post => @params
        follow_redirect!
        last_response.should be_ok
      end
    end
  end
  
  describe "POST /ativar/id" do
    
    before(:each) do
      @post = Post.create(:title => "Notícia em primeira mão",
                          :subtitle => "Que bomba!",
                          :image_url => "http://google.com/image.jpg")
    end
    
    it "should deactivate a post" do
      pending
      Post.should_receive(:active).with(@post.id).and_return(true)
      @post.should_receive(:save)
    end
  end
  

end
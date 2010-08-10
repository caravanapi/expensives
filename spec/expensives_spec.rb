require 'spec_helper'
require 'expensives'

describe "Expensives" do  
  include Rack::Test::Methods
  
  before(:all) do
    Post.delete_all
    Issue.delete_all
  end
  
  before(:each) do
    @post = Post.create(:title => "Notícia em primeira mão",
                        :subtitle => "Que bomba!",
                        :image_url => "http://google.com/image.jpg")
    @issue = Issue.create(:edition => 1, 
                          :published_at => Date.new(2010, 8, 7),
                          :highlight => @post)
    @issues = [@issue]
    @issues.stub!(:first => @issue )
  end
  
  after(:each) do
    @post.destroy
    @issue.destroy
  end
  
  def app
    @app ||= Sinatra::Application
  end
  
  describe "GET /index" do
    it "should redirect to the last edition" do
      Issue.should_receive(:most_recent).with(no_args).and_return(@issues)
      get '/'
      follow_redirect!
      last_response.should be_ok
    end
  end
  
  describe "GET /edicao/1" do
    it "should show the issue highlight" do
      Issue.should_receive(:find_by_edition).with('1').and_return(@issue)
      get '/edicao/1'
      last_response.should be_ok
    end
  end
  
  describe "GET /edicao/1/noticia-em-primeira-m-o" do
    it "should display a post" do
      Post.should_receive(:by_slug).with('noticia-em-primeira-m-o').and_return([@post])
      get '/edicao/1/noticia-em-primeira-m-o'
      last_response.should be_ok
      last_response.body.should =~ /Notícia em primeira mão/
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
        'title' => "Notícia em primeira mão",
        'subtitle' => "Que bomba!",
        'image_url' => "http://google.com/image.jpg"
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
    it "should deactivate a post" do
      pending
      Post.should_receive(:active).with(@post.id).and_return(true)
      @post.should_receive(:save)
    end
  end
end
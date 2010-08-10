require 'spec_helper'

describe Post do
  before(:all) do
    Post.delete_all
  end
  
  after(:each) do
    Post.delete_all
  end
  
  subject do
    @post = Post.new({
      :title => "This is a title",
      :subtitle => "This is a subtitle",
      :image_url => "http://picasa.google.com/image.jpg"
    })
  end
  
  it "should not be valid without a title" do
    subject.title = nil
    subject.should_not be_valid
  end

  it "should not be valid without a subtitle" do
    subject.subtitle = nil
    subject.should_not be_valid
  end
  
  it "should create a slug based on the title" do
    subject.save.should be_true
    subject.slug.should == "this-is-a-title"
  end

  it "should not be valid without an image url" do
    subject.image_url = nil
    subject.should_not be_valid
  end
end
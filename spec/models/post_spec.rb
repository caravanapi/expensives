require 'spec_helper'

describe Post do
  subject do
    @post = Post.new({
      :title => "This is a title"
    })
  end
  
  it "should not be valid without a title" do
    subject.title = nil
    subject.should_not be_valid
  end
end
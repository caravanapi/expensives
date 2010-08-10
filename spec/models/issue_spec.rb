require 'spec_helper'

describe Issue do
  subject do
    @issue = Issue.new({
      :edition => 1,
      :published_at => Date.today
    })
  end
  
  it "should not be valid without an edition number" do
    subject.edition = nil
    subject.should_not be_valid
    subject.errors.on(:edition).should include("can't be blank")
  end
  
  it "should not be valid with a non numeric edition" do
    subject.edition = "A"
    subject.should_not be_valid
    subject.errors.on(:edition).should include('is not a number')
  end
  
  it "should not be valid without a publication date" do
    subject.published_at = nil
    subject.should_not be_valid
    subject.errors.on(:published_at).should include("can't be blank")
  end
end
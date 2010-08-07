class Post < ActiveRecord::Base
  before_save :slugfy

  validates_presence_of :title
  validates_presence_of :subtitle
  validates_presence_of :image_url
  
  def slugfy
    self.slug = title.gsub(/\W/, '-').downcase
  end
end
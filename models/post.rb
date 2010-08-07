class Post < ActiveRecord::Base
  before_save :slugfy

  validates_presence_of :title
  validates_presence_of :subtitle
  validates_presence_of :image_url
  
  named_scope :by_slug, lambda { |slug| { :conditions => { :slug => slug } } }
  
  def slugfy
    self.slug = title.gsub(/\W/, '-').downcase
  end
end
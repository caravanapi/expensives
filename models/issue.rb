class Issue < ActiveRecord::Base
  validates_presence_of :edition
  validates_numericality_of :edition
  validates_presence_of :published_at
  
  has_many :posts
  has_one :highlight, :class_name => "Post"
  
  named_scope :most_recent, :order => "published_at DESC", :limit => 1
end
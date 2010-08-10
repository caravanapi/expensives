class Issue < ActiveRecord::Base
  validates_presence_of :edition
  validates_numericality_of :edition
  validates_presence_of :published_at
end
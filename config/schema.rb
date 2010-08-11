require './models/issue'
require './models/post'

Setup.tables = {
  Issue => {
    :edition => { :type => :integer, :default => 0, :null => false },
    :published_at => { :type => :date },
    :highlight_id => { :type => :integer }
  },
  Post => {
    :title => { :type => :string, :default => "", :null => false },
    :subtitle => { :type => :string, :default => "", :null => false  },
    :image_url => { :type => :string, :default => "", :null => false },
    :slug => { :type => :string, :default => "", :null => false },
    :active => { :type => :boolean, :default => true, :null => false },
    :issue_id => { :type => :integer }
  }
}
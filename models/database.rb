config = YAML.load(File.read('database.yml'))

ActiveRecord::Base.establish_connection config[ENV['RACK_ENV']]

ActiveRecord::Migration.class_eval do
  tables = {
    Issue => {
      :edition => { :type => :integer, :default => 0, :null => false },
      :published_at => { :type => :date }
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
  
  tables.each_pair do |klass, columns|
    create_table klass.table_name unless klass.table_exists?
    columns.each_pair do |name, info|
      unless klass.column_names.include?(name.to_s)
        add_column(klass.table_name, name, info[:type], info.except(:type))
      end
    end
  end
  unless index_exists?(:posts, "posts_slug", true)
    add_index :posts, :slug, :unique => true, :name => "posts_slug"
  end
end
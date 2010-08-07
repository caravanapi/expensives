config = YAML.load(File.read('database.yml'))

ActiveRecord::Base.establish_connection config[ENV['RACK_ENV']]

ActiveRecord::Migration.class_eval do
  columns = {
    :title => { :type => :string, :options => { :null => false } },
    :subtitle => { :type => :string, :options => { :null => false } },
    :image_url => { :type => :string, :options => { :null => false } },
    :slug => { :type => :string, :options => { :null => false } },
    :active => { :type => :boolean, :options => { :default => true, :null => false }}
  }
  
  create_table :posts unless Post.table_exists?
  columns.each_pair do |name, info|
    add_column(:posts, name, info[:type], info[:options]) unless Post.column_names.include?(name.to_s)
  end
  # add_index :posts, :slug
end
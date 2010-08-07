config = YAML.load(File.read('database.yml'))

ActiveRecord::Base.establish_connection config[ENV['RACK_ENV']]

ActiveRecord::Migration.class_eval do
  unless Post.table_exists?
    create_table :posts do |t|
      t.string :title, :null => false
      t.string :subtitle, :null => false
      t.string :image_url, :null => false
      t.string :slug, :null => false
    end
  else
      add_column :posts, :active, :boolean, :default => true, :null => false unless Post.column_names.include?("active")
  end
end
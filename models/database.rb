
ActiveRecord::Base.establish_connection(
   :adapter   => 'sqlite3',
   :database  => "./db/expensives.db"
)

ActiveRecord::Migration.class_eval do
  unless Post.table_exists?
    create_table :posts do |t|
      t.string :title
    end
  end
end
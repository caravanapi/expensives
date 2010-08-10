require 'active_record'
require 'sqlite3'

class Setup
  def self.tables=(value)
    @tables = value
  end
  
  def self.connect_to_db!
    config = YAML.load(File.read('config/database.yml'))
    ActiveRecord::Base.establish_connection config[ENV['RACK_ENV']]
  end
  
  def self.create_tables!
    tables = @tables
    ActiveRecord::Migration.class_eval do
      tables.each_pair do |klass, columns|
        table_name = klass.table_name rescue klass.to_s
        create_table table_name unless table_exists?(table_name)
        table_columns = columns(table_name).map(&:name)
        columns.each_pair do |name, info|
          unless table_columns.include?(name.to_s)
            add_column(table_name, name, info[:type], info.except(:type))
          end
        end
      end
    end
  end
end
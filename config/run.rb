require './lib/database_setup'

require './config/schema'

Setup.connect_to_db!
Setup.create_tables!
require 'active_record'

options = {
    adapter: 'postgresql',
    database: 'hurr.io'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)

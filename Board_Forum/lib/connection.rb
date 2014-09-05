require 'active_record'

  ActiveRecord::Base.establish_connection({
    :adapter => "postgresql",
    :host => "localhost",
    :username => "lisa",
    :database => "board_forum"
  })

  ActiveRecord::Base.logger = Logger.new(STDOUT)

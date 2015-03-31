require "active_record"
require "pry"
#require_relative  #add later



ActiveRecord::Base.establish_connection(
	:adapter => "postgresql",
	:host => "localhost",
	:database => "personal_finance_db"
	)

def clean_slate
	ActiveRecord::Base.connection.tables.each do |table|
		ActiveRecord::Base.connection.drop_table(table)
	end
end

binding.pry
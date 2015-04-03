require 'active_record'
require 'pry'

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

def clear_screen
	print `clear`
end

def blank_line
	puts
end

class CreatePersonalFinance < ActiveRecord::Migration
	
	def initialize
		create_table :accounts do |column|
			column.string :name
			column.string :bank
			column.integer :account_number
			column.float :balance
		end

		create_table :transactions do |column|
			column.belongs_to :account
			column.float :credit
			column.float :debit
			column.string :payee
			column.string :date
			column.string :category
		end
	end
end

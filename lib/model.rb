#require "active_record"

class Account < ActiveRecord::Base
	has_many :transactions
	validates :name, :bank, :account_number, :balance, :presence => true
end

class Transaction < ActiveRecord::Base
	belongs_to :account
	validates  :payee,  :date, :category, :presence => true
	#validates :debit, :credit,  #Not sure what to validate?
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
			column.float :debit
			column.float :credit
			column.string :payee
			column.string :date
			column.string :category
		end
	end
end

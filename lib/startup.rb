require 'active_record'
require_relative 'account'
require_relative 'transaction'

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

clean_slate

CreatePersonalFinance.new

Account.create(name: "Preston Checking", bank: "WF", account_number: 543832, balance: 54390.09)
Account.create(name: "Preston Savings", bank: "WF", account_number: 7482935, balance: 45060.54)
Account.create(name: "Echo Checking", bank: "Citi Bank", account_number: 9764354, balance: 55456.24)
Account.create(name: "Echo Savings", bank: "Citi Bank", account_number: 7352643, balance: 40930.49)
Account.create(name: "China Checking", bank: "Bank of China", account_number: 6473839, balance: 16043.43)
Account.create(name: "China Savings", bank: "Bank of China", account_number: 3285640, balance: 12053.13)


Transaction.create(account_id: 1, credit: nil, debit: 42.14, payee: "Amazon", date: "02/18/15", category: "personal care")
Transaction.create(account_id: 1, credit: nil, debit: 15.03, payee: "Five Guys", date: "03/05/15", category: "food")
Transaction.create(account_id: 1, credit: nil, debit: 642.00, payee: "Visa", date: "03/09/15", category: "debts")
Transaction.create(account_id: 1, credit: nil, debit: 92.54, payee: "RCN", date: "03/13/15", category: "utilities")
Transaction.create(account_id: 1, credit: 1000.00, debit: nil, payee: "NASA", date: "03/16/15", category: "income")
Transaction.create(account_id: 1, credit: nil, debit: 102.23, payee: "Giant Foods", date: "03/19/15", category: "food")
Transaction.create(account_id: 1, credit: nil, debit: 1893.03, payee: "Apple Computers", date: "03/21/15", category: "personal care")
Transaction.create(account_id: 1, credit: 1500.00, debit: nil, payee: "NASA", date: "03/31/15", category: "income")
Transaction.create(account_id: 1, credit: nil, debit: 50.00, payee: "WMATA", date: "04/01/15", category: "transportation")




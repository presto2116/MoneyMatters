
class Account < ActiveRecord::Base
	has_many :transactions
	validates :name, :bank, :account_number, :balance, :presence => true

	def self.create_account
		puts("What's the name of the new account?")
			name = gets.chomp
		puts("What's the bank's name?")
			bank = gets.chomp
		puts("What's the account number?")
			account_number = gets.chomp.to_i
		puts("What's the current balance in this account?")
			balance = gets.chomp.to_f.round(2)
		Account.create(name: name, bank: bank, account_number: account_number, balance: balance) 
	end

	def self.access_old_accounts
		tp Account.all
		puts
		puts("Please enter the ID of the account you want to access?")
			account_id = gets.chomp.to_i
			current_account = Account.find(account_id)
			@current_account = current_account		
	end

	def self.list_account
		puts `clear`
		tp @current_account
		puts
	end

	def self.list_transactions
		puts `clear`
		tp @current_account.transactions.all
		puts
	end

	def self.edit_transaction
		puts `clear`
		tp @current_account.transactions.all
		puts
		puts("Please enter the ID of the transaction you would like to edit")
			edit_id = gets.chomp.to_i
		edit_transaction = Transaction.find(edit_id)
		puts("Which value would you like to change?")
		puts("Choices: debit, credit, payee, date, category")
			field_edit = gets.chomp.downcase
		puts("Please enter correct information")
			correct_info = gets.chomp
		case field_edit
			when "debit"
				Transaction.update(edit_id, debit: correct_info)
			when "credit"
				Transaction.update(edit_id, credit: correct_info)
			when "payee"
				Transaction.update(edit_id, payee: correct_info)
			when "date"
				Transaction.update(edit_id, date: correct_info)
			when "category"
				Transaction.update(edit_id, category: correct_info)
			else
				puts("Please enter a correct choice")
		end
	end

	def self.add_transaction
		puts("What's the amount of this transaction?")
		amount = gets.chomp.to_f.round(2)
		puts("Was '#{amount}' a 'credit'(+ $$$) or 'debit'(- $$$)")
		credit_debit = gets.chomp.downcase
			if credit_debit == "credit"
				credit = amount
				debit = nil
			elsif credit_debit == "debit"
				debit = amount
				credit = nil
			else
				puts("Please put 'credit' or 'debit'")
			end
		puts("Who was the payee of this transaction?")
			payee = gets.chomp
		puts("what's the date of this transaction (MM/dd/yy)")
			date = gets.chomp
		puts("Which category is this transaction")
		puts("Choices: income, rent, transportation, personal care, debts, utilities, food, recreation")
		category = gets.chomp.downcase
		@current_account.transactions.create(credit: credit, debit: debit, payee: payee, date: date, category: category)
		puts("This transaction has been added to your account.")
		puts
	end

	def self.delete_transaction
		puts `clear`
		tp @current_account.transactions.all
		puts
		puts("Please select the ID of which transation you want to delete.")
		delete_id = gets.chomp.to_i
		Transaction.destroy(delete_id)
	end

	def self.category_list
		puts `clear`
		puts("Which category will you like to view?")
		puts("Choices: income, rent, transportation, personal care, debts, utilities, food, recreation")
		category_choice = gets.chomp.downcase
		case category_choice
			when "income"
				tp Transaction.where(category: "income")
			when "rent"
				tp Transaction.where(category: "rent")
			when "transportation"
				tp Transaction.where(category: "transportation")
			when "personal care"
				tp Transaction.where(category: "personal care")
			when "debts"
				tp Transaction.where(category: "debts")
			when "utilities"
				tp Transaction.where(category: "utilities")
			when "food"
				tp Transaction.where(category: "food")
			when "recreation"
				tp Transaction.where(category: "recreation")
			else
				puts("please enter a valid choice")
		end
	end
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

def main_menu
	puts `clear`
	loop do
		puts("Lean To Save With Us at MoneyMatters")
		puts("---------------Main Menu------------------")
		puts("Enter 1- See Account Info and Balacnce")
		puts("Enter 2- List all Transactions")
		puts("Enter 3- Add a Transaction")
		puts("Enter 4- Edit a Transaction")
		puts("Enter 5- Delete a Transaction")
		puts("Enter 6- See A Perticular Category of Transactions")
		puts("Enter 7- Exit")
		loop do
			user_entry = gets.chomp.to_i
			
			case user_entry
				when 1 #See accounts
					Account.list_account
					break
				when 2 #List transactions
					Account.list_transactions
					break
				when 3 #add transaction
					Account.add_transaction
					break
				when 4 #edit transaction
					Account.edit_transaction
					break
				when 5 #delete transaction
					Account.delete_transaction
					break
				when 6 #see categories
					Account.category_list
					break
				when 7 #Quit
					puts("Please come back again")
					exit
				else
					puts("Please enter a correct number")
			end
		end
	end
end

#Account setup menu
puts("Lets set up a new account or access an old one")
puts("---------------Account Menu-------------------")
puts("Enter 1- Create a new account")
puts("Enter 2- Access previously created account")
puts("Enter 3- Exit")
while true
	account_entry = gets.chomp.to_i

	case account_entry
		when 1
			Account.create_account
			main_menu
			break
		when 2
			Account.access_old_accounts
			main_menu
			break
		when 3
			puts("Come back again")
			exit
		else
			puts("Please enter a correct number")
	end
end





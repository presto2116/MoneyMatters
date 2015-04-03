require 'active_record'
require 'table_print'
require 'pry'



class Account < ActiveRecord::Base
	has_many :transactions
	validates :name, :bank, :account_number, :balance, :presence => true
	validates :account_number, :numericality => true
	validates :account_number, :length => {:is => 7}
	#validates :balance, :numericality => true
	
	def self.create_account #create new account, then enter main menu
		puts("What's the name of the new account?")
			name = gets.chomp
		puts("What's the bank's name?")
			bank = gets.chomp
		puts("What's the 7 digit account number?")
			account_number = gets.chomp.to_i
		puts("What's the current balance in this account?")
			balance = gets.chomp.to_f.round(2)
		create_account = Account.new(name: name, bank: bank, account_number: account_number, balance: balance) 
		if create_acount.valid?
			create_account.save
		else
			create_account.errors.each do |key, val|
				puts "#{key} #{val}"
				end
			sleep 1
			Account.create_account	
		end
		current_account = Account.last
		@current_account = current_account
	end

	def self.access_old_accounts #choose previously created account, then enter main menu
		tp Account.all.order(:id)
		blank_line
		puts("Please enter the ID of the account you want to access?")
			account_id = gets.chomp.to_i
			current_account = Account.find(account_id)
			@current_account = current_account	
	end

	def self.list_account # balance prompt above every main menu
		clear_screen
			tp @current_account 
		blank_line
	end

	def self.list_transactions #list transactions by date
		clear_screen
			tp @current_account.transactions.all.order(:date)
		blank_line
		puts
		puts("Press 'ENTER' to return to main menu")
		entry = gets.chomp
			if entry == ""
				main_menu
			end  
	end

	def self.add_transaction #add new transaction to current account
		clear_screen
		puts("What's the amount of this transaction?")
		print("$") 
		amount = gets.chomp.to_f.round(2)
		puts("Was '$#{amount}' a 'credit'(+ $$$) or 'debit'(- $$$)")
		entry = gets.chomp.downcase
			if entry == "credit"
				credit = amount
				debit = nil
			elsif entry == "debit"
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
		puts(" Categories: income, rent, transportation, personal care, debts, utilities, food")
		category = gets.chomp.downcase
		new_transaction = @current_account.transactions.new(credit: credit, debit: debit, payee: payee, date: date, category: category)
		if new_transaction.valid?
			new_transaction.save
		else
			new_transaction.errors.each do |key, val|
				puts "#{key} #{val}"
				sleep 1
				Account.add_transaction
			end
		end
		Account.updating_add_balance
		clear_screen
		puts("This transaction has been added to your account.")
		sleep 1
	end

	def self.updating_add_balance #when adding transaction, updates the current account balance
		if Transaction.last.debit == nil
				update_balance = @current_account.balance + Transaction.last.credit 
			 	@current_account.update(balance: update_balance)
			elsif Transaction.last.credit == nil
				update_balance = @current_account.balance - Transaction.last.debit 
				@current_account.update(balance: update_balance.round(2))
			else
		end
	end

	def self.edit_transaction #edits a previous transaction
			clear_screen
			tp @current_account.transactions.all
			puts
			puts("Please enter the ID of the transaction you would like to edit")
				edit_id = gets.chomp.to_i
			edit_transaction = Transaction.find(edit_id)
			@edit_transaction = edit_transaction
			clear_screen
			tp Transaction.find(edit_id)
			puts("Which value would you like to change?")
			puts("	Choices: debit, credit, payee, date, category")
				field_edit = gets.chomp.downcase
			puts("Please enter correct information")
				correct_info = gets.chomp
			case field_edit
				when "debit"
					@correct_info = correct_info.to_f
					Account.update_edit_debit_balance
					Transaction.update(edit_id, debit: correct_info)
				when "credit"
					@correct_info = correct_info.to_f
					Account.update_edit_credit_balance
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
			clear_screen 
			tp Transaction.find(edit_id)
			puts
			puts("Transaction has been updated")
			sleep 1
	end

	def self.update_edit_credit_balance #when editing the credit amount of a transaction, updates the current account balance
		update_balance = @current_account.balance - @edit_transaction.credit + @correct_info
		@current_account.update(balance: update_balance.round(2))
	end

	def self.update_edit_debit_balance #when editing the debit amount of a transaction, updates the current account balance
		update_balance = @current_account.balance + @edit_transaction.debit - @correct_info
		@current_account.update(balance: update_balance.round(2))
	end
	
	def self.delete_transaction #deletes a previous transaction
		clear_screen
		tp @current_account.transactions.all
		puts
		puts("Please select the ID of which transation you want to delete.")
		delete_id = gets.chomp.to_i
		bye_transaction = Transaction.find(delete_id)
		@bye_transaction = bye_transaction
		puts `clear`
		tp @bye_transaction
		puts
		puts("Are you sure you want to delete this transaction? (yes/no)")
		delete = gets.chomp.downcase
			if delete == "yes"
				clear_screen
				puts("This transaction has been deleted")
				Account.update_delete_balance
				Transaction.destroy(delete_id)
				sleep 1
			else
				puts("Transaction was not deleted")
				sleep 1
			end
	end

def self.update_delete_balance #when deleting a transaction, updates the current account balance
		if @bye_transaction.debit == nil
			update_balance = @current_account.balance - @bye_transaction.credit 
		 	@current_account.update(balance: update_balance.round(2))
		elsif @bye_transaction.credit == nil
			update_balance = @current_account.balance + @bye_transaction.debit 
			@current_account.update(balance: update_balance.round(2))
		else
		end
	end

	def self.category_list #lists transactions by category
		loop do
			clear_screen
			puts("Which category will you like to view?")
			puts(" Categories: income, rent, transportation, personal care, debts, utilities, food")
			puts("or press 'enter' to return to main menu")
			category_choice = gets.chomp.downcase
			if category_choice == ""
				break
			else
			clear_screen
			tp @current_account.transactions.where(category: category_choice)
			puts("Sum of category '#{category_choice}'' is: Credit: $#{Transaction.where(category: category_choice).sum('credit')}, Debit: -$#{Transaction.where(category: category_choice).sum('debit')}")
			puts
			end
		end
	end
end
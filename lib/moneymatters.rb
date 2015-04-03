require 'pry'
require 'table_print'
require_relative 'db'
require_relative 'account'
require_relative 'transaction'


def main_menu
	clear_screen
	loop do
		Account.list_account
		puts("======Learn To Save With Us at MoneyMatters=======")
		puts("-------------------Main Menu----------------------")
		puts("Enter 1- List all Transactions")
		puts("Enter 2- Add a Transaction")
		puts("Enter 3- Edit a Transaction")
		puts("Enter 4- Delete a Transaction")
		puts("Enter 5- See a Particular Category of Transactions")
		puts("Enter 6- Exit")
		puts("==================================================")
		loop do
			user_entry = gets.chomp.to_i
			
			case user_entry
				when 1 #List transactions
					Account.list_transactions
					break
				when 2 #add new transaction
					Account.add_transaction
					break
				when 3 #edit previous transaction
					Account.edit_transaction
					break
				when 4 #delete previous transaction
					Account.delete_transaction
					break
				when 5 #see all transactions in a category
					Account.category_list
					break
				when 6 #Quit
					clear_screen
					puts("Hope you enjoyed MoneyMatters")
					puts("Please come back again soon")
					exit
				else
					puts("Please enter a correct number")
			end
		end
	end
end

#Account setup menu
clear_screen
puts("Lets set up a new account or access an old one")
puts("---------------Account Menu-------------------")
puts("Enter 1- Create a new account")
puts("Enter 2- Access previously created account")
puts("Enter 3- Exit")
while true
	account_entry = gets.chomp.to_i

	case account_entry
		when 1 #create a new account 
			clear_screen
			Account.create_account
			main_menu
			break
		when 2 #enter main menu of a previously created account
			clear_screen
			Account.access_old_accounts
			main_menu
			break
		when 3
			clear_screen
			puts("Hope you enjoyed MoneyMatters")
			puts("Please come back again soon")
			exit
		else
			puts("Please enter a correct number")
	end
end
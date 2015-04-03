#Welcome to MoneyMatters

##A personal finance managing application that helps keep track of your finances

##Setup Instructions
1. Enter psql from the command line and create a new data base named 'moneymatters_db'
	1. type `psql` in your terminal
	2. Once in psql, type `CREATE DATABASE moneymatters_db`
	3. If successfully created, type '\q' to exit psql
2. Find the MoneyMatters directory and enter the 'lib' directory
3. Type `ruby setup.rb` ***ONLY ONCE***
4. If it prints: 
```ruby 
	-- create_table(:accounts)
	  -> 0.0158s
	-- create_table(:transactions)
	  -> 0.0263s
```

- you are ready to start using the app

##Instructions for the application
<<<<<<< HEAD
1. STARTUP: From the 'lib' directory, type 'ruby moneymatters.rb' 
	*This will place you within the application
2. ACCOUNT MENU: In the application, you are prompted with two options.
	1. Create a new account
		*Choose this option if you have not previously added your account
	2. Access previously created account
		*Choose this option if you already added your account
=======
1. STARTUP: From the 'lib' directory, type `ruby moneymatters.rb` 
  * This will place you within the application
2. ACCOUNT MENU: In the application, you are prompted with two options.
  * Create a new account
    - Choose this option if you have not previously added your account
  * Access previously created account
    - Choose this option if you already added your account
>>>>>>> b1009907e0014c7d697d40590ad8cef9cc236af2
3. MAIN MENU: Both options, once completed, will send you into the main menu
  * MAIN MENU OPTIONS
	1. List All Transactions
	2. Add a Transaction
	3. Edit a Transaction
	4. Delete a Transaction
	5. View Transactions by Category
	6. Exit

### Enjoy the application and please leave feedback in the issues tab 

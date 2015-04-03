#Welcome to MoneyMatters

##A personal finance managing application that helps keep track of your finances

##Setup Instructions
1. Enter psql from the command line and create a new data base named 'moneymatters_db'
	- type psql in your terminal
	- Once in psql type 'CREATE DATABASE moneymatters_db'
	- If successfully created, type '\q' to exit psql
2. Find the MoneyMatters directory and enter the 'lib' directory
3. Type 'ruby setup.rb' ***ONLY ONCE***
4. Now everything is set up to start using the app

##Instructions for the application
1. STARTUP: From the 'lib' directory, type 'ruby moneymatters.rb' 
  * This will place you within the application
2. ACCOUNT MENU: In the application, you are prompted with two options.
  * Create a new account
    - Choose this option if you have not previously added your account
  * Access previously created account
    - Choose this option if you already added your account
3. MAIN MENU: Both options, once completed, will send you into the main menu
  * MAIN MENU OPTIONS
	- List All Transactions
	- Add a Transaction
	- Edit a Transaction
	- Delete a Transaction
	- View Transactions by Category
	- Exit
## Enjoy the application and please leave feedback in my github issues page. 

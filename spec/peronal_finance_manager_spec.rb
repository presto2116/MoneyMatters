require 'pry'
require_relative "../lib/db"
require_relative "../lib/account"
require_relative "../lib/transaction"

describe Account do
	let(:preston) {Account.create(name: "PrestonCheck", bank: "WF", account_number: 6824132, balance: 10000.00)}
		it "can be instantiated" do
			preston = Account.create(name: "PrestonCheck", bank: "WF", account_number: 6824132, balance: 10000.00)
			expect(preston.class).to be(Account)
		end

		it "has a name" do
			expect(preston.name).to eq("PrestonCheck")
		end

		it "has a bank" do
			expect(preston.bank).to eq("WF")
		end

		it "has an account number" do
			expect(preston.account_number).to eq(6824132)
		end

		it "has a unique account number"

		it " has a account number which is integer with 7 digits" do
			expect(preston.account_number.to_s.length).to eq(7)		
		end


		it "has a starting balance" do
			expect(preston.balance).to eq(10000.00)
		end

		it "has many transations"

		context "when transations have been added to account"

			it "has a new updated balance"



end

describe Transaction do
let(:monkey) {Transaction.create(account_id: 1, credit: nil, debit: 42.14, payee: "Amazon", date: "02/18/15", category: "personal care")}
	it "has one credit or debit (not both)" #will be a tricky test

	it "has a payee" do
		expect(monkey.payee).to eq("Amazon")
	end
	
	it "has a date"  do 
		expect(monkey.date).to eq("02/18/15")
	end
		
	it "has a date in format MM/dd/yy"

	it "has a category" do
		expect(monkey.category).to eq("personal care")
	end

	it "belongs to one Account" do
		expect(monkey.account_id).to eq(1)
	end


end






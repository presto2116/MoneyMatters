require_relative "../lib/controller.rb"

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

		it " has a account number which is integer with 7 digits"

		it "has a starting balance" do
			expect(preston.starting_balance).to eq(10000.00)
		end

		it "has many transations"

		context "when transations have been added to account"

			it "has a new updated balance"



end

describe Transaction do

	it "has one credit or debit (not both)" #will be a tricky test

	it "has a payee"

	it "has a date"

	it "has a date in format MM/dd"

	it "has a category"

	it "belongs to one Account"

	it ""
end






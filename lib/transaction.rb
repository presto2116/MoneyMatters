

class Transaction < ActiveRecord::Base
	attr_reader :credit_formatted
	belongs_to :account
	validates  :payee,  :date, :category, :presence => true
	validates :debit, :numericality => true, allow_nil: true
	validates :credit, :numericality => true , allow_nil: true
	#validates :debit, :credit,  #Not sure what to validate?
end


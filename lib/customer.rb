
class Customer

	attr_accessor :name, :available_balance, :minimum_balance

	def initialize(name, available_balance, minimum_balance)
		@name = name
		@available_balance = available_balance
		@minimum_balance = minimum_balance
	end
end
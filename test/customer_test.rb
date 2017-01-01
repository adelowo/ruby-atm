require "./lib/customer"
require "minitest/autorun"

class CustomerTest < MiniTest::Test

	def setup
		@lanre = Customer.new("Lanre Adelowo", 150_000, 0)
	end

	def test_cash_withdrawal
		@lanre.withdraw!(10_000)

		assert_equal 140_000, @lanre.available_balance
	end

	def test_user_can_withdraw
		assert_true(@lanre.can_withdraw? 140_000)
	end

	def test_cannot_withdraw_due_to_bank_policy
		@lanre.minimum_balance = 10_000
		assert_true(@lanre.can_withdraw?(140_0001).class == FalseClass)
	end

	def test_name
		assert_equal "Lanre Adelowo", @lanre.name
	end

	def test_available_balance
		assert_equal 150_000, @lanre.available_balance
	end

	def test_minimum_balance
		assert_equal 0, @lanre.minimum_balance
	end	

	def assert_true(expression)
		assert(true == expression)
	end
end


class Atm

	FilePath = 'db.txt'

	Separator = ";" #separator for the data in the database file

	##Here are the command the ATM understands 
	Balance = 0
	Withdraw = 1
	Logout = 2
	
	def initialize
		@customer = nil
		@all_customers = []
		@last_fours = []
		get_all_customer_details
	end

	def start

		# Simulate the debit card insertion
		last_4_digits = prompt "ENTER the last 4 digits of your card ?"

		raise AtmRunTimeError, "The digits must be 4 characters long" unless last_4_digits.length.eql? 4

		current_customer = get_customer_details_by_last_four_digits last_4_digits.to_i

		#Increment anytime an InvalidPasswordError is rescued. 3 is max then we die.
		login_error_count = 0 

		begin

			is_password_valid(current_customer, prompt("Please provide your password ?"))

			puts "", "Authenticating you via our secure server" #deal with it
						
			login_error_count = 0
			@all_customers.drop @all_customers.size

			hydrate_data(current_customer)

			puts "You have been authenticated", ""

		rescue InvalidPasswordError => e

			raise LoginThrottleError, e.message + '. Atm would exit now' if login_error_count >= 3

			login_error_count += 1

			##Holy Cow ?... Who does that ? Auto-allow you recall code that caused an exception.		
			##Man. Ruby is deep!!!
			retry
		end

		bootstrap_atm_commands
	end

	protected

	def get_all_customer_details
		File.open(FilePath, "r").each do |line|
			next unless line.match(/\w+/)
			@all_customers.push(line.strip) 
		end
	end

	def bootstrap_atm_commands
		print_instructions 
		process_command(prompt("How may we help you today ? Please Enter a command"))		
	end	

	def hydrate_data(customer)
		@customer = Customer.new(customer[2].strip, customer[4].strip.to_f, customer[5].strip.to_f)
	end

	def print_instructions
		puts "Hello, #{@customer.name}", ""

		commands = 	[
			[Balance,"check your balance"], [Withdraw, "withdraw some cash"], [Logout, "logout"]
		]

		commands.each {|key, value| puts "Press #{key} to #{value}."}

		puts ""
	end	

	def process_command(command)
		case command.to_i
		when Balance
			puts "Available Balance -> #{@customer.available_balance}", ""

		when Withdraw
			puts ""

			amount_to_withdraw = prompt("How much would you like to withdraw ?").to_f

			if @customer.can_withdraw?(amount_to_withdraw)
				puts "Authenticating your withdrawal"
				@customer.withdraw!(amount_to_withdraw)
				puts "Done"
			else
				puts "Insufficient funds!",""
			end	

		when Logout
			puts "Unauthenticating you via our secure sever", "You have been successfully logged out"

			exit

		else
			puts "", "Unknown Command", ""
		end

		bootstrap_atm_commands
	end	

	def get_customer_details_by_last_four_digits(number)
		found = []
		
		@all_customers.each do |customer|
			next unless customer.slice(0,4).to_i.eql? number
			found = customer.split Separator
		end

		raise UnknownCardError, "Invalid debit card" if found.empty?

		found
	end

	def is_password_valid(customer, password)
		raise InvalidPasswordError, "Please input the right password" unless customer[3].strip.eql? password
	end

	def prompt(question)
		puts question
		gets.strip
	end
end

AtmRunTimeError = Class.new(RuntimeError)

BalanceOverflowError = Class.new(ArgumentError)

class FraudError < AtmRunTimeError
end

class UnknownCardError < FraudError
end

class InvalidPasswordError < FraudError
end

LoginThrottleError = Class.new(RuntimeError)

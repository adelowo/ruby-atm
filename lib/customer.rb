class Customer

  attr_accessor :name, :available_balance, :minimum_balance

  def initialize(name, available_balance, minimum_balance)
    @name = name
    @available_balance = available_balance
    @minimum_balance = minimum_balance
  end

  def withdraw!(amount)
    @available_balance -= amount
  end

  def can_withdraw?(amount)
    #some banks have a minimum balance policy. Let's put that in perspective too.
    cannot_withdraw = (@available_balance - amount) > @minimum_balance
    cannot_withdraw ||= amount < @available_balance
  end
end

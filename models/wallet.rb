# models/wallet.rb

class Wallet
  attr_accessor :balance, :owner

  def initialize(owner)
    @balance = 0
    @owner = owner
  end

  # Adds funds to the wallet
  def credit(amount)
    raise "Amount must be positive" if amount <= 0
    @balance += amount
  end

  # Deducts funds from the wallet
  def debit(amount)
    raise "Amount must be positive" if amount <= 0
    raise "Insufficient funds" if amount > @balance
    @balance -= amount
  end

  # Returns the current balance
  def get_balance
    @balance
  end
end

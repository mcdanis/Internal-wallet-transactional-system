class Wallet
  attr_accessor :balance, :owner, :transactions

  def initialize(owner)
    @owner = owner
    @balance = 0.0
    @transactions = []
  end

  def credit(amount)
    raise 'Amount must be positive' if amount <= 0
    @balance += amount
  end

  def debit(amount)
    raise 'Amount must be positive' if amount <= 0
    raise 'Insufficient balance' if amount > @balance
    @balance -= amount
  end

  def add_transaction(transaction)
    @transactions << transaction
  end
end

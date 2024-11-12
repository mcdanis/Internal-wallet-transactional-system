# models/transaction.rb

class Transaction
  attr_accessor :source_wallet, :target_wallet, :amount, :timestamp

  def initialize(source_wallet:, target_wallet:, amount:)
    @source_wallet = source_wallet
    @target_wallet = target_wallet
    @amount = amount
    @timestamp = Time.now
  end

  # Executes the transaction between two wallets
  def execute
    raise "Amount must be positive" if @amount <= 0
    source_wallet.debit(@amount) unless source_wallet.nil?
    target_wallet.credit(@amount) unless target_wallet.nil?
  end
end

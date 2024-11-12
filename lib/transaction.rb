class Transaction
  attr_accessor :amount, :source_wallet, :target_wallet, :timestamp

  def initialize(amount:, source_wallet: nil, target_wallet: nil)
    @amount = amount
    @source_wallet = source_wallet
    @target_wallet = target_wallet
    @timestamp = Time.now
  end

  def process
    if source_wallet.nil?
      target_wallet.credit(amount)
      target_wallet.add_transaction(self)
    elsif target_wallet.nil?
      source_wallet.debit(amount)
      source_wallet.add_transaction(self)
    else
      source_wallet.debit(amount)
      target_wallet.credit(amount)
      source_wallet.add_transaction(self)
      target_wallet.add_transaction(self)
    end
  end
end

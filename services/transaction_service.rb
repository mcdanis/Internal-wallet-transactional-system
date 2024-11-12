

class TransactionService
  def initialize(source:, target:, amount:)
    @source = source
    @target = target
    @amount = amount
  end

  
  def execute
    validate_transaction
    record_transaction
    perform_transaction
  end

  private

  
  def validate_transaction
    raise "Amount must be greater than zero" if @amount <= 0
    raise "Source wallet is required" if @source.nil? || @source.wallet.nil?
    raise "Target wallet is required" if @target.nil? || @target.wallet.nil?

    if @source.wallet.get_balance < @amount
      raise "Insufficient balance in source wallet"
    end
  end

  
  def perform_transaction
    
    @source.wallet.debit(@amount)

    
    @target.wallet.credit(@amount)
  end

  
  def record_transaction
    
    
    puts "Transaction completed: 
  end
end

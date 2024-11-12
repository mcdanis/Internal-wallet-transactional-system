require 'minitest/autorun'
require_relative '../models/user'
require_relative '../models/team'
require_relative '../models/stock'
require_relative '../services/transaction_service'

class TransactionTest < Minitest::Test
  def setup
    
    @user = User.new("Dani")
    @team = Team.new("Development")
    @stock = Stock.new("AAPL")

    
    @user.wallet.credit(1000)
    @team.wallet.credit(500)
    @stock.wallet.credit(2000)

    
    @transaction_service = TransactionService.new
  end

  def test_successful_credit_transaction
    
    result = @transaction_service.process_credit(@user, 500)
    assert_equal 1500, @user.wallet.get_balance  
    assert_equal "Transaction successful", result  
  end

  def test_successful_debit_transaction
    
    result = @transaction_service.process_debit(@team, 200)
    assert_equal 300, @team.wallet.get_balance  
    assert_equal "Transaction successful", result  
  end

  def test_debit_transaction_with_insufficient_balance
    
    assert_raises(RuntimeError, "Insufficient balance in wallet") do
      @transaction_service.process_debit(@user, 1500)  
    end
  end

  def test_invalid_transaction_amount
    
    assert_raises(RuntimeError, "Amount must be greater than zero") do
      @transaction_service.process_debit(@team, 0)  
    end
  end

  def test_credit_to_invalid_wallet
    
    assert_raises(RuntimeError, "Invalid wallet") do
      @transaction_service.process_credit(nil, 100)
    end
  end

  def test_debit_to_invalid_wallet
    
    assert_raises(RuntimeError, "Invalid wallet") do
      @transaction_service.process_debit(nil, 100)
    end
  end

  def test_credit_and_debit_transactions_in_one
    
    @transaction_service.process_credit(@user, 500)
    @transaction_service.process_debit(@team, 200)

    
    assert_equal 1500, @user.wallet.get_balance  
    assert_equal 300, @team.wallet.get_balance  
  end

  def teardown
    
  end
end

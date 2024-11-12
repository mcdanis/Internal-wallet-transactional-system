require 'minitest/autorun'
require_relative '../models/user'
require_relative '../models/team'
require_relative '../models/stock'

class WalletTest < Minitest::Test
  def setup
    
    @user = User.new("Dani")
    @team = Team.new("Development")
    @stock = Stock.new("AAPL")

    
    @user.wallet.credit(1000)
    @team.wallet.credit(500)
    @stock.wallet.credit(2000)
  end

  def test_user_wallet_balance
    
    assert_equal 1000, @user.wallet.get_balance
  end

  def test_team_wallet_balance
    
    assert_equal 500, @team.wallet.get_balance
  end

  def test_stock_wallet_balance
    
    assert_equal 2000, @stock.wallet.get_balance
  end

  def test_credit_transaction
    
    @user.wallet.credit(500)
    assert_equal 1500, @user.wallet.get_balance  
  end

  def test_debit_transaction
    
    @team.wallet.debit(200)
    assert_equal 300, @team.wallet.get_balance  
  end

  def test_debit_transaction_with_insufficient_balance
    
    assert_raises(RuntimeError, "Insufficient balance in wallet") do
      @user.wallet.debit(1500)  
    end
  end

  def test_invalid_transaction_amount
    
    assert_raises(RuntimeError, "Amount must be greater than zero") do
      @team.wallet.debit(0)  
    end
  end
end

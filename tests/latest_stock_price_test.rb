require 'minitest/autorun'
require 'webmock/minitest'
require_relative '../../services/latest_stock_price'

class LatestStockPriceTest < Minitest::Test
  def setup
    
    WebMock.enable!
  end

  def test_get_latest_price_success
    
    stub_request(:get, "https://api.example.com/price?symbol=AAPL")
      .to_return(body: '{"price": 150.00}', status: 200)

    
    stock_price = LatestStockPrice.get_latest_price('AAPL')

    assert_equal 150.00, stock_price  
  end

  def test_invalid_stock_symbol
    
    stub_request(:get, "https://api.example.com/price?symbol=INVALID")
      .to_return(body: '{"error": "Invalid symbol"}', status: 400)

    
    assert_raises(RuntimeError, "Invalid stock symbol") do
      LatestStockPrice.get_latest_price('INVALID')
    end
  end

  def test_api_error_handling
    
    stub_request(:get, "https://api.example.com/price?symbol=AAPL")
      .to_return(status: 500)

    
    assert_raises(RuntimeError, "Failed to retrieve stock price") do
      LatestStockPrice.get_latest_price('AAPL')
    end
  end

  def teardown
    WebMock.disable!
  end
end

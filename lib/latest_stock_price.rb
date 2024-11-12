

require 'net/http'
require 'json'

class LatestStockPrice
  BASE_URL = 'https://latest-stock-price.p.rapidapi.com' 
  API_KEY = 'YOUR_RAPIDAPI_KEY' 

  def initialize
    @headers = {
      "X-RapidAPI-Key" => API_KEY,
      "X-RapidAPI-Host" => "latest-stock-price.p.rapidapi.com"
    }
  end

  
  def price(symbol)
    url = URI("#{BASE_URL}/price?symbol=#{symbol}")
    response = make_request(url)
    response ? response[0]['lastPrice'] : nil
  end

  
  def prices(symbols)
    url = URI("#{BASE_URL}/prices?symbols=#{symbols.join(',')}")
    response = make_request(url)
    response.map { |stock| { symbol: stock['symbol'], last_price: stock['lastPrice'] } } if response
  end

  
  def price_all
    url = URI("#{BASE_URL}/price_all")
    response = make_request(url)
    response.map { |stock| { symbol: stock['symbol'], last_price: stock['lastPrice'] } } if response
  end

  private

  
  def make_request(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url, @headers)

    response = http.request(request)

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      puts "Error: #{response.message} (#{response.code})"
      nil
    end
  end
end

# models/stock.rb

class Stock
  attr_accessor :name, :wallet

  def initialize(name)
    @name = name
    @wallet = Wallet.new(self)
  end

  # Displays stock balance
  def display_balance
    puts "Stock #{@name} Balance: #{wallet.get_balance}"
  end
end

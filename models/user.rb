# models/user.rb

class User
  attr_accessor :username, :wallet

  def initialize(username)
    @username = username
    @wallet = Wallet.new(self)
  end

  # Displays user balance
  def display_balance
    puts "User #{@username} Balance: #{wallet.get_balance}"
  end
end


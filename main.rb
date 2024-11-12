require_relative './lib/wallet'
require_relative './lib/transaction'

user_wallet = Wallet.new("User1")
team_wallet = Wallet.new("Team1")

credit_transaction = Transaction.new(amount: 100.0, target_wallet: user_wallet)
credit_transaction.process

puts "User Wallet Balance: #{user_wallet.balance}"

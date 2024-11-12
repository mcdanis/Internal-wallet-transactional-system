# models/team.rb

class Team
  attr_accessor :name, :wallet

  def initialize(name)
    @name = name
    @wallet = Wallet.new(self)
  end

  # Displays team balance
  def display_balance
    puts "Team #{@name} Balance: #{wallet.get_balance}"
  end
end

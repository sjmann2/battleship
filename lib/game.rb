class Game
  attr_reader :cruiser_player,
              :cruiser_computer,
              :submarine_player,
              :submarine_computer
  def initialize
    @cruiser_player = Ship.new("Player's Cruiser", 3)
    @cruiser_computer = Ship.new("Computer's Cruiser", 3)
    @submarine_player = Ship.new("Player's Submarine", 2)
    @submarine_computer = Ship.new("Computer's Submarine", 3)
  end
end
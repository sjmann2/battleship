class Game
  attr_reader :cruiser_player,
              :cruiser_computer,
              :submarine_player,
              :submarine_computer,
              :board
  def initialize
    @cruiser_player = Ship.new("Player's Cruiser", 3)
    @cruiser_computer = Ship.new("Computer's Cruiser", 3)
    @submarine_player = Ship.new("Player's Submarine", 2)
    @submarine_computer = Ship.new("Computer's Submarine", 3)
    @board = Board.new
  end

  def place_ships_player(ship_instance, coordinate_array)
    if board.valid_placement?(ship_instance, coordinate_array)
    board.place(ship_instance, coordinate_array)
    else
      'Invalid coordinates try again'
    end
  end
end
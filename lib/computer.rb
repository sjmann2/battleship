class Computer
  attr_reader :board,
              :cruiser,
              :submarine
  def initialize
    @board = Board.new
    @cruiser = Ship.new("cruiser", 3)
    @submarine = Ship.new("submarine", 2)
    @ships_to_place = []
  end

  def place_ships(ship_instance, coordinate_array)
    if @board.valid_placement?(ship_instance, coordinate_array)
      @board.place(ship_instance, coordinate_array)
    else
      "Invalid coordinates try again"
    end
  end
 
  def random_computer_ship_placement(ship_instance)
    computer_ship_placement_array = []
    until board.valid_placement?(ship_instance, computer_ship_placement_array) == true
      (ship_instance.length).times do
        computer_ship_placement_array << board.cells.keys.sample
      end
      if board.valid_placement?(ship_instance, computer_ship_placement_array)
        computer_ship_placement_array
      else
        computer_ship_placement_array = []
      end
    end
    computer_ship_placement_array
  end

  # computer_ship_placement_array = random_computer_ship_placement(game.cruiser_computer, game, computer_ship_placement_array)
  # game.place_ships_computer(game.cruiser_computer, computer_ship_placement_array)
  # computer_ship_placement_array = []
  # computer_ship_placement_array = random_computer_ship_placement(game.submarine_computer, game, computer_ship_placement_array)
  # game.place_ships_computer(game.submarine_computer, computer_ship_placement_array)
end
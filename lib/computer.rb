class Computer
  attr_reader :board,
              :cruiser,
              :submarine,
              :previous_shots,
              :ships_to_place

  def initialize
    @board = Board.new
    @cruiser = Ship.new("cruiser", 3)
    @submarine = Ship.new("submarine", 2)
    @ships_to_place = []
    @previous_shots = []
  end

  def place_ships(ship_instance, coordinate_array)
    if board.valid_placement?(ship_instance, coordinate_array)
      board.place(ship_instance, coordinate_array)
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

  def place_all_ships
    @ships_to_place << @cruiser
    @ships_to_place << @submarine
    ships_placement = @ships_to_place.map do |ship|
      [ship, place_ships(ship, random_computer_ship_placement(ship))]
    end
  end

  def take_random_shot
    random_shot = board.cells.keys.sample
    until @previous_shots.include?(random_shot) == false
      random_shot = board.cells.keys.sample
    end
    @previous_shots << random_shot
    random_shot
  end
end

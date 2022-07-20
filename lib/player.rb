class Player
  attr_reader :board,
              :cruiser,
              :submarine

  def initialize
    @board = Board.new
    @cruiser = Ship.new("cruiser", 3)
    @submarine = Ship.new("submarine", 2)
  end

  def place_ships(ship_instance, coordinate_array)
    if @board.valid_placement?(ship_instance, coordinate_array)
      @board.place(ship_instance, coordinate_array)
    else
      "Invalid coordinates try again"
    end
  end
end

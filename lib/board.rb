class Board
  attr_reader :cells

  def initialize
    @cells = CellGenerator.new.cells
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship_instance, coordinate_array)
    if !coordinates_are_on_board(coordinate_array)
      return false
    end
    #coordinates are not on board, return false
    if !coordinate_array.all? { |coordinate| @cells[coordinate].empty? }
      return false
    end
    #if not all coordinates are empty, return false
    if ship_instance.length != coordinate_array.length
      return false
    end
    #check coordinates against length of ship
    is_horizontal = (consecutive_numbers_comparison(coordinate_array, ship_instance) && same_letters_comparison(coordinate_array, ship_instance))
    is_vertical = (same_numbers_comparison(coordinate_array, ship_instance) && consecutive_letters_comparison(coordinate_array, ship_instance))
    if !(is_horizontal || is_vertical)
      return false
    end
    true
  end

  def coordinates_are_on_board(coordinate_array)
    valid_coordinates_array = coordinate_array.reject do |individual_coordinate|
      !@cells.keys.include?(individual_coordinate)
      #reject coordinates if coordinate is not on the board, returns those that are
    end
    coordinate_array == valid_coordinates_array
    #returns true if inputted coordinate array is a valid coordinate array
  end

  def consecutive_numbers_comparison(coordinate_array, ship_instance)
    numbers_coordinate_array = coordinate_array.map do |individual_coordinate|
      individual_coordinate[1]
      #isolate the individual coordinate number
      #an array of just numbers
    end
    times_run = 0
    numbers_comparison_array = []
    until times_run == ship_instance.length
      #it runs until there are enough coordinates to place the ship
      numbers_comparison_array << (numbers_coordinate_array[0].to_i + times_run).to_s
      #takes the first element of coordinate number array, changes it to integer,
      #adds the amount of times run, changes it back to string
      times_run += 1
    end
    numbers_coordinate_array == numbers_comparison_array
    #returns true if inputted coordinate array is equal to the consecutive number coordinate array
  end

  def same_numbers_comparison(coordinate_array, ship_instance)
    numbers_coordinate_array = coordinate_array.map do |individual_coordinate|
      individual_coordinate[1]
      #isolate the individual coordinate number
    end
    numbers_same_array = []
    (ship_instance.length).times { numbers_same_array << numbers_coordinate_array[0] }
    #take length of ship and run it that many times to get x number of coordinates
    numbers_coordinate_array == numbers_same_array
    #returns true if inputted coordinate array is equal to the first element for entire array
  end

  def consecutive_letters_comparison(coordinate_array, ship_instance)
    letters_coordinate_array = coordinate_array.map do |individual_coordinate|
      individual_coordinate[0].ord
      #isolate the individual coordinate letter, convert to ordinal value
    end
    times_run = 0
    letters_comparison_array = []
    until times_run == ship_instance.length
      #it runs until there are enough coordinates to place the ship
      letters_comparison_array << (letters_coordinate_array[0] + times_run)
      #takes the first element of coordinate letter array, adds the amount of times run
      times_run += 1
    end
    letters_coordinate_array == letters_comparison_array
    #returns true if inputted coordinate is equal to an array of consecutive letters
  end

  def same_letters_comparison(coordinate_array, ship_instance)
    letters_coordinate_array = coordinate_array.map do |individual_coordinate|
      individual_coordinate[0].ord
      #isolate the individual coordinate letter, convert to ordinal value
    end
    letters_same_array = []
    (ship_instance.length).times { letters_same_array << letters_coordinate_array[0] }
    #take length of ship and run it that many times to get x number of coordinates
    letters_coordinate_array == letters_same_array
    #returns true if inputted coordinate array is equal to the first element for entire array
  end

  def place(ship_instance, coordinate_array)
    coordinate_array.each do |coordinate|
      @cells[coordinate].place_ship(ship_instance)
    end
  end

  def render(see_ships = false)
    "  1 2 3 4 \n" +
    "A #{@cells["A1"].render(see_ships)} #{@cells["A2"].render(see_ships)} #{@cells["A3"].render(see_ships)} #{@cells["A4"].render(see_ships)} \n" +
    "B #{@cells["B1"].render(see_ships)} #{@cells["B2"].render(see_ships)} #{@cells["B3"].render(see_ships)} #{@cells["B4"].render(see_ships)} \n" +
    "C #{@cells["C1"].render(see_ships)} #{@cells["C2"].render(see_ships)} #{@cells["C3"].render(see_ships)} #{@cells["C4"].render(see_ships)} \n" +
    "D #{@cells["D1"].render(see_ships)} #{@cells["D2"].render(see_ships)} #{@cells["D3"].render(see_ships)} #{@cells["D4"].render(see_ships)} \n"
  end
end

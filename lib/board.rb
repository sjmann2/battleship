class Board
  attr_reader :cells

  def initialize
    @cells = CellGenerator.new.cells
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship_instance, coordinate_array)
    if coordinates_are_on_board(coordinate_array)
      if !(coordinate_array.map do |coordinate|
        @cells[coordinate].empty?
      end.include?(false))

        #[T, T, T].include?(false) => false
        #if cells coordinate includes false returns true

        #iterate through array with valid coordinate method,
        # if all coordinates are all valid, then the array will remain intact and be equal to original
        #check coordinates against length of ship
        if ship_instance.length == coordinate_array.length
          #coordiantes are consecutive
          #numbers are consecutive
          if consecutive_numbers_comparison(coordinate_array, ship_instance) && same_letters_comparison(coordinate_array, ship_instance)
            true
          elsif same_numbers_comparison(coordinate_array, ship_instance) && consecutive_letters_comparison(coordinate_array, ship_instance)
            true
          else
            false
          end
        else
          false
        end
      else
        false
      end
    else
      false
    end
  end

  #or if the numbers are all the same

  #letters are consecutive

  #letters are all the same
  def coordinates_are_on_board(coordinate_array)
    valid_coordinates_array = coordinate_array.reject do |individual_coordinate|
      !@cells.keys.include?(individual_coordinate)
    end
    coordinate_array == valid_coordinates_array
  end

  def consecutive_numbers_comparison(coordinate_array, ship_instance)
    numbers_coordinate_array = coordinate_array.map do |individual_coordinate|
      individual_coordinate[1]
    end
    times_run = 0
    numbers_comparison_array = []
    until times_run == ship_instance.length
      numbers_comparison_array << (numbers_coordinate_array[0].to_i + times_run).to_s
      times_run += 1
    end
    numbers_coordinate_array == numbers_comparison_array
  end

  def same_numbers_comparison(coordinate_array, ship_instance)
    numbers_coordinate_array = coordinate_array.map do |individual_coordinate|
      individual_coordinate[1]
    end
    numbers_same_array = []
    (ship_instance.length).times { numbers_same_array << numbers_coordinate_array[0] }
    numbers_coordinate_array == numbers_same_array
  end

  def consecutive_letters_comparison(coordinate_array, ship_instance)
    letters_coordinate_array = coordinate_array.map do |individual_coordinate|
      individual_coordinate[0].ord
    end
    times_run = 0
    letters_comparison_array = []
    until times_run == ship_instance.length
      letters_comparison_array << (letters_coordinate_array[0].to_i + times_run)
      times_run += 1
    end
    letters_coordinate_array == letters_comparison_array
  end

  def same_letters_comparison(coordinate_array, ship_instance)
    letters_coordinate_array = coordinate_array.map do |individual_coordinate|
      individual_coordinate[0].ord
    end
    letters_same_array = []
    (ship_instance.length).times { letters_same_array << letters_coordinate_array[0] }
    letters_coordinate_array == letters_same_array
  end

  def place(ship_instance, coordinate_array)
    #coordinate array inputted corresponds to specific cell objects
    #link back to cell class
    #access values in hash
    #place the same ship in cell objects
    coordinate_array.each do |coordinate|
      @cells[coordinate].place_ship(ship_instance)
      #cell_1
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

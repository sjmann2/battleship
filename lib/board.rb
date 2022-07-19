class Board
  attr_reader :cells,
              :cell_generator

  def initialize
    @cell_generator = CellGenerator.new
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
    #if coordinates length is not same as length of ship, return false
    is_horizontal = (consecutive_numbers_comparison(coordinate_array, ship_instance) && same_letters_comparison(coordinate_array, ship_instance))                
    is_vertical = (same_numbers_comparison(coordinate_array, ship_instance) && consecutive_letters_comparison(coordinate_array, ship_instance))
    if !(is_horizontal || is_vertical)
      return false
    end
    #if coordinates are not horizontal or vertical, return false
    true
  end

  def coordinates_are_on_board(coordinate_array)
    valid_coordinates_array = coordinate_array.select do |individual_coordinate|
      @cells.keys.include?(individual_coordinate)
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
    column_labels = (1..@cell_generator.width).to_a
    #[1, 2, 3, 4]
    row_labels = ("A"..(("A".ord + @cell_generator.height - 1).chr)).to_a
    #["A", "B", "C", "D"]

    coordinates =
      column_labels.map { |num| row_labels.map { |letter| letter + num.to_s } }
        .flatten!
        .sort!
    #["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    cells_render = coordinates.map { |coordinate| @cells[coordinate].render(see_ships) }
    #[".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."]
    cells_render_slices = (cells_render.each_slice(@cell_generator.width).to_a)
    #[[".", ".", ".", "."], [".", ".", ".", "."], [".", ".", ".", "."], [".", ".", ".", "."]]
    row_label = "A".ord
    rows_render = cells_render_slices.map do |row|
      row_render = row.join(" ")
      #". . . ."
      row_render = "#{row_label.chr} #{row_render}"
      row_label += 1
      row_render
      #"A . . . ."
    end
    # ["A . . . .", "B . . . .", "C . . . .", "D . . . ."]
    board_render = rows_render.join(" \n")
    #"A . . . .\nB . . . .\nC . . . .\nD . . . ."
    return "#{column_labels.join(" ").insert(0, "  ")} \n" + board_render + " \n"
  end
end
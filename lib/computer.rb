class Computer
  attr_reader :board,
              :cruiser,
              :submarine,
              :previous_shots,
              :ships_to_place,
              :target_array,
              :first_hit,
              :ship_directionality,
              :is_second_ship_scenario

  attr_accessor :player_board,
                :first_hit

  def initialize
    @board = Board.new
    @cruiser = Ship.new("cruiser", 3)
    @submarine = Ship.new("submarine", 2)
    @ships_to_place = []
    @previous_shots = []
    @target_array = []
    @player_board = nil
    @first_hit = nil
    @ship_directionality = nil
    @is_second_ship_scenario = false
  end

  def place_ships(ship_instance, coordinate_array)
    if board.valid_placement?(ship_instance, coordinate_array)
      board.place(ship_instance, coordinate_array)
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
    @ships_to_place.map do |ship|
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

  # Hit! When the last random shot was a hit
  def last_shot_hit?
    return false if @previous_shots == []
    !@player_board.cells[@previous_shots.last].empty?
  end

  # Makes an array of the 1-4 coordinates that are eligible and around the hit location
  def array_of_nearby_possibles(coordinate)
    nearby_array = []
    # right
    nearby_array << move_coordinate_right(coordinate)
    # up
    nearby_array << move_coordinate_up(coordinate)
    # down
    nearby_array << move_coordinate_down(coordinate)
    # left
    nearby_array << move_coordinate_left(coordinate)
    # remove positions not on board or already shot at
    nearby_array = nearby_array.select do |coordinate|
      board.valid_coordinate?(coordinate) && !player_board.cells[coordinate].shot_at
    end
    nearby_array
  end

  # Takes a random shot of that array shuffle, then pop
  def take_shot_target_array
    @previous_shots << @target_array.shuffle!.pop
    @previous_shots.last
  end

  def number_of_hits
    @player_board.cells.count { |key, cell| cell.render == "H" }
  end

  def computer_shot_on_first_hit
    @target_array = array_of_nearby_possibles(@previous_shots.last)
    @first_hit = @previous_shots.last
    take_shot_target_array
  end

  def computer_shooting
    # if the targeted ship is sunk and there are still outstanding hits on the board,
    # find the outstanding hit and add its nearby's to the target array
    if @first_hit != nil && @player_board.cells[@first_hit].render == "X" && number_of_hits >= 1
      @first_hit = @player_board.cells.find { |key, cell| cell.render == "H" }.first
      @target_array = array_of_nearby_possibles(@first_hit)
      @is_second_ship_scenario = false
      return take_shot_target_array
    end
    
    if @first_hit != nil && @player_board.cells[@first_hit].render == "X"
      @is_second_ship_scenario = false
    end
    # takes random shot at beginning of game
    return take_random_shot if @player_board.cells.count { |key, cell| cell.shot_at == true }.zero?
    # if no hits on board, take a random shot
    return take_random_shot if number_of_hits.zero?
    # keeps firing from target array until second hit
    return take_shot_target_array if @target_array != [] && !last_shot_hit?
    # first hit after randomly firing, it generates the target array and begins firing at it
    if (number_of_hits == 1) && @target_array == [] && last_shot_hit?
      computer_shot_on_first_hit
      # Second ship hit scenario
    elsif @target_array == [] &&
          # number of hits on board is equal to number of hits on first hit ship
          (number_of_hits !=
           @player_board.cells.count do |key, cell|
             cell.render == "H" && @player_board.cells[@first_hit].ship == cell.ship
           end)
      @is_second_ship_scenario = true
      follow_up_array
      take_shot_target_array
      # Second hit conditions
    elsif number_of_hits >= 2
      ship_directionality_assessment
      follow_up_array
      take_shot_target_array
    else
      take_random_shot
    end
  end

  # Evaluate if ship is horizontal or vertical
  def ship_directionality_assessment
    hits_array = @player_board.cells.select { |key, cell| cell.render == "H" }.keys.sort
    if hits_array[0][0] == hits_array[(hits_array.length - 1)][0]
      @ship_directionality = "horizontal"
    elsif hits_array[0][1] == hits_array[(hits_array.length - 1)][1]
      @ship_directionality = "vertical"
    end
  end

  def follow_up_array
    @target_array = []
    hits_array = @player_board.cells.select { |key, cell| cell.render == "H" }.keys.sort
    if @is_second_ship_scenario == false
      if @ship_directionality == "horizontal"
        left_coord = hits_array.first[0] + (hits_array.first[1].to_i - 1).to_s
        two_d_targeting_iteration(left_coord, "left")
        right_coord = hits_array.last[0] + (hits_array.last[1].to_i + 1).to_s
        two_d_targeting_iteration(right_coord, "right")
      elsif @ship_directionality == "vertical"
        up_coord = (hits_array.first[0].ord - 1).chr.to_s + hits_array.first[1]
        two_d_targeting_iteration(up_coord, "up")
        down_coord = (hits_array.last[0].ord + 1).chr.to_s + hits_array.last[1]
        two_d_targeting_iteration(down_coord, "down")
      end
    else
      second_ship_scenario
    end
  end

  def second_ship_scenario
    hits_array = []
    hits_array << @first_hit
    if @ship_directionality == "vertical"
      # flipped ship directionality
      left_coord = hits_array.first[0] + (hits_array.first[1].to_i - 1).to_s
      two_d_targeting_iteration(left_coord, "left")
      right_coord = hits_array.last[0] + (hits_array.last[1].to_i + 1).to_s
      two_d_targeting_iteration(right_coord, "right")
    elsif @ship_directionality == "horizontal"
      up_coord = (hits_array.first[0].ord - 1).chr.to_s + hits_array.first[1]
      two_d_targeting_iteration(up_coord, "up")
      down_coord = (hits_array.last[0].ord + 1).chr.to_s + hits_array.last[1]
      two_d_targeting_iteration(down_coord, "down")
    end
  end

  def two_d_targeting_iteration(coordinate, direction)
    return if !board.valid_coordinate?(coordinate)
    return if player_board.cells[coordinate].render == "M"
    return if player_board.cells[coordinate].render == "X"
    if player_board.cells[coordinate].render == "."
      @target_array << coordinate
    else
      until player_board.cells[coordinate].render == "."
        coordinate = if direction == "right"
            move_coordinate_right(coordinate)
          elsif direction == "left"
            move_coordinate_left(coordinate)
          elsif direction == "up"
            move_coordinate_up(coordinate)
          elsif direction == "down"
            move_coordinate_down(coordinate)
          end
        return if !board.valid_coordinate?(coordinate) || player_board.cells[coordinate].render == "M"
      end
      @target_array << coordinate
    end
  end

  def move_coordinate_right(coordinate)
    coordinate.next
  end

  def move_coordinate_left(coordinate)
    coordinate[0] + (coordinate[1].to_i - 1).to_s
  end

  def move_coordinate_up(coordinate)
    (coordinate[0].ord - 1).chr.to_s + coordinate[1]
  end

  def move_coordinate_down(coordinate)
    (coordinate[0].ord + 1).chr.to_s + coordinate[1]
  end
end

class Computer
  attr_reader :board,
              :cruiser,
              :submarine,
              :previous_shots,
              :ships_to_place
  attr_accessor :player_board

  def initialize
    @board = Board.new
    @cruiser = Ship.new("cruiser", 3)
    @submarine = Ship.new("submarine", 2)
    @ships_to_place = []
    @previous_shots = []
    @target_array = []
    @player_board = nil
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
  
  
  # Random shot from a more intelligent shooting pattern
  # checkerboard shooting

  # Hit! When the last random shot was a hit
  def last_shot_hit?
    return false if @previous_shots == []
    !@player_board.cells[@previous_shots.last.coordinate].empty?
  end


    # Makes an array of the 1-4 coordinates that are eligible and around the hit location
  def array_of_nearby_possibles(coordinate)
    nearby_array = []
    #right
    nearby_array << coordinate.next
    #up
    nearby_array << (coordinate[0].ord - 1).chr.to_s + coordinate[1]
    #down
    nearby_array << (coordinate[0].ord + 1).chr.to_s + coordinate[1]
    #left
    nearby_array << coordinate[0] + (coordinate[1].to_i - 1).to_s
    #remove positions not on board or already shot at
    nearby_array = nearby_array.select do |coordinate| 
      board.valid_coordinate?(coordinate) && !player_board.cells[coordinate].shot_at
    end
    nearby_array
  end

    # Takes a random shot of that array shuffle, then pop

  def computer_shot_on_hit
    array_of_nearby_possibles("A3").shuffle.pop
  end

  def computer_shot_on_first_hit
    last_shot_hit = @previous_shots.last.coordinate
    @target_array = array_of_nearby_possibles(last_shot_hit)
    @target_array.shuffle.pop
  end

  def computer_shooting
    #takes random shot at beginning of game
    return take_random_shot if cells.count { |cell| cell.shot_at == true }.zero?
    #first hit, it generates the target array and begins firing at it
    elsif  (cells.count { |cell| cell.render == "H" } == 1) && target_array == [] && player_board.cells[@previous_shots.last.ship] != nil
    computer_shot_on_first_hit
    #keeps firing from target array
    elsif !last_shot_hit && (target_array != [])
      @target_array.shuffle.pop
    elsif (cells.count { |cell| cell.render == "H" } == 2)
  end 

      # (cells.count { |cell| cell.render == "H" } == 1) && 

    # Keeps on shooting from array until second hit
  
    # Follow-up hit
      # Evaluate if ship is horizontal or vertical
      # Generate new array of two possible next shots
        # Iterate (adding 1 to changing letter or number) until it gets
          # to a cell that hasn't been fired upon or has a miss (miss needs to end adding any elements)
      # Weeds out invalid coordinates
      # Fires random from that array
      # Repeat process of follow-up hit until ship.sunk? is true
    #Second ship scenario
      # If it exhausts that situation, pop out of loop also with a re-evaluation of the shots
      #IMPORTANT create variable that saves first hit location for this to work
      # Reruns follow-up hit but switches evaluation of ship horizontal/vertical
        #Horiz/vert probably also needs to be saved variable then
    #Random shot method needs to ask if there are outstanding hits on the board 
end

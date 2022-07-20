class Game
  attr_reader :computer,
              :player

  def initialize
    @player = Player.new
    @computer = Computer.new
    @computer.player_board = @player.board
  end

  def menu
    puts "Welcome to the BATTLESHIP menu! Please select your board size:"
    puts "Please enter the width in digits eg 5, maximum of 10 and minimum of 3"
    selection_1 = gets.chomp
    until selection_1.to_i > 2 && selection_1.to_i < 11 && !selection_1.include?(".")
      puts "Invalid size, please try again"
      selection_1 = gets.chomp
    end
    width = selection_1.to_i
    puts "Please enter the height in digits eg 5, maximum of 10 and minimum of 3"
    selection_2 = gets.chomp
    until selection_2.to_i > 2 && selection_2.to_i < 11 && !selection_1.include?(".")
      puts "Invalid size, please try again"
      selection_2 = gets.chomp
    end
    height = selection_2.to_i

    @player.board.cell_generator = CellGenerator.new(width, height)
    @player.board.cells = @player.board.cell_generator.cells
    @computer.board.cell_generator = CellGenerator.new(width, height)
    @computer.board.cells = @computer.board.cell_generator.cells
  end

  def place_ships_computer
    @computer.place_all_ships
  end

  def take_turn(player_shot, computer_shot)
    @computer.board.cells[player_shot].fire_upon
    @player.board.cells[computer_shot].fire_upon
  end

  def render
    puts "                                        "
    puts "=============COMPUTER BOARD============="
    puts @computer.board.render
    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)
  end

  def shot_feedback(player_shot, computer_shot)
    puts shot_feedback_player_line(player_shot)
    puts shot_feedback_computer_line(computer_shot)
  end

  def shot_feedback_player_line(player_shot)
    if @computer.board.cells[player_shot].render == "M"
      "Your shot on #{player_shot} was a miss"
    elsif @computer.board.cells[player_shot].render == "H"
      "Your shot on #{player_shot} was a hit"
    elsif @computer.board.cells[player_shot].render == "X"
      "Your shot on #{player_shot} sunk my #{@computer.board.cells[player_shot].ship.name}"
    end
  end

  def shot_feedback_computer_line(computer_shot)
    if @player.board.cells[computer_shot].render == "M"
      "My shot on #{computer_shot} was a miss"
    elsif @player.board.cells[computer_shot].render == "H"
      "My shot on #{computer_shot} was a hit"
    elsif @player.board.cells[computer_shot].render == "X"
      "My shot on #{computer_shot} sunk your #{player.board.cells[computer_shot].ship.name}"
    end
  end

  def end_game?
    if (@player.cruiser.sunk? && @player.submarine.sunk?) || (@computer.cruiser.sunk? && @computer.submarine.sunk?)
      true
    else
      false
    end
  end

  def ships_placement
    place_ships_computer

    puts "I have laid out my ships on the grid. \n" +
           "You now need to lay out your two ships. \n" +
           "The Cruiser is three units long and the Submarine is two units long."

    puts @player.board.render
    place_one_ship(@player.cruiser)
    place_one_ship(@player.submarine)
  end

  def place_one_ship(ship_instance)
    puts "Enter the squares for the #{ship_instance.name} (#{ship_instance.length} spaces):"
    puts "Please enter coordinates in the proper format, with either a space or comma between each coordinate."
    player_ship_placement = gets.chomp
      .gsub(",", " ")
      .upcase
      .split(" ")
      .sort
    until @player.board.valid_placement?(ship_instance, player_ship_placement) == true
      p "Invalid coordinates, please try again."

      player_ship_placement = gets.chomp
        .gsub(",", " ")
        .upcase
        .split(" ")
        .sort
    end
    @player.place_ships(ship_instance, player_ship_placement)
    puts @player.board.render(true)
  end

  def turns
    until end_game? == true
      # computer_shot = @computer.take_random_shot
      computer_shot = computer.computer_shooting
      p "Enter the coordinate for your shot:"

      player_shot = gets.chomp.upcase

      until @computer.board.valid_coordinate?(player_shot) && !@computer.board.cells[player_shot].shot_at
        p "Invalid coordinates, please try again."
        player_shot = gets.chomp.upcase
      end

      take_turn(player_shot, computer_shot)
      render
      shot_feedback(player_shot, computer_shot)
    end
  end

  def end_game
    if (@player.cruiser.sunk? && @player.submarine.sunk?) &&
       (@computer.cruiser.sunk? && @computer.submarine.sunk?)
      p "Mutually assured destruction accomplished."
    elsif (@player.cruiser.sunk? && @player.submarine.sunk?)
      p "I won, hahahahaha"
    else
      p "You won, nice job beating a computer..."
    end
  end
end

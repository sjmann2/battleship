class Game
  attr_reader :computer,
              :player

  def initialize
    @player = Player.new
    @computer = Computer.new
  end

  def place_ships_computer
    @computer.place_all_ships
  end

  def take_turn(player_shot, computer_shot)
    @computer.board.cells[player_shot].fire_upon
    @player.board.cells[computer_shot].fire_upon
    puts """
    =============COMPUTER BOARD============="""
    puts @computer.board.render
    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)
    
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
    else
      "Something went wrong!"
    end
  end

  def shot_feedback_computer_line(computer_shot)
    if @player.board.cells[computer_shot].render == "M"
      "My shot on #{computer_shot} was a miss"
    elsif @player.board.cells[computer_shot].render == "H"
      "My shot on #{computer_shot} was a hit"
    elsif @player.board.cells[computer_shot].render == "X"
      "My shot on #{computer_shot} sunk your #{player.board.cells[computer_shot].ship.name}"
    else
      "Something went wrong!"
    end
  end

  def end_game?
    if (@player.cruiser.sunk? && @player.submarine.sunk?) || (@computer.cruiser.sunk? && @computer.submarine.sunk?)
      true
    else
      false
    end
  end

  def run_game

    #computer places ships randomly
    place_ships_computer
  
    #Player places ships
  
    puts "I have laid out my ships on the grid. \n" +
        "You now need to lay out your two ships. \n" +
        "The Cruiser is three units long and the Submarine is two units long."
  
    puts player.board.render
  
    p "Enter the squares for the Cruiser (3 spaces):"
  
    player_cruiser_placement = gets.chomp.delete(",").upcase.split(" ")
  
    until player.board.valid_placement?(player.cruiser, player_cruiser_placement) == true
  
      p "Invalid coordinates, please try again."
  
      player_cruiser_placement = gets.chomp.delete(",").upcase.split(" ")
    end
  
    player.place_ships(player.cruiser, player_cruiser_placement)
  
    puts player.board.render(true)
  
    p "Enter the squares for the Submarine (2 spaces):"
  
    player_submarine_placement = gets.chomp.delete(",").upcase.split(" ")
  
    until player.board.valid_placement?(player.submarine, player_submarine_placement) == true
      
      p "Invalid coordinates, please try again."
  
      player_submarine_placement = gets.chomp.delete(",").upcase.split(" ")
    end
  
    player.place_ships(player.submarine, player_submarine_placement)
    puts player.board.render(true)
  
    until end_game? == true
      #random computer shot
      computer_shot = computer.take_random_shot
  require 'pry'; binding.pry
      p "Enter the coordinate for your shot:"
  
      player_shot = gets.chomp.upcase
  
      until computer.board.valid_coordinate?(player_shot) && !computer.board.cells[player_shot].shot_at
        computer.board.cells[player_shot].fire_upon == true
  
        p "Invalid coordinates, please try again."
  
        player_shot = gets.chomp.upcase
      end
  
      take_turn(player_shot, computer_shot)
    end
  
    if (player.cruiser.sunk? && player.submarine.sunk?)
      p "I won, hahahahaha"
    else
      p "You won, nice job beating a computer..."
    end
  end
end

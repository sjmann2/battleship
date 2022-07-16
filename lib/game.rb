class Game
  attr_reader :cruiser_player,
              :cruiser_computer,
              :submarine_player,
              :submarine_computer,
              :board_player,
              :board_computer
  def initialize
    @cruiser_player = Ship.new("cruiser", 3)
    @cruiser_computer = Ship.new("cruiser", 3)
    @submarine_player = Ship.new("submarine", 2)
    @submarine_computer = Ship.new("submarine", 2)
    @board_player = Board.new
    @board_computer = Board.new
  end

  def place_ships_player(ship_instance, coordinate_array)
    if board_player.valid_placement?(ship_instance, coordinate_array)
    board_player.place(ship_instance, coordinate_array)
    else
      'Invalid coordinates try again'
    end
  end

  def place_ships_computer(ship_instance, coordinate_array)
    if board_computer.valid_placement?(ship_instance, coordinate_array)
    board_computer.place(ship_instance, coordinate_array)
    else
      'Invalid coordinates try again'
    end
  end

  def take_turn(player_shot, computer_shot)


      # if board_computer.valid_coordinate?(player_shot) && !board_computer.cells[player_shot].shot_at
      #   board_computer.cells[player_shot].fire_upon
      # else
      #   "Something went wrong!"
      # end
      board_computer.cells[player_shot].fire_upon
      board_player.cells[computer_shot].fire_upon
      puts "=============COMPUTER BOARD============="
      puts board_computer.render
      puts "==============PLAYER BOARD=============="
      puts board_player.render(true)
      #feedback here!
      puts shot_feedback_player_line(player_shot)
      puts shot_feedback_computer_line(computer_shot)
  end

  def shot_feedback_player_line(player_shot)
    if board_computer.cells[player_shot].render == 'M'
      "Your shot on #{player_shot} was a miss"
    elsif board_computer.cells[player_shot].render == 'H'
      "Your shot on #{player_shot} was a hit"
    elsif board_computer.cells[player_shot].render == 'X'
      "Your shot on #{player_shot} sunk my #{board_computer.cells[player_shot].ship.name}"
    else
      "Something went wrong!"
    end
  end

  def shot_feedback_computer_line(computer_shot)
    if board_player.cells[computer_shot].render == 'M'
      "My shot on #{computer_shot} was a miss"
    elsif board_player.cells[computer_shot].render == 'H'
      "My shot on #{computer_shot} was a hit"
    elsif board_player.cells[computer_shot].render == 'X'
      "My shot on #{computer_shot} sunk your #{board_player.cells[computer_shot].ship.name}"
    else
      "Something went wrong!"
    end
  end
  
  def end_game?
    if (@cruiser_player.sunk? && @submarine_player.sunk?) || (@submarine_computer.sunk? && @cruiser_computer.sunk?)
      true
    else
      false
    end
  end
end
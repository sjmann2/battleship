class Game
  attr_reader :computer,
              :player

  def initialize
    @player = Player.new
    @computer = Computer.new
  end

  def place_ships_computer
    @computer.place_all_ships(@player.board)
  end

  def take_turn(player_shot, computer_shot)
    # if board_computer.valid_coordinate?(@player_shot) && !board_computer.cells[@player_shot].shot_at
    #   board_computer.cells[@player_shot].fire_upon
    # else
    #   "Something went wrong!"
    # end
    @computer.board.cells[player_shot].fire_upon
    @player.board.cells[computer_shot].fire_upon
    puts "=============COMPUTER BOARD============="
    puts @computer.board.render
    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)
    #feedback here!
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
end

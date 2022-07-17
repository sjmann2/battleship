require "./lib/board"
require "./lib/ship"
require "./lib/cell"
require "./lib/game"
require "./lib/cell_generator"
require "./lib/player"
require "./lib/computer"

def run_game
  game = Game.new
  #computer places ships randomly
  game.place_all_ships

  #Player places ships

  puts "I have laid out my ships on the grid. \n" +
      "You now need to lay out your two ships. \n" +
      "The Cruiser is three units long and the Submarine is two units long."

  puts game.player.board.render

  p "Enter the squares for the Cruiser (3 spaces):"

  player_cruiser_placement = gets.chomp.delete(",").upcase.split(" ")

  until game.player.board.valid_placement?(game.player.cruiser, player_cruiser_placement) == true

    p "Invalid coordinates, please try again."

    player_cruiser_placement = gets.chomp.delete(",").upcase.split(" ")
  end

  game.player.place_ships(game.player.cruiser, player_cruiser_placement)

  puts game.player.board.render(true)

  p "Enter the squares for the Submarine (2 spaces):"

  player_submarine_placement = gets.chomp.delete(",").upcase.split(" ")

  until game.player.board.valid_placement?(game.player.submarine, player_submarine_placement) == true
    
    p "Invalid coordinates, please try again."

    player_submarine_placement = gets.chomp.delete(",").upcase.split(" ")
  end

  game.player.place_ships(game.player.submarine, player_submarine_placement)
  puts game.player.board.render(true)
require 'pry'; binding.pry
  until game.end_game? == true
    #random computer shot
    game.computer.take_random_shot

    p "Enter the coordinate for your shot:"

    player_shot = gets.chomp.upcase

    until game.board_computer.valid_coordinate?(player_shot) && !game.board_computer.cells[player_shot].shot_at
      game.board_computer.cells[player_shot].fire_upon == true

      p "Invalid coordinates, please try again."

      player_shot = gets.chomp.upcase
    end

    game.take_turn(player_shot, computer_shot)
    p " "
  end

  if (game.player.cruiser.sunk? && game.player.submarine.sunk?)
    p "I won, hahahahaha"
  else
    p "You won, nice job beating a computer..."
  end
end

player_input = nil
until player_input == "q"
  p "Welcome to BATTLESHIP"
  p "Enter p to play. Enter q to quit."
  player_input = gets.chomp
  if player_input == "p"
    run_game
  end
  p "Welcome to BATTLESHIP"
  p "Enter p to play. Enter q to quit."
  player_input = gets.chomp
end

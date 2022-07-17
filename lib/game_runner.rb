require "./lib/board"
require "./lib/ship"
require "./lib/cell"
require "./lib/game"
require "./lib/cell_generator"
require "./lib/player"
require "./lib/computer"



player_input = nil
until player_input == "q"
  p "Welcome to BATTLESHIP"
  p "Enter p to play. Enter q to quit."
  player_input = gets.chomp
  if player_input == "p"
    game = Game.new
    game.run_game
  end
  p "Welcome to BATTLESHIP"
  p "Enter p to play. Enter q to quit."
  player_input = gets.chomp
end

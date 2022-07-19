require "./lib/board"
require "./lib/ship"
require "./lib/cell"
require "./lib/game"
require "./lib/cell_generator"
require "./lib/player"
require "./lib/computer"

def run
  player_input = nil
  until player_input == "q"
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit."
    player_input = gets.chomp
    if player_input == "p"
      game = Game.new
      game.ships_placement
      game.turns
      game.end_game
    end
  end
end

p run

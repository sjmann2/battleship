require "./lib/board"
require "./lib/ship"
require "./lib/cell"
require "./lib/game"
require "./lib/cell_generator"
require "./lib/player"

def run_game
  game = Game.new
  #Computer places ships
  # game.place_ships_computer(game.cruiser_computer, ['A1', 'A2', 'A3'])
  # game.place_ships_computer(game.submarine_computer, ['B1', 'B2'])
  #Random Ship placement
  #generate random(but valid!) arrays based on ship length
  #picks a random spot
  computer_ship_placement_array = []
  ship_instance = game.cruiser_computer

  def random_computer_ship_placement(ship_instance, game, computer_ship_placement_array)
    until game.board_computer.valid_placement?(ship_instance, computer_ship_placement_array) == true
      (ship_instance.length).times do
        computer_ship_placement_array << game.board_computer.cells.keys.sample
      end
      if game.board_computer.valid_placement?(ship_instance, computer_ship_placement_array)
        computer_ship_placement_array
      else
        computer_ship_placement_array = []
      end
    end
    computer_ship_placement_array
  end

  computer_ship_placement_array = random_computer_ship_placement(game.cruiser_computer, game, computer_ship_placement_array)
  game.place_ships_computer(game.cruiser_computer, computer_ship_placement_array)
  computer_ship_placement_array = []
  computer_ship_placement_array = random_computer_ship_placement(game.submarine_computer, game, computer_ship_placement_array)
  game.place_ships_computer(game.submarine_computer, computer_ship_placement_array)

  #Player places ships

  puts """I have laid out my ships on the grid.
      You now need to lay out your two ships.
      The Cruiser is three units long and the Submarine is two units long."""

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

  until game.end_game? == true
    #random computer shot
    computer_shot = game.board_computer.cells.keys.sample
    until !game.player.board.cells[computer_shot].shot_at == true
      computer_shot = game.board_computer.cells.keys.sample
    end

    p "Enter the coordinate for your shot:"

    player_shot = gets.chomp.upcase

    until game.board_computer.valid_coordinate?(player_shot) && !game.board_computer.cells[player_shot].shot_at
      game.board_computer.cells[player_shot].fire_upon == true

      p "Invalid coordinates, please try again."

      player_shot = gets.chomp.upcase
    end

    game.take_turn(player_shot, computer_shot)
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

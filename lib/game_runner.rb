require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'



def run_game
    game = Game.new
    #Computer places ships
    game.place_ships_computer(game.cruiser_computer, ['A1', 'A2', 'A3'])
    game.place_ships_computer(game.submarine_computer, ['B1', 'B2'])
    
    #Player places ships
    p "I have laid out my ships on the grid."
    p "You now need to lay out your two ships."
    p "The Cruiser is three units long and the Submarine is two units long."
    puts game.board_player.render
    p "Enter the squares for the Cruiser (3 spaces):"
    player_cruiser_placement = gets.chomp.upcase.split(" ")
    until game.board_player.valid_placement?(game.cruiser_player, player_cruiser_placement) == true
        p "Invalid coordinates, please try again."
    end
    game.place_ships_player(game.cruiser_player, player_cruiser_placement)

    puts game.board_player.render(true)
    p "Enter the squares for the Submarine (2 spaces):"
    player_submarine_placement = gets.chomp.upcase.split(" ")
    until game.board_player.valid_placement?(game.submarine_player, player_submarine_placement) == true
        p "Invalid coordinates, please try again."
    end
    game.place_ships_player(game.submarine_player, player_submarine_placement)
    puts game.board_player.render(true)



        #print out communication: ship length, render board,
        #provide input for ship positions(cruiser, submarine)
        #If input is invalid, method to have player re-enter coordinates
    #The turn
        #until loop: until end game conditions are met
    #End game
        #You won or I won
    #Returned back to main menu

end



p "Welcome to BATTLESHIP"
p "Enter p to play. Enter q to quit."
player_input = gets.chomp
if player_input == "p"
    run_game
end

# until end_game? == true


# end


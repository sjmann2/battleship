require "./lib/board"
require "./lib/ship"
require "./lib/cell"
require "./lib/game"
require "./lib/cell_generator"
require "./lib/player"
require "./lib/computer"

describe Game do
  it "exists" do
    game = Game.new

    expect(game).to be_instance_of(Game)
  end

  it "automatically generates new ships and board" do
    game = Game.new

    expect(game.cruiser_computer).to be_instance_of(Ship)
    expect(game.submarine_computer).to be_instance_of(Ship)
    expect(game.board_computer).to be_instance_of(Board)
  end

  it "can place ships" do
    game = Game.new

    game.place_ships_computer(game.cruiser_computer, ["A1", "A2", "A3"])
    game.place_ships_computer(game.submarine_computer, ["B1", "B2"])
    expect(game.board_computer.cells["A1"].ship).to eq(game.cruiser_computer)
    expect(game.board_computer.cells["A2"].ship).to eq(game.cruiser_computer)
    expect(game.board_computer.cells["A3"].ship).to eq(game.cruiser_computer)
    expect(game.board_computer.cells["B1"].ship).to eq(game.submarine_computer)
    expect(game.place_ships_computer(game.submarine_computer, ["B3", "B2"])).to eq("Invalid coordinates try again")
  end

  it "can take a turn" do
    game = Game.new
    player = Player.new

    game.player.place_ships(game.player.cruiser, ["A1", "A2", "A3"])
    game.player.place_ships(game.player.submarine, ["B1", "B2"])
    game.place_ships_computer(game.cruiser_computer, ["A1", "A2", "A3"])
    game.place_ships_computer(game.submarine_computer, ["B1", "B2"])

    #(player's inputted shot, computer shot)
    expect(game.board_computer.cells["A4"].render).to eq(".")
    expect(game.player.board.cells["A4"].render).to eq(".")

    game.take_turn("A4", "A4")

    expect(game.board_computer.cells["A4"].render).to eq("M")
    expect(game.player.board.cells["A4"].render).to eq("M")

    game.take_turn("A1", "B1")

    expect(game.board_computer.cells["A1"].render).to eq("H")
    expect(game.player.board.cells["B1"].render).to eq("H")

    game.take_turn("A2", "B2")

    expect(game.board_computer.cells["A2"].render).to eq("H")
    expect(game.player.board.cells["B2"].render).to eq("X")

    game.take_turn("C2", "C2")

    #CLI output and feedback isn't tested, render(true)

    #Render both boards
    #player shot => go into computer board, call the corresponding cell, run fire_upon method
    #computer shot => go into player board, call the corresponding cell, run fire_upon method
    #Reporting results of the shot (feedback!)
    #Runs inside a loop until both ships of either player or computer are ship.sunk? = true

  end

  it "knows when to end game" do
    game = Game.new
    player = Player.new

    game.player.place_ships(game.player.cruiser, ["A1", "A2", "A3"])
    game.player.place_ships(game.player.cruiser, ["B1", "B2"])
    game.place_ships_computer(game.cruiser_computer, ["A1", "A2", "A3"])
    game.place_ships_computer(game.submarine_computer, ["B1", "B2"])

    game.take_turn("A2", "A4")
    game.take_turn("A1", "B1")
    game.take_turn("A3", "B2")

    expect(game.end_game?).to eq(false)

    game.take_turn("B1", "C2")
    game.take_turn("B2", "C3")

    expect(game.end_game?).to eq(true)
  end

  xit "gives feedback on shots" do
    game = Game.new

    game.player.place_ships(game.cruiser_player, ["A1", "A2", "A3"])
    game.player.place_ships(game.submarine_player, ["B1", "B2"])
    game.place_ships_computer(game.cruiser_computer, ["A1", "A2", "A3"])
    game.place_ships_computer(game.submarine_computer, ["B1", "B2"])
    #take_turn test
    expect(game.take_turn("A4", "A4")).to eq("")
    #helper test
    game.shot_feedback("A4", "A4")
  end

  xit "places ships on board for both sides" do
    game = Game.new
    #game initialization automatically create cruiser and sub with empty arrays
    game.player.place_ships(cruiser, ["A1", "A2", "A3"])
    #make the ship class object cruiser
    game.player.place_ships(submarine, ["B1", "B2"])

    game.place_ships_computer(cruiser, ["A1", "A2", "A3"])
    game.place_ships_computer(submarine, ["B1", "B2"])

    #player board to show ships place and computer ships are present with true value
    expect()

    #Turn - both sides input their shots and get feedback on those shots
    #Turn is repeated until End Game conditions are met
    #End Game all ships are sunk by one side

    expect()
  end
end

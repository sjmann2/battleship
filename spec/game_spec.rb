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

  it "automatically generates player and computer" do
    game = Game.new

    expect(game.computer).to be_instance_of(Computer)
    expect(game.player).to be_instance_of(Player)
  end

  it "can take a turn" do
    game = Game.new

    game.player.place_ships(game.player.cruiser, ["A1", "A2", "A3"])
    game.player.place_ships(game.player.submarine, ["B1", "B2"])
    game.computer.place_ships(game.computer.cruiser, ["A1", "A2", "A3"])
    game.computer.place_ships(game.computer.submarine, ["B1", "B2"])

    expect(game.computer.board.cells["A4"].render).to eq(".")
    expect(game.player.board.cells["A4"].render).to eq(".")

    game.take_turn("A4", "A4")

    expect(game.computer.board.cells["A4"].render).to eq("M")
    expect(game.player.board.cells["A4"].render).to eq("M")

    game.take_turn("A1", "B1")

    expect(game.computer.board.cells["A1"].render).to eq("H")
    expect(game.player.board.cells["B1"].render).to eq("H")

    game.take_turn("A2", "B2")

    expect(game.computer.board.cells["A2"].render).to eq("H")
    expect(game.player.board.cells["B2"].render).to eq("X")

    game.take_turn("C2", "C2")

    expect(game.computer.board.cells["C2"].render).to eq("M")
    expect(game.player.board.cells["C2"].render).to eq("M")
  end

  it "knows when to end game" do
    game = Game.new

    game.player.place_ships(game.player.cruiser, ["A1", "A2", "A3"])
    game.player.place_ships(game.player.submarine, ["B1", "B2"])
    game.computer.place_all_ships

    game.take_turn("A2", "A2")
    game.take_turn("A1", "A1")
    game.take_turn("A3", "A3")

    expect(game.end_game?).to eq(false)

    game.take_turn("B1", "B1")
    game.take_turn("B2", "B2")

    expect(game.end_game?).to eq(true)
  end

  it "places ships on board" do
    game = Game.new
    
    game.player.place_ships(game.player.cruiser, ["A1", "A2", "A3"])
    game.player.place_ships(game.player.submarine, ["B1", "B2"])
    
    expect(game.player.board.cells["A1"].empty?).to be(false)
    expect(game.place_ships_computer).to be_instance_of(Array)
    #I had trouble testing place ships computer--spent too long staring at it feel free
    #different test
  end
end

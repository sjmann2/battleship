require "./lib/board"
require "./lib/ship"
require "./lib/cell"
require "./lib/game"
require "./lib/cell_generator"
require "./lib/player"

describe Player do
  it "exists" do
    player = Player.new

    expect(player).to be_instance_of(Player)
  end

  it "has ships and a board" do
    player = Player.new

    expect(player.board).to be_instance_of(Board)
    expect(player.cruiser).to be_instance_of(Ship)
    expect(player.submarine).to be_instance_of(Ship)
  end

  it "can place ships" do
    player = Player.new

    player.place_ships(player.cruiser, ["A1", "A2", "A3"])
    player.place_ships(player.submarine, ["B1", "B2"])

    expect(player.board.cells["A1"].ship).to eq(player.cruiser)
    expect(player.board.cells["A2"].ship).to eq(player.cruiser)
    expect(player.board.cells["A3"].ship).to eq(player.cruiser)
    expect(player.board.cells["B3"].empty?).to eq(true)
    expect(player.place_ships(player.submarine, ["B3", "B2"])).to eq("Invalid coordinates try again")
  end
end

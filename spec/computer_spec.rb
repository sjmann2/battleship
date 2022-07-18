require "./lib/board"
require "./lib/ship"
require "./lib/cell"
require "./lib/game"
require "./lib/cell_generator"
require "./lib/player"
require "./lib/computer"

describe Computer do
  it "exists" do
    computer = Computer.new

    expect(computer).to be_instance_of(Computer)
  end

  it "has ships and a board" do
    computer = Computer.new
    expect(computer.board).to be_instance_of(Board)
    expect(computer.cruiser).to be_instance_of(Ship)
    expect(computer.submarine).to be_instance_of(Ship)
  end

  it "can place ships" do
    game = Game.new

    game.computer.place_ships(game.computer.cruiser, ["A1", "A2", "A3"])
    game.computer.place_ships(game.computer.submarine, ["B1", "B2"])

    expect(game.computer.board.cells["A1"].ship).to eq(game.computer.cruiser)
    expect(game.computer.board.cells["A2"].ship).to eq(game.computer.cruiser)
    expect(game.computer.board.cells["A3"].ship).to eq(game.computer.cruiser)
    expect(game.computer.board.cells['B3'].empty?).to eq(true)
    expect(game.computer.place_ships(game.computer.submarine, ["B3", "B2"]))
      .to eq("Invalid coordinates try again")
  end

  it 'can generate random valid ship placements' do
    computer = Computer.new
    50.times do
      expect(computer.board.valid_placement?(
            computer.cruiser,
            computer.random_computer_ship_placement(computer.cruiser)
            )).to eq(true)
    end
  end

  it 'can place multiple ships at a time' do
    game = Game.new

    game.place_ships_computer
    expect(game.computer.board.cells.count { |cell_name, cell| cell.ship != nil }).to eq(5)
  end

  it 'can take a random shot' do
    game = Game.new
    16.times do
      computer_shot = game.computer.take_random_shot
      expect(game.player.board.valid_coordinate?(computer_shot)).to eq(true)
    end
  end

  it 'can tell if last shot was a hit' do
    game = Game.new

    game.player.place_ships(game.player.cruiser, ["A1", "A2", "A3"])
    game.player.place_ships(game.player.submarine, ["B1", "B2"])

    game.take_turn("A1", "A4")
    game.computer.previous_shots << game.computer.board.cells["A4"]
    expect(game.computer.last_shot_hit?).to be false

    game.take_turn("A2", "A1")
    game.computer.previous_shots << game.computer.board.cells["A1"]

    expect(game.computer.last_shot_hit?).to be true

    game.take_turn("A3", "B3")
    game.computer.previous_shots << game.computer.board.cells["B3"]
    expect(game.computer.last_shot_hit?).to be false

    game.take_turn("A4", "B2")
    game.computer.previous_shots << game.computer.board.cells["B2"]
    expect(game.computer.last_shot_hit?).to be true
  end

  it 'can make array of possible coordinate to shoot at after hit' do

    game = Game.new

    game.player.place_ships(game.player.cruiser, ["A1", "A2", "A3"])
    game.player.place_ships(game.player.submarine, ["B1", "B2"])

    game.take_turn("A1", "A4")
    game.computer.previous_shots << game.computer.board.cells["A4"]

    expect(game.computer.last_shot_hit?).to be false

    game.take_turn("A2", "A3")
    game.computer.previous_shots << game.computer.board.cells["A3"]

    expect(game.computer.array_of_nearby_possibles("A3")).to eq(["B3", "A2"])
  end

  it 'takes random shot from array of possible hits' do
    game = Game.new

    game.player.place_ships(game.player.cruiser, ["A1", "A2", "A3"])
    game.player.place_ships(game.player.submarine, ["B1", "B2"])

    game.take_turn("A1", "A4")
    game.computer.previous_shots << game.computer.board.cells["A4"]

    expect(game.computer.last_shot_hit?).to be false

    game.take_turn("A2", "A3")
    game.computer.previous_shots << game.computer.board.cells["A3"]

    expect(game.computer.computer_shot_on_hit == "B3" || "A2").to eq(true)
  end
end

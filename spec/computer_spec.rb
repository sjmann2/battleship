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
    expect(game.computer.board.cells["B3"].empty?).to eq(true)
  end

  it "can generate random valid ship placements" do
    computer = Computer.new
    50.times do
      expect(computer.board.valid_placement?(
        computer.cruiser,
        computer.random_computer_ship_placement(computer.cruiser)
      )).to eq(true)
    end
  end

  it "can place multiple ships at a time" do
    game = Game.new

    game.place_ships_computer
    expect(game.computer.board.cells.count { |cell_name, cell| cell.ship != nil }).to eq(5)
  end

  it "can take a random shot" do
    game = Game.new
    16.times do
      computer_shot = game.computer.take_random_shot
      expect(game.player.board.valid_coordinate?(computer_shot)).to eq(true)
    end
  end

  it "can tell if last shot was a hit" do
    game = Game.new

    game.player.place_ships(game.player.cruiser, ["A1", "A2", "A3"])
    game.player.place_ships(game.player.submarine, ["B1", "B2"])

    game.take_turn("A1", "A4")
    game.computer.previous_shots << "A4"

    expect(game.computer.last_shot_hit?).to be false

    game.take_turn("A2", "A1")
    game.computer.previous_shots << "A1"

    expect(game.computer.last_shot_hit?).to be true

    game.take_turn("A3", "B3")
    game.computer.previous_shots << "B3"

    expect(game.computer.last_shot_hit?).to be false

    game.take_turn("A4", "B2")
    game.computer.previous_shots << "B2"

    expect(game.computer.last_shot_hit?).to be true
  end

  it "can make array of possible coordinates to shoot at after hit" do
    game = Game.new

    game.player.place_ships(game.player.cruiser, ["A1", "A2", "A3"])
    game.player.place_ships(game.player.submarine, ["B1", "B2"])

    game.take_turn("A1", "A4")
    game.computer.previous_shots << "A4"

    expect(game.computer.last_shot_hit?).to be false

    game.take_turn("A2", "A3")
    game.computer.previous_shots << "A3"

    expect(game.computer.array_of_nearby_possibles("A3")).to eq(["B3", "A2"])
  end

  it "takes random shot from array of possible hits" do
    game = Game.new

    game.player.place_ships(game.player.cruiser, ["A1", "A2", "A3"])
    game.player.place_ships(game.player.submarine, ["B1", "B2"])

    game.take_turn("A1", "A4")
    game.computer.previous_shots << "A4"

    expect(game.computer.last_shot_hit?).to be false

    game.take_turn("A2", "B3")
    game.computer.previous_shots << "B3"

    game.take_turn("A3", "A3")
    game.computer.previous_shots << "A3"

    expect(game.computer.computer_shot_on_first_hit).to eq("A2")
  end

  it "counts number of hits on player board" do
    game = Game.new

    game.player.place_ships(game.player.cruiser, ["A1", "A2", "A3"])
    game.player.place_ships(game.player.submarine, ["B1", "B2"])

    game.take_turn("A1", "A4")
    expect(game.computer.number_of_hits).to eq(0)

    game.take_turn("A2", "B2")
    expect(game.computer.number_of_hits).to eq(1)

    game.take_turn("A3", "A3")
    expect(game.computer.number_of_hits).to eq(2)
  end

  it "can evaluate if ship is horizontal" do
    game = Game.new

    game.player.place_ships(game.player.cruiser, ["A1", "A2", "A3"])
    game.player.place_ships(game.player.submarine, ["B1", "C1"])

    game.take_turn("A1", "A1")
    game.computer.previous_shots << "A1"

    game.take_turn("A2", "A2")
    game.computer.previous_shots << "A2"
    game.computer.ship_directionality_assessment

    expect(game.computer.ship_directionality).to eq("horizontal")
  end

  it "can evaluate if ship is vertical" do
    game = Game.new

    game.player.place_ships(game.player.cruiser, ["A4", "B4", "C4"])
    game.player.place_ships(game.player.submarine, ["B1", "C1"])

    game.take_turn("A1", "A4")
    game.computer.previous_shots << "A4"

    game.take_turn("A2", "B4")
    game.computer.previous_shots << "B4"
    game.computer.ship_directionality_assessment

    expect(game.computer.ship_directionality).to eq("vertical")
  end

  it "can provide valid next shot in any direction starting from a hit" do
    game = Game.new

    game.player.place_ships(game.player.cruiser, ["A1", "A2", "A3"])
    game.player.place_ships(game.player.submarine, ["B1", "B2"])

    game.take_turn("A1", "B2")
    game.computer.previous_shots << "B2"
    game.computer.two_d_targeting_iteration("B2", "left")

    expect(game.computer.target_array).to eq(["B1"])
  end

  it "can provide next coordinate based on a direction" do
    computer = Computer.new
    coordinate = "B3"

    expect(computer.move_coordinate_down(coordinate)).to eq("C3")
    expect(computer.move_coordinate_up(coordinate)).to eq("A3")
    expect(computer.move_coordinate_right(coordinate)).to eq("B4")
    expect(computer.move_coordinate_left(coordinate)).to eq("B2")
  end

  it "can handle the second ship scenario" do
    # This setup tests if the computer can handle hitting a second ship
    # when its already started firing at another. This was the most likely
    # arrangement to make the computer fall into firing on two ships
    # On first shot after "B1", there is a 33% chance of hitting the second
    # ship, 33% of a miss, and 33% chance of hitting the same ship.
    game = Game.new

    game.player.place_ships(game.player.cruiser, ["B1", "B2", "B3"])
    game.player.place_ships(game.player.submarine, ["C1", "C2"])

    game.take_turn("A1", "A4")
    game.computer.previous_shots << "A4"

    game.take_turn("A2", "B1")
    game.computer.previous_shots << "B1"
    game.computer.first_hit = "B1"

    game.take_turn("A3", game.computer.computer_shooting)

    game.take_turn("A4", game.computer.computer_shooting)

    game.take_turn("B1", game.computer.computer_shooting)

    game.take_turn("B2", game.computer.computer_shooting)

    game.take_turn("B3", game.computer.computer_shooting)

    game.take_turn("B4", game.computer.computer_shooting)

    game.take_turn("B4", game.computer.computer_shooting)

    game.take_turn("B4", game.computer.computer_shooting)
  end
end

require "./lib/board"
require "./lib/ship"
require "./lib/cell"
require "./lib/cell_generator"

describe Board do
  it "exists" do
    board = Board.new
    expect(board).to be_instance_of(Board)
  end

  it "has cells" do
    board = Board.new

    expect(board.cells).to be_instance_of(Hash)
    expect(board.cells["B1"]).to be_instance_of(Cell)
  end

  it "can tell if coordinate is on the board" do
    board = Board.new

    expect(board.valid_coordinate?("A1")).to be(true)
    expect(board.coordinates_are_on_board(["A1", "A2", "A3"])).to be(true)
    expect(board.valid_coordinate?("D4")).to be(true)
    expect(board.valid_coordinate?("A5")).to be(false)
    expect(board.coordinates_are_on_board(["A5", "A6", "A7"])).to be(false)
    expect(board.valid_coordinate?("E1")).to be(false)
    expect(board.coordinates_are_on_board(["E1", "E2", "E3"])).to be(false)
    expect(board.valid_coordinate?("A22")).to be(false)
    expect(board.valid_coordinate?("F30")).to be(false)
    expect(board.valid_coordinate?("AFLK,J&DK:KD")).to be(false)
  end

  it "coordinates length should be equal to length of the ship" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be(false)
    expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be(false)
    expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be(true)
    expect(board.valid_placement?(submarine, ["A2", "A3"])).to be(true)
  end

  it "coordinates should be consecutive and in ascending order" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be(false)
    expect(board.consecutive_numbers_comparison(["A1", "A2", "A4"], cruiser)).to be(false)
    expect(board.valid_placement?(submarine, ["C1", "B1"])).to be(false)
    expect(board.same_numbers_comparison(["C1", "B1"], submarine)).to be(true)
    expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be(false)
    expect(board.same_letters_comparison(["A3", "A2", "A1"], cruiser)).to be(true)
    expect(board.valid_placement?(submarine, ["C2", "D3"])).to be(false)
    expect(board.consecutive_letters_comparison(["C2", "D3"], submarine)).to be(true)

    expect(board.valid_placement?(submarine, ["A1", "A2"])).to be(true)
    expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be(true)
  end

  it "cant have overlapping ships" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be(true)

    board.place(cruiser, ["A1", "A2", "A3"])

    expect(board.valid_placement?(submarine, ["A1", "B1"])).to be(false)
    expect(board.valid_placement?(submarine, ["A2", "B2"])).to be(false)
    expect(board.valid_placement?(submarine, ["A3", "B3"])).to be(false)
  end

  it "can place ships" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    expect(cell_1.ship).to eq(cruiser)
    expect(cell_2.ship).to eq(cruiser)
    expect(cell_3.ship).to eq(cruiser)
  end

  it "can render a board" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")

    board.place(cruiser, ["A1", "A2", "A3"])

    expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
  end
end

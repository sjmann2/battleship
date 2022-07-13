require './lib/board'
require './lib/ship'
require './lib/cell'

describe Board do
    it 'exists' do
    board = Board.new
    expect(board).to be_an_instance_of(Board)
    end

    it 'has cells' do
    board = Board.new

    expect(board.cells).to be_an_instance_of(Hash)
    expect(board.cells["B1"]).to be_an_instance_of(Cell)
    end

    it 'can tell if coordinate is on the board' do
    board = Board.new

    expect(board.valid_coordinate?("A1")).to be(true)
    expect(board.valid_coordinate?("D4")).to be(true)
    expect(board.valid_coordinate?("A5")).to be(false)
    expect(board.valid_coordinate?("E1")).to be(false)
    expect(board.valid_coordinate?("A22")).to be(false)
    end

    it 'can place ships correctly' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    #coordinates in array should be the same as the length of the ship
    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be(false)
    expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be(false)
    #make sure the coordinates are consecutive
    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be(false)
    expect(board.valid_placement?(submarine, ["C1", "B1"])).to be(false)
    expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be(false)
    expect(board.valid_placement?(submarine, ["C2", "D3"])).to be(false)
    #these should be valid

    expect(board.valid_placement?(submarine, ["A1", "A2"])).to be(true)
    expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be(true)
    end
    
end


        
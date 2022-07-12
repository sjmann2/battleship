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
    
end


        
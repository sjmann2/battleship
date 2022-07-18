require "./lib/cell_generator"
require "./lib/cell"
require "./lib/board"

describe CellGenerator do
  it "exists" do
    cells = CellGenerator.new
    expect(cells).to be_instance_of(CellGenerator)
  end


  it "has a default width and a height" do
    cells = CellGenerator.new

    expect(cells.height).to eq(4)

    expect(cells.width).to eq(4)
  end

  it "is a hash of cell coordinates" do
    cells = CellGenerator.new.cells

    expect(cells).to be_an_instance_of(Hash)
    expect(cells["A1"]).to be_instance_of(Cell)
  end

  it "contains 16 key value pairs by default" do
    cells = CellGenerator.new.cells

    expect(cells.width).to eq(16)
    #This should be testing area or key value pairs, not just checking width
    #width = 4, not 16
  end

  it "can increase board size" do
    cells = CellGenerator.new(6, 6).cells

    expect(cells.width).to eq(36)
    #same here, width is 6, not 36
    expect(cells["F6"]).to be_instance_of(Cell)
  end
end

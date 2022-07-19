require "./lib/cell"
require "./lib/ship"

describe Cell do
  it "exists" do
    cell = Cell.new("B4")

    expect(cell).to be_instance_of(Cell)
  end

  it "has attributes" do
    cell = Cell.new("B4")

    expect(cell.ship).to be nil
    expect(cell.coordinate).to eq("B4")
  end

  it "can hold a ship" do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    expect(cell.empty?).to be true

    cell.place_ship(cruiser)
    expect(cell.empty?).to be false
    expect(cell.ship).to eq(cruiser)
  end

  it "can be fired upon" do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)
    expect(cell.fired_upon?).to be false
    cell.fire_upon
    expect(cell.fired_upon?).to be true
    expect(cell.ship.health).to eq(2)
  end

  it "can be rendered to show a miss" do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    expect(cell.render).to eq(".")
    expect(cell.render(true)).to eq(".")
    cell.fire_upon

    expect(cell.render).to eq("M")
    expect(cell.render(true)).to eq("M")
  end

  it "can be rendered to show a hit" do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    expect(cell.render).to eq(".")
    expect(cell.render(true)).to eq("S")
    cell.fire_upon

    expect(cell.render).to eq("H")
    expect(cell.render(true)).to eq("H")

    cell.fire_upon
    cell.fire_upon

    expect(cell.render).to eq("H")
    expect(cell.render(true)).to eq("H")

    cruiser.hit
    cruiser.hit

    expect(cell.render).to eq("X")
    expect(cell.render(true)).to eq("X")
  end
end

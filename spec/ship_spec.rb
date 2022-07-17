require "./lib/ship"

describe Ship do
  it "exists" do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser).to be_an_instance_of(Ship)
  end

  it "has attributes" do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.name).to eq("Cruiser")
    expect(cruiser.length).to be(3)
  end

  it "has default health equal to length" do
    cruiser = Ship.new("Cruiser", 3)
    expect(cruiser.health).to be(3)
  end

  it "has method to determine if sunk" do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.sunk?).to be(false)
    cruiser.hit
    cruiser.hit
    expect(cruiser.sunk?).to be(false)
    cruiser.hit
    expect(cruiser.sunk?).to be(true)
    cruiser.hit
    expect(cruiser.sunk?).to be(true)
  end

  it "can get hit" do
    cruiser = Ship.new("Cruiser", 3)
    expect(cruiser.health).to be(3)
    cruiser.hit
    expect(cruiser.health).to be(2)
  end
end

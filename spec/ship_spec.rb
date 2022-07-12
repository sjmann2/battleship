require './lib/ship'

describe Ship do
    it 'exists' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser).to be_an_instance_of(Ship)
    end

    it 'has attributes' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.name).to eq("Cruiser")
    expect(cruiser.length).to be(3)
    end

end
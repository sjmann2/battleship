require './lib/cell'
require './lib/ship'

describe Cell do
    it 'exists' do
        cell = Cell.new('B4')

        expect(cell).to be_an_instance_of(Cell)
    end 

    it 'has attributes' do
        cell = Cell.new('B4')
        
        expect(cell.ship).to be nil
        expect(cell.coordinate).to eq('B4')
    end

    it 'can hold a ship' do
        cell = Cell.new('B4')
        cruiser = Ship.new("Cruiser", 3)
        expect(cell.empty?).to be true

        cell.place_ship(cruiser)
        expect(cell.empty?).to be false
        expect(cell.ship).to eq(cruiser)
    end

    it 'can be fired upon' do
        cell = Cell.new('B4')
        cruiser = Ship.new("Cruiser", 3)
        cell.place_ship(cruiser)

        expect(cell.fired_upon?).to be false
        cell.fire_upon
        expect(cell.fired_upon?).to be true
    end


end
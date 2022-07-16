require './lib/cell_generator'
require './lib/cell'

describe CellGenerator do
    it 'exists' do
        cells = CellGenerator.new
        expect(cells).to be_an_instance_of(CellGenerator)
    end

    it 'has a default length and a width' do
        cells = CellGenerator.new
        
        expect(cells.width).to eq(4)
        expect(cells.length).to eq(4)
    end

    it 'is a hash of cell coordinates' do
        cells = CellGenerator.new.cells

        expect(cells).to be_an_instance_of(Hash)
        expect(cells["A1"]).to be_an_instance_of(Cell)
    end

    it 'contains 16 key value pairs' do
        cells = CellGenerator.new.cells
        expect(cells.length).to eq(16)
    end
end
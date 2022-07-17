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
      computer = Computer.new

      computer.place_ships(computer.cruiser, ["A1", "A2", "A3"])
      computer.place_ships(computer.submarine, ["B1", "B2"])

      expect(computer.board.cells["A1"].ship).to eq(computer.cruiser)
      expect(computer.board.cells["A2"].ship).to eq(computer.cruiser)
      expect(computer.board.cells["A3"].ship).to eq(computer.cruiser)
      expect(computer.board.cells['B3'].empty?).to eq(true)
      expect(computer.place_ships(computer.submarine, ["B3", "B2"])).to eq("Invalid coordinates try again")
    end

    it 'can generate random valid ship placements' do
      computer = Computer.new
      50.times do
      expect(computer.board.valid_placement?(
              computer.cruiser,
              computer.random_computer_ship_placement(computer.cruiser))).to eq(true)
      end
    end
      
end
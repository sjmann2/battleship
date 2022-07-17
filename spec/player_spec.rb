require "./lib/board"
require "./lib/ship"
require "./lib/cell"
require "./lib/game"
require "./lib/cell_generator"

describe Player do
    it 'exists' do
        player = Player.new

        expect(player).to be_instance_of(Player)
    end
end
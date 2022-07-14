require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'

describe Game do
  it 'exists' do
    game = Game.new

    expect(game).to be_instance_of(Game)
  end

  it 'automatically generate new ships and board' do
    game = Game.new

    expect(game.cruiser_player).to be_instance_of(Ship)
    expect(game.cruiser_computer).to be_instance_of(Ship)
    expect(game.submarine_player).to be_instance_of(Ship)
    expect(game.submarine_computer).to be_instance_of(Ship)
    expect(game.board).to be_instance_of(Board)
  end


  it 'can place ships' do
    game = Game.new

    #Initialization- both sides place ships
    game.place_ships_player(game.cruiser_player, ['A1', 'A2', 'A3'])
    game.place_ships_player(game.submarine_player, ['B1', 'B2'])
    expect(game.board.cells['A1'].ship).to eq(game.cruiser_player)
    expect(game.board.cells['A2'].ship).to eq(game.cruiser_player)
    expect(game.board.cells['A3'].ship).to eq(game.cruiser_player)
    # expect(game.board.cells['B3'].empty?).to eq(true)
    expect(game.place_ships_player(game.submarine_player, ['B3', 'B2'])).to eq('Invalid coordinates try again')
    
  end




  xit 'places ships on board for both sides' do
    game = Game.new
    #game initialization automatically create cruiser and sub with empty arrays
    game.place_ships_player(cruiser, ['A1', 'A2', 'A3'])
    #make the ship class object cruiser
    game.place_ships_player(submarine, ['B1', 'B2'])


    game.place_ships_computer(cruiser, ['A1', 'A2', 'A3'])
    game.place_ships_computer(submarine, ['B1', 'B2'])

    #player board to show ships place and computer ships are present with true value
    expect()
    
    #Turn - both sides input their shots and get feedback on those shots
    #Turn is repeated until End Game conditions are met
    #End Game all ships are sunk by one side

    expect()
  end
    #Feedback on shots
  xit 'gives feedback on shots' do
    game = Game.new
    game.place_ships_player
    game.place_ships_computer

  end
end



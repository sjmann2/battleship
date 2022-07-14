require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'

describe Game do
  it 'exists' do
    game = Game.new

    expect(game).to be_instance_of(Game)
  end

  it 'automatically generate new ships' do
    game = Game.new

    expect(game.cruiser_player).to be_instance_of(Ship)
    expect(game.cruiser_computer).to be_instance_of(Ship)
    expect(game.submarine_player).to be_instance_of(Ship)
    expect(game.submarine_computer).to be_instance_of(Ship)
  end


  xit 'has turns' do
    game = Game.new

    #Initialization- both sides place ships
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



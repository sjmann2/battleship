class Cell
  attr_reader :coordinate,
              :ship,
              :shot_at

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @shot_at = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship_instance)
    @ship = ship_instance
  end

  def fired_upon?
    @shot_at
  end

  def fire_upon
    if @shot_at == true
    else
      @shot_at = true
      if !empty?
        @ship.hit
      end
    end
  end

  def render(see_ships = false)
    if empty? == false && @shot_at == true && @ship.sunk? == false
      "H"
      #if there is a ship, it has been shot at but hasn't been sunk
    elsif empty? == false && see_ships == true && @shot_at == false
      "S"
      #if there is a ship, see ships is true, hasn't been shot at
    elsif empty? == false && @shot_at == true && @ship.sunk? == true
      "X"
      #if there's a ship, it has been shot at and it has been sunk
    elsif empty? == true && @shot_at == true
      "M"
      #if there's no ship, has been shot at
    elsif @shot_at == false
      "."
      #if it's empty and hasn't been shot at
    end
  end
end

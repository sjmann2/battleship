class Cell
    attr_reader :coordinate,
                :ship
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
        @ship.health < @ship.length && @ship.health >= 0
    end

    def fire_upon
        if @shot_at == true
        elsif
            @shot_at = true
            if !empty? 
                @ship.hit
            end
        end
    end
    
    def render(see_ships = false)
        # Comment out about what each scenario means for furth condensing
        if empty? == true && see_ships == false && @shot_at == false
            "."
        elsif empty? == false && see_ships == true && @shot_at == false
            "S"
        elsif empty? == true && see_ships == true && @shot_at == false
            "."
        elsif empty? == false && see_ships == false && @shot_at == false
            "."
        elsif empty? == true && @shot_at == true
            "M"
        elsif empty? == false && @shot_at == true && @ship.sunk? == false
            "H"
        elsif empty? == false && @shot_at == true && @ship.sunk? == true
            "X"
        else
            "Something went wrong!!"
        end
    end
        

end
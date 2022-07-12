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
        @ship.health != @ship.length
    end

    def fire_upon
        unless @shot_at == true
        end
        @shot_at = true
        if !empty? 
            @ship.hit
        end
    end
        
end
class Cell
    attr_reader :coordinate,
                :ship
    def initialize(coordinate)
        @coordinate = coordinate
        @ship = ship
    end

    def empty?
        @ship == nil
    end

    def place_ship(ship_instance)
        @ship = ship_instance
    end
end
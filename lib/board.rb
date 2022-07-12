class Board
    attr_reader :cells

    def initialize
        @cells =
                   { 
                    "A1" => cell_1 = Cell.new("A1"),
                    "A2" => cell_2 = Cell.new("A2"),
                    "A3" => cell_3 = Cell.new("A3"),
                    "A4" => cell_4 = Cell.new("A4"),
                    "B1" => cell_5 = Cell.new("B1"),
                    "B2" => cell_6 = Cell.new("B2"),
                    "B3" => cell_7 = Cell.new("B3"),
                    "B4" => cell_8 = Cell.new("B4"),
                    "C1" => cell_9 = Cell.new("C1"),
                    "C2" => cell_10 = Cell.new("C2"),
                    "C3" => cell_11 = Cell.new("C3"),
                    "C4" => cell_12 = Cell.new("C4"),
                    "D1" => cell_13 = Cell.new("D1"),
                    "D2" => cell_14 = Cell.new("D2"),
                    "D3" => cell_15 = Cell.new("D3"),
                    "D4" => cell_16 = Cell.new("D4")

                }
    
    end

    def valid_coordinate?(coordinate)
        @cells.keys.include?(coordinate)
    end

    def valid_placement?(ship_instance, coordinate_array)
        


end
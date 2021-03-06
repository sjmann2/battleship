class CellGenerator
  attr_reader :width,
              :height

  def initialize(width = 4, height = 4)
    @width = width
    @height = height
  end

  def cells
    column = (1..@width).to_a
    row = ("A"..(("A".ord + @height - 1).chr)).to_a
    #We want "A".."D"
    #change number(height) into letter
    #if height = 4, turn 4 into letter D
    #ordinal value of A = 65, so 65 + width 4-1 = 68
    #68 back into a character = D
    #Turn all of it back into an array
    column
      .map { |num| row.map { |letter| letter + num.to_s } }
      .flatten!
      .map { |coordinate| [coordinate, Cell.new(coordinate)] }
      .to_h
  end
end

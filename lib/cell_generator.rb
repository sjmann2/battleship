class CellGenerator
  attr_reader :length,
              :width

  def initialize(length = 4, width = 4)
    @length = length
    @width = width
  end

  def cells
    @width = (1..@width).to_a
    @length = ("A"..(("A".ord + @length - 1).chr)).to_a
    #We want "A".."D"
    #change number(length) into letter
    #if length = 4, turn 4 into letter D
    #ordinal value of A = 65, so 65 + length 4-1 = 68
    #68 back into a character = D
    #Turn all of it back into an array
    @width
      .map { |num| @length.map { |letter| letter + num.to_s } }
      .flatten!
      .map { |coordinate| [coordinate, Cell.new(coordinate)] }
      .to_h

    # coordinates =
    #     numbers.map do |number|
    #         letters.map do |letter|
    #             letter + number.to_s
    #         end
    #     end
    #     coordinates.flatten!
  end
end

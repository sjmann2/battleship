class CellGenerator
  attr_reader :length,
              :height

  def initialize(length = 4, height = 4)
    @length = length
    @height = height
  end

  def cells
    @length = (1..@length).to_a
    @height = ("A"..(("A".ord + @height - 1).chr)).to_a
    #We want "A".."D"
    #change number(height) into letter
    #if height = 4, turn 4 into letter D
    #ordinal value of A = 65, so 65 + length 4-1 = 68
    #68 back into a character = D
    #Turn all of it back into an array
    @length
      .map { |num| @height.map { |letter| letter + num.to_s } }
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

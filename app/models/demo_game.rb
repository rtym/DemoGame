require 'matrix'

class DemoGame
  def initialize matrix = nil
    unless matrix.blank?
      @matrix = matrix
    else
      @matrix = Array.new(8) { Array.new(8) { Random.rand COLORS.size } }
    end
  end

  def get_colors
    @matrix.collect { |row| row.collect { |element| COLORS[element] } }
  end
end

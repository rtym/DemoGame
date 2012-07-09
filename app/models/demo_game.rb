require 'matrix'

class DemoGame
  def initialize rows = nil
    unless rows.blank?
      @matrix = Matrix.[] rows
    else
      @matrix = Matrix.zero(8).collect { | element | Random.rand COLORS.size }
    end
  end

  def get_colors
    @matrix.collect{ |element| COLORS[element] }
  end
end

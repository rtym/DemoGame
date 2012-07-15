require 'matrix'

class DemoGame
  def initialize matrix = nil
    unless matrix.blank? || matrix.size != GAME_SIZE
      @matrix = matrix
    else
      @matrix = Array.new(GAME_SIZE) { Array.new(GAME_SIZE) { Random.rand COLORS.size } }
    end
  end

  def get_matrix
    @matrix
  end

  def get_colors
    @matrix.collect { |row| row.collect { |element| COLORS[element] } }
  end

  def get_strategy row, column
    strategy = :none

    horizontal_count = 1
    vertical_count = 1

    #check to the left
    counter = column - 1

    while counter >= 0 && @matrix[row][counter] == @matrix[row][column]
      horizontal_count += 1
      counter -= 1
    end

    #check to the right
    counter = column + 1

    while counter < @matrix.size && @matrix[row][counter] == @matrix[row][column]
      horizontal_count += 1
      counter += 1
    end

    #check to the top
    counter = row - 1

    while counter >= 0 && @matrix[counter][column] == @matrix[row][column]
      vertical_count += 1
      counter -= 1
    end

    #check to the bottom
    counter = row + 1

    while counter < @matrix.size && @matrix[counter][column] == @matrix[row][column]
      vertical_count += 1
      counter += 1
    end

    strategy = :vertical if vertical_count >= ACCEPTABLE_LENGTH && vertical_count >= horizontal_count
    strategy = :horizontal if horizontal_count >= ACCEPTABLE_LENGTH && horizontal_count > vertical_count

    strategy
  end

  def play row, column
    row = row.to_i
    column = column.to_i

    strategy = get_strategy row, column

    destroy_block_vertical(row, column) if strategy == :vertical
    destroy_block_horizontal(row, column) if strategy == :horizontal
  end

  private

  def destroy_block_vertical row, column
    to = from = row

    #get from
    counter = row - 1

    while counter >= 0 && @matrix[counter][column] == @matrix[row][column]
      from -= 1
      counter -= 1
    end

    #get to
    counter = row + 1

    while counter < @matrix.size && @matrix[counter][column] == @matrix[row][column]
      to += 1
      counter += 1
    end

    reassign_vertical column, from, to
  end

  def destroy_block_horizontal row, column
    to = from = column

    #get from
    counter = column - 1

    while counter >= 0 && @matrix[row][counter] == @matrix[row][column]
      from -= 1
      counter -= 1
    end

    #get to
    counter = column + 1

    while counter < @matrix.size && @matrix[row][counter] == @matrix[row][column]
      to += 1
      counter += 1
    end

    reassign_horizontal row, from, to
  end

  def reassign_vertical column, from, to
    length = to - from + 1

    for counter in 0..to do
      @matrix[counter + length][column] = @matrix[counter][column] if counter < from
      @matrix[counter][column] = Random.rand(COLORS.size) if counter <= length
    end
  end

  def reassign_horizontal row, from, to
    counter = row

    while counter > 0
      for counter1 in from..to do
        @matrix[counter][counter1] = @matrix[counter - 1][counter1]
      end

      counter -= 1
    end

    for counter in from..to do
      @matrix[0][counter] = Random.rand(COLORS.size)
    end
  end
end

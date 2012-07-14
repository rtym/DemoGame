require 'matrix'

class DemoGame
  def initialize matrix = nil
    unless matrix.blank? || matrix.size != GAME_SIZE
      @matrix = matrix
    else
      @matrix = Array.new(GAME_SIZE) { Array.new(GAME_SIZE) { Random.rand COLORS.size } }
    end

    @horizontal = generate_horizontal
  end

  def get_matrix
    @matrix
  end

  def get_colors
    @matrix.collect { |row| row.collect { |element| COLORS[element] } }
  end

  def check row_number, column_number
    #horizontal_check
    count_horizontal = 1

    #check to the left
    counter = column_number - 1
    while counter >= 0 && @matrix[row_number][counter] == @matrix[row_number][column_number] do
      counter -= 1
      count_horizontal += 1
    end

    #check to the right
    counter = column_number + 1
    while counter < @matrix.size && @matrix[row_number][counter] == @matrix[row_number][column_number] do
      counter += 1
      count_horizontal += 1
    end

    #vertical_check
    count_vertical = 1

    #check to the top
    counter = row_number - 1
    while counter >= 0 && @matrix[counter][column_number] == @matrix[row_number][column_number] do
      counter -= 1
      count_vertical += 1
    end

    #check to the bottom
    counter = row_number + 1
    while counter < @matrix.size && @matrix[counter][column_number] == @matrix[row_number][column_number] do
      counter += 1
      count_vertical += 1
    end

    count_vertical >= ACCEPTABLE_LENGTH || count_horizontal >= ACCEPTABLE_LENGTH
  end

  private

  def initialize_array size, value = 0
    Array.new(size) { Array.new(GAME_SIZE) { value } }
  end

  def generate_horizontal sequence_size = 3
    result = initialize_array GAME_SIZE, false

    @matrix.each_with_index do |row, counter1|
      row.each_with_index do |element, counter2|

      end
    end

    result
  end
end

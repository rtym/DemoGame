module RootHelper
  def matrix_to_hash matrix
    result = {}

    matrix.each_with_index do |row, counter1|
      row_hash = {}

      row.each_with_index do |element, counter2|
        row_hash[counter2] = element
      end

      result[counter1] = row_hash
    end

    result
  end
end

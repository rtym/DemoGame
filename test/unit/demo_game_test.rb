require 'test_helper'

class DemoGameTest < ActiveSupport::TestCase
  setup do
    test_matrix = [
        [0, 1, 2, 2, 2, 0, 2, 0],
        [2, 0, 0, 1, 1, 2, 2, 0],
        [1, 1, 1, 0, 2, 0, 2, 2],
        [1, 1, 1, 1, 0, 2, 2, 0],
        [1, 0, 0, 1, 2, 1, 2, 0],
        [2, 1, 0, 2, 1, 0, 2, 1],
        [0, 1, 2, 0, 1, 2, 0, 1],
        [2, 2, 1, 0, 2, 2, 1, 0]
    ]

    @game = DemoGame.new test_matrix
  end

  test "check default size" do
    game_matrix = @game.get_matrix
    key = game_matrix.size == GAME_SIZE

    game_matrix.each do |element|
      key = element.size == GAME_SIZE
      break unless key
    end if key

    assert key, "size of matrix differs from the game size"
  end

  test "check if all elements are colors" do
    key = false

    @game.get_colors.each do |color_group|
      key = color_group - COLORS == []
      break unless key
    end

    assert key, "game matrix contains unknown colors"
  end

  test "check strategy" do
    assert @game.get_strategy(0, 0) == :none
    assert @game.get_strategy(0, 2) == :horizontal
    assert @game.get_strategy(7, 5) == :none
    assert @game.get_strategy(2, 2) == :horizontal
    assert @game.get_strategy(3, 1) == :horizontal
    assert @game.get_strategy(2, 6) == :vertical
  end

end

require 'test_helper'

class DemoGameTest < ActiveSupport::TestCase
  setup do
    @game = DemoGame.new
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
end

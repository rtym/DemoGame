class RootController < ApplicationController
  def index
    @game = DemoGame.new.get_colors
  end
end

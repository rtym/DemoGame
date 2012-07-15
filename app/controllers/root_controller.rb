class RootController < ApplicationController
  def index
    unless params[:matrix].blank?
      @game = DemoGame.new convert_hash_to_matrix(JSON.parse(params[:matrix]))
    else
      @game = DemoGame.new
    end

    @game.play(params[:horizontal], params[:vertical]) unless params[:play].blank?
  end

  private

  def convert_hash_to_matrix hash = nil
    hash.keys.sort_by {|key| key.to_i}.map{|key| convert_hash_to_array(hash[key])} unless hash.nil?
  end

  def convert_hash_to_array hash = nil
    hash.keys.sort_by {|key| key.to_i}.map{|key| hash[key].to_i} unless hash.nil?
  end
end

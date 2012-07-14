class RootController < ApplicationController
  def index
    @game = DemoGame.new convert_hash_to_matrix(params[:matrix])
  end

  private

  def convert_hash_to_matrix hash = nil
    hash.keys.sort_by {|key| key.to_i}.map{|key| convert_hash_to_array(hash[key])} unless hash.nil?
  end

  def convert_hash_to_array hash = nil
    hash.keys.sort_by {|key| key.to_i}.map{|key| hash[key].to_i} unless hash.nil?
  end
end

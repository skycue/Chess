require_relative "piece.rb"
require_relative "slideable.rb"

class Rook < Piece
  include Slideable

  # def initialize(color, board, pos)
  #   super
  # end

  def move_dirs
    "horizontal"
  end

  def symbol
    "R"
  end
end

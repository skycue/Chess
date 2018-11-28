require_relative "piece.rb"
require_relative "stepable.rb"

class Knight < Piece
  include Stepable

  def symbol
    "H"
  end

  def move_diffs
    return [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
  end

end

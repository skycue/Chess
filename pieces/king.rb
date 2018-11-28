require_relative "piece.rb"
require_relative "stepable.rb"

class King < Piece

  include Stepable

  def symbol
    "K"
  end

  def move_diffs
    return [[1,0], [-1, 0], [0, 1], [0, -1], [1,1], [1,-1], [-1,1], [-1, -1]]
  end

end

require_relative "../board.rb"

class Piece

  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def valid_moves
    possible_moves = moves
    possible_moves.reject do |move|
      dup_board = board.dup
      dup_board.move_piece!(pos, move)
      dup_board.in_check?(color)
    end
  end

  def inspect
    symbol
  end

  def symbol
    " "
  end

  def to_s
    symbol
  end

  def empty?
    is_a?(NullPiece)
  end

  def moves
  end

end

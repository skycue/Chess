require_relative "pieces.rb"

class Board

  attr_accessor :rows

  def initialize
    @rows = Array.new(8) { Array.new(8) { NullPiece.instance } }
    setup_board
  end

  def setup_board
    setup_rows = [0, 1, 6, 7]
    piece_rows = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    setup_rows.each do |i|
      color = (i == 0 || i == 1) ? :black : :white
      piece_rows.each_with_index do |piece, j|
        if i == 1 || i == 6
          add_piece(Pawn, color, [i,j])
        else
          add_piece(piece, color, [i,j])
        end
      end
    end
  end

  def add_piece(piece, color, pos)
    self[pos] = piece.new(color, self, pos)
  end

  def move_piece(start_pos, end_pos)
    move_piece!(start_pos, end_pos) if self[start_pos].valid_moves.include?(end_pos)
  end

  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]
    raise "There is no piece at the selected position." if piece.empty?
    raise "Invalid move." unless self[end_pos].empty?

    self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
  end

  def [](pos)
    x, y = pos
    rows[x][y]
  end

  def []=(pos, value)
    x, y = pos
    rows[x][y] = value
  end

  def valid_pos?(pos)
    pos.all? {|i| i >= 0 && i <= 7}
  end

  def in_check?(color)
    king_pos = nil
    rows.each do |row|
      row.each do |piece|
        if piece.is_a?(King) && piece.color == color
          king_pos = piece.pos
        end
      end
    end
    opp_color = (color == :white ? :black : :white)
    pieces = find_all_pieces(opp_color)
    pieces.any? { |piece| piece.moves.include?(king_pos) }
  end

  def checkmate?(color)
    if in_check?(color)
      pieces = find_all_pieces(color)
      return pieces.all? { |piece| piece.valid_moves.empty? }
    end
    false
  end

  def find_all_pieces(color)
    pieces = []

    rows.each do |row|
      row.each do |piece|
        pieces << piece if piece.color == color
      end
    end

    pieces
  end

  def dup
    dup_board = Board.new
    dup_board.rows = []
    rows.each do |row|
      dup_row = []
      row.each do |piece|
        if piece.is_a?(NullPiece)
          dup_row << piece
        else
          dup_row << piece.class.new(piece.color, dup_board, piece.pos)
        end
      end
      dup_board.rows << dup_row
    end
    dup_board
  end

end

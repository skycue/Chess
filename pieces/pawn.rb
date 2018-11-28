require_relative "piece.rb"

class Pawn < Piece

  def symbol
    "P"
  end

  def moves
    forward_steps + side_attacks
  end

  def at_start_row?
    return true if (color == :white && pos.first == 6) || (color == :black && pos.first == 1)
    false
  end

  def forward_dir
    return -1 if color == :white
    return 1
  end

  def forward_steps
    forward_one = [forward_dir + pos.first, pos.last]
    steps = board.valid_pos?(forward_one) ? [forward_one] : []
    steps << [(forward_dir * 2) + pos.first, pos.last] if at_start_row?
  end

  def side_attacks
    dir = [[1, 1], [1, -1]]
    real_dir = dir.map {|dir_pos| [forward_dir + pos.first, dir_pos.last + pos.last]}
    real_dir.select! {|position| board.valid_pos?(position)}
    real_dir.reject {|position| board[position].empty?}
  end
end

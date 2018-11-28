module Stepable

  def moves
    diffs = move_diffs
    diffs.map! {|diff| [diff.first + pos.first, diff.last + pos.last]}
    diffs.select!{|pos| board.valid_pos?(pos)}
    diffs.select {|pos| board[pos].empty?}
  end

  # overwritten in implementations
  def move_diffs
    raise "move_diffs unimplemented in subclass."
  end
end

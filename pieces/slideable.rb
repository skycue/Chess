module Slideable
  HORIZONTAL_DIRS = [[0, 1], [0, -1], [1, 0], [-1, 0]]
  DIAGONAL_DIRS = [[1, 1], [1, -1], [-1, 1], [-1, -1]]

  def moves
    possible_moves = [horizontal_dirs, diagonal_dirs]
    case move_dirs
    when "both"
      return possible_moves.first + possible_moves.last
    when "horizontal"
      return possible_moves.first
    when "diagonal"
      return possible_moves.last
    end
  end

  def move_dirs
    raise "move_dirs unimplemented in subclass."
  end

  def horizontal_dirs
    horizontal_moves = []
    HORIZONTAL_DIRS.each do |dir|
      horizontal_moves += grow_unblocked_moves_in_dir(dir.first, dir.last)
    end
    horizontal_moves
  end

  def diagonal_dirs
    diagonal_moves = []
    DIAGONAL_DIRS.each do |dir|
      diagonal_moves += grow_unblocked_moves_in_dir(dir.first, dir.last)
    end
    diagonal_moves
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    moves_in_dir = []
    i, j = self.pos
    new_pos = [i + dx, j + dy]
    while self.board.valid_pos?(new_pos) && board[new_pos].empty?
      moves_in_dir << new_pos
      x, y = new_pos
      new_pos = [x + dx, y + dy]
    end
    moves_in_dir
  end
end

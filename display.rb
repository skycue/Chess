require "colorize"
require_relative "cursor.rb"
require_relative "board.rb"

class Display

  attr_reader :board, :cursor

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def render
    horizontal = "----" * 8 + "-"
    display_rows = [horizontal]
    board.rows.each_with_index do |row, i|
      row_str = ""
      row.each_with_index do |piece, j|
        disp = piece.nil? ? " " : piece.to_s
        if cursor.cursor_pos == [i, j]
          disp = "*" if disp == " "
          disp = cursor.selected ? disp.red : disp.yellow
        end
        row_str += "| " + disp + " "
      end
      row_str += "|"
      display_rows << row_str
      display_rows << horizontal
    end
    display_rows.each {|row| puts row}

    nil
  end

  def move_around
    while true
      system("clear")
      render
      cursor.get_input
    end
  end

end

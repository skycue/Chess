require_relative 'board'
require_relative 'player'
require_relative 'display'

class Game
  attr_reader :board, :display, :current_player, :players

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @current_player = :white
    @players = {
      white: Player.new(:white, @display),
      black: Player.new(:black, @display)
    }
  end

  def play
    until board.checkmate?(current_player)
      display.render

      start_pos, end_pos = players[current_player].make_move(board)
      board.move_piece(start_pos, end_pos, current_player)

      change_turn!
    end

    display.render
    puts "#{current_player} is in check."
  end

  private

  def change_turn!
    @current_player = current_player == :white ? :black : :white
  end
end

if $PROGRAM_NAME == __FILE__
  Game.new.play
end

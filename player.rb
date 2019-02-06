class Player
  attr_reader :color, :display

  def initialize(color, display)
    @color = color
    @display = display
  end

  def make_move(board)
    start_pos, end_pos = nil, nil

    until start_pos && end_pos

      if start_pos
        puts "This is #{color}'s turn. To where would you like to move it?"
        end_pos = display.cursor.get_input

        display.reset! if end_pos
      else
        puts "This is #{color}'s turn. Which piece would you like to move?"
        start_pos = display.cursor.get_input

        display.reset! if start_pos
      end
    end

    [start_pos, end_pos]
  end
end

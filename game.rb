class Game
  def initialize(initial_height)
    @initial_height = initial_height
    @line_width = 21
    @space = '  |  '
    @ring1 = '  0  '
    @ring2 = ' 000 '
    @ring3 = '00000'
    @pegs = [[@ring3, @ring2, @ring1], [], []]
  end

  def play
    welcome_player
    build_rings
    display_board

    until player_won?
      display_board(request_moves)
    end

    render_win_message
  end

end

game = Game.new(3)
game.play



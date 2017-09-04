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

  private

  def welcome_player
    puts "--------------------------"
    puts "Welcome to Tower of Hanoi!"
    puts "--------------------------"
    puts "Instructions:"
    puts "Moving each disc one at a time, move the stack"
    puts "of discs from peg 1 to peg 3."
    puts ""
    puts "Discs can only be placed on an empty peg or on"
    puts "a disc that is larger than itself."
    puts ""
    puts "Your finished board should look like this:"
    puts ""
    puts render_disc(@space) + render_disc(@space) + render_disc(@ring1)
    puts render_disc(@space) + render_disc(@space) + render_disc(@ring2)
    puts render_disc(@space) + render_disc(@space) + render_disc(@ring3)
    puts '-' * @line_width
    puts '1'.center(@line_width/3) + '2'.center(@line_width/3) + '3'.center(@line_width/3)
    puts ""
    puts "Enter 'q' to quit at any time."
    puts ""
    puts "================================================"
    puts ""
  end



  def player_won?
    @pegs == [[], [], [@ring3, @ring2, @ring1]]
  end

  def render_win_message
    puts "Congratulations! You won!"
  end



end

game = Game.new(3)
game.play



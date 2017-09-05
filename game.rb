class Game
  def initialize(initial_height)
    @initial_height = initial_height
    @pegs = [[RING3, RING2, RING1], [], []]
  end

  def play
    welcome_player
    display_board
    display_board(request_moves) until player_won?
    render_win_message
  end

  private

  LINE_WIDTH = 21
  SPACE = '  |  '
  RING1 = '  0  '
  RING2 = ' 000 '
  RING3 = '00000'

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
    puts render_disc(SPACE) + render_disc(SPACE) + render_disc(RING1)
    puts render_disc(SPACE) + render_disc(SPACE) + render_disc(RING2)
    puts render_disc(SPACE) + render_disc(SPACE) + render_disc(RING3)
    puts '-' * LINE_WIDTH
    puts '1'.center(LINE_WIDTH/3) + '2'.center(LINE_WIDTH/3) + '3'.center(LINE_WIDTH/3)
    puts ""
    puts "Enter 'q' to quit at any time."
    puts ""
    puts "================================================"
    puts ""
  end

  def render_disc(location)
    if location
      location.center(LINE_WIDTH/3)
    else
      SPACE.center(LINE_WIDTH/3)
    end
  end

  def request_moves
    moves = []
    puts "Select the peg of the disc you want to move:    Enter 'q' to quit."
    input = gets.chomp
    exit_game if input.downcase == 'q'
    moves << input
    puts "Select the destination peg. (Must be empty or contain a larger disc):    Enter 'q' to quit."
    input = gets.chomp
    exit_game if input.downcase == 'q'
    moves << input
    moves
  end

  def display_board(moves = [])
    if moves
      from = moves[0].to_i
      to = moves[1].to_i
      @pegs[to -1] << @pegs[from -1].pop
      @pegs = @pegs.map(&:compact)
    end
    puts ""
    puts ""
    puts ""
    puts ""
    puts "Your Current Board:"
    puts ""
    puts render_disc(@pegs[0][2]) + render_disc(@pegs[1][2]) + render_disc(@pegs[2][2])
    puts render_disc(@pegs[0][1]) + render_disc(@pegs[1][1]) + render_disc(@pegs[2][1])
    puts render_disc(@pegs[0][0]) + render_disc(@pegs[1][0]) + render_disc(@pegs[2][0])
    puts '-' * LINE_WIDTH
    puts '1'.center(LINE_WIDTH/3) + '2'.center(LINE_WIDTH/3) + '3'.center(LINE_WIDTH/3)
  end

  def player_won?
    @pegs == [[], [], [RING3, RING2, RING1]]
  end

  def render_win_message
    puts "Congratulations! You won!"
  end

  def exit_game
    puts "Good bye."
    exit
  end

end

game = Game.new(3)
game.play



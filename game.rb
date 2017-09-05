require_relative 'ascii_art'

class Game
  def initialize(qty_rings)
    @qty_rings = qty_rings
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
    puts AsciiArt::TITLE
    continue_or_quit
    puts "-" * 46
    puts "INSTRUCTIONS:"
    puts "-" * 46
    puts "Moving each disc one at a time, move the stack"
    puts "of discs from the peg on the left (1) to the"
    puts "peg on the right (3).", ""
    puts "Discs can only be placed on an empty peg or on"
    puts "a disc that is larger than itself.", ""
    puts "Your finished board should look like this:", ""
    puts render_disc(SPACE) + render_disc(SPACE) + render_disc(RING1)
    puts render_disc(SPACE) + render_disc(SPACE) + render_disc(RING2)
    puts render_disc(SPACE) + render_disc(SPACE) + render_disc(RING3)
    puts '-' * LINE_WIDTH
    puts '1'.center(LINE_WIDTH/3) + '2'.center(LINE_WIDTH/3) + '3'.center(LINE_WIDTH/3)
    puts "", "=" * 46, ""
    continue_or_quit
  end

  def continue_or_quit
    puts "Hit the 'Enter' key to continue."
    puts "Enter 'q' to quit at any time."
    response = gets.chomp
    exit_game if response == 'q'
    clear_screen
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
    puts "", "Select the peg of the disc you want to move:    Enter 'q' to quit."
    input = gets.chomp
    exit_game if input.downcase == 'q'
    moves << input
    puts "", "Select the destination peg. (Must be empty or contain a larger disc):    Enter 'q' to quit."
    input = gets.chomp
    exit_game if input.downcase == 'q'
    moves << input
    moves
  end

  def display_board(moves = [])
    clear_screen
    if moves
      from_index = (moves[0].to_i) -1
      to_index = (moves[1].to_i) -1
      @pegs[to_index] << @pegs[from_index].pop
      @pegs = @pegs.map(&:compact)
    end
    puts "Your Current Board:", ""
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
    clear_screen
    puts AsciiArt::WIN
  end

  def exit_game
    clear_screen
    puts AsciiArt::CAT
    puts "kthxbai."
    exit
  end

  def clear_screen
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

end

game = Game.new(3)
game.play

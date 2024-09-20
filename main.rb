require_relative 'lib/human_player'
require_relative 'lib/computer_player'

class Game
  COLOURS = ["", " red  ", " blue ", "green ", " pink ", " navy ", "orange", "yellow", "white ", "black "] #index starts at 1 to make it easier

  def initialize
    puts "Hi"
  end

  def play
    p COLOURS
  end

  def win?
  end

  def is_exact_match?
  end

  def is_fuzzy_match?
  end

  def print_board
  end
end

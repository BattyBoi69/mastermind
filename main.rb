require_relative 'lib/human_player'
require_relative 'lib/computer_player'

class Game
  COLOURS = ["", " red  ", " blue ", "green ", " pink ", " navy ", "orange",
             "yellow", "white ", "black "] #index starts at 1
  MAX_TURNS = 12
  WINNING_SCORE = "++++"
  @@colours_trimmed = COLOURS.map{ |colour| colour.strip }

  def initialize(player_1_class, player_2_class)
    @mastermind = player_1_class.new(self)
    @guesser = player_2_class.new(self)
  end
  attr_reader :secret, :board

  def self.colours_trimmed
    @@colours_trimmed
  end

  def play
    
    puts "Begin Mastermind, the game. Here are the available colours:\n"
    puts @@colours_trimmed[1..-1]
    puts "\nLet the game begin:\n\n"

    @board = Array.new(MAX_TURNS)
    @secret = @mastermind.choose_secret
    @turn = 1
    until @turn > MAX_TURNS do
      guess = @guesser.make_guess
      score = score(guess)
      @board[@turn-1] = {guess:, score:}
      if win?(score)
        puts "Congrats, you won!"
        break
      end
      
      print_board if @guesser.is_a?(HumanPlayer)
      @turn += 1 
    end

    print_board
    puts "\nend of game"
  end

  def score(guess)
    score = ""
    guess_collected = Hash.new { |hash, key| hash[key] = [] }
    guess.each_with_index{ |entry, ind| guess_collected[entry].push(ind) }

    guess_collected.each_pair do |colour, index_list|
      if is_fuzzy_match?(colour)
        exact_list = index_list.filter{ |ind| is_exact_match?(colour,ind) }
        if exact_list.length > 0
          exact_list.length.times{ score.concat("+") }
        else
          score.concat("o")
        end
      end
    end
    score.ljust(4, "-")
  end

  def win?(score)
    score == WINNING_SCORE
  end

  def is_exact_match?(colour_index, index)
    @secret[index] == colour_index
  end

  def is_fuzzy_match?(colour_index)
    @secret.any?(colour_index)
  end

  def print_board
    col_separator  = " | "
    row_separator =   "----+" + ("--------+" * 4) + "------"
    board = "Turn|Guess   " + ("         " * 3) + "|Score \n"
    @board.compact.length.times do |i|
      turn = (i+1).to_s.rjust(3) + col_separator
      guess = @board[i][:guess].map{ |g| COLOURS[g] }.join(col_separator)
      score = col_separator + @board[i][:score] + " \n"
      board << row_separator + "\n" + turn + guess + score
    end
    puts board << row_separator
  end
end

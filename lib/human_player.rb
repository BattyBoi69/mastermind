require_relative 'player'

class HumanPlayer < Player
  def choose_secret
    puts "Choose secret code for the other player to guess:"
    request_code
  end

  def make_guess
    request_code
  end

  def request_code
    guess = []
    for i in 1..4
      puts "Type the colour in slot #{i}:"
      ith_guess = ""
      while Game.colours_trimmed[1..-1].none?(ith_guess)
        ith_guess = gets.chomp
      end
      puts i
      guess[i-1] = Game.colours_trimmed.index(ith_guess)
    end
    guess
  end
end

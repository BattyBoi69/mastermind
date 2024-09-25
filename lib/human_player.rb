require_relative 'player'

class HumanPlayer < Player
  def make_guess
    super
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

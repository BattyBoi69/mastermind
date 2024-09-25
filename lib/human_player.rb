require_relative 'player'

class HumanPlayer < Player
  def make_guess
    super
    guess = []
    4.times do |i|
      puts "Type the colour in slot #{i}:"
      loop do
        ith_guess = gets.chomp
        break unless @@colours_trimmed[1..-1].none?(ith_guess)
      end
      guess[i-1] = @@colours_trimmed.index(ith_guess)
    end
    guess
  end
end

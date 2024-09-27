require_relative 'player'

class ComputerPlayer < Player
  def initialize(game)
    super(game)
    @space = Array.new(9**4).each_with_index.map do |_, i|
      i.digits(9).map{ |j| j + 1 }.concat([1,1,1]).take(4)
    end
  end
  attr_accessor :space
  
  def make_guess
    puts "SPACE:"
    p @space[0..10]
    p @space[-10..-1]
    puts "\n"
    game_board = @game.board.compact
    return random_code(4) if game_board.length <= 1

    persistent = persistent_colours
    num_of_persistent = persistent.length
    num_of_hits = game_board[-1][:score].delete("-").length

    num_of_psample = [num_of_persistent, num_of_hits].min
    num_of_hsample = num_of_hits - num_of_psample
    num_of_miss = 4 - num_of_hits

    guess = random_code(num_of_miss)
    num_of_psample.times{ guess << persistent.sample }
    num_of_hsample.times{ guess << game_board[-1][:guess].sample }
    guess.shuffle
  end

  def choose_secret
    random_code(4)
  end

  def random_code(n)
    code = []
    n.times{code << Array(1..9).sample}
    code
  end

  def persistent_colours
    game_board = @game.board.compact
    return [] if game_board.length < 2
    recent_guess = game_board[-1][:guess]

    recent_guess.filter{ |ith| game_board[-2][:guess].include?(ith) }
  end

end

require_relative 'player'

class ComputerPlayer < Player
  def make_guess
    game_board = @game.board.compact
    return [1, 1, 1, 1] if game_board.length == 0
    return random_code(4) if game_board.length == 1
    
    persistent = persistent_colours
    num_of_persistent = persistent.length
    num_of_hits = game_board[-1][:score].delete("-").length
    num_of_miss = 4 - num_of_hits

    guess = random_code(num_of_miss)
    num_of_hits.times{ guess << game_board[-1][:guess].sample }
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

    recent_guess.select{ |ith| game_board[-2][:guess].contains(ith) }
  end
   
end

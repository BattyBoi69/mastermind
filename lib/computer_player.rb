require_relative 'player'

class ComputerPlayer < Player
  WORST_SCORE = "----"

  def initialize(game)
    super(game)
    @space = Array.new(9**4).each_with_index.map do |_, i|
      i.digits(9).map{ |j| j + 1 }.concat([1,1,1]).take(4)
    end
    @banned_colours = []
  end
  attr_accessor :space

  def make_guess
    game_board = @game.board.compact

    return @space.sample if game_board.length <= 0
    
    if game_board[-1][:score] == WORST_SCORE
      remove_prev_guess
      return @space.sample
    end

    #persistent  = persistents().reject{ |c| @banned_colours.include?(c) }
    guess_space = @space 
    guess_space.sample
  end

  def choose_secret
    random_code(4)
  end

  def random_code(n)
    code = []
    n.times{code << Array(1..9).sample}
    code
  end

  def persistents
    game_board = @game.board.compact
    return [] if game_board.length < 2
    recent_guess = game_board[-1][:guess]

    recent_guess.filter{ |ith| game_board[-2][:guess].include?(ith) }
  end

  def remove_prev_guess
    prev_guess = @game.board.compact[-1][:guess].uniq
    prev_guess.each do |colour|
      @space.reject!{ |pattern| pattern.include?(colour) }
    end
    @banned_colours.concat(prev_guess).uniq!
  end


end

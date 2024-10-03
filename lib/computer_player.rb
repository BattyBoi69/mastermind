require_relative 'player'
require_relative 'enumerable_extensions'

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

    return @space.sample if game_board.length <= 1

    p game_board
    case misses(game_board[-1][:score])
    when 1
      filter_triples
    when 2, 3
      filter_prev_guess
    when 4
      remove_prev_guess
    end
    p @space.length
    p @space if @space.length < 9
    @space.sample
  end

  def choose_secret
    random_code(4)
  end

  def random_code(n)
    code = []
    n.times{code << Array(1..9).sample}
    code
  end

  def remove_prev_guess
    prev_guess = @game.board.compact[-1][:guess].uniq
    prev_guess.each do |colour|
      @space.reject!{ |pattern| pattern.include?(colour) }
    end
    @banned_colours.concat(prev_guess).uniq!
  end

  def filter_prev_guess
    prev_guess = @game.board.compact[-1][:guess].uniq
    new_space = []
    prev_guess.each{ |colour| new_space.concat(filter_colour(colour)) }
    @space = new_space.uniq
  end

  def filter_colour(colour)
    @space.filter{ |pattern| pattern.include?(colour) }
  end

  def misses(score)
    score.count "-"
  end

  def filter_triples
    prev_guess = @game.board.compact[-1][:guess].uniq
    prev_guess.repeated_combination(3) do |combination|
      filter_specific(*combination)
    end
  end

  def filter_specific(c1, c2, c3)
    @space.filter! do |pattern|
      pattern.reject_first(c1)
        .reject_first(c2)
        .reject_first(c3)
        .length == 1
    end
  end

end

require_relative 'player'
require_relative 'enumerable_extensions'

class ComputerPlayer < Player
  WORST_SCORE = '----'.freeze

  def initialize(game)
    super
    @space = Array.new(@n_colours**4).each_with_index.map do |_, i|
      i.digits(@n_colours).map { |j| j + 1 }.push(1, 1, 1).take(4)
    end
  end
  attr_accessor :space

  def make_guess
    game_board = @game.board.compact

    return @space.sample if game_board.empty?

    @space.delete(game_board[-1][:guess]) # remove current guess

    hits = 4 - misses(game_board[-1][:score])
    if hits.zero?
      remove_prev_guess
    elsif hits < 4
      filter_guess(hits)
    elsif hits == 4
      @space = filter_specific(game_board[-1][:guess])
    end
    @space.sample
  end

  def choose_secret
    random_code(4)
  end

  def random_code(n)
    code = []
    n.times { code << Array(1..@n_colours).sample }
    code
  end

  def remove_prev_guess
    prev_guess = @game.board.compact[-1][:guess].uniq
    prev_guess.each do |colour|
      @space.reject! { |pattern| pattern.include?(colour) }
    end
  end

  def misses(score)
    score.count '-'
  end

  def filter_guess(hits)
    prev_guess = @game.board.compact[-1][:guess].uniq
    space_temp = []
    prev_guess.repeated_combination(hits) do |combination|
      space_temp.concat(filter_specific(combination))
    end
    @space = space_temp.uniq
  end

  def filter_specific(combination)
    combi_size = combination.length
    @space.filter do |pattern|
      combination.reduce(pattern) do |leftovers, colour|
        leftovers.reject_first(colour)
      end.length == 4 - combi_size
    end
  end
end

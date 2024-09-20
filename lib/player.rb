class Player
  def initialize(game)
    @game = game
  end

  def make_guess
    @game.print_board
  end
end

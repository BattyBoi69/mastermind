require_relative 'player'

class ComputerPlayer < Player
  def choose_secret
    secret = []
    4.times{secret << Array(1..9).sample}
    secret
  end
end

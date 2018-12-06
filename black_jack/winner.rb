class Winner

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
  end

  def determine_winner
    return :draw if draw?
    return :black_jack if black_jack?
    return :dealer_win if dealer_win?
    return :player_win if player_win?
    return :player_win if @player.score > @dealer.score

    :dealer_win
  end

  private

  def black_jack?
    @player.score == 21
  end

  def draw?
    @player.score == @dealer.score
  end

  def player_win?
    @dealer.score > 21
  end

  def dealer_win?
    @player.score > 21
  end
end


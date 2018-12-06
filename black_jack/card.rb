class Card

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def picture?
    ["J", "Q", "K"].include?(@rank)
  end

  def ace?
    @rank == "A"
  end

  def full_name
    "#{rank}#{suit}"
  end
end

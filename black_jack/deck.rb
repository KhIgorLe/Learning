require_relative 'card'

class Deck
  RANK = %w(2 3 4 5 6 7 8 9 10 J Q K A).freeze
  SUITS = %w(♥ ♦ ♣ ♠).freeze

  attr_reader :cards

  def initialize
    @cards = build
  end

  def get_cards(count)
    @cards.pop(count)
  end

  private

  def build
    cards = []
    RANK.each do |rank|
      SUITS.each do |suit|
        cards << Card.new(rank, suit)
      end
    end
    cards.shuffle!
  end
end

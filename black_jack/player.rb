require_relative 'bank'

class Player
  attr_reader :name, :cards, :bank

  def initialize(name = "Dealer")
    @name = name
    @cards = []
    @bank = create_bank
  end

  def set_cards(cards)
    @cards.concat(cards)
  end

  def reset_cards
    @cards.clear
  end

  def score
    @cards.inject(0) do |sum, card|
      sum + points(sum, card)
    end
  end

  def exceeded_points?
    score > 21
  end

  def black_jack?
    score == 21
  end

  def score_board
    puts "#{@name} cards: #{@cards.map(&:full_name).join(" ")}"
    puts "#{@name} score: #{score}"
    puts "#{@name} money: #{cash}"
  end

  def cash
    @bank.cash
  end

  def set_cash(cash)
    @bank.cash -= cash
  end

  def get_cash(cash)
    @bank.cash += cash
  end

  private

  def points(sum, card)
    return 10 if card.picture?
    return sum < 11 ? 11 : 1 if card.ace?

    card.rank.to_i
  end

  def create_bank
    Bank.new(100)
  end
end

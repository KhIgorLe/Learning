require_relative 'deck'
require_relative 'winner'

class Round

  ROUND_MENU = <<-MENU.freeze
    Select a menu item:
    Enter 1 - Pass
    Enter 2 - Add a card
    Enter 3 - Show cards
  MENU

  def initialize(player, dealer)
    @deck = deck
    @player = player
    @dealer = dealer
    @bank = create_bank
  end

  def start
    set_cards

    rate

    @player.score_board
    puts "#" * 25
    show_star

    action

    who_win

    score_board

    reset_cards
  end

  private

  def action
    command = ""
    while command != 3
      break if need_open_cards?
      puts ROUND_MENU
      command = gets.to_i
      case command
      when 1 then dealer_action
      when 2 then player_action
      when 3 then break
      else
        puts "Command is entered incorrectly."
      end
    end
  end

  def who_win
    result = winner.determine_winner
    send(result)
  end

  def black_jack
    puts "Black Jack"
    player_win
  end

  def dealer_win
    @dealer.get_cash(20)
    puts "Game result: Dealer win"
  end

  def player_win
    @player.get_cash(20)
    puts "Game result: Player win"
  end

  def draw
    @player.get_cash(10)
    @dealer.get_cash(10)
    puts "Game result: Draw"
  end

  def rate
    @bank.cash += 20
    @player.set_cash(10)
    @dealer.set_cash(10)
  end

  def need_open_cards?
    cards_count? || @player.exceeded_points? || @dealer.exceeded_points? || black_jack?
  end

  def black_jack?
    @player.black_jack? || @dealer.black_jack?
  end

  def cards_count?
    (@dealer.score > 16 || @dealer.cards.size > 2) && @player.cards.size > 2
  end

  def dealer_action
    if @dealer.score > 16 || @dealer.cards.size > 2
      puts "Dealer missed the move"
      return
    end

    @dealer.set_cards(cards(1))
    show_star
    score_board if black_jack?
  end

  def player_action
    return if @player.cards.size != 2

    @player.set_cards(cards(1))
    dealer_action if @player.score < 21
  end

  def show_star
    stars = "*" * @dealer.cards.size
    puts "Dealer cards: #{stars}"
  end

  def score_board
    puts ""
    puts "Total information:"
    @player.score_board
    puts "#" * 25
    @dealer.score_board
  end

  def winner
    Winner.new(@player, @dealer)
  end

  def cards(count)
    @deck.get_cards(count)
  end

  def set_cards
    @player.set_cards(cards(2))
    @dealer.set_cards(cards(2))
  end

  def reset_cards
    @player.reset_cards
    @dealer.reset_cards
  end

  def deck
    Deck.new
  end

  def create_bank
    Bank.new
  end
end

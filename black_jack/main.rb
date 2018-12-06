require_relative 'player'
require_relative 'round'

class Main

  BET = 10.freeze

  MAIN_MENU = <<-MENU.freeze
    Select a menu item:
    Enter 1 - Deal cards
    Enter 0 - Exit
  MENU

  def initialize
    @player = player
    @dealer = dealer
  end

  def run
    puts round_action
  end

  private

  def round_action
    command = ''
    while command != 0 && @player.cash >= BET && @dealer.cash >= BET
      puts MAIN_MENU
      command = gets.to_i
      case command
      when 1 then round.start
      when 0 then break
      else
        puts 'Command is entered incorrectly'
      end
    end
    return "You run out of money" if @player.cash < BET
    return "You win, come again" if @dealer.cash < BET
    "See you later"
  end

  def player
    puts "Enter your name"
    name = gets.chomp
    Player.new(name)
  end

  def dealer
    Player.new
  end

  def round
    Round.new(@player, @dealer)
  end
end

Main.new.run
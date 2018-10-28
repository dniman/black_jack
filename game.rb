# frozen_string_literal: true

require './players'

# BlackJack
class Game
  include Players

  attr_accessor :bank
  attr_reader :stake

  def initialize(stake = 10)
    @bank = 0
    @stake = stake
  end

  def start
    ask_name
    loop do
      reset_values!
      game_logic
      break unless repeat?
    end
  end

  def game_logic
    deal_cards
    user.move = true
    while any_move?
      puts show_info
      player_actions
    end
    calc_results
  end

  def ask_name
    print 'Enter your name: '
    user.name = gets.chomp
  end

  def reset_values!
    self.bank = 0
    user.cards.clear
    dealer.cards.clear
  end

  def deal_cards
    dealer.deck.shuffle!
    players.each do |player|
      dealer.deal(player, 2)
      player.bank -= stake
      self.bank += stake
    end
  end

  def show_info
    clear_screen
    dealer_info = any_move? ? dealer.info : dealer.info(true)
    ["Game bank: #{bank}$", user.info, dealer_info, '']
  end

  def player_actions
    user_actions if current_player.is_a?(User)
    dealer_actions if current_player.is_a?(Dealer)
  end

  def calc_results
    puts show_info
    congrat_with_win if user.win?(dealer)
    congrat_with_lose if user.lose?(dealer)
    congrat_with_tie if user.tied_score?(dealer)
  end

  def repeat?
    print 'Play again? [yes/no]: '
    return true if gets.chomp =~ /^[Yy]$/

    false
  end

  def clear_screen
    system('clear')
  end
end

# frozen_string_literal: true

require 'forwardable'
require './game'

# Terminal interface
class TerminalInterface
  extend Forwardable

  def_delegators :@game, :bank, :user, :dealer, :any_move?
  def_delegators :@game, :reset_values!, :deal_cards, :current_player
  def_delegators :@game, :user_win?, :user_lose?, :tied_score?

  attr_reader :game

  def initialize(game)
    @game = game
  end

  def start_game
    ask_name
    loop do
      reset_values!
      game_logic
      break unless repeat?
    end
  end

  def ask_name
    print 'Enter your name: '
    user.name = gets.chomp
  end

  def game_logic
    deal_cards
    user.move = true
    while any_move?
      show_info
      player_actions
    end
    show_results
  end

  def repeat?
    print 'Play again? [yes/no]: '
    return true if gets.chomp =~ /^[Yy]$/

    false
  end

  def show_info
    clear_screen
    dealer_info = any_move? ? dealer.info : dealer.info(true)
    puts ["Game bank: #{bank}$", user.info, dealer_info, '']
  end

  def player_actions
    user_actions if current_player.is_a?(User)
    dealer_actions if current_player.is_a?(Dealer)
  end

  def user_actions
    puts 'Your move. What will you do?'
    puts '  1. Pass a move'
    puts '  2. Take a card'
    puts '  3. Reveal cards'
    print 'Choose an action 1/2/3: '
    select_action(gets.chomp.to_i)
  end

  def select_action(action)
    case action
    when 1 then
      user.pass_move(dealer)
    when 2 then
      user.take_card(dealer)
      user.pass_move(dealer)
    else
      user.reveal_cards
    end
  end

  def dealer_actions
    dealer.take_card(dealer)
    dealer.pass_move(user)
    dealer.reveal_cards
  end

  def show_results
    show_info
    congrat_with_win if user_win?
    congrat_with_lose if user_lose?
    congrat_with_tie if tied_score?
  end

  def congrat_with_win
    puts 'Congratulations! You win!'
    user.bank += bank
  end

  def congrat_with_lose
    puts 'Sorry. You lose. Try again'
    dealer.bank += bank
  end

  def congrat_with_tie
    puts 'Tied score'
    user.bank += stake
    dealer.bank += stake
  end

  def clear_screen
    system('clear')
  end
end

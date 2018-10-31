# frozen_string_literal: true

require './user'
require './dealer'
require './game/winners_rules'

# BlackJack
class Game
  include WinnersRules

  attr_accessor :bank
  attr_reader :client, :stake

  def initialize(client, stake = 10)
    @client = client
    @bank = 0
    @stake = stake
  end

  def start_game
    user.name = client.ask_name
    loop do
      reset_values!
      game_logic
      break unless repeat?
    end
  end

  def reset_values!
    self.bank = 0
    players.each { |player| player.cards.clear }
  end

  def game_logic
    deal_cards
    user.move = true
    while any_move?
      show_info
      players_actions
    end
    show_results
  end

  def repeat?
    client.repeat_message
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
    client.clear_screen
    dealer_info = any_move? ? dealer.info : dealer.info(true)
    client.puts_message ["Game bank: #{bank}$", user.info, dealer_info, '']
  end

  def players_actions
    user_actions if current_player.is_a?(User)
    dealer_actions if current_player.is_a?(Dealer)
  end

  def user_actions
    select_action(client.ask_action)
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
    client.puts_message 'Congratulations! You win!'
    user.bank += bank
  end

  def congrat_with_lose
    client.puts_message 'Sorry. You lose. Try again'
    dealer.bank += bank
  end

  def congrat_with_tie
    client.puts_message 'Tied score'
    user.bank += stake
    dealer.bank += stake
  end

  def user
    @user ||= User.new
  end

  def dealer
    @dealer ||= Dealer.new
  end

  def current_player
    players.detect(&:move)
  end

  def players
    [user, dealer]
  end

  def any_move?
    current_player ? true : false
  end

  # rules for winner definition
  module WinnersRules
    # rubocop:disable Metrics/AbcSize
    def user_win?
      (user.score > dealer.score && user.score <= 21) ||
        (user.score < dealer.score && dealer.score > 21)
    end
    # rubocop:enable Metrics/AbcSize

    def user_lose?
      (user.score > 21 && dealer.score <= 21) ||
        (user.score < dealer.score && dealer.score <= 21)
    end

    def tied_score?
      user.score == dealer.score
    end
  end
end

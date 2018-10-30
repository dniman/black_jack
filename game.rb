# frozen_string_literal: true

require './user'
require './dealer'

# BlackJack
class Game
  attr_accessor :bank
  attr_reader :stake

  def initialize(stake = 10)
    @bank = 0
    @stake = stake
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

  def any_move?
    return true if current_player

    false
  end

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

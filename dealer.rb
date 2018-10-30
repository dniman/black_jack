# frozen_string_literal: true

require './player'
require './deck'

# Diler
#
class Dealer < Player
  def deal(gamer, qty = 1)
    qty.times { gamer.cards << deck.shift }
  end

  def deck
    @deck ||= Deck.new
  end

  def pass_move(player)
    return unless score >= 17 || is_a?(player.class)

    super
  end

  def take_card(dealer)
    super if score < 17
  end

  def reveal_cards
    super if cards.count == 3
  end

  def name
    self.class.name
  end
end

# frozen_string_literal: true

require './player'

# Diler
#
class Dealer
  include Player 

  def deal(gamer, qty)
    qty.times { gamer.cards << deck.shift }
  end

  def deck
    @deck ||= Deck.new
  end

  def pass_move(player)
    return unless (self.score >= 17 ||  self.is_a?(player.class))
    super
  end
end

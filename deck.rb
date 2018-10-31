# frozen_string_literal: true

require 'forwardable'
require './card'

# Deck for BlackJack
class Deck
  extend Forwardable
  def_delegators :@cards, :<<, :length, :shift

  CARD_RANKS = 2..14

  attr_reader :cards

  def initialize(cards = [])
    @cards = cards
    return unless cards.empty?

    CARD_RANKS.each do |rank|
      Card::SUITS.each do |suit|
        cards << Card.new(rank, suit)
      end
    end
  end

  def shuffle
    Deck.new(cards.shuffle)
  end

  def shuffle!
    self.cards = cards.shuffle!
    self
  end

  protected

  attr_writer :cards
end

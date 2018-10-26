# frozen_string_literal: true

require 'forwardable'
require './card'

# Deck for BlackJack
class Deck
  extend Forwardable
  def_delegators :@cards, :<<, :length, :shift

  CARD_RANKS = 2..14
  CARD_SUITS = %W[\u{2661} \u{2662} \u{2664} \u{2667}].freeze

  attr_reader :cards

  def initialize(cards = [])
    @cards = cards
    return unless cards.empty?

    CARD_RANKS.each do |rank|
      CARD_SUITS.each do |suit|
        cards << Card.new(rank, suit)
      end
    end
  end

  def shuffle
    Deck.new(cards.shuffle)
  end
end

# frozen_string_literal: true

require './validation'

# Card from the deck
class Card
  include Validation
  attr_reader :rank, :suit

  SUITS = %W[\u{2661} \u{2662} \u{2664} \u{2667}].freeze

  validate :rank, :presence
  validate :rank, :type, Integer
  validate :rank, :range, 1..14
  validate :suit, :presence
  validate :suit, :presence_in_array, SUITS

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    validate!
  end

  def nominal
    return 10 if rank > 10 && rank < 14
    return 11 if rank == 14

    rank
  end

  def ace?
    rank == 14
  end

  def to_s
    case rank
    when 11 then "J#{suit}"
    when 12 then "Q#{suit}"
    when 13 then "K#{suit}"
    when 14 then "A#{suit}"
    else
      "#{rank}#{suit}"
    end
  end
end

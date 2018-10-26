# frozen_string_literal: true

# Card from the deck
class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
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

# frozen_string_literal: true

# BlackJack player
#
class Player
  attr_accessor :bank, :move
  attr_writer :score

  def initialize
    @bank = 100
    @score = 0
    @move = false
  end

  def cards
    @cards ||= []
  end

  def score
    calc_score
  end

  def calc_score
    self.score = cards.inject(0) do |sum, card|
      sum += card.ace? && (card.nominal + sum) > 21 ? 1 : card.nominal
      sum
    end
  end

  def pass_move(player)
    self.move = false
    player.move = true
  end

  def take_card(dealer)
    dealer.deal(self, 1)
  end

  def reveal_cards
    self.move = false
  end

  def win?(player)
    (score > player.score && score <= 21) ||
      (score < player.score && player.score > 21)
  end

  def lose?(player)
    (score > 21 && player.score <= 21) ||
      (score < player.score && player.score <= 21)
  end

  def tied_score?(player)
    score == player.score
  end

  def info(visible = false)
    "\e[4m#Player\e[0m: #{name_format} - #{bank_format}\t\
        Cards: #{cards_format(visible)}\t\
        Score: #{score_format(visible)}"
  end

  protected

  def name_format
    name.ljust(15, ' ')
  end

  def bank_format
    bank.to_s.concat('$').ljust(4, ' ')
  end

  def stars
    Array.new(cards.count, '*').join(' ').ljust(15, ' ')
  end

  def cards_format(visible)
    visible ? cards.join(' ').ljust(15, ' ') : stars
  end

  def score_format(visible)
    visible ? score : '??'
  end
end

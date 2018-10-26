# frozen_string_literal: true

# BlackJack player
#
module Player
  attr_accessor :bank, :score, :name, :move

  def initialize
    @bank = 100
    @score = 0
  end

  def cards
    @cards ||= []
  end

  def calc_score
    self.score = cards.inject(0) do |sum, card|
      sum += card.ace? && (card.nominal + sum) > 21 ? 1 : card.nominal
    end
  end

  def pass_move(player)
    self.move = false
    player.move = true
  end
          
  def take_card(dealer)
    dealer.deal(self, 1)
    calc_score
    pass_move(dealer)
  end


end

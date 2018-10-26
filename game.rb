# frozen_string_literal: true

# BlackJack
class Game
  attr_accessor :bank
  attr_reader :stake

  def initialize(stake = 10)
    @bank = stake * 2
    @stake = stake
  end

  def start
    print 'Enter your name: '
    user.name = gets.chomp

    [user, dealer].each do |player|
      dealer.deal(player)
      player.calc_score
      player.bank -= stake
    end

    set_move(user)
 end

  def user
    @user ||= User.new
  end

  def dealer
    @dealer ||= Dealer.new
  end

  private

  def set_move(player)
    dealer.move = false if player.is_a?(User)
    user.move = false if player.is_a?(Dealer)
    player.move = true
  end
end

# frozen_string_literal: true

require './player'

# BlackJack user
class User
  include Player 

  attr_accessor :bank, :score, :name

  def initialize
    @bank = 100
    @score = 0
  end
end

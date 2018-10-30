# frozen_string_literal: true

require './player'

# BlackJack user
class User < Player
  attr_accessor :name

  def info(visible = true)
    super
  end
end

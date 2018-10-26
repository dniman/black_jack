# frozen_string_literal: true

require './game'

system('clear')
puts File.read('bj.txt')

game = Game.new
game.start

# frozen_string_literal: true

require './terminal_interface'

system('clear')
puts File.read('bj.txt')

game = Game.new
ui = TerminalInterface.new(game)
ui.start_game

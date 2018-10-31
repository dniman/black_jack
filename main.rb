# frozen_string_literal: true

require './game/'
require './game/terminal_interface'

system('clear')
puts File.read('bj.txt')

# game = Game.new
# ui = TerminalInterface.new(game)
# ui.start_game

ui = Game::TerminalInterface.new
game = Game.new(ui)
game.start_game

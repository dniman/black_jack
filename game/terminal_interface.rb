# frozen_string_literal: true

class Game
  # Terminal interface
  class TerminalInterface
    EXIT_REGEX = /^[Yy]$/

    def print_message(message)
      print message
    end

    def puts_message(message)
      puts message
    end

    def ask_name
      print_message 'Enter your name: '
      gets.chomp
    end

    def repeat_message
      print_message 'Play again? [yes/no]: '
      return true if gets.chomp =~ EXIT_REGEX

      false
    end

    def clear_screen
      system('clear')
    end

    def ask_action
      puts_message 'Your move. What will you do?'
      puts_message '  1. Pass a move'
      puts_message '  2. Take a card'
      puts_message '  3. Reveal cards'
      print_message 'Choose an action 1/2/3: '
      gets.chomp.to_i
    end
  end
end

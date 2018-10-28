# frozen_string_literal: true

require './user'
require './dealer'

# Module Players
module Players
  def user_actions
    puts 'Your move. What will you do?'
    puts '  1. Pass a move'
    puts '  2. Take a card'
    puts '  3. Reveal cards'
    print 'Choose an action 1/2/3: '
    select_action(gets.chomp.to_i)
  end

  def select_action(action)
    case action
    when 1 then
      user.pass_move(dealer)
    when 2 then
      user.take_card(dealer)
      user.pass_move(dealer)
    else
      user.reveal_cards
    end
  end

  def dealer_actions
    dealer.take_card(dealer)
    dealer.pass_move(user)
    dealer.reveal_cards
  end

  def congrat_with_win
    puts 'Congratulations! You win!'
    user.bank += bank
  end

  def congrat_with_lose
    puts 'Sorry. You lose. Try again'
    dealer.bank += bank
  end

  def congrat_with_tie
    puts 'Tied score'
    user.bank += stake
    dealer.bank += stake
  end

  def any_move?
    return true if current_player

    false
  end

  def current_player
    players.detect(&:move)
  end

  def players
    [user, dealer]
  end

  def user
    @user ||= User.new
  end

  def dealer
    @dealer ||= Dealer.new
  end
end

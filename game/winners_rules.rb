# frozen_string_literal: true

class Game
  # rules for winner definition
  module WinnersRules
    # rubocop:disable Metrics/AbcSize
    def user_win?
      (user.score > dealer.score && user.score <= 21) ||
        (user.score < dealer.score && dealer.score > 21)
    end
    # rubocop:enable Metrics/AbcSize

    def user_lose?
      (user.score > 21 && dealer.score <= 21) ||
        (user.score < dealer.score && dealer.score <= 21)
    end

    def tied_score?
      user.score == dealer.score
    end
  end
end

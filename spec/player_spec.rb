# frozen_string_literal: true

require './player'
require './card'
require './user'
require './dealer'

class DummyClass
  include Player
end

RSpec.describe Player do
  describe '#calc_score' do
    context 'when 2 two aces' do
      it 'should return 12' do
        dc = DummyClass.new
        dc.cards << Card.new(14, "\u{2661}")
        dc.cards << Card.new(14, "\u{2662}")

        expect(dc.calc_score).to eq(12)
      end
    end

    context 'when two 10 cards and one ace' do
      it 'should return 21' do
        dc = DummyClass.new
        dc.cards << Card.new(10, "\u{2661}")
        dc.cards << Card.new(10, "\u{2662}")
        dc.cards << Card.new(14, "\u{2661}")

        expect(dc.calc_score).to eq(21)
      end
    end
  end

  describe "#pass_move" do
    context "when player is a User" do
      it "should pass the move to Dealer" do
        user = User.new
        dealer = Dealer.new
        user.pass_move(dealer)
        expect(user.move).to be_falsey
        expect(dealer.move).to be_truthy
      end
    end

    context "when player is a Dealer" do
      context "when score is greater or equal 17" do
        it "should pass the move to User" do
          user = User.new
          dealer = Dealer.new
          dealer.cards << Card.new(10, "\u{2661}")
          dealer.cards << Card.new(7, "\u{2661}")
          dealer.calc_score
          user.move = false
          dealer.move = true

          dealer.pass_move(user)
          expect(user.move).to be_truthy
          expect(dealer.move).to be_falsey
        end
      end

      context "when score is less then 17" do
        it "should nothing to do" do
          user = User.new
          dealer = Dealer.new
          dealer.cards << Card.new(10, "\u{2661}")
          dealer.cards << Card.new(6, "\u{2661}")
          dealer.calc_score
          user.move = false
          dealer.move = true

          dealer.pass_move(user)
          expect(user.move).to be_falsey
          expect(dealer.move).to be_truthy
        end
      end
    end
  end

  describe "#take_card" do
    context "when player is a User" do
      context "and user cards count equal 2" do
        it "cards count should equal 3" do
          user = User.new
          dealer = Dealer.new
          user.cards << Card.new(10, "\u{2661}")
          user.cards << Card.new(10, "\u{2662}")

          user.take_card(dealer)
          expect(user.cards.length).to eq(3)
        end

        it "should recalculate score's sum" do
          user = User.new
          dealer = Dealer.new
          user.cards << Card.new(10, "\u{2661}")
          user.cards << Card.new(10, "\u{2661}")
          score = user.calc_score               

          user.take_card(dealer)
          expect(user.score).to be > score 
        end

        it "should pass move to dealer" do
          user = User.new
          dealer = Dealer.new
          user.cards << Card.new(10, "\u{2661}")
          user.cards << Card.new(10, "\u{2662}")

          user.take_card(dealer)
          expect(user.move).to be_falsey
          expect(dealer.move).to be_truthy
        end
      end
    end
  end
end

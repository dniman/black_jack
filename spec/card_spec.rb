# frozen_string_literal: true

require './card'

RSpec.describe Card do
  describe '#nominal' do
    context 'when rank <= 10' do
      it 'should return 10' do
        card = Card.new(10, "\u{2661}")
        expect(card.nominal).to eq(10)
      end
    end

    context 'when rank > 10 and rank < 14' do
      it 'should return 10' do
        card = Card.new(11, "\u{2661}")
        expect(card.nominal).to eq(10)
      end
    end

    context 'when rank == 14' do
      it 'should return 11' do
        card = Card.new(14, "\u{2661}")
        expect(card.nominal).to eq(11)
      end
    end
  end

  describe '#ace?' do
    it 'should return true' do
      card = Card.new(14, "\u{2661}")
      expect(card.ace?).to be_truthy
    end

    it 'should return false' do
      card = Card.new(1, "\u{2661}")
      expect(card.ace?).to be_falsy
    end
  end
end

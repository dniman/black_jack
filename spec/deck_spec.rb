# frozen_string_literal: true

require 'spec_helper'
require './deck'

describe Deck do
  describe '#shuffle' do
    it { is_expected.to respond_to(:shuffle) }

    it 'should be an instance of Deck' do
      shuffled_subject = subject.shuffle.class
      expect(shuffled_subject).to eq(subject.class)
    end
  end

  it { is_expected.to respond_to(:<<) }

  describe '#length' do
    it 'should respond to #length' do
      expect(subject).to respond_to(:length)
    end

    it 'should return 52 cards' do
      expect(subject.length).to eq(52)
    end
  end

  it { is_expected.to respond_to(:shift) }
end

# frozen_string_literal: true

require 'spec_helper'
require './deck'

describe Deck do
  describe '#shuffle' do
    it 'should be an instance of Deck' do
      shuffled_subject = subject.shuffle.class
      expect(shuffled_subject).to eq(subject.class)
    end

    it 'should have another object_id' do
      id = subject.object_id
      expect(subject.shuffle.object_id).not_to eq(id)
    end
  end

  describe '#shuffle!' do
    it 'should have the same object_id' do
      id = subject.object_id
      expect(subject.shuffle!.object_id).to eq(id)
    end
  end

  it { is_expected.to respond_to(:<<) }

  describe '#length' do
    it 'should return 52 cards' do
      expect(subject.length).to eq(52)
    end
  end

  it { is_expected.to respond_to(:shift) }
end

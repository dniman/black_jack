require 'spec_helper'
require 'forwardable'

class Deck
  extend Forwardable

  def_delegators :@cards, :shuffle, :<<

  def initialize
    @cards = []
  end
end

describe Deck do
  describe "respond to #shuffle" do
    it { is_expected.to respond_to(:shuffle) }
  end
  
  describe "should respond to #<<" do
    it { is_expected.to respond_to(:<<) }
  end
end

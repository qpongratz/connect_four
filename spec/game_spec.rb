# frozen_string_literal: true

require 'game'
require 'player'
require 'board'

describe Game do
  subject(:game) { described_class.new }
  describe '#make_players' do
    it 'Players contains two objects' do
      game.make_players
      length = game.players.length
      expect(length).to eq(2)
    end
    it 'Player class recieves message to make new' do
      allow(Player).to receive(:new)
      expect(Player).to receive(:new).twice
      game.make_players
    end
  end
end
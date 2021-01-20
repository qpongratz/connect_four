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
  describe '#turn' do
    let(:board) { instance_double(Board) }
    let(:player) { instance_double(Player) }
    before do
      game.instance_variable_set(:@players, [player, player])
      game.instance_variable_set(:@board, board)
    end
    context 'Board is not full' do
      before do
        allow(board).to receive(:full?).and_return(false)
        allow(board).to receive(:winner?).and_return(false, true)
        allow(player).to receive(:move)
      end
      it 'Send board to current player' do
        expect(player).to receive(:move)
        game.turn
      end
      it 'Ask board if there is a winner' do
        expect(board).to receive(:winner?).twice
        game.turn
      end
      it 'Send #winner to self if board.winner? is true' do
        expect(game).to receive(:winner).once
        game.turn
      end
    end
    context 'Board is full' do
      before do
        allow(board).to receive(:full?).and_return(true)
      end
      it 'Send #tie to self' do
        expect(game).to receive(:tie).once
        game.turn
      end
      it 'Does not send board to current player' do
        expect(player).not_to receive(:move)
        game.turn
      end
    end
  end

end
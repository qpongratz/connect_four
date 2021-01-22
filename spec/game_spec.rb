# frozen_string_literal: true

require 'game'
require 'display'

describe Game do
  subject(:game) { described_class.new }
  describe '#make_players' do
    before do
      allow(game).to receive(:puts)
    end
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
    let(:next_player) { instance_double(Player) }
    before do
      game.instance_variable_set(:@players, [player, next_player])
      game.instance_variable_set(:@board, board)
      allow(game).to receive(:puts)
      allow(board).to receive(:board_state).and_return([[1, 1], [2, 2], [], [], [], [], []])
      allow(board).to receive(:board_height).and_return(6)
      allow(game).to receive(:print)
    end
    context 'Board is not full' do
      before do
        allow(board).to receive(:full?).and_return(false)
        allow(board).to receive(:winner?).and_return(false, true)
        allow(player).to receive(:move)
        allow(next_player).to receive(:move)
      end
      it 'Send board to current player' do
        expect(next_player).to receive(:move)
        game.turn
      end
      context 'Winner after two turns' do
        it 'Each player gets a move' do
          expect(player).to receive(:move).once
          expect(next_player).to receive(:move).once
          game.turn
        end
        it 'Winner is pinged twice' do
          expect(board).to receive(:winner?).twice
          game.turn
        end
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
        expect(next_player).not_to receive(:move)
        game.turn
      end
    end
  end
  describe 'Display.board' do
    context 'Board is empty' do
    end
  end

end
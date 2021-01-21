# frozen_string_literal: true

require 'player'

describe Player do
  subject(:player) { described_class.new(1) }
  let(:board) { instance_double(Board) }
  describe '#move' do
    context 'Move is valid on board' do
      before do
        allow(board).to receive(:move)
        allow(board).to receive(:valid_move?).and_return(true)
        allow(player).to receive(:input)
      end
      it 'Gets input from #input' do
        expect(player).to receive(:input)
        player.move(board)
      end
      it 'Sends input to board' do
        expect(board).to receive(:move)
        player.move(board)
      end
    end
    context 'Move is invalid on board and then valid' do
      before do
        allow(board).to receive(:move)
        allow(board).to receive(:valid_move?).and_return(false, true)
        allow(player).to receive(:input)
      end
      it 'Gets input from #input twice' do
        expect(player).to receive(:input).twice
        player.move(board)
      end
      it 'Sends input to board after an invalid move first' do
        expect(board).to receive(:move).once
        player.move(board)
      end
    end
  end
  describe '#input' do
    let(:valid_input) { '4' }
    let(:invalid_input) { '17' }
    before do
      allow(player).to receive(:puts)
    end
    it 'Return input when input is valid' do
      allow(player).to receive(:gets).and_return(valid_input)
      result = player.input
      expect(result).to eq(valid_input)
    end
    it 'Return valid input to board when inputting one invalid and then a valid move' do
      allow(player).to receive(:gets).and_return(invalid_input, valid_input)
      result = player.input
      expect(result).to eq(valid_input)
    end
  end
end

# frozen_string_literal: true

require 'player'

describe Player do
  subject(:player) { described_class.new(1) }
  let(:board) { instance_double(Board) }
  describe '#move' do
    before do
      allow(board).to receive(:move)
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
  describe '#input' do
    let(:valid_input) {'4'}
    let(:invalid_input) {'17'}
    it 'return input when input is valid' do
      allow(player).to receive(:gets).and_return(valid_input)
      result = player.input
      expect(result).to eq(valid_input)
    end
    it 'not return input when input is invalid' do
      allow(player).to receive(:gets).and_return(invalid_input)
      result = player.input
      expect(result).not_to eq(invalid_input)
    end
  end
end
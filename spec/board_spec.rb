# frozen_string_literal: true

require 'board'

describe Board do
  subject(:board) { described_class.new }

  describe '#initialize' do
    context 'Board is created' do
      it 'board_state length is 7' do
        length = board.board_state.length
        width = board.board_width
        expect(length).to eq(width)
      end
    end
  end

  describe '#valid_move?' do
    context 'Column is empty' do
      it 'Returns true' do
        result = board.valid_move?(1)
        expect(result).to be true
      end
    end
    context 'Column is full' do
      before do
        full_column = Array.new(board.board_height)
        full_board_state = Array.new(board.board_width, full_column)
        allow(board).to receive(:board_state).and_return(full_board_state)
      end
      it 'Returns false' do
        result = board.valid_move?(1)
        expect(result).to be false
      end
    end
  end
end

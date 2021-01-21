# frozen_string_literal: true

require 'board'

describe Board do
  subject(:board) { described_class.new }

  describe '#initialize' do
    context 'Board is created' do
      it 'Board_state length is board width' do
        length = board.board_state.length
        width = board.board_width
        expect(length).to eq(width)
      end
      it 'Initial height of columns is 0' do
        column = board.board_state[0]
        height = column.length
        expect(height).to be_zero
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
    context 'Column is  almost full' do
      before do
        partially_full_column = Array.new(board.board_height - 1)
        full_board_state = Array.new(board.board_width, partially_full_column)
        allow(board).to receive(:board_state).and_return(full_board_state)
      end
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

  describe '#full?' do
    let(:full_column) { Array.new(board.board_height) }
    let(:fake_board_state) { [] }
    context 'Board is initialized' do
      it 'Returns false' do
        result = board.full?
        expect(result).to be false
      end
    end
    context 'One column is full' do
      before do
        fake_board_state << full_column
        (board.board_width - 1).times { fake_board_state << [] }
        allow(board).to receive(:board_state).and_return(fake_board_state)
      end
      xit 'Returns false' do
        result = board.full?
        expect(result).to be false
      end
    end
    context 'All but one column is full' do
      before do
        fake_board_state << []
        (board.board_width - 1).times { fake_board_state << full_column }
        allow(board).to receive(:board_state).and_return(fake_board_state)
      end
      xit 'Returns false' do
        result = board.full?
        expect(result).to be false
      end
    end
    context 'All columns are full' do
      before do
        board.board_width.times { fake_board_state << full_column }
        allow(board).to receive(:board_state).and_return(fake_board_state)
      end
      xit 'Returns true' do
        result = board.full?
        expect(result).to be true
      end
    end
  end
end

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
      it 'Returns false' do
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
      it 'Returns false' do
        result = board.full?
        expect(result).to be false
      end
    end
    context 'All columns are full' do
      before do
        board.board_width.times { fake_board_state << full_column }
        allow(board).to receive(:board_state).and_return(fake_board_state)
      end
      it 'Returns true' do
        result = board.full?
        expect(result).to be true
      end
    end
  end

  describe '#move' do
    context 'Single move, board empty' do
      it 'Puts id at the bottom of an empty column' do
        board.move(1, 1)
        result = board.board_state[0][0]
        expect(result).to eq(1)
      end
    end
    context 'Two moves in the same column' do
      before do
        board.move(1, 1)
        board.move(2, 1)
      end
      it 'First move on bottom' do
        result = board.board_state[0][0]
        expect(result).to eq(1)
      end
      it 'Second move on top' do
        result = board.board_state[0][1]
        expect(result).to eq(2)
      end
    end
    context 'Moves also work in last column' do
      it 'Move is at bottom of last column' do
        player_input = board.board_width
        column = player_input - 1
        board.move(1, player_input)
        result = board.board_state[column][0]
        expect(result).to eq(1)
      end
    end
  end

  describe '#winner?' do
    let(:fake_board_state) { [] }
    let(:empty_column) { [] }
    context 'Four consecutive vertical' do
      it 'Returns true if they are all the same' do
        winning_column = [1, 1, 1, 1]
        board.instance_variable_set(:@current_move, [0, 3])
        fake_board_state << winning_column
        6.times { fake_board_state << empty_column }
        allow(board).to receive(:board_state).and_return(fake_board_state)
        result = board.winner?
        expect(result).to be true
      end
      it 'Returns false if they are not all the same' do
        non_winning_column = [1, 2, 1, 2]
        board.instance_variable_set(:@current_move, [0, 3])
        fake_board_state << non_winning_column
        6.times { fake_board_state << empty_column }
        allow(board).to receive(:board_state).and_return(fake_board_state)
        result = board.winner?
        expect(result).to be false
      end
    end
    context 'Forward diagonal wins' do
      before do
        fake_board_state = [[1, 2, 2, 2], [2, 1, 2, 2], [2, 2, 1, 2], [2, 2, 2, 1]]
        board.instance_variable_set(:@board_state, fake_board_state)
        board.instance_variable_set(:@board_width, 4)
        board.instance_variable_set(:@board_width, 4)
      end
      it 'Returns true if current move is in first position' do
        board.instance_variable_set(:@current_move, [0, 0])
        result = board.winner?
        expect(result).to be true
      end
      it 'Returns true if current move is in second position' do
        board.instance_variable_set(:@current_move, [1, 1])
        result = board.winner?
        expect(result).to be true
      end
      it 'Returns true if current move is in third position' do
        board.instance_variable_set(:@current_move, [2, 2])
        result = board.winner?
        expect(result).to be true
      end
      it 'Returns true if current move is in fourth position' do
        board.instance_variable_set(:@current_move, [3, 3])
        result = board.winner?
        expect(result).to be true
      end
    end
    context 'Backward diagonal wins' do
      before do
        fake_board_state = [[2, 2, 2, 1], [2, 2, 1, 2], [2, 1, 2, 2], [1, 2, 2, 2]]
        board.instance_variable_set(:@board_state, fake_board_state)
        board.instance_variable_set(:@board_width, 4)
        board.instance_variable_set(:@board_width, 4)
      end
      it 'Returns true if current move is in first position' do
        board.instance_variable_set(:@current_move, [0, 3])
        result = board.winner?
        expect(result).to be true
      end
      it 'Returns true if current move is in second position' do
        board.instance_variable_set(:@current_move, [1, 2])
        result = board.winner?
        expect(result).to be true
      end
      it 'Returns true if current move is in third position' do
        board.instance_variable_set(:@current_move, [2, 1])
        result = board.winner?
        expect(result).to be true
      end
      it 'Returns true if current move is in fourth position' do
        board.instance_variable_set(:@current_move, [3, 0])
        result = board.winner?
        expect(result).to be true
      end
    end
    context 'Horizontal wins' do
      before do
        fake_board_state = [[2, 2, 2, 1], [2, 2, 1, 1], [2, 2, 2, 1], [2, 1, 2, 1]]
        board.instance_variable_set(:@board_state, fake_board_state)
        board.instance_variable_set(:@board_width, 4)
        board.instance_variable_set(:@board_width, 4)
      end
      it 'Returns true if current move is in first position' do
        board.instance_variable_set(:@current_move, [0, 3])
        result = board.winner?
        expect(result).to be true
      end
      it 'Returns true if current move is in second position' do
        board.instance_variable_set(:@current_move, [1, 3])
        result = board.winner?
        expect(result).to be true
      end
      it 'Returns true if current move is in third position' do
        board.instance_variable_set(:@current_move, [2, 3])
        result = board.winner?
        expect(result).to be true
      end
      it 'Returns true if current move is in fourth position' do
        board.instance_variable_set(:@current_move, [3, 3])
        result = board.winner?
        expect(result).to be true
      end
    end
  end
end

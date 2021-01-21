# frozen_string_literal: true

# keeps track of where pieces are and how to display them
class Board
  attr_reader :board_state, :board_width, :board_height

  def initialize(board_width = 7, board_height = 6)
    @board_width = board_width
    @board_height = board_height
    setup_board_space(board_width)
  end

  def full?; end

  def winner?; end

  def move(id, input); end

  def valid_move?(input)
    board_state[input - 1].length < board_height
  end

  private

  def setup_board_space(width)
    @board_state = []
    width.times { @board_state.push([]) }
  end
end

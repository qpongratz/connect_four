# frozen_string_literal: true

# keeps track of where pieces are and how to display them
class Board
  attr_reader :board_state, :board_width, :board_height

  def initialize(board_width = 7, board_height = 6)
    @board_width = board_width
    @board_height = board_height
    setup_board_space(board_width)
  end

  def full?
    number_of_elements >= total_board_spaces
  end

  def winner?; end

  def move(id, input); end

  def valid_move?(input)
    column = translate(input)
    column_height(column) < board_height
  end

  private
  
  def translate(input)
    input - 1
  end

  def column_height(column)
    board_state[column].length
  end

  def number_of_elements
    board_state.flatten.count
  end

  def total_board_spaces
    board_height * board_width
  end

  def setup_board_space(width)
    @board_state = []
    width.times { @board_state.push([]) }
  end
end

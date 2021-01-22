# frozen_string_literal: true

# keeps track of where pieces are and how to display them
class Board
  attr_reader :board_state, :board_width, :board_height, :current_move

  def initialize(board_width = 7, board_height = 6)
    @board_width = board_width
    @board_height = board_height
    setup_board_space(board_width)
  end

  def full?
    number_of_elements >= total_board_spaces
  end

  def winner?
    # What piece am I looking for?
    x_pos = current_move[0]
    y_pos = current_move[1]
    piece = board_state[x_pos][y_pos]
    winning_string = "#{piece} #{piece} #{piece} #{piece}"
    # Define the lines the wins can be on.
    horizontal = ((x_pos - 3)..(x_pos + 3)).to_a
    vertical = ((y_pos - 3)..(y_pos + 3)).to_a
    current_row = Array.new(7, y_pos)
    current_column = Array.new(7, x_pos)
    row_win = horizontal.zip(current_row)
    column_win = current_column.zip(vertical)
    forward_diagonal_win = horizontal.zip(vertical)
    backward_diagonal_win = horizontal.zip(vertical.reverse)
    line_arrays = [row_win, column_win, forward_diagonal_win, backward_diagonal_win]
    # Map coordinates to pieces
    line_strings = line_arrays.map do |array|
      piece_list = array.map { |coordinate| board_state[coordinate[0]][coordinate[1]] }
      piece_list.join(' ')
    end
    # Check for wins on each line.
    line_strings.keep_if { |string| string.include?(winning_string) }
    line_strings.length.positive?
  end

  def move(id, input)
    column = translate(input)
    board_state[column].push(id)
    @current_move = [column, (column_height(column) - 1)]
  end

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

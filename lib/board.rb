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
    winning_string = "#{current_piece} #{current_piece} #{current_piece} #{current_piece}"
    intersecting_coordinates = intersecting_lines(current_x, current_y)
    intersecting_pieces = coordinates_to_pieces(intersecting_coordinates)
    intersecting_pieces.keep_if { |string| string.include?(winning_string) }
    intersecting_pieces.length.positive?
  end

  def move(id, input)
    column = translate_to_column(input)
    board_state[column].push(id)
    @current_move = [column, (column_height(column) - 1)]
  end

  def valid_move?(input)
    column = translate_to_column(input)
    column_height(column) < board_height
  end

  private

  def on_board?(column, row)
    column.between?(0, board_width - 1) && row.between?(0, board_height - 1)
  end

  def current_piece
    piece_at_coordinate(current_x, current_y)
  end

  def current_x
    current_move[0]
  end

  def current_y
    current_move[1]
  end

  def coordinates_to_pieces(coordinate_arrays)
    coordinate_arrays.map do |array|
      pieces = array.map { |coord| piece_at_coordinate(coord[0], coord[1]) }
      pieces.join(' ')
    end
  end

  def piece_at_coordinate(column, row)
    on_board?(column, row) ? board_state[column][row] : nil
  end

  def intersecting_lines(x_pos, y_pos)
    horizontal = ((x_pos - 3)..(x_pos + 3)).to_a
    vertical = ((y_pos - 3)..(y_pos + 3)).to_a
    current_row = Array.new(7, y_pos)
    current_column = Array.new(7, x_pos)
    row_coords = horizontal.zip(current_row)
    column_coords = current_column.zip(vertical)
    positive_diagonal_coords = horizontal.zip(vertical)
    negative_diagonal_coords = horizontal.zip(vertical.reverse)
    [row_coords, column_coords, positive_diagonal_coords, negative_diagonal_coords]
  end

  def translate_to_column(input)
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

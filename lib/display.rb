# frozen_string_literal: true

# Displays the board
module Display

  PIECES = ['⚪', '⚫'].freeze

  def display_board(board)
    readable_board = prepare_board(board)
    print_top(board.board_width)
    readable_board.each_with_index do |row, index|
      convert_ids_to_pieces(row)
      print_row_with_pieces(row)
      index == readable_board.length - 1 ? print_bottom(row) : print_spacer(row)
    end
    print "\n\n\n"
  end

  private

  def prepare_board(board)
    board_copy = board.board_state.map(&:dup)
    board_copy.each { |array| array.push('  ') until array.length == board.board_height }
    board_copy.transpose.reverse
  end

  def print_top(width)
    #print Column numbers above it
    print "\n┌"
    (width - 1).times { print '──┬' }
    print '──┐'
  end

  def convert_ids_to_pieces(row)
    row.map! { |piece| piece == '  ' ? piece : PIECES[piece - 1] }
  end

  def print_row_with_pieces(row)
    print "\n"
    row.each { |piece| print "│#{piece}" }
    print '│'
  end

  def print_spacer(row)
    print "\n├"
    (row.length - 1).times { print '──┼' }
    print '──┤'
  end

  def print_bottom(row)
    print "\n├"
    (row.length - 1).times { print '──┴' }
    print '──┤'
  end
end

# frozen_string_literal: true


module Display

  PIECES = ['⚪', '⚫']

  def display_board(board)
    readable_board = prepare_board(board)
    print "\n┌"
    (board.board_width - 1).times {print '──┬'}
    print '──┐'
    readable_board.each_with_index do |row, index|
      row.map! { |piece| piece = piece == '  ' ? piece : PIECES[piece - 1] }
      print "\n"
      row.each { |piece| print "│#{piece}" }
      print "│\n├"
      if index == readable_board.length - 1
        (row.length - 1).times { print '──┴' }
      else
        (row.length - 1).times { print '──┼' }
      end
      print '──┤'
    end
    print "\n\n\n"
  end

  def prepare_board(board)
    board_copy = board.board_state.map(&:dup)
    board_copy.each { |array| array.push('  ') until array.length == board.board_height }
    board_copy.transpose.reverse
  end  
end
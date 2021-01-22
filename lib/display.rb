# frozen_string_literal: true


module Display

  PIECES = ['⚪', '⚫']
  def self.board(board)
    board_copy = board.board_state.map(&:dup)
    board_copy.each { |array| array.push('  ') until array.length == board.board_height }
    readable_board = board_copy.transpose.reverse
    readable_board.each do |row|
      row.map! {|piece| piece = piece == '  ' ? piece : PIECES[piece - 1]}
      print "\n"
      row.each {|piece| print "│#{piece}"}
      print "│\n├"
      (row.length - 1).times {print '──┼'}
      print '──┤'
    end
  end
end
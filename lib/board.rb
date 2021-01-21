# frozen_string_literal: true

# keeps track of where pieces are and how to display them
class Board
  def initialize; end
  def full?; end
  def winner?; end
  def move(id, input); end
  def valid_move?(input); end
end

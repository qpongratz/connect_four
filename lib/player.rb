# frozen_string_literal: true

require_relative 'board'

# Controls the player class
class Player
  def initialize(id)
    @id = id
  end

  def move(board)
    board.move(input)
  end

  def input
    input = gets.chomp
    valid?(input) ? input : nil
  end
  
  private
  
  def valid?(input)
    input.to_i.between?(1, 7)
  end
end
# frozen_string_literal: true

require_relative 'board'

# Controls the player class
class Player
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def move(board)
    player_input = input
    input unless board.valid_move?(player_input)
    board.move(id, player_input)
  end

  # Could be private, but has tests associated with it. Perhaps rework tests to test this through move.
  def input
    puts 'Enter column number'
    input = gets.chomp
    input = gets.chomp until valid?(input)
    input
  end

  private

  def valid?(input)
    input.to_i.between?(1, 7) ||
      (puts 'Invalid column number')
  end
end

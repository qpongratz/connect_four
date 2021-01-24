# frozen_string_literal: true

require_relative 'player'
require_relative 'board'
require_relative 'display'

# Controls game flow and initializes boards and players
class Game
  include Display
  attr_reader :players, :current_player, :board

  def initialize
    @players = nil
    @board = Board.new
    @current_player = nil
  end

  # Should be private and test through start.
  def make_players
    @players = []
    players.push(Player.new(1))
    players.push(Player.new(2))
  end

  def start
    make_players
    setup_players
    players.shuffle!
    display_board(board)
    turn
  end

  def turn
    until board.full?
      next_player
      current_player.move(board)
      display_board(board)
      return winner if board.winner?
    end
    tie
  end

  private

  def setup_players
    players.each(&:setup)
  end

  def next_player
    players.rotate!
    @current_player = players[0]
  end

  def winner
    puts "#{current_player.name} has won. Congratz!"
  end

  def tie
    puts 'Board is full. No one has won.'
  end
end

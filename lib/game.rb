# frozen_string_literal: true

require_relative 'player'
require_relative 'board'

# Controls game flow and initializes boards and players
class Game
  attr_reader :players, :current_player, :board

  def initialize
      
  end


  def make_players
    @players = []
    players.push(Player.new(1))
    players.push(Player.new(2))
  end

  def start
  end

  def turn
    until board.full?
      next_player
      current_player.move(board)
      return winner if board.winner?
    end
    tie
  end

  private

  def next_player
    players.rotate!
    @current_player = players[0]
  end

  def winner
    puts "#{current_player} has won. Congratz!"
  end

  def tie
    puts 'Board is full. No one has won.'
  end

end
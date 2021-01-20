# frozen_string_literal: true

require_relative 'player'
require_relative 'board'

# Controls game flow and initializes boards and players
class Game
  attr_reader :players

  def initialize; end

  def make_players
    @players = []
    players.push(Player.new(1))
    players.push(Player.new(2))
  end
end
# frozen_string_literal: true

require_relative 'game'

puts 'Welcome to Four-in-a-row!'
puts 'Two players take turns dropping pieces into a board'
puts 'The first to connect four vertically, horizontally, or diagaonally'
puts 'WINS'
puts 'Good luck, and may the fours be with you.'

new_game = Game.new
new_game.start
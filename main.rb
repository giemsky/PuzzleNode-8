require 'rubygems'
require 'yajl'
require 'dictionary'
require 'board'
require 'move'

unless ARGV.size == 1
  puts "USAGE: ruby main.rb <input_file>"
  exit
end

# Read board file
board_file = ARGV.first

# let's parse JSON file
json = File.new(board_file, 'r')
data = Yajl::Parser.new.parse(json)

# retrieve tiles with weights
letters = Array.new
data["tiles"].each do |t| 
  letter, weight = t.strip.match(/^([a-z])(\d{1,2})$/)[1, 2]
  letters << letter
  Move.tiles_weights[letter] = weight.to_i
end

# parse board & dictionary
board = Board.new(data["board"])
dictionary = Dictionary.new(data["dictionary"])

# search for the best move
matched_words = dictionary.match(letters)
best_move = matched_words.inject(nil) do |best_move, word| 
  best_move.nil? ? board.find_best_move(word) : [best_move, board.find_best_move(word)].max
end

# display results
board.move(best_move)
puts board.inspect





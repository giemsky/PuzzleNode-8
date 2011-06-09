#
# Move - class representing move that can be executed on the board
#

class Move
  include Comparable
  
  # Available move directions
  HORIZONTAL = 0
  VERTICAL = 1
  
  attr_reader :x, :y, :word, :orientation
  
  class << self
    attr_accessor :tiles_weights
  end
  self.tiles_weights = Hash.new
  
  def initialize(path, x, y, word, orientation)
    @path = path # path with weights for letters to be placed
    @x = x
    @y = y
    @word = word
    @orientation = orientation
  end
  
  #
  # Returns: Hash
  #
  def tiles_weights
    self.class.tiles_weights
  end
  
  #
  # Calculate score for this move
  # Returns: Fixnum
  #
  def score
    return @score unless @score.nil?

    @score = 0
    letters = @word.chars
    loop{ @score += @path.next * tiles_weights[letters.next] }
    @score
  end

  def <=>(other)
    score <=> other.score
  end
end
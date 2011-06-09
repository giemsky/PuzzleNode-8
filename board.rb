#
# Board - class repesenting board matrix
#

class Board
  def initialize(rows)
    @matrix = Array.new
    initialize_matrix(rows)
  end
  
  #
  # Finds the best move for a given word
  # Returns: Move
  #
  def find_best_move(word)
    # initial move
    best_move = Move.new(@matrix[0][0..word.size-1].each, 0, 0, word, Move::HORIZONTAL)
    
    # horizontal check
    (0..self.rows-1).each do |x|
      (0..(self.cols - word.size)).each do |y|
        path = @matrix[x][y..y+word.size-1].each
        best_move = [best_move, Move.new(path, x, y, word, Move::HORIZONTAL)].max
      end
    end
    
    # vertical check
    (0..self.cols-1).each do |y|
      (0..(self.rows - word.size)).each do |x|
        path = @matrix[x..x+word.size-1].map{|row| row[y]}.each
        best_move = [best_move, Move.new(path, x, y, word, Move::VERTICAL)].max
      end
    end
    
    best_move
  end
  
  #
  # Executes given move, places its word on board
  #
  def move(move)
    case move.orientation
    when Move::HORIZONTAL
      move.word.size.times{|i| @matrix[move.x][move.y+i] = move.word[i].chr}
    when Move::VERTICAL
      move.word.size.times{|i| @matrix[move.x+i][move.y] = move.word[i].chr}
    end
  end
  
  #
  # Board's rows size
  #
  def rows
    @rows ||= @matrix.size
  end
  
  #
  # Board's cols size
  #
  def cols
    @cols ||= @matrix[0].size
  end
  
  def inspect
    @matrix.inject(String.new) do |output, row| 
      output << row.join(' ')
      output << "\n"
    end
  end
  
  private
  
  def initialize_matrix(rows)
    rows.each_with_index do |row, i|
      @matrix[i] = row.strip.split(' ').map(&:to_i)
    end
  end
end # end Board
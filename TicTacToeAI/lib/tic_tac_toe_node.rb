require "byebug"
require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end
  
    # evaluator = mark of current player (:x or :o)
  def losing_node?(evaluator)
    evaluator == :x ? other_mark = :o : other_mark = :x
    if @board.over? 
      if @board.winner == other_mark
        return true 
      else
        return false
      end
    end

    if evaluator == next_mover_mark
      self.children.all? { |child| child.losing_node?(evaluator) }
    else
      self.children.any? { |child| child.losing_node?(evaluator) }
    end
  end
  
  def winning_node?(evaluator)
    if @board.over? 
      if @board.winner == evaluator
        return true 
      else
        return false
      end
    end

    if evaluator == next_mover_mark
      self.children.any? { |child| child.winning_node?(evaluator) }
    else
      self.children.all? { |child| child.winning_node?(evaluator) }
    end
  end
  
  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    child_arr = []
    empty_positions.each do |pos|
      new_board = @board.dup
      # debugger
      new_board[pos] = @next_mover_mark
      next_mark = @next_mover_mark == :x ? :o : :x
      child_arr << TicTacToeNode.new(new_board, next_mark, pos)
    end
    child_arr
  end

  def empty_positions
    empty_pos = []
    # debugger
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |col, j|
        empty_pos << [i, j] if @board.empty?([i, j])
      end
    end

    empty_pos
  end
end

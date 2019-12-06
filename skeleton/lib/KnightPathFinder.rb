require "byebug"
require_relative "00_tree_node"

class KnightPathFinder
    attr_reader :considered_positions, :tree, :root_node
    attr_writer :considered_positions

    def self.valid_moves(pos)
        possibles = KnightPathFinder.possible_moves(pos)
        valid_moves = possibles.select do |move|
            size = (0..7).to_a
            size.include?(move[0]) && size.include?(move[1])
        end
        valid_moves
    end

    def self.possible_moves(pos)
        possible_moves_arr = []
        vert = pos[0]
        horz = pos[1]

        # deltas = [[2, 1], [2, -1], ]

        possible_moves_arr << [(vert + 2), (horz + 1)]
        possible_moves_arr << [(vert + 2), (horz - 1)]
        possible_moves_arr << [(vert - 2), (horz + 1)]
        possible_moves_arr << [(vert - 2), (horz - 1)]
        possible_moves_arr << [(vert + 1), (horz + 2)]
        possible_moves_arr << [(vert + 1), (horz - 2)]
        possible_moves_arr << [(vert - 1), (horz + 2)]
        possible_moves_arr << [(vert - 1), (horz - 2)]
        possible_moves_arr
    end

    def initialize(starting_pos)
        @root_node = PolyTreeNode.new(starting_pos)
        @considered_positions = [starting_pos]
        self.build_move_tree
    end

    # def [](pos)
        
    # end

    def build_move_tree
        pos_queue = [@root_node]

        until pos_queue.length == 0
            first = pos_queue.shift
            new_moves = new_moves_positions(first.value)

            new_moves.each do |move|
                child = PolyTreeNode.new(move)
                child.parent = first
                pos_queue << child
            end

        end
    end

    def new_moves_positions(pos)
        possible_moves = KnightPathFinder.valid_moves(pos)
        # debugger
        new_moves = possible_moves.reject { |move| @considered_positions.include?(move) }
        @considered_positions += new_moves
        new_moves
    end


end 

if __FILE__ == $PROGRAM_NAME
    kpf = KnightPathFinder.new([0, 0])
    # p kpf.new_moves_positions([0, 0])
    # kpf.considered_positions

    p kpf.root_node
end
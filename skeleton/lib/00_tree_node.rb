require "byebug"
class PolyTreeNode

    attr_reader :parent, :children, :value
    def initialize(value)
        @parent = nil
        @children = []
        @value = value
    end

    def parent=(node)
        unless parent.nil?
            # debugger
            self.parent.children.delete(self)
        end
        @parent = node
        return nil if node == nil
        node.children << self
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        self.children.include?(child_node) ? child_node.parent = nil : (raise "this node is not a child of this parent")
    end

    def dfs(target)
        # debugger
        return self if self.value == target
        self.children.each do |child|
            # debugger
            result = child.dfs(target) 
            return result unless result.nil?
        end
        nil
    end

    def bfs(target)
        arr = [self]

        until arr.length == 0
            first  = arr.shift
            return first if first.value == target
            first.children.each { |child| arr << child }
        end
        nil
    end

end
module JsonToGraphql
  class Parser
    attr_accessor :input_hash, :output_string, :root
    SPACES_PER_TAB = 2;

    def initialize(input_hash)
      self.input_hash = input_hash
      self.root = Node.new(name: :root, args: {}, attrs: [])
      build_nodes(self.input_hash, self.root)
    end

    def build_nodes(hash, parent_node)
      hash.each do |key, value|
        node = Node.new(name: key,
                        args: value.delete('_args') || {},
                        attrs: value.delete('_attrs') || [])

        node.variables = (value.delete("_variables") || {}) if parent_node.name == :root
        parent_node.children << node
        build_nodes(value || {}, node)
      end
    end

    def print
      "{\n#{root.print(output_string, 1)}}"
    end

    class Node
      attr_accessor :name, :args, :attrs, :children, :variables
      SPACES_PER_TAB = 2

      def initialize(name:, args:, attrs:)
        @name = name
        @children = []
        @attrs = attrs || []
        @args = args || {}
      end

      def print(output_string, level)
        indentation = " " * (level * SPACES_PER_TAB)
        next_level_indentation = " " * ((level.succ) * SPACES_PER_TAB)
        output_string.concat(indentation, "#{name}", argument_string, "{\n")
        attrs.each { |attr| output_string.concat(next_level_indentation, "#{attr}\n") }
        children.each { |child| child.print(output_string, level.succ) }
        output_string.concat(indentation, "}\n")
      end

      private

      def argument_string
        return ' ' if args.empty?
        '(' + args.map{|k,v| "#{k}: #{v}"}.join(',') + ') '
      end
    end
  end
end

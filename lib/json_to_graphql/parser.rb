module JsonToGraphql
  class Parser
    attr_accessor :input_hash, :root
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
      if input_hash.key?('query')
        start_string = ""
        start_space = 0
      else
        start_string = "{\n"
        start_space = 1
      end

      query = root.children.each_with_object(start_string) do |child, query|
        query.concat("#{child.print("", start_space)}")
      end
      query.concat("}") unless input_hash.key?('query')
      return query
    end

    class Node
      attr_accessor :name, :args, :attrs, :children, :variables
      SPACES_PER_TAB = 2

      def initialize(name:, args:, attrs:)
        @name = name
        @children = []
        @attrs = attrs || []
        @args = args || {}
        @variables = {}
      end

      def print(string, level)
        indentation = " " * (level * SPACES_PER_TAB)
        next_level_indentation = " " * ((level.succ) * SPACES_PER_TAB)
        string.concat(indentation, "#{name}", arg_var_string, "{\n")
        attrs.each { |attr| string.concat(next_level_indentation, "#{attr}\n") }
        children.each { |child| child.print(string, level.succ) }
        string.concat(indentation, "}\n")
      end

      private

      def arg_var_string
        if !args.empty?
          '(' + args.map{|k,v| "#{k}: #{v}"}.join(',') + ') '
        elsif !variables.empty?
          '(' + variables.map{|k,v| "$#{k}: #{v}"}.join(',') + ') '
        else
          ""
        end
      end
    end
  end
end

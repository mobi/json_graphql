require "json_to_graphql/version"
require "json_to_graphql/parser"
require 'json'

module JsonToGraphql
  def self.parse(json_string)
    JsonToGraphql::Parser.new(JSON.parse(json_string)).print.chomp("\n}").reverse.chomp("  \n{").reverse
  end
end

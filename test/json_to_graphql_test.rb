require "test_helper"

class JsonToGraphqlTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::JsonToGraphql::VERSION
  end

  def test_parser_converts_hash_to_graphql
    parser = ::JsonToGraphql::Parser.new(input_hash)
    graphql_query = parser.print
    assert_equal graphql_query.to_s, output_query.to_s
  end

  def test_parser_converts_hash_to_graphql_when_query_key_not_present
    parser = ::JsonToGraphql::Parser.new(input_hash_without_query_key)
    graphql_query = parser.print
    assert_equal graphql_query.to_s, output_query_without_query_key.to_s
  end

  def input_hash
    {
      "query" => {
        "_variables" => {
          "x" => 1, "y" => 2
        },
        "lines" => {
          "_args" => {
            "id" => 123
          }, "_attrs" => [:name,:age], "devices" => {
            "_args" => {
              "price" => 40
            }, "_attrs" => [:price,:name]
          }, "people" => {}
        }
      }
    }
  end

  def input_hash_without_query_key
    {
      "lines" => {
        "_args" => {
          "id" => 123
        }, "_attrs" => [:name,:age], "devices" => {
          "_args" => {
            "price" => 40
          }, "_attrs" => [:price,:name]
        }, "people" => {}
      }
    }
  end

  def output_query_without_query_key
    <<~QUERY.chomp
    {
      lines(id: 123) {
        name
        age
        devices(price: 40) {
          price
          name
        }
        people{
        }
      }
    }
    QUERY
  end

  def output_query
    <<~QUERY
    query($x: 1,$y: 2) {
      lines(id: 123) {
        name
        age
        devices(price: 40) {
          price
          name
        }
        people{
        }
      }
    }
    QUERY
  end
end

# JsonToGraphql

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json_to_graphql'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_to_graphql

## Usage

This gem accepts a JSON object of a particular format and returns a valid GraphQL query.

```ruby
    json_query = {
      "query" => {
        "_variables" => {
          "x" => 1, "y" => 2
        },
        "libraries" => {
          "_args" => {
            "id" => 123
          }, 
          "_attrs" => [:name, :address], 
          "books" => {
            "_args" => {
              "price" => 40
            }, 
            "_attrs" => [:price, :name, :author]
          }, 
          "employees" => {
            "_args" => {
                "department" => "history"
            },
            "_attrs" => [:name, :age, :department]
          }
        }
      }
    }.to_json

JsonToGraphql.parse(json_query)
```
should yield

```graphql
  {
    query($x: 1, $y: 2) {
      libraries(id: 123) {
        name
        address
        devices(price: 40) {
          price
          name
          author
        }
        employees(department: history){
          name
          age
          department
        }
      }
    }
  }
```

Here each key/node can have one of 4 options:

1 - **Variables**: Using the key `_variables` which are local variables that you want to use later in the query, usually placed on the top key defining the entire query, in this case this key is `"query"`.

2 - **Arguments**: Use the `_args` key to define the arguments to be passed to your GraphQL engine when fetching the relation.

3 - **Attributes/Columns**: Use the `_attrs` key to define the fields that should be returned.

4 - **New key**: Specify new keys to define additional relations that should be returned.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/json_to_graphql. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JsonToGraphql project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/json_to_graphql/blob/master/CODE_OF_CONDUCT.md).

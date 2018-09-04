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

The gem basically handles the conversion through the method `parse` defined in the `JsonToGraphql` module that gets passed a json in the following format.

```ruby
    {
      "query" => {
        "_variables" => {
          "x" => 1, "y" => 2
        },
        "libraries" => {
          "_args" => {
            "id" => 123
          }, 
          "_attrs" => [:name,:address], 
          "books" => {
            "_args" => {
              "price" => 40
            }, 
            "_attrs" => [:price,:name, :author]
          }, 
          "employees" => {
            "_args" => {
                "department" => "history"
            },
            "_attrs" => [:name, :age, :department]
          }
        }
      }
    }
```

Assuming this is stored in a variable called `json_query` in `JSON` format then

```ruby
JsonToGraphql.parse(json_query)
```
should output

```graphql
  {
    query($x: 1,$y: 2) {
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

2 - **Arguments**: Using the key `_args` which is another hash containing arguments passed to a node like in `devices(price: 40)`.

3 - **Attributes/Columns**: Using the key `_attrs` and the value in this case is an array representing the attributes or columns requested to included in the response.

4 - **New key**: Usually resembling a nested object to be included that is also expected to have arguments and attributes.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/json_to_graphql. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JsonToGraphql project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/json_to_graphql/blob/master/CODE_OF_CONDUCT.md).

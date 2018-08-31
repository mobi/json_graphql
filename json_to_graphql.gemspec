
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "json_to_graphql/version"

Gem::Specification.new do |spec|
  spec.name          = "json_to_graphql"
  spec.version       = JsonToGraphql::VERSION
  spec.authors       = ["Adam Fernung", "Amir Kolta"]
  spec.email         = ["adam.fernung@mobiwm.com", "amir.kolta@mobiwm.com"]

  spec.summary       = "This gem converts JSON objects to GraphQL queries."
  spec.description   = "This is an even longer description of how this gem converts
                        JSON to GraphQL queries."
  spec.homepage      = "https://github.com/mobi/json_graphql"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-stack_explorer"
  spec.add_development_dependency "pry-byebug"
end

# Spider::Node

Spider compiler in a gem.

## Installation

Add this line to your application's Gemfile:

    gem 'spider-node'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spider-node

## Usage

```ruby
require 'spider-node'

# raises an error if node(1) isn't available
Spider::Node.check_node

# compiles a Spider source file and returns Spider::Node::CompileResult
result = Spider::Node.compile_file(file)
result.success? # => true if succeeded
result.js # => output JavaScript source code
result.stdout # => what tsc(1) shows to stdout
result.stderr # => what tsc(1) shows to stderr

# compiles a Spider source code string and returns String
js_source = spider::Node.compile_file(source)
```

## Contributing

1. Fork it ( https://github.com/alinbsp/spider-node/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

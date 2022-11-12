# DebugVisualizer

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add debugvisualizer

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install debugvisualizer

## Usage

### Example

```ruby
require 'debugvisualizer'

DebugVisualizer.register do |data|
  if data.is_a?(Hash)
    {
      id: "hash_visualizer",
      name: "Hash",
      data: {
          kind: { table: true },
          rows: [data]
      }
    }
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test-unit` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/debugvisualizer.

# DebugVisualizer

A libray to use [VS Code Debug Visualizer](https://github.com/hediet/vscode-debug-visualizer) in [Ruby debugger](https://github.com/ruby/debug).

[![](https://user-images.githubusercontent.com/59436572/209464984-16f19f33-5fa5-401a-b420-ce7ad6017dce.png)](https://www.youtube.com/watch?v=9vLVCrpzlDQ)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add debugvisualizer

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install debugvisualizer

## Register Custom View

Here is an example:

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

## Acknowledgement

[Koichi Sasada (@ko1)](https://github.com/ko1) - He reviewed API and gave me many ideas to improve `debugvisualizer`.

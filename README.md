# RSpec Timeout.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec_timeout'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec_timeout

## Usage

Open `spec_helper.rb` add a require for RSpec Timeout and set it up in your
specs:

```ruby
require "rspec_timeout"
RSpec.configure do |config|
  RSpecTimeout.setup(config)
end
```

This will cause your test suite to fail if it takes more than 120 seconds (the
default timeout) to execute.

If you'd like to customise the timeout, you can pass the `:timeout` option
thusly:

```ruby
require "rspec_timeout"
RSpec.configure do |config|
  RSpecTimeout.setup(config, :timeout => 2)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rspec_timeout. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


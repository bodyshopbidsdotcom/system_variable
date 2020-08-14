# SystemVariable

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/system_variable`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'system_variable'
```

And then execute:

    $ bundle i

Or install it yourself as:

    $ gem install system_variable

Once installed, install any SystemVariable migrations

    $ rake system_variable:install:migrations

## Configuration

SystemVariable can be configured using an initializer file in your rails application.

```ruby
# config/initializers/system_variable.rb

SystemVariable.configure do |config|
  config.external_sources = [ENV] # An array of variable sources, such as ENV or AWS Secrets.
                                  # Each element should be a Hash or conform to a Hash interface.
                                  # When fetching values, external sources are checked in the order they're defined here.
                                  # Default: [ENV]
  @cache_key = 'system_variable'  # Allows the key used by Rails cache to be configurable
                                  # Default: 'system_variable'
  @caching_enabled = true         # Enables caching of native SystemVariable variables.
                                  # Default: true
end
```

## Usage

Fetching variables
```ruby
SystemVariable.fetch('EXTERNAL_APPLICATION_URL') # 'https://externalurl.test
```

Return default values if variable isn't found, or the found value is `nil`.
```ruby
SystemVariable.fetch('EXTERNAL_APPLICATION_URL', default: 'http://defaulturl.test') # 'http://defaulturl.test'
```

Check if a variable key is defined
```ruby
SystemVariable.exists?('EXTERNAL_APPLICATION_URL')
```

NOTE: All lookup methods (fetch/exists?) will look at native SystemVariable values _first_, then check any defined external sources.

Create a new variable
```ruby
SystemVariable::Variable.create(key: 'MY_NEW_VARIABLE', value: 'foo')
```

Create a new variable and assign it to a category
```ruby
SystemVariable::Variable.create(key: 'MY_NEW_VARIABLE', value: 'foo', category_attributes: { name: 'My Category' })
```

## Development

Install Dependencies

    $ bundle i

Setup the database

    $ bundle exec rake db:create
    $ bundle exec rake db:schema:load

Run migrations

    $ bundle exec rake db:migrate

Run tests

    $ bundle exec rspec

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/system_variable. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SystemVariable project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/system_variable/blob/master/CODE_OF_CONDUCT.md).

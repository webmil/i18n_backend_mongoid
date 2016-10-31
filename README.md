# i18n_backend_mongoid

Store I18n translations in MongoDB

## Dependency

```ruby
gem 'rails-i18n'
gem 'mongoid'
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'i18n_backend_mongoid'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install i18n_backend_mongoid

## Usage

    rails g i18n_backend_mongoid:install TRANSLATION_TABLE_NAME

## Uninstall

    rails d i18n_backend_mongoid:install TRANSLATION_TABLE_NAME

## Contributing

    1. Fork it ( https://github.com/webmil/i18n_backend_mongoid/fork )
    2. Create your feature branch (`git checkout -b my-new-feature`)
    3. Commit your changes (`git commit -am 'Add some feature'`)
    4. Push to the branch (`git push origin my-new-feature`)
    5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

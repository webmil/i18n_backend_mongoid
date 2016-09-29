# Venomi

United I18n backend simple with mongoid provider and adds translation functionality to Rails Admin.

## Dependency

```ruby
gem 'rails-i18n'
gem 'mongoid'
gem 'rails_admin'
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'venomi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install venomi

## Usage

    rails g venomi:install TRANSLATION_TABLE_NAME

## Uninstall

    rails d venomi:install TRANSLATION_TABLE_NAME

## Contributing

    1. Fork it ( https://github.com/AlexandrToorchyn/venomi/fork )
    2. Create your feature branch (`git checkout -b my-new-feature`)
    3. Commit your changes (`git commit -am 'Add some feature'`)
    4. Push to the branch (`git push origin my-new-feature`)
    5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

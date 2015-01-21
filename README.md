# RestrictedStruct

[![Build Status](https://travis-ci.org/waterlink/restricted_struct.svg?branch=master)](https://travis-ci.org/waterlink/restricted_struct)

This gem allows to use ruby's Struct, but automatically hides all the attributes as private or protected, which provides higher level of encapsulation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'restricted_struct'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install restricted_struct

## Usage

Instead of doing this:

```ruby
class Rectangle < Struct.new(:x1, :y1, :x2, :y2)
  protected :x1, :x1=, :y1, :y1=, :x2, :x2=, :y2, :y2=

  # ...
end
```

one can do:

```ruby
class Rectangle < RestrictedStruct.new(:protected, :x1, :y1, :x2, :y2)
  # ...
end
```

Available access levels: `:private` and `:protected`.

## Contributing

1. Fork it ( https://github.com/waterlink/restricted_struct/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Alexey Fedorov](https://github.com/waterlink)
- [Anselm Helbig](https://github.com/anselm-helbig-wimdu)

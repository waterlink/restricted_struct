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

### Keyword arguments

```ruby
class Rectangle < RestrictedStruct.new(:protected, :x1, :y1, :x2, :y2, :color => :white)
  # ...
end
```

This will create a struct with 5 fields: x1, y1, x2, y2 and color. But color will default to `:white` if not provided.
And color can be assigned while instantiating a value of this class either as 5th parameter or as keyword argument, i.e.:

```ruby
rect = Rectangle[20, 30, 60, 50, :red]
# is the same as:
rect = Rectangle[20, 30, 60, 50, :color => :red]
```

By the way, nothing forbids you from specifying any fields as keyword arguments:

```ruby
rect = Rectangle[20, 30, :x2 => 60, :y2 => 50]
# or even all of them:
rect = Rectangle[:x1 => 20, :y1 => 30, :x2 => 60, :y2 => 50, :color => :black]
```

Just be careful when specifying the same fields simultaneously as normal params and as part of keyword arguments hash, for example:

```ruby
rect = Rectangle[20, 30, 60, 50, :x2 => 55]
# is essentially the same as
rect = Rectangle[20, 30, 55, 50]
```

Which means 3rd argument was overwritten by corresponding keyword argument.

## Contributing

1. Fork it ( https://github.com/waterlink/restricted_struct/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Alexey Fedorov](https://github.com/waterlink)
- [Anselm Helbig](https://github.com/anselm-helbig-wimdu)

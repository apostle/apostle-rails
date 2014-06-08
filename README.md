# Apostle Rails
[![Gem Version](https://badge.fury.io/rb/apostle-rails.png)](http://badge.fury.io/rb/apostle-rails)

Rails Bindings for [Apostle.io](http://apostle.io)

## Installation

Add this line to your application's Gemfile:

    gem 'apostle-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apostle-rails

## Usage

`apostle-rails` is designed to feel like the `ActionMailer` API as much as possible.

Changing an existing mailer is easy.

```ruby
class MyMailer < ActionMailer::Base
	def my_mail name, email, message
		@message, @name = message, name
		mail to: email, subject: "Your message"
	end
end
```
becomes
```ruby
class MyMailer < ActionMailer::Base

	include Apostle::Mailer

	def my_mail name, email, message
		@message, @name = message, name
		mail "my_mail", email: email
	end
end
```

The first param passed to `mail` is the template slug, and instead of `to`, use `email`. `Apostle::Mailer` automatically adds any instance variables you set to the `Apostle::Mail` instance.

Instead of returning a `Mail::Message` object when you call `MyMailer.my_mail` you get an instance of `Apostle::Mail`, which  you can then call `deliver` on.

```ruby
MyMailer.
	my_mail("Mal Curtis", "mal@mal.co.nz", "Hi there").
	deliver!
```

### Instance variables
Any instance variables you assign will be converted to their `JSON` representation via `#as_json`. This can end up adding extra information which you may not want to send, so it might be easier to create your own hash representations of information.

```ruby
def new_book book, email
	@book = { title: book.title, author: book.author.name }
	mail "new_book", email: email
end
```

## Who
Created with ♥ by [Mal Curtis](http://github.com/snikch) ([@snikchnz](http://twitter.com/snikchnz))

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

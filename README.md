# Mailgems

This library allows you to quickly and easily use the Mailgems API v1 via Ruby. It is also an Action Mailer adapter for using [Mailgems](https://www.mailgems.com) in Rails apps. It uses the [Mailgems HTTP API](https://mailgems.docs.apiary.io/) internally.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mailgems'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mailgems

## Usage

Here's how to send a message using the library:

```ruby
require 'mailguns'

# First, instantiate the Mailgems Mail with your API key
mg_client = Mailgun::Mail.new(api_key: 'your-api-key')

# Define your mail parameters
mail_params = {
	from_email: 'foo@sending_domain.com',
	from_name: 'Foo',
	recipients: [{
		email: 'receiver@example.com',
		attributes: { name: 'Receiver' }
	}],
	subject: 'The Mailgems Ruby SDK is awesome!',
	content: 'Hi {{name}}, It is really easy to send an email!'
}

# Send your mail through the client
mg_client.send_mail mail_params
```

## Rails

```ruby
Mailgems.configure do |config|
	config.api_key = 'your-api-key'
	config.sandbox = false
end
```

Or have the initializer read your environment setting if you prefer.

To use as the ActionMailer delivery method, add this to your `config/environments/whatever.rb`:
```ruby
	config.action_mailer.delivery_method = :mailgems
```

To specify Mailgems options such as template (body) or merge_data:
```ruby
class UserMailer < ApplicationMailer
  def welcome_email
    mail(to: params[:to], subject: "Welcome!", body: 'mailgems-template-name', merge_data: { name: params[:name] })
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mailgems/mailgems-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mailgems project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mailgems/mailgems-ruby/blob/master/CODE_OF_CONDUCT.md).

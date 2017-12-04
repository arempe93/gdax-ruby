GDAX Ruby
=========

An object-oriented client for the GDAX REST API. Heavily inspired by the [Stripe Ruby client](https://github.com/stripe/stripe-ruby)

## Examples

#### Place an order, then cancel it

```ruby
order = GDAX::Order.buy(product_id: 'BTC-USD', price: 100, size: 0.5)
# => #<GDAX::Order { id: 'cb6a1d6d-2c78-4da5-9961-14795d0d4379' ... }>

order.cancel
# => #<GDAX::Response { ... }>
```

#### Get account history

```ruby
account = GDAX::Account.list.first
# => #<GDAX::Account { ... }>

account.history
# => #<GDAX::Collection(AccountHistory) [ ... ]>

# without fetching Account first

GDAX::Account.new(id: '...').history
# => #<GDAX::Collection(AccountHistory) [ ... ]>
```

#### Page through orders

```ruby
orders = GDAX::Orders.list
# => #<GDAX::Collection(Order) [ ... ]>

next_page = orders.next
# => #<GDAX::Collection(Order) [ ... ]>
```

#### Make a withdrawal

```ruby
GDAX::Withdrawal.crypto(address: '...', currency: 'BTC', amount: 10)
# => #<GDAX::Response { ... }>
```

## Configuration

#### Required (for authenticated apis)

```ruby
GDAX.api_key # default: ENV['GDAX_API_KEY']
GDAX.api_secret # default: ENV['GDAX_API_SECRET']
GDAX.api_passphrase # default: ENV['GDAX_API_PASSPHRASE']
```

#### Optional

```ruby
GDAX.api_base # default: 'https://api.gdax.com'
GDAX.use_server_time # default: false
```

## Handling Errors

Errors from the GDAX API will be of type `GDAX::APIError`, and will contain `response`. Timeout and network issues will be of type `GDAX::ConnectionError`, a subclass of `GDAX::APIError` with no response informtion.

### Documentation

Coming soon

### Requirements

Ruby 2.1+

### Installation

```
bundle install gdax
```

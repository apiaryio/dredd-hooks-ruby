[![Build Status](https://travis-ci.org/apiaryio/dredd-hooks-template.svg?branch=master)](https://travis-ci.org/apiaryio/dredd-hooks-template)

# Ruby Hooks Handler for Dredd API Testing Framework

Write [Dredd](https://github.com/apiaryio/dredd) [hooks](http://dredd.readthedocs.org/en/latest/hooks/) in Ruby to glue together API Blueprint with your Ruby project

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dredd_worker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dredd_hooks

## Usage

1. Create a hook file in `hooks.rb`:

```ruby
include DreddHooks::Methods

before "Machines > Machines collection > Get Machines" do |transaction|
  transaction['skip'] = "true"
end
```

2. Run it with Dredd

```
$ dredd apiary.apib localhost:3000 --language ruby --hookfiles hooks.rb
```

## API

Module `DreddHooks::Methods` mixes in following methods `before`, `after`, `before_all`, `after_all`, `before_each`, `after_each`, `before_validation`, `before_each_validation`

`before`, `before_validation` `after` hooks are identified by [transaction name](http://dredd.readthedocs.org/en/latest/hooks/#getting-transaction-names).

Usage is very similar to [sync JS hooks API](http://dredd.readthedocs.org/en/latest/hooks/#sync-api)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

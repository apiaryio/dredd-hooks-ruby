Ruby Hooks Handler for Dredd API Testing Framework
==================================================

[![Build Status](https://travis-ci.org/apiaryio/dredd-hooks-ruby.svg?branch=master)](https://travis-ci.org/apiaryio/dredd-hooks-ruby)

Test your API with the [Dredd HTTP API testing framework](https://github.com/apiaryio/dredd) and write [hooks](http://dredd.readthedocs.org/en/latest/hooks/) in Ruby!

Installation
------------

Add the gem to your `Gemfile`:

```ruby
# Gemfile

gem 'dredd_hooks', '0.1.0' # see semver.org
```

Usage
-----

Create a hook file (name is arbitrary):

```ruby
# ./hooks.rb

include DreddHooks::Methods

before "Machines > Machines collection > Get Machines" do |transaction|
  transaction['skip'] = "true"
end
```

Run it with Dredd:

```bash
# note that the hooks file was named ./hooks.rb
dredd apiary.apib localhost:3000 --language ruby --hookfiles ./hooks.rb
```

Documentation
-------------

### API

The `DreddHooks::Methods` module provides the following methods to be used with [transaction names][doc-names].

- `before`
- `after`
- `before_validation`

And these ones to be used without them:

- `before_all`
- `after_all`
- `before_each`
- `after_each`
- `before_each_validation`

See also the official [Hooks documentation][doc-hooks].

  [doc-names]: http://dredd.readthedocs.org/en/latest/hooks/#getting-transaction-names
  [doc-hooks]: https://dredd.readthedocs.org/en/latest/hooks

Change log
----------

Releases are commented to provide a [brief change log][releases], details can be found in the [`CHANGELOG`][changelog] file.

  [releases]: https://github.com/gonzalo-bulnes/dredd-hooks-ruby/releases
  [changelog]: ./CHANGELOG.md

Development
-----------

### Testing

```bash
# Run the test suite
rake
```

Contributing
------------

1. Fork it
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create a new Pull Request

License
-------

See [`LICENSE`][license].

  [license]: ./LICENSE.txt


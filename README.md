Ruby Hooks Handler for Dredd API Testing Framework
==================================================

[![Build Status](https://travis-ci.org/apiaryio/dredd-hooks-ruby.svg?branch=master)](https://travis-ci.org/apiaryio/dredd-hooks-ruby)
[![Dependency Status](https://gemnasium.com/badges/github.com/apiaryio/dredd-hooks-ruby.svg)](https://gemnasium.com/github.com/apiaryio/dredd-hooks-ruby)
[![Code Climate](https://codeclimate.com/github/apiaryio/dredd-hooks-ruby/badges/gpa.svg)](https://codeclimate.com/github/apiaryio/dredd-hooks-ruby)
[![Inline Docs](http://inch-ci.org/github/apiaryio/dredd-hooks-ruby.svg?branch=master)](http://inch-ci.org/github/apiaryio/dredd-hooks-ruby)

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

Create a hook file (the file name is arbitrary):

```ruby
# ./hooks.rb

require 'dredd_hooks/methods'

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

The `DreddHooks::Methods` module provides the following methods to be used with [transaction names][doc-names]:

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

A few [Cucumber][cucumber] features provide an end-to-end test harness, and a set of [RSpec][rspec] specs provide both a more granular documentation and a unit test harness.

RSpec [tags][tags] are used to categorize the spec examples.

Spec examples that are tagged as `public` describe aspects of the gem public API, and MAY be considered as its documentation.

The `private` or `protected` specs are written for development purpose only. Because they describe internal behaviour which may change at any moment without notice, they are only executed as a secondary task by the [continuous integration service][travis] and SHOULD be ignored.

Run `rake spec:public` to print the gem public documentation.

  [cucumber]: https://github.com/cucumber/cucumber-rails
  [rspec]: https://www.relishapp.com/rspec
  [tags]: https://www.relishapp.com/rspec/rspec-core/v/3-4/docs/command-line/tag-option
  [travis]: https://travis-ci.org/gonzalo-bulnes/simple_token_authentication/builds

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


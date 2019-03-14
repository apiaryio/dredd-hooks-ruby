# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [0.1.3] - 2019-03-14

## Added

- Allow `--host` and `--port` to be set via CLI.
- Ex: `dredd-hooks-ruby hooks.rb --host 0.0.0.0 --port 12345`
- See https://github.com/apiaryio/dredd/issues/748#issuecomment-473010416 for more context.

## [0.1.2] - 2016-12-30

## Fixed

- Do not raise `UnknownHookError` when `NoMethodError` is raised inside of a hook block - @nicolasiensen

## [0.1.1] - 2016-11-13

### Added

- Alert the user when no hook files are found - @jeffdeville

## [0.1.0] - 2016-08-06

### Added

- This change log : )
- Possibility to use DreddHooks::Server as a library (see DreddHooks::CLI for an example)

### Changed

- Started using the Semantic Versioning convention

### Fixed

- The test suite can be used locally (it is a workaround only)

## 0.0.1 - 2015-07-07

### Added

- Ability to write Dredd hooks in Ruby

## Previously

The original [proof of concept][poc] was written by @netmilk.


[0.1.3]: https://github.com/apiaryio/dredd-hooks-ruby/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/apiaryio/dredd-hooks-ruby/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/apiaryio/dredd-hooks-ruby/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/apiaryio/dredd-hooks-ruby/compare/v0.0.1...v0.1.0
[poc]: https://github.com/gonzalo-bulnes/dredd-rack/issues/7#issue-70936733

## Inspiration

See http://keepachangelog.com and take part of the discussion!


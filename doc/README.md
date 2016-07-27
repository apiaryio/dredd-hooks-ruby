How to Add New Hooks
====================

Dredd does support new hooks? It's time to extend the Ruby DSL!

Most of the new hooks definition is automated, but not everything yet.
In order to enable your new hook:

1. Determine if the hook is specific to a transaction or applies to all of them
1. Add the _registration_ and _run_ method to the [runner spec][runner-spec]
1. Add the DSL method to the [DSL spec][methods-spec]
1. Add the usage example to the [**Execution order** feature][feature]
1. Run the entire test suite and watch the tests fail (start worrying if they don't!)
1. Add the hook name to the corresponding list in the [definitions file][def]
1. Add the corresponding Dredd **event** to the [events definition][events-handler] (be careful, the hooks order does matter!)
1. Run the test suite and watch it pass : )

Finally, bump the [_minor_][semver] version number, update the `README`, the `CHANGELOG` and do anything you need to do in order to release!

  [def]: ../lib/dredd_hooks/definitions.rb
  [events-handler]: ../lib/dredd_hooks/server/events_handler.rb

  [runner-spec]: ../spec/lib/dredd_hooks/runner_spec.rb
  [methods-spec]: ../spec/lib/dredd_hooks/methods_spec.rb
  [feature]: ../features/execution_order.feature
  [semver]: http://semver.org


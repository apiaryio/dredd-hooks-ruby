Feature: TCP server and messages

Scenario: TCP server
  When I run `dredd-hooks-ruby` interactively
  And I wait for output to contain "Starting"
  Then It should start listening on localhost port "61321"


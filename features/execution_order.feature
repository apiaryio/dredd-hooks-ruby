Feature: Execution order

  Background:
    Given I have Dredd installed
    And a file named "apiary.apib" with:
      """
      # My Api
      ## GET /message
      + Response 200 (text/plain)

              Hello World!
      """
    And a file "server.js" with a server responding on "http://localhost:4567/message" with "Hello World!"

  Scenario:
    Given a file named "hookfile.rb" with:
      """
      require 'dredd_hooks/methods'
      include DreddHooks::Methods

      key = 'hooks_modifications'

      before("/message > GET") do |transaction|
        transaction[key] ||= []
        transaction[key].push "before modification"
      end

      after("/message > GET") do |transaction|
        transaction[key] ||= []
        transaction[key].push "after modification"
      end

      before_validation("/message > GET") do |transaction|
        transaction[key] ||= []
        transaction[key].push "before validation modification"
      end

      before_all do |transaction|
        transaction[0][key] ||= []
        transaction[0][key].push "before all modification"
      end

      after_all do |transaction|
        transaction[0][key] ||= []
        transaction[0][key].push "after all modification"
      end

      before_each do |transaction|
        transaction[key] ||= []
        transaction[key].push "before each modification"
      end

      before_each_validation do |transaction|
        transaction[key] ||= []
        transaction[key].push "before each validation modification"
      end

      after_each do |transaction|
        transaction[key] ||= []
        transaction[key].push "after each modification"
      end
      """
    And I set the environment variables to:
      | variable                       | value      |
      | TEST_DREDD_HOOKS_HANDLER_ORDER | true       |

    When I run `dredd ./apiary.apib http://localhost:4567 --server="node server.js" --language="bundle exec dredd-hooks-ruby" --hookfiles=./hookfile.rb --loglevel=debug`
    Then the exit status should be 0
    And the output should contain:
      """
      0 before all modification
      1 before each modification
      2 before modification
      3 before each validation modification
      4 before validation modification
      5 after modification
      6 after each modification
      7 after all modification
      """

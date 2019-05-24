Feature: Failing a transaction

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
      before("/message > GET") do |transaction|
        transaction['fail'] = "Yay! Failed!"
      end
      """
    When I run `dredd ./apiary.apib http://localhost:4567 --server="node server.js" --language="bundle exec dredd-hooks-ruby" --hookfiles=./hookfile.rb --loglevel=debug`
    Then the exit status should be 1
    And the output should contain:
      """
      Yay! Failed!
      """

Feature: Multiple hook files with a glob

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
    Given a file named "hookfile1.rb" with:
      """
      require 'dredd_hooks/methods'
      include DreddHooks::Methods
      before("/message > GET") do |transaction|
        puts "It's me, File1"
      end
      """
    And a file named "hookfile2.rb" with:
      """
      require 'dredd_hooks/methods'
      include DreddHooks::Methods
      before("/message > GET") do |transaction|
        puts "It's me, File2"
      end
      """
    And a file named "hookfile_glob.rb" with:
      """
      require 'dredd_hooks/methods'
      include DreddHooks::Methods
      before("/message > GET") do |transaction|
        puts "It's me, File3"
      end
      """
    When I run `dredd ./apiary.apib http://localhost:4567 --server="node server.js" --language="bundle exec dredd-hooks-ruby" --hookfiles=./hookfile1.rb --hookfiles=./hookfile2.rb --hookfiles=./hookfile_*.rb --loglevel=debug`
    Then the exit status should be 0
    And the output should contain:
      """
      It's me, File1
      """
    And the output should contain:
      """
      It's me, File2
      """
    And the output should contain:
      """
      It's me, File3
      """

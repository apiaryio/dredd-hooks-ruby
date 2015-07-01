Feature: Execution order

  Background:
    Given I have "dredd-hooks-ruby" command installed
    And I have "dredd" command installed
    And a file named "server.rb" with:
      """
      require 'sinatra'
      get '/message' do
        "Hello World!\n\n"
      end
      """

    And a file named "apiary.apib" with:
      """
      # My Api
      ## GET /message
      + Response 200 (text/html;charset=utf-8)
          Hello World!
      """

  @debug
  Scenario:
    Given a file named "hookfile.rb" with:
      """
      include DreddHooks::Methods

      key = 'hooks_modifications'

      before("/message > GET") do |transaction|
        transaction[key] = [] if transaction[key].nil?
        transaction[key].push "before modification"
      end

      after("/message > GET") do |transaction|
        transaction[key] = [] if transaction[key].nil?
        transaction[key].push "after modification"
      end

      before_validation("/message > GET") do |transaction|
        transaction[key] = [] if transaction[key].nil?
        transaction[key].push "before validation modification"
      end

      before_all do |transaction|
        transaction[0][key] = [] if transaction[0][key].nil?
        transaction[0][key].push "before all modification"
      end

      after_all do |transaction|
        transaction[0][key] = [] if transaction[0][key].nil?
        transaction[0][key].push "after all modification"
      end

      before_each do |transaction|
        transaction[key] = [] if transaction[key].nil?
        transaction[key].push "before each modification"
      end

      before_each_validation do |transaction|
        transaction[key] = [] if transaction[key].nil?
        transaction[key].push "before each validation modification"
      end

      after_each do |transaction|
        transaction[key] = [] if transaction[key].nil?
        transaction[key].push "after each modification"
      end

      """
    Given I set the environment variables to:
      | variable                       | value      |
      | TEST_DREDD_HOOKS_HANDLER_ORDER | true       |
    When I run `dredd ./apiary.apib http://localhost:4567 --server "ruby server.rb" --language dredd-hooks-ruby --hookfiles ./hookfile.rb`
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

Feature: Hook handlers

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

      before("/message > GET") do |transaction|
        puts "before hook handled"
      end

      after("/message > GET") do |transaction|
        puts "after hook handled"
      end

      before_validation("/message > GET") do |transaction|
        puts "before validation hook handled"
      end

      before_all do |transaction|
        puts "before all hook handled"
      end

      after_all do |transaction|
        puts "after all hook handled"
      end

      before_each do |transaction|
        puts "before each hook handled"
      end

      before_each_validation do |transaction|
        puts "before each validation hook handled"
      end

      after_each do |transaction|
        puts "after each hook handled"
      end

      """

    When I run `dredd ./apiary.apib http://localhost:4567 --server "ruby server.rb" --language dredd-hooks-ruby --hookfiles ./hookfile.rb`
    Then the exit status should be 0
    And the output should contain:
      """
      before hook handled
      """
    And the output should contain:
      """
      before validation hook handled
      """
    And the output should contain:
      """
      after hook handled
      """
    And the output should contain:
      """
      before each hook handled
      """
    And the output should contain:
      """
      before each validation hook handled
      """
    And the output should contain:
      """
      after each hook handled
      """
    And the output should contain:
      """
      before all hook handled
      """
    And the output should contain:
      """
      after all hook handled
      """

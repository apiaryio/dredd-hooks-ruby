Feature: Multiple hookfiles with a glob

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
    Given a file named "hookfile1.rb" with:
      """
      include DreddHooks::Methods
      before("/message > GET") do |transaction|
        puts "It's me, File1"
      end
      """
    And a file named "hookfile2.rb" with:
      """
      include DreddHooks::Methods
      before("/message > GET") do |transaction|
        puts "It's me, File2"
      end
      """
    And a file named "hookfile_to_be_globed.rb" with:
      """
      include DreddHooks::Methods
      before("/message > GET") do |transaction|
        puts "It's me, File3"
      end
      """
    When I run `dredd ./apiary.apib http://localhost:4567 --server "ruby server.rb" --language dredd-hooks-ruby --hookfiles ./hookfile1.rb --hookfiles ./hookfile2.rb --hookfiles ./hookfile_*.rb`
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
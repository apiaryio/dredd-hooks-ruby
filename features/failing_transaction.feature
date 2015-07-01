Feature: Failing a transacstion

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
        transaction['fail'] = "Yay! Failed in ruby!"
      end
      """
    When I run `dredd ./apiary.apib http://localhost:4567 --server "ruby server.rb" --language dredd-hooks-ruby --hookfiles ./hookfile.rb`
    Then the exit status should be 1
    And the output should contain:
      """
      Yay! Failed in ruby!
      """

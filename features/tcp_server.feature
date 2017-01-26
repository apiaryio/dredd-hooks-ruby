Feature: TCP server and messages

Background:
  Given I run `dredd-hooks-ruby` interactively
  And I run `sleep 2`

Scenario: TCP server
  Then it should start listening on localhost port "61321"

Scenario: Message exchange for event beforeEach
  When I connect to the server
  And I send a JSON message to the socket:
    """
    {"event": "beforeEach", "uuid": "1234-abcd", "data": {"key":"value"}}
    """
  And I send a newline character as a message delimiter to the socket
  Then I should receive same response
  And I should be able to gracefully disconnect

Scenario: Message exchange for event beforeEachValidation
  When I connect to the server
  And I send a JSON message to the socket:
    """
    {"event": "beforeEachValidation", "uuid": "2234-abcd", "data": {"key":"value"}}
    """
  And I send a newline character as a message delimiter to the socket
  Then I should receive same response
  And I should be able to gracefully disconnect

Scenario: Message exchange for event afterEach
  When I connect to the server
  And I send a JSON message to the socket:
    """
    {"event": "afterEach", "uuid": "3234-abcd", "data": {"key":"value"}}
    """
  And I send a newline character as a message delimiter to the socket
  Then I should receive same response
  And I should be able to gracefully disconnect

Scenario: Message exchange for event beforeAll
  When I connect to the server
  And I send a JSON message to the socket:
    """
    {"event": "beforeAll", "uuid": "4234-abcd", "data": {"key":"value"}}
    """
  And I send a newline character as a message delimiter to the socket
  Then I should receive same response
  And I should be able to gracefully disconnect

Scenario: Message exchange for event afterAll
  When I connect to the server
  And I send a JSON message to the socket:
    """
    {"event": "afterAll", "uuid": "5234-abcd", "data": {"key":"value"}}
    """
  And I send a newline character as a message delimiter to the socket
  Then I should receive same response
  And I should be able to gracefully disconnect

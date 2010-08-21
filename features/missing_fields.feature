Feature: Missing Fields
  In order to provide reliable tests
  Steps referering to elements not found on a form should fail

  Scenario: Failing Steps
    Given I am on the blank form
    When I fill in a nonexistent text field an error should be raised
    When I select a nonexistent select field an error should be raised
    When I choose a nonexistent radio button an error should be raised
    When I check a nonexistent check box an error should be raised
    When I press a nonexistent button an error should be raised
    When I select a missing option from an existing select an error should be raised

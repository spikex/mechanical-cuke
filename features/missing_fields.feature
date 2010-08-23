Feature: Missing Fields
  In order to provide reliable tests
  Steps referering to elements not found on a form should fail

  Scenario: Missing Fields
    Given I am on the blank form
    When I fill in a nonexistent text field an error should be raised
    When I select a nonexistent select field an error should be raised
    When I choose a nonexistent radio button an error should be raised
    When I check a nonexistent checkbox an error should be raised
    When I press a nonexistent button an error should be raised
    When I select a missing option from an existing select an error should be raised

  Scenario: Missing Link
    Given I am on the blank form
    When I follow a nonexistent link an error should be raised

  Scenario: Checking Values of Missing Fields
    Given I am on the blank form
    When I test the value of a nonexistent field contains an error should be raised
    When I test state of a nonexistent checkbox contains an error should be raised




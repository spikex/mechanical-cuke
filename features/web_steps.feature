Feature: Using Mechanize
  In order to test web sites over HTTP
  I want to be able to interacted with sites using Mechanize

  Scenario: Navigation Steps
    Given I am on the index page
    Then I should be on the index page
    When I go to the index page
    Then I should be on the index page
    When I follow "Form Link"
    Then I should be on the form page

  Scenario: Should See Steps
    Given I am on the index page
    Then I should see "Hello World!"
    And I should see /Hel+o.World./
    But I should not see "Oogy Boogy!"
    And I should not see /[Oo]+gy Bo+gy/

  Scenario: Form Steps
    Given I am on the form page
    When I fill in "Field by Label" with "Label Field"
    And I fill in "Name Field" for "field_by_name"
    And I fill in "field_by_id_id" with "ID Field"
    And I fill in "Text Area by Label" with "Text Area Text"
    And I fill in "Password by Label" with "Password Text"
    And I select "Option Two" from "Select by Name"
    And I choose "Radio Button One" 
    And I check "Unchecked Box"
    And I uncheck "Checked Box"
    And I press "Submit"
    Then I should see "Label Field"
    And I should see "Name Field"
    And I should see "Option Two"
    And I should see "Text Area Text"
    And I should see "Password Text"
    And I should see "Radio Button One Chosen"
    But I should not see "Option One"
    And I should not see "Radio Button Two Chosen"
    And I should see "Unchecked Box Checked"
    But I should not see "Checked Box Checked"

  Scenario: Form Value Steps
    Given I am on the form page
    Then the "Checked Box" checkbox should be checked
    And the "Unchecked Box" checkbox should not be checked
    When I fill in "Field by Label" with "Label Field"
    Then the "Field by Label" field should contain "Label Field"
    And the "Field by Label" field should not contain "Oogy Boogy"

  Scenario: Form Table Steps
    Given I am on the form page
    When I fill in the following:
    | Field by Label | Labeled |
    | field_by_name  | Named |
    | field_by_id_id | ID-ed |
    And I press "Submit"
    Then I should see "Labeled"
    And I should see "Named"
    And I should see "ID-ed"

  Scenario: Basic Auth
    Given I have no basic auth credentials
    Then I should not be able to access the protected page
    Given I have basic auth credentials "username:password"
    When I go to the protected page
    Then I should see "Authorized!"
    
@mock_launchy
  Scenario: Save and Open Step
    Given I am on the index page
    Then show me the page

  Scenario: Attach File Step
    Given I am on the upload page
    When I attach the file "test/fixtures/hello.txt" to "upload"
    And I press "Submit"
    Then I should see "File hello.txt uploaded"



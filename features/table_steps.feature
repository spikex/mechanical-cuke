Feature: Table Steps
  Even though tableish is part of Cucumber
  I need to make sure it works with Mechanize
  (because it depends on body_respose being defined).

  Scenario: I should see the following table
    Given I am on the table page
    Then I should see the following table:
    | Column One | Column Two |
    | One        | Two        |
    | Three      | Four       |


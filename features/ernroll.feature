# ../features/enroll.feature

Feature: As user I want to enroll/signup a takehome 
  Scenario: Enroll a takehome
    Given I at homepage
    And I click button with text "Enroll Now"
    And I fill the credential
    When I click "Sign Up" button
    Then I should see "take home test" course on My Courses page
# ../features/enroll.feature

Feature: As user I want to enroll and complete a take home test
  Scenario: Enroll and complete a takehome
    Given I at homepage
    And I click button with text "Enroll Now"
    And I fill the credential
    When I click "Sign Up" button
    And I see "take home test" course on My Courses page
    And I click "take home test" course 
    And I complete the all the course
    Then I should see all my lecture completed
    
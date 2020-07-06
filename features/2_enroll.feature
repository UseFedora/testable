# feature/2_enroll.feature
Feature:
  As a user, I should be able to enroll in a course

  Scenario: Enroll into a course
    Given I am not enrolled in the school
    When I sign up to the school
    And I click on course box
    And I click on enroll button
    Then I should be enrolled in course 
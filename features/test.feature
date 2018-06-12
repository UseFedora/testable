Feature: As a student I should be able to enroll a course and complete it


  Background: setup - create an user
    Given I am on the sign up page
    Given I enter all required information and register

  Scenario: Verify that a student can enroll in a course and can complete it
    Given I enroll in a course with name "take home test"
    Then I verify that I can complete the course
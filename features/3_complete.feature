# feature/3_complete.feature
Feature: 
    As a user, I should be able to complete a course

    Scenario: Complete course
        Given I am logged out of the school
        When I log in to complete a course
        And I visit an enrolled course
        And I visit the first lecture page
        And I complete the lectures
        And I complete the quiz
        Then I should be complete with the course
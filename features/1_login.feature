# feature/1_login.feature
Feature:
  As an user, I should be able to login to my school

  Scenario: Login from Marketing Site
    Given I am on the school homepage
    When I click Login link
    And I fill my credential
    Then I should be logged in
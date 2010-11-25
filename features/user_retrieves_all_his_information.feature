Feature: User retrieves all his information
  In order to scape from Facebook's world dominance plan
  As a intelligent user
  I want to be able to retrieve all the information about my account
  And store it locally on my computer.

Scenario: User retrieves his name
  Given the "demo-user-1" Facebook account exists
  And I have given permission to Goof to access all my information 
  When I retrieve all information
  Then I should see "Name: Federico"
  





  

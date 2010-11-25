Given /^the Federico Facebook account exists$/ do
end

Given /^I have given permission to Goof to access all my information$/ do
  visit "home/index"
  click_link "connect to facebook"  
end

When /^I retrieve all information$/ do
  visit "home/index"  
  click_link "Get file"
end

Then /^the exported file should contain the attribute "([^"]*)" with value "([^"]*)"$/ do |arg1, arg2|    
end
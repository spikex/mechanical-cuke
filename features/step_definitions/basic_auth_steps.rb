Given /^I have no basic auth credentials$/ do
  basic_auth(nil, nil)
end

Then /^I should not be able to access (.+)$/ do |page_name|
  assert_raise(Mechanize::ResponseCodeError) { get path_to(page_name) }   
end

Given /^I have basic auth credentials "([^\"]*)"$/ do |credentials|
  username, password = credentials.split(':')
  basic_auth(username, password)
end

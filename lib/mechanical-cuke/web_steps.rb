Given /^(?:|I )am on (.+)$/ do |page_name|
  get path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  get path_to(page_name)
end

When /^(?:|I )press "([^\"]*)"$/ do |value|
  button = form.submits.find{|f| f.value == value}
  raise "Can't find button \"#{value}\"" if button.nil?
  form.click_button(button)
end

When /^(?:|I )follow "([^\"]*)"$/ do |link|
  l = current_page.link_with(:text => link)
  raise "Can't find link \"#{link}\"" if l.nil?
  l.click
end

When /^(?:|I )fill in "([^\"]*)" with "([^\"]*)"$/ do |field, value|
  f = find_field(field)
  raise "Can't find field \"#{field}\"" if f.nil?
  f.value = value
end

When /^(?:|I )fill in "([^\"]*)" for "([^\"]*)"$/ do |value, field|
  f = find_field(field)
  raise "Can't find field \"#{field}\"" if f.nil?
  f.value = value
end

When /^(?:|I )fill in the following:$/ do | fields|
  fields.rows_hash.each do |name, value|
    When %{I fill in "#{name}" with "#{value}"}
  end
end

When /^(?:|I )select "([^\"]*)" from "([^\"]*)"$/ do |value, field|
  f = find_field(field)
  raise "Can't find field \"#{field}\"" if f.nil?
  option = f.option_with(:value => value)
  raise "Can't find option #{value} for \"#{field}\"" if option.nil?
  option.select
end


When /^(?:|I )check "([^\"]*)"$/ do |field|
  cb = find_checkbox(field)
  raise "Can't find check box \"#{field}\"" if cb.nil?
  cb.checked = true
end

When /^(?:|I )uncheck "([^\"]*)"$/ do |field|
  cb = find_checkbox(field)
  raise "Can't find check box \"#{field}\"" if cb.nil?
  cb.checked = false
end

When /^(?:|I )choose "([^\"]*)"$/ do |field|
  r = find_radiobutton(field)
  raise "Can't find radio button \"#{field}\"" if r.nil?
  r.check
end

When /^(?:|I )attach the file "([^\"]*)" to "([^\"]*)"$/ do |path, field|
  form.file_upload_with(:name => field).file_name = path
end

Then /^(?:|I )should see "([^\"]*)"$/ do |text|
  if defined?(Spec::Rails::Matchers)
    response.should contain(text)
  else
    assert current_page.body.include?(text)
  end
end


Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)
  if defined?(Spec::Rails::Matchers)
    page.should have_xpath('//*', :text => regexp)
  else
    assert_match regexp, current_page.body
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)
  if defined?(Spec::Rails::Matchers)
    page.should have_not_xpath('//*', :text => regexp)
  else
    assert_no_match regexp, current_page.body
  end
end

But /^(?:|I )should not see "([^\"]*)"$/ do |text|
  if defined?(Spec::Rails::Matchers)
    response.should_not contain(text)
  else
    assert !current_page.body.include?(text)
  end
end

Then /^the "([^\"]*)" field should contain "([^\"]*)"$/ do |field, value|
  f = find_field(field)
  raise "Can't find field \"#{field}\"" if f.nil?
  if defined?(Spec::Rails::Matchers)
    f.should == field
  else
    assert_equal value, f.value
  end
end

Then /^the "([^\"]*)" field should not contain "([^\"]*)"$/ do |field, value|
  f = find_field(field)
  raise "Can't find field \"#{field}\"" if f.nil?
  if defined?(Spec::Rails::Matchers)
    f.should_not == value
  else
    assert_not_equal value, f.value
  end
end

Then /^the "([^\"]*)" checkbox should be checked$/ do |label|
  cb = find_checkbox(label)
  raise "Can't find check box \"#{label}\"" if cb.nil?
  if defined?(Spec::Rails::Matchers)
    cb.checked.should be true
  else
    assert cb.checked
  end
end

Then /^the "([^\"]*)" checkbox should not be checked$/ do |label|
  cb = find_checkbox(label)
  raise "Can't find check box \"#{label}\"" if cb.nil?
  if defined?(Spec::Rails::Matchers)
    cb.checked.should be true
  else
    assert !cb.checked
  end
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = current_page.uri.to_s
  if defined?(Spec::Rails::Matchers)
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^show me the page$/ do
  filename = save_page(current_page)
  open_in_browser(filename) unless filename.nil?
end

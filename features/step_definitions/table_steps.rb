require 'cucumber/web/tableish'

Then /^I should see the following table:$/ do |expected_layouts_table|
  expected_layouts_table.diff!(tableish("table#table tr", 'td,th'))
end

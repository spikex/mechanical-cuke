When /^I (?:fill in|select|choose|check|press) a nonexistent (.+) an error should be raised$/ do |type|

  case type
  when "text field" then
    assert_raise(RuntimeError) do
      When %{I fill in "nonexistent" with "anything"}
    end
  when "select field" then
    assert_raise(RuntimeError) do
      When %{I select "anything" from "nonexistent"}
    end
  when "radio button" then
    assert_raise(RuntimeError) do
      When %{I choose "nonexistent"}
    end
  when "check box" then
    assert_raise(RuntimeError) do
      When %{I check "nonexistent"}
    end
  when "button" then
    assert_raise(RuntimeError) do
      When %{I press "nonexistent"}
    end
  else assert false
  end
end

When /^I follow a nonexistent link an error should be raised$/ do 
  assert_raise(RuntimeError) do
    When %{I follow "nonexistent"}
  end
end

When /^I select a missing option from an existing select an error should be raised$/ do
  assert_raise(RuntimeError) do
    When %{I select "nonexistent" from "Exists"}
  end
end

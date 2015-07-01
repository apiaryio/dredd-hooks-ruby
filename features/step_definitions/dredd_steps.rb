Given(/^I have "([^"]*)" command installed$/) do |command|
  is_present = system("which #{ command} > /dev/null 2>&1")
  raise "Command #{command} is not present in the system" if not is_present
end

Given(/^server under test is running$/) do
end

When(/^I run:$/) do |string|
  step "I run `#{string}`"
end

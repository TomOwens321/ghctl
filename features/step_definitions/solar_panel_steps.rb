require 'solar_panel'

Given(/^I have a solar panel$/) do
  @panel = create :solar_panel
end

When(/^a reservoir requests heat$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the solar panel will provide heat if it is warmer$/) do
  pending # express the regexp above with the code you wish you had
end

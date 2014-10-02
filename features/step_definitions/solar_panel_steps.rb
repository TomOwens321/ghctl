require 'solar_panel'
require 'thermometer'

Given(/^I have a solar panel$/) do
  therm = build :thermometer
  @panel = build( :solar_panel, :thermometer => therm )
end

When(/^a reservoir requests heat$/) do
  @reservoir = build :thermometer
end

Then(/^the solar panel will provide heat if it is warmer$/) do
  pending # express the regexp above with the code you wish you had
end

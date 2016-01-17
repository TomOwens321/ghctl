Feature: Solar Panel
  As a greenhouse full of plants
  I wish to implement a solar collector to provide additional heat
  So the plants may thrive

Scenario: Request to add heat to a reservoir
  Given I have a solar panel
  When a reservoir requests heat
  Then the solar panel will provide heat if it is warmer
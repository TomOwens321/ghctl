#!/usr/bin/env ruby
$:.unshift File.dirname(__FILE__), 'lib', 'lib/devices'

require 'onewire'
require 'config'
require 'thermometer'
require 'device'
require 'owfuncs'

therms = []
host   = 'localhost'

$SCALE = :fahrenheit
begin
  client = Onewire.client host

thermsFound = OwFuncs.find_thermometers host
rescue
  puts "Unable to connect to OneWire devices."
end

unless thermsFound.nil?
  thermsFound.each do |id|
    config = THERMOMETERS.select {|t| t[:id].match(/#{id}/)}[0]
    therm = Thermometer.new client, id
    therm.name = config.nil? ? "Therm-#{id}" : config[:name]
    therm.location = config.nil? ? "Location Unknown" : config[:location]
    therms << therm
    Device.register_device therm
  end
end
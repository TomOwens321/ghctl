#!/usr/bin/env ruby
require 'onewire'
require './lib/config'
require './lib/thermometer'
require './lib/thermo_monitor'
require './lib/owfuncs'

therms = []
host   = 'greenhousepi'

$SCALE = :fahrenheit
client = Onewire.client host
monitor = ThermoMonitor.new
thermsFound = OwFuncs.find_thermometers host

thermsFound.each do |id|
	config = THERMOMETERS.select {|t| t[:id].match(/#{id}/)}[0]
	therm = Thermometer.new client, id
	therm.name = config.nil? ? "Therm-#{id}" : config[:name]
	therm.location = config.nil? ? "Location Unknown" : config[:location]
	therms << therm
	monitor.register therm
end

monitor.run

loop do
	sleep 600
end


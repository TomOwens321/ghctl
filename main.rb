require 'onewire'
require './lib/thermometer'
require './lib/thermo_monitor'
require './lib/owfuncs'

therms = []
host   = 'bob'

client = Onewire.client host
monitor = ThermoMonitor.new
thermsFound = OwFuncs.find_thermometers host

thermsFound.each do |id|
	therm = Thermometer.new client, id
	therm.name = "Therm-#{id}"
	therms << therm
	monitor.register therm
end

monitor.run

loop do
	sleep 600
end


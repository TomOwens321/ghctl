require 'onewire'
require './lib/thermometer'
require './lib/logger'
require './lib/owfuncs'

therms = []
host   = 'localhost'

client = Onewire.client host
logger = Logger.new
thermsFound = OwFuncs.find_thermometers host

thermsFound.each do |id|
	therm = Thermometer.new client, id
	therm.name = "Therm-#{id}"
	therms << therm
	logger.register therm
end

logger.run

loop do
	sleep 600
end


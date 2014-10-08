require 'onewire'
require './lib/thermometer'
require './lib/logger'
require './lib/owfuncs'

host = 'towens.com'
client = Onewire.client host
logger = Logger.new
therms = OwFuncs.find_thermometers host

therms.each do |l|
	therm = Thermometer.new client, l
	therm.name = "Therm-#{l}"
	logger.register therm
end


logger.run
sleep 600


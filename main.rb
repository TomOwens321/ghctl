require 'onewire'
require './lib/thermometer'
require './lib/logger'

client = Onewire.client 'towens.com'
logger = Logger.new

1.times do |l|
	therm = Thermometer.new client, client.dir[l]
	#therm.name = "Thermometer-#{l}"
	logger.register therm
end


logger.run
sleep 60
#logger.stop
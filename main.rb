require 'onewire'
require './lib/thermometer'
require './lib/logger'

client = Onewire.client 'localhost'
logger = Logger.new

4.times do |l|
	therm = Thermometer.new client, client.dir[l]
	therm.name = "Thermometer-#{l}"
	logger.register therm
end


logger.run
sleep 600
<<<<<<< HEAD
#logger.stop
=======
#logger.stop
>>>>>>> c81b8a515dc39c258c351f9afb334da4e370846a

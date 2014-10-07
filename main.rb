require 'onewire'
require './lib/thermometer'
require './lib/logger'

client = Onewire.client 'towens.com'
path = client.dir[0]

therm = Thermometer.new client, path

puts therm.temperature

logger = Logger.new
logger.register therm

logger.run
sleep 60
logger.stop
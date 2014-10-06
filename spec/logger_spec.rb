require 'spec_helper'
require 'logger'

describe Logger do

	before :each do
		@logger = Logger.new
	end

	it "registers devices" do
		dev1 = "device1"
		dev2 = "device2"
		@logger.register( dev1 )
		expect(@logger.thermometers).to include(dev1)
		@logger.register( dev2 )
		expect(@logger.thermometers).to include(dev2)
	end

	it "unregisters devices" do
		dev1 = "device1"
		dev2 = "device2"
		@logger.register( dev1 )
		@logger.register( dev2 )
		@logger.unregister( dev1 )
		expect(@logger.thermometers).to include(dev2)
		expect(@logger.thermometers).to_not include(dev1)
	end

end
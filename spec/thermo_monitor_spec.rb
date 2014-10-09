require 'spec_helper'
require 'thermo_monitor'

describe ThermoMonitor do

	before :each do
		@logger = ThermoMonitor.new
	end

	it "registers devices" do
		dev1 = "device1"
		dev2 = "device2"
		@logger.register( dev1 )
		expect(@logger.thermometers).to include(:thermometer => dev1, :lastTemp => '0')
		@logger.register( dev2 )
		expect(@logger.thermometers).to include(:thermometer => dev2, :lastTemp => '0')
	end

	it "unregisters devices" do
		dev1 = "device1"
		dev2 = "device2"
		@logger.register( dev1 )
		@logger.register( dev2 )
		@logger.unregister( dev1 )
		expect(@logger.thermometers).to include(:thermometer => dev2, :lastTemp => '0')
		expect(@logger.thermometers).to_not include(:thermometer => dev1, :lastTemp => '0')
	end

end
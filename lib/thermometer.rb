require 'onewire'

class Thermometer < Onewire::Scope
    
    attr_accessor :name, :location, :id

	def initialize( client, path )
		@id = path
		@name = path
		@location = ""
		super
	end

	def temperature
		self.read 'temperature'
	end

	def highTempAlarm=( highTempLimit )
		self.write( 'temphigh', highTempLimit )
		highTempLimit
	end

	def highTempAlarm
		self.read( 'temphigh' )
	end

	def lowTempAlarm=( lowTempLimit )
		self.write( 'templow', lowTempLimit )
		lowTempLimit
	end

	def lowTempAlarm
		self.read( 'templow' )
	end

end
$:.unshift File.dirname(__FILE__), 'lib', 'lib/devices'

require 'onewire'
require 'device'

class Thermometer < Onewire::Scope
    
    attr_accessor :name, :location, :id, :scale
    attr_reader :requests

	def initialize( client, path )
		@id = path
		@name = path
		@location = ""
		@scale = $SCALE
		begin
		  super
		rescue
			puts "Unable to talk to owHost"
		end
	end

	def temperature
    begin
    	tmp = self.read( 'fasttemp' )
			temp_scale( tmp )
    rescue
      puts "Unable to read temperature."
    end
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

	def temp_scale( temperature )
		return temperature.to_f * 9/5 + 32 if @scale == :fahrenheit
		return temperature.to_f
	end

end

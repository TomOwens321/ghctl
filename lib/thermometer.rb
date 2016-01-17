require 'onewire'

class Thermometer < Onewire::Scope
    
    attr_accessor :name, :location, :id, :scale

	def initialize( client, path )
		@id = path
		@name = path
		@location = ""
		@scale = $SCALE
		super
	end

	def temperature
            begin
		temp_scale( self.read 'fasttemp' )
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

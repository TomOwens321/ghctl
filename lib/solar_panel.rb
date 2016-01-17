class SolarPanel

	attr_accessor :name

	def initialize( devices )
		@name = ""
		@thermometer = devices[:thermometer]
		@control = devices[:control]
	end

	def temperature
		@thermometer.temperature
	end

	def control
		@control.state
	end

	def control=( state )
		@control.state = state
	end

end
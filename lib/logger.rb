class Logger

	attr_reader :thermometers

	def initialize
		@thermometers = []
	end

	def register( device )
		@thermometers << device
		@thermometers.flatten!
	end

	def unregister( device )
		@thermometers.delete_if { |t| t == device }
	end

	

end
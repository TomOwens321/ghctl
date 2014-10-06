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

	def run
		@running = Thread.new do
			10.times do |t|
				puts "Loop count #{t}"
				sleep 2
			end
		end
	end

	def stop
		@running.kill
	end

end
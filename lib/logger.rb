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
			while @thermometers.size > 0 do
				@thermometers.each do |t|
					puts "#{t.name} : #{t.temperature}"
				end
				sleep 10
			end
		end
	end

	def stop
		@running.kill
	end

end
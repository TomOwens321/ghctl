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
				puts "--------------------------------------------"
				@thermometers.each do |t| 
					begin
					  temp = t.temperature
					  puts "%-24s : %07.3f : %06.2f" % [t.name,  temp, temp * 9/5 + 32]
					rescue
					  puts "Error communicating with #{t.name}"
					end
				end
				sleep 10
			end
		end
	end

	def stop
		@running.kill
	end

end

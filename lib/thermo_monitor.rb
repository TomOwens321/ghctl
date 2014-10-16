require './lib/logger'

class ThermoMonitor

	attr_reader :thermometers

	def initialize
		@thermometers = []
	end

	def register( device )
		newdev = {:thermometer => device, :lastTemp => '0'}
		@thermometers.push newdev
		@thermometers.flatten!
	end

	def unregister( device )
		@thermometers.delete_if { |t| t[:thermometer] == device }
	end

	def run
		Logger.write_log_file_with_timestamp "-=< Temperature Logger Restart >=-"
		@running = Thread.new do
			while @thermometers.size > 0 do
				#puts "--------------------------------------------"
				@thermometers.each do |t| 
					begin
					  temp = t[:thermometer].temperature
					  unless t[:lastTemp] == temp
					    #puts "%-24s : %07.3f : %06.2f" % [t[:thermometer].name,  temp, temp * 9/5 + 32]
					    log_it(t, temp)
					    t[:lastTemp] = temp
					  end
					rescue
					  puts "Error communicating with #{t[:thermometer].name}"
					  Logger.write_log_file_with_timestamp "!!! Error communicating with #{t[:thermometer].name}"
					end
				end
				sleep 60
			end
		end
	end

	def stop
		Logger.write_log_file_with_timestamp "-=< Temperature Logger Shutdown >=-"
		@running.kill
	end

	def log_it(thermometer, temperature )
		message = "TEMPLOG : #{thermometer[:thermometer].name} | %07.3f" % [temperature]
		#puts message
		Logger.write_log_file_with_timestamp( message )
	end

end

class Logger

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
		write_log_file_with_timestamp "-=< Temperature Logger Restart >=-"
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
					  write_log_file_with_timestamp "!!! Error communicating with #{t[:thermometer].name}"
					end
				end
				sleep 10
			end
		end
	end

	def stop
		write_log_file_with_timestamp "-=< Temperature Logger Shutdown >=-"
		@running.kill
	end

	def log_it(thermometer, temperature )
		message = "#{thermometer[:thermometer].name} | %07.3f" % [temperature]
		puts message
		write_log_file_with_timestamp( message )
	end

	def write_log_file_with_timestamp( message )
		Dir.mkdir("logs") unless Dir.exist?("logs")
		msg = "#{Time.now.strftime('%Y-%m-%d %H:%M:%S')} | #{message}\n"
		filename = "logs/#{Time.now.strftime('%Y-%m-%d')}-Temperatures.log"
		File.open( filename, 'a' ) {|f| f.write(msg)}
	end

end

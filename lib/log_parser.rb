class LogParser

	def get_logs( range = :today )
		logDir = "logs"
		@files = Dir.glob("#{logDir}/*.log")
	end

	def temperature_change_count( logs, device = :any )
		count = 0
		[*logs].each do |log|
			count += read_temps_for_device( log, device ).size
		end
		count
	end

	def min_max(fileList, device = :any)
		temps = []
		[*fileList].each do |file|
			list = read_temps_for_device( file, device )
			list.each do |line|
				temps.push line.split("|")[2].to_f
			end
		end
		minMax = {:min => temps.min, :max => temps.max}
	end

	def last_temperature( logs, device = :any )
		temp = ""
		[*logs].each do |log|
			temp = read_temps_for_device( log, device ).last
		end
		temp
	end

	def read_temps_for_device( log, device )
		if device == :any
		    File.open( log ) {|f| f.grep(/TEMPLOG/)}
		else
			File.open( log ) {|f| f.grep(/TEMPLOG.*#{device}/)}
		end
	end

end
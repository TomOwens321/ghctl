class LogParser

	def get_logs( range = :today )
		logDir = "logs"
		@files = Dir.glob("#{logDir}/*.log")
	end

	def temperature_change_count( log, device = :any )
		if device == :any
		    File.open( log ) {|f| f.grep(/TEMPLOG/)}.size
		else
			File.open( log ) {|f| f.grep(/TEMPLOG.*#{device}/)}.size
		end
	end

	def min_max(fileList, device = :any)
		temps = []
		list = read_temps_for_device( fileList, device )
		list.each do |line|
			temps.push line.split("|")[2].to_f
		end
		minMax = {:min => temps.min, :max => temps.max}
	end

	def read_temps_for_device( log, device = "" )
		File.open( log ) {|f| f.grep(/TEMPLOG.*/)}
	end

end
require 'date'

class LogParser

	def get_logs( range = :all )
		logDir = "logs"
		files = Dir.glob("#{logDir}/*.log")
		filter(files, range)
		files.sort!
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
				temps.push line.split("|")[2].to_f unless line.empty?
			end
		end
		minMax = {:min => temps.min, :max => temps.max}
	end

	def last_temperature( logs, device = :any )
		temp = ""
		[*logs].each do |log|
			temp = read_temps_for_device( log, device ).last
		end
		temp.chomp!
	end

	def read_temps_for_device( log, device )
		if device == :any
		    File.open( log ) {|f| f.grep(/TEMPLOG/)}
		else
			File.open( log ) {|f| f.grep(/TEMPLOG.*#{device}/)}
		end
	end

	def filter( list, range )
		today = Date.today
		case range
		
		when :all
			return list
		
		when :today
			list.delete_if {|file|  Date.parse(file) != today}
		
		when :yesterday
			list.delete_if {|file| Date.parse(file) != today - 1}
		
		when :this_week
			list.delete_if {|file| !(today - 7 .. today).cover? Date.parse(file) }

		when :this_month
			list.delete_if {|file| Date.parse(file).month != today.month}
		
		else
			raise "#{range} is an unknown filter."
		end
		list
	end

end
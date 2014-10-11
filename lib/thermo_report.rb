require './lib/log_parser'

puts "Starting thermo report"
parser = LogParser.new
logFiles = parser.get_logs( :all )

logFiles.each do |log|
	puts "Reading #{log}..."
	puts "#{File.basename(log)} recorded #{parser.temperature_change_count(log, "South Window")} temperature changes"
	mm = parser.min_max( log )
	puts "Max = %06.2f | Min = %06.2f" % [ mm[:max] * 9/5 + 32, mm[:min] * 9/5 + 32 ]
	puts "Current temperature : %06.2f" % [parser.last_temperature( log ).split("|")[2].to_f * 9/5 + 32]
end
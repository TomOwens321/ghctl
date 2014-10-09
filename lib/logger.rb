module Logger

	def Logger.write_log_file_with_timestamp( message )
		Dir.mkdir("logs") unless Dir.exist?("logs")
		msg = "#{Time.now.strftime('%Y-%m-%d %H:%M:%S')} | #{message}\n"
		filename = "logs/#{Time.now.strftime('%Y-%m-%d')}_ghctl.log"
		File.open( filename, 'a' ) {|f| f.write(msg)}
	end

end
require 'open-uri'

class Metar

	def initialize( station = "KGXY" )
		@station = station
	end

	def get_latest
		metar = ""
		url = "ftp://tgftp.nws.noaa.gov/data/observations/metar/stations/KGXY.TXT"
		open(url) do |f|
			metar = f.read
		end
		p metar
	end
end
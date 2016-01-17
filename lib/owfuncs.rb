require 'onewire'

module OwFuncs

	def OwFuncs.find_thermometers( host )
		therms = []
		client = Onewire.client host
		client.dir.each do |c|
			therms << c if client.dir(c).any? { |val| /\..*temperature/ =~ val }
		end
		therms
	end

end
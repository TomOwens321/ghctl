require 'onewire'

class Relay < Onewire::Scope

	attr_accessor :name, :location

	def initialize( client, path )
		@name = ""
		@location = ""
		super
	end

	def state
		state = self.read( @location )
		raise "Relay state cannot be determined" if state.nil?
		state == 0 ? :OFF : :ON
	end

	def state=( state )
		case state
		when :ON
			setState = 1
		when :OFF
			setState = 0
		else
			raise "#{state} is an unknown state for this Relay"
		end
		self.write( @location, setState )
		return state
	end

end
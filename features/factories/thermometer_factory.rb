FactoryGirl.define do

	factory :thermometer do
		#client 'test'
		#path 'path'
		name "Thermometer"
		location "Virtual"
		#temperature 25
	end

	initialize_with do
		new( 'client', 'path' )
	end

end
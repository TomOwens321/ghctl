FactoryGirl.define do

	factory :thermometer do
		client 'test'
		path 'path'
		name "Thermometer"
		location "Virtual"
		temperature 25
		#initialize_with( 'client', 'path' )
	end

end
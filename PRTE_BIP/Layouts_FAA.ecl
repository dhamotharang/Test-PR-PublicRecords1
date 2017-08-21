import FAA; 

export Layouts_FAA := module

	shared max_size := _Dataset().max_record_size;

	//This layout is the layout structure required by
	//faa.fFAA_aircraft_reg_as_business_linking
	export layout_faa_aircraft_reg_as_business_linking := record 
		faa.layout_aircraft_registration_out;
	end;	

end; //Layouts_FAA
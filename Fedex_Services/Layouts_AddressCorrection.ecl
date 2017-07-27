import doxie_cbrs;

export Layouts_AddressCorrection := 
MODULE;

	export formatted := Fedex_Services.Layouts.out;

	export out := record(formatted - [st_decode, st_result_count, exact_lname_match, leading_lname_match])
		unsigned2 internal_penalty_personName;
		unsigned2 internal_penalty_companyName;
		unsigned2 internal_penalty_address;
		unsigned2 internal_penalty_phone;
		unsigned2 internal_penalty_date;
		unsigned6 internal_seq := 0;
	end;	

END;
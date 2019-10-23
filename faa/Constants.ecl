export Constants := module

	export boolean Build_BID_Key_Flag := true;

	//DF-21779 Clear following fields in thor_data400::key::faa::fcra::aircraft_id_qa 
	export fields_to_clear_aircraft := 'ace_fips_st,certification,compname,country,fract_owner,last_action_date,' +
                         'orig_county,region,status_code,title,type_registrant';
	//DF-21779 Clear following fields in thor_data400::key::faa::fcra::aircraft_info_qa 
	export fields_to_clear_aircraft_details := 'aircraft_category_code,aircraft_cruising_speed,aircraft_weight,amateur_certification_code,lf,' +
															 'number_of_engines,number_of_seats';

	//DF-21779 Clear following fields in thor_data400::key::faa::fcra::engine_info_qa
	export fields_to_clear_aircraft_engine := 'fuel_consumed,lf';

	//DF-21779 Clear following fields in thor_data400::key::faa::fcra::airmen_certs_qa
	export fields_to_clear_pilot_certificate := 'ratings';

	//DF-21779 Clear following fields in thor_data400::key::faa::fcra::airmen_did_qa
	export fields_to_clear_pilot_registration := 'ace_fips_st,country,region,title';

	//DF-21779 Clear following fields in thor_data400::key::fcra::aircraft_reg_did_qa
	export fields_to_clear_aircraft_registration := 'ace_fips_st,certification,compname,country,fract_owner,last_action_date,' +
                         'lf,orig_county,region,status_code,title,type_registrant';

end;
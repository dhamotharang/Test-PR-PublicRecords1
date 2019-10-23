IMPORT strata, doxie_files;
EXPORT Verify_FCRA_Deprecated_Fields := FUNCTION

	// DF-21779 Show counts of blanked out fields in thor_data400::key::faa::fcra::aircraft_id
	cnt_faa_aircraft_id_fcra := OUTPUT(strata.macf_pops(faa.key_aircraft_id(true),,,,,,FALSE,['ace_fips_st','certification',
																											'compname','country','fract_owner','last_action_date','orig_county',
																											'region','status_code','title','type_registrant']));
	// Show counts of blanked out fields in thor_data400::key::faa::fcra::aircraft_info_qa
	cnt_faa_aircraft_info_fcra := OUTPUT(strata.macf_pops(faa.key_aircraft_info(true),,,,,,FALSE,['aircraft_category_code',
																											'aircraft_cruising_speed','aircraft_weight','amateur_certification_code',
																											'lf','number_of_engines','number_of_seats']));
	// Show counts of blanked out fields in thor_data400::key::faa::fcra::engine_info_qa
	cnt_faa_engine_info_fcra := OUTPUT(strata.macf_pops(faa.key_engine_info(true),,,,,,FALSE,['fuel_consumed','lf']));


	// Show counts of blanked out fields in thor_data400::key::faa::fcra::airmen_certs_qa
	cnt_faa_airmen_certs_fcra := OUTPUT(strata.macf_pops(faa.key_airmen_certs(true),,,,,,FALSE,['ratings']));

	// Show counts of blanked out fields in thor_data400::key::faa::fcra::airmen_did_qa
	cnt_faa_airmen_did_fcra := OUTPUT(strata.macf_pops(faa.key_airmen_did(true),,,,,,FALSE,['ace_fips_st','country',
																										'region','title']));

	// Show counts of blanked out fields in thor_data400::key::faa::fcra::airmen_rid_qa
	cnt_faa_airmen_rid_fcra := OUTPUT(strata.macf_pops(faa.key_airmen_rid(true),,,,,,FALSE,['ace_fips_st','country',
																										'region','title']));

	// Show counts of blanked out fields in thor_data400::key::fcra::aircraft_reg_did_qa
	cnt_faa_aircraftreg_did_fcra := OUTPUT(strata.macf_pops(doxie_files.key_aircraft_did_FCRA,,,,,,FALSE,['ace_fips_st','certification',
																											'compname','country','fract_owner','last_action_date','lf','orig_county',
																											'region','status_code','title','type_registrant']));

	RETURN PARALLEL(cnt_faa_aircraft_id_fcra,cnt_faa_aircraft_info_fcra,cnt_faa_engine_info_fcra,cnt_faa_airmen_certs_fcra,
	                cnt_faa_airmen_did_fcra,cnt_faa_airmen_rid_fcra,cnt_faa_aircraftreg_did_fcra);
	
END;

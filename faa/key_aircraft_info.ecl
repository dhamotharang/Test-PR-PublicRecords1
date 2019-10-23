Import Data_Services, doxie,ut;

export key_aircraft_info (boolean isFCRA = false) := function

	df := dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::base::faa_aircraft_info_building',layout_aircraft_info,flat);

	file_prefix := if (IsFCRA, 
											Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa::FCRA::aircraft_info_',
											Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa_aircraft_info_');

	//DF-21779 Clear specified fields in thor_data400::key::faa::fcra::aircraft_info_qa
	ut.MAC_CLEAR_FIELDS(df, df_cleared, faa.Constants.fields_to_clear_aircraft_details);

	df_new := if (IsFCRA, df_cleared, df);
								 
	return index (df_new, {code := df_new.aircraft_mfr_model_code},{df_new},
							file_prefix + doxie.Version_SuperKey);
end; 	

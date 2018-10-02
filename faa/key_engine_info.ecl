Import Data_Services, doxie,ut;
export key_engine_info (boolean isFCRA = false) := function

	df := dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::base::faa_engine_info_BUILDING',layout_engine_info,flat);

	file_prefix := if (IsFCRA, 
											Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa::FCRA::engine_info_',
											Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa_engine_info_');

	// DF21779 Blank out specified fields in thor_data400::key::faa::fcra::engine_info_qa
	ut.MAC_CLEAR_FIELDS(df, df_cleared, faa.Constants.fields_to_clear_aircraft_engine);

	df_new := if (IsFCRA, df_cleared, df);
										
	return index (df_new, {code := df_new.engine_mfr_model_code},{df_new},
							file_prefix + doxie.Version_SuperKey);
							
end; 	

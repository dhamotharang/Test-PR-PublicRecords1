Import Data_Services, doxie, ut,faa;
 export key_airmen_did (boolean isFCRA = false) := function

df := faa.searchFileAirmen;
 
  file_prefix := if (IsFCRA, 
										Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa::FCRA::airmen_did_',
                    Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::airmen_did_');

	//DF-21779 Clear specified fields in thor_data400::key::faa::fcra::airmen_did_qa
	ut.MAC_CLEAR_FIELDS(df, df_cleared, faa.Constants.fields_to_clear_pilot_registration);

	df_new := if (IsFCRA, df_cleared, df);										
										
 return index(df_new((integer)did_out != 0),
	               {UNSIGNED8 did := (UNSIGNED8) did_out, df_new.airmen_id}, {df_new},
	               file_prefix + doxie.Version_SuperKey);
	
	end; 
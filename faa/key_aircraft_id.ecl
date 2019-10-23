Import Data_Services, doxie,ut;
export key_aircraft_id(boolean isFCRA = false) := function

	df := faa.searchFile_Linkids;

  file_prefix := if (IsFCRA, 
										Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa::FCRA::aircraft_id_',
                    Data_Services.Data_location.Prefix('FAA')+'thor_Data400::key::aircraft_id_');

	//DF-21779 Clear speicifed fields in thor_data400::key::faa::fcra::aircraft_id_qa 
	ut.MAC_CLEAR_FIELDS(df, df_cleared, faa.Constants.fields_to_clear_aircraft);
	
	df_new := IF (IsFCRA,
								df_cleared,
								df);
										
  return index(df_new,{aircraft_id},{df_new},
                file_prefix + doxie.Version_SuperKey);
end; 	



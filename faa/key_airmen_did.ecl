Import Data_Services, doxie, ut,faa;
 export key_airmen_did (boolean isFCRA = false) := function

df := faa.searchFileAirmen;
 
  file_prefix := if (IsFCRA, 
										Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa::FCRA::airmen_did_',
                    Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::airmen_did_');
										
 return index(df((integer)did_out != 0),
	               {UNSIGNED8 did := (UNSIGNED8) did_out, df.airmen_id}, {df},
	               file_prefix + doxie.Version_SuperKey);
	
	end; 
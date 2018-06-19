Import Data_Services, doxie,ut;

export key_aircraft_info (boolean isFCRA = false) := function

df := dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::base::faa_aircraft_info_building',layout_aircraft_info,flat);

file_prefix := if (IsFCRA, 
										Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa::FCRA::aircraft_info_',
                    Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa_aircraft_info_');
										 
 		return index (df, {code := df.aircraft_mfr_model_code},{df},
                file_prefix + doxie.Version_SuperKey);
end; 	

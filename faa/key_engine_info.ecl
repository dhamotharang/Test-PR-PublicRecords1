Import Data_Services, doxie,ut;
export key_engine_info (boolean isFCRA = false) := function

df := dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::base::faa_engine_info_BUILDING',layout_engine_info,flat);

file_prefix := if (IsFCRA, 
										Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa::FCRA::engine_info_',
                    Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa_engine_info_');
										
		return index (df, {code := df.engine_mfr_model_code},{df},
                file_prefix + doxie.Version_SuperKey);
end; 	

Import Data_Services, gong_Neustar, doxie, ut;
export key_gong_batch_lczf := 	
	index(gong_Neustar.File_Gong_Full_Prepped_For_Keys_1(trim(name_last) <> ''),
				 {name_last,
					p_city_name,
				  z5,
					name_first},
				 {gong_Neustar.File_Gong_Full_Prepped_For_Keys_1},
			 '~thor_data400::key::gong_lczf_'+ doxie.Version_SuperKey
				 //Data_Services.Data_location.Prefix('Gong') + 'thor_data400::key::gong_lczf_'+ doxie.Version_SuperKey
	);
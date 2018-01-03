import gong, doxie, data_services;

export Key_npa_nxx_line :=  
       index(gong.File_Gong_Full(TRIM(phone10)<>''),
             {string3 npa := phone10[1..3],
						  string3 nxx := phone10[4..6],
							string4 line := phone10[7..10]},
             {gong.File_Gong_Full},
             data_services.data_location.prefix() + 'thor_data400::key::gong_eda_npa_nxx_line_' + doxie.Version_SuperKey);
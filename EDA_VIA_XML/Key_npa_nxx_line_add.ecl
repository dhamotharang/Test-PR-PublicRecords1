import gong, doxie;

export Key_npa_nxx_line_add :=  
       index(gong.file_daily_full(TRIM(phone10)<>''),
             {string3 npa := phone10[1..3],
						  string3 nxx := phone10[4..6],
							string4 line := phone10[7..10]},
             {gong.file_daily_full},
		   '~thor_data400::key::gong_eda_npa_nxx_line_add_' + doxie.Version_SuperKey, OPT);

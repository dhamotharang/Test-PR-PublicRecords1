import gong_Neustar, doxie, ut;
//DF-26180 Need to include did in this key
ds := PROJECT(gong_Neustar.File_Gong_Full_Prepped_For_Keys(TRIM(phone10)<>''), 
								recordof(gong_Neustar.File_Gong_Full_Prepped_For_Keys));

export Key_npa_nxx_line :=  
       index(ds,
             {string3 npa := phone10[1..3],
						  string3 nxx := phone10[4..6],
							string4 line := phone10[7..10]},
             {ds},
		   '~thor_data400::key::gong_eda_npa_nxx_line_' + doxie.Version_SuperKey);

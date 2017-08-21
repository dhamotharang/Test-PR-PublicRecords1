Import Data_Services, doxie_build,doxie_files,doxie,Life_EIR,ut, hygenics_search;
/*
df 					:= hygenics_crim.file_court_offenses;
output_file_name 	:= Data_Services.Data_location.Prefix('Provider')+'thor_data400::key::corrections_court_offenses_';
						 
export Key_Court_Offenses := index(df,{ofk := df.offender_key},{df},output_file_name + doxie_build.buildstate + '_' + doxie.Version_SuperKey);*/

export Key_Court_Offenses (boolean IsFCRA = false ) := function

df2 := doxie_files.file_court_offenses (Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
df 	:= doxie_files.file_court_offenses;

string file_name := if(IsFCRA, 
					 Data_Services.Data_location.Prefix('Criminal')+'thor_data400::key::corrections::fcra::court_offenses_'+doxie_build.buildstate+'_'+doxie.Version_SuperKey,
					 Data_Services.Data_location.Prefix('Criminal')+'thor_data400::key::corrections_court_offenses_'+doxie_build.buildstate+'_'+doxie.Version_SuperKey);

return if (IsFCRA,
           index(df2,{ofk := df.offender_key},{df2}, file_name, OPT),
           index(df,{ofk := df.offender_key},{df}, file_name, OPT));
					 
end;
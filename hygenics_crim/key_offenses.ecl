Import Data_Services, doxie_build,doxie,doxie_files,hygenics_search;
/*
df := file_offenses;

export Key_Offenses := index(df,{ok := df.offender_key},{df},Data_Services.Data_location.Prefix('Provider')+'thor_Data400::key::corrections_offenses_' + doxie_build.buildstate + '_' + doxie.Version_SuperKey);
*/

export key_offenses(boolean IsFCRA = false) := function

//offense category is in base not keys
df2 := doxie_files.file_offenses(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
df 	:= doxie_files.file_offenses;

string file_name := if(IsFCRA, 
					 Data_Services.Data_location.Prefix('Criminal')+'thor_200::key::criminal_offenses::fcra::'+doxie.Version_SuperKey+'::offender_key',
					 Data_Services.Data_location.Prefix('Criminal')+'thor_data400::key::corrections_offenses_'+doxie_build.buildstate + '_' + doxie.Version_SuperKey);

return if (IsFCRA,
           index(df2,{ok := df.offender_key},{df}, file_name, OPT),
           index(df,{ok := df.offender_key},{df}, file_name));

end;
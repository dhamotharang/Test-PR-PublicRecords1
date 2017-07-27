Import corrections, Data_Services, doxie_build,doxie, Data_Services, hygenics_search, hygenics_crim;

export Key_Punishment (boolean IsFCRA = false) := function

s_df_all := File_Punishment;

df2 	:= s_df_all(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
df 		:= s_df_all;

string file_name := if(IsFCRA, 
					 Data_Services.Data_location.Prefix('Criminal')+'thor_200::key::criminal_punishment::fcra::'+doxie.Version_SuperKey+'::offender_key.punishment_type',
					 Data_Services.Data_location.Prefix('Criminal')+'thor_data400::key::corrections_punishment_'+doxie_build.buildstate + '_' + doxie.Version_SuperKey);

return if (IsFCRA,
           index(df2,{ok := df2.offender_key, pt := df2.punishment_type},{df2}, file_name, OPT),
           index(df,{ok := df.offender_key, pt := df.punishment_type},{df}, file_name));

end;

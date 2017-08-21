Import Data_Services, doxie_build,doxie,doxie_files,Life_EIR,ut, hygenics_crim,hygenics_search;

/*df 					:= hygenics_crim.file_Activity;
output_file_name 	:= Data_Services.Data_location.Prefix('Provider')+'thor_data400::key::corrections_activity_';
						 
export Key_Activity :=   index(df,{ok := df.offender_key},{df},output_file_name + doxie_build.buildstate + '_' + doxie.Version_SuperKey);*/

export Key_Activity(boolean IsFCRA = false) := function

df2 := doxie_files.file_Activity(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
df 	:= doxie_files.file_Activity;

string file_name := if(IsFCRA, 
					 Data_Services.Data_location.Prefix('Criminal')+'thor_data400::key::corrections::fcra::activity_'+doxie_build.buildstate+'_'+doxie.Version_SuperKey,
					 Data_Services.Data_location.Prefix('Criminal')+'thor_Data400::key::corrections_activity_'+doxie_build.buildstate+'_'+doxie.Version_SuperKey);

return if (IsFCRA,
           index(df2,{ok := df.offender_key},{df}, file_name, OPT),
           index(df,{ok := df.offender_key},{df}, file_name));

end;

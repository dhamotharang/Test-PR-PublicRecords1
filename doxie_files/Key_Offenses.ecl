import doxie, doxie_build, ut, hygenics_search, data_services, vault, _control;

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export key_offenses(boolean IsFCRA = false) := vault.doxie_files.Key_Offenses(isFCRA);
#ELSE
export key_offenses(boolean IsFCRA = false) := function

df2 := file_offenses(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
df 	:= file_offenses;

string file_name := if(IsFCRA, 
					 Data_Services.Data_location.Prefix('Criminal')+'thor_200::key::criminal_offenses::fcra::'+doxie.Version_SuperKey+'::offender_key',
					 Data_Services.Data_location.Prefix('Criminal')+'thor_data400::key::corrections_offenses_'+doxie_build.buildstate + '_' + doxie.Version_SuperKey);

return if (IsFCRA,
           index(df2,{ok := df.offender_key},{df}, file_name, OPT),
           index(df,{ok := df.offender_key},{df}, file_name));

end;
#END;
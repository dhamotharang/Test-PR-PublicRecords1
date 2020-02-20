Import Data_Services,doxie_build,doxie,hygenics_search, vault, _control;

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_Court_Offenses (boolean IsFCRA = false) := vault.doxie_files.Key_Court_Offenses(isFCRA);
#ELSE
export Key_Court_Offenses (boolean IsFCRA = false /* deprecated - use Key_Court_Offenses_FCRA instead */) := function

df2 := doxie_files.file_court_offenses (Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
df 	:= doxie_files.file_court_offenses;

string file_name := if(IsFCRA, 
					 Data_Services.Data_location.Prefix('Criminal')+'thor_data400::key::corrections::fcra::court_offenses_'+doxie_build.buildstate+'_'+doxie.Version_SuperKey,
					 Data_Services.Data_location.Prefix('Criminal')+'thor_data400::key::corrections_court_offenses_'+doxie_build.buildstate+'_'+doxie.Version_SuperKey);

return if (IsFCRA,
           index(df2,{ofk := df.offender_key},{df2}, file_name, OPT),
           index(df,{ofk := df.offender_key},{df}, file_name, OPT));
					 
end;
#END;
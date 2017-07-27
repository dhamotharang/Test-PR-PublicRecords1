Import Data_Services, doxie_build, doxie, hygenics_search;

export key_offenders_offenderkey (boolean IsFCRA = false /* deprecated - use key_offenders_offenderkey_FCRA instead */) := function

df2 := doxie_files.File_FCRA_Offenders(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
df 	:= doxie_files.File_Offenders;

string file_name := if(IsFCRA, 
					 Data_Services.Data_location.Prefix('Criminal')+'thor_data400::key::corrections::fcra::offenders_offenderkey_'+doxie_build.buildstate+'_'+doxie.Version_SuperKey,
					 Data_Services.Data_location.Prefix('Criminal')+'thor_data400::key::corrections_offenders_offenderkey_'+doxie_build.buildstate+'_'+doxie.Version_SuperKey);

return if (IsFCRA,
           index(df2,{string60 ofk := df2.offender_key},{df2}, file_name, OPT),
           index(df,{string60 ofk := df.offender_key},{df}, file_name));

end;

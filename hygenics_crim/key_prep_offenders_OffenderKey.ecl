import doxie, doxie_build, hygenics_search;

export key_prep_offenders_OffenderKey(boolean IsFCRA = false) := function

//df2 := hygenics_search.file_fcra_offenders_keybuilding(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
df2 := file_offenders_keybuilding(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
df 	:= file_offenders_keybuilding;

string file_name := if(IsFCRA, 
					 '~thor_data400::key::corrections::fcra::offenders_offenderkey_'+doxie_build.buildstate+'_'+doxie.Version_SuperKey,
					 '~thor_data400::key::corrections_offenders_offenderkey_'+doxie_build.buildstate + thorlib.wuid());

return if (IsFCRA,
           index(df2,{string60 ofk := df2.offender_key},{df2}, file_name, OPT),
           index(df,{string60 ofk := df.offender_key},{df}, file_name));

end;
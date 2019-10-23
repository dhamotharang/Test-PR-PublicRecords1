import doxie, doxie_build, hygenics_search, ut;

export key_prep_offenders_OffenderKey(boolean IsFCRA = false) := function

//df2 := hygenics_search.file_fcra_offenders_keybuilding(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
df2 := file_offenders_keybuilding(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
//DF-21868 Deprecate specified fields in thor_data400::key::corrections::fcra::offenders_offenderkey_public_qa
ut.MAC_CLEAR_FIELDS(df2, df2_cleared, hygenics_crim.constants('').fields_to_clear_offenders_offenderkey);

df 	:= file_offenders_keybuilding;

string file_name := if(IsFCRA, 
					 '~thor_data400::key::corrections::fcra::offenders_offenderkey_'+doxie_build.buildstate+'_'+doxie.Version_SuperKey,
					 '~thor_data400::key::corrections_offenders_offenderkey_'+doxie_build.buildstate + thorlib.wuid());

return if (IsFCRA,
           index(df2_cleared,{string60 ofk := df2_cleared.offender_key},{df2_cleared}, file_name, OPT),
           index(df,{string60 ofk := df.offender_key},{df}, file_name));

end;
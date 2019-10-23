import doxie, doxie_build, ut, hygenics_search,corrections;

export key_prep_courtoffenses(boolean IsFCRA = false) := function

corrections.Layout_CourtOffenses oldFile_FCRA(file_courtoffenses_keybuilding l) := transform
    self.offense_category := 0; //Offense category is blank for FCRA.
		self := l;
end;

//Including Court & DOC Offenses in the FCRA Offense Key (for now)
df2 := project(file_courtoffenses_keybuilding(Vendor not in hygenics_search.sCourt_Vendors_To_Omit), oldFile_FCRA(left));
//DF-21868 Deprecate specified fields in thor_data400::key::corrections::fcra::court_offenses_public_qa(
//thor_data400::key::life_eir::fcra::filedate::court_offenses)
ut.MAC_CLEAR_FIELDS(df2, df2_cleared, hygenics_crim.constants('').fields_to_clear_court_offenses);

df 	:= file_courtoffenses_keybuilding(data_type<>'1');

string file_name := if(IsFCRA, 
					 '~thor_data400::key::corrections::fcra::court_offenses_'+doxie_build.buildstate+'_'+doxie.Version_SuperKey,
					 '~thor_data400::key::corrections_court_offenses_'+doxie_build.buildstate + thorlib.wuid());

return if (IsFCRA,
           index(df2_cleared,{ofk := df2_cleared.offender_key},{df2_cleared}, file_name, OPT),
           index(df,{ofk := df.offender_key},{df}, file_name));

end;
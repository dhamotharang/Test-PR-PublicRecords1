import doxie, doxie_build, ut, hygenics_search,corrections;

export key_prep_offenses(boolean IsFCRA = false) := function
 corrections.layout_offense_common oldFile_fcra(corrections.layout_offense_common l) := transform
    self.offense_category := 0;
		self := l;
 end;
 
df2 := project(file_offenses_keybuilding(Vendor not in hygenics_search.sCourt_Vendors_To_Omit), oldFile_fcra(left));	
//DF-21868 deprecate specified fields in thor_200::key::criminal_offenses::fcra::qa::offender_key
ut.MAC_CLEAR_FIELDS(df2, df2_cleared, hygenics_crim.constants('').fields_to_clear_offender_key); 

df 	:= file_offenses_keybuilding;

string file_name := if(IsFCRA, 
					 '~thor_200::key::criminal_offenses::fcra::'+doxie.Version_SuperKey+'::offender_key',
					 '~thor_data400::key::corrections_offenses_'+doxie_build.buildstate + thorlib.wuid());

return if (IsFCRA,
           index(df2_cleared,{ok := df2_cleared.offender_key},{df2_cleared}, file_name, OPT),
           index(df,{ok := df.offender_key},{df}, file_name));

end;
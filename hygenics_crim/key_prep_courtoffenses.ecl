import doxie, doxie_build, ut, hygenics_search,corrections;

export key_prep_courtoffenses(boolean IsFCRA = false) := function

corrections.Layout_CourtOffenses oldFile_FCRA(file_courtoffenses_keybuilding l) := transform
    self.offense_category := 0; //Offense category is blank for FCRA.
		self := l;
end;

//Including Court & DOC Offenses in the FCRA Offense Key (for now)
df2 := project(file_courtoffenses_keybuilding(Vendor not in hygenics_search.sCourt_Vendors_To_Omit), oldFile_FCRA(left));
df 	:= file_courtoffenses_keybuilding(data_type<>'1');

string file_name := if(IsFCRA, 
					 '~thor_data400::key::corrections::fcra::court_offenses_'+doxie_build.buildstate+'_'+doxie.Version_SuperKey,
					 '~thor_data400::key::corrections_court_offenses_'+doxie_build.buildstate + thorlib.wuid());

return if (IsFCRA,
           index(df2,{ofk := df2.offender_key},{df2}, file_name, OPT),
           index(df,{ofk := df.offender_key},{df}, file_name));

end;
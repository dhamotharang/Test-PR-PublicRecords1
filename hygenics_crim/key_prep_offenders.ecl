import doxie, doxie_build, ut, hygenics_search;

export key_prep_offenders(boolean IsFCRA = false) := function

//df2 := hygenics_search.file_fcra_offenders_keybuilding(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
df2 := file_offenders_keybuilding(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
df 	:= file_offenders_keybuilding;

string file_name := if(IsFCRA, 
					 '~thor_data400::key::criminal_offenders::fcra::'+doxie.Version_SuperKey+'::did',
					 '~thor_data400::key::corrections_offenders_'+doxie_build.buildstate + thorlib.wuid());

return if (IsFCRA,
           index(df2((integer)did != 0),{unsigned6 sdid := (integer)df2.did},{df2}, file_name, OPT),
           index(df((integer)did != 0),{unsigned6 sdid := (integer)df.did},{df}, file_name));

end;
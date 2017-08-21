import doxie, doxie_build, ut, hygenics_search;

export key_prep_offenders_docnum(boolean IsFCRA = false) := function

//df2 := hygenics_search.file_fcra_offenders_keybuilding(doc_num not in ['0',''] and Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
df2 := file_offenders_keybuilding(doc_num not in ['0',''] and Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
df 	:= file_offenders_keybuilding(doc_num not in ['0','']);

string file_name := if(IsFCRA, 
					 '~thor_200::criminal_offenders::fcra::'+doxie.Version_SuperKey+'::docnum',
					 '~thor_data400::key::corrections_offenders_docnum_'+doxie_build.buildstate + thorlib.wuid());

return if (IsFCRA,
           index(df2,{string10 docnum := df2.doc_num, string2 state := df2.st},{df2}, file_name, OPT),
           index(df,{string10 docnum := df.doc_num, string2 state := df.st},{df}, file_name));

end;
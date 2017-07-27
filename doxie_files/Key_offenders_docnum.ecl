Import Data_Services, doxie_build,doxie,Data_Services, hygenics_search;

export Key_offenders_docnum (boolean IsFCRA = false) := function

df2 := File_FCRA_Offenders(doc_num <> '' and Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
df 	:= File_Offenders(doc_num <> '');

string file_name := if(IsFCRA, 
					 Data_Services.Data_location.Prefix('Criminal')+'thor_200::key::criminal_offenders::fcra::'+doxie.Version_SuperKey+'::docnum',
					 Data_Services.Data_location.Prefix('Criminal')+'thor_data400::key::corrections_offenders_docnum_'+doxie_build.buildstate + '_' + doxie.Version_SuperKey);

return if (IsFCRA,
           index(df2,{string10 docnum := df2.doc_num, string2 state := df2.st},{df2}, file_name, OPT),
           index(df,{string10 docnum := df.doc_num, string2 state := df.st},{df}, file_name));
					 
end;
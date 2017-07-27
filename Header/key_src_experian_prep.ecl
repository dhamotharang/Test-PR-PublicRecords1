import ut,ExperianCred,ut;

export key_src_experian_prep(boolean pFastHeader = false) := function

Experian_in := ExperianCred.Experian_as_source(if(pFastHeader,ExperianCred.Files.Base_File_Out),~pFastHeader,pFastHeader);

mac_key_src(Experian_in, ExperianCred.Layouts.Layout_Out_old, 
						Experian_child, 
						ut.Data_Location.Person_header+'thor_data400::key::Experian_src_index'+SF_suffix(pFastHeader)+'_',id)

return id;
end;
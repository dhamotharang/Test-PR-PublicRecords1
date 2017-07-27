import ut,DriversV2;

export Key_Src_DLv2_prep(boolean pFastHeader = false) := function

dDLs_as_Source := DriversV2.DLs_as_Source(if(pFastHeader,DriversV2.File_DL),~pFastHeader,pFastHeader);

mac_key_src(dDLs_as_Source, DriversV2.Layout_DL, 
						dl_child, 
						ut.Data_Location.Person_header+'thor_data400::key::dlv2_src_index'+SF_suffix(pFastHeader)+'_',id);
						
return id;
end;
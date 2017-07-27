import ut,liensv2;
export Key_Src_LienV2_prep(boolean pFastHeader = false) := function

liens_as_source := liensv2.LiensV2_as_Source(pFastHeader);

mac_key_src(liens_as_source, liensv2.Layout_as_source, 
						lienv2_child, 
						ut.Data_Location.Person_header+'thor_data400::key::LienV2_src_index'+SF_suffix(pFastHeader)+'_',id);

return id;
end;
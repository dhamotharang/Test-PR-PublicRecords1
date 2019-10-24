import gong, doxie; 

//CCPA-22 - exclude DID
layout_no_did := RECORD
	RECORDOF(gong.file_gong_hhid) - did;
end;	
export key_hhid := index(gong.file_gong_hhid(hhid<>0),
                             {unsigned6 s_hhid := hhid},{layout_no_did},
                             '~thor_data400::key::gong_hhid_'+doxie.Version_SuperKey);
	
	
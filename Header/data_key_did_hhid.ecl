import header, dx_Header;  
f := header.File_HHID_Current;

export data_key_did_hhid := PROJECT (f, dx_Header.layouts.i_hhid);
//Key_Prep_Did_HDid := index(f,{did, ver},{hhid,hhid_indiv,hhid_relat},'~thor_data400::key::did_hhid_' + thorlib.WUID(), OPT);
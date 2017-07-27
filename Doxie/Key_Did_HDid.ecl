import header;  
f := header.File_HHID_Current;
export Key_Did_HDid := index(f,{did, ver},{hhid,hhid_indiv,hhid_relat},'~thor_data400::key::did_hhid_' + version_superkey, OPT);
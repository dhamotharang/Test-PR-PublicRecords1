import header,ut;  
f := header.File_HHID_Current;
export Key_Did_HDid := index(f,{did, ver},{hhid,hhid_indiv,hhid_relat},
ut.Data_Location.Person_header+'thor_data400::key::did_hhid_' + version_superkey, OPT);
import header,ut;  
f := header.File_FCRA_HHID_Current;
export Key_FCRA_did_hhid := index(f,{did, ver},{hhid,hhid_indiv,hhid_relat},
ut.Data_Location.Person_header+'thor_data400::key::fcra::did_hhid_' + version_superkey, OPT);
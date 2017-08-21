import header,Data_Services;  
f := header.File_HHID_Current;
export Key_Did_HDid := index(f,{did, ver},{hhid,hhid_indiv,hhid_relat},
Data_Services.Data_location.prefix('PRTE')+'prte::key::header::qa::did_hhid', OPT);
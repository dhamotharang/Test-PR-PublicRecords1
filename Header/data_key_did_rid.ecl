IMPORT dx_Header, doxie;

EXPORT data_key_did_rid := PROJECT (doxie.build_file_base_did_rid, dx_Header.layouts.i_did_rid);

//index(doxie.build_file_base_did_rid,{rid},{did,stable},ut.Data_Location.Person_header+'thor_data400::key::rid_did_'+ version_superkey);
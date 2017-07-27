import header;

df := dataset('~thor_data400::base::file_did_rid',{doxie.KeyType_Rid_Did,unsigned8 __filepos {virtual(fileposition)}},THOR,UNSORTED);

export file_base_did_rid := df;
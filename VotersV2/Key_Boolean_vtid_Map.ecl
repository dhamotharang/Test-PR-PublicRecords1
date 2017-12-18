import votersv2,data_services;


tmsid_rec := RECORD
  unsigned integer2 src;
  unsigned integer6 doc;
  unsigned integer8 __filepos;
 END;


tmsid_table := dataset([],tmsid_rec);

export key_boolean_vtid_map := index(tmsid_table,{src,doc,__filepos},data_services.data_location.prefix('Voter') + 'thor_data400::key::votersv2::qa::doc.vtid');




import liensv2, data_services;


tmsid_rec := RECORD
  unsigned integer2 src;
  unsigned integer6 doc;
  string50 tmsid;
  unsigned integer8 __filepos;

 END;


tmsid_table := dataset([],tmsid_rec);

export key_boolean_tmsid := index(tmsid_table,{src,doc,tmsid,__filepos},data_services.data_location.prefix('bankruptcyv2') + 'thor_data400::key::bankruptcyv2::qa::docref.tmsid');


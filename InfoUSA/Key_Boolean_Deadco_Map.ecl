import infousa, data_services;


tmsid_rec := RECORD
  unsigned integer2 src;
  unsigned integer6 doc;
  string9 abi_number;
  unsigned integer8 __filepos;
 END;


tmsid_table := dataset([],tmsid_rec);

export key_boolean_deadco_map := index(tmsid_table,{src,doc,abi_number,__filepos},data_services.data_location.prefix() + 'thor_data400::key::deadco::qa::doc.abinumber');




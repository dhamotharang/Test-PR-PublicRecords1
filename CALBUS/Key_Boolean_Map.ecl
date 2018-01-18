import data_services;


tmsid_rec := RECORD
  unsigned integer2 src;
  unsigned integer6 doc;
  string13 account_number;
  unsigned integer8 __filepos;

 END;


tmsid_table := dataset([],tmsid_rec);

export key_boolean_map := index(tmsid_table,
                                {src,doc,account_number,__filepos}, 
                                data_services.data_location.prefix() + 'thor_data400::key::calbus::qa::doc.accnumber');
import calbus;


tmsid_rec := RECORD
  unsigned integer6 doc;
  string30 corp_key;
  unsigned integer8 __filepos;

 END;


tmsid_table := dataset([],tmsid_rec);

export key_boolean_map := index(tmsid_table,{doc,corp_key,__filepos},'~thor_data400::key::corp2::qa::docref.docref');




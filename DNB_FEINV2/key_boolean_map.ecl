import dnb_feinv2;


tmsid_rec := RECORD
  unsigned integer2 src;
  unsigned integer6 doc;
  unsigned integer2 src2;
  string50 doc2;
  unsigned integer8 __filepos;
 END;


tmsid_table := dataset([],tmsid_rec);

export key_boolean_map := index(tmsid_table,{src,doc,src2,doc2,__filepos},'~thor_data400::key::feinv2::qa::map.key');




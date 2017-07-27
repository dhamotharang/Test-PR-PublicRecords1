import infousa;


tmsid_rec := RECORD
  unsigned integer2 src;
  unsigned integer6 doc;
  string9 abi_number;
  unsigned integer8 __filepos;
 END;


tmsid_table := dataset([],tmsid_rec);

export key_boolean_abius_map := index(tmsid_table,{src,doc,abi_number,__filepos},'~thor_data400::key::abius::qa::doc.abinumber');




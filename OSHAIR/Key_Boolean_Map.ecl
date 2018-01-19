import Data_Services;


tmsid_rec := RECORD
  unsigned integer2 src;
  unsigned integer6 doc;
  unsigned integer8 __filepos;

 END;


tmsid_table := dataset([],tmsid_rec);

export key_boolean_map := index(tmsid_table,{src,doc,__filepos},Data_Services.Data_location.Prefix()+'thor_data400::key::oshair::qa::doc.anumber');


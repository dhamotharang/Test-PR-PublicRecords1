import Data_Services;


tmsid_rec := RECORD
  unsigned integer2 src;
  unsigned integer6 doc;
  string50 tmsid;
  unsigned integer8 __filepos;

 END;


tmsid_table := dataset([],tmsid_rec);

export key_boolean_tmsid := index(tmsid_table,{src,doc,tmsid,__filepos},Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::qa::docref.tmsid');


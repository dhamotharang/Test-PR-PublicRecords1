import Data_Services;


tmsid_rec 
:= RECORD
  unsigned integer2 src;
  unsigned integer6 doc;
  unsigned integer2 src2;
  string84 doc2;
  unsigned integer8 __filepos;
 END;



tmsid_table := dataset([],tmsid_rec);

export key_boolean_tmsid := index(tmsid_table,{src,doc,src2,doc2,__filepos},Data_Services.Data_location.Prefix()+'thor_data400::key::mfind::qa::docref.tmsid');


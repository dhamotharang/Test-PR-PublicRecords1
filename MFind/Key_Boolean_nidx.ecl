import Data_Services;


tmsid_rec 
:= RECORD
  unsigned integer2 part;
  unsigned integer1 typ;
  unsigned integer4 nominal;
  unsigned integer2 src;
  unsigned integer6 doc;
  unsigned integer2 seg;
  unsigned integer4 kwp;
  unsigned integer1 wip;
  unsigned integer3 suffix;
  unsigned integer8 fpos;
 END;



tmsid_table := dataset([],tmsid_rec);

export key_boolean_nidx := index(tmsid_table,{part,typ,nominal,src,doc,seg,kwp,wip},{suffix,fpos},Data_Services.Data_location.Prefix()+'thor_data400::key::mfind::qa::nidx');






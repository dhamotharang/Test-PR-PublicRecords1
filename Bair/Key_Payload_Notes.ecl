import Data_Services;

r := RECORD
  string100 eid;
  unsigned1 note_type;
  string510 notes;
  unsigned8 __internal_fpos__;
 END;
d:=dataset([],r);

EXPORT Key_Payload_Notes(string v='qa') := 
	index(d,{eid},{d},data_services.Data_location.Prefix('BAIR')+'thor_data400::key::bair::notes::'+v+'::eid'); 
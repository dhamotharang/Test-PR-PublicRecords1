Import data_services;
r:=RECORD
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

d	:=dataset([],r);

EXPORT Key_Auto_Namewords2(string Platform) :=	Index(d,{d},
																											data_services.Data_location.Prefix(Platform) +'thor_data400::key::' 
																											+Platform +'::qa::autokey::namewords2');

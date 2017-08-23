Import data_services;
r:=RECORD
  string7 p7;
  string3 p3;
  string40 cname_indic;
  string40 cname_sec;
  string2 st;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

d	:=dataset([],r);

EXPORT Key_Auto_Phoneb2(string Platform) :=	Index(d,{d},
																									data_services.Data_location.Prefix(Platform) +'thor_data400::key::' 
																									+Platform	+'::qa::autokey::phoneb2');



Import data_services;
r:=RECORD
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

d	:=dataset([],r);

EXPORT Key_Auto_Zipb2(string Platform)  :=	Index(d,{d},
																									data_services.Data_location.Prefix(Platform) +'thor_data400::key::' 
																									+Platform +'::qa::autokey::zipb2');


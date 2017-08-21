Import data_services;
r:=RECORD
  string7 p7;
  string3 p3;
  string6 dph_lname;
  string20 pfname;
  string2 st;
  unsigned6 did;
  unsigned4 lookups;
 END;

d	:=dataset([],r);

EXPORT Key_Auto_Phone2(string Platform) :=	Index(d,{d},
																									data_services.Data_location.Prefix(Platform) +'thor_data400::key::' 
																									+Platform	+'::qa::autokey::phone2');


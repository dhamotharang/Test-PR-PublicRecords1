Import data_services;
r:=RECORD
  string1 f1;
  string1 f2;
  string1 f3;
  string1 f4;
  string1 f5;
  string1 f6;
  string1 f7;
  string1 f8;
  string1 f9;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

d	:=dataset([],r);

EXPORT Key_Auto_Fein2(string Platform) :=	Index(d,{d},
																								data_services.Data_location.Prefix(Platform) +'thor_data400::key::' 
																								+Platform +'::qa::autokey::Fein2');

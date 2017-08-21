Import data_services;
r:=RECORD
  string1 s1;
  string1 s2;
  string1 s3;
  string1 s4;
  string1 s5;
  string1 s6;
  string1 s7;
  string1 s8;
  string1 s9;
  string6 dph_lname;
  string20 pfname;
  unsigned6 did;
  unsigned4 lookups;
 END;

d	:=dataset([],r);

EXPORT Key_Auto_Ssn2(string Platform) :=	Index(d,{d},
																								data_services.Data_location.Prefix(Platform) +'thor_data400::key::' 
																								+Platform +'::qa::autokey::ssn2');



Import data_services;
r:=RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string5 zip;
  string8 sec_range;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

d	:=dataset([],r);

EXPORT Key_Auto_Addressb2(string Platform) :=	Index(d,{d},
																										data_services.Data_location.Prefix(Platform) + 'thor_data400::key::' 
																										+Platform	+'::qa::autokey::addressb2');



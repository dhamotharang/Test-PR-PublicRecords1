Import data_services,doxie;
r:=RECORD
  string255 description;
  unsigned6 ind_type;
  unsigned3 status;
  string20 date_added;
  string30 user_added;
  string20 date_changed;
  string30 user_changed;
  unsigned8 __internal_fpos__;
 END;

d	:=dataset([],r);

EXPORT Key_MbsFdnIndType(string Platform) := Index(d,{description},{d},
																									 data_services.Data_location.Prefix(Platform) + 'thor_data400::key::' 
																									 +Platform	+ '::'+ doxie.Version_SuperKey +'::mbsfdnindtype');
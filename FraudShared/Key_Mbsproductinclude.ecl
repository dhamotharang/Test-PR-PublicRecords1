Import data_services;
r:=RECORD
  unsigned6 fdn_file_info_id;
  unsigned6 fdn_file_product_include_id;
  unsigned6 product_id;
  unsigned3 status;
  string20 date_added;
  string30 user_added;
  string20 date_changed;
  string30 user_changed;
  unsigned8 __internal_fpos__;
 END;

d	:=dataset([],r);

EXPORT Key_Mbsproductinclude(string Platform) :=	Index(d,{fdn_file_info_id},{d},
																												data_services.Data_location.Prefix(Platform) +'thor_data400::key::' 
																												+Platform +'::qa::mbsproductinclude');

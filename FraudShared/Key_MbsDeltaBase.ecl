Import data_services,doxie;
r:=RECORD
  unsigned6 gc_id;
  unsigned6 ind_type;
  unsigned6 fdn_file_info_id;
  string100 fdn_file_code;
  unsigned3 file_type;
  string256 description;
  unsigned3 primary_source_entity;
  string256 ind_type_description;
  unsigned3 update_freq;
  unsigned6 expiration_days;
  unsigned6 post_contract_expiration_days;
  unsigned3 status;
  unsigned3 product_include;
  string20 date_added;
  string30 user_added;
  string20 date_changed;
  string30 user_changed;
  string100 p_industry_segment;
  string20 usage_term;
  unsigned8 __internal_fpos__;
 END;

d	:=dataset([],r);

EXPORT Key_MbsDeltaBase(string Platform) := Index(d,{gc_id,ind_type},{d},
																									 data_services.Data_location.Prefix(Platform) + 'thor_data400::key::' 
																									 +Platform	+ '::'+ doxie.Version_SuperKey +'::mbsdeltabase');
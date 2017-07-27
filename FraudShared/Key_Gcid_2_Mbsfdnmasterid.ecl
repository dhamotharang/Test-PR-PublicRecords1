Import data_services;
r:=RECORD
  unsigned6 gc_id;
  unsigned6 hh_id;
  unsigned6 cc_id;
  unsigned6 gc_cc_hh_id;
  string10 id_type;
  string10 fdnmasterid_type;
  data16 fdnmasterid;
  unsigned8 __internal_fpos__;
 END;
d	:=dataset([],r);

EXPORT Key_Gcid_2_Mbsfdnmasterid(string Platform) :=	Index(d,{gc_id},{d},
																														data_services.Data_location.Prefix(Platform) +'thor_data400::key::' 
																														+Platform	+'::qa::gcid_2_mbsfdnmasterid');

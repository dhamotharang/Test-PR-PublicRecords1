import Data_Services;

r := RECORD
   string50 ori;
  unsigned2 group_id;
  unsigned1 owner;
  string64 msrepl_tran_version;
  unsigned2 mode_id;
  unsigned4 data_provider_id;
  string50 data_provider_ori;
  string200 data_provider_name;
 END;

d:=dataset([],r);

EXPORT Key_Group_Access(string v = 'qa', boolean isDelta = false) := 
													index(d,{ori},{d},data_services.Data_location.Prefix('BAIR')+
																						'thor_data400::key::bair::group_access::' + if(isDelta, 'delta::', '') + v + '::ori', OPT);
IMPORT Data_Services,bank_routing,file_compare,std;

EXPORT fn_Key_Compare(STRING Version) := FUNCTION 

 OldKey := INDEX(bank_routing.key_rtn,bank_routing.thor_cluster + 'key::bank_routing::father::rtn');
										
 NewKey := INDEX(bank_routing.key_rtn,bank_routing.thor_cluster + 'key::bank_routing::qa::rtn');

 PulledOldKey:=Pull(OldKey);
 PulledNewKey:=Pull(NewKey);
 ImportantRecord:=RECORD
  STRING routing_number_MICR;
  STRING state;
  STRING city_town;
  STRING zip_code;
  STRING street_address;
  STRING zip_4;
  STRING routing_number_fractional;
  STRING head_office_branch_codes;
  STRING institution_name_full;
  STRING mail_address;
  STRING mail_city_town;
  STRING mail_state;
  STRING mail_zip_code;
  STRING mail_zip_4;
  STRING branch_office_name;
  STRING head_office_routing_number;
  STRING phone_number_area_code;
  STRING phone_number;
 END;

 IgnoreRecord:=RECORD
  STRING institution_name_abbreviated;
  STRING phone_number_extension;
 END;

 return file_compare.Fn_File_Compare(PulledOldKey,PulledNewKey,ImportantRecord,IgnoreRecord,ImportantRecord,true,true,true,true,'bank_routing','Non_FCRA_Key', Version);

END;
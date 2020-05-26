IMPORT SALT311;
IMPORT Scrubs,Scrubs_FCC; // Import modules for FieldTypes attribute definitions
EXPORT Input_Fields := MODULE
 
EXPORT NumFields := 45;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_No','Invalid_Float','Invalid_Alpha','Invalid_AlphaChar','Invalid_AlphaNum','Invalid_AlphaNumChar','Invalid_State','Invalid_Zip','Invalid_Phone','Invalid_Date','Invalid_Future');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_No' => 1,'Invalid_Float' => 2,'Invalid_Alpha' => 3,'Invalid_AlphaChar' => 4,'Invalid_AlphaNum' => 5,'Invalid_AlphaNumChar' => 6,'Invalid_State' => 7,'Invalid_Zip' => 8,'Invalid_Phone' => 9,'Invalid_Date' => 10,'Invalid_Future' => 11,0);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Float(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 .-/'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Float(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 .-/'))));
EXPORT InValidMessageFT_Invalid_Float(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 .-/'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'Alpha')>0);
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaChar(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_AlphaChar(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'AlphaChar')>0);
EXPORT InValidMessageFT_Invalid_AlphaChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'AlphaNum')>0);
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNumChar(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_AlphaNumChar(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'AlphaNumChar')>0);
EXPORT InValidMessageFT_Invalid_AlphaNumChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  RETURN  MakeFT_Invalid_Alpha(s0);
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 .-/'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Float(s1);
END;
EXPORT InValidFT_Invalid_Zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 .-/'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 .-/'),SALT311.HygieneErrors.NotLength('0,5,9,10'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 .-/'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Float(s1);
END;
EXPORT InValidFT_Invalid_Phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 .-/'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 .-/'),SALT311.HygieneErrors.NotLength('0,9,10'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs_FCC.Functions.fn_valid_Date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_FCC.Functions.fn_valid_Date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Future(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Future(SALT311.StrType s) := WHICH(~Scrubs_FCC.Functions.fn_valid_Date(s,'Future')>0);
EXPORT InValidMessageFT_Invalid_Future(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_FCC.Functions.fn_valid_Date'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'license_type','file_number','callsign_of_license','radio_service_code','licensees_name','licensees_attention_line','dba_name','licensees_street','licensees_city','licensees_state','licensees_zip','licensees_phone','date_application_received_at_fcc','date_license_issued','date_license_expires','date_of_last_change','type_of_last_change','latitude','longitude','transmitters_street','transmitters_city','transmitters_county','transmitters_state','transmitters_antenna_height','transmitters_height_above_avg_terra','transmitters_height_above_ground_le','power_of_this_frequency','frequency_mhz','class_of_station','number_of_units_authorized_on_freq','effective_radiated_power','emissions_codes','frequency_coordination_number','paging_license_status','control_point_for_the_system','pending_or_granted','firm_preparing_application','contact_firms_street_address','contact_firms_city','contact_firms_state','contact_firms_zipcode','contact_firms_phone_number','contact_firms_fax_number','unique_key','crlf');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'license_type','file_number','callsign_of_license','radio_service_code','licensees_name','licensees_attention_line','dba_name','licensees_street','licensees_city','licensees_state','licensees_zip','licensees_phone','date_application_received_at_fcc','date_license_issued','date_license_expires','date_of_last_change','type_of_last_change','latitude','longitude','transmitters_street','transmitters_city','transmitters_county','transmitters_state','transmitters_antenna_height','transmitters_height_above_avg_terra','transmitters_height_above_ground_le','power_of_this_frequency','frequency_mhz','class_of_station','number_of_units_authorized_on_freq','effective_radiated_power','emissions_codes','frequency_coordination_number','paging_license_status','control_point_for_the_system','pending_or_granted','firm_preparing_application','contact_firms_street_address','contact_firms_city','contact_firms_state','contact_firms_zipcode','contact_firms_phone_number','contact_firms_fax_number','unique_key','crlf');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'license_type' => 0,'file_number' => 1,'callsign_of_license' => 2,'radio_service_code' => 3,'licensees_name' => 4,'licensees_attention_line' => 5,'dba_name' => 6,'licensees_street' => 7,'licensees_city' => 8,'licensees_state' => 9,'licensees_zip' => 10,'licensees_phone' => 11,'date_application_received_at_fcc' => 12,'date_license_issued' => 13,'date_license_expires' => 14,'date_of_last_change' => 15,'type_of_last_change' => 16,'latitude' => 17,'longitude' => 18,'transmitters_street' => 19,'transmitters_city' => 20,'transmitters_county' => 21,'transmitters_state' => 22,'transmitters_antenna_height' => 23,'transmitters_height_above_avg_terra' => 24,'transmitters_height_above_ground_le' => 25,'power_of_this_frequency' => 26,'frequency_mhz' => 27,'class_of_station' => 28,'number_of_units_authorized_on_freq' => 29,'effective_radiated_power' => 30,'emissions_codes' => 31,'frequency_coordination_number' => 32,'paging_license_status' => 33,'control_point_for_the_system' => 34,'pending_or_granted' => 35,'firm_preparing_application' => 36,'contact_firms_street_address' => 37,'contact_firms_city' => 38,'contact_firms_state' => 39,'contact_firms_zipcode' => 40,'contact_firms_phone_number' => 41,'contact_firms_fax_number' => 42,'unique_key' => 43,'crlf' => 44,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['CUSTOM'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_license_type(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_license_type(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_license_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_file_number(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_file_number(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_file_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_callsign_of_license(SALT311.StrType s0) := s0;
EXPORT InValid_callsign_of_license(SALT311.StrType s) := 0;
EXPORT InValidMessage_callsign_of_license(UNSIGNED1 wh) := '';
 
EXPORT Make_radio_service_code(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_radio_service_code(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_radio_service_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_licensees_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_licensees_name(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_licensees_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_licensees_attention_line(SALT311.StrType s0) := s0;
EXPORT InValid_licensees_attention_line(SALT311.StrType s) := 0;
EXPORT InValidMessage_licensees_attention_line(UNSIGNED1 wh) := '';
 
EXPORT Make_dba_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_dba_name(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_dba_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_licensees_street(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_licensees_street(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_licensees_street(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_licensees_city(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_licensees_city(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_licensees_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_licensees_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_licensees_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_licensees_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_licensees_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_licensees_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_licensees_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_licensees_phone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_licensees_phone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_licensees_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_date_application_received_at_fcc(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_application_received_at_fcc(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_application_received_at_fcc(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_date_license_issued(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_license_issued(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_license_issued(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_date_license_expires(SALT311.StrType s0) := MakeFT_Invalid_Future(s0);
EXPORT InValid_date_license_expires(SALT311.StrType s) := InValidFT_Invalid_Future(s);
EXPORT InValidMessage_date_license_expires(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future(wh);
 
EXPORT Make_date_of_last_change(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_of_last_change(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_of_last_change(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_type_of_last_change(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_type_of_last_change(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_type_of_last_change(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_latitude(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_latitude(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_latitude(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_longitude(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_longitude(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_longitude(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_transmitters_street(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_transmitters_street(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_transmitters_street(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_transmitters_city(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_transmitters_city(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_transmitters_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_transmitters_county(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_transmitters_county(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_transmitters_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_transmitters_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_transmitters_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_transmitters_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_transmitters_antenna_height(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_transmitters_antenna_height(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_transmitters_antenna_height(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_transmitters_height_above_avg_terra(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_transmitters_height_above_avg_terra(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_transmitters_height_above_avg_terra(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_transmitters_height_above_ground_le(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_transmitters_height_above_ground_le(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_transmitters_height_above_ground_le(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_power_of_this_frequency(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_power_of_this_frequency(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_power_of_this_frequency(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_frequency_mhz(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_frequency_mhz(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_frequency_mhz(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_class_of_station(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_class_of_station(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_class_of_station(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_number_of_units_authorized_on_freq(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_number_of_units_authorized_on_freq(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_number_of_units_authorized_on_freq(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_effective_radiated_power(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_effective_radiated_power(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_effective_radiated_power(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_emissions_codes(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_emissions_codes(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_emissions_codes(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_frequency_coordination_number(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_frequency_coordination_number(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_frequency_coordination_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_paging_license_status(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_paging_license_status(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_paging_license_status(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_control_point_for_the_system(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_control_point_for_the_system(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_control_point_for_the_system(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_pending_or_granted(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_pending_or_granted(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_pending_or_granted(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_firm_preparing_application(SALT311.StrType s0) := s0;
EXPORT InValid_firm_preparing_application(SALT311.StrType s) := 0;
EXPORT InValidMessage_firm_preparing_application(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_firms_street_address(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_contact_firms_street_address(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_contact_firms_street_address(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_contact_firms_city(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_contact_firms_city(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_contact_firms_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_contact_firms_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_contact_firms_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_contact_firms_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_contact_firms_zipcode(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_contact_firms_zipcode(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_contact_firms_zipcode(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_contact_firms_phone_number(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_contact_firms_phone_number(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_contact_firms_phone_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_contact_firms_fax_number(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_contact_firms_fax_number(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_contact_firms_fax_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_unique_key(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_unique_key(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_unique_key(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_crlf(SALT311.StrType s0) := s0;
EXPORT InValid_crlf(SALT311.StrType s) := 0;
EXPORT InValidMessage_crlf(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_FCC;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_license_type;
    BOOLEAN Diff_file_number;
    BOOLEAN Diff_callsign_of_license;
    BOOLEAN Diff_radio_service_code;
    BOOLEAN Diff_licensees_name;
    BOOLEAN Diff_licensees_attention_line;
    BOOLEAN Diff_dba_name;
    BOOLEAN Diff_licensees_street;
    BOOLEAN Diff_licensees_city;
    BOOLEAN Diff_licensees_state;
    BOOLEAN Diff_licensees_zip;
    BOOLEAN Diff_licensees_phone;
    BOOLEAN Diff_date_application_received_at_fcc;
    BOOLEAN Diff_date_license_issued;
    BOOLEAN Diff_date_license_expires;
    BOOLEAN Diff_date_of_last_change;
    BOOLEAN Diff_type_of_last_change;
    BOOLEAN Diff_latitude;
    BOOLEAN Diff_longitude;
    BOOLEAN Diff_transmitters_street;
    BOOLEAN Diff_transmitters_city;
    BOOLEAN Diff_transmitters_county;
    BOOLEAN Diff_transmitters_state;
    BOOLEAN Diff_transmitters_antenna_height;
    BOOLEAN Diff_transmitters_height_above_avg_terra;
    BOOLEAN Diff_transmitters_height_above_ground_le;
    BOOLEAN Diff_power_of_this_frequency;
    BOOLEAN Diff_frequency_mhz;
    BOOLEAN Diff_class_of_station;
    BOOLEAN Diff_number_of_units_authorized_on_freq;
    BOOLEAN Diff_effective_radiated_power;
    BOOLEAN Diff_emissions_codes;
    BOOLEAN Diff_frequency_coordination_number;
    BOOLEAN Diff_paging_license_status;
    BOOLEAN Diff_control_point_for_the_system;
    BOOLEAN Diff_pending_or_granted;
    BOOLEAN Diff_firm_preparing_application;
    BOOLEAN Diff_contact_firms_street_address;
    BOOLEAN Diff_contact_firms_city;
    BOOLEAN Diff_contact_firms_state;
    BOOLEAN Diff_contact_firms_zipcode;
    BOOLEAN Diff_contact_firms_phone_number;
    BOOLEAN Diff_contact_firms_fax_number;
    BOOLEAN Diff_unique_key;
    BOOLEAN Diff_crlf;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_license_type := le.license_type <> ri.license_type;
    SELF.Diff_file_number := le.file_number <> ri.file_number;
    SELF.Diff_callsign_of_license := le.callsign_of_license <> ri.callsign_of_license;
    SELF.Diff_radio_service_code := le.radio_service_code <> ri.radio_service_code;
    SELF.Diff_licensees_name := le.licensees_name <> ri.licensees_name;
    SELF.Diff_licensees_attention_line := le.licensees_attention_line <> ri.licensees_attention_line;
    SELF.Diff_dba_name := le.dba_name <> ri.dba_name;
    SELF.Diff_licensees_street := le.licensees_street <> ri.licensees_street;
    SELF.Diff_licensees_city := le.licensees_city <> ri.licensees_city;
    SELF.Diff_licensees_state := le.licensees_state <> ri.licensees_state;
    SELF.Diff_licensees_zip := le.licensees_zip <> ri.licensees_zip;
    SELF.Diff_licensees_phone := le.licensees_phone <> ri.licensees_phone;
    SELF.Diff_date_application_received_at_fcc := le.date_application_received_at_fcc <> ri.date_application_received_at_fcc;
    SELF.Diff_date_license_issued := le.date_license_issued <> ri.date_license_issued;
    SELF.Diff_date_license_expires := le.date_license_expires <> ri.date_license_expires;
    SELF.Diff_date_of_last_change := le.date_of_last_change <> ri.date_of_last_change;
    SELF.Diff_type_of_last_change := le.type_of_last_change <> ri.type_of_last_change;
    SELF.Diff_latitude := le.latitude <> ri.latitude;
    SELF.Diff_longitude := le.longitude <> ri.longitude;
    SELF.Diff_transmitters_street := le.transmitters_street <> ri.transmitters_street;
    SELF.Diff_transmitters_city := le.transmitters_city <> ri.transmitters_city;
    SELF.Diff_transmitters_county := le.transmitters_county <> ri.transmitters_county;
    SELF.Diff_transmitters_state := le.transmitters_state <> ri.transmitters_state;
    SELF.Diff_transmitters_antenna_height := le.transmitters_antenna_height <> ri.transmitters_antenna_height;
    SELF.Diff_transmitters_height_above_avg_terra := le.transmitters_height_above_avg_terra <> ri.transmitters_height_above_avg_terra;
    SELF.Diff_transmitters_height_above_ground_le := le.transmitters_height_above_ground_le <> ri.transmitters_height_above_ground_le;
    SELF.Diff_power_of_this_frequency := le.power_of_this_frequency <> ri.power_of_this_frequency;
    SELF.Diff_frequency_mhz := le.frequency_mhz <> ri.frequency_mhz;
    SELF.Diff_class_of_station := le.class_of_station <> ri.class_of_station;
    SELF.Diff_number_of_units_authorized_on_freq := le.number_of_units_authorized_on_freq <> ri.number_of_units_authorized_on_freq;
    SELF.Diff_effective_radiated_power := le.effective_radiated_power <> ri.effective_radiated_power;
    SELF.Diff_emissions_codes := le.emissions_codes <> ri.emissions_codes;
    SELF.Diff_frequency_coordination_number := le.frequency_coordination_number <> ri.frequency_coordination_number;
    SELF.Diff_paging_license_status := le.paging_license_status <> ri.paging_license_status;
    SELF.Diff_control_point_for_the_system := le.control_point_for_the_system <> ri.control_point_for_the_system;
    SELF.Diff_pending_or_granted := le.pending_or_granted <> ri.pending_or_granted;
    SELF.Diff_firm_preparing_application := le.firm_preparing_application <> ri.firm_preparing_application;
    SELF.Diff_contact_firms_street_address := le.contact_firms_street_address <> ri.contact_firms_street_address;
    SELF.Diff_contact_firms_city := le.contact_firms_city <> ri.contact_firms_city;
    SELF.Diff_contact_firms_state := le.contact_firms_state <> ri.contact_firms_state;
    SELF.Diff_contact_firms_zipcode := le.contact_firms_zipcode <> ri.contact_firms_zipcode;
    SELF.Diff_contact_firms_phone_number := le.contact_firms_phone_number <> ri.contact_firms_phone_number;
    SELF.Diff_contact_firms_fax_number := le.contact_firms_fax_number <> ri.contact_firms_fax_number;
    SELF.Diff_unique_key := le.unique_key <> ri.unique_key;
    SELF.Diff_crlf := le.crlf <> ri.crlf;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_license_type,1,0)+ IF( SELF.Diff_file_number,1,0)+ IF( SELF.Diff_callsign_of_license,1,0)+ IF( SELF.Diff_radio_service_code,1,0)+ IF( SELF.Diff_licensees_name,1,0)+ IF( SELF.Diff_licensees_attention_line,1,0)+ IF( SELF.Diff_dba_name,1,0)+ IF( SELF.Diff_licensees_street,1,0)+ IF( SELF.Diff_licensees_city,1,0)+ IF( SELF.Diff_licensees_state,1,0)+ IF( SELF.Diff_licensees_zip,1,0)+ IF( SELF.Diff_licensees_phone,1,0)+ IF( SELF.Diff_date_application_received_at_fcc,1,0)+ IF( SELF.Diff_date_license_issued,1,0)+ IF( SELF.Diff_date_license_expires,1,0)+ IF( SELF.Diff_date_of_last_change,1,0)+ IF( SELF.Diff_type_of_last_change,1,0)+ IF( SELF.Diff_latitude,1,0)+ IF( SELF.Diff_longitude,1,0)+ IF( SELF.Diff_transmitters_street,1,0)+ IF( SELF.Diff_transmitters_city,1,0)+ IF( SELF.Diff_transmitters_county,1,0)+ IF( SELF.Diff_transmitters_state,1,0)+ IF( SELF.Diff_transmitters_antenna_height,1,0)+ IF( SELF.Diff_transmitters_height_above_avg_terra,1,0)+ IF( SELF.Diff_transmitters_height_above_ground_le,1,0)+ IF( SELF.Diff_power_of_this_frequency,1,0)+ IF( SELF.Diff_frequency_mhz,1,0)+ IF( SELF.Diff_class_of_station,1,0)+ IF( SELF.Diff_number_of_units_authorized_on_freq,1,0)+ IF( SELF.Diff_effective_radiated_power,1,0)+ IF( SELF.Diff_emissions_codes,1,0)+ IF( SELF.Diff_frequency_coordination_number,1,0)+ IF( SELF.Diff_paging_license_status,1,0)+ IF( SELF.Diff_control_point_for_the_system,1,0)+ IF( SELF.Diff_pending_or_granted,1,0)+ IF( SELF.Diff_firm_preparing_application,1,0)+ IF( SELF.Diff_contact_firms_street_address,1,0)+ IF( SELF.Diff_contact_firms_city,1,0)+ IF( SELF.Diff_contact_firms_state,1,0)+ IF( SELF.Diff_contact_firms_zipcode,1,0)+ IF( SELF.Diff_contact_firms_phone_number,1,0)+ IF( SELF.Diff_contact_firms_fax_number,1,0)+ IF( SELF.Diff_unique_key,1,0)+ IF( SELF.Diff_crlf,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_license_type := COUNT(GROUP,%Closest%.Diff_license_type);
    Count_Diff_file_number := COUNT(GROUP,%Closest%.Diff_file_number);
    Count_Diff_callsign_of_license := COUNT(GROUP,%Closest%.Diff_callsign_of_license);
    Count_Diff_radio_service_code := COUNT(GROUP,%Closest%.Diff_radio_service_code);
    Count_Diff_licensees_name := COUNT(GROUP,%Closest%.Diff_licensees_name);
    Count_Diff_licensees_attention_line := COUNT(GROUP,%Closest%.Diff_licensees_attention_line);
    Count_Diff_dba_name := COUNT(GROUP,%Closest%.Diff_dba_name);
    Count_Diff_licensees_street := COUNT(GROUP,%Closest%.Diff_licensees_street);
    Count_Diff_licensees_city := COUNT(GROUP,%Closest%.Diff_licensees_city);
    Count_Diff_licensees_state := COUNT(GROUP,%Closest%.Diff_licensees_state);
    Count_Diff_licensees_zip := COUNT(GROUP,%Closest%.Diff_licensees_zip);
    Count_Diff_licensees_phone := COUNT(GROUP,%Closest%.Diff_licensees_phone);
    Count_Diff_date_application_received_at_fcc := COUNT(GROUP,%Closest%.Diff_date_application_received_at_fcc);
    Count_Diff_date_license_issued := COUNT(GROUP,%Closest%.Diff_date_license_issued);
    Count_Diff_date_license_expires := COUNT(GROUP,%Closest%.Diff_date_license_expires);
    Count_Diff_date_of_last_change := COUNT(GROUP,%Closest%.Diff_date_of_last_change);
    Count_Diff_type_of_last_change := COUNT(GROUP,%Closest%.Diff_type_of_last_change);
    Count_Diff_latitude := COUNT(GROUP,%Closest%.Diff_latitude);
    Count_Diff_longitude := COUNT(GROUP,%Closest%.Diff_longitude);
    Count_Diff_transmitters_street := COUNT(GROUP,%Closest%.Diff_transmitters_street);
    Count_Diff_transmitters_city := COUNT(GROUP,%Closest%.Diff_transmitters_city);
    Count_Diff_transmitters_county := COUNT(GROUP,%Closest%.Diff_transmitters_county);
    Count_Diff_transmitters_state := COUNT(GROUP,%Closest%.Diff_transmitters_state);
    Count_Diff_transmitters_antenna_height := COUNT(GROUP,%Closest%.Diff_transmitters_antenna_height);
    Count_Diff_transmitters_height_above_avg_terra := COUNT(GROUP,%Closest%.Diff_transmitters_height_above_avg_terra);
    Count_Diff_transmitters_height_above_ground_le := COUNT(GROUP,%Closest%.Diff_transmitters_height_above_ground_le);
    Count_Diff_power_of_this_frequency := COUNT(GROUP,%Closest%.Diff_power_of_this_frequency);
    Count_Diff_frequency_mhz := COUNT(GROUP,%Closest%.Diff_frequency_mhz);
    Count_Diff_class_of_station := COUNT(GROUP,%Closest%.Diff_class_of_station);
    Count_Diff_number_of_units_authorized_on_freq := COUNT(GROUP,%Closest%.Diff_number_of_units_authorized_on_freq);
    Count_Diff_effective_radiated_power := COUNT(GROUP,%Closest%.Diff_effective_radiated_power);
    Count_Diff_emissions_codes := COUNT(GROUP,%Closest%.Diff_emissions_codes);
    Count_Diff_frequency_coordination_number := COUNT(GROUP,%Closest%.Diff_frequency_coordination_number);
    Count_Diff_paging_license_status := COUNT(GROUP,%Closest%.Diff_paging_license_status);
    Count_Diff_control_point_for_the_system := COUNT(GROUP,%Closest%.Diff_control_point_for_the_system);
    Count_Diff_pending_or_granted := COUNT(GROUP,%Closest%.Diff_pending_or_granted);
    Count_Diff_firm_preparing_application := COUNT(GROUP,%Closest%.Diff_firm_preparing_application);
    Count_Diff_contact_firms_street_address := COUNT(GROUP,%Closest%.Diff_contact_firms_street_address);
    Count_Diff_contact_firms_city := COUNT(GROUP,%Closest%.Diff_contact_firms_city);
    Count_Diff_contact_firms_state := COUNT(GROUP,%Closest%.Diff_contact_firms_state);
    Count_Diff_contact_firms_zipcode := COUNT(GROUP,%Closest%.Diff_contact_firms_zipcode);
    Count_Diff_contact_firms_phone_number := COUNT(GROUP,%Closest%.Diff_contact_firms_phone_number);
    Count_Diff_contact_firms_fax_number := COUNT(GROUP,%Closest%.Diff_contact_firms_fax_number);
    Count_Diff_unique_key := COUNT(GROUP,%Closest%.Diff_unique_key);
    Count_Diff_crlf := COUNT(GROUP,%Closest%.Diff_crlf);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

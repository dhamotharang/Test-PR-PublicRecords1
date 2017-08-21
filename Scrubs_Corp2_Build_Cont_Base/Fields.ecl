IMPORT ut,SALT30;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alphaNum','invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_name_type_code','invalid_name_type_desc','invalid_forgn_dom_code','invalid_flag_code','invalid_mandatory','invalid_numeric','invalid_charter','invalid_alphaOnly','invalid_alphaRequired','invalid_date','invalid_zip','invalid_phone','invalid_cont_name');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'invalid_alphaNum' => 1,'invalid_corp_key' => 2,'invalid_corp_vendor' => 3,'invalid_state_origin' => 4,'invalid_name_type_code' => 5,'invalid_name_type_desc' => 6,'invalid_forgn_dom_code' => 7,'invalid_flag_code' => 8,'invalid_mandatory' => 9,'invalid_numeric' => 10,'invalid_charter' => 11,'invalid_alphaOnly' => 12,'invalid_alphaRequired' => 13,'invalid_date' => 14,'invalid_zip' => 15,'invalid_phone' => 16,'invalid_cont_name' => 17,0);
 
EXPORT MakeFT_invalid_alphaNum(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789;"-.@%&*()\'#\\/,`:$! <>{}[]-^=!+&,./#()'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' <>{}[]-^=!+&,./#()',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphaNum(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789;"-.@%&*()\'#\\/,`:$! <>{}[]-^=!+&,./#()'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_alphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789;"-.@%&*()\'#\\/,`:$! <>{}[]-^=!+&,./#()'),SALT30.HygieneErrors.NotLength('1..'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_key(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_key(SALT30.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_corp_key(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotLength('4..'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_vendor(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_corp_vendor(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_corp_vendor(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('2'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_origin(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_state_origin(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state_origin(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT30.HygieneErrors.NotLength('2'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name_type_code(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name_type_code(SALT30.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_name_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotLength('1..'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name_type_desc(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name_type_desc(SALT30.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_name_type_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotLength('1..'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_forgn_dom_code(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_forgn_dom_code(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['D','F',' ']);
EXPORT InValidMessageFT_invalid_forgn_dom_code(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('D|F| '),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_flag_code(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_flag_code(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['N','Y',' ']);
EXPORT InValidMessageFT_invalid_flag_code(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('N|Y| '),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT30.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotLength('1..'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('1..'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_charter(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_charter(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_charter(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT30.HygieneErrors.NotLength('1..'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphaOnly(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphaOnly(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_alphaOnly(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphaRequired(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphaRequired(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_alphaRequired(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT30.HygieneErrors.NotLength('1..'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT30.HygieneErrors.NotLength('0..8'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('5,9'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789- '); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_phone(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789- '))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 12));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789- '),SALT30.HygieneErrors.NotLength('0..12'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cont_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789;"-.*\'\\/,`&  ,.'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,'  ,.',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_cont_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789;"-.*\'\\/,`&  ,.'))));
EXPORT InValidMessageFT_invalid_cont_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789;"-.*\'\\/,`&  ,.'),SALT30.HygieneErrors.Good);
 
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'bdid','did','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','corp_key','corp_supp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_orig_sos_charter_nbr','corp_sos_charter_nbr','corp_legal_name','corp_address1_type_cd','corp_address1_type_desc','corp_address1_line1','corp_address1_line2','corp_address1_line3','corp_address1_line4','corp_address1_line5','corp_address1_line6','corp_address1_effective_date','corp_phone_number','corp_phone_number_type_cd','corp_phone_number_type_desc','corp_fax_nbr','corp_email_address','corp_web_address','cont_filing_reference_nbr','cont_filing_date','cont_filing_cd','cont_filing_desc','cont_type_cd','cont_type_desc','cont_name','cont_title_desc','cont_sos_charter_nbr','cont_fein','cont_ssn','cont_dob','cont_status_cd','cont_status_desc','cont_effective_date','cont_effective_cd','cont_effective_desc','cont_addl_info','cont_address_type_cd','cont_address_type_desc','cont_address_line1','cont_address_line2','cont_address_line3','cont_address_line4','cont_address_line5','cont_address_line6','cont_address_effective_date','cont_address_county','cont_phone_number','cont_phone_number_type_cd','cont_phone_number_type_desc','cont_fax_nbr','cont_email_address','cont_web_address','corp_addr1_prim_range','corp_addr1_predir','corp_addr1_prim_name','corp_addr1_addr_suffix','corp_addr1_postdir','corp_addr1_unit_desig','corp_addr1_sec_range','corp_addr1_p_city_name','corp_addr1_v_city_name','corp_addr1_state','corp_addr1_zip5','corp_addr1_zip4','corp_addr1_cart','corp_addr1_cr_sort_sz','corp_addr1_lot','corp_addr1_lot_order','corp_addr1_dpbc','corp_addr1_chk_digit','corp_addr1_rec_type','corp_addr1_ace_fips_st','corp_addr1_county','corp_addr1_geo_lat','corp_addr1_geo_long','corp_addr1_msa','corp_addr1_geo_blk','corp_addr1_geo_match','corp_addr1_err_stat','cont_title','cont_fname','cont_mname','cont_lname','cont_name_suffix','cont_score','cont_cname','cont_cname_score','cont_prim_range','cont_predir','cont_prim_name','cont_addr_suffix','cont_postdir','cont_unit_desig','cont_sec_range','cont_p_city_name','cont_v_city_name','cont_state','cont_zip5','cont_zip4','cont_cart','cont_cr_sort_sz','cont_lot','cont_lot_order','cont_dpbc','cont_chk_digit','cont_rec_type','cont_ace_fips_st','cont_county','cont_geo_lat','cont_geo_long','cont_msa','cont_geo_blk','cont_geo_match','cont_err_stat','corp_phone10','cont_phone10','record_type','append_corp_addr_rawaid','append_corp_addr_aceaid','corp_prep_addr_line1','corp_prep_addr_last_line','append_cont_addr_rawaid','append_cont_addr_aceaid','cont_prep_addr_line1','cont_prep_addr_last_line','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'bdid' => 1,'did' => 2,'dt_first_seen' => 3,'dt_last_seen' => 4,'dt_vendor_first_reported' => 5,'dt_vendor_last_reported' => 6,'corp_key' => 7,'corp_supp_key' => 8,'corp_vendor' => 9,'corp_vendor_county' => 10,'corp_vendor_subcode' => 11,'corp_state_origin' => 12,'corp_process_date' => 13,'corp_orig_sos_charter_nbr' => 14,'corp_sos_charter_nbr' => 15,'corp_legal_name' => 16,'corp_address1_type_cd' => 17,'corp_address1_type_desc' => 18,'corp_address1_line1' => 19,'corp_address1_line2' => 20,'corp_address1_line3' => 21,'corp_address1_line4' => 22,'corp_address1_line5' => 23,'corp_address1_line6' => 24,'corp_address1_effective_date' => 25,'corp_phone_number' => 26,'corp_phone_number_type_cd' => 27,'corp_phone_number_type_desc' => 28,'corp_fax_nbr' => 29,'corp_email_address' => 30,'corp_web_address' => 31,'cont_filing_reference_nbr' => 32,'cont_filing_date' => 33,'cont_filing_cd' => 34,'cont_filing_desc' => 35,'cont_type_cd' => 36,'cont_type_desc' => 37,'cont_name' => 38,'cont_title_desc' => 39,'cont_sos_charter_nbr' => 40,'cont_fein' => 41,'cont_ssn' => 42,'cont_dob' => 43,'cont_status_cd' => 44,'cont_status_desc' => 45,'cont_effective_date' => 46,'cont_effective_cd' => 47,'cont_effective_desc' => 48,'cont_addl_info' => 49,'cont_address_type_cd' => 50,'cont_address_type_desc' => 51,'cont_address_line1' => 52,'cont_address_line2' => 53,'cont_address_line3' => 54,'cont_address_line4' => 55,'cont_address_line5' => 56,'cont_address_line6' => 57,'cont_address_effective_date' => 58,'cont_address_county' => 59,'cont_phone_number' => 60,'cont_phone_number_type_cd' => 61,'cont_phone_number_type_desc' => 62,'cont_fax_nbr' => 63,'cont_email_address' => 64,'cont_web_address' => 65,'corp_addr1_prim_range' => 66,'corp_addr1_predir' => 67,'corp_addr1_prim_name' => 68,'corp_addr1_addr_suffix' => 69,'corp_addr1_postdir' => 70,'corp_addr1_unit_desig' => 71,'corp_addr1_sec_range' => 72,'corp_addr1_p_city_name' => 73,'corp_addr1_v_city_name' => 74,'corp_addr1_state' => 75,'corp_addr1_zip5' => 76,'corp_addr1_zip4' => 77,'corp_addr1_cart' => 78,'corp_addr1_cr_sort_sz' => 79,'corp_addr1_lot' => 80,'corp_addr1_lot_order' => 81,'corp_addr1_dpbc' => 82,'corp_addr1_chk_digit' => 83,'corp_addr1_rec_type' => 84,'corp_addr1_ace_fips_st' => 85,'corp_addr1_county' => 86,'corp_addr1_geo_lat' => 87,'corp_addr1_geo_long' => 88,'corp_addr1_msa' => 89,'corp_addr1_geo_blk' => 90,'corp_addr1_geo_match' => 91,'corp_addr1_err_stat' => 92,'cont_title' => 93,'cont_fname' => 94,'cont_mname' => 95,'cont_lname' => 96,'cont_name_suffix' => 97,'cont_score' => 98,'cont_cname' => 99,'cont_cname_score' => 100,'cont_prim_range' => 101,'cont_predir' => 102,'cont_prim_name' => 103,'cont_addr_suffix' => 104,'cont_postdir' => 105,'cont_unit_desig' => 106,'cont_sec_range' => 107,'cont_p_city_name' => 108,'cont_v_city_name' => 109,'cont_state' => 110,'cont_zip5' => 111,'cont_zip4' => 112,'cont_cart' => 113,'cont_cr_sort_sz' => 114,'cont_lot' => 115,'cont_lot_order' => 116,'cont_dpbc' => 117,'cont_chk_digit' => 118,'cont_rec_type' => 119,'cont_ace_fips_st' => 120,'cont_county' => 121,'cont_geo_lat' => 122,'cont_geo_long' => 123,'cont_msa' => 124,'cont_geo_blk' => 125,'cont_geo_match' => 126,'cont_err_stat' => 127,'corp_phone10' => 128,'cont_phone10' => 129,'record_type' => 130,'append_corp_addr_rawaid' => 131,'append_corp_addr_aceaid' => 132,'corp_prep_addr_line1' => 133,'corp_prep_addr_last_line' => 134,'append_cont_addr_rawaid' => 135,'append_cont_addr_aceaid' => 136,'cont_prep_addr_line1' => 137,'cont_prep_addr_last_line' => 138,'dotid' => 139,'dotscore' => 140,'dotweight' => 141,'empid' => 142,'empscore' => 143,'empweight' => 144,'powid' => 145,'powscore' => 146,'powweight' => 147,'proxid' => 148,'proxscore' => 149,'proxweight' => 150,'seleid' => 151,'selescore' => 152,'seleweight' => 153,'orgid' => 154,'orgscore' => 155,'orgweight' => 156,'ultid' => 157,'ultscore' => 158,'ultweight' => 159,0);
 
//Individual field level validation
 
EXPORT Make_bdid(SALT30.StrType s0) := s0;
EXPORT InValid_bdid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := '';
 
EXPORT Make_did(SALT30.StrType s0) := s0;
EXPORT InValid_did(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT30.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT30.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_first_reported(SALT30.StrType s0) := s0;
EXPORT InValid_dt_vendor_first_reported(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_last_reported(SALT30.StrType s0) := s0;
EXPORT InValid_dt_vendor_last_reported(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_key(SALT30.StrType s0) := MakeFT_invalid_corp_key(s0);
EXPORT InValid_corp_key(SALT30.StrType s) := InValidFT_invalid_corp_key(s);
EXPORT InValidMessage_corp_key(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_key(wh);
 
EXPORT Make_corp_supp_key(SALT30.StrType s0) := s0;
EXPORT InValid_corp_supp_key(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_supp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_vendor(SALT30.StrType s0) := MakeFT_invalid_corp_vendor(s0);
EXPORT InValid_corp_vendor(SALT30.StrType s) := InValidFT_invalid_corp_vendor(s);
EXPORT InValidMessage_corp_vendor(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_vendor(wh);
 
EXPORT Make_corp_vendor_county(SALT30.StrType s0) := s0;
EXPORT InValid_corp_vendor_county(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_vendor_county(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_vendor_subcode(SALT30.StrType s0) := s0;
EXPORT InValid_corp_vendor_subcode(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_vendor_subcode(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_state_origin(SALT30.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_state_origin(SALT30.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_state_origin(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_process_date(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_process_date(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_orig_sos_charter_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_corp_orig_sos_charter_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_orig_sos_charter_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_sos_charter_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_corp_sos_charter_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_sos_charter_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_legal_name(SALT30.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_corp_legal_name(SALT30.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_corp_legal_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_corp_address1_type_cd(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address1_type_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address1_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address1_type_desc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address1_type_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address1_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address1_line1(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address1_line1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address1_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address1_line2(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address1_line2(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address1_line2(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address1_line3(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address1_line3(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address1_line3(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address1_line4(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address1_line4(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address1_line4(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address1_line5(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address1_line5(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address1_line5(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address1_line6(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address1_line6(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address1_line6(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address1_effective_date(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address1_effective_date(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address1_effective_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_phone_number(SALT30.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_corp_phone_number(SALT30.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_corp_phone_number(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_corp_phone_number_type_cd(SALT30.StrType s0) := s0;
EXPORT InValid_corp_phone_number_type_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_phone_number_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_phone_number_type_desc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_phone_number_type_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_phone_number_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_fax_nbr(SALT30.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_corp_fax_nbr(SALT30.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_corp_fax_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_corp_email_address(SALT30.StrType s0) := s0;
EXPORT InValid_corp_email_address(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_email_address(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_web_address(SALT30.StrType s0) := s0;
EXPORT InValid_corp_web_address(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_web_address(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_filing_reference_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_cont_filing_reference_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_filing_reference_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_filing_date(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_cont_filing_date(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_cont_filing_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_cont_filing_cd(SALT30.StrType s0) := s0;
EXPORT InValid_cont_filing_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_filing_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_filing_desc(SALT30.StrType s0) := s0;
EXPORT InValid_cont_filing_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_filing_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_type_cd(SALT30.StrType s0) := s0;
EXPORT InValid_cont_type_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_type_desc(SALT30.StrType s0) := s0;
EXPORT InValid_cont_type_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_name(SALT30.StrType s0) := s0;
EXPORT InValid_cont_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_name(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_title_desc(SALT30.StrType s0) := s0;
EXPORT InValid_cont_title_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_title_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_sos_charter_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_cont_sos_charter_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_sos_charter_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_fein(SALT30.StrType s0) := s0;
EXPORT InValid_cont_fein(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_ssn(SALT30.StrType s0) := s0;
EXPORT InValid_cont_ssn(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_dob(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_cont_dob(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_cont_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_cont_status_cd(SALT30.StrType s0) := s0;
EXPORT InValid_cont_status_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_status_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_status_desc(SALT30.StrType s0) := s0;
EXPORT InValid_cont_status_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_status_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_effective_date(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_cont_effective_date(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_cont_effective_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_cont_effective_cd(SALT30.StrType s0) := s0;
EXPORT InValid_cont_effective_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_effective_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_effective_desc(SALT30.StrType s0) := s0;
EXPORT InValid_cont_effective_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_effective_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_addl_info(SALT30.StrType s0) := s0;
EXPORT InValid_cont_addl_info(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_addl_info(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_address_type_cd(SALT30.StrType s0) := s0;
EXPORT InValid_cont_address_type_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_address_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_address_type_desc(SALT30.StrType s0) := s0;
EXPORT InValid_cont_address_type_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_address_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_address_line1(SALT30.StrType s0) := s0;
EXPORT InValid_cont_address_line1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_address_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_address_line2(SALT30.StrType s0) := s0;
EXPORT InValid_cont_address_line2(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_address_line2(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_address_line3(SALT30.StrType s0) := s0;
EXPORT InValid_cont_address_line3(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_address_line3(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_address_line4(SALT30.StrType s0) := s0;
EXPORT InValid_cont_address_line4(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_address_line4(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_address_line5(SALT30.StrType s0) := s0;
EXPORT InValid_cont_address_line5(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_address_line5(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_address_line6(SALT30.StrType s0) := s0;
EXPORT InValid_cont_address_line6(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_address_line6(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_address_effective_date(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_cont_address_effective_date(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_cont_address_effective_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_cont_address_county(SALT30.StrType s0) := s0;
EXPORT InValid_cont_address_county(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_address_county(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_phone_number(SALT30.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_cont_phone_number(SALT30.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_cont_phone_number(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_cont_phone_number_type_cd(SALT30.StrType s0) := s0;
EXPORT InValid_cont_phone_number_type_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_phone_number_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_phone_number_type_desc(SALT30.StrType s0) := s0;
EXPORT InValid_cont_phone_number_type_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_phone_number_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_fax_nbr(SALT30.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_cont_fax_nbr(SALT30.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_cont_fax_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_cont_email_address(SALT30.StrType s0) := s0;
EXPORT InValid_cont_email_address(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_email_address(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_web_address(SALT30.StrType s0) := s0;
EXPORT InValid_cont_web_address(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_web_address(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_prim_range(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_prim_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_predir(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_predir(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_prim_name(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_prim_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_addr_suffix(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_addr_suffix(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_postdir(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_postdir(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_unit_desig(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_unit_desig(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_sec_range(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_sec_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_p_city_name(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_p_city_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_v_city_name(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_v_city_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_state(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_state(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_state(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_zip5(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_zip5(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_zip5(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_zip4(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_zip4(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_cart(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_cart(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_cr_sort_sz(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_cr_sort_sz(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_lot(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_lot(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_lot_order(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_lot_order(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_dpbc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_dpbc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_dpbc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_chk_digit(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_chk_digit(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_rec_type(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_rec_type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_ace_fips_st(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_ace_fips_st(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_ace_fips_st(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_county(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_county(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_county(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_geo_lat(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_geo_lat(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_geo_long(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_geo_long(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_msa(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_msa(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_geo_blk(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_geo_blk(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_geo_match(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_geo_match(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr1_err_stat(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr1_err_stat(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr1_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_title(SALT30.StrType s0) := s0;
EXPORT InValid_cont_title(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_title(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_fname(SALT30.StrType s0) := s0;
EXPORT InValid_cont_fname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_mname(SALT30.StrType s0) := s0;
EXPORT InValid_cont_mname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_lname(SALT30.StrType s0) := s0;
EXPORT InValid_cont_lname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_name_suffix(SALT30.StrType s0) := s0;
EXPORT InValid_cont_name_suffix(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_score(SALT30.StrType s0) := s0;
EXPORT InValid_cont_score(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_score(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_cname(SALT30.StrType s0) := s0;
EXPORT InValid_cont_cname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_cname(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_cname_score(SALT30.StrType s0) := s0;
EXPORT InValid_cont_cname_score(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_cname_score(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_prim_range(SALT30.StrType s0) := s0;
EXPORT InValid_cont_prim_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_predir(SALT30.StrType s0) := s0;
EXPORT InValid_cont_predir(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_prim_name(SALT30.StrType s0) := s0;
EXPORT InValid_cont_prim_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_addr_suffix(SALT30.StrType s0) := s0;
EXPORT InValid_cont_addr_suffix(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_postdir(SALT30.StrType s0) := s0;
EXPORT InValid_cont_postdir(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_unit_desig(SALT30.StrType s0) := s0;
EXPORT InValid_cont_unit_desig(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_sec_range(SALT30.StrType s0) := s0;
EXPORT InValid_cont_sec_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_p_city_name(SALT30.StrType s0) := s0;
EXPORT InValid_cont_p_city_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_v_city_name(SALT30.StrType s0) := s0;
EXPORT InValid_cont_v_city_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_state(SALT30.StrType s0) := s0;
EXPORT InValid_cont_state(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_state(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_zip5(SALT30.StrType s0) := s0;
EXPORT InValid_cont_zip5(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_zip5(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_zip4(SALT30.StrType s0) := s0;
EXPORT InValid_cont_zip4(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_cart(SALT30.StrType s0) := s0;
EXPORT InValid_cont_cart(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_cr_sort_sz(SALT30.StrType s0) := s0;
EXPORT InValid_cont_cr_sort_sz(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_lot(SALT30.StrType s0) := s0;
EXPORT InValid_cont_lot(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_lot_order(SALT30.StrType s0) := s0;
EXPORT InValid_cont_lot_order(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_dpbc(SALT30.StrType s0) := s0;
EXPORT InValid_cont_dpbc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_dpbc(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_chk_digit(SALT30.StrType s0) := s0;
EXPORT InValid_cont_chk_digit(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_rec_type(SALT30.StrType s0) := s0;
EXPORT InValid_cont_rec_type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_ace_fips_st(SALT30.StrType s0) := s0;
EXPORT InValid_cont_ace_fips_st(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_ace_fips_st(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_county(SALT30.StrType s0) := s0;
EXPORT InValid_cont_county(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_county(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_geo_lat(SALT30.StrType s0) := s0;
EXPORT InValid_cont_geo_lat(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_geo_long(SALT30.StrType s0) := s0;
EXPORT InValid_cont_geo_long(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_msa(SALT30.StrType s0) := s0;
EXPORT InValid_cont_msa(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_geo_blk(SALT30.StrType s0) := s0;
EXPORT InValid_cont_geo_blk(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_geo_match(SALT30.StrType s0) := s0;
EXPORT InValid_cont_geo_match(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_err_stat(SALT30.StrType s0) := s0;
EXPORT InValid_cont_err_stat(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_phone10(SALT30.StrType s0) := s0;
EXPORT InValid_corp_phone10(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_phone10(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_phone10(SALT30.StrType s0) := s0;
EXPORT InValid_cont_phone10(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_phone10(UNSIGNED1 wh) := '';
 
EXPORT Make_record_type(SALT30.StrType s0) := s0;
EXPORT InValid_record_type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := '';
 
EXPORT Make_append_corp_addr_rawaid(SALT30.StrType s0) := s0;
EXPORT InValid_append_corp_addr_rawaid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_corp_addr_rawaid(UNSIGNED1 wh) := '';
 
EXPORT Make_append_corp_addr_aceaid(SALT30.StrType s0) := s0;
EXPORT InValid_append_corp_addr_aceaid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_corp_addr_aceaid(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_prep_addr_line1(SALT30.StrType s0) := s0;
EXPORT InValid_corp_prep_addr_line1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_prep_addr_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_prep_addr_last_line(SALT30.StrType s0) := s0;
EXPORT InValid_corp_prep_addr_last_line(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_prep_addr_last_line(UNSIGNED1 wh) := '';
 
EXPORT Make_append_cont_addr_rawaid(SALT30.StrType s0) := s0;
EXPORT InValid_append_cont_addr_rawaid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_cont_addr_rawaid(UNSIGNED1 wh) := '';
 
EXPORT Make_append_cont_addr_aceaid(SALT30.StrType s0) := s0;
EXPORT InValid_append_cont_addr_aceaid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_cont_addr_aceaid(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_prep_addr_line1(SALT30.StrType s0) := s0;
EXPORT InValid_cont_prep_addr_line1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_prep_addr_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_cont_prep_addr_last_line(SALT30.StrType s0) := s0;
EXPORT InValid_cont_prep_addr_last_line(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cont_prep_addr_last_line(UNSIGNED1 wh) := '';
 
EXPORT Make_dotid(SALT30.StrType s0) := s0;
EXPORT InValid_dotid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := '';
 
EXPORT Make_dotscore(SALT30.StrType s0) := s0;
EXPORT InValid_dotscore(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := '';
 
EXPORT Make_dotweight(SALT30.StrType s0) := s0;
EXPORT InValid_dotweight(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := '';
 
EXPORT Make_empid(SALT30.StrType s0) := s0;
EXPORT InValid_empid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_empid(UNSIGNED1 wh) := '';
 
EXPORT Make_empscore(SALT30.StrType s0) := s0;
EXPORT InValid_empscore(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := '';
 
EXPORT Make_empweight(SALT30.StrType s0) := s0;
EXPORT InValid_empweight(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := '';
 
EXPORT Make_powid(SALT30.StrType s0) := s0;
EXPORT InValid_powid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_powid(UNSIGNED1 wh) := '';
 
EXPORT Make_powscore(SALT30.StrType s0) := s0;
EXPORT InValid_powscore(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := '';
 
EXPORT Make_powweight(SALT30.StrType s0) := s0;
EXPORT InValid_powweight(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := '';
 
EXPORT Make_proxid(SALT30.StrType s0) := s0;
EXPORT InValid_proxid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_proxscore(SALT30.StrType s0) := s0;
EXPORT InValid_proxscore(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := '';
 
EXPORT Make_proxweight(SALT30.StrType s0) := s0;
EXPORT InValid_proxweight(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := '';
 
EXPORT Make_seleid(SALT30.StrType s0) := s0;
EXPORT InValid_seleid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := '';
 
EXPORT Make_selescore(SALT30.StrType s0) := s0;
EXPORT InValid_selescore(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := '';
 
EXPORT Make_seleweight(SALT30.StrType s0) := s0;
EXPORT InValid_seleweight(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := '';
 
EXPORT Make_orgid(SALT30.StrType s0) := s0;
EXPORT InValid_orgid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := '';
 
EXPORT Make_orgscore(SALT30.StrType s0) := s0;
EXPORT InValid_orgscore(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := '';
 
EXPORT Make_orgweight(SALT30.StrType s0) := s0;
EXPORT InValid_orgweight(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := '';
 
EXPORT Make_ultid(SALT30.StrType s0) := s0;
EXPORT InValid_ultid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := '';
 
EXPORT Make_ultscore(SALT30.StrType s0) := s0;
EXPORT InValid_ultscore(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := '';
 
EXPORT Make_ultweight(SALT30.StrType s0) := s0;
EXPORT InValid_ultweight(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,Scrubs_Corp2_Build_Cont_Base;
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
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_did;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_corp_key;
    BOOLEAN Diff_corp_supp_key;
    BOOLEAN Diff_corp_vendor;
    BOOLEAN Diff_corp_vendor_county;
    BOOLEAN Diff_corp_vendor_subcode;
    BOOLEAN Diff_corp_state_origin;
    BOOLEAN Diff_corp_process_date;
    BOOLEAN Diff_corp_orig_sos_charter_nbr;
    BOOLEAN Diff_corp_sos_charter_nbr;
    BOOLEAN Diff_corp_legal_name;
    BOOLEAN Diff_corp_address1_type_cd;
    BOOLEAN Diff_corp_address1_type_desc;
    BOOLEAN Diff_corp_address1_line1;
    BOOLEAN Diff_corp_address1_line2;
    BOOLEAN Diff_corp_address1_line3;
    BOOLEAN Diff_corp_address1_line4;
    BOOLEAN Diff_corp_address1_line5;
    BOOLEAN Diff_corp_address1_line6;
    BOOLEAN Diff_corp_address1_effective_date;
    BOOLEAN Diff_corp_phone_number;
    BOOLEAN Diff_corp_phone_number_type_cd;
    BOOLEAN Diff_corp_phone_number_type_desc;
    BOOLEAN Diff_corp_fax_nbr;
    BOOLEAN Diff_corp_email_address;
    BOOLEAN Diff_corp_web_address;
    BOOLEAN Diff_cont_filing_reference_nbr;
    BOOLEAN Diff_cont_filing_date;
    BOOLEAN Diff_cont_filing_cd;
    BOOLEAN Diff_cont_filing_desc;
    BOOLEAN Diff_cont_type_cd;
    BOOLEAN Diff_cont_type_desc;
    BOOLEAN Diff_cont_name;
    BOOLEAN Diff_cont_title_desc;
    BOOLEAN Diff_cont_sos_charter_nbr;
    BOOLEAN Diff_cont_fein;
    BOOLEAN Diff_cont_ssn;
    BOOLEAN Diff_cont_dob;
    BOOLEAN Diff_cont_status_cd;
    BOOLEAN Diff_cont_status_desc;
    BOOLEAN Diff_cont_effective_date;
    BOOLEAN Diff_cont_effective_cd;
    BOOLEAN Diff_cont_effective_desc;
    BOOLEAN Diff_cont_addl_info;
    BOOLEAN Diff_cont_address_type_cd;
    BOOLEAN Diff_cont_address_type_desc;
    BOOLEAN Diff_cont_address_line1;
    BOOLEAN Diff_cont_address_line2;
    BOOLEAN Diff_cont_address_line3;
    BOOLEAN Diff_cont_address_line4;
    BOOLEAN Diff_cont_address_line5;
    BOOLEAN Diff_cont_address_line6;
    BOOLEAN Diff_cont_address_effective_date;
    BOOLEAN Diff_cont_address_county;
    BOOLEAN Diff_cont_phone_number;
    BOOLEAN Diff_cont_phone_number_type_cd;
    BOOLEAN Diff_cont_phone_number_type_desc;
    BOOLEAN Diff_cont_fax_nbr;
    BOOLEAN Diff_cont_email_address;
    BOOLEAN Diff_cont_web_address;
    BOOLEAN Diff_corp_addr1_prim_range;
    BOOLEAN Diff_corp_addr1_predir;
    BOOLEAN Diff_corp_addr1_prim_name;
    BOOLEAN Diff_corp_addr1_addr_suffix;
    BOOLEAN Diff_corp_addr1_postdir;
    BOOLEAN Diff_corp_addr1_unit_desig;
    BOOLEAN Diff_corp_addr1_sec_range;
    BOOLEAN Diff_corp_addr1_p_city_name;
    BOOLEAN Diff_corp_addr1_v_city_name;
    BOOLEAN Diff_corp_addr1_state;
    BOOLEAN Diff_corp_addr1_zip5;
    BOOLEAN Diff_corp_addr1_zip4;
    BOOLEAN Diff_corp_addr1_cart;
    BOOLEAN Diff_corp_addr1_cr_sort_sz;
    BOOLEAN Diff_corp_addr1_lot;
    BOOLEAN Diff_corp_addr1_lot_order;
    BOOLEAN Diff_corp_addr1_dpbc;
    BOOLEAN Diff_corp_addr1_chk_digit;
    BOOLEAN Diff_corp_addr1_rec_type;
    BOOLEAN Diff_corp_addr1_ace_fips_st;
    BOOLEAN Diff_corp_addr1_county;
    BOOLEAN Diff_corp_addr1_geo_lat;
    BOOLEAN Diff_corp_addr1_geo_long;
    BOOLEAN Diff_corp_addr1_msa;
    BOOLEAN Diff_corp_addr1_geo_blk;
    BOOLEAN Diff_corp_addr1_geo_match;
    BOOLEAN Diff_corp_addr1_err_stat;
    BOOLEAN Diff_cont_title;
    BOOLEAN Diff_cont_fname;
    BOOLEAN Diff_cont_mname;
    BOOLEAN Diff_cont_lname;
    BOOLEAN Diff_cont_name_suffix;
    BOOLEAN Diff_cont_score;
    BOOLEAN Diff_cont_cname;
    BOOLEAN Diff_cont_cname_score;
    BOOLEAN Diff_cont_prim_range;
    BOOLEAN Diff_cont_predir;
    BOOLEAN Diff_cont_prim_name;
    BOOLEAN Diff_cont_addr_suffix;
    BOOLEAN Diff_cont_postdir;
    BOOLEAN Diff_cont_unit_desig;
    BOOLEAN Diff_cont_sec_range;
    BOOLEAN Diff_cont_p_city_name;
    BOOLEAN Diff_cont_v_city_name;
    BOOLEAN Diff_cont_state;
    BOOLEAN Diff_cont_zip5;
    BOOLEAN Diff_cont_zip4;
    BOOLEAN Diff_cont_cart;
    BOOLEAN Diff_cont_cr_sort_sz;
    BOOLEAN Diff_cont_lot;
    BOOLEAN Diff_cont_lot_order;
    BOOLEAN Diff_cont_dpbc;
    BOOLEAN Diff_cont_chk_digit;
    BOOLEAN Diff_cont_rec_type;
    BOOLEAN Diff_cont_ace_fips_st;
    BOOLEAN Diff_cont_county;
    BOOLEAN Diff_cont_geo_lat;
    BOOLEAN Diff_cont_geo_long;
    BOOLEAN Diff_cont_msa;
    BOOLEAN Diff_cont_geo_blk;
    BOOLEAN Diff_cont_geo_match;
    BOOLEAN Diff_cont_err_stat;
    BOOLEAN Diff_corp_phone10;
    BOOLEAN Diff_cont_phone10;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_append_corp_addr_rawaid;
    BOOLEAN Diff_append_corp_addr_aceaid;
    BOOLEAN Diff_corp_prep_addr_line1;
    BOOLEAN Diff_corp_prep_addr_last_line;
    BOOLEAN Diff_append_cont_addr_rawaid;
    BOOLEAN Diff_append_cont_addr_aceaid;
    BOOLEAN Diff_cont_prep_addr_line1;
    BOOLEAN Diff_cont_prep_addr_last_line;
    BOOLEAN Diff_dotid;
    BOOLEAN Diff_dotscore;
    BOOLEAN Diff_dotweight;
    BOOLEAN Diff_empid;
    BOOLEAN Diff_empscore;
    BOOLEAN Diff_empweight;
    BOOLEAN Diff_powid;
    BOOLEAN Diff_powscore;
    BOOLEAN Diff_powweight;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_proxscore;
    BOOLEAN Diff_proxweight;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_selescore;
    BOOLEAN Diff_seleweight;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_orgscore;
    BOOLEAN Diff_orgweight;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_ultscore;
    BOOLEAN Diff_ultweight;
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_corp_key := le.corp_key <> ri.corp_key;
    SELF.Diff_corp_supp_key := le.corp_supp_key <> ri.corp_supp_key;
    SELF.Diff_corp_vendor := le.corp_vendor <> ri.corp_vendor;
    SELF.Diff_corp_vendor_county := le.corp_vendor_county <> ri.corp_vendor_county;
    SELF.Diff_corp_vendor_subcode := le.corp_vendor_subcode <> ri.corp_vendor_subcode;
    SELF.Diff_corp_state_origin := le.corp_state_origin <> ri.corp_state_origin;
    SELF.Diff_corp_process_date := le.corp_process_date <> ri.corp_process_date;
    SELF.Diff_corp_orig_sos_charter_nbr := le.corp_orig_sos_charter_nbr <> ri.corp_orig_sos_charter_nbr;
    SELF.Diff_corp_sos_charter_nbr := le.corp_sos_charter_nbr <> ri.corp_sos_charter_nbr;
    SELF.Diff_corp_legal_name := le.corp_legal_name <> ri.corp_legal_name;
    SELF.Diff_corp_address1_type_cd := le.corp_address1_type_cd <> ri.corp_address1_type_cd;
    SELF.Diff_corp_address1_type_desc := le.corp_address1_type_desc <> ri.corp_address1_type_desc;
    SELF.Diff_corp_address1_line1 := le.corp_address1_line1 <> ri.corp_address1_line1;
    SELF.Diff_corp_address1_line2 := le.corp_address1_line2 <> ri.corp_address1_line2;
    SELF.Diff_corp_address1_line3 := le.corp_address1_line3 <> ri.corp_address1_line3;
    SELF.Diff_corp_address1_line4 := le.corp_address1_line4 <> ri.corp_address1_line4;
    SELF.Diff_corp_address1_line5 := le.corp_address1_line5 <> ri.corp_address1_line5;
    SELF.Diff_corp_address1_line6 := le.corp_address1_line6 <> ri.corp_address1_line6;
    SELF.Diff_corp_address1_effective_date := le.corp_address1_effective_date <> ri.corp_address1_effective_date;
    SELF.Diff_corp_phone_number := le.corp_phone_number <> ri.corp_phone_number;
    SELF.Diff_corp_phone_number_type_cd := le.corp_phone_number_type_cd <> ri.corp_phone_number_type_cd;
    SELF.Diff_corp_phone_number_type_desc := le.corp_phone_number_type_desc <> ri.corp_phone_number_type_desc;
    SELF.Diff_corp_fax_nbr := le.corp_fax_nbr <> ri.corp_fax_nbr;
    SELF.Diff_corp_email_address := le.corp_email_address <> ri.corp_email_address;
    SELF.Diff_corp_web_address := le.corp_web_address <> ri.corp_web_address;
    SELF.Diff_cont_filing_reference_nbr := le.cont_filing_reference_nbr <> ri.cont_filing_reference_nbr;
    SELF.Diff_cont_filing_date := le.cont_filing_date <> ri.cont_filing_date;
    SELF.Diff_cont_filing_cd := le.cont_filing_cd <> ri.cont_filing_cd;
    SELF.Diff_cont_filing_desc := le.cont_filing_desc <> ri.cont_filing_desc;
    SELF.Diff_cont_type_cd := le.cont_type_cd <> ri.cont_type_cd;
    SELF.Diff_cont_type_desc := le.cont_type_desc <> ri.cont_type_desc;
    SELF.Diff_cont_name := le.cont_name <> ri.cont_name;
    SELF.Diff_cont_title_desc := le.cont_title_desc <> ri.cont_title_desc;
    SELF.Diff_cont_sos_charter_nbr := le.cont_sos_charter_nbr <> ri.cont_sos_charter_nbr;
    SELF.Diff_cont_fein := le.cont_fein <> ri.cont_fein;
    SELF.Diff_cont_ssn := le.cont_ssn <> ri.cont_ssn;
    SELF.Diff_cont_dob := le.cont_dob <> ri.cont_dob;
    SELF.Diff_cont_status_cd := le.cont_status_cd <> ri.cont_status_cd;
    SELF.Diff_cont_status_desc := le.cont_status_desc <> ri.cont_status_desc;
    SELF.Diff_cont_effective_date := le.cont_effective_date <> ri.cont_effective_date;
    SELF.Diff_cont_effective_cd := le.cont_effective_cd <> ri.cont_effective_cd;
    SELF.Diff_cont_effective_desc := le.cont_effective_desc <> ri.cont_effective_desc;
    SELF.Diff_cont_addl_info := le.cont_addl_info <> ri.cont_addl_info;
    SELF.Diff_cont_address_type_cd := le.cont_address_type_cd <> ri.cont_address_type_cd;
    SELF.Diff_cont_address_type_desc := le.cont_address_type_desc <> ri.cont_address_type_desc;
    SELF.Diff_cont_address_line1 := le.cont_address_line1 <> ri.cont_address_line1;
    SELF.Diff_cont_address_line2 := le.cont_address_line2 <> ri.cont_address_line2;
    SELF.Diff_cont_address_line3 := le.cont_address_line3 <> ri.cont_address_line3;
    SELF.Diff_cont_address_line4 := le.cont_address_line4 <> ri.cont_address_line4;
    SELF.Diff_cont_address_line5 := le.cont_address_line5 <> ri.cont_address_line5;
    SELF.Diff_cont_address_line6 := le.cont_address_line6 <> ri.cont_address_line6;
    SELF.Diff_cont_address_effective_date := le.cont_address_effective_date <> ri.cont_address_effective_date;
    SELF.Diff_cont_address_county := le.cont_address_county <> ri.cont_address_county;
    SELF.Diff_cont_phone_number := le.cont_phone_number <> ri.cont_phone_number;
    SELF.Diff_cont_phone_number_type_cd := le.cont_phone_number_type_cd <> ri.cont_phone_number_type_cd;
    SELF.Diff_cont_phone_number_type_desc := le.cont_phone_number_type_desc <> ri.cont_phone_number_type_desc;
    SELF.Diff_cont_fax_nbr := le.cont_fax_nbr <> ri.cont_fax_nbr;
    SELF.Diff_cont_email_address := le.cont_email_address <> ri.cont_email_address;
    SELF.Diff_cont_web_address := le.cont_web_address <> ri.cont_web_address;
    SELF.Diff_corp_addr1_prim_range := le.corp_addr1_prim_range <> ri.corp_addr1_prim_range;
    SELF.Diff_corp_addr1_predir := le.corp_addr1_predir <> ri.corp_addr1_predir;
    SELF.Diff_corp_addr1_prim_name := le.corp_addr1_prim_name <> ri.corp_addr1_prim_name;
    SELF.Diff_corp_addr1_addr_suffix := le.corp_addr1_addr_suffix <> ri.corp_addr1_addr_suffix;
    SELF.Diff_corp_addr1_postdir := le.corp_addr1_postdir <> ri.corp_addr1_postdir;
    SELF.Diff_corp_addr1_unit_desig := le.corp_addr1_unit_desig <> ri.corp_addr1_unit_desig;
    SELF.Diff_corp_addr1_sec_range := le.corp_addr1_sec_range <> ri.corp_addr1_sec_range;
    SELF.Diff_corp_addr1_p_city_name := le.corp_addr1_p_city_name <> ri.corp_addr1_p_city_name;
    SELF.Diff_corp_addr1_v_city_name := le.corp_addr1_v_city_name <> ri.corp_addr1_v_city_name;
    SELF.Diff_corp_addr1_state := le.corp_addr1_state <> ri.corp_addr1_state;
    SELF.Diff_corp_addr1_zip5 := le.corp_addr1_zip5 <> ri.corp_addr1_zip5;
    SELF.Diff_corp_addr1_zip4 := le.corp_addr1_zip4 <> ri.corp_addr1_zip4;
    SELF.Diff_corp_addr1_cart := le.corp_addr1_cart <> ri.corp_addr1_cart;
    SELF.Diff_corp_addr1_cr_sort_sz := le.corp_addr1_cr_sort_sz <> ri.corp_addr1_cr_sort_sz;
    SELF.Diff_corp_addr1_lot := le.corp_addr1_lot <> ri.corp_addr1_lot;
    SELF.Diff_corp_addr1_lot_order := le.corp_addr1_lot_order <> ri.corp_addr1_lot_order;
    SELF.Diff_corp_addr1_dpbc := le.corp_addr1_dpbc <> ri.corp_addr1_dpbc;
    SELF.Diff_corp_addr1_chk_digit := le.corp_addr1_chk_digit <> ri.corp_addr1_chk_digit;
    SELF.Diff_corp_addr1_rec_type := le.corp_addr1_rec_type <> ri.corp_addr1_rec_type;
    SELF.Diff_corp_addr1_ace_fips_st := le.corp_addr1_ace_fips_st <> ri.corp_addr1_ace_fips_st;
    SELF.Diff_corp_addr1_county := le.corp_addr1_county <> ri.corp_addr1_county;
    SELF.Diff_corp_addr1_geo_lat := le.corp_addr1_geo_lat <> ri.corp_addr1_geo_lat;
    SELF.Diff_corp_addr1_geo_long := le.corp_addr1_geo_long <> ri.corp_addr1_geo_long;
    SELF.Diff_corp_addr1_msa := le.corp_addr1_msa <> ri.corp_addr1_msa;
    SELF.Diff_corp_addr1_geo_blk := le.corp_addr1_geo_blk <> ri.corp_addr1_geo_blk;
    SELF.Diff_corp_addr1_geo_match := le.corp_addr1_geo_match <> ri.corp_addr1_geo_match;
    SELF.Diff_corp_addr1_err_stat := le.corp_addr1_err_stat <> ri.corp_addr1_err_stat;
    SELF.Diff_cont_title := le.cont_title <> ri.cont_title;
    SELF.Diff_cont_fname := le.cont_fname <> ri.cont_fname;
    SELF.Diff_cont_mname := le.cont_mname <> ri.cont_mname;
    SELF.Diff_cont_lname := le.cont_lname <> ri.cont_lname;
    SELF.Diff_cont_name_suffix := le.cont_name_suffix <> ri.cont_name_suffix;
    SELF.Diff_cont_score := le.cont_score <> ri.cont_score;
    SELF.Diff_cont_cname := le.cont_cname <> ri.cont_cname;
    SELF.Diff_cont_cname_score := le.cont_cname_score <> ri.cont_cname_score;
    SELF.Diff_cont_prim_range := le.cont_prim_range <> ri.cont_prim_range;
    SELF.Diff_cont_predir := le.cont_predir <> ri.cont_predir;
    SELF.Diff_cont_prim_name := le.cont_prim_name <> ri.cont_prim_name;
    SELF.Diff_cont_addr_suffix := le.cont_addr_suffix <> ri.cont_addr_suffix;
    SELF.Diff_cont_postdir := le.cont_postdir <> ri.cont_postdir;
    SELF.Diff_cont_unit_desig := le.cont_unit_desig <> ri.cont_unit_desig;
    SELF.Diff_cont_sec_range := le.cont_sec_range <> ri.cont_sec_range;
    SELF.Diff_cont_p_city_name := le.cont_p_city_name <> ri.cont_p_city_name;
    SELF.Diff_cont_v_city_name := le.cont_v_city_name <> ri.cont_v_city_name;
    SELF.Diff_cont_state := le.cont_state <> ri.cont_state;
    SELF.Diff_cont_zip5 := le.cont_zip5 <> ri.cont_zip5;
    SELF.Diff_cont_zip4 := le.cont_zip4 <> ri.cont_zip4;
    SELF.Diff_cont_cart := le.cont_cart <> ri.cont_cart;
    SELF.Diff_cont_cr_sort_sz := le.cont_cr_sort_sz <> ri.cont_cr_sort_sz;
    SELF.Diff_cont_lot := le.cont_lot <> ri.cont_lot;
    SELF.Diff_cont_lot_order := le.cont_lot_order <> ri.cont_lot_order;
    SELF.Diff_cont_dpbc := le.cont_dpbc <> ri.cont_dpbc;
    SELF.Diff_cont_chk_digit := le.cont_chk_digit <> ri.cont_chk_digit;
    SELF.Diff_cont_rec_type := le.cont_rec_type <> ri.cont_rec_type;
    SELF.Diff_cont_ace_fips_st := le.cont_ace_fips_st <> ri.cont_ace_fips_st;
    SELF.Diff_cont_county := le.cont_county <> ri.cont_county;
    SELF.Diff_cont_geo_lat := le.cont_geo_lat <> ri.cont_geo_lat;
    SELF.Diff_cont_geo_long := le.cont_geo_long <> ri.cont_geo_long;
    SELF.Diff_cont_msa := le.cont_msa <> ri.cont_msa;
    SELF.Diff_cont_geo_blk := le.cont_geo_blk <> ri.cont_geo_blk;
    SELF.Diff_cont_geo_match := le.cont_geo_match <> ri.cont_geo_match;
    SELF.Diff_cont_err_stat := le.cont_err_stat <> ri.cont_err_stat;
    SELF.Diff_corp_phone10 := le.corp_phone10 <> ri.corp_phone10;
    SELF.Diff_cont_phone10 := le.cont_phone10 <> ri.cont_phone10;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_append_corp_addr_rawaid := le.append_corp_addr_rawaid <> ri.append_corp_addr_rawaid;
    SELF.Diff_append_corp_addr_aceaid := le.append_corp_addr_aceaid <> ri.append_corp_addr_aceaid;
    SELF.Diff_corp_prep_addr_line1 := le.corp_prep_addr_line1 <> ri.corp_prep_addr_line1;
    SELF.Diff_corp_prep_addr_last_line := le.corp_prep_addr_last_line <> ri.corp_prep_addr_last_line;
    SELF.Diff_append_cont_addr_rawaid := le.append_cont_addr_rawaid <> ri.append_cont_addr_rawaid;
    SELF.Diff_append_cont_addr_aceaid := le.append_cont_addr_aceaid <> ri.append_cont_addr_aceaid;
    SELF.Diff_cont_prep_addr_line1 := le.cont_prep_addr_line1 <> ri.cont_prep_addr_line1;
    SELF.Diff_cont_prep_addr_last_line := le.cont_prep_addr_last_line <> ri.cont_prep_addr_last_line;
    SELF.Diff_dotid := le.dotid <> ri.dotid;
    SELF.Diff_dotscore := le.dotscore <> ri.dotscore;
    SELF.Diff_dotweight := le.dotweight <> ri.dotweight;
    SELF.Diff_empid := le.empid <> ri.empid;
    SELF.Diff_empscore := le.empscore <> ri.empscore;
    SELF.Diff_empweight := le.empweight <> ri.empweight;
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_powscore := le.powscore <> ri.powscore;
    SELF.Diff_powweight := le.powweight <> ri.powweight;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_proxscore := le.proxscore <> ri.proxscore;
    SELF.Diff_proxweight := le.proxweight <> ri.proxweight;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_selescore := le.selescore <> ri.selescore;
    SELF.Diff_seleweight := le.seleweight <> ri.seleweight;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_orgscore := le.orgscore <> ri.orgscore;
    SELF.Diff_orgweight := le.orgweight <> ri.orgweight;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_ultscore := le.ultscore <> ri.ultscore;
    SELF.Diff_ultweight := le.ultweight <> ri.ultweight;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_corp_key,1,0)+ IF( SELF.Diff_corp_supp_key,1,0)+ IF( SELF.Diff_corp_vendor,1,0)+ IF( SELF.Diff_corp_vendor_county,1,0)+ IF( SELF.Diff_corp_vendor_subcode,1,0)+ IF( SELF.Diff_corp_state_origin,1,0)+ IF( SELF.Diff_corp_process_date,1,0)+ IF( SELF.Diff_corp_orig_sos_charter_nbr,1,0)+ IF( SELF.Diff_corp_sos_charter_nbr,1,0)+ IF( SELF.Diff_corp_legal_name,1,0)+ IF( SELF.Diff_corp_address1_type_cd,1,0)+ IF( SELF.Diff_corp_address1_type_desc,1,0)+ IF( SELF.Diff_corp_address1_line1,1,0)+ IF( SELF.Diff_corp_address1_line2,1,0)+ IF( SELF.Diff_corp_address1_line3,1,0)+ IF( SELF.Diff_corp_address1_line4,1,0)+ IF( SELF.Diff_corp_address1_line5,1,0)+ IF( SELF.Diff_corp_address1_line6,1,0)+ IF( SELF.Diff_corp_address1_effective_date,1,0)+ IF( SELF.Diff_corp_phone_number,1,0)+ IF( SELF.Diff_corp_phone_number_type_cd,1,0)+ IF( SELF.Diff_corp_phone_number_type_desc,1,0)+ IF( SELF.Diff_corp_fax_nbr,1,0)+ IF( SELF.Diff_corp_email_address,1,0)+ IF( SELF.Diff_corp_web_address,1,0)+ IF( SELF.Diff_cont_filing_reference_nbr,1,0)+ IF( SELF.Diff_cont_filing_date,1,0)+ IF( SELF.Diff_cont_filing_cd,1,0)+ IF( SELF.Diff_cont_filing_desc,1,0)+ IF( SELF.Diff_cont_type_cd,1,0)+ IF( SELF.Diff_cont_type_desc,1,0)+ IF( SELF.Diff_cont_name,1,0)+ IF( SELF.Diff_cont_title_desc,1,0)+ IF( SELF.Diff_cont_sos_charter_nbr,1,0)+ IF( SELF.Diff_cont_fein,1,0)+ IF( SELF.Diff_cont_ssn,1,0)+ IF( SELF.Diff_cont_dob,1,0)+ IF( SELF.Diff_cont_status_cd,1,0)+ IF( SELF.Diff_cont_status_desc,1,0)+ IF( SELF.Diff_cont_effective_date,1,0)+ IF( SELF.Diff_cont_effective_cd,1,0)+ IF( SELF.Diff_cont_effective_desc,1,0)+ IF( SELF.Diff_cont_addl_info,1,0)+ IF( SELF.Diff_cont_address_type_cd,1,0)+ IF( SELF.Diff_cont_address_type_desc,1,0)+ IF( SELF.Diff_cont_address_line1,1,0)+ IF( SELF.Diff_cont_address_line2,1,0)+ IF( SELF.Diff_cont_address_line3,1,0)+ IF( SELF.Diff_cont_address_line4,1,0)+ IF( SELF.Diff_cont_address_line5,1,0)+ IF( SELF.Diff_cont_address_line6,1,0)+ IF( SELF.Diff_cont_address_effective_date,1,0)+ IF( SELF.Diff_cont_address_county,1,0)+ IF( SELF.Diff_cont_phone_number,1,0)+ IF( SELF.Diff_cont_phone_number_type_cd,1,0)+ IF( SELF.Diff_cont_phone_number_type_desc,1,0)+ IF( SELF.Diff_cont_fax_nbr,1,0)+ IF( SELF.Diff_cont_email_address,1,0)+ IF( SELF.Diff_cont_web_address,1,0)+ IF( SELF.Diff_corp_addr1_prim_range,1,0)+ IF( SELF.Diff_corp_addr1_predir,1,0)+ IF( SELF.Diff_corp_addr1_prim_name,1,0)+ IF( SELF.Diff_corp_addr1_addr_suffix,1,0)+ IF( SELF.Diff_corp_addr1_postdir,1,0)+ IF( SELF.Diff_corp_addr1_unit_desig,1,0)+ IF( SELF.Diff_corp_addr1_sec_range,1,0)+ IF( SELF.Diff_corp_addr1_p_city_name,1,0)+ IF( SELF.Diff_corp_addr1_v_city_name,1,0)+ IF( SELF.Diff_corp_addr1_state,1,0)+ IF( SELF.Diff_corp_addr1_zip5,1,0)+ IF( SELF.Diff_corp_addr1_zip4,1,0)+ IF( SELF.Diff_corp_addr1_cart,1,0)+ IF( SELF.Diff_corp_addr1_cr_sort_sz,1,0)+ IF( SELF.Diff_corp_addr1_lot,1,0)+ IF( SELF.Diff_corp_addr1_lot_order,1,0)+ IF( SELF.Diff_corp_addr1_dpbc,1,0)+ IF( SELF.Diff_corp_addr1_chk_digit,1,0)+ IF( SELF.Diff_corp_addr1_rec_type,1,0)+ IF( SELF.Diff_corp_addr1_ace_fips_st,1,0)+ IF( SELF.Diff_corp_addr1_county,1,0)+ IF( SELF.Diff_corp_addr1_geo_lat,1,0)+ IF( SELF.Diff_corp_addr1_geo_long,1,0)+ IF( SELF.Diff_corp_addr1_msa,1,0)+ IF( SELF.Diff_corp_addr1_geo_blk,1,0)+ IF( SELF.Diff_corp_addr1_geo_match,1,0)+ IF( SELF.Diff_corp_addr1_err_stat,1,0)+ IF( SELF.Diff_cont_title,1,0)+ IF( SELF.Diff_cont_fname,1,0)+ IF( SELF.Diff_cont_mname,1,0)+ IF( SELF.Diff_cont_lname,1,0)+ IF( SELF.Diff_cont_name_suffix,1,0)+ IF( SELF.Diff_cont_score,1,0)+ IF( SELF.Diff_cont_cname,1,0)+ IF( SELF.Diff_cont_cname_score,1,0)+ IF( SELF.Diff_cont_prim_range,1,0)+ IF( SELF.Diff_cont_predir,1,0)+ IF( SELF.Diff_cont_prim_name,1,0)+ IF( SELF.Diff_cont_addr_suffix,1,0)+ IF( SELF.Diff_cont_postdir,1,0)+ IF( SELF.Diff_cont_unit_desig,1,0)+ IF( SELF.Diff_cont_sec_range,1,0)+ IF( SELF.Diff_cont_p_city_name,1,0)+ IF( SELF.Diff_cont_v_city_name,1,0)+ IF( SELF.Diff_cont_state,1,0)+ IF( SELF.Diff_cont_zip5,1,0)+ IF( SELF.Diff_cont_zip4,1,0)+ IF( SELF.Diff_cont_cart,1,0)+ IF( SELF.Diff_cont_cr_sort_sz,1,0)+ IF( SELF.Diff_cont_lot,1,0)+ IF( SELF.Diff_cont_lot_order,1,0)+ IF( SELF.Diff_cont_dpbc,1,0)+ IF( SELF.Diff_cont_chk_digit,1,0)+ IF( SELF.Diff_cont_rec_type,1,0)+ IF( SELF.Diff_cont_ace_fips_st,1,0)+ IF( SELF.Diff_cont_county,1,0)+ IF( SELF.Diff_cont_geo_lat,1,0)+ IF( SELF.Diff_cont_geo_long,1,0)+ IF( SELF.Diff_cont_msa,1,0)+ IF( SELF.Diff_cont_geo_blk,1,0)+ IF( SELF.Diff_cont_geo_match,1,0)+ IF( SELF.Diff_cont_err_stat,1,0)+ IF( SELF.Diff_corp_phone10,1,0)+ IF( SELF.Diff_cont_phone10,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_append_corp_addr_rawaid,1,0)+ IF( SELF.Diff_append_corp_addr_aceaid,1,0)+ IF( SELF.Diff_corp_prep_addr_line1,1,0)+ IF( SELF.Diff_corp_prep_addr_last_line,1,0)+ IF( SELF.Diff_append_cont_addr_rawaid,1,0)+ IF( SELF.Diff_append_cont_addr_aceaid,1,0)+ IF( SELF.Diff_cont_prep_addr_line1,1,0)+ IF( SELF.Diff_cont_prep_addr_last_line,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0);
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
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_corp_key := COUNT(GROUP,%Closest%.Diff_corp_key);
    Count_Diff_corp_supp_key := COUNT(GROUP,%Closest%.Diff_corp_supp_key);
    Count_Diff_corp_vendor := COUNT(GROUP,%Closest%.Diff_corp_vendor);
    Count_Diff_corp_vendor_county := COUNT(GROUP,%Closest%.Diff_corp_vendor_county);
    Count_Diff_corp_vendor_subcode := COUNT(GROUP,%Closest%.Diff_corp_vendor_subcode);
    Count_Diff_corp_state_origin := COUNT(GROUP,%Closest%.Diff_corp_state_origin);
    Count_Diff_corp_process_date := COUNT(GROUP,%Closest%.Diff_corp_process_date);
    Count_Diff_corp_orig_sos_charter_nbr := COUNT(GROUP,%Closest%.Diff_corp_orig_sos_charter_nbr);
    Count_Diff_corp_sos_charter_nbr := COUNT(GROUP,%Closest%.Diff_corp_sos_charter_nbr);
    Count_Diff_corp_legal_name := COUNT(GROUP,%Closest%.Diff_corp_legal_name);
    Count_Diff_corp_address1_type_cd := COUNT(GROUP,%Closest%.Diff_corp_address1_type_cd);
    Count_Diff_corp_address1_type_desc := COUNT(GROUP,%Closest%.Diff_corp_address1_type_desc);
    Count_Diff_corp_address1_line1 := COUNT(GROUP,%Closest%.Diff_corp_address1_line1);
    Count_Diff_corp_address1_line2 := COUNT(GROUP,%Closest%.Diff_corp_address1_line2);
    Count_Diff_corp_address1_line3 := COUNT(GROUP,%Closest%.Diff_corp_address1_line3);
    Count_Diff_corp_address1_line4 := COUNT(GROUP,%Closest%.Diff_corp_address1_line4);
    Count_Diff_corp_address1_line5 := COUNT(GROUP,%Closest%.Diff_corp_address1_line5);
    Count_Diff_corp_address1_line6 := COUNT(GROUP,%Closest%.Diff_corp_address1_line6);
    Count_Diff_corp_address1_effective_date := COUNT(GROUP,%Closest%.Diff_corp_address1_effective_date);
    Count_Diff_corp_phone_number := COUNT(GROUP,%Closest%.Diff_corp_phone_number);
    Count_Diff_corp_phone_number_type_cd := COUNT(GROUP,%Closest%.Diff_corp_phone_number_type_cd);
    Count_Diff_corp_phone_number_type_desc := COUNT(GROUP,%Closest%.Diff_corp_phone_number_type_desc);
    Count_Diff_corp_fax_nbr := COUNT(GROUP,%Closest%.Diff_corp_fax_nbr);
    Count_Diff_corp_email_address := COUNT(GROUP,%Closest%.Diff_corp_email_address);
    Count_Diff_corp_web_address := COUNT(GROUP,%Closest%.Diff_corp_web_address);
    Count_Diff_cont_filing_reference_nbr := COUNT(GROUP,%Closest%.Diff_cont_filing_reference_nbr);
    Count_Diff_cont_filing_date := COUNT(GROUP,%Closest%.Diff_cont_filing_date);
    Count_Diff_cont_filing_cd := COUNT(GROUP,%Closest%.Diff_cont_filing_cd);
    Count_Diff_cont_filing_desc := COUNT(GROUP,%Closest%.Diff_cont_filing_desc);
    Count_Diff_cont_type_cd := COUNT(GROUP,%Closest%.Diff_cont_type_cd);
    Count_Diff_cont_type_desc := COUNT(GROUP,%Closest%.Diff_cont_type_desc);
    Count_Diff_cont_name := COUNT(GROUP,%Closest%.Diff_cont_name);
    Count_Diff_cont_title_desc := COUNT(GROUP,%Closest%.Diff_cont_title_desc);
    Count_Diff_cont_sos_charter_nbr := COUNT(GROUP,%Closest%.Diff_cont_sos_charter_nbr);
    Count_Diff_cont_fein := COUNT(GROUP,%Closest%.Diff_cont_fein);
    Count_Diff_cont_ssn := COUNT(GROUP,%Closest%.Diff_cont_ssn);
    Count_Diff_cont_dob := COUNT(GROUP,%Closest%.Diff_cont_dob);
    Count_Diff_cont_status_cd := COUNT(GROUP,%Closest%.Diff_cont_status_cd);
    Count_Diff_cont_status_desc := COUNT(GROUP,%Closest%.Diff_cont_status_desc);
    Count_Diff_cont_effective_date := COUNT(GROUP,%Closest%.Diff_cont_effective_date);
    Count_Diff_cont_effective_cd := COUNT(GROUP,%Closest%.Diff_cont_effective_cd);
    Count_Diff_cont_effective_desc := COUNT(GROUP,%Closest%.Diff_cont_effective_desc);
    Count_Diff_cont_addl_info := COUNT(GROUP,%Closest%.Diff_cont_addl_info);
    Count_Diff_cont_address_type_cd := COUNT(GROUP,%Closest%.Diff_cont_address_type_cd);
    Count_Diff_cont_address_type_desc := COUNT(GROUP,%Closest%.Diff_cont_address_type_desc);
    Count_Diff_cont_address_line1 := COUNT(GROUP,%Closest%.Diff_cont_address_line1);
    Count_Diff_cont_address_line2 := COUNT(GROUP,%Closest%.Diff_cont_address_line2);
    Count_Diff_cont_address_line3 := COUNT(GROUP,%Closest%.Diff_cont_address_line3);
    Count_Diff_cont_address_line4 := COUNT(GROUP,%Closest%.Diff_cont_address_line4);
    Count_Diff_cont_address_line5 := COUNT(GROUP,%Closest%.Diff_cont_address_line5);
    Count_Diff_cont_address_line6 := COUNT(GROUP,%Closest%.Diff_cont_address_line6);
    Count_Diff_cont_address_effective_date := COUNT(GROUP,%Closest%.Diff_cont_address_effective_date);
    Count_Diff_cont_address_county := COUNT(GROUP,%Closest%.Diff_cont_address_county);
    Count_Diff_cont_phone_number := COUNT(GROUP,%Closest%.Diff_cont_phone_number);
    Count_Diff_cont_phone_number_type_cd := COUNT(GROUP,%Closest%.Diff_cont_phone_number_type_cd);
    Count_Diff_cont_phone_number_type_desc := COUNT(GROUP,%Closest%.Diff_cont_phone_number_type_desc);
    Count_Diff_cont_fax_nbr := COUNT(GROUP,%Closest%.Diff_cont_fax_nbr);
    Count_Diff_cont_email_address := COUNT(GROUP,%Closest%.Diff_cont_email_address);
    Count_Diff_cont_web_address := COUNT(GROUP,%Closest%.Diff_cont_web_address);
    Count_Diff_corp_addr1_prim_range := COUNT(GROUP,%Closest%.Diff_corp_addr1_prim_range);
    Count_Diff_corp_addr1_predir := COUNT(GROUP,%Closest%.Diff_corp_addr1_predir);
    Count_Diff_corp_addr1_prim_name := COUNT(GROUP,%Closest%.Diff_corp_addr1_prim_name);
    Count_Diff_corp_addr1_addr_suffix := COUNT(GROUP,%Closest%.Diff_corp_addr1_addr_suffix);
    Count_Diff_corp_addr1_postdir := COUNT(GROUP,%Closest%.Diff_corp_addr1_postdir);
    Count_Diff_corp_addr1_unit_desig := COUNT(GROUP,%Closest%.Diff_corp_addr1_unit_desig);
    Count_Diff_corp_addr1_sec_range := COUNT(GROUP,%Closest%.Diff_corp_addr1_sec_range);
    Count_Diff_corp_addr1_p_city_name := COUNT(GROUP,%Closest%.Diff_corp_addr1_p_city_name);
    Count_Diff_corp_addr1_v_city_name := COUNT(GROUP,%Closest%.Diff_corp_addr1_v_city_name);
    Count_Diff_corp_addr1_state := COUNT(GROUP,%Closest%.Diff_corp_addr1_state);
    Count_Diff_corp_addr1_zip5 := COUNT(GROUP,%Closest%.Diff_corp_addr1_zip5);
    Count_Diff_corp_addr1_zip4 := COUNT(GROUP,%Closest%.Diff_corp_addr1_zip4);
    Count_Diff_corp_addr1_cart := COUNT(GROUP,%Closest%.Diff_corp_addr1_cart);
    Count_Diff_corp_addr1_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_corp_addr1_cr_sort_sz);
    Count_Diff_corp_addr1_lot := COUNT(GROUP,%Closest%.Diff_corp_addr1_lot);
    Count_Diff_corp_addr1_lot_order := COUNT(GROUP,%Closest%.Diff_corp_addr1_lot_order);
    Count_Diff_corp_addr1_dpbc := COUNT(GROUP,%Closest%.Diff_corp_addr1_dpbc);
    Count_Diff_corp_addr1_chk_digit := COUNT(GROUP,%Closest%.Diff_corp_addr1_chk_digit);
    Count_Diff_corp_addr1_rec_type := COUNT(GROUP,%Closest%.Diff_corp_addr1_rec_type);
    Count_Diff_corp_addr1_ace_fips_st := COUNT(GROUP,%Closest%.Diff_corp_addr1_ace_fips_st);
    Count_Diff_corp_addr1_county := COUNT(GROUP,%Closest%.Diff_corp_addr1_county);
    Count_Diff_corp_addr1_geo_lat := COUNT(GROUP,%Closest%.Diff_corp_addr1_geo_lat);
    Count_Diff_corp_addr1_geo_long := COUNT(GROUP,%Closest%.Diff_corp_addr1_geo_long);
    Count_Diff_corp_addr1_msa := COUNT(GROUP,%Closest%.Diff_corp_addr1_msa);
    Count_Diff_corp_addr1_geo_blk := COUNT(GROUP,%Closest%.Diff_corp_addr1_geo_blk);
    Count_Diff_corp_addr1_geo_match := COUNT(GROUP,%Closest%.Diff_corp_addr1_geo_match);
    Count_Diff_corp_addr1_err_stat := COUNT(GROUP,%Closest%.Diff_corp_addr1_err_stat);
    Count_Diff_cont_title := COUNT(GROUP,%Closest%.Diff_cont_title);
    Count_Diff_cont_fname := COUNT(GROUP,%Closest%.Diff_cont_fname);
    Count_Diff_cont_mname := COUNT(GROUP,%Closest%.Diff_cont_mname);
    Count_Diff_cont_lname := COUNT(GROUP,%Closest%.Diff_cont_lname);
    Count_Diff_cont_name_suffix := COUNT(GROUP,%Closest%.Diff_cont_name_suffix);
    Count_Diff_cont_score := COUNT(GROUP,%Closest%.Diff_cont_score);
    Count_Diff_cont_cname := COUNT(GROUP,%Closest%.Diff_cont_cname);
    Count_Diff_cont_cname_score := COUNT(GROUP,%Closest%.Diff_cont_cname_score);
    Count_Diff_cont_prim_range := COUNT(GROUP,%Closest%.Diff_cont_prim_range);
    Count_Diff_cont_predir := COUNT(GROUP,%Closest%.Diff_cont_predir);
    Count_Diff_cont_prim_name := COUNT(GROUP,%Closest%.Diff_cont_prim_name);
    Count_Diff_cont_addr_suffix := COUNT(GROUP,%Closest%.Diff_cont_addr_suffix);
    Count_Diff_cont_postdir := COUNT(GROUP,%Closest%.Diff_cont_postdir);
    Count_Diff_cont_unit_desig := COUNT(GROUP,%Closest%.Diff_cont_unit_desig);
    Count_Diff_cont_sec_range := COUNT(GROUP,%Closest%.Diff_cont_sec_range);
    Count_Diff_cont_p_city_name := COUNT(GROUP,%Closest%.Diff_cont_p_city_name);
    Count_Diff_cont_v_city_name := COUNT(GROUP,%Closest%.Diff_cont_v_city_name);
    Count_Diff_cont_state := COUNT(GROUP,%Closest%.Diff_cont_state);
    Count_Diff_cont_zip5 := COUNT(GROUP,%Closest%.Diff_cont_zip5);
    Count_Diff_cont_zip4 := COUNT(GROUP,%Closest%.Diff_cont_zip4);
    Count_Diff_cont_cart := COUNT(GROUP,%Closest%.Diff_cont_cart);
    Count_Diff_cont_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cont_cr_sort_sz);
    Count_Diff_cont_lot := COUNT(GROUP,%Closest%.Diff_cont_lot);
    Count_Diff_cont_lot_order := COUNT(GROUP,%Closest%.Diff_cont_lot_order);
    Count_Diff_cont_dpbc := COUNT(GROUP,%Closest%.Diff_cont_dpbc);
    Count_Diff_cont_chk_digit := COUNT(GROUP,%Closest%.Diff_cont_chk_digit);
    Count_Diff_cont_rec_type := COUNT(GROUP,%Closest%.Diff_cont_rec_type);
    Count_Diff_cont_ace_fips_st := COUNT(GROUP,%Closest%.Diff_cont_ace_fips_st);
    Count_Diff_cont_county := COUNT(GROUP,%Closest%.Diff_cont_county);
    Count_Diff_cont_geo_lat := COUNT(GROUP,%Closest%.Diff_cont_geo_lat);
    Count_Diff_cont_geo_long := COUNT(GROUP,%Closest%.Diff_cont_geo_long);
    Count_Diff_cont_msa := COUNT(GROUP,%Closest%.Diff_cont_msa);
    Count_Diff_cont_geo_blk := COUNT(GROUP,%Closest%.Diff_cont_geo_blk);
    Count_Diff_cont_geo_match := COUNT(GROUP,%Closest%.Diff_cont_geo_match);
    Count_Diff_cont_err_stat := COUNT(GROUP,%Closest%.Diff_cont_err_stat);
    Count_Diff_corp_phone10 := COUNT(GROUP,%Closest%.Diff_corp_phone10);
    Count_Diff_cont_phone10 := COUNT(GROUP,%Closest%.Diff_cont_phone10);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_append_corp_addr_rawaid := COUNT(GROUP,%Closest%.Diff_append_corp_addr_rawaid);
    Count_Diff_append_corp_addr_aceaid := COUNT(GROUP,%Closest%.Diff_append_corp_addr_aceaid);
    Count_Diff_corp_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_corp_prep_addr_line1);
    Count_Diff_corp_prep_addr_last_line := COUNT(GROUP,%Closest%.Diff_corp_prep_addr_last_line);
    Count_Diff_append_cont_addr_rawaid := COUNT(GROUP,%Closest%.Diff_append_cont_addr_rawaid);
    Count_Diff_append_cont_addr_aceaid := COUNT(GROUP,%Closest%.Diff_append_cont_addr_aceaid);
    Count_Diff_cont_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_cont_prep_addr_line1);
    Count_Diff_cont_prep_addr_last_line := COUNT(GROUP,%Closest%.Diff_cont_prep_addr_last_line);
    Count_Diff_dotid := COUNT(GROUP,%Closest%.Diff_dotid);
    Count_Diff_dotscore := COUNT(GROUP,%Closest%.Diff_dotscore);
    Count_Diff_dotweight := COUNT(GROUP,%Closest%.Diff_dotweight);
    Count_Diff_empid := COUNT(GROUP,%Closest%.Diff_empid);
    Count_Diff_empscore := COUNT(GROUP,%Closest%.Diff_empscore);
    Count_Diff_empweight := COUNT(GROUP,%Closest%.Diff_empweight);
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_powscore := COUNT(GROUP,%Closest%.Diff_powscore);
    Count_Diff_powweight := COUNT(GROUP,%Closest%.Diff_powweight);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_proxscore := COUNT(GROUP,%Closest%.Diff_proxscore);
    Count_Diff_proxweight := COUNT(GROUP,%Closest%.Diff_proxweight);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_selescore := COUNT(GROUP,%Closest%.Diff_selescore);
    Count_Diff_seleweight := COUNT(GROUP,%Closest%.Diff_seleweight);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_orgscore := COUNT(GROUP,%Closest%.Diff_orgscore);
    Count_Diff_orgweight := COUNT(GROUP,%Closest%.Diff_orgweight);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_ultscore := COUNT(GROUP,%Closest%.Diff_ultscore);
    Count_Diff_ultweight := COUNT(GROUP,%Closest%.Diff_ultweight);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

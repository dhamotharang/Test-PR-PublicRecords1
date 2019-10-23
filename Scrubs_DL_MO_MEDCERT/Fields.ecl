IMPORT SALT38;
IMPORT Scrubs_DL_MO_MEDCERT; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 98;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_Past_Date','invalid_general_Date','invalid_Alpha_Numeric','invalid_Hyphen_Alpha_Numeric','invalid_mandatory','invalid_Num','invalid_first_name','invalid_mid_name','invalid_last_name','invalid_gender','invalid_title','invalid_state','invalid_zip','invalid_zip4','invalid_mailing_zip','invalid_eye_color','invalid_operator_status','invalid_commercial_status','invalid_sch_bus_status','invalid_pending_act_code','invalid_must_test_ind','invalid_deceased_ind','invalid_prev_cdl_class','invalid_cdl_ptr','invalid_pdps_ptr','invalid_mvr_privacy_code','invalid_lic_iss_code','invalid_license_class','invalid_license_endorsements','invalid_license_restrictions','invalid_license_trans_type','invalid_permit_class','invalid_permit_iss_code','invalid_permit_endorse_codes','invalid_permit_restric_codes','invalid_permit_trans_type','invalid_non_driver_code','invalid_non_driver_trans_type','invalid_action_counts','invalid_driv_priv_counts','invalid_conv_counts','invalid_accidents_counts','invalid_aka_counts','invalid_fname','invalid_mname','invalid_lname','invalid_direction','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_msa','invalid_geo_match','invalid_err_stat');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'invalid_Past_Date' => 1,'invalid_general_Date' => 2,'invalid_Alpha_Numeric' => 3,'invalid_Hyphen_Alpha_Numeric' => 4,'invalid_mandatory' => 5,'invalid_Num' => 6,'invalid_first_name' => 7,'invalid_mid_name' => 8,'invalid_last_name' => 9,'invalid_gender' => 10,'invalid_title' => 11,'invalid_state' => 12,'invalid_zip' => 13,'invalid_zip4' => 14,'invalid_mailing_zip' => 15,'invalid_eye_color' => 16,'invalid_operator_status' => 17,'invalid_commercial_status' => 18,'invalid_sch_bus_status' => 19,'invalid_pending_act_code' => 20,'invalid_must_test_ind' => 21,'invalid_deceased_ind' => 22,'invalid_prev_cdl_class' => 23,'invalid_cdl_ptr' => 24,'invalid_pdps_ptr' => 25,'invalid_mvr_privacy_code' => 26,'invalid_lic_iss_code' => 27,'invalid_license_class' => 28,'invalid_license_endorsements' => 29,'invalid_license_restrictions' => 30,'invalid_license_trans_type' => 31,'invalid_permit_class' => 32,'invalid_permit_iss_code' => 33,'invalid_permit_endorse_codes' => 34,'invalid_permit_restric_codes' => 35,'invalid_permit_trans_type' => 36,'invalid_non_driver_code' => 37,'invalid_non_driver_trans_type' => 38,'invalid_action_counts' => 39,'invalid_driv_priv_counts' => 40,'invalid_conv_counts' => 41,'invalid_accidents_counts' => 42,'invalid_aka_counts' => 43,'invalid_fname' => 44,'invalid_mname' => 45,'invalid_lname' => 46,'invalid_direction' => 47,'invalid_cart' => 48,'invalid_cr_sort_sz' => 49,'invalid_lot' => 50,'invalid_lot_order' => 51,'invalid_dpbc' => 52,'invalid_chk_digit' => 53,'invalid_fips_state' => 54,'invalid_fips_county' => 55,'invalid_geo' => 56,'invalid_msa' => 57,'invalid_geo_match' => 58,'invalid_err_stat' => 59,0);
 
EXPORT MakeFT_invalid_Past_Date(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_Past_Date(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_valid_past_date(s)>0);
EXPORT InValidMessageFT_invalid_Past_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_valid_past_date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_general_Date(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_general_Date(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_valid_general_Date(s)>0);
EXPORT InValidMessageFT_invalid_general_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_valid_general_Date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_Alpha_Numeric(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_Alpha_Numeric(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_alphanumeric(s)>0);
EXPORT InValidMessageFT_invalid_Alpha_Numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_alphanumeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_Hyphen_Alpha_Numeric(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_Hyphen_Alpha_Numeric(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_invalid_Hyphen_Alpha_Numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_chk_blanks(s)>0);
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_chk_blanks'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_Num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_Num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_first_name(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_first_name(SALT38.StrType s,SALT38.StrType middle_name,SALT38.StrType last_name) := WHICH(~Scrubs_DL_MO_MEDCERT.functions.fn_chk_people_names(s,middle_name,last_name)>0);
EXPORT InValidMessageFT_invalid_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.functions.fn_chk_people_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mid_name(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mid_name(SALT38.StrType s,SALT38.StrType first_name,SALT38.StrType last_name) := WHICH(~Scrubs_DL_MO_MEDCERT.functions.fn_chk_people_names(s,first_name,last_name)>0);
EXPORT InValidMessageFT_invalid_mid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.functions.fn_chk_people_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_last_name(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_last_name(SALT38.StrType s,SALT38.StrType first_name,SALT38.StrType middle_name) := WHICH(~Scrubs_DL_MO_MEDCERT.functions.fn_chk_people_names(s,first_name,middle_name)>0);
EXPORT InValidMessageFT_invalid_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.functions.fn_chk_people_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'B|F|M|U|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_gender(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'B|F|M|U|'))));
EXPORT InValidMessageFT_invalid_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('B|F|M|U|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_title(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'MR|MS|SIR|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_title(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'MR|MS|SIR|'))));
EXPORT InValidMessageFT_invalid_title(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('MR|MS|SIR|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_verify_state'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_verify_zip5(s)>0);
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_verify_zip5'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip4(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_verify_zip4(s)>0);
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_verify_zip4'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mailing_zip(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mailing_zip(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_mailing_zip(s)>0);
EXPORT InValidMessageFT_invalid_mailing_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_mailing_zip'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_eye_color(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'1|2|3|4|5|6|7|8|9|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_eye_color(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'1|2|3|4|5|6|7|8|9|'))));
EXPORT InValidMessageFT_invalid_eye_color(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('1|2|3|4|5|6|7|8|9|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_operator_status(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'C|CS|D|E|LT|O|R|RR|S|V|VR|VX|W|WE|WV'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_operator_status(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'C|CS|D|E|LT|O|R|RR|S|V|VR|VX|W|WE|WV'))));
EXPORT InValidMessageFT_invalid_operator_status(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('C|CS|D|E|LT|O|R|RR|S|V|VR|VX|W|WE|WV'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_commercial_status(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'C|CC|CS|D|DO|DQ|DS|E|LT|NO|O|R|RC|RR|S|V|VX|WE|WV|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_commercial_status(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'C|CC|CS|D|DO|DQ|DS|E|LT|NO|O|R|RC|RR|S|V|VX|WE|WV|'))));
EXPORT InValidMessageFT_invalid_commercial_status(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('C|CC|CS|D|DO|DQ|DS|E|LT|NO|O|R|RC|RR|S|V|VX|WE|WV|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sch_bus_status(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'I|S|V|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_sch_bus_status(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'I|S|V|'))));
EXPORT InValidMessageFT_invalid_sch_bus_status(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('I|S|V|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pending_act_code(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'A|C|D|G|K|O|R|S|V|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_pending_act_code(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'A|C|D|G|K|O|R|S|V|'))));
EXPORT InValidMessageFT_invalid_pending_act_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('A|C|D|G|K|O|R|S|V|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_must_test_ind(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'A|C|O|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_must_test_ind(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'A|C|O|'))));
EXPORT InValidMessageFT_invalid_must_test_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('A|C|O|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_deceased_ind(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'N|Y|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_deceased_ind(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'N|Y|'))));
EXPORT InValidMessageFT_invalid_deceased_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('N|Y|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_prev_cdl_class(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'A|B|C|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_prev_cdl_class(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'A|B|C|'))));
EXPORT InValidMessageFT_invalid_prev_cdl_class(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('A|B|C|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cdl_ptr(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'N|Y|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_cdl_ptr(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'N|Y|'))));
EXPORT InValidMessageFT_invalid_cdl_ptr(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('N|Y|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pdps_ptr(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'N|Y|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_pdps_ptr(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'N|Y|'))));
EXPORT InValidMessageFT_invalid_pdps_ptr(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('N|Y|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mvr_privacy_code(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'P|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_mvr_privacy_code(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'P|'))));
EXPORT InValidMessageFT_invalid_mvr_privacy_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('P|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lic_iss_code(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'C|F|Y|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_lic_iss_code(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'C|F|Y|'))));
EXPORT InValidMessageFT_invalid_lic_iss_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('C|F|Y|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_class(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'A|B|C|E|F|M|N|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_license_class(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'A|B|C|E|F|M|N|'))));
EXPORT InValidMessageFT_invalid_license_class(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('A|B|C|E|F|M|N|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_endorsements(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'B|C|H|M|N|P|S|T|X|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_license_endorsements(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'B|C|H|M|N|P|S|T|X|'))));
EXPORT InValidMessageFT_invalid_license_endorsements(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('B|C|H|M|N|P|S|T|X|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_restrictions(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'#|A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|T|U|V|W|X|Y|Z|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_license_restrictions(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'#|A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|T|U|V|W|X|Y|Z|'))));
EXPORT InValidMessageFT_invalid_license_restrictions(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('#|A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|T|U|V|W|X|Y|Z|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_trans_type(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_license_trans_type(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.license_transType(s)>0);
EXPORT InValidMessageFT_invalid_license_trans_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.license_transType'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_permit_class(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'A|B|C|E|F|M|N|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_permit_class(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'A|B|C|E|F|M|N|'))));
EXPORT InValidMessageFT_invalid_permit_class(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('A|B|C|E|F|M|N|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_permit_iss_code(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'Y|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_permit_iss_code(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'Y|'))));
EXPORT InValidMessageFT_invalid_permit_iss_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('Y|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_permit_endorse_codes(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'M|MN|N|NSP|P|PN|PS|PSM|PSMN|PSN|SP|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_permit_endorse_codes(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'M|MN|N|NSP|P|PN|PS|PSM|PSMN|PSN|SP|'))));
EXPORT InValidMessageFT_invalid_permit_endorse_codes(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('M|MN|N|NSP|P|PN|PS|PSM|PSMN|PSN|SP|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_permit_restric_codes(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'-|A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|T|U|X|Y|Z'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_permit_restric_codes(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'-|A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|T|U|X|Y|Z'))));
EXPORT InValidMessageFT_invalid_permit_restric_codes(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('-|A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|T|U|X|Y|Z'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_permit_trans_type(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'40|42|50|60|70|85|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_permit_trans_type(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'40|42|50|60|70|85|'))));
EXPORT InValidMessageFT_invalid_permit_trans_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('40|42|50|60|70|85|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_non_driver_code(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'Y|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_non_driver_code(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'Y|'))));
EXPORT InValidMessageFT_invalid_non_driver_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('Y|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_non_driver_trans_type(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'01|30|40|41|42|50|51|52|60|62|85|D|DA|NA|RO|RW|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_non_driver_trans_type(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'01|30|40|41|42|50|51|52|60|62|85|D|DA|NA|RO|RW|'))));
EXPORT InValidMessageFT_invalid_non_driver_trans_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('01|30|40|41|42|50|51|52|60|62|85|D|DA|NA|RO|RW|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_action_counts(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_action_counts(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.action_counts(s)>0);
EXPORT InValidMessageFT_invalid_action_counts(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.action_counts'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_driv_priv_counts(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0|1|2|3|4|5|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_driv_priv_counts(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0|1|2|3|4|5|'))));
EXPORT InValidMessageFT_invalid_driv_priv_counts(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0|1|2|3|4|5|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_conv_counts(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_conv_counts(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.conv_counts(s)>0);
EXPORT InValidMessageFT_invalid_conv_counts(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.conv_counts'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_accidents_counts(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'1|2|3|4|5|6|7|8|9|10|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_accidents_counts(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'1|2|3|4|5|6|7|8|9|10|'))));
EXPORT InValidMessageFT_invalid_accidents_counts(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('1|2|3|4|5|6|7|8|9|10|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_aka_counts(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0|1|2|3|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_aka_counts(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0|1|2|3|'))));
EXPORT InValidMessageFT_invalid_aka_counts(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0|1|2|3|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fname(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fname(SALT38.StrType s,SALT38.StrType mname,SALT38.StrType lname) := WHICH(~Scrubs_DL_MO_MEDCERT.functions.fn_chk_people_names(s,mname,lname)>0);
EXPORT InValidMessageFT_invalid_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.functions.fn_chk_people_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mname(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mname(SALT38.StrType s,SALT38.StrType fname,SALT38.StrType lname) := WHICH(~Scrubs_DL_MO_MEDCERT.functions.fn_chk_people_names(s,fname,lname)>0);
EXPORT InValidMessageFT_invalid_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.functions.fn_chk_people_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lname(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lname(SALT38.StrType s,SALT38.StrType fname,SALT38.StrType mname) := WHICH(~Scrubs_DL_MO_MEDCERT.functions.fn_chk_people_names(s,fname,mname)>0);
EXPORT InValidMessageFT_invalid_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.functions.fn_chk_people_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_direction(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'E|N|S|W'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_direction(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'E|N|S|W'))));
EXPORT InValidMessageFT_invalid_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('E|N|S|W'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cart(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cart(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_alphanumeric(s,4)>0);
EXPORT InValidMessageFT_invalid_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_alphanumeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cr_sort_sz(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cr_sort_sz(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['B','C','D','']);
EXPORT InValidMessageFT_invalid_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('B|C|D|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot_order(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot_order(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['A','D','']);
EXPORT InValidMessageFT_invalid_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('A|D|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dpbc(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dpbc(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_dpbc(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_chk_digit(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_chk_digit(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_state(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_state(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_fips_state(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_county(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_county(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_numeric(s,3)>0);
EXPORT InValidMessageFT_invalid_fips_county(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_geo_coord(s)>0);
EXPORT InValidMessageFT_invalid_geo(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_geo_coord'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_msa(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_msa(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_match(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo_match(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_err_stat(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_err_stat(SALT38.StrType s) := WHICH(~Scrubs_DL_MO_MEDCERT.Functions.fn_alphanumeric(s,4)>0);
EXPORT InValidMessageFT_invalid_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_MO_MEDCERT.Functions.fn_alphanumeric'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','unique_key','license_number','last_name','first_name','middle_name','suffix','date_of_birth','gender','address','city','state','zip5','zip4','mailing_address1','mailing_address2','mailing_city','mailing_state','mailing_zip','height','eye_color','operator_status','commercial_status','sch_bus_status','pending_act_code','must_test_ind','deceased_ind','prev_cdl_class','cdl_ptr','pdps_ptr','mvr_privacy_code','brc_status_code','brc_status_date','lic_iss_code','license_class','lic_exp_date','lic_seq_number','lic_surrender_to','new_out_of_st_dl_num','license_endorsements','license_restrictions','license_trans_type','lic_print_date','permit_iss_code','permit_class','permit_exp_date','permit_seq_number','permit_endorse_codes','permit_restric_codes','permit_trans_type','permit_print_date','non_driver_code','non_driver_exp_date','non_driver_seq_num','non_driver_trans_type','non_driver_print_date','action_surrender_date','action_counts','driv_priv_counts','conv_counts','accidents_counts','aka_counts','title','fname','mname','lname','name_suffix','cleaning_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','cln_zip5','cln_zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','previous_dl_number','previous_st','old_dl_number');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'process_date','unique_key','license_number','last_name','first_name','middle_name','suffix','date_of_birth','gender','address','city','state','zip5','zip4','mailing_address1','mailing_address2','mailing_city','mailing_state','mailing_zip','height','eye_color','operator_status','commercial_status','sch_bus_status','pending_act_code','must_test_ind','deceased_ind','prev_cdl_class','cdl_ptr','pdps_ptr','mvr_privacy_code','brc_status_code','brc_status_date','lic_iss_code','license_class','lic_exp_date','lic_seq_number','lic_surrender_to','new_out_of_st_dl_num','license_endorsements','license_restrictions','license_trans_type','lic_print_date','permit_iss_code','permit_class','permit_exp_date','permit_seq_number','permit_endorse_codes','permit_restric_codes','permit_trans_type','permit_print_date','non_driver_code','non_driver_exp_date','non_driver_seq_num','non_driver_trans_type','non_driver_print_date','action_surrender_date','action_counts','driv_priv_counts','conv_counts','accidents_counts','aka_counts','title','fname','mname','lname','name_suffix','cleaning_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','cln_zip5','cln_zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','previous_dl_number','previous_st','old_dl_number');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'process_date' => 0,'unique_key' => 1,'license_number' => 2,'last_name' => 3,'first_name' => 4,'middle_name' => 5,'suffix' => 6,'date_of_birth' => 7,'gender' => 8,'address' => 9,'city' => 10,'state' => 11,'zip5' => 12,'zip4' => 13,'mailing_address1' => 14,'mailing_address2' => 15,'mailing_city' => 16,'mailing_state' => 17,'mailing_zip' => 18,'height' => 19,'eye_color' => 20,'operator_status' => 21,'commercial_status' => 22,'sch_bus_status' => 23,'pending_act_code' => 24,'must_test_ind' => 25,'deceased_ind' => 26,'prev_cdl_class' => 27,'cdl_ptr' => 28,'pdps_ptr' => 29,'mvr_privacy_code' => 30,'brc_status_code' => 31,'brc_status_date' => 32,'lic_iss_code' => 33,'license_class' => 34,'lic_exp_date' => 35,'lic_seq_number' => 36,'lic_surrender_to' => 37,'new_out_of_st_dl_num' => 38,'license_endorsements' => 39,'license_restrictions' => 40,'license_trans_type' => 41,'lic_print_date' => 42,'permit_iss_code' => 43,'permit_class' => 44,'permit_exp_date' => 45,'permit_seq_number' => 46,'permit_endorse_codes' => 47,'permit_restric_codes' => 48,'permit_trans_type' => 49,'permit_print_date' => 50,'non_driver_code' => 51,'non_driver_exp_date' => 52,'non_driver_seq_num' => 53,'non_driver_trans_type' => 54,'non_driver_print_date' => 55,'action_surrender_date' => 56,'action_counts' => 57,'driv_priv_counts' => 58,'conv_counts' => 59,'accidents_counts' => 60,'aka_counts' => 61,'title' => 62,'fname' => 63,'mname' => 64,'lname' => 65,'name_suffix' => 66,'cleaning_score' => 67,'prim_range' => 68,'predir' => 69,'prim_name' => 70,'addr_suffix' => 71,'postdir' => 72,'unit_desig' => 73,'sec_range' => 74,'p_city_name' => 75,'v_city_name' => 76,'st' => 77,'cln_zip5' => 78,'cln_zip4' => 79,'cart' => 80,'cr_sort_sz' => 81,'lot' => 82,'lot_order' => 83,'dpbc' => 84,'chk_digit' => 85,'rec_type' => 86,'ace_fips_st' => 87,'county' => 88,'geo_lat' => 89,'geo_long' => 90,'msa' => 91,'geo_blk' => 92,'geo_match' => 93,'err_stat' => 94,'previous_dl_number' => 95,'previous_st' => 96,'old_dl_number' => 97,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],[],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],['ALLOW'],['CUSTOM'],[],['ALLOW'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_process_date(SALT38.StrType s0) := MakeFT_invalid_Past_Date(s0);
EXPORT InValid_process_date(SALT38.StrType s) := InValidFT_invalid_Past_Date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_Past_Date(wh);
 
EXPORT Make_unique_key(SALT38.StrType s0) := MakeFT_invalid_Alpha_Numeric(s0);
EXPORT InValid_unique_key(SALT38.StrType s) := InValidFT_invalid_Alpha_Numeric(s);
EXPORT InValidMessage_unique_key(UNSIGNED1 wh) := InValidMessageFT_invalid_Alpha_Numeric(wh);
 
EXPORT Make_license_number(SALT38.StrType s0) := MakeFT_invalid_Alpha_Numeric(s0);
EXPORT InValid_license_number(SALT38.StrType s) := InValidFT_invalid_Alpha_Numeric(s);
EXPORT InValidMessage_license_number(UNSIGNED1 wh) := InValidMessageFT_invalid_Alpha_Numeric(wh);
 
EXPORT Make_last_name(SALT38.StrType s0) := MakeFT_invalid_last_name(s0);
EXPORT InValid_last_name(SALT38.StrType s,SALT38.StrType first_name,SALT38.StrType middle_name) := InValidFT_invalid_last_name(s,first_name,middle_name);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_last_name(wh);
 
EXPORT Make_first_name(SALT38.StrType s0) := MakeFT_invalid_first_name(s0);
EXPORT InValid_first_name(SALT38.StrType s,SALT38.StrType middle_name,SALT38.StrType last_name) := InValidFT_invalid_first_name(s,middle_name,last_name);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_first_name(wh);
 
EXPORT Make_middle_name(SALT38.StrType s0) := MakeFT_invalid_mid_name(s0);
EXPORT InValid_middle_name(SALT38.StrType s,SALT38.StrType first_name,SALT38.StrType last_name) := InValidFT_invalid_mid_name(s,first_name,last_name);
EXPORT InValidMessage_middle_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mid_name(wh);
 
EXPORT Make_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_date_of_birth(SALT38.StrType s0) := MakeFT_invalid_Past_Date(s0);
EXPORT InValid_date_of_birth(SALT38.StrType s) := InValidFT_invalid_Past_Date(s);
EXPORT InValidMessage_date_of_birth(UNSIGNED1 wh) := InValidMessageFT_invalid_Past_Date(wh);
 
EXPORT Make_gender(SALT38.StrType s0) := MakeFT_invalid_gender(s0);
EXPORT InValid_gender(SALT38.StrType s) := InValidFT_invalid_gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender(wh);
 
EXPORT Make_address(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_address(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_address(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_city(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_city(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_state(SALT38.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT38.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip5(SALT38.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip5(SALT38.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_zip4(SALT38.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_zip4(SALT38.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_mailing_address1(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_mailing_address1(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_mailing_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_mailing_address2(SALT38.StrType s0) := s0;
EXPORT InValid_mailing_address2(SALT38.StrType s) := 0;
EXPORT InValidMessage_mailing_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_mailing_city(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_mailing_city(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_mailing_city(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_mailing_state(SALT38.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_mailing_state(SALT38.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_mailing_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_mailing_zip(SALT38.StrType s0) := MakeFT_invalid_mailing_zip(s0);
EXPORT InValid_mailing_zip(SALT38.StrType s) := InValidFT_invalid_mailing_zip(s);
EXPORT InValidMessage_mailing_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_mailing_zip(wh);
 
EXPORT Make_height(SALT38.StrType s0) := MakeFT_invalid_Num(s0);
EXPORT InValid_height(SALT38.StrType s) := InValidFT_invalid_Num(s);
EXPORT InValidMessage_height(UNSIGNED1 wh) := InValidMessageFT_invalid_Num(wh);
 
EXPORT Make_eye_color(SALT38.StrType s0) := MakeFT_invalid_eye_color(s0);
EXPORT InValid_eye_color(SALT38.StrType s) := InValidFT_invalid_eye_color(s);
EXPORT InValidMessage_eye_color(UNSIGNED1 wh) := InValidMessageFT_invalid_eye_color(wh);
 
EXPORT Make_operator_status(SALT38.StrType s0) := MakeFT_invalid_operator_status(s0);
EXPORT InValid_operator_status(SALT38.StrType s) := InValidFT_invalid_operator_status(s);
EXPORT InValidMessage_operator_status(UNSIGNED1 wh) := InValidMessageFT_invalid_operator_status(wh);
 
EXPORT Make_commercial_status(SALT38.StrType s0) := MakeFT_invalid_commercial_status(s0);
EXPORT InValid_commercial_status(SALT38.StrType s) := InValidFT_invalid_commercial_status(s);
EXPORT InValidMessage_commercial_status(UNSIGNED1 wh) := InValidMessageFT_invalid_commercial_status(wh);
 
EXPORT Make_sch_bus_status(SALT38.StrType s0) := MakeFT_invalid_sch_bus_status(s0);
EXPORT InValid_sch_bus_status(SALT38.StrType s) := InValidFT_invalid_sch_bus_status(s);
EXPORT InValidMessage_sch_bus_status(UNSIGNED1 wh) := InValidMessageFT_invalid_sch_bus_status(wh);
 
EXPORT Make_pending_act_code(SALT38.StrType s0) := MakeFT_invalid_pending_act_code(s0);
EXPORT InValid_pending_act_code(SALT38.StrType s) := InValidFT_invalid_pending_act_code(s);
EXPORT InValidMessage_pending_act_code(UNSIGNED1 wh) := InValidMessageFT_invalid_pending_act_code(wh);
 
EXPORT Make_must_test_ind(SALT38.StrType s0) := MakeFT_invalid_must_test_ind(s0);
EXPORT InValid_must_test_ind(SALT38.StrType s) := InValidFT_invalid_must_test_ind(s);
EXPORT InValidMessage_must_test_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_must_test_ind(wh);
 
EXPORT Make_deceased_ind(SALT38.StrType s0) := MakeFT_invalid_deceased_ind(s0);
EXPORT InValid_deceased_ind(SALT38.StrType s) := InValidFT_invalid_deceased_ind(s);
EXPORT InValidMessage_deceased_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_deceased_ind(wh);
 
EXPORT Make_prev_cdl_class(SALT38.StrType s0) := MakeFT_invalid_prev_cdl_class(s0);
EXPORT InValid_prev_cdl_class(SALT38.StrType s) := InValidFT_invalid_prev_cdl_class(s);
EXPORT InValidMessage_prev_cdl_class(UNSIGNED1 wh) := InValidMessageFT_invalid_prev_cdl_class(wh);
 
EXPORT Make_cdl_ptr(SALT38.StrType s0) := MakeFT_invalid_cdl_ptr(s0);
EXPORT InValid_cdl_ptr(SALT38.StrType s) := InValidFT_invalid_cdl_ptr(s);
EXPORT InValidMessage_cdl_ptr(UNSIGNED1 wh) := InValidMessageFT_invalid_cdl_ptr(wh);
 
EXPORT Make_pdps_ptr(SALT38.StrType s0) := MakeFT_invalid_pdps_ptr(s0);
EXPORT InValid_pdps_ptr(SALT38.StrType s) := InValidFT_invalid_pdps_ptr(s);
EXPORT InValidMessage_pdps_ptr(UNSIGNED1 wh) := InValidMessageFT_invalid_pdps_ptr(wh);
 
EXPORT Make_mvr_privacy_code(SALT38.StrType s0) := MakeFT_invalid_mvr_privacy_code(s0);
EXPORT InValid_mvr_privacy_code(SALT38.StrType s) := InValidFT_invalid_mvr_privacy_code(s);
EXPORT InValidMessage_mvr_privacy_code(UNSIGNED1 wh) := InValidMessageFT_invalid_mvr_privacy_code(wh);
 
EXPORT Make_brc_status_code(SALT38.StrType s0) := s0;
EXPORT InValid_brc_status_code(SALT38.StrType s) := 0;
EXPORT InValidMessage_brc_status_code(UNSIGNED1 wh) := '';
 
EXPORT Make_brc_status_date(SALT38.StrType s0) := MakeFT_invalid_Past_Date(s0);
EXPORT InValid_brc_status_date(SALT38.StrType s) := InValidFT_invalid_Past_Date(s);
EXPORT InValidMessage_brc_status_date(UNSIGNED1 wh) := InValidMessageFT_invalid_Past_Date(wh);
 
EXPORT Make_lic_iss_code(SALT38.StrType s0) := MakeFT_invalid_lic_iss_code(s0);
EXPORT InValid_lic_iss_code(SALT38.StrType s) := InValidFT_invalid_lic_iss_code(s);
EXPORT InValidMessage_lic_iss_code(UNSIGNED1 wh) := InValidMessageFT_invalid_lic_iss_code(wh);
 
EXPORT Make_license_class(SALT38.StrType s0) := MakeFT_invalid_license_class(s0);
EXPORT InValid_license_class(SALT38.StrType s) := InValidFT_invalid_license_class(s);
EXPORT InValidMessage_license_class(UNSIGNED1 wh) := InValidMessageFT_invalid_license_class(wh);
 
EXPORT Make_lic_exp_date(SALT38.StrType s0) := MakeFT_invalid_general_Date(s0);
EXPORT InValid_lic_exp_date(SALT38.StrType s) := InValidFT_invalid_general_Date(s);
EXPORT InValidMessage_lic_exp_date(UNSIGNED1 wh) := InValidMessageFT_invalid_general_Date(wh);
 
EXPORT Make_lic_seq_number(SALT38.StrType s0) := MakeFT_invalid_Num(s0);
EXPORT InValid_lic_seq_number(SALT38.StrType s) := InValidFT_invalid_Num(s);
EXPORT InValidMessage_lic_seq_number(UNSIGNED1 wh) := InValidMessageFT_invalid_Num(wh);
 
EXPORT Make_lic_surrender_to(SALT38.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_lic_surrender_to(SALT38.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_lic_surrender_to(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_new_out_of_st_dl_num(SALT38.StrType s0) := s0;
EXPORT InValid_new_out_of_st_dl_num(SALT38.StrType s) := 0;
EXPORT InValidMessage_new_out_of_st_dl_num(UNSIGNED1 wh) := '';
 
EXPORT Make_license_endorsements(SALT38.StrType s0) := MakeFT_invalid_license_endorsements(s0);
EXPORT InValid_license_endorsements(SALT38.StrType s) := InValidFT_invalid_license_endorsements(s);
EXPORT InValidMessage_license_endorsements(UNSIGNED1 wh) := InValidMessageFT_invalid_license_endorsements(wh);
 
EXPORT Make_license_restrictions(SALT38.StrType s0) := MakeFT_invalid_license_restrictions(s0);
EXPORT InValid_license_restrictions(SALT38.StrType s) := InValidFT_invalid_license_restrictions(s);
EXPORT InValidMessage_license_restrictions(UNSIGNED1 wh) := InValidMessageFT_invalid_license_restrictions(wh);
 
EXPORT Make_license_trans_type(SALT38.StrType s0) := MakeFT_invalid_license_trans_type(s0);
EXPORT InValid_license_trans_type(SALT38.StrType s) := InValidFT_invalid_license_trans_type(s);
EXPORT InValidMessage_license_trans_type(UNSIGNED1 wh) := InValidMessageFT_invalid_license_trans_type(wh);
 
EXPORT Make_lic_print_date(SALT38.StrType s0) := MakeFT_invalid_general_Date(s0);
EXPORT InValid_lic_print_date(SALT38.StrType s) := InValidFT_invalid_general_Date(s);
EXPORT InValidMessage_lic_print_date(UNSIGNED1 wh) := InValidMessageFT_invalid_general_Date(wh);
 
EXPORT Make_permit_iss_code(SALT38.StrType s0) := MakeFT_invalid_permit_iss_code(s0);
EXPORT InValid_permit_iss_code(SALT38.StrType s) := InValidFT_invalid_permit_iss_code(s);
EXPORT InValidMessage_permit_iss_code(UNSIGNED1 wh) := InValidMessageFT_invalid_permit_iss_code(wh);
 
EXPORT Make_permit_class(SALT38.StrType s0) := MakeFT_invalid_permit_class(s0);
EXPORT InValid_permit_class(SALT38.StrType s) := InValidFT_invalid_permit_class(s);
EXPORT InValidMessage_permit_class(UNSIGNED1 wh) := InValidMessageFT_invalid_permit_class(wh);
 
EXPORT Make_permit_exp_date(SALT38.StrType s0) := MakeFT_invalid_general_Date(s0);
EXPORT InValid_permit_exp_date(SALT38.StrType s) := InValidFT_invalid_general_Date(s);
EXPORT InValidMessage_permit_exp_date(UNSIGNED1 wh) := InValidMessageFT_invalid_general_Date(wh);
 
EXPORT Make_permit_seq_number(SALT38.StrType s0) := MakeFT_invalid_Num(s0);
EXPORT InValid_permit_seq_number(SALT38.StrType s) := InValidFT_invalid_Num(s);
EXPORT InValidMessage_permit_seq_number(UNSIGNED1 wh) := InValidMessageFT_invalid_Num(wh);
 
EXPORT Make_permit_endorse_codes(SALT38.StrType s0) := MakeFT_invalid_permit_endorse_codes(s0);
EXPORT InValid_permit_endorse_codes(SALT38.StrType s) := InValidFT_invalid_permit_endorse_codes(s);
EXPORT InValidMessage_permit_endorse_codes(UNSIGNED1 wh) := InValidMessageFT_invalid_permit_endorse_codes(wh);
 
EXPORT Make_permit_restric_codes(SALT38.StrType s0) := MakeFT_invalid_permit_restric_codes(s0);
EXPORT InValid_permit_restric_codes(SALT38.StrType s) := InValidFT_invalid_permit_restric_codes(s);
EXPORT InValidMessage_permit_restric_codes(UNSIGNED1 wh) := InValidMessageFT_invalid_permit_restric_codes(wh);
 
EXPORT Make_permit_trans_type(SALT38.StrType s0) := MakeFT_invalid_permit_trans_type(s0);
EXPORT InValid_permit_trans_type(SALT38.StrType s) := InValidFT_invalid_permit_trans_type(s);
EXPORT InValidMessage_permit_trans_type(UNSIGNED1 wh) := InValidMessageFT_invalid_permit_trans_type(wh);
 
EXPORT Make_permit_print_date(SALT38.StrType s0) := MakeFT_invalid_Past_Date(s0);
EXPORT InValid_permit_print_date(SALT38.StrType s) := InValidFT_invalid_Past_Date(s);
EXPORT InValidMessage_permit_print_date(UNSIGNED1 wh) := InValidMessageFT_invalid_Past_Date(wh);
 
EXPORT Make_non_driver_code(SALT38.StrType s0) := MakeFT_invalid_non_driver_code(s0);
EXPORT InValid_non_driver_code(SALT38.StrType s) := InValidFT_invalid_non_driver_code(s);
EXPORT InValidMessage_non_driver_code(UNSIGNED1 wh) := InValidMessageFT_invalid_non_driver_code(wh);
 
EXPORT Make_non_driver_exp_date(SALT38.StrType s0) := MakeFT_invalid_general_Date(s0);
EXPORT InValid_non_driver_exp_date(SALT38.StrType s) := InValidFT_invalid_general_Date(s);
EXPORT InValidMessage_non_driver_exp_date(UNSIGNED1 wh) := InValidMessageFT_invalid_general_Date(wh);
 
EXPORT Make_non_driver_seq_num(SALT38.StrType s0) := MakeFT_invalid_Num(s0);
EXPORT InValid_non_driver_seq_num(SALT38.StrType s) := InValidFT_invalid_Num(s);
EXPORT InValidMessage_non_driver_seq_num(UNSIGNED1 wh) := InValidMessageFT_invalid_Num(wh);
 
EXPORT Make_non_driver_trans_type(SALT38.StrType s0) := MakeFT_invalid_non_driver_trans_type(s0);
EXPORT InValid_non_driver_trans_type(SALT38.StrType s) := InValidFT_invalid_non_driver_trans_type(s);
EXPORT InValidMessage_non_driver_trans_type(UNSIGNED1 wh) := InValidMessageFT_invalid_non_driver_trans_type(wh);
 
EXPORT Make_non_driver_print_date(SALT38.StrType s0) := MakeFT_invalid_general_Date(s0);
EXPORT InValid_non_driver_print_date(SALT38.StrType s) := InValidFT_invalid_general_Date(s);
EXPORT InValidMessage_non_driver_print_date(UNSIGNED1 wh) := InValidMessageFT_invalid_general_Date(wh);
 
EXPORT Make_action_surrender_date(SALT38.StrType s0) := MakeFT_invalid_Past_Date(s0);
EXPORT InValid_action_surrender_date(SALT38.StrType s) := InValidFT_invalid_Past_Date(s);
EXPORT InValidMessage_action_surrender_date(UNSIGNED1 wh) := InValidMessageFT_invalid_Past_Date(wh);
 
EXPORT Make_action_counts(SALT38.StrType s0) := MakeFT_invalid_action_counts(s0);
EXPORT InValid_action_counts(SALT38.StrType s) := InValidFT_invalid_action_counts(s);
EXPORT InValidMessage_action_counts(UNSIGNED1 wh) := InValidMessageFT_invalid_action_counts(wh);
 
EXPORT Make_driv_priv_counts(SALT38.StrType s0) := MakeFT_invalid_driv_priv_counts(s0);
EXPORT InValid_driv_priv_counts(SALT38.StrType s) := InValidFT_invalid_driv_priv_counts(s);
EXPORT InValidMessage_driv_priv_counts(UNSIGNED1 wh) := InValidMessageFT_invalid_driv_priv_counts(wh);
 
EXPORT Make_conv_counts(SALT38.StrType s0) := MakeFT_invalid_conv_counts(s0);
EXPORT InValid_conv_counts(SALT38.StrType s) := InValidFT_invalid_conv_counts(s);
EXPORT InValidMessage_conv_counts(UNSIGNED1 wh) := InValidMessageFT_invalid_conv_counts(wh);
 
EXPORT Make_accidents_counts(SALT38.StrType s0) := MakeFT_invalid_accidents_counts(s0);
EXPORT InValid_accidents_counts(SALT38.StrType s) := InValidFT_invalid_accidents_counts(s);
EXPORT InValidMessage_accidents_counts(UNSIGNED1 wh) := InValidMessageFT_invalid_accidents_counts(wh);
 
EXPORT Make_aka_counts(SALT38.StrType s0) := MakeFT_invalid_aka_counts(s0);
EXPORT InValid_aka_counts(SALT38.StrType s) := InValidFT_invalid_aka_counts(s);
EXPORT InValidMessage_aka_counts(UNSIGNED1 wh) := InValidMessageFT_invalid_aka_counts(wh);
 
EXPORT Make_title(SALT38.StrType s0) := MakeFT_invalid_title(s0);
EXPORT InValid_title(SALT38.StrType s) := InValidFT_invalid_title(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_invalid_title(wh);
 
EXPORT Make_fname(SALT38.StrType s0) := MakeFT_invalid_fname(s0);
EXPORT InValid_fname(SALT38.StrType s,SALT38.StrType mname,SALT38.StrType lname) := InValidFT_invalid_fname(s,mname,lname);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_fname(wh);
 
EXPORT Make_mname(SALT38.StrType s0) := MakeFT_invalid_mname(s0);
EXPORT InValid_mname(SALT38.StrType s,SALT38.StrType fname,SALT38.StrType lname) := InValidFT_invalid_mname(s,fname,lname);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_mname(wh);
 
EXPORT Make_lname(SALT38.StrType s0) := MakeFT_invalid_lname(s0);
EXPORT InValid_lname(SALT38.StrType s,SALT38.StrType fname,SALT38.StrType mname) := InValidFT_invalid_lname(s,fname,mname);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_lname(wh);
 
EXPORT Make_name_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_cleaning_score(SALT38.StrType s0) := s0;
EXPORT InValid_cleaning_score(SALT38.StrType s) := 0;
EXPORT InValidMessage_cleaning_score(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT38.StrType s0) := s0;
EXPORT InValid_prim_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT38.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_predir(SALT38.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_prim_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prim_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_addr_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT38.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_postdir(SALT38.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_unit_desig(SALT38.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT38.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT38.StrType s0) := s0;
EXPORT InValid_sec_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_p_city_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_v_city_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_v_city_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_st(SALT38.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_st(SALT38.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_cln_zip5(SALT38.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_cln_zip5(SALT38.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_cln_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_cln_zip4(SALT38.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_cln_zip4(SALT38.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_cln_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_cart(SALT38.StrType s0) := MakeFT_invalid_cart(s0);
EXPORT InValid_cart(SALT38.StrType s) := InValidFT_invalid_cart(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_invalid_cart(wh);
 
EXPORT Make_cr_sort_sz(SALT38.StrType s0) := MakeFT_invalid_cr_sort_sz(s0);
EXPORT InValid_cr_sort_sz(SALT38.StrType s) := InValidFT_invalid_cr_sort_sz(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_invalid_cr_sort_sz(wh);
 
EXPORT Make_lot(SALT38.StrType s0) := MakeFT_invalid_lot(s0);
EXPORT InValid_lot(SALT38.StrType s) := InValidFT_invalid_lot(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_invalid_lot(wh);
 
EXPORT Make_lot_order(SALT38.StrType s0) := MakeFT_invalid_lot_order(s0);
EXPORT InValid_lot_order(SALT38.StrType s) := InValidFT_invalid_lot_order(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_invalid_lot_order(wh);
 
EXPORT Make_dpbc(SALT38.StrType s0) := MakeFT_invalid_dpbc(s0);
EXPORT InValid_dpbc(SALT38.StrType s) := InValidFT_invalid_dpbc(s);
EXPORT InValidMessage_dpbc(UNSIGNED1 wh) := InValidMessageFT_invalid_dpbc(wh);
 
EXPORT Make_chk_digit(SALT38.StrType s0) := MakeFT_invalid_chk_digit(s0);
EXPORT InValid_chk_digit(SALT38.StrType s) := InValidFT_invalid_chk_digit(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_invalid_chk_digit(wh);
 
EXPORT Make_rec_type(SALT38.StrType s0) := s0;
EXPORT InValid_rec_type(SALT38.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_st(SALT38.StrType s0) := MakeFT_invalid_fips_state(s0);
EXPORT InValid_ace_fips_st(SALT38.StrType s) := InValidFT_invalid_fips_state(s);
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_invalid_fips_state(wh);
 
EXPORT Make_county(SALT38.StrType s0) := MakeFT_invalid_fips_county(s0);
EXPORT InValid_county(SALT38.StrType s) := InValidFT_invalid_fips_county(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_invalid_fips_county(wh);
 
EXPORT Make_geo_lat(SALT38.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_geo_lat(SALT38.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_geo_long(SALT38.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_geo_long(SALT38.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_msa(SALT38.StrType s0) := MakeFT_invalid_msa(s0);
EXPORT InValid_msa(SALT38.StrType s) := InValidFT_invalid_msa(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_invalid_msa(wh);
 
EXPORT Make_geo_blk(SALT38.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT38.StrType s0) := MakeFT_invalid_geo_match(s0);
EXPORT InValid_geo_match(SALT38.StrType s) := InValidFT_invalid_geo_match(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_match(wh);
 
EXPORT Make_err_stat(SALT38.StrType s0) := MakeFT_invalid_err_stat(s0);
EXPORT InValid_err_stat(SALT38.StrType s) := InValidFT_invalid_err_stat(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_invalid_err_stat(wh);
 
EXPORT Make_previous_dl_number(SALT38.StrType s0) := MakeFT_invalid_Hyphen_Alpha_Numeric(s0);
EXPORT InValid_previous_dl_number(SALT38.StrType s) := InValidFT_invalid_Hyphen_Alpha_Numeric(s);
EXPORT InValidMessage_previous_dl_number(UNSIGNED1 wh) := InValidMessageFT_invalid_Hyphen_Alpha_Numeric(wh);
 
EXPORT Make_previous_st(SALT38.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_previous_st(SALT38.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_previous_st(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_old_dl_number(SALT38.StrType s0) := MakeFT_invalid_Alpha_Numeric(s0);
EXPORT InValid_old_dl_number(SALT38.StrType s) := InValidFT_invalid_Alpha_Numeric(s);
EXPORT InValidMessage_old_dl_number(UNSIGNED1 wh) := InValidMessageFT_invalid_Alpha_Numeric(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_DL_MO_MEDCERT;
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
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_unique_key;
    BOOLEAN Diff_license_number;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_middle_name;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_date_of_birth;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_address;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip5;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_mailing_address1;
    BOOLEAN Diff_mailing_address2;
    BOOLEAN Diff_mailing_city;
    BOOLEAN Diff_mailing_state;
    BOOLEAN Diff_mailing_zip;
    BOOLEAN Diff_height;
    BOOLEAN Diff_eye_color;
    BOOLEAN Diff_operator_status;
    BOOLEAN Diff_commercial_status;
    BOOLEAN Diff_sch_bus_status;
    BOOLEAN Diff_pending_act_code;
    BOOLEAN Diff_must_test_ind;
    BOOLEAN Diff_deceased_ind;
    BOOLEAN Diff_prev_cdl_class;
    BOOLEAN Diff_cdl_ptr;
    BOOLEAN Diff_pdps_ptr;
    BOOLEAN Diff_mvr_privacy_code;
    BOOLEAN Diff_brc_status_code;
    BOOLEAN Diff_brc_status_date;
    BOOLEAN Diff_lic_iss_code;
    BOOLEAN Diff_license_class;
    BOOLEAN Diff_lic_exp_date;
    BOOLEAN Diff_lic_seq_number;
    BOOLEAN Diff_lic_surrender_to;
    BOOLEAN Diff_new_out_of_st_dl_num;
    BOOLEAN Diff_license_endorsements;
    BOOLEAN Diff_license_restrictions;
    BOOLEAN Diff_license_trans_type;
    BOOLEAN Diff_lic_print_date;
    BOOLEAN Diff_permit_iss_code;
    BOOLEAN Diff_permit_class;
    BOOLEAN Diff_permit_exp_date;
    BOOLEAN Diff_permit_seq_number;
    BOOLEAN Diff_permit_endorse_codes;
    BOOLEAN Diff_permit_restric_codes;
    BOOLEAN Diff_permit_trans_type;
    BOOLEAN Diff_permit_print_date;
    BOOLEAN Diff_non_driver_code;
    BOOLEAN Diff_non_driver_exp_date;
    BOOLEAN Diff_non_driver_seq_num;
    BOOLEAN Diff_non_driver_trans_type;
    BOOLEAN Diff_non_driver_print_date;
    BOOLEAN Diff_action_surrender_date;
    BOOLEAN Diff_action_counts;
    BOOLEAN Diff_driv_priv_counts;
    BOOLEAN Diff_conv_counts;
    BOOLEAN Diff_accidents_counts;
    BOOLEAN Diff_aka_counts;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_cleaning_score;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_cln_zip5;
    BOOLEAN Diff_cln_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_previous_dl_number;
    BOOLEAN Diff_previous_st;
    BOOLEAN Diff_old_dl_number;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_unique_key := le.unique_key <> ri.unique_key;
    SELF.Diff_license_number := le.license_number <> ri.license_number;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_middle_name := le.middle_name <> ri.middle_name;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_date_of_birth := le.date_of_birth <> ri.date_of_birth;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_address := le.address <> ri.address;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip5 := le.zip5 <> ri.zip5;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_mailing_address1 := le.mailing_address1 <> ri.mailing_address1;
    SELF.Diff_mailing_address2 := le.mailing_address2 <> ri.mailing_address2;
    SELF.Diff_mailing_city := le.mailing_city <> ri.mailing_city;
    SELF.Diff_mailing_state := le.mailing_state <> ri.mailing_state;
    SELF.Diff_mailing_zip := le.mailing_zip <> ri.mailing_zip;
    SELF.Diff_height := le.height <> ri.height;
    SELF.Diff_eye_color := le.eye_color <> ri.eye_color;
    SELF.Diff_operator_status := le.operator_status <> ri.operator_status;
    SELF.Diff_commercial_status := le.commercial_status <> ri.commercial_status;
    SELF.Diff_sch_bus_status := le.sch_bus_status <> ri.sch_bus_status;
    SELF.Diff_pending_act_code := le.pending_act_code <> ri.pending_act_code;
    SELF.Diff_must_test_ind := le.must_test_ind <> ri.must_test_ind;
    SELF.Diff_deceased_ind := le.deceased_ind <> ri.deceased_ind;
    SELF.Diff_prev_cdl_class := le.prev_cdl_class <> ri.prev_cdl_class;
    SELF.Diff_cdl_ptr := le.cdl_ptr <> ri.cdl_ptr;
    SELF.Diff_pdps_ptr := le.pdps_ptr <> ri.pdps_ptr;
    SELF.Diff_mvr_privacy_code := le.mvr_privacy_code <> ri.mvr_privacy_code;
    SELF.Diff_brc_status_code := le.brc_status_code <> ri.brc_status_code;
    SELF.Diff_brc_status_date := le.brc_status_date <> ri.brc_status_date;
    SELF.Diff_lic_iss_code := le.lic_iss_code <> ri.lic_iss_code;
    SELF.Diff_license_class := le.license_class <> ri.license_class;
    SELF.Diff_lic_exp_date := le.lic_exp_date <> ri.lic_exp_date;
    SELF.Diff_lic_seq_number := le.lic_seq_number <> ri.lic_seq_number;
    SELF.Diff_lic_surrender_to := le.lic_surrender_to <> ri.lic_surrender_to;
    SELF.Diff_new_out_of_st_dl_num := le.new_out_of_st_dl_num <> ri.new_out_of_st_dl_num;
    SELF.Diff_license_endorsements := le.license_endorsements <> ri.license_endorsements;
    SELF.Diff_license_restrictions := le.license_restrictions <> ri.license_restrictions;
    SELF.Diff_license_trans_type := le.license_trans_type <> ri.license_trans_type;
    SELF.Diff_lic_print_date := le.lic_print_date <> ri.lic_print_date;
    SELF.Diff_permit_iss_code := le.permit_iss_code <> ri.permit_iss_code;
    SELF.Diff_permit_class := le.permit_class <> ri.permit_class;
    SELF.Diff_permit_exp_date := le.permit_exp_date <> ri.permit_exp_date;
    SELF.Diff_permit_seq_number := le.permit_seq_number <> ri.permit_seq_number;
    SELF.Diff_permit_endorse_codes := le.permit_endorse_codes <> ri.permit_endorse_codes;
    SELF.Diff_permit_restric_codes := le.permit_restric_codes <> ri.permit_restric_codes;
    SELF.Diff_permit_trans_type := le.permit_trans_type <> ri.permit_trans_type;
    SELF.Diff_permit_print_date := le.permit_print_date <> ri.permit_print_date;
    SELF.Diff_non_driver_code := le.non_driver_code <> ri.non_driver_code;
    SELF.Diff_non_driver_exp_date := le.non_driver_exp_date <> ri.non_driver_exp_date;
    SELF.Diff_non_driver_seq_num := le.non_driver_seq_num <> ri.non_driver_seq_num;
    SELF.Diff_non_driver_trans_type := le.non_driver_trans_type <> ri.non_driver_trans_type;
    SELF.Diff_non_driver_print_date := le.non_driver_print_date <> ri.non_driver_print_date;
    SELF.Diff_action_surrender_date := le.action_surrender_date <> ri.action_surrender_date;
    SELF.Diff_action_counts := le.action_counts <> ri.action_counts;
    SELF.Diff_driv_priv_counts := le.driv_priv_counts <> ri.driv_priv_counts;
    SELF.Diff_conv_counts := le.conv_counts <> ri.conv_counts;
    SELF.Diff_accidents_counts := le.accidents_counts <> ri.accidents_counts;
    SELF.Diff_aka_counts := le.aka_counts <> ri.aka_counts;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_cleaning_score := le.cleaning_score <> ri.cleaning_score;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_cln_zip5 := le.cln_zip5 <> ri.cln_zip5;
    SELF.Diff_cln_zip4 := le.cln_zip4 <> ri.cln_zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_previous_dl_number := le.previous_dl_number <> ri.previous_dl_number;
    SELF.Diff_previous_st := le.previous_st <> ri.previous_st;
    SELF.Diff_old_dl_number := le.old_dl_number <> ri.old_dl_number;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_unique_key,1,0)+ IF( SELF.Diff_license_number,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_middle_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_date_of_birth,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_address,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip5,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_mailing_address1,1,0)+ IF( SELF.Diff_mailing_address2,1,0)+ IF( SELF.Diff_mailing_city,1,0)+ IF( SELF.Diff_mailing_state,1,0)+ IF( SELF.Diff_mailing_zip,1,0)+ IF( SELF.Diff_height,1,0)+ IF( SELF.Diff_eye_color,1,0)+ IF( SELF.Diff_operator_status,1,0)+ IF( SELF.Diff_commercial_status,1,0)+ IF( SELF.Diff_sch_bus_status,1,0)+ IF( SELF.Diff_pending_act_code,1,0)+ IF( SELF.Diff_must_test_ind,1,0)+ IF( SELF.Diff_deceased_ind,1,0)+ IF( SELF.Diff_prev_cdl_class,1,0)+ IF( SELF.Diff_cdl_ptr,1,0)+ IF( SELF.Diff_pdps_ptr,1,0)+ IF( SELF.Diff_mvr_privacy_code,1,0)+ IF( SELF.Diff_brc_status_code,1,0)+ IF( SELF.Diff_brc_status_date,1,0)+ IF( SELF.Diff_lic_iss_code,1,0)+ IF( SELF.Diff_license_class,1,0)+ IF( SELF.Diff_lic_exp_date,1,0)+ IF( SELF.Diff_lic_seq_number,1,0)+ IF( SELF.Diff_lic_surrender_to,1,0)+ IF( SELF.Diff_new_out_of_st_dl_num,1,0)+ IF( SELF.Diff_license_endorsements,1,0)+ IF( SELF.Diff_license_restrictions,1,0)+ IF( SELF.Diff_license_trans_type,1,0)+ IF( SELF.Diff_lic_print_date,1,0)+ IF( SELF.Diff_permit_iss_code,1,0)+ IF( SELF.Diff_permit_class,1,0)+ IF( SELF.Diff_permit_exp_date,1,0)+ IF( SELF.Diff_permit_seq_number,1,0)+ IF( SELF.Diff_permit_endorse_codes,1,0)+ IF( SELF.Diff_permit_restric_codes,1,0)+ IF( SELF.Diff_permit_trans_type,1,0)+ IF( SELF.Diff_permit_print_date,1,0)+ IF( SELF.Diff_non_driver_code,1,0)+ IF( SELF.Diff_non_driver_exp_date,1,0)+ IF( SELF.Diff_non_driver_seq_num,1,0)+ IF( SELF.Diff_non_driver_trans_type,1,0)+ IF( SELF.Diff_non_driver_print_date,1,0)+ IF( SELF.Diff_action_surrender_date,1,0)+ IF( SELF.Diff_action_counts,1,0)+ IF( SELF.Diff_driv_priv_counts,1,0)+ IF( SELF.Diff_conv_counts,1,0)+ IF( SELF.Diff_accidents_counts,1,0)+ IF( SELF.Diff_aka_counts,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_cleaning_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_cln_zip5,1,0)+ IF( SELF.Diff_cln_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_previous_dl_number,1,0)+ IF( SELF.Diff_previous_st,1,0)+ IF( SELF.Diff_old_dl_number,1,0);
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
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_unique_key := COUNT(GROUP,%Closest%.Diff_unique_key);
    Count_Diff_license_number := COUNT(GROUP,%Closest%.Diff_license_number);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_middle_name := COUNT(GROUP,%Closest%.Diff_middle_name);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_date_of_birth := COUNT(GROUP,%Closest%.Diff_date_of_birth);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_address := COUNT(GROUP,%Closest%.Diff_address);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip5 := COUNT(GROUP,%Closest%.Diff_zip5);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_mailing_address1 := COUNT(GROUP,%Closest%.Diff_mailing_address1);
    Count_Diff_mailing_address2 := COUNT(GROUP,%Closest%.Diff_mailing_address2);
    Count_Diff_mailing_city := COUNT(GROUP,%Closest%.Diff_mailing_city);
    Count_Diff_mailing_state := COUNT(GROUP,%Closest%.Diff_mailing_state);
    Count_Diff_mailing_zip := COUNT(GROUP,%Closest%.Diff_mailing_zip);
    Count_Diff_height := COUNT(GROUP,%Closest%.Diff_height);
    Count_Diff_eye_color := COUNT(GROUP,%Closest%.Diff_eye_color);
    Count_Diff_operator_status := COUNT(GROUP,%Closest%.Diff_operator_status);
    Count_Diff_commercial_status := COUNT(GROUP,%Closest%.Diff_commercial_status);
    Count_Diff_sch_bus_status := COUNT(GROUP,%Closest%.Diff_sch_bus_status);
    Count_Diff_pending_act_code := COUNT(GROUP,%Closest%.Diff_pending_act_code);
    Count_Diff_must_test_ind := COUNT(GROUP,%Closest%.Diff_must_test_ind);
    Count_Diff_deceased_ind := COUNT(GROUP,%Closest%.Diff_deceased_ind);
    Count_Diff_prev_cdl_class := COUNT(GROUP,%Closest%.Diff_prev_cdl_class);
    Count_Diff_cdl_ptr := COUNT(GROUP,%Closest%.Diff_cdl_ptr);
    Count_Diff_pdps_ptr := COUNT(GROUP,%Closest%.Diff_pdps_ptr);
    Count_Diff_mvr_privacy_code := COUNT(GROUP,%Closest%.Diff_mvr_privacy_code);
    Count_Diff_brc_status_code := COUNT(GROUP,%Closest%.Diff_brc_status_code);
    Count_Diff_brc_status_date := COUNT(GROUP,%Closest%.Diff_brc_status_date);
    Count_Diff_lic_iss_code := COUNT(GROUP,%Closest%.Diff_lic_iss_code);
    Count_Diff_license_class := COUNT(GROUP,%Closest%.Diff_license_class);
    Count_Diff_lic_exp_date := COUNT(GROUP,%Closest%.Diff_lic_exp_date);
    Count_Diff_lic_seq_number := COUNT(GROUP,%Closest%.Diff_lic_seq_number);
    Count_Diff_lic_surrender_to := COUNT(GROUP,%Closest%.Diff_lic_surrender_to);
    Count_Diff_new_out_of_st_dl_num := COUNT(GROUP,%Closest%.Diff_new_out_of_st_dl_num);
    Count_Diff_license_endorsements := COUNT(GROUP,%Closest%.Diff_license_endorsements);
    Count_Diff_license_restrictions := COUNT(GROUP,%Closest%.Diff_license_restrictions);
    Count_Diff_license_trans_type := COUNT(GROUP,%Closest%.Diff_license_trans_type);
    Count_Diff_lic_print_date := COUNT(GROUP,%Closest%.Diff_lic_print_date);
    Count_Diff_permit_iss_code := COUNT(GROUP,%Closest%.Diff_permit_iss_code);
    Count_Diff_permit_class := COUNT(GROUP,%Closest%.Diff_permit_class);
    Count_Diff_permit_exp_date := COUNT(GROUP,%Closest%.Diff_permit_exp_date);
    Count_Diff_permit_seq_number := COUNT(GROUP,%Closest%.Diff_permit_seq_number);
    Count_Diff_permit_endorse_codes := COUNT(GROUP,%Closest%.Diff_permit_endorse_codes);
    Count_Diff_permit_restric_codes := COUNT(GROUP,%Closest%.Diff_permit_restric_codes);
    Count_Diff_permit_trans_type := COUNT(GROUP,%Closest%.Diff_permit_trans_type);
    Count_Diff_permit_print_date := COUNT(GROUP,%Closest%.Diff_permit_print_date);
    Count_Diff_non_driver_code := COUNT(GROUP,%Closest%.Diff_non_driver_code);
    Count_Diff_non_driver_exp_date := COUNT(GROUP,%Closest%.Diff_non_driver_exp_date);
    Count_Diff_non_driver_seq_num := COUNT(GROUP,%Closest%.Diff_non_driver_seq_num);
    Count_Diff_non_driver_trans_type := COUNT(GROUP,%Closest%.Diff_non_driver_trans_type);
    Count_Diff_non_driver_print_date := COUNT(GROUP,%Closest%.Diff_non_driver_print_date);
    Count_Diff_action_surrender_date := COUNT(GROUP,%Closest%.Diff_action_surrender_date);
    Count_Diff_action_counts := COUNT(GROUP,%Closest%.Diff_action_counts);
    Count_Diff_driv_priv_counts := COUNT(GROUP,%Closest%.Diff_driv_priv_counts);
    Count_Diff_conv_counts := COUNT(GROUP,%Closest%.Diff_conv_counts);
    Count_Diff_accidents_counts := COUNT(GROUP,%Closest%.Diff_accidents_counts);
    Count_Diff_aka_counts := COUNT(GROUP,%Closest%.Diff_aka_counts);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_cleaning_score := COUNT(GROUP,%Closest%.Diff_cleaning_score);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_cln_zip5 := COUNT(GROUP,%Closest%.Diff_cln_zip5);
    Count_Diff_cln_zip4 := COUNT(GROUP,%Closest%.Diff_cln_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_previous_dl_number := COUNT(GROUP,%Closest%.Diff_previous_dl_number);
    Count_Diff_previous_st := COUNT(GROUP,%Closest%.Diff_previous_st);
    Count_Diff_old_dl_number := COUNT(GROUP,%Closest%.Diff_old_dl_number);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

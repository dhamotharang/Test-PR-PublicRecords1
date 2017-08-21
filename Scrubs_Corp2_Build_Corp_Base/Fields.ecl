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
 
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'source_rec_id','bdid','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_key','corp_supp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_orig_sos_charter_nbr','corp_sos_charter_nbr','corp_src_type','corp_legal_name','corp_ln_name_type_cd','corp_ln_name_type_desc','corp_supp_nbr','corp_name_comment','corp_address1_type_cd','corp_address1_type_desc','corp_address1_line1','corp_address1_line2','corp_address1_line3','corp_address1_line4','corp_address1_line5','corp_address1_line6','corp_address1_effective_date','corp_address2_type_cd','corp_address2_type_desc','corp_address2_line1','corp_address2_line2','corp_address2_line3','corp_address2_line4','corp_address2_line5','corp_address2_line6','corp_address2_effective_date','corp_phone_number','corp_phone_number_type_cd','corp_phone_number_type_desc','corp_fax_nbr','corp_email_address','corp_web_address','corp_filing_reference_nbr','corp_filing_date','corp_filing_cd','corp_filing_desc','corp_status_cd','corp_status_desc','corp_status_date','corp_standing','corp_status_comment','corp_ticker_symbol','corp_stock_exchange','corp_inc_state','corp_inc_county','corp_inc_date','corp_anniversary_month','corp_fed_tax_id','corp_state_tax_id','corp_term_exist_cd','corp_term_exist_exp','corp_term_exist_desc','corp_foreign_domestic_ind','corp_forgn_state_cd','corp_forgn_state_desc','corp_forgn_sos_charter_nbr','corp_forgn_date','corp_forgn_fed_tax_id','corp_forgn_state_tax_id','corp_forgn_term_exist_cd','corp_forgn_term_exist_exp','corp_forgn_term_exist_desc','corp_orig_org_structure_cd','corp_orig_org_structure_desc','corp_for_profit_ind','corp_public_or_private_ind','corp_sic_code','corp_naic_code','corp_orig_bus_type_cd','corp_orig_bus_type_desc','corp_entity_desc','corp_certificate_nbr','corp_internal_nbr','corp_previous_nbr','corp_microfilm_nbr','corp_amendments_filed','corp_acts','corp_partnership_ind','corp_mfg_ind','corp_addl_info','corp_taxes','corp_franchise_taxes','corp_tax_program_cd','corp_tax_program_desc','corp_ra_name','corp_ra_title_cd','corp_ra_title_desc','corp_ra_fein','corp_ra_ssn','corp_ra_dob','corp_ra_effective_date','corp_ra_resign_date','corp_ra_no_comp','corp_ra_no_comp_igs','corp_ra_addl_info','corp_ra_address_type_cd','corp_ra_address_type_desc','corp_ra_address_line1','corp_ra_address_line2','corp_ra_address_line3','corp_ra_address_line4','corp_ra_address_line5','corp_ra_address_line6','corp_ra_phone_number','corp_ra_phone_number_type_cd','corp_ra_phone_number_type_desc','corp_ra_fax_nbr','corp_ra_email_address','corp_ra_web_address','corp_addr1_prim_range','corp_addr1_predir','corp_addr1_prim_name','corp_addr1_addr_suffix','corp_addr1_postdir','corp_addr1_unit_desig','corp_addr1_sec_range','corp_addr1_p_city_name','corp_addr1_v_city_name','corp_addr1_state','corp_addr1_zip5','corp_addr1_zip4','corp_addr1_cart','corp_addr1_cr_sort_sz','corp_addr1_lot','corp_addr1_lot_order','corp_addr1_dpbc','corp_addr1_chk_digit','corp_addr1_rec_type','corp_addr1_ace_fips_st','corp_addr1_county','corp_addr1_geo_lat','corp_addr1_geo_long','corp_addr1_msa','corp_addr1_geo_blk','corp_addr1_geo_match','corp_addr1_err_stat','corp_addr2_prim_range','corp_addr2_predir','corp_addr2_prim_name','corp_addr2_addr_suffix','corp_addr2_postdir','corp_addr2_unit_desig','corp_addr2_sec_range','corp_addr2_p_city_name','corp_addr2_v_city_name','corp_addr2_state','corp_addr2_zip5','corp_addr2_zip4','corp_addr2_cart','corp_addr2_cr_sort_sz','corp_addr2_lot','corp_addr2_lot_order','corp_addr2_dpbc','corp_addr2_chk_digit','corp_addr2_rec_type','corp_addr2_ace_fips_st','corp_addr2_county','corp_addr2_geo_lat','corp_addr2_geo_long','corp_addr2_msa','corp_addr2_geo_blk','corp_addr2_geo_match','corp_addr2_err_stat','corp_ra_title1','corp_ra_fname1','corp_ra_mname1','corp_ra_lname1','corp_ra_name_suffix1','corp_ra_score1','corp_ra_title2','corp_ra_fname2','corp_ra_mname2','corp_ra_lname2','corp_ra_name_suffix2','corp_ra_score2','corp_ra_cname1','corp_ra_cname1_score','corp_ra_cname2','corp_ra_cname2_score','corp_ra_prim_range','corp_ra_predir','corp_ra_prim_name','corp_ra_addr_suffix','corp_ra_postdir','corp_ra_unit_desig','corp_ra_sec_range','corp_ra_p_city_name','corp_ra_v_city_name','corp_ra_state','corp_ra_zip5','corp_ra_zip4','corp_ra_cart','corp_ra_cr_sort_sz','corp_ra_lot','corp_ra_lot_order','corp_ra_dpbc','corp_ra_chk_digit','corp_ra_rec_type','corp_ra_ace_fips_st','corp_ra_county','corp_ra_geo_lat','corp_ra_geo_long','corp_ra_msa','corp_ra_geo_blk','corp_ra_geo_match','corp_ra_err_stat','corp_phone10','corp_ra_phone10','record_type','append_addr1_rawaid','append_addr1_aceaid','corp_prep_addr1_line1','corp_prep_addr1_last_line','append_addr2_rawaid','append_addr2_aceaid','corp_prep_addr2_line1','corp_prep_addr2_last_line','append_ra_rawaid','append_ra_aceaid','ra_prep_addr_line1','ra_prep_addr_last_line','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'source_rec_id' => 1,'bdid' => 2,'dt_first_seen' => 3,'dt_last_seen' => 4,'dt_vendor_first_reported' => 5,'dt_vendor_last_reported' => 6,'corp_ra_dt_first_seen' => 7,'corp_ra_dt_last_seen' => 8,'corp_key' => 9,'corp_supp_key' => 10,'corp_vendor' => 11,'corp_vendor_county' => 12,'corp_vendor_subcode' => 13,'corp_state_origin' => 14,'corp_process_date' => 15,'corp_orig_sos_charter_nbr' => 16,'corp_sos_charter_nbr' => 17,'corp_src_type' => 18,'corp_legal_name' => 19,'corp_ln_name_type_cd' => 20,'corp_ln_name_type_desc' => 21,'corp_supp_nbr' => 22,'corp_name_comment' => 23,'corp_address1_type_cd' => 24,'corp_address1_type_desc' => 25,'corp_address1_line1' => 26,'corp_address1_line2' => 27,'corp_address1_line3' => 28,'corp_address1_line4' => 29,'corp_address1_line5' => 30,'corp_address1_line6' => 31,'corp_address1_effective_date' => 32,'corp_address2_type_cd' => 33,'corp_address2_type_desc' => 34,'corp_address2_line1' => 35,'corp_address2_line2' => 36,'corp_address2_line3' => 37,'corp_address2_line4' => 38,'corp_address2_line5' => 39,'corp_address2_line6' => 40,'corp_address2_effective_date' => 41,'corp_phone_number' => 42,'corp_phone_number_type_cd' => 43,'corp_phone_number_type_desc' => 44,'corp_fax_nbr' => 45,'corp_email_address' => 46,'corp_web_address' => 47,'corp_filing_reference_nbr' => 48,'corp_filing_date' => 49,'corp_filing_cd' => 50,'corp_filing_desc' => 51,'corp_status_cd' => 52,'corp_status_desc' => 53,'corp_status_date' => 54,'corp_standing' => 55,'corp_status_comment' => 56,'corp_ticker_symbol' => 57,'corp_stock_exchange' => 58,'corp_inc_state' => 59,'corp_inc_county' => 60,'corp_inc_date' => 61,'corp_anniversary_month' => 62,'corp_fed_tax_id' => 63,'corp_state_tax_id' => 64,'corp_term_exist_cd' => 65,'corp_term_exist_exp' => 66,'corp_term_exist_desc' => 67,'corp_foreign_domestic_ind' => 68,'corp_forgn_state_cd' => 69,'corp_forgn_state_desc' => 70,'corp_forgn_sos_charter_nbr' => 71,'corp_forgn_date' => 72,'corp_forgn_fed_tax_id' => 73,'corp_forgn_state_tax_id' => 74,'corp_forgn_term_exist_cd' => 75,'corp_forgn_term_exist_exp' => 76,'corp_forgn_term_exist_desc' => 77,'corp_orig_org_structure_cd' => 78,'corp_orig_org_structure_desc' => 79,'corp_for_profit_ind' => 80,'corp_public_or_private_ind' => 81,'corp_sic_code' => 82,'corp_naic_code' => 83,'corp_orig_bus_type_cd' => 84,'corp_orig_bus_type_desc' => 85,'corp_entity_desc' => 86,'corp_certificate_nbr' => 87,'corp_internal_nbr' => 88,'corp_previous_nbr' => 89,'corp_microfilm_nbr' => 90,'corp_amendments_filed' => 91,'corp_acts' => 92,'corp_partnership_ind' => 93,'corp_mfg_ind' => 94,'corp_addl_info' => 95,'corp_taxes' => 96,'corp_franchise_taxes' => 97,'corp_tax_program_cd' => 98,'corp_tax_program_desc' => 99,'corp_ra_name' => 100,'corp_ra_title_cd' => 101,'corp_ra_title_desc' => 102,'corp_ra_fein' => 103,'corp_ra_ssn' => 104,'corp_ra_dob' => 105,'corp_ra_effective_date' => 106,'corp_ra_resign_date' => 107,'corp_ra_no_comp' => 108,'corp_ra_no_comp_igs' => 109,'corp_ra_addl_info' => 110,'corp_ra_address_type_cd' => 111,'corp_ra_address_type_desc' => 112,'corp_ra_address_line1' => 113,'corp_ra_address_line2' => 114,'corp_ra_address_line3' => 115,'corp_ra_address_line4' => 116,'corp_ra_address_line5' => 117,'corp_ra_address_line6' => 118,'corp_ra_phone_number' => 119,'corp_ra_phone_number_type_cd' => 120,'corp_ra_phone_number_type_desc' => 121,'corp_ra_fax_nbr' => 122,'corp_ra_email_address' => 123,'corp_ra_web_address' => 124,'corp_addr1_prim_range' => 125,'corp_addr1_predir' => 126,'corp_addr1_prim_name' => 127,'corp_addr1_addr_suffix' => 128,'corp_addr1_postdir' => 129,'corp_addr1_unit_desig' => 130,'corp_addr1_sec_range' => 131,'corp_addr1_p_city_name' => 132,'corp_addr1_v_city_name' => 133,'corp_addr1_state' => 134,'corp_addr1_zip5' => 135,'corp_addr1_zip4' => 136,'corp_addr1_cart' => 137,'corp_addr1_cr_sort_sz' => 138,'corp_addr1_lot' => 139,'corp_addr1_lot_order' => 140,'corp_addr1_dpbc' => 141,'corp_addr1_chk_digit' => 142,'corp_addr1_rec_type' => 143,'corp_addr1_ace_fips_st' => 144,'corp_addr1_county' => 145,'corp_addr1_geo_lat' => 146,'corp_addr1_geo_long' => 147,'corp_addr1_msa' => 148,'corp_addr1_geo_blk' => 149,'corp_addr1_geo_match' => 150,'corp_addr1_err_stat' => 151,'corp_addr2_prim_range' => 152,'corp_addr2_predir' => 153,'corp_addr2_prim_name' => 154,'corp_addr2_addr_suffix' => 155,'corp_addr2_postdir' => 156,'corp_addr2_unit_desig' => 157,'corp_addr2_sec_range' => 158,'corp_addr2_p_city_name' => 159,'corp_addr2_v_city_name' => 160,'corp_addr2_state' => 161,'corp_addr2_zip5' => 162,'corp_addr2_zip4' => 163,'corp_addr2_cart' => 164,'corp_addr2_cr_sort_sz' => 165,'corp_addr2_lot' => 166,'corp_addr2_lot_order' => 167,'corp_addr2_dpbc' => 168,'corp_addr2_chk_digit' => 169,'corp_addr2_rec_type' => 170,'corp_addr2_ace_fips_st' => 171,'corp_addr2_county' => 172,'corp_addr2_geo_lat' => 173,'corp_addr2_geo_long' => 174,'corp_addr2_msa' => 175,'corp_addr2_geo_blk' => 176,'corp_addr2_geo_match' => 177,'corp_addr2_err_stat' => 178,'corp_ra_title1' => 179,'corp_ra_fname1' => 180,'corp_ra_mname1' => 181,'corp_ra_lname1' => 182,'corp_ra_name_suffix1' => 183,'corp_ra_score1' => 184,'corp_ra_title2' => 185,'corp_ra_fname2' => 186,'corp_ra_mname2' => 187,'corp_ra_lname2' => 188,'corp_ra_name_suffix2' => 189,'corp_ra_score2' => 190,'corp_ra_cname1' => 191,'corp_ra_cname1_score' => 192,'corp_ra_cname2' => 193,'corp_ra_cname2_score' => 194,'corp_ra_prim_range' => 195,'corp_ra_predir' => 196,'corp_ra_prim_name' => 197,'corp_ra_addr_suffix' => 198,'corp_ra_postdir' => 199,'corp_ra_unit_desig' => 200,'corp_ra_sec_range' => 201,'corp_ra_p_city_name' => 202,'corp_ra_v_city_name' => 203,'corp_ra_state' => 204,'corp_ra_zip5' => 205,'corp_ra_zip4' => 206,'corp_ra_cart' => 207,'corp_ra_cr_sort_sz' => 208,'corp_ra_lot' => 209,'corp_ra_lot_order' => 210,'corp_ra_dpbc' => 211,'corp_ra_chk_digit' => 212,'corp_ra_rec_type' => 213,'corp_ra_ace_fips_st' => 214,'corp_ra_county' => 215,'corp_ra_geo_lat' => 216,'corp_ra_geo_long' => 217,'corp_ra_msa' => 218,'corp_ra_geo_blk' => 219,'corp_ra_geo_match' => 220,'corp_ra_err_stat' => 221,'corp_phone10' => 222,'corp_ra_phone10' => 223,'record_type' => 224,'append_addr1_rawaid' => 225,'append_addr1_aceaid' => 226,'corp_prep_addr1_line1' => 227,'corp_prep_addr1_last_line' => 228,'append_addr2_rawaid' => 229,'append_addr2_aceaid' => 230,'corp_prep_addr2_line1' => 231,'corp_prep_addr2_last_line' => 232,'append_ra_rawaid' => 233,'append_ra_aceaid' => 234,'ra_prep_addr_line1' => 235,'ra_prep_addr_last_line' => 236,'dotid' => 237,'dotscore' => 238,'dotweight' => 239,'empid' => 240,'empscore' => 241,'empweight' => 242,'powid' => 243,'powscore' => 244,'powweight' => 245,'proxid' => 246,'proxscore' => 247,'proxweight' => 248,'seleid' => 249,'selescore' => 250,'seleweight' => 251,'orgid' => 252,'orgscore' => 253,'orgweight' => 254,'ultid' => 255,'ultscore' => 256,'ultweight' => 257,0);
 
//Individual field level validation
 
EXPORT Make_source_rec_id(SALT30.StrType s0) := s0;
EXPORT InValid_source_rec_id(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_source_rec_id(UNSIGNED1 wh) := '';
 
EXPORT Make_bdid(SALT30.StrType s0) := s0;
EXPORT InValid_bdid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_corp_ra_dt_first_seen(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_dt_first_seen(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_dt_last_seen(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_dt_last_seen(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_dt_last_seen(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_corp_orig_sos_charter_nbr(SALT30.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_corp_orig_sos_charter_nbr(SALT30.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_corp_orig_sos_charter_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_corp_sos_charter_nbr(SALT30.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_corp_sos_charter_nbr(SALT30.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_corp_sos_charter_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_corp_src_type(SALT30.StrType s0) := s0;
EXPORT InValid_corp_src_type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_src_type(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_legal_name(SALT30.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_corp_legal_name(SALT30.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_corp_legal_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_corp_ln_name_type_cd(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ln_name_type_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ln_name_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ln_name_type_desc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ln_name_type_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ln_name_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_supp_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_corp_supp_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_supp_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_name_comment(SALT30.StrType s0) := s0;
EXPORT InValid_corp_name_comment(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_name_comment(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_corp_address2_type_cd(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address2_type_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address2_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address2_type_desc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address2_type_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address2_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address2_line1(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address2_line1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address2_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address2_line2(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address2_line2(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address2_line2(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address2_line3(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address2_line3(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address2_line3(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address2_line4(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address2_line4(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address2_line4(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address2_line5(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address2_line5(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address2_line5(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address2_line6(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address2_line6(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address2_line6(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_address2_effective_date(SALT30.StrType s0) := s0;
EXPORT InValid_corp_address2_effective_date(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_address2_effective_date(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_corp_filing_reference_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_corp_filing_reference_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_filing_reference_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_filing_date(SALT30.StrType s0) := s0;
EXPORT InValid_corp_filing_date(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_filing_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_filing_cd(SALT30.StrType s0) := s0;
EXPORT InValid_corp_filing_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_filing_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_filing_desc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_filing_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_filing_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_status_cd(SALT30.StrType s0) := s0;
EXPORT InValid_corp_status_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_status_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_status_desc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_status_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_status_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_status_date(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_status_date(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_status_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_standing(SALT30.StrType s0) := MakeFT_invalid_flag_code(s0);
EXPORT InValid_corp_standing(SALT30.StrType s) := InValidFT_invalid_flag_code(s);
EXPORT InValidMessage_corp_standing(UNSIGNED1 wh) := InValidMessageFT_invalid_flag_code(wh);
 
EXPORT Make_corp_status_comment(SALT30.StrType s0) := s0;
EXPORT InValid_corp_status_comment(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_status_comment(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ticker_symbol(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ticker_symbol(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ticker_symbol(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_stock_exchange(SALT30.StrType s0) := s0;
EXPORT InValid_corp_stock_exchange(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_stock_exchange(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_inc_state(SALT30.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_inc_state(SALT30.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_inc_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_inc_county(SALT30.StrType s0) := s0;
EXPORT InValid_corp_inc_county(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_inc_county(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_inc_date(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_inc_date(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_inc_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_anniversary_month(SALT30.StrType s0) := s0;
EXPORT InValid_corp_anniversary_month(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_anniversary_month(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_fed_tax_id(SALT30.StrType s0) := s0;
EXPORT InValid_corp_fed_tax_id(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_fed_tax_id(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_state_tax_id(SALT30.StrType s0) := s0;
EXPORT InValid_corp_state_tax_id(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_state_tax_id(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_term_exist_cd(SALT30.StrType s0) := s0;
EXPORT InValid_corp_term_exist_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_term_exist_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_term_exist_exp(SALT30.StrType s0) := s0;
EXPORT InValid_corp_term_exist_exp(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_term_exist_exp(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_term_exist_desc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_term_exist_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_term_exist_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_foreign_domestic_ind(SALT30.StrType s0) := MakeFT_invalid_forgn_dom_code(s0);
EXPORT InValid_corp_foreign_domestic_ind(SALT30.StrType s) := InValidFT_invalid_forgn_dom_code(s);
EXPORT InValidMessage_corp_foreign_domestic_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_forgn_dom_code(wh);
 
EXPORT Make_corp_forgn_state_cd(SALT30.StrType s0) := s0;
EXPORT InValid_corp_forgn_state_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_forgn_state_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_forgn_state_desc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_forgn_state_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_forgn_state_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_forgn_sos_charter_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_corp_forgn_sos_charter_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_forgn_sos_charter_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_forgn_date(SALT30.StrType s0) := s0;
EXPORT InValid_corp_forgn_date(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_forgn_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_forgn_fed_tax_id(SALT30.StrType s0) := s0;
EXPORT InValid_corp_forgn_fed_tax_id(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_forgn_fed_tax_id(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_forgn_state_tax_id(SALT30.StrType s0) := s0;
EXPORT InValid_corp_forgn_state_tax_id(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_forgn_state_tax_id(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_forgn_term_exist_cd(SALT30.StrType s0) := s0;
EXPORT InValid_corp_forgn_term_exist_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_forgn_term_exist_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_forgn_term_exist_exp(SALT30.StrType s0) := s0;
EXPORT InValid_corp_forgn_term_exist_exp(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_forgn_term_exist_exp(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_forgn_term_exist_desc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_forgn_term_exist_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_forgn_term_exist_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_orig_org_structure_cd(SALT30.StrType s0) := s0;
EXPORT InValid_corp_orig_org_structure_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_orig_org_structure_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_orig_org_structure_desc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_orig_org_structure_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_orig_org_structure_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_for_profit_ind(SALT30.StrType s0) := MakeFT_invalid_flag_code(s0);
EXPORT InValid_corp_for_profit_ind(SALT30.StrType s) := InValidFT_invalid_flag_code(s);
EXPORT InValidMessage_corp_for_profit_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_flag_code(wh);
 
EXPORT Make_corp_public_or_private_ind(SALT30.StrType s0) := MakeFT_invalid_flag_code(s0);
EXPORT InValid_corp_public_or_private_ind(SALT30.StrType s) := InValidFT_invalid_flag_code(s);
EXPORT InValidMessage_corp_public_or_private_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_flag_code(wh);
 
EXPORT Make_corp_sic_code(SALT30.StrType s0) := s0;
EXPORT InValid_corp_sic_code(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_sic_code(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_naic_code(SALT30.StrType s0) := s0;
EXPORT InValid_corp_naic_code(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_naic_code(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_orig_bus_type_cd(SALT30.StrType s0) := s0;
EXPORT InValid_corp_orig_bus_type_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_orig_bus_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_orig_bus_type_desc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_orig_bus_type_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_orig_bus_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_entity_desc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_entity_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_entity_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_certificate_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_corp_certificate_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_certificate_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_internal_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_corp_internal_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_internal_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_previous_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_corp_previous_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_previous_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_microfilm_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_corp_microfilm_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_microfilm_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_amendments_filed(SALT30.StrType s0) := s0;
EXPORT InValid_corp_amendments_filed(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_amendments_filed(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_acts(SALT30.StrType s0) := s0;
EXPORT InValid_corp_acts(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_acts(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_partnership_ind(SALT30.StrType s0) := s0;
EXPORT InValid_corp_partnership_ind(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_partnership_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_mfg_ind(SALT30.StrType s0) := s0;
EXPORT InValid_corp_mfg_ind(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_mfg_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addl_info(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addl_info(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addl_info(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_taxes(SALT30.StrType s0) := s0;
EXPORT InValid_corp_taxes(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_taxes(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_franchise_taxes(SALT30.StrType s0) := s0;
EXPORT InValid_corp_franchise_taxes(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_franchise_taxes(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_tax_program_cd(SALT30.StrType s0) := s0;
EXPORT InValid_corp_tax_program_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_tax_program_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_tax_program_desc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_tax_program_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_tax_program_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_name(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_name(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_title_cd(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_title_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_title_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_title_desc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_title_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_title_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_fein(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_fein(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_ssn(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_ssn(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_dob(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_dob(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_dob(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_effective_date(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_effective_date(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_effective_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_resign_date(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_resign_date(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_resign_date(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_no_comp(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_no_comp(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_no_comp(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_no_comp_igs(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_no_comp_igs(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_no_comp_igs(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_addl_info(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_addl_info(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_addl_info(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_address_type_cd(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_address_type_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_address_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_address_type_desc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_address_type_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_address_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_address_line1(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_address_line1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_address_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_address_line2(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_address_line2(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_address_line2(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_address_line3(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_address_line3(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_address_line3(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_address_line4(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_address_line4(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_address_line4(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_address_line5(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_address_line5(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_address_line5(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_address_line6(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_address_line6(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_address_line6(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_phone_number(SALT30.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_corp_ra_phone_number(SALT30.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_corp_ra_phone_number(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_corp_ra_phone_number_type_cd(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_phone_number_type_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_phone_number_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_phone_number_type_desc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_phone_number_type_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_phone_number_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_fax_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_fax_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_fax_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_email_address(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_email_address(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_email_address(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_web_address(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_web_address(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_web_address(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_corp_addr2_prim_range(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_prim_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_predir(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_predir(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_prim_name(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_prim_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_addr_suffix(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_addr_suffix(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_postdir(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_postdir(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_unit_desig(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_unit_desig(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_sec_range(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_sec_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_p_city_name(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_p_city_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_v_city_name(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_v_city_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_state(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_state(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_state(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_zip5(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_zip5(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_zip5(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_zip4(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_zip4(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_cart(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_cart(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_cr_sort_sz(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_cr_sort_sz(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_lot(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_lot(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_lot_order(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_lot_order(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_dpbc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_dpbc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_dpbc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_chk_digit(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_chk_digit(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_rec_type(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_rec_type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_ace_fips_st(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_ace_fips_st(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_ace_fips_st(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_county(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_county(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_county(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_geo_lat(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_geo_lat(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_geo_long(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_geo_long(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_msa(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_msa(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_geo_blk(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_geo_blk(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_geo_match(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_geo_match(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_addr2_err_stat(SALT30.StrType s0) := s0;
EXPORT InValid_corp_addr2_err_stat(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_addr2_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_title1(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_title1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_title1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_fname1(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_fname1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_fname1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_mname1(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_mname1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_mname1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_lname1(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_lname1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_lname1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_name_suffix1(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_name_suffix1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_name_suffix1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_score1(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_score1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_score1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_title2(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_title2(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_title2(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_fname2(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_fname2(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_fname2(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_mname2(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_mname2(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_mname2(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_lname2(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_lname2(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_lname2(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_name_suffix2(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_name_suffix2(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_name_suffix2(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_score2(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_score2(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_score2(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_cname1(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_cname1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_cname1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_cname1_score(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_cname1_score(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_cname1_score(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_cname2(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_cname2(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_cname2(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_cname2_score(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_cname2_score(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_cname2_score(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_prim_range(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_prim_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_predir(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_predir(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_prim_name(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_prim_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_addr_suffix(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_addr_suffix(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_postdir(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_postdir(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_unit_desig(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_unit_desig(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_sec_range(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_sec_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_p_city_name(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_p_city_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_v_city_name(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_v_city_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_state(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_state(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_state(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_zip5(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_zip5(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_zip5(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_zip4(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_zip4(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_cart(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_cart(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_cr_sort_sz(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_cr_sort_sz(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_lot(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_lot(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_lot_order(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_lot_order(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_dpbc(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_dpbc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_dpbc(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_chk_digit(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_chk_digit(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_rec_type(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_rec_type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_ace_fips_st(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_ace_fips_st(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_ace_fips_st(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_county(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_county(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_county(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_geo_lat(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_geo_lat(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_geo_long(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_geo_long(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_msa(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_msa(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_geo_blk(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_geo_blk(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_geo_match(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_geo_match(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_err_stat(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_err_stat(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_phone10(SALT30.StrType s0) := s0;
EXPORT InValid_corp_phone10(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_phone10(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ra_phone10(SALT30.StrType s0) := s0;
EXPORT InValid_corp_ra_phone10(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_ra_phone10(UNSIGNED1 wh) := '';
 
EXPORT Make_record_type(SALT30.StrType s0) := s0;
EXPORT InValid_record_type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := '';
 
EXPORT Make_append_addr1_rawaid(SALT30.StrType s0) := s0;
EXPORT InValid_append_addr1_rawaid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_addr1_rawaid(UNSIGNED1 wh) := '';
 
EXPORT Make_append_addr1_aceaid(SALT30.StrType s0) := s0;
EXPORT InValid_append_addr1_aceaid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_addr1_aceaid(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_prep_addr1_line1(SALT30.StrType s0) := s0;
EXPORT InValid_corp_prep_addr1_line1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_prep_addr1_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_prep_addr1_last_line(SALT30.StrType s0) := s0;
EXPORT InValid_corp_prep_addr1_last_line(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_prep_addr1_last_line(UNSIGNED1 wh) := '';
 
EXPORT Make_append_addr2_rawaid(SALT30.StrType s0) := s0;
EXPORT InValid_append_addr2_rawaid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_addr2_rawaid(UNSIGNED1 wh) := '';
 
EXPORT Make_append_addr2_aceaid(SALT30.StrType s0) := s0;
EXPORT InValid_append_addr2_aceaid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_addr2_aceaid(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_prep_addr2_line1(SALT30.StrType s0) := s0;
EXPORT InValid_corp_prep_addr2_line1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_prep_addr2_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_prep_addr2_last_line(SALT30.StrType s0) := s0;
EXPORT InValid_corp_prep_addr2_last_line(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_prep_addr2_last_line(UNSIGNED1 wh) := '';
 
EXPORT Make_append_ra_rawaid(SALT30.StrType s0) := s0;
EXPORT InValid_append_ra_rawaid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_ra_rawaid(UNSIGNED1 wh) := '';
 
EXPORT Make_append_ra_aceaid(SALT30.StrType s0) := s0;
EXPORT InValid_append_ra_aceaid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_ra_aceaid(UNSIGNED1 wh) := '';
 
EXPORT Make_ra_prep_addr_line1(SALT30.StrType s0) := s0;
EXPORT InValid_ra_prep_addr_line1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ra_prep_addr_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_ra_prep_addr_last_line(SALT30.StrType s0) := s0;
EXPORT InValid_ra_prep_addr_last_line(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ra_prep_addr_last_line(UNSIGNED1 wh) := '';
 
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
  IMPORT SALT30,Scrubs_Corp2_Build_Corp_Base;
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
    BOOLEAN Diff_source_rec_id;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_corp_ra_dt_first_seen;
    BOOLEAN Diff_corp_ra_dt_last_seen;
    BOOLEAN Diff_corp_key;
    BOOLEAN Diff_corp_supp_key;
    BOOLEAN Diff_corp_vendor;
    BOOLEAN Diff_corp_vendor_county;
    BOOLEAN Diff_corp_vendor_subcode;
    BOOLEAN Diff_corp_state_origin;
    BOOLEAN Diff_corp_process_date;
    BOOLEAN Diff_corp_orig_sos_charter_nbr;
    BOOLEAN Diff_corp_sos_charter_nbr;
    BOOLEAN Diff_corp_src_type;
    BOOLEAN Diff_corp_legal_name;
    BOOLEAN Diff_corp_ln_name_type_cd;
    BOOLEAN Diff_corp_ln_name_type_desc;
    BOOLEAN Diff_corp_supp_nbr;
    BOOLEAN Diff_corp_name_comment;
    BOOLEAN Diff_corp_address1_type_cd;
    BOOLEAN Diff_corp_address1_type_desc;
    BOOLEAN Diff_corp_address1_line1;
    BOOLEAN Diff_corp_address1_line2;
    BOOLEAN Diff_corp_address1_line3;
    BOOLEAN Diff_corp_address1_line4;
    BOOLEAN Diff_corp_address1_line5;
    BOOLEAN Diff_corp_address1_line6;
    BOOLEAN Diff_corp_address1_effective_date;
    BOOLEAN Diff_corp_address2_type_cd;
    BOOLEAN Diff_corp_address2_type_desc;
    BOOLEAN Diff_corp_address2_line1;
    BOOLEAN Diff_corp_address2_line2;
    BOOLEAN Diff_corp_address2_line3;
    BOOLEAN Diff_corp_address2_line4;
    BOOLEAN Diff_corp_address2_line5;
    BOOLEAN Diff_corp_address2_line6;
    BOOLEAN Diff_corp_address2_effective_date;
    BOOLEAN Diff_corp_phone_number;
    BOOLEAN Diff_corp_phone_number_type_cd;
    BOOLEAN Diff_corp_phone_number_type_desc;
    BOOLEAN Diff_corp_fax_nbr;
    BOOLEAN Diff_corp_email_address;
    BOOLEAN Diff_corp_web_address;
    BOOLEAN Diff_corp_filing_reference_nbr;
    BOOLEAN Diff_corp_filing_date;
    BOOLEAN Diff_corp_filing_cd;
    BOOLEAN Diff_corp_filing_desc;
    BOOLEAN Diff_corp_status_cd;
    BOOLEAN Diff_corp_status_desc;
    BOOLEAN Diff_corp_status_date;
    BOOLEAN Diff_corp_standing;
    BOOLEAN Diff_corp_status_comment;
    BOOLEAN Diff_corp_ticker_symbol;
    BOOLEAN Diff_corp_stock_exchange;
    BOOLEAN Diff_corp_inc_state;
    BOOLEAN Diff_corp_inc_county;
    BOOLEAN Diff_corp_inc_date;
    BOOLEAN Diff_corp_anniversary_month;
    BOOLEAN Diff_corp_fed_tax_id;
    BOOLEAN Diff_corp_state_tax_id;
    BOOLEAN Diff_corp_term_exist_cd;
    BOOLEAN Diff_corp_term_exist_exp;
    BOOLEAN Diff_corp_term_exist_desc;
    BOOLEAN Diff_corp_foreign_domestic_ind;
    BOOLEAN Diff_corp_forgn_state_cd;
    BOOLEAN Diff_corp_forgn_state_desc;
    BOOLEAN Diff_corp_forgn_sos_charter_nbr;
    BOOLEAN Diff_corp_forgn_date;
    BOOLEAN Diff_corp_forgn_fed_tax_id;
    BOOLEAN Diff_corp_forgn_state_tax_id;
    BOOLEAN Diff_corp_forgn_term_exist_cd;
    BOOLEAN Diff_corp_forgn_term_exist_exp;
    BOOLEAN Diff_corp_forgn_term_exist_desc;
    BOOLEAN Diff_corp_orig_org_structure_cd;
    BOOLEAN Diff_corp_orig_org_structure_desc;
    BOOLEAN Diff_corp_for_profit_ind;
    BOOLEAN Diff_corp_public_or_private_ind;
    BOOLEAN Diff_corp_sic_code;
    BOOLEAN Diff_corp_naic_code;
    BOOLEAN Diff_corp_orig_bus_type_cd;
    BOOLEAN Diff_corp_orig_bus_type_desc;
    BOOLEAN Diff_corp_entity_desc;
    BOOLEAN Diff_corp_certificate_nbr;
    BOOLEAN Diff_corp_internal_nbr;
    BOOLEAN Diff_corp_previous_nbr;
    BOOLEAN Diff_corp_microfilm_nbr;
    BOOLEAN Diff_corp_amendments_filed;
    BOOLEAN Diff_corp_acts;
    BOOLEAN Diff_corp_partnership_ind;
    BOOLEAN Diff_corp_mfg_ind;
    BOOLEAN Diff_corp_addl_info;
    BOOLEAN Diff_corp_taxes;
    BOOLEAN Diff_corp_franchise_taxes;
    BOOLEAN Diff_corp_tax_program_cd;
    BOOLEAN Diff_corp_tax_program_desc;
    BOOLEAN Diff_corp_ra_name;
    BOOLEAN Diff_corp_ra_title_cd;
    BOOLEAN Diff_corp_ra_title_desc;
    BOOLEAN Diff_corp_ra_fein;
    BOOLEAN Diff_corp_ra_ssn;
    BOOLEAN Diff_corp_ra_dob;
    BOOLEAN Diff_corp_ra_effective_date;
    BOOLEAN Diff_corp_ra_resign_date;
    BOOLEAN Diff_corp_ra_no_comp;
    BOOLEAN Diff_corp_ra_no_comp_igs;
    BOOLEAN Diff_corp_ra_addl_info;
    BOOLEAN Diff_corp_ra_address_type_cd;
    BOOLEAN Diff_corp_ra_address_type_desc;
    BOOLEAN Diff_corp_ra_address_line1;
    BOOLEAN Diff_corp_ra_address_line2;
    BOOLEAN Diff_corp_ra_address_line3;
    BOOLEAN Diff_corp_ra_address_line4;
    BOOLEAN Diff_corp_ra_address_line5;
    BOOLEAN Diff_corp_ra_address_line6;
    BOOLEAN Diff_corp_ra_phone_number;
    BOOLEAN Diff_corp_ra_phone_number_type_cd;
    BOOLEAN Diff_corp_ra_phone_number_type_desc;
    BOOLEAN Diff_corp_ra_fax_nbr;
    BOOLEAN Diff_corp_ra_email_address;
    BOOLEAN Diff_corp_ra_web_address;
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
    BOOLEAN Diff_corp_addr2_prim_range;
    BOOLEAN Diff_corp_addr2_predir;
    BOOLEAN Diff_corp_addr2_prim_name;
    BOOLEAN Diff_corp_addr2_addr_suffix;
    BOOLEAN Diff_corp_addr2_postdir;
    BOOLEAN Diff_corp_addr2_unit_desig;
    BOOLEAN Diff_corp_addr2_sec_range;
    BOOLEAN Diff_corp_addr2_p_city_name;
    BOOLEAN Diff_corp_addr2_v_city_name;
    BOOLEAN Diff_corp_addr2_state;
    BOOLEAN Diff_corp_addr2_zip5;
    BOOLEAN Diff_corp_addr2_zip4;
    BOOLEAN Diff_corp_addr2_cart;
    BOOLEAN Diff_corp_addr2_cr_sort_sz;
    BOOLEAN Diff_corp_addr2_lot;
    BOOLEAN Diff_corp_addr2_lot_order;
    BOOLEAN Diff_corp_addr2_dpbc;
    BOOLEAN Diff_corp_addr2_chk_digit;
    BOOLEAN Diff_corp_addr2_rec_type;
    BOOLEAN Diff_corp_addr2_ace_fips_st;
    BOOLEAN Diff_corp_addr2_county;
    BOOLEAN Diff_corp_addr2_geo_lat;
    BOOLEAN Diff_corp_addr2_geo_long;
    BOOLEAN Diff_corp_addr2_msa;
    BOOLEAN Diff_corp_addr2_geo_blk;
    BOOLEAN Diff_corp_addr2_geo_match;
    BOOLEAN Diff_corp_addr2_err_stat;
    BOOLEAN Diff_corp_ra_title1;
    BOOLEAN Diff_corp_ra_fname1;
    BOOLEAN Diff_corp_ra_mname1;
    BOOLEAN Diff_corp_ra_lname1;
    BOOLEAN Diff_corp_ra_name_suffix1;
    BOOLEAN Diff_corp_ra_score1;
    BOOLEAN Diff_corp_ra_title2;
    BOOLEAN Diff_corp_ra_fname2;
    BOOLEAN Diff_corp_ra_mname2;
    BOOLEAN Diff_corp_ra_lname2;
    BOOLEAN Diff_corp_ra_name_suffix2;
    BOOLEAN Diff_corp_ra_score2;
    BOOLEAN Diff_corp_ra_cname1;
    BOOLEAN Diff_corp_ra_cname1_score;
    BOOLEAN Diff_corp_ra_cname2;
    BOOLEAN Diff_corp_ra_cname2_score;
    BOOLEAN Diff_corp_ra_prim_range;
    BOOLEAN Diff_corp_ra_predir;
    BOOLEAN Diff_corp_ra_prim_name;
    BOOLEAN Diff_corp_ra_addr_suffix;
    BOOLEAN Diff_corp_ra_postdir;
    BOOLEAN Diff_corp_ra_unit_desig;
    BOOLEAN Diff_corp_ra_sec_range;
    BOOLEAN Diff_corp_ra_p_city_name;
    BOOLEAN Diff_corp_ra_v_city_name;
    BOOLEAN Diff_corp_ra_state;
    BOOLEAN Diff_corp_ra_zip5;
    BOOLEAN Diff_corp_ra_zip4;
    BOOLEAN Diff_corp_ra_cart;
    BOOLEAN Diff_corp_ra_cr_sort_sz;
    BOOLEAN Diff_corp_ra_lot;
    BOOLEAN Diff_corp_ra_lot_order;
    BOOLEAN Diff_corp_ra_dpbc;
    BOOLEAN Diff_corp_ra_chk_digit;
    BOOLEAN Diff_corp_ra_rec_type;
    BOOLEAN Diff_corp_ra_ace_fips_st;
    BOOLEAN Diff_corp_ra_county;
    BOOLEAN Diff_corp_ra_geo_lat;
    BOOLEAN Diff_corp_ra_geo_long;
    BOOLEAN Diff_corp_ra_msa;
    BOOLEAN Diff_corp_ra_geo_blk;
    BOOLEAN Diff_corp_ra_geo_match;
    BOOLEAN Diff_corp_ra_err_stat;
    BOOLEAN Diff_corp_phone10;
    BOOLEAN Diff_corp_ra_phone10;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_append_addr1_rawaid;
    BOOLEAN Diff_append_addr1_aceaid;
    BOOLEAN Diff_corp_prep_addr1_line1;
    BOOLEAN Diff_corp_prep_addr1_last_line;
    BOOLEAN Diff_append_addr2_rawaid;
    BOOLEAN Diff_append_addr2_aceaid;
    BOOLEAN Diff_corp_prep_addr2_line1;
    BOOLEAN Diff_corp_prep_addr2_last_line;
    BOOLEAN Diff_append_ra_rawaid;
    BOOLEAN Diff_append_ra_aceaid;
    BOOLEAN Diff_ra_prep_addr_line1;
    BOOLEAN Diff_ra_prep_addr_last_line;
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
    SELF.Diff_source_rec_id := le.source_rec_id <> ri.source_rec_id;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_corp_ra_dt_first_seen := le.corp_ra_dt_first_seen <> ri.corp_ra_dt_first_seen;
    SELF.Diff_corp_ra_dt_last_seen := le.corp_ra_dt_last_seen <> ri.corp_ra_dt_last_seen;
    SELF.Diff_corp_key := le.corp_key <> ri.corp_key;
    SELF.Diff_corp_supp_key := le.corp_supp_key <> ri.corp_supp_key;
    SELF.Diff_corp_vendor := le.corp_vendor <> ri.corp_vendor;
    SELF.Diff_corp_vendor_county := le.corp_vendor_county <> ri.corp_vendor_county;
    SELF.Diff_corp_vendor_subcode := le.corp_vendor_subcode <> ri.corp_vendor_subcode;
    SELF.Diff_corp_state_origin := le.corp_state_origin <> ri.corp_state_origin;
    SELF.Diff_corp_process_date := le.corp_process_date <> ri.corp_process_date;
    SELF.Diff_corp_orig_sos_charter_nbr := le.corp_orig_sos_charter_nbr <> ri.corp_orig_sos_charter_nbr;
    SELF.Diff_corp_sos_charter_nbr := le.corp_sos_charter_nbr <> ri.corp_sos_charter_nbr;
    SELF.Diff_corp_src_type := le.corp_src_type <> ri.corp_src_type;
    SELF.Diff_corp_legal_name := le.corp_legal_name <> ri.corp_legal_name;
    SELF.Diff_corp_ln_name_type_cd := le.corp_ln_name_type_cd <> ri.corp_ln_name_type_cd;
    SELF.Diff_corp_ln_name_type_desc := le.corp_ln_name_type_desc <> ri.corp_ln_name_type_desc;
    SELF.Diff_corp_supp_nbr := le.corp_supp_nbr <> ri.corp_supp_nbr;
    SELF.Diff_corp_name_comment := le.corp_name_comment <> ri.corp_name_comment;
    SELF.Diff_corp_address1_type_cd := le.corp_address1_type_cd <> ri.corp_address1_type_cd;
    SELF.Diff_corp_address1_type_desc := le.corp_address1_type_desc <> ri.corp_address1_type_desc;
    SELF.Diff_corp_address1_line1 := le.corp_address1_line1 <> ri.corp_address1_line1;
    SELF.Diff_corp_address1_line2 := le.corp_address1_line2 <> ri.corp_address1_line2;
    SELF.Diff_corp_address1_line3 := le.corp_address1_line3 <> ri.corp_address1_line3;
    SELF.Diff_corp_address1_line4 := le.corp_address1_line4 <> ri.corp_address1_line4;
    SELF.Diff_corp_address1_line5 := le.corp_address1_line5 <> ri.corp_address1_line5;
    SELF.Diff_corp_address1_line6 := le.corp_address1_line6 <> ri.corp_address1_line6;
    SELF.Diff_corp_address1_effective_date := le.corp_address1_effective_date <> ri.corp_address1_effective_date;
    SELF.Diff_corp_address2_type_cd := le.corp_address2_type_cd <> ri.corp_address2_type_cd;
    SELF.Diff_corp_address2_type_desc := le.corp_address2_type_desc <> ri.corp_address2_type_desc;
    SELF.Diff_corp_address2_line1 := le.corp_address2_line1 <> ri.corp_address2_line1;
    SELF.Diff_corp_address2_line2 := le.corp_address2_line2 <> ri.corp_address2_line2;
    SELF.Diff_corp_address2_line3 := le.corp_address2_line3 <> ri.corp_address2_line3;
    SELF.Diff_corp_address2_line4 := le.corp_address2_line4 <> ri.corp_address2_line4;
    SELF.Diff_corp_address2_line5 := le.corp_address2_line5 <> ri.corp_address2_line5;
    SELF.Diff_corp_address2_line6 := le.corp_address2_line6 <> ri.corp_address2_line6;
    SELF.Diff_corp_address2_effective_date := le.corp_address2_effective_date <> ri.corp_address2_effective_date;
    SELF.Diff_corp_phone_number := le.corp_phone_number <> ri.corp_phone_number;
    SELF.Diff_corp_phone_number_type_cd := le.corp_phone_number_type_cd <> ri.corp_phone_number_type_cd;
    SELF.Diff_corp_phone_number_type_desc := le.corp_phone_number_type_desc <> ri.corp_phone_number_type_desc;
    SELF.Diff_corp_fax_nbr := le.corp_fax_nbr <> ri.corp_fax_nbr;
    SELF.Diff_corp_email_address := le.corp_email_address <> ri.corp_email_address;
    SELF.Diff_corp_web_address := le.corp_web_address <> ri.corp_web_address;
    SELF.Diff_corp_filing_reference_nbr := le.corp_filing_reference_nbr <> ri.corp_filing_reference_nbr;
    SELF.Diff_corp_filing_date := le.corp_filing_date <> ri.corp_filing_date;
    SELF.Diff_corp_filing_cd := le.corp_filing_cd <> ri.corp_filing_cd;
    SELF.Diff_corp_filing_desc := le.corp_filing_desc <> ri.corp_filing_desc;
    SELF.Diff_corp_status_cd := le.corp_status_cd <> ri.corp_status_cd;
    SELF.Diff_corp_status_desc := le.corp_status_desc <> ri.corp_status_desc;
    SELF.Diff_corp_status_date := le.corp_status_date <> ri.corp_status_date;
    SELF.Diff_corp_standing := le.corp_standing <> ri.corp_standing;
    SELF.Diff_corp_status_comment := le.corp_status_comment <> ri.corp_status_comment;
    SELF.Diff_corp_ticker_symbol := le.corp_ticker_symbol <> ri.corp_ticker_symbol;
    SELF.Diff_corp_stock_exchange := le.corp_stock_exchange <> ri.corp_stock_exchange;
    SELF.Diff_corp_inc_state := le.corp_inc_state <> ri.corp_inc_state;
    SELF.Diff_corp_inc_county := le.corp_inc_county <> ri.corp_inc_county;
    SELF.Diff_corp_inc_date := le.corp_inc_date <> ri.corp_inc_date;
    SELF.Diff_corp_anniversary_month := le.corp_anniversary_month <> ri.corp_anniversary_month;
    SELF.Diff_corp_fed_tax_id := le.corp_fed_tax_id <> ri.corp_fed_tax_id;
    SELF.Diff_corp_state_tax_id := le.corp_state_tax_id <> ri.corp_state_tax_id;
    SELF.Diff_corp_term_exist_cd := le.corp_term_exist_cd <> ri.corp_term_exist_cd;
    SELF.Diff_corp_term_exist_exp := le.corp_term_exist_exp <> ri.corp_term_exist_exp;
    SELF.Diff_corp_term_exist_desc := le.corp_term_exist_desc <> ri.corp_term_exist_desc;
    SELF.Diff_corp_foreign_domestic_ind := le.corp_foreign_domestic_ind <> ri.corp_foreign_domestic_ind;
    SELF.Diff_corp_forgn_state_cd := le.corp_forgn_state_cd <> ri.corp_forgn_state_cd;
    SELF.Diff_corp_forgn_state_desc := le.corp_forgn_state_desc <> ri.corp_forgn_state_desc;
    SELF.Diff_corp_forgn_sos_charter_nbr := le.corp_forgn_sos_charter_nbr <> ri.corp_forgn_sos_charter_nbr;
    SELF.Diff_corp_forgn_date := le.corp_forgn_date <> ri.corp_forgn_date;
    SELF.Diff_corp_forgn_fed_tax_id := le.corp_forgn_fed_tax_id <> ri.corp_forgn_fed_tax_id;
    SELF.Diff_corp_forgn_state_tax_id := le.corp_forgn_state_tax_id <> ri.corp_forgn_state_tax_id;
    SELF.Diff_corp_forgn_term_exist_cd := le.corp_forgn_term_exist_cd <> ri.corp_forgn_term_exist_cd;
    SELF.Diff_corp_forgn_term_exist_exp := le.corp_forgn_term_exist_exp <> ri.corp_forgn_term_exist_exp;
    SELF.Diff_corp_forgn_term_exist_desc := le.corp_forgn_term_exist_desc <> ri.corp_forgn_term_exist_desc;
    SELF.Diff_corp_orig_org_structure_cd := le.corp_orig_org_structure_cd <> ri.corp_orig_org_structure_cd;
    SELF.Diff_corp_orig_org_structure_desc := le.corp_orig_org_structure_desc <> ri.corp_orig_org_structure_desc;
    SELF.Diff_corp_for_profit_ind := le.corp_for_profit_ind <> ri.corp_for_profit_ind;
    SELF.Diff_corp_public_or_private_ind := le.corp_public_or_private_ind <> ri.corp_public_or_private_ind;
    SELF.Diff_corp_sic_code := le.corp_sic_code <> ri.corp_sic_code;
    SELF.Diff_corp_naic_code := le.corp_naic_code <> ri.corp_naic_code;
    SELF.Diff_corp_orig_bus_type_cd := le.corp_orig_bus_type_cd <> ri.corp_orig_bus_type_cd;
    SELF.Diff_corp_orig_bus_type_desc := le.corp_orig_bus_type_desc <> ri.corp_orig_bus_type_desc;
    SELF.Diff_corp_entity_desc := le.corp_entity_desc <> ri.corp_entity_desc;
    SELF.Diff_corp_certificate_nbr := le.corp_certificate_nbr <> ri.corp_certificate_nbr;
    SELF.Diff_corp_internal_nbr := le.corp_internal_nbr <> ri.corp_internal_nbr;
    SELF.Diff_corp_previous_nbr := le.corp_previous_nbr <> ri.corp_previous_nbr;
    SELF.Diff_corp_microfilm_nbr := le.corp_microfilm_nbr <> ri.corp_microfilm_nbr;
    SELF.Diff_corp_amendments_filed := le.corp_amendments_filed <> ri.corp_amendments_filed;
    SELF.Diff_corp_acts := le.corp_acts <> ri.corp_acts;
    SELF.Diff_corp_partnership_ind := le.corp_partnership_ind <> ri.corp_partnership_ind;
    SELF.Diff_corp_mfg_ind := le.corp_mfg_ind <> ri.corp_mfg_ind;
    SELF.Diff_corp_addl_info := le.corp_addl_info <> ri.corp_addl_info;
    SELF.Diff_corp_taxes := le.corp_taxes <> ri.corp_taxes;
    SELF.Diff_corp_franchise_taxes := le.corp_franchise_taxes <> ri.corp_franchise_taxes;
    SELF.Diff_corp_tax_program_cd := le.corp_tax_program_cd <> ri.corp_tax_program_cd;
    SELF.Diff_corp_tax_program_desc := le.corp_tax_program_desc <> ri.corp_tax_program_desc;
    SELF.Diff_corp_ra_name := le.corp_ra_name <> ri.corp_ra_name;
    SELF.Diff_corp_ra_title_cd := le.corp_ra_title_cd <> ri.corp_ra_title_cd;
    SELF.Diff_corp_ra_title_desc := le.corp_ra_title_desc <> ri.corp_ra_title_desc;
    SELF.Diff_corp_ra_fein := le.corp_ra_fein <> ri.corp_ra_fein;
    SELF.Diff_corp_ra_ssn := le.corp_ra_ssn <> ri.corp_ra_ssn;
    SELF.Diff_corp_ra_dob := le.corp_ra_dob <> ri.corp_ra_dob;
    SELF.Diff_corp_ra_effective_date := le.corp_ra_effective_date <> ri.corp_ra_effective_date;
    SELF.Diff_corp_ra_resign_date := le.corp_ra_resign_date <> ri.corp_ra_resign_date;
    SELF.Diff_corp_ra_no_comp := le.corp_ra_no_comp <> ri.corp_ra_no_comp;
    SELF.Diff_corp_ra_no_comp_igs := le.corp_ra_no_comp_igs <> ri.corp_ra_no_comp_igs;
    SELF.Diff_corp_ra_addl_info := le.corp_ra_addl_info <> ri.corp_ra_addl_info;
    SELF.Diff_corp_ra_address_type_cd := le.corp_ra_address_type_cd <> ri.corp_ra_address_type_cd;
    SELF.Diff_corp_ra_address_type_desc := le.corp_ra_address_type_desc <> ri.corp_ra_address_type_desc;
    SELF.Diff_corp_ra_address_line1 := le.corp_ra_address_line1 <> ri.corp_ra_address_line1;
    SELF.Diff_corp_ra_address_line2 := le.corp_ra_address_line2 <> ri.corp_ra_address_line2;
    SELF.Diff_corp_ra_address_line3 := le.corp_ra_address_line3 <> ri.corp_ra_address_line3;
    SELF.Diff_corp_ra_address_line4 := le.corp_ra_address_line4 <> ri.corp_ra_address_line4;
    SELF.Diff_corp_ra_address_line5 := le.corp_ra_address_line5 <> ri.corp_ra_address_line5;
    SELF.Diff_corp_ra_address_line6 := le.corp_ra_address_line6 <> ri.corp_ra_address_line6;
    SELF.Diff_corp_ra_phone_number := le.corp_ra_phone_number <> ri.corp_ra_phone_number;
    SELF.Diff_corp_ra_phone_number_type_cd := le.corp_ra_phone_number_type_cd <> ri.corp_ra_phone_number_type_cd;
    SELF.Diff_corp_ra_phone_number_type_desc := le.corp_ra_phone_number_type_desc <> ri.corp_ra_phone_number_type_desc;
    SELF.Diff_corp_ra_fax_nbr := le.corp_ra_fax_nbr <> ri.corp_ra_fax_nbr;
    SELF.Diff_corp_ra_email_address := le.corp_ra_email_address <> ri.corp_ra_email_address;
    SELF.Diff_corp_ra_web_address := le.corp_ra_web_address <> ri.corp_ra_web_address;
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
    SELF.Diff_corp_addr2_prim_range := le.corp_addr2_prim_range <> ri.corp_addr2_prim_range;
    SELF.Diff_corp_addr2_predir := le.corp_addr2_predir <> ri.corp_addr2_predir;
    SELF.Diff_corp_addr2_prim_name := le.corp_addr2_prim_name <> ri.corp_addr2_prim_name;
    SELF.Diff_corp_addr2_addr_suffix := le.corp_addr2_addr_suffix <> ri.corp_addr2_addr_suffix;
    SELF.Diff_corp_addr2_postdir := le.corp_addr2_postdir <> ri.corp_addr2_postdir;
    SELF.Diff_corp_addr2_unit_desig := le.corp_addr2_unit_desig <> ri.corp_addr2_unit_desig;
    SELF.Diff_corp_addr2_sec_range := le.corp_addr2_sec_range <> ri.corp_addr2_sec_range;
    SELF.Diff_corp_addr2_p_city_name := le.corp_addr2_p_city_name <> ri.corp_addr2_p_city_name;
    SELF.Diff_corp_addr2_v_city_name := le.corp_addr2_v_city_name <> ri.corp_addr2_v_city_name;
    SELF.Diff_corp_addr2_state := le.corp_addr2_state <> ri.corp_addr2_state;
    SELF.Diff_corp_addr2_zip5 := le.corp_addr2_zip5 <> ri.corp_addr2_zip5;
    SELF.Diff_corp_addr2_zip4 := le.corp_addr2_zip4 <> ri.corp_addr2_zip4;
    SELF.Diff_corp_addr2_cart := le.corp_addr2_cart <> ri.corp_addr2_cart;
    SELF.Diff_corp_addr2_cr_sort_sz := le.corp_addr2_cr_sort_sz <> ri.corp_addr2_cr_sort_sz;
    SELF.Diff_corp_addr2_lot := le.corp_addr2_lot <> ri.corp_addr2_lot;
    SELF.Diff_corp_addr2_lot_order := le.corp_addr2_lot_order <> ri.corp_addr2_lot_order;
    SELF.Diff_corp_addr2_dpbc := le.corp_addr2_dpbc <> ri.corp_addr2_dpbc;
    SELF.Diff_corp_addr2_chk_digit := le.corp_addr2_chk_digit <> ri.corp_addr2_chk_digit;
    SELF.Diff_corp_addr2_rec_type := le.corp_addr2_rec_type <> ri.corp_addr2_rec_type;
    SELF.Diff_corp_addr2_ace_fips_st := le.corp_addr2_ace_fips_st <> ri.corp_addr2_ace_fips_st;
    SELF.Diff_corp_addr2_county := le.corp_addr2_county <> ri.corp_addr2_county;
    SELF.Diff_corp_addr2_geo_lat := le.corp_addr2_geo_lat <> ri.corp_addr2_geo_lat;
    SELF.Diff_corp_addr2_geo_long := le.corp_addr2_geo_long <> ri.corp_addr2_geo_long;
    SELF.Diff_corp_addr2_msa := le.corp_addr2_msa <> ri.corp_addr2_msa;
    SELF.Diff_corp_addr2_geo_blk := le.corp_addr2_geo_blk <> ri.corp_addr2_geo_blk;
    SELF.Diff_corp_addr2_geo_match := le.corp_addr2_geo_match <> ri.corp_addr2_geo_match;
    SELF.Diff_corp_addr2_err_stat := le.corp_addr2_err_stat <> ri.corp_addr2_err_stat;
    SELF.Diff_corp_ra_title1 := le.corp_ra_title1 <> ri.corp_ra_title1;
    SELF.Diff_corp_ra_fname1 := le.corp_ra_fname1 <> ri.corp_ra_fname1;
    SELF.Diff_corp_ra_mname1 := le.corp_ra_mname1 <> ri.corp_ra_mname1;
    SELF.Diff_corp_ra_lname1 := le.corp_ra_lname1 <> ri.corp_ra_lname1;
    SELF.Diff_corp_ra_name_suffix1 := le.corp_ra_name_suffix1 <> ri.corp_ra_name_suffix1;
    SELF.Diff_corp_ra_score1 := le.corp_ra_score1 <> ri.corp_ra_score1;
    SELF.Diff_corp_ra_title2 := le.corp_ra_title2 <> ri.corp_ra_title2;
    SELF.Diff_corp_ra_fname2 := le.corp_ra_fname2 <> ri.corp_ra_fname2;
    SELF.Diff_corp_ra_mname2 := le.corp_ra_mname2 <> ri.corp_ra_mname2;
    SELF.Diff_corp_ra_lname2 := le.corp_ra_lname2 <> ri.corp_ra_lname2;
    SELF.Diff_corp_ra_name_suffix2 := le.corp_ra_name_suffix2 <> ri.corp_ra_name_suffix2;
    SELF.Diff_corp_ra_score2 := le.corp_ra_score2 <> ri.corp_ra_score2;
    SELF.Diff_corp_ra_cname1 := le.corp_ra_cname1 <> ri.corp_ra_cname1;
    SELF.Diff_corp_ra_cname1_score := le.corp_ra_cname1_score <> ri.corp_ra_cname1_score;
    SELF.Diff_corp_ra_cname2 := le.corp_ra_cname2 <> ri.corp_ra_cname2;
    SELF.Diff_corp_ra_cname2_score := le.corp_ra_cname2_score <> ri.corp_ra_cname2_score;
    SELF.Diff_corp_ra_prim_range := le.corp_ra_prim_range <> ri.corp_ra_prim_range;
    SELF.Diff_corp_ra_predir := le.corp_ra_predir <> ri.corp_ra_predir;
    SELF.Diff_corp_ra_prim_name := le.corp_ra_prim_name <> ri.corp_ra_prim_name;
    SELF.Diff_corp_ra_addr_suffix := le.corp_ra_addr_suffix <> ri.corp_ra_addr_suffix;
    SELF.Diff_corp_ra_postdir := le.corp_ra_postdir <> ri.corp_ra_postdir;
    SELF.Diff_corp_ra_unit_desig := le.corp_ra_unit_desig <> ri.corp_ra_unit_desig;
    SELF.Diff_corp_ra_sec_range := le.corp_ra_sec_range <> ri.corp_ra_sec_range;
    SELF.Diff_corp_ra_p_city_name := le.corp_ra_p_city_name <> ri.corp_ra_p_city_name;
    SELF.Diff_corp_ra_v_city_name := le.corp_ra_v_city_name <> ri.corp_ra_v_city_name;
    SELF.Diff_corp_ra_state := le.corp_ra_state <> ri.corp_ra_state;
    SELF.Diff_corp_ra_zip5 := le.corp_ra_zip5 <> ri.corp_ra_zip5;
    SELF.Diff_corp_ra_zip4 := le.corp_ra_zip4 <> ri.corp_ra_zip4;
    SELF.Diff_corp_ra_cart := le.corp_ra_cart <> ri.corp_ra_cart;
    SELF.Diff_corp_ra_cr_sort_sz := le.corp_ra_cr_sort_sz <> ri.corp_ra_cr_sort_sz;
    SELF.Diff_corp_ra_lot := le.corp_ra_lot <> ri.corp_ra_lot;
    SELF.Diff_corp_ra_lot_order := le.corp_ra_lot_order <> ri.corp_ra_lot_order;
    SELF.Diff_corp_ra_dpbc := le.corp_ra_dpbc <> ri.corp_ra_dpbc;
    SELF.Diff_corp_ra_chk_digit := le.corp_ra_chk_digit <> ri.corp_ra_chk_digit;
    SELF.Diff_corp_ra_rec_type := le.corp_ra_rec_type <> ri.corp_ra_rec_type;
    SELF.Diff_corp_ra_ace_fips_st := le.corp_ra_ace_fips_st <> ri.corp_ra_ace_fips_st;
    SELF.Diff_corp_ra_county := le.corp_ra_county <> ri.corp_ra_county;
    SELF.Diff_corp_ra_geo_lat := le.corp_ra_geo_lat <> ri.corp_ra_geo_lat;
    SELF.Diff_corp_ra_geo_long := le.corp_ra_geo_long <> ri.corp_ra_geo_long;
    SELF.Diff_corp_ra_msa := le.corp_ra_msa <> ri.corp_ra_msa;
    SELF.Diff_corp_ra_geo_blk := le.corp_ra_geo_blk <> ri.corp_ra_geo_blk;
    SELF.Diff_corp_ra_geo_match := le.corp_ra_geo_match <> ri.corp_ra_geo_match;
    SELF.Diff_corp_ra_err_stat := le.corp_ra_err_stat <> ri.corp_ra_err_stat;
    SELF.Diff_corp_phone10 := le.corp_phone10 <> ri.corp_phone10;
    SELF.Diff_corp_ra_phone10 := le.corp_ra_phone10 <> ri.corp_ra_phone10;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_append_addr1_rawaid := le.append_addr1_rawaid <> ri.append_addr1_rawaid;
    SELF.Diff_append_addr1_aceaid := le.append_addr1_aceaid <> ri.append_addr1_aceaid;
    SELF.Diff_corp_prep_addr1_line1 := le.corp_prep_addr1_line1 <> ri.corp_prep_addr1_line1;
    SELF.Diff_corp_prep_addr1_last_line := le.corp_prep_addr1_last_line <> ri.corp_prep_addr1_last_line;
    SELF.Diff_append_addr2_rawaid := le.append_addr2_rawaid <> ri.append_addr2_rawaid;
    SELF.Diff_append_addr2_aceaid := le.append_addr2_aceaid <> ri.append_addr2_aceaid;
    SELF.Diff_corp_prep_addr2_line1 := le.corp_prep_addr2_line1 <> ri.corp_prep_addr2_line1;
    SELF.Diff_corp_prep_addr2_last_line := le.corp_prep_addr2_last_line <> ri.corp_prep_addr2_last_line;
    SELF.Diff_append_ra_rawaid := le.append_ra_rawaid <> ri.append_ra_rawaid;
    SELF.Diff_append_ra_aceaid := le.append_ra_aceaid <> ri.append_ra_aceaid;
    SELF.Diff_ra_prep_addr_line1 := le.ra_prep_addr_line1 <> ri.ra_prep_addr_line1;
    SELF.Diff_ra_prep_addr_last_line := le.ra_prep_addr_last_line <> ri.ra_prep_addr_last_line;
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
    SELF.Num_Diffs := 0+ IF( SELF.Diff_source_rec_id,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_corp_ra_dt_first_seen,1,0)+ IF( SELF.Diff_corp_ra_dt_last_seen,1,0)+ IF( SELF.Diff_corp_key,1,0)+ IF( SELF.Diff_corp_supp_key,1,0)+ IF( SELF.Diff_corp_vendor,1,0)+ IF( SELF.Diff_corp_vendor_county,1,0)+ IF( SELF.Diff_corp_vendor_subcode,1,0)+ IF( SELF.Diff_corp_state_origin,1,0)+ IF( SELF.Diff_corp_process_date,1,0)+ IF( SELF.Diff_corp_orig_sos_charter_nbr,1,0)+ IF( SELF.Diff_corp_sos_charter_nbr,1,0)+ IF( SELF.Diff_corp_src_type,1,0)+ IF( SELF.Diff_corp_legal_name,1,0)+ IF( SELF.Diff_corp_ln_name_type_cd,1,0)+ IF( SELF.Diff_corp_ln_name_type_desc,1,0)+ IF( SELF.Diff_corp_supp_nbr,1,0)+ IF( SELF.Diff_corp_name_comment,1,0)+ IF( SELF.Diff_corp_address1_type_cd,1,0)+ IF( SELF.Diff_corp_address1_type_desc,1,0)+ IF( SELF.Diff_corp_address1_line1,1,0)+ IF( SELF.Diff_corp_address1_line2,1,0)+ IF( SELF.Diff_corp_address1_line3,1,0)+ IF( SELF.Diff_corp_address1_line4,1,0)+ IF( SELF.Diff_corp_address1_line5,1,0)+ IF( SELF.Diff_corp_address1_line6,1,0)+ IF( SELF.Diff_corp_address1_effective_date,1,0)+ IF( SELF.Diff_corp_address2_type_cd,1,0)+ IF( SELF.Diff_corp_address2_type_desc,1,0)+ IF( SELF.Diff_corp_address2_line1,1,0)+ IF( SELF.Diff_corp_address2_line2,1,0)+ IF( SELF.Diff_corp_address2_line3,1,0)+ IF( SELF.Diff_corp_address2_line4,1,0)+ IF( SELF.Diff_corp_address2_line5,1,0)+ IF( SELF.Diff_corp_address2_line6,1,0)+ IF( SELF.Diff_corp_address2_effective_date,1,0)+ IF( SELF.Diff_corp_phone_number,1,0)+ IF( SELF.Diff_corp_phone_number_type_cd,1,0)+ IF( SELF.Diff_corp_phone_number_type_desc,1,0)+ IF( SELF.Diff_corp_fax_nbr,1,0)+ IF( SELF.Diff_corp_email_address,1,0)+ IF( SELF.Diff_corp_web_address,1,0)+ IF( SELF.Diff_corp_filing_reference_nbr,1,0)+ IF( SELF.Diff_corp_filing_date,1,0)+ IF( SELF.Diff_corp_filing_cd,1,0)+ IF( SELF.Diff_corp_filing_desc,1,0)+ IF( SELF.Diff_corp_status_cd,1,0)+ IF( SELF.Diff_corp_status_desc,1,0)+ IF( SELF.Diff_corp_status_date,1,0)+ IF( SELF.Diff_corp_standing,1,0)+ IF( SELF.Diff_corp_status_comment,1,0)+ IF( SELF.Diff_corp_ticker_symbol,1,0)+ IF( SELF.Diff_corp_stock_exchange,1,0)+ IF( SELF.Diff_corp_inc_state,1,0)+ IF( SELF.Diff_corp_inc_county,1,0)+ IF( SELF.Diff_corp_inc_date,1,0)+ IF( SELF.Diff_corp_anniversary_month,1,0)+ IF( SELF.Diff_corp_fed_tax_id,1,0)+ IF( SELF.Diff_corp_state_tax_id,1,0)+ IF( SELF.Diff_corp_term_exist_cd,1,0)+ IF( SELF.Diff_corp_term_exist_exp,1,0)+ IF( SELF.Diff_corp_term_exist_desc,1,0)+ IF( SELF.Diff_corp_foreign_domestic_ind,1,0)+ IF( SELF.Diff_corp_forgn_state_cd,1,0)+ IF( SELF.Diff_corp_forgn_state_desc,1,0)+ IF( SELF.Diff_corp_forgn_sos_charter_nbr,1,0)+ IF( SELF.Diff_corp_forgn_date,1,0)+ IF( SELF.Diff_corp_forgn_fed_tax_id,1,0)+ IF( SELF.Diff_corp_forgn_state_tax_id,1,0)+ IF( SELF.Diff_corp_forgn_term_exist_cd,1,0)+ IF( SELF.Diff_corp_forgn_term_exist_exp,1,0)+ IF( SELF.Diff_corp_forgn_term_exist_desc,1,0)+ IF( SELF.Diff_corp_orig_org_structure_cd,1,0)+ IF( SELF.Diff_corp_orig_org_structure_desc,1,0)+ IF( SELF.Diff_corp_for_profit_ind,1,0)+ IF( SELF.Diff_corp_public_or_private_ind,1,0)+ IF( SELF.Diff_corp_sic_code,1,0)+ IF( SELF.Diff_corp_naic_code,1,0)+ IF( SELF.Diff_corp_orig_bus_type_cd,1,0)+ IF( SELF.Diff_corp_orig_bus_type_desc,1,0)+ IF( SELF.Diff_corp_entity_desc,1,0)+ IF( SELF.Diff_corp_certificate_nbr,1,0)+ IF( SELF.Diff_corp_internal_nbr,1,0)+ IF( SELF.Diff_corp_previous_nbr,1,0)+ IF( SELF.Diff_corp_microfilm_nbr,1,0)+ IF( SELF.Diff_corp_amendments_filed,1,0)+ IF( SELF.Diff_corp_acts,1,0)+ IF( SELF.Diff_corp_partnership_ind,1,0)+ IF( SELF.Diff_corp_mfg_ind,1,0)+ IF( SELF.Diff_corp_addl_info,1,0)+ IF( SELF.Diff_corp_taxes,1,0)+ IF( SELF.Diff_corp_franchise_taxes,1,0)+ IF( SELF.Diff_corp_tax_program_cd,1,0)+ IF( SELF.Diff_corp_tax_program_desc,1,0)+ IF( SELF.Diff_corp_ra_name,1,0)+ IF( SELF.Diff_corp_ra_title_cd,1,0)+ IF( SELF.Diff_corp_ra_title_desc,1,0)+ IF( SELF.Diff_corp_ra_fein,1,0)+ IF( SELF.Diff_corp_ra_ssn,1,0)+ IF( SELF.Diff_corp_ra_dob,1,0)+ IF( SELF.Diff_corp_ra_effective_date,1,0)+ IF( SELF.Diff_corp_ra_resign_date,1,0)+ IF( SELF.Diff_corp_ra_no_comp,1,0)+ IF( SELF.Diff_corp_ra_no_comp_igs,1,0)+ IF( SELF.Diff_corp_ra_addl_info,1,0)+ IF( SELF.Diff_corp_ra_address_type_cd,1,0)+ IF( SELF.Diff_corp_ra_address_type_desc,1,0)+ IF( SELF.Diff_corp_ra_address_line1,1,0)+ IF( SELF.Diff_corp_ra_address_line2,1,0)+ IF( SELF.Diff_corp_ra_address_line3,1,0)+ IF( SELF.Diff_corp_ra_address_line4,1,0)+ IF( SELF.Diff_corp_ra_address_line5,1,0)+ IF( SELF.Diff_corp_ra_address_line6,1,0)+ IF( SELF.Diff_corp_ra_phone_number,1,0)+ IF( SELF.Diff_corp_ra_phone_number_type_cd,1,0)+ IF( SELF.Diff_corp_ra_phone_number_type_desc,1,0)+ IF( SELF.Diff_corp_ra_fax_nbr,1,0)+ IF( SELF.Diff_corp_ra_email_address,1,0)+ IF( SELF.Diff_corp_ra_web_address,1,0)+ IF( SELF.Diff_corp_addr1_prim_range,1,0)+ IF( SELF.Diff_corp_addr1_predir,1,0)+ IF( SELF.Diff_corp_addr1_prim_name,1,0)+ IF( SELF.Diff_corp_addr1_addr_suffix,1,0)+ IF( SELF.Diff_corp_addr1_postdir,1,0)+ IF( SELF.Diff_corp_addr1_unit_desig,1,0)+ IF( SELF.Diff_corp_addr1_sec_range,1,0)+ IF( SELF.Diff_corp_addr1_p_city_name,1,0)+ IF( SELF.Diff_corp_addr1_v_city_name,1,0)+ IF( SELF.Diff_corp_addr1_state,1,0)+ IF( SELF.Diff_corp_addr1_zip5,1,0)+ IF( SELF.Diff_corp_addr1_zip4,1,0)+ IF( SELF.Diff_corp_addr1_cart,1,0)+ IF( SELF.Diff_corp_addr1_cr_sort_sz,1,0)+ IF( SELF.Diff_corp_addr1_lot,1,0)+ IF( SELF.Diff_corp_addr1_lot_order,1,0)+ IF( SELF.Diff_corp_addr1_dpbc,1,0)+ IF( SELF.Diff_corp_addr1_chk_digit,1,0)+ IF( SELF.Diff_corp_addr1_rec_type,1,0)+ IF( SELF.Diff_corp_addr1_ace_fips_st,1,0)+ IF( SELF.Diff_corp_addr1_county,1,0)+ IF( SELF.Diff_corp_addr1_geo_lat,1,0)+ IF( SELF.Diff_corp_addr1_geo_long,1,0)+ IF( SELF.Diff_corp_addr1_msa,1,0)+ IF( SELF.Diff_corp_addr1_geo_blk,1,0)+ IF( SELF.Diff_corp_addr1_geo_match,1,0)+ IF( SELF.Diff_corp_addr1_err_stat,1,0)+ IF( SELF.Diff_corp_addr2_prim_range,1,0)+ IF( SELF.Diff_corp_addr2_predir,1,0)+ IF( SELF.Diff_corp_addr2_prim_name,1,0)+ IF( SELF.Diff_corp_addr2_addr_suffix,1,0)+ IF( SELF.Diff_corp_addr2_postdir,1,0)+ IF( SELF.Diff_corp_addr2_unit_desig,1,0)+ IF( SELF.Diff_corp_addr2_sec_range,1,0)+ IF( SELF.Diff_corp_addr2_p_city_name,1,0)+ IF( SELF.Diff_corp_addr2_v_city_name,1,0)+ IF( SELF.Diff_corp_addr2_state,1,0)+ IF( SELF.Diff_corp_addr2_zip5,1,0)+ IF( SELF.Diff_corp_addr2_zip4,1,0)+ IF( SELF.Diff_corp_addr2_cart,1,0)+ IF( SELF.Diff_corp_addr2_cr_sort_sz,1,0)+ IF( SELF.Diff_corp_addr2_lot,1,0)+ IF( SELF.Diff_corp_addr2_lot_order,1,0)+ IF( SELF.Diff_corp_addr2_dpbc,1,0)+ IF( SELF.Diff_corp_addr2_chk_digit,1,0)+ IF( SELF.Diff_corp_addr2_rec_type,1,0)+ IF( SELF.Diff_corp_addr2_ace_fips_st,1,0)+ IF( SELF.Diff_corp_addr2_county,1,0)+ IF( SELF.Diff_corp_addr2_geo_lat,1,0)+ IF( SELF.Diff_corp_addr2_geo_long,1,0)+ IF( SELF.Diff_corp_addr2_msa,1,0)+ IF( SELF.Diff_corp_addr2_geo_blk,1,0)+ IF( SELF.Diff_corp_addr2_geo_match,1,0)+ IF( SELF.Diff_corp_addr2_err_stat,1,0)+ IF( SELF.Diff_corp_ra_title1,1,0)+ IF( SELF.Diff_corp_ra_fname1,1,0)+ IF( SELF.Diff_corp_ra_mname1,1,0)+ IF( SELF.Diff_corp_ra_lname1,1,0)+ IF( SELF.Diff_corp_ra_name_suffix1,1,0)+ IF( SELF.Diff_corp_ra_score1,1,0)+ IF( SELF.Diff_corp_ra_title2,1,0)+ IF( SELF.Diff_corp_ra_fname2,1,0)+ IF( SELF.Diff_corp_ra_mname2,1,0)+ IF( SELF.Diff_corp_ra_lname2,1,0)+ IF( SELF.Diff_corp_ra_name_suffix2,1,0)+ IF( SELF.Diff_corp_ra_score2,1,0)+ IF( SELF.Diff_corp_ra_cname1,1,0)+ IF( SELF.Diff_corp_ra_cname1_score,1,0)+ IF( SELF.Diff_corp_ra_cname2,1,0)+ IF( SELF.Diff_corp_ra_cname2_score,1,0)+ IF( SELF.Diff_corp_ra_prim_range,1,0)+ IF( SELF.Diff_corp_ra_predir,1,0)+ IF( SELF.Diff_corp_ra_prim_name,1,0)+ IF( SELF.Diff_corp_ra_addr_suffix,1,0)+ IF( SELF.Diff_corp_ra_postdir,1,0)+ IF( SELF.Diff_corp_ra_unit_desig,1,0)+ IF( SELF.Diff_corp_ra_sec_range,1,0)+ IF( SELF.Diff_corp_ra_p_city_name,1,0)+ IF( SELF.Diff_corp_ra_v_city_name,1,0)+ IF( SELF.Diff_corp_ra_state,1,0)+ IF( SELF.Diff_corp_ra_zip5,1,0)+ IF( SELF.Diff_corp_ra_zip4,1,0)+ IF( SELF.Diff_corp_ra_cart,1,0)+ IF( SELF.Diff_corp_ra_cr_sort_sz,1,0)+ IF( SELF.Diff_corp_ra_lot,1,0)+ IF( SELF.Diff_corp_ra_lot_order,1,0)+ IF( SELF.Diff_corp_ra_dpbc,1,0)+ IF( SELF.Diff_corp_ra_chk_digit,1,0)+ IF( SELF.Diff_corp_ra_rec_type,1,0)+ IF( SELF.Diff_corp_ra_ace_fips_st,1,0)+ IF( SELF.Diff_corp_ra_county,1,0)+ IF( SELF.Diff_corp_ra_geo_lat,1,0)+ IF( SELF.Diff_corp_ra_geo_long,1,0)+ IF( SELF.Diff_corp_ra_msa,1,0)+ IF( SELF.Diff_corp_ra_geo_blk,1,0)+ IF( SELF.Diff_corp_ra_geo_match,1,0)+ IF( SELF.Diff_corp_ra_err_stat,1,0)+ IF( SELF.Diff_corp_phone10,1,0)+ IF( SELF.Diff_corp_ra_phone10,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_append_addr1_rawaid,1,0)+ IF( SELF.Diff_append_addr1_aceaid,1,0)+ IF( SELF.Diff_corp_prep_addr1_line1,1,0)+ IF( SELF.Diff_corp_prep_addr1_last_line,1,0)+ IF( SELF.Diff_append_addr2_rawaid,1,0)+ IF( SELF.Diff_append_addr2_aceaid,1,0)+ IF( SELF.Diff_corp_prep_addr2_line1,1,0)+ IF( SELF.Diff_corp_prep_addr2_last_line,1,0)+ IF( SELF.Diff_append_ra_rawaid,1,0)+ IF( SELF.Diff_append_ra_aceaid,1,0)+ IF( SELF.Diff_ra_prep_addr_line1,1,0)+ IF( SELF.Diff_ra_prep_addr_last_line,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0);
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
    Count_Diff_source_rec_id := COUNT(GROUP,%Closest%.Diff_source_rec_id);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_corp_ra_dt_first_seen := COUNT(GROUP,%Closest%.Diff_corp_ra_dt_first_seen);
    Count_Diff_corp_ra_dt_last_seen := COUNT(GROUP,%Closest%.Diff_corp_ra_dt_last_seen);
    Count_Diff_corp_key := COUNT(GROUP,%Closest%.Diff_corp_key);
    Count_Diff_corp_supp_key := COUNT(GROUP,%Closest%.Diff_corp_supp_key);
    Count_Diff_corp_vendor := COUNT(GROUP,%Closest%.Diff_corp_vendor);
    Count_Diff_corp_vendor_county := COUNT(GROUP,%Closest%.Diff_corp_vendor_county);
    Count_Diff_corp_vendor_subcode := COUNT(GROUP,%Closest%.Diff_corp_vendor_subcode);
    Count_Diff_corp_state_origin := COUNT(GROUP,%Closest%.Diff_corp_state_origin);
    Count_Diff_corp_process_date := COUNT(GROUP,%Closest%.Diff_corp_process_date);
    Count_Diff_corp_orig_sos_charter_nbr := COUNT(GROUP,%Closest%.Diff_corp_orig_sos_charter_nbr);
    Count_Diff_corp_sos_charter_nbr := COUNT(GROUP,%Closest%.Diff_corp_sos_charter_nbr);
    Count_Diff_corp_src_type := COUNT(GROUP,%Closest%.Diff_corp_src_type);
    Count_Diff_corp_legal_name := COUNT(GROUP,%Closest%.Diff_corp_legal_name);
    Count_Diff_corp_ln_name_type_cd := COUNT(GROUP,%Closest%.Diff_corp_ln_name_type_cd);
    Count_Diff_corp_ln_name_type_desc := COUNT(GROUP,%Closest%.Diff_corp_ln_name_type_desc);
    Count_Diff_corp_supp_nbr := COUNT(GROUP,%Closest%.Diff_corp_supp_nbr);
    Count_Diff_corp_name_comment := COUNT(GROUP,%Closest%.Diff_corp_name_comment);
    Count_Diff_corp_address1_type_cd := COUNT(GROUP,%Closest%.Diff_corp_address1_type_cd);
    Count_Diff_corp_address1_type_desc := COUNT(GROUP,%Closest%.Diff_corp_address1_type_desc);
    Count_Diff_corp_address1_line1 := COUNT(GROUP,%Closest%.Diff_corp_address1_line1);
    Count_Diff_corp_address1_line2 := COUNT(GROUP,%Closest%.Diff_corp_address1_line2);
    Count_Diff_corp_address1_line3 := COUNT(GROUP,%Closest%.Diff_corp_address1_line3);
    Count_Diff_corp_address1_line4 := COUNT(GROUP,%Closest%.Diff_corp_address1_line4);
    Count_Diff_corp_address1_line5 := COUNT(GROUP,%Closest%.Diff_corp_address1_line5);
    Count_Diff_corp_address1_line6 := COUNT(GROUP,%Closest%.Diff_corp_address1_line6);
    Count_Diff_corp_address1_effective_date := COUNT(GROUP,%Closest%.Diff_corp_address1_effective_date);
    Count_Diff_corp_address2_type_cd := COUNT(GROUP,%Closest%.Diff_corp_address2_type_cd);
    Count_Diff_corp_address2_type_desc := COUNT(GROUP,%Closest%.Diff_corp_address2_type_desc);
    Count_Diff_corp_address2_line1 := COUNT(GROUP,%Closest%.Diff_corp_address2_line1);
    Count_Diff_corp_address2_line2 := COUNT(GROUP,%Closest%.Diff_corp_address2_line2);
    Count_Diff_corp_address2_line3 := COUNT(GROUP,%Closest%.Diff_corp_address2_line3);
    Count_Diff_corp_address2_line4 := COUNT(GROUP,%Closest%.Diff_corp_address2_line4);
    Count_Diff_corp_address2_line5 := COUNT(GROUP,%Closest%.Diff_corp_address2_line5);
    Count_Diff_corp_address2_line6 := COUNT(GROUP,%Closest%.Diff_corp_address2_line6);
    Count_Diff_corp_address2_effective_date := COUNT(GROUP,%Closest%.Diff_corp_address2_effective_date);
    Count_Diff_corp_phone_number := COUNT(GROUP,%Closest%.Diff_corp_phone_number);
    Count_Diff_corp_phone_number_type_cd := COUNT(GROUP,%Closest%.Diff_corp_phone_number_type_cd);
    Count_Diff_corp_phone_number_type_desc := COUNT(GROUP,%Closest%.Diff_corp_phone_number_type_desc);
    Count_Diff_corp_fax_nbr := COUNT(GROUP,%Closest%.Diff_corp_fax_nbr);
    Count_Diff_corp_email_address := COUNT(GROUP,%Closest%.Diff_corp_email_address);
    Count_Diff_corp_web_address := COUNT(GROUP,%Closest%.Diff_corp_web_address);
    Count_Diff_corp_filing_reference_nbr := COUNT(GROUP,%Closest%.Diff_corp_filing_reference_nbr);
    Count_Diff_corp_filing_date := COUNT(GROUP,%Closest%.Diff_corp_filing_date);
    Count_Diff_corp_filing_cd := COUNT(GROUP,%Closest%.Diff_corp_filing_cd);
    Count_Diff_corp_filing_desc := COUNT(GROUP,%Closest%.Diff_corp_filing_desc);
    Count_Diff_corp_status_cd := COUNT(GROUP,%Closest%.Diff_corp_status_cd);
    Count_Diff_corp_status_desc := COUNT(GROUP,%Closest%.Diff_corp_status_desc);
    Count_Diff_corp_status_date := COUNT(GROUP,%Closest%.Diff_corp_status_date);
    Count_Diff_corp_standing := COUNT(GROUP,%Closest%.Diff_corp_standing);
    Count_Diff_corp_status_comment := COUNT(GROUP,%Closest%.Diff_corp_status_comment);
    Count_Diff_corp_ticker_symbol := COUNT(GROUP,%Closest%.Diff_corp_ticker_symbol);
    Count_Diff_corp_stock_exchange := COUNT(GROUP,%Closest%.Diff_corp_stock_exchange);
    Count_Diff_corp_inc_state := COUNT(GROUP,%Closest%.Diff_corp_inc_state);
    Count_Diff_corp_inc_county := COUNT(GROUP,%Closest%.Diff_corp_inc_county);
    Count_Diff_corp_inc_date := COUNT(GROUP,%Closest%.Diff_corp_inc_date);
    Count_Diff_corp_anniversary_month := COUNT(GROUP,%Closest%.Diff_corp_anniversary_month);
    Count_Diff_corp_fed_tax_id := COUNT(GROUP,%Closest%.Diff_corp_fed_tax_id);
    Count_Diff_corp_state_tax_id := COUNT(GROUP,%Closest%.Diff_corp_state_tax_id);
    Count_Diff_corp_term_exist_cd := COUNT(GROUP,%Closest%.Diff_corp_term_exist_cd);
    Count_Diff_corp_term_exist_exp := COUNT(GROUP,%Closest%.Diff_corp_term_exist_exp);
    Count_Diff_corp_term_exist_desc := COUNT(GROUP,%Closest%.Diff_corp_term_exist_desc);
    Count_Diff_corp_foreign_domestic_ind := COUNT(GROUP,%Closest%.Diff_corp_foreign_domestic_ind);
    Count_Diff_corp_forgn_state_cd := COUNT(GROUP,%Closest%.Diff_corp_forgn_state_cd);
    Count_Diff_corp_forgn_state_desc := COUNT(GROUP,%Closest%.Diff_corp_forgn_state_desc);
    Count_Diff_corp_forgn_sos_charter_nbr := COUNT(GROUP,%Closest%.Diff_corp_forgn_sos_charter_nbr);
    Count_Diff_corp_forgn_date := COUNT(GROUP,%Closest%.Diff_corp_forgn_date);
    Count_Diff_corp_forgn_fed_tax_id := COUNT(GROUP,%Closest%.Diff_corp_forgn_fed_tax_id);
    Count_Diff_corp_forgn_state_tax_id := COUNT(GROUP,%Closest%.Diff_corp_forgn_state_tax_id);
    Count_Diff_corp_forgn_term_exist_cd := COUNT(GROUP,%Closest%.Diff_corp_forgn_term_exist_cd);
    Count_Diff_corp_forgn_term_exist_exp := COUNT(GROUP,%Closest%.Diff_corp_forgn_term_exist_exp);
    Count_Diff_corp_forgn_term_exist_desc := COUNT(GROUP,%Closest%.Diff_corp_forgn_term_exist_desc);
    Count_Diff_corp_orig_org_structure_cd := COUNT(GROUP,%Closest%.Diff_corp_orig_org_structure_cd);
    Count_Diff_corp_orig_org_structure_desc := COUNT(GROUP,%Closest%.Diff_corp_orig_org_structure_desc);
    Count_Diff_corp_for_profit_ind := COUNT(GROUP,%Closest%.Diff_corp_for_profit_ind);
    Count_Diff_corp_public_or_private_ind := COUNT(GROUP,%Closest%.Diff_corp_public_or_private_ind);
    Count_Diff_corp_sic_code := COUNT(GROUP,%Closest%.Diff_corp_sic_code);
    Count_Diff_corp_naic_code := COUNT(GROUP,%Closest%.Diff_corp_naic_code);
    Count_Diff_corp_orig_bus_type_cd := COUNT(GROUP,%Closest%.Diff_corp_orig_bus_type_cd);
    Count_Diff_corp_orig_bus_type_desc := COUNT(GROUP,%Closest%.Diff_corp_orig_bus_type_desc);
    Count_Diff_corp_entity_desc := COUNT(GROUP,%Closest%.Diff_corp_entity_desc);
    Count_Diff_corp_certificate_nbr := COUNT(GROUP,%Closest%.Diff_corp_certificate_nbr);
    Count_Diff_corp_internal_nbr := COUNT(GROUP,%Closest%.Diff_corp_internal_nbr);
    Count_Diff_corp_previous_nbr := COUNT(GROUP,%Closest%.Diff_corp_previous_nbr);
    Count_Diff_corp_microfilm_nbr := COUNT(GROUP,%Closest%.Diff_corp_microfilm_nbr);
    Count_Diff_corp_amendments_filed := COUNT(GROUP,%Closest%.Diff_corp_amendments_filed);
    Count_Diff_corp_acts := COUNT(GROUP,%Closest%.Diff_corp_acts);
    Count_Diff_corp_partnership_ind := COUNT(GROUP,%Closest%.Diff_corp_partnership_ind);
    Count_Diff_corp_mfg_ind := COUNT(GROUP,%Closest%.Diff_corp_mfg_ind);
    Count_Diff_corp_addl_info := COUNT(GROUP,%Closest%.Diff_corp_addl_info);
    Count_Diff_corp_taxes := COUNT(GROUP,%Closest%.Diff_corp_taxes);
    Count_Diff_corp_franchise_taxes := COUNT(GROUP,%Closest%.Diff_corp_franchise_taxes);
    Count_Diff_corp_tax_program_cd := COUNT(GROUP,%Closest%.Diff_corp_tax_program_cd);
    Count_Diff_corp_tax_program_desc := COUNT(GROUP,%Closest%.Diff_corp_tax_program_desc);
    Count_Diff_corp_ra_name := COUNT(GROUP,%Closest%.Diff_corp_ra_name);
    Count_Diff_corp_ra_title_cd := COUNT(GROUP,%Closest%.Diff_corp_ra_title_cd);
    Count_Diff_corp_ra_title_desc := COUNT(GROUP,%Closest%.Diff_corp_ra_title_desc);
    Count_Diff_corp_ra_fein := COUNT(GROUP,%Closest%.Diff_corp_ra_fein);
    Count_Diff_corp_ra_ssn := COUNT(GROUP,%Closest%.Diff_corp_ra_ssn);
    Count_Diff_corp_ra_dob := COUNT(GROUP,%Closest%.Diff_corp_ra_dob);
    Count_Diff_corp_ra_effective_date := COUNT(GROUP,%Closest%.Diff_corp_ra_effective_date);
    Count_Diff_corp_ra_resign_date := COUNT(GROUP,%Closest%.Diff_corp_ra_resign_date);
    Count_Diff_corp_ra_no_comp := COUNT(GROUP,%Closest%.Diff_corp_ra_no_comp);
    Count_Diff_corp_ra_no_comp_igs := COUNT(GROUP,%Closest%.Diff_corp_ra_no_comp_igs);
    Count_Diff_corp_ra_addl_info := COUNT(GROUP,%Closest%.Diff_corp_ra_addl_info);
    Count_Diff_corp_ra_address_type_cd := COUNT(GROUP,%Closest%.Diff_corp_ra_address_type_cd);
    Count_Diff_corp_ra_address_type_desc := COUNT(GROUP,%Closest%.Diff_corp_ra_address_type_desc);
    Count_Diff_corp_ra_address_line1 := COUNT(GROUP,%Closest%.Diff_corp_ra_address_line1);
    Count_Diff_corp_ra_address_line2 := COUNT(GROUP,%Closest%.Diff_corp_ra_address_line2);
    Count_Diff_corp_ra_address_line3 := COUNT(GROUP,%Closest%.Diff_corp_ra_address_line3);
    Count_Diff_corp_ra_address_line4 := COUNT(GROUP,%Closest%.Diff_corp_ra_address_line4);
    Count_Diff_corp_ra_address_line5 := COUNT(GROUP,%Closest%.Diff_corp_ra_address_line5);
    Count_Diff_corp_ra_address_line6 := COUNT(GROUP,%Closest%.Diff_corp_ra_address_line6);
    Count_Diff_corp_ra_phone_number := COUNT(GROUP,%Closest%.Diff_corp_ra_phone_number);
    Count_Diff_corp_ra_phone_number_type_cd := COUNT(GROUP,%Closest%.Diff_corp_ra_phone_number_type_cd);
    Count_Diff_corp_ra_phone_number_type_desc := COUNT(GROUP,%Closest%.Diff_corp_ra_phone_number_type_desc);
    Count_Diff_corp_ra_fax_nbr := COUNT(GROUP,%Closest%.Diff_corp_ra_fax_nbr);
    Count_Diff_corp_ra_email_address := COUNT(GROUP,%Closest%.Diff_corp_ra_email_address);
    Count_Diff_corp_ra_web_address := COUNT(GROUP,%Closest%.Diff_corp_ra_web_address);
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
    Count_Diff_corp_addr2_prim_range := COUNT(GROUP,%Closest%.Diff_corp_addr2_prim_range);
    Count_Diff_corp_addr2_predir := COUNT(GROUP,%Closest%.Diff_corp_addr2_predir);
    Count_Diff_corp_addr2_prim_name := COUNT(GROUP,%Closest%.Diff_corp_addr2_prim_name);
    Count_Diff_corp_addr2_addr_suffix := COUNT(GROUP,%Closest%.Diff_corp_addr2_addr_suffix);
    Count_Diff_corp_addr2_postdir := COUNT(GROUP,%Closest%.Diff_corp_addr2_postdir);
    Count_Diff_corp_addr2_unit_desig := COUNT(GROUP,%Closest%.Diff_corp_addr2_unit_desig);
    Count_Diff_corp_addr2_sec_range := COUNT(GROUP,%Closest%.Diff_corp_addr2_sec_range);
    Count_Diff_corp_addr2_p_city_name := COUNT(GROUP,%Closest%.Diff_corp_addr2_p_city_name);
    Count_Diff_corp_addr2_v_city_name := COUNT(GROUP,%Closest%.Diff_corp_addr2_v_city_name);
    Count_Diff_corp_addr2_state := COUNT(GROUP,%Closest%.Diff_corp_addr2_state);
    Count_Diff_corp_addr2_zip5 := COUNT(GROUP,%Closest%.Diff_corp_addr2_zip5);
    Count_Diff_corp_addr2_zip4 := COUNT(GROUP,%Closest%.Diff_corp_addr2_zip4);
    Count_Diff_corp_addr2_cart := COUNT(GROUP,%Closest%.Diff_corp_addr2_cart);
    Count_Diff_corp_addr2_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_corp_addr2_cr_sort_sz);
    Count_Diff_corp_addr2_lot := COUNT(GROUP,%Closest%.Diff_corp_addr2_lot);
    Count_Diff_corp_addr2_lot_order := COUNT(GROUP,%Closest%.Diff_corp_addr2_lot_order);
    Count_Diff_corp_addr2_dpbc := COUNT(GROUP,%Closest%.Diff_corp_addr2_dpbc);
    Count_Diff_corp_addr2_chk_digit := COUNT(GROUP,%Closest%.Diff_corp_addr2_chk_digit);
    Count_Diff_corp_addr2_rec_type := COUNT(GROUP,%Closest%.Diff_corp_addr2_rec_type);
    Count_Diff_corp_addr2_ace_fips_st := COUNT(GROUP,%Closest%.Diff_corp_addr2_ace_fips_st);
    Count_Diff_corp_addr2_county := COUNT(GROUP,%Closest%.Diff_corp_addr2_county);
    Count_Diff_corp_addr2_geo_lat := COUNT(GROUP,%Closest%.Diff_corp_addr2_geo_lat);
    Count_Diff_corp_addr2_geo_long := COUNT(GROUP,%Closest%.Diff_corp_addr2_geo_long);
    Count_Diff_corp_addr2_msa := COUNT(GROUP,%Closest%.Diff_corp_addr2_msa);
    Count_Diff_corp_addr2_geo_blk := COUNT(GROUP,%Closest%.Diff_corp_addr2_geo_blk);
    Count_Diff_corp_addr2_geo_match := COUNT(GROUP,%Closest%.Diff_corp_addr2_geo_match);
    Count_Diff_corp_addr2_err_stat := COUNT(GROUP,%Closest%.Diff_corp_addr2_err_stat);
    Count_Diff_corp_ra_title1 := COUNT(GROUP,%Closest%.Diff_corp_ra_title1);
    Count_Diff_corp_ra_fname1 := COUNT(GROUP,%Closest%.Diff_corp_ra_fname1);
    Count_Diff_corp_ra_mname1 := COUNT(GROUP,%Closest%.Diff_corp_ra_mname1);
    Count_Diff_corp_ra_lname1 := COUNT(GROUP,%Closest%.Diff_corp_ra_lname1);
    Count_Diff_corp_ra_name_suffix1 := COUNT(GROUP,%Closest%.Diff_corp_ra_name_suffix1);
    Count_Diff_corp_ra_score1 := COUNT(GROUP,%Closest%.Diff_corp_ra_score1);
    Count_Diff_corp_ra_title2 := COUNT(GROUP,%Closest%.Diff_corp_ra_title2);
    Count_Diff_corp_ra_fname2 := COUNT(GROUP,%Closest%.Diff_corp_ra_fname2);
    Count_Diff_corp_ra_mname2 := COUNT(GROUP,%Closest%.Diff_corp_ra_mname2);
    Count_Diff_corp_ra_lname2 := COUNT(GROUP,%Closest%.Diff_corp_ra_lname2);
    Count_Diff_corp_ra_name_suffix2 := COUNT(GROUP,%Closest%.Diff_corp_ra_name_suffix2);
    Count_Diff_corp_ra_score2 := COUNT(GROUP,%Closest%.Diff_corp_ra_score2);
    Count_Diff_corp_ra_cname1 := COUNT(GROUP,%Closest%.Diff_corp_ra_cname1);
    Count_Diff_corp_ra_cname1_score := COUNT(GROUP,%Closest%.Diff_corp_ra_cname1_score);
    Count_Diff_corp_ra_cname2 := COUNT(GROUP,%Closest%.Diff_corp_ra_cname2);
    Count_Diff_corp_ra_cname2_score := COUNT(GROUP,%Closest%.Diff_corp_ra_cname2_score);
    Count_Diff_corp_ra_prim_range := COUNT(GROUP,%Closest%.Diff_corp_ra_prim_range);
    Count_Diff_corp_ra_predir := COUNT(GROUP,%Closest%.Diff_corp_ra_predir);
    Count_Diff_corp_ra_prim_name := COUNT(GROUP,%Closest%.Diff_corp_ra_prim_name);
    Count_Diff_corp_ra_addr_suffix := COUNT(GROUP,%Closest%.Diff_corp_ra_addr_suffix);
    Count_Diff_corp_ra_postdir := COUNT(GROUP,%Closest%.Diff_corp_ra_postdir);
    Count_Diff_corp_ra_unit_desig := COUNT(GROUP,%Closest%.Diff_corp_ra_unit_desig);
    Count_Diff_corp_ra_sec_range := COUNT(GROUP,%Closest%.Diff_corp_ra_sec_range);
    Count_Diff_corp_ra_p_city_name := COUNT(GROUP,%Closest%.Diff_corp_ra_p_city_name);
    Count_Diff_corp_ra_v_city_name := COUNT(GROUP,%Closest%.Diff_corp_ra_v_city_name);
    Count_Diff_corp_ra_state := COUNT(GROUP,%Closest%.Diff_corp_ra_state);
    Count_Diff_corp_ra_zip5 := COUNT(GROUP,%Closest%.Diff_corp_ra_zip5);
    Count_Diff_corp_ra_zip4 := COUNT(GROUP,%Closest%.Diff_corp_ra_zip4);
    Count_Diff_corp_ra_cart := COUNT(GROUP,%Closest%.Diff_corp_ra_cart);
    Count_Diff_corp_ra_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_corp_ra_cr_sort_sz);
    Count_Diff_corp_ra_lot := COUNT(GROUP,%Closest%.Diff_corp_ra_lot);
    Count_Diff_corp_ra_lot_order := COUNT(GROUP,%Closest%.Diff_corp_ra_lot_order);
    Count_Diff_corp_ra_dpbc := COUNT(GROUP,%Closest%.Diff_corp_ra_dpbc);
    Count_Diff_corp_ra_chk_digit := COUNT(GROUP,%Closest%.Diff_corp_ra_chk_digit);
    Count_Diff_corp_ra_rec_type := COUNT(GROUP,%Closest%.Diff_corp_ra_rec_type);
    Count_Diff_corp_ra_ace_fips_st := COUNT(GROUP,%Closest%.Diff_corp_ra_ace_fips_st);
    Count_Diff_corp_ra_county := COUNT(GROUP,%Closest%.Diff_corp_ra_county);
    Count_Diff_corp_ra_geo_lat := COUNT(GROUP,%Closest%.Diff_corp_ra_geo_lat);
    Count_Diff_corp_ra_geo_long := COUNT(GROUP,%Closest%.Diff_corp_ra_geo_long);
    Count_Diff_corp_ra_msa := COUNT(GROUP,%Closest%.Diff_corp_ra_msa);
    Count_Diff_corp_ra_geo_blk := COUNT(GROUP,%Closest%.Diff_corp_ra_geo_blk);
    Count_Diff_corp_ra_geo_match := COUNT(GROUP,%Closest%.Diff_corp_ra_geo_match);
    Count_Diff_corp_ra_err_stat := COUNT(GROUP,%Closest%.Diff_corp_ra_err_stat);
    Count_Diff_corp_phone10 := COUNT(GROUP,%Closest%.Diff_corp_phone10);
    Count_Diff_corp_ra_phone10 := COUNT(GROUP,%Closest%.Diff_corp_ra_phone10);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_append_addr1_rawaid := COUNT(GROUP,%Closest%.Diff_append_addr1_rawaid);
    Count_Diff_append_addr1_aceaid := COUNT(GROUP,%Closest%.Diff_append_addr1_aceaid);
    Count_Diff_corp_prep_addr1_line1 := COUNT(GROUP,%Closest%.Diff_corp_prep_addr1_line1);
    Count_Diff_corp_prep_addr1_last_line := COUNT(GROUP,%Closest%.Diff_corp_prep_addr1_last_line);
    Count_Diff_append_addr2_rawaid := COUNT(GROUP,%Closest%.Diff_append_addr2_rawaid);
    Count_Diff_append_addr2_aceaid := COUNT(GROUP,%Closest%.Diff_append_addr2_aceaid);
    Count_Diff_corp_prep_addr2_line1 := COUNT(GROUP,%Closest%.Diff_corp_prep_addr2_line1);
    Count_Diff_corp_prep_addr2_last_line := COUNT(GROUP,%Closest%.Diff_corp_prep_addr2_last_line);
    Count_Diff_append_ra_rawaid := COUNT(GROUP,%Closest%.Diff_append_ra_rawaid);
    Count_Diff_append_ra_aceaid := COUNT(GROUP,%Closest%.Diff_append_ra_aceaid);
    Count_Diff_ra_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_ra_prep_addr_line1);
    Count_Diff_ra_prep_addr_last_line := COUNT(GROUP,%Closest%.Diff_ra_prep_addr_last_line);
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

IMPORT SALT311;
IMPORT Scrubs_BKForeclosure_Reo; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 100;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_number','invalid_alpha','invalid_AlphaNum','invalid_apn','invalid_date','invalid_addr','invalid_state','invalid_zip','invalid_name','invalid_document_code','invalid_property_code','invalid_land_use_code','invalid_lender_type_code','invalid_loan_type_code');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_number' => 1,'invalid_alpha' => 2,'invalid_AlphaNum' => 3,'invalid_apn' => 4,'invalid_date' => 5,'invalid_addr' => 6,'invalid_state' => 7,'invalid_zip' => 8,'invalid_name' => 9,'invalid_document_code' => 10,'invalid_property_code' => 11,'invalid_land_use_code' => 12,'invalid_lender_type_code' => 13,'invalid_loan_type_code' => 14,0);
 
EXPORT MakeFT_invalid_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -.,'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -.,',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -.,'))));
EXPORT InValidMessageFT_invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -.,'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_apn(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -,;.:|'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -,;.:|',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_apn(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -,;.:|'))));
EXPORT InValidMessageFT_invalid_apn(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -,;.:|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,8,10'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_addr(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' <>{}[]-^=!+&,.()#/;:!"'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=!+&,.()#/;:!"',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_addr(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' <>{}[]-^=!+&,.()#/;:!"'))));
EXPORT InValidMessageFT_invalid_addr(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' <>{}[]-^=!+&,.()#/;:!"'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\''))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\''),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,1,4,5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -,.()[]%;\'*+\\/"&#<>:!'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -,.()[]%;\'*+\\/"&#<>:!',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -,.()[]%;\'*+\\/"&#<>:!'))));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -,.()[]%;\'*+\\/"&#<>:!'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_document_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_document_code(SALT311.StrType s) := WHICH(~Scrubs_BKForeclosure_Reo.fn_valid_codes(s,'DOCUMENT_TYPE')>0);
EXPORT InValidMessageFT_invalid_document_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BKForeclosure_Reo.fn_valid_codes'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_property_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_property_code(SALT311.StrType s) := WHICH(~Scrubs_BKForeclosure_Reo.fn_valid_codes(s,'PROPERTY_USE')>0);
EXPORT InValidMessageFT_invalid_property_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BKForeclosure_Reo.fn_valid_codes'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_land_use_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_land_use_code(SALT311.StrType s) := WHICH(~Scrubs_BKForeclosure_Reo.fn_valid_codes(s,'LAND_USE')>0);
EXPORT InValidMessageFT_invalid_land_use_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BKForeclosure_Reo.fn_valid_codes'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lender_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lender_type_code(SALT311.StrType s) := WHICH(~Scrubs_BKForeclosure_Reo.fn_valid_codes(s,'LENDER_TYPE')>0);
EXPORT InValidMessageFT_invalid_lender_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BKForeclosure_Reo.fn_valid_codes'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_loan_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_loan_type_code(SALT311.StrType s) := WHICH(~Scrubs_BKForeclosure_Reo.fn_valid_codes(s,'LOAN_TYPE')>0);
EXPORT InValidMessageFT_invalid_loan_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BKForeclosure_Reo.fn_valid_codes'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'foreclosure_id','ln_filedate','bk_infile_type','fips_cd','prop_full_addr','prop_addr_city','prop_addr_state','prop_addr_zip5','prop_addr_zip4','prop_addr_unit_type','prop_addr_unit_no','prop_addr_house_no','prop_addr_predir','prop_addr_street','prop_addr_suffix','prop_addr_postdir','prop_addr_carrier_rt','recording_date','recording_book_num','recording_page_num','recording_doc_num','doc_type_cd','apn','multi_apn','partial_interest_trans','seller1_fname','seller1_lname','seller1_id','seller2_fname','seller2_lname','buyer1_fname','buyer1_lname','buyer1_id_cd','buyer2_fname','buyer2_lname','buyer_vesting_cd','concurrent_doc_num','buyer_mail_city','buyer_mail_state','buyer_mail_zip5','buyer_mail_zip4','legal_lot_cd','legal_lot_num','legal_block','legal_section','legal_district','legal_land_lot','legal_unit','legacl_city','legal_subdivision','legal_phase_num','legal_tract_num','legal_brief_desc','legal_township','recorder_map_ref','prop_buyer_mail_addr_cd','property_use_cd','orig_contract_date','sales_price','sales_price_cd','city_xfer_tax','county_xfer_tax','total_xfer_tax','concurrent_lender_name','concurrent_lender_type','concurrent_loan_amt','concurrent_loan_type','concurrent_type_fin','concurrent_interest_rate','concurrent_due_dt','concurrent_2nd_loan_amt','buyer_mail_full_addr','buyer_mail_unit_type','buyer_mail_unit_no','lps_internal_pid','buyer_mail_careof','title_co_name','legal_desc_cd','adj_rate_rider','adj_rate_index','change_index','rate_change_freq','int_rate_ngt','int_rate_nlt','max_int_rate','int_only_period','fixed_rate_rider','first_chg_dt_yy','first_chg_dt_mmdd','prepayment_rider','prepayment_term','asses_land_use','res_indicator','construction_loan','inter_family','cash_purchase','stand_alone_refi','equity_credit_line','reo_flag','distressedsaleflag');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'foreclosure_id','ln_filedate','bk_infile_type','fips_cd','prop_full_addr','prop_addr_city','prop_addr_state','prop_addr_zip5','prop_addr_zip4','prop_addr_unit_type','prop_addr_unit_no','prop_addr_house_no','prop_addr_predir','prop_addr_street','prop_addr_suffix','prop_addr_postdir','prop_addr_carrier_rt','recording_date','recording_book_num','recording_page_num','recording_doc_num','doc_type_cd','apn','multi_apn','partial_interest_trans','seller1_fname','seller1_lname','seller1_id','seller2_fname','seller2_lname','buyer1_fname','buyer1_lname','buyer1_id_cd','buyer2_fname','buyer2_lname','buyer_vesting_cd','concurrent_doc_num','buyer_mail_city','buyer_mail_state','buyer_mail_zip5','buyer_mail_zip4','legal_lot_cd','legal_lot_num','legal_block','legal_section','legal_district','legal_land_lot','legal_unit','legacl_city','legal_subdivision','legal_phase_num','legal_tract_num','legal_brief_desc','legal_township','recorder_map_ref','prop_buyer_mail_addr_cd','property_use_cd','orig_contract_date','sales_price','sales_price_cd','city_xfer_tax','county_xfer_tax','total_xfer_tax','concurrent_lender_name','concurrent_lender_type','concurrent_loan_amt','concurrent_loan_type','concurrent_type_fin','concurrent_interest_rate','concurrent_due_dt','concurrent_2nd_loan_amt','buyer_mail_full_addr','buyer_mail_unit_type','buyer_mail_unit_no','lps_internal_pid','buyer_mail_careof','title_co_name','legal_desc_cd','adj_rate_rider','adj_rate_index','change_index','rate_change_freq','int_rate_ngt','int_rate_nlt','max_int_rate','int_only_period','fixed_rate_rider','first_chg_dt_yy','first_chg_dt_mmdd','prepayment_rider','prepayment_term','asses_land_use','res_indicator','construction_loan','inter_family','cash_purchase','stand_alone_refi','equity_credit_line','reo_flag','distressedsaleflag');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'foreclosure_id' => 0,'ln_filedate' => 1,'bk_infile_type' => 2,'fips_cd' => 3,'prop_full_addr' => 4,'prop_addr_city' => 5,'prop_addr_state' => 6,'prop_addr_zip5' => 7,'prop_addr_zip4' => 8,'prop_addr_unit_type' => 9,'prop_addr_unit_no' => 10,'prop_addr_house_no' => 11,'prop_addr_predir' => 12,'prop_addr_street' => 13,'prop_addr_suffix' => 14,'prop_addr_postdir' => 15,'prop_addr_carrier_rt' => 16,'recording_date' => 17,'recording_book_num' => 18,'recording_page_num' => 19,'recording_doc_num' => 20,'doc_type_cd' => 21,'apn' => 22,'multi_apn' => 23,'partial_interest_trans' => 24,'seller1_fname' => 25,'seller1_lname' => 26,'seller1_id' => 27,'seller2_fname' => 28,'seller2_lname' => 29,'buyer1_fname' => 30,'buyer1_lname' => 31,'buyer1_id_cd' => 32,'buyer2_fname' => 33,'buyer2_lname' => 34,'buyer_vesting_cd' => 35,'concurrent_doc_num' => 36,'buyer_mail_city' => 37,'buyer_mail_state' => 38,'buyer_mail_zip5' => 39,'buyer_mail_zip4' => 40,'legal_lot_cd' => 41,'legal_lot_num' => 42,'legal_block' => 43,'legal_section' => 44,'legal_district' => 45,'legal_land_lot' => 46,'legal_unit' => 47,'legacl_city' => 48,'legal_subdivision' => 49,'legal_phase_num' => 50,'legal_tract_num' => 51,'legal_brief_desc' => 52,'legal_township' => 53,'recorder_map_ref' => 54,'prop_buyer_mail_addr_cd' => 55,'property_use_cd' => 56,'orig_contract_date' => 57,'sales_price' => 58,'sales_price_cd' => 59,'city_xfer_tax' => 60,'county_xfer_tax' => 61,'total_xfer_tax' => 62,'concurrent_lender_name' => 63,'concurrent_lender_type' => 64,'concurrent_loan_amt' => 65,'concurrent_loan_type' => 66,'concurrent_type_fin' => 67,'concurrent_interest_rate' => 68,'concurrent_due_dt' => 69,'concurrent_2nd_loan_amt' => 70,'buyer_mail_full_addr' => 71,'buyer_mail_unit_type' => 72,'buyer_mail_unit_no' => 73,'lps_internal_pid' => 74,'buyer_mail_careof' => 75,'title_co_name' => 76,'legal_desc_cd' => 77,'adj_rate_rider' => 78,'adj_rate_index' => 79,'change_index' => 80,'rate_change_freq' => 81,'int_rate_ngt' => 82,'int_rate_nlt' => 83,'max_int_rate' => 84,'int_only_period' => 85,'fixed_rate_rider' => 86,'first_chg_dt_yy' => 87,'first_chg_dt_mmdd' => 88,'prepayment_rider' => 89,'prepayment_term' => 90,'asses_land_use' => 91,'res_indicator' => 92,'construction_loan' => 93,'inter_family' => 94,'cash_purchase' => 95,'stand_alone_refi' => 96,'equity_credit_line' => 97,'reo_flag' => 98,'distressedsaleflag' => 99,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],['ALLOW','LENGTHS'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],[],[],[],[],[],[],['ALLOW','LENGTHS'],[],[],[],['CUSTOM'],['ALLOW'],[],[],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],[],[],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],['ALLOW','LENGTHS'],[],[],[],[],[],[],['CUSTOM'],[],['CUSTOM'],[],[],['ALLOW','LENGTHS'],[],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_foreclosure_id(SALT311.StrType s0) := s0;
EXPORT InValid_foreclosure_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_foreclosure_id(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_filedate(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_ln_filedate(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_ln_filedate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_bk_infile_type(SALT311.StrType s0) := s0;
EXPORT InValid_bk_infile_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_bk_infile_type(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_cd(SALT311.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_fips_cd(SALT311.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_fips_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);
 
EXPORT Make_prop_full_addr(SALT311.StrType s0) := MakeFT_invalid_addr(s0);
EXPORT InValid_prop_full_addr(SALT311.StrType s) := InValidFT_invalid_addr(s);
EXPORT InValidMessage_prop_full_addr(UNSIGNED1 wh) := InValidMessageFT_invalid_addr(wh);
 
EXPORT Make_prop_addr_city(SALT311.StrType s0) := MakeFT_invalid_AlphaNum(s0);
EXPORT InValid_prop_addr_city(SALT311.StrType s) := InValidFT_invalid_AlphaNum(s);
EXPORT InValidMessage_prop_addr_city(UNSIGNED1 wh) := InValidMessageFT_invalid_AlphaNum(wh);
 
EXPORT Make_prop_addr_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_prop_addr_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_prop_addr_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_prop_addr_zip5(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_prop_addr_zip5(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_prop_addr_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_prop_addr_zip4(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_prop_addr_zip4(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_prop_addr_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_prop_addr_unit_type(SALT311.StrType s0) := s0;
EXPORT InValid_prop_addr_unit_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_prop_addr_unit_type(UNSIGNED1 wh) := '';
 
EXPORT Make_prop_addr_unit_no(SALT311.StrType s0) := s0;
EXPORT InValid_prop_addr_unit_no(SALT311.StrType s) := 0;
EXPORT InValidMessage_prop_addr_unit_no(UNSIGNED1 wh) := '';
 
EXPORT Make_prop_addr_house_no(SALT311.StrType s0) := s0;
EXPORT InValid_prop_addr_house_no(SALT311.StrType s) := 0;
EXPORT InValidMessage_prop_addr_house_no(UNSIGNED1 wh) := '';
 
EXPORT Make_prop_addr_predir(SALT311.StrType s0) := s0;
EXPORT InValid_prop_addr_predir(SALT311.StrType s) := 0;
EXPORT InValidMessage_prop_addr_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prop_addr_street(SALT311.StrType s0) := s0;
EXPORT InValid_prop_addr_street(SALT311.StrType s) := 0;
EXPORT InValidMessage_prop_addr_street(UNSIGNED1 wh) := '';
 
EXPORT Make_prop_addr_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_prop_addr_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_prop_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_prop_addr_postdir(SALT311.StrType s0) := s0;
EXPORT InValid_prop_addr_postdir(SALT311.StrType s) := 0;
EXPORT InValidMessage_prop_addr_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_prop_addr_carrier_rt(SALT311.StrType s0) := s0;
EXPORT InValid_prop_addr_carrier_rt(SALT311.StrType s) := 0;
EXPORT InValidMessage_prop_addr_carrier_rt(UNSIGNED1 wh) := '';
 
EXPORT Make_recording_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_recording_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_recording_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_recording_book_num(SALT311.StrType s0) := s0;
EXPORT InValid_recording_book_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_recording_book_num(UNSIGNED1 wh) := '';
 
EXPORT Make_recording_page_num(SALT311.StrType s0) := s0;
EXPORT InValid_recording_page_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_recording_page_num(UNSIGNED1 wh) := '';
 
EXPORT Make_recording_doc_num(SALT311.StrType s0) := s0;
EXPORT InValid_recording_doc_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_recording_doc_num(UNSIGNED1 wh) := '';
 
EXPORT Make_doc_type_cd(SALT311.StrType s0) := MakeFT_invalid_document_code(s0);
EXPORT InValid_doc_type_cd(SALT311.StrType s) := InValidFT_invalid_document_code(s);
EXPORT InValidMessage_doc_type_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_document_code(wh);
 
EXPORT Make_apn(SALT311.StrType s0) := MakeFT_invalid_apn(s0);
EXPORT InValid_apn(SALT311.StrType s) := InValidFT_invalid_apn(s);
EXPORT InValidMessage_apn(UNSIGNED1 wh) := InValidMessageFT_invalid_apn(wh);
 
EXPORT Make_multi_apn(SALT311.StrType s0) := s0;
EXPORT InValid_multi_apn(SALT311.StrType s) := 0;
EXPORT InValidMessage_multi_apn(UNSIGNED1 wh) := '';
 
EXPORT Make_partial_interest_trans(SALT311.StrType s0) := s0;
EXPORT InValid_partial_interest_trans(SALT311.StrType s) := 0;
EXPORT InValidMessage_partial_interest_trans(UNSIGNED1 wh) := '';
 
EXPORT Make_seller1_fname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_seller1_fname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_seller1_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_seller1_lname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_seller1_lname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_seller1_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_seller1_id(SALT311.StrType s0) := s0;
EXPORT InValid_seller1_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_seller1_id(UNSIGNED1 wh) := '';
 
EXPORT Make_seller2_fname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_seller2_fname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_seller2_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_seller2_lname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_seller2_lname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_seller2_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_buyer1_fname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_buyer1_fname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_buyer1_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_buyer1_lname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_buyer1_lname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_buyer1_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_buyer1_id_cd(SALT311.StrType s0) := s0;
EXPORT InValid_buyer1_id_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_buyer1_id_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_buyer2_fname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_buyer2_fname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_buyer2_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_buyer2_lname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_buyer2_lname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_buyer2_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_buyer_vesting_cd(SALT311.StrType s0) := s0;
EXPORT InValid_buyer_vesting_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_buyer_vesting_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_concurrent_doc_num(SALT311.StrType s0) := s0;
EXPORT InValid_concurrent_doc_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_concurrent_doc_num(UNSIGNED1 wh) := '';
 
EXPORT Make_buyer_mail_city(SALT311.StrType s0) := MakeFT_invalid_AlphaNum(s0);
EXPORT InValid_buyer_mail_city(SALT311.StrType s) := InValidFT_invalid_AlphaNum(s);
EXPORT InValidMessage_buyer_mail_city(UNSIGNED1 wh) := InValidMessageFT_invalid_AlphaNum(wh);
 
EXPORT Make_buyer_mail_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_buyer_mail_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_buyer_mail_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_buyer_mail_zip5(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_buyer_mail_zip5(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_buyer_mail_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_buyer_mail_zip4(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_buyer_mail_zip4(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_buyer_mail_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_legal_lot_cd(SALT311.StrType s0) := s0;
EXPORT InValid_legal_lot_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_lot_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_lot_num(SALT311.StrType s0) := s0;
EXPORT InValid_legal_lot_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_lot_num(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_block(SALT311.StrType s0) := s0;
EXPORT InValid_legal_block(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_block(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_section(SALT311.StrType s0) := s0;
EXPORT InValid_legal_section(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_section(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_district(SALT311.StrType s0) := s0;
EXPORT InValid_legal_district(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_district(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_land_lot(SALT311.StrType s0) := s0;
EXPORT InValid_legal_land_lot(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_land_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_unit(SALT311.StrType s0) := s0;
EXPORT InValid_legal_unit(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_unit(UNSIGNED1 wh) := '';
 
EXPORT Make_legacl_city(SALT311.StrType s0) := s0;
EXPORT InValid_legacl_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_legacl_city(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_subdivision(SALT311.StrType s0) := s0;
EXPORT InValid_legal_subdivision(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_subdivision(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_phase_num(SALT311.StrType s0) := s0;
EXPORT InValid_legal_phase_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_phase_num(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_tract_num(SALT311.StrType s0) := s0;
EXPORT InValid_legal_tract_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_tract_num(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_brief_desc(SALT311.StrType s0) := s0;
EXPORT InValid_legal_brief_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_brief_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_township(SALT311.StrType s0) := s0;
EXPORT InValid_legal_township(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_township(UNSIGNED1 wh) := '';
 
EXPORT Make_recorder_map_ref(SALT311.StrType s0) := s0;
EXPORT InValid_recorder_map_ref(SALT311.StrType s) := 0;
EXPORT InValidMessage_recorder_map_ref(UNSIGNED1 wh) := '';
 
EXPORT Make_prop_buyer_mail_addr_cd(SALT311.StrType s0) := s0;
EXPORT InValid_prop_buyer_mail_addr_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_prop_buyer_mail_addr_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_property_use_cd(SALT311.StrType s0) := MakeFT_invalid_property_code(s0);
EXPORT InValid_property_use_cd(SALT311.StrType s) := InValidFT_invalid_property_code(s);
EXPORT InValidMessage_property_use_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_property_code(wh);
 
EXPORT Make_orig_contract_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_orig_contract_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_orig_contract_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_sales_price(SALT311.StrType s0) := s0;
EXPORT InValid_sales_price(SALT311.StrType s) := 0;
EXPORT InValidMessage_sales_price(UNSIGNED1 wh) := '';
 
EXPORT Make_sales_price_cd(SALT311.StrType s0) := s0;
EXPORT InValid_sales_price_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_sales_price_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_city_xfer_tax(SALT311.StrType s0) := s0;
EXPORT InValid_city_xfer_tax(SALT311.StrType s) := 0;
EXPORT InValidMessage_city_xfer_tax(UNSIGNED1 wh) := '';
 
EXPORT Make_county_xfer_tax(SALT311.StrType s0) := s0;
EXPORT InValid_county_xfer_tax(SALT311.StrType s) := 0;
EXPORT InValidMessage_county_xfer_tax(UNSIGNED1 wh) := '';
 
EXPORT Make_total_xfer_tax(SALT311.StrType s0) := s0;
EXPORT InValid_total_xfer_tax(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_xfer_tax(UNSIGNED1 wh) := '';
 
EXPORT Make_concurrent_lender_name(SALT311.StrType s0) := s0;
EXPORT InValid_concurrent_lender_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_concurrent_lender_name(UNSIGNED1 wh) := '';
 
EXPORT Make_concurrent_lender_type(SALT311.StrType s0) := MakeFT_invalid_lender_type_code(s0);
EXPORT InValid_concurrent_lender_type(SALT311.StrType s) := InValidFT_invalid_lender_type_code(s);
EXPORT InValidMessage_concurrent_lender_type(UNSIGNED1 wh) := InValidMessageFT_invalid_lender_type_code(wh);
 
EXPORT Make_concurrent_loan_amt(SALT311.StrType s0) := s0;
EXPORT InValid_concurrent_loan_amt(SALT311.StrType s) := 0;
EXPORT InValidMessage_concurrent_loan_amt(UNSIGNED1 wh) := '';
 
EXPORT Make_concurrent_loan_type(SALT311.StrType s0) := MakeFT_invalid_loan_type_code(s0);
EXPORT InValid_concurrent_loan_type(SALT311.StrType s) := InValidFT_invalid_loan_type_code(s);
EXPORT InValidMessage_concurrent_loan_type(UNSIGNED1 wh) := InValidMessageFT_invalid_loan_type_code(wh);
 
EXPORT Make_concurrent_type_fin(SALT311.StrType s0) := s0;
EXPORT InValid_concurrent_type_fin(SALT311.StrType s) := 0;
EXPORT InValidMessage_concurrent_type_fin(UNSIGNED1 wh) := '';
 
EXPORT Make_concurrent_interest_rate(SALT311.StrType s0) := s0;
EXPORT InValid_concurrent_interest_rate(SALT311.StrType s) := 0;
EXPORT InValidMessage_concurrent_interest_rate(UNSIGNED1 wh) := '';
 
EXPORT Make_concurrent_due_dt(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_concurrent_due_dt(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_concurrent_due_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_concurrent_2nd_loan_amt(SALT311.StrType s0) := s0;
EXPORT InValid_concurrent_2nd_loan_amt(SALT311.StrType s) := 0;
EXPORT InValidMessage_concurrent_2nd_loan_amt(UNSIGNED1 wh) := '';
 
EXPORT Make_buyer_mail_full_addr(SALT311.StrType s0) := MakeFT_invalid_addr(s0);
EXPORT InValid_buyer_mail_full_addr(SALT311.StrType s) := InValidFT_invalid_addr(s);
EXPORT InValidMessage_buyer_mail_full_addr(UNSIGNED1 wh) := InValidMessageFT_invalid_addr(wh);
 
EXPORT Make_buyer_mail_unit_type(SALT311.StrType s0) := s0;
EXPORT InValid_buyer_mail_unit_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_buyer_mail_unit_type(UNSIGNED1 wh) := '';
 
EXPORT Make_buyer_mail_unit_no(SALT311.StrType s0) := s0;
EXPORT InValid_buyer_mail_unit_no(SALT311.StrType s) := 0;
EXPORT InValidMessage_buyer_mail_unit_no(UNSIGNED1 wh) := '';
 
EXPORT Make_lps_internal_pid(SALT311.StrType s0) := s0;
EXPORT InValid_lps_internal_pid(SALT311.StrType s) := 0;
EXPORT InValidMessage_lps_internal_pid(UNSIGNED1 wh) := '';
 
EXPORT Make_buyer_mail_careof(SALT311.StrType s0) := s0;
EXPORT InValid_buyer_mail_careof(SALT311.StrType s) := 0;
EXPORT InValidMessage_buyer_mail_careof(UNSIGNED1 wh) := '';
 
EXPORT Make_title_co_name(SALT311.StrType s0) := s0;
EXPORT InValid_title_co_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_title_co_name(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_desc_cd(SALT311.StrType s0) := s0;
EXPORT InValid_legal_desc_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_desc_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_adj_rate_rider(SALT311.StrType s0) := s0;
EXPORT InValid_adj_rate_rider(SALT311.StrType s) := 0;
EXPORT InValidMessage_adj_rate_rider(UNSIGNED1 wh) := '';
 
EXPORT Make_adj_rate_index(SALT311.StrType s0) := s0;
EXPORT InValid_adj_rate_index(SALT311.StrType s) := 0;
EXPORT InValidMessage_adj_rate_index(UNSIGNED1 wh) := '';
 
EXPORT Make_change_index(SALT311.StrType s0) := s0;
EXPORT InValid_change_index(SALT311.StrType s) := 0;
EXPORT InValidMessage_change_index(UNSIGNED1 wh) := '';
 
EXPORT Make_rate_change_freq(SALT311.StrType s0) := s0;
EXPORT InValid_rate_change_freq(SALT311.StrType s) := 0;
EXPORT InValidMessage_rate_change_freq(UNSIGNED1 wh) := '';
 
EXPORT Make_int_rate_ngt(SALT311.StrType s0) := s0;
EXPORT InValid_int_rate_ngt(SALT311.StrType s) := 0;
EXPORT InValidMessage_int_rate_ngt(UNSIGNED1 wh) := '';
 
EXPORT Make_int_rate_nlt(SALT311.StrType s0) := s0;
EXPORT InValid_int_rate_nlt(SALT311.StrType s) := 0;
EXPORT InValidMessage_int_rate_nlt(UNSIGNED1 wh) := '';
 
EXPORT Make_max_int_rate(SALT311.StrType s0) := s0;
EXPORT InValid_max_int_rate(SALT311.StrType s) := 0;
EXPORT InValidMessage_max_int_rate(UNSIGNED1 wh) := '';
 
EXPORT Make_int_only_period(SALT311.StrType s0) := s0;
EXPORT InValid_int_only_period(SALT311.StrType s) := 0;
EXPORT InValidMessage_int_only_period(UNSIGNED1 wh) := '';
 
EXPORT Make_fixed_rate_rider(SALT311.StrType s0) := s0;
EXPORT InValid_fixed_rate_rider(SALT311.StrType s) := 0;
EXPORT InValidMessage_fixed_rate_rider(UNSIGNED1 wh) := '';
 
EXPORT Make_first_chg_dt_yy(SALT311.StrType s0) := s0;
EXPORT InValid_first_chg_dt_yy(SALT311.StrType s) := 0;
EXPORT InValidMessage_first_chg_dt_yy(UNSIGNED1 wh) := '';
 
EXPORT Make_first_chg_dt_mmdd(SALT311.StrType s0) := s0;
EXPORT InValid_first_chg_dt_mmdd(SALT311.StrType s) := 0;
EXPORT InValidMessage_first_chg_dt_mmdd(UNSIGNED1 wh) := '';
 
EXPORT Make_prepayment_rider(SALT311.StrType s0) := s0;
EXPORT InValid_prepayment_rider(SALT311.StrType s) := 0;
EXPORT InValidMessage_prepayment_rider(UNSIGNED1 wh) := '';
 
EXPORT Make_prepayment_term(SALT311.StrType s0) := s0;
EXPORT InValid_prepayment_term(SALT311.StrType s) := 0;
EXPORT InValidMessage_prepayment_term(UNSIGNED1 wh) := '';
 
EXPORT Make_asses_land_use(SALT311.StrType s0) := MakeFT_invalid_land_use_code(s0);
EXPORT InValid_asses_land_use(SALT311.StrType s) := InValidFT_invalid_land_use_code(s);
EXPORT InValidMessage_asses_land_use(UNSIGNED1 wh) := InValidMessageFT_invalid_land_use_code(wh);
 
EXPORT Make_res_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_res_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_res_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_construction_loan(SALT311.StrType s0) := s0;
EXPORT InValid_construction_loan(SALT311.StrType s) := 0;
EXPORT InValidMessage_construction_loan(UNSIGNED1 wh) := '';
 
EXPORT Make_inter_family(SALT311.StrType s0) := s0;
EXPORT InValid_inter_family(SALT311.StrType s) := 0;
EXPORT InValidMessage_inter_family(UNSIGNED1 wh) := '';
 
EXPORT Make_cash_purchase(SALT311.StrType s0) := s0;
EXPORT InValid_cash_purchase(SALT311.StrType s) := 0;
EXPORT InValidMessage_cash_purchase(UNSIGNED1 wh) := '';
 
EXPORT Make_stand_alone_refi(SALT311.StrType s0) := s0;
EXPORT InValid_stand_alone_refi(SALT311.StrType s) := 0;
EXPORT InValidMessage_stand_alone_refi(UNSIGNED1 wh) := '';
 
EXPORT Make_equity_credit_line(SALT311.StrType s0) := s0;
EXPORT InValid_equity_credit_line(SALT311.StrType s) := 0;
EXPORT InValidMessage_equity_credit_line(UNSIGNED1 wh) := '';
 
EXPORT Make_reo_flag(SALT311.StrType s0) := s0;
EXPORT InValid_reo_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_reo_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_distressedsaleflag(SALT311.StrType s0) := s0;
EXPORT InValid_distressedsaleflag(SALT311.StrType s) := 0;
EXPORT InValidMessage_distressedsaleflag(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_BKForeclosure_Reo;
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
    BOOLEAN Diff_foreclosure_id;
    BOOLEAN Diff_ln_filedate;
    BOOLEAN Diff_bk_infile_type;
    BOOLEAN Diff_fips_cd;
    BOOLEAN Diff_prop_full_addr;
    BOOLEAN Diff_prop_addr_city;
    BOOLEAN Diff_prop_addr_state;
    BOOLEAN Diff_prop_addr_zip5;
    BOOLEAN Diff_prop_addr_zip4;
    BOOLEAN Diff_prop_addr_unit_type;
    BOOLEAN Diff_prop_addr_unit_no;
    BOOLEAN Diff_prop_addr_house_no;
    BOOLEAN Diff_prop_addr_predir;
    BOOLEAN Diff_prop_addr_street;
    BOOLEAN Diff_prop_addr_suffix;
    BOOLEAN Diff_prop_addr_postdir;
    BOOLEAN Diff_prop_addr_carrier_rt;
    BOOLEAN Diff_recording_date;
    BOOLEAN Diff_recording_book_num;
    BOOLEAN Diff_recording_page_num;
    BOOLEAN Diff_recording_doc_num;
    BOOLEAN Diff_doc_type_cd;
    BOOLEAN Diff_apn;
    BOOLEAN Diff_multi_apn;
    BOOLEAN Diff_partial_interest_trans;
    BOOLEAN Diff_seller1_fname;
    BOOLEAN Diff_seller1_lname;
    BOOLEAN Diff_seller1_id;
    BOOLEAN Diff_seller2_fname;
    BOOLEAN Diff_seller2_lname;
    BOOLEAN Diff_buyer1_fname;
    BOOLEAN Diff_buyer1_lname;
    BOOLEAN Diff_buyer1_id_cd;
    BOOLEAN Diff_buyer2_fname;
    BOOLEAN Diff_buyer2_lname;
    BOOLEAN Diff_buyer_vesting_cd;
    BOOLEAN Diff_concurrent_doc_num;
    BOOLEAN Diff_buyer_mail_city;
    BOOLEAN Diff_buyer_mail_state;
    BOOLEAN Diff_buyer_mail_zip5;
    BOOLEAN Diff_buyer_mail_zip4;
    BOOLEAN Diff_legal_lot_cd;
    BOOLEAN Diff_legal_lot_num;
    BOOLEAN Diff_legal_block;
    BOOLEAN Diff_legal_section;
    BOOLEAN Diff_legal_district;
    BOOLEAN Diff_legal_land_lot;
    BOOLEAN Diff_legal_unit;
    BOOLEAN Diff_legacl_city;
    BOOLEAN Diff_legal_subdivision;
    BOOLEAN Diff_legal_phase_num;
    BOOLEAN Diff_legal_tract_num;
    BOOLEAN Diff_legal_brief_desc;
    BOOLEAN Diff_legal_township;
    BOOLEAN Diff_recorder_map_ref;
    BOOLEAN Diff_prop_buyer_mail_addr_cd;
    BOOLEAN Diff_property_use_cd;
    BOOLEAN Diff_orig_contract_date;
    BOOLEAN Diff_sales_price;
    BOOLEAN Diff_sales_price_cd;
    BOOLEAN Diff_city_xfer_tax;
    BOOLEAN Diff_county_xfer_tax;
    BOOLEAN Diff_total_xfer_tax;
    BOOLEAN Diff_concurrent_lender_name;
    BOOLEAN Diff_concurrent_lender_type;
    BOOLEAN Diff_concurrent_loan_amt;
    BOOLEAN Diff_concurrent_loan_type;
    BOOLEAN Diff_concurrent_type_fin;
    BOOLEAN Diff_concurrent_interest_rate;
    BOOLEAN Diff_concurrent_due_dt;
    BOOLEAN Diff_concurrent_2nd_loan_amt;
    BOOLEAN Diff_buyer_mail_full_addr;
    BOOLEAN Diff_buyer_mail_unit_type;
    BOOLEAN Diff_buyer_mail_unit_no;
    BOOLEAN Diff_lps_internal_pid;
    BOOLEAN Diff_buyer_mail_careof;
    BOOLEAN Diff_title_co_name;
    BOOLEAN Diff_legal_desc_cd;
    BOOLEAN Diff_adj_rate_rider;
    BOOLEAN Diff_adj_rate_index;
    BOOLEAN Diff_change_index;
    BOOLEAN Diff_rate_change_freq;
    BOOLEAN Diff_int_rate_ngt;
    BOOLEAN Diff_int_rate_nlt;
    BOOLEAN Diff_max_int_rate;
    BOOLEAN Diff_int_only_period;
    BOOLEAN Diff_fixed_rate_rider;
    BOOLEAN Diff_first_chg_dt_yy;
    BOOLEAN Diff_first_chg_dt_mmdd;
    BOOLEAN Diff_prepayment_rider;
    BOOLEAN Diff_prepayment_term;
    BOOLEAN Diff_asses_land_use;
    BOOLEAN Diff_res_indicator;
    BOOLEAN Diff_construction_loan;
    BOOLEAN Diff_inter_family;
    BOOLEAN Diff_cash_purchase;
    BOOLEAN Diff_stand_alone_refi;
    BOOLEAN Diff_equity_credit_line;
    BOOLEAN Diff_reo_flag;
    BOOLEAN Diff_distressedsaleflag;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_foreclosure_id := le.foreclosure_id <> ri.foreclosure_id;
    SELF.Diff_ln_filedate := le.ln_filedate <> ri.ln_filedate;
    SELF.Diff_bk_infile_type := le.bk_infile_type <> ri.bk_infile_type;
    SELF.Diff_fips_cd := le.fips_cd <> ri.fips_cd;
    SELF.Diff_prop_full_addr := le.prop_full_addr <> ri.prop_full_addr;
    SELF.Diff_prop_addr_city := le.prop_addr_city <> ri.prop_addr_city;
    SELF.Diff_prop_addr_state := le.prop_addr_state <> ri.prop_addr_state;
    SELF.Diff_prop_addr_zip5 := le.prop_addr_zip5 <> ri.prop_addr_zip5;
    SELF.Diff_prop_addr_zip4 := le.prop_addr_zip4 <> ri.prop_addr_zip4;
    SELF.Diff_prop_addr_unit_type := le.prop_addr_unit_type <> ri.prop_addr_unit_type;
    SELF.Diff_prop_addr_unit_no := le.prop_addr_unit_no <> ri.prop_addr_unit_no;
    SELF.Diff_prop_addr_house_no := le.prop_addr_house_no <> ri.prop_addr_house_no;
    SELF.Diff_prop_addr_predir := le.prop_addr_predir <> ri.prop_addr_predir;
    SELF.Diff_prop_addr_street := le.prop_addr_street <> ri.prop_addr_street;
    SELF.Diff_prop_addr_suffix := le.prop_addr_suffix <> ri.prop_addr_suffix;
    SELF.Diff_prop_addr_postdir := le.prop_addr_postdir <> ri.prop_addr_postdir;
    SELF.Diff_prop_addr_carrier_rt := le.prop_addr_carrier_rt <> ri.prop_addr_carrier_rt;
    SELF.Diff_recording_date := le.recording_date <> ri.recording_date;
    SELF.Diff_recording_book_num := le.recording_book_num <> ri.recording_book_num;
    SELF.Diff_recording_page_num := le.recording_page_num <> ri.recording_page_num;
    SELF.Diff_recording_doc_num := le.recording_doc_num <> ri.recording_doc_num;
    SELF.Diff_doc_type_cd := le.doc_type_cd <> ri.doc_type_cd;
    SELF.Diff_apn := le.apn <> ri.apn;
    SELF.Diff_multi_apn := le.multi_apn <> ri.multi_apn;
    SELF.Diff_partial_interest_trans := le.partial_interest_trans <> ri.partial_interest_trans;
    SELF.Diff_seller1_fname := le.seller1_fname <> ri.seller1_fname;
    SELF.Diff_seller1_lname := le.seller1_lname <> ri.seller1_lname;
    SELF.Diff_seller1_id := le.seller1_id <> ri.seller1_id;
    SELF.Diff_seller2_fname := le.seller2_fname <> ri.seller2_fname;
    SELF.Diff_seller2_lname := le.seller2_lname <> ri.seller2_lname;
    SELF.Diff_buyer1_fname := le.buyer1_fname <> ri.buyer1_fname;
    SELF.Diff_buyer1_lname := le.buyer1_lname <> ri.buyer1_lname;
    SELF.Diff_buyer1_id_cd := le.buyer1_id_cd <> ri.buyer1_id_cd;
    SELF.Diff_buyer2_fname := le.buyer2_fname <> ri.buyer2_fname;
    SELF.Diff_buyer2_lname := le.buyer2_lname <> ri.buyer2_lname;
    SELF.Diff_buyer_vesting_cd := le.buyer_vesting_cd <> ri.buyer_vesting_cd;
    SELF.Diff_concurrent_doc_num := le.concurrent_doc_num <> ri.concurrent_doc_num;
    SELF.Diff_buyer_mail_city := le.buyer_mail_city <> ri.buyer_mail_city;
    SELF.Diff_buyer_mail_state := le.buyer_mail_state <> ri.buyer_mail_state;
    SELF.Diff_buyer_mail_zip5 := le.buyer_mail_zip5 <> ri.buyer_mail_zip5;
    SELF.Diff_buyer_mail_zip4 := le.buyer_mail_zip4 <> ri.buyer_mail_zip4;
    SELF.Diff_legal_lot_cd := le.legal_lot_cd <> ri.legal_lot_cd;
    SELF.Diff_legal_lot_num := le.legal_lot_num <> ri.legal_lot_num;
    SELF.Diff_legal_block := le.legal_block <> ri.legal_block;
    SELF.Diff_legal_section := le.legal_section <> ri.legal_section;
    SELF.Diff_legal_district := le.legal_district <> ri.legal_district;
    SELF.Diff_legal_land_lot := le.legal_land_lot <> ri.legal_land_lot;
    SELF.Diff_legal_unit := le.legal_unit <> ri.legal_unit;
    SELF.Diff_legacl_city := le.legacl_city <> ri.legacl_city;
    SELF.Diff_legal_subdivision := le.legal_subdivision <> ri.legal_subdivision;
    SELF.Diff_legal_phase_num := le.legal_phase_num <> ri.legal_phase_num;
    SELF.Diff_legal_tract_num := le.legal_tract_num <> ri.legal_tract_num;
    SELF.Diff_legal_brief_desc := le.legal_brief_desc <> ri.legal_brief_desc;
    SELF.Diff_legal_township := le.legal_township <> ri.legal_township;
    SELF.Diff_recorder_map_ref := le.recorder_map_ref <> ri.recorder_map_ref;
    SELF.Diff_prop_buyer_mail_addr_cd := le.prop_buyer_mail_addr_cd <> ri.prop_buyer_mail_addr_cd;
    SELF.Diff_property_use_cd := le.property_use_cd <> ri.property_use_cd;
    SELF.Diff_orig_contract_date := le.orig_contract_date <> ri.orig_contract_date;
    SELF.Diff_sales_price := le.sales_price <> ri.sales_price;
    SELF.Diff_sales_price_cd := le.sales_price_cd <> ri.sales_price_cd;
    SELF.Diff_city_xfer_tax := le.city_xfer_tax <> ri.city_xfer_tax;
    SELF.Diff_county_xfer_tax := le.county_xfer_tax <> ri.county_xfer_tax;
    SELF.Diff_total_xfer_tax := le.total_xfer_tax <> ri.total_xfer_tax;
    SELF.Diff_concurrent_lender_name := le.concurrent_lender_name <> ri.concurrent_lender_name;
    SELF.Diff_concurrent_lender_type := le.concurrent_lender_type <> ri.concurrent_lender_type;
    SELF.Diff_concurrent_loan_amt := le.concurrent_loan_amt <> ri.concurrent_loan_amt;
    SELF.Diff_concurrent_loan_type := le.concurrent_loan_type <> ri.concurrent_loan_type;
    SELF.Diff_concurrent_type_fin := le.concurrent_type_fin <> ri.concurrent_type_fin;
    SELF.Diff_concurrent_interest_rate := le.concurrent_interest_rate <> ri.concurrent_interest_rate;
    SELF.Diff_concurrent_due_dt := le.concurrent_due_dt <> ri.concurrent_due_dt;
    SELF.Diff_concurrent_2nd_loan_amt := le.concurrent_2nd_loan_amt <> ri.concurrent_2nd_loan_amt;
    SELF.Diff_buyer_mail_full_addr := le.buyer_mail_full_addr <> ri.buyer_mail_full_addr;
    SELF.Diff_buyer_mail_unit_type := le.buyer_mail_unit_type <> ri.buyer_mail_unit_type;
    SELF.Diff_buyer_mail_unit_no := le.buyer_mail_unit_no <> ri.buyer_mail_unit_no;
    SELF.Diff_lps_internal_pid := le.lps_internal_pid <> ri.lps_internal_pid;
    SELF.Diff_buyer_mail_careof := le.buyer_mail_careof <> ri.buyer_mail_careof;
    SELF.Diff_title_co_name := le.title_co_name <> ri.title_co_name;
    SELF.Diff_legal_desc_cd := le.legal_desc_cd <> ri.legal_desc_cd;
    SELF.Diff_adj_rate_rider := le.adj_rate_rider <> ri.adj_rate_rider;
    SELF.Diff_adj_rate_index := le.adj_rate_index <> ri.adj_rate_index;
    SELF.Diff_change_index := le.change_index <> ri.change_index;
    SELF.Diff_rate_change_freq := le.rate_change_freq <> ri.rate_change_freq;
    SELF.Diff_int_rate_ngt := le.int_rate_ngt <> ri.int_rate_ngt;
    SELF.Diff_int_rate_nlt := le.int_rate_nlt <> ri.int_rate_nlt;
    SELF.Diff_max_int_rate := le.max_int_rate <> ri.max_int_rate;
    SELF.Diff_int_only_period := le.int_only_period <> ri.int_only_period;
    SELF.Diff_fixed_rate_rider := le.fixed_rate_rider <> ri.fixed_rate_rider;
    SELF.Diff_first_chg_dt_yy := le.first_chg_dt_yy <> ri.first_chg_dt_yy;
    SELF.Diff_first_chg_dt_mmdd := le.first_chg_dt_mmdd <> ri.first_chg_dt_mmdd;
    SELF.Diff_prepayment_rider := le.prepayment_rider <> ri.prepayment_rider;
    SELF.Diff_prepayment_term := le.prepayment_term <> ri.prepayment_term;
    SELF.Diff_asses_land_use := le.asses_land_use <> ri.asses_land_use;
    SELF.Diff_res_indicator := le.res_indicator <> ri.res_indicator;
    SELF.Diff_construction_loan := le.construction_loan <> ri.construction_loan;
    SELF.Diff_inter_family := le.inter_family <> ri.inter_family;
    SELF.Diff_cash_purchase := le.cash_purchase <> ri.cash_purchase;
    SELF.Diff_stand_alone_refi := le.stand_alone_refi <> ri.stand_alone_refi;
    SELF.Diff_equity_credit_line := le.equity_credit_line <> ri.equity_credit_line;
    SELF.Diff_reo_flag := le.reo_flag <> ri.reo_flag;
    SELF.Diff_distressedsaleflag := le.distressedsaleflag <> ri.distressedsaleflag;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_foreclosure_id,1,0)+ IF( SELF.Diff_ln_filedate,1,0)+ IF( SELF.Diff_bk_infile_type,1,0)+ IF( SELF.Diff_fips_cd,1,0)+ IF( SELF.Diff_prop_full_addr,1,0)+ IF( SELF.Diff_prop_addr_city,1,0)+ IF( SELF.Diff_prop_addr_state,1,0)+ IF( SELF.Diff_prop_addr_zip5,1,0)+ IF( SELF.Diff_prop_addr_zip4,1,0)+ IF( SELF.Diff_prop_addr_unit_type,1,0)+ IF( SELF.Diff_prop_addr_unit_no,1,0)+ IF( SELF.Diff_prop_addr_house_no,1,0)+ IF( SELF.Diff_prop_addr_predir,1,0)+ IF( SELF.Diff_prop_addr_street,1,0)+ IF( SELF.Diff_prop_addr_suffix,1,0)+ IF( SELF.Diff_prop_addr_postdir,1,0)+ IF( SELF.Diff_prop_addr_carrier_rt,1,0)+ IF( SELF.Diff_recording_date,1,0)+ IF( SELF.Diff_recording_book_num,1,0)+ IF( SELF.Diff_recording_page_num,1,0)+ IF( SELF.Diff_recording_doc_num,1,0)+ IF( SELF.Diff_doc_type_cd,1,0)+ IF( SELF.Diff_apn,1,0)+ IF( SELF.Diff_multi_apn,1,0)+ IF( SELF.Diff_partial_interest_trans,1,0)+ IF( SELF.Diff_seller1_fname,1,0)+ IF( SELF.Diff_seller1_lname,1,0)+ IF( SELF.Diff_seller1_id,1,0)+ IF( SELF.Diff_seller2_fname,1,0)+ IF( SELF.Diff_seller2_lname,1,0)+ IF( SELF.Diff_buyer1_fname,1,0)+ IF( SELF.Diff_buyer1_lname,1,0)+ IF( SELF.Diff_buyer1_id_cd,1,0)+ IF( SELF.Diff_buyer2_fname,1,0)+ IF( SELF.Diff_buyer2_lname,1,0)+ IF( SELF.Diff_buyer_vesting_cd,1,0)+ IF( SELF.Diff_concurrent_doc_num,1,0)+ IF( SELF.Diff_buyer_mail_city,1,0)+ IF( SELF.Diff_buyer_mail_state,1,0)+ IF( SELF.Diff_buyer_mail_zip5,1,0)+ IF( SELF.Diff_buyer_mail_zip4,1,0)+ IF( SELF.Diff_legal_lot_cd,1,0)+ IF( SELF.Diff_legal_lot_num,1,0)+ IF( SELF.Diff_legal_block,1,0)+ IF( SELF.Diff_legal_section,1,0)+ IF( SELF.Diff_legal_district,1,0)+ IF( SELF.Diff_legal_land_lot,1,0)+ IF( SELF.Diff_legal_unit,1,0)+ IF( SELF.Diff_legacl_city,1,0)+ IF( SELF.Diff_legal_subdivision,1,0)+ IF( SELF.Diff_legal_phase_num,1,0)+ IF( SELF.Diff_legal_tract_num,1,0)+ IF( SELF.Diff_legal_brief_desc,1,0)+ IF( SELF.Diff_legal_township,1,0)+ IF( SELF.Diff_recorder_map_ref,1,0)+ IF( SELF.Diff_prop_buyer_mail_addr_cd,1,0)+ IF( SELF.Diff_property_use_cd,1,0)+ IF( SELF.Diff_orig_contract_date,1,0)+ IF( SELF.Diff_sales_price,1,0)+ IF( SELF.Diff_sales_price_cd,1,0)+ IF( SELF.Diff_city_xfer_tax,1,0)+ IF( SELF.Diff_county_xfer_tax,1,0)+ IF( SELF.Diff_total_xfer_tax,1,0)+ IF( SELF.Diff_concurrent_lender_name,1,0)+ IF( SELF.Diff_concurrent_lender_type,1,0)+ IF( SELF.Diff_concurrent_loan_amt,1,0)+ IF( SELF.Diff_concurrent_loan_type,1,0)+ IF( SELF.Diff_concurrent_type_fin,1,0)+ IF( SELF.Diff_concurrent_interest_rate,1,0)+ IF( SELF.Diff_concurrent_due_dt,1,0)+ IF( SELF.Diff_concurrent_2nd_loan_amt,1,0)+ IF( SELF.Diff_buyer_mail_full_addr,1,0)+ IF( SELF.Diff_buyer_mail_unit_type,1,0)+ IF( SELF.Diff_buyer_mail_unit_no,1,0)+ IF( SELF.Diff_lps_internal_pid,1,0)+ IF( SELF.Diff_buyer_mail_careof,1,0)+ IF( SELF.Diff_title_co_name,1,0)+ IF( SELF.Diff_legal_desc_cd,1,0)+ IF( SELF.Diff_adj_rate_rider,1,0)+ IF( SELF.Diff_adj_rate_index,1,0)+ IF( SELF.Diff_change_index,1,0)+ IF( SELF.Diff_rate_change_freq,1,0)+ IF( SELF.Diff_int_rate_ngt,1,0)+ IF( SELF.Diff_int_rate_nlt,1,0)+ IF( SELF.Diff_max_int_rate,1,0)+ IF( SELF.Diff_int_only_period,1,0)+ IF( SELF.Diff_fixed_rate_rider,1,0)+ IF( SELF.Diff_first_chg_dt_yy,1,0)+ IF( SELF.Diff_first_chg_dt_mmdd,1,0)+ IF( SELF.Diff_prepayment_rider,1,0)+ IF( SELF.Diff_prepayment_term,1,0)+ IF( SELF.Diff_asses_land_use,1,0)+ IF( SELF.Diff_res_indicator,1,0)+ IF( SELF.Diff_construction_loan,1,0)+ IF( SELF.Diff_inter_family,1,0)+ IF( SELF.Diff_cash_purchase,1,0)+ IF( SELF.Diff_stand_alone_refi,1,0)+ IF( SELF.Diff_equity_credit_line,1,0)+ IF( SELF.Diff_reo_flag,1,0)+ IF( SELF.Diff_distressedsaleflag,1,0);
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
    Count_Diff_foreclosure_id := COUNT(GROUP,%Closest%.Diff_foreclosure_id);
    Count_Diff_ln_filedate := COUNT(GROUP,%Closest%.Diff_ln_filedate);
    Count_Diff_bk_infile_type := COUNT(GROUP,%Closest%.Diff_bk_infile_type);
    Count_Diff_fips_cd := COUNT(GROUP,%Closest%.Diff_fips_cd);
    Count_Diff_prop_full_addr := COUNT(GROUP,%Closest%.Diff_prop_full_addr);
    Count_Diff_prop_addr_city := COUNT(GROUP,%Closest%.Diff_prop_addr_city);
    Count_Diff_prop_addr_state := COUNT(GROUP,%Closest%.Diff_prop_addr_state);
    Count_Diff_prop_addr_zip5 := COUNT(GROUP,%Closest%.Diff_prop_addr_zip5);
    Count_Diff_prop_addr_zip4 := COUNT(GROUP,%Closest%.Diff_prop_addr_zip4);
    Count_Diff_prop_addr_unit_type := COUNT(GROUP,%Closest%.Diff_prop_addr_unit_type);
    Count_Diff_prop_addr_unit_no := COUNT(GROUP,%Closest%.Diff_prop_addr_unit_no);
    Count_Diff_prop_addr_house_no := COUNT(GROUP,%Closest%.Diff_prop_addr_house_no);
    Count_Diff_prop_addr_predir := COUNT(GROUP,%Closest%.Diff_prop_addr_predir);
    Count_Diff_prop_addr_street := COUNT(GROUP,%Closest%.Diff_prop_addr_street);
    Count_Diff_prop_addr_suffix := COUNT(GROUP,%Closest%.Diff_prop_addr_suffix);
    Count_Diff_prop_addr_postdir := COUNT(GROUP,%Closest%.Diff_prop_addr_postdir);
    Count_Diff_prop_addr_carrier_rt := COUNT(GROUP,%Closest%.Diff_prop_addr_carrier_rt);
    Count_Diff_recording_date := COUNT(GROUP,%Closest%.Diff_recording_date);
    Count_Diff_recording_book_num := COUNT(GROUP,%Closest%.Diff_recording_book_num);
    Count_Diff_recording_page_num := COUNT(GROUP,%Closest%.Diff_recording_page_num);
    Count_Diff_recording_doc_num := COUNT(GROUP,%Closest%.Diff_recording_doc_num);
    Count_Diff_doc_type_cd := COUNT(GROUP,%Closest%.Diff_doc_type_cd);
    Count_Diff_apn := COUNT(GROUP,%Closest%.Diff_apn);
    Count_Diff_multi_apn := COUNT(GROUP,%Closest%.Diff_multi_apn);
    Count_Diff_partial_interest_trans := COUNT(GROUP,%Closest%.Diff_partial_interest_trans);
    Count_Diff_seller1_fname := COUNT(GROUP,%Closest%.Diff_seller1_fname);
    Count_Diff_seller1_lname := COUNT(GROUP,%Closest%.Diff_seller1_lname);
    Count_Diff_seller1_id := COUNT(GROUP,%Closest%.Diff_seller1_id);
    Count_Diff_seller2_fname := COUNT(GROUP,%Closest%.Diff_seller2_fname);
    Count_Diff_seller2_lname := COUNT(GROUP,%Closest%.Diff_seller2_lname);
    Count_Diff_buyer1_fname := COUNT(GROUP,%Closest%.Diff_buyer1_fname);
    Count_Diff_buyer1_lname := COUNT(GROUP,%Closest%.Diff_buyer1_lname);
    Count_Diff_buyer1_id_cd := COUNT(GROUP,%Closest%.Diff_buyer1_id_cd);
    Count_Diff_buyer2_fname := COUNT(GROUP,%Closest%.Diff_buyer2_fname);
    Count_Diff_buyer2_lname := COUNT(GROUP,%Closest%.Diff_buyer2_lname);
    Count_Diff_buyer_vesting_cd := COUNT(GROUP,%Closest%.Diff_buyer_vesting_cd);
    Count_Diff_concurrent_doc_num := COUNT(GROUP,%Closest%.Diff_concurrent_doc_num);
    Count_Diff_buyer_mail_city := COUNT(GROUP,%Closest%.Diff_buyer_mail_city);
    Count_Diff_buyer_mail_state := COUNT(GROUP,%Closest%.Diff_buyer_mail_state);
    Count_Diff_buyer_mail_zip5 := COUNT(GROUP,%Closest%.Diff_buyer_mail_zip5);
    Count_Diff_buyer_mail_zip4 := COUNT(GROUP,%Closest%.Diff_buyer_mail_zip4);
    Count_Diff_legal_lot_cd := COUNT(GROUP,%Closest%.Diff_legal_lot_cd);
    Count_Diff_legal_lot_num := COUNT(GROUP,%Closest%.Diff_legal_lot_num);
    Count_Diff_legal_block := COUNT(GROUP,%Closest%.Diff_legal_block);
    Count_Diff_legal_section := COUNT(GROUP,%Closest%.Diff_legal_section);
    Count_Diff_legal_district := COUNT(GROUP,%Closest%.Diff_legal_district);
    Count_Diff_legal_land_lot := COUNT(GROUP,%Closest%.Diff_legal_land_lot);
    Count_Diff_legal_unit := COUNT(GROUP,%Closest%.Diff_legal_unit);
    Count_Diff_legacl_city := COUNT(GROUP,%Closest%.Diff_legacl_city);
    Count_Diff_legal_subdivision := COUNT(GROUP,%Closest%.Diff_legal_subdivision);
    Count_Diff_legal_phase_num := COUNT(GROUP,%Closest%.Diff_legal_phase_num);
    Count_Diff_legal_tract_num := COUNT(GROUP,%Closest%.Diff_legal_tract_num);
    Count_Diff_legal_brief_desc := COUNT(GROUP,%Closest%.Diff_legal_brief_desc);
    Count_Diff_legal_township := COUNT(GROUP,%Closest%.Diff_legal_township);
    Count_Diff_recorder_map_ref := COUNT(GROUP,%Closest%.Diff_recorder_map_ref);
    Count_Diff_prop_buyer_mail_addr_cd := COUNT(GROUP,%Closest%.Diff_prop_buyer_mail_addr_cd);
    Count_Diff_property_use_cd := COUNT(GROUP,%Closest%.Diff_property_use_cd);
    Count_Diff_orig_contract_date := COUNT(GROUP,%Closest%.Diff_orig_contract_date);
    Count_Diff_sales_price := COUNT(GROUP,%Closest%.Diff_sales_price);
    Count_Diff_sales_price_cd := COUNT(GROUP,%Closest%.Diff_sales_price_cd);
    Count_Diff_city_xfer_tax := COUNT(GROUP,%Closest%.Diff_city_xfer_tax);
    Count_Diff_county_xfer_tax := COUNT(GROUP,%Closest%.Diff_county_xfer_tax);
    Count_Diff_total_xfer_tax := COUNT(GROUP,%Closest%.Diff_total_xfer_tax);
    Count_Diff_concurrent_lender_name := COUNT(GROUP,%Closest%.Diff_concurrent_lender_name);
    Count_Diff_concurrent_lender_type := COUNT(GROUP,%Closest%.Diff_concurrent_lender_type);
    Count_Diff_concurrent_loan_amt := COUNT(GROUP,%Closest%.Diff_concurrent_loan_amt);
    Count_Diff_concurrent_loan_type := COUNT(GROUP,%Closest%.Diff_concurrent_loan_type);
    Count_Diff_concurrent_type_fin := COUNT(GROUP,%Closest%.Diff_concurrent_type_fin);
    Count_Diff_concurrent_interest_rate := COUNT(GROUP,%Closest%.Diff_concurrent_interest_rate);
    Count_Diff_concurrent_due_dt := COUNT(GROUP,%Closest%.Diff_concurrent_due_dt);
    Count_Diff_concurrent_2nd_loan_amt := COUNT(GROUP,%Closest%.Diff_concurrent_2nd_loan_amt);
    Count_Diff_buyer_mail_full_addr := COUNT(GROUP,%Closest%.Diff_buyer_mail_full_addr);
    Count_Diff_buyer_mail_unit_type := COUNT(GROUP,%Closest%.Diff_buyer_mail_unit_type);
    Count_Diff_buyer_mail_unit_no := COUNT(GROUP,%Closest%.Diff_buyer_mail_unit_no);
    Count_Diff_lps_internal_pid := COUNT(GROUP,%Closest%.Diff_lps_internal_pid);
    Count_Diff_buyer_mail_careof := COUNT(GROUP,%Closest%.Diff_buyer_mail_careof);
    Count_Diff_title_co_name := COUNT(GROUP,%Closest%.Diff_title_co_name);
    Count_Diff_legal_desc_cd := COUNT(GROUP,%Closest%.Diff_legal_desc_cd);
    Count_Diff_adj_rate_rider := COUNT(GROUP,%Closest%.Diff_adj_rate_rider);
    Count_Diff_adj_rate_index := COUNT(GROUP,%Closest%.Diff_adj_rate_index);
    Count_Diff_change_index := COUNT(GROUP,%Closest%.Diff_change_index);
    Count_Diff_rate_change_freq := COUNT(GROUP,%Closest%.Diff_rate_change_freq);
    Count_Diff_int_rate_ngt := COUNT(GROUP,%Closest%.Diff_int_rate_ngt);
    Count_Diff_int_rate_nlt := COUNT(GROUP,%Closest%.Diff_int_rate_nlt);
    Count_Diff_max_int_rate := COUNT(GROUP,%Closest%.Diff_max_int_rate);
    Count_Diff_int_only_period := COUNT(GROUP,%Closest%.Diff_int_only_period);
    Count_Diff_fixed_rate_rider := COUNT(GROUP,%Closest%.Diff_fixed_rate_rider);
    Count_Diff_first_chg_dt_yy := COUNT(GROUP,%Closest%.Diff_first_chg_dt_yy);
    Count_Diff_first_chg_dt_mmdd := COUNT(GROUP,%Closest%.Diff_first_chg_dt_mmdd);
    Count_Diff_prepayment_rider := COUNT(GROUP,%Closest%.Diff_prepayment_rider);
    Count_Diff_prepayment_term := COUNT(GROUP,%Closest%.Diff_prepayment_term);
    Count_Diff_asses_land_use := COUNT(GROUP,%Closest%.Diff_asses_land_use);
    Count_Diff_res_indicator := COUNT(GROUP,%Closest%.Diff_res_indicator);
    Count_Diff_construction_loan := COUNT(GROUP,%Closest%.Diff_construction_loan);
    Count_Diff_inter_family := COUNT(GROUP,%Closest%.Diff_inter_family);
    Count_Diff_cash_purchase := COUNT(GROUP,%Closest%.Diff_cash_purchase);
    Count_Diff_stand_alone_refi := COUNT(GROUP,%Closest%.Diff_stand_alone_refi);
    Count_Diff_equity_credit_line := COUNT(GROUP,%Closest%.Diff_equity_credit_line);
    Count_Diff_reo_flag := COUNT(GROUP,%Closest%.Diff_reo_flag);
    Count_Diff_distressedsaleflag := COUNT(GROUP,%Closest%.Diff_distressedsaleflag);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

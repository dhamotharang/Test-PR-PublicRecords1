IMPORT SALT311;
IMPORT Scrubs,Scrubs_Official_Records; // Import modules for FieldTypes attribute definitions
EXPORT Document_Fields := MODULE
 
EXPORT NumFields := 86;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_Date','Invalid_FutureDate','Invalid_State','Invalid_County','Invalid_NonBlank','Invalid_Char');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_Date' => 2,'Invalid_FutureDate' => 3,'Invalid_State' => 4,'Invalid_County' => 5,'Invalid_NonBlank' => 6,'Invalid_Char' => 7,0);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_FutureDate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_FutureDate(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s,'future')>0);
EXPORT InValidMessageFT_Invalid_FutureDate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['FL','CA']);
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('FL|CA'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_County(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_County(SALT311.StrType s) := WHICH(~Scrubs_Official_Records.fnValidCounty(s)>0);
EXPORT InValidMessageFT_Invalid_County(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Official_Records.fnValidCounty'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_NonBlank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_NonBlank(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_NonBlank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -\''))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -\''),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','vendor','state_origin','county_name','official_record_key','fips_st','fips_county','batch_id','doc_serial_num','doc_instrument_or_clerk_filing_num','doc_num_dummy_flag','doc_filed_dt','doc_record_dt','doc_type_cd','doc_type_desc','doc_other_desc','doc_page_count','doc_names_count','doc_status_cd','doc_status_desc','doc_amend_cd','doc_amend_desc','execution_dt','consideration_amt','assumption_amt','certified_mail_fee','service_charge','trust_amt','transfer_','mortgage','intangible_tax_amt','intangible_tax_penalty','excise_tax_amt','recording_fee','documentary_stamps_fee','doc_stamps_mtg_fee','book_num','page_num','book_type_cd','book_type_desc','parcel_or_case_num','formatted_parcel_num','legal_desc_1','legal_desc_2','legal_desc_3','legal_desc_4','legal_desc_5','verified_flag','address_1','address_2','address_3','address_4','prior_doc_file_num','prior_doc_type_cd','prior_doc_type_desc','prior_book_num','prior_page_num','prior_book_type_cd','prior_book_type_desc','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','ace_fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'process_date','vendor','state_origin','county_name','official_record_key','fips_st','fips_county','batch_id','doc_serial_num','doc_instrument_or_clerk_filing_num','doc_num_dummy_flag','doc_filed_dt','doc_record_dt','doc_type_cd','doc_type_desc','doc_other_desc','doc_page_count','doc_names_count','doc_status_cd','doc_status_desc','doc_amend_cd','doc_amend_desc','execution_dt','consideration_amt','assumption_amt','certified_mail_fee','service_charge','trust_amt','transfer_','mortgage','intangible_tax_amt','intangible_tax_penalty','excise_tax_amt','recording_fee','documentary_stamps_fee','doc_stamps_mtg_fee','book_num','page_num','book_type_cd','book_type_desc','parcel_or_case_num','formatted_parcel_num','legal_desc_1','legal_desc_2','legal_desc_3','legal_desc_4','legal_desc_5','verified_flag','address_1','address_2','address_3','address_4','prior_doc_file_num','prior_doc_type_cd','prior_doc_type_desc','prior_book_num','prior_page_num','prior_book_type_cd','prior_book_type_desc','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','ace_fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'process_date' => 0,'vendor' => 1,'state_origin' => 2,'county_name' => 3,'official_record_key' => 4,'fips_st' => 5,'fips_county' => 6,'batch_id' => 7,'doc_serial_num' => 8,'doc_instrument_or_clerk_filing_num' => 9,'doc_num_dummy_flag' => 10,'doc_filed_dt' => 11,'doc_record_dt' => 12,'doc_type_cd' => 13,'doc_type_desc' => 14,'doc_other_desc' => 15,'doc_page_count' => 16,'doc_names_count' => 17,'doc_status_cd' => 18,'doc_status_desc' => 19,'doc_amend_cd' => 20,'doc_amend_desc' => 21,'execution_dt' => 22,'consideration_amt' => 23,'assumption_amt' => 24,'certified_mail_fee' => 25,'service_charge' => 26,'trust_amt' => 27,'transfer_' => 28,'mortgage' => 29,'intangible_tax_amt' => 30,'intangible_tax_penalty' => 31,'excise_tax_amt' => 32,'recording_fee' => 33,'documentary_stamps_fee' => 34,'doc_stamps_mtg_fee' => 35,'book_num' => 36,'page_num' => 37,'book_type_cd' => 38,'book_type_desc' => 39,'parcel_or_case_num' => 40,'formatted_parcel_num' => 41,'legal_desc_1' => 42,'legal_desc_2' => 43,'legal_desc_3' => 44,'legal_desc_4' => 45,'legal_desc_5' => 46,'verified_flag' => 47,'address_1' => 48,'address_2' => 49,'address_3' => 50,'address_4' => 51,'prior_doc_file_num' => 52,'prior_doc_type_cd' => 53,'prior_doc_type_desc' => 54,'prior_book_num' => 55,'prior_page_num' => 56,'prior_book_type_cd' => 57,'prior_book_type_desc' => 58,'prim_range' => 59,'predir' => 60,'prim_name' => 61,'addr_suffix' => 62,'postdir' => 63,'unit_desig' => 64,'sec_range' => 65,'p_city_name' => 66,'v_city_name' => 67,'st' => 68,'zip' => 69,'zip4' => 70,'cart' => 71,'cr_sort_sz' => 72,'lot' => 73,'lot_order' => 74,'dpbc' => 75,'chk_digit' => 76,'rec_type' => 77,'ace_fips_st' => 78,'ace_fips_county' => 79,'geo_lat' => 80,'geo_long' => 81,'msa' => 82,'geo_blk' => 83,'geo_match' => 84,'err_stat' => 85,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['ALLOW'],['ENUM'],['CUSTOM'],['LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['LENGTHS'],[],['CUSTOM'],['CUSTOM'],[],[],[],['ALLOW'],['ALLOW'],[],[],[],[],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_vendor(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_vendor(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_vendor(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_state_origin(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_state_origin(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_state_origin(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_county_name(SALT311.StrType s0) := MakeFT_Invalid_County(s0);
EXPORT InValid_county_name(SALT311.StrType s) := InValidFT_Invalid_County(s);
EXPORT InValidMessage_county_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_County(wh);
 
EXPORT Make_official_record_key(SALT311.StrType s0) := MakeFT_Invalid_NonBlank(s0);
EXPORT InValid_official_record_key(SALT311.StrType s) := InValidFT_Invalid_NonBlank(s);
EXPORT InValidMessage_official_record_key(UNSIGNED1 wh) := InValidMessageFT_Invalid_NonBlank(wh);
 
EXPORT Make_fips_st(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_fips_st(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_fips_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_fips_county(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_fips_county(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_batch_id(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_batch_id(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_batch_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_doc_serial_num(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_doc_serial_num(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_doc_serial_num(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_doc_instrument_or_clerk_filing_num(SALT311.StrType s0) := MakeFT_Invalid_NonBlank(s0);
EXPORT InValid_doc_instrument_or_clerk_filing_num(SALT311.StrType s) := InValidFT_Invalid_NonBlank(s);
EXPORT InValidMessage_doc_instrument_or_clerk_filing_num(UNSIGNED1 wh) := InValidMessageFT_Invalid_NonBlank(wh);
 
EXPORT Make_doc_num_dummy_flag(SALT311.StrType s0) := s0;
EXPORT InValid_doc_num_dummy_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_doc_num_dummy_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_doc_filed_dt(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_doc_filed_dt(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_doc_filed_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_doc_record_dt(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_doc_record_dt(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_doc_record_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_doc_type_cd(SALT311.StrType s0) := s0;
EXPORT InValid_doc_type_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_doc_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_doc_type_desc(SALT311.StrType s0) := s0;
EXPORT InValid_doc_type_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_doc_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_doc_other_desc(SALT311.StrType s0) := s0;
EXPORT InValid_doc_other_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_doc_other_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_doc_page_count(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_doc_page_count(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_doc_page_count(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_doc_names_count(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_doc_names_count(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_doc_names_count(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_doc_status_cd(SALT311.StrType s0) := s0;
EXPORT InValid_doc_status_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_doc_status_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_doc_status_desc(SALT311.StrType s0) := s0;
EXPORT InValid_doc_status_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_doc_status_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_doc_amend_cd(SALT311.StrType s0) := s0;
EXPORT InValid_doc_amend_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_doc_amend_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_doc_amend_desc(SALT311.StrType s0) := s0;
EXPORT InValid_doc_amend_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_doc_amend_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_execution_dt(SALT311.StrType s0) := MakeFT_Invalid_FutureDate(s0);
EXPORT InValid_execution_dt(SALT311.StrType s) := InValidFT_Invalid_FutureDate(s);
EXPORT InValidMessage_execution_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_FutureDate(wh);
 
EXPORT Make_consideration_amt(SALT311.StrType s0) := s0;
EXPORT InValid_consideration_amt(SALT311.StrType s) := 0;
EXPORT InValidMessage_consideration_amt(UNSIGNED1 wh) := '';
 
EXPORT Make_assumption_amt(SALT311.StrType s0) := s0;
EXPORT InValid_assumption_amt(SALT311.StrType s) := 0;
EXPORT InValidMessage_assumption_amt(UNSIGNED1 wh) := '';
 
EXPORT Make_certified_mail_fee(SALT311.StrType s0) := s0;
EXPORT InValid_certified_mail_fee(SALT311.StrType s) := 0;
EXPORT InValidMessage_certified_mail_fee(UNSIGNED1 wh) := '';
 
EXPORT Make_service_charge(SALT311.StrType s0) := s0;
EXPORT InValid_service_charge(SALT311.StrType s) := 0;
EXPORT InValidMessage_service_charge(UNSIGNED1 wh) := '';
 
EXPORT Make_trust_amt(SALT311.StrType s0) := s0;
EXPORT InValid_trust_amt(SALT311.StrType s) := 0;
EXPORT InValidMessage_trust_amt(UNSIGNED1 wh) := '';
 
EXPORT Make_transfer_(SALT311.StrType s0) := s0;
EXPORT InValid_transfer_(SALT311.StrType s) := 0;
EXPORT InValidMessage_transfer_(UNSIGNED1 wh) := '';
 
EXPORT Make_mortgage(SALT311.StrType s0) := s0;
EXPORT InValid_mortgage(SALT311.StrType s) := 0;
EXPORT InValidMessage_mortgage(UNSIGNED1 wh) := '';
 
EXPORT Make_intangible_tax_amt(SALT311.StrType s0) := s0;
EXPORT InValid_intangible_tax_amt(SALT311.StrType s) := 0;
EXPORT InValidMessage_intangible_tax_amt(UNSIGNED1 wh) := '';
 
EXPORT Make_intangible_tax_penalty(SALT311.StrType s0) := s0;
EXPORT InValid_intangible_tax_penalty(SALT311.StrType s) := 0;
EXPORT InValidMessage_intangible_tax_penalty(UNSIGNED1 wh) := '';
 
EXPORT Make_excise_tax_amt(SALT311.StrType s0) := s0;
EXPORT InValid_excise_tax_amt(SALT311.StrType s) := 0;
EXPORT InValidMessage_excise_tax_amt(UNSIGNED1 wh) := '';
 
EXPORT Make_recording_fee(SALT311.StrType s0) := s0;
EXPORT InValid_recording_fee(SALT311.StrType s) := 0;
EXPORT InValidMessage_recording_fee(UNSIGNED1 wh) := '';
 
EXPORT Make_documentary_stamps_fee(SALT311.StrType s0) := s0;
EXPORT InValid_documentary_stamps_fee(SALT311.StrType s) := 0;
EXPORT InValidMessage_documentary_stamps_fee(UNSIGNED1 wh) := '';
 
EXPORT Make_doc_stamps_mtg_fee(SALT311.StrType s0) := s0;
EXPORT InValid_doc_stamps_mtg_fee(SALT311.StrType s) := 0;
EXPORT InValidMessage_doc_stamps_mtg_fee(UNSIGNED1 wh) := '';
 
EXPORT Make_book_num(SALT311.StrType s0) := s0;
EXPORT InValid_book_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_book_num(UNSIGNED1 wh) := '';
 
EXPORT Make_page_num(SALT311.StrType s0) := s0;
EXPORT InValid_page_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_page_num(UNSIGNED1 wh) := '';
 
EXPORT Make_book_type_cd(SALT311.StrType s0) := s0;
EXPORT InValid_book_type_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_book_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_book_type_desc(SALT311.StrType s0) := s0;
EXPORT InValid_book_type_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_book_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_parcel_or_case_num(SALT311.StrType s0) := s0;
EXPORT InValid_parcel_or_case_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_parcel_or_case_num(UNSIGNED1 wh) := '';
 
EXPORT Make_formatted_parcel_num(SALT311.StrType s0) := s0;
EXPORT InValid_formatted_parcel_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_formatted_parcel_num(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_desc_1(SALT311.StrType s0) := s0;
EXPORT InValid_legal_desc_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_desc_1(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_desc_2(SALT311.StrType s0) := s0;
EXPORT InValid_legal_desc_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_desc_2(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_desc_3(SALT311.StrType s0) := s0;
EXPORT InValid_legal_desc_3(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_desc_3(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_desc_4(SALT311.StrType s0) := s0;
EXPORT InValid_legal_desc_4(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_desc_4(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_desc_5(SALT311.StrType s0) := s0;
EXPORT InValid_legal_desc_5(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_desc_5(UNSIGNED1 wh) := '';
 
EXPORT Make_verified_flag(SALT311.StrType s0) := s0;
EXPORT InValid_verified_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_verified_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_address_1(SALT311.StrType s0) := s0;
EXPORT InValid_address_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_address_1(UNSIGNED1 wh) := '';
 
EXPORT Make_address_2(SALT311.StrType s0) := s0;
EXPORT InValid_address_2(SALT311.StrType s) := 0;
EXPORT InValidMessage_address_2(UNSIGNED1 wh) := '';
 
EXPORT Make_address_3(SALT311.StrType s0) := s0;
EXPORT InValid_address_3(SALT311.StrType s) := 0;
EXPORT InValidMessage_address_3(UNSIGNED1 wh) := '';
 
EXPORT Make_address_4(SALT311.StrType s0) := s0;
EXPORT InValid_address_4(SALT311.StrType s) := 0;
EXPORT InValidMessage_address_4(UNSIGNED1 wh) := '';
 
EXPORT Make_prior_doc_file_num(SALT311.StrType s0) := s0;
EXPORT InValid_prior_doc_file_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_prior_doc_file_num(UNSIGNED1 wh) := '';
 
EXPORT Make_prior_doc_type_cd(SALT311.StrType s0) := s0;
EXPORT InValid_prior_doc_type_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_prior_doc_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_prior_doc_type_desc(SALT311.StrType s0) := s0;
EXPORT InValid_prior_doc_type_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_prior_doc_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_prior_book_num(SALT311.StrType s0) := s0;
EXPORT InValid_prior_book_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_prior_book_num(UNSIGNED1 wh) := '';
 
EXPORT Make_prior_page_num(SALT311.StrType s0) := s0;
EXPORT InValid_prior_page_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_prior_page_num(UNSIGNED1 wh) := '';
 
EXPORT Make_prior_book_type_cd(SALT311.StrType s0) := s0;
EXPORT InValid_prior_book_type_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_prior_book_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_prior_book_type_desc(SALT311.StrType s0) := s0;
EXPORT InValid_prior_book_type_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_prior_book_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT311.StrType s0) := s0;
EXPORT InValid_prim_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT311.StrType s0) := s0;
EXPORT InValid_predir(SALT311.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT311.StrType s0) := s0;
EXPORT InValid_prim_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT311.StrType s0) := s0;
EXPORT InValid_postdir(SALT311.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT311.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT311.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT311.StrType s0) := s0;
EXPORT InValid_sec_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT311.StrType s0) := s0;
EXPORT InValid_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT311.StrType s0) := s0;
EXPORT InValid_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4(SALT311.StrType s0) := s0;
EXPORT InValid_zip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_cart(SALT311.StrType s0) := s0;
EXPORT InValid_cart(SALT311.StrType s) := 0;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz(SALT311.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT311.StrType s) := 0;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_lot(SALT311.StrType s0) := s0;
EXPORT InValid_lot(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_order(SALT311.StrType s0) := s0;
EXPORT InValid_lot_order(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_dpbc(SALT311.StrType s0) := s0;
EXPORT InValid_dpbc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dpbc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT311.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT311.StrType s) := 0;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type(SALT311.StrType s0) := s0;
EXPORT InValid_rec_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_st(SALT311.StrType s0) := s0;
EXPORT InValid_ace_fips_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_county(SALT311.StrType s0) := s0;
EXPORT InValid_ace_fips_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_ace_fips_county(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat(SALT311.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long(SALT311.StrType s0) := s0;
EXPORT InValid_geo_long(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_msa(SALT311.StrType s0) := s0;
EXPORT InValid_msa(SALT311.StrType s) := 0;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk(SALT311.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT311.StrType s0) := s0;
EXPORT InValid_geo_match(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat(SALT311.StrType s0) := s0;
EXPORT InValid_err_stat(SALT311.StrType s) := 0;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Official_Records;
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
    BOOLEAN Diff_vendor;
    BOOLEAN Diff_state_origin;
    BOOLEAN Diff_county_name;
    BOOLEAN Diff_official_record_key;
    BOOLEAN Diff_fips_st;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_batch_id;
    BOOLEAN Diff_doc_serial_num;
    BOOLEAN Diff_doc_instrument_or_clerk_filing_num;
    BOOLEAN Diff_doc_num_dummy_flag;
    BOOLEAN Diff_doc_filed_dt;
    BOOLEAN Diff_doc_record_dt;
    BOOLEAN Diff_doc_type_cd;
    BOOLEAN Diff_doc_type_desc;
    BOOLEAN Diff_doc_other_desc;
    BOOLEAN Diff_doc_page_count;
    BOOLEAN Diff_doc_names_count;
    BOOLEAN Diff_doc_status_cd;
    BOOLEAN Diff_doc_status_desc;
    BOOLEAN Diff_doc_amend_cd;
    BOOLEAN Diff_doc_amend_desc;
    BOOLEAN Diff_execution_dt;
    BOOLEAN Diff_consideration_amt;
    BOOLEAN Diff_assumption_amt;
    BOOLEAN Diff_certified_mail_fee;
    BOOLEAN Diff_service_charge;
    BOOLEAN Diff_trust_amt;
    BOOLEAN Diff_transfer_;
    BOOLEAN Diff_mortgage;
    BOOLEAN Diff_intangible_tax_amt;
    BOOLEAN Diff_intangible_tax_penalty;
    BOOLEAN Diff_excise_tax_amt;
    BOOLEAN Diff_recording_fee;
    BOOLEAN Diff_documentary_stamps_fee;
    BOOLEAN Diff_doc_stamps_mtg_fee;
    BOOLEAN Diff_book_num;
    BOOLEAN Diff_page_num;
    BOOLEAN Diff_book_type_cd;
    BOOLEAN Diff_book_type_desc;
    BOOLEAN Diff_parcel_or_case_num;
    BOOLEAN Diff_formatted_parcel_num;
    BOOLEAN Diff_legal_desc_1;
    BOOLEAN Diff_legal_desc_2;
    BOOLEAN Diff_legal_desc_3;
    BOOLEAN Diff_legal_desc_4;
    BOOLEAN Diff_legal_desc_5;
    BOOLEAN Diff_verified_flag;
    BOOLEAN Diff_address_1;
    BOOLEAN Diff_address_2;
    BOOLEAN Diff_address_3;
    BOOLEAN Diff_address_4;
    BOOLEAN Diff_prior_doc_file_num;
    BOOLEAN Diff_prior_doc_type_cd;
    BOOLEAN Diff_prior_doc_type_desc;
    BOOLEAN Diff_prior_book_num;
    BOOLEAN Diff_prior_page_num;
    BOOLEAN Diff_prior_book_type_cd;
    BOOLEAN Diff_prior_book_type_desc;
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
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_ace_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_vendor := le.vendor <> ri.vendor;
    SELF.Diff_state_origin := le.state_origin <> ri.state_origin;
    SELF.Diff_county_name := le.county_name <> ri.county_name;
    SELF.Diff_official_record_key := le.official_record_key <> ri.official_record_key;
    SELF.Diff_fips_st := le.fips_st <> ri.fips_st;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_batch_id := le.batch_id <> ri.batch_id;
    SELF.Diff_doc_serial_num := le.doc_serial_num <> ri.doc_serial_num;
    SELF.Diff_doc_instrument_or_clerk_filing_num := le.doc_instrument_or_clerk_filing_num <> ri.doc_instrument_or_clerk_filing_num;
    SELF.Diff_doc_num_dummy_flag := le.doc_num_dummy_flag <> ri.doc_num_dummy_flag;
    SELF.Diff_doc_filed_dt := le.doc_filed_dt <> ri.doc_filed_dt;
    SELF.Diff_doc_record_dt := le.doc_record_dt <> ri.doc_record_dt;
    SELF.Diff_doc_type_cd := le.doc_type_cd <> ri.doc_type_cd;
    SELF.Diff_doc_type_desc := le.doc_type_desc <> ri.doc_type_desc;
    SELF.Diff_doc_other_desc := le.doc_other_desc <> ri.doc_other_desc;
    SELF.Diff_doc_page_count := le.doc_page_count <> ri.doc_page_count;
    SELF.Diff_doc_names_count := le.doc_names_count <> ri.doc_names_count;
    SELF.Diff_doc_status_cd := le.doc_status_cd <> ri.doc_status_cd;
    SELF.Diff_doc_status_desc := le.doc_status_desc <> ri.doc_status_desc;
    SELF.Diff_doc_amend_cd := le.doc_amend_cd <> ri.doc_amend_cd;
    SELF.Diff_doc_amend_desc := le.doc_amend_desc <> ri.doc_amend_desc;
    SELF.Diff_execution_dt := le.execution_dt <> ri.execution_dt;
    SELF.Diff_consideration_amt := le.consideration_amt <> ri.consideration_amt;
    SELF.Diff_assumption_amt := le.assumption_amt <> ri.assumption_amt;
    SELF.Diff_certified_mail_fee := le.certified_mail_fee <> ri.certified_mail_fee;
    SELF.Diff_service_charge := le.service_charge <> ri.service_charge;
    SELF.Diff_trust_amt := le.trust_amt <> ri.trust_amt;
    SELF.Diff_transfer_ := le.transfer_ <> ri.transfer_;
    SELF.Diff_mortgage := le.mortgage <> ri.mortgage;
    SELF.Diff_intangible_tax_amt := le.intangible_tax_amt <> ri.intangible_tax_amt;
    SELF.Diff_intangible_tax_penalty := le.intangible_tax_penalty <> ri.intangible_tax_penalty;
    SELF.Diff_excise_tax_amt := le.excise_tax_amt <> ri.excise_tax_amt;
    SELF.Diff_recording_fee := le.recording_fee <> ri.recording_fee;
    SELF.Diff_documentary_stamps_fee := le.documentary_stamps_fee <> ri.documentary_stamps_fee;
    SELF.Diff_doc_stamps_mtg_fee := le.doc_stamps_mtg_fee <> ri.doc_stamps_mtg_fee;
    SELF.Diff_book_num := le.book_num <> ri.book_num;
    SELF.Diff_page_num := le.page_num <> ri.page_num;
    SELF.Diff_book_type_cd := le.book_type_cd <> ri.book_type_cd;
    SELF.Diff_book_type_desc := le.book_type_desc <> ri.book_type_desc;
    SELF.Diff_parcel_or_case_num := le.parcel_or_case_num <> ri.parcel_or_case_num;
    SELF.Diff_formatted_parcel_num := le.formatted_parcel_num <> ri.formatted_parcel_num;
    SELF.Diff_legal_desc_1 := le.legal_desc_1 <> ri.legal_desc_1;
    SELF.Diff_legal_desc_2 := le.legal_desc_2 <> ri.legal_desc_2;
    SELF.Diff_legal_desc_3 := le.legal_desc_3 <> ri.legal_desc_3;
    SELF.Diff_legal_desc_4 := le.legal_desc_4 <> ri.legal_desc_4;
    SELF.Diff_legal_desc_5 := le.legal_desc_5 <> ri.legal_desc_5;
    SELF.Diff_verified_flag := le.verified_flag <> ri.verified_flag;
    SELF.Diff_address_1 := le.address_1 <> ri.address_1;
    SELF.Diff_address_2 := le.address_2 <> ri.address_2;
    SELF.Diff_address_3 := le.address_3 <> ri.address_3;
    SELF.Diff_address_4 := le.address_4 <> ri.address_4;
    SELF.Diff_prior_doc_file_num := le.prior_doc_file_num <> ri.prior_doc_file_num;
    SELF.Diff_prior_doc_type_cd := le.prior_doc_type_cd <> ri.prior_doc_type_cd;
    SELF.Diff_prior_doc_type_desc := le.prior_doc_type_desc <> ri.prior_doc_type_desc;
    SELF.Diff_prior_book_num := le.prior_book_num <> ri.prior_book_num;
    SELF.Diff_prior_page_num := le.prior_page_num <> ri.prior_page_num;
    SELF.Diff_prior_book_type_cd := le.prior_book_type_cd <> ri.prior_book_type_cd;
    SELF.Diff_prior_book_type_desc := le.prior_book_type_desc <> ri.prior_book_type_desc;
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
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_ace_fips_county := le.ace_fips_county <> ri.ace_fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_vendor,1,0)+ IF( SELF.Diff_state_origin,1,0)+ IF( SELF.Diff_county_name,1,0)+ IF( SELF.Diff_official_record_key,1,0)+ IF( SELF.Diff_fips_st,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_batch_id,1,0)+ IF( SELF.Diff_doc_serial_num,1,0)+ IF( SELF.Diff_doc_instrument_or_clerk_filing_num,1,0)+ IF( SELF.Diff_doc_num_dummy_flag,1,0)+ IF( SELF.Diff_doc_filed_dt,1,0)+ IF( SELF.Diff_doc_record_dt,1,0)+ IF( SELF.Diff_doc_type_cd,1,0)+ IF( SELF.Diff_doc_type_desc,1,0)+ IF( SELF.Diff_doc_other_desc,1,0)+ IF( SELF.Diff_doc_page_count,1,0)+ IF( SELF.Diff_doc_names_count,1,0)+ IF( SELF.Diff_doc_status_cd,1,0)+ IF( SELF.Diff_doc_status_desc,1,0)+ IF( SELF.Diff_doc_amend_cd,1,0)+ IF( SELF.Diff_doc_amend_desc,1,0)+ IF( SELF.Diff_execution_dt,1,0)+ IF( SELF.Diff_consideration_amt,1,0)+ IF( SELF.Diff_assumption_amt,1,0)+ IF( SELF.Diff_certified_mail_fee,1,0)+ IF( SELF.Diff_service_charge,1,0)+ IF( SELF.Diff_trust_amt,1,0)+ IF( SELF.Diff_transfer_,1,0)+ IF( SELF.Diff_mortgage,1,0)+ IF( SELF.Diff_intangible_tax_amt,1,0)+ IF( SELF.Diff_intangible_tax_penalty,1,0)+ IF( SELF.Diff_excise_tax_amt,1,0)+ IF( SELF.Diff_recording_fee,1,0)+ IF( SELF.Diff_documentary_stamps_fee,1,0)+ IF( SELF.Diff_doc_stamps_mtg_fee,1,0)+ IF( SELF.Diff_book_num,1,0)+ IF( SELF.Diff_page_num,1,0)+ IF( SELF.Diff_book_type_cd,1,0)+ IF( SELF.Diff_book_type_desc,1,0)+ IF( SELF.Diff_parcel_or_case_num,1,0)+ IF( SELF.Diff_formatted_parcel_num,1,0)+ IF( SELF.Diff_legal_desc_1,1,0)+ IF( SELF.Diff_legal_desc_2,1,0)+ IF( SELF.Diff_legal_desc_3,1,0)+ IF( SELF.Diff_legal_desc_4,1,0)+ IF( SELF.Diff_legal_desc_5,1,0)+ IF( SELF.Diff_verified_flag,1,0)+ IF( SELF.Diff_address_1,1,0)+ IF( SELF.Diff_address_2,1,0)+ IF( SELF.Diff_address_3,1,0)+ IF( SELF.Diff_address_4,1,0)+ IF( SELF.Diff_prior_doc_file_num,1,0)+ IF( SELF.Diff_prior_doc_type_cd,1,0)+ IF( SELF.Diff_prior_doc_type_desc,1,0)+ IF( SELF.Diff_prior_book_num,1,0)+ IF( SELF.Diff_prior_page_num,1,0)+ IF( SELF.Diff_prior_book_type_cd,1,0)+ IF( SELF.Diff_prior_book_type_desc,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_ace_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0);
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
    Count_Diff_vendor := COUNT(GROUP,%Closest%.Diff_vendor);
    Count_Diff_state_origin := COUNT(GROUP,%Closest%.Diff_state_origin);
    Count_Diff_county_name := COUNT(GROUP,%Closest%.Diff_county_name);
    Count_Diff_official_record_key := COUNT(GROUP,%Closest%.Diff_official_record_key);
    Count_Diff_fips_st := COUNT(GROUP,%Closest%.Diff_fips_st);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_batch_id := COUNT(GROUP,%Closest%.Diff_batch_id);
    Count_Diff_doc_serial_num := COUNT(GROUP,%Closest%.Diff_doc_serial_num);
    Count_Diff_doc_instrument_or_clerk_filing_num := COUNT(GROUP,%Closest%.Diff_doc_instrument_or_clerk_filing_num);
    Count_Diff_doc_num_dummy_flag := COUNT(GROUP,%Closest%.Diff_doc_num_dummy_flag);
    Count_Diff_doc_filed_dt := COUNT(GROUP,%Closest%.Diff_doc_filed_dt);
    Count_Diff_doc_record_dt := COUNT(GROUP,%Closest%.Diff_doc_record_dt);
    Count_Diff_doc_type_cd := COUNT(GROUP,%Closest%.Diff_doc_type_cd);
    Count_Diff_doc_type_desc := COUNT(GROUP,%Closest%.Diff_doc_type_desc);
    Count_Diff_doc_other_desc := COUNT(GROUP,%Closest%.Diff_doc_other_desc);
    Count_Diff_doc_page_count := COUNT(GROUP,%Closest%.Diff_doc_page_count);
    Count_Diff_doc_names_count := COUNT(GROUP,%Closest%.Diff_doc_names_count);
    Count_Diff_doc_status_cd := COUNT(GROUP,%Closest%.Diff_doc_status_cd);
    Count_Diff_doc_status_desc := COUNT(GROUP,%Closest%.Diff_doc_status_desc);
    Count_Diff_doc_amend_cd := COUNT(GROUP,%Closest%.Diff_doc_amend_cd);
    Count_Diff_doc_amend_desc := COUNT(GROUP,%Closest%.Diff_doc_amend_desc);
    Count_Diff_execution_dt := COUNT(GROUP,%Closest%.Diff_execution_dt);
    Count_Diff_consideration_amt := COUNT(GROUP,%Closest%.Diff_consideration_amt);
    Count_Diff_assumption_amt := COUNT(GROUP,%Closest%.Diff_assumption_amt);
    Count_Diff_certified_mail_fee := COUNT(GROUP,%Closest%.Diff_certified_mail_fee);
    Count_Diff_service_charge := COUNT(GROUP,%Closest%.Diff_service_charge);
    Count_Diff_trust_amt := COUNT(GROUP,%Closest%.Diff_trust_amt);
    Count_Diff_transfer_ := COUNT(GROUP,%Closest%.Diff_transfer_);
    Count_Diff_mortgage := COUNT(GROUP,%Closest%.Diff_mortgage);
    Count_Diff_intangible_tax_amt := COUNT(GROUP,%Closest%.Diff_intangible_tax_amt);
    Count_Diff_intangible_tax_penalty := COUNT(GROUP,%Closest%.Diff_intangible_tax_penalty);
    Count_Diff_excise_tax_amt := COUNT(GROUP,%Closest%.Diff_excise_tax_amt);
    Count_Diff_recording_fee := COUNT(GROUP,%Closest%.Diff_recording_fee);
    Count_Diff_documentary_stamps_fee := COUNT(GROUP,%Closest%.Diff_documentary_stamps_fee);
    Count_Diff_doc_stamps_mtg_fee := COUNT(GROUP,%Closest%.Diff_doc_stamps_mtg_fee);
    Count_Diff_book_num := COUNT(GROUP,%Closest%.Diff_book_num);
    Count_Diff_page_num := COUNT(GROUP,%Closest%.Diff_page_num);
    Count_Diff_book_type_cd := COUNT(GROUP,%Closest%.Diff_book_type_cd);
    Count_Diff_book_type_desc := COUNT(GROUP,%Closest%.Diff_book_type_desc);
    Count_Diff_parcel_or_case_num := COUNT(GROUP,%Closest%.Diff_parcel_or_case_num);
    Count_Diff_formatted_parcel_num := COUNT(GROUP,%Closest%.Diff_formatted_parcel_num);
    Count_Diff_legal_desc_1 := COUNT(GROUP,%Closest%.Diff_legal_desc_1);
    Count_Diff_legal_desc_2 := COUNT(GROUP,%Closest%.Diff_legal_desc_2);
    Count_Diff_legal_desc_3 := COUNT(GROUP,%Closest%.Diff_legal_desc_3);
    Count_Diff_legal_desc_4 := COUNT(GROUP,%Closest%.Diff_legal_desc_4);
    Count_Diff_legal_desc_5 := COUNT(GROUP,%Closest%.Diff_legal_desc_5);
    Count_Diff_verified_flag := COUNT(GROUP,%Closest%.Diff_verified_flag);
    Count_Diff_address_1 := COUNT(GROUP,%Closest%.Diff_address_1);
    Count_Diff_address_2 := COUNT(GROUP,%Closest%.Diff_address_2);
    Count_Diff_address_3 := COUNT(GROUP,%Closest%.Diff_address_3);
    Count_Diff_address_4 := COUNT(GROUP,%Closest%.Diff_address_4);
    Count_Diff_prior_doc_file_num := COUNT(GROUP,%Closest%.Diff_prior_doc_file_num);
    Count_Diff_prior_doc_type_cd := COUNT(GROUP,%Closest%.Diff_prior_doc_type_cd);
    Count_Diff_prior_doc_type_desc := COUNT(GROUP,%Closest%.Diff_prior_doc_type_desc);
    Count_Diff_prior_book_num := COUNT(GROUP,%Closest%.Diff_prior_book_num);
    Count_Diff_prior_page_num := COUNT(GROUP,%Closest%.Diff_prior_page_num);
    Count_Diff_prior_book_type_cd := COUNT(GROUP,%Closest%.Diff_prior_book_type_cd);
    Count_Diff_prior_book_type_desc := COUNT(GROUP,%Closest%.Diff_prior_book_type_desc);
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
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_ace_fips_county := COUNT(GROUP,%Closest%.Diff_ace_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

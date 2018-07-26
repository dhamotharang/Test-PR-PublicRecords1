IMPORT SALT311;
IMPORT Scrubs,Scrubs_LN_PropertyV2_Assessor; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 118;
EXPORT invalid_fipsDCT := DICTIONARY(Scrubs_LN_PropertyV2_Assessor.file_fips,{fips_code => Scrubs_LN_PropertyV2_Assessor.file_fips});
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_char','invalid_address','invalid_apn','invalid_county_name','invalid_vendor_source','invalid_from_file','invalid_buyer_or_borrower_ind','invalid_date','invalid_date_future','invalid_zip','invalid_fips','invalid_zcs','invalid_prop_amount','invalid_amount','invalid_state_code','invalid_document_type_code','invalid_legal_lot_code','invalid_sales_price_code','invalid_property_use_code','invalid_condo_code','invalid_loan_type_code','invalid_lender_type_code','invalid_name1_id_code','invalid_vesting_code','invalid_seller1_id_code','invalid_seller2_id_code','invalid_record_type','invalid_type_financing','invalid_rate_change_frequency','invalid_adjustable_rate_index','invalid_fixed_step_rate_ride');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_char' => 2,'invalid_address' => 3,'invalid_apn' => 4,'invalid_county_name' => 5,'invalid_vendor_source' => 6,'invalid_from_file' => 7,'invalid_buyer_or_borrower_ind' => 8,'invalid_date' => 9,'invalid_date_future' => 10,'invalid_zip' => 11,'invalid_fips' => 12,'invalid_zcs' => 13,'invalid_prop_amount' => 14,'invalid_amount' => 15,'invalid_state_code' => 16,'invalid_document_type_code' => 17,'invalid_legal_lot_code' => 18,'invalid_sales_price_code' => 19,'invalid_property_use_code' => 20,'invalid_condo_code' => 21,'invalid_loan_type_code' => 22,'invalid_lender_type_code' => 23,'invalid_name1_id_code' => 24,'invalid_vesting_code' => 25,'invalid_seller1_id_code' => 26,'invalid_seller2_id_code' => 27,'invalid_record_type' => 28,'invalid_type_financing' => 29,'invalid_rate_change_frequency' => 30,'invalid_adjustable_rate_index' => 31,'invalid_fixed_step_rate_ride' => 32,0);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' &(),-/.\'#:;*;ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' &(),-/.\'#:;*;ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' &(),-/.\'#:;*;ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' &(),-/.\'#:;*;ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' &(),-/.\'#:;*;ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_invalid_char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' &(),-/.\'#:;*;ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_address(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_apn(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' _-.,/:&()*0123456789:;ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_apn(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' _-.,/:&()*0123456789:;ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_apn(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' _-.,/:&()*0123456789:;ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_county_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_county_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'))),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' -',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' -',' ')) = 2 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' -',' ')) = 3 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' -',' ')) = 4 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' -',' ')) = 5));
EXPORT InValidMessageFT_invalid_county_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'),SALT311.HygieneErrors.NotWords('1,2,3,4,5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_vendor_source(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_vendor_source(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['F','D','O','S']);
EXPORT InValidMessageFT_invalid_vendor_source(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('F|D|O|S'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_from_file(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_from_file(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['F','M','D']);
EXPORT InValidMessageFT_invalid_from_file(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('F|M|D'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_buyer_or_borrower_ind(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_buyer_or_borrower_ind(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['B','O']);
EXPORT InValidMessageFT_invalid_buyer_or_borrower_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('B|O'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.NotLength('0..8'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date_future(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date_future(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s,'F')>0,~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 8));
EXPORT InValidMessageFT_invalid_date_future(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.NotLength('0..8'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('5,9'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_fips(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),((SALT311.StrType) s) NOT IN invalid_fipsDCT,~(LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_fips(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('5'),SALT311.HygieneErrors.NotWithinFile('Scrubs_LN_PropertyV2_Assessor.file_fips'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zcs(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ,-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_zcs(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ,-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_invalid_zcs(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ,-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_prop_amount(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_prop_amount(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789.'))));
EXPORT InValidMessageFT_invalid_prop_amount(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789.'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_amount(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_amount(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789.'))));
EXPORT InValidMessageFT_invalid_amount(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789.'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ'); // Only allow valid symbols
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_invalid_state_code(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ'),SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_document_type_code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' -.:ABCDEFGHIJKLMNOPQRSTUVWXYZ/():,&\'- '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_document_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' -.:ABCDEFGHIJKLMNOPQRSTUVWXYZ/():,&\'- '))),~Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property(s,vendor_source_flag,'DOCUMENT_TYPE_CODE','FARES_1080')>0);
EXPORT InValidMessageFT_invalid_document_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' -.:ABCDEFGHIJKLMNOPQRSTUVWXYZ/():,&\'- '),SALT311.HygieneErrors.CustomFail('Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_legal_lot_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_legal_lot_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property(s,vendor_source_flag,'LEGAL_LOT_CODE','FARES_1080')>0);
EXPORT InValidMessageFT_invalid_legal_lot_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sales_price_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sales_price_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property(s,vendor_source_flag,'SALE_CODE','FARES_1080')>0);
EXPORT InValidMessageFT_invalid_sales_price_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_property_use_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_property_use_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property(s,vendor_source_flag,'PROPERTY_INDICATOR_CODE','FARES_1080')>0);
EXPORT InValidMessageFT_invalid_property_use_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_condo_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_condo_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property(s,vendor_source_flag,'CONDO_CODE','FARES_1080')>0);
EXPORT InValidMessageFT_invalid_condo_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_loan_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_loan_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property(s,vendor_source_flag,'MORTGAGE_LOAN_TYPE_CODE','FARES_1080')>0);
EXPORT InValidMessageFT_invalid_loan_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lender_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lender_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property(s,vendor_source_flag,'FIRST_TD_LENDER_TYPE_CODE','FARES_1080')>0);
EXPORT InValidMessageFT_invalid_lender_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name1_id_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name1_id_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property(s,vendor_source_flag,'BUYER1_ID_CODE','FARES_1080')>0);
EXPORT InValidMessageFT_invalid_name1_id_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_vesting_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_vesting_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property(s,vendor_source_flag,'BUYER_VESTING_CODE','FARES_1080')>0);
EXPORT InValidMessageFT_invalid_vesting_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_seller1_id_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_seller1_id_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property(s,vendor_source_flag,'SELLER1_ID_CODE','FARES_1080')>0);
EXPORT InValidMessageFT_invalid_seller1_id_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_seller2_id_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_seller2_id_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property(s,vendor_source_flag,'SELLER2_ID_CODE','FARES_1080')>0);
EXPORT InValidMessageFT_invalid_seller2_id_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property(s,vendor_source_flag,'RECORD_TYPE','FARES_1080')>0);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_type_financing(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_type_financing(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property(s,vendor_source_flag,'TYPE_FINANCING','FARES_1080')>0);
EXPORT InValidMessageFT_invalid_type_financing(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_rate_change_frequency(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rate_change_frequency(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property(s,vendor_source_flag,'RATE_CHANGE_FREQUENCY','FARES_1080')>0);
EXPORT InValidMessageFT_invalid_rate_change_frequency(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_adjustable_rate_index(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_adjustable_rate_index(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property(s,vendor_source_flag,'ADJUSTABLE_RATE_INDEX','FARES_1080')>0);
EXPORT InValidMessageFT_invalid_adjustable_rate_index(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fixed_step_rate_ride(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fixed_step_rate_ride(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property(s,vendor_source_flag,'FIXED_STEP_RATE_RIDER','FARES_1080')>0);
EXPORT InValidMessageFT_invalid_fixed_step_rate_ride(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'ln_fares_id','process_date','vendor_source_flag','current_record','from_file','fips_code','state','county_name','record_type','apnt_or_pin_number','fares_unformatted_apn','multi_apn_flag','tax_id_number','excise_tax_number','buyer_or_borrower_ind','name1','name1_id_code','name2','name2_id_code','vesting_code','addendum_flag','phone_number','mailing_care_of','mailing_street','mailing_unit_number','mailing_csz','mailing_address_cd','seller1','seller1_id_code','seller2','seller2_id_code','seller_addendum_flag','seller_mailing_full_street_address','seller_mailing_address_unit_number','seller_mailing_address_citystatezip','property_full_street_address','property_address_unit_number','property_address_citystatezip','property_address_code','legal_lot_code','legal_lot_number','legal_block','legal_section','legal_district','legal_land_lot','legal_unit','legal_city_municipality_township','legal_subdivision_name','legal_phase_number','legal_tract_number','legal_sec_twn_rng_mer','legal_brief_description','recorder_map_reference','complete_legal_description_code','contract_date','recording_date','arm_reset_date','document_number','document_type_code','loan_number','recorder_book_number','recorder_page_number','concurrent_mortgage_book_page_document_number','sales_price','sales_price_code','city_transfer_tax','county_transfer_tax','total_transfer_tax','first_td_loan_amount','second_td_loan_amount','first_td_lender_type_code','second_td_lender_type_code','first_td_loan_type_code','type_financing','first_td_interest_rate','first_td_due_date','title_company_name','partial_interest_transferred','loan_term_months','loan_term_years','lender_name','lender_name_id','lender_dba_aka_name','lender_full_street_address','lender_address_unit_number','lender_address_citystatezip','assessment_match_land_use_code','property_use_code','condo_code','timeshare_flag','land_lot_size','hawaii_tct','hawaii_condo_cpr_code','hawaii_condo_name','filler_except_hawaii','rate_change_frequency','change_index','adjustable_rate_index','adjustable_rate_rider','graduated_payment_rider','balloon_rider','fixed_step_rate_rider','condominium_rider','planned_unit_development_rider','rate_improvement_rider','assumability_rider','prepayment_rider','one_four_family_rider','biweekly_payment_rider','second_home_rider','data_source_code','main_record_id_code','addl_name_flag','prop_addr_propagated_ind','ln_ownership_rights','ln_relationship_type','ln_buyer_mailing_country_code','ln_seller_mailing_country_code');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'ln_fares_id','process_date','vendor_source_flag','current_record','from_file','fips_code','state','county_name','record_type','apnt_or_pin_number','fares_unformatted_apn','multi_apn_flag','tax_id_number','excise_tax_number','buyer_or_borrower_ind','name1','name1_id_code','name2','name2_id_code','vesting_code','addendum_flag','phone_number','mailing_care_of','mailing_street','mailing_unit_number','mailing_csz','mailing_address_cd','seller1','seller1_id_code','seller2','seller2_id_code','seller_addendum_flag','seller_mailing_full_street_address','seller_mailing_address_unit_number','seller_mailing_address_citystatezip','property_full_street_address','property_address_unit_number','property_address_citystatezip','property_address_code','legal_lot_code','legal_lot_number','legal_block','legal_section','legal_district','legal_land_lot','legal_unit','legal_city_municipality_township','legal_subdivision_name','legal_phase_number','legal_tract_number','legal_sec_twn_rng_mer','legal_brief_description','recorder_map_reference','complete_legal_description_code','contract_date','recording_date','arm_reset_date','document_number','document_type_code','loan_number','recorder_book_number','recorder_page_number','concurrent_mortgage_book_page_document_number','sales_price','sales_price_code','city_transfer_tax','county_transfer_tax','total_transfer_tax','first_td_loan_amount','second_td_loan_amount','first_td_lender_type_code','second_td_lender_type_code','first_td_loan_type_code','type_financing','first_td_interest_rate','first_td_due_date','title_company_name','partial_interest_transferred','loan_term_months','loan_term_years','lender_name','lender_name_id','lender_dba_aka_name','lender_full_street_address','lender_address_unit_number','lender_address_citystatezip','assessment_match_land_use_code','property_use_code','condo_code','timeshare_flag','land_lot_size','hawaii_tct','hawaii_condo_cpr_code','hawaii_condo_name','filler_except_hawaii','rate_change_frequency','change_index','adjustable_rate_index','adjustable_rate_rider','graduated_payment_rider','balloon_rider','fixed_step_rate_rider','condominium_rider','planned_unit_development_rider','rate_improvement_rider','assumability_rider','prepayment_rider','one_four_family_rider','biweekly_payment_rider','second_home_rider','data_source_code','main_record_id_code','addl_name_flag','prop_addr_propagated_ind','ln_ownership_rights','ln_relationship_type','ln_buyer_mailing_country_code','ln_seller_mailing_country_code');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'ln_fares_id' => 0,'process_date' => 1,'vendor_source_flag' => 2,'current_record' => 3,'from_file' => 4,'fips_code' => 5,'state' => 6,'county_name' => 7,'record_type' => 8,'apnt_or_pin_number' => 9,'fares_unformatted_apn' => 10,'multi_apn_flag' => 11,'tax_id_number' => 12,'excise_tax_number' => 13,'buyer_or_borrower_ind' => 14,'name1' => 15,'name1_id_code' => 16,'name2' => 17,'name2_id_code' => 18,'vesting_code' => 19,'addendum_flag' => 20,'phone_number' => 21,'mailing_care_of' => 22,'mailing_street' => 23,'mailing_unit_number' => 24,'mailing_csz' => 25,'mailing_address_cd' => 26,'seller1' => 27,'seller1_id_code' => 28,'seller2' => 29,'seller2_id_code' => 30,'seller_addendum_flag' => 31,'seller_mailing_full_street_address' => 32,'seller_mailing_address_unit_number' => 33,'seller_mailing_address_citystatezip' => 34,'property_full_street_address' => 35,'property_address_unit_number' => 36,'property_address_citystatezip' => 37,'property_address_code' => 38,'legal_lot_code' => 39,'legal_lot_number' => 40,'legal_block' => 41,'legal_section' => 42,'legal_district' => 43,'legal_land_lot' => 44,'legal_unit' => 45,'legal_city_municipality_township' => 46,'legal_subdivision_name' => 47,'legal_phase_number' => 48,'legal_tract_number' => 49,'legal_sec_twn_rng_mer' => 50,'legal_brief_description' => 51,'recorder_map_reference' => 52,'complete_legal_description_code' => 53,'contract_date' => 54,'recording_date' => 55,'arm_reset_date' => 56,'document_number' => 57,'document_type_code' => 58,'loan_number' => 59,'recorder_book_number' => 60,'recorder_page_number' => 61,'concurrent_mortgage_book_page_document_number' => 62,'sales_price' => 63,'sales_price_code' => 64,'city_transfer_tax' => 65,'county_transfer_tax' => 66,'total_transfer_tax' => 67,'first_td_loan_amount' => 68,'second_td_loan_amount' => 69,'first_td_lender_type_code' => 70,'second_td_lender_type_code' => 71,'first_td_loan_type_code' => 72,'type_financing' => 73,'first_td_interest_rate' => 74,'first_td_due_date' => 75,'title_company_name' => 76,'partial_interest_transferred' => 77,'loan_term_months' => 78,'loan_term_years' => 79,'lender_name' => 80,'lender_name_id' => 81,'lender_dba_aka_name' => 82,'lender_full_street_address' => 83,'lender_address_unit_number' => 84,'lender_address_citystatezip' => 85,'assessment_match_land_use_code' => 86,'property_use_code' => 87,'condo_code' => 88,'timeshare_flag' => 89,'land_lot_size' => 90,'hawaii_tct' => 91,'hawaii_condo_cpr_code' => 92,'hawaii_condo_name' => 93,'filler_except_hawaii' => 94,'rate_change_frequency' => 95,'change_index' => 96,'adjustable_rate_index' => 97,'adjustable_rate_rider' => 98,'graduated_payment_rider' => 99,'balloon_rider' => 100,'fixed_step_rate_rider' => 101,'condominium_rider' => 102,'planned_unit_development_rider' => 103,'rate_improvement_rider' => 104,'assumability_rider' => 105,'prepayment_rider' => 106,'one_four_family_rider' => 107,'biweekly_payment_rider' => 108,'second_home_rider' => 109,'data_source_code' => 110,'main_record_id_code' => 111,'addl_name_flag' => 112,'prop_addr_propagated_ind' => 113,'ln_ownership_rights' => 114,'ln_relationship_type' => 115,'ln_buyer_mailing_country_code' => 116,'ln_seller_mailing_country_code' => 117,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],['ALLOW','CUSTOM','LENGTHS'],['ENUM'],[],['ENUM'],['ALLOW','LENGTHS','WITHIN_FILE'],['LEFTTRIM','ALLOW','LENGTHS'],['ALLOW','WORDS'],['CUSTOM'],['ALLOW'],['ALLOW'],[],[],[],['ENUM'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],[],['ALLOW'],[],[],['ALLOW'],[],['ALLOW'],[],['CUSTOM'],[],[],[],[],[],[],[],[],['ALLOW'],[],[],[],[],[],['ALLOW','CUSTOM','LENGTHS'],['ALLOW','CUSTOM','LENGTHS'],['ALLOW','CUSTOM','LENGTHS'],[],['ALLOW','CUSTOM'],[],[],[],[],['ALLOW'],['CUSTOM'],[],[],[],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW','CUSTOM','LENGTHS'],[],[],[],[],[],[],[],['ALLOW'],[],['ALLOW'],[],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],['CUSTOM'],[],['CUSTOM'],[],[],[],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_ln_fares_id(SALT311.StrType s0) := s0;
EXPORT InValid_ln_fares_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_fares_id(UNSIGNED1 wh) := '';
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_vendor_source_flag(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_vendor_source_flag(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_vendor_source_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_current_record(SALT311.StrType s0) := s0;
EXPORT InValid_current_record(SALT311.StrType s) := 0;
EXPORT InValidMessage_current_record(UNSIGNED1 wh) := '';
 
EXPORT Make_from_file(SALT311.StrType s0) := MakeFT_invalid_from_file(s0);
EXPORT InValid_from_file(SALT311.StrType s) := InValidFT_invalid_from_file(s);
EXPORT InValidMessage_from_file(UNSIGNED1 wh) := InValidMessageFT_invalid_from_file(wh);
 
EXPORT Make_fips_code(SALT311.StrType s0) := MakeFT_invalid_fips(s0);
EXPORT InValid_fips_code(SALT311.StrType s) := InValidFT_invalid_fips(s);
EXPORT InValidMessage_fips_code(UNSIGNED1 wh) := InValidMessageFT_invalid_fips(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_invalid_state_code(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_invalid_state_code(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state_code(wh);
 
EXPORT Make_county_name(SALT311.StrType s0) := MakeFT_invalid_county_name(s0);
EXPORT InValid_county_name(SALT311.StrType s) := InValidFT_invalid_county_name(s);
EXPORT InValidMessage_county_name(UNSIGNED1 wh) := InValidMessageFT_invalid_county_name(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_record_type(s,vendor_source_flag);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_apnt_or_pin_number(SALT311.StrType s0) := MakeFT_invalid_apn(s0);
EXPORT InValid_apnt_or_pin_number(SALT311.StrType s) := InValidFT_invalid_apn(s);
EXPORT InValidMessage_apnt_or_pin_number(UNSIGNED1 wh) := InValidMessageFT_invalid_apn(wh);
 
EXPORT Make_fares_unformatted_apn(SALT311.StrType s0) := MakeFT_invalid_apn(s0);
EXPORT InValid_fares_unformatted_apn(SALT311.StrType s) := InValidFT_invalid_apn(s);
EXPORT InValidMessage_fares_unformatted_apn(UNSIGNED1 wh) := InValidMessageFT_invalid_apn(wh);
 
EXPORT Make_multi_apn_flag(SALT311.StrType s0) := s0;
EXPORT InValid_multi_apn_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_multi_apn_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_tax_id_number(SALT311.StrType s0) := s0;
EXPORT InValid_tax_id_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_tax_id_number(UNSIGNED1 wh) := '';
 
EXPORT Make_excise_tax_number(SALT311.StrType s0) := s0;
EXPORT InValid_excise_tax_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_excise_tax_number(UNSIGNED1 wh) := '';
 
EXPORT Make_buyer_or_borrower_ind(SALT311.StrType s0) := MakeFT_invalid_buyer_or_borrower_ind(s0);
EXPORT InValid_buyer_or_borrower_ind(SALT311.StrType s) := InValidFT_invalid_buyer_or_borrower_ind(s);
EXPORT InValidMessage_buyer_or_borrower_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_buyer_or_borrower_ind(wh);
 
EXPORT Make_name1(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_name1(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_name1(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_name1_id_code(SALT311.StrType s0) := MakeFT_invalid_name1_id_code(s0);
EXPORT InValid_name1_id_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_name1_id_code(s,vendor_source_flag);
EXPORT InValidMessage_name1_id_code(UNSIGNED1 wh) := InValidMessageFT_invalid_name1_id_code(wh);
 
EXPORT Make_name2(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_name2(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_name2(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_name2_id_code(SALT311.StrType s0) := MakeFT_invalid_name1_id_code(s0);
EXPORT InValid_name2_id_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_name1_id_code(s,vendor_source_flag);
EXPORT InValidMessage_name2_id_code(UNSIGNED1 wh) := InValidMessageFT_invalid_name1_id_code(wh);
 
EXPORT Make_vesting_code(SALT311.StrType s0) := MakeFT_invalid_vesting_code(s0);
EXPORT InValid_vesting_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_vesting_code(s,vendor_source_flag);
EXPORT InValidMessage_vesting_code(UNSIGNED1 wh) := InValidMessageFT_invalid_vesting_code(wh);
 
EXPORT Make_addendum_flag(SALT311.StrType s0) := s0;
EXPORT InValid_addendum_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_addendum_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_phone_number(SALT311.StrType s0) := s0;
EXPORT InValid_phone_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_phone_number(UNSIGNED1 wh) := '';
 
EXPORT Make_mailing_care_of(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_mailing_care_of(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_mailing_care_of(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_mailing_street(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_mailing_street(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_mailing_street(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_mailing_unit_number(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_mailing_unit_number(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_mailing_unit_number(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_mailing_csz(SALT311.StrType s0) := MakeFT_invalid_zcs(s0);
EXPORT InValid_mailing_csz(SALT311.StrType s) := InValidFT_invalid_zcs(s);
EXPORT InValidMessage_mailing_csz(UNSIGNED1 wh) := InValidMessageFT_invalid_zcs(wh);
 
EXPORT Make_mailing_address_cd(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_mailing_address_cd(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_mailing_address_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_seller1(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_seller1(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_seller1(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_seller1_id_code(SALT311.StrType s0) := MakeFT_invalid_seller1_id_code(s0);
EXPORT InValid_seller1_id_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_seller1_id_code(s,vendor_source_flag);
EXPORT InValidMessage_seller1_id_code(UNSIGNED1 wh) := InValidMessageFT_invalid_seller1_id_code(wh);
 
EXPORT Make_seller2(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_seller2(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_seller2(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_seller2_id_code(SALT311.StrType s0) := MakeFT_invalid_seller2_id_code(s0);
EXPORT InValid_seller2_id_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_seller2_id_code(s,vendor_source_flag);
EXPORT InValidMessage_seller2_id_code(UNSIGNED1 wh) := InValidMessageFT_invalid_seller2_id_code(wh);
 
EXPORT Make_seller_addendum_flag(SALT311.StrType s0) := s0;
EXPORT InValid_seller_addendum_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_seller_addendum_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_seller_mailing_full_street_address(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_seller_mailing_full_street_address(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_seller_mailing_full_street_address(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_seller_mailing_address_unit_number(SALT311.StrType s0) := s0;
EXPORT InValid_seller_mailing_address_unit_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_seller_mailing_address_unit_number(UNSIGNED1 wh) := '';
 
EXPORT Make_seller_mailing_address_citystatezip(SALT311.StrType s0) := s0;
EXPORT InValid_seller_mailing_address_citystatezip(SALT311.StrType s) := 0;
EXPORT InValidMessage_seller_mailing_address_citystatezip(UNSIGNED1 wh) := '';
 
EXPORT Make_property_full_street_address(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_property_full_street_address(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_property_full_street_address(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_property_address_unit_number(SALT311.StrType s0) := s0;
EXPORT InValid_property_address_unit_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_property_address_unit_number(UNSIGNED1 wh) := '';
 
EXPORT Make_property_address_citystatezip(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_property_address_citystatezip(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_property_address_citystatezip(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_property_address_code(SALT311.StrType s0) := s0;
EXPORT InValid_property_address_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_property_address_code(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_lot_code(SALT311.StrType s0) := MakeFT_invalid_legal_lot_code(s0);
EXPORT InValid_legal_lot_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_legal_lot_code(s,vendor_source_flag);
EXPORT InValidMessage_legal_lot_code(UNSIGNED1 wh) := InValidMessageFT_invalid_legal_lot_code(wh);
 
EXPORT Make_legal_lot_number(SALT311.StrType s0) := s0;
EXPORT InValid_legal_lot_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_lot_number(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_legal_city_municipality_township(SALT311.StrType s0) := s0;
EXPORT InValid_legal_city_municipality_township(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_city_municipality_township(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_subdivision_name(SALT311.StrType s0) := s0;
EXPORT InValid_legal_subdivision_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_subdivision_name(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_phase_number(SALT311.StrType s0) := MakeFT_invalid_char(s0);
EXPORT InValid_legal_phase_number(SALT311.StrType s) := InValidFT_invalid_char(s);
EXPORT InValidMessage_legal_phase_number(UNSIGNED1 wh) := InValidMessageFT_invalid_char(wh);
 
EXPORT Make_legal_tract_number(SALT311.StrType s0) := s0;
EXPORT InValid_legal_tract_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_tract_number(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_sec_twn_rng_mer(SALT311.StrType s0) := s0;
EXPORT InValid_legal_sec_twn_rng_mer(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_sec_twn_rng_mer(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_brief_description(SALT311.StrType s0) := s0;
EXPORT InValid_legal_brief_description(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_brief_description(UNSIGNED1 wh) := '';
 
EXPORT Make_recorder_map_reference(SALT311.StrType s0) := s0;
EXPORT InValid_recorder_map_reference(SALT311.StrType s) := 0;
EXPORT InValidMessage_recorder_map_reference(UNSIGNED1 wh) := '';
 
EXPORT Make_complete_legal_description_code(SALT311.StrType s0) := s0;
EXPORT InValid_complete_legal_description_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_complete_legal_description_code(UNSIGNED1 wh) := '';
 
EXPORT Make_contract_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_contract_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_contract_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_recording_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_recording_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_recording_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_arm_reset_date(SALT311.StrType s0) := MakeFT_invalid_date_future(s0);
EXPORT InValid_arm_reset_date(SALT311.StrType s) := InValidFT_invalid_date_future(s);
EXPORT InValidMessage_arm_reset_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date_future(wh);
 
EXPORT Make_document_number(SALT311.StrType s0) := s0;
EXPORT InValid_document_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_document_number(UNSIGNED1 wh) := '';
 
EXPORT Make_document_type_code(SALT311.StrType s0) := MakeFT_invalid_document_type_code(s0);
EXPORT InValid_document_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_document_type_code(s,vendor_source_flag);
EXPORT InValidMessage_document_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_document_type_code(wh);
 
EXPORT Make_loan_number(SALT311.StrType s0) := s0;
EXPORT InValid_loan_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_loan_number(UNSIGNED1 wh) := '';
 
EXPORT Make_recorder_book_number(SALT311.StrType s0) := s0;
EXPORT InValid_recorder_book_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_recorder_book_number(UNSIGNED1 wh) := '';
 
EXPORT Make_recorder_page_number(SALT311.StrType s0) := s0;
EXPORT InValid_recorder_page_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_recorder_page_number(UNSIGNED1 wh) := '';
 
EXPORT Make_concurrent_mortgage_book_page_document_number(SALT311.StrType s0) := s0;
EXPORT InValid_concurrent_mortgage_book_page_document_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_concurrent_mortgage_book_page_document_number(UNSIGNED1 wh) := '';
 
EXPORT Make_sales_price(SALT311.StrType s0) := MakeFT_invalid_amount(s0);
EXPORT InValid_sales_price(SALT311.StrType s) := InValidFT_invalid_amount(s);
EXPORT InValidMessage_sales_price(UNSIGNED1 wh) := InValidMessageFT_invalid_amount(wh);
 
EXPORT Make_sales_price_code(SALT311.StrType s0) := MakeFT_invalid_sales_price_code(s0);
EXPORT InValid_sales_price_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_sales_price_code(s,vendor_source_flag);
EXPORT InValidMessage_sales_price_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sales_price_code(wh);
 
EXPORT Make_city_transfer_tax(SALT311.StrType s0) := s0;
EXPORT InValid_city_transfer_tax(SALT311.StrType s) := 0;
EXPORT InValidMessage_city_transfer_tax(UNSIGNED1 wh) := '';
 
EXPORT Make_county_transfer_tax(SALT311.StrType s0) := s0;
EXPORT InValid_county_transfer_tax(SALT311.StrType s) := 0;
EXPORT InValidMessage_county_transfer_tax(UNSIGNED1 wh) := '';
 
EXPORT Make_total_transfer_tax(SALT311.StrType s0) := s0;
EXPORT InValid_total_transfer_tax(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_transfer_tax(UNSIGNED1 wh) := '';
 
EXPORT Make_first_td_loan_amount(SALT311.StrType s0) := MakeFT_invalid_amount(s0);
EXPORT InValid_first_td_loan_amount(SALT311.StrType s) := InValidFT_invalid_amount(s);
EXPORT InValidMessage_first_td_loan_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_amount(wh);
 
EXPORT Make_second_td_loan_amount(SALT311.StrType s0) := MakeFT_invalid_amount(s0);
EXPORT InValid_second_td_loan_amount(SALT311.StrType s) := InValidFT_invalid_amount(s);
EXPORT InValidMessage_second_td_loan_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_amount(wh);
 
EXPORT Make_first_td_lender_type_code(SALT311.StrType s0) := MakeFT_invalid_lender_type_code(s0);
EXPORT InValid_first_td_lender_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_lender_type_code(s,vendor_source_flag);
EXPORT InValidMessage_first_td_lender_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_lender_type_code(wh);
 
EXPORT Make_second_td_lender_type_code(SALT311.StrType s0) := MakeFT_invalid_lender_type_code(s0);
EXPORT InValid_second_td_lender_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_lender_type_code(s,vendor_source_flag);
EXPORT InValidMessage_second_td_lender_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_lender_type_code(wh);
 
EXPORT Make_first_td_loan_type_code(SALT311.StrType s0) := MakeFT_invalid_loan_type_code(s0);
EXPORT InValid_first_td_loan_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_loan_type_code(s,vendor_source_flag);
EXPORT InValidMessage_first_td_loan_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_loan_type_code(wh);
 
EXPORT Make_type_financing(SALT311.StrType s0) := MakeFT_invalid_type_financing(s0);
EXPORT InValid_type_financing(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_type_financing(s,vendor_source_flag);
EXPORT InValidMessage_type_financing(UNSIGNED1 wh) := InValidMessageFT_invalid_type_financing(wh);
 
EXPORT Make_first_td_interest_rate(SALT311.StrType s0) := s0;
EXPORT InValid_first_td_interest_rate(SALT311.StrType s) := 0;
EXPORT InValidMessage_first_td_interest_rate(UNSIGNED1 wh) := '';
 
EXPORT Make_first_td_due_date(SALT311.StrType s0) := MakeFT_invalid_date_future(s0);
EXPORT InValid_first_td_due_date(SALT311.StrType s) := InValidFT_invalid_date_future(s);
EXPORT InValidMessage_first_td_due_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date_future(wh);
 
EXPORT Make_title_company_name(SALT311.StrType s0) := s0;
EXPORT InValid_title_company_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_title_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_partial_interest_transferred(SALT311.StrType s0) := s0;
EXPORT InValid_partial_interest_transferred(SALT311.StrType s) := 0;
EXPORT InValidMessage_partial_interest_transferred(UNSIGNED1 wh) := '';
 
EXPORT Make_loan_term_months(SALT311.StrType s0) := s0;
EXPORT InValid_loan_term_months(SALT311.StrType s) := 0;
EXPORT InValidMessage_loan_term_months(UNSIGNED1 wh) := '';
 
EXPORT Make_loan_term_years(SALT311.StrType s0) := s0;
EXPORT InValid_loan_term_years(SALT311.StrType s) := 0;
EXPORT InValidMessage_loan_term_years(UNSIGNED1 wh) := '';
 
EXPORT Make_lender_name(SALT311.StrType s0) := s0;
EXPORT InValid_lender_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_lender_name(UNSIGNED1 wh) := '';
 
EXPORT Make_lender_name_id(SALT311.StrType s0) := s0;
EXPORT InValid_lender_name_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_lender_name_id(UNSIGNED1 wh) := '';
 
EXPORT Make_lender_dba_aka_name(SALT311.StrType s0) := s0;
EXPORT InValid_lender_dba_aka_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_lender_dba_aka_name(UNSIGNED1 wh) := '';
 
EXPORT Make_lender_full_street_address(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_lender_full_street_address(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_lender_full_street_address(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_lender_address_unit_number(SALT311.StrType s0) := s0;
EXPORT InValid_lender_address_unit_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_lender_address_unit_number(UNSIGNED1 wh) := '';
 
EXPORT Make_lender_address_citystatezip(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_lender_address_citystatezip(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_lender_address_citystatezip(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_assessment_match_land_use_code(SALT311.StrType s0) := s0;
EXPORT InValid_assessment_match_land_use_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_assessment_match_land_use_code(UNSIGNED1 wh) := '';
 
EXPORT Make_property_use_code(SALT311.StrType s0) := MakeFT_invalid_property_use_code(s0);
EXPORT InValid_property_use_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_property_use_code(s,vendor_source_flag);
EXPORT InValidMessage_property_use_code(UNSIGNED1 wh) := InValidMessageFT_invalid_property_use_code(wh);
 
EXPORT Make_condo_code(SALT311.StrType s0) := MakeFT_invalid_condo_code(s0);
EXPORT InValid_condo_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_condo_code(s,vendor_source_flag);
EXPORT InValidMessage_condo_code(UNSIGNED1 wh) := InValidMessageFT_invalid_condo_code(wh);
 
EXPORT Make_timeshare_flag(SALT311.StrType s0) := s0;
EXPORT InValid_timeshare_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_timeshare_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_land_lot_size(SALT311.StrType s0) := s0;
EXPORT InValid_land_lot_size(SALT311.StrType s) := 0;
EXPORT InValidMessage_land_lot_size(UNSIGNED1 wh) := '';
 
EXPORT Make_hawaii_tct(SALT311.StrType s0) := s0;
EXPORT InValid_hawaii_tct(SALT311.StrType s) := 0;
EXPORT InValidMessage_hawaii_tct(UNSIGNED1 wh) := '';
 
EXPORT Make_hawaii_condo_cpr_code(SALT311.StrType s0) := s0;
EXPORT InValid_hawaii_condo_cpr_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_hawaii_condo_cpr_code(UNSIGNED1 wh) := '';
 
EXPORT Make_hawaii_condo_name(SALT311.StrType s0) := s0;
EXPORT InValid_hawaii_condo_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_hawaii_condo_name(UNSIGNED1 wh) := '';
 
EXPORT Make_filler_except_hawaii(SALT311.StrType s0) := s0;
EXPORT InValid_filler_except_hawaii(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler_except_hawaii(UNSIGNED1 wh) := '';
 
EXPORT Make_rate_change_frequency(SALT311.StrType s0) := MakeFT_invalid_rate_change_frequency(s0);
EXPORT InValid_rate_change_frequency(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_rate_change_frequency(s,vendor_source_flag);
EXPORT InValidMessage_rate_change_frequency(UNSIGNED1 wh) := InValidMessageFT_invalid_rate_change_frequency(wh);
 
EXPORT Make_change_index(SALT311.StrType s0) := s0;
EXPORT InValid_change_index(SALT311.StrType s) := 0;
EXPORT InValidMessage_change_index(UNSIGNED1 wh) := '';
 
EXPORT Make_adjustable_rate_index(SALT311.StrType s0) := MakeFT_invalid_adjustable_rate_index(s0);
EXPORT InValid_adjustable_rate_index(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_adjustable_rate_index(s,vendor_source_flag);
EXPORT InValidMessage_adjustable_rate_index(UNSIGNED1 wh) := InValidMessageFT_invalid_adjustable_rate_index(wh);
 
EXPORT Make_adjustable_rate_rider(SALT311.StrType s0) := s0;
EXPORT InValid_adjustable_rate_rider(SALT311.StrType s) := 0;
EXPORT InValidMessage_adjustable_rate_rider(UNSIGNED1 wh) := '';
 
EXPORT Make_graduated_payment_rider(SALT311.StrType s0) := s0;
EXPORT InValid_graduated_payment_rider(SALT311.StrType s) := 0;
EXPORT InValidMessage_graduated_payment_rider(UNSIGNED1 wh) := '';
 
EXPORT Make_balloon_rider(SALT311.StrType s0) := s0;
EXPORT InValid_balloon_rider(SALT311.StrType s) := 0;
EXPORT InValidMessage_balloon_rider(UNSIGNED1 wh) := '';
 
EXPORT Make_fixed_step_rate_rider(SALT311.StrType s0) := MakeFT_invalid_fixed_step_rate_ride(s0);
EXPORT InValid_fixed_step_rate_rider(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_fixed_step_rate_ride(s,vendor_source_flag);
EXPORT InValidMessage_fixed_step_rate_rider(UNSIGNED1 wh) := InValidMessageFT_invalid_fixed_step_rate_ride(wh);
 
EXPORT Make_condominium_rider(SALT311.StrType s0) := s0;
EXPORT InValid_condominium_rider(SALT311.StrType s) := 0;
EXPORT InValidMessage_condominium_rider(UNSIGNED1 wh) := '';
 
EXPORT Make_planned_unit_development_rider(SALT311.StrType s0) := s0;
EXPORT InValid_planned_unit_development_rider(SALT311.StrType s) := 0;
EXPORT InValidMessage_planned_unit_development_rider(UNSIGNED1 wh) := '';
 
EXPORT Make_rate_improvement_rider(SALT311.StrType s0) := s0;
EXPORT InValid_rate_improvement_rider(SALT311.StrType s) := 0;
EXPORT InValidMessage_rate_improvement_rider(UNSIGNED1 wh) := '';
 
EXPORT Make_assumability_rider(SALT311.StrType s0) := s0;
EXPORT InValid_assumability_rider(SALT311.StrType s) := 0;
EXPORT InValidMessage_assumability_rider(UNSIGNED1 wh) := '';
 
EXPORT Make_prepayment_rider(SALT311.StrType s0) := s0;
EXPORT InValid_prepayment_rider(SALT311.StrType s) := 0;
EXPORT InValidMessage_prepayment_rider(UNSIGNED1 wh) := '';
 
EXPORT Make_one_four_family_rider(SALT311.StrType s0) := s0;
EXPORT InValid_one_four_family_rider(SALT311.StrType s) := 0;
EXPORT InValidMessage_one_four_family_rider(UNSIGNED1 wh) := '';
 
EXPORT Make_biweekly_payment_rider(SALT311.StrType s0) := s0;
EXPORT InValid_biweekly_payment_rider(SALT311.StrType s) := 0;
EXPORT InValidMessage_biweekly_payment_rider(UNSIGNED1 wh) := '';
 
EXPORT Make_second_home_rider(SALT311.StrType s0) := s0;
EXPORT InValid_second_home_rider(SALT311.StrType s) := 0;
EXPORT InValidMessage_second_home_rider(UNSIGNED1 wh) := '';
 
EXPORT Make_data_source_code(SALT311.StrType s0) := s0;
EXPORT InValid_data_source_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_data_source_code(UNSIGNED1 wh) := '';
 
EXPORT Make_main_record_id_code(SALT311.StrType s0) := s0;
EXPORT InValid_main_record_id_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_main_record_id_code(UNSIGNED1 wh) := '';
 
EXPORT Make_addl_name_flag(SALT311.StrType s0) := s0;
EXPORT InValid_addl_name_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_addl_name_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_prop_addr_propagated_ind(SALT311.StrType s0) := s0;
EXPORT InValid_prop_addr_propagated_ind(SALT311.StrType s) := 0;
EXPORT InValidMessage_prop_addr_propagated_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_ownership_rights(SALT311.StrType s0) := s0;
EXPORT InValid_ln_ownership_rights(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_ownership_rights(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_relationship_type(SALT311.StrType s0) := s0;
EXPORT InValid_ln_relationship_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_relationship_type(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_buyer_mailing_country_code(SALT311.StrType s0) := s0;
EXPORT InValid_ln_buyer_mailing_country_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_buyer_mailing_country_code(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_seller_mailing_country_code(SALT311.StrType s0) := s0;
EXPORT InValid_ln_seller_mailing_country_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_seller_mailing_country_code(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_LN_PropertyV2_Deed;
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
    BOOLEAN Diff_ln_fares_id;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_vendor_source_flag;
    BOOLEAN Diff_current_record;
    BOOLEAN Diff_from_file;
    BOOLEAN Diff_fips_code;
    BOOLEAN Diff_state;
    BOOLEAN Diff_county_name;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_apnt_or_pin_number;
    BOOLEAN Diff_fares_unformatted_apn;
    BOOLEAN Diff_multi_apn_flag;
    BOOLEAN Diff_tax_id_number;
    BOOLEAN Diff_excise_tax_number;
    BOOLEAN Diff_buyer_or_borrower_ind;
    BOOLEAN Diff_name1;
    BOOLEAN Diff_name1_id_code;
    BOOLEAN Diff_name2;
    BOOLEAN Diff_name2_id_code;
    BOOLEAN Diff_vesting_code;
    BOOLEAN Diff_addendum_flag;
    BOOLEAN Diff_phone_number;
    BOOLEAN Diff_mailing_care_of;
    BOOLEAN Diff_mailing_street;
    BOOLEAN Diff_mailing_unit_number;
    BOOLEAN Diff_mailing_csz;
    BOOLEAN Diff_mailing_address_cd;
    BOOLEAN Diff_seller1;
    BOOLEAN Diff_seller1_id_code;
    BOOLEAN Diff_seller2;
    BOOLEAN Diff_seller2_id_code;
    BOOLEAN Diff_seller_addendum_flag;
    BOOLEAN Diff_seller_mailing_full_street_address;
    BOOLEAN Diff_seller_mailing_address_unit_number;
    BOOLEAN Diff_seller_mailing_address_citystatezip;
    BOOLEAN Diff_property_full_street_address;
    BOOLEAN Diff_property_address_unit_number;
    BOOLEAN Diff_property_address_citystatezip;
    BOOLEAN Diff_property_address_code;
    BOOLEAN Diff_legal_lot_code;
    BOOLEAN Diff_legal_lot_number;
    BOOLEAN Diff_legal_block;
    BOOLEAN Diff_legal_section;
    BOOLEAN Diff_legal_district;
    BOOLEAN Diff_legal_land_lot;
    BOOLEAN Diff_legal_unit;
    BOOLEAN Diff_legal_city_municipality_township;
    BOOLEAN Diff_legal_subdivision_name;
    BOOLEAN Diff_legal_phase_number;
    BOOLEAN Diff_legal_tract_number;
    BOOLEAN Diff_legal_sec_twn_rng_mer;
    BOOLEAN Diff_legal_brief_description;
    BOOLEAN Diff_recorder_map_reference;
    BOOLEAN Diff_complete_legal_description_code;
    BOOLEAN Diff_contract_date;
    BOOLEAN Diff_recording_date;
    BOOLEAN Diff_arm_reset_date;
    BOOLEAN Diff_document_number;
    BOOLEAN Diff_document_type_code;
    BOOLEAN Diff_loan_number;
    BOOLEAN Diff_recorder_book_number;
    BOOLEAN Diff_recorder_page_number;
    BOOLEAN Diff_concurrent_mortgage_book_page_document_number;
    BOOLEAN Diff_sales_price;
    BOOLEAN Diff_sales_price_code;
    BOOLEAN Diff_city_transfer_tax;
    BOOLEAN Diff_county_transfer_tax;
    BOOLEAN Diff_total_transfer_tax;
    BOOLEAN Diff_first_td_loan_amount;
    BOOLEAN Diff_second_td_loan_amount;
    BOOLEAN Diff_first_td_lender_type_code;
    BOOLEAN Diff_second_td_lender_type_code;
    BOOLEAN Diff_first_td_loan_type_code;
    BOOLEAN Diff_type_financing;
    BOOLEAN Diff_first_td_interest_rate;
    BOOLEAN Diff_first_td_due_date;
    BOOLEAN Diff_title_company_name;
    BOOLEAN Diff_partial_interest_transferred;
    BOOLEAN Diff_loan_term_months;
    BOOLEAN Diff_loan_term_years;
    BOOLEAN Diff_lender_name;
    BOOLEAN Diff_lender_name_id;
    BOOLEAN Diff_lender_dba_aka_name;
    BOOLEAN Diff_lender_full_street_address;
    BOOLEAN Diff_lender_address_unit_number;
    BOOLEAN Diff_lender_address_citystatezip;
    BOOLEAN Diff_assessment_match_land_use_code;
    BOOLEAN Diff_property_use_code;
    BOOLEAN Diff_condo_code;
    BOOLEAN Diff_timeshare_flag;
    BOOLEAN Diff_land_lot_size;
    BOOLEAN Diff_hawaii_tct;
    BOOLEAN Diff_hawaii_condo_cpr_code;
    BOOLEAN Diff_hawaii_condo_name;
    BOOLEAN Diff_filler_except_hawaii;
    BOOLEAN Diff_rate_change_frequency;
    BOOLEAN Diff_change_index;
    BOOLEAN Diff_adjustable_rate_index;
    BOOLEAN Diff_adjustable_rate_rider;
    BOOLEAN Diff_graduated_payment_rider;
    BOOLEAN Diff_balloon_rider;
    BOOLEAN Diff_fixed_step_rate_rider;
    BOOLEAN Diff_condominium_rider;
    BOOLEAN Diff_planned_unit_development_rider;
    BOOLEAN Diff_rate_improvement_rider;
    BOOLEAN Diff_assumability_rider;
    BOOLEAN Diff_prepayment_rider;
    BOOLEAN Diff_one_four_family_rider;
    BOOLEAN Diff_biweekly_payment_rider;
    BOOLEAN Diff_second_home_rider;
    BOOLEAN Diff_data_source_code;
    BOOLEAN Diff_main_record_id_code;
    BOOLEAN Diff_addl_name_flag;
    BOOLEAN Diff_prop_addr_propagated_ind;
    BOOLEAN Diff_ln_ownership_rights;
    BOOLEAN Diff_ln_relationship_type;
    BOOLEAN Diff_ln_buyer_mailing_country_code;
    BOOLEAN Diff_ln_seller_mailing_country_code;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_ln_fares_id := le.ln_fares_id <> ri.ln_fares_id;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_vendor_source_flag := le.vendor_source_flag <> ri.vendor_source_flag;
    SELF.Diff_current_record := le.current_record <> ri.current_record;
    SELF.Diff_from_file := le.from_file <> ri.from_file;
    SELF.Diff_fips_code := le.fips_code <> ri.fips_code;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_county_name := le.county_name <> ri.county_name;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_apnt_or_pin_number := le.apnt_or_pin_number <> ri.apnt_or_pin_number;
    SELF.Diff_fares_unformatted_apn := le.fares_unformatted_apn <> ri.fares_unformatted_apn;
    SELF.Diff_multi_apn_flag := le.multi_apn_flag <> ri.multi_apn_flag;
    SELF.Diff_tax_id_number := le.tax_id_number <> ri.tax_id_number;
    SELF.Diff_excise_tax_number := le.excise_tax_number <> ri.excise_tax_number;
    SELF.Diff_buyer_or_borrower_ind := le.buyer_or_borrower_ind <> ri.buyer_or_borrower_ind;
    SELF.Diff_name1 := le.name1 <> ri.name1;
    SELF.Diff_name1_id_code := le.name1_id_code <> ri.name1_id_code;
    SELF.Diff_name2 := le.name2 <> ri.name2;
    SELF.Diff_name2_id_code := le.name2_id_code <> ri.name2_id_code;
    SELF.Diff_vesting_code := le.vesting_code <> ri.vesting_code;
    SELF.Diff_addendum_flag := le.addendum_flag <> ri.addendum_flag;
    SELF.Diff_phone_number := le.phone_number <> ri.phone_number;
    SELF.Diff_mailing_care_of := le.mailing_care_of <> ri.mailing_care_of;
    SELF.Diff_mailing_street := le.mailing_street <> ri.mailing_street;
    SELF.Diff_mailing_unit_number := le.mailing_unit_number <> ri.mailing_unit_number;
    SELF.Diff_mailing_csz := le.mailing_csz <> ri.mailing_csz;
    SELF.Diff_mailing_address_cd := le.mailing_address_cd <> ri.mailing_address_cd;
    SELF.Diff_seller1 := le.seller1 <> ri.seller1;
    SELF.Diff_seller1_id_code := le.seller1_id_code <> ri.seller1_id_code;
    SELF.Diff_seller2 := le.seller2 <> ri.seller2;
    SELF.Diff_seller2_id_code := le.seller2_id_code <> ri.seller2_id_code;
    SELF.Diff_seller_addendum_flag := le.seller_addendum_flag <> ri.seller_addendum_flag;
    SELF.Diff_seller_mailing_full_street_address := le.seller_mailing_full_street_address <> ri.seller_mailing_full_street_address;
    SELF.Diff_seller_mailing_address_unit_number := le.seller_mailing_address_unit_number <> ri.seller_mailing_address_unit_number;
    SELF.Diff_seller_mailing_address_citystatezip := le.seller_mailing_address_citystatezip <> ri.seller_mailing_address_citystatezip;
    SELF.Diff_property_full_street_address := le.property_full_street_address <> ri.property_full_street_address;
    SELF.Diff_property_address_unit_number := le.property_address_unit_number <> ri.property_address_unit_number;
    SELF.Diff_property_address_citystatezip := le.property_address_citystatezip <> ri.property_address_citystatezip;
    SELF.Diff_property_address_code := le.property_address_code <> ri.property_address_code;
    SELF.Diff_legal_lot_code := le.legal_lot_code <> ri.legal_lot_code;
    SELF.Diff_legal_lot_number := le.legal_lot_number <> ri.legal_lot_number;
    SELF.Diff_legal_block := le.legal_block <> ri.legal_block;
    SELF.Diff_legal_section := le.legal_section <> ri.legal_section;
    SELF.Diff_legal_district := le.legal_district <> ri.legal_district;
    SELF.Diff_legal_land_lot := le.legal_land_lot <> ri.legal_land_lot;
    SELF.Diff_legal_unit := le.legal_unit <> ri.legal_unit;
    SELF.Diff_legal_city_municipality_township := le.legal_city_municipality_township <> ri.legal_city_municipality_township;
    SELF.Diff_legal_subdivision_name := le.legal_subdivision_name <> ri.legal_subdivision_name;
    SELF.Diff_legal_phase_number := le.legal_phase_number <> ri.legal_phase_number;
    SELF.Diff_legal_tract_number := le.legal_tract_number <> ri.legal_tract_number;
    SELF.Diff_legal_sec_twn_rng_mer := le.legal_sec_twn_rng_mer <> ri.legal_sec_twn_rng_mer;
    SELF.Diff_legal_brief_description := le.legal_brief_description <> ri.legal_brief_description;
    SELF.Diff_recorder_map_reference := le.recorder_map_reference <> ri.recorder_map_reference;
    SELF.Diff_complete_legal_description_code := le.complete_legal_description_code <> ri.complete_legal_description_code;
    SELF.Diff_contract_date := le.contract_date <> ri.contract_date;
    SELF.Diff_recording_date := le.recording_date <> ri.recording_date;
    SELF.Diff_arm_reset_date := le.arm_reset_date <> ri.arm_reset_date;
    SELF.Diff_document_number := le.document_number <> ri.document_number;
    SELF.Diff_document_type_code := le.document_type_code <> ri.document_type_code;
    SELF.Diff_loan_number := le.loan_number <> ri.loan_number;
    SELF.Diff_recorder_book_number := le.recorder_book_number <> ri.recorder_book_number;
    SELF.Diff_recorder_page_number := le.recorder_page_number <> ri.recorder_page_number;
    SELF.Diff_concurrent_mortgage_book_page_document_number := le.concurrent_mortgage_book_page_document_number <> ri.concurrent_mortgage_book_page_document_number;
    SELF.Diff_sales_price := le.sales_price <> ri.sales_price;
    SELF.Diff_sales_price_code := le.sales_price_code <> ri.sales_price_code;
    SELF.Diff_city_transfer_tax := le.city_transfer_tax <> ri.city_transfer_tax;
    SELF.Diff_county_transfer_tax := le.county_transfer_tax <> ri.county_transfer_tax;
    SELF.Diff_total_transfer_tax := le.total_transfer_tax <> ri.total_transfer_tax;
    SELF.Diff_first_td_loan_amount := le.first_td_loan_amount <> ri.first_td_loan_amount;
    SELF.Diff_second_td_loan_amount := le.second_td_loan_amount <> ri.second_td_loan_amount;
    SELF.Diff_first_td_lender_type_code := le.first_td_lender_type_code <> ri.first_td_lender_type_code;
    SELF.Diff_second_td_lender_type_code := le.second_td_lender_type_code <> ri.second_td_lender_type_code;
    SELF.Diff_first_td_loan_type_code := le.first_td_loan_type_code <> ri.first_td_loan_type_code;
    SELF.Diff_type_financing := le.type_financing <> ri.type_financing;
    SELF.Diff_first_td_interest_rate := le.first_td_interest_rate <> ri.first_td_interest_rate;
    SELF.Diff_first_td_due_date := le.first_td_due_date <> ri.first_td_due_date;
    SELF.Diff_title_company_name := le.title_company_name <> ri.title_company_name;
    SELF.Diff_partial_interest_transferred := le.partial_interest_transferred <> ri.partial_interest_transferred;
    SELF.Diff_loan_term_months := le.loan_term_months <> ri.loan_term_months;
    SELF.Diff_loan_term_years := le.loan_term_years <> ri.loan_term_years;
    SELF.Diff_lender_name := le.lender_name <> ri.lender_name;
    SELF.Diff_lender_name_id := le.lender_name_id <> ri.lender_name_id;
    SELF.Diff_lender_dba_aka_name := le.lender_dba_aka_name <> ri.lender_dba_aka_name;
    SELF.Diff_lender_full_street_address := le.lender_full_street_address <> ri.lender_full_street_address;
    SELF.Diff_lender_address_unit_number := le.lender_address_unit_number <> ri.lender_address_unit_number;
    SELF.Diff_lender_address_citystatezip := le.lender_address_citystatezip <> ri.lender_address_citystatezip;
    SELF.Diff_assessment_match_land_use_code := le.assessment_match_land_use_code <> ri.assessment_match_land_use_code;
    SELF.Diff_property_use_code := le.property_use_code <> ri.property_use_code;
    SELF.Diff_condo_code := le.condo_code <> ri.condo_code;
    SELF.Diff_timeshare_flag := le.timeshare_flag <> ri.timeshare_flag;
    SELF.Diff_land_lot_size := le.land_lot_size <> ri.land_lot_size;
    SELF.Diff_hawaii_tct := le.hawaii_tct <> ri.hawaii_tct;
    SELF.Diff_hawaii_condo_cpr_code := le.hawaii_condo_cpr_code <> ri.hawaii_condo_cpr_code;
    SELF.Diff_hawaii_condo_name := le.hawaii_condo_name <> ri.hawaii_condo_name;
    SELF.Diff_filler_except_hawaii := le.filler_except_hawaii <> ri.filler_except_hawaii;
    SELF.Diff_rate_change_frequency := le.rate_change_frequency <> ri.rate_change_frequency;
    SELF.Diff_change_index := le.change_index <> ri.change_index;
    SELF.Diff_adjustable_rate_index := le.adjustable_rate_index <> ri.adjustable_rate_index;
    SELF.Diff_adjustable_rate_rider := le.adjustable_rate_rider <> ri.adjustable_rate_rider;
    SELF.Diff_graduated_payment_rider := le.graduated_payment_rider <> ri.graduated_payment_rider;
    SELF.Diff_balloon_rider := le.balloon_rider <> ri.balloon_rider;
    SELF.Diff_fixed_step_rate_rider := le.fixed_step_rate_rider <> ri.fixed_step_rate_rider;
    SELF.Diff_condominium_rider := le.condominium_rider <> ri.condominium_rider;
    SELF.Diff_planned_unit_development_rider := le.planned_unit_development_rider <> ri.planned_unit_development_rider;
    SELF.Diff_rate_improvement_rider := le.rate_improvement_rider <> ri.rate_improvement_rider;
    SELF.Diff_assumability_rider := le.assumability_rider <> ri.assumability_rider;
    SELF.Diff_prepayment_rider := le.prepayment_rider <> ri.prepayment_rider;
    SELF.Diff_one_four_family_rider := le.one_four_family_rider <> ri.one_four_family_rider;
    SELF.Diff_biweekly_payment_rider := le.biweekly_payment_rider <> ri.biweekly_payment_rider;
    SELF.Diff_second_home_rider := le.second_home_rider <> ri.second_home_rider;
    SELF.Diff_data_source_code := le.data_source_code <> ri.data_source_code;
    SELF.Diff_main_record_id_code := le.main_record_id_code <> ri.main_record_id_code;
    SELF.Diff_addl_name_flag := le.addl_name_flag <> ri.addl_name_flag;
    SELF.Diff_prop_addr_propagated_ind := le.prop_addr_propagated_ind <> ri.prop_addr_propagated_ind;
    SELF.Diff_ln_ownership_rights := le.ln_ownership_rights <> ri.ln_ownership_rights;
    SELF.Diff_ln_relationship_type := le.ln_relationship_type <> ri.ln_relationship_type;
    SELF.Diff_ln_buyer_mailing_country_code := le.ln_buyer_mailing_country_code <> ri.ln_buyer_mailing_country_code;
    SELF.Diff_ln_seller_mailing_country_code := le.ln_seller_mailing_country_code <> ri.ln_seller_mailing_country_code;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.fips_code;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_ln_fares_id,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_vendor_source_flag,1,0)+ IF( SELF.Diff_current_record,1,0)+ IF( SELF.Diff_from_file,1,0)+ IF( SELF.Diff_fips_code,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_county_name,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_apnt_or_pin_number,1,0)+ IF( SELF.Diff_fares_unformatted_apn,1,0)+ IF( SELF.Diff_multi_apn_flag,1,0)+ IF( SELF.Diff_tax_id_number,1,0)+ IF( SELF.Diff_excise_tax_number,1,0)+ IF( SELF.Diff_buyer_or_borrower_ind,1,0)+ IF( SELF.Diff_name1,1,0)+ IF( SELF.Diff_name1_id_code,1,0)+ IF( SELF.Diff_name2,1,0)+ IF( SELF.Diff_name2_id_code,1,0)+ IF( SELF.Diff_vesting_code,1,0)+ IF( SELF.Diff_addendum_flag,1,0)+ IF( SELF.Diff_phone_number,1,0)+ IF( SELF.Diff_mailing_care_of,1,0)+ IF( SELF.Diff_mailing_street,1,0)+ IF( SELF.Diff_mailing_unit_number,1,0)+ IF( SELF.Diff_mailing_csz,1,0)+ IF( SELF.Diff_mailing_address_cd,1,0)+ IF( SELF.Diff_seller1,1,0)+ IF( SELF.Diff_seller1_id_code,1,0)+ IF( SELF.Diff_seller2,1,0)+ IF( SELF.Diff_seller2_id_code,1,0)+ IF( SELF.Diff_seller_addendum_flag,1,0)+ IF( SELF.Diff_seller_mailing_full_street_address,1,0)+ IF( SELF.Diff_seller_mailing_address_unit_number,1,0)+ IF( SELF.Diff_seller_mailing_address_citystatezip,1,0)+ IF( SELF.Diff_property_full_street_address,1,0)+ IF( SELF.Diff_property_address_unit_number,1,0)+ IF( SELF.Diff_property_address_citystatezip,1,0)+ IF( SELF.Diff_property_address_code,1,0)+ IF( SELF.Diff_legal_lot_code,1,0)+ IF( SELF.Diff_legal_lot_number,1,0)+ IF( SELF.Diff_legal_block,1,0)+ IF( SELF.Diff_legal_section,1,0)+ IF( SELF.Diff_legal_district,1,0)+ IF( SELF.Diff_legal_land_lot,1,0)+ IF( SELF.Diff_legal_unit,1,0)+ IF( SELF.Diff_legal_city_municipality_township,1,0)+ IF( SELF.Diff_legal_subdivision_name,1,0)+ IF( SELF.Diff_legal_phase_number,1,0)+ IF( SELF.Diff_legal_tract_number,1,0)+ IF( SELF.Diff_legal_sec_twn_rng_mer,1,0)+ IF( SELF.Diff_legal_brief_description,1,0)+ IF( SELF.Diff_recorder_map_reference,1,0)+ IF( SELF.Diff_complete_legal_description_code,1,0)+ IF( SELF.Diff_contract_date,1,0)+ IF( SELF.Diff_recording_date,1,0)+ IF( SELF.Diff_arm_reset_date,1,0)+ IF( SELF.Diff_document_number,1,0)+ IF( SELF.Diff_document_type_code,1,0)+ IF( SELF.Diff_loan_number,1,0)+ IF( SELF.Diff_recorder_book_number,1,0)+ IF( SELF.Diff_recorder_page_number,1,0)+ IF( SELF.Diff_concurrent_mortgage_book_page_document_number,1,0)+ IF( SELF.Diff_sales_price,1,0)+ IF( SELF.Diff_sales_price_code,1,0)+ IF( SELF.Diff_city_transfer_tax,1,0)+ IF( SELF.Diff_county_transfer_tax,1,0)+ IF( SELF.Diff_total_transfer_tax,1,0)+ IF( SELF.Diff_first_td_loan_amount,1,0)+ IF( SELF.Diff_second_td_loan_amount,1,0)+ IF( SELF.Diff_first_td_lender_type_code,1,0)+ IF( SELF.Diff_second_td_lender_type_code,1,0)+ IF( SELF.Diff_first_td_loan_type_code,1,0)+ IF( SELF.Diff_type_financing,1,0)+ IF( SELF.Diff_first_td_interest_rate,1,0)+ IF( SELF.Diff_first_td_due_date,1,0)+ IF( SELF.Diff_title_company_name,1,0)+ IF( SELF.Diff_partial_interest_transferred,1,0)+ IF( SELF.Diff_loan_term_months,1,0)+ IF( SELF.Diff_loan_term_years,1,0)+ IF( SELF.Diff_lender_name,1,0)+ IF( SELF.Diff_lender_name_id,1,0)+ IF( SELF.Diff_lender_dba_aka_name,1,0)+ IF( SELF.Diff_lender_full_street_address,1,0)+ IF( SELF.Diff_lender_address_unit_number,1,0)+ IF( SELF.Diff_lender_address_citystatezip,1,0)+ IF( SELF.Diff_assessment_match_land_use_code,1,0)+ IF( SELF.Diff_property_use_code,1,0)+ IF( SELF.Diff_condo_code,1,0)+ IF( SELF.Diff_timeshare_flag,1,0)+ IF( SELF.Diff_land_lot_size,1,0)+ IF( SELF.Diff_hawaii_tct,1,0)+ IF( SELF.Diff_hawaii_condo_cpr_code,1,0)+ IF( SELF.Diff_hawaii_condo_name,1,0)+ IF( SELF.Diff_filler_except_hawaii,1,0)+ IF( SELF.Diff_rate_change_frequency,1,0)+ IF( SELF.Diff_change_index,1,0)+ IF( SELF.Diff_adjustable_rate_index,1,0)+ IF( SELF.Diff_adjustable_rate_rider,1,0)+ IF( SELF.Diff_graduated_payment_rider,1,0)+ IF( SELF.Diff_balloon_rider,1,0)+ IF( SELF.Diff_fixed_step_rate_rider,1,0)+ IF( SELF.Diff_condominium_rider,1,0)+ IF( SELF.Diff_planned_unit_development_rider,1,0)+ IF( SELF.Diff_rate_improvement_rider,1,0)+ IF( SELF.Diff_assumability_rider,1,0)+ IF( SELF.Diff_prepayment_rider,1,0)+ IF( SELF.Diff_one_four_family_rider,1,0)+ IF( SELF.Diff_biweekly_payment_rider,1,0)+ IF( SELF.Diff_second_home_rider,1,0)+ IF( SELF.Diff_data_source_code,1,0)+ IF( SELF.Diff_main_record_id_code,1,0)+ IF( SELF.Diff_addl_name_flag,1,0)+ IF( SELF.Diff_prop_addr_propagated_ind,1,0)+ IF( SELF.Diff_ln_ownership_rights,1,0)+ IF( SELF.Diff_ln_relationship_type,1,0)+ IF( SELF.Diff_ln_buyer_mailing_country_code,1,0)+ IF( SELF.Diff_ln_seller_mailing_country_code,1,0);
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
    Count_Diff_ln_fares_id := COUNT(GROUP,%Closest%.Diff_ln_fares_id);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_vendor_source_flag := COUNT(GROUP,%Closest%.Diff_vendor_source_flag);
    Count_Diff_current_record := COUNT(GROUP,%Closest%.Diff_current_record);
    Count_Diff_from_file := COUNT(GROUP,%Closest%.Diff_from_file);
    Count_Diff_fips_code := COUNT(GROUP,%Closest%.Diff_fips_code);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_county_name := COUNT(GROUP,%Closest%.Diff_county_name);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_apnt_or_pin_number := COUNT(GROUP,%Closest%.Diff_apnt_or_pin_number);
    Count_Diff_fares_unformatted_apn := COUNT(GROUP,%Closest%.Diff_fares_unformatted_apn);
    Count_Diff_multi_apn_flag := COUNT(GROUP,%Closest%.Diff_multi_apn_flag);
    Count_Diff_tax_id_number := COUNT(GROUP,%Closest%.Diff_tax_id_number);
    Count_Diff_excise_tax_number := COUNT(GROUP,%Closest%.Diff_excise_tax_number);
    Count_Diff_buyer_or_borrower_ind := COUNT(GROUP,%Closest%.Diff_buyer_or_borrower_ind);
    Count_Diff_name1 := COUNT(GROUP,%Closest%.Diff_name1);
    Count_Diff_name1_id_code := COUNT(GROUP,%Closest%.Diff_name1_id_code);
    Count_Diff_name2 := COUNT(GROUP,%Closest%.Diff_name2);
    Count_Diff_name2_id_code := COUNT(GROUP,%Closest%.Diff_name2_id_code);
    Count_Diff_vesting_code := COUNT(GROUP,%Closest%.Diff_vesting_code);
    Count_Diff_addendum_flag := COUNT(GROUP,%Closest%.Diff_addendum_flag);
    Count_Diff_phone_number := COUNT(GROUP,%Closest%.Diff_phone_number);
    Count_Diff_mailing_care_of := COUNT(GROUP,%Closest%.Diff_mailing_care_of);
    Count_Diff_mailing_street := COUNT(GROUP,%Closest%.Diff_mailing_street);
    Count_Diff_mailing_unit_number := COUNT(GROUP,%Closest%.Diff_mailing_unit_number);
    Count_Diff_mailing_csz := COUNT(GROUP,%Closest%.Diff_mailing_csz);
    Count_Diff_mailing_address_cd := COUNT(GROUP,%Closest%.Diff_mailing_address_cd);
    Count_Diff_seller1 := COUNT(GROUP,%Closest%.Diff_seller1);
    Count_Diff_seller1_id_code := COUNT(GROUP,%Closest%.Diff_seller1_id_code);
    Count_Diff_seller2 := COUNT(GROUP,%Closest%.Diff_seller2);
    Count_Diff_seller2_id_code := COUNT(GROUP,%Closest%.Diff_seller2_id_code);
    Count_Diff_seller_addendum_flag := COUNT(GROUP,%Closest%.Diff_seller_addendum_flag);
    Count_Diff_seller_mailing_full_street_address := COUNT(GROUP,%Closest%.Diff_seller_mailing_full_street_address);
    Count_Diff_seller_mailing_address_unit_number := COUNT(GROUP,%Closest%.Diff_seller_mailing_address_unit_number);
    Count_Diff_seller_mailing_address_citystatezip := COUNT(GROUP,%Closest%.Diff_seller_mailing_address_citystatezip);
    Count_Diff_property_full_street_address := COUNT(GROUP,%Closest%.Diff_property_full_street_address);
    Count_Diff_property_address_unit_number := COUNT(GROUP,%Closest%.Diff_property_address_unit_number);
    Count_Diff_property_address_citystatezip := COUNT(GROUP,%Closest%.Diff_property_address_citystatezip);
    Count_Diff_property_address_code := COUNT(GROUP,%Closest%.Diff_property_address_code);
    Count_Diff_legal_lot_code := COUNT(GROUP,%Closest%.Diff_legal_lot_code);
    Count_Diff_legal_lot_number := COUNT(GROUP,%Closest%.Diff_legal_lot_number);
    Count_Diff_legal_block := COUNT(GROUP,%Closest%.Diff_legal_block);
    Count_Diff_legal_section := COUNT(GROUP,%Closest%.Diff_legal_section);
    Count_Diff_legal_district := COUNT(GROUP,%Closest%.Diff_legal_district);
    Count_Diff_legal_land_lot := COUNT(GROUP,%Closest%.Diff_legal_land_lot);
    Count_Diff_legal_unit := COUNT(GROUP,%Closest%.Diff_legal_unit);
    Count_Diff_legal_city_municipality_township := COUNT(GROUP,%Closest%.Diff_legal_city_municipality_township);
    Count_Diff_legal_subdivision_name := COUNT(GROUP,%Closest%.Diff_legal_subdivision_name);
    Count_Diff_legal_phase_number := COUNT(GROUP,%Closest%.Diff_legal_phase_number);
    Count_Diff_legal_tract_number := COUNT(GROUP,%Closest%.Diff_legal_tract_number);
    Count_Diff_legal_sec_twn_rng_mer := COUNT(GROUP,%Closest%.Diff_legal_sec_twn_rng_mer);
    Count_Diff_legal_brief_description := COUNT(GROUP,%Closest%.Diff_legal_brief_description);
    Count_Diff_recorder_map_reference := COUNT(GROUP,%Closest%.Diff_recorder_map_reference);
    Count_Diff_complete_legal_description_code := COUNT(GROUP,%Closest%.Diff_complete_legal_description_code);
    Count_Diff_contract_date := COUNT(GROUP,%Closest%.Diff_contract_date);
    Count_Diff_recording_date := COUNT(GROUP,%Closest%.Diff_recording_date);
    Count_Diff_arm_reset_date := COUNT(GROUP,%Closest%.Diff_arm_reset_date);
    Count_Diff_document_number := COUNT(GROUP,%Closest%.Diff_document_number);
    Count_Diff_document_type_code := COUNT(GROUP,%Closest%.Diff_document_type_code);
    Count_Diff_loan_number := COUNT(GROUP,%Closest%.Diff_loan_number);
    Count_Diff_recorder_book_number := COUNT(GROUP,%Closest%.Diff_recorder_book_number);
    Count_Diff_recorder_page_number := COUNT(GROUP,%Closest%.Diff_recorder_page_number);
    Count_Diff_concurrent_mortgage_book_page_document_number := COUNT(GROUP,%Closest%.Diff_concurrent_mortgage_book_page_document_number);
    Count_Diff_sales_price := COUNT(GROUP,%Closest%.Diff_sales_price);
    Count_Diff_sales_price_code := COUNT(GROUP,%Closest%.Diff_sales_price_code);
    Count_Diff_city_transfer_tax := COUNT(GROUP,%Closest%.Diff_city_transfer_tax);
    Count_Diff_county_transfer_tax := COUNT(GROUP,%Closest%.Diff_county_transfer_tax);
    Count_Diff_total_transfer_tax := COUNT(GROUP,%Closest%.Diff_total_transfer_tax);
    Count_Diff_first_td_loan_amount := COUNT(GROUP,%Closest%.Diff_first_td_loan_amount);
    Count_Diff_second_td_loan_amount := COUNT(GROUP,%Closest%.Diff_second_td_loan_amount);
    Count_Diff_first_td_lender_type_code := COUNT(GROUP,%Closest%.Diff_first_td_lender_type_code);
    Count_Diff_second_td_lender_type_code := COUNT(GROUP,%Closest%.Diff_second_td_lender_type_code);
    Count_Diff_first_td_loan_type_code := COUNT(GROUP,%Closest%.Diff_first_td_loan_type_code);
    Count_Diff_type_financing := COUNT(GROUP,%Closest%.Diff_type_financing);
    Count_Diff_first_td_interest_rate := COUNT(GROUP,%Closest%.Diff_first_td_interest_rate);
    Count_Diff_first_td_due_date := COUNT(GROUP,%Closest%.Diff_first_td_due_date);
    Count_Diff_title_company_name := COUNT(GROUP,%Closest%.Diff_title_company_name);
    Count_Diff_partial_interest_transferred := COUNT(GROUP,%Closest%.Diff_partial_interest_transferred);
    Count_Diff_loan_term_months := COUNT(GROUP,%Closest%.Diff_loan_term_months);
    Count_Diff_loan_term_years := COUNT(GROUP,%Closest%.Diff_loan_term_years);
    Count_Diff_lender_name := COUNT(GROUP,%Closest%.Diff_lender_name);
    Count_Diff_lender_name_id := COUNT(GROUP,%Closest%.Diff_lender_name_id);
    Count_Diff_lender_dba_aka_name := COUNT(GROUP,%Closest%.Diff_lender_dba_aka_name);
    Count_Diff_lender_full_street_address := COUNT(GROUP,%Closest%.Diff_lender_full_street_address);
    Count_Diff_lender_address_unit_number := COUNT(GROUP,%Closest%.Diff_lender_address_unit_number);
    Count_Diff_lender_address_citystatezip := COUNT(GROUP,%Closest%.Diff_lender_address_citystatezip);
    Count_Diff_assessment_match_land_use_code := COUNT(GROUP,%Closest%.Diff_assessment_match_land_use_code);
    Count_Diff_property_use_code := COUNT(GROUP,%Closest%.Diff_property_use_code);
    Count_Diff_condo_code := COUNT(GROUP,%Closest%.Diff_condo_code);
    Count_Diff_timeshare_flag := COUNT(GROUP,%Closest%.Diff_timeshare_flag);
    Count_Diff_land_lot_size := COUNT(GROUP,%Closest%.Diff_land_lot_size);
    Count_Diff_hawaii_tct := COUNT(GROUP,%Closest%.Diff_hawaii_tct);
    Count_Diff_hawaii_condo_cpr_code := COUNT(GROUP,%Closest%.Diff_hawaii_condo_cpr_code);
    Count_Diff_hawaii_condo_name := COUNT(GROUP,%Closest%.Diff_hawaii_condo_name);
    Count_Diff_filler_except_hawaii := COUNT(GROUP,%Closest%.Diff_filler_except_hawaii);
    Count_Diff_rate_change_frequency := COUNT(GROUP,%Closest%.Diff_rate_change_frequency);
    Count_Diff_change_index := COUNT(GROUP,%Closest%.Diff_change_index);
    Count_Diff_adjustable_rate_index := COUNT(GROUP,%Closest%.Diff_adjustable_rate_index);
    Count_Diff_adjustable_rate_rider := COUNT(GROUP,%Closest%.Diff_adjustable_rate_rider);
    Count_Diff_graduated_payment_rider := COUNT(GROUP,%Closest%.Diff_graduated_payment_rider);
    Count_Diff_balloon_rider := COUNT(GROUP,%Closest%.Diff_balloon_rider);
    Count_Diff_fixed_step_rate_rider := COUNT(GROUP,%Closest%.Diff_fixed_step_rate_rider);
    Count_Diff_condominium_rider := COUNT(GROUP,%Closest%.Diff_condominium_rider);
    Count_Diff_planned_unit_development_rider := COUNT(GROUP,%Closest%.Diff_planned_unit_development_rider);
    Count_Diff_rate_improvement_rider := COUNT(GROUP,%Closest%.Diff_rate_improvement_rider);
    Count_Diff_assumability_rider := COUNT(GROUP,%Closest%.Diff_assumability_rider);
    Count_Diff_prepayment_rider := COUNT(GROUP,%Closest%.Diff_prepayment_rider);
    Count_Diff_one_four_family_rider := COUNT(GROUP,%Closest%.Diff_one_four_family_rider);
    Count_Diff_biweekly_payment_rider := COUNT(GROUP,%Closest%.Diff_biweekly_payment_rider);
    Count_Diff_second_home_rider := COUNT(GROUP,%Closest%.Diff_second_home_rider);
    Count_Diff_data_source_code := COUNT(GROUP,%Closest%.Diff_data_source_code);
    Count_Diff_main_record_id_code := COUNT(GROUP,%Closest%.Diff_main_record_id_code);
    Count_Diff_addl_name_flag := COUNT(GROUP,%Closest%.Diff_addl_name_flag);
    Count_Diff_prop_addr_propagated_ind := COUNT(GROUP,%Closest%.Diff_prop_addr_propagated_ind);
    Count_Diff_ln_ownership_rights := COUNT(GROUP,%Closest%.Diff_ln_ownership_rights);
    Count_Diff_ln_relationship_type := COUNT(GROUP,%Closest%.Diff_ln_relationship_type);
    Count_Diff_ln_buyer_mailing_country_code := COUNT(GROUP,%Closest%.Diff_ln_buyer_mailing_country_code);
    Count_Diff_ln_seller_mailing_country_code := COUNT(GROUP,%Closest%.Diff_ln_seller_mailing_country_code);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;

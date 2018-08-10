IMPORT SALT311;
IMPORT Scrubs_LN_PropertyV2_Assessor,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 219;
EXPORT invalid_fipsDCT := DICTIONARY(Scrubs_LN_PropertyV2_Assessor.file_fips,{fips_code => Scrubs_LN_PropertyV2_Assessor.file_fips});
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_address','invalid_county_name','invalid_apn','invalid_csz','invalid_zip','invalid_year','invalid_date','invalid_phone','invalid_fips','invalid_prop_amount','invalid_tax_amount','invalid_state_num','invalid_state_code','invalud_document_number','invalid_land_use','invalid_ownership_rights_code','invalid_relationship_code','invalid_name_type_code','invalid_second_name_type_code','invalid_mail_care_of_name_type_code','invalid_record_type_code','invalid_legal_lot_code','invalid_ownership_type_code','invalid_new_record_type_code','invalid_sale_code','invalid_prior_sales_price_code','invalid_mortgage_loan_type_code','invalid_mortgage_lender_type_code','invalid_tax_exemption1_code','invalid_tax_exemption2_code','invalid_tax_exemption3_code','invalid_tax_exemption4_code','invalid_no_of_stories','invalid_garage_type_code','invalid_pool_code','invalid_exterior_walls_code','invalid_roof_type_code','invalid_heating_code','invalid_heating_fuel_type_code','invalid_air_conditioning_type_code','invalid_building_class_code','invalid_site_influence1_code','invalid_amenities1_code','invalid_amenities2_code','invalid_amenities3_code','invalid_amenities4_code','invalid_other_buildings1_code','invalid_fireplace_indicator','invalid_property_address_code','invalid_floor_cover_code','invalid_building_quality_code','invalid_document_type_code','invalid_basement_code','invalid_building_area_indicator','invalid_building_area1_indicator','invalid_building_area2_indicator','invalid_building_area3_indicator','invalid_building_area4_indicator','invalid_building_area5_indicator','invalid_building_area6_indicator','invalid_building_area7_indicator','invalid_construction_type','invalid_building_area');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_address' => 2,'invalid_county_name' => 3,'invalid_apn' => 4,'invalid_csz' => 5,'invalid_zip' => 6,'invalid_year' => 7,'invalid_date' => 8,'invalid_phone' => 9,'invalid_fips' => 10,'invalid_prop_amount' => 11,'invalid_tax_amount' => 12,'invalid_state_num' => 13,'invalid_state_code' => 14,'invalud_document_number' => 15,'invalid_land_use' => 16,'invalid_ownership_rights_code' => 17,'invalid_relationship_code' => 18,'invalid_name_type_code' => 19,'invalid_second_name_type_code' => 20,'invalid_mail_care_of_name_type_code' => 21,'invalid_record_type_code' => 22,'invalid_legal_lot_code' => 23,'invalid_ownership_type_code' => 24,'invalid_new_record_type_code' => 25,'invalid_sale_code' => 26,'invalid_prior_sales_price_code' => 27,'invalid_mortgage_loan_type_code' => 28,'invalid_mortgage_lender_type_code' => 29,'invalid_tax_exemption1_code' => 30,'invalid_tax_exemption2_code' => 31,'invalid_tax_exemption3_code' => 32,'invalid_tax_exemption4_code' => 33,'invalid_no_of_stories' => 34,'invalid_garage_type_code' => 35,'invalid_pool_code' => 36,'invalid_exterior_walls_code' => 37,'invalid_roof_type_code' => 38,'invalid_heating_code' => 39,'invalid_heating_fuel_type_code' => 40,'invalid_air_conditioning_type_code' => 41,'invalid_building_class_code' => 42,'invalid_site_influence1_code' => 43,'invalid_amenities1_code' => 44,'invalid_amenities2_code' => 45,'invalid_amenities3_code' => 46,'invalid_amenities4_code' => 47,'invalid_other_buildings1_code' => 48,'invalid_fireplace_indicator' => 49,'invalid_property_address_code' => 50,'invalid_floor_cover_code' => 51,'invalid_building_quality_code' => 52,'invalid_document_type_code' => 53,'invalid_basement_code' => 54,'invalid_building_area_indicator' => 55,'invalid_building_area1_indicator' => 56,'invalid_building_area2_indicator' => 57,'invalid_building_area3_indicator' => 58,'invalid_building_area4_indicator' => 59,'invalid_building_area5_indicator' => 60,'invalid_building_area6_indicator' => 61,'invalid_building_area7_indicator' => 62,'invalid_construction_type' => 63,'invalid_building_area' => 64,0);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' &(),-/.\'#:;*;ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' &(),-/.\'#:;*;ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' &(),-/.\'#:;*;ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_address(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_county_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_county_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'))),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' -',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' -',' ')) = 2 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' -',' ')) = 3 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' -',' ')) = 4 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' -',' ')) = 5));
EXPORT InValidMessageFT_invalid_county_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'),SALT311.HygieneErrors.NotWords('1,2,3,4,5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_apn(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' _-.,/:&()*0123456789:;ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_apn(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' _-.,/:&()*0123456789:;ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_apn(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' _-.,/:&()*0123456789:;ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_csz(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ,-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_csz(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ,-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_invalid_csz(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ,-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('5,9'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_year(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_year(SALT311.StrType s) := WHICH(~Scrubs_LN_PropertyV2_Assessor.fn_valid_year(s)>0);
EXPORT InValidMessageFT_invalid_year(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_LN_PropertyV2_Assessor.fn_valid_year'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.NotLength('0..8'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 10));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0..10'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_fips(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),((SALT311.StrType) s) NOT IN invalid_fipsDCT,~(LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_fips(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('5'),SALT311.HygieneErrors.NotWithinFile('Scrubs_LN_PropertyV2_Assessor.file_fips'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_prop_amount(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_prop_amount(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789.'))));
EXPORT InValidMessageFT_invalid_prop_amount(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789.'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_tax_amount(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_tax_amount(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789.'))));
EXPORT InValidMessageFT_invalid_tax_amount(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789.'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_state_num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(1 <= (INTEGER4)s AND (INTEGER4)s <= 78),~(LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state_num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotInRange('1,78'),SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ'); // Only allow valid symbols
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_invalid_state_code(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ'),SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalud_document_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-&\' -.'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -.',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalud_document_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-&\' -.'))));
EXPORT InValidMessageFT_invalud_document_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-&\' -.'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_land_use(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_land_use(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'LAND_USE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_land_use(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ownership_rights_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ownership_rights_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'OWNER_OWNERSHIP_RIGHTS_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_ownership_rights_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_relationship_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_relationship_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'OWNER_RELATIONSHIP_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_relationship_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'ASSESSEE_NAME_TYPE_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_name_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_second_name_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_second_name_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'SECOND_ASSESSEE_NAME_TYPE_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_second_name_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mail_care_of_name_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mail_care_of_name_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'MAIL_CARE_OF_NAME_TYPE_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_mail_care_of_name_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'RECORD_TYPE_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_record_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_legal_lot_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_legal_lot_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'LEGAL_LOT_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_legal_lot_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ownership_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ownership_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'OWNERSHIP_TYPE_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_ownership_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_new_record_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_new_record_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'NEW_RECORD_TYPE_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_new_record_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sale_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sale_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'SALE_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_sale_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_prior_sales_price_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_prior_sales_price_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'PRIOR_SALES_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_prior_sales_price_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mortgage_loan_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mortgage_loan_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'MORTGAGE_LOAN_TYPE_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_mortgage_loan_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mortgage_lender_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mortgage_lender_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'MORTGAGE_LENDER_TYPE_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_mortgage_lender_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_tax_exemption1_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_tax_exemption1_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'TAX_EXEMPTION1_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_tax_exemption1_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_tax_exemption2_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_tax_exemption2_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'TAX_EXEMPTION2_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_tax_exemption2_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_tax_exemption3_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_tax_exemption3_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'TAX_EXEMPTION3_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_tax_exemption3_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_tax_exemption4_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_tax_exemption4_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'TAX_EXEMPTION4_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_tax_exemption4_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_no_of_stories(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789.AB+'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_no_of_stories(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789.AB+'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 5));
EXPORT InValidMessageFT_invalid_no_of_stories(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789.AB+'),SALT311.HygieneErrors.NotLength('0..5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_garage_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_garage_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'GARAGE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_garage_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pool_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pool_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'POOL_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_pool_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_exterior_walls_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_exterior_walls_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'EXTERIOR_WALLS','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_exterior_walls_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_roof_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_roof_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'ROOF_TYPE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_roof_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_heating_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_heating_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'HEATING','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_heating_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_heating_fuel_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_heating_fuel_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'FUEL','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_heating_fuel_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_air_conditioning_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_air_conditioning_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'AIR_CONDITIONING_TYPE_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_air_conditioning_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_building_class_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_building_class_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'BUILDING_CLASS_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_building_class_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_site_influence1_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_site_influence1_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'LOCATION_INFLUENCE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_site_influence1_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_amenities1_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_amenities1_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'AMENITIES1_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_amenities1_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_amenities2_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_amenities2_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'AMENITIES2_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_amenities2_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_amenities3_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_amenities3_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'AMENITIES3_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_amenities3_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_amenities4_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_amenities4_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'AMENITIES4_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_amenities4_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_other_buildings1_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_other_buildings1_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'BLDG_IMPV_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_other_buildings1_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fireplace_indicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fireplace_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'FIREPLACE_INDICATOR','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_fireplace_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_property_address_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_property_address_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'PROPERTY_ADDRESS_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_property_address_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_floor_cover_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_floor_cover_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'FLOOR_COVER','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_floor_cover_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_building_quality_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_building_quality_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'QUALITY','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_building_quality_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_document_type_code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' -.:ABCDEFGHIJKLMNOPQRSTUVWXYZ/():,&\'- '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_document_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' -.:ABCDEFGHIJKLMNOPQRSTUVWXYZ/():,&\'- '))),~fn_valid_codesv3_property(s,vendor_source_flag,'DOCUMENT_TYPE_CODE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_document_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' -.:ABCDEFGHIJKLMNOPQRSTUVWXYZ/():,&\'- '),SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_basement_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_basement_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'BASEMENT_FINISH','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_basement_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_building_area_indicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_building_area_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'BUILDING_SQ_FEET_IND','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_building_area_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_building_area1_indicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_building_area1_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'BUILDING_AREA1_INDICATOR','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_building_area1_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_building_area2_indicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_building_area2_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'BUILDING_AREA2_INDICATOR','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_building_area2_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_building_area3_indicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_building_area3_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'BUILDING_AREA3_INDICATOR','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_building_area3_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_building_area4_indicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_building_area4_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'BUILDING_AREA4_INDICATOR','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_building_area4_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_building_area5_indicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_building_area5_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'BUILDING_AREA5_INDICATOR','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_building_area5_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_building_area6_indicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_building_area6_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'BUILDING_AREA6_INDICATOR','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_building_area6_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_building_area7_indicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_building_area7_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'BUILDING_AREA7_INDICATOR','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_building_area7_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_construction_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_construction_type(SALT311.StrType s,SALT311.StrType vendor_source_flag) := WHICH(~fn_valid_codesv3_property(s,vendor_source_flag,'CONSTRUCTION_TYPE','FARES_2580')>0);
EXPORT InValidMessageFT_invalid_construction_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_codesv3_property'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_building_area(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_building_area(SALT311.StrType s,SALT311.StrType sales_price) := WHICH(~fn_valid_ratio(s,sales_price)>0);
EXPORT InValidMessageFT_invalid_building_area(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_ratio'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'ln_fares_id','process_date','vendor_source_flag','current_record','fips_code','state_code','county_name','old_apn','apna_or_pin_number','fares_unformatted_apn','duplicate_apn_multiple_address_id','assessee_name','second_assessee_name','assessee_ownership_rights_code','assessee_relationship_code','assessee_phone_number','tax_account_number','contract_owner','assessee_name_type_code','second_assessee_name_type_code','mail_care_of_name_type_code','mailing_care_of_name','mailing_full_street_address','mailing_unit_number','mailing_city_state_zip','property_full_street_address','property_unit_number','property_city_state_zip','property_country_code','property_address_code','legal_lot_code','legal_lot_number','legal_land_lot','legal_block','legal_section','legal_district','legal_unit','legal_city_municipality_township','legal_subdivision_name','legal_phase_number','legal_tract_number','legal_sec_twn_rng_mer','legal_brief_description','legal_assessor_map_ref','census_tract','record_type_code','ownership_type_code','new_record_type_code','state_land_use_code','county_land_use_code','county_land_use_description','standardized_land_use_code','timeshare_code','zoning','owner_occupied','recorder_document_number','recorder_book_number','recorder_page_number','transfer_date','recording_date','sale_date','document_type','sales_price','sales_price_code','mortgage_loan_amount','mortgage_loan_type_code','mortgage_lender_name','mortgage_lender_type_code','prior_transfer_date','prior_recording_date','prior_sales_price','prior_sales_price_code','assessed_land_value','assessed_improvement_value','assessed_total_value','assessed_value_year','market_land_value','market_improvement_value','market_total_value','market_value_year','homestead_homeowner_exemption','tax_exemption1_code','tax_exemption2_code','tax_exemption3_code','tax_exemption4_code','tax_rate_code_area','tax_amount','tax_year','tax_delinquent_year','school_tax_district1','school_tax_district1_indicator','school_tax_district2','school_tax_district2_indicator','school_tax_district3','school_tax_district3_indicator','lot_size','lot_size_acres','lot_size_frontage_feet','lot_size_depth_feet','land_acres','land_square_footage','land_dimensions','building_area','building_area_indicator','building_area1','building_area1_indicator','building_area2','building_area2_indicator','building_area3','building_area3_indicator','building_area4','building_area4_indicator','building_area5','building_area5_indicator','building_area6','building_area6_indicator','building_area7','building_area7_indicator','year_built','effective_year_built','no_of_buildings','no_of_stories','no_of_units','no_of_rooms','no_of_bedrooms','no_of_baths','no_of_partial_baths','no_of_plumbing_fixtures','garage_type_code','parking_no_of_cars','pool_code','style_code','type_construction_code','foundation_code','building_quality_code','building_condition_code','exterior_walls_code','interior_walls_code','roof_cover_code','roof_type_code','floor_cover_code','water_code','sewer_code','heating_code','heating_fuel_type_code','air_conditioning_code','air_conditioning_type_code','elevator','fireplace_indicator','fireplace_number','basement_code','building_class_code','site_influence1_code','site_influence2_code','site_influence3_code','site_influence4_code','site_influence5_code','amenities1_code','amenities2_code','amenities3_code','amenities4_code','amenities5_code','amenities2_code1','amenities2_code2','amenities2_code3','amenities2_code4','amenities2_code5','extra_features1_area','extra_features1_indicator','extra_features2_area','extra_features2_indicator','extra_features3_area','extra_features3_indicator','extra_features4_area','extra_features4_indicator','other_buildings1_code','other_buildings2_code','other_buildings3_code','other_buildings4_code','other_buildings5_code','other_impr_building1_indicator','other_impr_building2_indicator','other_impr_building3_indicator','other_impr_building4_indicator','other_impr_building5_indicator','other_impr_building_area1','other_impr_building_area2','other_impr_building_area3','other_impr_building_area4','other_impr_building_area5','topograpy_code','neighborhood_code','condo_project_or_building_name','assessee_name_indicator','second_assessee_name_indicator','other_rooms_indicator','mail_care_of_name_indicator','comments','tape_cut_date','certification_date','edition_number','prop_addr_propagated_ind','ln_ownership_rights','ln_relationship_type','ln_mailing_country_code','ln_property_name','ln_property_name_type','ln_land_use_category','ln_lot','ln_block','ln_unit','ln_subfloor','ln_floor_cover','ln_mobile_home_indicator','ln_condo_indicator','ln_property_tax_exemption','ln_veteran_status','ln_old_apn_indicator','fips');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'ln_fares_id','process_date','vendor_source_flag','current_record','fips_code','state_code','county_name','old_apn','apna_or_pin_number','fares_unformatted_apn','duplicate_apn_multiple_address_id','assessee_name','second_assessee_name','assessee_ownership_rights_code','assessee_relationship_code','assessee_phone_number','tax_account_number','contract_owner','assessee_name_type_code','second_assessee_name_type_code','mail_care_of_name_type_code','mailing_care_of_name','mailing_full_street_address','mailing_unit_number','mailing_city_state_zip','property_full_street_address','property_unit_number','property_city_state_zip','property_country_code','property_address_code','legal_lot_code','legal_lot_number','legal_land_lot','legal_block','legal_section','legal_district','legal_unit','legal_city_municipality_township','legal_subdivision_name','legal_phase_number','legal_tract_number','legal_sec_twn_rng_mer','legal_brief_description','legal_assessor_map_ref','census_tract','record_type_code','ownership_type_code','new_record_type_code','state_land_use_code','county_land_use_code','county_land_use_description','standardized_land_use_code','timeshare_code','zoning','owner_occupied','recorder_document_number','recorder_book_number','recorder_page_number','transfer_date','recording_date','sale_date','document_type','sales_price','sales_price_code','mortgage_loan_amount','mortgage_loan_type_code','mortgage_lender_name','mortgage_lender_type_code','prior_transfer_date','prior_recording_date','prior_sales_price','prior_sales_price_code','assessed_land_value','assessed_improvement_value','assessed_total_value','assessed_value_year','market_land_value','market_improvement_value','market_total_value','market_value_year','homestead_homeowner_exemption','tax_exemption1_code','tax_exemption2_code','tax_exemption3_code','tax_exemption4_code','tax_rate_code_area','tax_amount','tax_year','tax_delinquent_year','school_tax_district1','school_tax_district1_indicator','school_tax_district2','school_tax_district2_indicator','school_tax_district3','school_tax_district3_indicator','lot_size','lot_size_acres','lot_size_frontage_feet','lot_size_depth_feet','land_acres','land_square_footage','land_dimensions','building_area','building_area_indicator','building_area1','building_area1_indicator','building_area2','building_area2_indicator','building_area3','building_area3_indicator','building_area4','building_area4_indicator','building_area5','building_area5_indicator','building_area6','building_area6_indicator','building_area7','building_area7_indicator','year_built','effective_year_built','no_of_buildings','no_of_stories','no_of_units','no_of_rooms','no_of_bedrooms','no_of_baths','no_of_partial_baths','no_of_plumbing_fixtures','garage_type_code','parking_no_of_cars','pool_code','style_code','type_construction_code','foundation_code','building_quality_code','building_condition_code','exterior_walls_code','interior_walls_code','roof_cover_code','roof_type_code','floor_cover_code','water_code','sewer_code','heating_code','heating_fuel_type_code','air_conditioning_code','air_conditioning_type_code','elevator','fireplace_indicator','fireplace_number','basement_code','building_class_code','site_influence1_code','site_influence2_code','site_influence3_code','site_influence4_code','site_influence5_code','amenities1_code','amenities2_code','amenities3_code','amenities4_code','amenities5_code','amenities2_code1','amenities2_code2','amenities2_code3','amenities2_code4','amenities2_code5','extra_features1_area','extra_features1_indicator','extra_features2_area','extra_features2_indicator','extra_features3_area','extra_features3_indicator','extra_features4_area','extra_features4_indicator','other_buildings1_code','other_buildings2_code','other_buildings3_code','other_buildings4_code','other_buildings5_code','other_impr_building1_indicator','other_impr_building2_indicator','other_impr_building3_indicator','other_impr_building4_indicator','other_impr_building5_indicator','other_impr_building_area1','other_impr_building_area2','other_impr_building_area3','other_impr_building_area4','other_impr_building_area5','topograpy_code','neighborhood_code','condo_project_or_building_name','assessee_name_indicator','second_assessee_name_indicator','other_rooms_indicator','mail_care_of_name_indicator','comments','tape_cut_date','certification_date','edition_number','prop_addr_propagated_ind','ln_ownership_rights','ln_relationship_type','ln_mailing_country_code','ln_property_name','ln_property_name_type','ln_land_use_category','ln_lot','ln_block','ln_unit','ln_subfloor','ln_floor_cover','ln_mobile_home_indicator','ln_condo_indicator','ln_property_tax_exemption','ln_veteran_status','ln_old_apn_indicator','fips');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'ln_fares_id' => 0,'process_date' => 1,'vendor_source_flag' => 2,'current_record' => 3,'fips_code' => 4,'state_code' => 5,'county_name' => 6,'old_apn' => 7,'apna_or_pin_number' => 8,'fares_unformatted_apn' => 9,'duplicate_apn_multiple_address_id' => 10,'assessee_name' => 11,'second_assessee_name' => 12,'assessee_ownership_rights_code' => 13,'assessee_relationship_code' => 14,'assessee_phone_number' => 15,'tax_account_number' => 16,'contract_owner' => 17,'assessee_name_type_code' => 18,'second_assessee_name_type_code' => 19,'mail_care_of_name_type_code' => 20,'mailing_care_of_name' => 21,'mailing_full_street_address' => 22,'mailing_unit_number' => 23,'mailing_city_state_zip' => 24,'property_full_street_address' => 25,'property_unit_number' => 26,'property_city_state_zip' => 27,'property_country_code' => 28,'property_address_code' => 29,'legal_lot_code' => 30,'legal_lot_number' => 31,'legal_land_lot' => 32,'legal_block' => 33,'legal_section' => 34,'legal_district' => 35,'legal_unit' => 36,'legal_city_municipality_township' => 37,'legal_subdivision_name' => 38,'legal_phase_number' => 39,'legal_tract_number' => 40,'legal_sec_twn_rng_mer' => 41,'legal_brief_description' => 42,'legal_assessor_map_ref' => 43,'census_tract' => 44,'record_type_code' => 45,'ownership_type_code' => 46,'new_record_type_code' => 47,'state_land_use_code' => 48,'county_land_use_code' => 49,'county_land_use_description' => 50,'standardized_land_use_code' => 51,'timeshare_code' => 52,'zoning' => 53,'owner_occupied' => 54,'recorder_document_number' => 55,'recorder_book_number' => 56,'recorder_page_number' => 57,'transfer_date' => 58,'recording_date' => 59,'sale_date' => 60,'document_type' => 61,'sales_price' => 62,'sales_price_code' => 63,'mortgage_loan_amount' => 64,'mortgage_loan_type_code' => 65,'mortgage_lender_name' => 66,'mortgage_lender_type_code' => 67,'prior_transfer_date' => 68,'prior_recording_date' => 69,'prior_sales_price' => 70,'prior_sales_price_code' => 71,'assessed_land_value' => 72,'assessed_improvement_value' => 73,'assessed_total_value' => 74,'assessed_value_year' => 75,'market_land_value' => 76,'market_improvement_value' => 77,'market_total_value' => 78,'market_value_year' => 79,'homestead_homeowner_exemption' => 80,'tax_exemption1_code' => 81,'tax_exemption2_code' => 82,'tax_exemption3_code' => 83,'tax_exemption4_code' => 84,'tax_rate_code_area' => 85,'tax_amount' => 86,'tax_year' => 87,'tax_delinquent_year' => 88,'school_tax_district1' => 89,'school_tax_district1_indicator' => 90,'school_tax_district2' => 91,'school_tax_district2_indicator' => 92,'school_tax_district3' => 93,'school_tax_district3_indicator' => 94,'lot_size' => 95,'lot_size_acres' => 96,'lot_size_frontage_feet' => 97,'lot_size_depth_feet' => 98,'land_acres' => 99,'land_square_footage' => 100,'land_dimensions' => 101,'building_area' => 102,'building_area_indicator' => 103,'building_area1' => 104,'building_area1_indicator' => 105,'building_area2' => 106,'building_area2_indicator' => 107,'building_area3' => 108,'building_area3_indicator' => 109,'building_area4' => 110,'building_area4_indicator' => 111,'building_area5' => 112,'building_area5_indicator' => 113,'building_area6' => 114,'building_area6_indicator' => 115,'building_area7' => 116,'building_area7_indicator' => 117,'year_built' => 118,'effective_year_built' => 119,'no_of_buildings' => 120,'no_of_stories' => 121,'no_of_units' => 122,'no_of_rooms' => 123,'no_of_bedrooms' => 124,'no_of_baths' => 125,'no_of_partial_baths' => 126,'no_of_plumbing_fixtures' => 127,'garage_type_code' => 128,'parking_no_of_cars' => 129,'pool_code' => 130,'style_code' => 131,'type_construction_code' => 132,'foundation_code' => 133,'building_quality_code' => 134,'building_condition_code' => 135,'exterior_walls_code' => 136,'interior_walls_code' => 137,'roof_cover_code' => 138,'roof_type_code' => 139,'floor_cover_code' => 140,'water_code' => 141,'sewer_code' => 142,'heating_code' => 143,'heating_fuel_type_code' => 144,'air_conditioning_code' => 145,'air_conditioning_type_code' => 146,'elevator' => 147,'fireplace_indicator' => 148,'fireplace_number' => 149,'basement_code' => 150,'building_class_code' => 151,'site_influence1_code' => 152,'site_influence2_code' => 153,'site_influence3_code' => 154,'site_influence4_code' => 155,'site_influence5_code' => 156,'amenities1_code' => 157,'amenities2_code' => 158,'amenities3_code' => 159,'amenities4_code' => 160,'amenities5_code' => 161,'amenities2_code1' => 162,'amenities2_code2' => 163,'amenities2_code3' => 164,'amenities2_code4' => 165,'amenities2_code5' => 166,'extra_features1_area' => 167,'extra_features1_indicator' => 168,'extra_features2_area' => 169,'extra_features2_indicator' => 170,'extra_features3_area' => 171,'extra_features3_indicator' => 172,'extra_features4_area' => 173,'extra_features4_indicator' => 174,'other_buildings1_code' => 175,'other_buildings2_code' => 176,'other_buildings3_code' => 177,'other_buildings4_code' => 178,'other_buildings5_code' => 179,'other_impr_building1_indicator' => 180,'other_impr_building2_indicator' => 181,'other_impr_building3_indicator' => 182,'other_impr_building4_indicator' => 183,'other_impr_building5_indicator' => 184,'other_impr_building_area1' => 185,'other_impr_building_area2' => 186,'other_impr_building_area3' => 187,'other_impr_building_area4' => 188,'other_impr_building_area5' => 189,'topograpy_code' => 190,'neighborhood_code' => 191,'condo_project_or_building_name' => 192,'assessee_name_indicator' => 193,'second_assessee_name_indicator' => 194,'other_rooms_indicator' => 195,'mail_care_of_name_indicator' => 196,'comments' => 197,'tape_cut_date' => 198,'certification_date' => 199,'edition_number' => 200,'prop_addr_propagated_ind' => 201,'ln_ownership_rights' => 202,'ln_relationship_type' => 203,'ln_mailing_country_code' => 204,'ln_property_name' => 205,'ln_property_name_type' => 206,'ln_land_use_category' => 207,'ln_lot' => 208,'ln_block' => 209,'ln_unit' => 210,'ln_subfloor' => 211,'ln_floor_cover' => 212,'ln_mobile_home_indicator' => 213,'ln_condo_indicator' => 214,'ln_property_tax_exemption' => 215,'ln_veteran_status' => 216,'ln_old_apn_indicator' => 217,'fips' => 218,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],['ALLOW','CUSTOM','LENGTHS'],[],[],['ALLOW','LENGTHS','WITHIN_FILE'],['LEFTTRIM','ALLOW','LENGTHS'],['ALLOW','WORDS'],[],['ALLOW','LENGTHS'],[],[],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW','LENGTHS'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],['CUSTOM'],[],[],[],[],[],[],['ALLOW','CUSTOM','LENGTHS'],['ALLOW','CUSTOM','LENGTHS'],['ALLOW','CUSTOM','LENGTHS'],['ALLOW','CUSTOM'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ALLOW','CUSTOM','LENGTHS'],['ALLOW','CUSTOM','LENGTHS'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW','LENGTHS'],[],[],[],[],[],[],['CUSTOM'],[],['CUSTOM'],[],['CUSTOM'],[],['CUSTOM'],[],['CUSTOM'],[],[],['CUSTOM'],['CUSTOM'],[],[],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],[],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['ALLOW','CUSTOM','LENGTHS'],['ALLOW','CUSTOM','LENGTHS'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['ALLOW','LENGTHS','WITHIN_FILE'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_ln_fares_id(SALT311.StrType s0) := s0;
EXPORT InValid_ln_fares_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_fares_id(UNSIGNED1 wh) := '';
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_vendor_source_flag(SALT311.StrType s0) := s0;
EXPORT InValid_vendor_source_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_vendor_source_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_current_record(SALT311.StrType s0) := s0;
EXPORT InValid_current_record(SALT311.StrType s) := 0;
EXPORT InValidMessage_current_record(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_code(SALT311.StrType s0) := MakeFT_invalid_fips(s0);
EXPORT InValid_fips_code(SALT311.StrType s) := InValidFT_invalid_fips(s);
EXPORT InValidMessage_fips_code(UNSIGNED1 wh) := InValidMessageFT_invalid_fips(wh);
 
EXPORT Make_state_code(SALT311.StrType s0) := MakeFT_invalid_state_code(s0);
EXPORT InValid_state_code(SALT311.StrType s) := InValidFT_invalid_state_code(s);
EXPORT InValidMessage_state_code(UNSIGNED1 wh) := InValidMessageFT_invalid_state_code(wh);
 
EXPORT Make_county_name(SALT311.StrType s0) := MakeFT_invalid_county_name(s0);
EXPORT InValid_county_name(SALT311.StrType s) := InValidFT_invalid_county_name(s);
EXPORT InValidMessage_county_name(UNSIGNED1 wh) := InValidMessageFT_invalid_county_name(wh);
 
EXPORT Make_old_apn(SALT311.StrType s0) := s0;
EXPORT InValid_old_apn(SALT311.StrType s) := 0;
EXPORT InValidMessage_old_apn(UNSIGNED1 wh) := '';
 
EXPORT Make_apna_or_pin_number(SALT311.StrType s0) := MakeFT_invalid_apn(s0);
EXPORT InValid_apna_or_pin_number(SALT311.StrType s) := InValidFT_invalid_apn(s);
EXPORT InValidMessage_apna_or_pin_number(UNSIGNED1 wh) := InValidMessageFT_invalid_apn(wh);
 
EXPORT Make_fares_unformatted_apn(SALT311.StrType s0) := s0;
EXPORT InValid_fares_unformatted_apn(SALT311.StrType s) := 0;
EXPORT InValidMessage_fares_unformatted_apn(UNSIGNED1 wh) := '';
 
EXPORT Make_duplicate_apn_multiple_address_id(SALT311.StrType s0) := s0;
EXPORT InValid_duplicate_apn_multiple_address_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_duplicate_apn_multiple_address_id(UNSIGNED1 wh) := '';
 
EXPORT Make_assessee_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_assessee_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_assessee_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_second_assessee_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_second_assessee_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_second_assessee_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_assessee_ownership_rights_code(SALT311.StrType s0) := MakeFT_invalid_ownership_rights_code(s0);
EXPORT InValid_assessee_ownership_rights_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_ownership_rights_code(s,vendor_source_flag);
EXPORT InValidMessage_assessee_ownership_rights_code(UNSIGNED1 wh) := InValidMessageFT_invalid_ownership_rights_code(wh);
 
EXPORT Make_assessee_relationship_code(SALT311.StrType s0) := MakeFT_invalid_relationship_code(s0);
EXPORT InValid_assessee_relationship_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_relationship_code(s,vendor_source_flag);
EXPORT InValidMessage_assessee_relationship_code(UNSIGNED1 wh) := InValidMessageFT_invalid_relationship_code(wh);
 
EXPORT Make_assessee_phone_number(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_assessee_phone_number(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_assessee_phone_number(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_tax_account_number(SALT311.StrType s0) := s0;
EXPORT InValid_tax_account_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_tax_account_number(UNSIGNED1 wh) := '';
 
EXPORT Make_contract_owner(SALT311.StrType s0) := s0;
EXPORT InValid_contract_owner(SALT311.StrType s) := 0;
EXPORT InValidMessage_contract_owner(UNSIGNED1 wh) := '';
 
EXPORT Make_assessee_name_type_code(SALT311.StrType s0) := MakeFT_invalid_name_type_code(s0);
EXPORT InValid_assessee_name_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_name_type_code(s,vendor_source_flag);
EXPORT InValidMessage_assessee_name_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_name_type_code(wh);
 
EXPORT Make_second_assessee_name_type_code(SALT311.StrType s0) := MakeFT_invalid_second_name_type_code(s0);
EXPORT InValid_second_assessee_name_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_second_name_type_code(s,vendor_source_flag);
EXPORT InValidMessage_second_assessee_name_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_second_name_type_code(wh);
 
EXPORT Make_mail_care_of_name_type_code(SALT311.StrType s0) := MakeFT_invalid_mail_care_of_name_type_code(s0);
EXPORT InValid_mail_care_of_name_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_mail_care_of_name_type_code(s,vendor_source_flag);
EXPORT InValidMessage_mail_care_of_name_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_mail_care_of_name_type_code(wh);
 
EXPORT Make_mailing_care_of_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_mailing_care_of_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_mailing_care_of_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_mailing_full_street_address(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_mailing_full_street_address(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_mailing_full_street_address(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_mailing_unit_number(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_mailing_unit_number(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_mailing_unit_number(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_mailing_city_state_zip(SALT311.StrType s0) := MakeFT_invalid_csz(s0);
EXPORT InValid_mailing_city_state_zip(SALT311.StrType s) := InValidFT_invalid_csz(s);
EXPORT InValidMessage_mailing_city_state_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_csz(wh);
 
EXPORT Make_property_full_street_address(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_property_full_street_address(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_property_full_street_address(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_property_unit_number(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_property_unit_number(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_property_unit_number(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_property_city_state_zip(SALT311.StrType s0) := MakeFT_invalid_csz(s0);
EXPORT InValid_property_city_state_zip(SALT311.StrType s) := InValidFT_invalid_csz(s);
EXPORT InValidMessage_property_city_state_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_csz(wh);
 
EXPORT Make_property_country_code(SALT311.StrType s0) := s0;
EXPORT InValid_property_country_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_property_country_code(UNSIGNED1 wh) := '';
 
EXPORT Make_property_address_code(SALT311.StrType s0) := MakeFT_invalid_property_address_code(s0);
EXPORT InValid_property_address_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_property_address_code(s,vendor_source_flag);
EXPORT InValidMessage_property_address_code(UNSIGNED1 wh) := InValidMessageFT_invalid_property_address_code(wh);
 
EXPORT Make_legal_lot_code(SALT311.StrType s0) := MakeFT_invalid_legal_lot_code(s0);
EXPORT InValid_legal_lot_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_legal_lot_code(s,vendor_source_flag);
EXPORT InValidMessage_legal_lot_code(UNSIGNED1 wh) := InValidMessageFT_invalid_legal_lot_code(wh);
 
EXPORT Make_legal_lot_number(SALT311.StrType s0) := s0;
EXPORT InValid_legal_lot_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_lot_number(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_land_lot(SALT311.StrType s0) := s0;
EXPORT InValid_legal_land_lot(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_land_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_block(SALT311.StrType s0) := s0;
EXPORT InValid_legal_block(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_block(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_section(SALT311.StrType s0) := s0;
EXPORT InValid_legal_section(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_section(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_district(SALT311.StrType s0) := s0;
EXPORT InValid_legal_district(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_district(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_unit(SALT311.StrType s0) := s0;
EXPORT InValid_legal_unit(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_unit(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_city_municipality_township(SALT311.StrType s0) := s0;
EXPORT InValid_legal_city_municipality_township(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_city_municipality_township(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_subdivision_name(SALT311.StrType s0) := s0;
EXPORT InValid_legal_subdivision_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_subdivision_name(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_phase_number(SALT311.StrType s0) := s0;
EXPORT InValid_legal_phase_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_phase_number(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_tract_number(SALT311.StrType s0) := s0;
EXPORT InValid_legal_tract_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_tract_number(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_sec_twn_rng_mer(SALT311.StrType s0) := s0;
EXPORT InValid_legal_sec_twn_rng_mer(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_sec_twn_rng_mer(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_brief_description(SALT311.StrType s0) := s0;
EXPORT InValid_legal_brief_description(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_brief_description(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_assessor_map_ref(SALT311.StrType s0) := s0;
EXPORT InValid_legal_assessor_map_ref(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_assessor_map_ref(UNSIGNED1 wh) := '';
 
EXPORT Make_census_tract(SALT311.StrType s0) := s0;
EXPORT InValid_census_tract(SALT311.StrType s) := 0;
EXPORT InValidMessage_census_tract(UNSIGNED1 wh) := '';
 
EXPORT Make_record_type_code(SALT311.StrType s0) := MakeFT_invalid_record_type_code(s0);
EXPORT InValid_record_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_record_type_code(s,vendor_source_flag);
EXPORT InValidMessage_record_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type_code(wh);
 
EXPORT Make_ownership_type_code(SALT311.StrType s0) := MakeFT_invalid_ownership_type_code(s0);
EXPORT InValid_ownership_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_ownership_type_code(s,vendor_source_flag);
EXPORT InValidMessage_ownership_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_ownership_type_code(wh);
 
EXPORT Make_new_record_type_code(SALT311.StrType s0) := MakeFT_invalid_new_record_type_code(s0);
EXPORT InValid_new_record_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_new_record_type_code(s,vendor_source_flag);
EXPORT InValidMessage_new_record_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_new_record_type_code(wh);
 
EXPORT Make_state_land_use_code(SALT311.StrType s0) := s0;
EXPORT InValid_state_land_use_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_state_land_use_code(UNSIGNED1 wh) := '';
 
EXPORT Make_county_land_use_code(SALT311.StrType s0) := s0;
EXPORT InValid_county_land_use_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_county_land_use_code(UNSIGNED1 wh) := '';
 
EXPORT Make_county_land_use_description(SALT311.StrType s0) := s0;
EXPORT InValid_county_land_use_description(SALT311.StrType s) := 0;
EXPORT InValidMessage_county_land_use_description(UNSIGNED1 wh) := '';
 
EXPORT Make_standardized_land_use_code(SALT311.StrType s0) := MakeFT_invalid_land_use(s0);
EXPORT InValid_standardized_land_use_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_land_use(s,vendor_source_flag);
EXPORT InValidMessage_standardized_land_use_code(UNSIGNED1 wh) := InValidMessageFT_invalid_land_use(wh);
 
EXPORT Make_timeshare_code(SALT311.StrType s0) := s0;
EXPORT InValid_timeshare_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_timeshare_code(UNSIGNED1 wh) := '';
 
EXPORT Make_zoning(SALT311.StrType s0) := s0;
EXPORT InValid_zoning(SALT311.StrType s) := 0;
EXPORT InValidMessage_zoning(UNSIGNED1 wh) := '';
 
EXPORT Make_owner_occupied(SALT311.StrType s0) := s0;
EXPORT InValid_owner_occupied(SALT311.StrType s) := 0;
EXPORT InValidMessage_owner_occupied(UNSIGNED1 wh) := '';
 
EXPORT Make_recorder_document_number(SALT311.StrType s0) := s0;
EXPORT InValid_recorder_document_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_recorder_document_number(UNSIGNED1 wh) := '';
 
EXPORT Make_recorder_book_number(SALT311.StrType s0) := s0;
EXPORT InValid_recorder_book_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_recorder_book_number(UNSIGNED1 wh) := '';
 
EXPORT Make_recorder_page_number(SALT311.StrType s0) := s0;
EXPORT InValid_recorder_page_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_recorder_page_number(UNSIGNED1 wh) := '';
 
EXPORT Make_transfer_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_transfer_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_transfer_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_recording_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_recording_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_recording_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_sale_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_sale_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_sale_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_document_type(SALT311.StrType s0) := MakeFT_invalid_document_type_code(s0);
EXPORT InValid_document_type(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_document_type_code(s,vendor_source_flag);
EXPORT InValidMessage_document_type(UNSIGNED1 wh) := InValidMessageFT_invalid_document_type_code(wh);
 
EXPORT Make_sales_price(SALT311.StrType s0) := MakeFT_invalid_prop_amount(s0);
EXPORT InValid_sales_price(SALT311.StrType s) := InValidFT_invalid_prop_amount(s);
EXPORT InValidMessage_sales_price(UNSIGNED1 wh) := InValidMessageFT_invalid_prop_amount(wh);
 
EXPORT Make_sales_price_code(SALT311.StrType s0) := MakeFT_invalid_sale_code(s0);
EXPORT InValid_sales_price_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_sale_code(s,vendor_source_flag);
EXPORT InValidMessage_sales_price_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sale_code(wh);
 
EXPORT Make_mortgage_loan_amount(SALT311.StrType s0) := MakeFT_invalid_prop_amount(s0);
EXPORT InValid_mortgage_loan_amount(SALT311.StrType s) := InValidFT_invalid_prop_amount(s);
EXPORT InValidMessage_mortgage_loan_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_prop_amount(wh);
 
EXPORT Make_mortgage_loan_type_code(SALT311.StrType s0) := MakeFT_invalid_mortgage_loan_type_code(s0);
EXPORT InValid_mortgage_loan_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_mortgage_loan_type_code(s,vendor_source_flag);
EXPORT InValidMessage_mortgage_loan_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_mortgage_loan_type_code(wh);
 
EXPORT Make_mortgage_lender_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_mortgage_lender_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_mortgage_lender_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_mortgage_lender_type_code(SALT311.StrType s0) := MakeFT_invalid_mortgage_lender_type_code(s0);
EXPORT InValid_mortgage_lender_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_mortgage_lender_type_code(s,vendor_source_flag);
EXPORT InValidMessage_mortgage_lender_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_mortgage_lender_type_code(wh);
 
EXPORT Make_prior_transfer_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_prior_transfer_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_prior_transfer_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_prior_recording_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_prior_recording_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_prior_recording_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_prior_sales_price(SALT311.StrType s0) := MakeFT_invalid_prop_amount(s0);
EXPORT InValid_prior_sales_price(SALT311.StrType s) := InValidFT_invalid_prop_amount(s);
EXPORT InValidMessage_prior_sales_price(UNSIGNED1 wh) := InValidMessageFT_invalid_prop_amount(wh);
 
EXPORT Make_prior_sales_price_code(SALT311.StrType s0) := MakeFT_invalid_prior_sales_price_code(s0);
EXPORT InValid_prior_sales_price_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_prior_sales_price_code(s,vendor_source_flag);
EXPORT InValidMessage_prior_sales_price_code(UNSIGNED1 wh) := InValidMessageFT_invalid_prior_sales_price_code(wh);
 
EXPORT Make_assessed_land_value(SALT311.StrType s0) := MakeFT_invalid_prop_amount(s0);
EXPORT InValid_assessed_land_value(SALT311.StrType s) := InValidFT_invalid_prop_amount(s);
EXPORT InValidMessage_assessed_land_value(UNSIGNED1 wh) := InValidMessageFT_invalid_prop_amount(wh);
 
EXPORT Make_assessed_improvement_value(SALT311.StrType s0) := MakeFT_invalid_prop_amount(s0);
EXPORT InValid_assessed_improvement_value(SALT311.StrType s) := InValidFT_invalid_prop_amount(s);
EXPORT InValidMessage_assessed_improvement_value(UNSIGNED1 wh) := InValidMessageFT_invalid_prop_amount(wh);
 
EXPORT Make_assessed_total_value(SALT311.StrType s0) := MakeFT_invalid_prop_amount(s0);
EXPORT InValid_assessed_total_value(SALT311.StrType s) := InValidFT_invalid_prop_amount(s);
EXPORT InValidMessage_assessed_total_value(UNSIGNED1 wh) := InValidMessageFT_invalid_prop_amount(wh);
 
EXPORT Make_assessed_value_year(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_assessed_value_year(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_assessed_value_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_market_land_value(SALT311.StrType s0) := MakeFT_invalid_prop_amount(s0);
EXPORT InValid_market_land_value(SALT311.StrType s) := InValidFT_invalid_prop_amount(s);
EXPORT InValidMessage_market_land_value(UNSIGNED1 wh) := InValidMessageFT_invalid_prop_amount(wh);
 
EXPORT Make_market_improvement_value(SALT311.StrType s0) := MakeFT_invalid_prop_amount(s0);
EXPORT InValid_market_improvement_value(SALT311.StrType s) := InValidFT_invalid_prop_amount(s);
EXPORT InValidMessage_market_improvement_value(UNSIGNED1 wh) := InValidMessageFT_invalid_prop_amount(wh);
 
EXPORT Make_market_total_value(SALT311.StrType s0) := MakeFT_invalid_prop_amount(s0);
EXPORT InValid_market_total_value(SALT311.StrType s) := InValidFT_invalid_prop_amount(s);
EXPORT InValidMessage_market_total_value(UNSIGNED1 wh) := InValidMessageFT_invalid_prop_amount(wh);
 
EXPORT Make_market_value_year(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_market_value_year(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_market_value_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_homestead_homeowner_exemption(SALT311.StrType s0) := s0;
EXPORT InValid_homestead_homeowner_exemption(SALT311.StrType s) := 0;
EXPORT InValidMessage_homestead_homeowner_exemption(UNSIGNED1 wh) := '';
 
EXPORT Make_tax_exemption1_code(SALT311.StrType s0) := MakeFT_invalid_tax_exemption1_code(s0);
EXPORT InValid_tax_exemption1_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_tax_exemption1_code(s,vendor_source_flag);
EXPORT InValidMessage_tax_exemption1_code(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_exemption1_code(wh);
 
EXPORT Make_tax_exemption2_code(SALT311.StrType s0) := MakeFT_invalid_tax_exemption2_code(s0);
EXPORT InValid_tax_exemption2_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_tax_exemption2_code(s,vendor_source_flag);
EXPORT InValidMessage_tax_exemption2_code(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_exemption2_code(wh);
 
EXPORT Make_tax_exemption3_code(SALT311.StrType s0) := MakeFT_invalid_tax_exemption3_code(s0);
EXPORT InValid_tax_exemption3_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_tax_exemption3_code(s,vendor_source_flag);
EXPORT InValidMessage_tax_exemption3_code(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_exemption3_code(wh);
 
EXPORT Make_tax_exemption4_code(SALT311.StrType s0) := MakeFT_invalid_tax_exemption4_code(s0);
EXPORT InValid_tax_exemption4_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_tax_exemption4_code(s,vendor_source_flag);
EXPORT InValidMessage_tax_exemption4_code(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_exemption4_code(wh);
 
EXPORT Make_tax_rate_code_area(SALT311.StrType s0) := s0;
EXPORT InValid_tax_rate_code_area(SALT311.StrType s) := 0;
EXPORT InValidMessage_tax_rate_code_area(UNSIGNED1 wh) := '';
 
EXPORT Make_tax_amount(SALT311.StrType s0) := MakeFT_invalid_tax_amount(s0);
EXPORT InValid_tax_amount(SALT311.StrType s) := InValidFT_invalid_tax_amount(s);
EXPORT InValidMessage_tax_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_amount(wh);
 
EXPORT Make_tax_year(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_tax_year(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_tax_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_tax_delinquent_year(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_tax_delinquent_year(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_tax_delinquent_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_school_tax_district1(SALT311.StrType s0) := s0;
EXPORT InValid_school_tax_district1(SALT311.StrType s) := 0;
EXPORT InValidMessage_school_tax_district1(UNSIGNED1 wh) := '';
 
EXPORT Make_school_tax_district1_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_school_tax_district1_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_school_tax_district1_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_school_tax_district2(SALT311.StrType s0) := s0;
EXPORT InValid_school_tax_district2(SALT311.StrType s) := 0;
EXPORT InValidMessage_school_tax_district2(UNSIGNED1 wh) := '';
 
EXPORT Make_school_tax_district2_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_school_tax_district2_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_school_tax_district2_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_school_tax_district3(SALT311.StrType s0) := s0;
EXPORT InValid_school_tax_district3(SALT311.StrType s) := 0;
EXPORT InValidMessage_school_tax_district3(UNSIGNED1 wh) := '';
 
EXPORT Make_school_tax_district3_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_school_tax_district3_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_school_tax_district3_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_size(SALT311.StrType s0) := s0;
EXPORT InValid_lot_size(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot_size(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_size_acres(SALT311.StrType s0) := s0;
EXPORT InValid_lot_size_acres(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot_size_acres(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_size_frontage_feet(SALT311.StrType s0) := s0;
EXPORT InValid_lot_size_frontage_feet(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot_size_frontage_feet(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_size_depth_feet(SALT311.StrType s0) := s0;
EXPORT InValid_lot_size_depth_feet(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot_size_depth_feet(UNSIGNED1 wh) := '';
 
EXPORT Make_land_acres(SALT311.StrType s0) := s0;
EXPORT InValid_land_acres(SALT311.StrType s) := 0;
EXPORT InValidMessage_land_acres(UNSIGNED1 wh) := '';
 
EXPORT Make_land_square_footage(SALT311.StrType s0) := s0;
EXPORT InValid_land_square_footage(SALT311.StrType s) := 0;
EXPORT InValidMessage_land_square_footage(UNSIGNED1 wh) := '';
 
EXPORT Make_land_dimensions(SALT311.StrType s0) := s0;
EXPORT InValid_land_dimensions(SALT311.StrType s) := 0;
EXPORT InValidMessage_land_dimensions(UNSIGNED1 wh) := '';
 
EXPORT Make_building_area(SALT311.StrType s0) := MakeFT_invalid_building_area(s0);
EXPORT InValid_building_area(SALT311.StrType s,SALT311.StrType sales_price) := InValidFT_invalid_building_area(s,sales_price);
EXPORT InValidMessage_building_area(UNSIGNED1 wh) := InValidMessageFT_invalid_building_area(wh);
 
EXPORT Make_building_area_indicator(SALT311.StrType s0) := MakeFT_invalid_building_area_indicator(s0);
EXPORT InValid_building_area_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_building_area_indicator(s,vendor_source_flag);
EXPORT InValidMessage_building_area_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_building_area_indicator(wh);
 
EXPORT Make_building_area1(SALT311.StrType s0) := MakeFT_invalid_building_area(s0);
EXPORT InValid_building_area1(SALT311.StrType s,SALT311.StrType sales_price) := InValidFT_invalid_building_area(s,sales_price);
EXPORT InValidMessage_building_area1(UNSIGNED1 wh) := InValidMessageFT_invalid_building_area(wh);
 
EXPORT Make_building_area1_indicator(SALT311.StrType s0) := MakeFT_invalid_building_area1_indicator(s0);
EXPORT InValid_building_area1_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_building_area1_indicator(s,vendor_source_flag);
EXPORT InValidMessage_building_area1_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_building_area1_indicator(wh);
 
EXPORT Make_building_area2(SALT311.StrType s0) := MakeFT_invalid_building_area(s0);
EXPORT InValid_building_area2(SALT311.StrType s,SALT311.StrType sales_price) := InValidFT_invalid_building_area(s,sales_price);
EXPORT InValidMessage_building_area2(UNSIGNED1 wh) := InValidMessageFT_invalid_building_area(wh);
 
EXPORT Make_building_area2_indicator(SALT311.StrType s0) := MakeFT_invalid_building_area2_indicator(s0);
EXPORT InValid_building_area2_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_building_area2_indicator(s,vendor_source_flag);
EXPORT InValidMessage_building_area2_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_building_area2_indicator(wh);
 
EXPORT Make_building_area3(SALT311.StrType s0) := MakeFT_invalid_building_area(s0);
EXPORT InValid_building_area3(SALT311.StrType s,SALT311.StrType sales_price) := InValidFT_invalid_building_area(s,sales_price);
EXPORT InValidMessage_building_area3(UNSIGNED1 wh) := InValidMessageFT_invalid_building_area(wh);
 
EXPORT Make_building_area3_indicator(SALT311.StrType s0) := MakeFT_invalid_building_area3_indicator(s0);
EXPORT InValid_building_area3_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_building_area3_indicator(s,vendor_source_flag);
EXPORT InValidMessage_building_area3_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_building_area3_indicator(wh);
 
EXPORT Make_building_area4(SALT311.StrType s0) := MakeFT_invalid_building_area(s0);
EXPORT InValid_building_area4(SALT311.StrType s,SALT311.StrType sales_price) := InValidFT_invalid_building_area(s,sales_price);
EXPORT InValidMessage_building_area4(UNSIGNED1 wh) := InValidMessageFT_invalid_building_area(wh);
 
EXPORT Make_building_area4_indicator(SALT311.StrType s0) := MakeFT_invalid_building_area4_indicator(s0);
EXPORT InValid_building_area4_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_building_area4_indicator(s,vendor_source_flag);
EXPORT InValidMessage_building_area4_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_building_area4_indicator(wh);
 
EXPORT Make_building_area5(SALT311.StrType s0) := MakeFT_invalid_building_area(s0);
EXPORT InValid_building_area5(SALT311.StrType s,SALT311.StrType sales_price) := InValidFT_invalid_building_area(s,sales_price);
EXPORT InValidMessage_building_area5(UNSIGNED1 wh) := InValidMessageFT_invalid_building_area(wh);
 
EXPORT Make_building_area5_indicator(SALT311.StrType s0) := MakeFT_invalid_building_area5_indicator(s0);
EXPORT InValid_building_area5_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_building_area5_indicator(s,vendor_source_flag);
EXPORT InValidMessage_building_area5_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_building_area5_indicator(wh);
 
EXPORT Make_building_area6(SALT311.StrType s0) := MakeFT_invalid_building_area(s0);
EXPORT InValid_building_area6(SALT311.StrType s,SALT311.StrType sales_price) := InValidFT_invalid_building_area(s,sales_price);
EXPORT InValidMessage_building_area6(UNSIGNED1 wh) := InValidMessageFT_invalid_building_area(wh);
 
EXPORT Make_building_area6_indicator(SALT311.StrType s0) := MakeFT_invalid_building_area6_indicator(s0);
EXPORT InValid_building_area6_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_building_area6_indicator(s,vendor_source_flag);
EXPORT InValidMessage_building_area6_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_building_area6_indicator(wh);
 
EXPORT Make_building_area7(SALT311.StrType s0) := MakeFT_invalid_building_area(s0);
EXPORT InValid_building_area7(SALT311.StrType s,SALT311.StrType sales_price) := InValidFT_invalid_building_area(s,sales_price);
EXPORT InValidMessage_building_area7(UNSIGNED1 wh) := InValidMessageFT_invalid_building_area(wh);
 
EXPORT Make_building_area7_indicator(SALT311.StrType s0) := MakeFT_invalid_building_area7_indicator(s0);
EXPORT InValid_building_area7_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_building_area7_indicator(s,vendor_source_flag);
EXPORT InValidMessage_building_area7_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_building_area7_indicator(wh);
 
EXPORT Make_year_built(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_year_built(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_year_built(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_effective_year_built(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_effective_year_built(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_effective_year_built(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_no_of_buildings(SALT311.StrType s0) := s0;
EXPORT InValid_no_of_buildings(SALT311.StrType s) := 0;
EXPORT InValidMessage_no_of_buildings(UNSIGNED1 wh) := '';
 
EXPORT Make_no_of_stories(SALT311.StrType s0) := MakeFT_invalid_no_of_stories(s0);
EXPORT InValid_no_of_stories(SALT311.StrType s) := InValidFT_invalid_no_of_stories(s);
EXPORT InValidMessage_no_of_stories(UNSIGNED1 wh) := InValidMessageFT_invalid_no_of_stories(wh);
 
EXPORT Make_no_of_units(SALT311.StrType s0) := s0;
EXPORT InValid_no_of_units(SALT311.StrType s) := 0;
EXPORT InValidMessage_no_of_units(UNSIGNED1 wh) := '';
 
EXPORT Make_no_of_rooms(SALT311.StrType s0) := s0;
EXPORT InValid_no_of_rooms(SALT311.StrType s) := 0;
EXPORT InValidMessage_no_of_rooms(UNSIGNED1 wh) := '';
 
EXPORT Make_no_of_bedrooms(SALT311.StrType s0) := s0;
EXPORT InValid_no_of_bedrooms(SALT311.StrType s) := 0;
EXPORT InValidMessage_no_of_bedrooms(UNSIGNED1 wh) := '';
 
EXPORT Make_no_of_baths(SALT311.StrType s0) := s0;
EXPORT InValid_no_of_baths(SALT311.StrType s) := 0;
EXPORT InValidMessage_no_of_baths(UNSIGNED1 wh) := '';
 
EXPORT Make_no_of_partial_baths(SALT311.StrType s0) := s0;
EXPORT InValid_no_of_partial_baths(SALT311.StrType s) := 0;
EXPORT InValidMessage_no_of_partial_baths(UNSIGNED1 wh) := '';
 
EXPORT Make_no_of_plumbing_fixtures(SALT311.StrType s0) := s0;
EXPORT InValid_no_of_plumbing_fixtures(SALT311.StrType s) := 0;
EXPORT InValidMessage_no_of_plumbing_fixtures(UNSIGNED1 wh) := '';
 
EXPORT Make_garage_type_code(SALT311.StrType s0) := MakeFT_invalid_garage_type_code(s0);
EXPORT InValid_garage_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_garage_type_code(s,vendor_source_flag);
EXPORT InValidMessage_garage_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_garage_type_code(wh);
 
EXPORT Make_parking_no_of_cars(SALT311.StrType s0) := s0;
EXPORT InValid_parking_no_of_cars(SALT311.StrType s) := 0;
EXPORT InValidMessage_parking_no_of_cars(UNSIGNED1 wh) := '';
 
EXPORT Make_pool_code(SALT311.StrType s0) := MakeFT_invalid_pool_code(s0);
EXPORT InValid_pool_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_pool_code(s,vendor_source_flag);
EXPORT InValidMessage_pool_code(UNSIGNED1 wh) := InValidMessageFT_invalid_pool_code(wh);
 
EXPORT Make_style_code(SALT311.StrType s0) := s0;
EXPORT InValid_style_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_style_code(UNSIGNED1 wh) := '';
 
EXPORT Make_type_construction_code(SALT311.StrType s0) := MakeFT_invalid_construction_type(s0);
EXPORT InValid_type_construction_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_construction_type(s,vendor_source_flag);
EXPORT InValidMessage_type_construction_code(UNSIGNED1 wh) := InValidMessageFT_invalid_construction_type(wh);
 
EXPORT Make_foundation_code(SALT311.StrType s0) := s0;
EXPORT InValid_foundation_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_foundation_code(UNSIGNED1 wh) := '';
 
EXPORT Make_building_quality_code(SALT311.StrType s0) := MakeFT_invalid_building_quality_code(s0);
EXPORT InValid_building_quality_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_building_quality_code(s,vendor_source_flag);
EXPORT InValidMessage_building_quality_code(UNSIGNED1 wh) := InValidMessageFT_invalid_building_quality_code(wh);
 
EXPORT Make_building_condition_code(SALT311.StrType s0) := s0;
EXPORT InValid_building_condition_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_building_condition_code(UNSIGNED1 wh) := '';
 
EXPORT Make_exterior_walls_code(SALT311.StrType s0) := MakeFT_invalid_exterior_walls_code(s0);
EXPORT InValid_exterior_walls_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_exterior_walls_code(s,vendor_source_flag);
EXPORT InValidMessage_exterior_walls_code(UNSIGNED1 wh) := InValidMessageFT_invalid_exterior_walls_code(wh);
 
EXPORT Make_interior_walls_code(SALT311.StrType s0) := s0;
EXPORT InValid_interior_walls_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_interior_walls_code(UNSIGNED1 wh) := '';
 
EXPORT Make_roof_cover_code(SALT311.StrType s0) := s0;
EXPORT InValid_roof_cover_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_roof_cover_code(UNSIGNED1 wh) := '';
 
EXPORT Make_roof_type_code(SALT311.StrType s0) := MakeFT_invalid_roof_type_code(s0);
EXPORT InValid_roof_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_roof_type_code(s,vendor_source_flag);
EXPORT InValidMessage_roof_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_roof_type_code(wh);
 
EXPORT Make_floor_cover_code(SALT311.StrType s0) := MakeFT_invalid_floor_cover_code(s0);
EXPORT InValid_floor_cover_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_floor_cover_code(s,vendor_source_flag);
EXPORT InValidMessage_floor_cover_code(UNSIGNED1 wh) := InValidMessageFT_invalid_floor_cover_code(wh);
 
EXPORT Make_water_code(SALT311.StrType s0) := s0;
EXPORT InValid_water_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_water_code(UNSIGNED1 wh) := '';
 
EXPORT Make_sewer_code(SALT311.StrType s0) := s0;
EXPORT InValid_sewer_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_sewer_code(UNSIGNED1 wh) := '';
 
EXPORT Make_heating_code(SALT311.StrType s0) := MakeFT_invalid_heating_code(s0);
EXPORT InValid_heating_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_heating_code(s,vendor_source_flag);
EXPORT InValidMessage_heating_code(UNSIGNED1 wh) := InValidMessageFT_invalid_heating_code(wh);
 
EXPORT Make_heating_fuel_type_code(SALT311.StrType s0) := MakeFT_invalid_heating_fuel_type_code(s0);
EXPORT InValid_heating_fuel_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_heating_fuel_type_code(s,vendor_source_flag);
EXPORT InValidMessage_heating_fuel_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_heating_fuel_type_code(wh);
 
EXPORT Make_air_conditioning_code(SALT311.StrType s0) := s0;
EXPORT InValid_air_conditioning_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_air_conditioning_code(UNSIGNED1 wh) := '';
 
EXPORT Make_air_conditioning_type_code(SALT311.StrType s0) := MakeFT_invalid_air_conditioning_type_code(s0);
EXPORT InValid_air_conditioning_type_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_air_conditioning_type_code(s,vendor_source_flag);
EXPORT InValidMessage_air_conditioning_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_air_conditioning_type_code(wh);
 
EXPORT Make_elevator(SALT311.StrType s0) := s0;
EXPORT InValid_elevator(SALT311.StrType s) := 0;
EXPORT InValidMessage_elevator(UNSIGNED1 wh) := '';
 
EXPORT Make_fireplace_indicator(SALT311.StrType s0) := MakeFT_invalid_fireplace_indicator(s0);
EXPORT InValid_fireplace_indicator(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_fireplace_indicator(s,vendor_source_flag);
EXPORT InValidMessage_fireplace_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_fireplace_indicator(wh);
 
EXPORT Make_fireplace_number(SALT311.StrType s0) := s0;
EXPORT InValid_fireplace_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_fireplace_number(UNSIGNED1 wh) := '';
 
EXPORT Make_basement_code(SALT311.StrType s0) := MakeFT_invalid_basement_code(s0);
EXPORT InValid_basement_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_basement_code(s,vendor_source_flag);
EXPORT InValidMessage_basement_code(UNSIGNED1 wh) := InValidMessageFT_invalid_basement_code(wh);
 
EXPORT Make_building_class_code(SALT311.StrType s0) := MakeFT_invalid_building_class_code(s0);
EXPORT InValid_building_class_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_building_class_code(s,vendor_source_flag);
EXPORT InValidMessage_building_class_code(UNSIGNED1 wh) := InValidMessageFT_invalid_building_class_code(wh);
 
EXPORT Make_site_influence1_code(SALT311.StrType s0) := MakeFT_invalid_site_influence1_code(s0);
EXPORT InValid_site_influence1_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_site_influence1_code(s,vendor_source_flag);
EXPORT InValidMessage_site_influence1_code(UNSIGNED1 wh) := InValidMessageFT_invalid_site_influence1_code(wh);
 
EXPORT Make_site_influence2_code(SALT311.StrType s0) := s0;
EXPORT InValid_site_influence2_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_site_influence2_code(UNSIGNED1 wh) := '';
 
EXPORT Make_site_influence3_code(SALT311.StrType s0) := s0;
EXPORT InValid_site_influence3_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_site_influence3_code(UNSIGNED1 wh) := '';
 
EXPORT Make_site_influence4_code(SALT311.StrType s0) := s0;
EXPORT InValid_site_influence4_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_site_influence4_code(UNSIGNED1 wh) := '';
 
EXPORT Make_site_influence5_code(SALT311.StrType s0) := s0;
EXPORT InValid_site_influence5_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_site_influence5_code(UNSIGNED1 wh) := '';
 
EXPORT Make_amenities1_code(SALT311.StrType s0) := MakeFT_invalid_amenities1_code(s0);
EXPORT InValid_amenities1_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_amenities1_code(s,vendor_source_flag);
EXPORT InValidMessage_amenities1_code(UNSIGNED1 wh) := InValidMessageFT_invalid_amenities1_code(wh);
 
EXPORT Make_amenities2_code(SALT311.StrType s0) := MakeFT_invalid_amenities2_code(s0);
EXPORT InValid_amenities2_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_amenities2_code(s,vendor_source_flag);
EXPORT InValidMessage_amenities2_code(UNSIGNED1 wh) := InValidMessageFT_invalid_amenities2_code(wh);
 
EXPORT Make_amenities3_code(SALT311.StrType s0) := MakeFT_invalid_amenities3_code(s0);
EXPORT InValid_amenities3_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_amenities3_code(s,vendor_source_flag);
EXPORT InValidMessage_amenities3_code(UNSIGNED1 wh) := InValidMessageFT_invalid_amenities3_code(wh);
 
EXPORT Make_amenities4_code(SALT311.StrType s0) := MakeFT_invalid_amenities4_code(s0);
EXPORT InValid_amenities4_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_amenities4_code(s,vendor_source_flag);
EXPORT InValidMessage_amenities4_code(UNSIGNED1 wh) := InValidMessageFT_invalid_amenities4_code(wh);
 
EXPORT Make_amenities5_code(SALT311.StrType s0) := s0;
EXPORT InValid_amenities5_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_amenities5_code(UNSIGNED1 wh) := '';
 
EXPORT Make_amenities2_code1(SALT311.StrType s0) := s0;
EXPORT InValid_amenities2_code1(SALT311.StrType s) := 0;
EXPORT InValidMessage_amenities2_code1(UNSIGNED1 wh) := '';
 
EXPORT Make_amenities2_code2(SALT311.StrType s0) := s0;
EXPORT InValid_amenities2_code2(SALT311.StrType s) := 0;
EXPORT InValidMessage_amenities2_code2(UNSIGNED1 wh) := '';
 
EXPORT Make_amenities2_code3(SALT311.StrType s0) := s0;
EXPORT InValid_amenities2_code3(SALT311.StrType s) := 0;
EXPORT InValidMessage_amenities2_code3(UNSIGNED1 wh) := '';
 
EXPORT Make_amenities2_code4(SALT311.StrType s0) := s0;
EXPORT InValid_amenities2_code4(SALT311.StrType s) := 0;
EXPORT InValidMessage_amenities2_code4(UNSIGNED1 wh) := '';
 
EXPORT Make_amenities2_code5(SALT311.StrType s0) := s0;
EXPORT InValid_amenities2_code5(SALT311.StrType s) := 0;
EXPORT InValidMessage_amenities2_code5(UNSIGNED1 wh) := '';
 
EXPORT Make_extra_features1_area(SALT311.StrType s0) := s0;
EXPORT InValid_extra_features1_area(SALT311.StrType s) := 0;
EXPORT InValidMessage_extra_features1_area(UNSIGNED1 wh) := '';
 
EXPORT Make_extra_features1_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_extra_features1_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_extra_features1_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_extra_features2_area(SALT311.StrType s0) := s0;
EXPORT InValid_extra_features2_area(SALT311.StrType s) := 0;
EXPORT InValidMessage_extra_features2_area(UNSIGNED1 wh) := '';
 
EXPORT Make_extra_features2_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_extra_features2_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_extra_features2_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_extra_features3_area(SALT311.StrType s0) := s0;
EXPORT InValid_extra_features3_area(SALT311.StrType s) := 0;
EXPORT InValidMessage_extra_features3_area(UNSIGNED1 wh) := '';
 
EXPORT Make_extra_features3_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_extra_features3_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_extra_features3_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_extra_features4_area(SALT311.StrType s0) := s0;
EXPORT InValid_extra_features4_area(SALT311.StrType s) := 0;
EXPORT InValidMessage_extra_features4_area(UNSIGNED1 wh) := '';
 
EXPORT Make_extra_features4_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_extra_features4_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_extra_features4_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_other_buildings1_code(SALT311.StrType s0) := MakeFT_invalid_other_buildings1_code(s0);
EXPORT InValid_other_buildings1_code(SALT311.StrType s,SALT311.StrType vendor_source_flag) := InValidFT_invalid_other_buildings1_code(s,vendor_source_flag);
EXPORT InValidMessage_other_buildings1_code(UNSIGNED1 wh) := InValidMessageFT_invalid_other_buildings1_code(wh);
 
EXPORT Make_other_buildings2_code(SALT311.StrType s0) := s0;
EXPORT InValid_other_buildings2_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_other_buildings2_code(UNSIGNED1 wh) := '';
 
EXPORT Make_other_buildings3_code(SALT311.StrType s0) := s0;
EXPORT InValid_other_buildings3_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_other_buildings3_code(UNSIGNED1 wh) := '';
 
EXPORT Make_other_buildings4_code(SALT311.StrType s0) := s0;
EXPORT InValid_other_buildings4_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_other_buildings4_code(UNSIGNED1 wh) := '';
 
EXPORT Make_other_buildings5_code(SALT311.StrType s0) := s0;
EXPORT InValid_other_buildings5_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_other_buildings5_code(UNSIGNED1 wh) := '';
 
EXPORT Make_other_impr_building1_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_other_impr_building1_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_other_impr_building1_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_other_impr_building2_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_other_impr_building2_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_other_impr_building2_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_other_impr_building3_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_other_impr_building3_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_other_impr_building3_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_other_impr_building4_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_other_impr_building4_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_other_impr_building4_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_other_impr_building5_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_other_impr_building5_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_other_impr_building5_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_other_impr_building_area1(SALT311.StrType s0) := s0;
EXPORT InValid_other_impr_building_area1(SALT311.StrType s) := 0;
EXPORT InValidMessage_other_impr_building_area1(UNSIGNED1 wh) := '';
 
EXPORT Make_other_impr_building_area2(SALT311.StrType s0) := s0;
EXPORT InValid_other_impr_building_area2(SALT311.StrType s) := 0;
EXPORT InValidMessage_other_impr_building_area2(UNSIGNED1 wh) := '';
 
EXPORT Make_other_impr_building_area3(SALT311.StrType s0) := s0;
EXPORT InValid_other_impr_building_area3(SALT311.StrType s) := 0;
EXPORT InValidMessage_other_impr_building_area3(UNSIGNED1 wh) := '';
 
EXPORT Make_other_impr_building_area4(SALT311.StrType s0) := s0;
EXPORT InValid_other_impr_building_area4(SALT311.StrType s) := 0;
EXPORT InValidMessage_other_impr_building_area4(UNSIGNED1 wh) := '';
 
EXPORT Make_other_impr_building_area5(SALT311.StrType s0) := s0;
EXPORT InValid_other_impr_building_area5(SALT311.StrType s) := 0;
EXPORT InValidMessage_other_impr_building_area5(UNSIGNED1 wh) := '';
 
EXPORT Make_topograpy_code(SALT311.StrType s0) := s0;
EXPORT InValid_topograpy_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_topograpy_code(UNSIGNED1 wh) := '';
 
EXPORT Make_neighborhood_code(SALT311.StrType s0) := s0;
EXPORT InValid_neighborhood_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_neighborhood_code(UNSIGNED1 wh) := '';
 
EXPORT Make_condo_project_or_building_name(SALT311.StrType s0) := s0;
EXPORT InValid_condo_project_or_building_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_condo_project_or_building_name(UNSIGNED1 wh) := '';
 
EXPORT Make_assessee_name_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_assessee_name_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_assessee_name_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_second_assessee_name_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_second_assessee_name_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_second_assessee_name_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_other_rooms_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_other_rooms_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_other_rooms_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_care_of_name_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_mail_care_of_name_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_care_of_name_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_comments(SALT311.StrType s0) := s0;
EXPORT InValid_comments(SALT311.StrType s) := 0;
EXPORT InValidMessage_comments(UNSIGNED1 wh) := '';
 
EXPORT Make_tape_cut_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tape_cut_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tape_cut_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_certification_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_certification_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_certification_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_edition_number(SALT311.StrType s0) := s0;
EXPORT InValid_edition_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_edition_number(UNSIGNED1 wh) := '';
 
EXPORT Make_prop_addr_propagated_ind(SALT311.StrType s0) := s0;
EXPORT InValid_prop_addr_propagated_ind(SALT311.StrType s) := 0;
EXPORT InValidMessage_prop_addr_propagated_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_ownership_rights(SALT311.StrType s0) := s0;
EXPORT InValid_ln_ownership_rights(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_ownership_rights(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_relationship_type(SALT311.StrType s0) := s0;
EXPORT InValid_ln_relationship_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_relationship_type(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_mailing_country_code(SALT311.StrType s0) := s0;
EXPORT InValid_ln_mailing_country_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_mailing_country_code(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_property_name(SALT311.StrType s0) := s0;
EXPORT InValid_ln_property_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_property_name(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_property_name_type(SALT311.StrType s0) := s0;
EXPORT InValid_ln_property_name_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_property_name_type(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_land_use_category(SALT311.StrType s0) := s0;
EXPORT InValid_ln_land_use_category(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_land_use_category(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_lot(SALT311.StrType s0) := s0;
EXPORT InValid_ln_lot(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_block(SALT311.StrType s0) := s0;
EXPORT InValid_ln_block(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_block(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_unit(SALT311.StrType s0) := s0;
EXPORT InValid_ln_unit(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_unit(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_subfloor(SALT311.StrType s0) := s0;
EXPORT InValid_ln_subfloor(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_subfloor(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_floor_cover(SALT311.StrType s0) := s0;
EXPORT InValid_ln_floor_cover(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_floor_cover(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_mobile_home_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_ln_mobile_home_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_mobile_home_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_condo_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_ln_condo_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_condo_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_property_tax_exemption(SALT311.StrType s0) := s0;
EXPORT InValid_ln_property_tax_exemption(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_property_tax_exemption(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_veteran_status(SALT311.StrType s0) := s0;
EXPORT InValid_ln_veteran_status(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_veteran_status(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_old_apn_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_ln_old_apn_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_old_apn_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_fips(SALT311.StrType s0) := MakeFT_invalid_fips(s0);
EXPORT InValid_fips(SALT311.StrType s) := InValidFT_invalid_fips(s);
EXPORT InValidMessage_fips(UNSIGNED1 wh) := InValidMessageFT_invalid_fips(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_LN_PropertyV2_Assessor;
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
    BOOLEAN Diff_fips_code;
    BOOLEAN Diff_state_code;
    BOOLEAN Diff_county_name;
    BOOLEAN Diff_old_apn;
    BOOLEAN Diff_apna_or_pin_number;
    BOOLEAN Diff_fares_unformatted_apn;
    BOOLEAN Diff_duplicate_apn_multiple_address_id;
    BOOLEAN Diff_assessee_name;
    BOOLEAN Diff_second_assessee_name;
    BOOLEAN Diff_assessee_ownership_rights_code;
    BOOLEAN Diff_assessee_relationship_code;
    BOOLEAN Diff_assessee_phone_number;
    BOOLEAN Diff_tax_account_number;
    BOOLEAN Diff_contract_owner;
    BOOLEAN Diff_assessee_name_type_code;
    BOOLEAN Diff_second_assessee_name_type_code;
    BOOLEAN Diff_mail_care_of_name_type_code;
    BOOLEAN Diff_mailing_care_of_name;
    BOOLEAN Diff_mailing_full_street_address;
    BOOLEAN Diff_mailing_unit_number;
    BOOLEAN Diff_mailing_city_state_zip;
    BOOLEAN Diff_property_full_street_address;
    BOOLEAN Diff_property_unit_number;
    BOOLEAN Diff_property_city_state_zip;
    BOOLEAN Diff_property_country_code;
    BOOLEAN Diff_property_address_code;
    BOOLEAN Diff_legal_lot_code;
    BOOLEAN Diff_legal_lot_number;
    BOOLEAN Diff_legal_land_lot;
    BOOLEAN Diff_legal_block;
    BOOLEAN Diff_legal_section;
    BOOLEAN Diff_legal_district;
    BOOLEAN Diff_legal_unit;
    BOOLEAN Diff_legal_city_municipality_township;
    BOOLEAN Diff_legal_subdivision_name;
    BOOLEAN Diff_legal_phase_number;
    BOOLEAN Diff_legal_tract_number;
    BOOLEAN Diff_legal_sec_twn_rng_mer;
    BOOLEAN Diff_legal_brief_description;
    BOOLEAN Diff_legal_assessor_map_ref;
    BOOLEAN Diff_census_tract;
    BOOLEAN Diff_record_type_code;
    BOOLEAN Diff_ownership_type_code;
    BOOLEAN Diff_new_record_type_code;
    BOOLEAN Diff_state_land_use_code;
    BOOLEAN Diff_county_land_use_code;
    BOOLEAN Diff_county_land_use_description;
    BOOLEAN Diff_standardized_land_use_code;
    BOOLEAN Diff_timeshare_code;
    BOOLEAN Diff_zoning;
    BOOLEAN Diff_owner_occupied;
    BOOLEAN Diff_recorder_document_number;
    BOOLEAN Diff_recorder_book_number;
    BOOLEAN Diff_recorder_page_number;
    BOOLEAN Diff_transfer_date;
    BOOLEAN Diff_recording_date;
    BOOLEAN Diff_sale_date;
    BOOLEAN Diff_document_type;
    BOOLEAN Diff_sales_price;
    BOOLEAN Diff_sales_price_code;
    BOOLEAN Diff_mortgage_loan_amount;
    BOOLEAN Diff_mortgage_loan_type_code;
    BOOLEAN Diff_mortgage_lender_name;
    BOOLEAN Diff_mortgage_lender_type_code;
    BOOLEAN Diff_prior_transfer_date;
    BOOLEAN Diff_prior_recording_date;
    BOOLEAN Diff_prior_sales_price;
    BOOLEAN Diff_prior_sales_price_code;
    BOOLEAN Diff_assessed_land_value;
    BOOLEAN Diff_assessed_improvement_value;
    BOOLEAN Diff_assessed_total_value;
    BOOLEAN Diff_assessed_value_year;
    BOOLEAN Diff_market_land_value;
    BOOLEAN Diff_market_improvement_value;
    BOOLEAN Diff_market_total_value;
    BOOLEAN Diff_market_value_year;
    BOOLEAN Diff_homestead_homeowner_exemption;
    BOOLEAN Diff_tax_exemption1_code;
    BOOLEAN Diff_tax_exemption2_code;
    BOOLEAN Diff_tax_exemption3_code;
    BOOLEAN Diff_tax_exemption4_code;
    BOOLEAN Diff_tax_rate_code_area;
    BOOLEAN Diff_tax_amount;
    BOOLEAN Diff_tax_year;
    BOOLEAN Diff_tax_delinquent_year;
    BOOLEAN Diff_school_tax_district1;
    BOOLEAN Diff_school_tax_district1_indicator;
    BOOLEAN Diff_school_tax_district2;
    BOOLEAN Diff_school_tax_district2_indicator;
    BOOLEAN Diff_school_tax_district3;
    BOOLEAN Diff_school_tax_district3_indicator;
    BOOLEAN Diff_lot_size;
    BOOLEAN Diff_lot_size_acres;
    BOOLEAN Diff_lot_size_frontage_feet;
    BOOLEAN Diff_lot_size_depth_feet;
    BOOLEAN Diff_land_acres;
    BOOLEAN Diff_land_square_footage;
    BOOLEAN Diff_land_dimensions;
    BOOLEAN Diff_building_area;
    BOOLEAN Diff_building_area_indicator;
    BOOLEAN Diff_building_area1;
    BOOLEAN Diff_building_area1_indicator;
    BOOLEAN Diff_building_area2;
    BOOLEAN Diff_building_area2_indicator;
    BOOLEAN Diff_building_area3;
    BOOLEAN Diff_building_area3_indicator;
    BOOLEAN Diff_building_area4;
    BOOLEAN Diff_building_area4_indicator;
    BOOLEAN Diff_building_area5;
    BOOLEAN Diff_building_area5_indicator;
    BOOLEAN Diff_building_area6;
    BOOLEAN Diff_building_area6_indicator;
    BOOLEAN Diff_building_area7;
    BOOLEAN Diff_building_area7_indicator;
    BOOLEAN Diff_year_built;
    BOOLEAN Diff_effective_year_built;
    BOOLEAN Diff_no_of_buildings;
    BOOLEAN Diff_no_of_stories;
    BOOLEAN Diff_no_of_units;
    BOOLEAN Diff_no_of_rooms;
    BOOLEAN Diff_no_of_bedrooms;
    BOOLEAN Diff_no_of_baths;
    BOOLEAN Diff_no_of_partial_baths;
    BOOLEAN Diff_no_of_plumbing_fixtures;
    BOOLEAN Diff_garage_type_code;
    BOOLEAN Diff_parking_no_of_cars;
    BOOLEAN Diff_pool_code;
    BOOLEAN Diff_style_code;
    BOOLEAN Diff_type_construction_code;
    BOOLEAN Diff_foundation_code;
    BOOLEAN Diff_building_quality_code;
    BOOLEAN Diff_building_condition_code;
    BOOLEAN Diff_exterior_walls_code;
    BOOLEAN Diff_interior_walls_code;
    BOOLEAN Diff_roof_cover_code;
    BOOLEAN Diff_roof_type_code;
    BOOLEAN Diff_floor_cover_code;
    BOOLEAN Diff_water_code;
    BOOLEAN Diff_sewer_code;
    BOOLEAN Diff_heating_code;
    BOOLEAN Diff_heating_fuel_type_code;
    BOOLEAN Diff_air_conditioning_code;
    BOOLEAN Diff_air_conditioning_type_code;
    BOOLEAN Diff_elevator;
    BOOLEAN Diff_fireplace_indicator;
    BOOLEAN Diff_fireplace_number;
    BOOLEAN Diff_basement_code;
    BOOLEAN Diff_building_class_code;
    BOOLEAN Diff_site_influence1_code;
    BOOLEAN Diff_site_influence2_code;
    BOOLEAN Diff_site_influence3_code;
    BOOLEAN Diff_site_influence4_code;
    BOOLEAN Diff_site_influence5_code;
    BOOLEAN Diff_amenities1_code;
    BOOLEAN Diff_amenities2_code;
    BOOLEAN Diff_amenities3_code;
    BOOLEAN Diff_amenities4_code;
    BOOLEAN Diff_amenities5_code;
    BOOLEAN Diff_amenities2_code1;
    BOOLEAN Diff_amenities2_code2;
    BOOLEAN Diff_amenities2_code3;
    BOOLEAN Diff_amenities2_code4;
    BOOLEAN Diff_amenities2_code5;
    BOOLEAN Diff_extra_features1_area;
    BOOLEAN Diff_extra_features1_indicator;
    BOOLEAN Diff_extra_features2_area;
    BOOLEAN Diff_extra_features2_indicator;
    BOOLEAN Diff_extra_features3_area;
    BOOLEAN Diff_extra_features3_indicator;
    BOOLEAN Diff_extra_features4_area;
    BOOLEAN Diff_extra_features4_indicator;
    BOOLEAN Diff_other_buildings1_code;
    BOOLEAN Diff_other_buildings2_code;
    BOOLEAN Diff_other_buildings3_code;
    BOOLEAN Diff_other_buildings4_code;
    BOOLEAN Diff_other_buildings5_code;
    BOOLEAN Diff_other_impr_building1_indicator;
    BOOLEAN Diff_other_impr_building2_indicator;
    BOOLEAN Diff_other_impr_building3_indicator;
    BOOLEAN Diff_other_impr_building4_indicator;
    BOOLEAN Diff_other_impr_building5_indicator;
    BOOLEAN Diff_other_impr_building_area1;
    BOOLEAN Diff_other_impr_building_area2;
    BOOLEAN Diff_other_impr_building_area3;
    BOOLEAN Diff_other_impr_building_area4;
    BOOLEAN Diff_other_impr_building_area5;
    BOOLEAN Diff_topograpy_code;
    BOOLEAN Diff_neighborhood_code;
    BOOLEAN Diff_condo_project_or_building_name;
    BOOLEAN Diff_assessee_name_indicator;
    BOOLEAN Diff_second_assessee_name_indicator;
    BOOLEAN Diff_other_rooms_indicator;
    BOOLEAN Diff_mail_care_of_name_indicator;
    BOOLEAN Diff_comments;
    BOOLEAN Diff_tape_cut_date;
    BOOLEAN Diff_certification_date;
    BOOLEAN Diff_edition_number;
    BOOLEAN Diff_prop_addr_propagated_ind;
    BOOLEAN Diff_ln_ownership_rights;
    BOOLEAN Diff_ln_relationship_type;
    BOOLEAN Diff_ln_mailing_country_code;
    BOOLEAN Diff_ln_property_name;
    BOOLEAN Diff_ln_property_name_type;
    BOOLEAN Diff_ln_land_use_category;
    BOOLEAN Diff_ln_lot;
    BOOLEAN Diff_ln_block;
    BOOLEAN Diff_ln_unit;
    BOOLEAN Diff_ln_subfloor;
    BOOLEAN Diff_ln_floor_cover;
    BOOLEAN Diff_ln_mobile_home_indicator;
    BOOLEAN Diff_ln_condo_indicator;
    BOOLEAN Diff_ln_property_tax_exemption;
    BOOLEAN Diff_ln_veteran_status;
    BOOLEAN Diff_ln_old_apn_indicator;
    BOOLEAN Diff_fips;
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
    SELF.Diff_fips_code := le.fips_code <> ri.fips_code;
    SELF.Diff_state_code := le.state_code <> ri.state_code;
    SELF.Diff_county_name := le.county_name <> ri.county_name;
    SELF.Diff_old_apn := le.old_apn <> ri.old_apn;
    SELF.Diff_apna_or_pin_number := le.apna_or_pin_number <> ri.apna_or_pin_number;
    SELF.Diff_fares_unformatted_apn := le.fares_unformatted_apn <> ri.fares_unformatted_apn;
    SELF.Diff_duplicate_apn_multiple_address_id := le.duplicate_apn_multiple_address_id <> ri.duplicate_apn_multiple_address_id;
    SELF.Diff_assessee_name := le.assessee_name <> ri.assessee_name;
    SELF.Diff_second_assessee_name := le.second_assessee_name <> ri.second_assessee_name;
    SELF.Diff_assessee_ownership_rights_code := le.assessee_ownership_rights_code <> ri.assessee_ownership_rights_code;
    SELF.Diff_assessee_relationship_code := le.assessee_relationship_code <> ri.assessee_relationship_code;
    SELF.Diff_assessee_phone_number := le.assessee_phone_number <> ri.assessee_phone_number;
    SELF.Diff_tax_account_number := le.tax_account_number <> ri.tax_account_number;
    SELF.Diff_contract_owner := le.contract_owner <> ri.contract_owner;
    SELF.Diff_assessee_name_type_code := le.assessee_name_type_code <> ri.assessee_name_type_code;
    SELF.Diff_second_assessee_name_type_code := le.second_assessee_name_type_code <> ri.second_assessee_name_type_code;
    SELF.Diff_mail_care_of_name_type_code := le.mail_care_of_name_type_code <> ri.mail_care_of_name_type_code;
    SELF.Diff_mailing_care_of_name := le.mailing_care_of_name <> ri.mailing_care_of_name;
    SELF.Diff_mailing_full_street_address := le.mailing_full_street_address <> ri.mailing_full_street_address;
    SELF.Diff_mailing_unit_number := le.mailing_unit_number <> ri.mailing_unit_number;
    SELF.Diff_mailing_city_state_zip := le.mailing_city_state_zip <> ri.mailing_city_state_zip;
    SELF.Diff_property_full_street_address := le.property_full_street_address <> ri.property_full_street_address;
    SELF.Diff_property_unit_number := le.property_unit_number <> ri.property_unit_number;
    SELF.Diff_property_city_state_zip := le.property_city_state_zip <> ri.property_city_state_zip;
    SELF.Diff_property_country_code := le.property_country_code <> ri.property_country_code;
    SELF.Diff_property_address_code := le.property_address_code <> ri.property_address_code;
    SELF.Diff_legal_lot_code := le.legal_lot_code <> ri.legal_lot_code;
    SELF.Diff_legal_lot_number := le.legal_lot_number <> ri.legal_lot_number;
    SELF.Diff_legal_land_lot := le.legal_land_lot <> ri.legal_land_lot;
    SELF.Diff_legal_block := le.legal_block <> ri.legal_block;
    SELF.Diff_legal_section := le.legal_section <> ri.legal_section;
    SELF.Diff_legal_district := le.legal_district <> ri.legal_district;
    SELF.Diff_legal_unit := le.legal_unit <> ri.legal_unit;
    SELF.Diff_legal_city_municipality_township := le.legal_city_municipality_township <> ri.legal_city_municipality_township;
    SELF.Diff_legal_subdivision_name := le.legal_subdivision_name <> ri.legal_subdivision_name;
    SELF.Diff_legal_phase_number := le.legal_phase_number <> ri.legal_phase_number;
    SELF.Diff_legal_tract_number := le.legal_tract_number <> ri.legal_tract_number;
    SELF.Diff_legal_sec_twn_rng_mer := le.legal_sec_twn_rng_mer <> ri.legal_sec_twn_rng_mer;
    SELF.Diff_legal_brief_description := le.legal_brief_description <> ri.legal_brief_description;
    SELF.Diff_legal_assessor_map_ref := le.legal_assessor_map_ref <> ri.legal_assessor_map_ref;
    SELF.Diff_census_tract := le.census_tract <> ri.census_tract;
    SELF.Diff_record_type_code := le.record_type_code <> ri.record_type_code;
    SELF.Diff_ownership_type_code := le.ownership_type_code <> ri.ownership_type_code;
    SELF.Diff_new_record_type_code := le.new_record_type_code <> ri.new_record_type_code;
    SELF.Diff_state_land_use_code := le.state_land_use_code <> ri.state_land_use_code;
    SELF.Diff_county_land_use_code := le.county_land_use_code <> ri.county_land_use_code;
    SELF.Diff_county_land_use_description := le.county_land_use_description <> ri.county_land_use_description;
    SELF.Diff_standardized_land_use_code := le.standardized_land_use_code <> ri.standardized_land_use_code;
    SELF.Diff_timeshare_code := le.timeshare_code <> ri.timeshare_code;
    SELF.Diff_zoning := le.zoning <> ri.zoning;
    SELF.Diff_owner_occupied := le.owner_occupied <> ri.owner_occupied;
    SELF.Diff_recorder_document_number := le.recorder_document_number <> ri.recorder_document_number;
    SELF.Diff_recorder_book_number := le.recorder_book_number <> ri.recorder_book_number;
    SELF.Diff_recorder_page_number := le.recorder_page_number <> ri.recorder_page_number;
    SELF.Diff_transfer_date := le.transfer_date <> ri.transfer_date;
    SELF.Diff_recording_date := le.recording_date <> ri.recording_date;
    SELF.Diff_sale_date := le.sale_date <> ri.sale_date;
    SELF.Diff_document_type := le.document_type <> ri.document_type;
    SELF.Diff_sales_price := le.sales_price <> ri.sales_price;
    SELF.Diff_sales_price_code := le.sales_price_code <> ri.sales_price_code;
    SELF.Diff_mortgage_loan_amount := le.mortgage_loan_amount <> ri.mortgage_loan_amount;
    SELF.Diff_mortgage_loan_type_code := le.mortgage_loan_type_code <> ri.mortgage_loan_type_code;
    SELF.Diff_mortgage_lender_name := le.mortgage_lender_name <> ri.mortgage_lender_name;
    SELF.Diff_mortgage_lender_type_code := le.mortgage_lender_type_code <> ri.mortgage_lender_type_code;
    SELF.Diff_prior_transfer_date := le.prior_transfer_date <> ri.prior_transfer_date;
    SELF.Diff_prior_recording_date := le.prior_recording_date <> ri.prior_recording_date;
    SELF.Diff_prior_sales_price := le.prior_sales_price <> ri.prior_sales_price;
    SELF.Diff_prior_sales_price_code := le.prior_sales_price_code <> ri.prior_sales_price_code;
    SELF.Diff_assessed_land_value := le.assessed_land_value <> ri.assessed_land_value;
    SELF.Diff_assessed_improvement_value := le.assessed_improvement_value <> ri.assessed_improvement_value;
    SELF.Diff_assessed_total_value := le.assessed_total_value <> ri.assessed_total_value;
    SELF.Diff_assessed_value_year := le.assessed_value_year <> ri.assessed_value_year;
    SELF.Diff_market_land_value := le.market_land_value <> ri.market_land_value;
    SELF.Diff_market_improvement_value := le.market_improvement_value <> ri.market_improvement_value;
    SELF.Diff_market_total_value := le.market_total_value <> ri.market_total_value;
    SELF.Diff_market_value_year := le.market_value_year <> ri.market_value_year;
    SELF.Diff_homestead_homeowner_exemption := le.homestead_homeowner_exemption <> ri.homestead_homeowner_exemption;
    SELF.Diff_tax_exemption1_code := le.tax_exemption1_code <> ri.tax_exemption1_code;
    SELF.Diff_tax_exemption2_code := le.tax_exemption2_code <> ri.tax_exemption2_code;
    SELF.Diff_tax_exemption3_code := le.tax_exemption3_code <> ri.tax_exemption3_code;
    SELF.Diff_tax_exemption4_code := le.tax_exemption4_code <> ri.tax_exemption4_code;
    SELF.Diff_tax_rate_code_area := le.tax_rate_code_area <> ri.tax_rate_code_area;
    SELF.Diff_tax_amount := le.tax_amount <> ri.tax_amount;
    SELF.Diff_tax_year := le.tax_year <> ri.tax_year;
    SELF.Diff_tax_delinquent_year := le.tax_delinquent_year <> ri.tax_delinquent_year;
    SELF.Diff_school_tax_district1 := le.school_tax_district1 <> ri.school_tax_district1;
    SELF.Diff_school_tax_district1_indicator := le.school_tax_district1_indicator <> ri.school_tax_district1_indicator;
    SELF.Diff_school_tax_district2 := le.school_tax_district2 <> ri.school_tax_district2;
    SELF.Diff_school_tax_district2_indicator := le.school_tax_district2_indicator <> ri.school_tax_district2_indicator;
    SELF.Diff_school_tax_district3 := le.school_tax_district3 <> ri.school_tax_district3;
    SELF.Diff_school_tax_district3_indicator := le.school_tax_district3_indicator <> ri.school_tax_district3_indicator;
    SELF.Diff_lot_size := le.lot_size <> ri.lot_size;
    SELF.Diff_lot_size_acres := le.lot_size_acres <> ri.lot_size_acres;
    SELF.Diff_lot_size_frontage_feet := le.lot_size_frontage_feet <> ri.lot_size_frontage_feet;
    SELF.Diff_lot_size_depth_feet := le.lot_size_depth_feet <> ri.lot_size_depth_feet;
    SELF.Diff_land_acres := le.land_acres <> ri.land_acres;
    SELF.Diff_land_square_footage := le.land_square_footage <> ri.land_square_footage;
    SELF.Diff_land_dimensions := le.land_dimensions <> ri.land_dimensions;
    SELF.Diff_building_area := le.building_area <> ri.building_area;
    SELF.Diff_building_area_indicator := le.building_area_indicator <> ri.building_area_indicator;
    SELF.Diff_building_area1 := le.building_area1 <> ri.building_area1;
    SELF.Diff_building_area1_indicator := le.building_area1_indicator <> ri.building_area1_indicator;
    SELF.Diff_building_area2 := le.building_area2 <> ri.building_area2;
    SELF.Diff_building_area2_indicator := le.building_area2_indicator <> ri.building_area2_indicator;
    SELF.Diff_building_area3 := le.building_area3 <> ri.building_area3;
    SELF.Diff_building_area3_indicator := le.building_area3_indicator <> ri.building_area3_indicator;
    SELF.Diff_building_area4 := le.building_area4 <> ri.building_area4;
    SELF.Diff_building_area4_indicator := le.building_area4_indicator <> ri.building_area4_indicator;
    SELF.Diff_building_area5 := le.building_area5 <> ri.building_area5;
    SELF.Diff_building_area5_indicator := le.building_area5_indicator <> ri.building_area5_indicator;
    SELF.Diff_building_area6 := le.building_area6 <> ri.building_area6;
    SELF.Diff_building_area6_indicator := le.building_area6_indicator <> ri.building_area6_indicator;
    SELF.Diff_building_area7 := le.building_area7 <> ri.building_area7;
    SELF.Diff_building_area7_indicator := le.building_area7_indicator <> ri.building_area7_indicator;
    SELF.Diff_year_built := le.year_built <> ri.year_built;
    SELF.Diff_effective_year_built := le.effective_year_built <> ri.effective_year_built;
    SELF.Diff_no_of_buildings := le.no_of_buildings <> ri.no_of_buildings;
    SELF.Diff_no_of_stories := le.no_of_stories <> ri.no_of_stories;
    SELF.Diff_no_of_units := le.no_of_units <> ri.no_of_units;
    SELF.Diff_no_of_rooms := le.no_of_rooms <> ri.no_of_rooms;
    SELF.Diff_no_of_bedrooms := le.no_of_bedrooms <> ri.no_of_bedrooms;
    SELF.Diff_no_of_baths := le.no_of_baths <> ri.no_of_baths;
    SELF.Diff_no_of_partial_baths := le.no_of_partial_baths <> ri.no_of_partial_baths;
    SELF.Diff_no_of_plumbing_fixtures := le.no_of_plumbing_fixtures <> ri.no_of_plumbing_fixtures;
    SELF.Diff_garage_type_code := le.garage_type_code <> ri.garage_type_code;
    SELF.Diff_parking_no_of_cars := le.parking_no_of_cars <> ri.parking_no_of_cars;
    SELF.Diff_pool_code := le.pool_code <> ri.pool_code;
    SELF.Diff_style_code := le.style_code <> ri.style_code;
    SELF.Diff_type_construction_code := le.type_construction_code <> ri.type_construction_code;
    SELF.Diff_foundation_code := le.foundation_code <> ri.foundation_code;
    SELF.Diff_building_quality_code := le.building_quality_code <> ri.building_quality_code;
    SELF.Diff_building_condition_code := le.building_condition_code <> ri.building_condition_code;
    SELF.Diff_exterior_walls_code := le.exterior_walls_code <> ri.exterior_walls_code;
    SELF.Diff_interior_walls_code := le.interior_walls_code <> ri.interior_walls_code;
    SELF.Diff_roof_cover_code := le.roof_cover_code <> ri.roof_cover_code;
    SELF.Diff_roof_type_code := le.roof_type_code <> ri.roof_type_code;
    SELF.Diff_floor_cover_code := le.floor_cover_code <> ri.floor_cover_code;
    SELF.Diff_water_code := le.water_code <> ri.water_code;
    SELF.Diff_sewer_code := le.sewer_code <> ri.sewer_code;
    SELF.Diff_heating_code := le.heating_code <> ri.heating_code;
    SELF.Diff_heating_fuel_type_code := le.heating_fuel_type_code <> ri.heating_fuel_type_code;
    SELF.Diff_air_conditioning_code := le.air_conditioning_code <> ri.air_conditioning_code;
    SELF.Diff_air_conditioning_type_code := le.air_conditioning_type_code <> ri.air_conditioning_type_code;
    SELF.Diff_elevator := le.elevator <> ri.elevator;
    SELF.Diff_fireplace_indicator := le.fireplace_indicator <> ri.fireplace_indicator;
    SELF.Diff_fireplace_number := le.fireplace_number <> ri.fireplace_number;
    SELF.Diff_basement_code := le.basement_code <> ri.basement_code;
    SELF.Diff_building_class_code := le.building_class_code <> ri.building_class_code;
    SELF.Diff_site_influence1_code := le.site_influence1_code <> ri.site_influence1_code;
    SELF.Diff_site_influence2_code := le.site_influence2_code <> ri.site_influence2_code;
    SELF.Diff_site_influence3_code := le.site_influence3_code <> ri.site_influence3_code;
    SELF.Diff_site_influence4_code := le.site_influence4_code <> ri.site_influence4_code;
    SELF.Diff_site_influence5_code := le.site_influence5_code <> ri.site_influence5_code;
    SELF.Diff_amenities1_code := le.amenities1_code <> ri.amenities1_code;
    SELF.Diff_amenities2_code := le.amenities2_code <> ri.amenities2_code;
    SELF.Diff_amenities3_code := le.amenities3_code <> ri.amenities3_code;
    SELF.Diff_amenities4_code := le.amenities4_code <> ri.amenities4_code;
    SELF.Diff_amenities5_code := le.amenities5_code <> ri.amenities5_code;
    SELF.Diff_amenities2_code1 := le.amenities2_code1 <> ri.amenities2_code1;
    SELF.Diff_amenities2_code2 := le.amenities2_code2 <> ri.amenities2_code2;
    SELF.Diff_amenities2_code3 := le.amenities2_code3 <> ri.amenities2_code3;
    SELF.Diff_amenities2_code4 := le.amenities2_code4 <> ri.amenities2_code4;
    SELF.Diff_amenities2_code5 := le.amenities2_code5 <> ri.amenities2_code5;
    SELF.Diff_extra_features1_area := le.extra_features1_area <> ri.extra_features1_area;
    SELF.Diff_extra_features1_indicator := le.extra_features1_indicator <> ri.extra_features1_indicator;
    SELF.Diff_extra_features2_area := le.extra_features2_area <> ri.extra_features2_area;
    SELF.Diff_extra_features2_indicator := le.extra_features2_indicator <> ri.extra_features2_indicator;
    SELF.Diff_extra_features3_area := le.extra_features3_area <> ri.extra_features3_area;
    SELF.Diff_extra_features3_indicator := le.extra_features3_indicator <> ri.extra_features3_indicator;
    SELF.Diff_extra_features4_area := le.extra_features4_area <> ri.extra_features4_area;
    SELF.Diff_extra_features4_indicator := le.extra_features4_indicator <> ri.extra_features4_indicator;
    SELF.Diff_other_buildings1_code := le.other_buildings1_code <> ri.other_buildings1_code;
    SELF.Diff_other_buildings2_code := le.other_buildings2_code <> ri.other_buildings2_code;
    SELF.Diff_other_buildings3_code := le.other_buildings3_code <> ri.other_buildings3_code;
    SELF.Diff_other_buildings4_code := le.other_buildings4_code <> ri.other_buildings4_code;
    SELF.Diff_other_buildings5_code := le.other_buildings5_code <> ri.other_buildings5_code;
    SELF.Diff_other_impr_building1_indicator := le.other_impr_building1_indicator <> ri.other_impr_building1_indicator;
    SELF.Diff_other_impr_building2_indicator := le.other_impr_building2_indicator <> ri.other_impr_building2_indicator;
    SELF.Diff_other_impr_building3_indicator := le.other_impr_building3_indicator <> ri.other_impr_building3_indicator;
    SELF.Diff_other_impr_building4_indicator := le.other_impr_building4_indicator <> ri.other_impr_building4_indicator;
    SELF.Diff_other_impr_building5_indicator := le.other_impr_building5_indicator <> ri.other_impr_building5_indicator;
    SELF.Diff_other_impr_building_area1 := le.other_impr_building_area1 <> ri.other_impr_building_area1;
    SELF.Diff_other_impr_building_area2 := le.other_impr_building_area2 <> ri.other_impr_building_area2;
    SELF.Diff_other_impr_building_area3 := le.other_impr_building_area3 <> ri.other_impr_building_area3;
    SELF.Diff_other_impr_building_area4 := le.other_impr_building_area4 <> ri.other_impr_building_area4;
    SELF.Diff_other_impr_building_area5 := le.other_impr_building_area5 <> ri.other_impr_building_area5;
    SELF.Diff_topograpy_code := le.topograpy_code <> ri.topograpy_code;
    SELF.Diff_neighborhood_code := le.neighborhood_code <> ri.neighborhood_code;
    SELF.Diff_condo_project_or_building_name := le.condo_project_or_building_name <> ri.condo_project_or_building_name;
    SELF.Diff_assessee_name_indicator := le.assessee_name_indicator <> ri.assessee_name_indicator;
    SELF.Diff_second_assessee_name_indicator := le.second_assessee_name_indicator <> ri.second_assessee_name_indicator;
    SELF.Diff_other_rooms_indicator := le.other_rooms_indicator <> ri.other_rooms_indicator;
    SELF.Diff_mail_care_of_name_indicator := le.mail_care_of_name_indicator <> ri.mail_care_of_name_indicator;
    SELF.Diff_comments := le.comments <> ri.comments;
    SELF.Diff_tape_cut_date := le.tape_cut_date <> ri.tape_cut_date;
    SELF.Diff_certification_date := le.certification_date <> ri.certification_date;
    SELF.Diff_edition_number := le.edition_number <> ri.edition_number;
    SELF.Diff_prop_addr_propagated_ind := le.prop_addr_propagated_ind <> ri.prop_addr_propagated_ind;
    SELF.Diff_ln_ownership_rights := le.ln_ownership_rights <> ri.ln_ownership_rights;
    SELF.Diff_ln_relationship_type := le.ln_relationship_type <> ri.ln_relationship_type;
    SELF.Diff_ln_mailing_country_code := le.ln_mailing_country_code <> ri.ln_mailing_country_code;
    SELF.Diff_ln_property_name := le.ln_property_name <> ri.ln_property_name;
    SELF.Diff_ln_property_name_type := le.ln_property_name_type <> ri.ln_property_name_type;
    SELF.Diff_ln_land_use_category := le.ln_land_use_category <> ri.ln_land_use_category;
    SELF.Diff_ln_lot := le.ln_lot <> ri.ln_lot;
    SELF.Diff_ln_block := le.ln_block <> ri.ln_block;
    SELF.Diff_ln_unit := le.ln_unit <> ri.ln_unit;
    SELF.Diff_ln_subfloor := le.ln_subfloor <> ri.ln_subfloor;
    SELF.Diff_ln_floor_cover := le.ln_floor_cover <> ri.ln_floor_cover;
    SELF.Diff_ln_mobile_home_indicator := le.ln_mobile_home_indicator <> ri.ln_mobile_home_indicator;
    SELF.Diff_ln_condo_indicator := le.ln_condo_indicator <> ri.ln_condo_indicator;
    SELF.Diff_ln_property_tax_exemption := le.ln_property_tax_exemption <> ri.ln_property_tax_exemption;
    SELF.Diff_ln_veteran_status := le.ln_veteran_status <> ri.ln_veteran_status;
    SELF.Diff_ln_old_apn_indicator := le.ln_old_apn_indicator <> ri.ln_old_apn_indicator;
    SELF.Diff_fips := le.fips <> ri.fips;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.fips_code;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_ln_fares_id,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_vendor_source_flag,1,0)+ IF( SELF.Diff_current_record,1,0)+ IF( SELF.Diff_fips_code,1,0)+ IF( SELF.Diff_state_code,1,0)+ IF( SELF.Diff_county_name,1,0)+ IF( SELF.Diff_old_apn,1,0)+ IF( SELF.Diff_apna_or_pin_number,1,0)+ IF( SELF.Diff_fares_unformatted_apn,1,0)+ IF( SELF.Diff_duplicate_apn_multiple_address_id,1,0)+ IF( SELF.Diff_assessee_name,1,0)+ IF( SELF.Diff_second_assessee_name,1,0)+ IF( SELF.Diff_assessee_ownership_rights_code,1,0)+ IF( SELF.Diff_assessee_relationship_code,1,0)+ IF( SELF.Diff_assessee_phone_number,1,0)+ IF( SELF.Diff_tax_account_number,1,0)+ IF( SELF.Diff_contract_owner,1,0)+ IF( SELF.Diff_assessee_name_type_code,1,0)+ IF( SELF.Diff_second_assessee_name_type_code,1,0)+ IF( SELF.Diff_mail_care_of_name_type_code,1,0)+ IF( SELF.Diff_mailing_care_of_name,1,0)+ IF( SELF.Diff_mailing_full_street_address,1,0)+ IF( SELF.Diff_mailing_unit_number,1,0)+ IF( SELF.Diff_mailing_city_state_zip,1,0)+ IF( SELF.Diff_property_full_street_address,1,0)+ IF( SELF.Diff_property_unit_number,1,0)+ IF( SELF.Diff_property_city_state_zip,1,0)+ IF( SELF.Diff_property_country_code,1,0)+ IF( SELF.Diff_property_address_code,1,0)+ IF( SELF.Diff_legal_lot_code,1,0)+ IF( SELF.Diff_legal_lot_number,1,0)+ IF( SELF.Diff_legal_land_lot,1,0)+ IF( SELF.Diff_legal_block,1,0)+ IF( SELF.Diff_legal_section,1,0)+ IF( SELF.Diff_legal_district,1,0)+ IF( SELF.Diff_legal_unit,1,0)+ IF( SELF.Diff_legal_city_municipality_township,1,0)+ IF( SELF.Diff_legal_subdivision_name,1,0)+ IF( SELF.Diff_legal_phase_number,1,0)+ IF( SELF.Diff_legal_tract_number,1,0)+ IF( SELF.Diff_legal_sec_twn_rng_mer,1,0)+ IF( SELF.Diff_legal_brief_description,1,0)+ IF( SELF.Diff_legal_assessor_map_ref,1,0)+ IF( SELF.Diff_census_tract,1,0)+ IF( SELF.Diff_record_type_code,1,0)+ IF( SELF.Diff_ownership_type_code,1,0)+ IF( SELF.Diff_new_record_type_code,1,0)+ IF( SELF.Diff_state_land_use_code,1,0)+ IF( SELF.Diff_county_land_use_code,1,0)+ IF( SELF.Diff_county_land_use_description,1,0)+ IF( SELF.Diff_standardized_land_use_code,1,0)+ IF( SELF.Diff_timeshare_code,1,0)+ IF( SELF.Diff_zoning,1,0)+ IF( SELF.Diff_owner_occupied,1,0)+ IF( SELF.Diff_recorder_document_number,1,0)+ IF( SELF.Diff_recorder_book_number,1,0)+ IF( SELF.Diff_recorder_page_number,1,0)+ IF( SELF.Diff_transfer_date,1,0)+ IF( SELF.Diff_recording_date,1,0)+ IF( SELF.Diff_sale_date,1,0)+ IF( SELF.Diff_document_type,1,0)+ IF( SELF.Diff_sales_price,1,0)+ IF( SELF.Diff_sales_price_code,1,0)+ IF( SELF.Diff_mortgage_loan_amount,1,0)+ IF( SELF.Diff_mortgage_loan_type_code,1,0)+ IF( SELF.Diff_mortgage_lender_name,1,0)+ IF( SELF.Diff_mortgage_lender_type_code,1,0)+ IF( SELF.Diff_prior_transfer_date,1,0)+ IF( SELF.Diff_prior_recording_date,1,0)+ IF( SELF.Diff_prior_sales_price,1,0)+ IF( SELF.Diff_prior_sales_price_code,1,0)+ IF( SELF.Diff_assessed_land_value,1,0)+ IF( SELF.Diff_assessed_improvement_value,1,0)+ IF( SELF.Diff_assessed_total_value,1,0)+ IF( SELF.Diff_assessed_value_year,1,0)+ IF( SELF.Diff_market_land_value,1,0)+ IF( SELF.Diff_market_improvement_value,1,0)+ IF( SELF.Diff_market_total_value,1,0)+ IF( SELF.Diff_market_value_year,1,0)+ IF( SELF.Diff_homestead_homeowner_exemption,1,0)+ IF( SELF.Diff_tax_exemption1_code,1,0)+ IF( SELF.Diff_tax_exemption2_code,1,0)+ IF( SELF.Diff_tax_exemption3_code,1,0)+ IF( SELF.Diff_tax_exemption4_code,1,0)+ IF( SELF.Diff_tax_rate_code_area,1,0)+ IF( SELF.Diff_tax_amount,1,0)+ IF( SELF.Diff_tax_year,1,0)+ IF( SELF.Diff_tax_delinquent_year,1,0)+ IF( SELF.Diff_school_tax_district1,1,0)+ IF( SELF.Diff_school_tax_district1_indicator,1,0)+ IF( SELF.Diff_school_tax_district2,1,0)+ IF( SELF.Diff_school_tax_district2_indicator,1,0)+ IF( SELF.Diff_school_tax_district3,1,0)+ IF( SELF.Diff_school_tax_district3_indicator,1,0)+ IF( SELF.Diff_lot_size,1,0)+ IF( SELF.Diff_lot_size_acres,1,0)+ IF( SELF.Diff_lot_size_frontage_feet,1,0)+ IF( SELF.Diff_lot_size_depth_feet,1,0)+ IF( SELF.Diff_land_acres,1,0)+ IF( SELF.Diff_land_square_footage,1,0)+ IF( SELF.Diff_land_dimensions,1,0)+ IF( SELF.Diff_building_area,1,0)+ IF( SELF.Diff_building_area_indicator,1,0)+ IF( SELF.Diff_building_area1,1,0)+ IF( SELF.Diff_building_area1_indicator,1,0)+ IF( SELF.Diff_building_area2,1,0)+ IF( SELF.Diff_building_area2_indicator,1,0)+ IF( SELF.Diff_building_area3,1,0)+ IF( SELF.Diff_building_area3_indicator,1,0)+ IF( SELF.Diff_building_area4,1,0)+ IF( SELF.Diff_building_area4_indicator,1,0)+ IF( SELF.Diff_building_area5,1,0)+ IF( SELF.Diff_building_area5_indicator,1,0)+ IF( SELF.Diff_building_area6,1,0)+ IF( SELF.Diff_building_area6_indicator,1,0)+ IF( SELF.Diff_building_area7,1,0)+ IF( SELF.Diff_building_area7_indicator,1,0)+ IF( SELF.Diff_year_built,1,0)+ IF( SELF.Diff_effective_year_built,1,0)+ IF( SELF.Diff_no_of_buildings,1,0)+ IF( SELF.Diff_no_of_stories,1,0)+ IF( SELF.Diff_no_of_units,1,0)+ IF( SELF.Diff_no_of_rooms,1,0)+ IF( SELF.Diff_no_of_bedrooms,1,0)+ IF( SELF.Diff_no_of_baths,1,0)+ IF( SELF.Diff_no_of_partial_baths,1,0)+ IF( SELF.Diff_no_of_plumbing_fixtures,1,0)+ IF( SELF.Diff_garage_type_code,1,0)+ IF( SELF.Diff_parking_no_of_cars,1,0)+ IF( SELF.Diff_pool_code,1,0)+ IF( SELF.Diff_style_code,1,0)+ IF( SELF.Diff_type_construction_code,1,0)+ IF( SELF.Diff_foundation_code,1,0)+ IF( SELF.Diff_building_quality_code,1,0)+ IF( SELF.Diff_building_condition_code,1,0)+ IF( SELF.Diff_exterior_walls_code,1,0)+ IF( SELF.Diff_interior_walls_code,1,0)+ IF( SELF.Diff_roof_cover_code,1,0)+ IF( SELF.Diff_roof_type_code,1,0)+ IF( SELF.Diff_floor_cover_code,1,0)+ IF( SELF.Diff_water_code,1,0)+ IF( SELF.Diff_sewer_code,1,0)+ IF( SELF.Diff_heating_code,1,0)+ IF( SELF.Diff_heating_fuel_type_code,1,0)+ IF( SELF.Diff_air_conditioning_code,1,0)+ IF( SELF.Diff_air_conditioning_type_code,1,0)+ IF( SELF.Diff_elevator,1,0)+ IF( SELF.Diff_fireplace_indicator,1,0)+ IF( SELF.Diff_fireplace_number,1,0)+ IF( SELF.Diff_basement_code,1,0)+ IF( SELF.Diff_building_class_code,1,0)+ IF( SELF.Diff_site_influence1_code,1,0)+ IF( SELF.Diff_site_influence2_code,1,0)+ IF( SELF.Diff_site_influence3_code,1,0)+ IF( SELF.Diff_site_influence4_code,1,0)+ IF( SELF.Diff_site_influence5_code,1,0)+ IF( SELF.Diff_amenities1_code,1,0)+ IF( SELF.Diff_amenities2_code,1,0)+ IF( SELF.Diff_amenities3_code,1,0)+ IF( SELF.Diff_amenities4_code,1,0)+ IF( SELF.Diff_amenities5_code,1,0)+ IF( SELF.Diff_amenities2_code1,1,0)+ IF( SELF.Diff_amenities2_code2,1,0)+ IF( SELF.Diff_amenities2_code3,1,0)+ IF( SELF.Diff_amenities2_code4,1,0)+ IF( SELF.Diff_amenities2_code5,1,0)+ IF( SELF.Diff_extra_features1_area,1,0)+ IF( SELF.Diff_extra_features1_indicator,1,0)+ IF( SELF.Diff_extra_features2_area,1,0)+ IF( SELF.Diff_extra_features2_indicator,1,0)+ IF( SELF.Diff_extra_features3_area,1,0)+ IF( SELF.Diff_extra_features3_indicator,1,0)+ IF( SELF.Diff_extra_features4_area,1,0)+ IF( SELF.Diff_extra_features4_indicator,1,0)+ IF( SELF.Diff_other_buildings1_code,1,0)+ IF( SELF.Diff_other_buildings2_code,1,0)+ IF( SELF.Diff_other_buildings3_code,1,0)+ IF( SELF.Diff_other_buildings4_code,1,0)+ IF( SELF.Diff_other_buildings5_code,1,0)+ IF( SELF.Diff_other_impr_building1_indicator,1,0)+ IF( SELF.Diff_other_impr_building2_indicator,1,0)+ IF( SELF.Diff_other_impr_building3_indicator,1,0)+ IF( SELF.Diff_other_impr_building4_indicator,1,0)+ IF( SELF.Diff_other_impr_building5_indicator,1,0)+ IF( SELF.Diff_other_impr_building_area1,1,0)+ IF( SELF.Diff_other_impr_building_area2,1,0)+ IF( SELF.Diff_other_impr_building_area3,1,0)+ IF( SELF.Diff_other_impr_building_area4,1,0)+ IF( SELF.Diff_other_impr_building_area5,1,0)+ IF( SELF.Diff_topograpy_code,1,0)+ IF( SELF.Diff_neighborhood_code,1,0)+ IF( SELF.Diff_condo_project_or_building_name,1,0)+ IF( SELF.Diff_assessee_name_indicator,1,0)+ IF( SELF.Diff_second_assessee_name_indicator,1,0)+ IF( SELF.Diff_other_rooms_indicator,1,0)+ IF( SELF.Diff_mail_care_of_name_indicator,1,0)+ IF( SELF.Diff_comments,1,0)+ IF( SELF.Diff_tape_cut_date,1,0)+ IF( SELF.Diff_certification_date,1,0)+ IF( SELF.Diff_edition_number,1,0)+ IF( SELF.Diff_prop_addr_propagated_ind,1,0)+ IF( SELF.Diff_ln_ownership_rights,1,0)+ IF( SELF.Diff_ln_relationship_type,1,0)+ IF( SELF.Diff_ln_mailing_country_code,1,0)+ IF( SELF.Diff_ln_property_name,1,0)+ IF( SELF.Diff_ln_property_name_type,1,0)+ IF( SELF.Diff_ln_land_use_category,1,0)+ IF( SELF.Diff_ln_lot,1,0)+ IF( SELF.Diff_ln_block,1,0)+ IF( SELF.Diff_ln_unit,1,0)+ IF( SELF.Diff_ln_subfloor,1,0)+ IF( SELF.Diff_ln_floor_cover,1,0)+ IF( SELF.Diff_ln_mobile_home_indicator,1,0)+ IF( SELF.Diff_ln_condo_indicator,1,0)+ IF( SELF.Diff_ln_property_tax_exemption,1,0)+ IF( SELF.Diff_ln_veteran_status,1,0)+ IF( SELF.Diff_ln_old_apn_indicator,1,0)+ IF( SELF.Diff_fips,1,0);
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
    Count_Diff_fips_code := COUNT(GROUP,%Closest%.Diff_fips_code);
    Count_Diff_state_code := COUNT(GROUP,%Closest%.Diff_state_code);
    Count_Diff_county_name := COUNT(GROUP,%Closest%.Diff_county_name);
    Count_Diff_old_apn := COUNT(GROUP,%Closest%.Diff_old_apn);
    Count_Diff_apna_or_pin_number := COUNT(GROUP,%Closest%.Diff_apna_or_pin_number);
    Count_Diff_fares_unformatted_apn := COUNT(GROUP,%Closest%.Diff_fares_unformatted_apn);
    Count_Diff_duplicate_apn_multiple_address_id := COUNT(GROUP,%Closest%.Diff_duplicate_apn_multiple_address_id);
    Count_Diff_assessee_name := COUNT(GROUP,%Closest%.Diff_assessee_name);
    Count_Diff_second_assessee_name := COUNT(GROUP,%Closest%.Diff_second_assessee_name);
    Count_Diff_assessee_ownership_rights_code := COUNT(GROUP,%Closest%.Diff_assessee_ownership_rights_code);
    Count_Diff_assessee_relationship_code := COUNT(GROUP,%Closest%.Diff_assessee_relationship_code);
    Count_Diff_assessee_phone_number := COUNT(GROUP,%Closest%.Diff_assessee_phone_number);
    Count_Diff_tax_account_number := COUNT(GROUP,%Closest%.Diff_tax_account_number);
    Count_Diff_contract_owner := COUNT(GROUP,%Closest%.Diff_contract_owner);
    Count_Diff_assessee_name_type_code := COUNT(GROUP,%Closest%.Diff_assessee_name_type_code);
    Count_Diff_second_assessee_name_type_code := COUNT(GROUP,%Closest%.Diff_second_assessee_name_type_code);
    Count_Diff_mail_care_of_name_type_code := COUNT(GROUP,%Closest%.Diff_mail_care_of_name_type_code);
    Count_Diff_mailing_care_of_name := COUNT(GROUP,%Closest%.Diff_mailing_care_of_name);
    Count_Diff_mailing_full_street_address := COUNT(GROUP,%Closest%.Diff_mailing_full_street_address);
    Count_Diff_mailing_unit_number := COUNT(GROUP,%Closest%.Diff_mailing_unit_number);
    Count_Diff_mailing_city_state_zip := COUNT(GROUP,%Closest%.Diff_mailing_city_state_zip);
    Count_Diff_property_full_street_address := COUNT(GROUP,%Closest%.Diff_property_full_street_address);
    Count_Diff_property_unit_number := COUNT(GROUP,%Closest%.Diff_property_unit_number);
    Count_Diff_property_city_state_zip := COUNT(GROUP,%Closest%.Diff_property_city_state_zip);
    Count_Diff_property_country_code := COUNT(GROUP,%Closest%.Diff_property_country_code);
    Count_Diff_property_address_code := COUNT(GROUP,%Closest%.Diff_property_address_code);
    Count_Diff_legal_lot_code := COUNT(GROUP,%Closest%.Diff_legal_lot_code);
    Count_Diff_legal_lot_number := COUNT(GROUP,%Closest%.Diff_legal_lot_number);
    Count_Diff_legal_land_lot := COUNT(GROUP,%Closest%.Diff_legal_land_lot);
    Count_Diff_legal_block := COUNT(GROUP,%Closest%.Diff_legal_block);
    Count_Diff_legal_section := COUNT(GROUP,%Closest%.Diff_legal_section);
    Count_Diff_legal_district := COUNT(GROUP,%Closest%.Diff_legal_district);
    Count_Diff_legal_unit := COUNT(GROUP,%Closest%.Diff_legal_unit);
    Count_Diff_legal_city_municipality_township := COUNT(GROUP,%Closest%.Diff_legal_city_municipality_township);
    Count_Diff_legal_subdivision_name := COUNT(GROUP,%Closest%.Diff_legal_subdivision_name);
    Count_Diff_legal_phase_number := COUNT(GROUP,%Closest%.Diff_legal_phase_number);
    Count_Diff_legal_tract_number := COUNT(GROUP,%Closest%.Diff_legal_tract_number);
    Count_Diff_legal_sec_twn_rng_mer := COUNT(GROUP,%Closest%.Diff_legal_sec_twn_rng_mer);
    Count_Diff_legal_brief_description := COUNT(GROUP,%Closest%.Diff_legal_brief_description);
    Count_Diff_legal_assessor_map_ref := COUNT(GROUP,%Closest%.Diff_legal_assessor_map_ref);
    Count_Diff_census_tract := COUNT(GROUP,%Closest%.Diff_census_tract);
    Count_Diff_record_type_code := COUNT(GROUP,%Closest%.Diff_record_type_code);
    Count_Diff_ownership_type_code := COUNT(GROUP,%Closest%.Diff_ownership_type_code);
    Count_Diff_new_record_type_code := COUNT(GROUP,%Closest%.Diff_new_record_type_code);
    Count_Diff_state_land_use_code := COUNT(GROUP,%Closest%.Diff_state_land_use_code);
    Count_Diff_county_land_use_code := COUNT(GROUP,%Closest%.Diff_county_land_use_code);
    Count_Diff_county_land_use_description := COUNT(GROUP,%Closest%.Diff_county_land_use_description);
    Count_Diff_standardized_land_use_code := COUNT(GROUP,%Closest%.Diff_standardized_land_use_code);
    Count_Diff_timeshare_code := COUNT(GROUP,%Closest%.Diff_timeshare_code);
    Count_Diff_zoning := COUNT(GROUP,%Closest%.Diff_zoning);
    Count_Diff_owner_occupied := COUNT(GROUP,%Closest%.Diff_owner_occupied);
    Count_Diff_recorder_document_number := COUNT(GROUP,%Closest%.Diff_recorder_document_number);
    Count_Diff_recorder_book_number := COUNT(GROUP,%Closest%.Diff_recorder_book_number);
    Count_Diff_recorder_page_number := COUNT(GROUP,%Closest%.Diff_recorder_page_number);
    Count_Diff_transfer_date := COUNT(GROUP,%Closest%.Diff_transfer_date);
    Count_Diff_recording_date := COUNT(GROUP,%Closest%.Diff_recording_date);
    Count_Diff_sale_date := COUNT(GROUP,%Closest%.Diff_sale_date);
    Count_Diff_document_type := COUNT(GROUP,%Closest%.Diff_document_type);
    Count_Diff_sales_price := COUNT(GROUP,%Closest%.Diff_sales_price);
    Count_Diff_sales_price_code := COUNT(GROUP,%Closest%.Diff_sales_price_code);
    Count_Diff_mortgage_loan_amount := COUNT(GROUP,%Closest%.Diff_mortgage_loan_amount);
    Count_Diff_mortgage_loan_type_code := COUNT(GROUP,%Closest%.Diff_mortgage_loan_type_code);
    Count_Diff_mortgage_lender_name := COUNT(GROUP,%Closest%.Diff_mortgage_lender_name);
    Count_Diff_mortgage_lender_type_code := COUNT(GROUP,%Closest%.Diff_mortgage_lender_type_code);
    Count_Diff_prior_transfer_date := COUNT(GROUP,%Closest%.Diff_prior_transfer_date);
    Count_Diff_prior_recording_date := COUNT(GROUP,%Closest%.Diff_prior_recording_date);
    Count_Diff_prior_sales_price := COUNT(GROUP,%Closest%.Diff_prior_sales_price);
    Count_Diff_prior_sales_price_code := COUNT(GROUP,%Closest%.Diff_prior_sales_price_code);
    Count_Diff_assessed_land_value := COUNT(GROUP,%Closest%.Diff_assessed_land_value);
    Count_Diff_assessed_improvement_value := COUNT(GROUP,%Closest%.Diff_assessed_improvement_value);
    Count_Diff_assessed_total_value := COUNT(GROUP,%Closest%.Diff_assessed_total_value);
    Count_Diff_assessed_value_year := COUNT(GROUP,%Closest%.Diff_assessed_value_year);
    Count_Diff_market_land_value := COUNT(GROUP,%Closest%.Diff_market_land_value);
    Count_Diff_market_improvement_value := COUNT(GROUP,%Closest%.Diff_market_improvement_value);
    Count_Diff_market_total_value := COUNT(GROUP,%Closest%.Diff_market_total_value);
    Count_Diff_market_value_year := COUNT(GROUP,%Closest%.Diff_market_value_year);
    Count_Diff_homestead_homeowner_exemption := COUNT(GROUP,%Closest%.Diff_homestead_homeowner_exemption);
    Count_Diff_tax_exemption1_code := COUNT(GROUP,%Closest%.Diff_tax_exemption1_code);
    Count_Diff_tax_exemption2_code := COUNT(GROUP,%Closest%.Diff_tax_exemption2_code);
    Count_Diff_tax_exemption3_code := COUNT(GROUP,%Closest%.Diff_tax_exemption3_code);
    Count_Diff_tax_exemption4_code := COUNT(GROUP,%Closest%.Diff_tax_exemption4_code);
    Count_Diff_tax_rate_code_area := COUNT(GROUP,%Closest%.Diff_tax_rate_code_area);
    Count_Diff_tax_amount := COUNT(GROUP,%Closest%.Diff_tax_amount);
    Count_Diff_tax_year := COUNT(GROUP,%Closest%.Diff_tax_year);
    Count_Diff_tax_delinquent_year := COUNT(GROUP,%Closest%.Diff_tax_delinquent_year);
    Count_Diff_school_tax_district1 := COUNT(GROUP,%Closest%.Diff_school_tax_district1);
    Count_Diff_school_tax_district1_indicator := COUNT(GROUP,%Closest%.Diff_school_tax_district1_indicator);
    Count_Diff_school_tax_district2 := COUNT(GROUP,%Closest%.Diff_school_tax_district2);
    Count_Diff_school_tax_district2_indicator := COUNT(GROUP,%Closest%.Diff_school_tax_district2_indicator);
    Count_Diff_school_tax_district3 := COUNT(GROUP,%Closest%.Diff_school_tax_district3);
    Count_Diff_school_tax_district3_indicator := COUNT(GROUP,%Closest%.Diff_school_tax_district3_indicator);
    Count_Diff_lot_size := COUNT(GROUP,%Closest%.Diff_lot_size);
    Count_Diff_lot_size_acres := COUNT(GROUP,%Closest%.Diff_lot_size_acres);
    Count_Diff_lot_size_frontage_feet := COUNT(GROUP,%Closest%.Diff_lot_size_frontage_feet);
    Count_Diff_lot_size_depth_feet := COUNT(GROUP,%Closest%.Diff_lot_size_depth_feet);
    Count_Diff_land_acres := COUNT(GROUP,%Closest%.Diff_land_acres);
    Count_Diff_land_square_footage := COUNT(GROUP,%Closest%.Diff_land_square_footage);
    Count_Diff_land_dimensions := COUNT(GROUP,%Closest%.Diff_land_dimensions);
    Count_Diff_building_area := COUNT(GROUP,%Closest%.Diff_building_area);
    Count_Diff_building_area_indicator := COUNT(GROUP,%Closest%.Diff_building_area_indicator);
    Count_Diff_building_area1 := COUNT(GROUP,%Closest%.Diff_building_area1);
    Count_Diff_building_area1_indicator := COUNT(GROUP,%Closest%.Diff_building_area1_indicator);
    Count_Diff_building_area2 := COUNT(GROUP,%Closest%.Diff_building_area2);
    Count_Diff_building_area2_indicator := COUNT(GROUP,%Closest%.Diff_building_area2_indicator);
    Count_Diff_building_area3 := COUNT(GROUP,%Closest%.Diff_building_area3);
    Count_Diff_building_area3_indicator := COUNT(GROUP,%Closest%.Diff_building_area3_indicator);
    Count_Diff_building_area4 := COUNT(GROUP,%Closest%.Diff_building_area4);
    Count_Diff_building_area4_indicator := COUNT(GROUP,%Closest%.Diff_building_area4_indicator);
    Count_Diff_building_area5 := COUNT(GROUP,%Closest%.Diff_building_area5);
    Count_Diff_building_area5_indicator := COUNT(GROUP,%Closest%.Diff_building_area5_indicator);
    Count_Diff_building_area6 := COUNT(GROUP,%Closest%.Diff_building_area6);
    Count_Diff_building_area6_indicator := COUNT(GROUP,%Closest%.Diff_building_area6_indicator);
    Count_Diff_building_area7 := COUNT(GROUP,%Closest%.Diff_building_area7);
    Count_Diff_building_area7_indicator := COUNT(GROUP,%Closest%.Diff_building_area7_indicator);
    Count_Diff_year_built := COUNT(GROUP,%Closest%.Diff_year_built);
    Count_Diff_effective_year_built := COUNT(GROUP,%Closest%.Diff_effective_year_built);
    Count_Diff_no_of_buildings := COUNT(GROUP,%Closest%.Diff_no_of_buildings);
    Count_Diff_no_of_stories := COUNT(GROUP,%Closest%.Diff_no_of_stories);
    Count_Diff_no_of_units := COUNT(GROUP,%Closest%.Diff_no_of_units);
    Count_Diff_no_of_rooms := COUNT(GROUP,%Closest%.Diff_no_of_rooms);
    Count_Diff_no_of_bedrooms := COUNT(GROUP,%Closest%.Diff_no_of_bedrooms);
    Count_Diff_no_of_baths := COUNT(GROUP,%Closest%.Diff_no_of_baths);
    Count_Diff_no_of_partial_baths := COUNT(GROUP,%Closest%.Diff_no_of_partial_baths);
    Count_Diff_no_of_plumbing_fixtures := COUNT(GROUP,%Closest%.Diff_no_of_plumbing_fixtures);
    Count_Diff_garage_type_code := COUNT(GROUP,%Closest%.Diff_garage_type_code);
    Count_Diff_parking_no_of_cars := COUNT(GROUP,%Closest%.Diff_parking_no_of_cars);
    Count_Diff_pool_code := COUNT(GROUP,%Closest%.Diff_pool_code);
    Count_Diff_style_code := COUNT(GROUP,%Closest%.Diff_style_code);
    Count_Diff_type_construction_code := COUNT(GROUP,%Closest%.Diff_type_construction_code);
    Count_Diff_foundation_code := COUNT(GROUP,%Closest%.Diff_foundation_code);
    Count_Diff_building_quality_code := COUNT(GROUP,%Closest%.Diff_building_quality_code);
    Count_Diff_building_condition_code := COUNT(GROUP,%Closest%.Diff_building_condition_code);
    Count_Diff_exterior_walls_code := COUNT(GROUP,%Closest%.Diff_exterior_walls_code);
    Count_Diff_interior_walls_code := COUNT(GROUP,%Closest%.Diff_interior_walls_code);
    Count_Diff_roof_cover_code := COUNT(GROUP,%Closest%.Diff_roof_cover_code);
    Count_Diff_roof_type_code := COUNT(GROUP,%Closest%.Diff_roof_type_code);
    Count_Diff_floor_cover_code := COUNT(GROUP,%Closest%.Diff_floor_cover_code);
    Count_Diff_water_code := COUNT(GROUP,%Closest%.Diff_water_code);
    Count_Diff_sewer_code := COUNT(GROUP,%Closest%.Diff_sewer_code);
    Count_Diff_heating_code := COUNT(GROUP,%Closest%.Diff_heating_code);
    Count_Diff_heating_fuel_type_code := COUNT(GROUP,%Closest%.Diff_heating_fuel_type_code);
    Count_Diff_air_conditioning_code := COUNT(GROUP,%Closest%.Diff_air_conditioning_code);
    Count_Diff_air_conditioning_type_code := COUNT(GROUP,%Closest%.Diff_air_conditioning_type_code);
    Count_Diff_elevator := COUNT(GROUP,%Closest%.Diff_elevator);
    Count_Diff_fireplace_indicator := COUNT(GROUP,%Closest%.Diff_fireplace_indicator);
    Count_Diff_fireplace_number := COUNT(GROUP,%Closest%.Diff_fireplace_number);
    Count_Diff_basement_code := COUNT(GROUP,%Closest%.Diff_basement_code);
    Count_Diff_building_class_code := COUNT(GROUP,%Closest%.Diff_building_class_code);
    Count_Diff_site_influence1_code := COUNT(GROUP,%Closest%.Diff_site_influence1_code);
    Count_Diff_site_influence2_code := COUNT(GROUP,%Closest%.Diff_site_influence2_code);
    Count_Diff_site_influence3_code := COUNT(GROUP,%Closest%.Diff_site_influence3_code);
    Count_Diff_site_influence4_code := COUNT(GROUP,%Closest%.Diff_site_influence4_code);
    Count_Diff_site_influence5_code := COUNT(GROUP,%Closest%.Diff_site_influence5_code);
    Count_Diff_amenities1_code := COUNT(GROUP,%Closest%.Diff_amenities1_code);
    Count_Diff_amenities2_code := COUNT(GROUP,%Closest%.Diff_amenities2_code);
    Count_Diff_amenities3_code := COUNT(GROUP,%Closest%.Diff_amenities3_code);
    Count_Diff_amenities4_code := COUNT(GROUP,%Closest%.Diff_amenities4_code);
    Count_Diff_amenities5_code := COUNT(GROUP,%Closest%.Diff_amenities5_code);
    Count_Diff_amenities2_code1 := COUNT(GROUP,%Closest%.Diff_amenities2_code1);
    Count_Diff_amenities2_code2 := COUNT(GROUP,%Closest%.Diff_amenities2_code2);
    Count_Diff_amenities2_code3 := COUNT(GROUP,%Closest%.Diff_amenities2_code3);
    Count_Diff_amenities2_code4 := COUNT(GROUP,%Closest%.Diff_amenities2_code4);
    Count_Diff_amenities2_code5 := COUNT(GROUP,%Closest%.Diff_amenities2_code5);
    Count_Diff_extra_features1_area := COUNT(GROUP,%Closest%.Diff_extra_features1_area);
    Count_Diff_extra_features1_indicator := COUNT(GROUP,%Closest%.Diff_extra_features1_indicator);
    Count_Diff_extra_features2_area := COUNT(GROUP,%Closest%.Diff_extra_features2_area);
    Count_Diff_extra_features2_indicator := COUNT(GROUP,%Closest%.Diff_extra_features2_indicator);
    Count_Diff_extra_features3_area := COUNT(GROUP,%Closest%.Diff_extra_features3_area);
    Count_Diff_extra_features3_indicator := COUNT(GROUP,%Closest%.Diff_extra_features3_indicator);
    Count_Diff_extra_features4_area := COUNT(GROUP,%Closest%.Diff_extra_features4_area);
    Count_Diff_extra_features4_indicator := COUNT(GROUP,%Closest%.Diff_extra_features4_indicator);
    Count_Diff_other_buildings1_code := COUNT(GROUP,%Closest%.Diff_other_buildings1_code);
    Count_Diff_other_buildings2_code := COUNT(GROUP,%Closest%.Diff_other_buildings2_code);
    Count_Diff_other_buildings3_code := COUNT(GROUP,%Closest%.Diff_other_buildings3_code);
    Count_Diff_other_buildings4_code := COUNT(GROUP,%Closest%.Diff_other_buildings4_code);
    Count_Diff_other_buildings5_code := COUNT(GROUP,%Closest%.Diff_other_buildings5_code);
    Count_Diff_other_impr_building1_indicator := COUNT(GROUP,%Closest%.Diff_other_impr_building1_indicator);
    Count_Diff_other_impr_building2_indicator := COUNT(GROUP,%Closest%.Diff_other_impr_building2_indicator);
    Count_Diff_other_impr_building3_indicator := COUNT(GROUP,%Closest%.Diff_other_impr_building3_indicator);
    Count_Diff_other_impr_building4_indicator := COUNT(GROUP,%Closest%.Diff_other_impr_building4_indicator);
    Count_Diff_other_impr_building5_indicator := COUNT(GROUP,%Closest%.Diff_other_impr_building5_indicator);
    Count_Diff_other_impr_building_area1 := COUNT(GROUP,%Closest%.Diff_other_impr_building_area1);
    Count_Diff_other_impr_building_area2 := COUNT(GROUP,%Closest%.Diff_other_impr_building_area2);
    Count_Diff_other_impr_building_area3 := COUNT(GROUP,%Closest%.Diff_other_impr_building_area3);
    Count_Diff_other_impr_building_area4 := COUNT(GROUP,%Closest%.Diff_other_impr_building_area4);
    Count_Diff_other_impr_building_area5 := COUNT(GROUP,%Closest%.Diff_other_impr_building_area5);
    Count_Diff_topograpy_code := COUNT(GROUP,%Closest%.Diff_topograpy_code);
    Count_Diff_neighborhood_code := COUNT(GROUP,%Closest%.Diff_neighborhood_code);
    Count_Diff_condo_project_or_building_name := COUNT(GROUP,%Closest%.Diff_condo_project_or_building_name);
    Count_Diff_assessee_name_indicator := COUNT(GROUP,%Closest%.Diff_assessee_name_indicator);
    Count_Diff_second_assessee_name_indicator := COUNT(GROUP,%Closest%.Diff_second_assessee_name_indicator);
    Count_Diff_other_rooms_indicator := COUNT(GROUP,%Closest%.Diff_other_rooms_indicator);
    Count_Diff_mail_care_of_name_indicator := COUNT(GROUP,%Closest%.Diff_mail_care_of_name_indicator);
    Count_Diff_comments := COUNT(GROUP,%Closest%.Diff_comments);
    Count_Diff_tape_cut_date := COUNT(GROUP,%Closest%.Diff_tape_cut_date);
    Count_Diff_certification_date := COUNT(GROUP,%Closest%.Diff_certification_date);
    Count_Diff_edition_number := COUNT(GROUP,%Closest%.Diff_edition_number);
    Count_Diff_prop_addr_propagated_ind := COUNT(GROUP,%Closest%.Diff_prop_addr_propagated_ind);
    Count_Diff_ln_ownership_rights := COUNT(GROUP,%Closest%.Diff_ln_ownership_rights);
    Count_Diff_ln_relationship_type := COUNT(GROUP,%Closest%.Diff_ln_relationship_type);
    Count_Diff_ln_mailing_country_code := COUNT(GROUP,%Closest%.Diff_ln_mailing_country_code);
    Count_Diff_ln_property_name := COUNT(GROUP,%Closest%.Diff_ln_property_name);
    Count_Diff_ln_property_name_type := COUNT(GROUP,%Closest%.Diff_ln_property_name_type);
    Count_Diff_ln_land_use_category := COUNT(GROUP,%Closest%.Diff_ln_land_use_category);
    Count_Diff_ln_lot := COUNT(GROUP,%Closest%.Diff_ln_lot);
    Count_Diff_ln_block := COUNT(GROUP,%Closest%.Diff_ln_block);
    Count_Diff_ln_unit := COUNT(GROUP,%Closest%.Diff_ln_unit);
    Count_Diff_ln_subfloor := COUNT(GROUP,%Closest%.Diff_ln_subfloor);
    Count_Diff_ln_floor_cover := COUNT(GROUP,%Closest%.Diff_ln_floor_cover);
    Count_Diff_ln_mobile_home_indicator := COUNT(GROUP,%Closest%.Diff_ln_mobile_home_indicator);
    Count_Diff_ln_condo_indicator := COUNT(GROUP,%Closest%.Diff_ln_condo_indicator);
    Count_Diff_ln_property_tax_exemption := COUNT(GROUP,%Closest%.Diff_ln_property_tax_exemption);
    Count_Diff_ln_veteran_status := COUNT(GROUP,%Closest%.Diff_ln_veteran_status);
    Count_Diff_ln_old_apn_indicator := COUNT(GROUP,%Closest%.Diff_ln_old_apn_indicator);
    Count_Diff_fips := COUNT(GROUP,%Closest%.Diff_fips);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;

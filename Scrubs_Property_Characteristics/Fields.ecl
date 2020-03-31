IMPORT SALT311;
IMPORT Scrubs,Scrubs_LN_PropertyV2_Assessor,Scrubs_Property_Characteristics; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 283;
EXPORT invalid_fipsDCT := DICTIONARY(Scrubs_LN_PropertyV2_Assessor.file_fips,{fips_code => Scrubs_LN_PropertyV2_Assessor.file_fips});
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_nums','invalid_vendor_source','invalid_fireplace_indicator','invalid_alpha','invalid_address','invalid_csz','invalid_county_name','invalid_apn','invalid_zip','invalid_year','invalid_date','invalid_fips','invalid_prop_amount','invalid_tax_amount','invalid_document_number','invalid_land_use','invalid_air_conditioning_type_code','invalid_basement_finish_type_code','invalid_construction_type_code','invalid_exterior_walls_code','invalid_fireplace_type','invalid_floor_cover_code','invalid_frame_code','invalid_foundation_type','invalid_garage_type','invalid_heating_fuel_type','invalid_heating_type','invalid_location_code','invalid_parking_type','invalid_pool_type','invalid_property_code','invalid_roof_type','invalid_sale_code','invalid_sale_tran_code','invalid_sewer_type','invalid_stories_type','invalid_structure_quality_code','invalid_style_type','invalid_water_type','invalid_financing_type_code','invalid_mortgage_loan_type_code','invalid_mortgage_lender_type_code');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_nums' => 1,'invalid_vendor_source' => 2,'invalid_fireplace_indicator' => 3,'invalid_alpha' => 4,'invalid_address' => 5,'invalid_csz' => 6,'invalid_county_name' => 7,'invalid_apn' => 8,'invalid_zip' => 9,'invalid_year' => 10,'invalid_date' => 11,'invalid_fips' => 12,'invalid_prop_amount' => 13,'invalid_tax_amount' => 14,'invalid_document_number' => 15,'invalid_land_use' => 16,'invalid_air_conditioning_type_code' => 17,'invalid_basement_finish_type_code' => 18,'invalid_construction_type_code' => 19,'invalid_exterior_walls_code' => 20,'invalid_fireplace_type' => 21,'invalid_floor_cover_code' => 22,'invalid_frame_code' => 23,'invalid_foundation_type' => 24,'invalid_garage_type' => 25,'invalid_heating_fuel_type' => 26,'invalid_heating_type' => 27,'invalid_location_code' => 28,'invalid_parking_type' => 29,'invalid_pool_type' => 30,'invalid_property_code' => 31,'invalid_roof_type' => 32,'invalid_sale_code' => 33,'invalid_sale_tran_code' => 34,'invalid_sewer_type' => 35,'invalid_stories_type' => 36,'invalid_structure_quality_code' => 37,'invalid_style_type' => 38,'invalid_water_type' => 39,'invalid_financing_type_code' => 40,'invalid_mortgage_loan_type_code' => 41,'invalid_mortgage_lender_type_code' => 42,0);
 
EXPORT MakeFT_invalid_nums(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789. '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_nums(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789. '))));
EXPORT InValidMessageFT_invalid_nums(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789. '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_vendor_source(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_vendor_source(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['FARES','OKCTY','DEFLT','MLS',''],~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_vendor_source(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('FARES|OKCTY|DEFLT|MLS|'),SALT311.HygieneErrors.NotLength('0,5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fireplace_indicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fireplace_indicator(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Y','N','']);
EXPORT InValidMessageFT_invalid_fireplace_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Y|N|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' &(),-/.\'#:;*+;ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' &(),-/.\'#:;*+;ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' &(),-/.\'#:;*+;ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_address(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_csz(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ,-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_csz(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ,-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_invalid_csz(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ,-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT311.HygieneErrors.Good);
 
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
EXPORT InValidFT_invalid_apn(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' _-.,/:&()*0123456789:;ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))));
EXPORT InValidMessageFT_invalid_apn(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' _-.,/:&()*0123456789:;ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('5,9'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_year(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_year(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_year(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,4'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_fips(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),((SALT311.StrType) s) NOT IN invalid_fipsDCT,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_fips(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('0,5'),SALT311.HygieneErrors.NotWithinFile('Scrubs_LN_PropertyV2_Assessor.file_fips'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_prop_amount(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_prop_amount(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789.'))),~(0 <= (INTEGER4)s AND (INTEGER4)s <= 10000000));
EXPORT InValidMessageFT_invalid_prop_amount(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789.'),SALT311.HygieneErrors.NotInRange('0,10000000'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_tax_amount(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_tax_amount(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789.'))));
EXPORT InValidMessageFT_invalid_tax_amount(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789.'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_document_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefqhijklmnopqrstuvwxyz0123456789()/-&\':_. '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_document_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefqhijklmnopqrstuvwxyz0123456789()/-&\':_. '))));
EXPORT InValidMessageFT_invalid_document_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefqhijklmnopqrstuvwxyz0123456789()/-&\':_. '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_land_use(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_land_use(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'LAND_USE_CODE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_land_use(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_air_conditioning_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_air_conditioning_type_code(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'AIR_CONDITIONING_TYPE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_air_conditioning_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_basement_finish_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_basement_finish_type_code(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'BASEMENT_FINISH','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_basement_finish_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_construction_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_construction_type_code(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'CONSTRUCTION_TYPE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_construction_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_exterior_walls_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_exterior_walls_code(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'EXTERIOR_WALL','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_exterior_walls_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fireplace_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fireplace_type(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'FIREPLACE_TYPE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_fireplace_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_floor_cover_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_floor_cover_code(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'FLOOR_COVER','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_floor_cover_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_frame_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_frame_code(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'FRAME','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_frame_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_foundation_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_foundation_type(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'FOUNDATION_TYPE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_foundation_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_garage_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_garage_type(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'GARAGE_TYPE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_garage_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_heating_fuel_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_heating_fuel_type(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'FUEL_TYPE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_heating_fuel_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_heating_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_heating_type(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'HEATING_TYPE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_heating_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_location_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_location_code(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'LOCATION_INFLUENCE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_location_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_parking_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_parking_type(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'PARKING_TYPE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_parking_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pool_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pool_type(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'POOL_TYPE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_pool_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_property_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_property_code(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'PROPERTY_IND','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_property_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_roof_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_roof_type(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'ROOF_COVER_TYPE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_roof_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sale_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sale_code(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'SALE_CODE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_sale_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sale_tran_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sale_tran_code(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'SALE_TRANS_CODE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_sale_tran_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sewer_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sewer_type(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'SEWER_TYPE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_sewer_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_stories_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_stories_type(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'STORIES_TYPE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_stories_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_structure_quality_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_structure_quality_code(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'QUALITY','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_structure_quality_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_style_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_style_type(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'STYLE_TYPE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_style_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_water_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_water_type(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'WATER_TYPE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_water_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_financing_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_financing_type_code(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'TYPE_FINANCING','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_financing_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mortgage_loan_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mortgage_loan_type_code(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'MORTGAGE_LOAN_TYPE_CODE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_mortgage_loan_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mortgage_lender_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mortgage_lender_type_code(SALT311.StrType s) := WHICH(~Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo(s,'MORTGAGE_LENDER_TYPE_CODE','PROPERTYINFO')>0);
EXPORT InValidMessageFT_invalid_mortgage_lender_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'property_rid','dt_vendor_first_reported','dt_vendor_last_reported','tax_sortby_date','deed_sortby_date','vendor_source','fares_unformatted_apn','property_street_address','property_city_state_zip','property_raw_aid','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','building_square_footage','src_building_square_footage','tax_dt_building_square_footage','air_conditioning_type','src_air_conditioning_type','tax_dt_air_conditioning_type','basement_finish','src_basement_finish','tax_dt_basement_finish','construction_type','src_construction_type','tax_dt_construction_type','exterior_wall','src_exterior_wall','tax_dt_exterior_wall','fireplace_ind','src_fireplace_ind','tax_dt_fireplace_ind','fireplace_type','src_fireplace_type','tax_dt_fireplace_type','flood_zone_panel','src_flood_zone_panel','tax_dt_flood_zone_panel','garage','src_garage','tax_dt_garage','first_floor_square_footage','src_first_floor_square_footage','tax_dt_first_floor_square_footage','heating','src_heating','tax_dt_heating','living_area_square_footage','src_living_area_square_footage','tax_dt_living_area_square_footage','no_of_baths','src_no_of_baths','tax_dt_no_of_baths','no_of_bedrooms','src_no_of_bedrooms','tax_dt_no_of_bedrooms','no_of_fireplaces','src_no_of_fireplaces','tax_dt_no_of_fireplaces','no_of_full_baths','src_no_of_full_baths','tax_dt_no_of_full_baths','no_of_half_baths','src_no_of_half_baths','tax_dt_no_of_half_baths','no_of_stories','src_no_of_stories','tax_dt_no_of_stories','parking_type','src_parking_type','tax_dt_parking_type','pool_indicator','src_pool_indicator','tax_dt_pool_indicator','pool_type','src_pool_type','tax_dt_pool_type','roof_cover','src_roof_cover','tax_dt_roof_cover','year_built','src_year_built','tax_dt_year_built','foundation','src_foundation','tax_dt_foundation','basement_square_footage','src_basement_square_footage','tax_dt_basement_square_footage','effective_year_built','src_effective_year_built','tax_dt_effective_year_built','garage_square_footage','src_garage_square_footage','tax_dt_garage_square_footage','stories_type','src_stories_type','tax_dt_stories_type','apn_number','src_apn_number','tax_dt_apn_number','census_tract','src_census_tract','tax_dt_census_tract','range','src_range','tax_dt_range','zoning','src_zoning','tax_dt_zoning','block_number','src_block_number','tax_dt_block_number','county_name','src_county_name','tax_dt_county_name','fips_code','src_fips_code','tax_dt_fips_code','subdivision','src_subdivision','tax_dt_subdivision','municipality','src_municipality','tax_dt_municipality','township','src_township','tax_dt_township','homestead_exemption_ind','src_homestead_exemption_ind','tax_dt_homestead_exemption_ind','land_use_code','src_land_use_code','tax_dt_land_use_code','latitude','src_latitude','tax_dt_latitude','longitude','src_longitude','tax_dt_longitude','location_influence_code','src_location_influence_code','tax_dt_location_influence_code','acres','src_acres','tax_dt_acres','lot_depth_footage','src_lot_depth_footage','tax_dt_lot_depth_footage','lot_front_footage','src_lot_front_footage','tax_dt_lot_front_footage','lot_number','src_lot_number','tax_dt_lot_number','lot_size','src_lot_size','tax_dt_lot_size','property_type_code','src_property_type_code','tax_dt_property_type_code','structure_quality','src_structure_quality','tax_dt_structure_quality','water','src_water','tax_dt_water','sewer','src_sewer','tax_dt_sewer','assessed_land_value','src_assessed_land_value','tax_dt_assessed_land_value','assessed_year','src_assessed_year','tax_dt_assessed_year','tax_amount','src_tax_amount','tax_dt_tax_amount','tax_year','src_tax_year','market_land_value','src_market_land_value','tax_dt_market_land_value','improvement_value','src_improvement_value','tax_dt_improvement_value','percent_improved','src_percent_improved','tax_dt_percent_improved','total_assessed_value','src_total_assessed_value','tax_dt_total_assessed_value','total_calculated_value','src_total_calculated_value','tax_dt_total_calculated_value','total_land_value','src_total_land_value','tax_dt_total_land_value','total_market_value','src_total_market_value','tax_dt_total_market_value','floor_type','src_floor_type','tax_dt_floor_type','frame_type','src_frame_type','tax_dt_frame_type','fuel_type','src_fuel_type','tax_dt_fuel_type','no_of_bath_fixtures','src_no_of_bath_fixtures','tax_dt_no_of_bath_fixtures','no_of_rooms','src_no_of_rooms','tax_dt_no_of_rooms','no_of_units','src_no_of_units','tax_dt_no_of_units','style_type','src_style_type','tax_dt_style_type','assessment_document_number','src_assessment_document_number','tax_dt_assessment_document_number','assessment_recording_date','src_assessment_recording_date','tax_dt_assessment_recording_date','deed_document_number','src_deed_document_number','rec_dt_deed_document_number','deed_recording_date','src_deed_recording_date','full_part_sale','src_full_part_sale','rec_dt_full_part_sale','sale_amount','src_sale_amount','rec_dt_sale_amount','sale_date','src_sale_date','rec_dt_sale_date','sale_type_code','src_sale_type_code','rec_dt_sale_type_code','mortgage_company_name','src_mortgage_company_name','rec_dt_mortgage_company_name','loan_amount','src_loan_amount','rec_dt_loan_amount','second_loan_amount','src_second_loan_amount','rec_dt_second_loan_amount','loan_type_code','src_loan_type_code','rec_dt_loan_type_code','interest_rate_type_code','src_interest_rate_type_code','rec_dt_interest_rate_type_code');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'property_rid','dt_vendor_first_reported','dt_vendor_last_reported','tax_sortby_date','deed_sortby_date','vendor_source','fares_unformatted_apn','property_street_address','property_city_state_zip','property_raw_aid','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','building_square_footage','src_building_square_footage','tax_dt_building_square_footage','air_conditioning_type','src_air_conditioning_type','tax_dt_air_conditioning_type','basement_finish','src_basement_finish','tax_dt_basement_finish','construction_type','src_construction_type','tax_dt_construction_type','exterior_wall','src_exterior_wall','tax_dt_exterior_wall','fireplace_ind','src_fireplace_ind','tax_dt_fireplace_ind','fireplace_type','src_fireplace_type','tax_dt_fireplace_type','flood_zone_panel','src_flood_zone_panel','tax_dt_flood_zone_panel','garage','src_garage','tax_dt_garage','first_floor_square_footage','src_first_floor_square_footage','tax_dt_first_floor_square_footage','heating','src_heating','tax_dt_heating','living_area_square_footage','src_living_area_square_footage','tax_dt_living_area_square_footage','no_of_baths','src_no_of_baths','tax_dt_no_of_baths','no_of_bedrooms','src_no_of_bedrooms','tax_dt_no_of_bedrooms','no_of_fireplaces','src_no_of_fireplaces','tax_dt_no_of_fireplaces','no_of_full_baths','src_no_of_full_baths','tax_dt_no_of_full_baths','no_of_half_baths','src_no_of_half_baths','tax_dt_no_of_half_baths','no_of_stories','src_no_of_stories','tax_dt_no_of_stories','parking_type','src_parking_type','tax_dt_parking_type','pool_indicator','src_pool_indicator','tax_dt_pool_indicator','pool_type','src_pool_type','tax_dt_pool_type','roof_cover','src_roof_cover','tax_dt_roof_cover','year_built','src_year_built','tax_dt_year_built','foundation','src_foundation','tax_dt_foundation','basement_square_footage','src_basement_square_footage','tax_dt_basement_square_footage','effective_year_built','src_effective_year_built','tax_dt_effective_year_built','garage_square_footage','src_garage_square_footage','tax_dt_garage_square_footage','stories_type','src_stories_type','tax_dt_stories_type','apn_number','src_apn_number','tax_dt_apn_number','census_tract','src_census_tract','tax_dt_census_tract','range','src_range','tax_dt_range','zoning','src_zoning','tax_dt_zoning','block_number','src_block_number','tax_dt_block_number','county_name','src_county_name','tax_dt_county_name','fips_code','src_fips_code','tax_dt_fips_code','subdivision','src_subdivision','tax_dt_subdivision','municipality','src_municipality','tax_dt_municipality','township','src_township','tax_dt_township','homestead_exemption_ind','src_homestead_exemption_ind','tax_dt_homestead_exemption_ind','land_use_code','src_land_use_code','tax_dt_land_use_code','latitude','src_latitude','tax_dt_latitude','longitude','src_longitude','tax_dt_longitude','location_influence_code','src_location_influence_code','tax_dt_location_influence_code','acres','src_acres','tax_dt_acres','lot_depth_footage','src_lot_depth_footage','tax_dt_lot_depth_footage','lot_front_footage','src_lot_front_footage','tax_dt_lot_front_footage','lot_number','src_lot_number','tax_dt_lot_number','lot_size','src_lot_size','tax_dt_lot_size','property_type_code','src_property_type_code','tax_dt_property_type_code','structure_quality','src_structure_quality','tax_dt_structure_quality','water','src_water','tax_dt_water','sewer','src_sewer','tax_dt_sewer','assessed_land_value','src_assessed_land_value','tax_dt_assessed_land_value','assessed_year','src_assessed_year','tax_dt_assessed_year','tax_amount','src_tax_amount','tax_dt_tax_amount','tax_year','src_tax_year','market_land_value','src_market_land_value','tax_dt_market_land_value','improvement_value','src_improvement_value','tax_dt_improvement_value','percent_improved','src_percent_improved','tax_dt_percent_improved','total_assessed_value','src_total_assessed_value','tax_dt_total_assessed_value','total_calculated_value','src_total_calculated_value','tax_dt_total_calculated_value','total_land_value','src_total_land_value','tax_dt_total_land_value','total_market_value','src_total_market_value','tax_dt_total_market_value','floor_type','src_floor_type','tax_dt_floor_type','frame_type','src_frame_type','tax_dt_frame_type','fuel_type','src_fuel_type','tax_dt_fuel_type','no_of_bath_fixtures','src_no_of_bath_fixtures','tax_dt_no_of_bath_fixtures','no_of_rooms','src_no_of_rooms','tax_dt_no_of_rooms','no_of_units','src_no_of_units','tax_dt_no_of_units','style_type','src_style_type','tax_dt_style_type','assessment_document_number','src_assessment_document_number','tax_dt_assessment_document_number','assessment_recording_date','src_assessment_recording_date','tax_dt_assessment_recording_date','deed_document_number','src_deed_document_number','rec_dt_deed_document_number','deed_recording_date','src_deed_recording_date','full_part_sale','src_full_part_sale','rec_dt_full_part_sale','sale_amount','src_sale_amount','rec_dt_sale_amount','sale_date','src_sale_date','rec_dt_sale_date','sale_type_code','src_sale_type_code','rec_dt_sale_type_code','mortgage_company_name','src_mortgage_company_name','rec_dt_mortgage_company_name','loan_amount','src_loan_amount','rec_dt_loan_amount','second_loan_amount','src_second_loan_amount','rec_dt_second_loan_amount','loan_type_code','src_loan_type_code','rec_dt_loan_type_code','interest_rate_type_code','src_interest_rate_type_code','rec_dt_interest_rate_type_code');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'property_rid' => 0,'dt_vendor_first_reported' => 1,'dt_vendor_last_reported' => 2,'tax_sortby_date' => 3,'deed_sortby_date' => 4,'vendor_source' => 5,'fares_unformatted_apn' => 6,'property_street_address' => 7,'property_city_state_zip' => 8,'property_raw_aid' => 9,'prim_range' => 10,'predir' => 11,'prim_name' => 12,'addr_suffix' => 13,'postdir' => 14,'unit_desig' => 15,'sec_range' => 16,'p_city_name' => 17,'v_city_name' => 18,'st' => 19,'zip' => 20,'zip4' => 21,'cart' => 22,'cr_sort_sz' => 23,'lot' => 24,'lot_order' => 25,'dbpc' => 26,'chk_digit' => 27,'rec_type' => 28,'county' => 29,'geo_lat' => 30,'geo_long' => 31,'msa' => 32,'geo_blk' => 33,'geo_match' => 34,'err_stat' => 35,'building_square_footage' => 36,'src_building_square_footage' => 37,'tax_dt_building_square_footage' => 38,'air_conditioning_type' => 39,'src_air_conditioning_type' => 40,'tax_dt_air_conditioning_type' => 41,'basement_finish' => 42,'src_basement_finish' => 43,'tax_dt_basement_finish' => 44,'construction_type' => 45,'src_construction_type' => 46,'tax_dt_construction_type' => 47,'exterior_wall' => 48,'src_exterior_wall' => 49,'tax_dt_exterior_wall' => 50,'fireplace_ind' => 51,'src_fireplace_ind' => 52,'tax_dt_fireplace_ind' => 53,'fireplace_type' => 54,'src_fireplace_type' => 55,'tax_dt_fireplace_type' => 56,'flood_zone_panel' => 57,'src_flood_zone_panel' => 58,'tax_dt_flood_zone_panel' => 59,'garage' => 60,'src_garage' => 61,'tax_dt_garage' => 62,'first_floor_square_footage' => 63,'src_first_floor_square_footage' => 64,'tax_dt_first_floor_square_footage' => 65,'heating' => 66,'src_heating' => 67,'tax_dt_heating' => 68,'living_area_square_footage' => 69,'src_living_area_square_footage' => 70,'tax_dt_living_area_square_footage' => 71,'no_of_baths' => 72,'src_no_of_baths' => 73,'tax_dt_no_of_baths' => 74,'no_of_bedrooms' => 75,'src_no_of_bedrooms' => 76,'tax_dt_no_of_bedrooms' => 77,'no_of_fireplaces' => 78,'src_no_of_fireplaces' => 79,'tax_dt_no_of_fireplaces' => 80,'no_of_full_baths' => 81,'src_no_of_full_baths' => 82,'tax_dt_no_of_full_baths' => 83,'no_of_half_baths' => 84,'src_no_of_half_baths' => 85,'tax_dt_no_of_half_baths' => 86,'no_of_stories' => 87,'src_no_of_stories' => 88,'tax_dt_no_of_stories' => 89,'parking_type' => 90,'src_parking_type' => 91,'tax_dt_parking_type' => 92,'pool_indicator' => 93,'src_pool_indicator' => 94,'tax_dt_pool_indicator' => 95,'pool_type' => 96,'src_pool_type' => 97,'tax_dt_pool_type' => 98,'roof_cover' => 99,'src_roof_cover' => 100,'tax_dt_roof_cover' => 101,'year_built' => 102,'src_year_built' => 103,'tax_dt_year_built' => 104,'foundation' => 105,'src_foundation' => 106,'tax_dt_foundation' => 107,'basement_square_footage' => 108,'src_basement_square_footage' => 109,'tax_dt_basement_square_footage' => 110,'effective_year_built' => 111,'src_effective_year_built' => 112,'tax_dt_effective_year_built' => 113,'garage_square_footage' => 114,'src_garage_square_footage' => 115,'tax_dt_garage_square_footage' => 116,'stories_type' => 117,'src_stories_type' => 118,'tax_dt_stories_type' => 119,'apn_number' => 120,'src_apn_number' => 121,'tax_dt_apn_number' => 122,'census_tract' => 123,'src_census_tract' => 124,'tax_dt_census_tract' => 125,'range' => 126,'src_range' => 127,'tax_dt_range' => 128,'zoning' => 129,'src_zoning' => 130,'tax_dt_zoning' => 131,'block_number' => 132,'src_block_number' => 133,'tax_dt_block_number' => 134,'county_name' => 135,'src_county_name' => 136,'tax_dt_county_name' => 137,'fips_code' => 138,'src_fips_code' => 139,'tax_dt_fips_code' => 140,'subdivision' => 141,'src_subdivision' => 142,'tax_dt_subdivision' => 143,'municipality' => 144,'src_municipality' => 145,'tax_dt_municipality' => 146,'township' => 147,'src_township' => 148,'tax_dt_township' => 149,'homestead_exemption_ind' => 150,'src_homestead_exemption_ind' => 151,'tax_dt_homestead_exemption_ind' => 152,'land_use_code' => 153,'src_land_use_code' => 154,'tax_dt_land_use_code' => 155,'latitude' => 156,'src_latitude' => 157,'tax_dt_latitude' => 158,'longitude' => 159,'src_longitude' => 160,'tax_dt_longitude' => 161,'location_influence_code' => 162,'src_location_influence_code' => 163,'tax_dt_location_influence_code' => 164,'acres' => 165,'src_acres' => 166,'tax_dt_acres' => 167,'lot_depth_footage' => 168,'src_lot_depth_footage' => 169,'tax_dt_lot_depth_footage' => 170,'lot_front_footage' => 171,'src_lot_front_footage' => 172,'tax_dt_lot_front_footage' => 173,'lot_number' => 174,'src_lot_number' => 175,'tax_dt_lot_number' => 176,'lot_size' => 177,'src_lot_size' => 178,'tax_dt_lot_size' => 179,'property_type_code' => 180,'src_property_type_code' => 181,'tax_dt_property_type_code' => 182,'structure_quality' => 183,'src_structure_quality' => 184,'tax_dt_structure_quality' => 185,'water' => 186,'src_water' => 187,'tax_dt_water' => 188,'sewer' => 189,'src_sewer' => 190,'tax_dt_sewer' => 191,'assessed_land_value' => 192,'src_assessed_land_value' => 193,'tax_dt_assessed_land_value' => 194,'assessed_year' => 195,'src_assessed_year' => 196,'tax_dt_assessed_year' => 197,'tax_amount' => 198,'src_tax_amount' => 199,'tax_dt_tax_amount' => 200,'tax_year' => 201,'src_tax_year' => 202,'market_land_value' => 203,'src_market_land_value' => 204,'tax_dt_market_land_value' => 205,'improvement_value' => 206,'src_improvement_value' => 207,'tax_dt_improvement_value' => 208,'percent_improved' => 209,'src_percent_improved' => 210,'tax_dt_percent_improved' => 211,'total_assessed_value' => 212,'src_total_assessed_value' => 213,'tax_dt_total_assessed_value' => 214,'total_calculated_value' => 215,'src_total_calculated_value' => 216,'tax_dt_total_calculated_value' => 217,'total_land_value' => 218,'src_total_land_value' => 219,'tax_dt_total_land_value' => 220,'total_market_value' => 221,'src_total_market_value' => 222,'tax_dt_total_market_value' => 223,'floor_type' => 224,'src_floor_type' => 225,'tax_dt_floor_type' => 226,'frame_type' => 227,'src_frame_type' => 228,'tax_dt_frame_type' => 229,'fuel_type' => 230,'src_fuel_type' => 231,'tax_dt_fuel_type' => 232,'no_of_bath_fixtures' => 233,'src_no_of_bath_fixtures' => 234,'tax_dt_no_of_bath_fixtures' => 235,'no_of_rooms' => 236,'src_no_of_rooms' => 237,'tax_dt_no_of_rooms' => 238,'no_of_units' => 239,'src_no_of_units' => 240,'tax_dt_no_of_units' => 241,'style_type' => 242,'src_style_type' => 243,'tax_dt_style_type' => 244,'assessment_document_number' => 245,'src_assessment_document_number' => 246,'tax_dt_assessment_document_number' => 247,'assessment_recording_date' => 248,'src_assessment_recording_date' => 249,'tax_dt_assessment_recording_date' => 250,'deed_document_number' => 251,'src_deed_document_number' => 252,'rec_dt_deed_document_number' => 253,'deed_recording_date' => 254,'src_deed_recording_date' => 255,'full_part_sale' => 256,'src_full_part_sale' => 257,'rec_dt_full_part_sale' => 258,'sale_amount' => 259,'src_sale_amount' => 260,'rec_dt_sale_amount' => 261,'sale_date' => 262,'src_sale_date' => 263,'rec_dt_sale_date' => 264,'sale_type_code' => 265,'src_sale_type_code' => 266,'rec_dt_sale_type_code' => 267,'mortgage_company_name' => 268,'src_mortgage_company_name' => 269,'rec_dt_mortgage_company_name' => 270,'loan_amount' => 271,'src_loan_amount' => 272,'rec_dt_loan_amount' => 273,'second_loan_amount' => 274,'src_second_loan_amount' => 275,'rec_dt_second_loan_amount' => 276,'loan_type_code' => 277,'src_loan_type_code' => 278,'rec_dt_loan_type_code' => 279,'interest_rate_type_code' => 280,'src_interest_rate_type_code' => 281,'rec_dt_interest_rate_type_code' => 282,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['ENUM'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW','LENGTHS'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW','LENGTHS'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW','WORDS'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW','LENGTHS','WITHIN_FILE'],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW','LENGTHS'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW','LENGTHS'],['ENUM','LENGTHS'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],[],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM','LENGTHS'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_property_rid(SALT311.StrType s0) := s0;
EXPORT InValid_property_rid(SALT311.StrType s) := 0;
EXPORT InValidMessage_property_rid(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_tax_sortby_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_sortby_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_sortby_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_deed_sortby_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_deed_sortby_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_deed_sortby_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_vendor_source(SALT311.StrType s0) := s0;
EXPORT InValid_vendor_source(SALT311.StrType s) := 0;
EXPORT InValidMessage_vendor_source(UNSIGNED1 wh) := '';
 
EXPORT Make_fares_unformatted_apn(SALT311.StrType s0) := MakeFT_invalid_apn(s0);
EXPORT InValid_fares_unformatted_apn(SALT311.StrType s) := InValidFT_invalid_apn(s);
EXPORT InValidMessage_fares_unformatted_apn(UNSIGNED1 wh) := InValidMessageFT_invalid_apn(wh);
 
EXPORT Make_property_street_address(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_property_street_address(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_property_street_address(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_property_city_state_zip(SALT311.StrType s0) := MakeFT_invalid_csz(s0);
EXPORT InValid_property_city_state_zip(SALT311.StrType s) := InValidFT_invalid_csz(s);
EXPORT InValidMessage_property_city_state_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_csz(wh);
 
EXPORT Make_property_raw_aid(SALT311.StrType s0) := s0;
EXPORT InValid_property_raw_aid(SALT311.StrType s) := 0;
EXPORT InValidMessage_property_raw_aid(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_prim_range(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_predir(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_predir(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_prim_name(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_prim_name(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_suffix(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_suffix(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_postdir(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_postdir(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_unit_desig(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_unit_desig(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_sec_range(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_sec_range(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_p_city_name(SALT311.StrType s0) := MakeFT_invalid_csz(s0);
EXPORT InValid_p_city_name(SALT311.StrType s) := InValidFT_invalid_csz(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_csz(wh);
 
EXPORT Make_v_city_name(SALT311.StrType s0) := MakeFT_invalid_csz(s0);
EXPORT InValid_v_city_name(SALT311.StrType s) := InValidFT_invalid_csz(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_csz(wh);
 
EXPORT Make_st(SALT311.StrType s0) := s0;
EXPORT InValid_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
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
 
EXPORT Make_dbpc(SALT311.StrType s0) := s0;
EXPORT InValid_dbpc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT311.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT311.StrType s) := 0;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type(SALT311.StrType s0) := s0;
EXPORT InValid_rec_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_county(SALT311.StrType s0) := s0;
EXPORT InValid_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_building_square_footage(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_building_square_footage(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_building_square_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_src_building_square_footage(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_building_square_footage(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_building_square_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_building_square_footage(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_building_square_footage(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_building_square_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_air_conditioning_type(SALT311.StrType s0) := MakeFT_invalid_air_conditioning_type_code(s0);
EXPORT InValid_air_conditioning_type(SALT311.StrType s) := InValidFT_invalid_air_conditioning_type_code(s);
EXPORT InValidMessage_air_conditioning_type(UNSIGNED1 wh) := InValidMessageFT_invalid_air_conditioning_type_code(wh);
 
EXPORT Make_src_air_conditioning_type(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_air_conditioning_type(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_air_conditioning_type(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_air_conditioning_type(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_air_conditioning_type(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_air_conditioning_type(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_basement_finish(SALT311.StrType s0) := MakeFT_invalid_basement_finish_type_code(s0);
EXPORT InValid_basement_finish(SALT311.StrType s) := InValidFT_invalid_basement_finish_type_code(s);
EXPORT InValidMessage_basement_finish(UNSIGNED1 wh) := InValidMessageFT_invalid_basement_finish_type_code(wh);
 
EXPORT Make_src_basement_finish(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_basement_finish(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_basement_finish(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_basement_finish(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_basement_finish(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_basement_finish(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_construction_type(SALT311.StrType s0) := MakeFT_invalid_construction_type_code(s0);
EXPORT InValid_construction_type(SALT311.StrType s) := InValidFT_invalid_construction_type_code(s);
EXPORT InValidMessage_construction_type(UNSIGNED1 wh) := InValidMessageFT_invalid_construction_type_code(wh);
 
EXPORT Make_src_construction_type(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_construction_type(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_construction_type(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_construction_type(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_construction_type(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_construction_type(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_exterior_wall(SALT311.StrType s0) := MakeFT_invalid_exterior_walls_code(s0);
EXPORT InValid_exterior_wall(SALT311.StrType s) := InValidFT_invalid_exterior_walls_code(s);
EXPORT InValidMessage_exterior_wall(UNSIGNED1 wh) := InValidMessageFT_invalid_exterior_walls_code(wh);
 
EXPORT Make_src_exterior_wall(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_exterior_wall(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_exterior_wall(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_exterior_wall(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_exterior_wall(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_exterior_wall(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_fireplace_ind(SALT311.StrType s0) := MakeFT_invalid_fireplace_indicator(s0);
EXPORT InValid_fireplace_ind(SALT311.StrType s) := InValidFT_invalid_fireplace_indicator(s);
EXPORT InValidMessage_fireplace_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_fireplace_indicator(wh);
 
EXPORT Make_src_fireplace_ind(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_fireplace_ind(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_fireplace_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_fireplace_ind(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_fireplace_ind(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_fireplace_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_fireplace_type(SALT311.StrType s0) := MakeFT_invalid_fireplace_type(s0);
EXPORT InValid_fireplace_type(SALT311.StrType s) := InValidFT_invalid_fireplace_type(s);
EXPORT InValidMessage_fireplace_type(UNSIGNED1 wh) := InValidMessageFT_invalid_fireplace_type(wh);
 
EXPORT Make_src_fireplace_type(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_fireplace_type(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_fireplace_type(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_fireplace_type(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_fireplace_type(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_fireplace_type(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_flood_zone_panel(SALT311.StrType s0) := s0;
EXPORT InValid_flood_zone_panel(SALT311.StrType s) := 0;
EXPORT InValidMessage_flood_zone_panel(UNSIGNED1 wh) := '';
 
EXPORT Make_src_flood_zone_panel(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_flood_zone_panel(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_flood_zone_panel(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_flood_zone_panel(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_flood_zone_panel(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_flood_zone_panel(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_garage(SALT311.StrType s0) := MakeFT_invalid_garage_type(s0);
EXPORT InValid_garage(SALT311.StrType s) := InValidFT_invalid_garage_type(s);
EXPORT InValidMessage_garage(UNSIGNED1 wh) := InValidMessageFT_invalid_garage_type(wh);
 
EXPORT Make_src_garage(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_garage(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_garage(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_garage(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_garage(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_garage(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_first_floor_square_footage(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_first_floor_square_footage(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_first_floor_square_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_src_first_floor_square_footage(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_first_floor_square_footage(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_first_floor_square_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_first_floor_square_footage(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_first_floor_square_footage(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_first_floor_square_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_heating(SALT311.StrType s0) := MakeFT_invalid_heating_type(s0);
EXPORT InValid_heating(SALT311.StrType s) := InValidFT_invalid_heating_type(s);
EXPORT InValidMessage_heating(UNSIGNED1 wh) := InValidMessageFT_invalid_heating_type(wh);
 
EXPORT Make_src_heating(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_heating(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_heating(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_heating(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_heating(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_heating(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_living_area_square_footage(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_living_area_square_footage(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_living_area_square_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_src_living_area_square_footage(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_living_area_square_footage(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_living_area_square_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_living_area_square_footage(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_living_area_square_footage(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_living_area_square_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_no_of_baths(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_no_of_baths(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_no_of_baths(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_src_no_of_baths(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_no_of_baths(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_no_of_baths(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_no_of_baths(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_no_of_baths(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_no_of_baths(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_no_of_bedrooms(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_no_of_bedrooms(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_no_of_bedrooms(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_src_no_of_bedrooms(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_no_of_bedrooms(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_no_of_bedrooms(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_no_of_bedrooms(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_no_of_bedrooms(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_no_of_bedrooms(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_no_of_fireplaces(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_no_of_fireplaces(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_no_of_fireplaces(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_src_no_of_fireplaces(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_no_of_fireplaces(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_no_of_fireplaces(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_no_of_fireplaces(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_no_of_fireplaces(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_no_of_fireplaces(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_no_of_full_baths(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_no_of_full_baths(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_no_of_full_baths(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_src_no_of_full_baths(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_no_of_full_baths(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_no_of_full_baths(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_no_of_full_baths(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_no_of_full_baths(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_no_of_full_baths(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_no_of_half_baths(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_no_of_half_baths(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_no_of_half_baths(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_src_no_of_half_baths(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_no_of_half_baths(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_no_of_half_baths(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_no_of_half_baths(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_no_of_half_baths(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_no_of_half_baths(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_no_of_stories(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_no_of_stories(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_no_of_stories(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_src_no_of_stories(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_no_of_stories(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_no_of_stories(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_no_of_stories(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_no_of_stories(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_no_of_stories(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_parking_type(SALT311.StrType s0) := MakeFT_invalid_parking_type(s0);
EXPORT InValid_parking_type(SALT311.StrType s) := InValidFT_invalid_parking_type(s);
EXPORT InValidMessage_parking_type(UNSIGNED1 wh) := InValidMessageFT_invalid_parking_type(wh);
 
EXPORT Make_src_parking_type(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_parking_type(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_parking_type(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_parking_type(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_parking_type(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_parking_type(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_pool_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_pool_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_pool_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_src_pool_indicator(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_pool_indicator(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_pool_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_pool_indicator(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_pool_indicator(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_pool_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_pool_type(SALT311.StrType s0) := MakeFT_invalid_pool_type(s0);
EXPORT InValid_pool_type(SALT311.StrType s) := InValidFT_invalid_pool_type(s);
EXPORT InValidMessage_pool_type(UNSIGNED1 wh) := InValidMessageFT_invalid_pool_type(wh);
 
EXPORT Make_src_pool_type(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_pool_type(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_pool_type(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_pool_type(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_pool_type(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_pool_type(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_roof_cover(SALT311.StrType s0) := MakeFT_invalid_roof_type(s0);
EXPORT InValid_roof_cover(SALT311.StrType s) := InValidFT_invalid_roof_type(s);
EXPORT InValidMessage_roof_cover(UNSIGNED1 wh) := InValidMessageFT_invalid_roof_type(wh);
 
EXPORT Make_src_roof_cover(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_roof_cover(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_roof_cover(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_roof_cover(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_roof_cover(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_roof_cover(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_year_built(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_year_built(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_year_built(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_src_year_built(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_year_built(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_year_built(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_year_built(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_year_built(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_year_built(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_foundation(SALT311.StrType s0) := MakeFT_invalid_foundation_type(s0);
EXPORT InValid_foundation(SALT311.StrType s) := InValidFT_invalid_foundation_type(s);
EXPORT InValidMessage_foundation(UNSIGNED1 wh) := InValidMessageFT_invalid_foundation_type(wh);
 
EXPORT Make_src_foundation(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_foundation(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_foundation(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_foundation(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_foundation(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_foundation(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_basement_square_footage(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_basement_square_footage(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_basement_square_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_src_basement_square_footage(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_basement_square_footage(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_basement_square_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_basement_square_footage(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_basement_square_footage(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_basement_square_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_effective_year_built(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_effective_year_built(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_effective_year_built(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_src_effective_year_built(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_effective_year_built(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_effective_year_built(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_effective_year_built(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_effective_year_built(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_effective_year_built(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_garage_square_footage(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_garage_square_footage(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_garage_square_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_src_garage_square_footage(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_garage_square_footage(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_garage_square_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_garage_square_footage(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_garage_square_footage(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_garage_square_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_stories_type(SALT311.StrType s0) := MakeFT_invalid_stories_type(s0);
EXPORT InValid_stories_type(SALT311.StrType s) := InValidFT_invalid_stories_type(s);
EXPORT InValidMessage_stories_type(UNSIGNED1 wh) := InValidMessageFT_invalid_stories_type(wh);
 
EXPORT Make_src_stories_type(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_stories_type(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_stories_type(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_stories_type(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_stories_type(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_stories_type(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_apn_number(SALT311.StrType s0) := MakeFT_invalid_apn(s0);
EXPORT InValid_apn_number(SALT311.StrType s) := InValidFT_invalid_apn(s);
EXPORT InValidMessage_apn_number(UNSIGNED1 wh) := InValidMessageFT_invalid_apn(wh);
 
EXPORT Make_src_apn_number(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_apn_number(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_apn_number(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_apn_number(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_apn_number(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_apn_number(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_census_tract(SALT311.StrType s0) := s0;
EXPORT InValid_census_tract(SALT311.StrType s) := 0;
EXPORT InValidMessage_census_tract(UNSIGNED1 wh) := '';
 
EXPORT Make_src_census_tract(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_census_tract(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_census_tract(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_census_tract(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_census_tract(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_census_tract(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_range(SALT311.StrType s0) := s0;
EXPORT InValid_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_range(UNSIGNED1 wh) := '';
 
EXPORT Make_src_range(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_range(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_range(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_range(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_range(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_range(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_zoning(SALT311.StrType s0) := s0;
EXPORT InValid_zoning(SALT311.StrType s) := 0;
EXPORT InValidMessage_zoning(UNSIGNED1 wh) := '';
 
EXPORT Make_src_zoning(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_zoning(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_zoning(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_zoning(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_zoning(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_zoning(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_block_number(SALT311.StrType s0) := s0;
EXPORT InValid_block_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_block_number(UNSIGNED1 wh) := '';
 
EXPORT Make_src_block_number(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_block_number(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_block_number(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_block_number(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_block_number(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_block_number(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_county_name(SALT311.StrType s0) := MakeFT_invalid_county_name(s0);
EXPORT InValid_county_name(SALT311.StrType s) := InValidFT_invalid_county_name(s);
EXPORT InValidMessage_county_name(UNSIGNED1 wh) := InValidMessageFT_invalid_county_name(wh);
 
EXPORT Make_src_county_name(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_county_name(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_county_name(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_county_name(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_county_name(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_county_name(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_fips_code(SALT311.StrType s0) := MakeFT_invalid_fips(s0);
EXPORT InValid_fips_code(SALT311.StrType s) := InValidFT_invalid_fips(s);
EXPORT InValidMessage_fips_code(UNSIGNED1 wh) := InValidMessageFT_invalid_fips(wh);
 
EXPORT Make_src_fips_code(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_fips_code(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_fips_code(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_fips_code(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_fips_code(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_fips_code(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_subdivision(SALT311.StrType s0) := s0;
EXPORT InValid_subdivision(SALT311.StrType s) := 0;
EXPORT InValidMessage_subdivision(UNSIGNED1 wh) := '';
 
EXPORT Make_src_subdivision(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_subdivision(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_subdivision(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_subdivision(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_subdivision(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_subdivision(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_municipality(SALT311.StrType s0) := s0;
EXPORT InValid_municipality(SALT311.StrType s) := 0;
EXPORT InValidMessage_municipality(UNSIGNED1 wh) := '';
 
EXPORT Make_src_municipality(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_municipality(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_municipality(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_municipality(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_municipality(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_municipality(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_township(SALT311.StrType s0) := s0;
EXPORT InValid_township(SALT311.StrType s) := 0;
EXPORT InValidMessage_township(UNSIGNED1 wh) := '';
 
EXPORT Make_src_township(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_township(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_township(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_township(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_township(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_township(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_homestead_exemption_ind(SALT311.StrType s0) := s0;
EXPORT InValid_homestead_exemption_ind(SALT311.StrType s) := 0;
EXPORT InValidMessage_homestead_exemption_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_src_homestead_exemption_ind(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_homestead_exemption_ind(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_homestead_exemption_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_homestead_exemption_ind(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_homestead_exemption_ind(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_homestead_exemption_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_land_use_code(SALT311.StrType s0) := MakeFT_invalid_land_use(s0);
EXPORT InValid_land_use_code(SALT311.StrType s) := InValidFT_invalid_land_use(s);
EXPORT InValidMessage_land_use_code(UNSIGNED1 wh) := InValidMessageFT_invalid_land_use(wh);
 
EXPORT Make_src_land_use_code(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_land_use_code(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_land_use_code(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_land_use_code(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_land_use_code(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_land_use_code(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_latitude(SALT311.StrType s0) := s0;
EXPORT InValid_latitude(SALT311.StrType s) := 0;
EXPORT InValidMessage_latitude(UNSIGNED1 wh) := '';
 
EXPORT Make_src_latitude(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_latitude(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_latitude(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_latitude(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_latitude(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_latitude(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_longitude(SALT311.StrType s0) := s0;
EXPORT InValid_longitude(SALT311.StrType s) := 0;
EXPORT InValidMessage_longitude(UNSIGNED1 wh) := '';
 
EXPORT Make_src_longitude(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_longitude(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_longitude(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_longitude(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_longitude(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_longitude(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_location_influence_code(SALT311.StrType s0) := MakeFT_invalid_location_code(s0);
EXPORT InValid_location_influence_code(SALT311.StrType s) := InValidFT_invalid_location_code(s);
EXPORT InValidMessage_location_influence_code(UNSIGNED1 wh) := InValidMessageFT_invalid_location_code(wh);
 
EXPORT Make_src_location_influence_code(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_location_influence_code(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_location_influence_code(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_location_influence_code(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_location_influence_code(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_location_influence_code(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_acres(SALT311.StrType s0) := s0;
EXPORT InValid_acres(SALT311.StrType s) := 0;
EXPORT InValidMessage_acres(UNSIGNED1 wh) := '';
 
EXPORT Make_src_acres(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_acres(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_acres(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_acres(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_acres(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_acres(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_lot_depth_footage(SALT311.StrType s0) := s0;
EXPORT InValid_lot_depth_footage(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot_depth_footage(UNSIGNED1 wh) := '';
 
EXPORT Make_src_lot_depth_footage(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_lot_depth_footage(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_lot_depth_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_lot_depth_footage(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_lot_depth_footage(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_lot_depth_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_lot_front_footage(SALT311.StrType s0) := s0;
EXPORT InValid_lot_front_footage(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot_front_footage(UNSIGNED1 wh) := '';
 
EXPORT Make_src_lot_front_footage(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_lot_front_footage(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_lot_front_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_lot_front_footage(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_lot_front_footage(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_lot_front_footage(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_lot_number(SALT311.StrType s0) := s0;
EXPORT InValid_lot_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot_number(UNSIGNED1 wh) := '';
 
EXPORT Make_src_lot_number(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_lot_number(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_lot_number(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_lot_number(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_lot_number(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_lot_number(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_lot_size(SALT311.StrType s0) := s0;
EXPORT InValid_lot_size(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot_size(UNSIGNED1 wh) := '';
 
EXPORT Make_src_lot_size(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_lot_size(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_lot_size(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_lot_size(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_lot_size(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_lot_size(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_property_type_code(SALT311.StrType s0) := MakeFT_invalid_property_code(s0);
EXPORT InValid_property_type_code(SALT311.StrType s) := InValidFT_invalid_property_code(s);
EXPORT InValidMessage_property_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_property_code(wh);
 
EXPORT Make_src_property_type_code(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_property_type_code(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_property_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_property_type_code(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_property_type_code(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_property_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_structure_quality(SALT311.StrType s0) := MakeFT_invalid_structure_quality_code(s0);
EXPORT InValid_structure_quality(SALT311.StrType s) := InValidFT_invalid_structure_quality_code(s);
EXPORT InValidMessage_structure_quality(UNSIGNED1 wh) := InValidMessageFT_invalid_structure_quality_code(wh);
 
EXPORT Make_src_structure_quality(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_structure_quality(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_structure_quality(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_structure_quality(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_structure_quality(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_structure_quality(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_water(SALT311.StrType s0) := MakeFT_invalid_water_type(s0);
EXPORT InValid_water(SALT311.StrType s) := InValidFT_invalid_water_type(s);
EXPORT InValidMessage_water(UNSIGNED1 wh) := InValidMessageFT_invalid_water_type(wh);
 
EXPORT Make_src_water(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_water(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_water(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_water(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_water(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_water(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_sewer(SALT311.StrType s0) := MakeFT_invalid_sewer_type(s0);
EXPORT InValid_sewer(SALT311.StrType s) := InValidFT_invalid_sewer_type(s);
EXPORT InValidMessage_sewer(UNSIGNED1 wh) := InValidMessageFT_invalid_sewer_type(wh);
 
EXPORT Make_src_sewer(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_sewer(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_sewer(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_sewer(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_sewer(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_sewer(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_assessed_land_value(SALT311.StrType s0) := MakeFT_invalid_tax_amount(s0);
EXPORT InValid_assessed_land_value(SALT311.StrType s) := InValidFT_invalid_tax_amount(s);
EXPORT InValidMessage_assessed_land_value(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_amount(wh);
 
EXPORT Make_src_assessed_land_value(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_assessed_land_value(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_assessed_land_value(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_assessed_land_value(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_assessed_land_value(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_assessed_land_value(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_assessed_year(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_assessed_year(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_assessed_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_src_assessed_year(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_assessed_year(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_assessed_year(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_assessed_year(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_assessed_year(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_assessed_year(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_tax_amount(SALT311.StrType s0) := MakeFT_invalid_tax_amount(s0);
EXPORT InValid_tax_amount(SALT311.StrType s) := InValidFT_invalid_tax_amount(s);
EXPORT InValidMessage_tax_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_amount(wh);
 
EXPORT Make_src_tax_amount(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_tax_amount(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_tax_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_tax_amount(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_tax_amount(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_tax_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_tax_year(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_tax_year(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_tax_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_src_tax_year(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_tax_year(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_tax_year(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_market_land_value(SALT311.StrType s0) := MakeFT_invalid_tax_amount(s0);
EXPORT InValid_market_land_value(SALT311.StrType s) := InValidFT_invalid_tax_amount(s);
EXPORT InValidMessage_market_land_value(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_amount(wh);
 
EXPORT Make_src_market_land_value(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_market_land_value(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_market_land_value(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_market_land_value(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_market_land_value(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_market_land_value(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_improvement_value(SALT311.StrType s0) := MakeFT_invalid_tax_amount(s0);
EXPORT InValid_improvement_value(SALT311.StrType s) := InValidFT_invalid_tax_amount(s);
EXPORT InValidMessage_improvement_value(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_amount(wh);
 
EXPORT Make_src_improvement_value(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_improvement_value(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_improvement_value(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_improvement_value(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_improvement_value(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_improvement_value(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_percent_improved(SALT311.StrType s0) := s0;
EXPORT InValid_percent_improved(SALT311.StrType s) := 0;
EXPORT InValidMessage_percent_improved(UNSIGNED1 wh) := '';
 
EXPORT Make_src_percent_improved(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_percent_improved(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_percent_improved(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_percent_improved(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_percent_improved(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_percent_improved(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_total_assessed_value(SALT311.StrType s0) := MakeFT_invalid_tax_amount(s0);
EXPORT InValid_total_assessed_value(SALT311.StrType s) := InValidFT_invalid_tax_amount(s);
EXPORT InValidMessage_total_assessed_value(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_amount(wh);
 
EXPORT Make_src_total_assessed_value(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_total_assessed_value(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_total_assessed_value(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_total_assessed_value(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_total_assessed_value(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_total_assessed_value(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_total_calculated_value(SALT311.StrType s0) := MakeFT_invalid_tax_amount(s0);
EXPORT InValid_total_calculated_value(SALT311.StrType s) := InValidFT_invalid_tax_amount(s);
EXPORT InValidMessage_total_calculated_value(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_amount(wh);
 
EXPORT Make_src_total_calculated_value(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_total_calculated_value(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_total_calculated_value(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_total_calculated_value(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_total_calculated_value(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_total_calculated_value(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_total_land_value(SALT311.StrType s0) := MakeFT_invalid_tax_amount(s0);
EXPORT InValid_total_land_value(SALT311.StrType s) := InValidFT_invalid_tax_amount(s);
EXPORT InValidMessage_total_land_value(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_amount(wh);
 
EXPORT Make_src_total_land_value(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_total_land_value(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_total_land_value(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_total_land_value(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_total_land_value(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_total_land_value(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_total_market_value(SALT311.StrType s0) := MakeFT_invalid_tax_amount(s0);
EXPORT InValid_total_market_value(SALT311.StrType s) := InValidFT_invalid_tax_amount(s);
EXPORT InValidMessage_total_market_value(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_amount(wh);
 
EXPORT Make_src_total_market_value(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_total_market_value(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_total_market_value(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_total_market_value(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_total_market_value(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_total_market_value(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_floor_type(SALT311.StrType s0) := MakeFT_invalid_floor_cover_code(s0);
EXPORT InValid_floor_type(SALT311.StrType s) := InValidFT_invalid_floor_cover_code(s);
EXPORT InValidMessage_floor_type(UNSIGNED1 wh) := InValidMessageFT_invalid_floor_cover_code(wh);
 
EXPORT Make_src_floor_type(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_floor_type(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_floor_type(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_floor_type(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_floor_type(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_floor_type(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_frame_type(SALT311.StrType s0) := MakeFT_invalid_frame_code(s0);
EXPORT InValid_frame_type(SALT311.StrType s) := InValidFT_invalid_frame_code(s);
EXPORT InValidMessage_frame_type(UNSIGNED1 wh) := InValidMessageFT_invalid_frame_code(wh);
 
EXPORT Make_src_frame_type(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_frame_type(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_frame_type(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_frame_type(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_frame_type(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_frame_type(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_fuel_type(SALT311.StrType s0) := MakeFT_invalid_heating_fuel_type(s0);
EXPORT InValid_fuel_type(SALT311.StrType s) := InValidFT_invalid_heating_fuel_type(s);
EXPORT InValidMessage_fuel_type(UNSIGNED1 wh) := InValidMessageFT_invalid_heating_fuel_type(wh);
 
EXPORT Make_src_fuel_type(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_fuel_type(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_fuel_type(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_fuel_type(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_fuel_type(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_fuel_type(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_no_of_bath_fixtures(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_no_of_bath_fixtures(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_no_of_bath_fixtures(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_src_no_of_bath_fixtures(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_no_of_bath_fixtures(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_no_of_bath_fixtures(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_no_of_bath_fixtures(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_no_of_bath_fixtures(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_no_of_bath_fixtures(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_no_of_rooms(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_no_of_rooms(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_no_of_rooms(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_src_no_of_rooms(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_no_of_rooms(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_no_of_rooms(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_no_of_rooms(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_no_of_rooms(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_no_of_rooms(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_no_of_units(SALT311.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_no_of_units(SALT311.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_no_of_units(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_src_no_of_units(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_no_of_units(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_no_of_units(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_no_of_units(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_no_of_units(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_no_of_units(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_style_type(SALT311.StrType s0) := MakeFT_invalid_style_type(s0);
EXPORT InValid_style_type(SALT311.StrType s) := InValidFT_invalid_style_type(s);
EXPORT InValidMessage_style_type(UNSIGNED1 wh) := InValidMessageFT_invalid_style_type(wh);
 
EXPORT Make_src_style_type(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_style_type(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_style_type(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_style_type(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_style_type(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_style_type(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_assessment_document_number(SALT311.StrType s0) := MakeFT_invalid_document_number(s0);
EXPORT InValid_assessment_document_number(SALT311.StrType s) := InValidFT_invalid_document_number(s);
EXPORT InValidMessage_assessment_document_number(UNSIGNED1 wh) := InValidMessageFT_invalid_document_number(wh);
 
EXPORT Make_src_assessment_document_number(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_assessment_document_number(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_assessment_document_number(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_assessment_document_number(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_assessment_document_number(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_assessment_document_number(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_assessment_recording_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_assessment_recording_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_assessment_recording_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_src_assessment_recording_date(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_assessment_recording_date(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_assessment_recording_date(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_tax_dt_assessment_recording_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_tax_dt_assessment_recording_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_tax_dt_assessment_recording_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_deed_document_number(SALT311.StrType s0) := MakeFT_invalid_document_number(s0);
EXPORT InValid_deed_document_number(SALT311.StrType s) := InValidFT_invalid_document_number(s);
EXPORT InValidMessage_deed_document_number(UNSIGNED1 wh) := InValidMessageFT_invalid_document_number(wh);
 
EXPORT Make_src_deed_document_number(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_deed_document_number(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_deed_document_number(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_rec_dt_deed_document_number(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_rec_dt_deed_document_number(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_rec_dt_deed_document_number(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_deed_recording_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_deed_recording_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_deed_recording_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_src_deed_recording_date(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_deed_recording_date(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_deed_recording_date(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_full_part_sale(SALT311.StrType s0) := MakeFT_invalid_sale_code(s0);
EXPORT InValid_full_part_sale(SALT311.StrType s) := InValidFT_invalid_sale_code(s);
EXPORT InValidMessage_full_part_sale(UNSIGNED1 wh) := InValidMessageFT_invalid_sale_code(wh);
 
EXPORT Make_src_full_part_sale(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_full_part_sale(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_full_part_sale(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_rec_dt_full_part_sale(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_rec_dt_full_part_sale(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_rec_dt_full_part_sale(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_sale_amount(SALT311.StrType s0) := MakeFT_invalid_tax_amount(s0);
EXPORT InValid_sale_amount(SALT311.StrType s) := InValidFT_invalid_tax_amount(s);
EXPORT InValidMessage_sale_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_amount(wh);
 
EXPORT Make_src_sale_amount(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_sale_amount(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_sale_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_rec_dt_sale_amount(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_rec_dt_sale_amount(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_rec_dt_sale_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_sale_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_sale_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_sale_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_src_sale_date(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_sale_date(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_sale_date(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_rec_dt_sale_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_rec_dt_sale_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_rec_dt_sale_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_sale_type_code(SALT311.StrType s0) := MakeFT_invalid_sale_tran_code(s0);
EXPORT InValid_sale_type_code(SALT311.StrType s) := InValidFT_invalid_sale_tran_code(s);
EXPORT InValidMessage_sale_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sale_tran_code(wh);
 
EXPORT Make_src_sale_type_code(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_sale_type_code(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_sale_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_rec_dt_sale_type_code(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_rec_dt_sale_type_code(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_rec_dt_sale_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_mortgage_company_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_mortgage_company_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_mortgage_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_src_mortgage_company_name(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_mortgage_company_name(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_mortgage_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_rec_dt_mortgage_company_name(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_rec_dt_mortgage_company_name(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_rec_dt_mortgage_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_loan_amount(SALT311.StrType s0) := MakeFT_invalid_tax_amount(s0);
EXPORT InValid_loan_amount(SALT311.StrType s) := InValidFT_invalid_tax_amount(s);
EXPORT InValidMessage_loan_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_amount(wh);
 
EXPORT Make_src_loan_amount(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_loan_amount(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_loan_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_rec_dt_loan_amount(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_rec_dt_loan_amount(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_rec_dt_loan_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_second_loan_amount(SALT311.StrType s0) := MakeFT_invalid_tax_amount(s0);
EXPORT InValid_second_loan_amount(SALT311.StrType s) := InValidFT_invalid_tax_amount(s);
EXPORT InValidMessage_second_loan_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_amount(wh);
 
EXPORT Make_src_second_loan_amount(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_second_loan_amount(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_second_loan_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_rec_dt_second_loan_amount(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_rec_dt_second_loan_amount(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_rec_dt_second_loan_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_loan_type_code(SALT311.StrType s0) := MakeFT_invalid_mortgage_loan_type_code(s0);
EXPORT InValid_loan_type_code(SALT311.StrType s) := InValidFT_invalid_mortgage_loan_type_code(s);
EXPORT InValidMessage_loan_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_mortgage_loan_type_code(wh);
 
EXPORT Make_src_loan_type_code(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_loan_type_code(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_loan_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_rec_dt_loan_type_code(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_rec_dt_loan_type_code(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_rec_dt_loan_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_interest_rate_type_code(SALT311.StrType s0) := MakeFT_invalid_financing_type_code(s0);
EXPORT InValid_interest_rate_type_code(SALT311.StrType s) := InValidFT_invalid_financing_type_code(s);
EXPORT InValidMessage_interest_rate_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_financing_type_code(wh);
 
EXPORT Make_src_interest_rate_type_code(SALT311.StrType s0) := MakeFT_invalid_vendor_source(s0);
EXPORT InValid_src_interest_rate_type_code(SALT311.StrType s) := InValidFT_invalid_vendor_source(s);
EXPORT InValidMessage_src_interest_rate_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor_source(wh);
 
EXPORT Make_rec_dt_interest_rate_type_code(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_rec_dt_interest_rate_type_code(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_rec_dt_interest_rate_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Property_Characteristics;
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
    BOOLEAN Diff_property_rid;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_tax_sortby_date;
    BOOLEAN Diff_deed_sortby_date;
    BOOLEAN Diff_vendor_source;
    BOOLEAN Diff_fares_unformatted_apn;
    BOOLEAN Diff_property_street_address;
    BOOLEAN Diff_property_city_state_zip;
    BOOLEAN Diff_property_raw_aid;
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
    BOOLEAN Diff_dbpc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_building_square_footage;
    BOOLEAN Diff_src_building_square_footage;
    BOOLEAN Diff_tax_dt_building_square_footage;
    BOOLEAN Diff_air_conditioning_type;
    BOOLEAN Diff_src_air_conditioning_type;
    BOOLEAN Diff_tax_dt_air_conditioning_type;
    BOOLEAN Diff_basement_finish;
    BOOLEAN Diff_src_basement_finish;
    BOOLEAN Diff_tax_dt_basement_finish;
    BOOLEAN Diff_construction_type;
    BOOLEAN Diff_src_construction_type;
    BOOLEAN Diff_tax_dt_construction_type;
    BOOLEAN Diff_exterior_wall;
    BOOLEAN Diff_src_exterior_wall;
    BOOLEAN Diff_tax_dt_exterior_wall;
    BOOLEAN Diff_fireplace_ind;
    BOOLEAN Diff_src_fireplace_ind;
    BOOLEAN Diff_tax_dt_fireplace_ind;
    BOOLEAN Diff_fireplace_type;
    BOOLEAN Diff_src_fireplace_type;
    BOOLEAN Diff_tax_dt_fireplace_type;
    BOOLEAN Diff_flood_zone_panel;
    BOOLEAN Diff_src_flood_zone_panel;
    BOOLEAN Diff_tax_dt_flood_zone_panel;
    BOOLEAN Diff_garage;
    BOOLEAN Diff_src_garage;
    BOOLEAN Diff_tax_dt_garage;
    BOOLEAN Diff_first_floor_square_footage;
    BOOLEAN Diff_src_first_floor_square_footage;
    BOOLEAN Diff_tax_dt_first_floor_square_footage;
    BOOLEAN Diff_heating;
    BOOLEAN Diff_src_heating;
    BOOLEAN Diff_tax_dt_heating;
    BOOLEAN Diff_living_area_square_footage;
    BOOLEAN Diff_src_living_area_square_footage;
    BOOLEAN Diff_tax_dt_living_area_square_footage;
    BOOLEAN Diff_no_of_baths;
    BOOLEAN Diff_src_no_of_baths;
    BOOLEAN Diff_tax_dt_no_of_baths;
    BOOLEAN Diff_no_of_bedrooms;
    BOOLEAN Diff_src_no_of_bedrooms;
    BOOLEAN Diff_tax_dt_no_of_bedrooms;
    BOOLEAN Diff_no_of_fireplaces;
    BOOLEAN Diff_src_no_of_fireplaces;
    BOOLEAN Diff_tax_dt_no_of_fireplaces;
    BOOLEAN Diff_no_of_full_baths;
    BOOLEAN Diff_src_no_of_full_baths;
    BOOLEAN Diff_tax_dt_no_of_full_baths;
    BOOLEAN Diff_no_of_half_baths;
    BOOLEAN Diff_src_no_of_half_baths;
    BOOLEAN Diff_tax_dt_no_of_half_baths;
    BOOLEAN Diff_no_of_stories;
    BOOLEAN Diff_src_no_of_stories;
    BOOLEAN Diff_tax_dt_no_of_stories;
    BOOLEAN Diff_parking_type;
    BOOLEAN Diff_src_parking_type;
    BOOLEAN Diff_tax_dt_parking_type;
    BOOLEAN Diff_pool_indicator;
    BOOLEAN Diff_src_pool_indicator;
    BOOLEAN Diff_tax_dt_pool_indicator;
    BOOLEAN Diff_pool_type;
    BOOLEAN Diff_src_pool_type;
    BOOLEAN Diff_tax_dt_pool_type;
    BOOLEAN Diff_roof_cover;
    BOOLEAN Diff_src_roof_cover;
    BOOLEAN Diff_tax_dt_roof_cover;
    BOOLEAN Diff_year_built;
    BOOLEAN Diff_src_year_built;
    BOOLEAN Diff_tax_dt_year_built;
    BOOLEAN Diff_foundation;
    BOOLEAN Diff_src_foundation;
    BOOLEAN Diff_tax_dt_foundation;
    BOOLEAN Diff_basement_square_footage;
    BOOLEAN Diff_src_basement_square_footage;
    BOOLEAN Diff_tax_dt_basement_square_footage;
    BOOLEAN Diff_effective_year_built;
    BOOLEAN Diff_src_effective_year_built;
    BOOLEAN Diff_tax_dt_effective_year_built;
    BOOLEAN Diff_garage_square_footage;
    BOOLEAN Diff_src_garage_square_footage;
    BOOLEAN Diff_tax_dt_garage_square_footage;
    BOOLEAN Diff_stories_type;
    BOOLEAN Diff_src_stories_type;
    BOOLEAN Diff_tax_dt_stories_type;
    BOOLEAN Diff_apn_number;
    BOOLEAN Diff_src_apn_number;
    BOOLEAN Diff_tax_dt_apn_number;
    BOOLEAN Diff_census_tract;
    BOOLEAN Diff_src_census_tract;
    BOOLEAN Diff_tax_dt_census_tract;
    BOOLEAN Diff_range;
    BOOLEAN Diff_src_range;
    BOOLEAN Diff_tax_dt_range;
    BOOLEAN Diff_zoning;
    BOOLEAN Diff_src_zoning;
    BOOLEAN Diff_tax_dt_zoning;
    BOOLEAN Diff_block_number;
    BOOLEAN Diff_src_block_number;
    BOOLEAN Diff_tax_dt_block_number;
    BOOLEAN Diff_county_name;
    BOOLEAN Diff_src_county_name;
    BOOLEAN Diff_tax_dt_county_name;
    BOOLEAN Diff_fips_code;
    BOOLEAN Diff_src_fips_code;
    BOOLEAN Diff_tax_dt_fips_code;
    BOOLEAN Diff_subdivision;
    BOOLEAN Diff_src_subdivision;
    BOOLEAN Diff_tax_dt_subdivision;
    BOOLEAN Diff_municipality;
    BOOLEAN Diff_src_municipality;
    BOOLEAN Diff_tax_dt_municipality;
    BOOLEAN Diff_township;
    BOOLEAN Diff_src_township;
    BOOLEAN Diff_tax_dt_township;
    BOOLEAN Diff_homestead_exemption_ind;
    BOOLEAN Diff_src_homestead_exemption_ind;
    BOOLEAN Diff_tax_dt_homestead_exemption_ind;
    BOOLEAN Diff_land_use_code;
    BOOLEAN Diff_src_land_use_code;
    BOOLEAN Diff_tax_dt_land_use_code;
    BOOLEAN Diff_latitude;
    BOOLEAN Diff_src_latitude;
    BOOLEAN Diff_tax_dt_latitude;
    BOOLEAN Diff_longitude;
    BOOLEAN Diff_src_longitude;
    BOOLEAN Diff_tax_dt_longitude;
    BOOLEAN Diff_location_influence_code;
    BOOLEAN Diff_src_location_influence_code;
    BOOLEAN Diff_tax_dt_location_influence_code;
    BOOLEAN Diff_acres;
    BOOLEAN Diff_src_acres;
    BOOLEAN Diff_tax_dt_acres;
    BOOLEAN Diff_lot_depth_footage;
    BOOLEAN Diff_src_lot_depth_footage;
    BOOLEAN Diff_tax_dt_lot_depth_footage;
    BOOLEAN Diff_lot_front_footage;
    BOOLEAN Diff_src_lot_front_footage;
    BOOLEAN Diff_tax_dt_lot_front_footage;
    BOOLEAN Diff_lot_number;
    BOOLEAN Diff_src_lot_number;
    BOOLEAN Diff_tax_dt_lot_number;
    BOOLEAN Diff_lot_size;
    BOOLEAN Diff_src_lot_size;
    BOOLEAN Diff_tax_dt_lot_size;
    BOOLEAN Diff_property_type_code;
    BOOLEAN Diff_src_property_type_code;
    BOOLEAN Diff_tax_dt_property_type_code;
    BOOLEAN Diff_structure_quality;
    BOOLEAN Diff_src_structure_quality;
    BOOLEAN Diff_tax_dt_structure_quality;
    BOOLEAN Diff_water;
    BOOLEAN Diff_src_water;
    BOOLEAN Diff_tax_dt_water;
    BOOLEAN Diff_sewer;
    BOOLEAN Diff_src_sewer;
    BOOLEAN Diff_tax_dt_sewer;
    BOOLEAN Diff_assessed_land_value;
    BOOLEAN Diff_src_assessed_land_value;
    BOOLEAN Diff_tax_dt_assessed_land_value;
    BOOLEAN Diff_assessed_year;
    BOOLEAN Diff_src_assessed_year;
    BOOLEAN Diff_tax_dt_assessed_year;
    BOOLEAN Diff_tax_amount;
    BOOLEAN Diff_src_tax_amount;
    BOOLEAN Diff_tax_dt_tax_amount;
    BOOLEAN Diff_tax_year;
    BOOLEAN Diff_src_tax_year;
    BOOLEAN Diff_market_land_value;
    BOOLEAN Diff_src_market_land_value;
    BOOLEAN Diff_tax_dt_market_land_value;
    BOOLEAN Diff_improvement_value;
    BOOLEAN Diff_src_improvement_value;
    BOOLEAN Diff_tax_dt_improvement_value;
    BOOLEAN Diff_percent_improved;
    BOOLEAN Diff_src_percent_improved;
    BOOLEAN Diff_tax_dt_percent_improved;
    BOOLEAN Diff_total_assessed_value;
    BOOLEAN Diff_src_total_assessed_value;
    BOOLEAN Diff_tax_dt_total_assessed_value;
    BOOLEAN Diff_total_calculated_value;
    BOOLEAN Diff_src_total_calculated_value;
    BOOLEAN Diff_tax_dt_total_calculated_value;
    BOOLEAN Diff_total_land_value;
    BOOLEAN Diff_src_total_land_value;
    BOOLEAN Diff_tax_dt_total_land_value;
    BOOLEAN Diff_total_market_value;
    BOOLEAN Diff_src_total_market_value;
    BOOLEAN Diff_tax_dt_total_market_value;
    BOOLEAN Diff_floor_type;
    BOOLEAN Diff_src_floor_type;
    BOOLEAN Diff_tax_dt_floor_type;
    BOOLEAN Diff_frame_type;
    BOOLEAN Diff_src_frame_type;
    BOOLEAN Diff_tax_dt_frame_type;
    BOOLEAN Diff_fuel_type;
    BOOLEAN Diff_src_fuel_type;
    BOOLEAN Diff_tax_dt_fuel_type;
    BOOLEAN Diff_no_of_bath_fixtures;
    BOOLEAN Diff_src_no_of_bath_fixtures;
    BOOLEAN Diff_tax_dt_no_of_bath_fixtures;
    BOOLEAN Diff_no_of_rooms;
    BOOLEAN Diff_src_no_of_rooms;
    BOOLEAN Diff_tax_dt_no_of_rooms;
    BOOLEAN Diff_no_of_units;
    BOOLEAN Diff_src_no_of_units;
    BOOLEAN Diff_tax_dt_no_of_units;
    BOOLEAN Diff_style_type;
    BOOLEAN Diff_src_style_type;
    BOOLEAN Diff_tax_dt_style_type;
    BOOLEAN Diff_assessment_document_number;
    BOOLEAN Diff_src_assessment_document_number;
    BOOLEAN Diff_tax_dt_assessment_document_number;
    BOOLEAN Diff_assessment_recording_date;
    BOOLEAN Diff_src_assessment_recording_date;
    BOOLEAN Diff_tax_dt_assessment_recording_date;
    BOOLEAN Diff_deed_document_number;
    BOOLEAN Diff_src_deed_document_number;
    BOOLEAN Diff_rec_dt_deed_document_number;
    BOOLEAN Diff_deed_recording_date;
    BOOLEAN Diff_src_deed_recording_date;
    BOOLEAN Diff_full_part_sale;
    BOOLEAN Diff_src_full_part_sale;
    BOOLEAN Diff_rec_dt_full_part_sale;
    BOOLEAN Diff_sale_amount;
    BOOLEAN Diff_src_sale_amount;
    BOOLEAN Diff_rec_dt_sale_amount;
    BOOLEAN Diff_sale_date;
    BOOLEAN Diff_src_sale_date;
    BOOLEAN Diff_rec_dt_sale_date;
    BOOLEAN Diff_sale_type_code;
    BOOLEAN Diff_src_sale_type_code;
    BOOLEAN Diff_rec_dt_sale_type_code;
    BOOLEAN Diff_mortgage_company_name;
    BOOLEAN Diff_src_mortgage_company_name;
    BOOLEAN Diff_rec_dt_mortgage_company_name;
    BOOLEAN Diff_loan_amount;
    BOOLEAN Diff_src_loan_amount;
    BOOLEAN Diff_rec_dt_loan_amount;
    BOOLEAN Diff_second_loan_amount;
    BOOLEAN Diff_src_second_loan_amount;
    BOOLEAN Diff_rec_dt_second_loan_amount;
    BOOLEAN Diff_loan_type_code;
    BOOLEAN Diff_src_loan_type_code;
    BOOLEAN Diff_rec_dt_loan_type_code;
    BOOLEAN Diff_interest_rate_type_code;
    BOOLEAN Diff_src_interest_rate_type_code;
    BOOLEAN Diff_rec_dt_interest_rate_type_code;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_property_rid := le.property_rid <> ri.property_rid;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_tax_sortby_date := le.tax_sortby_date <> ri.tax_sortby_date;
    SELF.Diff_deed_sortby_date := le.deed_sortby_date <> ri.deed_sortby_date;
    SELF.Diff_vendor_source := le.vendor_source <> ri.vendor_source;
    SELF.Diff_fares_unformatted_apn := le.fares_unformatted_apn <> ri.fares_unformatted_apn;
    SELF.Diff_property_street_address := le.property_street_address <> ri.property_street_address;
    SELF.Diff_property_city_state_zip := le.property_city_state_zip <> ri.property_city_state_zip;
    SELF.Diff_property_raw_aid := le.property_raw_aid <> ri.property_raw_aid;
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
    SELF.Diff_dbpc := le.dbpc <> ri.dbpc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_building_square_footage := le.building_square_footage <> ri.building_square_footage;
    SELF.Diff_src_building_square_footage := le.src_building_square_footage <> ri.src_building_square_footage;
    SELF.Diff_tax_dt_building_square_footage := le.tax_dt_building_square_footage <> ri.tax_dt_building_square_footage;
    SELF.Diff_air_conditioning_type := le.air_conditioning_type <> ri.air_conditioning_type;
    SELF.Diff_src_air_conditioning_type := le.src_air_conditioning_type <> ri.src_air_conditioning_type;
    SELF.Diff_tax_dt_air_conditioning_type := le.tax_dt_air_conditioning_type <> ri.tax_dt_air_conditioning_type;
    SELF.Diff_basement_finish := le.basement_finish <> ri.basement_finish;
    SELF.Diff_src_basement_finish := le.src_basement_finish <> ri.src_basement_finish;
    SELF.Diff_tax_dt_basement_finish := le.tax_dt_basement_finish <> ri.tax_dt_basement_finish;
    SELF.Diff_construction_type := le.construction_type <> ri.construction_type;
    SELF.Diff_src_construction_type := le.src_construction_type <> ri.src_construction_type;
    SELF.Diff_tax_dt_construction_type := le.tax_dt_construction_type <> ri.tax_dt_construction_type;
    SELF.Diff_exterior_wall := le.exterior_wall <> ri.exterior_wall;
    SELF.Diff_src_exterior_wall := le.src_exterior_wall <> ri.src_exterior_wall;
    SELF.Diff_tax_dt_exterior_wall := le.tax_dt_exterior_wall <> ri.tax_dt_exterior_wall;
    SELF.Diff_fireplace_ind := le.fireplace_ind <> ri.fireplace_ind;
    SELF.Diff_src_fireplace_ind := le.src_fireplace_ind <> ri.src_fireplace_ind;
    SELF.Diff_tax_dt_fireplace_ind := le.tax_dt_fireplace_ind <> ri.tax_dt_fireplace_ind;
    SELF.Diff_fireplace_type := le.fireplace_type <> ri.fireplace_type;
    SELF.Diff_src_fireplace_type := le.src_fireplace_type <> ri.src_fireplace_type;
    SELF.Diff_tax_dt_fireplace_type := le.tax_dt_fireplace_type <> ri.tax_dt_fireplace_type;
    SELF.Diff_flood_zone_panel := le.flood_zone_panel <> ri.flood_zone_panel;
    SELF.Diff_src_flood_zone_panel := le.src_flood_zone_panel <> ri.src_flood_zone_panel;
    SELF.Diff_tax_dt_flood_zone_panel := le.tax_dt_flood_zone_panel <> ri.tax_dt_flood_zone_panel;
    SELF.Diff_garage := le.garage <> ri.garage;
    SELF.Diff_src_garage := le.src_garage <> ri.src_garage;
    SELF.Diff_tax_dt_garage := le.tax_dt_garage <> ri.tax_dt_garage;
    SELF.Diff_first_floor_square_footage := le.first_floor_square_footage <> ri.first_floor_square_footage;
    SELF.Diff_src_first_floor_square_footage := le.src_first_floor_square_footage <> ri.src_first_floor_square_footage;
    SELF.Diff_tax_dt_first_floor_square_footage := le.tax_dt_first_floor_square_footage <> ri.tax_dt_first_floor_square_footage;
    SELF.Diff_heating := le.heating <> ri.heating;
    SELF.Diff_src_heating := le.src_heating <> ri.src_heating;
    SELF.Diff_tax_dt_heating := le.tax_dt_heating <> ri.tax_dt_heating;
    SELF.Diff_living_area_square_footage := le.living_area_square_footage <> ri.living_area_square_footage;
    SELF.Diff_src_living_area_square_footage := le.src_living_area_square_footage <> ri.src_living_area_square_footage;
    SELF.Diff_tax_dt_living_area_square_footage := le.tax_dt_living_area_square_footage <> ri.tax_dt_living_area_square_footage;
    SELF.Diff_no_of_baths := le.no_of_baths <> ri.no_of_baths;
    SELF.Diff_src_no_of_baths := le.src_no_of_baths <> ri.src_no_of_baths;
    SELF.Diff_tax_dt_no_of_baths := le.tax_dt_no_of_baths <> ri.tax_dt_no_of_baths;
    SELF.Diff_no_of_bedrooms := le.no_of_bedrooms <> ri.no_of_bedrooms;
    SELF.Diff_src_no_of_bedrooms := le.src_no_of_bedrooms <> ri.src_no_of_bedrooms;
    SELF.Diff_tax_dt_no_of_bedrooms := le.tax_dt_no_of_bedrooms <> ri.tax_dt_no_of_bedrooms;
    SELF.Diff_no_of_fireplaces := le.no_of_fireplaces <> ri.no_of_fireplaces;
    SELF.Diff_src_no_of_fireplaces := le.src_no_of_fireplaces <> ri.src_no_of_fireplaces;
    SELF.Diff_tax_dt_no_of_fireplaces := le.tax_dt_no_of_fireplaces <> ri.tax_dt_no_of_fireplaces;
    SELF.Diff_no_of_full_baths := le.no_of_full_baths <> ri.no_of_full_baths;
    SELF.Diff_src_no_of_full_baths := le.src_no_of_full_baths <> ri.src_no_of_full_baths;
    SELF.Diff_tax_dt_no_of_full_baths := le.tax_dt_no_of_full_baths <> ri.tax_dt_no_of_full_baths;
    SELF.Diff_no_of_half_baths := le.no_of_half_baths <> ri.no_of_half_baths;
    SELF.Diff_src_no_of_half_baths := le.src_no_of_half_baths <> ri.src_no_of_half_baths;
    SELF.Diff_tax_dt_no_of_half_baths := le.tax_dt_no_of_half_baths <> ri.tax_dt_no_of_half_baths;
    SELF.Diff_no_of_stories := le.no_of_stories <> ri.no_of_stories;
    SELF.Diff_src_no_of_stories := le.src_no_of_stories <> ri.src_no_of_stories;
    SELF.Diff_tax_dt_no_of_stories := le.tax_dt_no_of_stories <> ri.tax_dt_no_of_stories;
    SELF.Diff_parking_type := le.parking_type <> ri.parking_type;
    SELF.Diff_src_parking_type := le.src_parking_type <> ri.src_parking_type;
    SELF.Diff_tax_dt_parking_type := le.tax_dt_parking_type <> ri.tax_dt_parking_type;
    SELF.Diff_pool_indicator := le.pool_indicator <> ri.pool_indicator;
    SELF.Diff_src_pool_indicator := le.src_pool_indicator <> ri.src_pool_indicator;
    SELF.Diff_tax_dt_pool_indicator := le.tax_dt_pool_indicator <> ri.tax_dt_pool_indicator;
    SELF.Diff_pool_type := le.pool_type <> ri.pool_type;
    SELF.Diff_src_pool_type := le.src_pool_type <> ri.src_pool_type;
    SELF.Diff_tax_dt_pool_type := le.tax_dt_pool_type <> ri.tax_dt_pool_type;
    SELF.Diff_roof_cover := le.roof_cover <> ri.roof_cover;
    SELF.Diff_src_roof_cover := le.src_roof_cover <> ri.src_roof_cover;
    SELF.Diff_tax_dt_roof_cover := le.tax_dt_roof_cover <> ri.tax_dt_roof_cover;
    SELF.Diff_year_built := le.year_built <> ri.year_built;
    SELF.Diff_src_year_built := le.src_year_built <> ri.src_year_built;
    SELF.Diff_tax_dt_year_built := le.tax_dt_year_built <> ri.tax_dt_year_built;
    SELF.Diff_foundation := le.foundation <> ri.foundation;
    SELF.Diff_src_foundation := le.src_foundation <> ri.src_foundation;
    SELF.Diff_tax_dt_foundation := le.tax_dt_foundation <> ri.tax_dt_foundation;
    SELF.Diff_basement_square_footage := le.basement_square_footage <> ri.basement_square_footage;
    SELF.Diff_src_basement_square_footage := le.src_basement_square_footage <> ri.src_basement_square_footage;
    SELF.Diff_tax_dt_basement_square_footage := le.tax_dt_basement_square_footage <> ri.tax_dt_basement_square_footage;
    SELF.Diff_effective_year_built := le.effective_year_built <> ri.effective_year_built;
    SELF.Diff_src_effective_year_built := le.src_effective_year_built <> ri.src_effective_year_built;
    SELF.Diff_tax_dt_effective_year_built := le.tax_dt_effective_year_built <> ri.tax_dt_effective_year_built;
    SELF.Diff_garage_square_footage := le.garage_square_footage <> ri.garage_square_footage;
    SELF.Diff_src_garage_square_footage := le.src_garage_square_footage <> ri.src_garage_square_footage;
    SELF.Diff_tax_dt_garage_square_footage := le.tax_dt_garage_square_footage <> ri.tax_dt_garage_square_footage;
    SELF.Diff_stories_type := le.stories_type <> ri.stories_type;
    SELF.Diff_src_stories_type := le.src_stories_type <> ri.src_stories_type;
    SELF.Diff_tax_dt_stories_type := le.tax_dt_stories_type <> ri.tax_dt_stories_type;
    SELF.Diff_apn_number := le.apn_number <> ri.apn_number;
    SELF.Diff_src_apn_number := le.src_apn_number <> ri.src_apn_number;
    SELF.Diff_tax_dt_apn_number := le.tax_dt_apn_number <> ri.tax_dt_apn_number;
    SELF.Diff_census_tract := le.census_tract <> ri.census_tract;
    SELF.Diff_src_census_tract := le.src_census_tract <> ri.src_census_tract;
    SELF.Diff_tax_dt_census_tract := le.tax_dt_census_tract <> ri.tax_dt_census_tract;
    SELF.Diff_range := le.range <> ri.range;
    SELF.Diff_src_range := le.src_range <> ri.src_range;
    SELF.Diff_tax_dt_range := le.tax_dt_range <> ri.tax_dt_range;
    SELF.Diff_zoning := le.zoning <> ri.zoning;
    SELF.Diff_src_zoning := le.src_zoning <> ri.src_zoning;
    SELF.Diff_tax_dt_zoning := le.tax_dt_zoning <> ri.tax_dt_zoning;
    SELF.Diff_block_number := le.block_number <> ri.block_number;
    SELF.Diff_src_block_number := le.src_block_number <> ri.src_block_number;
    SELF.Diff_tax_dt_block_number := le.tax_dt_block_number <> ri.tax_dt_block_number;
    SELF.Diff_county_name := le.county_name <> ri.county_name;
    SELF.Diff_src_county_name := le.src_county_name <> ri.src_county_name;
    SELF.Diff_tax_dt_county_name := le.tax_dt_county_name <> ri.tax_dt_county_name;
    SELF.Diff_fips_code := le.fips_code <> ri.fips_code;
    SELF.Diff_src_fips_code := le.src_fips_code <> ri.src_fips_code;
    SELF.Diff_tax_dt_fips_code := le.tax_dt_fips_code <> ri.tax_dt_fips_code;
    SELF.Diff_subdivision := le.subdivision <> ri.subdivision;
    SELF.Diff_src_subdivision := le.src_subdivision <> ri.src_subdivision;
    SELF.Diff_tax_dt_subdivision := le.tax_dt_subdivision <> ri.tax_dt_subdivision;
    SELF.Diff_municipality := le.municipality <> ri.municipality;
    SELF.Diff_src_municipality := le.src_municipality <> ri.src_municipality;
    SELF.Diff_tax_dt_municipality := le.tax_dt_municipality <> ri.tax_dt_municipality;
    SELF.Diff_township := le.township <> ri.township;
    SELF.Diff_src_township := le.src_township <> ri.src_township;
    SELF.Diff_tax_dt_township := le.tax_dt_township <> ri.tax_dt_township;
    SELF.Diff_homestead_exemption_ind := le.homestead_exemption_ind <> ri.homestead_exemption_ind;
    SELF.Diff_src_homestead_exemption_ind := le.src_homestead_exemption_ind <> ri.src_homestead_exemption_ind;
    SELF.Diff_tax_dt_homestead_exemption_ind := le.tax_dt_homestead_exemption_ind <> ri.tax_dt_homestead_exemption_ind;
    SELF.Diff_land_use_code := le.land_use_code <> ri.land_use_code;
    SELF.Diff_src_land_use_code := le.src_land_use_code <> ri.src_land_use_code;
    SELF.Diff_tax_dt_land_use_code := le.tax_dt_land_use_code <> ri.tax_dt_land_use_code;
    SELF.Diff_latitude := le.latitude <> ri.latitude;
    SELF.Diff_src_latitude := le.src_latitude <> ri.src_latitude;
    SELF.Diff_tax_dt_latitude := le.tax_dt_latitude <> ri.tax_dt_latitude;
    SELF.Diff_longitude := le.longitude <> ri.longitude;
    SELF.Diff_src_longitude := le.src_longitude <> ri.src_longitude;
    SELF.Diff_tax_dt_longitude := le.tax_dt_longitude <> ri.tax_dt_longitude;
    SELF.Diff_location_influence_code := le.location_influence_code <> ri.location_influence_code;
    SELF.Diff_src_location_influence_code := le.src_location_influence_code <> ri.src_location_influence_code;
    SELF.Diff_tax_dt_location_influence_code := le.tax_dt_location_influence_code <> ri.tax_dt_location_influence_code;
    SELF.Diff_acres := le.acres <> ri.acres;
    SELF.Diff_src_acres := le.src_acres <> ri.src_acres;
    SELF.Diff_tax_dt_acres := le.tax_dt_acres <> ri.tax_dt_acres;
    SELF.Diff_lot_depth_footage := le.lot_depth_footage <> ri.lot_depth_footage;
    SELF.Diff_src_lot_depth_footage := le.src_lot_depth_footage <> ri.src_lot_depth_footage;
    SELF.Diff_tax_dt_lot_depth_footage := le.tax_dt_lot_depth_footage <> ri.tax_dt_lot_depth_footage;
    SELF.Diff_lot_front_footage := le.lot_front_footage <> ri.lot_front_footage;
    SELF.Diff_src_lot_front_footage := le.src_lot_front_footage <> ri.src_lot_front_footage;
    SELF.Diff_tax_dt_lot_front_footage := le.tax_dt_lot_front_footage <> ri.tax_dt_lot_front_footage;
    SELF.Diff_lot_number := le.lot_number <> ri.lot_number;
    SELF.Diff_src_lot_number := le.src_lot_number <> ri.src_lot_number;
    SELF.Diff_tax_dt_lot_number := le.tax_dt_lot_number <> ri.tax_dt_lot_number;
    SELF.Diff_lot_size := le.lot_size <> ri.lot_size;
    SELF.Diff_src_lot_size := le.src_lot_size <> ri.src_lot_size;
    SELF.Diff_tax_dt_lot_size := le.tax_dt_lot_size <> ri.tax_dt_lot_size;
    SELF.Diff_property_type_code := le.property_type_code <> ri.property_type_code;
    SELF.Diff_src_property_type_code := le.src_property_type_code <> ri.src_property_type_code;
    SELF.Diff_tax_dt_property_type_code := le.tax_dt_property_type_code <> ri.tax_dt_property_type_code;
    SELF.Diff_structure_quality := le.structure_quality <> ri.structure_quality;
    SELF.Diff_src_structure_quality := le.src_structure_quality <> ri.src_structure_quality;
    SELF.Diff_tax_dt_structure_quality := le.tax_dt_structure_quality <> ri.tax_dt_structure_quality;
    SELF.Diff_water := le.water <> ri.water;
    SELF.Diff_src_water := le.src_water <> ri.src_water;
    SELF.Diff_tax_dt_water := le.tax_dt_water <> ri.tax_dt_water;
    SELF.Diff_sewer := le.sewer <> ri.sewer;
    SELF.Diff_src_sewer := le.src_sewer <> ri.src_sewer;
    SELF.Diff_tax_dt_sewer := le.tax_dt_sewer <> ri.tax_dt_sewer;
    SELF.Diff_assessed_land_value := le.assessed_land_value <> ri.assessed_land_value;
    SELF.Diff_src_assessed_land_value := le.src_assessed_land_value <> ri.src_assessed_land_value;
    SELF.Diff_tax_dt_assessed_land_value := le.tax_dt_assessed_land_value <> ri.tax_dt_assessed_land_value;
    SELF.Diff_assessed_year := le.assessed_year <> ri.assessed_year;
    SELF.Diff_src_assessed_year := le.src_assessed_year <> ri.src_assessed_year;
    SELF.Diff_tax_dt_assessed_year := le.tax_dt_assessed_year <> ri.tax_dt_assessed_year;
    SELF.Diff_tax_amount := le.tax_amount <> ri.tax_amount;
    SELF.Diff_src_tax_amount := le.src_tax_amount <> ri.src_tax_amount;
    SELF.Diff_tax_dt_tax_amount := le.tax_dt_tax_amount <> ri.tax_dt_tax_amount;
    SELF.Diff_tax_year := le.tax_year <> ri.tax_year;
    SELF.Diff_src_tax_year := le.src_tax_year <> ri.src_tax_year;
    SELF.Diff_market_land_value := le.market_land_value <> ri.market_land_value;
    SELF.Diff_src_market_land_value := le.src_market_land_value <> ri.src_market_land_value;
    SELF.Diff_tax_dt_market_land_value := le.tax_dt_market_land_value <> ri.tax_dt_market_land_value;
    SELF.Diff_improvement_value := le.improvement_value <> ri.improvement_value;
    SELF.Diff_src_improvement_value := le.src_improvement_value <> ri.src_improvement_value;
    SELF.Diff_tax_dt_improvement_value := le.tax_dt_improvement_value <> ri.tax_dt_improvement_value;
    SELF.Diff_percent_improved := le.percent_improved <> ri.percent_improved;
    SELF.Diff_src_percent_improved := le.src_percent_improved <> ri.src_percent_improved;
    SELF.Diff_tax_dt_percent_improved := le.tax_dt_percent_improved <> ri.tax_dt_percent_improved;
    SELF.Diff_total_assessed_value := le.total_assessed_value <> ri.total_assessed_value;
    SELF.Diff_src_total_assessed_value := le.src_total_assessed_value <> ri.src_total_assessed_value;
    SELF.Diff_tax_dt_total_assessed_value := le.tax_dt_total_assessed_value <> ri.tax_dt_total_assessed_value;
    SELF.Diff_total_calculated_value := le.total_calculated_value <> ri.total_calculated_value;
    SELF.Diff_src_total_calculated_value := le.src_total_calculated_value <> ri.src_total_calculated_value;
    SELF.Diff_tax_dt_total_calculated_value := le.tax_dt_total_calculated_value <> ri.tax_dt_total_calculated_value;
    SELF.Diff_total_land_value := le.total_land_value <> ri.total_land_value;
    SELF.Diff_src_total_land_value := le.src_total_land_value <> ri.src_total_land_value;
    SELF.Diff_tax_dt_total_land_value := le.tax_dt_total_land_value <> ri.tax_dt_total_land_value;
    SELF.Diff_total_market_value := le.total_market_value <> ri.total_market_value;
    SELF.Diff_src_total_market_value := le.src_total_market_value <> ri.src_total_market_value;
    SELF.Diff_tax_dt_total_market_value := le.tax_dt_total_market_value <> ri.tax_dt_total_market_value;
    SELF.Diff_floor_type := le.floor_type <> ri.floor_type;
    SELF.Diff_src_floor_type := le.src_floor_type <> ri.src_floor_type;
    SELF.Diff_tax_dt_floor_type := le.tax_dt_floor_type <> ri.tax_dt_floor_type;
    SELF.Diff_frame_type := le.frame_type <> ri.frame_type;
    SELF.Diff_src_frame_type := le.src_frame_type <> ri.src_frame_type;
    SELF.Diff_tax_dt_frame_type := le.tax_dt_frame_type <> ri.tax_dt_frame_type;
    SELF.Diff_fuel_type := le.fuel_type <> ri.fuel_type;
    SELF.Diff_src_fuel_type := le.src_fuel_type <> ri.src_fuel_type;
    SELF.Diff_tax_dt_fuel_type := le.tax_dt_fuel_type <> ri.tax_dt_fuel_type;
    SELF.Diff_no_of_bath_fixtures := le.no_of_bath_fixtures <> ri.no_of_bath_fixtures;
    SELF.Diff_src_no_of_bath_fixtures := le.src_no_of_bath_fixtures <> ri.src_no_of_bath_fixtures;
    SELF.Diff_tax_dt_no_of_bath_fixtures := le.tax_dt_no_of_bath_fixtures <> ri.tax_dt_no_of_bath_fixtures;
    SELF.Diff_no_of_rooms := le.no_of_rooms <> ri.no_of_rooms;
    SELF.Diff_src_no_of_rooms := le.src_no_of_rooms <> ri.src_no_of_rooms;
    SELF.Diff_tax_dt_no_of_rooms := le.tax_dt_no_of_rooms <> ri.tax_dt_no_of_rooms;
    SELF.Diff_no_of_units := le.no_of_units <> ri.no_of_units;
    SELF.Diff_src_no_of_units := le.src_no_of_units <> ri.src_no_of_units;
    SELF.Diff_tax_dt_no_of_units := le.tax_dt_no_of_units <> ri.tax_dt_no_of_units;
    SELF.Diff_style_type := le.style_type <> ri.style_type;
    SELF.Diff_src_style_type := le.src_style_type <> ri.src_style_type;
    SELF.Diff_tax_dt_style_type := le.tax_dt_style_type <> ri.tax_dt_style_type;
    SELF.Diff_assessment_document_number := le.assessment_document_number <> ri.assessment_document_number;
    SELF.Diff_src_assessment_document_number := le.src_assessment_document_number <> ri.src_assessment_document_number;
    SELF.Diff_tax_dt_assessment_document_number := le.tax_dt_assessment_document_number <> ri.tax_dt_assessment_document_number;
    SELF.Diff_assessment_recording_date := le.assessment_recording_date <> ri.assessment_recording_date;
    SELF.Diff_src_assessment_recording_date := le.src_assessment_recording_date <> ri.src_assessment_recording_date;
    SELF.Diff_tax_dt_assessment_recording_date := le.tax_dt_assessment_recording_date <> ri.tax_dt_assessment_recording_date;
    SELF.Diff_deed_document_number := le.deed_document_number <> ri.deed_document_number;
    SELF.Diff_src_deed_document_number := le.src_deed_document_number <> ri.src_deed_document_number;
    SELF.Diff_rec_dt_deed_document_number := le.rec_dt_deed_document_number <> ri.rec_dt_deed_document_number;
    SELF.Diff_deed_recording_date := le.deed_recording_date <> ri.deed_recording_date;
    SELF.Diff_src_deed_recording_date := le.src_deed_recording_date <> ri.src_deed_recording_date;
    SELF.Diff_full_part_sale := le.full_part_sale <> ri.full_part_sale;
    SELF.Diff_src_full_part_sale := le.src_full_part_sale <> ri.src_full_part_sale;
    SELF.Diff_rec_dt_full_part_sale := le.rec_dt_full_part_sale <> ri.rec_dt_full_part_sale;
    SELF.Diff_sale_amount := le.sale_amount <> ri.sale_amount;
    SELF.Diff_src_sale_amount := le.src_sale_amount <> ri.src_sale_amount;
    SELF.Diff_rec_dt_sale_amount := le.rec_dt_sale_amount <> ri.rec_dt_sale_amount;
    SELF.Diff_sale_date := le.sale_date <> ri.sale_date;
    SELF.Diff_src_sale_date := le.src_sale_date <> ri.src_sale_date;
    SELF.Diff_rec_dt_sale_date := le.rec_dt_sale_date <> ri.rec_dt_sale_date;
    SELF.Diff_sale_type_code := le.sale_type_code <> ri.sale_type_code;
    SELF.Diff_src_sale_type_code := le.src_sale_type_code <> ri.src_sale_type_code;
    SELF.Diff_rec_dt_sale_type_code := le.rec_dt_sale_type_code <> ri.rec_dt_sale_type_code;
    SELF.Diff_mortgage_company_name := le.mortgage_company_name <> ri.mortgage_company_name;
    SELF.Diff_src_mortgage_company_name := le.src_mortgage_company_name <> ri.src_mortgage_company_name;
    SELF.Diff_rec_dt_mortgage_company_name := le.rec_dt_mortgage_company_name <> ri.rec_dt_mortgage_company_name;
    SELF.Diff_loan_amount := le.loan_amount <> ri.loan_amount;
    SELF.Diff_src_loan_amount := le.src_loan_amount <> ri.src_loan_amount;
    SELF.Diff_rec_dt_loan_amount := le.rec_dt_loan_amount <> ri.rec_dt_loan_amount;
    SELF.Diff_second_loan_amount := le.second_loan_amount <> ri.second_loan_amount;
    SELF.Diff_src_second_loan_amount := le.src_second_loan_amount <> ri.src_second_loan_amount;
    SELF.Diff_rec_dt_second_loan_amount := le.rec_dt_second_loan_amount <> ri.rec_dt_second_loan_amount;
    SELF.Diff_loan_type_code := le.loan_type_code <> ri.loan_type_code;
    SELF.Diff_src_loan_type_code := le.src_loan_type_code <> ri.src_loan_type_code;
    SELF.Diff_rec_dt_loan_type_code := le.rec_dt_loan_type_code <> ri.rec_dt_loan_type_code;
    SELF.Diff_interest_rate_type_code := le.interest_rate_type_code <> ri.interest_rate_type_code;
    SELF.Diff_src_interest_rate_type_code := le.src_interest_rate_type_code <> ri.src_interest_rate_type_code;
    SELF.Diff_rec_dt_interest_rate_type_code := le.rec_dt_interest_rate_type_code <> ri.rec_dt_interest_rate_type_code;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.vendor_source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_property_rid,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_tax_sortby_date,1,0)+ IF( SELF.Diff_deed_sortby_date,1,0)+ IF( SELF.Diff_vendor_source,1,0)+ IF( SELF.Diff_fares_unformatted_apn,1,0)+ IF( SELF.Diff_property_street_address,1,0)+ IF( SELF.Diff_property_city_state_zip,1,0)+ IF( SELF.Diff_property_raw_aid,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_building_square_footage,1,0)+ IF( SELF.Diff_src_building_square_footage,1,0)+ IF( SELF.Diff_tax_dt_building_square_footage,1,0)+ IF( SELF.Diff_air_conditioning_type,1,0)+ IF( SELF.Diff_src_air_conditioning_type,1,0)+ IF( SELF.Diff_tax_dt_air_conditioning_type,1,0)+ IF( SELF.Diff_basement_finish,1,0)+ IF( SELF.Diff_src_basement_finish,1,0)+ IF( SELF.Diff_tax_dt_basement_finish,1,0)+ IF( SELF.Diff_construction_type,1,0)+ IF( SELF.Diff_src_construction_type,1,0)+ IF( SELF.Diff_tax_dt_construction_type,1,0)+ IF( SELF.Diff_exterior_wall,1,0)+ IF( SELF.Diff_src_exterior_wall,1,0)+ IF( SELF.Diff_tax_dt_exterior_wall,1,0)+ IF( SELF.Diff_fireplace_ind,1,0)+ IF( SELF.Diff_src_fireplace_ind,1,0)+ IF( SELF.Diff_tax_dt_fireplace_ind,1,0)+ IF( SELF.Diff_fireplace_type,1,0)+ IF( SELF.Diff_src_fireplace_type,1,0)+ IF( SELF.Diff_tax_dt_fireplace_type,1,0)+ IF( SELF.Diff_flood_zone_panel,1,0)+ IF( SELF.Diff_src_flood_zone_panel,1,0)+ IF( SELF.Diff_tax_dt_flood_zone_panel,1,0)+ IF( SELF.Diff_garage,1,0)+ IF( SELF.Diff_src_garage,1,0)+ IF( SELF.Diff_tax_dt_garage,1,0)+ IF( SELF.Diff_first_floor_square_footage,1,0)+ IF( SELF.Diff_src_first_floor_square_footage,1,0)+ IF( SELF.Diff_tax_dt_first_floor_square_footage,1,0)+ IF( SELF.Diff_heating,1,0)+ IF( SELF.Diff_src_heating,1,0)+ IF( SELF.Diff_tax_dt_heating,1,0)+ IF( SELF.Diff_living_area_square_footage,1,0)+ IF( SELF.Diff_src_living_area_square_footage,1,0)+ IF( SELF.Diff_tax_dt_living_area_square_footage,1,0)+ IF( SELF.Diff_no_of_baths,1,0)+ IF( SELF.Diff_src_no_of_baths,1,0)+ IF( SELF.Diff_tax_dt_no_of_baths,1,0)+ IF( SELF.Diff_no_of_bedrooms,1,0)+ IF( SELF.Diff_src_no_of_bedrooms,1,0)+ IF( SELF.Diff_tax_dt_no_of_bedrooms,1,0)+ IF( SELF.Diff_no_of_fireplaces,1,0)+ IF( SELF.Diff_src_no_of_fireplaces,1,0)+ IF( SELF.Diff_tax_dt_no_of_fireplaces,1,0)+ IF( SELF.Diff_no_of_full_baths,1,0)+ IF( SELF.Diff_src_no_of_full_baths,1,0)+ IF( SELF.Diff_tax_dt_no_of_full_baths,1,0)+ IF( SELF.Diff_no_of_half_baths,1,0)+ IF( SELF.Diff_src_no_of_half_baths,1,0)+ IF( SELF.Diff_tax_dt_no_of_half_baths,1,0)+ IF( SELF.Diff_no_of_stories,1,0)+ IF( SELF.Diff_src_no_of_stories,1,0)+ IF( SELF.Diff_tax_dt_no_of_stories,1,0)+ IF( SELF.Diff_parking_type,1,0)+ IF( SELF.Diff_src_parking_type,1,0)+ IF( SELF.Diff_tax_dt_parking_type,1,0)+ IF( SELF.Diff_pool_indicator,1,0)+ IF( SELF.Diff_src_pool_indicator,1,0)+ IF( SELF.Diff_tax_dt_pool_indicator,1,0)+ IF( SELF.Diff_pool_type,1,0)+ IF( SELF.Diff_src_pool_type,1,0)+ IF( SELF.Diff_tax_dt_pool_type,1,0)+ IF( SELF.Diff_roof_cover,1,0)+ IF( SELF.Diff_src_roof_cover,1,0)+ IF( SELF.Diff_tax_dt_roof_cover,1,0)+ IF( SELF.Diff_year_built,1,0)+ IF( SELF.Diff_src_year_built,1,0)+ IF( SELF.Diff_tax_dt_year_built,1,0)+ IF( SELF.Diff_foundation,1,0)+ IF( SELF.Diff_src_foundation,1,0)+ IF( SELF.Diff_tax_dt_foundation,1,0)+ IF( SELF.Diff_basement_square_footage,1,0)+ IF( SELF.Diff_src_basement_square_footage,1,0)+ IF( SELF.Diff_tax_dt_basement_square_footage,1,0)+ IF( SELF.Diff_effective_year_built,1,0)+ IF( SELF.Diff_src_effective_year_built,1,0)+ IF( SELF.Diff_tax_dt_effective_year_built,1,0)+ IF( SELF.Diff_garage_square_footage,1,0)+ IF( SELF.Diff_src_garage_square_footage,1,0)+ IF( SELF.Diff_tax_dt_garage_square_footage,1,0)+ IF( SELF.Diff_stories_type,1,0)+ IF( SELF.Diff_src_stories_type,1,0)+ IF( SELF.Diff_tax_dt_stories_type,1,0)+ IF( SELF.Diff_apn_number,1,0)+ IF( SELF.Diff_src_apn_number,1,0)+ IF( SELF.Diff_tax_dt_apn_number,1,0)+ IF( SELF.Diff_census_tract,1,0)+ IF( SELF.Diff_src_census_tract,1,0)+ IF( SELF.Diff_tax_dt_census_tract,1,0)+ IF( SELF.Diff_range,1,0)+ IF( SELF.Diff_src_range,1,0)+ IF( SELF.Diff_tax_dt_range,1,0)+ IF( SELF.Diff_zoning,1,0)+ IF( SELF.Diff_src_zoning,1,0)+ IF( SELF.Diff_tax_dt_zoning,1,0)+ IF( SELF.Diff_block_number,1,0)+ IF( SELF.Diff_src_block_number,1,0)+ IF( SELF.Diff_tax_dt_block_number,1,0)+ IF( SELF.Diff_county_name,1,0)+ IF( SELF.Diff_src_county_name,1,0)+ IF( SELF.Diff_tax_dt_county_name,1,0)+ IF( SELF.Diff_fips_code,1,0)+ IF( SELF.Diff_src_fips_code,1,0)+ IF( SELF.Diff_tax_dt_fips_code,1,0)+ IF( SELF.Diff_subdivision,1,0)+ IF( SELF.Diff_src_subdivision,1,0)+ IF( SELF.Diff_tax_dt_subdivision,1,0)+ IF( SELF.Diff_municipality,1,0)+ IF( SELF.Diff_src_municipality,1,0)+ IF( SELF.Diff_tax_dt_municipality,1,0)+ IF( SELF.Diff_township,1,0)+ IF( SELF.Diff_src_township,1,0)+ IF( SELF.Diff_tax_dt_township,1,0)+ IF( SELF.Diff_homestead_exemption_ind,1,0)+ IF( SELF.Diff_src_homestead_exemption_ind,1,0)+ IF( SELF.Diff_tax_dt_homestead_exemption_ind,1,0)+ IF( SELF.Diff_land_use_code,1,0)+ IF( SELF.Diff_src_land_use_code,1,0)+ IF( SELF.Diff_tax_dt_land_use_code,1,0)+ IF( SELF.Diff_latitude,1,0)+ IF( SELF.Diff_src_latitude,1,0)+ IF( SELF.Diff_tax_dt_latitude,1,0)+ IF( SELF.Diff_longitude,1,0)+ IF( SELF.Diff_src_longitude,1,0)+ IF( SELF.Diff_tax_dt_longitude,1,0)+ IF( SELF.Diff_location_influence_code,1,0)+ IF( SELF.Diff_src_location_influence_code,1,0)+ IF( SELF.Diff_tax_dt_location_influence_code,1,0)+ IF( SELF.Diff_acres,1,0)+ IF( SELF.Diff_src_acres,1,0)+ IF( SELF.Diff_tax_dt_acres,1,0)+ IF( SELF.Diff_lot_depth_footage,1,0)+ IF( SELF.Diff_src_lot_depth_footage,1,0)+ IF( SELF.Diff_tax_dt_lot_depth_footage,1,0)+ IF( SELF.Diff_lot_front_footage,1,0)+ IF( SELF.Diff_src_lot_front_footage,1,0)+ IF( SELF.Diff_tax_dt_lot_front_footage,1,0)+ IF( SELF.Diff_lot_number,1,0)+ IF( SELF.Diff_src_lot_number,1,0)+ IF( SELF.Diff_tax_dt_lot_number,1,0)+ IF( SELF.Diff_lot_size,1,0)+ IF( SELF.Diff_src_lot_size,1,0)+ IF( SELF.Diff_tax_dt_lot_size,1,0)+ IF( SELF.Diff_property_type_code,1,0)+ IF( SELF.Diff_src_property_type_code,1,0)+ IF( SELF.Diff_tax_dt_property_type_code,1,0)+ IF( SELF.Diff_structure_quality,1,0)+ IF( SELF.Diff_src_structure_quality,1,0)+ IF( SELF.Diff_tax_dt_structure_quality,1,0)+ IF( SELF.Diff_water,1,0)+ IF( SELF.Diff_src_water,1,0)+ IF( SELF.Diff_tax_dt_water,1,0)+ IF( SELF.Diff_sewer,1,0)+ IF( SELF.Diff_src_sewer,1,0)+ IF( SELF.Diff_tax_dt_sewer,1,0)+ IF( SELF.Diff_assessed_land_value,1,0)+ IF( SELF.Diff_src_assessed_land_value,1,0)+ IF( SELF.Diff_tax_dt_assessed_land_value,1,0)+ IF( SELF.Diff_assessed_year,1,0)+ IF( SELF.Diff_src_assessed_year,1,0)+ IF( SELF.Diff_tax_dt_assessed_year,1,0)+ IF( SELF.Diff_tax_amount,1,0)+ IF( SELF.Diff_src_tax_amount,1,0)+ IF( SELF.Diff_tax_dt_tax_amount,1,0)+ IF( SELF.Diff_tax_year,1,0)+ IF( SELF.Diff_src_tax_year,1,0)+ IF( SELF.Diff_market_land_value,1,0)+ IF( SELF.Diff_src_market_land_value,1,0)+ IF( SELF.Diff_tax_dt_market_land_value,1,0)+ IF( SELF.Diff_improvement_value,1,0)+ IF( SELF.Diff_src_improvement_value,1,0)+ IF( SELF.Diff_tax_dt_improvement_value,1,0)+ IF( SELF.Diff_percent_improved,1,0)+ IF( SELF.Diff_src_percent_improved,1,0)+ IF( SELF.Diff_tax_dt_percent_improved,1,0)+ IF( SELF.Diff_total_assessed_value,1,0)+ IF( SELF.Diff_src_total_assessed_value,1,0)+ IF( SELF.Diff_tax_dt_total_assessed_value,1,0)+ IF( SELF.Diff_total_calculated_value,1,0)+ IF( SELF.Diff_src_total_calculated_value,1,0)+ IF( SELF.Diff_tax_dt_total_calculated_value,1,0)+ IF( SELF.Diff_total_land_value,1,0)+ IF( SELF.Diff_src_total_land_value,1,0)+ IF( SELF.Diff_tax_dt_total_land_value,1,0)+ IF( SELF.Diff_total_market_value,1,0)+ IF( SELF.Diff_src_total_market_value,1,0)+ IF( SELF.Diff_tax_dt_total_market_value,1,0)+ IF( SELF.Diff_floor_type,1,0)+ IF( SELF.Diff_src_floor_type,1,0)+ IF( SELF.Diff_tax_dt_floor_type,1,0)+ IF( SELF.Diff_frame_type,1,0)+ IF( SELF.Diff_src_frame_type,1,0)+ IF( SELF.Diff_tax_dt_frame_type,1,0)+ IF( SELF.Diff_fuel_type,1,0)+ IF( SELF.Diff_src_fuel_type,1,0)+ IF( SELF.Diff_tax_dt_fuel_type,1,0)+ IF( SELF.Diff_no_of_bath_fixtures,1,0)+ IF( SELF.Diff_src_no_of_bath_fixtures,1,0)+ IF( SELF.Diff_tax_dt_no_of_bath_fixtures,1,0)+ IF( SELF.Diff_no_of_rooms,1,0)+ IF( SELF.Diff_src_no_of_rooms,1,0)+ IF( SELF.Diff_tax_dt_no_of_rooms,1,0)+ IF( SELF.Diff_no_of_units,1,0)+ IF( SELF.Diff_src_no_of_units,1,0)+ IF( SELF.Diff_tax_dt_no_of_units,1,0)+ IF( SELF.Diff_style_type,1,0)+ IF( SELF.Diff_src_style_type,1,0)+ IF( SELF.Diff_tax_dt_style_type,1,0)+ IF( SELF.Diff_assessment_document_number,1,0)+ IF( SELF.Diff_src_assessment_document_number,1,0)+ IF( SELF.Diff_tax_dt_assessment_document_number,1,0)+ IF( SELF.Diff_assessment_recording_date,1,0)+ IF( SELF.Diff_src_assessment_recording_date,1,0)+ IF( SELF.Diff_tax_dt_assessment_recording_date,1,0)+ IF( SELF.Diff_deed_document_number,1,0)+ IF( SELF.Diff_src_deed_document_number,1,0)+ IF( SELF.Diff_rec_dt_deed_document_number,1,0)+ IF( SELF.Diff_deed_recording_date,1,0)+ IF( SELF.Diff_src_deed_recording_date,1,0)+ IF( SELF.Diff_full_part_sale,1,0)+ IF( SELF.Diff_src_full_part_sale,1,0)+ IF( SELF.Diff_rec_dt_full_part_sale,1,0)+ IF( SELF.Diff_sale_amount,1,0)+ IF( SELF.Diff_src_sale_amount,1,0)+ IF( SELF.Diff_rec_dt_sale_amount,1,0)+ IF( SELF.Diff_sale_date,1,0)+ IF( SELF.Diff_src_sale_date,1,0)+ IF( SELF.Diff_rec_dt_sale_date,1,0)+ IF( SELF.Diff_sale_type_code,1,0)+ IF( SELF.Diff_src_sale_type_code,1,0)+ IF( SELF.Diff_rec_dt_sale_type_code,1,0)+ IF( SELF.Diff_mortgage_company_name,1,0)+ IF( SELF.Diff_src_mortgage_company_name,1,0)+ IF( SELF.Diff_rec_dt_mortgage_company_name,1,0)+ IF( SELF.Diff_loan_amount,1,0)+ IF( SELF.Diff_src_loan_amount,1,0)+ IF( SELF.Diff_rec_dt_loan_amount,1,0)+ IF( SELF.Diff_second_loan_amount,1,0)+ IF( SELF.Diff_src_second_loan_amount,1,0)+ IF( SELF.Diff_rec_dt_second_loan_amount,1,0)+ IF( SELF.Diff_loan_type_code,1,0)+ IF( SELF.Diff_src_loan_type_code,1,0)+ IF( SELF.Diff_rec_dt_loan_type_code,1,0)+ IF( SELF.Diff_interest_rate_type_code,1,0)+ IF( SELF.Diff_src_interest_rate_type_code,1,0)+ IF( SELF.Diff_rec_dt_interest_rate_type_code,1,0);
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
    Count_Diff_property_rid := COUNT(GROUP,%Closest%.Diff_property_rid);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_tax_sortby_date := COUNT(GROUP,%Closest%.Diff_tax_sortby_date);
    Count_Diff_deed_sortby_date := COUNT(GROUP,%Closest%.Diff_deed_sortby_date);
    Count_Diff_vendor_source := COUNT(GROUP,%Closest%.Diff_vendor_source);
    Count_Diff_fares_unformatted_apn := COUNT(GROUP,%Closest%.Diff_fares_unformatted_apn);
    Count_Diff_property_street_address := COUNT(GROUP,%Closest%.Diff_property_street_address);
    Count_Diff_property_city_state_zip := COUNT(GROUP,%Closest%.Diff_property_city_state_zip);
    Count_Diff_property_raw_aid := COUNT(GROUP,%Closest%.Diff_property_raw_aid);
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
    Count_Diff_dbpc := COUNT(GROUP,%Closest%.Diff_dbpc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_building_square_footage := COUNT(GROUP,%Closest%.Diff_building_square_footage);
    Count_Diff_src_building_square_footage := COUNT(GROUP,%Closest%.Diff_src_building_square_footage);
    Count_Diff_tax_dt_building_square_footage := COUNT(GROUP,%Closest%.Diff_tax_dt_building_square_footage);
    Count_Diff_air_conditioning_type := COUNT(GROUP,%Closest%.Diff_air_conditioning_type);
    Count_Diff_src_air_conditioning_type := COUNT(GROUP,%Closest%.Diff_src_air_conditioning_type);
    Count_Diff_tax_dt_air_conditioning_type := COUNT(GROUP,%Closest%.Diff_tax_dt_air_conditioning_type);
    Count_Diff_basement_finish := COUNT(GROUP,%Closest%.Diff_basement_finish);
    Count_Diff_src_basement_finish := COUNT(GROUP,%Closest%.Diff_src_basement_finish);
    Count_Diff_tax_dt_basement_finish := COUNT(GROUP,%Closest%.Diff_tax_dt_basement_finish);
    Count_Diff_construction_type := COUNT(GROUP,%Closest%.Diff_construction_type);
    Count_Diff_src_construction_type := COUNT(GROUP,%Closest%.Diff_src_construction_type);
    Count_Diff_tax_dt_construction_type := COUNT(GROUP,%Closest%.Diff_tax_dt_construction_type);
    Count_Diff_exterior_wall := COUNT(GROUP,%Closest%.Diff_exterior_wall);
    Count_Diff_src_exterior_wall := COUNT(GROUP,%Closest%.Diff_src_exterior_wall);
    Count_Diff_tax_dt_exterior_wall := COUNT(GROUP,%Closest%.Diff_tax_dt_exterior_wall);
    Count_Diff_fireplace_ind := COUNT(GROUP,%Closest%.Diff_fireplace_ind);
    Count_Diff_src_fireplace_ind := COUNT(GROUP,%Closest%.Diff_src_fireplace_ind);
    Count_Diff_tax_dt_fireplace_ind := COUNT(GROUP,%Closest%.Diff_tax_dt_fireplace_ind);
    Count_Diff_fireplace_type := COUNT(GROUP,%Closest%.Diff_fireplace_type);
    Count_Diff_src_fireplace_type := COUNT(GROUP,%Closest%.Diff_src_fireplace_type);
    Count_Diff_tax_dt_fireplace_type := COUNT(GROUP,%Closest%.Diff_tax_dt_fireplace_type);
    Count_Diff_flood_zone_panel := COUNT(GROUP,%Closest%.Diff_flood_zone_panel);
    Count_Diff_src_flood_zone_panel := COUNT(GROUP,%Closest%.Diff_src_flood_zone_panel);
    Count_Diff_tax_dt_flood_zone_panel := COUNT(GROUP,%Closest%.Diff_tax_dt_flood_zone_panel);
    Count_Diff_garage := COUNT(GROUP,%Closest%.Diff_garage);
    Count_Diff_src_garage := COUNT(GROUP,%Closest%.Diff_src_garage);
    Count_Diff_tax_dt_garage := COUNT(GROUP,%Closest%.Diff_tax_dt_garage);
    Count_Diff_first_floor_square_footage := COUNT(GROUP,%Closest%.Diff_first_floor_square_footage);
    Count_Diff_src_first_floor_square_footage := COUNT(GROUP,%Closest%.Diff_src_first_floor_square_footage);
    Count_Diff_tax_dt_first_floor_square_footage := COUNT(GROUP,%Closest%.Diff_tax_dt_first_floor_square_footage);
    Count_Diff_heating := COUNT(GROUP,%Closest%.Diff_heating);
    Count_Diff_src_heating := COUNT(GROUP,%Closest%.Diff_src_heating);
    Count_Diff_tax_dt_heating := COUNT(GROUP,%Closest%.Diff_tax_dt_heating);
    Count_Diff_living_area_square_footage := COUNT(GROUP,%Closest%.Diff_living_area_square_footage);
    Count_Diff_src_living_area_square_footage := COUNT(GROUP,%Closest%.Diff_src_living_area_square_footage);
    Count_Diff_tax_dt_living_area_square_footage := COUNT(GROUP,%Closest%.Diff_tax_dt_living_area_square_footage);
    Count_Diff_no_of_baths := COUNT(GROUP,%Closest%.Diff_no_of_baths);
    Count_Diff_src_no_of_baths := COUNT(GROUP,%Closest%.Diff_src_no_of_baths);
    Count_Diff_tax_dt_no_of_baths := COUNT(GROUP,%Closest%.Diff_tax_dt_no_of_baths);
    Count_Diff_no_of_bedrooms := COUNT(GROUP,%Closest%.Diff_no_of_bedrooms);
    Count_Diff_src_no_of_bedrooms := COUNT(GROUP,%Closest%.Diff_src_no_of_bedrooms);
    Count_Diff_tax_dt_no_of_bedrooms := COUNT(GROUP,%Closest%.Diff_tax_dt_no_of_bedrooms);
    Count_Diff_no_of_fireplaces := COUNT(GROUP,%Closest%.Diff_no_of_fireplaces);
    Count_Diff_src_no_of_fireplaces := COUNT(GROUP,%Closest%.Diff_src_no_of_fireplaces);
    Count_Diff_tax_dt_no_of_fireplaces := COUNT(GROUP,%Closest%.Diff_tax_dt_no_of_fireplaces);
    Count_Diff_no_of_full_baths := COUNT(GROUP,%Closest%.Diff_no_of_full_baths);
    Count_Diff_src_no_of_full_baths := COUNT(GROUP,%Closest%.Diff_src_no_of_full_baths);
    Count_Diff_tax_dt_no_of_full_baths := COUNT(GROUP,%Closest%.Diff_tax_dt_no_of_full_baths);
    Count_Diff_no_of_half_baths := COUNT(GROUP,%Closest%.Diff_no_of_half_baths);
    Count_Diff_src_no_of_half_baths := COUNT(GROUP,%Closest%.Diff_src_no_of_half_baths);
    Count_Diff_tax_dt_no_of_half_baths := COUNT(GROUP,%Closest%.Diff_tax_dt_no_of_half_baths);
    Count_Diff_no_of_stories := COUNT(GROUP,%Closest%.Diff_no_of_stories);
    Count_Diff_src_no_of_stories := COUNT(GROUP,%Closest%.Diff_src_no_of_stories);
    Count_Diff_tax_dt_no_of_stories := COUNT(GROUP,%Closest%.Diff_tax_dt_no_of_stories);
    Count_Diff_parking_type := COUNT(GROUP,%Closest%.Diff_parking_type);
    Count_Diff_src_parking_type := COUNT(GROUP,%Closest%.Diff_src_parking_type);
    Count_Diff_tax_dt_parking_type := COUNT(GROUP,%Closest%.Diff_tax_dt_parking_type);
    Count_Diff_pool_indicator := COUNT(GROUP,%Closest%.Diff_pool_indicator);
    Count_Diff_src_pool_indicator := COUNT(GROUP,%Closest%.Diff_src_pool_indicator);
    Count_Diff_tax_dt_pool_indicator := COUNT(GROUP,%Closest%.Diff_tax_dt_pool_indicator);
    Count_Diff_pool_type := COUNT(GROUP,%Closest%.Diff_pool_type);
    Count_Diff_src_pool_type := COUNT(GROUP,%Closest%.Diff_src_pool_type);
    Count_Diff_tax_dt_pool_type := COUNT(GROUP,%Closest%.Diff_tax_dt_pool_type);
    Count_Diff_roof_cover := COUNT(GROUP,%Closest%.Diff_roof_cover);
    Count_Diff_src_roof_cover := COUNT(GROUP,%Closest%.Diff_src_roof_cover);
    Count_Diff_tax_dt_roof_cover := COUNT(GROUP,%Closest%.Diff_tax_dt_roof_cover);
    Count_Diff_year_built := COUNT(GROUP,%Closest%.Diff_year_built);
    Count_Diff_src_year_built := COUNT(GROUP,%Closest%.Diff_src_year_built);
    Count_Diff_tax_dt_year_built := COUNT(GROUP,%Closest%.Diff_tax_dt_year_built);
    Count_Diff_foundation := COUNT(GROUP,%Closest%.Diff_foundation);
    Count_Diff_src_foundation := COUNT(GROUP,%Closest%.Diff_src_foundation);
    Count_Diff_tax_dt_foundation := COUNT(GROUP,%Closest%.Diff_tax_dt_foundation);
    Count_Diff_basement_square_footage := COUNT(GROUP,%Closest%.Diff_basement_square_footage);
    Count_Diff_src_basement_square_footage := COUNT(GROUP,%Closest%.Diff_src_basement_square_footage);
    Count_Diff_tax_dt_basement_square_footage := COUNT(GROUP,%Closest%.Diff_tax_dt_basement_square_footage);
    Count_Diff_effective_year_built := COUNT(GROUP,%Closest%.Diff_effective_year_built);
    Count_Diff_src_effective_year_built := COUNT(GROUP,%Closest%.Diff_src_effective_year_built);
    Count_Diff_tax_dt_effective_year_built := COUNT(GROUP,%Closest%.Diff_tax_dt_effective_year_built);
    Count_Diff_garage_square_footage := COUNT(GROUP,%Closest%.Diff_garage_square_footage);
    Count_Diff_src_garage_square_footage := COUNT(GROUP,%Closest%.Diff_src_garage_square_footage);
    Count_Diff_tax_dt_garage_square_footage := COUNT(GROUP,%Closest%.Diff_tax_dt_garage_square_footage);
    Count_Diff_stories_type := COUNT(GROUP,%Closest%.Diff_stories_type);
    Count_Diff_src_stories_type := COUNT(GROUP,%Closest%.Diff_src_stories_type);
    Count_Diff_tax_dt_stories_type := COUNT(GROUP,%Closest%.Diff_tax_dt_stories_type);
    Count_Diff_apn_number := COUNT(GROUP,%Closest%.Diff_apn_number);
    Count_Diff_src_apn_number := COUNT(GROUP,%Closest%.Diff_src_apn_number);
    Count_Diff_tax_dt_apn_number := COUNT(GROUP,%Closest%.Diff_tax_dt_apn_number);
    Count_Diff_census_tract := COUNT(GROUP,%Closest%.Diff_census_tract);
    Count_Diff_src_census_tract := COUNT(GROUP,%Closest%.Diff_src_census_tract);
    Count_Diff_tax_dt_census_tract := COUNT(GROUP,%Closest%.Diff_tax_dt_census_tract);
    Count_Diff_range := COUNT(GROUP,%Closest%.Diff_range);
    Count_Diff_src_range := COUNT(GROUP,%Closest%.Diff_src_range);
    Count_Diff_tax_dt_range := COUNT(GROUP,%Closest%.Diff_tax_dt_range);
    Count_Diff_zoning := COUNT(GROUP,%Closest%.Diff_zoning);
    Count_Diff_src_zoning := COUNT(GROUP,%Closest%.Diff_src_zoning);
    Count_Diff_tax_dt_zoning := COUNT(GROUP,%Closest%.Diff_tax_dt_zoning);
    Count_Diff_block_number := COUNT(GROUP,%Closest%.Diff_block_number);
    Count_Diff_src_block_number := COUNT(GROUP,%Closest%.Diff_src_block_number);
    Count_Diff_tax_dt_block_number := COUNT(GROUP,%Closest%.Diff_tax_dt_block_number);
    Count_Diff_county_name := COUNT(GROUP,%Closest%.Diff_county_name);
    Count_Diff_src_county_name := COUNT(GROUP,%Closest%.Diff_src_county_name);
    Count_Diff_tax_dt_county_name := COUNT(GROUP,%Closest%.Diff_tax_dt_county_name);
    Count_Diff_fips_code := COUNT(GROUP,%Closest%.Diff_fips_code);
    Count_Diff_src_fips_code := COUNT(GROUP,%Closest%.Diff_src_fips_code);
    Count_Diff_tax_dt_fips_code := COUNT(GROUP,%Closest%.Diff_tax_dt_fips_code);
    Count_Diff_subdivision := COUNT(GROUP,%Closest%.Diff_subdivision);
    Count_Diff_src_subdivision := COUNT(GROUP,%Closest%.Diff_src_subdivision);
    Count_Diff_tax_dt_subdivision := COUNT(GROUP,%Closest%.Diff_tax_dt_subdivision);
    Count_Diff_municipality := COUNT(GROUP,%Closest%.Diff_municipality);
    Count_Diff_src_municipality := COUNT(GROUP,%Closest%.Diff_src_municipality);
    Count_Diff_tax_dt_municipality := COUNT(GROUP,%Closest%.Diff_tax_dt_municipality);
    Count_Diff_township := COUNT(GROUP,%Closest%.Diff_township);
    Count_Diff_src_township := COUNT(GROUP,%Closest%.Diff_src_township);
    Count_Diff_tax_dt_township := COUNT(GROUP,%Closest%.Diff_tax_dt_township);
    Count_Diff_homestead_exemption_ind := COUNT(GROUP,%Closest%.Diff_homestead_exemption_ind);
    Count_Diff_src_homestead_exemption_ind := COUNT(GROUP,%Closest%.Diff_src_homestead_exemption_ind);
    Count_Diff_tax_dt_homestead_exemption_ind := COUNT(GROUP,%Closest%.Diff_tax_dt_homestead_exemption_ind);
    Count_Diff_land_use_code := COUNT(GROUP,%Closest%.Diff_land_use_code);
    Count_Diff_src_land_use_code := COUNT(GROUP,%Closest%.Diff_src_land_use_code);
    Count_Diff_tax_dt_land_use_code := COUNT(GROUP,%Closest%.Diff_tax_dt_land_use_code);
    Count_Diff_latitude := COUNT(GROUP,%Closest%.Diff_latitude);
    Count_Diff_src_latitude := COUNT(GROUP,%Closest%.Diff_src_latitude);
    Count_Diff_tax_dt_latitude := COUNT(GROUP,%Closest%.Diff_tax_dt_latitude);
    Count_Diff_longitude := COUNT(GROUP,%Closest%.Diff_longitude);
    Count_Diff_src_longitude := COUNT(GROUP,%Closest%.Diff_src_longitude);
    Count_Diff_tax_dt_longitude := COUNT(GROUP,%Closest%.Diff_tax_dt_longitude);
    Count_Diff_location_influence_code := COUNT(GROUP,%Closest%.Diff_location_influence_code);
    Count_Diff_src_location_influence_code := COUNT(GROUP,%Closest%.Diff_src_location_influence_code);
    Count_Diff_tax_dt_location_influence_code := COUNT(GROUP,%Closest%.Diff_tax_dt_location_influence_code);
    Count_Diff_acres := COUNT(GROUP,%Closest%.Diff_acres);
    Count_Diff_src_acres := COUNT(GROUP,%Closest%.Diff_src_acres);
    Count_Diff_tax_dt_acres := COUNT(GROUP,%Closest%.Diff_tax_dt_acres);
    Count_Diff_lot_depth_footage := COUNT(GROUP,%Closest%.Diff_lot_depth_footage);
    Count_Diff_src_lot_depth_footage := COUNT(GROUP,%Closest%.Diff_src_lot_depth_footage);
    Count_Diff_tax_dt_lot_depth_footage := COUNT(GROUP,%Closest%.Diff_tax_dt_lot_depth_footage);
    Count_Diff_lot_front_footage := COUNT(GROUP,%Closest%.Diff_lot_front_footage);
    Count_Diff_src_lot_front_footage := COUNT(GROUP,%Closest%.Diff_src_lot_front_footage);
    Count_Diff_tax_dt_lot_front_footage := COUNT(GROUP,%Closest%.Diff_tax_dt_lot_front_footage);
    Count_Diff_lot_number := COUNT(GROUP,%Closest%.Diff_lot_number);
    Count_Diff_src_lot_number := COUNT(GROUP,%Closest%.Diff_src_lot_number);
    Count_Diff_tax_dt_lot_number := COUNT(GROUP,%Closest%.Diff_tax_dt_lot_number);
    Count_Diff_lot_size := COUNT(GROUP,%Closest%.Diff_lot_size);
    Count_Diff_src_lot_size := COUNT(GROUP,%Closest%.Diff_src_lot_size);
    Count_Diff_tax_dt_lot_size := COUNT(GROUP,%Closest%.Diff_tax_dt_lot_size);
    Count_Diff_property_type_code := COUNT(GROUP,%Closest%.Diff_property_type_code);
    Count_Diff_src_property_type_code := COUNT(GROUP,%Closest%.Diff_src_property_type_code);
    Count_Diff_tax_dt_property_type_code := COUNT(GROUP,%Closest%.Diff_tax_dt_property_type_code);
    Count_Diff_structure_quality := COUNT(GROUP,%Closest%.Diff_structure_quality);
    Count_Diff_src_structure_quality := COUNT(GROUP,%Closest%.Diff_src_structure_quality);
    Count_Diff_tax_dt_structure_quality := COUNT(GROUP,%Closest%.Diff_tax_dt_structure_quality);
    Count_Diff_water := COUNT(GROUP,%Closest%.Diff_water);
    Count_Diff_src_water := COUNT(GROUP,%Closest%.Diff_src_water);
    Count_Diff_tax_dt_water := COUNT(GROUP,%Closest%.Diff_tax_dt_water);
    Count_Diff_sewer := COUNT(GROUP,%Closest%.Diff_sewer);
    Count_Diff_src_sewer := COUNT(GROUP,%Closest%.Diff_src_sewer);
    Count_Diff_tax_dt_sewer := COUNT(GROUP,%Closest%.Diff_tax_dt_sewer);
    Count_Diff_assessed_land_value := COUNT(GROUP,%Closest%.Diff_assessed_land_value);
    Count_Diff_src_assessed_land_value := COUNT(GROUP,%Closest%.Diff_src_assessed_land_value);
    Count_Diff_tax_dt_assessed_land_value := COUNT(GROUP,%Closest%.Diff_tax_dt_assessed_land_value);
    Count_Diff_assessed_year := COUNT(GROUP,%Closest%.Diff_assessed_year);
    Count_Diff_src_assessed_year := COUNT(GROUP,%Closest%.Diff_src_assessed_year);
    Count_Diff_tax_dt_assessed_year := COUNT(GROUP,%Closest%.Diff_tax_dt_assessed_year);
    Count_Diff_tax_amount := COUNT(GROUP,%Closest%.Diff_tax_amount);
    Count_Diff_src_tax_amount := COUNT(GROUP,%Closest%.Diff_src_tax_amount);
    Count_Diff_tax_dt_tax_amount := COUNT(GROUP,%Closest%.Diff_tax_dt_tax_amount);
    Count_Diff_tax_year := COUNT(GROUP,%Closest%.Diff_tax_year);
    Count_Diff_src_tax_year := COUNT(GROUP,%Closest%.Diff_src_tax_year);
    Count_Diff_market_land_value := COUNT(GROUP,%Closest%.Diff_market_land_value);
    Count_Diff_src_market_land_value := COUNT(GROUP,%Closest%.Diff_src_market_land_value);
    Count_Diff_tax_dt_market_land_value := COUNT(GROUP,%Closest%.Diff_tax_dt_market_land_value);
    Count_Diff_improvement_value := COUNT(GROUP,%Closest%.Diff_improvement_value);
    Count_Diff_src_improvement_value := COUNT(GROUP,%Closest%.Diff_src_improvement_value);
    Count_Diff_tax_dt_improvement_value := COUNT(GROUP,%Closest%.Diff_tax_dt_improvement_value);
    Count_Diff_percent_improved := COUNT(GROUP,%Closest%.Diff_percent_improved);
    Count_Diff_src_percent_improved := COUNT(GROUP,%Closest%.Diff_src_percent_improved);
    Count_Diff_tax_dt_percent_improved := COUNT(GROUP,%Closest%.Diff_tax_dt_percent_improved);
    Count_Diff_total_assessed_value := COUNT(GROUP,%Closest%.Diff_total_assessed_value);
    Count_Diff_src_total_assessed_value := COUNT(GROUP,%Closest%.Diff_src_total_assessed_value);
    Count_Diff_tax_dt_total_assessed_value := COUNT(GROUP,%Closest%.Diff_tax_dt_total_assessed_value);
    Count_Diff_total_calculated_value := COUNT(GROUP,%Closest%.Diff_total_calculated_value);
    Count_Diff_src_total_calculated_value := COUNT(GROUP,%Closest%.Diff_src_total_calculated_value);
    Count_Diff_tax_dt_total_calculated_value := COUNT(GROUP,%Closest%.Diff_tax_dt_total_calculated_value);
    Count_Diff_total_land_value := COUNT(GROUP,%Closest%.Diff_total_land_value);
    Count_Diff_src_total_land_value := COUNT(GROUP,%Closest%.Diff_src_total_land_value);
    Count_Diff_tax_dt_total_land_value := COUNT(GROUP,%Closest%.Diff_tax_dt_total_land_value);
    Count_Diff_total_market_value := COUNT(GROUP,%Closest%.Diff_total_market_value);
    Count_Diff_src_total_market_value := COUNT(GROUP,%Closest%.Diff_src_total_market_value);
    Count_Diff_tax_dt_total_market_value := COUNT(GROUP,%Closest%.Diff_tax_dt_total_market_value);
    Count_Diff_floor_type := COUNT(GROUP,%Closest%.Diff_floor_type);
    Count_Diff_src_floor_type := COUNT(GROUP,%Closest%.Diff_src_floor_type);
    Count_Diff_tax_dt_floor_type := COUNT(GROUP,%Closest%.Diff_tax_dt_floor_type);
    Count_Diff_frame_type := COUNT(GROUP,%Closest%.Diff_frame_type);
    Count_Diff_src_frame_type := COUNT(GROUP,%Closest%.Diff_src_frame_type);
    Count_Diff_tax_dt_frame_type := COUNT(GROUP,%Closest%.Diff_tax_dt_frame_type);
    Count_Diff_fuel_type := COUNT(GROUP,%Closest%.Diff_fuel_type);
    Count_Diff_src_fuel_type := COUNT(GROUP,%Closest%.Diff_src_fuel_type);
    Count_Diff_tax_dt_fuel_type := COUNT(GROUP,%Closest%.Diff_tax_dt_fuel_type);
    Count_Diff_no_of_bath_fixtures := COUNT(GROUP,%Closest%.Diff_no_of_bath_fixtures);
    Count_Diff_src_no_of_bath_fixtures := COUNT(GROUP,%Closest%.Diff_src_no_of_bath_fixtures);
    Count_Diff_tax_dt_no_of_bath_fixtures := COUNT(GROUP,%Closest%.Diff_tax_dt_no_of_bath_fixtures);
    Count_Diff_no_of_rooms := COUNT(GROUP,%Closest%.Diff_no_of_rooms);
    Count_Diff_src_no_of_rooms := COUNT(GROUP,%Closest%.Diff_src_no_of_rooms);
    Count_Diff_tax_dt_no_of_rooms := COUNT(GROUP,%Closest%.Diff_tax_dt_no_of_rooms);
    Count_Diff_no_of_units := COUNT(GROUP,%Closest%.Diff_no_of_units);
    Count_Diff_src_no_of_units := COUNT(GROUP,%Closest%.Diff_src_no_of_units);
    Count_Diff_tax_dt_no_of_units := COUNT(GROUP,%Closest%.Diff_tax_dt_no_of_units);
    Count_Diff_style_type := COUNT(GROUP,%Closest%.Diff_style_type);
    Count_Diff_src_style_type := COUNT(GROUP,%Closest%.Diff_src_style_type);
    Count_Diff_tax_dt_style_type := COUNT(GROUP,%Closest%.Diff_tax_dt_style_type);
    Count_Diff_assessment_document_number := COUNT(GROUP,%Closest%.Diff_assessment_document_number);
    Count_Diff_src_assessment_document_number := COUNT(GROUP,%Closest%.Diff_src_assessment_document_number);
    Count_Diff_tax_dt_assessment_document_number := COUNT(GROUP,%Closest%.Diff_tax_dt_assessment_document_number);
    Count_Diff_assessment_recording_date := COUNT(GROUP,%Closest%.Diff_assessment_recording_date);
    Count_Diff_src_assessment_recording_date := COUNT(GROUP,%Closest%.Diff_src_assessment_recording_date);
    Count_Diff_tax_dt_assessment_recording_date := COUNT(GROUP,%Closest%.Diff_tax_dt_assessment_recording_date);
    Count_Diff_deed_document_number := COUNT(GROUP,%Closest%.Diff_deed_document_number);
    Count_Diff_src_deed_document_number := COUNT(GROUP,%Closest%.Diff_src_deed_document_number);
    Count_Diff_rec_dt_deed_document_number := COUNT(GROUP,%Closest%.Diff_rec_dt_deed_document_number);
    Count_Diff_deed_recording_date := COUNT(GROUP,%Closest%.Diff_deed_recording_date);
    Count_Diff_src_deed_recording_date := COUNT(GROUP,%Closest%.Diff_src_deed_recording_date);
    Count_Diff_full_part_sale := COUNT(GROUP,%Closest%.Diff_full_part_sale);
    Count_Diff_src_full_part_sale := COUNT(GROUP,%Closest%.Diff_src_full_part_sale);
    Count_Diff_rec_dt_full_part_sale := COUNT(GROUP,%Closest%.Diff_rec_dt_full_part_sale);
    Count_Diff_sale_amount := COUNT(GROUP,%Closest%.Diff_sale_amount);
    Count_Diff_src_sale_amount := COUNT(GROUP,%Closest%.Diff_src_sale_amount);
    Count_Diff_rec_dt_sale_amount := COUNT(GROUP,%Closest%.Diff_rec_dt_sale_amount);
    Count_Diff_sale_date := COUNT(GROUP,%Closest%.Diff_sale_date);
    Count_Diff_src_sale_date := COUNT(GROUP,%Closest%.Diff_src_sale_date);
    Count_Diff_rec_dt_sale_date := COUNT(GROUP,%Closest%.Diff_rec_dt_sale_date);
    Count_Diff_sale_type_code := COUNT(GROUP,%Closest%.Diff_sale_type_code);
    Count_Diff_src_sale_type_code := COUNT(GROUP,%Closest%.Diff_src_sale_type_code);
    Count_Diff_rec_dt_sale_type_code := COUNT(GROUP,%Closest%.Diff_rec_dt_sale_type_code);
    Count_Diff_mortgage_company_name := COUNT(GROUP,%Closest%.Diff_mortgage_company_name);
    Count_Diff_src_mortgage_company_name := COUNT(GROUP,%Closest%.Diff_src_mortgage_company_name);
    Count_Diff_rec_dt_mortgage_company_name := COUNT(GROUP,%Closest%.Diff_rec_dt_mortgage_company_name);
    Count_Diff_loan_amount := COUNT(GROUP,%Closest%.Diff_loan_amount);
    Count_Diff_src_loan_amount := COUNT(GROUP,%Closest%.Diff_src_loan_amount);
    Count_Diff_rec_dt_loan_amount := COUNT(GROUP,%Closest%.Diff_rec_dt_loan_amount);
    Count_Diff_second_loan_amount := COUNT(GROUP,%Closest%.Diff_second_loan_amount);
    Count_Diff_src_second_loan_amount := COUNT(GROUP,%Closest%.Diff_src_second_loan_amount);
    Count_Diff_rec_dt_second_loan_amount := COUNT(GROUP,%Closest%.Diff_rec_dt_second_loan_amount);
    Count_Diff_loan_type_code := COUNT(GROUP,%Closest%.Diff_loan_type_code);
    Count_Diff_src_loan_type_code := COUNT(GROUP,%Closest%.Diff_src_loan_type_code);
    Count_Diff_rec_dt_loan_type_code := COUNT(GROUP,%Closest%.Diff_rec_dt_loan_type_code);
    Count_Diff_interest_rate_type_code := COUNT(GROUP,%Closest%.Diff_interest_rate_type_code);
    Count_Diff_src_interest_rate_type_code := COUNT(GROUP,%Closest%.Diff_src_interest_rate_type_code);
    Count_Diff_rec_dt_interest_rate_type_code := COUNT(GROUP,%Closest%.Diff_rec_dt_interest_rate_type_code);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;

IMPORT SALT37;
IMPORT Scrubs_FBNV2,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_CA_Orange_Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT37.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_name','invalid_legal_name','invalid_mandatory','invalid_zero_integer','invalid_record_type','invalid_numeric','invalid_numeric_or_blank','invalid_percentage','invalid_direction','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dbpc','invalid_chk_digit','invalid_rec_type','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_cbsa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','invalid_raw_aid','invalid_ace_aid','invalid_st','invalid_zip5','invalid_zip4','invalid_bus_name','invalid_long_bus_name','invalid_bus_status','invalid_filing_type','invalid_seq_no','invalid_bus_type_desc','invalid_alpha_neg_num','invalid_alpha','invalid_alphanum','invalid_phone','invalid_sic','invalid_naics','invalid_address_type_code','invalid_norm_type','invalid_email','invalid_yes_blank','invalid_business_size','invalid_cert_or_class','invalid_current_future_date','invalid_current_past_date','invalid_future_date','invalid_general_date','invalid_past_date','invalid_year_established','invalid_contact_type','invalid_contact_name_format');
EXPORT FieldTypeNum(SALT37.StrType fn) := CASE(fn,'invalid_name' => 1,'invalid_legal_name' => 2,'invalid_mandatory' => 3,'invalid_zero_integer' => 4,'invalid_record_type' => 5,'invalid_numeric' => 6,'invalid_numeric_or_blank' => 7,'invalid_percentage' => 8,'invalid_direction' => 9,'invalid_cart' => 10,'invalid_cr_sort_sz' => 11,'invalid_lot' => 12,'invalid_lot_order' => 13,'invalid_dbpc' => 14,'invalid_chk_digit' => 15,'invalid_rec_type' => 16,'invalid_fips_state' => 17,'invalid_fips_county' => 18,'invalid_geo' => 19,'invalid_cbsa' => 20,'invalid_geo_blk' => 21,'invalid_geo_match' => 22,'invalid_err_stat' => 23,'invalid_raw_aid' => 24,'invalid_ace_aid' => 25,'invalid_st' => 26,'invalid_zip5' => 27,'invalid_zip4' => 28,'invalid_bus_name' => 29,'invalid_long_bus_name' => 30,'invalid_bus_status' => 31,'invalid_filing_type' => 32,'invalid_seq_no' => 33,'invalid_bus_type_desc' => 34,'invalid_alpha_neg_num' => 35,'invalid_alpha' => 36,'invalid_alphanum' => 37,'invalid_phone' => 38,'invalid_sic' => 39,'invalid_naics' => 40,'invalid_address_type_code' => 41,'invalid_norm_type' => 42,'invalid_email' => 43,'invalid_yes_blank' => 44,'invalid_business_size' => 45,'invalid_cert_or_class' => 46,'invalid_current_future_date' => 47,'invalid_current_past_date' => 48,'invalid_future_date' => 49,'invalid_general_date' => 50,'invalid_past_date' => 51,'invalid_year_established' => 52,'invalid_contact_type' => 53,'invalid_contact_name_format' => 54,0);
 
EXPORT MakeFT_invalid_name(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_invalid_name(s)>0);
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_invalid_name'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_legal_name(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_legal_name(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_invalid_legal_name(s)>0);
EXPORT InValidMessageFT_invalid_legal_name(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_invalid_legal_name'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT37.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLength('1..'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zero_integer(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zero_integer(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['0','']);
EXPORT InValidMessageFT_invalid_zero_integer(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('0|'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['C','H']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('C|H'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_or_blank(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric_or_blank(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_numeric_or_blank(s)>0);
EXPORT InValidMessageFT_invalid_numeric_or_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_numeric_or_blank'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_percentage(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_percentage(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_range_numeric(s,0,100)>0);
EXPORT InValidMessageFT_invalid_percentage(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_range_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_direction(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_direction(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['E','N','S','W','NE','NW','SE','SW','']);
EXPORT InValidMessageFT_invalid_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('E|N|S|W|NE|NW|SE|SW|'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cart(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cart(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_alphanum(s,4)>0);
EXPORT InValidMessageFT_invalid_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_alphanum'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cr_sort_sz(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cr_sort_sz(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['A','B','C','D','']);
EXPORT InValidMessageFT_invalid_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('A|B|C|D|'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot_order(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot_order(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['A','D','']);
EXPORT InValidMessageFT_invalid_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('A|D|'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dbpc(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dbpc(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_dbpc(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_chk_digit(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_chk_digit(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_rec_type(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rec_type(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_addr_rec_type(s)>0);
EXPORT InValidMessageFT_invalid_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_addr_rec_type'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_state(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_state(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_fips_state(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_county(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_county(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_numeric(s,3)>0);
EXPORT InValidMessageFT_invalid_fips_county(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'-.0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_geo(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'-.0123456789'))));
EXPORT InValidMessageFT_invalid_geo(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('-.0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cbsa(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cbsa(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_cbsa(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_blk(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo_blk(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_numeric(s,7)>0);
EXPORT InValidMessageFT_invalid_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_match(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo_match(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_err_stat(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_err_stat(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_alphanum(s,4)>0);
EXPORT InValidMessageFT_invalid_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_alphanum'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_raw_aid(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_raw_aid(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_range_numeric(s,10000000000,999999999999)>0);
EXPORT InValidMessageFT_invalid_raw_aid(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_range_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ace_aid(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ace_aid(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_numeric(s,12)>0);
EXPORT InValidMessageFT_invalid_ace_aid(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_st(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_verify_state'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip4(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_verify_zip4(s)>0);
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_verify_zip4'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bus_name(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' #&\'(),-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZaeino'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_bus_name(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' #&\'(),-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZaeino'))));
EXPORT InValidMessageFT_invalid_bus_name(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' #&\'(),-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZaeino'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_long_bus_name(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' #&\',-./0123459ABCDEFGHIJKLMNOPQRSTUVWXYZacdeghilmnoprstuy'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_long_bus_name(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' #&\',-./0123459ABCDEFGHIJKLMNOPQRSTUVWXYZacdeghilmnoprstuy'))));
EXPORT InValidMessageFT_invalid_long_bus_name(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' #&\',-./0123459ABCDEFGHIJKLMNOPQRSTUVWXYZacdeghilmnoprstuy'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bus_status(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bus_status(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['CURRENT','NEW','RENEWAL',' ']);
EXPORT InValidMessageFT_invalid_bus_status(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('CURRENT|NEW|RENEWAL| '),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_filing_type(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_filing_type(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['BUSINESS LICENSE','TRADENAMETYPE(STRING):0,0 CORPORATION','ASSUMED NAME','DBA','FICTITIOUS NAME']);
EXPORT InValidMessageFT_invalid_filing_type(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('BUSINESS LICENSE|TRADENAMETYPE(STRING):0,0 CORPORATION|ASSUMED NAME|DBA|FICTITIOUS NAME'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_seq_no(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' 01234'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_seq_no(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' 01234'))));
EXPORT InValidMessageFT_invalid_seq_no(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' 01234'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bus_type_desc(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' &\'(),-./0123459ABCDEFGHIJKLMNOPQRSTUVWXYZacehilmnorstu'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_bus_type_desc(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' &\'(),-./0123459ABCDEFGHIJKLMNOPQRSTUVWXYZacehilmnorstu'))));
EXPORT InValidMessageFT_invalid_bus_type_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' &\'(),-./0123459ABCDEFGHIJKLMNOPQRSTUVWXYZacehilmnorstu'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_neg_num(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' -0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_neg_num(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' -0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alpha_neg_num(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' -0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanum(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanum(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alphanum(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_verify_optional_phone'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_sic(s)>0);
EXPORT InValidMessageFT_invalid_sic(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_sic'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_naics(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_naics(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_naics(s)>0);
EXPORT InValidMessageFT_invalid_naics(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_naics'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address_type_code(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_address_type_code(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['P','M']);
EXPORT InValidMessageFT_invalid_address_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('P|M'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_norm_type(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_norm_type(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['D','L']);
EXPORT InValidMessageFT_invalid_norm_type(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('D|L'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,TYPE(STRING):0,0\'&'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_email(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,TYPE(STRING):0,0\'&'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,TYPE(STRING):0,0\'&'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_yes_blank(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_yes_blank(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['Y',' ']);
EXPORT InValidMessageFT_invalid_yes_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('Y| '),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_business_size(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_business_size(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['L','S','X']);
EXPORT InValidMessageFT_invalid_business_size(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('L|S|X'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cert_or_class(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cert_or_class(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['Certified','Classified','CERTIFIED','CLASSIFIED','CLASSIFICATION','CERTIFICATION','Classification','Certification','SELF-CLASSIFIED/NON VERIFIED',' ']);
EXPORT InValidMessageFT_invalid_cert_or_class(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('Certified|Classified|CERTIFIED|CLASSIFIED|CLASSIFICATION|CERTIFICATION|Classification|Certification|SELF-CLASSIFIED/NON VERIFIED| '),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_current_future_date(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_current_future_date(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_current_future_date(s)>0);
EXPORT InValidMessageFT_invalid_current_future_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_current_future_date'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_current_past_date(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_current_past_date(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_current_past_date(s)>0);
EXPORT InValidMessageFT_invalid_current_past_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_current_past_date'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_future_date(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_future_date(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_future_date(s)>0);
EXPORT InValidMessageFT_invalid_future_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_future_date'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_general_date(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_general_date(SALT37.StrType s) := WHICH(~Scrubs.fn_valid_generalDate(s)>0);
EXPORT InValidMessageFT_invalid_general_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs.fn_valid_generalDate'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_past_date(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_past_date(SALT37.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0);
EXPORT InValidMessageFT_invalid_past_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_year_established(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_year_established(SALT37.StrType s) := WHICH(~Scrubs_FBNV2.Functions.fn_valid_year_established(s)>0);
EXPORT InValidMessageFT_invalid_year_established(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_FBNV2.Functions.fn_valid_year_established'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_contact_type(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_contact_type(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['C','O']);
EXPORT InValidMessageFT_invalid_contact_type(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('C|O'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_contact_name_format(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_contact_name_format(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['C','P']);
EXPORT InValidMessageFT_invalid_contact_name_format(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('C|P'),SALT37.HygieneErrors.Good);
 
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'business_name','file_date','regis_nbr','prep_bus_addr_line1','prep_bus_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','cname','first_name','middle_name','last_name_company','owner_address','phone_nbr','BUSINESS_LETTER','ADDRESS','CITY','STATE','ZIP_CODE','DOCETYEP','OWNER_NBR','OWNER_CITY','OWNER_STATE','OWNER_ZIP_CODE','BUSINESS_TYPE','title','fname','mname','lname','name_suffix','name_score');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'business_name' => 0,'file_date' => 1,'regis_nbr' => 2,'prep_bus_addr_line1' => 3,'prep_bus_addr_line_last' => 4,'prep_owner_addr_line1' => 5,'prep_owner_addr_line_last' => 6,'cname' => 7,'first_name' => 8,'middle_name' => 9,'last_name_company' => 10,'owner_address' => 11,'phone_nbr' => 12,'BUSINESS_LETTER' => 13,'ADDRESS' => 14,'CITY' => 15,'STATE' => 16,'ZIP_CODE' => 17,'DOCETYEP' => 18,'OWNER_NBR' => 19,'OWNER_CITY' => 20,'OWNER_STATE' => 21,'OWNER_ZIP_CODE' => 22,'BUSINESS_TYPE' => 23,'title' => 24,'fname' => 25,'mname' => 26,'lname' => 27,'name_suffix' => 28,'name_score' => 29,0);
 
//Individual field level validation
 
EXPORT Make_business_name(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_business_name(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_business_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_file_date(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_file_date(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_file_date(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_regis_nbr(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_regis_nbr(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_regis_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_bus_addr_line1(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_bus_addr_line1(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_bus_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_bus_addr_line_last(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_bus_addr_line_last(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_bus_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_owner_addr_line1(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_owner_addr_line1(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_owner_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_owner_addr_line_last(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_owner_addr_line_last(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_owner_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_cname(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_cname(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_cname(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_first_name(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_first_name(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_middle_name(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_middle_name(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_middle_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_last_name_company(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_last_name_company(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_last_name_company(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_owner_address(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_owner_address(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_owner_address(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_phone_nbr(SALT37.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone_nbr(SALT37.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_BUSINESS_LETTER(SALT37.StrType s0) := s0;
EXPORT InValid_BUSINESS_LETTER(SALT37.StrType s) := 0;
EXPORT InValidMessage_BUSINESS_LETTER(UNSIGNED1 wh) := '';
 
EXPORT Make_ADDRESS(SALT37.StrType s0) := s0;
EXPORT InValid_ADDRESS(SALT37.StrType s) := 0;
EXPORT InValidMessage_ADDRESS(UNSIGNED1 wh) := '';
 
EXPORT Make_CITY(SALT37.StrType s0) := s0;
EXPORT InValid_CITY(SALT37.StrType s) := 0;
EXPORT InValidMessage_CITY(UNSIGNED1 wh) := '';
 
EXPORT Make_STATE(SALT37.StrType s0) := s0;
EXPORT InValid_STATE(SALT37.StrType s) := 0;
EXPORT InValidMessage_STATE(UNSIGNED1 wh) := '';
 
EXPORT Make_ZIP_CODE(SALT37.StrType s0) := s0;
EXPORT InValid_ZIP_CODE(SALT37.StrType s) := 0;
EXPORT InValidMessage_ZIP_CODE(UNSIGNED1 wh) := '';
 
EXPORT Make_DOCETYEP(SALT37.StrType s0) := s0;
EXPORT InValid_DOCETYEP(SALT37.StrType s) := 0;
EXPORT InValidMessage_DOCETYEP(UNSIGNED1 wh) := '';
 
EXPORT Make_OWNER_NBR(SALT37.StrType s0) := s0;
EXPORT InValid_OWNER_NBR(SALT37.StrType s) := 0;
EXPORT InValidMessage_OWNER_NBR(UNSIGNED1 wh) := '';
 
EXPORT Make_OWNER_CITY(SALT37.StrType s0) := s0;
EXPORT InValid_OWNER_CITY(SALT37.StrType s) := 0;
EXPORT InValidMessage_OWNER_CITY(UNSIGNED1 wh) := '';
 
EXPORT Make_OWNER_STATE(SALT37.StrType s0) := s0;
EXPORT InValid_OWNER_STATE(SALT37.StrType s) := 0;
EXPORT InValidMessage_OWNER_STATE(UNSIGNED1 wh) := '';
 
EXPORT Make_OWNER_ZIP_CODE(SALT37.StrType s0) := s0;
EXPORT InValid_OWNER_ZIP_CODE(SALT37.StrType s) := 0;
EXPORT InValidMessage_OWNER_ZIP_CODE(UNSIGNED1 wh) := '';
 
EXPORT Make_BUSINESS_TYPE(SALT37.StrType s0) := s0;
EXPORT InValid_BUSINESS_TYPE(SALT37.StrType s) := 0;
EXPORT InValidMessage_BUSINESS_TYPE(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT37.StrType s0) := s0;
EXPORT InValid_title(SALT37.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT37.StrType s0) := s0;
EXPORT InValid_fname(SALT37.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT37.StrType s0) := s0;
EXPORT InValid_mname(SALT37.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT37.StrType s0) := s0;
EXPORT InValid_lname(SALT37.StrType s) := 0;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_name_suffix(SALT37.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT37.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_name_score(SALT37.StrType s0) := s0;
EXPORT InValid_name_score(SALT37.StrType s) := 0;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT37,Scrubs_FBNV2;
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
    BOOLEAN Diff_business_name;
    BOOLEAN Diff_file_date;
    BOOLEAN Diff_regis_nbr;
    BOOLEAN Diff_prep_bus_addr_line1;
    BOOLEAN Diff_prep_bus_addr_line_last;
    BOOLEAN Diff_prep_owner_addr_line1;
    BOOLEAN Diff_prep_owner_addr_line_last;
    BOOLEAN Diff_cname;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_middle_name;
    BOOLEAN Diff_last_name_company;
    BOOLEAN Diff_owner_address;
    BOOLEAN Diff_phone_nbr;
    BOOLEAN Diff_BUSINESS_LETTER;
    BOOLEAN Diff_ADDRESS;
    BOOLEAN Diff_CITY;
    BOOLEAN Diff_STATE;
    BOOLEAN Diff_ZIP_CODE;
    BOOLEAN Diff_DOCETYEP;
    BOOLEAN Diff_OWNER_NBR;
    BOOLEAN Diff_OWNER_CITY;
    BOOLEAN Diff_OWNER_STATE;
    BOOLEAN Diff_OWNER_ZIP_CODE;
    BOOLEAN Diff_BUSINESS_TYPE;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
    UNSIGNED Num_Diffs;
    SALT37.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_business_name := le.business_name <> ri.business_name;
    SELF.Diff_file_date := le.file_date <> ri.file_date;
    SELF.Diff_regis_nbr := le.regis_nbr <> ri.regis_nbr;
    SELF.Diff_prep_bus_addr_line1 := le.prep_bus_addr_line1 <> ri.prep_bus_addr_line1;
    SELF.Diff_prep_bus_addr_line_last := le.prep_bus_addr_line_last <> ri.prep_bus_addr_line_last;
    SELF.Diff_prep_owner_addr_line1 := le.prep_owner_addr_line1 <> ri.prep_owner_addr_line1;
    SELF.Diff_prep_owner_addr_line_last := le.prep_owner_addr_line_last <> ri.prep_owner_addr_line_last;
    SELF.Diff_cname := le.cname <> ri.cname;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_middle_name := le.middle_name <> ri.middle_name;
    SELF.Diff_last_name_company := le.last_name_company <> ri.last_name_company;
    SELF.Diff_owner_address := le.owner_address <> ri.owner_address;
    SELF.Diff_phone_nbr := le.phone_nbr <> ri.phone_nbr;
    SELF.Diff_BUSINESS_LETTER := le.BUSINESS_LETTER <> ri.BUSINESS_LETTER;
    SELF.Diff_ADDRESS := le.ADDRESS <> ri.ADDRESS;
    SELF.Diff_CITY := le.CITY <> ri.CITY;
    SELF.Diff_STATE := le.STATE <> ri.STATE;
    SELF.Diff_ZIP_CODE := le.ZIP_CODE <> ri.ZIP_CODE;
    SELF.Diff_DOCETYEP := le.DOCETYEP <> ri.DOCETYEP;
    SELF.Diff_OWNER_NBR := le.OWNER_NBR <> ri.OWNER_NBR;
    SELF.Diff_OWNER_CITY := le.OWNER_CITY <> ri.OWNER_CITY;
    SELF.Diff_OWNER_STATE := le.OWNER_STATE <> ri.OWNER_STATE;
    SELF.Diff_OWNER_ZIP_CODE := le.OWNER_ZIP_CODE <> ri.OWNER_ZIP_CODE;
    SELF.Diff_BUSINESS_TYPE := le.BUSINESS_TYPE <> ri.BUSINESS_TYPE;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_business_name,1,0)+ IF( SELF.Diff_file_date,1,0)+ IF( SELF.Diff_regis_nbr,1,0)+ IF( SELF.Diff_prep_bus_addr_line1,1,0)+ IF( SELF.Diff_prep_bus_addr_line_last,1,0)+ IF( SELF.Diff_prep_owner_addr_line1,1,0)+ IF( SELF.Diff_prep_owner_addr_line_last,1,0)+ IF( SELF.Diff_cname,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_middle_name,1,0)+ IF( SELF.Diff_last_name_company,1,0)+ IF( SELF.Diff_owner_address,1,0)+ IF( SELF.Diff_phone_nbr,1,0)+ IF( SELF.Diff_BUSINESS_LETTER,1,0)+ IF( SELF.Diff_ADDRESS,1,0)+ IF( SELF.Diff_CITY,1,0)+ IF( SELF.Diff_STATE,1,0)+ IF( SELF.Diff_ZIP_CODE,1,0)+ IF( SELF.Diff_DOCETYEP,1,0)+ IF( SELF.Diff_OWNER_NBR,1,0)+ IF( SELF.Diff_OWNER_CITY,1,0)+ IF( SELF.Diff_OWNER_STATE,1,0)+ IF( SELF.Diff_OWNER_ZIP_CODE,1,0)+ IF( SELF.Diff_BUSINESS_TYPE,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0);
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
    Count_Diff_business_name := COUNT(GROUP,%Closest%.Diff_business_name);
    Count_Diff_file_date := COUNT(GROUP,%Closest%.Diff_file_date);
    Count_Diff_regis_nbr := COUNT(GROUP,%Closest%.Diff_regis_nbr);
    Count_Diff_prep_bus_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_bus_addr_line1);
    Count_Diff_prep_bus_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_bus_addr_line_last);
    Count_Diff_prep_owner_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_owner_addr_line1);
    Count_Diff_prep_owner_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_owner_addr_line_last);
    Count_Diff_cname := COUNT(GROUP,%Closest%.Diff_cname);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_middle_name := COUNT(GROUP,%Closest%.Diff_middle_name);
    Count_Diff_last_name_company := COUNT(GROUP,%Closest%.Diff_last_name_company);
    Count_Diff_owner_address := COUNT(GROUP,%Closest%.Diff_owner_address);
    Count_Diff_phone_nbr := COUNT(GROUP,%Closest%.Diff_phone_nbr);
    Count_Diff_BUSINESS_LETTER := COUNT(GROUP,%Closest%.Diff_BUSINESS_LETTER);
    Count_Diff_ADDRESS := COUNT(GROUP,%Closest%.Diff_ADDRESS);
    Count_Diff_CITY := COUNT(GROUP,%Closest%.Diff_CITY);
    Count_Diff_STATE := COUNT(GROUP,%Closest%.Diff_STATE);
    Count_Diff_ZIP_CODE := COUNT(GROUP,%Closest%.Diff_ZIP_CODE);
    Count_Diff_DOCETYEP := COUNT(GROUP,%Closest%.Diff_DOCETYEP);
    Count_Diff_OWNER_NBR := COUNT(GROUP,%Closest%.Diff_OWNER_NBR);
    Count_Diff_OWNER_CITY := COUNT(GROUP,%Closest%.Diff_OWNER_CITY);
    Count_Diff_OWNER_STATE := COUNT(GROUP,%Closest%.Diff_OWNER_STATE);
    Count_Diff_OWNER_ZIP_CODE := COUNT(GROUP,%Closest%.Diff_OWNER_ZIP_CODE);
    Count_Diff_BUSINESS_TYPE := COUNT(GROUP,%Closest%.Diff_BUSINESS_TYPE);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

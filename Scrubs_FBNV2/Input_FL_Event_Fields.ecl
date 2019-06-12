IMPORT SALT37;
IMPORT Scrubs_FBNV2,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_FL_Event_Fields := MODULE
 
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
EXPORT InValidFT_invalid_filing_type(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['BUSINESS LICENSE','TRADENAME:TYPE(STRING):0,0 CORPORATION','ASSUMED NAME','DBA','FICTITIOUS NAME']);
EXPORT InValidMessageFT_invalid_filing_type(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('BUSINESS LICENSE|TRADENAME:TYPE(STRING):0,0 CORPORATION|ASSUMED NAME|DBA|FICTITIOUS NAME'),SALT37.HygieneErrors.Good);
 
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
  s1 := SALT37.stringfilter(s0,' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,:TYPE(STRING):0,0\'&'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_email(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,:TYPE(STRING):0,0\'&'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,:TYPE(STRING):0,0\'&'),SALT37.HygieneErrors.Good);
 
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
 
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'action_OWN_name','event_date','event_doc_number','event_orig_doc_number','prep_old_addr_line1','prep_old_addr_line_last','prep_new_addr_line1','prep_new_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','EVENT_FIC_NAME','EVENT_ACTION_CTR','EVENT_SEQ_NUMBER','EVENT_PAGES','ACTION_SEQ_NUMBER','ACTION_CODE','ACTION_VERBAGE','ACTION_OLD_FEI','ACTION_OLD_COUNTY','ACTION_OLD_ADDR1','ACTION_OLD_ADDR2','ACTION_OLD_CITY','ACTION_OLD_STATE','ACTION_OLD_ZIP5','ACTION_OLD_ZIP4','ACTION_OLD_COUNTRY','ACTION_OLD_COUNTRY_DESC','ACTION_NEW_FEI','ACTION_NEW_COUNTY','ACTION_NEW_ADDR1','ACTION_NEW_ADDR2','ACTION_NEW_CITY','ACTION_NEW_STATE','ACTION_NEW_ZIP5','ACTION_NEW_ZIP4','ACTION_NEW_COUNTRY','ACTION_NEW_COUNTRY_DESC','ACTION_OWN_ADDRESS','ACTION_OWN_CITY','ACTION_OWN_STATE','ACTION_OWN_ZIP5','ACTION_OWN_FEI','ACTION_OWN_CHARTER_NUMBER','ACTION_OLD_NAME_SEQ','ACTION_NEW_NAME_SEQ','Owner_title','Owner_fname','Owner_mname','Owner_lname','Owner_name_suffix','Owner_name_score','cname');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'action_OWN_name' => 0,'event_date' => 1,'event_doc_number' => 2,'event_orig_doc_number' => 3,'prep_old_addr_line1' => 4,'prep_old_addr_line_last' => 5,'prep_new_addr_line1' => 6,'prep_new_addr_line_last' => 7,'prep_owner_addr_line1' => 8,'prep_owner_addr_line_last' => 9,'EVENT_FIC_NAME' => 10,'EVENT_ACTION_CTR' => 11,'EVENT_SEQ_NUMBER' => 12,'EVENT_PAGES' => 13,'ACTION_SEQ_NUMBER' => 14,'ACTION_CODE' => 15,'ACTION_VERBAGE' => 16,'ACTION_OLD_FEI' => 17,'ACTION_OLD_COUNTY' => 18,'ACTION_OLD_ADDR1' => 19,'ACTION_OLD_ADDR2' => 20,'ACTION_OLD_CITY' => 21,'ACTION_OLD_STATE' => 22,'ACTION_OLD_ZIP5' => 23,'ACTION_OLD_ZIP4' => 24,'ACTION_OLD_COUNTRY' => 25,'ACTION_OLD_COUNTRY_DESC' => 26,'ACTION_NEW_FEI' => 27,'ACTION_NEW_COUNTY' => 28,'ACTION_NEW_ADDR1' => 29,'ACTION_NEW_ADDR2' => 30,'ACTION_NEW_CITY' => 31,'ACTION_NEW_STATE' => 32,'ACTION_NEW_ZIP5' => 33,'ACTION_NEW_ZIP4' => 34,'ACTION_NEW_COUNTRY' => 35,'ACTION_NEW_COUNTRY_DESC' => 36,'ACTION_OWN_ADDRESS' => 37,'ACTION_OWN_CITY' => 38,'ACTION_OWN_STATE' => 39,'ACTION_OWN_ZIP5' => 40,'ACTION_OWN_FEI' => 41,'ACTION_OWN_CHARTER_NUMBER' => 42,'ACTION_OLD_NAME_SEQ' => 43,'ACTION_NEW_NAME_SEQ' => 44,'Owner_title' => 45,'Owner_fname' => 46,'Owner_mname' => 47,'Owner_lname' => 48,'Owner_name_suffix' => 49,'Owner_name_score' => 50,'cname' => 51,0);
 
//Individual field level validation
 
EXPORT Make_action_OWN_name(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_action_OWN_name(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_action_OWN_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_event_date(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_event_date(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_event_date(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_event_doc_number(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_event_doc_number(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_event_doc_number(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_event_orig_doc_number(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_event_orig_doc_number(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_event_orig_doc_number(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_old_addr_line1(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_old_addr_line1(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_old_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_old_addr_line_last(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_old_addr_line_last(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_old_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_new_addr_line1(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_new_addr_line1(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_new_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_new_addr_line_last(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_new_addr_line_last(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_new_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_owner_addr_line1(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_owner_addr_line1(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_owner_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_owner_addr_line_last(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_owner_addr_line_last(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_owner_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_EVENT_FIC_NAME(SALT37.StrType s0) := s0;
EXPORT InValid_EVENT_FIC_NAME(SALT37.StrType s) := 0;
EXPORT InValidMessage_EVENT_FIC_NAME(UNSIGNED1 wh) := '';
 
EXPORT Make_EVENT_ACTION_CTR(SALT37.StrType s0) := s0;
EXPORT InValid_EVENT_ACTION_CTR(SALT37.StrType s) := 0;
EXPORT InValidMessage_EVENT_ACTION_CTR(UNSIGNED1 wh) := '';
 
EXPORT Make_EVENT_SEQ_NUMBER(SALT37.StrType s0) := s0;
EXPORT InValid_EVENT_SEQ_NUMBER(SALT37.StrType s) := 0;
EXPORT InValidMessage_EVENT_SEQ_NUMBER(UNSIGNED1 wh) := '';
 
EXPORT Make_EVENT_PAGES(SALT37.StrType s0) := s0;
EXPORT InValid_EVENT_PAGES(SALT37.StrType s) := 0;
EXPORT InValidMessage_EVENT_PAGES(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_SEQ_NUMBER(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_SEQ_NUMBER(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_SEQ_NUMBER(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_CODE(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_CODE(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_CODE(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_VERBAGE(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_VERBAGE(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_VERBAGE(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_OLD_FEI(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_OLD_FEI(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_OLD_FEI(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_OLD_COUNTY(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_OLD_COUNTY(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_OLD_COUNTY(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_OLD_ADDR1(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_OLD_ADDR1(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_OLD_ADDR1(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_OLD_ADDR2(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_OLD_ADDR2(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_OLD_ADDR2(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_OLD_CITY(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_OLD_CITY(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_OLD_CITY(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_OLD_STATE(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_OLD_STATE(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_OLD_STATE(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_OLD_ZIP5(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_OLD_ZIP5(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_OLD_ZIP5(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_OLD_ZIP4(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_OLD_ZIP4(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_OLD_ZIP4(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_OLD_COUNTRY(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_OLD_COUNTRY(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_OLD_COUNTRY(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_OLD_COUNTRY_DESC(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_OLD_COUNTRY_DESC(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_OLD_COUNTRY_DESC(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_NEW_FEI(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_NEW_FEI(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_NEW_FEI(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_NEW_COUNTY(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_NEW_COUNTY(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_NEW_COUNTY(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_NEW_ADDR1(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_NEW_ADDR1(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_NEW_ADDR1(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_NEW_ADDR2(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_NEW_ADDR2(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_NEW_ADDR2(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_NEW_CITY(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_NEW_CITY(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_NEW_CITY(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_NEW_STATE(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_NEW_STATE(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_NEW_STATE(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_NEW_ZIP5(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_NEW_ZIP5(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_NEW_ZIP5(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_NEW_ZIP4(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_NEW_ZIP4(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_NEW_ZIP4(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_NEW_COUNTRY(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_NEW_COUNTRY(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_NEW_COUNTRY(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_NEW_COUNTRY_DESC(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_NEW_COUNTRY_DESC(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_NEW_COUNTRY_DESC(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_OWN_ADDRESS(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_OWN_ADDRESS(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_OWN_ADDRESS(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_OWN_CITY(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_OWN_CITY(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_OWN_CITY(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_OWN_STATE(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_OWN_STATE(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_OWN_STATE(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_OWN_ZIP5(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_OWN_ZIP5(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_OWN_ZIP5(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_OWN_FEI(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_OWN_FEI(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_OWN_FEI(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_OWN_CHARTER_NUMBER(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_OWN_CHARTER_NUMBER(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_OWN_CHARTER_NUMBER(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_OLD_NAME_SEQ(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_OLD_NAME_SEQ(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_OLD_NAME_SEQ(UNSIGNED1 wh) := '';
 
EXPORT Make_ACTION_NEW_NAME_SEQ(SALT37.StrType s0) := s0;
EXPORT InValid_ACTION_NEW_NAME_SEQ(SALT37.StrType s) := 0;
EXPORT InValidMessage_ACTION_NEW_NAME_SEQ(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_title(SALT37.StrType s0) := s0;
EXPORT InValid_Owner_title(SALT37.StrType s) := 0;
EXPORT InValidMessage_Owner_title(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_fname(SALT37.StrType s0) := s0;
EXPORT InValid_Owner_fname(SALT37.StrType s) := 0;
EXPORT InValidMessage_Owner_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_mname(SALT37.StrType s0) := s0;
EXPORT InValid_Owner_mname(SALT37.StrType s) := 0;
EXPORT InValidMessage_Owner_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_lname(SALT37.StrType s0) := s0;
EXPORT InValid_Owner_lname(SALT37.StrType s) := 0;
EXPORT InValidMessage_Owner_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_name_suffix(SALT37.StrType s0) := s0;
EXPORT InValid_Owner_name_suffix(SALT37.StrType s) := 0;
EXPORT InValidMessage_Owner_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_name_score(SALT37.StrType s0) := s0;
EXPORT InValid_Owner_name_score(SALT37.StrType s) := 0;
EXPORT InValidMessage_Owner_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_cname(SALT37.StrType s0) := s0;
EXPORT InValid_cname(SALT37.StrType s) := 0;
EXPORT InValidMessage_cname(UNSIGNED1 wh) := '';
 
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
    BOOLEAN Diff_action_OWN_name;
    BOOLEAN Diff_event_date;
    BOOLEAN Diff_event_doc_number;
    BOOLEAN Diff_event_orig_doc_number;
    BOOLEAN Diff_prep_old_addr_line1;
    BOOLEAN Diff_prep_old_addr_line_last;
    BOOLEAN Diff_prep_new_addr_line1;
    BOOLEAN Diff_prep_new_addr_line_last;
    BOOLEAN Diff_prep_owner_addr_line1;
    BOOLEAN Diff_prep_owner_addr_line_last;
    BOOLEAN Diff_EVENT_FIC_NAME;
    BOOLEAN Diff_EVENT_ACTION_CTR;
    BOOLEAN Diff_EVENT_SEQ_NUMBER;
    BOOLEAN Diff_EVENT_PAGES;
    BOOLEAN Diff_ACTION_SEQ_NUMBER;
    BOOLEAN Diff_ACTION_CODE;
    BOOLEAN Diff_ACTION_VERBAGE;
    BOOLEAN Diff_ACTION_OLD_FEI;
    BOOLEAN Diff_ACTION_OLD_COUNTY;
    BOOLEAN Diff_ACTION_OLD_ADDR1;
    BOOLEAN Diff_ACTION_OLD_ADDR2;
    BOOLEAN Diff_ACTION_OLD_CITY;
    BOOLEAN Diff_ACTION_OLD_STATE;
    BOOLEAN Diff_ACTION_OLD_ZIP5;
    BOOLEAN Diff_ACTION_OLD_ZIP4;
    BOOLEAN Diff_ACTION_OLD_COUNTRY;
    BOOLEAN Diff_ACTION_OLD_COUNTRY_DESC;
    BOOLEAN Diff_ACTION_NEW_FEI;
    BOOLEAN Diff_ACTION_NEW_COUNTY;
    BOOLEAN Diff_ACTION_NEW_ADDR1;
    BOOLEAN Diff_ACTION_NEW_ADDR2;
    BOOLEAN Diff_ACTION_NEW_CITY;
    BOOLEAN Diff_ACTION_NEW_STATE;
    BOOLEAN Diff_ACTION_NEW_ZIP5;
    BOOLEAN Diff_ACTION_NEW_ZIP4;
    BOOLEAN Diff_ACTION_NEW_COUNTRY;
    BOOLEAN Diff_ACTION_NEW_COUNTRY_DESC;
    BOOLEAN Diff_ACTION_OWN_ADDRESS;
    BOOLEAN Diff_ACTION_OWN_CITY;
    BOOLEAN Diff_ACTION_OWN_STATE;
    BOOLEAN Diff_ACTION_OWN_ZIP5;
    BOOLEAN Diff_ACTION_OWN_FEI;
    BOOLEAN Diff_ACTION_OWN_CHARTER_NUMBER;
    BOOLEAN Diff_ACTION_OLD_NAME_SEQ;
    BOOLEAN Diff_ACTION_NEW_NAME_SEQ;
    BOOLEAN Diff_Owner_title;
    BOOLEAN Diff_Owner_fname;
    BOOLEAN Diff_Owner_mname;
    BOOLEAN Diff_Owner_lname;
    BOOLEAN Diff_Owner_name_suffix;
    BOOLEAN Diff_Owner_name_score;
    BOOLEAN Diff_cname;
    UNSIGNED Num_Diffs;
    SALT37.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_action_OWN_name := le.action_OWN_name <> ri.action_OWN_name;
    SELF.Diff_event_date := le.event_date <> ri.event_date;
    SELF.Diff_event_doc_number := le.event_doc_number <> ri.event_doc_number;
    SELF.Diff_event_orig_doc_number := le.event_orig_doc_number <> ri.event_orig_doc_number;
    SELF.Diff_prep_old_addr_line1 := le.prep_old_addr_line1 <> ri.prep_old_addr_line1;
    SELF.Diff_prep_old_addr_line_last := le.prep_old_addr_line_last <> ri.prep_old_addr_line_last;
    SELF.Diff_prep_new_addr_line1 := le.prep_new_addr_line1 <> ri.prep_new_addr_line1;
    SELF.Diff_prep_new_addr_line_last := le.prep_new_addr_line_last <> ri.prep_new_addr_line_last;
    SELF.Diff_prep_owner_addr_line1 := le.prep_owner_addr_line1 <> ri.prep_owner_addr_line1;
    SELF.Diff_prep_owner_addr_line_last := le.prep_owner_addr_line_last <> ri.prep_owner_addr_line_last;
    SELF.Diff_EVENT_FIC_NAME := le.EVENT_FIC_NAME <> ri.EVENT_FIC_NAME;
    SELF.Diff_EVENT_ACTION_CTR := le.EVENT_ACTION_CTR <> ri.EVENT_ACTION_CTR;
    SELF.Diff_EVENT_SEQ_NUMBER := le.EVENT_SEQ_NUMBER <> ri.EVENT_SEQ_NUMBER;
    SELF.Diff_EVENT_PAGES := le.EVENT_PAGES <> ri.EVENT_PAGES;
    SELF.Diff_ACTION_SEQ_NUMBER := le.ACTION_SEQ_NUMBER <> ri.ACTION_SEQ_NUMBER;
    SELF.Diff_ACTION_CODE := le.ACTION_CODE <> ri.ACTION_CODE;
    SELF.Diff_ACTION_VERBAGE := le.ACTION_VERBAGE <> ri.ACTION_VERBAGE;
    SELF.Diff_ACTION_OLD_FEI := le.ACTION_OLD_FEI <> ri.ACTION_OLD_FEI;
    SELF.Diff_ACTION_OLD_COUNTY := le.ACTION_OLD_COUNTY <> ri.ACTION_OLD_COUNTY;
    SELF.Diff_ACTION_OLD_ADDR1 := le.ACTION_OLD_ADDR1 <> ri.ACTION_OLD_ADDR1;
    SELF.Diff_ACTION_OLD_ADDR2 := le.ACTION_OLD_ADDR2 <> ri.ACTION_OLD_ADDR2;
    SELF.Diff_ACTION_OLD_CITY := le.ACTION_OLD_CITY <> ri.ACTION_OLD_CITY;
    SELF.Diff_ACTION_OLD_STATE := le.ACTION_OLD_STATE <> ri.ACTION_OLD_STATE;
    SELF.Diff_ACTION_OLD_ZIP5 := le.ACTION_OLD_ZIP5 <> ri.ACTION_OLD_ZIP5;
    SELF.Diff_ACTION_OLD_ZIP4 := le.ACTION_OLD_ZIP4 <> ri.ACTION_OLD_ZIP4;
    SELF.Diff_ACTION_OLD_COUNTRY := le.ACTION_OLD_COUNTRY <> ri.ACTION_OLD_COUNTRY;
    SELF.Diff_ACTION_OLD_COUNTRY_DESC := le.ACTION_OLD_COUNTRY_DESC <> ri.ACTION_OLD_COUNTRY_DESC;
    SELF.Diff_ACTION_NEW_FEI := le.ACTION_NEW_FEI <> ri.ACTION_NEW_FEI;
    SELF.Diff_ACTION_NEW_COUNTY := le.ACTION_NEW_COUNTY <> ri.ACTION_NEW_COUNTY;
    SELF.Diff_ACTION_NEW_ADDR1 := le.ACTION_NEW_ADDR1 <> ri.ACTION_NEW_ADDR1;
    SELF.Diff_ACTION_NEW_ADDR2 := le.ACTION_NEW_ADDR2 <> ri.ACTION_NEW_ADDR2;
    SELF.Diff_ACTION_NEW_CITY := le.ACTION_NEW_CITY <> ri.ACTION_NEW_CITY;
    SELF.Diff_ACTION_NEW_STATE := le.ACTION_NEW_STATE <> ri.ACTION_NEW_STATE;
    SELF.Diff_ACTION_NEW_ZIP5 := le.ACTION_NEW_ZIP5 <> ri.ACTION_NEW_ZIP5;
    SELF.Diff_ACTION_NEW_ZIP4 := le.ACTION_NEW_ZIP4 <> ri.ACTION_NEW_ZIP4;
    SELF.Diff_ACTION_NEW_COUNTRY := le.ACTION_NEW_COUNTRY <> ri.ACTION_NEW_COUNTRY;
    SELF.Diff_ACTION_NEW_COUNTRY_DESC := le.ACTION_NEW_COUNTRY_DESC <> ri.ACTION_NEW_COUNTRY_DESC;
    SELF.Diff_ACTION_OWN_ADDRESS := le.ACTION_OWN_ADDRESS <> ri.ACTION_OWN_ADDRESS;
    SELF.Diff_ACTION_OWN_CITY := le.ACTION_OWN_CITY <> ri.ACTION_OWN_CITY;
    SELF.Diff_ACTION_OWN_STATE := le.ACTION_OWN_STATE <> ri.ACTION_OWN_STATE;
    SELF.Diff_ACTION_OWN_ZIP5 := le.ACTION_OWN_ZIP5 <> ri.ACTION_OWN_ZIP5;
    SELF.Diff_ACTION_OWN_FEI := le.ACTION_OWN_FEI <> ri.ACTION_OWN_FEI;
    SELF.Diff_ACTION_OWN_CHARTER_NUMBER := le.ACTION_OWN_CHARTER_NUMBER <> ri.ACTION_OWN_CHARTER_NUMBER;
    SELF.Diff_ACTION_OLD_NAME_SEQ := le.ACTION_OLD_NAME_SEQ <> ri.ACTION_OLD_NAME_SEQ;
    SELF.Diff_ACTION_NEW_NAME_SEQ := le.ACTION_NEW_NAME_SEQ <> ri.ACTION_NEW_NAME_SEQ;
    SELF.Diff_Owner_title := le.Owner_title <> ri.Owner_title;
    SELF.Diff_Owner_fname := le.Owner_fname <> ri.Owner_fname;
    SELF.Diff_Owner_mname := le.Owner_mname <> ri.Owner_mname;
    SELF.Diff_Owner_lname := le.Owner_lname <> ri.Owner_lname;
    SELF.Diff_Owner_name_suffix := le.Owner_name_suffix <> ri.Owner_name_suffix;
    SELF.Diff_Owner_name_score := le.Owner_name_score <> ri.Owner_name_score;
    SELF.Diff_cname := le.cname <> ri.cname;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_action_OWN_name,1,0)+ IF( SELF.Diff_event_date,1,0)+ IF( SELF.Diff_event_doc_number,1,0)+ IF( SELF.Diff_event_orig_doc_number,1,0)+ IF( SELF.Diff_prep_old_addr_line1,1,0)+ IF( SELF.Diff_prep_old_addr_line_last,1,0)+ IF( SELF.Diff_prep_new_addr_line1,1,0)+ IF( SELF.Diff_prep_new_addr_line_last,1,0)+ IF( SELF.Diff_prep_owner_addr_line1,1,0)+ IF( SELF.Diff_prep_owner_addr_line_last,1,0)+ IF( SELF.Diff_EVENT_FIC_NAME,1,0)+ IF( SELF.Diff_EVENT_ACTION_CTR,1,0)+ IF( SELF.Diff_EVENT_SEQ_NUMBER,1,0)+ IF( SELF.Diff_EVENT_PAGES,1,0)+ IF( SELF.Diff_ACTION_SEQ_NUMBER,1,0)+ IF( SELF.Diff_ACTION_CODE,1,0)+ IF( SELF.Diff_ACTION_VERBAGE,1,0)+ IF( SELF.Diff_ACTION_OLD_FEI,1,0)+ IF( SELF.Diff_ACTION_OLD_COUNTY,1,0)+ IF( SELF.Diff_ACTION_OLD_ADDR1,1,0)+ IF( SELF.Diff_ACTION_OLD_ADDR2,1,0)+ IF( SELF.Diff_ACTION_OLD_CITY,1,0)+ IF( SELF.Diff_ACTION_OLD_STATE,1,0)+ IF( SELF.Diff_ACTION_OLD_ZIP5,1,0)+ IF( SELF.Diff_ACTION_OLD_ZIP4,1,0)+ IF( SELF.Diff_ACTION_OLD_COUNTRY,1,0)+ IF( SELF.Diff_ACTION_OLD_COUNTRY_DESC,1,0)+ IF( SELF.Diff_ACTION_NEW_FEI,1,0)+ IF( SELF.Diff_ACTION_NEW_COUNTY,1,0)+ IF( SELF.Diff_ACTION_NEW_ADDR1,1,0)+ IF( SELF.Diff_ACTION_NEW_ADDR2,1,0)+ IF( SELF.Diff_ACTION_NEW_CITY,1,0)+ IF( SELF.Diff_ACTION_NEW_STATE,1,0)+ IF( SELF.Diff_ACTION_NEW_ZIP5,1,0)+ IF( SELF.Diff_ACTION_NEW_ZIP4,1,0)+ IF( SELF.Diff_ACTION_NEW_COUNTRY,1,0)+ IF( SELF.Diff_ACTION_NEW_COUNTRY_DESC,1,0)+ IF( SELF.Diff_ACTION_OWN_ADDRESS,1,0)+ IF( SELF.Diff_ACTION_OWN_CITY,1,0)+ IF( SELF.Diff_ACTION_OWN_STATE,1,0)+ IF( SELF.Diff_ACTION_OWN_ZIP5,1,0)+ IF( SELF.Diff_ACTION_OWN_FEI,1,0)+ IF( SELF.Diff_ACTION_OWN_CHARTER_NUMBER,1,0)+ IF( SELF.Diff_ACTION_OLD_NAME_SEQ,1,0)+ IF( SELF.Diff_ACTION_NEW_NAME_SEQ,1,0)+ IF( SELF.Diff_Owner_title,1,0)+ IF( SELF.Diff_Owner_fname,1,0)+ IF( SELF.Diff_Owner_mname,1,0)+ IF( SELF.Diff_Owner_lname,1,0)+ IF( SELF.Diff_Owner_name_suffix,1,0)+ IF( SELF.Diff_Owner_name_score,1,0)+ IF( SELF.Diff_cname,1,0);
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
    Count_Diff_action_OWN_name := COUNT(GROUP,%Closest%.Diff_action_OWN_name);
    Count_Diff_event_date := COUNT(GROUP,%Closest%.Diff_event_date);
    Count_Diff_event_doc_number := COUNT(GROUP,%Closest%.Diff_event_doc_number);
    Count_Diff_event_orig_doc_number := COUNT(GROUP,%Closest%.Diff_event_orig_doc_number);
    Count_Diff_prep_old_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_old_addr_line1);
    Count_Diff_prep_old_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_old_addr_line_last);
    Count_Diff_prep_new_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_new_addr_line1);
    Count_Diff_prep_new_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_new_addr_line_last);
    Count_Diff_prep_owner_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_owner_addr_line1);
    Count_Diff_prep_owner_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_owner_addr_line_last);
    Count_Diff_EVENT_FIC_NAME := COUNT(GROUP,%Closest%.Diff_EVENT_FIC_NAME);
    Count_Diff_EVENT_ACTION_CTR := COUNT(GROUP,%Closest%.Diff_EVENT_ACTION_CTR);
    Count_Diff_EVENT_SEQ_NUMBER := COUNT(GROUP,%Closest%.Diff_EVENT_SEQ_NUMBER);
    Count_Diff_EVENT_PAGES := COUNT(GROUP,%Closest%.Diff_EVENT_PAGES);
    Count_Diff_ACTION_SEQ_NUMBER := COUNT(GROUP,%Closest%.Diff_ACTION_SEQ_NUMBER);
    Count_Diff_ACTION_CODE := COUNT(GROUP,%Closest%.Diff_ACTION_CODE);
    Count_Diff_ACTION_VERBAGE := COUNT(GROUP,%Closest%.Diff_ACTION_VERBAGE);
    Count_Diff_ACTION_OLD_FEI := COUNT(GROUP,%Closest%.Diff_ACTION_OLD_FEI);
    Count_Diff_ACTION_OLD_COUNTY := COUNT(GROUP,%Closest%.Diff_ACTION_OLD_COUNTY);
    Count_Diff_ACTION_OLD_ADDR1 := COUNT(GROUP,%Closest%.Diff_ACTION_OLD_ADDR1);
    Count_Diff_ACTION_OLD_ADDR2 := COUNT(GROUP,%Closest%.Diff_ACTION_OLD_ADDR2);
    Count_Diff_ACTION_OLD_CITY := COUNT(GROUP,%Closest%.Diff_ACTION_OLD_CITY);
    Count_Diff_ACTION_OLD_STATE := COUNT(GROUP,%Closest%.Diff_ACTION_OLD_STATE);
    Count_Diff_ACTION_OLD_ZIP5 := COUNT(GROUP,%Closest%.Diff_ACTION_OLD_ZIP5);
    Count_Diff_ACTION_OLD_ZIP4 := COUNT(GROUP,%Closest%.Diff_ACTION_OLD_ZIP4);
    Count_Diff_ACTION_OLD_COUNTRY := COUNT(GROUP,%Closest%.Diff_ACTION_OLD_COUNTRY);
    Count_Diff_ACTION_OLD_COUNTRY_DESC := COUNT(GROUP,%Closest%.Diff_ACTION_OLD_COUNTRY_DESC);
    Count_Diff_ACTION_NEW_FEI := COUNT(GROUP,%Closest%.Diff_ACTION_NEW_FEI);
    Count_Diff_ACTION_NEW_COUNTY := COUNT(GROUP,%Closest%.Diff_ACTION_NEW_COUNTY);
    Count_Diff_ACTION_NEW_ADDR1 := COUNT(GROUP,%Closest%.Diff_ACTION_NEW_ADDR1);
    Count_Diff_ACTION_NEW_ADDR2 := COUNT(GROUP,%Closest%.Diff_ACTION_NEW_ADDR2);
    Count_Diff_ACTION_NEW_CITY := COUNT(GROUP,%Closest%.Diff_ACTION_NEW_CITY);
    Count_Diff_ACTION_NEW_STATE := COUNT(GROUP,%Closest%.Diff_ACTION_NEW_STATE);
    Count_Diff_ACTION_NEW_ZIP5 := COUNT(GROUP,%Closest%.Diff_ACTION_NEW_ZIP5);
    Count_Diff_ACTION_NEW_ZIP4 := COUNT(GROUP,%Closest%.Diff_ACTION_NEW_ZIP4);
    Count_Diff_ACTION_NEW_COUNTRY := COUNT(GROUP,%Closest%.Diff_ACTION_NEW_COUNTRY);
    Count_Diff_ACTION_NEW_COUNTRY_DESC := COUNT(GROUP,%Closest%.Diff_ACTION_NEW_COUNTRY_DESC);
    Count_Diff_ACTION_OWN_ADDRESS := COUNT(GROUP,%Closest%.Diff_ACTION_OWN_ADDRESS);
    Count_Diff_ACTION_OWN_CITY := COUNT(GROUP,%Closest%.Diff_ACTION_OWN_CITY);
    Count_Diff_ACTION_OWN_STATE := COUNT(GROUP,%Closest%.Diff_ACTION_OWN_STATE);
    Count_Diff_ACTION_OWN_ZIP5 := COUNT(GROUP,%Closest%.Diff_ACTION_OWN_ZIP5);
    Count_Diff_ACTION_OWN_FEI := COUNT(GROUP,%Closest%.Diff_ACTION_OWN_FEI);
    Count_Diff_ACTION_OWN_CHARTER_NUMBER := COUNT(GROUP,%Closest%.Diff_ACTION_OWN_CHARTER_NUMBER);
    Count_Diff_ACTION_OLD_NAME_SEQ := COUNT(GROUP,%Closest%.Diff_ACTION_OLD_NAME_SEQ);
    Count_Diff_ACTION_NEW_NAME_SEQ := COUNT(GROUP,%Closest%.Diff_ACTION_NEW_NAME_SEQ);
    Count_Diff_Owner_title := COUNT(GROUP,%Closest%.Diff_Owner_title);
    Count_Diff_Owner_fname := COUNT(GROUP,%Closest%.Diff_Owner_fname);
    Count_Diff_Owner_mname := COUNT(GROUP,%Closest%.Diff_Owner_mname);
    Count_Diff_Owner_lname := COUNT(GROUP,%Closest%.Diff_Owner_lname);
    Count_Diff_Owner_name_suffix := COUNT(GROUP,%Closest%.Diff_Owner_name_suffix);
    Count_Diff_Owner_name_score := COUNT(GROUP,%Closest%.Diff_Owner_name_score);
    Count_Diff_cname := COUNT(GROUP,%Closest%.Diff_cname);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

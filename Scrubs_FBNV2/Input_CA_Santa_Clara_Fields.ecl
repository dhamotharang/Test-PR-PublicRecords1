IMPORT SALT37;
IMPORT Scrubs_FBNV2,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_CA_Santa_Clara_Fields := MODULE
 
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
 
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'business_name','filed_date','orig_filed_date','fbn_num','filing_type','owner_name','prep_addr_line1','prep_addr_line_last','status','FBN_TYPE','BUSINESS_TYPE','ORIG_FBN_NUM','RECORD_CODE1','BUSINESS_ADDR1','RECORD_CODE2','BUSINESS_ADDR2','RECORD_CODE3','BUS_CITY','BUS_ST','BUS_ZIP','RECORD_CODE4','ADDTL_BUSINESS','RECORD_CODE5','OWNER_TYPE','RECORD_CODE6','OWNER_ADDR1','OWNER_CITY','OWNER_ST','OWNER_ZIP','Owner_title','Owner_fname','Owner_mname','Owner_lname','Owner_name_suffix','Owner_name_score','prep_owner_addr_line1','prep_owner_addr_line_last');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'business_name' => 0,'filed_date' => 1,'orig_filed_date' => 2,'fbn_num' => 3,'filing_type' => 4,'owner_name' => 5,'prep_addr_line1' => 6,'prep_addr_line_last' => 7,'status' => 8,'FBN_TYPE' => 9,'BUSINESS_TYPE' => 10,'ORIG_FBN_NUM' => 11,'RECORD_CODE1' => 12,'BUSINESS_ADDR1' => 13,'RECORD_CODE2' => 14,'BUSINESS_ADDR2' => 15,'RECORD_CODE3' => 16,'BUS_CITY' => 17,'BUS_ST' => 18,'BUS_ZIP' => 19,'RECORD_CODE4' => 20,'ADDTL_BUSINESS' => 21,'RECORD_CODE5' => 22,'OWNER_TYPE' => 23,'RECORD_CODE6' => 24,'OWNER_ADDR1' => 25,'OWNER_CITY' => 26,'OWNER_ST' => 27,'OWNER_ZIP' => 28,'Owner_title' => 29,'Owner_fname' => 30,'Owner_mname' => 31,'Owner_lname' => 32,'Owner_name_suffix' => 33,'Owner_name_score' => 34,'prep_owner_addr_line1' => 35,'prep_owner_addr_line_last' => 36,0);
 
//Individual field level validation
 
EXPORT Make_business_name(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_business_name(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_business_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_filed_date(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_filed_date(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_filed_date(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_orig_filed_date(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_orig_filed_date(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_orig_filed_date(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_fbn_num(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_fbn_num(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_fbn_num(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_filing_type(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_filing_type(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_filing_type(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_owner_name(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_owner_name(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_owner_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_line1(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line1(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_line_last(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line_last(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_status(SALT37.StrType s0) := s0;
EXPORT InValid_status(SALT37.StrType s) := 0;
EXPORT InValidMessage_status(UNSIGNED1 wh) := '';
 
EXPORT Make_FBN_TYPE(SALT37.StrType s0) := s0;
EXPORT InValid_FBN_TYPE(SALT37.StrType s) := 0;
EXPORT InValidMessage_FBN_TYPE(UNSIGNED1 wh) := '';
 
EXPORT Make_BUSINESS_TYPE(SALT37.StrType s0) := s0;
EXPORT InValid_BUSINESS_TYPE(SALT37.StrType s) := 0;
EXPORT InValidMessage_BUSINESS_TYPE(UNSIGNED1 wh) := '';
 
EXPORT Make_ORIG_FBN_NUM(SALT37.StrType s0) := s0;
EXPORT InValid_ORIG_FBN_NUM(SALT37.StrType s) := 0;
EXPORT InValidMessage_ORIG_FBN_NUM(UNSIGNED1 wh) := '';
 
EXPORT Make_RECORD_CODE1(SALT37.StrType s0) := s0;
EXPORT InValid_RECORD_CODE1(SALT37.StrType s) := 0;
EXPORT InValidMessage_RECORD_CODE1(UNSIGNED1 wh) := '';
 
EXPORT Make_BUSINESS_ADDR1(SALT37.StrType s0) := s0;
EXPORT InValid_BUSINESS_ADDR1(SALT37.StrType s) := 0;
EXPORT InValidMessage_BUSINESS_ADDR1(UNSIGNED1 wh) := '';
 
EXPORT Make_RECORD_CODE2(SALT37.StrType s0) := s0;
EXPORT InValid_RECORD_CODE2(SALT37.StrType s) := 0;
EXPORT InValidMessage_RECORD_CODE2(UNSIGNED1 wh) := '';
 
EXPORT Make_BUSINESS_ADDR2(SALT37.StrType s0) := s0;
EXPORT InValid_BUSINESS_ADDR2(SALT37.StrType s) := 0;
EXPORT InValidMessage_BUSINESS_ADDR2(UNSIGNED1 wh) := '';
 
EXPORT Make_RECORD_CODE3(SALT37.StrType s0) := s0;
EXPORT InValid_RECORD_CODE3(SALT37.StrType s) := 0;
EXPORT InValidMessage_RECORD_CODE3(UNSIGNED1 wh) := '';
 
EXPORT Make_BUS_CITY(SALT37.StrType s0) := s0;
EXPORT InValid_BUS_CITY(SALT37.StrType s) := 0;
EXPORT InValidMessage_BUS_CITY(UNSIGNED1 wh) := '';
 
EXPORT Make_BUS_ST(SALT37.StrType s0) := s0;
EXPORT InValid_BUS_ST(SALT37.StrType s) := 0;
EXPORT InValidMessage_BUS_ST(UNSIGNED1 wh) := '';
 
EXPORT Make_BUS_ZIP(SALT37.StrType s0) := s0;
EXPORT InValid_BUS_ZIP(SALT37.StrType s) := 0;
EXPORT InValidMessage_BUS_ZIP(UNSIGNED1 wh) := '';
 
EXPORT Make_RECORD_CODE4(SALT37.StrType s0) := s0;
EXPORT InValid_RECORD_CODE4(SALT37.StrType s) := 0;
EXPORT InValidMessage_RECORD_CODE4(UNSIGNED1 wh) := '';
 
EXPORT Make_ADDTL_BUSINESS(SALT37.StrType s0) := s0;
EXPORT InValid_ADDTL_BUSINESS(SALT37.StrType s) := 0;
EXPORT InValidMessage_ADDTL_BUSINESS(UNSIGNED1 wh) := '';
 
EXPORT Make_RECORD_CODE5(SALT37.StrType s0) := s0;
EXPORT InValid_RECORD_CODE5(SALT37.StrType s) := 0;
EXPORT InValidMessage_RECORD_CODE5(UNSIGNED1 wh) := '';
 
EXPORT Make_OWNER_TYPE(SALT37.StrType s0) := s0;
EXPORT InValid_OWNER_TYPE(SALT37.StrType s) := 0;
EXPORT InValidMessage_OWNER_TYPE(UNSIGNED1 wh) := '';
 
EXPORT Make_RECORD_CODE6(SALT37.StrType s0) := s0;
EXPORT InValid_RECORD_CODE6(SALT37.StrType s) := 0;
EXPORT InValidMessage_RECORD_CODE6(UNSIGNED1 wh) := '';
 
EXPORT Make_OWNER_ADDR1(SALT37.StrType s0) := s0;
EXPORT InValid_OWNER_ADDR1(SALT37.StrType s) := 0;
EXPORT InValidMessage_OWNER_ADDR1(UNSIGNED1 wh) := '';
 
EXPORT Make_OWNER_CITY(SALT37.StrType s0) := s0;
EXPORT InValid_OWNER_CITY(SALT37.StrType s) := 0;
EXPORT InValidMessage_OWNER_CITY(UNSIGNED1 wh) := '';
 
EXPORT Make_OWNER_ST(SALT37.StrType s0) := s0;
EXPORT InValid_OWNER_ST(SALT37.StrType s) := 0;
EXPORT InValidMessage_OWNER_ST(UNSIGNED1 wh) := '';
 
EXPORT Make_OWNER_ZIP(SALT37.StrType s0) := s0;
EXPORT InValid_OWNER_ZIP(SALT37.StrType s) := 0;
EXPORT InValidMessage_OWNER_ZIP(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_prep_owner_addr_line1(SALT37.StrType s0) := s0;
EXPORT InValid_prep_owner_addr_line1(SALT37.StrType s) := 0;
EXPORT InValidMessage_prep_owner_addr_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_prep_owner_addr_line_last(SALT37.StrType s0) := s0;
EXPORT InValid_prep_owner_addr_line_last(SALT37.StrType s) := 0;
EXPORT InValidMessage_prep_owner_addr_line_last(UNSIGNED1 wh) := '';
 
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
    BOOLEAN Diff_filed_date;
    BOOLEAN Diff_orig_filed_date;
    BOOLEAN Diff_fbn_num;
    BOOLEAN Diff_filing_type;
    BOOLEAN Diff_owner_name;
    BOOLEAN Diff_prep_addr_line1;
    BOOLEAN Diff_prep_addr_line_last;
    BOOLEAN Diff_status;
    BOOLEAN Diff_FBN_TYPE;
    BOOLEAN Diff_BUSINESS_TYPE;
    BOOLEAN Diff_ORIG_FBN_NUM;
    BOOLEAN Diff_RECORD_CODE1;
    BOOLEAN Diff_BUSINESS_ADDR1;
    BOOLEAN Diff_RECORD_CODE2;
    BOOLEAN Diff_BUSINESS_ADDR2;
    BOOLEAN Diff_RECORD_CODE3;
    BOOLEAN Diff_BUS_CITY;
    BOOLEAN Diff_BUS_ST;
    BOOLEAN Diff_BUS_ZIP;
    BOOLEAN Diff_RECORD_CODE4;
    BOOLEAN Diff_ADDTL_BUSINESS;
    BOOLEAN Diff_RECORD_CODE5;
    BOOLEAN Diff_OWNER_TYPE;
    BOOLEAN Diff_RECORD_CODE6;
    BOOLEAN Diff_OWNER_ADDR1;
    BOOLEAN Diff_OWNER_CITY;
    BOOLEAN Diff_OWNER_ST;
    BOOLEAN Diff_OWNER_ZIP;
    BOOLEAN Diff_Owner_title;
    BOOLEAN Diff_Owner_fname;
    BOOLEAN Diff_Owner_mname;
    BOOLEAN Diff_Owner_lname;
    BOOLEAN Diff_Owner_name_suffix;
    BOOLEAN Diff_Owner_name_score;
    BOOLEAN Diff_prep_owner_addr_line1;
    BOOLEAN Diff_prep_owner_addr_line_last;
    UNSIGNED Num_Diffs;
    SALT37.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_business_name := le.business_name <> ri.business_name;
    SELF.Diff_filed_date := le.filed_date <> ri.filed_date;
    SELF.Diff_orig_filed_date := le.orig_filed_date <> ri.orig_filed_date;
    SELF.Diff_fbn_num := le.fbn_num <> ri.fbn_num;
    SELF.Diff_filing_type := le.filing_type <> ri.filing_type;
    SELF.Diff_owner_name := le.owner_name <> ri.owner_name;
    SELF.Diff_prep_addr_line1 := le.prep_addr_line1 <> ri.prep_addr_line1;
    SELF.Diff_prep_addr_line_last := le.prep_addr_line_last <> ri.prep_addr_line_last;
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_FBN_TYPE := le.FBN_TYPE <> ri.FBN_TYPE;
    SELF.Diff_BUSINESS_TYPE := le.BUSINESS_TYPE <> ri.BUSINESS_TYPE;
    SELF.Diff_ORIG_FBN_NUM := le.ORIG_FBN_NUM <> ri.ORIG_FBN_NUM;
    SELF.Diff_RECORD_CODE1 := le.RECORD_CODE1 <> ri.RECORD_CODE1;
    SELF.Diff_BUSINESS_ADDR1 := le.BUSINESS_ADDR1 <> ri.BUSINESS_ADDR1;
    SELF.Diff_RECORD_CODE2 := le.RECORD_CODE2 <> ri.RECORD_CODE2;
    SELF.Diff_BUSINESS_ADDR2 := le.BUSINESS_ADDR2 <> ri.BUSINESS_ADDR2;
    SELF.Diff_RECORD_CODE3 := le.RECORD_CODE3 <> ri.RECORD_CODE3;
    SELF.Diff_BUS_CITY := le.BUS_CITY <> ri.BUS_CITY;
    SELF.Diff_BUS_ST := le.BUS_ST <> ri.BUS_ST;
    SELF.Diff_BUS_ZIP := le.BUS_ZIP <> ri.BUS_ZIP;
    SELF.Diff_RECORD_CODE4 := le.RECORD_CODE4 <> ri.RECORD_CODE4;
    SELF.Diff_ADDTL_BUSINESS := le.ADDTL_BUSINESS <> ri.ADDTL_BUSINESS;
    SELF.Diff_RECORD_CODE5 := le.RECORD_CODE5 <> ri.RECORD_CODE5;
    SELF.Diff_OWNER_TYPE := le.OWNER_TYPE <> ri.OWNER_TYPE;
    SELF.Diff_RECORD_CODE6 := le.RECORD_CODE6 <> ri.RECORD_CODE6;
    SELF.Diff_OWNER_ADDR1 := le.OWNER_ADDR1 <> ri.OWNER_ADDR1;
    SELF.Diff_OWNER_CITY := le.OWNER_CITY <> ri.OWNER_CITY;
    SELF.Diff_OWNER_ST := le.OWNER_ST <> ri.OWNER_ST;
    SELF.Diff_OWNER_ZIP := le.OWNER_ZIP <> ri.OWNER_ZIP;
    SELF.Diff_Owner_title := le.Owner_title <> ri.Owner_title;
    SELF.Diff_Owner_fname := le.Owner_fname <> ri.Owner_fname;
    SELF.Diff_Owner_mname := le.Owner_mname <> ri.Owner_mname;
    SELF.Diff_Owner_lname := le.Owner_lname <> ri.Owner_lname;
    SELF.Diff_Owner_name_suffix := le.Owner_name_suffix <> ri.Owner_name_suffix;
    SELF.Diff_Owner_name_score := le.Owner_name_score <> ri.Owner_name_score;
    SELF.Diff_prep_owner_addr_line1 := le.prep_owner_addr_line1 <> ri.prep_owner_addr_line1;
    SELF.Diff_prep_owner_addr_line_last := le.prep_owner_addr_line_last <> ri.prep_owner_addr_line_last;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_business_name,1,0)+ IF( SELF.Diff_filed_date,1,0)+ IF( SELF.Diff_orig_filed_date,1,0)+ IF( SELF.Diff_fbn_num,1,0)+ IF( SELF.Diff_filing_type,1,0)+ IF( SELF.Diff_owner_name,1,0)+ IF( SELF.Diff_prep_addr_line1,1,0)+ IF( SELF.Diff_prep_addr_line_last,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_FBN_TYPE,1,0)+ IF( SELF.Diff_BUSINESS_TYPE,1,0)+ IF( SELF.Diff_ORIG_FBN_NUM,1,0)+ IF( SELF.Diff_RECORD_CODE1,1,0)+ IF( SELF.Diff_BUSINESS_ADDR1,1,0)+ IF( SELF.Diff_RECORD_CODE2,1,0)+ IF( SELF.Diff_BUSINESS_ADDR2,1,0)+ IF( SELF.Diff_RECORD_CODE3,1,0)+ IF( SELF.Diff_BUS_CITY,1,0)+ IF( SELF.Diff_BUS_ST,1,0)+ IF( SELF.Diff_BUS_ZIP,1,0)+ IF( SELF.Diff_RECORD_CODE4,1,0)+ IF( SELF.Diff_ADDTL_BUSINESS,1,0)+ IF( SELF.Diff_RECORD_CODE5,1,0)+ IF( SELF.Diff_OWNER_TYPE,1,0)+ IF( SELF.Diff_RECORD_CODE6,1,0)+ IF( SELF.Diff_OWNER_ADDR1,1,0)+ IF( SELF.Diff_OWNER_CITY,1,0)+ IF( SELF.Diff_OWNER_ST,1,0)+ IF( SELF.Diff_OWNER_ZIP,1,0)+ IF( SELF.Diff_Owner_title,1,0)+ IF( SELF.Diff_Owner_fname,1,0)+ IF( SELF.Diff_Owner_mname,1,0)+ IF( SELF.Diff_Owner_lname,1,0)+ IF( SELF.Diff_Owner_name_suffix,1,0)+ IF( SELF.Diff_Owner_name_score,1,0)+ IF( SELF.Diff_prep_owner_addr_line1,1,0)+ IF( SELF.Diff_prep_owner_addr_line_last,1,0);
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
    Count_Diff_filed_date := COUNT(GROUP,%Closest%.Diff_filed_date);
    Count_Diff_orig_filed_date := COUNT(GROUP,%Closest%.Diff_orig_filed_date);
    Count_Diff_fbn_num := COUNT(GROUP,%Closest%.Diff_fbn_num);
    Count_Diff_filing_type := COUNT(GROUP,%Closest%.Diff_filing_type);
    Count_Diff_owner_name := COUNT(GROUP,%Closest%.Diff_owner_name);
    Count_Diff_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_addr_line1);
    Count_Diff_prep_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_addr_line_last);
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_FBN_TYPE := COUNT(GROUP,%Closest%.Diff_FBN_TYPE);
    Count_Diff_BUSINESS_TYPE := COUNT(GROUP,%Closest%.Diff_BUSINESS_TYPE);
    Count_Diff_ORIG_FBN_NUM := COUNT(GROUP,%Closest%.Diff_ORIG_FBN_NUM);
    Count_Diff_RECORD_CODE1 := COUNT(GROUP,%Closest%.Diff_RECORD_CODE1);
    Count_Diff_BUSINESS_ADDR1 := COUNT(GROUP,%Closest%.Diff_BUSINESS_ADDR1);
    Count_Diff_RECORD_CODE2 := COUNT(GROUP,%Closest%.Diff_RECORD_CODE2);
    Count_Diff_BUSINESS_ADDR2 := COUNT(GROUP,%Closest%.Diff_BUSINESS_ADDR2);
    Count_Diff_RECORD_CODE3 := COUNT(GROUP,%Closest%.Diff_RECORD_CODE3);
    Count_Diff_BUS_CITY := COUNT(GROUP,%Closest%.Diff_BUS_CITY);
    Count_Diff_BUS_ST := COUNT(GROUP,%Closest%.Diff_BUS_ST);
    Count_Diff_BUS_ZIP := COUNT(GROUP,%Closest%.Diff_BUS_ZIP);
    Count_Diff_RECORD_CODE4 := COUNT(GROUP,%Closest%.Diff_RECORD_CODE4);
    Count_Diff_ADDTL_BUSINESS := COUNT(GROUP,%Closest%.Diff_ADDTL_BUSINESS);
    Count_Diff_RECORD_CODE5 := COUNT(GROUP,%Closest%.Diff_RECORD_CODE5);
    Count_Diff_OWNER_TYPE := COUNT(GROUP,%Closest%.Diff_OWNER_TYPE);
    Count_Diff_RECORD_CODE6 := COUNT(GROUP,%Closest%.Diff_RECORD_CODE6);
    Count_Diff_OWNER_ADDR1 := COUNT(GROUP,%Closest%.Diff_OWNER_ADDR1);
    Count_Diff_OWNER_CITY := COUNT(GROUP,%Closest%.Diff_OWNER_CITY);
    Count_Diff_OWNER_ST := COUNT(GROUP,%Closest%.Diff_OWNER_ST);
    Count_Diff_OWNER_ZIP := COUNT(GROUP,%Closest%.Diff_OWNER_ZIP);
    Count_Diff_Owner_title := COUNT(GROUP,%Closest%.Diff_Owner_title);
    Count_Diff_Owner_fname := COUNT(GROUP,%Closest%.Diff_Owner_fname);
    Count_Diff_Owner_mname := COUNT(GROUP,%Closest%.Diff_Owner_mname);
    Count_Diff_Owner_lname := COUNT(GROUP,%Closest%.Diff_Owner_lname);
    Count_Diff_Owner_name_suffix := COUNT(GROUP,%Closest%.Diff_Owner_name_suffix);
    Count_Diff_Owner_name_score := COUNT(GROUP,%Closest%.Diff_Owner_name_score);
    Count_Diff_prep_owner_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_owner_addr_line1);
    Count_Diff_prep_owner_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_owner_addr_line_last);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

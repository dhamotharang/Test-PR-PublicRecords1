IMPORT SALT37;
IMPORT Scrubs_FBNV2,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_CA_San_Diego_Fields := MODULE
 
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
 
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'business_name','file_date','prev_file_date','file_number','prev_file_number','filing_type','prep_addr_line1','prep_addr_line_last','TYPE_OF_RECORD','OWNER_NAME','fbn_type','PNAME','EXPIRATION_DATE','BUSINESS_START_DATE','OWNERSHIP_TYPE','TYPE_OF_NAME','TYPE_OF_NAME_SEQ_NUM','STREET_ADDRESS1','STREET_ADDRESS2','CITY','STATE','ZIP_CODE','COUNTRY','MAILING_ADDRESS1','MAILING_ADDRESS2','MAILING_CITY','MAILING_STATE','MAILING_ZIP_CODE','MAILING_COUNTRY','prep_mail_addr_line1','prep_mail_addr_line_last');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'business_name' => 0,'file_date' => 1,'prev_file_date' => 2,'file_number' => 3,'prev_file_number' => 4,'filing_type' => 5,'prep_addr_line1' => 6,'prep_addr_line_last' => 7,'TYPE_OF_RECORD' => 8,'OWNER_NAME' => 9,'fbn_type' => 10,'PNAME' => 11,'EXPIRATION_DATE' => 12,'BUSINESS_START_DATE' => 13,'OWNERSHIP_TYPE' => 14,'TYPE_OF_NAME' => 15,'TYPE_OF_NAME_SEQ_NUM' => 16,'STREET_ADDRESS1' => 17,'STREET_ADDRESS2' => 18,'CITY' => 19,'STATE' => 20,'ZIP_CODE' => 21,'COUNTRY' => 22,'MAILING_ADDRESS1' => 23,'MAILING_ADDRESS2' => 24,'MAILING_CITY' => 25,'MAILING_STATE' => 26,'MAILING_ZIP_CODE' => 27,'MAILING_COUNTRY' => 28,'prep_mail_addr_line1' => 29,'prep_mail_addr_line_last' => 30,0);
 
//Individual field level validation
 
EXPORT Make_business_name(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_business_name(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_business_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_file_date(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_file_date(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_file_date(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_prev_file_date(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_prev_file_date(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_prev_file_date(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_file_number(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_file_number(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_file_number(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prev_file_number(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prev_file_number(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prev_file_number(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_filing_type(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_filing_type(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_filing_type(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_line1(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line1(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_line_last(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line_last(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_TYPE_OF_RECORD(SALT37.StrType s0) := s0;
EXPORT InValid_TYPE_OF_RECORD(SALT37.StrType s) := 0;
EXPORT InValidMessage_TYPE_OF_RECORD(UNSIGNED1 wh) := '';
 
EXPORT Make_OWNER_NAME(SALT37.StrType s0) := s0;
EXPORT InValid_OWNER_NAME(SALT37.StrType s) := 0;
EXPORT InValidMessage_OWNER_NAME(UNSIGNED1 wh) := '';
 
EXPORT Make_fbn_type(SALT37.StrType s0) := s0;
EXPORT InValid_fbn_type(SALT37.StrType s) := 0;
EXPORT InValidMessage_fbn_type(UNSIGNED1 wh) := '';
 
EXPORT Make_PNAME(SALT37.StrType s0) := s0;
EXPORT InValid_PNAME(SALT37.StrType s) := 0;
EXPORT InValidMessage_PNAME(UNSIGNED1 wh) := '';
 
EXPORT Make_EXPIRATION_DATE(SALT37.StrType s0) := s0;
EXPORT InValid_EXPIRATION_DATE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EXPIRATION_DATE(UNSIGNED1 wh) := '';
 
EXPORT Make_BUSINESS_START_DATE(SALT37.StrType s0) := s0;
EXPORT InValid_BUSINESS_START_DATE(SALT37.StrType s) := 0;
EXPORT InValidMessage_BUSINESS_START_DATE(UNSIGNED1 wh) := '';
 
EXPORT Make_OWNERSHIP_TYPE(SALT37.StrType s0) := s0;
EXPORT InValid_OWNERSHIP_TYPE(SALT37.StrType s) := 0;
EXPORT InValidMessage_OWNERSHIP_TYPE(UNSIGNED1 wh) := '';
 
EXPORT Make_TYPE_OF_NAME(SALT37.StrType s0) := s0;
EXPORT InValid_TYPE_OF_NAME(SALT37.StrType s) := 0;
EXPORT InValidMessage_TYPE_OF_NAME(UNSIGNED1 wh) := '';
 
EXPORT Make_TYPE_OF_NAME_SEQ_NUM(SALT37.StrType s0) := s0;
EXPORT InValid_TYPE_OF_NAME_SEQ_NUM(SALT37.StrType s) := 0;
EXPORT InValidMessage_TYPE_OF_NAME_SEQ_NUM(UNSIGNED1 wh) := '';
 
EXPORT Make_STREET_ADDRESS1(SALT37.StrType s0) := s0;
EXPORT InValid_STREET_ADDRESS1(SALT37.StrType s) := 0;
EXPORT InValidMessage_STREET_ADDRESS1(UNSIGNED1 wh) := '';
 
EXPORT Make_STREET_ADDRESS2(SALT37.StrType s0) := s0;
EXPORT InValid_STREET_ADDRESS2(SALT37.StrType s) := 0;
EXPORT InValidMessage_STREET_ADDRESS2(UNSIGNED1 wh) := '';
 
EXPORT Make_CITY(SALT37.StrType s0) := s0;
EXPORT InValid_CITY(SALT37.StrType s) := 0;
EXPORT InValidMessage_CITY(UNSIGNED1 wh) := '';
 
EXPORT Make_STATE(SALT37.StrType s0) := s0;
EXPORT InValid_STATE(SALT37.StrType s) := 0;
EXPORT InValidMessage_STATE(UNSIGNED1 wh) := '';
 
EXPORT Make_ZIP_CODE(SALT37.StrType s0) := s0;
EXPORT InValid_ZIP_CODE(SALT37.StrType s) := 0;
EXPORT InValidMessage_ZIP_CODE(UNSIGNED1 wh) := '';
 
EXPORT Make_COUNTRY(SALT37.StrType s0) := s0;
EXPORT InValid_COUNTRY(SALT37.StrType s) := 0;
EXPORT InValidMessage_COUNTRY(UNSIGNED1 wh) := '';
 
EXPORT Make_MAILING_ADDRESS1(SALT37.StrType s0) := s0;
EXPORT InValid_MAILING_ADDRESS1(SALT37.StrType s) := 0;
EXPORT InValidMessage_MAILING_ADDRESS1(UNSIGNED1 wh) := '';
 
EXPORT Make_MAILING_ADDRESS2(SALT37.StrType s0) := s0;
EXPORT InValid_MAILING_ADDRESS2(SALT37.StrType s) := 0;
EXPORT InValidMessage_MAILING_ADDRESS2(UNSIGNED1 wh) := '';
 
EXPORT Make_MAILING_CITY(SALT37.StrType s0) := s0;
EXPORT InValid_MAILING_CITY(SALT37.StrType s) := 0;
EXPORT InValidMessage_MAILING_CITY(UNSIGNED1 wh) := '';
 
EXPORT Make_MAILING_STATE(SALT37.StrType s0) := s0;
EXPORT InValid_MAILING_STATE(SALT37.StrType s) := 0;
EXPORT InValidMessage_MAILING_STATE(UNSIGNED1 wh) := '';
 
EXPORT Make_MAILING_ZIP_CODE(SALT37.StrType s0) := s0;
EXPORT InValid_MAILING_ZIP_CODE(SALT37.StrType s) := 0;
EXPORT InValidMessage_MAILING_ZIP_CODE(UNSIGNED1 wh) := '';
 
EXPORT Make_MAILING_COUNTRY(SALT37.StrType s0) := s0;
EXPORT InValid_MAILING_COUNTRY(SALT37.StrType s) := 0;
EXPORT InValidMessage_MAILING_COUNTRY(UNSIGNED1 wh) := '';
 
EXPORT Make_prep_mail_addr_line1(SALT37.StrType s0) := s0;
EXPORT InValid_prep_mail_addr_line1(SALT37.StrType s) := 0;
EXPORT InValidMessage_prep_mail_addr_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_prep_mail_addr_line_last(SALT37.StrType s0) := s0;
EXPORT InValid_prep_mail_addr_line_last(SALT37.StrType s) := 0;
EXPORT InValidMessage_prep_mail_addr_line_last(UNSIGNED1 wh) := '';
 
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
    BOOLEAN Diff_prev_file_date;
    BOOLEAN Diff_file_number;
    BOOLEAN Diff_prev_file_number;
    BOOLEAN Diff_filing_type;
    BOOLEAN Diff_prep_addr_line1;
    BOOLEAN Diff_prep_addr_line_last;
    BOOLEAN Diff_TYPE_OF_RECORD;
    BOOLEAN Diff_OWNER_NAME;
    BOOLEAN Diff_fbn_type;
    BOOLEAN Diff_PNAME;
    BOOLEAN Diff_EXPIRATION_DATE;
    BOOLEAN Diff_BUSINESS_START_DATE;
    BOOLEAN Diff_OWNERSHIP_TYPE;
    BOOLEAN Diff_TYPE_OF_NAME;
    BOOLEAN Diff_TYPE_OF_NAME_SEQ_NUM;
    BOOLEAN Diff_STREET_ADDRESS1;
    BOOLEAN Diff_STREET_ADDRESS2;
    BOOLEAN Diff_CITY;
    BOOLEAN Diff_STATE;
    BOOLEAN Diff_ZIP_CODE;
    BOOLEAN Diff_COUNTRY;
    BOOLEAN Diff_MAILING_ADDRESS1;
    BOOLEAN Diff_MAILING_ADDRESS2;
    BOOLEAN Diff_MAILING_CITY;
    BOOLEAN Diff_MAILING_STATE;
    BOOLEAN Diff_MAILING_ZIP_CODE;
    BOOLEAN Diff_MAILING_COUNTRY;
    BOOLEAN Diff_prep_mail_addr_line1;
    BOOLEAN Diff_prep_mail_addr_line_last;
    UNSIGNED Num_Diffs;
    SALT37.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_business_name := le.business_name <> ri.business_name;
    SELF.Diff_file_date := le.file_date <> ri.file_date;
    SELF.Diff_prev_file_date := le.prev_file_date <> ri.prev_file_date;
    SELF.Diff_file_number := le.file_number <> ri.file_number;
    SELF.Diff_prev_file_number := le.prev_file_number <> ri.prev_file_number;
    SELF.Diff_filing_type := le.filing_type <> ri.filing_type;
    SELF.Diff_prep_addr_line1 := le.prep_addr_line1 <> ri.prep_addr_line1;
    SELF.Diff_prep_addr_line_last := le.prep_addr_line_last <> ri.prep_addr_line_last;
    SELF.Diff_TYPE_OF_RECORD := le.TYPE_OF_RECORD <> ri.TYPE_OF_RECORD;
    SELF.Diff_OWNER_NAME := le.OWNER_NAME <> ri.OWNER_NAME;
    SELF.Diff_fbn_type := le.fbn_type <> ri.fbn_type;
    SELF.Diff_PNAME := le.PNAME <> ri.PNAME;
    SELF.Diff_EXPIRATION_DATE := le.EXPIRATION_DATE <> ri.EXPIRATION_DATE;
    SELF.Diff_BUSINESS_START_DATE := le.BUSINESS_START_DATE <> ri.BUSINESS_START_DATE;
    SELF.Diff_OWNERSHIP_TYPE := le.OWNERSHIP_TYPE <> ri.OWNERSHIP_TYPE;
    SELF.Diff_TYPE_OF_NAME := le.TYPE_OF_NAME <> ri.TYPE_OF_NAME;
    SELF.Diff_TYPE_OF_NAME_SEQ_NUM := le.TYPE_OF_NAME_SEQ_NUM <> ri.TYPE_OF_NAME_SEQ_NUM;
    SELF.Diff_STREET_ADDRESS1 := le.STREET_ADDRESS1 <> ri.STREET_ADDRESS1;
    SELF.Diff_STREET_ADDRESS2 := le.STREET_ADDRESS2 <> ri.STREET_ADDRESS2;
    SELF.Diff_CITY := le.CITY <> ri.CITY;
    SELF.Diff_STATE := le.STATE <> ri.STATE;
    SELF.Diff_ZIP_CODE := le.ZIP_CODE <> ri.ZIP_CODE;
    SELF.Diff_COUNTRY := le.COUNTRY <> ri.COUNTRY;
    SELF.Diff_MAILING_ADDRESS1 := le.MAILING_ADDRESS1 <> ri.MAILING_ADDRESS1;
    SELF.Diff_MAILING_ADDRESS2 := le.MAILING_ADDRESS2 <> ri.MAILING_ADDRESS2;
    SELF.Diff_MAILING_CITY := le.MAILING_CITY <> ri.MAILING_CITY;
    SELF.Diff_MAILING_STATE := le.MAILING_STATE <> ri.MAILING_STATE;
    SELF.Diff_MAILING_ZIP_CODE := le.MAILING_ZIP_CODE <> ri.MAILING_ZIP_CODE;
    SELF.Diff_MAILING_COUNTRY := le.MAILING_COUNTRY <> ri.MAILING_COUNTRY;
    SELF.Diff_prep_mail_addr_line1 := le.prep_mail_addr_line1 <> ri.prep_mail_addr_line1;
    SELF.Diff_prep_mail_addr_line_last := le.prep_mail_addr_line_last <> ri.prep_mail_addr_line_last;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_business_name,1,0)+ IF( SELF.Diff_file_date,1,0)+ IF( SELF.Diff_prev_file_date,1,0)+ IF( SELF.Diff_file_number,1,0)+ IF( SELF.Diff_prev_file_number,1,0)+ IF( SELF.Diff_filing_type,1,0)+ IF( SELF.Diff_prep_addr_line1,1,0)+ IF( SELF.Diff_prep_addr_line_last,1,0)+ IF( SELF.Diff_TYPE_OF_RECORD,1,0)+ IF( SELF.Diff_OWNER_NAME,1,0)+ IF( SELF.Diff_fbn_type,1,0)+ IF( SELF.Diff_PNAME,1,0)+ IF( SELF.Diff_EXPIRATION_DATE,1,0)+ IF( SELF.Diff_BUSINESS_START_DATE,1,0)+ IF( SELF.Diff_OWNERSHIP_TYPE,1,0)+ IF( SELF.Diff_TYPE_OF_NAME,1,0)+ IF( SELF.Diff_TYPE_OF_NAME_SEQ_NUM,1,0)+ IF( SELF.Diff_STREET_ADDRESS1,1,0)+ IF( SELF.Diff_STREET_ADDRESS2,1,0)+ IF( SELF.Diff_CITY,1,0)+ IF( SELF.Diff_STATE,1,0)+ IF( SELF.Diff_ZIP_CODE,1,0)+ IF( SELF.Diff_COUNTRY,1,0)+ IF( SELF.Diff_MAILING_ADDRESS1,1,0)+ IF( SELF.Diff_MAILING_ADDRESS2,1,0)+ IF( SELF.Diff_MAILING_CITY,1,0)+ IF( SELF.Diff_MAILING_STATE,1,0)+ IF( SELF.Diff_MAILING_ZIP_CODE,1,0)+ IF( SELF.Diff_MAILING_COUNTRY,1,0)+ IF( SELF.Diff_prep_mail_addr_line1,1,0)+ IF( SELF.Diff_prep_mail_addr_line_last,1,0);
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
    Count_Diff_prev_file_date := COUNT(GROUP,%Closest%.Diff_prev_file_date);
    Count_Diff_file_number := COUNT(GROUP,%Closest%.Diff_file_number);
    Count_Diff_prev_file_number := COUNT(GROUP,%Closest%.Diff_prev_file_number);
    Count_Diff_filing_type := COUNT(GROUP,%Closest%.Diff_filing_type);
    Count_Diff_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_addr_line1);
    Count_Diff_prep_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_addr_line_last);
    Count_Diff_TYPE_OF_RECORD := COUNT(GROUP,%Closest%.Diff_TYPE_OF_RECORD);
    Count_Diff_OWNER_NAME := COUNT(GROUP,%Closest%.Diff_OWNER_NAME);
    Count_Diff_fbn_type := COUNT(GROUP,%Closest%.Diff_fbn_type);
    Count_Diff_PNAME := COUNT(GROUP,%Closest%.Diff_PNAME);
    Count_Diff_EXPIRATION_DATE := COUNT(GROUP,%Closest%.Diff_EXPIRATION_DATE);
    Count_Diff_BUSINESS_START_DATE := COUNT(GROUP,%Closest%.Diff_BUSINESS_START_DATE);
    Count_Diff_OWNERSHIP_TYPE := COUNT(GROUP,%Closest%.Diff_OWNERSHIP_TYPE);
    Count_Diff_TYPE_OF_NAME := COUNT(GROUP,%Closest%.Diff_TYPE_OF_NAME);
    Count_Diff_TYPE_OF_NAME_SEQ_NUM := COUNT(GROUP,%Closest%.Diff_TYPE_OF_NAME_SEQ_NUM);
    Count_Diff_STREET_ADDRESS1 := COUNT(GROUP,%Closest%.Diff_STREET_ADDRESS1);
    Count_Diff_STREET_ADDRESS2 := COUNT(GROUP,%Closest%.Diff_STREET_ADDRESS2);
    Count_Diff_CITY := COUNT(GROUP,%Closest%.Diff_CITY);
    Count_Diff_STATE := COUNT(GROUP,%Closest%.Diff_STATE);
    Count_Diff_ZIP_CODE := COUNT(GROUP,%Closest%.Diff_ZIP_CODE);
    Count_Diff_COUNTRY := COUNT(GROUP,%Closest%.Diff_COUNTRY);
    Count_Diff_MAILING_ADDRESS1 := COUNT(GROUP,%Closest%.Diff_MAILING_ADDRESS1);
    Count_Diff_MAILING_ADDRESS2 := COUNT(GROUP,%Closest%.Diff_MAILING_ADDRESS2);
    Count_Diff_MAILING_CITY := COUNT(GROUP,%Closest%.Diff_MAILING_CITY);
    Count_Diff_MAILING_STATE := COUNT(GROUP,%Closest%.Diff_MAILING_STATE);
    Count_Diff_MAILING_ZIP_CODE := COUNT(GROUP,%Closest%.Diff_MAILING_ZIP_CODE);
    Count_Diff_MAILING_COUNTRY := COUNT(GROUP,%Closest%.Diff_MAILING_COUNTRY);
    Count_Diff_prep_mail_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_mail_addr_line1);
    Count_Diff_prep_mail_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_mail_addr_line_last);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

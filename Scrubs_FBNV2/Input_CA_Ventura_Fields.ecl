IMPORT SALT37;
IMPORT Scrubs_FBNV2,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_CA_Ventura_Fields := MODULE
 
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
 
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'business_name','recorded_date','start_date','abandondate','file_number','owner_name','prep_bus_addr_line1','prep_bus_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','instrument_id','recorded_time','business_street','business_city','business_state','business_zip5','business_zip4','mail_street','mail_city','mail_state','mail_zip5','mail_zip4','owner_firstname','owner_address','owner_city','owner_state','owner_zipcode5','owner_zipcode4','short_legal','file_year','file_seq','pname','Owner_cln_title','Owner_cln_fname','Owner_cln_mname','Owner_cln_lname','Owner_cln_name_suffix','Owner_cln_name_score','cname','prep_mail_addr_line1','prep_mail_addr_line_last');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'business_name' => 0,'recorded_date' => 1,'start_date' => 2,'abandondate' => 3,'file_number' => 4,'owner_name' => 5,'prep_bus_addr_line1' => 6,'prep_bus_addr_line_last' => 7,'prep_owner_addr_line1' => 8,'prep_owner_addr_line_last' => 9,'instrument_id' => 10,'recorded_time' => 11,'business_street' => 12,'business_city' => 13,'business_state' => 14,'business_zip5' => 15,'business_zip4' => 16,'mail_street' => 17,'mail_city' => 18,'mail_state' => 19,'mail_zip5' => 20,'mail_zip4' => 21,'owner_firstname' => 22,'owner_address' => 23,'owner_city' => 24,'owner_state' => 25,'owner_zipcode5' => 26,'owner_zipcode4' => 27,'short_legal' => 28,'file_year' => 29,'file_seq' => 30,'pname' => 31,'Owner_cln_title' => 32,'Owner_cln_fname' => 33,'Owner_cln_mname' => 34,'Owner_cln_lname' => 35,'Owner_cln_name_suffix' => 36,'Owner_cln_name_score' => 37,'cname' => 38,'prep_mail_addr_line1' => 39,'prep_mail_addr_line_last' => 40,0);
 
//Individual field level validation
 
EXPORT Make_business_name(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_business_name(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_business_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_recorded_date(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_recorded_date(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_recorded_date(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_start_date(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_start_date(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_start_date(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_abandondate(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_abandondate(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_abandondate(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_file_number(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_file_number(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_file_number(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_owner_name(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_owner_name(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_owner_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
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
 
EXPORT Make_instrument_id(SALT37.StrType s0) := s0;
EXPORT InValid_instrument_id(SALT37.StrType s) := 0;
EXPORT InValidMessage_instrument_id(UNSIGNED1 wh) := '';
 
EXPORT Make_recorded_time(SALT37.StrType s0) := s0;
EXPORT InValid_recorded_time(SALT37.StrType s) := 0;
EXPORT InValidMessage_recorded_time(UNSIGNED1 wh) := '';
 
EXPORT Make_business_street(SALT37.StrType s0) := s0;
EXPORT InValid_business_street(SALT37.StrType s) := 0;
EXPORT InValidMessage_business_street(UNSIGNED1 wh) := '';
 
EXPORT Make_business_city(SALT37.StrType s0) := s0;
EXPORT InValid_business_city(SALT37.StrType s) := 0;
EXPORT InValidMessage_business_city(UNSIGNED1 wh) := '';
 
EXPORT Make_business_state(SALT37.StrType s0) := s0;
EXPORT InValid_business_state(SALT37.StrType s) := 0;
EXPORT InValidMessage_business_state(UNSIGNED1 wh) := '';
 
EXPORT Make_business_zip5(SALT37.StrType s0) := s0;
EXPORT InValid_business_zip5(SALT37.StrType s) := 0;
EXPORT InValidMessage_business_zip5(UNSIGNED1 wh) := '';
 
EXPORT Make_business_zip4(SALT37.StrType s0) := s0;
EXPORT InValid_business_zip4(SALT37.StrType s) := 0;
EXPORT InValidMessage_business_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_street(SALT37.StrType s0) := s0;
EXPORT InValid_mail_street(SALT37.StrType s) := 0;
EXPORT InValidMessage_mail_street(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_city(SALT37.StrType s0) := s0;
EXPORT InValid_mail_city(SALT37.StrType s) := 0;
EXPORT InValidMessage_mail_city(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_state(SALT37.StrType s0) := s0;
EXPORT InValid_mail_state(SALT37.StrType s) := 0;
EXPORT InValidMessage_mail_state(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_zip5(SALT37.StrType s0) := s0;
EXPORT InValid_mail_zip5(SALT37.StrType s) := 0;
EXPORT InValidMessage_mail_zip5(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_zip4(SALT37.StrType s0) := s0;
EXPORT InValid_mail_zip4(SALT37.StrType s) := 0;
EXPORT InValidMessage_mail_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_owner_firstname(SALT37.StrType s0) := s0;
EXPORT InValid_owner_firstname(SALT37.StrType s) := 0;
EXPORT InValidMessage_owner_firstname(UNSIGNED1 wh) := '';
 
EXPORT Make_owner_address(SALT37.StrType s0) := s0;
EXPORT InValid_owner_address(SALT37.StrType s) := 0;
EXPORT InValidMessage_owner_address(UNSIGNED1 wh) := '';
 
EXPORT Make_owner_city(SALT37.StrType s0) := s0;
EXPORT InValid_owner_city(SALT37.StrType s) := 0;
EXPORT InValidMessage_owner_city(UNSIGNED1 wh) := '';
 
EXPORT Make_owner_state(SALT37.StrType s0) := s0;
EXPORT InValid_owner_state(SALT37.StrType s) := 0;
EXPORT InValidMessage_owner_state(UNSIGNED1 wh) := '';
 
EXPORT Make_owner_zipcode5(SALT37.StrType s0) := s0;
EXPORT InValid_owner_zipcode5(SALT37.StrType s) := 0;
EXPORT InValidMessage_owner_zipcode5(UNSIGNED1 wh) := '';
 
EXPORT Make_owner_zipcode4(SALT37.StrType s0) := s0;
EXPORT InValid_owner_zipcode4(SALT37.StrType s) := 0;
EXPORT InValidMessage_owner_zipcode4(UNSIGNED1 wh) := '';
 
EXPORT Make_short_legal(SALT37.StrType s0) := s0;
EXPORT InValid_short_legal(SALT37.StrType s) := 0;
EXPORT InValidMessage_short_legal(UNSIGNED1 wh) := '';
 
EXPORT Make_file_year(SALT37.StrType s0) := s0;
EXPORT InValid_file_year(SALT37.StrType s) := 0;
EXPORT InValidMessage_file_year(UNSIGNED1 wh) := '';
 
EXPORT Make_file_seq(SALT37.StrType s0) := s0;
EXPORT InValid_file_seq(SALT37.StrType s) := 0;
EXPORT InValidMessage_file_seq(UNSIGNED1 wh) := '';
 
EXPORT Make_pname(SALT37.StrType s0) := s0;
EXPORT InValid_pname(SALT37.StrType s) := 0;
EXPORT InValidMessage_pname(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_cln_title(SALT37.StrType s0) := s0;
EXPORT InValid_Owner_cln_title(SALT37.StrType s) := 0;
EXPORT InValidMessage_Owner_cln_title(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_cln_fname(SALT37.StrType s0) := s0;
EXPORT InValid_Owner_cln_fname(SALT37.StrType s) := 0;
EXPORT InValidMessage_Owner_cln_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_cln_mname(SALT37.StrType s0) := s0;
EXPORT InValid_Owner_cln_mname(SALT37.StrType s) := 0;
EXPORT InValidMessage_Owner_cln_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_cln_lname(SALT37.StrType s0) := s0;
EXPORT InValid_Owner_cln_lname(SALT37.StrType s) := 0;
EXPORT InValidMessage_Owner_cln_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_cln_name_suffix(SALT37.StrType s0) := s0;
EXPORT InValid_Owner_cln_name_suffix(SALT37.StrType s) := 0;
EXPORT InValidMessage_Owner_cln_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_cln_name_score(SALT37.StrType s0) := s0;
EXPORT InValid_Owner_cln_name_score(SALT37.StrType s) := 0;
EXPORT InValidMessage_Owner_cln_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_cname(SALT37.StrType s0) := s0;
EXPORT InValid_cname(SALT37.StrType s) := 0;
EXPORT InValidMessage_cname(UNSIGNED1 wh) := '';
 
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
    BOOLEAN Diff_recorded_date;
    BOOLEAN Diff_start_date;
    BOOLEAN Diff_abandondate;
    BOOLEAN Diff_file_number;
    BOOLEAN Diff_owner_name;
    BOOLEAN Diff_prep_bus_addr_line1;
    BOOLEAN Diff_prep_bus_addr_line_last;
    BOOLEAN Diff_prep_owner_addr_line1;
    BOOLEAN Diff_prep_owner_addr_line_last;
    BOOLEAN Diff_instrument_id;
    BOOLEAN Diff_recorded_time;
    BOOLEAN Diff_business_street;
    BOOLEAN Diff_business_city;
    BOOLEAN Diff_business_state;
    BOOLEAN Diff_business_zip5;
    BOOLEAN Diff_business_zip4;
    BOOLEAN Diff_mail_street;
    BOOLEAN Diff_mail_city;
    BOOLEAN Diff_mail_state;
    BOOLEAN Diff_mail_zip5;
    BOOLEAN Diff_mail_zip4;
    BOOLEAN Diff_owner_firstname;
    BOOLEAN Diff_owner_address;
    BOOLEAN Diff_owner_city;
    BOOLEAN Diff_owner_state;
    BOOLEAN Diff_owner_zipcode5;
    BOOLEAN Diff_owner_zipcode4;
    BOOLEAN Diff_short_legal;
    BOOLEAN Diff_file_year;
    BOOLEAN Diff_file_seq;
    BOOLEAN Diff_pname;
    BOOLEAN Diff_Owner_cln_title;
    BOOLEAN Diff_Owner_cln_fname;
    BOOLEAN Diff_Owner_cln_mname;
    BOOLEAN Diff_Owner_cln_lname;
    BOOLEAN Diff_Owner_cln_name_suffix;
    BOOLEAN Diff_Owner_cln_name_score;
    BOOLEAN Diff_cname;
    BOOLEAN Diff_prep_mail_addr_line1;
    BOOLEAN Diff_prep_mail_addr_line_last;
    UNSIGNED Num_Diffs;
    SALT37.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_business_name := le.business_name <> ri.business_name;
    SELF.Diff_recorded_date := le.recorded_date <> ri.recorded_date;
    SELF.Diff_start_date := le.start_date <> ri.start_date;
    SELF.Diff_abandondate := le.abandondate <> ri.abandondate;
    SELF.Diff_file_number := le.file_number <> ri.file_number;
    SELF.Diff_owner_name := le.owner_name <> ri.owner_name;
    SELF.Diff_prep_bus_addr_line1 := le.prep_bus_addr_line1 <> ri.prep_bus_addr_line1;
    SELF.Diff_prep_bus_addr_line_last := le.prep_bus_addr_line_last <> ri.prep_bus_addr_line_last;
    SELF.Diff_prep_owner_addr_line1 := le.prep_owner_addr_line1 <> ri.prep_owner_addr_line1;
    SELF.Diff_prep_owner_addr_line_last := le.prep_owner_addr_line_last <> ri.prep_owner_addr_line_last;
    SELF.Diff_instrument_id := le.instrument_id <> ri.instrument_id;
    SELF.Diff_recorded_time := le.recorded_time <> ri.recorded_time;
    SELF.Diff_business_street := le.business_street <> ri.business_street;
    SELF.Diff_business_city := le.business_city <> ri.business_city;
    SELF.Diff_business_state := le.business_state <> ri.business_state;
    SELF.Diff_business_zip5 := le.business_zip5 <> ri.business_zip5;
    SELF.Diff_business_zip4 := le.business_zip4 <> ri.business_zip4;
    SELF.Diff_mail_street := le.mail_street <> ri.mail_street;
    SELF.Diff_mail_city := le.mail_city <> ri.mail_city;
    SELF.Diff_mail_state := le.mail_state <> ri.mail_state;
    SELF.Diff_mail_zip5 := le.mail_zip5 <> ri.mail_zip5;
    SELF.Diff_mail_zip4 := le.mail_zip4 <> ri.mail_zip4;
    SELF.Diff_owner_firstname := le.owner_firstname <> ri.owner_firstname;
    SELF.Diff_owner_address := le.owner_address <> ri.owner_address;
    SELF.Diff_owner_city := le.owner_city <> ri.owner_city;
    SELF.Diff_owner_state := le.owner_state <> ri.owner_state;
    SELF.Diff_owner_zipcode5 := le.owner_zipcode5 <> ri.owner_zipcode5;
    SELF.Diff_owner_zipcode4 := le.owner_zipcode4 <> ri.owner_zipcode4;
    SELF.Diff_short_legal := le.short_legal <> ri.short_legal;
    SELF.Diff_file_year := le.file_year <> ri.file_year;
    SELF.Diff_file_seq := le.file_seq <> ri.file_seq;
    SELF.Diff_pname := le.pname <> ri.pname;
    SELF.Diff_Owner_cln_title := le.Owner_cln_title <> ri.Owner_cln_title;
    SELF.Diff_Owner_cln_fname := le.Owner_cln_fname <> ri.Owner_cln_fname;
    SELF.Diff_Owner_cln_mname := le.Owner_cln_mname <> ri.Owner_cln_mname;
    SELF.Diff_Owner_cln_lname := le.Owner_cln_lname <> ri.Owner_cln_lname;
    SELF.Diff_Owner_cln_name_suffix := le.Owner_cln_name_suffix <> ri.Owner_cln_name_suffix;
    SELF.Diff_Owner_cln_name_score := le.Owner_cln_name_score <> ri.Owner_cln_name_score;
    SELF.Diff_cname := le.cname <> ri.cname;
    SELF.Diff_prep_mail_addr_line1 := le.prep_mail_addr_line1 <> ri.prep_mail_addr_line1;
    SELF.Diff_prep_mail_addr_line_last := le.prep_mail_addr_line_last <> ri.prep_mail_addr_line_last;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_business_name,1,0)+ IF( SELF.Diff_recorded_date,1,0)+ IF( SELF.Diff_start_date,1,0)+ IF( SELF.Diff_abandondate,1,0)+ IF( SELF.Diff_file_number,1,0)+ IF( SELF.Diff_owner_name,1,0)+ IF( SELF.Diff_prep_bus_addr_line1,1,0)+ IF( SELF.Diff_prep_bus_addr_line_last,1,0)+ IF( SELF.Diff_prep_owner_addr_line1,1,0)+ IF( SELF.Diff_prep_owner_addr_line_last,1,0)+ IF( SELF.Diff_instrument_id,1,0)+ IF( SELF.Diff_recorded_time,1,0)+ IF( SELF.Diff_business_street,1,0)+ IF( SELF.Diff_business_city,1,0)+ IF( SELF.Diff_business_state,1,0)+ IF( SELF.Diff_business_zip5,1,0)+ IF( SELF.Diff_business_zip4,1,0)+ IF( SELF.Diff_mail_street,1,0)+ IF( SELF.Diff_mail_city,1,0)+ IF( SELF.Diff_mail_state,1,0)+ IF( SELF.Diff_mail_zip5,1,0)+ IF( SELF.Diff_mail_zip4,1,0)+ IF( SELF.Diff_owner_firstname,1,0)+ IF( SELF.Diff_owner_address,1,0)+ IF( SELF.Diff_owner_city,1,0)+ IF( SELF.Diff_owner_state,1,0)+ IF( SELF.Diff_owner_zipcode5,1,0)+ IF( SELF.Diff_owner_zipcode4,1,0)+ IF( SELF.Diff_short_legal,1,0)+ IF( SELF.Diff_file_year,1,0)+ IF( SELF.Diff_file_seq,1,0)+ IF( SELF.Diff_pname,1,0)+ IF( SELF.Diff_Owner_cln_title,1,0)+ IF( SELF.Diff_Owner_cln_fname,1,0)+ IF( SELF.Diff_Owner_cln_mname,1,0)+ IF( SELF.Diff_Owner_cln_lname,1,0)+ IF( SELF.Diff_Owner_cln_name_suffix,1,0)+ IF( SELF.Diff_Owner_cln_name_score,1,0)+ IF( SELF.Diff_cname,1,0)+ IF( SELF.Diff_prep_mail_addr_line1,1,0)+ IF( SELF.Diff_prep_mail_addr_line_last,1,0);
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
    Count_Diff_recorded_date := COUNT(GROUP,%Closest%.Diff_recorded_date);
    Count_Diff_start_date := COUNT(GROUP,%Closest%.Diff_start_date);
    Count_Diff_abandondate := COUNT(GROUP,%Closest%.Diff_abandondate);
    Count_Diff_file_number := COUNT(GROUP,%Closest%.Diff_file_number);
    Count_Diff_owner_name := COUNT(GROUP,%Closest%.Diff_owner_name);
    Count_Diff_prep_bus_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_bus_addr_line1);
    Count_Diff_prep_bus_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_bus_addr_line_last);
    Count_Diff_prep_owner_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_owner_addr_line1);
    Count_Diff_prep_owner_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_owner_addr_line_last);
    Count_Diff_instrument_id := COUNT(GROUP,%Closest%.Diff_instrument_id);
    Count_Diff_recorded_time := COUNT(GROUP,%Closest%.Diff_recorded_time);
    Count_Diff_business_street := COUNT(GROUP,%Closest%.Diff_business_street);
    Count_Diff_business_city := COUNT(GROUP,%Closest%.Diff_business_city);
    Count_Diff_business_state := COUNT(GROUP,%Closest%.Diff_business_state);
    Count_Diff_business_zip5 := COUNT(GROUP,%Closest%.Diff_business_zip5);
    Count_Diff_business_zip4 := COUNT(GROUP,%Closest%.Diff_business_zip4);
    Count_Diff_mail_street := COUNT(GROUP,%Closest%.Diff_mail_street);
    Count_Diff_mail_city := COUNT(GROUP,%Closest%.Diff_mail_city);
    Count_Diff_mail_state := COUNT(GROUP,%Closest%.Diff_mail_state);
    Count_Diff_mail_zip5 := COUNT(GROUP,%Closest%.Diff_mail_zip5);
    Count_Diff_mail_zip4 := COUNT(GROUP,%Closest%.Diff_mail_zip4);
    Count_Diff_owner_firstname := COUNT(GROUP,%Closest%.Diff_owner_firstname);
    Count_Diff_owner_address := COUNT(GROUP,%Closest%.Diff_owner_address);
    Count_Diff_owner_city := COUNT(GROUP,%Closest%.Diff_owner_city);
    Count_Diff_owner_state := COUNT(GROUP,%Closest%.Diff_owner_state);
    Count_Diff_owner_zipcode5 := COUNT(GROUP,%Closest%.Diff_owner_zipcode5);
    Count_Diff_owner_zipcode4 := COUNT(GROUP,%Closest%.Diff_owner_zipcode4);
    Count_Diff_short_legal := COUNT(GROUP,%Closest%.Diff_short_legal);
    Count_Diff_file_year := COUNT(GROUP,%Closest%.Diff_file_year);
    Count_Diff_file_seq := COUNT(GROUP,%Closest%.Diff_file_seq);
    Count_Diff_pname := COUNT(GROUP,%Closest%.Diff_pname);
    Count_Diff_Owner_cln_title := COUNT(GROUP,%Closest%.Diff_Owner_cln_title);
    Count_Diff_Owner_cln_fname := COUNT(GROUP,%Closest%.Diff_Owner_cln_fname);
    Count_Diff_Owner_cln_mname := COUNT(GROUP,%Closest%.Diff_Owner_cln_mname);
    Count_Diff_Owner_cln_lname := COUNT(GROUP,%Closest%.Diff_Owner_cln_lname);
    Count_Diff_Owner_cln_name_suffix := COUNT(GROUP,%Closest%.Diff_Owner_cln_name_suffix);
    Count_Diff_Owner_cln_name_score := COUNT(GROUP,%Closest%.Diff_Owner_cln_name_score);
    Count_Diff_cname := COUNT(GROUP,%Closest%.Diff_cname);
    Count_Diff_prep_mail_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_mail_addr_line1);
    Count_Diff_prep_mail_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_mail_addr_line_last);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

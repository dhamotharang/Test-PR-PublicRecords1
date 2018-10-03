IMPORT SALT37;
IMPORT Scrubs_Equifax_Business_Data; // Import modules for FieldTypes attribute definitions
EXPORT Input_Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT37.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_name','invalid_legal_name','invalid_mandatory','invalid_zero_integer','invalid_record_type','invalid_numeric','invalid_numeric_or_blank','invalid_percentage','invalid_direction','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dbpc','invalid_chk_digit','invalid_rec_type','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','invalid_raw_aid','invalid_ace_aid','invalid_st','invalid_zip5','invalid_zip4','invalid_phone','invalid_rcid','invalid_sic','invalid_naics','invalid_url','invalid_address_type_code','invalid_norm_type','invalid_email','invalid_yes_blank','invalid_business_size','invalid_cert_or_class','invalid_current_future_date','invalid_current_past_date','invalid_future_date','invalid_general_date','invalid_past_date','invalid_year_established','invalid_date_created','invalid_date_seen','invalid_reformated_date','invalid_vendor_reported_date','invalid_process_date','invalid_busstatcd','invalid_cmsa','invalid_corpamountcd','invalid_corpamountprec','invalid_corpamounttp','invalid_corpempcd','invalid_ctryisocd','invalid_ctrynum','invalid_ctrytelcd','invalid_geoprec','invalid_merctype','invalid_mrkt_telescore','invalid_mrkt_totalind','invalid_mrkt_totalscore','invalid_public','invalid_statec','invalid_stkexc');
EXPORT FieldTypeNum(SALT37.StrType fn) := CASE(fn,'invalid_name' => 1,'invalid_legal_name' => 2,'invalid_mandatory' => 3,'invalid_zero_integer' => 4,'invalid_record_type' => 5,'invalid_numeric' => 6,'invalid_numeric_or_blank' => 7,'invalid_percentage' => 8,'invalid_direction' => 9,'invalid_cart' => 10,'invalid_cr_sort_sz' => 11,'invalid_lot' => 12,'invalid_lot_order' => 13,'invalid_dbpc' => 14,'invalid_chk_digit' => 15,'invalid_rec_type' => 16,'invalid_fips_state' => 17,'invalid_fips_county' => 18,'invalid_geo' => 19,'invalid_msa' => 20,'invalid_geo_blk' => 21,'invalid_geo_match' => 22,'invalid_err_stat' => 23,'invalid_raw_aid' => 24,'invalid_ace_aid' => 25,'invalid_st' => 26,'invalid_zip5' => 27,'invalid_zip4' => 28,'invalid_phone' => 29,'invalid_rcid' => 30,'invalid_sic' => 31,'invalid_naics' => 32,'invalid_url' => 33,'invalid_address_type_code' => 34,'invalid_norm_type' => 35,'invalid_email' => 36,'invalid_yes_blank' => 37,'invalid_business_size' => 38,'invalid_cert_or_class' => 39,'invalid_current_future_date' => 40,'invalid_current_past_date' => 41,'invalid_future_date' => 42,'invalid_general_date' => 43,'invalid_past_date' => 44,'invalid_year_established' => 45,'invalid_date_created' => 46,'invalid_date_seen' => 47,'invalid_reformated_date' => 48,'invalid_vendor_reported_date' => 49,'invalid_process_date' => 50,'invalid_busstatcd' => 51,'invalid_cmsa' => 52,'invalid_corpamountcd' => 53,'invalid_corpamountprec' => 54,'invalid_corpamounttp' => 55,'invalid_corpempcd' => 56,'invalid_ctryisocd' => 57,'invalid_ctrynum' => 58,'invalid_ctrytelcd' => 59,'invalid_geoprec' => 60,'invalid_merctype' => 61,'invalid_mrkt_telescore' => 62,'invalid_mrkt_totalind' => 63,'invalid_mrkt_totalscore' => 64,'invalid_public' => 65,'invalid_statec' => 66,'invalid_stkexc' => 67,0);
 
EXPORT MakeFT_invalid_name(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_invalid_name(s)>0);
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_invalid_name'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_legal_name(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_legal_name(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_invalid_legal_name(s)>0);
EXPORT InValidMessageFT_invalid_legal_name(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_invalid_legal_name'),SALT37.HygieneErrors.Good);
 
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
EXPORT InValidFT_invalid_numeric(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_or_blank(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric_or_blank(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric_or_blank(s)>0);
EXPORT InValidMessageFT_invalid_numeric_or_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric_or_blank'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_percentage(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_percentage(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_range_numeric(s,0,100)>0);
EXPORT InValidMessageFT_invalid_percentage(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_range_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_direction(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_direction(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['E','N','S','W','NE','NW','SE','SW','']);
EXPORT InValidMessageFT_invalid_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('E|N|S|W|NE|NW|SE|SW|'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cart(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cart(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_alphanum(s,4)>0);
EXPORT InValidMessageFT_invalid_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_alphanum'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cr_sort_sz(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cr_sort_sz(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['A','B','C','D','']);
EXPORT InValidMessageFT_invalid_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('A|B|C|D|'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot_order(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot_order(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['A','D','']);
EXPORT InValidMessageFT_invalid_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('A|D|'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dbpc(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dbpc(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_dbpc(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_chk_digit(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_chk_digit(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_rec_type(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rec_type(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_addr_rec_type(s)>0);
EXPORT InValidMessageFT_invalid_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_addr_rec_type'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_state(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_state(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_fips_state(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_county(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_county(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,3)>0);
EXPORT InValidMessageFT_invalid_fips_county(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'-.0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_geo(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'-.0123456789'))));
EXPORT InValidMessageFT_invalid_geo(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('-.0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_msa(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_msa(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_blk(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo_blk(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,7)>0);
EXPORT InValidMessageFT_invalid_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_match(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo_match(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_err_stat(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_err_stat(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_alphanum(s,4)>0);
EXPORT InValidMessageFT_invalid_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_alphanum'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_raw_aid(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_raw_aid(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_range_numeric(s,10000000000,999999999999)>0);
EXPORT InValidMessageFT_invalid_raw_aid(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_range_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ace_aid(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ace_aid(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,12)>0);
EXPORT InValidMessageFT_invalid_ace_aid(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st(SALT37.StrType s,SALT37.StrType EFX_CTRYNAME) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_state(s,EFX_CTRYNAME)>0);
EXPORT InValidMessageFT_invalid_st(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_state'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip4(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_zip4(s)>0);
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_zip4'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_optional_phone'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_rcid(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rcid(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_rcid(s)>0);
EXPORT InValidMessageFT_invalid_rcid(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_rcid'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_sic(s)>0);
EXPORT InValidMessageFT_invalid_sic(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_sic'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_naics(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_naics(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_naics(s)>0);
EXPORT InValidMessageFT_invalid_naics(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_naics'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_url(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_url(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_url(s)>0);
EXPORT InValidMessageFT_invalid_url(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_url'),SALT37.HygieneErrors.Good);
 
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
  s1 := SALT37.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ\\\'-!#$%&*,./:;?@_{}~+=()^`><'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_email(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ\\\'-!#$%&*,./:;?@_{}~+=()^`><'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ\\\'-!#$%&*,./:;?@_{}~+=()^`><'),SALT37.HygieneErrors.Good);
 
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
EXPORT InValidFT_invalid_cert_or_class(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['CERTIFIED','CLASSIFIED','CLASSIFICATION','CERTIFICATION','SELF-CLASSIFIED/NON VERIFIED','OTHER CLASSIFICATIONS','UNKNOWN',' ']);
EXPORT InValidMessageFT_invalid_cert_or_class(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('CERTIFIED|CLASSIFIED|CLASSIFICATION|CERTIFICATION|SELF-CLASSIFIED/NON VERIFIED|OTHER CLASSIFICATIONS|UNKNOWN| '),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_current_future_date(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_current_future_date(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_current_future_date(s)>0);
EXPORT InValidMessageFT_invalid_current_future_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_current_future_date'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_current_past_date(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_current_past_date(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_current_past_date(s)>0);
EXPORT InValidMessageFT_invalid_current_past_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_current_past_date'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_future_date(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_future_date(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_future_date(s)>0);
EXPORT InValidMessageFT_invalid_future_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_future_date'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_general_date(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_general_date(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_valid_generalDate(s)>0);
EXPORT InValidMessageFT_invalid_general_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_valid_generalDate'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_past_date(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_past_date(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_valid_past_Date(s)>0);
EXPORT InValidMessageFT_invalid_past_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_valid_past_Date'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_year_established(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_year_established(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_valid_year_established(s)>0);
EXPORT InValidMessageFT_invalid_year_established(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_valid_year_established'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date_created(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date_created(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_valid_date_created(s)>0);
EXPORT InValidMessageFT_invalid_date_created(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_valid_date_created'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date_seen(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date_seen(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_current_past_date(s)>0);
EXPORT InValidMessageFT_invalid_date_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_current_past_date'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_reformated_date(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_reformated_date(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_valid_reformatedDate(s)>0);
EXPORT InValidMessageFT_invalid_reformated_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_valid_reformatedDate'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_vendor_reported_date(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_vendor_reported_date(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_current_past_date(s)>0);
EXPORT InValidMessageFT_invalid_vendor_reported_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_current_past_date'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_process_date(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_process_date(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_current_past_date(s)>0);
EXPORT InValidMessageFT_invalid_process_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_current_past_date'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_busstatcd(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_busstatcd(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_busstatcd(s)>0);
EXPORT InValidMessageFT_invalid_busstatcd(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_busstatcd'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cmsa(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cmsa(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_cmsa(s)>0);
EXPORT InValidMessageFT_invalid_cmsa(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_cmsa'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corpamountcd(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corpamountcd(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_corpamountcd(s)>0);
EXPORT InValidMessageFT_invalid_corpamountcd(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_corpamountcd'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corpamountprec(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corpamountprec(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_corpamountprec(s)>0);
EXPORT InValidMessageFT_invalid_corpamountprec(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_corpamountprec'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corpamounttp(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corpamounttp(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_corpamounttp(s)>0);
EXPORT InValidMessageFT_invalid_corpamounttp(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_corpamounttp'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corpempcd(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corpempcd(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_corpempcd(s)>0);
EXPORT InValidMessageFT_invalid_corpempcd(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_corpempcd'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ctryisocd(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ctryisocd(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_ctryisocd(s)>0);
EXPORT InValidMessageFT_invalid_ctryisocd(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_ctryisocd'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ctrynum(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ctrynum(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_ctrynum(s)>0);
EXPORT InValidMessageFT_invalid_ctrynum(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_ctrynum'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ctrytelcd(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ctrytelcd(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_ctrytelcd(s)>0);
EXPORT InValidMessageFT_invalid_ctrytelcd(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_ctrytelcd'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geoprec(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geoprec(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_geoprec(s)>0);
EXPORT InValidMessageFT_invalid_geoprec(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_geoprec'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_merctype(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_merctype(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_merctype(s)>0);
EXPORT InValidMessageFT_invalid_merctype(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_merctype'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mrkt_telescore(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mrkt_telescore(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_mrkt_telescore(s)>0);
EXPORT InValidMessageFT_invalid_mrkt_telescore(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_mrkt_telescore'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mrkt_totalind(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mrkt_totalind(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_mrkt_totalind(s)>0);
EXPORT InValidMessageFT_invalid_mrkt_totalind(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_mrkt_totalind'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mrkt_totalscore(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mrkt_totalscore(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_mrkt_totalscore(s)>0);
EXPORT InValidMessageFT_invalid_mrkt_totalscore(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_mrkt_totalscore'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_public(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_public(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_public(s)>0);
EXPORT InValidMessageFT_invalid_public(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_public'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_statec(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_statec(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_statec(s)>0);
EXPORT InValidMessageFT_invalid_statec(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_statec'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_stkexc(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_stkexc(SALT37.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_stkexc(s)>0);
EXPORT InValidMessageFT_invalid_stkexc(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_stkexc'),SALT37.HygieneErrors.Good);
 
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','normcompany_type','normaddress_type','norm_state','EFX_BUSSTATCD','EFX_CMSA','EFX_CORPAMOUNTCD','EFX_CORPAMOUNTPREC','EFX_CORPAMOUNTTP','EFX_CORPEMPCD','EFX_WEB','EFX_CTRYISOCD','EFX_CTRYNUM','EFX_CTRYTELCD','EFX_GEOPREC','EFX_MERCTYPE','EFX_MRKT_TELESCORE','EFX_MRKT_TOTALIND','EFX_MRKT_TOTALSCORE','EFX_PUBLIC','EFX_STKEXC','EFX_PRIMSIC','EFX_SECSIC1','EFX_SECSIC2','EFX_SECSIC3','EFX_SECSIC4','EFX_ID','EFX_NAME','EFX_LEGAL_NAME','EFX_ADDRESS','EFX_CITY','EFX_REGION','EFX_CTRYNAME','EFX_COUNTYNM','EFX_CMSADESC','EFX_SOHO','EFX_BIZ','EFX_RES','EFX_CMRA','EFX_SECADR','EFX_SECCTY','EFX_SECGEOPREC','EFX_SECREGION','EFX_SECCTRYISOCD','EFX_SECCTRYNUM','EFX_SECCTRYNAME','EFX_PHONE','EFX_FAXPHONE','EFX_BUSSTAT','EFX_YREST','EFX_CORPEMPCNT','EFX_LOCEMPCNT','EFX_LOCEMPCD','EFX_CORPAMOUNT','EFX_LOCAMOUNT','EFX_LOCAMOUNTCD','EFX_LOCAMOUNTTP','EFX_LOCAMOUNTPREC','EFX_TCKSYM','EFX_PRIMSICDESC','EFX_SECSICDESC1','EFX_SECSICDESC2','EFX_SECSICDESC3','EFX_SECSICDESC4','EFX_PRIMNAICSCODE','EFX_SECNAICS1','EFX_SECNAICS2','EFX_SECNAICS3','EFX_SECNAICS4','EFX_PRIMNAICSDESC','EFX_SECNAICSDESC1','EFX_SECNAICSDESC2','EFX_SECNAICSDESC3','EFX_SECNAICSDESC4','EFX_DEAD','EFX_DEADDT','EFX_MRKT_TELEVER','EFX_MRKT_VACANT','EFX_MRKT_SEASONAL','EFX_MBE','EFX_WBE','EFX_MWBE','EFX_SDB','EFX_HUBZONE','EFX_DBE','EFX_VET','EFX_DVET','EFX_8a','EFX_8aEXPDT','EFX_DIS','EFX_SBE','EFX_BUSSIZE','EFX_LBE','EFX_GOV','EFX_FGOV','EFX_NONPROFIT','EFX_HBCU','EFX_GAYLESBIAN','EFX_WSBE','EFX_VSBE','EFX_DVSBE','EFX_MWBESTATUS','EFX_NMSDC','EFX_WBENC','EFX_CA_PUC','EFX_TX_HUB','EFX_TX_HUBCERTNUM','EFX_GSAX','EFX_CALTRANS','EFX_EDU','EFX_MI','EFX_ANC','AT_CERT1','AT_CERT2','AT_CERT3','AT_CERT4','AT_CERT5','AT_CERT6','AT_CERT7','AT_CERT8','AT_CERT9','AT_CERT10','AT_CERTDESC1','AT_CERTDESC2','AT_CERTDESC3','AT_CERTDESC4','AT_CERTDESC5','AT_CERTDESC6','AT_CERTDESC7','AT_CERTDESC8','AT_CERTDESC9','AT_CERTDESC10','AT_CERTSRC1','AT_CERTSRC2','AT_CERTSRC3','AT_CERTSRC4','AT_CERTSRC5','AT_CERTSRC6','AT_CERTSRC7','AT_CERTSRC8','AT_CERTSRC9','AT_CERTSRC10','AT_CERTLEV1','AT_CERTLEV2','AT_CERTLEV3','AT_CERTLEV4','AT_CERTLEV5','AT_CERTLEV6','AT_CERTLEV7','AT_CERTLEV8','AT_CERTLEV9','AT_CERTLEV10','AT_CERTNUM1','AT_CERTNUM2','AT_CERTNUM3','AT_CERTNUM4','AT_CERTNUM5','AT_CERTNUM6','AT_CERTNUM7','AT_CERTNUM8','AT_CERTNUM9','AT_CERTNUM10','AT_CERTEXP1','AT_CERTEXP2','AT_CERTEXP3','AT_CERTEXP4','AT_CERTEXP5','AT_CERTEXP6','AT_CERTEXP7','AT_CERTEXP8','AT_CERTEXP9','AT_CERTEXP10','EFX_EXTRACT_DATE','EFX_MERCHANT_ID','EFX_PROJECT_ID','EFX_FOREIGN','Record_Update_Refresh_Date','EFX_DATE_CREATED');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'dt_first_seen' => 0,'dt_last_seen' => 1,'dt_vendor_first_reported' => 2,'dt_vendor_last_reported' => 3,'process_date' => 4,'record_type' => 5,'normcompany_type' => 6,'normaddress_type' => 7,'norm_state' => 8,'EFX_BUSSTATCD' => 9,'EFX_CMSA' => 10,'EFX_CORPAMOUNTCD' => 11,'EFX_CORPAMOUNTPREC' => 12,'EFX_CORPAMOUNTTP' => 13,'EFX_CORPEMPCD' => 14,'EFX_WEB' => 15,'EFX_CTRYISOCD' => 16,'EFX_CTRYNUM' => 17,'EFX_CTRYTELCD' => 18,'EFX_GEOPREC' => 19,'EFX_MERCTYPE' => 20,'EFX_MRKT_TELESCORE' => 21,'EFX_MRKT_TOTALIND' => 22,'EFX_MRKT_TOTALSCORE' => 23,'EFX_PUBLIC' => 24,'EFX_STKEXC' => 25,'EFX_PRIMSIC' => 26,'EFX_SECSIC1' => 27,'EFX_SECSIC2' => 28,'EFX_SECSIC3' => 29,'EFX_SECSIC4' => 30,'EFX_ID' => 31,'EFX_NAME' => 32,'EFX_LEGAL_NAME' => 33,'EFX_ADDRESS' => 34,'EFX_CITY' => 35,'EFX_REGION' => 36,'EFX_CTRYNAME' => 37,'EFX_COUNTYNM' => 38,'EFX_CMSADESC' => 39,'EFX_SOHO' => 40,'EFX_BIZ' => 41,'EFX_RES' => 42,'EFX_CMRA' => 43,'EFX_SECADR' => 44,'EFX_SECCTY' => 45,'EFX_SECGEOPREC' => 46,'EFX_SECREGION' => 47,'EFX_SECCTRYISOCD' => 48,'EFX_SECCTRYNUM' => 49,'EFX_SECCTRYNAME' => 50,'EFX_PHONE' => 51,'EFX_FAXPHONE' => 52,'EFX_BUSSTAT' => 53,'EFX_YREST' => 54,'EFX_CORPEMPCNT' => 55,'EFX_LOCEMPCNT' => 56,'EFX_LOCEMPCD' => 57,'EFX_CORPAMOUNT' => 58,'EFX_LOCAMOUNT' => 59,'EFX_LOCAMOUNTCD' => 60,'EFX_LOCAMOUNTTP' => 61,'EFX_LOCAMOUNTPREC' => 62,'EFX_TCKSYM' => 63,'EFX_PRIMSICDESC' => 64,'EFX_SECSICDESC1' => 65,'EFX_SECSICDESC2' => 66,'EFX_SECSICDESC3' => 67,'EFX_SECSICDESC4' => 68,'EFX_PRIMNAICSCODE' => 69,'EFX_SECNAICS1' => 70,'EFX_SECNAICS2' => 71,'EFX_SECNAICS3' => 72,'EFX_SECNAICS4' => 73,'EFX_PRIMNAICSDESC' => 74,'EFX_SECNAICSDESC1' => 75,'EFX_SECNAICSDESC2' => 76,'EFX_SECNAICSDESC3' => 77,'EFX_SECNAICSDESC4' => 78,'EFX_DEAD' => 79,'EFX_DEADDT' => 80,'EFX_MRKT_TELEVER' => 81,'EFX_MRKT_VACANT' => 82,'EFX_MRKT_SEASONAL' => 83,'EFX_MBE' => 84,'EFX_WBE' => 85,'EFX_MWBE' => 86,'EFX_SDB' => 87,'EFX_HUBZONE' => 88,'EFX_DBE' => 89,'EFX_VET' => 90,'EFX_DVET' => 91,'EFX_8a' => 92,'EFX_8aEXPDT' => 93,'EFX_DIS' => 94,'EFX_SBE' => 95,'EFX_BUSSIZE' => 96,'EFX_LBE' => 97,'EFX_GOV' => 98,'EFX_FGOV' => 99,'EFX_NONPROFIT' => 100,'EFX_HBCU' => 101,'EFX_GAYLESBIAN' => 102,'EFX_WSBE' => 103,'EFX_VSBE' => 104,'EFX_DVSBE' => 105,'EFX_MWBESTATUS' => 106,'EFX_NMSDC' => 107,'EFX_WBENC' => 108,'EFX_CA_PUC' => 109,'EFX_TX_HUB' => 110,'EFX_TX_HUBCERTNUM' => 111,'EFX_GSAX' => 112,'EFX_CALTRANS' => 113,'EFX_EDU' => 114,'EFX_MI' => 115,'EFX_ANC' => 116,'AT_CERT1' => 117,'AT_CERT2' => 118,'AT_CERT3' => 119,'AT_CERT4' => 120,'AT_CERT5' => 121,'AT_CERT6' => 122,'AT_CERT7' => 123,'AT_CERT8' => 124,'AT_CERT9' => 125,'AT_CERT10' => 126,'AT_CERTDESC1' => 127,'AT_CERTDESC2' => 128,'AT_CERTDESC3' => 129,'AT_CERTDESC4' => 130,'AT_CERTDESC5' => 131,'AT_CERTDESC6' => 132,'AT_CERTDESC7' => 133,'AT_CERTDESC8' => 134,'AT_CERTDESC9' => 135,'AT_CERTDESC10' => 136,'AT_CERTSRC1' => 137,'AT_CERTSRC2' => 138,'AT_CERTSRC3' => 139,'AT_CERTSRC4' => 140,'AT_CERTSRC5' => 141,'AT_CERTSRC6' => 142,'AT_CERTSRC7' => 143,'AT_CERTSRC8' => 144,'AT_CERTSRC9' => 145,'AT_CERTSRC10' => 146,'AT_CERTLEV1' => 147,'AT_CERTLEV2' => 148,'AT_CERTLEV3' => 149,'AT_CERTLEV4' => 150,'AT_CERTLEV5' => 151,'AT_CERTLEV6' => 152,'AT_CERTLEV7' => 153,'AT_CERTLEV8' => 154,'AT_CERTLEV9' => 155,'AT_CERTLEV10' => 156,'AT_CERTNUM1' => 157,'AT_CERTNUM2' => 158,'AT_CERTNUM3' => 159,'AT_CERTNUM4' => 160,'AT_CERTNUM5' => 161,'AT_CERTNUM6' => 162,'AT_CERTNUM7' => 163,'AT_CERTNUM8' => 164,'AT_CERTNUM9' => 165,'AT_CERTNUM10' => 166,'AT_CERTEXP1' => 167,'AT_CERTEXP2' => 168,'AT_CERTEXP3' => 169,'AT_CERTEXP4' => 170,'AT_CERTEXP5' => 171,'AT_CERTEXP6' => 172,'AT_CERTEXP7' => 173,'AT_CERTEXP8' => 174,'AT_CERTEXP9' => 175,'AT_CERTEXP10' => 176,'EFX_EXTRACT_DATE' => 177,'EFX_MERCHANT_ID' => 178,'EFX_PROJECT_ID' => 179,'EFX_FOREIGN' => 180,'Record_Update_Refresh_Date' => 181,'EFX_DATE_CREATED' => 182,0);
 
//Individual field level validation
 
EXPORT Make_dt_first_seen(SALT37.StrType s0) := MakeFT_invalid_reformated_date(s0);
EXPORT InValid_dt_first_seen(SALT37.StrType s) := InValidFT_invalid_reformated_date(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_reformated_date(wh);
 
EXPORT Make_dt_last_seen(SALT37.StrType s0) := MakeFT_invalid_reformated_date(s0);
EXPORT InValid_dt_last_seen(SALT37.StrType s) := InValidFT_invalid_reformated_date(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_reformated_date(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT37.StrType s0) := MakeFT_invalid_reformated_date(s0);
EXPORT InValid_dt_vendor_first_reported(SALT37.StrType s) := InValidFT_invalid_reformated_date(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_reformated_date(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT37.StrType s0) := MakeFT_invalid_reformated_date(s0);
EXPORT InValid_dt_vendor_last_reported(SALT37.StrType s) := InValidFT_invalid_reformated_date(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_reformated_date(wh);
 
EXPORT Make_process_date(SALT37.StrType s0) := MakeFT_invalid_reformated_date(s0);
EXPORT InValid_process_date(SALT37.StrType s) := InValidFT_invalid_reformated_date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_reformated_date(wh);
 
EXPORT Make_record_type(SALT37.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT37.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_normcompany_type(SALT37.StrType s0) := MakeFT_invalid_norm_type(s0);
EXPORT InValid_normcompany_type(SALT37.StrType s) := InValidFT_invalid_norm_type(s);
EXPORT InValidMessage_normcompany_type(UNSIGNED1 wh) := InValidMessageFT_invalid_norm_type(wh);
 
EXPORT Make_normaddress_type(SALT37.StrType s0) := MakeFT_invalid_address_type_code(s0);
EXPORT InValid_normaddress_type(SALT37.StrType s) := InValidFT_invalid_address_type_code(s);
EXPORT InValidMessage_normaddress_type(UNSIGNED1 wh) := InValidMessageFT_invalid_address_type_code(wh);
 
EXPORT Make_norm_state(SALT37.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_norm_state(SALT37.StrType s,SALT37.StrType EFX_CTRYNAME) := InValidFT_invalid_st(s,EFX_CTRYNAME);
EXPORT InValidMessage_norm_state(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_EFX_BUSSTATCD(SALT37.StrType s0) := MakeFT_invalid_busstatcd(s0);
EXPORT InValid_EFX_BUSSTATCD(SALT37.StrType s) := InValidFT_invalid_busstatcd(s);
EXPORT InValidMessage_EFX_BUSSTATCD(UNSIGNED1 wh) := InValidMessageFT_invalid_busstatcd(wh);
 
EXPORT Make_EFX_CMSA(SALT37.StrType s0) := MakeFT_invalid_cmsa(s0);
EXPORT InValid_EFX_CMSA(SALT37.StrType s) := InValidFT_invalid_cmsa(s);
EXPORT InValidMessage_EFX_CMSA(UNSIGNED1 wh) := InValidMessageFT_invalid_cmsa(wh);
 
EXPORT Make_EFX_CORPAMOUNTCD(SALT37.StrType s0) := MakeFT_invalid_corpamountcd(s0);
EXPORT InValid_EFX_CORPAMOUNTCD(SALT37.StrType s) := InValidFT_invalid_corpamountcd(s);
EXPORT InValidMessage_EFX_CORPAMOUNTCD(UNSIGNED1 wh) := InValidMessageFT_invalid_corpamountcd(wh);
 
EXPORT Make_EFX_CORPAMOUNTPREC(SALT37.StrType s0) := MakeFT_invalid_corpamountprec(s0);
EXPORT InValid_EFX_CORPAMOUNTPREC(SALT37.StrType s) := InValidFT_invalid_corpamountprec(s);
EXPORT InValidMessage_EFX_CORPAMOUNTPREC(UNSIGNED1 wh) := InValidMessageFT_invalid_corpamountprec(wh);
 
EXPORT Make_EFX_CORPAMOUNTTP(SALT37.StrType s0) := MakeFT_invalid_corpamounttp(s0);
EXPORT InValid_EFX_CORPAMOUNTTP(SALT37.StrType s) := InValidFT_invalid_corpamounttp(s);
EXPORT InValidMessage_EFX_CORPAMOUNTTP(UNSIGNED1 wh) := InValidMessageFT_invalid_corpamounttp(wh);
 
EXPORT Make_EFX_CORPEMPCD(SALT37.StrType s0) := MakeFT_invalid_corpempcd(s0);
EXPORT InValid_EFX_CORPEMPCD(SALT37.StrType s) := InValidFT_invalid_corpempcd(s);
EXPORT InValidMessage_EFX_CORPEMPCD(UNSIGNED1 wh) := InValidMessageFT_invalid_corpempcd(wh);
 
EXPORT Make_EFX_WEB(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_WEB(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_WEB(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CTRYISOCD(SALT37.StrType s0) := MakeFT_invalid_ctryisocd(s0);
EXPORT InValid_EFX_CTRYISOCD(SALT37.StrType s) := InValidFT_invalid_ctryisocd(s);
EXPORT InValidMessage_EFX_CTRYISOCD(UNSIGNED1 wh) := InValidMessageFT_invalid_ctryisocd(wh);
 
EXPORT Make_EFX_CTRYNUM(SALT37.StrType s0) := MakeFT_invalid_ctrynum(s0);
EXPORT InValid_EFX_CTRYNUM(SALT37.StrType s) := InValidFT_invalid_ctrynum(s);
EXPORT InValidMessage_EFX_CTRYNUM(UNSIGNED1 wh) := InValidMessageFT_invalid_ctrynum(wh);
 
EXPORT Make_EFX_CTRYTELCD(SALT37.StrType s0) := MakeFT_invalid_ctrytelcd(s0);
EXPORT InValid_EFX_CTRYTELCD(SALT37.StrType s) := InValidFT_invalid_ctrytelcd(s);
EXPORT InValidMessage_EFX_CTRYTELCD(UNSIGNED1 wh) := InValidMessageFT_invalid_ctrytelcd(wh);
 
EXPORT Make_EFX_GEOPREC(SALT37.StrType s0) := MakeFT_invalid_geoprec(s0);
EXPORT InValid_EFX_GEOPREC(SALT37.StrType s) := InValidFT_invalid_geoprec(s);
EXPORT InValidMessage_EFX_GEOPREC(UNSIGNED1 wh) := InValidMessageFT_invalid_geoprec(wh);
 
EXPORT Make_EFX_MERCTYPE(SALT37.StrType s0) := MakeFT_invalid_merctype(s0);
EXPORT InValid_EFX_MERCTYPE(SALT37.StrType s) := InValidFT_invalid_merctype(s);
EXPORT InValidMessage_EFX_MERCTYPE(UNSIGNED1 wh) := InValidMessageFT_invalid_merctype(wh);
 
EXPORT Make_EFX_MRKT_TELESCORE(SALT37.StrType s0) := MakeFT_invalid_mrkt_telescore(s0);
EXPORT InValid_EFX_MRKT_TELESCORE(SALT37.StrType s) := InValidFT_invalid_mrkt_telescore(s);
EXPORT InValidMessage_EFX_MRKT_TELESCORE(UNSIGNED1 wh) := InValidMessageFT_invalid_mrkt_telescore(wh);
 
EXPORT Make_EFX_MRKT_TOTALIND(SALT37.StrType s0) := MakeFT_invalid_mrkt_totalind(s0);
EXPORT InValid_EFX_MRKT_TOTALIND(SALT37.StrType s) := InValidFT_invalid_mrkt_totalind(s);
EXPORT InValidMessage_EFX_MRKT_TOTALIND(UNSIGNED1 wh) := InValidMessageFT_invalid_mrkt_totalind(wh);
 
EXPORT Make_EFX_MRKT_TOTALSCORE(SALT37.StrType s0) := MakeFT_invalid_mrkt_totalscore(s0);
EXPORT InValid_EFX_MRKT_TOTALSCORE(SALT37.StrType s) := InValidFT_invalid_mrkt_totalscore(s);
EXPORT InValidMessage_EFX_MRKT_TOTALSCORE(UNSIGNED1 wh) := InValidMessageFT_invalid_mrkt_totalscore(wh);
 
EXPORT Make_EFX_PUBLIC(SALT37.StrType s0) := MakeFT_invalid_public(s0);
EXPORT InValid_EFX_PUBLIC(SALT37.StrType s) := InValidFT_invalid_public(s);
EXPORT InValidMessage_EFX_PUBLIC(UNSIGNED1 wh) := InValidMessageFT_invalid_public(wh);
 
EXPORT Make_EFX_STKEXC(SALT37.StrType s0) := MakeFT_invalid_stkexc(s0);
EXPORT InValid_EFX_STKEXC(SALT37.StrType s) := InValidFT_invalid_stkexc(s);
EXPORT InValidMessage_EFX_STKEXC(UNSIGNED1 wh) := InValidMessageFT_invalid_stkexc(wh);
 
EXPORT Make_EFX_PRIMSIC(SALT37.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_EFX_PRIMSIC(SALT37.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_EFX_PRIMSIC(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_EFX_SECSIC1(SALT37.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_EFX_SECSIC1(SALT37.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_EFX_SECSIC1(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_EFX_SECSIC2(SALT37.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_EFX_SECSIC2(SALT37.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_EFX_SECSIC2(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_EFX_SECSIC3(SALT37.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_EFX_SECSIC3(SALT37.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_EFX_SECSIC3(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_EFX_SECSIC4(SALT37.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_EFX_SECSIC4(SALT37.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_EFX_SECSIC4(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_EFX_ID(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_EFX_ID(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_EFX_ID(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_EFX_NAME(SALT37.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_EFX_NAME(SALT37.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_EFX_NAME(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_EFX_LEGAL_NAME(SALT37.StrType s0) := MakeFT_invalid_legal_name(s0);
EXPORT InValid_EFX_LEGAL_NAME(SALT37.StrType s) := InValidFT_invalid_legal_name(s);
EXPORT InValidMessage_EFX_LEGAL_NAME(UNSIGNED1 wh) := InValidMessageFT_invalid_legal_name(wh);
 
EXPORT Make_EFX_ADDRESS(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_EFX_ADDRESS(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_EFX_ADDRESS(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_EFX_CITY(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_EFX_CITY(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_EFX_CITY(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_EFX_REGION(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_REGION(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_REGION(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CTRYNAME(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_EFX_CTRYNAME(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_EFX_CTRYNAME(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_EFX_COUNTYNM(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_COUNTYNM(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_COUNTYNM(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CMSADESC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CMSADESC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CMSADESC(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SOHO(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_SOHO(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_SOHO(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_BIZ(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_BIZ(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_BIZ(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_RES(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_RES(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_RES(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_CMRA(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_CMRA(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_CMRA(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_SECADR(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECADR(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECADR(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECCTY(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECCTY(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECCTY(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECGEOPREC(SALT37.StrType s0) := MakeFT_invalid_geoprec(s0);
EXPORT InValid_EFX_SECGEOPREC(SALT37.StrType s) := InValidFT_invalid_geoprec(s);
EXPORT InValidMessage_EFX_SECGEOPREC(UNSIGNED1 wh) := InValidMessageFT_invalid_geoprec(wh);
 
EXPORT Make_EFX_SECREGION(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECREGION(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECREGION(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECCTRYISOCD(SALT37.StrType s0) := MakeFT_invalid_ctryisocd(s0);
EXPORT InValid_EFX_SECCTRYISOCD(SALT37.StrType s) := InValidFT_invalid_ctryisocd(s);
EXPORT InValidMessage_EFX_SECCTRYISOCD(UNSIGNED1 wh) := InValidMessageFT_invalid_ctryisocd(wh);
 
EXPORT Make_EFX_SECCTRYNUM(SALT37.StrType s0) := MakeFT_invalid_ctrynum(s0);
EXPORT InValid_EFX_SECCTRYNUM(SALT37.StrType s) := InValidFT_invalid_ctrynum(s);
EXPORT InValidMessage_EFX_SECCTRYNUM(UNSIGNED1 wh) := InValidMessageFT_invalid_ctrynum(wh);
 
EXPORT Make_EFX_SECCTRYNAME(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECCTRYNAME(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECCTRYNAME(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_PHONE(SALT37.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_EFX_PHONE(SALT37.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_EFX_PHONE(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_EFX_FAXPHONE(SALT37.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_EFX_FAXPHONE(SALT37.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_EFX_FAXPHONE(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_EFX_BUSSTAT(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_BUSSTAT(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_BUSSTAT(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_YREST(SALT37.StrType s0) := MakeFT_invalid_year_established(s0);
EXPORT InValid_EFX_YREST(SALT37.StrType s) := InValidFT_invalid_year_established(s);
EXPORT InValidMessage_EFX_YREST(UNSIGNED1 wh) := InValidMessageFT_invalid_year_established(wh);
 
EXPORT Make_EFX_CORPEMPCNT(SALT37.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_EFX_CORPEMPCNT(SALT37.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_EFX_CORPEMPCNT(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_EFX_LOCEMPCNT(SALT37.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_EFX_LOCEMPCNT(SALT37.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_EFX_LOCEMPCNT(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_EFX_LOCEMPCD(SALT37.StrType s0) := MakeFT_invalid_corpempcd(s0);
EXPORT InValid_EFX_LOCEMPCD(SALT37.StrType s) := InValidFT_invalid_corpempcd(s);
EXPORT InValidMessage_EFX_LOCEMPCD(UNSIGNED1 wh) := InValidMessageFT_invalid_corpempcd(wh);
 
EXPORT Make_EFX_CORPAMOUNT(SALT37.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_EFX_CORPAMOUNT(SALT37.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_EFX_CORPAMOUNT(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_EFX_LOCAMOUNT(SALT37.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_EFX_LOCAMOUNT(SALT37.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_EFX_LOCAMOUNT(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_EFX_LOCAMOUNTCD(SALT37.StrType s0) := MakeFT_invalid_corpamountcd(s0);
EXPORT InValid_EFX_LOCAMOUNTCD(SALT37.StrType s) := InValidFT_invalid_corpamountcd(s);
EXPORT InValidMessage_EFX_LOCAMOUNTCD(UNSIGNED1 wh) := InValidMessageFT_invalid_corpamountcd(wh);
 
EXPORT Make_EFX_LOCAMOUNTTP(SALT37.StrType s0) := MakeFT_invalid_corpamounttp(s0);
EXPORT InValid_EFX_LOCAMOUNTTP(SALT37.StrType s) := InValidFT_invalid_corpamounttp(s);
EXPORT InValidMessage_EFX_LOCAMOUNTTP(UNSIGNED1 wh) := InValidMessageFT_invalid_corpamounttp(wh);
 
EXPORT Make_EFX_LOCAMOUNTPREC(SALT37.StrType s0) := MakeFT_invalid_corpamountprec(s0);
EXPORT InValid_EFX_LOCAMOUNTPREC(SALT37.StrType s) := InValidFT_invalid_corpamountprec(s);
EXPORT InValidMessage_EFX_LOCAMOUNTPREC(UNSIGNED1 wh) := InValidMessageFT_invalid_corpamountprec(wh);
 
EXPORT Make_EFX_TCKSYM(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_TCKSYM(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_TCKSYM(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_PRIMSICDESC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_PRIMSICDESC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_PRIMSICDESC(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECSICDESC1(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECSICDESC1(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECSICDESC1(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECSICDESC2(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECSICDESC2(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECSICDESC2(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECSICDESC3(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECSICDESC3(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECSICDESC3(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECSICDESC4(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECSICDESC4(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECSICDESC4(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_PRIMNAICSCODE(SALT37.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_EFX_PRIMNAICSCODE(SALT37.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_EFX_PRIMNAICSCODE(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_EFX_SECNAICS1(SALT37.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_EFX_SECNAICS1(SALT37.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_EFX_SECNAICS1(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_EFX_SECNAICS2(SALT37.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_EFX_SECNAICS2(SALT37.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_EFX_SECNAICS2(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_EFX_SECNAICS3(SALT37.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_EFX_SECNAICS3(SALT37.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_EFX_SECNAICS3(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_EFX_SECNAICS4(SALT37.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_EFX_SECNAICS4(SALT37.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_EFX_SECNAICS4(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_EFX_PRIMNAICSDESC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_PRIMNAICSDESC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_PRIMNAICSDESC(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECNAICSDESC1(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECNAICSDESC1(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECNAICSDESC1(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECNAICSDESC2(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECNAICSDESC2(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECNAICSDESC2(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECNAICSDESC3(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECNAICSDESC3(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECNAICSDESC3(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECNAICSDESC4(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECNAICSDESC4(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECNAICSDESC4(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_DEAD(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_DEAD(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_DEAD(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_DEADDT(SALT37.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_EFX_DEADDT(SALT37.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_EFX_DEADDT(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_EFX_MRKT_TELEVER(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_MRKT_TELEVER(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_MRKT_TELEVER(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_MRKT_VACANT(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_MRKT_VACANT(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_MRKT_VACANT(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_MRKT_SEASONAL(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_MRKT_SEASONAL(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_MRKT_SEASONAL(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_MBE(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_MBE(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_MBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_WBE(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_WBE(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_WBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_MWBE(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_MWBE(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_MWBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_SDB(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_SDB(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_SDB(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_HUBZONE(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_HUBZONE(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_HUBZONE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_DBE(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_DBE(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_DBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_VET(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_VET(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_VET(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_DVET(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_DVET(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_DVET(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_8a(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_8a(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_8a(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_8aEXPDT(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_EFX_8aEXPDT(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_EFX_8aEXPDT(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_EFX_DIS(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_DIS(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_DIS(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_SBE(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_SBE(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_SBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_BUSSIZE(SALT37.StrType s0) := MakeFT_invalid_business_size(s0);
EXPORT InValid_EFX_BUSSIZE(SALT37.StrType s) := InValidFT_invalid_business_size(s);
EXPORT InValidMessage_EFX_BUSSIZE(UNSIGNED1 wh) := InValidMessageFT_invalid_business_size(wh);
 
EXPORT Make_EFX_LBE(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_LBE(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_LBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_GOV(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_GOV(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_GOV(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_FGOV(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_FGOV(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_FGOV(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_NONPROFIT(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_NONPROFIT(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_NONPROFIT(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_HBCU(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_HBCU(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_HBCU(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_GAYLESBIAN(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_GAYLESBIAN(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_GAYLESBIAN(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_WSBE(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_WSBE(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_WSBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_VSBE(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_VSBE(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_VSBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_DVSBE(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_DVSBE(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_DVSBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_MWBESTATUS(SALT37.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_EFX_MWBESTATUS(SALT37.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_EFX_MWBESTATUS(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_EFX_NMSDC(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_NMSDC(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_NMSDC(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_WBENC(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_WBENC(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_WBENC(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_CA_PUC(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_CA_PUC(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_CA_PUC(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_TX_HUB(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_TX_HUB(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_TX_HUB(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_TX_HUBCERTNUM(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_TX_HUBCERTNUM(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_TX_HUBCERTNUM(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_GSAX(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_GSAX(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_GSAX(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_CALTRANS(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_CALTRANS(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_CALTRANS(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_EDU(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_EDU(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_EDU(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_MI(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_MI(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_MI(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_ANC(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_ANC(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_ANC(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_AT_CERT1(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT1(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT1(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT2(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT2(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT2(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT3(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT3(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT3(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT4(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT4(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT4(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT5(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT5(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT5(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT6(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT6(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT6(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT7(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT7(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT7(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT8(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT8(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT8(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT9(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT9(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT9(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT10(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT10(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT10(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC1(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC1(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC1(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC2(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC2(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC2(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC3(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC3(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC3(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC4(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC4(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC4(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC5(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC5(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC5(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC6(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC6(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC6(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC7(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC7(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC7(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC8(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC8(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC8(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC9(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC9(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC9(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC10(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC10(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC10(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC1(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC1(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC1(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC2(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC2(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC2(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC3(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC3(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC3(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC4(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC4(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC4(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC5(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC5(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC5(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC6(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC6(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC6(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC7(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC7(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC7(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC8(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC8(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC8(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC9(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC9(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC9(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC10(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC10(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC10(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTLEV1(SALT37.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV1(SALT37.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV1(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV2(SALT37.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV2(SALT37.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV2(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV3(SALT37.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV3(SALT37.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV3(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV4(SALT37.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV4(SALT37.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV4(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV5(SALT37.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV5(SALT37.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV5(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV6(SALT37.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV6(SALT37.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV6(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV7(SALT37.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV7(SALT37.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV7(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV8(SALT37.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV8(SALT37.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV8(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV9(SALT37.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV9(SALT37.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV9(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV10(SALT37.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV10(SALT37.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV10(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTNUM1(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM1(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM1(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM2(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM2(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM2(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM3(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM3(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM3(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM4(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM4(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM4(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM5(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM5(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM5(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM6(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM6(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM6(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM7(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM7(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM7(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM8(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM8(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM8(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM9(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM9(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM9(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM10(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM10(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM10(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTEXP1(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP1(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP1(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP2(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP2(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP2(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP3(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP3(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP3(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP4(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP4(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP4(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP5(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP5(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP5(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP6(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP6(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP6(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP7(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP7(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP7(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP8(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP8(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP8(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP9(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP9(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP9(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP10(SALT37.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP10(SALT37.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP10(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_EFX_EXTRACT_DATE(SALT37.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_EFX_EXTRACT_DATE(SALT37.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_EFX_EXTRACT_DATE(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_EFX_MERCHANT_ID(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_EFX_MERCHANT_ID(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_EFX_MERCHANT_ID(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_EFX_PROJECT_ID(SALT37.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_EFX_PROJECT_ID(SALT37.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_EFX_PROJECT_ID(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_EFX_FOREIGN(SALT37.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_FOREIGN(SALT37.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_FOREIGN(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_Record_Update_Refresh_Date(SALT37.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_Record_Update_Refresh_Date(SALT37.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_Record_Update_Refresh_Date(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_EFX_DATE_CREATED(SALT37.StrType s0) := MakeFT_invalid_date_created(s0);
EXPORT InValid_EFX_DATE_CREATED(SALT37.StrType s) := InValidFT_invalid_date_created(s);
EXPORT InValidMessage_EFX_DATE_CREATED(UNSIGNED1 wh) := InValidMessageFT_invalid_date_created(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT37,Scrubs_Equifax_Business_Data;
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
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_normcompany_type;
    BOOLEAN Diff_normaddress_type;
    BOOLEAN Diff_norm_state;
    BOOLEAN Diff_EFX_BUSSTATCD;
    BOOLEAN Diff_EFX_CMSA;
    BOOLEAN Diff_EFX_CORPAMOUNTCD;
    BOOLEAN Diff_EFX_CORPAMOUNTPREC;
    BOOLEAN Diff_EFX_CORPAMOUNTTP;
    BOOLEAN Diff_EFX_CORPEMPCD;
    BOOLEAN Diff_EFX_WEB;
    BOOLEAN Diff_EFX_CTRYISOCD;
    BOOLEAN Diff_EFX_CTRYNUM;
    BOOLEAN Diff_EFX_CTRYTELCD;
    BOOLEAN Diff_EFX_GEOPREC;
    BOOLEAN Diff_EFX_MERCTYPE;
    BOOLEAN Diff_EFX_MRKT_TELESCORE;
    BOOLEAN Diff_EFX_MRKT_TOTALIND;
    BOOLEAN Diff_EFX_MRKT_TOTALSCORE;
    BOOLEAN Diff_EFX_PUBLIC;
    BOOLEAN Diff_EFX_STKEXC;
    BOOLEAN Diff_EFX_PRIMSIC;
    BOOLEAN Diff_EFX_SECSIC1;
    BOOLEAN Diff_EFX_SECSIC2;
    BOOLEAN Diff_EFX_SECSIC3;
    BOOLEAN Diff_EFX_SECSIC4;
    BOOLEAN Diff_EFX_ID;
    BOOLEAN Diff_EFX_NAME;
    BOOLEAN Diff_EFX_LEGAL_NAME;
    BOOLEAN Diff_EFX_ADDRESS;
    BOOLEAN Diff_EFX_CITY;
    BOOLEAN Diff_EFX_REGION;
    BOOLEAN Diff_EFX_CTRYNAME;
    BOOLEAN Diff_EFX_COUNTYNM;
    BOOLEAN Diff_EFX_CMSADESC;
    BOOLEAN Diff_EFX_SOHO;
    BOOLEAN Diff_EFX_BIZ;
    BOOLEAN Diff_EFX_RES;
    BOOLEAN Diff_EFX_CMRA;
    BOOLEAN Diff_EFX_SECADR;
    BOOLEAN Diff_EFX_SECCTY;
    BOOLEAN Diff_EFX_SECGEOPREC;
    BOOLEAN Diff_EFX_SECREGION;
    BOOLEAN Diff_EFX_SECCTRYISOCD;
    BOOLEAN Diff_EFX_SECCTRYNUM;
    BOOLEAN Diff_EFX_SECCTRYNAME;
    BOOLEAN Diff_EFX_PHONE;
    BOOLEAN Diff_EFX_FAXPHONE;
    BOOLEAN Diff_EFX_BUSSTAT;
    BOOLEAN Diff_EFX_YREST;
    BOOLEAN Diff_EFX_CORPEMPCNT;
    BOOLEAN Diff_EFX_LOCEMPCNT;
    BOOLEAN Diff_EFX_LOCEMPCD;
    BOOLEAN Diff_EFX_CORPAMOUNT;
    BOOLEAN Diff_EFX_LOCAMOUNT;
    BOOLEAN Diff_EFX_LOCAMOUNTCD;
    BOOLEAN Diff_EFX_LOCAMOUNTTP;
    BOOLEAN Diff_EFX_LOCAMOUNTPREC;
    BOOLEAN Diff_EFX_TCKSYM;
    BOOLEAN Diff_EFX_PRIMSICDESC;
    BOOLEAN Diff_EFX_SECSICDESC1;
    BOOLEAN Diff_EFX_SECSICDESC2;
    BOOLEAN Diff_EFX_SECSICDESC3;
    BOOLEAN Diff_EFX_SECSICDESC4;
    BOOLEAN Diff_EFX_PRIMNAICSCODE;
    BOOLEAN Diff_EFX_SECNAICS1;
    BOOLEAN Diff_EFX_SECNAICS2;
    BOOLEAN Diff_EFX_SECNAICS3;
    BOOLEAN Diff_EFX_SECNAICS4;
    BOOLEAN Diff_EFX_PRIMNAICSDESC;
    BOOLEAN Diff_EFX_SECNAICSDESC1;
    BOOLEAN Diff_EFX_SECNAICSDESC2;
    BOOLEAN Diff_EFX_SECNAICSDESC3;
    BOOLEAN Diff_EFX_SECNAICSDESC4;
    BOOLEAN Diff_EFX_DEAD;
    BOOLEAN Diff_EFX_DEADDT;
    BOOLEAN Diff_EFX_MRKT_TELEVER;
    BOOLEAN Diff_EFX_MRKT_VACANT;
    BOOLEAN Diff_EFX_MRKT_SEASONAL;
    BOOLEAN Diff_EFX_MBE;
    BOOLEAN Diff_EFX_WBE;
    BOOLEAN Diff_EFX_MWBE;
    BOOLEAN Diff_EFX_SDB;
    BOOLEAN Diff_EFX_HUBZONE;
    BOOLEAN Diff_EFX_DBE;
    BOOLEAN Diff_EFX_VET;
    BOOLEAN Diff_EFX_DVET;
    BOOLEAN Diff_EFX_8a;
    BOOLEAN Diff_EFX_8aEXPDT;
    BOOLEAN Diff_EFX_DIS;
    BOOLEAN Diff_EFX_SBE;
    BOOLEAN Diff_EFX_BUSSIZE;
    BOOLEAN Diff_EFX_LBE;
    BOOLEAN Diff_EFX_GOV;
    BOOLEAN Diff_EFX_FGOV;
    BOOLEAN Diff_EFX_NONPROFIT;
    BOOLEAN Diff_EFX_HBCU;
    BOOLEAN Diff_EFX_GAYLESBIAN;
    BOOLEAN Diff_EFX_WSBE;
    BOOLEAN Diff_EFX_VSBE;
    BOOLEAN Diff_EFX_DVSBE;
    BOOLEAN Diff_EFX_MWBESTATUS;
    BOOLEAN Diff_EFX_NMSDC;
    BOOLEAN Diff_EFX_WBENC;
    BOOLEAN Diff_EFX_CA_PUC;
    BOOLEAN Diff_EFX_TX_HUB;
    BOOLEAN Diff_EFX_TX_HUBCERTNUM;
    BOOLEAN Diff_EFX_GSAX;
    BOOLEAN Diff_EFX_CALTRANS;
    BOOLEAN Diff_EFX_EDU;
    BOOLEAN Diff_EFX_MI;
    BOOLEAN Diff_EFX_ANC;
    BOOLEAN Diff_AT_CERT1;
    BOOLEAN Diff_AT_CERT2;
    BOOLEAN Diff_AT_CERT3;
    BOOLEAN Diff_AT_CERT4;
    BOOLEAN Diff_AT_CERT5;
    BOOLEAN Diff_AT_CERT6;
    BOOLEAN Diff_AT_CERT7;
    BOOLEAN Diff_AT_CERT8;
    BOOLEAN Diff_AT_CERT9;
    BOOLEAN Diff_AT_CERT10;
    BOOLEAN Diff_AT_CERTDESC1;
    BOOLEAN Diff_AT_CERTDESC2;
    BOOLEAN Diff_AT_CERTDESC3;
    BOOLEAN Diff_AT_CERTDESC4;
    BOOLEAN Diff_AT_CERTDESC5;
    BOOLEAN Diff_AT_CERTDESC6;
    BOOLEAN Diff_AT_CERTDESC7;
    BOOLEAN Diff_AT_CERTDESC8;
    BOOLEAN Diff_AT_CERTDESC9;
    BOOLEAN Diff_AT_CERTDESC10;
    BOOLEAN Diff_AT_CERTSRC1;
    BOOLEAN Diff_AT_CERTSRC2;
    BOOLEAN Diff_AT_CERTSRC3;
    BOOLEAN Diff_AT_CERTSRC4;
    BOOLEAN Diff_AT_CERTSRC5;
    BOOLEAN Diff_AT_CERTSRC6;
    BOOLEAN Diff_AT_CERTSRC7;
    BOOLEAN Diff_AT_CERTSRC8;
    BOOLEAN Diff_AT_CERTSRC9;
    BOOLEAN Diff_AT_CERTSRC10;
    BOOLEAN Diff_AT_CERTLEV1;
    BOOLEAN Diff_AT_CERTLEV2;
    BOOLEAN Diff_AT_CERTLEV3;
    BOOLEAN Diff_AT_CERTLEV4;
    BOOLEAN Diff_AT_CERTLEV5;
    BOOLEAN Diff_AT_CERTLEV6;
    BOOLEAN Diff_AT_CERTLEV7;
    BOOLEAN Diff_AT_CERTLEV8;
    BOOLEAN Diff_AT_CERTLEV9;
    BOOLEAN Diff_AT_CERTLEV10;
    BOOLEAN Diff_AT_CERTNUM1;
    BOOLEAN Diff_AT_CERTNUM2;
    BOOLEAN Diff_AT_CERTNUM3;
    BOOLEAN Diff_AT_CERTNUM4;
    BOOLEAN Diff_AT_CERTNUM5;
    BOOLEAN Diff_AT_CERTNUM6;
    BOOLEAN Diff_AT_CERTNUM7;
    BOOLEAN Diff_AT_CERTNUM8;
    BOOLEAN Diff_AT_CERTNUM9;
    BOOLEAN Diff_AT_CERTNUM10;
    BOOLEAN Diff_AT_CERTEXP1;
    BOOLEAN Diff_AT_CERTEXP2;
    BOOLEAN Diff_AT_CERTEXP3;
    BOOLEAN Diff_AT_CERTEXP4;
    BOOLEAN Diff_AT_CERTEXP5;
    BOOLEAN Diff_AT_CERTEXP6;
    BOOLEAN Diff_AT_CERTEXP7;
    BOOLEAN Diff_AT_CERTEXP8;
    BOOLEAN Diff_AT_CERTEXP9;
    BOOLEAN Diff_AT_CERTEXP10;
    BOOLEAN Diff_EFX_EXTRACT_DATE;
    BOOLEAN Diff_EFX_MERCHANT_ID;
    BOOLEAN Diff_EFX_PROJECT_ID;
    BOOLEAN Diff_EFX_FOREIGN;
    BOOLEAN Diff_Record_Update_Refresh_Date;
    BOOLEAN Diff_EFX_DATE_CREATED;
    UNSIGNED Num_Diffs;
    SALT37.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_normcompany_type := le.normcompany_type <> ri.normcompany_type;
    SELF.Diff_normaddress_type := le.normaddress_type <> ri.normaddress_type;
    SELF.Diff_norm_state := le.norm_state <> ri.norm_state;
    SELF.Diff_EFX_BUSSTATCD := le.EFX_BUSSTATCD <> ri.EFX_BUSSTATCD;
    SELF.Diff_EFX_CMSA := le.EFX_CMSA <> ri.EFX_CMSA;
    SELF.Diff_EFX_CORPAMOUNTCD := le.EFX_CORPAMOUNTCD <> ri.EFX_CORPAMOUNTCD;
    SELF.Diff_EFX_CORPAMOUNTPREC := le.EFX_CORPAMOUNTPREC <> ri.EFX_CORPAMOUNTPREC;
    SELF.Diff_EFX_CORPAMOUNTTP := le.EFX_CORPAMOUNTTP <> ri.EFX_CORPAMOUNTTP;
    SELF.Diff_EFX_CORPEMPCD := le.EFX_CORPEMPCD <> ri.EFX_CORPEMPCD;
    SELF.Diff_EFX_WEB := le.EFX_WEB <> ri.EFX_WEB;
    SELF.Diff_EFX_CTRYISOCD := le.EFX_CTRYISOCD <> ri.EFX_CTRYISOCD;
    SELF.Diff_EFX_CTRYNUM := le.EFX_CTRYNUM <> ri.EFX_CTRYNUM;
    SELF.Diff_EFX_CTRYTELCD := le.EFX_CTRYTELCD <> ri.EFX_CTRYTELCD;
    SELF.Diff_EFX_GEOPREC := le.EFX_GEOPREC <> ri.EFX_GEOPREC;
    SELF.Diff_EFX_MERCTYPE := le.EFX_MERCTYPE <> ri.EFX_MERCTYPE;
    SELF.Diff_EFX_MRKT_TELESCORE := le.EFX_MRKT_TELESCORE <> ri.EFX_MRKT_TELESCORE;
    SELF.Diff_EFX_MRKT_TOTALIND := le.EFX_MRKT_TOTALIND <> ri.EFX_MRKT_TOTALIND;
    SELF.Diff_EFX_MRKT_TOTALSCORE := le.EFX_MRKT_TOTALSCORE <> ri.EFX_MRKT_TOTALSCORE;
    SELF.Diff_EFX_PUBLIC := le.EFX_PUBLIC <> ri.EFX_PUBLIC;
    SELF.Diff_EFX_STKEXC := le.EFX_STKEXC <> ri.EFX_STKEXC;
    SELF.Diff_EFX_PRIMSIC := le.EFX_PRIMSIC <> ri.EFX_PRIMSIC;
    SELF.Diff_EFX_SECSIC1 := le.EFX_SECSIC1 <> ri.EFX_SECSIC1;
    SELF.Diff_EFX_SECSIC2 := le.EFX_SECSIC2 <> ri.EFX_SECSIC2;
    SELF.Diff_EFX_SECSIC3 := le.EFX_SECSIC3 <> ri.EFX_SECSIC3;
    SELF.Diff_EFX_SECSIC4 := le.EFX_SECSIC4 <> ri.EFX_SECSIC4;
    SELF.Diff_EFX_ID := le.EFX_ID <> ri.EFX_ID;
    SELF.Diff_EFX_NAME := le.EFX_NAME <> ri.EFX_NAME;
    SELF.Diff_EFX_LEGAL_NAME := le.EFX_LEGAL_NAME <> ri.EFX_LEGAL_NAME;
    SELF.Diff_EFX_ADDRESS := le.EFX_ADDRESS <> ri.EFX_ADDRESS;
    SELF.Diff_EFX_CITY := le.EFX_CITY <> ri.EFX_CITY;
    SELF.Diff_EFX_REGION := le.EFX_REGION <> ri.EFX_REGION;
    SELF.Diff_EFX_CTRYNAME := le.EFX_CTRYNAME <> ri.EFX_CTRYNAME;
    SELF.Diff_EFX_COUNTYNM := le.EFX_COUNTYNM <> ri.EFX_COUNTYNM;
    SELF.Diff_EFX_CMSADESC := le.EFX_CMSADESC <> ri.EFX_CMSADESC;
    SELF.Diff_EFX_SOHO := le.EFX_SOHO <> ri.EFX_SOHO;
    SELF.Diff_EFX_BIZ := le.EFX_BIZ <> ri.EFX_BIZ;
    SELF.Diff_EFX_RES := le.EFX_RES <> ri.EFX_RES;
    SELF.Diff_EFX_CMRA := le.EFX_CMRA <> ri.EFX_CMRA;
    SELF.Diff_EFX_SECADR := le.EFX_SECADR <> ri.EFX_SECADR;
    SELF.Diff_EFX_SECCTY := le.EFX_SECCTY <> ri.EFX_SECCTY;
    SELF.Diff_EFX_SECGEOPREC := le.EFX_SECGEOPREC <> ri.EFX_SECGEOPREC;
    SELF.Diff_EFX_SECREGION := le.EFX_SECREGION <> ri.EFX_SECREGION;
    SELF.Diff_EFX_SECCTRYISOCD := le.EFX_SECCTRYISOCD <> ri.EFX_SECCTRYISOCD;
    SELF.Diff_EFX_SECCTRYNUM := le.EFX_SECCTRYNUM <> ri.EFX_SECCTRYNUM;
    SELF.Diff_EFX_SECCTRYNAME := le.EFX_SECCTRYNAME <> ri.EFX_SECCTRYNAME;
    SELF.Diff_EFX_PHONE := le.EFX_PHONE <> ri.EFX_PHONE;
    SELF.Diff_EFX_FAXPHONE := le.EFX_FAXPHONE <> ri.EFX_FAXPHONE;
    SELF.Diff_EFX_BUSSTAT := le.EFX_BUSSTAT <> ri.EFX_BUSSTAT;
    SELF.Diff_EFX_YREST := le.EFX_YREST <> ri.EFX_YREST;
    SELF.Diff_EFX_CORPEMPCNT := le.EFX_CORPEMPCNT <> ri.EFX_CORPEMPCNT;
    SELF.Diff_EFX_LOCEMPCNT := le.EFX_LOCEMPCNT <> ri.EFX_LOCEMPCNT;
    SELF.Diff_EFX_LOCEMPCD := le.EFX_LOCEMPCD <> ri.EFX_LOCEMPCD;
    SELF.Diff_EFX_CORPAMOUNT := le.EFX_CORPAMOUNT <> ri.EFX_CORPAMOUNT;
    SELF.Diff_EFX_LOCAMOUNT := le.EFX_LOCAMOUNT <> ri.EFX_LOCAMOUNT;
    SELF.Diff_EFX_LOCAMOUNTCD := le.EFX_LOCAMOUNTCD <> ri.EFX_LOCAMOUNTCD;
    SELF.Diff_EFX_LOCAMOUNTTP := le.EFX_LOCAMOUNTTP <> ri.EFX_LOCAMOUNTTP;
    SELF.Diff_EFX_LOCAMOUNTPREC := le.EFX_LOCAMOUNTPREC <> ri.EFX_LOCAMOUNTPREC;
    SELF.Diff_EFX_TCKSYM := le.EFX_TCKSYM <> ri.EFX_TCKSYM;
    SELF.Diff_EFX_PRIMSICDESC := le.EFX_PRIMSICDESC <> ri.EFX_PRIMSICDESC;
    SELF.Diff_EFX_SECSICDESC1 := le.EFX_SECSICDESC1 <> ri.EFX_SECSICDESC1;
    SELF.Diff_EFX_SECSICDESC2 := le.EFX_SECSICDESC2 <> ri.EFX_SECSICDESC2;
    SELF.Diff_EFX_SECSICDESC3 := le.EFX_SECSICDESC3 <> ri.EFX_SECSICDESC3;
    SELF.Diff_EFX_SECSICDESC4 := le.EFX_SECSICDESC4 <> ri.EFX_SECSICDESC4;
    SELF.Diff_EFX_PRIMNAICSCODE := le.EFX_PRIMNAICSCODE <> ri.EFX_PRIMNAICSCODE;
    SELF.Diff_EFX_SECNAICS1 := le.EFX_SECNAICS1 <> ri.EFX_SECNAICS1;
    SELF.Diff_EFX_SECNAICS2 := le.EFX_SECNAICS2 <> ri.EFX_SECNAICS2;
    SELF.Diff_EFX_SECNAICS3 := le.EFX_SECNAICS3 <> ri.EFX_SECNAICS3;
    SELF.Diff_EFX_SECNAICS4 := le.EFX_SECNAICS4 <> ri.EFX_SECNAICS4;
    SELF.Diff_EFX_PRIMNAICSDESC := le.EFX_PRIMNAICSDESC <> ri.EFX_PRIMNAICSDESC;
    SELF.Diff_EFX_SECNAICSDESC1 := le.EFX_SECNAICSDESC1 <> ri.EFX_SECNAICSDESC1;
    SELF.Diff_EFX_SECNAICSDESC2 := le.EFX_SECNAICSDESC2 <> ri.EFX_SECNAICSDESC2;
    SELF.Diff_EFX_SECNAICSDESC3 := le.EFX_SECNAICSDESC3 <> ri.EFX_SECNAICSDESC3;
    SELF.Diff_EFX_SECNAICSDESC4 := le.EFX_SECNAICSDESC4 <> ri.EFX_SECNAICSDESC4;
    SELF.Diff_EFX_DEAD := le.EFX_DEAD <> ri.EFX_DEAD;
    SELF.Diff_EFX_DEADDT := le.EFX_DEADDT <> ri.EFX_DEADDT;
    SELF.Diff_EFX_MRKT_TELEVER := le.EFX_MRKT_TELEVER <> ri.EFX_MRKT_TELEVER;
    SELF.Diff_EFX_MRKT_VACANT := le.EFX_MRKT_VACANT <> ri.EFX_MRKT_VACANT;
    SELF.Diff_EFX_MRKT_SEASONAL := le.EFX_MRKT_SEASONAL <> ri.EFX_MRKT_SEASONAL;
    SELF.Diff_EFX_MBE := le.EFX_MBE <> ri.EFX_MBE;
    SELF.Diff_EFX_WBE := le.EFX_WBE <> ri.EFX_WBE;
    SELF.Diff_EFX_MWBE := le.EFX_MWBE <> ri.EFX_MWBE;
    SELF.Diff_EFX_SDB := le.EFX_SDB <> ri.EFX_SDB;
    SELF.Diff_EFX_HUBZONE := le.EFX_HUBZONE <> ri.EFX_HUBZONE;
    SELF.Diff_EFX_DBE := le.EFX_DBE <> ri.EFX_DBE;
    SELF.Diff_EFX_VET := le.EFX_VET <> ri.EFX_VET;
    SELF.Diff_EFX_DVET := le.EFX_DVET <> ri.EFX_DVET;
    SELF.Diff_EFX_8a := le.EFX_8a <> ri.EFX_8a;
    SELF.Diff_EFX_8aEXPDT := le.EFX_8aEXPDT <> ri.EFX_8aEXPDT;
    SELF.Diff_EFX_DIS := le.EFX_DIS <> ri.EFX_DIS;
    SELF.Diff_EFX_SBE := le.EFX_SBE <> ri.EFX_SBE;
    SELF.Diff_EFX_BUSSIZE := le.EFX_BUSSIZE <> ri.EFX_BUSSIZE;
    SELF.Diff_EFX_LBE := le.EFX_LBE <> ri.EFX_LBE;
    SELF.Diff_EFX_GOV := le.EFX_GOV <> ri.EFX_GOV;
    SELF.Diff_EFX_FGOV := le.EFX_FGOV <> ri.EFX_FGOV;
    SELF.Diff_EFX_NONPROFIT := le.EFX_NONPROFIT <> ri.EFX_NONPROFIT;
    SELF.Diff_EFX_HBCU := le.EFX_HBCU <> ri.EFX_HBCU;
    SELF.Diff_EFX_GAYLESBIAN := le.EFX_GAYLESBIAN <> ri.EFX_GAYLESBIAN;
    SELF.Diff_EFX_WSBE := le.EFX_WSBE <> ri.EFX_WSBE;
    SELF.Diff_EFX_VSBE := le.EFX_VSBE <> ri.EFX_VSBE;
    SELF.Diff_EFX_DVSBE := le.EFX_DVSBE <> ri.EFX_DVSBE;
    SELF.Diff_EFX_MWBESTATUS := le.EFX_MWBESTATUS <> ri.EFX_MWBESTATUS;
    SELF.Diff_EFX_NMSDC := le.EFX_NMSDC <> ri.EFX_NMSDC;
    SELF.Diff_EFX_WBENC := le.EFX_WBENC <> ri.EFX_WBENC;
    SELF.Diff_EFX_CA_PUC := le.EFX_CA_PUC <> ri.EFX_CA_PUC;
    SELF.Diff_EFX_TX_HUB := le.EFX_TX_HUB <> ri.EFX_TX_HUB;
    SELF.Diff_EFX_TX_HUBCERTNUM := le.EFX_TX_HUBCERTNUM <> ri.EFX_TX_HUBCERTNUM;
    SELF.Diff_EFX_GSAX := le.EFX_GSAX <> ri.EFX_GSAX;
    SELF.Diff_EFX_CALTRANS := le.EFX_CALTRANS <> ri.EFX_CALTRANS;
    SELF.Diff_EFX_EDU := le.EFX_EDU <> ri.EFX_EDU;
    SELF.Diff_EFX_MI := le.EFX_MI <> ri.EFX_MI;
    SELF.Diff_EFX_ANC := le.EFX_ANC <> ri.EFX_ANC;
    SELF.Diff_AT_CERT1 := le.AT_CERT1 <> ri.AT_CERT1;
    SELF.Diff_AT_CERT2 := le.AT_CERT2 <> ri.AT_CERT2;
    SELF.Diff_AT_CERT3 := le.AT_CERT3 <> ri.AT_CERT3;
    SELF.Diff_AT_CERT4 := le.AT_CERT4 <> ri.AT_CERT4;
    SELF.Diff_AT_CERT5 := le.AT_CERT5 <> ri.AT_CERT5;
    SELF.Diff_AT_CERT6 := le.AT_CERT6 <> ri.AT_CERT6;
    SELF.Diff_AT_CERT7 := le.AT_CERT7 <> ri.AT_CERT7;
    SELF.Diff_AT_CERT8 := le.AT_CERT8 <> ri.AT_CERT8;
    SELF.Diff_AT_CERT9 := le.AT_CERT9 <> ri.AT_CERT9;
    SELF.Diff_AT_CERT10 := le.AT_CERT10 <> ri.AT_CERT10;
    SELF.Diff_AT_CERTDESC1 := le.AT_CERTDESC1 <> ri.AT_CERTDESC1;
    SELF.Diff_AT_CERTDESC2 := le.AT_CERTDESC2 <> ri.AT_CERTDESC2;
    SELF.Diff_AT_CERTDESC3 := le.AT_CERTDESC3 <> ri.AT_CERTDESC3;
    SELF.Diff_AT_CERTDESC4 := le.AT_CERTDESC4 <> ri.AT_CERTDESC4;
    SELF.Diff_AT_CERTDESC5 := le.AT_CERTDESC5 <> ri.AT_CERTDESC5;
    SELF.Diff_AT_CERTDESC6 := le.AT_CERTDESC6 <> ri.AT_CERTDESC6;
    SELF.Diff_AT_CERTDESC7 := le.AT_CERTDESC7 <> ri.AT_CERTDESC7;
    SELF.Diff_AT_CERTDESC8 := le.AT_CERTDESC8 <> ri.AT_CERTDESC8;
    SELF.Diff_AT_CERTDESC9 := le.AT_CERTDESC9 <> ri.AT_CERTDESC9;
    SELF.Diff_AT_CERTDESC10 := le.AT_CERTDESC10 <> ri.AT_CERTDESC10;
    SELF.Diff_AT_CERTSRC1 := le.AT_CERTSRC1 <> ri.AT_CERTSRC1;
    SELF.Diff_AT_CERTSRC2 := le.AT_CERTSRC2 <> ri.AT_CERTSRC2;
    SELF.Diff_AT_CERTSRC3 := le.AT_CERTSRC3 <> ri.AT_CERTSRC3;
    SELF.Diff_AT_CERTSRC4 := le.AT_CERTSRC4 <> ri.AT_CERTSRC4;
    SELF.Diff_AT_CERTSRC5 := le.AT_CERTSRC5 <> ri.AT_CERTSRC5;
    SELF.Diff_AT_CERTSRC6 := le.AT_CERTSRC6 <> ri.AT_CERTSRC6;
    SELF.Diff_AT_CERTSRC7 := le.AT_CERTSRC7 <> ri.AT_CERTSRC7;
    SELF.Diff_AT_CERTSRC8 := le.AT_CERTSRC8 <> ri.AT_CERTSRC8;
    SELF.Diff_AT_CERTSRC9 := le.AT_CERTSRC9 <> ri.AT_CERTSRC9;
    SELF.Diff_AT_CERTSRC10 := le.AT_CERTSRC10 <> ri.AT_CERTSRC10;
    SELF.Diff_AT_CERTLEV1 := le.AT_CERTLEV1 <> ri.AT_CERTLEV1;
    SELF.Diff_AT_CERTLEV2 := le.AT_CERTLEV2 <> ri.AT_CERTLEV2;
    SELF.Diff_AT_CERTLEV3 := le.AT_CERTLEV3 <> ri.AT_CERTLEV3;
    SELF.Diff_AT_CERTLEV4 := le.AT_CERTLEV4 <> ri.AT_CERTLEV4;
    SELF.Diff_AT_CERTLEV5 := le.AT_CERTLEV5 <> ri.AT_CERTLEV5;
    SELF.Diff_AT_CERTLEV6 := le.AT_CERTLEV6 <> ri.AT_CERTLEV6;
    SELF.Diff_AT_CERTLEV7 := le.AT_CERTLEV7 <> ri.AT_CERTLEV7;
    SELF.Diff_AT_CERTLEV8 := le.AT_CERTLEV8 <> ri.AT_CERTLEV8;
    SELF.Diff_AT_CERTLEV9 := le.AT_CERTLEV9 <> ri.AT_CERTLEV9;
    SELF.Diff_AT_CERTLEV10 := le.AT_CERTLEV10 <> ri.AT_CERTLEV10;
    SELF.Diff_AT_CERTNUM1 := le.AT_CERTNUM1 <> ri.AT_CERTNUM1;
    SELF.Diff_AT_CERTNUM2 := le.AT_CERTNUM2 <> ri.AT_CERTNUM2;
    SELF.Diff_AT_CERTNUM3 := le.AT_CERTNUM3 <> ri.AT_CERTNUM3;
    SELF.Diff_AT_CERTNUM4 := le.AT_CERTNUM4 <> ri.AT_CERTNUM4;
    SELF.Diff_AT_CERTNUM5 := le.AT_CERTNUM5 <> ri.AT_CERTNUM5;
    SELF.Diff_AT_CERTNUM6 := le.AT_CERTNUM6 <> ri.AT_CERTNUM6;
    SELF.Diff_AT_CERTNUM7 := le.AT_CERTNUM7 <> ri.AT_CERTNUM7;
    SELF.Diff_AT_CERTNUM8 := le.AT_CERTNUM8 <> ri.AT_CERTNUM8;
    SELF.Diff_AT_CERTNUM9 := le.AT_CERTNUM9 <> ri.AT_CERTNUM9;
    SELF.Diff_AT_CERTNUM10 := le.AT_CERTNUM10 <> ri.AT_CERTNUM10;
    SELF.Diff_AT_CERTEXP1 := le.AT_CERTEXP1 <> ri.AT_CERTEXP1;
    SELF.Diff_AT_CERTEXP2 := le.AT_CERTEXP2 <> ri.AT_CERTEXP2;
    SELF.Diff_AT_CERTEXP3 := le.AT_CERTEXP3 <> ri.AT_CERTEXP3;
    SELF.Diff_AT_CERTEXP4 := le.AT_CERTEXP4 <> ri.AT_CERTEXP4;
    SELF.Diff_AT_CERTEXP5 := le.AT_CERTEXP5 <> ri.AT_CERTEXP5;
    SELF.Diff_AT_CERTEXP6 := le.AT_CERTEXP6 <> ri.AT_CERTEXP6;
    SELF.Diff_AT_CERTEXP7 := le.AT_CERTEXP7 <> ri.AT_CERTEXP7;
    SELF.Diff_AT_CERTEXP8 := le.AT_CERTEXP8 <> ri.AT_CERTEXP8;
    SELF.Diff_AT_CERTEXP9 := le.AT_CERTEXP9 <> ri.AT_CERTEXP9;
    SELF.Diff_AT_CERTEXP10 := le.AT_CERTEXP10 <> ri.AT_CERTEXP10;
    SELF.Diff_EFX_EXTRACT_DATE := le.EFX_EXTRACT_DATE <> ri.EFX_EXTRACT_DATE;
    SELF.Diff_EFX_MERCHANT_ID := le.EFX_MERCHANT_ID <> ri.EFX_MERCHANT_ID;
    SELF.Diff_EFX_PROJECT_ID := le.EFX_PROJECT_ID <> ri.EFX_PROJECT_ID;
    SELF.Diff_EFX_FOREIGN := le.EFX_FOREIGN <> ri.EFX_FOREIGN;
    SELF.Diff_Record_Update_Refresh_Date := le.Record_Update_Refresh_Date <> ri.Record_Update_Refresh_Date;
    SELF.Diff_EFX_DATE_CREATED := le.EFX_DATE_CREATED <> ri.EFX_DATE_CREATED;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_normcompany_type,1,0)+ IF( SELF.Diff_normaddress_type,1,0)+ IF( SELF.Diff_norm_state,1,0)+ IF( SELF.Diff_EFX_BUSSTATCD,1,0)+ IF( SELF.Diff_EFX_CMSA,1,0)+ IF( SELF.Diff_EFX_CORPAMOUNTCD,1,0)+ IF( SELF.Diff_EFX_CORPAMOUNTPREC,1,0)+ IF( SELF.Diff_EFX_CORPAMOUNTTP,1,0)+ IF( SELF.Diff_EFX_CORPEMPCD,1,0)+ IF( SELF.Diff_EFX_WEB,1,0)+ IF( SELF.Diff_EFX_CTRYISOCD,1,0)+ IF( SELF.Diff_EFX_CTRYNUM,1,0)+ IF( SELF.Diff_EFX_CTRYTELCD,1,0)+ IF( SELF.Diff_EFX_GEOPREC,1,0)+ IF( SELF.Diff_EFX_MERCTYPE,1,0)+ IF( SELF.Diff_EFX_MRKT_TELESCORE,1,0)+ IF( SELF.Diff_EFX_MRKT_TOTALIND,1,0)+ IF( SELF.Diff_EFX_MRKT_TOTALSCORE,1,0)+ IF( SELF.Diff_EFX_PUBLIC,1,0)+ IF( SELF.Diff_EFX_STKEXC,1,0)+ IF( SELF.Diff_EFX_PRIMSIC,1,0)+ IF( SELF.Diff_EFX_SECSIC1,1,0)+ IF( SELF.Diff_EFX_SECSIC2,1,0)+ IF( SELF.Diff_EFX_SECSIC3,1,0)+ IF( SELF.Diff_EFX_SECSIC4,1,0)+ IF( SELF.Diff_EFX_ID,1,0)+ IF( SELF.Diff_EFX_NAME,1,0)+ IF( SELF.Diff_EFX_LEGAL_NAME,1,0)+ IF( SELF.Diff_EFX_ADDRESS,1,0)+ IF( SELF.Diff_EFX_CITY,1,0)+ IF( SELF.Diff_EFX_REGION,1,0)+ IF( SELF.Diff_EFX_CTRYNAME,1,0)+ IF( SELF.Diff_EFX_COUNTYNM,1,0)+ IF( SELF.Diff_EFX_CMSADESC,1,0)+ IF( SELF.Diff_EFX_SOHO,1,0)+ IF( SELF.Diff_EFX_BIZ,1,0)+ IF( SELF.Diff_EFX_RES,1,0)+ IF( SELF.Diff_EFX_CMRA,1,0)+ IF( SELF.Diff_EFX_SECADR,1,0)+ IF( SELF.Diff_EFX_SECCTY,1,0)+ IF( SELF.Diff_EFX_SECGEOPREC,1,0)+ IF( SELF.Diff_EFX_SECREGION,1,0)+ IF( SELF.Diff_EFX_SECCTRYISOCD,1,0)+ IF( SELF.Diff_EFX_SECCTRYNUM,1,0)+ IF( SELF.Diff_EFX_SECCTRYNAME,1,0)+ IF( SELF.Diff_EFX_PHONE,1,0)+ IF( SELF.Diff_EFX_FAXPHONE,1,0)+ IF( SELF.Diff_EFX_BUSSTAT,1,0)+ IF( SELF.Diff_EFX_YREST,1,0)+ IF( SELF.Diff_EFX_CORPEMPCNT,1,0)+ IF( SELF.Diff_EFX_LOCEMPCNT,1,0)+ IF( SELF.Diff_EFX_LOCEMPCD,1,0)+ IF( SELF.Diff_EFX_CORPAMOUNT,1,0)+ IF( SELF.Diff_EFX_LOCAMOUNT,1,0)+ IF( SELF.Diff_EFX_LOCAMOUNTCD,1,0)+ IF( SELF.Diff_EFX_LOCAMOUNTTP,1,0)+ IF( SELF.Diff_EFX_LOCAMOUNTPREC,1,0)+ IF( SELF.Diff_EFX_TCKSYM,1,0)+ IF( SELF.Diff_EFX_PRIMSICDESC,1,0)+ IF( SELF.Diff_EFX_SECSICDESC1,1,0)+ IF( SELF.Diff_EFX_SECSICDESC2,1,0)+ IF( SELF.Diff_EFX_SECSICDESC3,1,0)+ IF( SELF.Diff_EFX_SECSICDESC4,1,0)+ IF( SELF.Diff_EFX_PRIMNAICSCODE,1,0)+ IF( SELF.Diff_EFX_SECNAICS1,1,0)+ IF( SELF.Diff_EFX_SECNAICS2,1,0)+ IF( SELF.Diff_EFX_SECNAICS3,1,0)+ IF( SELF.Diff_EFX_SECNAICS4,1,0)+ IF( SELF.Diff_EFX_PRIMNAICSDESC,1,0)+ IF( SELF.Diff_EFX_SECNAICSDESC1,1,0)+ IF( SELF.Diff_EFX_SECNAICSDESC2,1,0)+ IF( SELF.Diff_EFX_SECNAICSDESC3,1,0)+ IF( SELF.Diff_EFX_SECNAICSDESC4,1,0)+ IF( SELF.Diff_EFX_DEAD,1,0)+ IF( SELF.Diff_EFX_DEADDT,1,0)+ IF( SELF.Diff_EFX_MRKT_TELEVER,1,0)+ IF( SELF.Diff_EFX_MRKT_VACANT,1,0)+ IF( SELF.Diff_EFX_MRKT_SEASONAL,1,0)+ IF( SELF.Diff_EFX_MBE,1,0)+ IF( SELF.Diff_EFX_WBE,1,0)+ IF( SELF.Diff_EFX_MWBE,1,0)+ IF( SELF.Diff_EFX_SDB,1,0)+ IF( SELF.Diff_EFX_HUBZONE,1,0)+ IF( SELF.Diff_EFX_DBE,1,0)+ IF( SELF.Diff_EFX_VET,1,0)+ IF( SELF.Diff_EFX_DVET,1,0)+ IF( SELF.Diff_EFX_8a,1,0)+ IF( SELF.Diff_EFX_8aEXPDT,1,0)+ IF( SELF.Diff_EFX_DIS,1,0)+ IF( SELF.Diff_EFX_SBE,1,0)+ IF( SELF.Diff_EFX_BUSSIZE,1,0)+ IF( SELF.Diff_EFX_LBE,1,0)+ IF( SELF.Diff_EFX_GOV,1,0)+ IF( SELF.Diff_EFX_FGOV,1,0)+ IF( SELF.Diff_EFX_NONPROFIT,1,0)+ IF( SELF.Diff_EFX_HBCU,1,0)+ IF( SELF.Diff_EFX_GAYLESBIAN,1,0)+ IF( SELF.Diff_EFX_WSBE,1,0)+ IF( SELF.Diff_EFX_VSBE,1,0)+ IF( SELF.Diff_EFX_DVSBE,1,0)+ IF( SELF.Diff_EFX_MWBESTATUS,1,0)+ IF( SELF.Diff_EFX_NMSDC,1,0)+ IF( SELF.Diff_EFX_WBENC,1,0)+ IF( SELF.Diff_EFX_CA_PUC,1,0)+ IF( SELF.Diff_EFX_TX_HUB,1,0)+ IF( SELF.Diff_EFX_TX_HUBCERTNUM,1,0)+ IF( SELF.Diff_EFX_GSAX,1,0)+ IF( SELF.Diff_EFX_CALTRANS,1,0)+ IF( SELF.Diff_EFX_EDU,1,0)+ IF( SELF.Diff_EFX_MI,1,0)+ IF( SELF.Diff_EFX_ANC,1,0)+ IF( SELF.Diff_AT_CERT1,1,0)+ IF( SELF.Diff_AT_CERT2,1,0)+ IF( SELF.Diff_AT_CERT3,1,0)+ IF( SELF.Diff_AT_CERT4,1,0)+ IF( SELF.Diff_AT_CERT5,1,0)+ IF( SELF.Diff_AT_CERT6,1,0)+ IF( SELF.Diff_AT_CERT7,1,0)+ IF( SELF.Diff_AT_CERT8,1,0)+ IF( SELF.Diff_AT_CERT9,1,0)+ IF( SELF.Diff_AT_CERT10,1,0)+ IF( SELF.Diff_AT_CERTDESC1,1,0)+ IF( SELF.Diff_AT_CERTDESC2,1,0)+ IF( SELF.Diff_AT_CERTDESC3,1,0)+ IF( SELF.Diff_AT_CERTDESC4,1,0)+ IF( SELF.Diff_AT_CERTDESC5,1,0)+ IF( SELF.Diff_AT_CERTDESC6,1,0)+ IF( SELF.Diff_AT_CERTDESC7,1,0)+ IF( SELF.Diff_AT_CERTDESC8,1,0)+ IF( SELF.Diff_AT_CERTDESC9,1,0)+ IF( SELF.Diff_AT_CERTDESC10,1,0)+ IF( SELF.Diff_AT_CERTSRC1,1,0)+ IF( SELF.Diff_AT_CERTSRC2,1,0)+ IF( SELF.Diff_AT_CERTSRC3,1,0)+ IF( SELF.Diff_AT_CERTSRC4,1,0)+ IF( SELF.Diff_AT_CERTSRC5,1,0)+ IF( SELF.Diff_AT_CERTSRC6,1,0)+ IF( SELF.Diff_AT_CERTSRC7,1,0)+ IF( SELF.Diff_AT_CERTSRC8,1,0)+ IF( SELF.Diff_AT_CERTSRC9,1,0)+ IF( SELF.Diff_AT_CERTSRC10,1,0)+ IF( SELF.Diff_AT_CERTLEV1,1,0)+ IF( SELF.Diff_AT_CERTLEV2,1,0)+ IF( SELF.Diff_AT_CERTLEV3,1,0)+ IF( SELF.Diff_AT_CERTLEV4,1,0)+ IF( SELF.Diff_AT_CERTLEV5,1,0)+ IF( SELF.Diff_AT_CERTLEV6,1,0)+ IF( SELF.Diff_AT_CERTLEV7,1,0)+ IF( SELF.Diff_AT_CERTLEV8,1,0)+ IF( SELF.Diff_AT_CERTLEV9,1,0)+ IF( SELF.Diff_AT_CERTLEV10,1,0)+ IF( SELF.Diff_AT_CERTNUM1,1,0)+ IF( SELF.Diff_AT_CERTNUM2,1,0)+ IF( SELF.Diff_AT_CERTNUM3,1,0)+ IF( SELF.Diff_AT_CERTNUM4,1,0)+ IF( SELF.Diff_AT_CERTNUM5,1,0)+ IF( SELF.Diff_AT_CERTNUM6,1,0)+ IF( SELF.Diff_AT_CERTNUM7,1,0)+ IF( SELF.Diff_AT_CERTNUM8,1,0)+ IF( SELF.Diff_AT_CERTNUM9,1,0)+ IF( SELF.Diff_AT_CERTNUM10,1,0)+ IF( SELF.Diff_AT_CERTEXP1,1,0)+ IF( SELF.Diff_AT_CERTEXP2,1,0)+ IF( SELF.Diff_AT_CERTEXP3,1,0)+ IF( SELF.Diff_AT_CERTEXP4,1,0)+ IF( SELF.Diff_AT_CERTEXP5,1,0)+ IF( SELF.Diff_AT_CERTEXP6,1,0)+ IF( SELF.Diff_AT_CERTEXP7,1,0)+ IF( SELF.Diff_AT_CERTEXP8,1,0)+ IF( SELF.Diff_AT_CERTEXP9,1,0)+ IF( SELF.Diff_AT_CERTEXP10,1,0)+ IF( SELF.Diff_EFX_EXTRACT_DATE,1,0)+ IF( SELF.Diff_EFX_MERCHANT_ID,1,0)+ IF( SELF.Diff_EFX_PROJECT_ID,1,0)+ IF( SELF.Diff_EFX_FOREIGN,1,0)+ IF( SELF.Diff_Record_Update_Refresh_Date,1,0)+ IF( SELF.Diff_EFX_DATE_CREATED,1,0);
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
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_normcompany_type := COUNT(GROUP,%Closest%.Diff_normcompany_type);
    Count_Diff_normaddress_type := COUNT(GROUP,%Closest%.Diff_normaddress_type);
    Count_Diff_norm_state := COUNT(GROUP,%Closest%.Diff_norm_state);
    Count_Diff_EFX_BUSSTATCD := COUNT(GROUP,%Closest%.Diff_EFX_BUSSTATCD);
    Count_Diff_EFX_CMSA := COUNT(GROUP,%Closest%.Diff_EFX_CMSA);
    Count_Diff_EFX_CORPAMOUNTCD := COUNT(GROUP,%Closest%.Diff_EFX_CORPAMOUNTCD);
    Count_Diff_EFX_CORPAMOUNTPREC := COUNT(GROUP,%Closest%.Diff_EFX_CORPAMOUNTPREC);
    Count_Diff_EFX_CORPAMOUNTTP := COUNT(GROUP,%Closest%.Diff_EFX_CORPAMOUNTTP);
    Count_Diff_EFX_CORPEMPCD := COUNT(GROUP,%Closest%.Diff_EFX_CORPEMPCD);
    Count_Diff_EFX_WEB := COUNT(GROUP,%Closest%.Diff_EFX_WEB);
    Count_Diff_EFX_CTRYISOCD := COUNT(GROUP,%Closest%.Diff_EFX_CTRYISOCD);
    Count_Diff_EFX_CTRYNUM := COUNT(GROUP,%Closest%.Diff_EFX_CTRYNUM);
    Count_Diff_EFX_CTRYTELCD := COUNT(GROUP,%Closest%.Diff_EFX_CTRYTELCD);
    Count_Diff_EFX_GEOPREC := COUNT(GROUP,%Closest%.Diff_EFX_GEOPREC);
    Count_Diff_EFX_MERCTYPE := COUNT(GROUP,%Closest%.Diff_EFX_MERCTYPE);
    Count_Diff_EFX_MRKT_TELESCORE := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_TELESCORE);
    Count_Diff_EFX_MRKT_TOTALIND := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_TOTALIND);
    Count_Diff_EFX_MRKT_TOTALSCORE := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_TOTALSCORE);
    Count_Diff_EFX_PUBLIC := COUNT(GROUP,%Closest%.Diff_EFX_PUBLIC);
    Count_Diff_EFX_STKEXC := COUNT(GROUP,%Closest%.Diff_EFX_STKEXC);
    Count_Diff_EFX_PRIMSIC := COUNT(GROUP,%Closest%.Diff_EFX_PRIMSIC);
    Count_Diff_EFX_SECSIC1 := COUNT(GROUP,%Closest%.Diff_EFX_SECSIC1);
    Count_Diff_EFX_SECSIC2 := COUNT(GROUP,%Closest%.Diff_EFX_SECSIC2);
    Count_Diff_EFX_SECSIC3 := COUNT(GROUP,%Closest%.Diff_EFX_SECSIC3);
    Count_Diff_EFX_SECSIC4 := COUNT(GROUP,%Closest%.Diff_EFX_SECSIC4);
    Count_Diff_EFX_ID := COUNT(GROUP,%Closest%.Diff_EFX_ID);
    Count_Diff_EFX_NAME := COUNT(GROUP,%Closest%.Diff_EFX_NAME);
    Count_Diff_EFX_LEGAL_NAME := COUNT(GROUP,%Closest%.Diff_EFX_LEGAL_NAME);
    Count_Diff_EFX_ADDRESS := COUNT(GROUP,%Closest%.Diff_EFX_ADDRESS);
    Count_Diff_EFX_CITY := COUNT(GROUP,%Closest%.Diff_EFX_CITY);
    Count_Diff_EFX_REGION := COUNT(GROUP,%Closest%.Diff_EFX_REGION);
    Count_Diff_EFX_CTRYNAME := COUNT(GROUP,%Closest%.Diff_EFX_CTRYNAME);
    Count_Diff_EFX_COUNTYNM := COUNT(GROUP,%Closest%.Diff_EFX_COUNTYNM);
    Count_Diff_EFX_CMSADESC := COUNT(GROUP,%Closest%.Diff_EFX_CMSADESC);
    Count_Diff_EFX_SOHO := COUNT(GROUP,%Closest%.Diff_EFX_SOHO);
    Count_Diff_EFX_BIZ := COUNT(GROUP,%Closest%.Diff_EFX_BIZ);
    Count_Diff_EFX_RES := COUNT(GROUP,%Closest%.Diff_EFX_RES);
    Count_Diff_EFX_CMRA := COUNT(GROUP,%Closest%.Diff_EFX_CMRA);
    Count_Diff_EFX_SECADR := COUNT(GROUP,%Closest%.Diff_EFX_SECADR);
    Count_Diff_EFX_SECCTY := COUNT(GROUP,%Closest%.Diff_EFX_SECCTY);
    Count_Diff_EFX_SECGEOPREC := COUNT(GROUP,%Closest%.Diff_EFX_SECGEOPREC);
    Count_Diff_EFX_SECREGION := COUNT(GROUP,%Closest%.Diff_EFX_SECREGION);
    Count_Diff_EFX_SECCTRYISOCD := COUNT(GROUP,%Closest%.Diff_EFX_SECCTRYISOCD);
    Count_Diff_EFX_SECCTRYNUM := COUNT(GROUP,%Closest%.Diff_EFX_SECCTRYNUM);
    Count_Diff_EFX_SECCTRYNAME := COUNT(GROUP,%Closest%.Diff_EFX_SECCTRYNAME);
    Count_Diff_EFX_PHONE := COUNT(GROUP,%Closest%.Diff_EFX_PHONE);
    Count_Diff_EFX_FAXPHONE := COUNT(GROUP,%Closest%.Diff_EFX_FAXPHONE);
    Count_Diff_EFX_BUSSTAT := COUNT(GROUP,%Closest%.Diff_EFX_BUSSTAT);
    Count_Diff_EFX_YREST := COUNT(GROUP,%Closest%.Diff_EFX_YREST);
    Count_Diff_EFX_CORPEMPCNT := COUNT(GROUP,%Closest%.Diff_EFX_CORPEMPCNT);
    Count_Diff_EFX_LOCEMPCNT := COUNT(GROUP,%Closest%.Diff_EFX_LOCEMPCNT);
    Count_Diff_EFX_LOCEMPCD := COUNT(GROUP,%Closest%.Diff_EFX_LOCEMPCD);
    Count_Diff_EFX_CORPAMOUNT := COUNT(GROUP,%Closest%.Diff_EFX_CORPAMOUNT);
    Count_Diff_EFX_LOCAMOUNT := COUNT(GROUP,%Closest%.Diff_EFX_LOCAMOUNT);
    Count_Diff_EFX_LOCAMOUNTCD := COUNT(GROUP,%Closest%.Diff_EFX_LOCAMOUNTCD);
    Count_Diff_EFX_LOCAMOUNTTP := COUNT(GROUP,%Closest%.Diff_EFX_LOCAMOUNTTP);
    Count_Diff_EFX_LOCAMOUNTPREC := COUNT(GROUP,%Closest%.Diff_EFX_LOCAMOUNTPREC);
    Count_Diff_EFX_TCKSYM := COUNT(GROUP,%Closest%.Diff_EFX_TCKSYM);
    Count_Diff_EFX_PRIMSICDESC := COUNT(GROUP,%Closest%.Diff_EFX_PRIMSICDESC);
    Count_Diff_EFX_SECSICDESC1 := COUNT(GROUP,%Closest%.Diff_EFX_SECSICDESC1);
    Count_Diff_EFX_SECSICDESC2 := COUNT(GROUP,%Closest%.Diff_EFX_SECSICDESC2);
    Count_Diff_EFX_SECSICDESC3 := COUNT(GROUP,%Closest%.Diff_EFX_SECSICDESC3);
    Count_Diff_EFX_SECSICDESC4 := COUNT(GROUP,%Closest%.Diff_EFX_SECSICDESC4);
    Count_Diff_EFX_PRIMNAICSCODE := COUNT(GROUP,%Closest%.Diff_EFX_PRIMNAICSCODE);
    Count_Diff_EFX_SECNAICS1 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICS1);
    Count_Diff_EFX_SECNAICS2 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICS2);
    Count_Diff_EFX_SECNAICS3 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICS3);
    Count_Diff_EFX_SECNAICS4 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICS4);
    Count_Diff_EFX_PRIMNAICSDESC := COUNT(GROUP,%Closest%.Diff_EFX_PRIMNAICSDESC);
    Count_Diff_EFX_SECNAICSDESC1 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICSDESC1);
    Count_Diff_EFX_SECNAICSDESC2 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICSDESC2);
    Count_Diff_EFX_SECNAICSDESC3 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICSDESC3);
    Count_Diff_EFX_SECNAICSDESC4 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICSDESC4);
    Count_Diff_EFX_DEAD := COUNT(GROUP,%Closest%.Diff_EFX_DEAD);
    Count_Diff_EFX_DEADDT := COUNT(GROUP,%Closest%.Diff_EFX_DEADDT);
    Count_Diff_EFX_MRKT_TELEVER := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_TELEVER);
    Count_Diff_EFX_MRKT_VACANT := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_VACANT);
    Count_Diff_EFX_MRKT_SEASONAL := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_SEASONAL);
    Count_Diff_EFX_MBE := COUNT(GROUP,%Closest%.Diff_EFX_MBE);
    Count_Diff_EFX_WBE := COUNT(GROUP,%Closest%.Diff_EFX_WBE);
    Count_Diff_EFX_MWBE := COUNT(GROUP,%Closest%.Diff_EFX_MWBE);
    Count_Diff_EFX_SDB := COUNT(GROUP,%Closest%.Diff_EFX_SDB);
    Count_Diff_EFX_HUBZONE := COUNT(GROUP,%Closest%.Diff_EFX_HUBZONE);
    Count_Diff_EFX_DBE := COUNT(GROUP,%Closest%.Diff_EFX_DBE);
    Count_Diff_EFX_VET := COUNT(GROUP,%Closest%.Diff_EFX_VET);
    Count_Diff_EFX_DVET := COUNT(GROUP,%Closest%.Diff_EFX_DVET);
    Count_Diff_EFX_8a := COUNT(GROUP,%Closest%.Diff_EFX_8a);
    Count_Diff_EFX_8aEXPDT := COUNT(GROUP,%Closest%.Diff_EFX_8aEXPDT);
    Count_Diff_EFX_DIS := COUNT(GROUP,%Closest%.Diff_EFX_DIS);
    Count_Diff_EFX_SBE := COUNT(GROUP,%Closest%.Diff_EFX_SBE);
    Count_Diff_EFX_BUSSIZE := COUNT(GROUP,%Closest%.Diff_EFX_BUSSIZE);
    Count_Diff_EFX_LBE := COUNT(GROUP,%Closest%.Diff_EFX_LBE);
    Count_Diff_EFX_GOV := COUNT(GROUP,%Closest%.Diff_EFX_GOV);
    Count_Diff_EFX_FGOV := COUNT(GROUP,%Closest%.Diff_EFX_FGOV);
    Count_Diff_EFX_NONPROFIT := COUNT(GROUP,%Closest%.Diff_EFX_NONPROFIT);
    Count_Diff_EFX_HBCU := COUNT(GROUP,%Closest%.Diff_EFX_HBCU);
    Count_Diff_EFX_GAYLESBIAN := COUNT(GROUP,%Closest%.Diff_EFX_GAYLESBIAN);
    Count_Diff_EFX_WSBE := COUNT(GROUP,%Closest%.Diff_EFX_WSBE);
    Count_Diff_EFX_VSBE := COUNT(GROUP,%Closest%.Diff_EFX_VSBE);
    Count_Diff_EFX_DVSBE := COUNT(GROUP,%Closest%.Diff_EFX_DVSBE);
    Count_Diff_EFX_MWBESTATUS := COUNT(GROUP,%Closest%.Diff_EFX_MWBESTATUS);
    Count_Diff_EFX_NMSDC := COUNT(GROUP,%Closest%.Diff_EFX_NMSDC);
    Count_Diff_EFX_WBENC := COUNT(GROUP,%Closest%.Diff_EFX_WBENC);
    Count_Diff_EFX_CA_PUC := COUNT(GROUP,%Closest%.Diff_EFX_CA_PUC);
    Count_Diff_EFX_TX_HUB := COUNT(GROUP,%Closest%.Diff_EFX_TX_HUB);
    Count_Diff_EFX_TX_HUBCERTNUM := COUNT(GROUP,%Closest%.Diff_EFX_TX_HUBCERTNUM);
    Count_Diff_EFX_GSAX := COUNT(GROUP,%Closest%.Diff_EFX_GSAX);
    Count_Diff_EFX_CALTRANS := COUNT(GROUP,%Closest%.Diff_EFX_CALTRANS);
    Count_Diff_EFX_EDU := COUNT(GROUP,%Closest%.Diff_EFX_EDU);
    Count_Diff_EFX_MI := COUNT(GROUP,%Closest%.Diff_EFX_MI);
    Count_Diff_EFX_ANC := COUNT(GROUP,%Closest%.Diff_EFX_ANC);
    Count_Diff_AT_CERT1 := COUNT(GROUP,%Closest%.Diff_AT_CERT1);
    Count_Diff_AT_CERT2 := COUNT(GROUP,%Closest%.Diff_AT_CERT2);
    Count_Diff_AT_CERT3 := COUNT(GROUP,%Closest%.Diff_AT_CERT3);
    Count_Diff_AT_CERT4 := COUNT(GROUP,%Closest%.Diff_AT_CERT4);
    Count_Diff_AT_CERT5 := COUNT(GROUP,%Closest%.Diff_AT_CERT5);
    Count_Diff_AT_CERT6 := COUNT(GROUP,%Closest%.Diff_AT_CERT6);
    Count_Diff_AT_CERT7 := COUNT(GROUP,%Closest%.Diff_AT_CERT7);
    Count_Diff_AT_CERT8 := COUNT(GROUP,%Closest%.Diff_AT_CERT8);
    Count_Diff_AT_CERT9 := COUNT(GROUP,%Closest%.Diff_AT_CERT9);
    Count_Diff_AT_CERT10 := COUNT(GROUP,%Closest%.Diff_AT_CERT10);
    Count_Diff_AT_CERTDESC1 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC1);
    Count_Diff_AT_CERTDESC2 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC2);
    Count_Diff_AT_CERTDESC3 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC3);
    Count_Diff_AT_CERTDESC4 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC4);
    Count_Diff_AT_CERTDESC5 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC5);
    Count_Diff_AT_CERTDESC6 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC6);
    Count_Diff_AT_CERTDESC7 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC7);
    Count_Diff_AT_CERTDESC8 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC8);
    Count_Diff_AT_CERTDESC9 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC9);
    Count_Diff_AT_CERTDESC10 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC10);
    Count_Diff_AT_CERTSRC1 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC1);
    Count_Diff_AT_CERTSRC2 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC2);
    Count_Diff_AT_CERTSRC3 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC3);
    Count_Diff_AT_CERTSRC4 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC4);
    Count_Diff_AT_CERTSRC5 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC5);
    Count_Diff_AT_CERTSRC6 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC6);
    Count_Diff_AT_CERTSRC7 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC7);
    Count_Diff_AT_CERTSRC8 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC8);
    Count_Diff_AT_CERTSRC9 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC9);
    Count_Diff_AT_CERTSRC10 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC10);
    Count_Diff_AT_CERTLEV1 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV1);
    Count_Diff_AT_CERTLEV2 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV2);
    Count_Diff_AT_CERTLEV3 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV3);
    Count_Diff_AT_CERTLEV4 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV4);
    Count_Diff_AT_CERTLEV5 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV5);
    Count_Diff_AT_CERTLEV6 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV6);
    Count_Diff_AT_CERTLEV7 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV7);
    Count_Diff_AT_CERTLEV8 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV8);
    Count_Diff_AT_CERTLEV9 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV9);
    Count_Diff_AT_CERTLEV10 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV10);
    Count_Diff_AT_CERTNUM1 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM1);
    Count_Diff_AT_CERTNUM2 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM2);
    Count_Diff_AT_CERTNUM3 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM3);
    Count_Diff_AT_CERTNUM4 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM4);
    Count_Diff_AT_CERTNUM5 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM5);
    Count_Diff_AT_CERTNUM6 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM6);
    Count_Diff_AT_CERTNUM7 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM7);
    Count_Diff_AT_CERTNUM8 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM8);
    Count_Diff_AT_CERTNUM9 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM9);
    Count_Diff_AT_CERTNUM10 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM10);
    Count_Diff_AT_CERTEXP1 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP1);
    Count_Diff_AT_CERTEXP2 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP2);
    Count_Diff_AT_CERTEXP3 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP3);
    Count_Diff_AT_CERTEXP4 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP4);
    Count_Diff_AT_CERTEXP5 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP5);
    Count_Diff_AT_CERTEXP6 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP6);
    Count_Diff_AT_CERTEXP7 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP7);
    Count_Diff_AT_CERTEXP8 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP8);
    Count_Diff_AT_CERTEXP9 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP9);
    Count_Diff_AT_CERTEXP10 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP10);
    Count_Diff_EFX_EXTRACT_DATE := COUNT(GROUP,%Closest%.Diff_EFX_EXTRACT_DATE);
    Count_Diff_EFX_MERCHANT_ID := COUNT(GROUP,%Closest%.Diff_EFX_MERCHANT_ID);
    Count_Diff_EFX_PROJECT_ID := COUNT(GROUP,%Closest%.Diff_EFX_PROJECT_ID);
    Count_Diff_EFX_FOREIGN := COUNT(GROUP,%Closest%.Diff_EFX_FOREIGN);
    Count_Diff_Record_Update_Refresh_Date := COUNT(GROUP,%Closest%.Diff_Record_Update_Refresh_Date);
    Count_Diff_EFX_DATE_CREATED := COUNT(GROUP,%Closest%.Diff_EFX_DATE_CREATED);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

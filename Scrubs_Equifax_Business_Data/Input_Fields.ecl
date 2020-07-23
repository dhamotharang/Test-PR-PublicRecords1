IMPORT SALT311;
IMPORT Scrubs_Equifax_Business_Data,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_Fields := MODULE
 
EXPORT NumFields := 116;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_ace_aid','invalid_address_type_code','invalid_alpha','invalid_business_size','invalid_busstatcd','invalid_cart','invalid_cert_or_class','invalid_chk_digit','invalid_cmsa','invalid_county','invalid_corpamountcd','invalid_corpamountprec','invalid_corpamounttp','invalid_corpempcd','invalid_cr_sort_sz','invalid_ctryisocd','invalid_ctrynum','invalid_ctrytelcd','invalid_current_future_date','invalid_current_past_date','invalid_date_created','invalid_date_seen','invalid_dbpc','invalid_email','invalid_direction','invalid_err_stat','invalid_fips_state','invalid_fips_county','invalid_future_date','invalid_geoprec','invalid_general_date','invalid_geo','invalid_geo_blk','invalid_geo_match','invalid_legal_name','invalid_lot','invalid_lot_order','invalid_mandatory','invalid_merctype','invalid_mrkt_telescore','invalid_mrkt_totalind','invalid_mrkt_totalscore','invalid_msa','invalid_naics','invalid_name','invalid_norm_type','invalid_numeric','invalid_numeric_or_blank','invalid_past_date','invalid_percentage','invalid_phone','invalid_process_date','invalid_public','invalid_raw_aid','invalid_rcid','invalid_rec_type','invalid_record_type','invalid_reformated_date','invalid_sic','invalid_st','invalid_statec','invalid_stkexc','invalid_url','invalid_vendor_reported_date','invalid_year_established','invalid_yes_blank','invalid_zero_integer','invalid_zip5','invalid_zip4');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_ace_aid' => 1,'invalid_address_type_code' => 2,'invalid_alpha' => 3,'invalid_business_size' => 4,'invalid_busstatcd' => 5,'invalid_cart' => 6,'invalid_cert_or_class' => 7,'invalid_chk_digit' => 8,'invalid_cmsa' => 9,'invalid_county' => 10,'invalid_corpamountcd' => 11,'invalid_corpamountprec' => 12,'invalid_corpamounttp' => 13,'invalid_corpempcd' => 14,'invalid_cr_sort_sz' => 15,'invalid_ctryisocd' => 16,'invalid_ctrynum' => 17,'invalid_ctrytelcd' => 18,'invalid_current_future_date' => 19,'invalid_current_past_date' => 20,'invalid_date_created' => 21,'invalid_date_seen' => 22,'invalid_dbpc' => 23,'invalid_email' => 24,'invalid_direction' => 25,'invalid_err_stat' => 26,'invalid_fips_state' => 27,'invalid_fips_county' => 28,'invalid_future_date' => 29,'invalid_geoprec' => 30,'invalid_general_date' => 31,'invalid_geo' => 32,'invalid_geo_blk' => 33,'invalid_geo_match' => 34,'invalid_legal_name' => 35,'invalid_lot' => 36,'invalid_lot_order' => 37,'invalid_mandatory' => 38,'invalid_merctype' => 39,'invalid_mrkt_telescore' => 40,'invalid_mrkt_totalind' => 41,'invalid_mrkt_totalscore' => 42,'invalid_msa' => 43,'invalid_naics' => 44,'invalid_name' => 45,'invalid_norm_type' => 46,'invalid_numeric' => 47,'invalid_numeric_or_blank' => 48,'invalid_past_date' => 49,'invalid_percentage' => 50,'invalid_phone' => 51,'invalid_process_date' => 52,'invalid_public' => 53,'invalid_raw_aid' => 54,'invalid_rcid' => 55,'invalid_rec_type' => 56,'invalid_record_type' => 57,'invalid_reformated_date' => 58,'invalid_sic' => 59,'invalid_st' => 60,'invalid_statec' => 61,'invalid_stkexc' => 62,'invalid_url' => 63,'invalid_vendor_reported_date' => 64,'invalid_year_established' => 65,'invalid_yes_blank' => 66,'invalid_zero_integer' => 67,'invalid_zip5' => 68,'invalid_zip4' => 69,0);
 
EXPORT MakeFT_invalid_ace_aid(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ace_aid(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,12)>0);
EXPORT InValidMessageFT_invalid_ace_aid(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_address_type_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['P','M']);
EXPORT InValidMessageFT_invalid_address_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('P|M'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_alpha(s,4)>0);
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_alpha'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_business_size(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_business_size(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['L','S','X']);
EXPORT InValidMessageFT_invalid_business_size(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('L|S|X'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_busstatcd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_busstatcd(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_busstatcd(s)>0);
EXPORT InValidMessageFT_invalid_busstatcd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_busstatcd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cart(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cart(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_alphanum(s,4)>0);
EXPORT InValidMessageFT_invalid_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_alphanum'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cert_or_class(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cert_or_class(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['CERTIFIED','CLASSIFIED','CLASSIFICATION','CERTIFICATION','SELF-CLASSIFIED/NON VERIFIED','OTHER CLASSIFICATIONS','UNKNOWN',' ']);
EXPORT InValidMessageFT_invalid_cert_or_class(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('CERTIFIED|CLASSIFIED|CLASSIFICATION|CERTIFICATION|SELF-CLASSIFIED/NON VERIFIED|OTHER CLASSIFICATIONS|UNKNOWN| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_chk_digit(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_chk_digit(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cmsa(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cmsa(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_cmsa(s)>0);
EXPORT InValidMessageFT_invalid_cmsa(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_cmsa'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_county(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_county(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,3)>0);
EXPORT InValidMessageFT_invalid_county(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corpamountcd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corpamountcd(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_corpamountcd(s)>0);
EXPORT InValidMessageFT_invalid_corpamountcd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_corpamountcd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corpamountprec(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corpamountprec(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_corpamountprec(s)>0);
EXPORT InValidMessageFT_invalid_corpamountprec(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_corpamountprec'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corpamounttp(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corpamounttp(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_corpamounttp(s)>0);
EXPORT InValidMessageFT_invalid_corpamounttp(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_corpamounttp'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corpempcd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corpempcd(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_corpempcd(s)>0);
EXPORT InValidMessageFT_invalid_corpempcd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_corpempcd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cr_sort_sz(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cr_sort_sz(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['A','B','C','D','']);
EXPORT InValidMessageFT_invalid_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('A|B|C|D|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ctryisocd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ctryisocd(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_ctryisocd(s)>0);
EXPORT InValidMessageFT_invalid_ctryisocd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_ctryisocd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ctrynum(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ctrynum(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_ctrynum(s)>0);
EXPORT InValidMessageFT_invalid_ctrynum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_ctrynum'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ctrytelcd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ctrytelcd(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_ctrytelcd(s)>0);
EXPORT InValidMessageFT_invalid_ctrytelcd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_ctrytelcd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_current_future_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_current_future_date(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_current_future_date(s)>0);
EXPORT InValidMessageFT_invalid_current_future_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_current_future_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_current_past_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_current_past_date(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_current_past_date(s)>0);
EXPORT InValidMessageFT_invalid_current_past_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_current_past_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date_created(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date_created(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_valid_date_created(s)>0);
EXPORT InValidMessageFT_invalid_date_created(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_valid_date_created'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date_seen(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date_seen(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_current_past_date(s)>0);
EXPORT InValidMessageFT_invalid_date_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_current_past_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dbpc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dbpc(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_dbpc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ\\\'-!#$%&*,./:;?@_{}~+=()^`><'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_email(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ\\\'-!#$%&*,./:;?@_{}~+=()^`><'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ\\\'-!#$%&*,./:;?@_{}~+=()^`><'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_direction(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_direction(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['E','N','S','W','NE','NW','SE','SW','']);
EXPORT InValidMessageFT_invalid_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('E|N|S|W|NE|NW|SE|SW|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_err_stat(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_err_stat(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_alphanum(s,4)>0);
EXPORT InValidMessageFT_invalid_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_alphanum'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_state(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_fips_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_county(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_county(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,3)>0);
EXPORT InValidMessageFT_invalid_fips_county(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_future_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_future_date(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_future_date(s)>0);
EXPORT InValidMessageFT_invalid_future_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_future_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geoprec(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geoprec(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_geoprec(s)>0);
EXPORT InValidMessageFT_invalid_geoprec(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_geoprec'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_general_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_general_date(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_valid_generalDate(s)>0);
EXPORT InValidMessageFT_invalid_general_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_valid_generalDate'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'-.0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_geo(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'-.0123456789'))));
EXPORT InValidMessageFT_invalid_geo(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('-.0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_blk(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo_blk(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,7)>0);
EXPORT InValidMessageFT_invalid_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_match(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo_match(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_legal_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_legal_name(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_invalid_legal_name(s)>0);
EXPORT InValidMessageFT_invalid_legal_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_invalid_legal_name'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot_order(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot_order(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['A','D','']);
EXPORT InValidMessageFT_invalid_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('A|D|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_merctype(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_merctype(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_merctype(s)>0);
EXPORT InValidMessageFT_invalid_merctype(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_merctype'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mrkt_telescore(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mrkt_telescore(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_mrkt_telescore(s)>0);
EXPORT InValidMessageFT_invalid_mrkt_telescore(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_mrkt_telescore'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mrkt_totalind(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mrkt_totalind(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_mrkt_totalind(s)>0);
EXPORT InValidMessageFT_invalid_mrkt_totalind(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_mrkt_totalind'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mrkt_totalscore(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mrkt_totalscore(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_mrkt_totalscore(s)>0);
EXPORT InValidMessageFT_invalid_mrkt_totalscore(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_mrkt_totalscore'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_msa(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_msa(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_naics(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_naics(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_NAICSCode(s)>0);
EXPORT InValidMessageFT_invalid_naics(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_NAICSCode'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_invalid_name(s)>0);
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_invalid_name'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_norm_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_norm_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['D','L']);
EXPORT InValidMessageFT_invalid_norm_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('D|L'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_or_blank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric_or_blank(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric_or_blank(s)>0);
EXPORT InValidMessageFT_invalid_numeric_or_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric_or_blank'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_past_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_past_date(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_valid_past_Date(s)>0);
EXPORT InValidMessageFT_invalid_past_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_valid_past_Date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_percentage(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_percentage(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_range_numeric(s,0,100)>0);
EXPORT InValidMessageFT_invalid_percentage(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_range_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_optional_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_process_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_process_date(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_current_past_date(s)>0);
EXPORT InValidMessageFT_invalid_process_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_current_past_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_public(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_public(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_public(s)>0);
EXPORT InValidMessageFT_invalid_public(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_public'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_raw_aid(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_raw_aid(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_range_numeric(s,10000000000,999999999999)>0);
EXPORT InValidMessageFT_invalid_raw_aid(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_range_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_rcid(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rcid(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_rcid(s)>0);
EXPORT InValidMessageFT_invalid_rcid(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_rcid'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_rec_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rec_type(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_addr_rec_type(s)>0);
EXPORT InValidMessageFT_invalid_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_addr_rec_type'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['C','H']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('C|H'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_reformated_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_reformated_date(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_valid_reformatedDate(s)>0);
EXPORT InValidMessageFT_invalid_reformated_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_valid_reformatedDate'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_SicCode(s)>0);
EXPORT InValidMessageFT_invalid_sic(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_SicCode'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_st(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_statec(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_statec(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_statec(s)>0);
EXPORT InValidMessageFT_invalid_statec(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_statec'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_stkexc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_stkexc(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_stkexc(s)>0);
EXPORT InValidMessageFT_invalid_stkexc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_stkexc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_url(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_url(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_url(s)>0);
EXPORT InValidMessageFT_invalid_url(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_url'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_vendor_reported_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_vendor_reported_date(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_current_past_date(s)>0);
EXPORT InValidMessageFT_invalid_vendor_reported_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_current_past_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_year_established(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_year_established(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_valid_year_established(s)>0);
EXPORT InValidMessageFT_invalid_year_established(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_valid_year_established'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_yes_blank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_yes_blank(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Y',' ']);
EXPORT InValidMessageFT_invalid_yes_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Y| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zero_integer(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zero_integer(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['0','']);
EXPORT InValidMessageFT_invalid_zero_integer(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('0|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_zip5(s)>0);
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_zip5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip4(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_numeric_or_blank(s,4)>0);
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_numeric_or_blank'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'AT_CERTEXP1','AT_CERTEXP2','AT_CERTEXP3','AT_CERTEXP4','AT_CERTEXP5','AT_CERTEXP6','AT_CERTEXP7','AT_CERTEXP8','AT_CERTEXP9','AT_CERTEXP10','AT_CERTLEV1','AT_CERTLEV2','AT_CERTLEV3','AT_CERTLEV4','AT_CERTLEV5','AT_CERTLEV6','AT_CERTLEV7','AT_CERTLEV8','AT_CERTLEV9','AT_CERTLEV10','EFX_8a','EFX_8aEXPDT','EFX_ADDRESS','EFX_ANC','EFX_BIZ','EFX_BUSSIZE','EFX_BUSSTATCD','EFX_CALTRANS','EFX_CA_PUC','EFX_CITY','EFX_CMRA','EFX_CMSA','EFX_CORPAMOUNT','EFX_CORPAMOUNTCD','EFX_CORPAMOUNTPREC','EFX_CORPAMOUNTTP','EFX_CORPEMPCD','EFX_CORPEMPCNT','EFX_COUNTYNM','EFX_COUNTY','EFX_CTRYISOCD','EFX_CTRYNAME','EFX_CTRYNUM','EFX_CTRYTELCD','EFX_DATE_CREATED','EFX_DBE','EFX_DEAD','EFX_DEADDT','EFX_DIS','EFX_DVET','EFX_DVSBE','EFX_EDU','EFX_EXTRACT_DATE','EFX_FAXPHONE','EFX_FGOV','EFX_FOREIGN','EFX_GAYLESBIAN','EFX_GEOPREC','EFX_GOV','EFX_GSAX','EFX_HBCU','EFX_HUBZONE','EFX_ID','EFX_LBE','EFX_LEGAL_NAME','EFX_LOCAMOUNT','EFX_LOCAMOUNTCD','EFX_LOCAMOUNTTP','EFX_LOCAMOUNTPREC','EFX_LOCEMPCNT','EFX_LOCEMPCD','EFX_MBE','EFX_MERCHANT_ID','EFX_MERCTYPE','EFX_MI','EFX_MRKT_SEASONAL','EFX_MRKT_TELESCORE','EFX_MRKT_TELEVER','EFX_MRKT_TOTALIND','EFX_MRKT_TOTALSCORE','EFX_MRKT_VACANT','EFX_MWBE','EFX_MWBESTATUS','EFX_NAME','EFX_NMSDC','EFX_NONPROFIT','EFX_PHONE','EFX_PRIMNAICSCODE','EFX_PRIMSIC','EFX_PROJECT_ID','EFX_PUBLIC','EFX_RES','EFX_SBE','EFX_SDB','EFX_SECCTRYISOCD','EFX_SECCTRYNUM','EFX_SECGEOPREC','EFX_SECNAICS1','EFX_SECNAICS2','EFX_SECNAICS3','EFX_SECNAICS4','EFX_SECSIC1','EFX_SECSIC2','EFX_SECSIC3','EFX_SECSIC4','EFX_STATEC','EFX_STKEXC','EFX_SOHO','EFX_TX_HUB','EFX_VET','EFX_VSBE','EFX_WBE','EFX_WBENC','EFX_WSBE','EFX_YREST','Record_Update_Refresh_Date');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'AT_CERTEXP1','AT_CERTEXP2','AT_CERTEXP3','AT_CERTEXP4','AT_CERTEXP5','AT_CERTEXP6','AT_CERTEXP7','AT_CERTEXP8','AT_CERTEXP9','AT_CERTEXP10','AT_CERTLEV1','AT_CERTLEV2','AT_CERTLEV3','AT_CERTLEV4','AT_CERTLEV5','AT_CERTLEV6','AT_CERTLEV7','AT_CERTLEV8','AT_CERTLEV9','AT_CERTLEV10','EFX_8a','EFX_8aEXPDT','EFX_ADDRESS','EFX_ANC','EFX_BIZ','EFX_BUSSIZE','EFX_BUSSTATCD','EFX_CALTRANS','EFX_CA_PUC','EFX_CITY','EFX_CMRA','EFX_CMSA','EFX_CORPAMOUNT','EFX_CORPAMOUNTCD','EFX_CORPAMOUNTPREC','EFX_CORPAMOUNTTP','EFX_CORPEMPCD','EFX_CORPEMPCNT','EFX_COUNTYNM','EFX_COUNTY','EFX_CTRYISOCD','EFX_CTRYNAME','EFX_CTRYNUM','EFX_CTRYTELCD','EFX_DATE_CREATED','EFX_DBE','EFX_DEAD','EFX_DEADDT','EFX_DIS','EFX_DVET','EFX_DVSBE','EFX_EDU','EFX_EXTRACT_DATE','EFX_FAXPHONE','EFX_FGOV','EFX_FOREIGN','EFX_GAYLESBIAN','EFX_GEOPREC','EFX_GOV','EFX_GSAX','EFX_HBCU','EFX_HUBZONE','EFX_ID','EFX_LBE','EFX_LEGAL_NAME','EFX_LOCAMOUNT','EFX_LOCAMOUNTCD','EFX_LOCAMOUNTTP','EFX_LOCAMOUNTPREC','EFX_LOCEMPCNT','EFX_LOCEMPCD','EFX_MBE','EFX_MERCHANT_ID','EFX_MERCTYPE','EFX_MI','EFX_MRKT_SEASONAL','EFX_MRKT_TELESCORE','EFX_MRKT_TELEVER','EFX_MRKT_TOTALIND','EFX_MRKT_TOTALSCORE','EFX_MRKT_VACANT','EFX_MWBE','EFX_MWBESTATUS','EFX_NAME','EFX_NMSDC','EFX_NONPROFIT','EFX_PHONE','EFX_PRIMNAICSCODE','EFX_PRIMSIC','EFX_PROJECT_ID','EFX_PUBLIC','EFX_RES','EFX_SBE','EFX_SDB','EFX_SECCTRYISOCD','EFX_SECCTRYNUM','EFX_SECGEOPREC','EFX_SECNAICS1','EFX_SECNAICS2','EFX_SECNAICS3','EFX_SECNAICS4','EFX_SECSIC1','EFX_SECSIC2','EFX_SECSIC3','EFX_SECSIC4','EFX_STATEC','EFX_STKEXC','EFX_SOHO','EFX_TX_HUB','EFX_VET','EFX_VSBE','EFX_WBE','EFX_WBENC','EFX_WSBE','EFX_YREST','Record_Update_Refresh_Date');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'AT_CERTEXP1' => 0,'AT_CERTEXP2' => 1,'AT_CERTEXP3' => 2,'AT_CERTEXP4' => 3,'AT_CERTEXP5' => 4,'AT_CERTEXP6' => 5,'AT_CERTEXP7' => 6,'AT_CERTEXP8' => 7,'AT_CERTEXP9' => 8,'AT_CERTEXP10' => 9,'AT_CERTLEV1' => 10,'AT_CERTLEV2' => 11,'AT_CERTLEV3' => 12,'AT_CERTLEV4' => 13,'AT_CERTLEV5' => 14,'AT_CERTLEV6' => 15,'AT_CERTLEV7' => 16,'AT_CERTLEV8' => 17,'AT_CERTLEV9' => 18,'AT_CERTLEV10' => 19,'EFX_8a' => 20,'EFX_8aEXPDT' => 21,'EFX_ADDRESS' => 22,'EFX_ANC' => 23,'EFX_BIZ' => 24,'EFX_BUSSIZE' => 25,'EFX_BUSSTATCD' => 26,'EFX_CALTRANS' => 27,'EFX_CA_PUC' => 28,'EFX_CITY' => 29,'EFX_CMRA' => 30,'EFX_CMSA' => 31,'EFX_CORPAMOUNT' => 32,'EFX_CORPAMOUNTCD' => 33,'EFX_CORPAMOUNTPREC' => 34,'EFX_CORPAMOUNTTP' => 35,'EFX_CORPEMPCD' => 36,'EFX_CORPEMPCNT' => 37,'EFX_COUNTYNM' => 38,'EFX_COUNTY' => 39,'EFX_CTRYISOCD' => 40,'EFX_CTRYNAME' => 41,'EFX_CTRYNUM' => 42,'EFX_CTRYTELCD' => 43,'EFX_DATE_CREATED' => 44,'EFX_DBE' => 45,'EFX_DEAD' => 46,'EFX_DEADDT' => 47,'EFX_DIS' => 48,'EFX_DVET' => 49,'EFX_DVSBE' => 50,'EFX_EDU' => 51,'EFX_EXTRACT_DATE' => 52,'EFX_FAXPHONE' => 53,'EFX_FGOV' => 54,'EFX_FOREIGN' => 55,'EFX_GAYLESBIAN' => 56,'EFX_GEOPREC' => 57,'EFX_GOV' => 58,'EFX_GSAX' => 59,'EFX_HBCU' => 60,'EFX_HUBZONE' => 61,'EFX_ID' => 62,'EFX_LBE' => 63,'EFX_LEGAL_NAME' => 64,'EFX_LOCAMOUNT' => 65,'EFX_LOCAMOUNTCD' => 66,'EFX_LOCAMOUNTTP' => 67,'EFX_LOCAMOUNTPREC' => 68,'EFX_LOCEMPCNT' => 69,'EFX_LOCEMPCD' => 70,'EFX_MBE' => 71,'EFX_MERCHANT_ID' => 72,'EFX_MERCTYPE' => 73,'EFX_MI' => 74,'EFX_MRKT_SEASONAL' => 75,'EFX_MRKT_TELESCORE' => 76,'EFX_MRKT_TELEVER' => 77,'EFX_MRKT_TOTALIND' => 78,'EFX_MRKT_TOTALSCORE' => 79,'EFX_MRKT_VACANT' => 80,'EFX_MWBE' => 81,'EFX_MWBESTATUS' => 82,'EFX_NAME' => 83,'EFX_NMSDC' => 84,'EFX_NONPROFIT' => 85,'EFX_PHONE' => 86,'EFX_PRIMNAICSCODE' => 87,'EFX_PRIMSIC' => 88,'EFX_PROJECT_ID' => 89,'EFX_PUBLIC' => 90,'EFX_RES' => 91,'EFX_SBE' => 92,'EFX_SDB' => 93,'EFX_SECCTRYISOCD' => 94,'EFX_SECCTRYNUM' => 95,'EFX_SECGEOPREC' => 96,'EFX_SECNAICS1' => 97,'EFX_SECNAICS2' => 98,'EFX_SECNAICS3' => 99,'EFX_SECNAICS4' => 100,'EFX_SECSIC1' => 101,'EFX_SECSIC2' => 102,'EFX_SECSIC3' => 103,'EFX_SECSIC4' => 104,'EFX_STATEC' => 105,'EFX_STKEXC' => 106,'EFX_SOHO' => 107,'EFX_TX_HUB' => 108,'EFX_VET' => 109,'EFX_VSBE' => 110,'EFX_WBE' => 111,'EFX_WBENC' => 112,'EFX_WSBE' => 113,'EFX_YREST' => 114,'Record_Update_Refresh_Date' => 115,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['LENGTHS'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['ENUM'],['ENUM'],['LENGTHS'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_AT_CERTEXP1(SALT311.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP1(SALT311.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP1(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP2(SALT311.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP2(SALT311.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP2(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP3(SALT311.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP3(SALT311.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP3(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP4(SALT311.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP4(SALT311.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP4(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP5(SALT311.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP5(SALT311.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP5(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP6(SALT311.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP6(SALT311.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP6(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP7(SALT311.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP7(SALT311.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP7(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP8(SALT311.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP8(SALT311.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP8(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP9(SALT311.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP9(SALT311.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP9(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTEXP10(SALT311.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_AT_CERTEXP10(SALT311.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_AT_CERTEXP10(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_AT_CERTLEV1(SALT311.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV1(SALT311.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV1(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV2(SALT311.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV2(SALT311.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV2(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV3(SALT311.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV3(SALT311.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV3(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV4(SALT311.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV4(SALT311.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV4(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV5(SALT311.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV5(SALT311.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV5(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV6(SALT311.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV6(SALT311.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV6(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV7(SALT311.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV7(SALT311.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV7(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV8(SALT311.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV8(SALT311.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV8(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV9(SALT311.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV9(SALT311.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV9(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_AT_CERTLEV10(SALT311.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_AT_CERTLEV10(SALT311.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_AT_CERTLEV10(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_EFX_8a(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_8a(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_8a(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_8aEXPDT(SALT311.StrType s0) := MakeFT_invalid_general_date(s0);
EXPORT InValid_EFX_8aEXPDT(SALT311.StrType s) := InValidFT_invalid_general_date(s);
EXPORT InValidMessage_EFX_8aEXPDT(UNSIGNED1 wh) := InValidMessageFT_invalid_general_date(wh);
 
EXPORT Make_EFX_ADDRESS(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_EFX_ADDRESS(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_EFX_ADDRESS(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_EFX_ANC(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_ANC(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_ANC(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_BIZ(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_BIZ(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_BIZ(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_BUSSIZE(SALT311.StrType s0) := MakeFT_invalid_business_size(s0);
EXPORT InValid_EFX_BUSSIZE(SALT311.StrType s) := InValidFT_invalid_business_size(s);
EXPORT InValidMessage_EFX_BUSSIZE(UNSIGNED1 wh) := InValidMessageFT_invalid_business_size(wh);
 
EXPORT Make_EFX_BUSSTATCD(SALT311.StrType s0) := MakeFT_invalid_busstatcd(s0);
EXPORT InValid_EFX_BUSSTATCD(SALT311.StrType s) := InValidFT_invalid_busstatcd(s);
EXPORT InValidMessage_EFX_BUSSTATCD(UNSIGNED1 wh) := InValidMessageFT_invalid_busstatcd(wh);
 
EXPORT Make_EFX_CALTRANS(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_CALTRANS(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_CALTRANS(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_CA_PUC(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_CA_PUC(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_CA_PUC(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_CITY(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_EFX_CITY(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_EFX_CITY(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_EFX_CMRA(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_CMRA(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_CMRA(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_CMSA(SALT311.StrType s0) := MakeFT_invalid_cmsa(s0);
EXPORT InValid_EFX_CMSA(SALT311.StrType s) := InValidFT_invalid_cmsa(s);
EXPORT InValidMessage_EFX_CMSA(UNSIGNED1 wh) := InValidMessageFT_invalid_cmsa(wh);
 
EXPORT Make_EFX_CORPAMOUNT(SALT311.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_EFX_CORPAMOUNT(SALT311.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_EFX_CORPAMOUNT(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_EFX_CORPAMOUNTCD(SALT311.StrType s0) := MakeFT_invalid_corpamountcd(s0);
EXPORT InValid_EFX_CORPAMOUNTCD(SALT311.StrType s) := InValidFT_invalid_corpamountcd(s);
EXPORT InValidMessage_EFX_CORPAMOUNTCD(UNSIGNED1 wh) := InValidMessageFT_invalid_corpamountcd(wh);
 
EXPORT Make_EFX_CORPAMOUNTPREC(SALT311.StrType s0) := MakeFT_invalid_corpamountprec(s0);
EXPORT InValid_EFX_CORPAMOUNTPREC(SALT311.StrType s) := InValidFT_invalid_corpamountprec(s);
EXPORT InValidMessage_EFX_CORPAMOUNTPREC(UNSIGNED1 wh) := InValidMessageFT_invalid_corpamountprec(wh);
 
EXPORT Make_EFX_CORPAMOUNTTP(SALT311.StrType s0) := MakeFT_invalid_corpamounttp(s0);
EXPORT InValid_EFX_CORPAMOUNTTP(SALT311.StrType s) := InValidFT_invalid_corpamounttp(s);
EXPORT InValidMessage_EFX_CORPAMOUNTTP(UNSIGNED1 wh) := InValidMessageFT_invalid_corpamounttp(wh);
 
EXPORT Make_EFX_CORPEMPCD(SALT311.StrType s0) := MakeFT_invalid_corpempcd(s0);
EXPORT InValid_EFX_CORPEMPCD(SALT311.StrType s) := InValidFT_invalid_corpempcd(s);
EXPORT InValidMessage_EFX_CORPEMPCD(UNSIGNED1 wh) := InValidMessageFT_invalid_corpempcd(wh);
 
EXPORT Make_EFX_CORPEMPCNT(SALT311.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_EFX_CORPEMPCNT(SALT311.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_EFX_CORPEMPCNT(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_EFX_COUNTYNM(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_EFX_COUNTYNM(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_EFX_COUNTYNM(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_EFX_COUNTY(SALT311.StrType s0) := MakeFT_invalid_county(s0);
EXPORT InValid_EFX_COUNTY(SALT311.StrType s) := InValidFT_invalid_county(s);
EXPORT InValidMessage_EFX_COUNTY(UNSIGNED1 wh) := InValidMessageFT_invalid_county(wh);
 
EXPORT Make_EFX_CTRYISOCD(SALT311.StrType s0) := MakeFT_invalid_ctryisocd(s0);
EXPORT InValid_EFX_CTRYISOCD(SALT311.StrType s) := InValidFT_invalid_ctryisocd(s);
EXPORT InValidMessage_EFX_CTRYISOCD(UNSIGNED1 wh) := InValidMessageFT_invalid_ctryisocd(wh);
 
EXPORT Make_EFX_CTRYNAME(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_EFX_CTRYNAME(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_EFX_CTRYNAME(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_EFX_CTRYNUM(SALT311.StrType s0) := MakeFT_invalid_ctrynum(s0);
EXPORT InValid_EFX_CTRYNUM(SALT311.StrType s) := InValidFT_invalid_ctrynum(s);
EXPORT InValidMessage_EFX_CTRYNUM(UNSIGNED1 wh) := InValidMessageFT_invalid_ctrynum(wh);
 
EXPORT Make_EFX_CTRYTELCD(SALT311.StrType s0) := MakeFT_invalid_ctrytelcd(s0);
EXPORT InValid_EFX_CTRYTELCD(SALT311.StrType s) := InValidFT_invalid_ctrytelcd(s);
EXPORT InValidMessage_EFX_CTRYTELCD(UNSIGNED1 wh) := InValidMessageFT_invalid_ctrytelcd(wh);
 
EXPORT Make_EFX_DATE_CREATED(SALT311.StrType s0) := MakeFT_invalid_date_created(s0);
EXPORT InValid_EFX_DATE_CREATED(SALT311.StrType s) := InValidFT_invalid_date_created(s);
EXPORT InValidMessage_EFX_DATE_CREATED(UNSIGNED1 wh) := InValidMessageFT_invalid_date_created(wh);
 
EXPORT Make_EFX_DBE(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_DBE(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_DBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_DEAD(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_DEAD(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_DEAD(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_DEADDT(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_EFX_DEADDT(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_EFX_DEADDT(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_EFX_DIS(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_DIS(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_DIS(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_DVET(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_DVET(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_DVET(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_DVSBE(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_DVSBE(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_DVSBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_EDU(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_EDU(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_EDU(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_EXTRACT_DATE(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_EFX_EXTRACT_DATE(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_EFX_EXTRACT_DATE(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_EFX_FAXPHONE(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_EFX_FAXPHONE(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_EFX_FAXPHONE(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_EFX_FGOV(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_FGOV(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_FGOV(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_FOREIGN(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_FOREIGN(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_FOREIGN(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_GAYLESBIAN(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_GAYLESBIAN(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_GAYLESBIAN(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_GEOPREC(SALT311.StrType s0) := MakeFT_invalid_geoprec(s0);
EXPORT InValid_EFX_GEOPREC(SALT311.StrType s) := InValidFT_invalid_geoprec(s);
EXPORT InValidMessage_EFX_GEOPREC(UNSIGNED1 wh) := InValidMessageFT_invalid_geoprec(wh);
 
EXPORT Make_EFX_GOV(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_GOV(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_GOV(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_GSAX(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_GSAX(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_GSAX(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_HBCU(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_HBCU(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_HBCU(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_HUBZONE(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_HUBZONE(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_HUBZONE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_ID(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_EFX_ID(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_EFX_ID(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_EFX_LBE(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_LBE(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_LBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_LEGAL_NAME(SALT311.StrType s0) := MakeFT_invalid_legal_name(s0);
EXPORT InValid_EFX_LEGAL_NAME(SALT311.StrType s) := InValidFT_invalid_legal_name(s);
EXPORT InValidMessage_EFX_LEGAL_NAME(UNSIGNED1 wh) := InValidMessageFT_invalid_legal_name(wh);
 
EXPORT Make_EFX_LOCAMOUNT(SALT311.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_EFX_LOCAMOUNT(SALT311.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_EFX_LOCAMOUNT(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_EFX_LOCAMOUNTCD(SALT311.StrType s0) := MakeFT_invalid_corpamountcd(s0);
EXPORT InValid_EFX_LOCAMOUNTCD(SALT311.StrType s) := InValidFT_invalid_corpamountcd(s);
EXPORT InValidMessage_EFX_LOCAMOUNTCD(UNSIGNED1 wh) := InValidMessageFT_invalid_corpamountcd(wh);
 
EXPORT Make_EFX_LOCAMOUNTTP(SALT311.StrType s0) := MakeFT_invalid_corpamounttp(s0);
EXPORT InValid_EFX_LOCAMOUNTTP(SALT311.StrType s) := InValidFT_invalid_corpamounttp(s);
EXPORT InValidMessage_EFX_LOCAMOUNTTP(UNSIGNED1 wh) := InValidMessageFT_invalid_corpamounttp(wh);
 
EXPORT Make_EFX_LOCAMOUNTPREC(SALT311.StrType s0) := MakeFT_invalid_corpamountprec(s0);
EXPORT InValid_EFX_LOCAMOUNTPREC(SALT311.StrType s) := InValidFT_invalid_corpamountprec(s);
EXPORT InValidMessage_EFX_LOCAMOUNTPREC(UNSIGNED1 wh) := InValidMessageFT_invalid_corpamountprec(wh);
 
EXPORT Make_EFX_LOCEMPCNT(SALT311.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_EFX_LOCEMPCNT(SALT311.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_EFX_LOCEMPCNT(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_EFX_LOCEMPCD(SALT311.StrType s0) := MakeFT_invalid_corpempcd(s0);
EXPORT InValid_EFX_LOCEMPCD(SALT311.StrType s) := InValidFT_invalid_corpempcd(s);
EXPORT InValidMessage_EFX_LOCEMPCD(UNSIGNED1 wh) := InValidMessageFT_invalid_corpempcd(wh);
 
EXPORT Make_EFX_MBE(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_MBE(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_MBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_MERCHANT_ID(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_EFX_MERCHANT_ID(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_EFX_MERCHANT_ID(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_EFX_MERCTYPE(SALT311.StrType s0) := MakeFT_invalid_merctype(s0);
EXPORT InValid_EFX_MERCTYPE(SALT311.StrType s) := InValidFT_invalid_merctype(s);
EXPORT InValidMessage_EFX_MERCTYPE(UNSIGNED1 wh) := InValidMessageFT_invalid_merctype(wh);
 
EXPORT Make_EFX_MI(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_MI(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_MI(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_MRKT_SEASONAL(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_MRKT_SEASONAL(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_MRKT_SEASONAL(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_MRKT_TELESCORE(SALT311.StrType s0) := MakeFT_invalid_mrkt_telescore(s0);
EXPORT InValid_EFX_MRKT_TELESCORE(SALT311.StrType s) := InValidFT_invalid_mrkt_telescore(s);
EXPORT InValidMessage_EFX_MRKT_TELESCORE(UNSIGNED1 wh) := InValidMessageFT_invalid_mrkt_telescore(wh);
 
EXPORT Make_EFX_MRKT_TELEVER(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_MRKT_TELEVER(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_MRKT_TELEVER(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_MRKT_TOTALIND(SALT311.StrType s0) := MakeFT_invalid_mrkt_totalind(s0);
EXPORT InValid_EFX_MRKT_TOTALIND(SALT311.StrType s) := InValidFT_invalid_mrkt_totalind(s);
EXPORT InValidMessage_EFX_MRKT_TOTALIND(UNSIGNED1 wh) := InValidMessageFT_invalid_mrkt_totalind(wh);
 
EXPORT Make_EFX_MRKT_TOTALSCORE(SALT311.StrType s0) := MakeFT_invalid_mrkt_totalscore(s0);
EXPORT InValid_EFX_MRKT_TOTALSCORE(SALT311.StrType s) := InValidFT_invalid_mrkt_totalscore(s);
EXPORT InValidMessage_EFX_MRKT_TOTALSCORE(UNSIGNED1 wh) := InValidMessageFT_invalid_mrkt_totalscore(wh);
 
EXPORT Make_EFX_MRKT_VACANT(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_MRKT_VACANT(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_MRKT_VACANT(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_MWBE(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_MWBE(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_MWBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_MWBESTATUS(SALT311.StrType s0) := MakeFT_invalid_cert_or_class(s0);
EXPORT InValid_EFX_MWBESTATUS(SALT311.StrType s) := InValidFT_invalid_cert_or_class(s);
EXPORT InValidMessage_EFX_MWBESTATUS(UNSIGNED1 wh) := InValidMessageFT_invalid_cert_or_class(wh);
 
EXPORT Make_EFX_NAME(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_EFX_NAME(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_EFX_NAME(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_EFX_NMSDC(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_NMSDC(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_NMSDC(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_NONPROFIT(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_NONPROFIT(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_NONPROFIT(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_PHONE(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_EFX_PHONE(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_EFX_PHONE(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_EFX_PRIMNAICSCODE(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_EFX_PRIMNAICSCODE(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_EFX_PRIMNAICSCODE(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_EFX_PRIMSIC(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_EFX_PRIMSIC(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_EFX_PRIMSIC(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_EFX_PROJECT_ID(SALT311.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_EFX_PROJECT_ID(SALT311.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_EFX_PROJECT_ID(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_EFX_PUBLIC(SALT311.StrType s0) := MakeFT_invalid_public(s0);
EXPORT InValid_EFX_PUBLIC(SALT311.StrType s) := InValidFT_invalid_public(s);
EXPORT InValidMessage_EFX_PUBLIC(UNSIGNED1 wh) := InValidMessageFT_invalid_public(wh);
 
EXPORT Make_EFX_RES(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_RES(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_RES(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_SBE(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_SBE(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_SBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_SDB(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_SDB(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_SDB(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_SECCTRYISOCD(SALT311.StrType s0) := MakeFT_invalid_ctryisocd(s0);
EXPORT InValid_EFX_SECCTRYISOCD(SALT311.StrType s) := InValidFT_invalid_ctryisocd(s);
EXPORT InValidMessage_EFX_SECCTRYISOCD(UNSIGNED1 wh) := InValidMessageFT_invalid_ctryisocd(wh);
 
EXPORT Make_EFX_SECCTRYNUM(SALT311.StrType s0) := MakeFT_invalid_ctrynum(s0);
EXPORT InValid_EFX_SECCTRYNUM(SALT311.StrType s) := InValidFT_invalid_ctrynum(s);
EXPORT InValidMessage_EFX_SECCTRYNUM(UNSIGNED1 wh) := InValidMessageFT_invalid_ctrynum(wh);
 
EXPORT Make_EFX_SECGEOPREC(SALT311.StrType s0) := MakeFT_invalid_geoprec(s0);
EXPORT InValid_EFX_SECGEOPREC(SALT311.StrType s) := InValidFT_invalid_geoprec(s);
EXPORT InValidMessage_EFX_SECGEOPREC(UNSIGNED1 wh) := InValidMessageFT_invalid_geoprec(wh);
 
EXPORT Make_EFX_SECNAICS1(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_EFX_SECNAICS1(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_EFX_SECNAICS1(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_EFX_SECNAICS2(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_EFX_SECNAICS2(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_EFX_SECNAICS2(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_EFX_SECNAICS3(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_EFX_SECNAICS3(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_EFX_SECNAICS3(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_EFX_SECNAICS4(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_EFX_SECNAICS4(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_EFX_SECNAICS4(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_EFX_SECSIC1(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_EFX_SECSIC1(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_EFX_SECSIC1(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_EFX_SECSIC2(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_EFX_SECSIC2(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_EFX_SECSIC2(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_EFX_SECSIC3(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_EFX_SECSIC3(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_EFX_SECSIC3(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_EFX_SECSIC4(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_EFX_SECSIC4(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_EFX_SECSIC4(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_EFX_STATEC(SALT311.StrType s0) := MakeFT_invalid_statec(s0);
EXPORT InValid_EFX_STATEC(SALT311.StrType s) := InValidFT_invalid_statec(s);
EXPORT InValidMessage_EFX_STATEC(UNSIGNED1 wh) := InValidMessageFT_invalid_statec(wh);
 
EXPORT Make_EFX_STKEXC(SALT311.StrType s0) := MakeFT_invalid_stkexc(s0);
EXPORT InValid_EFX_STKEXC(SALT311.StrType s) := InValidFT_invalid_stkexc(s);
EXPORT InValidMessage_EFX_STKEXC(UNSIGNED1 wh) := InValidMessageFT_invalid_stkexc(wh);
 
EXPORT Make_EFX_SOHO(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_SOHO(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_SOHO(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_TX_HUB(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_TX_HUB(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_TX_HUB(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_VET(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_VET(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_VET(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_VSBE(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_VSBE(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_VSBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_WBE(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_WBE(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_WBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_WBENC(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_WBENC(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_WBENC(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_WSBE(SALT311.StrType s0) := MakeFT_invalid_yes_blank(s0);
EXPORT InValid_EFX_WSBE(SALT311.StrType s) := InValidFT_invalid_yes_blank(s);
EXPORT InValidMessage_EFX_WSBE(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_blank(wh);
 
EXPORT Make_EFX_YREST(SALT311.StrType s0) := MakeFT_invalid_year_established(s0);
EXPORT InValid_EFX_YREST(SALT311.StrType s) := InValidFT_invalid_year_established(s);
EXPORT InValidMessage_EFX_YREST(UNSIGNED1 wh) := InValidMessageFT_invalid_year_established(wh);
 
EXPORT Make_Record_Update_Refresh_Date(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_Record_Update_Refresh_Date(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_Record_Update_Refresh_Date(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Equifax_Business_Data;
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
    BOOLEAN Diff_EFX_8a;
    BOOLEAN Diff_EFX_8aEXPDT;
    BOOLEAN Diff_EFX_ADDRESS;
    BOOLEAN Diff_EFX_ANC;
    BOOLEAN Diff_EFX_BIZ;
    BOOLEAN Diff_EFX_BUSSIZE;
    BOOLEAN Diff_EFX_BUSSTATCD;
    BOOLEAN Diff_EFX_CALTRANS;
    BOOLEAN Diff_EFX_CA_PUC;
    BOOLEAN Diff_EFX_CITY;
    BOOLEAN Diff_EFX_CMRA;
    BOOLEAN Diff_EFX_CMSA;
    BOOLEAN Diff_EFX_CORPAMOUNT;
    BOOLEAN Diff_EFX_CORPAMOUNTCD;
    BOOLEAN Diff_EFX_CORPAMOUNTPREC;
    BOOLEAN Diff_EFX_CORPAMOUNTTP;
    BOOLEAN Diff_EFX_CORPEMPCD;
    BOOLEAN Diff_EFX_CORPEMPCNT;
    BOOLEAN Diff_EFX_COUNTYNM;
    BOOLEAN Diff_EFX_COUNTY;
    BOOLEAN Diff_EFX_CTRYISOCD;
    BOOLEAN Diff_EFX_CTRYNAME;
    BOOLEAN Diff_EFX_CTRYNUM;
    BOOLEAN Diff_EFX_CTRYTELCD;
    BOOLEAN Diff_EFX_DATE_CREATED;
    BOOLEAN Diff_EFX_DBE;
    BOOLEAN Diff_EFX_DEAD;
    BOOLEAN Diff_EFX_DEADDT;
    BOOLEAN Diff_EFX_DIS;
    BOOLEAN Diff_EFX_DVET;
    BOOLEAN Diff_EFX_DVSBE;
    BOOLEAN Diff_EFX_EDU;
    BOOLEAN Diff_EFX_EXTRACT_DATE;
    BOOLEAN Diff_EFX_FAXPHONE;
    BOOLEAN Diff_EFX_FGOV;
    BOOLEAN Diff_EFX_FOREIGN;
    BOOLEAN Diff_EFX_GAYLESBIAN;
    BOOLEAN Diff_EFX_GEOPREC;
    BOOLEAN Diff_EFX_GOV;
    BOOLEAN Diff_EFX_GSAX;
    BOOLEAN Diff_EFX_HBCU;
    BOOLEAN Diff_EFX_HUBZONE;
    BOOLEAN Diff_EFX_ID;
    BOOLEAN Diff_EFX_LBE;
    BOOLEAN Diff_EFX_LEGAL_NAME;
    BOOLEAN Diff_EFX_LOCAMOUNT;
    BOOLEAN Diff_EFX_LOCAMOUNTCD;
    BOOLEAN Diff_EFX_LOCAMOUNTTP;
    BOOLEAN Diff_EFX_LOCAMOUNTPREC;
    BOOLEAN Diff_EFX_LOCEMPCNT;
    BOOLEAN Diff_EFX_LOCEMPCD;
    BOOLEAN Diff_EFX_MBE;
    BOOLEAN Diff_EFX_MERCHANT_ID;
    BOOLEAN Diff_EFX_MERCTYPE;
    BOOLEAN Diff_EFX_MI;
    BOOLEAN Diff_EFX_MRKT_SEASONAL;
    BOOLEAN Diff_EFX_MRKT_TELESCORE;
    BOOLEAN Diff_EFX_MRKT_TELEVER;
    BOOLEAN Diff_EFX_MRKT_TOTALIND;
    BOOLEAN Diff_EFX_MRKT_TOTALSCORE;
    BOOLEAN Diff_EFX_MRKT_VACANT;
    BOOLEAN Diff_EFX_MWBE;
    BOOLEAN Diff_EFX_MWBESTATUS;
    BOOLEAN Diff_EFX_NAME;
    BOOLEAN Diff_EFX_NMSDC;
    BOOLEAN Diff_EFX_NONPROFIT;
    BOOLEAN Diff_EFX_PHONE;
    BOOLEAN Diff_EFX_PRIMNAICSCODE;
    BOOLEAN Diff_EFX_PRIMSIC;
    BOOLEAN Diff_EFX_PROJECT_ID;
    BOOLEAN Diff_EFX_PUBLIC;
    BOOLEAN Diff_EFX_RES;
    BOOLEAN Diff_EFX_SBE;
    BOOLEAN Diff_EFX_SDB;
    BOOLEAN Diff_EFX_SECCTRYISOCD;
    BOOLEAN Diff_EFX_SECCTRYNUM;
    BOOLEAN Diff_EFX_SECGEOPREC;
    BOOLEAN Diff_EFX_SECNAICS1;
    BOOLEAN Diff_EFX_SECNAICS2;
    BOOLEAN Diff_EFX_SECNAICS3;
    BOOLEAN Diff_EFX_SECNAICS4;
    BOOLEAN Diff_EFX_SECSIC1;
    BOOLEAN Diff_EFX_SECSIC2;
    BOOLEAN Diff_EFX_SECSIC3;
    BOOLEAN Diff_EFX_SECSIC4;
    BOOLEAN Diff_EFX_STATEC;
    BOOLEAN Diff_EFX_STKEXC;
    BOOLEAN Diff_EFX_SOHO;
    BOOLEAN Diff_EFX_TX_HUB;
    BOOLEAN Diff_EFX_VET;
    BOOLEAN Diff_EFX_VSBE;
    BOOLEAN Diff_EFX_WBE;
    BOOLEAN Diff_EFX_WBENC;
    BOOLEAN Diff_EFX_WSBE;
    BOOLEAN Diff_EFX_YREST;
    BOOLEAN Diff_Record_Update_Refresh_Date;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
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
    SELF.Diff_EFX_8a := le.EFX_8a <> ri.EFX_8a;
    SELF.Diff_EFX_8aEXPDT := le.EFX_8aEXPDT <> ri.EFX_8aEXPDT;
    SELF.Diff_EFX_ADDRESS := le.EFX_ADDRESS <> ri.EFX_ADDRESS;
    SELF.Diff_EFX_ANC := le.EFX_ANC <> ri.EFX_ANC;
    SELF.Diff_EFX_BIZ := le.EFX_BIZ <> ri.EFX_BIZ;
    SELF.Diff_EFX_BUSSIZE := le.EFX_BUSSIZE <> ri.EFX_BUSSIZE;
    SELF.Diff_EFX_BUSSTATCD := le.EFX_BUSSTATCD <> ri.EFX_BUSSTATCD;
    SELF.Diff_EFX_CALTRANS := le.EFX_CALTRANS <> ri.EFX_CALTRANS;
    SELF.Diff_EFX_CA_PUC := le.EFX_CA_PUC <> ri.EFX_CA_PUC;
    SELF.Diff_EFX_CITY := le.EFX_CITY <> ri.EFX_CITY;
    SELF.Diff_EFX_CMRA := le.EFX_CMRA <> ri.EFX_CMRA;
    SELF.Diff_EFX_CMSA := le.EFX_CMSA <> ri.EFX_CMSA;
    SELF.Diff_EFX_CORPAMOUNT := le.EFX_CORPAMOUNT <> ri.EFX_CORPAMOUNT;
    SELF.Diff_EFX_CORPAMOUNTCD := le.EFX_CORPAMOUNTCD <> ri.EFX_CORPAMOUNTCD;
    SELF.Diff_EFX_CORPAMOUNTPREC := le.EFX_CORPAMOUNTPREC <> ri.EFX_CORPAMOUNTPREC;
    SELF.Diff_EFX_CORPAMOUNTTP := le.EFX_CORPAMOUNTTP <> ri.EFX_CORPAMOUNTTP;
    SELF.Diff_EFX_CORPEMPCD := le.EFX_CORPEMPCD <> ri.EFX_CORPEMPCD;
    SELF.Diff_EFX_CORPEMPCNT := le.EFX_CORPEMPCNT <> ri.EFX_CORPEMPCNT;
    SELF.Diff_EFX_COUNTYNM := le.EFX_COUNTYNM <> ri.EFX_COUNTYNM;
    SELF.Diff_EFX_COUNTY := le.EFX_COUNTY <> ri.EFX_COUNTY;
    SELF.Diff_EFX_CTRYISOCD := le.EFX_CTRYISOCD <> ri.EFX_CTRYISOCD;
    SELF.Diff_EFX_CTRYNAME := le.EFX_CTRYNAME <> ri.EFX_CTRYNAME;
    SELF.Diff_EFX_CTRYNUM := le.EFX_CTRYNUM <> ri.EFX_CTRYNUM;
    SELF.Diff_EFX_CTRYTELCD := le.EFX_CTRYTELCD <> ri.EFX_CTRYTELCD;
    SELF.Diff_EFX_DATE_CREATED := le.EFX_DATE_CREATED <> ri.EFX_DATE_CREATED;
    SELF.Diff_EFX_DBE := le.EFX_DBE <> ri.EFX_DBE;
    SELF.Diff_EFX_DEAD := le.EFX_DEAD <> ri.EFX_DEAD;
    SELF.Diff_EFX_DEADDT := le.EFX_DEADDT <> ri.EFX_DEADDT;
    SELF.Diff_EFX_DIS := le.EFX_DIS <> ri.EFX_DIS;
    SELF.Diff_EFX_DVET := le.EFX_DVET <> ri.EFX_DVET;
    SELF.Diff_EFX_DVSBE := le.EFX_DVSBE <> ri.EFX_DVSBE;
    SELF.Diff_EFX_EDU := le.EFX_EDU <> ri.EFX_EDU;
    SELF.Diff_EFX_EXTRACT_DATE := le.EFX_EXTRACT_DATE <> ri.EFX_EXTRACT_DATE;
    SELF.Diff_EFX_FAXPHONE := le.EFX_FAXPHONE <> ri.EFX_FAXPHONE;
    SELF.Diff_EFX_FGOV := le.EFX_FGOV <> ri.EFX_FGOV;
    SELF.Diff_EFX_FOREIGN := le.EFX_FOREIGN <> ri.EFX_FOREIGN;
    SELF.Diff_EFX_GAYLESBIAN := le.EFX_GAYLESBIAN <> ri.EFX_GAYLESBIAN;
    SELF.Diff_EFX_GEOPREC := le.EFX_GEOPREC <> ri.EFX_GEOPREC;
    SELF.Diff_EFX_GOV := le.EFX_GOV <> ri.EFX_GOV;
    SELF.Diff_EFX_GSAX := le.EFX_GSAX <> ri.EFX_GSAX;
    SELF.Diff_EFX_HBCU := le.EFX_HBCU <> ri.EFX_HBCU;
    SELF.Diff_EFX_HUBZONE := le.EFX_HUBZONE <> ri.EFX_HUBZONE;
    SELF.Diff_EFX_ID := le.EFX_ID <> ri.EFX_ID;
    SELF.Diff_EFX_LBE := le.EFX_LBE <> ri.EFX_LBE;
    SELF.Diff_EFX_LEGAL_NAME := le.EFX_LEGAL_NAME <> ri.EFX_LEGAL_NAME;
    SELF.Diff_EFX_LOCAMOUNT := le.EFX_LOCAMOUNT <> ri.EFX_LOCAMOUNT;
    SELF.Diff_EFX_LOCAMOUNTCD := le.EFX_LOCAMOUNTCD <> ri.EFX_LOCAMOUNTCD;
    SELF.Diff_EFX_LOCAMOUNTTP := le.EFX_LOCAMOUNTTP <> ri.EFX_LOCAMOUNTTP;
    SELF.Diff_EFX_LOCAMOUNTPREC := le.EFX_LOCAMOUNTPREC <> ri.EFX_LOCAMOUNTPREC;
    SELF.Diff_EFX_LOCEMPCNT := le.EFX_LOCEMPCNT <> ri.EFX_LOCEMPCNT;
    SELF.Diff_EFX_LOCEMPCD := le.EFX_LOCEMPCD <> ri.EFX_LOCEMPCD;
    SELF.Diff_EFX_MBE := le.EFX_MBE <> ri.EFX_MBE;
    SELF.Diff_EFX_MERCHANT_ID := le.EFX_MERCHANT_ID <> ri.EFX_MERCHANT_ID;
    SELF.Diff_EFX_MERCTYPE := le.EFX_MERCTYPE <> ri.EFX_MERCTYPE;
    SELF.Diff_EFX_MI := le.EFX_MI <> ri.EFX_MI;
    SELF.Diff_EFX_MRKT_SEASONAL := le.EFX_MRKT_SEASONAL <> ri.EFX_MRKT_SEASONAL;
    SELF.Diff_EFX_MRKT_TELESCORE := le.EFX_MRKT_TELESCORE <> ri.EFX_MRKT_TELESCORE;
    SELF.Diff_EFX_MRKT_TELEVER := le.EFX_MRKT_TELEVER <> ri.EFX_MRKT_TELEVER;
    SELF.Diff_EFX_MRKT_TOTALIND := le.EFX_MRKT_TOTALIND <> ri.EFX_MRKT_TOTALIND;
    SELF.Diff_EFX_MRKT_TOTALSCORE := le.EFX_MRKT_TOTALSCORE <> ri.EFX_MRKT_TOTALSCORE;
    SELF.Diff_EFX_MRKT_VACANT := le.EFX_MRKT_VACANT <> ri.EFX_MRKT_VACANT;
    SELF.Diff_EFX_MWBE := le.EFX_MWBE <> ri.EFX_MWBE;
    SELF.Diff_EFX_MWBESTATUS := le.EFX_MWBESTATUS <> ri.EFX_MWBESTATUS;
    SELF.Diff_EFX_NAME := le.EFX_NAME <> ri.EFX_NAME;
    SELF.Diff_EFX_NMSDC := le.EFX_NMSDC <> ri.EFX_NMSDC;
    SELF.Diff_EFX_NONPROFIT := le.EFX_NONPROFIT <> ri.EFX_NONPROFIT;
    SELF.Diff_EFX_PHONE := le.EFX_PHONE <> ri.EFX_PHONE;
    SELF.Diff_EFX_PRIMNAICSCODE := le.EFX_PRIMNAICSCODE <> ri.EFX_PRIMNAICSCODE;
    SELF.Diff_EFX_PRIMSIC := le.EFX_PRIMSIC <> ri.EFX_PRIMSIC;
    SELF.Diff_EFX_PROJECT_ID := le.EFX_PROJECT_ID <> ri.EFX_PROJECT_ID;
    SELF.Diff_EFX_PUBLIC := le.EFX_PUBLIC <> ri.EFX_PUBLIC;
    SELF.Diff_EFX_RES := le.EFX_RES <> ri.EFX_RES;
    SELF.Diff_EFX_SBE := le.EFX_SBE <> ri.EFX_SBE;
    SELF.Diff_EFX_SDB := le.EFX_SDB <> ri.EFX_SDB;
    SELF.Diff_EFX_SECCTRYISOCD := le.EFX_SECCTRYISOCD <> ri.EFX_SECCTRYISOCD;
    SELF.Diff_EFX_SECCTRYNUM := le.EFX_SECCTRYNUM <> ri.EFX_SECCTRYNUM;
    SELF.Diff_EFX_SECGEOPREC := le.EFX_SECGEOPREC <> ri.EFX_SECGEOPREC;
    SELF.Diff_EFX_SECNAICS1 := le.EFX_SECNAICS1 <> ri.EFX_SECNAICS1;
    SELF.Diff_EFX_SECNAICS2 := le.EFX_SECNAICS2 <> ri.EFX_SECNAICS2;
    SELF.Diff_EFX_SECNAICS3 := le.EFX_SECNAICS3 <> ri.EFX_SECNAICS3;
    SELF.Diff_EFX_SECNAICS4 := le.EFX_SECNAICS4 <> ri.EFX_SECNAICS4;
    SELF.Diff_EFX_SECSIC1 := le.EFX_SECSIC1 <> ri.EFX_SECSIC1;
    SELF.Diff_EFX_SECSIC2 := le.EFX_SECSIC2 <> ri.EFX_SECSIC2;
    SELF.Diff_EFX_SECSIC3 := le.EFX_SECSIC3 <> ri.EFX_SECSIC3;
    SELF.Diff_EFX_SECSIC4 := le.EFX_SECSIC4 <> ri.EFX_SECSIC4;
    SELF.Diff_EFX_STATEC := le.EFX_STATEC <> ri.EFX_STATEC;
    SELF.Diff_EFX_STKEXC := le.EFX_STKEXC <> ri.EFX_STKEXC;
    SELF.Diff_EFX_SOHO := le.EFX_SOHO <> ri.EFX_SOHO;
    SELF.Diff_EFX_TX_HUB := le.EFX_TX_HUB <> ri.EFX_TX_HUB;
    SELF.Diff_EFX_VET := le.EFX_VET <> ri.EFX_VET;
    SELF.Diff_EFX_VSBE := le.EFX_VSBE <> ri.EFX_VSBE;
    SELF.Diff_EFX_WBE := le.EFX_WBE <> ri.EFX_WBE;
    SELF.Diff_EFX_WBENC := le.EFX_WBENC <> ri.EFX_WBENC;
    SELF.Diff_EFX_WSBE := le.EFX_WSBE <> ri.EFX_WSBE;
    SELF.Diff_EFX_YREST := le.EFX_YREST <> ri.EFX_YREST;
    SELF.Diff_Record_Update_Refresh_Date := le.Record_Update_Refresh_Date <> ri.Record_Update_Refresh_Date;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_AT_CERTEXP1,1,0)+ IF( SELF.Diff_AT_CERTEXP2,1,0)+ IF( SELF.Diff_AT_CERTEXP3,1,0)+ IF( SELF.Diff_AT_CERTEXP4,1,0)+ IF( SELF.Diff_AT_CERTEXP5,1,0)+ IF( SELF.Diff_AT_CERTEXP6,1,0)+ IF( SELF.Diff_AT_CERTEXP7,1,0)+ IF( SELF.Diff_AT_CERTEXP8,1,0)+ IF( SELF.Diff_AT_CERTEXP9,1,0)+ IF( SELF.Diff_AT_CERTEXP10,1,0)+ IF( SELF.Diff_AT_CERTLEV1,1,0)+ IF( SELF.Diff_AT_CERTLEV2,1,0)+ IF( SELF.Diff_AT_CERTLEV3,1,0)+ IF( SELF.Diff_AT_CERTLEV4,1,0)+ IF( SELF.Diff_AT_CERTLEV5,1,0)+ IF( SELF.Diff_AT_CERTLEV6,1,0)+ IF( SELF.Diff_AT_CERTLEV7,1,0)+ IF( SELF.Diff_AT_CERTLEV8,1,0)+ IF( SELF.Diff_AT_CERTLEV9,1,0)+ IF( SELF.Diff_AT_CERTLEV10,1,0)+ IF( SELF.Diff_EFX_8a,1,0)+ IF( SELF.Diff_EFX_8aEXPDT,1,0)+ IF( SELF.Diff_EFX_ADDRESS,1,0)+ IF( SELF.Diff_EFX_ANC,1,0)+ IF( SELF.Diff_EFX_BIZ,1,0)+ IF( SELF.Diff_EFX_BUSSIZE,1,0)+ IF( SELF.Diff_EFX_BUSSTATCD,1,0)+ IF( SELF.Diff_EFX_CALTRANS,1,0)+ IF( SELF.Diff_EFX_CA_PUC,1,0)+ IF( SELF.Diff_EFX_CITY,1,0)+ IF( SELF.Diff_EFX_CMRA,1,0)+ IF( SELF.Diff_EFX_CMSA,1,0)+ IF( SELF.Diff_EFX_CORPAMOUNT,1,0)+ IF( SELF.Diff_EFX_CORPAMOUNTCD,1,0)+ IF( SELF.Diff_EFX_CORPAMOUNTPREC,1,0)+ IF( SELF.Diff_EFX_CORPAMOUNTTP,1,0)+ IF( SELF.Diff_EFX_CORPEMPCD,1,0)+ IF( SELF.Diff_EFX_CORPEMPCNT,1,0)+ IF( SELF.Diff_EFX_COUNTYNM,1,0)+ IF( SELF.Diff_EFX_COUNTY,1,0)+ IF( SELF.Diff_EFX_CTRYISOCD,1,0)+ IF( SELF.Diff_EFX_CTRYNAME,1,0)+ IF( SELF.Diff_EFX_CTRYNUM,1,0)+ IF( SELF.Diff_EFX_CTRYTELCD,1,0)+ IF( SELF.Diff_EFX_DATE_CREATED,1,0)+ IF( SELF.Diff_EFX_DBE,1,0)+ IF( SELF.Diff_EFX_DEAD,1,0)+ IF( SELF.Diff_EFX_DEADDT,1,0)+ IF( SELF.Diff_EFX_DIS,1,0)+ IF( SELF.Diff_EFX_DVET,1,0)+ IF( SELF.Diff_EFX_DVSBE,1,0)+ IF( SELF.Diff_EFX_EDU,1,0)+ IF( SELF.Diff_EFX_EXTRACT_DATE,1,0)+ IF( SELF.Diff_EFX_FAXPHONE,1,0)+ IF( SELF.Diff_EFX_FGOV,1,0)+ IF( SELF.Diff_EFX_FOREIGN,1,0)+ IF( SELF.Diff_EFX_GAYLESBIAN,1,0)+ IF( SELF.Diff_EFX_GEOPREC,1,0)+ IF( SELF.Diff_EFX_GOV,1,0)+ IF( SELF.Diff_EFX_GSAX,1,0)+ IF( SELF.Diff_EFX_HBCU,1,0)+ IF( SELF.Diff_EFX_HUBZONE,1,0)+ IF( SELF.Diff_EFX_ID,1,0)+ IF( SELF.Diff_EFX_LBE,1,0)+ IF( SELF.Diff_EFX_LEGAL_NAME,1,0)+ IF( SELF.Diff_EFX_LOCAMOUNT,1,0)+ IF( SELF.Diff_EFX_LOCAMOUNTCD,1,0)+ IF( SELF.Diff_EFX_LOCAMOUNTTP,1,0)+ IF( SELF.Diff_EFX_LOCAMOUNTPREC,1,0)+ IF( SELF.Diff_EFX_LOCEMPCNT,1,0)+ IF( SELF.Diff_EFX_LOCEMPCD,1,0)+ IF( SELF.Diff_EFX_MBE,1,0)+ IF( SELF.Diff_EFX_MERCHANT_ID,1,0)+ IF( SELF.Diff_EFX_MERCTYPE,1,0)+ IF( SELF.Diff_EFX_MI,1,0)+ IF( SELF.Diff_EFX_MRKT_SEASONAL,1,0)+ IF( SELF.Diff_EFX_MRKT_TELESCORE,1,0)+ IF( SELF.Diff_EFX_MRKT_TELEVER,1,0)+ IF( SELF.Diff_EFX_MRKT_TOTALIND,1,0)+ IF( SELF.Diff_EFX_MRKT_TOTALSCORE,1,0)+ IF( SELF.Diff_EFX_MRKT_VACANT,1,0)+ IF( SELF.Diff_EFX_MWBE,1,0)+ IF( SELF.Diff_EFX_MWBESTATUS,1,0)+ IF( SELF.Diff_EFX_NAME,1,0)+ IF( SELF.Diff_EFX_NMSDC,1,0)+ IF( SELF.Diff_EFX_NONPROFIT,1,0)+ IF( SELF.Diff_EFX_PHONE,1,0)+ IF( SELF.Diff_EFX_PRIMNAICSCODE,1,0)+ IF( SELF.Diff_EFX_PRIMSIC,1,0)+ IF( SELF.Diff_EFX_PROJECT_ID,1,0)+ IF( SELF.Diff_EFX_PUBLIC,1,0)+ IF( SELF.Diff_EFX_RES,1,0)+ IF( SELF.Diff_EFX_SBE,1,0)+ IF( SELF.Diff_EFX_SDB,1,0)+ IF( SELF.Diff_EFX_SECCTRYISOCD,1,0)+ IF( SELF.Diff_EFX_SECCTRYNUM,1,0)+ IF( SELF.Diff_EFX_SECGEOPREC,1,0)+ IF( SELF.Diff_EFX_SECNAICS1,1,0)+ IF( SELF.Diff_EFX_SECNAICS2,1,0)+ IF( SELF.Diff_EFX_SECNAICS3,1,0)+ IF( SELF.Diff_EFX_SECNAICS4,1,0)+ IF( SELF.Diff_EFX_SECSIC1,1,0)+ IF( SELF.Diff_EFX_SECSIC2,1,0)+ IF( SELF.Diff_EFX_SECSIC3,1,0)+ IF( SELF.Diff_EFX_SECSIC4,1,0)+ IF( SELF.Diff_EFX_STATEC,1,0)+ IF( SELF.Diff_EFX_STKEXC,1,0)+ IF( SELF.Diff_EFX_SOHO,1,0)+ IF( SELF.Diff_EFX_TX_HUB,1,0)+ IF( SELF.Diff_EFX_VET,1,0)+ IF( SELF.Diff_EFX_VSBE,1,0)+ IF( SELF.Diff_EFX_WBE,1,0)+ IF( SELF.Diff_EFX_WBENC,1,0)+ IF( SELF.Diff_EFX_WSBE,1,0)+ IF( SELF.Diff_EFX_YREST,1,0)+ IF( SELF.Diff_Record_Update_Refresh_Date,1,0);
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
    Count_Diff_EFX_8a := COUNT(GROUP,%Closest%.Diff_EFX_8a);
    Count_Diff_EFX_8aEXPDT := COUNT(GROUP,%Closest%.Diff_EFX_8aEXPDT);
    Count_Diff_EFX_ADDRESS := COUNT(GROUP,%Closest%.Diff_EFX_ADDRESS);
    Count_Diff_EFX_ANC := COUNT(GROUP,%Closest%.Diff_EFX_ANC);
    Count_Diff_EFX_BIZ := COUNT(GROUP,%Closest%.Diff_EFX_BIZ);
    Count_Diff_EFX_BUSSIZE := COUNT(GROUP,%Closest%.Diff_EFX_BUSSIZE);
    Count_Diff_EFX_BUSSTATCD := COUNT(GROUP,%Closest%.Diff_EFX_BUSSTATCD);
    Count_Diff_EFX_CALTRANS := COUNT(GROUP,%Closest%.Diff_EFX_CALTRANS);
    Count_Diff_EFX_CA_PUC := COUNT(GROUP,%Closest%.Diff_EFX_CA_PUC);
    Count_Diff_EFX_CITY := COUNT(GROUP,%Closest%.Diff_EFX_CITY);
    Count_Diff_EFX_CMRA := COUNT(GROUP,%Closest%.Diff_EFX_CMRA);
    Count_Diff_EFX_CMSA := COUNT(GROUP,%Closest%.Diff_EFX_CMSA);
    Count_Diff_EFX_CORPAMOUNT := COUNT(GROUP,%Closest%.Diff_EFX_CORPAMOUNT);
    Count_Diff_EFX_CORPAMOUNTCD := COUNT(GROUP,%Closest%.Diff_EFX_CORPAMOUNTCD);
    Count_Diff_EFX_CORPAMOUNTPREC := COUNT(GROUP,%Closest%.Diff_EFX_CORPAMOUNTPREC);
    Count_Diff_EFX_CORPAMOUNTTP := COUNT(GROUP,%Closest%.Diff_EFX_CORPAMOUNTTP);
    Count_Diff_EFX_CORPEMPCD := COUNT(GROUP,%Closest%.Diff_EFX_CORPEMPCD);
    Count_Diff_EFX_CORPEMPCNT := COUNT(GROUP,%Closest%.Diff_EFX_CORPEMPCNT);
    Count_Diff_EFX_COUNTYNM := COUNT(GROUP,%Closest%.Diff_EFX_COUNTYNM);
    Count_Diff_EFX_COUNTY := COUNT(GROUP,%Closest%.Diff_EFX_COUNTY);
    Count_Diff_EFX_CTRYISOCD := COUNT(GROUP,%Closest%.Diff_EFX_CTRYISOCD);
    Count_Diff_EFX_CTRYNAME := COUNT(GROUP,%Closest%.Diff_EFX_CTRYNAME);
    Count_Diff_EFX_CTRYNUM := COUNT(GROUP,%Closest%.Diff_EFX_CTRYNUM);
    Count_Diff_EFX_CTRYTELCD := COUNT(GROUP,%Closest%.Diff_EFX_CTRYTELCD);
    Count_Diff_EFX_DATE_CREATED := COUNT(GROUP,%Closest%.Diff_EFX_DATE_CREATED);
    Count_Diff_EFX_DBE := COUNT(GROUP,%Closest%.Diff_EFX_DBE);
    Count_Diff_EFX_DEAD := COUNT(GROUP,%Closest%.Diff_EFX_DEAD);
    Count_Diff_EFX_DEADDT := COUNT(GROUP,%Closest%.Diff_EFX_DEADDT);
    Count_Diff_EFX_DIS := COUNT(GROUP,%Closest%.Diff_EFX_DIS);
    Count_Diff_EFX_DVET := COUNT(GROUP,%Closest%.Diff_EFX_DVET);
    Count_Diff_EFX_DVSBE := COUNT(GROUP,%Closest%.Diff_EFX_DVSBE);
    Count_Diff_EFX_EDU := COUNT(GROUP,%Closest%.Diff_EFX_EDU);
    Count_Diff_EFX_EXTRACT_DATE := COUNT(GROUP,%Closest%.Diff_EFX_EXTRACT_DATE);
    Count_Diff_EFX_FAXPHONE := COUNT(GROUP,%Closest%.Diff_EFX_FAXPHONE);
    Count_Diff_EFX_FGOV := COUNT(GROUP,%Closest%.Diff_EFX_FGOV);
    Count_Diff_EFX_FOREIGN := COUNT(GROUP,%Closest%.Diff_EFX_FOREIGN);
    Count_Diff_EFX_GAYLESBIAN := COUNT(GROUP,%Closest%.Diff_EFX_GAYLESBIAN);
    Count_Diff_EFX_GEOPREC := COUNT(GROUP,%Closest%.Diff_EFX_GEOPREC);
    Count_Diff_EFX_GOV := COUNT(GROUP,%Closest%.Diff_EFX_GOV);
    Count_Diff_EFX_GSAX := COUNT(GROUP,%Closest%.Diff_EFX_GSAX);
    Count_Diff_EFX_HBCU := COUNT(GROUP,%Closest%.Diff_EFX_HBCU);
    Count_Diff_EFX_HUBZONE := COUNT(GROUP,%Closest%.Diff_EFX_HUBZONE);
    Count_Diff_EFX_ID := COUNT(GROUP,%Closest%.Diff_EFX_ID);
    Count_Diff_EFX_LBE := COUNT(GROUP,%Closest%.Diff_EFX_LBE);
    Count_Diff_EFX_LEGAL_NAME := COUNT(GROUP,%Closest%.Diff_EFX_LEGAL_NAME);
    Count_Diff_EFX_LOCAMOUNT := COUNT(GROUP,%Closest%.Diff_EFX_LOCAMOUNT);
    Count_Diff_EFX_LOCAMOUNTCD := COUNT(GROUP,%Closest%.Diff_EFX_LOCAMOUNTCD);
    Count_Diff_EFX_LOCAMOUNTTP := COUNT(GROUP,%Closest%.Diff_EFX_LOCAMOUNTTP);
    Count_Diff_EFX_LOCAMOUNTPREC := COUNT(GROUP,%Closest%.Diff_EFX_LOCAMOUNTPREC);
    Count_Diff_EFX_LOCEMPCNT := COUNT(GROUP,%Closest%.Diff_EFX_LOCEMPCNT);
    Count_Diff_EFX_LOCEMPCD := COUNT(GROUP,%Closest%.Diff_EFX_LOCEMPCD);
    Count_Diff_EFX_MBE := COUNT(GROUP,%Closest%.Diff_EFX_MBE);
    Count_Diff_EFX_MERCHANT_ID := COUNT(GROUP,%Closest%.Diff_EFX_MERCHANT_ID);
    Count_Diff_EFX_MERCTYPE := COUNT(GROUP,%Closest%.Diff_EFX_MERCTYPE);
    Count_Diff_EFX_MI := COUNT(GROUP,%Closest%.Diff_EFX_MI);
    Count_Diff_EFX_MRKT_SEASONAL := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_SEASONAL);
    Count_Diff_EFX_MRKT_TELESCORE := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_TELESCORE);
    Count_Diff_EFX_MRKT_TELEVER := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_TELEVER);
    Count_Diff_EFX_MRKT_TOTALIND := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_TOTALIND);
    Count_Diff_EFX_MRKT_TOTALSCORE := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_TOTALSCORE);
    Count_Diff_EFX_MRKT_VACANT := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_VACANT);
    Count_Diff_EFX_MWBE := COUNT(GROUP,%Closest%.Diff_EFX_MWBE);
    Count_Diff_EFX_MWBESTATUS := COUNT(GROUP,%Closest%.Diff_EFX_MWBESTATUS);
    Count_Diff_EFX_NAME := COUNT(GROUP,%Closest%.Diff_EFX_NAME);
    Count_Diff_EFX_NMSDC := COUNT(GROUP,%Closest%.Diff_EFX_NMSDC);
    Count_Diff_EFX_NONPROFIT := COUNT(GROUP,%Closest%.Diff_EFX_NONPROFIT);
    Count_Diff_EFX_PHONE := COUNT(GROUP,%Closest%.Diff_EFX_PHONE);
    Count_Diff_EFX_PRIMNAICSCODE := COUNT(GROUP,%Closest%.Diff_EFX_PRIMNAICSCODE);
    Count_Diff_EFX_PRIMSIC := COUNT(GROUP,%Closest%.Diff_EFX_PRIMSIC);
    Count_Diff_EFX_PROJECT_ID := COUNT(GROUP,%Closest%.Diff_EFX_PROJECT_ID);
    Count_Diff_EFX_PUBLIC := COUNT(GROUP,%Closest%.Diff_EFX_PUBLIC);
    Count_Diff_EFX_RES := COUNT(GROUP,%Closest%.Diff_EFX_RES);
    Count_Diff_EFX_SBE := COUNT(GROUP,%Closest%.Diff_EFX_SBE);
    Count_Diff_EFX_SDB := COUNT(GROUP,%Closest%.Diff_EFX_SDB);
    Count_Diff_EFX_SECCTRYISOCD := COUNT(GROUP,%Closest%.Diff_EFX_SECCTRYISOCD);
    Count_Diff_EFX_SECCTRYNUM := COUNT(GROUP,%Closest%.Diff_EFX_SECCTRYNUM);
    Count_Diff_EFX_SECGEOPREC := COUNT(GROUP,%Closest%.Diff_EFX_SECGEOPREC);
    Count_Diff_EFX_SECNAICS1 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICS1);
    Count_Diff_EFX_SECNAICS2 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICS2);
    Count_Diff_EFX_SECNAICS3 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICS3);
    Count_Diff_EFX_SECNAICS4 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICS4);
    Count_Diff_EFX_SECSIC1 := COUNT(GROUP,%Closest%.Diff_EFX_SECSIC1);
    Count_Diff_EFX_SECSIC2 := COUNT(GROUP,%Closest%.Diff_EFX_SECSIC2);
    Count_Diff_EFX_SECSIC3 := COUNT(GROUP,%Closest%.Diff_EFX_SECSIC3);
    Count_Diff_EFX_SECSIC4 := COUNT(GROUP,%Closest%.Diff_EFX_SECSIC4);
    Count_Diff_EFX_STATEC := COUNT(GROUP,%Closest%.Diff_EFX_STATEC);
    Count_Diff_EFX_STKEXC := COUNT(GROUP,%Closest%.Diff_EFX_STKEXC);
    Count_Diff_EFX_SOHO := COUNT(GROUP,%Closest%.Diff_EFX_SOHO);
    Count_Diff_EFX_TX_HUB := COUNT(GROUP,%Closest%.Diff_EFX_TX_HUB);
    Count_Diff_EFX_VET := COUNT(GROUP,%Closest%.Diff_EFX_VET);
    Count_Diff_EFX_VSBE := COUNT(GROUP,%Closest%.Diff_EFX_VSBE);
    Count_Diff_EFX_WBE := COUNT(GROUP,%Closest%.Diff_EFX_WBE);
    Count_Diff_EFX_WBENC := COUNT(GROUP,%Closest%.Diff_EFX_WBENC);
    Count_Diff_EFX_WSBE := COUNT(GROUP,%Closest%.Diff_EFX_WSBE);
    Count_Diff_EFX_YREST := COUNT(GROUP,%Closest%.Diff_EFX_YREST);
    Count_Diff_Record_Update_Refresh_Date := COUNT(GROUP,%Closest%.Diff_Record_Update_Refresh_Date);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

IMPORT SALT38;
IMPORT Scrubs_Experian_FEIN; // Import modules for FieldTypes attribute definitions
EXPORT Base_Fields := MODULE
 
EXPORT NumFields := 69;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_zero_integer','invalid_boolean_yes_no','invalid_numeric','invalid_percentage','invalid_pastdate8','invalid_business_identification_number','invalid_business_state','invalid_business_zip','invalid_norm_type','invalid_norm_tax_id','invalid_norm_confidence_level','invalid_source','invalid_direction','invalid_st','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_rec_type','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','invalid_raw_aid','invalid_ace_aid');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_zero_integer' => 2,'invalid_boolean_yes_no' => 3,'invalid_numeric' => 4,'invalid_percentage' => 5,'invalid_pastdate8' => 6,'invalid_business_identification_number' => 7,'invalid_business_state' => 8,'invalid_business_zip' => 9,'invalid_norm_type' => 10,'invalid_norm_tax_id' => 11,'invalid_norm_confidence_level' => 12,'invalid_source' => 13,'invalid_direction' => 14,'invalid_st' => 15,'invalid_zip5' => 16,'invalid_zip4' => 17,'invalid_cart' => 18,'invalid_cr_sort_sz' => 19,'invalid_lot' => 20,'invalid_lot_order' => 21,'invalid_dpbc' => 22,'invalid_chk_digit' => 23,'invalid_rec_type' => 24,'invalid_fips_state' => 25,'invalid_fips_county' => 26,'invalid_geo' => 27,'invalid_msa' => 28,'invalid_geo_blk' => 29,'invalid_geo_match' => 30,'invalid_err_stat' => 31,'invalid_raw_aid' => 32,'invalid_ace_aid' => 33,0);
 
EXPORT MakeFT_invalid_mandatory(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_populated_strings(s)>0);
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_populated_strings'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zero_integer(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zero_integer(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['0','']);
EXPORT InValidMessageFT_invalid_zero_integer(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('0|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_boolean_yes_no(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_boolean_yes_no(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['Y','N']);
EXPORT InValidMessageFT_invalid_boolean_yes_no(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('Y|N'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_percentage(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_percentage(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_range_numeric(s,0,100)>0);
EXPORT InValidMessageFT_invalid_percentage(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_range_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate8(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate8(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate8(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_past_yyyymmdd'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_business_identification_number(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_business_identification_number(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_numeric(s,9)>0);
EXPORT InValidMessageFT_invalid_business_identification_number(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_business_state(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_business_state(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_business_state(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_verify_state'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_business_zip(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_business_zip(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_business_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_norm_type(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_norm_type(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_range_numeric(s,1,5)>0);
EXPORT InValidMessageFT_invalid_norm_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_range_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_norm_tax_id(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_norm_tax_id(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_numeric(s,9)>0);
EXPORT InValidMessageFT_invalid_norm_tax_id(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_norm_confidence_level(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_norm_confidence_level(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_range_numeric(s,1,3)>0);
EXPORT InValidMessageFT_invalid_norm_confidence_level(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_range_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_source(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_source(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['E5','E6']);
EXPORT InValidMessageFT_invalid_source(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('E5|E6'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_direction(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ENSW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_direction(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ENSW'))));
EXPORT InValidMessageFT_invalid_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ENSW'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_st(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_verify_state'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip4(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cart(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cart(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_alphanumeric(s,4)>0);
EXPORT InValidMessageFT_invalid_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_alphanumeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cr_sort_sz(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cr_sort_sz(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['A','B','C','D']);
EXPORT InValidMessageFT_invalid_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('A|B|C|D'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot_order(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot_order(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['A','D']);
EXPORT InValidMessageFT_invalid_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('A|D'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dpbc(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dpbc(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_dpbc(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_chk_digit(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_chk_digit(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_rec_type(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rec_type(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_addr_rec_type(s)>0);
EXPORT InValidMessageFT_invalid_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_addr_rec_type'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_state(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_state(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_fips_state(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_county(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_county(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_numeric(s,3)>0);
EXPORT InValidMessageFT_invalid_fips_county(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_geo_coord(s)>0);
EXPORT InValidMessageFT_invalid_geo(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_geo_coord'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_msa(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_msa(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_blk(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo_blk(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_numeric(s,7)>0);
EXPORT InValidMessageFT_invalid_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_match(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo_match(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_err_stat(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_err_stat(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_alphanumeric(s,4)>0);
EXPORT InValidMessageFT_invalid_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_alphanumeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_raw_aid(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_raw_aid(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_raw_aid(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ace_aid(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ace_aid(SALT38.StrType s) := WHICH(~Scrubs_Experian_FEIN.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_ace_aid(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'business_identification_number','business_name','business_address','business_city','business_state','business_zip','norm_type','norm_tax_id','norm_confidence_level','norm_display_configuration','long_name','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source','source_rec_id','bdid','bdid_score','dt_vendor_first_reported','dt_vendor_last_reported','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_addr_line1','prep_addr_line_last');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'business_identification_number','business_name','business_address','business_city','business_state','business_zip','norm_type','norm_tax_id','norm_confidence_level','norm_display_configuration','long_name','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source','source_rec_id','bdid','bdid_score','dt_vendor_first_reported','dt_vendor_last_reported','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_addr_line1','prep_addr_line_last');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'business_identification_number' => 0,'business_name' => 1,'business_address' => 2,'business_city' => 3,'business_state' => 4,'business_zip' => 5,'norm_type' => 6,'norm_tax_id' => 7,'norm_confidence_level' => 8,'norm_display_configuration' => 9,'long_name' => 10,'dotid' => 11,'dotscore' => 12,'dotweight' => 13,'empid' => 14,'empscore' => 15,'empweight' => 16,'powid' => 17,'powscore' => 18,'powweight' => 19,'proxid' => 20,'proxscore' => 21,'proxweight' => 22,'seleid' => 23,'selescore' => 24,'seleweight' => 25,'orgid' => 26,'orgscore' => 27,'orgweight' => 28,'ultid' => 29,'ultscore' => 30,'ultweight' => 31,'source' => 32,'source_rec_id' => 33,'bdid' => 34,'bdid_score' => 35,'dt_vendor_first_reported' => 36,'dt_vendor_last_reported' => 37,'prim_range' => 38,'predir' => 39,'prim_name' => 40,'addr_suffix' => 41,'postdir' => 42,'unit_desig' => 43,'sec_range' => 44,'p_city_name' => 45,'v_city_name' => 46,'st' => 47,'zip' => 48,'zip4' => 49,'cart' => 50,'cr_sort_sz' => 51,'lot' => 52,'lot_order' => 53,'dbpc' => 54,'chk_digit' => 55,'rec_type' => 56,'fips_state' => 57,'fips_county' => 58,'geo_lat' => 59,'geo_long' => 60,'msa' => 61,'geo_blk' => 62,'geo_match' => 63,'err_stat' => 64,'raw_aid' => 65,'ace_aid' => 66,'prep_addr_line1' => 67,'prep_addr_line_last' => 68,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['CUSTOM'],[],['ALLOW'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_business_identification_number(SALT38.StrType s0) := MakeFT_invalid_business_identification_number(s0);
EXPORT InValid_business_identification_number(SALT38.StrType s) := InValidFT_invalid_business_identification_number(s);
EXPORT InValidMessage_business_identification_number(UNSIGNED1 wh) := InValidMessageFT_invalid_business_identification_number(wh);
 
EXPORT Make_business_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_business_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_business_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_business_address(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_business_address(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_business_address(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_business_city(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_business_city(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_business_city(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_business_state(SALT38.StrType s0) := MakeFT_invalid_business_state(s0);
EXPORT InValid_business_state(SALT38.StrType s) := InValidFT_invalid_business_state(s);
EXPORT InValidMessage_business_state(UNSIGNED1 wh) := InValidMessageFT_invalid_business_state(wh);
 
EXPORT Make_business_zip(SALT38.StrType s0) := MakeFT_invalid_business_zip(s0);
EXPORT InValid_business_zip(SALT38.StrType s) := InValidFT_invalid_business_zip(s);
EXPORT InValidMessage_business_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_business_zip(wh);
 
EXPORT Make_norm_type(SALT38.StrType s0) := MakeFT_invalid_norm_type(s0);
EXPORT InValid_norm_type(SALT38.StrType s) := InValidFT_invalid_norm_type(s);
EXPORT InValidMessage_norm_type(UNSIGNED1 wh) := InValidMessageFT_invalid_norm_type(wh);
 
EXPORT Make_norm_tax_id(SALT38.StrType s0) := MakeFT_invalid_norm_tax_id(s0);
EXPORT InValid_norm_tax_id(SALT38.StrType s) := InValidFT_invalid_norm_tax_id(s);
EXPORT InValidMessage_norm_tax_id(UNSIGNED1 wh) := InValidMessageFT_invalid_norm_tax_id(wh);
 
EXPORT Make_norm_confidence_level(SALT38.StrType s0) := MakeFT_invalid_norm_confidence_level(s0);
EXPORT InValid_norm_confidence_level(SALT38.StrType s) := InValidFT_invalid_norm_confidence_level(s);
EXPORT InValidMessage_norm_confidence_level(UNSIGNED1 wh) := InValidMessageFT_invalid_norm_confidence_level(wh);
 
EXPORT Make_norm_display_configuration(SALT38.StrType s0) := MakeFT_invalid_boolean_yes_no(s0);
EXPORT InValid_norm_display_configuration(SALT38.StrType s) := InValidFT_invalid_boolean_yes_no(s);
EXPORT InValidMessage_norm_display_configuration(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_yes_no(wh);
 
EXPORT Make_long_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_long_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_long_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_dotid(SALT38.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_dotid(SALT38.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_dotscore(SALT38.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_dotscore(SALT38.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_dotweight(SALT38.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_dotweight(SALT38.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_empid(SALT38.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_empid(SALT38.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_empid(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_empscore(SALT38.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_empscore(SALT38.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_empweight(SALT38.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_empweight(SALT38.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_powid(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_powid(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_powid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_powscore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_powscore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_powweight(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_powweight(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_proxid(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_proxid(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_proxscore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_proxscore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_proxweight(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_proxweight(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_seleid(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_seleid(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_selescore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_selescore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_seleweight(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_seleweight(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_orgid(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_orgid(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_orgscore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_orgscore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_orgweight(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_orgweight(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ultid(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_ultid(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ultscore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_ultscore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_ultweight(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_ultweight(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_source(SALT38.StrType s0) := MakeFT_invalid_source(s0);
EXPORT InValid_source(SALT38.StrType s) := InValidFT_invalid_source(s);
EXPORT InValidMessage_source(UNSIGNED1 wh) := InValidMessageFT_invalid_source(wh);
 
EXPORT Make_source_rec_id(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_source_rec_id(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_source_rec_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_bdid(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bdid(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_bdid_score(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_bdid_score(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_bdid_score(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT38.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_dt_vendor_first_reported(SALT38.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT38.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_dt_vendor_last_reported(SALT38.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_prim_range(SALT38.StrType s0) := s0;
EXPORT InValid_prim_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT38.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_predir(SALT38.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_prim_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prim_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_addr_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT38.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_postdir(SALT38.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_unit_desig(SALT38.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT38.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT38.StrType s0) := s0;
EXPORT InValid_sec_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_p_city_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_v_city_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_v_city_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_st(SALT38.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_st(SALT38.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_zip(SALT38.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_zip(SALT38.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_zip4(SALT38.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_zip4(SALT38.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_cart(SALT38.StrType s0) := MakeFT_invalid_cart(s0);
EXPORT InValid_cart(SALT38.StrType s) := InValidFT_invalid_cart(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_invalid_cart(wh);
 
EXPORT Make_cr_sort_sz(SALT38.StrType s0) := MakeFT_invalid_cr_sort_sz(s0);
EXPORT InValid_cr_sort_sz(SALT38.StrType s) := InValidFT_invalid_cr_sort_sz(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_invalid_cr_sort_sz(wh);
 
EXPORT Make_lot(SALT38.StrType s0) := MakeFT_invalid_lot(s0);
EXPORT InValid_lot(SALT38.StrType s) := InValidFT_invalid_lot(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_invalid_lot(wh);
 
EXPORT Make_lot_order(SALT38.StrType s0) := MakeFT_invalid_lot_order(s0);
EXPORT InValid_lot_order(SALT38.StrType s) := InValidFT_invalid_lot_order(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_invalid_lot_order(wh);
 
EXPORT Make_dbpc(SALT38.StrType s0) := MakeFT_invalid_dpbc(s0);
EXPORT InValid_dbpc(SALT38.StrType s) := InValidFT_invalid_dpbc(s);
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := InValidMessageFT_invalid_dpbc(wh);
 
EXPORT Make_chk_digit(SALT38.StrType s0) := MakeFT_invalid_chk_digit(s0);
EXPORT InValid_chk_digit(SALT38.StrType s) := InValidFT_invalid_chk_digit(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_invalid_chk_digit(wh);
 
EXPORT Make_rec_type(SALT38.StrType s0) := MakeFT_invalid_rec_type(s0);
EXPORT InValid_rec_type(SALT38.StrType s) := InValidFT_invalid_rec_type(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_invalid_rec_type(wh);
 
EXPORT Make_fips_state(SALT38.StrType s0) := MakeFT_invalid_fips_state(s0);
EXPORT InValid_fips_state(SALT38.StrType s) := InValidFT_invalid_fips_state(s);
EXPORT InValidMessage_fips_state(UNSIGNED1 wh) := InValidMessageFT_invalid_fips_state(wh);
 
EXPORT Make_fips_county(SALT38.StrType s0) := MakeFT_invalid_fips_county(s0);
EXPORT InValid_fips_county(SALT38.StrType s) := InValidFT_invalid_fips_county(s);
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := InValidMessageFT_invalid_fips_county(wh);
 
EXPORT Make_geo_lat(SALT38.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_geo_lat(SALT38.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_geo_long(SALT38.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_geo_long(SALT38.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_msa(SALT38.StrType s0) := MakeFT_invalid_msa(s0);
EXPORT InValid_msa(SALT38.StrType s) := InValidFT_invalid_msa(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_invalid_msa(wh);
 
EXPORT Make_geo_blk(SALT38.StrType s0) := MakeFT_invalid_geo_blk(s0);
EXPORT InValid_geo_blk(SALT38.StrType s) := InValidFT_invalid_geo_blk(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_blk(wh);
 
EXPORT Make_geo_match(SALT38.StrType s0) := MakeFT_invalid_geo_match(s0);
EXPORT InValid_geo_match(SALT38.StrType s) := InValidFT_invalid_geo_match(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_match(wh);
 
EXPORT Make_err_stat(SALT38.StrType s0) := MakeFT_invalid_err_stat(s0);
EXPORT InValid_err_stat(SALT38.StrType s) := InValidFT_invalid_err_stat(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_invalid_err_stat(wh);
 
EXPORT Make_raw_aid(SALT38.StrType s0) := MakeFT_invalid_raw_aid(s0);
EXPORT InValid_raw_aid(SALT38.StrType s) := InValidFT_invalid_raw_aid(s);
EXPORT InValidMessage_raw_aid(UNSIGNED1 wh) := InValidMessageFT_invalid_raw_aid(wh);
 
EXPORT Make_ace_aid(SALT38.StrType s0) := MakeFT_invalid_ace_aid(s0);
EXPORT InValid_ace_aid(SALT38.StrType s) := InValidFT_invalid_ace_aid(s);
EXPORT InValidMessage_ace_aid(UNSIGNED1 wh) := InValidMessageFT_invalid_ace_aid(wh);
 
EXPORT Make_prep_addr_line1(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line1(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_line_last(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line_last(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_Experian_FEIN;
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
    BOOLEAN Diff_business_identification_number;
    BOOLEAN Diff_business_name;
    BOOLEAN Diff_business_address;
    BOOLEAN Diff_business_city;
    BOOLEAN Diff_business_state;
    BOOLEAN Diff_business_zip;
    BOOLEAN Diff_norm_type;
    BOOLEAN Diff_norm_tax_id;
    BOOLEAN Diff_norm_confidence_level;
    BOOLEAN Diff_norm_display_configuration;
    BOOLEAN Diff_long_name;
    BOOLEAN Diff_dotid;
    BOOLEAN Diff_dotscore;
    BOOLEAN Diff_dotweight;
    BOOLEAN Diff_empid;
    BOOLEAN Diff_empscore;
    BOOLEAN Diff_empweight;
    BOOLEAN Diff_powid;
    BOOLEAN Diff_powscore;
    BOOLEAN Diff_powweight;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_proxscore;
    BOOLEAN Diff_proxweight;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_selescore;
    BOOLEAN Diff_seleweight;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_orgscore;
    BOOLEAN Diff_orgweight;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_ultscore;
    BOOLEAN Diff_ultweight;
    BOOLEAN Diff_source;
    BOOLEAN Diff_source_rec_id;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_bdid_score;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
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
    BOOLEAN Diff_fips_state;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_raw_aid;
    BOOLEAN Diff_ace_aid;
    BOOLEAN Diff_prep_addr_line1;
    BOOLEAN Diff_prep_addr_line_last;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_business_identification_number := le.business_identification_number <> ri.business_identification_number;
    SELF.Diff_business_name := le.business_name <> ri.business_name;
    SELF.Diff_business_address := le.business_address <> ri.business_address;
    SELF.Diff_business_city := le.business_city <> ri.business_city;
    SELF.Diff_business_state := le.business_state <> ri.business_state;
    SELF.Diff_business_zip := le.business_zip <> ri.business_zip;
    SELF.Diff_norm_type := le.norm_type <> ri.norm_type;
    SELF.Diff_norm_tax_id := le.norm_tax_id <> ri.norm_tax_id;
    SELF.Diff_norm_confidence_level := le.norm_confidence_level <> ri.norm_confidence_level;
    SELF.Diff_norm_display_configuration := le.norm_display_configuration <> ri.norm_display_configuration;
    SELF.Diff_long_name := le.long_name <> ri.long_name;
    SELF.Diff_dotid := le.dotid <> ri.dotid;
    SELF.Diff_dotscore := le.dotscore <> ri.dotscore;
    SELF.Diff_dotweight := le.dotweight <> ri.dotweight;
    SELF.Diff_empid := le.empid <> ri.empid;
    SELF.Diff_empscore := le.empscore <> ri.empscore;
    SELF.Diff_empweight := le.empweight <> ri.empweight;
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_powscore := le.powscore <> ri.powscore;
    SELF.Diff_powweight := le.powweight <> ri.powweight;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_proxscore := le.proxscore <> ri.proxscore;
    SELF.Diff_proxweight := le.proxweight <> ri.proxweight;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_selescore := le.selescore <> ri.selescore;
    SELF.Diff_seleweight := le.seleweight <> ri.seleweight;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_orgscore := le.orgscore <> ri.orgscore;
    SELF.Diff_orgweight := le.orgweight <> ri.orgweight;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_ultscore := le.ultscore <> ri.ultscore;
    SELF.Diff_ultweight := le.ultweight <> ri.ultweight;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_source_rec_id := le.source_rec_id <> ri.source_rec_id;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_bdid_score := le.bdid_score <> ri.bdid_score;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
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
    SELF.Diff_fips_state := le.fips_state <> ri.fips_state;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_raw_aid := le.raw_aid <> ri.raw_aid;
    SELF.Diff_ace_aid := le.ace_aid <> ri.ace_aid;
    SELF.Diff_prep_addr_line1 := le.prep_addr_line1 <> ri.prep_addr_line1;
    SELF.Diff_prep_addr_line_last := le.prep_addr_line_last <> ri.prep_addr_line_last;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_business_identification_number,1,0)+ IF( SELF.Diff_business_name,1,0)+ IF( SELF.Diff_business_address,1,0)+ IF( SELF.Diff_business_city,1,0)+ IF( SELF.Diff_business_state,1,0)+ IF( SELF.Diff_business_zip,1,0)+ IF( SELF.Diff_norm_type,1,0)+ IF( SELF.Diff_norm_tax_id,1,0)+ IF( SELF.Diff_norm_confidence_level,1,0)+ IF( SELF.Diff_norm_display_configuration,1,0)+ IF( SELF.Diff_long_name,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_source_rec_id,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_bdid_score,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_state,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_raw_aid,1,0)+ IF( SELF.Diff_ace_aid,1,0)+ IF( SELF.Diff_prep_addr_line1,1,0)+ IF( SELF.Diff_prep_addr_line_last,1,0);
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
    Count_Diff_business_identification_number := COUNT(GROUP,%Closest%.Diff_business_identification_number);
    Count_Diff_business_name := COUNT(GROUP,%Closest%.Diff_business_name);
    Count_Diff_business_address := COUNT(GROUP,%Closest%.Diff_business_address);
    Count_Diff_business_city := COUNT(GROUP,%Closest%.Diff_business_city);
    Count_Diff_business_state := COUNT(GROUP,%Closest%.Diff_business_state);
    Count_Diff_business_zip := COUNT(GROUP,%Closest%.Diff_business_zip);
    Count_Diff_norm_type := COUNT(GROUP,%Closest%.Diff_norm_type);
    Count_Diff_norm_tax_id := COUNT(GROUP,%Closest%.Diff_norm_tax_id);
    Count_Diff_norm_confidence_level := COUNT(GROUP,%Closest%.Diff_norm_confidence_level);
    Count_Diff_norm_display_configuration := COUNT(GROUP,%Closest%.Diff_norm_display_configuration);
    Count_Diff_long_name := COUNT(GROUP,%Closest%.Diff_long_name);
    Count_Diff_dotid := COUNT(GROUP,%Closest%.Diff_dotid);
    Count_Diff_dotscore := COUNT(GROUP,%Closest%.Diff_dotscore);
    Count_Diff_dotweight := COUNT(GROUP,%Closest%.Diff_dotweight);
    Count_Diff_empid := COUNT(GROUP,%Closest%.Diff_empid);
    Count_Diff_empscore := COUNT(GROUP,%Closest%.Diff_empscore);
    Count_Diff_empweight := COUNT(GROUP,%Closest%.Diff_empweight);
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_powscore := COUNT(GROUP,%Closest%.Diff_powscore);
    Count_Diff_powweight := COUNT(GROUP,%Closest%.Diff_powweight);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_proxscore := COUNT(GROUP,%Closest%.Diff_proxscore);
    Count_Diff_proxweight := COUNT(GROUP,%Closest%.Diff_proxweight);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_selescore := COUNT(GROUP,%Closest%.Diff_selescore);
    Count_Diff_seleweight := COUNT(GROUP,%Closest%.Diff_seleweight);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_orgscore := COUNT(GROUP,%Closest%.Diff_orgscore);
    Count_Diff_orgweight := COUNT(GROUP,%Closest%.Diff_orgweight);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_ultscore := COUNT(GROUP,%Closest%.Diff_ultscore);
    Count_Diff_ultweight := COUNT(GROUP,%Closest%.Diff_ultweight);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_source_rec_id := COUNT(GROUP,%Closest%.Diff_source_rec_id);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_bdid_score := COUNT(GROUP,%Closest%.Diff_bdid_score);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
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
    Count_Diff_fips_state := COUNT(GROUP,%Closest%.Diff_fips_state);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_raw_aid := COUNT(GROUP,%Closest%.Diff_raw_aid);
    Count_Diff_ace_aid := COUNT(GROUP,%Closest%.Diff_ace_aid);
    Count_Diff_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_addr_line1);
    Count_Diff_prep_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_addr_line_last);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

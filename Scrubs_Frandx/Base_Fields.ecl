IMPORT SALT38;
IMPORT Scrubs_Frandx; // Import modules for FieldTypes attribute definitions
EXPORT Base_Fields := MODULE
 
EXPORT NumFields := 97;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_zero_integer','invalid_numeric','invalid_nonempty_number','invalid_percentage','invalid_pastdate8','invalid_pastdate08','invalid_record_type','invalid_franchisee_id','invalid_fruns','invalid_company_name','invalid_state','invalid_zip_code','invalid_zip_code4','invalid_phone','invalid_secondary_phone','invalid_unit_flag','invalid_relationship_code','invalid_industry_type','invalid_sic_code','invalid_unit_flag_exp','invalid_relationship_code_exp','invalid_fname','invalid_mname','invalid_lname','invalid_direction','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dbpc','invalid_chk_digit','invalid_rec_type','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','invalid_raw_aid','invalid_ace_aid','invalid_source_rec_id');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_zero_integer' => 2,'invalid_numeric' => 3,'invalid_nonempty_number' => 4,'invalid_percentage' => 5,'invalid_pastdate8' => 6,'invalid_pastdate08' => 7,'invalid_record_type' => 8,'invalid_franchisee_id' => 9,'invalid_fruns' => 10,'invalid_company_name' => 11,'invalid_state' => 12,'invalid_zip_code' => 13,'invalid_zip_code4' => 14,'invalid_phone' => 15,'invalid_secondary_phone' => 16,'invalid_unit_flag' => 17,'invalid_relationship_code' => 18,'invalid_industry_type' => 19,'invalid_sic_code' => 20,'invalid_unit_flag_exp' => 21,'invalid_relationship_code_exp' => 22,'invalid_fname' => 23,'invalid_mname' => 24,'invalid_lname' => 25,'invalid_direction' => 26,'invalid_cart' => 27,'invalid_cr_sort_sz' => 28,'invalid_lot' => 29,'invalid_lot_order' => 30,'invalid_dbpc' => 31,'invalid_chk_digit' => 32,'invalid_rec_type' => 33,'invalid_fips_state' => 34,'invalid_fips_county' => 35,'invalid_geo' => 36,'invalid_msa' => 37,'invalid_geo_blk' => 38,'invalid_geo_match' => 39,'invalid_err_stat' => 40,'invalid_raw_aid' => 41,'invalid_ace_aid' => 42,'invalid_source_rec_id' => 43,0);
 
EXPORT MakeFT_invalid_mandatory(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_populated_strings(s)>0);
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_populated_strings'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zero_integer(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zero_integer(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['0','']);
EXPORT InValidMessageFT_invalid_zero_integer(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('0|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_nonempty_number(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_nonempty_number(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_nonempty_number(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_percentage(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_percentage(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_range_numeric(s,0,100)>0);
EXPORT InValidMessageFT_invalid_percentage(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_range_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate8(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate8(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate8(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_past_yyyymmdd'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate08(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate08(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_optional_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate08(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_optional_past_yyyymmdd'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['H','']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('H|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_franchisee_id(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_franchisee_id(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_numeric(s,6)>0);
EXPORT InValidMessageFT_invalid_franchisee_id(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fruns(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fruns(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_fruns(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_name(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_name(SALT38.StrType s,SALT38.StrType fname,SALT38.StrType mname,SALT38.StrType lname) := WHICH(~Scrubs_Frandx.Functions.fn_populated_strings(s,fname,mname,lname)>0);
EXPORT InValidMessageFT_invalid_company_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_populated_strings'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_verify_state'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip_code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip_code(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_zip_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip_code4(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip_code4(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_verify_zip4(s)>0);
EXPORT InValidMessageFT_invalid_zip_code4(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_verify_zip4'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_verify_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_verify_phone'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_secondary_phone(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_secondary_phone(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_verify_2nd_phone(s)>0);
EXPORT InValidMessageFT_invalid_secondary_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_verify_2nd_phone'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_unit_flag(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_unit_flag(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_unit_flag(s)>0);
EXPORT InValidMessageFT_invalid_unit_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_unit_flag'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_relationship_code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_relationship_code(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_relationship_code(s)>0);
EXPORT InValidMessageFT_invalid_relationship_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_relationship_code'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_industry_type(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_industry_type(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_industry_type(s)>0);
EXPORT InValidMessageFT_invalid_industry_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_industry_type'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic_code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic_code(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_sic_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_unit_flag_exp(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_unit_flag_exp(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_unit_flag_exp(s)>0);
EXPORT InValidMessageFT_invalid_unit_flag_exp(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_unit_flag_exp'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_relationship_code_exp(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_relationship_code_exp(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_relationship_code_exp(s)>0);
EXPORT InValidMessageFT_invalid_relationship_code_exp(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_relationship_code_exp'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fname(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fname(SALT38.StrType s,SALT38.StrType mname,SALT38.StrType lname,SALT38.StrType company_name) := WHICH(~Scrubs_Frandx.Functions.fn_populated_strings(s,mname,lname,company_name)>0);
EXPORT InValidMessageFT_invalid_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_populated_strings'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mname(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mname(SALT38.StrType s,SALT38.StrType fname,SALT38.StrType lname,SALT38.StrType company_name) := WHICH(~Scrubs_Frandx.Functions.fn_populated_strings(s,fname,lname,company_name)>0);
EXPORT InValidMessageFT_invalid_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_populated_strings'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lname(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lname(SALT38.StrType s,SALT38.StrType fname,SALT38.StrType mname,SALT38.StrType company_name) := WHICH(~Scrubs_Frandx.Functions.fn_populated_strings(s,fname,mname,company_name)>0);
EXPORT InValidMessageFT_invalid_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_populated_strings'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_direction(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_direction(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['E','N','S','W','NE','NW','SE','SW','']);
EXPORT InValidMessageFT_invalid_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('E|N|S|W|NE|NW|SE|SW|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cart(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cart(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_alphanum(s,4)>0);
EXPORT InValidMessageFT_invalid_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_alphanum'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cr_sort_sz(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cr_sort_sz(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['A','B','C','D','']);
EXPORT InValidMessageFT_invalid_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('A|B|C|D|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot_order(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot_order(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['A','D','']);
EXPORT InValidMessageFT_invalid_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('A|D|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dbpc(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dbpc(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_dbpc(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_chk_digit(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_chk_digit(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_rec_type(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rec_type(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_addr_rec_type(s)>0);
EXPORT InValidMessageFT_invalid_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_addr_rec_type'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_state(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_state(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_fips_state(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_county(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_county(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_numeric(s,3)>0);
EXPORT InValidMessageFT_invalid_fips_county(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'-.0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_geo(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'-.0123456789'))));
EXPORT InValidMessageFT_invalid_geo(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('-.0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_msa(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_msa(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_blk(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo_blk(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_numeric(s,7)>0);
EXPORT InValidMessageFT_invalid_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_match(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo_match(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_err_stat(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_err_stat(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_alphanum(s,4)>0);
EXPORT InValidMessageFT_invalid_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_alphanum'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_raw_aid(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_raw_aid(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_numeric(s,13)>0);
EXPORT InValidMessageFT_invalid_raw_aid(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ace_aid(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ace_aid(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_numeric(s,12)>0);
EXPORT InValidMessageFT_invalid_ace_aid(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_source_rec_id(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_source_rec_id(SALT38.StrType s) := WHICH(~Scrubs_Frandx.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_source_rec_id(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Frandx.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','bdid','bdid_score','did','did_score','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','franchisee_id','brand_name','fruns','company_name','exec_full_name','address1','address2','city','state','zip_code','zip_code4','phone','phone_extension','secondary_phone','unit_flag','relationship_code','f_units','website_url','email','industry','sector','industry_type','sic_code','frn_start_date','record_id','unit_flag_exp','relationship_code_exp','clean_phone','clean_secondary_phone','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_addr_line1','prep_addr_line_last','source_rec_id');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','bdid','bdid_score','did','did_score','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','franchisee_id','brand_name','fruns','company_name','exec_full_name','address1','address2','city','state','zip_code','zip_code4','phone','phone_extension','secondary_phone','unit_flag','relationship_code','f_units','website_url','email','industry','sector','industry_type','sic_code','frn_start_date','record_id','unit_flag_exp','relationship_code_exp','clean_phone','clean_secondary_phone','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_addr_line1','prep_addr_line_last','source_rec_id');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'dotid' => 0,'dotscore' => 1,'dotweight' => 2,'empid' => 3,'empscore' => 4,'empweight' => 5,'powid' => 6,'powscore' => 7,'powweight' => 8,'proxid' => 9,'proxscore' => 10,'proxweight' => 11,'seleid' => 12,'selescore' => 13,'seleweight' => 14,'orgid' => 15,'orgscore' => 16,'orgweight' => 17,'ultid' => 18,'ultscore' => 19,'ultweight' => 20,'bdid' => 21,'bdid_score' => 22,'did' => 23,'did_score' => 24,'dt_first_seen' => 25,'dt_last_seen' => 26,'dt_vendor_first_reported' => 27,'dt_vendor_last_reported' => 28,'record_type' => 29,'franchisee_id' => 30,'brand_name' => 31,'fruns' => 32,'company_name' => 33,'exec_full_name' => 34,'address1' => 35,'address2' => 36,'city' => 37,'state' => 38,'zip_code' => 39,'zip_code4' => 40,'phone' => 41,'phone_extension' => 42,'secondary_phone' => 43,'unit_flag' => 44,'relationship_code' => 45,'f_units' => 46,'website_url' => 47,'email' => 48,'industry' => 49,'sector' => 50,'industry_type' => 51,'sic_code' => 52,'frn_start_date' => 53,'record_id' => 54,'unit_flag_exp' => 55,'relationship_code_exp' => 56,'clean_phone' => 57,'clean_secondary_phone' => 58,'title' => 59,'fname' => 60,'mname' => 61,'lname' => 62,'name_suffix' => 63,'name_score' => 64,'prim_range' => 65,'predir' => 66,'prim_name' => 67,'addr_suffix' => 68,'postdir' => 69,'unit_desig' => 70,'sec_range' => 71,'p_city_name' => 72,'v_city_name' => 73,'st' => 74,'zip' => 75,'zip4' => 76,'cart' => 77,'cr_sort_sz' => 78,'lot' => 79,'lot_order' => 80,'dbpc' => 81,'chk_digit' => 82,'rec_type' => 83,'fips_state' => 84,'fips_county' => 85,'geo_lat' => 86,'geo_long' => 87,'msa' => 88,'geo_blk' => 89,'geo_match' => 90,'err_stat' => 91,'raw_aid' => 92,'ace_aid' => 93,'prep_addr_line1' => 94,'prep_addr_line_last' => 95,'source_rec_id' => 96,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],['ENUM'],['CUSTOM'],[],['ENUM'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
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
 
EXPORT Make_powid(SALT38.StrType s0) := MakeFT_invalid_nonempty_number(s0);
EXPORT InValid_powid(SALT38.StrType s) := InValidFT_invalid_nonempty_number(s);
EXPORT InValidMessage_powid(UNSIGNED1 wh) := InValidMessageFT_invalid_nonempty_number(wh);
 
EXPORT Make_powscore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_powscore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_powweight(SALT38.StrType s0) := MakeFT_invalid_nonempty_number(s0);
EXPORT InValid_powweight(SALT38.StrType s) := InValidFT_invalid_nonempty_number(s);
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := InValidMessageFT_invalid_nonempty_number(wh);
 
EXPORT Make_proxid(SALT38.StrType s0) := MakeFT_invalid_nonempty_number(s0);
EXPORT InValid_proxid(SALT38.StrType s) := InValidFT_invalid_nonempty_number(s);
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := InValidMessageFT_invalid_nonempty_number(wh);
 
EXPORT Make_proxscore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_proxscore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_proxweight(SALT38.StrType s0) := MakeFT_invalid_nonempty_number(s0);
EXPORT InValid_proxweight(SALT38.StrType s) := InValidFT_invalid_nonempty_number(s);
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := InValidMessageFT_invalid_nonempty_number(wh);
 
EXPORT Make_seleid(SALT38.StrType s0) := MakeFT_invalid_nonempty_number(s0);
EXPORT InValid_seleid(SALT38.StrType s) := InValidFT_invalid_nonempty_number(s);
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := InValidMessageFT_invalid_nonempty_number(wh);
 
EXPORT Make_selescore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_selescore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_seleweight(SALT38.StrType s0) := MakeFT_invalid_nonempty_number(s0);
EXPORT InValid_seleweight(SALT38.StrType s) := InValidFT_invalid_nonempty_number(s);
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := InValidMessageFT_invalid_nonempty_number(wh);
 
EXPORT Make_orgid(SALT38.StrType s0) := MakeFT_invalid_nonempty_number(s0);
EXPORT InValid_orgid(SALT38.StrType s) := InValidFT_invalid_nonempty_number(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_invalid_nonempty_number(wh);
 
EXPORT Make_orgscore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_orgscore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_orgweight(SALT38.StrType s0) := MakeFT_invalid_nonempty_number(s0);
EXPORT InValid_orgweight(SALT38.StrType s) := InValidFT_invalid_nonempty_number(s);
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := InValidMessageFT_invalid_nonempty_number(wh);
 
EXPORT Make_ultid(SALT38.StrType s0) := MakeFT_invalid_nonempty_number(s0);
EXPORT InValid_ultid(SALT38.StrType s) := InValidFT_invalid_nonempty_number(s);
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := InValidMessageFT_invalid_nonempty_number(wh);
 
EXPORT Make_ultscore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_ultscore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_ultweight(SALT38.StrType s0) := MakeFT_invalid_nonempty_number(s0);
EXPORT InValid_ultweight(SALT38.StrType s) := InValidFT_invalid_nonempty_number(s);
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := InValidMessageFT_invalid_nonempty_number(wh);
 
EXPORT Make_bdid(SALT38.StrType s0) := MakeFT_invalid_nonempty_number(s0);
EXPORT InValid_bdid(SALT38.StrType s) := InValidFT_invalid_nonempty_number(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_invalid_nonempty_number(wh);
 
EXPORT Make_bdid_score(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_bdid_score(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_bdid_score(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_did(SALT38.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_did(SALT38.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_did_score(SALT38.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_did_score(SALT38.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_dt_first_seen(SALT38.StrType s0) := MakeFT_invalid_pastdate08(s0);
EXPORT InValid_dt_first_seen(SALT38.StrType s) := InValidFT_invalid_pastdate08(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate08(wh);
 
EXPORT Make_dt_last_seen(SALT38.StrType s0) := MakeFT_invalid_pastdate08(s0);
EXPORT InValid_dt_last_seen(SALT38.StrType s) := InValidFT_invalid_pastdate08(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate08(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT38.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_dt_vendor_first_reported(SALT38.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT38.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_dt_vendor_last_reported(SALT38.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_record_type(SALT38.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT38.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_franchisee_id(SALT38.StrType s0) := MakeFT_invalid_franchisee_id(s0);
EXPORT InValid_franchisee_id(SALT38.StrType s) := InValidFT_invalid_franchisee_id(s);
EXPORT InValidMessage_franchisee_id(UNSIGNED1 wh) := InValidMessageFT_invalid_franchisee_id(wh);
 
EXPORT Make_brand_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_brand_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_brand_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_fruns(SALT38.StrType s0) := MakeFT_invalid_fruns(s0);
EXPORT InValid_fruns(SALT38.StrType s) := InValidFT_invalid_fruns(s);
EXPORT InValidMessage_fruns(UNSIGNED1 wh) := InValidMessageFT_invalid_fruns(wh);
 
EXPORT Make_company_name(SALT38.StrType s0) := MakeFT_invalid_company_name(s0);
EXPORT InValid_company_name(SALT38.StrType s,SALT38.StrType fname,SALT38.StrType mname,SALT38.StrType lname) := InValidFT_invalid_company_name(s,fname,mname,lname);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_company_name(wh);
 
EXPORT Make_exec_full_name(SALT38.StrType s0) := s0;
EXPORT InValid_exec_full_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_exec_full_name(UNSIGNED1 wh) := '';
 
EXPORT Make_address1(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_address1(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_address2(SALT38.StrType s0) := s0;
EXPORT InValid_address2(SALT38.StrType s) := 0;
EXPORT InValidMessage_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_city(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_state(SALT38.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT38.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip_code(SALT38.StrType s0) := MakeFT_invalid_zip_code(s0);
EXPORT InValid_zip_code(SALT38.StrType s) := InValidFT_invalid_zip_code(s);
EXPORT InValidMessage_zip_code(UNSIGNED1 wh) := InValidMessageFT_invalid_zip_code(wh);
 
EXPORT Make_zip_code4(SALT38.StrType s0) := MakeFT_invalid_zip_code4(s0);
EXPORT InValid_zip_code4(SALT38.StrType s) := InValidFT_invalid_zip_code4(s);
EXPORT InValidMessage_zip_code4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip_code4(wh);
 
EXPORT Make_phone(SALT38.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone(SALT38.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_phone_extension(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_phone_extension(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_phone_extension(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_secondary_phone(SALT38.StrType s0) := MakeFT_invalid_secondary_phone(s0);
EXPORT InValid_secondary_phone(SALT38.StrType s) := InValidFT_invalid_secondary_phone(s);
EXPORT InValidMessage_secondary_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_secondary_phone(wh);
 
EXPORT Make_unit_flag(SALT38.StrType s0) := MakeFT_invalid_unit_flag(s0);
EXPORT InValid_unit_flag(SALT38.StrType s) := InValidFT_invalid_unit_flag(s);
EXPORT InValidMessage_unit_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_unit_flag(wh);
 
EXPORT Make_relationship_code(SALT38.StrType s0) := MakeFT_invalid_relationship_code(s0);
EXPORT InValid_relationship_code(SALT38.StrType s) := InValidFT_invalid_relationship_code(s);
EXPORT InValidMessage_relationship_code(UNSIGNED1 wh) := InValidMessageFT_invalid_relationship_code(wh);
 
EXPORT Make_f_units(SALT38.StrType s0) := MakeFT_invalid_nonempty_number(s0);
EXPORT InValid_f_units(SALT38.StrType s) := InValidFT_invalid_nonempty_number(s);
EXPORT InValidMessage_f_units(UNSIGNED1 wh) := InValidMessageFT_invalid_nonempty_number(wh);
 
EXPORT Make_website_url(SALT38.StrType s0) := s0;
EXPORT InValid_website_url(SALT38.StrType s) := 0;
EXPORT InValidMessage_website_url(UNSIGNED1 wh) := '';
 
EXPORT Make_email(SALT38.StrType s0) := s0;
EXPORT InValid_email(SALT38.StrType s) := 0;
EXPORT InValidMessage_email(UNSIGNED1 wh) := '';
 
EXPORT Make_industry(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_industry(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_industry(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_sector(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_sector(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_sector(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_industry_type(SALT38.StrType s0) := MakeFT_invalid_industry_type(s0);
EXPORT InValid_industry_type(SALT38.StrType s) := InValidFT_invalid_industry_type(s);
EXPORT InValidMessage_industry_type(UNSIGNED1 wh) := InValidMessageFT_invalid_industry_type(wh);
 
EXPORT Make_sic_code(SALT38.StrType s0) := MakeFT_invalid_sic_code(s0);
EXPORT InValid_sic_code(SALT38.StrType s) := InValidFT_invalid_sic_code(s);
EXPORT InValidMessage_sic_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sic_code(wh);
 
EXPORT Make_frn_start_date(SALT38.StrType s0) := s0;
EXPORT InValid_frn_start_date(SALT38.StrType s) := 0;
EXPORT InValidMessage_frn_start_date(UNSIGNED1 wh) := '';
 
EXPORT Make_record_id(SALT38.StrType s0) := MakeFT_invalid_nonempty_number(s0);
EXPORT InValid_record_id(SALT38.StrType s) := InValidFT_invalid_nonempty_number(s);
EXPORT InValidMessage_record_id(UNSIGNED1 wh) := InValidMessageFT_invalid_nonempty_number(wh);
 
EXPORT Make_unit_flag_exp(SALT38.StrType s0) := MakeFT_invalid_unit_flag_exp(s0);
EXPORT InValid_unit_flag_exp(SALT38.StrType s) := InValidFT_invalid_unit_flag_exp(s);
EXPORT InValidMessage_unit_flag_exp(UNSIGNED1 wh) := InValidMessageFT_invalid_unit_flag_exp(wh);
 
EXPORT Make_relationship_code_exp(SALT38.StrType s0) := MakeFT_invalid_relationship_code_exp(s0);
EXPORT InValid_relationship_code_exp(SALT38.StrType s) := InValidFT_invalid_relationship_code_exp(s);
EXPORT InValidMessage_relationship_code_exp(UNSIGNED1 wh) := InValidMessageFT_invalid_relationship_code_exp(wh);
 
EXPORT Make_clean_phone(SALT38.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_clean_phone(SALT38.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_clean_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_clean_secondary_phone(SALT38.StrType s0) := MakeFT_invalid_secondary_phone(s0);
EXPORT InValid_clean_secondary_phone(SALT38.StrType s) := InValidFT_invalid_secondary_phone(s);
EXPORT InValidMessage_clean_secondary_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_secondary_phone(wh);
 
EXPORT Make_title(SALT38.StrType s0) := s0;
EXPORT InValid_title(SALT38.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT38.StrType s0) := MakeFT_invalid_fname(s0);
EXPORT InValid_fname(SALT38.StrType s,SALT38.StrType mname,SALT38.StrType lname,SALT38.StrType company_name) := InValidFT_invalid_fname(s,mname,lname,company_name);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_fname(wh);
 
EXPORT Make_mname(SALT38.StrType s0) := MakeFT_invalid_mname(s0);
EXPORT InValid_mname(SALT38.StrType s,SALT38.StrType fname,SALT38.StrType lname,SALT38.StrType company_name) := InValidFT_invalid_mname(s,fname,lname,company_name);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_mname(wh);
 
EXPORT Make_lname(SALT38.StrType s0) := MakeFT_invalid_lname(s0);
EXPORT InValid_lname(SALT38.StrType s,SALT38.StrType fname,SALT38.StrType mname,SALT38.StrType company_name) := InValidFT_invalid_lname(s,fname,mname,company_name);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_lname(wh);
 
EXPORT Make_name_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_name_score(SALT38.StrType s0) := s0;
EXPORT InValid_name_score(SALT38.StrType s) := 0;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_st(SALT38.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_st(SALT38.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip(SALT38.StrType s0) := MakeFT_invalid_zip_code(s0);
EXPORT InValid_zip(SALT38.StrType s) := InValidFT_invalid_zip_code(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip_code(wh);
 
EXPORT Make_zip4(SALT38.StrType s0) := MakeFT_invalid_zip_code4(s0);
EXPORT InValid_zip4(SALT38.StrType s) := InValidFT_invalid_zip_code4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip_code4(wh);
 
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
 
EXPORT Make_dbpc(SALT38.StrType s0) := MakeFT_invalid_dbpc(s0);
EXPORT InValid_dbpc(SALT38.StrType s) := InValidFT_invalid_dbpc(s);
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := InValidMessageFT_invalid_dbpc(wh);
 
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
 
EXPORT Make_source_rec_id(SALT38.StrType s0) := MakeFT_invalid_source_rec_id(s0);
EXPORT InValid_source_rec_id(SALT38.StrType s) := InValidFT_invalid_source_rec_id(s);
EXPORT InValidMessage_source_rec_id(UNSIGNED1 wh) := InValidMessageFT_invalid_source_rec_id(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_Frandx;
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
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_bdid_score;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_franchisee_id;
    BOOLEAN Diff_brand_name;
    BOOLEAN Diff_fruns;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_exec_full_name;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip_code;
    BOOLEAN Diff_zip_code4;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_phone_extension;
    BOOLEAN Diff_secondary_phone;
    BOOLEAN Diff_unit_flag;
    BOOLEAN Diff_relationship_code;
    BOOLEAN Diff_f_units;
    BOOLEAN Diff_website_url;
    BOOLEAN Diff_email;
    BOOLEAN Diff_industry;
    BOOLEAN Diff_sector;
    BOOLEAN Diff_industry_type;
    BOOLEAN Diff_sic_code;
    BOOLEAN Diff_frn_start_date;
    BOOLEAN Diff_record_id;
    BOOLEAN Diff_unit_flag_exp;
    BOOLEAN Diff_relationship_code_exp;
    BOOLEAN Diff_clean_phone;
    BOOLEAN Diff_clean_secondary_phone;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
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
    BOOLEAN Diff_source_rec_id;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
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
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_bdid_score := le.bdid_score <> ri.bdid_score;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_franchisee_id := le.franchisee_id <> ri.franchisee_id;
    SELF.Diff_brand_name := le.brand_name <> ri.brand_name;
    SELF.Diff_fruns := le.fruns <> ri.fruns;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_exec_full_name := le.exec_full_name <> ri.exec_full_name;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip_code := le.zip_code <> ri.zip_code;
    SELF.Diff_zip_code4 := le.zip_code4 <> ri.zip_code4;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_phone_extension := le.phone_extension <> ri.phone_extension;
    SELF.Diff_secondary_phone := le.secondary_phone <> ri.secondary_phone;
    SELF.Diff_unit_flag := le.unit_flag <> ri.unit_flag;
    SELF.Diff_relationship_code := le.relationship_code <> ri.relationship_code;
    SELF.Diff_f_units := le.f_units <> ri.f_units;
    SELF.Diff_website_url := le.website_url <> ri.website_url;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_industry := le.industry <> ri.industry;
    SELF.Diff_sector := le.sector <> ri.sector;
    SELF.Diff_industry_type := le.industry_type <> ri.industry_type;
    SELF.Diff_sic_code := le.sic_code <> ri.sic_code;
    SELF.Diff_frn_start_date := le.frn_start_date <> ri.frn_start_date;
    SELF.Diff_record_id := le.record_id <> ri.record_id;
    SELF.Diff_unit_flag_exp := le.unit_flag_exp <> ri.unit_flag_exp;
    SELF.Diff_relationship_code_exp := le.relationship_code_exp <> ri.relationship_code_exp;
    SELF.Diff_clean_phone := le.clean_phone <> ri.clean_phone;
    SELF.Diff_clean_secondary_phone := le.clean_secondary_phone <> ri.clean_secondary_phone;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
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
    SELF.Diff_source_rec_id := le.source_rec_id <> ri.source_rec_id;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_bdid_score,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_franchisee_id,1,0)+ IF( SELF.Diff_brand_name,1,0)+ IF( SELF.Diff_fruns,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_exec_full_name,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip_code,1,0)+ IF( SELF.Diff_zip_code4,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_phone_extension,1,0)+ IF( SELF.Diff_secondary_phone,1,0)+ IF( SELF.Diff_unit_flag,1,0)+ IF( SELF.Diff_relationship_code,1,0)+ IF( SELF.Diff_f_units,1,0)+ IF( SELF.Diff_website_url,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_industry,1,0)+ IF( SELF.Diff_sector,1,0)+ IF( SELF.Diff_industry_type,1,0)+ IF( SELF.Diff_sic_code,1,0)+ IF( SELF.Diff_frn_start_date,1,0)+ IF( SELF.Diff_record_id,1,0)+ IF( SELF.Diff_unit_flag_exp,1,0)+ IF( SELF.Diff_relationship_code_exp,1,0)+ IF( SELF.Diff_clean_phone,1,0)+ IF( SELF.Diff_clean_secondary_phone,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_state,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_raw_aid,1,0)+ IF( SELF.Diff_ace_aid,1,0)+ IF( SELF.Diff_prep_addr_line1,1,0)+ IF( SELF.Diff_prep_addr_line_last,1,0)+ IF( SELF.Diff_source_rec_id,1,0);
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
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_bdid_score := COUNT(GROUP,%Closest%.Diff_bdid_score);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_franchisee_id := COUNT(GROUP,%Closest%.Diff_franchisee_id);
    Count_Diff_brand_name := COUNT(GROUP,%Closest%.Diff_brand_name);
    Count_Diff_fruns := COUNT(GROUP,%Closest%.Diff_fruns);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_exec_full_name := COUNT(GROUP,%Closest%.Diff_exec_full_name);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip_code := COUNT(GROUP,%Closest%.Diff_zip_code);
    Count_Diff_zip_code4 := COUNT(GROUP,%Closest%.Diff_zip_code4);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_phone_extension := COUNT(GROUP,%Closest%.Diff_phone_extension);
    Count_Diff_secondary_phone := COUNT(GROUP,%Closest%.Diff_secondary_phone);
    Count_Diff_unit_flag := COUNT(GROUP,%Closest%.Diff_unit_flag);
    Count_Diff_relationship_code := COUNT(GROUP,%Closest%.Diff_relationship_code);
    Count_Diff_f_units := COUNT(GROUP,%Closest%.Diff_f_units);
    Count_Diff_website_url := COUNT(GROUP,%Closest%.Diff_website_url);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_industry := COUNT(GROUP,%Closest%.Diff_industry);
    Count_Diff_sector := COUNT(GROUP,%Closest%.Diff_sector);
    Count_Diff_industry_type := COUNT(GROUP,%Closest%.Diff_industry_type);
    Count_Diff_sic_code := COUNT(GROUP,%Closest%.Diff_sic_code);
    Count_Diff_frn_start_date := COUNT(GROUP,%Closest%.Diff_frn_start_date);
    Count_Diff_record_id := COUNT(GROUP,%Closest%.Diff_record_id);
    Count_Diff_unit_flag_exp := COUNT(GROUP,%Closest%.Diff_unit_flag_exp);
    Count_Diff_relationship_code_exp := COUNT(GROUP,%Closest%.Diff_relationship_code_exp);
    Count_Diff_clean_phone := COUNT(GROUP,%Closest%.Diff_clean_phone);
    Count_Diff_clean_secondary_phone := COUNT(GROUP,%Closest%.Diff_clean_secondary_phone);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
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
    Count_Diff_source_rec_id := COUNT(GROUP,%Closest%.Diff_source_rec_id);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

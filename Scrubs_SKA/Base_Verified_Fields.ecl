IMPORT SALT311;
IMPORT Scrubs_SKA; // Import modules for FieldTypes attribute definitions
EXPORT Base_Verified_Fields := MODULE
 
EXPORT NumFields := 114;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_numeric','invalid_mandatory','invalid_boolean','invalid_pastdate8','invalid_direction','invalid_geo_coord','invalid_deptcode','invalid_dept_expl','invalid_state','invalid_zip','invalid_address2','invalid_city2','invalid_state2','invalid_zip2','invalid_fips','invalid_phone','invalid_spec','invalid_spec_expl','invalid_spec2','invalid_spec2_expl','invalid_spec3','invalid_spec3_expl','invalid_owner','invalid_mail_p_city_name','invalid_mail_v_city_name','invalid_mail_st','invalid_mail_zip','invalid_mail_zip4','invalid_mail_ace_fips_state','invalid_alt_prim_name','invalid_alt_p_city_name','invalid_alt_v_city_name','invalid_alt_st','invalid_alt_zip','invalid_alt_zip4','invalid_alt_ace_fips_state');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_numeric' => 1,'invalid_mandatory' => 2,'invalid_boolean' => 3,'invalid_pastdate8' => 4,'invalid_direction' => 5,'invalid_geo_coord' => 6,'invalid_deptcode' => 7,'invalid_dept_expl' => 8,'invalid_state' => 9,'invalid_zip' => 10,'invalid_address2' => 11,'invalid_city2' => 12,'invalid_state2' => 13,'invalid_zip2' => 14,'invalid_fips' => 15,'invalid_phone' => 16,'invalid_spec' => 17,'invalid_spec_expl' => 18,'invalid_spec2' => 19,'invalid_spec2_expl' => 20,'invalid_spec3' => 21,'invalid_spec3_expl' => 22,'invalid_owner' => 23,'invalid_mail_p_city_name' => 24,'invalid_mail_v_city_name' => 25,'invalid_mail_st' => 26,'invalid_mail_zip' => 27,'invalid_mail_zip4' => 28,'invalid_mail_ace_fips_state' => 29,'invalid_alt_prim_name' => 30,'invalid_alt_p_city_name' => 31,'invalid_alt_v_city_name' => 32,'invalid_alt_st' => 33,'invalid_alt_zip' => 34,'invalid_alt_zip4' => 35,'invalid_alt_ace_fips_state' => 36,0);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_populated_strings(s)>0);
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_boolean(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_boolean(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['N','Y','']);
EXPORT InValidMessageFT_invalid_boolean(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('N|Y|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate8(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate8(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate8(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_past_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_direction(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ENSW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_direction(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ENSW'))));
EXPORT InValidMessageFT_invalid_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ENSW'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_coord(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo_coord(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_geo_coord(s)>0);
EXPORT InValidMessageFT_invalid_geo_coord(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_geo_coord'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_deptcode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_deptcode(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_alpha_opt(s,3)>0);
EXPORT InValidMessageFT_invalid_deptcode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_alpha_opt'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dept_expl(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dept_expl(SALT311.StrType s,SALT311.StrType deptcode) := WHICH(~Scrubs_SKA.Functions.fn_str1_xor_str2(s,deptcode)>0);
EXPORT InValidMessageFT_invalid_dept_expl(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_verify_zip(s)>0);
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_verify_zip'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address2(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_address2(SALT311.StrType s,SALT311.StrType address1) := WHICH(~Scrubs_SKA.Functions.fn_str1_only_if_str2(s,address1)>0);
EXPORT InValidMessageFT_invalid_address2(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_str1_only_if_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_city2(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_city2(SALT311.StrType s,SALT311.StrType address2) := WHICH(~Scrubs_SKA.Functions.fn_str1_xor_str2(s,address2)>0);
EXPORT InValidMessageFT_invalid_city2(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state2(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state2(SALT311.StrType s,SALT311.StrType address2) := WHICH(~Scrubs_SKA.Functions.fn_str1_xor_str2(s,address2)>0);
EXPORT InValidMessageFT_invalid_state2(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip2(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip2(SALT311.StrType s,SALT311.StrType address2) := WHICH(~Scrubs_SKA.Functions.fn_str1_xor_str2(s,address2)>0);
EXPORT InValidMessageFT_invalid_zip2(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_fips(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_verify_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_verify_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_spec(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_spec(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_alpha_opt(s,3)>0);
EXPORT InValidMessageFT_invalid_spec(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_alpha_opt'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_spec_expl(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_spec_expl(SALT311.StrType s,SALT311.StrType spec) := WHICH(~Scrubs_SKA.Functions.fn_str1_xor_str2(s,spec)>0);
EXPORT InValidMessageFT_invalid_spec_expl(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_spec2(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_spec2(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_alpha_opt(s,3)>0);
EXPORT InValidMessageFT_invalid_spec2(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_alpha_opt'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_spec2_expl(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_spec2_expl(SALT311.StrType s,SALT311.StrType spec2) := WHICH(~Scrubs_SKA.Functions.fn_spec_expl(s,spec2)>0);
EXPORT InValidMessageFT_invalid_spec2_expl(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_spec_expl'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_spec3(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_spec3(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_alpha_opt(s,3)>0);
EXPORT InValidMessageFT_invalid_spec3(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_alpha_opt'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_spec3_expl(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_spec3_expl(SALT311.StrType s,SALT311.StrType spec3) := WHICH(~Scrubs_SKA.Functions.fn_spec_expl(s,spec3)>0);
EXPORT InValidMessageFT_invalid_spec3_expl(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_spec_expl'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_owner(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_owner(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_alpha(s,3)>0);
EXPORT InValidMessageFT_invalid_owner(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_alpha'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mail_p_city_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mail_p_city_name(SALT311.StrType s,SALT311.StrType mail_v_city_name) := WHICH(~Scrubs_SKA.Functions.fn_populated_strings(s,mail_v_city_name)>0);
EXPORT InValidMessageFT_invalid_mail_p_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mail_v_city_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mail_v_city_name(SALT311.StrType s,SALT311.StrType mail_p_city_name) := WHICH(~Scrubs_SKA.Functions.fn_populated_strings(s,mail_p_city_name)>0);
EXPORT InValidMessageFT_invalid_mail_v_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mail_st(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mail_st(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_mail_st(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mail_zip(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mail_zip(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_mail_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mail_zip4(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mail_zip4(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_numeric_opt(s,4)>0);
EXPORT InValidMessageFT_invalid_mail_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_numeric_opt'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mail_ace_fips_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mail_ace_fips_state(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_mail_ace_fips_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alt_prim_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_alt_prim_name(SALT311.StrType s,SALT311.StrType address2) := WHICH(~Scrubs_SKA.Functions.fn_str1_xor_str2(s,address2)>0);
EXPORT InValidMessageFT_invalid_alt_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alt_p_city_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_alt_p_city_name(SALT311.StrType s,SALT311.StrType alt_st,SALT311.StrType alt_zip) := WHICH(~Scrubs_SKA.Functions.fn_str1_xor_str2_xor_str3(s,alt_st,alt_zip)>0);
EXPORT InValidMessageFT_invalid_alt_p_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_str1_xor_str2_xor_str3'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alt_v_city_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_alt_v_city_name(SALT311.StrType s,SALT311.StrType alt_st,SALT311.StrType alt_zip) := WHICH(~Scrubs_SKA.Functions.fn_str1_xor_str2_xor_str3(s,alt_st,alt_zip)>0);
EXPORT InValidMessageFT_invalid_alt_v_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_str1_xor_str2_xor_str3'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alt_st(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_alt_st(SALT311.StrType s,SALT311.StrType alt_p_city_name,SALT311.StrType alt_zip) := WHICH(~Scrubs_SKA.Functions.fn_str1_xor_str2_xor_str3(s,alt_p_city_name,alt_zip)>0);
EXPORT InValidMessageFT_invalid_alt_st(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_str1_xor_str2_xor_str3'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alt_zip(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_alt_zip(SALT311.StrType s,SALT311.StrType alt_v_city_name,SALT311.StrType alt_st) := WHICH(~Scrubs_SKA.Functions.fn_str1_xor_str2_xor_str3(s,alt_v_city_name,alt_st)>0);
EXPORT InValidMessageFT_invalid_alt_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_str1_xor_str2_xor_str3'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alt_zip4(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_alt_zip4(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_numeric_opt(s,4)>0);
EXPORT InValidMessageFT_invalid_alt_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_numeric_opt'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alt_ace_fips_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_alt_ace_fips_state(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_numeric_opt(s,2)>0);
EXPORT InValidMessageFT_invalid_alt_ace_fips_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_numeric_opt'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'id_ska','bdid','ttl','first_name','middle','last_name','t1','do','deptcode','dept_expl','key_file','company1','address1','city','state','zip','address2','city2','state2','zip2','fips','phone','spec','spec_expl','spec2','spec2_expl','spec3','spec3_expl','persid','owner','emailavail','title','fname','mname','lname','name_suffix','name_score','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dbpc','mail_chk_digit','mail_rec_type','mail_ace_fips_state','mail_county','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat','alt_prim_range','alt_predir','alt_prim_name','alt_addr_suffix','alt_postdir','alt_unit_desig','alt_sec_range','alt_p_city_name','alt_v_city_name','alt_st','alt_zip','alt_zip4','alt_cart','alt_cr_sort_sz','alt_lot','alt_lot_order','alt_dbpc','alt_chk_digit','alt_rec_type','alt_ace_fips_state','alt_county','alt_geo_lat','alt_geo_long','alt_msa','alt_geo_blk','alt_geo_match','alt_err_stat','lf','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'id_ska','bdid','ttl','first_name','middle','last_name','t1','do','deptcode','dept_expl','key_file','company1','address1','city','state','zip','address2','city2','state2','zip2','fips','phone','spec','spec_expl','spec2','spec2_expl','spec3','spec3_expl','persid','owner','emailavail','title','fname','mname','lname','name_suffix','name_score','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dbpc','mail_chk_digit','mail_rec_type','mail_ace_fips_state','mail_county','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat','alt_prim_range','alt_predir','alt_prim_name','alt_addr_suffix','alt_postdir','alt_unit_desig','alt_sec_range','alt_p_city_name','alt_v_city_name','alt_st','alt_zip','alt_zip4','alt_cart','alt_cr_sort_sz','alt_lot','alt_lot_order','alt_dbpc','alt_chk_digit','alt_rec_type','alt_ace_fips_state','alt_county','alt_geo_lat','alt_geo_long','alt_msa','alt_geo_blk','alt_geo_match','alt_err_stat','lf','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'id_ska' => 0,'bdid' => 1,'ttl' => 2,'first_name' => 3,'middle' => 4,'last_name' => 5,'t1' => 6,'do' => 7,'deptcode' => 8,'dept_expl' => 9,'key_file' => 10,'company1' => 11,'address1' => 12,'city' => 13,'state' => 14,'zip' => 15,'address2' => 16,'city2' => 17,'state2' => 18,'zip2' => 19,'fips' => 20,'phone' => 21,'spec' => 22,'spec_expl' => 23,'spec2' => 24,'spec2_expl' => 25,'spec3' => 26,'spec3_expl' => 27,'persid' => 28,'owner' => 29,'emailavail' => 30,'title' => 31,'fname' => 32,'mname' => 33,'lname' => 34,'name_suffix' => 35,'name_score' => 36,'mail_prim_range' => 37,'mail_predir' => 38,'mail_prim_name' => 39,'mail_addr_suffix' => 40,'mail_postdir' => 41,'mail_unit_desig' => 42,'mail_sec_range' => 43,'mail_p_city_name' => 44,'mail_v_city_name' => 45,'mail_st' => 46,'mail_zip' => 47,'mail_zip4' => 48,'mail_cart' => 49,'mail_cr_sort_sz' => 50,'mail_lot' => 51,'mail_lot_order' => 52,'mail_dbpc' => 53,'mail_chk_digit' => 54,'mail_rec_type' => 55,'mail_ace_fips_state' => 56,'mail_county' => 57,'mail_geo_lat' => 58,'mail_geo_long' => 59,'mail_msa' => 60,'mail_geo_blk' => 61,'mail_geo_match' => 62,'mail_err_stat' => 63,'alt_prim_range' => 64,'alt_predir' => 65,'alt_prim_name' => 66,'alt_addr_suffix' => 67,'alt_postdir' => 68,'alt_unit_desig' => 69,'alt_sec_range' => 70,'alt_p_city_name' => 71,'alt_v_city_name' => 72,'alt_st' => 73,'alt_zip' => 74,'alt_zip4' => 75,'alt_cart' => 76,'alt_cr_sort_sz' => 77,'alt_lot' => 78,'alt_lot_order' => 79,'alt_dbpc' => 80,'alt_chk_digit' => 81,'alt_rec_type' => 82,'alt_ace_fips_state' => 83,'alt_county' => 84,'alt_geo_lat' => 85,'alt_geo_long' => 86,'alt_msa' => 87,'alt_geo_blk' => 88,'alt_geo_match' => 89,'alt_err_stat' => 90,'lf' => 91,'dotid' => 92,'dotscore' => 93,'dotweight' => 94,'empid' => 95,'empscore' => 96,'empweight' => 97,'powid' => 98,'powscore' => 99,'powweight' => 100,'proxid' => 101,'proxscore' => 102,'proxweight' => 103,'seleid' => 104,'selescore' => 105,'seleweight' => 106,'orgid' => 107,'orgscore' => 108,'orgweight' => 109,'ultid' => 110,'ultscore' => 111,'ultweight' => 112,'source_rec_id' => 113,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],[],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],[],['CUSTOM'],[],['CUSTOM'],[],[],[],['ALLOW'],['CUSTOM'],[],['ALLOW'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],[],[],[],[],[],['ALLOW'],['CUSTOM'],[],['ALLOW'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_id_ska(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_id_ska(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_id_ska(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_bdid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bdid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ttl(SALT311.StrType s0) := s0;
EXPORT InValid_ttl(SALT311.StrType s) := 0;
EXPORT InValidMessage_ttl(UNSIGNED1 wh) := '';
 
EXPORT Make_first_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_first_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_middle(SALT311.StrType s0) := s0;
EXPORT InValid_middle(SALT311.StrType s) := 0;
EXPORT InValidMessage_middle(UNSIGNED1 wh) := '';
 
EXPORT Make_last_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_last_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_t1(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_t1(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_t1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_do(SALT311.StrType s0) := MakeFT_invalid_boolean(s0);
EXPORT InValid_do(SALT311.StrType s) := InValidFT_invalid_boolean(s);
EXPORT InValidMessage_do(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean(wh);
 
EXPORT Make_deptcode(SALT311.StrType s0) := MakeFT_invalid_deptcode(s0);
EXPORT InValid_deptcode(SALT311.StrType s) := InValidFT_invalid_deptcode(s);
EXPORT InValidMessage_deptcode(UNSIGNED1 wh) := InValidMessageFT_invalid_deptcode(wh);
 
EXPORT Make_dept_expl(SALT311.StrType s0) := MakeFT_invalid_dept_expl(s0);
EXPORT InValid_dept_expl(SALT311.StrType s,SALT311.StrType deptcode) := InValidFT_invalid_dept_expl(s,deptcode);
EXPORT InValidMessage_dept_expl(UNSIGNED1 wh) := InValidMessageFT_invalid_dept_expl(wh);
 
EXPORT Make_key_file(SALT311.StrType s0) := s0;
EXPORT InValid_key_file(SALT311.StrType s) := 0;
EXPORT InValidMessage_key_file(UNSIGNED1 wh) := '';
 
EXPORT Make_company1(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_company1(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_company1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_address1(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_address1(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_address2(SALT311.StrType s0) := MakeFT_invalid_address2(s0);
EXPORT InValid_address2(SALT311.StrType s,SALT311.StrType address1) := InValidFT_invalid_address2(s,address1);
EXPORT InValidMessage_address2(UNSIGNED1 wh) := InValidMessageFT_invalid_address2(wh);
 
EXPORT Make_city2(SALT311.StrType s0) := MakeFT_invalid_city2(s0);
EXPORT InValid_city2(SALT311.StrType s,SALT311.StrType address2) := InValidFT_invalid_city2(s,address2);
EXPORT InValidMessage_city2(UNSIGNED1 wh) := InValidMessageFT_invalid_city2(wh);
 
EXPORT Make_state2(SALT311.StrType s0) := MakeFT_invalid_state2(s0);
EXPORT InValid_state2(SALT311.StrType s,SALT311.StrType address2) := InValidFT_invalid_state2(s,address2);
EXPORT InValidMessage_state2(UNSIGNED1 wh) := InValidMessageFT_invalid_state2(wh);
 
EXPORT Make_zip2(SALT311.StrType s0) := MakeFT_invalid_zip2(s0);
EXPORT InValid_zip2(SALT311.StrType s,SALT311.StrType address2) := InValidFT_invalid_zip2(s,address2);
EXPORT InValidMessage_zip2(UNSIGNED1 wh) := InValidMessageFT_invalid_zip2(wh);
 
EXPORT Make_fips(SALT311.StrType s0) := MakeFT_invalid_fips(s0);
EXPORT InValid_fips(SALT311.StrType s) := InValidFT_invalid_fips(s);
EXPORT InValidMessage_fips(UNSIGNED1 wh) := InValidMessageFT_invalid_fips(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_spec(SALT311.StrType s0) := MakeFT_invalid_spec(s0);
EXPORT InValid_spec(SALT311.StrType s) := InValidFT_invalid_spec(s);
EXPORT InValidMessage_spec(UNSIGNED1 wh) := InValidMessageFT_invalid_spec(wh);
 
EXPORT Make_spec_expl(SALT311.StrType s0) := MakeFT_invalid_spec_expl(s0);
EXPORT InValid_spec_expl(SALT311.StrType s,SALT311.StrType spec) := InValidFT_invalid_spec_expl(s,spec);
EXPORT InValidMessage_spec_expl(UNSIGNED1 wh) := InValidMessageFT_invalid_spec_expl(wh);
 
EXPORT Make_spec2(SALT311.StrType s0) := MakeFT_invalid_spec2(s0);
EXPORT InValid_spec2(SALT311.StrType s) := InValidFT_invalid_spec2(s);
EXPORT InValidMessage_spec2(UNSIGNED1 wh) := InValidMessageFT_invalid_spec2(wh);
 
EXPORT Make_spec2_expl(SALT311.StrType s0) := MakeFT_invalid_spec2_expl(s0);
EXPORT InValid_spec2_expl(SALT311.StrType s,SALT311.StrType spec2) := InValidFT_invalid_spec2_expl(s,spec2);
EXPORT InValidMessage_spec2_expl(UNSIGNED1 wh) := InValidMessageFT_invalid_spec2_expl(wh);
 
EXPORT Make_spec3(SALT311.StrType s0) := MakeFT_invalid_spec3(s0);
EXPORT InValid_spec3(SALT311.StrType s) := InValidFT_invalid_spec3(s);
EXPORT InValidMessage_spec3(UNSIGNED1 wh) := InValidMessageFT_invalid_spec3(wh);
 
EXPORT Make_spec3_expl(SALT311.StrType s0) := MakeFT_invalid_spec3_expl(s0);
EXPORT InValid_spec3_expl(SALT311.StrType s,SALT311.StrType spec3) := InValidFT_invalid_spec3_expl(s,spec3);
EXPORT InValidMessage_spec3_expl(UNSIGNED1 wh) := InValidMessageFT_invalid_spec3_expl(wh);
 
EXPORT Make_persid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_persid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_persid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_owner(SALT311.StrType s0) := MakeFT_invalid_owner(s0);
EXPORT InValid_owner(SALT311.StrType s) := InValidFT_invalid_owner(s);
EXPORT InValidMessage_owner(UNSIGNED1 wh) := InValidMessageFT_invalid_owner(wh);
 
EXPORT Make_emailavail(SALT311.StrType s0) := MakeFT_invalid_boolean(s0);
EXPORT InValid_emailavail(SALT311.StrType s) := InValidFT_invalid_boolean(s);
EXPORT InValidMessage_emailavail(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean(wh);
 
EXPORT Make_title(SALT311.StrType s0) := s0;
EXPORT InValid_title(SALT311.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_fname(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_mname(SALT311.StrType s0) := s0;
EXPORT InValid_mname(SALT311.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_lname(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_name_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_name_score(SALT311.StrType s0) := s0;
EXPORT InValid_name_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_prim_range(SALT311.StrType s0) := s0;
EXPORT InValid_mail_prim_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_predir(SALT311.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_mail_predir(SALT311.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_mail_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_mail_prim_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_mail_prim_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_mail_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_mail_addr_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_mail_addr_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_postdir(SALT311.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_mail_postdir(SALT311.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_mail_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_mail_unit_desig(SALT311.StrType s0) := s0;
EXPORT InValid_mail_unit_desig(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_sec_range(SALT311.StrType s0) := s0;
EXPORT InValid_mail_sec_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_p_city_name(SALT311.StrType s0) := MakeFT_invalid_mail_p_city_name(s0);
EXPORT InValid_mail_p_city_name(SALT311.StrType s,SALT311.StrType mail_v_city_name) := InValidFT_invalid_mail_p_city_name(s,mail_v_city_name);
EXPORT InValidMessage_mail_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mail_p_city_name(wh);
 
EXPORT Make_mail_v_city_name(SALT311.StrType s0) := MakeFT_invalid_mail_v_city_name(s0);
EXPORT InValid_mail_v_city_name(SALT311.StrType s,SALT311.StrType mail_p_city_name) := InValidFT_invalid_mail_v_city_name(s,mail_p_city_name);
EXPORT InValidMessage_mail_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mail_v_city_name(wh);
 
EXPORT Make_mail_st(SALT311.StrType s0) := MakeFT_invalid_mail_st(s0);
EXPORT InValid_mail_st(SALT311.StrType s) := InValidFT_invalid_mail_st(s);
EXPORT InValidMessage_mail_st(UNSIGNED1 wh) := InValidMessageFT_invalid_mail_st(wh);
 
EXPORT Make_mail_zip(SALT311.StrType s0) := MakeFT_invalid_mail_zip(s0);
EXPORT InValid_mail_zip(SALT311.StrType s) := InValidFT_invalid_mail_zip(s);
EXPORT InValidMessage_mail_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_mail_zip(wh);
 
EXPORT Make_mail_zip4(SALT311.StrType s0) := MakeFT_invalid_mail_zip4(s0);
EXPORT InValid_mail_zip4(SALT311.StrType s) := InValidFT_invalid_mail_zip4(s);
EXPORT InValidMessage_mail_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_mail_zip4(wh);
 
EXPORT Make_mail_cart(SALT311.StrType s0) := s0;
EXPORT InValid_mail_cart(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_cr_sort_sz(SALT311.StrType s0) := s0;
EXPORT InValid_mail_cr_sort_sz(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_lot(SALT311.StrType s0) := s0;
EXPORT InValid_mail_lot(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_lot_order(SALT311.StrType s0) := s0;
EXPORT InValid_mail_lot_order(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_dbpc(SALT311.StrType s0) := s0;
EXPORT InValid_mail_dbpc(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_dbpc(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_chk_digit(SALT311.StrType s0) := s0;
EXPORT InValid_mail_chk_digit(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_rec_type(SALT311.StrType s0) := s0;
EXPORT InValid_mail_rec_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_ace_fips_state(SALT311.StrType s0) := MakeFT_invalid_mail_ace_fips_state(s0);
EXPORT InValid_mail_ace_fips_state(SALT311.StrType s) := InValidFT_invalid_mail_ace_fips_state(s);
EXPORT InValidMessage_mail_ace_fips_state(UNSIGNED1 wh) := InValidMessageFT_invalid_mail_ace_fips_state(wh);
 
EXPORT Make_mail_county(SALT311.StrType s0) := s0;
EXPORT InValid_mail_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_county(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_geo_lat(SALT311.StrType s0) := MakeFT_invalid_geo_coord(s0);
EXPORT InValid_mail_geo_lat(SALT311.StrType s) := InValidFT_invalid_geo_coord(s);
EXPORT InValidMessage_mail_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_coord(wh);
 
EXPORT Make_mail_geo_long(SALT311.StrType s0) := MakeFT_invalid_geo_coord(s0);
EXPORT InValid_mail_geo_long(SALT311.StrType s) := InValidFT_invalid_geo_coord(s);
EXPORT InValidMessage_mail_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_coord(wh);
 
EXPORT Make_mail_msa(SALT311.StrType s0) := s0;
EXPORT InValid_mail_msa(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_geo_blk(SALT311.StrType s0) := s0;
EXPORT InValid_mail_geo_blk(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_geo_match(SALT311.StrType s0) := s0;
EXPORT InValid_mail_geo_match(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_err_stat(SALT311.StrType s0) := s0;
EXPORT InValid_mail_err_stat(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_prim_range(SALT311.StrType s0) := s0;
EXPORT InValid_alt_prim_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_predir(SALT311.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_alt_predir(SALT311.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_alt_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_alt_prim_name(SALT311.StrType s0) := MakeFT_invalid_alt_prim_name(s0);
EXPORT InValid_alt_prim_name(SALT311.StrType s,SALT311.StrType address2) := InValidFT_invalid_alt_prim_name(s,address2);
EXPORT InValidMessage_alt_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alt_prim_name(wh);
 
EXPORT Make_alt_addr_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_alt_addr_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_postdir(SALT311.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_alt_postdir(SALT311.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_alt_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_alt_unit_desig(SALT311.StrType s0) := s0;
EXPORT InValid_alt_unit_desig(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_sec_range(SALT311.StrType s0) := s0;
EXPORT InValid_alt_sec_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_p_city_name(SALT311.StrType s0) := MakeFT_invalid_alt_p_city_name(s0);
EXPORT InValid_alt_p_city_name(SALT311.StrType s,SALT311.StrType alt_st,SALT311.StrType alt_zip) := InValidFT_invalid_alt_p_city_name(s,alt_st,alt_zip);
EXPORT InValidMessage_alt_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alt_p_city_name(wh);
 
EXPORT Make_alt_v_city_name(SALT311.StrType s0) := MakeFT_invalid_alt_v_city_name(s0);
EXPORT InValid_alt_v_city_name(SALT311.StrType s,SALT311.StrType alt_st,SALT311.StrType alt_zip) := InValidFT_invalid_alt_v_city_name(s,alt_st,alt_zip);
EXPORT InValidMessage_alt_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alt_v_city_name(wh);
 
EXPORT Make_alt_st(SALT311.StrType s0) := MakeFT_invalid_alt_st(s0);
EXPORT InValid_alt_st(SALT311.StrType s,SALT311.StrType alt_p_city_name,SALT311.StrType alt_zip) := InValidFT_invalid_alt_st(s,alt_p_city_name,alt_zip);
EXPORT InValidMessage_alt_st(UNSIGNED1 wh) := InValidMessageFT_invalid_alt_st(wh);
 
EXPORT Make_alt_zip(SALT311.StrType s0) := MakeFT_invalid_alt_zip(s0);
EXPORT InValid_alt_zip(SALT311.StrType s,SALT311.StrType alt_v_city_name,SALT311.StrType alt_st) := InValidFT_invalid_alt_zip(s,alt_v_city_name,alt_st);
EXPORT InValidMessage_alt_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_alt_zip(wh);
 
EXPORT Make_alt_zip4(SALT311.StrType s0) := MakeFT_invalid_alt_zip4(s0);
EXPORT InValid_alt_zip4(SALT311.StrType s) := InValidFT_invalid_alt_zip4(s);
EXPORT InValidMessage_alt_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_alt_zip4(wh);
 
EXPORT Make_alt_cart(SALT311.StrType s0) := s0;
EXPORT InValid_alt_cart(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_cr_sort_sz(SALT311.StrType s0) := s0;
EXPORT InValid_alt_cr_sort_sz(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_lot(SALT311.StrType s0) := s0;
EXPORT InValid_alt_lot(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_lot_order(SALT311.StrType s0) := s0;
EXPORT InValid_alt_lot_order(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_dbpc(SALT311.StrType s0) := s0;
EXPORT InValid_alt_dbpc(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_dbpc(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_chk_digit(SALT311.StrType s0) := s0;
EXPORT InValid_alt_chk_digit(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_rec_type(SALT311.StrType s0) := s0;
EXPORT InValid_alt_rec_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_ace_fips_state(SALT311.StrType s0) := MakeFT_invalid_alt_ace_fips_state(s0);
EXPORT InValid_alt_ace_fips_state(SALT311.StrType s) := InValidFT_invalid_alt_ace_fips_state(s);
EXPORT InValidMessage_alt_ace_fips_state(UNSIGNED1 wh) := InValidMessageFT_invalid_alt_ace_fips_state(wh);
 
EXPORT Make_alt_county(SALT311.StrType s0) := s0;
EXPORT InValid_alt_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_county(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_geo_lat(SALT311.StrType s0) := s0;
EXPORT InValid_alt_geo_lat(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_geo_long(SALT311.StrType s0) := s0;
EXPORT InValid_alt_geo_long(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_msa(SALT311.StrType s0) := s0;
EXPORT InValid_alt_msa(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_geo_blk(SALT311.StrType s0) := s0;
EXPORT InValid_alt_geo_blk(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_geo_match(SALT311.StrType s0) := s0;
EXPORT InValid_alt_geo_match(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_alt_err_stat(SALT311.StrType s0) := s0;
EXPORT InValid_alt_err_stat(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_lf(SALT311.StrType s0) := s0;
EXPORT InValid_lf(SALT311.StrType s) := 0;
EXPORT InValidMessage_lf(UNSIGNED1 wh) := '';
 
EXPORT Make_dotid(SALT311.StrType s0) := s0;
EXPORT InValid_dotid(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := '';
 
EXPORT Make_dotscore(SALT311.StrType s0) := s0;
EXPORT InValid_dotscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := '';
 
EXPORT Make_dotweight(SALT311.StrType s0) := s0;
EXPORT InValid_dotweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := '';
 
EXPORT Make_empid(SALT311.StrType s0) := s0;
EXPORT InValid_empid(SALT311.StrType s) := 0;
EXPORT InValidMessage_empid(UNSIGNED1 wh) := '';
 
EXPORT Make_empscore(SALT311.StrType s0) := s0;
EXPORT InValid_empscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := '';
 
EXPORT Make_empweight(SALT311.StrType s0) := s0;
EXPORT InValid_empweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := '';
 
EXPORT Make_powid(SALT311.StrType s0) := s0;
EXPORT InValid_powid(SALT311.StrType s) := 0;
EXPORT InValidMessage_powid(UNSIGNED1 wh) := '';
 
EXPORT Make_powscore(SALT311.StrType s0) := s0;
EXPORT InValid_powscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := '';
 
EXPORT Make_powweight(SALT311.StrType s0) := s0;
EXPORT InValid_powweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := '';
 
EXPORT Make_proxid(SALT311.StrType s0) := s0;
EXPORT InValid_proxid(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_proxscore(SALT311.StrType s0) := s0;
EXPORT InValid_proxscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := '';
 
EXPORT Make_proxweight(SALT311.StrType s0) := s0;
EXPORT InValid_proxweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := '';
 
EXPORT Make_seleid(SALT311.StrType s0) := s0;
EXPORT InValid_seleid(SALT311.StrType s) := 0;
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := '';
 
EXPORT Make_selescore(SALT311.StrType s0) := s0;
EXPORT InValid_selescore(SALT311.StrType s) := 0;
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := '';
 
EXPORT Make_seleweight(SALT311.StrType s0) := s0;
EXPORT InValid_seleweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := '';
 
EXPORT Make_orgid(SALT311.StrType s0) := s0;
EXPORT InValid_orgid(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := '';
 
EXPORT Make_orgscore(SALT311.StrType s0) := s0;
EXPORT InValid_orgscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := '';
 
EXPORT Make_orgweight(SALT311.StrType s0) := s0;
EXPORT InValid_orgweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := '';
 
EXPORT Make_ultid(SALT311.StrType s0) := s0;
EXPORT InValid_ultid(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := '';
 
EXPORT Make_ultscore(SALT311.StrType s0) := s0;
EXPORT InValid_ultscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := '';
 
EXPORT Make_ultweight(SALT311.StrType s0) := s0;
EXPORT InValid_ultweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := '';
 
EXPORT Make_source_rec_id(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_source_rec_id(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_source_rec_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_SKA;
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
    BOOLEAN Diff_id_ska;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_ttl;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_middle;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_t1;
    BOOLEAN Diff_do;
    BOOLEAN Diff_deptcode;
    BOOLEAN Diff_dept_expl;
    BOOLEAN Diff_key_file;
    BOOLEAN Diff_company1;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_city2;
    BOOLEAN Diff_state2;
    BOOLEAN Diff_zip2;
    BOOLEAN Diff_fips;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_spec;
    BOOLEAN Diff_spec_expl;
    BOOLEAN Diff_spec2;
    BOOLEAN Diff_spec2_expl;
    BOOLEAN Diff_spec3;
    BOOLEAN Diff_spec3_expl;
    BOOLEAN Diff_persid;
    BOOLEAN Diff_owner;
    BOOLEAN Diff_emailavail;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_mail_prim_range;
    BOOLEAN Diff_mail_predir;
    BOOLEAN Diff_mail_prim_name;
    BOOLEAN Diff_mail_addr_suffix;
    BOOLEAN Diff_mail_postdir;
    BOOLEAN Diff_mail_unit_desig;
    BOOLEAN Diff_mail_sec_range;
    BOOLEAN Diff_mail_p_city_name;
    BOOLEAN Diff_mail_v_city_name;
    BOOLEAN Diff_mail_st;
    BOOLEAN Diff_mail_zip;
    BOOLEAN Diff_mail_zip4;
    BOOLEAN Diff_mail_cart;
    BOOLEAN Diff_mail_cr_sort_sz;
    BOOLEAN Diff_mail_lot;
    BOOLEAN Diff_mail_lot_order;
    BOOLEAN Diff_mail_dbpc;
    BOOLEAN Diff_mail_chk_digit;
    BOOLEAN Diff_mail_rec_type;
    BOOLEAN Diff_mail_ace_fips_state;
    BOOLEAN Diff_mail_county;
    BOOLEAN Diff_mail_geo_lat;
    BOOLEAN Diff_mail_geo_long;
    BOOLEAN Diff_mail_msa;
    BOOLEAN Diff_mail_geo_blk;
    BOOLEAN Diff_mail_geo_match;
    BOOLEAN Diff_mail_err_stat;
    BOOLEAN Diff_alt_prim_range;
    BOOLEAN Diff_alt_predir;
    BOOLEAN Diff_alt_prim_name;
    BOOLEAN Diff_alt_addr_suffix;
    BOOLEAN Diff_alt_postdir;
    BOOLEAN Diff_alt_unit_desig;
    BOOLEAN Diff_alt_sec_range;
    BOOLEAN Diff_alt_p_city_name;
    BOOLEAN Diff_alt_v_city_name;
    BOOLEAN Diff_alt_st;
    BOOLEAN Diff_alt_zip;
    BOOLEAN Diff_alt_zip4;
    BOOLEAN Diff_alt_cart;
    BOOLEAN Diff_alt_cr_sort_sz;
    BOOLEAN Diff_alt_lot;
    BOOLEAN Diff_alt_lot_order;
    BOOLEAN Diff_alt_dbpc;
    BOOLEAN Diff_alt_chk_digit;
    BOOLEAN Diff_alt_rec_type;
    BOOLEAN Diff_alt_ace_fips_state;
    BOOLEAN Diff_alt_county;
    BOOLEAN Diff_alt_geo_lat;
    BOOLEAN Diff_alt_geo_long;
    BOOLEAN Diff_alt_msa;
    BOOLEAN Diff_alt_geo_blk;
    BOOLEAN Diff_alt_geo_match;
    BOOLEAN Diff_alt_err_stat;
    BOOLEAN Diff_lf;
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
    BOOLEAN Diff_source_rec_id;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_id_ska := le.id_ska <> ri.id_ska;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_ttl := le.ttl <> ri.ttl;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_middle := le.middle <> ri.middle;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_t1 := le.t1 <> ri.t1;
    SELF.Diff_do := le.do <> ri.do;
    SELF.Diff_deptcode := le.deptcode <> ri.deptcode;
    SELF.Diff_dept_expl := le.dept_expl <> ri.dept_expl;
    SELF.Diff_key_file := le.key_file <> ri.key_file;
    SELF.Diff_company1 := le.company1 <> ri.company1;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_city2 := le.city2 <> ri.city2;
    SELF.Diff_state2 := le.state2 <> ri.state2;
    SELF.Diff_zip2 := le.zip2 <> ri.zip2;
    SELF.Diff_fips := le.fips <> ri.fips;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_spec := le.spec <> ri.spec;
    SELF.Diff_spec_expl := le.spec_expl <> ri.spec_expl;
    SELF.Diff_spec2 := le.spec2 <> ri.spec2;
    SELF.Diff_spec2_expl := le.spec2_expl <> ri.spec2_expl;
    SELF.Diff_spec3 := le.spec3 <> ri.spec3;
    SELF.Diff_spec3_expl := le.spec3_expl <> ri.spec3_expl;
    SELF.Diff_persid := le.persid <> ri.persid;
    SELF.Diff_owner := le.owner <> ri.owner;
    SELF.Diff_emailavail := le.emailavail <> ri.emailavail;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_mail_prim_range := le.mail_prim_range <> ri.mail_prim_range;
    SELF.Diff_mail_predir := le.mail_predir <> ri.mail_predir;
    SELF.Diff_mail_prim_name := le.mail_prim_name <> ri.mail_prim_name;
    SELF.Diff_mail_addr_suffix := le.mail_addr_suffix <> ri.mail_addr_suffix;
    SELF.Diff_mail_postdir := le.mail_postdir <> ri.mail_postdir;
    SELF.Diff_mail_unit_desig := le.mail_unit_desig <> ri.mail_unit_desig;
    SELF.Diff_mail_sec_range := le.mail_sec_range <> ri.mail_sec_range;
    SELF.Diff_mail_p_city_name := le.mail_p_city_name <> ri.mail_p_city_name;
    SELF.Diff_mail_v_city_name := le.mail_v_city_name <> ri.mail_v_city_name;
    SELF.Diff_mail_st := le.mail_st <> ri.mail_st;
    SELF.Diff_mail_zip := le.mail_zip <> ri.mail_zip;
    SELF.Diff_mail_zip4 := le.mail_zip4 <> ri.mail_zip4;
    SELF.Diff_mail_cart := le.mail_cart <> ri.mail_cart;
    SELF.Diff_mail_cr_sort_sz := le.mail_cr_sort_sz <> ri.mail_cr_sort_sz;
    SELF.Diff_mail_lot := le.mail_lot <> ri.mail_lot;
    SELF.Diff_mail_lot_order := le.mail_lot_order <> ri.mail_lot_order;
    SELF.Diff_mail_dbpc := le.mail_dbpc <> ri.mail_dbpc;
    SELF.Diff_mail_chk_digit := le.mail_chk_digit <> ri.mail_chk_digit;
    SELF.Diff_mail_rec_type := le.mail_rec_type <> ri.mail_rec_type;
    SELF.Diff_mail_ace_fips_state := le.mail_ace_fips_state <> ri.mail_ace_fips_state;
    SELF.Diff_mail_county := le.mail_county <> ri.mail_county;
    SELF.Diff_mail_geo_lat := le.mail_geo_lat <> ri.mail_geo_lat;
    SELF.Diff_mail_geo_long := le.mail_geo_long <> ri.mail_geo_long;
    SELF.Diff_mail_msa := le.mail_msa <> ri.mail_msa;
    SELF.Diff_mail_geo_blk := le.mail_geo_blk <> ri.mail_geo_blk;
    SELF.Diff_mail_geo_match := le.mail_geo_match <> ri.mail_geo_match;
    SELF.Diff_mail_err_stat := le.mail_err_stat <> ri.mail_err_stat;
    SELF.Diff_alt_prim_range := le.alt_prim_range <> ri.alt_prim_range;
    SELF.Diff_alt_predir := le.alt_predir <> ri.alt_predir;
    SELF.Diff_alt_prim_name := le.alt_prim_name <> ri.alt_prim_name;
    SELF.Diff_alt_addr_suffix := le.alt_addr_suffix <> ri.alt_addr_suffix;
    SELF.Diff_alt_postdir := le.alt_postdir <> ri.alt_postdir;
    SELF.Diff_alt_unit_desig := le.alt_unit_desig <> ri.alt_unit_desig;
    SELF.Diff_alt_sec_range := le.alt_sec_range <> ri.alt_sec_range;
    SELF.Diff_alt_p_city_name := le.alt_p_city_name <> ri.alt_p_city_name;
    SELF.Diff_alt_v_city_name := le.alt_v_city_name <> ri.alt_v_city_name;
    SELF.Diff_alt_st := le.alt_st <> ri.alt_st;
    SELF.Diff_alt_zip := le.alt_zip <> ri.alt_zip;
    SELF.Diff_alt_zip4 := le.alt_zip4 <> ri.alt_zip4;
    SELF.Diff_alt_cart := le.alt_cart <> ri.alt_cart;
    SELF.Diff_alt_cr_sort_sz := le.alt_cr_sort_sz <> ri.alt_cr_sort_sz;
    SELF.Diff_alt_lot := le.alt_lot <> ri.alt_lot;
    SELF.Diff_alt_lot_order := le.alt_lot_order <> ri.alt_lot_order;
    SELF.Diff_alt_dbpc := le.alt_dbpc <> ri.alt_dbpc;
    SELF.Diff_alt_chk_digit := le.alt_chk_digit <> ri.alt_chk_digit;
    SELF.Diff_alt_rec_type := le.alt_rec_type <> ri.alt_rec_type;
    SELF.Diff_alt_ace_fips_state := le.alt_ace_fips_state <> ri.alt_ace_fips_state;
    SELF.Diff_alt_county := le.alt_county <> ri.alt_county;
    SELF.Diff_alt_geo_lat := le.alt_geo_lat <> ri.alt_geo_lat;
    SELF.Diff_alt_geo_long := le.alt_geo_long <> ri.alt_geo_long;
    SELF.Diff_alt_msa := le.alt_msa <> ri.alt_msa;
    SELF.Diff_alt_geo_blk := le.alt_geo_blk <> ri.alt_geo_blk;
    SELF.Diff_alt_geo_match := le.alt_geo_match <> ri.alt_geo_match;
    SELF.Diff_alt_err_stat := le.alt_err_stat <> ri.alt_err_stat;
    SELF.Diff_lf := le.lf <> ri.lf;
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
    SELF.Diff_source_rec_id := le.source_rec_id <> ri.source_rec_id;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_id_ska,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_ttl,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_middle,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_t1,1,0)+ IF( SELF.Diff_do,1,0)+ IF( SELF.Diff_deptcode,1,0)+ IF( SELF.Diff_dept_expl,1,0)+ IF( SELF.Diff_key_file,1,0)+ IF( SELF.Diff_company1,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_city2,1,0)+ IF( SELF.Diff_state2,1,0)+ IF( SELF.Diff_zip2,1,0)+ IF( SELF.Diff_fips,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_spec,1,0)+ IF( SELF.Diff_spec_expl,1,0)+ IF( SELF.Diff_spec2,1,0)+ IF( SELF.Diff_spec2_expl,1,0)+ IF( SELF.Diff_spec3,1,0)+ IF( SELF.Diff_spec3_expl,1,0)+ IF( SELF.Diff_persid,1,0)+ IF( SELF.Diff_owner,1,0)+ IF( SELF.Diff_emailavail,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_mail_prim_range,1,0)+ IF( SELF.Diff_mail_predir,1,0)+ IF( SELF.Diff_mail_prim_name,1,0)+ IF( SELF.Diff_mail_addr_suffix,1,0)+ IF( SELF.Diff_mail_postdir,1,0)+ IF( SELF.Diff_mail_unit_desig,1,0)+ IF( SELF.Diff_mail_sec_range,1,0)+ IF( SELF.Diff_mail_p_city_name,1,0)+ IF( SELF.Diff_mail_v_city_name,1,0)+ IF( SELF.Diff_mail_st,1,0)+ IF( SELF.Diff_mail_zip,1,0)+ IF( SELF.Diff_mail_zip4,1,0)+ IF( SELF.Diff_mail_cart,1,0)+ IF( SELF.Diff_mail_cr_sort_sz,1,0)+ IF( SELF.Diff_mail_lot,1,0)+ IF( SELF.Diff_mail_lot_order,1,0)+ IF( SELF.Diff_mail_dbpc,1,0)+ IF( SELF.Diff_mail_chk_digit,1,0)+ IF( SELF.Diff_mail_rec_type,1,0)+ IF( SELF.Diff_mail_ace_fips_state,1,0)+ IF( SELF.Diff_mail_county,1,0)+ IF( SELF.Diff_mail_geo_lat,1,0)+ IF( SELF.Diff_mail_geo_long,1,0)+ IF( SELF.Diff_mail_msa,1,0)+ IF( SELF.Diff_mail_geo_blk,1,0)+ IF( SELF.Diff_mail_geo_match,1,0)+ IF( SELF.Diff_mail_err_stat,1,0)+ IF( SELF.Diff_alt_prim_range,1,0)+ IF( SELF.Diff_alt_predir,1,0)+ IF( SELF.Diff_alt_prim_name,1,0)+ IF( SELF.Diff_alt_addr_suffix,1,0)+ IF( SELF.Diff_alt_postdir,1,0)+ IF( SELF.Diff_alt_unit_desig,1,0)+ IF( SELF.Diff_alt_sec_range,1,0)+ IF( SELF.Diff_alt_p_city_name,1,0)+ IF( SELF.Diff_alt_v_city_name,1,0)+ IF( SELF.Diff_alt_st,1,0)+ IF( SELF.Diff_alt_zip,1,0)+ IF( SELF.Diff_alt_zip4,1,0)+ IF( SELF.Diff_alt_cart,1,0)+ IF( SELF.Diff_alt_cr_sort_sz,1,0)+ IF( SELF.Diff_alt_lot,1,0)+ IF( SELF.Diff_alt_lot_order,1,0)+ IF( SELF.Diff_alt_dbpc,1,0)+ IF( SELF.Diff_alt_chk_digit,1,0)+ IF( SELF.Diff_alt_rec_type,1,0)+ IF( SELF.Diff_alt_ace_fips_state,1,0)+ IF( SELF.Diff_alt_county,1,0)+ IF( SELF.Diff_alt_geo_lat,1,0)+ IF( SELF.Diff_alt_geo_long,1,0)+ IF( SELF.Diff_alt_msa,1,0)+ IF( SELF.Diff_alt_geo_blk,1,0)+ IF( SELF.Diff_alt_geo_match,1,0)+ IF( SELF.Diff_alt_err_stat,1,0)+ IF( SELF.Diff_lf,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_source_rec_id,1,0);
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
    Count_Diff_id_ska := COUNT(GROUP,%Closest%.Diff_id_ska);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_ttl := COUNT(GROUP,%Closest%.Diff_ttl);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_middle := COUNT(GROUP,%Closest%.Diff_middle);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_t1 := COUNT(GROUP,%Closest%.Diff_t1);
    Count_Diff_do := COUNT(GROUP,%Closest%.Diff_do);
    Count_Diff_deptcode := COUNT(GROUP,%Closest%.Diff_deptcode);
    Count_Diff_dept_expl := COUNT(GROUP,%Closest%.Diff_dept_expl);
    Count_Diff_key_file := COUNT(GROUP,%Closest%.Diff_key_file);
    Count_Diff_company1 := COUNT(GROUP,%Closest%.Diff_company1);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_city2 := COUNT(GROUP,%Closest%.Diff_city2);
    Count_Diff_state2 := COUNT(GROUP,%Closest%.Diff_state2);
    Count_Diff_zip2 := COUNT(GROUP,%Closest%.Diff_zip2);
    Count_Diff_fips := COUNT(GROUP,%Closest%.Diff_fips);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_spec := COUNT(GROUP,%Closest%.Diff_spec);
    Count_Diff_spec_expl := COUNT(GROUP,%Closest%.Diff_spec_expl);
    Count_Diff_spec2 := COUNT(GROUP,%Closest%.Diff_spec2);
    Count_Diff_spec2_expl := COUNT(GROUP,%Closest%.Diff_spec2_expl);
    Count_Diff_spec3 := COUNT(GROUP,%Closest%.Diff_spec3);
    Count_Diff_spec3_expl := COUNT(GROUP,%Closest%.Diff_spec3_expl);
    Count_Diff_persid := COUNT(GROUP,%Closest%.Diff_persid);
    Count_Diff_owner := COUNT(GROUP,%Closest%.Diff_owner);
    Count_Diff_emailavail := COUNT(GROUP,%Closest%.Diff_emailavail);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_mail_prim_range := COUNT(GROUP,%Closest%.Diff_mail_prim_range);
    Count_Diff_mail_predir := COUNT(GROUP,%Closest%.Diff_mail_predir);
    Count_Diff_mail_prim_name := COUNT(GROUP,%Closest%.Diff_mail_prim_name);
    Count_Diff_mail_addr_suffix := COUNT(GROUP,%Closest%.Diff_mail_addr_suffix);
    Count_Diff_mail_postdir := COUNT(GROUP,%Closest%.Diff_mail_postdir);
    Count_Diff_mail_unit_desig := COUNT(GROUP,%Closest%.Diff_mail_unit_desig);
    Count_Diff_mail_sec_range := COUNT(GROUP,%Closest%.Diff_mail_sec_range);
    Count_Diff_mail_p_city_name := COUNT(GROUP,%Closest%.Diff_mail_p_city_name);
    Count_Diff_mail_v_city_name := COUNT(GROUP,%Closest%.Diff_mail_v_city_name);
    Count_Diff_mail_st := COUNT(GROUP,%Closest%.Diff_mail_st);
    Count_Diff_mail_zip := COUNT(GROUP,%Closest%.Diff_mail_zip);
    Count_Diff_mail_zip4 := COUNT(GROUP,%Closest%.Diff_mail_zip4);
    Count_Diff_mail_cart := COUNT(GROUP,%Closest%.Diff_mail_cart);
    Count_Diff_mail_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_mail_cr_sort_sz);
    Count_Diff_mail_lot := COUNT(GROUP,%Closest%.Diff_mail_lot);
    Count_Diff_mail_lot_order := COUNT(GROUP,%Closest%.Diff_mail_lot_order);
    Count_Diff_mail_dbpc := COUNT(GROUP,%Closest%.Diff_mail_dbpc);
    Count_Diff_mail_chk_digit := COUNT(GROUP,%Closest%.Diff_mail_chk_digit);
    Count_Diff_mail_rec_type := COUNT(GROUP,%Closest%.Diff_mail_rec_type);
    Count_Diff_mail_ace_fips_state := COUNT(GROUP,%Closest%.Diff_mail_ace_fips_state);
    Count_Diff_mail_county := COUNT(GROUP,%Closest%.Diff_mail_county);
    Count_Diff_mail_geo_lat := COUNT(GROUP,%Closest%.Diff_mail_geo_lat);
    Count_Diff_mail_geo_long := COUNT(GROUP,%Closest%.Diff_mail_geo_long);
    Count_Diff_mail_msa := COUNT(GROUP,%Closest%.Diff_mail_msa);
    Count_Diff_mail_geo_blk := COUNT(GROUP,%Closest%.Diff_mail_geo_blk);
    Count_Diff_mail_geo_match := COUNT(GROUP,%Closest%.Diff_mail_geo_match);
    Count_Diff_mail_err_stat := COUNT(GROUP,%Closest%.Diff_mail_err_stat);
    Count_Diff_alt_prim_range := COUNT(GROUP,%Closest%.Diff_alt_prim_range);
    Count_Diff_alt_predir := COUNT(GROUP,%Closest%.Diff_alt_predir);
    Count_Diff_alt_prim_name := COUNT(GROUP,%Closest%.Diff_alt_prim_name);
    Count_Diff_alt_addr_suffix := COUNT(GROUP,%Closest%.Diff_alt_addr_suffix);
    Count_Diff_alt_postdir := COUNT(GROUP,%Closest%.Diff_alt_postdir);
    Count_Diff_alt_unit_desig := COUNT(GROUP,%Closest%.Diff_alt_unit_desig);
    Count_Diff_alt_sec_range := COUNT(GROUP,%Closest%.Diff_alt_sec_range);
    Count_Diff_alt_p_city_name := COUNT(GROUP,%Closest%.Diff_alt_p_city_name);
    Count_Diff_alt_v_city_name := COUNT(GROUP,%Closest%.Diff_alt_v_city_name);
    Count_Diff_alt_st := COUNT(GROUP,%Closest%.Diff_alt_st);
    Count_Diff_alt_zip := COUNT(GROUP,%Closest%.Diff_alt_zip);
    Count_Diff_alt_zip4 := COUNT(GROUP,%Closest%.Diff_alt_zip4);
    Count_Diff_alt_cart := COUNT(GROUP,%Closest%.Diff_alt_cart);
    Count_Diff_alt_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_alt_cr_sort_sz);
    Count_Diff_alt_lot := COUNT(GROUP,%Closest%.Diff_alt_lot);
    Count_Diff_alt_lot_order := COUNT(GROUP,%Closest%.Diff_alt_lot_order);
    Count_Diff_alt_dbpc := COUNT(GROUP,%Closest%.Diff_alt_dbpc);
    Count_Diff_alt_chk_digit := COUNT(GROUP,%Closest%.Diff_alt_chk_digit);
    Count_Diff_alt_rec_type := COUNT(GROUP,%Closest%.Diff_alt_rec_type);
    Count_Diff_alt_ace_fips_state := COUNT(GROUP,%Closest%.Diff_alt_ace_fips_state);
    Count_Diff_alt_county := COUNT(GROUP,%Closest%.Diff_alt_county);
    Count_Diff_alt_geo_lat := COUNT(GROUP,%Closest%.Diff_alt_geo_lat);
    Count_Diff_alt_geo_long := COUNT(GROUP,%Closest%.Diff_alt_geo_long);
    Count_Diff_alt_msa := COUNT(GROUP,%Closest%.Diff_alt_msa);
    Count_Diff_alt_geo_blk := COUNT(GROUP,%Closest%.Diff_alt_geo_blk);
    Count_Diff_alt_geo_match := COUNT(GROUP,%Closest%.Diff_alt_geo_match);
    Count_Diff_alt_err_stat := COUNT(GROUP,%Closest%.Diff_alt_err_stat);
    Count_Diff_lf := COUNT(GROUP,%Closest%.Diff_lf);
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
    Count_Diff_source_rec_id := COUNT(GROUP,%Closest%.Diff_source_rec_id);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

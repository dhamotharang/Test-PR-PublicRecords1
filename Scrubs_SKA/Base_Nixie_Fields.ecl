IMPORT SALT311;
IMPORT Scrubs_SKA; // Import modules for FieldTypes attribute definitions
EXPORT Base_Nixie_Fields := MODULE
 
EXPORT NumFields := 76;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_numeric','invalid_mandatory','invalid_pastdate8','invalid_direction','invalid_geo_coord','invalid_dept_code','invalid_dept_expl','invalid_spec','invalid_spec_expl','invalid_state','invalid_zip','invalid_area_code','invalid_number','invalid_mail_p_city_name','invalid_mail_v_city_name','invalid_mail_st','invalid_mail_zip','invalid_mail_zip4','invalid_mail_ace_fips_state');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_numeric' => 1,'invalid_mandatory' => 2,'invalid_pastdate8' => 3,'invalid_direction' => 4,'invalid_geo_coord' => 5,'invalid_dept_code' => 6,'invalid_dept_expl' => 7,'invalid_spec' => 8,'invalid_spec_expl' => 9,'invalid_state' => 10,'invalid_zip' => 11,'invalid_area_code' => 12,'invalid_number' => 13,'invalid_mail_p_city_name' => 14,'invalid_mail_v_city_name' => 15,'invalid_mail_st' => 16,'invalid_mail_zip' => 17,'invalid_mail_zip4' => 18,'invalid_mail_ace_fips_state' => 19,0);
 
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
 
EXPORT MakeFT_invalid_dept_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dept_code(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_alpha_opt(s,3)>0);
EXPORT InValidMessageFT_invalid_dept_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_alpha_opt'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dept_expl(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dept_expl(SALT311.StrType s,SALT311.StrType dept_code) := WHICH(~Scrubs_SKA.Functions.fn_str1_xor_str2(s,dept_code)>0);
EXPORT InValidMessageFT_invalid_dept_expl(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
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
 
EXPORT MakeFT_invalid_area_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_area_code(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_numeric(s,3)>0);
EXPORT InValidMessageFT_invalid_area_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_number(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_number(SALT311.StrType s) := WHICH(~Scrubs_SKA.Functions.fn_numeric_opt(s,7)>0);
EXPORT InValidMessageFT_invalid_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SKA.Functions.fn_numeric_opt'),SALT311.HygieneErrors.Good);
 
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
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'id_ska','bdid','ttl','first_name','middle','last_name','t1','dept_code','dept_expl','spec','spec_expl','dept_file','company1','address1','city','state','zip','area_code','number','persid','nixie_date','title','fname','mname','lname','name_suffix','name_score','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dbpc','mail_chk_digit','mail_rec_type','mail_ace_fips_state','mail_county','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'id_ska','bdid','ttl','first_name','middle','last_name','t1','dept_code','dept_expl','spec','spec_expl','dept_file','company1','address1','city','state','zip','area_code','number','persid','nixie_date','title','fname','mname','lname','name_suffix','name_score','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dbpc','mail_chk_digit','mail_rec_type','mail_ace_fips_state','mail_county','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'id_ska' => 0,'bdid' => 1,'ttl' => 2,'first_name' => 3,'middle' => 4,'last_name' => 5,'t1' => 6,'dept_code' => 7,'dept_expl' => 8,'spec' => 9,'spec_expl' => 10,'dept_file' => 11,'company1' => 12,'address1' => 13,'city' => 14,'state' => 15,'zip' => 16,'area_code' => 17,'number' => 18,'persid' => 19,'nixie_date' => 20,'title' => 21,'fname' => 22,'mname' => 23,'lname' => 24,'name_suffix' => 25,'name_score' => 26,'mail_prim_range' => 27,'mail_predir' => 28,'mail_prim_name' => 29,'mail_addr_suffix' => 30,'mail_postdir' => 31,'mail_unit_desig' => 32,'mail_sec_range' => 33,'mail_p_city_name' => 34,'mail_v_city_name' => 35,'mail_st' => 36,'mail_zip' => 37,'mail_zip4' => 38,'mail_cart' => 39,'mail_cr_sort_sz' => 40,'mail_lot' => 41,'mail_lot_order' => 42,'mail_dbpc' => 43,'mail_chk_digit' => 44,'mail_rec_type' => 45,'mail_ace_fips_state' => 46,'mail_county' => 47,'mail_geo_lat' => 48,'mail_geo_long' => 49,'mail_msa' => 50,'mail_geo_blk' => 51,'mail_geo_match' => 52,'mail_err_stat' => 53,'dotid' => 54,'dotscore' => 55,'dotweight' => 56,'empid' => 57,'empscore' => 58,'empweight' => 59,'powid' => 60,'powscore' => 61,'powweight' => 62,'proxid' => 63,'proxscore' => 64,'proxweight' => 65,'seleid' => 66,'selescore' => 67,'seleweight' => 68,'orgid' => 69,'orgscore' => 70,'orgweight' => 71,'ultid' => 72,'ultscore' => 73,'ultweight' => 74,'source_rec_id' => 75,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],[],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],[],['CUSTOM'],[],[],[],['ALLOW'],['CUSTOM'],[],['ALLOW'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
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
 
EXPORT Make_dept_code(SALT311.StrType s0) := MakeFT_invalid_dept_code(s0);
EXPORT InValid_dept_code(SALT311.StrType s) := InValidFT_invalid_dept_code(s);
EXPORT InValidMessage_dept_code(UNSIGNED1 wh) := InValidMessageFT_invalid_dept_code(wh);
 
EXPORT Make_dept_expl(SALT311.StrType s0) := MakeFT_invalid_dept_expl(s0);
EXPORT InValid_dept_expl(SALT311.StrType s,SALT311.StrType dept_code) := InValidFT_invalid_dept_expl(s,dept_code);
EXPORT InValidMessage_dept_expl(UNSIGNED1 wh) := InValidMessageFT_invalid_dept_expl(wh);
 
EXPORT Make_spec(SALT311.StrType s0) := MakeFT_invalid_spec(s0);
EXPORT InValid_spec(SALT311.StrType s) := InValidFT_invalid_spec(s);
EXPORT InValidMessage_spec(UNSIGNED1 wh) := InValidMessageFT_invalid_spec(wh);
 
EXPORT Make_spec_expl(SALT311.StrType s0) := MakeFT_invalid_spec_expl(s0);
EXPORT InValid_spec_expl(SALT311.StrType s,SALT311.StrType spec) := InValidFT_invalid_spec_expl(s,spec);
EXPORT InValidMessage_spec_expl(UNSIGNED1 wh) := InValidMessageFT_invalid_spec_expl(wh);
 
EXPORT Make_dept_file(SALT311.StrType s0) := s0;
EXPORT InValid_dept_file(SALT311.StrType s) := 0;
EXPORT InValidMessage_dept_file(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_area_code(SALT311.StrType s0) := MakeFT_invalid_area_code(s0);
EXPORT InValid_area_code(SALT311.StrType s) := InValidFT_invalid_area_code(s);
EXPORT InValidMessage_area_code(UNSIGNED1 wh) := InValidMessageFT_invalid_area_code(wh);
 
EXPORT Make_number(SALT311.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_number(SALT311.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_number(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);
 
EXPORT Make_persid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_persid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_persid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_nixie_date(SALT311.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_nixie_date(SALT311.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_nixie_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
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
    BOOLEAN Diff_dept_code;
    BOOLEAN Diff_dept_expl;
    BOOLEAN Diff_spec;
    BOOLEAN Diff_spec_expl;
    BOOLEAN Diff_dept_file;
    BOOLEAN Diff_company1;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_area_code;
    BOOLEAN Diff_number;
    BOOLEAN Diff_persid;
    BOOLEAN Diff_nixie_date;
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
    SELF.Diff_dept_code := le.dept_code <> ri.dept_code;
    SELF.Diff_dept_expl := le.dept_expl <> ri.dept_expl;
    SELF.Diff_spec := le.spec <> ri.spec;
    SELF.Diff_spec_expl := le.spec_expl <> ri.spec_expl;
    SELF.Diff_dept_file := le.dept_file <> ri.dept_file;
    SELF.Diff_company1 := le.company1 <> ri.company1;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_area_code := le.area_code <> ri.area_code;
    SELF.Diff_number := le.number <> ri.number;
    SELF.Diff_persid := le.persid <> ri.persid;
    SELF.Diff_nixie_date := le.nixie_date <> ri.nixie_date;
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
    SELF.Num_Diffs := 0+ IF( SELF.Diff_id_ska,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_ttl,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_middle,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_t1,1,0)+ IF( SELF.Diff_dept_code,1,0)+ IF( SELF.Diff_dept_expl,1,0)+ IF( SELF.Diff_spec,1,0)+ IF( SELF.Diff_spec_expl,1,0)+ IF( SELF.Diff_dept_file,1,0)+ IF( SELF.Diff_company1,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_area_code,1,0)+ IF( SELF.Diff_number,1,0)+ IF( SELF.Diff_persid,1,0)+ IF( SELF.Diff_nixie_date,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_mail_prim_range,1,0)+ IF( SELF.Diff_mail_predir,1,0)+ IF( SELF.Diff_mail_prim_name,1,0)+ IF( SELF.Diff_mail_addr_suffix,1,0)+ IF( SELF.Diff_mail_postdir,1,0)+ IF( SELF.Diff_mail_unit_desig,1,0)+ IF( SELF.Diff_mail_sec_range,1,0)+ IF( SELF.Diff_mail_p_city_name,1,0)+ IF( SELF.Diff_mail_v_city_name,1,0)+ IF( SELF.Diff_mail_st,1,0)+ IF( SELF.Diff_mail_zip,1,0)+ IF( SELF.Diff_mail_zip4,1,0)+ IF( SELF.Diff_mail_cart,1,0)+ IF( SELF.Diff_mail_cr_sort_sz,1,0)+ IF( SELF.Diff_mail_lot,1,0)+ IF( SELF.Diff_mail_lot_order,1,0)+ IF( SELF.Diff_mail_dbpc,1,0)+ IF( SELF.Diff_mail_chk_digit,1,0)+ IF( SELF.Diff_mail_rec_type,1,0)+ IF( SELF.Diff_mail_ace_fips_state,1,0)+ IF( SELF.Diff_mail_county,1,0)+ IF( SELF.Diff_mail_geo_lat,1,0)+ IF( SELF.Diff_mail_geo_long,1,0)+ IF( SELF.Diff_mail_msa,1,0)+ IF( SELF.Diff_mail_geo_blk,1,0)+ IF( SELF.Diff_mail_geo_match,1,0)+ IF( SELF.Diff_mail_err_stat,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_source_rec_id,1,0);
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
    Count_Diff_dept_code := COUNT(GROUP,%Closest%.Diff_dept_code);
    Count_Diff_dept_expl := COUNT(GROUP,%Closest%.Diff_dept_expl);
    Count_Diff_spec := COUNT(GROUP,%Closest%.Diff_spec);
    Count_Diff_spec_expl := COUNT(GROUP,%Closest%.Diff_spec_expl);
    Count_Diff_dept_file := COUNT(GROUP,%Closest%.Diff_dept_file);
    Count_Diff_company1 := COUNT(GROUP,%Closest%.Diff_company1);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_area_code := COUNT(GROUP,%Closest%.Diff_area_code);
    Count_Diff_number := COUNT(GROUP,%Closest%.Diff_number);
    Count_Diff_persid := COUNT(GROUP,%Closest%.Diff_persid);
    Count_Diff_nixie_date := COUNT(GROUP,%Closest%.Diff_nixie_date);
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

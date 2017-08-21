IMPORT SALT37;
IMPORT Scrubs_UCCV2; // Import modules for FieldTypes attribute definitions
EXPORT IL_Party_Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT37.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_empty','invalid_zero_integer','invalid_boolean_yn','invalid_pastdate8','invalid_pastdate6','invalid_tmsid','invalid_rmsid','invalid_orig_name','invalid_orig_lname','invalid_orig_fname','invalid_orig_address1','invalid_orig_state','invalid_orig_zip5','invalid_party_type','invalid_fname','invalid_mname','invalid_lname','invalid_company_name');
EXPORT FieldTypeNum(SALT37.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_empty' => 2,'invalid_zero_integer' => 3,'invalid_boolean_yn' => 4,'invalid_pastdate8' => 5,'invalid_pastdate6' => 6,'invalid_tmsid' => 7,'invalid_rmsid' => 8,'invalid_orig_name' => 9,'invalid_orig_lname' => 10,'invalid_orig_fname' => 11,'invalid_orig_address1' => 12,'invalid_orig_state' => 13,'invalid_orig_zip5' => 14,'invalid_party_type' => 15,'invalid_fname' => 16,'invalid_mname' => 17,'invalid_lname' => 18,'invalid_company_name' => 19,0);
 
EXPORT MakeFT_invalid_mandatory(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT37.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_populated_strings(s)>0);
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_populated_strings'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_empty(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_empty(SALT37.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLength('0'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zero_integer(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zero_integer(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['0','']);
EXPORT InValidMessageFT_invalid_zero_integer(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('0|'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_boolean_yn(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_boolean_yn(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['N','Y']);
EXPORT InValidMessageFT_invalid_boolean_yn(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('N|Y'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate8(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate8(SALT37.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate8(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_past_yyyymmdd'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate6(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate6(SALT37.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_past_yyyymm(s)>0);
EXPORT InValidMessageFT_invalid_pastdate6(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_past_yyyymm'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_tmsid(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_tmsid(SALT37.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_state_tmsid_rmsid(s,'IL')>0);
EXPORT InValidMessageFT_invalid_tmsid(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_state_tmsid_rmsid'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_rmsid(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rmsid(SALT37.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_state_tmsid_rmsid(s,'IL')>0);
EXPORT InValidMessageFT_invalid_rmsid(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_state_tmsid_rmsid'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_name(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_name(SALT37.StrType s,SALT37.StrType orig_lname,SALT37.StrType orig_fname) := WHICH(~Scrubs_UCCV2.Functions.fn_populated_strings(s,orig_lname,orig_fname)>0);
EXPORT InValidMessageFT_invalid_orig_name(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_populated_strings'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_lname(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_lname(SALT37.StrType s,SALT37.StrType orig_name,SALT37.StrType orig_fname) := WHICH(~Scrubs_UCCV2.Functions.fn_populated_strings(s,orig_name,orig_fname)>0);
EXPORT InValidMessageFT_invalid_orig_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_populated_strings'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_fname(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_fname(SALT37.StrType s,SALT37.StrType orig_name,SALT37.StrType orig_lname) := WHICH(~Scrubs_UCCV2.Functions.fn_populated_strings(s,orig_name,orig_lname)>0);
EXPORT InValidMessageFT_invalid_orig_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_populated_strings'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_address1(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_address1(SALT37.StrType s,SALT37.StrType orig_city,SALT37.StrType orig_state) := WHICH(~Scrubs_UCCV2.Functions.fn_populated_strings(s,orig_city,orig_state)>0);
EXPORT InValidMessageFT_invalid_orig_address1(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_populated_strings'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_state(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_state(SALT37.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_orig_state(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_verify_state'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_zip5(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_zip5(SALT37.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_verify_zip5(s)>0);
EXPORT InValidMessageFT_invalid_orig_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_verify_zip5'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_party_type(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_party_type(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['D','S']);
EXPORT InValidMessageFT_invalid_party_type(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('D|S'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fname(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fname(SALT37.StrType s,SALT37.StrType mname,SALT37.StrType lname,SALT37.StrType company_name) := WHICH(~Scrubs_UCCV2.Functions.fn_populated_strings(s,mname,lname,company_name)>0);
EXPORT InValidMessageFT_invalid_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_populated_strings'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mname(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mname(SALT37.StrType s,SALT37.StrType fname,SALT37.StrType lname,SALT37.StrType company_name) := WHICH(~Scrubs_UCCV2.Functions.fn_populated_strings(s,fname,lname,company_name)>0);
EXPORT InValidMessageFT_invalid_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_populated_strings'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lname(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lname(SALT37.StrType s,SALT37.StrType fname,SALT37.StrType mname,SALT37.StrType company_name) := WHICH(~Scrubs_UCCV2.Functions.fn_populated_strings(s,fname,mname,company_name)>0);
EXPORT InValidMessageFT_invalid_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_populated_strings'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_name(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_name(SALT37.StrType s,SALT37.StrType fname,SALT37.StrType mname,SALT37.StrType lname) := WHICH(~Scrubs_UCCV2.Functions.fn_company_xor_person(s,fname,mname,lname)>0);
EXPORT InValidMessageFT_invalid_company_name(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_company_xor_person'),SALT37.HygieneErrors.Good);
 
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'tmsid','rmsid','orig_name','orig_lname','orig_fname','orig_mname','orig_suffix','duns_number','hq_duns_number','ssn','fein','incorp_state','corp_number','corp_type','orig_address1','orig_address2','orig_city','orig_state','orig_zip5','orig_zip4','orig_country','orig_province','orig_postal_code','foreign_indc','party_type','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','process_date','title','fname','mname','lname','name_suffix','name_score','company_name','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','county','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','ace_fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','bdid','did','did_score','bdid_score','source_rec_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','prep_addr_line1','prep_addr_last_line','rawaid','aceaid','persistent_record_id');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'tmsid' => 0,'rmsid' => 1,'orig_name' => 2,'orig_lname' => 3,'orig_fname' => 4,'orig_mname' => 5,'orig_suffix' => 6,'duns_number' => 7,'hq_duns_number' => 8,'ssn' => 9,'fein' => 10,'incorp_state' => 11,'corp_number' => 12,'corp_type' => 13,'orig_address1' => 14,'orig_address2' => 15,'orig_city' => 16,'orig_state' => 17,'orig_zip5' => 18,'orig_zip4' => 19,'orig_country' => 20,'orig_province' => 21,'orig_postal_code' => 22,'foreign_indc' => 23,'party_type' => 24,'dt_first_seen' => 25,'dt_last_seen' => 26,'dt_vendor_last_reported' => 27,'dt_vendor_first_reported' => 28,'process_date' => 29,'title' => 30,'fname' => 31,'mname' => 32,'lname' => 33,'name_suffix' => 34,'name_score' => 35,'company_name' => 36,'prim_range' => 37,'predir' => 38,'prim_name' => 39,'suffix' => 40,'postdir' => 41,'unit_desig' => 42,'sec_range' => 43,'p_city_name' => 44,'v_city_name' => 45,'st' => 46,'zip5' => 47,'zip4' => 48,'county' => 49,'cart' => 50,'cr_sort_sz' => 51,'lot' => 52,'lot_order' => 53,'dpbc' => 54,'chk_digit' => 55,'rec_type' => 56,'ace_fips_st' => 57,'ace_fips_county' => 58,'geo_lat' => 59,'geo_long' => 60,'msa' => 61,'geo_blk' => 62,'geo_match' => 63,'err_stat' => 64,'bdid' => 65,'did' => 66,'did_score' => 67,'bdid_score' => 68,'source_rec_id' => 69,'dotid' => 70,'dotscore' => 71,'dotweight' => 72,'empid' => 73,'empscore' => 74,'empweight' => 75,'powid' => 76,'powscore' => 77,'powweight' => 78,'proxid' => 79,'proxscore' => 80,'proxweight' => 81,'seleid' => 82,'selescore' => 83,'seleweight' => 84,'orgid' => 85,'orgscore' => 86,'orgweight' => 87,'ultid' => 88,'ultscore' => 89,'ultweight' => 90,'prep_addr_line1' => 91,'prep_addr_last_line' => 92,'rawaid' => 93,'aceaid' => 94,'persistent_record_id' => 95,0);
 
//Individual field level validation
 
EXPORT Make_tmsid(SALT37.StrType s0) := MakeFT_invalid_tmsid(s0);
EXPORT InValid_tmsid(SALT37.StrType s) := InValidFT_invalid_tmsid(s);
EXPORT InValidMessage_tmsid(UNSIGNED1 wh) := InValidMessageFT_invalid_tmsid(wh);
 
EXPORT Make_rmsid(SALT37.StrType s0) := MakeFT_invalid_rmsid(s0);
EXPORT InValid_rmsid(SALT37.StrType s) := InValidFT_invalid_rmsid(s);
EXPORT InValidMessage_rmsid(UNSIGNED1 wh) := InValidMessageFT_invalid_rmsid(wh);
 
EXPORT Make_orig_name(SALT37.StrType s0) := MakeFT_invalid_orig_name(s0);
EXPORT InValid_orig_name(SALT37.StrType s,SALT37.StrType orig_lname,SALT37.StrType orig_fname) := InValidFT_invalid_orig_name(s,orig_lname,orig_fname);
EXPORT InValidMessage_orig_name(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_name(wh);
 
EXPORT Make_orig_lname(SALT37.StrType s0) := MakeFT_invalid_orig_lname(s0);
EXPORT InValid_orig_lname(SALT37.StrType s,SALT37.StrType orig_name,SALT37.StrType orig_fname) := InValidFT_invalid_orig_lname(s,orig_name,orig_fname);
EXPORT InValidMessage_orig_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_lname(wh);
 
EXPORT Make_orig_fname(SALT37.StrType s0) := MakeFT_invalid_orig_fname(s0);
EXPORT InValid_orig_fname(SALT37.StrType s,SALT37.StrType orig_name,SALT37.StrType orig_lname) := InValidFT_invalid_orig_fname(s,orig_name,orig_lname);
EXPORT InValidMessage_orig_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_fname(wh);
 
EXPORT Make_orig_mname(SALT37.StrType s0) := s0;
EXPORT InValid_orig_mname(SALT37.StrType s) := 0;
EXPORT InValidMessage_orig_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_suffix(SALT37.StrType s0) := s0;
EXPORT InValid_orig_suffix(SALT37.StrType s) := 0;
EXPORT InValidMessage_orig_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_duns_number(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_duns_number(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_duns_number(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_hq_duns_number(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_hq_duns_number(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_hq_duns_number(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_ssn(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_ssn(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_fein(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_fein(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_fein(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_incorp_state(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_incorp_state(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_incorp_state(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_corp_number(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_corp_number(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_corp_number(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_corp_type(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_corp_type(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_corp_type(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_orig_address1(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_orig_address1(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_orig_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_orig_address2(SALT37.StrType s0) := s0;
EXPORT InValid_orig_address2(SALT37.StrType s) := 0;
EXPORT InValidMessage_orig_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_city(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_orig_city(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_orig_state(SALT37.StrType s0) := MakeFT_invalid_orig_state(s0);
EXPORT InValid_orig_state(SALT37.StrType s) := InValidFT_invalid_orig_state(s);
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_state(wh);
 
EXPORT Make_orig_zip5(SALT37.StrType s0) := MakeFT_invalid_orig_zip5(s0);
EXPORT InValid_orig_zip5(SALT37.StrType s) := InValidFT_invalid_orig_zip5(s);
EXPORT InValidMessage_orig_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_zip5(wh);
 
EXPORT Make_orig_zip4(SALT37.StrType s0) := s0;
EXPORT InValid_orig_zip4(SALT37.StrType s) := 0;
EXPORT InValidMessage_orig_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_country(SALT37.StrType s0) := s0;
EXPORT InValid_orig_country(SALT37.StrType s) := 0;
EXPORT InValidMessage_orig_country(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_province(SALT37.StrType s0) := s0;
EXPORT InValid_orig_province(SALT37.StrType s) := 0;
EXPORT InValidMessage_orig_province(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_postal_code(SALT37.StrType s0) := s0;
EXPORT InValid_orig_postal_code(SALT37.StrType s) := 0;
EXPORT InValidMessage_orig_postal_code(UNSIGNED1 wh) := '';
 
EXPORT Make_foreign_indc(SALT37.StrType s0) := MakeFT_invalid_boolean_yn(s0);
EXPORT InValid_foreign_indc(SALT37.StrType s) := InValidFT_invalid_boolean_yn(s);
EXPORT InValidMessage_foreign_indc(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_yn(wh);
 
EXPORT Make_party_type(SALT37.StrType s0) := MakeFT_invalid_party_type(s0);
EXPORT InValid_party_type(SALT37.StrType s) := InValidFT_invalid_party_type(s);
EXPORT InValidMessage_party_type(UNSIGNED1 wh) := InValidMessageFT_invalid_party_type(wh);
 
EXPORT Make_dt_first_seen(SALT37.StrType s0) := MakeFT_invalid_pastdate6(s0);
EXPORT InValid_dt_first_seen(SALT37.StrType s) := InValidFT_invalid_pastdate6(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate6(wh);
 
EXPORT Make_dt_last_seen(SALT37.StrType s0) := MakeFT_invalid_pastdate6(s0);
EXPORT InValid_dt_last_seen(SALT37.StrType s) := InValidFT_invalid_pastdate6(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate6(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT37.StrType s0) := MakeFT_invalid_pastdate6(s0);
EXPORT InValid_dt_vendor_last_reported(SALT37.StrType s) := InValidFT_invalid_pastdate6(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate6(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT37.StrType s0) := MakeFT_invalid_pastdate6(s0);
EXPORT InValid_dt_vendor_first_reported(SALT37.StrType s) := InValidFT_invalid_pastdate6(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate6(wh);
 
EXPORT Make_process_date(SALT37.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_process_date(SALT37.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_title(SALT37.StrType s0) := s0;
EXPORT InValid_title(SALT37.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT37.StrType s0) := MakeFT_invalid_fname(s0);
EXPORT InValid_fname(SALT37.StrType s,SALT37.StrType mname,SALT37.StrType lname,SALT37.StrType company_name) := InValidFT_invalid_fname(s,mname,lname,company_name);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_fname(wh);
 
EXPORT Make_mname(SALT37.StrType s0) := MakeFT_invalid_mname(s0);
EXPORT InValid_mname(SALT37.StrType s,SALT37.StrType fname,SALT37.StrType lname,SALT37.StrType company_name) := InValidFT_invalid_mname(s,fname,lname,company_name);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_mname(wh);
 
EXPORT Make_lname(SALT37.StrType s0) := MakeFT_invalid_lname(s0);
EXPORT InValid_lname(SALT37.StrType s,SALT37.StrType fname,SALT37.StrType mname,SALT37.StrType company_name) := InValidFT_invalid_lname(s,fname,mname,company_name);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_lname(wh);
 
EXPORT Make_name_suffix(SALT37.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT37.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_name_score(SALT37.StrType s0) := s0;
EXPORT InValid_name_score(SALT37.StrType s) := 0;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name(SALT37.StrType s0) := MakeFT_invalid_company_name(s0);
EXPORT InValid_company_name(SALT37.StrType s,SALT37.StrType fname,SALT37.StrType mname,SALT37.StrType lname) := InValidFT_invalid_company_name(s,fname,mname,lname);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_company_name(wh);
 
EXPORT Make_prim_range(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_prim_range(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_predir(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_predir(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_prim_name(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_prim_name(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_suffix(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_suffix(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_postdir(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_postdir(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_unit_desig(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_unit_desig(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_sec_range(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_sec_range(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_p_city_name(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_p_city_name(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_v_city_name(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_v_city_name(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_st(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_st(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_zip5(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_zip5(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_zip4(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_zip4(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_county(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_county(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_cart(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_cart(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_cr_sort_sz(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_cr_sort_sz(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_lot(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_lot(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_lot_order(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_lot_order(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_dpbc(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_dpbc(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_dpbc(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_chk_digit(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_chk_digit(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_rec_type(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_rec_type(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_ace_fips_st(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_ace_fips_st(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_ace_fips_county(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_ace_fips_county(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_ace_fips_county(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_geo_lat(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_geo_lat(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_geo_long(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_geo_long(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_msa(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_msa(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_geo_blk(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_geo_blk(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_geo_match(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_geo_match(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_err_stat(SALT37.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_err_stat(SALT37.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_bdid(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_bdid(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_did(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_did(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_did_score(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_did_score(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_bdid_score(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_bdid_score(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_bdid_score(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_source_rec_id(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_source_rec_id(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_source_rec_id(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_dotid(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_dotid(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_dotscore(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_dotscore(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_dotweight(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_dotweight(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_empid(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_empid(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_empid(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_empscore(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_empscore(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_empweight(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_empweight(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_powid(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_powid(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_powid(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_powscore(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_powscore(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_powweight(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_powweight(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_proxid(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_proxid(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_proxscore(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_proxscore(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_proxweight(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_proxweight(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_seleid(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_seleid(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_selescore(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_selescore(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_seleweight(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_seleweight(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_orgid(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_orgid(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_orgscore(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_orgscore(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_orgweight(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_orgweight(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_ultid(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_ultid(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_ultscore(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_ultscore(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_ultweight(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_ultweight(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_prep_addr_line1(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line1(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_last_line(SALT37.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_last_line(SALT37.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_last_line(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_rawaid(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_rawaid(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_aceaid(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_aceaid(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_aceaid(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_persistent_record_id(SALT37.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_persistent_record_id(SALT37.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_persistent_record_id(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT37,Scrubs_UCCV2;
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
    BOOLEAN Diff_tmsid;
    BOOLEAN Diff_rmsid;
    BOOLEAN Diff_orig_name;
    BOOLEAN Diff_orig_lname;
    BOOLEAN Diff_orig_fname;
    BOOLEAN Diff_orig_mname;
    BOOLEAN Diff_orig_suffix;
    BOOLEAN Diff_duns_number;
    BOOLEAN Diff_hq_duns_number;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_fein;
    BOOLEAN Diff_incorp_state;
    BOOLEAN Diff_corp_number;
    BOOLEAN Diff_corp_type;
    BOOLEAN Diff_orig_address1;
    BOOLEAN Diff_orig_address2;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip5;
    BOOLEAN Diff_orig_zip4;
    BOOLEAN Diff_orig_country;
    BOOLEAN Diff_orig_province;
    BOOLEAN Diff_orig_postal_code;
    BOOLEAN Diff_foreign_indc;
    BOOLEAN Diff_party_type;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip5;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_county;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_ace_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_bdid_score;
    BOOLEAN Diff_source_rec_id;
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
    BOOLEAN Diff_prep_addr_line1;
    BOOLEAN Diff_prep_addr_last_line;
    BOOLEAN Diff_rawaid;
    BOOLEAN Diff_aceaid;
    BOOLEAN Diff_persistent_record_id;
    UNSIGNED Num_Diffs;
    SALT37.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_tmsid := le.tmsid <> ri.tmsid;
    SELF.Diff_rmsid := le.rmsid <> ri.rmsid;
    SELF.Diff_orig_name := le.orig_name <> ri.orig_name;
    SELF.Diff_orig_lname := le.orig_lname <> ri.orig_lname;
    SELF.Diff_orig_fname := le.orig_fname <> ri.orig_fname;
    SELF.Diff_orig_mname := le.orig_mname <> ri.orig_mname;
    SELF.Diff_orig_suffix := le.orig_suffix <> ri.orig_suffix;
    SELF.Diff_duns_number := le.duns_number <> ri.duns_number;
    SELF.Diff_hq_duns_number := le.hq_duns_number <> ri.hq_duns_number;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_fein := le.fein <> ri.fein;
    SELF.Diff_incorp_state := le.incorp_state <> ri.incorp_state;
    SELF.Diff_corp_number := le.corp_number <> ri.corp_number;
    SELF.Diff_corp_type := le.corp_type <> ri.corp_type;
    SELF.Diff_orig_address1 := le.orig_address1 <> ri.orig_address1;
    SELF.Diff_orig_address2 := le.orig_address2 <> ri.orig_address2;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip5 := le.orig_zip5 <> ri.orig_zip5;
    SELF.Diff_orig_zip4 := le.orig_zip4 <> ri.orig_zip4;
    SELF.Diff_orig_country := le.orig_country <> ri.orig_country;
    SELF.Diff_orig_province := le.orig_province <> ri.orig_province;
    SELF.Diff_orig_postal_code := le.orig_postal_code <> ri.orig_postal_code;
    SELF.Diff_foreign_indc := le.foreign_indc <> ri.foreign_indc;
    SELF.Diff_party_type := le.party_type <> ri.party_type;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip5 := le.zip5 <> ri.zip5;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_ace_fips_county := le.ace_fips_county <> ri.ace_fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_bdid_score := le.bdid_score <> ri.bdid_score;
    SELF.Diff_source_rec_id := le.source_rec_id <> ri.source_rec_id;
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
    SELF.Diff_prep_addr_line1 := le.prep_addr_line1 <> ri.prep_addr_line1;
    SELF.Diff_prep_addr_last_line := le.prep_addr_last_line <> ri.prep_addr_last_line;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Diff_aceaid := le.aceaid <> ri.aceaid;
    SELF.Diff_persistent_record_id := le.persistent_record_id <> ri.persistent_record_id;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_tmsid,1,0)+ IF( SELF.Diff_rmsid,1,0)+ IF( SELF.Diff_orig_name,1,0)+ IF( SELF.Diff_orig_lname,1,0)+ IF( SELF.Diff_orig_fname,1,0)+ IF( SELF.Diff_orig_mname,1,0)+ IF( SELF.Diff_orig_suffix,1,0)+ IF( SELF.Diff_duns_number,1,0)+ IF( SELF.Diff_hq_duns_number,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_fein,1,0)+ IF( SELF.Diff_incorp_state,1,0)+ IF( SELF.Diff_corp_number,1,0)+ IF( SELF.Diff_corp_type,1,0)+ IF( SELF.Diff_orig_address1,1,0)+ IF( SELF.Diff_orig_address2,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip5,1,0)+ IF( SELF.Diff_orig_zip4,1,0)+ IF( SELF.Diff_orig_country,1,0)+ IF( SELF.Diff_orig_province,1,0)+ IF( SELF.Diff_orig_postal_code,1,0)+ IF( SELF.Diff_foreign_indc,1,0)+ IF( SELF.Diff_party_type,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip5,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_ace_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_bdid_score,1,0)+ IF( SELF.Diff_source_rec_id,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_prep_addr_line1,1,0)+ IF( SELF.Diff_prep_addr_last_line,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_aceaid,1,0)+ IF( SELF.Diff_persistent_record_id,1,0);
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
    Count_Diff_tmsid := COUNT(GROUP,%Closest%.Diff_tmsid);
    Count_Diff_rmsid := COUNT(GROUP,%Closest%.Diff_rmsid);
    Count_Diff_orig_name := COUNT(GROUP,%Closest%.Diff_orig_name);
    Count_Diff_orig_lname := COUNT(GROUP,%Closest%.Diff_orig_lname);
    Count_Diff_orig_fname := COUNT(GROUP,%Closest%.Diff_orig_fname);
    Count_Diff_orig_mname := COUNT(GROUP,%Closest%.Diff_orig_mname);
    Count_Diff_orig_suffix := COUNT(GROUP,%Closest%.Diff_orig_suffix);
    Count_Diff_duns_number := COUNT(GROUP,%Closest%.Diff_duns_number);
    Count_Diff_hq_duns_number := COUNT(GROUP,%Closest%.Diff_hq_duns_number);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_fein := COUNT(GROUP,%Closest%.Diff_fein);
    Count_Diff_incorp_state := COUNT(GROUP,%Closest%.Diff_incorp_state);
    Count_Diff_corp_number := COUNT(GROUP,%Closest%.Diff_corp_number);
    Count_Diff_corp_type := COUNT(GROUP,%Closest%.Diff_corp_type);
    Count_Diff_orig_address1 := COUNT(GROUP,%Closest%.Diff_orig_address1);
    Count_Diff_orig_address2 := COUNT(GROUP,%Closest%.Diff_orig_address2);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip5 := COUNT(GROUP,%Closest%.Diff_orig_zip5);
    Count_Diff_orig_zip4 := COUNT(GROUP,%Closest%.Diff_orig_zip4);
    Count_Diff_orig_country := COUNT(GROUP,%Closest%.Diff_orig_country);
    Count_Diff_orig_province := COUNT(GROUP,%Closest%.Diff_orig_province);
    Count_Diff_orig_postal_code := COUNT(GROUP,%Closest%.Diff_orig_postal_code);
    Count_Diff_foreign_indc := COUNT(GROUP,%Closest%.Diff_foreign_indc);
    Count_Diff_party_type := COUNT(GROUP,%Closest%.Diff_party_type);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip5 := COUNT(GROUP,%Closest%.Diff_zip5);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_ace_fips_county := COUNT(GROUP,%Closest%.Diff_ace_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_bdid_score := COUNT(GROUP,%Closest%.Diff_bdid_score);
    Count_Diff_source_rec_id := COUNT(GROUP,%Closest%.Diff_source_rec_id);
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
    Count_Diff_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_addr_line1);
    Count_Diff_prep_addr_last_line := COUNT(GROUP,%Closest%.Diff_prep_addr_last_line);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
    Count_Diff_aceaid := COUNT(GROUP,%Closest%.Diff_aceaid);
    Count_Diff_persistent_record_id := COUNT(GROUP,%Closest%.Diff_persistent_record_id);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

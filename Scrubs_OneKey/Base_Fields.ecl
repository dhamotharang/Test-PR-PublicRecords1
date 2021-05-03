IMPORT SALT311;
IMPORT Scrubs_OneKey; // Import modules for FieldTypes attribute definitions
EXPORT Base_Fields := MODULE
 
EXPORT NumFields := 117;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_numeric','invalid_numeric_nonzero','invalid_pastdate8','invalid_mandatory','invalid_source','invalid_record_type','invalid_frst_nm','invalid_mid_nm','invalid_last_nm','invalid_prim_prfsn_cd','invalid_prim_prfsn_desc','invalid_prim_spcl_cd','invalid_prim_spcl_desc','invalid_sec_spcl_cd','invalid_sec_spcl_desc','invalid_tert_spcl_cd','invalid_tert_spcl_desc','invalid_sub_spcl_cd','invalid_sub_spcl_desc','invalid_titl_typ_id','invalid_titl_typ_desc','invalid_ok_wkp_id');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_numeric' => 1,'invalid_numeric_nonzero' => 2,'invalid_pastdate8' => 3,'invalid_mandatory' => 4,'invalid_source' => 5,'invalid_record_type' => 6,'invalid_frst_nm' => 7,'invalid_mid_nm' => 8,'invalid_last_nm' => 9,'invalid_prim_prfsn_cd' => 10,'invalid_prim_prfsn_desc' => 11,'invalid_prim_spcl_cd' => 12,'invalid_prim_spcl_desc' => 13,'invalid_sec_spcl_cd' => 14,'invalid_sec_spcl_desc' => 15,'invalid_tert_spcl_cd' => 16,'invalid_tert_spcl_desc' => 17,'invalid_sub_spcl_cd' => 18,'invalid_sub_spcl_desc' => 19,'invalid_titl_typ_id' => 20,'invalid_titl_typ_desc' => 21,'invalid_ok_wkp_id' => 22,0);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs_OneKey.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_nonzero(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric_nonzero(SALT311.StrType s) := WHICH(~Scrubs_OneKey.Functions.fn_numeric_nonzero(s)>0);
EXPORT InValidMessageFT_invalid_numeric_nonzero(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_numeric_nonzero'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate8(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate8(SALT311.StrType s) := WHICH(~Scrubs_OneKey.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate8(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_past_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~Scrubs_OneKey.Functions.fn_populated_strings(s)>0);
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_source(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_source(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['SK','09']);
EXPORT InValidMessageFT_invalid_source(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('SK|09'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['C','H']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('C|H'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_frst_nm(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_frst_nm(SALT311.StrType s,SALT311.StrType mid_nm,SALT311.StrType last_nm) := WHICH(~Scrubs_OneKey.Functions.fn_populated_strings(s,mid_nm,last_nm)>0);
EXPORT InValidMessageFT_invalid_frst_nm(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mid_nm(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mid_nm(SALT311.StrType s,SALT311.StrType frst_nm,SALT311.StrType last_nm) := WHICH(~Scrubs_OneKey.Functions.fn_populated_strings(s,frst_nm,last_nm)>0);
EXPORT InValidMessageFT_invalid_mid_nm(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_last_nm(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_last_nm(SALT311.StrType s,SALT311.StrType frst_nm,SALT311.StrType mid_nm) := WHICH(~Scrubs_OneKey.Functions.fn_populated_strings(s,frst_nm,mid_nm)>0);
EXPORT InValidMessageFT_invalid_last_nm(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_prim_prfsn_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_prim_prfsn_cd(SALT311.StrType s,SALT311.StrType prim_prfsn_desc) := WHICH(~Scrubs_OneKey.Functions.fn_str1_xor_str2(s,prim_prfsn_desc)>0);
EXPORT InValidMessageFT_invalid_prim_prfsn_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_prim_prfsn_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_prim_prfsn_desc(SALT311.StrType s,SALT311.StrType prim_prfsn_cd) := WHICH(~Scrubs_OneKey.Functions.fn_str1_xor_str2(s,prim_prfsn_cd)>0);
EXPORT InValidMessageFT_invalid_prim_prfsn_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_prim_spcl_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_prim_spcl_cd(SALT311.StrType s,SALT311.StrType prim_spcl_desc) := WHICH(~Scrubs_OneKey.Functions.fn_str1_xor_str2(s,prim_spcl_desc)>0);
EXPORT InValidMessageFT_invalid_prim_spcl_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_prim_spcl_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_prim_spcl_desc(SALT311.StrType s,SALT311.StrType prim_spcl_cd) := WHICH(~Scrubs_OneKey.Functions.fn_str1_xor_str2(s,prim_spcl_cd)>0);
EXPORT InValidMessageFT_invalid_prim_spcl_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sec_spcl_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sec_spcl_cd(SALT311.StrType s,SALT311.StrType sec_spcl_desc) := WHICH(~Scrubs_OneKey.Functions.fn_str1_xor_str2(s,sec_spcl_desc)>0);
EXPORT InValidMessageFT_invalid_sec_spcl_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sec_spcl_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sec_spcl_desc(SALT311.StrType s,SALT311.StrType sec_spcl_cd) := WHICH(~Scrubs_OneKey.Functions.fn_str1_xor_str2(s,sec_spcl_cd)>0);
EXPORT InValidMessageFT_invalid_sec_spcl_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_tert_spcl_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_tert_spcl_cd(SALT311.StrType s,SALT311.StrType tert_spcl_desc) := WHICH(~Scrubs_OneKey.Functions.fn_str1_xor_str2(s,tert_spcl_desc)>0);
EXPORT InValidMessageFT_invalid_tert_spcl_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_tert_spcl_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_tert_spcl_desc(SALT311.StrType s,SALT311.StrType tert_spcl_cd) := WHICH(~Scrubs_OneKey.Functions.fn_str1_xor_str2(s,tert_spcl_cd)>0);
EXPORT InValidMessageFT_invalid_tert_spcl_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sub_spcl_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sub_spcl_cd(SALT311.StrType s,SALT311.StrType sub_spcl_desc) := WHICH(~Scrubs_OneKey.Functions.fn_str1_xor_str2(s,sub_spcl_desc)>0);
EXPORT InValidMessageFT_invalid_sub_spcl_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sub_spcl_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sub_spcl_desc(SALT311.StrType s,SALT311.StrType sub_spcl_cd) := WHICH(~Scrubs_OneKey.Functions.fn_str1_xor_str2(s,sub_spcl_cd)>0);
EXPORT InValidMessageFT_invalid_sub_spcl_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_titl_typ_id(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_titl_typ_id(SALT311.StrType s,SALT311.StrType titl_typ_desc) := WHICH(~Scrubs_OneKey.Functions.fn_str1_xor_str2(s,titl_typ_desc)>0);
EXPORT InValidMessageFT_invalid_titl_typ_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_titl_typ_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_titl_typ_desc(SALT311.StrType s,SALT311.StrType titl_typ_id) := WHICH(~Scrubs_OneKey.Functions.fn_str1_xor_str2(s,titl_typ_id)>0);
EXPORT InValidMessageFT_invalid_titl_typ_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ok_wkp_id(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ok_wkp_id(SALT311.StrType s) := WHICH(~Scrubs_OneKey.Functions.fn_onekey_id(s)>0);
EXPORT InValidMessageFT_invalid_ok_wkp_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_onekey_id'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'source','bdid','bdid_score','source_rec_id','dt_vendor_first_reported','dt_vendor_last_reported','record_type','hcp_hce_id','ok_indv_id','ska_uid','frst_nm','mid_nm','last_nm','sfx_cd','gender_cd','prim_prfsn_cd','prim_prfsn_desc','prim_spcl_cd','prim_spcl_desc','sec_spcl_cd','sec_spcl_desc','tert_spcl_cd','tert_spcl_desc','sub_spcl_cd','sub_spcl_desc','titl_typ_id','titl_typ_desc','hco_hce_id','ok_wkp_id','ska_id','bus_nm','dba_nm','addr_id','str_front_id','addr_ln_1_txt','addr_ln_2_txt','city_nm','st_cd','zip5_cd','zip4_cd','fips_cnty_cd','fips_cnty_desc','telephn_nbr','cot_id','cot_clas_id','cot_clas_desc','cot_fclt_typ_id','cot_fclt_typ_desc','cot_spcl_id','cot_spcl_desc','email_ind_flag','ims_id','hce_prfsnl_stat_cd','hce_prfsnl_stat_desc','excld_rsn_desc','npi','deactv_dt','cleaned_deactv_dt','xref_hce_id','title','fname','mname','lname','name_suffix','name_score','prep_addr_line1','prep_addr_line_last','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'source','bdid','bdid_score','source_rec_id','dt_vendor_first_reported','dt_vendor_last_reported','record_type','hcp_hce_id','ok_indv_id','ska_uid','frst_nm','mid_nm','last_nm','sfx_cd','gender_cd','prim_prfsn_cd','prim_prfsn_desc','prim_spcl_cd','prim_spcl_desc','sec_spcl_cd','sec_spcl_desc','tert_spcl_cd','tert_spcl_desc','sub_spcl_cd','sub_spcl_desc','titl_typ_id','titl_typ_desc','hco_hce_id','ok_wkp_id','ska_id','bus_nm','dba_nm','addr_id','str_front_id','addr_ln_1_txt','addr_ln_2_txt','city_nm','st_cd','zip5_cd','zip4_cd','fips_cnty_cd','fips_cnty_desc','telephn_nbr','cot_id','cot_clas_id','cot_clas_desc','cot_fclt_typ_id','cot_fclt_typ_desc','cot_spcl_id','cot_spcl_desc','email_ind_flag','ims_id','hce_prfsnl_stat_cd','hce_prfsnl_stat_desc','excld_rsn_desc','npi','deactv_dt','cleaned_deactv_dt','xref_hce_id','title','fname','mname','lname','name_suffix','name_score','prep_addr_line1','prep_addr_line_last','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'source' => 0,'bdid' => 1,'bdid_score' => 2,'source_rec_id' => 3,'dt_vendor_first_reported' => 4,'dt_vendor_last_reported' => 5,'record_type' => 6,'hcp_hce_id' => 7,'ok_indv_id' => 8,'ska_uid' => 9,'frst_nm' => 10,'mid_nm' => 11,'last_nm' => 12,'sfx_cd' => 13,'gender_cd' => 14,'prim_prfsn_cd' => 15,'prim_prfsn_desc' => 16,'prim_spcl_cd' => 17,'prim_spcl_desc' => 18,'sec_spcl_cd' => 19,'sec_spcl_desc' => 20,'tert_spcl_cd' => 21,'tert_spcl_desc' => 22,'sub_spcl_cd' => 23,'sub_spcl_desc' => 24,'titl_typ_id' => 25,'titl_typ_desc' => 26,'hco_hce_id' => 27,'ok_wkp_id' => 28,'ska_id' => 29,'bus_nm' => 30,'dba_nm' => 31,'addr_id' => 32,'str_front_id' => 33,'addr_ln_1_txt' => 34,'addr_ln_2_txt' => 35,'city_nm' => 36,'st_cd' => 37,'zip5_cd' => 38,'zip4_cd' => 39,'fips_cnty_cd' => 40,'fips_cnty_desc' => 41,'telephn_nbr' => 42,'cot_id' => 43,'cot_clas_id' => 44,'cot_clas_desc' => 45,'cot_fclt_typ_id' => 46,'cot_fclt_typ_desc' => 47,'cot_spcl_id' => 48,'cot_spcl_desc' => 49,'email_ind_flag' => 50,'ims_id' => 51,'hce_prfsnl_stat_cd' => 52,'hce_prfsnl_stat_desc' => 53,'excld_rsn_desc' => 54,'npi' => 55,'deactv_dt' => 56,'cleaned_deactv_dt' => 57,'xref_hce_id' => 58,'title' => 59,'fname' => 60,'mname' => 61,'lname' => 62,'name_suffix' => 63,'name_score' => 64,'prep_addr_line1' => 65,'prep_addr_line_last' => 66,'prim_range' => 67,'predir' => 68,'prim_name' => 69,'addr_suffix' => 70,'postdir' => 71,'unit_desig' => 72,'sec_range' => 73,'p_city_name' => 74,'v_city_name' => 75,'st' => 76,'zip' => 77,'zip4' => 78,'cart' => 79,'cr_sort_sz' => 80,'lot' => 81,'lot_order' => 82,'dbpc' => 83,'chk_digit' => 84,'rec_type' => 85,'fips_state' => 86,'fips_county' => 87,'geo_lat' => 88,'geo_long' => 89,'msa' => 90,'geo_blk' => 91,'geo_match' => 92,'err_stat' => 93,'raw_aid' => 94,'ace_aid' => 95,'dotid' => 96,'dotscore' => 97,'dotweight' => 98,'empid' => 99,'empscore' => 100,'empweight' => 101,'powid' => 102,'powscore' => 103,'powweight' => 104,'proxid' => 105,'proxscore' => 106,'proxweight' => 107,'seleid' => 108,'selescore' => 109,'seleweight' => 110,'orgid' => 111,'orgscore' => 112,'orgweight' => 113,'ultid' => 114,'ultscore' => 115,'ultweight' => 116,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ENUM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_source(SALT311.StrType s0) := MakeFT_invalid_source(s0);
EXPORT InValid_source(SALT311.StrType s) := InValidFT_invalid_source(s);
EXPORT InValidMessage_source(UNSIGNED1 wh) := InValidMessageFT_invalid_source(wh);
 
EXPORT Make_bdid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bdid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_bdid_score(SALT311.StrType s0) := s0;
EXPORT InValid_bdid_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_bdid_score(UNSIGNED1 wh) := '';
 
EXPORT Make_source_rec_id(SALT311.StrType s0) := MakeFT_invalid_numeric_nonzero(s0);
EXPORT InValid_source_rec_id(SALT311.StrType s) := InValidFT_invalid_numeric_nonzero(s);
EXPORT InValidMessage_source_rec_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_nonzero(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT311.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_hcp_hce_id(SALT311.StrType s0) := MakeFT_invalid_numeric_nonzero(s0);
EXPORT InValid_hcp_hce_id(SALT311.StrType s) := InValidFT_invalid_numeric_nonzero(s);
EXPORT InValidMessage_hcp_hce_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_nonzero(wh);
 
EXPORT Make_ok_indv_id(SALT311.StrType s0) := s0;
EXPORT InValid_ok_indv_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_ok_indv_id(UNSIGNED1 wh) := '';
 
EXPORT Make_ska_uid(SALT311.StrType s0) := s0;
EXPORT InValid_ska_uid(SALT311.StrType s) := 0;
EXPORT InValidMessage_ska_uid(UNSIGNED1 wh) := '';
 
EXPORT Make_frst_nm(SALT311.StrType s0) := MakeFT_invalid_frst_nm(s0);
EXPORT InValid_frst_nm(SALT311.StrType s,SALT311.StrType mid_nm,SALT311.StrType last_nm) := InValidFT_invalid_frst_nm(s,mid_nm,last_nm);
EXPORT InValidMessage_frst_nm(UNSIGNED1 wh) := InValidMessageFT_invalid_frst_nm(wh);
 
EXPORT Make_mid_nm(SALT311.StrType s0) := MakeFT_invalid_mid_nm(s0);
EXPORT InValid_mid_nm(SALT311.StrType s,SALT311.StrType frst_nm,SALT311.StrType last_nm) := InValidFT_invalid_mid_nm(s,frst_nm,last_nm);
EXPORT InValidMessage_mid_nm(UNSIGNED1 wh) := InValidMessageFT_invalid_mid_nm(wh);
 
EXPORT Make_last_nm(SALT311.StrType s0) := MakeFT_invalid_last_nm(s0);
EXPORT InValid_last_nm(SALT311.StrType s,SALT311.StrType frst_nm,SALT311.StrType mid_nm) := InValidFT_invalid_last_nm(s,frst_nm,mid_nm);
EXPORT InValidMessage_last_nm(UNSIGNED1 wh) := InValidMessageFT_invalid_last_nm(wh);
 
EXPORT Make_sfx_cd(SALT311.StrType s0) := s0;
EXPORT InValid_sfx_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_sfx_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_gender_cd(SALT311.StrType s0) := s0;
EXPORT InValid_gender_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_gender_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_prfsn_cd(SALT311.StrType s0) := MakeFT_invalid_prim_prfsn_cd(s0);
EXPORT InValid_prim_prfsn_cd(SALT311.StrType s,SALT311.StrType prim_prfsn_desc) := InValidFT_invalid_prim_prfsn_cd(s,prim_prfsn_desc);
EXPORT InValidMessage_prim_prfsn_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_prim_prfsn_cd(wh);
 
EXPORT Make_prim_prfsn_desc(SALT311.StrType s0) := MakeFT_invalid_prim_prfsn_desc(s0);
EXPORT InValid_prim_prfsn_desc(SALT311.StrType s,SALT311.StrType prim_prfsn_cd) := InValidFT_invalid_prim_prfsn_desc(s,prim_prfsn_cd);
EXPORT InValidMessage_prim_prfsn_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_prim_prfsn_desc(wh);
 
EXPORT Make_prim_spcl_cd(SALT311.StrType s0) := MakeFT_invalid_prim_spcl_cd(s0);
EXPORT InValid_prim_spcl_cd(SALT311.StrType s,SALT311.StrType prim_spcl_desc) := InValidFT_invalid_prim_spcl_cd(s,prim_spcl_desc);
EXPORT InValidMessage_prim_spcl_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_prim_spcl_cd(wh);
 
EXPORT Make_prim_spcl_desc(SALT311.StrType s0) := MakeFT_invalid_prim_spcl_desc(s0);
EXPORT InValid_prim_spcl_desc(SALT311.StrType s,SALT311.StrType prim_spcl_cd) := InValidFT_invalid_prim_spcl_desc(s,prim_spcl_cd);
EXPORT InValidMessage_prim_spcl_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_prim_spcl_desc(wh);
 
EXPORT Make_sec_spcl_cd(SALT311.StrType s0) := MakeFT_invalid_sec_spcl_cd(s0);
EXPORT InValid_sec_spcl_cd(SALT311.StrType s,SALT311.StrType sec_spcl_desc) := InValidFT_invalid_sec_spcl_cd(s,sec_spcl_desc);
EXPORT InValidMessage_sec_spcl_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_sec_spcl_cd(wh);
 
EXPORT Make_sec_spcl_desc(SALT311.StrType s0) := MakeFT_invalid_sec_spcl_desc(s0);
EXPORT InValid_sec_spcl_desc(SALT311.StrType s,SALT311.StrType sec_spcl_cd) := InValidFT_invalid_sec_spcl_desc(s,sec_spcl_cd);
EXPORT InValidMessage_sec_spcl_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_sec_spcl_desc(wh);
 
EXPORT Make_tert_spcl_cd(SALT311.StrType s0) := MakeFT_invalid_tert_spcl_cd(s0);
EXPORT InValid_tert_spcl_cd(SALT311.StrType s,SALT311.StrType tert_spcl_desc) := InValidFT_invalid_tert_spcl_cd(s,tert_spcl_desc);
EXPORT InValidMessage_tert_spcl_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_tert_spcl_cd(wh);
 
EXPORT Make_tert_spcl_desc(SALT311.StrType s0) := MakeFT_invalid_tert_spcl_desc(s0);
EXPORT InValid_tert_spcl_desc(SALT311.StrType s,SALT311.StrType tert_spcl_cd) := InValidFT_invalid_tert_spcl_desc(s,tert_spcl_cd);
EXPORT InValidMessage_tert_spcl_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_tert_spcl_desc(wh);
 
EXPORT Make_sub_spcl_cd(SALT311.StrType s0) := MakeFT_invalid_sub_spcl_cd(s0);
EXPORT InValid_sub_spcl_cd(SALT311.StrType s,SALT311.StrType sub_spcl_desc) := InValidFT_invalid_sub_spcl_cd(s,sub_spcl_desc);
EXPORT InValidMessage_sub_spcl_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_sub_spcl_cd(wh);
 
EXPORT Make_sub_spcl_desc(SALT311.StrType s0) := MakeFT_invalid_sub_spcl_desc(s0);
EXPORT InValid_sub_spcl_desc(SALT311.StrType s,SALT311.StrType sub_spcl_cd) := InValidFT_invalid_sub_spcl_desc(s,sub_spcl_cd);
EXPORT InValidMessage_sub_spcl_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_sub_spcl_desc(wh);
 
EXPORT Make_titl_typ_id(SALT311.StrType s0) := MakeFT_invalid_titl_typ_id(s0);
EXPORT InValid_titl_typ_id(SALT311.StrType s,SALT311.StrType titl_typ_desc) := InValidFT_invalid_titl_typ_id(s,titl_typ_desc);
EXPORT InValidMessage_titl_typ_id(UNSIGNED1 wh) := InValidMessageFT_invalid_titl_typ_id(wh);
 
EXPORT Make_titl_typ_desc(SALT311.StrType s0) := MakeFT_invalid_titl_typ_desc(s0);
EXPORT InValid_titl_typ_desc(SALT311.StrType s,SALT311.StrType titl_typ_id) := InValidFT_invalid_titl_typ_desc(s,titl_typ_id);
EXPORT InValidMessage_titl_typ_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_titl_typ_desc(wh);
 
EXPORT Make_hco_hce_id(SALT311.StrType s0) := MakeFT_invalid_numeric_nonzero(s0);
EXPORT InValid_hco_hce_id(SALT311.StrType s) := InValidFT_invalid_numeric_nonzero(s);
EXPORT InValidMessage_hco_hce_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_nonzero(wh);
 
EXPORT Make_ok_wkp_id(SALT311.StrType s0) := MakeFT_invalid_ok_wkp_id(s0);
EXPORT InValid_ok_wkp_id(SALT311.StrType s) := InValidFT_invalid_ok_wkp_id(s);
EXPORT InValidMessage_ok_wkp_id(UNSIGNED1 wh) := InValidMessageFT_invalid_ok_wkp_id(wh);
 
EXPORT Make_ska_id(SALT311.StrType s0) := MakeFT_invalid_numeric_nonzero(s0);
EXPORT InValid_ska_id(SALT311.StrType s) := InValidFT_invalid_numeric_nonzero(s);
EXPORT InValidMessage_ska_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_nonzero(wh);
 
EXPORT Make_bus_nm(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_bus_nm(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_bus_nm(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_dba_nm(SALT311.StrType s0) := s0;
EXPORT InValid_dba_nm(SALT311.StrType s) := 0;
EXPORT InValidMessage_dba_nm(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_id(SALT311.StrType s0) := s0;
EXPORT InValid_addr_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_addr_id(UNSIGNED1 wh) := '';
 
EXPORT Make_str_front_id(SALT311.StrType s0) := s0;
EXPORT InValid_str_front_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_str_front_id(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_ln_1_txt(SALT311.StrType s0) := s0;
EXPORT InValid_addr_ln_1_txt(SALT311.StrType s) := 0;
EXPORT InValidMessage_addr_ln_1_txt(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_ln_2_txt(SALT311.StrType s0) := s0;
EXPORT InValid_addr_ln_2_txt(SALT311.StrType s) := 0;
EXPORT InValidMessage_addr_ln_2_txt(UNSIGNED1 wh) := '';
 
EXPORT Make_city_nm(SALT311.StrType s0) := s0;
EXPORT InValid_city_nm(SALT311.StrType s) := 0;
EXPORT InValidMessage_city_nm(UNSIGNED1 wh) := '';
 
EXPORT Make_st_cd(SALT311.StrType s0) := s0;
EXPORT InValid_st_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_st_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_zip5_cd(SALT311.StrType s0) := s0;
EXPORT InValid_zip5_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip5_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4_cd(SALT311.StrType s0) := s0;
EXPORT InValid_zip4_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip4_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_cnty_cd(SALT311.StrType s0) := s0;
EXPORT InValid_fips_cnty_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_fips_cnty_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_cnty_desc(SALT311.StrType s0) := s0;
EXPORT InValid_fips_cnty_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_fips_cnty_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_telephn_nbr(SALT311.StrType s0) := s0;
EXPORT InValid_telephn_nbr(SALT311.StrType s) := 0;
EXPORT InValidMessage_telephn_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_cot_id(SALT311.StrType s0) := s0;
EXPORT InValid_cot_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_cot_id(UNSIGNED1 wh) := '';
 
EXPORT Make_cot_clas_id(SALT311.StrType s0) := s0;
EXPORT InValid_cot_clas_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_cot_clas_id(UNSIGNED1 wh) := '';
 
EXPORT Make_cot_clas_desc(SALT311.StrType s0) := s0;
EXPORT InValid_cot_clas_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_cot_clas_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cot_fclt_typ_id(SALT311.StrType s0) := s0;
EXPORT InValid_cot_fclt_typ_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_cot_fclt_typ_id(UNSIGNED1 wh) := '';
 
EXPORT Make_cot_fclt_typ_desc(SALT311.StrType s0) := s0;
EXPORT InValid_cot_fclt_typ_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_cot_fclt_typ_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cot_spcl_id(SALT311.StrType s0) := s0;
EXPORT InValid_cot_spcl_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_cot_spcl_id(UNSIGNED1 wh) := '';
 
EXPORT Make_cot_spcl_desc(SALT311.StrType s0) := s0;
EXPORT InValid_cot_spcl_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_cot_spcl_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_email_ind_flag(SALT311.StrType s0) := s0;
EXPORT InValid_email_ind_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_email_ind_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_ims_id(SALT311.StrType s0) := s0;
EXPORT InValid_ims_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_ims_id(UNSIGNED1 wh) := '';
 
EXPORT Make_hce_prfsnl_stat_cd(SALT311.StrType s0) := s0;
EXPORT InValid_hce_prfsnl_stat_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_hce_prfsnl_stat_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_hce_prfsnl_stat_desc(SALT311.StrType s0) := s0;
EXPORT InValid_hce_prfsnl_stat_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_hce_prfsnl_stat_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_excld_rsn_desc(SALT311.StrType s0) := s0;
EXPORT InValid_excld_rsn_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_excld_rsn_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_npi(SALT311.StrType s0) := s0;
EXPORT InValid_npi(SALT311.StrType s) := 0;
EXPORT InValidMessage_npi(UNSIGNED1 wh) := '';
 
EXPORT Make_deactv_dt(SALT311.StrType s0) := s0;
EXPORT InValid_deactv_dt(SALT311.StrType s) := 0;
EXPORT InValidMessage_deactv_dt(UNSIGNED1 wh) := '';
 
EXPORT Make_cleaned_deactv_dt(SALT311.StrType s0) := s0;
EXPORT InValid_cleaned_deactv_dt(SALT311.StrType s) := 0;
EXPORT InValidMessage_cleaned_deactv_dt(UNSIGNED1 wh) := '';
 
EXPORT Make_xref_hce_id(SALT311.StrType s0) := s0;
EXPORT InValid_xref_hce_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_xref_hce_id(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT311.StrType s0) := s0;
EXPORT InValid_title(SALT311.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT311.StrType s0) := s0;
EXPORT InValid_fname(SALT311.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT311.StrType s0) := s0;
EXPORT InValid_mname(SALT311.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT311.StrType s0) := s0;
EXPORT InValid_lname(SALT311.StrType s) := 0;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_name_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_name_score(SALT311.StrType s0) := s0;
EXPORT InValid_name_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_prep_addr_line1(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line1(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_line_last(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line_last(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prim_range(SALT311.StrType s0) := s0;
EXPORT InValid_prim_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT311.StrType s0) := s0;
EXPORT InValid_predir(SALT311.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT311.StrType s0) := s0;
EXPORT InValid_prim_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT311.StrType s0) := s0;
EXPORT InValid_postdir(SALT311.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT311.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT311.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT311.StrType s0) := s0;
EXPORT InValid_sec_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT311.StrType s0) := s0;
EXPORT InValid_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT311.StrType s0) := s0;
EXPORT InValid_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4(SALT311.StrType s0) := s0;
EXPORT InValid_zip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_cart(SALT311.StrType s0) := s0;
EXPORT InValid_cart(SALT311.StrType s) := 0;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz(SALT311.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT311.StrType s) := 0;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_lot(SALT311.StrType s0) := s0;
EXPORT InValid_lot(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_order(SALT311.StrType s0) := s0;
EXPORT InValid_lot_order(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_dbpc(SALT311.StrType s0) := s0;
EXPORT InValid_dbpc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT311.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT311.StrType s) := 0;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type(SALT311.StrType s0) := s0;
EXPORT InValid_rec_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_state(SALT311.StrType s0) := s0;
EXPORT InValid_fips_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_fips_state(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_county(SALT311.StrType s0) := s0;
EXPORT InValid_fips_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat(SALT311.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long(SALT311.StrType s0) := s0;
EXPORT InValid_geo_long(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_msa(SALT311.StrType s0) := s0;
EXPORT InValid_msa(SALT311.StrType s) := 0;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk(SALT311.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT311.StrType s0) := s0;
EXPORT InValid_geo_match(SALT311.StrType s) := 0;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat(SALT311.StrType s0) := s0;
EXPORT InValid_err_stat(SALT311.StrType s) := 0;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_raw_aid(SALT311.StrType s0) := s0;
EXPORT InValid_raw_aid(SALT311.StrType s) := 0;
EXPORT InValidMessage_raw_aid(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_aid(SALT311.StrType s0) := s0;
EXPORT InValid_ace_aid(SALT311.StrType s) := 0;
EXPORT InValidMessage_ace_aid(UNSIGNED1 wh) := '';
 
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
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_OneKey;
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
    BOOLEAN Diff_source;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_bdid_score;
    BOOLEAN Diff_source_rec_id;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_hcp_hce_id;
    BOOLEAN Diff_ok_indv_id;
    BOOLEAN Diff_ska_uid;
    BOOLEAN Diff_frst_nm;
    BOOLEAN Diff_mid_nm;
    BOOLEAN Diff_last_nm;
    BOOLEAN Diff_sfx_cd;
    BOOLEAN Diff_gender_cd;
    BOOLEAN Diff_prim_prfsn_cd;
    BOOLEAN Diff_prim_prfsn_desc;
    BOOLEAN Diff_prim_spcl_cd;
    BOOLEAN Diff_prim_spcl_desc;
    BOOLEAN Diff_sec_spcl_cd;
    BOOLEAN Diff_sec_spcl_desc;
    BOOLEAN Diff_tert_spcl_cd;
    BOOLEAN Diff_tert_spcl_desc;
    BOOLEAN Diff_sub_spcl_cd;
    BOOLEAN Diff_sub_spcl_desc;
    BOOLEAN Diff_titl_typ_id;
    BOOLEAN Diff_titl_typ_desc;
    BOOLEAN Diff_hco_hce_id;
    BOOLEAN Diff_ok_wkp_id;
    BOOLEAN Diff_ska_id;
    BOOLEAN Diff_bus_nm;
    BOOLEAN Diff_dba_nm;
    BOOLEAN Diff_addr_id;
    BOOLEAN Diff_str_front_id;
    BOOLEAN Diff_addr_ln_1_txt;
    BOOLEAN Diff_addr_ln_2_txt;
    BOOLEAN Diff_city_nm;
    BOOLEAN Diff_st_cd;
    BOOLEAN Diff_zip5_cd;
    BOOLEAN Diff_zip4_cd;
    BOOLEAN Diff_fips_cnty_cd;
    BOOLEAN Diff_fips_cnty_desc;
    BOOLEAN Diff_telephn_nbr;
    BOOLEAN Diff_cot_id;
    BOOLEAN Diff_cot_clas_id;
    BOOLEAN Diff_cot_clas_desc;
    BOOLEAN Diff_cot_fclt_typ_id;
    BOOLEAN Diff_cot_fclt_typ_desc;
    BOOLEAN Diff_cot_spcl_id;
    BOOLEAN Diff_cot_spcl_desc;
    BOOLEAN Diff_email_ind_flag;
    BOOLEAN Diff_ims_id;
    BOOLEAN Diff_hce_prfsnl_stat_cd;
    BOOLEAN Diff_hce_prfsnl_stat_desc;
    BOOLEAN Diff_excld_rsn_desc;
    BOOLEAN Diff_npi;
    BOOLEAN Diff_deactv_dt;
    BOOLEAN Diff_cleaned_deactv_dt;
    BOOLEAN Diff_xref_hce_id;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_prep_addr_line1;
    BOOLEAN Diff_prep_addr_line_last;
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
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_bdid_score := le.bdid_score <> ri.bdid_score;
    SELF.Diff_source_rec_id := le.source_rec_id <> ri.source_rec_id;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_hcp_hce_id := le.hcp_hce_id <> ri.hcp_hce_id;
    SELF.Diff_ok_indv_id := le.ok_indv_id <> ri.ok_indv_id;
    SELF.Diff_ska_uid := le.ska_uid <> ri.ska_uid;
    SELF.Diff_frst_nm := le.frst_nm <> ri.frst_nm;
    SELF.Diff_mid_nm := le.mid_nm <> ri.mid_nm;
    SELF.Diff_last_nm := le.last_nm <> ri.last_nm;
    SELF.Diff_sfx_cd := le.sfx_cd <> ri.sfx_cd;
    SELF.Diff_gender_cd := le.gender_cd <> ri.gender_cd;
    SELF.Diff_prim_prfsn_cd := le.prim_prfsn_cd <> ri.prim_prfsn_cd;
    SELF.Diff_prim_prfsn_desc := le.prim_prfsn_desc <> ri.prim_prfsn_desc;
    SELF.Diff_prim_spcl_cd := le.prim_spcl_cd <> ri.prim_spcl_cd;
    SELF.Diff_prim_spcl_desc := le.prim_spcl_desc <> ri.prim_spcl_desc;
    SELF.Diff_sec_spcl_cd := le.sec_spcl_cd <> ri.sec_spcl_cd;
    SELF.Diff_sec_spcl_desc := le.sec_spcl_desc <> ri.sec_spcl_desc;
    SELF.Diff_tert_spcl_cd := le.tert_spcl_cd <> ri.tert_spcl_cd;
    SELF.Diff_tert_spcl_desc := le.tert_spcl_desc <> ri.tert_spcl_desc;
    SELF.Diff_sub_spcl_cd := le.sub_spcl_cd <> ri.sub_spcl_cd;
    SELF.Diff_sub_spcl_desc := le.sub_spcl_desc <> ri.sub_spcl_desc;
    SELF.Diff_titl_typ_id := le.titl_typ_id <> ri.titl_typ_id;
    SELF.Diff_titl_typ_desc := le.titl_typ_desc <> ri.titl_typ_desc;
    SELF.Diff_hco_hce_id := le.hco_hce_id <> ri.hco_hce_id;
    SELF.Diff_ok_wkp_id := le.ok_wkp_id <> ri.ok_wkp_id;
    SELF.Diff_ska_id := le.ska_id <> ri.ska_id;
    SELF.Diff_bus_nm := le.bus_nm <> ri.bus_nm;
    SELF.Diff_dba_nm := le.dba_nm <> ri.dba_nm;
    SELF.Diff_addr_id := le.addr_id <> ri.addr_id;
    SELF.Diff_str_front_id := le.str_front_id <> ri.str_front_id;
    SELF.Diff_addr_ln_1_txt := le.addr_ln_1_txt <> ri.addr_ln_1_txt;
    SELF.Diff_addr_ln_2_txt := le.addr_ln_2_txt <> ri.addr_ln_2_txt;
    SELF.Diff_city_nm := le.city_nm <> ri.city_nm;
    SELF.Diff_st_cd := le.st_cd <> ri.st_cd;
    SELF.Diff_zip5_cd := le.zip5_cd <> ri.zip5_cd;
    SELF.Diff_zip4_cd := le.zip4_cd <> ri.zip4_cd;
    SELF.Diff_fips_cnty_cd := le.fips_cnty_cd <> ri.fips_cnty_cd;
    SELF.Diff_fips_cnty_desc := le.fips_cnty_desc <> ri.fips_cnty_desc;
    SELF.Diff_telephn_nbr := le.telephn_nbr <> ri.telephn_nbr;
    SELF.Diff_cot_id := le.cot_id <> ri.cot_id;
    SELF.Diff_cot_clas_id := le.cot_clas_id <> ri.cot_clas_id;
    SELF.Diff_cot_clas_desc := le.cot_clas_desc <> ri.cot_clas_desc;
    SELF.Diff_cot_fclt_typ_id := le.cot_fclt_typ_id <> ri.cot_fclt_typ_id;
    SELF.Diff_cot_fclt_typ_desc := le.cot_fclt_typ_desc <> ri.cot_fclt_typ_desc;
    SELF.Diff_cot_spcl_id := le.cot_spcl_id <> ri.cot_spcl_id;
    SELF.Diff_cot_spcl_desc := le.cot_spcl_desc <> ri.cot_spcl_desc;
    SELF.Diff_email_ind_flag := le.email_ind_flag <> ri.email_ind_flag;
    SELF.Diff_ims_id := le.ims_id <> ri.ims_id;
    SELF.Diff_hce_prfsnl_stat_cd := le.hce_prfsnl_stat_cd <> ri.hce_prfsnl_stat_cd;
    SELF.Diff_hce_prfsnl_stat_desc := le.hce_prfsnl_stat_desc <> ri.hce_prfsnl_stat_desc;
    SELF.Diff_excld_rsn_desc := le.excld_rsn_desc <> ri.excld_rsn_desc;
    SELF.Diff_npi := le.npi <> ri.npi;
    SELF.Diff_deactv_dt := le.deactv_dt <> ri.deactv_dt;
    SELF.Diff_cleaned_deactv_dt := le.cleaned_deactv_dt <> ri.cleaned_deactv_dt;
    SELF.Diff_xref_hce_id := le.xref_hce_id <> ri.xref_hce_id;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_prep_addr_line1 := le.prep_addr_line1 <> ri.prep_addr_line1;
    SELF.Diff_prep_addr_line_last := le.prep_addr_line_last <> ri.prep_addr_line_last;
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
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_bdid_score,1,0)+ IF( SELF.Diff_source_rec_id,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_hcp_hce_id,1,0)+ IF( SELF.Diff_ok_indv_id,1,0)+ IF( SELF.Diff_ska_uid,1,0)+ IF( SELF.Diff_frst_nm,1,0)+ IF( SELF.Diff_mid_nm,1,0)+ IF( SELF.Diff_last_nm,1,0)+ IF( SELF.Diff_sfx_cd,1,0)+ IF( SELF.Diff_gender_cd,1,0)+ IF( SELF.Diff_prim_prfsn_cd,1,0)+ IF( SELF.Diff_prim_prfsn_desc,1,0)+ IF( SELF.Diff_prim_spcl_cd,1,0)+ IF( SELF.Diff_prim_spcl_desc,1,0)+ IF( SELF.Diff_sec_spcl_cd,1,0)+ IF( SELF.Diff_sec_spcl_desc,1,0)+ IF( SELF.Diff_tert_spcl_cd,1,0)+ IF( SELF.Diff_tert_spcl_desc,1,0)+ IF( SELF.Diff_sub_spcl_cd,1,0)+ IF( SELF.Diff_sub_spcl_desc,1,0)+ IF( SELF.Diff_titl_typ_id,1,0)+ IF( SELF.Diff_titl_typ_desc,1,0)+ IF( SELF.Diff_hco_hce_id,1,0)+ IF( SELF.Diff_ok_wkp_id,1,0)+ IF( SELF.Diff_ska_id,1,0)+ IF( SELF.Diff_bus_nm,1,0)+ IF( SELF.Diff_dba_nm,1,0)+ IF( SELF.Diff_addr_id,1,0)+ IF( SELF.Diff_str_front_id,1,0)+ IF( SELF.Diff_addr_ln_1_txt,1,0)+ IF( SELF.Diff_addr_ln_2_txt,1,0)+ IF( SELF.Diff_city_nm,1,0)+ IF( SELF.Diff_st_cd,1,0)+ IF( SELF.Diff_zip5_cd,1,0)+ IF( SELF.Diff_zip4_cd,1,0)+ IF( SELF.Diff_fips_cnty_cd,1,0)+ IF( SELF.Diff_fips_cnty_desc,1,0)+ IF( SELF.Diff_telephn_nbr,1,0)+ IF( SELF.Diff_cot_id,1,0)+ IF( SELF.Diff_cot_clas_id,1,0)+ IF( SELF.Diff_cot_clas_desc,1,0)+ IF( SELF.Diff_cot_fclt_typ_id,1,0)+ IF( SELF.Diff_cot_fclt_typ_desc,1,0)+ IF( SELF.Diff_cot_spcl_id,1,0)+ IF( SELF.Diff_cot_spcl_desc,1,0)+ IF( SELF.Diff_email_ind_flag,1,0)+ IF( SELF.Diff_ims_id,1,0)+ IF( SELF.Diff_hce_prfsnl_stat_cd,1,0)+ IF( SELF.Diff_hce_prfsnl_stat_desc,1,0)+ IF( SELF.Diff_excld_rsn_desc,1,0)+ IF( SELF.Diff_npi,1,0)+ IF( SELF.Diff_deactv_dt,1,0)+ IF( SELF.Diff_cleaned_deactv_dt,1,0)+ IF( SELF.Diff_xref_hce_id,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_prep_addr_line1,1,0)+ IF( SELF.Diff_prep_addr_line_last,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_state,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_raw_aid,1,0)+ IF( SELF.Diff_ace_aid,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0);
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
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_bdid_score := COUNT(GROUP,%Closest%.Diff_bdid_score);
    Count_Diff_source_rec_id := COUNT(GROUP,%Closest%.Diff_source_rec_id);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_hcp_hce_id := COUNT(GROUP,%Closest%.Diff_hcp_hce_id);
    Count_Diff_ok_indv_id := COUNT(GROUP,%Closest%.Diff_ok_indv_id);
    Count_Diff_ska_uid := COUNT(GROUP,%Closest%.Diff_ska_uid);
    Count_Diff_frst_nm := COUNT(GROUP,%Closest%.Diff_frst_nm);
    Count_Diff_mid_nm := COUNT(GROUP,%Closest%.Diff_mid_nm);
    Count_Diff_last_nm := COUNT(GROUP,%Closest%.Diff_last_nm);
    Count_Diff_sfx_cd := COUNT(GROUP,%Closest%.Diff_sfx_cd);
    Count_Diff_gender_cd := COUNT(GROUP,%Closest%.Diff_gender_cd);
    Count_Diff_prim_prfsn_cd := COUNT(GROUP,%Closest%.Diff_prim_prfsn_cd);
    Count_Diff_prim_prfsn_desc := COUNT(GROUP,%Closest%.Diff_prim_prfsn_desc);
    Count_Diff_prim_spcl_cd := COUNT(GROUP,%Closest%.Diff_prim_spcl_cd);
    Count_Diff_prim_spcl_desc := COUNT(GROUP,%Closest%.Diff_prim_spcl_desc);
    Count_Diff_sec_spcl_cd := COUNT(GROUP,%Closest%.Diff_sec_spcl_cd);
    Count_Diff_sec_spcl_desc := COUNT(GROUP,%Closest%.Diff_sec_spcl_desc);
    Count_Diff_tert_spcl_cd := COUNT(GROUP,%Closest%.Diff_tert_spcl_cd);
    Count_Diff_tert_spcl_desc := COUNT(GROUP,%Closest%.Diff_tert_spcl_desc);
    Count_Diff_sub_spcl_cd := COUNT(GROUP,%Closest%.Diff_sub_spcl_cd);
    Count_Diff_sub_spcl_desc := COUNT(GROUP,%Closest%.Diff_sub_spcl_desc);
    Count_Diff_titl_typ_id := COUNT(GROUP,%Closest%.Diff_titl_typ_id);
    Count_Diff_titl_typ_desc := COUNT(GROUP,%Closest%.Diff_titl_typ_desc);
    Count_Diff_hco_hce_id := COUNT(GROUP,%Closest%.Diff_hco_hce_id);
    Count_Diff_ok_wkp_id := COUNT(GROUP,%Closest%.Diff_ok_wkp_id);
    Count_Diff_ska_id := COUNT(GROUP,%Closest%.Diff_ska_id);
    Count_Diff_bus_nm := COUNT(GROUP,%Closest%.Diff_bus_nm);
    Count_Diff_dba_nm := COUNT(GROUP,%Closest%.Diff_dba_nm);
    Count_Diff_addr_id := COUNT(GROUP,%Closest%.Diff_addr_id);
    Count_Diff_str_front_id := COUNT(GROUP,%Closest%.Diff_str_front_id);
    Count_Diff_addr_ln_1_txt := COUNT(GROUP,%Closest%.Diff_addr_ln_1_txt);
    Count_Diff_addr_ln_2_txt := COUNT(GROUP,%Closest%.Diff_addr_ln_2_txt);
    Count_Diff_city_nm := COUNT(GROUP,%Closest%.Diff_city_nm);
    Count_Diff_st_cd := COUNT(GROUP,%Closest%.Diff_st_cd);
    Count_Diff_zip5_cd := COUNT(GROUP,%Closest%.Diff_zip5_cd);
    Count_Diff_zip4_cd := COUNT(GROUP,%Closest%.Diff_zip4_cd);
    Count_Diff_fips_cnty_cd := COUNT(GROUP,%Closest%.Diff_fips_cnty_cd);
    Count_Diff_fips_cnty_desc := COUNT(GROUP,%Closest%.Diff_fips_cnty_desc);
    Count_Diff_telephn_nbr := COUNT(GROUP,%Closest%.Diff_telephn_nbr);
    Count_Diff_cot_id := COUNT(GROUP,%Closest%.Diff_cot_id);
    Count_Diff_cot_clas_id := COUNT(GROUP,%Closest%.Diff_cot_clas_id);
    Count_Diff_cot_clas_desc := COUNT(GROUP,%Closest%.Diff_cot_clas_desc);
    Count_Diff_cot_fclt_typ_id := COUNT(GROUP,%Closest%.Diff_cot_fclt_typ_id);
    Count_Diff_cot_fclt_typ_desc := COUNT(GROUP,%Closest%.Diff_cot_fclt_typ_desc);
    Count_Diff_cot_spcl_id := COUNT(GROUP,%Closest%.Diff_cot_spcl_id);
    Count_Diff_cot_spcl_desc := COUNT(GROUP,%Closest%.Diff_cot_spcl_desc);
    Count_Diff_email_ind_flag := COUNT(GROUP,%Closest%.Diff_email_ind_flag);
    Count_Diff_ims_id := COUNT(GROUP,%Closest%.Diff_ims_id);
    Count_Diff_hce_prfsnl_stat_cd := COUNT(GROUP,%Closest%.Diff_hce_prfsnl_stat_cd);
    Count_Diff_hce_prfsnl_stat_desc := COUNT(GROUP,%Closest%.Diff_hce_prfsnl_stat_desc);
    Count_Diff_excld_rsn_desc := COUNT(GROUP,%Closest%.Diff_excld_rsn_desc);
    Count_Diff_npi := COUNT(GROUP,%Closest%.Diff_npi);
    Count_Diff_deactv_dt := COUNT(GROUP,%Closest%.Diff_deactv_dt);
    Count_Diff_cleaned_deactv_dt := COUNT(GROUP,%Closest%.Diff_cleaned_deactv_dt);
    Count_Diff_xref_hce_id := COUNT(GROUP,%Closest%.Diff_xref_hce_id);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_addr_line1);
    Count_Diff_prep_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_addr_line_last);
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
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

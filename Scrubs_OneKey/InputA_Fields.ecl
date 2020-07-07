IMPORT SALT311;
IMPORT Scrubs_OneKey; // Import modules for FieldTypes attribute definitions
EXPORT InputA_Fields := MODULE
 
EXPORT NumFields := 46;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_numeric_nonzero','invalid_mandatory','invalid_source','invalid_record_type','invalid_frst_nm','invalid_mid_nm','invalid_last_nm','invalid_prim_prfsn_cd','invalid_prim_prfsn_desc','invalid_prim_spcl_cd','invalid_prim_spcl_desc','invalid_sec_spcl_cd','invalid_sec_spcl_desc','invalid_tert_spcl_cd','invalid_tert_spcl_desc','invalid_sub_spcl_cd','invalid_sub_spcl_desc','invalid_titl_typ_id','invalid_titl_typ_desc','invalid_ok_wkp_id','invalid_city_nm','invalid_st_cd','invalid_zip5_cd','invalid_hcp_affil_xid','invalid_delta_cd');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_numeric_nonzero' => 1,'invalid_mandatory' => 2,'invalid_source' => 3,'invalid_record_type' => 4,'invalid_frst_nm' => 5,'invalid_mid_nm' => 6,'invalid_last_nm' => 7,'invalid_prim_prfsn_cd' => 8,'invalid_prim_prfsn_desc' => 9,'invalid_prim_spcl_cd' => 10,'invalid_prim_spcl_desc' => 11,'invalid_sec_spcl_cd' => 12,'invalid_sec_spcl_desc' => 13,'invalid_tert_spcl_cd' => 14,'invalid_tert_spcl_desc' => 15,'invalid_sub_spcl_cd' => 16,'invalid_sub_spcl_desc' => 17,'invalid_titl_typ_id' => 18,'invalid_titl_typ_desc' => 19,'invalid_ok_wkp_id' => 20,'invalid_city_nm' => 21,'invalid_st_cd' => 22,'invalid_zip5_cd' => 23,'invalid_hcp_affil_xid' => 24,'invalid_delta_cd' => 25,0);
 
EXPORT MakeFT_invalid_numeric_nonzero(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric_nonzero(SALT311.StrType s) := WHICH(~Scrubs_OneKey.Functions.fn_numeric_nonzero(s)>0);
EXPORT InValidMessageFT_invalid_numeric_nonzero(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_numeric_nonzero'),SALT311.HygieneErrors.Good);
 
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
 
EXPORT MakeFT_invalid_city_nm(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_city_nm(SALT311.StrType s) := WHICH(~Scrubs_OneKey.Functions.fn_populated_strings(s)>0);
EXPORT InValidMessageFT_invalid_city_nm(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st_cd(SALT311.StrType s) := WHICH(~Scrubs_OneKey.Functions.fn_Valid_StateAbbrev(s)>0);
EXPORT InValidMessageFT_invalid_st_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_Valid_StateAbbrev'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5_cd(SALT311.StrType s) := WHICH(~Scrubs_OneKey.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_zip5_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_hcp_affil_xid(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_hcp_affil_xid(SALT311.StrType s,SALT311.StrType hcp_hce_id,SALT311.StrType hco_hce_id,SALT311.StrType titl_typ_id) := WHICH(~Scrubs_OneKey.Functions.fn_hcp_affil_xid(s,hcp_hce_id,hco_hce_id,titl_typ_id)>0);
EXPORT InValidMessageFT_invalid_hcp_affil_xid(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_hcp_affil_xid'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_delta_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_delta_cd(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['D','I','U','']);
EXPORT InValidMessageFT_invalid_delta_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('D|I|U|'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'hcp_hce_id','ok_indv_id','ska_uid','frst_nm','mid_nm','last_nm','sfx_cd','gender_cd','prim_prfsn_cd','prim_prfsn_desc','prim_spcl_cd','prim_spcl_desc','sec_spcl_cd','sec_spcl_desc','tert_spcl_cd','tert_spcl_desc','sub_spcl_cd','sub_spcl_desc','titl_typ_id','titl_typ_desc','hco_hce_id','ok_wkp_id','ska_id','bus_nm','dba_nm','addr_id','str_front_id','addr_ln_1_txt','addr_ln_2_txt','city_nm','st_cd','zip5_cd','zip4_cd','fips_cnty_cd','fips_cnty_desc','telephn_nbr','cot_id','cot_clas_id','cot_clas_desc','cot_fclt_typ_id','cot_fclt_typ_desc','cot_spcl_id','cot_spcl_desc','email_ind_flag','hcp_affil_xid','delta_cd');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'hcp_hce_id','ok_indv_id','ska_uid','frst_nm','mid_nm','last_nm','sfx_cd','gender_cd','prim_prfsn_cd','prim_prfsn_desc','prim_spcl_cd','prim_spcl_desc','sec_spcl_cd','sec_spcl_desc','tert_spcl_cd','tert_spcl_desc','sub_spcl_cd','sub_spcl_desc','titl_typ_id','titl_typ_desc','hco_hce_id','ok_wkp_id','ska_id','bus_nm','dba_nm','addr_id','str_front_id','addr_ln_1_txt','addr_ln_2_txt','city_nm','st_cd','zip5_cd','zip4_cd','fips_cnty_cd','fips_cnty_desc','telephn_nbr','cot_id','cot_clas_id','cot_clas_desc','cot_fclt_typ_id','cot_fclt_typ_desc','cot_spcl_id','cot_spcl_desc','email_ind_flag','hcp_affil_xid','delta_cd');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'hcp_hce_id' => 0,'ok_indv_id' => 1,'ska_uid' => 2,'frst_nm' => 3,'mid_nm' => 4,'last_nm' => 5,'sfx_cd' => 6,'gender_cd' => 7,'prim_prfsn_cd' => 8,'prim_prfsn_desc' => 9,'prim_spcl_cd' => 10,'prim_spcl_desc' => 11,'sec_spcl_cd' => 12,'sec_spcl_desc' => 13,'tert_spcl_cd' => 14,'tert_spcl_desc' => 15,'sub_spcl_cd' => 16,'sub_spcl_desc' => 17,'titl_typ_id' => 18,'titl_typ_desc' => 19,'hco_hce_id' => 20,'ok_wkp_id' => 21,'ska_id' => 22,'bus_nm' => 23,'dba_nm' => 24,'addr_id' => 25,'str_front_id' => 26,'addr_ln_1_txt' => 27,'addr_ln_2_txt' => 28,'city_nm' => 29,'st_cd' => 30,'zip5_cd' => 31,'zip4_cd' => 32,'fips_cnty_cd' => 33,'fips_cnty_desc' => 34,'telephn_nbr' => 35,'cot_id' => 36,'cot_clas_id' => 37,'cot_clas_desc' => 38,'cot_fclt_typ_id' => 39,'cot_fclt_typ_desc' => 40,'cot_spcl_id' => 41,'cot_spcl_desc' => 42,'email_ind_flag' => 43,'hcp_affil_xid' => 44,'delta_cd' => 45,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],['ENUM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
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
 
EXPORT Make_city_nm(SALT311.StrType s0) := MakeFT_invalid_city_nm(s0);
EXPORT InValid_city_nm(SALT311.StrType s) := InValidFT_invalid_city_nm(s);
EXPORT InValidMessage_city_nm(UNSIGNED1 wh) := InValidMessageFT_invalid_city_nm(wh);
 
EXPORT Make_st_cd(SALT311.StrType s0) := MakeFT_invalid_st_cd(s0);
EXPORT InValid_st_cd(SALT311.StrType s) := InValidFT_invalid_st_cd(s);
EXPORT InValidMessage_st_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_st_cd(wh);
 
EXPORT Make_zip5_cd(SALT311.StrType s0) := MakeFT_invalid_zip5_cd(s0);
EXPORT InValid_zip5_cd(SALT311.StrType s) := InValidFT_invalid_zip5_cd(s);
EXPORT InValidMessage_zip5_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5_cd(wh);
 
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
 
EXPORT Make_hcp_affil_xid(SALT311.StrType s0) := MakeFT_invalid_hcp_affil_xid(s0);
EXPORT InValid_hcp_affil_xid(SALT311.StrType s,SALT311.StrType hcp_hce_id,SALT311.StrType hco_hce_id,SALT311.StrType titl_typ_id) := InValidFT_invalid_hcp_affil_xid(s,hcp_hce_id,hco_hce_id,titl_typ_id);
EXPORT InValidMessage_hcp_affil_xid(UNSIGNED1 wh) := InValidMessageFT_invalid_hcp_affil_xid(wh);
 
EXPORT Make_delta_cd(SALT311.StrType s0) := MakeFT_invalid_delta_cd(s0);
EXPORT InValid_delta_cd(SALT311.StrType s) := InValidFT_invalid_delta_cd(s);
EXPORT InValidMessage_delta_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_delta_cd(wh);
 
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
    BOOLEAN Diff_hcp_affil_xid;
    BOOLEAN Diff_delta_cd;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
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
    SELF.Diff_hcp_affil_xid := le.hcp_affil_xid <> ri.hcp_affil_xid;
    SELF.Diff_delta_cd := le.delta_cd <> ri.delta_cd;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_hcp_hce_id,1,0)+ IF( SELF.Diff_ok_indv_id,1,0)+ IF( SELF.Diff_ska_uid,1,0)+ IF( SELF.Diff_frst_nm,1,0)+ IF( SELF.Diff_mid_nm,1,0)+ IF( SELF.Diff_last_nm,1,0)+ IF( SELF.Diff_sfx_cd,1,0)+ IF( SELF.Diff_gender_cd,1,0)+ IF( SELF.Diff_prim_prfsn_cd,1,0)+ IF( SELF.Diff_prim_prfsn_desc,1,0)+ IF( SELF.Diff_prim_spcl_cd,1,0)+ IF( SELF.Diff_prim_spcl_desc,1,0)+ IF( SELF.Diff_sec_spcl_cd,1,0)+ IF( SELF.Diff_sec_spcl_desc,1,0)+ IF( SELF.Diff_tert_spcl_cd,1,0)+ IF( SELF.Diff_tert_spcl_desc,1,0)+ IF( SELF.Diff_sub_spcl_cd,1,0)+ IF( SELF.Diff_sub_spcl_desc,1,0)+ IF( SELF.Diff_titl_typ_id,1,0)+ IF( SELF.Diff_titl_typ_desc,1,0)+ IF( SELF.Diff_hco_hce_id,1,0)+ IF( SELF.Diff_ok_wkp_id,1,0)+ IF( SELF.Diff_ska_id,1,0)+ IF( SELF.Diff_bus_nm,1,0)+ IF( SELF.Diff_dba_nm,1,0)+ IF( SELF.Diff_addr_id,1,0)+ IF( SELF.Diff_str_front_id,1,0)+ IF( SELF.Diff_addr_ln_1_txt,1,0)+ IF( SELF.Diff_addr_ln_2_txt,1,0)+ IF( SELF.Diff_city_nm,1,0)+ IF( SELF.Diff_st_cd,1,0)+ IF( SELF.Diff_zip5_cd,1,0)+ IF( SELF.Diff_zip4_cd,1,0)+ IF( SELF.Diff_fips_cnty_cd,1,0)+ IF( SELF.Diff_fips_cnty_desc,1,0)+ IF( SELF.Diff_telephn_nbr,1,0)+ IF( SELF.Diff_cot_id,1,0)+ IF( SELF.Diff_cot_clas_id,1,0)+ IF( SELF.Diff_cot_clas_desc,1,0)+ IF( SELF.Diff_cot_fclt_typ_id,1,0)+ IF( SELF.Diff_cot_fclt_typ_desc,1,0)+ IF( SELF.Diff_cot_spcl_id,1,0)+ IF( SELF.Diff_cot_spcl_desc,1,0)+ IF( SELF.Diff_email_ind_flag,1,0)+ IF( SELF.Diff_hcp_affil_xid,1,0)+ IF( SELF.Diff_delta_cd,1,0);
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
    Count_Diff_hcp_affil_xid := COUNT(GROUP,%Closest%.Diff_hcp_affil_xid);
    Count_Diff_delta_cd := COUNT(GROUP,%Closest%.Diff_delta_cd);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

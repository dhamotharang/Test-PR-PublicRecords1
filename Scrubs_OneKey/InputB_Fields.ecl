IMPORT SALT311;
IMPORT Scrubs_OneKey; // Import modules for FieldTypes attribute definitions
EXPORT InputB_Fields := MODULE
 
EXPORT NumFields := 22;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_numeric_nonzero','invalid_mandatory','invalid_ok_wkp_id','invalid_frst_nm','invalid_mid_nm','invalid_last_nm','invalid_prim_prfsn_cd','invalid_prim_prfsn_desc','invalid_prim_spcl_cd','invalid_prim_spcl_desc','invalid_hce_prfsnl_stat_cd','invalid_hce_prfsnl_stat_desc','invalid_excld_rsn_desc','invalid_deactv_dt','invalid_city_nm','invalid_st_cd','invalid_zip5_cd');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_numeric_nonzero' => 1,'invalid_mandatory' => 2,'invalid_ok_wkp_id' => 3,'invalid_frst_nm' => 4,'invalid_mid_nm' => 5,'invalid_last_nm' => 6,'invalid_prim_prfsn_cd' => 7,'invalid_prim_prfsn_desc' => 8,'invalid_prim_spcl_cd' => 9,'invalid_prim_spcl_desc' => 10,'invalid_hce_prfsnl_stat_cd' => 11,'invalid_hce_prfsnl_stat_desc' => 12,'invalid_excld_rsn_desc' => 13,'invalid_deactv_dt' => 14,'invalid_city_nm' => 15,'invalid_st_cd' => 16,'invalid_zip5_cd' => 17,0);
 
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
 
EXPORT MakeFT_invalid_ok_wkp_id(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ok_wkp_id(SALT311.StrType s) := WHICH(~Scrubs_OneKey.Functions.fn_onekey_id(s)>0);
EXPORT InValidMessageFT_invalid_ok_wkp_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_onekey_id'),SALT311.HygieneErrors.Good);
 
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
 
EXPORT MakeFT_invalid_hce_prfsnl_stat_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_hce_prfsnl_stat_cd(SALT311.StrType s,SALT311.StrType hce_prfsnl_stat_desc) := WHICH(~Scrubs_OneKey.Functions.fn_str1_xor_str2(s,hce_prfsnl_stat_desc)>0);
EXPORT InValidMessageFT_invalid_hce_prfsnl_stat_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_hce_prfsnl_stat_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_hce_prfsnl_stat_desc(SALT311.StrType s,SALT311.StrType hce_prfsnl_stat_cd) := WHICH(~Scrubs_OneKey.Functions.fn_str1_xor_str2(s,hce_prfsnl_stat_cd)>0);
EXPORT InValidMessageFT_invalid_hce_prfsnl_stat_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_excld_rsn_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_excld_rsn_desc(SALT311.StrType s,SALT311.StrType hce_prfsnl_stat_cd) := WHICH(~Scrubs_OneKey.Functions.fn_str1_xor_str2(s,hce_prfsnl_stat_cd)>0);
EXPORT InValidMessageFT_invalid_excld_rsn_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_deactv_dt(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_deactv_dt(SALT311.StrType s) := WHICH(~Scrubs_OneKey.Functions.fn_mm_dd_yyyy(s)>0);
EXPORT InValidMessageFT_invalid_deactv_dt(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_mm_dd_yyyy'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_city_nm(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_city_nm(SALT311.StrType s,SALT311.StrType st_cd,SALT311.StrType zip5_cd) := WHICH(~Scrubs_OneKey.Functions.fn_str1_xor_str2_xor_str3(s,st_cd,zip5_cd)>0);
EXPORT InValidMessageFT_invalid_city_nm(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_str1_xor_str2_xor_str3'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st_cd(SALT311.StrType s) := WHICH(~Scrubs_OneKey.Functions.fn_Valid_StateAbbrev(s)>0);
EXPORT InValidMessageFT_invalid_st_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_Valid_StateAbbrev'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5_cd(SALT311.StrType s) := WHICH(~Scrubs_OneKey.Functions.fn_numeric_optional(s,5)>0);
EXPORT InValidMessageFT_invalid_zip5_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OneKey.Functions.fn_numeric_optional'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'hcp_hce_id','ok_indv_id','ska_uid','ims_id','frst_nm','mid_nm','last_nm','sfx_cd','gender_cd','prim_prfsn_cd','prim_prfsn_desc','prim_spcl_cd','prim_spcl_desc','hce_prfsnl_stat_cd','hce_prfsnl_stat_desc','excld_rsn_desc','npi','deactv_dt','xref_hce_id','city_nm','st_cd','zip5_cd');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'hcp_hce_id','ok_indv_id','ska_uid','ims_id','frst_nm','mid_nm','last_nm','sfx_cd','gender_cd','prim_prfsn_cd','prim_prfsn_desc','prim_spcl_cd','prim_spcl_desc','hce_prfsnl_stat_cd','hce_prfsnl_stat_desc','excld_rsn_desc','npi','deactv_dt','xref_hce_id','city_nm','st_cd','zip5_cd');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'hcp_hce_id' => 0,'ok_indv_id' => 1,'ska_uid' => 2,'ims_id' => 3,'frst_nm' => 4,'mid_nm' => 5,'last_nm' => 6,'sfx_cd' => 7,'gender_cd' => 8,'prim_prfsn_cd' => 9,'prim_prfsn_desc' => 10,'prim_spcl_cd' => 11,'prim_spcl_desc' => 12,'hce_prfsnl_stat_cd' => 13,'hce_prfsnl_stat_desc' => 14,'excld_rsn_desc' => 15,'npi' => 16,'deactv_dt' => 17,'xref_hce_id' => 18,'city_nm' => 19,'st_cd' => 20,'zip5_cd' => 21,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_hcp_hce_id(SALT311.StrType s0) := MakeFT_invalid_numeric_nonzero(s0);
EXPORT InValid_hcp_hce_id(SALT311.StrType s) := InValidFT_invalid_numeric_nonzero(s);
EXPORT InValidMessage_hcp_hce_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_nonzero(wh);
 
EXPORT Make_ok_indv_id(SALT311.StrType s0) := MakeFT_invalid_ok_wkp_id(s0);
EXPORT InValid_ok_indv_id(SALT311.StrType s) := InValidFT_invalid_ok_wkp_id(s);
EXPORT InValidMessage_ok_indv_id(UNSIGNED1 wh) := InValidMessageFT_invalid_ok_wkp_id(wh);
 
EXPORT Make_ska_uid(SALT311.StrType s0) := MakeFT_invalid_numeric_nonzero(s0);
EXPORT InValid_ska_uid(SALT311.StrType s) := InValidFT_invalid_numeric_nonzero(s);
EXPORT InValidMessage_ska_uid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_nonzero(wh);
 
EXPORT Make_ims_id(SALT311.StrType s0) := s0;
EXPORT InValid_ims_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_ims_id(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_hce_prfsnl_stat_cd(SALT311.StrType s0) := MakeFT_invalid_hce_prfsnl_stat_cd(s0);
EXPORT InValid_hce_prfsnl_stat_cd(SALT311.StrType s,SALT311.StrType hce_prfsnl_stat_desc) := InValidFT_invalid_hce_prfsnl_stat_cd(s,hce_prfsnl_stat_desc);
EXPORT InValidMessage_hce_prfsnl_stat_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_hce_prfsnl_stat_cd(wh);
 
EXPORT Make_hce_prfsnl_stat_desc(SALT311.StrType s0) := MakeFT_invalid_hce_prfsnl_stat_desc(s0);
EXPORT InValid_hce_prfsnl_stat_desc(SALT311.StrType s,SALT311.StrType hce_prfsnl_stat_cd) := InValidFT_invalid_hce_prfsnl_stat_desc(s,hce_prfsnl_stat_cd);
EXPORT InValidMessage_hce_prfsnl_stat_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_hce_prfsnl_stat_desc(wh);
 
EXPORT Make_excld_rsn_desc(SALT311.StrType s0) := MakeFT_invalid_excld_rsn_desc(s0);
EXPORT InValid_excld_rsn_desc(SALT311.StrType s,SALT311.StrType hce_prfsnl_stat_cd) := InValidFT_invalid_excld_rsn_desc(s,hce_prfsnl_stat_cd);
EXPORT InValidMessage_excld_rsn_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_excld_rsn_desc(wh);
 
EXPORT Make_npi(SALT311.StrType s0) := s0;
EXPORT InValid_npi(SALT311.StrType s) := 0;
EXPORT InValidMessage_npi(UNSIGNED1 wh) := '';
 
EXPORT Make_deactv_dt(SALT311.StrType s0) := MakeFT_invalid_deactv_dt(s0);
EXPORT InValid_deactv_dt(SALT311.StrType s) := InValidFT_invalid_deactv_dt(s);
EXPORT InValidMessage_deactv_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_deactv_dt(wh);
 
EXPORT Make_xref_hce_id(SALT311.StrType s0) := s0;
EXPORT InValid_xref_hce_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_xref_hce_id(UNSIGNED1 wh) := '';
 
EXPORT Make_city_nm(SALT311.StrType s0) := MakeFT_invalid_city_nm(s0);
EXPORT InValid_city_nm(SALT311.StrType s,SALT311.StrType st_cd,SALT311.StrType zip5_cd) := InValidFT_invalid_city_nm(s,st_cd,zip5_cd);
EXPORT InValidMessage_city_nm(UNSIGNED1 wh) := InValidMessageFT_invalid_city_nm(wh);
 
EXPORT Make_st_cd(SALT311.StrType s0) := MakeFT_invalid_st_cd(s0);
EXPORT InValid_st_cd(SALT311.StrType s) := InValidFT_invalid_st_cd(s);
EXPORT InValidMessage_st_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_st_cd(wh);
 
EXPORT Make_zip5_cd(SALT311.StrType s0) := MakeFT_invalid_zip5_cd(s0);
EXPORT InValid_zip5_cd(SALT311.StrType s) := InValidFT_invalid_zip5_cd(s);
EXPORT InValidMessage_zip5_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5_cd(wh);
 
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
    BOOLEAN Diff_ims_id;
    BOOLEAN Diff_frst_nm;
    BOOLEAN Diff_mid_nm;
    BOOLEAN Diff_last_nm;
    BOOLEAN Diff_sfx_cd;
    BOOLEAN Diff_gender_cd;
    BOOLEAN Diff_prim_prfsn_cd;
    BOOLEAN Diff_prim_prfsn_desc;
    BOOLEAN Diff_prim_spcl_cd;
    BOOLEAN Diff_prim_spcl_desc;
    BOOLEAN Diff_hce_prfsnl_stat_cd;
    BOOLEAN Diff_hce_prfsnl_stat_desc;
    BOOLEAN Diff_excld_rsn_desc;
    BOOLEAN Diff_npi;
    BOOLEAN Diff_deactv_dt;
    BOOLEAN Diff_xref_hce_id;
    BOOLEAN Diff_city_nm;
    BOOLEAN Diff_st_cd;
    BOOLEAN Diff_zip5_cd;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_hcp_hce_id := le.hcp_hce_id <> ri.hcp_hce_id;
    SELF.Diff_ok_indv_id := le.ok_indv_id <> ri.ok_indv_id;
    SELF.Diff_ska_uid := le.ska_uid <> ri.ska_uid;
    SELF.Diff_ims_id := le.ims_id <> ri.ims_id;
    SELF.Diff_frst_nm := le.frst_nm <> ri.frst_nm;
    SELF.Diff_mid_nm := le.mid_nm <> ri.mid_nm;
    SELF.Diff_last_nm := le.last_nm <> ri.last_nm;
    SELF.Diff_sfx_cd := le.sfx_cd <> ri.sfx_cd;
    SELF.Diff_gender_cd := le.gender_cd <> ri.gender_cd;
    SELF.Diff_prim_prfsn_cd := le.prim_prfsn_cd <> ri.prim_prfsn_cd;
    SELF.Diff_prim_prfsn_desc := le.prim_prfsn_desc <> ri.prim_prfsn_desc;
    SELF.Diff_prim_spcl_cd := le.prim_spcl_cd <> ri.prim_spcl_cd;
    SELF.Diff_prim_spcl_desc := le.prim_spcl_desc <> ri.prim_spcl_desc;
    SELF.Diff_hce_prfsnl_stat_cd := le.hce_prfsnl_stat_cd <> ri.hce_prfsnl_stat_cd;
    SELF.Diff_hce_prfsnl_stat_desc := le.hce_prfsnl_stat_desc <> ri.hce_prfsnl_stat_desc;
    SELF.Diff_excld_rsn_desc := le.excld_rsn_desc <> ri.excld_rsn_desc;
    SELF.Diff_npi := le.npi <> ri.npi;
    SELF.Diff_deactv_dt := le.deactv_dt <> ri.deactv_dt;
    SELF.Diff_xref_hce_id := le.xref_hce_id <> ri.xref_hce_id;
    SELF.Diff_city_nm := le.city_nm <> ri.city_nm;
    SELF.Diff_st_cd := le.st_cd <> ri.st_cd;
    SELF.Diff_zip5_cd := le.zip5_cd <> ri.zip5_cd;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_hcp_hce_id,1,0)+ IF( SELF.Diff_ok_indv_id,1,0)+ IF( SELF.Diff_ska_uid,1,0)+ IF( SELF.Diff_ims_id,1,0)+ IF( SELF.Diff_frst_nm,1,0)+ IF( SELF.Diff_mid_nm,1,0)+ IF( SELF.Diff_last_nm,1,0)+ IF( SELF.Diff_sfx_cd,1,0)+ IF( SELF.Diff_gender_cd,1,0)+ IF( SELF.Diff_prim_prfsn_cd,1,0)+ IF( SELF.Diff_prim_prfsn_desc,1,0)+ IF( SELF.Diff_prim_spcl_cd,1,0)+ IF( SELF.Diff_prim_spcl_desc,1,0)+ IF( SELF.Diff_hce_prfsnl_stat_cd,1,0)+ IF( SELF.Diff_hce_prfsnl_stat_desc,1,0)+ IF( SELF.Diff_excld_rsn_desc,1,0)+ IF( SELF.Diff_npi,1,0)+ IF( SELF.Diff_deactv_dt,1,0)+ IF( SELF.Diff_xref_hce_id,1,0)+ IF( SELF.Diff_city_nm,1,0)+ IF( SELF.Diff_st_cd,1,0)+ IF( SELF.Diff_zip5_cd,1,0);
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
    Count_Diff_ims_id := COUNT(GROUP,%Closest%.Diff_ims_id);
    Count_Diff_frst_nm := COUNT(GROUP,%Closest%.Diff_frst_nm);
    Count_Diff_mid_nm := COUNT(GROUP,%Closest%.Diff_mid_nm);
    Count_Diff_last_nm := COUNT(GROUP,%Closest%.Diff_last_nm);
    Count_Diff_sfx_cd := COUNT(GROUP,%Closest%.Diff_sfx_cd);
    Count_Diff_gender_cd := COUNT(GROUP,%Closest%.Diff_gender_cd);
    Count_Diff_prim_prfsn_cd := COUNT(GROUP,%Closest%.Diff_prim_prfsn_cd);
    Count_Diff_prim_prfsn_desc := COUNT(GROUP,%Closest%.Diff_prim_prfsn_desc);
    Count_Diff_prim_spcl_cd := COUNT(GROUP,%Closest%.Diff_prim_spcl_cd);
    Count_Diff_prim_spcl_desc := COUNT(GROUP,%Closest%.Diff_prim_spcl_desc);
    Count_Diff_hce_prfsnl_stat_cd := COUNT(GROUP,%Closest%.Diff_hce_prfsnl_stat_cd);
    Count_Diff_hce_prfsnl_stat_desc := COUNT(GROUP,%Closest%.Diff_hce_prfsnl_stat_desc);
    Count_Diff_excld_rsn_desc := COUNT(GROUP,%Closest%.Diff_excld_rsn_desc);
    Count_Diff_npi := COUNT(GROUP,%Closest%.Diff_npi);
    Count_Diff_deactv_dt := COUNT(GROUP,%Closest%.Diff_deactv_dt);
    Count_Diff_xref_hce_id := COUNT(GROUP,%Closest%.Diff_xref_hce_id);
    Count_Diff_city_nm := COUNT(GROUP,%Closest%.Diff_city_nm);
    Count_Diff_st_cd := COUNT(GROUP,%Closest%.Diff_st_cd);
    Count_Diff_zip5_cd := COUNT(GROUP,%Closest%.Diff_zip5_cd);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;

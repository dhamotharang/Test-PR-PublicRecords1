IMPORT SALT311,STD;
EXPORT InputA_hygiene(dataset(InputA_layout_OneKey) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_hcp_hce_id_cnt := COUNT(GROUP,h.hcp_hce_id <> (TYPEOF(h.hcp_hce_id))'');
    populated_hcp_hce_id_pcnt := AVE(GROUP,IF(h.hcp_hce_id = (TYPEOF(h.hcp_hce_id))'',0,100));
    maxlength_hcp_hce_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hcp_hce_id)));
    avelength_hcp_hce_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hcp_hce_id)),h.hcp_hce_id<>(typeof(h.hcp_hce_id))'');
    populated_ok_indv_id_cnt := COUNT(GROUP,h.ok_indv_id <> (TYPEOF(h.ok_indv_id))'');
    populated_ok_indv_id_pcnt := AVE(GROUP,IF(h.ok_indv_id = (TYPEOF(h.ok_indv_id))'',0,100));
    maxlength_ok_indv_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ok_indv_id)));
    avelength_ok_indv_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ok_indv_id)),h.ok_indv_id<>(typeof(h.ok_indv_id))'');
    populated_ska_uid_cnt := COUNT(GROUP,h.ska_uid <> (TYPEOF(h.ska_uid))'');
    populated_ska_uid_pcnt := AVE(GROUP,IF(h.ska_uid = (TYPEOF(h.ska_uid))'',0,100));
    maxlength_ska_uid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ska_uid)));
    avelength_ska_uid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ska_uid)),h.ska_uid<>(typeof(h.ska_uid))'');
    populated_frst_nm_cnt := COUNT(GROUP,h.frst_nm <> (TYPEOF(h.frst_nm))'');
    populated_frst_nm_pcnt := AVE(GROUP,IF(h.frst_nm = (TYPEOF(h.frst_nm))'',0,100));
    maxlength_frst_nm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.frst_nm)));
    avelength_frst_nm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.frst_nm)),h.frst_nm<>(typeof(h.frst_nm))'');
    populated_mid_nm_cnt := COUNT(GROUP,h.mid_nm <> (TYPEOF(h.mid_nm))'');
    populated_mid_nm_pcnt := AVE(GROUP,IF(h.mid_nm = (TYPEOF(h.mid_nm))'',0,100));
    maxlength_mid_nm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mid_nm)));
    avelength_mid_nm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mid_nm)),h.mid_nm<>(typeof(h.mid_nm))'');
    populated_last_nm_cnt := COUNT(GROUP,h.last_nm <> (TYPEOF(h.last_nm))'');
    populated_last_nm_pcnt := AVE(GROUP,IF(h.last_nm = (TYPEOF(h.last_nm))'',0,100));
    maxlength_last_nm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_nm)));
    avelength_last_nm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_nm)),h.last_nm<>(typeof(h.last_nm))'');
    populated_sfx_cd_cnt := COUNT(GROUP,h.sfx_cd <> (TYPEOF(h.sfx_cd))'');
    populated_sfx_cd_pcnt := AVE(GROUP,IF(h.sfx_cd = (TYPEOF(h.sfx_cd))'',0,100));
    maxlength_sfx_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sfx_cd)));
    avelength_sfx_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sfx_cd)),h.sfx_cd<>(typeof(h.sfx_cd))'');
    populated_gender_cd_cnt := COUNT(GROUP,h.gender_cd <> (TYPEOF(h.gender_cd))'');
    populated_gender_cd_pcnt := AVE(GROUP,IF(h.gender_cd = (TYPEOF(h.gender_cd))'',0,100));
    maxlength_gender_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender_cd)));
    avelength_gender_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender_cd)),h.gender_cd<>(typeof(h.gender_cd))'');
    populated_prim_prfsn_cd_cnt := COUNT(GROUP,h.prim_prfsn_cd <> (TYPEOF(h.prim_prfsn_cd))'');
    populated_prim_prfsn_cd_pcnt := AVE(GROUP,IF(h.prim_prfsn_cd = (TYPEOF(h.prim_prfsn_cd))'',0,100));
    maxlength_prim_prfsn_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_prfsn_cd)));
    avelength_prim_prfsn_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_prfsn_cd)),h.prim_prfsn_cd<>(typeof(h.prim_prfsn_cd))'');
    populated_prim_prfsn_desc_cnt := COUNT(GROUP,h.prim_prfsn_desc <> (TYPEOF(h.prim_prfsn_desc))'');
    populated_prim_prfsn_desc_pcnt := AVE(GROUP,IF(h.prim_prfsn_desc = (TYPEOF(h.prim_prfsn_desc))'',0,100));
    maxlength_prim_prfsn_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_prfsn_desc)));
    avelength_prim_prfsn_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_prfsn_desc)),h.prim_prfsn_desc<>(typeof(h.prim_prfsn_desc))'');
    populated_prim_spcl_cd_cnt := COUNT(GROUP,h.prim_spcl_cd <> (TYPEOF(h.prim_spcl_cd))'');
    populated_prim_spcl_cd_pcnt := AVE(GROUP,IF(h.prim_spcl_cd = (TYPEOF(h.prim_spcl_cd))'',0,100));
    maxlength_prim_spcl_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_spcl_cd)));
    avelength_prim_spcl_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_spcl_cd)),h.prim_spcl_cd<>(typeof(h.prim_spcl_cd))'');
    populated_prim_spcl_desc_cnt := COUNT(GROUP,h.prim_spcl_desc <> (TYPEOF(h.prim_spcl_desc))'');
    populated_prim_spcl_desc_pcnt := AVE(GROUP,IF(h.prim_spcl_desc = (TYPEOF(h.prim_spcl_desc))'',0,100));
    maxlength_prim_spcl_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_spcl_desc)));
    avelength_prim_spcl_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_spcl_desc)),h.prim_spcl_desc<>(typeof(h.prim_spcl_desc))'');
    populated_sec_spcl_cd_cnt := COUNT(GROUP,h.sec_spcl_cd <> (TYPEOF(h.sec_spcl_cd))'');
    populated_sec_spcl_cd_pcnt := AVE(GROUP,IF(h.sec_spcl_cd = (TYPEOF(h.sec_spcl_cd))'',0,100));
    maxlength_sec_spcl_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_spcl_cd)));
    avelength_sec_spcl_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_spcl_cd)),h.sec_spcl_cd<>(typeof(h.sec_spcl_cd))'');
    populated_sec_spcl_desc_cnt := COUNT(GROUP,h.sec_spcl_desc <> (TYPEOF(h.sec_spcl_desc))'');
    populated_sec_spcl_desc_pcnt := AVE(GROUP,IF(h.sec_spcl_desc = (TYPEOF(h.sec_spcl_desc))'',0,100));
    maxlength_sec_spcl_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_spcl_desc)));
    avelength_sec_spcl_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_spcl_desc)),h.sec_spcl_desc<>(typeof(h.sec_spcl_desc))'');
    populated_tert_spcl_cd_cnt := COUNT(GROUP,h.tert_spcl_cd <> (TYPEOF(h.tert_spcl_cd))'');
    populated_tert_spcl_cd_pcnt := AVE(GROUP,IF(h.tert_spcl_cd = (TYPEOF(h.tert_spcl_cd))'',0,100));
    maxlength_tert_spcl_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tert_spcl_cd)));
    avelength_tert_spcl_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tert_spcl_cd)),h.tert_spcl_cd<>(typeof(h.tert_spcl_cd))'');
    populated_tert_spcl_desc_cnt := COUNT(GROUP,h.tert_spcl_desc <> (TYPEOF(h.tert_spcl_desc))'');
    populated_tert_spcl_desc_pcnt := AVE(GROUP,IF(h.tert_spcl_desc = (TYPEOF(h.tert_spcl_desc))'',0,100));
    maxlength_tert_spcl_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tert_spcl_desc)));
    avelength_tert_spcl_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tert_spcl_desc)),h.tert_spcl_desc<>(typeof(h.tert_spcl_desc))'');
    populated_sub_spcl_cd_cnt := COUNT(GROUP,h.sub_spcl_cd <> (TYPEOF(h.sub_spcl_cd))'');
    populated_sub_spcl_cd_pcnt := AVE(GROUP,IF(h.sub_spcl_cd = (TYPEOF(h.sub_spcl_cd))'',0,100));
    maxlength_sub_spcl_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sub_spcl_cd)));
    avelength_sub_spcl_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sub_spcl_cd)),h.sub_spcl_cd<>(typeof(h.sub_spcl_cd))'');
    populated_sub_spcl_desc_cnt := COUNT(GROUP,h.sub_spcl_desc <> (TYPEOF(h.sub_spcl_desc))'');
    populated_sub_spcl_desc_pcnt := AVE(GROUP,IF(h.sub_spcl_desc = (TYPEOF(h.sub_spcl_desc))'',0,100));
    maxlength_sub_spcl_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sub_spcl_desc)));
    avelength_sub_spcl_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sub_spcl_desc)),h.sub_spcl_desc<>(typeof(h.sub_spcl_desc))'');
    populated_titl_typ_id_cnt := COUNT(GROUP,h.titl_typ_id <> (TYPEOF(h.titl_typ_id))'');
    populated_titl_typ_id_pcnt := AVE(GROUP,IF(h.titl_typ_id = (TYPEOF(h.titl_typ_id))'',0,100));
    maxlength_titl_typ_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.titl_typ_id)));
    avelength_titl_typ_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.titl_typ_id)),h.titl_typ_id<>(typeof(h.titl_typ_id))'');
    populated_titl_typ_desc_cnt := COUNT(GROUP,h.titl_typ_desc <> (TYPEOF(h.titl_typ_desc))'');
    populated_titl_typ_desc_pcnt := AVE(GROUP,IF(h.titl_typ_desc = (TYPEOF(h.titl_typ_desc))'',0,100));
    maxlength_titl_typ_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.titl_typ_desc)));
    avelength_titl_typ_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.titl_typ_desc)),h.titl_typ_desc<>(typeof(h.titl_typ_desc))'');
    populated_hco_hce_id_cnt := COUNT(GROUP,h.hco_hce_id <> (TYPEOF(h.hco_hce_id))'');
    populated_hco_hce_id_pcnt := AVE(GROUP,IF(h.hco_hce_id = (TYPEOF(h.hco_hce_id))'',0,100));
    maxlength_hco_hce_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hco_hce_id)));
    avelength_hco_hce_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hco_hce_id)),h.hco_hce_id<>(typeof(h.hco_hce_id))'');
    populated_ok_wkp_id_cnt := COUNT(GROUP,h.ok_wkp_id <> (TYPEOF(h.ok_wkp_id))'');
    populated_ok_wkp_id_pcnt := AVE(GROUP,IF(h.ok_wkp_id = (TYPEOF(h.ok_wkp_id))'',0,100));
    maxlength_ok_wkp_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ok_wkp_id)));
    avelength_ok_wkp_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ok_wkp_id)),h.ok_wkp_id<>(typeof(h.ok_wkp_id))'');
    populated_ska_id_cnt := COUNT(GROUP,h.ska_id <> (TYPEOF(h.ska_id))'');
    populated_ska_id_pcnt := AVE(GROUP,IF(h.ska_id = (TYPEOF(h.ska_id))'',0,100));
    maxlength_ska_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ska_id)));
    avelength_ska_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ska_id)),h.ska_id<>(typeof(h.ska_id))'');
    populated_bus_nm_cnt := COUNT(GROUP,h.bus_nm <> (TYPEOF(h.bus_nm))'');
    populated_bus_nm_pcnt := AVE(GROUP,IF(h.bus_nm = (TYPEOF(h.bus_nm))'',0,100));
    maxlength_bus_nm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bus_nm)));
    avelength_bus_nm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bus_nm)),h.bus_nm<>(typeof(h.bus_nm))'');
    populated_dba_nm_cnt := COUNT(GROUP,h.dba_nm <> (TYPEOF(h.dba_nm))'');
    populated_dba_nm_pcnt := AVE(GROUP,IF(h.dba_nm = (TYPEOF(h.dba_nm))'',0,100));
    maxlength_dba_nm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba_nm)));
    avelength_dba_nm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dba_nm)),h.dba_nm<>(typeof(h.dba_nm))'');
    populated_addr_id_cnt := COUNT(GROUP,h.addr_id <> (TYPEOF(h.addr_id))'');
    populated_addr_id_pcnt := AVE(GROUP,IF(h.addr_id = (TYPEOF(h.addr_id))'',0,100));
    maxlength_addr_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_id)));
    avelength_addr_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_id)),h.addr_id<>(typeof(h.addr_id))'');
    populated_str_front_id_cnt := COUNT(GROUP,h.str_front_id <> (TYPEOF(h.str_front_id))'');
    populated_str_front_id_pcnt := AVE(GROUP,IF(h.str_front_id = (TYPEOF(h.str_front_id))'',0,100));
    maxlength_str_front_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.str_front_id)));
    avelength_str_front_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.str_front_id)),h.str_front_id<>(typeof(h.str_front_id))'');
    populated_addr_ln_1_txt_cnt := COUNT(GROUP,h.addr_ln_1_txt <> (TYPEOF(h.addr_ln_1_txt))'');
    populated_addr_ln_1_txt_pcnt := AVE(GROUP,IF(h.addr_ln_1_txt = (TYPEOF(h.addr_ln_1_txt))'',0,100));
    maxlength_addr_ln_1_txt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_ln_1_txt)));
    avelength_addr_ln_1_txt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_ln_1_txt)),h.addr_ln_1_txt<>(typeof(h.addr_ln_1_txt))'');
    populated_addr_ln_2_txt_cnt := COUNT(GROUP,h.addr_ln_2_txt <> (TYPEOF(h.addr_ln_2_txt))'');
    populated_addr_ln_2_txt_pcnt := AVE(GROUP,IF(h.addr_ln_2_txt = (TYPEOF(h.addr_ln_2_txt))'',0,100));
    maxlength_addr_ln_2_txt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_ln_2_txt)));
    avelength_addr_ln_2_txt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_ln_2_txt)),h.addr_ln_2_txt<>(typeof(h.addr_ln_2_txt))'');
    populated_city_nm_cnt := COUNT(GROUP,h.city_nm <> (TYPEOF(h.city_nm))'');
    populated_city_nm_pcnt := AVE(GROUP,IF(h.city_nm = (TYPEOF(h.city_nm))'',0,100));
    maxlength_city_nm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_nm)));
    avelength_city_nm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_nm)),h.city_nm<>(typeof(h.city_nm))'');
    populated_st_cd_cnt := COUNT(GROUP,h.st_cd <> (TYPEOF(h.st_cd))'');
    populated_st_cd_pcnt := AVE(GROUP,IF(h.st_cd = (TYPEOF(h.st_cd))'',0,100));
    maxlength_st_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.st_cd)));
    avelength_st_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.st_cd)),h.st_cd<>(typeof(h.st_cd))'');
    populated_zip5_cd_cnt := COUNT(GROUP,h.zip5_cd <> (TYPEOF(h.zip5_cd))'');
    populated_zip5_cd_pcnt := AVE(GROUP,IF(h.zip5_cd = (TYPEOF(h.zip5_cd))'',0,100));
    maxlength_zip5_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip5_cd)));
    avelength_zip5_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip5_cd)),h.zip5_cd<>(typeof(h.zip5_cd))'');
    populated_zip4_cd_cnt := COUNT(GROUP,h.zip4_cd <> (TYPEOF(h.zip4_cd))'');
    populated_zip4_cd_pcnt := AVE(GROUP,IF(h.zip4_cd = (TYPEOF(h.zip4_cd))'',0,100));
    maxlength_zip4_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4_cd)));
    avelength_zip4_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4_cd)),h.zip4_cd<>(typeof(h.zip4_cd))'');
    populated_fips_cnty_cd_cnt := COUNT(GROUP,h.fips_cnty_cd <> (TYPEOF(h.fips_cnty_cd))'');
    populated_fips_cnty_cd_pcnt := AVE(GROUP,IF(h.fips_cnty_cd = (TYPEOF(h.fips_cnty_cd))'',0,100));
    maxlength_fips_cnty_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_cnty_cd)));
    avelength_fips_cnty_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_cnty_cd)),h.fips_cnty_cd<>(typeof(h.fips_cnty_cd))'');
    populated_fips_cnty_desc_cnt := COUNT(GROUP,h.fips_cnty_desc <> (TYPEOF(h.fips_cnty_desc))'');
    populated_fips_cnty_desc_pcnt := AVE(GROUP,IF(h.fips_cnty_desc = (TYPEOF(h.fips_cnty_desc))'',0,100));
    maxlength_fips_cnty_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_cnty_desc)));
    avelength_fips_cnty_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_cnty_desc)),h.fips_cnty_desc<>(typeof(h.fips_cnty_desc))'');
    populated_telephn_nbr_cnt := COUNT(GROUP,h.telephn_nbr <> (TYPEOF(h.telephn_nbr))'');
    populated_telephn_nbr_pcnt := AVE(GROUP,IF(h.telephn_nbr = (TYPEOF(h.telephn_nbr))'',0,100));
    maxlength_telephn_nbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephn_nbr)));
    avelength_telephn_nbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephn_nbr)),h.telephn_nbr<>(typeof(h.telephn_nbr))'');
    populated_cot_id_cnt := COUNT(GROUP,h.cot_id <> (TYPEOF(h.cot_id))'');
    populated_cot_id_pcnt := AVE(GROUP,IF(h.cot_id = (TYPEOF(h.cot_id))'',0,100));
    maxlength_cot_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cot_id)));
    avelength_cot_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cot_id)),h.cot_id<>(typeof(h.cot_id))'');
    populated_cot_clas_id_cnt := COUNT(GROUP,h.cot_clas_id <> (TYPEOF(h.cot_clas_id))'');
    populated_cot_clas_id_pcnt := AVE(GROUP,IF(h.cot_clas_id = (TYPEOF(h.cot_clas_id))'',0,100));
    maxlength_cot_clas_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cot_clas_id)));
    avelength_cot_clas_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cot_clas_id)),h.cot_clas_id<>(typeof(h.cot_clas_id))'');
    populated_cot_clas_desc_cnt := COUNT(GROUP,h.cot_clas_desc <> (TYPEOF(h.cot_clas_desc))'');
    populated_cot_clas_desc_pcnt := AVE(GROUP,IF(h.cot_clas_desc = (TYPEOF(h.cot_clas_desc))'',0,100));
    maxlength_cot_clas_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cot_clas_desc)));
    avelength_cot_clas_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cot_clas_desc)),h.cot_clas_desc<>(typeof(h.cot_clas_desc))'');
    populated_cot_fclt_typ_id_cnt := COUNT(GROUP,h.cot_fclt_typ_id <> (TYPEOF(h.cot_fclt_typ_id))'');
    populated_cot_fclt_typ_id_pcnt := AVE(GROUP,IF(h.cot_fclt_typ_id = (TYPEOF(h.cot_fclt_typ_id))'',0,100));
    maxlength_cot_fclt_typ_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cot_fclt_typ_id)));
    avelength_cot_fclt_typ_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cot_fclt_typ_id)),h.cot_fclt_typ_id<>(typeof(h.cot_fclt_typ_id))'');
    populated_cot_fclt_typ_desc_cnt := COUNT(GROUP,h.cot_fclt_typ_desc <> (TYPEOF(h.cot_fclt_typ_desc))'');
    populated_cot_fclt_typ_desc_pcnt := AVE(GROUP,IF(h.cot_fclt_typ_desc = (TYPEOF(h.cot_fclt_typ_desc))'',0,100));
    maxlength_cot_fclt_typ_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cot_fclt_typ_desc)));
    avelength_cot_fclt_typ_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cot_fclt_typ_desc)),h.cot_fclt_typ_desc<>(typeof(h.cot_fclt_typ_desc))'');
    populated_cot_spcl_id_cnt := COUNT(GROUP,h.cot_spcl_id <> (TYPEOF(h.cot_spcl_id))'');
    populated_cot_spcl_id_pcnt := AVE(GROUP,IF(h.cot_spcl_id = (TYPEOF(h.cot_spcl_id))'',0,100));
    maxlength_cot_spcl_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cot_spcl_id)));
    avelength_cot_spcl_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cot_spcl_id)),h.cot_spcl_id<>(typeof(h.cot_spcl_id))'');
    populated_cot_spcl_desc_cnt := COUNT(GROUP,h.cot_spcl_desc <> (TYPEOF(h.cot_spcl_desc))'');
    populated_cot_spcl_desc_pcnt := AVE(GROUP,IF(h.cot_spcl_desc = (TYPEOF(h.cot_spcl_desc))'',0,100));
    maxlength_cot_spcl_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cot_spcl_desc)));
    avelength_cot_spcl_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cot_spcl_desc)),h.cot_spcl_desc<>(typeof(h.cot_spcl_desc))'');
    populated_email_ind_flag_cnt := COUNT(GROUP,h.email_ind_flag <> (TYPEOF(h.email_ind_flag))'');
    populated_email_ind_flag_pcnt := AVE(GROUP,IF(h.email_ind_flag = (TYPEOF(h.email_ind_flag))'',0,100));
    maxlength_email_ind_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_ind_flag)));
    avelength_email_ind_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_ind_flag)),h.email_ind_flag<>(typeof(h.email_ind_flag))'');
    populated_hcp_affil_xid_cnt := COUNT(GROUP,h.hcp_affil_xid <> (TYPEOF(h.hcp_affil_xid))'');
    populated_hcp_affil_xid_pcnt := AVE(GROUP,IF(h.hcp_affil_xid = (TYPEOF(h.hcp_affil_xid))'',0,100));
    maxlength_hcp_affil_xid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hcp_affil_xid)));
    avelength_hcp_affil_xid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hcp_affil_xid)),h.hcp_affil_xid<>(typeof(h.hcp_affil_xid))'');
    populated_delta_cd_cnt := COUNT(GROUP,h.delta_cd <> (TYPEOF(h.delta_cd))'');
    populated_delta_cd_pcnt := AVE(GROUP,IF(h.delta_cd = (TYPEOF(h.delta_cd))'',0,100));
    maxlength_delta_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.delta_cd)));
    avelength_delta_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.delta_cd)),h.delta_cd<>(typeof(h.delta_cd))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_hcp_hce_id_pcnt *   0.00 / 100 + T.Populated_ok_indv_id_pcnt *   0.00 / 100 + T.Populated_ska_uid_pcnt *   0.00 / 100 + T.Populated_frst_nm_pcnt *   0.00 / 100 + T.Populated_mid_nm_pcnt *   0.00 / 100 + T.Populated_last_nm_pcnt *   0.00 / 100 + T.Populated_sfx_cd_pcnt *   0.00 / 100 + T.Populated_gender_cd_pcnt *   0.00 / 100 + T.Populated_prim_prfsn_cd_pcnt *   0.00 / 100 + T.Populated_prim_prfsn_desc_pcnt *   0.00 / 100 + T.Populated_prim_spcl_cd_pcnt *   0.00 / 100 + T.Populated_prim_spcl_desc_pcnt *   0.00 / 100 + T.Populated_sec_spcl_cd_pcnt *   0.00 / 100 + T.Populated_sec_spcl_desc_pcnt *   0.00 / 100 + T.Populated_tert_spcl_cd_pcnt *   0.00 / 100 + T.Populated_tert_spcl_desc_pcnt *   0.00 / 100 + T.Populated_sub_spcl_cd_pcnt *   0.00 / 100 + T.Populated_sub_spcl_desc_pcnt *   0.00 / 100 + T.Populated_titl_typ_id_pcnt *   0.00 / 100 + T.Populated_titl_typ_desc_pcnt *   0.00 / 100 + T.Populated_hco_hce_id_pcnt *   0.00 / 100 + T.Populated_ok_wkp_id_pcnt *   0.00 / 100 + T.Populated_ska_id_pcnt *   0.00 / 100 + T.Populated_bus_nm_pcnt *   0.00 / 100 + T.Populated_dba_nm_pcnt *   0.00 / 100 + T.Populated_addr_id_pcnt *   0.00 / 100 + T.Populated_str_front_id_pcnt *   0.00 / 100 + T.Populated_addr_ln_1_txt_pcnt *   0.00 / 100 + T.Populated_addr_ln_2_txt_pcnt *   0.00 / 100 + T.Populated_city_nm_pcnt *   0.00 / 100 + T.Populated_st_cd_pcnt *   0.00 / 100 + T.Populated_zip5_cd_pcnt *   0.00 / 100 + T.Populated_zip4_cd_pcnt *   0.00 / 100 + T.Populated_fips_cnty_cd_pcnt *   0.00 / 100 + T.Populated_fips_cnty_desc_pcnt *   0.00 / 100 + T.Populated_telephn_nbr_pcnt *   0.00 / 100 + T.Populated_cot_id_pcnt *   0.00 / 100 + T.Populated_cot_clas_id_pcnt *   0.00 / 100 + T.Populated_cot_clas_desc_pcnt *   0.00 / 100 + T.Populated_cot_fclt_typ_id_pcnt *   0.00 / 100 + T.Populated_cot_fclt_typ_desc_pcnt *   0.00 / 100 + T.Populated_cot_spcl_id_pcnt *   0.00 / 100 + T.Populated_cot_spcl_desc_pcnt *   0.00 / 100 + T.Populated_email_ind_flag_pcnt *   0.00 / 100 + T.Populated_hcp_affil_xid_pcnt *   0.00 / 100 + T.Populated_delta_cd_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'hcp_hce_id','ok_indv_id','ska_uid','frst_nm','mid_nm','last_nm','sfx_cd','gender_cd','prim_prfsn_cd','prim_prfsn_desc','prim_spcl_cd','prim_spcl_desc','sec_spcl_cd','sec_spcl_desc','tert_spcl_cd','tert_spcl_desc','sub_spcl_cd','sub_spcl_desc','titl_typ_id','titl_typ_desc','hco_hce_id','ok_wkp_id','ska_id','bus_nm','dba_nm','addr_id','str_front_id','addr_ln_1_txt','addr_ln_2_txt','city_nm','st_cd','zip5_cd','zip4_cd','fips_cnty_cd','fips_cnty_desc','telephn_nbr','cot_id','cot_clas_id','cot_clas_desc','cot_fclt_typ_id','cot_fclt_typ_desc','cot_spcl_id','cot_spcl_desc','email_ind_flag','hcp_affil_xid','delta_cd');
  SELF.populated_pcnt := CHOOSE(C,le.populated_hcp_hce_id_pcnt,le.populated_ok_indv_id_pcnt,le.populated_ska_uid_pcnt,le.populated_frst_nm_pcnt,le.populated_mid_nm_pcnt,le.populated_last_nm_pcnt,le.populated_sfx_cd_pcnt,le.populated_gender_cd_pcnt,le.populated_prim_prfsn_cd_pcnt,le.populated_prim_prfsn_desc_pcnt,le.populated_prim_spcl_cd_pcnt,le.populated_prim_spcl_desc_pcnt,le.populated_sec_spcl_cd_pcnt,le.populated_sec_spcl_desc_pcnt,le.populated_tert_spcl_cd_pcnt,le.populated_tert_spcl_desc_pcnt,le.populated_sub_spcl_cd_pcnt,le.populated_sub_spcl_desc_pcnt,le.populated_titl_typ_id_pcnt,le.populated_titl_typ_desc_pcnt,le.populated_hco_hce_id_pcnt,le.populated_ok_wkp_id_pcnt,le.populated_ska_id_pcnt,le.populated_bus_nm_pcnt,le.populated_dba_nm_pcnt,le.populated_addr_id_pcnt,le.populated_str_front_id_pcnt,le.populated_addr_ln_1_txt_pcnt,le.populated_addr_ln_2_txt_pcnt,le.populated_city_nm_pcnt,le.populated_st_cd_pcnt,le.populated_zip5_cd_pcnt,le.populated_zip4_cd_pcnt,le.populated_fips_cnty_cd_pcnt,le.populated_fips_cnty_desc_pcnt,le.populated_telephn_nbr_pcnt,le.populated_cot_id_pcnt,le.populated_cot_clas_id_pcnt,le.populated_cot_clas_desc_pcnt,le.populated_cot_fclt_typ_id_pcnt,le.populated_cot_fclt_typ_desc_pcnt,le.populated_cot_spcl_id_pcnt,le.populated_cot_spcl_desc_pcnt,le.populated_email_ind_flag_pcnt,le.populated_hcp_affil_xid_pcnt,le.populated_delta_cd_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_hcp_hce_id,le.maxlength_ok_indv_id,le.maxlength_ska_uid,le.maxlength_frst_nm,le.maxlength_mid_nm,le.maxlength_last_nm,le.maxlength_sfx_cd,le.maxlength_gender_cd,le.maxlength_prim_prfsn_cd,le.maxlength_prim_prfsn_desc,le.maxlength_prim_spcl_cd,le.maxlength_prim_spcl_desc,le.maxlength_sec_spcl_cd,le.maxlength_sec_spcl_desc,le.maxlength_tert_spcl_cd,le.maxlength_tert_spcl_desc,le.maxlength_sub_spcl_cd,le.maxlength_sub_spcl_desc,le.maxlength_titl_typ_id,le.maxlength_titl_typ_desc,le.maxlength_hco_hce_id,le.maxlength_ok_wkp_id,le.maxlength_ska_id,le.maxlength_bus_nm,le.maxlength_dba_nm,le.maxlength_addr_id,le.maxlength_str_front_id,le.maxlength_addr_ln_1_txt,le.maxlength_addr_ln_2_txt,le.maxlength_city_nm,le.maxlength_st_cd,le.maxlength_zip5_cd,le.maxlength_zip4_cd,le.maxlength_fips_cnty_cd,le.maxlength_fips_cnty_desc,le.maxlength_telephn_nbr,le.maxlength_cot_id,le.maxlength_cot_clas_id,le.maxlength_cot_clas_desc,le.maxlength_cot_fclt_typ_id,le.maxlength_cot_fclt_typ_desc,le.maxlength_cot_spcl_id,le.maxlength_cot_spcl_desc,le.maxlength_email_ind_flag,le.maxlength_hcp_affil_xid,le.maxlength_delta_cd);
  SELF.avelength := CHOOSE(C,le.avelength_hcp_hce_id,le.avelength_ok_indv_id,le.avelength_ska_uid,le.avelength_frst_nm,le.avelength_mid_nm,le.avelength_last_nm,le.avelength_sfx_cd,le.avelength_gender_cd,le.avelength_prim_prfsn_cd,le.avelength_prim_prfsn_desc,le.avelength_prim_spcl_cd,le.avelength_prim_spcl_desc,le.avelength_sec_spcl_cd,le.avelength_sec_spcl_desc,le.avelength_tert_spcl_cd,le.avelength_tert_spcl_desc,le.avelength_sub_spcl_cd,le.avelength_sub_spcl_desc,le.avelength_titl_typ_id,le.avelength_titl_typ_desc,le.avelength_hco_hce_id,le.avelength_ok_wkp_id,le.avelength_ska_id,le.avelength_bus_nm,le.avelength_dba_nm,le.avelength_addr_id,le.avelength_str_front_id,le.avelength_addr_ln_1_txt,le.avelength_addr_ln_2_txt,le.avelength_city_nm,le.avelength_st_cd,le.avelength_zip5_cd,le.avelength_zip4_cd,le.avelength_fips_cnty_cd,le.avelength_fips_cnty_desc,le.avelength_telephn_nbr,le.avelength_cot_id,le.avelength_cot_clas_id,le.avelength_cot_clas_desc,le.avelength_cot_fclt_typ_id,le.avelength_cot_fclt_typ_desc,le.avelength_cot_spcl_id,le.avelength_cot_spcl_desc,le.avelength_email_ind_flag,le.avelength_hcp_affil_xid,le.avelength_delta_cd);
END;
EXPORT invSummary := NORMALIZE(summary0, 46, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.hcp_hce_id),TRIM((SALT311.StrType)le.ok_indv_id),TRIM((SALT311.StrType)le.ska_uid),TRIM((SALT311.StrType)le.frst_nm),TRIM((SALT311.StrType)le.mid_nm),TRIM((SALT311.StrType)le.last_nm),TRIM((SALT311.StrType)le.sfx_cd),TRIM((SALT311.StrType)le.gender_cd),TRIM((SALT311.StrType)le.prim_prfsn_cd),TRIM((SALT311.StrType)le.prim_prfsn_desc),TRIM((SALT311.StrType)le.prim_spcl_cd),TRIM((SALT311.StrType)le.prim_spcl_desc),TRIM((SALT311.StrType)le.sec_spcl_cd),TRIM((SALT311.StrType)le.sec_spcl_desc),TRIM((SALT311.StrType)le.tert_spcl_cd),TRIM((SALT311.StrType)le.tert_spcl_desc),TRIM((SALT311.StrType)le.sub_spcl_cd),TRIM((SALT311.StrType)le.sub_spcl_desc),TRIM((SALT311.StrType)le.titl_typ_id),TRIM((SALT311.StrType)le.titl_typ_desc),TRIM((SALT311.StrType)le.hco_hce_id),TRIM((SALT311.StrType)le.ok_wkp_id),TRIM((SALT311.StrType)le.ska_id),TRIM((SALT311.StrType)le.bus_nm),TRIM((SALT311.StrType)le.dba_nm),TRIM((SALT311.StrType)le.addr_id),TRIM((SALT311.StrType)le.str_front_id),TRIM((SALT311.StrType)le.addr_ln_1_txt),TRIM((SALT311.StrType)le.addr_ln_2_txt),TRIM((SALT311.StrType)le.city_nm),TRIM((SALT311.StrType)le.st_cd),TRIM((SALT311.StrType)le.zip5_cd),TRIM((SALT311.StrType)le.zip4_cd),TRIM((SALT311.StrType)le.fips_cnty_cd),TRIM((SALT311.StrType)le.fips_cnty_desc),TRIM((SALT311.StrType)le.telephn_nbr),TRIM((SALT311.StrType)le.cot_id),TRIM((SALT311.StrType)le.cot_clas_id),TRIM((SALT311.StrType)le.cot_clas_desc),TRIM((SALT311.StrType)le.cot_fclt_typ_id),TRIM((SALT311.StrType)le.cot_fclt_typ_desc),TRIM((SALT311.StrType)le.cot_spcl_id),TRIM((SALT311.StrType)le.cot_spcl_desc),TRIM((SALT311.StrType)le.email_ind_flag),TRIM((SALT311.StrType)le.hcp_affil_xid),TRIM((SALT311.StrType)le.delta_cd)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,46,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 46);
  SELF.FldNo2 := 1 + (C % 46);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.hcp_hce_id),TRIM((SALT311.StrType)le.ok_indv_id),TRIM((SALT311.StrType)le.ska_uid),TRIM((SALT311.StrType)le.frst_nm),TRIM((SALT311.StrType)le.mid_nm),TRIM((SALT311.StrType)le.last_nm),TRIM((SALT311.StrType)le.sfx_cd),TRIM((SALT311.StrType)le.gender_cd),TRIM((SALT311.StrType)le.prim_prfsn_cd),TRIM((SALT311.StrType)le.prim_prfsn_desc),TRIM((SALT311.StrType)le.prim_spcl_cd),TRIM((SALT311.StrType)le.prim_spcl_desc),TRIM((SALT311.StrType)le.sec_spcl_cd),TRIM((SALT311.StrType)le.sec_spcl_desc),TRIM((SALT311.StrType)le.tert_spcl_cd),TRIM((SALT311.StrType)le.tert_spcl_desc),TRIM((SALT311.StrType)le.sub_spcl_cd),TRIM((SALT311.StrType)le.sub_spcl_desc),TRIM((SALT311.StrType)le.titl_typ_id),TRIM((SALT311.StrType)le.titl_typ_desc),TRIM((SALT311.StrType)le.hco_hce_id),TRIM((SALT311.StrType)le.ok_wkp_id),TRIM((SALT311.StrType)le.ska_id),TRIM((SALT311.StrType)le.bus_nm),TRIM((SALT311.StrType)le.dba_nm),TRIM((SALT311.StrType)le.addr_id),TRIM((SALT311.StrType)le.str_front_id),TRIM((SALT311.StrType)le.addr_ln_1_txt),TRIM((SALT311.StrType)le.addr_ln_2_txt),TRIM((SALT311.StrType)le.city_nm),TRIM((SALT311.StrType)le.st_cd),TRIM((SALT311.StrType)le.zip5_cd),TRIM((SALT311.StrType)le.zip4_cd),TRIM((SALT311.StrType)le.fips_cnty_cd),TRIM((SALT311.StrType)le.fips_cnty_desc),TRIM((SALT311.StrType)le.telephn_nbr),TRIM((SALT311.StrType)le.cot_id),TRIM((SALT311.StrType)le.cot_clas_id),TRIM((SALT311.StrType)le.cot_clas_desc),TRIM((SALT311.StrType)le.cot_fclt_typ_id),TRIM((SALT311.StrType)le.cot_fclt_typ_desc),TRIM((SALT311.StrType)le.cot_spcl_id),TRIM((SALT311.StrType)le.cot_spcl_desc),TRIM((SALT311.StrType)le.email_ind_flag),TRIM((SALT311.StrType)le.hcp_affil_xid),TRIM((SALT311.StrType)le.delta_cd)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.hcp_hce_id),TRIM((SALT311.StrType)le.ok_indv_id),TRIM((SALT311.StrType)le.ska_uid),TRIM((SALT311.StrType)le.frst_nm),TRIM((SALT311.StrType)le.mid_nm),TRIM((SALT311.StrType)le.last_nm),TRIM((SALT311.StrType)le.sfx_cd),TRIM((SALT311.StrType)le.gender_cd),TRIM((SALT311.StrType)le.prim_prfsn_cd),TRIM((SALT311.StrType)le.prim_prfsn_desc),TRIM((SALT311.StrType)le.prim_spcl_cd),TRIM((SALT311.StrType)le.prim_spcl_desc),TRIM((SALT311.StrType)le.sec_spcl_cd),TRIM((SALT311.StrType)le.sec_spcl_desc),TRIM((SALT311.StrType)le.tert_spcl_cd),TRIM((SALT311.StrType)le.tert_spcl_desc),TRIM((SALT311.StrType)le.sub_spcl_cd),TRIM((SALT311.StrType)le.sub_spcl_desc),TRIM((SALT311.StrType)le.titl_typ_id),TRIM((SALT311.StrType)le.titl_typ_desc),TRIM((SALT311.StrType)le.hco_hce_id),TRIM((SALT311.StrType)le.ok_wkp_id),TRIM((SALT311.StrType)le.ska_id),TRIM((SALT311.StrType)le.bus_nm),TRIM((SALT311.StrType)le.dba_nm),TRIM((SALT311.StrType)le.addr_id),TRIM((SALT311.StrType)le.str_front_id),TRIM((SALT311.StrType)le.addr_ln_1_txt),TRIM((SALT311.StrType)le.addr_ln_2_txt),TRIM((SALT311.StrType)le.city_nm),TRIM((SALT311.StrType)le.st_cd),TRIM((SALT311.StrType)le.zip5_cd),TRIM((SALT311.StrType)le.zip4_cd),TRIM((SALT311.StrType)le.fips_cnty_cd),TRIM((SALT311.StrType)le.fips_cnty_desc),TRIM((SALT311.StrType)le.telephn_nbr),TRIM((SALT311.StrType)le.cot_id),TRIM((SALT311.StrType)le.cot_clas_id),TRIM((SALT311.StrType)le.cot_clas_desc),TRIM((SALT311.StrType)le.cot_fclt_typ_id),TRIM((SALT311.StrType)le.cot_fclt_typ_desc),TRIM((SALT311.StrType)le.cot_spcl_id),TRIM((SALT311.StrType)le.cot_spcl_desc),TRIM((SALT311.StrType)le.email_ind_flag),TRIM((SALT311.StrType)le.hcp_affil_xid),TRIM((SALT311.StrType)le.delta_cd)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),46*46,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'hcp_hce_id'}
      ,{2,'ok_indv_id'}
      ,{3,'ska_uid'}
      ,{4,'frst_nm'}
      ,{5,'mid_nm'}
      ,{6,'last_nm'}
      ,{7,'sfx_cd'}
      ,{8,'gender_cd'}
      ,{9,'prim_prfsn_cd'}
      ,{10,'prim_prfsn_desc'}
      ,{11,'prim_spcl_cd'}
      ,{12,'prim_spcl_desc'}
      ,{13,'sec_spcl_cd'}
      ,{14,'sec_spcl_desc'}
      ,{15,'tert_spcl_cd'}
      ,{16,'tert_spcl_desc'}
      ,{17,'sub_spcl_cd'}
      ,{18,'sub_spcl_desc'}
      ,{19,'titl_typ_id'}
      ,{20,'titl_typ_desc'}
      ,{21,'hco_hce_id'}
      ,{22,'ok_wkp_id'}
      ,{23,'ska_id'}
      ,{24,'bus_nm'}
      ,{25,'dba_nm'}
      ,{26,'addr_id'}
      ,{27,'str_front_id'}
      ,{28,'addr_ln_1_txt'}
      ,{29,'addr_ln_2_txt'}
      ,{30,'city_nm'}
      ,{31,'st_cd'}
      ,{32,'zip5_cd'}
      ,{33,'zip4_cd'}
      ,{34,'fips_cnty_cd'}
      ,{35,'fips_cnty_desc'}
      ,{36,'telephn_nbr'}
      ,{37,'cot_id'}
      ,{38,'cot_clas_id'}
      ,{39,'cot_clas_desc'}
      ,{40,'cot_fclt_typ_id'}
      ,{41,'cot_fclt_typ_desc'}
      ,{42,'cot_spcl_id'}
      ,{43,'cot_spcl_desc'}
      ,{44,'email_ind_flag'}
      ,{45,'hcp_affil_xid'}
      ,{46,'delta_cd'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    InputA_Fields.InValid_hcp_hce_id((SALT311.StrType)le.hcp_hce_id),
    InputA_Fields.InValid_ok_indv_id((SALT311.StrType)le.ok_indv_id),
    InputA_Fields.InValid_ska_uid((SALT311.StrType)le.ska_uid),
    InputA_Fields.InValid_frst_nm((SALT311.StrType)le.frst_nm,(SALT311.StrType)le.mid_nm,(SALT311.StrType)le.last_nm),
    InputA_Fields.InValid_mid_nm((SALT311.StrType)le.mid_nm,(SALT311.StrType)le.frst_nm,(SALT311.StrType)le.last_nm),
    InputA_Fields.InValid_last_nm((SALT311.StrType)le.last_nm,(SALT311.StrType)le.frst_nm,(SALT311.StrType)le.mid_nm),
    InputA_Fields.InValid_sfx_cd((SALT311.StrType)le.sfx_cd),
    InputA_Fields.InValid_gender_cd((SALT311.StrType)le.gender_cd),
    InputA_Fields.InValid_prim_prfsn_cd((SALT311.StrType)le.prim_prfsn_cd,(SALT311.StrType)le.prim_prfsn_desc),
    InputA_Fields.InValid_prim_prfsn_desc((SALT311.StrType)le.prim_prfsn_desc,(SALT311.StrType)le.prim_prfsn_cd),
    InputA_Fields.InValid_prim_spcl_cd((SALT311.StrType)le.prim_spcl_cd,(SALT311.StrType)le.prim_spcl_desc),
    InputA_Fields.InValid_prim_spcl_desc((SALT311.StrType)le.prim_spcl_desc,(SALT311.StrType)le.prim_spcl_cd),
    InputA_Fields.InValid_sec_spcl_cd((SALT311.StrType)le.sec_spcl_cd,(SALT311.StrType)le.sec_spcl_desc),
    InputA_Fields.InValid_sec_spcl_desc((SALT311.StrType)le.sec_spcl_desc,(SALT311.StrType)le.sec_spcl_cd),
    InputA_Fields.InValid_tert_spcl_cd((SALT311.StrType)le.tert_spcl_cd,(SALT311.StrType)le.tert_spcl_desc),
    InputA_Fields.InValid_tert_spcl_desc((SALT311.StrType)le.tert_spcl_desc,(SALT311.StrType)le.tert_spcl_cd),
    InputA_Fields.InValid_sub_spcl_cd((SALT311.StrType)le.sub_spcl_cd,(SALT311.StrType)le.sub_spcl_desc),
    InputA_Fields.InValid_sub_spcl_desc((SALT311.StrType)le.sub_spcl_desc,(SALT311.StrType)le.sub_spcl_cd),
    InputA_Fields.InValid_titl_typ_id((SALT311.StrType)le.titl_typ_id,(SALT311.StrType)le.titl_typ_desc),
    InputA_Fields.InValid_titl_typ_desc((SALT311.StrType)le.titl_typ_desc,(SALT311.StrType)le.titl_typ_id),
    InputA_Fields.InValid_hco_hce_id((SALT311.StrType)le.hco_hce_id),
    InputA_Fields.InValid_ok_wkp_id((SALT311.StrType)le.ok_wkp_id),
    InputA_Fields.InValid_ska_id((SALT311.StrType)le.ska_id),
    InputA_Fields.InValid_bus_nm((SALT311.StrType)le.bus_nm),
    InputA_Fields.InValid_dba_nm((SALT311.StrType)le.dba_nm),
    InputA_Fields.InValid_addr_id((SALT311.StrType)le.addr_id),
    InputA_Fields.InValid_str_front_id((SALT311.StrType)le.str_front_id),
    InputA_Fields.InValid_addr_ln_1_txt((SALT311.StrType)le.addr_ln_1_txt),
    InputA_Fields.InValid_addr_ln_2_txt((SALT311.StrType)le.addr_ln_2_txt),
    InputA_Fields.InValid_city_nm((SALT311.StrType)le.city_nm),
    InputA_Fields.InValid_st_cd((SALT311.StrType)le.st_cd),
    InputA_Fields.InValid_zip5_cd((SALT311.StrType)le.zip5_cd),
    InputA_Fields.InValid_zip4_cd((SALT311.StrType)le.zip4_cd),
    InputA_Fields.InValid_fips_cnty_cd((SALT311.StrType)le.fips_cnty_cd),
    InputA_Fields.InValid_fips_cnty_desc((SALT311.StrType)le.fips_cnty_desc),
    InputA_Fields.InValid_telephn_nbr((SALT311.StrType)le.telephn_nbr),
    InputA_Fields.InValid_cot_id((SALT311.StrType)le.cot_id),
    InputA_Fields.InValid_cot_clas_id((SALT311.StrType)le.cot_clas_id),
    InputA_Fields.InValid_cot_clas_desc((SALT311.StrType)le.cot_clas_desc),
    InputA_Fields.InValid_cot_fclt_typ_id((SALT311.StrType)le.cot_fclt_typ_id),
    InputA_Fields.InValid_cot_fclt_typ_desc((SALT311.StrType)le.cot_fclt_typ_desc),
    InputA_Fields.InValid_cot_spcl_id((SALT311.StrType)le.cot_spcl_id),
    InputA_Fields.InValid_cot_spcl_desc((SALT311.StrType)le.cot_spcl_desc),
    InputA_Fields.InValid_email_ind_flag((SALT311.StrType)le.email_ind_flag),
    InputA_Fields.InValid_hcp_affil_xid((SALT311.StrType)le.hcp_affil_xid,(SALT311.StrType)le.hcp_hce_id,(SALT311.StrType)le.hco_hce_id,(SALT311.StrType)le.titl_typ_id),
    InputA_Fields.InValid_delta_cd((SALT311.StrType)le.delta_cd),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,46,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := InputA_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric_nonzero','Unknown','Unknown','invalid_frst_nm','invalid_mid_nm','invalid_last_nm','Unknown','Unknown','invalid_prim_prfsn_cd','invalid_prim_prfsn_desc','invalid_prim_spcl_cd','invalid_prim_spcl_desc','invalid_sec_spcl_cd','invalid_sec_spcl_desc','invalid_tert_spcl_cd','invalid_tert_spcl_desc','invalid_sub_spcl_cd','invalid_sub_spcl_desc','invalid_titl_typ_id','invalid_titl_typ_desc','invalid_numeric_nonzero','invalid_ok_wkp_id','invalid_numeric_nonzero','invalid_mandatory','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_city_nm','invalid_st_cd','invalid_zip5_cd','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_hcp_affil_xid','invalid_delta_cd');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,InputA_Fields.InValidMessage_hcp_hce_id(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_ok_indv_id(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_ska_uid(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_frst_nm(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_mid_nm(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_last_nm(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_sfx_cd(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_gender_cd(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_prim_prfsn_cd(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_prim_prfsn_desc(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_prim_spcl_cd(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_prim_spcl_desc(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_sec_spcl_cd(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_sec_spcl_desc(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_tert_spcl_cd(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_tert_spcl_desc(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_sub_spcl_cd(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_sub_spcl_desc(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_titl_typ_id(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_titl_typ_desc(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_hco_hce_id(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_ok_wkp_id(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_ska_id(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_bus_nm(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_dba_nm(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_addr_id(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_str_front_id(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_addr_ln_1_txt(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_addr_ln_2_txt(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_city_nm(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_st_cd(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_zip5_cd(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_zip4_cd(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_fips_cnty_cd(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_fips_cnty_desc(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_telephn_nbr(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_cot_id(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_cot_clas_id(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_cot_clas_desc(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_cot_fclt_typ_id(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_cot_fclt_typ_desc(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_cot_spcl_id(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_cot_spcl_desc(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_email_ind_flag(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_hcp_affil_xid(TotalErrors.ErrorNum),InputA_Fields.InValidMessage_delta_cd(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OneKey, InputA_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

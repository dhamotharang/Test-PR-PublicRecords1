IMPORT SALT311,STD;
EXPORT Base_hygiene(dataset(Base_layout_OneKey) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_source_cnt := COUNT(GROUP,h.source <> (TYPEOF(h.source))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_bdid_score_cnt := COUNT(GROUP,h.bdid_score <> (TYPEOF(h.bdid_score))'');
    populated_bdid_score_pcnt := AVE(GROUP,IF(h.bdid_score = (TYPEOF(h.bdid_score))'',0,100));
    maxlength_bdid_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid_score)));
    avelength_bdid_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid_score)),h.bdid_score<>(typeof(h.bdid_score))'');
    populated_source_rec_id_cnt := COUNT(GROUP,h.source_rec_id <> (TYPEOF(h.source_rec_id))'');
    populated_source_rec_id_pcnt := AVE(GROUP,IF(h.source_rec_id = (TYPEOF(h.source_rec_id))'',0,100));
    maxlength_source_rec_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_rec_id)));
    avelength_source_rec_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_rec_id)),h.source_rec_id<>(typeof(h.source_rec_id))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
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
    populated_ims_id_cnt := COUNT(GROUP,h.ims_id <> (TYPEOF(h.ims_id))'');
    populated_ims_id_pcnt := AVE(GROUP,IF(h.ims_id = (TYPEOF(h.ims_id))'',0,100));
    maxlength_ims_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ims_id)));
    avelength_ims_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ims_id)),h.ims_id<>(typeof(h.ims_id))'');
    populated_hce_prfsnl_stat_cd_cnt := COUNT(GROUP,h.hce_prfsnl_stat_cd <> (TYPEOF(h.hce_prfsnl_stat_cd))'');
    populated_hce_prfsnl_stat_cd_pcnt := AVE(GROUP,IF(h.hce_prfsnl_stat_cd = (TYPEOF(h.hce_prfsnl_stat_cd))'',0,100));
    maxlength_hce_prfsnl_stat_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hce_prfsnl_stat_cd)));
    avelength_hce_prfsnl_stat_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hce_prfsnl_stat_cd)),h.hce_prfsnl_stat_cd<>(typeof(h.hce_prfsnl_stat_cd))'');
    populated_hce_prfsnl_stat_desc_cnt := COUNT(GROUP,h.hce_prfsnl_stat_desc <> (TYPEOF(h.hce_prfsnl_stat_desc))'');
    populated_hce_prfsnl_stat_desc_pcnt := AVE(GROUP,IF(h.hce_prfsnl_stat_desc = (TYPEOF(h.hce_prfsnl_stat_desc))'',0,100));
    maxlength_hce_prfsnl_stat_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hce_prfsnl_stat_desc)));
    avelength_hce_prfsnl_stat_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hce_prfsnl_stat_desc)),h.hce_prfsnl_stat_desc<>(typeof(h.hce_prfsnl_stat_desc))'');
    populated_excld_rsn_desc_cnt := COUNT(GROUP,h.excld_rsn_desc <> (TYPEOF(h.excld_rsn_desc))'');
    populated_excld_rsn_desc_pcnt := AVE(GROUP,IF(h.excld_rsn_desc = (TYPEOF(h.excld_rsn_desc))'',0,100));
    maxlength_excld_rsn_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.excld_rsn_desc)));
    avelength_excld_rsn_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.excld_rsn_desc)),h.excld_rsn_desc<>(typeof(h.excld_rsn_desc))'');
    populated_npi_cnt := COUNT(GROUP,h.npi <> (TYPEOF(h.npi))'');
    populated_npi_pcnt := AVE(GROUP,IF(h.npi = (TYPEOF(h.npi))'',0,100));
    maxlength_npi := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.npi)));
    avelength_npi := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.npi)),h.npi<>(typeof(h.npi))'');
    populated_deactv_dt_cnt := COUNT(GROUP,h.deactv_dt <> (TYPEOF(h.deactv_dt))'');
    populated_deactv_dt_pcnt := AVE(GROUP,IF(h.deactv_dt = (TYPEOF(h.deactv_dt))'',0,100));
    maxlength_deactv_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.deactv_dt)));
    avelength_deactv_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.deactv_dt)),h.deactv_dt<>(typeof(h.deactv_dt))'');
    populated_cleaned_deactv_dt_cnt := COUNT(GROUP,h.cleaned_deactv_dt <> (TYPEOF(h.cleaned_deactv_dt))'');
    populated_cleaned_deactv_dt_pcnt := AVE(GROUP,IF(h.cleaned_deactv_dt = (TYPEOF(h.cleaned_deactv_dt))'',0,100));
    maxlength_cleaned_deactv_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleaned_deactv_dt)));
    avelength_cleaned_deactv_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleaned_deactv_dt)),h.cleaned_deactv_dt<>(typeof(h.cleaned_deactv_dt))'');
    populated_xref_hce_id_cnt := COUNT(GROUP,h.xref_hce_id <> (TYPEOF(h.xref_hce_id))'');
    populated_xref_hce_id_pcnt := AVE(GROUP,IF(h.xref_hce_id = (TYPEOF(h.xref_hce_id))'',0,100));
    maxlength_xref_hce_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.xref_hce_id)));
    avelength_xref_hce_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.xref_hce_id)),h.xref_hce_id<>(typeof(h.xref_hce_id))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_cnt := COUNT(GROUP,h.name_score <> (TYPEOF(h.name_score))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_prep_addr_line1_cnt := COUNT(GROUP,h.prep_addr_line1 <> (TYPEOF(h.prep_addr_line1))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_line_last_cnt := COUNT(GROUP,h.prep_addr_line_last <> (TYPEOF(h.prep_addr_line_last))'');
    populated_prep_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_addr_line_last = (TYPEOF(h.prep_addr_line_last))'',0,100));
    maxlength_prep_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line_last)));
    avelength_prep_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line_last)),h.prep_addr_line_last<>(typeof(h.prep_addr_line_last))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_cnt := COUNT(GROUP,h.dbpc <> (TYPEOF(h.dbpc))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_fips_state_cnt := COUNT(GROUP,h.fips_state <> (TYPEOF(h.fips_state))'');
    populated_fips_state_pcnt := AVE(GROUP,IF(h.fips_state = (TYPEOF(h.fips_state))'',0,100));
    maxlength_fips_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_state)));
    avelength_fips_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_state)),h.fips_state<>(typeof(h.fips_state))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_raw_aid_cnt := COUNT(GROUP,h.raw_aid <> (TYPEOF(h.raw_aid))'');
    populated_raw_aid_pcnt := AVE(GROUP,IF(h.raw_aid = (TYPEOF(h.raw_aid))'',0,100));
    maxlength_raw_aid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_aid)));
    avelength_raw_aid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_aid)),h.raw_aid<>(typeof(h.raw_aid))'');
    populated_ace_aid_cnt := COUNT(GROUP,h.ace_aid <> (TYPEOF(h.ace_aid))'');
    populated_ace_aid_pcnt := AVE(GROUP,IF(h.ace_aid = (TYPEOF(h.ace_aid))'',0,100));
    maxlength_ace_aid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_aid)));
    avelength_ace_aid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_aid)),h.ace_aid<>(typeof(h.ace_aid))'');
    populated_dotid_cnt := COUNT(GROUP,h.dotid <> (TYPEOF(h.dotid))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_cnt := COUNT(GROUP,h.dotscore <> (TYPEOF(h.dotscore))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_cnt := COUNT(GROUP,h.dotweight <> (TYPEOF(h.dotweight))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_cnt := COUNT(GROUP,h.empid <> (TYPEOF(h.empid))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_cnt := COUNT(GROUP,h.empscore <> (TYPEOF(h.empscore))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_cnt := COUNT(GROUP,h.empweight <> (TYPEOF(h.empweight))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_cnt := COUNT(GROUP,h.powid <> (TYPEOF(h.powid))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_cnt := COUNT(GROUP,h.powscore <> (TYPEOF(h.powscore))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_cnt := COUNT(GROUP,h.powweight <> (TYPEOF(h.powweight))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_cnt := COUNT(GROUP,h.proxid <> (TYPEOF(h.proxid))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_cnt := COUNT(GROUP,h.proxscore <> (TYPEOF(h.proxscore))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_cnt := COUNT(GROUP,h.proxweight <> (TYPEOF(h.proxweight))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_cnt := COUNT(GROUP,h.seleid <> (TYPEOF(h.seleid))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_cnt := COUNT(GROUP,h.selescore <> (TYPEOF(h.selescore))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_cnt := COUNT(GROUP,h.seleweight <> (TYPEOF(h.seleweight))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_cnt := COUNT(GROUP,h.orgid <> (TYPEOF(h.orgid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_cnt := COUNT(GROUP,h.orgscore <> (TYPEOF(h.orgscore))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_cnt := COUNT(GROUP,h.orgweight <> (TYPEOF(h.orgweight))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_cnt := COUNT(GROUP,h.ultid <> (TYPEOF(h.ultid))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_cnt := COUNT(GROUP,h.ultscore <> (TYPEOF(h.ultscore))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_cnt := COUNT(GROUP,h.ultweight <> (TYPEOF(h.ultweight))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_bdid_score_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_hcp_hce_id_pcnt *   0.00 / 100 + T.Populated_ok_indv_id_pcnt *   0.00 / 100 + T.Populated_ska_uid_pcnt *   0.00 / 100 + T.Populated_frst_nm_pcnt *   0.00 / 100 + T.Populated_mid_nm_pcnt *   0.00 / 100 + T.Populated_last_nm_pcnt *   0.00 / 100 + T.Populated_sfx_cd_pcnt *   0.00 / 100 + T.Populated_gender_cd_pcnt *   0.00 / 100 + T.Populated_prim_prfsn_cd_pcnt *   0.00 / 100 + T.Populated_prim_prfsn_desc_pcnt *   0.00 / 100 + T.Populated_prim_spcl_cd_pcnt *   0.00 / 100 + T.Populated_prim_spcl_desc_pcnt *   0.00 / 100 + T.Populated_sec_spcl_cd_pcnt *   0.00 / 100 + T.Populated_sec_spcl_desc_pcnt *   0.00 / 100 + T.Populated_tert_spcl_cd_pcnt *   0.00 / 100 + T.Populated_tert_spcl_desc_pcnt *   0.00 / 100 + T.Populated_sub_spcl_cd_pcnt *   0.00 / 100 + T.Populated_sub_spcl_desc_pcnt *   0.00 / 100 + T.Populated_titl_typ_id_pcnt *   0.00 / 100 + T.Populated_titl_typ_desc_pcnt *   0.00 / 100 + T.Populated_hco_hce_id_pcnt *   0.00 / 100 + T.Populated_ok_wkp_id_pcnt *   0.00 / 100 + T.Populated_ska_id_pcnt *   0.00 / 100 + T.Populated_bus_nm_pcnt *   0.00 / 100 + T.Populated_dba_nm_pcnt *   0.00 / 100 + T.Populated_addr_id_pcnt *   0.00 / 100 + T.Populated_str_front_id_pcnt *   0.00 / 100 + T.Populated_addr_ln_1_txt_pcnt *   0.00 / 100 + T.Populated_addr_ln_2_txt_pcnt *   0.00 / 100 + T.Populated_city_nm_pcnt *   0.00 / 100 + T.Populated_st_cd_pcnt *   0.00 / 100 + T.Populated_zip5_cd_pcnt *   0.00 / 100 + T.Populated_zip4_cd_pcnt *   0.00 / 100 + T.Populated_fips_cnty_cd_pcnt *   0.00 / 100 + T.Populated_fips_cnty_desc_pcnt *   0.00 / 100 + T.Populated_telephn_nbr_pcnt *   0.00 / 100 + T.Populated_cot_id_pcnt *   0.00 / 100 + T.Populated_cot_clas_id_pcnt *   0.00 / 100 + T.Populated_cot_clas_desc_pcnt *   0.00 / 100 + T.Populated_cot_fclt_typ_id_pcnt *   0.00 / 100 + T.Populated_cot_fclt_typ_desc_pcnt *   0.00 / 100 + T.Populated_cot_spcl_id_pcnt *   0.00 / 100 + T.Populated_cot_spcl_desc_pcnt *   0.00 / 100 + T.Populated_email_ind_flag_pcnt *   0.00 / 100 + T.Populated_ims_id_pcnt *   0.00 / 100 + T.Populated_hce_prfsnl_stat_cd_pcnt *   0.00 / 100 + T.Populated_hce_prfsnl_stat_desc_pcnt *   0.00 / 100 + T.Populated_excld_rsn_desc_pcnt *   0.00 / 100 + T.Populated_npi_pcnt *   0.00 / 100 + T.Populated_deactv_dt_pcnt *   0.00 / 100 + T.Populated_cleaned_deactv_dt_pcnt *   0.00 / 100 + T.Populated_xref_hce_id_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_line_last_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_raw_aid_pcnt *   0.00 / 100 + T.Populated_ace_aid_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'source','bdid','bdid_score','source_rec_id','dt_vendor_first_reported','dt_vendor_last_reported','record_type','hcp_hce_id','ok_indv_id','ska_uid','frst_nm','mid_nm','last_nm','sfx_cd','gender_cd','prim_prfsn_cd','prim_prfsn_desc','prim_spcl_cd','prim_spcl_desc','sec_spcl_cd','sec_spcl_desc','tert_spcl_cd','tert_spcl_desc','sub_spcl_cd','sub_spcl_desc','titl_typ_id','titl_typ_desc','hco_hce_id','ok_wkp_id','ska_id','bus_nm','dba_nm','addr_id','str_front_id','addr_ln_1_txt','addr_ln_2_txt','city_nm','st_cd','zip5_cd','zip4_cd','fips_cnty_cd','fips_cnty_desc','telephn_nbr','cot_id','cot_clas_id','cot_clas_desc','cot_fclt_typ_id','cot_fclt_typ_desc','cot_spcl_id','cot_spcl_desc','email_ind_flag','ims_id','hce_prfsnl_stat_cd','hce_prfsnl_stat_desc','excld_rsn_desc','npi','deactv_dt','cleaned_deactv_dt','xref_hce_id','title','fname','mname','lname','name_suffix','name_score','prep_addr_line1','prep_addr_line_last','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
  SELF.populated_pcnt := CHOOSE(C,le.populated_source_pcnt,le.populated_bdid_pcnt,le.populated_bdid_score_pcnt,le.populated_source_rec_id_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_record_type_pcnt,le.populated_hcp_hce_id_pcnt,le.populated_ok_indv_id_pcnt,le.populated_ska_uid_pcnt,le.populated_frst_nm_pcnt,le.populated_mid_nm_pcnt,le.populated_last_nm_pcnt,le.populated_sfx_cd_pcnt,le.populated_gender_cd_pcnt,le.populated_prim_prfsn_cd_pcnt,le.populated_prim_prfsn_desc_pcnt,le.populated_prim_spcl_cd_pcnt,le.populated_prim_spcl_desc_pcnt,le.populated_sec_spcl_cd_pcnt,le.populated_sec_spcl_desc_pcnt,le.populated_tert_spcl_cd_pcnt,le.populated_tert_spcl_desc_pcnt,le.populated_sub_spcl_cd_pcnt,le.populated_sub_spcl_desc_pcnt,le.populated_titl_typ_id_pcnt,le.populated_titl_typ_desc_pcnt,le.populated_hco_hce_id_pcnt,le.populated_ok_wkp_id_pcnt,le.populated_ska_id_pcnt,le.populated_bus_nm_pcnt,le.populated_dba_nm_pcnt,le.populated_addr_id_pcnt,le.populated_str_front_id_pcnt,le.populated_addr_ln_1_txt_pcnt,le.populated_addr_ln_2_txt_pcnt,le.populated_city_nm_pcnt,le.populated_st_cd_pcnt,le.populated_zip5_cd_pcnt,le.populated_zip4_cd_pcnt,le.populated_fips_cnty_cd_pcnt,le.populated_fips_cnty_desc_pcnt,le.populated_telephn_nbr_pcnt,le.populated_cot_id_pcnt,le.populated_cot_clas_id_pcnt,le.populated_cot_clas_desc_pcnt,le.populated_cot_fclt_typ_id_pcnt,le.populated_cot_fclt_typ_desc_pcnt,le.populated_cot_spcl_id_pcnt,le.populated_cot_spcl_desc_pcnt,le.populated_email_ind_flag_pcnt,le.populated_ims_id_pcnt,le.populated_hce_prfsnl_stat_cd_pcnt,le.populated_hce_prfsnl_stat_desc_pcnt,le.populated_excld_rsn_desc_pcnt,le.populated_npi_pcnt,le.populated_deactv_dt_pcnt,le.populated_cleaned_deactv_dt_pcnt,le.populated_xref_hce_id_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_line_last_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_raw_aid_pcnt,le.populated_ace_aid_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_source,le.maxlength_bdid,le.maxlength_bdid_score,le.maxlength_source_rec_id,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_record_type,le.maxlength_hcp_hce_id,le.maxlength_ok_indv_id,le.maxlength_ska_uid,le.maxlength_frst_nm,le.maxlength_mid_nm,le.maxlength_last_nm,le.maxlength_sfx_cd,le.maxlength_gender_cd,le.maxlength_prim_prfsn_cd,le.maxlength_prim_prfsn_desc,le.maxlength_prim_spcl_cd,le.maxlength_prim_spcl_desc,le.maxlength_sec_spcl_cd,le.maxlength_sec_spcl_desc,le.maxlength_tert_spcl_cd,le.maxlength_tert_spcl_desc,le.maxlength_sub_spcl_cd,le.maxlength_sub_spcl_desc,le.maxlength_titl_typ_id,le.maxlength_titl_typ_desc,le.maxlength_hco_hce_id,le.maxlength_ok_wkp_id,le.maxlength_ska_id,le.maxlength_bus_nm,le.maxlength_dba_nm,le.maxlength_addr_id,le.maxlength_str_front_id,le.maxlength_addr_ln_1_txt,le.maxlength_addr_ln_2_txt,le.maxlength_city_nm,le.maxlength_st_cd,le.maxlength_zip5_cd,le.maxlength_zip4_cd,le.maxlength_fips_cnty_cd,le.maxlength_fips_cnty_desc,le.maxlength_telephn_nbr,le.maxlength_cot_id,le.maxlength_cot_clas_id,le.maxlength_cot_clas_desc,le.maxlength_cot_fclt_typ_id,le.maxlength_cot_fclt_typ_desc,le.maxlength_cot_spcl_id,le.maxlength_cot_spcl_desc,le.maxlength_email_ind_flag,le.maxlength_ims_id,le.maxlength_hce_prfsnl_stat_cd,le.maxlength_hce_prfsnl_stat_desc,le.maxlength_excld_rsn_desc,le.maxlength_npi,le.maxlength_deactv_dt,le.maxlength_cleaned_deactv_dt,le.maxlength_xref_hce_id,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_line_last,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_raw_aid,le.maxlength_ace_aid,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight);
  SELF.avelength := CHOOSE(C,le.avelength_source,le.avelength_bdid,le.avelength_bdid_score,le.avelength_source_rec_id,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_record_type,le.avelength_hcp_hce_id,le.avelength_ok_indv_id,le.avelength_ska_uid,le.avelength_frst_nm,le.avelength_mid_nm,le.avelength_last_nm,le.avelength_sfx_cd,le.avelength_gender_cd,le.avelength_prim_prfsn_cd,le.avelength_prim_prfsn_desc,le.avelength_prim_spcl_cd,le.avelength_prim_spcl_desc,le.avelength_sec_spcl_cd,le.avelength_sec_spcl_desc,le.avelength_tert_spcl_cd,le.avelength_tert_spcl_desc,le.avelength_sub_spcl_cd,le.avelength_sub_spcl_desc,le.avelength_titl_typ_id,le.avelength_titl_typ_desc,le.avelength_hco_hce_id,le.avelength_ok_wkp_id,le.avelength_ska_id,le.avelength_bus_nm,le.avelength_dba_nm,le.avelength_addr_id,le.avelength_str_front_id,le.avelength_addr_ln_1_txt,le.avelength_addr_ln_2_txt,le.avelength_city_nm,le.avelength_st_cd,le.avelength_zip5_cd,le.avelength_zip4_cd,le.avelength_fips_cnty_cd,le.avelength_fips_cnty_desc,le.avelength_telephn_nbr,le.avelength_cot_id,le.avelength_cot_clas_id,le.avelength_cot_clas_desc,le.avelength_cot_fclt_typ_id,le.avelength_cot_fclt_typ_desc,le.avelength_cot_spcl_id,le.avelength_cot_spcl_desc,le.avelength_email_ind_flag,le.avelength_ims_id,le.avelength_hce_prfsnl_stat_cd,le.avelength_hce_prfsnl_stat_desc,le.avelength_excld_rsn_desc,le.avelength_npi,le.avelength_deactv_dt,le.avelength_cleaned_deactv_dt,le.avelength_xref_hce_id,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_prep_addr_line1,le.avelength_prep_addr_line_last,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_state,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_raw_aid,le.avelength_ace_aid,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight);
END;
EXPORT invSummary := NORMALIZE(summary0, 117, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.source),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT311.StrType)le.bdid_score), ''),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.hcp_hce_id),TRIM((SALT311.StrType)le.ok_indv_id),TRIM((SALT311.StrType)le.ska_uid),TRIM((SALT311.StrType)le.frst_nm),TRIM((SALT311.StrType)le.mid_nm),TRIM((SALT311.StrType)le.last_nm),TRIM((SALT311.StrType)le.sfx_cd),TRIM((SALT311.StrType)le.gender_cd),TRIM((SALT311.StrType)le.prim_prfsn_cd),TRIM((SALT311.StrType)le.prim_prfsn_desc),TRIM((SALT311.StrType)le.prim_spcl_cd),TRIM((SALT311.StrType)le.prim_spcl_desc),TRIM((SALT311.StrType)le.sec_spcl_cd),TRIM((SALT311.StrType)le.sec_spcl_desc),TRIM((SALT311.StrType)le.tert_spcl_cd),TRIM((SALT311.StrType)le.tert_spcl_desc),TRIM((SALT311.StrType)le.sub_spcl_cd),TRIM((SALT311.StrType)le.sub_spcl_desc),TRIM((SALT311.StrType)le.titl_typ_id),TRIM((SALT311.StrType)le.titl_typ_desc),TRIM((SALT311.StrType)le.hco_hce_id),TRIM((SALT311.StrType)le.ok_wkp_id),TRIM((SALT311.StrType)le.ska_id),TRIM((SALT311.StrType)le.bus_nm),TRIM((SALT311.StrType)le.dba_nm),TRIM((SALT311.StrType)le.addr_id),TRIM((SALT311.StrType)le.str_front_id),TRIM((SALT311.StrType)le.addr_ln_1_txt),TRIM((SALT311.StrType)le.addr_ln_2_txt),TRIM((SALT311.StrType)le.city_nm),TRIM((SALT311.StrType)le.st_cd),TRIM((SALT311.StrType)le.zip5_cd),TRIM((SALT311.StrType)le.zip4_cd),TRIM((SALT311.StrType)le.fips_cnty_cd),TRIM((SALT311.StrType)le.fips_cnty_desc),TRIM((SALT311.StrType)le.telephn_nbr),TRIM((SALT311.StrType)le.cot_id),TRIM((SALT311.StrType)le.cot_clas_id),TRIM((SALT311.StrType)le.cot_clas_desc),TRIM((SALT311.StrType)le.cot_fclt_typ_id),TRIM((SALT311.StrType)le.cot_fclt_typ_desc),TRIM((SALT311.StrType)le.cot_spcl_id),TRIM((SALT311.StrType)le.cot_spcl_desc),TRIM((SALT311.StrType)le.email_ind_flag),TRIM((SALT311.StrType)le.ims_id),TRIM((SALT311.StrType)le.hce_prfsnl_stat_cd),TRIM((SALT311.StrType)le.hce_prfsnl_stat_desc),TRIM((SALT311.StrType)le.excld_rsn_desc),TRIM((SALT311.StrType)le.npi),TRIM((SALT311.StrType)le.deactv_dt),TRIM((SALT311.StrType)le.cleaned_deactv_dt),TRIM((SALT311.StrType)le.xref_hce_id),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_line_last),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.raw_aid <> 0,TRIM((SALT311.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT311.StrType)le.ace_aid), ''),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,117,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 117);
  SELF.FldNo2 := 1 + (C % 117);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.source),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT311.StrType)le.bdid_score), ''),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.hcp_hce_id),TRIM((SALT311.StrType)le.ok_indv_id),TRIM((SALT311.StrType)le.ska_uid),TRIM((SALT311.StrType)le.frst_nm),TRIM((SALT311.StrType)le.mid_nm),TRIM((SALT311.StrType)le.last_nm),TRIM((SALT311.StrType)le.sfx_cd),TRIM((SALT311.StrType)le.gender_cd),TRIM((SALT311.StrType)le.prim_prfsn_cd),TRIM((SALT311.StrType)le.prim_prfsn_desc),TRIM((SALT311.StrType)le.prim_spcl_cd),TRIM((SALT311.StrType)le.prim_spcl_desc),TRIM((SALT311.StrType)le.sec_spcl_cd),TRIM((SALT311.StrType)le.sec_spcl_desc),TRIM((SALT311.StrType)le.tert_spcl_cd),TRIM((SALT311.StrType)le.tert_spcl_desc),TRIM((SALT311.StrType)le.sub_spcl_cd),TRIM((SALT311.StrType)le.sub_spcl_desc),TRIM((SALT311.StrType)le.titl_typ_id),TRIM((SALT311.StrType)le.titl_typ_desc),TRIM((SALT311.StrType)le.hco_hce_id),TRIM((SALT311.StrType)le.ok_wkp_id),TRIM((SALT311.StrType)le.ska_id),TRIM((SALT311.StrType)le.bus_nm),TRIM((SALT311.StrType)le.dba_nm),TRIM((SALT311.StrType)le.addr_id),TRIM((SALT311.StrType)le.str_front_id),TRIM((SALT311.StrType)le.addr_ln_1_txt),TRIM((SALT311.StrType)le.addr_ln_2_txt),TRIM((SALT311.StrType)le.city_nm),TRIM((SALT311.StrType)le.st_cd),TRIM((SALT311.StrType)le.zip5_cd),TRIM((SALT311.StrType)le.zip4_cd),TRIM((SALT311.StrType)le.fips_cnty_cd),TRIM((SALT311.StrType)le.fips_cnty_desc),TRIM((SALT311.StrType)le.telephn_nbr),TRIM((SALT311.StrType)le.cot_id),TRIM((SALT311.StrType)le.cot_clas_id),TRIM((SALT311.StrType)le.cot_clas_desc),TRIM((SALT311.StrType)le.cot_fclt_typ_id),TRIM((SALT311.StrType)le.cot_fclt_typ_desc),TRIM((SALT311.StrType)le.cot_spcl_id),TRIM((SALT311.StrType)le.cot_spcl_desc),TRIM((SALT311.StrType)le.email_ind_flag),TRIM((SALT311.StrType)le.ims_id),TRIM((SALT311.StrType)le.hce_prfsnl_stat_cd),TRIM((SALT311.StrType)le.hce_prfsnl_stat_desc),TRIM((SALT311.StrType)le.excld_rsn_desc),TRIM((SALT311.StrType)le.npi),TRIM((SALT311.StrType)le.deactv_dt),TRIM((SALT311.StrType)le.cleaned_deactv_dt),TRIM((SALT311.StrType)le.xref_hce_id),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_line_last),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.raw_aid <> 0,TRIM((SALT311.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT311.StrType)le.ace_aid), ''),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.source),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT311.StrType)le.bdid_score), ''),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.hcp_hce_id),TRIM((SALT311.StrType)le.ok_indv_id),TRIM((SALT311.StrType)le.ska_uid),TRIM((SALT311.StrType)le.frst_nm),TRIM((SALT311.StrType)le.mid_nm),TRIM((SALT311.StrType)le.last_nm),TRIM((SALT311.StrType)le.sfx_cd),TRIM((SALT311.StrType)le.gender_cd),TRIM((SALT311.StrType)le.prim_prfsn_cd),TRIM((SALT311.StrType)le.prim_prfsn_desc),TRIM((SALT311.StrType)le.prim_spcl_cd),TRIM((SALT311.StrType)le.prim_spcl_desc),TRIM((SALT311.StrType)le.sec_spcl_cd),TRIM((SALT311.StrType)le.sec_spcl_desc),TRIM((SALT311.StrType)le.tert_spcl_cd),TRIM((SALT311.StrType)le.tert_spcl_desc),TRIM((SALT311.StrType)le.sub_spcl_cd),TRIM((SALT311.StrType)le.sub_spcl_desc),TRIM((SALT311.StrType)le.titl_typ_id),TRIM((SALT311.StrType)le.titl_typ_desc),TRIM((SALT311.StrType)le.hco_hce_id),TRIM((SALT311.StrType)le.ok_wkp_id),TRIM((SALT311.StrType)le.ska_id),TRIM((SALT311.StrType)le.bus_nm),TRIM((SALT311.StrType)le.dba_nm),TRIM((SALT311.StrType)le.addr_id),TRIM((SALT311.StrType)le.str_front_id),TRIM((SALT311.StrType)le.addr_ln_1_txt),TRIM((SALT311.StrType)le.addr_ln_2_txt),TRIM((SALT311.StrType)le.city_nm),TRIM((SALT311.StrType)le.st_cd),TRIM((SALT311.StrType)le.zip5_cd),TRIM((SALT311.StrType)le.zip4_cd),TRIM((SALT311.StrType)le.fips_cnty_cd),TRIM((SALT311.StrType)le.fips_cnty_desc),TRIM((SALT311.StrType)le.telephn_nbr),TRIM((SALT311.StrType)le.cot_id),TRIM((SALT311.StrType)le.cot_clas_id),TRIM((SALT311.StrType)le.cot_clas_desc),TRIM((SALT311.StrType)le.cot_fclt_typ_id),TRIM((SALT311.StrType)le.cot_fclt_typ_desc),TRIM((SALT311.StrType)le.cot_spcl_id),TRIM((SALT311.StrType)le.cot_spcl_desc),TRIM((SALT311.StrType)le.email_ind_flag),TRIM((SALT311.StrType)le.ims_id),TRIM((SALT311.StrType)le.hce_prfsnl_stat_cd),TRIM((SALT311.StrType)le.hce_prfsnl_stat_desc),TRIM((SALT311.StrType)le.excld_rsn_desc),TRIM((SALT311.StrType)le.npi),TRIM((SALT311.StrType)le.deactv_dt),TRIM((SALT311.StrType)le.cleaned_deactv_dt),TRIM((SALT311.StrType)le.xref_hce_id),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_line_last),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.raw_aid <> 0,TRIM((SALT311.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT311.StrType)le.ace_aid), ''),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),117*117,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'source'}
      ,{2,'bdid'}
      ,{3,'bdid_score'}
      ,{4,'source_rec_id'}
      ,{5,'dt_vendor_first_reported'}
      ,{6,'dt_vendor_last_reported'}
      ,{7,'record_type'}
      ,{8,'hcp_hce_id'}
      ,{9,'ok_indv_id'}
      ,{10,'ska_uid'}
      ,{11,'frst_nm'}
      ,{12,'mid_nm'}
      ,{13,'last_nm'}
      ,{14,'sfx_cd'}
      ,{15,'gender_cd'}
      ,{16,'prim_prfsn_cd'}
      ,{17,'prim_prfsn_desc'}
      ,{18,'prim_spcl_cd'}
      ,{19,'prim_spcl_desc'}
      ,{20,'sec_spcl_cd'}
      ,{21,'sec_spcl_desc'}
      ,{22,'tert_spcl_cd'}
      ,{23,'tert_spcl_desc'}
      ,{24,'sub_spcl_cd'}
      ,{25,'sub_spcl_desc'}
      ,{26,'titl_typ_id'}
      ,{27,'titl_typ_desc'}
      ,{28,'hco_hce_id'}
      ,{29,'ok_wkp_id'}
      ,{30,'ska_id'}
      ,{31,'bus_nm'}
      ,{32,'dba_nm'}
      ,{33,'addr_id'}
      ,{34,'str_front_id'}
      ,{35,'addr_ln_1_txt'}
      ,{36,'addr_ln_2_txt'}
      ,{37,'city_nm'}
      ,{38,'st_cd'}
      ,{39,'zip5_cd'}
      ,{40,'zip4_cd'}
      ,{41,'fips_cnty_cd'}
      ,{42,'fips_cnty_desc'}
      ,{43,'telephn_nbr'}
      ,{44,'cot_id'}
      ,{45,'cot_clas_id'}
      ,{46,'cot_clas_desc'}
      ,{47,'cot_fclt_typ_id'}
      ,{48,'cot_fclt_typ_desc'}
      ,{49,'cot_spcl_id'}
      ,{50,'cot_spcl_desc'}
      ,{51,'email_ind_flag'}
      ,{52,'ims_id'}
      ,{53,'hce_prfsnl_stat_cd'}
      ,{54,'hce_prfsnl_stat_desc'}
      ,{55,'excld_rsn_desc'}
      ,{56,'npi'}
      ,{57,'deactv_dt'}
      ,{58,'cleaned_deactv_dt'}
      ,{59,'xref_hce_id'}
      ,{60,'title'}
      ,{61,'fname'}
      ,{62,'mname'}
      ,{63,'lname'}
      ,{64,'name_suffix'}
      ,{65,'name_score'}
      ,{66,'prep_addr_line1'}
      ,{67,'prep_addr_line_last'}
      ,{68,'prim_range'}
      ,{69,'predir'}
      ,{70,'prim_name'}
      ,{71,'addr_suffix'}
      ,{72,'postdir'}
      ,{73,'unit_desig'}
      ,{74,'sec_range'}
      ,{75,'p_city_name'}
      ,{76,'v_city_name'}
      ,{77,'st'}
      ,{78,'zip'}
      ,{79,'zip4'}
      ,{80,'cart'}
      ,{81,'cr_sort_sz'}
      ,{82,'lot'}
      ,{83,'lot_order'}
      ,{84,'dbpc'}
      ,{85,'chk_digit'}
      ,{86,'rec_type'}
      ,{87,'fips_state'}
      ,{88,'fips_county'}
      ,{89,'geo_lat'}
      ,{90,'geo_long'}
      ,{91,'msa'}
      ,{92,'geo_blk'}
      ,{93,'geo_match'}
      ,{94,'err_stat'}
      ,{95,'raw_aid'}
      ,{96,'ace_aid'}
      ,{97,'dotid'}
      ,{98,'dotscore'}
      ,{99,'dotweight'}
      ,{100,'empid'}
      ,{101,'empscore'}
      ,{102,'empweight'}
      ,{103,'powid'}
      ,{104,'powscore'}
      ,{105,'powweight'}
      ,{106,'proxid'}
      ,{107,'proxscore'}
      ,{108,'proxweight'}
      ,{109,'seleid'}
      ,{110,'selescore'}
      ,{111,'seleweight'}
      ,{112,'orgid'}
      ,{113,'orgscore'}
      ,{114,'orgweight'}
      ,{115,'ultid'}
      ,{116,'ultscore'}
      ,{117,'ultweight'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Fields.InValid_source((SALT311.StrType)le.source),
    Base_Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Base_Fields.InValid_bdid_score((SALT311.StrType)le.bdid_score),
    Base_Fields.InValid_source_rec_id((SALT311.StrType)le.source_rec_id),
    Base_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Base_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Base_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Base_Fields.InValid_hcp_hce_id((SALT311.StrType)le.hcp_hce_id),
    Base_Fields.InValid_ok_indv_id((SALT311.StrType)le.ok_indv_id),
    Base_Fields.InValid_ska_uid((SALT311.StrType)le.ska_uid),
    Base_Fields.InValid_frst_nm((SALT311.StrType)le.frst_nm,(SALT311.StrType)le.mid_nm,(SALT311.StrType)le.last_nm),
    Base_Fields.InValid_mid_nm((SALT311.StrType)le.mid_nm,(SALT311.StrType)le.frst_nm,(SALT311.StrType)le.last_nm),
    Base_Fields.InValid_last_nm((SALT311.StrType)le.last_nm,(SALT311.StrType)le.frst_nm,(SALT311.StrType)le.mid_nm),
    Base_Fields.InValid_sfx_cd((SALT311.StrType)le.sfx_cd),
    Base_Fields.InValid_gender_cd((SALT311.StrType)le.gender_cd),
    Base_Fields.InValid_prim_prfsn_cd((SALT311.StrType)le.prim_prfsn_cd,(SALT311.StrType)le.prim_prfsn_desc),
    Base_Fields.InValid_prim_prfsn_desc((SALT311.StrType)le.prim_prfsn_desc,(SALT311.StrType)le.prim_prfsn_cd),
    Base_Fields.InValid_prim_spcl_cd((SALT311.StrType)le.prim_spcl_cd,(SALT311.StrType)le.prim_spcl_desc),
    Base_Fields.InValid_prim_spcl_desc((SALT311.StrType)le.prim_spcl_desc,(SALT311.StrType)le.prim_spcl_cd),
    Base_Fields.InValid_sec_spcl_cd((SALT311.StrType)le.sec_spcl_cd,(SALT311.StrType)le.sec_spcl_desc),
    Base_Fields.InValid_sec_spcl_desc((SALT311.StrType)le.sec_spcl_desc,(SALT311.StrType)le.sec_spcl_cd),
    Base_Fields.InValid_tert_spcl_cd((SALT311.StrType)le.tert_spcl_cd,(SALT311.StrType)le.tert_spcl_desc),
    Base_Fields.InValid_tert_spcl_desc((SALT311.StrType)le.tert_spcl_desc,(SALT311.StrType)le.tert_spcl_cd),
    Base_Fields.InValid_sub_spcl_cd((SALT311.StrType)le.sub_spcl_cd,(SALT311.StrType)le.sub_spcl_desc),
    Base_Fields.InValid_sub_spcl_desc((SALT311.StrType)le.sub_spcl_desc,(SALT311.StrType)le.sub_spcl_cd),
    Base_Fields.InValid_titl_typ_id((SALT311.StrType)le.titl_typ_id,(SALT311.StrType)le.titl_typ_desc),
    Base_Fields.InValid_titl_typ_desc((SALT311.StrType)le.titl_typ_desc,(SALT311.StrType)le.titl_typ_id),
    Base_Fields.InValid_hco_hce_id((SALT311.StrType)le.hco_hce_id),
    Base_Fields.InValid_ok_wkp_id((SALT311.StrType)le.ok_wkp_id),
    Base_Fields.InValid_ska_id((SALT311.StrType)le.ska_id),
    Base_Fields.InValid_bus_nm((SALT311.StrType)le.bus_nm),
    Base_Fields.InValid_dba_nm((SALT311.StrType)le.dba_nm),
    Base_Fields.InValid_addr_id((SALT311.StrType)le.addr_id),
    Base_Fields.InValid_str_front_id((SALT311.StrType)le.str_front_id),
    Base_Fields.InValid_addr_ln_1_txt((SALT311.StrType)le.addr_ln_1_txt),
    Base_Fields.InValid_addr_ln_2_txt((SALT311.StrType)le.addr_ln_2_txt),
    Base_Fields.InValid_city_nm((SALT311.StrType)le.city_nm),
    Base_Fields.InValid_st_cd((SALT311.StrType)le.st_cd),
    Base_Fields.InValid_zip5_cd((SALT311.StrType)le.zip5_cd),
    Base_Fields.InValid_zip4_cd((SALT311.StrType)le.zip4_cd),
    Base_Fields.InValid_fips_cnty_cd((SALT311.StrType)le.fips_cnty_cd),
    Base_Fields.InValid_fips_cnty_desc((SALT311.StrType)le.fips_cnty_desc),
    Base_Fields.InValid_telephn_nbr((SALT311.StrType)le.telephn_nbr),
    Base_Fields.InValid_cot_id((SALT311.StrType)le.cot_id),
    Base_Fields.InValid_cot_clas_id((SALT311.StrType)le.cot_clas_id),
    Base_Fields.InValid_cot_clas_desc((SALT311.StrType)le.cot_clas_desc),
    Base_Fields.InValid_cot_fclt_typ_id((SALT311.StrType)le.cot_fclt_typ_id),
    Base_Fields.InValid_cot_fclt_typ_desc((SALT311.StrType)le.cot_fclt_typ_desc),
    Base_Fields.InValid_cot_spcl_id((SALT311.StrType)le.cot_spcl_id),
    Base_Fields.InValid_cot_spcl_desc((SALT311.StrType)le.cot_spcl_desc),
    Base_Fields.InValid_email_ind_flag((SALT311.StrType)le.email_ind_flag),
    Base_Fields.InValid_ims_id((SALT311.StrType)le.ims_id),
    Base_Fields.InValid_hce_prfsnl_stat_cd((SALT311.StrType)le.hce_prfsnl_stat_cd),
    Base_Fields.InValid_hce_prfsnl_stat_desc((SALT311.StrType)le.hce_prfsnl_stat_desc),
    Base_Fields.InValid_excld_rsn_desc((SALT311.StrType)le.excld_rsn_desc),
    Base_Fields.InValid_npi((SALT311.StrType)le.npi),
    Base_Fields.InValid_deactv_dt((SALT311.StrType)le.deactv_dt),
    Base_Fields.InValid_cleaned_deactv_dt((SALT311.StrType)le.cleaned_deactv_dt),
    Base_Fields.InValid_xref_hce_id((SALT311.StrType)le.xref_hce_id),
    Base_Fields.InValid_title((SALT311.StrType)le.title),
    Base_Fields.InValid_fname((SALT311.StrType)le.fname),
    Base_Fields.InValid_mname((SALT311.StrType)le.mname),
    Base_Fields.InValid_lname((SALT311.StrType)le.lname),
    Base_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Base_Fields.InValid_name_score((SALT311.StrType)le.name_score),
    Base_Fields.InValid_prep_addr_line1((SALT311.StrType)le.prep_addr_line1),
    Base_Fields.InValid_prep_addr_line_last((SALT311.StrType)le.prep_addr_line_last),
    Base_Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Base_Fields.InValid_predir((SALT311.StrType)le.predir),
    Base_Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Base_Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix),
    Base_Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Base_Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Base_Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Base_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    Base_Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    Base_Fields.InValid_st((SALT311.StrType)le.st),
    Base_Fields.InValid_zip((SALT311.StrType)le.zip),
    Base_Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Base_Fields.InValid_cart((SALT311.StrType)le.cart),
    Base_Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    Base_Fields.InValid_lot((SALT311.StrType)le.lot),
    Base_Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    Base_Fields.InValid_dbpc((SALT311.StrType)le.dbpc),
    Base_Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    Base_Fields.InValid_rec_type((SALT311.StrType)le.rec_type),
    Base_Fields.InValid_fips_state((SALT311.StrType)le.fips_state),
    Base_Fields.InValid_fips_county((SALT311.StrType)le.fips_county),
    Base_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Base_Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Base_Fields.InValid_msa((SALT311.StrType)le.msa),
    Base_Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Base_Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Base_Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    Base_Fields.InValid_raw_aid((SALT311.StrType)le.raw_aid),
    Base_Fields.InValid_ace_aid((SALT311.StrType)le.ace_aid),
    Base_Fields.InValid_dotid((SALT311.StrType)le.dotid),
    Base_Fields.InValid_dotscore((SALT311.StrType)le.dotscore),
    Base_Fields.InValid_dotweight((SALT311.StrType)le.dotweight),
    Base_Fields.InValid_empid((SALT311.StrType)le.empid),
    Base_Fields.InValid_empscore((SALT311.StrType)le.empscore),
    Base_Fields.InValid_empweight((SALT311.StrType)le.empweight),
    Base_Fields.InValid_powid((SALT311.StrType)le.powid),
    Base_Fields.InValid_powscore((SALT311.StrType)le.powscore),
    Base_Fields.InValid_powweight((SALT311.StrType)le.powweight),
    Base_Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Base_Fields.InValid_proxscore((SALT311.StrType)le.proxscore),
    Base_Fields.InValid_proxweight((SALT311.StrType)le.proxweight),
    Base_Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Base_Fields.InValid_selescore((SALT311.StrType)le.selescore),
    Base_Fields.InValid_seleweight((SALT311.StrType)le.seleweight),
    Base_Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Base_Fields.InValid_orgscore((SALT311.StrType)le.orgscore),
    Base_Fields.InValid_orgweight((SALT311.StrType)le.orgweight),
    Base_Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Base_Fields.InValid_ultscore((SALT311.StrType)le.ultscore),
    Base_Fields.InValid_ultweight((SALT311.StrType)le.ultweight),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,117,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_source','invalid_numeric','Unknown','invalid_numeric_nonzero','invalid_pastdate8','invalid_pastdate8','invalid_record_type','invalid_numeric_nonzero','Unknown','Unknown','invalid_frst_nm','invalid_mid_nm','invalid_last_nm','Unknown','Unknown','invalid_prim_prfsn_cd','invalid_prim_prfsn_desc','invalid_prim_spcl_cd','invalid_prim_spcl_desc','invalid_sec_spcl_cd','invalid_sec_spcl_desc','invalid_tert_spcl_cd','invalid_tert_spcl_desc','invalid_sub_spcl_cd','invalid_sub_spcl_desc','invalid_titl_typ_id','invalid_titl_typ_desc','invalid_numeric_nonzero','invalid_ok_wkp_id','invalid_numeric_nonzero','invalid_mandatory','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_mandatory','invalid_mandatory','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Fields.InValidMessage_source(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),Base_Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_hcp_hce_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ok_indv_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ska_uid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_frst_nm(TotalErrors.ErrorNum),Base_Fields.InValidMessage_mid_nm(TotalErrors.ErrorNum),Base_Fields.InValidMessage_last_nm(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sfx_cd(TotalErrors.ErrorNum),Base_Fields.InValidMessage_gender_cd(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_prfsn_cd(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_prfsn_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_spcl_cd(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_spcl_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sec_spcl_cd(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sec_spcl_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_tert_spcl_cd(TotalErrors.ErrorNum),Base_Fields.InValidMessage_tert_spcl_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sub_spcl_cd(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sub_spcl_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_titl_typ_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_titl_typ_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_hco_hce_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ok_wkp_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ska_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bus_nm(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dba_nm(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addr_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_str_front_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addr_ln_1_txt(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addr_ln_2_txt(TotalErrors.ErrorNum),Base_Fields.InValidMessage_city_nm(TotalErrors.ErrorNum),Base_Fields.InValidMessage_st_cd(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip5_cd(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip4_cd(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_cnty_cd(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_cnty_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_telephn_nbr(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cot_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cot_clas_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cot_clas_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cot_fclt_typ_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cot_fclt_typ_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cot_spcl_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cot_spcl_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_email_ind_flag(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ims_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_hce_prfsnl_stat_cd(TotalErrors.ErrorNum),Base_Fields.InValidMessage_hce_prfsnl_stat_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_excld_rsn_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_npi(TotalErrors.ErrorNum),Base_Fields.InValidMessage_deactv_dt(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cleaned_deactv_dt(TotalErrors.ErrorNum),Base_Fields.InValidMessage_xref_hce_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_title(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_addr_line_last(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Base_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Base_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_raw_aid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ace_aid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultweight(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OneKey, Base_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

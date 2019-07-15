IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_LGID3) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.source))'', MAX(GROUP,h.source));
    NumberOfRecords := COUNT(GROUP);
    populated_sbfe_id_cnt := COUNT(GROUP,h.sbfe_id <> (TYPEOF(h.sbfe_id))'');
    populated_sbfe_id_pcnt := AVE(GROUP,IF(h.sbfe_id = (TYPEOF(h.sbfe_id))'',0,100));
    maxlength_sbfe_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sbfe_id)));
    avelength_sbfe_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sbfe_id)),h.sbfe_id<>(typeof(h.sbfe_id))'');
    populated_nodes_below_st_cnt := COUNT(GROUP,h.nodes_below_st <> (TYPEOF(h.nodes_below_st))'');
    populated_nodes_below_st_pcnt := AVE(GROUP,IF(h.nodes_below_st = (TYPEOF(h.nodes_below_st))'',0,100));
    maxlength_nodes_below_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nodes_below_st)));
    avelength_nodes_below_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nodes_below_st)),h.nodes_below_st<>(typeof(h.nodes_below_st))'');
    populated_Lgid3IfHrchy_cnt := COUNT(GROUP,h.Lgid3IfHrchy <> (TYPEOF(h.Lgid3IfHrchy))'');
    populated_Lgid3IfHrchy_pcnt := AVE(GROUP,IF(h.Lgid3IfHrchy = (TYPEOF(h.Lgid3IfHrchy))'',0,100));
    maxlength_Lgid3IfHrchy := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Lgid3IfHrchy)));
    avelength_Lgid3IfHrchy := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Lgid3IfHrchy)),h.Lgid3IfHrchy<>(typeof(h.Lgid3IfHrchy))'');
    populated_OriginalSeleId_cnt := COUNT(GROUP,h.OriginalSeleId <> (TYPEOF(h.OriginalSeleId))'');
    populated_OriginalSeleId_pcnt := AVE(GROUP,IF(h.OriginalSeleId = (TYPEOF(h.OriginalSeleId))'',0,100));
    maxlength_OriginalSeleId := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.OriginalSeleId)));
    avelength_OriginalSeleId := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.OriginalSeleId)),h.OriginalSeleId<>(typeof(h.OriginalSeleId))'');
    populated_OriginalOrgId_cnt := COUNT(GROUP,h.OriginalOrgId <> (TYPEOF(h.OriginalOrgId))'');
    populated_OriginalOrgId_pcnt := AVE(GROUP,IF(h.OriginalOrgId = (TYPEOF(h.OriginalOrgId))'',0,100));
    maxlength_OriginalOrgId := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.OriginalOrgId)));
    avelength_OriginalOrgId := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.OriginalOrgId)),h.OriginalOrgId<>(typeof(h.OriginalOrgId))'');
    populated_company_name_cnt := COUNT(GROUP,h.company_name <> (TYPEOF(h.company_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_cnp_number_cnt := COUNT(GROUP,h.cnp_number <> (TYPEOF(h.cnp_number))'');
    populated_cnp_number_pcnt := AVE(GROUP,IF(h.cnp_number = (TYPEOF(h.cnp_number))'',0,100));
    maxlength_cnp_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_number)));
    avelength_cnp_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_number)),h.cnp_number<>(typeof(h.cnp_number))'');
    populated_active_duns_number_cnt := COUNT(GROUP,h.active_duns_number <> (TYPEOF(h.active_duns_number))'');
    populated_active_duns_number_pcnt := AVE(GROUP,IF(h.active_duns_number = (TYPEOF(h.active_duns_number))'',0,100));
    maxlength_active_duns_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_duns_number)));
    avelength_active_duns_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_duns_number)),h.active_duns_number<>(typeof(h.active_duns_number))'');
    populated_duns_number_cnt := COUNT(GROUP,h.duns_number <> (TYPEOF(h.duns_number))'');
    populated_duns_number_pcnt := AVE(GROUP,IF(h.duns_number = (TYPEOF(h.duns_number))'',0,100));
    maxlength_duns_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.duns_number)));
    avelength_duns_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.duns_number)),h.duns_number<>(typeof(h.duns_number))'');
    populated_company_fein_cnt := COUNT(GROUP,h.company_fein <> (TYPEOF(h.company_fein))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_company_inc_state_cnt := COUNT(GROUP,h.company_inc_state <> (TYPEOF(h.company_inc_state))'');
    populated_company_inc_state_pcnt := AVE(GROUP,IF(h.company_inc_state = (TYPEOF(h.company_inc_state))'',0,100));
    maxlength_company_inc_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_inc_state)));
    avelength_company_inc_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_inc_state)),h.company_inc_state<>(typeof(h.company_inc_state))'');
    populated_company_charter_number_cnt := COUNT(GROUP,h.company_charter_number <> (TYPEOF(h.company_charter_number))'');
    populated_company_charter_number_pcnt := AVE(GROUP,IF(h.company_charter_number = (TYPEOF(h.company_charter_number))'',0,100));
    maxlength_company_charter_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_charter_number)));
    avelength_company_charter_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_charter_number)),h.company_charter_number<>(typeof(h.company_charter_number))'');
    populated_cnp_btype_cnt := COUNT(GROUP,h.cnp_btype <> (TYPEOF(h.cnp_btype))'');
    populated_cnp_btype_pcnt := AVE(GROUP,IF(h.cnp_btype = (TYPEOF(h.cnp_btype))'',0,100));
    maxlength_cnp_btype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_btype)));
    avelength_cnp_btype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_btype)),h.cnp_btype<>(typeof(h.cnp_btype))'');
    populated_company_name_type_derived_cnt := COUNT(GROUP,h.company_name_type_derived <> (TYPEOF(h.company_name_type_derived))'');
    populated_company_name_type_derived_pcnt := AVE(GROUP,IF(h.company_name_type_derived = (TYPEOF(h.company_name_type_derived))'',0,100));
    maxlength_company_name_type_derived := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name_type_derived)));
    avelength_company_name_type_derived := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name_type_derived)),h.company_name_type_derived<>(typeof(h.company_name_type_derived))'');
    populated_hist_duns_number_cnt := COUNT(GROUP,h.hist_duns_number <> (TYPEOF(h.hist_duns_number))'');
    populated_hist_duns_number_pcnt := AVE(GROUP,IF(h.hist_duns_number = (TYPEOF(h.hist_duns_number))'',0,100));
    maxlength_hist_duns_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hist_duns_number)));
    avelength_hist_duns_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hist_duns_number)),h.hist_duns_number<>(typeof(h.hist_duns_number))'');
    populated_active_domestic_corp_key_cnt := COUNT(GROUP,h.active_domestic_corp_key <> (TYPEOF(h.active_domestic_corp_key))'');
    populated_active_domestic_corp_key_pcnt := AVE(GROUP,IF(h.active_domestic_corp_key = (TYPEOF(h.active_domestic_corp_key))'',0,100));
    maxlength_active_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_domestic_corp_key)));
    avelength_active_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_domestic_corp_key)),h.active_domestic_corp_key<>(typeof(h.active_domestic_corp_key))'');
    populated_hist_domestic_corp_key_cnt := COUNT(GROUP,h.hist_domestic_corp_key <> (TYPEOF(h.hist_domestic_corp_key))'');
    populated_hist_domestic_corp_key_pcnt := AVE(GROUP,IF(h.hist_domestic_corp_key = (TYPEOF(h.hist_domestic_corp_key))'',0,100));
    maxlength_hist_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hist_domestic_corp_key)));
    avelength_hist_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hist_domestic_corp_key)),h.hist_domestic_corp_key<>(typeof(h.hist_domestic_corp_key))'');
    populated_foreign_corp_key_cnt := COUNT(GROUP,h.foreign_corp_key <> (TYPEOF(h.foreign_corp_key))'');
    populated_foreign_corp_key_pcnt := AVE(GROUP,IF(h.foreign_corp_key = (TYPEOF(h.foreign_corp_key))'',0,100));
    maxlength_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.foreign_corp_key)));
    avelength_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.foreign_corp_key)),h.foreign_corp_key<>(typeof(h.foreign_corp_key))'');
    populated_unk_corp_key_cnt := COUNT(GROUP,h.unk_corp_key <> (TYPEOF(h.unk_corp_key))'');
    populated_unk_corp_key_pcnt := AVE(GROUP,IF(h.unk_corp_key = (TYPEOF(h.unk_corp_key))'',0,100));
    maxlength_unk_corp_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unk_corp_key)));
    avelength_unk_corp_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unk_corp_key)),h.unk_corp_key<>(typeof(h.unk_corp_key))'');
    populated_cnp_name_cnt := COUNT(GROUP,h.cnp_name <> (TYPEOF(h.cnp_name))'');
    populated_cnp_name_pcnt := AVE(GROUP,IF(h.cnp_name = (TYPEOF(h.cnp_name))'',0,100));
    maxlength_cnp_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_name)));
    avelength_cnp_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_name)),h.cnp_name<>(typeof(h.cnp_name))'');
    populated_cnp_hasNumber_cnt := COUNT(GROUP,h.cnp_hasNumber <> (TYPEOF(h.cnp_hasNumber))'');
    populated_cnp_hasNumber_pcnt := AVE(GROUP,IF(h.cnp_hasNumber = (TYPEOF(h.cnp_hasNumber))'',0,100));
    maxlength_cnp_hasNumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_hasNumber)));
    avelength_cnp_hasNumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_hasNumber)),h.cnp_hasNumber<>(typeof(h.cnp_hasNumber))'');
    populated_cnp_lowv_cnt := COUNT(GROUP,h.cnp_lowv <> (TYPEOF(h.cnp_lowv))'');
    populated_cnp_lowv_pcnt := AVE(GROUP,IF(h.cnp_lowv = (TYPEOF(h.cnp_lowv))'',0,100));
    maxlength_cnp_lowv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_lowv)));
    avelength_cnp_lowv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_lowv)),h.cnp_lowv<>(typeof(h.cnp_lowv))'');
    populated_cnp_translated_cnt := COUNT(GROUP,h.cnp_translated <> (TYPEOF(h.cnp_translated))'');
    populated_cnp_translated_pcnt := AVE(GROUP,IF(h.cnp_translated = (TYPEOF(h.cnp_translated))'',0,100));
    maxlength_cnp_translated := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_translated)));
    avelength_cnp_translated := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_translated)),h.cnp_translated<>(typeof(h.cnp_translated))'');
    populated_cnp_classid_cnt := COUNT(GROUP,h.cnp_classid <> (TYPEOF(h.cnp_classid))'');
    populated_cnp_classid_pcnt := AVE(GROUP,IF(h.cnp_classid = (TYPEOF(h.cnp_classid))'',0,100));
    maxlength_cnp_classid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_classid)));
    avelength_cnp_classid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnp_classid)),h.cnp_classid<>(typeof(h.cnp_classid))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
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
    populated_has_lgid_cnt := COUNT(GROUP,h.has_lgid <> (TYPEOF(h.has_lgid))'');
    populated_has_lgid_pcnt := AVE(GROUP,IF(h.has_lgid = (TYPEOF(h.has_lgid))'',0,100));
    maxlength_has_lgid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.has_lgid)));
    avelength_has_lgid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.has_lgid)),h.has_lgid<>(typeof(h.has_lgid))'');
    populated_is_sele_level_cnt := COUNT(GROUP,h.is_sele_level <> (TYPEOF(h.is_sele_level))'');
    populated_is_sele_level_pcnt := AVE(GROUP,IF(h.is_sele_level = (TYPEOF(h.is_sele_level))'',0,100));
    maxlength_is_sele_level := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_sele_level)));
    avelength_is_sele_level := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_sele_level)),h.is_sele_level<>(typeof(h.is_sele_level))'');
    populated_is_org_level_cnt := COUNT(GROUP,h.is_org_level <> (TYPEOF(h.is_org_level))'');
    populated_is_org_level_pcnt := AVE(GROUP,IF(h.is_org_level = (TYPEOF(h.is_org_level))'',0,100));
    maxlength_is_org_level := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_org_level)));
    avelength_is_org_level := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_org_level)),h.is_org_level<>(typeof(h.is_org_level))'');
    populated_is_ult_level_cnt := COUNT(GROUP,h.is_ult_level <> (TYPEOF(h.is_ult_level))'');
    populated_is_ult_level_pcnt := AVE(GROUP,IF(h.is_ult_level = (TYPEOF(h.is_ult_level))'',0,100));
    maxlength_is_ult_level := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_ult_level)));
    avelength_is_ult_level := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_ult_level)),h.is_ult_level<>(typeof(h.is_ult_level))'');
    populated_parent_proxid_cnt := COUNT(GROUP,h.parent_proxid <> (TYPEOF(h.parent_proxid))'');
    populated_parent_proxid_pcnt := AVE(GROUP,IF(h.parent_proxid = (TYPEOF(h.parent_proxid))'',0,100));
    maxlength_parent_proxid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.parent_proxid)));
    avelength_parent_proxid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.parent_proxid)),h.parent_proxid<>(typeof(h.parent_proxid))'');
    populated_sele_proxid_cnt := COUNT(GROUP,h.sele_proxid <> (TYPEOF(h.sele_proxid))'');
    populated_sele_proxid_pcnt := AVE(GROUP,IF(h.sele_proxid = (TYPEOF(h.sele_proxid))'',0,100));
    maxlength_sele_proxid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sele_proxid)));
    avelength_sele_proxid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sele_proxid)),h.sele_proxid<>(typeof(h.sele_proxid))'');
    populated_org_proxid_cnt := COUNT(GROUP,h.org_proxid <> (TYPEOF(h.org_proxid))'');
    populated_org_proxid_pcnt := AVE(GROUP,IF(h.org_proxid = (TYPEOF(h.org_proxid))'',0,100));
    maxlength_org_proxid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.org_proxid)));
    avelength_org_proxid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.org_proxid)),h.org_proxid<>(typeof(h.org_proxid))'');
    populated_ultimate_proxid_cnt := COUNT(GROUP,h.ultimate_proxid <> (TYPEOF(h.ultimate_proxid))'');
    populated_ultimate_proxid_pcnt := AVE(GROUP,IF(h.ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',0,100));
    maxlength_ultimate_proxid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultimate_proxid)));
    avelength_ultimate_proxid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultimate_proxid)),h.ultimate_proxid<>(typeof(h.ultimate_proxid))'');
    populated_levels_from_top_cnt := COUNT(GROUP,h.levels_from_top <> (TYPEOF(h.levels_from_top))'');
    populated_levels_from_top_pcnt := AVE(GROUP,IF(h.levels_from_top = (TYPEOF(h.levels_from_top))'',0,100));
    maxlength_levels_from_top := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.levels_from_top)));
    avelength_levels_from_top := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.levels_from_top)),h.levels_from_top<>(typeof(h.levels_from_top))'');
    populated_nodes_total_cnt := COUNT(GROUP,h.nodes_total <> (TYPEOF(h.nodes_total))'');
    populated_nodes_total_pcnt := AVE(GROUP,IF(h.nodes_total = (TYPEOF(h.nodes_total))'',0,100));
    maxlength_nodes_total := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nodes_total)));
    avelength_nodes_total := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nodes_total)),h.nodes_total<>(typeof(h.nodes_total))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_sbfe_id_pcnt *  27.00 / 100 + T.Populated_nodes_below_st_pcnt *   0.00 / 100 + T.Populated_Lgid3IfHrchy_pcnt *  27.00 / 100 + T.Populated_OriginalSeleId_pcnt *   0.00 / 100 + T.Populated_OriginalOrgId_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *  26.00 / 100 + T.Populated_cnp_number_pcnt *  13.00 / 100 + T.Populated_active_duns_number_pcnt *  27.00 / 100 + T.Populated_duns_number_pcnt *  27.00 / 100 + T.Populated_company_fein_pcnt *  26.00 / 100 + T.Populated_company_inc_state_pcnt *   6.00 / 100 + T.Populated_company_charter_number_pcnt *  26.00 / 100 + T.Populated_cnp_btype_pcnt *   3.00 / 100 + T.Populated_company_name_type_derived_pcnt *   0.00 / 100 + T.Populated_hist_duns_number_pcnt *   0.00 / 100 + T.Populated_active_domestic_corp_key_pcnt *   0.00 / 100 + T.Populated_hist_domestic_corp_key_pcnt *   0.00 / 100 + T.Populated_foreign_corp_key_pcnt *   0.00 / 100 + T.Populated_unk_corp_key_pcnt *   0.00 / 100 + T.Populated_cnp_name_pcnt *   0.00 / 100 + T.Populated_cnp_hasNumber_pcnt *   0.00 / 100 + T.Populated_cnp_lowv_pcnt *   0.00 / 100 + T.Populated_cnp_translated_pcnt *   0.00 / 100 + T.Populated_cnp_classid_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_has_lgid_pcnt *   0.00 / 100 + T.Populated_is_sele_level_pcnt *   0.00 / 100 + T.Populated_is_org_level_pcnt *   0.00 / 100 + T.Populated_is_ult_level_pcnt *   0.00 / 100 + T.Populated_parent_proxid_pcnt *   0.00 / 100 + T.Populated_sele_proxid_pcnt *   0.00 / 100 + T.Populated_org_proxid_pcnt *   0.00 / 100 + T.Populated_ultimate_proxid_pcnt *   0.00 / 100 + T.Populated_levels_from_top_pcnt *   0.00 / 100 + T.Populated_nodes_total_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING source1;
    STRING source2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source1 := le.Source;
    SELF.source2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_sbfe_id_pcnt*ri.Populated_sbfe_id_pcnt *  27.00 / 10000 + le.Populated_nodes_below_st_pcnt*ri.Populated_nodes_below_st_pcnt *   0.00 / 10000 + le.Populated_Lgid3IfHrchy_pcnt*ri.Populated_Lgid3IfHrchy_pcnt *  27.00 / 10000 + le.Populated_OriginalSeleId_pcnt*ri.Populated_OriginalSeleId_pcnt *   0.00 / 10000 + le.Populated_OriginalOrgId_pcnt*ri.Populated_OriginalOrgId_pcnt *   0.00 / 10000 + le.Populated_company_name_pcnt*ri.Populated_company_name_pcnt *  26.00 / 10000 + le.Populated_cnp_number_pcnt*ri.Populated_cnp_number_pcnt *  13.00 / 10000 + le.Populated_active_duns_number_pcnt*ri.Populated_active_duns_number_pcnt *  27.00 / 10000 + le.Populated_duns_number_pcnt*ri.Populated_duns_number_pcnt *  27.00 / 10000 + le.Populated_company_fein_pcnt*ri.Populated_company_fein_pcnt *  26.00 / 10000 + le.Populated_company_inc_state_pcnt*ri.Populated_company_inc_state_pcnt *   6.00 / 10000 + le.Populated_company_charter_number_pcnt*ri.Populated_company_charter_number_pcnt *  26.00 / 10000 + le.Populated_cnp_btype_pcnt*ri.Populated_cnp_btype_pcnt *   3.00 / 10000 + le.Populated_company_name_type_derived_pcnt*ri.Populated_company_name_type_derived_pcnt *   0.00 / 10000 + le.Populated_hist_duns_number_pcnt*ri.Populated_hist_duns_number_pcnt *   0.00 / 10000 + le.Populated_active_domestic_corp_key_pcnt*ri.Populated_active_domestic_corp_key_pcnt *   0.00 / 10000 + le.Populated_hist_domestic_corp_key_pcnt*ri.Populated_hist_domestic_corp_key_pcnt *   0.00 / 10000 + le.Populated_foreign_corp_key_pcnt*ri.Populated_foreign_corp_key_pcnt *   0.00 / 10000 + le.Populated_unk_corp_key_pcnt*ri.Populated_unk_corp_key_pcnt *   0.00 / 10000 + le.Populated_cnp_name_pcnt*ri.Populated_cnp_name_pcnt *   0.00 / 10000 + le.Populated_cnp_hasNumber_pcnt*ri.Populated_cnp_hasNumber_pcnt *   0.00 / 10000 + le.Populated_cnp_lowv_pcnt*ri.Populated_cnp_lowv_pcnt *   0.00 / 10000 + le.Populated_cnp_translated_pcnt*ri.Populated_cnp_translated_pcnt *   0.00 / 10000 + le.Populated_cnp_classid_pcnt*ri.Populated_cnp_classid_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *   0.00 / 10000 + le.Populated_has_lgid_pcnt*ri.Populated_has_lgid_pcnt *   0.00 / 10000 + le.Populated_is_sele_level_pcnt*ri.Populated_is_sele_level_pcnt *   0.00 / 10000 + le.Populated_is_org_level_pcnt*ri.Populated_is_org_level_pcnt *   0.00 / 10000 + le.Populated_is_ult_level_pcnt*ri.Populated_is_ult_level_pcnt *   0.00 / 10000 + le.Populated_parent_proxid_pcnt*ri.Populated_parent_proxid_pcnt *   0.00 / 10000 + le.Populated_sele_proxid_pcnt*ri.Populated_sele_proxid_pcnt *   0.00 / 10000 + le.Populated_org_proxid_pcnt*ri.Populated_org_proxid_pcnt *   0.00 / 10000 + le.Populated_ultimate_proxid_pcnt*ri.Populated_ultimate_proxid_pcnt *   0.00 / 10000 + le.Populated_levels_from_top_pcnt*ri.Populated_levels_from_top_pcnt *   0.00 / 10000 + le.Populated_nodes_total_pcnt*ri.Populated_nodes_total_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_pcnt*ri.Populated_dt_first_seen_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_pcnt*ri.Populated_dt_last_seen_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'sbfe_id','nodes_below_st','Lgid3IfHrchy','OriginalSeleId','OriginalOrgId','company_name','cnp_number','active_duns_number','duns_number','company_fein','company_inc_state','company_charter_number','cnp_btype','company_name_type_derived','hist_duns_number','active_domestic_corp_key','hist_domestic_corp_key','foreign_corp_key','unk_corp_key','cnp_name','cnp_hasNumber','cnp_lowv','cnp_translated','cnp_classid','prim_range','prim_name','sec_range','v_city_name','st','zip','has_lgid','is_sele_level','is_org_level','is_ult_level','parent_proxid','sele_proxid','org_proxid','ultimate_proxid','levels_from_top','nodes_total','dt_first_seen','dt_last_seen');
  SELF.populated_pcnt := CHOOSE(C,le.populated_sbfe_id_pcnt,le.populated_nodes_below_st_pcnt,le.populated_Lgid3IfHrchy_pcnt,le.populated_OriginalSeleId_pcnt,le.populated_OriginalOrgId_pcnt,le.populated_company_name_pcnt,le.populated_cnp_number_pcnt,le.populated_active_duns_number_pcnt,le.populated_duns_number_pcnt,le.populated_company_fein_pcnt,le.populated_company_inc_state_pcnt,le.populated_company_charter_number_pcnt,le.populated_cnp_btype_pcnt,le.populated_company_name_type_derived_pcnt,le.populated_hist_duns_number_pcnt,le.populated_active_domestic_corp_key_pcnt,le.populated_hist_domestic_corp_key_pcnt,le.populated_foreign_corp_key_pcnt,le.populated_unk_corp_key_pcnt,le.populated_cnp_name_pcnt,le.populated_cnp_hasNumber_pcnt,le.populated_cnp_lowv_pcnt,le.populated_cnp_translated_pcnt,le.populated_cnp_classid_pcnt,le.populated_prim_range_pcnt,le.populated_prim_name_pcnt,le.populated_sec_range_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_has_lgid_pcnt,le.populated_is_sele_level_pcnt,le.populated_is_org_level_pcnt,le.populated_is_ult_level_pcnt,le.populated_parent_proxid_pcnt,le.populated_sele_proxid_pcnt,le.populated_org_proxid_pcnt,le.populated_ultimate_proxid_pcnt,le.populated_levels_from_top_pcnt,le.populated_nodes_total_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_sbfe_id,le.maxlength_nodes_below_st,le.maxlength_Lgid3IfHrchy,le.maxlength_OriginalSeleId,le.maxlength_OriginalOrgId,le.maxlength_company_name,le.maxlength_cnp_number,le.maxlength_active_duns_number,le.maxlength_duns_number,le.maxlength_company_fein,le.maxlength_company_inc_state,le.maxlength_company_charter_number,le.maxlength_cnp_btype,le.maxlength_company_name_type_derived,le.maxlength_hist_duns_number,le.maxlength_active_domestic_corp_key,le.maxlength_hist_domestic_corp_key,le.maxlength_foreign_corp_key,le.maxlength_unk_corp_key,le.maxlength_cnp_name,le.maxlength_cnp_hasNumber,le.maxlength_cnp_lowv,le.maxlength_cnp_translated,le.maxlength_cnp_classid,le.maxlength_prim_range,le.maxlength_prim_name,le.maxlength_sec_range,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_has_lgid,le.maxlength_is_sele_level,le.maxlength_is_org_level,le.maxlength_is_ult_level,le.maxlength_parent_proxid,le.maxlength_sele_proxid,le.maxlength_org_proxid,le.maxlength_ultimate_proxid,le.maxlength_levels_from_top,le.maxlength_nodes_total,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen);
  SELF.avelength := CHOOSE(C,le.avelength_sbfe_id,le.avelength_nodes_below_st,le.avelength_Lgid3IfHrchy,le.avelength_OriginalSeleId,le.avelength_OriginalOrgId,le.avelength_company_name,le.avelength_cnp_number,le.avelength_active_duns_number,le.avelength_duns_number,le.avelength_company_fein,le.avelength_company_inc_state,le.avelength_company_charter_number,le.avelength_cnp_btype,le.avelength_company_name_type_derived,le.avelength_hist_duns_number,le.avelength_active_domestic_corp_key,le.avelength_hist_domestic_corp_key,le.avelength_foreign_corp_key,le.avelength_unk_corp_key,le.avelength_cnp_name,le.avelength_cnp_hasNumber,le.avelength_cnp_lowv,le.avelength_cnp_translated,le.avelength_cnp_classid,le.avelength_prim_range,le.avelength_prim_name,le.avelength_sec_range,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_has_lgid,le.avelength_is_sele_level,le.avelength_is_org_level,le.avelength_is_ult_level,le.avelength_parent_proxid,le.avelength_sele_proxid,le.avelength_org_proxid,le.avelength_ultimate_proxid,le.avelength_levels_from_top,le.avelength_nodes_total,le.avelength_dt_first_seen,le.avelength_dt_last_seen);
END;
EXPORT invSummary := NORMALIZE(summary0, 42, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.LGID3;
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.sbfe_id),TRIM((SALT311.StrType)le.nodes_below_st),TRIM((SALT311.StrType)le.Lgid3IfHrchy),TRIM((SALT311.StrType)le.OriginalSeleId),TRIM((SALT311.StrType)le.OriginalOrgId),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.cnp_number),TRIM((SALT311.StrType)le.active_duns_number),TRIM((SALT311.StrType)le.duns_number),TRIM((SALT311.StrType)le.company_fein),TRIM((SALT311.StrType)le.company_inc_state),TRIM((SALT311.StrType)le.company_charter_number),TRIM((SALT311.StrType)le.cnp_btype),TRIM((SALT311.StrType)le.company_name_type_derived),TRIM((SALT311.StrType)le.hist_duns_number),TRIM((SALT311.StrType)le.active_domestic_corp_key),TRIM((SALT311.StrType)le.hist_domestic_corp_key),TRIM((SALT311.StrType)le.foreign_corp_key),TRIM((SALT311.StrType)le.unk_corp_key),TRIM((SALT311.StrType)le.cnp_name),TRIM((SALT311.StrType)le.cnp_hasNumber),TRIM((SALT311.StrType)le.cnp_lowv),TRIM((SALT311.StrType)le.cnp_translated),TRIM((SALT311.StrType)le.cnp_classid),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.has_lgid),TRIM((SALT311.StrType)le.is_sele_level),TRIM((SALT311.StrType)le.is_org_level),TRIM((SALT311.StrType)le.is_ult_level),TRIM((SALT311.StrType)le.parent_proxid),TRIM((SALT311.StrType)le.sele_proxid),TRIM((SALT311.StrType)le.org_proxid),TRIM((SALT311.StrType)le.ultimate_proxid),TRIM((SALT311.StrType)le.levels_from_top),TRIM((SALT311.StrType)le.nodes_total),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,42,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 42);
  SELF.FldNo2 := 1 + (C % 42);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.sbfe_id),TRIM((SALT311.StrType)le.nodes_below_st),TRIM((SALT311.StrType)le.Lgid3IfHrchy),TRIM((SALT311.StrType)le.OriginalSeleId),TRIM((SALT311.StrType)le.OriginalOrgId),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.cnp_number),TRIM((SALT311.StrType)le.active_duns_number),TRIM((SALT311.StrType)le.duns_number),TRIM((SALT311.StrType)le.company_fein),TRIM((SALT311.StrType)le.company_inc_state),TRIM((SALT311.StrType)le.company_charter_number),TRIM((SALT311.StrType)le.cnp_btype),TRIM((SALT311.StrType)le.company_name_type_derived),TRIM((SALT311.StrType)le.hist_duns_number),TRIM((SALT311.StrType)le.active_domestic_corp_key),TRIM((SALT311.StrType)le.hist_domestic_corp_key),TRIM((SALT311.StrType)le.foreign_corp_key),TRIM((SALT311.StrType)le.unk_corp_key),TRIM((SALT311.StrType)le.cnp_name),TRIM((SALT311.StrType)le.cnp_hasNumber),TRIM((SALT311.StrType)le.cnp_lowv),TRIM((SALT311.StrType)le.cnp_translated),TRIM((SALT311.StrType)le.cnp_classid),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.has_lgid),TRIM((SALT311.StrType)le.is_sele_level),TRIM((SALT311.StrType)le.is_org_level),TRIM((SALT311.StrType)le.is_ult_level),TRIM((SALT311.StrType)le.parent_proxid),TRIM((SALT311.StrType)le.sele_proxid),TRIM((SALT311.StrType)le.org_proxid),TRIM((SALT311.StrType)le.ultimate_proxid),TRIM((SALT311.StrType)le.levels_from_top),TRIM((SALT311.StrType)le.nodes_total),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.sbfe_id),TRIM((SALT311.StrType)le.nodes_below_st),TRIM((SALT311.StrType)le.Lgid3IfHrchy),TRIM((SALT311.StrType)le.OriginalSeleId),TRIM((SALT311.StrType)le.OriginalOrgId),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.cnp_number),TRIM((SALT311.StrType)le.active_duns_number),TRIM((SALT311.StrType)le.duns_number),TRIM((SALT311.StrType)le.company_fein),TRIM((SALT311.StrType)le.company_inc_state),TRIM((SALT311.StrType)le.company_charter_number),TRIM((SALT311.StrType)le.cnp_btype),TRIM((SALT311.StrType)le.company_name_type_derived),TRIM((SALT311.StrType)le.hist_duns_number),TRIM((SALT311.StrType)le.active_domestic_corp_key),TRIM((SALT311.StrType)le.hist_domestic_corp_key),TRIM((SALT311.StrType)le.foreign_corp_key),TRIM((SALT311.StrType)le.unk_corp_key),TRIM((SALT311.StrType)le.cnp_name),TRIM((SALT311.StrType)le.cnp_hasNumber),TRIM((SALT311.StrType)le.cnp_lowv),TRIM((SALT311.StrType)le.cnp_translated),TRIM((SALT311.StrType)le.cnp_classid),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.has_lgid),TRIM((SALT311.StrType)le.is_sele_level),TRIM((SALT311.StrType)le.is_org_level),TRIM((SALT311.StrType)le.is_ult_level),TRIM((SALT311.StrType)le.parent_proxid),TRIM((SALT311.StrType)le.sele_proxid),TRIM((SALT311.StrType)le.org_proxid),TRIM((SALT311.StrType)le.ultimate_proxid),TRIM((SALT311.StrType)le.levels_from_top),TRIM((SALT311.StrType)le.nodes_total),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),42*42,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'sbfe_id'}
      ,{2,'nodes_below_st'}
      ,{3,'Lgid3IfHrchy'}
      ,{4,'OriginalSeleId'}
      ,{5,'OriginalOrgId'}
      ,{6,'company_name'}
      ,{7,'cnp_number'}
      ,{8,'active_duns_number'}
      ,{9,'duns_number'}
      ,{10,'company_fein'}
      ,{11,'company_inc_state'}
      ,{12,'company_charter_number'}
      ,{13,'cnp_btype'}
      ,{14,'company_name_type_derived'}
      ,{15,'hist_duns_number'}
      ,{16,'active_domestic_corp_key'}
      ,{17,'hist_domestic_corp_key'}
      ,{18,'foreign_corp_key'}
      ,{19,'unk_corp_key'}
      ,{20,'cnp_name'}
      ,{21,'cnp_hasNumber'}
      ,{22,'cnp_lowv'}
      ,{23,'cnp_translated'}
      ,{24,'cnp_classid'}
      ,{25,'prim_range'}
      ,{26,'prim_name'}
      ,{27,'sec_range'}
      ,{28,'v_city_name'}
      ,{29,'st'}
      ,{30,'zip'}
      ,{31,'has_lgid'}
      ,{32,'is_sele_level'}
      ,{33,'is_org_level'}
      ,{34,'is_ult_level'}
      ,{35,'parent_proxid'}
      ,{36,'sele_proxid'}
      ,{37,'org_proxid'}
      ,{38,'ultimate_proxid'}
      ,{39,'levels_from_top'}
      ,{40,'nodes_total'}
      ,{41,'dt_first_seen'}
      ,{42,'dt_last_seen'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source) source; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_sbfe_id((SALT311.StrType)le.sbfe_id),
    Fields.InValid_nodes_below_st((SALT311.StrType)le.nodes_below_st),
    Fields.InValid_Lgid3IfHrchy((SALT311.StrType)le.Lgid3IfHrchy),
    Fields.InValid_OriginalSeleId((SALT311.StrType)le.OriginalSeleId),
    Fields.InValid_OriginalOrgId((SALT311.StrType)le.OriginalOrgId),
    Fields.InValid_company_name((SALT311.StrType)le.company_name),
    Fields.InValid_cnp_number((SALT311.StrType)le.cnp_number),
    Fields.InValid_active_duns_number((SALT311.StrType)le.active_duns_number),
    Fields.InValid_duns_number((SALT311.StrType)le.duns_number),
    0, // Uncleanable field
    Fields.InValid_company_fein((SALT311.StrType)le.company_fein),
    Fields.InValid_company_inc_state((SALT311.StrType)le.company_inc_state),
    Fields.InValid_company_charter_number((SALT311.StrType)le.company_charter_number),
    Fields.InValid_cnp_btype((SALT311.StrType)le.cnp_btype),
    Fields.InValid_company_name_type_derived((SALT311.StrType)le.company_name_type_derived),
    Fields.InValid_hist_duns_number((SALT311.StrType)le.hist_duns_number),
    Fields.InValid_active_domestic_corp_key((SALT311.StrType)le.active_domestic_corp_key),
    Fields.InValid_hist_domestic_corp_key((SALT311.StrType)le.hist_domestic_corp_key),
    Fields.InValid_foreign_corp_key((SALT311.StrType)le.foreign_corp_key),
    Fields.InValid_unk_corp_key((SALT311.StrType)le.unk_corp_key),
    Fields.InValid_cnp_name((SALT311.StrType)le.cnp_name),
    Fields.InValid_cnp_hasNumber((SALT311.StrType)le.cnp_hasNumber),
    Fields.InValid_cnp_lowv((SALT311.StrType)le.cnp_lowv),
    Fields.InValid_cnp_translated((SALT311.StrType)le.cnp_translated),
    Fields.InValid_cnp_classid((SALT311.StrType)le.cnp_classid),
    Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    Fields.InValid_st((SALT311.StrType)le.st),
    Fields.InValid_zip((SALT311.StrType)le.zip),
    Fields.InValid_has_lgid((SALT311.StrType)le.has_lgid),
    Fields.InValid_is_sele_level((SALT311.StrType)le.is_sele_level),
    Fields.InValid_is_org_level((SALT311.StrType)le.is_org_level),
    Fields.InValid_is_ult_level((SALT311.StrType)le.is_ult_level),
    Fields.InValid_parent_proxid((SALT311.StrType)le.parent_proxid),
    Fields.InValid_sele_proxid((SALT311.StrType)le.sele_proxid),
    Fields.InValid_org_proxid((SALT311.StrType)le.org_proxid),
    Fields.InValid_ultimate_proxid((SALT311.StrType)le.ultimate_proxid),
    Fields.InValid_levels_from_top((SALT311.StrType)le.levels_from_top),
    Fields.InValid_nodes_total((SALT311.StrType)le.nodes_total),
    Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source := le.source;
END;
Errors := NORMALIZE(h,43,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','not_hrchy_parent','Unknown','Unknown','Unknown','Noblanks','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_sbfe_id(TotalErrors.ErrorNum),Fields.InValidMessage_nodes_below_st(TotalErrors.ErrorNum),Fields.InValidMessage_Lgid3IfHrchy(TotalErrors.ErrorNum),Fields.InValidMessage_OriginalSeleId(TotalErrors.ErrorNum),Fields.InValidMessage_OriginalOrgId(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_duns_number(TotalErrors.ErrorNum),'',Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Fields.InValidMessage_company_inc_state(TotalErrors.ErrorNum),Fields.InValidMessage_company_charter_number(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_btype(TotalErrors.ErrorNum),Fields.InValidMessage_company_name_type_derived(TotalErrors.ErrorNum),Fields.InValidMessage_hist_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_hist_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_unk_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_name(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_hasNumber(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_lowv(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_translated(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_classid(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_has_lgid(TotalErrors.ErrorNum),Fields.InValidMessage_is_sele_level(TotalErrors.ErrorNum),Fields.InValidMessage_is_org_level(TotalErrors.ErrorNum),Fields.InValidMessage_is_ult_level(TotalErrors.ErrorNum),Fields.InValidMessage_parent_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_sele_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_org_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_ultimate_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_levels_from_top(TotalErrors.ErrorNum),Fields.InValidMessage_nodes_total(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//Compute field consistencies between sources
  SALT311.Mac_SrcFrequency_Outliers(h,company_inc_state,source,company_inc_state_Unusually_Frequent_outliers, company_inc_state_Unique_outliers, company_inc_state_Unique_outlier_sources, company_inc_state_Distinct_outliers,company_inc_state_Distinct_outlier_sources, company_inc_state_Top5_outliers, company_inc_state_Top5_outlier_sources)
  SALT311.Mac_SrcFrequency_Outliers(h,company_charter_number,source,company_charter_number_Unusually_Frequent_outliers, company_charter_number_Unique_outliers, company_charter_number_Unique_outlier_sources, company_charter_number_Distinct_outliers,company_charter_number_Distinct_outlier_sources, company_charter_number_Top5_outliers, company_charter_number_Top5_outlier_sources)
  SALT311.Mac_SrcFrequency_Outliers(h,company_name,source,company_name_Unusually_Frequent_outliers, company_name_Unique_outliers, company_name_Unique_outlier_sources, company_name_Distinct_outliers,company_name_Distinct_outlier_sources, company_name_Top5_outliers, company_name_Top5_outlier_sources)
  SALT311.Mac_SrcFrequency_Outliers(h,cnp_btype,source,cnp_btype_Unusually_Frequent_outliers, cnp_btype_Unique_outliers, cnp_btype_Unique_outlier_sources, cnp_btype_Distinct_outliers,cnp_btype_Distinct_outlier_sources, cnp_btype_Top5_outliers, cnp_btype_Top5_outlier_sources)
  SALT311.Mac_SrcFrequency_Outliers(h,company_fein,source,company_fein_Unusually_Frequent_outliers, company_fein_Unique_outliers, company_fein_Unique_outlier_sources, company_fein_Distinct_outliers,company_fein_Distinct_outlier_sources, company_fein_Top5_outliers, company_fein_Top5_outlier_sources)
EXPORT AllUnusuallyFrequentOutliers := company_inc_state_Unusually_Frequent_outliers + company_charter_number_Unusually_Frequent_outliers + company_name_Unusually_Frequent_outliers + cnp_btype_Unusually_Frequent_outliers + company_fein_Unusually_Frequent_outliers;
EXPORT AllUniqueOutliers := company_inc_state_Unique_outliers + company_charter_number_Unique_outliers + company_name_Unique_outliers + cnp_btype_Unique_outliers + company_fein_Unique_outliers;
EXPORT AllDistinctOutliers := company_inc_state_Distinct_outliers + company_charter_number_Distinct_outliers + company_name_Distinct_outliers + cnp_btype_Distinct_outliers + company_fein_Distinct_outliers;
EXPORT AllTop5Outliers := company_inc_state_Top5_outliers + company_charter_number_Top5_outliers + company_name_Top5_outliers + cnp_btype_Top5_outliers + company_fein_Top5_outliers;
EXPORT AllUniqueOutlierSources := company_inc_state_Unique_outlier_sources + company_charter_number_Unique_outlier_sources + company_name_Unique_outlier_sources + cnp_btype_Unique_outlier_sources + company_fein_Unique_outlier_sources;
EXPORT AllDistinctOutlierSources := company_inc_state_Distinct_outlier_sources + company_charter_number_Distinct_outlier_sources + company_name_Distinct_outlier_sources + cnp_btype_Distinct_outlier_sources + company_fein_Distinct_outlier_sources;
EXPORT AllTop5OutlierSources := company_inc_state_Top5_outlier_sources + company_charter_number_Top5_outlier_sources + company_name_Top5_outlier_sources + cnp_btype_Top5_outlier_sources + company_fein_Top5_outlier_sources;
//We have LGID3 specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT311.MOD_ClusterStats.Counts(h,LGID3);
EXPORT ClusterSrc := SALT311.MOD_ClusterStats.Sources(h,LGID3,source);
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(BIPV2_LGID3, Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;

IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_Base) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.source))'', MAX(GROUP,h.source));
    NumberOfRecords := COUNT(GROUP);
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
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
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_global_sid_cnt := COUNT(GROUP,h.global_sid <> (TYPEOF(h.global_sid))'');
    populated_global_sid_pcnt := AVE(GROUP,IF(h.global_sid = (TYPEOF(h.global_sid))'',0,100));
    maxlength_global_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)));
    avelength_global_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)),h.global_sid<>(typeof(h.global_sid))'');
    populated_dbusa_business_id_cnt := COUNT(GROUP,h.dbusa_business_id <> (TYPEOF(h.dbusa_business_id))'');
    populated_dbusa_business_id_pcnt := AVE(GROUP,IF(h.dbusa_business_id = (TYPEOF(h.dbusa_business_id))'',0,100));
    maxlength_dbusa_business_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbusa_business_id)));
    avelength_dbusa_business_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbusa_business_id)),h.dbusa_business_id<>(typeof(h.dbusa_business_id))'');
    populated_dbusa_executive_id_cnt := COUNT(GROUP,h.dbusa_executive_id <> (TYPEOF(h.dbusa_executive_id))'');
    populated_dbusa_executive_id_pcnt := AVE(GROUP,IF(h.dbusa_executive_id = (TYPEOF(h.dbusa_executive_id))'',0,100));
    maxlength_dbusa_executive_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbusa_executive_id)));
    avelength_dbusa_executive_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbusa_executive_id)),h.dbusa_executive_id<>(typeof(h.dbusa_executive_id))'');
    populated_subhq_parent_id_cnt := COUNT(GROUP,h.subhq_parent_id <> (TYPEOF(h.subhq_parent_id))'');
    populated_subhq_parent_id_pcnt := AVE(GROUP,IF(h.subhq_parent_id = (TYPEOF(h.subhq_parent_id))'',0,100));
    maxlength_subhq_parent_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subhq_parent_id)));
    avelength_subhq_parent_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subhq_parent_id)),h.subhq_parent_id<>(typeof(h.subhq_parent_id))'');
    populated_hq_id_cnt := COUNT(GROUP,h.hq_id <> (TYPEOF(h.hq_id))'');
    populated_hq_id_pcnt := AVE(GROUP,IF(h.hq_id = (TYPEOF(h.hq_id))'',0,100));
    maxlength_hq_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hq_id)));
    avelength_hq_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hq_id)),h.hq_id<>(typeof(h.hq_id))'');
    populated_ind_frm_indicator_cnt := COUNT(GROUP,h.ind_frm_indicator <> (TYPEOF(h.ind_frm_indicator))'');
    populated_ind_frm_indicator_pcnt := AVE(GROUP,IF(h.ind_frm_indicator = (TYPEOF(h.ind_frm_indicator))'',0,100));
    maxlength_ind_frm_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ind_frm_indicator)));
    avelength_ind_frm_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ind_frm_indicator)),h.ind_frm_indicator<>(typeof(h.ind_frm_indicator))'');
    populated_company_name_cnt := COUNT(GROUP,h.company_name <> (TYPEOF(h.company_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_full_name_cnt := COUNT(GROUP,h.full_name <> (TYPEOF(h.full_name))'');
    populated_full_name_pcnt := AVE(GROUP,IF(h.full_name = (TYPEOF(h.full_name))'',0,100));
    maxlength_full_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.full_name)));
    avelength_full_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.full_name)),h.full_name<>(typeof(h.full_name))'');
    populated_prefix_cnt := COUNT(GROUP,h.prefix <> (TYPEOF(h.prefix))'');
    populated_prefix_pcnt := AVE(GROUP,IF(h.prefix = (TYPEOF(h.prefix))'',0,100));
    maxlength_prefix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prefix)));
    avelength_prefix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prefix)),h.prefix<>(typeof(h.prefix))'');
    populated_first_name_cnt := COUNT(GROUP,h.first_name <> (TYPEOF(h.first_name))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_initial_cnt := COUNT(GROUP,h.middle_initial <> (TYPEOF(h.middle_initial))'');
    populated_middle_initial_pcnt := AVE(GROUP,IF(h.middle_initial = (TYPEOF(h.middle_initial))'',0,100));
    maxlength_middle_initial := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.middle_initial)));
    avelength_middle_initial := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.middle_initial)),h.middle_initial<>(typeof(h.middle_initial))'');
    populated_last_name_cnt := COUNT(GROUP,h.last_name <> (TYPEOF(h.last_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_standardized_title_cnt := COUNT(GROUP,h.standardized_title <> (TYPEOF(h.standardized_title))'');
    populated_standardized_title_pcnt := AVE(GROUP,IF(h.standardized_title = (TYPEOF(h.standardized_title))'',0,100));
    maxlength_standardized_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.standardized_title)));
    avelength_standardized_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.standardized_title)),h.standardized_title<>(typeof(h.standardized_title))'');
    populated_sourcetitle_cnt := COUNT(GROUP,h.sourcetitle <> (TYPEOF(h.sourcetitle))'');
    populated_sourcetitle_pcnt := AVE(GROUP,IF(h.sourcetitle = (TYPEOF(h.sourcetitle))'',0,100));
    maxlength_sourcetitle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourcetitle)));
    avelength_sourcetitle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourcetitle)),h.sourcetitle<>(typeof(h.sourcetitle))'');
    populated_executive_title_rank_cnt := COUNT(GROUP,h.executive_title_rank <> (TYPEOF(h.executive_title_rank))'');
    populated_executive_title_rank_pcnt := AVE(GROUP,IF(h.executive_title_rank = (TYPEOF(h.executive_title_rank))'',0,100));
    maxlength_executive_title_rank := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_title_rank)));
    avelength_executive_title_rank := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_title_rank)),h.executive_title_rank<>(typeof(h.executive_title_rank))'');
    populated_primary_exec_flag_cnt := COUNT(GROUP,h.primary_exec_flag <> (TYPEOF(h.primary_exec_flag))'');
    populated_primary_exec_flag_pcnt := AVE(GROUP,IF(h.primary_exec_flag = (TYPEOF(h.primary_exec_flag))'',0,100));
    maxlength_primary_exec_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_exec_flag)));
    avelength_primary_exec_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_exec_flag)),h.primary_exec_flag<>(typeof(h.primary_exec_flag))'');
    populated_exec_type_cnt := COUNT(GROUP,h.exec_type <> (TYPEOF(h.exec_type))'');
    populated_exec_type_pcnt := AVE(GROUP,IF(h.exec_type = (TYPEOF(h.exec_type))'',0,100));
    maxlength_exec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.exec_type)));
    avelength_exec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.exec_type)),h.exec_type<>(typeof(h.exec_type))'');
    populated_executive_department_cnt := COUNT(GROUP,h.executive_department <> (TYPEOF(h.executive_department))'');
    populated_executive_department_pcnt := AVE(GROUP,IF(h.executive_department = (TYPEOF(h.executive_department))'',0,100));
    maxlength_executive_department := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_department)));
    avelength_executive_department := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_department)),h.executive_department<>(typeof(h.executive_department))'');
    populated_executive_level_cnt := COUNT(GROUP,h.executive_level <> (TYPEOF(h.executive_level))'');
    populated_executive_level_pcnt := AVE(GROUP,IF(h.executive_level = (TYPEOF(h.executive_level))'',0,100));
    maxlength_executive_level := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_level)));
    avelength_executive_level := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_level)),h.executive_level<>(typeof(h.executive_level))'');
    populated_phy_addr_standardized_cnt := COUNT(GROUP,h.phy_addr_standardized <> (TYPEOF(h.phy_addr_standardized))'');
    populated_phy_addr_standardized_pcnt := AVE(GROUP,IF(h.phy_addr_standardized = (TYPEOF(h.phy_addr_standardized))'',0,100));
    maxlength_phy_addr_standardized := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_standardized)));
    avelength_phy_addr_standardized := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_standardized)),h.phy_addr_standardized<>(typeof(h.phy_addr_standardized))'');
    populated_phy_addr_city_cnt := COUNT(GROUP,h.phy_addr_city <> (TYPEOF(h.phy_addr_city))'');
    populated_phy_addr_city_pcnt := AVE(GROUP,IF(h.phy_addr_city = (TYPEOF(h.phy_addr_city))'',0,100));
    maxlength_phy_addr_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_city)));
    avelength_phy_addr_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_city)),h.phy_addr_city<>(typeof(h.phy_addr_city))'');
    populated_phy_addr_state_cnt := COUNT(GROUP,h.phy_addr_state <> (TYPEOF(h.phy_addr_state))'');
    populated_phy_addr_state_pcnt := AVE(GROUP,IF(h.phy_addr_state = (TYPEOF(h.phy_addr_state))'',0,100));
    maxlength_phy_addr_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_state)));
    avelength_phy_addr_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_state)),h.phy_addr_state<>(typeof(h.phy_addr_state))'');
    populated_phy_addr_zip_cnt := COUNT(GROUP,h.phy_addr_zip <> (TYPEOF(h.phy_addr_zip))'');
    populated_phy_addr_zip_pcnt := AVE(GROUP,IF(h.phy_addr_zip = (TYPEOF(h.phy_addr_zip))'',0,100));
    maxlength_phy_addr_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_zip)));
    avelength_phy_addr_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_zip)),h.phy_addr_zip<>(typeof(h.phy_addr_zip))'');
    populated_phy_addr_zip4_cnt := COUNT(GROUP,h.phy_addr_zip4 <> (TYPEOF(h.phy_addr_zip4))'');
    populated_phy_addr_zip4_pcnt := AVE(GROUP,IF(h.phy_addr_zip4 = (TYPEOF(h.phy_addr_zip4))'',0,100));
    maxlength_phy_addr_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_zip4)));
    avelength_phy_addr_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_zip4)),h.phy_addr_zip4<>(typeof(h.phy_addr_zip4))'');
    populated_phy_addr_carrierroute_cnt := COUNT(GROUP,h.phy_addr_carrierroute <> (TYPEOF(h.phy_addr_carrierroute))'');
    populated_phy_addr_carrierroute_pcnt := AVE(GROUP,IF(h.phy_addr_carrierroute = (TYPEOF(h.phy_addr_carrierroute))'',0,100));
    maxlength_phy_addr_carrierroute := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_carrierroute)));
    avelength_phy_addr_carrierroute := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_carrierroute)),h.phy_addr_carrierroute<>(typeof(h.phy_addr_carrierroute))'');
    populated_phy_addr_deliverypt_cnt := COUNT(GROUP,h.phy_addr_deliverypt <> (TYPEOF(h.phy_addr_deliverypt))'');
    populated_phy_addr_deliverypt_pcnt := AVE(GROUP,IF(h.phy_addr_deliverypt = (TYPEOF(h.phy_addr_deliverypt))'',0,100));
    maxlength_phy_addr_deliverypt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_deliverypt)));
    avelength_phy_addr_deliverypt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_deliverypt)),h.phy_addr_deliverypt<>(typeof(h.phy_addr_deliverypt))'');
    populated_phy_addr_deliveryptchkdig_cnt := COUNT(GROUP,h.phy_addr_deliveryptchkdig <> (TYPEOF(h.phy_addr_deliveryptchkdig))'');
    populated_phy_addr_deliveryptchkdig_pcnt := AVE(GROUP,IF(h.phy_addr_deliveryptchkdig = (TYPEOF(h.phy_addr_deliveryptchkdig))'',0,100));
    maxlength_phy_addr_deliveryptchkdig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_deliveryptchkdig)));
    avelength_phy_addr_deliveryptchkdig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phy_addr_deliveryptchkdig)),h.phy_addr_deliveryptchkdig<>(typeof(h.phy_addr_deliveryptchkdig))'');
    populated_mail_addr_standardized_cnt := COUNT(GROUP,h.mail_addr_standardized <> (TYPEOF(h.mail_addr_standardized))'');
    populated_mail_addr_standardized_pcnt := AVE(GROUP,IF(h.mail_addr_standardized = (TYPEOF(h.mail_addr_standardized))'',0,100));
    maxlength_mail_addr_standardized := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_standardized)));
    avelength_mail_addr_standardized := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_standardized)),h.mail_addr_standardized<>(typeof(h.mail_addr_standardized))'');
    populated_mail_addr_city_cnt := COUNT(GROUP,h.mail_addr_city <> (TYPEOF(h.mail_addr_city))'');
    populated_mail_addr_city_pcnt := AVE(GROUP,IF(h.mail_addr_city = (TYPEOF(h.mail_addr_city))'',0,100));
    maxlength_mail_addr_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_city)));
    avelength_mail_addr_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_city)),h.mail_addr_city<>(typeof(h.mail_addr_city))'');
    populated_mail_addr_state_cnt := COUNT(GROUP,h.mail_addr_state <> (TYPEOF(h.mail_addr_state))'');
    populated_mail_addr_state_pcnt := AVE(GROUP,IF(h.mail_addr_state = (TYPEOF(h.mail_addr_state))'',0,100));
    maxlength_mail_addr_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_state)));
    avelength_mail_addr_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_state)),h.mail_addr_state<>(typeof(h.mail_addr_state))'');
    populated_mail_addr_zip_cnt := COUNT(GROUP,h.mail_addr_zip <> (TYPEOF(h.mail_addr_zip))'');
    populated_mail_addr_zip_pcnt := AVE(GROUP,IF(h.mail_addr_zip = (TYPEOF(h.mail_addr_zip))'',0,100));
    maxlength_mail_addr_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_zip)));
    avelength_mail_addr_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_zip)),h.mail_addr_zip<>(typeof(h.mail_addr_zip))'');
    populated_mail_addr_zip4_cnt := COUNT(GROUP,h.mail_addr_zip4 <> (TYPEOF(h.mail_addr_zip4))'');
    populated_mail_addr_zip4_pcnt := AVE(GROUP,IF(h.mail_addr_zip4 = (TYPEOF(h.mail_addr_zip4))'',0,100));
    maxlength_mail_addr_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_zip4)));
    avelength_mail_addr_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_zip4)),h.mail_addr_zip4<>(typeof(h.mail_addr_zip4))'');
    populated_mail_addr_carrierroute_cnt := COUNT(GROUP,h.mail_addr_carrierroute <> (TYPEOF(h.mail_addr_carrierroute))'');
    populated_mail_addr_carrierroute_pcnt := AVE(GROUP,IF(h.mail_addr_carrierroute = (TYPEOF(h.mail_addr_carrierroute))'',0,100));
    maxlength_mail_addr_carrierroute := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_carrierroute)));
    avelength_mail_addr_carrierroute := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_carrierroute)),h.mail_addr_carrierroute<>(typeof(h.mail_addr_carrierroute))'');
    populated_mail_addr_deliverypt_cnt := COUNT(GROUP,h.mail_addr_deliverypt <> (TYPEOF(h.mail_addr_deliverypt))'');
    populated_mail_addr_deliverypt_pcnt := AVE(GROUP,IF(h.mail_addr_deliverypt = (TYPEOF(h.mail_addr_deliverypt))'',0,100));
    maxlength_mail_addr_deliverypt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_deliverypt)));
    avelength_mail_addr_deliverypt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_deliverypt)),h.mail_addr_deliverypt<>(typeof(h.mail_addr_deliverypt))'');
    populated_mail_addr_deliveryptchkdig_cnt := COUNT(GROUP,h.mail_addr_deliveryptchkdig <> (TYPEOF(h.mail_addr_deliveryptchkdig))'');
    populated_mail_addr_deliveryptchkdig_pcnt := AVE(GROUP,IF(h.mail_addr_deliveryptchkdig = (TYPEOF(h.mail_addr_deliveryptchkdig))'',0,100));
    maxlength_mail_addr_deliveryptchkdig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_deliveryptchkdig)));
    avelength_mail_addr_deliveryptchkdig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_deliveryptchkdig)),h.mail_addr_deliveryptchkdig<>(typeof(h.mail_addr_deliveryptchkdig))'');
    populated_mail_score_cnt := COUNT(GROUP,h.mail_score <> (TYPEOF(h.mail_score))'');
    populated_mail_score_pcnt := AVE(GROUP,IF(h.mail_score = (TYPEOF(h.mail_score))'',0,100));
    maxlength_mail_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_score)));
    avelength_mail_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_score)),h.mail_score<>(typeof(h.mail_score))'');
    populated_mail_score_desc_cnt := COUNT(GROUP,h.mail_score_desc <> (TYPEOF(h.mail_score_desc))'');
    populated_mail_score_desc_pcnt := AVE(GROUP,IF(h.mail_score_desc = (TYPEOF(h.mail_score_desc))'',0,100));
    maxlength_mail_score_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_score_desc)));
    avelength_mail_score_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_score_desc)),h.mail_score_desc<>(typeof(h.mail_score_desc))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_area_code_cnt := COUNT(GROUP,h.area_code <> (TYPEOF(h.area_code))'');
    populated_area_code_pcnt := AVE(GROUP,IF(h.area_code = (TYPEOF(h.area_code))'',0,100));
    maxlength_area_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.area_code)));
    avelength_area_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.area_code)),h.area_code<>(typeof(h.area_code))'');
    populated_fax_cnt := COUNT(GROUP,h.fax <> (TYPEOF(h.fax))'');
    populated_fax_pcnt := AVE(GROUP,IF(h.fax = (TYPEOF(h.fax))'',0,100));
    maxlength_fax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fax)));
    avelength_fax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fax)),h.fax<>(typeof(h.fax))'');
    populated_email_cnt := COUNT(GROUP,h.email <> (TYPEOF(h.email))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_email_available_indicator_cnt := COUNT(GROUP,h.email_available_indicator <> (TYPEOF(h.email_available_indicator))'');
    populated_email_available_indicator_pcnt := AVE(GROUP,IF(h.email_available_indicator = (TYPEOF(h.email_available_indicator))'',0,100));
    maxlength_email_available_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_available_indicator)));
    avelength_email_available_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_available_indicator)),h.email_available_indicator<>(typeof(h.email_available_indicator))'');
    populated_url_cnt := COUNT(GROUP,h.url <> (TYPEOF(h.url))'');
    populated_url_pcnt := AVE(GROUP,IF(h.url = (TYPEOF(h.url))'',0,100));
    maxlength_url := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.url)));
    avelength_url := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.url)),h.url<>(typeof(h.url))'');
    populated_url_facebook_cnt := COUNT(GROUP,h.url_facebook <> (TYPEOF(h.url_facebook))'');
    populated_url_facebook_pcnt := AVE(GROUP,IF(h.url_facebook = (TYPEOF(h.url_facebook))'',0,100));
    maxlength_url_facebook := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.url_facebook)));
    avelength_url_facebook := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.url_facebook)),h.url_facebook<>(typeof(h.url_facebook))'');
    populated_url_googleplus_cnt := COUNT(GROUP,h.url_googleplus <> (TYPEOF(h.url_googleplus))'');
    populated_url_googleplus_pcnt := AVE(GROUP,IF(h.url_googleplus = (TYPEOF(h.url_googleplus))'',0,100));
    maxlength_url_googleplus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.url_googleplus)));
    avelength_url_googleplus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.url_googleplus)),h.url_googleplus<>(typeof(h.url_googleplus))'');
    populated_url_instagram_cnt := COUNT(GROUP,h.url_instagram <> (TYPEOF(h.url_instagram))'');
    populated_url_instagram_pcnt := AVE(GROUP,IF(h.url_instagram = (TYPEOF(h.url_instagram))'',0,100));
    maxlength_url_instagram := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.url_instagram)));
    avelength_url_instagram := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.url_instagram)),h.url_instagram<>(typeof(h.url_instagram))'');
    populated_url_linkedin_cnt := COUNT(GROUP,h.url_linkedin <> (TYPEOF(h.url_linkedin))'');
    populated_url_linkedin_pcnt := AVE(GROUP,IF(h.url_linkedin = (TYPEOF(h.url_linkedin))'',0,100));
    maxlength_url_linkedin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.url_linkedin)));
    avelength_url_linkedin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.url_linkedin)),h.url_linkedin<>(typeof(h.url_linkedin))'');
    populated_url_twitter_cnt := COUNT(GROUP,h.url_twitter <> (TYPEOF(h.url_twitter))'');
    populated_url_twitter_pcnt := AVE(GROUP,IF(h.url_twitter = (TYPEOF(h.url_twitter))'',0,100));
    maxlength_url_twitter := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.url_twitter)));
    avelength_url_twitter := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.url_twitter)),h.url_twitter<>(typeof(h.url_twitter))'');
    populated_url_youtube_cnt := COUNT(GROUP,h.url_youtube <> (TYPEOF(h.url_youtube))'');
    populated_url_youtube_pcnt := AVE(GROUP,IF(h.url_youtube = (TYPEOF(h.url_youtube))'',0,100));
    maxlength_url_youtube := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.url_youtube)));
    avelength_url_youtube := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.url_youtube)),h.url_youtube<>(typeof(h.url_youtube))'');
    populated_business_status_code_cnt := COUNT(GROUP,h.business_status_code <> (TYPEOF(h.business_status_code))'');
    populated_business_status_code_pcnt := AVE(GROUP,IF(h.business_status_code = (TYPEOF(h.business_status_code))'',0,100));
    maxlength_business_status_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_status_code)));
    avelength_business_status_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_status_code)),h.business_status_code<>(typeof(h.business_status_code))'');
    populated_business_status_desc_cnt := COUNT(GROUP,h.business_status_desc <> (TYPEOF(h.business_status_desc))'');
    populated_business_status_desc_pcnt := AVE(GROUP,IF(h.business_status_desc = (TYPEOF(h.business_status_desc))'',0,100));
    maxlength_business_status_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_status_desc)));
    avelength_business_status_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_status_desc)),h.business_status_desc<>(typeof(h.business_status_desc))'');
    populated_franchise_flag_cnt := COUNT(GROUP,h.franchise_flag <> (TYPEOF(h.franchise_flag))'');
    populated_franchise_flag_pcnt := AVE(GROUP,IF(h.franchise_flag = (TYPEOF(h.franchise_flag))'',0,100));
    maxlength_franchise_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.franchise_flag)));
    avelength_franchise_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.franchise_flag)),h.franchise_flag<>(typeof(h.franchise_flag))'');
    populated_franchise_type_cnt := COUNT(GROUP,h.franchise_type <> (TYPEOF(h.franchise_type))'');
    populated_franchise_type_pcnt := AVE(GROUP,IF(h.franchise_type = (TYPEOF(h.franchise_type))'',0,100));
    maxlength_franchise_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.franchise_type)));
    avelength_franchise_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.franchise_type)),h.franchise_type<>(typeof(h.franchise_type))'');
    populated_franchise_desc_cnt := COUNT(GROUP,h.franchise_desc <> (TYPEOF(h.franchise_desc))'');
    populated_franchise_desc_pcnt := AVE(GROUP,IF(h.franchise_desc = (TYPEOF(h.franchise_desc))'',0,100));
    maxlength_franchise_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.franchise_desc)));
    avelength_franchise_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.franchise_desc)),h.franchise_desc<>(typeof(h.franchise_desc))'');
    populated_ticker_symbol_cnt := COUNT(GROUP,h.ticker_symbol <> (TYPEOF(h.ticker_symbol))'');
    populated_ticker_symbol_pcnt := AVE(GROUP,IF(h.ticker_symbol = (TYPEOF(h.ticker_symbol))'',0,100));
    maxlength_ticker_symbol := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ticker_symbol)));
    avelength_ticker_symbol := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ticker_symbol)),h.ticker_symbol<>(typeof(h.ticker_symbol))'');
    populated_stock_exchange_cnt := COUNT(GROUP,h.stock_exchange <> (TYPEOF(h.stock_exchange))'');
    populated_stock_exchange_pcnt := AVE(GROUP,IF(h.stock_exchange = (TYPEOF(h.stock_exchange))'',0,100));
    maxlength_stock_exchange := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stock_exchange)));
    avelength_stock_exchange := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stock_exchange)),h.stock_exchange<>(typeof(h.stock_exchange))'');
    populated_fortune_1000_flag_cnt := COUNT(GROUP,h.fortune_1000_flag <> (TYPEOF(h.fortune_1000_flag))'');
    populated_fortune_1000_flag_pcnt := AVE(GROUP,IF(h.fortune_1000_flag = (TYPEOF(h.fortune_1000_flag))'',0,100));
    maxlength_fortune_1000_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fortune_1000_flag)));
    avelength_fortune_1000_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fortune_1000_flag)),h.fortune_1000_flag<>(typeof(h.fortune_1000_flag))'');
    populated_fortune_1000_rank_cnt := COUNT(GROUP,h.fortune_1000_rank <> (TYPEOF(h.fortune_1000_rank))'');
    populated_fortune_1000_rank_pcnt := AVE(GROUP,IF(h.fortune_1000_rank = (TYPEOF(h.fortune_1000_rank))'',0,100));
    maxlength_fortune_1000_rank := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fortune_1000_rank)));
    avelength_fortune_1000_rank := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fortune_1000_rank)),h.fortune_1000_rank<>(typeof(h.fortune_1000_rank))'');
    populated_fortune_1000_branches_cnt := COUNT(GROUP,h.fortune_1000_branches <> (TYPEOF(h.fortune_1000_branches))'');
    populated_fortune_1000_branches_pcnt := AVE(GROUP,IF(h.fortune_1000_branches = (TYPEOF(h.fortune_1000_branches))'',0,100));
    maxlength_fortune_1000_branches := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fortune_1000_branches)));
    avelength_fortune_1000_branches := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fortune_1000_branches)),h.fortune_1000_branches<>(typeof(h.fortune_1000_branches))'');
    populated_num_linked_locations_cnt := COUNT(GROUP,h.num_linked_locations <> (TYPEOF(h.num_linked_locations))'');
    populated_num_linked_locations_pcnt := AVE(GROUP,IF(h.num_linked_locations = (TYPEOF(h.num_linked_locations))'',0,100));
    maxlength_num_linked_locations := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.num_linked_locations)));
    avelength_num_linked_locations := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.num_linked_locations)),h.num_linked_locations<>(typeof(h.num_linked_locations))'');
    populated_county_code_cnt := COUNT(GROUP,h.county_code <> (TYPEOF(h.county_code))'');
    populated_county_code_pcnt := AVE(GROUP,IF(h.county_code = (TYPEOF(h.county_code))'',0,100));
    maxlength_county_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_code)));
    avelength_county_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_code)),h.county_code<>(typeof(h.county_code))'');
    populated_county_desc_cnt := COUNT(GROUP,h.county_desc <> (TYPEOF(h.county_desc))'');
    populated_county_desc_pcnt := AVE(GROUP,IF(h.county_desc = (TYPEOF(h.county_desc))'',0,100));
    maxlength_county_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_desc)));
    avelength_county_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_desc)),h.county_desc<>(typeof(h.county_desc))'');
    populated_cbsa_code_cnt := COUNT(GROUP,h.cbsa_code <> (TYPEOF(h.cbsa_code))'');
    populated_cbsa_code_pcnt := AVE(GROUP,IF(h.cbsa_code = (TYPEOF(h.cbsa_code))'',0,100));
    maxlength_cbsa_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cbsa_code)));
    avelength_cbsa_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cbsa_code)),h.cbsa_code<>(typeof(h.cbsa_code))'');
    populated_cbsa_desc_cnt := COUNT(GROUP,h.cbsa_desc <> (TYPEOF(h.cbsa_desc))'');
    populated_cbsa_desc_pcnt := AVE(GROUP,IF(h.cbsa_desc = (TYPEOF(h.cbsa_desc))'',0,100));
    maxlength_cbsa_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cbsa_desc)));
    avelength_cbsa_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cbsa_desc)),h.cbsa_desc<>(typeof(h.cbsa_desc))'');
    populated_geo_match_level_cnt := COUNT(GROUP,h.geo_match_level <> (TYPEOF(h.geo_match_level))'');
    populated_geo_match_level_pcnt := AVE(GROUP,IF(h.geo_match_level = (TYPEOF(h.geo_match_level))'',0,100));
    maxlength_geo_match_level := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match_level)));
    avelength_geo_match_level := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match_level)),h.geo_match_level<>(typeof(h.geo_match_level))'');
    populated_latitude_cnt := COUNT(GROUP,h.latitude <> (TYPEOF(h.latitude))'');
    populated_latitude_pcnt := AVE(GROUP,IF(h.latitude = (TYPEOF(h.latitude))'',0,100));
    maxlength_latitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.latitude)));
    avelength_latitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.latitude)),h.latitude<>(typeof(h.latitude))'');
    populated_longitude_cnt := COUNT(GROUP,h.longitude <> (TYPEOF(h.longitude))'');
    populated_longitude_pcnt := AVE(GROUP,IF(h.longitude = (TYPEOF(h.longitude))'',0,100));
    maxlength_longitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.longitude)));
    avelength_longitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.longitude)),h.longitude<>(typeof(h.longitude))'');
    populated_scf_cnt := COUNT(GROUP,h.scf <> (TYPEOF(h.scf))'');
    populated_scf_pcnt := AVE(GROUP,IF(h.scf = (TYPEOF(h.scf))'',0,100));
    maxlength_scf := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.scf)));
    avelength_scf := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.scf)),h.scf<>(typeof(h.scf))'');
    populated_timezone_cnt := COUNT(GROUP,h.timezone <> (TYPEOF(h.timezone))'');
    populated_timezone_pcnt := AVE(GROUP,IF(h.timezone = (TYPEOF(h.timezone))'',0,100));
    maxlength_timezone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.timezone)));
    avelength_timezone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.timezone)),h.timezone<>(typeof(h.timezone))'');
    populated_censustract_cnt := COUNT(GROUP,h.censustract <> (TYPEOF(h.censustract))'');
    populated_censustract_pcnt := AVE(GROUP,IF(h.censustract = (TYPEOF(h.censustract))'',0,100));
    maxlength_censustract := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censustract)));
    avelength_censustract := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censustract)),h.censustract<>(typeof(h.censustract))'');
    populated_censusblock_cnt := COUNT(GROUP,h.censusblock <> (TYPEOF(h.censusblock))'');
    populated_censusblock_pcnt := AVE(GROUP,IF(h.censusblock = (TYPEOF(h.censusblock))'',0,100));
    maxlength_censusblock := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.censusblock)));
    avelength_censusblock := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.censusblock)),h.censusblock<>(typeof(h.censusblock))'');
    populated_city_population_code_cnt := COUNT(GROUP,h.city_population_code <> (TYPEOF(h.city_population_code))'');
    populated_city_population_code_pcnt := AVE(GROUP,IF(h.city_population_code = (TYPEOF(h.city_population_code))'',0,100));
    maxlength_city_population_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_population_code)));
    avelength_city_population_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_population_code)),h.city_population_code<>(typeof(h.city_population_code))'');
    populated_city_population_descr_cnt := COUNT(GROUP,h.city_population_descr <> (TYPEOF(h.city_population_descr))'');
    populated_city_population_descr_pcnt := AVE(GROUP,IF(h.city_population_descr = (TYPEOF(h.city_population_descr))'',0,100));
    maxlength_city_population_descr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_population_descr)));
    avelength_city_population_descr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_population_descr)),h.city_population_descr<>(typeof(h.city_population_descr))'');
    populated_primary_sic_cnt := COUNT(GROUP,h.primary_sic <> (TYPEOF(h.primary_sic))'');
    populated_primary_sic_pcnt := AVE(GROUP,IF(h.primary_sic = (TYPEOF(h.primary_sic))'',0,100));
    maxlength_primary_sic := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_sic)));
    avelength_primary_sic := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_sic)),h.primary_sic<>(typeof(h.primary_sic))'');
    populated_primary_sic_desc_cnt := COUNT(GROUP,h.primary_sic_desc <> (TYPEOF(h.primary_sic_desc))'');
    populated_primary_sic_desc_pcnt := AVE(GROUP,IF(h.primary_sic_desc = (TYPEOF(h.primary_sic_desc))'',0,100));
    maxlength_primary_sic_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_sic_desc)));
    avelength_primary_sic_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_sic_desc)),h.primary_sic_desc<>(typeof(h.primary_sic_desc))'');
    populated_sic02_cnt := COUNT(GROUP,h.sic02 <> (TYPEOF(h.sic02))'');
    populated_sic02_pcnt := AVE(GROUP,IF(h.sic02 = (TYPEOF(h.sic02))'',0,100));
    maxlength_sic02 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic02)));
    avelength_sic02 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic02)),h.sic02<>(typeof(h.sic02))'');
    populated_sic02_desc_cnt := COUNT(GROUP,h.sic02_desc <> (TYPEOF(h.sic02_desc))'');
    populated_sic02_desc_pcnt := AVE(GROUP,IF(h.sic02_desc = (TYPEOF(h.sic02_desc))'',0,100));
    maxlength_sic02_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic02_desc)));
    avelength_sic02_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic02_desc)),h.sic02_desc<>(typeof(h.sic02_desc))'');
    populated_sic03_cnt := COUNT(GROUP,h.sic03 <> (TYPEOF(h.sic03))'');
    populated_sic03_pcnt := AVE(GROUP,IF(h.sic03 = (TYPEOF(h.sic03))'',0,100));
    maxlength_sic03 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic03)));
    avelength_sic03 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic03)),h.sic03<>(typeof(h.sic03))'');
    populated_sic03_desc_cnt := COUNT(GROUP,h.sic03_desc <> (TYPEOF(h.sic03_desc))'');
    populated_sic03_desc_pcnt := AVE(GROUP,IF(h.sic03_desc = (TYPEOF(h.sic03_desc))'',0,100));
    maxlength_sic03_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic03_desc)));
    avelength_sic03_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic03_desc)),h.sic03_desc<>(typeof(h.sic03_desc))'');
    populated_sic04_cnt := COUNT(GROUP,h.sic04 <> (TYPEOF(h.sic04))'');
    populated_sic04_pcnt := AVE(GROUP,IF(h.sic04 = (TYPEOF(h.sic04))'',0,100));
    maxlength_sic04 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic04)));
    avelength_sic04 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic04)),h.sic04<>(typeof(h.sic04))'');
    populated_sic04_desc_cnt := COUNT(GROUP,h.sic04_desc <> (TYPEOF(h.sic04_desc))'');
    populated_sic04_desc_pcnt := AVE(GROUP,IF(h.sic04_desc = (TYPEOF(h.sic04_desc))'',0,100));
    maxlength_sic04_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic04_desc)));
    avelength_sic04_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic04_desc)),h.sic04_desc<>(typeof(h.sic04_desc))'');
    populated_sic05_cnt := COUNT(GROUP,h.sic05 <> (TYPEOF(h.sic05))'');
    populated_sic05_pcnt := AVE(GROUP,IF(h.sic05 = (TYPEOF(h.sic05))'',0,100));
    maxlength_sic05 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic05)));
    avelength_sic05 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic05)),h.sic05<>(typeof(h.sic05))'');
    populated_sic05_desc_cnt := COUNT(GROUP,h.sic05_desc <> (TYPEOF(h.sic05_desc))'');
    populated_sic05_desc_pcnt := AVE(GROUP,IF(h.sic05_desc = (TYPEOF(h.sic05_desc))'',0,100));
    maxlength_sic05_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic05_desc)));
    avelength_sic05_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic05_desc)),h.sic05_desc<>(typeof(h.sic05_desc))'');
    populated_sic06_cnt := COUNT(GROUP,h.sic06 <> (TYPEOF(h.sic06))'');
    populated_sic06_pcnt := AVE(GROUP,IF(h.sic06 = (TYPEOF(h.sic06))'',0,100));
    maxlength_sic06 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic06)));
    avelength_sic06 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic06)),h.sic06<>(typeof(h.sic06))'');
    populated_sic06_desc_cnt := COUNT(GROUP,h.sic06_desc <> (TYPEOF(h.sic06_desc))'');
    populated_sic06_desc_pcnt := AVE(GROUP,IF(h.sic06_desc = (TYPEOF(h.sic06_desc))'',0,100));
    maxlength_sic06_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic06_desc)));
    avelength_sic06_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic06_desc)),h.sic06_desc<>(typeof(h.sic06_desc))'');
    populated_primarysic2_cnt := COUNT(GROUP,h.primarysic2 <> (TYPEOF(h.primarysic2))'');
    populated_primarysic2_pcnt := AVE(GROUP,IF(h.primarysic2 = (TYPEOF(h.primarysic2))'',0,100));
    maxlength_primarysic2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primarysic2)));
    avelength_primarysic2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primarysic2)),h.primarysic2<>(typeof(h.primarysic2))'');
    populated_primary_2_digit_sic_desc_cnt := COUNT(GROUP,h.primary_2_digit_sic_desc <> (TYPEOF(h.primary_2_digit_sic_desc))'');
    populated_primary_2_digit_sic_desc_pcnt := AVE(GROUP,IF(h.primary_2_digit_sic_desc = (TYPEOF(h.primary_2_digit_sic_desc))'',0,100));
    maxlength_primary_2_digit_sic_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_2_digit_sic_desc)));
    avelength_primary_2_digit_sic_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_2_digit_sic_desc)),h.primary_2_digit_sic_desc<>(typeof(h.primary_2_digit_sic_desc))'');
    populated_primarysic4_cnt := COUNT(GROUP,h.primarysic4 <> (TYPEOF(h.primarysic4))'');
    populated_primarysic4_pcnt := AVE(GROUP,IF(h.primarysic4 = (TYPEOF(h.primarysic4))'',0,100));
    maxlength_primarysic4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primarysic4)));
    avelength_primarysic4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primarysic4)),h.primarysic4<>(typeof(h.primarysic4))'');
    populated_primary_4_digit_sic_desc_cnt := COUNT(GROUP,h.primary_4_digit_sic_desc <> (TYPEOF(h.primary_4_digit_sic_desc))'');
    populated_primary_4_digit_sic_desc_pcnt := AVE(GROUP,IF(h.primary_4_digit_sic_desc = (TYPEOF(h.primary_4_digit_sic_desc))'',0,100));
    maxlength_primary_4_digit_sic_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_4_digit_sic_desc)));
    avelength_primary_4_digit_sic_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_4_digit_sic_desc)),h.primary_4_digit_sic_desc<>(typeof(h.primary_4_digit_sic_desc))'');
    populated_naics01_cnt := COUNT(GROUP,h.naics01 <> (TYPEOF(h.naics01))'');
    populated_naics01_pcnt := AVE(GROUP,IF(h.naics01 = (TYPEOF(h.naics01))'',0,100));
    maxlength_naics01 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics01)));
    avelength_naics01 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics01)),h.naics01<>(typeof(h.naics01))'');
    populated_naics01_desc_cnt := COUNT(GROUP,h.naics01_desc <> (TYPEOF(h.naics01_desc))'');
    populated_naics01_desc_pcnt := AVE(GROUP,IF(h.naics01_desc = (TYPEOF(h.naics01_desc))'',0,100));
    maxlength_naics01_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics01_desc)));
    avelength_naics01_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics01_desc)),h.naics01_desc<>(typeof(h.naics01_desc))'');
    populated_naics02_cnt := COUNT(GROUP,h.naics02 <> (TYPEOF(h.naics02))'');
    populated_naics02_pcnt := AVE(GROUP,IF(h.naics02 = (TYPEOF(h.naics02))'',0,100));
    maxlength_naics02 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics02)));
    avelength_naics02 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics02)),h.naics02<>(typeof(h.naics02))'');
    populated_naics02_desc_cnt := COUNT(GROUP,h.naics02_desc <> (TYPEOF(h.naics02_desc))'');
    populated_naics02_desc_pcnt := AVE(GROUP,IF(h.naics02_desc = (TYPEOF(h.naics02_desc))'',0,100));
    maxlength_naics02_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics02_desc)));
    avelength_naics02_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics02_desc)),h.naics02_desc<>(typeof(h.naics02_desc))'');
    populated_naics03_cnt := COUNT(GROUP,h.naics03 <> (TYPEOF(h.naics03))'');
    populated_naics03_pcnt := AVE(GROUP,IF(h.naics03 = (TYPEOF(h.naics03))'',0,100));
    maxlength_naics03 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics03)));
    avelength_naics03 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics03)),h.naics03<>(typeof(h.naics03))'');
    populated_naics03_desc_cnt := COUNT(GROUP,h.naics03_desc <> (TYPEOF(h.naics03_desc))'');
    populated_naics03_desc_pcnt := AVE(GROUP,IF(h.naics03_desc = (TYPEOF(h.naics03_desc))'',0,100));
    maxlength_naics03_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics03_desc)));
    avelength_naics03_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics03_desc)),h.naics03_desc<>(typeof(h.naics03_desc))'');
    populated_naics04_cnt := COUNT(GROUP,h.naics04 <> (TYPEOF(h.naics04))'');
    populated_naics04_pcnt := AVE(GROUP,IF(h.naics04 = (TYPEOF(h.naics04))'',0,100));
    maxlength_naics04 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics04)));
    avelength_naics04 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics04)),h.naics04<>(typeof(h.naics04))'');
    populated_naics04_desc_cnt := COUNT(GROUP,h.naics04_desc <> (TYPEOF(h.naics04_desc))'');
    populated_naics04_desc_pcnt := AVE(GROUP,IF(h.naics04_desc = (TYPEOF(h.naics04_desc))'',0,100));
    maxlength_naics04_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics04_desc)));
    avelength_naics04_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics04_desc)),h.naics04_desc<>(typeof(h.naics04_desc))'');
    populated_naics05_cnt := COUNT(GROUP,h.naics05 <> (TYPEOF(h.naics05))'');
    populated_naics05_pcnt := AVE(GROUP,IF(h.naics05 = (TYPEOF(h.naics05))'',0,100));
    maxlength_naics05 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics05)));
    avelength_naics05 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics05)),h.naics05<>(typeof(h.naics05))'');
    populated_naics05_desc_cnt := COUNT(GROUP,h.naics05_desc <> (TYPEOF(h.naics05_desc))'');
    populated_naics05_desc_pcnt := AVE(GROUP,IF(h.naics05_desc = (TYPEOF(h.naics05_desc))'',0,100));
    maxlength_naics05_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics05_desc)));
    avelength_naics05_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics05_desc)),h.naics05_desc<>(typeof(h.naics05_desc))'');
    populated_naics06_cnt := COUNT(GROUP,h.naics06 <> (TYPEOF(h.naics06))'');
    populated_naics06_pcnt := AVE(GROUP,IF(h.naics06 = (TYPEOF(h.naics06))'',0,100));
    maxlength_naics06 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics06)));
    avelength_naics06 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics06)),h.naics06<>(typeof(h.naics06))'');
    populated_naics06_desc_cnt := COUNT(GROUP,h.naics06_desc <> (TYPEOF(h.naics06_desc))'');
    populated_naics06_desc_pcnt := AVE(GROUP,IF(h.naics06_desc = (TYPEOF(h.naics06_desc))'',0,100));
    maxlength_naics06_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics06_desc)));
    avelength_naics06_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics06_desc)),h.naics06_desc<>(typeof(h.naics06_desc))'');
    populated_location_employees_total_cnt := COUNT(GROUP,h.location_employees_total <> (TYPEOF(h.location_employees_total))'');
    populated_location_employees_total_pcnt := AVE(GROUP,IF(h.location_employees_total = (TYPEOF(h.location_employees_total))'',0,100));
    maxlength_location_employees_total := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_employees_total)));
    avelength_location_employees_total := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_employees_total)),h.location_employees_total<>(typeof(h.location_employees_total))'');
    populated_location_employee_code_cnt := COUNT(GROUP,h.location_employee_code <> (TYPEOF(h.location_employee_code))'');
    populated_location_employee_code_pcnt := AVE(GROUP,IF(h.location_employee_code = (TYPEOF(h.location_employee_code))'',0,100));
    maxlength_location_employee_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_employee_code)));
    avelength_location_employee_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_employee_code)),h.location_employee_code<>(typeof(h.location_employee_code))'');
    populated_location_employee_desc_cnt := COUNT(GROUP,h.location_employee_desc <> (TYPEOF(h.location_employee_desc))'');
    populated_location_employee_desc_pcnt := AVE(GROUP,IF(h.location_employee_desc = (TYPEOF(h.location_employee_desc))'',0,100));
    maxlength_location_employee_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_employee_desc)));
    avelength_location_employee_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_employee_desc)),h.location_employee_desc<>(typeof(h.location_employee_desc))'');
    populated_location_sales_total_cnt := COUNT(GROUP,h.location_sales_total <> (TYPEOF(h.location_sales_total))'');
    populated_location_sales_total_pcnt := AVE(GROUP,IF(h.location_sales_total = (TYPEOF(h.location_sales_total))'',0,100));
    maxlength_location_sales_total := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_sales_total)));
    avelength_location_sales_total := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_sales_total)),h.location_sales_total<>(typeof(h.location_sales_total))'');
    populated_location_sales_code_cnt := COUNT(GROUP,h.location_sales_code <> (TYPEOF(h.location_sales_code))'');
    populated_location_sales_code_pcnt := AVE(GROUP,IF(h.location_sales_code = (TYPEOF(h.location_sales_code))'',0,100));
    maxlength_location_sales_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_sales_code)));
    avelength_location_sales_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_sales_code)),h.location_sales_code<>(typeof(h.location_sales_code))'');
    populated_location_sales_desc_cnt := COUNT(GROUP,h.location_sales_desc <> (TYPEOF(h.location_sales_desc))'');
    populated_location_sales_desc_pcnt := AVE(GROUP,IF(h.location_sales_desc = (TYPEOF(h.location_sales_desc))'',0,100));
    maxlength_location_sales_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_sales_desc)));
    avelength_location_sales_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_sales_desc)),h.location_sales_desc<>(typeof(h.location_sales_desc))'');
    populated_corporate_employee_total_cnt := COUNT(GROUP,h.corporate_employee_total <> (TYPEOF(h.corporate_employee_total))'');
    populated_corporate_employee_total_pcnt := AVE(GROUP,IF(h.corporate_employee_total = (TYPEOF(h.corporate_employee_total))'',0,100));
    maxlength_corporate_employee_total := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corporate_employee_total)));
    avelength_corporate_employee_total := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corporate_employee_total)),h.corporate_employee_total<>(typeof(h.corporate_employee_total))'');
    populated_corporate_employee_code_cnt := COUNT(GROUP,h.corporate_employee_code <> (TYPEOF(h.corporate_employee_code))'');
    populated_corporate_employee_code_pcnt := AVE(GROUP,IF(h.corporate_employee_code = (TYPEOF(h.corporate_employee_code))'',0,100));
    maxlength_corporate_employee_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corporate_employee_code)));
    avelength_corporate_employee_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corporate_employee_code)),h.corporate_employee_code<>(typeof(h.corporate_employee_code))'');
    populated_corporate_employee_desc_cnt := COUNT(GROUP,h.corporate_employee_desc <> (TYPEOF(h.corporate_employee_desc))'');
    populated_corporate_employee_desc_pcnt := AVE(GROUP,IF(h.corporate_employee_desc = (TYPEOF(h.corporate_employee_desc))'',0,100));
    maxlength_corporate_employee_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corporate_employee_desc)));
    avelength_corporate_employee_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corporate_employee_desc)),h.corporate_employee_desc<>(typeof(h.corporate_employee_desc))'');
    populated_year_established_cnt := COUNT(GROUP,h.year_established <> (TYPEOF(h.year_established))'');
    populated_year_established_pcnt := AVE(GROUP,IF(h.year_established = (TYPEOF(h.year_established))'',0,100));
    maxlength_year_established := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.year_established)));
    avelength_year_established := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.year_established)),h.year_established<>(typeof(h.year_established))'');
    populated_years_in_business_range_cnt := COUNT(GROUP,h.years_in_business_range <> (TYPEOF(h.years_in_business_range))'');
    populated_years_in_business_range_pcnt := AVE(GROUP,IF(h.years_in_business_range = (TYPEOF(h.years_in_business_range))'',0,100));
    maxlength_years_in_business_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.years_in_business_range)));
    avelength_years_in_business_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.years_in_business_range)),h.years_in_business_range<>(typeof(h.years_in_business_range))'');
    populated_female_owned_cnt := COUNT(GROUP,h.female_owned <> (TYPEOF(h.female_owned))'');
    populated_female_owned_pcnt := AVE(GROUP,IF(h.female_owned = (TYPEOF(h.female_owned))'',0,100));
    maxlength_female_owned := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.female_owned)));
    avelength_female_owned := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.female_owned)),h.female_owned<>(typeof(h.female_owned))'');
    populated_minority_owned_flag_cnt := COUNT(GROUP,h.minority_owned_flag <> (TYPEOF(h.minority_owned_flag))'');
    populated_minority_owned_flag_pcnt := AVE(GROUP,IF(h.minority_owned_flag = (TYPEOF(h.minority_owned_flag))'',0,100));
    maxlength_minority_owned_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.minority_owned_flag)));
    avelength_minority_owned_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.minority_owned_flag)),h.minority_owned_flag<>(typeof(h.minority_owned_flag))'');
    populated_minority_type_cnt := COUNT(GROUP,h.minority_type <> (TYPEOF(h.minority_type))'');
    populated_minority_type_pcnt := AVE(GROUP,IF(h.minority_type = (TYPEOF(h.minority_type))'',0,100));
    maxlength_minority_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.minority_type)));
    avelength_minority_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.minority_type)),h.minority_type<>(typeof(h.minority_type))'');
    populated_home_based_indicator_cnt := COUNT(GROUP,h.home_based_indicator <> (TYPEOF(h.home_based_indicator))'');
    populated_home_based_indicator_pcnt := AVE(GROUP,IF(h.home_based_indicator = (TYPEOF(h.home_based_indicator))'',0,100));
    maxlength_home_based_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.home_based_indicator)));
    avelength_home_based_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.home_based_indicator)),h.home_based_indicator<>(typeof(h.home_based_indicator))'');
    populated_small_business_indicator_cnt := COUNT(GROUP,h.small_business_indicator <> (TYPEOF(h.small_business_indicator))'');
    populated_small_business_indicator_pcnt := AVE(GROUP,IF(h.small_business_indicator = (TYPEOF(h.small_business_indicator))'',0,100));
    maxlength_small_business_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.small_business_indicator)));
    avelength_small_business_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.small_business_indicator)),h.small_business_indicator<>(typeof(h.small_business_indicator))'');
    populated_import_export_cnt := COUNT(GROUP,h.import_export <> (TYPEOF(h.import_export))'');
    populated_import_export_pcnt := AVE(GROUP,IF(h.import_export = (TYPEOF(h.import_export))'',0,100));
    maxlength_import_export := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.import_export)));
    avelength_import_export := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.import_export)),h.import_export<>(typeof(h.import_export))'');
    populated_manufacturing_location_cnt := COUNT(GROUP,h.manufacturing_location <> (TYPEOF(h.manufacturing_location))'');
    populated_manufacturing_location_pcnt := AVE(GROUP,IF(h.manufacturing_location = (TYPEOF(h.manufacturing_location))'',0,100));
    maxlength_manufacturing_location := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.manufacturing_location)));
    avelength_manufacturing_location := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.manufacturing_location)),h.manufacturing_location<>(typeof(h.manufacturing_location))'');
    populated_public_indicator_cnt := COUNT(GROUP,h.public_indicator <> (TYPEOF(h.public_indicator))'');
    populated_public_indicator_pcnt := AVE(GROUP,IF(h.public_indicator = (TYPEOF(h.public_indicator))'',0,100));
    maxlength_public_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.public_indicator)));
    avelength_public_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.public_indicator)),h.public_indicator<>(typeof(h.public_indicator))'');
    populated_ein_cnt := COUNT(GROUP,h.ein <> (TYPEOF(h.ein))'');
    populated_ein_pcnt := AVE(GROUP,IF(h.ein = (TYPEOF(h.ein))'',0,100));
    maxlength_ein := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ein)));
    avelength_ein := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ein)),h.ein<>(typeof(h.ein))'');
    populated_non_profit_org_cnt := COUNT(GROUP,h.non_profit_org <> (TYPEOF(h.non_profit_org))'');
    populated_non_profit_org_pcnt := AVE(GROUP,IF(h.non_profit_org = (TYPEOF(h.non_profit_org))'',0,100));
    maxlength_non_profit_org := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.non_profit_org)));
    avelength_non_profit_org := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.non_profit_org)),h.non_profit_org<>(typeof(h.non_profit_org))'');
    populated_square_footage_cnt := COUNT(GROUP,h.square_footage <> (TYPEOF(h.square_footage))'');
    populated_square_footage_pcnt := AVE(GROUP,IF(h.square_footage = (TYPEOF(h.square_footage))'',0,100));
    maxlength_square_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.square_footage)));
    avelength_square_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.square_footage)),h.square_footage<>(typeof(h.square_footage))'');
    populated_square_footage_code_cnt := COUNT(GROUP,h.square_footage_code <> (TYPEOF(h.square_footage_code))'');
    populated_square_footage_code_pcnt := AVE(GROUP,IF(h.square_footage_code = (TYPEOF(h.square_footage_code))'',0,100));
    maxlength_square_footage_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.square_footage_code)));
    avelength_square_footage_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.square_footage_code)),h.square_footage_code<>(typeof(h.square_footage_code))'');
    populated_square_footage_desc_cnt := COUNT(GROUP,h.square_footage_desc <> (TYPEOF(h.square_footage_desc))'');
    populated_square_footage_desc_pcnt := AVE(GROUP,IF(h.square_footage_desc = (TYPEOF(h.square_footage_desc))'',0,100));
    maxlength_square_footage_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.square_footage_desc)));
    avelength_square_footage_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.square_footage_desc)),h.square_footage_desc<>(typeof(h.square_footage_desc))'');
    populated_creditscore_cnt := COUNT(GROUP,h.creditscore <> (TYPEOF(h.creditscore))'');
    populated_creditscore_pcnt := AVE(GROUP,IF(h.creditscore = (TYPEOF(h.creditscore))'',0,100));
    maxlength_creditscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.creditscore)));
    avelength_creditscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.creditscore)),h.creditscore<>(typeof(h.creditscore))'');
    populated_creditcode_cnt := COUNT(GROUP,h.creditcode <> (TYPEOF(h.creditcode))'');
    populated_creditcode_pcnt := AVE(GROUP,IF(h.creditcode = (TYPEOF(h.creditcode))'',0,100));
    maxlength_creditcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.creditcode)));
    avelength_creditcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.creditcode)),h.creditcode<>(typeof(h.creditcode))'');
    populated_credit_desc_cnt := COUNT(GROUP,h.credit_desc <> (TYPEOF(h.credit_desc))'');
    populated_credit_desc_pcnt := AVE(GROUP,IF(h.credit_desc = (TYPEOF(h.credit_desc))'',0,100));
    maxlength_credit_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.credit_desc)));
    avelength_credit_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.credit_desc)),h.credit_desc<>(typeof(h.credit_desc))'');
    populated_credit_capacity_cnt := COUNT(GROUP,h.credit_capacity <> (TYPEOF(h.credit_capacity))'');
    populated_credit_capacity_pcnt := AVE(GROUP,IF(h.credit_capacity = (TYPEOF(h.credit_capacity))'',0,100));
    maxlength_credit_capacity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.credit_capacity)));
    avelength_credit_capacity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.credit_capacity)),h.credit_capacity<>(typeof(h.credit_capacity))'');
    populated_credit_capacity_code_cnt := COUNT(GROUP,h.credit_capacity_code <> (TYPEOF(h.credit_capacity_code))'');
    populated_credit_capacity_code_pcnt := AVE(GROUP,IF(h.credit_capacity_code = (TYPEOF(h.credit_capacity_code))'',0,100));
    maxlength_credit_capacity_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.credit_capacity_code)));
    avelength_credit_capacity_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.credit_capacity_code)),h.credit_capacity_code<>(typeof(h.credit_capacity_code))'');
    populated_credit_capacity_desc_cnt := COUNT(GROUP,h.credit_capacity_desc <> (TYPEOF(h.credit_capacity_desc))'');
    populated_credit_capacity_desc_pcnt := AVE(GROUP,IF(h.credit_capacity_desc = (TYPEOF(h.credit_capacity_desc))'',0,100));
    maxlength_credit_capacity_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.credit_capacity_desc)));
    avelength_credit_capacity_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.credit_capacity_desc)),h.credit_capacity_desc<>(typeof(h.credit_capacity_desc))'');
    populated_advertising_expenses_code_cnt := COUNT(GROUP,h.advertising_expenses_code <> (TYPEOF(h.advertising_expenses_code))'');
    populated_advertising_expenses_code_pcnt := AVE(GROUP,IF(h.advertising_expenses_code = (TYPEOF(h.advertising_expenses_code))'',0,100));
    maxlength_advertising_expenses_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.advertising_expenses_code)));
    avelength_advertising_expenses_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.advertising_expenses_code)),h.advertising_expenses_code<>(typeof(h.advertising_expenses_code))'');
    populated_expense_advertising_desc_cnt := COUNT(GROUP,h.expense_advertising_desc <> (TYPEOF(h.expense_advertising_desc))'');
    populated_expense_advertising_desc_pcnt := AVE(GROUP,IF(h.expense_advertising_desc = (TYPEOF(h.expense_advertising_desc))'',0,100));
    maxlength_expense_advertising_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_advertising_desc)));
    avelength_expense_advertising_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_advertising_desc)),h.expense_advertising_desc<>(typeof(h.expense_advertising_desc))'');
    populated_technology_expenses_code_cnt := COUNT(GROUP,h.technology_expenses_code <> (TYPEOF(h.technology_expenses_code))'');
    populated_technology_expenses_code_pcnt := AVE(GROUP,IF(h.technology_expenses_code = (TYPEOF(h.technology_expenses_code))'',0,100));
    maxlength_technology_expenses_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.technology_expenses_code)));
    avelength_technology_expenses_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.technology_expenses_code)),h.technology_expenses_code<>(typeof(h.technology_expenses_code))'');
    populated_expense_technology_desc_cnt := COUNT(GROUP,h.expense_technology_desc <> (TYPEOF(h.expense_technology_desc))'');
    populated_expense_technology_desc_pcnt := AVE(GROUP,IF(h.expense_technology_desc = (TYPEOF(h.expense_technology_desc))'',0,100));
    maxlength_expense_technology_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_technology_desc)));
    avelength_expense_technology_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_technology_desc)),h.expense_technology_desc<>(typeof(h.expense_technology_desc))'');
    populated_office_equip_expenses_code_cnt := COUNT(GROUP,h.office_equip_expenses_code <> (TYPEOF(h.office_equip_expenses_code))'');
    populated_office_equip_expenses_code_pcnt := AVE(GROUP,IF(h.office_equip_expenses_code = (TYPEOF(h.office_equip_expenses_code))'',0,100));
    maxlength_office_equip_expenses_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.office_equip_expenses_code)));
    avelength_office_equip_expenses_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.office_equip_expenses_code)),h.office_equip_expenses_code<>(typeof(h.office_equip_expenses_code))'');
    populated_expense_office_equip_desc_cnt := COUNT(GROUP,h.expense_office_equip_desc <> (TYPEOF(h.expense_office_equip_desc))'');
    populated_expense_office_equip_desc_pcnt := AVE(GROUP,IF(h.expense_office_equip_desc = (TYPEOF(h.expense_office_equip_desc))'',0,100));
    maxlength_expense_office_equip_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_office_equip_desc)));
    avelength_expense_office_equip_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_office_equip_desc)),h.expense_office_equip_desc<>(typeof(h.expense_office_equip_desc))'');
    populated_rent_expenses_code_cnt := COUNT(GROUP,h.rent_expenses_code <> (TYPEOF(h.rent_expenses_code))'');
    populated_rent_expenses_code_pcnt := AVE(GROUP,IF(h.rent_expenses_code = (TYPEOF(h.rent_expenses_code))'',0,100));
    maxlength_rent_expenses_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rent_expenses_code)));
    avelength_rent_expenses_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rent_expenses_code)),h.rent_expenses_code<>(typeof(h.rent_expenses_code))'');
    populated_expense_rent_desc_cnt := COUNT(GROUP,h.expense_rent_desc <> (TYPEOF(h.expense_rent_desc))'');
    populated_expense_rent_desc_pcnt := AVE(GROUP,IF(h.expense_rent_desc = (TYPEOF(h.expense_rent_desc))'',0,100));
    maxlength_expense_rent_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_rent_desc)));
    avelength_expense_rent_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_rent_desc)),h.expense_rent_desc<>(typeof(h.expense_rent_desc))'');
    populated_telecom_expenses_code_cnt := COUNT(GROUP,h.telecom_expenses_code <> (TYPEOF(h.telecom_expenses_code))'');
    populated_telecom_expenses_code_pcnt := AVE(GROUP,IF(h.telecom_expenses_code = (TYPEOF(h.telecom_expenses_code))'',0,100));
    maxlength_telecom_expenses_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.telecom_expenses_code)));
    avelength_telecom_expenses_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.telecom_expenses_code)),h.telecom_expenses_code<>(typeof(h.telecom_expenses_code))'');
    populated_expense_telecom_desc_cnt := COUNT(GROUP,h.expense_telecom_desc <> (TYPEOF(h.expense_telecom_desc))'');
    populated_expense_telecom_desc_pcnt := AVE(GROUP,IF(h.expense_telecom_desc = (TYPEOF(h.expense_telecom_desc))'',0,100));
    maxlength_expense_telecom_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_telecom_desc)));
    avelength_expense_telecom_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_telecom_desc)),h.expense_telecom_desc<>(typeof(h.expense_telecom_desc))'');
    populated_accounting_expenses_code_cnt := COUNT(GROUP,h.accounting_expenses_code <> (TYPEOF(h.accounting_expenses_code))'');
    populated_accounting_expenses_code_pcnt := AVE(GROUP,IF(h.accounting_expenses_code = (TYPEOF(h.accounting_expenses_code))'',0,100));
    maxlength_accounting_expenses_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.accounting_expenses_code)));
    avelength_accounting_expenses_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.accounting_expenses_code)),h.accounting_expenses_code<>(typeof(h.accounting_expenses_code))'');
    populated_expense_accounting_desc_cnt := COUNT(GROUP,h.expense_accounting_desc <> (TYPEOF(h.expense_accounting_desc))'');
    populated_expense_accounting_desc_pcnt := AVE(GROUP,IF(h.expense_accounting_desc = (TYPEOF(h.expense_accounting_desc))'',0,100));
    maxlength_expense_accounting_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_accounting_desc)));
    avelength_expense_accounting_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_accounting_desc)),h.expense_accounting_desc<>(typeof(h.expense_accounting_desc))'');
    populated_bus_insurance_expense_code_cnt := COUNT(GROUP,h.bus_insurance_expense_code <> (TYPEOF(h.bus_insurance_expense_code))'');
    populated_bus_insurance_expense_code_pcnt := AVE(GROUP,IF(h.bus_insurance_expense_code = (TYPEOF(h.bus_insurance_expense_code))'',0,100));
    maxlength_bus_insurance_expense_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bus_insurance_expense_code)));
    avelength_bus_insurance_expense_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bus_insurance_expense_code)),h.bus_insurance_expense_code<>(typeof(h.bus_insurance_expense_code))'');
    populated_expense_bus_insurance_desc_cnt := COUNT(GROUP,h.expense_bus_insurance_desc <> (TYPEOF(h.expense_bus_insurance_desc))'');
    populated_expense_bus_insurance_desc_pcnt := AVE(GROUP,IF(h.expense_bus_insurance_desc = (TYPEOF(h.expense_bus_insurance_desc))'',0,100));
    maxlength_expense_bus_insurance_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_bus_insurance_desc)));
    avelength_expense_bus_insurance_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_bus_insurance_desc)),h.expense_bus_insurance_desc<>(typeof(h.expense_bus_insurance_desc))'');
    populated_legal_expenses_code_cnt := COUNT(GROUP,h.legal_expenses_code <> (TYPEOF(h.legal_expenses_code))'');
    populated_legal_expenses_code_pcnt := AVE(GROUP,IF(h.legal_expenses_code = (TYPEOF(h.legal_expenses_code))'',0,100));
    maxlength_legal_expenses_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_expenses_code)));
    avelength_legal_expenses_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_expenses_code)),h.legal_expenses_code<>(typeof(h.legal_expenses_code))'');
    populated_expense_legal_desc_cnt := COUNT(GROUP,h.expense_legal_desc <> (TYPEOF(h.expense_legal_desc))'');
    populated_expense_legal_desc_pcnt := AVE(GROUP,IF(h.expense_legal_desc = (TYPEOF(h.expense_legal_desc))'',0,100));
    maxlength_expense_legal_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_legal_desc)));
    avelength_expense_legal_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_legal_desc)),h.expense_legal_desc<>(typeof(h.expense_legal_desc))'');
    populated_utilities_expenses_code_cnt := COUNT(GROUP,h.utilities_expenses_code <> (TYPEOF(h.utilities_expenses_code))'');
    populated_utilities_expenses_code_pcnt := AVE(GROUP,IF(h.utilities_expenses_code = (TYPEOF(h.utilities_expenses_code))'',0,100));
    maxlength_utilities_expenses_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.utilities_expenses_code)));
    avelength_utilities_expenses_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.utilities_expenses_code)),h.utilities_expenses_code<>(typeof(h.utilities_expenses_code))'');
    populated_expense_utilities_desc_cnt := COUNT(GROUP,h.expense_utilities_desc <> (TYPEOF(h.expense_utilities_desc))'');
    populated_expense_utilities_desc_pcnt := AVE(GROUP,IF(h.expense_utilities_desc = (TYPEOF(h.expense_utilities_desc))'',0,100));
    maxlength_expense_utilities_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_utilities_desc)));
    avelength_expense_utilities_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.expense_utilities_desc)),h.expense_utilities_desc<>(typeof(h.expense_utilities_desc))'');
    populated_number_of_pcs_code_cnt := COUNT(GROUP,h.number_of_pcs_code <> (TYPEOF(h.number_of_pcs_code))'');
    populated_number_of_pcs_code_pcnt := AVE(GROUP,IF(h.number_of_pcs_code = (TYPEOF(h.number_of_pcs_code))'',0,100));
    maxlength_number_of_pcs_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.number_of_pcs_code)));
    avelength_number_of_pcs_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.number_of_pcs_code)),h.number_of_pcs_code<>(typeof(h.number_of_pcs_code))'');
    populated_number_of_pcs_desc_cnt := COUNT(GROUP,h.number_of_pcs_desc <> (TYPEOF(h.number_of_pcs_desc))'');
    populated_number_of_pcs_desc_pcnt := AVE(GROUP,IF(h.number_of_pcs_desc = (TYPEOF(h.number_of_pcs_desc))'',0,100));
    maxlength_number_of_pcs_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.number_of_pcs_desc)));
    avelength_number_of_pcs_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.number_of_pcs_desc)),h.number_of_pcs_desc<>(typeof(h.number_of_pcs_desc))'');
    populated_nb_flag_cnt := COUNT(GROUP,h.nb_flag <> (TYPEOF(h.nb_flag))'');
    populated_nb_flag_pcnt := AVE(GROUP,IF(h.nb_flag = (TYPEOF(h.nb_flag))'',0,100));
    maxlength_nb_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nb_flag)));
    avelength_nb_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nb_flag)),h.nb_flag<>(typeof(h.nb_flag))'');
    populated_hq_company_name_cnt := COUNT(GROUP,h.hq_company_name <> (TYPEOF(h.hq_company_name))'');
    populated_hq_company_name_pcnt := AVE(GROUP,IF(h.hq_company_name = (TYPEOF(h.hq_company_name))'',0,100));
    maxlength_hq_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hq_company_name)));
    avelength_hq_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hq_company_name)),h.hq_company_name<>(typeof(h.hq_company_name))'');
    populated_hq_city_cnt := COUNT(GROUP,h.hq_city <> (TYPEOF(h.hq_city))'');
    populated_hq_city_pcnt := AVE(GROUP,IF(h.hq_city = (TYPEOF(h.hq_city))'',0,100));
    maxlength_hq_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hq_city)));
    avelength_hq_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hq_city)),h.hq_city<>(typeof(h.hq_city))'');
    populated_hq_state_cnt := COUNT(GROUP,h.hq_state <> (TYPEOF(h.hq_state))'');
    populated_hq_state_pcnt := AVE(GROUP,IF(h.hq_state = (TYPEOF(h.hq_state))'',0,100));
    maxlength_hq_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hq_state)));
    avelength_hq_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hq_state)),h.hq_state<>(typeof(h.hq_state))'');
    populated_subhq_parent_name_cnt := COUNT(GROUP,h.subhq_parent_name <> (TYPEOF(h.subhq_parent_name))'');
    populated_subhq_parent_name_pcnt := AVE(GROUP,IF(h.subhq_parent_name = (TYPEOF(h.subhq_parent_name))'',0,100));
    maxlength_subhq_parent_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subhq_parent_name)));
    avelength_subhq_parent_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subhq_parent_name)),h.subhq_parent_name<>(typeof(h.subhq_parent_name))'');
    populated_subhq_parent_city_cnt := COUNT(GROUP,h.subhq_parent_city <> (TYPEOF(h.subhq_parent_city))'');
    populated_subhq_parent_city_pcnt := AVE(GROUP,IF(h.subhq_parent_city = (TYPEOF(h.subhq_parent_city))'',0,100));
    maxlength_subhq_parent_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subhq_parent_city)));
    avelength_subhq_parent_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subhq_parent_city)),h.subhq_parent_city<>(typeof(h.subhq_parent_city))'');
    populated_subhq_parent_state_cnt := COUNT(GROUP,h.subhq_parent_state <> (TYPEOF(h.subhq_parent_state))'');
    populated_subhq_parent_state_pcnt := AVE(GROUP,IF(h.subhq_parent_state = (TYPEOF(h.subhq_parent_state))'',0,100));
    maxlength_subhq_parent_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subhq_parent_state)));
    avelength_subhq_parent_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subhq_parent_state)),h.subhq_parent_state<>(typeof(h.subhq_parent_state))'');
    populated_domestic_foreign_owner_flag_cnt := COUNT(GROUP,h.domestic_foreign_owner_flag <> (TYPEOF(h.domestic_foreign_owner_flag))'');
    populated_domestic_foreign_owner_flag_pcnt := AVE(GROUP,IF(h.domestic_foreign_owner_flag = (TYPEOF(h.domestic_foreign_owner_flag))'',0,100));
    maxlength_domestic_foreign_owner_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.domestic_foreign_owner_flag)));
    avelength_domestic_foreign_owner_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.domestic_foreign_owner_flag)),h.domestic_foreign_owner_flag<>(typeof(h.domestic_foreign_owner_flag))'');
    populated_foreign_parent_company_name_cnt := COUNT(GROUP,h.foreign_parent_company_name <> (TYPEOF(h.foreign_parent_company_name))'');
    populated_foreign_parent_company_name_pcnt := AVE(GROUP,IF(h.foreign_parent_company_name = (TYPEOF(h.foreign_parent_company_name))'',0,100));
    maxlength_foreign_parent_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.foreign_parent_company_name)));
    avelength_foreign_parent_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.foreign_parent_company_name)),h.foreign_parent_company_name<>(typeof(h.foreign_parent_company_name))'');
    populated_foreign_parent_city_cnt := COUNT(GROUP,h.foreign_parent_city <> (TYPEOF(h.foreign_parent_city))'');
    populated_foreign_parent_city_pcnt := AVE(GROUP,IF(h.foreign_parent_city = (TYPEOF(h.foreign_parent_city))'',0,100));
    maxlength_foreign_parent_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.foreign_parent_city)));
    avelength_foreign_parent_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.foreign_parent_city)),h.foreign_parent_city<>(typeof(h.foreign_parent_city))'');
    populated_foreign_parent_country_cnt := COUNT(GROUP,h.foreign_parent_country <> (TYPEOF(h.foreign_parent_country))'');
    populated_foreign_parent_country_pcnt := AVE(GROUP,IF(h.foreign_parent_country = (TYPEOF(h.foreign_parent_country))'',0,100));
    maxlength_foreign_parent_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.foreign_parent_country)));
    avelength_foreign_parent_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.foreign_parent_country)),h.foreign_parent_country<>(typeof(h.foreign_parent_country))'');
    populated_db_cons_matchkey_cnt := COUNT(GROUP,h.db_cons_matchkey <> (TYPEOF(h.db_cons_matchkey))'');
    populated_db_cons_matchkey_pcnt := AVE(GROUP,IF(h.db_cons_matchkey = (TYPEOF(h.db_cons_matchkey))'',0,100));
    maxlength_db_cons_matchkey := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_matchkey)));
    avelength_db_cons_matchkey := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_matchkey)),h.db_cons_matchkey<>(typeof(h.db_cons_matchkey))'');
    populated_databaseusa_individual_id_cnt := COUNT(GROUP,h.databaseusa_individual_id <> (TYPEOF(h.databaseusa_individual_id))'');
    populated_databaseusa_individual_id_pcnt := AVE(GROUP,IF(h.databaseusa_individual_id = (TYPEOF(h.databaseusa_individual_id))'',0,100));
    maxlength_databaseusa_individual_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.databaseusa_individual_id)));
    avelength_databaseusa_individual_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.databaseusa_individual_id)),h.databaseusa_individual_id<>(typeof(h.databaseusa_individual_id))'');
    populated_db_cons_full_name_cnt := COUNT(GROUP,h.db_cons_full_name <> (TYPEOF(h.db_cons_full_name))'');
    populated_db_cons_full_name_pcnt := AVE(GROUP,IF(h.db_cons_full_name = (TYPEOF(h.db_cons_full_name))'',0,100));
    maxlength_db_cons_full_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_full_name)));
    avelength_db_cons_full_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_full_name)),h.db_cons_full_name<>(typeof(h.db_cons_full_name))'');
    populated_db_cons_full_name_prefix_cnt := COUNT(GROUP,h.db_cons_full_name_prefix <> (TYPEOF(h.db_cons_full_name_prefix))'');
    populated_db_cons_full_name_prefix_pcnt := AVE(GROUP,IF(h.db_cons_full_name_prefix = (TYPEOF(h.db_cons_full_name_prefix))'',0,100));
    maxlength_db_cons_full_name_prefix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_full_name_prefix)));
    avelength_db_cons_full_name_prefix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_full_name_prefix)),h.db_cons_full_name_prefix<>(typeof(h.db_cons_full_name_prefix))'');
    populated_db_cons_first_name_cnt := COUNT(GROUP,h.db_cons_first_name <> (TYPEOF(h.db_cons_first_name))'');
    populated_db_cons_first_name_pcnt := AVE(GROUP,IF(h.db_cons_first_name = (TYPEOF(h.db_cons_first_name))'',0,100));
    maxlength_db_cons_first_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_first_name)));
    avelength_db_cons_first_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_first_name)),h.db_cons_first_name<>(typeof(h.db_cons_first_name))'');
    populated_db_cons_middle_initial_cnt := COUNT(GROUP,h.db_cons_middle_initial <> (TYPEOF(h.db_cons_middle_initial))'');
    populated_db_cons_middle_initial_pcnt := AVE(GROUP,IF(h.db_cons_middle_initial = (TYPEOF(h.db_cons_middle_initial))'',0,100));
    maxlength_db_cons_middle_initial := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_middle_initial)));
    avelength_db_cons_middle_initial := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_middle_initial)),h.db_cons_middle_initial<>(typeof(h.db_cons_middle_initial))'');
    populated_db_cons_last_name_cnt := COUNT(GROUP,h.db_cons_last_name <> (TYPEOF(h.db_cons_last_name))'');
    populated_db_cons_last_name_pcnt := AVE(GROUP,IF(h.db_cons_last_name = (TYPEOF(h.db_cons_last_name))'',0,100));
    maxlength_db_cons_last_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_last_name)));
    avelength_db_cons_last_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_last_name)),h.db_cons_last_name<>(typeof(h.db_cons_last_name))'');
    populated_db_cons_email_cnt := COUNT(GROUP,h.db_cons_email <> (TYPEOF(h.db_cons_email))'');
    populated_db_cons_email_pcnt := AVE(GROUP,IF(h.db_cons_email = (TYPEOF(h.db_cons_email))'',0,100));
    maxlength_db_cons_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_email)));
    avelength_db_cons_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_email)),h.db_cons_email<>(typeof(h.db_cons_email))'');
    populated_db_cons_gender_cnt := COUNT(GROUP,h.db_cons_gender <> (TYPEOF(h.db_cons_gender))'');
    populated_db_cons_gender_pcnt := AVE(GROUP,IF(h.db_cons_gender = (TYPEOF(h.db_cons_gender))'',0,100));
    maxlength_db_cons_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_gender)));
    avelength_db_cons_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_gender)),h.db_cons_gender<>(typeof(h.db_cons_gender))'');
    populated_db_cons_date_of_birth_year_cnt := COUNT(GROUP,h.db_cons_date_of_birth_year <> (TYPEOF(h.db_cons_date_of_birth_year))'');
    populated_db_cons_date_of_birth_year_pcnt := AVE(GROUP,IF(h.db_cons_date_of_birth_year = (TYPEOF(h.db_cons_date_of_birth_year))'',0,100));
    maxlength_db_cons_date_of_birth_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_date_of_birth_year)));
    avelength_db_cons_date_of_birth_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_date_of_birth_year)),h.db_cons_date_of_birth_year<>(typeof(h.db_cons_date_of_birth_year))'');
    populated_db_cons_date_of_birth_month_cnt := COUNT(GROUP,h.db_cons_date_of_birth_month <> (TYPEOF(h.db_cons_date_of_birth_month))'');
    populated_db_cons_date_of_birth_month_pcnt := AVE(GROUP,IF(h.db_cons_date_of_birth_month = (TYPEOF(h.db_cons_date_of_birth_month))'',0,100));
    maxlength_db_cons_date_of_birth_month := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_date_of_birth_month)));
    avelength_db_cons_date_of_birth_month := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_date_of_birth_month)),h.db_cons_date_of_birth_month<>(typeof(h.db_cons_date_of_birth_month))'');
    populated_db_cons_age_cnt := COUNT(GROUP,h.db_cons_age <> (TYPEOF(h.db_cons_age))'');
    populated_db_cons_age_pcnt := AVE(GROUP,IF(h.db_cons_age = (TYPEOF(h.db_cons_age))'',0,100));
    maxlength_db_cons_age := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_age)));
    avelength_db_cons_age := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_age)),h.db_cons_age<>(typeof(h.db_cons_age))'');
    populated_db_cons_age_code_desc_cnt := COUNT(GROUP,h.db_cons_age_code_desc <> (TYPEOF(h.db_cons_age_code_desc))'');
    populated_db_cons_age_code_desc_pcnt := AVE(GROUP,IF(h.db_cons_age_code_desc = (TYPEOF(h.db_cons_age_code_desc))'',0,100));
    maxlength_db_cons_age_code_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_age_code_desc)));
    avelength_db_cons_age_code_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_age_code_desc)),h.db_cons_age_code_desc<>(typeof(h.db_cons_age_code_desc))'');
    populated_db_cons_age_in_two_year_hh_cnt := COUNT(GROUP,h.db_cons_age_in_two_year_hh <> (TYPEOF(h.db_cons_age_in_two_year_hh))'');
    populated_db_cons_age_in_two_year_hh_pcnt := AVE(GROUP,IF(h.db_cons_age_in_two_year_hh = (TYPEOF(h.db_cons_age_in_two_year_hh))'',0,100));
    maxlength_db_cons_age_in_two_year_hh := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_age_in_two_year_hh)));
    avelength_db_cons_age_in_two_year_hh := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_age_in_two_year_hh)),h.db_cons_age_in_two_year_hh<>(typeof(h.db_cons_age_in_two_year_hh))'');
    populated_db_cons_ethnic_code_cnt := COUNT(GROUP,h.db_cons_ethnic_code <> (TYPEOF(h.db_cons_ethnic_code))'');
    populated_db_cons_ethnic_code_pcnt := AVE(GROUP,IF(h.db_cons_ethnic_code = (TYPEOF(h.db_cons_ethnic_code))'',0,100));
    maxlength_db_cons_ethnic_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_ethnic_code)));
    avelength_db_cons_ethnic_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_ethnic_code)),h.db_cons_ethnic_code<>(typeof(h.db_cons_ethnic_code))'');
    populated_db_cons_religious_affil_cnt := COUNT(GROUP,h.db_cons_religious_affil <> (TYPEOF(h.db_cons_religious_affil))'');
    populated_db_cons_religious_affil_pcnt := AVE(GROUP,IF(h.db_cons_religious_affil = (TYPEOF(h.db_cons_religious_affil))'',0,100));
    maxlength_db_cons_religious_affil := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_religious_affil)));
    avelength_db_cons_religious_affil := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_religious_affil)),h.db_cons_religious_affil<>(typeof(h.db_cons_religious_affil))'');
    populated_db_cons_language_pref_cnt := COUNT(GROUP,h.db_cons_language_pref <> (TYPEOF(h.db_cons_language_pref))'');
    populated_db_cons_language_pref_pcnt := AVE(GROUP,IF(h.db_cons_language_pref = (TYPEOF(h.db_cons_language_pref))'',0,100));
    maxlength_db_cons_language_pref := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_language_pref)));
    avelength_db_cons_language_pref := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_language_pref)),h.db_cons_language_pref<>(typeof(h.db_cons_language_pref))'');
    populated_db_cons_phy_addr_std_cnt := COUNT(GROUP,h.db_cons_phy_addr_std <> (TYPEOF(h.db_cons_phy_addr_std))'');
    populated_db_cons_phy_addr_std_pcnt := AVE(GROUP,IF(h.db_cons_phy_addr_std = (TYPEOF(h.db_cons_phy_addr_std))'',0,100));
    maxlength_db_cons_phy_addr_std := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phy_addr_std)));
    avelength_db_cons_phy_addr_std := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phy_addr_std)),h.db_cons_phy_addr_std<>(typeof(h.db_cons_phy_addr_std))'');
    populated_db_cons_phy_addr_city_cnt := COUNT(GROUP,h.db_cons_phy_addr_city <> (TYPEOF(h.db_cons_phy_addr_city))'');
    populated_db_cons_phy_addr_city_pcnt := AVE(GROUP,IF(h.db_cons_phy_addr_city = (TYPEOF(h.db_cons_phy_addr_city))'',0,100));
    maxlength_db_cons_phy_addr_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phy_addr_city)));
    avelength_db_cons_phy_addr_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phy_addr_city)),h.db_cons_phy_addr_city<>(typeof(h.db_cons_phy_addr_city))'');
    populated_db_cons_phy_addr_state_cnt := COUNT(GROUP,h.db_cons_phy_addr_state <> (TYPEOF(h.db_cons_phy_addr_state))'');
    populated_db_cons_phy_addr_state_pcnt := AVE(GROUP,IF(h.db_cons_phy_addr_state = (TYPEOF(h.db_cons_phy_addr_state))'',0,100));
    maxlength_db_cons_phy_addr_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phy_addr_state)));
    avelength_db_cons_phy_addr_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phy_addr_state)),h.db_cons_phy_addr_state<>(typeof(h.db_cons_phy_addr_state))'');
    populated_db_cons_phy_addr_zip_cnt := COUNT(GROUP,h.db_cons_phy_addr_zip <> (TYPEOF(h.db_cons_phy_addr_zip))'');
    populated_db_cons_phy_addr_zip_pcnt := AVE(GROUP,IF(h.db_cons_phy_addr_zip = (TYPEOF(h.db_cons_phy_addr_zip))'',0,100));
    maxlength_db_cons_phy_addr_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phy_addr_zip)));
    avelength_db_cons_phy_addr_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phy_addr_zip)),h.db_cons_phy_addr_zip<>(typeof(h.db_cons_phy_addr_zip))'');
    populated_db_cons_phy_addr_zip4_cnt := COUNT(GROUP,h.db_cons_phy_addr_zip4 <> (TYPEOF(h.db_cons_phy_addr_zip4))'');
    populated_db_cons_phy_addr_zip4_pcnt := AVE(GROUP,IF(h.db_cons_phy_addr_zip4 = (TYPEOF(h.db_cons_phy_addr_zip4))'',0,100));
    maxlength_db_cons_phy_addr_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phy_addr_zip4)));
    avelength_db_cons_phy_addr_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phy_addr_zip4)),h.db_cons_phy_addr_zip4<>(typeof(h.db_cons_phy_addr_zip4))'');
    populated_db_cons_phy_addr_carrierroute_cnt := COUNT(GROUP,h.db_cons_phy_addr_carrierroute <> (TYPEOF(h.db_cons_phy_addr_carrierroute))'');
    populated_db_cons_phy_addr_carrierroute_pcnt := AVE(GROUP,IF(h.db_cons_phy_addr_carrierroute = (TYPEOF(h.db_cons_phy_addr_carrierroute))'',0,100));
    maxlength_db_cons_phy_addr_carrierroute := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phy_addr_carrierroute)));
    avelength_db_cons_phy_addr_carrierroute := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phy_addr_carrierroute)),h.db_cons_phy_addr_carrierroute<>(typeof(h.db_cons_phy_addr_carrierroute))'');
    populated_db_cons_phy_addr_deliverypt_cnt := COUNT(GROUP,h.db_cons_phy_addr_deliverypt <> (TYPEOF(h.db_cons_phy_addr_deliverypt))'');
    populated_db_cons_phy_addr_deliverypt_pcnt := AVE(GROUP,IF(h.db_cons_phy_addr_deliverypt = (TYPEOF(h.db_cons_phy_addr_deliverypt))'',0,100));
    maxlength_db_cons_phy_addr_deliverypt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phy_addr_deliverypt)));
    avelength_db_cons_phy_addr_deliverypt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phy_addr_deliverypt)),h.db_cons_phy_addr_deliverypt<>(typeof(h.db_cons_phy_addr_deliverypt))'');
    populated_db_cons_line_of_travel_cnt := COUNT(GROUP,h.db_cons_line_of_travel <> (TYPEOF(h.db_cons_line_of_travel))'');
    populated_db_cons_line_of_travel_pcnt := AVE(GROUP,IF(h.db_cons_line_of_travel = (TYPEOF(h.db_cons_line_of_travel))'',0,100));
    maxlength_db_cons_line_of_travel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_line_of_travel)));
    avelength_db_cons_line_of_travel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_line_of_travel)),h.db_cons_line_of_travel<>(typeof(h.db_cons_line_of_travel))'');
    populated_db_cons_geocode_results_cnt := COUNT(GROUP,h.db_cons_geocode_results <> (TYPEOF(h.db_cons_geocode_results))'');
    populated_db_cons_geocode_results_pcnt := AVE(GROUP,IF(h.db_cons_geocode_results = (TYPEOF(h.db_cons_geocode_results))'',0,100));
    maxlength_db_cons_geocode_results := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_geocode_results)));
    avelength_db_cons_geocode_results := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_geocode_results)),h.db_cons_geocode_results<>(typeof(h.db_cons_geocode_results))'');
    populated_db_cons_latitude_cnt := COUNT(GROUP,h.db_cons_latitude <> (TYPEOF(h.db_cons_latitude))'');
    populated_db_cons_latitude_pcnt := AVE(GROUP,IF(h.db_cons_latitude = (TYPEOF(h.db_cons_latitude))'',0,100));
    maxlength_db_cons_latitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_latitude)));
    avelength_db_cons_latitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_latitude)),h.db_cons_latitude<>(typeof(h.db_cons_latitude))'');
    populated_db_cons_longitude_cnt := COUNT(GROUP,h.db_cons_longitude <> (TYPEOF(h.db_cons_longitude))'');
    populated_db_cons_longitude_pcnt := AVE(GROUP,IF(h.db_cons_longitude = (TYPEOF(h.db_cons_longitude))'',0,100));
    maxlength_db_cons_longitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_longitude)));
    avelength_db_cons_longitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_longitude)),h.db_cons_longitude<>(typeof(h.db_cons_longitude))'');
    populated_db_cons_time_zone_code_cnt := COUNT(GROUP,h.db_cons_time_zone_code <> (TYPEOF(h.db_cons_time_zone_code))'');
    populated_db_cons_time_zone_code_pcnt := AVE(GROUP,IF(h.db_cons_time_zone_code = (TYPEOF(h.db_cons_time_zone_code))'',0,100));
    maxlength_db_cons_time_zone_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_time_zone_code)));
    avelength_db_cons_time_zone_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_time_zone_code)),h.db_cons_time_zone_code<>(typeof(h.db_cons_time_zone_code))'');
    populated_db_cons_time_zone_desc_cnt := COUNT(GROUP,h.db_cons_time_zone_desc <> (TYPEOF(h.db_cons_time_zone_desc))'');
    populated_db_cons_time_zone_desc_pcnt := AVE(GROUP,IF(h.db_cons_time_zone_desc = (TYPEOF(h.db_cons_time_zone_desc))'',0,100));
    maxlength_db_cons_time_zone_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_time_zone_desc)));
    avelength_db_cons_time_zone_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_time_zone_desc)),h.db_cons_time_zone_desc<>(typeof(h.db_cons_time_zone_desc))'');
    populated_db_cons_census_tract_cnt := COUNT(GROUP,h.db_cons_census_tract <> (TYPEOF(h.db_cons_census_tract))'');
    populated_db_cons_census_tract_pcnt := AVE(GROUP,IF(h.db_cons_census_tract = (TYPEOF(h.db_cons_census_tract))'',0,100));
    maxlength_db_cons_census_tract := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_census_tract)));
    avelength_db_cons_census_tract := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_census_tract)),h.db_cons_census_tract<>(typeof(h.db_cons_census_tract))'');
    populated_db_cons_census_block_cnt := COUNT(GROUP,h.db_cons_census_block <> (TYPEOF(h.db_cons_census_block))'');
    populated_db_cons_census_block_pcnt := AVE(GROUP,IF(h.db_cons_census_block = (TYPEOF(h.db_cons_census_block))'',0,100));
    maxlength_db_cons_census_block := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_census_block)));
    avelength_db_cons_census_block := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_census_block)),h.db_cons_census_block<>(typeof(h.db_cons_census_block))'');
    populated_db_cons_countyfips_cnt := COUNT(GROUP,h.db_cons_countyfips <> (TYPEOF(h.db_cons_countyfips))'');
    populated_db_cons_countyfips_pcnt := AVE(GROUP,IF(h.db_cons_countyfips = (TYPEOF(h.db_cons_countyfips))'',0,100));
    maxlength_db_cons_countyfips := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_countyfips)));
    avelength_db_cons_countyfips := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_countyfips)),h.db_cons_countyfips<>(typeof(h.db_cons_countyfips))'');
    populated_db_countyname_cnt := COUNT(GROUP,h.db_countyname <> (TYPEOF(h.db_countyname))'');
    populated_db_countyname_pcnt := AVE(GROUP,IF(h.db_countyname = (TYPEOF(h.db_countyname))'',0,100));
    maxlength_db_countyname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_countyname)));
    avelength_db_countyname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_countyname)),h.db_countyname<>(typeof(h.db_countyname))'');
    populated_db_cons_cbsa_code_cnt := COUNT(GROUP,h.db_cons_cbsa_code <> (TYPEOF(h.db_cons_cbsa_code))'');
    populated_db_cons_cbsa_code_pcnt := AVE(GROUP,IF(h.db_cons_cbsa_code = (TYPEOF(h.db_cons_cbsa_code))'',0,100));
    maxlength_db_cons_cbsa_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_cbsa_code)));
    avelength_db_cons_cbsa_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_cbsa_code)),h.db_cons_cbsa_code<>(typeof(h.db_cons_cbsa_code))'');
    populated_db_cons_cbsa_desc_cnt := COUNT(GROUP,h.db_cons_cbsa_desc <> (TYPEOF(h.db_cons_cbsa_desc))'');
    populated_db_cons_cbsa_desc_pcnt := AVE(GROUP,IF(h.db_cons_cbsa_desc = (TYPEOF(h.db_cons_cbsa_desc))'',0,100));
    maxlength_db_cons_cbsa_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_cbsa_desc)));
    avelength_db_cons_cbsa_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_cbsa_desc)),h.db_cons_cbsa_desc<>(typeof(h.db_cons_cbsa_desc))'');
    populated_db_cons_walk_sequence_cnt := COUNT(GROUP,h.db_cons_walk_sequence <> (TYPEOF(h.db_cons_walk_sequence))'');
    populated_db_cons_walk_sequence_pcnt := AVE(GROUP,IF(h.db_cons_walk_sequence = (TYPEOF(h.db_cons_walk_sequence))'',0,100));
    maxlength_db_cons_walk_sequence := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_walk_sequence)));
    avelength_db_cons_walk_sequence := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_walk_sequence)),h.db_cons_walk_sequence<>(typeof(h.db_cons_walk_sequence))'');
    populated_db_cons_phone_cnt := COUNT(GROUP,h.db_cons_phone <> (TYPEOF(h.db_cons_phone))'');
    populated_db_cons_phone_pcnt := AVE(GROUP,IF(h.db_cons_phone = (TYPEOF(h.db_cons_phone))'',0,100));
    maxlength_db_cons_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phone)));
    avelength_db_cons_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_phone)),h.db_cons_phone<>(typeof(h.db_cons_phone))'');
    populated_db_cons_dnc_cnt := COUNT(GROUP,h.db_cons_dnc <> (TYPEOF(h.db_cons_dnc))'');
    populated_db_cons_dnc_pcnt := AVE(GROUP,IF(h.db_cons_dnc = (TYPEOF(h.db_cons_dnc))'',0,100));
    maxlength_db_cons_dnc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_dnc)));
    avelength_db_cons_dnc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_dnc)),h.db_cons_dnc<>(typeof(h.db_cons_dnc))'');
    populated_db_cons_scrubbed_phoneable_cnt := COUNT(GROUP,h.db_cons_scrubbed_phoneable <> (TYPEOF(h.db_cons_scrubbed_phoneable))'');
    populated_db_cons_scrubbed_phoneable_pcnt := AVE(GROUP,IF(h.db_cons_scrubbed_phoneable = (TYPEOF(h.db_cons_scrubbed_phoneable))'',0,100));
    maxlength_db_cons_scrubbed_phoneable := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_scrubbed_phoneable)));
    avelength_db_cons_scrubbed_phoneable := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_scrubbed_phoneable)),h.db_cons_scrubbed_phoneable<>(typeof(h.db_cons_scrubbed_phoneable))'');
    populated_db_cons_children_present_cnt := COUNT(GROUP,h.db_cons_children_present <> (TYPEOF(h.db_cons_children_present))'');
    populated_db_cons_children_present_pcnt := AVE(GROUP,IF(h.db_cons_children_present = (TYPEOF(h.db_cons_children_present))'',0,100));
    maxlength_db_cons_children_present := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_children_present)));
    avelength_db_cons_children_present := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_children_present)),h.db_cons_children_present<>(typeof(h.db_cons_children_present))'');
    populated_db_cons_home_value_code_cnt := COUNT(GROUP,h.db_cons_home_value_code <> (TYPEOF(h.db_cons_home_value_code))'');
    populated_db_cons_home_value_code_pcnt := AVE(GROUP,IF(h.db_cons_home_value_code = (TYPEOF(h.db_cons_home_value_code))'',0,100));
    maxlength_db_cons_home_value_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_value_code)));
    avelength_db_cons_home_value_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_value_code)),h.db_cons_home_value_code<>(typeof(h.db_cons_home_value_code))'');
    populated_db_cons_home_value_desc_cnt := COUNT(GROUP,h.db_cons_home_value_desc <> (TYPEOF(h.db_cons_home_value_desc))'');
    populated_db_cons_home_value_desc_pcnt := AVE(GROUP,IF(h.db_cons_home_value_desc = (TYPEOF(h.db_cons_home_value_desc))'',0,100));
    maxlength_db_cons_home_value_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_value_desc)));
    avelength_db_cons_home_value_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_value_desc)),h.db_cons_home_value_desc<>(typeof(h.db_cons_home_value_desc))'');
    populated_db_cons_donor_capacity_cnt := COUNT(GROUP,h.db_cons_donor_capacity <> (TYPEOF(h.db_cons_donor_capacity))'');
    populated_db_cons_donor_capacity_pcnt := AVE(GROUP,IF(h.db_cons_donor_capacity = (TYPEOF(h.db_cons_donor_capacity))'',0,100));
    maxlength_db_cons_donor_capacity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_donor_capacity)));
    avelength_db_cons_donor_capacity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_donor_capacity)),h.db_cons_donor_capacity<>(typeof(h.db_cons_donor_capacity))'');
    populated_db_cons_donor_capacity_code_cnt := COUNT(GROUP,h.db_cons_donor_capacity_code <> (TYPEOF(h.db_cons_donor_capacity_code))'');
    populated_db_cons_donor_capacity_code_pcnt := AVE(GROUP,IF(h.db_cons_donor_capacity_code = (TYPEOF(h.db_cons_donor_capacity_code))'',0,100));
    maxlength_db_cons_donor_capacity_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_donor_capacity_code)));
    avelength_db_cons_donor_capacity_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_donor_capacity_code)),h.db_cons_donor_capacity_code<>(typeof(h.db_cons_donor_capacity_code))'');
    populated_db_cons_donor_capacity_desc_cnt := COUNT(GROUP,h.db_cons_donor_capacity_desc <> (TYPEOF(h.db_cons_donor_capacity_desc))'');
    populated_db_cons_donor_capacity_desc_pcnt := AVE(GROUP,IF(h.db_cons_donor_capacity_desc = (TYPEOF(h.db_cons_donor_capacity_desc))'',0,100));
    maxlength_db_cons_donor_capacity_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_donor_capacity_desc)));
    avelength_db_cons_donor_capacity_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_donor_capacity_desc)),h.db_cons_donor_capacity_desc<>(typeof(h.db_cons_donor_capacity_desc))'');
    populated_db_cons_home_owner_renter_cnt := COUNT(GROUP,h.db_cons_home_owner_renter <> (TYPEOF(h.db_cons_home_owner_renter))'');
    populated_db_cons_home_owner_renter_pcnt := AVE(GROUP,IF(h.db_cons_home_owner_renter = (TYPEOF(h.db_cons_home_owner_renter))'',0,100));
    maxlength_db_cons_home_owner_renter := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_owner_renter)));
    avelength_db_cons_home_owner_renter := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_owner_renter)),h.db_cons_home_owner_renter<>(typeof(h.db_cons_home_owner_renter))'');
    populated_db_cons_length_of_res_cnt := COUNT(GROUP,h.db_cons_length_of_res <> (TYPEOF(h.db_cons_length_of_res))'');
    populated_db_cons_length_of_res_pcnt := AVE(GROUP,IF(h.db_cons_length_of_res = (TYPEOF(h.db_cons_length_of_res))'',0,100));
    maxlength_db_cons_length_of_res := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_length_of_res)));
    avelength_db_cons_length_of_res := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_length_of_res)),h.db_cons_length_of_res<>(typeof(h.db_cons_length_of_res))'');
    populated_db_cons_length_of_res_code_cnt := COUNT(GROUP,h.db_cons_length_of_res_code <> (TYPEOF(h.db_cons_length_of_res_code))'');
    populated_db_cons_length_of_res_code_pcnt := AVE(GROUP,IF(h.db_cons_length_of_res_code = (TYPEOF(h.db_cons_length_of_res_code))'',0,100));
    maxlength_db_cons_length_of_res_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_length_of_res_code)));
    avelength_db_cons_length_of_res_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_length_of_res_code)),h.db_cons_length_of_res_code<>(typeof(h.db_cons_length_of_res_code))'');
    populated_db_cons_length_of_res_desc_cnt := COUNT(GROUP,h.db_cons_length_of_res_desc <> (TYPEOF(h.db_cons_length_of_res_desc))'');
    populated_db_cons_length_of_res_desc_pcnt := AVE(GROUP,IF(h.db_cons_length_of_res_desc = (TYPEOF(h.db_cons_length_of_res_desc))'',0,100));
    maxlength_db_cons_length_of_res_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_length_of_res_desc)));
    avelength_db_cons_length_of_res_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_length_of_res_desc)),h.db_cons_length_of_res_desc<>(typeof(h.db_cons_length_of_res_desc))'');
    populated_db_cons_dwelling_type_cnt := COUNT(GROUP,h.db_cons_dwelling_type <> (TYPEOF(h.db_cons_dwelling_type))'');
    populated_db_cons_dwelling_type_pcnt := AVE(GROUP,IF(h.db_cons_dwelling_type = (TYPEOF(h.db_cons_dwelling_type))'',0,100));
    maxlength_db_cons_dwelling_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_dwelling_type)));
    avelength_db_cons_dwelling_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_dwelling_type)),h.db_cons_dwelling_type<>(typeof(h.db_cons_dwelling_type))'');
    populated_db_cons_recent_home_buyer_cnt := COUNT(GROUP,h.db_cons_recent_home_buyer <> (TYPEOF(h.db_cons_recent_home_buyer))'');
    populated_db_cons_recent_home_buyer_pcnt := AVE(GROUP,IF(h.db_cons_recent_home_buyer = (TYPEOF(h.db_cons_recent_home_buyer))'',0,100));
    maxlength_db_cons_recent_home_buyer := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_recent_home_buyer)));
    avelength_db_cons_recent_home_buyer := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_recent_home_buyer)),h.db_cons_recent_home_buyer<>(typeof(h.db_cons_recent_home_buyer))'');
    populated_db_cons_income_code_cnt := COUNT(GROUP,h.db_cons_income_code <> (TYPEOF(h.db_cons_income_code))'');
    populated_db_cons_income_code_pcnt := AVE(GROUP,IF(h.db_cons_income_code = (TYPEOF(h.db_cons_income_code))'',0,100));
    maxlength_db_cons_income_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_income_code)));
    avelength_db_cons_income_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_income_code)),h.db_cons_income_code<>(typeof(h.db_cons_income_code))'');
    populated_db_cons_income_desc_cnt := COUNT(GROUP,h.db_cons_income_desc <> (TYPEOF(h.db_cons_income_desc))'');
    populated_db_cons_income_desc_pcnt := AVE(GROUP,IF(h.db_cons_income_desc = (TYPEOF(h.db_cons_income_desc))'',0,100));
    maxlength_db_cons_income_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_income_desc)));
    avelength_db_cons_income_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_income_desc)),h.db_cons_income_desc<>(typeof(h.db_cons_income_desc))'');
    populated_db_cons_unsecuredcredcap_cnt := COUNT(GROUP,h.db_cons_unsecuredcredcap <> (TYPEOF(h.db_cons_unsecuredcredcap))'');
    populated_db_cons_unsecuredcredcap_pcnt := AVE(GROUP,IF(h.db_cons_unsecuredcredcap = (TYPEOF(h.db_cons_unsecuredcredcap))'',0,100));
    maxlength_db_cons_unsecuredcredcap := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_unsecuredcredcap)));
    avelength_db_cons_unsecuredcredcap := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_unsecuredcredcap)),h.db_cons_unsecuredcredcap<>(typeof(h.db_cons_unsecuredcredcap))'');
    populated_db_cons_unsecuredcredcapcode_cnt := COUNT(GROUP,h.db_cons_unsecuredcredcapcode <> (TYPEOF(h.db_cons_unsecuredcredcapcode))'');
    populated_db_cons_unsecuredcredcapcode_pcnt := AVE(GROUP,IF(h.db_cons_unsecuredcredcapcode = (TYPEOF(h.db_cons_unsecuredcredcapcode))'',0,100));
    maxlength_db_cons_unsecuredcredcapcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_unsecuredcredcapcode)));
    avelength_db_cons_unsecuredcredcapcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_unsecuredcredcapcode)),h.db_cons_unsecuredcredcapcode<>(typeof(h.db_cons_unsecuredcredcapcode))'');
    populated_db_cons_unsecuredcredcapdesc_cnt := COUNT(GROUP,h.db_cons_unsecuredcredcapdesc <> (TYPEOF(h.db_cons_unsecuredcredcapdesc))'');
    populated_db_cons_unsecuredcredcapdesc_pcnt := AVE(GROUP,IF(h.db_cons_unsecuredcredcapdesc = (TYPEOF(h.db_cons_unsecuredcredcapdesc))'',0,100));
    maxlength_db_cons_unsecuredcredcapdesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_unsecuredcredcapdesc)));
    avelength_db_cons_unsecuredcredcapdesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_unsecuredcredcapdesc)),h.db_cons_unsecuredcredcapdesc<>(typeof(h.db_cons_unsecuredcredcapdesc))'');
    populated_db_cons_networthhomeval_cnt := COUNT(GROUP,h.db_cons_networthhomeval <> (TYPEOF(h.db_cons_networthhomeval))'');
    populated_db_cons_networthhomeval_pcnt := AVE(GROUP,IF(h.db_cons_networthhomeval = (TYPEOF(h.db_cons_networthhomeval))'',0,100));
    maxlength_db_cons_networthhomeval := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_networthhomeval)));
    avelength_db_cons_networthhomeval := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_networthhomeval)),h.db_cons_networthhomeval<>(typeof(h.db_cons_networthhomeval))'');
    populated_db_cons_networthhomevalcode_cnt := COUNT(GROUP,h.db_cons_networthhomevalcode <> (TYPEOF(h.db_cons_networthhomevalcode))'');
    populated_db_cons_networthhomevalcode_pcnt := AVE(GROUP,IF(h.db_cons_networthhomevalcode = (TYPEOF(h.db_cons_networthhomevalcode))'',0,100));
    maxlength_db_cons_networthhomevalcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_networthhomevalcode)));
    avelength_db_cons_networthhomevalcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_networthhomevalcode)),h.db_cons_networthhomevalcode<>(typeof(h.db_cons_networthhomevalcode))'');
    populated_db_cons_net_worth_desc_cnt := COUNT(GROUP,h.db_cons_net_worth_desc <> (TYPEOF(h.db_cons_net_worth_desc))'');
    populated_db_cons_net_worth_desc_pcnt := AVE(GROUP,IF(h.db_cons_net_worth_desc = (TYPEOF(h.db_cons_net_worth_desc))'',0,100));
    maxlength_db_cons_net_worth_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_net_worth_desc)));
    avelength_db_cons_net_worth_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_net_worth_desc)),h.db_cons_net_worth_desc<>(typeof(h.db_cons_net_worth_desc))'');
    populated_db_cons_discretincome_cnt := COUNT(GROUP,h.db_cons_discretincome <> (TYPEOF(h.db_cons_discretincome))'');
    populated_db_cons_discretincome_pcnt := AVE(GROUP,IF(h.db_cons_discretincome = (TYPEOF(h.db_cons_discretincome))'',0,100));
    maxlength_db_cons_discretincome := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_discretincome)));
    avelength_db_cons_discretincome := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_discretincome)),h.db_cons_discretincome<>(typeof(h.db_cons_discretincome))'');
    populated_db_cons_discretincomecode_cnt := COUNT(GROUP,h.db_cons_discretincomecode <> (TYPEOF(h.db_cons_discretincomecode))'');
    populated_db_cons_discretincomecode_pcnt := AVE(GROUP,IF(h.db_cons_discretincomecode = (TYPEOF(h.db_cons_discretincomecode))'',0,100));
    maxlength_db_cons_discretincomecode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_discretincomecode)));
    avelength_db_cons_discretincomecode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_discretincomecode)),h.db_cons_discretincomecode<>(typeof(h.db_cons_discretincomecode))'');
    populated_db_cons_discretincomedesc_cnt := COUNT(GROUP,h.db_cons_discretincomedesc <> (TYPEOF(h.db_cons_discretincomedesc))'');
    populated_db_cons_discretincomedesc_pcnt := AVE(GROUP,IF(h.db_cons_discretincomedesc = (TYPEOF(h.db_cons_discretincomedesc))'',0,100));
    maxlength_db_cons_discretincomedesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_discretincomedesc)));
    avelength_db_cons_discretincomedesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_discretincomedesc)),h.db_cons_discretincomedesc<>(typeof(h.db_cons_discretincomedesc))'');
    populated_db_cons_marital_status_cnt := COUNT(GROUP,h.db_cons_marital_status <> (TYPEOF(h.db_cons_marital_status))'');
    populated_db_cons_marital_status_pcnt := AVE(GROUP,IF(h.db_cons_marital_status = (TYPEOF(h.db_cons_marital_status))'',0,100));
    maxlength_db_cons_marital_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_marital_status)));
    avelength_db_cons_marital_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_marital_status)),h.db_cons_marital_status<>(typeof(h.db_cons_marital_status))'');
    populated_db_cons_new_parent_cnt := COUNT(GROUP,h.db_cons_new_parent <> (TYPEOF(h.db_cons_new_parent))'');
    populated_db_cons_new_parent_pcnt := AVE(GROUP,IF(h.db_cons_new_parent = (TYPEOF(h.db_cons_new_parent))'',0,100));
    maxlength_db_cons_new_parent := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_new_parent)));
    avelength_db_cons_new_parent := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_new_parent)),h.db_cons_new_parent<>(typeof(h.db_cons_new_parent))'');
    populated_db_cons_child_near_hs_grad_cnt := COUNT(GROUP,h.db_cons_child_near_hs_grad <> (TYPEOF(h.db_cons_child_near_hs_grad))'');
    populated_db_cons_child_near_hs_grad_pcnt := AVE(GROUP,IF(h.db_cons_child_near_hs_grad = (TYPEOF(h.db_cons_child_near_hs_grad))'',0,100));
    maxlength_db_cons_child_near_hs_grad := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_child_near_hs_grad)));
    avelength_db_cons_child_near_hs_grad := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_child_near_hs_grad)),h.db_cons_child_near_hs_grad<>(typeof(h.db_cons_child_near_hs_grad))'');
    populated_db_cons_college_graduate_cnt := COUNT(GROUP,h.db_cons_college_graduate <> (TYPEOF(h.db_cons_college_graduate))'');
    populated_db_cons_college_graduate_pcnt := AVE(GROUP,IF(h.db_cons_college_graduate = (TYPEOF(h.db_cons_college_graduate))'',0,100));
    maxlength_db_cons_college_graduate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_college_graduate)));
    avelength_db_cons_college_graduate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_college_graduate)),h.db_cons_college_graduate<>(typeof(h.db_cons_college_graduate))'');
    populated_db_cons_intend_purchase_veh_cnt := COUNT(GROUP,h.db_cons_intend_purchase_veh <> (TYPEOF(h.db_cons_intend_purchase_veh))'');
    populated_db_cons_intend_purchase_veh_pcnt := AVE(GROUP,IF(h.db_cons_intend_purchase_veh = (TYPEOF(h.db_cons_intend_purchase_veh))'',0,100));
    maxlength_db_cons_intend_purchase_veh := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_intend_purchase_veh)));
    avelength_db_cons_intend_purchase_veh := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_intend_purchase_veh)),h.db_cons_intend_purchase_veh<>(typeof(h.db_cons_intend_purchase_veh))'');
    populated_db_cons_recent_divorce_cnt := COUNT(GROUP,h.db_cons_recent_divorce <> (TYPEOF(h.db_cons_recent_divorce))'');
    populated_db_cons_recent_divorce_pcnt := AVE(GROUP,IF(h.db_cons_recent_divorce = (TYPEOF(h.db_cons_recent_divorce))'',0,100));
    maxlength_db_cons_recent_divorce := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_recent_divorce)));
    avelength_db_cons_recent_divorce := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_recent_divorce)),h.db_cons_recent_divorce<>(typeof(h.db_cons_recent_divorce))'');
    populated_db_cons_newlywed_cnt := COUNT(GROUP,h.db_cons_newlywed <> (TYPEOF(h.db_cons_newlywed))'');
    populated_db_cons_newlywed_pcnt := AVE(GROUP,IF(h.db_cons_newlywed = (TYPEOF(h.db_cons_newlywed))'',0,100));
    maxlength_db_cons_newlywed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_newlywed)));
    avelength_db_cons_newlywed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_newlywed)),h.db_cons_newlywed<>(typeof(h.db_cons_newlywed))'');
    populated_db_cons_new_teen_driver_cnt := COUNT(GROUP,h.db_cons_new_teen_driver <> (TYPEOF(h.db_cons_new_teen_driver))'');
    populated_db_cons_new_teen_driver_pcnt := AVE(GROUP,IF(h.db_cons_new_teen_driver = (TYPEOF(h.db_cons_new_teen_driver))'',0,100));
    maxlength_db_cons_new_teen_driver := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_new_teen_driver)));
    avelength_db_cons_new_teen_driver := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_new_teen_driver)),h.db_cons_new_teen_driver<>(typeof(h.db_cons_new_teen_driver))'');
    populated_db_cons_home_year_built_cnt := COUNT(GROUP,h.db_cons_home_year_built <> (TYPEOF(h.db_cons_home_year_built))'');
    populated_db_cons_home_year_built_pcnt := AVE(GROUP,IF(h.db_cons_home_year_built = (TYPEOF(h.db_cons_home_year_built))'',0,100));
    maxlength_db_cons_home_year_built := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_year_built)));
    avelength_db_cons_home_year_built := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_year_built)),h.db_cons_home_year_built<>(typeof(h.db_cons_home_year_built))'');
    populated_db_cons_home_sqft_ranges_cnt := COUNT(GROUP,h.db_cons_home_sqft_ranges <> (TYPEOF(h.db_cons_home_sqft_ranges))'');
    populated_db_cons_home_sqft_ranges_pcnt := AVE(GROUP,IF(h.db_cons_home_sqft_ranges = (TYPEOF(h.db_cons_home_sqft_ranges))'',0,100));
    maxlength_db_cons_home_sqft_ranges := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_sqft_ranges)));
    avelength_db_cons_home_sqft_ranges := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_sqft_ranges)),h.db_cons_home_sqft_ranges<>(typeof(h.db_cons_home_sqft_ranges))'');
    populated_db_cons_poli_party_ind_cnt := COUNT(GROUP,h.db_cons_poli_party_ind <> (TYPEOF(h.db_cons_poli_party_ind))'');
    populated_db_cons_poli_party_ind_pcnt := AVE(GROUP,IF(h.db_cons_poli_party_ind = (TYPEOF(h.db_cons_poli_party_ind))'',0,100));
    maxlength_db_cons_poli_party_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_poli_party_ind)));
    avelength_db_cons_poli_party_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_poli_party_ind)),h.db_cons_poli_party_ind<>(typeof(h.db_cons_poli_party_ind))'');
    populated_db_cons_home_sqft_actual_cnt := COUNT(GROUP,h.db_cons_home_sqft_actual <> (TYPEOF(h.db_cons_home_sqft_actual))'');
    populated_db_cons_home_sqft_actual_pcnt := AVE(GROUP,IF(h.db_cons_home_sqft_actual = (TYPEOF(h.db_cons_home_sqft_actual))'',0,100));
    maxlength_db_cons_home_sqft_actual := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_sqft_actual)));
    avelength_db_cons_home_sqft_actual := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_sqft_actual)),h.db_cons_home_sqft_actual<>(typeof(h.db_cons_home_sqft_actual))'');
    populated_db_cons_occupation_ind_cnt := COUNT(GROUP,h.db_cons_occupation_ind <> (TYPEOF(h.db_cons_occupation_ind))'');
    populated_db_cons_occupation_ind_pcnt := AVE(GROUP,IF(h.db_cons_occupation_ind = (TYPEOF(h.db_cons_occupation_ind))'',0,100));
    maxlength_db_cons_occupation_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_occupation_ind)));
    avelength_db_cons_occupation_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_occupation_ind)),h.db_cons_occupation_ind<>(typeof(h.db_cons_occupation_ind))'');
    populated_db_cons_credit_card_user_cnt := COUNT(GROUP,h.db_cons_credit_card_user <> (TYPEOF(h.db_cons_credit_card_user))'');
    populated_db_cons_credit_card_user_pcnt := AVE(GROUP,IF(h.db_cons_credit_card_user = (TYPEOF(h.db_cons_credit_card_user))'',0,100));
    maxlength_db_cons_credit_card_user := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_credit_card_user)));
    avelength_db_cons_credit_card_user := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_credit_card_user)),h.db_cons_credit_card_user<>(typeof(h.db_cons_credit_card_user))'');
    populated_db_cons_home_property_type_cnt := COUNT(GROUP,h.db_cons_home_property_type <> (TYPEOF(h.db_cons_home_property_type))'');
    populated_db_cons_home_property_type_pcnt := AVE(GROUP,IF(h.db_cons_home_property_type = (TYPEOF(h.db_cons_home_property_type))'',0,100));
    maxlength_db_cons_home_property_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_property_type)));
    avelength_db_cons_home_property_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_home_property_type)),h.db_cons_home_property_type<>(typeof(h.db_cons_home_property_type))'');
    populated_db_cons_education_hh_cnt := COUNT(GROUP,h.db_cons_education_hh <> (TYPEOF(h.db_cons_education_hh))'');
    populated_db_cons_education_hh_pcnt := AVE(GROUP,IF(h.db_cons_education_hh = (TYPEOF(h.db_cons_education_hh))'',0,100));
    maxlength_db_cons_education_hh := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_education_hh)));
    avelength_db_cons_education_hh := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_education_hh)),h.db_cons_education_hh<>(typeof(h.db_cons_education_hh))'');
    populated_db_cons_education_ind_cnt := COUNT(GROUP,h.db_cons_education_ind <> (TYPEOF(h.db_cons_education_ind))'');
    populated_db_cons_education_ind_pcnt := AVE(GROUP,IF(h.db_cons_education_ind = (TYPEOF(h.db_cons_education_ind))'',0,100));
    maxlength_db_cons_education_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_education_ind)));
    avelength_db_cons_education_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_education_ind)),h.db_cons_education_ind<>(typeof(h.db_cons_education_ind))'');
    populated_db_cons_other_pet_owner_cnt := COUNT(GROUP,h.db_cons_other_pet_owner <> (TYPEOF(h.db_cons_other_pet_owner))'');
    populated_db_cons_other_pet_owner_pcnt := AVE(GROUP,IF(h.db_cons_other_pet_owner = (TYPEOF(h.db_cons_other_pet_owner))'',0,100));
    maxlength_db_cons_other_pet_owner := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_other_pet_owner)));
    avelength_db_cons_other_pet_owner := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.db_cons_other_pet_owner)),h.db_cons_other_pet_owner<>(typeof(h.db_cons_other_pet_owner))'');
    populated_businesstypedesc_cnt := COUNT(GROUP,h.businesstypedesc <> (TYPEOF(h.businesstypedesc))'');
    populated_businesstypedesc_pcnt := AVE(GROUP,IF(h.businesstypedesc = (TYPEOF(h.businesstypedesc))'',0,100));
    maxlength_businesstypedesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesstypedesc)));
    avelength_businesstypedesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.businesstypedesc)),h.businesstypedesc<>(typeof(h.businesstypedesc))'');
    populated_genderdesc_cnt := COUNT(GROUP,h.genderdesc <> (TYPEOF(h.genderdesc))'');
    populated_genderdesc_pcnt := AVE(GROUP,IF(h.genderdesc = (TYPEOF(h.genderdesc))'',0,100));
    maxlength_genderdesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.genderdesc)));
    avelength_genderdesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.genderdesc)),h.genderdesc<>(typeof(h.genderdesc))'');
    populated_executivetypedesc_cnt := COUNT(GROUP,h.executivetypedesc <> (TYPEOF(h.executivetypedesc))'');
    populated_executivetypedesc_pcnt := AVE(GROUP,IF(h.executivetypedesc = (TYPEOF(h.executivetypedesc))'',0,100));
    maxlength_executivetypedesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.executivetypedesc)));
    avelength_executivetypedesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.executivetypedesc)),h.executivetypedesc<>(typeof(h.executivetypedesc))'');
    populated_dbconsgenderdesc_cnt := COUNT(GROUP,h.dbconsgenderdesc <> (TYPEOF(h.dbconsgenderdesc))'');
    populated_dbconsgenderdesc_pcnt := AVE(GROUP,IF(h.dbconsgenderdesc = (TYPEOF(h.dbconsgenderdesc))'',0,100));
    maxlength_dbconsgenderdesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsgenderdesc)));
    avelength_dbconsgenderdesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsgenderdesc)),h.dbconsgenderdesc<>(typeof(h.dbconsgenderdesc))'');
    populated_dbconsethnicdesc_cnt := COUNT(GROUP,h.dbconsethnicdesc <> (TYPEOF(h.dbconsethnicdesc))'');
    populated_dbconsethnicdesc_pcnt := AVE(GROUP,IF(h.dbconsethnicdesc = (TYPEOF(h.dbconsethnicdesc))'',0,100));
    maxlength_dbconsethnicdesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsethnicdesc)));
    avelength_dbconsethnicdesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsethnicdesc)),h.dbconsethnicdesc<>(typeof(h.dbconsethnicdesc))'');
    populated_dbconsreligiousdesc_cnt := COUNT(GROUP,h.dbconsreligiousdesc <> (TYPEOF(h.dbconsreligiousdesc))'');
    populated_dbconsreligiousdesc_pcnt := AVE(GROUP,IF(h.dbconsreligiousdesc = (TYPEOF(h.dbconsreligiousdesc))'',0,100));
    maxlength_dbconsreligiousdesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsreligiousdesc)));
    avelength_dbconsreligiousdesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsreligiousdesc)),h.dbconsreligiousdesc<>(typeof(h.dbconsreligiousdesc))'');
    populated_dbconslangprefdesc_cnt := COUNT(GROUP,h.dbconslangprefdesc <> (TYPEOF(h.dbconslangprefdesc))'');
    populated_dbconslangprefdesc_pcnt := AVE(GROUP,IF(h.dbconslangprefdesc = (TYPEOF(h.dbconslangprefdesc))'',0,100));
    maxlength_dbconslangprefdesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconslangprefdesc)));
    avelength_dbconslangprefdesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconslangprefdesc)),h.dbconslangprefdesc<>(typeof(h.dbconslangprefdesc))'');
    populated_dbconsownerrenter_cnt := COUNT(GROUP,h.dbconsownerrenter <> (TYPEOF(h.dbconsownerrenter))'');
    populated_dbconsownerrenter_pcnt := AVE(GROUP,IF(h.dbconsownerrenter = (TYPEOF(h.dbconsownerrenter))'',0,100));
    maxlength_dbconsownerrenter := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsownerrenter)));
    avelength_dbconsownerrenter := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsownerrenter)),h.dbconsownerrenter<>(typeof(h.dbconsownerrenter))'');
    populated_dbconsdwellingtypedesc_cnt := COUNT(GROUP,h.dbconsdwellingtypedesc <> (TYPEOF(h.dbconsdwellingtypedesc))'');
    populated_dbconsdwellingtypedesc_pcnt := AVE(GROUP,IF(h.dbconsdwellingtypedesc = (TYPEOF(h.dbconsdwellingtypedesc))'',0,100));
    maxlength_dbconsdwellingtypedesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsdwellingtypedesc)));
    avelength_dbconsdwellingtypedesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsdwellingtypedesc)),h.dbconsdwellingtypedesc<>(typeof(h.dbconsdwellingtypedesc))'');
    populated_dbconsmaritaldesc_cnt := COUNT(GROUP,h.dbconsmaritaldesc <> (TYPEOF(h.dbconsmaritaldesc))'');
    populated_dbconsmaritaldesc_pcnt := AVE(GROUP,IF(h.dbconsmaritaldesc = (TYPEOF(h.dbconsmaritaldesc))'',0,100));
    maxlength_dbconsmaritaldesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsmaritaldesc)));
    avelength_dbconsmaritaldesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsmaritaldesc)),h.dbconsmaritaldesc<>(typeof(h.dbconsmaritaldesc))'');
    populated_dbconsnewparentdesc_cnt := COUNT(GROUP,h.dbconsnewparentdesc <> (TYPEOF(h.dbconsnewparentdesc))'');
    populated_dbconsnewparentdesc_pcnt := AVE(GROUP,IF(h.dbconsnewparentdesc = (TYPEOF(h.dbconsnewparentdesc))'',0,100));
    maxlength_dbconsnewparentdesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsnewparentdesc)));
    avelength_dbconsnewparentdesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsnewparentdesc)),h.dbconsnewparentdesc<>(typeof(h.dbconsnewparentdesc))'');
    populated_dbconsteendriverdesc_cnt := COUNT(GROUP,h.dbconsteendriverdesc <> (TYPEOF(h.dbconsteendriverdesc))'');
    populated_dbconsteendriverdesc_pcnt := AVE(GROUP,IF(h.dbconsteendriverdesc = (TYPEOF(h.dbconsteendriverdesc))'',0,100));
    maxlength_dbconsteendriverdesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsteendriverdesc)));
    avelength_dbconsteendriverdesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsteendriverdesc)),h.dbconsteendriverdesc<>(typeof(h.dbconsteendriverdesc))'');
    populated_dbconspolipartydesc_cnt := COUNT(GROUP,h.dbconspolipartydesc <> (TYPEOF(h.dbconspolipartydesc))'');
    populated_dbconspolipartydesc_pcnt := AVE(GROUP,IF(h.dbconspolipartydesc = (TYPEOF(h.dbconspolipartydesc))'',0,100));
    maxlength_dbconspolipartydesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconspolipartydesc)));
    avelength_dbconspolipartydesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconspolipartydesc)),h.dbconspolipartydesc<>(typeof(h.dbconspolipartydesc))'');
    populated_dbconsoccupationdesc_cnt := COUNT(GROUP,h.dbconsoccupationdesc <> (TYPEOF(h.dbconsoccupationdesc))'');
    populated_dbconsoccupationdesc_pcnt := AVE(GROUP,IF(h.dbconsoccupationdesc = (TYPEOF(h.dbconsoccupationdesc))'',0,100));
    maxlength_dbconsoccupationdesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsoccupationdesc)));
    avelength_dbconsoccupationdesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsoccupationdesc)),h.dbconsoccupationdesc<>(typeof(h.dbconsoccupationdesc))'');
    populated_dbconspropertytypedesc_cnt := COUNT(GROUP,h.dbconspropertytypedesc <> (TYPEOF(h.dbconspropertytypedesc))'');
    populated_dbconspropertytypedesc_pcnt := AVE(GROUP,IF(h.dbconspropertytypedesc = (TYPEOF(h.dbconspropertytypedesc))'',0,100));
    maxlength_dbconspropertytypedesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconspropertytypedesc)));
    avelength_dbconspropertytypedesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconspropertytypedesc)),h.dbconspropertytypedesc<>(typeof(h.dbconspropertytypedesc))'');
    populated_dbconsheadhouseeducdesc_cnt := COUNT(GROUP,h.dbconsheadhouseeducdesc <> (TYPEOF(h.dbconsheadhouseeducdesc))'');
    populated_dbconsheadhouseeducdesc_pcnt := AVE(GROUP,IF(h.dbconsheadhouseeducdesc = (TYPEOF(h.dbconsheadhouseeducdesc))'',0,100));
    maxlength_dbconsheadhouseeducdesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsheadhouseeducdesc)));
    avelength_dbconsheadhouseeducdesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconsheadhouseeducdesc)),h.dbconsheadhouseeducdesc<>(typeof(h.dbconsheadhouseeducdesc))'');
    populated_dbconseducationdesc_cnt := COUNT(GROUP,h.dbconseducationdesc <> (TYPEOF(h.dbconseducationdesc))'');
    populated_dbconseducationdesc_pcnt := AVE(GROUP,IF(h.dbconseducationdesc = (TYPEOF(h.dbconseducationdesc))'',0,100));
    maxlength_dbconseducationdesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconseducationdesc)));
    avelength_dbconseducationdesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbconseducationdesc)),h.dbconseducationdesc<>(typeof(h.dbconseducationdesc))'');
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
    populated_name_score_cnt := COUNT(GROUP,h.name_score <> (TYPEOF(h.name_score))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
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
    populated_prep_address_line1_cnt := COUNT(GROUP,h.prep_address_line1 <> (TYPEOF(h.prep_address_line1))'');
    populated_prep_address_line1_pcnt := AVE(GROUP,IF(h.prep_address_line1 = (TYPEOF(h.prep_address_line1))'',0,100));
    maxlength_prep_address_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_address_line1)));
    avelength_prep_address_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_address_line1)),h.prep_address_line1<>(typeof(h.prep_address_line1))'');
    populated_prep_address_line_last_cnt := COUNT(GROUP,h.prep_address_line_last <> (TYPEOF(h.prep_address_line_last))'');
    populated_prep_address_line_last_pcnt := AVE(GROUP,IF(h.prep_address_line_last = (TYPEOF(h.prep_address_line_last))'',0,100));
    maxlength_prep_address_line_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_address_line_last)));
    avelength_prep_address_line_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_address_line_last)),h.prep_address_line_last<>(typeof(h.prep_address_line_last))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_global_sid_pcnt *   0.00 / 100 + T.Populated_dbusa_business_id_pcnt *   0.00 / 100 + T.Populated_dbusa_executive_id_pcnt *   0.00 / 100 + T.Populated_subhq_parent_id_pcnt *   0.00 / 100 + T.Populated_hq_id_pcnt *   0.00 / 100 + T.Populated_ind_frm_indicator_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_full_name_pcnt *   0.00 / 100 + T.Populated_prefix_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_initial_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_standardized_title_pcnt *   0.00 / 100 + T.Populated_sourcetitle_pcnt *   0.00 / 100 + T.Populated_executive_title_rank_pcnt *   0.00 / 100 + T.Populated_primary_exec_flag_pcnt *   0.00 / 100 + T.Populated_exec_type_pcnt *   0.00 / 100 + T.Populated_executive_department_pcnt *   0.00 / 100 + T.Populated_executive_level_pcnt *   0.00 / 100 + T.Populated_phy_addr_standardized_pcnt *   0.00 / 100 + T.Populated_phy_addr_city_pcnt *   0.00 / 100 + T.Populated_phy_addr_state_pcnt *   0.00 / 100 + T.Populated_phy_addr_zip_pcnt *   0.00 / 100 + T.Populated_phy_addr_zip4_pcnt *   0.00 / 100 + T.Populated_phy_addr_carrierroute_pcnt *   0.00 / 100 + T.Populated_phy_addr_deliverypt_pcnt *   0.00 / 100 + T.Populated_phy_addr_deliveryptchkdig_pcnt *   0.00 / 100 + T.Populated_mail_addr_standardized_pcnt *   0.00 / 100 + T.Populated_mail_addr_city_pcnt *   0.00 / 100 + T.Populated_mail_addr_state_pcnt *   0.00 / 100 + T.Populated_mail_addr_zip_pcnt *   0.00 / 100 + T.Populated_mail_addr_zip4_pcnt *   0.00 / 100 + T.Populated_mail_addr_carrierroute_pcnt *   0.00 / 100 + T.Populated_mail_addr_deliverypt_pcnt *   0.00 / 100 + T.Populated_mail_addr_deliveryptchkdig_pcnt *   0.00 / 100 + T.Populated_mail_score_pcnt *   0.00 / 100 + T.Populated_mail_score_desc_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_area_code_pcnt *   0.00 / 100 + T.Populated_fax_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_email_available_indicator_pcnt *   0.00 / 100 + T.Populated_url_pcnt *   0.00 / 100 + T.Populated_url_facebook_pcnt *   0.00 / 100 + T.Populated_url_googleplus_pcnt *   0.00 / 100 + T.Populated_url_instagram_pcnt *   0.00 / 100 + T.Populated_url_linkedin_pcnt *   0.00 / 100 + T.Populated_url_twitter_pcnt *   0.00 / 100 + T.Populated_url_youtube_pcnt *   0.00 / 100 + T.Populated_business_status_code_pcnt *   0.00 / 100 + T.Populated_business_status_desc_pcnt *   0.00 / 100 + T.Populated_franchise_flag_pcnt *   0.00 / 100 + T.Populated_franchise_type_pcnt *   0.00 / 100 + T.Populated_franchise_desc_pcnt *   0.00 / 100 + T.Populated_ticker_symbol_pcnt *   0.00 / 100 + T.Populated_stock_exchange_pcnt *   0.00 / 100 + T.Populated_fortune_1000_flag_pcnt *   0.00 / 100 + T.Populated_fortune_1000_rank_pcnt *   0.00 / 100 + T.Populated_fortune_1000_branches_pcnt *   0.00 / 100 + T.Populated_num_linked_locations_pcnt *   0.00 / 100 + T.Populated_county_code_pcnt *   0.00 / 100 + T.Populated_county_desc_pcnt *   0.00 / 100 + T.Populated_cbsa_code_pcnt *   0.00 / 100 + T.Populated_cbsa_desc_pcnt *   0.00 / 100 + T.Populated_geo_match_level_pcnt *   0.00 / 100 + T.Populated_latitude_pcnt *   0.00 / 100 + T.Populated_longitude_pcnt *   0.00 / 100 + T.Populated_scf_pcnt *   0.00 / 100 + T.Populated_timezone_pcnt *   0.00 / 100 + T.Populated_censustract_pcnt *   0.00 / 100 + T.Populated_censusblock_pcnt *   0.00 / 100 + T.Populated_city_population_code_pcnt *   0.00 / 100 + T.Populated_city_population_descr_pcnt *   0.00 / 100 + T.Populated_primary_sic_pcnt *   0.00 / 100 + T.Populated_primary_sic_desc_pcnt *   0.00 / 100 + T.Populated_sic02_pcnt *   0.00 / 100 + T.Populated_sic02_desc_pcnt *   0.00 / 100 + T.Populated_sic03_pcnt *   0.00 / 100 + T.Populated_sic03_desc_pcnt *   0.00 / 100 + T.Populated_sic04_pcnt *   0.00 / 100 + T.Populated_sic04_desc_pcnt *   0.00 / 100 + T.Populated_sic05_pcnt *   0.00 / 100 + T.Populated_sic05_desc_pcnt *   0.00 / 100 + T.Populated_sic06_pcnt *   0.00 / 100 + T.Populated_sic06_desc_pcnt *   0.00 / 100 + T.Populated_primarysic2_pcnt *   0.00 / 100 + T.Populated_primary_2_digit_sic_desc_pcnt *   0.00 / 100 + T.Populated_primarysic4_pcnt *   0.00 / 100 + T.Populated_primary_4_digit_sic_desc_pcnt *   0.00 / 100 + T.Populated_naics01_pcnt *   0.00 / 100 + T.Populated_naics01_desc_pcnt *   0.00 / 100 + T.Populated_naics02_pcnt *   0.00 / 100 + T.Populated_naics02_desc_pcnt *   0.00 / 100 + T.Populated_naics03_pcnt *   0.00 / 100 + T.Populated_naics03_desc_pcnt *   0.00 / 100 + T.Populated_naics04_pcnt *   0.00 / 100 + T.Populated_naics04_desc_pcnt *   0.00 / 100 + T.Populated_naics05_pcnt *   0.00 / 100 + T.Populated_naics05_desc_pcnt *   0.00 / 100 + T.Populated_naics06_pcnt *   0.00 / 100 + T.Populated_naics06_desc_pcnt *   0.00 / 100 + T.Populated_location_employees_total_pcnt *   0.00 / 100 + T.Populated_location_employee_code_pcnt *   0.00 / 100 + T.Populated_location_employee_desc_pcnt *   0.00 / 100 + T.Populated_location_sales_total_pcnt *   0.00 / 100 + T.Populated_location_sales_code_pcnt *   0.00 / 100 + T.Populated_location_sales_desc_pcnt *   0.00 / 100 + T.Populated_corporate_employee_total_pcnt *   0.00 / 100 + T.Populated_corporate_employee_code_pcnt *   0.00 / 100 + T.Populated_corporate_employee_desc_pcnt *   0.00 / 100 + T.Populated_year_established_pcnt *   0.00 / 100 + T.Populated_years_in_business_range_pcnt *   0.00 / 100 + T.Populated_female_owned_pcnt *   0.00 / 100 + T.Populated_minority_owned_flag_pcnt *   0.00 / 100 + T.Populated_minority_type_pcnt *   0.00 / 100 + T.Populated_home_based_indicator_pcnt *   0.00 / 100 + T.Populated_small_business_indicator_pcnt *   0.00 / 100 + T.Populated_import_export_pcnt *   0.00 / 100 + T.Populated_manufacturing_location_pcnt *   0.00 / 100 + T.Populated_public_indicator_pcnt *   0.00 / 100 + T.Populated_ein_pcnt *   0.00 / 100 + T.Populated_non_profit_org_pcnt *   0.00 / 100 + T.Populated_square_footage_pcnt *   0.00 / 100 + T.Populated_square_footage_code_pcnt *   0.00 / 100 + T.Populated_square_footage_desc_pcnt *   0.00 / 100 + T.Populated_creditscore_pcnt *   0.00 / 100 + T.Populated_creditcode_pcnt *   0.00 / 100 + T.Populated_credit_desc_pcnt *   0.00 / 100 + T.Populated_credit_capacity_pcnt *   0.00 / 100 + T.Populated_credit_capacity_code_pcnt *   0.00 / 100 + T.Populated_credit_capacity_desc_pcnt *   0.00 / 100 + T.Populated_advertising_expenses_code_pcnt *   0.00 / 100 + T.Populated_expense_advertising_desc_pcnt *   0.00 / 100 + T.Populated_technology_expenses_code_pcnt *   0.00 / 100 + T.Populated_expense_technology_desc_pcnt *   0.00 / 100 + T.Populated_office_equip_expenses_code_pcnt *   0.00 / 100 + T.Populated_expense_office_equip_desc_pcnt *   0.00 / 100 + T.Populated_rent_expenses_code_pcnt *   0.00 / 100 + T.Populated_expense_rent_desc_pcnt *   0.00 / 100 + T.Populated_telecom_expenses_code_pcnt *   0.00 / 100 + T.Populated_expense_telecom_desc_pcnt *   0.00 / 100 + T.Populated_accounting_expenses_code_pcnt *   0.00 / 100 + T.Populated_expense_accounting_desc_pcnt *   0.00 / 100 + T.Populated_bus_insurance_expense_code_pcnt *   0.00 / 100 + T.Populated_expense_bus_insurance_desc_pcnt *   0.00 / 100 + T.Populated_legal_expenses_code_pcnt *   0.00 / 100 + T.Populated_expense_legal_desc_pcnt *   0.00 / 100 + T.Populated_utilities_expenses_code_pcnt *   0.00 / 100 + T.Populated_expense_utilities_desc_pcnt *   0.00 / 100 + T.Populated_number_of_pcs_code_pcnt *   0.00 / 100 + T.Populated_number_of_pcs_desc_pcnt *   0.00 / 100 + T.Populated_nb_flag_pcnt *   0.00 / 100 + T.Populated_hq_company_name_pcnt *   0.00 / 100 + T.Populated_hq_city_pcnt *   0.00 / 100 + T.Populated_hq_state_pcnt *   0.00 / 100 + T.Populated_subhq_parent_name_pcnt *   0.00 / 100 + T.Populated_subhq_parent_city_pcnt *   0.00 / 100 + T.Populated_subhq_parent_state_pcnt *   0.00 / 100 + T.Populated_domestic_foreign_owner_flag_pcnt *   0.00 / 100 + T.Populated_foreign_parent_company_name_pcnt *   0.00 / 100 + T.Populated_foreign_parent_city_pcnt *   0.00 / 100 + T.Populated_foreign_parent_country_pcnt *   0.00 / 100 + T.Populated_db_cons_matchkey_pcnt *   0.00 / 100 + T.Populated_databaseusa_individual_id_pcnt *   0.00 / 100 + T.Populated_db_cons_full_name_pcnt *   0.00 / 100 + T.Populated_db_cons_full_name_prefix_pcnt *   0.00 / 100 + T.Populated_db_cons_first_name_pcnt *   0.00 / 100 + T.Populated_db_cons_middle_initial_pcnt *   0.00 / 100 + T.Populated_db_cons_last_name_pcnt *   0.00 / 100 + T.Populated_db_cons_email_pcnt *   0.00 / 100 + T.Populated_db_cons_gender_pcnt *   0.00 / 100 + T.Populated_db_cons_date_of_birth_year_pcnt *   0.00 / 100 + T.Populated_db_cons_date_of_birth_month_pcnt *   0.00 / 100 + T.Populated_db_cons_age_pcnt *   0.00 / 100 + T.Populated_db_cons_age_code_desc_pcnt *   0.00 / 100 + T.Populated_db_cons_age_in_two_year_hh_pcnt *   0.00 / 100 + T.Populated_db_cons_ethnic_code_pcnt *   0.00 / 100 + T.Populated_db_cons_religious_affil_pcnt *   0.00 / 100 + T.Populated_db_cons_language_pref_pcnt *   0.00 / 100 + T.Populated_db_cons_phy_addr_std_pcnt *   0.00 / 100 + T.Populated_db_cons_phy_addr_city_pcnt *   0.00 / 100 + T.Populated_db_cons_phy_addr_state_pcnt *   0.00 / 100 + T.Populated_db_cons_phy_addr_zip_pcnt *   0.00 / 100 + T.Populated_db_cons_phy_addr_zip4_pcnt *   0.00 / 100 + T.Populated_db_cons_phy_addr_carrierroute_pcnt *   0.00 / 100 + T.Populated_db_cons_phy_addr_deliverypt_pcnt *   0.00 / 100 + T.Populated_db_cons_line_of_travel_pcnt *   0.00 / 100 + T.Populated_db_cons_geocode_results_pcnt *   0.00 / 100 + T.Populated_db_cons_latitude_pcnt *   0.00 / 100 + T.Populated_db_cons_longitude_pcnt *   0.00 / 100 + T.Populated_db_cons_time_zone_code_pcnt *   0.00 / 100 + T.Populated_db_cons_time_zone_desc_pcnt *   0.00 / 100 + T.Populated_db_cons_census_tract_pcnt *   0.00 / 100 + T.Populated_db_cons_census_block_pcnt *   0.00 / 100 + T.Populated_db_cons_countyfips_pcnt *   0.00 / 100 + T.Populated_db_countyname_pcnt *   0.00 / 100 + T.Populated_db_cons_cbsa_code_pcnt *   0.00 / 100 + T.Populated_db_cons_cbsa_desc_pcnt *   0.00 / 100 + T.Populated_db_cons_walk_sequence_pcnt *   0.00 / 100 + T.Populated_db_cons_phone_pcnt *   0.00 / 100 + T.Populated_db_cons_dnc_pcnt *   0.00 / 100 + T.Populated_db_cons_scrubbed_phoneable_pcnt *   0.00 / 100 + T.Populated_db_cons_children_present_pcnt *   0.00 / 100 + T.Populated_db_cons_home_value_code_pcnt *   0.00 / 100 + T.Populated_db_cons_home_value_desc_pcnt *   0.00 / 100 + T.Populated_db_cons_donor_capacity_pcnt *   0.00 / 100 + T.Populated_db_cons_donor_capacity_code_pcnt *   0.00 / 100 + T.Populated_db_cons_donor_capacity_desc_pcnt *   0.00 / 100 + T.Populated_db_cons_home_owner_renter_pcnt *   0.00 / 100 + T.Populated_db_cons_length_of_res_pcnt *   0.00 / 100 + T.Populated_db_cons_length_of_res_code_pcnt *   0.00 / 100 + T.Populated_db_cons_length_of_res_desc_pcnt *   0.00 / 100 + T.Populated_db_cons_dwelling_type_pcnt *   0.00 / 100 + T.Populated_db_cons_recent_home_buyer_pcnt *   0.00 / 100 + T.Populated_db_cons_income_code_pcnt *   0.00 / 100 + T.Populated_db_cons_income_desc_pcnt *   0.00 / 100 + T.Populated_db_cons_unsecuredcredcap_pcnt *   0.00 / 100 + T.Populated_db_cons_unsecuredcredcapcode_pcnt *   0.00 / 100 + T.Populated_db_cons_unsecuredcredcapdesc_pcnt *   0.00 / 100 + T.Populated_db_cons_networthhomeval_pcnt *   0.00 / 100 + T.Populated_db_cons_networthhomevalcode_pcnt *   0.00 / 100 + T.Populated_db_cons_net_worth_desc_pcnt *   0.00 / 100 + T.Populated_db_cons_discretincome_pcnt *   0.00 / 100 + T.Populated_db_cons_discretincomecode_pcnt *   0.00 / 100 + T.Populated_db_cons_discretincomedesc_pcnt *   0.00 / 100 + T.Populated_db_cons_marital_status_pcnt *   0.00 / 100 + T.Populated_db_cons_new_parent_pcnt *   0.00 / 100 + T.Populated_db_cons_child_near_hs_grad_pcnt *   0.00 / 100 + T.Populated_db_cons_college_graduate_pcnt *   0.00 / 100 + T.Populated_db_cons_intend_purchase_veh_pcnt *   0.00 / 100 + T.Populated_db_cons_recent_divorce_pcnt *   0.00 / 100 + T.Populated_db_cons_newlywed_pcnt *   0.00 / 100 + T.Populated_db_cons_new_teen_driver_pcnt *   0.00 / 100 + T.Populated_db_cons_home_year_built_pcnt *   0.00 / 100 + T.Populated_db_cons_home_sqft_ranges_pcnt *   0.00 / 100 + T.Populated_db_cons_poli_party_ind_pcnt *   0.00 / 100 + T.Populated_db_cons_home_sqft_actual_pcnt *   0.00 / 100 + T.Populated_db_cons_occupation_ind_pcnt *   0.00 / 100 + T.Populated_db_cons_credit_card_user_pcnt *   0.00 / 100 + T.Populated_db_cons_home_property_type_pcnt *   0.00 / 100 + T.Populated_db_cons_education_hh_pcnt *   0.00 / 100 + T.Populated_db_cons_education_ind_pcnt *   0.00 / 100 + T.Populated_db_cons_other_pet_owner_pcnt *   0.00 / 100 + T.Populated_businesstypedesc_pcnt *   0.00 / 100 + T.Populated_genderdesc_pcnt *   0.00 / 100 + T.Populated_executivetypedesc_pcnt *   0.00 / 100 + T.Populated_dbconsgenderdesc_pcnt *   0.00 / 100 + T.Populated_dbconsethnicdesc_pcnt *   0.00 / 100 + T.Populated_dbconsreligiousdesc_pcnt *   0.00 / 100 + T.Populated_dbconslangprefdesc_pcnt *   0.00 / 100 + T.Populated_dbconsownerrenter_pcnt *   0.00 / 100 + T.Populated_dbconsdwellingtypedesc_pcnt *   0.00 / 100 + T.Populated_dbconsmaritaldesc_pcnt *   0.00 / 100 + T.Populated_dbconsnewparentdesc_pcnt *   0.00 / 100 + T.Populated_dbconsteendriverdesc_pcnt *   0.00 / 100 + T.Populated_dbconspolipartydesc_pcnt *   0.00 / 100 + T.Populated_dbconsoccupationdesc_pcnt *   0.00 / 100 + T.Populated_dbconspropertytypedesc_pcnt *   0.00 / 100 + T.Populated_dbconsheadhouseeducdesc_pcnt *   0.00 / 100 + T.Populated_dbconseducationdesc_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_raw_aid_pcnt *   0.00 / 100 + T.Populated_ace_aid_pcnt *   0.00 / 100 + T.Populated_prep_address_line1_pcnt *   0.00 / 100 + T.Populated_prep_address_line_last_pcnt *   0.00 / 100;
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
    SELF.LinkingPotential := 0 + le.Populated_dt_first_seen_pcnt*ri.Populated_dt_first_seen_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_pcnt*ri.Populated_dt_last_seen_pcnt *   0.00 / 10000 + le.Populated_dt_vendor_first_reported_pcnt*ri.Populated_dt_vendor_first_reported_pcnt *   0.00 / 10000 + le.Populated_dt_vendor_last_reported_pcnt*ri.Populated_dt_vendor_last_reported_pcnt *   0.00 / 10000 + le.Populated_process_date_pcnt*ri.Populated_process_date_pcnt *   0.00 / 10000 + le.Populated_dotid_pcnt*ri.Populated_dotid_pcnt *   0.00 / 10000 + le.Populated_dotscore_pcnt*ri.Populated_dotscore_pcnt *   0.00 / 10000 + le.Populated_dotweight_pcnt*ri.Populated_dotweight_pcnt *   0.00 / 10000 + le.Populated_empid_pcnt*ri.Populated_empid_pcnt *   0.00 / 10000 + le.Populated_empscore_pcnt*ri.Populated_empscore_pcnt *   0.00 / 10000 + le.Populated_empweight_pcnt*ri.Populated_empweight_pcnt *   0.00 / 10000 + le.Populated_powid_pcnt*ri.Populated_powid_pcnt *   0.00 / 10000 + le.Populated_powscore_pcnt*ri.Populated_powscore_pcnt *   0.00 / 10000 + le.Populated_powweight_pcnt*ri.Populated_powweight_pcnt *   0.00 / 10000 + le.Populated_proxid_pcnt*ri.Populated_proxid_pcnt *   0.00 / 10000 + le.Populated_proxscore_pcnt*ri.Populated_proxscore_pcnt *   0.00 / 10000 + le.Populated_proxweight_pcnt*ri.Populated_proxweight_pcnt *   0.00 / 10000 + le.Populated_selescore_pcnt*ri.Populated_selescore_pcnt *   0.00 / 10000 + le.Populated_seleweight_pcnt*ri.Populated_seleweight_pcnt *   0.00 / 10000 + le.Populated_orgid_pcnt*ri.Populated_orgid_pcnt *   0.00 / 10000 + le.Populated_orgscore_pcnt*ri.Populated_orgscore_pcnt *   0.00 / 10000 + le.Populated_orgweight_pcnt*ri.Populated_orgweight_pcnt *   0.00 / 10000 + le.Populated_ultid_pcnt*ri.Populated_ultid_pcnt *   0.00 / 10000 + le.Populated_ultscore_pcnt*ri.Populated_ultscore_pcnt *   0.00 / 10000 + le.Populated_ultweight_pcnt*ri.Populated_ultweight_pcnt *   0.00 / 10000 + le.Populated_record_type_pcnt*ri.Populated_record_type_pcnt *   0.00 / 10000 + le.Populated_global_sid_pcnt*ri.Populated_global_sid_pcnt *   0.00 / 10000 + le.Populated_dbusa_business_id_pcnt*ri.Populated_dbusa_business_id_pcnt *   0.00 / 10000 + le.Populated_dbusa_executive_id_pcnt*ri.Populated_dbusa_executive_id_pcnt *   0.00 / 10000 + le.Populated_subhq_parent_id_pcnt*ri.Populated_subhq_parent_id_pcnt *   0.00 / 10000 + le.Populated_hq_id_pcnt*ri.Populated_hq_id_pcnt *   0.00 / 10000 + le.Populated_ind_frm_indicator_pcnt*ri.Populated_ind_frm_indicator_pcnt *   0.00 / 10000 + le.Populated_company_name_pcnt*ri.Populated_company_name_pcnt *   0.00 / 10000 + le.Populated_full_name_pcnt*ri.Populated_full_name_pcnt *   0.00 / 10000 + le.Populated_prefix_pcnt*ri.Populated_prefix_pcnt *   0.00 / 10000 + le.Populated_first_name_pcnt*ri.Populated_first_name_pcnt *   0.00 / 10000 + le.Populated_middle_initial_pcnt*ri.Populated_middle_initial_pcnt *   0.00 / 10000 + le.Populated_last_name_pcnt*ri.Populated_last_name_pcnt *   0.00 / 10000 + le.Populated_suffix_pcnt*ri.Populated_suffix_pcnt *   0.00 / 10000 + le.Populated_gender_pcnt*ri.Populated_gender_pcnt *   0.00 / 10000 + le.Populated_standardized_title_pcnt*ri.Populated_standardized_title_pcnt *   0.00 / 10000 + le.Populated_sourcetitle_pcnt*ri.Populated_sourcetitle_pcnt *   0.00 / 10000 + le.Populated_executive_title_rank_pcnt*ri.Populated_executive_title_rank_pcnt *   0.00 / 10000 + le.Populated_primary_exec_flag_pcnt*ri.Populated_primary_exec_flag_pcnt *   0.00 / 10000 + le.Populated_exec_type_pcnt*ri.Populated_exec_type_pcnt *   0.00 / 10000 + le.Populated_executive_department_pcnt*ri.Populated_executive_department_pcnt *   0.00 / 10000 + le.Populated_executive_level_pcnt*ri.Populated_executive_level_pcnt *   0.00 / 10000 + le.Populated_phy_addr_standardized_pcnt*ri.Populated_phy_addr_standardized_pcnt *   0.00 / 10000 + le.Populated_phy_addr_city_pcnt*ri.Populated_phy_addr_city_pcnt *   0.00 / 10000 + le.Populated_phy_addr_state_pcnt*ri.Populated_phy_addr_state_pcnt *   0.00 / 10000 + le.Populated_phy_addr_zip_pcnt*ri.Populated_phy_addr_zip_pcnt *   0.00 / 10000 + le.Populated_phy_addr_zip4_pcnt*ri.Populated_phy_addr_zip4_pcnt *   0.00 / 10000 + le.Populated_phy_addr_carrierroute_pcnt*ri.Populated_phy_addr_carrierroute_pcnt *   0.00 / 10000 + le.Populated_phy_addr_deliverypt_pcnt*ri.Populated_phy_addr_deliverypt_pcnt *   0.00 / 10000 + le.Populated_phy_addr_deliveryptchkdig_pcnt*ri.Populated_phy_addr_deliveryptchkdig_pcnt *   0.00 / 10000 + le.Populated_mail_addr_standardized_pcnt*ri.Populated_mail_addr_standardized_pcnt *   0.00 / 10000 + le.Populated_mail_addr_city_pcnt*ri.Populated_mail_addr_city_pcnt *   0.00 / 10000 + le.Populated_mail_addr_state_pcnt*ri.Populated_mail_addr_state_pcnt *   0.00 / 10000 + le.Populated_mail_addr_zip_pcnt*ri.Populated_mail_addr_zip_pcnt *   0.00 / 10000 + le.Populated_mail_addr_zip4_pcnt*ri.Populated_mail_addr_zip4_pcnt *   0.00 / 10000 + le.Populated_mail_addr_carrierroute_pcnt*ri.Populated_mail_addr_carrierroute_pcnt *   0.00 / 10000 + le.Populated_mail_addr_deliverypt_pcnt*ri.Populated_mail_addr_deliverypt_pcnt *   0.00 / 10000 + le.Populated_mail_addr_deliveryptchkdig_pcnt*ri.Populated_mail_addr_deliveryptchkdig_pcnt *   0.00 / 10000 + le.Populated_mail_score_pcnt*ri.Populated_mail_score_pcnt *   0.00 / 10000 + le.Populated_mail_score_desc_pcnt*ri.Populated_mail_score_desc_pcnt *   0.00 / 10000 + le.Populated_phone_pcnt*ri.Populated_phone_pcnt *   0.00 / 10000 + le.Populated_area_code_pcnt*ri.Populated_area_code_pcnt *   0.00 / 10000 + le.Populated_fax_pcnt*ri.Populated_fax_pcnt *   0.00 / 10000 + le.Populated_email_pcnt*ri.Populated_email_pcnt *   0.00 / 10000 + le.Populated_email_available_indicator_pcnt*ri.Populated_email_available_indicator_pcnt *   0.00 / 10000 + le.Populated_url_pcnt*ri.Populated_url_pcnt *   0.00 / 10000 + le.Populated_url_facebook_pcnt*ri.Populated_url_facebook_pcnt *   0.00 / 10000 + le.Populated_url_googleplus_pcnt*ri.Populated_url_googleplus_pcnt *   0.00 / 10000 + le.Populated_url_instagram_pcnt*ri.Populated_url_instagram_pcnt *   0.00 / 10000 + le.Populated_url_linkedin_pcnt*ri.Populated_url_linkedin_pcnt *   0.00 / 10000 + le.Populated_url_twitter_pcnt*ri.Populated_url_twitter_pcnt *   0.00 / 10000 + le.Populated_url_youtube_pcnt*ri.Populated_url_youtube_pcnt *   0.00 / 10000 + le.Populated_business_status_code_pcnt*ri.Populated_business_status_code_pcnt *   0.00 / 10000 + le.Populated_business_status_desc_pcnt*ri.Populated_business_status_desc_pcnt *   0.00 / 10000 + le.Populated_franchise_flag_pcnt*ri.Populated_franchise_flag_pcnt *   0.00 / 10000 + le.Populated_franchise_type_pcnt*ri.Populated_franchise_type_pcnt *   0.00 / 10000 + le.Populated_franchise_desc_pcnt*ri.Populated_franchise_desc_pcnt *   0.00 / 10000 + le.Populated_ticker_symbol_pcnt*ri.Populated_ticker_symbol_pcnt *   0.00 / 10000 + le.Populated_stock_exchange_pcnt*ri.Populated_stock_exchange_pcnt *   0.00 / 10000 + le.Populated_fortune_1000_flag_pcnt*ri.Populated_fortune_1000_flag_pcnt *   0.00 / 10000 + le.Populated_fortune_1000_rank_pcnt*ri.Populated_fortune_1000_rank_pcnt *   0.00 / 10000 + le.Populated_fortune_1000_branches_pcnt*ri.Populated_fortune_1000_branches_pcnt *   0.00 / 10000 + le.Populated_num_linked_locations_pcnt*ri.Populated_num_linked_locations_pcnt *   0.00 / 10000 + le.Populated_county_code_pcnt*ri.Populated_county_code_pcnt *   0.00 / 10000 + le.Populated_county_desc_pcnt*ri.Populated_county_desc_pcnt *   0.00 / 10000 + le.Populated_cbsa_code_pcnt*ri.Populated_cbsa_code_pcnt *   0.00 / 10000 + le.Populated_cbsa_desc_pcnt*ri.Populated_cbsa_desc_pcnt *   0.00 / 10000 + le.Populated_geo_match_level_pcnt*ri.Populated_geo_match_level_pcnt *   0.00 / 10000 + le.Populated_latitude_pcnt*ri.Populated_latitude_pcnt *   0.00 / 10000 + le.Populated_longitude_pcnt*ri.Populated_longitude_pcnt *   0.00 / 10000 + le.Populated_scf_pcnt*ri.Populated_scf_pcnt *   0.00 / 10000 + le.Populated_timezone_pcnt*ri.Populated_timezone_pcnt *   0.00 / 10000 + le.Populated_censustract_pcnt*ri.Populated_censustract_pcnt *   0.00 / 10000 + le.Populated_censusblock_pcnt*ri.Populated_censusblock_pcnt *   0.00 / 10000 + le.Populated_city_population_code_pcnt*ri.Populated_city_population_code_pcnt *   0.00 / 10000 + le.Populated_city_population_descr_pcnt*ri.Populated_city_population_descr_pcnt *   0.00 / 10000 + le.Populated_primary_sic_pcnt*ri.Populated_primary_sic_pcnt *   0.00 / 10000 + le.Populated_primary_sic_desc_pcnt*ri.Populated_primary_sic_desc_pcnt *   0.00 / 10000 + le.Populated_sic02_pcnt*ri.Populated_sic02_pcnt *   0.00 / 10000 + le.Populated_sic02_desc_pcnt*ri.Populated_sic02_desc_pcnt *   0.00 / 10000 + le.Populated_sic03_pcnt*ri.Populated_sic03_pcnt *   0.00 / 10000 + le.Populated_sic03_desc_pcnt*ri.Populated_sic03_desc_pcnt *   0.00 / 10000 + le.Populated_sic04_pcnt*ri.Populated_sic04_pcnt *   0.00 / 10000 + le.Populated_sic04_desc_pcnt*ri.Populated_sic04_desc_pcnt *   0.00 / 10000 + le.Populated_sic05_pcnt*ri.Populated_sic05_pcnt *   0.00 / 10000 + le.Populated_sic05_desc_pcnt*ri.Populated_sic05_desc_pcnt *   0.00 / 10000 + le.Populated_sic06_pcnt*ri.Populated_sic06_pcnt *   0.00 / 10000 + le.Populated_sic06_desc_pcnt*ri.Populated_sic06_desc_pcnt *   0.00 / 10000 + le.Populated_primarysic2_pcnt*ri.Populated_primarysic2_pcnt *   0.00 / 10000 + le.Populated_primary_2_digit_sic_desc_pcnt*ri.Populated_primary_2_digit_sic_desc_pcnt *   0.00 / 10000 + le.Populated_primarysic4_pcnt*ri.Populated_primarysic4_pcnt *   0.00 / 10000 + le.Populated_primary_4_digit_sic_desc_pcnt*ri.Populated_primary_4_digit_sic_desc_pcnt *   0.00 / 10000 + le.Populated_naics01_pcnt*ri.Populated_naics01_pcnt *   0.00 / 10000 + le.Populated_naics01_desc_pcnt*ri.Populated_naics01_desc_pcnt *   0.00 / 10000 + le.Populated_naics02_pcnt*ri.Populated_naics02_pcnt *   0.00 / 10000 + le.Populated_naics02_desc_pcnt*ri.Populated_naics02_desc_pcnt *   0.00 / 10000 + le.Populated_naics03_pcnt*ri.Populated_naics03_pcnt *   0.00 / 10000 + le.Populated_naics03_desc_pcnt*ri.Populated_naics03_desc_pcnt *   0.00 / 10000 + le.Populated_naics04_pcnt*ri.Populated_naics04_pcnt *   0.00 / 10000 + le.Populated_naics04_desc_pcnt*ri.Populated_naics04_desc_pcnt *   0.00 / 10000 + le.Populated_naics05_pcnt*ri.Populated_naics05_pcnt *   0.00 / 10000 + le.Populated_naics05_desc_pcnt*ri.Populated_naics05_desc_pcnt *   0.00 / 10000 + le.Populated_naics06_pcnt*ri.Populated_naics06_pcnt *   0.00 / 10000 + le.Populated_naics06_desc_pcnt*ri.Populated_naics06_desc_pcnt *   0.00 / 10000 + le.Populated_location_employees_total_pcnt*ri.Populated_location_employees_total_pcnt *   0.00 / 10000 + le.Populated_location_employee_code_pcnt*ri.Populated_location_employee_code_pcnt *   0.00 / 10000 + le.Populated_location_employee_desc_pcnt*ri.Populated_location_employee_desc_pcnt *   0.00 / 10000 + le.Populated_location_sales_total_pcnt*ri.Populated_location_sales_total_pcnt *   0.00 / 10000 + le.Populated_location_sales_code_pcnt*ri.Populated_location_sales_code_pcnt *   0.00 / 10000 + le.Populated_location_sales_desc_pcnt*ri.Populated_location_sales_desc_pcnt *   0.00 / 10000 + le.Populated_corporate_employee_total_pcnt*ri.Populated_corporate_employee_total_pcnt *   0.00 / 10000 + le.Populated_corporate_employee_code_pcnt*ri.Populated_corporate_employee_code_pcnt *   0.00 / 10000 + le.Populated_corporate_employee_desc_pcnt*ri.Populated_corporate_employee_desc_pcnt *   0.00 / 10000 + le.Populated_year_established_pcnt*ri.Populated_year_established_pcnt *   0.00 / 10000 + le.Populated_years_in_business_range_pcnt*ri.Populated_years_in_business_range_pcnt *   0.00 / 10000 + le.Populated_female_owned_pcnt*ri.Populated_female_owned_pcnt *   0.00 / 10000 + le.Populated_minority_owned_flag_pcnt*ri.Populated_minority_owned_flag_pcnt *   0.00 / 10000 + le.Populated_minority_type_pcnt*ri.Populated_minority_type_pcnt *   0.00 / 10000 + le.Populated_home_based_indicator_pcnt*ri.Populated_home_based_indicator_pcnt *   0.00 / 10000 + le.Populated_small_business_indicator_pcnt*ri.Populated_small_business_indicator_pcnt *   0.00 / 10000 + le.Populated_import_export_pcnt*ri.Populated_import_export_pcnt *   0.00 / 10000 + le.Populated_manufacturing_location_pcnt*ri.Populated_manufacturing_location_pcnt *   0.00 / 10000 + le.Populated_public_indicator_pcnt*ri.Populated_public_indicator_pcnt *   0.00 / 10000 + le.Populated_ein_pcnt*ri.Populated_ein_pcnt *   0.00 / 10000 + le.Populated_non_profit_org_pcnt*ri.Populated_non_profit_org_pcnt *   0.00 / 10000 + le.Populated_square_footage_pcnt*ri.Populated_square_footage_pcnt *   0.00 / 10000 + le.Populated_square_footage_code_pcnt*ri.Populated_square_footage_code_pcnt *   0.00 / 10000 + le.Populated_square_footage_desc_pcnt*ri.Populated_square_footage_desc_pcnt *   0.00 / 10000 + le.Populated_creditscore_pcnt*ri.Populated_creditscore_pcnt *   0.00 / 10000 + le.Populated_creditcode_pcnt*ri.Populated_creditcode_pcnt *   0.00 / 10000 + le.Populated_credit_desc_pcnt*ri.Populated_credit_desc_pcnt *   0.00 / 10000 + le.Populated_credit_capacity_pcnt*ri.Populated_credit_capacity_pcnt *   0.00 / 10000 + le.Populated_credit_capacity_code_pcnt*ri.Populated_credit_capacity_code_pcnt *   0.00 / 10000 + le.Populated_credit_capacity_desc_pcnt*ri.Populated_credit_capacity_desc_pcnt *   0.00 / 10000 + le.Populated_advertising_expenses_code_pcnt*ri.Populated_advertising_expenses_code_pcnt *   0.00 / 10000 + le.Populated_expense_advertising_desc_pcnt*ri.Populated_expense_advertising_desc_pcnt *   0.00 / 10000 + le.Populated_technology_expenses_code_pcnt*ri.Populated_technology_expenses_code_pcnt *   0.00 / 10000 + le.Populated_expense_technology_desc_pcnt*ri.Populated_expense_technology_desc_pcnt *   0.00 / 10000 + le.Populated_office_equip_expenses_code_pcnt*ri.Populated_office_equip_expenses_code_pcnt *   0.00 / 10000 + le.Populated_expense_office_equip_desc_pcnt*ri.Populated_expense_office_equip_desc_pcnt *   0.00 / 10000 + le.Populated_rent_expenses_code_pcnt*ri.Populated_rent_expenses_code_pcnt *   0.00 / 10000 + le.Populated_expense_rent_desc_pcnt*ri.Populated_expense_rent_desc_pcnt *   0.00 / 10000 + le.Populated_telecom_expenses_code_pcnt*ri.Populated_telecom_expenses_code_pcnt *   0.00 / 10000 + le.Populated_expense_telecom_desc_pcnt*ri.Populated_expense_telecom_desc_pcnt *   0.00 / 10000 + le.Populated_accounting_expenses_code_pcnt*ri.Populated_accounting_expenses_code_pcnt *   0.00 / 10000 + le.Populated_expense_accounting_desc_pcnt*ri.Populated_expense_accounting_desc_pcnt *   0.00 / 10000 + le.Populated_bus_insurance_expense_code_pcnt*ri.Populated_bus_insurance_expense_code_pcnt *   0.00 / 10000 + le.Populated_expense_bus_insurance_desc_pcnt*ri.Populated_expense_bus_insurance_desc_pcnt *   0.00 / 10000 + le.Populated_legal_expenses_code_pcnt*ri.Populated_legal_expenses_code_pcnt *   0.00 / 10000 + le.Populated_expense_legal_desc_pcnt*ri.Populated_expense_legal_desc_pcnt *   0.00 / 10000 + le.Populated_utilities_expenses_code_pcnt*ri.Populated_utilities_expenses_code_pcnt *   0.00 / 10000 + le.Populated_expense_utilities_desc_pcnt*ri.Populated_expense_utilities_desc_pcnt *   0.00 / 10000 + le.Populated_number_of_pcs_code_pcnt*ri.Populated_number_of_pcs_code_pcnt *   0.00 / 10000 + le.Populated_number_of_pcs_desc_pcnt*ri.Populated_number_of_pcs_desc_pcnt *   0.00 / 10000 + le.Populated_nb_flag_pcnt*ri.Populated_nb_flag_pcnt *   0.00 / 10000 + le.Populated_hq_company_name_pcnt*ri.Populated_hq_company_name_pcnt *   0.00 / 10000 + le.Populated_hq_city_pcnt*ri.Populated_hq_city_pcnt *   0.00 / 10000 + le.Populated_hq_state_pcnt*ri.Populated_hq_state_pcnt *   0.00 / 10000 + le.Populated_subhq_parent_name_pcnt*ri.Populated_subhq_parent_name_pcnt *   0.00 / 10000 + le.Populated_subhq_parent_city_pcnt*ri.Populated_subhq_parent_city_pcnt *   0.00 / 10000 + le.Populated_subhq_parent_state_pcnt*ri.Populated_subhq_parent_state_pcnt *   0.00 / 10000 + le.Populated_domestic_foreign_owner_flag_pcnt*ri.Populated_domestic_foreign_owner_flag_pcnt *   0.00 / 10000 + le.Populated_foreign_parent_company_name_pcnt*ri.Populated_foreign_parent_company_name_pcnt *   0.00 / 10000 + le.Populated_foreign_parent_city_pcnt*ri.Populated_foreign_parent_city_pcnt *   0.00 / 10000 + le.Populated_foreign_parent_country_pcnt*ri.Populated_foreign_parent_country_pcnt *   0.00 / 10000 + le.Populated_db_cons_matchkey_pcnt*ri.Populated_db_cons_matchkey_pcnt *   0.00 / 10000 + le.Populated_databaseusa_individual_id_pcnt*ri.Populated_databaseusa_individual_id_pcnt *   0.00 / 10000 + le.Populated_db_cons_full_name_pcnt*ri.Populated_db_cons_full_name_pcnt *   0.00 / 10000 + le.Populated_db_cons_full_name_prefix_pcnt*ri.Populated_db_cons_full_name_prefix_pcnt *   0.00 / 10000 + le.Populated_db_cons_first_name_pcnt*ri.Populated_db_cons_first_name_pcnt *   0.00 / 10000 + le.Populated_db_cons_middle_initial_pcnt*ri.Populated_db_cons_middle_initial_pcnt *   0.00 / 10000 + le.Populated_db_cons_last_name_pcnt*ri.Populated_db_cons_last_name_pcnt *   0.00 / 10000 + le.Populated_db_cons_email_pcnt*ri.Populated_db_cons_email_pcnt *   0.00 / 10000 + le.Populated_db_cons_gender_pcnt*ri.Populated_db_cons_gender_pcnt *   0.00 / 10000 + le.Populated_db_cons_date_of_birth_year_pcnt*ri.Populated_db_cons_date_of_birth_year_pcnt *   0.00 / 10000 + le.Populated_db_cons_date_of_birth_month_pcnt*ri.Populated_db_cons_date_of_birth_month_pcnt *   0.00 / 10000 + le.Populated_db_cons_age_pcnt*ri.Populated_db_cons_age_pcnt *   0.00 / 10000 + le.Populated_db_cons_age_code_desc_pcnt*ri.Populated_db_cons_age_code_desc_pcnt *   0.00 / 10000 + le.Populated_db_cons_age_in_two_year_hh_pcnt*ri.Populated_db_cons_age_in_two_year_hh_pcnt *   0.00 / 10000 + le.Populated_db_cons_ethnic_code_pcnt*ri.Populated_db_cons_ethnic_code_pcnt *   0.00 / 10000 + le.Populated_db_cons_religious_affil_pcnt*ri.Populated_db_cons_religious_affil_pcnt *   0.00 / 10000 + le.Populated_db_cons_language_pref_pcnt*ri.Populated_db_cons_language_pref_pcnt *   0.00 / 10000 + le.Populated_db_cons_phy_addr_std_pcnt*ri.Populated_db_cons_phy_addr_std_pcnt *   0.00 / 10000 + le.Populated_db_cons_phy_addr_city_pcnt*ri.Populated_db_cons_phy_addr_city_pcnt *   0.00 / 10000 + le.Populated_db_cons_phy_addr_state_pcnt*ri.Populated_db_cons_phy_addr_state_pcnt *   0.00 / 10000 + le.Populated_db_cons_phy_addr_zip_pcnt*ri.Populated_db_cons_phy_addr_zip_pcnt *   0.00 / 10000 + le.Populated_db_cons_phy_addr_zip4_pcnt*ri.Populated_db_cons_phy_addr_zip4_pcnt *   0.00 / 10000 + le.Populated_db_cons_phy_addr_carrierroute_pcnt*ri.Populated_db_cons_phy_addr_carrierroute_pcnt *   0.00 / 10000 + le.Populated_db_cons_phy_addr_deliverypt_pcnt*ri.Populated_db_cons_phy_addr_deliverypt_pcnt *   0.00 / 10000 + le.Populated_db_cons_line_of_travel_pcnt*ri.Populated_db_cons_line_of_travel_pcnt *   0.00 / 10000 + le.Populated_db_cons_geocode_results_pcnt*ri.Populated_db_cons_geocode_results_pcnt *   0.00 / 10000 + le.Populated_db_cons_latitude_pcnt*ri.Populated_db_cons_latitude_pcnt *   0.00 / 10000 + le.Populated_db_cons_longitude_pcnt*ri.Populated_db_cons_longitude_pcnt *   0.00 / 10000 + le.Populated_db_cons_time_zone_code_pcnt*ri.Populated_db_cons_time_zone_code_pcnt *   0.00 / 10000 + le.Populated_db_cons_time_zone_desc_pcnt*ri.Populated_db_cons_time_zone_desc_pcnt *   0.00 / 10000 + le.Populated_db_cons_census_tract_pcnt*ri.Populated_db_cons_census_tract_pcnt *   0.00 / 10000 + le.Populated_db_cons_census_block_pcnt*ri.Populated_db_cons_census_block_pcnt *   0.00 / 10000 + le.Populated_db_cons_countyfips_pcnt*ri.Populated_db_cons_countyfips_pcnt *   0.00 / 10000 + le.Populated_db_countyname_pcnt*ri.Populated_db_countyname_pcnt *   0.00 / 10000 + le.Populated_db_cons_cbsa_code_pcnt*ri.Populated_db_cons_cbsa_code_pcnt *   0.00 / 10000 + le.Populated_db_cons_cbsa_desc_pcnt*ri.Populated_db_cons_cbsa_desc_pcnt *   0.00 / 10000 + le.Populated_db_cons_walk_sequence_pcnt*ri.Populated_db_cons_walk_sequence_pcnt *   0.00 / 10000 + le.Populated_db_cons_phone_pcnt*ri.Populated_db_cons_phone_pcnt *   0.00 / 10000 + le.Populated_db_cons_dnc_pcnt*ri.Populated_db_cons_dnc_pcnt *   0.00 / 10000 + le.Populated_db_cons_scrubbed_phoneable_pcnt*ri.Populated_db_cons_scrubbed_phoneable_pcnt *   0.00 / 10000 + le.Populated_db_cons_children_present_pcnt*ri.Populated_db_cons_children_present_pcnt *   0.00 / 10000 + le.Populated_db_cons_home_value_code_pcnt*ri.Populated_db_cons_home_value_code_pcnt *   0.00 / 10000 + le.Populated_db_cons_home_value_desc_pcnt*ri.Populated_db_cons_home_value_desc_pcnt *   0.00 / 10000 + le.Populated_db_cons_donor_capacity_pcnt*ri.Populated_db_cons_donor_capacity_pcnt *   0.00 / 10000 + le.Populated_db_cons_donor_capacity_code_pcnt*ri.Populated_db_cons_donor_capacity_code_pcnt *   0.00 / 10000 + le.Populated_db_cons_donor_capacity_desc_pcnt*ri.Populated_db_cons_donor_capacity_desc_pcnt *   0.00 / 10000 + le.Populated_db_cons_home_owner_renter_pcnt*ri.Populated_db_cons_home_owner_renter_pcnt *   0.00 / 10000 + le.Populated_db_cons_length_of_res_pcnt*ri.Populated_db_cons_length_of_res_pcnt *   0.00 / 10000 + le.Populated_db_cons_length_of_res_code_pcnt*ri.Populated_db_cons_length_of_res_code_pcnt *   0.00 / 10000 + le.Populated_db_cons_length_of_res_desc_pcnt*ri.Populated_db_cons_length_of_res_desc_pcnt *   0.00 / 10000 + le.Populated_db_cons_dwelling_type_pcnt*ri.Populated_db_cons_dwelling_type_pcnt *   0.00 / 10000 + le.Populated_db_cons_recent_home_buyer_pcnt*ri.Populated_db_cons_recent_home_buyer_pcnt *   0.00 / 10000 + le.Populated_db_cons_income_code_pcnt*ri.Populated_db_cons_income_code_pcnt *   0.00 / 10000 + le.Populated_db_cons_income_desc_pcnt*ri.Populated_db_cons_income_desc_pcnt *   0.00 / 10000 + le.Populated_db_cons_unsecuredcredcap_pcnt*ri.Populated_db_cons_unsecuredcredcap_pcnt *   0.00 / 10000 + le.Populated_db_cons_unsecuredcredcapcode_pcnt*ri.Populated_db_cons_unsecuredcredcapcode_pcnt *   0.00 / 10000 + le.Populated_db_cons_unsecuredcredcapdesc_pcnt*ri.Populated_db_cons_unsecuredcredcapdesc_pcnt *   0.00 / 10000 + le.Populated_db_cons_networthhomeval_pcnt*ri.Populated_db_cons_networthhomeval_pcnt *   0.00 / 10000 + le.Populated_db_cons_networthhomevalcode_pcnt*ri.Populated_db_cons_networthhomevalcode_pcnt *   0.00 / 10000 + le.Populated_db_cons_net_worth_desc_pcnt*ri.Populated_db_cons_net_worth_desc_pcnt *   0.00 / 10000 + le.Populated_db_cons_discretincome_pcnt*ri.Populated_db_cons_discretincome_pcnt *   0.00 / 10000 + le.Populated_db_cons_discretincomecode_pcnt*ri.Populated_db_cons_discretincomecode_pcnt *   0.00 / 10000 + le.Populated_db_cons_discretincomedesc_pcnt*ri.Populated_db_cons_discretincomedesc_pcnt *   0.00 / 10000 + le.Populated_db_cons_marital_status_pcnt*ri.Populated_db_cons_marital_status_pcnt *   0.00 / 10000 + le.Populated_db_cons_new_parent_pcnt*ri.Populated_db_cons_new_parent_pcnt *   0.00 / 10000 + le.Populated_db_cons_child_near_hs_grad_pcnt*ri.Populated_db_cons_child_near_hs_grad_pcnt *   0.00 / 10000 + le.Populated_db_cons_college_graduate_pcnt*ri.Populated_db_cons_college_graduate_pcnt *   0.00 / 10000 + le.Populated_db_cons_intend_purchase_veh_pcnt*ri.Populated_db_cons_intend_purchase_veh_pcnt *   0.00 / 10000 + le.Populated_db_cons_recent_divorce_pcnt*ri.Populated_db_cons_recent_divorce_pcnt *   0.00 / 10000 + le.Populated_db_cons_newlywed_pcnt*ri.Populated_db_cons_newlywed_pcnt *   0.00 / 10000 + le.Populated_db_cons_new_teen_driver_pcnt*ri.Populated_db_cons_new_teen_driver_pcnt *   0.00 / 10000 + le.Populated_db_cons_home_year_built_pcnt*ri.Populated_db_cons_home_year_built_pcnt *   0.00 / 10000 + le.Populated_db_cons_home_sqft_ranges_pcnt*ri.Populated_db_cons_home_sqft_ranges_pcnt *   0.00 / 10000 + le.Populated_db_cons_poli_party_ind_pcnt*ri.Populated_db_cons_poli_party_ind_pcnt *   0.00 / 10000 + le.Populated_db_cons_home_sqft_actual_pcnt*ri.Populated_db_cons_home_sqft_actual_pcnt *   0.00 / 10000 + le.Populated_db_cons_occupation_ind_pcnt*ri.Populated_db_cons_occupation_ind_pcnt *   0.00 / 10000 + le.Populated_db_cons_credit_card_user_pcnt*ri.Populated_db_cons_credit_card_user_pcnt *   0.00 / 10000 + le.Populated_db_cons_home_property_type_pcnt*ri.Populated_db_cons_home_property_type_pcnt *   0.00 / 10000 + le.Populated_db_cons_education_hh_pcnt*ri.Populated_db_cons_education_hh_pcnt *   0.00 / 10000 + le.Populated_db_cons_education_ind_pcnt*ri.Populated_db_cons_education_ind_pcnt *   0.00 / 10000 + le.Populated_db_cons_other_pet_owner_pcnt*ri.Populated_db_cons_other_pet_owner_pcnt *   0.00 / 10000 + le.Populated_businesstypedesc_pcnt*ri.Populated_businesstypedesc_pcnt *   0.00 / 10000 + le.Populated_genderdesc_pcnt*ri.Populated_genderdesc_pcnt *   0.00 / 10000 + le.Populated_executivetypedesc_pcnt*ri.Populated_executivetypedesc_pcnt *   0.00 / 10000 + le.Populated_dbconsgenderdesc_pcnt*ri.Populated_dbconsgenderdesc_pcnt *   0.00 / 10000 + le.Populated_dbconsethnicdesc_pcnt*ri.Populated_dbconsethnicdesc_pcnt *   0.00 / 10000 + le.Populated_dbconsreligiousdesc_pcnt*ri.Populated_dbconsreligiousdesc_pcnt *   0.00 / 10000 + le.Populated_dbconslangprefdesc_pcnt*ri.Populated_dbconslangprefdesc_pcnt *   0.00 / 10000 + le.Populated_dbconsownerrenter_pcnt*ri.Populated_dbconsownerrenter_pcnt *   0.00 / 10000 + le.Populated_dbconsdwellingtypedesc_pcnt*ri.Populated_dbconsdwellingtypedesc_pcnt *   0.00 / 10000 + le.Populated_dbconsmaritaldesc_pcnt*ri.Populated_dbconsmaritaldesc_pcnt *   0.00 / 10000 + le.Populated_dbconsnewparentdesc_pcnt*ri.Populated_dbconsnewparentdesc_pcnt *   0.00 / 10000 + le.Populated_dbconsteendriverdesc_pcnt*ri.Populated_dbconsteendriverdesc_pcnt *   0.00 / 10000 + le.Populated_dbconspolipartydesc_pcnt*ri.Populated_dbconspolipartydesc_pcnt *   0.00 / 10000 + le.Populated_dbconsoccupationdesc_pcnt*ri.Populated_dbconsoccupationdesc_pcnt *   0.00 / 10000 + le.Populated_dbconspropertytypedesc_pcnt*ri.Populated_dbconspropertytypedesc_pcnt *   0.00 / 10000 + le.Populated_dbconsheadhouseeducdesc_pcnt*ri.Populated_dbconsheadhouseeducdesc_pcnt *   0.00 / 10000 + le.Populated_dbconseducationdesc_pcnt*ri.Populated_dbconseducationdesc_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_name_score_pcnt*ri.Populated_name_score_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dbpc_pcnt*ri.Populated_dbpc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_fips_state_pcnt*ri.Populated_fips_state_pcnt *   0.00 / 10000 + le.Populated_fips_county_pcnt*ri.Populated_fips_county_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_raw_aid_pcnt*ri.Populated_raw_aid_pcnt *   0.00 / 10000 + le.Populated_ace_aid_pcnt*ri.Populated_ace_aid_pcnt *   0.00 / 10000 + le.Populated_prep_address_line1_pcnt*ri.Populated_prep_address_line1_pcnt *   0.00 / 10000 + le.Populated_prep_address_line_last_pcnt*ri.Populated_prep_address_line_last_pcnt *   0.00 / 10000;
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
  SELF.FieldName := CHOOSE(C,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','record_type','global_sid','dbusa_business_id','dbusa_executive_id','subhq_parent_id','hq_id','ind_frm_indicator','company_name','full_name','prefix','first_name','middle_initial','last_name','suffix','gender','standardized_title','sourcetitle','executive_title_rank','primary_exec_flag','exec_type','executive_department','executive_level','phy_addr_standardized','phy_addr_city','phy_addr_state','phy_addr_zip','phy_addr_zip4','phy_addr_carrierroute','phy_addr_deliverypt','phy_addr_deliveryptchkdig','mail_addr_standardized','mail_addr_city','mail_addr_state','mail_addr_zip','mail_addr_zip4','mail_addr_carrierroute','mail_addr_deliverypt','mail_addr_deliveryptchkdig','mail_score','mail_score_desc','phone','area_code','fax','email','email_available_indicator','url','url_facebook','url_googleplus','url_instagram','url_linkedin','url_twitter','url_youtube','business_status_code','business_status_desc','franchise_flag','franchise_type','franchise_desc','ticker_symbol','stock_exchange','fortune_1000_flag','fortune_1000_rank','fortune_1000_branches','num_linked_locations','county_code','county_desc','cbsa_code','cbsa_desc','geo_match_level','latitude','longitude','scf','timezone','censustract','censusblock','city_population_code','city_population_descr','primary_sic','primary_sic_desc','sic02','sic02_desc','sic03','sic03_desc','sic04','sic04_desc','sic05','sic05_desc','sic06','sic06_desc','primarysic2','primary_2_digit_sic_desc','primarysic4','primary_4_digit_sic_desc','naics01','naics01_desc','naics02','naics02_desc','naics03','naics03_desc','naics04','naics04_desc','naics05','naics05_desc','naics06','naics06_desc','location_employees_total','location_employee_code','location_employee_desc','location_sales_total','location_sales_code','location_sales_desc','corporate_employee_total','corporate_employee_code','corporate_employee_desc','year_established','years_in_business_range','female_owned','minority_owned_flag','minority_type','home_based_indicator','small_business_indicator','import_export','manufacturing_location','public_indicator','ein','non_profit_org','square_footage','square_footage_code','square_footage_desc','creditscore','creditcode','credit_desc','credit_capacity','credit_capacity_code','credit_capacity_desc','advertising_expenses_code','expense_advertising_desc','technology_expenses_code','expense_technology_desc','office_equip_expenses_code','expense_office_equip_desc','rent_expenses_code','expense_rent_desc','telecom_expenses_code','expense_telecom_desc','accounting_expenses_code','expense_accounting_desc','bus_insurance_expense_code','expense_bus_insurance_desc','legal_expenses_code','expense_legal_desc','utilities_expenses_code','expense_utilities_desc','number_of_pcs_code','number_of_pcs_desc','nb_flag','hq_company_name','hq_city','hq_state','subhq_parent_name','subhq_parent_city','subhq_parent_state','domestic_foreign_owner_flag','foreign_parent_company_name','foreign_parent_city','foreign_parent_country','db_cons_matchkey','databaseusa_individual_id','db_cons_full_name','db_cons_full_name_prefix','db_cons_first_name','db_cons_middle_initial','db_cons_last_name','db_cons_email','db_cons_gender','db_cons_date_of_birth_year','db_cons_date_of_birth_month','db_cons_age','db_cons_age_code_desc','db_cons_age_in_two_year_hh','db_cons_ethnic_code','db_cons_religious_affil','db_cons_language_pref','db_cons_phy_addr_std','db_cons_phy_addr_city','db_cons_phy_addr_state','db_cons_phy_addr_zip','db_cons_phy_addr_zip4','db_cons_phy_addr_carrierroute','db_cons_phy_addr_deliverypt','db_cons_line_of_travel','db_cons_geocode_results','db_cons_latitude','db_cons_longitude','db_cons_time_zone_code','db_cons_time_zone_desc','db_cons_census_tract','db_cons_census_block','db_cons_countyfips','db_countyname','db_cons_cbsa_code','db_cons_cbsa_desc','db_cons_walk_sequence','db_cons_phone','db_cons_dnc','db_cons_scrubbed_phoneable','db_cons_children_present','db_cons_home_value_code','db_cons_home_value_desc','db_cons_donor_capacity','db_cons_donor_capacity_code','db_cons_donor_capacity_desc','db_cons_home_owner_renter','db_cons_length_of_res','db_cons_length_of_res_code','db_cons_length_of_res_desc','db_cons_dwelling_type','db_cons_recent_home_buyer','db_cons_income_code','db_cons_income_desc','db_cons_unsecuredcredcap','db_cons_unsecuredcredcapcode','db_cons_unsecuredcredcapdesc','db_cons_networthhomeval','db_cons_networthhomevalcode','db_cons_net_worth_desc','db_cons_discretincome','db_cons_discretincomecode','db_cons_discretincomedesc','db_cons_marital_status','db_cons_new_parent','db_cons_child_near_hs_grad','db_cons_college_graduate','db_cons_intend_purchase_veh','db_cons_recent_divorce','db_cons_newlywed','db_cons_new_teen_driver','db_cons_home_year_built','db_cons_home_sqft_ranges','db_cons_poli_party_ind','db_cons_home_sqft_actual','db_cons_occupation_ind','db_cons_credit_card_user','db_cons_home_property_type','db_cons_education_hh','db_cons_education_ind','db_cons_other_pet_owner','businesstypedesc','genderdesc','executivetypedesc','dbconsgenderdesc','dbconsethnicdesc','dbconsreligiousdesc','dbconslangprefdesc','dbconsownerrenter','dbconsdwellingtypedesc','dbconsmaritaldesc','dbconsnewparentdesc','dbconsteendriverdesc','dbconspolipartydesc','dbconsoccupationdesc','dbconspropertytypedesc','dbconsheadhouseeducdesc','dbconseducationdesc','title','fname','mname','lname','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_address_line1','prep_address_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_process_date_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_record_type_pcnt,le.populated_global_sid_pcnt,le.populated_dbusa_business_id_pcnt,le.populated_dbusa_executive_id_pcnt,le.populated_subhq_parent_id_pcnt,le.populated_hq_id_pcnt,le.populated_ind_frm_indicator_pcnt,le.populated_company_name_pcnt,le.populated_full_name_pcnt,le.populated_prefix_pcnt,le.populated_first_name_pcnt,le.populated_middle_initial_pcnt,le.populated_last_name_pcnt,le.populated_suffix_pcnt,le.populated_gender_pcnt,le.populated_standardized_title_pcnt,le.populated_sourcetitle_pcnt,le.populated_executive_title_rank_pcnt,le.populated_primary_exec_flag_pcnt,le.populated_exec_type_pcnt,le.populated_executive_department_pcnt,le.populated_executive_level_pcnt,le.populated_phy_addr_standardized_pcnt,le.populated_phy_addr_city_pcnt,le.populated_phy_addr_state_pcnt,le.populated_phy_addr_zip_pcnt,le.populated_phy_addr_zip4_pcnt,le.populated_phy_addr_carrierroute_pcnt,le.populated_phy_addr_deliverypt_pcnt,le.populated_phy_addr_deliveryptchkdig_pcnt,le.populated_mail_addr_standardized_pcnt,le.populated_mail_addr_city_pcnt,le.populated_mail_addr_state_pcnt,le.populated_mail_addr_zip_pcnt,le.populated_mail_addr_zip4_pcnt,le.populated_mail_addr_carrierroute_pcnt,le.populated_mail_addr_deliverypt_pcnt,le.populated_mail_addr_deliveryptchkdig_pcnt,le.populated_mail_score_pcnt,le.populated_mail_score_desc_pcnt,le.populated_phone_pcnt,le.populated_area_code_pcnt,le.populated_fax_pcnt,le.populated_email_pcnt,le.populated_email_available_indicator_pcnt,le.populated_url_pcnt,le.populated_url_facebook_pcnt,le.populated_url_googleplus_pcnt,le.populated_url_instagram_pcnt,le.populated_url_linkedin_pcnt,le.populated_url_twitter_pcnt,le.populated_url_youtube_pcnt,le.populated_business_status_code_pcnt,le.populated_business_status_desc_pcnt,le.populated_franchise_flag_pcnt,le.populated_franchise_type_pcnt,le.populated_franchise_desc_pcnt,le.populated_ticker_symbol_pcnt,le.populated_stock_exchange_pcnt,le.populated_fortune_1000_flag_pcnt,le.populated_fortune_1000_rank_pcnt,le.populated_fortune_1000_branches_pcnt,le.populated_num_linked_locations_pcnt,le.populated_county_code_pcnt,le.populated_county_desc_pcnt,le.populated_cbsa_code_pcnt,le.populated_cbsa_desc_pcnt,le.populated_geo_match_level_pcnt,le.populated_latitude_pcnt,le.populated_longitude_pcnt,le.populated_scf_pcnt,le.populated_timezone_pcnt,le.populated_censustract_pcnt,le.populated_censusblock_pcnt,le.populated_city_population_code_pcnt,le.populated_city_population_descr_pcnt,le.populated_primary_sic_pcnt,le.populated_primary_sic_desc_pcnt,le.populated_sic02_pcnt,le.populated_sic02_desc_pcnt,le.populated_sic03_pcnt,le.populated_sic03_desc_pcnt,le.populated_sic04_pcnt,le.populated_sic04_desc_pcnt,le.populated_sic05_pcnt,le.populated_sic05_desc_pcnt,le.populated_sic06_pcnt,le.populated_sic06_desc_pcnt,le.populated_primarysic2_pcnt,le.populated_primary_2_digit_sic_desc_pcnt,le.populated_primarysic4_pcnt,le.populated_primary_4_digit_sic_desc_pcnt,le.populated_naics01_pcnt,le.populated_naics01_desc_pcnt,le.populated_naics02_pcnt,le.populated_naics02_desc_pcnt,le.populated_naics03_pcnt,le.populated_naics03_desc_pcnt,le.populated_naics04_pcnt,le.populated_naics04_desc_pcnt,le.populated_naics05_pcnt,le.populated_naics05_desc_pcnt,le.populated_naics06_pcnt,le.populated_naics06_desc_pcnt,le.populated_location_employees_total_pcnt,le.populated_location_employee_code_pcnt,le.populated_location_employee_desc_pcnt,le.populated_location_sales_total_pcnt,le.populated_location_sales_code_pcnt,le.populated_location_sales_desc_pcnt,le.populated_corporate_employee_total_pcnt,le.populated_corporate_employee_code_pcnt,le.populated_corporate_employee_desc_pcnt,le.populated_year_established_pcnt,le.populated_years_in_business_range_pcnt,le.populated_female_owned_pcnt,le.populated_minority_owned_flag_pcnt,le.populated_minority_type_pcnt,le.populated_home_based_indicator_pcnt,le.populated_small_business_indicator_pcnt,le.populated_import_export_pcnt,le.populated_manufacturing_location_pcnt,le.populated_public_indicator_pcnt,le.populated_ein_pcnt,le.populated_non_profit_org_pcnt,le.populated_square_footage_pcnt,le.populated_square_footage_code_pcnt,le.populated_square_footage_desc_pcnt,le.populated_creditscore_pcnt,le.populated_creditcode_pcnt,le.populated_credit_desc_pcnt,le.populated_credit_capacity_pcnt,le.populated_credit_capacity_code_pcnt,le.populated_credit_capacity_desc_pcnt,le.populated_advertising_expenses_code_pcnt,le.populated_expense_advertising_desc_pcnt,le.populated_technology_expenses_code_pcnt,le.populated_expense_technology_desc_pcnt,le.populated_office_equip_expenses_code_pcnt,le.populated_expense_office_equip_desc_pcnt,le.populated_rent_expenses_code_pcnt,le.populated_expense_rent_desc_pcnt,le.populated_telecom_expenses_code_pcnt,le.populated_expense_telecom_desc_pcnt,le.populated_accounting_expenses_code_pcnt,le.populated_expense_accounting_desc_pcnt,le.populated_bus_insurance_expense_code_pcnt,le.populated_expense_bus_insurance_desc_pcnt,le.populated_legal_expenses_code_pcnt,le.populated_expense_legal_desc_pcnt,le.populated_utilities_expenses_code_pcnt,le.populated_expense_utilities_desc_pcnt,le.populated_number_of_pcs_code_pcnt,le.populated_number_of_pcs_desc_pcnt,le.populated_nb_flag_pcnt,le.populated_hq_company_name_pcnt,le.populated_hq_city_pcnt,le.populated_hq_state_pcnt,le.populated_subhq_parent_name_pcnt,le.populated_subhq_parent_city_pcnt,le.populated_subhq_parent_state_pcnt,le.populated_domestic_foreign_owner_flag_pcnt,le.populated_foreign_parent_company_name_pcnt,le.populated_foreign_parent_city_pcnt,le.populated_foreign_parent_country_pcnt,le.populated_db_cons_matchkey_pcnt,le.populated_databaseusa_individual_id_pcnt,le.populated_db_cons_full_name_pcnt,le.populated_db_cons_full_name_prefix_pcnt,le.populated_db_cons_first_name_pcnt,le.populated_db_cons_middle_initial_pcnt,le.populated_db_cons_last_name_pcnt,le.populated_db_cons_email_pcnt,le.populated_db_cons_gender_pcnt,le.populated_db_cons_date_of_birth_year_pcnt,le.populated_db_cons_date_of_birth_month_pcnt,le.populated_db_cons_age_pcnt,le.populated_db_cons_age_code_desc_pcnt,le.populated_db_cons_age_in_two_year_hh_pcnt,le.populated_db_cons_ethnic_code_pcnt,le.populated_db_cons_religious_affil_pcnt,le.populated_db_cons_language_pref_pcnt,le.populated_db_cons_phy_addr_std_pcnt,le.populated_db_cons_phy_addr_city_pcnt,le.populated_db_cons_phy_addr_state_pcnt,le.populated_db_cons_phy_addr_zip_pcnt,le.populated_db_cons_phy_addr_zip4_pcnt,le.populated_db_cons_phy_addr_carrierroute_pcnt,le.populated_db_cons_phy_addr_deliverypt_pcnt,le.populated_db_cons_line_of_travel_pcnt,le.populated_db_cons_geocode_results_pcnt,le.populated_db_cons_latitude_pcnt,le.populated_db_cons_longitude_pcnt,le.populated_db_cons_time_zone_code_pcnt,le.populated_db_cons_time_zone_desc_pcnt,le.populated_db_cons_census_tract_pcnt,le.populated_db_cons_census_block_pcnt,le.populated_db_cons_countyfips_pcnt,le.populated_db_countyname_pcnt,le.populated_db_cons_cbsa_code_pcnt,le.populated_db_cons_cbsa_desc_pcnt,le.populated_db_cons_walk_sequence_pcnt,le.populated_db_cons_phone_pcnt,le.populated_db_cons_dnc_pcnt,le.populated_db_cons_scrubbed_phoneable_pcnt,le.populated_db_cons_children_present_pcnt,le.populated_db_cons_home_value_code_pcnt,le.populated_db_cons_home_value_desc_pcnt,le.populated_db_cons_donor_capacity_pcnt,le.populated_db_cons_donor_capacity_code_pcnt,le.populated_db_cons_donor_capacity_desc_pcnt,le.populated_db_cons_home_owner_renter_pcnt,le.populated_db_cons_length_of_res_pcnt,le.populated_db_cons_length_of_res_code_pcnt,le.populated_db_cons_length_of_res_desc_pcnt,le.populated_db_cons_dwelling_type_pcnt,le.populated_db_cons_recent_home_buyer_pcnt,le.populated_db_cons_income_code_pcnt,le.populated_db_cons_income_desc_pcnt,le.populated_db_cons_unsecuredcredcap_pcnt,le.populated_db_cons_unsecuredcredcapcode_pcnt,le.populated_db_cons_unsecuredcredcapdesc_pcnt,le.populated_db_cons_networthhomeval_pcnt,le.populated_db_cons_networthhomevalcode_pcnt,le.populated_db_cons_net_worth_desc_pcnt,le.populated_db_cons_discretincome_pcnt,le.populated_db_cons_discretincomecode_pcnt,le.populated_db_cons_discretincomedesc_pcnt,le.populated_db_cons_marital_status_pcnt,le.populated_db_cons_new_parent_pcnt,le.populated_db_cons_child_near_hs_grad_pcnt,le.populated_db_cons_college_graduate_pcnt,le.populated_db_cons_intend_purchase_veh_pcnt,le.populated_db_cons_recent_divorce_pcnt,le.populated_db_cons_newlywed_pcnt,le.populated_db_cons_new_teen_driver_pcnt,le.populated_db_cons_home_year_built_pcnt,le.populated_db_cons_home_sqft_ranges_pcnt,le.populated_db_cons_poli_party_ind_pcnt,le.populated_db_cons_home_sqft_actual_pcnt,le.populated_db_cons_occupation_ind_pcnt,le.populated_db_cons_credit_card_user_pcnt,le.populated_db_cons_home_property_type_pcnt,le.populated_db_cons_education_hh_pcnt,le.populated_db_cons_education_ind_pcnt,le.populated_db_cons_other_pet_owner_pcnt,le.populated_businesstypedesc_pcnt,le.populated_genderdesc_pcnt,le.populated_executivetypedesc_pcnt,le.populated_dbconsgenderdesc_pcnt,le.populated_dbconsethnicdesc_pcnt,le.populated_dbconsreligiousdesc_pcnt,le.populated_dbconslangprefdesc_pcnt,le.populated_dbconsownerrenter_pcnt,le.populated_dbconsdwellingtypedesc_pcnt,le.populated_dbconsmaritaldesc_pcnt,le.populated_dbconsnewparentdesc_pcnt,le.populated_dbconsteendriverdesc_pcnt,le.populated_dbconspolipartydesc_pcnt,le.populated_dbconsoccupationdesc_pcnt,le.populated_dbconspropertytypedesc_pcnt,le.populated_dbconsheadhouseeducdesc_pcnt,le.populated_dbconseducationdesc_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_raw_aid_pcnt,le.populated_ace_aid_pcnt,le.populated_prep_address_line1_pcnt,le.populated_prep_address_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_process_date,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_record_type,le.maxlength_global_sid,le.maxlength_dbusa_business_id,le.maxlength_dbusa_executive_id,le.maxlength_subhq_parent_id,le.maxlength_hq_id,le.maxlength_ind_frm_indicator,le.maxlength_company_name,le.maxlength_full_name,le.maxlength_prefix,le.maxlength_first_name,le.maxlength_middle_initial,le.maxlength_last_name,le.maxlength_suffix,le.maxlength_gender,le.maxlength_standardized_title,le.maxlength_sourcetitle,le.maxlength_executive_title_rank,le.maxlength_primary_exec_flag,le.maxlength_exec_type,le.maxlength_executive_department,le.maxlength_executive_level,le.maxlength_phy_addr_standardized,le.maxlength_phy_addr_city,le.maxlength_phy_addr_state,le.maxlength_phy_addr_zip,le.maxlength_phy_addr_zip4,le.maxlength_phy_addr_carrierroute,le.maxlength_phy_addr_deliverypt,le.maxlength_phy_addr_deliveryptchkdig,le.maxlength_mail_addr_standardized,le.maxlength_mail_addr_city,le.maxlength_mail_addr_state,le.maxlength_mail_addr_zip,le.maxlength_mail_addr_zip4,le.maxlength_mail_addr_carrierroute,le.maxlength_mail_addr_deliverypt,le.maxlength_mail_addr_deliveryptchkdig,le.maxlength_mail_score,le.maxlength_mail_score_desc,le.maxlength_phone,le.maxlength_area_code,le.maxlength_fax,le.maxlength_email,le.maxlength_email_available_indicator,le.maxlength_url,le.maxlength_url_facebook,le.maxlength_url_googleplus,le.maxlength_url_instagram,le.maxlength_url_linkedin,le.maxlength_url_twitter,le.maxlength_url_youtube,le.maxlength_business_status_code,le.maxlength_business_status_desc,le.maxlength_franchise_flag,le.maxlength_franchise_type,le.maxlength_franchise_desc,le.maxlength_ticker_symbol,le.maxlength_stock_exchange,le.maxlength_fortune_1000_flag,le.maxlength_fortune_1000_rank,le.maxlength_fortune_1000_branches,le.maxlength_num_linked_locations,le.maxlength_county_code,le.maxlength_county_desc,le.maxlength_cbsa_code,le.maxlength_cbsa_desc,le.maxlength_geo_match_level,le.maxlength_latitude,le.maxlength_longitude,le.maxlength_scf,le.maxlength_timezone,le.maxlength_censustract,le.maxlength_censusblock,le.maxlength_city_population_code,le.maxlength_city_population_descr,le.maxlength_primary_sic,le.maxlength_primary_sic_desc,le.maxlength_sic02,le.maxlength_sic02_desc,le.maxlength_sic03,le.maxlength_sic03_desc,le.maxlength_sic04,le.maxlength_sic04_desc,le.maxlength_sic05,le.maxlength_sic05_desc,le.maxlength_sic06,le.maxlength_sic06_desc,le.maxlength_primarysic2,le.maxlength_primary_2_digit_sic_desc,le.maxlength_primarysic4,le.maxlength_primary_4_digit_sic_desc,le.maxlength_naics01,le.maxlength_naics01_desc,le.maxlength_naics02,le.maxlength_naics02_desc,le.maxlength_naics03,le.maxlength_naics03_desc,le.maxlength_naics04,le.maxlength_naics04_desc,le.maxlength_naics05,le.maxlength_naics05_desc,le.maxlength_naics06,le.maxlength_naics06_desc,le.maxlength_location_employees_total,le.maxlength_location_employee_code,le.maxlength_location_employee_desc,le.maxlength_location_sales_total,le.maxlength_location_sales_code,le.maxlength_location_sales_desc,le.maxlength_corporate_employee_total,le.maxlength_corporate_employee_code,le.maxlength_corporate_employee_desc,le.maxlength_year_established,le.maxlength_years_in_business_range,le.maxlength_female_owned,le.maxlength_minority_owned_flag,le.maxlength_minority_type,le.maxlength_home_based_indicator,le.maxlength_small_business_indicator,le.maxlength_import_export,le.maxlength_manufacturing_location,le.maxlength_public_indicator,le.maxlength_ein,le.maxlength_non_profit_org,le.maxlength_square_footage,le.maxlength_square_footage_code,le.maxlength_square_footage_desc,le.maxlength_creditscore,le.maxlength_creditcode,le.maxlength_credit_desc,le.maxlength_credit_capacity,le.maxlength_credit_capacity_code,le.maxlength_credit_capacity_desc,le.maxlength_advertising_expenses_code,le.maxlength_expense_advertising_desc,le.maxlength_technology_expenses_code,le.maxlength_expense_technology_desc,le.maxlength_office_equip_expenses_code,le.maxlength_expense_office_equip_desc,le.maxlength_rent_expenses_code,le.maxlength_expense_rent_desc,le.maxlength_telecom_expenses_code,le.maxlength_expense_telecom_desc,le.maxlength_accounting_expenses_code,le.maxlength_expense_accounting_desc,le.maxlength_bus_insurance_expense_code,le.maxlength_expense_bus_insurance_desc,le.maxlength_legal_expenses_code,le.maxlength_expense_legal_desc,le.maxlength_utilities_expenses_code,le.maxlength_expense_utilities_desc,le.maxlength_number_of_pcs_code,le.maxlength_number_of_pcs_desc,le.maxlength_nb_flag,le.maxlength_hq_company_name,le.maxlength_hq_city,le.maxlength_hq_state,le.maxlength_subhq_parent_name,le.maxlength_subhq_parent_city,le.maxlength_subhq_parent_state,le.maxlength_domestic_foreign_owner_flag,le.maxlength_foreign_parent_company_name,le.maxlength_foreign_parent_city,le.maxlength_foreign_parent_country,le.maxlength_db_cons_matchkey,le.maxlength_databaseusa_individual_id,le.maxlength_db_cons_full_name,le.maxlength_db_cons_full_name_prefix,le.maxlength_db_cons_first_name,le.maxlength_db_cons_middle_initial,le.maxlength_db_cons_last_name,le.maxlength_db_cons_email,le.maxlength_db_cons_gender,le.maxlength_db_cons_date_of_birth_year,le.maxlength_db_cons_date_of_birth_month,le.maxlength_db_cons_age,le.maxlength_db_cons_age_code_desc,le.maxlength_db_cons_age_in_two_year_hh,le.maxlength_db_cons_ethnic_code,le.maxlength_db_cons_religious_affil,le.maxlength_db_cons_language_pref,le.maxlength_db_cons_phy_addr_std,le.maxlength_db_cons_phy_addr_city,le.maxlength_db_cons_phy_addr_state,le.maxlength_db_cons_phy_addr_zip,le.maxlength_db_cons_phy_addr_zip4,le.maxlength_db_cons_phy_addr_carrierroute,le.maxlength_db_cons_phy_addr_deliverypt,le.maxlength_db_cons_line_of_travel,le.maxlength_db_cons_geocode_results,le.maxlength_db_cons_latitude,le.maxlength_db_cons_longitude,le.maxlength_db_cons_time_zone_code,le.maxlength_db_cons_time_zone_desc,le.maxlength_db_cons_census_tract,le.maxlength_db_cons_census_block,le.maxlength_db_cons_countyfips,le.maxlength_db_countyname,le.maxlength_db_cons_cbsa_code,le.maxlength_db_cons_cbsa_desc,le.maxlength_db_cons_walk_sequence,le.maxlength_db_cons_phone,le.maxlength_db_cons_dnc,le.maxlength_db_cons_scrubbed_phoneable,le.maxlength_db_cons_children_present,le.maxlength_db_cons_home_value_code,le.maxlength_db_cons_home_value_desc,le.maxlength_db_cons_donor_capacity,le.maxlength_db_cons_donor_capacity_code,le.maxlength_db_cons_donor_capacity_desc,le.maxlength_db_cons_home_owner_renter,le.maxlength_db_cons_length_of_res,le.maxlength_db_cons_length_of_res_code,le.maxlength_db_cons_length_of_res_desc,le.maxlength_db_cons_dwelling_type,le.maxlength_db_cons_recent_home_buyer,le.maxlength_db_cons_income_code,le.maxlength_db_cons_income_desc,le.maxlength_db_cons_unsecuredcredcap,le.maxlength_db_cons_unsecuredcredcapcode,le.maxlength_db_cons_unsecuredcredcapdesc,le.maxlength_db_cons_networthhomeval,le.maxlength_db_cons_networthhomevalcode,le.maxlength_db_cons_net_worth_desc,le.maxlength_db_cons_discretincome,le.maxlength_db_cons_discretincomecode,le.maxlength_db_cons_discretincomedesc,le.maxlength_db_cons_marital_status,le.maxlength_db_cons_new_parent,le.maxlength_db_cons_child_near_hs_grad,le.maxlength_db_cons_college_graduate,le.maxlength_db_cons_intend_purchase_veh,le.maxlength_db_cons_recent_divorce,le.maxlength_db_cons_newlywed,le.maxlength_db_cons_new_teen_driver,le.maxlength_db_cons_home_year_built,le.maxlength_db_cons_home_sqft_ranges,le.maxlength_db_cons_poli_party_ind,le.maxlength_db_cons_home_sqft_actual,le.maxlength_db_cons_occupation_ind,le.maxlength_db_cons_credit_card_user,le.maxlength_db_cons_home_property_type,le.maxlength_db_cons_education_hh,le.maxlength_db_cons_education_ind,le.maxlength_db_cons_other_pet_owner,le.maxlength_businesstypedesc,le.maxlength_genderdesc,le.maxlength_executivetypedesc,le.maxlength_dbconsgenderdesc,le.maxlength_dbconsethnicdesc,le.maxlength_dbconsreligiousdesc,le.maxlength_dbconslangprefdesc,le.maxlength_dbconsownerrenter,le.maxlength_dbconsdwellingtypedesc,le.maxlength_dbconsmaritaldesc,le.maxlength_dbconsnewparentdesc,le.maxlength_dbconsteendriverdesc,le.maxlength_dbconspolipartydesc,le.maxlength_dbconsoccupationdesc,le.maxlength_dbconspropertytypedesc,le.maxlength_dbconsheadhouseeducdesc,le.maxlength_dbconseducationdesc,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_raw_aid,le.maxlength_ace_aid,le.maxlength_prep_address_line1,le.maxlength_prep_address_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_process_date,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_record_type,le.avelength_global_sid,le.avelength_dbusa_business_id,le.avelength_dbusa_executive_id,le.avelength_subhq_parent_id,le.avelength_hq_id,le.avelength_ind_frm_indicator,le.avelength_company_name,le.avelength_full_name,le.avelength_prefix,le.avelength_first_name,le.avelength_middle_initial,le.avelength_last_name,le.avelength_suffix,le.avelength_gender,le.avelength_standardized_title,le.avelength_sourcetitle,le.avelength_executive_title_rank,le.avelength_primary_exec_flag,le.avelength_exec_type,le.avelength_executive_department,le.avelength_executive_level,le.avelength_phy_addr_standardized,le.avelength_phy_addr_city,le.avelength_phy_addr_state,le.avelength_phy_addr_zip,le.avelength_phy_addr_zip4,le.avelength_phy_addr_carrierroute,le.avelength_phy_addr_deliverypt,le.avelength_phy_addr_deliveryptchkdig,le.avelength_mail_addr_standardized,le.avelength_mail_addr_city,le.avelength_mail_addr_state,le.avelength_mail_addr_zip,le.avelength_mail_addr_zip4,le.avelength_mail_addr_carrierroute,le.avelength_mail_addr_deliverypt,le.avelength_mail_addr_deliveryptchkdig,le.avelength_mail_score,le.avelength_mail_score_desc,le.avelength_phone,le.avelength_area_code,le.avelength_fax,le.avelength_email,le.avelength_email_available_indicator,le.avelength_url,le.avelength_url_facebook,le.avelength_url_googleplus,le.avelength_url_instagram,le.avelength_url_linkedin,le.avelength_url_twitter,le.avelength_url_youtube,le.avelength_business_status_code,le.avelength_business_status_desc,le.avelength_franchise_flag,le.avelength_franchise_type,le.avelength_franchise_desc,le.avelength_ticker_symbol,le.avelength_stock_exchange,le.avelength_fortune_1000_flag,le.avelength_fortune_1000_rank,le.avelength_fortune_1000_branches,le.avelength_num_linked_locations,le.avelength_county_code,le.avelength_county_desc,le.avelength_cbsa_code,le.avelength_cbsa_desc,le.avelength_geo_match_level,le.avelength_latitude,le.avelength_longitude,le.avelength_scf,le.avelength_timezone,le.avelength_censustract,le.avelength_censusblock,le.avelength_city_population_code,le.avelength_city_population_descr,le.avelength_primary_sic,le.avelength_primary_sic_desc,le.avelength_sic02,le.avelength_sic02_desc,le.avelength_sic03,le.avelength_sic03_desc,le.avelength_sic04,le.avelength_sic04_desc,le.avelength_sic05,le.avelength_sic05_desc,le.avelength_sic06,le.avelength_sic06_desc,le.avelength_primarysic2,le.avelength_primary_2_digit_sic_desc,le.avelength_primarysic4,le.avelength_primary_4_digit_sic_desc,le.avelength_naics01,le.avelength_naics01_desc,le.avelength_naics02,le.avelength_naics02_desc,le.avelength_naics03,le.avelength_naics03_desc,le.avelength_naics04,le.avelength_naics04_desc,le.avelength_naics05,le.avelength_naics05_desc,le.avelength_naics06,le.avelength_naics06_desc,le.avelength_location_employees_total,le.avelength_location_employee_code,le.avelength_location_employee_desc,le.avelength_location_sales_total,le.avelength_location_sales_code,le.avelength_location_sales_desc,le.avelength_corporate_employee_total,le.avelength_corporate_employee_code,le.avelength_corporate_employee_desc,le.avelength_year_established,le.avelength_years_in_business_range,le.avelength_female_owned,le.avelength_minority_owned_flag,le.avelength_minority_type,le.avelength_home_based_indicator,le.avelength_small_business_indicator,le.avelength_import_export,le.avelength_manufacturing_location,le.avelength_public_indicator,le.avelength_ein,le.avelength_non_profit_org,le.avelength_square_footage,le.avelength_square_footage_code,le.avelength_square_footage_desc,le.avelength_creditscore,le.avelength_creditcode,le.avelength_credit_desc,le.avelength_credit_capacity,le.avelength_credit_capacity_code,le.avelength_credit_capacity_desc,le.avelength_advertising_expenses_code,le.avelength_expense_advertising_desc,le.avelength_technology_expenses_code,le.avelength_expense_technology_desc,le.avelength_office_equip_expenses_code,le.avelength_expense_office_equip_desc,le.avelength_rent_expenses_code,le.avelength_expense_rent_desc,le.avelength_telecom_expenses_code,le.avelength_expense_telecom_desc,le.avelength_accounting_expenses_code,le.avelength_expense_accounting_desc,le.avelength_bus_insurance_expense_code,le.avelength_expense_bus_insurance_desc,le.avelength_legal_expenses_code,le.avelength_expense_legal_desc,le.avelength_utilities_expenses_code,le.avelength_expense_utilities_desc,le.avelength_number_of_pcs_code,le.avelength_number_of_pcs_desc,le.avelength_nb_flag,le.avelength_hq_company_name,le.avelength_hq_city,le.avelength_hq_state,le.avelength_subhq_parent_name,le.avelength_subhq_parent_city,le.avelength_subhq_parent_state,le.avelength_domestic_foreign_owner_flag,le.avelength_foreign_parent_company_name,le.avelength_foreign_parent_city,le.avelength_foreign_parent_country,le.avelength_db_cons_matchkey,le.avelength_databaseusa_individual_id,le.avelength_db_cons_full_name,le.avelength_db_cons_full_name_prefix,le.avelength_db_cons_first_name,le.avelength_db_cons_middle_initial,le.avelength_db_cons_last_name,le.avelength_db_cons_email,le.avelength_db_cons_gender,le.avelength_db_cons_date_of_birth_year,le.avelength_db_cons_date_of_birth_month,le.avelength_db_cons_age,le.avelength_db_cons_age_code_desc,le.avelength_db_cons_age_in_two_year_hh,le.avelength_db_cons_ethnic_code,le.avelength_db_cons_religious_affil,le.avelength_db_cons_language_pref,le.avelength_db_cons_phy_addr_std,le.avelength_db_cons_phy_addr_city,le.avelength_db_cons_phy_addr_state,le.avelength_db_cons_phy_addr_zip,le.avelength_db_cons_phy_addr_zip4,le.avelength_db_cons_phy_addr_carrierroute,le.avelength_db_cons_phy_addr_deliverypt,le.avelength_db_cons_line_of_travel,le.avelength_db_cons_geocode_results,le.avelength_db_cons_latitude,le.avelength_db_cons_longitude,le.avelength_db_cons_time_zone_code,le.avelength_db_cons_time_zone_desc,le.avelength_db_cons_census_tract,le.avelength_db_cons_census_block,le.avelength_db_cons_countyfips,le.avelength_db_countyname,le.avelength_db_cons_cbsa_code,le.avelength_db_cons_cbsa_desc,le.avelength_db_cons_walk_sequence,le.avelength_db_cons_phone,le.avelength_db_cons_dnc,le.avelength_db_cons_scrubbed_phoneable,le.avelength_db_cons_children_present,le.avelength_db_cons_home_value_code,le.avelength_db_cons_home_value_desc,le.avelength_db_cons_donor_capacity,le.avelength_db_cons_donor_capacity_code,le.avelength_db_cons_donor_capacity_desc,le.avelength_db_cons_home_owner_renter,le.avelength_db_cons_length_of_res,le.avelength_db_cons_length_of_res_code,le.avelength_db_cons_length_of_res_desc,le.avelength_db_cons_dwelling_type,le.avelength_db_cons_recent_home_buyer,le.avelength_db_cons_income_code,le.avelength_db_cons_income_desc,le.avelength_db_cons_unsecuredcredcap,le.avelength_db_cons_unsecuredcredcapcode,le.avelength_db_cons_unsecuredcredcapdesc,le.avelength_db_cons_networthhomeval,le.avelength_db_cons_networthhomevalcode,le.avelength_db_cons_net_worth_desc,le.avelength_db_cons_discretincome,le.avelength_db_cons_discretincomecode,le.avelength_db_cons_discretincomedesc,le.avelength_db_cons_marital_status,le.avelength_db_cons_new_parent,le.avelength_db_cons_child_near_hs_grad,le.avelength_db_cons_college_graduate,le.avelength_db_cons_intend_purchase_veh,le.avelength_db_cons_recent_divorce,le.avelength_db_cons_newlywed,le.avelength_db_cons_new_teen_driver,le.avelength_db_cons_home_year_built,le.avelength_db_cons_home_sqft_ranges,le.avelength_db_cons_poli_party_ind,le.avelength_db_cons_home_sqft_actual,le.avelength_db_cons_occupation_ind,le.avelength_db_cons_credit_card_user,le.avelength_db_cons_home_property_type,le.avelength_db_cons_education_hh,le.avelength_db_cons_education_ind,le.avelength_db_cons_other_pet_owner,le.avelength_businesstypedesc,le.avelength_genderdesc,le.avelength_executivetypedesc,le.avelength_dbconsgenderdesc,le.avelength_dbconsethnicdesc,le.avelength_dbconsreligiousdesc,le.avelength_dbconslangprefdesc,le.avelength_dbconsownerrenter,le.avelength_dbconsdwellingtypedesc,le.avelength_dbconsmaritaldesc,le.avelength_dbconsnewparentdesc,le.avelength_dbconsteendriverdesc,le.avelength_dbconspolipartydesc,le.avelength_dbconsoccupationdesc,le.avelength_dbconspropertytypedesc,le.avelength_dbconsheadhouseeducdesc,le.avelength_dbconseducationdesc,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_state,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_raw_aid,le.avelength_ace_aid,le.avelength_prep_address_line1,le.avelength_prep_address_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 322, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.seleid;
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.dotid),TRIM((SALT311.StrType)le.dotscore),TRIM((SALT311.StrType)le.dotweight),TRIM((SALT311.StrType)le.empid),TRIM((SALT311.StrType)le.empscore),TRIM((SALT311.StrType)le.empweight),TRIM((SALT311.StrType)le.powid),TRIM((SALT311.StrType)le.powscore),TRIM((SALT311.StrType)le.powweight),TRIM((SALT311.StrType)le.proxid),TRIM((SALT311.StrType)le.proxscore),TRIM((SALT311.StrType)le.proxweight),TRIM((SALT311.StrType)le.selescore),TRIM((SALT311.StrType)le.seleweight),TRIM((SALT311.StrType)le.orgid),TRIM((SALT311.StrType)le.orgscore),TRIM((SALT311.StrType)le.orgweight),TRIM((SALT311.StrType)le.ultid),TRIM((SALT311.StrType)le.ultscore),TRIM((SALT311.StrType)le.ultweight),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.global_sid),TRIM((SALT311.StrType)le.dbusa_business_id),TRIM((SALT311.StrType)le.dbusa_executive_id),TRIM((SALT311.StrType)le.subhq_parent_id),TRIM((SALT311.StrType)le.hq_id),TRIM((SALT311.StrType)le.ind_frm_indicator),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.full_name),TRIM((SALT311.StrType)le.prefix),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.middle_initial),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.standardized_title),TRIM((SALT311.StrType)le.sourcetitle),TRIM((SALT311.StrType)le.executive_title_rank),TRIM((SALT311.StrType)le.primary_exec_flag),TRIM((SALT311.StrType)le.exec_type),TRIM((SALT311.StrType)le.executive_department),TRIM((SALT311.StrType)le.executive_level),TRIM((SALT311.StrType)le.phy_addr_standardized),TRIM((SALT311.StrType)le.phy_addr_city),TRIM((SALT311.StrType)le.phy_addr_state),TRIM((SALT311.StrType)le.phy_addr_zip),TRIM((SALT311.StrType)le.phy_addr_zip4),TRIM((SALT311.StrType)le.phy_addr_carrierroute),TRIM((SALT311.StrType)le.phy_addr_deliverypt),TRIM((SALT311.StrType)le.phy_addr_deliveryptchkdig),TRIM((SALT311.StrType)le.mail_addr_standardized),TRIM((SALT311.StrType)le.mail_addr_city),TRIM((SALT311.StrType)le.mail_addr_state),TRIM((SALT311.StrType)le.mail_addr_zip),TRIM((SALT311.StrType)le.mail_addr_zip4),TRIM((SALT311.StrType)le.mail_addr_carrierroute),TRIM((SALT311.StrType)le.mail_addr_deliverypt),TRIM((SALT311.StrType)le.mail_addr_deliveryptchkdig),TRIM((SALT311.StrType)le.mail_score),TRIM((SALT311.StrType)le.mail_score_desc),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.area_code),TRIM((SALT311.StrType)le.fax),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.email_available_indicator),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.url_facebook),TRIM((SALT311.StrType)le.url_googleplus),TRIM((SALT311.StrType)le.url_instagram),TRIM((SALT311.StrType)le.url_linkedin),TRIM((SALT311.StrType)le.url_twitter),TRIM((SALT311.StrType)le.url_youtube),TRIM((SALT311.StrType)le.business_status_code),TRIM((SALT311.StrType)le.business_status_desc),TRIM((SALT311.StrType)le.franchise_flag),TRIM((SALT311.StrType)le.franchise_type),TRIM((SALT311.StrType)le.franchise_desc),TRIM((SALT311.StrType)le.ticker_symbol),TRIM((SALT311.StrType)le.stock_exchange),TRIM((SALT311.StrType)le.fortune_1000_flag),TRIM((SALT311.StrType)le.fortune_1000_rank),TRIM((SALT311.StrType)le.fortune_1000_branches),TRIM((SALT311.StrType)le.num_linked_locations),TRIM((SALT311.StrType)le.county_code),TRIM((SALT311.StrType)le.county_desc),TRIM((SALT311.StrType)le.cbsa_code),TRIM((SALT311.StrType)le.cbsa_desc),TRIM((SALT311.StrType)le.geo_match_level),TRIM((SALT311.StrType)le.latitude),TRIM((SALT311.StrType)le.longitude),TRIM((SALT311.StrType)le.scf),TRIM((SALT311.StrType)le.timezone),TRIM((SALT311.StrType)le.censustract),TRIM((SALT311.StrType)le.censusblock),TRIM((SALT311.StrType)le.city_population_code),TRIM((SALT311.StrType)le.city_population_descr),TRIM((SALT311.StrType)le.primary_sic),TRIM((SALT311.StrType)le.primary_sic_desc),TRIM((SALT311.StrType)le.sic02),TRIM((SALT311.StrType)le.sic02_desc),TRIM((SALT311.StrType)le.sic03),TRIM((SALT311.StrType)le.sic03_desc),TRIM((SALT311.StrType)le.sic04),TRIM((SALT311.StrType)le.sic04_desc),TRIM((SALT311.StrType)le.sic05),TRIM((SALT311.StrType)le.sic05_desc),TRIM((SALT311.StrType)le.sic06),TRIM((SALT311.StrType)le.sic06_desc),TRIM((SALT311.StrType)le.primarysic2),TRIM((SALT311.StrType)le.primary_2_digit_sic_desc),TRIM((SALT311.StrType)le.primarysic4),TRIM((SALT311.StrType)le.primary_4_digit_sic_desc),TRIM((SALT311.StrType)le.naics01),TRIM((SALT311.StrType)le.naics01_desc),TRIM((SALT311.StrType)le.naics02),TRIM((SALT311.StrType)le.naics02_desc),TRIM((SALT311.StrType)le.naics03),TRIM((SALT311.StrType)le.naics03_desc),TRIM((SALT311.StrType)le.naics04),TRIM((SALT311.StrType)le.naics04_desc),TRIM((SALT311.StrType)le.naics05),TRIM((SALT311.StrType)le.naics05_desc),TRIM((SALT311.StrType)le.naics06),TRIM((SALT311.StrType)le.naics06_desc),TRIM((SALT311.StrType)le.location_employees_total),TRIM((SALT311.StrType)le.location_employee_code),TRIM((SALT311.StrType)le.location_employee_desc),TRIM((SALT311.StrType)le.location_sales_total),TRIM((SALT311.StrType)le.location_sales_code),TRIM((SALT311.StrType)le.location_sales_desc),TRIM((SALT311.StrType)le.corporate_employee_total),TRIM((SALT311.StrType)le.corporate_employee_code),TRIM((SALT311.StrType)le.corporate_employee_desc),TRIM((SALT311.StrType)le.year_established),TRIM((SALT311.StrType)le.years_in_business_range),TRIM((SALT311.StrType)le.female_owned),TRIM((SALT311.StrType)le.minority_owned_flag),TRIM((SALT311.StrType)le.minority_type),TRIM((SALT311.StrType)le.home_based_indicator),TRIM((SALT311.StrType)le.small_business_indicator),TRIM((SALT311.StrType)le.import_export),TRIM((SALT311.StrType)le.manufacturing_location),TRIM((SALT311.StrType)le.public_indicator),TRIM((SALT311.StrType)le.ein),TRIM((SALT311.StrType)le.non_profit_org),TRIM((SALT311.StrType)le.square_footage),TRIM((SALT311.StrType)le.square_footage_code),TRIM((SALT311.StrType)le.square_footage_desc),TRIM((SALT311.StrType)le.creditscore),TRIM((SALT311.StrType)le.creditcode),TRIM((SALT311.StrType)le.credit_desc),TRIM((SALT311.StrType)le.credit_capacity),TRIM((SALT311.StrType)le.credit_capacity_code),TRIM((SALT311.StrType)le.credit_capacity_desc),TRIM((SALT311.StrType)le.advertising_expenses_code),TRIM((SALT311.StrType)le.expense_advertising_desc),TRIM((SALT311.StrType)le.technology_expenses_code),TRIM((SALT311.StrType)le.expense_technology_desc),TRIM((SALT311.StrType)le.office_equip_expenses_code),TRIM((SALT311.StrType)le.expense_office_equip_desc),TRIM((SALT311.StrType)le.rent_expenses_code),TRIM((SALT311.StrType)le.expense_rent_desc),TRIM((SALT311.StrType)le.telecom_expenses_code),TRIM((SALT311.StrType)le.expense_telecom_desc),TRIM((SALT311.StrType)le.accounting_expenses_code),TRIM((SALT311.StrType)le.expense_accounting_desc),TRIM((SALT311.StrType)le.bus_insurance_expense_code),TRIM((SALT311.StrType)le.expense_bus_insurance_desc),TRIM((SALT311.StrType)le.legal_expenses_code),TRIM((SALT311.StrType)le.expense_legal_desc),TRIM((SALT311.StrType)le.utilities_expenses_code),TRIM((SALT311.StrType)le.expense_utilities_desc),TRIM((SALT311.StrType)le.number_of_pcs_code),TRIM((SALT311.StrType)le.number_of_pcs_desc),TRIM((SALT311.StrType)le.nb_flag),TRIM((SALT311.StrType)le.hq_company_name),TRIM((SALT311.StrType)le.hq_city),TRIM((SALT311.StrType)le.hq_state),TRIM((SALT311.StrType)le.subhq_parent_name),TRIM((SALT311.StrType)le.subhq_parent_city),TRIM((SALT311.StrType)le.subhq_parent_state),TRIM((SALT311.StrType)le.domestic_foreign_owner_flag),TRIM((SALT311.StrType)le.foreign_parent_company_name),TRIM((SALT311.StrType)le.foreign_parent_city),TRIM((SALT311.StrType)le.foreign_parent_country),TRIM((SALT311.StrType)le.db_cons_matchkey),TRIM((SALT311.StrType)le.databaseusa_individual_id),TRIM((SALT311.StrType)le.db_cons_full_name),TRIM((SALT311.StrType)le.db_cons_full_name_prefix),TRIM((SALT311.StrType)le.db_cons_first_name),TRIM((SALT311.StrType)le.db_cons_middle_initial),TRIM((SALT311.StrType)le.db_cons_last_name),TRIM((SALT311.StrType)le.db_cons_email),TRIM((SALT311.StrType)le.db_cons_gender),TRIM((SALT311.StrType)le.db_cons_date_of_birth_year),TRIM((SALT311.StrType)le.db_cons_date_of_birth_month),TRIM((SALT311.StrType)le.db_cons_age),TRIM((SALT311.StrType)le.db_cons_age_code_desc),TRIM((SALT311.StrType)le.db_cons_age_in_two_year_hh),TRIM((SALT311.StrType)le.db_cons_ethnic_code),TRIM((SALT311.StrType)le.db_cons_religious_affil),TRIM((SALT311.StrType)le.db_cons_language_pref),TRIM((SALT311.StrType)le.db_cons_phy_addr_std),TRIM((SALT311.StrType)le.db_cons_phy_addr_city),TRIM((SALT311.StrType)le.db_cons_phy_addr_state),TRIM((SALT311.StrType)le.db_cons_phy_addr_zip),TRIM((SALT311.StrType)le.db_cons_phy_addr_zip4),TRIM((SALT311.StrType)le.db_cons_phy_addr_carrierroute),TRIM((SALT311.StrType)le.db_cons_phy_addr_deliverypt),TRIM((SALT311.StrType)le.db_cons_line_of_travel),TRIM((SALT311.StrType)le.db_cons_geocode_results),TRIM((SALT311.StrType)le.db_cons_latitude),TRIM((SALT311.StrType)le.db_cons_longitude),TRIM((SALT311.StrType)le.db_cons_time_zone_code),TRIM((SALT311.StrType)le.db_cons_time_zone_desc),TRIM((SALT311.StrType)le.db_cons_census_tract),TRIM((SALT311.StrType)le.db_cons_census_block),TRIM((SALT311.StrType)le.db_cons_countyfips),TRIM((SALT311.StrType)le.db_countyname),TRIM((SALT311.StrType)le.db_cons_cbsa_code),TRIM((SALT311.StrType)le.db_cons_cbsa_desc),TRIM((SALT311.StrType)le.db_cons_walk_sequence),TRIM((SALT311.StrType)le.db_cons_phone),TRIM((SALT311.StrType)le.db_cons_dnc),TRIM((SALT311.StrType)le.db_cons_scrubbed_phoneable),TRIM((SALT311.StrType)le.db_cons_children_present),TRIM((SALT311.StrType)le.db_cons_home_value_code),TRIM((SALT311.StrType)le.db_cons_home_value_desc),TRIM((SALT311.StrType)le.db_cons_donor_capacity),TRIM((SALT311.StrType)le.db_cons_donor_capacity_code),TRIM((SALT311.StrType)le.db_cons_donor_capacity_desc),TRIM((SALT311.StrType)le.db_cons_home_owner_renter),TRIM((SALT311.StrType)le.db_cons_length_of_res),TRIM((SALT311.StrType)le.db_cons_length_of_res_code),TRIM((SALT311.StrType)le.db_cons_length_of_res_desc),TRIM((SALT311.StrType)le.db_cons_dwelling_type),TRIM((SALT311.StrType)le.db_cons_recent_home_buyer),TRIM((SALT311.StrType)le.db_cons_income_code),TRIM((SALT311.StrType)le.db_cons_income_desc),TRIM((SALT311.StrType)le.db_cons_unsecuredcredcap),TRIM((SALT311.StrType)le.db_cons_unsecuredcredcapcode),TRIM((SALT311.StrType)le.db_cons_unsecuredcredcapdesc),TRIM((SALT311.StrType)le.db_cons_networthhomeval),TRIM((SALT311.StrType)le.db_cons_networthhomevalcode),TRIM((SALT311.StrType)le.db_cons_net_worth_desc),TRIM((SALT311.StrType)le.db_cons_discretincome),TRIM((SALT311.StrType)le.db_cons_discretincomecode),TRIM((SALT311.StrType)le.db_cons_discretincomedesc),TRIM((SALT311.StrType)le.db_cons_marital_status),TRIM((SALT311.StrType)le.db_cons_new_parent),TRIM((SALT311.StrType)le.db_cons_child_near_hs_grad),TRIM((SALT311.StrType)le.db_cons_college_graduate),TRIM((SALT311.StrType)le.db_cons_intend_purchase_veh),TRIM((SALT311.StrType)le.db_cons_recent_divorce),TRIM((SALT311.StrType)le.db_cons_newlywed),TRIM((SALT311.StrType)le.db_cons_new_teen_driver),TRIM((SALT311.StrType)le.db_cons_home_year_built),TRIM((SALT311.StrType)le.db_cons_home_sqft_ranges),TRIM((SALT311.StrType)le.db_cons_poli_party_ind),TRIM((SALT311.StrType)le.db_cons_home_sqft_actual),TRIM((SALT311.StrType)le.db_cons_occupation_ind),TRIM((SALT311.StrType)le.db_cons_credit_card_user),TRIM((SALT311.StrType)le.db_cons_home_property_type),TRIM((SALT311.StrType)le.db_cons_education_hh),TRIM((SALT311.StrType)le.db_cons_education_ind),TRIM((SALT311.StrType)le.db_cons_other_pet_owner),TRIM((SALT311.StrType)le.businesstypedesc),TRIM((SALT311.StrType)le.genderdesc),TRIM((SALT311.StrType)le.executivetypedesc),TRIM((SALT311.StrType)le.dbconsgenderdesc),TRIM((SALT311.StrType)le.dbconsethnicdesc),TRIM((SALT311.StrType)le.dbconsreligiousdesc),TRIM((SALT311.StrType)le.dbconslangprefdesc),TRIM((SALT311.StrType)le.dbconsownerrenter),TRIM((SALT311.StrType)le.dbconsdwellingtypedesc),TRIM((SALT311.StrType)le.dbconsmaritaldesc),TRIM((SALT311.StrType)le.dbconsnewparentdesc),TRIM((SALT311.StrType)le.dbconsteendriverdesc),TRIM((SALT311.StrType)le.dbconspolipartydesc),TRIM((SALT311.StrType)le.dbconsoccupationdesc),TRIM((SALT311.StrType)le.dbconspropertytypedesc),TRIM((SALT311.StrType)le.dbconsheadhouseeducdesc),TRIM((SALT311.StrType)le.dbconseducationdesc),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.raw_aid),TRIM((SALT311.StrType)le.ace_aid),TRIM((SALT311.StrType)le.prep_address_line1),TRIM((SALT311.StrType)le.prep_address_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,322,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 322);
  SELF.FldNo2 := 1 + (C % 322);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.dotid),TRIM((SALT311.StrType)le.dotscore),TRIM((SALT311.StrType)le.dotweight),TRIM((SALT311.StrType)le.empid),TRIM((SALT311.StrType)le.empscore),TRIM((SALT311.StrType)le.empweight),TRIM((SALT311.StrType)le.powid),TRIM((SALT311.StrType)le.powscore),TRIM((SALT311.StrType)le.powweight),TRIM((SALT311.StrType)le.proxid),TRIM((SALT311.StrType)le.proxscore),TRIM((SALT311.StrType)le.proxweight),TRIM((SALT311.StrType)le.selescore),TRIM((SALT311.StrType)le.seleweight),TRIM((SALT311.StrType)le.orgid),TRIM((SALT311.StrType)le.orgscore),TRIM((SALT311.StrType)le.orgweight),TRIM((SALT311.StrType)le.ultid),TRIM((SALT311.StrType)le.ultscore),TRIM((SALT311.StrType)le.ultweight),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.global_sid),TRIM((SALT311.StrType)le.dbusa_business_id),TRIM((SALT311.StrType)le.dbusa_executive_id),TRIM((SALT311.StrType)le.subhq_parent_id),TRIM((SALT311.StrType)le.hq_id),TRIM((SALT311.StrType)le.ind_frm_indicator),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.full_name),TRIM((SALT311.StrType)le.prefix),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.middle_initial),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.standardized_title),TRIM((SALT311.StrType)le.sourcetitle),TRIM((SALT311.StrType)le.executive_title_rank),TRIM((SALT311.StrType)le.primary_exec_flag),TRIM((SALT311.StrType)le.exec_type),TRIM((SALT311.StrType)le.executive_department),TRIM((SALT311.StrType)le.executive_level),TRIM((SALT311.StrType)le.phy_addr_standardized),TRIM((SALT311.StrType)le.phy_addr_city),TRIM((SALT311.StrType)le.phy_addr_state),TRIM((SALT311.StrType)le.phy_addr_zip),TRIM((SALT311.StrType)le.phy_addr_zip4),TRIM((SALT311.StrType)le.phy_addr_carrierroute),TRIM((SALT311.StrType)le.phy_addr_deliverypt),TRIM((SALT311.StrType)le.phy_addr_deliveryptchkdig),TRIM((SALT311.StrType)le.mail_addr_standardized),TRIM((SALT311.StrType)le.mail_addr_city),TRIM((SALT311.StrType)le.mail_addr_state),TRIM((SALT311.StrType)le.mail_addr_zip),TRIM((SALT311.StrType)le.mail_addr_zip4),TRIM((SALT311.StrType)le.mail_addr_carrierroute),TRIM((SALT311.StrType)le.mail_addr_deliverypt),TRIM((SALT311.StrType)le.mail_addr_deliveryptchkdig),TRIM((SALT311.StrType)le.mail_score),TRIM((SALT311.StrType)le.mail_score_desc),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.area_code),TRIM((SALT311.StrType)le.fax),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.email_available_indicator),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.url_facebook),TRIM((SALT311.StrType)le.url_googleplus),TRIM((SALT311.StrType)le.url_instagram),TRIM((SALT311.StrType)le.url_linkedin),TRIM((SALT311.StrType)le.url_twitter),TRIM((SALT311.StrType)le.url_youtube),TRIM((SALT311.StrType)le.business_status_code),TRIM((SALT311.StrType)le.business_status_desc),TRIM((SALT311.StrType)le.franchise_flag),TRIM((SALT311.StrType)le.franchise_type),TRIM((SALT311.StrType)le.franchise_desc),TRIM((SALT311.StrType)le.ticker_symbol),TRIM((SALT311.StrType)le.stock_exchange),TRIM((SALT311.StrType)le.fortune_1000_flag),TRIM((SALT311.StrType)le.fortune_1000_rank),TRIM((SALT311.StrType)le.fortune_1000_branches),TRIM((SALT311.StrType)le.num_linked_locations),TRIM((SALT311.StrType)le.county_code),TRIM((SALT311.StrType)le.county_desc),TRIM((SALT311.StrType)le.cbsa_code),TRIM((SALT311.StrType)le.cbsa_desc),TRIM((SALT311.StrType)le.geo_match_level),TRIM((SALT311.StrType)le.latitude),TRIM((SALT311.StrType)le.longitude),TRIM((SALT311.StrType)le.scf),TRIM((SALT311.StrType)le.timezone),TRIM((SALT311.StrType)le.censustract),TRIM((SALT311.StrType)le.censusblock),TRIM((SALT311.StrType)le.city_population_code),TRIM((SALT311.StrType)le.city_population_descr),TRIM((SALT311.StrType)le.primary_sic),TRIM((SALT311.StrType)le.primary_sic_desc),TRIM((SALT311.StrType)le.sic02),TRIM((SALT311.StrType)le.sic02_desc),TRIM((SALT311.StrType)le.sic03),TRIM((SALT311.StrType)le.sic03_desc),TRIM((SALT311.StrType)le.sic04),TRIM((SALT311.StrType)le.sic04_desc),TRIM((SALT311.StrType)le.sic05),TRIM((SALT311.StrType)le.sic05_desc),TRIM((SALT311.StrType)le.sic06),TRIM((SALT311.StrType)le.sic06_desc),TRIM((SALT311.StrType)le.primarysic2),TRIM((SALT311.StrType)le.primary_2_digit_sic_desc),TRIM((SALT311.StrType)le.primarysic4),TRIM((SALT311.StrType)le.primary_4_digit_sic_desc),TRIM((SALT311.StrType)le.naics01),TRIM((SALT311.StrType)le.naics01_desc),TRIM((SALT311.StrType)le.naics02),TRIM((SALT311.StrType)le.naics02_desc),TRIM((SALT311.StrType)le.naics03),TRIM((SALT311.StrType)le.naics03_desc),TRIM((SALT311.StrType)le.naics04),TRIM((SALT311.StrType)le.naics04_desc),TRIM((SALT311.StrType)le.naics05),TRIM((SALT311.StrType)le.naics05_desc),TRIM((SALT311.StrType)le.naics06),TRIM((SALT311.StrType)le.naics06_desc),TRIM((SALT311.StrType)le.location_employees_total),TRIM((SALT311.StrType)le.location_employee_code),TRIM((SALT311.StrType)le.location_employee_desc),TRIM((SALT311.StrType)le.location_sales_total),TRIM((SALT311.StrType)le.location_sales_code),TRIM((SALT311.StrType)le.location_sales_desc),TRIM((SALT311.StrType)le.corporate_employee_total),TRIM((SALT311.StrType)le.corporate_employee_code),TRIM((SALT311.StrType)le.corporate_employee_desc),TRIM((SALT311.StrType)le.year_established),TRIM((SALT311.StrType)le.years_in_business_range),TRIM((SALT311.StrType)le.female_owned),TRIM((SALT311.StrType)le.minority_owned_flag),TRIM((SALT311.StrType)le.minority_type),TRIM((SALT311.StrType)le.home_based_indicator),TRIM((SALT311.StrType)le.small_business_indicator),TRIM((SALT311.StrType)le.import_export),TRIM((SALT311.StrType)le.manufacturing_location),TRIM((SALT311.StrType)le.public_indicator),TRIM((SALT311.StrType)le.ein),TRIM((SALT311.StrType)le.non_profit_org),TRIM((SALT311.StrType)le.square_footage),TRIM((SALT311.StrType)le.square_footage_code),TRIM((SALT311.StrType)le.square_footage_desc),TRIM((SALT311.StrType)le.creditscore),TRIM((SALT311.StrType)le.creditcode),TRIM((SALT311.StrType)le.credit_desc),TRIM((SALT311.StrType)le.credit_capacity),TRIM((SALT311.StrType)le.credit_capacity_code),TRIM((SALT311.StrType)le.credit_capacity_desc),TRIM((SALT311.StrType)le.advertising_expenses_code),TRIM((SALT311.StrType)le.expense_advertising_desc),TRIM((SALT311.StrType)le.technology_expenses_code),TRIM((SALT311.StrType)le.expense_technology_desc),TRIM((SALT311.StrType)le.office_equip_expenses_code),TRIM((SALT311.StrType)le.expense_office_equip_desc),TRIM((SALT311.StrType)le.rent_expenses_code),TRIM((SALT311.StrType)le.expense_rent_desc),TRIM((SALT311.StrType)le.telecom_expenses_code),TRIM((SALT311.StrType)le.expense_telecom_desc),TRIM((SALT311.StrType)le.accounting_expenses_code),TRIM((SALT311.StrType)le.expense_accounting_desc),TRIM((SALT311.StrType)le.bus_insurance_expense_code),TRIM((SALT311.StrType)le.expense_bus_insurance_desc),TRIM((SALT311.StrType)le.legal_expenses_code),TRIM((SALT311.StrType)le.expense_legal_desc),TRIM((SALT311.StrType)le.utilities_expenses_code),TRIM((SALT311.StrType)le.expense_utilities_desc),TRIM((SALT311.StrType)le.number_of_pcs_code),TRIM((SALT311.StrType)le.number_of_pcs_desc),TRIM((SALT311.StrType)le.nb_flag),TRIM((SALT311.StrType)le.hq_company_name),TRIM((SALT311.StrType)le.hq_city),TRIM((SALT311.StrType)le.hq_state),TRIM((SALT311.StrType)le.subhq_parent_name),TRIM((SALT311.StrType)le.subhq_parent_city),TRIM((SALT311.StrType)le.subhq_parent_state),TRIM((SALT311.StrType)le.domestic_foreign_owner_flag),TRIM((SALT311.StrType)le.foreign_parent_company_name),TRIM((SALT311.StrType)le.foreign_parent_city),TRIM((SALT311.StrType)le.foreign_parent_country),TRIM((SALT311.StrType)le.db_cons_matchkey),TRIM((SALT311.StrType)le.databaseusa_individual_id),TRIM((SALT311.StrType)le.db_cons_full_name),TRIM((SALT311.StrType)le.db_cons_full_name_prefix),TRIM((SALT311.StrType)le.db_cons_first_name),TRIM((SALT311.StrType)le.db_cons_middle_initial),TRIM((SALT311.StrType)le.db_cons_last_name),TRIM((SALT311.StrType)le.db_cons_email),TRIM((SALT311.StrType)le.db_cons_gender),TRIM((SALT311.StrType)le.db_cons_date_of_birth_year),TRIM((SALT311.StrType)le.db_cons_date_of_birth_month),TRIM((SALT311.StrType)le.db_cons_age),TRIM((SALT311.StrType)le.db_cons_age_code_desc),TRIM((SALT311.StrType)le.db_cons_age_in_two_year_hh),TRIM((SALT311.StrType)le.db_cons_ethnic_code),TRIM((SALT311.StrType)le.db_cons_religious_affil),TRIM((SALT311.StrType)le.db_cons_language_pref),TRIM((SALT311.StrType)le.db_cons_phy_addr_std),TRIM((SALT311.StrType)le.db_cons_phy_addr_city),TRIM((SALT311.StrType)le.db_cons_phy_addr_state),TRIM((SALT311.StrType)le.db_cons_phy_addr_zip),TRIM((SALT311.StrType)le.db_cons_phy_addr_zip4),TRIM((SALT311.StrType)le.db_cons_phy_addr_carrierroute),TRIM((SALT311.StrType)le.db_cons_phy_addr_deliverypt),TRIM((SALT311.StrType)le.db_cons_line_of_travel),TRIM((SALT311.StrType)le.db_cons_geocode_results),TRIM((SALT311.StrType)le.db_cons_latitude),TRIM((SALT311.StrType)le.db_cons_longitude),TRIM((SALT311.StrType)le.db_cons_time_zone_code),TRIM((SALT311.StrType)le.db_cons_time_zone_desc),TRIM((SALT311.StrType)le.db_cons_census_tract),TRIM((SALT311.StrType)le.db_cons_census_block),TRIM((SALT311.StrType)le.db_cons_countyfips),TRIM((SALT311.StrType)le.db_countyname),TRIM((SALT311.StrType)le.db_cons_cbsa_code),TRIM((SALT311.StrType)le.db_cons_cbsa_desc),TRIM((SALT311.StrType)le.db_cons_walk_sequence),TRIM((SALT311.StrType)le.db_cons_phone),TRIM((SALT311.StrType)le.db_cons_dnc),TRIM((SALT311.StrType)le.db_cons_scrubbed_phoneable),TRIM((SALT311.StrType)le.db_cons_children_present),TRIM((SALT311.StrType)le.db_cons_home_value_code),TRIM((SALT311.StrType)le.db_cons_home_value_desc),TRIM((SALT311.StrType)le.db_cons_donor_capacity),TRIM((SALT311.StrType)le.db_cons_donor_capacity_code),TRIM((SALT311.StrType)le.db_cons_donor_capacity_desc),TRIM((SALT311.StrType)le.db_cons_home_owner_renter),TRIM((SALT311.StrType)le.db_cons_length_of_res),TRIM((SALT311.StrType)le.db_cons_length_of_res_code),TRIM((SALT311.StrType)le.db_cons_length_of_res_desc),TRIM((SALT311.StrType)le.db_cons_dwelling_type),TRIM((SALT311.StrType)le.db_cons_recent_home_buyer),TRIM((SALT311.StrType)le.db_cons_income_code),TRIM((SALT311.StrType)le.db_cons_income_desc),TRIM((SALT311.StrType)le.db_cons_unsecuredcredcap),TRIM((SALT311.StrType)le.db_cons_unsecuredcredcapcode),TRIM((SALT311.StrType)le.db_cons_unsecuredcredcapdesc),TRIM((SALT311.StrType)le.db_cons_networthhomeval),TRIM((SALT311.StrType)le.db_cons_networthhomevalcode),TRIM((SALT311.StrType)le.db_cons_net_worth_desc),TRIM((SALT311.StrType)le.db_cons_discretincome),TRIM((SALT311.StrType)le.db_cons_discretincomecode),TRIM((SALT311.StrType)le.db_cons_discretincomedesc),TRIM((SALT311.StrType)le.db_cons_marital_status),TRIM((SALT311.StrType)le.db_cons_new_parent),TRIM((SALT311.StrType)le.db_cons_child_near_hs_grad),TRIM((SALT311.StrType)le.db_cons_college_graduate),TRIM((SALT311.StrType)le.db_cons_intend_purchase_veh),TRIM((SALT311.StrType)le.db_cons_recent_divorce),TRIM((SALT311.StrType)le.db_cons_newlywed),TRIM((SALT311.StrType)le.db_cons_new_teen_driver),TRIM((SALT311.StrType)le.db_cons_home_year_built),TRIM((SALT311.StrType)le.db_cons_home_sqft_ranges),TRIM((SALT311.StrType)le.db_cons_poli_party_ind),TRIM((SALT311.StrType)le.db_cons_home_sqft_actual),TRIM((SALT311.StrType)le.db_cons_occupation_ind),TRIM((SALT311.StrType)le.db_cons_credit_card_user),TRIM((SALT311.StrType)le.db_cons_home_property_type),TRIM((SALT311.StrType)le.db_cons_education_hh),TRIM((SALT311.StrType)le.db_cons_education_ind),TRIM((SALT311.StrType)le.db_cons_other_pet_owner),TRIM((SALT311.StrType)le.businesstypedesc),TRIM((SALT311.StrType)le.genderdesc),TRIM((SALT311.StrType)le.executivetypedesc),TRIM((SALT311.StrType)le.dbconsgenderdesc),TRIM((SALT311.StrType)le.dbconsethnicdesc),TRIM((SALT311.StrType)le.dbconsreligiousdesc),TRIM((SALT311.StrType)le.dbconslangprefdesc),TRIM((SALT311.StrType)le.dbconsownerrenter),TRIM((SALT311.StrType)le.dbconsdwellingtypedesc),TRIM((SALT311.StrType)le.dbconsmaritaldesc),TRIM((SALT311.StrType)le.dbconsnewparentdesc),TRIM((SALT311.StrType)le.dbconsteendriverdesc),TRIM((SALT311.StrType)le.dbconspolipartydesc),TRIM((SALT311.StrType)le.dbconsoccupationdesc),TRIM((SALT311.StrType)le.dbconspropertytypedesc),TRIM((SALT311.StrType)le.dbconsheadhouseeducdesc),TRIM((SALT311.StrType)le.dbconseducationdesc),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.raw_aid),TRIM((SALT311.StrType)le.ace_aid),TRIM((SALT311.StrType)le.prep_address_line1),TRIM((SALT311.StrType)le.prep_address_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.dotid),TRIM((SALT311.StrType)le.dotscore),TRIM((SALT311.StrType)le.dotweight),TRIM((SALT311.StrType)le.empid),TRIM((SALT311.StrType)le.empscore),TRIM((SALT311.StrType)le.empweight),TRIM((SALT311.StrType)le.powid),TRIM((SALT311.StrType)le.powscore),TRIM((SALT311.StrType)le.powweight),TRIM((SALT311.StrType)le.proxid),TRIM((SALT311.StrType)le.proxscore),TRIM((SALT311.StrType)le.proxweight),TRIM((SALT311.StrType)le.selescore),TRIM((SALT311.StrType)le.seleweight),TRIM((SALT311.StrType)le.orgid),TRIM((SALT311.StrType)le.orgscore),TRIM((SALT311.StrType)le.orgweight),TRIM((SALT311.StrType)le.ultid),TRIM((SALT311.StrType)le.ultscore),TRIM((SALT311.StrType)le.ultweight),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.global_sid),TRIM((SALT311.StrType)le.dbusa_business_id),TRIM((SALT311.StrType)le.dbusa_executive_id),TRIM((SALT311.StrType)le.subhq_parent_id),TRIM((SALT311.StrType)le.hq_id),TRIM((SALT311.StrType)le.ind_frm_indicator),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.full_name),TRIM((SALT311.StrType)le.prefix),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.middle_initial),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.standardized_title),TRIM((SALT311.StrType)le.sourcetitle),TRIM((SALT311.StrType)le.executive_title_rank),TRIM((SALT311.StrType)le.primary_exec_flag),TRIM((SALT311.StrType)le.exec_type),TRIM((SALT311.StrType)le.executive_department),TRIM((SALT311.StrType)le.executive_level),TRIM((SALT311.StrType)le.phy_addr_standardized),TRIM((SALT311.StrType)le.phy_addr_city),TRIM((SALT311.StrType)le.phy_addr_state),TRIM((SALT311.StrType)le.phy_addr_zip),TRIM((SALT311.StrType)le.phy_addr_zip4),TRIM((SALT311.StrType)le.phy_addr_carrierroute),TRIM((SALT311.StrType)le.phy_addr_deliverypt),TRIM((SALT311.StrType)le.phy_addr_deliveryptchkdig),TRIM((SALT311.StrType)le.mail_addr_standardized),TRIM((SALT311.StrType)le.mail_addr_city),TRIM((SALT311.StrType)le.mail_addr_state),TRIM((SALT311.StrType)le.mail_addr_zip),TRIM((SALT311.StrType)le.mail_addr_zip4),TRIM((SALT311.StrType)le.mail_addr_carrierroute),TRIM((SALT311.StrType)le.mail_addr_deliverypt),TRIM((SALT311.StrType)le.mail_addr_deliveryptchkdig),TRIM((SALT311.StrType)le.mail_score),TRIM((SALT311.StrType)le.mail_score_desc),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.area_code),TRIM((SALT311.StrType)le.fax),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.email_available_indicator),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.url_facebook),TRIM((SALT311.StrType)le.url_googleplus),TRIM((SALT311.StrType)le.url_instagram),TRIM((SALT311.StrType)le.url_linkedin),TRIM((SALT311.StrType)le.url_twitter),TRIM((SALT311.StrType)le.url_youtube),TRIM((SALT311.StrType)le.business_status_code),TRIM((SALT311.StrType)le.business_status_desc),TRIM((SALT311.StrType)le.franchise_flag),TRIM((SALT311.StrType)le.franchise_type),TRIM((SALT311.StrType)le.franchise_desc),TRIM((SALT311.StrType)le.ticker_symbol),TRIM((SALT311.StrType)le.stock_exchange),TRIM((SALT311.StrType)le.fortune_1000_flag),TRIM((SALT311.StrType)le.fortune_1000_rank),TRIM((SALT311.StrType)le.fortune_1000_branches),TRIM((SALT311.StrType)le.num_linked_locations),TRIM((SALT311.StrType)le.county_code),TRIM((SALT311.StrType)le.county_desc),TRIM((SALT311.StrType)le.cbsa_code),TRIM((SALT311.StrType)le.cbsa_desc),TRIM((SALT311.StrType)le.geo_match_level),TRIM((SALT311.StrType)le.latitude),TRIM((SALT311.StrType)le.longitude),TRIM((SALT311.StrType)le.scf),TRIM((SALT311.StrType)le.timezone),TRIM((SALT311.StrType)le.censustract),TRIM((SALT311.StrType)le.censusblock),TRIM((SALT311.StrType)le.city_population_code),TRIM((SALT311.StrType)le.city_population_descr),TRIM((SALT311.StrType)le.primary_sic),TRIM((SALT311.StrType)le.primary_sic_desc),TRIM((SALT311.StrType)le.sic02),TRIM((SALT311.StrType)le.sic02_desc),TRIM((SALT311.StrType)le.sic03),TRIM((SALT311.StrType)le.sic03_desc),TRIM((SALT311.StrType)le.sic04),TRIM((SALT311.StrType)le.sic04_desc),TRIM((SALT311.StrType)le.sic05),TRIM((SALT311.StrType)le.sic05_desc),TRIM((SALT311.StrType)le.sic06),TRIM((SALT311.StrType)le.sic06_desc),TRIM((SALT311.StrType)le.primarysic2),TRIM((SALT311.StrType)le.primary_2_digit_sic_desc),TRIM((SALT311.StrType)le.primarysic4),TRIM((SALT311.StrType)le.primary_4_digit_sic_desc),TRIM((SALT311.StrType)le.naics01),TRIM((SALT311.StrType)le.naics01_desc),TRIM((SALT311.StrType)le.naics02),TRIM((SALT311.StrType)le.naics02_desc),TRIM((SALT311.StrType)le.naics03),TRIM((SALT311.StrType)le.naics03_desc),TRIM((SALT311.StrType)le.naics04),TRIM((SALT311.StrType)le.naics04_desc),TRIM((SALT311.StrType)le.naics05),TRIM((SALT311.StrType)le.naics05_desc),TRIM((SALT311.StrType)le.naics06),TRIM((SALT311.StrType)le.naics06_desc),TRIM((SALT311.StrType)le.location_employees_total),TRIM((SALT311.StrType)le.location_employee_code),TRIM((SALT311.StrType)le.location_employee_desc),TRIM((SALT311.StrType)le.location_sales_total),TRIM((SALT311.StrType)le.location_sales_code),TRIM((SALT311.StrType)le.location_sales_desc),TRIM((SALT311.StrType)le.corporate_employee_total),TRIM((SALT311.StrType)le.corporate_employee_code),TRIM((SALT311.StrType)le.corporate_employee_desc),TRIM((SALT311.StrType)le.year_established),TRIM((SALT311.StrType)le.years_in_business_range),TRIM((SALT311.StrType)le.female_owned),TRIM((SALT311.StrType)le.minority_owned_flag),TRIM((SALT311.StrType)le.minority_type),TRIM((SALT311.StrType)le.home_based_indicator),TRIM((SALT311.StrType)le.small_business_indicator),TRIM((SALT311.StrType)le.import_export),TRIM((SALT311.StrType)le.manufacturing_location),TRIM((SALT311.StrType)le.public_indicator),TRIM((SALT311.StrType)le.ein),TRIM((SALT311.StrType)le.non_profit_org),TRIM((SALT311.StrType)le.square_footage),TRIM((SALT311.StrType)le.square_footage_code),TRIM((SALT311.StrType)le.square_footage_desc),TRIM((SALT311.StrType)le.creditscore),TRIM((SALT311.StrType)le.creditcode),TRIM((SALT311.StrType)le.credit_desc),TRIM((SALT311.StrType)le.credit_capacity),TRIM((SALT311.StrType)le.credit_capacity_code),TRIM((SALT311.StrType)le.credit_capacity_desc),TRIM((SALT311.StrType)le.advertising_expenses_code),TRIM((SALT311.StrType)le.expense_advertising_desc),TRIM((SALT311.StrType)le.technology_expenses_code),TRIM((SALT311.StrType)le.expense_technology_desc),TRIM((SALT311.StrType)le.office_equip_expenses_code),TRIM((SALT311.StrType)le.expense_office_equip_desc),TRIM((SALT311.StrType)le.rent_expenses_code),TRIM((SALT311.StrType)le.expense_rent_desc),TRIM((SALT311.StrType)le.telecom_expenses_code),TRIM((SALT311.StrType)le.expense_telecom_desc),TRIM((SALT311.StrType)le.accounting_expenses_code),TRIM((SALT311.StrType)le.expense_accounting_desc),TRIM((SALT311.StrType)le.bus_insurance_expense_code),TRIM((SALT311.StrType)le.expense_bus_insurance_desc),TRIM((SALT311.StrType)le.legal_expenses_code),TRIM((SALT311.StrType)le.expense_legal_desc),TRIM((SALT311.StrType)le.utilities_expenses_code),TRIM((SALT311.StrType)le.expense_utilities_desc),TRIM((SALT311.StrType)le.number_of_pcs_code),TRIM((SALT311.StrType)le.number_of_pcs_desc),TRIM((SALT311.StrType)le.nb_flag),TRIM((SALT311.StrType)le.hq_company_name),TRIM((SALT311.StrType)le.hq_city),TRIM((SALT311.StrType)le.hq_state),TRIM((SALT311.StrType)le.subhq_parent_name),TRIM((SALT311.StrType)le.subhq_parent_city),TRIM((SALT311.StrType)le.subhq_parent_state),TRIM((SALT311.StrType)le.domestic_foreign_owner_flag),TRIM((SALT311.StrType)le.foreign_parent_company_name),TRIM((SALT311.StrType)le.foreign_parent_city),TRIM((SALT311.StrType)le.foreign_parent_country),TRIM((SALT311.StrType)le.db_cons_matchkey),TRIM((SALT311.StrType)le.databaseusa_individual_id),TRIM((SALT311.StrType)le.db_cons_full_name),TRIM((SALT311.StrType)le.db_cons_full_name_prefix),TRIM((SALT311.StrType)le.db_cons_first_name),TRIM((SALT311.StrType)le.db_cons_middle_initial),TRIM((SALT311.StrType)le.db_cons_last_name),TRIM((SALT311.StrType)le.db_cons_email),TRIM((SALT311.StrType)le.db_cons_gender),TRIM((SALT311.StrType)le.db_cons_date_of_birth_year),TRIM((SALT311.StrType)le.db_cons_date_of_birth_month),TRIM((SALT311.StrType)le.db_cons_age),TRIM((SALT311.StrType)le.db_cons_age_code_desc),TRIM((SALT311.StrType)le.db_cons_age_in_two_year_hh),TRIM((SALT311.StrType)le.db_cons_ethnic_code),TRIM((SALT311.StrType)le.db_cons_religious_affil),TRIM((SALT311.StrType)le.db_cons_language_pref),TRIM((SALT311.StrType)le.db_cons_phy_addr_std),TRIM((SALT311.StrType)le.db_cons_phy_addr_city),TRIM((SALT311.StrType)le.db_cons_phy_addr_state),TRIM((SALT311.StrType)le.db_cons_phy_addr_zip),TRIM((SALT311.StrType)le.db_cons_phy_addr_zip4),TRIM((SALT311.StrType)le.db_cons_phy_addr_carrierroute),TRIM((SALT311.StrType)le.db_cons_phy_addr_deliverypt),TRIM((SALT311.StrType)le.db_cons_line_of_travel),TRIM((SALT311.StrType)le.db_cons_geocode_results),TRIM((SALT311.StrType)le.db_cons_latitude),TRIM((SALT311.StrType)le.db_cons_longitude),TRIM((SALT311.StrType)le.db_cons_time_zone_code),TRIM((SALT311.StrType)le.db_cons_time_zone_desc),TRIM((SALT311.StrType)le.db_cons_census_tract),TRIM((SALT311.StrType)le.db_cons_census_block),TRIM((SALT311.StrType)le.db_cons_countyfips),TRIM((SALT311.StrType)le.db_countyname),TRIM((SALT311.StrType)le.db_cons_cbsa_code),TRIM((SALT311.StrType)le.db_cons_cbsa_desc),TRIM((SALT311.StrType)le.db_cons_walk_sequence),TRIM((SALT311.StrType)le.db_cons_phone),TRIM((SALT311.StrType)le.db_cons_dnc),TRIM((SALT311.StrType)le.db_cons_scrubbed_phoneable),TRIM((SALT311.StrType)le.db_cons_children_present),TRIM((SALT311.StrType)le.db_cons_home_value_code),TRIM((SALT311.StrType)le.db_cons_home_value_desc),TRIM((SALT311.StrType)le.db_cons_donor_capacity),TRIM((SALT311.StrType)le.db_cons_donor_capacity_code),TRIM((SALT311.StrType)le.db_cons_donor_capacity_desc),TRIM((SALT311.StrType)le.db_cons_home_owner_renter),TRIM((SALT311.StrType)le.db_cons_length_of_res),TRIM((SALT311.StrType)le.db_cons_length_of_res_code),TRIM((SALT311.StrType)le.db_cons_length_of_res_desc),TRIM((SALT311.StrType)le.db_cons_dwelling_type),TRIM((SALT311.StrType)le.db_cons_recent_home_buyer),TRIM((SALT311.StrType)le.db_cons_income_code),TRIM((SALT311.StrType)le.db_cons_income_desc),TRIM((SALT311.StrType)le.db_cons_unsecuredcredcap),TRIM((SALT311.StrType)le.db_cons_unsecuredcredcapcode),TRIM((SALT311.StrType)le.db_cons_unsecuredcredcapdesc),TRIM((SALT311.StrType)le.db_cons_networthhomeval),TRIM((SALT311.StrType)le.db_cons_networthhomevalcode),TRIM((SALT311.StrType)le.db_cons_net_worth_desc),TRIM((SALT311.StrType)le.db_cons_discretincome),TRIM((SALT311.StrType)le.db_cons_discretincomecode),TRIM((SALT311.StrType)le.db_cons_discretincomedesc),TRIM((SALT311.StrType)le.db_cons_marital_status),TRIM((SALT311.StrType)le.db_cons_new_parent),TRIM((SALT311.StrType)le.db_cons_child_near_hs_grad),TRIM((SALT311.StrType)le.db_cons_college_graduate),TRIM((SALT311.StrType)le.db_cons_intend_purchase_veh),TRIM((SALT311.StrType)le.db_cons_recent_divorce),TRIM((SALT311.StrType)le.db_cons_newlywed),TRIM((SALT311.StrType)le.db_cons_new_teen_driver),TRIM((SALT311.StrType)le.db_cons_home_year_built),TRIM((SALT311.StrType)le.db_cons_home_sqft_ranges),TRIM((SALT311.StrType)le.db_cons_poli_party_ind),TRIM((SALT311.StrType)le.db_cons_home_sqft_actual),TRIM((SALT311.StrType)le.db_cons_occupation_ind),TRIM((SALT311.StrType)le.db_cons_credit_card_user),TRIM((SALT311.StrType)le.db_cons_home_property_type),TRIM((SALT311.StrType)le.db_cons_education_hh),TRIM((SALT311.StrType)le.db_cons_education_ind),TRIM((SALT311.StrType)le.db_cons_other_pet_owner),TRIM((SALT311.StrType)le.businesstypedesc),TRIM((SALT311.StrType)le.genderdesc),TRIM((SALT311.StrType)le.executivetypedesc),TRIM((SALT311.StrType)le.dbconsgenderdesc),TRIM((SALT311.StrType)le.dbconsethnicdesc),TRIM((SALT311.StrType)le.dbconsreligiousdesc),TRIM((SALT311.StrType)le.dbconslangprefdesc),TRIM((SALT311.StrType)le.dbconsownerrenter),TRIM((SALT311.StrType)le.dbconsdwellingtypedesc),TRIM((SALT311.StrType)le.dbconsmaritaldesc),TRIM((SALT311.StrType)le.dbconsnewparentdesc),TRIM((SALT311.StrType)le.dbconsteendriverdesc),TRIM((SALT311.StrType)le.dbconspolipartydesc),TRIM((SALT311.StrType)le.dbconsoccupationdesc),TRIM((SALT311.StrType)le.dbconspropertytypedesc),TRIM((SALT311.StrType)le.dbconsheadhouseeducdesc),TRIM((SALT311.StrType)le.dbconseducationdesc),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.raw_aid),TRIM((SALT311.StrType)le.ace_aid),TRIM((SALT311.StrType)le.prep_address_line1),TRIM((SALT311.StrType)le.prep_address_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),322*322,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_first_seen'}
      ,{2,'dt_last_seen'}
      ,{3,'dt_vendor_first_reported'}
      ,{4,'dt_vendor_last_reported'}
      ,{5,'process_date'}
      ,{6,'dotid'}
      ,{7,'dotscore'}
      ,{8,'dotweight'}
      ,{9,'empid'}
      ,{10,'empscore'}
      ,{11,'empweight'}
      ,{12,'powid'}
      ,{13,'powscore'}
      ,{14,'powweight'}
      ,{15,'proxid'}
      ,{16,'proxscore'}
      ,{17,'proxweight'}
      ,{18,'selescore'}
      ,{19,'seleweight'}
      ,{20,'orgid'}
      ,{21,'orgscore'}
      ,{22,'orgweight'}
      ,{23,'ultid'}
      ,{24,'ultscore'}
      ,{25,'ultweight'}
      ,{26,'record_type'}
      ,{27,'global_sid'}
      ,{28,'dbusa_business_id'}
      ,{29,'dbusa_executive_id'}
      ,{30,'subhq_parent_id'}
      ,{31,'hq_id'}
      ,{32,'ind_frm_indicator'}
      ,{33,'company_name'}
      ,{34,'full_name'}
      ,{35,'prefix'}
      ,{36,'first_name'}
      ,{37,'middle_initial'}
      ,{38,'last_name'}
      ,{39,'suffix'}
      ,{40,'gender'}
      ,{41,'standardized_title'}
      ,{42,'sourcetitle'}
      ,{43,'executive_title_rank'}
      ,{44,'primary_exec_flag'}
      ,{45,'exec_type'}
      ,{46,'executive_department'}
      ,{47,'executive_level'}
      ,{48,'phy_addr_standardized'}
      ,{49,'phy_addr_city'}
      ,{50,'phy_addr_state'}
      ,{51,'phy_addr_zip'}
      ,{52,'phy_addr_zip4'}
      ,{53,'phy_addr_carrierroute'}
      ,{54,'phy_addr_deliverypt'}
      ,{55,'phy_addr_deliveryptchkdig'}
      ,{56,'mail_addr_standardized'}
      ,{57,'mail_addr_city'}
      ,{58,'mail_addr_state'}
      ,{59,'mail_addr_zip'}
      ,{60,'mail_addr_zip4'}
      ,{61,'mail_addr_carrierroute'}
      ,{62,'mail_addr_deliverypt'}
      ,{63,'mail_addr_deliveryptchkdig'}
      ,{64,'mail_score'}
      ,{65,'mail_score_desc'}
      ,{66,'phone'}
      ,{67,'area_code'}
      ,{68,'fax'}
      ,{69,'email'}
      ,{70,'email_available_indicator'}
      ,{71,'url'}
      ,{72,'url_facebook'}
      ,{73,'url_googleplus'}
      ,{74,'url_instagram'}
      ,{75,'url_linkedin'}
      ,{76,'url_twitter'}
      ,{77,'url_youtube'}
      ,{78,'business_status_code'}
      ,{79,'business_status_desc'}
      ,{80,'franchise_flag'}
      ,{81,'franchise_type'}
      ,{82,'franchise_desc'}
      ,{83,'ticker_symbol'}
      ,{84,'stock_exchange'}
      ,{85,'fortune_1000_flag'}
      ,{86,'fortune_1000_rank'}
      ,{87,'fortune_1000_branches'}
      ,{88,'num_linked_locations'}
      ,{89,'county_code'}
      ,{90,'county_desc'}
      ,{91,'cbsa_code'}
      ,{92,'cbsa_desc'}
      ,{93,'geo_match_level'}
      ,{94,'latitude'}
      ,{95,'longitude'}
      ,{96,'scf'}
      ,{97,'timezone'}
      ,{98,'censustract'}
      ,{99,'censusblock'}
      ,{100,'city_population_code'}
      ,{101,'city_population_descr'}
      ,{102,'primary_sic'}
      ,{103,'primary_sic_desc'}
      ,{104,'sic02'}
      ,{105,'sic02_desc'}
      ,{106,'sic03'}
      ,{107,'sic03_desc'}
      ,{108,'sic04'}
      ,{109,'sic04_desc'}
      ,{110,'sic05'}
      ,{111,'sic05_desc'}
      ,{112,'sic06'}
      ,{113,'sic06_desc'}
      ,{114,'primarysic2'}
      ,{115,'primary_2_digit_sic_desc'}
      ,{116,'primarysic4'}
      ,{117,'primary_4_digit_sic_desc'}
      ,{118,'naics01'}
      ,{119,'naics01_desc'}
      ,{120,'naics02'}
      ,{121,'naics02_desc'}
      ,{122,'naics03'}
      ,{123,'naics03_desc'}
      ,{124,'naics04'}
      ,{125,'naics04_desc'}
      ,{126,'naics05'}
      ,{127,'naics05_desc'}
      ,{128,'naics06'}
      ,{129,'naics06_desc'}
      ,{130,'location_employees_total'}
      ,{131,'location_employee_code'}
      ,{132,'location_employee_desc'}
      ,{133,'location_sales_total'}
      ,{134,'location_sales_code'}
      ,{135,'location_sales_desc'}
      ,{136,'corporate_employee_total'}
      ,{137,'corporate_employee_code'}
      ,{138,'corporate_employee_desc'}
      ,{139,'year_established'}
      ,{140,'years_in_business_range'}
      ,{141,'female_owned'}
      ,{142,'minority_owned_flag'}
      ,{143,'minority_type'}
      ,{144,'home_based_indicator'}
      ,{145,'small_business_indicator'}
      ,{146,'import_export'}
      ,{147,'manufacturing_location'}
      ,{148,'public_indicator'}
      ,{149,'ein'}
      ,{150,'non_profit_org'}
      ,{151,'square_footage'}
      ,{152,'square_footage_code'}
      ,{153,'square_footage_desc'}
      ,{154,'creditscore'}
      ,{155,'creditcode'}
      ,{156,'credit_desc'}
      ,{157,'credit_capacity'}
      ,{158,'credit_capacity_code'}
      ,{159,'credit_capacity_desc'}
      ,{160,'advertising_expenses_code'}
      ,{161,'expense_advertising_desc'}
      ,{162,'technology_expenses_code'}
      ,{163,'expense_technology_desc'}
      ,{164,'office_equip_expenses_code'}
      ,{165,'expense_office_equip_desc'}
      ,{166,'rent_expenses_code'}
      ,{167,'expense_rent_desc'}
      ,{168,'telecom_expenses_code'}
      ,{169,'expense_telecom_desc'}
      ,{170,'accounting_expenses_code'}
      ,{171,'expense_accounting_desc'}
      ,{172,'bus_insurance_expense_code'}
      ,{173,'expense_bus_insurance_desc'}
      ,{174,'legal_expenses_code'}
      ,{175,'expense_legal_desc'}
      ,{176,'utilities_expenses_code'}
      ,{177,'expense_utilities_desc'}
      ,{178,'number_of_pcs_code'}
      ,{179,'number_of_pcs_desc'}
      ,{180,'nb_flag'}
      ,{181,'hq_company_name'}
      ,{182,'hq_city'}
      ,{183,'hq_state'}
      ,{184,'subhq_parent_name'}
      ,{185,'subhq_parent_city'}
      ,{186,'subhq_parent_state'}
      ,{187,'domestic_foreign_owner_flag'}
      ,{188,'foreign_parent_company_name'}
      ,{189,'foreign_parent_city'}
      ,{190,'foreign_parent_country'}
      ,{191,'db_cons_matchkey'}
      ,{192,'databaseusa_individual_id'}
      ,{193,'db_cons_full_name'}
      ,{194,'db_cons_full_name_prefix'}
      ,{195,'db_cons_first_name'}
      ,{196,'db_cons_middle_initial'}
      ,{197,'db_cons_last_name'}
      ,{198,'db_cons_email'}
      ,{199,'db_cons_gender'}
      ,{200,'db_cons_date_of_birth_year'}
      ,{201,'db_cons_date_of_birth_month'}
      ,{202,'db_cons_age'}
      ,{203,'db_cons_age_code_desc'}
      ,{204,'db_cons_age_in_two_year_hh'}
      ,{205,'db_cons_ethnic_code'}
      ,{206,'db_cons_religious_affil'}
      ,{207,'db_cons_language_pref'}
      ,{208,'db_cons_phy_addr_std'}
      ,{209,'db_cons_phy_addr_city'}
      ,{210,'db_cons_phy_addr_state'}
      ,{211,'db_cons_phy_addr_zip'}
      ,{212,'db_cons_phy_addr_zip4'}
      ,{213,'db_cons_phy_addr_carrierroute'}
      ,{214,'db_cons_phy_addr_deliverypt'}
      ,{215,'db_cons_line_of_travel'}
      ,{216,'db_cons_geocode_results'}
      ,{217,'db_cons_latitude'}
      ,{218,'db_cons_longitude'}
      ,{219,'db_cons_time_zone_code'}
      ,{220,'db_cons_time_zone_desc'}
      ,{221,'db_cons_census_tract'}
      ,{222,'db_cons_census_block'}
      ,{223,'db_cons_countyfips'}
      ,{224,'db_countyname'}
      ,{225,'db_cons_cbsa_code'}
      ,{226,'db_cons_cbsa_desc'}
      ,{227,'db_cons_walk_sequence'}
      ,{228,'db_cons_phone'}
      ,{229,'db_cons_dnc'}
      ,{230,'db_cons_scrubbed_phoneable'}
      ,{231,'db_cons_children_present'}
      ,{232,'db_cons_home_value_code'}
      ,{233,'db_cons_home_value_desc'}
      ,{234,'db_cons_donor_capacity'}
      ,{235,'db_cons_donor_capacity_code'}
      ,{236,'db_cons_donor_capacity_desc'}
      ,{237,'db_cons_home_owner_renter'}
      ,{238,'db_cons_length_of_res'}
      ,{239,'db_cons_length_of_res_code'}
      ,{240,'db_cons_length_of_res_desc'}
      ,{241,'db_cons_dwelling_type'}
      ,{242,'db_cons_recent_home_buyer'}
      ,{243,'db_cons_income_code'}
      ,{244,'db_cons_income_desc'}
      ,{245,'db_cons_unsecuredcredcap'}
      ,{246,'db_cons_unsecuredcredcapcode'}
      ,{247,'db_cons_unsecuredcredcapdesc'}
      ,{248,'db_cons_networthhomeval'}
      ,{249,'db_cons_networthhomevalcode'}
      ,{250,'db_cons_net_worth_desc'}
      ,{251,'db_cons_discretincome'}
      ,{252,'db_cons_discretincomecode'}
      ,{253,'db_cons_discretincomedesc'}
      ,{254,'db_cons_marital_status'}
      ,{255,'db_cons_new_parent'}
      ,{256,'db_cons_child_near_hs_grad'}
      ,{257,'db_cons_college_graduate'}
      ,{258,'db_cons_intend_purchase_veh'}
      ,{259,'db_cons_recent_divorce'}
      ,{260,'db_cons_newlywed'}
      ,{261,'db_cons_new_teen_driver'}
      ,{262,'db_cons_home_year_built'}
      ,{263,'db_cons_home_sqft_ranges'}
      ,{264,'db_cons_poli_party_ind'}
      ,{265,'db_cons_home_sqft_actual'}
      ,{266,'db_cons_occupation_ind'}
      ,{267,'db_cons_credit_card_user'}
      ,{268,'db_cons_home_property_type'}
      ,{269,'db_cons_education_hh'}
      ,{270,'db_cons_education_ind'}
      ,{271,'db_cons_other_pet_owner'}
      ,{272,'businesstypedesc'}
      ,{273,'genderdesc'}
      ,{274,'executivetypedesc'}
      ,{275,'dbconsgenderdesc'}
      ,{276,'dbconsethnicdesc'}
      ,{277,'dbconsreligiousdesc'}
      ,{278,'dbconslangprefdesc'}
      ,{279,'dbconsownerrenter'}
      ,{280,'dbconsdwellingtypedesc'}
      ,{281,'dbconsmaritaldesc'}
      ,{282,'dbconsnewparentdesc'}
      ,{283,'dbconsteendriverdesc'}
      ,{284,'dbconspolipartydesc'}
      ,{285,'dbconsoccupationdesc'}
      ,{286,'dbconspropertytypedesc'}
      ,{287,'dbconsheadhouseeducdesc'}
      ,{288,'dbconseducationdesc'}
      ,{289,'title'}
      ,{290,'fname'}
      ,{291,'mname'}
      ,{292,'lname'}
      ,{293,'name_score'}
      ,{294,'prim_range'}
      ,{295,'predir'}
      ,{296,'prim_name'}
      ,{297,'addr_suffix'}
      ,{298,'postdir'}
      ,{299,'unit_desig'}
      ,{300,'sec_range'}
      ,{301,'p_city_name'}
      ,{302,'v_city_name'}
      ,{303,'st'}
      ,{304,'cart'}
      ,{305,'cr_sort_sz'}
      ,{306,'lot'}
      ,{307,'lot_order'}
      ,{308,'dbpc'}
      ,{309,'chk_digit'}
      ,{310,'rec_type'}
      ,{311,'fips_state'}
      ,{312,'fips_county'}
      ,{313,'geo_lat'}
      ,{314,'geo_long'}
      ,{315,'msa'}
      ,{316,'geo_blk'}
      ,{317,'geo_match'}
      ,{318,'err_stat'}
      ,{319,'raw_aid'}
      ,{320,'ace_aid'}
      ,{321,'prep_address_line1'}
      ,{322,'prep_address_line_last'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED2 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source) source; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED2 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Fields.InValid_dotid((SALT311.StrType)le.dotid),
    Fields.InValid_dotscore((SALT311.StrType)le.dotscore),
    Fields.InValid_dotweight((SALT311.StrType)le.dotweight),
    Fields.InValid_empid((SALT311.StrType)le.empid),
    Fields.InValid_empscore((SALT311.StrType)le.empscore),
    Fields.InValid_empweight((SALT311.StrType)le.empweight),
    Fields.InValid_powid((SALT311.StrType)le.powid),
    Fields.InValid_powscore((SALT311.StrType)le.powscore),
    Fields.InValid_powweight((SALT311.StrType)le.powweight),
    Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Fields.InValid_proxscore((SALT311.StrType)le.proxscore),
    Fields.InValid_proxweight((SALT311.StrType)le.proxweight),
    Fields.InValid_selescore((SALT311.StrType)le.selescore),
    Fields.InValid_seleweight((SALT311.StrType)le.seleweight),
    Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Fields.InValid_orgscore((SALT311.StrType)le.orgscore),
    Fields.InValid_orgweight((SALT311.StrType)le.orgweight),
    Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Fields.InValid_ultscore((SALT311.StrType)le.ultscore),
    Fields.InValid_ultweight((SALT311.StrType)le.ultweight),
    Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Fields.InValid_global_sid((SALT311.StrType)le.global_sid),
    Fields.InValid_dbusa_business_id((SALT311.StrType)le.dbusa_business_id),
    Fields.InValid_dbusa_executive_id((SALT311.StrType)le.dbusa_executive_id),
    Fields.InValid_subhq_parent_id((SALT311.StrType)le.subhq_parent_id),
    Fields.InValid_hq_id((SALT311.StrType)le.hq_id),
    Fields.InValid_ind_frm_indicator((SALT311.StrType)le.ind_frm_indicator),
    Fields.InValid_company_name((SALT311.StrType)le.company_name),
    Fields.InValid_full_name((SALT311.StrType)le.full_name),
    Fields.InValid_prefix((SALT311.StrType)le.prefix),
    Fields.InValid_first_name((SALT311.StrType)le.first_name),
    Fields.InValid_middle_initial((SALT311.StrType)le.middle_initial),
    Fields.InValid_last_name((SALT311.StrType)le.last_name),
    Fields.InValid_suffix((SALT311.StrType)le.suffix),
    Fields.InValid_gender((SALT311.StrType)le.gender),
    Fields.InValid_standardized_title((SALT311.StrType)le.standardized_title),
    Fields.InValid_sourcetitle((SALT311.StrType)le.sourcetitle),
    Fields.InValid_executive_title_rank((SALT311.StrType)le.executive_title_rank),
    Fields.InValid_primary_exec_flag((SALT311.StrType)le.primary_exec_flag),
    Fields.InValid_exec_type((SALT311.StrType)le.exec_type),
    Fields.InValid_executive_department((SALT311.StrType)le.executive_department),
    Fields.InValid_executive_level((SALT311.StrType)le.executive_level),
    Fields.InValid_phy_addr_standardized((SALT311.StrType)le.phy_addr_standardized),
    Fields.InValid_phy_addr_city((SALT311.StrType)le.phy_addr_city),
    Fields.InValid_phy_addr_state((SALT311.StrType)le.phy_addr_state),
    Fields.InValid_phy_addr_zip((SALT311.StrType)le.phy_addr_zip),
    Fields.InValid_phy_addr_zip4((SALT311.StrType)le.phy_addr_zip4),
    Fields.InValid_phy_addr_carrierroute((SALT311.StrType)le.phy_addr_carrierroute),
    Fields.InValid_phy_addr_deliverypt((SALT311.StrType)le.phy_addr_deliverypt),
    Fields.InValid_phy_addr_deliveryptchkdig((SALT311.StrType)le.phy_addr_deliveryptchkdig),
    Fields.InValid_mail_addr_standardized((SALT311.StrType)le.mail_addr_standardized),
    Fields.InValid_mail_addr_city((SALT311.StrType)le.mail_addr_city),
    Fields.InValid_mail_addr_state((SALT311.StrType)le.mail_addr_state),
    Fields.InValid_mail_addr_zip((SALT311.StrType)le.mail_addr_zip),
    Fields.InValid_mail_addr_zip4((SALT311.StrType)le.mail_addr_zip4),
    Fields.InValid_mail_addr_carrierroute((SALT311.StrType)le.mail_addr_carrierroute),
    Fields.InValid_mail_addr_deliverypt((SALT311.StrType)le.mail_addr_deliverypt),
    Fields.InValid_mail_addr_deliveryptchkdig((SALT311.StrType)le.mail_addr_deliveryptchkdig),
    Fields.InValid_mail_score((SALT311.StrType)le.mail_score),
    Fields.InValid_mail_score_desc((SALT311.StrType)le.mail_score_desc),
    Fields.InValid_phone((SALT311.StrType)le.phone),
    Fields.InValid_area_code((SALT311.StrType)le.area_code),
    Fields.InValid_fax((SALT311.StrType)le.fax),
    Fields.InValid_email((SALT311.StrType)le.email),
    Fields.InValid_email_available_indicator((SALT311.StrType)le.email_available_indicator),
    Fields.InValid_url((SALT311.StrType)le.url),
    Fields.InValid_url_facebook((SALT311.StrType)le.url_facebook),
    Fields.InValid_url_googleplus((SALT311.StrType)le.url_googleplus),
    Fields.InValid_url_instagram((SALT311.StrType)le.url_instagram),
    Fields.InValid_url_linkedin((SALT311.StrType)le.url_linkedin),
    Fields.InValid_url_twitter((SALT311.StrType)le.url_twitter),
    Fields.InValid_url_youtube((SALT311.StrType)le.url_youtube),
    Fields.InValid_business_status_code((SALT311.StrType)le.business_status_code),
    Fields.InValid_business_status_desc((SALT311.StrType)le.business_status_desc),
    Fields.InValid_franchise_flag((SALT311.StrType)le.franchise_flag),
    Fields.InValid_franchise_type((SALT311.StrType)le.franchise_type),
    Fields.InValid_franchise_desc((SALT311.StrType)le.franchise_desc),
    Fields.InValid_ticker_symbol((SALT311.StrType)le.ticker_symbol),
    Fields.InValid_stock_exchange((SALT311.StrType)le.stock_exchange),
    Fields.InValid_fortune_1000_flag((SALT311.StrType)le.fortune_1000_flag),
    Fields.InValid_fortune_1000_rank((SALT311.StrType)le.fortune_1000_rank),
    Fields.InValid_fortune_1000_branches((SALT311.StrType)le.fortune_1000_branches),
    Fields.InValid_num_linked_locations((SALT311.StrType)le.num_linked_locations),
    Fields.InValid_county_code((SALT311.StrType)le.county_code),
    Fields.InValid_county_desc((SALT311.StrType)le.county_desc),
    Fields.InValid_cbsa_code((SALT311.StrType)le.cbsa_code),
    Fields.InValid_cbsa_desc((SALT311.StrType)le.cbsa_desc),
    Fields.InValid_geo_match_level((SALT311.StrType)le.geo_match_level),
    Fields.InValid_latitude((SALT311.StrType)le.latitude),
    Fields.InValid_longitude((SALT311.StrType)le.longitude),
    Fields.InValid_scf((SALT311.StrType)le.scf),
    Fields.InValid_timezone((SALT311.StrType)le.timezone),
    Fields.InValid_censustract((SALT311.StrType)le.censustract),
    Fields.InValid_censusblock((SALT311.StrType)le.censusblock),
    Fields.InValid_city_population_code((SALT311.StrType)le.city_population_code),
    Fields.InValid_city_population_descr((SALT311.StrType)le.city_population_descr),
    Fields.InValid_primary_sic((SALT311.StrType)le.primary_sic),
    Fields.InValid_primary_sic_desc((SALT311.StrType)le.primary_sic_desc),
    Fields.InValid_sic02((SALT311.StrType)le.sic02),
    Fields.InValid_sic02_desc((SALT311.StrType)le.sic02_desc),
    Fields.InValid_sic03((SALT311.StrType)le.sic03),
    Fields.InValid_sic03_desc((SALT311.StrType)le.sic03_desc),
    Fields.InValid_sic04((SALT311.StrType)le.sic04),
    Fields.InValid_sic04_desc((SALT311.StrType)le.sic04_desc),
    Fields.InValid_sic05((SALT311.StrType)le.sic05),
    Fields.InValid_sic05_desc((SALT311.StrType)le.sic05_desc),
    Fields.InValid_sic06((SALT311.StrType)le.sic06),
    Fields.InValid_sic06_desc((SALT311.StrType)le.sic06_desc),
    Fields.InValid_primarysic2((SALT311.StrType)le.primarysic2),
    Fields.InValid_primary_2_digit_sic_desc((SALT311.StrType)le.primary_2_digit_sic_desc),
    Fields.InValid_primarysic4((SALT311.StrType)le.primarysic4),
    Fields.InValid_primary_4_digit_sic_desc((SALT311.StrType)le.primary_4_digit_sic_desc),
    Fields.InValid_naics01((SALT311.StrType)le.naics01),
    Fields.InValid_naics01_desc((SALT311.StrType)le.naics01_desc),
    Fields.InValid_naics02((SALT311.StrType)le.naics02),
    Fields.InValid_naics02_desc((SALT311.StrType)le.naics02_desc),
    Fields.InValid_naics03((SALT311.StrType)le.naics03),
    Fields.InValid_naics03_desc((SALT311.StrType)le.naics03_desc),
    Fields.InValid_naics04((SALT311.StrType)le.naics04),
    Fields.InValid_naics04_desc((SALT311.StrType)le.naics04_desc),
    Fields.InValid_naics05((SALT311.StrType)le.naics05),
    Fields.InValid_naics05_desc((SALT311.StrType)le.naics05_desc),
    Fields.InValid_naics06((SALT311.StrType)le.naics06),
    Fields.InValid_naics06_desc((SALT311.StrType)le.naics06_desc),
    Fields.InValid_location_employees_total((SALT311.StrType)le.location_employees_total),
    Fields.InValid_location_employee_code((SALT311.StrType)le.location_employee_code),
    Fields.InValid_location_employee_desc((SALT311.StrType)le.location_employee_desc),
    Fields.InValid_location_sales_total((SALT311.StrType)le.location_sales_total),
    Fields.InValid_location_sales_code((SALT311.StrType)le.location_sales_code),
    Fields.InValid_location_sales_desc((SALT311.StrType)le.location_sales_desc),
    Fields.InValid_corporate_employee_total((SALT311.StrType)le.corporate_employee_total),
    Fields.InValid_corporate_employee_code((SALT311.StrType)le.corporate_employee_code),
    Fields.InValid_corporate_employee_desc((SALT311.StrType)le.corporate_employee_desc),
    Fields.InValid_year_established((SALT311.StrType)le.year_established),
    Fields.InValid_years_in_business_range((SALT311.StrType)le.years_in_business_range),
    Fields.InValid_female_owned((SALT311.StrType)le.female_owned),
    Fields.InValid_minority_owned_flag((SALT311.StrType)le.minority_owned_flag),
    Fields.InValid_minority_type((SALT311.StrType)le.minority_type),
    Fields.InValid_home_based_indicator((SALT311.StrType)le.home_based_indicator),
    Fields.InValid_small_business_indicator((SALT311.StrType)le.small_business_indicator),
    Fields.InValid_import_export((SALT311.StrType)le.import_export),
    Fields.InValid_manufacturing_location((SALT311.StrType)le.manufacturing_location),
    Fields.InValid_public_indicator((SALT311.StrType)le.public_indicator),
    Fields.InValid_ein((SALT311.StrType)le.ein),
    Fields.InValid_non_profit_org((SALT311.StrType)le.non_profit_org),
    Fields.InValid_square_footage((SALT311.StrType)le.square_footage),
    Fields.InValid_square_footage_code((SALT311.StrType)le.square_footage_code),
    Fields.InValid_square_footage_desc((SALT311.StrType)le.square_footage_desc),
    Fields.InValid_creditscore((SALT311.StrType)le.creditscore),
    Fields.InValid_creditcode((SALT311.StrType)le.creditcode),
    Fields.InValid_credit_desc((SALT311.StrType)le.credit_desc),
    Fields.InValid_credit_capacity((SALT311.StrType)le.credit_capacity),
    Fields.InValid_credit_capacity_code((SALT311.StrType)le.credit_capacity_code),
    Fields.InValid_credit_capacity_desc((SALT311.StrType)le.credit_capacity_desc),
    Fields.InValid_advertising_expenses_code((SALT311.StrType)le.advertising_expenses_code),
    Fields.InValid_expense_advertising_desc((SALT311.StrType)le.expense_advertising_desc),
    Fields.InValid_technology_expenses_code((SALT311.StrType)le.technology_expenses_code),
    Fields.InValid_expense_technology_desc((SALT311.StrType)le.expense_technology_desc),
    Fields.InValid_office_equip_expenses_code((SALT311.StrType)le.office_equip_expenses_code),
    Fields.InValid_expense_office_equip_desc((SALT311.StrType)le.expense_office_equip_desc),
    Fields.InValid_rent_expenses_code((SALT311.StrType)le.rent_expenses_code),
    Fields.InValid_expense_rent_desc((SALT311.StrType)le.expense_rent_desc),
    Fields.InValid_telecom_expenses_code((SALT311.StrType)le.telecom_expenses_code),
    Fields.InValid_expense_telecom_desc((SALT311.StrType)le.expense_telecom_desc),
    Fields.InValid_accounting_expenses_code((SALT311.StrType)le.accounting_expenses_code),
    Fields.InValid_expense_accounting_desc((SALT311.StrType)le.expense_accounting_desc),
    Fields.InValid_bus_insurance_expense_code((SALT311.StrType)le.bus_insurance_expense_code),
    Fields.InValid_expense_bus_insurance_desc((SALT311.StrType)le.expense_bus_insurance_desc),
    Fields.InValid_legal_expenses_code((SALT311.StrType)le.legal_expenses_code),
    Fields.InValid_expense_legal_desc((SALT311.StrType)le.expense_legal_desc),
    Fields.InValid_utilities_expenses_code((SALT311.StrType)le.utilities_expenses_code),
    Fields.InValid_expense_utilities_desc((SALT311.StrType)le.expense_utilities_desc),
    Fields.InValid_number_of_pcs_code((SALT311.StrType)le.number_of_pcs_code),
    Fields.InValid_number_of_pcs_desc((SALT311.StrType)le.number_of_pcs_desc),
    Fields.InValid_nb_flag((SALT311.StrType)le.nb_flag),
    Fields.InValid_hq_company_name((SALT311.StrType)le.hq_company_name),
    Fields.InValid_hq_city((SALT311.StrType)le.hq_city),
    Fields.InValid_hq_state((SALT311.StrType)le.hq_state),
    Fields.InValid_subhq_parent_name((SALT311.StrType)le.subhq_parent_name),
    Fields.InValid_subhq_parent_city((SALT311.StrType)le.subhq_parent_city),
    Fields.InValid_subhq_parent_state((SALT311.StrType)le.subhq_parent_state),
    Fields.InValid_domestic_foreign_owner_flag((SALT311.StrType)le.domestic_foreign_owner_flag),
    Fields.InValid_foreign_parent_company_name((SALT311.StrType)le.foreign_parent_company_name),
    Fields.InValid_foreign_parent_city((SALT311.StrType)le.foreign_parent_city),
    Fields.InValid_foreign_parent_country((SALT311.StrType)le.foreign_parent_country),
    Fields.InValid_db_cons_matchkey((SALT311.StrType)le.db_cons_matchkey),
    Fields.InValid_databaseusa_individual_id((SALT311.StrType)le.databaseusa_individual_id),
    Fields.InValid_db_cons_full_name((SALT311.StrType)le.db_cons_full_name),
    Fields.InValid_db_cons_full_name_prefix((SALT311.StrType)le.db_cons_full_name_prefix),
    Fields.InValid_db_cons_first_name((SALT311.StrType)le.db_cons_first_name),
    Fields.InValid_db_cons_middle_initial((SALT311.StrType)le.db_cons_middle_initial),
    Fields.InValid_db_cons_last_name((SALT311.StrType)le.db_cons_last_name),
    Fields.InValid_db_cons_email((SALT311.StrType)le.db_cons_email),
    Fields.InValid_db_cons_gender((SALT311.StrType)le.db_cons_gender),
    Fields.InValid_db_cons_date_of_birth_year((SALT311.StrType)le.db_cons_date_of_birth_year),
    Fields.InValid_db_cons_date_of_birth_month((SALT311.StrType)le.db_cons_date_of_birth_month),
    Fields.InValid_db_cons_age((SALT311.StrType)le.db_cons_age),
    Fields.InValid_db_cons_age_code_desc((SALT311.StrType)le.db_cons_age_code_desc),
    Fields.InValid_db_cons_age_in_two_year_hh((SALT311.StrType)le.db_cons_age_in_two_year_hh),
    Fields.InValid_db_cons_ethnic_code((SALT311.StrType)le.db_cons_ethnic_code),
    Fields.InValid_db_cons_religious_affil((SALT311.StrType)le.db_cons_religious_affil),
    Fields.InValid_db_cons_language_pref((SALT311.StrType)le.db_cons_language_pref),
    Fields.InValid_db_cons_phy_addr_std((SALT311.StrType)le.db_cons_phy_addr_std),
    Fields.InValid_db_cons_phy_addr_city((SALT311.StrType)le.db_cons_phy_addr_city),
    Fields.InValid_db_cons_phy_addr_state((SALT311.StrType)le.db_cons_phy_addr_state),
    Fields.InValid_db_cons_phy_addr_zip((SALT311.StrType)le.db_cons_phy_addr_zip),
    Fields.InValid_db_cons_phy_addr_zip4((SALT311.StrType)le.db_cons_phy_addr_zip4),
    Fields.InValid_db_cons_phy_addr_carrierroute((SALT311.StrType)le.db_cons_phy_addr_carrierroute),
    Fields.InValid_db_cons_phy_addr_deliverypt((SALT311.StrType)le.db_cons_phy_addr_deliverypt),
    Fields.InValid_db_cons_line_of_travel((SALT311.StrType)le.db_cons_line_of_travel),
    Fields.InValid_db_cons_geocode_results((SALT311.StrType)le.db_cons_geocode_results),
    Fields.InValid_db_cons_latitude((SALT311.StrType)le.db_cons_latitude),
    Fields.InValid_db_cons_longitude((SALT311.StrType)le.db_cons_longitude),
    Fields.InValid_db_cons_time_zone_code((SALT311.StrType)le.db_cons_time_zone_code),
    Fields.InValid_db_cons_time_zone_desc((SALT311.StrType)le.db_cons_time_zone_desc),
    Fields.InValid_db_cons_census_tract((SALT311.StrType)le.db_cons_census_tract),
    Fields.InValid_db_cons_census_block((SALT311.StrType)le.db_cons_census_block),
    Fields.InValid_db_cons_countyfips((SALT311.StrType)le.db_cons_countyfips),
    Fields.InValid_db_countyname((SALT311.StrType)le.db_countyname),
    Fields.InValid_db_cons_cbsa_code((SALT311.StrType)le.db_cons_cbsa_code),
    Fields.InValid_db_cons_cbsa_desc((SALT311.StrType)le.db_cons_cbsa_desc),
    Fields.InValid_db_cons_walk_sequence((SALT311.StrType)le.db_cons_walk_sequence),
    Fields.InValid_db_cons_phone((SALT311.StrType)le.db_cons_phone),
    Fields.InValid_db_cons_dnc((SALT311.StrType)le.db_cons_dnc),
    Fields.InValid_db_cons_scrubbed_phoneable((SALT311.StrType)le.db_cons_scrubbed_phoneable),
    Fields.InValid_db_cons_children_present((SALT311.StrType)le.db_cons_children_present),
    Fields.InValid_db_cons_home_value_code((SALT311.StrType)le.db_cons_home_value_code),
    Fields.InValid_db_cons_home_value_desc((SALT311.StrType)le.db_cons_home_value_desc),
    Fields.InValid_db_cons_donor_capacity((SALT311.StrType)le.db_cons_donor_capacity),
    Fields.InValid_db_cons_donor_capacity_code((SALT311.StrType)le.db_cons_donor_capacity_code),
    Fields.InValid_db_cons_donor_capacity_desc((SALT311.StrType)le.db_cons_donor_capacity_desc),
    Fields.InValid_db_cons_home_owner_renter((SALT311.StrType)le.db_cons_home_owner_renter),
    Fields.InValid_db_cons_length_of_res((SALT311.StrType)le.db_cons_length_of_res),
    Fields.InValid_db_cons_length_of_res_code((SALT311.StrType)le.db_cons_length_of_res_code),
    Fields.InValid_db_cons_length_of_res_desc((SALT311.StrType)le.db_cons_length_of_res_desc),
    Fields.InValid_db_cons_dwelling_type((SALT311.StrType)le.db_cons_dwelling_type),
    Fields.InValid_db_cons_recent_home_buyer((SALT311.StrType)le.db_cons_recent_home_buyer),
    Fields.InValid_db_cons_income_code((SALT311.StrType)le.db_cons_income_code),
    Fields.InValid_db_cons_income_desc((SALT311.StrType)le.db_cons_income_desc),
    Fields.InValid_db_cons_unsecuredcredcap((SALT311.StrType)le.db_cons_unsecuredcredcap),
    Fields.InValid_db_cons_unsecuredcredcapcode((SALT311.StrType)le.db_cons_unsecuredcredcapcode),
    Fields.InValid_db_cons_unsecuredcredcapdesc((SALT311.StrType)le.db_cons_unsecuredcredcapdesc),
    Fields.InValid_db_cons_networthhomeval((SALT311.StrType)le.db_cons_networthhomeval),
    Fields.InValid_db_cons_networthhomevalcode((SALT311.StrType)le.db_cons_networthhomevalcode),
    Fields.InValid_db_cons_net_worth_desc((SALT311.StrType)le.db_cons_net_worth_desc),
    Fields.InValid_db_cons_discretincome((SALT311.StrType)le.db_cons_discretincome),
    Fields.InValid_db_cons_discretincomecode((SALT311.StrType)le.db_cons_discretincomecode),
    Fields.InValid_db_cons_discretincomedesc((SALT311.StrType)le.db_cons_discretincomedesc),
    Fields.InValid_db_cons_marital_status((SALT311.StrType)le.db_cons_marital_status),
    Fields.InValid_db_cons_new_parent((SALT311.StrType)le.db_cons_new_parent),
    Fields.InValid_db_cons_child_near_hs_grad((SALT311.StrType)le.db_cons_child_near_hs_grad),
    Fields.InValid_db_cons_college_graduate((SALT311.StrType)le.db_cons_college_graduate),
    Fields.InValid_db_cons_intend_purchase_veh((SALT311.StrType)le.db_cons_intend_purchase_veh),
    Fields.InValid_db_cons_recent_divorce((SALT311.StrType)le.db_cons_recent_divorce),
    Fields.InValid_db_cons_newlywed((SALT311.StrType)le.db_cons_newlywed),
    Fields.InValid_db_cons_new_teen_driver((SALT311.StrType)le.db_cons_new_teen_driver),
    Fields.InValid_db_cons_home_year_built((SALT311.StrType)le.db_cons_home_year_built),
    Fields.InValid_db_cons_home_sqft_ranges((SALT311.StrType)le.db_cons_home_sqft_ranges),
    Fields.InValid_db_cons_poli_party_ind((SALT311.StrType)le.db_cons_poli_party_ind),
    Fields.InValid_db_cons_home_sqft_actual((SALT311.StrType)le.db_cons_home_sqft_actual),
    Fields.InValid_db_cons_occupation_ind((SALT311.StrType)le.db_cons_occupation_ind),
    Fields.InValid_db_cons_credit_card_user((SALT311.StrType)le.db_cons_credit_card_user),
    Fields.InValid_db_cons_home_property_type((SALT311.StrType)le.db_cons_home_property_type),
    Fields.InValid_db_cons_education_hh((SALT311.StrType)le.db_cons_education_hh),
    Fields.InValid_db_cons_education_ind((SALT311.StrType)le.db_cons_education_ind),
    Fields.InValid_db_cons_other_pet_owner((SALT311.StrType)le.db_cons_other_pet_owner),
    Fields.InValid_businesstypedesc((SALT311.StrType)le.businesstypedesc),
    Fields.InValid_genderdesc((SALT311.StrType)le.genderdesc),
    Fields.InValid_executivetypedesc((SALT311.StrType)le.executivetypedesc),
    Fields.InValid_dbconsgenderdesc((SALT311.StrType)le.dbconsgenderdesc),
    Fields.InValid_dbconsethnicdesc((SALT311.StrType)le.dbconsethnicdesc),
    Fields.InValid_dbconsreligiousdesc((SALT311.StrType)le.dbconsreligiousdesc),
    Fields.InValid_dbconslangprefdesc((SALT311.StrType)le.dbconslangprefdesc),
    Fields.InValid_dbconsownerrenter((SALT311.StrType)le.dbconsownerrenter),
    Fields.InValid_dbconsdwellingtypedesc((SALT311.StrType)le.dbconsdwellingtypedesc),
    Fields.InValid_dbconsmaritaldesc((SALT311.StrType)le.dbconsmaritaldesc),
    Fields.InValid_dbconsnewparentdesc((SALT311.StrType)le.dbconsnewparentdesc),
    Fields.InValid_dbconsteendriverdesc((SALT311.StrType)le.dbconsteendriverdesc),
    Fields.InValid_dbconspolipartydesc((SALT311.StrType)le.dbconspolipartydesc),
    Fields.InValid_dbconsoccupationdesc((SALT311.StrType)le.dbconsoccupationdesc),
    Fields.InValid_dbconspropertytypedesc((SALT311.StrType)le.dbconspropertytypedesc),
    Fields.InValid_dbconsheadhouseeducdesc((SALT311.StrType)le.dbconsheadhouseeducdesc),
    Fields.InValid_dbconseducationdesc((SALT311.StrType)le.dbconseducationdesc),
    Fields.InValid_title((SALT311.StrType)le.title),
    Fields.InValid_fname((SALT311.StrType)le.fname),
    Fields.InValid_mname((SALT311.StrType)le.mname),
    Fields.InValid_lname((SALT311.StrType)le.lname),
    Fields.InValid_name_score((SALT311.StrType)le.name_score),
    Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Fields.InValid_predir((SALT311.StrType)le.predir),
    Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    Fields.InValid_st((SALT311.StrType)le.st),
    Fields.InValid_cart((SALT311.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT311.StrType)le.lot),
    Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT311.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT311.StrType)le.rec_type),
    Fields.InValid_fips_state((SALT311.StrType)le.fips_state),
    Fields.InValid_fips_county((SALT311.StrType)le.fips_county),
    Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Fields.InValid_msa((SALT311.StrType)le.msa),
    Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    Fields.InValid_raw_aid((SALT311.StrType)le.raw_aid),
    Fields.InValid_ace_aid((SALT311.StrType)le.ace_aid),
    Fields.InValid_prep_address_line1((SALT311.StrType)le.prep_address_line1),
    Fields.InValid_prep_address_line_last((SALT311.StrType)le.prep_address_line_last),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source := le.source;
END;
Errors := NORMALIZE(h,322,NoteErrors(LEFT,COUNTER));
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
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Fields.InValidMessage_empid(TotalErrors.ErrorNum),Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Fields.InValidMessage_powid(TotalErrors.ErrorNum),Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_global_sid(TotalErrors.ErrorNum),Fields.InValidMessage_dbusa_business_id(TotalErrors.ErrorNum),Fields.InValidMessage_dbusa_executive_id(TotalErrors.ErrorNum),Fields.InValidMessage_subhq_parent_id(TotalErrors.ErrorNum),Fields.InValidMessage_hq_id(TotalErrors.ErrorNum),Fields.InValidMessage_ind_frm_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_middle_initial(TotalErrors.ErrorNum),Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_standardized_title(TotalErrors.ErrorNum),Fields.InValidMessage_sourcetitle(TotalErrors.ErrorNum),Fields.InValidMessage_executive_title_rank(TotalErrors.ErrorNum),Fields.InValidMessage_primary_exec_flag(TotalErrors.ErrorNum),Fields.InValidMessage_exec_type(TotalErrors.ErrorNum),Fields.InValidMessage_executive_department(TotalErrors.ErrorNum),Fields.InValidMessage_executive_level(TotalErrors.ErrorNum),Fields.InValidMessage_phy_addr_standardized(TotalErrors.ErrorNum),Fields.InValidMessage_phy_addr_city(TotalErrors.ErrorNum),Fields.InValidMessage_phy_addr_state(TotalErrors.ErrorNum),Fields.InValidMessage_phy_addr_zip(TotalErrors.ErrorNum),Fields.InValidMessage_phy_addr_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_phy_addr_carrierroute(TotalErrors.ErrorNum),Fields.InValidMessage_phy_addr_deliverypt(TotalErrors.ErrorNum),Fields.InValidMessage_phy_addr_deliveryptchkdig(TotalErrors.ErrorNum),Fields.InValidMessage_mail_addr_standardized(TotalErrors.ErrorNum),Fields.InValidMessage_mail_addr_city(TotalErrors.ErrorNum),Fields.InValidMessage_mail_addr_state(TotalErrors.ErrorNum),Fields.InValidMessage_mail_addr_zip(TotalErrors.ErrorNum),Fields.InValidMessage_mail_addr_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_mail_addr_carrierroute(TotalErrors.ErrorNum),Fields.InValidMessage_mail_addr_deliverypt(TotalErrors.ErrorNum),Fields.InValidMessage_mail_addr_deliveryptchkdig(TotalErrors.ErrorNum),Fields.InValidMessage_mail_score(TotalErrors.ErrorNum),Fields.InValidMessage_mail_score_desc(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_area_code(TotalErrors.ErrorNum),Fields.InValidMessage_fax(TotalErrors.ErrorNum),Fields.InValidMessage_email(TotalErrors.ErrorNum),Fields.InValidMessage_email_available_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_url(TotalErrors.ErrorNum),Fields.InValidMessage_url_facebook(TotalErrors.ErrorNum),Fields.InValidMessage_url_googleplus(TotalErrors.ErrorNum),Fields.InValidMessage_url_instagram(TotalErrors.ErrorNum),Fields.InValidMessage_url_linkedin(TotalErrors.ErrorNum),Fields.InValidMessage_url_twitter(TotalErrors.ErrorNum),Fields.InValidMessage_url_youtube(TotalErrors.ErrorNum),Fields.InValidMessage_business_status_code(TotalErrors.ErrorNum),Fields.InValidMessage_business_status_desc(TotalErrors.ErrorNum),Fields.InValidMessage_franchise_flag(TotalErrors.ErrorNum),Fields.InValidMessage_franchise_type(TotalErrors.ErrorNum),Fields.InValidMessage_franchise_desc(TotalErrors.ErrorNum),Fields.InValidMessage_ticker_symbol(TotalErrors.ErrorNum),Fields.InValidMessage_stock_exchange(TotalErrors.ErrorNum),Fields.InValidMessage_fortune_1000_flag(TotalErrors.ErrorNum),Fields.InValidMessage_fortune_1000_rank(TotalErrors.ErrorNum),Fields.InValidMessage_fortune_1000_branches(TotalErrors.ErrorNum),Fields.InValidMessage_num_linked_locations(TotalErrors.ErrorNum),Fields.InValidMessage_county_code(TotalErrors.ErrorNum),Fields.InValidMessage_county_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cbsa_code(TotalErrors.ErrorNum),Fields.InValidMessage_cbsa_desc(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match_level(TotalErrors.ErrorNum),Fields.InValidMessage_latitude(TotalErrors.ErrorNum),Fields.InValidMessage_longitude(TotalErrors.ErrorNum),Fields.InValidMessage_scf(TotalErrors.ErrorNum),Fields.InValidMessage_timezone(TotalErrors.ErrorNum),Fields.InValidMessage_censustract(TotalErrors.ErrorNum),Fields.InValidMessage_censusblock(TotalErrors.ErrorNum),Fields.InValidMessage_city_population_code(TotalErrors.ErrorNum),Fields.InValidMessage_city_population_descr(TotalErrors.ErrorNum),Fields.InValidMessage_primary_sic(TotalErrors.ErrorNum),Fields.InValidMessage_primary_sic_desc(TotalErrors.ErrorNum),Fields.InValidMessage_sic02(TotalErrors.ErrorNum),Fields.InValidMessage_sic02_desc(TotalErrors.ErrorNum),Fields.InValidMessage_sic03(TotalErrors.ErrorNum),Fields.InValidMessage_sic03_desc(TotalErrors.ErrorNum),Fields.InValidMessage_sic04(TotalErrors.ErrorNum),Fields.InValidMessage_sic04_desc(TotalErrors.ErrorNum),Fields.InValidMessage_sic05(TotalErrors.ErrorNum),Fields.InValidMessage_sic05_desc(TotalErrors.ErrorNum),Fields.InValidMessage_sic06(TotalErrors.ErrorNum),Fields.InValidMessage_sic06_desc(TotalErrors.ErrorNum),Fields.InValidMessage_primarysic2(TotalErrors.ErrorNum),Fields.InValidMessage_primary_2_digit_sic_desc(TotalErrors.ErrorNum),Fields.InValidMessage_primarysic4(TotalErrors.ErrorNum),Fields.InValidMessage_primary_4_digit_sic_desc(TotalErrors.ErrorNum),Fields.InValidMessage_naics01(TotalErrors.ErrorNum),Fields.InValidMessage_naics01_desc(TotalErrors.ErrorNum),Fields.InValidMessage_naics02(TotalErrors.ErrorNum),Fields.InValidMessage_naics02_desc(TotalErrors.ErrorNum),Fields.InValidMessage_naics03(TotalErrors.ErrorNum),Fields.InValidMessage_naics03_desc(TotalErrors.ErrorNum),Fields.InValidMessage_naics04(TotalErrors.ErrorNum),Fields.InValidMessage_naics04_desc(TotalErrors.ErrorNum),Fields.InValidMessage_naics05(TotalErrors.ErrorNum),Fields.InValidMessage_naics05_desc(TotalErrors.ErrorNum),Fields.InValidMessage_naics06(TotalErrors.ErrorNum),Fields.InValidMessage_naics06_desc(TotalErrors.ErrorNum),Fields.InValidMessage_location_employees_total(TotalErrors.ErrorNum),Fields.InValidMessage_location_employee_code(TotalErrors.ErrorNum),Fields.InValidMessage_location_employee_desc(TotalErrors.ErrorNum),Fields.InValidMessage_location_sales_total(TotalErrors.ErrorNum),Fields.InValidMessage_location_sales_code(TotalErrors.ErrorNum),Fields.InValidMessage_location_sales_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corporate_employee_total(TotalErrors.ErrorNum),Fields.InValidMessage_corporate_employee_code(TotalErrors.ErrorNum),Fields.InValidMessage_corporate_employee_desc(TotalErrors.ErrorNum),Fields.InValidMessage_year_established(TotalErrors.ErrorNum),Fields.InValidMessage_years_in_business_range(TotalErrors.ErrorNum),Fields.InValidMessage_female_owned(TotalErrors.ErrorNum),Fields.InValidMessage_minority_owned_flag(TotalErrors.ErrorNum),Fields.InValidMessage_minority_type(TotalErrors.ErrorNum),Fields.InValidMessage_home_based_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_small_business_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_import_export(TotalErrors.ErrorNum),Fields.InValidMessage_manufacturing_location(TotalErrors.ErrorNum),Fields.InValidMessage_public_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_ein(TotalErrors.ErrorNum),Fields.InValidMessage_non_profit_org(TotalErrors.ErrorNum),Fields.InValidMessage_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_square_footage_code(TotalErrors.ErrorNum),Fields.InValidMessage_square_footage_desc(TotalErrors.ErrorNum),Fields.InValidMessage_creditscore(TotalErrors.ErrorNum),Fields.InValidMessage_creditcode(TotalErrors.ErrorNum),Fields.InValidMessage_credit_desc(TotalErrors.ErrorNum),Fields.InValidMessage_credit_capacity(TotalErrors.ErrorNum),Fields.InValidMessage_credit_capacity_code(TotalErrors.ErrorNum),Fields.InValidMessage_credit_capacity_desc(TotalErrors.ErrorNum),Fields.InValidMessage_advertising_expenses_code(TotalErrors.ErrorNum),Fields.InValidMessage_expense_advertising_desc(TotalErrors.ErrorNum),Fields.InValidMessage_technology_expenses_code(TotalErrors.ErrorNum),Fields.InValidMessage_expense_technology_desc(TotalErrors.ErrorNum),Fields.InValidMessage_office_equip_expenses_code(TotalErrors.ErrorNum),Fields.InValidMessage_expense_office_equip_desc(TotalErrors.ErrorNum),Fields.InValidMessage_rent_expenses_code(TotalErrors.ErrorNum),Fields.InValidMessage_expense_rent_desc(TotalErrors.ErrorNum),Fields.InValidMessage_telecom_expenses_code(TotalErrors.ErrorNum),Fields.InValidMessage_expense_telecom_desc(TotalErrors.ErrorNum),Fields.InValidMessage_accounting_expenses_code(TotalErrors.ErrorNum),Fields.InValidMessage_expense_accounting_desc(TotalErrors.ErrorNum),Fields.InValidMessage_bus_insurance_expense_code(TotalErrors.ErrorNum),Fields.InValidMessage_expense_bus_insurance_desc(TotalErrors.ErrorNum),Fields.InValidMessage_legal_expenses_code(TotalErrors.ErrorNum),Fields.InValidMessage_expense_legal_desc(TotalErrors.ErrorNum),Fields.InValidMessage_utilities_expenses_code(TotalErrors.ErrorNum),Fields.InValidMessage_expense_utilities_desc(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_pcs_code(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_pcs_desc(TotalErrors.ErrorNum),Fields.InValidMessage_nb_flag(TotalErrors.ErrorNum),Fields.InValidMessage_hq_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_hq_city(TotalErrors.ErrorNum),Fields.InValidMessage_hq_state(TotalErrors.ErrorNum),Fields.InValidMessage_subhq_parent_name(TotalErrors.ErrorNum),Fields.InValidMessage_subhq_parent_city(TotalErrors.ErrorNum),Fields.InValidMessage_subhq_parent_state(TotalErrors.ErrorNum),Fields.InValidMessage_domestic_foreign_owner_flag(TotalErrors.ErrorNum),Fields.InValidMessage_foreign_parent_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_foreign_parent_city(TotalErrors.ErrorNum),Fields.InValidMessage_foreign_parent_country(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_matchkey(TotalErrors.ErrorNum),Fields.InValidMessage_databaseusa_individual_id(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_full_name_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_middle_initial(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_email(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_gender(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_date_of_birth_year(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_date_of_birth_month(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_age(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_age_code_desc(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_age_in_two_year_hh(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_ethnic_code(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_religious_affil(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_language_pref(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_phy_addr_std(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_phy_addr_city(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_phy_addr_state(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_phy_addr_zip(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_phy_addr_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_phy_addr_carrierroute(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_phy_addr_deliverypt(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_line_of_travel(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_geocode_results(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_latitude(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_longitude(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_time_zone_code(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_time_zone_desc(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_census_tract(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_census_block(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_countyfips(TotalErrors.ErrorNum),Fields.InValidMessage_db_countyname(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_cbsa_code(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_cbsa_desc(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_walk_sequence(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_phone(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_dnc(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_scrubbed_phoneable(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_children_present(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_home_value_code(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_home_value_desc(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_donor_capacity(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_donor_capacity_code(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_donor_capacity_desc(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_home_owner_renter(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_length_of_res(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_length_of_res_code(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_length_of_res_desc(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_dwelling_type(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_recent_home_buyer(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_income_code(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_income_desc(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_unsecuredcredcap(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_unsecuredcredcapcode(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_unsecuredcredcapdesc(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_networthhomeval(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_networthhomevalcode(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_net_worth_desc(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_discretincome(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_discretincomecode(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_discretincomedesc(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_marital_status(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_new_parent(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_child_near_hs_grad(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_college_graduate(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_intend_purchase_veh(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_recent_divorce(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_newlywed(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_new_teen_driver(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_home_year_built(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_home_sqft_ranges(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_poli_party_ind(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_home_sqft_actual(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_occupation_ind(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_credit_card_user(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_home_property_type(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_education_hh(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_education_ind(TotalErrors.ErrorNum),Fields.InValidMessage_db_cons_other_pet_owner(TotalErrors.ErrorNum),Fields.InValidMessage_businesstypedesc(TotalErrors.ErrorNum),Fields.InValidMessage_genderdesc(TotalErrors.ErrorNum),Fields.InValidMessage_executivetypedesc(TotalErrors.ErrorNum),Fields.InValidMessage_dbconsgenderdesc(TotalErrors.ErrorNum),Fields.InValidMessage_dbconsethnicdesc(TotalErrors.ErrorNum),Fields.InValidMessage_dbconsreligiousdesc(TotalErrors.ErrorNum),Fields.InValidMessage_dbconslangprefdesc(TotalErrors.ErrorNum),Fields.InValidMessage_dbconsownerrenter(TotalErrors.ErrorNum),Fields.InValidMessage_dbconsdwellingtypedesc(TotalErrors.ErrorNum),Fields.InValidMessage_dbconsmaritaldesc(TotalErrors.ErrorNum),Fields.InValidMessage_dbconsnewparentdesc(TotalErrors.ErrorNum),Fields.InValidMessage_dbconsteendriverdesc(TotalErrors.ErrorNum),Fields.InValidMessage_dbconspolipartydesc(TotalErrors.ErrorNum),Fields.InValidMessage_dbconsoccupationdesc(TotalErrors.ErrorNum),Fields.InValidMessage_dbconspropertytypedesc(TotalErrors.ErrorNum),Fields.InValidMessage_dbconsheadhouseeducdesc(TotalErrors.ErrorNum),Fields.InValidMessage_dbconseducationdesc(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_raw_aid(TotalErrors.ErrorNum),Fields.InValidMessage_ace_aid(TotalErrors.ErrorNum),Fields.InValidMessage_prep_address_line1(TotalErrors.ErrorNum),Fields.InValidMessage_prep_address_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//We have seleid specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT311.MOD_ClusterStats.Counts(h,seleid);
EXPORT ClusterSrc := SALT311.MOD_ClusterStats.Sources(h,seleid,source);
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Database_USA, Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;

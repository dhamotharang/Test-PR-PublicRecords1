IMPORT SALT311,STD;
EXPORT Base_6510_hygiene(dataset(Base_6510_layout_EBR) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_powid_cnt := COUNT(GROUP,h.powid <> (TYPEOF(h.powid))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_proxid_cnt := COUNT(GROUP,h.proxid <> (TYPEOF(h.proxid))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_seleid_cnt := COUNT(GROUP,h.seleid <> (TYPEOF(h.seleid))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_orgid_cnt := COUNT(GROUP,h.orgid <> (TYPEOF(h.orgid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_ultid_cnt := COUNT(GROUP,h.ultid <> (TYPEOF(h.ultid))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_date_first_seen_cnt := COUNT(GROUP,h.date_first_seen <> (TYPEOF(h.date_first_seen))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_cnt := COUNT(GROUP,h.date_last_seen <> (TYPEOF(h.date_last_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_process_date_first_seen_cnt := COUNT(GROUP,h.process_date_first_seen <> (TYPEOF(h.process_date_first_seen))'');
    populated_process_date_first_seen_pcnt := AVE(GROUP,IF(h.process_date_first_seen = (TYPEOF(h.process_date_first_seen))'',0,100));
    maxlength_process_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date_first_seen)));
    avelength_process_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date_first_seen)),h.process_date_first_seen<>(typeof(h.process_date_first_seen))'');
    populated_process_date_last_seen_cnt := COUNT(GROUP,h.process_date_last_seen <> (TYPEOF(h.process_date_last_seen))'');
    populated_process_date_last_seen_pcnt := AVE(GROUP,IF(h.process_date_last_seen = (TYPEOF(h.process_date_last_seen))'',0,100));
    maxlength_process_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date_last_seen)));
    avelength_process_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date_last_seen)),h.process_date_last_seen<>(typeof(h.process_date_last_seen))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_file_number_cnt := COUNT(GROUP,h.file_number <> (TYPEOF(h.file_number))'');
    populated_file_number_pcnt := AVE(GROUP,IF(h.file_number = (TYPEOF(h.file_number))'',0,100));
    maxlength_file_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_number)));
    avelength_file_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_number)),h.file_number<>(typeof(h.file_number))'');
    populated_segment_code_cnt := COUNT(GROUP,h.segment_code <> (TYPEOF(h.segment_code))'');
    populated_segment_code_pcnt := AVE(GROUP,IF(h.segment_code = (TYPEOF(h.segment_code))'',0,100));
    maxlength_segment_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.segment_code)));
    avelength_segment_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.segment_code)),h.segment_code<>(typeof(h.segment_code))'');
    populated_sequence_number_cnt := COUNT(GROUP,h.sequence_number <> (TYPEOF(h.sequence_number))'');
    populated_sequence_number_pcnt := AVE(GROUP,IF(h.sequence_number = (TYPEOF(h.sequence_number))'',0,100));
    maxlength_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sequence_number)));
    avelength_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sequence_number)),h.sequence_number<>(typeof(h.sequence_number))'');
    populated_orig_date_reported_yymmdd_cnt := COUNT(GROUP,h.orig_date_reported_yymmdd <> (TYPEOF(h.orig_date_reported_yymmdd))'');
    populated_orig_date_reported_yymmdd_pcnt := AVE(GROUP,IF(h.orig_date_reported_yymmdd = (TYPEOF(h.orig_date_reported_yymmdd))'',0,100));
    maxlength_orig_date_reported_yymmdd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_date_reported_yymmdd)));
    avelength_orig_date_reported_yymmdd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_date_reported_yymmdd)),h.orig_date_reported_yymmdd<>(typeof(h.orig_date_reported_yymmdd))'');
    populated_action_code_cnt := COUNT(GROUP,h.action_code <> (TYPEOF(h.action_code))'');
    populated_action_code_pcnt := AVE(GROUP,IF(h.action_code = (TYPEOF(h.action_code))'',0,100));
    maxlength_action_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.action_code)));
    avelength_action_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.action_code)),h.action_code<>(typeof(h.action_code))'');
    populated_action_desc_cnt := COUNT(GROUP,h.action_desc <> (TYPEOF(h.action_desc))'');
    populated_action_desc_pcnt := AVE(GROUP,IF(h.action_desc = (TYPEOF(h.action_desc))'',0,100));
    maxlength_action_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.action_desc)));
    avelength_action_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.action_desc)),h.action_desc<>(typeof(h.action_desc))'');
    populated_co_bus_name_cnt := COUNT(GROUP,h.co_bus_name <> (TYPEOF(h.co_bus_name))'');
    populated_co_bus_name_pcnt := AVE(GROUP,IF(h.co_bus_name = (TYPEOF(h.co_bus_name))'',0,100));
    maxlength_co_bus_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.co_bus_name)));
    avelength_co_bus_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.co_bus_name)),h.co_bus_name<>(typeof(h.co_bus_name))'');
    populated_co_bus_address_cnt := COUNT(GROUP,h.co_bus_address <> (TYPEOF(h.co_bus_address))'');
    populated_co_bus_address_pcnt := AVE(GROUP,IF(h.co_bus_address = (TYPEOF(h.co_bus_address))'',0,100));
    maxlength_co_bus_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.co_bus_address)));
    avelength_co_bus_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.co_bus_address)),h.co_bus_address<>(typeof(h.co_bus_address))'');
    populated_co_bus_city_cnt := COUNT(GROUP,h.co_bus_city <> (TYPEOF(h.co_bus_city))'');
    populated_co_bus_city_pcnt := AVE(GROUP,IF(h.co_bus_city = (TYPEOF(h.co_bus_city))'',0,100));
    maxlength_co_bus_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.co_bus_city)));
    avelength_co_bus_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.co_bus_city)),h.co_bus_city<>(typeof(h.co_bus_city))'');
    populated_co_bus_state_code_cnt := COUNT(GROUP,h.co_bus_state_code <> (TYPEOF(h.co_bus_state_code))'');
    populated_co_bus_state_code_pcnt := AVE(GROUP,IF(h.co_bus_state_code = (TYPEOF(h.co_bus_state_code))'',0,100));
    maxlength_co_bus_state_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.co_bus_state_code)));
    avelength_co_bus_state_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.co_bus_state_code)),h.co_bus_state_code<>(typeof(h.co_bus_state_code))'');
    populated_co_bus_state_desc_cnt := COUNT(GROUP,h.co_bus_state_desc <> (TYPEOF(h.co_bus_state_desc))'');
    populated_co_bus_state_desc_pcnt := AVE(GROUP,IF(h.co_bus_state_desc = (TYPEOF(h.co_bus_state_desc))'',0,100));
    maxlength_co_bus_state_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.co_bus_state_desc)));
    avelength_co_bus_state_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.co_bus_state_desc)),h.co_bus_state_desc<>(typeof(h.co_bus_state_desc))'');
    populated_co_bus_zip_cnt := COUNT(GROUP,h.co_bus_zip <> (TYPEOF(h.co_bus_zip))'');
    populated_co_bus_zip_pcnt := AVE(GROUP,IF(h.co_bus_zip = (TYPEOF(h.co_bus_zip))'',0,100));
    maxlength_co_bus_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.co_bus_zip)));
    avelength_co_bus_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.co_bus_zip)),h.co_bus_zip<>(typeof(h.co_bus_zip))'');
    populated_extent_of_action_cnt := COUNT(GROUP,h.extent_of_action <> (TYPEOF(h.extent_of_action))'');
    populated_extent_of_action_pcnt := AVE(GROUP,IF(h.extent_of_action = (TYPEOF(h.extent_of_action))'',0,100));
    maxlength_extent_of_action := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.extent_of_action)));
    avelength_extent_of_action := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.extent_of_action)),h.extent_of_action<>(typeof(h.extent_of_action))'');
    populated_agency_code_cnt := COUNT(GROUP,h.agency_code <> (TYPEOF(h.agency_code))'');
    populated_agency_code_pcnt := AVE(GROUP,IF(h.agency_code = (TYPEOF(h.agency_code))'',0,100));
    maxlength_agency_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.agency_code)));
    avelength_agency_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.agency_code)),h.agency_code<>(typeof(h.agency_code))'');
    populated_agency_desc_cnt := COUNT(GROUP,h.agency_desc <> (TYPEOF(h.agency_desc))'');
    populated_agency_desc_pcnt := AVE(GROUP,IF(h.agency_desc = (TYPEOF(h.agency_desc))'',0,100));
    maxlength_agency_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.agency_desc)));
    avelength_agency_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.agency_desc)),h.agency_desc<>(typeof(h.agency_desc))'');
    populated_date_reported_cnt := COUNT(GROUP,h.date_reported <> (TYPEOF(h.date_reported))'');
    populated_date_reported_pcnt := AVE(GROUP,IF(h.date_reported = (TYPEOF(h.date_reported))'',0,100));
    maxlength_date_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_reported)));
    avelength_date_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_reported)),h.date_reported<>(typeof(h.date_reported))'');
    populated_prep_addr_line1_cnt := COUNT(GROUP,h.prep_addr_line1 <> (TYPEOF(h.prep_addr_line1))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_last_line_cnt := COUNT(GROUP,h.prep_addr_last_line <> (TYPEOF(h.prep_addr_last_line))'');
    populated_prep_addr_last_line_pcnt := AVE(GROUP,IF(h.prep_addr_last_line = (TYPEOF(h.prep_addr_last_line))'',0,100));
    maxlength_prep_addr_last_line := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_last_line)));
    avelength_prep_addr_last_line := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_last_line)),h.prep_addr_last_line<>(typeof(h.prep_addr_last_line))'');
    populated_clean_business_address_prim_range_cnt := COUNT(GROUP,h.clean_business_address_prim_range <> (TYPEOF(h.clean_business_address_prim_range))'');
    populated_clean_business_address_prim_range_pcnt := AVE(GROUP,IF(h.clean_business_address_prim_range = (TYPEOF(h.clean_business_address_prim_range))'',0,100));
    maxlength_clean_business_address_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_address_prim_range)));
    avelength_clean_business_address_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_address_prim_range)),h.clean_business_address_prim_range<>(typeof(h.clean_business_address_prim_range))'');
    populated_clean_business_address_prim_name_cnt := COUNT(GROUP,h.clean_business_address_prim_name <> (TYPEOF(h.clean_business_address_prim_name))'');
    populated_clean_business_address_prim_name_pcnt := AVE(GROUP,IF(h.clean_business_address_prim_name = (TYPEOF(h.clean_business_address_prim_name))'',0,100));
    maxlength_clean_business_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_address_prim_name)));
    avelength_clean_business_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_address_prim_name)),h.clean_business_address_prim_name<>(typeof(h.clean_business_address_prim_name))'');
    populated_clean_business_address_p_city_name_cnt := COUNT(GROUP,h.clean_business_address_p_city_name <> (TYPEOF(h.clean_business_address_p_city_name))'');
    populated_clean_business_address_p_city_name_pcnt := AVE(GROUP,IF(h.clean_business_address_p_city_name = (TYPEOF(h.clean_business_address_p_city_name))'',0,100));
    maxlength_clean_business_address_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_address_p_city_name)));
    avelength_clean_business_address_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_address_p_city_name)),h.clean_business_address_p_city_name<>(typeof(h.clean_business_address_p_city_name))'');
    populated_clean_business_address_v_city_name_cnt := COUNT(GROUP,h.clean_business_address_v_city_name <> (TYPEOF(h.clean_business_address_v_city_name))'');
    populated_clean_business_address_v_city_name_pcnt := AVE(GROUP,IF(h.clean_business_address_v_city_name = (TYPEOF(h.clean_business_address_v_city_name))'',0,100));
    maxlength_clean_business_address_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_address_v_city_name)));
    avelength_clean_business_address_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_address_v_city_name)),h.clean_business_address_v_city_name<>(typeof(h.clean_business_address_v_city_name))'');
    populated_clean_business_address_st_cnt := COUNT(GROUP,h.clean_business_address_st <> (TYPEOF(h.clean_business_address_st))'');
    populated_clean_business_address_st_pcnt := AVE(GROUP,IF(h.clean_business_address_st = (TYPEOF(h.clean_business_address_st))'',0,100));
    maxlength_clean_business_address_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_address_st)));
    avelength_clean_business_address_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_address_st)),h.clean_business_address_st<>(typeof(h.clean_business_address_st))'');
    populated_clean_business_address_zip_cnt := COUNT(GROUP,h.clean_business_address_zip <> (TYPEOF(h.clean_business_address_zip))'');
    populated_clean_business_address_zip_pcnt := AVE(GROUP,IF(h.clean_business_address_zip = (TYPEOF(h.clean_business_address_zip))'',0,100));
    maxlength_clean_business_address_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_address_zip)));
    avelength_clean_business_address_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_address_zip)),h.clean_business_address_zip<>(typeof(h.clean_business_address_zip))'');
    populated_clean_business_name_title_cnt := COUNT(GROUP,h.clean_business_name_title <> (TYPEOF(h.clean_business_name_title))'');
    populated_clean_business_name_title_pcnt := AVE(GROUP,IF(h.clean_business_name_title = (TYPEOF(h.clean_business_name_title))'',0,100));
    maxlength_clean_business_name_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_name_title)));
    avelength_clean_business_name_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_name_title)),h.clean_business_name_title<>(typeof(h.clean_business_name_title))'');
    populated_clean_business_name_fname_cnt := COUNT(GROUP,h.clean_business_name_fname <> (TYPEOF(h.clean_business_name_fname))'');
    populated_clean_business_name_fname_pcnt := AVE(GROUP,IF(h.clean_business_name_fname = (TYPEOF(h.clean_business_name_fname))'',0,100));
    maxlength_clean_business_name_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_name_fname)));
    avelength_clean_business_name_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_name_fname)),h.clean_business_name_fname<>(typeof(h.clean_business_name_fname))'');
    populated_clean_business_name_mname_cnt := COUNT(GROUP,h.clean_business_name_mname <> (TYPEOF(h.clean_business_name_mname))'');
    populated_clean_business_name_mname_pcnt := AVE(GROUP,IF(h.clean_business_name_mname = (TYPEOF(h.clean_business_name_mname))'',0,100));
    maxlength_clean_business_name_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_name_mname)));
    avelength_clean_business_name_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_name_mname)),h.clean_business_name_mname<>(typeof(h.clean_business_name_mname))'');
    populated_clean_business_name_lname_cnt := COUNT(GROUP,h.clean_business_name_lname <> (TYPEOF(h.clean_business_name_lname))'');
    populated_clean_business_name_lname_pcnt := AVE(GROUP,IF(h.clean_business_name_lname = (TYPEOF(h.clean_business_name_lname))'',0,100));
    maxlength_clean_business_name_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_name_lname)));
    avelength_clean_business_name_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_name_lname)),h.clean_business_name_lname<>(typeof(h.clean_business_name_lname))'');
    populated_clean_business_name_name_suffix_cnt := COUNT(GROUP,h.clean_business_name_name_suffix <> (TYPEOF(h.clean_business_name_name_suffix))'');
    populated_clean_business_name_name_suffix_pcnt := AVE(GROUP,IF(h.clean_business_name_name_suffix = (TYPEOF(h.clean_business_name_name_suffix))'',0,100));
    maxlength_clean_business_name_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_name_name_suffix)));
    avelength_clean_business_name_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_business_name_name_suffix)),h.clean_business_name_name_suffix<>(typeof(h.clean_business_name_name_suffix))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_process_date_first_seen_pcnt *   0.00 / 100 + T.Populated_process_date_last_seen_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_file_number_pcnt *   0.00 / 100 + T.Populated_segment_code_pcnt *   0.00 / 100 + T.Populated_sequence_number_pcnt *   0.00 / 100 + T.Populated_orig_date_reported_yymmdd_pcnt *   0.00 / 100 + T.Populated_action_code_pcnt *   0.00 / 100 + T.Populated_action_desc_pcnt *   0.00 / 100 + T.Populated_co_bus_name_pcnt *   0.00 / 100 + T.Populated_co_bus_address_pcnt *   0.00 / 100 + T.Populated_co_bus_city_pcnt *   0.00 / 100 + T.Populated_co_bus_state_code_pcnt *   0.00 / 100 + T.Populated_co_bus_state_desc_pcnt *   0.00 / 100 + T.Populated_co_bus_zip_pcnt *   0.00 / 100 + T.Populated_extent_of_action_pcnt *   0.00 / 100 + T.Populated_agency_code_pcnt *   0.00 / 100 + T.Populated_agency_desc_pcnt *   0.00 / 100 + T.Populated_date_reported_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_last_line_pcnt *   0.00 / 100 + T.Populated_clean_business_address_prim_range_pcnt *   0.00 / 100 + T.Populated_clean_business_address_prim_name_pcnt *   0.00 / 100 + T.Populated_clean_business_address_p_city_name_pcnt *   0.00 / 100 + T.Populated_clean_business_address_v_city_name_pcnt *   0.00 / 100 + T.Populated_clean_business_address_st_pcnt *   0.00 / 100 + T.Populated_clean_business_address_zip_pcnt *   0.00 / 100 + T.Populated_clean_business_name_title_pcnt *   0.00 / 100 + T.Populated_clean_business_name_fname_pcnt *   0.00 / 100 + T.Populated_clean_business_name_mname_pcnt *   0.00 / 100 + T.Populated_clean_business_name_lname_pcnt *   0.00 / 100 + T.Populated_clean_business_name_name_suffix_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','orig_date_reported_yymmdd','action_code','action_desc','co_bus_name','co_bus_address','co_bus_city','co_bus_state_code','co_bus_state_desc','co_bus_zip','extent_of_action','agency_code','agency_desc','date_reported','prep_addr_line1','prep_addr_last_line','clean_business_address_prim_range','clean_business_address_prim_name','clean_business_address_p_city_name','clean_business_address_v_city_name','clean_business_address_st','clean_business_address_zip','clean_business_name_title','clean_business_name_fname','clean_business_name_mname','clean_business_name_lname','clean_business_name_name_suffix');
  SELF.populated_pcnt := CHOOSE(C,le.populated_powid_pcnt,le.populated_proxid_pcnt,le.populated_seleid_pcnt,le.populated_orgid_pcnt,le.populated_ultid_pcnt,le.populated_bdid_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_process_date_first_seen_pcnt,le.populated_process_date_last_seen_pcnt,le.populated_record_type_pcnt,le.populated_process_date_pcnt,le.populated_file_number_pcnt,le.populated_segment_code_pcnt,le.populated_sequence_number_pcnt,le.populated_orig_date_reported_yymmdd_pcnt,le.populated_action_code_pcnt,le.populated_action_desc_pcnt,le.populated_co_bus_name_pcnt,le.populated_co_bus_address_pcnt,le.populated_co_bus_city_pcnt,le.populated_co_bus_state_code_pcnt,le.populated_co_bus_state_desc_pcnt,le.populated_co_bus_zip_pcnt,le.populated_extent_of_action_pcnt,le.populated_agency_code_pcnt,le.populated_agency_desc_pcnt,le.populated_date_reported_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_last_line_pcnt,le.populated_clean_business_address_prim_range_pcnt,le.populated_clean_business_address_prim_name_pcnt,le.populated_clean_business_address_p_city_name_pcnt,le.populated_clean_business_address_v_city_name_pcnt,le.populated_clean_business_address_st_pcnt,le.populated_clean_business_address_zip_pcnt,le.populated_clean_business_name_title_pcnt,le.populated_clean_business_name_fname_pcnt,le.populated_clean_business_name_mname_pcnt,le.populated_clean_business_name_lname_pcnt,le.populated_clean_business_name_name_suffix_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_powid,le.maxlength_proxid,le.maxlength_seleid,le.maxlength_orgid,le.maxlength_ultid,le.maxlength_bdid,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_process_date_first_seen,le.maxlength_process_date_last_seen,le.maxlength_record_type,le.maxlength_process_date,le.maxlength_file_number,le.maxlength_segment_code,le.maxlength_sequence_number,le.maxlength_orig_date_reported_yymmdd,le.maxlength_action_code,le.maxlength_action_desc,le.maxlength_co_bus_name,le.maxlength_co_bus_address,le.maxlength_co_bus_city,le.maxlength_co_bus_state_code,le.maxlength_co_bus_state_desc,le.maxlength_co_bus_zip,le.maxlength_extent_of_action,le.maxlength_agency_code,le.maxlength_agency_desc,le.maxlength_date_reported,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_last_line,le.maxlength_clean_business_address_prim_range,le.maxlength_clean_business_address_prim_name,le.maxlength_clean_business_address_p_city_name,le.maxlength_clean_business_address_v_city_name,le.maxlength_clean_business_address_st,le.maxlength_clean_business_address_zip,le.maxlength_clean_business_name_title,le.maxlength_clean_business_name_fname,le.maxlength_clean_business_name_mname,le.maxlength_clean_business_name_lname,le.maxlength_clean_business_name_name_suffix);
  SELF.avelength := CHOOSE(C,le.avelength_powid,le.avelength_proxid,le.avelength_seleid,le.avelength_orgid,le.avelength_ultid,le.avelength_bdid,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_process_date_first_seen,le.avelength_process_date_last_seen,le.avelength_record_type,le.avelength_process_date,le.avelength_file_number,le.avelength_segment_code,le.avelength_sequence_number,le.avelength_orig_date_reported_yymmdd,le.avelength_action_code,le.avelength_action_desc,le.avelength_co_bus_name,le.avelength_co_bus_address,le.avelength_co_bus_city,le.avelength_co_bus_state_code,le.avelength_co_bus_state_desc,le.avelength_co_bus_zip,le.avelength_extent_of_action,le.avelength_agency_code,le.avelength_agency_desc,le.avelength_date_reported,le.avelength_prep_addr_line1,le.avelength_prep_addr_last_line,le.avelength_clean_business_address_prim_range,le.avelength_clean_business_address_prim_name,le.avelength_clean_business_address_p_city_name,le.avelength_clean_business_address_v_city_name,le.avelength_clean_business_address_st,le.avelength_clean_business_address_zip,le.avelength_clean_business_name_title,le.avelength_clean_business_name_fname,le.avelength_clean_business_name_mname,le.avelength_clean_business_name_lname,le.avelength_clean_business_name_name_suffix);
END;
EXPORT invSummary := NORMALIZE(summary0, 41, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.orig_date_reported_yymmdd),TRIM((SALT311.StrType)le.action_code),TRIM((SALT311.StrType)le.action_desc),TRIM((SALT311.StrType)le.co_bus_name),TRIM((SALT311.StrType)le.co_bus_address),TRIM((SALT311.StrType)le.co_bus_city),TRIM((SALT311.StrType)le.co_bus_state_code),TRIM((SALT311.StrType)le.co_bus_state_desc),TRIM((SALT311.StrType)le.co_bus_zip),TRIM((SALT311.StrType)le.extent_of_action),TRIM((SALT311.StrType)le.agency_code),TRIM((SALT311.StrType)le.agency_desc),TRIM((SALT311.StrType)le.date_reported),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_last_line),TRIM((SALT311.StrType)le.clean_business_address_prim_range),TRIM((SALT311.StrType)le.clean_business_address_prim_name),TRIM((SALT311.StrType)le.clean_business_address_p_city_name),TRIM((SALT311.StrType)le.clean_business_address_v_city_name),TRIM((SALT311.StrType)le.clean_business_address_st),TRIM((SALT311.StrType)le.clean_business_address_zip),TRIM((SALT311.StrType)le.clean_business_name_title),TRIM((SALT311.StrType)le.clean_business_name_fname),TRIM((SALT311.StrType)le.clean_business_name_mname),TRIM((SALT311.StrType)le.clean_business_name_lname),TRIM((SALT311.StrType)le.clean_business_name_name_suffix)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,41,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 41);
  SELF.FldNo2 := 1 + (C % 41);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.orig_date_reported_yymmdd),TRIM((SALT311.StrType)le.action_code),TRIM((SALT311.StrType)le.action_desc),TRIM((SALT311.StrType)le.co_bus_name),TRIM((SALT311.StrType)le.co_bus_address),TRIM((SALT311.StrType)le.co_bus_city),TRIM((SALT311.StrType)le.co_bus_state_code),TRIM((SALT311.StrType)le.co_bus_state_desc),TRIM((SALT311.StrType)le.co_bus_zip),TRIM((SALT311.StrType)le.extent_of_action),TRIM((SALT311.StrType)le.agency_code),TRIM((SALT311.StrType)le.agency_desc),TRIM((SALT311.StrType)le.date_reported),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_last_line),TRIM((SALT311.StrType)le.clean_business_address_prim_range),TRIM((SALT311.StrType)le.clean_business_address_prim_name),TRIM((SALT311.StrType)le.clean_business_address_p_city_name),TRIM((SALT311.StrType)le.clean_business_address_v_city_name),TRIM((SALT311.StrType)le.clean_business_address_st),TRIM((SALT311.StrType)le.clean_business_address_zip),TRIM((SALT311.StrType)le.clean_business_name_title),TRIM((SALT311.StrType)le.clean_business_name_fname),TRIM((SALT311.StrType)le.clean_business_name_mname),TRIM((SALT311.StrType)le.clean_business_name_lname),TRIM((SALT311.StrType)le.clean_business_name_name_suffix)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.orig_date_reported_yymmdd),TRIM((SALT311.StrType)le.action_code),TRIM((SALT311.StrType)le.action_desc),TRIM((SALT311.StrType)le.co_bus_name),TRIM((SALT311.StrType)le.co_bus_address),TRIM((SALT311.StrType)le.co_bus_city),TRIM((SALT311.StrType)le.co_bus_state_code),TRIM((SALT311.StrType)le.co_bus_state_desc),TRIM((SALT311.StrType)le.co_bus_zip),TRIM((SALT311.StrType)le.extent_of_action),TRIM((SALT311.StrType)le.agency_code),TRIM((SALT311.StrType)le.agency_desc),TRIM((SALT311.StrType)le.date_reported),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_last_line),TRIM((SALT311.StrType)le.clean_business_address_prim_range),TRIM((SALT311.StrType)le.clean_business_address_prim_name),TRIM((SALT311.StrType)le.clean_business_address_p_city_name),TRIM((SALT311.StrType)le.clean_business_address_v_city_name),TRIM((SALT311.StrType)le.clean_business_address_st),TRIM((SALT311.StrType)le.clean_business_address_zip),TRIM((SALT311.StrType)le.clean_business_name_title),TRIM((SALT311.StrType)le.clean_business_name_fname),TRIM((SALT311.StrType)le.clean_business_name_mname),TRIM((SALT311.StrType)le.clean_business_name_lname),TRIM((SALT311.StrType)le.clean_business_name_name_suffix)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),41*41,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'powid'}
      ,{2,'proxid'}
      ,{3,'seleid'}
      ,{4,'orgid'}
      ,{5,'ultid'}
      ,{6,'bdid'}
      ,{7,'date_first_seen'}
      ,{8,'date_last_seen'}
      ,{9,'process_date_first_seen'}
      ,{10,'process_date_last_seen'}
      ,{11,'record_type'}
      ,{12,'process_date'}
      ,{13,'file_number'}
      ,{14,'segment_code'}
      ,{15,'sequence_number'}
      ,{16,'orig_date_reported_yymmdd'}
      ,{17,'action_code'}
      ,{18,'action_desc'}
      ,{19,'co_bus_name'}
      ,{20,'co_bus_address'}
      ,{21,'co_bus_city'}
      ,{22,'co_bus_state_code'}
      ,{23,'co_bus_state_desc'}
      ,{24,'co_bus_zip'}
      ,{25,'extent_of_action'}
      ,{26,'agency_code'}
      ,{27,'agency_desc'}
      ,{28,'date_reported'}
      ,{29,'prep_addr_line1'}
      ,{30,'prep_addr_last_line'}
      ,{31,'clean_business_address_prim_range'}
      ,{32,'clean_business_address_prim_name'}
      ,{33,'clean_business_address_p_city_name'}
      ,{34,'clean_business_address_v_city_name'}
      ,{35,'clean_business_address_st'}
      ,{36,'clean_business_address_zip'}
      ,{37,'clean_business_name_title'}
      ,{38,'clean_business_name_fname'}
      ,{39,'clean_business_name_mname'}
      ,{40,'clean_business_name_lname'}
      ,{41,'clean_business_name_name_suffix'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_6510_Fields.InValid_powid((SALT311.StrType)le.powid),
    Base_6510_Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Base_6510_Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Base_6510_Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Base_6510_Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Base_6510_Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Base_6510_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Base_6510_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Base_6510_Fields.InValid_process_date_first_seen((SALT311.StrType)le.process_date_first_seen),
    Base_6510_Fields.InValid_process_date_last_seen((SALT311.StrType)le.process_date_last_seen),
    Base_6510_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Base_6510_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Base_6510_Fields.InValid_file_number((SALT311.StrType)le.file_number),
    Base_6510_Fields.InValid_segment_code((SALT311.StrType)le.segment_code),
    Base_6510_Fields.InValid_sequence_number((SALT311.StrType)le.sequence_number),
    Base_6510_Fields.InValid_orig_date_reported_yymmdd((SALT311.StrType)le.orig_date_reported_yymmdd),
    Base_6510_Fields.InValid_action_code((SALT311.StrType)le.action_code),
    Base_6510_Fields.InValid_action_desc((SALT311.StrType)le.action_desc),
    Base_6510_Fields.InValid_co_bus_name((SALT311.StrType)le.co_bus_name),
    Base_6510_Fields.InValid_co_bus_address((SALT311.StrType)le.co_bus_address),
    Base_6510_Fields.InValid_co_bus_city((SALT311.StrType)le.co_bus_city),
    Base_6510_Fields.InValid_co_bus_state_code((SALT311.StrType)le.co_bus_state_code),
    Base_6510_Fields.InValid_co_bus_state_desc((SALT311.StrType)le.co_bus_state_desc),
    Base_6510_Fields.InValid_co_bus_zip((SALT311.StrType)le.co_bus_zip),
    Base_6510_Fields.InValid_extent_of_action((SALT311.StrType)le.extent_of_action),
    Base_6510_Fields.InValid_agency_code((SALT311.StrType)le.agency_code),
    Base_6510_Fields.InValid_agency_desc((SALT311.StrType)le.agency_desc),
    Base_6510_Fields.InValid_date_reported((SALT311.StrType)le.date_reported),
    Base_6510_Fields.InValid_prep_addr_line1((SALT311.StrType)le.prep_addr_line1),
    Base_6510_Fields.InValid_prep_addr_last_line((SALT311.StrType)le.prep_addr_last_line),
    Base_6510_Fields.InValid_clean_business_address_prim_range((SALT311.StrType)le.clean_business_address_prim_range),
    Base_6510_Fields.InValid_clean_business_address_prim_name((SALT311.StrType)le.clean_business_address_prim_name),
    Base_6510_Fields.InValid_clean_business_address_p_city_name((SALT311.StrType)le.clean_business_address_p_city_name),
    Base_6510_Fields.InValid_clean_business_address_v_city_name((SALT311.StrType)le.clean_business_address_v_city_name),
    Base_6510_Fields.InValid_clean_business_address_st((SALT311.StrType)le.clean_business_address_st),
    Base_6510_Fields.InValid_clean_business_address_zip((SALT311.StrType)le.clean_business_address_zip),
    Base_6510_Fields.InValid_clean_business_name_title((SALT311.StrType)le.clean_business_name_title),
    Base_6510_Fields.InValid_clean_business_name_fname((SALT311.StrType)le.clean_business_name_fname),
    Base_6510_Fields.InValid_clean_business_name_mname((SALT311.StrType)le.clean_business_name_mname),
    Base_6510_Fields.InValid_clean_business_name_lname((SALT311.StrType)le.clean_business_name_lname),
    Base_6510_Fields.InValid_clean_business_name_name_suffix((SALT311.StrType)le.clean_business_name_name_suffix),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,41,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_6510_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_numeric','invalid_dt_first_seen','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_record_type','invalid_pastdate','invalid_file_number','invalid_segment','invalid_numeric_or_allzeros','invalid_dt_yymmdd','invalid_action_code','invalid_action_desc','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_state','invalid_state_desc','invalid_zip5','invalid_extent','invalid_agency_code','invalid_agency_desc','invalid_pastdate','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip5','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_6510_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_process_date_first_seen(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_process_date_last_seen(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_file_number(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_segment_code(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_sequence_number(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_orig_date_reported_yymmdd(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_action_code(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_action_desc(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_co_bus_name(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_co_bus_address(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_co_bus_city(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_co_bus_state_code(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_co_bus_state_desc(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_co_bus_zip(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_extent_of_action(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_agency_code(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_agency_desc(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_date_reported(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_prep_addr_last_line(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_clean_business_address_prim_range(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_clean_business_address_prim_name(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_clean_business_address_p_city_name(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_clean_business_address_v_city_name(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_clean_business_address_st(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_clean_business_address_zip(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_clean_business_name_title(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_clean_business_name_fname(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_clean_business_name_mname(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_clean_business_name_lname(TotalErrors.ErrorNum),Base_6510_Fields.InValidMessage_clean_business_name_name_suffix(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_6510_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

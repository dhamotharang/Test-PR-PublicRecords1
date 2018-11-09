IMPORT SALT39,STD;
EXPORT Party_hygiene(dataset(Party_layout_Civil_Court) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dt_first_reported_cnt := COUNT(GROUP,h.dt_first_reported <> (TYPEOF(h.dt_first_reported))'');
    populated_dt_first_reported_pcnt := AVE(GROUP,IF(h.dt_first_reported = (TYPEOF(h.dt_first_reported))'',0,100));
    maxlength_dt_first_reported := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_first_reported)));
    avelength_dt_first_reported := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_first_reported)),h.dt_first_reported<>(typeof(h.dt_first_reported))'');
    populated_dt_last_reported_cnt := COUNT(GROUP,h.dt_last_reported <> (TYPEOF(h.dt_last_reported))'');
    populated_dt_last_reported_pcnt := AVE(GROUP,IF(h.dt_last_reported = (TYPEOF(h.dt_last_reported))'',0,100));
    maxlength_dt_last_reported := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_last_reported)));
    avelength_dt_last_reported := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_last_reported)),h.dt_last_reported<>(typeof(h.dt_last_reported))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_vendor_cnt := COUNT(GROUP,h.vendor <> (TYPEOF(h.vendor))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
    populated_state_origin_cnt := COUNT(GROUP,h.state_origin <> (TYPEOF(h.state_origin))'');
    populated_state_origin_pcnt := AVE(GROUP,IF(h.state_origin = (TYPEOF(h.state_origin))'',0,100));
    maxlength_state_origin := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.state_origin)));
    avelength_state_origin := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.state_origin)),h.state_origin<>(typeof(h.state_origin))'');
    populated_source_file_cnt := COUNT(GROUP,h.source_file <> (TYPEOF(h.source_file))'');
    populated_source_file_pcnt := AVE(GROUP,IF(h.source_file = (TYPEOF(h.source_file))'',0,100));
    maxlength_source_file := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.source_file)));
    avelength_source_file := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.source_file)),h.source_file<>(typeof(h.source_file))'');
    populated_case_key_cnt := COUNT(GROUP,h.case_key <> (TYPEOF(h.case_key))'');
    populated_case_key_pcnt := AVE(GROUP,IF(h.case_key = (TYPEOF(h.case_key))'',0,100));
    maxlength_case_key := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_key)));
    avelength_case_key := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_key)),h.case_key<>(typeof(h.case_key))'');
    populated_parent_case_key_cnt := COUNT(GROUP,h.parent_case_key <> (TYPEOF(h.parent_case_key))'');
    populated_parent_case_key_pcnt := AVE(GROUP,IF(h.parent_case_key = (TYPEOF(h.parent_case_key))'',0,100));
    maxlength_parent_case_key := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.parent_case_key)));
    avelength_parent_case_key := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.parent_case_key)),h.parent_case_key<>(typeof(h.parent_case_key))'');
    populated_court_code_cnt := COUNT(GROUP,h.court_code <> (TYPEOF(h.court_code))'');
    populated_court_code_pcnt := AVE(GROUP,IF(h.court_code = (TYPEOF(h.court_code))'',0,100));
    maxlength_court_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.court_code)));
    avelength_court_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.court_code)),h.court_code<>(typeof(h.court_code))'');
    populated_court_cnt := COUNT(GROUP,h.court <> (TYPEOF(h.court))'');
    populated_court_pcnt := AVE(GROUP,IF(h.court = (TYPEOF(h.court))'',0,100));
    maxlength_court := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.court)));
    avelength_court := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.court)),h.court<>(typeof(h.court))'');
    populated_case_number_cnt := COUNT(GROUP,h.case_number <> (TYPEOF(h.case_number))'');
    populated_case_number_pcnt := AVE(GROUP,IF(h.case_number = (TYPEOF(h.case_number))'',0,100));
    maxlength_case_number := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_number)));
    avelength_case_number := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_number)),h.case_number<>(typeof(h.case_number))'');
    populated_case_type_code_cnt := COUNT(GROUP,h.case_type_code <> (TYPEOF(h.case_type_code))'');
    populated_case_type_code_pcnt := AVE(GROUP,IF(h.case_type_code = (TYPEOF(h.case_type_code))'',0,100));
    maxlength_case_type_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_type_code)));
    avelength_case_type_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_type_code)),h.case_type_code<>(typeof(h.case_type_code))'');
    populated_case_type_cnt := COUNT(GROUP,h.case_type <> (TYPEOF(h.case_type))'');
    populated_case_type_pcnt := AVE(GROUP,IF(h.case_type = (TYPEOF(h.case_type))'',0,100));
    maxlength_case_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_type)));
    avelength_case_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_type)),h.case_type<>(typeof(h.case_type))'');
    populated_case_title_cnt := COUNT(GROUP,h.case_title <> (TYPEOF(h.case_title))'');
    populated_case_title_pcnt := AVE(GROUP,IF(h.case_title = (TYPEOF(h.case_title))'',0,100));
    maxlength_case_title := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_title)));
    avelength_case_title := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_title)),h.case_title<>(typeof(h.case_title))'');
    populated_ruled_for_against_code_cnt := COUNT(GROUP,h.ruled_for_against_code <> (TYPEOF(h.ruled_for_against_code))'');
    populated_ruled_for_against_code_pcnt := AVE(GROUP,IF(h.ruled_for_against_code = (TYPEOF(h.ruled_for_against_code))'',0,100));
    maxlength_ruled_for_against_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ruled_for_against_code)));
    avelength_ruled_for_against_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ruled_for_against_code)),h.ruled_for_against_code<>(typeof(h.ruled_for_against_code))'');
    populated_ruled_for_against_cnt := COUNT(GROUP,h.ruled_for_against <> (TYPEOF(h.ruled_for_against))'');
    populated_ruled_for_against_pcnt := AVE(GROUP,IF(h.ruled_for_against = (TYPEOF(h.ruled_for_against))'',0,100));
    maxlength_ruled_for_against := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ruled_for_against)));
    avelength_ruled_for_against := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ruled_for_against)),h.ruled_for_against<>(typeof(h.ruled_for_against))'');
    populated_entity_1_cnt := COUNT(GROUP,h.entity_1 <> (TYPEOF(h.entity_1))'');
    populated_entity_1_pcnt := AVE(GROUP,IF(h.entity_1 = (TYPEOF(h.entity_1))'',0,100));
    maxlength_entity_1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_1)));
    avelength_entity_1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_1)),h.entity_1<>(typeof(h.entity_1))'');
    populated_entity_nm_format_1_cnt := COUNT(GROUP,h.entity_nm_format_1 <> (TYPEOF(h.entity_nm_format_1))'');
    populated_entity_nm_format_1_pcnt := AVE(GROUP,IF(h.entity_nm_format_1 = (TYPEOF(h.entity_nm_format_1))'',0,100));
    maxlength_entity_nm_format_1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_nm_format_1)));
    avelength_entity_nm_format_1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_nm_format_1)),h.entity_nm_format_1<>(typeof(h.entity_nm_format_1))'');
    populated_entity_type_code_1_orig_cnt := COUNT(GROUP,h.entity_type_code_1_orig <> (TYPEOF(h.entity_type_code_1_orig))'');
    populated_entity_type_code_1_orig_pcnt := AVE(GROUP,IF(h.entity_type_code_1_orig = (TYPEOF(h.entity_type_code_1_orig))'',0,100));
    maxlength_entity_type_code_1_orig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_type_code_1_orig)));
    avelength_entity_type_code_1_orig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_type_code_1_orig)),h.entity_type_code_1_orig<>(typeof(h.entity_type_code_1_orig))'');
    populated_entity_type_description_1_orig_cnt := COUNT(GROUP,h.entity_type_description_1_orig <> (TYPEOF(h.entity_type_description_1_orig))'');
    populated_entity_type_description_1_orig_pcnt := AVE(GROUP,IF(h.entity_type_description_1_orig = (TYPEOF(h.entity_type_description_1_orig))'',0,100));
    maxlength_entity_type_description_1_orig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_type_description_1_orig)));
    avelength_entity_type_description_1_orig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_type_description_1_orig)),h.entity_type_description_1_orig<>(typeof(h.entity_type_description_1_orig))'');
    populated_entity_type_code_1_master_cnt := COUNT(GROUP,h.entity_type_code_1_master <> (TYPEOF(h.entity_type_code_1_master))'');
    populated_entity_type_code_1_master_pcnt := AVE(GROUP,IF(h.entity_type_code_1_master = (TYPEOF(h.entity_type_code_1_master))'',0,100));
    maxlength_entity_type_code_1_master := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_type_code_1_master)));
    avelength_entity_type_code_1_master := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_type_code_1_master)),h.entity_type_code_1_master<>(typeof(h.entity_type_code_1_master))'');
    populated_entity_seq_num_1_cnt := COUNT(GROUP,h.entity_seq_num_1 <> (TYPEOF(h.entity_seq_num_1))'');
    populated_entity_seq_num_1_pcnt := AVE(GROUP,IF(h.entity_seq_num_1 = (TYPEOF(h.entity_seq_num_1))'',0,100));
    maxlength_entity_seq_num_1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_seq_num_1)));
    avelength_entity_seq_num_1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_seq_num_1)),h.entity_seq_num_1<>(typeof(h.entity_seq_num_1))'');
    populated_atty_seq_num_1_cnt := COUNT(GROUP,h.atty_seq_num_1 <> (TYPEOF(h.atty_seq_num_1))'');
    populated_atty_seq_num_1_pcnt := AVE(GROUP,IF(h.atty_seq_num_1 = (TYPEOF(h.atty_seq_num_1))'',0,100));
    maxlength_atty_seq_num_1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.atty_seq_num_1)));
    avelength_atty_seq_num_1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.atty_seq_num_1)),h.atty_seq_num_1<>(typeof(h.atty_seq_num_1))'');
    populated_entity_1_address_1_cnt := COUNT(GROUP,h.entity_1_address_1 <> (TYPEOF(h.entity_1_address_1))'');
    populated_entity_1_address_1_pcnt := AVE(GROUP,IF(h.entity_1_address_1 = (TYPEOF(h.entity_1_address_1))'',0,100));
    maxlength_entity_1_address_1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_1_address_1)));
    avelength_entity_1_address_1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_1_address_1)),h.entity_1_address_1<>(typeof(h.entity_1_address_1))'');
    populated_entity_1_address_2_cnt := COUNT(GROUP,h.entity_1_address_2 <> (TYPEOF(h.entity_1_address_2))'');
    populated_entity_1_address_2_pcnt := AVE(GROUP,IF(h.entity_1_address_2 = (TYPEOF(h.entity_1_address_2))'',0,100));
    maxlength_entity_1_address_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_1_address_2)));
    avelength_entity_1_address_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_1_address_2)),h.entity_1_address_2<>(typeof(h.entity_1_address_2))'');
    populated_entity_1_address_3_cnt := COUNT(GROUP,h.entity_1_address_3 <> (TYPEOF(h.entity_1_address_3))'');
    populated_entity_1_address_3_pcnt := AVE(GROUP,IF(h.entity_1_address_3 = (TYPEOF(h.entity_1_address_3))'',0,100));
    maxlength_entity_1_address_3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_1_address_3)));
    avelength_entity_1_address_3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_1_address_3)),h.entity_1_address_3<>(typeof(h.entity_1_address_3))'');
    populated_entity_1_address_4_cnt := COUNT(GROUP,h.entity_1_address_4 <> (TYPEOF(h.entity_1_address_4))'');
    populated_entity_1_address_4_pcnt := AVE(GROUP,IF(h.entity_1_address_4 = (TYPEOF(h.entity_1_address_4))'',0,100));
    maxlength_entity_1_address_4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_1_address_4)));
    avelength_entity_1_address_4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_1_address_4)),h.entity_1_address_4<>(typeof(h.entity_1_address_4))'');
    populated_entity_1_dob_cnt := COUNT(GROUP,h.entity_1_dob <> (TYPEOF(h.entity_1_dob))'');
    populated_entity_1_dob_pcnt := AVE(GROUP,IF(h.entity_1_dob = (TYPEOF(h.entity_1_dob))'',0,100));
    maxlength_entity_1_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_1_dob)));
    avelength_entity_1_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_1_dob)),h.entity_1_dob<>(typeof(h.entity_1_dob))'');
    populated_primary_entity_2_cnt := COUNT(GROUP,h.primary_entity_2 <> (TYPEOF(h.primary_entity_2))'');
    populated_primary_entity_2_pcnt := AVE(GROUP,IF(h.primary_entity_2 = (TYPEOF(h.primary_entity_2))'',0,100));
    maxlength_primary_entity_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.primary_entity_2)));
    avelength_primary_entity_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.primary_entity_2)),h.primary_entity_2<>(typeof(h.primary_entity_2))'');
    populated_entity_nm_format_2_cnt := COUNT(GROUP,h.entity_nm_format_2 <> (TYPEOF(h.entity_nm_format_2))'');
    populated_entity_nm_format_2_pcnt := AVE(GROUP,IF(h.entity_nm_format_2 = (TYPEOF(h.entity_nm_format_2))'',0,100));
    maxlength_entity_nm_format_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_nm_format_2)));
    avelength_entity_nm_format_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_nm_format_2)),h.entity_nm_format_2<>(typeof(h.entity_nm_format_2))'');
    populated_entity_type_code_2_orig_cnt := COUNT(GROUP,h.entity_type_code_2_orig <> (TYPEOF(h.entity_type_code_2_orig))'');
    populated_entity_type_code_2_orig_pcnt := AVE(GROUP,IF(h.entity_type_code_2_orig = (TYPEOF(h.entity_type_code_2_orig))'',0,100));
    maxlength_entity_type_code_2_orig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_type_code_2_orig)));
    avelength_entity_type_code_2_orig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_type_code_2_orig)),h.entity_type_code_2_orig<>(typeof(h.entity_type_code_2_orig))'');
    populated_entity_type_description_2_orig_cnt := COUNT(GROUP,h.entity_type_description_2_orig <> (TYPEOF(h.entity_type_description_2_orig))'');
    populated_entity_type_description_2_orig_pcnt := AVE(GROUP,IF(h.entity_type_description_2_orig = (TYPEOF(h.entity_type_description_2_orig))'',0,100));
    maxlength_entity_type_description_2_orig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_type_description_2_orig)));
    avelength_entity_type_description_2_orig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_type_description_2_orig)),h.entity_type_description_2_orig<>(typeof(h.entity_type_description_2_orig))'');
    populated_entity_type_code_2_master_cnt := COUNT(GROUP,h.entity_type_code_2_master <> (TYPEOF(h.entity_type_code_2_master))'');
    populated_entity_type_code_2_master_pcnt := AVE(GROUP,IF(h.entity_type_code_2_master = (TYPEOF(h.entity_type_code_2_master))'',0,100));
    maxlength_entity_type_code_2_master := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_type_code_2_master)));
    avelength_entity_type_code_2_master := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_type_code_2_master)),h.entity_type_code_2_master<>(typeof(h.entity_type_code_2_master))'');
    populated_entity_seq_num_2_cnt := COUNT(GROUP,h.entity_seq_num_2 <> (TYPEOF(h.entity_seq_num_2))'');
    populated_entity_seq_num_2_pcnt := AVE(GROUP,IF(h.entity_seq_num_2 = (TYPEOF(h.entity_seq_num_2))'',0,100));
    maxlength_entity_seq_num_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_seq_num_2)));
    avelength_entity_seq_num_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_seq_num_2)),h.entity_seq_num_2<>(typeof(h.entity_seq_num_2))'');
    populated_atty_seq_num_2_cnt := COUNT(GROUP,h.atty_seq_num_2 <> (TYPEOF(h.atty_seq_num_2))'');
    populated_atty_seq_num_2_pcnt := AVE(GROUP,IF(h.atty_seq_num_2 = (TYPEOF(h.atty_seq_num_2))'',0,100));
    maxlength_atty_seq_num_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.atty_seq_num_2)));
    avelength_atty_seq_num_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.atty_seq_num_2)),h.atty_seq_num_2<>(typeof(h.atty_seq_num_2))'');
    populated_entity_2_address_1_cnt := COUNT(GROUP,h.entity_2_address_1 <> (TYPEOF(h.entity_2_address_1))'');
    populated_entity_2_address_1_pcnt := AVE(GROUP,IF(h.entity_2_address_1 = (TYPEOF(h.entity_2_address_1))'',0,100));
    maxlength_entity_2_address_1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_2_address_1)));
    avelength_entity_2_address_1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_2_address_1)),h.entity_2_address_1<>(typeof(h.entity_2_address_1))'');
    populated_entity_2_address_2_cnt := COUNT(GROUP,h.entity_2_address_2 <> (TYPEOF(h.entity_2_address_2))'');
    populated_entity_2_address_2_pcnt := AVE(GROUP,IF(h.entity_2_address_2 = (TYPEOF(h.entity_2_address_2))'',0,100));
    maxlength_entity_2_address_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_2_address_2)));
    avelength_entity_2_address_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_2_address_2)),h.entity_2_address_2<>(typeof(h.entity_2_address_2))'');
    populated_entity_2_address_3_cnt := COUNT(GROUP,h.entity_2_address_3 <> (TYPEOF(h.entity_2_address_3))'');
    populated_entity_2_address_3_pcnt := AVE(GROUP,IF(h.entity_2_address_3 = (TYPEOF(h.entity_2_address_3))'',0,100));
    maxlength_entity_2_address_3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_2_address_3)));
    avelength_entity_2_address_3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_2_address_3)),h.entity_2_address_3<>(typeof(h.entity_2_address_3))'');
    populated_entity_2_address_4_cnt := COUNT(GROUP,h.entity_2_address_4 <> (TYPEOF(h.entity_2_address_4))'');
    populated_entity_2_address_4_pcnt := AVE(GROUP,IF(h.entity_2_address_4 = (TYPEOF(h.entity_2_address_4))'',0,100));
    maxlength_entity_2_address_4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_2_address_4)));
    avelength_entity_2_address_4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_2_address_4)),h.entity_2_address_4<>(typeof(h.entity_2_address_4))'');
    populated_entity_2_dob_cnt := COUNT(GROUP,h.entity_2_dob <> (TYPEOF(h.entity_2_dob))'');
    populated_entity_2_dob_pcnt := AVE(GROUP,IF(h.entity_2_dob = (TYPEOF(h.entity_2_dob))'',0,100));
    maxlength_entity_2_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_2_dob)));
    avelength_entity_2_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_2_dob)),h.entity_2_dob<>(typeof(h.entity_2_dob))'');
    populated_prim_range1_cnt := COUNT(GROUP,h.prim_range1 <> (TYPEOF(h.prim_range1))'');
    populated_prim_range1_pcnt := AVE(GROUP,IF(h.prim_range1 = (TYPEOF(h.prim_range1))'',0,100));
    maxlength_prim_range1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_range1)));
    avelength_prim_range1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_range1)),h.prim_range1<>(typeof(h.prim_range1))'');
    populated_predir1_cnt := COUNT(GROUP,h.predir1 <> (TYPEOF(h.predir1))'');
    populated_predir1_pcnt := AVE(GROUP,IF(h.predir1 = (TYPEOF(h.predir1))'',0,100));
    maxlength_predir1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.predir1)));
    avelength_predir1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.predir1)),h.predir1<>(typeof(h.predir1))'');
    populated_prim_name1_cnt := COUNT(GROUP,h.prim_name1 <> (TYPEOF(h.prim_name1))'');
    populated_prim_name1_pcnt := AVE(GROUP,IF(h.prim_name1 = (TYPEOF(h.prim_name1))'',0,100));
    maxlength_prim_name1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_name1)));
    avelength_prim_name1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_name1)),h.prim_name1<>(typeof(h.prim_name1))'');
    populated_addr_suffix1_cnt := COUNT(GROUP,h.addr_suffix1 <> (TYPEOF(h.addr_suffix1))'');
    populated_addr_suffix1_pcnt := AVE(GROUP,IF(h.addr_suffix1 = (TYPEOF(h.addr_suffix1))'',0,100));
    maxlength_addr_suffix1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.addr_suffix1)));
    avelength_addr_suffix1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.addr_suffix1)),h.addr_suffix1<>(typeof(h.addr_suffix1))'');
    populated_postdir1_cnt := COUNT(GROUP,h.postdir1 <> (TYPEOF(h.postdir1))'');
    populated_postdir1_pcnt := AVE(GROUP,IF(h.postdir1 = (TYPEOF(h.postdir1))'',0,100));
    maxlength_postdir1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.postdir1)));
    avelength_postdir1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.postdir1)),h.postdir1<>(typeof(h.postdir1))'');
    populated_unit_desig1_cnt := COUNT(GROUP,h.unit_desig1 <> (TYPEOF(h.unit_desig1))'');
    populated_unit_desig1_pcnt := AVE(GROUP,IF(h.unit_desig1 = (TYPEOF(h.unit_desig1))'',0,100));
    maxlength_unit_desig1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.unit_desig1)));
    avelength_unit_desig1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.unit_desig1)),h.unit_desig1<>(typeof(h.unit_desig1))'');
    populated_sec_range1_cnt := COUNT(GROUP,h.sec_range1 <> (TYPEOF(h.sec_range1))'');
    populated_sec_range1_pcnt := AVE(GROUP,IF(h.sec_range1 = (TYPEOF(h.sec_range1))'',0,100));
    maxlength_sec_range1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.sec_range1)));
    avelength_sec_range1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.sec_range1)),h.sec_range1<>(typeof(h.sec_range1))'');
    populated_p_city_name1_cnt := COUNT(GROUP,h.p_city_name1 <> (TYPEOF(h.p_city_name1))'');
    populated_p_city_name1_pcnt := AVE(GROUP,IF(h.p_city_name1 = (TYPEOF(h.p_city_name1))'',0,100));
    maxlength_p_city_name1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.p_city_name1)));
    avelength_p_city_name1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.p_city_name1)),h.p_city_name1<>(typeof(h.p_city_name1))'');
    populated_v_city_name1_cnt := COUNT(GROUP,h.v_city_name1 <> (TYPEOF(h.v_city_name1))'');
    populated_v_city_name1_pcnt := AVE(GROUP,IF(h.v_city_name1 = (TYPEOF(h.v_city_name1))'',0,100));
    maxlength_v_city_name1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v_city_name1)));
    avelength_v_city_name1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v_city_name1)),h.v_city_name1<>(typeof(h.v_city_name1))'');
    populated_st1_cnt := COUNT(GROUP,h.st1 <> (TYPEOF(h.st1))'');
    populated_st1_pcnt := AVE(GROUP,IF(h.st1 = (TYPEOF(h.st1))'',0,100));
    maxlength_st1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.st1)));
    avelength_st1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.st1)),h.st1<>(typeof(h.st1))'');
    populated_zip1_cnt := COUNT(GROUP,h.zip1 <> (TYPEOF(h.zip1))'');
    populated_zip1_pcnt := AVE(GROUP,IF(h.zip1 = (TYPEOF(h.zip1))'',0,100));
    maxlength_zip1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip1)));
    avelength_zip1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip1)),h.zip1<>(typeof(h.zip1))'');
    populated_zip41_cnt := COUNT(GROUP,h.zip41 <> (TYPEOF(h.zip41))'');
    populated_zip41_pcnt := AVE(GROUP,IF(h.zip41 = (TYPEOF(h.zip41))'',0,100));
    maxlength_zip41 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip41)));
    avelength_zip41 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip41)),h.zip41<>(typeof(h.zip41))'');
    populated_cart1_cnt := COUNT(GROUP,h.cart1 <> (TYPEOF(h.cart1))'');
    populated_cart1_pcnt := AVE(GROUP,IF(h.cart1 = (TYPEOF(h.cart1))'',0,100));
    maxlength_cart1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cart1)));
    avelength_cart1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cart1)),h.cart1<>(typeof(h.cart1))'');
    populated_cr_sort_sz1_cnt := COUNT(GROUP,h.cr_sort_sz1 <> (TYPEOF(h.cr_sort_sz1))'');
    populated_cr_sort_sz1_pcnt := AVE(GROUP,IF(h.cr_sort_sz1 = (TYPEOF(h.cr_sort_sz1))'',0,100));
    maxlength_cr_sort_sz1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cr_sort_sz1)));
    avelength_cr_sort_sz1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cr_sort_sz1)),h.cr_sort_sz1<>(typeof(h.cr_sort_sz1))'');
    populated_lot1_cnt := COUNT(GROUP,h.lot1 <> (TYPEOF(h.lot1))'');
    populated_lot1_pcnt := AVE(GROUP,IF(h.lot1 = (TYPEOF(h.lot1))'',0,100));
    maxlength_lot1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.lot1)));
    avelength_lot1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.lot1)),h.lot1<>(typeof(h.lot1))'');
    populated_lot_order1_cnt := COUNT(GROUP,h.lot_order1 <> (TYPEOF(h.lot_order1))'');
    populated_lot_order1_pcnt := AVE(GROUP,IF(h.lot_order1 = (TYPEOF(h.lot_order1))'',0,100));
    maxlength_lot_order1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.lot_order1)));
    avelength_lot_order1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.lot_order1)),h.lot_order1<>(typeof(h.lot_order1))'');
    populated_dpbc1_cnt := COUNT(GROUP,h.dpbc1 <> (TYPEOF(h.dpbc1))'');
    populated_dpbc1_pcnt := AVE(GROUP,IF(h.dpbc1 = (TYPEOF(h.dpbc1))'',0,100));
    maxlength_dpbc1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dpbc1)));
    avelength_dpbc1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dpbc1)),h.dpbc1<>(typeof(h.dpbc1))'');
    populated_chk_digit1_cnt := COUNT(GROUP,h.chk_digit1 <> (TYPEOF(h.chk_digit1))'');
    populated_chk_digit1_pcnt := AVE(GROUP,IF(h.chk_digit1 = (TYPEOF(h.chk_digit1))'',0,100));
    maxlength_chk_digit1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.chk_digit1)));
    avelength_chk_digit1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.chk_digit1)),h.chk_digit1<>(typeof(h.chk_digit1))'');
    populated_rec_type1_cnt := COUNT(GROUP,h.rec_type1 <> (TYPEOF(h.rec_type1))'');
    populated_rec_type1_pcnt := AVE(GROUP,IF(h.rec_type1 = (TYPEOF(h.rec_type1))'',0,100));
    maxlength_rec_type1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.rec_type1)));
    avelength_rec_type1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.rec_type1)),h.rec_type1<>(typeof(h.rec_type1))'');
    populated_ace_fips_st1_cnt := COUNT(GROUP,h.ace_fips_st1 <> (TYPEOF(h.ace_fips_st1))'');
    populated_ace_fips_st1_pcnt := AVE(GROUP,IF(h.ace_fips_st1 = (TYPEOF(h.ace_fips_st1))'',0,100));
    maxlength_ace_fips_st1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ace_fips_st1)));
    avelength_ace_fips_st1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ace_fips_st1)),h.ace_fips_st1<>(typeof(h.ace_fips_st1))'');
    populated_ace_fips_county1_cnt := COUNT(GROUP,h.ace_fips_county1 <> (TYPEOF(h.ace_fips_county1))'');
    populated_ace_fips_county1_pcnt := AVE(GROUP,IF(h.ace_fips_county1 = (TYPEOF(h.ace_fips_county1))'',0,100));
    maxlength_ace_fips_county1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ace_fips_county1)));
    avelength_ace_fips_county1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ace_fips_county1)),h.ace_fips_county1<>(typeof(h.ace_fips_county1))'');
    populated_geo_lat1_cnt := COUNT(GROUP,h.geo_lat1 <> (TYPEOF(h.geo_lat1))'');
    populated_geo_lat1_pcnt := AVE(GROUP,IF(h.geo_lat1 = (TYPEOF(h.geo_lat1))'',0,100));
    maxlength_geo_lat1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_lat1)));
    avelength_geo_lat1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_lat1)),h.geo_lat1<>(typeof(h.geo_lat1))'');
    populated_geo_long1_cnt := COUNT(GROUP,h.geo_long1 <> (TYPEOF(h.geo_long1))'');
    populated_geo_long1_pcnt := AVE(GROUP,IF(h.geo_long1 = (TYPEOF(h.geo_long1))'',0,100));
    maxlength_geo_long1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_long1)));
    avelength_geo_long1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_long1)),h.geo_long1<>(typeof(h.geo_long1))'');
    populated_msa1_cnt := COUNT(GROUP,h.msa1 <> (TYPEOF(h.msa1))'');
    populated_msa1_pcnt := AVE(GROUP,IF(h.msa1 = (TYPEOF(h.msa1))'',0,100));
    maxlength_msa1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.msa1)));
    avelength_msa1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.msa1)),h.msa1<>(typeof(h.msa1))'');
    populated_geo_blk1_cnt := COUNT(GROUP,h.geo_blk1 <> (TYPEOF(h.geo_blk1))'');
    populated_geo_blk1_pcnt := AVE(GROUP,IF(h.geo_blk1 = (TYPEOF(h.geo_blk1))'',0,100));
    maxlength_geo_blk1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_blk1)));
    avelength_geo_blk1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_blk1)),h.geo_blk1<>(typeof(h.geo_blk1))'');
    populated_geo_match1_cnt := COUNT(GROUP,h.geo_match1 <> (TYPEOF(h.geo_match1))'');
    populated_geo_match1_pcnt := AVE(GROUP,IF(h.geo_match1 = (TYPEOF(h.geo_match1))'',0,100));
    maxlength_geo_match1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_match1)));
    avelength_geo_match1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_match1)),h.geo_match1<>(typeof(h.geo_match1))'');
    populated_err_stat1_cnt := COUNT(GROUP,h.err_stat1 <> (TYPEOF(h.err_stat1))'');
    populated_err_stat1_pcnt := AVE(GROUP,IF(h.err_stat1 = (TYPEOF(h.err_stat1))'',0,100));
    maxlength_err_stat1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.err_stat1)));
    avelength_err_stat1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.err_stat1)),h.err_stat1<>(typeof(h.err_stat1))'');
    populated_prim_range2_cnt := COUNT(GROUP,h.prim_range2 <> (TYPEOF(h.prim_range2))'');
    populated_prim_range2_pcnt := AVE(GROUP,IF(h.prim_range2 = (TYPEOF(h.prim_range2))'',0,100));
    maxlength_prim_range2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_range2)));
    avelength_prim_range2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_range2)),h.prim_range2<>(typeof(h.prim_range2))'');
    populated_predir2_cnt := COUNT(GROUP,h.predir2 <> (TYPEOF(h.predir2))'');
    populated_predir2_pcnt := AVE(GROUP,IF(h.predir2 = (TYPEOF(h.predir2))'',0,100));
    maxlength_predir2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.predir2)));
    avelength_predir2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.predir2)),h.predir2<>(typeof(h.predir2))'');
    populated_prim_name2_cnt := COUNT(GROUP,h.prim_name2 <> (TYPEOF(h.prim_name2))'');
    populated_prim_name2_pcnt := AVE(GROUP,IF(h.prim_name2 = (TYPEOF(h.prim_name2))'',0,100));
    maxlength_prim_name2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_name2)));
    avelength_prim_name2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_name2)),h.prim_name2<>(typeof(h.prim_name2))'');
    populated_addr_suffix2_cnt := COUNT(GROUP,h.addr_suffix2 <> (TYPEOF(h.addr_suffix2))'');
    populated_addr_suffix2_pcnt := AVE(GROUP,IF(h.addr_suffix2 = (TYPEOF(h.addr_suffix2))'',0,100));
    maxlength_addr_suffix2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.addr_suffix2)));
    avelength_addr_suffix2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.addr_suffix2)),h.addr_suffix2<>(typeof(h.addr_suffix2))'');
    populated_postdir2_cnt := COUNT(GROUP,h.postdir2 <> (TYPEOF(h.postdir2))'');
    populated_postdir2_pcnt := AVE(GROUP,IF(h.postdir2 = (TYPEOF(h.postdir2))'',0,100));
    maxlength_postdir2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.postdir2)));
    avelength_postdir2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.postdir2)),h.postdir2<>(typeof(h.postdir2))'');
    populated_unit_desig2_cnt := COUNT(GROUP,h.unit_desig2 <> (TYPEOF(h.unit_desig2))'');
    populated_unit_desig2_pcnt := AVE(GROUP,IF(h.unit_desig2 = (TYPEOF(h.unit_desig2))'',0,100));
    maxlength_unit_desig2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.unit_desig2)));
    avelength_unit_desig2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.unit_desig2)),h.unit_desig2<>(typeof(h.unit_desig2))'');
    populated_sec_range2_cnt := COUNT(GROUP,h.sec_range2 <> (TYPEOF(h.sec_range2))'');
    populated_sec_range2_pcnt := AVE(GROUP,IF(h.sec_range2 = (TYPEOF(h.sec_range2))'',0,100));
    maxlength_sec_range2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.sec_range2)));
    avelength_sec_range2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.sec_range2)),h.sec_range2<>(typeof(h.sec_range2))'');
    populated_p_city_name2_cnt := COUNT(GROUP,h.p_city_name2 <> (TYPEOF(h.p_city_name2))'');
    populated_p_city_name2_pcnt := AVE(GROUP,IF(h.p_city_name2 = (TYPEOF(h.p_city_name2))'',0,100));
    maxlength_p_city_name2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.p_city_name2)));
    avelength_p_city_name2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.p_city_name2)),h.p_city_name2<>(typeof(h.p_city_name2))'');
    populated_v_city_name2_cnt := COUNT(GROUP,h.v_city_name2 <> (TYPEOF(h.v_city_name2))'');
    populated_v_city_name2_pcnt := AVE(GROUP,IF(h.v_city_name2 = (TYPEOF(h.v_city_name2))'',0,100));
    maxlength_v_city_name2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v_city_name2)));
    avelength_v_city_name2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v_city_name2)),h.v_city_name2<>(typeof(h.v_city_name2))'');
    populated_st2_cnt := COUNT(GROUP,h.st2 <> (TYPEOF(h.st2))'');
    populated_st2_pcnt := AVE(GROUP,IF(h.st2 = (TYPEOF(h.st2))'',0,100));
    maxlength_st2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.st2)));
    avelength_st2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.st2)),h.st2<>(typeof(h.st2))'');
    populated_zip2_cnt := COUNT(GROUP,h.zip2 <> (TYPEOF(h.zip2))'');
    populated_zip2_pcnt := AVE(GROUP,IF(h.zip2 = (TYPEOF(h.zip2))'',0,100));
    maxlength_zip2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip2)));
    avelength_zip2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip2)),h.zip2<>(typeof(h.zip2))'');
    populated_zip42_cnt := COUNT(GROUP,h.zip42 <> (TYPEOF(h.zip42))'');
    populated_zip42_pcnt := AVE(GROUP,IF(h.zip42 = (TYPEOF(h.zip42))'',0,100));
    maxlength_zip42 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip42)));
    avelength_zip42 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip42)),h.zip42<>(typeof(h.zip42))'');
    populated_cart2_cnt := COUNT(GROUP,h.cart2 <> (TYPEOF(h.cart2))'');
    populated_cart2_pcnt := AVE(GROUP,IF(h.cart2 = (TYPEOF(h.cart2))'',0,100));
    maxlength_cart2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cart2)));
    avelength_cart2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cart2)),h.cart2<>(typeof(h.cart2))'');
    populated_cr_sort_sz2_cnt := COUNT(GROUP,h.cr_sort_sz2 <> (TYPEOF(h.cr_sort_sz2))'');
    populated_cr_sort_sz2_pcnt := AVE(GROUP,IF(h.cr_sort_sz2 = (TYPEOF(h.cr_sort_sz2))'',0,100));
    maxlength_cr_sort_sz2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cr_sort_sz2)));
    avelength_cr_sort_sz2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cr_sort_sz2)),h.cr_sort_sz2<>(typeof(h.cr_sort_sz2))'');
    populated_lot2_cnt := COUNT(GROUP,h.lot2 <> (TYPEOF(h.lot2))'');
    populated_lot2_pcnt := AVE(GROUP,IF(h.lot2 = (TYPEOF(h.lot2))'',0,100));
    maxlength_lot2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.lot2)));
    avelength_lot2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.lot2)),h.lot2<>(typeof(h.lot2))'');
    populated_lot_order2_cnt := COUNT(GROUP,h.lot_order2 <> (TYPEOF(h.lot_order2))'');
    populated_lot_order2_pcnt := AVE(GROUP,IF(h.lot_order2 = (TYPEOF(h.lot_order2))'',0,100));
    maxlength_lot_order2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.lot_order2)));
    avelength_lot_order2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.lot_order2)),h.lot_order2<>(typeof(h.lot_order2))'');
    populated_dpbc2_cnt := COUNT(GROUP,h.dpbc2 <> (TYPEOF(h.dpbc2))'');
    populated_dpbc2_pcnt := AVE(GROUP,IF(h.dpbc2 = (TYPEOF(h.dpbc2))'',0,100));
    maxlength_dpbc2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dpbc2)));
    avelength_dpbc2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dpbc2)),h.dpbc2<>(typeof(h.dpbc2))'');
    populated_chk_digit2_cnt := COUNT(GROUP,h.chk_digit2 <> (TYPEOF(h.chk_digit2))'');
    populated_chk_digit2_pcnt := AVE(GROUP,IF(h.chk_digit2 = (TYPEOF(h.chk_digit2))'',0,100));
    maxlength_chk_digit2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.chk_digit2)));
    avelength_chk_digit2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.chk_digit2)),h.chk_digit2<>(typeof(h.chk_digit2))'');
    populated_rec_type2_cnt := COUNT(GROUP,h.rec_type2 <> (TYPEOF(h.rec_type2))'');
    populated_rec_type2_pcnt := AVE(GROUP,IF(h.rec_type2 = (TYPEOF(h.rec_type2))'',0,100));
    maxlength_rec_type2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.rec_type2)));
    avelength_rec_type2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.rec_type2)),h.rec_type2<>(typeof(h.rec_type2))'');
    populated_ace_fips_st2_cnt := COUNT(GROUP,h.ace_fips_st2 <> (TYPEOF(h.ace_fips_st2))'');
    populated_ace_fips_st2_pcnt := AVE(GROUP,IF(h.ace_fips_st2 = (TYPEOF(h.ace_fips_st2))'',0,100));
    maxlength_ace_fips_st2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ace_fips_st2)));
    avelength_ace_fips_st2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ace_fips_st2)),h.ace_fips_st2<>(typeof(h.ace_fips_st2))'');
    populated_ace_fips_county2_cnt := COUNT(GROUP,h.ace_fips_county2 <> (TYPEOF(h.ace_fips_county2))'');
    populated_ace_fips_county2_pcnt := AVE(GROUP,IF(h.ace_fips_county2 = (TYPEOF(h.ace_fips_county2))'',0,100));
    maxlength_ace_fips_county2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ace_fips_county2)));
    avelength_ace_fips_county2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ace_fips_county2)),h.ace_fips_county2<>(typeof(h.ace_fips_county2))'');
    populated_geo_lat2_cnt := COUNT(GROUP,h.geo_lat2 <> (TYPEOF(h.geo_lat2))'');
    populated_geo_lat2_pcnt := AVE(GROUP,IF(h.geo_lat2 = (TYPEOF(h.geo_lat2))'',0,100));
    maxlength_geo_lat2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_lat2)));
    avelength_geo_lat2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_lat2)),h.geo_lat2<>(typeof(h.geo_lat2))'');
    populated_geo_long2_cnt := COUNT(GROUP,h.geo_long2 <> (TYPEOF(h.geo_long2))'');
    populated_geo_long2_pcnt := AVE(GROUP,IF(h.geo_long2 = (TYPEOF(h.geo_long2))'',0,100));
    maxlength_geo_long2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_long2)));
    avelength_geo_long2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_long2)),h.geo_long2<>(typeof(h.geo_long2))'');
    populated_msa2_cnt := COUNT(GROUP,h.msa2 <> (TYPEOF(h.msa2))'');
    populated_msa2_pcnt := AVE(GROUP,IF(h.msa2 = (TYPEOF(h.msa2))'',0,100));
    maxlength_msa2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.msa2)));
    avelength_msa2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.msa2)),h.msa2<>(typeof(h.msa2))'');
    populated_geo_blk2_cnt := COUNT(GROUP,h.geo_blk2 <> (TYPEOF(h.geo_blk2))'');
    populated_geo_blk2_pcnt := AVE(GROUP,IF(h.geo_blk2 = (TYPEOF(h.geo_blk2))'',0,100));
    maxlength_geo_blk2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_blk2)));
    avelength_geo_blk2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_blk2)),h.geo_blk2<>(typeof(h.geo_blk2))'');
    populated_geo_match2_cnt := COUNT(GROUP,h.geo_match2 <> (TYPEOF(h.geo_match2))'');
    populated_geo_match2_pcnt := AVE(GROUP,IF(h.geo_match2 = (TYPEOF(h.geo_match2))'',0,100));
    maxlength_geo_match2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_match2)));
    avelength_geo_match2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_match2)),h.geo_match2<>(typeof(h.geo_match2))'');
    populated_err_stat2_cnt := COUNT(GROUP,h.err_stat2 <> (TYPEOF(h.err_stat2))'');
    populated_err_stat2_pcnt := AVE(GROUP,IF(h.err_stat2 = (TYPEOF(h.err_stat2))'',0,100));
    maxlength_err_stat2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.err_stat2)));
    avelength_err_stat2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.err_stat2)),h.err_stat2<>(typeof(h.err_stat2))'');
    populated_e1_title1_cnt := COUNT(GROUP,h.e1_title1 <> (TYPEOF(h.e1_title1))'');
    populated_e1_title1_pcnt := AVE(GROUP,IF(h.e1_title1 = (TYPEOF(h.e1_title1))'',0,100));
    maxlength_e1_title1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_title1)));
    avelength_e1_title1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_title1)),h.e1_title1<>(typeof(h.e1_title1))'');
    populated_e1_fname1_cnt := COUNT(GROUP,h.e1_fname1 <> (TYPEOF(h.e1_fname1))'');
    populated_e1_fname1_pcnt := AVE(GROUP,IF(h.e1_fname1 = (TYPEOF(h.e1_fname1))'',0,100));
    maxlength_e1_fname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_fname1)));
    avelength_e1_fname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_fname1)),h.e1_fname1<>(typeof(h.e1_fname1))'');
    populated_e1_mname1_cnt := COUNT(GROUP,h.e1_mname1 <> (TYPEOF(h.e1_mname1))'');
    populated_e1_mname1_pcnt := AVE(GROUP,IF(h.e1_mname1 = (TYPEOF(h.e1_mname1))'',0,100));
    maxlength_e1_mname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_mname1)));
    avelength_e1_mname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_mname1)),h.e1_mname1<>(typeof(h.e1_mname1))'');
    populated_e1_lname1_cnt := COUNT(GROUP,h.e1_lname1 <> (TYPEOF(h.e1_lname1))'');
    populated_e1_lname1_pcnt := AVE(GROUP,IF(h.e1_lname1 = (TYPEOF(h.e1_lname1))'',0,100));
    maxlength_e1_lname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_lname1)));
    avelength_e1_lname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_lname1)),h.e1_lname1<>(typeof(h.e1_lname1))'');
    populated_e1_suffix1_cnt := COUNT(GROUP,h.e1_suffix1 <> (TYPEOF(h.e1_suffix1))'');
    populated_e1_suffix1_pcnt := AVE(GROUP,IF(h.e1_suffix1 = (TYPEOF(h.e1_suffix1))'',0,100));
    maxlength_e1_suffix1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_suffix1)));
    avelength_e1_suffix1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_suffix1)),h.e1_suffix1<>(typeof(h.e1_suffix1))'');
    populated_e1_pname1_score_cnt := COUNT(GROUP,h.e1_pname1_score <> (TYPEOF(h.e1_pname1_score))'');
    populated_e1_pname1_score_pcnt := AVE(GROUP,IF(h.e1_pname1_score = (TYPEOF(h.e1_pname1_score))'',0,100));
    maxlength_e1_pname1_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_pname1_score)));
    avelength_e1_pname1_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_pname1_score)),h.e1_pname1_score<>(typeof(h.e1_pname1_score))'');
    populated_e1_cname1_cnt := COUNT(GROUP,h.e1_cname1 <> (TYPEOF(h.e1_cname1))'');
    populated_e1_cname1_pcnt := AVE(GROUP,IF(h.e1_cname1 = (TYPEOF(h.e1_cname1))'',0,100));
    maxlength_e1_cname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_cname1)));
    avelength_e1_cname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_cname1)),h.e1_cname1<>(typeof(h.e1_cname1))'');
    populated_e1_title2_cnt := COUNT(GROUP,h.e1_title2 <> (TYPEOF(h.e1_title2))'');
    populated_e1_title2_pcnt := AVE(GROUP,IF(h.e1_title2 = (TYPEOF(h.e1_title2))'',0,100));
    maxlength_e1_title2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_title2)));
    avelength_e1_title2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_title2)),h.e1_title2<>(typeof(h.e1_title2))'');
    populated_e1_fname2_cnt := COUNT(GROUP,h.e1_fname2 <> (TYPEOF(h.e1_fname2))'');
    populated_e1_fname2_pcnt := AVE(GROUP,IF(h.e1_fname2 = (TYPEOF(h.e1_fname2))'',0,100));
    maxlength_e1_fname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_fname2)));
    avelength_e1_fname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_fname2)),h.e1_fname2<>(typeof(h.e1_fname2))'');
    populated_e1_mname2_cnt := COUNT(GROUP,h.e1_mname2 <> (TYPEOF(h.e1_mname2))'');
    populated_e1_mname2_pcnt := AVE(GROUP,IF(h.e1_mname2 = (TYPEOF(h.e1_mname2))'',0,100));
    maxlength_e1_mname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_mname2)));
    avelength_e1_mname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_mname2)),h.e1_mname2<>(typeof(h.e1_mname2))'');
    populated_e1_lname2_cnt := COUNT(GROUP,h.e1_lname2 <> (TYPEOF(h.e1_lname2))'');
    populated_e1_lname2_pcnt := AVE(GROUP,IF(h.e1_lname2 = (TYPEOF(h.e1_lname2))'',0,100));
    maxlength_e1_lname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_lname2)));
    avelength_e1_lname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_lname2)),h.e1_lname2<>(typeof(h.e1_lname2))'');
    populated_e1_suffix2_cnt := COUNT(GROUP,h.e1_suffix2 <> (TYPEOF(h.e1_suffix2))'');
    populated_e1_suffix2_pcnt := AVE(GROUP,IF(h.e1_suffix2 = (TYPEOF(h.e1_suffix2))'',0,100));
    maxlength_e1_suffix2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_suffix2)));
    avelength_e1_suffix2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_suffix2)),h.e1_suffix2<>(typeof(h.e1_suffix2))'');
    populated_e1_pname2_score_cnt := COUNT(GROUP,h.e1_pname2_score <> (TYPEOF(h.e1_pname2_score))'');
    populated_e1_pname2_score_pcnt := AVE(GROUP,IF(h.e1_pname2_score = (TYPEOF(h.e1_pname2_score))'',0,100));
    maxlength_e1_pname2_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_pname2_score)));
    avelength_e1_pname2_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_pname2_score)),h.e1_pname2_score<>(typeof(h.e1_pname2_score))'');
    populated_e1_cname2_cnt := COUNT(GROUP,h.e1_cname2 <> (TYPEOF(h.e1_cname2))'');
    populated_e1_cname2_pcnt := AVE(GROUP,IF(h.e1_cname2 = (TYPEOF(h.e1_cname2))'',0,100));
    maxlength_e1_cname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_cname2)));
    avelength_e1_cname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_cname2)),h.e1_cname2<>(typeof(h.e1_cname2))'');
    populated_e1_title3_cnt := COUNT(GROUP,h.e1_title3 <> (TYPEOF(h.e1_title3))'');
    populated_e1_title3_pcnt := AVE(GROUP,IF(h.e1_title3 = (TYPEOF(h.e1_title3))'',0,100));
    maxlength_e1_title3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_title3)));
    avelength_e1_title3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_title3)),h.e1_title3<>(typeof(h.e1_title3))'');
    populated_e1_fname3_cnt := COUNT(GROUP,h.e1_fname3 <> (TYPEOF(h.e1_fname3))'');
    populated_e1_fname3_pcnt := AVE(GROUP,IF(h.e1_fname3 = (TYPEOF(h.e1_fname3))'',0,100));
    maxlength_e1_fname3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_fname3)));
    avelength_e1_fname3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_fname3)),h.e1_fname3<>(typeof(h.e1_fname3))'');
    populated_e1_mname3_cnt := COUNT(GROUP,h.e1_mname3 <> (TYPEOF(h.e1_mname3))'');
    populated_e1_mname3_pcnt := AVE(GROUP,IF(h.e1_mname3 = (TYPEOF(h.e1_mname3))'',0,100));
    maxlength_e1_mname3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_mname3)));
    avelength_e1_mname3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_mname3)),h.e1_mname3<>(typeof(h.e1_mname3))'');
    populated_e1_lname3_cnt := COUNT(GROUP,h.e1_lname3 <> (TYPEOF(h.e1_lname3))'');
    populated_e1_lname3_pcnt := AVE(GROUP,IF(h.e1_lname3 = (TYPEOF(h.e1_lname3))'',0,100));
    maxlength_e1_lname3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_lname3)));
    avelength_e1_lname3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_lname3)),h.e1_lname3<>(typeof(h.e1_lname3))'');
    populated_e1_suffix3_cnt := COUNT(GROUP,h.e1_suffix3 <> (TYPEOF(h.e1_suffix3))'');
    populated_e1_suffix3_pcnt := AVE(GROUP,IF(h.e1_suffix3 = (TYPEOF(h.e1_suffix3))'',0,100));
    maxlength_e1_suffix3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_suffix3)));
    avelength_e1_suffix3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_suffix3)),h.e1_suffix3<>(typeof(h.e1_suffix3))'');
    populated_e1_pname3_score_cnt := COUNT(GROUP,h.e1_pname3_score <> (TYPEOF(h.e1_pname3_score))'');
    populated_e1_pname3_score_pcnt := AVE(GROUP,IF(h.e1_pname3_score = (TYPEOF(h.e1_pname3_score))'',0,100));
    maxlength_e1_pname3_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_pname3_score)));
    avelength_e1_pname3_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_pname3_score)),h.e1_pname3_score<>(typeof(h.e1_pname3_score))'');
    populated_e1_cname3_cnt := COUNT(GROUP,h.e1_cname3 <> (TYPEOF(h.e1_cname3))'');
    populated_e1_cname3_pcnt := AVE(GROUP,IF(h.e1_cname3 = (TYPEOF(h.e1_cname3))'',0,100));
    maxlength_e1_cname3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_cname3)));
    avelength_e1_cname3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_cname3)),h.e1_cname3<>(typeof(h.e1_cname3))'');
    populated_e1_title4_cnt := COUNT(GROUP,h.e1_title4 <> (TYPEOF(h.e1_title4))'');
    populated_e1_title4_pcnt := AVE(GROUP,IF(h.e1_title4 = (TYPEOF(h.e1_title4))'',0,100));
    maxlength_e1_title4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_title4)));
    avelength_e1_title4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_title4)),h.e1_title4<>(typeof(h.e1_title4))'');
    populated_e1_fname4_cnt := COUNT(GROUP,h.e1_fname4 <> (TYPEOF(h.e1_fname4))'');
    populated_e1_fname4_pcnt := AVE(GROUP,IF(h.e1_fname4 = (TYPEOF(h.e1_fname4))'',0,100));
    maxlength_e1_fname4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_fname4)));
    avelength_e1_fname4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_fname4)),h.e1_fname4<>(typeof(h.e1_fname4))'');
    populated_e1_mname4_cnt := COUNT(GROUP,h.e1_mname4 <> (TYPEOF(h.e1_mname4))'');
    populated_e1_mname4_pcnt := AVE(GROUP,IF(h.e1_mname4 = (TYPEOF(h.e1_mname4))'',0,100));
    maxlength_e1_mname4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_mname4)));
    avelength_e1_mname4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_mname4)),h.e1_mname4<>(typeof(h.e1_mname4))'');
    populated_e1_lname4_cnt := COUNT(GROUP,h.e1_lname4 <> (TYPEOF(h.e1_lname4))'');
    populated_e1_lname4_pcnt := AVE(GROUP,IF(h.e1_lname4 = (TYPEOF(h.e1_lname4))'',0,100));
    maxlength_e1_lname4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_lname4)));
    avelength_e1_lname4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_lname4)),h.e1_lname4<>(typeof(h.e1_lname4))'');
    populated_e1_suffix4_cnt := COUNT(GROUP,h.e1_suffix4 <> (TYPEOF(h.e1_suffix4))'');
    populated_e1_suffix4_pcnt := AVE(GROUP,IF(h.e1_suffix4 = (TYPEOF(h.e1_suffix4))'',0,100));
    maxlength_e1_suffix4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_suffix4)));
    avelength_e1_suffix4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_suffix4)),h.e1_suffix4<>(typeof(h.e1_suffix4))'');
    populated_e1_pname4_score_cnt := COUNT(GROUP,h.e1_pname4_score <> (TYPEOF(h.e1_pname4_score))'');
    populated_e1_pname4_score_pcnt := AVE(GROUP,IF(h.e1_pname4_score = (TYPEOF(h.e1_pname4_score))'',0,100));
    maxlength_e1_pname4_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_pname4_score)));
    avelength_e1_pname4_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_pname4_score)),h.e1_pname4_score<>(typeof(h.e1_pname4_score))'');
    populated_e1_cname4_cnt := COUNT(GROUP,h.e1_cname4 <> (TYPEOF(h.e1_cname4))'');
    populated_e1_cname4_pcnt := AVE(GROUP,IF(h.e1_cname4 = (TYPEOF(h.e1_cname4))'',0,100));
    maxlength_e1_cname4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_cname4)));
    avelength_e1_cname4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_cname4)),h.e1_cname4<>(typeof(h.e1_cname4))'');
    populated_e1_title5_cnt := COUNT(GROUP,h.e1_title5 <> (TYPEOF(h.e1_title5))'');
    populated_e1_title5_pcnt := AVE(GROUP,IF(h.e1_title5 = (TYPEOF(h.e1_title5))'',0,100));
    maxlength_e1_title5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_title5)));
    avelength_e1_title5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_title5)),h.e1_title5<>(typeof(h.e1_title5))'');
    populated_e1_fname5_cnt := COUNT(GROUP,h.e1_fname5 <> (TYPEOF(h.e1_fname5))'');
    populated_e1_fname5_pcnt := AVE(GROUP,IF(h.e1_fname5 = (TYPEOF(h.e1_fname5))'',0,100));
    maxlength_e1_fname5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_fname5)));
    avelength_e1_fname5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_fname5)),h.e1_fname5<>(typeof(h.e1_fname5))'');
    populated_e1_mname5_cnt := COUNT(GROUP,h.e1_mname5 <> (TYPEOF(h.e1_mname5))'');
    populated_e1_mname5_pcnt := AVE(GROUP,IF(h.e1_mname5 = (TYPEOF(h.e1_mname5))'',0,100));
    maxlength_e1_mname5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_mname5)));
    avelength_e1_mname5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_mname5)),h.e1_mname5<>(typeof(h.e1_mname5))'');
    populated_e1_lname5_cnt := COUNT(GROUP,h.e1_lname5 <> (TYPEOF(h.e1_lname5))'');
    populated_e1_lname5_pcnt := AVE(GROUP,IF(h.e1_lname5 = (TYPEOF(h.e1_lname5))'',0,100));
    maxlength_e1_lname5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_lname5)));
    avelength_e1_lname5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_lname5)),h.e1_lname5<>(typeof(h.e1_lname5))'');
    populated_e1_suffix5_cnt := COUNT(GROUP,h.e1_suffix5 <> (TYPEOF(h.e1_suffix5))'');
    populated_e1_suffix5_pcnt := AVE(GROUP,IF(h.e1_suffix5 = (TYPEOF(h.e1_suffix5))'',0,100));
    maxlength_e1_suffix5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_suffix5)));
    avelength_e1_suffix5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_suffix5)),h.e1_suffix5<>(typeof(h.e1_suffix5))'');
    populated_e1_pname5_score_cnt := COUNT(GROUP,h.e1_pname5_score <> (TYPEOF(h.e1_pname5_score))'');
    populated_e1_pname5_score_pcnt := AVE(GROUP,IF(h.e1_pname5_score = (TYPEOF(h.e1_pname5_score))'',0,100));
    maxlength_e1_pname5_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_pname5_score)));
    avelength_e1_pname5_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_pname5_score)),h.e1_pname5_score<>(typeof(h.e1_pname5_score))'');
    populated_e1_cname5_cnt := COUNT(GROUP,h.e1_cname5 <> (TYPEOF(h.e1_cname5))'');
    populated_e1_cname5_pcnt := AVE(GROUP,IF(h.e1_cname5 = (TYPEOF(h.e1_cname5))'',0,100));
    maxlength_e1_cname5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_cname5)));
    avelength_e1_cname5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e1_cname5)),h.e1_cname5<>(typeof(h.e1_cname5))'');
    populated_e2_title1_cnt := COUNT(GROUP,h.e2_title1 <> (TYPEOF(h.e2_title1))'');
    populated_e2_title1_pcnt := AVE(GROUP,IF(h.e2_title1 = (TYPEOF(h.e2_title1))'',0,100));
    maxlength_e2_title1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_title1)));
    avelength_e2_title1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_title1)),h.e2_title1<>(typeof(h.e2_title1))'');
    populated_e2_fname1_cnt := COUNT(GROUP,h.e2_fname1 <> (TYPEOF(h.e2_fname1))'');
    populated_e2_fname1_pcnt := AVE(GROUP,IF(h.e2_fname1 = (TYPEOF(h.e2_fname1))'',0,100));
    maxlength_e2_fname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_fname1)));
    avelength_e2_fname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_fname1)),h.e2_fname1<>(typeof(h.e2_fname1))'');
    populated_e2_mname1_cnt := COUNT(GROUP,h.e2_mname1 <> (TYPEOF(h.e2_mname1))'');
    populated_e2_mname1_pcnt := AVE(GROUP,IF(h.e2_mname1 = (TYPEOF(h.e2_mname1))'',0,100));
    maxlength_e2_mname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_mname1)));
    avelength_e2_mname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_mname1)),h.e2_mname1<>(typeof(h.e2_mname1))'');
    populated_e2_lname1_cnt := COUNT(GROUP,h.e2_lname1 <> (TYPEOF(h.e2_lname1))'');
    populated_e2_lname1_pcnt := AVE(GROUP,IF(h.e2_lname1 = (TYPEOF(h.e2_lname1))'',0,100));
    maxlength_e2_lname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_lname1)));
    avelength_e2_lname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_lname1)),h.e2_lname1<>(typeof(h.e2_lname1))'');
    populated_e2_suffix1_cnt := COUNT(GROUP,h.e2_suffix1 <> (TYPEOF(h.e2_suffix1))'');
    populated_e2_suffix1_pcnt := AVE(GROUP,IF(h.e2_suffix1 = (TYPEOF(h.e2_suffix1))'',0,100));
    maxlength_e2_suffix1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_suffix1)));
    avelength_e2_suffix1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_suffix1)),h.e2_suffix1<>(typeof(h.e2_suffix1))'');
    populated_e2_pname1_score_cnt := COUNT(GROUP,h.e2_pname1_score <> (TYPEOF(h.e2_pname1_score))'');
    populated_e2_pname1_score_pcnt := AVE(GROUP,IF(h.e2_pname1_score = (TYPEOF(h.e2_pname1_score))'',0,100));
    maxlength_e2_pname1_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_pname1_score)));
    avelength_e2_pname1_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_pname1_score)),h.e2_pname1_score<>(typeof(h.e2_pname1_score))'');
    populated_e2_cname1_cnt := COUNT(GROUP,h.e2_cname1 <> (TYPEOF(h.e2_cname1))'');
    populated_e2_cname1_pcnt := AVE(GROUP,IF(h.e2_cname1 = (TYPEOF(h.e2_cname1))'',0,100));
    maxlength_e2_cname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_cname1)));
    avelength_e2_cname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_cname1)),h.e2_cname1<>(typeof(h.e2_cname1))'');
    populated_e2_title2_cnt := COUNT(GROUP,h.e2_title2 <> (TYPEOF(h.e2_title2))'');
    populated_e2_title2_pcnt := AVE(GROUP,IF(h.e2_title2 = (TYPEOF(h.e2_title2))'',0,100));
    maxlength_e2_title2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_title2)));
    avelength_e2_title2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_title2)),h.e2_title2<>(typeof(h.e2_title2))'');
    populated_e2_fname2_cnt := COUNT(GROUP,h.e2_fname2 <> (TYPEOF(h.e2_fname2))'');
    populated_e2_fname2_pcnt := AVE(GROUP,IF(h.e2_fname2 = (TYPEOF(h.e2_fname2))'',0,100));
    maxlength_e2_fname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_fname2)));
    avelength_e2_fname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_fname2)),h.e2_fname2<>(typeof(h.e2_fname2))'');
    populated_e2_mname2_cnt := COUNT(GROUP,h.e2_mname2 <> (TYPEOF(h.e2_mname2))'');
    populated_e2_mname2_pcnt := AVE(GROUP,IF(h.e2_mname2 = (TYPEOF(h.e2_mname2))'',0,100));
    maxlength_e2_mname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_mname2)));
    avelength_e2_mname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_mname2)),h.e2_mname2<>(typeof(h.e2_mname2))'');
    populated_e2_lname2_cnt := COUNT(GROUP,h.e2_lname2 <> (TYPEOF(h.e2_lname2))'');
    populated_e2_lname2_pcnt := AVE(GROUP,IF(h.e2_lname2 = (TYPEOF(h.e2_lname2))'',0,100));
    maxlength_e2_lname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_lname2)));
    avelength_e2_lname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_lname2)),h.e2_lname2<>(typeof(h.e2_lname2))'');
    populated_e2_suffix2_cnt := COUNT(GROUP,h.e2_suffix2 <> (TYPEOF(h.e2_suffix2))'');
    populated_e2_suffix2_pcnt := AVE(GROUP,IF(h.e2_suffix2 = (TYPEOF(h.e2_suffix2))'',0,100));
    maxlength_e2_suffix2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_suffix2)));
    avelength_e2_suffix2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_suffix2)),h.e2_suffix2<>(typeof(h.e2_suffix2))'');
    populated_e2_pname2_score_cnt := COUNT(GROUP,h.e2_pname2_score <> (TYPEOF(h.e2_pname2_score))'');
    populated_e2_pname2_score_pcnt := AVE(GROUP,IF(h.e2_pname2_score = (TYPEOF(h.e2_pname2_score))'',0,100));
    maxlength_e2_pname2_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_pname2_score)));
    avelength_e2_pname2_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_pname2_score)),h.e2_pname2_score<>(typeof(h.e2_pname2_score))'');
    populated_e2_cname2_cnt := COUNT(GROUP,h.e2_cname2 <> (TYPEOF(h.e2_cname2))'');
    populated_e2_cname2_pcnt := AVE(GROUP,IF(h.e2_cname2 = (TYPEOF(h.e2_cname2))'',0,100));
    maxlength_e2_cname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_cname2)));
    avelength_e2_cname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_cname2)),h.e2_cname2<>(typeof(h.e2_cname2))'');
    populated_e2_title3_cnt := COUNT(GROUP,h.e2_title3 <> (TYPEOF(h.e2_title3))'');
    populated_e2_title3_pcnt := AVE(GROUP,IF(h.e2_title3 = (TYPEOF(h.e2_title3))'',0,100));
    maxlength_e2_title3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_title3)));
    avelength_e2_title3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_title3)),h.e2_title3<>(typeof(h.e2_title3))'');
    populated_e2_fname3_cnt := COUNT(GROUP,h.e2_fname3 <> (TYPEOF(h.e2_fname3))'');
    populated_e2_fname3_pcnt := AVE(GROUP,IF(h.e2_fname3 = (TYPEOF(h.e2_fname3))'',0,100));
    maxlength_e2_fname3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_fname3)));
    avelength_e2_fname3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_fname3)),h.e2_fname3<>(typeof(h.e2_fname3))'');
    populated_e2_mname3_cnt := COUNT(GROUP,h.e2_mname3 <> (TYPEOF(h.e2_mname3))'');
    populated_e2_mname3_pcnt := AVE(GROUP,IF(h.e2_mname3 = (TYPEOF(h.e2_mname3))'',0,100));
    maxlength_e2_mname3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_mname3)));
    avelength_e2_mname3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_mname3)),h.e2_mname3<>(typeof(h.e2_mname3))'');
    populated_e2_lname3_cnt := COUNT(GROUP,h.e2_lname3 <> (TYPEOF(h.e2_lname3))'');
    populated_e2_lname3_pcnt := AVE(GROUP,IF(h.e2_lname3 = (TYPEOF(h.e2_lname3))'',0,100));
    maxlength_e2_lname3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_lname3)));
    avelength_e2_lname3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_lname3)),h.e2_lname3<>(typeof(h.e2_lname3))'');
    populated_e2_suffix3_cnt := COUNT(GROUP,h.e2_suffix3 <> (TYPEOF(h.e2_suffix3))'');
    populated_e2_suffix3_pcnt := AVE(GROUP,IF(h.e2_suffix3 = (TYPEOF(h.e2_suffix3))'',0,100));
    maxlength_e2_suffix3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_suffix3)));
    avelength_e2_suffix3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_suffix3)),h.e2_suffix3<>(typeof(h.e2_suffix3))'');
    populated_e2_pname3_score_cnt := COUNT(GROUP,h.e2_pname3_score <> (TYPEOF(h.e2_pname3_score))'');
    populated_e2_pname3_score_pcnt := AVE(GROUP,IF(h.e2_pname3_score = (TYPEOF(h.e2_pname3_score))'',0,100));
    maxlength_e2_pname3_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_pname3_score)));
    avelength_e2_pname3_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_pname3_score)),h.e2_pname3_score<>(typeof(h.e2_pname3_score))'');
    populated_e2_cname3_cnt := COUNT(GROUP,h.e2_cname3 <> (TYPEOF(h.e2_cname3))'');
    populated_e2_cname3_pcnt := AVE(GROUP,IF(h.e2_cname3 = (TYPEOF(h.e2_cname3))'',0,100));
    maxlength_e2_cname3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_cname3)));
    avelength_e2_cname3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_cname3)),h.e2_cname3<>(typeof(h.e2_cname3))'');
    populated_e2_title4_cnt := COUNT(GROUP,h.e2_title4 <> (TYPEOF(h.e2_title4))'');
    populated_e2_title4_pcnt := AVE(GROUP,IF(h.e2_title4 = (TYPEOF(h.e2_title4))'',0,100));
    maxlength_e2_title4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_title4)));
    avelength_e2_title4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_title4)),h.e2_title4<>(typeof(h.e2_title4))'');
    populated_e2_fname4_cnt := COUNT(GROUP,h.e2_fname4 <> (TYPEOF(h.e2_fname4))'');
    populated_e2_fname4_pcnt := AVE(GROUP,IF(h.e2_fname4 = (TYPEOF(h.e2_fname4))'',0,100));
    maxlength_e2_fname4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_fname4)));
    avelength_e2_fname4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_fname4)),h.e2_fname4<>(typeof(h.e2_fname4))'');
    populated_e2_mname4_cnt := COUNT(GROUP,h.e2_mname4 <> (TYPEOF(h.e2_mname4))'');
    populated_e2_mname4_pcnt := AVE(GROUP,IF(h.e2_mname4 = (TYPEOF(h.e2_mname4))'',0,100));
    maxlength_e2_mname4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_mname4)));
    avelength_e2_mname4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_mname4)),h.e2_mname4<>(typeof(h.e2_mname4))'');
    populated_e2_lname4_cnt := COUNT(GROUP,h.e2_lname4 <> (TYPEOF(h.e2_lname4))'');
    populated_e2_lname4_pcnt := AVE(GROUP,IF(h.e2_lname4 = (TYPEOF(h.e2_lname4))'',0,100));
    maxlength_e2_lname4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_lname4)));
    avelength_e2_lname4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_lname4)),h.e2_lname4<>(typeof(h.e2_lname4))'');
    populated_e2_suffix4_cnt := COUNT(GROUP,h.e2_suffix4 <> (TYPEOF(h.e2_suffix4))'');
    populated_e2_suffix4_pcnt := AVE(GROUP,IF(h.e2_suffix4 = (TYPEOF(h.e2_suffix4))'',0,100));
    maxlength_e2_suffix4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_suffix4)));
    avelength_e2_suffix4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_suffix4)),h.e2_suffix4<>(typeof(h.e2_suffix4))'');
    populated_e2_pname4_score_cnt := COUNT(GROUP,h.e2_pname4_score <> (TYPEOF(h.e2_pname4_score))'');
    populated_e2_pname4_score_pcnt := AVE(GROUP,IF(h.e2_pname4_score = (TYPEOF(h.e2_pname4_score))'',0,100));
    maxlength_e2_pname4_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_pname4_score)));
    avelength_e2_pname4_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_pname4_score)),h.e2_pname4_score<>(typeof(h.e2_pname4_score))'');
    populated_e2_cname4_cnt := COUNT(GROUP,h.e2_cname4 <> (TYPEOF(h.e2_cname4))'');
    populated_e2_cname4_pcnt := AVE(GROUP,IF(h.e2_cname4 = (TYPEOF(h.e2_cname4))'',0,100));
    maxlength_e2_cname4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_cname4)));
    avelength_e2_cname4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_cname4)),h.e2_cname4<>(typeof(h.e2_cname4))'');
    populated_e2_title5_cnt := COUNT(GROUP,h.e2_title5 <> (TYPEOF(h.e2_title5))'');
    populated_e2_title5_pcnt := AVE(GROUP,IF(h.e2_title5 = (TYPEOF(h.e2_title5))'',0,100));
    maxlength_e2_title5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_title5)));
    avelength_e2_title5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_title5)),h.e2_title5<>(typeof(h.e2_title5))'');
    populated_e2_fname5_cnt := COUNT(GROUP,h.e2_fname5 <> (TYPEOF(h.e2_fname5))'');
    populated_e2_fname5_pcnt := AVE(GROUP,IF(h.e2_fname5 = (TYPEOF(h.e2_fname5))'',0,100));
    maxlength_e2_fname5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_fname5)));
    avelength_e2_fname5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_fname5)),h.e2_fname5<>(typeof(h.e2_fname5))'');
    populated_e2_mname5_cnt := COUNT(GROUP,h.e2_mname5 <> (TYPEOF(h.e2_mname5))'');
    populated_e2_mname5_pcnt := AVE(GROUP,IF(h.e2_mname5 = (TYPEOF(h.e2_mname5))'',0,100));
    maxlength_e2_mname5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_mname5)));
    avelength_e2_mname5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_mname5)),h.e2_mname5<>(typeof(h.e2_mname5))'');
    populated_e2_lname5_cnt := COUNT(GROUP,h.e2_lname5 <> (TYPEOF(h.e2_lname5))'');
    populated_e2_lname5_pcnt := AVE(GROUP,IF(h.e2_lname5 = (TYPEOF(h.e2_lname5))'',0,100));
    maxlength_e2_lname5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_lname5)));
    avelength_e2_lname5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_lname5)),h.e2_lname5<>(typeof(h.e2_lname5))'');
    populated_e2_suffix5_cnt := COUNT(GROUP,h.e2_suffix5 <> (TYPEOF(h.e2_suffix5))'');
    populated_e2_suffix5_pcnt := AVE(GROUP,IF(h.e2_suffix5 = (TYPEOF(h.e2_suffix5))'',0,100));
    maxlength_e2_suffix5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_suffix5)));
    avelength_e2_suffix5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_suffix5)),h.e2_suffix5<>(typeof(h.e2_suffix5))'');
    populated_e2_pname5_score_cnt := COUNT(GROUP,h.e2_pname5_score <> (TYPEOF(h.e2_pname5_score))'');
    populated_e2_pname5_score_pcnt := AVE(GROUP,IF(h.e2_pname5_score = (TYPEOF(h.e2_pname5_score))'',0,100));
    maxlength_e2_pname5_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_pname5_score)));
    avelength_e2_pname5_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_pname5_score)),h.e2_pname5_score<>(typeof(h.e2_pname5_score))'');
    populated_e2_cname5_cnt := COUNT(GROUP,h.e2_cname5 <> (TYPEOF(h.e2_cname5))'');
    populated_e2_cname5_pcnt := AVE(GROUP,IF(h.e2_cname5 = (TYPEOF(h.e2_cname5))'',0,100));
    maxlength_e2_cname5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_cname5)));
    avelength_e2_cname5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.e2_cname5)),h.e2_cname5<>(typeof(h.e2_cname5))'');
    populated_v1_title1_cnt := COUNT(GROUP,h.v1_title1 <> (TYPEOF(h.v1_title1))'');
    populated_v1_title1_pcnt := AVE(GROUP,IF(h.v1_title1 = (TYPEOF(h.v1_title1))'',0,100));
    maxlength_v1_title1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_title1)));
    avelength_v1_title1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_title1)),h.v1_title1<>(typeof(h.v1_title1))'');
    populated_v1_fname1_cnt := COUNT(GROUP,h.v1_fname1 <> (TYPEOF(h.v1_fname1))'');
    populated_v1_fname1_pcnt := AVE(GROUP,IF(h.v1_fname1 = (TYPEOF(h.v1_fname1))'',0,100));
    maxlength_v1_fname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_fname1)));
    avelength_v1_fname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_fname1)),h.v1_fname1<>(typeof(h.v1_fname1))'');
    populated_v1_mname1_cnt := COUNT(GROUP,h.v1_mname1 <> (TYPEOF(h.v1_mname1))'');
    populated_v1_mname1_pcnt := AVE(GROUP,IF(h.v1_mname1 = (TYPEOF(h.v1_mname1))'',0,100));
    maxlength_v1_mname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_mname1)));
    avelength_v1_mname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_mname1)),h.v1_mname1<>(typeof(h.v1_mname1))'');
    populated_v1_lname1_cnt := COUNT(GROUP,h.v1_lname1 <> (TYPEOF(h.v1_lname1))'');
    populated_v1_lname1_pcnt := AVE(GROUP,IF(h.v1_lname1 = (TYPEOF(h.v1_lname1))'',0,100));
    maxlength_v1_lname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_lname1)));
    avelength_v1_lname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_lname1)),h.v1_lname1<>(typeof(h.v1_lname1))'');
    populated_v1_suffix1_cnt := COUNT(GROUP,h.v1_suffix1 <> (TYPEOF(h.v1_suffix1))'');
    populated_v1_suffix1_pcnt := AVE(GROUP,IF(h.v1_suffix1 = (TYPEOF(h.v1_suffix1))'',0,100));
    maxlength_v1_suffix1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_suffix1)));
    avelength_v1_suffix1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_suffix1)),h.v1_suffix1<>(typeof(h.v1_suffix1))'');
    populated_v1_pname1_score_cnt := COUNT(GROUP,h.v1_pname1_score <> (TYPEOF(h.v1_pname1_score))'');
    populated_v1_pname1_score_pcnt := AVE(GROUP,IF(h.v1_pname1_score = (TYPEOF(h.v1_pname1_score))'',0,100));
    maxlength_v1_pname1_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_pname1_score)));
    avelength_v1_pname1_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_pname1_score)),h.v1_pname1_score<>(typeof(h.v1_pname1_score))'');
    populated_v1_cname1_cnt := COUNT(GROUP,h.v1_cname1 <> (TYPEOF(h.v1_cname1))'');
    populated_v1_cname1_pcnt := AVE(GROUP,IF(h.v1_cname1 = (TYPEOF(h.v1_cname1))'',0,100));
    maxlength_v1_cname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_cname1)));
    avelength_v1_cname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_cname1)),h.v1_cname1<>(typeof(h.v1_cname1))'');
    populated_v1_title2_cnt := COUNT(GROUP,h.v1_title2 <> (TYPEOF(h.v1_title2))'');
    populated_v1_title2_pcnt := AVE(GROUP,IF(h.v1_title2 = (TYPEOF(h.v1_title2))'',0,100));
    maxlength_v1_title2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_title2)));
    avelength_v1_title2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_title2)),h.v1_title2<>(typeof(h.v1_title2))'');
    populated_v1_fname2_cnt := COUNT(GROUP,h.v1_fname2 <> (TYPEOF(h.v1_fname2))'');
    populated_v1_fname2_pcnt := AVE(GROUP,IF(h.v1_fname2 = (TYPEOF(h.v1_fname2))'',0,100));
    maxlength_v1_fname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_fname2)));
    avelength_v1_fname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_fname2)),h.v1_fname2<>(typeof(h.v1_fname2))'');
    populated_v1_mname2_cnt := COUNT(GROUP,h.v1_mname2 <> (TYPEOF(h.v1_mname2))'');
    populated_v1_mname2_pcnt := AVE(GROUP,IF(h.v1_mname2 = (TYPEOF(h.v1_mname2))'',0,100));
    maxlength_v1_mname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_mname2)));
    avelength_v1_mname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_mname2)),h.v1_mname2<>(typeof(h.v1_mname2))'');
    populated_v1_lname2_cnt := COUNT(GROUP,h.v1_lname2 <> (TYPEOF(h.v1_lname2))'');
    populated_v1_lname2_pcnt := AVE(GROUP,IF(h.v1_lname2 = (TYPEOF(h.v1_lname2))'',0,100));
    maxlength_v1_lname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_lname2)));
    avelength_v1_lname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_lname2)),h.v1_lname2<>(typeof(h.v1_lname2))'');
    populated_v1_suffix2_cnt := COUNT(GROUP,h.v1_suffix2 <> (TYPEOF(h.v1_suffix2))'');
    populated_v1_suffix2_pcnt := AVE(GROUP,IF(h.v1_suffix2 = (TYPEOF(h.v1_suffix2))'',0,100));
    maxlength_v1_suffix2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_suffix2)));
    avelength_v1_suffix2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_suffix2)),h.v1_suffix2<>(typeof(h.v1_suffix2))'');
    populated_v1_pname2_score_cnt := COUNT(GROUP,h.v1_pname2_score <> (TYPEOF(h.v1_pname2_score))'');
    populated_v1_pname2_score_pcnt := AVE(GROUP,IF(h.v1_pname2_score = (TYPEOF(h.v1_pname2_score))'',0,100));
    maxlength_v1_pname2_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_pname2_score)));
    avelength_v1_pname2_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_pname2_score)),h.v1_pname2_score<>(typeof(h.v1_pname2_score))'');
    populated_v1_cname2_cnt := COUNT(GROUP,h.v1_cname2 <> (TYPEOF(h.v1_cname2))'');
    populated_v1_cname2_pcnt := AVE(GROUP,IF(h.v1_cname2 = (TYPEOF(h.v1_cname2))'',0,100));
    maxlength_v1_cname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_cname2)));
    avelength_v1_cname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_cname2)),h.v1_cname2<>(typeof(h.v1_cname2))'');
    populated_v1_title3_cnt := COUNT(GROUP,h.v1_title3 <> (TYPEOF(h.v1_title3))'');
    populated_v1_title3_pcnt := AVE(GROUP,IF(h.v1_title3 = (TYPEOF(h.v1_title3))'',0,100));
    maxlength_v1_title3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_title3)));
    avelength_v1_title3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_title3)),h.v1_title3<>(typeof(h.v1_title3))'');
    populated_v1_fname3_cnt := COUNT(GROUP,h.v1_fname3 <> (TYPEOF(h.v1_fname3))'');
    populated_v1_fname3_pcnt := AVE(GROUP,IF(h.v1_fname3 = (TYPEOF(h.v1_fname3))'',0,100));
    maxlength_v1_fname3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_fname3)));
    avelength_v1_fname3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_fname3)),h.v1_fname3<>(typeof(h.v1_fname3))'');
    populated_v1_mname3_cnt := COUNT(GROUP,h.v1_mname3 <> (TYPEOF(h.v1_mname3))'');
    populated_v1_mname3_pcnt := AVE(GROUP,IF(h.v1_mname3 = (TYPEOF(h.v1_mname3))'',0,100));
    maxlength_v1_mname3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_mname3)));
    avelength_v1_mname3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_mname3)),h.v1_mname3<>(typeof(h.v1_mname3))'');
    populated_v1_lname3_cnt := COUNT(GROUP,h.v1_lname3 <> (TYPEOF(h.v1_lname3))'');
    populated_v1_lname3_pcnt := AVE(GROUP,IF(h.v1_lname3 = (TYPEOF(h.v1_lname3))'',0,100));
    maxlength_v1_lname3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_lname3)));
    avelength_v1_lname3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_lname3)),h.v1_lname3<>(typeof(h.v1_lname3))'');
    populated_v1_suffix3_cnt := COUNT(GROUP,h.v1_suffix3 <> (TYPEOF(h.v1_suffix3))'');
    populated_v1_suffix3_pcnt := AVE(GROUP,IF(h.v1_suffix3 = (TYPEOF(h.v1_suffix3))'',0,100));
    maxlength_v1_suffix3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_suffix3)));
    avelength_v1_suffix3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_suffix3)),h.v1_suffix3<>(typeof(h.v1_suffix3))'');
    populated_v1_pname3_score_cnt := COUNT(GROUP,h.v1_pname3_score <> (TYPEOF(h.v1_pname3_score))'');
    populated_v1_pname3_score_pcnt := AVE(GROUP,IF(h.v1_pname3_score = (TYPEOF(h.v1_pname3_score))'',0,100));
    maxlength_v1_pname3_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_pname3_score)));
    avelength_v1_pname3_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_pname3_score)),h.v1_pname3_score<>(typeof(h.v1_pname3_score))'');
    populated_v1_cname3_cnt := COUNT(GROUP,h.v1_cname3 <> (TYPEOF(h.v1_cname3))'');
    populated_v1_cname3_pcnt := AVE(GROUP,IF(h.v1_cname3 = (TYPEOF(h.v1_cname3))'',0,100));
    maxlength_v1_cname3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_cname3)));
    avelength_v1_cname3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_cname3)),h.v1_cname3<>(typeof(h.v1_cname3))'');
    populated_v1_title4_cnt := COUNT(GROUP,h.v1_title4 <> (TYPEOF(h.v1_title4))'');
    populated_v1_title4_pcnt := AVE(GROUP,IF(h.v1_title4 = (TYPEOF(h.v1_title4))'',0,100));
    maxlength_v1_title4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_title4)));
    avelength_v1_title4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_title4)),h.v1_title4<>(typeof(h.v1_title4))'');
    populated_v1_fname4_cnt := COUNT(GROUP,h.v1_fname4 <> (TYPEOF(h.v1_fname4))'');
    populated_v1_fname4_pcnt := AVE(GROUP,IF(h.v1_fname4 = (TYPEOF(h.v1_fname4))'',0,100));
    maxlength_v1_fname4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_fname4)));
    avelength_v1_fname4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_fname4)),h.v1_fname4<>(typeof(h.v1_fname4))'');
    populated_v1_mname4_cnt := COUNT(GROUP,h.v1_mname4 <> (TYPEOF(h.v1_mname4))'');
    populated_v1_mname4_pcnt := AVE(GROUP,IF(h.v1_mname4 = (TYPEOF(h.v1_mname4))'',0,100));
    maxlength_v1_mname4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_mname4)));
    avelength_v1_mname4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_mname4)),h.v1_mname4<>(typeof(h.v1_mname4))'');
    populated_v1_lname4_cnt := COUNT(GROUP,h.v1_lname4 <> (TYPEOF(h.v1_lname4))'');
    populated_v1_lname4_pcnt := AVE(GROUP,IF(h.v1_lname4 = (TYPEOF(h.v1_lname4))'',0,100));
    maxlength_v1_lname4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_lname4)));
    avelength_v1_lname4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_lname4)),h.v1_lname4<>(typeof(h.v1_lname4))'');
    populated_v1_suffix4_cnt := COUNT(GROUP,h.v1_suffix4 <> (TYPEOF(h.v1_suffix4))'');
    populated_v1_suffix4_pcnt := AVE(GROUP,IF(h.v1_suffix4 = (TYPEOF(h.v1_suffix4))'',0,100));
    maxlength_v1_suffix4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_suffix4)));
    avelength_v1_suffix4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_suffix4)),h.v1_suffix4<>(typeof(h.v1_suffix4))'');
    populated_v1_pname4_score_cnt := COUNT(GROUP,h.v1_pname4_score <> (TYPEOF(h.v1_pname4_score))'');
    populated_v1_pname4_score_pcnt := AVE(GROUP,IF(h.v1_pname4_score = (TYPEOF(h.v1_pname4_score))'',0,100));
    maxlength_v1_pname4_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_pname4_score)));
    avelength_v1_pname4_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_pname4_score)),h.v1_pname4_score<>(typeof(h.v1_pname4_score))'');
    populated_v1_cname4_cnt := COUNT(GROUP,h.v1_cname4 <> (TYPEOF(h.v1_cname4))'');
    populated_v1_cname4_pcnt := AVE(GROUP,IF(h.v1_cname4 = (TYPEOF(h.v1_cname4))'',0,100));
    maxlength_v1_cname4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_cname4)));
    avelength_v1_cname4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_cname4)),h.v1_cname4<>(typeof(h.v1_cname4))'');
    populated_v1_title5_cnt := COUNT(GROUP,h.v1_title5 <> (TYPEOF(h.v1_title5))'');
    populated_v1_title5_pcnt := AVE(GROUP,IF(h.v1_title5 = (TYPEOF(h.v1_title5))'',0,100));
    maxlength_v1_title5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_title5)));
    avelength_v1_title5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_title5)),h.v1_title5<>(typeof(h.v1_title5))'');
    populated_v1_fname5_cnt := COUNT(GROUP,h.v1_fname5 <> (TYPEOF(h.v1_fname5))'');
    populated_v1_fname5_pcnt := AVE(GROUP,IF(h.v1_fname5 = (TYPEOF(h.v1_fname5))'',0,100));
    maxlength_v1_fname5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_fname5)));
    avelength_v1_fname5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_fname5)),h.v1_fname5<>(typeof(h.v1_fname5))'');
    populated_v1_mname5_cnt := COUNT(GROUP,h.v1_mname5 <> (TYPEOF(h.v1_mname5))'');
    populated_v1_mname5_pcnt := AVE(GROUP,IF(h.v1_mname5 = (TYPEOF(h.v1_mname5))'',0,100));
    maxlength_v1_mname5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_mname5)));
    avelength_v1_mname5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_mname5)),h.v1_mname5<>(typeof(h.v1_mname5))'');
    populated_v1_lname5_cnt := COUNT(GROUP,h.v1_lname5 <> (TYPEOF(h.v1_lname5))'');
    populated_v1_lname5_pcnt := AVE(GROUP,IF(h.v1_lname5 = (TYPEOF(h.v1_lname5))'',0,100));
    maxlength_v1_lname5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_lname5)));
    avelength_v1_lname5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_lname5)),h.v1_lname5<>(typeof(h.v1_lname5))'');
    populated_v1_suffix5_cnt := COUNT(GROUP,h.v1_suffix5 <> (TYPEOF(h.v1_suffix5))'');
    populated_v1_suffix5_pcnt := AVE(GROUP,IF(h.v1_suffix5 = (TYPEOF(h.v1_suffix5))'',0,100));
    maxlength_v1_suffix5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_suffix5)));
    avelength_v1_suffix5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_suffix5)),h.v1_suffix5<>(typeof(h.v1_suffix5))'');
    populated_v1_pname5_score_cnt := COUNT(GROUP,h.v1_pname5_score <> (TYPEOF(h.v1_pname5_score))'');
    populated_v1_pname5_score_pcnt := AVE(GROUP,IF(h.v1_pname5_score = (TYPEOF(h.v1_pname5_score))'',0,100));
    maxlength_v1_pname5_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_pname5_score)));
    avelength_v1_pname5_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_pname5_score)),h.v1_pname5_score<>(typeof(h.v1_pname5_score))'');
    populated_v1_cname5_cnt := COUNT(GROUP,h.v1_cname5 <> (TYPEOF(h.v1_cname5))'');
    populated_v1_cname5_pcnt := AVE(GROUP,IF(h.v1_cname5 = (TYPEOF(h.v1_cname5))'',0,100));
    maxlength_v1_cname5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_cname5)));
    avelength_v1_cname5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v1_cname5)),h.v1_cname5<>(typeof(h.v1_cname5))'');
    populated_v2_title1_cnt := COUNT(GROUP,h.v2_title1 <> (TYPEOF(h.v2_title1))'');
    populated_v2_title1_pcnt := AVE(GROUP,IF(h.v2_title1 = (TYPEOF(h.v2_title1))'',0,100));
    maxlength_v2_title1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_title1)));
    avelength_v2_title1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_title1)),h.v2_title1<>(typeof(h.v2_title1))'');
    populated_v2_fname1_cnt := COUNT(GROUP,h.v2_fname1 <> (TYPEOF(h.v2_fname1))'');
    populated_v2_fname1_pcnt := AVE(GROUP,IF(h.v2_fname1 = (TYPEOF(h.v2_fname1))'',0,100));
    maxlength_v2_fname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_fname1)));
    avelength_v2_fname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_fname1)),h.v2_fname1<>(typeof(h.v2_fname1))'');
    populated_v2_mname1_cnt := COUNT(GROUP,h.v2_mname1 <> (TYPEOF(h.v2_mname1))'');
    populated_v2_mname1_pcnt := AVE(GROUP,IF(h.v2_mname1 = (TYPEOF(h.v2_mname1))'',0,100));
    maxlength_v2_mname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_mname1)));
    avelength_v2_mname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_mname1)),h.v2_mname1<>(typeof(h.v2_mname1))'');
    populated_v2_lname1_cnt := COUNT(GROUP,h.v2_lname1 <> (TYPEOF(h.v2_lname1))'');
    populated_v2_lname1_pcnt := AVE(GROUP,IF(h.v2_lname1 = (TYPEOF(h.v2_lname1))'',0,100));
    maxlength_v2_lname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_lname1)));
    avelength_v2_lname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_lname1)),h.v2_lname1<>(typeof(h.v2_lname1))'');
    populated_v2_suffix1_cnt := COUNT(GROUP,h.v2_suffix1 <> (TYPEOF(h.v2_suffix1))'');
    populated_v2_suffix1_pcnt := AVE(GROUP,IF(h.v2_suffix1 = (TYPEOF(h.v2_suffix1))'',0,100));
    maxlength_v2_suffix1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_suffix1)));
    avelength_v2_suffix1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_suffix1)),h.v2_suffix1<>(typeof(h.v2_suffix1))'');
    populated_v2_pname1_score_cnt := COUNT(GROUP,h.v2_pname1_score <> (TYPEOF(h.v2_pname1_score))'');
    populated_v2_pname1_score_pcnt := AVE(GROUP,IF(h.v2_pname1_score = (TYPEOF(h.v2_pname1_score))'',0,100));
    maxlength_v2_pname1_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_pname1_score)));
    avelength_v2_pname1_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_pname1_score)),h.v2_pname1_score<>(typeof(h.v2_pname1_score))'');
    populated_v2_cname1_cnt := COUNT(GROUP,h.v2_cname1 <> (TYPEOF(h.v2_cname1))'');
    populated_v2_cname1_pcnt := AVE(GROUP,IF(h.v2_cname1 = (TYPEOF(h.v2_cname1))'',0,100));
    maxlength_v2_cname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_cname1)));
    avelength_v2_cname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_cname1)),h.v2_cname1<>(typeof(h.v2_cname1))'');
    populated_v2_title2_cnt := COUNT(GROUP,h.v2_title2 <> (TYPEOF(h.v2_title2))'');
    populated_v2_title2_pcnt := AVE(GROUP,IF(h.v2_title2 = (TYPEOF(h.v2_title2))'',0,100));
    maxlength_v2_title2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_title2)));
    avelength_v2_title2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_title2)),h.v2_title2<>(typeof(h.v2_title2))'');
    populated_v2_fname2_cnt := COUNT(GROUP,h.v2_fname2 <> (TYPEOF(h.v2_fname2))'');
    populated_v2_fname2_pcnt := AVE(GROUP,IF(h.v2_fname2 = (TYPEOF(h.v2_fname2))'',0,100));
    maxlength_v2_fname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_fname2)));
    avelength_v2_fname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_fname2)),h.v2_fname2<>(typeof(h.v2_fname2))'');
    populated_v2_mname2_cnt := COUNT(GROUP,h.v2_mname2 <> (TYPEOF(h.v2_mname2))'');
    populated_v2_mname2_pcnt := AVE(GROUP,IF(h.v2_mname2 = (TYPEOF(h.v2_mname2))'',0,100));
    maxlength_v2_mname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_mname2)));
    avelength_v2_mname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_mname2)),h.v2_mname2<>(typeof(h.v2_mname2))'');
    populated_v2_lname2_cnt := COUNT(GROUP,h.v2_lname2 <> (TYPEOF(h.v2_lname2))'');
    populated_v2_lname2_pcnt := AVE(GROUP,IF(h.v2_lname2 = (TYPEOF(h.v2_lname2))'',0,100));
    maxlength_v2_lname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_lname2)));
    avelength_v2_lname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_lname2)),h.v2_lname2<>(typeof(h.v2_lname2))'');
    populated_v2_suffix2_cnt := COUNT(GROUP,h.v2_suffix2 <> (TYPEOF(h.v2_suffix2))'');
    populated_v2_suffix2_pcnt := AVE(GROUP,IF(h.v2_suffix2 = (TYPEOF(h.v2_suffix2))'',0,100));
    maxlength_v2_suffix2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_suffix2)));
    avelength_v2_suffix2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_suffix2)),h.v2_suffix2<>(typeof(h.v2_suffix2))'');
    populated_v2_pname2_score_cnt := COUNT(GROUP,h.v2_pname2_score <> (TYPEOF(h.v2_pname2_score))'');
    populated_v2_pname2_score_pcnt := AVE(GROUP,IF(h.v2_pname2_score = (TYPEOF(h.v2_pname2_score))'',0,100));
    maxlength_v2_pname2_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_pname2_score)));
    avelength_v2_pname2_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_pname2_score)),h.v2_pname2_score<>(typeof(h.v2_pname2_score))'');
    populated_v2_cname2_cnt := COUNT(GROUP,h.v2_cname2 <> (TYPEOF(h.v2_cname2))'');
    populated_v2_cname2_pcnt := AVE(GROUP,IF(h.v2_cname2 = (TYPEOF(h.v2_cname2))'',0,100));
    maxlength_v2_cname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_cname2)));
    avelength_v2_cname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_cname2)),h.v2_cname2<>(typeof(h.v2_cname2))'');
    populated_v2_title3_cnt := COUNT(GROUP,h.v2_title3 <> (TYPEOF(h.v2_title3))'');
    populated_v2_title3_pcnt := AVE(GROUP,IF(h.v2_title3 = (TYPEOF(h.v2_title3))'',0,100));
    maxlength_v2_title3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_title3)));
    avelength_v2_title3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_title3)),h.v2_title3<>(typeof(h.v2_title3))'');
    populated_v2_fname3_cnt := COUNT(GROUP,h.v2_fname3 <> (TYPEOF(h.v2_fname3))'');
    populated_v2_fname3_pcnt := AVE(GROUP,IF(h.v2_fname3 = (TYPEOF(h.v2_fname3))'',0,100));
    maxlength_v2_fname3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_fname3)));
    avelength_v2_fname3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_fname3)),h.v2_fname3<>(typeof(h.v2_fname3))'');
    populated_v2_mname3_cnt := COUNT(GROUP,h.v2_mname3 <> (TYPEOF(h.v2_mname3))'');
    populated_v2_mname3_pcnt := AVE(GROUP,IF(h.v2_mname3 = (TYPEOF(h.v2_mname3))'',0,100));
    maxlength_v2_mname3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_mname3)));
    avelength_v2_mname3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_mname3)),h.v2_mname3<>(typeof(h.v2_mname3))'');
    populated_v2_lname3_cnt := COUNT(GROUP,h.v2_lname3 <> (TYPEOF(h.v2_lname3))'');
    populated_v2_lname3_pcnt := AVE(GROUP,IF(h.v2_lname3 = (TYPEOF(h.v2_lname3))'',0,100));
    maxlength_v2_lname3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_lname3)));
    avelength_v2_lname3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_lname3)),h.v2_lname3<>(typeof(h.v2_lname3))'');
    populated_v2_suffix3_cnt := COUNT(GROUP,h.v2_suffix3 <> (TYPEOF(h.v2_suffix3))'');
    populated_v2_suffix3_pcnt := AVE(GROUP,IF(h.v2_suffix3 = (TYPEOF(h.v2_suffix3))'',0,100));
    maxlength_v2_suffix3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_suffix3)));
    avelength_v2_suffix3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_suffix3)),h.v2_suffix3<>(typeof(h.v2_suffix3))'');
    populated_v2_pname3_score_cnt := COUNT(GROUP,h.v2_pname3_score <> (TYPEOF(h.v2_pname3_score))'');
    populated_v2_pname3_score_pcnt := AVE(GROUP,IF(h.v2_pname3_score = (TYPEOF(h.v2_pname3_score))'',0,100));
    maxlength_v2_pname3_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_pname3_score)));
    avelength_v2_pname3_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_pname3_score)),h.v2_pname3_score<>(typeof(h.v2_pname3_score))'');
    populated_v2_cname3_cnt := COUNT(GROUP,h.v2_cname3 <> (TYPEOF(h.v2_cname3))'');
    populated_v2_cname3_pcnt := AVE(GROUP,IF(h.v2_cname3 = (TYPEOF(h.v2_cname3))'',0,100));
    maxlength_v2_cname3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_cname3)));
    avelength_v2_cname3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_cname3)),h.v2_cname3<>(typeof(h.v2_cname3))'');
    populated_v2_title4_cnt := COUNT(GROUP,h.v2_title4 <> (TYPEOF(h.v2_title4))'');
    populated_v2_title4_pcnt := AVE(GROUP,IF(h.v2_title4 = (TYPEOF(h.v2_title4))'',0,100));
    maxlength_v2_title4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_title4)));
    avelength_v2_title4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_title4)),h.v2_title4<>(typeof(h.v2_title4))'');
    populated_v2_fname4_cnt := COUNT(GROUP,h.v2_fname4 <> (TYPEOF(h.v2_fname4))'');
    populated_v2_fname4_pcnt := AVE(GROUP,IF(h.v2_fname4 = (TYPEOF(h.v2_fname4))'',0,100));
    maxlength_v2_fname4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_fname4)));
    avelength_v2_fname4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_fname4)),h.v2_fname4<>(typeof(h.v2_fname4))'');
    populated_v2_mname4_cnt := COUNT(GROUP,h.v2_mname4 <> (TYPEOF(h.v2_mname4))'');
    populated_v2_mname4_pcnt := AVE(GROUP,IF(h.v2_mname4 = (TYPEOF(h.v2_mname4))'',0,100));
    maxlength_v2_mname4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_mname4)));
    avelength_v2_mname4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_mname4)),h.v2_mname4<>(typeof(h.v2_mname4))'');
    populated_v2_lname4_cnt := COUNT(GROUP,h.v2_lname4 <> (TYPEOF(h.v2_lname4))'');
    populated_v2_lname4_pcnt := AVE(GROUP,IF(h.v2_lname4 = (TYPEOF(h.v2_lname4))'',0,100));
    maxlength_v2_lname4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_lname4)));
    avelength_v2_lname4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_lname4)),h.v2_lname4<>(typeof(h.v2_lname4))'');
    populated_v2_suffix4_cnt := COUNT(GROUP,h.v2_suffix4 <> (TYPEOF(h.v2_suffix4))'');
    populated_v2_suffix4_pcnt := AVE(GROUP,IF(h.v2_suffix4 = (TYPEOF(h.v2_suffix4))'',0,100));
    maxlength_v2_suffix4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_suffix4)));
    avelength_v2_suffix4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_suffix4)),h.v2_suffix4<>(typeof(h.v2_suffix4))'');
    populated_v2_pname4_score_cnt := COUNT(GROUP,h.v2_pname4_score <> (TYPEOF(h.v2_pname4_score))'');
    populated_v2_pname4_score_pcnt := AVE(GROUP,IF(h.v2_pname4_score = (TYPEOF(h.v2_pname4_score))'',0,100));
    maxlength_v2_pname4_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_pname4_score)));
    avelength_v2_pname4_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_pname4_score)),h.v2_pname4_score<>(typeof(h.v2_pname4_score))'');
    populated_v2_cname4_cnt := COUNT(GROUP,h.v2_cname4 <> (TYPEOF(h.v2_cname4))'');
    populated_v2_cname4_pcnt := AVE(GROUP,IF(h.v2_cname4 = (TYPEOF(h.v2_cname4))'',0,100));
    maxlength_v2_cname4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_cname4)));
    avelength_v2_cname4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_cname4)),h.v2_cname4<>(typeof(h.v2_cname4))'');
    populated_v2_title5_cnt := COUNT(GROUP,h.v2_title5 <> (TYPEOF(h.v2_title5))'');
    populated_v2_title5_pcnt := AVE(GROUP,IF(h.v2_title5 = (TYPEOF(h.v2_title5))'',0,100));
    maxlength_v2_title5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_title5)));
    avelength_v2_title5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_title5)),h.v2_title5<>(typeof(h.v2_title5))'');
    populated_v2_fname5_cnt := COUNT(GROUP,h.v2_fname5 <> (TYPEOF(h.v2_fname5))'');
    populated_v2_fname5_pcnt := AVE(GROUP,IF(h.v2_fname5 = (TYPEOF(h.v2_fname5))'',0,100));
    maxlength_v2_fname5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_fname5)));
    avelength_v2_fname5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_fname5)),h.v2_fname5<>(typeof(h.v2_fname5))'');
    populated_v2_mname5_cnt := COUNT(GROUP,h.v2_mname5 <> (TYPEOF(h.v2_mname5))'');
    populated_v2_mname5_pcnt := AVE(GROUP,IF(h.v2_mname5 = (TYPEOF(h.v2_mname5))'',0,100));
    maxlength_v2_mname5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_mname5)));
    avelength_v2_mname5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_mname5)),h.v2_mname5<>(typeof(h.v2_mname5))'');
    populated_v2_lname5_cnt := COUNT(GROUP,h.v2_lname5 <> (TYPEOF(h.v2_lname5))'');
    populated_v2_lname5_pcnt := AVE(GROUP,IF(h.v2_lname5 = (TYPEOF(h.v2_lname5))'',0,100));
    maxlength_v2_lname5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_lname5)));
    avelength_v2_lname5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_lname5)),h.v2_lname5<>(typeof(h.v2_lname5))'');
    populated_v2_suffix5_cnt := COUNT(GROUP,h.v2_suffix5 <> (TYPEOF(h.v2_suffix5))'');
    populated_v2_suffix5_pcnt := AVE(GROUP,IF(h.v2_suffix5 = (TYPEOF(h.v2_suffix5))'',0,100));
    maxlength_v2_suffix5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_suffix5)));
    avelength_v2_suffix5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_suffix5)),h.v2_suffix5<>(typeof(h.v2_suffix5))'');
    populated_v2_pname5_score_cnt := COUNT(GROUP,h.v2_pname5_score <> (TYPEOF(h.v2_pname5_score))'');
    populated_v2_pname5_score_pcnt := AVE(GROUP,IF(h.v2_pname5_score = (TYPEOF(h.v2_pname5_score))'',0,100));
    maxlength_v2_pname5_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_pname5_score)));
    avelength_v2_pname5_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_pname5_score)),h.v2_pname5_score<>(typeof(h.v2_pname5_score))'');
    populated_v2_cname5_cnt := COUNT(GROUP,h.v2_cname5 <> (TYPEOF(h.v2_cname5))'');
    populated_v2_cname5_pcnt := AVE(GROUP,IF(h.v2_cname5 = (TYPEOF(h.v2_cname5))'',0,100));
    maxlength_v2_cname5 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_cname5)));
    avelength_v2_cname5 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v2_cname5)),h.v2_cname5<>(typeof(h.v2_cname5))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_last_reported_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100 + T.Populated_state_origin_pcnt *   0.00 / 100 + T.Populated_source_file_pcnt *   0.00 / 100 + T.Populated_case_key_pcnt *   0.00 / 100 + T.Populated_parent_case_key_pcnt *   0.00 / 100 + T.Populated_court_code_pcnt *   0.00 / 100 + T.Populated_court_pcnt *   0.00 / 100 + T.Populated_case_number_pcnt *   0.00 / 100 + T.Populated_case_type_code_pcnt *   0.00 / 100 + T.Populated_case_type_pcnt *   0.00 / 100 + T.Populated_case_title_pcnt *   0.00 / 100 + T.Populated_ruled_for_against_code_pcnt *   0.00 / 100 + T.Populated_ruled_for_against_pcnt *   0.00 / 100 + T.Populated_entity_1_pcnt *   0.00 / 100 + T.Populated_entity_nm_format_1_pcnt *   0.00 / 100 + T.Populated_entity_type_code_1_orig_pcnt *   0.00 / 100 + T.Populated_entity_type_description_1_orig_pcnt *   0.00 / 100 + T.Populated_entity_type_code_1_master_pcnt *   0.00 / 100 + T.Populated_entity_seq_num_1_pcnt *   0.00 / 100 + T.Populated_atty_seq_num_1_pcnt *   0.00 / 100 + T.Populated_entity_1_address_1_pcnt *   0.00 / 100 + T.Populated_entity_1_address_2_pcnt *   0.00 / 100 + T.Populated_entity_1_address_3_pcnt *   0.00 / 100 + T.Populated_entity_1_address_4_pcnt *   0.00 / 100 + T.Populated_entity_1_dob_pcnt *   0.00 / 100 + T.Populated_primary_entity_2_pcnt *   0.00 / 100 + T.Populated_entity_nm_format_2_pcnt *   0.00 / 100 + T.Populated_entity_type_code_2_orig_pcnt *   0.00 / 100 + T.Populated_entity_type_description_2_orig_pcnt *   0.00 / 100 + T.Populated_entity_type_code_2_master_pcnt *   0.00 / 100 + T.Populated_entity_seq_num_2_pcnt *   0.00 / 100 + T.Populated_atty_seq_num_2_pcnt *   0.00 / 100 + T.Populated_entity_2_address_1_pcnt *   0.00 / 100 + T.Populated_entity_2_address_2_pcnt *   0.00 / 100 + T.Populated_entity_2_address_3_pcnt *   0.00 / 100 + T.Populated_entity_2_address_4_pcnt *   0.00 / 100 + T.Populated_entity_2_dob_pcnt *   0.00 / 100 + T.Populated_prim_range1_pcnt *   0.00 / 100 + T.Populated_predir1_pcnt *   0.00 / 100 + T.Populated_prim_name1_pcnt *   0.00 / 100 + T.Populated_addr_suffix1_pcnt *   0.00 / 100 + T.Populated_postdir1_pcnt *   0.00 / 100 + T.Populated_unit_desig1_pcnt *   0.00 / 100 + T.Populated_sec_range1_pcnt *   0.00 / 100 + T.Populated_p_city_name1_pcnt *   0.00 / 100 + T.Populated_v_city_name1_pcnt *   0.00 / 100 + T.Populated_st1_pcnt *   0.00 / 100 + T.Populated_zip1_pcnt *   0.00 / 100 + T.Populated_zip41_pcnt *   0.00 / 100 + T.Populated_cart1_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz1_pcnt *   0.00 / 100 + T.Populated_lot1_pcnt *   0.00 / 100 + T.Populated_lot_order1_pcnt *   0.00 / 100 + T.Populated_dpbc1_pcnt *   0.00 / 100 + T.Populated_chk_digit1_pcnt *   0.00 / 100 + T.Populated_rec_type1_pcnt *   0.00 / 100 + T.Populated_ace_fips_st1_pcnt *   0.00 / 100 + T.Populated_ace_fips_county1_pcnt *   0.00 / 100 + T.Populated_geo_lat1_pcnt *   0.00 / 100 + T.Populated_geo_long1_pcnt *   0.00 / 100 + T.Populated_msa1_pcnt *   0.00 / 100 + T.Populated_geo_blk1_pcnt *   0.00 / 100 + T.Populated_geo_match1_pcnt *   0.00 / 100 + T.Populated_err_stat1_pcnt *   0.00 / 100 + T.Populated_prim_range2_pcnt *   0.00 / 100 + T.Populated_predir2_pcnt *   0.00 / 100 + T.Populated_prim_name2_pcnt *   0.00 / 100 + T.Populated_addr_suffix2_pcnt *   0.00 / 100 + T.Populated_postdir2_pcnt *   0.00 / 100 + T.Populated_unit_desig2_pcnt *   0.00 / 100 + T.Populated_sec_range2_pcnt *   0.00 / 100 + T.Populated_p_city_name2_pcnt *   0.00 / 100 + T.Populated_v_city_name2_pcnt *   0.00 / 100 + T.Populated_st2_pcnt *   0.00 / 100 + T.Populated_zip2_pcnt *   0.00 / 100 + T.Populated_zip42_pcnt *   0.00 / 100 + T.Populated_cart2_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz2_pcnt *   0.00 / 100 + T.Populated_lot2_pcnt *   0.00 / 100 + T.Populated_lot_order2_pcnt *   0.00 / 100 + T.Populated_dpbc2_pcnt *   0.00 / 100 + T.Populated_chk_digit2_pcnt *   0.00 / 100 + T.Populated_rec_type2_pcnt *   0.00 / 100 + T.Populated_ace_fips_st2_pcnt *   0.00 / 100 + T.Populated_ace_fips_county2_pcnt *   0.00 / 100 + T.Populated_geo_lat2_pcnt *   0.00 / 100 + T.Populated_geo_long2_pcnt *   0.00 / 100 + T.Populated_msa2_pcnt *   0.00 / 100 + T.Populated_geo_blk2_pcnt *   0.00 / 100 + T.Populated_geo_match2_pcnt *   0.00 / 100 + T.Populated_err_stat2_pcnt *   0.00 / 100 + T.Populated_e1_title1_pcnt *   0.00 / 100 + T.Populated_e1_fname1_pcnt *   0.00 / 100 + T.Populated_e1_mname1_pcnt *   0.00 / 100 + T.Populated_e1_lname1_pcnt *   0.00 / 100 + T.Populated_e1_suffix1_pcnt *   0.00 / 100 + T.Populated_e1_pname1_score_pcnt *   0.00 / 100 + T.Populated_e1_cname1_pcnt *   0.00 / 100 + T.Populated_e1_title2_pcnt *   0.00 / 100 + T.Populated_e1_fname2_pcnt *   0.00 / 100 + T.Populated_e1_mname2_pcnt *   0.00 / 100 + T.Populated_e1_lname2_pcnt *   0.00 / 100 + T.Populated_e1_suffix2_pcnt *   0.00 / 100 + T.Populated_e1_pname2_score_pcnt *   0.00 / 100 + T.Populated_e1_cname2_pcnt *   0.00 / 100 + T.Populated_e1_title3_pcnt *   0.00 / 100 + T.Populated_e1_fname3_pcnt *   0.00 / 100 + T.Populated_e1_mname3_pcnt *   0.00 / 100 + T.Populated_e1_lname3_pcnt *   0.00 / 100 + T.Populated_e1_suffix3_pcnt *   0.00 / 100 + T.Populated_e1_pname3_score_pcnt *   0.00 / 100 + T.Populated_e1_cname3_pcnt *   0.00 / 100 + T.Populated_e1_title4_pcnt *   0.00 / 100 + T.Populated_e1_fname4_pcnt *   0.00 / 100 + T.Populated_e1_mname4_pcnt *   0.00 / 100 + T.Populated_e1_lname4_pcnt *   0.00 / 100 + T.Populated_e1_suffix4_pcnt *   0.00 / 100 + T.Populated_e1_pname4_score_pcnt *   0.00 / 100 + T.Populated_e1_cname4_pcnt *   0.00 / 100 + T.Populated_e1_title5_pcnt *   0.00 / 100 + T.Populated_e1_fname5_pcnt *   0.00 / 100 + T.Populated_e1_mname5_pcnt *   0.00 / 100 + T.Populated_e1_lname5_pcnt *   0.00 / 100 + T.Populated_e1_suffix5_pcnt *   0.00 / 100 + T.Populated_e1_pname5_score_pcnt *   0.00 / 100 + T.Populated_e1_cname5_pcnt *   0.00 / 100 + T.Populated_e2_title1_pcnt *   0.00 / 100 + T.Populated_e2_fname1_pcnt *   0.00 / 100 + T.Populated_e2_mname1_pcnt *   0.00 / 100 + T.Populated_e2_lname1_pcnt *   0.00 / 100 + T.Populated_e2_suffix1_pcnt *   0.00 / 100 + T.Populated_e2_pname1_score_pcnt *   0.00 / 100 + T.Populated_e2_cname1_pcnt *   0.00 / 100 + T.Populated_e2_title2_pcnt *   0.00 / 100 + T.Populated_e2_fname2_pcnt *   0.00 / 100 + T.Populated_e2_mname2_pcnt *   0.00 / 100 + T.Populated_e2_lname2_pcnt *   0.00 / 100 + T.Populated_e2_suffix2_pcnt *   0.00 / 100 + T.Populated_e2_pname2_score_pcnt *   0.00 / 100 + T.Populated_e2_cname2_pcnt *   0.00 / 100 + T.Populated_e2_title3_pcnt *   0.00 / 100 + T.Populated_e2_fname3_pcnt *   0.00 / 100 + T.Populated_e2_mname3_pcnt *   0.00 / 100 + T.Populated_e2_lname3_pcnt *   0.00 / 100 + T.Populated_e2_suffix3_pcnt *   0.00 / 100 + T.Populated_e2_pname3_score_pcnt *   0.00 / 100 + T.Populated_e2_cname3_pcnt *   0.00 / 100 + T.Populated_e2_title4_pcnt *   0.00 / 100 + T.Populated_e2_fname4_pcnt *   0.00 / 100 + T.Populated_e2_mname4_pcnt *   0.00 / 100 + T.Populated_e2_lname4_pcnt *   0.00 / 100 + T.Populated_e2_suffix4_pcnt *   0.00 / 100 + T.Populated_e2_pname4_score_pcnt *   0.00 / 100 + T.Populated_e2_cname4_pcnt *   0.00 / 100 + T.Populated_e2_title5_pcnt *   0.00 / 100 + T.Populated_e2_fname5_pcnt *   0.00 / 100 + T.Populated_e2_mname5_pcnt *   0.00 / 100 + T.Populated_e2_lname5_pcnt *   0.00 / 100 + T.Populated_e2_suffix5_pcnt *   0.00 / 100 + T.Populated_e2_pname5_score_pcnt *   0.00 / 100 + T.Populated_e2_cname5_pcnt *   0.00 / 100 + T.Populated_v1_title1_pcnt *   0.00 / 100 + T.Populated_v1_fname1_pcnt *   0.00 / 100 + T.Populated_v1_mname1_pcnt *   0.00 / 100 + T.Populated_v1_lname1_pcnt *   0.00 / 100 + T.Populated_v1_suffix1_pcnt *   0.00 / 100 + T.Populated_v1_pname1_score_pcnt *   0.00 / 100 + T.Populated_v1_cname1_pcnt *   0.00 / 100 + T.Populated_v1_title2_pcnt *   0.00 / 100 + T.Populated_v1_fname2_pcnt *   0.00 / 100 + T.Populated_v1_mname2_pcnt *   0.00 / 100 + T.Populated_v1_lname2_pcnt *   0.00 / 100 + T.Populated_v1_suffix2_pcnt *   0.00 / 100 + T.Populated_v1_pname2_score_pcnt *   0.00 / 100 + T.Populated_v1_cname2_pcnt *   0.00 / 100 + T.Populated_v1_title3_pcnt *   0.00 / 100 + T.Populated_v1_fname3_pcnt *   0.00 / 100 + T.Populated_v1_mname3_pcnt *   0.00 / 100 + T.Populated_v1_lname3_pcnt *   0.00 / 100 + T.Populated_v1_suffix3_pcnt *   0.00 / 100 + T.Populated_v1_pname3_score_pcnt *   0.00 / 100 + T.Populated_v1_cname3_pcnt *   0.00 / 100 + T.Populated_v1_title4_pcnt *   0.00 / 100 + T.Populated_v1_fname4_pcnt *   0.00 / 100 + T.Populated_v1_mname4_pcnt *   0.00 / 100 + T.Populated_v1_lname4_pcnt *   0.00 / 100 + T.Populated_v1_suffix4_pcnt *   0.00 / 100 + T.Populated_v1_pname4_score_pcnt *   0.00 / 100 + T.Populated_v1_cname4_pcnt *   0.00 / 100 + T.Populated_v1_title5_pcnt *   0.00 / 100 + T.Populated_v1_fname5_pcnt *   0.00 / 100 + T.Populated_v1_mname5_pcnt *   0.00 / 100 + T.Populated_v1_lname5_pcnt *   0.00 / 100 + T.Populated_v1_suffix5_pcnt *   0.00 / 100 + T.Populated_v1_pname5_score_pcnt *   0.00 / 100 + T.Populated_v1_cname5_pcnt *   0.00 / 100 + T.Populated_v2_title1_pcnt *   0.00 / 100 + T.Populated_v2_fname1_pcnt *   0.00 / 100 + T.Populated_v2_mname1_pcnt *   0.00 / 100 + T.Populated_v2_lname1_pcnt *   0.00 / 100 + T.Populated_v2_suffix1_pcnt *   0.00 / 100 + T.Populated_v2_pname1_score_pcnt *   0.00 / 100 + T.Populated_v2_cname1_pcnt *   0.00 / 100 + T.Populated_v2_title2_pcnt *   0.00 / 100 + T.Populated_v2_fname2_pcnt *   0.00 / 100 + T.Populated_v2_mname2_pcnt *   0.00 / 100 + T.Populated_v2_lname2_pcnt *   0.00 / 100 + T.Populated_v2_suffix2_pcnt *   0.00 / 100 + T.Populated_v2_pname2_score_pcnt *   0.00 / 100 + T.Populated_v2_cname2_pcnt *   0.00 / 100 + T.Populated_v2_title3_pcnt *   0.00 / 100 + T.Populated_v2_fname3_pcnt *   0.00 / 100 + T.Populated_v2_mname3_pcnt *   0.00 / 100 + T.Populated_v2_lname3_pcnt *   0.00 / 100 + T.Populated_v2_suffix3_pcnt *   0.00 / 100 + T.Populated_v2_pname3_score_pcnt *   0.00 / 100 + T.Populated_v2_cname3_pcnt *   0.00 / 100 + T.Populated_v2_title4_pcnt *   0.00 / 100 + T.Populated_v2_fname4_pcnt *   0.00 / 100 + T.Populated_v2_mname4_pcnt *   0.00 / 100 + T.Populated_v2_lname4_pcnt *   0.00 / 100 + T.Populated_v2_suffix4_pcnt *   0.00 / 100 + T.Populated_v2_pname4_score_pcnt *   0.00 / 100 + T.Populated_v2_cname4_pcnt *   0.00 / 100 + T.Populated_v2_title5_pcnt *   0.00 / 100 + T.Populated_v2_fname5_pcnt *   0.00 / 100 + T.Populated_v2_mname5_pcnt *   0.00 / 100 + T.Populated_v2_lname5_pcnt *   0.00 / 100 + T.Populated_v2_suffix5_pcnt *   0.00 / 100 + T.Populated_v2_pname5_score_pcnt *   0.00 / 100 + T.Populated_v2_cname5_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'dt_first_reported','dt_last_reported','process_date','vendor','state_origin','source_file','case_key','parent_case_key','court_code','court','case_number','case_type_code','case_type','case_title','ruled_for_against_code','ruled_for_against','entity_1','entity_nm_format_1','entity_type_code_1_orig','entity_type_description_1_orig','entity_type_code_1_master','entity_seq_num_1','atty_seq_num_1','entity_1_address_1','entity_1_address_2','entity_1_address_3','entity_1_address_4','entity_1_dob','primary_entity_2','entity_nm_format_2','entity_type_code_2_orig','entity_type_description_2_orig','entity_type_code_2_master','entity_seq_num_2','atty_seq_num_2','entity_2_address_1','entity_2_address_2','entity_2_address_3','entity_2_address_4','entity_2_dob','prim_range1','predir1','prim_name1','addr_suffix1','postdir1','unit_desig1','sec_range1','p_city_name1','v_city_name1','st1','zip1','zip41','cart1','cr_sort_sz1','lot1','lot_order1','dpbc1','chk_digit1','rec_type1','ace_fips_st1','ace_fips_county1','geo_lat1','geo_long1','msa1','geo_blk1','geo_match1','err_stat1','prim_range2','predir2','prim_name2','addr_suffix2','postdir2','unit_desig2','sec_range2','p_city_name2','v_city_name2','st2','zip2','zip42','cart2','cr_sort_sz2','lot2','lot_order2','dpbc2','chk_digit2','rec_type2','ace_fips_st2','ace_fips_county2','geo_lat2','geo_long2','msa2','geo_blk2','geo_match2','err_stat2','e1_title1','e1_fname1','e1_mname1','e1_lname1','e1_suffix1','e1_pname1_score','e1_cname1','e1_title2','e1_fname2','e1_mname2','e1_lname2','e1_suffix2','e1_pname2_score','e1_cname2','e1_title3','e1_fname3','e1_mname3','e1_lname3','e1_suffix3','e1_pname3_score','e1_cname3','e1_title4','e1_fname4','e1_mname4','e1_lname4','e1_suffix4','e1_pname4_score','e1_cname4','e1_title5','e1_fname5','e1_mname5','e1_lname5','e1_suffix5','e1_pname5_score','e1_cname5','e2_title1','e2_fname1','e2_mname1','e2_lname1','e2_suffix1','e2_pname1_score','e2_cname1','e2_title2','e2_fname2','e2_mname2','e2_lname2','e2_suffix2','e2_pname2_score','e2_cname2','e2_title3','e2_fname3','e2_mname3','e2_lname3','e2_suffix3','e2_pname3_score','e2_cname3','e2_title4','e2_fname4','e2_mname4','e2_lname4','e2_suffix4','e2_pname4_score','e2_cname4','e2_title5','e2_fname5','e2_mname5','e2_lname5','e2_suffix5','e2_pname5_score','e2_cname5','v1_title1','v1_fname1','v1_mname1','v1_lname1','v1_suffix1','v1_pname1_score','v1_cname1','v1_title2','v1_fname2','v1_mname2','v1_lname2','v1_suffix2','v1_pname2_score','v1_cname2','v1_title3','v1_fname3','v1_mname3','v1_lname3','v1_suffix3','v1_pname3_score','v1_cname3','v1_title4','v1_fname4','v1_mname4','v1_lname4','v1_suffix4','v1_pname4_score','v1_cname4','v1_title5','v1_fname5','v1_mname5','v1_lname5','v1_suffix5','v1_pname5_score','v1_cname5','v2_title1','v2_fname1','v2_mname1','v2_lname1','v2_suffix1','v2_pname1_score','v2_cname1','v2_title2','v2_fname2','v2_mname2','v2_lname2','v2_suffix2','v2_pname2_score','v2_cname2','v2_title3','v2_fname3','v2_mname3','v2_lname3','v2_suffix3','v2_pname3_score','v2_cname3','v2_title4','v2_fname4','v2_mname4','v2_lname4','v2_suffix4','v2_pname4_score','v2_cname4','v2_title5','v2_fname5','v2_mname5','v2_lname5','v2_suffix5','v2_pname5_score','v2_cname5');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_first_reported_pcnt,le.populated_dt_last_reported_pcnt,le.populated_process_date_pcnt,le.populated_vendor_pcnt,le.populated_state_origin_pcnt,le.populated_source_file_pcnt,le.populated_case_key_pcnt,le.populated_parent_case_key_pcnt,le.populated_court_code_pcnt,le.populated_court_pcnt,le.populated_case_number_pcnt,le.populated_case_type_code_pcnt,le.populated_case_type_pcnt,le.populated_case_title_pcnt,le.populated_ruled_for_against_code_pcnt,le.populated_ruled_for_against_pcnt,le.populated_entity_1_pcnt,le.populated_entity_nm_format_1_pcnt,le.populated_entity_type_code_1_orig_pcnt,le.populated_entity_type_description_1_orig_pcnt,le.populated_entity_type_code_1_master_pcnt,le.populated_entity_seq_num_1_pcnt,le.populated_atty_seq_num_1_pcnt,le.populated_entity_1_address_1_pcnt,le.populated_entity_1_address_2_pcnt,le.populated_entity_1_address_3_pcnt,le.populated_entity_1_address_4_pcnt,le.populated_entity_1_dob_pcnt,le.populated_primary_entity_2_pcnt,le.populated_entity_nm_format_2_pcnt,le.populated_entity_type_code_2_orig_pcnt,le.populated_entity_type_description_2_orig_pcnt,le.populated_entity_type_code_2_master_pcnt,le.populated_entity_seq_num_2_pcnt,le.populated_atty_seq_num_2_pcnt,le.populated_entity_2_address_1_pcnt,le.populated_entity_2_address_2_pcnt,le.populated_entity_2_address_3_pcnt,le.populated_entity_2_address_4_pcnt,le.populated_entity_2_dob_pcnt,le.populated_prim_range1_pcnt,le.populated_predir1_pcnt,le.populated_prim_name1_pcnt,le.populated_addr_suffix1_pcnt,le.populated_postdir1_pcnt,le.populated_unit_desig1_pcnt,le.populated_sec_range1_pcnt,le.populated_p_city_name1_pcnt,le.populated_v_city_name1_pcnt,le.populated_st1_pcnt,le.populated_zip1_pcnt,le.populated_zip41_pcnt,le.populated_cart1_pcnt,le.populated_cr_sort_sz1_pcnt,le.populated_lot1_pcnt,le.populated_lot_order1_pcnt,le.populated_dpbc1_pcnt,le.populated_chk_digit1_pcnt,le.populated_rec_type1_pcnt,le.populated_ace_fips_st1_pcnt,le.populated_ace_fips_county1_pcnt,le.populated_geo_lat1_pcnt,le.populated_geo_long1_pcnt,le.populated_msa1_pcnt,le.populated_geo_blk1_pcnt,le.populated_geo_match1_pcnt,le.populated_err_stat1_pcnt,le.populated_prim_range2_pcnt,le.populated_predir2_pcnt,le.populated_prim_name2_pcnt,le.populated_addr_suffix2_pcnt,le.populated_postdir2_pcnt,le.populated_unit_desig2_pcnt,le.populated_sec_range2_pcnt,le.populated_p_city_name2_pcnt,le.populated_v_city_name2_pcnt,le.populated_st2_pcnt,le.populated_zip2_pcnt,le.populated_zip42_pcnt,le.populated_cart2_pcnt,le.populated_cr_sort_sz2_pcnt,le.populated_lot2_pcnt,le.populated_lot_order2_pcnt,le.populated_dpbc2_pcnt,le.populated_chk_digit2_pcnt,le.populated_rec_type2_pcnt,le.populated_ace_fips_st2_pcnt,le.populated_ace_fips_county2_pcnt,le.populated_geo_lat2_pcnt,le.populated_geo_long2_pcnt,le.populated_msa2_pcnt,le.populated_geo_blk2_pcnt,le.populated_geo_match2_pcnt,le.populated_err_stat2_pcnt,le.populated_e1_title1_pcnt,le.populated_e1_fname1_pcnt,le.populated_e1_mname1_pcnt,le.populated_e1_lname1_pcnt,le.populated_e1_suffix1_pcnt,le.populated_e1_pname1_score_pcnt,le.populated_e1_cname1_pcnt,le.populated_e1_title2_pcnt,le.populated_e1_fname2_pcnt,le.populated_e1_mname2_pcnt,le.populated_e1_lname2_pcnt,le.populated_e1_suffix2_pcnt,le.populated_e1_pname2_score_pcnt,le.populated_e1_cname2_pcnt,le.populated_e1_title3_pcnt,le.populated_e1_fname3_pcnt,le.populated_e1_mname3_pcnt,le.populated_e1_lname3_pcnt,le.populated_e1_suffix3_pcnt,le.populated_e1_pname3_score_pcnt,le.populated_e1_cname3_pcnt,le.populated_e1_title4_pcnt,le.populated_e1_fname4_pcnt,le.populated_e1_mname4_pcnt,le.populated_e1_lname4_pcnt,le.populated_e1_suffix4_pcnt,le.populated_e1_pname4_score_pcnt,le.populated_e1_cname4_pcnt,le.populated_e1_title5_pcnt,le.populated_e1_fname5_pcnt,le.populated_e1_mname5_pcnt,le.populated_e1_lname5_pcnt,le.populated_e1_suffix5_pcnt,le.populated_e1_pname5_score_pcnt,le.populated_e1_cname5_pcnt,le.populated_e2_title1_pcnt,le.populated_e2_fname1_pcnt,le.populated_e2_mname1_pcnt,le.populated_e2_lname1_pcnt,le.populated_e2_suffix1_pcnt,le.populated_e2_pname1_score_pcnt,le.populated_e2_cname1_pcnt,le.populated_e2_title2_pcnt,le.populated_e2_fname2_pcnt,le.populated_e2_mname2_pcnt,le.populated_e2_lname2_pcnt,le.populated_e2_suffix2_pcnt,le.populated_e2_pname2_score_pcnt,le.populated_e2_cname2_pcnt,le.populated_e2_title3_pcnt,le.populated_e2_fname3_pcnt,le.populated_e2_mname3_pcnt,le.populated_e2_lname3_pcnt,le.populated_e2_suffix3_pcnt,le.populated_e2_pname3_score_pcnt,le.populated_e2_cname3_pcnt,le.populated_e2_title4_pcnt,le.populated_e2_fname4_pcnt,le.populated_e2_mname4_pcnt,le.populated_e2_lname4_pcnt,le.populated_e2_suffix4_pcnt,le.populated_e2_pname4_score_pcnt,le.populated_e2_cname4_pcnt,le.populated_e2_title5_pcnt,le.populated_e2_fname5_pcnt,le.populated_e2_mname5_pcnt,le.populated_e2_lname5_pcnt,le.populated_e2_suffix5_pcnt,le.populated_e2_pname5_score_pcnt,le.populated_e2_cname5_pcnt,le.populated_v1_title1_pcnt,le.populated_v1_fname1_pcnt,le.populated_v1_mname1_pcnt,le.populated_v1_lname1_pcnt,le.populated_v1_suffix1_pcnt,le.populated_v1_pname1_score_pcnt,le.populated_v1_cname1_pcnt,le.populated_v1_title2_pcnt,le.populated_v1_fname2_pcnt,le.populated_v1_mname2_pcnt,le.populated_v1_lname2_pcnt,le.populated_v1_suffix2_pcnt,le.populated_v1_pname2_score_pcnt,le.populated_v1_cname2_pcnt,le.populated_v1_title3_pcnt,le.populated_v1_fname3_pcnt,le.populated_v1_mname3_pcnt,le.populated_v1_lname3_pcnt,le.populated_v1_suffix3_pcnt,le.populated_v1_pname3_score_pcnt,le.populated_v1_cname3_pcnt,le.populated_v1_title4_pcnt,le.populated_v1_fname4_pcnt,le.populated_v1_mname4_pcnt,le.populated_v1_lname4_pcnt,le.populated_v1_suffix4_pcnt,le.populated_v1_pname4_score_pcnt,le.populated_v1_cname4_pcnt,le.populated_v1_title5_pcnt,le.populated_v1_fname5_pcnt,le.populated_v1_mname5_pcnt,le.populated_v1_lname5_pcnt,le.populated_v1_suffix5_pcnt,le.populated_v1_pname5_score_pcnt,le.populated_v1_cname5_pcnt,le.populated_v2_title1_pcnt,le.populated_v2_fname1_pcnt,le.populated_v2_mname1_pcnt,le.populated_v2_lname1_pcnt,le.populated_v2_suffix1_pcnt,le.populated_v2_pname1_score_pcnt,le.populated_v2_cname1_pcnt,le.populated_v2_title2_pcnt,le.populated_v2_fname2_pcnt,le.populated_v2_mname2_pcnt,le.populated_v2_lname2_pcnt,le.populated_v2_suffix2_pcnt,le.populated_v2_pname2_score_pcnt,le.populated_v2_cname2_pcnt,le.populated_v2_title3_pcnt,le.populated_v2_fname3_pcnt,le.populated_v2_mname3_pcnt,le.populated_v2_lname3_pcnt,le.populated_v2_suffix3_pcnt,le.populated_v2_pname3_score_pcnt,le.populated_v2_cname3_pcnt,le.populated_v2_title4_pcnt,le.populated_v2_fname4_pcnt,le.populated_v2_mname4_pcnt,le.populated_v2_lname4_pcnt,le.populated_v2_suffix4_pcnt,le.populated_v2_pname4_score_pcnt,le.populated_v2_cname4_pcnt,le.populated_v2_title5_pcnt,le.populated_v2_fname5_pcnt,le.populated_v2_mname5_pcnt,le.populated_v2_lname5_pcnt,le.populated_v2_suffix5_pcnt,le.populated_v2_pname5_score_pcnt,le.populated_v2_cname5_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_first_reported,le.maxlength_dt_last_reported,le.maxlength_process_date,le.maxlength_vendor,le.maxlength_state_origin,le.maxlength_source_file,le.maxlength_case_key,le.maxlength_parent_case_key,le.maxlength_court_code,le.maxlength_court,le.maxlength_case_number,le.maxlength_case_type_code,le.maxlength_case_type,le.maxlength_case_title,le.maxlength_ruled_for_against_code,le.maxlength_ruled_for_against,le.maxlength_entity_1,le.maxlength_entity_nm_format_1,le.maxlength_entity_type_code_1_orig,le.maxlength_entity_type_description_1_orig,le.maxlength_entity_type_code_1_master,le.maxlength_entity_seq_num_1,le.maxlength_atty_seq_num_1,le.maxlength_entity_1_address_1,le.maxlength_entity_1_address_2,le.maxlength_entity_1_address_3,le.maxlength_entity_1_address_4,le.maxlength_entity_1_dob,le.maxlength_primary_entity_2,le.maxlength_entity_nm_format_2,le.maxlength_entity_type_code_2_orig,le.maxlength_entity_type_description_2_orig,le.maxlength_entity_type_code_2_master,le.maxlength_entity_seq_num_2,le.maxlength_atty_seq_num_2,le.maxlength_entity_2_address_1,le.maxlength_entity_2_address_2,le.maxlength_entity_2_address_3,le.maxlength_entity_2_address_4,le.maxlength_entity_2_dob,le.maxlength_prim_range1,le.maxlength_predir1,le.maxlength_prim_name1,le.maxlength_addr_suffix1,le.maxlength_postdir1,le.maxlength_unit_desig1,le.maxlength_sec_range1,le.maxlength_p_city_name1,le.maxlength_v_city_name1,le.maxlength_st1,le.maxlength_zip1,le.maxlength_zip41,le.maxlength_cart1,le.maxlength_cr_sort_sz1,le.maxlength_lot1,le.maxlength_lot_order1,le.maxlength_dpbc1,le.maxlength_chk_digit1,le.maxlength_rec_type1,le.maxlength_ace_fips_st1,le.maxlength_ace_fips_county1,le.maxlength_geo_lat1,le.maxlength_geo_long1,le.maxlength_msa1,le.maxlength_geo_blk1,le.maxlength_geo_match1,le.maxlength_err_stat1,le.maxlength_prim_range2,le.maxlength_predir2,le.maxlength_prim_name2,le.maxlength_addr_suffix2,le.maxlength_postdir2,le.maxlength_unit_desig2,le.maxlength_sec_range2,le.maxlength_p_city_name2,le.maxlength_v_city_name2,le.maxlength_st2,le.maxlength_zip2,le.maxlength_zip42,le.maxlength_cart2,le.maxlength_cr_sort_sz2,le.maxlength_lot2,le.maxlength_lot_order2,le.maxlength_dpbc2,le.maxlength_chk_digit2,le.maxlength_rec_type2,le.maxlength_ace_fips_st2,le.maxlength_ace_fips_county2,le.maxlength_geo_lat2,le.maxlength_geo_long2,le.maxlength_msa2,le.maxlength_geo_blk2,le.maxlength_geo_match2,le.maxlength_err_stat2,le.maxlength_e1_title1,le.maxlength_e1_fname1,le.maxlength_e1_mname1,le.maxlength_e1_lname1,le.maxlength_e1_suffix1,le.maxlength_e1_pname1_score,le.maxlength_e1_cname1,le.maxlength_e1_title2,le.maxlength_e1_fname2,le.maxlength_e1_mname2,le.maxlength_e1_lname2,le.maxlength_e1_suffix2,le.maxlength_e1_pname2_score,le.maxlength_e1_cname2,le.maxlength_e1_title3,le.maxlength_e1_fname3,le.maxlength_e1_mname3,le.maxlength_e1_lname3,le.maxlength_e1_suffix3,le.maxlength_e1_pname3_score,le.maxlength_e1_cname3,le.maxlength_e1_title4,le.maxlength_e1_fname4,le.maxlength_e1_mname4,le.maxlength_e1_lname4,le.maxlength_e1_suffix4,le.maxlength_e1_pname4_score,le.maxlength_e1_cname4,le.maxlength_e1_title5,le.maxlength_e1_fname5,le.maxlength_e1_mname5,le.maxlength_e1_lname5,le.maxlength_e1_suffix5,le.maxlength_e1_pname5_score,le.maxlength_e1_cname5,le.maxlength_e2_title1,le.maxlength_e2_fname1,le.maxlength_e2_mname1,le.maxlength_e2_lname1,le.maxlength_e2_suffix1,le.maxlength_e2_pname1_score,le.maxlength_e2_cname1,le.maxlength_e2_title2,le.maxlength_e2_fname2,le.maxlength_e2_mname2,le.maxlength_e2_lname2,le.maxlength_e2_suffix2,le.maxlength_e2_pname2_score,le.maxlength_e2_cname2,le.maxlength_e2_title3,le.maxlength_e2_fname3,le.maxlength_e2_mname3,le.maxlength_e2_lname3,le.maxlength_e2_suffix3,le.maxlength_e2_pname3_score,le.maxlength_e2_cname3,le.maxlength_e2_title4,le.maxlength_e2_fname4,le.maxlength_e2_mname4,le.maxlength_e2_lname4,le.maxlength_e2_suffix4,le.maxlength_e2_pname4_score,le.maxlength_e2_cname4,le.maxlength_e2_title5,le.maxlength_e2_fname5,le.maxlength_e2_mname5,le.maxlength_e2_lname5,le.maxlength_e2_suffix5,le.maxlength_e2_pname5_score,le.maxlength_e2_cname5,le.maxlength_v1_title1,le.maxlength_v1_fname1,le.maxlength_v1_mname1,le.maxlength_v1_lname1,le.maxlength_v1_suffix1,le.maxlength_v1_pname1_score,le.maxlength_v1_cname1,le.maxlength_v1_title2,le.maxlength_v1_fname2,le.maxlength_v1_mname2,le.maxlength_v1_lname2,le.maxlength_v1_suffix2,le.maxlength_v1_pname2_score,le.maxlength_v1_cname2,le.maxlength_v1_title3,le.maxlength_v1_fname3,le.maxlength_v1_mname3,le.maxlength_v1_lname3,le.maxlength_v1_suffix3,le.maxlength_v1_pname3_score,le.maxlength_v1_cname3,le.maxlength_v1_title4,le.maxlength_v1_fname4,le.maxlength_v1_mname4,le.maxlength_v1_lname4,le.maxlength_v1_suffix4,le.maxlength_v1_pname4_score,le.maxlength_v1_cname4,le.maxlength_v1_title5,le.maxlength_v1_fname5,le.maxlength_v1_mname5,le.maxlength_v1_lname5,le.maxlength_v1_suffix5,le.maxlength_v1_pname5_score,le.maxlength_v1_cname5,le.maxlength_v2_title1,le.maxlength_v2_fname1,le.maxlength_v2_mname1,le.maxlength_v2_lname1,le.maxlength_v2_suffix1,le.maxlength_v2_pname1_score,le.maxlength_v2_cname1,le.maxlength_v2_title2,le.maxlength_v2_fname2,le.maxlength_v2_mname2,le.maxlength_v2_lname2,le.maxlength_v2_suffix2,le.maxlength_v2_pname2_score,le.maxlength_v2_cname2,le.maxlength_v2_title3,le.maxlength_v2_fname3,le.maxlength_v2_mname3,le.maxlength_v2_lname3,le.maxlength_v2_suffix3,le.maxlength_v2_pname3_score,le.maxlength_v2_cname3,le.maxlength_v2_title4,le.maxlength_v2_fname4,le.maxlength_v2_mname4,le.maxlength_v2_lname4,le.maxlength_v2_suffix4,le.maxlength_v2_pname4_score,le.maxlength_v2_cname4,le.maxlength_v2_title5,le.maxlength_v2_fname5,le.maxlength_v2_mname5,le.maxlength_v2_lname5,le.maxlength_v2_suffix5,le.maxlength_v2_pname5_score,le.maxlength_v2_cname5);
  SELF.avelength := CHOOSE(C,le.avelength_dt_first_reported,le.avelength_dt_last_reported,le.avelength_process_date,le.avelength_vendor,le.avelength_state_origin,le.avelength_source_file,le.avelength_case_key,le.avelength_parent_case_key,le.avelength_court_code,le.avelength_court,le.avelength_case_number,le.avelength_case_type_code,le.avelength_case_type,le.avelength_case_title,le.avelength_ruled_for_against_code,le.avelength_ruled_for_against,le.avelength_entity_1,le.avelength_entity_nm_format_1,le.avelength_entity_type_code_1_orig,le.avelength_entity_type_description_1_orig,le.avelength_entity_type_code_1_master,le.avelength_entity_seq_num_1,le.avelength_atty_seq_num_1,le.avelength_entity_1_address_1,le.avelength_entity_1_address_2,le.avelength_entity_1_address_3,le.avelength_entity_1_address_4,le.avelength_entity_1_dob,le.avelength_primary_entity_2,le.avelength_entity_nm_format_2,le.avelength_entity_type_code_2_orig,le.avelength_entity_type_description_2_orig,le.avelength_entity_type_code_2_master,le.avelength_entity_seq_num_2,le.avelength_atty_seq_num_2,le.avelength_entity_2_address_1,le.avelength_entity_2_address_2,le.avelength_entity_2_address_3,le.avelength_entity_2_address_4,le.avelength_entity_2_dob,le.avelength_prim_range1,le.avelength_predir1,le.avelength_prim_name1,le.avelength_addr_suffix1,le.avelength_postdir1,le.avelength_unit_desig1,le.avelength_sec_range1,le.avelength_p_city_name1,le.avelength_v_city_name1,le.avelength_st1,le.avelength_zip1,le.avelength_zip41,le.avelength_cart1,le.avelength_cr_sort_sz1,le.avelength_lot1,le.avelength_lot_order1,le.avelength_dpbc1,le.avelength_chk_digit1,le.avelength_rec_type1,le.avelength_ace_fips_st1,le.avelength_ace_fips_county1,le.avelength_geo_lat1,le.avelength_geo_long1,le.avelength_msa1,le.avelength_geo_blk1,le.avelength_geo_match1,le.avelength_err_stat1,le.avelength_prim_range2,le.avelength_predir2,le.avelength_prim_name2,le.avelength_addr_suffix2,le.avelength_postdir2,le.avelength_unit_desig2,le.avelength_sec_range2,le.avelength_p_city_name2,le.avelength_v_city_name2,le.avelength_st2,le.avelength_zip2,le.avelength_zip42,le.avelength_cart2,le.avelength_cr_sort_sz2,le.avelength_lot2,le.avelength_lot_order2,le.avelength_dpbc2,le.avelength_chk_digit2,le.avelength_rec_type2,le.avelength_ace_fips_st2,le.avelength_ace_fips_county2,le.avelength_geo_lat2,le.avelength_geo_long2,le.avelength_msa2,le.avelength_geo_blk2,le.avelength_geo_match2,le.avelength_err_stat2,le.avelength_e1_title1,le.avelength_e1_fname1,le.avelength_e1_mname1,le.avelength_e1_lname1,le.avelength_e1_suffix1,le.avelength_e1_pname1_score,le.avelength_e1_cname1,le.avelength_e1_title2,le.avelength_e1_fname2,le.avelength_e1_mname2,le.avelength_e1_lname2,le.avelength_e1_suffix2,le.avelength_e1_pname2_score,le.avelength_e1_cname2,le.avelength_e1_title3,le.avelength_e1_fname3,le.avelength_e1_mname3,le.avelength_e1_lname3,le.avelength_e1_suffix3,le.avelength_e1_pname3_score,le.avelength_e1_cname3,le.avelength_e1_title4,le.avelength_e1_fname4,le.avelength_e1_mname4,le.avelength_e1_lname4,le.avelength_e1_suffix4,le.avelength_e1_pname4_score,le.avelength_e1_cname4,le.avelength_e1_title5,le.avelength_e1_fname5,le.avelength_e1_mname5,le.avelength_e1_lname5,le.avelength_e1_suffix5,le.avelength_e1_pname5_score,le.avelength_e1_cname5,le.avelength_e2_title1,le.avelength_e2_fname1,le.avelength_e2_mname1,le.avelength_e2_lname1,le.avelength_e2_suffix1,le.avelength_e2_pname1_score,le.avelength_e2_cname1,le.avelength_e2_title2,le.avelength_e2_fname2,le.avelength_e2_mname2,le.avelength_e2_lname2,le.avelength_e2_suffix2,le.avelength_e2_pname2_score,le.avelength_e2_cname2,le.avelength_e2_title3,le.avelength_e2_fname3,le.avelength_e2_mname3,le.avelength_e2_lname3,le.avelength_e2_suffix3,le.avelength_e2_pname3_score,le.avelength_e2_cname3,le.avelength_e2_title4,le.avelength_e2_fname4,le.avelength_e2_mname4,le.avelength_e2_lname4,le.avelength_e2_suffix4,le.avelength_e2_pname4_score,le.avelength_e2_cname4,le.avelength_e2_title5,le.avelength_e2_fname5,le.avelength_e2_mname5,le.avelength_e2_lname5,le.avelength_e2_suffix5,le.avelength_e2_pname5_score,le.avelength_e2_cname5,le.avelength_v1_title1,le.avelength_v1_fname1,le.avelength_v1_mname1,le.avelength_v1_lname1,le.avelength_v1_suffix1,le.avelength_v1_pname1_score,le.avelength_v1_cname1,le.avelength_v1_title2,le.avelength_v1_fname2,le.avelength_v1_mname2,le.avelength_v1_lname2,le.avelength_v1_suffix2,le.avelength_v1_pname2_score,le.avelength_v1_cname2,le.avelength_v1_title3,le.avelength_v1_fname3,le.avelength_v1_mname3,le.avelength_v1_lname3,le.avelength_v1_suffix3,le.avelength_v1_pname3_score,le.avelength_v1_cname3,le.avelength_v1_title4,le.avelength_v1_fname4,le.avelength_v1_mname4,le.avelength_v1_lname4,le.avelength_v1_suffix4,le.avelength_v1_pname4_score,le.avelength_v1_cname4,le.avelength_v1_title5,le.avelength_v1_fname5,le.avelength_v1_mname5,le.avelength_v1_lname5,le.avelength_v1_suffix5,le.avelength_v1_pname5_score,le.avelength_v1_cname5,le.avelength_v2_title1,le.avelength_v2_fname1,le.avelength_v2_mname1,le.avelength_v2_lname1,le.avelength_v2_suffix1,le.avelength_v2_pname1_score,le.avelength_v2_cname1,le.avelength_v2_title2,le.avelength_v2_fname2,le.avelength_v2_mname2,le.avelength_v2_lname2,le.avelength_v2_suffix2,le.avelength_v2_pname2_score,le.avelength_v2_cname2,le.avelength_v2_title3,le.avelength_v2_fname3,le.avelength_v2_mname3,le.avelength_v2_lname3,le.avelength_v2_suffix3,le.avelength_v2_pname3_score,le.avelength_v2_cname3,le.avelength_v2_title4,le.avelength_v2_fname4,le.avelength_v2_mname4,le.avelength_v2_lname4,le.avelength_v2_suffix4,le.avelength_v2_pname4_score,le.avelength_v2_cname4,le.avelength_v2_title5,le.avelength_v2_fname5,le.avelength_v2_mname5,le.avelength_v2_lname5,le.avelength_v2_suffix5,le.avelength_v2_pname5_score,le.avelength_v2_cname5);
END;
EXPORT invSummary := NORMALIZE(summary0, 234, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.dt_first_reported),TRIM((SALT39.StrType)le.dt_last_reported),TRIM((SALT39.StrType)le.process_date),TRIM((SALT39.StrType)le.vendor),TRIM((SALT39.StrType)le.state_origin),TRIM((SALT39.StrType)le.source_file),TRIM((SALT39.StrType)le.case_key),TRIM((SALT39.StrType)le.parent_case_key),TRIM((SALT39.StrType)le.court_code),TRIM((SALT39.StrType)le.court),TRIM((SALT39.StrType)le.case_number),TRIM((SALT39.StrType)le.case_type_code),TRIM((SALT39.StrType)le.case_type),TRIM((SALT39.StrType)le.case_title),TRIM((SALT39.StrType)le.ruled_for_against_code),TRIM((SALT39.StrType)le.ruled_for_against),TRIM((SALT39.StrType)le.entity_1),TRIM((SALT39.StrType)le.entity_nm_format_1),TRIM((SALT39.StrType)le.entity_type_code_1_orig),TRIM((SALT39.StrType)le.entity_type_description_1_orig),TRIM((SALT39.StrType)le.entity_type_code_1_master),TRIM((SALT39.StrType)le.entity_seq_num_1),TRIM((SALT39.StrType)le.atty_seq_num_1),TRIM((SALT39.StrType)le.entity_1_address_1),TRIM((SALT39.StrType)le.entity_1_address_2),TRIM((SALT39.StrType)le.entity_1_address_3),TRIM((SALT39.StrType)le.entity_1_address_4),TRIM((SALT39.StrType)le.entity_1_dob),TRIM((SALT39.StrType)le.primary_entity_2),TRIM((SALT39.StrType)le.entity_nm_format_2),TRIM((SALT39.StrType)le.entity_type_code_2_orig),TRIM((SALT39.StrType)le.entity_type_description_2_orig),TRIM((SALT39.StrType)le.entity_type_code_2_master),TRIM((SALT39.StrType)le.entity_seq_num_2),TRIM((SALT39.StrType)le.atty_seq_num_2),TRIM((SALT39.StrType)le.entity_2_address_1),TRIM((SALT39.StrType)le.entity_2_address_2),TRIM((SALT39.StrType)le.entity_2_address_3),TRIM((SALT39.StrType)le.entity_2_address_4),TRIM((SALT39.StrType)le.entity_2_dob),TRIM((SALT39.StrType)le.prim_range1),TRIM((SALT39.StrType)le.predir1),TRIM((SALT39.StrType)le.prim_name1),TRIM((SALT39.StrType)le.addr_suffix1),TRIM((SALT39.StrType)le.postdir1),TRIM((SALT39.StrType)le.unit_desig1),TRIM((SALT39.StrType)le.sec_range1),TRIM((SALT39.StrType)le.p_city_name1),TRIM((SALT39.StrType)le.v_city_name1),TRIM((SALT39.StrType)le.st1),TRIM((SALT39.StrType)le.zip1),TRIM((SALT39.StrType)le.zip41),TRIM((SALT39.StrType)le.cart1),TRIM((SALT39.StrType)le.cr_sort_sz1),TRIM((SALT39.StrType)le.lot1),TRIM((SALT39.StrType)le.lot_order1),TRIM((SALT39.StrType)le.dpbc1),TRIM((SALT39.StrType)le.chk_digit1),TRIM((SALT39.StrType)le.rec_type1),TRIM((SALT39.StrType)le.ace_fips_st1),TRIM((SALT39.StrType)le.ace_fips_county1),TRIM((SALT39.StrType)le.geo_lat1),TRIM((SALT39.StrType)le.geo_long1),TRIM((SALT39.StrType)le.msa1),TRIM((SALT39.StrType)le.geo_blk1),TRIM((SALT39.StrType)le.geo_match1),TRIM((SALT39.StrType)le.err_stat1),TRIM((SALT39.StrType)le.prim_range2),TRIM((SALT39.StrType)le.predir2),TRIM((SALT39.StrType)le.prim_name2),TRIM((SALT39.StrType)le.addr_suffix2),TRIM((SALT39.StrType)le.postdir2),TRIM((SALT39.StrType)le.unit_desig2),TRIM((SALT39.StrType)le.sec_range2),TRIM((SALT39.StrType)le.p_city_name2),TRIM((SALT39.StrType)le.v_city_name2),TRIM((SALT39.StrType)le.st2),TRIM((SALT39.StrType)le.zip2),TRIM((SALT39.StrType)le.zip42),TRIM((SALT39.StrType)le.cart2),TRIM((SALT39.StrType)le.cr_sort_sz2),TRIM((SALT39.StrType)le.lot2),TRIM((SALT39.StrType)le.lot_order2),TRIM((SALT39.StrType)le.dpbc2),TRIM((SALT39.StrType)le.chk_digit2),TRIM((SALT39.StrType)le.rec_type2),TRIM((SALT39.StrType)le.ace_fips_st2),TRIM((SALT39.StrType)le.ace_fips_county2),TRIM((SALT39.StrType)le.geo_lat2),TRIM((SALT39.StrType)le.geo_long2),TRIM((SALT39.StrType)le.msa2),TRIM((SALT39.StrType)le.geo_blk2),TRIM((SALT39.StrType)le.geo_match2),TRIM((SALT39.StrType)le.err_stat2),TRIM((SALT39.StrType)le.e1_title1),TRIM((SALT39.StrType)le.e1_fname1),TRIM((SALT39.StrType)le.e1_mname1),TRIM((SALT39.StrType)le.e1_lname1),TRIM((SALT39.StrType)le.e1_suffix1),TRIM((SALT39.StrType)le.e1_pname1_score),TRIM((SALT39.StrType)le.e1_cname1),TRIM((SALT39.StrType)le.e1_title2),TRIM((SALT39.StrType)le.e1_fname2),TRIM((SALT39.StrType)le.e1_mname2),TRIM((SALT39.StrType)le.e1_lname2),TRIM((SALT39.StrType)le.e1_suffix2),TRIM((SALT39.StrType)le.e1_pname2_score),TRIM((SALT39.StrType)le.e1_cname2),TRIM((SALT39.StrType)le.e1_title3),TRIM((SALT39.StrType)le.e1_fname3),TRIM((SALT39.StrType)le.e1_mname3),TRIM((SALT39.StrType)le.e1_lname3),TRIM((SALT39.StrType)le.e1_suffix3),TRIM((SALT39.StrType)le.e1_pname3_score),TRIM((SALT39.StrType)le.e1_cname3),TRIM((SALT39.StrType)le.e1_title4),TRIM((SALT39.StrType)le.e1_fname4),TRIM((SALT39.StrType)le.e1_mname4),TRIM((SALT39.StrType)le.e1_lname4),TRIM((SALT39.StrType)le.e1_suffix4),TRIM((SALT39.StrType)le.e1_pname4_score),TRIM((SALT39.StrType)le.e1_cname4),TRIM((SALT39.StrType)le.e1_title5),TRIM((SALT39.StrType)le.e1_fname5),TRIM((SALT39.StrType)le.e1_mname5),TRIM((SALT39.StrType)le.e1_lname5),TRIM((SALT39.StrType)le.e1_suffix5),TRIM((SALT39.StrType)le.e1_pname5_score),TRIM((SALT39.StrType)le.e1_cname5),TRIM((SALT39.StrType)le.e2_title1),TRIM((SALT39.StrType)le.e2_fname1),TRIM((SALT39.StrType)le.e2_mname1),TRIM((SALT39.StrType)le.e2_lname1),TRIM((SALT39.StrType)le.e2_suffix1),TRIM((SALT39.StrType)le.e2_pname1_score),TRIM((SALT39.StrType)le.e2_cname1),TRIM((SALT39.StrType)le.e2_title2),TRIM((SALT39.StrType)le.e2_fname2),TRIM((SALT39.StrType)le.e2_mname2),TRIM((SALT39.StrType)le.e2_lname2),TRIM((SALT39.StrType)le.e2_suffix2),TRIM((SALT39.StrType)le.e2_pname2_score),TRIM((SALT39.StrType)le.e2_cname2),TRIM((SALT39.StrType)le.e2_title3),TRIM((SALT39.StrType)le.e2_fname3),TRIM((SALT39.StrType)le.e2_mname3),TRIM((SALT39.StrType)le.e2_lname3),TRIM((SALT39.StrType)le.e2_suffix3),TRIM((SALT39.StrType)le.e2_pname3_score),TRIM((SALT39.StrType)le.e2_cname3),TRIM((SALT39.StrType)le.e2_title4),TRIM((SALT39.StrType)le.e2_fname4),TRIM((SALT39.StrType)le.e2_mname4),TRIM((SALT39.StrType)le.e2_lname4),TRIM((SALT39.StrType)le.e2_suffix4),TRIM((SALT39.StrType)le.e2_pname4_score),TRIM((SALT39.StrType)le.e2_cname4),TRIM((SALT39.StrType)le.e2_title5),TRIM((SALT39.StrType)le.e2_fname5),TRIM((SALT39.StrType)le.e2_mname5),TRIM((SALT39.StrType)le.e2_lname5),TRIM((SALT39.StrType)le.e2_suffix5),TRIM((SALT39.StrType)le.e2_pname5_score),TRIM((SALT39.StrType)le.e2_cname5),TRIM((SALT39.StrType)le.v1_title1),TRIM((SALT39.StrType)le.v1_fname1),TRIM((SALT39.StrType)le.v1_mname1),TRIM((SALT39.StrType)le.v1_lname1),TRIM((SALT39.StrType)le.v1_suffix1),TRIM((SALT39.StrType)le.v1_pname1_score),TRIM((SALT39.StrType)le.v1_cname1),TRIM((SALT39.StrType)le.v1_title2),TRIM((SALT39.StrType)le.v1_fname2),TRIM((SALT39.StrType)le.v1_mname2),TRIM((SALT39.StrType)le.v1_lname2),TRIM((SALT39.StrType)le.v1_suffix2),TRIM((SALT39.StrType)le.v1_pname2_score),TRIM((SALT39.StrType)le.v1_cname2),TRIM((SALT39.StrType)le.v1_title3),TRIM((SALT39.StrType)le.v1_fname3),TRIM((SALT39.StrType)le.v1_mname3),TRIM((SALT39.StrType)le.v1_lname3),TRIM((SALT39.StrType)le.v1_suffix3),TRIM((SALT39.StrType)le.v1_pname3_score),TRIM((SALT39.StrType)le.v1_cname3),TRIM((SALT39.StrType)le.v1_title4),TRIM((SALT39.StrType)le.v1_fname4),TRIM((SALT39.StrType)le.v1_mname4),TRIM((SALT39.StrType)le.v1_lname4),TRIM((SALT39.StrType)le.v1_suffix4),TRIM((SALT39.StrType)le.v1_pname4_score),TRIM((SALT39.StrType)le.v1_cname4),TRIM((SALT39.StrType)le.v1_title5),TRIM((SALT39.StrType)le.v1_fname5),TRIM((SALT39.StrType)le.v1_mname5),TRIM((SALT39.StrType)le.v1_lname5),TRIM((SALT39.StrType)le.v1_suffix5),TRIM((SALT39.StrType)le.v1_pname5_score),TRIM((SALT39.StrType)le.v1_cname5),TRIM((SALT39.StrType)le.v2_title1),TRIM((SALT39.StrType)le.v2_fname1),TRIM((SALT39.StrType)le.v2_mname1),TRIM((SALT39.StrType)le.v2_lname1),TRIM((SALT39.StrType)le.v2_suffix1),TRIM((SALT39.StrType)le.v2_pname1_score),TRIM((SALT39.StrType)le.v2_cname1),TRIM((SALT39.StrType)le.v2_title2),TRIM((SALT39.StrType)le.v2_fname2),TRIM((SALT39.StrType)le.v2_mname2),TRIM((SALT39.StrType)le.v2_lname2),TRIM((SALT39.StrType)le.v2_suffix2),TRIM((SALT39.StrType)le.v2_pname2_score),TRIM((SALT39.StrType)le.v2_cname2),TRIM((SALT39.StrType)le.v2_title3),TRIM((SALT39.StrType)le.v2_fname3),TRIM((SALT39.StrType)le.v2_mname3),TRIM((SALT39.StrType)le.v2_lname3),TRIM((SALT39.StrType)le.v2_suffix3),TRIM((SALT39.StrType)le.v2_pname3_score),TRIM((SALT39.StrType)le.v2_cname3),TRIM((SALT39.StrType)le.v2_title4),TRIM((SALT39.StrType)le.v2_fname4),TRIM((SALT39.StrType)le.v2_mname4),TRIM((SALT39.StrType)le.v2_lname4),TRIM((SALT39.StrType)le.v2_suffix4),TRIM((SALT39.StrType)le.v2_pname4_score),TRIM((SALT39.StrType)le.v2_cname4),TRIM((SALT39.StrType)le.v2_title5),TRIM((SALT39.StrType)le.v2_fname5),TRIM((SALT39.StrType)le.v2_mname5),TRIM((SALT39.StrType)le.v2_lname5),TRIM((SALT39.StrType)le.v2_suffix5),TRIM((SALT39.StrType)le.v2_pname5_score),TRIM((SALT39.StrType)le.v2_cname5)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,234,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 234);
  SELF.FldNo2 := 1 + (C % 234);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.dt_first_reported),TRIM((SALT39.StrType)le.dt_last_reported),TRIM((SALT39.StrType)le.process_date),TRIM((SALT39.StrType)le.vendor),TRIM((SALT39.StrType)le.state_origin),TRIM((SALT39.StrType)le.source_file),TRIM((SALT39.StrType)le.case_key),TRIM((SALT39.StrType)le.parent_case_key),TRIM((SALT39.StrType)le.court_code),TRIM((SALT39.StrType)le.court),TRIM((SALT39.StrType)le.case_number),TRIM((SALT39.StrType)le.case_type_code),TRIM((SALT39.StrType)le.case_type),TRIM((SALT39.StrType)le.case_title),TRIM((SALT39.StrType)le.ruled_for_against_code),TRIM((SALT39.StrType)le.ruled_for_against),TRIM((SALT39.StrType)le.entity_1),TRIM((SALT39.StrType)le.entity_nm_format_1),TRIM((SALT39.StrType)le.entity_type_code_1_orig),TRIM((SALT39.StrType)le.entity_type_description_1_orig),TRIM((SALT39.StrType)le.entity_type_code_1_master),TRIM((SALT39.StrType)le.entity_seq_num_1),TRIM((SALT39.StrType)le.atty_seq_num_1),TRIM((SALT39.StrType)le.entity_1_address_1),TRIM((SALT39.StrType)le.entity_1_address_2),TRIM((SALT39.StrType)le.entity_1_address_3),TRIM((SALT39.StrType)le.entity_1_address_4),TRIM((SALT39.StrType)le.entity_1_dob),TRIM((SALT39.StrType)le.primary_entity_2),TRIM((SALT39.StrType)le.entity_nm_format_2),TRIM((SALT39.StrType)le.entity_type_code_2_orig),TRIM((SALT39.StrType)le.entity_type_description_2_orig),TRIM((SALT39.StrType)le.entity_type_code_2_master),TRIM((SALT39.StrType)le.entity_seq_num_2),TRIM((SALT39.StrType)le.atty_seq_num_2),TRIM((SALT39.StrType)le.entity_2_address_1),TRIM((SALT39.StrType)le.entity_2_address_2),TRIM((SALT39.StrType)le.entity_2_address_3),TRIM((SALT39.StrType)le.entity_2_address_4),TRIM((SALT39.StrType)le.entity_2_dob),TRIM((SALT39.StrType)le.prim_range1),TRIM((SALT39.StrType)le.predir1),TRIM((SALT39.StrType)le.prim_name1),TRIM((SALT39.StrType)le.addr_suffix1),TRIM((SALT39.StrType)le.postdir1),TRIM((SALT39.StrType)le.unit_desig1),TRIM((SALT39.StrType)le.sec_range1),TRIM((SALT39.StrType)le.p_city_name1),TRIM((SALT39.StrType)le.v_city_name1),TRIM((SALT39.StrType)le.st1),TRIM((SALT39.StrType)le.zip1),TRIM((SALT39.StrType)le.zip41),TRIM((SALT39.StrType)le.cart1),TRIM((SALT39.StrType)le.cr_sort_sz1),TRIM((SALT39.StrType)le.lot1),TRIM((SALT39.StrType)le.lot_order1),TRIM((SALT39.StrType)le.dpbc1),TRIM((SALT39.StrType)le.chk_digit1),TRIM((SALT39.StrType)le.rec_type1),TRIM((SALT39.StrType)le.ace_fips_st1),TRIM((SALT39.StrType)le.ace_fips_county1),TRIM((SALT39.StrType)le.geo_lat1),TRIM((SALT39.StrType)le.geo_long1),TRIM((SALT39.StrType)le.msa1),TRIM((SALT39.StrType)le.geo_blk1),TRIM((SALT39.StrType)le.geo_match1),TRIM((SALT39.StrType)le.err_stat1),TRIM((SALT39.StrType)le.prim_range2),TRIM((SALT39.StrType)le.predir2),TRIM((SALT39.StrType)le.prim_name2),TRIM((SALT39.StrType)le.addr_suffix2),TRIM((SALT39.StrType)le.postdir2),TRIM((SALT39.StrType)le.unit_desig2),TRIM((SALT39.StrType)le.sec_range2),TRIM((SALT39.StrType)le.p_city_name2),TRIM((SALT39.StrType)le.v_city_name2),TRIM((SALT39.StrType)le.st2),TRIM((SALT39.StrType)le.zip2),TRIM((SALT39.StrType)le.zip42),TRIM((SALT39.StrType)le.cart2),TRIM((SALT39.StrType)le.cr_sort_sz2),TRIM((SALT39.StrType)le.lot2),TRIM((SALT39.StrType)le.lot_order2),TRIM((SALT39.StrType)le.dpbc2),TRIM((SALT39.StrType)le.chk_digit2),TRIM((SALT39.StrType)le.rec_type2),TRIM((SALT39.StrType)le.ace_fips_st2),TRIM((SALT39.StrType)le.ace_fips_county2),TRIM((SALT39.StrType)le.geo_lat2),TRIM((SALT39.StrType)le.geo_long2),TRIM((SALT39.StrType)le.msa2),TRIM((SALT39.StrType)le.geo_blk2),TRIM((SALT39.StrType)le.geo_match2),TRIM((SALT39.StrType)le.err_stat2),TRIM((SALT39.StrType)le.e1_title1),TRIM((SALT39.StrType)le.e1_fname1),TRIM((SALT39.StrType)le.e1_mname1),TRIM((SALT39.StrType)le.e1_lname1),TRIM((SALT39.StrType)le.e1_suffix1),TRIM((SALT39.StrType)le.e1_pname1_score),TRIM((SALT39.StrType)le.e1_cname1),TRIM((SALT39.StrType)le.e1_title2),TRIM((SALT39.StrType)le.e1_fname2),TRIM((SALT39.StrType)le.e1_mname2),TRIM((SALT39.StrType)le.e1_lname2),TRIM((SALT39.StrType)le.e1_suffix2),TRIM((SALT39.StrType)le.e1_pname2_score),TRIM((SALT39.StrType)le.e1_cname2),TRIM((SALT39.StrType)le.e1_title3),TRIM((SALT39.StrType)le.e1_fname3),TRIM((SALT39.StrType)le.e1_mname3),TRIM((SALT39.StrType)le.e1_lname3),TRIM((SALT39.StrType)le.e1_suffix3),TRIM((SALT39.StrType)le.e1_pname3_score),TRIM((SALT39.StrType)le.e1_cname3),TRIM((SALT39.StrType)le.e1_title4),TRIM((SALT39.StrType)le.e1_fname4),TRIM((SALT39.StrType)le.e1_mname4),TRIM((SALT39.StrType)le.e1_lname4),TRIM((SALT39.StrType)le.e1_suffix4),TRIM((SALT39.StrType)le.e1_pname4_score),TRIM((SALT39.StrType)le.e1_cname4),TRIM((SALT39.StrType)le.e1_title5),TRIM((SALT39.StrType)le.e1_fname5),TRIM((SALT39.StrType)le.e1_mname5),TRIM((SALT39.StrType)le.e1_lname5),TRIM((SALT39.StrType)le.e1_suffix5),TRIM((SALT39.StrType)le.e1_pname5_score),TRIM((SALT39.StrType)le.e1_cname5),TRIM((SALT39.StrType)le.e2_title1),TRIM((SALT39.StrType)le.e2_fname1),TRIM((SALT39.StrType)le.e2_mname1),TRIM((SALT39.StrType)le.e2_lname1),TRIM((SALT39.StrType)le.e2_suffix1),TRIM((SALT39.StrType)le.e2_pname1_score),TRIM((SALT39.StrType)le.e2_cname1),TRIM((SALT39.StrType)le.e2_title2),TRIM((SALT39.StrType)le.e2_fname2),TRIM((SALT39.StrType)le.e2_mname2),TRIM((SALT39.StrType)le.e2_lname2),TRIM((SALT39.StrType)le.e2_suffix2),TRIM((SALT39.StrType)le.e2_pname2_score),TRIM((SALT39.StrType)le.e2_cname2),TRIM((SALT39.StrType)le.e2_title3),TRIM((SALT39.StrType)le.e2_fname3),TRIM((SALT39.StrType)le.e2_mname3),TRIM((SALT39.StrType)le.e2_lname3),TRIM((SALT39.StrType)le.e2_suffix3),TRIM((SALT39.StrType)le.e2_pname3_score),TRIM((SALT39.StrType)le.e2_cname3),TRIM((SALT39.StrType)le.e2_title4),TRIM((SALT39.StrType)le.e2_fname4),TRIM((SALT39.StrType)le.e2_mname4),TRIM((SALT39.StrType)le.e2_lname4),TRIM((SALT39.StrType)le.e2_suffix4),TRIM((SALT39.StrType)le.e2_pname4_score),TRIM((SALT39.StrType)le.e2_cname4),TRIM((SALT39.StrType)le.e2_title5),TRIM((SALT39.StrType)le.e2_fname5),TRIM((SALT39.StrType)le.e2_mname5),TRIM((SALT39.StrType)le.e2_lname5),TRIM((SALT39.StrType)le.e2_suffix5),TRIM((SALT39.StrType)le.e2_pname5_score),TRIM((SALT39.StrType)le.e2_cname5),TRIM((SALT39.StrType)le.v1_title1),TRIM((SALT39.StrType)le.v1_fname1),TRIM((SALT39.StrType)le.v1_mname1),TRIM((SALT39.StrType)le.v1_lname1),TRIM((SALT39.StrType)le.v1_suffix1),TRIM((SALT39.StrType)le.v1_pname1_score),TRIM((SALT39.StrType)le.v1_cname1),TRIM((SALT39.StrType)le.v1_title2),TRIM((SALT39.StrType)le.v1_fname2),TRIM((SALT39.StrType)le.v1_mname2),TRIM((SALT39.StrType)le.v1_lname2),TRIM((SALT39.StrType)le.v1_suffix2),TRIM((SALT39.StrType)le.v1_pname2_score),TRIM((SALT39.StrType)le.v1_cname2),TRIM((SALT39.StrType)le.v1_title3),TRIM((SALT39.StrType)le.v1_fname3),TRIM((SALT39.StrType)le.v1_mname3),TRIM((SALT39.StrType)le.v1_lname3),TRIM((SALT39.StrType)le.v1_suffix3),TRIM((SALT39.StrType)le.v1_pname3_score),TRIM((SALT39.StrType)le.v1_cname3),TRIM((SALT39.StrType)le.v1_title4),TRIM((SALT39.StrType)le.v1_fname4),TRIM((SALT39.StrType)le.v1_mname4),TRIM((SALT39.StrType)le.v1_lname4),TRIM((SALT39.StrType)le.v1_suffix4),TRIM((SALT39.StrType)le.v1_pname4_score),TRIM((SALT39.StrType)le.v1_cname4),TRIM((SALT39.StrType)le.v1_title5),TRIM((SALT39.StrType)le.v1_fname5),TRIM((SALT39.StrType)le.v1_mname5),TRIM((SALT39.StrType)le.v1_lname5),TRIM((SALT39.StrType)le.v1_suffix5),TRIM((SALT39.StrType)le.v1_pname5_score),TRIM((SALT39.StrType)le.v1_cname5),TRIM((SALT39.StrType)le.v2_title1),TRIM((SALT39.StrType)le.v2_fname1),TRIM((SALT39.StrType)le.v2_mname1),TRIM((SALT39.StrType)le.v2_lname1),TRIM((SALT39.StrType)le.v2_suffix1),TRIM((SALT39.StrType)le.v2_pname1_score),TRIM((SALT39.StrType)le.v2_cname1),TRIM((SALT39.StrType)le.v2_title2),TRIM((SALT39.StrType)le.v2_fname2),TRIM((SALT39.StrType)le.v2_mname2),TRIM((SALT39.StrType)le.v2_lname2),TRIM((SALT39.StrType)le.v2_suffix2),TRIM((SALT39.StrType)le.v2_pname2_score),TRIM((SALT39.StrType)le.v2_cname2),TRIM((SALT39.StrType)le.v2_title3),TRIM((SALT39.StrType)le.v2_fname3),TRIM((SALT39.StrType)le.v2_mname3),TRIM((SALT39.StrType)le.v2_lname3),TRIM((SALT39.StrType)le.v2_suffix3),TRIM((SALT39.StrType)le.v2_pname3_score),TRIM((SALT39.StrType)le.v2_cname3),TRIM((SALT39.StrType)le.v2_title4),TRIM((SALT39.StrType)le.v2_fname4),TRIM((SALT39.StrType)le.v2_mname4),TRIM((SALT39.StrType)le.v2_lname4),TRIM((SALT39.StrType)le.v2_suffix4),TRIM((SALT39.StrType)le.v2_pname4_score),TRIM((SALT39.StrType)le.v2_cname4),TRIM((SALT39.StrType)le.v2_title5),TRIM((SALT39.StrType)le.v2_fname5),TRIM((SALT39.StrType)le.v2_mname5),TRIM((SALT39.StrType)le.v2_lname5),TRIM((SALT39.StrType)le.v2_suffix5),TRIM((SALT39.StrType)le.v2_pname5_score),TRIM((SALT39.StrType)le.v2_cname5)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.dt_first_reported),TRIM((SALT39.StrType)le.dt_last_reported),TRIM((SALT39.StrType)le.process_date),TRIM((SALT39.StrType)le.vendor),TRIM((SALT39.StrType)le.state_origin),TRIM((SALT39.StrType)le.source_file),TRIM((SALT39.StrType)le.case_key),TRIM((SALT39.StrType)le.parent_case_key),TRIM((SALT39.StrType)le.court_code),TRIM((SALT39.StrType)le.court),TRIM((SALT39.StrType)le.case_number),TRIM((SALT39.StrType)le.case_type_code),TRIM((SALT39.StrType)le.case_type),TRIM((SALT39.StrType)le.case_title),TRIM((SALT39.StrType)le.ruled_for_against_code),TRIM((SALT39.StrType)le.ruled_for_against),TRIM((SALT39.StrType)le.entity_1),TRIM((SALT39.StrType)le.entity_nm_format_1),TRIM((SALT39.StrType)le.entity_type_code_1_orig),TRIM((SALT39.StrType)le.entity_type_description_1_orig),TRIM((SALT39.StrType)le.entity_type_code_1_master),TRIM((SALT39.StrType)le.entity_seq_num_1),TRIM((SALT39.StrType)le.atty_seq_num_1),TRIM((SALT39.StrType)le.entity_1_address_1),TRIM((SALT39.StrType)le.entity_1_address_2),TRIM((SALT39.StrType)le.entity_1_address_3),TRIM((SALT39.StrType)le.entity_1_address_4),TRIM((SALT39.StrType)le.entity_1_dob),TRIM((SALT39.StrType)le.primary_entity_2),TRIM((SALT39.StrType)le.entity_nm_format_2),TRIM((SALT39.StrType)le.entity_type_code_2_orig),TRIM((SALT39.StrType)le.entity_type_description_2_orig),TRIM((SALT39.StrType)le.entity_type_code_2_master),TRIM((SALT39.StrType)le.entity_seq_num_2),TRIM((SALT39.StrType)le.atty_seq_num_2),TRIM((SALT39.StrType)le.entity_2_address_1),TRIM((SALT39.StrType)le.entity_2_address_2),TRIM((SALT39.StrType)le.entity_2_address_3),TRIM((SALT39.StrType)le.entity_2_address_4),TRIM((SALT39.StrType)le.entity_2_dob),TRIM((SALT39.StrType)le.prim_range1),TRIM((SALT39.StrType)le.predir1),TRIM((SALT39.StrType)le.prim_name1),TRIM((SALT39.StrType)le.addr_suffix1),TRIM((SALT39.StrType)le.postdir1),TRIM((SALT39.StrType)le.unit_desig1),TRIM((SALT39.StrType)le.sec_range1),TRIM((SALT39.StrType)le.p_city_name1),TRIM((SALT39.StrType)le.v_city_name1),TRIM((SALT39.StrType)le.st1),TRIM((SALT39.StrType)le.zip1),TRIM((SALT39.StrType)le.zip41),TRIM((SALT39.StrType)le.cart1),TRIM((SALT39.StrType)le.cr_sort_sz1),TRIM((SALT39.StrType)le.lot1),TRIM((SALT39.StrType)le.lot_order1),TRIM((SALT39.StrType)le.dpbc1),TRIM((SALT39.StrType)le.chk_digit1),TRIM((SALT39.StrType)le.rec_type1),TRIM((SALT39.StrType)le.ace_fips_st1),TRIM((SALT39.StrType)le.ace_fips_county1),TRIM((SALT39.StrType)le.geo_lat1),TRIM((SALT39.StrType)le.geo_long1),TRIM((SALT39.StrType)le.msa1),TRIM((SALT39.StrType)le.geo_blk1),TRIM((SALT39.StrType)le.geo_match1),TRIM((SALT39.StrType)le.err_stat1),TRIM((SALT39.StrType)le.prim_range2),TRIM((SALT39.StrType)le.predir2),TRIM((SALT39.StrType)le.prim_name2),TRIM((SALT39.StrType)le.addr_suffix2),TRIM((SALT39.StrType)le.postdir2),TRIM((SALT39.StrType)le.unit_desig2),TRIM((SALT39.StrType)le.sec_range2),TRIM((SALT39.StrType)le.p_city_name2),TRIM((SALT39.StrType)le.v_city_name2),TRIM((SALT39.StrType)le.st2),TRIM((SALT39.StrType)le.zip2),TRIM((SALT39.StrType)le.zip42),TRIM((SALT39.StrType)le.cart2),TRIM((SALT39.StrType)le.cr_sort_sz2),TRIM((SALT39.StrType)le.lot2),TRIM((SALT39.StrType)le.lot_order2),TRIM((SALT39.StrType)le.dpbc2),TRIM((SALT39.StrType)le.chk_digit2),TRIM((SALT39.StrType)le.rec_type2),TRIM((SALT39.StrType)le.ace_fips_st2),TRIM((SALT39.StrType)le.ace_fips_county2),TRIM((SALT39.StrType)le.geo_lat2),TRIM((SALT39.StrType)le.geo_long2),TRIM((SALT39.StrType)le.msa2),TRIM((SALT39.StrType)le.geo_blk2),TRIM((SALT39.StrType)le.geo_match2),TRIM((SALT39.StrType)le.err_stat2),TRIM((SALT39.StrType)le.e1_title1),TRIM((SALT39.StrType)le.e1_fname1),TRIM((SALT39.StrType)le.e1_mname1),TRIM((SALT39.StrType)le.e1_lname1),TRIM((SALT39.StrType)le.e1_suffix1),TRIM((SALT39.StrType)le.e1_pname1_score),TRIM((SALT39.StrType)le.e1_cname1),TRIM((SALT39.StrType)le.e1_title2),TRIM((SALT39.StrType)le.e1_fname2),TRIM((SALT39.StrType)le.e1_mname2),TRIM((SALT39.StrType)le.e1_lname2),TRIM((SALT39.StrType)le.e1_suffix2),TRIM((SALT39.StrType)le.e1_pname2_score),TRIM((SALT39.StrType)le.e1_cname2),TRIM((SALT39.StrType)le.e1_title3),TRIM((SALT39.StrType)le.e1_fname3),TRIM((SALT39.StrType)le.e1_mname3),TRIM((SALT39.StrType)le.e1_lname3),TRIM((SALT39.StrType)le.e1_suffix3),TRIM((SALT39.StrType)le.e1_pname3_score),TRIM((SALT39.StrType)le.e1_cname3),TRIM((SALT39.StrType)le.e1_title4),TRIM((SALT39.StrType)le.e1_fname4),TRIM((SALT39.StrType)le.e1_mname4),TRIM((SALT39.StrType)le.e1_lname4),TRIM((SALT39.StrType)le.e1_suffix4),TRIM((SALT39.StrType)le.e1_pname4_score),TRIM((SALT39.StrType)le.e1_cname4),TRIM((SALT39.StrType)le.e1_title5),TRIM((SALT39.StrType)le.e1_fname5),TRIM((SALT39.StrType)le.e1_mname5),TRIM((SALT39.StrType)le.e1_lname5),TRIM((SALT39.StrType)le.e1_suffix5),TRIM((SALT39.StrType)le.e1_pname5_score),TRIM((SALT39.StrType)le.e1_cname5),TRIM((SALT39.StrType)le.e2_title1),TRIM((SALT39.StrType)le.e2_fname1),TRIM((SALT39.StrType)le.e2_mname1),TRIM((SALT39.StrType)le.e2_lname1),TRIM((SALT39.StrType)le.e2_suffix1),TRIM((SALT39.StrType)le.e2_pname1_score),TRIM((SALT39.StrType)le.e2_cname1),TRIM((SALT39.StrType)le.e2_title2),TRIM((SALT39.StrType)le.e2_fname2),TRIM((SALT39.StrType)le.e2_mname2),TRIM((SALT39.StrType)le.e2_lname2),TRIM((SALT39.StrType)le.e2_suffix2),TRIM((SALT39.StrType)le.e2_pname2_score),TRIM((SALT39.StrType)le.e2_cname2),TRIM((SALT39.StrType)le.e2_title3),TRIM((SALT39.StrType)le.e2_fname3),TRIM((SALT39.StrType)le.e2_mname3),TRIM((SALT39.StrType)le.e2_lname3),TRIM((SALT39.StrType)le.e2_suffix3),TRIM((SALT39.StrType)le.e2_pname3_score),TRIM((SALT39.StrType)le.e2_cname3),TRIM((SALT39.StrType)le.e2_title4),TRIM((SALT39.StrType)le.e2_fname4),TRIM((SALT39.StrType)le.e2_mname4),TRIM((SALT39.StrType)le.e2_lname4),TRIM((SALT39.StrType)le.e2_suffix4),TRIM((SALT39.StrType)le.e2_pname4_score),TRIM((SALT39.StrType)le.e2_cname4),TRIM((SALT39.StrType)le.e2_title5),TRIM((SALT39.StrType)le.e2_fname5),TRIM((SALT39.StrType)le.e2_mname5),TRIM((SALT39.StrType)le.e2_lname5),TRIM((SALT39.StrType)le.e2_suffix5),TRIM((SALT39.StrType)le.e2_pname5_score),TRIM((SALT39.StrType)le.e2_cname5),TRIM((SALT39.StrType)le.v1_title1),TRIM((SALT39.StrType)le.v1_fname1),TRIM((SALT39.StrType)le.v1_mname1),TRIM((SALT39.StrType)le.v1_lname1),TRIM((SALT39.StrType)le.v1_suffix1),TRIM((SALT39.StrType)le.v1_pname1_score),TRIM((SALT39.StrType)le.v1_cname1),TRIM((SALT39.StrType)le.v1_title2),TRIM((SALT39.StrType)le.v1_fname2),TRIM((SALT39.StrType)le.v1_mname2),TRIM((SALT39.StrType)le.v1_lname2),TRIM((SALT39.StrType)le.v1_suffix2),TRIM((SALT39.StrType)le.v1_pname2_score),TRIM((SALT39.StrType)le.v1_cname2),TRIM((SALT39.StrType)le.v1_title3),TRIM((SALT39.StrType)le.v1_fname3),TRIM((SALT39.StrType)le.v1_mname3),TRIM((SALT39.StrType)le.v1_lname3),TRIM((SALT39.StrType)le.v1_suffix3),TRIM((SALT39.StrType)le.v1_pname3_score),TRIM((SALT39.StrType)le.v1_cname3),TRIM((SALT39.StrType)le.v1_title4),TRIM((SALT39.StrType)le.v1_fname4),TRIM((SALT39.StrType)le.v1_mname4),TRIM((SALT39.StrType)le.v1_lname4),TRIM((SALT39.StrType)le.v1_suffix4),TRIM((SALT39.StrType)le.v1_pname4_score),TRIM((SALT39.StrType)le.v1_cname4),TRIM((SALT39.StrType)le.v1_title5),TRIM((SALT39.StrType)le.v1_fname5),TRIM((SALT39.StrType)le.v1_mname5),TRIM((SALT39.StrType)le.v1_lname5),TRIM((SALT39.StrType)le.v1_suffix5),TRIM((SALT39.StrType)le.v1_pname5_score),TRIM((SALT39.StrType)le.v1_cname5),TRIM((SALT39.StrType)le.v2_title1),TRIM((SALT39.StrType)le.v2_fname1),TRIM((SALT39.StrType)le.v2_mname1),TRIM((SALT39.StrType)le.v2_lname1),TRIM((SALT39.StrType)le.v2_suffix1),TRIM((SALT39.StrType)le.v2_pname1_score),TRIM((SALT39.StrType)le.v2_cname1),TRIM((SALT39.StrType)le.v2_title2),TRIM((SALT39.StrType)le.v2_fname2),TRIM((SALT39.StrType)le.v2_mname2),TRIM((SALT39.StrType)le.v2_lname2),TRIM((SALT39.StrType)le.v2_suffix2),TRIM((SALT39.StrType)le.v2_pname2_score),TRIM((SALT39.StrType)le.v2_cname2),TRIM((SALT39.StrType)le.v2_title3),TRIM((SALT39.StrType)le.v2_fname3),TRIM((SALT39.StrType)le.v2_mname3),TRIM((SALT39.StrType)le.v2_lname3),TRIM((SALT39.StrType)le.v2_suffix3),TRIM((SALT39.StrType)le.v2_pname3_score),TRIM((SALT39.StrType)le.v2_cname3),TRIM((SALT39.StrType)le.v2_title4),TRIM((SALT39.StrType)le.v2_fname4),TRIM((SALT39.StrType)le.v2_mname4),TRIM((SALT39.StrType)le.v2_lname4),TRIM((SALT39.StrType)le.v2_suffix4),TRIM((SALT39.StrType)le.v2_pname4_score),TRIM((SALT39.StrType)le.v2_cname4),TRIM((SALT39.StrType)le.v2_title5),TRIM((SALT39.StrType)le.v2_fname5),TRIM((SALT39.StrType)le.v2_mname5),TRIM((SALT39.StrType)le.v2_lname5),TRIM((SALT39.StrType)le.v2_suffix5),TRIM((SALT39.StrType)le.v2_pname5_score),TRIM((SALT39.StrType)le.v2_cname5)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),234*234,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_first_reported'}
      ,{2,'dt_last_reported'}
      ,{3,'process_date'}
      ,{4,'vendor'}
      ,{5,'state_origin'}
      ,{6,'source_file'}
      ,{7,'case_key'}
      ,{8,'parent_case_key'}
      ,{9,'court_code'}
      ,{10,'court'}
      ,{11,'case_number'}
      ,{12,'case_type_code'}
      ,{13,'case_type'}
      ,{14,'case_title'}
      ,{15,'ruled_for_against_code'}
      ,{16,'ruled_for_against'}
      ,{17,'entity_1'}
      ,{18,'entity_nm_format_1'}
      ,{19,'entity_type_code_1_orig'}
      ,{20,'entity_type_description_1_orig'}
      ,{21,'entity_type_code_1_master'}
      ,{22,'entity_seq_num_1'}
      ,{23,'atty_seq_num_1'}
      ,{24,'entity_1_address_1'}
      ,{25,'entity_1_address_2'}
      ,{26,'entity_1_address_3'}
      ,{27,'entity_1_address_4'}
      ,{28,'entity_1_dob'}
      ,{29,'primary_entity_2'}
      ,{30,'entity_nm_format_2'}
      ,{31,'entity_type_code_2_orig'}
      ,{32,'entity_type_description_2_orig'}
      ,{33,'entity_type_code_2_master'}
      ,{34,'entity_seq_num_2'}
      ,{35,'atty_seq_num_2'}
      ,{36,'entity_2_address_1'}
      ,{37,'entity_2_address_2'}
      ,{38,'entity_2_address_3'}
      ,{39,'entity_2_address_4'}
      ,{40,'entity_2_dob'}
      ,{41,'prim_range1'}
      ,{42,'predir1'}
      ,{43,'prim_name1'}
      ,{44,'addr_suffix1'}
      ,{45,'postdir1'}
      ,{46,'unit_desig1'}
      ,{47,'sec_range1'}
      ,{48,'p_city_name1'}
      ,{49,'v_city_name1'}
      ,{50,'st1'}
      ,{51,'zip1'}
      ,{52,'zip41'}
      ,{53,'cart1'}
      ,{54,'cr_sort_sz1'}
      ,{55,'lot1'}
      ,{56,'lot_order1'}
      ,{57,'dpbc1'}
      ,{58,'chk_digit1'}
      ,{59,'rec_type1'}
      ,{60,'ace_fips_st1'}
      ,{61,'ace_fips_county1'}
      ,{62,'geo_lat1'}
      ,{63,'geo_long1'}
      ,{64,'msa1'}
      ,{65,'geo_blk1'}
      ,{66,'geo_match1'}
      ,{67,'err_stat1'}
      ,{68,'prim_range2'}
      ,{69,'predir2'}
      ,{70,'prim_name2'}
      ,{71,'addr_suffix2'}
      ,{72,'postdir2'}
      ,{73,'unit_desig2'}
      ,{74,'sec_range2'}
      ,{75,'p_city_name2'}
      ,{76,'v_city_name2'}
      ,{77,'st2'}
      ,{78,'zip2'}
      ,{79,'zip42'}
      ,{80,'cart2'}
      ,{81,'cr_sort_sz2'}
      ,{82,'lot2'}
      ,{83,'lot_order2'}
      ,{84,'dpbc2'}
      ,{85,'chk_digit2'}
      ,{86,'rec_type2'}
      ,{87,'ace_fips_st2'}
      ,{88,'ace_fips_county2'}
      ,{89,'geo_lat2'}
      ,{90,'geo_long2'}
      ,{91,'msa2'}
      ,{92,'geo_blk2'}
      ,{93,'geo_match2'}
      ,{94,'err_stat2'}
      ,{95,'e1_title1'}
      ,{96,'e1_fname1'}
      ,{97,'e1_mname1'}
      ,{98,'e1_lname1'}
      ,{99,'e1_suffix1'}
      ,{100,'e1_pname1_score'}
      ,{101,'e1_cname1'}
      ,{102,'e1_title2'}
      ,{103,'e1_fname2'}
      ,{104,'e1_mname2'}
      ,{105,'e1_lname2'}
      ,{106,'e1_suffix2'}
      ,{107,'e1_pname2_score'}
      ,{108,'e1_cname2'}
      ,{109,'e1_title3'}
      ,{110,'e1_fname3'}
      ,{111,'e1_mname3'}
      ,{112,'e1_lname3'}
      ,{113,'e1_suffix3'}
      ,{114,'e1_pname3_score'}
      ,{115,'e1_cname3'}
      ,{116,'e1_title4'}
      ,{117,'e1_fname4'}
      ,{118,'e1_mname4'}
      ,{119,'e1_lname4'}
      ,{120,'e1_suffix4'}
      ,{121,'e1_pname4_score'}
      ,{122,'e1_cname4'}
      ,{123,'e1_title5'}
      ,{124,'e1_fname5'}
      ,{125,'e1_mname5'}
      ,{126,'e1_lname5'}
      ,{127,'e1_suffix5'}
      ,{128,'e1_pname5_score'}
      ,{129,'e1_cname5'}
      ,{130,'e2_title1'}
      ,{131,'e2_fname1'}
      ,{132,'e2_mname1'}
      ,{133,'e2_lname1'}
      ,{134,'e2_suffix1'}
      ,{135,'e2_pname1_score'}
      ,{136,'e2_cname1'}
      ,{137,'e2_title2'}
      ,{138,'e2_fname2'}
      ,{139,'e2_mname2'}
      ,{140,'e2_lname2'}
      ,{141,'e2_suffix2'}
      ,{142,'e2_pname2_score'}
      ,{143,'e2_cname2'}
      ,{144,'e2_title3'}
      ,{145,'e2_fname3'}
      ,{146,'e2_mname3'}
      ,{147,'e2_lname3'}
      ,{148,'e2_suffix3'}
      ,{149,'e2_pname3_score'}
      ,{150,'e2_cname3'}
      ,{151,'e2_title4'}
      ,{152,'e2_fname4'}
      ,{153,'e2_mname4'}
      ,{154,'e2_lname4'}
      ,{155,'e2_suffix4'}
      ,{156,'e2_pname4_score'}
      ,{157,'e2_cname4'}
      ,{158,'e2_title5'}
      ,{159,'e2_fname5'}
      ,{160,'e2_mname5'}
      ,{161,'e2_lname5'}
      ,{162,'e2_suffix5'}
      ,{163,'e2_pname5_score'}
      ,{164,'e2_cname5'}
      ,{165,'v1_title1'}
      ,{166,'v1_fname1'}
      ,{167,'v1_mname1'}
      ,{168,'v1_lname1'}
      ,{169,'v1_suffix1'}
      ,{170,'v1_pname1_score'}
      ,{171,'v1_cname1'}
      ,{172,'v1_title2'}
      ,{173,'v1_fname2'}
      ,{174,'v1_mname2'}
      ,{175,'v1_lname2'}
      ,{176,'v1_suffix2'}
      ,{177,'v1_pname2_score'}
      ,{178,'v1_cname2'}
      ,{179,'v1_title3'}
      ,{180,'v1_fname3'}
      ,{181,'v1_mname3'}
      ,{182,'v1_lname3'}
      ,{183,'v1_suffix3'}
      ,{184,'v1_pname3_score'}
      ,{185,'v1_cname3'}
      ,{186,'v1_title4'}
      ,{187,'v1_fname4'}
      ,{188,'v1_mname4'}
      ,{189,'v1_lname4'}
      ,{190,'v1_suffix4'}
      ,{191,'v1_pname4_score'}
      ,{192,'v1_cname4'}
      ,{193,'v1_title5'}
      ,{194,'v1_fname5'}
      ,{195,'v1_mname5'}
      ,{196,'v1_lname5'}
      ,{197,'v1_suffix5'}
      ,{198,'v1_pname5_score'}
      ,{199,'v1_cname5'}
      ,{200,'v2_title1'}
      ,{201,'v2_fname1'}
      ,{202,'v2_mname1'}
      ,{203,'v2_lname1'}
      ,{204,'v2_suffix1'}
      ,{205,'v2_pname1_score'}
      ,{206,'v2_cname1'}
      ,{207,'v2_title2'}
      ,{208,'v2_fname2'}
      ,{209,'v2_mname2'}
      ,{210,'v2_lname2'}
      ,{211,'v2_suffix2'}
      ,{212,'v2_pname2_score'}
      ,{213,'v2_cname2'}
      ,{214,'v2_title3'}
      ,{215,'v2_fname3'}
      ,{216,'v2_mname3'}
      ,{217,'v2_lname3'}
      ,{218,'v2_suffix3'}
      ,{219,'v2_pname3_score'}
      ,{220,'v2_cname3'}
      ,{221,'v2_title4'}
      ,{222,'v2_fname4'}
      ,{223,'v2_mname4'}
      ,{224,'v2_lname4'}
      ,{225,'v2_suffix4'}
      ,{226,'v2_pname4_score'}
      ,{227,'v2_cname4'}
      ,{228,'v2_title5'}
      ,{229,'v2_fname5'}
      ,{230,'v2_mname5'}
      ,{231,'v2_lname5'}
      ,{232,'v2_suffix5'}
      ,{233,'v2_pname5_score'}
      ,{234,'v2_cname5'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Party_Fields.InValid_dt_first_reported((SALT39.StrType)le.dt_first_reported),
    Party_Fields.InValid_dt_last_reported((SALT39.StrType)le.dt_last_reported),
    Party_Fields.InValid_process_date((SALT39.StrType)le.process_date),
    Party_Fields.InValid_vendor((SALT39.StrType)le.vendor),
    Party_Fields.InValid_state_origin((SALT39.StrType)le.state_origin),
    Party_Fields.InValid_source_file((SALT39.StrType)le.source_file),
    Party_Fields.InValid_case_key((SALT39.StrType)le.case_key),
    Party_Fields.InValid_parent_case_key((SALT39.StrType)le.parent_case_key),
    Party_Fields.InValid_court_code((SALT39.StrType)le.court_code),
    Party_Fields.InValid_court((SALT39.StrType)le.court),
    Party_Fields.InValid_case_number((SALT39.StrType)le.case_number),
    Party_Fields.InValid_case_type_code((SALT39.StrType)le.case_type_code),
    Party_Fields.InValid_case_type((SALT39.StrType)le.case_type),
    Party_Fields.InValid_case_title((SALT39.StrType)le.case_title),
    Party_Fields.InValid_ruled_for_against_code((SALT39.StrType)le.ruled_for_against_code),
    Party_Fields.InValid_ruled_for_against((SALT39.StrType)le.ruled_for_against),
    Party_Fields.InValid_entity_1((SALT39.StrType)le.entity_1),
    Party_Fields.InValid_entity_nm_format_1((SALT39.StrType)le.entity_nm_format_1),
    Party_Fields.InValid_entity_type_code_1_orig((SALT39.StrType)le.entity_type_code_1_orig),
    Party_Fields.InValid_entity_type_description_1_orig((SALT39.StrType)le.entity_type_description_1_orig),
    Party_Fields.InValid_entity_type_code_1_master((SALT39.StrType)le.entity_type_code_1_master),
    Party_Fields.InValid_entity_seq_num_1((SALT39.StrType)le.entity_seq_num_1),
    Party_Fields.InValid_atty_seq_num_1((SALT39.StrType)le.atty_seq_num_1),
    Party_Fields.InValid_entity_1_address_1((SALT39.StrType)le.entity_1_address_1),
    Party_Fields.InValid_entity_1_address_2((SALT39.StrType)le.entity_1_address_2),
    Party_Fields.InValid_entity_1_address_3((SALT39.StrType)le.entity_1_address_3),
    Party_Fields.InValid_entity_1_address_4((SALT39.StrType)le.entity_1_address_4),
    Party_Fields.InValid_entity_1_dob((SALT39.StrType)le.entity_1_dob),
    Party_Fields.InValid_primary_entity_2((SALT39.StrType)le.primary_entity_2),
    Party_Fields.InValid_entity_nm_format_2((SALT39.StrType)le.entity_nm_format_2),
    Party_Fields.InValid_entity_type_code_2_orig((SALT39.StrType)le.entity_type_code_2_orig),
    Party_Fields.InValid_entity_type_description_2_orig((SALT39.StrType)le.entity_type_description_2_orig),
    Party_Fields.InValid_entity_type_code_2_master((SALT39.StrType)le.entity_type_code_2_master),
    Party_Fields.InValid_entity_seq_num_2((SALT39.StrType)le.entity_seq_num_2),
    Party_Fields.InValid_atty_seq_num_2((SALT39.StrType)le.atty_seq_num_2),
    Party_Fields.InValid_entity_2_address_1((SALT39.StrType)le.entity_2_address_1),
    Party_Fields.InValid_entity_2_address_2((SALT39.StrType)le.entity_2_address_2),
    Party_Fields.InValid_entity_2_address_3((SALT39.StrType)le.entity_2_address_3),
    Party_Fields.InValid_entity_2_address_4((SALT39.StrType)le.entity_2_address_4),
    Party_Fields.InValid_entity_2_dob((SALT39.StrType)le.entity_2_dob),
    Party_Fields.InValid_prim_range1((SALT39.StrType)le.prim_range1),
    Party_Fields.InValid_predir1((SALT39.StrType)le.predir1),
    Party_Fields.InValid_prim_name1((SALT39.StrType)le.prim_name1),
    Party_Fields.InValid_addr_suffix1((SALT39.StrType)le.addr_suffix1),
    Party_Fields.InValid_postdir1((SALT39.StrType)le.postdir1),
    Party_Fields.InValid_unit_desig1((SALT39.StrType)le.unit_desig1),
    Party_Fields.InValid_sec_range1((SALT39.StrType)le.sec_range1),
    Party_Fields.InValid_p_city_name1((SALT39.StrType)le.p_city_name1),
    Party_Fields.InValid_v_city_name1((SALT39.StrType)le.v_city_name1),
    Party_Fields.InValid_st1((SALT39.StrType)le.st1),
    Party_Fields.InValid_zip1((SALT39.StrType)le.zip1),
    Party_Fields.InValid_zip41((SALT39.StrType)le.zip41),
    Party_Fields.InValid_cart1((SALT39.StrType)le.cart1),
    Party_Fields.InValid_cr_sort_sz1((SALT39.StrType)le.cr_sort_sz1),
    Party_Fields.InValid_lot1((SALT39.StrType)le.lot1),
    Party_Fields.InValid_lot_order1((SALT39.StrType)le.lot_order1),
    Party_Fields.InValid_dpbc1((SALT39.StrType)le.dpbc1),
    Party_Fields.InValid_chk_digit1((SALT39.StrType)le.chk_digit1),
    Party_Fields.InValid_rec_type1((SALT39.StrType)le.rec_type1),
    Party_Fields.InValid_ace_fips_st1((SALT39.StrType)le.ace_fips_st1),
    Party_Fields.InValid_ace_fips_county1((SALT39.StrType)le.ace_fips_county1),
    Party_Fields.InValid_geo_lat1((SALT39.StrType)le.geo_lat1),
    Party_Fields.InValid_geo_long1((SALT39.StrType)le.geo_long1),
    Party_Fields.InValid_msa1((SALT39.StrType)le.msa1),
    Party_Fields.InValid_geo_blk1((SALT39.StrType)le.geo_blk1),
    Party_Fields.InValid_geo_match1((SALT39.StrType)le.geo_match1),
    Party_Fields.InValid_err_stat1((SALT39.StrType)le.err_stat1),
    Party_Fields.InValid_prim_range2((SALT39.StrType)le.prim_range2),
    Party_Fields.InValid_predir2((SALT39.StrType)le.predir2),
    Party_Fields.InValid_prim_name2((SALT39.StrType)le.prim_name2),
    Party_Fields.InValid_addr_suffix2((SALT39.StrType)le.addr_suffix2),
    Party_Fields.InValid_postdir2((SALT39.StrType)le.postdir2),
    Party_Fields.InValid_unit_desig2((SALT39.StrType)le.unit_desig2),
    Party_Fields.InValid_sec_range2((SALT39.StrType)le.sec_range2),
    Party_Fields.InValid_p_city_name2((SALT39.StrType)le.p_city_name2),
    Party_Fields.InValid_v_city_name2((SALT39.StrType)le.v_city_name2),
    Party_Fields.InValid_st2((SALT39.StrType)le.st2),
    Party_Fields.InValid_zip2((SALT39.StrType)le.zip2),
    Party_Fields.InValid_zip42((SALT39.StrType)le.zip42),
    Party_Fields.InValid_cart2((SALT39.StrType)le.cart2),
    Party_Fields.InValid_cr_sort_sz2((SALT39.StrType)le.cr_sort_sz2),
    Party_Fields.InValid_lot2((SALT39.StrType)le.lot2),
    Party_Fields.InValid_lot_order2((SALT39.StrType)le.lot_order2),
    Party_Fields.InValid_dpbc2((SALT39.StrType)le.dpbc2),
    Party_Fields.InValid_chk_digit2((SALT39.StrType)le.chk_digit2),
    Party_Fields.InValid_rec_type2((SALT39.StrType)le.rec_type2),
    Party_Fields.InValid_ace_fips_st2((SALT39.StrType)le.ace_fips_st2),
    Party_Fields.InValid_ace_fips_county2((SALT39.StrType)le.ace_fips_county2),
    Party_Fields.InValid_geo_lat2((SALT39.StrType)le.geo_lat2),
    Party_Fields.InValid_geo_long2((SALT39.StrType)le.geo_long2),
    Party_Fields.InValid_msa2((SALT39.StrType)le.msa2),
    Party_Fields.InValid_geo_blk2((SALT39.StrType)le.geo_blk2),
    Party_Fields.InValid_geo_match2((SALT39.StrType)le.geo_match2),
    Party_Fields.InValid_err_stat2((SALT39.StrType)le.err_stat2),
    Party_Fields.InValid_e1_title1((SALT39.StrType)le.e1_title1),
    Party_Fields.InValid_e1_fname1((SALT39.StrType)le.e1_fname1),
    Party_Fields.InValid_e1_mname1((SALT39.StrType)le.e1_mname1),
    Party_Fields.InValid_e1_lname1((SALT39.StrType)le.e1_lname1),
    Party_Fields.InValid_e1_suffix1((SALT39.StrType)le.e1_suffix1),
    Party_Fields.InValid_e1_pname1_score((SALT39.StrType)le.e1_pname1_score),
    Party_Fields.InValid_e1_cname1((SALT39.StrType)le.e1_cname1),
    Party_Fields.InValid_e1_title2((SALT39.StrType)le.e1_title2),
    Party_Fields.InValid_e1_fname2((SALT39.StrType)le.e1_fname2),
    Party_Fields.InValid_e1_mname2((SALT39.StrType)le.e1_mname2),
    Party_Fields.InValid_e1_lname2((SALT39.StrType)le.e1_lname2),
    Party_Fields.InValid_e1_suffix2((SALT39.StrType)le.e1_suffix2),
    Party_Fields.InValid_e1_pname2_score((SALT39.StrType)le.e1_pname2_score),
    Party_Fields.InValid_e1_cname2((SALT39.StrType)le.e1_cname2),
    Party_Fields.InValid_e1_title3((SALT39.StrType)le.e1_title3),
    Party_Fields.InValid_e1_fname3((SALT39.StrType)le.e1_fname3),
    Party_Fields.InValid_e1_mname3((SALT39.StrType)le.e1_mname3),
    Party_Fields.InValid_e1_lname3((SALT39.StrType)le.e1_lname3),
    Party_Fields.InValid_e1_suffix3((SALT39.StrType)le.e1_suffix3),
    Party_Fields.InValid_e1_pname3_score((SALT39.StrType)le.e1_pname3_score),
    Party_Fields.InValid_e1_cname3((SALT39.StrType)le.e1_cname3),
    Party_Fields.InValid_e1_title4((SALT39.StrType)le.e1_title4),
    Party_Fields.InValid_e1_fname4((SALT39.StrType)le.e1_fname4),
    Party_Fields.InValid_e1_mname4((SALT39.StrType)le.e1_mname4),
    Party_Fields.InValid_e1_lname4((SALT39.StrType)le.e1_lname4),
    Party_Fields.InValid_e1_suffix4((SALT39.StrType)le.e1_suffix4),
    Party_Fields.InValid_e1_pname4_score((SALT39.StrType)le.e1_pname4_score),
    Party_Fields.InValid_e1_cname4((SALT39.StrType)le.e1_cname4),
    Party_Fields.InValid_e1_title5((SALT39.StrType)le.e1_title5),
    Party_Fields.InValid_e1_fname5((SALT39.StrType)le.e1_fname5),
    Party_Fields.InValid_e1_mname5((SALT39.StrType)le.e1_mname5),
    Party_Fields.InValid_e1_lname5((SALT39.StrType)le.e1_lname5),
    Party_Fields.InValid_e1_suffix5((SALT39.StrType)le.e1_suffix5),
    Party_Fields.InValid_e1_pname5_score((SALT39.StrType)le.e1_pname5_score),
    Party_Fields.InValid_e1_cname5((SALT39.StrType)le.e1_cname5),
    Party_Fields.InValid_e2_title1((SALT39.StrType)le.e2_title1),
    Party_Fields.InValid_e2_fname1((SALT39.StrType)le.e2_fname1),
    Party_Fields.InValid_e2_mname1((SALT39.StrType)le.e2_mname1),
    Party_Fields.InValid_e2_lname1((SALT39.StrType)le.e2_lname1),
    Party_Fields.InValid_e2_suffix1((SALT39.StrType)le.e2_suffix1),
    Party_Fields.InValid_e2_pname1_score((SALT39.StrType)le.e2_pname1_score),
    Party_Fields.InValid_e2_cname1((SALT39.StrType)le.e2_cname1),
    Party_Fields.InValid_e2_title2((SALT39.StrType)le.e2_title2),
    Party_Fields.InValid_e2_fname2((SALT39.StrType)le.e2_fname2),
    Party_Fields.InValid_e2_mname2((SALT39.StrType)le.e2_mname2),
    Party_Fields.InValid_e2_lname2((SALT39.StrType)le.e2_lname2),
    Party_Fields.InValid_e2_suffix2((SALT39.StrType)le.e2_suffix2),
    Party_Fields.InValid_e2_pname2_score((SALT39.StrType)le.e2_pname2_score),
    Party_Fields.InValid_e2_cname2((SALT39.StrType)le.e2_cname2),
    Party_Fields.InValid_e2_title3((SALT39.StrType)le.e2_title3),
    Party_Fields.InValid_e2_fname3((SALT39.StrType)le.e2_fname3),
    Party_Fields.InValid_e2_mname3((SALT39.StrType)le.e2_mname3),
    Party_Fields.InValid_e2_lname3((SALT39.StrType)le.e2_lname3),
    Party_Fields.InValid_e2_suffix3((SALT39.StrType)le.e2_suffix3),
    Party_Fields.InValid_e2_pname3_score((SALT39.StrType)le.e2_pname3_score),
    Party_Fields.InValid_e2_cname3((SALT39.StrType)le.e2_cname3),
    Party_Fields.InValid_e2_title4((SALT39.StrType)le.e2_title4),
    Party_Fields.InValid_e2_fname4((SALT39.StrType)le.e2_fname4),
    Party_Fields.InValid_e2_mname4((SALT39.StrType)le.e2_mname4),
    Party_Fields.InValid_e2_lname4((SALT39.StrType)le.e2_lname4),
    Party_Fields.InValid_e2_suffix4((SALT39.StrType)le.e2_suffix4),
    Party_Fields.InValid_e2_pname4_score((SALT39.StrType)le.e2_pname4_score),
    Party_Fields.InValid_e2_cname4((SALT39.StrType)le.e2_cname4),
    Party_Fields.InValid_e2_title5((SALT39.StrType)le.e2_title5),
    Party_Fields.InValid_e2_fname5((SALT39.StrType)le.e2_fname5),
    Party_Fields.InValid_e2_mname5((SALT39.StrType)le.e2_mname5),
    Party_Fields.InValid_e2_lname5((SALT39.StrType)le.e2_lname5),
    Party_Fields.InValid_e2_suffix5((SALT39.StrType)le.e2_suffix5),
    Party_Fields.InValid_e2_pname5_score((SALT39.StrType)le.e2_pname5_score),
    Party_Fields.InValid_e2_cname5((SALT39.StrType)le.e2_cname5),
    Party_Fields.InValid_v1_title1((SALT39.StrType)le.v1_title1),
    Party_Fields.InValid_v1_fname1((SALT39.StrType)le.v1_fname1),
    Party_Fields.InValid_v1_mname1((SALT39.StrType)le.v1_mname1),
    Party_Fields.InValid_v1_lname1((SALT39.StrType)le.v1_lname1),
    Party_Fields.InValid_v1_suffix1((SALT39.StrType)le.v1_suffix1),
    Party_Fields.InValid_v1_pname1_score((SALT39.StrType)le.v1_pname1_score),
    Party_Fields.InValid_v1_cname1((SALT39.StrType)le.v1_cname1),
    Party_Fields.InValid_v1_title2((SALT39.StrType)le.v1_title2),
    Party_Fields.InValid_v1_fname2((SALT39.StrType)le.v1_fname2),
    Party_Fields.InValid_v1_mname2((SALT39.StrType)le.v1_mname2),
    Party_Fields.InValid_v1_lname2((SALT39.StrType)le.v1_lname2),
    Party_Fields.InValid_v1_suffix2((SALT39.StrType)le.v1_suffix2),
    Party_Fields.InValid_v1_pname2_score((SALT39.StrType)le.v1_pname2_score),
    Party_Fields.InValid_v1_cname2((SALT39.StrType)le.v1_cname2),
    Party_Fields.InValid_v1_title3((SALT39.StrType)le.v1_title3),
    Party_Fields.InValid_v1_fname3((SALT39.StrType)le.v1_fname3),
    Party_Fields.InValid_v1_mname3((SALT39.StrType)le.v1_mname3),
    Party_Fields.InValid_v1_lname3((SALT39.StrType)le.v1_lname3),
    Party_Fields.InValid_v1_suffix3((SALT39.StrType)le.v1_suffix3),
    Party_Fields.InValid_v1_pname3_score((SALT39.StrType)le.v1_pname3_score),
    Party_Fields.InValid_v1_cname3((SALT39.StrType)le.v1_cname3),
    Party_Fields.InValid_v1_title4((SALT39.StrType)le.v1_title4),
    Party_Fields.InValid_v1_fname4((SALT39.StrType)le.v1_fname4),
    Party_Fields.InValid_v1_mname4((SALT39.StrType)le.v1_mname4),
    Party_Fields.InValid_v1_lname4((SALT39.StrType)le.v1_lname4),
    Party_Fields.InValid_v1_suffix4((SALT39.StrType)le.v1_suffix4),
    Party_Fields.InValid_v1_pname4_score((SALT39.StrType)le.v1_pname4_score),
    Party_Fields.InValid_v1_cname4((SALT39.StrType)le.v1_cname4),
    Party_Fields.InValid_v1_title5((SALT39.StrType)le.v1_title5),
    Party_Fields.InValid_v1_fname5((SALT39.StrType)le.v1_fname5),
    Party_Fields.InValid_v1_mname5((SALT39.StrType)le.v1_mname5),
    Party_Fields.InValid_v1_lname5((SALT39.StrType)le.v1_lname5),
    Party_Fields.InValid_v1_suffix5((SALT39.StrType)le.v1_suffix5),
    Party_Fields.InValid_v1_pname5_score((SALT39.StrType)le.v1_pname5_score),
    Party_Fields.InValid_v1_cname5((SALT39.StrType)le.v1_cname5),
    Party_Fields.InValid_v2_title1((SALT39.StrType)le.v2_title1),
    Party_Fields.InValid_v2_fname1((SALT39.StrType)le.v2_fname1),
    Party_Fields.InValid_v2_mname1((SALT39.StrType)le.v2_mname1),
    Party_Fields.InValid_v2_lname1((SALT39.StrType)le.v2_lname1),
    Party_Fields.InValid_v2_suffix1((SALT39.StrType)le.v2_suffix1),
    Party_Fields.InValid_v2_pname1_score((SALT39.StrType)le.v2_pname1_score),
    Party_Fields.InValid_v2_cname1((SALT39.StrType)le.v2_cname1),
    Party_Fields.InValid_v2_title2((SALT39.StrType)le.v2_title2),
    Party_Fields.InValid_v2_fname2((SALT39.StrType)le.v2_fname2),
    Party_Fields.InValid_v2_mname2((SALT39.StrType)le.v2_mname2),
    Party_Fields.InValid_v2_lname2((SALT39.StrType)le.v2_lname2),
    Party_Fields.InValid_v2_suffix2((SALT39.StrType)le.v2_suffix2),
    Party_Fields.InValid_v2_pname2_score((SALT39.StrType)le.v2_pname2_score),
    Party_Fields.InValid_v2_cname2((SALT39.StrType)le.v2_cname2),
    Party_Fields.InValid_v2_title3((SALT39.StrType)le.v2_title3),
    Party_Fields.InValid_v2_fname3((SALT39.StrType)le.v2_fname3),
    Party_Fields.InValid_v2_mname3((SALT39.StrType)le.v2_mname3),
    Party_Fields.InValid_v2_lname3((SALT39.StrType)le.v2_lname3),
    Party_Fields.InValid_v2_suffix3((SALT39.StrType)le.v2_suffix3),
    Party_Fields.InValid_v2_pname3_score((SALT39.StrType)le.v2_pname3_score),
    Party_Fields.InValid_v2_cname3((SALT39.StrType)le.v2_cname3),
    Party_Fields.InValid_v2_title4((SALT39.StrType)le.v2_title4),
    Party_Fields.InValid_v2_fname4((SALT39.StrType)le.v2_fname4),
    Party_Fields.InValid_v2_mname4((SALT39.StrType)le.v2_mname4),
    Party_Fields.InValid_v2_lname4((SALT39.StrType)le.v2_lname4),
    Party_Fields.InValid_v2_suffix4((SALT39.StrType)le.v2_suffix4),
    Party_Fields.InValid_v2_pname4_score((SALT39.StrType)le.v2_pname4_score),
    Party_Fields.InValid_v2_cname4((SALT39.StrType)le.v2_cname4),
    Party_Fields.InValid_v2_title5((SALT39.StrType)le.v2_title5),
    Party_Fields.InValid_v2_fname5((SALT39.StrType)le.v2_fname5),
    Party_Fields.InValid_v2_mname5((SALT39.StrType)le.v2_mname5),
    Party_Fields.InValid_v2_lname5((SALT39.StrType)le.v2_lname5),
    Party_Fields.InValid_v2_suffix5((SALT39.StrType)le.v2_suffix5),
    Party_Fields.InValid_v2_pname5_score((SALT39.StrType)le.v2_pname5_score),
    Party_Fields.InValid_v2_cname5((SALT39.StrType)le.v2_cname5),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,234,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Party_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Num','Invalid_Letter','Unknown','Invalid_Char','Invalid_Char','Invalid_Char','Unknown','Invalid_Char','Invalid_Char','Unknown','Unknown','Invalid_RuledAgainstCode','Unknown','Invalid_Char','Invalid_EntityNMFormat','Invalid_Char','Unknown','Invalid_Entity1TypeCode','Invalid_Num','Invalid_Num','Unknown','Unknown','Unknown','Unknown','Invalid_Num','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Party_Fields.InValidMessage_dt_first_reported(TotalErrors.ErrorNum),Party_Fields.InValidMessage_dt_last_reported(TotalErrors.ErrorNum),Party_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Party_Fields.InValidMessage_vendor(TotalErrors.ErrorNum),Party_Fields.InValidMessage_state_origin(TotalErrors.ErrorNum),Party_Fields.InValidMessage_source_file(TotalErrors.ErrorNum),Party_Fields.InValidMessage_case_key(TotalErrors.ErrorNum),Party_Fields.InValidMessage_parent_case_key(TotalErrors.ErrorNum),Party_Fields.InValidMessage_court_code(TotalErrors.ErrorNum),Party_Fields.InValidMessage_court(TotalErrors.ErrorNum),Party_Fields.InValidMessage_case_number(TotalErrors.ErrorNum),Party_Fields.InValidMessage_case_type_code(TotalErrors.ErrorNum),Party_Fields.InValidMessage_case_type(TotalErrors.ErrorNum),Party_Fields.InValidMessage_case_title(TotalErrors.ErrorNum),Party_Fields.InValidMessage_ruled_for_against_code(TotalErrors.ErrorNum),Party_Fields.InValidMessage_ruled_for_against(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_nm_format_1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_type_code_1_orig(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_type_description_1_orig(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_type_code_1_master(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_seq_num_1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_atty_seq_num_1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_1_address_1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_1_address_2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_1_address_3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_1_address_4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_1_dob(TotalErrors.ErrorNum),Party_Fields.InValidMessage_primary_entity_2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_nm_format_2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_type_code_2_orig(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_type_description_2_orig(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_type_code_2_master(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_seq_num_2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_atty_seq_num_2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_2_address_1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_2_address_2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_2_address_3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_2_address_4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_2_dob(TotalErrors.ErrorNum),Party_Fields.InValidMessage_prim_range1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_predir1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_prim_name1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_addr_suffix1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_postdir1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_unit_desig1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_sec_range1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_p_city_name1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v_city_name1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_st1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_zip1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_zip41(TotalErrors.ErrorNum),Party_Fields.InValidMessage_cart1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_cr_sort_sz1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_lot1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_lot_order1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_dpbc1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_chk_digit1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_rec_type1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_ace_fips_st1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_ace_fips_county1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_geo_lat1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_geo_long1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_msa1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_geo_blk1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_geo_match1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_err_stat1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_prim_range2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_predir2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_prim_name2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_addr_suffix2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_postdir2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_unit_desig2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_sec_range2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_p_city_name2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v_city_name2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_st2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_zip2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_zip42(TotalErrors.ErrorNum),Party_Fields.InValidMessage_cart2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_cr_sort_sz2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_lot2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_lot_order2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_dpbc2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_chk_digit2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_rec_type2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_ace_fips_st2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_ace_fips_county2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_geo_lat2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_geo_long2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_msa2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_geo_blk2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_geo_match2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_err_stat2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_title1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_fname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_mname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_lname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_suffix1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_pname1_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_cname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_title2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_fname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_mname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_lname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_suffix2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_pname2_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_cname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_title3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_fname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_mname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_lname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_suffix3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_pname3_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_cname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_title4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_fname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_mname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_lname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_suffix4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_pname4_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_cname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_title5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_fname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_mname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_lname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_suffix5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_pname5_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e1_cname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_title1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_fname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_mname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_lname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_suffix1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_pname1_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_cname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_title2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_fname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_mname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_lname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_suffix2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_pname2_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_cname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_title3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_fname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_mname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_lname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_suffix3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_pname3_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_cname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_title4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_fname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_mname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_lname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_suffix4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_pname4_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_cname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_title5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_fname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_mname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_lname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_suffix5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_pname5_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_e2_cname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_title1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_fname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_mname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_lname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_suffix1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_pname1_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_cname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_title2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_fname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_mname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_lname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_suffix2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_pname2_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_cname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_title3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_fname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_mname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_lname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_suffix3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_pname3_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_cname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_title4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_fname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_mname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_lname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_suffix4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_pname4_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_cname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_title5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_fname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_mname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_lname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_suffix5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_pname5_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v1_cname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_title1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_fname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_mname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_lname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_suffix1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_pname1_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_cname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_title2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_fname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_mname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_lname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_suffix2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_pname2_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_cname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_title3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_fname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_mname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_lname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_suffix3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_pname3_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_cname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_title4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_fname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_mname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_lname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_suffix4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_pname4_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_cname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_title5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_fname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_mname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_lname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_suffix5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_pname5_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_v2_cname5(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Civil_Court, Party_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

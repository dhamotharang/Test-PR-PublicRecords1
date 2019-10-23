IMPORT SALT311,STD;
EXPORT Base_5000_hygiene(dataset(Base_5000_layout_EBR) h) := MODULE
 
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
    populated_name_cnt := COUNT(GROUP,h.name <> (TYPEOF(h.name))'');
    populated_name_pcnt := AVE(GROUP,IF(h.name = (TYPEOF(h.name))'',0,100));
    maxlength_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name)));
    avelength_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name)),h.name<>(typeof(h.name))'');
    populated_street_address_cnt := COUNT(GROUP,h.street_address <> (TYPEOF(h.street_address))'');
    populated_street_address_pcnt := AVE(GROUP,IF(h.street_address = (TYPEOF(h.street_address))'',0,100));
    maxlength_street_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_address)));
    avelength_street_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_address)),h.street_address<>(typeof(h.street_address))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_code_cnt := COUNT(GROUP,h.state_code <> (TYPEOF(h.state_code))'');
    populated_state_code_pcnt := AVE(GROUP,IF(h.state_code = (TYPEOF(h.state_code))'',0,100));
    maxlength_state_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_code)));
    avelength_state_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_code)),h.state_code<>(typeof(h.state_code))'');
    populated_state_desc_cnt := COUNT(GROUP,h.state_desc <> (TYPEOF(h.state_desc))'');
    populated_state_desc_pcnt := AVE(GROUP,IF(h.state_desc = (TYPEOF(h.state_desc))'',0,100));
    maxlength_state_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_desc)));
    avelength_state_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_desc)),h.state_desc<>(typeof(h.state_desc))'');
    populated_zip_code_cnt := COUNT(GROUP,h.zip_code <> (TYPEOF(h.zip_code))'');
    populated_zip_code_pcnt := AVE(GROUP,IF(h.zip_code = (TYPEOF(h.zip_code))'',0,100));
    maxlength_zip_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_code)));
    avelength_zip_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_code)),h.zip_code<>(typeof(h.zip_code))'');
    populated_telephone_cnt := COUNT(GROUP,h.telephone <> (TYPEOF(h.telephone))'');
    populated_telephone_pcnt := AVE(GROUP,IF(h.telephone = (TYPEOF(h.telephone))'',0,100));
    maxlength_telephone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephone)));
    avelength_telephone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephone)),h.telephone<>(typeof(h.telephone))'');
    populated_relationship_code_cnt := COUNT(GROUP,h.relationship_code <> (TYPEOF(h.relationship_code))'');
    populated_relationship_code_pcnt := AVE(GROUP,IF(h.relationship_code = (TYPEOF(h.relationship_code))'',0,100));
    maxlength_relationship_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relationship_code)));
    avelength_relationship_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relationship_code)),h.relationship_code<>(typeof(h.relationship_code))'');
    populated_relationship_desc_cnt := COUNT(GROUP,h.relationship_desc <> (TYPEOF(h.relationship_desc))'');
    populated_relationship_desc_pcnt := AVE(GROUP,IF(h.relationship_desc = (TYPEOF(h.relationship_desc))'',0,100));
    maxlength_relationship_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relationship_desc)));
    avelength_relationship_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relationship_desc)),h.relationship_desc<>(typeof(h.relationship_desc))'');
    populated_bal_range_code_cnt := COUNT(GROUP,h.bal_range_code <> (TYPEOF(h.bal_range_code))'');
    populated_bal_range_code_pcnt := AVE(GROUP,IF(h.bal_range_code = (TYPEOF(h.bal_range_code))'',0,100));
    maxlength_bal_range_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bal_range_code)));
    avelength_bal_range_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bal_range_code)),h.bal_range_code<>(typeof(h.bal_range_code))'');
    populated_acct_bal_range_code_cnt := COUNT(GROUP,h.acct_bal_range_code <> (TYPEOF(h.acct_bal_range_code))'');
    populated_acct_bal_range_code_pcnt := AVE(GROUP,IF(h.acct_bal_range_code = (TYPEOF(h.acct_bal_range_code))'',0,100));
    maxlength_acct_bal_range_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.acct_bal_range_code)));
    avelength_acct_bal_range_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.acct_bal_range_code)),h.acct_bal_range_code<>(typeof(h.acct_bal_range_code))'');
    populated_nbr_fig_in_bal_cnt := COUNT(GROUP,h.nbr_fig_in_bal <> (TYPEOF(h.nbr_fig_in_bal))'');
    populated_nbr_fig_in_bal_pcnt := AVE(GROUP,IF(h.nbr_fig_in_bal = (TYPEOF(h.nbr_fig_in_bal))'',0,100));
    maxlength_nbr_fig_in_bal := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nbr_fig_in_bal)));
    avelength_nbr_fig_in_bal := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nbr_fig_in_bal)),h.nbr_fig_in_bal<>(typeof(h.nbr_fig_in_bal))'');
    populated_acct_bal_total_cnt := COUNT(GROUP,h.acct_bal_total <> (TYPEOF(h.acct_bal_total))'');
    populated_acct_bal_total_pcnt := AVE(GROUP,IF(h.acct_bal_total = (TYPEOF(h.acct_bal_total))'',0,100));
    maxlength_acct_bal_total := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.acct_bal_total)));
    avelength_acct_bal_total := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.acct_bal_total)),h.acct_bal_total<>(typeof(h.acct_bal_total))'');
    populated_acct_rating_code_cnt := COUNT(GROUP,h.acct_rating_code <> (TYPEOF(h.acct_rating_code))'');
    populated_acct_rating_code_pcnt := AVE(GROUP,IF(h.acct_rating_code = (TYPEOF(h.acct_rating_code))'',0,100));
    maxlength_acct_rating_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.acct_rating_code)));
    avelength_acct_rating_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.acct_rating_code)),h.acct_rating_code<>(typeof(h.acct_rating_code))'');
    populated_date_acct_opened_ymd_cnt := COUNT(GROUP,h.date_acct_opened_ymd <> (TYPEOF(h.date_acct_opened_ymd))'');
    populated_date_acct_opened_ymd_pcnt := AVE(GROUP,IF(h.date_acct_opened_ymd = (TYPEOF(h.date_acct_opened_ymd))'',0,100));
    maxlength_date_acct_opened_ymd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_acct_opened_ymd)));
    avelength_date_acct_opened_ymd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_acct_opened_ymd)),h.date_acct_opened_ymd<>(typeof(h.date_acct_opened_ymd))'');
    populated_date_acct_closed_ymd_cnt := COUNT(GROUP,h.date_acct_closed_ymd <> (TYPEOF(h.date_acct_closed_ymd))'');
    populated_date_acct_closed_ymd_pcnt := AVE(GROUP,IF(h.date_acct_closed_ymd = (TYPEOF(h.date_acct_closed_ymd))'',0,100));
    maxlength_date_acct_closed_ymd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_acct_closed_ymd)));
    avelength_date_acct_closed_ymd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_acct_closed_ymd)),h.date_acct_closed_ymd<>(typeof(h.date_acct_closed_ymd))'');
    populated_name_addr_key_cnt := COUNT(GROUP,h.name_addr_key <> (TYPEOF(h.name_addr_key))'');
    populated_name_addr_key_pcnt := AVE(GROUP,IF(h.name_addr_key = (TYPEOF(h.name_addr_key))'',0,100));
    maxlength_name_addr_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_addr_key)));
    avelength_name_addr_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_addr_key)),h.name_addr_key<>(typeof(h.name_addr_key))'');
    populated_append_rawaid_cnt := COUNT(GROUP,h.append_rawaid <> (TYPEOF(h.append_rawaid))'');
    populated_append_rawaid_pcnt := AVE(GROUP,IF(h.append_rawaid = (TYPEOF(h.append_rawaid))'',0,100));
    maxlength_append_rawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_rawaid)));
    avelength_append_rawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_rawaid)),h.append_rawaid<>(typeof(h.append_rawaid))'');
    populated_append_aceaid_cnt := COUNT(GROUP,h.append_aceaid <> (TYPEOF(h.append_aceaid))'');
    populated_append_aceaid_pcnt := AVE(GROUP,IF(h.append_aceaid = (TYPEOF(h.append_aceaid))'',0,100));
    maxlength_append_aceaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_aceaid)));
    avelength_append_aceaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_aceaid)),h.append_aceaid<>(typeof(h.append_aceaid))'');
    populated_prep_addr_line1_cnt := COUNT(GROUP,h.prep_addr_line1 <> (TYPEOF(h.prep_addr_line1))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_last_line_cnt := COUNT(GROUP,h.prep_addr_last_line <> (TYPEOF(h.prep_addr_last_line))'');
    populated_prep_addr_last_line_pcnt := AVE(GROUP,IF(h.prep_addr_last_line = (TYPEOF(h.prep_addr_last_line))'',0,100));
    maxlength_prep_addr_last_line := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_last_line)));
    avelength_prep_addr_last_line := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_last_line)),h.prep_addr_last_line<>(typeof(h.prep_addr_last_line))'');
    populated_clean_address_predir_cnt := COUNT(GROUP,h.clean_address_predir <> (TYPEOF(h.clean_address_predir))'');
    populated_clean_address_predir_pcnt := AVE(GROUP,IF(h.clean_address_predir = (TYPEOF(h.clean_address_predir))'',0,100));
    maxlength_clean_address_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_predir)));
    avelength_clean_address_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_predir)),h.clean_address_predir<>(typeof(h.clean_address_predir))'');
    populated_clean_address_prim_name_cnt := COUNT(GROUP,h.clean_address_prim_name <> (TYPEOF(h.clean_address_prim_name))'');
    populated_clean_address_prim_name_pcnt := AVE(GROUP,IF(h.clean_address_prim_name = (TYPEOF(h.clean_address_prim_name))'',0,100));
    maxlength_clean_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_prim_name)));
    avelength_clean_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_prim_name)),h.clean_address_prim_name<>(typeof(h.clean_address_prim_name))'');
    populated_clean_address_postdir_cnt := COUNT(GROUP,h.clean_address_postdir <> (TYPEOF(h.clean_address_postdir))'');
    populated_clean_address_postdir_pcnt := AVE(GROUP,IF(h.clean_address_postdir = (TYPEOF(h.clean_address_postdir))'',0,100));
    maxlength_clean_address_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_postdir)));
    avelength_clean_address_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_postdir)),h.clean_address_postdir<>(typeof(h.clean_address_postdir))'');
    populated_clean_address_p_city_name_cnt := COUNT(GROUP,h.clean_address_p_city_name <> (TYPEOF(h.clean_address_p_city_name))'');
    populated_clean_address_p_city_name_pcnt := AVE(GROUP,IF(h.clean_address_p_city_name = (TYPEOF(h.clean_address_p_city_name))'',0,100));
    maxlength_clean_address_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_p_city_name)));
    avelength_clean_address_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_p_city_name)),h.clean_address_p_city_name<>(typeof(h.clean_address_p_city_name))'');
    populated_clean_address_v_city_name_cnt := COUNT(GROUP,h.clean_address_v_city_name <> (TYPEOF(h.clean_address_v_city_name))'');
    populated_clean_address_v_city_name_pcnt := AVE(GROUP,IF(h.clean_address_v_city_name = (TYPEOF(h.clean_address_v_city_name))'',0,100));
    maxlength_clean_address_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_v_city_name)));
    avelength_clean_address_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_v_city_name)),h.clean_address_v_city_name<>(typeof(h.clean_address_v_city_name))'');
    populated_clean_address_st_cnt := COUNT(GROUP,h.clean_address_st <> (TYPEOF(h.clean_address_st))'');
    populated_clean_address_st_pcnt := AVE(GROUP,IF(h.clean_address_st = (TYPEOF(h.clean_address_st))'',0,100));
    maxlength_clean_address_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_st)));
    avelength_clean_address_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_st)),h.clean_address_st<>(typeof(h.clean_address_st))'');
    populated_clean_address_zip_cnt := COUNT(GROUP,h.clean_address_zip <> (TYPEOF(h.clean_address_zip))'');
    populated_clean_address_zip_pcnt := AVE(GROUP,IF(h.clean_address_zip = (TYPEOF(h.clean_address_zip))'',0,100));
    maxlength_clean_address_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_zip)));
    avelength_clean_address_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_zip)),h.clean_address_zip<>(typeof(h.clean_address_zip))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_process_date_first_seen_pcnt *   0.00 / 100 + T.Populated_process_date_last_seen_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_file_number_pcnt *   0.00 / 100 + T.Populated_segment_code_pcnt *   0.00 / 100 + T.Populated_sequence_number_pcnt *   0.00 / 100 + T.Populated_name_pcnt *   0.00 / 100 + T.Populated_street_address_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_code_pcnt *   0.00 / 100 + T.Populated_state_desc_pcnt *   0.00 / 100 + T.Populated_zip_code_pcnt *   0.00 / 100 + T.Populated_telephone_pcnt *   0.00 / 100 + T.Populated_relationship_code_pcnt *   0.00 / 100 + T.Populated_relationship_desc_pcnt *   0.00 / 100 + T.Populated_bal_range_code_pcnt *   0.00 / 100 + T.Populated_acct_bal_range_code_pcnt *   0.00 / 100 + T.Populated_nbr_fig_in_bal_pcnt *   0.00 / 100 + T.Populated_acct_bal_total_pcnt *   0.00 / 100 + T.Populated_acct_rating_code_pcnt *   0.00 / 100 + T.Populated_date_acct_opened_ymd_pcnt *   0.00 / 100 + T.Populated_date_acct_closed_ymd_pcnt *   0.00 / 100 + T.Populated_name_addr_key_pcnt *   0.00 / 100 + T.Populated_append_rawaid_pcnt *   0.00 / 100 + T.Populated_append_aceaid_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_last_line_pcnt *   0.00 / 100 + T.Populated_clean_address_predir_pcnt *   0.00 / 100 + T.Populated_clean_address_prim_name_pcnt *   0.00 / 100 + T.Populated_clean_address_postdir_pcnt *   0.00 / 100 + T.Populated_clean_address_p_city_name_pcnt *   0.00 / 100 + T.Populated_clean_address_v_city_name_pcnt *   0.00 / 100 + T.Populated_clean_address_st_pcnt *   0.00 / 100 + T.Populated_clean_address_zip_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','name','street_address','city','state_code','state_desc','zip_code','telephone','relationship_code','relationship_desc','bal_range_code','acct_bal_range_code','nbr_fig_in_bal','acct_bal_total','acct_rating_code','date_acct_opened_ymd','date_acct_closed_ymd','name_addr_key','append_rawaid','append_aceaid','prep_addr_line1','prep_addr_last_line','clean_address_predir','clean_address_prim_name','clean_address_postdir','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip');
  SELF.populated_pcnt := CHOOSE(C,le.populated_powid_pcnt,le.populated_proxid_pcnt,le.populated_seleid_pcnt,le.populated_orgid_pcnt,le.populated_ultid_pcnt,le.populated_bdid_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_process_date_first_seen_pcnt,le.populated_process_date_last_seen_pcnt,le.populated_record_type_pcnt,le.populated_process_date_pcnt,le.populated_file_number_pcnt,le.populated_segment_code_pcnt,le.populated_sequence_number_pcnt,le.populated_name_pcnt,le.populated_street_address_pcnt,le.populated_city_pcnt,le.populated_state_code_pcnt,le.populated_state_desc_pcnt,le.populated_zip_code_pcnt,le.populated_telephone_pcnt,le.populated_relationship_code_pcnt,le.populated_relationship_desc_pcnt,le.populated_bal_range_code_pcnt,le.populated_acct_bal_range_code_pcnt,le.populated_nbr_fig_in_bal_pcnt,le.populated_acct_bal_total_pcnt,le.populated_acct_rating_code_pcnt,le.populated_date_acct_opened_ymd_pcnt,le.populated_date_acct_closed_ymd_pcnt,le.populated_name_addr_key_pcnt,le.populated_append_rawaid_pcnt,le.populated_append_aceaid_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_last_line_pcnt,le.populated_clean_address_predir_pcnt,le.populated_clean_address_prim_name_pcnt,le.populated_clean_address_postdir_pcnt,le.populated_clean_address_p_city_name_pcnt,le.populated_clean_address_v_city_name_pcnt,le.populated_clean_address_st_pcnt,le.populated_clean_address_zip_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_powid,le.maxlength_proxid,le.maxlength_seleid,le.maxlength_orgid,le.maxlength_ultid,le.maxlength_bdid,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_process_date_first_seen,le.maxlength_process_date_last_seen,le.maxlength_record_type,le.maxlength_process_date,le.maxlength_file_number,le.maxlength_segment_code,le.maxlength_sequence_number,le.maxlength_name,le.maxlength_street_address,le.maxlength_city,le.maxlength_state_code,le.maxlength_state_desc,le.maxlength_zip_code,le.maxlength_telephone,le.maxlength_relationship_code,le.maxlength_relationship_desc,le.maxlength_bal_range_code,le.maxlength_acct_bal_range_code,le.maxlength_nbr_fig_in_bal,le.maxlength_acct_bal_total,le.maxlength_acct_rating_code,le.maxlength_date_acct_opened_ymd,le.maxlength_date_acct_closed_ymd,le.maxlength_name_addr_key,le.maxlength_append_rawaid,le.maxlength_append_aceaid,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_last_line,le.maxlength_clean_address_predir,le.maxlength_clean_address_prim_name,le.maxlength_clean_address_postdir,le.maxlength_clean_address_p_city_name,le.maxlength_clean_address_v_city_name,le.maxlength_clean_address_st,le.maxlength_clean_address_zip);
  SELF.avelength := CHOOSE(C,le.avelength_powid,le.avelength_proxid,le.avelength_seleid,le.avelength_orgid,le.avelength_ultid,le.avelength_bdid,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_process_date_first_seen,le.avelength_process_date_last_seen,le.avelength_record_type,le.avelength_process_date,le.avelength_file_number,le.avelength_segment_code,le.avelength_sequence_number,le.avelength_name,le.avelength_street_address,le.avelength_city,le.avelength_state_code,le.avelength_state_desc,le.avelength_zip_code,le.avelength_telephone,le.avelength_relationship_code,le.avelength_relationship_desc,le.avelength_bal_range_code,le.avelength_acct_bal_range_code,le.avelength_nbr_fig_in_bal,le.avelength_acct_bal_total,le.avelength_acct_rating_code,le.avelength_date_acct_opened_ymd,le.avelength_date_acct_closed_ymd,le.avelength_name_addr_key,le.avelength_append_rawaid,le.avelength_append_aceaid,le.avelength_prep_addr_line1,le.avelength_prep_addr_last_line,le.avelength_clean_address_predir,le.avelength_clean_address_prim_name,le.avelength_clean_address_postdir,le.avelength_clean_address_p_city_name,le.avelength_clean_address_v_city_name,le.avelength_clean_address_st,le.avelength_clean_address_zip);
END;
EXPORT invSummary := NORMALIZE(summary0, 43, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.street_address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state_code),TRIM((SALT311.StrType)le.state_desc),TRIM((SALT311.StrType)le.zip_code),TRIM((SALT311.StrType)le.telephone),TRIM((SALT311.StrType)le.relationship_code),TRIM((SALT311.StrType)le.relationship_desc),TRIM((SALT311.StrType)le.bal_range_code),TRIM((SALT311.StrType)le.acct_bal_range_code),TRIM((SALT311.StrType)le.nbr_fig_in_bal),TRIM((SALT311.StrType)le.acct_bal_total),TRIM((SALT311.StrType)le.acct_rating_code),TRIM((SALT311.StrType)le.date_acct_opened_ymd),TRIM((SALT311.StrType)le.date_acct_closed_ymd),TRIM((SALT311.StrType)le.name_addr_key),IF (le.append_rawaid <> 0,TRIM((SALT311.StrType)le.append_rawaid), ''),IF (le.append_aceaid <> 0,TRIM((SALT311.StrType)le.append_aceaid), ''),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_last_line),TRIM((SALT311.StrType)le.clean_address_predir),TRIM((SALT311.StrType)le.clean_address_prim_name),TRIM((SALT311.StrType)le.clean_address_postdir),TRIM((SALT311.StrType)le.clean_address_p_city_name),TRIM((SALT311.StrType)le.clean_address_v_city_name),TRIM((SALT311.StrType)le.clean_address_st),TRIM((SALT311.StrType)le.clean_address_zip)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,43,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 43);
  SELF.FldNo2 := 1 + (C % 43);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.street_address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state_code),TRIM((SALT311.StrType)le.state_desc),TRIM((SALT311.StrType)le.zip_code),TRIM((SALT311.StrType)le.telephone),TRIM((SALT311.StrType)le.relationship_code),TRIM((SALT311.StrType)le.relationship_desc),TRIM((SALT311.StrType)le.bal_range_code),TRIM((SALT311.StrType)le.acct_bal_range_code),TRIM((SALT311.StrType)le.nbr_fig_in_bal),TRIM((SALT311.StrType)le.acct_bal_total),TRIM((SALT311.StrType)le.acct_rating_code),TRIM((SALT311.StrType)le.date_acct_opened_ymd),TRIM((SALT311.StrType)le.date_acct_closed_ymd),TRIM((SALT311.StrType)le.name_addr_key),IF (le.append_rawaid <> 0,TRIM((SALT311.StrType)le.append_rawaid), ''),IF (le.append_aceaid <> 0,TRIM((SALT311.StrType)le.append_aceaid), ''),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_last_line),TRIM((SALT311.StrType)le.clean_address_predir),TRIM((SALT311.StrType)le.clean_address_prim_name),TRIM((SALT311.StrType)le.clean_address_postdir),TRIM((SALT311.StrType)le.clean_address_p_city_name),TRIM((SALT311.StrType)le.clean_address_v_city_name),TRIM((SALT311.StrType)le.clean_address_st),TRIM((SALT311.StrType)le.clean_address_zip)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.street_address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state_code),TRIM((SALT311.StrType)le.state_desc),TRIM((SALT311.StrType)le.zip_code),TRIM((SALT311.StrType)le.telephone),TRIM((SALT311.StrType)le.relationship_code),TRIM((SALT311.StrType)le.relationship_desc),TRIM((SALT311.StrType)le.bal_range_code),TRIM((SALT311.StrType)le.acct_bal_range_code),TRIM((SALT311.StrType)le.nbr_fig_in_bal),TRIM((SALT311.StrType)le.acct_bal_total),TRIM((SALT311.StrType)le.acct_rating_code),TRIM((SALT311.StrType)le.date_acct_opened_ymd),TRIM((SALT311.StrType)le.date_acct_closed_ymd),TRIM((SALT311.StrType)le.name_addr_key),IF (le.append_rawaid <> 0,TRIM((SALT311.StrType)le.append_rawaid), ''),IF (le.append_aceaid <> 0,TRIM((SALT311.StrType)le.append_aceaid), ''),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_last_line),TRIM((SALT311.StrType)le.clean_address_predir),TRIM((SALT311.StrType)le.clean_address_prim_name),TRIM((SALT311.StrType)le.clean_address_postdir),TRIM((SALT311.StrType)le.clean_address_p_city_name),TRIM((SALT311.StrType)le.clean_address_v_city_name),TRIM((SALT311.StrType)le.clean_address_st),TRIM((SALT311.StrType)le.clean_address_zip)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),43*43,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{16,'name'}
      ,{17,'street_address'}
      ,{18,'city'}
      ,{19,'state_code'}
      ,{20,'state_desc'}
      ,{21,'zip_code'}
      ,{22,'telephone'}
      ,{23,'relationship_code'}
      ,{24,'relationship_desc'}
      ,{25,'bal_range_code'}
      ,{26,'acct_bal_range_code'}
      ,{27,'nbr_fig_in_bal'}
      ,{28,'acct_bal_total'}
      ,{29,'acct_rating_code'}
      ,{30,'date_acct_opened_ymd'}
      ,{31,'date_acct_closed_ymd'}
      ,{32,'name_addr_key'}
      ,{33,'append_rawaid'}
      ,{34,'append_aceaid'}
      ,{35,'prep_addr_line1'}
      ,{36,'prep_addr_last_line'}
      ,{37,'clean_address_predir'}
      ,{38,'clean_address_prim_name'}
      ,{39,'clean_address_postdir'}
      ,{40,'clean_address_p_city_name'}
      ,{41,'clean_address_v_city_name'}
      ,{42,'clean_address_st'}
      ,{43,'clean_address_zip'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_5000_Fields.InValid_powid((SALT311.StrType)le.powid),
    Base_5000_Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Base_5000_Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Base_5000_Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Base_5000_Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Base_5000_Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Base_5000_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Base_5000_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Base_5000_Fields.InValid_process_date_first_seen((SALT311.StrType)le.process_date_first_seen),
    Base_5000_Fields.InValid_process_date_last_seen((SALT311.StrType)le.process_date_last_seen),
    Base_5000_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Base_5000_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Base_5000_Fields.InValid_file_number((SALT311.StrType)le.file_number),
    Base_5000_Fields.InValid_segment_code((SALT311.StrType)le.segment_code),
    Base_5000_Fields.InValid_sequence_number((SALT311.StrType)le.sequence_number),
    Base_5000_Fields.InValid_name((SALT311.StrType)le.name),
    Base_5000_Fields.InValid_street_address((SALT311.StrType)le.street_address),
    Base_5000_Fields.InValid_city((SALT311.StrType)le.city),
    Base_5000_Fields.InValid_state_code((SALT311.StrType)le.state_code),
    Base_5000_Fields.InValid_state_desc((SALT311.StrType)le.state_desc),
    Base_5000_Fields.InValid_zip_code((SALT311.StrType)le.zip_code),
    Base_5000_Fields.InValid_telephone((SALT311.StrType)le.telephone),
    Base_5000_Fields.InValid_relationship_code((SALT311.StrType)le.relationship_code),
    Base_5000_Fields.InValid_relationship_desc((SALT311.StrType)le.relationship_desc),
    Base_5000_Fields.InValid_bal_range_code((SALT311.StrType)le.bal_range_code),
    Base_5000_Fields.InValid_acct_bal_range_code((SALT311.StrType)le.acct_bal_range_code),
    Base_5000_Fields.InValid_nbr_fig_in_bal((SALT311.StrType)le.nbr_fig_in_bal),
    Base_5000_Fields.InValid_acct_bal_total((SALT311.StrType)le.acct_bal_total),
    Base_5000_Fields.InValid_acct_rating_code((SALT311.StrType)le.acct_rating_code),
    Base_5000_Fields.InValid_date_acct_opened_ymd((SALT311.StrType)le.date_acct_opened_ymd),
    Base_5000_Fields.InValid_date_acct_closed_ymd((SALT311.StrType)le.date_acct_closed_ymd),
    Base_5000_Fields.InValid_name_addr_key((SALT311.StrType)le.name_addr_key),
    Base_5000_Fields.InValid_append_rawaid((SALT311.StrType)le.append_rawaid),
    Base_5000_Fields.InValid_append_aceaid((SALT311.StrType)le.append_aceaid),
    Base_5000_Fields.InValid_prep_addr_line1((SALT311.StrType)le.prep_addr_line1),
    Base_5000_Fields.InValid_prep_addr_last_line((SALT311.StrType)le.prep_addr_last_line),
    Base_5000_Fields.InValid_clean_address_predir((SALT311.StrType)le.clean_address_predir),
    Base_5000_Fields.InValid_clean_address_prim_name((SALT311.StrType)le.clean_address_prim_name),
    Base_5000_Fields.InValid_clean_address_postdir((SALT311.StrType)le.clean_address_postdir),
    Base_5000_Fields.InValid_clean_address_p_city_name((SALT311.StrType)le.clean_address_p_city_name),
    Base_5000_Fields.InValid_clean_address_v_city_name((SALT311.StrType)le.clean_address_v_city_name),
    Base_5000_Fields.InValid_clean_address_st((SALT311.StrType)le.clean_address_st),
    Base_5000_Fields.InValid_clean_address_zip((SALT311.StrType)le.clean_address_zip),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,43,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_5000_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_numeric','invalid_dt_first_seen','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_record_type','invalid_pastdate','invalid_file_number','invalid_segment','invalid_numeric_or_allzeros','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_state','invalid_state_desc','invalid_zip5','invalid_phone','invalid_relationship_code','invalid_relationship_desc','invalid_bal_range_code','invalid_acct_bal_range_code','invalid_numeric','invalid_acct_bal','invalid_acct_rating_code','invalid_dt_mmddyy','invalid_dt_mmddyy','invalid_numeric','invalid_numeric','invalid_numeric','invalid_mandatory','invalid_mandatory','invalid_direction','invalid_mandatory','invalid_direction','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip5');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_5000_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_process_date_first_seen(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_process_date_last_seen(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_file_number(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_segment_code(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_sequence_number(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_name(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_street_address(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_city(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_state_code(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_state_desc(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_zip_code(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_telephone(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_relationship_code(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_relationship_desc(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_bal_range_code(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_acct_bal_range_code(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_nbr_fig_in_bal(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_acct_bal_total(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_acct_rating_code(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_date_acct_opened_ymd(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_date_acct_closed_ymd(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_name_addr_key(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_append_rawaid(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_append_aceaid(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_prep_addr_last_line(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_clean_address_predir(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_clean_address_prim_name(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_clean_address_postdir(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_clean_address_p_city_name(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_clean_address_v_city_name(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_clean_address_st(TotalErrors.ErrorNum),Base_5000_Fields.InValidMessage_clean_address_zip(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_5000_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

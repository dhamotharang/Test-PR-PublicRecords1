IMPORT SALT311,STD;
EXPORT Base_2015_hygiene(dataset(Base_2015_layout_EBR) h) := MODULE
 
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
    populated_trade_count1_cnt := COUNT(GROUP,h.trade_count1 <> (TYPEOF(h.trade_count1))'');
    populated_trade_count1_pcnt := AVE(GROUP,IF(h.trade_count1 = (TYPEOF(h.trade_count1))'',0,100));
    maxlength_trade_count1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trade_count1)));
    avelength_trade_count1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trade_count1)),h.trade_count1<>(typeof(h.trade_count1))'');
    populated_debt1_cnt := COUNT(GROUP,h.debt1 <> (TYPEOF(h.debt1))'');
    populated_debt1_pcnt := AVE(GROUP,IF(h.debt1 = (TYPEOF(h.debt1))'',0,100));
    maxlength_debt1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt1)));
    avelength_debt1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt1)),h.debt1<>(typeof(h.debt1))'');
    populated_high_credit_mask1_cnt := COUNT(GROUP,h.high_credit_mask1 <> (TYPEOF(h.high_credit_mask1))'');
    populated_high_credit_mask1_pcnt := AVE(GROUP,IF(h.high_credit_mask1 = (TYPEOF(h.high_credit_mask1))'',0,100));
    maxlength_high_credit_mask1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_credit_mask1)));
    avelength_high_credit_mask1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_credit_mask1)),h.high_credit_mask1<>(typeof(h.high_credit_mask1))'');
    populated_recent_high_credit1_cnt := COUNT(GROUP,h.recent_high_credit1 <> (TYPEOF(h.recent_high_credit1))'');
    populated_recent_high_credit1_pcnt := AVE(GROUP,IF(h.recent_high_credit1 = (TYPEOF(h.recent_high_credit1))'',0,100));
    maxlength_recent_high_credit1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recent_high_credit1)));
    avelength_recent_high_credit1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recent_high_credit1)),h.recent_high_credit1<>(typeof(h.recent_high_credit1))'');
    populated_account_balance_mask1_cnt := COUNT(GROUP,h.account_balance_mask1 <> (TYPEOF(h.account_balance_mask1))'');
    populated_account_balance_mask1_pcnt := AVE(GROUP,IF(h.account_balance_mask1 = (TYPEOF(h.account_balance_mask1))'',0,100));
    maxlength_account_balance_mask1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_balance_mask1)));
    avelength_account_balance_mask1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_balance_mask1)),h.account_balance_mask1<>(typeof(h.account_balance_mask1))'');
    populated_masked_account_balance1_cnt := COUNT(GROUP,h.masked_account_balance1 <> (TYPEOF(h.masked_account_balance1))'');
    populated_masked_account_balance1_pcnt := AVE(GROUP,IF(h.masked_account_balance1 = (TYPEOF(h.masked_account_balance1))'',0,100));
    maxlength_masked_account_balance1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.masked_account_balance1)));
    avelength_masked_account_balance1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.masked_account_balance1)),h.masked_account_balance1<>(typeof(h.masked_account_balance1))'');
    populated_current_balance_percent1_cnt := COUNT(GROUP,h.current_balance_percent1 <> (TYPEOF(h.current_balance_percent1))'');
    populated_current_balance_percent1_pcnt := AVE(GROUP,IF(h.current_balance_percent1 = (TYPEOF(h.current_balance_percent1))'',0,100));
    maxlength_current_balance_percent1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_balance_percent1)));
    avelength_current_balance_percent1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_balance_percent1)),h.current_balance_percent1<>(typeof(h.current_balance_percent1))'');
    populated_debt_01_30_percent1_cnt := COUNT(GROUP,h.debt_01_30_percent1 <> (TYPEOF(h.debt_01_30_percent1))'');
    populated_debt_01_30_percent1_pcnt := AVE(GROUP,IF(h.debt_01_30_percent1 = (TYPEOF(h.debt_01_30_percent1))'',0,100));
    maxlength_debt_01_30_percent1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_01_30_percent1)));
    avelength_debt_01_30_percent1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_01_30_percent1)),h.debt_01_30_percent1<>(typeof(h.debt_01_30_percent1))'');
    populated_debt_31_60_percent1_cnt := COUNT(GROUP,h.debt_31_60_percent1 <> (TYPEOF(h.debt_31_60_percent1))'');
    populated_debt_31_60_percent1_pcnt := AVE(GROUP,IF(h.debt_31_60_percent1 = (TYPEOF(h.debt_31_60_percent1))'',0,100));
    maxlength_debt_31_60_percent1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_31_60_percent1)));
    avelength_debt_31_60_percent1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_31_60_percent1)),h.debt_31_60_percent1<>(typeof(h.debt_31_60_percent1))'');
    populated_debt_61_90_percent1_cnt := COUNT(GROUP,h.debt_61_90_percent1 <> (TYPEOF(h.debt_61_90_percent1))'');
    populated_debt_61_90_percent1_pcnt := AVE(GROUP,IF(h.debt_61_90_percent1 = (TYPEOF(h.debt_61_90_percent1))'',0,100));
    maxlength_debt_61_90_percent1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_61_90_percent1)));
    avelength_debt_61_90_percent1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_61_90_percent1)),h.debt_61_90_percent1<>(typeof(h.debt_61_90_percent1))'');
    populated_debt_91_plus_percent1_cnt := COUNT(GROUP,h.debt_91_plus_percent1 <> (TYPEOF(h.debt_91_plus_percent1))'');
    populated_debt_91_plus_percent1_pcnt := AVE(GROUP,IF(h.debt_91_plus_percent1 = (TYPEOF(h.debt_91_plus_percent1))'',0,100));
    maxlength_debt_91_plus_percent1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_91_plus_percent1)));
    avelength_debt_91_plus_percent1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_91_plus_percent1)),h.debt_91_plus_percent1<>(typeof(h.debt_91_plus_percent1))'');
    populated_trade_count2_cnt := COUNT(GROUP,h.trade_count2 <> (TYPEOF(h.trade_count2))'');
    populated_trade_count2_pcnt := AVE(GROUP,IF(h.trade_count2 = (TYPEOF(h.trade_count2))'',0,100));
    maxlength_trade_count2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trade_count2)));
    avelength_trade_count2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trade_count2)),h.trade_count2<>(typeof(h.trade_count2))'');
    populated_debt2_cnt := COUNT(GROUP,h.debt2 <> (TYPEOF(h.debt2))'');
    populated_debt2_pcnt := AVE(GROUP,IF(h.debt2 = (TYPEOF(h.debt2))'',0,100));
    maxlength_debt2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt2)));
    avelength_debt2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt2)),h.debt2<>(typeof(h.debt2))'');
    populated_high_credit_mask2_cnt := COUNT(GROUP,h.high_credit_mask2 <> (TYPEOF(h.high_credit_mask2))'');
    populated_high_credit_mask2_pcnt := AVE(GROUP,IF(h.high_credit_mask2 = (TYPEOF(h.high_credit_mask2))'',0,100));
    maxlength_high_credit_mask2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_credit_mask2)));
    avelength_high_credit_mask2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_credit_mask2)),h.high_credit_mask2<>(typeof(h.high_credit_mask2))'');
    populated_recent_high_credit2_cnt := COUNT(GROUP,h.recent_high_credit2 <> (TYPEOF(h.recent_high_credit2))'');
    populated_recent_high_credit2_pcnt := AVE(GROUP,IF(h.recent_high_credit2 = (TYPEOF(h.recent_high_credit2))'',0,100));
    maxlength_recent_high_credit2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recent_high_credit2)));
    avelength_recent_high_credit2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recent_high_credit2)),h.recent_high_credit2<>(typeof(h.recent_high_credit2))'');
    populated_account_balance_mask2_cnt := COUNT(GROUP,h.account_balance_mask2 <> (TYPEOF(h.account_balance_mask2))'');
    populated_account_balance_mask2_pcnt := AVE(GROUP,IF(h.account_balance_mask2 = (TYPEOF(h.account_balance_mask2))'',0,100));
    maxlength_account_balance_mask2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_balance_mask2)));
    avelength_account_balance_mask2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_balance_mask2)),h.account_balance_mask2<>(typeof(h.account_balance_mask2))'');
    populated_masked_account_balance2_cnt := COUNT(GROUP,h.masked_account_balance2 <> (TYPEOF(h.masked_account_balance2))'');
    populated_masked_account_balance2_pcnt := AVE(GROUP,IF(h.masked_account_balance2 = (TYPEOF(h.masked_account_balance2))'',0,100));
    maxlength_masked_account_balance2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.masked_account_balance2)));
    avelength_masked_account_balance2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.masked_account_balance2)),h.masked_account_balance2<>(typeof(h.masked_account_balance2))'');
    populated_current_balance_percent2_cnt := COUNT(GROUP,h.current_balance_percent2 <> (TYPEOF(h.current_balance_percent2))'');
    populated_current_balance_percent2_pcnt := AVE(GROUP,IF(h.current_balance_percent2 = (TYPEOF(h.current_balance_percent2))'',0,100));
    maxlength_current_balance_percent2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_balance_percent2)));
    avelength_current_balance_percent2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_balance_percent2)),h.current_balance_percent2<>(typeof(h.current_balance_percent2))'');
    populated_debt_01_30_percent2_cnt := COUNT(GROUP,h.debt_01_30_percent2 <> (TYPEOF(h.debt_01_30_percent2))'');
    populated_debt_01_30_percent2_pcnt := AVE(GROUP,IF(h.debt_01_30_percent2 = (TYPEOF(h.debt_01_30_percent2))'',0,100));
    maxlength_debt_01_30_percent2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_01_30_percent2)));
    avelength_debt_01_30_percent2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_01_30_percent2)),h.debt_01_30_percent2<>(typeof(h.debt_01_30_percent2))'');
    populated_debt_31_60_percent2_cnt := COUNT(GROUP,h.debt_31_60_percent2 <> (TYPEOF(h.debt_31_60_percent2))'');
    populated_debt_31_60_percent2_pcnt := AVE(GROUP,IF(h.debt_31_60_percent2 = (TYPEOF(h.debt_31_60_percent2))'',0,100));
    maxlength_debt_31_60_percent2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_31_60_percent2)));
    avelength_debt_31_60_percent2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_31_60_percent2)),h.debt_31_60_percent2<>(typeof(h.debt_31_60_percent2))'');
    populated_debt_61_90_percent2_cnt := COUNT(GROUP,h.debt_61_90_percent2 <> (TYPEOF(h.debt_61_90_percent2))'');
    populated_debt_61_90_percent2_pcnt := AVE(GROUP,IF(h.debt_61_90_percent2 = (TYPEOF(h.debt_61_90_percent2))'',0,100));
    maxlength_debt_61_90_percent2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_61_90_percent2)));
    avelength_debt_61_90_percent2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_61_90_percent2)),h.debt_61_90_percent2<>(typeof(h.debt_61_90_percent2))'');
    populated_debt_91_plus_percent2_cnt := COUNT(GROUP,h.debt_91_plus_percent2 <> (TYPEOF(h.debt_91_plus_percent2))'');
    populated_debt_91_plus_percent2_pcnt := AVE(GROUP,IF(h.debt_91_plus_percent2 = (TYPEOF(h.debt_91_plus_percent2))'',0,100));
    maxlength_debt_91_plus_percent2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_91_plus_percent2)));
    avelength_debt_91_plus_percent2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_91_plus_percent2)),h.debt_91_plus_percent2<>(typeof(h.debt_91_plus_percent2))'');
    populated_trade_count3_cnt := COUNT(GROUP,h.trade_count3 <> (TYPEOF(h.trade_count3))'');
    populated_trade_count3_pcnt := AVE(GROUP,IF(h.trade_count3 = (TYPEOF(h.trade_count3))'',0,100));
    maxlength_trade_count3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trade_count3)));
    avelength_trade_count3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trade_count3)),h.trade_count3<>(typeof(h.trade_count3))'');
    populated_debt3_cnt := COUNT(GROUP,h.debt3 <> (TYPEOF(h.debt3))'');
    populated_debt3_pcnt := AVE(GROUP,IF(h.debt3 = (TYPEOF(h.debt3))'',0,100));
    maxlength_debt3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt3)));
    avelength_debt3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt3)),h.debt3<>(typeof(h.debt3))'');
    populated_high_credit_mask3_cnt := COUNT(GROUP,h.high_credit_mask3 <> (TYPEOF(h.high_credit_mask3))'');
    populated_high_credit_mask3_pcnt := AVE(GROUP,IF(h.high_credit_mask3 = (TYPEOF(h.high_credit_mask3))'',0,100));
    maxlength_high_credit_mask3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_credit_mask3)));
    avelength_high_credit_mask3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_credit_mask3)),h.high_credit_mask3<>(typeof(h.high_credit_mask3))'');
    populated_recent_high_credit3_cnt := COUNT(GROUP,h.recent_high_credit3 <> (TYPEOF(h.recent_high_credit3))'');
    populated_recent_high_credit3_pcnt := AVE(GROUP,IF(h.recent_high_credit3 = (TYPEOF(h.recent_high_credit3))'',0,100));
    maxlength_recent_high_credit3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recent_high_credit3)));
    avelength_recent_high_credit3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recent_high_credit3)),h.recent_high_credit3<>(typeof(h.recent_high_credit3))'');
    populated_account_balance_mask3_cnt := COUNT(GROUP,h.account_balance_mask3 <> (TYPEOF(h.account_balance_mask3))'');
    populated_account_balance_mask3_pcnt := AVE(GROUP,IF(h.account_balance_mask3 = (TYPEOF(h.account_balance_mask3))'',0,100));
    maxlength_account_balance_mask3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_balance_mask3)));
    avelength_account_balance_mask3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_balance_mask3)),h.account_balance_mask3<>(typeof(h.account_balance_mask3))'');
    populated_masked_account_balance3_cnt := COUNT(GROUP,h.masked_account_balance3 <> (TYPEOF(h.masked_account_balance3))'');
    populated_masked_account_balance3_pcnt := AVE(GROUP,IF(h.masked_account_balance3 = (TYPEOF(h.masked_account_balance3))'',0,100));
    maxlength_masked_account_balance3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.masked_account_balance3)));
    avelength_masked_account_balance3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.masked_account_balance3)),h.masked_account_balance3<>(typeof(h.masked_account_balance3))'');
    populated_current_balance_percent3_cnt := COUNT(GROUP,h.current_balance_percent3 <> (TYPEOF(h.current_balance_percent3))'');
    populated_current_balance_percent3_pcnt := AVE(GROUP,IF(h.current_balance_percent3 = (TYPEOF(h.current_balance_percent3))'',0,100));
    maxlength_current_balance_percent3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_balance_percent3)));
    avelength_current_balance_percent3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_balance_percent3)),h.current_balance_percent3<>(typeof(h.current_balance_percent3))'');
    populated_debt_01_30_percent3_cnt := COUNT(GROUP,h.debt_01_30_percent3 <> (TYPEOF(h.debt_01_30_percent3))'');
    populated_debt_01_30_percent3_pcnt := AVE(GROUP,IF(h.debt_01_30_percent3 = (TYPEOF(h.debt_01_30_percent3))'',0,100));
    maxlength_debt_01_30_percent3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_01_30_percent3)));
    avelength_debt_01_30_percent3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_01_30_percent3)),h.debt_01_30_percent3<>(typeof(h.debt_01_30_percent3))'');
    populated_debt_31_60_percent3_cnt := COUNT(GROUP,h.debt_31_60_percent3 <> (TYPEOF(h.debt_31_60_percent3))'');
    populated_debt_31_60_percent3_pcnt := AVE(GROUP,IF(h.debt_31_60_percent3 = (TYPEOF(h.debt_31_60_percent3))'',0,100));
    maxlength_debt_31_60_percent3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_31_60_percent3)));
    avelength_debt_31_60_percent3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_31_60_percent3)),h.debt_31_60_percent3<>(typeof(h.debt_31_60_percent3))'');
    populated_debt_61_90_percent3_cnt := COUNT(GROUP,h.debt_61_90_percent3 <> (TYPEOF(h.debt_61_90_percent3))'');
    populated_debt_61_90_percent3_pcnt := AVE(GROUP,IF(h.debt_61_90_percent3 = (TYPEOF(h.debt_61_90_percent3))'',0,100));
    maxlength_debt_61_90_percent3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_61_90_percent3)));
    avelength_debt_61_90_percent3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_61_90_percent3)),h.debt_61_90_percent3<>(typeof(h.debt_61_90_percent3))'');
    populated_debt_91_plus_percent3_cnt := COUNT(GROUP,h.debt_91_plus_percent3 <> (TYPEOF(h.debt_91_plus_percent3))'');
    populated_debt_91_plus_percent3_pcnt := AVE(GROUP,IF(h.debt_91_plus_percent3 = (TYPEOF(h.debt_91_plus_percent3))'',0,100));
    maxlength_debt_91_plus_percent3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_91_plus_percent3)));
    avelength_debt_91_plus_percent3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_91_plus_percent3)),h.debt_91_plus_percent3<>(typeof(h.debt_91_plus_percent3))'');
    populated_highest_credit_median_cnt := COUNT(GROUP,h.highest_credit_median <> (TYPEOF(h.highest_credit_median))'');
    populated_highest_credit_median_pcnt := AVE(GROUP,IF(h.highest_credit_median = (TYPEOF(h.highest_credit_median))'',0,100));
    maxlength_highest_credit_median := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.highest_credit_median)));
    avelength_highest_credit_median := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.highest_credit_median)),h.highest_credit_median<>(typeof(h.highest_credit_median))'');
    populated_orig_account_balance_regular_tradelines_cnt := COUNT(GROUP,h.orig_account_balance_regular_tradelines <> (TYPEOF(h.orig_account_balance_regular_tradelines))'');
    populated_orig_account_balance_regular_tradelines_pcnt := AVE(GROUP,IF(h.orig_account_balance_regular_tradelines = (TYPEOF(h.orig_account_balance_regular_tradelines))'',0,100));
    maxlength_orig_account_balance_regular_tradelines := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_account_balance_regular_tradelines)));
    avelength_orig_account_balance_regular_tradelines := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_account_balance_regular_tradelines)),h.orig_account_balance_regular_tradelines<>(typeof(h.orig_account_balance_regular_tradelines))'');
    populated_orig_account_balance_new_cnt := COUNT(GROUP,h.orig_account_balance_new <> (TYPEOF(h.orig_account_balance_new))'');
    populated_orig_account_balance_new_pcnt := AVE(GROUP,IF(h.orig_account_balance_new = (TYPEOF(h.orig_account_balance_new))'',0,100));
    maxlength_orig_account_balance_new := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_account_balance_new)));
    avelength_orig_account_balance_new := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_account_balance_new)),h.orig_account_balance_new<>(typeof(h.orig_account_balance_new))'');
    populated_orig_account_balance_combined_cnt := COUNT(GROUP,h.orig_account_balance_combined <> (TYPEOF(h.orig_account_balance_combined))'');
    populated_orig_account_balance_combined_pcnt := AVE(GROUP,IF(h.orig_account_balance_combined = (TYPEOF(h.orig_account_balance_combined))'',0,100));
    maxlength_orig_account_balance_combined := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_account_balance_combined)));
    avelength_orig_account_balance_combined := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_account_balance_combined)),h.orig_account_balance_combined<>(typeof(h.orig_account_balance_combined))'');
    populated_aged_trades_count_cnt := COUNT(GROUP,h.aged_trades_count <> (TYPEOF(h.aged_trades_count))'');
    populated_aged_trades_count_pcnt := AVE(GROUP,IF(h.aged_trades_count = (TYPEOF(h.aged_trades_count))'',0,100));
    maxlength_aged_trades_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aged_trades_count)));
    avelength_aged_trades_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aged_trades_count)),h.aged_trades_count<>(typeof(h.aged_trades_count))'');
    populated_account_balance_regular_tradelines_cnt := COUNT(GROUP,h.account_balance_regular_tradelines <> (TYPEOF(h.account_balance_regular_tradelines))'');
    populated_account_balance_regular_tradelines_pcnt := AVE(GROUP,IF(h.account_balance_regular_tradelines = (TYPEOF(h.account_balance_regular_tradelines))'',0,100));
    maxlength_account_balance_regular_tradelines := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_balance_regular_tradelines)));
    avelength_account_balance_regular_tradelines := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_balance_regular_tradelines)),h.account_balance_regular_tradelines<>(typeof(h.account_balance_regular_tradelines))'');
    populated_account_balance_new_cnt := COUNT(GROUP,h.account_balance_new <> (TYPEOF(h.account_balance_new))'');
    populated_account_balance_new_pcnt := AVE(GROUP,IF(h.account_balance_new = (TYPEOF(h.account_balance_new))'',0,100));
    maxlength_account_balance_new := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_balance_new)));
    avelength_account_balance_new := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_balance_new)),h.account_balance_new<>(typeof(h.account_balance_new))'');
    populated_account_balance_combined_cnt := COUNT(GROUP,h.account_balance_combined <> (TYPEOF(h.account_balance_combined))'');
    populated_account_balance_combined_pcnt := AVE(GROUP,IF(h.account_balance_combined = (TYPEOF(h.account_balance_combined))'',0,100));
    maxlength_account_balance_combined := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_balance_combined)));
    avelength_account_balance_combined := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_balance_combined)),h.account_balance_combined<>(typeof(h.account_balance_combined))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_process_date_first_seen_pcnt *   0.00 / 100 + T.Populated_process_date_last_seen_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_file_number_pcnt *   0.00 / 100 + T.Populated_segment_code_pcnt *   0.00 / 100 + T.Populated_trade_count1_pcnt *   0.00 / 100 + T.Populated_debt1_pcnt *   0.00 / 100 + T.Populated_high_credit_mask1_pcnt *   0.00 / 100 + T.Populated_recent_high_credit1_pcnt *   0.00 / 100 + T.Populated_account_balance_mask1_pcnt *   0.00 / 100 + T.Populated_masked_account_balance1_pcnt *   0.00 / 100 + T.Populated_current_balance_percent1_pcnt *   0.00 / 100 + T.Populated_debt_01_30_percent1_pcnt *   0.00 / 100 + T.Populated_debt_31_60_percent1_pcnt *   0.00 / 100 + T.Populated_debt_61_90_percent1_pcnt *   0.00 / 100 + T.Populated_debt_91_plus_percent1_pcnt *   0.00 / 100 + T.Populated_trade_count2_pcnt *   0.00 / 100 + T.Populated_debt2_pcnt *   0.00 / 100 + T.Populated_high_credit_mask2_pcnt *   0.00 / 100 + T.Populated_recent_high_credit2_pcnt *   0.00 / 100 + T.Populated_account_balance_mask2_pcnt *   0.00 / 100 + T.Populated_masked_account_balance2_pcnt *   0.00 / 100 + T.Populated_current_balance_percent2_pcnt *   0.00 / 100 + T.Populated_debt_01_30_percent2_pcnt *   0.00 / 100 + T.Populated_debt_31_60_percent2_pcnt *   0.00 / 100 + T.Populated_debt_61_90_percent2_pcnt *   0.00 / 100 + T.Populated_debt_91_plus_percent2_pcnt *   0.00 / 100 + T.Populated_trade_count3_pcnt *   0.00 / 100 + T.Populated_debt3_pcnt *   0.00 / 100 + T.Populated_high_credit_mask3_pcnt *   0.00 / 100 + T.Populated_recent_high_credit3_pcnt *   0.00 / 100 + T.Populated_account_balance_mask3_pcnt *   0.00 / 100 + T.Populated_masked_account_balance3_pcnt *   0.00 / 100 + T.Populated_current_balance_percent3_pcnt *   0.00 / 100 + T.Populated_debt_01_30_percent3_pcnt *   0.00 / 100 + T.Populated_debt_31_60_percent3_pcnt *   0.00 / 100 + T.Populated_debt_61_90_percent3_pcnt *   0.00 / 100 + T.Populated_debt_91_plus_percent3_pcnt *   0.00 / 100 + T.Populated_highest_credit_median_pcnt *   0.00 / 100 + T.Populated_orig_account_balance_regular_tradelines_pcnt *   0.00 / 100 + T.Populated_orig_account_balance_new_pcnt *   0.00 / 100 + T.Populated_orig_account_balance_combined_pcnt *   0.00 / 100 + T.Populated_aged_trades_count_pcnt *   0.00 / 100 + T.Populated_account_balance_regular_tradelines_pcnt *   0.00 / 100 + T.Populated_account_balance_new_pcnt *   0.00 / 100 + T.Populated_account_balance_combined_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','trade_count1','debt1','high_credit_mask1','recent_high_credit1','account_balance_mask1','masked_account_balance1','current_balance_percent1','debt_01_30_percent1','debt_31_60_percent1','debt_61_90_percent1','debt_91_plus_percent1','trade_count2','debt2','high_credit_mask2','recent_high_credit2','account_balance_mask2','masked_account_balance2','current_balance_percent2','debt_01_30_percent2','debt_31_60_percent2','debt_61_90_percent2','debt_91_plus_percent2','trade_count3','debt3','high_credit_mask3','recent_high_credit3','account_balance_mask3','masked_account_balance3','current_balance_percent3','debt_01_30_percent3','debt_31_60_percent3','debt_61_90_percent3','debt_91_plus_percent3','highest_credit_median','orig_account_balance_regular_tradelines','orig_account_balance_new','orig_account_balance_combined','aged_trades_count','account_balance_regular_tradelines','account_balance_new','account_balance_combined');
  SELF.populated_pcnt := CHOOSE(C,le.populated_powid_pcnt,le.populated_proxid_pcnt,le.populated_seleid_pcnt,le.populated_orgid_pcnt,le.populated_ultid_pcnt,le.populated_bdid_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_process_date_first_seen_pcnt,le.populated_process_date_last_seen_pcnt,le.populated_record_type_pcnt,le.populated_process_date_pcnt,le.populated_file_number_pcnt,le.populated_segment_code_pcnt,le.populated_trade_count1_pcnt,le.populated_debt1_pcnt,le.populated_high_credit_mask1_pcnt,le.populated_recent_high_credit1_pcnt,le.populated_account_balance_mask1_pcnt,le.populated_masked_account_balance1_pcnt,le.populated_current_balance_percent1_pcnt,le.populated_debt_01_30_percent1_pcnt,le.populated_debt_31_60_percent1_pcnt,le.populated_debt_61_90_percent1_pcnt,le.populated_debt_91_plus_percent1_pcnt,le.populated_trade_count2_pcnt,le.populated_debt2_pcnt,le.populated_high_credit_mask2_pcnt,le.populated_recent_high_credit2_pcnt,le.populated_account_balance_mask2_pcnt,le.populated_masked_account_balance2_pcnt,le.populated_current_balance_percent2_pcnt,le.populated_debt_01_30_percent2_pcnt,le.populated_debt_31_60_percent2_pcnt,le.populated_debt_61_90_percent2_pcnt,le.populated_debt_91_plus_percent2_pcnt,le.populated_trade_count3_pcnt,le.populated_debt3_pcnt,le.populated_high_credit_mask3_pcnt,le.populated_recent_high_credit3_pcnt,le.populated_account_balance_mask3_pcnt,le.populated_masked_account_balance3_pcnt,le.populated_current_balance_percent3_pcnt,le.populated_debt_01_30_percent3_pcnt,le.populated_debt_31_60_percent3_pcnt,le.populated_debt_61_90_percent3_pcnt,le.populated_debt_91_plus_percent3_pcnt,le.populated_highest_credit_median_pcnt,le.populated_orig_account_balance_regular_tradelines_pcnt,le.populated_orig_account_balance_new_pcnt,le.populated_orig_account_balance_combined_pcnt,le.populated_aged_trades_count_pcnt,le.populated_account_balance_regular_tradelines_pcnt,le.populated_account_balance_new_pcnt,le.populated_account_balance_combined_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_powid,le.maxlength_proxid,le.maxlength_seleid,le.maxlength_orgid,le.maxlength_ultid,le.maxlength_bdid,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_process_date_first_seen,le.maxlength_process_date_last_seen,le.maxlength_record_type,le.maxlength_process_date,le.maxlength_file_number,le.maxlength_segment_code,le.maxlength_trade_count1,le.maxlength_debt1,le.maxlength_high_credit_mask1,le.maxlength_recent_high_credit1,le.maxlength_account_balance_mask1,le.maxlength_masked_account_balance1,le.maxlength_current_balance_percent1,le.maxlength_debt_01_30_percent1,le.maxlength_debt_31_60_percent1,le.maxlength_debt_61_90_percent1,le.maxlength_debt_91_plus_percent1,le.maxlength_trade_count2,le.maxlength_debt2,le.maxlength_high_credit_mask2,le.maxlength_recent_high_credit2,le.maxlength_account_balance_mask2,le.maxlength_masked_account_balance2,le.maxlength_current_balance_percent2,le.maxlength_debt_01_30_percent2,le.maxlength_debt_31_60_percent2,le.maxlength_debt_61_90_percent2,le.maxlength_debt_91_plus_percent2,le.maxlength_trade_count3,le.maxlength_debt3,le.maxlength_high_credit_mask3,le.maxlength_recent_high_credit3,le.maxlength_account_balance_mask3,le.maxlength_masked_account_balance3,le.maxlength_current_balance_percent3,le.maxlength_debt_01_30_percent3,le.maxlength_debt_31_60_percent3,le.maxlength_debt_61_90_percent3,le.maxlength_debt_91_plus_percent3,le.maxlength_highest_credit_median,le.maxlength_orig_account_balance_regular_tradelines,le.maxlength_orig_account_balance_new,le.maxlength_orig_account_balance_combined,le.maxlength_aged_trades_count,le.maxlength_account_balance_regular_tradelines,le.maxlength_account_balance_new,le.maxlength_account_balance_combined);
  SELF.avelength := CHOOSE(C,le.avelength_powid,le.avelength_proxid,le.avelength_seleid,le.avelength_orgid,le.avelength_ultid,le.avelength_bdid,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_process_date_first_seen,le.avelength_process_date_last_seen,le.avelength_record_type,le.avelength_process_date,le.avelength_file_number,le.avelength_segment_code,le.avelength_trade_count1,le.avelength_debt1,le.avelength_high_credit_mask1,le.avelength_recent_high_credit1,le.avelength_account_balance_mask1,le.avelength_masked_account_balance1,le.avelength_current_balance_percent1,le.avelength_debt_01_30_percent1,le.avelength_debt_31_60_percent1,le.avelength_debt_61_90_percent1,le.avelength_debt_91_plus_percent1,le.avelength_trade_count2,le.avelength_debt2,le.avelength_high_credit_mask2,le.avelength_recent_high_credit2,le.avelength_account_balance_mask2,le.avelength_masked_account_balance2,le.avelength_current_balance_percent2,le.avelength_debt_01_30_percent2,le.avelength_debt_31_60_percent2,le.avelength_debt_61_90_percent2,le.avelength_debt_91_plus_percent2,le.avelength_trade_count3,le.avelength_debt3,le.avelength_high_credit_mask3,le.avelength_recent_high_credit3,le.avelength_account_balance_mask3,le.avelength_masked_account_balance3,le.avelength_current_balance_percent3,le.avelength_debt_01_30_percent3,le.avelength_debt_31_60_percent3,le.avelength_debt_61_90_percent3,le.avelength_debt_91_plus_percent3,le.avelength_highest_credit_median,le.avelength_orig_account_balance_regular_tradelines,le.avelength_orig_account_balance_new,le.avelength_orig_account_balance_combined,le.avelength_aged_trades_count,le.avelength_account_balance_regular_tradelines,le.avelength_account_balance_new,le.avelength_account_balance_combined);
END;
EXPORT invSummary := NORMALIZE(summary0, 55, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.trade_count1),TRIM((SALT311.StrType)le.debt1),TRIM((SALT311.StrType)le.high_credit_mask1),TRIM((SALT311.StrType)le.recent_high_credit1),TRIM((SALT311.StrType)le.account_balance_mask1),TRIM((SALT311.StrType)le.masked_account_balance1),TRIM((SALT311.StrType)le.current_balance_percent1),TRIM((SALT311.StrType)le.debt_01_30_percent1),TRIM((SALT311.StrType)le.debt_31_60_percent1),TRIM((SALT311.StrType)le.debt_61_90_percent1),TRIM((SALT311.StrType)le.debt_91_plus_percent1),TRIM((SALT311.StrType)le.trade_count2),TRIM((SALT311.StrType)le.debt2),TRIM((SALT311.StrType)le.high_credit_mask2),TRIM((SALT311.StrType)le.recent_high_credit2),TRIM((SALT311.StrType)le.account_balance_mask2),TRIM((SALT311.StrType)le.masked_account_balance2),TRIM((SALT311.StrType)le.current_balance_percent2),TRIM((SALT311.StrType)le.debt_01_30_percent2),TRIM((SALT311.StrType)le.debt_31_60_percent2),TRIM((SALT311.StrType)le.debt_61_90_percent2),TRIM((SALT311.StrType)le.debt_91_plus_percent2),TRIM((SALT311.StrType)le.trade_count3),TRIM((SALT311.StrType)le.debt3),TRIM((SALT311.StrType)le.high_credit_mask3),TRIM((SALT311.StrType)le.recent_high_credit3),TRIM((SALT311.StrType)le.account_balance_mask3),TRIM((SALT311.StrType)le.masked_account_balance3),TRIM((SALT311.StrType)le.current_balance_percent3),TRIM((SALT311.StrType)le.debt_01_30_percent3),TRIM((SALT311.StrType)le.debt_31_60_percent3),TRIM((SALT311.StrType)le.debt_61_90_percent3),TRIM((SALT311.StrType)le.debt_91_plus_percent3),TRIM((SALT311.StrType)le.highest_credit_median),TRIM((SALT311.StrType)le.orig_account_balance_regular_tradelines),TRIM((SALT311.StrType)le.orig_account_balance_new),TRIM((SALT311.StrType)le.orig_account_balance_combined),TRIM((SALT311.StrType)le.aged_trades_count),TRIM((SALT311.StrType)le.account_balance_regular_tradelines),TRIM((SALT311.StrType)le.account_balance_new),TRIM((SALT311.StrType)le.account_balance_combined)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,55,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 55);
  SELF.FldNo2 := 1 + (C % 55);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.trade_count1),TRIM((SALT311.StrType)le.debt1),TRIM((SALT311.StrType)le.high_credit_mask1),TRIM((SALT311.StrType)le.recent_high_credit1),TRIM((SALT311.StrType)le.account_balance_mask1),TRIM((SALT311.StrType)le.masked_account_balance1),TRIM((SALT311.StrType)le.current_balance_percent1),TRIM((SALT311.StrType)le.debt_01_30_percent1),TRIM((SALT311.StrType)le.debt_31_60_percent1),TRIM((SALT311.StrType)le.debt_61_90_percent1),TRIM((SALT311.StrType)le.debt_91_plus_percent1),TRIM((SALT311.StrType)le.trade_count2),TRIM((SALT311.StrType)le.debt2),TRIM((SALT311.StrType)le.high_credit_mask2),TRIM((SALT311.StrType)le.recent_high_credit2),TRIM((SALT311.StrType)le.account_balance_mask2),TRIM((SALT311.StrType)le.masked_account_balance2),TRIM((SALT311.StrType)le.current_balance_percent2),TRIM((SALT311.StrType)le.debt_01_30_percent2),TRIM((SALT311.StrType)le.debt_31_60_percent2),TRIM((SALT311.StrType)le.debt_61_90_percent2),TRIM((SALT311.StrType)le.debt_91_plus_percent2),TRIM((SALT311.StrType)le.trade_count3),TRIM((SALT311.StrType)le.debt3),TRIM((SALT311.StrType)le.high_credit_mask3),TRIM((SALT311.StrType)le.recent_high_credit3),TRIM((SALT311.StrType)le.account_balance_mask3),TRIM((SALT311.StrType)le.masked_account_balance3),TRIM((SALT311.StrType)le.current_balance_percent3),TRIM((SALT311.StrType)le.debt_01_30_percent3),TRIM((SALT311.StrType)le.debt_31_60_percent3),TRIM((SALT311.StrType)le.debt_61_90_percent3),TRIM((SALT311.StrType)le.debt_91_plus_percent3),TRIM((SALT311.StrType)le.highest_credit_median),TRIM((SALT311.StrType)le.orig_account_balance_regular_tradelines),TRIM((SALT311.StrType)le.orig_account_balance_new),TRIM((SALT311.StrType)le.orig_account_balance_combined),TRIM((SALT311.StrType)le.aged_trades_count),TRIM((SALT311.StrType)le.account_balance_regular_tradelines),TRIM((SALT311.StrType)le.account_balance_new),TRIM((SALT311.StrType)le.account_balance_combined)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.trade_count1),TRIM((SALT311.StrType)le.debt1),TRIM((SALT311.StrType)le.high_credit_mask1),TRIM((SALT311.StrType)le.recent_high_credit1),TRIM((SALT311.StrType)le.account_balance_mask1),TRIM((SALT311.StrType)le.masked_account_balance1),TRIM((SALT311.StrType)le.current_balance_percent1),TRIM((SALT311.StrType)le.debt_01_30_percent1),TRIM((SALT311.StrType)le.debt_31_60_percent1),TRIM((SALT311.StrType)le.debt_61_90_percent1),TRIM((SALT311.StrType)le.debt_91_plus_percent1),TRIM((SALT311.StrType)le.trade_count2),TRIM((SALT311.StrType)le.debt2),TRIM((SALT311.StrType)le.high_credit_mask2),TRIM((SALT311.StrType)le.recent_high_credit2),TRIM((SALT311.StrType)le.account_balance_mask2),TRIM((SALT311.StrType)le.masked_account_balance2),TRIM((SALT311.StrType)le.current_balance_percent2),TRIM((SALT311.StrType)le.debt_01_30_percent2),TRIM((SALT311.StrType)le.debt_31_60_percent2),TRIM((SALT311.StrType)le.debt_61_90_percent2),TRIM((SALT311.StrType)le.debt_91_plus_percent2),TRIM((SALT311.StrType)le.trade_count3),TRIM((SALT311.StrType)le.debt3),TRIM((SALT311.StrType)le.high_credit_mask3),TRIM((SALT311.StrType)le.recent_high_credit3),TRIM((SALT311.StrType)le.account_balance_mask3),TRIM((SALT311.StrType)le.masked_account_balance3),TRIM((SALT311.StrType)le.current_balance_percent3),TRIM((SALT311.StrType)le.debt_01_30_percent3),TRIM((SALT311.StrType)le.debt_31_60_percent3),TRIM((SALT311.StrType)le.debt_61_90_percent3),TRIM((SALT311.StrType)le.debt_91_plus_percent3),TRIM((SALT311.StrType)le.highest_credit_median),TRIM((SALT311.StrType)le.orig_account_balance_regular_tradelines),TRIM((SALT311.StrType)le.orig_account_balance_new),TRIM((SALT311.StrType)le.orig_account_balance_combined),TRIM((SALT311.StrType)le.aged_trades_count),TRIM((SALT311.StrType)le.account_balance_regular_tradelines),TRIM((SALT311.StrType)le.account_balance_new),TRIM((SALT311.StrType)le.account_balance_combined)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),55*55,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{15,'trade_count1'}
      ,{16,'debt1'}
      ,{17,'high_credit_mask1'}
      ,{18,'recent_high_credit1'}
      ,{19,'account_balance_mask1'}
      ,{20,'masked_account_balance1'}
      ,{21,'current_balance_percent1'}
      ,{22,'debt_01_30_percent1'}
      ,{23,'debt_31_60_percent1'}
      ,{24,'debt_61_90_percent1'}
      ,{25,'debt_91_plus_percent1'}
      ,{26,'trade_count2'}
      ,{27,'debt2'}
      ,{28,'high_credit_mask2'}
      ,{29,'recent_high_credit2'}
      ,{30,'account_balance_mask2'}
      ,{31,'masked_account_balance2'}
      ,{32,'current_balance_percent2'}
      ,{33,'debt_01_30_percent2'}
      ,{34,'debt_31_60_percent2'}
      ,{35,'debt_61_90_percent2'}
      ,{36,'debt_91_plus_percent2'}
      ,{37,'trade_count3'}
      ,{38,'debt3'}
      ,{39,'high_credit_mask3'}
      ,{40,'recent_high_credit3'}
      ,{41,'account_balance_mask3'}
      ,{42,'masked_account_balance3'}
      ,{43,'current_balance_percent3'}
      ,{44,'debt_01_30_percent3'}
      ,{45,'debt_31_60_percent3'}
      ,{46,'debt_61_90_percent3'}
      ,{47,'debt_91_plus_percent3'}
      ,{48,'highest_credit_median'}
      ,{49,'orig_account_balance_regular_tradelines'}
      ,{50,'orig_account_balance_new'}
      ,{51,'orig_account_balance_combined'}
      ,{52,'aged_trades_count'}
      ,{53,'account_balance_regular_tradelines'}
      ,{54,'account_balance_new'}
      ,{55,'account_balance_combined'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_2015_Fields.InValid_powid((SALT311.StrType)le.powid),
    Base_2015_Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Base_2015_Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Base_2015_Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Base_2015_Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Base_2015_Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Base_2015_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Base_2015_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Base_2015_Fields.InValid_process_date_first_seen((SALT311.StrType)le.process_date_first_seen),
    Base_2015_Fields.InValid_process_date_last_seen((SALT311.StrType)le.process_date_last_seen),
    Base_2015_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Base_2015_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Base_2015_Fields.InValid_file_number((SALT311.StrType)le.file_number),
    Base_2015_Fields.InValid_segment_code((SALT311.StrType)le.segment_code),
    Base_2015_Fields.InValid_trade_count1((SALT311.StrType)le.trade_count1),
    Base_2015_Fields.InValid_debt1((SALT311.StrType)le.debt1),
    Base_2015_Fields.InValid_high_credit_mask1((SALT311.StrType)le.high_credit_mask1),
    Base_2015_Fields.InValid_recent_high_credit1((SALT311.StrType)le.recent_high_credit1),
    Base_2015_Fields.InValid_account_balance_mask1((SALT311.StrType)le.account_balance_mask1),
    Base_2015_Fields.InValid_masked_account_balance1((SALT311.StrType)le.masked_account_balance1),
    Base_2015_Fields.InValid_current_balance_percent1((SALT311.StrType)le.current_balance_percent1),
    Base_2015_Fields.InValid_debt_01_30_percent1((SALT311.StrType)le.debt_01_30_percent1),
    Base_2015_Fields.InValid_debt_31_60_percent1((SALT311.StrType)le.debt_31_60_percent1),
    Base_2015_Fields.InValid_debt_61_90_percent1((SALT311.StrType)le.debt_61_90_percent1),
    Base_2015_Fields.InValid_debt_91_plus_percent1((SALT311.StrType)le.debt_91_plus_percent1),
    Base_2015_Fields.InValid_trade_count2((SALT311.StrType)le.trade_count2),
    Base_2015_Fields.InValid_debt2((SALT311.StrType)le.debt2),
    Base_2015_Fields.InValid_high_credit_mask2((SALT311.StrType)le.high_credit_mask2),
    Base_2015_Fields.InValid_recent_high_credit2((SALT311.StrType)le.recent_high_credit2),
    Base_2015_Fields.InValid_account_balance_mask2((SALT311.StrType)le.account_balance_mask2),
    Base_2015_Fields.InValid_masked_account_balance2((SALT311.StrType)le.masked_account_balance2),
    Base_2015_Fields.InValid_current_balance_percent2((SALT311.StrType)le.current_balance_percent2),
    Base_2015_Fields.InValid_debt_01_30_percent2((SALT311.StrType)le.debt_01_30_percent2),
    Base_2015_Fields.InValid_debt_31_60_percent2((SALT311.StrType)le.debt_31_60_percent2),
    Base_2015_Fields.InValid_debt_61_90_percent2((SALT311.StrType)le.debt_61_90_percent2),
    Base_2015_Fields.InValid_debt_91_plus_percent2((SALT311.StrType)le.debt_91_plus_percent2),
    Base_2015_Fields.InValid_trade_count3((SALT311.StrType)le.trade_count3),
    Base_2015_Fields.InValid_debt3((SALT311.StrType)le.debt3),
    Base_2015_Fields.InValid_high_credit_mask3((SALT311.StrType)le.high_credit_mask3),
    Base_2015_Fields.InValid_recent_high_credit3((SALT311.StrType)le.recent_high_credit3),
    Base_2015_Fields.InValid_account_balance_mask3((SALT311.StrType)le.account_balance_mask3),
    Base_2015_Fields.InValid_masked_account_balance3((SALT311.StrType)le.masked_account_balance3),
    Base_2015_Fields.InValid_current_balance_percent3((SALT311.StrType)le.current_balance_percent3),
    Base_2015_Fields.InValid_debt_01_30_percent3((SALT311.StrType)le.debt_01_30_percent3),
    Base_2015_Fields.InValid_debt_31_60_percent3((SALT311.StrType)le.debt_31_60_percent3),
    Base_2015_Fields.InValid_debt_61_90_percent3((SALT311.StrType)le.debt_61_90_percent3),
    Base_2015_Fields.InValid_debt_91_plus_percent3((SALT311.StrType)le.debt_91_plus_percent3),
    Base_2015_Fields.InValid_highest_credit_median((SALT311.StrType)le.highest_credit_median),
    Base_2015_Fields.InValid_orig_account_balance_regular_tradelines((SALT311.StrType)le.orig_account_balance_regular_tradelines),
    Base_2015_Fields.InValid_orig_account_balance_new((SALT311.StrType)le.orig_account_balance_new),
    Base_2015_Fields.InValid_orig_account_balance_combined((SALT311.StrType)le.orig_account_balance_combined),
    Base_2015_Fields.InValid_aged_trades_count((SALT311.StrType)le.aged_trades_count),
    Base_2015_Fields.InValid_account_balance_regular_tradelines((SALT311.StrType)le.account_balance_regular_tradelines),
    Base_2015_Fields.InValid_account_balance_new((SALT311.StrType)le.account_balance_new),
    Base_2015_Fields.InValid_account_balance_combined((SALT311.StrType)le.account_balance_combined),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,55,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_2015_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_numeric','invalid_dt_first_seen','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_record_type','invalid_pastdate','invalid_file_number','invalid_segment','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_mask','invalid_numeric_or_allzeros','invalid_mask','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_mask','invalid_numeric_or_allzeros','invalid_mask','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_mask','invalid_numeric_or_allzeros','invalid_mask','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_account_balance','invalid_account_balance','invalid_account_balance','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_2015_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_process_date_first_seen(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_process_date_last_seen(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_file_number(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_segment_code(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_trade_count1(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_debt1(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_high_credit_mask1(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_recent_high_credit1(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_account_balance_mask1(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_masked_account_balance1(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_current_balance_percent1(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_debt_01_30_percent1(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_debt_31_60_percent1(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_debt_61_90_percent1(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_debt_91_plus_percent1(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_trade_count2(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_debt2(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_high_credit_mask2(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_recent_high_credit2(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_account_balance_mask2(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_masked_account_balance2(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_current_balance_percent2(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_debt_01_30_percent2(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_debt_31_60_percent2(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_debt_61_90_percent2(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_debt_91_plus_percent2(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_trade_count3(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_debt3(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_high_credit_mask3(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_recent_high_credit3(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_account_balance_mask3(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_masked_account_balance3(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_current_balance_percent3(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_debt_01_30_percent3(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_debt_31_60_percent3(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_debt_61_90_percent3(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_debt_91_plus_percent3(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_highest_credit_median(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_orig_account_balance_regular_tradelines(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_orig_account_balance_new(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_orig_account_balance_combined(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_aged_trades_count(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_account_balance_regular_tradelines(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_account_balance_new(TotalErrors.ErrorNum),Base_2015_Fields.InValidMessage_account_balance_combined(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_2015_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

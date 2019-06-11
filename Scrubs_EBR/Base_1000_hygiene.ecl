IMPORT SALT311,STD;
EXPORT Base_1000_hygiene(dataset(Base_1000_layout_EBR) h) := MODULE
 
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
    populated_current_dbt_cnt := COUNT(GROUP,h.current_dbt <> (TYPEOF(h.current_dbt))'');
    populated_current_dbt_pcnt := AVE(GROUP,IF(h.current_dbt = (TYPEOF(h.current_dbt))'',0,100));
    maxlength_current_dbt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_dbt)));
    avelength_current_dbt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_dbt)),h.current_dbt<>(typeof(h.current_dbt))'');
    populated_predicted_dbt_cnt := COUNT(GROUP,h.predicted_dbt <> (TYPEOF(h.predicted_dbt))'');
    populated_predicted_dbt_pcnt := AVE(GROUP,IF(h.predicted_dbt = (TYPEOF(h.predicted_dbt))'',0,100));
    maxlength_predicted_dbt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predicted_dbt)));
    avelength_predicted_dbt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predicted_dbt)),h.predicted_dbt<>(typeof(h.predicted_dbt))'');
    populated_orig_predicted_dbt_date_mmddyy_cnt := COUNT(GROUP,h.orig_predicted_dbt_date_mmddyy <> (TYPEOF(h.orig_predicted_dbt_date_mmddyy))'');
    populated_orig_predicted_dbt_date_mmddyy_pcnt := AVE(GROUP,IF(h.orig_predicted_dbt_date_mmddyy = (TYPEOF(h.orig_predicted_dbt_date_mmddyy))'',0,100));
    maxlength_orig_predicted_dbt_date_mmddyy := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_predicted_dbt_date_mmddyy)));
    avelength_orig_predicted_dbt_date_mmddyy := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_predicted_dbt_date_mmddyy)),h.orig_predicted_dbt_date_mmddyy<>(typeof(h.orig_predicted_dbt_date_mmddyy))'');
    populated_average_industry_dbt_cnt := COUNT(GROUP,h.average_industry_dbt <> (TYPEOF(h.average_industry_dbt))'');
    populated_average_industry_dbt_pcnt := AVE(GROUP,IF(h.average_industry_dbt = (TYPEOF(h.average_industry_dbt))'',0,100));
    maxlength_average_industry_dbt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.average_industry_dbt)));
    avelength_average_industry_dbt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.average_industry_dbt)),h.average_industry_dbt<>(typeof(h.average_industry_dbt))'');
    populated_average_all_industries_dbt_cnt := COUNT(GROUP,h.average_all_industries_dbt <> (TYPEOF(h.average_all_industries_dbt))'');
    populated_average_all_industries_dbt_pcnt := AVE(GROUP,IF(h.average_all_industries_dbt = (TYPEOF(h.average_all_industries_dbt))'',0,100));
    maxlength_average_all_industries_dbt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.average_all_industries_dbt)));
    avelength_average_all_industries_dbt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.average_all_industries_dbt)),h.average_all_industries_dbt<>(typeof(h.average_all_industries_dbt))'');
    populated_low_balance_cnt := COUNT(GROUP,h.low_balance <> (TYPEOF(h.low_balance))'');
    populated_low_balance_pcnt := AVE(GROUP,IF(h.low_balance = (TYPEOF(h.low_balance))'',0,100));
    maxlength_low_balance := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.low_balance)));
    avelength_low_balance := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.low_balance)),h.low_balance<>(typeof(h.low_balance))'');
    populated_high_balance_cnt := COUNT(GROUP,h.high_balance <> (TYPEOF(h.high_balance))'');
    populated_high_balance_pcnt := AVE(GROUP,IF(h.high_balance = (TYPEOF(h.high_balance))'',0,100));
    maxlength_high_balance := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_balance)));
    avelength_high_balance := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_balance)),h.high_balance<>(typeof(h.high_balance))'');
    populated_current_account_balance_cnt := COUNT(GROUP,h.current_account_balance <> (TYPEOF(h.current_account_balance))'');
    populated_current_account_balance_pcnt := AVE(GROUP,IF(h.current_account_balance = (TYPEOF(h.current_account_balance))'',0,100));
    maxlength_current_account_balance := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_account_balance)));
    avelength_current_account_balance := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_account_balance)),h.current_account_balance<>(typeof(h.current_account_balance))'');
    populated_high_credit_extended_cnt := COUNT(GROUP,h.high_credit_extended <> (TYPEOF(h.high_credit_extended))'');
    populated_high_credit_extended_pcnt := AVE(GROUP,IF(h.high_credit_extended = (TYPEOF(h.high_credit_extended))'',0,100));
    maxlength_high_credit_extended := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_credit_extended)));
    avelength_high_credit_extended := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_credit_extended)),h.high_credit_extended<>(typeof(h.high_credit_extended))'');
    populated_median_credit_extended_cnt := COUNT(GROUP,h.median_credit_extended <> (TYPEOF(h.median_credit_extended))'');
    populated_median_credit_extended_pcnt := AVE(GROUP,IF(h.median_credit_extended = (TYPEOF(h.median_credit_extended))'',0,100));
    maxlength_median_credit_extended := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.median_credit_extended)));
    avelength_median_credit_extended := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.median_credit_extended)),h.median_credit_extended<>(typeof(h.median_credit_extended))'');
    populated_payment_performance_cnt := COUNT(GROUP,h.payment_performance <> (TYPEOF(h.payment_performance))'');
    populated_payment_performance_pcnt := AVE(GROUP,IF(h.payment_performance = (TYPEOF(h.payment_performance))'',0,100));
    maxlength_payment_performance := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.payment_performance)));
    avelength_payment_performance := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.payment_performance)),h.payment_performance<>(typeof(h.payment_performance))'');
    populated_payment_trend_cnt := COUNT(GROUP,h.payment_trend <> (TYPEOF(h.payment_trend))'');
    populated_payment_trend_pcnt := AVE(GROUP,IF(h.payment_trend = (TYPEOF(h.payment_trend))'',0,100));
    maxlength_payment_trend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.payment_trend)));
    avelength_payment_trend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.payment_trend)),h.payment_trend<>(typeof(h.payment_trend))'');
    populated_industry_description_cnt := COUNT(GROUP,h.industry_description <> (TYPEOF(h.industry_description))'');
    populated_industry_description_pcnt := AVE(GROUP,IF(h.industry_description = (TYPEOF(h.industry_description))'',0,100));
    maxlength_industry_description := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.industry_description)));
    avelength_industry_description := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.industry_description)),h.industry_description<>(typeof(h.industry_description))'');
    populated_predicted_dbt_date_cnt := COUNT(GROUP,h.predicted_dbt_date <> (TYPEOF(h.predicted_dbt_date))'');
    populated_predicted_dbt_date_pcnt := AVE(GROUP,IF(h.predicted_dbt_date = (TYPEOF(h.predicted_dbt_date))'',0,100));
    maxlength_predicted_dbt_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predicted_dbt_date)));
    avelength_predicted_dbt_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predicted_dbt_date)),h.predicted_dbt_date<>(typeof(h.predicted_dbt_date))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_process_date_first_seen_pcnt *   0.00 / 100 + T.Populated_process_date_last_seen_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_file_number_pcnt *   0.00 / 100 + T.Populated_current_dbt_pcnt *   0.00 / 100 + T.Populated_predicted_dbt_pcnt *   0.00 / 100 + T.Populated_orig_predicted_dbt_date_mmddyy_pcnt *   0.00 / 100 + T.Populated_average_industry_dbt_pcnt *   0.00 / 100 + T.Populated_average_all_industries_dbt_pcnt *   0.00 / 100 + T.Populated_low_balance_pcnt *   0.00 / 100 + T.Populated_high_balance_pcnt *   0.00 / 100 + T.Populated_current_account_balance_pcnt *   0.00 / 100 + T.Populated_high_credit_extended_pcnt *   0.00 / 100 + T.Populated_median_credit_extended_pcnt *   0.00 / 100 + T.Populated_payment_performance_pcnt *   0.00 / 100 + T.Populated_payment_trend_pcnt *   0.00 / 100 + T.Populated_industry_description_pcnt *   0.00 / 100 + T.Populated_predicted_dbt_date_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','current_dbt','predicted_dbt','orig_predicted_dbt_date_mmddyy','average_industry_dbt','average_all_industries_dbt','low_balance','high_balance','current_account_balance','high_credit_extended','median_credit_extended','payment_performance','payment_trend','industry_description','predicted_dbt_date');
  SELF.populated_pcnt := CHOOSE(C,le.populated_powid_pcnt,le.populated_proxid_pcnt,le.populated_seleid_pcnt,le.populated_orgid_pcnt,le.populated_ultid_pcnt,le.populated_bdid_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_process_date_first_seen_pcnt,le.populated_process_date_last_seen_pcnt,le.populated_record_type_pcnt,le.populated_process_date_pcnt,le.populated_file_number_pcnt,le.populated_current_dbt_pcnt,le.populated_predicted_dbt_pcnt,le.populated_orig_predicted_dbt_date_mmddyy_pcnt,le.populated_average_industry_dbt_pcnt,le.populated_average_all_industries_dbt_pcnt,le.populated_low_balance_pcnt,le.populated_high_balance_pcnt,le.populated_current_account_balance_pcnt,le.populated_high_credit_extended_pcnt,le.populated_median_credit_extended_pcnt,le.populated_payment_performance_pcnt,le.populated_payment_trend_pcnt,le.populated_industry_description_pcnt,le.populated_predicted_dbt_date_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_powid,le.maxlength_proxid,le.maxlength_seleid,le.maxlength_orgid,le.maxlength_ultid,le.maxlength_bdid,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_process_date_first_seen,le.maxlength_process_date_last_seen,le.maxlength_record_type,le.maxlength_process_date,le.maxlength_file_number,le.maxlength_current_dbt,le.maxlength_predicted_dbt,le.maxlength_orig_predicted_dbt_date_mmddyy,le.maxlength_average_industry_dbt,le.maxlength_average_all_industries_dbt,le.maxlength_low_balance,le.maxlength_high_balance,le.maxlength_current_account_balance,le.maxlength_high_credit_extended,le.maxlength_median_credit_extended,le.maxlength_payment_performance,le.maxlength_payment_trend,le.maxlength_industry_description,le.maxlength_predicted_dbt_date);
  SELF.avelength := CHOOSE(C,le.avelength_powid,le.avelength_proxid,le.avelength_seleid,le.avelength_orgid,le.avelength_ultid,le.avelength_bdid,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_process_date_first_seen,le.avelength_process_date_last_seen,le.avelength_record_type,le.avelength_process_date,le.avelength_file_number,le.avelength_current_dbt,le.avelength_predicted_dbt,le.avelength_orig_predicted_dbt_date_mmddyy,le.avelength_average_industry_dbt,le.avelength_average_all_industries_dbt,le.avelength_low_balance,le.avelength_high_balance,le.avelength_current_account_balance,le.avelength_high_credit_extended,le.avelength_median_credit_extended,le.avelength_payment_performance,le.avelength_payment_trend,le.avelength_industry_description,le.avelength_predicted_dbt_date);
END;
EXPORT invSummary := NORMALIZE(summary0, 27, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.current_dbt),TRIM((SALT311.StrType)le.predicted_dbt),TRIM((SALT311.StrType)le.orig_predicted_dbt_date_mmddyy),TRIM((SALT311.StrType)le.average_industry_dbt),TRIM((SALT311.StrType)le.average_all_industries_dbt),TRIM((SALT311.StrType)le.low_balance),TRIM((SALT311.StrType)le.high_balance),TRIM((SALT311.StrType)le.current_account_balance),TRIM((SALT311.StrType)le.high_credit_extended),TRIM((SALT311.StrType)le.median_credit_extended),TRIM((SALT311.StrType)le.payment_performance),TRIM((SALT311.StrType)le.payment_trend),TRIM((SALT311.StrType)le.industry_description),TRIM((SALT311.StrType)le.predicted_dbt_date)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,27,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 27);
  SELF.FldNo2 := 1 + (C % 27);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.current_dbt),TRIM((SALT311.StrType)le.predicted_dbt),TRIM((SALT311.StrType)le.orig_predicted_dbt_date_mmddyy),TRIM((SALT311.StrType)le.average_industry_dbt),TRIM((SALT311.StrType)le.average_all_industries_dbt),TRIM((SALT311.StrType)le.low_balance),TRIM((SALT311.StrType)le.high_balance),TRIM((SALT311.StrType)le.current_account_balance),TRIM((SALT311.StrType)le.high_credit_extended),TRIM((SALT311.StrType)le.median_credit_extended),TRIM((SALT311.StrType)le.payment_performance),TRIM((SALT311.StrType)le.payment_trend),TRIM((SALT311.StrType)le.industry_description),TRIM((SALT311.StrType)le.predicted_dbt_date)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.current_dbt),TRIM((SALT311.StrType)le.predicted_dbt),TRIM((SALT311.StrType)le.orig_predicted_dbt_date_mmddyy),TRIM((SALT311.StrType)le.average_industry_dbt),TRIM((SALT311.StrType)le.average_all_industries_dbt),TRIM((SALT311.StrType)le.low_balance),TRIM((SALT311.StrType)le.high_balance),TRIM((SALT311.StrType)le.current_account_balance),TRIM((SALT311.StrType)le.high_credit_extended),TRIM((SALT311.StrType)le.median_credit_extended),TRIM((SALT311.StrType)le.payment_performance),TRIM((SALT311.StrType)le.payment_trend),TRIM((SALT311.StrType)le.industry_description),TRIM((SALT311.StrType)le.predicted_dbt_date)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),27*27,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{14,'current_dbt'}
      ,{15,'predicted_dbt'}
      ,{16,'orig_predicted_dbt_date_mmddyy'}
      ,{17,'average_industry_dbt'}
      ,{18,'average_all_industries_dbt'}
      ,{19,'low_balance'}
      ,{20,'high_balance'}
      ,{21,'current_account_balance'}
      ,{22,'high_credit_extended'}
      ,{23,'median_credit_extended'}
      ,{24,'payment_performance'}
      ,{25,'payment_trend'}
      ,{26,'industry_description'}
      ,{27,'predicted_dbt_date'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_1000_Fields.InValid_powid((SALT311.StrType)le.powid),
    Base_1000_Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Base_1000_Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Base_1000_Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Base_1000_Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Base_1000_Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Base_1000_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Base_1000_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Base_1000_Fields.InValid_process_date_first_seen((SALT311.StrType)le.process_date_first_seen),
    Base_1000_Fields.InValid_process_date_last_seen((SALT311.StrType)le.process_date_last_seen),
    Base_1000_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Base_1000_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Base_1000_Fields.InValid_file_number((SALT311.StrType)le.file_number),
    Base_1000_Fields.InValid_current_dbt((SALT311.StrType)le.current_dbt),
    Base_1000_Fields.InValid_predicted_dbt((SALT311.StrType)le.predicted_dbt),
    Base_1000_Fields.InValid_orig_predicted_dbt_date_mmddyy((SALT311.StrType)le.orig_predicted_dbt_date_mmddyy),
    Base_1000_Fields.InValid_average_industry_dbt((SALT311.StrType)le.average_industry_dbt),
    Base_1000_Fields.InValid_average_all_industries_dbt((SALT311.StrType)le.average_all_industries_dbt),
    Base_1000_Fields.InValid_low_balance((SALT311.StrType)le.low_balance),
    Base_1000_Fields.InValid_high_balance((SALT311.StrType)le.high_balance),
    Base_1000_Fields.InValid_current_account_balance((SALT311.StrType)le.current_account_balance),
    Base_1000_Fields.InValid_high_credit_extended((SALT311.StrType)le.high_credit_extended),
    Base_1000_Fields.InValid_median_credit_extended((SALT311.StrType)le.median_credit_extended),
    Base_1000_Fields.InValid_payment_performance((SALT311.StrType)le.payment_performance),
    Base_1000_Fields.InValid_payment_trend((SALT311.StrType)le.payment_trend),
    Base_1000_Fields.InValid_industry_description((SALT311.StrType)le.industry_description),
    Base_1000_Fields.InValid_predicted_dbt_date((SALT311.StrType)le.predicted_dbt_date),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,27,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_1000_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_numeric','invalid_dt_first_seen','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_record_type','invalid_pastdate','invalid_file_number','invalid_numeric','invalid_numeric','invalid_mmddyy_Date','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_payment_performance','invalid_payment_trend','invalid_mandatory','invalid_generaldate');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_1000_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_process_date_first_seen(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_process_date_last_seen(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_file_number(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_current_dbt(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_predicted_dbt(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_orig_predicted_dbt_date_mmddyy(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_average_industry_dbt(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_average_all_industries_dbt(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_low_balance(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_high_balance(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_current_account_balance(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_high_credit_extended(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_median_credit_extended(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_payment_performance(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_payment_trend(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_industry_description(TotalErrors.ErrorNum),Base_1000_Fields.InValidMessage_predicted_dbt_date(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_1000_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

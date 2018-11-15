IMPORT SALT311,STD;
EXPORT Base_2000_hygiene(dataset(Base_2000_layout_EBR) h) := MODULE
 
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
    populated_payment_indicator_cnt := COUNT(GROUP,h.payment_indicator <> (TYPEOF(h.payment_indicator))'');
    populated_payment_indicator_pcnt := AVE(GROUP,IF(h.payment_indicator = (TYPEOF(h.payment_indicator))'',0,100));
    maxlength_payment_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.payment_indicator)));
    avelength_payment_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.payment_indicator)),h.payment_indicator<>(typeof(h.payment_indicator))'');
    populated_business_category_code_cnt := COUNT(GROUP,h.business_category_code <> (TYPEOF(h.business_category_code))'');
    populated_business_category_code_pcnt := AVE(GROUP,IF(h.business_category_code = (TYPEOF(h.business_category_code))'',0,100));
    maxlength_business_category_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_category_code)));
    avelength_business_category_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_category_code)),h.business_category_code<>(typeof(h.business_category_code))'');
    populated_business_category_description_cnt := COUNT(GROUP,h.business_category_description <> (TYPEOF(h.business_category_description))'');
    populated_business_category_description_pcnt := AVE(GROUP,IF(h.business_category_description = (TYPEOF(h.business_category_description))'',0,100));
    maxlength_business_category_description := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_category_description)));
    avelength_business_category_description := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_category_description)),h.business_category_description<>(typeof(h.business_category_description))'');
    populated_orig_date_reported_ymd_cnt := COUNT(GROUP,h.orig_date_reported_ymd <> (TYPEOF(h.orig_date_reported_ymd))'');
    populated_orig_date_reported_ymd_pcnt := AVE(GROUP,IF(h.orig_date_reported_ymd = (TYPEOF(h.orig_date_reported_ymd))'',0,100));
    maxlength_orig_date_reported_ymd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_date_reported_ymd)));
    avelength_orig_date_reported_ymd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_date_reported_ymd)),h.orig_date_reported_ymd<>(typeof(h.orig_date_reported_ymd))'');
    populated_orig_date_last_sale_ym_cnt := COUNT(GROUP,h.orig_date_last_sale_ym <> (TYPEOF(h.orig_date_last_sale_ym))'');
    populated_orig_date_last_sale_ym_pcnt := AVE(GROUP,IF(h.orig_date_last_sale_ym = (TYPEOF(h.orig_date_last_sale_ym))'',0,100));
    maxlength_orig_date_last_sale_ym := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_date_last_sale_ym)));
    avelength_orig_date_last_sale_ym := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_date_last_sale_ym)),h.orig_date_last_sale_ym<>(typeof(h.orig_date_last_sale_ym))'');
    populated_payment_terms_cnt := COUNT(GROUP,h.payment_terms <> (TYPEOF(h.payment_terms))'');
    populated_payment_terms_pcnt := AVE(GROUP,IF(h.payment_terms = (TYPEOF(h.payment_terms))'',0,100));
    maxlength_payment_terms := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.payment_terms)));
    avelength_payment_terms := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.payment_terms)),h.payment_terms<>(typeof(h.payment_terms))'');
    populated_high_credit_mask_cnt := COUNT(GROUP,h.high_credit_mask <> (TYPEOF(h.high_credit_mask))'');
    populated_high_credit_mask_pcnt := AVE(GROUP,IF(h.high_credit_mask = (TYPEOF(h.high_credit_mask))'',0,100));
    maxlength_high_credit_mask := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_credit_mask)));
    avelength_high_credit_mask := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_credit_mask)),h.high_credit_mask<>(typeof(h.high_credit_mask))'');
    populated_recent_high_credit_cnt := COUNT(GROUP,h.recent_high_credit <> (TYPEOF(h.recent_high_credit))'');
    populated_recent_high_credit_pcnt := AVE(GROUP,IF(h.recent_high_credit = (TYPEOF(h.recent_high_credit))'',0,100));
    maxlength_recent_high_credit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recent_high_credit)));
    avelength_recent_high_credit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recent_high_credit)),h.recent_high_credit<>(typeof(h.recent_high_credit))'');
    populated_account_balance_mask_cnt := COUNT(GROUP,h.account_balance_mask <> (TYPEOF(h.account_balance_mask))'');
    populated_account_balance_mask_pcnt := AVE(GROUP,IF(h.account_balance_mask = (TYPEOF(h.account_balance_mask))'',0,100));
    maxlength_account_balance_mask := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_balance_mask)));
    avelength_account_balance_mask := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_balance_mask)),h.account_balance_mask<>(typeof(h.account_balance_mask))'');
    populated_masked_account_balance_cnt := COUNT(GROUP,h.masked_account_balance <> (TYPEOF(h.masked_account_balance))'');
    populated_masked_account_balance_pcnt := AVE(GROUP,IF(h.masked_account_balance = (TYPEOF(h.masked_account_balance))'',0,100));
    maxlength_masked_account_balance := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.masked_account_balance)));
    avelength_masked_account_balance := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.masked_account_balance)),h.masked_account_balance<>(typeof(h.masked_account_balance))'');
    populated_current_percent_cnt := COUNT(GROUP,h.current_percent <> (TYPEOF(h.current_percent))'');
    populated_current_percent_pcnt := AVE(GROUP,IF(h.current_percent = (TYPEOF(h.current_percent))'',0,100));
    maxlength_current_percent := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_percent)));
    avelength_current_percent := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_percent)),h.current_percent<>(typeof(h.current_percent))'');
    populated_debt_01_30_percent_cnt := COUNT(GROUP,h.debt_01_30_percent <> (TYPEOF(h.debt_01_30_percent))'');
    populated_debt_01_30_percent_pcnt := AVE(GROUP,IF(h.debt_01_30_percent = (TYPEOF(h.debt_01_30_percent))'',0,100));
    maxlength_debt_01_30_percent := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_01_30_percent)));
    avelength_debt_01_30_percent := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_01_30_percent)),h.debt_01_30_percent<>(typeof(h.debt_01_30_percent))'');
    populated_debt_31_60_percent_cnt := COUNT(GROUP,h.debt_31_60_percent <> (TYPEOF(h.debt_31_60_percent))'');
    populated_debt_31_60_percent_pcnt := AVE(GROUP,IF(h.debt_31_60_percent = (TYPEOF(h.debt_31_60_percent))'',0,100));
    maxlength_debt_31_60_percent := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_31_60_percent)));
    avelength_debt_31_60_percent := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_31_60_percent)),h.debt_31_60_percent<>(typeof(h.debt_31_60_percent))'');
    populated_debt_61_90_percent_cnt := COUNT(GROUP,h.debt_61_90_percent <> (TYPEOF(h.debt_61_90_percent))'');
    populated_debt_61_90_percent_pcnt := AVE(GROUP,IF(h.debt_61_90_percent = (TYPEOF(h.debt_61_90_percent))'',0,100));
    maxlength_debt_61_90_percent := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_61_90_percent)));
    avelength_debt_61_90_percent := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_61_90_percent)),h.debt_61_90_percent<>(typeof(h.debt_61_90_percent))'');
    populated_debt_91_plus_percent_cnt := COUNT(GROUP,h.debt_91_plus_percent <> (TYPEOF(h.debt_91_plus_percent))'');
    populated_debt_91_plus_percent_pcnt := AVE(GROUP,IF(h.debt_91_plus_percent = (TYPEOF(h.debt_91_plus_percent))'',0,100));
    maxlength_debt_91_plus_percent := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_91_plus_percent)));
    avelength_debt_91_plus_percent := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.debt_91_plus_percent)),h.debt_91_plus_percent<>(typeof(h.debt_91_plus_percent))'');
    populated_new_trade_flag_cnt := COUNT(GROUP,h.new_trade_flag <> (TYPEOF(h.new_trade_flag))'');
    populated_new_trade_flag_pcnt := AVE(GROUP,IF(h.new_trade_flag = (TYPEOF(h.new_trade_flag))'',0,100));
    maxlength_new_trade_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.new_trade_flag)));
    avelength_new_trade_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.new_trade_flag)),h.new_trade_flag<>(typeof(h.new_trade_flag))'');
    populated_trade_type_code_cnt := COUNT(GROUP,h.trade_type_code <> (TYPEOF(h.trade_type_code))'');
    populated_trade_type_code_pcnt := AVE(GROUP,IF(h.trade_type_code = (TYPEOF(h.trade_type_code))'',0,100));
    maxlength_trade_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trade_type_code)));
    avelength_trade_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trade_type_code)),h.trade_type_code<>(typeof(h.trade_type_code))'');
    populated_trade_type_desc_cnt := COUNT(GROUP,h.trade_type_desc <> (TYPEOF(h.trade_type_desc))'');
    populated_trade_type_desc_pcnt := AVE(GROUP,IF(h.trade_type_desc = (TYPEOF(h.trade_type_desc))'',0,100));
    maxlength_trade_type_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trade_type_desc)));
    avelength_trade_type_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trade_type_desc)),h.trade_type_desc<>(typeof(h.trade_type_desc))'');
    populated_date_reported_cnt := COUNT(GROUP,h.date_reported <> (TYPEOF(h.date_reported))'');
    populated_date_reported_pcnt := AVE(GROUP,IF(h.date_reported = (TYPEOF(h.date_reported))'',0,100));
    maxlength_date_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_reported)));
    avelength_date_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_reported)),h.date_reported<>(typeof(h.date_reported))'');
    populated_date_last_sale_cnt := COUNT(GROUP,h.date_last_sale <> (TYPEOF(h.date_last_sale))'');
    populated_date_last_sale_pcnt := AVE(GROUP,IF(h.date_last_sale = (TYPEOF(h.date_last_sale))'',0,100));
    maxlength_date_last_sale := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_last_sale)));
    avelength_date_last_sale := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_last_sale)),h.date_last_sale<>(typeof(h.date_last_sale))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_process_date_first_seen_pcnt *   0.00 / 100 + T.Populated_process_date_last_seen_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_file_number_pcnt *   0.00 / 100 + T.Populated_segment_code_pcnt *   0.00 / 100 + T.Populated_sequence_number_pcnt *   0.00 / 100 + T.Populated_payment_indicator_pcnt *   0.00 / 100 + T.Populated_business_category_code_pcnt *   0.00 / 100 + T.Populated_business_category_description_pcnt *   0.00 / 100 + T.Populated_orig_date_reported_ymd_pcnt *   0.00 / 100 + T.Populated_orig_date_last_sale_ym_pcnt *   0.00 / 100 + T.Populated_payment_terms_pcnt *   0.00 / 100 + T.Populated_high_credit_mask_pcnt *   0.00 / 100 + T.Populated_recent_high_credit_pcnt *   0.00 / 100 + T.Populated_account_balance_mask_pcnt *   0.00 / 100 + T.Populated_masked_account_balance_pcnt *   0.00 / 100 + T.Populated_current_percent_pcnt *   0.00 / 100 + T.Populated_debt_01_30_percent_pcnt *   0.00 / 100 + T.Populated_debt_31_60_percent_pcnt *   0.00 / 100 + T.Populated_debt_61_90_percent_pcnt *   0.00 / 100 + T.Populated_debt_91_plus_percent_pcnt *   0.00 / 100 + T.Populated_new_trade_flag_pcnt *   0.00 / 100 + T.Populated_trade_type_code_pcnt *   0.00 / 100 + T.Populated_trade_type_desc_pcnt *   0.00 / 100 + T.Populated_date_reported_pcnt *   0.00 / 100 + T.Populated_date_last_sale_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','payment_indicator','business_category_code','business_category_description','orig_date_reported_ymd','orig_date_last_sale_ym','payment_terms','high_credit_mask','recent_high_credit','account_balance_mask','masked_account_balance','current_percent','debt_01_30_percent','debt_31_60_percent','debt_61_90_percent','debt_91_plus_percent','new_trade_flag','trade_type_code','trade_type_desc','date_reported','date_last_sale');
  SELF.populated_pcnt := CHOOSE(C,le.populated_powid_pcnt,le.populated_proxid_pcnt,le.populated_seleid_pcnt,le.populated_orgid_pcnt,le.populated_ultid_pcnt,le.populated_bdid_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_process_date_first_seen_pcnt,le.populated_process_date_last_seen_pcnt,le.populated_record_type_pcnt,le.populated_process_date_pcnt,le.populated_file_number_pcnt,le.populated_segment_code_pcnt,le.populated_sequence_number_pcnt,le.populated_payment_indicator_pcnt,le.populated_business_category_code_pcnt,le.populated_business_category_description_pcnt,le.populated_orig_date_reported_ymd_pcnt,le.populated_orig_date_last_sale_ym_pcnt,le.populated_payment_terms_pcnt,le.populated_high_credit_mask_pcnt,le.populated_recent_high_credit_pcnt,le.populated_account_balance_mask_pcnt,le.populated_masked_account_balance_pcnt,le.populated_current_percent_pcnt,le.populated_debt_01_30_percent_pcnt,le.populated_debt_31_60_percent_pcnt,le.populated_debt_61_90_percent_pcnt,le.populated_debt_91_plus_percent_pcnt,le.populated_new_trade_flag_pcnt,le.populated_trade_type_code_pcnt,le.populated_trade_type_desc_pcnt,le.populated_date_reported_pcnt,le.populated_date_last_sale_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_powid,le.maxlength_proxid,le.maxlength_seleid,le.maxlength_orgid,le.maxlength_ultid,le.maxlength_bdid,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_process_date_first_seen,le.maxlength_process_date_last_seen,le.maxlength_record_type,le.maxlength_process_date,le.maxlength_file_number,le.maxlength_segment_code,le.maxlength_sequence_number,le.maxlength_payment_indicator,le.maxlength_business_category_code,le.maxlength_business_category_description,le.maxlength_orig_date_reported_ymd,le.maxlength_orig_date_last_sale_ym,le.maxlength_payment_terms,le.maxlength_high_credit_mask,le.maxlength_recent_high_credit,le.maxlength_account_balance_mask,le.maxlength_masked_account_balance,le.maxlength_current_percent,le.maxlength_debt_01_30_percent,le.maxlength_debt_31_60_percent,le.maxlength_debt_61_90_percent,le.maxlength_debt_91_plus_percent,le.maxlength_new_trade_flag,le.maxlength_trade_type_code,le.maxlength_trade_type_desc,le.maxlength_date_reported,le.maxlength_date_last_sale);
  SELF.avelength := CHOOSE(C,le.avelength_powid,le.avelength_proxid,le.avelength_seleid,le.avelength_orgid,le.avelength_ultid,le.avelength_bdid,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_process_date_first_seen,le.avelength_process_date_last_seen,le.avelength_record_type,le.avelength_process_date,le.avelength_file_number,le.avelength_segment_code,le.avelength_sequence_number,le.avelength_payment_indicator,le.avelength_business_category_code,le.avelength_business_category_description,le.avelength_orig_date_reported_ymd,le.avelength_orig_date_last_sale_ym,le.avelength_payment_terms,le.avelength_high_credit_mask,le.avelength_recent_high_credit,le.avelength_account_balance_mask,le.avelength_masked_account_balance,le.avelength_current_percent,le.avelength_debt_01_30_percent,le.avelength_debt_31_60_percent,le.avelength_debt_61_90_percent,le.avelength_debt_91_plus_percent,le.avelength_new_trade_flag,le.avelength_trade_type_code,le.avelength_trade_type_desc,le.avelength_date_reported,le.avelength_date_last_sale);
END;
EXPORT invSummary := NORMALIZE(summary0, 35, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.payment_indicator),TRIM((SALT311.StrType)le.business_category_code),TRIM((SALT311.StrType)le.business_category_description),TRIM((SALT311.StrType)le.orig_date_reported_ymd),TRIM((SALT311.StrType)le.orig_date_last_sale_ym),TRIM((SALT311.StrType)le.payment_terms),TRIM((SALT311.StrType)le.high_credit_mask),TRIM((SALT311.StrType)le.recent_high_credit),TRIM((SALT311.StrType)le.account_balance_mask),TRIM((SALT311.StrType)le.masked_account_balance),TRIM((SALT311.StrType)le.current_percent),TRIM((SALT311.StrType)le.debt_01_30_percent),TRIM((SALT311.StrType)le.debt_31_60_percent),TRIM((SALT311.StrType)le.debt_61_90_percent),TRIM((SALT311.StrType)le.debt_91_plus_percent),TRIM((SALT311.StrType)le.new_trade_flag),TRIM((SALT311.StrType)le.trade_type_code),TRIM((SALT311.StrType)le.trade_type_desc),TRIM((SALT311.StrType)le.date_reported),TRIM((SALT311.StrType)le.date_last_sale)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,35,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 35);
  SELF.FldNo2 := 1 + (C % 35);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.payment_indicator),TRIM((SALT311.StrType)le.business_category_code),TRIM((SALT311.StrType)le.business_category_description),TRIM((SALT311.StrType)le.orig_date_reported_ymd),TRIM((SALT311.StrType)le.orig_date_last_sale_ym),TRIM((SALT311.StrType)le.payment_terms),TRIM((SALT311.StrType)le.high_credit_mask),TRIM((SALT311.StrType)le.recent_high_credit),TRIM((SALT311.StrType)le.account_balance_mask),TRIM((SALT311.StrType)le.masked_account_balance),TRIM((SALT311.StrType)le.current_percent),TRIM((SALT311.StrType)le.debt_01_30_percent),TRIM((SALT311.StrType)le.debt_31_60_percent),TRIM((SALT311.StrType)le.debt_61_90_percent),TRIM((SALT311.StrType)le.debt_91_plus_percent),TRIM((SALT311.StrType)le.new_trade_flag),TRIM((SALT311.StrType)le.trade_type_code),TRIM((SALT311.StrType)le.trade_type_desc),TRIM((SALT311.StrType)le.date_reported),TRIM((SALT311.StrType)le.date_last_sale)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.payment_indicator),TRIM((SALT311.StrType)le.business_category_code),TRIM((SALT311.StrType)le.business_category_description),TRIM((SALT311.StrType)le.orig_date_reported_ymd),TRIM((SALT311.StrType)le.orig_date_last_sale_ym),TRIM((SALT311.StrType)le.payment_terms),TRIM((SALT311.StrType)le.high_credit_mask),TRIM((SALT311.StrType)le.recent_high_credit),TRIM((SALT311.StrType)le.account_balance_mask),TRIM((SALT311.StrType)le.masked_account_balance),TRIM((SALT311.StrType)le.current_percent),TRIM((SALT311.StrType)le.debt_01_30_percent),TRIM((SALT311.StrType)le.debt_31_60_percent),TRIM((SALT311.StrType)le.debt_61_90_percent),TRIM((SALT311.StrType)le.debt_91_plus_percent),TRIM((SALT311.StrType)le.new_trade_flag),TRIM((SALT311.StrType)le.trade_type_code),TRIM((SALT311.StrType)le.trade_type_desc),TRIM((SALT311.StrType)le.date_reported),TRIM((SALT311.StrType)le.date_last_sale)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),35*35,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{16,'payment_indicator'}
      ,{17,'business_category_code'}
      ,{18,'business_category_description'}
      ,{19,'orig_date_reported_ymd'}
      ,{20,'orig_date_last_sale_ym'}
      ,{21,'payment_terms'}
      ,{22,'high_credit_mask'}
      ,{23,'recent_high_credit'}
      ,{24,'account_balance_mask'}
      ,{25,'masked_account_balance'}
      ,{26,'current_percent'}
      ,{27,'debt_01_30_percent'}
      ,{28,'debt_31_60_percent'}
      ,{29,'debt_61_90_percent'}
      ,{30,'debt_91_plus_percent'}
      ,{31,'new_trade_flag'}
      ,{32,'trade_type_code'}
      ,{33,'trade_type_desc'}
      ,{34,'date_reported'}
      ,{35,'date_last_sale'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_2000_Fields.InValid_powid((SALT311.StrType)le.powid),
    Base_2000_Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Base_2000_Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Base_2000_Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Base_2000_Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Base_2000_Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Base_2000_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Base_2000_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Base_2000_Fields.InValid_process_date_first_seen((SALT311.StrType)le.process_date_first_seen),
    Base_2000_Fields.InValid_process_date_last_seen((SALT311.StrType)le.process_date_last_seen),
    Base_2000_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Base_2000_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Base_2000_Fields.InValid_file_number((SALT311.StrType)le.file_number),
    Base_2000_Fields.InValid_segment_code((SALT311.StrType)le.segment_code),
    Base_2000_Fields.InValid_sequence_number((SALT311.StrType)le.sequence_number),
    Base_2000_Fields.InValid_payment_indicator((SALT311.StrType)le.payment_indicator),
    Base_2000_Fields.InValid_business_category_code((SALT311.StrType)le.business_category_code),
    Base_2000_Fields.InValid_business_category_description((SALT311.StrType)le.business_category_description),
    Base_2000_Fields.InValid_orig_date_reported_ymd((SALT311.StrType)le.orig_date_reported_ymd),
    Base_2000_Fields.InValid_orig_date_last_sale_ym((SALT311.StrType)le.orig_date_last_sale_ym),
    Base_2000_Fields.InValid_payment_terms((SALT311.StrType)le.payment_terms),
    Base_2000_Fields.InValid_high_credit_mask((SALT311.StrType)le.high_credit_mask),
    Base_2000_Fields.InValid_recent_high_credit((SALT311.StrType)le.recent_high_credit),
    Base_2000_Fields.InValid_account_balance_mask((SALT311.StrType)le.account_balance_mask),
    Base_2000_Fields.InValid_masked_account_balance((SALT311.StrType)le.masked_account_balance),
    Base_2000_Fields.InValid_current_percent((SALT311.StrType)le.current_percent),
    Base_2000_Fields.InValid_debt_01_30_percent((SALT311.StrType)le.debt_01_30_percent),
    Base_2000_Fields.InValid_debt_31_60_percent((SALT311.StrType)le.debt_31_60_percent),
    Base_2000_Fields.InValid_debt_61_90_percent((SALT311.StrType)le.debt_61_90_percent),
    Base_2000_Fields.InValid_debt_91_plus_percent((SALT311.StrType)le.debt_91_plus_percent),
    Base_2000_Fields.InValid_new_trade_flag((SALT311.StrType)le.new_trade_flag),
    Base_2000_Fields.InValid_trade_type_code((SALT311.StrType)le.trade_type_code),
    Base_2000_Fields.InValid_trade_type_desc((SALT311.StrType)le.trade_type_desc),
    Base_2000_Fields.InValid_date_reported((SALT311.StrType)le.date_reported),
    Base_2000_Fields.InValid_date_last_sale((SALT311.StrType)le.date_last_sale),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,35,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_2000_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_numeric','invalid_dt_first_seen','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_record_type','invalid_pastdate','invalid_file_number','invalid_segment','invalid_numeric_or_allzeros','invalid_payment_indicator','invalid_numeric','invalid_mandatory','invalid_dt_yymmdd','invalid_dt_yymm_or_0000','invalid_mandatory','invalid_mask','invalid_numeric_or_allzeros','invalid_mask','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_flag','invalid_trade_code','invalid_trade_desc','invalid_pastdate','invalid_dt_ccyymm_or_200000');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_2000_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_process_date_first_seen(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_process_date_last_seen(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_file_number(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_segment_code(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_sequence_number(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_payment_indicator(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_business_category_code(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_business_category_description(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_orig_date_reported_ymd(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_orig_date_last_sale_ym(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_payment_terms(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_high_credit_mask(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_recent_high_credit(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_account_balance_mask(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_masked_account_balance(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_current_percent(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_debt_01_30_percent(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_debt_31_60_percent(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_debt_61_90_percent(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_debt_91_plus_percent(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_new_trade_flag(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_trade_type_code(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_trade_type_desc(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_date_reported(TotalErrors.ErrorNum),Base_2000_Fields.InValidMessage_date_last_sale(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_2000_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

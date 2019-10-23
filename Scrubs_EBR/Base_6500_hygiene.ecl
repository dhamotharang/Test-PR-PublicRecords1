IMPORT SALT311,STD;
EXPORT Base_6500_hygiene(dataset(Base_6500_layout_EBR) h) := MODULE
 
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
    populated_bus_cat_code_cnt := COUNT(GROUP,h.bus_cat_code <> (TYPEOF(h.bus_cat_code))'');
    populated_bus_cat_code_pcnt := AVE(GROUP,IF(h.bus_cat_code = (TYPEOF(h.bus_cat_code))'',0,100));
    maxlength_bus_cat_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bus_cat_code)));
    avelength_bus_cat_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bus_cat_code)),h.bus_cat_code<>(typeof(h.bus_cat_code))'');
    populated_bus_cat_desc_cnt := COUNT(GROUP,h.bus_cat_desc <> (TYPEOF(h.bus_cat_desc))'');
    populated_bus_cat_desc_pcnt := AVE(GROUP,IF(h.bus_cat_desc = (TYPEOF(h.bus_cat_desc))'',0,100));
    maxlength_bus_cat_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bus_cat_desc)));
    avelength_bus_cat_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bus_cat_desc)),h.bus_cat_desc<>(typeof(h.bus_cat_desc))'');
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
    populated_acct_bal_mask_cnt := COUNT(GROUP,h.acct_bal_mask <> (TYPEOF(h.acct_bal_mask))'');
    populated_acct_bal_mask_pcnt := AVE(GROUP,IF(h.acct_bal_mask = (TYPEOF(h.acct_bal_mask))'',0,100));
    maxlength_acct_bal_mask := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.acct_bal_mask)));
    avelength_acct_bal_mask := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.acct_bal_mask)),h.acct_bal_mask<>(typeof(h.acct_bal_mask))'');
    populated_masked_acct_bal_cnt := COUNT(GROUP,h.masked_acct_bal <> (TYPEOF(h.masked_acct_bal))'');
    populated_masked_acct_bal_pcnt := AVE(GROUP,IF(h.masked_acct_bal = (TYPEOF(h.masked_acct_bal))'',0,100));
    maxlength_masked_acct_bal := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.masked_acct_bal)));
    avelength_masked_acct_bal := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.masked_acct_bal)),h.masked_acct_bal<>(typeof(h.masked_acct_bal))'');
    populated_current_pct_cnt := COUNT(GROUP,h.current_pct <> (TYPEOF(h.current_pct))'');
    populated_current_pct_pcnt := AVE(GROUP,IF(h.current_pct = (TYPEOF(h.current_pct))'',0,100));
    maxlength_current_pct := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_pct)));
    avelength_current_pct := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_pct)),h.current_pct<>(typeof(h.current_pct))'');
    populated_dbt_01_30_pct_cnt := COUNT(GROUP,h.dbt_01_30_pct <> (TYPEOF(h.dbt_01_30_pct))'');
    populated_dbt_01_30_pct_pcnt := AVE(GROUP,IF(h.dbt_01_30_pct = (TYPEOF(h.dbt_01_30_pct))'',0,100));
    maxlength_dbt_01_30_pct := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbt_01_30_pct)));
    avelength_dbt_01_30_pct := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbt_01_30_pct)),h.dbt_01_30_pct<>(typeof(h.dbt_01_30_pct))'');
    populated_dbt_31_60_pct_cnt := COUNT(GROUP,h.dbt_31_60_pct <> (TYPEOF(h.dbt_31_60_pct))'');
    populated_dbt_31_60_pct_pcnt := AVE(GROUP,IF(h.dbt_31_60_pct = (TYPEOF(h.dbt_31_60_pct))'',0,100));
    maxlength_dbt_31_60_pct := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbt_31_60_pct)));
    avelength_dbt_31_60_pct := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbt_31_60_pct)),h.dbt_31_60_pct<>(typeof(h.dbt_31_60_pct))'');
    populated_dbt_61_90_pct_cnt := COUNT(GROUP,h.dbt_61_90_pct <> (TYPEOF(h.dbt_61_90_pct))'');
    populated_dbt_61_90_pct_pcnt := AVE(GROUP,IF(h.dbt_61_90_pct = (TYPEOF(h.dbt_61_90_pct))'',0,100));
    maxlength_dbt_61_90_pct := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbt_61_90_pct)));
    avelength_dbt_61_90_pct := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbt_61_90_pct)),h.dbt_61_90_pct<>(typeof(h.dbt_61_90_pct))'');
    populated_dbt_91_plus_pct_cnt := COUNT(GROUP,h.dbt_91_plus_pct <> (TYPEOF(h.dbt_91_plus_pct))'');
    populated_dbt_91_plus_pct_pcnt := AVE(GROUP,IF(h.dbt_91_plus_pct = (TYPEOF(h.dbt_91_plus_pct))'',0,100));
    maxlength_dbt_91_plus_pct := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbt_91_plus_pct)));
    avelength_dbt_91_plus_pct := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbt_91_plus_pct)),h.dbt_91_plus_pct<>(typeof(h.dbt_91_plus_pct))'');
    populated_comment_code_cnt := COUNT(GROUP,h.comment_code <> (TYPEOF(h.comment_code))'');
    populated_comment_code_pcnt := AVE(GROUP,IF(h.comment_code = (TYPEOF(h.comment_code))'',0,100));
    maxlength_comment_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.comment_code)));
    avelength_comment_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.comment_code)),h.comment_code<>(typeof(h.comment_code))'');
    populated_comment_desc_cnt := COUNT(GROUP,h.comment_desc <> (TYPEOF(h.comment_desc))'');
    populated_comment_desc_pcnt := AVE(GROUP,IF(h.comment_desc = (TYPEOF(h.comment_desc))'',0,100));
    maxlength_comment_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.comment_desc)));
    avelength_comment_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.comment_desc)),h.comment_desc<>(typeof(h.comment_desc))'');
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
    UNSIGNED LinkingPotential :=  + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_process_date_first_seen_pcnt *   0.00 / 100 + T.Populated_process_date_last_seen_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_file_number_pcnt *   0.00 / 100 + T.Populated_segment_code_pcnt *   0.00 / 100 + T.Populated_sequence_number_pcnt *   0.00 / 100 + T.Populated_bus_cat_code_pcnt *   0.00 / 100 + T.Populated_bus_cat_desc_pcnt *   0.00 / 100 + T.Populated_orig_date_reported_ymd_pcnt *   0.00 / 100 + T.Populated_orig_date_last_sale_ym_pcnt *   0.00 / 100 + T.Populated_payment_terms_pcnt *   0.00 / 100 + T.Populated_high_credit_mask_pcnt *   0.00 / 100 + T.Populated_recent_high_credit_pcnt *   0.00 / 100 + T.Populated_acct_bal_mask_pcnt *   0.00 / 100 + T.Populated_masked_acct_bal_pcnt *   0.00 / 100 + T.Populated_current_pct_pcnt *   0.00 / 100 + T.Populated_dbt_01_30_pct_pcnt *   0.00 / 100 + T.Populated_dbt_31_60_pct_pcnt *   0.00 / 100 + T.Populated_dbt_61_90_pct_pcnt *   0.00 / 100 + T.Populated_dbt_91_plus_pct_pcnt *   0.00 / 100 + T.Populated_comment_code_pcnt *   0.00 / 100 + T.Populated_comment_desc_pcnt *   0.00 / 100 + T.Populated_date_reported_pcnt *   0.00 / 100 + T.Populated_date_last_sale_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','bus_cat_code','bus_cat_desc','orig_date_reported_ymd','orig_date_last_sale_ym','payment_terms','high_credit_mask','recent_high_credit','acct_bal_mask','masked_acct_bal','current_pct','dbt_01_30_pct','dbt_31_60_pct','dbt_61_90_pct','dbt_91_plus_pct','comment_code','comment_desc','date_reported','date_last_sale');
  SELF.populated_pcnt := CHOOSE(C,le.populated_powid_pcnt,le.populated_proxid_pcnt,le.populated_seleid_pcnt,le.populated_orgid_pcnt,le.populated_ultid_pcnt,le.populated_bdid_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_process_date_first_seen_pcnt,le.populated_process_date_last_seen_pcnt,le.populated_record_type_pcnt,le.populated_process_date_pcnt,le.populated_file_number_pcnt,le.populated_segment_code_pcnt,le.populated_sequence_number_pcnt,le.populated_bus_cat_code_pcnt,le.populated_bus_cat_desc_pcnt,le.populated_orig_date_reported_ymd_pcnt,le.populated_orig_date_last_sale_ym_pcnt,le.populated_payment_terms_pcnt,le.populated_high_credit_mask_pcnt,le.populated_recent_high_credit_pcnt,le.populated_acct_bal_mask_pcnt,le.populated_masked_acct_bal_pcnt,le.populated_current_pct_pcnt,le.populated_dbt_01_30_pct_pcnt,le.populated_dbt_31_60_pct_pcnt,le.populated_dbt_61_90_pct_pcnt,le.populated_dbt_91_plus_pct_pcnt,le.populated_comment_code_pcnt,le.populated_comment_desc_pcnt,le.populated_date_reported_pcnt,le.populated_date_last_sale_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_powid,le.maxlength_proxid,le.maxlength_seleid,le.maxlength_orgid,le.maxlength_ultid,le.maxlength_bdid,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_process_date_first_seen,le.maxlength_process_date_last_seen,le.maxlength_record_type,le.maxlength_process_date,le.maxlength_file_number,le.maxlength_segment_code,le.maxlength_sequence_number,le.maxlength_bus_cat_code,le.maxlength_bus_cat_desc,le.maxlength_orig_date_reported_ymd,le.maxlength_orig_date_last_sale_ym,le.maxlength_payment_terms,le.maxlength_high_credit_mask,le.maxlength_recent_high_credit,le.maxlength_acct_bal_mask,le.maxlength_masked_acct_bal,le.maxlength_current_pct,le.maxlength_dbt_01_30_pct,le.maxlength_dbt_31_60_pct,le.maxlength_dbt_61_90_pct,le.maxlength_dbt_91_plus_pct,le.maxlength_comment_code,le.maxlength_comment_desc,le.maxlength_date_reported,le.maxlength_date_last_sale);
  SELF.avelength := CHOOSE(C,le.avelength_powid,le.avelength_proxid,le.avelength_seleid,le.avelength_orgid,le.avelength_ultid,le.avelength_bdid,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_process_date_first_seen,le.avelength_process_date_last_seen,le.avelength_record_type,le.avelength_process_date,le.avelength_file_number,le.avelength_segment_code,le.avelength_sequence_number,le.avelength_bus_cat_code,le.avelength_bus_cat_desc,le.avelength_orig_date_reported_ymd,le.avelength_orig_date_last_sale_ym,le.avelength_payment_terms,le.avelength_high_credit_mask,le.avelength_recent_high_credit,le.avelength_acct_bal_mask,le.avelength_masked_acct_bal,le.avelength_current_pct,le.avelength_dbt_01_30_pct,le.avelength_dbt_31_60_pct,le.avelength_dbt_61_90_pct,le.avelength_dbt_91_plus_pct,le.avelength_comment_code,le.avelength_comment_desc,le.avelength_date_reported,le.avelength_date_last_sale);
END;
EXPORT invSummary := NORMALIZE(summary0, 33, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.bus_cat_code),TRIM((SALT311.StrType)le.bus_cat_desc),TRIM((SALT311.StrType)le.orig_date_reported_ymd),TRIM((SALT311.StrType)le.orig_date_last_sale_ym),TRIM((SALT311.StrType)le.payment_terms),TRIM((SALT311.StrType)le.high_credit_mask),TRIM((SALT311.StrType)le.recent_high_credit),TRIM((SALT311.StrType)le.acct_bal_mask),TRIM((SALT311.StrType)le.masked_acct_bal),TRIM((SALT311.StrType)le.current_pct),TRIM((SALT311.StrType)le.dbt_01_30_pct),TRIM((SALT311.StrType)le.dbt_31_60_pct),TRIM((SALT311.StrType)le.dbt_61_90_pct),TRIM((SALT311.StrType)le.dbt_91_plus_pct),TRIM((SALT311.StrType)le.comment_code),TRIM((SALT311.StrType)le.comment_desc),TRIM((SALT311.StrType)le.date_reported),TRIM((SALT311.StrType)le.date_last_sale)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,33,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 33);
  SELF.FldNo2 := 1 + (C % 33);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.bus_cat_code),TRIM((SALT311.StrType)le.bus_cat_desc),TRIM((SALT311.StrType)le.orig_date_reported_ymd),TRIM((SALT311.StrType)le.orig_date_last_sale_ym),TRIM((SALT311.StrType)le.payment_terms),TRIM((SALT311.StrType)le.high_credit_mask),TRIM((SALT311.StrType)le.recent_high_credit),TRIM((SALT311.StrType)le.acct_bal_mask),TRIM((SALT311.StrType)le.masked_acct_bal),TRIM((SALT311.StrType)le.current_pct),TRIM((SALT311.StrType)le.dbt_01_30_pct),TRIM((SALT311.StrType)le.dbt_31_60_pct),TRIM((SALT311.StrType)le.dbt_61_90_pct),TRIM((SALT311.StrType)le.dbt_91_plus_pct),TRIM((SALT311.StrType)le.comment_code),TRIM((SALT311.StrType)le.comment_desc),TRIM((SALT311.StrType)le.date_reported),TRIM((SALT311.StrType)le.date_last_sale)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.bus_cat_code),TRIM((SALT311.StrType)le.bus_cat_desc),TRIM((SALT311.StrType)le.orig_date_reported_ymd),TRIM((SALT311.StrType)le.orig_date_last_sale_ym),TRIM((SALT311.StrType)le.payment_terms),TRIM((SALT311.StrType)le.high_credit_mask),TRIM((SALT311.StrType)le.recent_high_credit),TRIM((SALT311.StrType)le.acct_bal_mask),TRIM((SALT311.StrType)le.masked_acct_bal),TRIM((SALT311.StrType)le.current_pct),TRIM((SALT311.StrType)le.dbt_01_30_pct),TRIM((SALT311.StrType)le.dbt_31_60_pct),TRIM((SALT311.StrType)le.dbt_61_90_pct),TRIM((SALT311.StrType)le.dbt_91_plus_pct),TRIM((SALT311.StrType)le.comment_code),TRIM((SALT311.StrType)le.comment_desc),TRIM((SALT311.StrType)le.date_reported),TRIM((SALT311.StrType)le.date_last_sale)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),33*33,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{16,'bus_cat_code'}
      ,{17,'bus_cat_desc'}
      ,{18,'orig_date_reported_ymd'}
      ,{19,'orig_date_last_sale_ym'}
      ,{20,'payment_terms'}
      ,{21,'high_credit_mask'}
      ,{22,'recent_high_credit'}
      ,{23,'acct_bal_mask'}
      ,{24,'masked_acct_bal'}
      ,{25,'current_pct'}
      ,{26,'dbt_01_30_pct'}
      ,{27,'dbt_31_60_pct'}
      ,{28,'dbt_61_90_pct'}
      ,{29,'dbt_91_plus_pct'}
      ,{30,'comment_code'}
      ,{31,'comment_desc'}
      ,{32,'date_reported'}
      ,{33,'date_last_sale'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_6500_Fields.InValid_powid((SALT311.StrType)le.powid),
    Base_6500_Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Base_6500_Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Base_6500_Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Base_6500_Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Base_6500_Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Base_6500_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Base_6500_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Base_6500_Fields.InValid_process_date_first_seen((SALT311.StrType)le.process_date_first_seen),
    Base_6500_Fields.InValid_process_date_last_seen((SALT311.StrType)le.process_date_last_seen),
    Base_6500_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Base_6500_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Base_6500_Fields.InValid_file_number((SALT311.StrType)le.file_number),
    Base_6500_Fields.InValid_segment_code((SALT311.StrType)le.segment_code),
    Base_6500_Fields.InValid_sequence_number((SALT311.StrType)le.sequence_number),
    Base_6500_Fields.InValid_bus_cat_code((SALT311.StrType)le.bus_cat_code),
    Base_6500_Fields.InValid_bus_cat_desc((SALT311.StrType)le.bus_cat_desc),
    Base_6500_Fields.InValid_orig_date_reported_ymd((SALT311.StrType)le.orig_date_reported_ymd),
    Base_6500_Fields.InValid_orig_date_last_sale_ym((SALT311.StrType)le.orig_date_last_sale_ym),
    Base_6500_Fields.InValid_payment_terms((SALT311.StrType)le.payment_terms),
    Base_6500_Fields.InValid_high_credit_mask((SALT311.StrType)le.high_credit_mask),
    Base_6500_Fields.InValid_recent_high_credit((SALT311.StrType)le.recent_high_credit),
    Base_6500_Fields.InValid_acct_bal_mask((SALT311.StrType)le.acct_bal_mask),
    Base_6500_Fields.InValid_masked_acct_bal((SALT311.StrType)le.masked_acct_bal),
    Base_6500_Fields.InValid_current_pct((SALT311.StrType)le.current_pct),
    Base_6500_Fields.InValid_dbt_01_30_pct((SALT311.StrType)le.dbt_01_30_pct),
    Base_6500_Fields.InValid_dbt_31_60_pct((SALT311.StrType)le.dbt_31_60_pct),
    Base_6500_Fields.InValid_dbt_61_90_pct((SALT311.StrType)le.dbt_61_90_pct),
    Base_6500_Fields.InValid_dbt_91_plus_pct((SALT311.StrType)le.dbt_91_plus_pct),
    Base_6500_Fields.InValid_comment_code((SALT311.StrType)le.comment_code),
    Base_6500_Fields.InValid_comment_desc((SALT311.StrType)le.comment_desc),
    Base_6500_Fields.InValid_date_reported((SALT311.StrType)le.date_reported),
    Base_6500_Fields.InValid_date_last_sale((SALT311.StrType)le.date_last_sale),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,33,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_6500_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_numeric','invalid_dt_first_seen','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_record_type','invalid_pastdate','invalid_file_number','invalid_segment','invalid_numeric_or_allzeros','invalid_cat_code','invalid_cat_desc','invalid_dt_mmddyy','invalid_dt_yymm','invalid_terms','invalid_mask','invalid_numeric_or_allzeros','invalid_mask','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_comment_code','invalid_comment_desc','invalid_pastdate','invalid_dt_ccyymm');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_6500_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_process_date_first_seen(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_process_date_last_seen(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_file_number(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_segment_code(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_sequence_number(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_bus_cat_code(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_bus_cat_desc(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_orig_date_reported_ymd(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_orig_date_last_sale_ym(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_payment_terms(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_high_credit_mask(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_recent_high_credit(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_acct_bal_mask(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_masked_acct_bal(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_current_pct(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_dbt_01_30_pct(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_dbt_31_60_pct(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_dbt_61_90_pct(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_dbt_91_plus_pct(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_comment_code(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_comment_desc(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_date_reported(TotalErrors.ErrorNum),Base_6500_Fields.InValidMessage_date_last_sale(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_6500_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

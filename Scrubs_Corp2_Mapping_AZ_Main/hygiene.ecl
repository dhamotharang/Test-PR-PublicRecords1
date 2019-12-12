﻿IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_In_AZ) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_corp_ra_dt_first_seen_cnt := COUNT(GROUP,h.corp_ra_dt_first_seen <> (TYPEOF(h.corp_ra_dt_first_seen))'');
    populated_corp_ra_dt_first_seen_pcnt := AVE(GROUP,IF(h.corp_ra_dt_first_seen = (TYPEOF(h.corp_ra_dt_first_seen))'',0,100));
    maxlength_corp_ra_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_ra_dt_first_seen)));
    avelength_corp_ra_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_ra_dt_first_seen)),h.corp_ra_dt_first_seen<>(typeof(h.corp_ra_dt_first_seen))'');
    populated_corp_ra_dt_last_seen_cnt := COUNT(GROUP,h.corp_ra_dt_last_seen <> (TYPEOF(h.corp_ra_dt_last_seen))'');
    populated_corp_ra_dt_last_seen_pcnt := AVE(GROUP,IF(h.corp_ra_dt_last_seen = (TYPEOF(h.corp_ra_dt_last_seen))'',0,100));
    maxlength_corp_ra_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_ra_dt_last_seen)));
    avelength_corp_ra_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_ra_dt_last_seen)),h.corp_ra_dt_last_seen<>(typeof(h.corp_ra_dt_last_seen))'');
    populated_corp_key_cnt := COUNT(GROUP,h.corp_key <> (TYPEOF(h.corp_key))'');
    populated_corp_key_pcnt := AVE(GROUP,IF(h.corp_key = (TYPEOF(h.corp_key))'',0,100));
    maxlength_corp_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_key)));
    avelength_corp_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_key)),h.corp_key<>(typeof(h.corp_key))'');
    populated_corp_vendor_cnt := COUNT(GROUP,h.corp_vendor <> (TYPEOF(h.corp_vendor))'');
    populated_corp_vendor_pcnt := AVE(GROUP,IF(h.corp_vendor = (TYPEOF(h.corp_vendor))'',0,100));
    maxlength_corp_vendor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_vendor)));
    avelength_corp_vendor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_vendor)),h.corp_vendor<>(typeof(h.corp_vendor))'');
    populated_corp_state_origin_cnt := COUNT(GROUP,h.corp_state_origin <> (TYPEOF(h.corp_state_origin))'');
    populated_corp_state_origin_pcnt := AVE(GROUP,IF(h.corp_state_origin = (TYPEOF(h.corp_state_origin))'',0,100));
    maxlength_corp_state_origin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_state_origin)));
    avelength_corp_state_origin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_state_origin)),h.corp_state_origin<>(typeof(h.corp_state_origin))'');
    populated_corp_process_date_cnt := COUNT(GROUP,h.corp_process_date <> (TYPEOF(h.corp_process_date))'');
    populated_corp_process_date_pcnt := AVE(GROUP,IF(h.corp_process_date = (TYPEOF(h.corp_process_date))'',0,100));
    maxlength_corp_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_process_date)));
    avelength_corp_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_process_date)),h.corp_process_date<>(typeof(h.corp_process_date))'');
    populated_corp_orig_sos_charter_nbr_cnt := COUNT(GROUP,h.corp_orig_sos_charter_nbr <> (TYPEOF(h.corp_orig_sos_charter_nbr))'');
    populated_corp_orig_sos_charter_nbr_pcnt := AVE(GROUP,IF(h.corp_orig_sos_charter_nbr = (TYPEOF(h.corp_orig_sos_charter_nbr))'',0,100));
    maxlength_corp_orig_sos_charter_nbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_orig_sos_charter_nbr)));
    avelength_corp_orig_sos_charter_nbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_orig_sos_charter_nbr)),h.corp_orig_sos_charter_nbr<>(typeof(h.corp_orig_sos_charter_nbr))'');
    populated_corp_legal_name_cnt := COUNT(GROUP,h.corp_legal_name <> (TYPEOF(h.corp_legal_name))'');
    populated_corp_legal_name_pcnt := AVE(GROUP,IF(h.corp_legal_name = (TYPEOF(h.corp_legal_name))'',0,100));
    maxlength_corp_legal_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_legal_name)));
    avelength_corp_legal_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_legal_name)),h.corp_legal_name<>(typeof(h.corp_legal_name))'');
    populated_corp_ln_name_type_desc_cnt := COUNT(GROUP,h.corp_ln_name_type_desc <> (TYPEOF(h.corp_ln_name_type_desc))'');
    populated_corp_ln_name_type_desc_pcnt := AVE(GROUP,IF(h.corp_ln_name_type_desc = (TYPEOF(h.corp_ln_name_type_desc))'',0,100));
    maxlength_corp_ln_name_type_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_ln_name_type_desc)));
    avelength_corp_ln_name_type_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_ln_name_type_desc)),h.corp_ln_name_type_desc<>(typeof(h.corp_ln_name_type_desc))'');
    populated_corp_filing_date_cnt := COUNT(GROUP,h.corp_filing_date <> (TYPEOF(h.corp_filing_date))'');
    populated_corp_filing_date_pcnt := AVE(GROUP,IF(h.corp_filing_date = (TYPEOF(h.corp_filing_date))'',0,100));
    maxlength_corp_filing_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_filing_date)));
    avelength_corp_filing_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_filing_date)),h.corp_filing_date<>(typeof(h.corp_filing_date))'');
    populated_corp_inc_date_cnt := COUNT(GROUP,h.corp_inc_date <> (TYPEOF(h.corp_inc_date))'');
    populated_corp_inc_date_pcnt := AVE(GROUP,IF(h.corp_inc_date = (TYPEOF(h.corp_inc_date))'',0,100));
    maxlength_corp_inc_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_inc_date)));
    avelength_corp_inc_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_inc_date)),h.corp_inc_date<>(typeof(h.corp_inc_date))'');
    populated_corp_forgn_date_cnt := COUNT(GROUP,h.corp_forgn_date <> (TYPEOF(h.corp_forgn_date))'');
    populated_corp_forgn_date_pcnt := AVE(GROUP,IF(h.corp_forgn_date = (TYPEOF(h.corp_forgn_date))'',0,100));
    maxlength_corp_forgn_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_forgn_date)));
    avelength_corp_forgn_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_forgn_date)),h.corp_forgn_date<>(typeof(h.corp_forgn_date))'');
    populated_corp_ra_effective_date_cnt := COUNT(GROUP,h.corp_ra_effective_date <> (TYPEOF(h.corp_ra_effective_date))'');
    populated_corp_ra_effective_date_pcnt := AVE(GROUP,IF(h.corp_ra_effective_date = (TYPEOF(h.corp_ra_effective_date))'',0,100));
    maxlength_corp_ra_effective_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_ra_effective_date)));
    avelength_corp_ra_effective_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_ra_effective_date)),h.corp_ra_effective_date<>(typeof(h.corp_ra_effective_date))'');
    populated_corp_ra_resign_date_cnt := COUNT(GROUP,h.corp_ra_resign_date <> (TYPEOF(h.corp_ra_resign_date))'');
    populated_corp_ra_resign_date_pcnt := AVE(GROUP,IF(h.corp_ra_resign_date = (TYPEOF(h.corp_ra_resign_date))'',0,100));
    maxlength_corp_ra_resign_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_ra_resign_date)));
    avelength_corp_ra_resign_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_ra_resign_date)),h.corp_ra_resign_date<>(typeof(h.corp_ra_resign_date))'');
    populated_corp_inc_state_cnt := COUNT(GROUP,h.corp_inc_state <> (TYPEOF(h.corp_inc_state))'');
    populated_corp_inc_state_pcnt := AVE(GROUP,IF(h.corp_inc_state = (TYPEOF(h.corp_inc_state))'',0,100));
    maxlength_corp_inc_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_inc_state)));
    avelength_corp_inc_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_inc_state)),h.corp_inc_state<>(typeof(h.corp_inc_state))'');
    populated_corp_status_desc_cnt := COUNT(GROUP,h.corp_status_desc <> (TYPEOF(h.corp_status_desc))'');
    populated_corp_status_desc_pcnt := AVE(GROUP,IF(h.corp_status_desc = (TYPEOF(h.corp_status_desc))'',0,100));
    maxlength_corp_status_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_status_desc)));
    avelength_corp_status_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_status_desc)),h.corp_status_desc<>(typeof(h.corp_status_desc))'');
    populated_corp_foreign_domestic_ind_cnt := COUNT(GROUP,h.corp_foreign_domestic_ind <> (TYPEOF(h.corp_foreign_domestic_ind))'');
    populated_corp_foreign_domestic_ind_pcnt := AVE(GROUP,IF(h.corp_foreign_domestic_ind = (TYPEOF(h.corp_foreign_domestic_ind))'',0,100));
    maxlength_corp_foreign_domestic_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_foreign_domestic_ind)));
    avelength_corp_foreign_domestic_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_foreign_domestic_ind)),h.corp_foreign_domestic_ind<>(typeof(h.corp_foreign_domestic_ind))'');
    populated_corp_orig_org_structure_desc_cnt := COUNT(GROUP,h.corp_orig_org_structure_desc <> (TYPEOF(h.corp_orig_org_structure_desc))'');
    populated_corp_orig_org_structure_desc_pcnt := AVE(GROUP,IF(h.corp_orig_org_structure_desc = (TYPEOF(h.corp_orig_org_structure_desc))'',0,100));
    maxlength_corp_orig_org_structure_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_orig_org_structure_desc)));
    avelength_corp_orig_org_structure_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_orig_org_structure_desc)),h.corp_orig_org_structure_desc<>(typeof(h.corp_orig_org_structure_desc))'');
    populated_corp_for_profit_ind_cnt := COUNT(GROUP,h.corp_for_profit_ind <> (TYPEOF(h.corp_for_profit_ind))'');
    populated_corp_for_profit_ind_pcnt := AVE(GROUP,IF(h.corp_for_profit_ind = (TYPEOF(h.corp_for_profit_ind))'',0,100));
    maxlength_corp_for_profit_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_for_profit_ind)));
    avelength_corp_for_profit_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_for_profit_ind)),h.corp_for_profit_ind<>(typeof(h.corp_for_profit_ind))'');
    populated_corp_forgn_state_desc_cnt := COUNT(GROUP,h.corp_forgn_state_desc <> (TYPEOF(h.corp_forgn_state_desc))'');
    populated_corp_forgn_state_desc_pcnt := AVE(GROUP,IF(h.corp_forgn_state_desc = (TYPEOF(h.corp_forgn_state_desc))'',0,100));
    maxlength_corp_forgn_state_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_forgn_state_desc)));
    avelength_corp_forgn_state_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_forgn_state_desc)),h.corp_forgn_state_desc<>(typeof(h.corp_forgn_state_desc))'');
    populated_corp_agent_status_desc_cnt := COUNT(GROUP,h.corp_agent_status_desc <> (TYPEOF(h.corp_agent_status_desc))'');
    populated_corp_agent_status_desc_pcnt := AVE(GROUP,IF(h.corp_agent_status_desc = (TYPEOF(h.corp_agent_status_desc))'',0,100));
    maxlength_corp_agent_status_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_agent_status_desc)));
    avelength_corp_agent_status_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_agent_status_desc)),h.corp_agent_status_desc<>(typeof(h.corp_agent_status_desc))'');
    populated_recordOrigin_cnt := COUNT(GROUP,h.recordOrigin <> (TYPEOF(h.recordOrigin))'');
    populated_recordOrigin_pcnt := AVE(GROUP,IF(h.recordOrigin = (TYPEOF(h.recordOrigin))'',0,100));
    maxlength_recordOrigin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recordOrigin)));
    avelength_recordOrigin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recordOrigin)),h.recordOrigin<>(typeof(h.recordOrigin))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_corp_ra_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_corp_ra_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_corp_key_pcnt *   0.00 / 100 + T.Populated_corp_vendor_pcnt *   0.00 / 100 + T.Populated_corp_state_origin_pcnt *   0.00 / 100 + T.Populated_corp_process_date_pcnt *   0.00 / 100 + T.Populated_corp_orig_sos_charter_nbr_pcnt *   0.00 / 100 + T.Populated_corp_legal_name_pcnt *   0.00 / 100 + T.Populated_corp_ln_name_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_filing_date_pcnt *   0.00 / 100 + T.Populated_corp_inc_date_pcnt *   0.00 / 100 + T.Populated_corp_forgn_date_pcnt *   0.00 / 100 + T.Populated_corp_ra_effective_date_pcnt *   0.00 / 100 + T.Populated_corp_ra_resign_date_pcnt *   0.00 / 100 + T.Populated_corp_inc_state_pcnt *   0.00 / 100 + T.Populated_corp_status_desc_pcnt *   0.00 / 100 + T.Populated_corp_foreign_domestic_ind_pcnt *   0.00 / 100 + T.Populated_corp_orig_org_structure_desc_pcnt *   0.00 / 100 + T.Populated_corp_for_profit_ind_pcnt *   0.00 / 100 + T.Populated_corp_forgn_state_desc_pcnt *   0.00 / 100 + T.Populated_corp_agent_status_desc_pcnt *   0.00 / 100 + T.Populated_recordOrigin_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_key','corp_vendor','corp_state_origin','corp_process_date','corp_orig_sos_charter_nbr','corp_legal_name','corp_ln_name_type_desc','corp_filing_date','corp_inc_date','corp_forgn_date','corp_ra_effective_date','corp_ra_resign_date','corp_inc_state','corp_status_desc','corp_foreign_domestic_ind','corp_orig_org_structure_desc','corp_for_profit_ind','corp_forgn_state_desc','corp_agent_status_desc','recordOrigin');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_corp_ra_dt_first_seen_pcnt,le.populated_corp_ra_dt_last_seen_pcnt,le.populated_corp_key_pcnt,le.populated_corp_vendor_pcnt,le.populated_corp_state_origin_pcnt,le.populated_corp_process_date_pcnt,le.populated_corp_orig_sos_charter_nbr_pcnt,le.populated_corp_legal_name_pcnt,le.populated_corp_ln_name_type_desc_pcnt,le.populated_corp_filing_date_pcnt,le.populated_corp_inc_date_pcnt,le.populated_corp_forgn_date_pcnt,le.populated_corp_ra_effective_date_pcnt,le.populated_corp_ra_resign_date_pcnt,le.populated_corp_inc_state_pcnt,le.populated_corp_status_desc_pcnt,le.populated_corp_foreign_domestic_ind_pcnt,le.populated_corp_orig_org_structure_desc_pcnt,le.populated_corp_for_profit_ind_pcnt,le.populated_corp_forgn_state_desc_pcnt,le.populated_corp_agent_status_desc_pcnt,le.populated_recordOrigin_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_corp_ra_dt_first_seen,le.maxlength_corp_ra_dt_last_seen,le.maxlength_corp_key,le.maxlength_corp_vendor,le.maxlength_corp_state_origin,le.maxlength_corp_process_date,le.maxlength_corp_orig_sos_charter_nbr,le.maxlength_corp_legal_name,le.maxlength_corp_ln_name_type_desc,le.maxlength_corp_filing_date,le.maxlength_corp_inc_date,le.maxlength_corp_forgn_date,le.maxlength_corp_ra_effective_date,le.maxlength_corp_ra_resign_date,le.maxlength_corp_inc_state,le.maxlength_corp_status_desc,le.maxlength_corp_foreign_domestic_ind,le.maxlength_corp_orig_org_structure_desc,le.maxlength_corp_for_profit_ind,le.maxlength_corp_forgn_state_desc,le.maxlength_corp_agent_status_desc,le.maxlength_recordOrigin);
  SELF.avelength := CHOOSE(C,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_corp_ra_dt_first_seen,le.avelength_corp_ra_dt_last_seen,le.avelength_corp_key,le.avelength_corp_vendor,le.avelength_corp_state_origin,le.avelength_corp_process_date,le.avelength_corp_orig_sos_charter_nbr,le.avelength_corp_legal_name,le.avelength_corp_ln_name_type_desc,le.avelength_corp_filing_date,le.avelength_corp_inc_date,le.avelength_corp_forgn_date,le.avelength_corp_ra_effective_date,le.avelength_corp_ra_resign_date,le.avelength_corp_inc_state,le.avelength_corp_status_desc,le.avelength_corp_foreign_domestic_ind,le.avelength_corp_orig_org_structure_desc,le.avelength_corp_for_profit_ind,le.avelength_corp_forgn_state_desc,le.avelength_corp_agent_status_desc,le.avelength_recordOrigin);
END;
EXPORT invSummary := NORMALIZE(summary0, 26, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.corp_ra_dt_first_seen <> 0,TRIM((SALT311.StrType)le.corp_ra_dt_first_seen), ''),IF (le.corp_ra_dt_last_seen <> 0,TRIM((SALT311.StrType)le.corp_ra_dt_last_seen), ''),TRIM((SALT311.StrType)le.corp_key),TRIM((SALT311.StrType)le.corp_vendor),TRIM((SALT311.StrType)le.corp_state_origin),TRIM((SALT311.StrType)le.corp_process_date),TRIM((SALT311.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT311.StrType)le.corp_legal_name),TRIM((SALT311.StrType)le.corp_ln_name_type_desc),TRIM((SALT311.StrType)le.corp_filing_date),TRIM((SALT311.StrType)le.corp_inc_date),TRIM((SALT311.StrType)le.corp_forgn_date),TRIM((SALT311.StrType)le.corp_ra_effective_date),TRIM((SALT311.StrType)le.corp_ra_resign_date),TRIM((SALT311.StrType)le.corp_inc_state),TRIM((SALT311.StrType)le.corp_status_desc),TRIM((SALT311.StrType)le.corp_foreign_domestic_ind),TRIM((SALT311.StrType)le.corp_orig_org_structure_desc),TRIM((SALT311.StrType)le.corp_for_profit_ind),TRIM((SALT311.StrType)le.corp_forgn_state_desc),TRIM((SALT311.StrType)le.corp_agent_status_desc),TRIM((SALT311.StrType)le.recordOrigin)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,26,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 26);
  SELF.FldNo2 := 1 + (C % 26);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.corp_ra_dt_first_seen <> 0,TRIM((SALT311.StrType)le.corp_ra_dt_first_seen), ''),IF (le.corp_ra_dt_last_seen <> 0,TRIM((SALT311.StrType)le.corp_ra_dt_last_seen), ''),TRIM((SALT311.StrType)le.corp_key),TRIM((SALT311.StrType)le.corp_vendor),TRIM((SALT311.StrType)le.corp_state_origin),TRIM((SALT311.StrType)le.corp_process_date),TRIM((SALT311.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT311.StrType)le.corp_legal_name),TRIM((SALT311.StrType)le.corp_ln_name_type_desc),TRIM((SALT311.StrType)le.corp_filing_date),TRIM((SALT311.StrType)le.corp_inc_date),TRIM((SALT311.StrType)le.corp_forgn_date),TRIM((SALT311.StrType)le.corp_ra_effective_date),TRIM((SALT311.StrType)le.corp_ra_resign_date),TRIM((SALT311.StrType)le.corp_inc_state),TRIM((SALT311.StrType)le.corp_status_desc),TRIM((SALT311.StrType)le.corp_foreign_domestic_ind),TRIM((SALT311.StrType)le.corp_orig_org_structure_desc),TRIM((SALT311.StrType)le.corp_for_profit_ind),TRIM((SALT311.StrType)le.corp_forgn_state_desc),TRIM((SALT311.StrType)le.corp_agent_status_desc),TRIM((SALT311.StrType)le.recordOrigin)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.corp_ra_dt_first_seen <> 0,TRIM((SALT311.StrType)le.corp_ra_dt_first_seen), ''),IF (le.corp_ra_dt_last_seen <> 0,TRIM((SALT311.StrType)le.corp_ra_dt_last_seen), ''),TRIM((SALT311.StrType)le.corp_key),TRIM((SALT311.StrType)le.corp_vendor),TRIM((SALT311.StrType)le.corp_state_origin),TRIM((SALT311.StrType)le.corp_process_date),TRIM((SALT311.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT311.StrType)le.corp_legal_name),TRIM((SALT311.StrType)le.corp_ln_name_type_desc),TRIM((SALT311.StrType)le.corp_filing_date),TRIM((SALT311.StrType)le.corp_inc_date),TRIM((SALT311.StrType)le.corp_forgn_date),TRIM((SALT311.StrType)le.corp_ra_effective_date),TRIM((SALT311.StrType)le.corp_ra_resign_date),TRIM((SALT311.StrType)le.corp_inc_state),TRIM((SALT311.StrType)le.corp_status_desc),TRIM((SALT311.StrType)le.corp_foreign_domestic_ind),TRIM((SALT311.StrType)le.corp_orig_org_structure_desc),TRIM((SALT311.StrType)le.corp_for_profit_ind),TRIM((SALT311.StrType)le.corp_forgn_state_desc),TRIM((SALT311.StrType)le.corp_agent_status_desc),TRIM((SALT311.StrType)le.recordOrigin)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),26*26,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_vendor_first_reported'}
      ,{2,'dt_vendor_last_reported'}
      ,{3,'dt_first_seen'}
      ,{4,'dt_last_seen'}
      ,{5,'corp_ra_dt_first_seen'}
      ,{6,'corp_ra_dt_last_seen'}
      ,{7,'corp_key'}
      ,{8,'corp_vendor'}
      ,{9,'corp_state_origin'}
      ,{10,'corp_process_date'}
      ,{11,'corp_orig_sos_charter_nbr'}
      ,{12,'corp_legal_name'}
      ,{13,'corp_ln_name_type_desc'}
      ,{14,'corp_filing_date'}
      ,{15,'corp_inc_date'}
      ,{16,'corp_forgn_date'}
      ,{17,'corp_ra_effective_date'}
      ,{18,'corp_ra_resign_date'}
      ,{19,'corp_inc_state'}
      ,{20,'corp_status_desc'}
      ,{21,'corp_foreign_domestic_ind'}
      ,{22,'corp_orig_org_structure_desc'}
      ,{23,'corp_for_profit_ind'}
      ,{24,'corp_forgn_state_desc'}
      ,{25,'corp_agent_status_desc'}
      ,{26,'recordOrigin'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Fields.InValid_corp_ra_dt_first_seen((SALT311.StrType)le.corp_ra_dt_first_seen),
    Fields.InValid_corp_ra_dt_last_seen((SALT311.StrType)le.corp_ra_dt_last_seen),
    Fields.InValid_corp_key((SALT311.StrType)le.corp_key),
    Fields.InValid_corp_vendor((SALT311.StrType)le.corp_vendor),
    Fields.InValid_corp_state_origin((SALT311.StrType)le.corp_state_origin),
    Fields.InValid_corp_process_date((SALT311.StrType)le.corp_process_date),
    Fields.InValid_corp_orig_sos_charter_nbr((SALT311.StrType)le.corp_orig_sos_charter_nbr),
    Fields.InValid_corp_legal_name((SALT311.StrType)le.corp_legal_name),
    Fields.InValid_corp_ln_name_type_desc((SALT311.StrType)le.corp_ln_name_type_desc,(SALT311.StrType)le.recordOrigin),
    Fields.InValid_corp_filing_date((SALT311.StrType)le.corp_filing_date),
    Fields.InValid_corp_inc_date((SALT311.StrType)le.corp_inc_date),
    Fields.InValid_corp_forgn_date((SALT311.StrType)le.corp_forgn_date),
    Fields.InValid_corp_ra_effective_date((SALT311.StrType)le.corp_ra_effective_date),
    Fields.InValid_corp_ra_resign_date((SALT311.StrType)le.corp_ra_resign_date),
    Fields.InValid_corp_inc_state((SALT311.StrType)le.corp_inc_state),
    Fields.InValid_corp_status_desc((SALT311.StrType)le.corp_status_desc),
    Fields.InValid_corp_foreign_domestic_ind((SALT311.StrType)le.corp_foreign_domestic_ind),
    Fields.InValid_corp_orig_org_structure_desc((SALT311.StrType)le.corp_orig_org_structure_desc),
    Fields.InValid_corp_for_profit_ind((SALT311.StrType)le.corp_for_profit_ind),
    Fields.InValid_corp_forgn_state_desc((SALT311.StrType)le.corp_forgn_state_desc),
    Fields.InValid_corp_agent_status_desc((SALT311.StrType)le.corp_agent_status_desc),
    Fields.InValid_recordOrigin((SALT311.StrType)le.recordOrigin),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,26,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_optional_date','invalid_optional_date','invalid_date','invalid_date','invalid_optional_date','invalid_optional_date','invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_date','invalid_charter','invalid_mandatory','invalid_name_type_desc','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_state_origin','invalid_alphablankperiod','invalid_forgn_dom_code','invalid_alphablankperiod','invalid_for_profit_ind','invalid_alphablankperiod','invalid_agent_status','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor(TotalErrors.ErrorNum),Fields.InValidMessage_corp_state_origin(TotalErrors.ErrorNum),Fields.InValidMessage_corp_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_sos_charter_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_legal_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ln_name_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_filing_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_inc_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_resign_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_inc_state(TotalErrors.ErrorNum),Fields.InValidMessage_corp_status_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_foreign_domestic_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_org_structure_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_for_profit_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_state_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_agent_status_desc(TotalErrors.ErrorNum),Fields.InValidMessage_recordOrigin(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Corp2_Mapping_AZ_Main, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

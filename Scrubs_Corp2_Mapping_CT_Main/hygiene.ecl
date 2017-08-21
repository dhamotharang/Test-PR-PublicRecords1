IMPORT ut,SALT34;
EXPORT hygiene(dataset(layout_In_CT) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT34.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_corp_ra_dt_first_seen_pcnt := AVE(GROUP,IF(h.corp_ra_dt_first_seen = (TYPEOF(h.corp_ra_dt_first_seen))'',0,100));
    maxlength_corp_ra_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ra_dt_first_seen)));
    avelength_corp_ra_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ra_dt_first_seen)),h.corp_ra_dt_first_seen<>(typeof(h.corp_ra_dt_first_seen))'');
    populated_corp_ra_dt_last_seen_pcnt := AVE(GROUP,IF(h.corp_ra_dt_last_seen = (TYPEOF(h.corp_ra_dt_last_seen))'',0,100));
    maxlength_corp_ra_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ra_dt_last_seen)));
    avelength_corp_ra_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ra_dt_last_seen)),h.corp_ra_dt_last_seen<>(typeof(h.corp_ra_dt_last_seen))'');
    populated_corp_process_date_pcnt := AVE(GROUP,IF(h.corp_process_date = (TYPEOF(h.corp_process_date))'',0,100));
    maxlength_corp_process_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_process_date)));
    avelength_corp_process_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_process_date)),h.corp_process_date<>(typeof(h.corp_process_date))'');
    populated_corp_inc_date_pcnt := AVE(GROUP,IF(h.corp_inc_date = (TYPEOF(h.corp_inc_date))'',0,100));
    maxlength_corp_inc_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_inc_date)));
    avelength_corp_inc_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_inc_date)),h.corp_inc_date<>(typeof(h.corp_inc_date))'');
    populated_corp_forgn_date_pcnt := AVE(GROUP,IF(h.corp_forgn_date = (TYPEOF(h.corp_forgn_date))'',0,100));
    maxlength_corp_forgn_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_forgn_date)));
    avelength_corp_forgn_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_forgn_date)),h.corp_forgn_date<>(typeof(h.corp_forgn_date))'');
    populated_corp_filing_date_pcnt := AVE(GROUP,IF(h.corp_filing_date = (TYPEOF(h.corp_filing_date))'',0,100));
    maxlength_corp_filing_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_filing_date)));
    avelength_corp_filing_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_filing_date)),h.corp_filing_date<>(typeof(h.corp_filing_date))'');
    populated_corp_status_date_pcnt := AVE(GROUP,IF(h.corp_status_date = (TYPEOF(h.corp_status_date))'',0,100));
    maxlength_corp_status_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_status_date)));
    avelength_corp_status_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_status_date)),h.corp_status_date<>(typeof(h.corp_status_date))'');
    populated_corp_merger_date_pcnt := AVE(GROUP,IF(h.corp_merger_date = (TYPEOF(h.corp_merger_date))'',0,100));
    maxlength_corp_merger_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_merger_date)));
    avelength_corp_merger_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_merger_date)),h.corp_merger_date<>(typeof(h.corp_merger_date))'');
    populated_corp_ra_resign_date_pcnt := AVE(GROUP,IF(h.corp_ra_resign_date = (TYPEOF(h.corp_ra_resign_date))'',0,100));
    maxlength_corp_ra_resign_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ra_resign_date)));
    avelength_corp_ra_resign_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ra_resign_date)),h.corp_ra_resign_date<>(typeof(h.corp_ra_resign_date))'');
    populated_corp_term_exist_exp_pcnt := AVE(GROUP,IF(h.corp_term_exist_exp = (TYPEOF(h.corp_term_exist_exp))'',0,100));
    maxlength_corp_term_exist_exp := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_term_exist_exp)));
    avelength_corp_term_exist_exp := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_term_exist_exp)),h.corp_term_exist_exp<>(typeof(h.corp_term_exist_exp))'');
    populated_cont_effective_date_pcnt := AVE(GROUP,IF(h.cont_effective_date = (TYPEOF(h.cont_effective_date))'',0,100));
    maxlength_cont_effective_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cont_effective_date)));
    avelength_cont_effective_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cont_effective_date)),h.cont_effective_date<>(typeof(h.cont_effective_date))'');
    populated_corp_dissolved_date_pcnt := AVE(GROUP,IF(h.corp_dissolved_date = (TYPEOF(h.corp_dissolved_date))'',0,100));
    maxlength_corp_dissolved_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_dissolved_date)));
    avelength_corp_dissolved_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_dissolved_date)),h.corp_dissolved_date<>(typeof(h.corp_dissolved_date))'');
    populated_corp_name_status_date_pcnt := AVE(GROUP,IF(h.corp_name_status_date = (TYPEOF(h.corp_name_status_date))'',0,100));
    maxlength_corp_name_status_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_name_status_date)));
    avelength_corp_name_status_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_name_status_date)),h.corp_name_status_date<>(typeof(h.corp_name_status_date))'');
    populated_corp_name_reservation_expiration_date_pcnt := AVE(GROUP,IF(h.corp_name_reservation_expiration_date = (TYPEOF(h.corp_name_reservation_expiration_date))'',0,100));
    maxlength_corp_name_reservation_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_name_reservation_expiration_date)));
    avelength_corp_name_reservation_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_name_reservation_expiration_date)),h.corp_name_reservation_expiration_date<>(typeof(h.corp_name_reservation_expiration_date))'');
    populated_corp_key_pcnt := AVE(GROUP,IF(h.corp_key = (TYPEOF(h.corp_key))'',0,100));
    maxlength_corp_key := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_key)));
    avelength_corp_key := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_key)),h.corp_key<>(typeof(h.corp_key))'');
    populated_corp_orig_sos_charter_nbr_pcnt := AVE(GROUP,IF(h.corp_orig_sos_charter_nbr = (TYPEOF(h.corp_orig_sos_charter_nbr))'',0,100));
    maxlength_corp_orig_sos_charter_nbr := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_orig_sos_charter_nbr)));
    avelength_corp_orig_sos_charter_nbr := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_orig_sos_charter_nbr)),h.corp_orig_sos_charter_nbr<>(typeof(h.corp_orig_sos_charter_nbr))'');
    populated_corp_vendor_pcnt := AVE(GROUP,IF(h.corp_vendor = (TYPEOF(h.corp_vendor))'',0,100));
    maxlength_corp_vendor := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_vendor)));
    avelength_corp_vendor := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_vendor)),h.corp_vendor<>(typeof(h.corp_vendor))'');
    populated_corp_state_origin_pcnt := AVE(GROUP,IF(h.corp_state_origin = (TYPEOF(h.corp_state_origin))'',0,100));
    maxlength_corp_state_origin := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_state_origin)));
    avelength_corp_state_origin := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_state_origin)),h.corp_state_origin<>(typeof(h.corp_state_origin))'');
    populated_corp_legal_name_pcnt := AVE(GROUP,IF(h.corp_legal_name = (TYPEOF(h.corp_legal_name))'',0,100));
    maxlength_corp_legal_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_legal_name)));
    avelength_corp_legal_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_legal_name)),h.corp_legal_name<>(typeof(h.corp_legal_name))'');
    populated_corp_inc_state_pcnt := AVE(GROUP,IF(h.corp_inc_state = (TYPEOF(h.corp_inc_state))'',0,100));
    maxlength_corp_inc_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_inc_state)));
    avelength_corp_inc_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_inc_state)),h.corp_inc_state<>(typeof(h.corp_inc_state))'');
    populated_corp_forgn_state_desc_pcnt := AVE(GROUP,IF(h.corp_forgn_state_desc = (TYPEOF(h.corp_forgn_state_desc))'',0,100));
    maxlength_corp_forgn_state_desc := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_forgn_state_desc)));
    avelength_corp_forgn_state_desc := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_forgn_state_desc)),h.corp_forgn_state_desc<>(typeof(h.corp_forgn_state_desc))'');
    populated_corp_foreign_domestic_ind_pcnt := AVE(GROUP,IF(h.corp_foreign_domestic_ind = (TYPEOF(h.corp_foreign_domestic_ind))'',0,100));
    maxlength_corp_foreign_domestic_ind := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_foreign_domestic_ind)));
    avelength_corp_foreign_domestic_ind := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_foreign_domestic_ind)),h.corp_foreign_domestic_ind<>(typeof(h.corp_foreign_domestic_ind))'');
    populated_corp_for_profit_ind_pcnt := AVE(GROUP,IF(h.corp_for_profit_ind = (TYPEOF(h.corp_for_profit_ind))'',0,100));
    maxlength_corp_for_profit_ind := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_for_profit_ind)));
    avelength_corp_for_profit_ind := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_for_profit_ind)),h.corp_for_profit_ind<>(typeof(h.corp_for_profit_ind))'');
    populated_corp_ln_name_type_cd_pcnt := AVE(GROUP,IF(h.corp_ln_name_type_cd = (TYPEOF(h.corp_ln_name_type_cd))'',0,100));
    maxlength_corp_ln_name_type_cd := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ln_name_type_cd)));
    avelength_corp_ln_name_type_cd := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ln_name_type_cd)),h.corp_ln_name_type_cd<>(typeof(h.corp_ln_name_type_cd))'');
    populated_corp_ln_name_type_desc_pcnt := AVE(GROUP,IF(h.corp_ln_name_type_desc = (TYPEOF(h.corp_ln_name_type_desc))'',0,100));
    maxlength_corp_ln_name_type_desc := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ln_name_type_desc)));
    avelength_corp_ln_name_type_desc := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ln_name_type_desc)),h.corp_ln_name_type_desc<>(typeof(h.corp_ln_name_type_desc))'');
    populated_corp_orig_bus_type_cd_pcnt := AVE(GROUP,IF(h.corp_orig_bus_type_cd = (TYPEOF(h.corp_orig_bus_type_cd))'',0,100));
    maxlength_corp_orig_bus_type_cd := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_orig_bus_type_cd)));
    avelength_corp_orig_bus_type_cd := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_orig_bus_type_cd)),h.corp_orig_bus_type_cd<>(typeof(h.corp_orig_bus_type_cd))'');
    populated_corp_status_cd_pcnt := AVE(GROUP,IF(h.corp_status_cd = (TYPEOF(h.corp_status_cd))'',0,100));
    maxlength_corp_status_cd := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_status_cd)));
    avelength_corp_status_cd := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_status_cd)),h.corp_status_cd<>(typeof(h.corp_status_cd))'');
    populated_corp_orig_org_structure_cd_pcnt := AVE(GROUP,IF(h.corp_orig_org_structure_cd = (TYPEOF(h.corp_orig_org_structure_cd))'',0,100));
    maxlength_corp_orig_org_structure_cd := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_orig_org_structure_cd)));
    avelength_corp_orig_org_structure_cd := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_orig_org_structure_cd)),h.corp_orig_org_structure_cd<>(typeof(h.corp_orig_org_structure_cd))'');
    populated_corp_country_of_formation_pcnt := AVE(GROUP,IF(h.corp_country_of_formation = (TYPEOF(h.corp_country_of_formation))'',0,100));
    maxlength_corp_country_of_formation := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_country_of_formation)));
    avelength_corp_country_of_formation := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_country_of_formation)),h.corp_country_of_formation<>(typeof(h.corp_country_of_formation))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_corp_ra_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_corp_ra_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_corp_process_date_pcnt *   0.00 / 100 + T.Populated_corp_inc_date_pcnt *   0.00 / 100 + T.Populated_corp_forgn_date_pcnt *   0.00 / 100 + T.Populated_corp_filing_date_pcnt *   0.00 / 100 + T.Populated_corp_status_date_pcnt *   0.00 / 100 + T.Populated_corp_merger_date_pcnt *   0.00 / 100 + T.Populated_corp_ra_resign_date_pcnt *   0.00 / 100 + T.Populated_corp_term_exist_exp_pcnt *   0.00 / 100 + T.Populated_cont_effective_date_pcnt *   0.00 / 100 + T.Populated_corp_dissolved_date_pcnt *   0.00 / 100 + T.Populated_corp_name_status_date_pcnt *   0.00 / 100 + T.Populated_corp_name_reservation_expiration_date_pcnt *   0.00 / 100 + T.Populated_corp_key_pcnt *   0.00 / 100 + T.Populated_corp_orig_sos_charter_nbr_pcnt *   0.00 / 100 + T.Populated_corp_vendor_pcnt *   0.00 / 100 + T.Populated_corp_state_origin_pcnt *   0.00 / 100 + T.Populated_corp_legal_name_pcnt *   0.00 / 100 + T.Populated_corp_inc_state_pcnt *   0.00 / 100 + T.Populated_corp_forgn_state_desc_pcnt *   0.00 / 100 + T.Populated_corp_foreign_domestic_ind_pcnt *   0.00 / 100 + T.Populated_corp_for_profit_ind_pcnt *   0.00 / 100 + T.Populated_corp_ln_name_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_ln_name_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_orig_bus_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_status_cd_pcnt *   0.00 / 100 + T.Populated_corp_orig_org_structure_cd_pcnt *   0.00 / 100 + T.Populated_corp_country_of_formation_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT34.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_process_date','corp_inc_date','corp_forgn_date','corp_filing_date','corp_status_date','corp_merger_date','corp_ra_resign_date','corp_term_exist_exp','cont_effective_date','corp_dissolved_date','corp_name_status_date','corp_name_reservation_expiration_date','corp_key','corp_orig_sos_charter_nbr','corp_vendor','corp_state_origin','corp_legal_name','corp_inc_state','corp_forgn_state_desc','corp_foreign_domestic_ind','corp_for_profit_ind','corp_ln_name_type_cd','corp_ln_name_type_desc','corp_orig_bus_type_cd','corp_status_cd','corp_orig_org_structure_cd','corp_country_of_formation');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_corp_ra_dt_first_seen_pcnt,le.populated_corp_ra_dt_last_seen_pcnt,le.populated_corp_process_date_pcnt,le.populated_corp_inc_date_pcnt,le.populated_corp_forgn_date_pcnt,le.populated_corp_filing_date_pcnt,le.populated_corp_status_date_pcnt,le.populated_corp_merger_date_pcnt,le.populated_corp_ra_resign_date_pcnt,le.populated_corp_term_exist_exp_pcnt,le.populated_cont_effective_date_pcnt,le.populated_corp_dissolved_date_pcnt,le.populated_corp_name_status_date_pcnt,le.populated_corp_name_reservation_expiration_date_pcnt,le.populated_corp_key_pcnt,le.populated_corp_orig_sos_charter_nbr_pcnt,le.populated_corp_vendor_pcnt,le.populated_corp_state_origin_pcnt,le.populated_corp_legal_name_pcnt,le.populated_corp_inc_state_pcnt,le.populated_corp_forgn_state_desc_pcnt,le.populated_corp_foreign_domestic_ind_pcnt,le.populated_corp_for_profit_ind_pcnt,le.populated_corp_ln_name_type_cd_pcnt,le.populated_corp_ln_name_type_desc_pcnt,le.populated_corp_orig_bus_type_cd_pcnt,le.populated_corp_status_cd_pcnt,le.populated_corp_orig_org_structure_cd_pcnt,le.populated_corp_country_of_formation_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_corp_ra_dt_first_seen,le.maxlength_corp_ra_dt_last_seen,le.maxlength_corp_process_date,le.maxlength_corp_inc_date,le.maxlength_corp_forgn_date,le.maxlength_corp_filing_date,le.maxlength_corp_status_date,le.maxlength_corp_merger_date,le.maxlength_corp_ra_resign_date,le.maxlength_corp_term_exist_exp,le.maxlength_cont_effective_date,le.maxlength_corp_dissolved_date,le.maxlength_corp_name_status_date,le.maxlength_corp_name_reservation_expiration_date,le.maxlength_corp_key,le.maxlength_corp_orig_sos_charter_nbr,le.maxlength_corp_vendor,le.maxlength_corp_state_origin,le.maxlength_corp_legal_name,le.maxlength_corp_inc_state,le.maxlength_corp_forgn_state_desc,le.maxlength_corp_foreign_domestic_ind,le.maxlength_corp_for_profit_ind,le.maxlength_corp_ln_name_type_cd,le.maxlength_corp_ln_name_type_desc,le.maxlength_corp_orig_bus_type_cd,le.maxlength_corp_status_cd,le.maxlength_corp_orig_org_structure_cd,le.maxlength_corp_country_of_formation);
  SELF.avelength := CHOOSE(C,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_corp_ra_dt_first_seen,le.avelength_corp_ra_dt_last_seen,le.avelength_corp_process_date,le.avelength_corp_inc_date,le.avelength_corp_forgn_date,le.avelength_corp_filing_date,le.avelength_corp_status_date,le.avelength_corp_merger_date,le.avelength_corp_ra_resign_date,le.avelength_corp_term_exist_exp,le.avelength_cont_effective_date,le.avelength_corp_dissolved_date,le.avelength_corp_name_status_date,le.avelength_corp_name_reservation_expiration_date,le.avelength_corp_key,le.avelength_corp_orig_sos_charter_nbr,le.avelength_corp_vendor,le.avelength_corp_state_origin,le.avelength_corp_legal_name,le.avelength_corp_inc_state,le.avelength_corp_forgn_state_desc,le.avelength_corp_foreign_domestic_ind,le.avelength_corp_for_profit_ind,le.avelength_corp_ln_name_type_cd,le.avelength_corp_ln_name_type_desc,le.avelength_corp_orig_bus_type_cd,le.avelength_corp_status_cd,le.avelength_corp_orig_org_structure_cd,le.avelength_corp_country_of_formation);
END;
EXPORT invSummary := NORMALIZE(summary0, 33, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT34.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.corp_ra_dt_first_seen <> 0,TRIM((SALT34.StrType)le.corp_ra_dt_first_seen), ''),IF (le.corp_ra_dt_last_seen <> 0,TRIM((SALT34.StrType)le.corp_ra_dt_last_seen), ''),TRIM((SALT34.StrType)le.corp_process_date),TRIM((SALT34.StrType)le.corp_inc_date),TRIM((SALT34.StrType)le.corp_forgn_date),TRIM((SALT34.StrType)le.corp_filing_date),TRIM((SALT34.StrType)le.corp_status_date),TRIM((SALT34.StrType)le.corp_merger_date),TRIM((SALT34.StrType)le.corp_ra_resign_date),TRIM((SALT34.StrType)le.corp_term_exist_exp),TRIM((SALT34.StrType)le.cont_effective_date),TRIM((SALT34.StrType)le.corp_dissolved_date),TRIM((SALT34.StrType)le.corp_name_status_date),TRIM((SALT34.StrType)le.corp_name_reservation_expiration_date),TRIM((SALT34.StrType)le.corp_key),TRIM((SALT34.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT34.StrType)le.corp_vendor),TRIM((SALT34.StrType)le.corp_state_origin),TRIM((SALT34.StrType)le.corp_legal_name),TRIM((SALT34.StrType)le.corp_inc_state),TRIM((SALT34.StrType)le.corp_forgn_state_desc),TRIM((SALT34.StrType)le.corp_foreign_domestic_ind),TRIM((SALT34.StrType)le.corp_for_profit_ind),TRIM((SALT34.StrType)le.corp_ln_name_type_cd),TRIM((SALT34.StrType)le.corp_ln_name_type_desc),TRIM((SALT34.StrType)le.corp_orig_bus_type_cd),TRIM((SALT34.StrType)le.corp_status_cd),TRIM((SALT34.StrType)le.corp_orig_org_structure_cd),TRIM((SALT34.StrType)le.corp_country_of_formation)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,33,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT34.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 33);
  SELF.FldNo2 := 1 + (C % 33);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.corp_ra_dt_first_seen <> 0,TRIM((SALT34.StrType)le.corp_ra_dt_first_seen), ''),IF (le.corp_ra_dt_last_seen <> 0,TRIM((SALT34.StrType)le.corp_ra_dt_last_seen), ''),TRIM((SALT34.StrType)le.corp_process_date),TRIM((SALT34.StrType)le.corp_inc_date),TRIM((SALT34.StrType)le.corp_forgn_date),TRIM((SALT34.StrType)le.corp_filing_date),TRIM((SALT34.StrType)le.corp_status_date),TRIM((SALT34.StrType)le.corp_merger_date),TRIM((SALT34.StrType)le.corp_ra_resign_date),TRIM((SALT34.StrType)le.corp_term_exist_exp),TRIM((SALT34.StrType)le.cont_effective_date),TRIM((SALT34.StrType)le.corp_dissolved_date),TRIM((SALT34.StrType)le.corp_name_status_date),TRIM((SALT34.StrType)le.corp_name_reservation_expiration_date),TRIM((SALT34.StrType)le.corp_key),TRIM((SALT34.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT34.StrType)le.corp_vendor),TRIM((SALT34.StrType)le.corp_state_origin),TRIM((SALT34.StrType)le.corp_legal_name),TRIM((SALT34.StrType)le.corp_inc_state),TRIM((SALT34.StrType)le.corp_forgn_state_desc),TRIM((SALT34.StrType)le.corp_foreign_domestic_ind),TRIM((SALT34.StrType)le.corp_for_profit_ind),TRIM((SALT34.StrType)le.corp_ln_name_type_cd),TRIM((SALT34.StrType)le.corp_ln_name_type_desc),TRIM((SALT34.StrType)le.corp_orig_bus_type_cd),TRIM((SALT34.StrType)le.corp_status_cd),TRIM((SALT34.StrType)le.corp_orig_org_structure_cd),TRIM((SALT34.StrType)le.corp_country_of_formation)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.corp_ra_dt_first_seen <> 0,TRIM((SALT34.StrType)le.corp_ra_dt_first_seen), ''),IF (le.corp_ra_dt_last_seen <> 0,TRIM((SALT34.StrType)le.corp_ra_dt_last_seen), ''),TRIM((SALT34.StrType)le.corp_process_date),TRIM((SALT34.StrType)le.corp_inc_date),TRIM((SALT34.StrType)le.corp_forgn_date),TRIM((SALT34.StrType)le.corp_filing_date),TRIM((SALT34.StrType)le.corp_status_date),TRIM((SALT34.StrType)le.corp_merger_date),TRIM((SALT34.StrType)le.corp_ra_resign_date),TRIM((SALT34.StrType)le.corp_term_exist_exp),TRIM((SALT34.StrType)le.cont_effective_date),TRIM((SALT34.StrType)le.corp_dissolved_date),TRIM((SALT34.StrType)le.corp_name_status_date),TRIM((SALT34.StrType)le.corp_name_reservation_expiration_date),TRIM((SALT34.StrType)le.corp_key),TRIM((SALT34.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT34.StrType)le.corp_vendor),TRIM((SALT34.StrType)le.corp_state_origin),TRIM((SALT34.StrType)le.corp_legal_name),TRIM((SALT34.StrType)le.corp_inc_state),TRIM((SALT34.StrType)le.corp_forgn_state_desc),TRIM((SALT34.StrType)le.corp_foreign_domestic_ind),TRIM((SALT34.StrType)le.corp_for_profit_ind),TRIM((SALT34.StrType)le.corp_ln_name_type_cd),TRIM((SALT34.StrType)le.corp_ln_name_type_desc),TRIM((SALT34.StrType)le.corp_orig_bus_type_cd),TRIM((SALT34.StrType)le.corp_status_cd),TRIM((SALT34.StrType)le.corp_orig_org_structure_cd),TRIM((SALT34.StrType)le.corp_country_of_formation)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),33*33,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_vendor_first_reported'}
      ,{2,'dt_vendor_last_reported'}
      ,{3,'dt_first_seen'}
      ,{4,'dt_last_seen'}
      ,{5,'corp_ra_dt_first_seen'}
      ,{6,'corp_ra_dt_last_seen'}
      ,{7,'corp_process_date'}
      ,{8,'corp_inc_date'}
      ,{9,'corp_forgn_date'}
      ,{10,'corp_filing_date'}
      ,{11,'corp_status_date'}
      ,{12,'corp_merger_date'}
      ,{13,'corp_ra_resign_date'}
      ,{14,'corp_term_exist_exp'}
      ,{15,'cont_effective_date'}
      ,{16,'corp_dissolved_date'}
      ,{17,'corp_name_status_date'}
      ,{18,'corp_name_reservation_expiration_date'}
      ,{19,'corp_key'}
      ,{20,'corp_orig_sos_charter_nbr'}
      ,{21,'corp_vendor'}
      ,{22,'corp_state_origin'}
      ,{23,'corp_legal_name'}
      ,{24,'corp_inc_state'}
      ,{25,'corp_forgn_state_desc'}
      ,{26,'corp_foreign_domestic_ind'}
      ,{27,'corp_for_profit_ind'}
      ,{28,'corp_ln_name_type_cd'}
      ,{29,'corp_ln_name_type_desc'}
      ,{30,'corp_orig_bus_type_cd'}
      ,{31,'corp_status_cd'}
      ,{32,'corp_orig_org_structure_cd'}
      ,{33,'corp_country_of_formation'}],SALT34.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT34.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT34.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT34.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dt_vendor_first_reported((SALT34.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT34.StrType)le.dt_vendor_last_reported),
    Fields.InValid_dt_first_seen((SALT34.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT34.StrType)le.dt_last_seen),
    Fields.InValid_corp_ra_dt_first_seen((SALT34.StrType)le.corp_ra_dt_first_seen),
    Fields.InValid_corp_ra_dt_last_seen((SALT34.StrType)le.corp_ra_dt_last_seen),
    Fields.InValid_corp_process_date((SALT34.StrType)le.corp_process_date),
    Fields.InValid_corp_inc_date((SALT34.StrType)le.corp_inc_date),
    Fields.InValid_corp_forgn_date((SALT34.StrType)le.corp_forgn_date),
    Fields.InValid_corp_filing_date((SALT34.StrType)le.corp_filing_date),
    Fields.InValid_corp_status_date((SALT34.StrType)le.corp_status_date),
    Fields.InValid_corp_merger_date((SALT34.StrType)le.corp_merger_date),
    Fields.InValid_corp_ra_resign_date((SALT34.StrType)le.corp_ra_resign_date),
    Fields.InValid_corp_term_exist_exp((SALT34.StrType)le.corp_term_exist_exp),
    Fields.InValid_cont_effective_date((SALT34.StrType)le.cont_effective_date),
    Fields.InValid_corp_dissolved_date((SALT34.StrType)le.corp_dissolved_date),
    Fields.InValid_corp_name_status_date((SALT34.StrType)le.corp_name_status_date),
    Fields.InValid_corp_name_reservation_expiration_date((SALT34.StrType)le.corp_name_reservation_expiration_date),
    Fields.InValid_corp_key((SALT34.StrType)le.corp_key),
    Fields.InValid_corp_orig_sos_charter_nbr((SALT34.StrType)le.corp_orig_sos_charter_nbr),
    Fields.InValid_corp_vendor((SALT34.StrType)le.corp_vendor),
    Fields.InValid_corp_state_origin((SALT34.StrType)le.corp_state_origin),
    Fields.InValid_corp_legal_name((SALT34.StrType)le.corp_legal_name),
    Fields.InValid_corp_inc_state((SALT34.StrType)le.corp_inc_state),
    Fields.InValid_corp_forgn_state_desc((SALT34.StrType)le.corp_forgn_state_desc),
    Fields.InValid_corp_foreign_domestic_ind((SALT34.StrType)le.corp_foreign_domestic_ind),
    Fields.InValid_corp_for_profit_ind((SALT34.StrType)le.corp_for_profit_ind),
    Fields.InValid_corp_ln_name_type_cd((SALT34.StrType)le.corp_ln_name_type_cd),
    Fields.InValid_corp_ln_name_type_desc((SALT34.StrType)le.corp_ln_name_type_desc),
    Fields.InValid_corp_orig_bus_type_cd((SALT34.StrType)le.corp_orig_bus_type_cd),
    Fields.InValid_corp_status_cd((SALT34.StrType)le.corp_status_cd),
    Fields.InValid_corp_orig_org_structure_cd((SALT34.StrType)le.corp_orig_org_structure_cd),
    Fields.InValid_corp_country_of_formation((SALT34.StrType)le.corp_country_of_formation),
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
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_corp_key','invalid_charter','invalid_corp_vendor','invalid_state_origin','invalid_mandatory','invalid_state_origin','invalid_alphablank','invalid_forgn_dom_code','invalid_for_profit_ind','invalid_name_type_cd','invalid_name_type_desc','invalid_orig_bus_type_cd','invalid_corp_status_cd','invalid_orig_org_structure_cd','invalid_alphablank');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_corp_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_inc_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_filing_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_status_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_merger_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_resign_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_term_exist_exp(TotalErrors.ErrorNum),Fields.InValidMessage_cont_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_dissolved_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_name_status_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_name_reservation_expiration_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_sos_charter_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor(TotalErrors.ErrorNum),Fields.InValidMessage_corp_state_origin(TotalErrors.ErrorNum),Fields.InValidMessage_corp_legal_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_inc_state(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_state_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_foreign_domestic_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_for_profit_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ln_name_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ln_name_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_bus_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_status_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_org_structure_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_country_of_formation(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;

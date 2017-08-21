IMPORT SALT32,std;
EXPORT match_methods(DATASET(layout_In_AK) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_dt_vendor_first_reported_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_dt_vendor_first_reported_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_dt_vendor_first_reported_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_dt_vendor_first_reported(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_dt_vendor_last_reported_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_dt_vendor_last_reported_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_dt_vendor_last_reported_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_dt_vendor_last_reported(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_dt_first_seen_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_dt_first_seen_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_dt_first_seen_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_dt_first_seen(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_dt_last_seen_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_dt_last_seen_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_dt_last_seen_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_dt_last_seen(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_ra_dt_first_seen_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_ra_dt_first_seen_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_ra_dt_first_seen_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_ra_dt_first_seen(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_ra_dt_last_seen_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_ra_dt_last_seen_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_ra_dt_last_seen_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_ra_dt_last_seen(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_key(TYPEOF(h.corp_key) L, TYPEOF(h.corp_key) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_corp_vendor(TYPEOF(h.corp_vendor) L, TYPEOF(h.corp_vendor) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_corp_state_origin(TYPEOF(h.corp_state_origin) L, TYPEOF(h.corp_state_origin) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_corp_process_date(TYPEOF(h.corp_process_date) L, TYPEOF(h.corp_process_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_corp_orig_sos_charter_nbr(TYPEOF(h.corp_orig_sos_charter_nbr) L, TYPEOF(h.corp_orig_sos_charter_nbr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_corp_legal_name(TYPEOF(h.corp_legal_name) L, TYPEOF(h.corp_legal_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_corp_ln_name_type_cd(TYPEOF(h.corp_ln_name_type_cd) L, TYPEOF(h.corp_ln_name_type_cd) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_corp_status_desc(TYPEOF(h.corp_status_desc) L, TYPEOF(h.corp_status_desc) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_corp_standing(TYPEOF(h.corp_standing) L, TYPEOF(h.corp_standing) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_corp_inc_state(TYPEOF(h.corp_inc_state) L, TYPEOF(h.corp_inc_state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_corp_inc_date_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_inc_date_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_inc_date_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_inc_date(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_term_exist_cd(TYPEOF(h.corp_term_exist_cd) L, TYPEOF(h.corp_term_exist_cd) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_corp_term_exist_exp_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_term_exist_exp_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_term_exist_exp_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_term_exist_exp(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_term_exist_desc(TYPEOF(h.corp_term_exist_desc) L, TYPEOF(h.corp_term_exist_desc) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_corp_foreign_domestic_ind(TYPEOF(h.corp_foreign_domestic_ind) L, TYPEOF(h.corp_foreign_domestic_ind) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_corp_forgn_date_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_forgn_date_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_forgn_date_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_forgn_date(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_corp_orig_org_structure_desc(TYPEOF(h.corp_orig_org_structure_desc) L, TYPEOF(h.corp_orig_org_structure_desc) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_corp_for_profit_ind(TYPEOF(h.corp_for_profit_ind) L, TYPEOF(h.corp_for_profit_ind) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_corp_country_of_formation(TYPEOF(h.corp_country_of_formation) L, TYPEOF(h.corp_country_of_formation) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_Corp_Name_Status_Desc(TYPEOF(h.Corp_Name_Status_Desc) L, TYPEOF(h.Corp_Name_Status_Desc) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_corp_forgn_state_cd(TYPEOF(h.corp_forgn_state_cd) L, TYPEOF(h.corp_forgn_state_cd) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_recordorigin(TYPEOF(h.recordorigin) L, TYPEOF(h.recordorigin) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
END;


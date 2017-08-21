// Begin code to perform the matching itself
 
IMPORT SALT34,ut,std;
EXPORT matches(DATASET(layout_in_file) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.1 := le.;
  SELF.2 := ri.;
  SELF.1 := le.;
  SELF.2 := ri.;
  INTEGER2 dt_vendor_first_reported_year_score := MAP ( le.dt_vendor_first_reported_year_isnull or ri.dt_vendor_first_reported_year_isnull => 0,
                                  le.dt_vendor_first_reported_year = ri.dt_vendor_first_reported_year => le.dt_vendor_first_reported_year_weight100,
                                  SALT34.fn_fail_scale(le.dt_vendor_first_reported_year_weight100,s.dt_vendor_first_reported_year_switch) );
  INTEGER2 dt_vendor_first_reported_month_score := MAP ( le.dt_vendor_first_reported_month_isnull or ri.dt_vendor_first_reported_month_isnull => 0,
                                  le.dt_vendor_first_reported_month = ri.dt_vendor_first_reported_month => le.dt_vendor_first_reported_month_weight100,
                                  SALT34.fn_fail_scale(le.dt_vendor_first_reported_month_weight100,s.dt_vendor_first_reported_month_switch) );
  INTEGER2 dt_vendor_first_reported_day_score := MAP ( le.dt_vendor_first_reported_day_isnull or ri.dt_vendor_first_reported_day_isnull => 0,
                                  le.dt_vendor_first_reported_day = ri.dt_vendor_first_reported_day => le.dt_vendor_first_reported_day_weight100,
                                  SALT34.fn_fail_scale(le.dt_vendor_first_reported_day_weight100,s.dt_vendor_first_reported_day_switch) );
  INTEGER2 dt_vendor_first_reported_score_temp := (dt_vendor_first_reported_year_score+dt_vendor_first_reported_month_score+dt_vendor_first_reported_day_score);
  INTEGER2 dt_vendor_first_reported_score := MAP( le.dt_vendor_first_reported_year  IN SET(s.nulls_dt_vendor_first_reported_year,dt_vendor_first_reported_year) AND le.dt_vendor_first_reported_month  IN SET(s.nulls_dt_vendor_first_reported_month,dt_vendor_first_reported_month) AND le.dt_vendor_first_reported_day  IN SET(s.nulls_dt_vendor_first_reported_day,dt_vendor_first_reported_day) or ri.dt_vendor_first_reported_year  IN SET(s.nulls_dt_vendor_first_reported_year,dt_vendor_first_reported_year) AND ri.dt_vendor_first_reported_month  IN SET(s.nulls_dt_vendor_first_reported_month,dt_vendor_first_reported_month) AND ri.dt_vendor_first_reported_day  IN SET(s.nulls_dt_vendor_first_reported_day,dt_vendor_first_reported_day) => 0,
                        dt_vendor_first_reported_score_temp);
 
  INTEGER2 dt_vendor_last_reported_year_score := MAP ( le.dt_vendor_last_reported_year_isnull or ri.dt_vendor_last_reported_year_isnull => 0,
                                  le.dt_vendor_last_reported_year = ri.dt_vendor_last_reported_year => le.dt_vendor_last_reported_year_weight100,
                                  SALT34.fn_fail_scale(le.dt_vendor_last_reported_year_weight100,s.dt_vendor_last_reported_year_switch) );
  INTEGER2 dt_vendor_last_reported_month_score := MAP ( le.dt_vendor_last_reported_month_isnull or ri.dt_vendor_last_reported_month_isnull => 0,
                                  le.dt_vendor_last_reported_month = ri.dt_vendor_last_reported_month => le.dt_vendor_last_reported_month_weight100,
                                  SALT34.fn_fail_scale(le.dt_vendor_last_reported_month_weight100,s.dt_vendor_last_reported_month_switch) );
  INTEGER2 dt_vendor_last_reported_day_score := MAP ( le.dt_vendor_last_reported_day_isnull or ri.dt_vendor_last_reported_day_isnull => 0,
                                  le.dt_vendor_last_reported_day = ri.dt_vendor_last_reported_day => le.dt_vendor_last_reported_day_weight100,
                                  SALT34.fn_fail_scale(le.dt_vendor_last_reported_day_weight100,s.dt_vendor_last_reported_day_switch) );
  INTEGER2 dt_vendor_last_reported_score_temp := (dt_vendor_last_reported_year_score+dt_vendor_last_reported_month_score+dt_vendor_last_reported_day_score);
  INTEGER2 dt_vendor_last_reported_score := MAP( le.dt_vendor_last_reported_year  IN SET(s.nulls_dt_vendor_last_reported_year,dt_vendor_last_reported_year) AND le.dt_vendor_last_reported_month  IN SET(s.nulls_dt_vendor_last_reported_month,dt_vendor_last_reported_month) AND le.dt_vendor_last_reported_day  IN SET(s.nulls_dt_vendor_last_reported_day,dt_vendor_last_reported_day) or ri.dt_vendor_last_reported_year  IN SET(s.nulls_dt_vendor_last_reported_year,dt_vendor_last_reported_year) AND ri.dt_vendor_last_reported_month  IN SET(s.nulls_dt_vendor_last_reported_month,dt_vendor_last_reported_month) AND ri.dt_vendor_last_reported_day  IN SET(s.nulls_dt_vendor_last_reported_day,dt_vendor_last_reported_day) => 0,
                        dt_vendor_last_reported_score_temp);
 
  INTEGER2 dt_first_seen_year_score := MAP ( le.dt_first_seen_year_isnull or ri.dt_first_seen_year_isnull => 0,
                                  le.dt_first_seen_year = ri.dt_first_seen_year => le.dt_first_seen_year_weight100,
                                  SALT34.fn_fail_scale(le.dt_first_seen_year_weight100,s.dt_first_seen_year_switch) );
  INTEGER2 dt_first_seen_month_score := MAP ( le.dt_first_seen_month_isnull or ri.dt_first_seen_month_isnull => 0,
                                  le.dt_first_seen_month = ri.dt_first_seen_month => le.dt_first_seen_month_weight100,
                                  SALT34.fn_fail_scale(le.dt_first_seen_month_weight100,s.dt_first_seen_month_switch) );
  INTEGER2 dt_first_seen_day_score := MAP ( le.dt_first_seen_day_isnull or ri.dt_first_seen_day_isnull => 0,
                                  le.dt_first_seen_day = ri.dt_first_seen_day => le.dt_first_seen_day_weight100,
                                  SALT34.fn_fail_scale(le.dt_first_seen_day_weight100,s.dt_first_seen_day_switch) );
  INTEGER2 dt_first_seen_score_temp := (dt_first_seen_year_score+dt_first_seen_month_score+dt_first_seen_day_score);
  INTEGER2 dt_first_seen_score := MAP( le.dt_first_seen_year  IN SET(s.nulls_dt_first_seen_year,dt_first_seen_year) AND le.dt_first_seen_month  IN SET(s.nulls_dt_first_seen_month,dt_first_seen_month) AND le.dt_first_seen_day  IN SET(s.nulls_dt_first_seen_day,dt_first_seen_day) or ri.dt_first_seen_year  IN SET(s.nulls_dt_first_seen_year,dt_first_seen_year) AND ri.dt_first_seen_month  IN SET(s.nulls_dt_first_seen_month,dt_first_seen_month) AND ri.dt_first_seen_day  IN SET(s.nulls_dt_first_seen_day,dt_first_seen_day) => 0,
                        dt_first_seen_score_temp);
 
  INTEGER2 dt_last_seen_year_score := MAP ( le.dt_last_seen_year_isnull or ri.dt_last_seen_year_isnull => 0,
                                  le.dt_last_seen_year = ri.dt_last_seen_year => le.dt_last_seen_year_weight100,
                                  SALT34.fn_fail_scale(le.dt_last_seen_year_weight100,s.dt_last_seen_year_switch) );
  INTEGER2 dt_last_seen_month_score := MAP ( le.dt_last_seen_month_isnull or ri.dt_last_seen_month_isnull => 0,
                                  le.dt_last_seen_month = ri.dt_last_seen_month => le.dt_last_seen_month_weight100,
                                  SALT34.fn_fail_scale(le.dt_last_seen_month_weight100,s.dt_last_seen_month_switch) );
  INTEGER2 dt_last_seen_day_score := MAP ( le.dt_last_seen_day_isnull or ri.dt_last_seen_day_isnull => 0,
                                  le.dt_last_seen_day = ri.dt_last_seen_day => le.dt_last_seen_day_weight100,
                                  SALT34.fn_fail_scale(le.dt_last_seen_day_weight100,s.dt_last_seen_day_switch) );
  INTEGER2 dt_last_seen_score_temp := (dt_last_seen_year_score+dt_last_seen_month_score+dt_last_seen_day_score);
  INTEGER2 dt_last_seen_score := MAP( le.dt_last_seen_year  IN SET(s.nulls_dt_last_seen_year,dt_last_seen_year) AND le.dt_last_seen_month  IN SET(s.nulls_dt_last_seen_month,dt_last_seen_month) AND le.dt_last_seen_day  IN SET(s.nulls_dt_last_seen_day,dt_last_seen_day) or ri.dt_last_seen_year  IN SET(s.nulls_dt_last_seen_year,dt_last_seen_year) AND ri.dt_last_seen_month  IN SET(s.nulls_dt_last_seen_month,dt_last_seen_month) AND ri.dt_last_seen_day  IN SET(s.nulls_dt_last_seen_day,dt_last_seen_day) => 0,
                        dt_last_seen_score_temp);
 
  INTEGER2 corp_ra_dt_first_seen_year_score := MAP ( le.corp_ra_dt_first_seen_year_isnull or ri.corp_ra_dt_first_seen_year_isnull => 0,
                                  le.corp_ra_dt_first_seen_year = ri.corp_ra_dt_first_seen_year => le.corp_ra_dt_first_seen_year_weight100,
                                  SALT34.fn_fail_scale(le.corp_ra_dt_first_seen_year_weight100,s.corp_ra_dt_first_seen_year_switch) );
  INTEGER2 corp_ra_dt_first_seen_month_score := MAP ( le.corp_ra_dt_first_seen_month_isnull or ri.corp_ra_dt_first_seen_month_isnull => 0,
                                  le.corp_ra_dt_first_seen_month = ri.corp_ra_dt_first_seen_month => le.corp_ra_dt_first_seen_month_weight100,
                                  SALT34.fn_fail_scale(le.corp_ra_dt_first_seen_month_weight100,s.corp_ra_dt_first_seen_month_switch) );
  INTEGER2 corp_ra_dt_first_seen_day_score := MAP ( le.corp_ra_dt_first_seen_day_isnull or ri.corp_ra_dt_first_seen_day_isnull => 0,
                                  le.corp_ra_dt_first_seen_day = ri.corp_ra_dt_first_seen_day => le.corp_ra_dt_first_seen_day_weight100,
                                  SALT34.fn_fail_scale(le.corp_ra_dt_first_seen_day_weight100,s.corp_ra_dt_first_seen_day_switch) );
  INTEGER2 corp_ra_dt_first_seen_score_temp := (corp_ra_dt_first_seen_year_score+corp_ra_dt_first_seen_month_score+corp_ra_dt_first_seen_day_score);
  INTEGER2 corp_ra_dt_first_seen_score := MAP( le.corp_ra_dt_first_seen_year  IN SET(s.nulls_corp_ra_dt_first_seen_year,corp_ra_dt_first_seen_year) AND le.corp_ra_dt_first_seen_month  IN SET(s.nulls_corp_ra_dt_first_seen_month,corp_ra_dt_first_seen_month) AND le.corp_ra_dt_first_seen_day  IN SET(s.nulls_corp_ra_dt_first_seen_day,corp_ra_dt_first_seen_day) or ri.corp_ra_dt_first_seen_year  IN SET(s.nulls_corp_ra_dt_first_seen_year,corp_ra_dt_first_seen_year) AND ri.corp_ra_dt_first_seen_month  IN SET(s.nulls_corp_ra_dt_first_seen_month,corp_ra_dt_first_seen_month) AND ri.corp_ra_dt_first_seen_day  IN SET(s.nulls_corp_ra_dt_first_seen_day,corp_ra_dt_first_seen_day) => 0,
                        corp_ra_dt_first_seen_score_temp);
 
  INTEGER2 corp_ra_dt_last_seen_year_score := MAP ( le.corp_ra_dt_last_seen_year_isnull or ri.corp_ra_dt_last_seen_year_isnull => 0,
                                  le.corp_ra_dt_last_seen_year = ri.corp_ra_dt_last_seen_year => le.corp_ra_dt_last_seen_year_weight100,
                                  SALT34.fn_fail_scale(le.corp_ra_dt_last_seen_year_weight100,s.corp_ra_dt_last_seen_year_switch) );
  INTEGER2 corp_ra_dt_last_seen_month_score := MAP ( le.corp_ra_dt_last_seen_month_isnull or ri.corp_ra_dt_last_seen_month_isnull => 0,
                                  le.corp_ra_dt_last_seen_month = ri.corp_ra_dt_last_seen_month => le.corp_ra_dt_last_seen_month_weight100,
                                  SALT34.fn_fail_scale(le.corp_ra_dt_last_seen_month_weight100,s.corp_ra_dt_last_seen_month_switch) );
  INTEGER2 corp_ra_dt_last_seen_day_score := MAP ( le.corp_ra_dt_last_seen_day_isnull or ri.corp_ra_dt_last_seen_day_isnull => 0,
                                  le.corp_ra_dt_last_seen_day = ri.corp_ra_dt_last_seen_day => le.corp_ra_dt_last_seen_day_weight100,
                                  SALT34.fn_fail_scale(le.corp_ra_dt_last_seen_day_weight100,s.corp_ra_dt_last_seen_day_switch) );
  INTEGER2 corp_ra_dt_last_seen_score_temp := (corp_ra_dt_last_seen_year_score+corp_ra_dt_last_seen_month_score+corp_ra_dt_last_seen_day_score);
  INTEGER2 corp_ra_dt_last_seen_score := MAP( le.corp_ra_dt_last_seen_year  IN SET(s.nulls_corp_ra_dt_last_seen_year,corp_ra_dt_last_seen_year) AND le.corp_ra_dt_last_seen_month  IN SET(s.nulls_corp_ra_dt_last_seen_month,corp_ra_dt_last_seen_month) AND le.corp_ra_dt_last_seen_day  IN SET(s.nulls_corp_ra_dt_last_seen_day,corp_ra_dt_last_seen_day) or ri.corp_ra_dt_last_seen_year  IN SET(s.nulls_corp_ra_dt_last_seen_year,corp_ra_dt_last_seen_year) AND ri.corp_ra_dt_last_seen_month  IN SET(s.nulls_corp_ra_dt_last_seen_month,corp_ra_dt_last_seen_month) AND ri.corp_ra_dt_last_seen_day  IN SET(s.nulls_corp_ra_dt_last_seen_day,corp_ra_dt_last_seen_day) => 0,
                        corp_ra_dt_last_seen_score_temp);
 
  INTEGER2 corp_key_score := MAP(
                        le.corp_key_isnull OR ri.corp_key_isnull => 0,
                        le.corp_key = ri.corp_key  => le.corp_key_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_key_weight100,s.corp_key_switch));
  INTEGER2 corp_supp_key_score := MAP(
                        le.corp_supp_key_isnull OR ri.corp_supp_key_isnull => 0,
                        le.corp_supp_key = ri.corp_supp_key  => le.corp_supp_key_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_supp_key_weight100,s.corp_supp_key_switch));
  INTEGER2 corp_vendor_score := MAP(
                        le.corp_vendor_isnull OR ri.corp_vendor_isnull => 0,
                        le.corp_vendor = ri.corp_vendor  => le.corp_vendor_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_vendor_weight100,s.corp_vendor_switch));
  INTEGER2 corp_vendor_county_score := MAP(
                        le.corp_vendor_county_isnull OR ri.corp_vendor_county_isnull => 0,
                        le.corp_vendor_county = ri.corp_vendor_county  => le.corp_vendor_county_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_vendor_county_weight100,s.corp_vendor_county_switch));
  INTEGER2 corp_vendor_subcode_score := MAP(
                        le.corp_vendor_subcode_isnull OR ri.corp_vendor_subcode_isnull => 0,
                        le.corp_vendor_subcode = ri.corp_vendor_subcode  => le.corp_vendor_subcode_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_vendor_subcode_weight100,s.corp_vendor_subcode_switch));
  INTEGER2 corp_state_origin_score := MAP(
                        le.corp_state_origin_isnull OR ri.corp_state_origin_isnull => 0,
                        le.corp_state_origin = ri.corp_state_origin  => le.corp_state_origin_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_state_origin_weight100,s.corp_state_origin_switch));
  INTEGER2 corp_process_date_year_score := MAP ( le.corp_process_date_year_isnull or ri.corp_process_date_year_isnull => 0,
                                  le.corp_process_date_year = ri.corp_process_date_year => le.corp_process_date_year_weight100,
                                  SALT34.fn_fail_scale(le.corp_process_date_year_weight100,s.corp_process_date_year_switch) );
  INTEGER2 corp_process_date_month_score := MAP ( le.corp_process_date_month_isnull or ri.corp_process_date_month_isnull => 0,
                                  le.corp_process_date_month = ri.corp_process_date_month => le.corp_process_date_month_weight100,
                                  SALT34.fn_fail_scale(le.corp_process_date_month_weight100,s.corp_process_date_month_switch) );
  INTEGER2 corp_process_date_day_score := MAP ( le.corp_process_date_day_isnull or ri.corp_process_date_day_isnull => 0,
                                  le.corp_process_date_day = ri.corp_process_date_day => le.corp_process_date_day_weight100,
                                  SALT34.fn_fail_scale(le.corp_process_date_day_weight100,s.corp_process_date_day_switch) );
  INTEGER2 corp_process_date_score_temp := (corp_process_date_year_score+corp_process_date_month_score+corp_process_date_day_score);
  INTEGER2 corp_process_date_score := MAP( le.corp_process_date_year  IN SET(s.nulls_corp_process_date_year,corp_process_date_year) AND le.corp_process_date_month  IN SET(s.nulls_corp_process_date_month,corp_process_date_month) AND le.corp_process_date_day  IN SET(s.nulls_corp_process_date_day,corp_process_date_day) or ri.corp_process_date_year  IN SET(s.nulls_corp_process_date_year,corp_process_date_year) AND ri.corp_process_date_month  IN SET(s.nulls_corp_process_date_month,corp_process_date_month) AND ri.corp_process_date_day  IN SET(s.nulls_corp_process_date_day,corp_process_date_day) => 0,
                        corp_process_date_score_temp);
 
  INTEGER2 corp_orig_sos_charter_nbr_score := MAP(
                        le.corp_orig_sos_charter_nbr_isnull OR ri.corp_orig_sos_charter_nbr_isnull => 0,
                        le.corp_orig_sos_charter_nbr = ri.corp_orig_sos_charter_nbr  => le.corp_orig_sos_charter_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_orig_sos_charter_nbr_weight100,s.corp_orig_sos_charter_nbr_switch));
  INTEGER2 corp_legal_name_score := MAP(
                        le.corp_legal_name_isnull OR ri.corp_legal_name_isnull => 0,
                        le.corp_legal_name = ri.corp_legal_name  => le.corp_legal_name_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_legal_name_weight100,s.corp_legal_name_switch));
  INTEGER2 corp_ln_name_type_cd_score := MAP(
                        le.corp_ln_name_type_cd_isnull OR ri.corp_ln_name_type_cd_isnull => 0,
                        le.corp_ln_name_type_cd = ri.corp_ln_name_type_cd  => le.corp_ln_name_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ln_name_type_cd_weight100,s.corp_ln_name_type_cd_switch));
  INTEGER2 corp_ln_name_type_desc_score := MAP(
                        le.corp_ln_name_type_desc_isnull OR ri.corp_ln_name_type_desc_isnull => 0,
                        le.corp_ln_name_type_desc = ri.corp_ln_name_type_desc  => le.corp_ln_name_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ln_name_type_desc_weight100,s.corp_ln_name_type_desc_switch));
  INTEGER2 corp_supp_nbr_score := MAP(
                        le.corp_supp_nbr_isnull OR ri.corp_supp_nbr_isnull => 0,
                        le.corp_supp_nbr = ri.corp_supp_nbr  => le.corp_supp_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_supp_nbr_weight100,s.corp_supp_nbr_switch));
  INTEGER2 corp_name_comment_score := MAP(
                        le.corp_name_comment_isnull OR ri.corp_name_comment_isnull => 0,
                        le.corp_name_comment = ri.corp_name_comment  => le.corp_name_comment_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_comment_weight100,s.corp_name_comment_switch));
  INTEGER2 corp_address1_type_cd_score := MAP(
                        le.corp_address1_type_cd_isnull OR ri.corp_address1_type_cd_isnull => 0,
                        le.corp_address1_type_cd = ri.corp_address1_type_cd  => le.corp_address1_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address1_type_cd_weight100,s.corp_address1_type_cd_switch));
  INTEGER2 corp_address1_type_desc_score := MAP(
                        le.corp_address1_type_desc_isnull OR ri.corp_address1_type_desc_isnull => 0,
                        le.corp_address1_type_desc = ri.corp_address1_type_desc  => le.corp_address1_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address1_type_desc_weight100,s.corp_address1_type_desc_switch));
  INTEGER2 corp_address1_line1_score := MAP(
                        le.corp_address1_line1_isnull OR ri.corp_address1_line1_isnull => 0,
                        le.corp_address1_line1 = ri.corp_address1_line1  => le.corp_address1_line1_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address1_line1_weight100,s.corp_address1_line1_switch));
  INTEGER2 corp_address1_line2_score := MAP(
                        le.corp_address1_line2_isnull OR ri.corp_address1_line2_isnull => 0,
                        le.corp_address1_line2 = ri.corp_address1_line2  => le.corp_address1_line2_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address1_line2_weight100,s.corp_address1_line2_switch));
  INTEGER2 corp_address1_line3_score := MAP(
                        le.corp_address1_line3_isnull OR ri.corp_address1_line3_isnull => 0,
                        le.corp_address1_line3 = ri.corp_address1_line3  => le.corp_address1_line3_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address1_line3_weight100,s.corp_address1_line3_switch));
  INTEGER2 corp_address1_effective_date_score := MAP(
                        le.corp_address1_effective_date_isnull OR ri.corp_address1_effective_date_isnull => 0,
                        le.corp_address1_effective_date = ri.corp_address1_effective_date  => le.corp_address1_effective_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address1_effective_date_weight100,s.corp_address1_effective_date_switch));
  INTEGER2 corp_address2_type_cd_score := MAP(
                        le.corp_address2_type_cd_isnull OR ri.corp_address2_type_cd_isnull => 0,
                        le.corp_address2_type_cd = ri.corp_address2_type_cd  => le.corp_address2_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address2_type_cd_weight100,s.corp_address2_type_cd_switch));
  INTEGER2 corp_address2_type_desc_score := MAP(
                        le.corp_address2_type_desc_isnull OR ri.corp_address2_type_desc_isnull => 0,
                        le.corp_address2_type_desc = ri.corp_address2_type_desc  => le.corp_address2_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address2_type_desc_weight100,s.corp_address2_type_desc_switch));
  INTEGER2 corp_address2_line1_score := MAP(
                        le.corp_address2_line1_isnull OR ri.corp_address2_line1_isnull => 0,
                        le.corp_address2_line1 = ri.corp_address2_line1  => le.corp_address2_line1_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address2_line1_weight100,s.corp_address2_line1_switch));
  INTEGER2 corp_address2_line2_score := MAP(
                        le.corp_address2_line2_isnull OR ri.corp_address2_line2_isnull => 0,
                        le.corp_address2_line2 = ri.corp_address2_line2  => le.corp_address2_line2_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address2_line2_weight100,s.corp_address2_line2_switch));
  INTEGER2 corp_address2_line3_score := MAP(
                        le.corp_address2_line3_isnull OR ri.corp_address2_line3_isnull => 0,
                        le.corp_address2_line3 = ri.corp_address2_line3  => le.corp_address2_line3_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address2_line3_weight100,s.corp_address2_line3_switch));
  INTEGER2 corp_address2_effective_date_score := MAP(
                        le.corp_address2_effective_date_isnull OR ri.corp_address2_effective_date_isnull => 0,
                        le.corp_address2_effective_date = ri.corp_address2_effective_date  => le.corp_address2_effective_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address2_effective_date_weight100,s.corp_address2_effective_date_switch));
  INTEGER2 corp_phone_number_score := MAP(
                        le.corp_phone_number_isnull OR ri.corp_phone_number_isnull => 0,
                        le.corp_phone_number = ri.corp_phone_number  => le.corp_phone_number_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_phone_number_weight100,s.corp_phone_number_switch));
  INTEGER2 corp_phone_number_type_cd_score := MAP(
                        le.corp_phone_number_type_cd_isnull OR ri.corp_phone_number_type_cd_isnull => 0,
                        le.corp_phone_number_type_cd = ri.corp_phone_number_type_cd  => le.corp_phone_number_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_phone_number_type_cd_weight100,s.corp_phone_number_type_cd_switch));
  INTEGER2 corp_phone_number_type_desc_score := MAP(
                        le.corp_phone_number_type_desc_isnull OR ri.corp_phone_number_type_desc_isnull => 0,
                        le.corp_phone_number_type_desc = ri.corp_phone_number_type_desc  => le.corp_phone_number_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_phone_number_type_desc_weight100,s.corp_phone_number_type_desc_switch));
  INTEGER2 corp_fax_nbr_score := MAP(
                        le.corp_fax_nbr_isnull OR ri.corp_fax_nbr_isnull => 0,
                        le.corp_fax_nbr = ri.corp_fax_nbr  => le.corp_fax_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_fax_nbr_weight100,s.corp_fax_nbr_switch));
  INTEGER2 corp_email_address_score := MAP(
                        le.corp_email_address_isnull OR ri.corp_email_address_isnull => 0,
                        le.corp_email_address = ri.corp_email_address  => le.corp_email_address_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_email_address_weight100,s.corp_email_address_switch));
  INTEGER2 corp_web_address_score := MAP(
                        le.corp_web_address_isnull OR ri.corp_web_address_isnull => 0,
                        le.corp_web_address = ri.corp_web_address  => le.corp_web_address_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_web_address_weight100,s.corp_web_address_switch));
  INTEGER2 corp_filing_reference_nbr_score := MAP(
                        le.corp_filing_reference_nbr_isnull OR ri.corp_filing_reference_nbr_isnull => 0,
                        le.corp_filing_reference_nbr = ri.corp_filing_reference_nbr  => le.corp_filing_reference_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_filing_reference_nbr_weight100,s.corp_filing_reference_nbr_switch));
  INTEGER2 corp_filing_date_score := MAP(
                        le.corp_filing_date_isnull OR ri.corp_filing_date_isnull => 0,
                        le.corp_filing_date = ri.corp_filing_date  => le.corp_filing_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_filing_date_weight100,s.corp_filing_date_switch));
  INTEGER2 corp_filing_cd_score := MAP(
                        le.corp_filing_cd_isnull OR ri.corp_filing_cd_isnull => 0,
                        le.corp_filing_cd = ri.corp_filing_cd  => le.corp_filing_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_filing_cd_weight100,s.corp_filing_cd_switch));
  INTEGER2 corp_filing_desc_score := MAP(
                        le.corp_filing_desc_isnull OR ri.corp_filing_desc_isnull => 0,
                        le.corp_filing_desc = ri.corp_filing_desc  => le.corp_filing_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_filing_desc_weight100,s.corp_filing_desc_switch));
  INTEGER2 corp_status_cd_score := MAP(
                        le.corp_status_cd_isnull OR ri.corp_status_cd_isnull => 0,
                        le.corp_status_cd = ri.corp_status_cd  => le.corp_status_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_status_cd_weight100,s.corp_status_cd_switch));
  INTEGER2 corp_status_desc_score := MAP(
                        le.corp_status_desc_isnull OR ri.corp_status_desc_isnull => 0,
                        le.corp_status_desc = ri.corp_status_desc  => le.corp_status_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_status_desc_weight100,s.corp_status_desc_switch));
  INTEGER2 corp_status_date_score := MAP(
                        le.corp_status_date_isnull OR ri.corp_status_date_isnull => 0,
                        le.corp_status_date = ri.corp_status_date  => le.corp_status_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_status_date_weight100,s.corp_status_date_switch));
  INTEGER2 corp_standing_score := MAP(
                        le.corp_standing_isnull OR ri.corp_standing_isnull => 0,
                        le.corp_standing = ri.corp_standing  => le.corp_standing_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_standing_weight100,s.corp_standing_switch));
  INTEGER2 corp_status_comment_score := MAP(
                        le.corp_status_comment_isnull OR ri.corp_status_comment_isnull => 0,
                        le.corp_status_comment = ri.corp_status_comment  => le.corp_status_comment_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_status_comment_weight100,s.corp_status_comment_switch));
  INTEGER2 corp_ticker_symbol_score := MAP(
                        le.corp_ticker_symbol_isnull OR ri.corp_ticker_symbol_isnull => 0,
                        le.corp_ticker_symbol = ri.corp_ticker_symbol  => le.corp_ticker_symbol_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ticker_symbol_weight100,s.corp_ticker_symbol_switch));
  INTEGER2 corp_stock_exchange_score := MAP(
                        le.corp_stock_exchange_isnull OR ri.corp_stock_exchange_isnull => 0,
                        le.corp_stock_exchange = ri.corp_stock_exchange  => le.corp_stock_exchange_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_stock_exchange_weight100,s.corp_stock_exchange_switch));
  INTEGER2 corp_inc_state_score := MAP(
                        le.corp_inc_state_isnull OR ri.corp_inc_state_isnull => 0,
                        le.corp_inc_state = ri.corp_inc_state  => le.corp_inc_state_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_inc_state_weight100,s.corp_inc_state_switch));
  INTEGER2 corp_inc_county_score := MAP(
                        le.corp_inc_county_isnull OR ri.corp_inc_county_isnull => 0,
                        le.corp_inc_county = ri.corp_inc_county  => le.corp_inc_county_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_inc_county_weight100,s.corp_inc_county_switch));
  INTEGER2 corp_inc_date_score := MAP(
                        le.corp_inc_date_isnull OR ri.corp_inc_date_isnull => 0,
                        le.corp_inc_date = ri.corp_inc_date  => le.corp_inc_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_inc_date_weight100,s.corp_inc_date_switch));
  INTEGER2 corp_anniversary_month_score := MAP(
                        le.corp_anniversary_month_isnull OR ri.corp_anniversary_month_isnull => 0,
                        le.corp_anniversary_month = ri.corp_anniversary_month  => le.corp_anniversary_month_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_anniversary_month_weight100,s.corp_anniversary_month_switch));
  INTEGER2 corp_fed_tax_id_score := MAP(
                        le.corp_fed_tax_id_isnull OR ri.corp_fed_tax_id_isnull => 0,
                        le.corp_fed_tax_id = ri.corp_fed_tax_id  => le.corp_fed_tax_id_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_fed_tax_id_weight100,s.corp_fed_tax_id_switch));
  INTEGER2 corp_state_tax_id_score := MAP(
                        le.corp_state_tax_id_isnull OR ri.corp_state_tax_id_isnull => 0,
                        le.corp_state_tax_id = ri.corp_state_tax_id  => le.corp_state_tax_id_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_state_tax_id_weight100,s.corp_state_tax_id_switch));
  INTEGER2 corp_term_exist_cd_score := MAP(
                        le.corp_term_exist_cd_isnull OR ri.corp_term_exist_cd_isnull => 0,
                        le.corp_term_exist_cd = ri.corp_term_exist_cd  => le.corp_term_exist_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_term_exist_cd_weight100,s.corp_term_exist_cd_switch));
  INTEGER2 corp_term_exist_exp_score := MAP(
                        le.corp_term_exist_exp_isnull OR ri.corp_term_exist_exp_isnull => 0,
                        le.corp_term_exist_exp = ri.corp_term_exist_exp  => le.corp_term_exist_exp_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_term_exist_exp_weight100,s.corp_term_exist_exp_switch));
  INTEGER2 corp_term_exist_desc_score := MAP(
                        le.corp_term_exist_desc_isnull OR ri.corp_term_exist_desc_isnull => 0,
                        le.corp_term_exist_desc = ri.corp_term_exist_desc  => le.corp_term_exist_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_term_exist_desc_weight100,s.corp_term_exist_desc_switch));
  INTEGER2 corp_foreign_domestic_ind_score := MAP(
                        le.corp_foreign_domestic_ind_isnull OR ri.corp_foreign_domestic_ind_isnull => 0,
                        le.corp_foreign_domestic_ind = ri.corp_foreign_domestic_ind  => le.corp_foreign_domestic_ind_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_foreign_domestic_ind_weight100,s.corp_foreign_domestic_ind_switch));
  INTEGER2 corp_forgn_state_cd_score := MAP(
                        le.corp_forgn_state_cd_isnull OR ri.corp_forgn_state_cd_isnull => 0,
                        le.corp_forgn_state_cd = ri.corp_forgn_state_cd  => le.corp_forgn_state_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_state_cd_weight100,s.corp_forgn_state_cd_switch));
  INTEGER2 corp_forgn_state_desc_score := MAP(
                        le.corp_forgn_state_desc_isnull OR ri.corp_forgn_state_desc_isnull => 0,
                        le.corp_forgn_state_desc = ri.corp_forgn_state_desc  => le.corp_forgn_state_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_state_desc_weight100,s.corp_forgn_state_desc_switch));
  INTEGER2 corp_forgn_sos_charter_nbr_score := MAP(
                        le.corp_forgn_sos_charter_nbr_isnull OR ri.corp_forgn_sos_charter_nbr_isnull => 0,
                        le.corp_forgn_sos_charter_nbr = ri.corp_forgn_sos_charter_nbr  => le.corp_forgn_sos_charter_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_sos_charter_nbr_weight100,s.corp_forgn_sos_charter_nbr_switch));
  INTEGER2 corp_forgn_date_score := MAP(
                        le.corp_forgn_date_isnull OR ri.corp_forgn_date_isnull => 0,
                        le.corp_forgn_date = ri.corp_forgn_date  => le.corp_forgn_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_date_weight100,s.corp_forgn_date_switch));
  INTEGER2 corp_forgn_fed_tax_id_score := MAP(
                        le.corp_forgn_fed_tax_id_isnull OR ri.corp_forgn_fed_tax_id_isnull => 0,
                        le.corp_forgn_fed_tax_id = ri.corp_forgn_fed_tax_id  => le.corp_forgn_fed_tax_id_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_fed_tax_id_weight100,s.corp_forgn_fed_tax_id_switch));
  INTEGER2 corp_forgn_state_tax_id_score := MAP(
                        le.corp_forgn_state_tax_id_isnull OR ri.corp_forgn_state_tax_id_isnull => 0,
                        le.corp_forgn_state_tax_id = ri.corp_forgn_state_tax_id  => le.corp_forgn_state_tax_id_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_state_tax_id_weight100,s.corp_forgn_state_tax_id_switch));
  INTEGER2 corp_forgn_term_exist_cd_score := MAP(
                        le.corp_forgn_term_exist_cd_isnull OR ri.corp_forgn_term_exist_cd_isnull => 0,
                        le.corp_forgn_term_exist_cd = ri.corp_forgn_term_exist_cd  => le.corp_forgn_term_exist_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_term_exist_cd_weight100,s.corp_forgn_term_exist_cd_switch));
  INTEGER2 corp_forgn_term_exist_exp_score := MAP(
                        le.corp_forgn_term_exist_exp_isnull OR ri.corp_forgn_term_exist_exp_isnull => 0,
                        le.corp_forgn_term_exist_exp = ri.corp_forgn_term_exist_exp  => le.corp_forgn_term_exist_exp_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_term_exist_exp_weight100,s.corp_forgn_term_exist_exp_switch));
  INTEGER2 corp_forgn_term_exist_desc_score := MAP(
                        le.corp_forgn_term_exist_desc_isnull OR ri.corp_forgn_term_exist_desc_isnull => 0,
                        le.corp_forgn_term_exist_desc = ri.corp_forgn_term_exist_desc  => le.corp_forgn_term_exist_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_term_exist_desc_weight100,s.corp_forgn_term_exist_desc_switch));
  INTEGER2 corp_orig_org_structure_cd_score := MAP(
                        le.corp_orig_org_structure_cd_isnull OR ri.corp_orig_org_structure_cd_isnull => 0,
                        le.corp_orig_org_structure_cd = ri.corp_orig_org_structure_cd  => le.corp_orig_org_structure_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_orig_org_structure_cd_weight100,s.corp_orig_org_structure_cd_switch));
  INTEGER2 corp_orig_org_structure_desc_score := MAP(
                        le.corp_orig_org_structure_desc_isnull OR ri.corp_orig_org_structure_desc_isnull => 0,
                        le.corp_orig_org_structure_desc = ri.corp_orig_org_structure_desc  => le.corp_orig_org_structure_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_orig_org_structure_desc_weight100,s.corp_orig_org_structure_desc_switch));
  INTEGER2 corp_for_profit_ind_score := MAP(
                        le.corp_for_profit_ind_isnull OR ri.corp_for_profit_ind_isnull => 0,
                        le.corp_for_profit_ind = ri.corp_for_profit_ind  => le.corp_for_profit_ind_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_for_profit_ind_weight100,s.corp_for_profit_ind_switch));
  INTEGER2 corp_public_or_private_ind_score := MAP(
                        le.corp_public_or_private_ind_isnull OR ri.corp_public_or_private_ind_isnull => 0,
                        le.corp_public_or_private_ind = ri.corp_public_or_private_ind  => le.corp_public_or_private_ind_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_public_or_private_ind_weight100,s.corp_public_or_private_ind_switch));
  INTEGER2 corp_sic_code_score := MAP(
                        le.corp_sic_code_isnull OR ri.corp_sic_code_isnull => 0,
                        le.corp_sic_code = ri.corp_sic_code  => le.corp_sic_code_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_sic_code_weight100,s.corp_sic_code_switch));
  INTEGER2 corp_naic_code_score := MAP(
                        le.corp_naic_code_isnull OR ri.corp_naic_code_isnull => 0,
                        le.corp_naic_code = ri.corp_naic_code  => le.corp_naic_code_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_naic_code_weight100,s.corp_naic_code_switch));
  INTEGER2 corp_orig_bus_type_cd_score := MAP(
                        le.corp_orig_bus_type_cd_isnull OR ri.corp_orig_bus_type_cd_isnull => 0,
                        le.corp_orig_bus_type_cd = ri.corp_orig_bus_type_cd  => le.corp_orig_bus_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_orig_bus_type_cd_weight100,s.corp_orig_bus_type_cd_switch));
  INTEGER2 corp_orig_bus_type_desc_score := MAP(
                        le.corp_orig_bus_type_desc_isnull OR ri.corp_orig_bus_type_desc_isnull => 0,
                        le.corp_orig_bus_type_desc = ri.corp_orig_bus_type_desc  => le.corp_orig_bus_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_orig_bus_type_desc_weight100,s.corp_orig_bus_type_desc_switch));
  INTEGER2 corp_entity_desc_score := MAP(
                        le.corp_entity_desc_isnull OR ri.corp_entity_desc_isnull => 0,
                        le.corp_entity_desc = ri.corp_entity_desc  => le.corp_entity_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_entity_desc_weight100,s.corp_entity_desc_switch));
  INTEGER2 corp_certificate_nbr_score := MAP(
                        le.corp_certificate_nbr_isnull OR ri.corp_certificate_nbr_isnull => 0,
                        le.corp_certificate_nbr = ri.corp_certificate_nbr  => le.corp_certificate_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_certificate_nbr_weight100,s.corp_certificate_nbr_switch));
  INTEGER2 corp_internal_nbr_score := MAP(
                        le.corp_internal_nbr_isnull OR ri.corp_internal_nbr_isnull => 0,
                        le.corp_internal_nbr = ri.corp_internal_nbr  => le.corp_internal_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_internal_nbr_weight100,s.corp_internal_nbr_switch));
  INTEGER2 corp_previous_nbr_score := MAP(
                        le.corp_previous_nbr_isnull OR ri.corp_previous_nbr_isnull => 0,
                        le.corp_previous_nbr = ri.corp_previous_nbr  => le.corp_previous_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_previous_nbr_weight100,s.corp_previous_nbr_switch));
  INTEGER2 corp_microfilm_nbr_score := MAP(
                        le.corp_microfilm_nbr_isnull OR ri.corp_microfilm_nbr_isnull => 0,
                        le.corp_microfilm_nbr = ri.corp_microfilm_nbr  => le.corp_microfilm_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_microfilm_nbr_weight100,s.corp_microfilm_nbr_switch));
  INTEGER2 corp_amendments_filed_score := MAP(
                        le.corp_amendments_filed_isnull OR ri.corp_amendments_filed_isnull => 0,
                        le.corp_amendments_filed = ri.corp_amendments_filed  => le.corp_amendments_filed_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_amendments_filed_weight100,s.corp_amendments_filed_switch));
  INTEGER2 corp_acts_score := MAP(
                        le.corp_acts_isnull OR ri.corp_acts_isnull => 0,
                        le.corp_acts = ri.corp_acts  => le.corp_acts_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_acts_weight100,s.corp_acts_switch));
  INTEGER2 corp_partnership_ind_score := MAP(
                        le.corp_partnership_ind_isnull OR ri.corp_partnership_ind_isnull => 0,
                        le.corp_partnership_ind = ri.corp_partnership_ind  => le.corp_partnership_ind_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_partnership_ind_weight100,s.corp_partnership_ind_switch));
  INTEGER2 corp_mfg_ind_score := MAP(
                        le.corp_mfg_ind_isnull OR ri.corp_mfg_ind_isnull => 0,
                        le.corp_mfg_ind = ri.corp_mfg_ind  => le.corp_mfg_ind_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_mfg_ind_weight100,s.corp_mfg_ind_switch));
  INTEGER2 corp_addl_info_score := MAP(
                        le.corp_addl_info_isnull OR ri.corp_addl_info_isnull => 0,
                        le.corp_addl_info = ri.corp_addl_info  => le.corp_addl_info_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_addl_info_weight100,s.corp_addl_info_switch));
  INTEGER2 corp_taxes_score := MAP(
                        le.corp_taxes_isnull OR ri.corp_taxes_isnull => 0,
                        le.corp_taxes = ri.corp_taxes  => le.corp_taxes_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_taxes_weight100,s.corp_taxes_switch));
  INTEGER2 corp_franchise_taxes_score := MAP(
                        le.corp_franchise_taxes_isnull OR ri.corp_franchise_taxes_isnull => 0,
                        le.corp_franchise_taxes = ri.corp_franchise_taxes  => le.corp_franchise_taxes_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_franchise_taxes_weight100,s.corp_franchise_taxes_switch));
  INTEGER2 corp_tax_program_cd_score := MAP(
                        le.corp_tax_program_cd_isnull OR ri.corp_tax_program_cd_isnull => 0,
                        le.corp_tax_program_cd = ri.corp_tax_program_cd  => le.corp_tax_program_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_tax_program_cd_weight100,s.corp_tax_program_cd_switch));
  INTEGER2 corp_tax_program_desc_score := MAP(
                        le.corp_tax_program_desc_isnull OR ri.corp_tax_program_desc_isnull => 0,
                        le.corp_tax_program_desc = ri.corp_tax_program_desc  => le.corp_tax_program_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_tax_program_desc_weight100,s.corp_tax_program_desc_switch));
  INTEGER2 corp_ra_full_name_score := MAP(
                        le.corp_ra_full_name_isnull OR ri.corp_ra_full_name_isnull => 0,
                        le.corp_ra_full_name = ri.corp_ra_full_name  => le.corp_ra_full_name_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_full_name_weight100,s.corp_ra_full_name_switch));
  INTEGER2 corp_ra_fname_score := MAP(
                        le.corp_ra_fname_isnull OR ri.corp_ra_fname_isnull => 0,
                        le.corp_ra_fname = ri.corp_ra_fname  => le.corp_ra_fname_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_fname_weight100,s.corp_ra_fname_switch));
  INTEGER2 corp_ra_mname_score := MAP(
                        le.corp_ra_mname_isnull OR ri.corp_ra_mname_isnull => 0,
                        le.corp_ra_mname = ri.corp_ra_mname  => le.corp_ra_mname_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_mname_weight100,s.corp_ra_mname_switch));
  INTEGER2 corp_ra_lname_score := MAP(
                        le.corp_ra_lname_isnull OR ri.corp_ra_lname_isnull => 0,
                        le.corp_ra_lname = ri.corp_ra_lname  => le.corp_ra_lname_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_lname_weight100,s.corp_ra_lname_switch));
  INTEGER2 corp_ra_suffix_score := MAP(
                        le.corp_ra_suffix_isnull OR ri.corp_ra_suffix_isnull => 0,
                        le.corp_ra_suffix = ri.corp_ra_suffix  => le.corp_ra_suffix_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_suffix_weight100,s.corp_ra_suffix_switch));
  INTEGER2 corp_ra_title_cd_score := MAP(
                        le.corp_ra_title_cd_isnull OR ri.corp_ra_title_cd_isnull => 0,
                        le.corp_ra_title_cd = ri.corp_ra_title_cd  => le.corp_ra_title_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_title_cd_weight100,s.corp_ra_title_cd_switch));
  INTEGER2 corp_ra_title_desc_score := MAP(
                        le.corp_ra_title_desc_isnull OR ri.corp_ra_title_desc_isnull => 0,
                        le.corp_ra_title_desc = ri.corp_ra_title_desc  => le.corp_ra_title_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_title_desc_weight100,s.corp_ra_title_desc_switch));
  INTEGER2 corp_ra_fein_score := MAP(
                        le.corp_ra_fein_isnull OR ri.corp_ra_fein_isnull => 0,
                        le.corp_ra_fein = ri.corp_ra_fein  => le.corp_ra_fein_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_fein_weight100,s.corp_ra_fein_switch));
  INTEGER2 corp_ra_ssn_score := MAP(
                        le.corp_ra_ssn_isnull OR ri.corp_ra_ssn_isnull => 0,
                        le.corp_ra_ssn = ri.corp_ra_ssn  => le.corp_ra_ssn_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_ssn_weight100,s.corp_ra_ssn_switch));
  INTEGER2 corp_ra_dob_score := MAP(
                        le.corp_ra_dob_isnull OR ri.corp_ra_dob_isnull => 0,
                        le.corp_ra_dob = ri.corp_ra_dob  => le.corp_ra_dob_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_dob_weight100,s.corp_ra_dob_switch));
  INTEGER2 corp_ra_effective_date_score := MAP(
                        le.corp_ra_effective_date_isnull OR ri.corp_ra_effective_date_isnull => 0,
                        le.corp_ra_effective_date = ri.corp_ra_effective_date  => le.corp_ra_effective_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_effective_date_weight100,s.corp_ra_effective_date_switch));
  INTEGER2 corp_ra_resign_date_score := MAP(
                        le.corp_ra_resign_date_isnull OR ri.corp_ra_resign_date_isnull => 0,
                        le.corp_ra_resign_date = ri.corp_ra_resign_date  => le.corp_ra_resign_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_resign_date_weight100,s.corp_ra_resign_date_switch));
  INTEGER2 corp_ra_no_comp_score := MAP(
                        le.corp_ra_no_comp_isnull OR ri.corp_ra_no_comp_isnull => 0,
                        le.corp_ra_no_comp = ri.corp_ra_no_comp  => le.corp_ra_no_comp_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_no_comp_weight100,s.corp_ra_no_comp_switch));
  INTEGER2 corp_ra_no_comp_igs_score := MAP(
                        le.corp_ra_no_comp_igs_isnull OR ri.corp_ra_no_comp_igs_isnull => 0,
                        le.corp_ra_no_comp_igs = ri.corp_ra_no_comp_igs  => le.corp_ra_no_comp_igs_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_no_comp_igs_weight100,s.corp_ra_no_comp_igs_switch));
  INTEGER2 corp_ra_addl_info_score := MAP(
                        le.corp_ra_addl_info_isnull OR ri.corp_ra_addl_info_isnull => 0,
                        le.corp_ra_addl_info = ri.corp_ra_addl_info  => le.corp_ra_addl_info_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_addl_info_weight100,s.corp_ra_addl_info_switch));
  INTEGER2 corp_ra_address_type_cd_score := MAP(
                        le.corp_ra_address_type_cd_isnull OR ri.corp_ra_address_type_cd_isnull => 0,
                        le.corp_ra_address_type_cd = ri.corp_ra_address_type_cd  => le.corp_ra_address_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_address_type_cd_weight100,s.corp_ra_address_type_cd_switch));
  INTEGER2 corp_ra_address_type_desc_score := MAP(
                        le.corp_ra_address_type_desc_isnull OR ri.corp_ra_address_type_desc_isnull => 0,
                        le.corp_ra_address_type_desc = ri.corp_ra_address_type_desc  => le.corp_ra_address_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_address_type_desc_weight100,s.corp_ra_address_type_desc_switch));
  INTEGER2 corp_ra_address_line1_score := MAP(
                        le.corp_ra_address_line1_isnull OR ri.corp_ra_address_line1_isnull => 0,
                        le.corp_ra_address_line1 = ri.corp_ra_address_line1  => le.corp_ra_address_line1_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_address_line1_weight100,s.corp_ra_address_line1_switch));
  INTEGER2 corp_ra_address_line2_score := MAP(
                        le.corp_ra_address_line2_isnull OR ri.corp_ra_address_line2_isnull => 0,
                        le.corp_ra_address_line2 = ri.corp_ra_address_line2  => le.corp_ra_address_line2_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_address_line2_weight100,s.corp_ra_address_line2_switch));
  INTEGER2 corp_ra_address_line3_score := MAP(
                        le.corp_ra_address_line3_isnull OR ri.corp_ra_address_line3_isnull => 0,
                        le.corp_ra_address_line3 = ri.corp_ra_address_line3  => le.corp_ra_address_line3_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_address_line3_weight100,s.corp_ra_address_line3_switch));
  INTEGER2 corp_ra_phone_number_score := MAP(
                        le.corp_ra_phone_number_isnull OR ri.corp_ra_phone_number_isnull => 0,
                        le.corp_ra_phone_number = ri.corp_ra_phone_number  => le.corp_ra_phone_number_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_phone_number_weight100,s.corp_ra_phone_number_switch));
  INTEGER2 corp_ra_phone_number_type_cd_score := MAP(
                        le.corp_ra_phone_number_type_cd_isnull OR ri.corp_ra_phone_number_type_cd_isnull => 0,
                        le.corp_ra_phone_number_type_cd = ri.corp_ra_phone_number_type_cd  => le.corp_ra_phone_number_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_phone_number_type_cd_weight100,s.corp_ra_phone_number_type_cd_switch));
  INTEGER2 corp_ra_phone_number_type_desc_score := MAP(
                        le.corp_ra_phone_number_type_desc_isnull OR ri.corp_ra_phone_number_type_desc_isnull => 0,
                        le.corp_ra_phone_number_type_desc = ri.corp_ra_phone_number_type_desc  => le.corp_ra_phone_number_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_phone_number_type_desc_weight100,s.corp_ra_phone_number_type_desc_switch));
  INTEGER2 corp_ra_fax_nbr_score := MAP(
                        le.corp_ra_fax_nbr_isnull OR ri.corp_ra_fax_nbr_isnull => 0,
                        le.corp_ra_fax_nbr = ri.corp_ra_fax_nbr  => le.corp_ra_fax_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_fax_nbr_weight100,s.corp_ra_fax_nbr_switch));
  INTEGER2 corp_ra_email_address_score := MAP(
                        le.corp_ra_email_address_isnull OR ri.corp_ra_email_address_isnull => 0,
                        le.corp_ra_email_address = ri.corp_ra_email_address  => le.corp_ra_email_address_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_email_address_weight100,s.corp_ra_email_address_switch));
  INTEGER2 corp_ra_web_address_score := MAP(
                        le.corp_ra_web_address_isnull OR ri.corp_ra_web_address_isnull => 0,
                        le.corp_ra_web_address = ri.corp_ra_web_address  => le.corp_ra_web_address_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_web_address_weight100,s.corp_ra_web_address_switch));
  INTEGER2 corp_prep_addr1_line1_score := MAP(
                        le.corp_prep_addr1_line1_isnull OR ri.corp_prep_addr1_line1_isnull => 0,
                        le.corp_prep_addr1_line1 = ri.corp_prep_addr1_line1  => le.corp_prep_addr1_line1_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_prep_addr1_line1_weight100,s.corp_prep_addr1_line1_switch));
  INTEGER2 corp_prep_addr1_last_line_score := MAP(
                        le.corp_prep_addr1_last_line_isnull OR ri.corp_prep_addr1_last_line_isnull => 0,
                        le.corp_prep_addr1_last_line = ri.corp_prep_addr1_last_line  => le.corp_prep_addr1_last_line_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_prep_addr1_last_line_weight100,s.corp_prep_addr1_last_line_switch));
  INTEGER2 corp_prep_addr2_line1_score := MAP(
                        le.corp_prep_addr2_line1_isnull OR ri.corp_prep_addr2_line1_isnull => 0,
                        le.corp_prep_addr2_line1 = ri.corp_prep_addr2_line1  => le.corp_prep_addr2_line1_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_prep_addr2_line1_weight100,s.corp_prep_addr2_line1_switch));
  INTEGER2 corp_prep_addr2_last_line_score := MAP(
                        le.corp_prep_addr2_last_line_isnull OR ri.corp_prep_addr2_last_line_isnull => 0,
                        le.corp_prep_addr2_last_line = ri.corp_prep_addr2_last_line  => le.corp_prep_addr2_last_line_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_prep_addr2_last_line_weight100,s.corp_prep_addr2_last_line_switch));
  INTEGER2 ra_prep_addr_line1_score := MAP(
                        le.ra_prep_addr_line1_isnull OR ri.ra_prep_addr_line1_isnull => 0,
                        le.ra_prep_addr_line1 = ri.ra_prep_addr_line1  => le.ra_prep_addr_line1_weight100,
                        SALT34.Fn_Fail_Scale(le.ra_prep_addr_line1_weight100,s.ra_prep_addr_line1_switch));
  INTEGER2 ra_prep_addr_last_line_score := MAP(
                        le.ra_prep_addr_last_line_isnull OR ri.ra_prep_addr_last_line_isnull => 0,
                        le.ra_prep_addr_last_line = ri.ra_prep_addr_last_line  => le.ra_prep_addr_last_line_weight100,
                        SALT34.Fn_Fail_Scale(le.ra_prep_addr_last_line_weight100,s.ra_prep_addr_last_line_switch));
  INTEGER2 cont_filing_reference_nbr_score := MAP(
                        le.cont_filing_reference_nbr_isnull OR ri.cont_filing_reference_nbr_isnull => 0,
                        le.cont_filing_reference_nbr = ri.cont_filing_reference_nbr  => le.cont_filing_reference_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_filing_reference_nbr_weight100,s.cont_filing_reference_nbr_switch));
  INTEGER2 cont_filing_date_score := MAP(
                        le.cont_filing_date_isnull OR ri.cont_filing_date_isnull => 0,
                        le.cont_filing_date = ri.cont_filing_date  => le.cont_filing_date_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_filing_date_weight100,s.cont_filing_date_switch));
  INTEGER2 cont_filing_cd_score := MAP(
                        le.cont_filing_cd_isnull OR ri.cont_filing_cd_isnull => 0,
                        le.cont_filing_cd = ri.cont_filing_cd  => le.cont_filing_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_filing_cd_weight100,s.cont_filing_cd_switch));
  INTEGER2 cont_filing_desc_score := MAP(
                        le.cont_filing_desc_isnull OR ri.cont_filing_desc_isnull => 0,
                        le.cont_filing_desc = ri.cont_filing_desc  => le.cont_filing_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_filing_desc_weight100,s.cont_filing_desc_switch));
  INTEGER2 cont_type_cd_score := MAP(
                        le.cont_type_cd_isnull OR ri.cont_type_cd_isnull => 0,
                        le.cont_type_cd = ri.cont_type_cd  => le.cont_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_type_cd_weight100,s.cont_type_cd_switch));
  INTEGER2 cont_type_desc_score := MAP(
                        le.cont_type_desc_isnull OR ri.cont_type_desc_isnull => 0,
                        le.cont_type_desc = ri.cont_type_desc  => le.cont_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_type_desc_weight100,s.cont_type_desc_switch));
  INTEGER2 cont_full_name_score := MAP(
                        le.cont_full_name_isnull OR ri.cont_full_name_isnull => 0,
                        le.cont_full_name = ri.cont_full_name  => le.cont_full_name_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_full_name_weight100,s.cont_full_name_switch));
  INTEGER2 cont_fname_score := MAP(
                        le.cont_fname_isnull OR ri.cont_fname_isnull => 0,
                        le.cont_fname = ri.cont_fname  => le.cont_fname_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_fname_weight100,s.cont_fname_switch));
  INTEGER2 cont_mname_score := MAP(
                        le.cont_mname_isnull OR ri.cont_mname_isnull => 0,
                        le.cont_mname = ri.cont_mname  => le.cont_mname_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_mname_weight100,s.cont_mname_switch));
  INTEGER2 cont_lname_score := MAP(
                        le.cont_lname_isnull OR ri.cont_lname_isnull => 0,
                        le.cont_lname = ri.cont_lname  => le.cont_lname_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_lname_weight100,s.cont_lname_switch));
  INTEGER2 cont_suffix_score := MAP(
                        le.cont_suffix_isnull OR ri.cont_suffix_isnull => 0,
                        le.cont_suffix = ri.cont_suffix  => le.cont_suffix_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_suffix_weight100,s.cont_suffix_switch));
  INTEGER2 cont_title1_desc_score := MAP(
                        le.cont_title1_desc_isnull OR ri.cont_title1_desc_isnull => 0,
                        le.cont_title1_desc = ri.cont_title1_desc  => le.cont_title1_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_title1_desc_weight100,s.cont_title1_desc_switch));
  INTEGER2 cont_title2_desc_score := MAP(
                        le.cont_title2_desc_isnull OR ri.cont_title2_desc_isnull => 0,
                        le.cont_title2_desc = ri.cont_title2_desc  => le.cont_title2_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_title2_desc_weight100,s.cont_title2_desc_switch));
  INTEGER2 cont_title3_desc_score := MAP(
                        le.cont_title3_desc_isnull OR ri.cont_title3_desc_isnull => 0,
                        le.cont_title3_desc = ri.cont_title3_desc  => le.cont_title3_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_title3_desc_weight100,s.cont_title3_desc_switch));
  INTEGER2 cont_title4_desc_score := MAP(
                        le.cont_title4_desc_isnull OR ri.cont_title4_desc_isnull => 0,
                        le.cont_title4_desc = ri.cont_title4_desc  => le.cont_title4_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_title4_desc_weight100,s.cont_title4_desc_switch));
  INTEGER2 cont_title5_desc_score := MAP(
                        le.cont_title5_desc_isnull OR ri.cont_title5_desc_isnull => 0,
                        le.cont_title5_desc = ri.cont_title5_desc  => le.cont_title5_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_title5_desc_weight100,s.cont_title5_desc_switch));
  INTEGER2 cont_fein_score := MAP(
                        le.cont_fein_isnull OR ri.cont_fein_isnull => 0,
                        le.cont_fein = ri.cont_fein  => le.cont_fein_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_fein_weight100,s.cont_fein_switch));
  INTEGER2 cont_ssn_score := MAP(
                        le.cont_ssn_isnull OR ri.cont_ssn_isnull => 0,
                        le.cont_ssn = ri.cont_ssn  => le.cont_ssn_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_ssn_weight100,s.cont_ssn_switch));
  INTEGER2 cont_dob_score := MAP(
                        le.cont_dob_isnull OR ri.cont_dob_isnull => 0,
                        le.cont_dob = ri.cont_dob  => le.cont_dob_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_dob_weight100,s.cont_dob_switch));
  INTEGER2 cont_status_cd_score := MAP(
                        le.cont_status_cd_isnull OR ri.cont_status_cd_isnull => 0,
                        le.cont_status_cd = ri.cont_status_cd  => le.cont_status_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_status_cd_weight100,s.cont_status_cd_switch));
  INTEGER2 cont_status_desc_score := MAP(
                        le.cont_status_desc_isnull OR ri.cont_status_desc_isnull => 0,
                        le.cont_status_desc = ri.cont_status_desc  => le.cont_status_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_status_desc_weight100,s.cont_status_desc_switch));
  INTEGER2 cont_effective_date_score := MAP(
                        le.cont_effective_date_isnull OR ri.cont_effective_date_isnull => 0,
                        le.cont_effective_date = ri.cont_effective_date  => le.cont_effective_date_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_effective_date_weight100,s.cont_effective_date_switch));
  INTEGER2 cont_effective_cd_score := MAP(
                        le.cont_effective_cd_isnull OR ri.cont_effective_cd_isnull => 0,
                        le.cont_effective_cd = ri.cont_effective_cd  => le.cont_effective_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_effective_cd_weight100,s.cont_effective_cd_switch));
  INTEGER2 cont_effective_desc_score := MAP(
                        le.cont_effective_desc_isnull OR ri.cont_effective_desc_isnull => 0,
                        le.cont_effective_desc = ri.cont_effective_desc  => le.cont_effective_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_effective_desc_weight100,s.cont_effective_desc_switch));
  INTEGER2 cont_addl_info_score := MAP(
                        le.cont_addl_info_isnull OR ri.cont_addl_info_isnull => 0,
                        le.cont_addl_info = ri.cont_addl_info  => le.cont_addl_info_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_addl_info_weight100,s.cont_addl_info_switch));
  INTEGER2 cont_address_type_cd_score := MAP(
                        le.cont_address_type_cd_isnull OR ri.cont_address_type_cd_isnull => 0,
                        le.cont_address_type_cd = ri.cont_address_type_cd  => le.cont_address_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_address_type_cd_weight100,s.cont_address_type_cd_switch));
  INTEGER2 cont_address_type_desc_score := MAP(
                        le.cont_address_type_desc_isnull OR ri.cont_address_type_desc_isnull => 0,
                        le.cont_address_type_desc = ri.cont_address_type_desc  => le.cont_address_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_address_type_desc_weight100,s.cont_address_type_desc_switch));
  INTEGER2 cont_address_line1_score := MAP(
                        le.cont_address_line1_isnull OR ri.cont_address_line1_isnull => 0,
                        le.cont_address_line1 = ri.cont_address_line1  => le.cont_address_line1_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_address_line1_weight100,s.cont_address_line1_switch));
  INTEGER2 cont_address_line2_score := MAP(
                        le.cont_address_line2_isnull OR ri.cont_address_line2_isnull => 0,
                        le.cont_address_line2 = ri.cont_address_line2  => le.cont_address_line2_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_address_line2_weight100,s.cont_address_line2_switch));
  INTEGER2 cont_address_line3_score := MAP(
                        le.cont_address_line3_isnull OR ri.cont_address_line3_isnull => 0,
                        le.cont_address_line3 = ri.cont_address_line3  => le.cont_address_line3_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_address_line3_weight100,s.cont_address_line3_switch));
  INTEGER2 cont_address_effective_date_score := MAP(
                        le.cont_address_effective_date_isnull OR ri.cont_address_effective_date_isnull => 0,
                        le.cont_address_effective_date = ri.cont_address_effective_date  => le.cont_address_effective_date_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_address_effective_date_weight100,s.cont_address_effective_date_switch));
  INTEGER2 cont_address_county_score := MAP(
                        le.cont_address_county_isnull OR ri.cont_address_county_isnull => 0,
                        le.cont_address_county = ri.cont_address_county  => le.cont_address_county_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_address_county_weight100,s.cont_address_county_switch));
  INTEGER2 cont_phone_number_score := MAP(
                        le.cont_phone_number_isnull OR ri.cont_phone_number_isnull => 0,
                        le.cont_phone_number = ri.cont_phone_number  => le.cont_phone_number_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_phone_number_weight100,s.cont_phone_number_switch));
  INTEGER2 cont_phone_number_type_cd_score := MAP(
                        le.cont_phone_number_type_cd_isnull OR ri.cont_phone_number_type_cd_isnull => 0,
                        le.cont_phone_number_type_cd = ri.cont_phone_number_type_cd  => le.cont_phone_number_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_phone_number_type_cd_weight100,s.cont_phone_number_type_cd_switch));
  INTEGER2 cont_phone_number_type_desc_score := MAP(
                        le.cont_phone_number_type_desc_isnull OR ri.cont_phone_number_type_desc_isnull => 0,
                        le.cont_phone_number_type_desc = ri.cont_phone_number_type_desc  => le.cont_phone_number_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_phone_number_type_desc_weight100,s.cont_phone_number_type_desc_switch));
  INTEGER2 cont_fax_nbr_score := MAP(
                        le.cont_fax_nbr_isnull OR ri.cont_fax_nbr_isnull => 0,
                        le.cont_fax_nbr = ri.cont_fax_nbr  => le.cont_fax_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_fax_nbr_weight100,s.cont_fax_nbr_switch));
  INTEGER2 cont_email_address_score := MAP(
                        le.cont_email_address_isnull OR ri.cont_email_address_isnull => 0,
                        le.cont_email_address = ri.cont_email_address  => le.cont_email_address_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_email_address_weight100,s.cont_email_address_switch));
  INTEGER2 cont_web_address_score := MAP(
                        le.cont_web_address_isnull OR ri.cont_web_address_isnull => 0,
                        le.cont_web_address = ri.cont_web_address  => le.cont_web_address_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_web_address_weight100,s.cont_web_address_switch));
  INTEGER2 corp_acres_score := MAP(
                        le.corp_acres_isnull OR ri.corp_acres_isnull => 0,
                        le.corp_acres = ri.corp_acres  => le.corp_acres_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_acres_weight100,s.corp_acres_switch));
  INTEGER2 corp_action_score := MAP(
                        le.corp_action_isnull OR ri.corp_action_isnull => 0,
                        le.corp_action = ri.corp_action  => le.corp_action_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_action_weight100,s.corp_action_switch));
  INTEGER2 corp_action_date_score := MAP(
                        le.corp_action_date_isnull OR ri.corp_action_date_isnull => 0,
                        le.corp_action_date = ri.corp_action_date  => le.corp_action_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_action_date_weight100,s.corp_action_date_switch));
  INTEGER2 corp_action_employment_security_approval_date_score := MAP(
                        le.corp_action_employment_security_approval_date_isnull OR ri.corp_action_employment_security_approval_date_isnull => 0,
                        le.corp_action_employment_security_approval_date = ri.corp_action_employment_security_approval_date  => le.corp_action_employment_security_approval_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_action_employment_security_approval_date_weight100,s.corp_action_employment_security_approval_date_switch));
  INTEGER2 corp_action_pending_cd_score := MAP(
                        le.corp_action_pending_cd_isnull OR ri.corp_action_pending_cd_isnull => 0,
                        le.corp_action_pending_cd = ri.corp_action_pending_cd  => le.corp_action_pending_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_action_pending_cd_weight100,s.corp_action_pending_cd_switch));
  INTEGER2 corp_action_pending_desc_score := MAP(
                        le.corp_action_pending_desc_isnull OR ri.corp_action_pending_desc_isnull => 0,
                        le.corp_action_pending_desc = ri.corp_action_pending_desc  => le.corp_action_pending_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_action_pending_desc_weight100,s.corp_action_pending_desc_switch));
  INTEGER2 corp_action_statement_of_intent_date_score := MAP(
                        le.corp_action_statement_of_intent_date_isnull OR ri.corp_action_statement_of_intent_date_isnull => 0,
                        le.corp_action_statement_of_intent_date = ri.corp_action_statement_of_intent_date  => le.corp_action_statement_of_intent_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_action_statement_of_intent_date_weight100,s.corp_action_statement_of_intent_date_switch));
  INTEGER2 corp_action_tax_dept_approval_date_score := MAP(
                        le.corp_action_tax_dept_approval_date_isnull OR ri.corp_action_tax_dept_approval_date_isnull => 0,
                        le.corp_action_tax_dept_approval_date = ri.corp_action_tax_dept_approval_date  => le.corp_action_tax_dept_approval_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_action_tax_dept_approval_date_weight100,s.corp_action_tax_dept_approval_date_switch));
  INTEGER2 corp_acts2_score := MAP(
                        le.corp_acts2_isnull OR ri.corp_acts2_isnull => 0,
                        le.corp_acts2 = ri.corp_acts2  => le.corp_acts2_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_acts2_weight100,s.corp_acts2_switch));
  INTEGER2 corp_acts3_score := MAP(
                        le.corp_acts3_isnull OR ri.corp_acts3_isnull => 0,
                        le.corp_acts3 = ri.corp_acts3  => le.corp_acts3_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_acts3_weight100,s.corp_acts3_switch));
  INTEGER2 corp_additional_principals_score := MAP(
                        le.corp_additional_principals_isnull OR ri.corp_additional_principals_isnull => 0,
                        le.corp_additional_principals = ri.corp_additional_principals  => le.corp_additional_principals_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_additional_principals_weight100,s.corp_additional_principals_switch));
  INTEGER2 corp_address_office_type_score := MAP(
                        le.corp_address_office_type_isnull OR ri.corp_address_office_type_isnull => 0,
                        le.corp_address_office_type = ri.corp_address_office_type  => le.corp_address_office_type_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address_office_type_weight100,s.corp_address_office_type_switch));
  INTEGER2 corp_agent_assign_date_score := MAP(
                        le.corp_agent_assign_date_isnull OR ri.corp_agent_assign_date_isnull => 0,
                        le.corp_agent_assign_date = ri.corp_agent_assign_date  => le.corp_agent_assign_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_agent_assign_date_weight100,s.corp_agent_assign_date_switch));
  INTEGER2 corp_agent_commercial_score := MAP(
                        le.corp_agent_commercial_isnull OR ri.corp_agent_commercial_isnull => 0,
                        le.corp_agent_commercial = ri.corp_agent_commercial  => le.corp_agent_commercial_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_agent_commercial_weight100,s.corp_agent_commercial_switch));
  INTEGER2 corp_agent_country_score := MAP(
                        le.corp_agent_country_isnull OR ri.corp_agent_country_isnull => 0,
                        le.corp_agent_country = ri.corp_agent_country  => le.corp_agent_country_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_agent_country_weight100,s.corp_agent_country_switch));
  INTEGER2 corp_agent_county_score := MAP(
                        le.corp_agent_county_isnull OR ri.corp_agent_county_isnull => 0,
                        le.corp_agent_county = ri.corp_agent_county  => le.corp_agent_county_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_agent_county_weight100,s.corp_agent_county_switch));
  INTEGER2 corp_agent_status_cd_score := MAP(
                        le.corp_agent_status_cd_isnull OR ri.corp_agent_status_cd_isnull => 0,
                        le.corp_agent_status_cd = ri.corp_agent_status_cd  => le.corp_agent_status_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_agent_status_cd_weight100,s.corp_agent_status_cd_switch));
  INTEGER2 corp_agent_status_desc_score := MAP(
                        le.corp_agent_status_desc_isnull OR ri.corp_agent_status_desc_isnull => 0,
                        le.corp_agent_status_desc = ri.corp_agent_status_desc  => le.corp_agent_status_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_agent_status_desc_weight100,s.corp_agent_status_desc_switch));
  INTEGER2 corp_agent_id_score := MAP(
                        le.corp_agent_id_isnull OR ri.corp_agent_id_isnull => 0,
                        le.corp_agent_id = ri.corp_agent_id  => le.corp_agent_id_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_agent_id_weight100,s.corp_agent_id_switch));
  INTEGER2 corp_agriculture_flag_score := MAP(
                        le.corp_agriculture_flag_isnull OR ri.corp_agriculture_flag_isnull => 0,
                        le.corp_agriculture_flag = ri.corp_agriculture_flag  => le.corp_agriculture_flag_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_agriculture_flag_weight100,s.corp_agriculture_flag_switch));
  INTEGER2 corp_authorized_partners_score := MAP(
                        le.corp_authorized_partners_isnull OR ri.corp_authorized_partners_isnull => 0,
                        le.corp_authorized_partners = ri.corp_authorized_partners  => le.corp_authorized_partners_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_authorized_partners_weight100,s.corp_authorized_partners_switch));
  INTEGER2 corp_comment_score := MAP(
                        le.corp_comment_isnull OR ri.corp_comment_isnull => 0,
                        le.corp_comment = ri.corp_comment  => le.corp_comment_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_comment_weight100,s.corp_comment_switch));
  INTEGER2 corp_consent_flag_for_protected_name_score := MAP(
                        le.corp_consent_flag_for_protected_name_isnull OR ri.corp_consent_flag_for_protected_name_isnull => 0,
                        le.corp_consent_flag_for_protected_name = ri.corp_consent_flag_for_protected_name  => le.corp_consent_flag_for_protected_name_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_consent_flag_for_protected_name_weight100,s.corp_consent_flag_for_protected_name_switch));
  INTEGER2 corp_converted_score := MAP(
                        le.corp_converted_isnull OR ri.corp_converted_isnull => 0,
                        le.corp_converted = ri.corp_converted  => le.corp_converted_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_converted_weight100,s.corp_converted_switch));
  INTEGER2 corp_converted_from_score := MAP(
                        le.corp_converted_from_isnull OR ri.corp_converted_from_isnull => 0,
                        le.corp_converted_from = ri.corp_converted_from  => le.corp_converted_from_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_converted_from_weight100,s.corp_converted_from_switch));
  INTEGER2 corp_country_of_formation_score := MAP(
                        le.corp_country_of_formation_isnull OR ri.corp_country_of_formation_isnull => 0,
                        le.corp_country_of_formation = ri.corp_country_of_formation  => le.corp_country_of_formation_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_country_of_formation_weight100,s.corp_country_of_formation_switch));
  INTEGER2 corp_date_of_organization_meeting_score := MAP(
                        le.corp_date_of_organization_meeting_isnull OR ri.corp_date_of_organization_meeting_isnull => 0,
                        le.corp_date_of_organization_meeting = ri.corp_date_of_organization_meeting  => le.corp_date_of_organization_meeting_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_date_of_organization_meeting_weight100,s.corp_date_of_organization_meeting_switch));
  INTEGER2 corp_delayed_effective_date_score := MAP(
                        le.corp_delayed_effective_date_isnull OR ri.corp_delayed_effective_date_isnull => 0,
                        le.corp_delayed_effective_date = ri.corp_delayed_effective_date  => le.corp_delayed_effective_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_delayed_effective_date_weight100,s.corp_delayed_effective_date_switch));
  INTEGER2 corp_directors_from_to_score := MAP(
                        le.corp_directors_from_to_isnull OR ri.corp_directors_from_to_isnull => 0,
                        le.corp_directors_from_to = ri.corp_directors_from_to  => le.corp_directors_from_to_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_directors_from_to_weight100,s.corp_directors_from_to_switch));
  INTEGER2 corp_dissolved_date_score := MAP(
                        le.corp_dissolved_date_isnull OR ri.corp_dissolved_date_isnull => 0,
                        le.corp_dissolved_date = ri.corp_dissolved_date  => le.corp_dissolved_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_dissolved_date_weight100,s.corp_dissolved_date_switch));
  INTEGER2 corp_farm_exemptions_score := MAP(
                        le.corp_farm_exemptions_isnull OR ri.corp_farm_exemptions_isnull => 0,
                        le.corp_farm_exemptions = ri.corp_farm_exemptions  => le.corp_farm_exemptions_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_farm_exemptions_weight100,s.corp_farm_exemptions_switch));
  INTEGER2 corp_farm_qual_date_score := MAP(
                        le.corp_farm_qual_date_isnull OR ri.corp_farm_qual_date_isnull => 0,
                        le.corp_farm_qual_date = ri.corp_farm_qual_date  => le.corp_farm_qual_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_farm_qual_date_weight100,s.corp_farm_qual_date_switch));
  INTEGER2 corp_farm_status_cd_score := MAP(
                        le.corp_farm_status_cd_isnull OR ri.corp_farm_status_cd_isnull => 0,
                        le.corp_farm_status_cd = ri.corp_farm_status_cd  => le.corp_farm_status_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_farm_status_cd_weight100,s.corp_farm_status_cd_switch));
  INTEGER2 corp_farm_status_desc_score := MAP(
                        le.corp_farm_status_desc_isnull OR ri.corp_farm_status_desc_isnull => 0,
                        le.corp_farm_status_desc = ri.corp_farm_status_desc  => le.corp_farm_status_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_farm_status_desc_weight100,s.corp_farm_status_desc_switch));
  INTEGER2 corp_fiscal_year_month_score := MAP(
                        le.corp_fiscal_year_month_isnull OR ri.corp_fiscal_year_month_isnull => 0,
                        le.corp_fiscal_year_month = ri.corp_fiscal_year_month  => le.corp_fiscal_year_month_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_fiscal_year_month_weight100,s.corp_fiscal_year_month_switch));
  INTEGER2 corp_foreign_fiduciary_capacity_in_state_score := MAP(
                        le.corp_foreign_fiduciary_capacity_in_state_isnull OR ri.corp_foreign_fiduciary_capacity_in_state_isnull => 0,
                        le.corp_foreign_fiduciary_capacity_in_state = ri.corp_foreign_fiduciary_capacity_in_state  => le.corp_foreign_fiduciary_capacity_in_state_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_foreign_fiduciary_capacity_in_state_weight100,s.corp_foreign_fiduciary_capacity_in_state_switch));
  INTEGER2 corp_governing_statute_score := MAP(
                        le.corp_governing_statute_isnull OR ri.corp_governing_statute_isnull => 0,
                        le.corp_governing_statute = ri.corp_governing_statute  => le.corp_governing_statute_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_governing_statute_weight100,s.corp_governing_statute_switch));
  INTEGER2 corp_has_members_score := MAP(
                        le.corp_has_members_isnull OR ri.corp_has_members_isnull => 0,
                        le.corp_has_members = ri.corp_has_members  => le.corp_has_members_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_has_members_weight100,s.corp_has_members_switch));
  INTEGER2 corp_has_vested_managers_score := MAP(
                        le.corp_has_vested_managers_isnull OR ri.corp_has_vested_managers_isnull => 0,
                        le.corp_has_vested_managers = ri.corp_has_vested_managers  => le.corp_has_vested_managers_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_has_vested_managers_weight100,s.corp_has_vested_managers_switch));
  INTEGER2 corp_home_incorporated_county_score := MAP(
                        le.corp_home_incorporated_county_isnull OR ri.corp_home_incorporated_county_isnull => 0,
                        le.corp_home_incorporated_county = ri.corp_home_incorporated_county  => le.corp_home_incorporated_county_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_home_incorporated_county_weight100,s.corp_home_incorporated_county_switch));
  INTEGER2 corp_home_state_name_score := MAP(
                        le.corp_home_state_name_isnull OR ri.corp_home_state_name_isnull => 0,
                        le.corp_home_state_name = ri.corp_home_state_name  => le.corp_home_state_name_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_home_state_name_weight100,s.corp_home_state_name_switch));
  INTEGER2 corp_is_professional_score := MAP(
                        le.corp_is_professional_isnull OR ri.corp_is_professional_isnull => 0,
                        le.corp_is_professional = ri.corp_is_professional  => le.corp_is_professional_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_is_professional_weight100,s.corp_is_professional_switch));
  INTEGER2 corp_is_non_profit_irs_approved_score := MAP(
                        le.corp_is_non_profit_irs_approved_isnull OR ri.corp_is_non_profit_irs_approved_isnull => 0,
                        le.corp_is_non_profit_irs_approved = ri.corp_is_non_profit_irs_approved  => le.corp_is_non_profit_irs_approved_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_is_non_profit_irs_approved_weight100,s.corp_is_non_profit_irs_approved_switch));
  INTEGER2 corp_last_renewal_date_score := MAP(
                        le.corp_last_renewal_date_isnull OR ri.corp_last_renewal_date_isnull => 0,
                        le.corp_last_renewal_date = ri.corp_last_renewal_date  => le.corp_last_renewal_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_last_renewal_date_weight100,s.corp_last_renewal_date_switch));
  INTEGER2 corp_last_renewal_year_score := MAP(
                        le.corp_last_renewal_year_isnull OR ri.corp_last_renewal_year_isnull => 0,
                        le.corp_last_renewal_year = ri.corp_last_renewal_year  => le.corp_last_renewal_year_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_last_renewal_year_weight100,s.corp_last_renewal_year_switch));
  INTEGER2 corp_license_type_score := MAP(
                        le.corp_license_type_isnull OR ri.corp_license_type_isnull => 0,
                        le.corp_license_type = ri.corp_license_type  => le.corp_license_type_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_license_type_weight100,s.corp_license_type_switch));
  INTEGER2 corp_llc_managed_desc_score := MAP(
                        le.corp_llc_managed_desc_isnull OR ri.corp_llc_managed_desc_isnull => 0,
                        le.corp_llc_managed_desc = ri.corp_llc_managed_desc  => le.corp_llc_managed_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_llc_managed_desc_weight100,s.corp_llc_managed_desc_switch));
  INTEGER2 corp_llc_managed_ind_score := MAP(
                        le.corp_llc_managed_ind_isnull OR ri.corp_llc_managed_ind_isnull => 0,
                        le.corp_llc_managed_ind = ri.corp_llc_managed_ind  => le.corp_llc_managed_ind_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_llc_managed_ind_weight100,s.corp_llc_managed_ind_switch));
  INTEGER2 corp_management_desc_score := MAP(
                        le.corp_management_desc_isnull OR ri.corp_management_desc_isnull => 0,
                        le.corp_management_desc = ri.corp_management_desc  => le.corp_management_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_management_desc_weight100,s.corp_management_desc_switch));
  INTEGER2 corp_management_type_score := MAP(
                        le.corp_management_type_isnull OR ri.corp_management_type_isnull => 0,
                        le.corp_management_type = ri.corp_management_type  => le.corp_management_type_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_management_type_weight100,s.corp_management_type_switch));
  INTEGER2 corp_manager_managed_score := MAP(
                        le.corp_manager_managed_isnull OR ri.corp_manager_managed_isnull => 0,
                        le.corp_manager_managed = ri.corp_manager_managed  => le.corp_manager_managed_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_manager_managed_weight100,s.corp_manager_managed_switch));
  INTEGER2 corp_merged_corporation_id_score := MAP(
                        le.corp_merged_corporation_id_isnull OR ri.corp_merged_corporation_id_isnull => 0,
                        le.corp_merged_corporation_id = ri.corp_merged_corporation_id  => le.corp_merged_corporation_id_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merged_corporation_id_weight100,s.corp_merged_corporation_id_switch));
  INTEGER2 corp_merged_fein_score := MAP(
                        le.corp_merged_fein_isnull OR ri.corp_merged_fein_isnull => 0,
                        le.corp_merged_fein = ri.corp_merged_fein  => le.corp_merged_fein_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merged_fein_weight100,s.corp_merged_fein_switch));
  INTEGER2 corp_merger_allowed_flag_score := MAP(
                        le.corp_merger_allowed_flag_isnull OR ri.corp_merger_allowed_flag_isnull => 0,
                        le.corp_merger_allowed_flag = ri.corp_merger_allowed_flag  => le.corp_merger_allowed_flag_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_allowed_flag_weight100,s.corp_merger_allowed_flag_switch));
  INTEGER2 corp_merger_date_score := MAP(
                        le.corp_merger_date_isnull OR ri.corp_merger_date_isnull => 0,
                        le.corp_merger_date = ri.corp_merger_date  => le.corp_merger_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_date_weight100,s.corp_merger_date_switch));
  INTEGER2 corp_merger_desc_score := MAP(
                        le.corp_merger_desc_isnull OR ri.corp_merger_desc_isnull => 0,
                        le.corp_merger_desc = ri.corp_merger_desc  => le.corp_merger_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_desc_weight100,s.corp_merger_desc_switch));
  INTEGER2 corp_merger_effective_date_score := MAP(
                        le.corp_merger_effective_date_isnull OR ri.corp_merger_effective_date_isnull => 0,
                        le.corp_merger_effective_date = ri.corp_merger_effective_date  => le.corp_merger_effective_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_effective_date_weight100,s.corp_merger_effective_date_switch));
  INTEGER2 corp_merger_id_score := MAP(
                        le.corp_merger_id_isnull OR ri.corp_merger_id_isnull => 0,
                        le.corp_merger_id = ri.corp_merger_id  => le.corp_merger_id_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_id_weight100,s.corp_merger_id_switch));
  INTEGER2 corp_merger_indicator_score := MAP(
                        le.corp_merger_indicator_isnull OR ri.corp_merger_indicator_isnull => 0,
                        le.corp_merger_indicator = ri.corp_merger_indicator  => le.corp_merger_indicator_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_indicator_weight100,s.corp_merger_indicator_switch));
  INTEGER2 corp_merger_name_score := MAP(
                        le.corp_merger_name_isnull OR ri.corp_merger_name_isnull => 0,
                        le.corp_merger_name = ri.corp_merger_name  => le.corp_merger_name_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_name_weight100,s.corp_merger_name_switch));
  INTEGER2 corp_merger_type_converted_to_cd_score := MAP(
                        le.corp_merger_type_converted_to_cd_isnull OR ri.corp_merger_type_converted_to_cd_isnull => 0,
                        le.corp_merger_type_converted_to_cd = ri.corp_merger_type_converted_to_cd  => le.corp_merger_type_converted_to_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_type_converted_to_cd_weight100,s.corp_merger_type_converted_to_cd_switch));
  INTEGER2 corp_merger_type_converted_to_desc_score := MAP(
                        le.corp_merger_type_converted_to_desc_isnull OR ri.corp_merger_type_converted_to_desc_isnull => 0,
                        le.corp_merger_type_converted_to_desc = ri.corp_merger_type_converted_to_desc  => le.corp_merger_type_converted_to_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_type_converted_to_desc_weight100,s.corp_merger_type_converted_to_desc_switch));
  INTEGER2 corp_naics_desc_score := MAP(
                        le.corp_naics_desc_isnull OR ri.corp_naics_desc_isnull => 0,
                        le.corp_naics_desc = ri.corp_naics_desc  => le.corp_naics_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_naics_desc_weight100,s.corp_naics_desc_switch));
  INTEGER2 corp_name_effective_date_score := MAP(
                        le.corp_name_effective_date_isnull OR ri.corp_name_effective_date_isnull => 0,
                        le.corp_name_effective_date = ri.corp_name_effective_date  => le.corp_name_effective_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_effective_date_weight100,s.corp_name_effective_date_switch));
  INTEGER2 corp_name_reservation_date_score := MAP(
                        le.corp_name_reservation_date_isnull OR ri.corp_name_reservation_date_isnull => 0,
                        le.corp_name_reservation_date = ri.corp_name_reservation_date  => le.corp_name_reservation_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_reservation_date_weight100,s.corp_name_reservation_date_switch));
  INTEGER2 corp_name_reservation_desc_score := MAP(
                        le.corp_name_reservation_desc_isnull OR ri.corp_name_reservation_desc_isnull => 0,
                        le.corp_name_reservation_desc = ri.corp_name_reservation_desc  => le.corp_name_reservation_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_reservation_desc_weight100,s.corp_name_reservation_desc_switch));
  INTEGER2 corp_name_reservation_expiration_date_score := MAP(
                        le.corp_name_reservation_expiration_date_isnull OR ri.corp_name_reservation_expiration_date_isnull => 0,
                        le.corp_name_reservation_expiration_date = ri.corp_name_reservation_expiration_date  => le.corp_name_reservation_expiration_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_reservation_expiration_date_weight100,s.corp_name_reservation_expiration_date_switch));
  INTEGER2 corp_name_reservation_nbr_score := MAP(
                        le.corp_name_reservation_nbr_isnull OR ri.corp_name_reservation_nbr_isnull => 0,
                        le.corp_name_reservation_nbr = ri.corp_name_reservation_nbr  => le.corp_name_reservation_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_reservation_nbr_weight100,s.corp_name_reservation_nbr_switch));
  INTEGER2 corp_name_reservation_type_score := MAP(
                        le.corp_name_reservation_type_isnull OR ri.corp_name_reservation_type_isnull => 0,
                        le.corp_name_reservation_type = ri.corp_name_reservation_type  => le.corp_name_reservation_type_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_reservation_type_weight100,s.corp_name_reservation_type_switch));
  INTEGER2 corp_name_status_cd_score := MAP(
                        le.corp_name_status_cd_isnull OR ri.corp_name_status_cd_isnull => 0,
                        le.corp_name_status_cd = ri.corp_name_status_cd  => le.corp_name_status_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_status_cd_weight100,s.corp_name_status_cd_switch));
  INTEGER2 corp_name_status_date_score := MAP(
                        le.corp_name_status_date_isnull OR ri.corp_name_status_date_isnull => 0,
                        le.corp_name_status_date = ri.corp_name_status_date  => le.corp_name_status_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_status_date_weight100,s.corp_name_status_date_switch));
  INTEGER2 corp_name_status_desc_score := MAP(
                        le.corp_name_status_desc_isnull OR ri.corp_name_status_desc_isnull => 0,
                        le.corp_name_status_desc = ri.corp_name_status_desc  => le.corp_name_status_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_status_desc_weight100,s.corp_name_status_desc_switch));
  INTEGER2 corp_non_profit_irs_approved_purpose_score := MAP(
                        le.corp_non_profit_irs_approved_purpose_isnull OR ri.corp_non_profit_irs_approved_purpose_isnull => 0,
                        le.corp_non_profit_irs_approved_purpose = ri.corp_non_profit_irs_approved_purpose  => le.corp_non_profit_irs_approved_purpose_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_non_profit_irs_approved_purpose_weight100,s.corp_non_profit_irs_approved_purpose_switch));
  INTEGER2 corp_non_profit_solicit_donations_score := MAP(
                        le.corp_non_profit_solicit_donations_isnull OR ri.corp_non_profit_solicit_donations_isnull => 0,
                        le.corp_non_profit_solicit_donations = ri.corp_non_profit_solicit_donations  => le.corp_non_profit_solicit_donations_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_non_profit_solicit_donations_weight100,s.corp_non_profit_solicit_donations_switch));
  INTEGER2 corp_nbr_of_amendments_score := MAP(
                        le.corp_nbr_of_amendments_isnull OR ri.corp_nbr_of_amendments_isnull => 0,
                        le.corp_nbr_of_amendments = ri.corp_nbr_of_amendments  => le.corp_nbr_of_amendments_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_nbr_of_amendments_weight100,s.corp_nbr_of_amendments_switch));
  INTEGER2 corp_nbr_of_initial_llc_members_score := MAP(
                        le.corp_nbr_of_initial_llc_members_isnull OR ri.corp_nbr_of_initial_llc_members_isnull => 0,
                        le.corp_nbr_of_initial_llc_members = ri.corp_nbr_of_initial_llc_members  => le.corp_nbr_of_initial_llc_members_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_nbr_of_initial_llc_members_weight100,s.corp_nbr_of_initial_llc_members_switch));
  INTEGER2 corp_nbr_of_partners_score := MAP(
                        le.corp_nbr_of_partners_isnull OR ri.corp_nbr_of_partners_isnull => 0,
                        le.corp_nbr_of_partners = ri.corp_nbr_of_partners  => le.corp_nbr_of_partners_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_nbr_of_partners_weight100,s.corp_nbr_of_partners_switch));
  INTEGER2 corp_operating_agreement_score := MAP(
                        le.corp_operating_agreement_isnull OR ri.corp_operating_agreement_isnull => 0,
                        le.corp_operating_agreement = ri.corp_operating_agreement  => le.corp_operating_agreement_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_operating_agreement_weight100,s.corp_operating_agreement_switch));
  INTEGER2 corp_opt_in_llc_act_desc_score := MAP(
                        le.corp_opt_in_llc_act_desc_isnull OR ri.corp_opt_in_llc_act_desc_isnull => 0,
                        le.corp_opt_in_llc_act_desc = ri.corp_opt_in_llc_act_desc  => le.corp_opt_in_llc_act_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_opt_in_llc_act_desc_weight100,s.corp_opt_in_llc_act_desc_switch));
  INTEGER2 corp_opt_in_llc_act_ind_score := MAP(
                        le.corp_opt_in_llc_act_ind_isnull OR ri.corp_opt_in_llc_act_ind_isnull => 0,
                        le.corp_opt_in_llc_act_ind = ri.corp_opt_in_llc_act_ind  => le.corp_opt_in_llc_act_ind_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_opt_in_llc_act_ind_weight100,s.corp_opt_in_llc_act_ind_switch));
  INTEGER2 corp_organizational_comments_score := MAP(
                        le.corp_organizational_comments_isnull OR ri.corp_organizational_comments_isnull => 0,
                        le.corp_organizational_comments = ri.corp_organizational_comments  => le.corp_organizational_comments_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_organizational_comments_weight100,s.corp_organizational_comments_switch));
  INTEGER2 corp_partner_contributions_total_score := MAP(
                        le.corp_partner_contributions_total_isnull OR ri.corp_partner_contributions_total_isnull => 0,
                        le.corp_partner_contributions_total = ri.corp_partner_contributions_total  => le.corp_partner_contributions_total_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_partner_contributions_total_weight100,s.corp_partner_contributions_total_switch));
  INTEGER2 corp_partner_terms_score := MAP(
                        le.corp_partner_terms_isnull OR ri.corp_partner_terms_isnull => 0,
                        le.corp_partner_terms = ri.corp_partner_terms  => le.corp_partner_terms_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_partner_terms_weight100,s.corp_partner_terms_switch));
  INTEGER2 corp_percentage_voters_required_to_approve_amendments_score := MAP(
                        le.corp_percentage_voters_required_to_approve_amendments_isnull OR ri.corp_percentage_voters_required_to_approve_amendments_isnull => 0,
                        le.corp_percentage_voters_required_to_approve_amendments = ri.corp_percentage_voters_required_to_approve_amendments  => le.corp_percentage_voters_required_to_approve_amendments_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_percentage_voters_required_to_approve_amendments_weight100,s.corp_percentage_voters_required_to_approve_amendments_switch));
  INTEGER2 corp_profession_score := MAP(
                        le.corp_profession_isnull OR ri.corp_profession_isnull => 0,
                        le.corp_profession = ri.corp_profession  => le.corp_profession_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_profession_weight100,s.corp_profession_switch));
  INTEGER2 corp_province_score := MAP(
                        le.corp_province_isnull OR ri.corp_province_isnull => 0,
                        le.corp_province = ri.corp_province  => le.corp_province_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_province_weight100,s.corp_province_switch));
  INTEGER2 corp_public_mutual_corporation_score := MAP(
                        le.corp_public_mutual_corporation_isnull OR ri.corp_public_mutual_corporation_isnull => 0,
                        le.corp_public_mutual_corporation = ri.corp_public_mutual_corporation  => le.corp_public_mutual_corporation_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_public_mutual_corporation_weight100,s.corp_public_mutual_corporation_switch));
  INTEGER2 corp_purpose_score := MAP(
                        le.corp_purpose_isnull OR ri.corp_purpose_isnull => 0,
                        le.corp_purpose = ri.corp_purpose  => le.corp_purpose_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_purpose_weight100,s.corp_purpose_switch));
  INTEGER2 corp_ra_required_flag_score := MAP(
                        le.corp_ra_required_flag_isnull OR ri.corp_ra_required_flag_isnull => 0,
                        le.corp_ra_required_flag = ri.corp_ra_required_flag  => le.corp_ra_required_flag_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_required_flag_weight100,s.corp_ra_required_flag_switch));
  INTEGER2 corp_registered_counties_score := MAP(
                        le.corp_registered_counties_isnull OR ri.corp_registered_counties_isnull => 0,
                        le.corp_registered_counties = ri.corp_registered_counties  => le.corp_registered_counties_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_registered_counties_weight100,s.corp_registered_counties_switch));
  INTEGER2 corp_regulated_ind_score := MAP(
                        le.corp_regulated_ind_isnull OR ri.corp_regulated_ind_isnull => 0,
                        le.corp_regulated_ind = ri.corp_regulated_ind  => le.corp_regulated_ind_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_regulated_ind_weight100,s.corp_regulated_ind_switch));
  INTEGER2 corp_renewal_date_score := MAP(
                        le.corp_renewal_date_isnull OR ri.corp_renewal_date_isnull => 0,
                        le.corp_renewal_date = ri.corp_renewal_date  => le.corp_renewal_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_renewal_date_weight100,s.corp_renewal_date_switch));
  INTEGER2 corp_standing_other_score := MAP(
                        le.corp_standing_other_isnull OR ri.corp_standing_other_isnull => 0,
                        le.corp_standing_other = ri.corp_standing_other  => le.corp_standing_other_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_standing_other_weight100,s.corp_standing_other_switch));
  INTEGER2 corp_survivor_corporation_id_score := MAP(
                        le.corp_survivor_corporation_id_isnull OR ri.corp_survivor_corporation_id_isnull => 0,
                        le.corp_survivor_corporation_id = ri.corp_survivor_corporation_id  => le.corp_survivor_corporation_id_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_survivor_corporation_id_weight100,s.corp_survivor_corporation_id_switch));
  INTEGER2 corp_tax_base_score := MAP(
                        le.corp_tax_base_isnull OR ri.corp_tax_base_isnull => 0,
                        le.corp_tax_base = ri.corp_tax_base  => le.corp_tax_base_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_tax_base_weight100,s.corp_tax_base_switch));
  INTEGER2 corp_tax_standing_score := MAP(
                        le.corp_tax_standing_isnull OR ri.corp_tax_standing_isnull => 0,
                        le.corp_tax_standing = ri.corp_tax_standing  => le.corp_tax_standing_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_tax_standing_weight100,s.corp_tax_standing_switch));
  INTEGER2 corp_termination_cd_score := MAP(
                        le.corp_termination_cd_isnull OR ri.corp_termination_cd_isnull => 0,
                        le.corp_termination_cd = ri.corp_termination_cd  => le.corp_termination_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_termination_cd_weight100,s.corp_termination_cd_switch));
  INTEGER2 corp_termination_desc_score := MAP(
                        le.corp_termination_desc_isnull OR ri.corp_termination_desc_isnull => 0,
                        le.corp_termination_desc = ri.corp_termination_desc  => le.corp_termination_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_termination_desc_weight100,s.corp_termination_desc_switch));
  INTEGER2 corp_termination_date_score := MAP(
                        le.corp_termination_date_isnull OR ri.corp_termination_date_isnull => 0,
                        le.corp_termination_date = ri.corp_termination_date  => le.corp_termination_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_termination_date_weight100,s.corp_termination_date_switch));
  INTEGER2 corp_trademark_business_mark_type_score := MAP(
                        le.corp_trademark_business_mark_type_isnull OR ri.corp_trademark_business_mark_type_isnull => 0,
                        le.corp_trademark_business_mark_type = ri.corp_trademark_business_mark_type  => le.corp_trademark_business_mark_type_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_business_mark_type_weight100,s.corp_trademark_business_mark_type_switch));
  INTEGER2 corp_trademark_cancelled_date_score := MAP(
                        le.corp_trademark_cancelled_date_isnull OR ri.corp_trademark_cancelled_date_isnull => 0,
                        le.corp_trademark_cancelled_date = ri.corp_trademark_cancelled_date  => le.corp_trademark_cancelled_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_cancelled_date_weight100,s.corp_trademark_cancelled_date_switch));
  INTEGER2 corp_trademark_class_desc1_score := MAP(
                        le.corp_trademark_class_desc1_isnull OR ri.corp_trademark_class_desc1_isnull => 0,
                        le.corp_trademark_class_desc1 = ri.corp_trademark_class_desc1  => le.corp_trademark_class_desc1_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_class_desc1_weight100,s.corp_trademark_class_desc1_switch));
  INTEGER2 corp_trademark_class_desc2_score := MAP(
                        le.corp_trademark_class_desc2_isnull OR ri.corp_trademark_class_desc2_isnull => 0,
                        le.corp_trademark_class_desc2 = ri.corp_trademark_class_desc2  => le.corp_trademark_class_desc2_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_class_desc2_weight100,s.corp_trademark_class_desc2_switch));
  INTEGER2 corp_trademark_class_desc3_score := MAP(
                        le.corp_trademark_class_desc3_isnull OR ri.corp_trademark_class_desc3_isnull => 0,
                        le.corp_trademark_class_desc3 = ri.corp_trademark_class_desc3  => le.corp_trademark_class_desc3_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_class_desc3_weight100,s.corp_trademark_class_desc3_switch));
  INTEGER2 corp_trademark_class_desc4_score := MAP(
                        le.corp_trademark_class_desc4_isnull OR ri.corp_trademark_class_desc4_isnull => 0,
                        le.corp_trademark_class_desc4 = ri.corp_trademark_class_desc4  => le.corp_trademark_class_desc4_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_class_desc4_weight100,s.corp_trademark_class_desc4_switch));
  INTEGER2 corp_trademark_class_desc5_score := MAP(
                        le.corp_trademark_class_desc5_isnull OR ri.corp_trademark_class_desc5_isnull => 0,
                        le.corp_trademark_class_desc5 = ri.corp_trademark_class_desc5  => le.corp_trademark_class_desc5_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_class_desc5_weight100,s.corp_trademark_class_desc5_switch));
  INTEGER2 corp_trademark_class_desc6_score := MAP(
                        le.corp_trademark_class_desc6_isnull OR ri.corp_trademark_class_desc6_isnull => 0,
                        le.corp_trademark_class_desc6 = ri.corp_trademark_class_desc6  => le.corp_trademark_class_desc6_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_class_desc6_weight100,s.corp_trademark_class_desc6_switch));
  INTEGER2 corp_trademark_classification_nbr_score := MAP(
                        le.corp_trademark_classification_nbr_isnull OR ri.corp_trademark_classification_nbr_isnull => 0,
                        le.corp_trademark_classification_nbr = ri.corp_trademark_classification_nbr  => le.corp_trademark_classification_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_classification_nbr_weight100,s.corp_trademark_classification_nbr_switch));
  INTEGER2 corp_trademark_disclaimer1_score := MAP(
                        le.corp_trademark_disclaimer1_isnull OR ri.corp_trademark_disclaimer1_isnull => 0,
                        le.corp_trademark_disclaimer1 = ri.corp_trademark_disclaimer1  => le.corp_trademark_disclaimer1_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_disclaimer1_weight100,s.corp_trademark_disclaimer1_switch));
  INTEGER2 corp_trademark_disclaimer2_score := MAP(
                        le.corp_trademark_disclaimer2_isnull OR ri.corp_trademark_disclaimer2_isnull => 0,
                        le.corp_trademark_disclaimer2 = ri.corp_trademark_disclaimer2  => le.corp_trademark_disclaimer2_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_disclaimer2_weight100,s.corp_trademark_disclaimer2_switch));
  INTEGER2 corp_trademark_expiration_date_score := MAP(
                        le.corp_trademark_expiration_date_isnull OR ri.corp_trademark_expiration_date_isnull => 0,
                        le.corp_trademark_expiration_date = ri.corp_trademark_expiration_date  => le.corp_trademark_expiration_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_expiration_date_weight100,s.corp_trademark_expiration_date_switch));
  INTEGER2 corp_trademark_filing_date_score := MAP(
                        le.corp_trademark_filing_date_isnull OR ri.corp_trademark_filing_date_isnull => 0,
                        le.corp_trademark_filing_date = ri.corp_trademark_filing_date  => le.corp_trademark_filing_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_filing_date_weight100,s.corp_trademark_filing_date_switch));
  INTEGER2 corp_trademark_first_use_date_score := MAP(
                        le.corp_trademark_first_use_date_isnull OR ri.corp_trademark_first_use_date_isnull => 0,
                        le.corp_trademark_first_use_date = ri.corp_trademark_first_use_date  => le.corp_trademark_first_use_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_first_use_date_weight100,s.corp_trademark_first_use_date_switch));
  INTEGER2 corp_trademark_first_use_date_in_state_score := MAP(
                        le.corp_trademark_first_use_date_in_state_isnull OR ri.corp_trademark_first_use_date_in_state_isnull => 0,
                        le.corp_trademark_first_use_date_in_state = ri.corp_trademark_first_use_date_in_state  => le.corp_trademark_first_use_date_in_state_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_first_use_date_in_state_weight100,s.corp_trademark_first_use_date_in_state_switch));
  INTEGER2 corp_trademark_keywords_score := MAP(
                        le.corp_trademark_keywords_isnull OR ri.corp_trademark_keywords_isnull => 0,
                        le.corp_trademark_keywords = ri.corp_trademark_keywords  => le.corp_trademark_keywords_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_keywords_weight100,s.corp_trademark_keywords_switch));
  INTEGER2 corp_trademark_logo_score := MAP(
                        le.corp_trademark_logo_isnull OR ri.corp_trademark_logo_isnull => 0,
                        le.corp_trademark_logo = ri.corp_trademark_logo  => le.corp_trademark_logo_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_logo_weight100,s.corp_trademark_logo_switch));
  INTEGER2 corp_trademark_name_expiration_date_score := MAP(
                        le.corp_trademark_name_expiration_date_isnull OR ri.corp_trademark_name_expiration_date_isnull => 0,
                        le.corp_trademark_name_expiration_date = ri.corp_trademark_name_expiration_date  => le.corp_trademark_name_expiration_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_name_expiration_date_weight100,s.corp_trademark_name_expiration_date_switch));
  INTEGER2 corp_trademark_nbr_score := MAP(
                        le.corp_trademark_nbr_isnull OR ri.corp_trademark_nbr_isnull => 0,
                        le.corp_trademark_nbr = ri.corp_trademark_nbr  => le.corp_trademark_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_nbr_weight100,s.corp_trademark_nbr_switch));
  INTEGER2 corp_trademark_renewal_date_score := MAP(
                        le.corp_trademark_renewal_date_isnull OR ri.corp_trademark_renewal_date_isnull => 0,
                        le.corp_trademark_renewal_date = ri.corp_trademark_renewal_date  => le.corp_trademark_renewal_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_renewal_date_weight100,s.corp_trademark_renewal_date_switch));
  INTEGER2 corp_trademark_status_score := MAP(
                        le.corp_trademark_status_isnull OR ri.corp_trademark_status_isnull => 0,
                        le.corp_trademark_status = ri.corp_trademark_status  => le.corp_trademark_status_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_status_weight100,s.corp_trademark_status_switch));
  INTEGER2 corp_trademark_used_1_score := MAP(
                        le.corp_trademark_used_1_isnull OR ri.corp_trademark_used_1_isnull => 0,
                        le.corp_trademark_used_1 = ri.corp_trademark_used_1  => le.corp_trademark_used_1_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_used_1_weight100,s.corp_trademark_used_1_switch));
  INTEGER2 corp_trademark_used_2_score := MAP(
                        le.corp_trademark_used_2_isnull OR ri.corp_trademark_used_2_isnull => 0,
                        le.corp_trademark_used_2 = ri.corp_trademark_used_2  => le.corp_trademark_used_2_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_used_2_weight100,s.corp_trademark_used_2_switch));
  INTEGER2 corp_trademark_used_3_score := MAP(
                        le.corp_trademark_used_3_isnull OR ri.corp_trademark_used_3_isnull => 0,
                        le.corp_trademark_used_3 = ri.corp_trademark_used_3  => le.corp_trademark_used_3_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_used_3_weight100,s.corp_trademark_used_3_switch));
  INTEGER2 cont_owner_percentage_score := MAP(
                        le.cont_owner_percentage_isnull OR ri.cont_owner_percentage_isnull => 0,
                        le.cont_owner_percentage = ri.cont_owner_percentage  => le.cont_owner_percentage_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_owner_percentage_weight100,s.cont_owner_percentage_switch));
  INTEGER2 cont_country_score := MAP(
                        le.cont_country_isnull OR ri.cont_country_isnull => 0,
                        le.cont_country = ri.cont_country  => le.cont_country_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_country_weight100,s.cont_country_switch));
  INTEGER2 cont_country_mailing_score := MAP(
                        le.cont_country_mailing_isnull OR ri.cont_country_mailing_isnull => 0,
                        le.cont_country_mailing = ri.cont_country_mailing  => le.cont_country_mailing_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_country_mailing_weight100,s.cont_country_mailing_switch));
  INTEGER2 cont_nondislosure_score := MAP(
                        le.cont_nondislosure_isnull OR ri.cont_nondislosure_isnull => 0,
                        le.cont_nondislosure = ri.cont_nondislosure  => le.cont_nondislosure_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_nondislosure_weight100,s.cont_nondislosure_switch));
  INTEGER2 cont_prep_addr_line1_score := MAP(
                        le.cont_prep_addr_line1_isnull OR ri.cont_prep_addr_line1_isnull => 0,
                        le.cont_prep_addr_line1 = ri.cont_prep_addr_line1  => le.cont_prep_addr_line1_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_prep_addr_line1_weight100,s.cont_prep_addr_line1_switch));
  INTEGER2 cont_prep_addr_last_line_score := MAP(
                        le.cont_prep_addr_last_line_isnull OR ri.cont_prep_addr_last_line_isnull => 0,
                        le.cont_prep_addr_last_line = ri.cont_prep_addr_last_line  => le.cont_prep_addr_last_line_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_prep_addr_last_line_weight100,s.cont_prep_addr_last_line_switch));
  INTEGER2 recordorigin_score := MAP(
                        le.recordorigin_isnull OR ri.recordorigin_isnull => 0,
                        le.recordorigin = ri.recordorigin  => le.recordorigin_weight100,
                        SALT34.Fn_Fail_Scale(le.recordorigin_weight100,s.recordorigin_switch));
  SELF.Conf_Prop := (0
  ) / 100; // Score based on propogated fields
  iComp := (dt_vendor_first_reported_score + dt_vendor_last_reported_score + dt_first_seen_score + dt_last_seen_score + corp_ra_dt_first_seen_score + corp_ra_dt_last_seen_score + corp_key_score + corp_supp_key_score + corp_vendor_score + corp_vendor_county_score + corp_vendor_subcode_score + corp_state_origin_score + corp_process_date_score + corp_orig_sos_charter_nbr_score + corp_legal_name_score + corp_ln_name_type_cd_score + corp_ln_name_type_desc_score + corp_supp_nbr_score + corp_name_comment_score + corp_address1_type_cd_score + corp_address1_type_desc_score + corp_address1_line1_score + corp_address1_line2_score + corp_address1_line3_score + corp_address1_effective_date_score + corp_address2_type_cd_score + corp_address2_type_desc_score + corp_address2_line1_score + corp_address2_line2_score + corp_address2_line3_score + corp_address2_effective_date_score + corp_phone_number_score + corp_phone_number_type_cd_score + corp_phone_number_type_desc_score + corp_fax_nbr_score + corp_email_address_score + corp_web_address_score + corp_filing_reference_nbr_score + corp_filing_date_score + corp_filing_cd_score + corp_filing_desc_score + corp_status_cd_score + corp_status_desc_score + corp_status_date_score + corp_standing_score + corp_status_comment_score + corp_ticker_symbol_score + corp_stock_exchange_score + corp_inc_state_score + corp_inc_county_score + corp_inc_date_score + corp_anniversary_month_score + corp_fed_tax_id_score + corp_state_tax_id_score + corp_term_exist_cd_score + corp_term_exist_exp_score + corp_term_exist_desc_score + corp_foreign_domestic_ind_score + corp_forgn_state_cd_score + corp_forgn_state_desc_score + corp_forgn_sos_charter_nbr_score + corp_forgn_date_score + corp_forgn_fed_tax_id_score + corp_forgn_state_tax_id_score + corp_forgn_term_exist_cd_score + corp_forgn_term_exist_exp_score + corp_forgn_term_exist_desc_score + corp_orig_org_structure_cd_score + corp_orig_org_structure_desc_score + corp_for_profit_ind_score + corp_public_or_private_ind_score + corp_sic_code_score + corp_naic_code_score + corp_orig_bus_type_cd_score + corp_orig_bus_type_desc_score + corp_entity_desc_score + corp_certificate_nbr_score + corp_internal_nbr_score + corp_previous_nbr_score + corp_microfilm_nbr_score + corp_amendments_filed_score + corp_acts_score + corp_partnership_ind_score + corp_mfg_ind_score + corp_addl_info_score + corp_taxes_score + corp_franchise_taxes_score + corp_tax_program_cd_score + corp_tax_program_desc_score + corp_ra_full_name_score + corp_ra_fname_score + corp_ra_mname_score + corp_ra_lname_score + corp_ra_suffix_score + corp_ra_title_cd_score + corp_ra_title_desc_score + corp_ra_fein_score + corp_ra_ssn_score + corp_ra_dob_score + corp_ra_effective_date_score + corp_ra_resign_date_score + corp_ra_no_comp_score + corp_ra_no_comp_igs_score + corp_ra_addl_info_score + corp_ra_address_type_cd_score + corp_ra_address_type_desc_score + corp_ra_address_line1_score + corp_ra_address_line2_score + corp_ra_address_line3_score + corp_ra_phone_number_score + corp_ra_phone_number_type_cd_score + corp_ra_phone_number_type_desc_score + corp_ra_fax_nbr_score + corp_ra_email_address_score + corp_ra_web_address_score + corp_prep_addr1_line1_score + corp_prep_addr1_last_line_score + corp_prep_addr2_line1_score + corp_prep_addr2_last_line_score + ra_prep_addr_line1_score + ra_prep_addr_last_line_score + cont_filing_reference_nbr_score + cont_filing_date_score + cont_filing_cd_score + cont_filing_desc_score + cont_type_cd_score + cont_type_desc_score + cont_full_name_score + cont_fname_score + cont_mname_score + cont_lname_score + cont_suffix_score + cont_title1_desc_score + cont_title2_desc_score + cont_title3_desc_score + cont_title4_desc_score + cont_title5_desc_score + cont_fein_score + cont_ssn_score + cont_dob_score + cont_status_cd_score + cont_status_desc_score + cont_effective_date_score + cont_effective_cd_score + cont_effective_desc_score + cont_addl_info_score + cont_address_type_cd_score + cont_address_type_desc_score + cont_address_line1_score + cont_address_line2_score + cont_address_line3_score + cont_address_effective_date_score + cont_address_county_score + cont_phone_number_score + cont_phone_number_type_cd_score + cont_phone_number_type_desc_score + cont_fax_nbr_score + cont_email_address_score + cont_web_address_score + corp_acres_score + corp_action_score + corp_action_date_score + corp_action_employment_security_approval_date_score + corp_action_pending_cd_score + corp_action_pending_desc_score + corp_action_statement_of_intent_date_score + corp_action_tax_dept_approval_date_score + corp_acts2_score + corp_acts3_score + corp_additional_principals_score + corp_address_office_type_score + corp_agent_assign_date_score + corp_agent_commercial_score + corp_agent_country_score + corp_agent_county_score + corp_agent_status_cd_score + corp_agent_status_desc_score + corp_agent_id_score + corp_agriculture_flag_score + corp_authorized_partners_score + corp_comment_score + corp_consent_flag_for_protected_name_score + corp_converted_score + corp_converted_from_score + corp_country_of_formation_score + corp_date_of_organization_meeting_score + corp_delayed_effective_date_score + corp_directors_from_to_score + corp_dissolved_date_score + corp_farm_exemptions_score + corp_farm_qual_date_score + corp_farm_status_cd_score + corp_farm_status_desc_score + corp_fiscal_year_month_score + corp_foreign_fiduciary_capacity_in_state_score + corp_governing_statute_score + corp_has_members_score + corp_has_vested_managers_score + corp_home_incorporated_county_score + corp_home_state_name_score + corp_is_professional_score + corp_is_non_profit_irs_approved_score + corp_last_renewal_date_score + corp_last_renewal_year_score + corp_license_type_score + corp_llc_managed_desc_score + corp_llc_managed_ind_score + corp_management_desc_score + corp_management_type_score + corp_manager_managed_score + corp_merged_corporation_id_score + corp_merged_fein_score + corp_merger_allowed_flag_score + corp_merger_date_score + corp_merger_desc_score + corp_merger_effective_date_score + corp_merger_id_score + corp_merger_indicator_score + corp_merger_name_score + corp_merger_type_converted_to_cd_score + corp_merger_type_converted_to_desc_score + corp_naics_desc_score + corp_name_effective_date_score + corp_name_reservation_date_score + corp_name_reservation_desc_score + corp_name_reservation_expiration_date_score + corp_name_reservation_nbr_score + corp_name_reservation_type_score + corp_name_status_cd_score + corp_name_status_date_score + corp_name_status_desc_score + corp_non_profit_irs_approved_purpose_score + corp_non_profit_solicit_donations_score + corp_nbr_of_amendments_score + corp_nbr_of_initial_llc_members_score + corp_nbr_of_partners_score + corp_operating_agreement_score + corp_opt_in_llc_act_desc_score + corp_opt_in_llc_act_ind_score + corp_organizational_comments_score + corp_partner_contributions_total_score + corp_partner_terms_score + corp_percentage_voters_required_to_approve_amendments_score + corp_profession_score + corp_province_score + corp_public_mutual_corporation_score + corp_purpose_score + corp_ra_required_flag_score + corp_registered_counties_score + corp_regulated_ind_score + corp_renewal_date_score + corp_standing_other_score + corp_survivor_corporation_id_score + corp_tax_base_score + corp_tax_standing_score + corp_termination_cd_score + corp_termination_desc_score + corp_termination_date_score + corp_trademark_business_mark_type_score + corp_trademark_cancelled_date_score + corp_trademark_class_desc1_score + corp_trademark_class_desc2_score + corp_trademark_class_desc3_score + corp_trademark_class_desc4_score + corp_trademark_class_desc5_score + corp_trademark_class_desc6_score + corp_trademark_classification_nbr_score + corp_trademark_disclaimer1_score + corp_trademark_disclaimer2_score + corp_trademark_expiration_date_score + corp_trademark_filing_date_score + corp_trademark_first_use_date_score + corp_trademark_first_use_date_in_state_score + corp_trademark_keywords_score + corp_trademark_logo_score + corp_trademark_name_expiration_date_score + corp_trademark_nbr_score + corp_trademark_renewal_date_score + corp_trademark_status_score + corp_trademark_used_1_score + corp_trademark_used_2_score + corp_trademark_used_3_score + cont_owner_percentage_score + cont_country_score + cont_country_mailing_score + cont_nondislosure_score + cont_prep_addr_line1_score + cont_prep_addr_last_line_score + recordorigin_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) := 'AttributeFile:'+(STRING)(n-10000);
SHARED all_mjs := MAC_DoJoins(h,match_join);
+++Line:325:No match joins created! Specificities are too low for matching
EXPORT All_Matches := all_mjs : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::all_m',EXPIRE(Config.PersistExpire)); // To by used by  and 
SALT34.mac_avoid_transitives(All_Matches,1,2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::mt',EXPIRE(Config.PersistExpire));
SALT34.mac_get_BestPerRecord( All_Matches,1,1,2,2,o );
EXPORT BestPerRecord := o : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::mr',EXPIRE(Config.PersistExpire));
//Now lets see if any slice-outs are needed
too_big := TABLE(h,{, InCluster := COUNT(GROUP)},,LOCAL)(InCluster>1000); //  that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.=RIGHT.,TRANSFORM(LEFT),LOCAL,LEFT ONLY);
SHARED in_matches := JOIN(h_ok,h_ok,LEFT.=RIGHT. AND (>STRING6<)LEFT.<>(>STRING6<)RIGHT.,match_join(LEFT,RIGHT,9999),LOCAL,UNORDERED);
SALT34.mac_cluster_breadth(in_matches,1,2,1,o);
SHARED in_matches1 := o;
missed_linkages := JOIN(in_matches1,Specificities(ih).ClusterSizes(InCluster>1),LEFT.1=RIGHT.,RIGHT ONLY,LOCAL);
missed_linkages1 := JOIN(h,missed_linkages,LEFT.=RIGHT.,TRANSFORM(RECORDOF(missed_linkages),SELF.1:=RIGHT.,SELF.1:=LEFT.,SELF:=RIGHT),LOCAL);
o1 := JOIN(in_matches1,Specificities(ih).ClusterSizes,LEFT.1=RIGHT.,LOCAL);
EXPORT ClusterLinkages := o1 + missed_linkages1 : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::clu',EXPIRE(Config.PersistExpire));
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT34.UIDType ;  //Outcast
  SALT34.UIDType ;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT34.UIDType Pref_; // Prefers this record
  SALT34.UIDType Pref_; // Prefers this cluster
  INTEGER2 Conf; // Score of new link
  integer2 Conf_Prop; // Prop of new link
  UNSIGNED2 Pref_Margin; // Extent to which pref is preferred
END;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := TRANSFORM
  self. := le.1;
  self. := le.1;
  self.Closest := le.Closest;
  self.Pref_ := ri.2;
  self.Pref_ := ri.2;
  self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
  SELF := ri;
END;
// Find those records happier in another cluster
CurrentJumpers := JOIN(BestPerRecord,ClusterOutcasts,LEFT.1=RIGHT.1 AND RIGHT.closest<LEFT.conf-LEFT.conf_prop,note_better(RIGHT,LEFT),HASH);
// No need for record to jump ship if clusters are joinable
WillJoin1 := JOIN(CurrentJumpers,All_Matches(Conf>=MatchThreshold),LEFT.=RIGHT.1 AND LEFT.Pref_=RIGHT.2,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin2 := JOIN(WillJoin1,All_Matches(Conf>=MatchThreshold),LEFT.=RIGHT.2 AND LEFT.Pref_=RIGHT.1,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin3 := JOIN(WillJoin2,match_candidates(ih).hasbuddies,LEFT.=RIGHT.,TRANSFORM(LEFT),LEFT ONLY,HASH); // Duplicated records cannot be sliced
EXPORT BetterElsewhere := WillJoin3;
EXPORT ToSlice := IF ( Config.DoSliceouts, DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH()),,-Pref_Margin,LOCAL),,LOCAL)) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::Matches::ToSlice',EXPIRE(Config.PersistExpire));
// 1024x better in new place
  SALT34.MAC_Avoid_SliceOuts(PossibleMatches,1,2,,Pref_,ToSlice,m); // If  is slice target - don't use in match
  m1 := IF( Config.DoSliceouts,m,PossibleMatches );
EXPORT Matches := m1(Conf>=MatchThreshold) : PERSIST('~temp::Scrubs_Corp2_Mapping_GA_Main::Matches::Matches',EXPIRE(Config.PersistExpire));
 
//Output the attributes to use for match debugging
EXPORT MatchSample := ENTH(Matches,1000);
EXPORT BorderlineMatchSample := ENTH(Matches(Conf=MatchThreshold),1000);
EXPORT AlmostMatchSample := ENTH(PossibleMatches(Conf<MatchThreshold,Conf>=LowerMatchThreshold),1000);
r := RECORD
  UNSIGNED2 RuleNumber := Matches.Rule;
  STRING Rule := RuleText(Matches.Rule);
  UNSIGNED MatchesFound := COUNT(GROUP);
END;
EXPORT RuleEfficacy := TABLE(Matches,r,Rule,FEW);
r := RECORD
  UNSIGNED2 Conf := Matches.Conf;
  UNSIGNED MatchesFound := COUNT(GROUp);
END;
export ConfidenceBreakdown := table(Matches,r,Conf,few);
Full_Sample_Matches := MatchSample+BorderlineMatchSample+AlmostMatchSample;
export MatchSampleRecords := Debug(ih,s,MatchThreshold).AnnotateMatches(Full_Sample_Matches);
 
//Now actually produce the new file
SHARED ih_init := Specificities(ih).ih_init;
SHARED ih_thin := TABLE(ih_init,{});
  ut.MAC_Patch_Id(ih_thin,,BasicMatch(ih).patch_file,1,2,ihbp); // Perform basic matches
  SALT34.MAC_SliceOut_ByRID(ihbp,,,ToSlice,,sliced0); // Execute Sliceouts
  sliced := IF( Config.DoSliceouts, sliced0, ihbp); // Config-based ability to remove sliceout
  ut.MAC_Patch_Id(sliced,,Matches,1,2,o); // Join Clusters
SHARED Patched_Infile_thin := o : INDEPENDENT;
  pi1 := JOIN(ih, Patched_Infile_thin, LEFT.=RIGHT., TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
 
EXPORT Patched_Infile := pi1;
 
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,,Matches,1,2,o1);
EXPORT Patched_Candidates := o1;
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := Scrubs_Corp2_Mapping_GA_Main.Fields.UIDConsistency(ih_thin); // Export whole consistency module
EXPORT PostIDs := Scrubs_Corp2_Mapping_GA_Main.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[2].cnt - PostIDs.IdCounts[2].cnt - MatchesPerformed - COUNT(BasicMatch(ih).patch_file)  + SlicesPerformed; // Should be zero
END;

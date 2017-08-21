IMPORT SALT32,std;
EXPORT match_methods(DATASET(layout_Property_Characteristics) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_property_rid(TYPEOF(h.property_rid) L, TYPEOF(h.property_rid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
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
EXPORT match_tax_sortby_date_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_sortby_date_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_sortby_date_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_sortby_date(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_deed_sortby_date_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_deed_sortby_date_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_deed_sortby_date_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_deed_sortby_date(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_vendor_source(TYPEOF(h.vendor_source) L, TYPEOF(h.vendor_source) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_fares_unformatted_apn(TYPEOF(h.fares_unformatted_apn) L, TYPEOF(h.fares_unformatted_apn) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_property_street_address(TYPEOF(h.property_street_address) L, TYPEOF(h.property_street_address) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_property_city_state_zip(TYPEOF(h.property_city_state_zip) L, TYPEOF(h.property_city_state_zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_property_raw_aid(TYPEOF(h.property_raw_aid) L, TYPEOF(h.property_raw_aid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_prim_range(TYPEOF(h.prim_range) L, TYPEOF(h.prim_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_predir(TYPEOF(h.predir) L, TYPEOF(h.predir) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_prim_name(TYPEOF(h.prim_name) L, TYPEOF(h.prim_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_addr_suffix(TYPEOF(h.addr_suffix) L, TYPEOF(h.addr_suffix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_postdir(TYPEOF(h.postdir) L, TYPEOF(h.postdir) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_unit_desig(TYPEOF(h.unit_desig) L, TYPEOF(h.unit_desig) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_sec_range(TYPEOF(h.sec_range) L, TYPEOF(h.sec_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_p_city_name(TYPEOF(h.p_city_name) L, TYPEOF(h.p_city_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_v_city_name(TYPEOF(h.v_city_name) L, TYPEOF(h.v_city_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_st(TYPEOF(h.st) L, TYPEOF(h.st) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_zip(TYPEOF(h.zip) L, TYPEOF(h.zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_zip4(TYPEOF(h.zip4) L, TYPEOF(h.zip4) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_cart(TYPEOF(h.cart) L, TYPEOF(h.cart) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_cr_sort_sz(TYPEOF(h.cr_sort_sz) L, TYPEOF(h.cr_sort_sz) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_lot(TYPEOF(h.lot) L, TYPEOF(h.lot) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_lot_order(TYPEOF(h.lot_order) L, TYPEOF(h.lot_order) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_dbpc(TYPEOF(h.dbpc) L, TYPEOF(h.dbpc) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_chk_digit(TYPEOF(h.chk_digit) L, TYPEOF(h.chk_digit) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_rec_type(TYPEOF(h.rec_type) L, TYPEOF(h.rec_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_county(TYPEOF(h.county) L, TYPEOF(h.county) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_geo_lat(TYPEOF(h.geo_lat) L, TYPEOF(h.geo_lat) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_geo_long(TYPEOF(h.geo_long) L, TYPEOF(h.geo_long) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_msa(TYPEOF(h.msa) L, TYPEOF(h.msa) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_geo_blk(TYPEOF(h.geo_blk) L, TYPEOF(h.geo_blk) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_geo_match(TYPEOF(h.geo_match) L, TYPEOF(h.geo_match) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_err_stat(TYPEOF(h.err_stat) L, TYPEOF(h.err_stat) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_building_square_footage(TYPEOF(h.building_square_footage) L, TYPEOF(h.building_square_footage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_building_square_footage(TYPEOF(h.src_building_square_footage) L, TYPEOF(h.src_building_square_footage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_building_square_footage_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_building_square_footage_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_building_square_footage_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_building_square_footage(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_air_conditioning_type(TYPEOF(h.air_conditioning_type) L, TYPEOF(h.air_conditioning_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_air_conditioning_type(TYPEOF(h.src_air_conditioning_type) L, TYPEOF(h.src_air_conditioning_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_air_conditioning_type_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_air_conditioning_type_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_air_conditioning_type_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_air_conditioning_type(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_basement_finish(TYPEOF(h.basement_finish) L, TYPEOF(h.basement_finish) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_basement_finish(TYPEOF(h.src_basement_finish) L, TYPEOF(h.src_basement_finish) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_basement_finish_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_basement_finish_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_basement_finish_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_basement_finish(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_construction_type(TYPEOF(h.construction_type) L, TYPEOF(h.construction_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_construction_type(TYPEOF(h.src_construction_type) L, TYPEOF(h.src_construction_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_construction_type_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_construction_type_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_construction_type_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_construction_type(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_exterior_wall(TYPEOF(h.exterior_wall) L, TYPEOF(h.exterior_wall) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_exterior_wall(TYPEOF(h.src_exterior_wall) L, TYPEOF(h.src_exterior_wall) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_exterior_wall_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_exterior_wall_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_exterior_wall_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_exterior_wall(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_fireplace_ind(TYPEOF(h.fireplace_ind) L, TYPEOF(h.fireplace_ind) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_fireplace_ind(TYPEOF(h.src_fireplace_ind) L, TYPEOF(h.src_fireplace_ind) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_fireplace_ind_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_fireplace_ind_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_fireplace_ind_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_fireplace_ind(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_fireplace_type(TYPEOF(h.fireplace_type) L, TYPEOF(h.fireplace_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_fireplace_type(TYPEOF(h.src_fireplace_type) L, TYPEOF(h.src_fireplace_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_fireplace_type_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_fireplace_type_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_fireplace_type_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_fireplace_type(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_flood_zone_panel(TYPEOF(h.flood_zone_panel) L, TYPEOF(h.flood_zone_panel) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_flood_zone_panel(TYPEOF(h.src_flood_zone_panel) L, TYPEOF(h.src_flood_zone_panel) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_flood_zone_panel_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_flood_zone_panel_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_flood_zone_panel_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_flood_zone_panel(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_garage(TYPEOF(h.garage) L, TYPEOF(h.garage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_garage(TYPEOF(h.src_garage) L, TYPEOF(h.src_garage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_garage_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_garage_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_garage_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_garage(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_first_floor_square_footage(TYPEOF(h.first_floor_square_footage) L, TYPEOF(h.first_floor_square_footage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_first_floor_square_footage(TYPEOF(h.src_first_floor_square_footage) L, TYPEOF(h.src_first_floor_square_footage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_first_floor_square_footage_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_first_floor_square_footage_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_first_floor_square_footage_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_first_floor_square_footage(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_heating(TYPEOF(h.heating) L, TYPEOF(h.heating) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_heating(TYPEOF(h.src_heating) L, TYPEOF(h.src_heating) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_heating_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_heating_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_heating_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_heating(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_living_area_square_footage(TYPEOF(h.living_area_square_footage) L, TYPEOF(h.living_area_square_footage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_living_area_square_footage(TYPEOF(h.src_living_area_square_footage) L, TYPEOF(h.src_living_area_square_footage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_living_area_square_footage_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_living_area_square_footage_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_living_area_square_footage_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_living_area_square_footage(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_no_of_baths(TYPEOF(h.no_of_baths) L, TYPEOF(h.no_of_baths) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_no_of_baths(TYPEOF(h.src_no_of_baths) L, TYPEOF(h.src_no_of_baths) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_no_of_baths_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_baths_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_baths_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_baths(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_no_of_bedrooms(TYPEOF(h.no_of_bedrooms) L, TYPEOF(h.no_of_bedrooms) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_no_of_bedrooms(TYPEOF(h.src_no_of_bedrooms) L, TYPEOF(h.src_no_of_bedrooms) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_no_of_bedrooms_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_bedrooms_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_bedrooms_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_bedrooms(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_no_of_fireplaces(TYPEOF(h.no_of_fireplaces) L, TYPEOF(h.no_of_fireplaces) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_no_of_fireplaces(TYPEOF(h.src_no_of_fireplaces) L, TYPEOF(h.src_no_of_fireplaces) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_no_of_fireplaces_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_fireplaces_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_fireplaces_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_fireplaces(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_no_of_full_baths(TYPEOF(h.no_of_full_baths) L, TYPEOF(h.no_of_full_baths) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_no_of_full_baths(TYPEOF(h.src_no_of_full_baths) L, TYPEOF(h.src_no_of_full_baths) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_no_of_full_baths_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_full_baths_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_full_baths_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_full_baths(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_no_of_half_baths(TYPEOF(h.no_of_half_baths) L, TYPEOF(h.no_of_half_baths) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_no_of_half_baths(TYPEOF(h.src_no_of_half_baths) L, TYPEOF(h.src_no_of_half_baths) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_no_of_half_baths_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_half_baths_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_half_baths_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_half_baths(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_no_of_stories(TYPEOF(h.no_of_stories) L, TYPEOF(h.no_of_stories) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_no_of_stories(TYPEOF(h.src_no_of_stories) L, TYPEOF(h.src_no_of_stories) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_no_of_stories_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_stories_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_stories_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_stories(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_parking_type(TYPEOF(h.parking_type) L, TYPEOF(h.parking_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_parking_type(TYPEOF(h.src_parking_type) L, TYPEOF(h.src_parking_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_parking_type_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_parking_type_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_parking_type_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_parking_type(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_pool_indicator(TYPEOF(h.pool_indicator) L, TYPEOF(h.pool_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_pool_indicator(TYPEOF(h.src_pool_indicator) L, TYPEOF(h.src_pool_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_pool_indicator_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_pool_indicator_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_pool_indicator_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_pool_indicator(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_pool_type(TYPEOF(h.pool_type) L, TYPEOF(h.pool_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_pool_type(TYPEOF(h.src_pool_type) L, TYPEOF(h.src_pool_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_pool_type_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_pool_type_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_pool_type_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_pool_type(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_roof_cover(TYPEOF(h.roof_cover) L, TYPEOF(h.roof_cover) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_roof_cover(TYPEOF(h.src_roof_cover) L, TYPEOF(h.src_roof_cover) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_roof_cover_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_roof_cover_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_roof_cover_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_roof_cover(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_year_built(TYPEOF(h.year_built) L, TYPEOF(h.year_built) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_year_built(TYPEOF(h.src_year_built) L, TYPEOF(h.src_year_built) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_year_built_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_year_built_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_year_built_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_year_built(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_foundation(TYPEOF(h.foundation) L, TYPEOF(h.foundation) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_foundation(TYPEOF(h.src_foundation) L, TYPEOF(h.src_foundation) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_foundation_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_foundation_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_foundation_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_foundation(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_basement_square_footage(TYPEOF(h.basement_square_footage) L, TYPEOF(h.basement_square_footage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_basement_square_footage(TYPEOF(h.src_basement_square_footage) L, TYPEOF(h.src_basement_square_footage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_basement_square_footage_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_basement_square_footage_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_basement_square_footage_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_basement_square_footage(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_effective_year_built(TYPEOF(h.effective_year_built) L, TYPEOF(h.effective_year_built) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_effective_year_built(TYPEOF(h.src_effective_year_built) L, TYPEOF(h.src_effective_year_built) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_effective_year_built_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_effective_year_built_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_effective_year_built_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_effective_year_built(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_garage_square_footage(TYPEOF(h.garage_square_footage) L, TYPEOF(h.garage_square_footage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_garage_square_footage(TYPEOF(h.src_garage_square_footage) L, TYPEOF(h.src_garage_square_footage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_garage_square_footage_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_garage_square_footage_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_garage_square_footage_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_garage_square_footage(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_stories_type(TYPEOF(h.stories_type) L, TYPEOF(h.stories_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_stories_type(TYPEOF(h.src_stories_type) L, TYPEOF(h.src_stories_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_stories_type_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_stories_type_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_stories_type_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_stories_type(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_apn_number(TYPEOF(h.apn_number) L, TYPEOF(h.apn_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_apn_number(TYPEOF(h.src_apn_number) L, TYPEOF(h.src_apn_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_apn_number_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_apn_number_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_apn_number_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_apn_number(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_census_tract(TYPEOF(h.census_tract) L, TYPEOF(h.census_tract) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_census_tract(TYPEOF(h.src_census_tract) L, TYPEOF(h.src_census_tract) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_census_tract_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_census_tract_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_census_tract_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_census_tract(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_range(TYPEOF(h.range) L, TYPEOF(h.range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_range(TYPEOF(h.src_range) L, TYPEOF(h.src_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_range_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_range_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_range_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_range(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_zoning(TYPEOF(h.zoning) L, TYPEOF(h.zoning) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_zoning(TYPEOF(h.src_zoning) L, TYPEOF(h.src_zoning) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_zoning_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_zoning_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_zoning_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_zoning(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_block_number(TYPEOF(h.block_number) L, TYPEOF(h.block_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_block_number(TYPEOF(h.src_block_number) L, TYPEOF(h.src_block_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_block_number_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_block_number_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_block_number_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_block_number(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_county_name(TYPEOF(h.county_name) L, TYPEOF(h.county_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_county_name(TYPEOF(h.src_county_name) L, TYPEOF(h.src_county_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_county_name_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_county_name_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_county_name_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_county_name(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_fips_code(TYPEOF(h.fips_code) L, TYPEOF(h.fips_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_fips_code(TYPEOF(h.src_fips_code) L, TYPEOF(h.src_fips_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_fips_code_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_fips_code_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_fips_code_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_fips_code(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_subdivision(TYPEOF(h.subdivision) L, TYPEOF(h.subdivision) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_subdivision(TYPEOF(h.src_subdivision) L, TYPEOF(h.src_subdivision) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_subdivision_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_subdivision_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_subdivision_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_subdivision(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_municipality(TYPEOF(h.municipality) L, TYPEOF(h.municipality) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_municipality(TYPEOF(h.src_municipality) L, TYPEOF(h.src_municipality) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_municipality_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_municipality_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_municipality_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_municipality(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_township(TYPEOF(h.township) L, TYPEOF(h.township) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_township(TYPEOF(h.src_township) L, TYPEOF(h.src_township) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_township_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_township_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_township_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_township(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_homestead_exemption_ind(TYPEOF(h.homestead_exemption_ind) L, TYPEOF(h.homestead_exemption_ind) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_homestead_exemption_ind(TYPEOF(h.src_homestead_exemption_ind) L, TYPEOF(h.src_homestead_exemption_ind) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_homestead_exemption_ind_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_homestead_exemption_ind_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_homestead_exemption_ind_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_homestead_exemption_ind(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_land_use_code(TYPEOF(h.land_use_code) L, TYPEOF(h.land_use_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_land_use_code(TYPEOF(h.src_land_use_code) L, TYPEOF(h.src_land_use_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_land_use_code_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_land_use_code_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_land_use_code_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_land_use_code(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_latitude(TYPEOF(h.latitude) L, TYPEOF(h.latitude) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_latitude(TYPEOF(h.src_latitude) L, TYPEOF(h.src_latitude) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_latitude_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_latitude_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_latitude_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_latitude(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_longitude(TYPEOF(h.longitude) L, TYPEOF(h.longitude) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_longitude(TYPEOF(h.src_longitude) L, TYPEOF(h.src_longitude) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_longitude_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_longitude_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_longitude_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_longitude(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_location_influence_code(TYPEOF(h.location_influence_code) L, TYPEOF(h.location_influence_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_location_influence_code(TYPEOF(h.src_location_influence_code) L, TYPEOF(h.src_location_influence_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_location_influence_code_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_location_influence_code_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_location_influence_code_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_location_influence_code(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_acres(TYPEOF(h.acres) L, TYPEOF(h.acres) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_acres(TYPEOF(h.src_acres) L, TYPEOF(h.src_acres) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_acres_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_acres_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_acres_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_acres(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_lot_depth_footage(TYPEOF(h.lot_depth_footage) L, TYPEOF(h.lot_depth_footage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_lot_depth_footage(TYPEOF(h.src_lot_depth_footage) L, TYPEOF(h.src_lot_depth_footage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_lot_depth_footage_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_lot_depth_footage_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_lot_depth_footage_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_lot_depth_footage(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_lot_front_footage(TYPEOF(h.lot_front_footage) L, TYPEOF(h.lot_front_footage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_lot_front_footage(TYPEOF(h.src_lot_front_footage) L, TYPEOF(h.src_lot_front_footage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_lot_front_footage_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_lot_front_footage_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_lot_front_footage_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_lot_front_footage(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_lot_number(TYPEOF(h.lot_number) L, TYPEOF(h.lot_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_lot_number(TYPEOF(h.src_lot_number) L, TYPEOF(h.src_lot_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_lot_number_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_lot_number_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_lot_number_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_lot_number(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_lot_size(TYPEOF(h.lot_size) L, TYPEOF(h.lot_size) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_lot_size(TYPEOF(h.src_lot_size) L, TYPEOF(h.src_lot_size) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_lot_size_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_lot_size_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_lot_size_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_lot_size(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_property_type_code(TYPEOF(h.property_type_code) L, TYPEOF(h.property_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_property_type_code(TYPEOF(h.src_property_type_code) L, TYPEOF(h.src_property_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_property_type_code_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_property_type_code_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_property_type_code_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_property_type_code(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_structure_quality(TYPEOF(h.structure_quality) L, TYPEOF(h.structure_quality) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_structure_quality(TYPEOF(h.src_structure_quality) L, TYPEOF(h.src_structure_quality) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_structure_quality_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_structure_quality_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_structure_quality_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_structure_quality(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_water(TYPEOF(h.water) L, TYPEOF(h.water) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_water(TYPEOF(h.src_water) L, TYPEOF(h.src_water) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_water_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_water_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_water_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_water(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_sewer(TYPEOF(h.sewer) L, TYPEOF(h.sewer) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_sewer(TYPEOF(h.src_sewer) L, TYPEOF(h.src_sewer) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_sewer_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_sewer_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_sewer_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_sewer(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_assessed_land_value(TYPEOF(h.assessed_land_value) L, TYPEOF(h.assessed_land_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_assessed_land_value(TYPEOF(h.src_assessed_land_value) L, TYPEOF(h.src_assessed_land_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_assessed_land_value_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_assessed_land_value_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_assessed_land_value_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_assessed_land_value(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_assessed_year(TYPEOF(h.assessed_year) L, TYPEOF(h.assessed_year) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_assessed_year(TYPEOF(h.src_assessed_year) L, TYPEOF(h.src_assessed_year) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_assessed_year_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_assessed_year_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_assessed_year_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_assessed_year(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_amount(TYPEOF(h.tax_amount) L, TYPEOF(h.tax_amount) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_tax_amount(TYPEOF(h.src_tax_amount) L, TYPEOF(h.src_tax_amount) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_tax_amount_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_tax_amount_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_tax_amount_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_tax_amount(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_year(TYPEOF(h.tax_year) L, TYPEOF(h.tax_year) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_tax_year(TYPEOF(h.src_tax_year) L, TYPEOF(h.src_tax_year) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_market_land_value(TYPEOF(h.market_land_value) L, TYPEOF(h.market_land_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_market_land_value(TYPEOF(h.src_market_land_value) L, TYPEOF(h.src_market_land_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_market_land_value_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_market_land_value_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_market_land_value_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_market_land_value(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_improvement_value(TYPEOF(h.improvement_value) L, TYPEOF(h.improvement_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_improvement_value(TYPEOF(h.src_improvement_value) L, TYPEOF(h.src_improvement_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_improvement_value_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_improvement_value_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_improvement_value_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_improvement_value(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_percent_improved(TYPEOF(h.percent_improved) L, TYPEOF(h.percent_improved) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_percent_improved(TYPEOF(h.src_percent_improved) L, TYPEOF(h.src_percent_improved) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_percent_improved_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_percent_improved_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_percent_improved_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_percent_improved(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_total_assessed_value(TYPEOF(h.total_assessed_value) L, TYPEOF(h.total_assessed_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_total_assessed_value(TYPEOF(h.src_total_assessed_value) L, TYPEOF(h.src_total_assessed_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_total_assessed_value_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_total_assessed_value_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_total_assessed_value_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_total_assessed_value(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_total_calculated_value(TYPEOF(h.total_calculated_value) L, TYPEOF(h.total_calculated_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_total_calculated_value(TYPEOF(h.src_total_calculated_value) L, TYPEOF(h.src_total_calculated_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_total_calculated_value_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_total_calculated_value_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_total_calculated_value_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_total_calculated_value(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_total_land_value(TYPEOF(h.total_land_value) L, TYPEOF(h.total_land_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_total_land_value(TYPEOF(h.src_total_land_value) L, TYPEOF(h.src_total_land_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_total_land_value_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_total_land_value_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_total_land_value_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_total_land_value(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_total_market_value(TYPEOF(h.total_market_value) L, TYPEOF(h.total_market_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_total_market_value(TYPEOF(h.src_total_market_value) L, TYPEOF(h.src_total_market_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_total_market_value_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_total_market_value_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_total_market_value_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_total_market_value(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_floor_type(TYPEOF(h.floor_type) L, TYPEOF(h.floor_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_floor_type(TYPEOF(h.src_floor_type) L, TYPEOF(h.src_floor_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_floor_type_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_floor_type_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_floor_type_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_floor_type(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_frame_type(TYPEOF(h.frame_type) L, TYPEOF(h.frame_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_frame_type(TYPEOF(h.src_frame_type) L, TYPEOF(h.src_frame_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_frame_type_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_frame_type_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_frame_type_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_frame_type(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_fuel_type(TYPEOF(h.fuel_type) L, TYPEOF(h.fuel_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_fuel_type(TYPEOF(h.src_fuel_type) L, TYPEOF(h.src_fuel_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_fuel_type_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_fuel_type_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_fuel_type_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_fuel_type(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_no_of_bath_fixtures(TYPEOF(h.no_of_bath_fixtures) L, TYPEOF(h.no_of_bath_fixtures) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_no_of_bath_fixtures(TYPEOF(h.src_no_of_bath_fixtures) L, TYPEOF(h.src_no_of_bath_fixtures) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_no_of_bath_fixtures_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_bath_fixtures_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_bath_fixtures_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_bath_fixtures(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_no_of_rooms(TYPEOF(h.no_of_rooms) L, TYPEOF(h.no_of_rooms) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_no_of_rooms(TYPEOF(h.src_no_of_rooms) L, TYPEOF(h.src_no_of_rooms) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_no_of_rooms_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_rooms_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_rooms_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_rooms(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_no_of_units(TYPEOF(h.no_of_units) L, TYPEOF(h.no_of_units) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_no_of_units(TYPEOF(h.src_no_of_units) L, TYPEOF(h.src_no_of_units) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_no_of_units_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_units_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_units_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_no_of_units(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_style_type(TYPEOF(h.style_type) L, TYPEOF(h.style_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_style_type(TYPEOF(h.src_style_type) L, TYPEOF(h.src_style_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_style_type_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_style_type_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_style_type_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_style_type(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_assessment_document_number(TYPEOF(h.assessment_document_number) L, TYPEOF(h.assessment_document_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_assessment_document_number(TYPEOF(h.src_assessment_document_number) L, TYPEOF(h.src_assessment_document_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_assessment_document_number_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_assessment_document_number_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_assessment_document_number_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_assessment_document_number(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_assessment_recording_date_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_assessment_recording_date_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_assessment_recording_date_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_assessment_recording_date(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_src_assessment_recording_date(TYPEOF(h.src_assessment_recording_date) L, TYPEOF(h.src_assessment_recording_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_tax_dt_assessment_recording_date_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_assessment_recording_date_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_assessment_recording_date_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_tax_dt_assessment_recording_date(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_deed_document_number(TYPEOF(h.deed_document_number) L, TYPEOF(h.deed_document_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_deed_document_number(TYPEOF(h.src_deed_document_number) L, TYPEOF(h.src_deed_document_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_rec_dt_deed_document_number_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_deed_document_number_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_deed_document_number_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_deed_document_number(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_deed_recording_date_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_deed_recording_date_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_deed_recording_date_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_deed_recording_date(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_src_deed_recording_date(TYPEOF(h.src_deed_recording_date) L, TYPEOF(h.src_deed_recording_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_full_part_sale(TYPEOF(h.full_part_sale) L, TYPEOF(h.full_part_sale) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_full_part_sale(TYPEOF(h.src_full_part_sale) L, TYPEOF(h.src_full_part_sale) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_rec_dt_full_part_sale_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_full_part_sale_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_full_part_sale_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_full_part_sale(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_sale_amount(TYPEOF(h.sale_amount) L, TYPEOF(h.sale_amount) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_sale_amount(TYPEOF(h.src_sale_amount) L, TYPEOF(h.src_sale_amount) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_rec_dt_sale_amount_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_sale_amount_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_sale_amount_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_sale_amount(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_sale_date_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_sale_date_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_sale_date_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_sale_date(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_src_sale_date(TYPEOF(h.src_sale_date) L, TYPEOF(h.src_sale_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_rec_dt_sale_date_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_sale_date_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_sale_date_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_sale_date(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_sale_type_code(TYPEOF(h.sale_type_code) L, TYPEOF(h.sale_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_sale_type_code(TYPEOF(h.src_sale_type_code) L, TYPEOF(h.src_sale_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_rec_dt_sale_type_code_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_sale_type_code_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_sale_type_code_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_sale_type_code(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_mortgage_company_name(TYPEOF(h.mortgage_company_name) L, TYPEOF(h.mortgage_company_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_mortgage_company_name(TYPEOF(h.src_mortgage_company_name) L, TYPEOF(h.src_mortgage_company_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_rec_dt_mortgage_company_name_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_mortgage_company_name_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_mortgage_company_name_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_mortgage_company_name(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_loan_amount(TYPEOF(h.loan_amount) L, TYPEOF(h.loan_amount) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_loan_amount(TYPEOF(h.src_loan_amount) L, TYPEOF(h.src_loan_amount) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_rec_dt_loan_amount_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_loan_amount_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_loan_amount_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_loan_amount(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_second_loan_amount(TYPEOF(h.second_loan_amount) L, TYPEOF(h.second_loan_amount) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_second_loan_amount(TYPEOF(h.src_second_loan_amount) L, TYPEOF(h.src_second_loan_amount) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_rec_dt_second_loan_amount_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_second_loan_amount_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_second_loan_amount_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_second_loan_amount(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_loan_type_code(TYPEOF(h.loan_type_code) L, TYPEOF(h.loan_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_loan_type_code(TYPEOF(h.src_loan_type_code) L, TYPEOF(h.src_loan_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_rec_dt_loan_type_code_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_loan_type_code_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_loan_type_code_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_loan_type_code(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_interest_rate_type_code(TYPEOF(h.interest_rate_type_code) L, TYPEOF(h.interest_rate_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_src_interest_rate_type_code(TYPEOF(h.src_interest_rate_type_code) L, TYPEOF(h.src_interest_rate_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT32.MatchCode.ExactMatch,
    SALT32.MatchCode.NoMatch),
  MAP(L = R => SALT32.MatchCode.ExactMatch, SALT32.MatchCode.NoMatch)
);
EXPORT match_rec_dt_interest_rate_type_code_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT32.MatchCode.ExactMatch,
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_interest_rate_type_code_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT32.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_interest_rate_type_code_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
EXPORT match_rec_dt_interest_rate_type_code(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT32.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT32.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT32.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT32.MatchCode.NoMatch);
END;


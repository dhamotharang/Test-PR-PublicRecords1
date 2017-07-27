//*****************************************************************************
// Normalize Officer/Contacts from Corp4 Temp file to Corp Contacts Base format
//*****************************************************************************

STRING350 CheckRegAgentName(STRING350 name) :=
  MAP((INTEGER)((Datalib.NameClean(name))[142]) <= 5 => name,
      '');

Corporate.Layout_Corp_Contacts_Base NormalizeCorpContacts(Corporate.Layout_Corp4_Temp L, INTEGER CTR) := TRANSFORM
SELF.state_origin := L.state_origin;
SELF.sos_ter_nbr := L.sos_charter_nbr;
SELF.officer_name := CHOOSE(CTR, L.officer1_name, L.officer2_name, L.officer3_name, L.officer4_name, L.officer5_name, CheckRegAgentName(L.orig_reg_agent_name));
SELF.officer_title := CHOOSE(CTR, L.officer1_title, L.officer2_title, L.officer3_title, L.officer4_title, L.officer5_title, 'HA');
SELF.officer_street := CHOOSE(CTR, L.officer1_street, L.officer2_street, L.officer3_street, L.officer4_street, L.officer5_street, L.orig_reg_agent_street);
SELF.officer_city := CHOOSE(CTR, L.officer1_city, L.officer2_city, L.officer3_city, L.officer4_city, L.officer5_city, L.orig_reg_agent_city);
SELF.officer_state := CHOOSE(CTR, L.officer1_state, L.officer2_state, L.officer3_state, L.officer4_state, L.officer5_state, L.orig_reg_agent_state);
SELF.officer_zip := CHOOSE(CTR, L.officer1_zip, L.officer2_zip, L.officer3_zip, L.officer4_zip, L.officer5_zip, L.orig_reg_agent_zip5);
SELF.abbrev_legal_name := L.abbrev_legal_name;
SELF.extract_date := L.extract_date;
SELF.title := CHOOSE(CTR, L.o1_title, L.o2_title, L.o3_title, L.o4_title, L.o5_title, L.o6_title);
SELF.fname := CHOOSE(CTR, L.o1_fname, L.o2_fname, L.o3_fname, L.o4_fname, L.o5_fname, L.o6_fname);
SELF.mname := CHOOSE(CTR, L.o1_mname, L.o2_mname, L.o3_mname, L.o4_mname, L.o5_mname, L.o6_mname);
SELF.lname := CHOOSE(CTR, L.o1_lname, L.o2_lname, L.o3_lname, L.o4_lname, L.o5_lname, L.o6_lname);
SELF.name_suffix := CHOOSE(CTR, L.o1_name_suffix, L.o2_name_suffix, L.o3_name_suffix, L.o4_name_suffix, L.o5_name_suffix, L.o6_name_suffix);
SELF.score := CHOOSE(CTR, L.o1_score, L.o2_score, L.o3_score, L.o4_score, L.o5_score, L.o6_score);
SELF.addr_suffix_flag := CHOOSE(CTR, L.o1_addr_suffix_flag, L.o2_addr_suffix_flag, L.o3_addr_suffix_flag, L.o4_addr_suffix_flag, L.o5_addr_suffix_flag, L.o6_addr_suffix_flag);
SELF.prim_range := CHOOSE(CTR, L.o1_prim_range, L.o2_prim_range, L.o3_prim_range, L.o4_prim_range, L.o5_prim_range, L.o6_prim_range);
SELF.predir := CHOOSE(CTR, L.o1_predir, L.o2_predir, L.o3_predir, L.o4_predir, L.o5_predir, L.o6_predir);
SELF.prim_name := CHOOSE(CTR, L.o1_prim_name, L.o2_prim_name, L.o3_prim_name, L.o4_prim_name, L.o5_prim_name, L.o6_prim_name);
SELF.addr_suffix := CHOOSE(CTR, L.o1_addr_suffix, L.o2_addr_suffix, L.o3_addr_suffix, L.o4_addr_suffix, L.o5_addr_suffix, L.o6_addr_suffix);
SELF.postdir := CHOOSE(CTR, L.o1_postdir, L.o2_postdir, L.o3_postdir, L.o4_postdir, L.o5_postdir, L.o6_postdir);
SELF.unit_desig := CHOOSE(CTR, L.o1_unit_desig, L.o2_unit_desig, L.o3_unit_desig, L.o4_unit_desig, L.o5_unit_desig, L.o6_unit_desig);
SELF.sec_range := CHOOSE(CTR, L.o1_sec_range, L.o2_sec_range, L.o3_sec_range, L.o4_sec_range, L.o5_sec_range, L.o6_sec_range);
SELF.p_city_name := CHOOSE(CTR, L.o1_p_city_name, L.o2_p_city_name, L.o3_p_city_name, L.o4_p_city_name, L.o5_p_city_name, L.o6_p_city_name);
SELF.v_city_name := CHOOSE(CTR, L.o1_v_city_name, L.o2_v_city_name, L.o3_v_city_name, L.o4_v_city_name, L.o5_v_city_name, L.o6_v_city_name);
SELF.state := CHOOSE(CTR, L.o1_state, L.o2_state, L.o3_state, L.o4_state, L.o5_state, L.o6_state);
SELF.zip5 := CHOOSE(CTR, L.o1_zip5, L.o2_zip5, L.o3_zip5, L.o4_zip5, L.o5_zip5, L.o6_zip5);
SELF.zip4 := CHOOSE(CTR, L.o1_zip4, L.o2_zip4, L.o3_zip4, L.o4_zip4, L.o5_zip4, L.o6_zip4);
SELF.cart := CHOOSE(CTR, L.o1_cart, L.o2_cart, L.o3_cart, L.o4_cart, L.o5_cart, L.o6_cart);
SELF.cr_sort_sz := CHOOSE(CTR, L.o1_cr_sort_sz, L.o2_cr_sort_sz, L.o3_cr_sort_sz, L.o4_cr_sort_sz, L.o5_cr_sort_sz, L.o6_cr_sort_sz);
SELF.lot := CHOOSE(CTR, L.o1_lot, L.o2_lot, L.o3_lot, L.o4_lot, L.o5_lot, L.o6_lot);
SELF.lot_order := CHOOSE(CTR, L.o1_lot_order, L.o2_lot_order, L.o3_lot_order, L.o4_lot_order, L.o5_lot_order, L.o6_lot_order);
SELF.dpbc := CHOOSE(CTR, L.o1_dpbc, L.o2_dpbc, L.o3_dpbc, L.o4_dpbc, L.o5_dpbc, L.o6_dpbc);
SELF.chk_digit := CHOOSE(CTR, L.o1_chk_digit, L.o2_chk_digit, L.o3_chk_digit, L.o4_chk_digit, L.o5_chk_digit, L.o6_chk_digit);
SELF.rec_type := CHOOSE(CTR, L.o1_rec_type, L.o2_rec_type, L.o3_rec_type, L.o4_rec_type, L.o5_rec_type, L.o6_rec_type);
SELF.ace_fips_st := CHOOSE(CTR, L.o1_ace_fips_st, L.o2_ace_fips_st, L.o3_ace_fips_st, L.o4_ace_fips_st, L.o5_ace_fips_st, L.o6_ace_fips_st);
SELF.county := CHOOSE(CTR, L.o1_county, L.o2_county, L.o3_county, L.o4_county, L.o5_county, L.o6_county);
SELF.geo_lat := CHOOSE(CTR, L.o1_geo_lat, L.o2_geo_lat, L.o3_geo_lat, L.o4_geo_lat, L.o5_geo_lat, L.o6_geo_lat);
SELF.geo_long := CHOOSE(CTR, L.o1_geo_long, L.o2_geo_long, L.o3_geo_long, L.o4_geo_long, L.o5_geo_long, L.o6_geo_long);
SELF.msa := CHOOSE(CTR, L.o1_msa, L.o2_msa, L.o3_msa, L.o4_msa, L.o5_msa, L.o6_msa);
SELF.geo_blk := CHOOSE(CTR, L.o1_geo_blk, L.o2_geo_blk, L.o3_geo_blk, L.o4_geo_blk, L.o5_geo_blk, L.o6_geo_blk);
SELF.geo_match := CHOOSE(CTR, L.o1_geo_match, L.o2_geo_match, L.o3_geo_match, L.o4_geo_match, L.o5_geo_match, L.o6_geo_match);
SELF.err_stat := CHOOSE(CTR, L.o1_err_stat, L.o2_err_stat, L.o3_err_stat, L.o4_err_stat, L.o5_err_stat, L.o6_err_stat);
SELF.dt_first_seen := L.dt_first_seen;  // YYYYMMDD
SELF.dt_last_seen := L.dt_last_seen;   // YYYYMMDD
SELF.record_type := L.record_type;
END;

Corp4_Contacts_Base_Norm := NORMALIZE(Corporate.Corp4_Temp, 6, NormalizeCorpContacts(LEFT, COUNTER));
COUNT(Corp4_Contacts_Base_Norm);

Corp4_Contacts_Base_Init := Corp4_Contacts_Base_Norm(officer_name <> '');
COUNT(Corp4_Contacts_Base_Init);

//************************************************************
// Rollup Contacts to set Date First Seen and Last Seen
//************************************************************

// Date First Seen and Date Last Seen have been initialized to Extract Date
Corporate.Layout_Corp_Contacts_Base RollupCorpContacts(Corporate.Layout_Corp_Contacts_Base L, Corporate.Layout_Corp_Contacts_Base R) := TRANSFORM
SELF.dt_first_seen := IF(L.dt_first_seen < R.dt_first_seen, L.dt_first_seen, R.dt_first_seen);
SELF := L;
END;

Corp4_Contacts_Base_Init_Dist := DISTRIBUTE(Corp4_Contacts_Base_Init, HASH(state_origin, sos_ter_nbr));
Corp4_Contacts_Base_Init_Sort := SORT(Corp4_Contacts_Base_Init_Dist, state_origin, sos_ter_nbr, officer_title,
                               lname, DataLib.PreferredFirst(fname), mname, name_suffix,
                               zip5, prim_name, prim_range, sec_range, -dt_last_seen, LOCAL);
Corp4_Contacts_Base_Init_Rollup := ROLLUP(Corp4_Contacts_Base_Init_Sort,
                                          LEFT.state_origin = RIGHT.state_origin AND
                                            LEFT.sos_ter_nbr = RIGHT.sos_ter_nbr AND
                                            LEFT.officer_title = RIGHT.officer_title AND
                                            LEFT.lname = RIGHT.lname AND
                                            DataLib.PreferredFirst(LEFT.fname) = DataLib.PreferredFirst(RIGHT.fname) AND
                                            LEFT.mname = RIGHT.mname AND
                                            LEFT.name_suffix = RIGHT.name_suffix AND
                                            LEFT.zip5 = RIGHT.zip5 AND
                                            LEFT.prim_name = RIGHT.prim_name AND
                                            LEFT.prim_range = RIGHT.prim_range AND
                                            LEFT.sec_range = RIGHT.sec_range,
                                          RollupCorpContacts(LEFT, RIGHT),
                                          LOCAL);

COUNT(Corp4_Contacts_Base_Init_Rollup);

//************************************************************
// Group and Iterate to Set Current/Historical Indicator
//************************************************************

// Record Type has been initialized to historical 'H'
Corp4_Contacts_Rollup_Sort := SORT(Corp4_Contacts_Base_Init_Rollup, state_origin, sos_ter_nbr, LOCAL);
Corp4_Contacts_Rollup_Grpd := GROUP(Corp4_Contacts_Rollup_Sort, state_origin, sos_ter_nbr, LOCAL);
Corp4_Contacts_Rollup_Grpd_Sort := SORT(Corp4_Contacts_Rollup_Grpd, -dt_last_seen);

Corporate.Layout_Corp_Contacts_Base SetRecordType(Corporate.Layout_Corp_Contacts_Base L, Corporate.Layout_Corp_Contacts_Base R) := TRANSFORM
SELF.record_type := MAP(L.record_type = '' => 'C',
                        L.record_type = 'C' AND L.dt_last_seen = R.dt_last_seen => 'C',
                        R.record_type);
// Check for contact name as person or business, if not person, set lname
// to first part of officer_name and blank other clean name fields
SELF.title :=   MAP((INTEGER)((Datalib.NameClean(R.officer_name))[142]) <= 5 => R.title,
                     '');
SELF.fname :=   MAP((INTEGER)((Datalib.NameClean(R.officer_name))[142]) <= 5 => R.fname,
                     '');
SELF.mname :=   MAP((INTEGER)((Datalib.NameClean(R.officer_name))[142]) <= 5 => R.mname,
                     '');
SELF.lname :=   MAP((INTEGER)((Datalib.NameClean(R.officer_name))[142]) <= 5 => R.lname,
                     R.officer_name);
SELF.name_suffix :=   MAP((INTEGER)((Datalib.NameClean(R.officer_name))[142]) <= 5 => R.name_suffix,
                     '');
SELF.score :=   MAP((INTEGER)((Datalib.NameClean(R.officer_name))[142]) <= 5 => R.score,
                     '');
SELF := R;
END;

Corp4_Contacts_Base := GROUP(ITERATE(Corp4_Contacts_Rollup_Grpd_Sort, SetRecordType(LEFT, RIGHT)));
COUNT(Corp4_Contacts_Base);

EXPORT Corp4_Contacts_Temp := Corp4_Contacts_Base : PERSIST('TEMP::Corp4_Contacts');
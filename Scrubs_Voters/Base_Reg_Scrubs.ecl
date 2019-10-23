IMPORT SALT39,STD;
IMPORT Scrubs_Voters; // Import modules for FieldTypes attribute definitions
EXPORT Base_Reg_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 94;
  EXPORT NumRulesFromFieldType := 94;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 94;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_Reg_Layout_Voters)
    UNSIGNED1 rid_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 vtid_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 source_Invalid;
    UNSIGNED1 file_id_Invalid;
    UNSIGNED1 vendor_id_Invalid;
    UNSIGNED1 source_state_Invalid;
    UNSIGNED1 file_acquired_date_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 middle_name_Invalid;
    UNSIGNED1 source_voterid_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 agecat_Invalid;
    UNSIGNED1 agecat_exp_Invalid;
    UNSIGNED1 regdate_Invalid;
    UNSIGNED1 race_Invalid;
    UNSIGNED1 race_exp_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 political_party_Invalid;
    UNSIGNED1 politicalparty_exp_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 work_phone_Invalid;
    UNSIGNED1 other_phone_Invalid;
    UNSIGNED1 active_status_Invalid;
    UNSIGNED1 active_status_exp_Invalid;
    UNSIGNED1 gendersurnamguess_Invalid;
    UNSIGNED1 active_other_Invalid;
    UNSIGNED1 voter_status_Invalid;
    UNSIGNED1 voter_status_exp_Invalid;
    UNSIGNED1 timezonetbl_Invalid;
    UNSIGNED1 distcode_Invalid;
    UNSIGNED1 countycode_Invalid;
    UNSIGNED1 schoolcode_Invalid;
    UNSIGNED1 statehouse_Invalid;
    UNSIGNED1 statesenate_Invalid;
    UNSIGNED1 ushouse_Invalid;
    UNSIGNED1 lastdatevote_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 cart_Invalid;
    UNSIGNED1 cr_sort_sz_Invalid;
    UNSIGNED1 lot_Invalid;
    UNSIGNED1 lot_order_Invalid;
    UNSIGNED1 dpbc_Invalid;
    UNSIGNED1 chk_digit_Invalid;
    UNSIGNED1 rec_type_Invalid;
    UNSIGNED1 ace_fips_st_Invalid;
    UNSIGNED1 fips_county_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 geo_blk_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
    UNSIGNED1 mail_predir_Invalid;
    UNSIGNED1 mail_prim_name_Invalid;
    UNSIGNED1 mail_postdir_Invalid;
    UNSIGNED1 mail_p_city_name_Invalid;
    UNSIGNED1 mail_v_city_name_Invalid;
    UNSIGNED1 mail_st_Invalid;
    UNSIGNED1 mail_ace_zip_Invalid;
    UNSIGNED1 mail_zip4_Invalid;
    UNSIGNED1 mail_cart_Invalid;
    UNSIGNED1 mail_cr_sort_sz_Invalid;
    UNSIGNED1 mail_lot_Invalid;
    UNSIGNED1 mail_lot_order_Invalid;
    UNSIGNED1 mail_dpbc_Invalid;
    UNSIGNED1 mail_chk_digit_Invalid;
    UNSIGNED1 mail_rec_type_Invalid;
    UNSIGNED1 mail_ace_fips_st_Invalid;
    UNSIGNED1 mail_fips_county_Invalid;
    UNSIGNED1 mail_geo_lat_Invalid;
    UNSIGNED1 mail_geo_long_Invalid;
    UNSIGNED1 mail_msa_Invalid;
    UNSIGNED1 mail_geo_blk_Invalid;
    UNSIGNED1 mail_geo_match_Invalid;
    UNSIGNED1 mail_err_stat_Invalid;
    UNSIGNED1 marriedappend_Invalid;
    UNSIGNED1 changedate_Invalid;
    UNSIGNED1 name_type_Invalid;
    UNSIGNED1 addr_type_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Reg_Layout_Voters)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Base_Reg_Layout_Voters) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.rid_Invalid := Base_Reg_Fields.InValid_rid((SALT39.StrType)le.rid);
    SELF.did_Invalid := Base_Reg_Fields.InValid_did((SALT39.StrType)le.did);
    SELF.did_score_Invalid := Base_Reg_Fields.InValid_did_score((SALT39.StrType)le.did_score);
    SELF.ssn_Invalid := Base_Reg_Fields.InValid_ssn((SALT39.StrType)le.ssn);
    SELF.vtid_Invalid := Base_Reg_Fields.InValid_vtid((SALT39.StrType)le.vtid);
    SELF.process_date_Invalid := Base_Reg_Fields.InValid_process_date((SALT39.StrType)le.process_date);
    SELF.date_first_seen_Invalid := Base_Reg_Fields.InValid_date_first_seen((SALT39.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Base_Reg_Fields.InValid_date_last_seen((SALT39.StrType)le.date_last_seen);
    SELF.source_Invalid := Base_Reg_Fields.InValid_source((SALT39.StrType)le.source);
    SELF.file_id_Invalid := Base_Reg_Fields.InValid_file_id((SALT39.StrType)le.file_id);
    SELF.vendor_id_Invalid := Base_Reg_Fields.InValid_vendor_id((SALT39.StrType)le.vendor_id);
    SELF.source_state_Invalid := Base_Reg_Fields.InValid_source_state((SALT39.StrType)le.source_state);
    SELF.file_acquired_date_Invalid := Base_Reg_Fields.InValid_file_acquired_date((SALT39.StrType)le.file_acquired_date);
    SELF.last_name_Invalid := Base_Reg_Fields.InValid_last_name((SALT39.StrType)le.last_name,(SALT39.StrType)le.first_name,(SALT39.StrType)le.middle_name);
    SELF.first_name_Invalid := Base_Reg_Fields.InValid_first_name((SALT39.StrType)le.first_name);
    SELF.middle_name_Invalid := Base_Reg_Fields.InValid_middle_name((SALT39.StrType)le.middle_name);
    SELF.source_voterid_Invalid := Base_Reg_Fields.InValid_source_voterid((SALT39.StrType)le.source_voterid);
    SELF.dob_Invalid := Base_Reg_Fields.InValid_dob((SALT39.StrType)le.dob);
    SELF.agecat_Invalid := Base_Reg_Fields.InValid_agecat((SALT39.StrType)le.agecat);
    SELF.agecat_exp_Invalid := Base_Reg_Fields.InValid_agecat_exp((SALT39.StrType)le.agecat_exp,(SALT39.StrType)le.agecat);
    SELF.regdate_Invalid := Base_Reg_Fields.InValid_regdate((SALT39.StrType)le.regdate);
    SELF.race_Invalid := Base_Reg_Fields.InValid_race((SALT39.StrType)le.race);
    SELF.race_exp_Invalid := Base_Reg_Fields.InValid_race_exp((SALT39.StrType)le.race_exp,(SALT39.StrType)le.race);
    SELF.gender_Invalid := Base_Reg_Fields.InValid_gender((SALT39.StrType)le.gender);
    SELF.political_party_Invalid := Base_Reg_Fields.InValid_political_party((SALT39.StrType)le.political_party,(SALT39.StrType)le.politicalparty_exp);
    SELF.politicalparty_exp_Invalid := Base_Reg_Fields.InValid_politicalparty_exp((SALT39.StrType)le.politicalparty_exp);
    SELF.phone_Invalid := Base_Reg_Fields.InValid_phone((SALT39.StrType)le.phone);
    SELF.work_phone_Invalid := Base_Reg_Fields.InValid_work_phone((SALT39.StrType)le.work_phone);
    SELF.other_phone_Invalid := Base_Reg_Fields.InValid_other_phone((SALT39.StrType)le.other_phone);
    SELF.active_status_Invalid := Base_Reg_Fields.InValid_active_status((SALT39.StrType)le.active_status);
    SELF.active_status_exp_Invalid := Base_Reg_Fields.InValid_active_status_exp((SALT39.StrType)le.active_status_exp);
    SELF.gendersurnamguess_Invalid := Base_Reg_Fields.InValid_gendersurnamguess((SALT39.StrType)le.gendersurnamguess);
    SELF.active_other_Invalid := Base_Reg_Fields.InValid_active_other((SALT39.StrType)le.active_other);
    SELF.voter_status_Invalid := Base_Reg_Fields.InValid_voter_status((SALT39.StrType)le.voter_status);
    SELF.voter_status_exp_Invalid := Base_Reg_Fields.InValid_voter_status_exp((SALT39.StrType)le.voter_status_exp);
    SELF.timezonetbl_Invalid := Base_Reg_Fields.InValid_timezonetbl((SALT39.StrType)le.timezonetbl);
    SELF.distcode_Invalid := Base_Reg_Fields.InValid_distcode((SALT39.StrType)le.distcode);
    SELF.countycode_Invalid := Base_Reg_Fields.InValid_countycode((SALT39.StrType)le.countycode);
    SELF.schoolcode_Invalid := Base_Reg_Fields.InValid_schoolcode((SALT39.StrType)le.schoolcode);
    SELF.statehouse_Invalid := Base_Reg_Fields.InValid_statehouse((SALT39.StrType)le.statehouse);
    SELF.statesenate_Invalid := Base_Reg_Fields.InValid_statesenate((SALT39.StrType)le.statesenate);
    SELF.ushouse_Invalid := Base_Reg_Fields.InValid_ushouse((SALT39.StrType)le.ushouse);
    SELF.lastdatevote_Invalid := Base_Reg_Fields.InValid_lastdatevote((SALT39.StrType)le.lastdatevote);
    SELF.fname_Invalid := Base_Reg_Fields.InValid_fname((SALT39.StrType)le.fname,(SALT39.StrType)le.mname,(SALT39.StrType)le.lname);
    SELF.predir_Invalid := Base_Reg_Fields.InValid_predir((SALT39.StrType)le.predir);
    SELF.prim_name_Invalid := Base_Reg_Fields.InValid_prim_name((SALT39.StrType)le.prim_name);
    SELF.postdir_Invalid := Base_Reg_Fields.InValid_postdir((SALT39.StrType)le.postdir);
    SELF.p_city_name_Invalid := Base_Reg_Fields.InValid_p_city_name((SALT39.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Base_Reg_Fields.InValid_v_city_name((SALT39.StrType)le.v_city_name);
    SELF.st_Invalid := Base_Reg_Fields.InValid_st((SALT39.StrType)le.st);
    SELF.zip_Invalid := Base_Reg_Fields.InValid_zip((SALT39.StrType)le.zip);
    SELF.zip4_Invalid := Base_Reg_Fields.InValid_zip4((SALT39.StrType)le.zip4);
    SELF.cart_Invalid := Base_Reg_Fields.InValid_cart((SALT39.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := Base_Reg_Fields.InValid_cr_sort_sz((SALT39.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := Base_Reg_Fields.InValid_lot((SALT39.StrType)le.lot);
    SELF.lot_order_Invalid := Base_Reg_Fields.InValid_lot_order((SALT39.StrType)le.lot_order);
    SELF.dpbc_Invalid := Base_Reg_Fields.InValid_dpbc((SALT39.StrType)le.dpbc);
    SELF.chk_digit_Invalid := Base_Reg_Fields.InValid_chk_digit((SALT39.StrType)le.chk_digit);
    SELF.rec_type_Invalid := Base_Reg_Fields.InValid_rec_type((SALT39.StrType)le.rec_type);
    SELF.ace_fips_st_Invalid := Base_Reg_Fields.InValid_ace_fips_st((SALT39.StrType)le.ace_fips_st);
    SELF.fips_county_Invalid := Base_Reg_Fields.InValid_fips_county((SALT39.StrType)le.fips_county);
    SELF.geo_lat_Invalid := Base_Reg_Fields.InValid_geo_lat((SALT39.StrType)le.geo_lat);
    SELF.geo_long_Invalid := Base_Reg_Fields.InValid_geo_long((SALT39.StrType)le.geo_long);
    SELF.msa_Invalid := Base_Reg_Fields.InValid_msa((SALT39.StrType)le.msa);
    SELF.geo_blk_Invalid := Base_Reg_Fields.InValid_geo_blk((SALT39.StrType)le.geo_blk);
    SELF.geo_match_Invalid := Base_Reg_Fields.InValid_geo_match((SALT39.StrType)le.geo_match);
    SELF.err_stat_Invalid := Base_Reg_Fields.InValid_err_stat((SALT39.StrType)le.err_stat);
    SELF.mail_predir_Invalid := Base_Reg_Fields.InValid_mail_predir((SALT39.StrType)le.mail_predir);
    SELF.mail_prim_name_Invalid := Base_Reg_Fields.InValid_mail_prim_name((SALT39.StrType)le.mail_prim_name);
    SELF.mail_postdir_Invalid := Base_Reg_Fields.InValid_mail_postdir((SALT39.StrType)le.mail_postdir);
    SELF.mail_p_city_name_Invalid := Base_Reg_Fields.InValid_mail_p_city_name((SALT39.StrType)le.mail_p_city_name);
    SELF.mail_v_city_name_Invalid := Base_Reg_Fields.InValid_mail_v_city_name((SALT39.StrType)le.mail_v_city_name);
    SELF.mail_st_Invalid := Base_Reg_Fields.InValid_mail_st((SALT39.StrType)le.mail_st);
    SELF.mail_ace_zip_Invalid := Base_Reg_Fields.InValid_mail_ace_zip((SALT39.StrType)le.mail_ace_zip);
    SELF.mail_zip4_Invalid := Base_Reg_Fields.InValid_mail_zip4((SALT39.StrType)le.mail_zip4);
    SELF.mail_cart_Invalid := Base_Reg_Fields.InValid_mail_cart((SALT39.StrType)le.mail_cart);
    SELF.mail_cr_sort_sz_Invalid := Base_Reg_Fields.InValid_mail_cr_sort_sz((SALT39.StrType)le.mail_cr_sort_sz);
    SELF.mail_lot_Invalid := Base_Reg_Fields.InValid_mail_lot((SALT39.StrType)le.mail_lot);
    SELF.mail_lot_order_Invalid := Base_Reg_Fields.InValid_mail_lot_order((SALT39.StrType)le.mail_lot_order);
    SELF.mail_dpbc_Invalid := Base_Reg_Fields.InValid_mail_dpbc((SALT39.StrType)le.mail_dpbc);
    SELF.mail_chk_digit_Invalid := Base_Reg_Fields.InValid_mail_chk_digit((SALT39.StrType)le.mail_chk_digit);
    SELF.mail_rec_type_Invalid := Base_Reg_Fields.InValid_mail_rec_type((SALT39.StrType)le.mail_rec_type);
    SELF.mail_ace_fips_st_Invalid := Base_Reg_Fields.InValid_mail_ace_fips_st((SALT39.StrType)le.mail_ace_fips_st);
    SELF.mail_fips_county_Invalid := Base_Reg_Fields.InValid_mail_fips_county((SALT39.StrType)le.mail_fips_county);
    SELF.mail_geo_lat_Invalid := Base_Reg_Fields.InValid_mail_geo_lat((SALT39.StrType)le.mail_geo_lat);
    SELF.mail_geo_long_Invalid := Base_Reg_Fields.InValid_mail_geo_long((SALT39.StrType)le.mail_geo_long);
    SELF.mail_msa_Invalid := Base_Reg_Fields.InValid_mail_msa((SALT39.StrType)le.mail_msa);
    SELF.mail_geo_blk_Invalid := Base_Reg_Fields.InValid_mail_geo_blk((SALT39.StrType)le.mail_geo_blk);
    SELF.mail_geo_match_Invalid := Base_Reg_Fields.InValid_mail_geo_match((SALT39.StrType)le.mail_geo_match);
    SELF.mail_err_stat_Invalid := Base_Reg_Fields.InValid_mail_err_stat((SALT39.StrType)le.mail_err_stat);
    SELF.marriedappend_Invalid := Base_Reg_Fields.InValid_marriedappend((SALT39.StrType)le.marriedappend);
    SELF.changedate_Invalid := Base_Reg_Fields.InValid_changedate((SALT39.StrType)le.changedate);
    SELF.name_type_Invalid := Base_Reg_Fields.InValid_name_type((SALT39.StrType)le.name_type);
    SELF.addr_type_Invalid := Base_Reg_Fields.InValid_addr_type((SALT39.StrType)le.addr_type);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Reg_Layout_Voters);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.rid_Invalid << 0 ) + ( le.did_Invalid << 1 ) + ( le.did_score_Invalid << 2 ) + ( le.ssn_Invalid << 3 ) + ( le.vtid_Invalid << 4 ) + ( le.process_date_Invalid << 5 ) + ( le.date_first_seen_Invalid << 6 ) + ( le.date_last_seen_Invalid << 7 ) + ( le.source_Invalid << 8 ) + ( le.file_id_Invalid << 9 ) + ( le.vendor_id_Invalid << 10 ) + ( le.source_state_Invalid << 11 ) + ( le.file_acquired_date_Invalid << 12 ) + ( le.last_name_Invalid << 13 ) + ( le.first_name_Invalid << 14 ) + ( le.middle_name_Invalid << 15 ) + ( le.source_voterid_Invalid << 16 ) + ( le.dob_Invalid << 17 ) + ( le.agecat_Invalid << 18 ) + ( le.agecat_exp_Invalid << 19 ) + ( le.regdate_Invalid << 20 ) + ( le.race_Invalid << 21 ) + ( le.race_exp_Invalid << 22 ) + ( le.gender_Invalid << 23 ) + ( le.political_party_Invalid << 24 ) + ( le.politicalparty_exp_Invalid << 25 ) + ( le.phone_Invalid << 26 ) + ( le.work_phone_Invalid << 27 ) + ( le.other_phone_Invalid << 28 ) + ( le.active_status_Invalid << 29 ) + ( le.active_status_exp_Invalid << 30 ) + ( le.gendersurnamguess_Invalid << 31 ) + ( le.active_other_Invalid << 32 ) + ( le.voter_status_Invalid << 33 ) + ( le.voter_status_exp_Invalid << 34 ) + ( le.timezonetbl_Invalid << 35 ) + ( le.distcode_Invalid << 36 ) + ( le.countycode_Invalid << 37 ) + ( le.schoolcode_Invalid << 38 ) + ( le.statehouse_Invalid << 39 ) + ( le.statesenate_Invalid << 40 ) + ( le.ushouse_Invalid << 41 ) + ( le.lastdatevote_Invalid << 42 ) + ( le.fname_Invalid << 43 ) + ( le.predir_Invalid << 44 ) + ( le.prim_name_Invalid << 45 ) + ( le.postdir_Invalid << 46 ) + ( le.p_city_name_Invalid << 47 ) + ( le.v_city_name_Invalid << 48 ) + ( le.st_Invalid << 49 ) + ( le.zip_Invalid << 50 ) + ( le.zip4_Invalid << 51 ) + ( le.cart_Invalid << 52 ) + ( le.cr_sort_sz_Invalid << 53 ) + ( le.lot_Invalid << 54 ) + ( le.lot_order_Invalid << 55 ) + ( le.dpbc_Invalid << 56 ) + ( le.chk_digit_Invalid << 57 ) + ( le.rec_type_Invalid << 58 ) + ( le.ace_fips_st_Invalid << 59 ) + ( le.fips_county_Invalid << 60 ) + ( le.geo_lat_Invalid << 61 ) + ( le.geo_long_Invalid << 62 ) + ( le.msa_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.geo_blk_Invalid << 0 ) + ( le.geo_match_Invalid << 1 ) + ( le.err_stat_Invalid << 2 ) + ( le.mail_predir_Invalid << 3 ) + ( le.mail_prim_name_Invalid << 4 ) + ( le.mail_postdir_Invalid << 5 ) + ( le.mail_p_city_name_Invalid << 6 ) + ( le.mail_v_city_name_Invalid << 7 ) + ( le.mail_st_Invalid << 8 ) + ( le.mail_ace_zip_Invalid << 9 ) + ( le.mail_zip4_Invalid << 10 ) + ( le.mail_cart_Invalid << 11 ) + ( le.mail_cr_sort_sz_Invalid << 12 ) + ( le.mail_lot_Invalid << 13 ) + ( le.mail_lot_order_Invalid << 14 ) + ( le.mail_dpbc_Invalid << 15 ) + ( le.mail_chk_digit_Invalid << 16 ) + ( le.mail_rec_type_Invalid << 17 ) + ( le.mail_ace_fips_st_Invalid << 18 ) + ( le.mail_fips_county_Invalid << 19 ) + ( le.mail_geo_lat_Invalid << 20 ) + ( le.mail_geo_long_Invalid << 21 ) + ( le.mail_msa_Invalid << 22 ) + ( le.mail_geo_blk_Invalid << 23 ) + ( le.mail_geo_match_Invalid << 24 ) + ( le.mail_err_stat_Invalid << 25 ) + ( le.marriedappend_Invalid << 26 ) + ( le.changedate_Invalid << 27 ) + ( le.name_type_Invalid << 28 ) + ( le.addr_type_Invalid << 29 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Reg_Layout_Voters);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.rid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.did_score_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.vtid_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.source_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.file_id_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.vendor_id_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.source_state_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.file_acquired_date_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.middle_name_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.source_voterid_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.agecat_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.agecat_exp_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.regdate_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.race_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.race_exp_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.political_party_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.politicalparty_exp_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.work_phone_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.other_phone_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.active_status_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.active_status_exp_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.gendersurnamguess_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.active_other_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.voter_status_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.voter_status_exp_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.timezonetbl_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.distcode_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.countycode_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.schoolcode_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.statehouse_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.statesenate_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.ushouse_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.lastdatevote_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.cart_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.lot_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.lot_order_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.dpbc_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.chk_digit_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.rec_type_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.ace_fips_st_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.fips_county_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.msa_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.geo_blk_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.geo_match_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.err_stat_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.mail_predir_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.mail_prim_name_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.mail_postdir_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.mail_p_city_name_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.mail_v_city_name_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.mail_st_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.mail_ace_zip_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.mail_zip4_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.mail_cart_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.mail_cr_sort_sz_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.mail_lot_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.mail_lot_order_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.mail_dpbc_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.mail_chk_digit_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.mail_rec_type_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.mail_ace_fips_st_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.mail_fips_county_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.mail_geo_lat_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.mail_geo_long_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.mail_msa_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.mail_geo_blk_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.mail_geo_match_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.mail_err_stat_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.marriedappend_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.changedate_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.name_type_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.addr_type_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    rid_CUSTOM_ErrorCount := COUNT(GROUP,h.rid_Invalid=1);
    did_CUSTOM_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_score_CUSTOM_ErrorCount := COUNT(GROUP,h.did_score_Invalid=1);
    ssn_CUSTOM_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    vtid_CUSTOM_ErrorCount := COUNT(GROUP,h.vtid_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    source_ENUM_ErrorCount := COUNT(GROUP,h.source_Invalid=1);
    file_id_ENUM_ErrorCount := COUNT(GROUP,h.file_id_Invalid=1);
    vendor_id_CUSTOM_ErrorCount := COUNT(GROUP,h.vendor_id_Invalid=1);
    source_state_CUSTOM_ErrorCount := COUNT(GROUP,h.source_state_Invalid=1);
    file_acquired_date_CUSTOM_ErrorCount := COUNT(GROUP,h.file_acquired_date_Invalid=1);
    last_name_CUSTOM_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    first_name_ALLOW_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    middle_name_ALLOW_ErrorCount := COUNT(GROUP,h.middle_name_Invalid=1);
    source_voterid_CUSTOM_ErrorCount := COUNT(GROUP,h.source_voterid_Invalid=1);
    dob_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    agecat_CUSTOM_ErrorCount := COUNT(GROUP,h.agecat_Invalid=1);
    agecat_exp_CUSTOM_ErrorCount := COUNT(GROUP,h.agecat_exp_Invalid=1);
    regdate_CUSTOM_ErrorCount := COUNT(GROUP,h.regdate_Invalid=1);
    race_CUSTOM_ErrorCount := COUNT(GROUP,h.race_Invalid=1);
    race_exp_CUSTOM_ErrorCount := COUNT(GROUP,h.race_exp_Invalid=1);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    political_party_CUSTOM_ErrorCount := COUNT(GROUP,h.political_party_Invalid=1);
    politicalparty_exp_CUSTOM_ErrorCount := COUNT(GROUP,h.politicalparty_exp_Invalid=1);
    phone_CUSTOM_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    work_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.work_phone_Invalid=1);
    other_phone_ALLOW_ErrorCount := COUNT(GROUP,h.other_phone_Invalid=1);
    active_status_ALLOW_ErrorCount := COUNT(GROUP,h.active_status_Invalid=1);
    active_status_exp_ENUM_ErrorCount := COUNT(GROUP,h.active_status_exp_Invalid=1);
    gendersurnamguess_ALLOW_ErrorCount := COUNT(GROUP,h.gendersurnamguess_Invalid=1);
    active_other_ALLOW_ErrorCount := COUNT(GROUP,h.active_other_Invalid=1);
    voter_status_ALLOW_ErrorCount := COUNT(GROUP,h.voter_status_Invalid=1);
    voter_status_exp_CUSTOM_ErrorCount := COUNT(GROUP,h.voter_status_exp_Invalid=1);
    timezonetbl_ALLOW_ErrorCount := COUNT(GROUP,h.timezonetbl_Invalid=1);
    distcode_ALLOW_ErrorCount := COUNT(GROUP,h.distcode_Invalid=1);
    countycode_ALLOW_ErrorCount := COUNT(GROUP,h.countycode_Invalid=1);
    schoolcode_ALLOW_ErrorCount := COUNT(GROUP,h.schoolcode_Invalid=1);
    statehouse_ALLOW_ErrorCount := COUNT(GROUP,h.statehouse_Invalid=1);
    statesenate_ALLOW_ErrorCount := COUNT(GROUP,h.statesenate_Invalid=1);
    ushouse_ALLOW_ErrorCount := COUNT(GROUP,h.ushouse_Invalid=1);
    lastdatevote_CUSTOM_ErrorCount := COUNT(GROUP,h.lastdatevote_Invalid=1);
    fname_CUSTOM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    p_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    st_CUSTOM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    cart_CUSTOM_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cr_sort_sz_ENUM_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    lot_CUSTOM_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_order_ENUM_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    dpbc_CUSTOM_ErrorCount := COUNT(GROUP,h.dpbc_Invalid=1);
    chk_digit_CUSTOM_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    rec_type_CUSTOM_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    ace_fips_st_CUSTOM_ErrorCount := COUNT(GROUP,h.ace_fips_st_Invalid=1);
    fips_county_CUSTOM_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=1);
    geo_lat_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_long_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    msa_CUSTOM_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    geo_blk_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_match_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    err_stat_CUSTOM_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    mail_predir_ALLOW_ErrorCount := COUNT(GROUP,h.mail_predir_Invalid=1);
    mail_prim_name_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_prim_name_Invalid=1);
    mail_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.mail_postdir_Invalid=1);
    mail_p_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_p_city_name_Invalid=1);
    mail_v_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_v_city_name_Invalid=1);
    mail_st_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_st_Invalid=1);
    mail_ace_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_ace_zip_Invalid=1);
    mail_zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_zip4_Invalid=1);
    mail_cart_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_cart_Invalid=1);
    mail_cr_sort_sz_ENUM_ErrorCount := COUNT(GROUP,h.mail_cr_sort_sz_Invalid=1);
    mail_lot_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_lot_Invalid=1);
    mail_lot_order_ENUM_ErrorCount := COUNT(GROUP,h.mail_lot_order_Invalid=1);
    mail_dpbc_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_dpbc_Invalid=1);
    mail_chk_digit_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_chk_digit_Invalid=1);
    mail_rec_type_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_rec_type_Invalid=1);
    mail_ace_fips_st_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_ace_fips_st_Invalid=1);
    mail_fips_county_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_fips_county_Invalid=1);
    mail_geo_lat_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_geo_lat_Invalid=1);
    mail_geo_long_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_geo_long_Invalid=1);
    mail_msa_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_msa_Invalid=1);
    mail_geo_blk_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_geo_blk_Invalid=1);
    mail_geo_match_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_geo_match_Invalid=1);
    mail_err_stat_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_err_stat_Invalid=1);
    marriedappend_ENUM_ErrorCount := COUNT(GROUP,h.marriedappend_Invalid=1);
    changedate_CUSTOM_ErrorCount := COUNT(GROUP,h.changedate_Invalid=1);
    name_type_ENUM_ErrorCount := COUNT(GROUP,h.name_type_Invalid=1);
    addr_type_ENUM_ErrorCount := COUNT(GROUP,h.addr_type_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.rid_Invalid > 0 OR h.did_Invalid > 0 OR h.did_score_Invalid > 0 OR h.ssn_Invalid > 0 OR h.vtid_Invalid > 0 OR h.process_date_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.source_Invalid > 0 OR h.file_id_Invalid > 0 OR h.vendor_id_Invalid > 0 OR h.source_state_Invalid > 0 OR h.file_acquired_date_Invalid > 0 OR h.last_name_Invalid > 0 OR h.first_name_Invalid > 0 OR h.middle_name_Invalid > 0 OR h.source_voterid_Invalid > 0 OR h.dob_Invalid > 0 OR h.agecat_Invalid > 0 OR h.agecat_exp_Invalid > 0 OR h.regdate_Invalid > 0 OR h.race_Invalid > 0 OR h.race_exp_Invalid > 0 OR h.gender_Invalid > 0 OR h.political_party_Invalid > 0 OR h.politicalparty_exp_Invalid > 0 OR h.phone_Invalid > 0 OR h.work_phone_Invalid > 0 OR h.other_phone_Invalid > 0 OR h.active_status_Invalid > 0 OR h.active_status_exp_Invalid > 0 OR h.gendersurnamguess_Invalid > 0 OR h.active_other_Invalid > 0 OR h.voter_status_Invalid > 0 OR h.voter_status_exp_Invalid > 0 OR h.timezonetbl_Invalid > 0 OR h.distcode_Invalid > 0 OR h.countycode_Invalid > 0 OR h.schoolcode_Invalid > 0 OR h.statehouse_Invalid > 0 OR h.statesenate_Invalid > 0 OR h.ushouse_Invalid > 0 OR h.lastdatevote_Invalid > 0 OR h.fname_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.postdir_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.cart_Invalid > 0 OR h.cr_sort_sz_Invalid > 0 OR h.lot_Invalid > 0 OR h.lot_order_Invalid > 0 OR h.dpbc_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.rec_type_Invalid > 0 OR h.ace_fips_st_Invalid > 0 OR h.fips_county_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.msa_Invalid > 0 OR h.geo_blk_Invalid > 0 OR h.geo_match_Invalid > 0 OR h.err_stat_Invalid > 0 OR h.mail_predir_Invalid > 0 OR h.mail_prim_name_Invalid > 0 OR h.mail_postdir_Invalid > 0 OR h.mail_p_city_name_Invalid > 0 OR h.mail_v_city_name_Invalid > 0 OR h.mail_st_Invalid > 0 OR h.mail_ace_zip_Invalid > 0 OR h.mail_zip4_Invalid > 0 OR h.mail_cart_Invalid > 0 OR h.mail_cr_sort_sz_Invalid > 0 OR h.mail_lot_Invalid > 0 OR h.mail_lot_order_Invalid > 0 OR h.mail_dpbc_Invalid > 0 OR h.mail_chk_digit_Invalid > 0 OR h.mail_rec_type_Invalid > 0 OR h.mail_ace_fips_st_Invalid > 0 OR h.mail_fips_county_Invalid > 0 OR h.mail_geo_lat_Invalid > 0 OR h.mail_geo_long_Invalid > 0 OR h.mail_msa_Invalid > 0 OR h.mail_geo_blk_Invalid > 0 OR h.mail_geo_match_Invalid > 0 OR h.mail_err_stat_Invalid > 0 OR h.marriedappend_Invalid > 0 OR h.changedate_Invalid > 0 OR h.name_type_Invalid > 0 OR h.addr_type_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.rid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ssn_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vtid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_ENUM_ErrorCount > 0, 1, 0) + IF(le.file_id_ENUM_ErrorCount > 0, 1, 0) + IF(le.vendor_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_acquired_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.middle_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_voterid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.agecat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.agecat_exp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.regdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.race_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.race_exp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.political_party_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.politicalparty_exp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.work_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.other_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_status_exp_ENUM_ErrorCount > 0, 1, 0) + IF(le.gendersurnamguess_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_other_ALLOW_ErrorCount > 0, 1, 0) + IF(le.voter_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.voter_status_exp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.timezonetbl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.distcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.countycode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.schoolcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statehouse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statesenate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ushouse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lastdatevote_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cart_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ENUM_ErrorCount > 0, 1, 0) + IF(le.lot_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.dpbc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rec_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ace_fips_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_blk_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_match_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.err_stat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_ace_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_cart_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_cr_sort_sz_ENUM_ErrorCount > 0, 1, 0) + IF(le.mail_lot_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.mail_dpbc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_rec_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_ace_fips_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_fips_county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_geo_blk_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_geo_match_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_err_stat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.marriedappend_ENUM_ErrorCount > 0, 1, 0) + IF(le.changedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.name_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.addr_type_ENUM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.rid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ssn_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vtid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_ENUM_ErrorCount > 0, 1, 0) + IF(le.file_id_ENUM_ErrorCount > 0, 1, 0) + IF(le.vendor_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_acquired_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.middle_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_voterid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.agecat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.agecat_exp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.regdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.race_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.race_exp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.political_party_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.politicalparty_exp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.work_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.other_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_status_exp_ENUM_ErrorCount > 0, 1, 0) + IF(le.gendersurnamguess_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_other_ALLOW_ErrorCount > 0, 1, 0) + IF(le.voter_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.voter_status_exp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.timezonetbl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.distcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.countycode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.schoolcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statehouse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statesenate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ushouse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lastdatevote_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cart_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ENUM_ErrorCount > 0, 1, 0) + IF(le.lot_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.dpbc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rec_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ace_fips_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_blk_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_match_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.err_stat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_ace_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_cart_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_cr_sort_sz_ENUM_ErrorCount > 0, 1, 0) + IF(le.mail_lot_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.mail_dpbc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_rec_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_ace_fips_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_fips_county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_geo_blk_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_geo_match_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_err_stat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.marriedappend_ENUM_ErrorCount > 0, 1, 0) + IF(le.changedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.name_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.addr_type_ENUM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT39.StrType ErrorMessage;
    SALT39.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.rid_Invalid,le.did_Invalid,le.did_score_Invalid,le.ssn_Invalid,le.vtid_Invalid,le.process_date_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.source_Invalid,le.file_id_Invalid,le.vendor_id_Invalid,le.source_state_Invalid,le.file_acquired_date_Invalid,le.last_name_Invalid,le.first_name_Invalid,le.middle_name_Invalid,le.source_voterid_Invalid,le.dob_Invalid,le.agecat_Invalid,le.agecat_exp_Invalid,le.regdate_Invalid,le.race_Invalid,le.race_exp_Invalid,le.gender_Invalid,le.political_party_Invalid,le.politicalparty_exp_Invalid,le.phone_Invalid,le.work_phone_Invalid,le.other_phone_Invalid,le.active_status_Invalid,le.active_status_exp_Invalid,le.gendersurnamguess_Invalid,le.active_other_Invalid,le.voter_status_Invalid,le.voter_status_exp_Invalid,le.timezonetbl_Invalid,le.distcode_Invalid,le.countycode_Invalid,le.schoolcode_Invalid,le.statehouse_Invalid,le.statesenate_Invalid,le.ushouse_Invalid,le.lastdatevote_Invalid,le.fname_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.postdir_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dpbc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.ace_fips_st_Invalid,le.fips_county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.mail_predir_Invalid,le.mail_prim_name_Invalid,le.mail_postdir_Invalid,le.mail_p_city_name_Invalid,le.mail_v_city_name_Invalid,le.mail_st_Invalid,le.mail_ace_zip_Invalid,le.mail_zip4_Invalid,le.mail_cart_Invalid,le.mail_cr_sort_sz_Invalid,le.mail_lot_Invalid,le.mail_lot_order_Invalid,le.mail_dpbc_Invalid,le.mail_chk_digit_Invalid,le.mail_rec_type_Invalid,le.mail_ace_fips_st_Invalid,le.mail_fips_county_Invalid,le.mail_geo_lat_Invalid,le.mail_geo_long_Invalid,le.mail_msa_Invalid,le.mail_geo_blk_Invalid,le.mail_geo_match_Invalid,le.mail_err_stat_Invalid,le.marriedappend_Invalid,le.changedate_Invalid,le.name_type_Invalid,le.addr_type_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Reg_Fields.InvalidMessage_rid(le.rid_Invalid),Base_Reg_Fields.InvalidMessage_did(le.did_Invalid),Base_Reg_Fields.InvalidMessage_did_score(le.did_score_Invalid),Base_Reg_Fields.InvalidMessage_ssn(le.ssn_Invalid),Base_Reg_Fields.InvalidMessage_vtid(le.vtid_Invalid),Base_Reg_Fields.InvalidMessage_process_date(le.process_date_Invalid),Base_Reg_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Base_Reg_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Base_Reg_Fields.InvalidMessage_source(le.source_Invalid),Base_Reg_Fields.InvalidMessage_file_id(le.file_id_Invalid),Base_Reg_Fields.InvalidMessage_vendor_id(le.vendor_id_Invalid),Base_Reg_Fields.InvalidMessage_source_state(le.source_state_Invalid),Base_Reg_Fields.InvalidMessage_file_acquired_date(le.file_acquired_date_Invalid),Base_Reg_Fields.InvalidMessage_last_name(le.last_name_Invalid),Base_Reg_Fields.InvalidMessage_first_name(le.first_name_Invalid),Base_Reg_Fields.InvalidMessage_middle_name(le.middle_name_Invalid),Base_Reg_Fields.InvalidMessage_source_voterid(le.source_voterid_Invalid),Base_Reg_Fields.InvalidMessage_dob(le.dob_Invalid),Base_Reg_Fields.InvalidMessage_agecat(le.agecat_Invalid),Base_Reg_Fields.InvalidMessage_agecat_exp(le.agecat_exp_Invalid),Base_Reg_Fields.InvalidMessage_regdate(le.regdate_Invalid),Base_Reg_Fields.InvalidMessage_race(le.race_Invalid),Base_Reg_Fields.InvalidMessage_race_exp(le.race_exp_Invalid),Base_Reg_Fields.InvalidMessage_gender(le.gender_Invalid),Base_Reg_Fields.InvalidMessage_political_party(le.political_party_Invalid),Base_Reg_Fields.InvalidMessage_politicalparty_exp(le.politicalparty_exp_Invalid),Base_Reg_Fields.InvalidMessage_phone(le.phone_Invalid),Base_Reg_Fields.InvalidMessage_work_phone(le.work_phone_Invalid),Base_Reg_Fields.InvalidMessage_other_phone(le.other_phone_Invalid),Base_Reg_Fields.InvalidMessage_active_status(le.active_status_Invalid),Base_Reg_Fields.InvalidMessage_active_status_exp(le.active_status_exp_Invalid),Base_Reg_Fields.InvalidMessage_gendersurnamguess(le.gendersurnamguess_Invalid),Base_Reg_Fields.InvalidMessage_active_other(le.active_other_Invalid),Base_Reg_Fields.InvalidMessage_voter_status(le.voter_status_Invalid),Base_Reg_Fields.InvalidMessage_voter_status_exp(le.voter_status_exp_Invalid),Base_Reg_Fields.InvalidMessage_timezonetbl(le.timezonetbl_Invalid),Base_Reg_Fields.InvalidMessage_distcode(le.distcode_Invalid),Base_Reg_Fields.InvalidMessage_countycode(le.countycode_Invalid),Base_Reg_Fields.InvalidMessage_schoolcode(le.schoolcode_Invalid),Base_Reg_Fields.InvalidMessage_statehouse(le.statehouse_Invalid),Base_Reg_Fields.InvalidMessage_statesenate(le.statesenate_Invalid),Base_Reg_Fields.InvalidMessage_ushouse(le.ushouse_Invalid),Base_Reg_Fields.InvalidMessage_lastdatevote(le.lastdatevote_Invalid),Base_Reg_Fields.InvalidMessage_fname(le.fname_Invalid),Base_Reg_Fields.InvalidMessage_predir(le.predir_Invalid),Base_Reg_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Base_Reg_Fields.InvalidMessage_postdir(le.postdir_Invalid),Base_Reg_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Base_Reg_Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Base_Reg_Fields.InvalidMessage_st(le.st_Invalid),Base_Reg_Fields.InvalidMessage_zip(le.zip_Invalid),Base_Reg_Fields.InvalidMessage_zip4(le.zip4_Invalid),Base_Reg_Fields.InvalidMessage_cart(le.cart_Invalid),Base_Reg_Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Base_Reg_Fields.InvalidMessage_lot(le.lot_Invalid),Base_Reg_Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Base_Reg_Fields.InvalidMessage_dpbc(le.dpbc_Invalid),Base_Reg_Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Base_Reg_Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Base_Reg_Fields.InvalidMessage_ace_fips_st(le.ace_fips_st_Invalid),Base_Reg_Fields.InvalidMessage_fips_county(le.fips_county_Invalid),Base_Reg_Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Base_Reg_Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Base_Reg_Fields.InvalidMessage_msa(le.msa_Invalid),Base_Reg_Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Base_Reg_Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Base_Reg_Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Base_Reg_Fields.InvalidMessage_mail_predir(le.mail_predir_Invalid),Base_Reg_Fields.InvalidMessage_mail_prim_name(le.mail_prim_name_Invalid),Base_Reg_Fields.InvalidMessage_mail_postdir(le.mail_postdir_Invalid),Base_Reg_Fields.InvalidMessage_mail_p_city_name(le.mail_p_city_name_Invalid),Base_Reg_Fields.InvalidMessage_mail_v_city_name(le.mail_v_city_name_Invalid),Base_Reg_Fields.InvalidMessage_mail_st(le.mail_st_Invalid),Base_Reg_Fields.InvalidMessage_mail_ace_zip(le.mail_ace_zip_Invalid),Base_Reg_Fields.InvalidMessage_mail_zip4(le.mail_zip4_Invalid),Base_Reg_Fields.InvalidMessage_mail_cart(le.mail_cart_Invalid),Base_Reg_Fields.InvalidMessage_mail_cr_sort_sz(le.mail_cr_sort_sz_Invalid),Base_Reg_Fields.InvalidMessage_mail_lot(le.mail_lot_Invalid),Base_Reg_Fields.InvalidMessage_mail_lot_order(le.mail_lot_order_Invalid),Base_Reg_Fields.InvalidMessage_mail_dpbc(le.mail_dpbc_Invalid),Base_Reg_Fields.InvalidMessage_mail_chk_digit(le.mail_chk_digit_Invalid),Base_Reg_Fields.InvalidMessage_mail_rec_type(le.mail_rec_type_Invalid),Base_Reg_Fields.InvalidMessage_mail_ace_fips_st(le.mail_ace_fips_st_Invalid),Base_Reg_Fields.InvalidMessage_mail_fips_county(le.mail_fips_county_Invalid),Base_Reg_Fields.InvalidMessage_mail_geo_lat(le.mail_geo_lat_Invalid),Base_Reg_Fields.InvalidMessage_mail_geo_long(le.mail_geo_long_Invalid),Base_Reg_Fields.InvalidMessage_mail_msa(le.mail_msa_Invalid),Base_Reg_Fields.InvalidMessage_mail_geo_blk(le.mail_geo_blk_Invalid),Base_Reg_Fields.InvalidMessage_mail_geo_match(le.mail_geo_match_Invalid),Base_Reg_Fields.InvalidMessage_mail_err_stat(le.mail_err_stat_Invalid),Base_Reg_Fields.InvalidMessage_marriedappend(le.marriedappend_Invalid),Base_Reg_Fields.InvalidMessage_changedate(le.changedate_Invalid),Base_Reg_Fields.InvalidMessage_name_type(le.name_type_Invalid),Base_Reg_Fields.InvalidMessage_addr_type(le.addr_type_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.rid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.vtid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.source_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.file_id_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.vendor_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.source_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.file_acquired_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.middle_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_voterid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.agecat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.agecat_exp_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.regdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.race_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.race_exp_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.political_party_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.politicalparty_exp_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.work_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.other_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.active_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.active_status_exp_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.gendersurnamguess_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.active_other_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.voter_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.voter_status_exp_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.timezonetbl_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.distcode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.countycode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.schoolcode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statehouse_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statesenate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ushouse_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lastdatevote_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dpbc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ace_fips_st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fips_county_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_prim_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_p_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_v_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_ace_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_cart_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_cr_sort_sz_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.mail_lot_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_lot_order_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.mail_dpbc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_chk_digit_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_rec_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_ace_fips_st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_fips_county_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_geo_lat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_geo_long_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_msa_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_geo_blk_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_geo_match_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_err_stat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.marriedappend_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.changedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.name_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.addr_type_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'rid','did','did_score','ssn','vtid','process_date','date_first_seen','date_last_seen','source','file_id','vendor_id','source_state','file_acquired_date','last_name','first_name','middle_name','source_voterid','dob','agecat','agecat_exp','regdate','race','race_exp','gender','political_party','politicalparty_exp','phone','work_phone','other_phone','active_status','active_status_exp','gendersurnamguess','active_other','voter_status','voter_status_exp','timezonetbl','distcode','countycode','schoolcode','statehouse','statesenate','ushouse','lastdatevote','fname','predir','prim_name','postdir','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_predir','mail_prim_name','mail_postdir','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_rec_type','mail_ace_fips_st','mail_fips_county','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat','marriedappend','changedate','name_type','addr_type','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_numeric','invalid_percentage','invalid_ssn','invalid_vtid','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_source','invalid_file_id','invalid_alphanum','invalid_source_state','invalid_pastdate8','invalid_last_name','invalid_alphanum_specials','invalid_alphanum_specials','invalid_alphanum','invalid_dob','invalid_agecat','invalid_agecat_exp','invalid_regdate','invalid_race','invalid_race_exp','invalid_gender','invalid_political_party','invalid_politicalparty_exp','invalid_phone','invalid_phone','invalid_nums_empty','invalid_alphanum_empty','invalid_active_status_exp','invalid_alphanum_empty','invalid_alphanum_empty','invalid_alphanum_empty','invalid_voter_status_exp','invalid_nums_empty','invalid_alphanum_empty','invalid_alphanum_empty','invalid_alphanum_specials','invalid_alphanum_empty','invalid_alphanumquot_empty','invalid_alphanum_empty','invalid_lastdatevote','invalid_fname','invalid_direction','invalid_mandatory','invalid_direction','invalid_mandatory','invalid_mandatory','invalid_st','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_rec_type','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','invalid_direction','invalid_mandatory','invalid_direction','invalid_mandatory','invalid_mandatory','invalid_st','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_rec_type','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','invalid_boolean_yn_empty','invalid_changedate','invalid_name_type','invalid_addr_type','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.rid,(SALT39.StrType)le.did,(SALT39.StrType)le.did_score,(SALT39.StrType)le.ssn,(SALT39.StrType)le.vtid,(SALT39.StrType)le.process_date,(SALT39.StrType)le.date_first_seen,(SALT39.StrType)le.date_last_seen,(SALT39.StrType)le.source,(SALT39.StrType)le.file_id,(SALT39.StrType)le.vendor_id,(SALT39.StrType)le.source_state,(SALT39.StrType)le.file_acquired_date,(SALT39.StrType)le.last_name,(SALT39.StrType)le.first_name,(SALT39.StrType)le.middle_name,(SALT39.StrType)le.source_voterid,(SALT39.StrType)le.dob,(SALT39.StrType)le.agecat,(SALT39.StrType)le.agecat_exp,(SALT39.StrType)le.regdate,(SALT39.StrType)le.race,(SALT39.StrType)le.race_exp,(SALT39.StrType)le.gender,(SALT39.StrType)le.political_party,(SALT39.StrType)le.politicalparty_exp,(SALT39.StrType)le.phone,(SALT39.StrType)le.work_phone,(SALT39.StrType)le.other_phone,(SALT39.StrType)le.active_status,(SALT39.StrType)le.active_status_exp,(SALT39.StrType)le.gendersurnamguess,(SALT39.StrType)le.active_other,(SALT39.StrType)le.voter_status,(SALT39.StrType)le.voter_status_exp,(SALT39.StrType)le.timezonetbl,(SALT39.StrType)le.distcode,(SALT39.StrType)le.countycode,(SALT39.StrType)le.schoolcode,(SALT39.StrType)le.statehouse,(SALT39.StrType)le.statesenate,(SALT39.StrType)le.ushouse,(SALT39.StrType)le.lastdatevote,(SALT39.StrType)le.fname,(SALT39.StrType)le.predir,(SALT39.StrType)le.prim_name,(SALT39.StrType)le.postdir,(SALT39.StrType)le.p_city_name,(SALT39.StrType)le.v_city_name,(SALT39.StrType)le.st,(SALT39.StrType)le.zip,(SALT39.StrType)le.zip4,(SALT39.StrType)le.cart,(SALT39.StrType)le.cr_sort_sz,(SALT39.StrType)le.lot,(SALT39.StrType)le.lot_order,(SALT39.StrType)le.dpbc,(SALT39.StrType)le.chk_digit,(SALT39.StrType)le.rec_type,(SALT39.StrType)le.ace_fips_st,(SALT39.StrType)le.fips_county,(SALT39.StrType)le.geo_lat,(SALT39.StrType)le.geo_long,(SALT39.StrType)le.msa,(SALT39.StrType)le.geo_blk,(SALT39.StrType)le.geo_match,(SALT39.StrType)le.err_stat,(SALT39.StrType)le.mail_predir,(SALT39.StrType)le.mail_prim_name,(SALT39.StrType)le.mail_postdir,(SALT39.StrType)le.mail_p_city_name,(SALT39.StrType)le.mail_v_city_name,(SALT39.StrType)le.mail_st,(SALT39.StrType)le.mail_ace_zip,(SALT39.StrType)le.mail_zip4,(SALT39.StrType)le.mail_cart,(SALT39.StrType)le.mail_cr_sort_sz,(SALT39.StrType)le.mail_lot,(SALT39.StrType)le.mail_lot_order,(SALT39.StrType)le.mail_dpbc,(SALT39.StrType)le.mail_chk_digit,(SALT39.StrType)le.mail_rec_type,(SALT39.StrType)le.mail_ace_fips_st,(SALT39.StrType)le.mail_fips_county,(SALT39.StrType)le.mail_geo_lat,(SALT39.StrType)le.mail_geo_long,(SALT39.StrType)le.mail_msa,(SALT39.StrType)le.mail_geo_blk,(SALT39.StrType)le.mail_geo_match,(SALT39.StrType)le.mail_err_stat,(SALT39.StrType)le.marriedappend,(SALT39.StrType)le.changedate,(SALT39.StrType)le.name_type,(SALT39.StrType)le.addr_type,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,94,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_Reg_Layout_Voters) prevDS = DATASET([], Base_Reg_Layout_Voters), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'rid:invalid_numeric:CUSTOM'
          ,'did:invalid_numeric:CUSTOM'
          ,'did_score:invalid_percentage:CUSTOM'
          ,'ssn:invalid_ssn:CUSTOM'
          ,'vtid:invalid_vtid:CUSTOM'
          ,'process_date:invalid_pastdate8:CUSTOM'
          ,'date_first_seen:invalid_pastdate8:CUSTOM'
          ,'date_last_seen:invalid_pastdate8:CUSTOM'
          ,'source:invalid_source:ENUM'
          ,'file_id:invalid_file_id:ENUM'
          ,'vendor_id:invalid_alphanum:CUSTOM'
          ,'source_state:invalid_source_state:CUSTOM'
          ,'file_acquired_date:invalid_pastdate8:CUSTOM'
          ,'last_name:invalid_last_name:CUSTOM'
          ,'first_name:invalid_alphanum_specials:ALLOW'
          ,'middle_name:invalid_alphanum_specials:ALLOW'
          ,'source_voterid:invalid_alphanum:CUSTOM'
          ,'dob:invalid_dob:CUSTOM'
          ,'agecat:invalid_agecat:CUSTOM'
          ,'agecat_exp:invalid_agecat_exp:CUSTOM'
          ,'regdate:invalid_regdate:CUSTOM'
          ,'race:invalid_race:CUSTOM'
          ,'race_exp:invalid_race_exp:CUSTOM'
          ,'gender:invalid_gender:ENUM'
          ,'political_party:invalid_political_party:CUSTOM'
          ,'politicalparty_exp:invalid_politicalparty_exp:CUSTOM'
          ,'phone:invalid_phone:CUSTOM'
          ,'work_phone:invalid_phone:CUSTOM'
          ,'other_phone:invalid_nums_empty:ALLOW'
          ,'active_status:invalid_alphanum_empty:ALLOW'
          ,'active_status_exp:invalid_active_status_exp:ENUM'
          ,'gendersurnamguess:invalid_alphanum_empty:ALLOW'
          ,'active_other:invalid_alphanum_empty:ALLOW'
          ,'voter_status:invalid_alphanum_empty:ALLOW'
          ,'voter_status_exp:invalid_voter_status_exp:CUSTOM'
          ,'timezonetbl:invalid_nums_empty:ALLOW'
          ,'distcode:invalid_alphanum_empty:ALLOW'
          ,'countycode:invalid_alphanum_empty:ALLOW'
          ,'schoolcode:invalid_alphanum_specials:ALLOW'
          ,'statehouse:invalid_alphanum_empty:ALLOW'
          ,'statesenate:invalid_alphanumquot_empty:ALLOW'
          ,'ushouse:invalid_alphanum_empty:ALLOW'
          ,'lastdatevote:invalid_lastdatevote:CUSTOM'
          ,'fname:invalid_fname:CUSTOM'
          ,'predir:invalid_direction:ALLOW'
          ,'prim_name:invalid_mandatory:CUSTOM'
          ,'postdir:invalid_direction:ALLOW'
          ,'p_city_name:invalid_mandatory:CUSTOM'
          ,'v_city_name:invalid_mandatory:CUSTOM'
          ,'st:invalid_st:CUSTOM'
          ,'zip:invalid_zip5:CUSTOM'
          ,'zip4:invalid_zip4:CUSTOM'
          ,'cart:invalid_cart:CUSTOM'
          ,'cr_sort_sz:invalid_cr_sort_sz:ENUM'
          ,'lot:invalid_lot:CUSTOM'
          ,'lot_order:invalid_lot_order:ENUM'
          ,'dpbc:invalid_dpbc:CUSTOM'
          ,'chk_digit:invalid_chk_digit:CUSTOM'
          ,'rec_type:invalid_rec_type:CUSTOM'
          ,'ace_fips_st:invalid_fips_state:CUSTOM'
          ,'fips_county:invalid_fips_county:CUSTOM'
          ,'geo_lat:invalid_geo:CUSTOM'
          ,'geo_long:invalid_geo:CUSTOM'
          ,'msa:invalid_msa:CUSTOM'
          ,'geo_blk:invalid_geo_blk:CUSTOM'
          ,'geo_match:invalid_geo_match:CUSTOM'
          ,'err_stat:invalid_err_stat:CUSTOM'
          ,'mail_predir:invalid_direction:ALLOW'
          ,'mail_prim_name:invalid_mandatory:CUSTOM'
          ,'mail_postdir:invalid_direction:ALLOW'
          ,'mail_p_city_name:invalid_mandatory:CUSTOM'
          ,'mail_v_city_name:invalid_mandatory:CUSTOM'
          ,'mail_st:invalid_st:CUSTOM'
          ,'mail_ace_zip:invalid_zip5:CUSTOM'
          ,'mail_zip4:invalid_zip4:CUSTOM'
          ,'mail_cart:invalid_cart:CUSTOM'
          ,'mail_cr_sort_sz:invalid_cr_sort_sz:ENUM'
          ,'mail_lot:invalid_lot:CUSTOM'
          ,'mail_lot_order:invalid_lot_order:ENUM'
          ,'mail_dpbc:invalid_dpbc:CUSTOM'
          ,'mail_chk_digit:invalid_chk_digit:CUSTOM'
          ,'mail_rec_type:invalid_rec_type:CUSTOM'
          ,'mail_ace_fips_st:invalid_fips_state:CUSTOM'
          ,'mail_fips_county:invalid_fips_county:CUSTOM'
          ,'mail_geo_lat:invalid_geo:CUSTOM'
          ,'mail_geo_long:invalid_geo:CUSTOM'
          ,'mail_msa:invalid_msa:CUSTOM'
          ,'mail_geo_blk:invalid_geo_blk:CUSTOM'
          ,'mail_geo_match:invalid_geo_match:CUSTOM'
          ,'mail_err_stat:invalid_err_stat:CUSTOM'
          ,'marriedappend:invalid_boolean_yn_empty:ENUM'
          ,'changedate:invalid_changedate:CUSTOM'
          ,'name_type:invalid_name_type:ENUM'
          ,'addr_type:invalid_addr_type:ENUM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Reg_Fields.InvalidMessage_rid(1)
          ,Base_Reg_Fields.InvalidMessage_did(1)
          ,Base_Reg_Fields.InvalidMessage_did_score(1)
          ,Base_Reg_Fields.InvalidMessage_ssn(1)
          ,Base_Reg_Fields.InvalidMessage_vtid(1)
          ,Base_Reg_Fields.InvalidMessage_process_date(1)
          ,Base_Reg_Fields.InvalidMessage_date_first_seen(1)
          ,Base_Reg_Fields.InvalidMessage_date_last_seen(1)
          ,Base_Reg_Fields.InvalidMessage_source(1)
          ,Base_Reg_Fields.InvalidMessage_file_id(1)
          ,Base_Reg_Fields.InvalidMessage_vendor_id(1)
          ,Base_Reg_Fields.InvalidMessage_source_state(1)
          ,Base_Reg_Fields.InvalidMessage_file_acquired_date(1)
          ,Base_Reg_Fields.InvalidMessage_last_name(1)
          ,Base_Reg_Fields.InvalidMessage_first_name(1)
          ,Base_Reg_Fields.InvalidMessage_middle_name(1)
          ,Base_Reg_Fields.InvalidMessage_source_voterid(1)
          ,Base_Reg_Fields.InvalidMessage_dob(1)
          ,Base_Reg_Fields.InvalidMessage_agecat(1)
          ,Base_Reg_Fields.InvalidMessage_agecat_exp(1)
          ,Base_Reg_Fields.InvalidMessage_regdate(1)
          ,Base_Reg_Fields.InvalidMessage_race(1)
          ,Base_Reg_Fields.InvalidMessage_race_exp(1)
          ,Base_Reg_Fields.InvalidMessage_gender(1)
          ,Base_Reg_Fields.InvalidMessage_political_party(1)
          ,Base_Reg_Fields.InvalidMessage_politicalparty_exp(1)
          ,Base_Reg_Fields.InvalidMessage_phone(1)
          ,Base_Reg_Fields.InvalidMessage_work_phone(1)
          ,Base_Reg_Fields.InvalidMessage_other_phone(1)
          ,Base_Reg_Fields.InvalidMessage_active_status(1)
          ,Base_Reg_Fields.InvalidMessage_active_status_exp(1)
          ,Base_Reg_Fields.InvalidMessage_gendersurnamguess(1)
          ,Base_Reg_Fields.InvalidMessage_active_other(1)
          ,Base_Reg_Fields.InvalidMessage_voter_status(1)
          ,Base_Reg_Fields.InvalidMessage_voter_status_exp(1)
          ,Base_Reg_Fields.InvalidMessage_timezonetbl(1)
          ,Base_Reg_Fields.InvalidMessage_distcode(1)
          ,Base_Reg_Fields.InvalidMessage_countycode(1)
          ,Base_Reg_Fields.InvalidMessage_schoolcode(1)
          ,Base_Reg_Fields.InvalidMessage_statehouse(1)
          ,Base_Reg_Fields.InvalidMessage_statesenate(1)
          ,Base_Reg_Fields.InvalidMessage_ushouse(1)
          ,Base_Reg_Fields.InvalidMessage_lastdatevote(1)
          ,Base_Reg_Fields.InvalidMessage_fname(1)
          ,Base_Reg_Fields.InvalidMessage_predir(1)
          ,Base_Reg_Fields.InvalidMessage_prim_name(1)
          ,Base_Reg_Fields.InvalidMessage_postdir(1)
          ,Base_Reg_Fields.InvalidMessage_p_city_name(1)
          ,Base_Reg_Fields.InvalidMessage_v_city_name(1)
          ,Base_Reg_Fields.InvalidMessage_st(1)
          ,Base_Reg_Fields.InvalidMessage_zip(1)
          ,Base_Reg_Fields.InvalidMessage_zip4(1)
          ,Base_Reg_Fields.InvalidMessage_cart(1)
          ,Base_Reg_Fields.InvalidMessage_cr_sort_sz(1)
          ,Base_Reg_Fields.InvalidMessage_lot(1)
          ,Base_Reg_Fields.InvalidMessage_lot_order(1)
          ,Base_Reg_Fields.InvalidMessage_dpbc(1)
          ,Base_Reg_Fields.InvalidMessage_chk_digit(1)
          ,Base_Reg_Fields.InvalidMessage_rec_type(1)
          ,Base_Reg_Fields.InvalidMessage_ace_fips_st(1)
          ,Base_Reg_Fields.InvalidMessage_fips_county(1)
          ,Base_Reg_Fields.InvalidMessage_geo_lat(1)
          ,Base_Reg_Fields.InvalidMessage_geo_long(1)
          ,Base_Reg_Fields.InvalidMessage_msa(1)
          ,Base_Reg_Fields.InvalidMessage_geo_blk(1)
          ,Base_Reg_Fields.InvalidMessage_geo_match(1)
          ,Base_Reg_Fields.InvalidMessage_err_stat(1)
          ,Base_Reg_Fields.InvalidMessage_mail_predir(1)
          ,Base_Reg_Fields.InvalidMessage_mail_prim_name(1)
          ,Base_Reg_Fields.InvalidMessage_mail_postdir(1)
          ,Base_Reg_Fields.InvalidMessage_mail_p_city_name(1)
          ,Base_Reg_Fields.InvalidMessage_mail_v_city_name(1)
          ,Base_Reg_Fields.InvalidMessage_mail_st(1)
          ,Base_Reg_Fields.InvalidMessage_mail_ace_zip(1)
          ,Base_Reg_Fields.InvalidMessage_mail_zip4(1)
          ,Base_Reg_Fields.InvalidMessage_mail_cart(1)
          ,Base_Reg_Fields.InvalidMessage_mail_cr_sort_sz(1)
          ,Base_Reg_Fields.InvalidMessage_mail_lot(1)
          ,Base_Reg_Fields.InvalidMessage_mail_lot_order(1)
          ,Base_Reg_Fields.InvalidMessage_mail_dpbc(1)
          ,Base_Reg_Fields.InvalidMessage_mail_chk_digit(1)
          ,Base_Reg_Fields.InvalidMessage_mail_rec_type(1)
          ,Base_Reg_Fields.InvalidMessage_mail_ace_fips_st(1)
          ,Base_Reg_Fields.InvalidMessage_mail_fips_county(1)
          ,Base_Reg_Fields.InvalidMessage_mail_geo_lat(1)
          ,Base_Reg_Fields.InvalidMessage_mail_geo_long(1)
          ,Base_Reg_Fields.InvalidMessage_mail_msa(1)
          ,Base_Reg_Fields.InvalidMessage_mail_geo_blk(1)
          ,Base_Reg_Fields.InvalidMessage_mail_geo_match(1)
          ,Base_Reg_Fields.InvalidMessage_mail_err_stat(1)
          ,Base_Reg_Fields.InvalidMessage_marriedappend(1)
          ,Base_Reg_Fields.InvalidMessage_changedate(1)
          ,Base_Reg_Fields.InvalidMessage_name_type(1)
          ,Base_Reg_Fields.InvalidMessage_addr_type(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.rid_CUSTOM_ErrorCount
          ,le.did_CUSTOM_ErrorCount
          ,le.did_score_CUSTOM_ErrorCount
          ,le.ssn_CUSTOM_ErrorCount
          ,le.vtid_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.source_ENUM_ErrorCount
          ,le.file_id_ENUM_ErrorCount
          ,le.vendor_id_CUSTOM_ErrorCount
          ,le.source_state_CUSTOM_ErrorCount
          ,le.file_acquired_date_CUSTOM_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.first_name_ALLOW_ErrorCount
          ,le.middle_name_ALLOW_ErrorCount
          ,le.source_voterid_CUSTOM_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.agecat_CUSTOM_ErrorCount
          ,le.agecat_exp_CUSTOM_ErrorCount
          ,le.regdate_CUSTOM_ErrorCount
          ,le.race_CUSTOM_ErrorCount
          ,le.race_exp_CUSTOM_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.political_party_CUSTOM_ErrorCount
          ,le.politicalparty_exp_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.work_phone_CUSTOM_ErrorCount
          ,le.other_phone_ALLOW_ErrorCount
          ,le.active_status_ALLOW_ErrorCount
          ,le.active_status_exp_ENUM_ErrorCount
          ,le.gendersurnamguess_ALLOW_ErrorCount
          ,le.active_other_ALLOW_ErrorCount
          ,le.voter_status_ALLOW_ErrorCount
          ,le.voter_status_exp_CUSTOM_ErrorCount
          ,le.timezonetbl_ALLOW_ErrorCount
          ,le.distcode_ALLOW_ErrorCount
          ,le.countycode_ALLOW_ErrorCount
          ,le.schoolcode_ALLOW_ErrorCount
          ,le.statehouse_ALLOW_ErrorCount
          ,le.statesenate_ALLOW_ErrorCount
          ,le.ushouse_ALLOW_ErrorCount
          ,le.lastdatevote_CUSTOM_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_CUSTOM_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.p_city_name_CUSTOM_ErrorCount
          ,le.v_city_name_CUSTOM_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.cart_CUSTOM_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_CUSTOM_ErrorCount
          ,le.lot_order_ENUM_ErrorCount
          ,le.dpbc_CUSTOM_ErrorCount
          ,le.chk_digit_CUSTOM_ErrorCount
          ,le.rec_type_CUSTOM_ErrorCount
          ,le.ace_fips_st_CUSTOM_ErrorCount
          ,le.fips_county_CUSTOM_ErrorCount
          ,le.geo_lat_CUSTOM_ErrorCount
          ,le.geo_long_CUSTOM_ErrorCount
          ,le.msa_CUSTOM_ErrorCount
          ,le.geo_blk_CUSTOM_ErrorCount
          ,le.geo_match_CUSTOM_ErrorCount
          ,le.err_stat_CUSTOM_ErrorCount
          ,le.mail_predir_ALLOW_ErrorCount
          ,le.mail_prim_name_CUSTOM_ErrorCount
          ,le.mail_postdir_ALLOW_ErrorCount
          ,le.mail_p_city_name_CUSTOM_ErrorCount
          ,le.mail_v_city_name_CUSTOM_ErrorCount
          ,le.mail_st_CUSTOM_ErrorCount
          ,le.mail_ace_zip_CUSTOM_ErrorCount
          ,le.mail_zip4_CUSTOM_ErrorCount
          ,le.mail_cart_CUSTOM_ErrorCount
          ,le.mail_cr_sort_sz_ENUM_ErrorCount
          ,le.mail_lot_CUSTOM_ErrorCount
          ,le.mail_lot_order_ENUM_ErrorCount
          ,le.mail_dpbc_CUSTOM_ErrorCount
          ,le.mail_chk_digit_CUSTOM_ErrorCount
          ,le.mail_rec_type_CUSTOM_ErrorCount
          ,le.mail_ace_fips_st_CUSTOM_ErrorCount
          ,le.mail_fips_county_CUSTOM_ErrorCount
          ,le.mail_geo_lat_CUSTOM_ErrorCount
          ,le.mail_geo_long_CUSTOM_ErrorCount
          ,le.mail_msa_CUSTOM_ErrorCount
          ,le.mail_geo_blk_CUSTOM_ErrorCount
          ,le.mail_geo_match_CUSTOM_ErrorCount
          ,le.mail_err_stat_CUSTOM_ErrorCount
          ,le.marriedappend_ENUM_ErrorCount
          ,le.changedate_CUSTOM_ErrorCount
          ,le.name_type_ENUM_ErrorCount
          ,le.addr_type_ENUM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.rid_CUSTOM_ErrorCount
          ,le.did_CUSTOM_ErrorCount
          ,le.did_score_CUSTOM_ErrorCount
          ,le.ssn_CUSTOM_ErrorCount
          ,le.vtid_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.source_ENUM_ErrorCount
          ,le.file_id_ENUM_ErrorCount
          ,le.vendor_id_CUSTOM_ErrorCount
          ,le.source_state_CUSTOM_ErrorCount
          ,le.file_acquired_date_CUSTOM_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.first_name_ALLOW_ErrorCount
          ,le.middle_name_ALLOW_ErrorCount
          ,le.source_voterid_CUSTOM_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.agecat_CUSTOM_ErrorCount
          ,le.agecat_exp_CUSTOM_ErrorCount
          ,le.regdate_CUSTOM_ErrorCount
          ,le.race_CUSTOM_ErrorCount
          ,le.race_exp_CUSTOM_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.political_party_CUSTOM_ErrorCount
          ,le.politicalparty_exp_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.work_phone_CUSTOM_ErrorCount
          ,le.other_phone_ALLOW_ErrorCount
          ,le.active_status_ALLOW_ErrorCount
          ,le.active_status_exp_ENUM_ErrorCount
          ,le.gendersurnamguess_ALLOW_ErrorCount
          ,le.active_other_ALLOW_ErrorCount
          ,le.voter_status_ALLOW_ErrorCount
          ,le.voter_status_exp_CUSTOM_ErrorCount
          ,le.timezonetbl_ALLOW_ErrorCount
          ,le.distcode_ALLOW_ErrorCount
          ,le.countycode_ALLOW_ErrorCount
          ,le.schoolcode_ALLOW_ErrorCount
          ,le.statehouse_ALLOW_ErrorCount
          ,le.statesenate_ALLOW_ErrorCount
          ,le.ushouse_ALLOW_ErrorCount
          ,le.lastdatevote_CUSTOM_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_CUSTOM_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.p_city_name_CUSTOM_ErrorCount
          ,le.v_city_name_CUSTOM_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.cart_CUSTOM_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_CUSTOM_ErrorCount
          ,le.lot_order_ENUM_ErrorCount
          ,le.dpbc_CUSTOM_ErrorCount
          ,le.chk_digit_CUSTOM_ErrorCount
          ,le.rec_type_CUSTOM_ErrorCount
          ,le.ace_fips_st_CUSTOM_ErrorCount
          ,le.fips_county_CUSTOM_ErrorCount
          ,le.geo_lat_CUSTOM_ErrorCount
          ,le.geo_long_CUSTOM_ErrorCount
          ,le.msa_CUSTOM_ErrorCount
          ,le.geo_blk_CUSTOM_ErrorCount
          ,le.geo_match_CUSTOM_ErrorCount
          ,le.err_stat_CUSTOM_ErrorCount
          ,le.mail_predir_ALLOW_ErrorCount
          ,le.mail_prim_name_CUSTOM_ErrorCount
          ,le.mail_postdir_ALLOW_ErrorCount
          ,le.mail_p_city_name_CUSTOM_ErrorCount
          ,le.mail_v_city_name_CUSTOM_ErrorCount
          ,le.mail_st_CUSTOM_ErrorCount
          ,le.mail_ace_zip_CUSTOM_ErrorCount
          ,le.mail_zip4_CUSTOM_ErrorCount
          ,le.mail_cart_CUSTOM_ErrorCount
          ,le.mail_cr_sort_sz_ENUM_ErrorCount
          ,le.mail_lot_CUSTOM_ErrorCount
          ,le.mail_lot_order_ENUM_ErrorCount
          ,le.mail_dpbc_CUSTOM_ErrorCount
          ,le.mail_chk_digit_CUSTOM_ErrorCount
          ,le.mail_rec_type_CUSTOM_ErrorCount
          ,le.mail_ace_fips_st_CUSTOM_ErrorCount
          ,le.mail_fips_county_CUSTOM_ErrorCount
          ,le.mail_geo_lat_CUSTOM_ErrorCount
          ,le.mail_geo_long_CUSTOM_ErrorCount
          ,le.mail_msa_CUSTOM_ErrorCount
          ,le.mail_geo_blk_CUSTOM_ErrorCount
          ,le.mail_geo_match_CUSTOM_ErrorCount
          ,le.mail_err_stat_CUSTOM_ErrorCount
          ,le.marriedappend_ENUM_ErrorCount
          ,le.changedate_CUSTOM_ErrorCount
          ,le.name_type_ENUM_ErrorCount
          ,le.addr_type_ENUM_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT39.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT39.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Base_Reg_hygiene(PROJECT(h, Base_Reg_Layout_Voters));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT39.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'rid:' + getFieldTypeText(h.rid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_score:' + getFieldTypeText(h.did_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn:' + getFieldTypeText(h.ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vtid:' + getFieldTypeText(h.vtid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_first_seen:' + getFieldTypeText(h.date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_last_seen:' + getFieldTypeText(h.date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source:' + getFieldTypeText(h.source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_id:' + getFieldTypeText(h.file_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_id:' + getFieldTypeText(h.vendor_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_state:' + getFieldTypeText(h.source_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_code:' + getFieldTypeText(h.source_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_acquired_date:' + getFieldTypeText(h.file_acquired_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'use_code:' + getFieldTypeText(h.use_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prefix_title:' + getFieldTypeText(h.prefix_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_name:' + getFieldTypeText(h.last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_name:' + getFieldTypeText(h.first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'middle_name:' + getFieldTypeText(h.middle_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'maiden_prior:' + getFieldTypeText(h.maiden_prior) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_maiden_pri:' + getFieldTypeText(h.clean_maiden_pri) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix_in:' + getFieldTypeText(h.name_suffix_in) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'voterfiller:' + getFieldTypeText(h.voterfiller) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_voterid:' + getFieldTypeText(h.source_voterid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'agecat:' + getFieldTypeText(h.agecat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'agecat_exp:' + getFieldTypeText(h.agecat_exp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'headhousehold:' + getFieldTypeText(h.headhousehold) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'place_of_birth:' + getFieldTypeText(h.place_of_birth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'occupation:' + getFieldTypeText(h.occupation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'maiden_name:' + getFieldTypeText(h.maiden_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'motorvoterid:' + getFieldTypeText(h.motorvoterid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'regsource:' + getFieldTypeText(h.regsource) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'regdate:' + getFieldTypeText(h.regdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'race:' + getFieldTypeText(h.race) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'race_exp:' + getFieldTypeText(h.race_exp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'political_party:' + getFieldTypeText(h.political_party) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'politicalparty_exp:' + getFieldTypeText(h.politicalparty_exp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'work_phone:' + getFieldTypeText(h.work_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_phone:' + getFieldTypeText(h.other_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'active_status:' + getFieldTypeText(h.active_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'active_status_exp:' + getFieldTypeText(h.active_status_exp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gendersurnamguess:' + getFieldTypeText(h.gendersurnamguess) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'active_other:' + getFieldTypeText(h.active_other) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'voter_status:' + getFieldTypeText(h.voter_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'voter_status_exp:' + getFieldTypeText(h.voter_status_exp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'res_addr1:' + getFieldTypeText(h.res_addr1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'res_addr2:' + getFieldTypeText(h.res_addr2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'res_city:' + getFieldTypeText(h.res_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'res_state:' + getFieldTypeText(h.res_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'res_zip:' + getFieldTypeText(h.res_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'res_county:' + getFieldTypeText(h.res_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_addr1:' + getFieldTypeText(h.mail_addr1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_addr2:' + getFieldTypeText(h.mail_addr2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_city:' + getFieldTypeText(h.mail_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_state:' + getFieldTypeText(h.mail_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_zip:' + getFieldTypeText(h.mail_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_county:' + getFieldTypeText(h.mail_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_filler1:' + getFieldTypeText(h.addr_filler1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_filler2:' + getFieldTypeText(h.addr_filler2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city_filler:' + getFieldTypeText(h.city_filler) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_filler:' + getFieldTypeText(h.state_filler) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_filler:' + getFieldTypeText(h.zip_filler) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'timezonetbl:' + getFieldTypeText(h.timezonetbl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'towncode:' + getFieldTypeText(h.towncode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'distcode:' + getFieldTypeText(h.distcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'countycode:' + getFieldTypeText(h.countycode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'schoolcode:' + getFieldTypeText(h.schoolcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cityinout:' + getFieldTypeText(h.cityinout) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spec_dist1:' + getFieldTypeText(h.spec_dist1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spec_dist2:' + getFieldTypeText(h.spec_dist2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'precinct1:' + getFieldTypeText(h.precinct1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'precinct2:' + getFieldTypeText(h.precinct2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'precinct3:' + getFieldTypeText(h.precinct3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'villageprecinct:' + getFieldTypeText(h.villageprecinct) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'schoolprecinct:' + getFieldTypeText(h.schoolprecinct) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ward:' + getFieldTypeText(h.ward) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'precinct_citytown:' + getFieldTypeText(h.precinct_citytown) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ancsmdindc:' + getFieldTypeText(h.ancsmdindc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'citycouncildist:' + getFieldTypeText(h.citycouncildist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'countycommdist:' + getFieldTypeText(h.countycommdist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'statehouse:' + getFieldTypeText(h.statehouse) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'statesenate:' + getFieldTypeText(h.statesenate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ushouse:' + getFieldTypeText(h.ushouse) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'elemschooldist:' + getFieldTypeText(h.elemschooldist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'schooldist:' + getFieldTypeText(h.schooldist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'schoolfiller:' + getFieldTypeText(h.schoolfiller) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commcolldist:' + getFieldTypeText(h.commcolldist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dist_filler:' + getFieldTypeText(h.dist_filler) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'municipal:' + getFieldTypeText(h.municipal) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'villagedist:' + getFieldTypeText(h.villagedist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'policejury:' + getFieldTypeText(h.policejury) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'policedist:' + getFieldTypeText(h.policedist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'publicservcomm:' + getFieldTypeText(h.publicservcomm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rescue:' + getFieldTypeText(h.rescue) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fire:' + getFieldTypeText(h.fire) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sanitary:' + getFieldTypeText(h.sanitary) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sewerdist:' + getFieldTypeText(h.sewerdist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'waterdist:' + getFieldTypeText(h.waterdist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mosquitodist:' + getFieldTypeText(h.mosquitodist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'taxdist:' + getFieldTypeText(h.taxdist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'supremecourt:' + getFieldTypeText(h.supremecourt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'justiceofpeace:' + getFieldTypeText(h.justiceofpeace) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'judicialdist:' + getFieldTypeText(h.judicialdist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'superiorctdist:' + getFieldTypeText(h.superiorctdist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'appealsct:' + getFieldTypeText(h.appealsct) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'courtfiller:' + getFieldTypeText(h.courtfiller) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cassaddrtyptbl:' + getFieldTypeText(h.cassaddrtyptbl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cassdelivpointcd:' + getFieldTypeText(h.cassdelivpointcd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'casscarrierrtetbl:' + getFieldTypeText(h.casscarrierrtetbl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'blkgrpenumdist:' + getFieldTypeText(h.blkgrpenumdist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'congressionaldist:' + getFieldTypeText(h.congressionaldist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lattitude:' + getFieldTypeText(h.lattitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'countyfips:' + getFieldTypeText(h.countyfips) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'censustract:' + getFieldTypeText(h.censustract) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fipsstcountycd:' + getFieldTypeText(h.fipsstcountycd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'longitude:' + getFieldTypeText(h.longitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contributorparty:' + getFieldTypeText(h.contributorparty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recipientparty:' + getFieldTypeText(h.recipientparty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateofcontr:' + getFieldTypeText(h.dateofcontr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dollaramt:' + getFieldTypeText(h.dollaramt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officecontto:' + getFieldTypeText(h.officecontto) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cumuldollaramt:' + getFieldTypeText(h.cumuldollaramt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contfiller1:' + getFieldTypeText(h.contfiller1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contfiller2:' + getFieldTypeText(h.contfiller2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'conttype:' + getFieldTypeText(h.conttype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contfiller4:' + getFieldTypeText(h.contfiller4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lastdatevote:' + getFieldTypeText(h.lastdatevote) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'miscvotehist:' + getFieldTypeText(h.miscvotehist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_score:' + getFieldTypeText(h.name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix:' + getFieldTypeText(h.addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpbc:' + getFieldTypeText(h.dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_st:' + getFieldTypeText(h.ace_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_prim_range:' + getFieldTypeText(h.mail_prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_predir:' + getFieldTypeText(h.mail_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_prim_name:' + getFieldTypeText(h.mail_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_addr_suffix:' + getFieldTypeText(h.mail_addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_postdir:' + getFieldTypeText(h.mail_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_unit_desig:' + getFieldTypeText(h.mail_unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_sec_range:' + getFieldTypeText(h.mail_sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_p_city_name:' + getFieldTypeText(h.mail_p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_v_city_name:' + getFieldTypeText(h.mail_v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_st:' + getFieldTypeText(h.mail_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_ace_zip:' + getFieldTypeText(h.mail_ace_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_zip4:' + getFieldTypeText(h.mail_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_cart:' + getFieldTypeText(h.mail_cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_cr_sort_sz:' + getFieldTypeText(h.mail_cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_lot:' + getFieldTypeText(h.mail_lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_lot_order:' + getFieldTypeText(h.mail_lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_dpbc:' + getFieldTypeText(h.mail_dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_chk_digit:' + getFieldTypeText(h.mail_chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_rec_type:' + getFieldTypeText(h.mail_rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_ace_fips_st:' + getFieldTypeText(h.mail_ace_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_fips_county:' + getFieldTypeText(h.mail_fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_geo_lat:' + getFieldTypeText(h.mail_geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_geo_long:' + getFieldTypeText(h.mail_geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_msa:' + getFieldTypeText(h.mail_msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_geo_blk:' + getFieldTypeText(h.mail_geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_geo_match:' + getFieldTypeText(h.mail_geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_err_stat:' + getFieldTypeText(h.mail_err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'idtypes:' + getFieldTypeText(h.idtypes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'precinct:' + getFieldTypeText(h.precinct) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ward1:' + getFieldTypeText(h.ward1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'idcode:' + getFieldTypeText(h.idcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'precinctparttextdesig:' + getFieldTypeText(h.precinctparttextdesig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'precinctparttextname:' + getFieldTypeText(h.precinctparttextname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'precincttextdesig:' + getFieldTypeText(h.precincttextdesig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'marriedappend:' + getFieldTypeText(h.marriedappend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'supervisordistrict:' + getFieldTypeText(h.supervisordistrict) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'district:' + getFieldTypeText(h.district) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ward2:' + getFieldTypeText(h.ward2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'citycountycouncil:' + getFieldTypeText(h.citycountycouncil) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'countyprecinct:' + getFieldTypeText(h.countyprecinct) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'countycommis:' + getFieldTypeText(h.countycommis) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'schoolboard:' + getFieldTypeText(h.schoolboard) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ward3:' + getFieldTypeText(h.ward3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'towncitycouncil1:' + getFieldTypeText(h.towncitycouncil1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'towncitycouncil2:' + getFieldTypeText(h.towncitycouncil2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'regents:' + getFieldTypeText(h.regents) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'watershed:' + getFieldTypeText(h.watershed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'education:' + getFieldTypeText(h.education) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'policeconstable:' + getFieldTypeText(h.policeconstable) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'freeholder:' + getFieldTypeText(h.freeholder) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'municourt:' + getFieldTypeText(h.municourt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'changedate:' + getFieldTypeText(h.changedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_type:' + getFieldTypeText(h.name_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_type:' + getFieldTypeText(h.addr_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_rid_cnt
          ,le.populated_did_cnt
          ,le.populated_did_score_cnt
          ,le.populated_ssn_cnt
          ,le.populated_vtid_cnt
          ,le.populated_process_date_cnt
          ,le.populated_date_first_seen_cnt
          ,le.populated_date_last_seen_cnt
          ,le.populated_source_cnt
          ,le.populated_file_id_cnt
          ,le.populated_vendor_id_cnt
          ,le.populated_source_state_cnt
          ,le.populated_source_code_cnt
          ,le.populated_file_acquired_date_cnt
          ,le.populated_use_code_cnt
          ,le.populated_prefix_title_cnt
          ,le.populated_last_name_cnt
          ,le.populated_first_name_cnt
          ,le.populated_middle_name_cnt
          ,le.populated_maiden_prior_cnt
          ,le.populated_clean_maiden_pri_cnt
          ,le.populated_name_suffix_in_cnt
          ,le.populated_voterfiller_cnt
          ,le.populated_source_voterid_cnt
          ,le.populated_dob_cnt
          ,le.populated_agecat_cnt
          ,le.populated_agecat_exp_cnt
          ,le.populated_headhousehold_cnt
          ,le.populated_place_of_birth_cnt
          ,le.populated_occupation_cnt
          ,le.populated_maiden_name_cnt
          ,le.populated_motorvoterid_cnt
          ,le.populated_regsource_cnt
          ,le.populated_regdate_cnt
          ,le.populated_race_cnt
          ,le.populated_race_exp_cnt
          ,le.populated_gender_cnt
          ,le.populated_political_party_cnt
          ,le.populated_politicalparty_exp_cnt
          ,le.populated_phone_cnt
          ,le.populated_work_phone_cnt
          ,le.populated_other_phone_cnt
          ,le.populated_active_status_cnt
          ,le.populated_active_status_exp_cnt
          ,le.populated_gendersurnamguess_cnt
          ,le.populated_active_other_cnt
          ,le.populated_voter_status_cnt
          ,le.populated_voter_status_exp_cnt
          ,le.populated_res_addr1_cnt
          ,le.populated_res_addr2_cnt
          ,le.populated_res_city_cnt
          ,le.populated_res_state_cnt
          ,le.populated_res_zip_cnt
          ,le.populated_res_county_cnt
          ,le.populated_mail_addr1_cnt
          ,le.populated_mail_addr2_cnt
          ,le.populated_mail_city_cnt
          ,le.populated_mail_state_cnt
          ,le.populated_mail_zip_cnt
          ,le.populated_mail_county_cnt
          ,le.populated_addr_filler1_cnt
          ,le.populated_addr_filler2_cnt
          ,le.populated_city_filler_cnt
          ,le.populated_state_filler_cnt
          ,le.populated_zip_filler_cnt
          ,le.populated_timezonetbl_cnt
          ,le.populated_towncode_cnt
          ,le.populated_distcode_cnt
          ,le.populated_countycode_cnt
          ,le.populated_schoolcode_cnt
          ,le.populated_cityinout_cnt
          ,le.populated_spec_dist1_cnt
          ,le.populated_spec_dist2_cnt
          ,le.populated_precinct1_cnt
          ,le.populated_precinct2_cnt
          ,le.populated_precinct3_cnt
          ,le.populated_villageprecinct_cnt
          ,le.populated_schoolprecinct_cnt
          ,le.populated_ward_cnt
          ,le.populated_precinct_citytown_cnt
          ,le.populated_ancsmdindc_cnt
          ,le.populated_citycouncildist_cnt
          ,le.populated_countycommdist_cnt
          ,le.populated_statehouse_cnt
          ,le.populated_statesenate_cnt
          ,le.populated_ushouse_cnt
          ,le.populated_elemschooldist_cnt
          ,le.populated_schooldist_cnt
          ,le.populated_schoolfiller_cnt
          ,le.populated_commcolldist_cnt
          ,le.populated_dist_filler_cnt
          ,le.populated_municipal_cnt
          ,le.populated_villagedist_cnt
          ,le.populated_policejury_cnt
          ,le.populated_policedist_cnt
          ,le.populated_publicservcomm_cnt
          ,le.populated_rescue_cnt
          ,le.populated_fire_cnt
          ,le.populated_sanitary_cnt
          ,le.populated_sewerdist_cnt
          ,le.populated_waterdist_cnt
          ,le.populated_mosquitodist_cnt
          ,le.populated_taxdist_cnt
          ,le.populated_supremecourt_cnt
          ,le.populated_justiceofpeace_cnt
          ,le.populated_judicialdist_cnt
          ,le.populated_superiorctdist_cnt
          ,le.populated_appealsct_cnt
          ,le.populated_courtfiller_cnt
          ,le.populated_cassaddrtyptbl_cnt
          ,le.populated_cassdelivpointcd_cnt
          ,le.populated_casscarrierrtetbl_cnt
          ,le.populated_blkgrpenumdist_cnt
          ,le.populated_congressionaldist_cnt
          ,le.populated_lattitude_cnt
          ,le.populated_countyfips_cnt
          ,le.populated_censustract_cnt
          ,le.populated_fipsstcountycd_cnt
          ,le.populated_longitude_cnt
          ,le.populated_contributorparty_cnt
          ,le.populated_recipientparty_cnt
          ,le.populated_dateofcontr_cnt
          ,le.populated_dollaramt_cnt
          ,le.populated_officecontto_cnt
          ,le.populated_cumuldollaramt_cnt
          ,le.populated_contfiller1_cnt
          ,le.populated_contfiller2_cnt
          ,le.populated_conttype_cnt
          ,le.populated_contfiller4_cnt
          ,le.populated_lastdatevote_cnt
          ,le.populated_miscvotehist_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_name_score_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_addr_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dpbc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_ace_fips_st_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_mail_prim_range_cnt
          ,le.populated_mail_predir_cnt
          ,le.populated_mail_prim_name_cnt
          ,le.populated_mail_addr_suffix_cnt
          ,le.populated_mail_postdir_cnt
          ,le.populated_mail_unit_desig_cnt
          ,le.populated_mail_sec_range_cnt
          ,le.populated_mail_p_city_name_cnt
          ,le.populated_mail_v_city_name_cnt
          ,le.populated_mail_st_cnt
          ,le.populated_mail_ace_zip_cnt
          ,le.populated_mail_zip4_cnt
          ,le.populated_mail_cart_cnt
          ,le.populated_mail_cr_sort_sz_cnt
          ,le.populated_mail_lot_cnt
          ,le.populated_mail_lot_order_cnt
          ,le.populated_mail_dpbc_cnt
          ,le.populated_mail_chk_digit_cnt
          ,le.populated_mail_rec_type_cnt
          ,le.populated_mail_ace_fips_st_cnt
          ,le.populated_mail_fips_county_cnt
          ,le.populated_mail_geo_lat_cnt
          ,le.populated_mail_geo_long_cnt
          ,le.populated_mail_msa_cnt
          ,le.populated_mail_geo_blk_cnt
          ,le.populated_mail_geo_match_cnt
          ,le.populated_mail_err_stat_cnt
          ,le.populated_idtypes_cnt
          ,le.populated_precinct_cnt
          ,le.populated_ward1_cnt
          ,le.populated_idcode_cnt
          ,le.populated_precinctparttextdesig_cnt
          ,le.populated_precinctparttextname_cnt
          ,le.populated_precincttextdesig_cnt
          ,le.populated_marriedappend_cnt
          ,le.populated_supervisordistrict_cnt
          ,le.populated_district_cnt
          ,le.populated_ward2_cnt
          ,le.populated_citycountycouncil_cnt
          ,le.populated_countyprecinct_cnt
          ,le.populated_countycommis_cnt
          ,le.populated_schoolboard_cnt
          ,le.populated_ward3_cnt
          ,le.populated_towncitycouncil1_cnt
          ,le.populated_towncitycouncil2_cnt
          ,le.populated_regents_cnt
          ,le.populated_watershed_cnt
          ,le.populated_education_cnt
          ,le.populated_policeconstable_cnt
          ,le.populated_freeholder_cnt
          ,le.populated_municourt_cnt
          ,le.populated_changedate_cnt
          ,le.populated_name_type_cnt
          ,le.populated_addr_type_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_rid_pcnt
          ,le.populated_did_pcnt
          ,le.populated_did_score_pcnt
          ,le.populated_ssn_pcnt
          ,le.populated_vtid_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_date_first_seen_pcnt
          ,le.populated_date_last_seen_pcnt
          ,le.populated_source_pcnt
          ,le.populated_file_id_pcnt
          ,le.populated_vendor_id_pcnt
          ,le.populated_source_state_pcnt
          ,le.populated_source_code_pcnt
          ,le.populated_file_acquired_date_pcnt
          ,le.populated_use_code_pcnt
          ,le.populated_prefix_title_pcnt
          ,le.populated_last_name_pcnt
          ,le.populated_first_name_pcnt
          ,le.populated_middle_name_pcnt
          ,le.populated_maiden_prior_pcnt
          ,le.populated_clean_maiden_pri_pcnt
          ,le.populated_name_suffix_in_pcnt
          ,le.populated_voterfiller_pcnt
          ,le.populated_source_voterid_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_agecat_pcnt
          ,le.populated_agecat_exp_pcnt
          ,le.populated_headhousehold_pcnt
          ,le.populated_place_of_birth_pcnt
          ,le.populated_occupation_pcnt
          ,le.populated_maiden_name_pcnt
          ,le.populated_motorvoterid_pcnt
          ,le.populated_regsource_pcnt
          ,le.populated_regdate_pcnt
          ,le.populated_race_pcnt
          ,le.populated_race_exp_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_political_party_pcnt
          ,le.populated_politicalparty_exp_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_work_phone_pcnt
          ,le.populated_other_phone_pcnt
          ,le.populated_active_status_pcnt
          ,le.populated_active_status_exp_pcnt
          ,le.populated_gendersurnamguess_pcnt
          ,le.populated_active_other_pcnt
          ,le.populated_voter_status_pcnt
          ,le.populated_voter_status_exp_pcnt
          ,le.populated_res_addr1_pcnt
          ,le.populated_res_addr2_pcnt
          ,le.populated_res_city_pcnt
          ,le.populated_res_state_pcnt
          ,le.populated_res_zip_pcnt
          ,le.populated_res_county_pcnt
          ,le.populated_mail_addr1_pcnt
          ,le.populated_mail_addr2_pcnt
          ,le.populated_mail_city_pcnt
          ,le.populated_mail_state_pcnt
          ,le.populated_mail_zip_pcnt
          ,le.populated_mail_county_pcnt
          ,le.populated_addr_filler1_pcnt
          ,le.populated_addr_filler2_pcnt
          ,le.populated_city_filler_pcnt
          ,le.populated_state_filler_pcnt
          ,le.populated_zip_filler_pcnt
          ,le.populated_timezonetbl_pcnt
          ,le.populated_towncode_pcnt
          ,le.populated_distcode_pcnt
          ,le.populated_countycode_pcnt
          ,le.populated_schoolcode_pcnt
          ,le.populated_cityinout_pcnt
          ,le.populated_spec_dist1_pcnt
          ,le.populated_spec_dist2_pcnt
          ,le.populated_precinct1_pcnt
          ,le.populated_precinct2_pcnt
          ,le.populated_precinct3_pcnt
          ,le.populated_villageprecinct_pcnt
          ,le.populated_schoolprecinct_pcnt
          ,le.populated_ward_pcnt
          ,le.populated_precinct_citytown_pcnt
          ,le.populated_ancsmdindc_pcnt
          ,le.populated_citycouncildist_pcnt
          ,le.populated_countycommdist_pcnt
          ,le.populated_statehouse_pcnt
          ,le.populated_statesenate_pcnt
          ,le.populated_ushouse_pcnt
          ,le.populated_elemschooldist_pcnt
          ,le.populated_schooldist_pcnt
          ,le.populated_schoolfiller_pcnt
          ,le.populated_commcolldist_pcnt
          ,le.populated_dist_filler_pcnt
          ,le.populated_municipal_pcnt
          ,le.populated_villagedist_pcnt
          ,le.populated_policejury_pcnt
          ,le.populated_policedist_pcnt
          ,le.populated_publicservcomm_pcnt
          ,le.populated_rescue_pcnt
          ,le.populated_fire_pcnt
          ,le.populated_sanitary_pcnt
          ,le.populated_sewerdist_pcnt
          ,le.populated_waterdist_pcnt
          ,le.populated_mosquitodist_pcnt
          ,le.populated_taxdist_pcnt
          ,le.populated_supremecourt_pcnt
          ,le.populated_justiceofpeace_pcnt
          ,le.populated_judicialdist_pcnt
          ,le.populated_superiorctdist_pcnt
          ,le.populated_appealsct_pcnt
          ,le.populated_courtfiller_pcnt
          ,le.populated_cassaddrtyptbl_pcnt
          ,le.populated_cassdelivpointcd_pcnt
          ,le.populated_casscarrierrtetbl_pcnt
          ,le.populated_blkgrpenumdist_pcnt
          ,le.populated_congressionaldist_pcnt
          ,le.populated_lattitude_pcnt
          ,le.populated_countyfips_pcnt
          ,le.populated_censustract_pcnt
          ,le.populated_fipsstcountycd_pcnt
          ,le.populated_longitude_pcnt
          ,le.populated_contributorparty_pcnt
          ,le.populated_recipientparty_pcnt
          ,le.populated_dateofcontr_pcnt
          ,le.populated_dollaramt_pcnt
          ,le.populated_officecontto_pcnt
          ,le.populated_cumuldollaramt_pcnt
          ,le.populated_contfiller1_pcnt
          ,le.populated_contfiller2_pcnt
          ,le.populated_conttype_pcnt
          ,le.populated_contfiller4_pcnt
          ,le.populated_lastdatevote_pcnt
          ,le.populated_miscvotehist_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_name_score_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_addr_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dpbc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_ace_fips_st_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_mail_prim_range_pcnt
          ,le.populated_mail_predir_pcnt
          ,le.populated_mail_prim_name_pcnt
          ,le.populated_mail_addr_suffix_pcnt
          ,le.populated_mail_postdir_pcnt
          ,le.populated_mail_unit_desig_pcnt
          ,le.populated_mail_sec_range_pcnt
          ,le.populated_mail_p_city_name_pcnt
          ,le.populated_mail_v_city_name_pcnt
          ,le.populated_mail_st_pcnt
          ,le.populated_mail_ace_zip_pcnt
          ,le.populated_mail_zip4_pcnt
          ,le.populated_mail_cart_pcnt
          ,le.populated_mail_cr_sort_sz_pcnt
          ,le.populated_mail_lot_pcnt
          ,le.populated_mail_lot_order_pcnt
          ,le.populated_mail_dpbc_pcnt
          ,le.populated_mail_chk_digit_pcnt
          ,le.populated_mail_rec_type_pcnt
          ,le.populated_mail_ace_fips_st_pcnt
          ,le.populated_mail_fips_county_pcnt
          ,le.populated_mail_geo_lat_pcnt
          ,le.populated_mail_geo_long_pcnt
          ,le.populated_mail_msa_pcnt
          ,le.populated_mail_geo_blk_pcnt
          ,le.populated_mail_geo_match_pcnt
          ,le.populated_mail_err_stat_pcnt
          ,le.populated_idtypes_pcnt
          ,le.populated_precinct_pcnt
          ,le.populated_ward1_pcnt
          ,le.populated_idcode_pcnt
          ,le.populated_precinctparttextdesig_pcnt
          ,le.populated_precinctparttextname_pcnt
          ,le.populated_precincttextdesig_pcnt
          ,le.populated_marriedappend_pcnt
          ,le.populated_supervisordistrict_pcnt
          ,le.populated_district_pcnt
          ,le.populated_ward2_pcnt
          ,le.populated_citycountycouncil_pcnt
          ,le.populated_countyprecinct_pcnt
          ,le.populated_countycommis_pcnt
          ,le.populated_schoolboard_pcnt
          ,le.populated_ward3_pcnt
          ,le.populated_towncitycouncil1_pcnt
          ,le.populated_towncitycouncil2_pcnt
          ,le.populated_regents_pcnt
          ,le.populated_watershed_pcnt
          ,le.populated_education_pcnt
          ,le.populated_policeconstable_pcnt
          ,le.populated_freeholder_pcnt
          ,le.populated_municourt_pcnt
          ,le.populated_changedate_pcnt
          ,le.populated_name_type_pcnt
          ,le.populated_addr_type_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,218,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT39.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Base_Reg_Delta(prevDS, PROJECT(h, Base_Reg_Layout_Voters));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),218,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_Reg_Layout_Voters) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Voters, Base_Reg_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT39.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT39.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;

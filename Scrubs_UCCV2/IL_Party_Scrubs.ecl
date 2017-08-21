IMPORT SALT37;
IMPORT Scrubs_UCCV2; // Import modules for FieldTypes attribute definitions
EXPORT IL_Party_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(IL_Party_Layout_UCCV2)
    UNSIGNED1 tmsid_Invalid;
    UNSIGNED1 rmsid_Invalid;
    UNSIGNED1 orig_name_Invalid;
    UNSIGNED1 orig_lname_Invalid;
    UNSIGNED1 orig_fname_Invalid;
    UNSIGNED1 duns_number_Invalid;
    UNSIGNED1 hq_duns_number_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 fein_Invalid;
    UNSIGNED1 incorp_state_Invalid;
    UNSIGNED1 corp_number_Invalid;
    UNSIGNED1 corp_type_Invalid;
    UNSIGNED1 orig_address1_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 orig_zip5_Invalid;
    UNSIGNED1 foreign_indc_Invalid;
    UNSIGNED1 party_type_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_desig_Invalid;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip5_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 county_Invalid;
    UNSIGNED1 cart_Invalid;
    UNSIGNED1 cr_sort_sz_Invalid;
    UNSIGNED1 lot_Invalid;
    UNSIGNED1 lot_order_Invalid;
    UNSIGNED1 dpbc_Invalid;
    UNSIGNED1 chk_digit_Invalid;
    UNSIGNED1 rec_type_Invalid;
    UNSIGNED1 ace_fips_st_Invalid;
    UNSIGNED1 ace_fips_county_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 geo_blk_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 bdid_score_Invalid;
    UNSIGNED1 source_rec_id_Invalid;
    UNSIGNED1 dotid_Invalid;
    UNSIGNED1 dotscore_Invalid;
    UNSIGNED1 dotweight_Invalid;
    UNSIGNED1 empid_Invalid;
    UNSIGNED1 empscore_Invalid;
    UNSIGNED1 empweight_Invalid;
    UNSIGNED1 powid_Invalid;
    UNSIGNED1 powscore_Invalid;
    UNSIGNED1 powweight_Invalid;
    UNSIGNED1 proxid_Invalid;
    UNSIGNED1 proxscore_Invalid;
    UNSIGNED1 proxweight_Invalid;
    UNSIGNED1 seleid_Invalid;
    UNSIGNED1 selescore_Invalid;
    UNSIGNED1 seleweight_Invalid;
    UNSIGNED1 orgid_Invalid;
    UNSIGNED1 orgscore_Invalid;
    UNSIGNED1 orgweight_Invalid;
    UNSIGNED1 ultid_Invalid;
    UNSIGNED1 ultscore_Invalid;
    UNSIGNED1 ultweight_Invalid;
    UNSIGNED1 prep_addr_line1_Invalid;
    UNSIGNED1 prep_addr_last_line_Invalid;
    UNSIGNED1 rawaid_Invalid;
    UNSIGNED1 aceaid_Invalid;
    UNSIGNED1 persistent_record_id_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(IL_Party_Layout_UCCV2)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(IL_Party_Layout_UCCV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.tmsid_Invalid := IL_Party_Fields.InValid_tmsid((SALT37.StrType)le.tmsid);
    SELF.rmsid_Invalid := IL_Party_Fields.InValid_rmsid((SALT37.StrType)le.rmsid);
    SELF.orig_name_Invalid := IL_Party_Fields.InValid_orig_name((SALT37.StrType)le.orig_name,(SALT37.StrType)le.orig_lname,(SALT37.StrType)le.orig_fname);
    SELF.orig_lname_Invalid := IL_Party_Fields.InValid_orig_lname((SALT37.StrType)le.orig_lname,(SALT37.StrType)le.orig_name,(SALT37.StrType)le.orig_fname);
    SELF.orig_fname_Invalid := IL_Party_Fields.InValid_orig_fname((SALT37.StrType)le.orig_fname,(SALT37.StrType)le.orig_name,(SALT37.StrType)le.orig_lname);
    SELF.duns_number_Invalid := IL_Party_Fields.InValid_duns_number((SALT37.StrType)le.duns_number);
    SELF.hq_duns_number_Invalid := IL_Party_Fields.InValid_hq_duns_number((SALT37.StrType)le.hq_duns_number);
    SELF.ssn_Invalid := IL_Party_Fields.InValid_ssn((SALT37.StrType)le.ssn);
    SELF.fein_Invalid := IL_Party_Fields.InValid_fein((SALT37.StrType)le.fein);
    SELF.incorp_state_Invalid := IL_Party_Fields.InValid_incorp_state((SALT37.StrType)le.incorp_state);
    SELF.corp_number_Invalid := IL_Party_Fields.InValid_corp_number((SALT37.StrType)le.corp_number);
    SELF.corp_type_Invalid := IL_Party_Fields.InValid_corp_type((SALT37.StrType)le.corp_type);
    SELF.orig_address1_Invalid := IL_Party_Fields.InValid_orig_address1((SALT37.StrType)le.orig_address1);
    SELF.orig_city_Invalid := IL_Party_Fields.InValid_orig_city((SALT37.StrType)le.orig_city);
    SELF.orig_state_Invalid := IL_Party_Fields.InValid_orig_state((SALT37.StrType)le.orig_state);
    SELF.orig_zip5_Invalid := IL_Party_Fields.InValid_orig_zip5((SALT37.StrType)le.orig_zip5);
    SELF.foreign_indc_Invalid := IL_Party_Fields.InValid_foreign_indc((SALT37.StrType)le.foreign_indc);
    SELF.party_type_Invalid := IL_Party_Fields.InValid_party_type((SALT37.StrType)le.party_type);
    SELF.dt_first_seen_Invalid := IL_Party_Fields.InValid_dt_first_seen((SALT37.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := IL_Party_Fields.InValid_dt_last_seen((SALT37.StrType)le.dt_last_seen);
    SELF.dt_vendor_last_reported_Invalid := IL_Party_Fields.InValid_dt_vendor_last_reported((SALT37.StrType)le.dt_vendor_last_reported);
    SELF.dt_vendor_first_reported_Invalid := IL_Party_Fields.InValid_dt_vendor_first_reported((SALT37.StrType)le.dt_vendor_first_reported);
    SELF.process_date_Invalid := IL_Party_Fields.InValid_process_date((SALT37.StrType)le.process_date);
    SELF.fname_Invalid := IL_Party_Fields.InValid_fname((SALT37.StrType)le.fname,(SALT37.StrType)le.mname,(SALT37.StrType)le.lname,(SALT37.StrType)le.company_name);
    SELF.mname_Invalid := IL_Party_Fields.InValid_mname((SALT37.StrType)le.mname,(SALT37.StrType)le.fname,(SALT37.StrType)le.lname,(SALT37.StrType)le.company_name);
    SELF.lname_Invalid := IL_Party_Fields.InValid_lname((SALT37.StrType)le.lname,(SALT37.StrType)le.fname,(SALT37.StrType)le.mname,(SALT37.StrType)le.company_name);
    SELF.company_name_Invalid := IL_Party_Fields.InValid_company_name((SALT37.StrType)le.company_name,(SALT37.StrType)le.fname,(SALT37.StrType)le.mname,(SALT37.StrType)le.lname);
    SELF.prim_range_Invalid := IL_Party_Fields.InValid_prim_range((SALT37.StrType)le.prim_range);
    SELF.predir_Invalid := IL_Party_Fields.InValid_predir((SALT37.StrType)le.predir);
    SELF.prim_name_Invalid := IL_Party_Fields.InValid_prim_name((SALT37.StrType)le.prim_name);
    SELF.suffix_Invalid := IL_Party_Fields.InValid_suffix((SALT37.StrType)le.suffix);
    SELF.postdir_Invalid := IL_Party_Fields.InValid_postdir((SALT37.StrType)le.postdir);
    SELF.unit_desig_Invalid := IL_Party_Fields.InValid_unit_desig((SALT37.StrType)le.unit_desig);
    SELF.sec_range_Invalid := IL_Party_Fields.InValid_sec_range((SALT37.StrType)le.sec_range);
    SELF.p_city_name_Invalid := IL_Party_Fields.InValid_p_city_name((SALT37.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := IL_Party_Fields.InValid_v_city_name((SALT37.StrType)le.v_city_name);
    SELF.st_Invalid := IL_Party_Fields.InValid_st((SALT37.StrType)le.st);
    SELF.zip5_Invalid := IL_Party_Fields.InValid_zip5((SALT37.StrType)le.zip5);
    SELF.zip4_Invalid := IL_Party_Fields.InValid_zip4((SALT37.StrType)le.zip4);
    SELF.county_Invalid := IL_Party_Fields.InValid_county((SALT37.StrType)le.county);
    SELF.cart_Invalid := IL_Party_Fields.InValid_cart((SALT37.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := IL_Party_Fields.InValid_cr_sort_sz((SALT37.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := IL_Party_Fields.InValid_lot((SALT37.StrType)le.lot);
    SELF.lot_order_Invalid := IL_Party_Fields.InValid_lot_order((SALT37.StrType)le.lot_order);
    SELF.dpbc_Invalid := IL_Party_Fields.InValid_dpbc((SALT37.StrType)le.dpbc);
    SELF.chk_digit_Invalid := IL_Party_Fields.InValid_chk_digit((SALT37.StrType)le.chk_digit);
    SELF.rec_type_Invalid := IL_Party_Fields.InValid_rec_type((SALT37.StrType)le.rec_type);
    SELF.ace_fips_st_Invalid := IL_Party_Fields.InValid_ace_fips_st((SALT37.StrType)le.ace_fips_st);
    SELF.ace_fips_county_Invalid := IL_Party_Fields.InValid_ace_fips_county((SALT37.StrType)le.ace_fips_county);
    SELF.geo_lat_Invalid := IL_Party_Fields.InValid_geo_lat((SALT37.StrType)le.geo_lat);
    SELF.geo_long_Invalid := IL_Party_Fields.InValid_geo_long((SALT37.StrType)le.geo_long);
    SELF.msa_Invalid := IL_Party_Fields.InValid_msa((SALT37.StrType)le.msa);
    SELF.geo_blk_Invalid := IL_Party_Fields.InValid_geo_blk((SALT37.StrType)le.geo_blk);
    SELF.geo_match_Invalid := IL_Party_Fields.InValid_geo_match((SALT37.StrType)le.geo_match);
    SELF.err_stat_Invalid := IL_Party_Fields.InValid_err_stat((SALT37.StrType)le.err_stat);
    SELF.bdid_Invalid := IL_Party_Fields.InValid_bdid((SALT37.StrType)le.bdid);
    SELF.did_Invalid := IL_Party_Fields.InValid_did((SALT37.StrType)le.did);
    SELF.did_score_Invalid := IL_Party_Fields.InValid_did_score((SALT37.StrType)le.did_score);
    SELF.bdid_score_Invalid := IL_Party_Fields.InValid_bdid_score((SALT37.StrType)le.bdid_score);
    SELF.source_rec_id_Invalid := IL_Party_Fields.InValid_source_rec_id((SALT37.StrType)le.source_rec_id);
    SELF.dotid_Invalid := IL_Party_Fields.InValid_dotid((SALT37.StrType)le.dotid);
    SELF.dotscore_Invalid := IL_Party_Fields.InValid_dotscore((SALT37.StrType)le.dotscore);
    SELF.dotweight_Invalid := IL_Party_Fields.InValid_dotweight((SALT37.StrType)le.dotweight);
    SELF.empid_Invalid := IL_Party_Fields.InValid_empid((SALT37.StrType)le.empid);
    SELF.empscore_Invalid := IL_Party_Fields.InValid_empscore((SALT37.StrType)le.empscore);
    SELF.empweight_Invalid := IL_Party_Fields.InValid_empweight((SALT37.StrType)le.empweight);
    SELF.powid_Invalid := IL_Party_Fields.InValid_powid((SALT37.StrType)le.powid);
    SELF.powscore_Invalid := IL_Party_Fields.InValid_powscore((SALT37.StrType)le.powscore);
    SELF.powweight_Invalid := IL_Party_Fields.InValid_powweight((SALT37.StrType)le.powweight);
    SELF.proxid_Invalid := IL_Party_Fields.InValid_proxid((SALT37.StrType)le.proxid);
    SELF.proxscore_Invalid := IL_Party_Fields.InValid_proxscore((SALT37.StrType)le.proxscore);
    SELF.proxweight_Invalid := IL_Party_Fields.InValid_proxweight((SALT37.StrType)le.proxweight);
    SELF.seleid_Invalid := IL_Party_Fields.InValid_seleid((SALT37.StrType)le.seleid);
    SELF.selescore_Invalid := IL_Party_Fields.InValid_selescore((SALT37.StrType)le.selescore);
    SELF.seleweight_Invalid := IL_Party_Fields.InValid_seleweight((SALT37.StrType)le.seleweight);
    SELF.orgid_Invalid := IL_Party_Fields.InValid_orgid((SALT37.StrType)le.orgid);
    SELF.orgscore_Invalid := IL_Party_Fields.InValid_orgscore((SALT37.StrType)le.orgscore);
    SELF.orgweight_Invalid := IL_Party_Fields.InValid_orgweight((SALT37.StrType)le.orgweight);
    SELF.ultid_Invalid := IL_Party_Fields.InValid_ultid((SALT37.StrType)le.ultid);
    SELF.ultscore_Invalid := IL_Party_Fields.InValid_ultscore((SALT37.StrType)le.ultscore);
    SELF.ultweight_Invalid := IL_Party_Fields.InValid_ultweight((SALT37.StrType)le.ultweight);
    SELF.prep_addr_line1_Invalid := IL_Party_Fields.InValid_prep_addr_line1((SALT37.StrType)le.prep_addr_line1);
    SELF.prep_addr_last_line_Invalid := IL_Party_Fields.InValid_prep_addr_last_line((SALT37.StrType)le.prep_addr_last_line);
    SELF.rawaid_Invalid := IL_Party_Fields.InValid_rawaid((SALT37.StrType)le.rawaid);
    SELF.aceaid_Invalid := IL_Party_Fields.InValid_aceaid((SALT37.StrType)le.aceaid);
    SELF.persistent_record_id_Invalid := IL_Party_Fields.InValid_persistent_record_id((SALT37.StrType)le.persistent_record_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),IL_Party_Layout_UCCV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.tmsid_Invalid << 0 ) + ( le.rmsid_Invalid << 1 ) + ( le.orig_name_Invalid << 2 ) + ( le.orig_lname_Invalid << 3 ) + ( le.orig_fname_Invalid << 4 ) + ( le.duns_number_Invalid << 5 ) + ( le.hq_duns_number_Invalid << 6 ) + ( le.ssn_Invalid << 7 ) + ( le.fein_Invalid << 8 ) + ( le.incorp_state_Invalid << 9 ) + ( le.corp_number_Invalid << 10 ) + ( le.corp_type_Invalid << 11 ) + ( le.orig_address1_Invalid << 12 ) + ( le.orig_city_Invalid << 13 ) + ( le.orig_state_Invalid << 14 ) + ( le.orig_zip5_Invalid << 15 ) + ( le.foreign_indc_Invalid << 16 ) + ( le.party_type_Invalid << 17 ) + ( le.dt_first_seen_Invalid << 18 ) + ( le.dt_last_seen_Invalid << 19 ) + ( le.dt_vendor_last_reported_Invalid << 20 ) + ( le.dt_vendor_first_reported_Invalid << 21 ) + ( le.process_date_Invalid << 22 ) + ( le.fname_Invalid << 23 ) + ( le.mname_Invalid << 24 ) + ( le.lname_Invalid << 25 ) + ( le.company_name_Invalid << 26 ) + ( le.prim_range_Invalid << 27 ) + ( le.predir_Invalid << 28 ) + ( le.prim_name_Invalid << 29 ) + ( le.suffix_Invalid << 30 ) + ( le.postdir_Invalid << 31 ) + ( le.unit_desig_Invalid << 32 ) + ( le.sec_range_Invalid << 33 ) + ( le.p_city_name_Invalid << 34 ) + ( le.v_city_name_Invalid << 35 ) + ( le.st_Invalid << 36 ) + ( le.zip5_Invalid << 37 ) + ( le.zip4_Invalid << 38 ) + ( le.county_Invalid << 39 ) + ( le.cart_Invalid << 40 ) + ( le.cr_sort_sz_Invalid << 41 ) + ( le.lot_Invalid << 42 ) + ( le.lot_order_Invalid << 43 ) + ( le.dpbc_Invalid << 44 ) + ( le.chk_digit_Invalid << 45 ) + ( le.rec_type_Invalid << 46 ) + ( le.ace_fips_st_Invalid << 47 ) + ( le.ace_fips_county_Invalid << 48 ) + ( le.geo_lat_Invalid << 49 ) + ( le.geo_long_Invalid << 50 ) + ( le.msa_Invalid << 51 ) + ( le.geo_blk_Invalid << 52 ) + ( le.geo_match_Invalid << 53 ) + ( le.err_stat_Invalid << 54 ) + ( le.bdid_Invalid << 55 ) + ( le.did_Invalid << 56 ) + ( le.did_score_Invalid << 57 ) + ( le.bdid_score_Invalid << 58 ) + ( le.source_rec_id_Invalid << 59 ) + ( le.dotid_Invalid << 60 ) + ( le.dotscore_Invalid << 61 ) + ( le.dotweight_Invalid << 62 ) + ( le.empid_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.empscore_Invalid << 0 ) + ( le.empweight_Invalid << 1 ) + ( le.powid_Invalid << 2 ) + ( le.powscore_Invalid << 3 ) + ( le.powweight_Invalid << 4 ) + ( le.proxid_Invalid << 5 ) + ( le.proxscore_Invalid << 6 ) + ( le.proxweight_Invalid << 7 ) + ( le.seleid_Invalid << 8 ) + ( le.selescore_Invalid << 9 ) + ( le.seleweight_Invalid << 10 ) + ( le.orgid_Invalid << 11 ) + ( le.orgscore_Invalid << 12 ) + ( le.orgweight_Invalid << 13 ) + ( le.ultid_Invalid << 14 ) + ( le.ultscore_Invalid << 15 ) + ( le.ultweight_Invalid << 16 ) + ( le.prep_addr_line1_Invalid << 17 ) + ( le.prep_addr_last_line_Invalid << 18 ) + ( le.rawaid_Invalid << 19 ) + ( le.aceaid_Invalid << 20 ) + ( le.persistent_record_id_Invalid << 21 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,IL_Party_Layout_UCCV2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.tmsid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.rmsid_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.orig_name_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orig_lname_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.orig_fname_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.duns_number_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.hq_duns_number_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.fein_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.incorp_state_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.corp_number_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.corp_type_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.orig_address1_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.orig_zip5_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.foreign_indc_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.party_type_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.zip5_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.county_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.cart_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.lot_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.lot_order_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.dpbc_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.chk_digit_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.rec_type_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.ace_fips_st_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.ace_fips_county_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.msa_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.geo_blk_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.geo_match_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.err_stat_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.did_score_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.bdid_score_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.source_rec_id_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.dotid_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.dotscore_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.dotweight_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.empid_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.empscore_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.empweight_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.powid_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.powscore_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.powweight_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.proxid_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.proxscore_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.proxweight_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.selescore_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.seleweight_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.orgscore_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.orgweight_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.ultid_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.ultscore_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.ultweight_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.prep_addr_line1_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.prep_addr_last_line_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.rawaid_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.aceaid_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.persistent_record_id_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    tmsid_CUSTOM_ErrorCount := COUNT(GROUP,h.tmsid_Invalid=1);
    rmsid_CUSTOM_ErrorCount := COUNT(GROUP,h.rmsid_Invalid=1);
    orig_name_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_name_Invalid=1);
    orig_lname_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=1);
    orig_fname_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=1);
    duns_number_LENGTH_ErrorCount := COUNT(GROUP,h.duns_number_Invalid=1);
    hq_duns_number_LENGTH_ErrorCount := COUNT(GROUP,h.hq_duns_number_Invalid=1);
    ssn_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    fein_LENGTH_ErrorCount := COUNT(GROUP,h.fein_Invalid=1);
    incorp_state_LENGTH_ErrorCount := COUNT(GROUP,h.incorp_state_Invalid=1);
    corp_number_LENGTH_ErrorCount := COUNT(GROUP,h.corp_number_Invalid=1);
    corp_type_LENGTH_ErrorCount := COUNT(GROUP,h.corp_type_Invalid=1);
    orig_address1_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_address1_Invalid=1);
    orig_city_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_state_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_zip5_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_zip5_Invalid=1);
    foreign_indc_ENUM_ErrorCount := COUNT(GROUP,h.foreign_indc_Invalid=1);
    party_type_ENUM_ErrorCount := COUNT(GROUP,h.party_type_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    fname_CUSTOM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    mname_CUSTOM_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    lname_CUSTOM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    company_name_CUSTOM_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    prim_range_LENGTH_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_LENGTH_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    suffix_LENGTH_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    postdir_LENGTH_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    unit_desig_LENGTH_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    sec_range_LENGTH_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    p_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    st_LENGTH_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip5_LENGTH_ErrorCount := COUNT(GROUP,h.zip5_Invalid=1);
    zip4_LENGTH_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    county_LENGTH_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    cart_LENGTH_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cr_sort_sz_LENGTH_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    lot_LENGTH_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_order_LENGTH_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    dpbc_LENGTH_ErrorCount := COUNT(GROUP,h.dpbc_Invalid=1);
    chk_digit_LENGTH_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    rec_type_LENGTH_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    ace_fips_st_LENGTH_ErrorCount := COUNT(GROUP,h.ace_fips_st_Invalid=1);
    ace_fips_county_LENGTH_ErrorCount := COUNT(GROUP,h.ace_fips_county_Invalid=1);
    geo_lat_LENGTH_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_long_LENGTH_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    msa_LENGTH_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    geo_blk_LENGTH_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_match_LENGTH_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    err_stat_LENGTH_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    bdid_ENUM_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    did_ENUM_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_score_ENUM_ErrorCount := COUNT(GROUP,h.did_score_Invalid=1);
    bdid_score_ENUM_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=1);
    source_rec_id_ENUM_ErrorCount := COUNT(GROUP,h.source_rec_id_Invalid=1);
    dotid_ENUM_ErrorCount := COUNT(GROUP,h.dotid_Invalid=1);
    dotscore_ENUM_ErrorCount := COUNT(GROUP,h.dotscore_Invalid=1);
    dotweight_ENUM_ErrorCount := COUNT(GROUP,h.dotweight_Invalid=1);
    empid_ENUM_ErrorCount := COUNT(GROUP,h.empid_Invalid=1);
    empscore_ENUM_ErrorCount := COUNT(GROUP,h.empscore_Invalid=1);
    empweight_ENUM_ErrorCount := COUNT(GROUP,h.empweight_Invalid=1);
    powid_ENUM_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    powscore_ENUM_ErrorCount := COUNT(GROUP,h.powscore_Invalid=1);
    powweight_ENUM_ErrorCount := COUNT(GROUP,h.powweight_Invalid=1);
    proxid_ENUM_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    proxscore_ENUM_ErrorCount := COUNT(GROUP,h.proxscore_Invalid=1);
    proxweight_ENUM_ErrorCount := COUNT(GROUP,h.proxweight_Invalid=1);
    seleid_ENUM_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    selescore_ENUM_ErrorCount := COUNT(GROUP,h.selescore_Invalid=1);
    seleweight_ENUM_ErrorCount := COUNT(GROUP,h.seleweight_Invalid=1);
    orgid_ENUM_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    orgscore_ENUM_ErrorCount := COUNT(GROUP,h.orgscore_Invalid=1);
    orgweight_ENUM_ErrorCount := COUNT(GROUP,h.orgweight_Invalid=1);
    ultid_ENUM_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    ultscore_ENUM_ErrorCount := COUNT(GROUP,h.ultscore_Invalid=1);
    ultweight_ENUM_ErrorCount := COUNT(GROUP,h.ultweight_Invalid=1);
    prep_addr_line1_CUSTOM_ErrorCount := COUNT(GROUP,h.prep_addr_line1_Invalid=1);
    prep_addr_last_line_CUSTOM_ErrorCount := COUNT(GROUP,h.prep_addr_last_line_Invalid=1);
    rawaid_ENUM_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=1);
    aceaid_ENUM_ErrorCount := COUNT(GROUP,h.aceaid_Invalid=1);
    persistent_record_id_ENUM_ErrorCount := COUNT(GROUP,h.persistent_record_id_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT37.StrType ErrorMessage;
    SALT37.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.tmsid_Invalid,le.rmsid_Invalid,le.orig_name_Invalid,le.orig_lname_Invalid,le.orig_fname_Invalid,le.duns_number_Invalid,le.hq_duns_number_Invalid,le.ssn_Invalid,le.fein_Invalid,le.incorp_state_Invalid,le.corp_number_Invalid,le.corp_type_Invalid,le.orig_address1_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.orig_zip5_Invalid,le.foreign_indc_Invalid,le.party_type_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_last_reported_Invalid,le.dt_vendor_first_reported_Invalid,le.process_date_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.company_name_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip5_Invalid,le.zip4_Invalid,le.county_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dpbc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.ace_fips_st_Invalid,le.ace_fips_county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.bdid_Invalid,le.did_Invalid,le.did_score_Invalid,le.bdid_score_Invalid,le.source_rec_id_Invalid,le.dotid_Invalid,le.dotscore_Invalid,le.dotweight_Invalid,le.empid_Invalid,le.empscore_Invalid,le.empweight_Invalid,le.powid_Invalid,le.powscore_Invalid,le.powweight_Invalid,le.proxid_Invalid,le.proxscore_Invalid,le.proxweight_Invalid,le.seleid_Invalid,le.selescore_Invalid,le.seleweight_Invalid,le.orgid_Invalid,le.orgscore_Invalid,le.orgweight_Invalid,le.ultid_Invalid,le.ultscore_Invalid,le.ultweight_Invalid,le.prep_addr_line1_Invalid,le.prep_addr_last_line_Invalid,le.rawaid_Invalid,le.aceaid_Invalid,le.persistent_record_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,IL_Party_Fields.InvalidMessage_tmsid(le.tmsid_Invalid),IL_Party_Fields.InvalidMessage_rmsid(le.rmsid_Invalid),IL_Party_Fields.InvalidMessage_orig_name(le.orig_name_Invalid),IL_Party_Fields.InvalidMessage_orig_lname(le.orig_lname_Invalid),IL_Party_Fields.InvalidMessage_orig_fname(le.orig_fname_Invalid),IL_Party_Fields.InvalidMessage_duns_number(le.duns_number_Invalid),IL_Party_Fields.InvalidMessage_hq_duns_number(le.hq_duns_number_Invalid),IL_Party_Fields.InvalidMessage_ssn(le.ssn_Invalid),IL_Party_Fields.InvalidMessage_fein(le.fein_Invalid),IL_Party_Fields.InvalidMessage_incorp_state(le.incorp_state_Invalid),IL_Party_Fields.InvalidMessage_corp_number(le.corp_number_Invalid),IL_Party_Fields.InvalidMessage_corp_type(le.corp_type_Invalid),IL_Party_Fields.InvalidMessage_orig_address1(le.orig_address1_Invalid),IL_Party_Fields.InvalidMessage_orig_city(le.orig_city_Invalid),IL_Party_Fields.InvalidMessage_orig_state(le.orig_state_Invalid),IL_Party_Fields.InvalidMessage_orig_zip5(le.orig_zip5_Invalid),IL_Party_Fields.InvalidMessage_foreign_indc(le.foreign_indc_Invalid),IL_Party_Fields.InvalidMessage_party_type(le.party_type_Invalid),IL_Party_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),IL_Party_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),IL_Party_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),IL_Party_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),IL_Party_Fields.InvalidMessage_process_date(le.process_date_Invalid),IL_Party_Fields.InvalidMessage_fname(le.fname_Invalid),IL_Party_Fields.InvalidMessage_mname(le.mname_Invalid),IL_Party_Fields.InvalidMessage_lname(le.lname_Invalid),IL_Party_Fields.InvalidMessage_company_name(le.company_name_Invalid),IL_Party_Fields.InvalidMessage_prim_range(le.prim_range_Invalid),IL_Party_Fields.InvalidMessage_predir(le.predir_Invalid),IL_Party_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),IL_Party_Fields.InvalidMessage_suffix(le.suffix_Invalid),IL_Party_Fields.InvalidMessage_postdir(le.postdir_Invalid),IL_Party_Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),IL_Party_Fields.InvalidMessage_sec_range(le.sec_range_Invalid),IL_Party_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),IL_Party_Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),IL_Party_Fields.InvalidMessage_st(le.st_Invalid),IL_Party_Fields.InvalidMessage_zip5(le.zip5_Invalid),IL_Party_Fields.InvalidMessage_zip4(le.zip4_Invalid),IL_Party_Fields.InvalidMessage_county(le.county_Invalid),IL_Party_Fields.InvalidMessage_cart(le.cart_Invalid),IL_Party_Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),IL_Party_Fields.InvalidMessage_lot(le.lot_Invalid),IL_Party_Fields.InvalidMessage_lot_order(le.lot_order_Invalid),IL_Party_Fields.InvalidMessage_dpbc(le.dpbc_Invalid),IL_Party_Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),IL_Party_Fields.InvalidMessage_rec_type(le.rec_type_Invalid),IL_Party_Fields.InvalidMessage_ace_fips_st(le.ace_fips_st_Invalid),IL_Party_Fields.InvalidMessage_ace_fips_county(le.ace_fips_county_Invalid),IL_Party_Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),IL_Party_Fields.InvalidMessage_geo_long(le.geo_long_Invalid),IL_Party_Fields.InvalidMessage_msa(le.msa_Invalid),IL_Party_Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),IL_Party_Fields.InvalidMessage_geo_match(le.geo_match_Invalid),IL_Party_Fields.InvalidMessage_err_stat(le.err_stat_Invalid),IL_Party_Fields.InvalidMessage_bdid(le.bdid_Invalid),IL_Party_Fields.InvalidMessage_did(le.did_Invalid),IL_Party_Fields.InvalidMessage_did_score(le.did_score_Invalid),IL_Party_Fields.InvalidMessage_bdid_score(le.bdid_score_Invalid),IL_Party_Fields.InvalidMessage_source_rec_id(le.source_rec_id_Invalid),IL_Party_Fields.InvalidMessage_dotid(le.dotid_Invalid),IL_Party_Fields.InvalidMessage_dotscore(le.dotscore_Invalid),IL_Party_Fields.InvalidMessage_dotweight(le.dotweight_Invalid),IL_Party_Fields.InvalidMessage_empid(le.empid_Invalid),IL_Party_Fields.InvalidMessage_empscore(le.empscore_Invalid),IL_Party_Fields.InvalidMessage_empweight(le.empweight_Invalid),IL_Party_Fields.InvalidMessage_powid(le.powid_Invalid),IL_Party_Fields.InvalidMessage_powscore(le.powscore_Invalid),IL_Party_Fields.InvalidMessage_powweight(le.powweight_Invalid),IL_Party_Fields.InvalidMessage_proxid(le.proxid_Invalid),IL_Party_Fields.InvalidMessage_proxscore(le.proxscore_Invalid),IL_Party_Fields.InvalidMessage_proxweight(le.proxweight_Invalid),IL_Party_Fields.InvalidMessage_seleid(le.seleid_Invalid),IL_Party_Fields.InvalidMessage_selescore(le.selescore_Invalid),IL_Party_Fields.InvalidMessage_seleweight(le.seleweight_Invalid),IL_Party_Fields.InvalidMessage_orgid(le.orgid_Invalid),IL_Party_Fields.InvalidMessage_orgscore(le.orgscore_Invalid),IL_Party_Fields.InvalidMessage_orgweight(le.orgweight_Invalid),IL_Party_Fields.InvalidMessage_ultid(le.ultid_Invalid),IL_Party_Fields.InvalidMessage_ultscore(le.ultscore_Invalid),IL_Party_Fields.InvalidMessage_ultweight(le.ultweight_Invalid),IL_Party_Fields.InvalidMessage_prep_addr_line1(le.prep_addr_line1_Invalid),IL_Party_Fields.InvalidMessage_prep_addr_last_line(le.prep_addr_last_line_Invalid),IL_Party_Fields.InvalidMessage_rawaid(le.rawaid_Invalid),IL_Party_Fields.InvalidMessage_aceaid(le.aceaid_Invalid),IL_Party_Fields.InvalidMessage_persistent_record_id(le.persistent_record_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.tmsid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rmsid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_fname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.duns_number_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.hq_duns_number_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.fein_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.incorp_state_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_number_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_type_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_zip5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.foreign_indc_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.party_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.zip5_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.dpbc_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.ace_fips_st_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.ace_fips_county_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.bdid_score_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.source_rec_id_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dotid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dotscore_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dotweight_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.empid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.empscore_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.empweight_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.powid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.powscore_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.powweight_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.proxscore_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.proxweight_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.selescore_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.seleweight_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orgscore_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orgweight_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ultscore_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ultweight_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.prep_addr_line1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prep_addr_last_line_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawaid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.aceaid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.persistent_record_id_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'tmsid','rmsid','orig_name','orig_lname','orig_fname','duns_number','hq_duns_number','ssn','fein','incorp_state','corp_number','corp_type','orig_address1','orig_city','orig_state','orig_zip5','foreign_indc','party_type','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','process_date','fname','mname','lname','company_name','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','county','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','ace_fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','bdid','did','did_score','bdid_score','source_rec_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','prep_addr_line1','prep_addr_last_line','rawaid','aceaid','persistent_record_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_tmsid','invalid_rmsid','invalid_orig_name','invalid_orig_lname','invalid_orig_fname','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_mandatory','invalid_mandatory','invalid_orig_state','invalid_orig_zip5','invalid_boolean_yn','invalid_party_type','invalid_pastdate6','invalid_pastdate6','invalid_pastdate6','invalid_pastdate6','invalid_pastdate8','invalid_fname','invalid_mname','invalid_lname','invalid_company_name','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_mandatory','invalid_mandatory','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.tmsid,(SALT37.StrType)le.rmsid,(SALT37.StrType)le.orig_name,(SALT37.StrType)le.orig_lname,(SALT37.StrType)le.orig_fname,(SALT37.StrType)le.duns_number,(SALT37.StrType)le.hq_duns_number,(SALT37.StrType)le.ssn,(SALT37.StrType)le.fein,(SALT37.StrType)le.incorp_state,(SALT37.StrType)le.corp_number,(SALT37.StrType)le.corp_type,(SALT37.StrType)le.orig_address1,(SALT37.StrType)le.orig_city,(SALT37.StrType)le.orig_state,(SALT37.StrType)le.orig_zip5,(SALT37.StrType)le.foreign_indc,(SALT37.StrType)le.party_type,(SALT37.StrType)le.dt_first_seen,(SALT37.StrType)le.dt_last_seen,(SALT37.StrType)le.dt_vendor_last_reported,(SALT37.StrType)le.dt_vendor_first_reported,(SALT37.StrType)le.process_date,(SALT37.StrType)le.fname,(SALT37.StrType)le.mname,(SALT37.StrType)le.lname,(SALT37.StrType)le.company_name,(SALT37.StrType)le.prim_range,(SALT37.StrType)le.predir,(SALT37.StrType)le.prim_name,(SALT37.StrType)le.suffix,(SALT37.StrType)le.postdir,(SALT37.StrType)le.unit_desig,(SALT37.StrType)le.sec_range,(SALT37.StrType)le.p_city_name,(SALT37.StrType)le.v_city_name,(SALT37.StrType)le.st,(SALT37.StrType)le.zip5,(SALT37.StrType)le.zip4,(SALT37.StrType)le.county,(SALT37.StrType)le.cart,(SALT37.StrType)le.cr_sort_sz,(SALT37.StrType)le.lot,(SALT37.StrType)le.lot_order,(SALT37.StrType)le.dpbc,(SALT37.StrType)le.chk_digit,(SALT37.StrType)le.rec_type,(SALT37.StrType)le.ace_fips_st,(SALT37.StrType)le.ace_fips_county,(SALT37.StrType)le.geo_lat,(SALT37.StrType)le.geo_long,(SALT37.StrType)le.msa,(SALT37.StrType)le.geo_blk,(SALT37.StrType)le.geo_match,(SALT37.StrType)le.err_stat,(SALT37.StrType)le.bdid,(SALT37.StrType)le.did,(SALT37.StrType)le.did_score,(SALT37.StrType)le.bdid_score,(SALT37.StrType)le.source_rec_id,(SALT37.StrType)le.dotid,(SALT37.StrType)le.dotscore,(SALT37.StrType)le.dotweight,(SALT37.StrType)le.empid,(SALT37.StrType)le.empscore,(SALT37.StrType)le.empweight,(SALT37.StrType)le.powid,(SALT37.StrType)le.powscore,(SALT37.StrType)le.powweight,(SALT37.StrType)le.proxid,(SALT37.StrType)le.proxscore,(SALT37.StrType)le.proxweight,(SALT37.StrType)le.seleid,(SALT37.StrType)le.selescore,(SALT37.StrType)le.seleweight,(SALT37.StrType)le.orgid,(SALT37.StrType)le.orgscore,(SALT37.StrType)le.orgweight,(SALT37.StrType)le.ultid,(SALT37.StrType)le.ultscore,(SALT37.StrType)le.ultweight,(SALT37.StrType)le.prep_addr_line1,(SALT37.StrType)le.prep_addr_last_line,(SALT37.StrType)le.rawaid,(SALT37.StrType)le.aceaid,(SALT37.StrType)le.persistent_record_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,86,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'tmsid:invalid_tmsid:CUSTOM'
          ,'rmsid:invalid_rmsid:CUSTOM'
          ,'orig_name:invalid_orig_name:CUSTOM'
          ,'orig_lname:invalid_orig_lname:CUSTOM'
          ,'orig_fname:invalid_orig_fname:CUSTOM'
          ,'duns_number:invalid_empty:LENGTH'
          ,'hq_duns_number:invalid_empty:LENGTH'
          ,'ssn:invalid_empty:LENGTH'
          ,'fein:invalid_empty:LENGTH'
          ,'incorp_state:invalid_empty:LENGTH'
          ,'corp_number:invalid_empty:LENGTH'
          ,'corp_type:invalid_empty:LENGTH'
          ,'orig_address1:invalid_mandatory:CUSTOM'
          ,'orig_city:invalid_mandatory:CUSTOM'
          ,'orig_state:invalid_orig_state:CUSTOM'
          ,'orig_zip5:invalid_orig_zip5:CUSTOM'
          ,'foreign_indc:invalid_boolean_yn:ENUM'
          ,'party_type:invalid_party_type:ENUM'
          ,'dt_first_seen:invalid_pastdate6:CUSTOM'
          ,'dt_last_seen:invalid_pastdate6:CUSTOM'
          ,'dt_vendor_last_reported:invalid_pastdate6:CUSTOM'
          ,'dt_vendor_first_reported:invalid_pastdate6:CUSTOM'
          ,'process_date:invalid_pastdate8:CUSTOM'
          ,'fname:invalid_fname:CUSTOM'
          ,'mname:invalid_mname:CUSTOM'
          ,'lname:invalid_lname:CUSTOM'
          ,'company_name:invalid_company_name:CUSTOM'
          ,'prim_range:invalid_empty:LENGTH'
          ,'predir:invalid_empty:LENGTH'
          ,'prim_name:invalid_empty:LENGTH'
          ,'suffix:invalid_empty:LENGTH'
          ,'postdir:invalid_empty:LENGTH'
          ,'unit_desig:invalid_empty:LENGTH'
          ,'sec_range:invalid_empty:LENGTH'
          ,'p_city_name:invalid_empty:LENGTH'
          ,'v_city_name:invalid_empty:LENGTH'
          ,'st:invalid_empty:LENGTH'
          ,'zip5:invalid_empty:LENGTH'
          ,'zip4:invalid_empty:LENGTH'
          ,'county:invalid_empty:LENGTH'
          ,'cart:invalid_empty:LENGTH'
          ,'cr_sort_sz:invalid_empty:LENGTH'
          ,'lot:invalid_empty:LENGTH'
          ,'lot_order:invalid_empty:LENGTH'
          ,'dpbc:invalid_empty:LENGTH'
          ,'chk_digit:invalid_empty:LENGTH'
          ,'rec_type:invalid_empty:LENGTH'
          ,'ace_fips_st:invalid_empty:LENGTH'
          ,'ace_fips_county:invalid_empty:LENGTH'
          ,'geo_lat:invalid_empty:LENGTH'
          ,'geo_long:invalid_empty:LENGTH'
          ,'msa:invalid_empty:LENGTH'
          ,'geo_blk:invalid_empty:LENGTH'
          ,'geo_match:invalid_empty:LENGTH'
          ,'err_stat:invalid_empty:LENGTH'
          ,'bdid:invalid_zero_integer:ENUM'
          ,'did:invalid_zero_integer:ENUM'
          ,'did_score:invalid_zero_integer:ENUM'
          ,'bdid_score:invalid_zero_integer:ENUM'
          ,'source_rec_id:invalid_zero_integer:ENUM'
          ,'dotid:invalid_zero_integer:ENUM'
          ,'dotscore:invalid_zero_integer:ENUM'
          ,'dotweight:invalid_zero_integer:ENUM'
          ,'empid:invalid_zero_integer:ENUM'
          ,'empscore:invalid_zero_integer:ENUM'
          ,'empweight:invalid_zero_integer:ENUM'
          ,'powid:invalid_zero_integer:ENUM'
          ,'powscore:invalid_zero_integer:ENUM'
          ,'powweight:invalid_zero_integer:ENUM'
          ,'proxid:invalid_zero_integer:ENUM'
          ,'proxscore:invalid_zero_integer:ENUM'
          ,'proxweight:invalid_zero_integer:ENUM'
          ,'seleid:invalid_zero_integer:ENUM'
          ,'selescore:invalid_zero_integer:ENUM'
          ,'seleweight:invalid_zero_integer:ENUM'
          ,'orgid:invalid_zero_integer:ENUM'
          ,'orgscore:invalid_zero_integer:ENUM'
          ,'orgweight:invalid_zero_integer:ENUM'
          ,'ultid:invalid_zero_integer:ENUM'
          ,'ultscore:invalid_zero_integer:ENUM'
          ,'ultweight:invalid_zero_integer:ENUM'
          ,'prep_addr_line1:invalid_mandatory:CUSTOM'
          ,'prep_addr_last_line:invalid_mandatory:CUSTOM'
          ,'rawaid:invalid_zero_integer:ENUM'
          ,'aceaid:invalid_zero_integer:ENUM'
          ,'persistent_record_id:invalid_zero_integer:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,IL_Party_Fields.InvalidMessage_tmsid(1)
          ,IL_Party_Fields.InvalidMessage_rmsid(1)
          ,IL_Party_Fields.InvalidMessage_orig_name(1)
          ,IL_Party_Fields.InvalidMessage_orig_lname(1)
          ,IL_Party_Fields.InvalidMessage_orig_fname(1)
          ,IL_Party_Fields.InvalidMessage_duns_number(1)
          ,IL_Party_Fields.InvalidMessage_hq_duns_number(1)
          ,IL_Party_Fields.InvalidMessage_ssn(1)
          ,IL_Party_Fields.InvalidMessage_fein(1)
          ,IL_Party_Fields.InvalidMessage_incorp_state(1)
          ,IL_Party_Fields.InvalidMessage_corp_number(1)
          ,IL_Party_Fields.InvalidMessage_corp_type(1)
          ,IL_Party_Fields.InvalidMessage_orig_address1(1)
          ,IL_Party_Fields.InvalidMessage_orig_city(1)
          ,IL_Party_Fields.InvalidMessage_orig_state(1)
          ,IL_Party_Fields.InvalidMessage_orig_zip5(1)
          ,IL_Party_Fields.InvalidMessage_foreign_indc(1)
          ,IL_Party_Fields.InvalidMessage_party_type(1)
          ,IL_Party_Fields.InvalidMessage_dt_first_seen(1)
          ,IL_Party_Fields.InvalidMessage_dt_last_seen(1)
          ,IL_Party_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,IL_Party_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,IL_Party_Fields.InvalidMessage_process_date(1)
          ,IL_Party_Fields.InvalidMessage_fname(1)
          ,IL_Party_Fields.InvalidMessage_mname(1)
          ,IL_Party_Fields.InvalidMessage_lname(1)
          ,IL_Party_Fields.InvalidMessage_company_name(1)
          ,IL_Party_Fields.InvalidMessage_prim_range(1)
          ,IL_Party_Fields.InvalidMessage_predir(1)
          ,IL_Party_Fields.InvalidMessage_prim_name(1)
          ,IL_Party_Fields.InvalidMessage_suffix(1)
          ,IL_Party_Fields.InvalidMessage_postdir(1)
          ,IL_Party_Fields.InvalidMessage_unit_desig(1)
          ,IL_Party_Fields.InvalidMessage_sec_range(1)
          ,IL_Party_Fields.InvalidMessage_p_city_name(1)
          ,IL_Party_Fields.InvalidMessage_v_city_name(1)
          ,IL_Party_Fields.InvalidMessage_st(1)
          ,IL_Party_Fields.InvalidMessage_zip5(1)
          ,IL_Party_Fields.InvalidMessage_zip4(1)
          ,IL_Party_Fields.InvalidMessage_county(1)
          ,IL_Party_Fields.InvalidMessage_cart(1)
          ,IL_Party_Fields.InvalidMessage_cr_sort_sz(1)
          ,IL_Party_Fields.InvalidMessage_lot(1)
          ,IL_Party_Fields.InvalidMessage_lot_order(1)
          ,IL_Party_Fields.InvalidMessage_dpbc(1)
          ,IL_Party_Fields.InvalidMessage_chk_digit(1)
          ,IL_Party_Fields.InvalidMessage_rec_type(1)
          ,IL_Party_Fields.InvalidMessage_ace_fips_st(1)
          ,IL_Party_Fields.InvalidMessage_ace_fips_county(1)
          ,IL_Party_Fields.InvalidMessage_geo_lat(1)
          ,IL_Party_Fields.InvalidMessage_geo_long(1)
          ,IL_Party_Fields.InvalidMessage_msa(1)
          ,IL_Party_Fields.InvalidMessage_geo_blk(1)
          ,IL_Party_Fields.InvalidMessage_geo_match(1)
          ,IL_Party_Fields.InvalidMessage_err_stat(1)
          ,IL_Party_Fields.InvalidMessage_bdid(1)
          ,IL_Party_Fields.InvalidMessage_did(1)
          ,IL_Party_Fields.InvalidMessage_did_score(1)
          ,IL_Party_Fields.InvalidMessage_bdid_score(1)
          ,IL_Party_Fields.InvalidMessage_source_rec_id(1)
          ,IL_Party_Fields.InvalidMessage_dotid(1)
          ,IL_Party_Fields.InvalidMessage_dotscore(1)
          ,IL_Party_Fields.InvalidMessage_dotweight(1)
          ,IL_Party_Fields.InvalidMessage_empid(1)
          ,IL_Party_Fields.InvalidMessage_empscore(1)
          ,IL_Party_Fields.InvalidMessage_empweight(1)
          ,IL_Party_Fields.InvalidMessage_powid(1)
          ,IL_Party_Fields.InvalidMessage_powscore(1)
          ,IL_Party_Fields.InvalidMessage_powweight(1)
          ,IL_Party_Fields.InvalidMessage_proxid(1)
          ,IL_Party_Fields.InvalidMessage_proxscore(1)
          ,IL_Party_Fields.InvalidMessage_proxweight(1)
          ,IL_Party_Fields.InvalidMessage_seleid(1)
          ,IL_Party_Fields.InvalidMessage_selescore(1)
          ,IL_Party_Fields.InvalidMessage_seleweight(1)
          ,IL_Party_Fields.InvalidMessage_orgid(1)
          ,IL_Party_Fields.InvalidMessage_orgscore(1)
          ,IL_Party_Fields.InvalidMessage_orgweight(1)
          ,IL_Party_Fields.InvalidMessage_ultid(1)
          ,IL_Party_Fields.InvalidMessage_ultscore(1)
          ,IL_Party_Fields.InvalidMessage_ultweight(1)
          ,IL_Party_Fields.InvalidMessage_prep_addr_line1(1)
          ,IL_Party_Fields.InvalidMessage_prep_addr_last_line(1)
          ,IL_Party_Fields.InvalidMessage_rawaid(1)
          ,IL_Party_Fields.InvalidMessage_aceaid(1)
          ,IL_Party_Fields.InvalidMessage_persistent_record_id(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.tmsid_CUSTOM_ErrorCount
          ,le.rmsid_CUSTOM_ErrorCount
          ,le.orig_name_CUSTOM_ErrorCount
          ,le.orig_lname_CUSTOM_ErrorCount
          ,le.orig_fname_CUSTOM_ErrorCount
          ,le.duns_number_LENGTH_ErrorCount
          ,le.hq_duns_number_LENGTH_ErrorCount
          ,le.ssn_LENGTH_ErrorCount
          ,le.fein_LENGTH_ErrorCount
          ,le.incorp_state_LENGTH_ErrorCount
          ,le.corp_number_LENGTH_ErrorCount
          ,le.corp_type_LENGTH_ErrorCount
          ,le.orig_address1_CUSTOM_ErrorCount
          ,le.orig_city_CUSTOM_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip5_CUSTOM_ErrorCount
          ,le.foreign_indc_ENUM_ErrorCount
          ,le.party_type_ENUM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.mname_CUSTOM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.prim_range_LENGTH_ErrorCount
          ,le.predir_LENGTH_ErrorCount
          ,le.prim_name_LENGTH_ErrorCount
          ,le.suffix_LENGTH_ErrorCount
          ,le.postdir_LENGTH_ErrorCount
          ,le.unit_desig_LENGTH_ErrorCount
          ,le.sec_range_LENGTH_ErrorCount
          ,le.p_city_name_LENGTH_ErrorCount
          ,le.v_city_name_LENGTH_ErrorCount
          ,le.st_LENGTH_ErrorCount
          ,le.zip5_LENGTH_ErrorCount
          ,le.zip4_LENGTH_ErrorCount
          ,le.county_LENGTH_ErrorCount
          ,le.cart_LENGTH_ErrorCount
          ,le.cr_sort_sz_LENGTH_ErrorCount
          ,le.lot_LENGTH_ErrorCount
          ,le.lot_order_LENGTH_ErrorCount
          ,le.dpbc_LENGTH_ErrorCount
          ,le.chk_digit_LENGTH_ErrorCount
          ,le.rec_type_LENGTH_ErrorCount
          ,le.ace_fips_st_LENGTH_ErrorCount
          ,le.ace_fips_county_LENGTH_ErrorCount
          ,le.geo_lat_LENGTH_ErrorCount
          ,le.geo_long_LENGTH_ErrorCount
          ,le.msa_LENGTH_ErrorCount
          ,le.geo_blk_LENGTH_ErrorCount
          ,le.geo_match_LENGTH_ErrorCount
          ,le.err_stat_LENGTH_ErrorCount
          ,le.bdid_ENUM_ErrorCount
          ,le.did_ENUM_ErrorCount
          ,le.did_score_ENUM_ErrorCount
          ,le.bdid_score_ENUM_ErrorCount
          ,le.source_rec_id_ENUM_ErrorCount
          ,le.dotid_ENUM_ErrorCount
          ,le.dotscore_ENUM_ErrorCount
          ,le.dotweight_ENUM_ErrorCount
          ,le.empid_ENUM_ErrorCount
          ,le.empscore_ENUM_ErrorCount
          ,le.empweight_ENUM_ErrorCount
          ,le.powid_ENUM_ErrorCount
          ,le.powscore_ENUM_ErrorCount
          ,le.powweight_ENUM_ErrorCount
          ,le.proxid_ENUM_ErrorCount
          ,le.proxscore_ENUM_ErrorCount
          ,le.proxweight_ENUM_ErrorCount
          ,le.seleid_ENUM_ErrorCount
          ,le.selescore_ENUM_ErrorCount
          ,le.seleweight_ENUM_ErrorCount
          ,le.orgid_ENUM_ErrorCount
          ,le.orgscore_ENUM_ErrorCount
          ,le.orgweight_ENUM_ErrorCount
          ,le.ultid_ENUM_ErrorCount
          ,le.ultscore_ENUM_ErrorCount
          ,le.ultweight_ENUM_ErrorCount
          ,le.prep_addr_line1_CUSTOM_ErrorCount
          ,le.prep_addr_last_line_CUSTOM_ErrorCount
          ,le.rawaid_ENUM_ErrorCount
          ,le.aceaid_ENUM_ErrorCount
          ,le.persistent_record_id_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.tmsid_CUSTOM_ErrorCount
          ,le.rmsid_CUSTOM_ErrorCount
          ,le.orig_name_CUSTOM_ErrorCount
          ,le.orig_lname_CUSTOM_ErrorCount
          ,le.orig_fname_CUSTOM_ErrorCount
          ,le.duns_number_LENGTH_ErrorCount
          ,le.hq_duns_number_LENGTH_ErrorCount
          ,le.ssn_LENGTH_ErrorCount
          ,le.fein_LENGTH_ErrorCount
          ,le.incorp_state_LENGTH_ErrorCount
          ,le.corp_number_LENGTH_ErrorCount
          ,le.corp_type_LENGTH_ErrorCount
          ,le.orig_address1_CUSTOM_ErrorCount
          ,le.orig_city_CUSTOM_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip5_CUSTOM_ErrorCount
          ,le.foreign_indc_ENUM_ErrorCount
          ,le.party_type_ENUM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.mname_CUSTOM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.prim_range_LENGTH_ErrorCount
          ,le.predir_LENGTH_ErrorCount
          ,le.prim_name_LENGTH_ErrorCount
          ,le.suffix_LENGTH_ErrorCount
          ,le.postdir_LENGTH_ErrorCount
          ,le.unit_desig_LENGTH_ErrorCount
          ,le.sec_range_LENGTH_ErrorCount
          ,le.p_city_name_LENGTH_ErrorCount
          ,le.v_city_name_LENGTH_ErrorCount
          ,le.st_LENGTH_ErrorCount
          ,le.zip5_LENGTH_ErrorCount
          ,le.zip4_LENGTH_ErrorCount
          ,le.county_LENGTH_ErrorCount
          ,le.cart_LENGTH_ErrorCount
          ,le.cr_sort_sz_LENGTH_ErrorCount
          ,le.lot_LENGTH_ErrorCount
          ,le.lot_order_LENGTH_ErrorCount
          ,le.dpbc_LENGTH_ErrorCount
          ,le.chk_digit_LENGTH_ErrorCount
          ,le.rec_type_LENGTH_ErrorCount
          ,le.ace_fips_st_LENGTH_ErrorCount
          ,le.ace_fips_county_LENGTH_ErrorCount
          ,le.geo_lat_LENGTH_ErrorCount
          ,le.geo_long_LENGTH_ErrorCount
          ,le.msa_LENGTH_ErrorCount
          ,le.geo_blk_LENGTH_ErrorCount
          ,le.geo_match_LENGTH_ErrorCount
          ,le.err_stat_LENGTH_ErrorCount
          ,le.bdid_ENUM_ErrorCount
          ,le.did_ENUM_ErrorCount
          ,le.did_score_ENUM_ErrorCount
          ,le.bdid_score_ENUM_ErrorCount
          ,le.source_rec_id_ENUM_ErrorCount
          ,le.dotid_ENUM_ErrorCount
          ,le.dotscore_ENUM_ErrorCount
          ,le.dotweight_ENUM_ErrorCount
          ,le.empid_ENUM_ErrorCount
          ,le.empscore_ENUM_ErrorCount
          ,le.empweight_ENUM_ErrorCount
          ,le.powid_ENUM_ErrorCount
          ,le.powscore_ENUM_ErrorCount
          ,le.powweight_ENUM_ErrorCount
          ,le.proxid_ENUM_ErrorCount
          ,le.proxscore_ENUM_ErrorCount
          ,le.proxweight_ENUM_ErrorCount
          ,le.seleid_ENUM_ErrorCount
          ,le.selescore_ENUM_ErrorCount
          ,le.seleweight_ENUM_ErrorCount
          ,le.orgid_ENUM_ErrorCount
          ,le.orgscore_ENUM_ErrorCount
          ,le.orgweight_ENUM_ErrorCount
          ,le.ultid_ENUM_ErrorCount
          ,le.ultscore_ENUM_ErrorCount
          ,le.ultweight_ENUM_ErrorCount
          ,le.prep_addr_line1_CUSTOM_ErrorCount
          ,le.prep_addr_last_line_CUSTOM_ErrorCount
          ,le.rawaid_ENUM_ErrorCount
          ,le.aceaid_ENUM_ErrorCount
          ,le.persistent_record_id_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,86,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT37.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT37.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;

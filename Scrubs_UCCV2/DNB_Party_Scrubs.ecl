﻿IMPORT SALT38,STD;
IMPORT Scrubs_UCCV2,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT DNB_Party_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 104;
  EXPORT NumRulesFromFieldType := 104;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 95;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(DNB_Party_Layout_UCCV2)
    UNSIGNED1 tmsid_Invalid;
    UNSIGNED1 rmsid_Invalid;
    UNSIGNED1 orig_name_Invalid;
    UNSIGNED1 orig_lname_Invalid;
    UNSIGNED1 orig_fname_Invalid;
    UNSIGNED1 orig_mname_Invalid;
    UNSIGNED1 orig_suffix_Invalid;
    UNSIGNED1 duns_number_Invalid;
    UNSIGNED1 hq_duns_number_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 fein_Invalid;
    UNSIGNED1 incorp_state_Invalid;
    UNSIGNED1 corp_number_Invalid;
    UNSIGNED1 corp_type_Invalid;
    UNSIGNED1 orig_address1_Invalid;
    UNSIGNED1 orig_address2_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 orig_zip5_Invalid;
    UNSIGNED1 orig_zip4_Invalid;
    UNSIGNED1 orig_country_Invalid;
    UNSIGNED1 orig_province_Invalid;
    UNSIGNED1 foreign_indc_Invalid;
    UNSIGNED1 party_type_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 name_score_Invalid;
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
  EXPORT  Bitmap_Layout := RECORD(DNB_Party_Layout_UCCV2)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(DNB_Party_Layout_UCCV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.tmsid_Invalid := DNB_Party_Fields.InValid_tmsid((SALT38.StrType)le.tmsid);
    SELF.rmsid_Invalid := DNB_Party_Fields.InValid_rmsid((SALT38.StrType)le.rmsid);
    SELF.orig_name_Invalid := DNB_Party_Fields.InValid_orig_name((SALT38.StrType)le.orig_name);
    SELF.orig_lname_Invalid := DNB_Party_Fields.InValid_orig_lname((SALT38.StrType)le.orig_lname);
    SELF.orig_fname_Invalid := DNB_Party_Fields.InValid_orig_fname((SALT38.StrType)le.orig_fname);
    SELF.orig_mname_Invalid := DNB_Party_Fields.InValid_orig_mname((SALT38.StrType)le.orig_mname);
    SELF.orig_suffix_Invalid := DNB_Party_Fields.InValid_orig_suffix((SALT38.StrType)le.orig_suffix);
    SELF.duns_number_Invalid := DNB_Party_Fields.InValid_duns_number((SALT38.StrType)le.duns_number);
    SELF.hq_duns_number_Invalid := DNB_Party_Fields.InValid_hq_duns_number((SALT38.StrType)le.hq_duns_number);
    SELF.ssn_Invalid := DNB_Party_Fields.InValid_ssn((SALT38.StrType)le.ssn);
    SELF.fein_Invalid := DNB_Party_Fields.InValid_fein((SALT38.StrType)le.fein);
    SELF.incorp_state_Invalid := DNB_Party_Fields.InValid_incorp_state((SALT38.StrType)le.incorp_state);
    SELF.corp_number_Invalid := DNB_Party_Fields.InValid_corp_number((SALT38.StrType)le.corp_number);
    SELF.corp_type_Invalid := DNB_Party_Fields.InValid_corp_type((SALT38.StrType)le.corp_type);
    SELF.orig_address1_Invalid := DNB_Party_Fields.InValid_orig_address1((SALT38.StrType)le.orig_address1,(SALT38.StrType)le.orig_city,(SALT38.StrType)le.orig_state);
    SELF.orig_address2_Invalid := DNB_Party_Fields.InValid_orig_address2((SALT38.StrType)le.orig_address2);
    SELF.orig_city_Invalid := DNB_Party_Fields.InValid_orig_city((SALT38.StrType)le.orig_city);
    SELF.orig_state_Invalid := DNB_Party_Fields.InValid_orig_state((SALT38.StrType)le.orig_state);
    SELF.orig_zip5_Invalid := DNB_Party_Fields.InValid_orig_zip5((SALT38.StrType)le.orig_zip5);
    SELF.orig_zip4_Invalid := DNB_Party_Fields.InValid_orig_zip4((SALT38.StrType)le.orig_zip4);
    SELF.orig_country_Invalid := DNB_Party_Fields.InValid_orig_country((SALT38.StrType)le.orig_country);
    SELF.orig_province_Invalid := DNB_Party_Fields.InValid_orig_province((SALT38.StrType)le.orig_province);
    SELF.foreign_indc_Invalid := DNB_Party_Fields.InValid_foreign_indc((SALT38.StrType)le.foreign_indc);
    SELF.party_type_Invalid := DNB_Party_Fields.InValid_party_type((SALT38.StrType)le.party_type);
    SELF.dt_first_seen_Invalid := DNB_Party_Fields.InValid_dt_first_seen((SALT38.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := DNB_Party_Fields.InValid_dt_last_seen((SALT38.StrType)le.dt_last_seen);
    SELF.dt_vendor_last_reported_Invalid := DNB_Party_Fields.InValid_dt_vendor_last_reported((SALT38.StrType)le.dt_vendor_last_reported);
    SELF.dt_vendor_first_reported_Invalid := DNB_Party_Fields.InValid_dt_vendor_first_reported((SALT38.StrType)le.dt_vendor_first_reported);
    SELF.process_date_Invalid := DNB_Party_Fields.InValid_process_date((SALT38.StrType)le.process_date);
    SELF.title_Invalid := DNB_Party_Fields.InValid_title((SALT38.StrType)le.title);
    SELF.fname_Invalid := DNB_Party_Fields.InValid_fname((SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.lname,(SALT38.StrType)le.company_name);
    SELF.mname_Invalid := DNB_Party_Fields.InValid_mname((SALT38.StrType)le.mname,(SALT38.StrType)le.fname,(SALT38.StrType)le.lname,(SALT38.StrType)le.company_name);
    SELF.lname_Invalid := DNB_Party_Fields.InValid_lname((SALT38.StrType)le.lname,(SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.company_name);
    SELF.name_suffix_Invalid := DNB_Party_Fields.InValid_name_suffix((SALT38.StrType)le.name_suffix);
    SELF.name_score_Invalid := DNB_Party_Fields.InValid_name_score((SALT38.StrType)le.name_score);
    SELF.company_name_Invalid := DNB_Party_Fields.InValid_company_name((SALT38.StrType)le.company_name,(SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.lname);
    SELF.prim_range_Invalid := DNB_Party_Fields.InValid_prim_range((SALT38.StrType)le.prim_range);
    SELF.predir_Invalid := DNB_Party_Fields.InValid_predir((SALT38.StrType)le.predir);
    SELF.prim_name_Invalid := DNB_Party_Fields.InValid_prim_name((SALT38.StrType)le.prim_name);
    SELF.suffix_Invalid := DNB_Party_Fields.InValid_suffix((SALT38.StrType)le.suffix);
    SELF.postdir_Invalid := DNB_Party_Fields.InValid_postdir((SALT38.StrType)le.postdir);
    SELF.unit_desig_Invalid := DNB_Party_Fields.InValid_unit_desig((SALT38.StrType)le.unit_desig);
    SELF.sec_range_Invalid := DNB_Party_Fields.InValid_sec_range((SALT38.StrType)le.sec_range);
    SELF.p_city_name_Invalid := DNB_Party_Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := DNB_Party_Fields.InValid_v_city_name((SALT38.StrType)le.v_city_name);
    SELF.st_Invalid := DNB_Party_Fields.InValid_st((SALT38.StrType)le.st);
    SELF.zip5_Invalid := DNB_Party_Fields.InValid_zip5((SALT38.StrType)le.zip5);
    SELF.zip4_Invalid := DNB_Party_Fields.InValid_zip4((SALT38.StrType)le.zip4);
    SELF.county_Invalid := DNB_Party_Fields.InValid_county((SALT38.StrType)le.county);
    SELF.cart_Invalid := DNB_Party_Fields.InValid_cart((SALT38.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := DNB_Party_Fields.InValid_cr_sort_sz((SALT38.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := DNB_Party_Fields.InValid_lot((SALT38.StrType)le.lot);
    SELF.lot_order_Invalid := DNB_Party_Fields.InValid_lot_order((SALT38.StrType)le.lot_order);
    SELF.dpbc_Invalid := DNB_Party_Fields.InValid_dpbc((SALT38.StrType)le.dpbc);
    SELF.chk_digit_Invalid := DNB_Party_Fields.InValid_chk_digit((SALT38.StrType)le.chk_digit);
    SELF.rec_type_Invalid := DNB_Party_Fields.InValid_rec_type((SALT38.StrType)le.rec_type);
    SELF.ace_fips_st_Invalid := DNB_Party_Fields.InValid_ace_fips_st((SALT38.StrType)le.ace_fips_st);
    SELF.ace_fips_county_Invalid := DNB_Party_Fields.InValid_ace_fips_county((SALT38.StrType)le.ace_fips_county);
    SELF.geo_lat_Invalid := DNB_Party_Fields.InValid_geo_lat((SALT38.StrType)le.geo_lat);
    SELF.geo_long_Invalid := DNB_Party_Fields.InValid_geo_long((SALT38.StrType)le.geo_long);
    SELF.msa_Invalid := DNB_Party_Fields.InValid_msa((SALT38.StrType)le.msa);
    SELF.geo_blk_Invalid := DNB_Party_Fields.InValid_geo_blk((SALT38.StrType)le.geo_blk);
    SELF.geo_match_Invalid := DNB_Party_Fields.InValid_geo_match((SALT38.StrType)le.geo_match);
    SELF.err_stat_Invalid := DNB_Party_Fields.InValid_err_stat((SALT38.StrType)le.err_stat);
    SELF.bdid_Invalid := DNB_Party_Fields.InValid_bdid((SALT38.StrType)le.bdid);
    SELF.did_Invalid := DNB_Party_Fields.InValid_did((SALT38.StrType)le.did);
    SELF.did_score_Invalid := DNB_Party_Fields.InValid_did_score((SALT38.StrType)le.did_score);
    SELF.bdid_score_Invalid := DNB_Party_Fields.InValid_bdid_score((SALT38.StrType)le.bdid_score);
    SELF.source_rec_id_Invalid := DNB_Party_Fields.InValid_source_rec_id((SALT38.StrType)le.source_rec_id);
    SELF.dotid_Invalid := DNB_Party_Fields.InValid_dotid((SALT38.StrType)le.dotid);
    SELF.dotscore_Invalid := DNB_Party_Fields.InValid_dotscore((SALT38.StrType)le.dotscore);
    SELF.dotweight_Invalid := DNB_Party_Fields.InValid_dotweight((SALT38.StrType)le.dotweight);
    SELF.empid_Invalid := DNB_Party_Fields.InValid_empid((SALT38.StrType)le.empid);
    SELF.empscore_Invalid := DNB_Party_Fields.InValid_empscore((SALT38.StrType)le.empscore);
    SELF.empweight_Invalid := DNB_Party_Fields.InValid_empweight((SALT38.StrType)le.empweight);
    SELF.powid_Invalid := DNB_Party_Fields.InValid_powid((SALT38.StrType)le.powid);
    SELF.powscore_Invalid := DNB_Party_Fields.InValid_powscore((SALT38.StrType)le.powscore);
    SELF.powweight_Invalid := DNB_Party_Fields.InValid_powweight((SALT38.StrType)le.powweight);
    SELF.proxid_Invalid := DNB_Party_Fields.InValid_proxid((SALT38.StrType)le.proxid);
    SELF.proxscore_Invalid := DNB_Party_Fields.InValid_proxscore((SALT38.StrType)le.proxscore);
    SELF.proxweight_Invalid := DNB_Party_Fields.InValid_proxweight((SALT38.StrType)le.proxweight);
    SELF.seleid_Invalid := DNB_Party_Fields.InValid_seleid((SALT38.StrType)le.seleid);
    SELF.selescore_Invalid := DNB_Party_Fields.InValid_selescore((SALT38.StrType)le.selescore);
    SELF.seleweight_Invalid := DNB_Party_Fields.InValid_seleweight((SALT38.StrType)le.seleweight);
    SELF.orgid_Invalid := DNB_Party_Fields.InValid_orgid((SALT38.StrType)le.orgid);
    SELF.orgscore_Invalid := DNB_Party_Fields.InValid_orgscore((SALT38.StrType)le.orgscore);
    SELF.orgweight_Invalid := DNB_Party_Fields.InValid_orgweight((SALT38.StrType)le.orgweight);
    SELF.ultid_Invalid := DNB_Party_Fields.InValid_ultid((SALT38.StrType)le.ultid);
    SELF.ultscore_Invalid := DNB_Party_Fields.InValid_ultscore((SALT38.StrType)le.ultscore);
    SELF.ultweight_Invalid := DNB_Party_Fields.InValid_ultweight((SALT38.StrType)le.ultweight);
    SELF.prep_addr_line1_Invalid := DNB_Party_Fields.InValid_prep_addr_line1((SALT38.StrType)le.prep_addr_line1);
    SELF.prep_addr_last_line_Invalid := DNB_Party_Fields.InValid_prep_addr_last_line((SALT38.StrType)le.prep_addr_last_line);
    SELF.rawaid_Invalid := DNB_Party_Fields.InValid_rawaid((SALT38.StrType)le.rawaid);
    SELF.aceaid_Invalid := DNB_Party_Fields.InValid_aceaid((SALT38.StrType)le.aceaid);
    SELF.persistent_record_id_Invalid := DNB_Party_Fields.InValid_persistent_record_id((SALT38.StrType)le.persistent_record_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),DNB_Party_Layout_UCCV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.tmsid_Invalid << 0 ) + ( le.rmsid_Invalid << 1 ) + ( le.orig_name_Invalid << 2 ) + ( le.orig_lname_Invalid << 4 ) + ( le.orig_fname_Invalid << 5 ) + ( le.orig_mname_Invalid << 6 ) + ( le.orig_suffix_Invalid << 7 ) + ( le.duns_number_Invalid << 8 ) + ( le.hq_duns_number_Invalid << 9 ) + ( le.ssn_Invalid << 10 ) + ( le.fein_Invalid << 11 ) + ( le.incorp_state_Invalid << 12 ) + ( le.corp_number_Invalid << 13 ) + ( le.corp_type_Invalid << 14 ) + ( le.orig_address1_Invalid << 15 ) + ( le.orig_address2_Invalid << 16 ) + ( le.orig_city_Invalid << 18 ) + ( le.orig_state_Invalid << 19 ) + ( le.orig_zip5_Invalid << 20 ) + ( le.orig_zip4_Invalid << 21 ) + ( le.orig_country_Invalid << 22 ) + ( le.orig_province_Invalid << 23 ) + ( le.foreign_indc_Invalid << 24 ) + ( le.party_type_Invalid << 25 ) + ( le.dt_first_seen_Invalid << 26 ) + ( le.dt_last_seen_Invalid << 28 ) + ( le.dt_vendor_last_reported_Invalid << 30 ) + ( le.dt_vendor_first_reported_Invalid << 32 ) + ( le.process_date_Invalid << 34 ) + ( le.title_Invalid << 36 ) + ( le.fname_Invalid << 38 ) + ( le.mname_Invalid << 39 ) + ( le.lname_Invalid << 40 ) + ( le.name_suffix_Invalid << 41 ) + ( le.name_score_Invalid << 43 ) + ( le.company_name_Invalid << 44 ) + ( le.prim_range_Invalid << 45 ) + ( le.predir_Invalid << 46 ) + ( le.prim_name_Invalid << 47 ) + ( le.suffix_Invalid << 48 ) + ( le.postdir_Invalid << 49 ) + ( le.unit_desig_Invalid << 50 ) + ( le.sec_range_Invalid << 51 ) + ( le.p_city_name_Invalid << 52 ) + ( le.v_city_name_Invalid << 53 ) + ( le.st_Invalid << 54 ) + ( le.zip5_Invalid << 55 ) + ( le.zip4_Invalid << 56 ) + ( le.county_Invalid << 57 ) + ( le.cart_Invalid << 58 ) + ( le.cr_sort_sz_Invalid << 59 ) + ( le.lot_Invalid << 60 ) + ( le.lot_order_Invalid << 61 ) + ( le.dpbc_Invalid << 62 ) + ( le.chk_digit_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.rec_type_Invalid << 0 ) + ( le.ace_fips_st_Invalid << 1 ) + ( le.ace_fips_county_Invalid << 2 ) + ( le.geo_lat_Invalid << 3 ) + ( le.geo_long_Invalid << 4 ) + ( le.msa_Invalid << 5 ) + ( le.geo_blk_Invalid << 6 ) + ( le.geo_match_Invalid << 7 ) + ( le.err_stat_Invalid << 8 ) + ( le.bdid_Invalid << 9 ) + ( le.did_Invalid << 10 ) + ( le.did_score_Invalid << 11 ) + ( le.bdid_score_Invalid << 12 ) + ( le.source_rec_id_Invalid << 13 ) + ( le.dotid_Invalid << 14 ) + ( le.dotscore_Invalid << 15 ) + ( le.dotweight_Invalid << 16 ) + ( le.empid_Invalid << 17 ) + ( le.empscore_Invalid << 18 ) + ( le.empweight_Invalid << 19 ) + ( le.powid_Invalid << 20 ) + ( le.powscore_Invalid << 21 ) + ( le.powweight_Invalid << 22 ) + ( le.proxid_Invalid << 23 ) + ( le.proxscore_Invalid << 24 ) + ( le.proxweight_Invalid << 25 ) + ( le.seleid_Invalid << 26 ) + ( le.selescore_Invalid << 27 ) + ( le.seleweight_Invalid << 28 ) + ( le.orgid_Invalid << 29 ) + ( le.orgscore_Invalid << 30 ) + ( le.orgweight_Invalid << 31 ) + ( le.ultid_Invalid << 32 ) + ( le.ultscore_Invalid << 33 ) + ( le.ultweight_Invalid << 34 ) + ( le.prep_addr_line1_Invalid << 35 ) + ( le.prep_addr_last_line_Invalid << 36 ) + ( le.rawaid_Invalid << 37 ) + ( le.aceaid_Invalid << 38 ) + ( le.persistent_record_id_Invalid << 39 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,DNB_Party_Layout_UCCV2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.tmsid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.rmsid_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.orig_name_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.orig_lname_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.orig_fname_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.orig_mname_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.orig_suffix_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.duns_number_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.hq_duns_number_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.fein_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.incorp_state_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.corp_number_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.corp_type_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.orig_address1_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.orig_address2_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.orig_zip5_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.orig_zip4_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.orig_country_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.orig_province_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.foreign_indc_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.party_type_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.title_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.name_score_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.zip5_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.county_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.cart_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.lot_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.lot_order_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.dpbc_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.chk_digit_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.rec_type_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.ace_fips_st_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.ace_fips_county_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.msa_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.geo_blk_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.geo_match_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.err_stat_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.did_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.did_score_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.bdid_score_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.source_rec_id_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.dotid_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.dotscore_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.dotweight_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.empid_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.empscore_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.empweight_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.powid_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.powscore_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.powweight_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.proxid_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.proxscore_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.proxweight_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.selescore_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.seleweight_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.orgscore_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.orgweight_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.ultid_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.ultscore_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.ultweight_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.prep_addr_line1_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.prep_addr_last_line_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF.rawaid_Invalid := (le.ScrubsBits2 >> 37) & 1;
    SELF.aceaid_Invalid := (le.ScrubsBits2 >> 38) & 1;
    SELF.persistent_record_id_Invalid := (le.ScrubsBits2 >> 39) & 1;
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
    orig_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_name_Invalid=1);
    orig_name_LENGTH_ErrorCount := COUNT(GROUP,h.orig_name_Invalid=2);
    orig_name_Total_ErrorCount := COUNT(GROUP,h.orig_name_Invalid>0);
    orig_lname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=1);
    orig_fname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=1);
    orig_mname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=1);
    orig_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid=1);
    duns_number_CUSTOM_ErrorCount := COUNT(GROUP,h.duns_number_Invalid=1);
    hq_duns_number_CUSTOM_ErrorCount := COUNT(GROUP,h.hq_duns_number_Invalid=1);
    ssn_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    fein_LENGTH_ErrorCount := COUNT(GROUP,h.fein_Invalid=1);
    incorp_state_LENGTH_ErrorCount := COUNT(GROUP,h.incorp_state_Invalid=1);
    corp_number_LENGTH_ErrorCount := COUNT(GROUP,h.corp_number_Invalid=1);
    corp_type_LENGTH_ErrorCount := COUNT(GROUP,h.corp_type_Invalid=1);
    orig_address1_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_address1_Invalid=1);
    orig_address2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address2_Invalid=1);
    orig_address2_LENGTH_ErrorCount := COUNT(GROUP,h.orig_address2_Invalid=2);
    orig_address2_Total_ErrorCount := COUNT(GROUP,h.orig_address2_Invalid>0);
    orig_city_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_state_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_zip5_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_zip5_Invalid=1);
    orig_zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_zip4_Invalid=1);
    orig_country_ALLOW_ErrorCount := COUNT(GROUP,h.orig_country_Invalid=1);
    orig_province_ALLOW_ErrorCount := COUNT(GROUP,h.orig_province_Invalid=1);
    foreign_indc_ENUM_ErrorCount := COUNT(GROUP,h.foreign_indc_Invalid=1);
    party_type_CUSTOM_ErrorCount := COUNT(GROUP,h.party_type_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=2);
    dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid>0);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=2);
    dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid>0);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=2);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_LENGTH_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    title_LENGTH_ErrorCount := COUNT(GROUP,h.title_Invalid=2);
    title_Total_ErrorCount := COUNT(GROUP,h.title_Invalid>0);
    fname_CUSTOM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    mname_CUSTOM_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    lname_CUSTOM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    name_score_ALLOW_ErrorCount := COUNT(GROUP,h.name_score_Invalid=1);
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
    AnyRule_WithErrorsCount := COUNT(GROUP, h.tmsid_Invalid > 0 OR h.rmsid_Invalid > 0 OR h.orig_name_Invalid > 0 OR h.orig_lname_Invalid > 0 OR h.orig_fname_Invalid > 0 OR h.orig_mname_Invalid > 0 OR h.orig_suffix_Invalid > 0 OR h.duns_number_Invalid > 0 OR h.hq_duns_number_Invalid > 0 OR h.ssn_Invalid > 0 OR h.fein_Invalid > 0 OR h.incorp_state_Invalid > 0 OR h.corp_number_Invalid > 0 OR h.corp_type_Invalid > 0 OR h.orig_address1_Invalid > 0 OR h.orig_address2_Invalid > 0 OR h.orig_city_Invalid > 0 OR h.orig_state_Invalid > 0 OR h.orig_zip5_Invalid > 0 OR h.orig_zip4_Invalid > 0 OR h.orig_country_Invalid > 0 OR h.orig_province_Invalid > 0 OR h.foreign_indc_Invalid > 0 OR h.party_type_Invalid > 0 OR h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.process_date_Invalid > 0 OR h.title_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.name_score_Invalid > 0 OR h.company_name_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip5_Invalid > 0 OR h.zip4_Invalid > 0 OR h.county_Invalid > 0 OR h.cart_Invalid > 0 OR h.cr_sort_sz_Invalid > 0 OR h.lot_Invalid > 0 OR h.lot_order_Invalid > 0 OR h.dpbc_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.rec_type_Invalid > 0 OR h.ace_fips_st_Invalid > 0 OR h.ace_fips_county_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.msa_Invalid > 0 OR h.geo_blk_Invalid > 0 OR h.geo_match_Invalid > 0 OR h.err_stat_Invalid > 0 OR h.bdid_Invalid > 0 OR h.did_Invalid > 0 OR h.did_score_Invalid > 0 OR h.bdid_score_Invalid > 0 OR h.source_rec_id_Invalid > 0 OR h.dotid_Invalid > 0 OR h.dotscore_Invalid > 0 OR h.dotweight_Invalid > 0 OR h.empid_Invalid > 0 OR h.empscore_Invalid > 0 OR h.empweight_Invalid > 0 OR h.powid_Invalid > 0 OR h.powscore_Invalid > 0 OR h.powweight_Invalid > 0 OR h.proxid_Invalid > 0 OR h.proxscore_Invalid > 0 OR h.proxweight_Invalid > 0 OR h.seleid_Invalid > 0 OR h.selescore_Invalid > 0 OR h.seleweight_Invalid > 0 OR h.orgid_Invalid > 0 OR h.orgscore_Invalid > 0 OR h.orgweight_Invalid > 0 OR h.ultid_Invalid > 0 OR h.ultscore_Invalid > 0 OR h.ultweight_Invalid > 0 OR h.prep_addr_line1_Invalid > 0 OR h.prep_addr_last_line_Invalid > 0 OR h.rawaid_Invalid > 0 OR h.aceaid_Invalid > 0 OR h.persistent_record_id_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.tmsid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rmsid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_lname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.orig_fname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.orig_mname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.orig_suffix_LENGTH_ErrorCount > 0, 1, 0) + IF(le.duns_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hq_duns_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ssn_LENGTH_ErrorCount > 0, 1, 0) + IF(le.fein_LENGTH_ErrorCount > 0, 1, 0) + IF(le.incorp_state_LENGTH_ErrorCount > 0, 1, 0) + IF(le.corp_number_LENGTH_ErrorCount > 0, 1, 0) + IF(le.corp_type_LENGTH_ErrorCount > 0, 1, 0) + IF(le.orig_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_address2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_country_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_province_ALLOW_ErrorCount > 0, 1, 0) + IF(le.foreign_indc_ENUM_ErrorCount > 0, 1, 0) + IF(le.party_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_Total_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_Total_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_Total_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_Total_ErrorCount > 0, 1, 0) + IF(le.process_date_Total_ErrorCount > 0, 1, 0) + IF(le.title_Total_ErrorCount > 0, 1, 0) + IF(le.fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.name_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.name_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_range_LENGTH_ErrorCount > 0, 1, 0) + IF(le.predir_LENGTH_ErrorCount > 0, 1, 0) + IF(le.prim_name_LENGTH_ErrorCount > 0, 1, 0) + IF(le.suffix_LENGTH_ErrorCount > 0, 1, 0) + IF(le.postdir_LENGTH_ErrorCount > 0, 1, 0) + IF(le.unit_desig_LENGTH_ErrorCount > 0, 1, 0) + IF(le.sec_range_LENGTH_ErrorCount > 0, 1, 0) + IF(le.p_city_name_LENGTH_ErrorCount > 0, 1, 0) + IF(le.v_city_name_LENGTH_ErrorCount > 0, 1, 0) + IF(le.st_LENGTH_ErrorCount > 0, 1, 0) + IF(le.zip5_LENGTH_ErrorCount > 0, 1, 0) + IF(le.zip4_LENGTH_ErrorCount > 0, 1, 0) + IF(le.county_LENGTH_ErrorCount > 0, 1, 0) + IF(le.cart_LENGTH_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_LENGTH_ErrorCount > 0, 1, 0) + IF(le.lot_LENGTH_ErrorCount > 0, 1, 0) + IF(le.lot_order_LENGTH_ErrorCount > 0, 1, 0) + IF(le.dpbc_LENGTH_ErrorCount > 0, 1, 0) + IF(le.chk_digit_LENGTH_ErrorCount > 0, 1, 0) + IF(le.rec_type_LENGTH_ErrorCount > 0, 1, 0) + IF(le.ace_fips_st_LENGTH_ErrorCount > 0, 1, 0) + IF(le.ace_fips_county_LENGTH_ErrorCount > 0, 1, 0) + IF(le.geo_lat_LENGTH_ErrorCount > 0, 1, 0) + IF(le.geo_long_LENGTH_ErrorCount > 0, 1, 0) + IF(le.msa_LENGTH_ErrorCount > 0, 1, 0) + IF(le.geo_blk_LENGTH_ErrorCount > 0, 1, 0) + IF(le.geo_match_LENGTH_ErrorCount > 0, 1, 0) + IF(le.err_stat_LENGTH_ErrorCount > 0, 1, 0) + IF(le.bdid_ENUM_ErrorCount > 0, 1, 0) + IF(le.did_ENUM_ErrorCount > 0, 1, 0) + IF(le.did_score_ENUM_ErrorCount > 0, 1, 0) + IF(le.bdid_score_ENUM_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotid_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.empid_ENUM_ErrorCount > 0, 1, 0) + IF(le.empscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.empweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.powid_ENUM_ErrorCount > 0, 1, 0) + IF(le.powscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.powweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.proxid_ENUM_ErrorCount > 0, 1, 0) + IF(le.proxscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.proxweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.seleid_ENUM_ErrorCount > 0, 1, 0) + IF(le.selescore_ENUM_ErrorCount > 0, 1, 0) + IF(le.seleweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.orgid_ENUM_ErrorCount > 0, 1, 0) + IF(le.orgscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.orgweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.ultid_ENUM_ErrorCount > 0, 1, 0) + IF(le.ultscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.ultweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_last_line_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawaid_ENUM_ErrorCount > 0, 1, 0) + IF(le.aceaid_ENUM_ErrorCount > 0, 1, 0) + IF(le.persistent_record_id_ENUM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.tmsid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rmsid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_name_LENGTH_ErrorCount > 0, 1, 0) + IF(le.orig_lname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.orig_fname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.orig_mname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.orig_suffix_LENGTH_ErrorCount > 0, 1, 0) + IF(le.duns_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hq_duns_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ssn_LENGTH_ErrorCount > 0, 1, 0) + IF(le.fein_LENGTH_ErrorCount > 0, 1, 0) + IF(le.incorp_state_LENGTH_ErrorCount > 0, 1, 0) + IF(le.corp_number_LENGTH_ErrorCount > 0, 1, 0) + IF(le.corp_type_LENGTH_ErrorCount > 0, 1, 0) + IF(le.orig_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_address2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address2_LENGTH_ErrorCount > 0, 1, 0) + IF(le.orig_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_country_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_province_ALLOW_ErrorCount > 0, 1, 0) + IF(le.foreign_indc_ENUM_ErrorCount > 0, 1, 0) + IF(le.party_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_LENGTH_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_LENGTH_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_LENGTH_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_LENGTH_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_LENGTH_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_LENGTH_ErrorCount > 0, 1, 0) + IF(le.fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_LENGTH_ErrorCount > 0, 1, 0) + IF(le.name_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_range_LENGTH_ErrorCount > 0, 1, 0) + IF(le.predir_LENGTH_ErrorCount > 0, 1, 0) + IF(le.prim_name_LENGTH_ErrorCount > 0, 1, 0) + IF(le.suffix_LENGTH_ErrorCount > 0, 1, 0) + IF(le.postdir_LENGTH_ErrorCount > 0, 1, 0) + IF(le.unit_desig_LENGTH_ErrorCount > 0, 1, 0) + IF(le.sec_range_LENGTH_ErrorCount > 0, 1, 0) + IF(le.p_city_name_LENGTH_ErrorCount > 0, 1, 0) + IF(le.v_city_name_LENGTH_ErrorCount > 0, 1, 0) + IF(le.st_LENGTH_ErrorCount > 0, 1, 0) + IF(le.zip5_LENGTH_ErrorCount > 0, 1, 0) + IF(le.zip4_LENGTH_ErrorCount > 0, 1, 0) + IF(le.county_LENGTH_ErrorCount > 0, 1, 0) + IF(le.cart_LENGTH_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_LENGTH_ErrorCount > 0, 1, 0) + IF(le.lot_LENGTH_ErrorCount > 0, 1, 0) + IF(le.lot_order_LENGTH_ErrorCount > 0, 1, 0) + IF(le.dpbc_LENGTH_ErrorCount > 0, 1, 0) + IF(le.chk_digit_LENGTH_ErrorCount > 0, 1, 0) + IF(le.rec_type_LENGTH_ErrorCount > 0, 1, 0) + IF(le.ace_fips_st_LENGTH_ErrorCount > 0, 1, 0) + IF(le.ace_fips_county_LENGTH_ErrorCount > 0, 1, 0) + IF(le.geo_lat_LENGTH_ErrorCount > 0, 1, 0) + IF(le.geo_long_LENGTH_ErrorCount > 0, 1, 0) + IF(le.msa_LENGTH_ErrorCount > 0, 1, 0) + IF(le.geo_blk_LENGTH_ErrorCount > 0, 1, 0) + IF(le.geo_match_LENGTH_ErrorCount > 0, 1, 0) + IF(le.err_stat_LENGTH_ErrorCount > 0, 1, 0) + IF(le.bdid_ENUM_ErrorCount > 0, 1, 0) + IF(le.did_ENUM_ErrorCount > 0, 1, 0) + IF(le.did_score_ENUM_ErrorCount > 0, 1, 0) + IF(le.bdid_score_ENUM_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotid_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.empid_ENUM_ErrorCount > 0, 1, 0) + IF(le.empscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.empweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.powid_ENUM_ErrorCount > 0, 1, 0) + IF(le.powscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.powweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.proxid_ENUM_ErrorCount > 0, 1, 0) + IF(le.proxscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.proxweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.seleid_ENUM_ErrorCount > 0, 1, 0) + IF(le.selescore_ENUM_ErrorCount > 0, 1, 0) + IF(le.seleweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.orgid_ENUM_ErrorCount > 0, 1, 0) + IF(le.orgscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.orgweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.ultid_ENUM_ErrorCount > 0, 1, 0) + IF(le.ultscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.ultweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_last_line_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawaid_ENUM_ErrorCount > 0, 1, 0) + IF(le.aceaid_ENUM_ErrorCount > 0, 1, 0) + IF(le.persistent_record_id_ENUM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT38.StrType ErrorMessage;
    SALT38.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.tmsid_Invalid,le.rmsid_Invalid,le.orig_name_Invalid,le.orig_lname_Invalid,le.orig_fname_Invalid,le.orig_mname_Invalid,le.orig_suffix_Invalid,le.duns_number_Invalid,le.hq_duns_number_Invalid,le.ssn_Invalid,le.fein_Invalid,le.incorp_state_Invalid,le.corp_number_Invalid,le.corp_type_Invalid,le.orig_address1_Invalid,le.orig_address2_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.orig_zip5_Invalid,le.orig_zip4_Invalid,le.orig_country_Invalid,le.orig_province_Invalid,le.foreign_indc_Invalid,le.party_type_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_last_reported_Invalid,le.dt_vendor_first_reported_Invalid,le.process_date_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.name_score_Invalid,le.company_name_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip5_Invalid,le.zip4_Invalid,le.county_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dpbc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.ace_fips_st_Invalid,le.ace_fips_county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.bdid_Invalid,le.did_Invalid,le.did_score_Invalid,le.bdid_score_Invalid,le.source_rec_id_Invalid,le.dotid_Invalid,le.dotscore_Invalid,le.dotweight_Invalid,le.empid_Invalid,le.empscore_Invalid,le.empweight_Invalid,le.powid_Invalid,le.powscore_Invalid,le.powweight_Invalid,le.proxid_Invalid,le.proxscore_Invalid,le.proxweight_Invalid,le.seleid_Invalid,le.selescore_Invalid,le.seleweight_Invalid,le.orgid_Invalid,le.orgscore_Invalid,le.orgweight_Invalid,le.ultid_Invalid,le.ultscore_Invalid,le.ultweight_Invalid,le.prep_addr_line1_Invalid,le.prep_addr_last_line_Invalid,le.rawaid_Invalid,le.aceaid_Invalid,le.persistent_record_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,DNB_Party_Fields.InvalidMessage_tmsid(le.tmsid_Invalid),DNB_Party_Fields.InvalidMessage_rmsid(le.rmsid_Invalid),DNB_Party_Fields.InvalidMessage_orig_name(le.orig_name_Invalid),DNB_Party_Fields.InvalidMessage_orig_lname(le.orig_lname_Invalid),DNB_Party_Fields.InvalidMessage_orig_fname(le.orig_fname_Invalid),DNB_Party_Fields.InvalidMessage_orig_mname(le.orig_mname_Invalid),DNB_Party_Fields.InvalidMessage_orig_suffix(le.orig_suffix_Invalid),DNB_Party_Fields.InvalidMessage_duns_number(le.duns_number_Invalid),DNB_Party_Fields.InvalidMessage_hq_duns_number(le.hq_duns_number_Invalid),DNB_Party_Fields.InvalidMessage_ssn(le.ssn_Invalid),DNB_Party_Fields.InvalidMessage_fein(le.fein_Invalid),DNB_Party_Fields.InvalidMessage_incorp_state(le.incorp_state_Invalid),DNB_Party_Fields.InvalidMessage_corp_number(le.corp_number_Invalid),DNB_Party_Fields.InvalidMessage_corp_type(le.corp_type_Invalid),DNB_Party_Fields.InvalidMessage_orig_address1(le.orig_address1_Invalid),DNB_Party_Fields.InvalidMessage_orig_address2(le.orig_address2_Invalid),DNB_Party_Fields.InvalidMessage_orig_city(le.orig_city_Invalid),DNB_Party_Fields.InvalidMessage_orig_state(le.orig_state_Invalid),DNB_Party_Fields.InvalidMessage_orig_zip5(le.orig_zip5_Invalid),DNB_Party_Fields.InvalidMessage_orig_zip4(le.orig_zip4_Invalid),DNB_Party_Fields.InvalidMessage_orig_country(le.orig_country_Invalid),DNB_Party_Fields.InvalidMessage_orig_province(le.orig_province_Invalid),DNB_Party_Fields.InvalidMessage_foreign_indc(le.foreign_indc_Invalid),DNB_Party_Fields.InvalidMessage_party_type(le.party_type_Invalid),DNB_Party_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),DNB_Party_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),DNB_Party_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),DNB_Party_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),DNB_Party_Fields.InvalidMessage_process_date(le.process_date_Invalid),DNB_Party_Fields.InvalidMessage_title(le.title_Invalid),DNB_Party_Fields.InvalidMessage_fname(le.fname_Invalid),DNB_Party_Fields.InvalidMessage_mname(le.mname_Invalid),DNB_Party_Fields.InvalidMessage_lname(le.lname_Invalid),DNB_Party_Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),DNB_Party_Fields.InvalidMessage_name_score(le.name_score_Invalid),DNB_Party_Fields.InvalidMessage_company_name(le.company_name_Invalid),DNB_Party_Fields.InvalidMessage_prim_range(le.prim_range_Invalid),DNB_Party_Fields.InvalidMessage_predir(le.predir_Invalid),DNB_Party_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),DNB_Party_Fields.InvalidMessage_suffix(le.suffix_Invalid),DNB_Party_Fields.InvalidMessage_postdir(le.postdir_Invalid),DNB_Party_Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),DNB_Party_Fields.InvalidMessage_sec_range(le.sec_range_Invalid),DNB_Party_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),DNB_Party_Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),DNB_Party_Fields.InvalidMessage_st(le.st_Invalid),DNB_Party_Fields.InvalidMessage_zip5(le.zip5_Invalid),DNB_Party_Fields.InvalidMessage_zip4(le.zip4_Invalid),DNB_Party_Fields.InvalidMessage_county(le.county_Invalid),DNB_Party_Fields.InvalidMessage_cart(le.cart_Invalid),DNB_Party_Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),DNB_Party_Fields.InvalidMessage_lot(le.lot_Invalid),DNB_Party_Fields.InvalidMessage_lot_order(le.lot_order_Invalid),DNB_Party_Fields.InvalidMessage_dpbc(le.dpbc_Invalid),DNB_Party_Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),DNB_Party_Fields.InvalidMessage_rec_type(le.rec_type_Invalid),DNB_Party_Fields.InvalidMessage_ace_fips_st(le.ace_fips_st_Invalid),DNB_Party_Fields.InvalidMessage_ace_fips_county(le.ace_fips_county_Invalid),DNB_Party_Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),DNB_Party_Fields.InvalidMessage_geo_long(le.geo_long_Invalid),DNB_Party_Fields.InvalidMessage_msa(le.msa_Invalid),DNB_Party_Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),DNB_Party_Fields.InvalidMessage_geo_match(le.geo_match_Invalid),DNB_Party_Fields.InvalidMessage_err_stat(le.err_stat_Invalid),DNB_Party_Fields.InvalidMessage_bdid(le.bdid_Invalid),DNB_Party_Fields.InvalidMessage_did(le.did_Invalid),DNB_Party_Fields.InvalidMessage_did_score(le.did_score_Invalid),DNB_Party_Fields.InvalidMessage_bdid_score(le.bdid_score_Invalid),DNB_Party_Fields.InvalidMessage_source_rec_id(le.source_rec_id_Invalid),DNB_Party_Fields.InvalidMessage_dotid(le.dotid_Invalid),DNB_Party_Fields.InvalidMessage_dotscore(le.dotscore_Invalid),DNB_Party_Fields.InvalidMessage_dotweight(le.dotweight_Invalid),DNB_Party_Fields.InvalidMessage_empid(le.empid_Invalid),DNB_Party_Fields.InvalidMessage_empscore(le.empscore_Invalid),DNB_Party_Fields.InvalidMessage_empweight(le.empweight_Invalid),DNB_Party_Fields.InvalidMessage_powid(le.powid_Invalid),DNB_Party_Fields.InvalidMessage_powscore(le.powscore_Invalid),DNB_Party_Fields.InvalidMessage_powweight(le.powweight_Invalid),DNB_Party_Fields.InvalidMessage_proxid(le.proxid_Invalid),DNB_Party_Fields.InvalidMessage_proxscore(le.proxscore_Invalid),DNB_Party_Fields.InvalidMessage_proxweight(le.proxweight_Invalid),DNB_Party_Fields.InvalidMessage_seleid(le.seleid_Invalid),DNB_Party_Fields.InvalidMessage_selescore(le.selescore_Invalid),DNB_Party_Fields.InvalidMessage_seleweight(le.seleweight_Invalid),DNB_Party_Fields.InvalidMessage_orgid(le.orgid_Invalid),DNB_Party_Fields.InvalidMessage_orgscore(le.orgscore_Invalid),DNB_Party_Fields.InvalidMessage_orgweight(le.orgweight_Invalid),DNB_Party_Fields.InvalidMessage_ultid(le.ultid_Invalid),DNB_Party_Fields.InvalidMessage_ultscore(le.ultscore_Invalid),DNB_Party_Fields.InvalidMessage_ultweight(le.ultweight_Invalid),DNB_Party_Fields.InvalidMessage_prep_addr_line1(le.prep_addr_line1_Invalid),DNB_Party_Fields.InvalidMessage_prep_addr_last_line(le.prep_addr_last_line_Invalid),DNB_Party_Fields.InvalidMessage_rawaid(le.rawaid_Invalid),DNB_Party_Fields.InvalidMessage_aceaid(le.aceaid_Invalid),DNB_Party_Fields.InvalidMessage_persistent_record_id(le.persistent_record_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.tmsid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rmsid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_lname_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_fname_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_mname_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_suffix_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.duns_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.hq_duns_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.fein_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.incorp_state_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_number_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_type_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_address2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_zip5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_province_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.foreign_indc_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.party_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.name_score_Invalid,'ALLOW','UNKNOWN')
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
    SELF.FieldName := CHOOSE(c,'tmsid','rmsid','orig_name','orig_lname','orig_fname','orig_mname','orig_suffix','duns_number','hq_duns_number','ssn','fein','incorp_state','corp_number','corp_type','orig_address1','orig_address2','orig_city','orig_state','orig_zip5','orig_zip4','orig_country','orig_province','foreign_indc','party_type','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','process_date','title','fname','mname','lname','name_suffix','name_score','company_name','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','county','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','ace_fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','bdid','did','did_score','bdid_score','source_rec_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','prep_addr_line1','prep_addr_last_line','rawaid','aceaid','persistent_record_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_tmsid','invalid_rmsid','invalid_wordbag','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_duns_number','invalid_duns_number','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_orig_address1','invalid_wordbag','invalid_mandatory','invalid_mandatory','invalid_zip_code5','invalid_zip_code4','invalid_alpha_blank','invalid_alpha_blank','invalid_boolean_yn_empty','invalid_party_type','invalid_pastdate06','invalid_pastdate06','invalid_pastdate06','invalid_pastdate06','invalid_08pastdate','invalid_wordbag','invalid_fname','invalid_mname','invalid_lname','invalid_wordbag','invalid_numeric_blank','invalid_company_name','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_mandatory','invalid_mandatory','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.tmsid,(SALT38.StrType)le.rmsid,(SALT38.StrType)le.orig_name,(SALT38.StrType)le.orig_lname,(SALT38.StrType)le.orig_fname,(SALT38.StrType)le.orig_mname,(SALT38.StrType)le.orig_suffix,(SALT38.StrType)le.duns_number,(SALT38.StrType)le.hq_duns_number,(SALT38.StrType)le.ssn,(SALT38.StrType)le.fein,(SALT38.StrType)le.incorp_state,(SALT38.StrType)le.corp_number,(SALT38.StrType)le.corp_type,(SALT38.StrType)le.orig_address1,(SALT38.StrType)le.orig_address2,(SALT38.StrType)le.orig_city,(SALT38.StrType)le.orig_state,(SALT38.StrType)le.orig_zip5,(SALT38.StrType)le.orig_zip4,(SALT38.StrType)le.orig_country,(SALT38.StrType)le.orig_province,(SALT38.StrType)le.foreign_indc,(SALT38.StrType)le.party_type,(SALT38.StrType)le.dt_first_seen,(SALT38.StrType)le.dt_last_seen,(SALT38.StrType)le.dt_vendor_last_reported,(SALT38.StrType)le.dt_vendor_first_reported,(SALT38.StrType)le.process_date,(SALT38.StrType)le.title,(SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.lname,(SALT38.StrType)le.name_suffix,(SALT38.StrType)le.name_score,(SALT38.StrType)le.company_name,(SALT38.StrType)le.prim_range,(SALT38.StrType)le.predir,(SALT38.StrType)le.prim_name,(SALT38.StrType)le.suffix,(SALT38.StrType)le.postdir,(SALT38.StrType)le.unit_desig,(SALT38.StrType)le.sec_range,(SALT38.StrType)le.p_city_name,(SALT38.StrType)le.v_city_name,(SALT38.StrType)le.st,(SALT38.StrType)le.zip5,(SALT38.StrType)le.zip4,(SALT38.StrType)le.county,(SALT38.StrType)le.cart,(SALT38.StrType)le.cr_sort_sz,(SALT38.StrType)le.lot,(SALT38.StrType)le.lot_order,(SALT38.StrType)le.dpbc,(SALT38.StrType)le.chk_digit,(SALT38.StrType)le.rec_type,(SALT38.StrType)le.ace_fips_st,(SALT38.StrType)le.ace_fips_county,(SALT38.StrType)le.geo_lat,(SALT38.StrType)le.geo_long,(SALT38.StrType)le.msa,(SALT38.StrType)le.geo_blk,(SALT38.StrType)le.geo_match,(SALT38.StrType)le.err_stat,(SALT38.StrType)le.bdid,(SALT38.StrType)le.did,(SALT38.StrType)le.did_score,(SALT38.StrType)le.bdid_score,(SALT38.StrType)le.source_rec_id,(SALT38.StrType)le.dotid,(SALT38.StrType)le.dotscore,(SALT38.StrType)le.dotweight,(SALT38.StrType)le.empid,(SALT38.StrType)le.empscore,(SALT38.StrType)le.empweight,(SALT38.StrType)le.powid,(SALT38.StrType)le.powscore,(SALT38.StrType)le.powweight,(SALT38.StrType)le.proxid,(SALT38.StrType)le.proxscore,(SALT38.StrType)le.proxweight,(SALT38.StrType)le.seleid,(SALT38.StrType)le.selescore,(SALT38.StrType)le.seleweight,(SALT38.StrType)le.orgid,(SALT38.StrType)le.orgscore,(SALT38.StrType)le.orgweight,(SALT38.StrType)le.ultid,(SALT38.StrType)le.ultscore,(SALT38.StrType)le.ultweight,(SALT38.StrType)le.prep_addr_line1,(SALT38.StrType)le.prep_addr_last_line,(SALT38.StrType)le.rawaid,(SALT38.StrType)le.aceaid,(SALT38.StrType)le.persistent_record_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,95,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(DNB_Party_Layout_UCCV2) prevDS = DATASET([], DNB_Party_Layout_UCCV2), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'tmsid:invalid_tmsid:CUSTOM'
          ,'rmsid:invalid_rmsid:CUSTOM'
          ,'orig_name:invalid_wordbag:ALLOW','orig_name:invalid_wordbag:LENGTH'
          ,'orig_lname:invalid_empty:LENGTH'
          ,'orig_fname:invalid_empty:LENGTH'
          ,'orig_mname:invalid_empty:LENGTH'
          ,'orig_suffix:invalid_empty:LENGTH'
          ,'duns_number:invalid_duns_number:CUSTOM'
          ,'hq_duns_number:invalid_duns_number:CUSTOM'
          ,'ssn:invalid_empty:LENGTH'
          ,'fein:invalid_empty:LENGTH'
          ,'incorp_state:invalid_empty:LENGTH'
          ,'corp_number:invalid_empty:LENGTH'
          ,'corp_type:invalid_empty:LENGTH'
          ,'orig_address1:invalid_orig_address1:CUSTOM'
          ,'orig_address2:invalid_wordbag:ALLOW','orig_address2:invalid_wordbag:LENGTH'
          ,'orig_city:invalid_mandatory:CUSTOM'
          ,'orig_state:invalid_mandatory:CUSTOM'
          ,'orig_zip5:invalid_zip_code5:CUSTOM'
          ,'orig_zip4:invalid_zip_code4:CUSTOM'
          ,'orig_country:invalid_alpha_blank:ALLOW'
          ,'orig_province:invalid_alpha_blank:ALLOW'
          ,'foreign_indc:invalid_boolean_yn_empty:ENUM'
          ,'party_type:invalid_party_type:CUSTOM'
          ,'dt_first_seen:invalid_pastdate06:CUSTOM','dt_first_seen:invalid_pastdate06:LENGTH'
          ,'dt_last_seen:invalid_pastdate06:CUSTOM','dt_last_seen:invalid_pastdate06:LENGTH'
          ,'dt_vendor_last_reported:invalid_pastdate06:CUSTOM','dt_vendor_last_reported:invalid_pastdate06:LENGTH'
          ,'dt_vendor_first_reported:invalid_pastdate06:CUSTOM','dt_vendor_first_reported:invalid_pastdate06:LENGTH'
          ,'process_date:invalid_08pastdate:CUSTOM','process_date:invalid_08pastdate:LENGTH'
          ,'title:invalid_wordbag:ALLOW','title:invalid_wordbag:LENGTH'
          ,'fname:invalid_fname:CUSTOM'
          ,'mname:invalid_mname:CUSTOM'
          ,'lname:invalid_lname:CUSTOM'
          ,'name_suffix:invalid_wordbag:ALLOW','name_suffix:invalid_wordbag:LENGTH'
          ,'name_score:invalid_numeric_blank:ALLOW'
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
          ,'persistent_record_id:invalid_zero_integer:ENUM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,DNB_Party_Fields.InvalidMessage_tmsid(1)
          ,DNB_Party_Fields.InvalidMessage_rmsid(1)
          ,DNB_Party_Fields.InvalidMessage_orig_name(1),DNB_Party_Fields.InvalidMessage_orig_name(2)
          ,DNB_Party_Fields.InvalidMessage_orig_lname(1)
          ,DNB_Party_Fields.InvalidMessage_orig_fname(1)
          ,DNB_Party_Fields.InvalidMessage_orig_mname(1)
          ,DNB_Party_Fields.InvalidMessage_orig_suffix(1)
          ,DNB_Party_Fields.InvalidMessage_duns_number(1)
          ,DNB_Party_Fields.InvalidMessage_hq_duns_number(1)
          ,DNB_Party_Fields.InvalidMessage_ssn(1)
          ,DNB_Party_Fields.InvalidMessage_fein(1)
          ,DNB_Party_Fields.InvalidMessage_incorp_state(1)
          ,DNB_Party_Fields.InvalidMessage_corp_number(1)
          ,DNB_Party_Fields.InvalidMessage_corp_type(1)
          ,DNB_Party_Fields.InvalidMessage_orig_address1(1)
          ,DNB_Party_Fields.InvalidMessage_orig_address2(1),DNB_Party_Fields.InvalidMessage_orig_address2(2)
          ,DNB_Party_Fields.InvalidMessage_orig_city(1)
          ,DNB_Party_Fields.InvalidMessage_orig_state(1)
          ,DNB_Party_Fields.InvalidMessage_orig_zip5(1)
          ,DNB_Party_Fields.InvalidMessage_orig_zip4(1)
          ,DNB_Party_Fields.InvalidMessage_orig_country(1)
          ,DNB_Party_Fields.InvalidMessage_orig_province(1)
          ,DNB_Party_Fields.InvalidMessage_foreign_indc(1)
          ,DNB_Party_Fields.InvalidMessage_party_type(1)
          ,DNB_Party_Fields.InvalidMessage_dt_first_seen(1),DNB_Party_Fields.InvalidMessage_dt_first_seen(2)
          ,DNB_Party_Fields.InvalidMessage_dt_last_seen(1),DNB_Party_Fields.InvalidMessage_dt_last_seen(2)
          ,DNB_Party_Fields.InvalidMessage_dt_vendor_last_reported(1),DNB_Party_Fields.InvalidMessage_dt_vendor_last_reported(2)
          ,DNB_Party_Fields.InvalidMessage_dt_vendor_first_reported(1),DNB_Party_Fields.InvalidMessage_dt_vendor_first_reported(2)
          ,DNB_Party_Fields.InvalidMessage_process_date(1),DNB_Party_Fields.InvalidMessage_process_date(2)
          ,DNB_Party_Fields.InvalidMessage_title(1),DNB_Party_Fields.InvalidMessage_title(2)
          ,DNB_Party_Fields.InvalidMessage_fname(1)
          ,DNB_Party_Fields.InvalidMessage_mname(1)
          ,DNB_Party_Fields.InvalidMessage_lname(1)
          ,DNB_Party_Fields.InvalidMessage_name_suffix(1),DNB_Party_Fields.InvalidMessage_name_suffix(2)
          ,DNB_Party_Fields.InvalidMessage_name_score(1)
          ,DNB_Party_Fields.InvalidMessage_company_name(1)
          ,DNB_Party_Fields.InvalidMessage_prim_range(1)
          ,DNB_Party_Fields.InvalidMessage_predir(1)
          ,DNB_Party_Fields.InvalidMessage_prim_name(1)
          ,DNB_Party_Fields.InvalidMessage_suffix(1)
          ,DNB_Party_Fields.InvalidMessage_postdir(1)
          ,DNB_Party_Fields.InvalidMessage_unit_desig(1)
          ,DNB_Party_Fields.InvalidMessage_sec_range(1)
          ,DNB_Party_Fields.InvalidMessage_p_city_name(1)
          ,DNB_Party_Fields.InvalidMessage_v_city_name(1)
          ,DNB_Party_Fields.InvalidMessage_st(1)
          ,DNB_Party_Fields.InvalidMessage_zip5(1)
          ,DNB_Party_Fields.InvalidMessage_zip4(1)
          ,DNB_Party_Fields.InvalidMessage_county(1)
          ,DNB_Party_Fields.InvalidMessage_cart(1)
          ,DNB_Party_Fields.InvalidMessage_cr_sort_sz(1)
          ,DNB_Party_Fields.InvalidMessage_lot(1)
          ,DNB_Party_Fields.InvalidMessage_lot_order(1)
          ,DNB_Party_Fields.InvalidMessage_dpbc(1)
          ,DNB_Party_Fields.InvalidMessage_chk_digit(1)
          ,DNB_Party_Fields.InvalidMessage_rec_type(1)
          ,DNB_Party_Fields.InvalidMessage_ace_fips_st(1)
          ,DNB_Party_Fields.InvalidMessage_ace_fips_county(1)
          ,DNB_Party_Fields.InvalidMessage_geo_lat(1)
          ,DNB_Party_Fields.InvalidMessage_geo_long(1)
          ,DNB_Party_Fields.InvalidMessage_msa(1)
          ,DNB_Party_Fields.InvalidMessage_geo_blk(1)
          ,DNB_Party_Fields.InvalidMessage_geo_match(1)
          ,DNB_Party_Fields.InvalidMessage_err_stat(1)
          ,DNB_Party_Fields.InvalidMessage_bdid(1)
          ,DNB_Party_Fields.InvalidMessage_did(1)
          ,DNB_Party_Fields.InvalidMessage_did_score(1)
          ,DNB_Party_Fields.InvalidMessage_bdid_score(1)
          ,DNB_Party_Fields.InvalidMessage_source_rec_id(1)
          ,DNB_Party_Fields.InvalidMessage_dotid(1)
          ,DNB_Party_Fields.InvalidMessage_dotscore(1)
          ,DNB_Party_Fields.InvalidMessage_dotweight(1)
          ,DNB_Party_Fields.InvalidMessage_empid(1)
          ,DNB_Party_Fields.InvalidMessage_empscore(1)
          ,DNB_Party_Fields.InvalidMessage_empweight(1)
          ,DNB_Party_Fields.InvalidMessage_powid(1)
          ,DNB_Party_Fields.InvalidMessage_powscore(1)
          ,DNB_Party_Fields.InvalidMessage_powweight(1)
          ,DNB_Party_Fields.InvalidMessage_proxid(1)
          ,DNB_Party_Fields.InvalidMessage_proxscore(1)
          ,DNB_Party_Fields.InvalidMessage_proxweight(1)
          ,DNB_Party_Fields.InvalidMessage_seleid(1)
          ,DNB_Party_Fields.InvalidMessage_selescore(1)
          ,DNB_Party_Fields.InvalidMessage_seleweight(1)
          ,DNB_Party_Fields.InvalidMessage_orgid(1)
          ,DNB_Party_Fields.InvalidMessage_orgscore(1)
          ,DNB_Party_Fields.InvalidMessage_orgweight(1)
          ,DNB_Party_Fields.InvalidMessage_ultid(1)
          ,DNB_Party_Fields.InvalidMessage_ultscore(1)
          ,DNB_Party_Fields.InvalidMessage_ultweight(1)
          ,DNB_Party_Fields.InvalidMessage_prep_addr_line1(1)
          ,DNB_Party_Fields.InvalidMessage_prep_addr_last_line(1)
          ,DNB_Party_Fields.InvalidMessage_rawaid(1)
          ,DNB_Party_Fields.InvalidMessage_aceaid(1)
          ,DNB_Party_Fields.InvalidMessage_persistent_record_id(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.tmsid_CUSTOM_ErrorCount
          ,le.rmsid_CUSTOM_ErrorCount
          ,le.orig_name_ALLOW_ErrorCount,le.orig_name_LENGTH_ErrorCount
          ,le.orig_lname_LENGTH_ErrorCount
          ,le.orig_fname_LENGTH_ErrorCount
          ,le.orig_mname_LENGTH_ErrorCount
          ,le.orig_suffix_LENGTH_ErrorCount
          ,le.duns_number_CUSTOM_ErrorCount
          ,le.hq_duns_number_CUSTOM_ErrorCount
          ,le.ssn_LENGTH_ErrorCount
          ,le.fein_LENGTH_ErrorCount
          ,le.incorp_state_LENGTH_ErrorCount
          ,le.corp_number_LENGTH_ErrorCount
          ,le.corp_type_LENGTH_ErrorCount
          ,le.orig_address1_CUSTOM_ErrorCount
          ,le.orig_address2_ALLOW_ErrorCount,le.orig_address2_LENGTH_ErrorCount
          ,le.orig_city_CUSTOM_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip5_CUSTOM_ErrorCount
          ,le.orig_zip4_CUSTOM_ErrorCount
          ,le.orig_country_ALLOW_ErrorCount
          ,le.orig_province_ALLOW_ErrorCount
          ,le.foreign_indc_ENUM_ErrorCount
          ,le.party_type_CUSTOM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.title_ALLOW_ErrorCount,le.title_LENGTH_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.mname_CUSTOM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount
          ,le.name_score_ALLOW_ErrorCount
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
          ,le.persistent_record_id_ENUM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.tmsid_CUSTOM_ErrorCount
          ,le.rmsid_CUSTOM_ErrorCount
          ,le.orig_name_ALLOW_ErrorCount,le.orig_name_LENGTH_ErrorCount
          ,le.orig_lname_LENGTH_ErrorCount
          ,le.orig_fname_LENGTH_ErrorCount
          ,le.orig_mname_LENGTH_ErrorCount
          ,le.orig_suffix_LENGTH_ErrorCount
          ,le.duns_number_CUSTOM_ErrorCount
          ,le.hq_duns_number_CUSTOM_ErrorCount
          ,le.ssn_LENGTH_ErrorCount
          ,le.fein_LENGTH_ErrorCount
          ,le.incorp_state_LENGTH_ErrorCount
          ,le.corp_number_LENGTH_ErrorCount
          ,le.corp_type_LENGTH_ErrorCount
          ,le.orig_address1_CUSTOM_ErrorCount
          ,le.orig_address2_ALLOW_ErrorCount,le.orig_address2_LENGTH_ErrorCount
          ,le.orig_city_CUSTOM_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip5_CUSTOM_ErrorCount
          ,le.orig_zip4_CUSTOM_ErrorCount
          ,le.orig_country_ALLOW_ErrorCount
          ,le.orig_province_ALLOW_ErrorCount
          ,le.foreign_indc_ENUM_ErrorCount
          ,le.party_type_CUSTOM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.title_ALLOW_ErrorCount,le.title_LENGTH_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.mname_CUSTOM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount
          ,le.name_score_ALLOW_ErrorCount
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
          ,le.persistent_record_id_ENUM_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
      SALT38.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT38.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := DNB_Party_hygiene(PROJECT(h, DNB_Party_Layout_UCCV2));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT38.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'tmsid:' + getFieldTypeText(h.tmsid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rmsid:' + getFieldTypeText(h.rmsid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_name:' + getFieldTypeText(h.orig_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_lname:' + getFieldTypeText(h.orig_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fname:' + getFieldTypeText(h.orig_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mname:' + getFieldTypeText(h.orig_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_suffix:' + getFieldTypeText(h.orig_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'duns_number:' + getFieldTypeText(h.duns_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hq_duns_number:' + getFieldTypeText(h.hq_duns_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn:' + getFieldTypeText(h.ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fein:' + getFieldTypeText(h.fein) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'incorp_state:' + getFieldTypeText(h.incorp_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_number:' + getFieldTypeText(h.corp_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_type:' + getFieldTypeText(h.corp_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address1:' + getFieldTypeText(h.orig_address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address2:' + getFieldTypeText(h.orig_address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_city:' + getFieldTypeText(h.orig_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state:' + getFieldTypeText(h.orig_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip5:' + getFieldTypeText(h.orig_zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip4:' + getFieldTypeText(h.orig_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_country:' + getFieldTypeText(h.orig_country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_province:' + getFieldTypeText(h.orig_province) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_postal_code:' + getFieldTypeText(h.orig_postal_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'foreign_indc:' + getFieldTypeText(h.foreign_indc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party_type:' + getFieldTypeText(h.party_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_score:' + getFieldTypeText(h.name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip5:' + getFieldTypeText(h.zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpbc:' + getFieldTypeText(h.dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_st:' + getFieldTypeText(h.ace_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_county:' + getFieldTypeText(h.ace_fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_score:' + getFieldTypeText(h.did_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid_score:' + getFieldTypeText(h.bdid_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_rec_id:' + getFieldTypeText(h.source_rec_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotid:' + getFieldTypeText(h.dotid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotscore:' + getFieldTypeText(h.dotscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotweight:' + getFieldTypeText(h.dotweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empid:' + getFieldTypeText(h.empid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empscore:' + getFieldTypeText(h.empscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empweight:' + getFieldTypeText(h.empweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powid:' + getFieldTypeText(h.powid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powscore:' + getFieldTypeText(h.powscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powweight:' + getFieldTypeText(h.powweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxid:' + getFieldTypeText(h.proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxscore:' + getFieldTypeText(h.proxscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxweight:' + getFieldTypeText(h.proxweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleid:' + getFieldTypeText(h.seleid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'selescore:' + getFieldTypeText(h.selescore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleweight:' + getFieldTypeText(h.seleweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid:' + getFieldTypeText(h.orgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgscore:' + getFieldTypeText(h.orgscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgweight:' + getFieldTypeText(h.orgweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultid:' + getFieldTypeText(h.ultid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultscore:' + getFieldTypeText(h.ultscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultweight:' + getFieldTypeText(h.ultweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_line1:' + getFieldTypeText(h.prep_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_last_line:' + getFieldTypeText(h.prep_addr_last_line) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawaid:' + getFieldTypeText(h.rawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aceaid:' + getFieldTypeText(h.aceaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'persistent_record_id:' + getFieldTypeText(h.persistent_record_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_tmsid_cnt
          ,le.populated_rmsid_cnt
          ,le.populated_orig_name_cnt
          ,le.populated_orig_lname_cnt
          ,le.populated_orig_fname_cnt
          ,le.populated_orig_mname_cnt
          ,le.populated_orig_suffix_cnt
          ,le.populated_duns_number_cnt
          ,le.populated_hq_duns_number_cnt
          ,le.populated_ssn_cnt
          ,le.populated_fein_cnt
          ,le.populated_incorp_state_cnt
          ,le.populated_corp_number_cnt
          ,le.populated_corp_type_cnt
          ,le.populated_orig_address1_cnt
          ,le.populated_orig_address2_cnt
          ,le.populated_orig_city_cnt
          ,le.populated_orig_state_cnt
          ,le.populated_orig_zip5_cnt
          ,le.populated_orig_zip4_cnt
          ,le.populated_orig_country_cnt
          ,le.populated_orig_province_cnt
          ,le.populated_orig_postal_code_cnt
          ,le.populated_foreign_indc_cnt
          ,le.populated_party_type_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_process_date_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_name_score_cnt
          ,le.populated_company_name_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip5_cnt
          ,le.populated_zip4_cnt
          ,le.populated_county_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dpbc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_ace_fips_st_cnt
          ,le.populated_ace_fips_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_bdid_cnt
          ,le.populated_did_cnt
          ,le.populated_did_score_cnt
          ,le.populated_bdid_score_cnt
          ,le.populated_source_rec_id_cnt
          ,le.populated_dotid_cnt
          ,le.populated_dotscore_cnt
          ,le.populated_dotweight_cnt
          ,le.populated_empid_cnt
          ,le.populated_empscore_cnt
          ,le.populated_empweight_cnt
          ,le.populated_powid_cnt
          ,le.populated_powscore_cnt
          ,le.populated_powweight_cnt
          ,le.populated_proxid_cnt
          ,le.populated_proxscore_cnt
          ,le.populated_proxweight_cnt
          ,le.populated_seleid_cnt
          ,le.populated_selescore_cnt
          ,le.populated_seleweight_cnt
          ,le.populated_orgid_cnt
          ,le.populated_orgscore_cnt
          ,le.populated_orgweight_cnt
          ,le.populated_ultid_cnt
          ,le.populated_ultscore_cnt
          ,le.populated_ultweight_cnt
          ,le.populated_prep_addr_line1_cnt
          ,le.populated_prep_addr_last_line_cnt
          ,le.populated_rawaid_cnt
          ,le.populated_aceaid_cnt
          ,le.populated_persistent_record_id_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_tmsid_pcnt
          ,le.populated_rmsid_pcnt
          ,le.populated_orig_name_pcnt
          ,le.populated_orig_lname_pcnt
          ,le.populated_orig_fname_pcnt
          ,le.populated_orig_mname_pcnt
          ,le.populated_orig_suffix_pcnt
          ,le.populated_duns_number_pcnt
          ,le.populated_hq_duns_number_pcnt
          ,le.populated_ssn_pcnt
          ,le.populated_fein_pcnt
          ,le.populated_incorp_state_pcnt
          ,le.populated_corp_number_pcnt
          ,le.populated_corp_type_pcnt
          ,le.populated_orig_address1_pcnt
          ,le.populated_orig_address2_pcnt
          ,le.populated_orig_city_pcnt
          ,le.populated_orig_state_pcnt
          ,le.populated_orig_zip5_pcnt
          ,le.populated_orig_zip4_pcnt
          ,le.populated_orig_country_pcnt
          ,le.populated_orig_province_pcnt
          ,le.populated_orig_postal_code_pcnt
          ,le.populated_foreign_indc_pcnt
          ,le.populated_party_type_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_name_score_pcnt
          ,le.populated_company_name_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip5_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_county_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dpbc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_ace_fips_st_pcnt
          ,le.populated_ace_fips_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_did_pcnt
          ,le.populated_did_score_pcnt
          ,le.populated_bdid_score_pcnt
          ,le.populated_source_rec_id_pcnt
          ,le.populated_dotid_pcnt
          ,le.populated_dotscore_pcnt
          ,le.populated_dotweight_pcnt
          ,le.populated_empid_pcnt
          ,le.populated_empscore_pcnt
          ,le.populated_empweight_pcnt
          ,le.populated_powid_pcnt
          ,le.populated_powscore_pcnt
          ,le.populated_powweight_pcnt
          ,le.populated_proxid_pcnt
          ,le.populated_proxscore_pcnt
          ,le.populated_proxweight_pcnt
          ,le.populated_seleid_pcnt
          ,le.populated_selescore_pcnt
          ,le.populated_seleweight_pcnt
          ,le.populated_orgid_pcnt
          ,le.populated_orgscore_pcnt
          ,le.populated_orgweight_pcnt
          ,le.populated_ultid_pcnt
          ,le.populated_ultscore_pcnt
          ,le.populated_ultweight_pcnt
          ,le.populated_prep_addr_line1_pcnt
          ,le.populated_prep_addr_last_line_pcnt
          ,le.populated_rawaid_pcnt
          ,le.populated_aceaid_pcnt
          ,le.populated_persistent_record_id_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,96,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT38.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := DNB_Party_Delta(prevDS, PROJECT(h, DNB_Party_Layout_UCCV2));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),96,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(DNB_Party_Layout_UCCV2) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_UCCV2, DNB_Party_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT38.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT38.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;

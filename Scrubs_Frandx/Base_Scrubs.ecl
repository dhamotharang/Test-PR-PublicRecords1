IMPORT SALT38,STD;
IMPORT Scrubs_Frandx; // Import modules for FieldTypes attribute definitions
EXPORT Base_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 85;
  EXPORT NumRulesFromFieldType := 85;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 85;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_Layout_Frandx)
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
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 bdid_score_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 franchisee_id_Invalid;
    UNSIGNED1 brand_name_Invalid;
    UNSIGNED1 fruns_Invalid;
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 address1_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_code_Invalid;
    UNSIGNED1 zip_code4_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 phone_extension_Invalid;
    UNSIGNED1 secondary_phone_Invalid;
    UNSIGNED1 unit_flag_Invalid;
    UNSIGNED1 relationship_code_Invalid;
    UNSIGNED1 f_units_Invalid;
    UNSIGNED1 industry_Invalid;
    UNSIGNED1 sector_Invalid;
    UNSIGNED1 industry_type_Invalid;
    UNSIGNED1 sic_code_Invalid;
    UNSIGNED1 record_id_Invalid;
    UNSIGNED1 unit_flag_exp_Invalid;
    UNSIGNED1 relationship_code_exp_Invalid;
    UNSIGNED1 clean_phone_Invalid;
    UNSIGNED1 clean_secondary_phone_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
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
    UNSIGNED1 dbpc_Invalid;
    UNSIGNED1 chk_digit_Invalid;
    UNSIGNED1 rec_type_Invalid;
    UNSIGNED1 fips_state_Invalid;
    UNSIGNED1 fips_county_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 geo_blk_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
    UNSIGNED1 raw_aid_Invalid;
    UNSIGNED1 ace_aid_Invalid;
    UNSIGNED1 prep_addr_line1_Invalid;
    UNSIGNED1 prep_addr_line_last_Invalid;
    UNSIGNED1 source_rec_id_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Layout_Frandx)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Base_Layout_Frandx) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dotid_Invalid := Base_Fields.InValid_dotid((SALT38.StrType)le.dotid);
    SELF.dotscore_Invalid := Base_Fields.InValid_dotscore((SALT38.StrType)le.dotscore);
    SELF.dotweight_Invalid := Base_Fields.InValid_dotweight((SALT38.StrType)le.dotweight);
    SELF.empid_Invalid := Base_Fields.InValid_empid((SALT38.StrType)le.empid);
    SELF.empscore_Invalid := Base_Fields.InValid_empscore((SALT38.StrType)le.empscore);
    SELF.empweight_Invalid := Base_Fields.InValid_empweight((SALT38.StrType)le.empweight);
    SELF.powid_Invalid := Base_Fields.InValid_powid((SALT38.StrType)le.powid);
    SELF.powscore_Invalid := Base_Fields.InValid_powscore((SALT38.StrType)le.powscore);
    SELF.powweight_Invalid := Base_Fields.InValid_powweight((SALT38.StrType)le.powweight);
    SELF.proxid_Invalid := Base_Fields.InValid_proxid((SALT38.StrType)le.proxid);
    SELF.proxscore_Invalid := Base_Fields.InValid_proxscore((SALT38.StrType)le.proxscore);
    SELF.proxweight_Invalid := Base_Fields.InValid_proxweight((SALT38.StrType)le.proxweight);
    SELF.seleid_Invalid := Base_Fields.InValid_seleid((SALT38.StrType)le.seleid);
    SELF.selescore_Invalid := Base_Fields.InValid_selescore((SALT38.StrType)le.selescore);
    SELF.seleweight_Invalid := Base_Fields.InValid_seleweight((SALT38.StrType)le.seleweight);
    SELF.orgid_Invalid := Base_Fields.InValid_orgid((SALT38.StrType)le.orgid);
    SELF.orgscore_Invalid := Base_Fields.InValid_orgscore((SALT38.StrType)le.orgscore);
    SELF.orgweight_Invalid := Base_Fields.InValid_orgweight((SALT38.StrType)le.orgweight);
    SELF.ultid_Invalid := Base_Fields.InValid_ultid((SALT38.StrType)le.ultid);
    SELF.ultscore_Invalid := Base_Fields.InValid_ultscore((SALT38.StrType)le.ultscore);
    SELF.ultweight_Invalid := Base_Fields.InValid_ultweight((SALT38.StrType)le.ultweight);
    SELF.bdid_Invalid := Base_Fields.InValid_bdid((SALT38.StrType)le.bdid);
    SELF.bdid_score_Invalid := Base_Fields.InValid_bdid_score((SALT38.StrType)le.bdid_score);
    SELF.did_Invalid := Base_Fields.InValid_did((SALT38.StrType)le.did);
    SELF.did_score_Invalid := Base_Fields.InValid_did_score((SALT38.StrType)le.did_score);
    SELF.dt_first_seen_Invalid := Base_Fields.InValid_dt_first_seen((SALT38.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Base_Fields.InValid_dt_last_seen((SALT38.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Base_Fields.InValid_dt_vendor_first_reported((SALT38.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Base_Fields.InValid_dt_vendor_last_reported((SALT38.StrType)le.dt_vendor_last_reported);
    SELF.record_type_Invalid := Base_Fields.InValid_record_type((SALT38.StrType)le.record_type);
    SELF.franchisee_id_Invalid := Base_Fields.InValid_franchisee_id((SALT38.StrType)le.franchisee_id);
    SELF.brand_name_Invalid := Base_Fields.InValid_brand_name((SALT38.StrType)le.brand_name);
    SELF.fruns_Invalid := Base_Fields.InValid_fruns((SALT38.StrType)le.fruns);
    SELF.company_name_Invalid := Base_Fields.InValid_company_name((SALT38.StrType)le.company_name,(SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.lname);
    SELF.address1_Invalid := Base_Fields.InValid_address1((SALT38.StrType)le.address1);
    SELF.city_Invalid := Base_Fields.InValid_city((SALT38.StrType)le.city);
    SELF.state_Invalid := Base_Fields.InValid_state((SALT38.StrType)le.state);
    SELF.zip_code_Invalid := Base_Fields.InValid_zip_code((SALT38.StrType)le.zip_code);
    SELF.zip_code4_Invalid := Base_Fields.InValid_zip_code4((SALT38.StrType)le.zip_code4);
    SELF.phone_Invalid := Base_Fields.InValid_phone((SALT38.StrType)le.phone);
    SELF.phone_extension_Invalid := Base_Fields.InValid_phone_extension((SALT38.StrType)le.phone_extension);
    SELF.secondary_phone_Invalid := Base_Fields.InValid_secondary_phone((SALT38.StrType)le.secondary_phone);
    SELF.unit_flag_Invalid := Base_Fields.InValid_unit_flag((SALT38.StrType)le.unit_flag);
    SELF.relationship_code_Invalid := Base_Fields.InValid_relationship_code((SALT38.StrType)le.relationship_code);
    SELF.f_units_Invalid := Base_Fields.InValid_f_units((SALT38.StrType)le.f_units);
    SELF.industry_Invalid := Base_Fields.InValid_industry((SALT38.StrType)le.industry);
    SELF.sector_Invalid := Base_Fields.InValid_sector((SALT38.StrType)le.sector);
    SELF.industry_type_Invalid := Base_Fields.InValid_industry_type((SALT38.StrType)le.industry_type);
    SELF.sic_code_Invalid := Base_Fields.InValid_sic_code((SALT38.StrType)le.sic_code);
    SELF.record_id_Invalid := Base_Fields.InValid_record_id((SALT38.StrType)le.record_id);
    SELF.unit_flag_exp_Invalid := Base_Fields.InValid_unit_flag_exp((SALT38.StrType)le.unit_flag_exp);
    SELF.relationship_code_exp_Invalid := Base_Fields.InValid_relationship_code_exp((SALT38.StrType)le.relationship_code_exp);
    SELF.clean_phone_Invalid := Base_Fields.InValid_clean_phone((SALT38.StrType)le.clean_phone);
    SELF.clean_secondary_phone_Invalid := Base_Fields.InValid_clean_secondary_phone((SALT38.StrType)le.clean_secondary_phone);
    SELF.fname_Invalid := Base_Fields.InValid_fname((SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.lname,(SALT38.StrType)le.company_name);
    SELF.mname_Invalid := Base_Fields.InValid_mname((SALT38.StrType)le.mname,(SALT38.StrType)le.fname,(SALT38.StrType)le.lname,(SALT38.StrType)le.company_name);
    SELF.lname_Invalid := Base_Fields.InValid_lname((SALT38.StrType)le.lname,(SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.company_name);
    SELF.predir_Invalid := Base_Fields.InValid_predir((SALT38.StrType)le.predir);
    SELF.prim_name_Invalid := Base_Fields.InValid_prim_name((SALT38.StrType)le.prim_name);
    SELF.postdir_Invalid := Base_Fields.InValid_postdir((SALT38.StrType)le.postdir);
    SELF.p_city_name_Invalid := Base_Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Base_Fields.InValid_v_city_name((SALT38.StrType)le.v_city_name);
    SELF.st_Invalid := Base_Fields.InValid_st((SALT38.StrType)le.st);
    SELF.zip_Invalid := Base_Fields.InValid_zip((SALT38.StrType)le.zip);
    SELF.zip4_Invalid := Base_Fields.InValid_zip4((SALT38.StrType)le.zip4);
    SELF.cart_Invalid := Base_Fields.InValid_cart((SALT38.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := Base_Fields.InValid_cr_sort_sz((SALT38.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := Base_Fields.InValid_lot((SALT38.StrType)le.lot);
    SELF.lot_order_Invalid := Base_Fields.InValid_lot_order((SALT38.StrType)le.lot_order);
    SELF.dbpc_Invalid := Base_Fields.InValid_dbpc((SALT38.StrType)le.dbpc);
    SELF.chk_digit_Invalid := Base_Fields.InValid_chk_digit((SALT38.StrType)le.chk_digit);
    SELF.rec_type_Invalid := Base_Fields.InValid_rec_type((SALT38.StrType)le.rec_type);
    SELF.fips_state_Invalid := Base_Fields.InValid_fips_state((SALT38.StrType)le.fips_state);
    SELF.fips_county_Invalid := Base_Fields.InValid_fips_county((SALT38.StrType)le.fips_county);
    SELF.geo_lat_Invalid := Base_Fields.InValid_geo_lat((SALT38.StrType)le.geo_lat);
    SELF.geo_long_Invalid := Base_Fields.InValid_geo_long((SALT38.StrType)le.geo_long);
    SELF.msa_Invalid := Base_Fields.InValid_msa((SALT38.StrType)le.msa);
    SELF.geo_blk_Invalid := Base_Fields.InValid_geo_blk((SALT38.StrType)le.geo_blk);
    SELF.geo_match_Invalid := Base_Fields.InValid_geo_match((SALT38.StrType)le.geo_match);
    SELF.err_stat_Invalid := Base_Fields.InValid_err_stat((SALT38.StrType)le.err_stat);
    SELF.raw_aid_Invalid := Base_Fields.InValid_raw_aid((SALT38.StrType)le.raw_aid);
    SELF.ace_aid_Invalid := Base_Fields.InValid_ace_aid((SALT38.StrType)le.ace_aid);
    SELF.prep_addr_line1_Invalid := Base_Fields.InValid_prep_addr_line1((SALT38.StrType)le.prep_addr_line1);
    SELF.prep_addr_line_last_Invalid := Base_Fields.InValid_prep_addr_line_last((SALT38.StrType)le.prep_addr_line_last);
    SELF.source_rec_id_Invalid := Base_Fields.InValid_source_rec_id((SALT38.StrType)le.source_rec_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Layout_Frandx);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dotid_Invalid << 0 ) + ( le.dotscore_Invalid << 1 ) + ( le.dotweight_Invalid << 2 ) + ( le.empid_Invalid << 3 ) + ( le.empscore_Invalid << 4 ) + ( le.empweight_Invalid << 5 ) + ( le.powid_Invalid << 6 ) + ( le.powscore_Invalid << 7 ) + ( le.powweight_Invalid << 8 ) + ( le.proxid_Invalid << 9 ) + ( le.proxscore_Invalid << 10 ) + ( le.proxweight_Invalid << 11 ) + ( le.seleid_Invalid << 12 ) + ( le.selescore_Invalid << 13 ) + ( le.seleweight_Invalid << 14 ) + ( le.orgid_Invalid << 15 ) + ( le.orgscore_Invalid << 16 ) + ( le.orgweight_Invalid << 17 ) + ( le.ultid_Invalid << 18 ) + ( le.ultscore_Invalid << 19 ) + ( le.ultweight_Invalid << 20 ) + ( le.bdid_Invalid << 21 ) + ( le.bdid_score_Invalid << 22 ) + ( le.did_Invalid << 23 ) + ( le.did_score_Invalid << 24 ) + ( le.dt_first_seen_Invalid << 25 ) + ( le.dt_last_seen_Invalid << 26 ) + ( le.dt_vendor_first_reported_Invalid << 27 ) + ( le.dt_vendor_last_reported_Invalid << 28 ) + ( le.record_type_Invalid << 29 ) + ( le.franchisee_id_Invalid << 30 ) + ( le.brand_name_Invalid << 31 ) + ( le.fruns_Invalid << 32 ) + ( le.company_name_Invalid << 33 ) + ( le.address1_Invalid << 34 ) + ( le.city_Invalid << 35 ) + ( le.state_Invalid << 36 ) + ( le.zip_code_Invalid << 37 ) + ( le.zip_code4_Invalid << 38 ) + ( le.phone_Invalid << 39 ) + ( le.phone_extension_Invalid << 40 ) + ( le.secondary_phone_Invalid << 41 ) + ( le.unit_flag_Invalid << 42 ) + ( le.relationship_code_Invalid << 43 ) + ( le.f_units_Invalid << 44 ) + ( le.industry_Invalid << 45 ) + ( le.sector_Invalid << 46 ) + ( le.industry_type_Invalid << 47 ) + ( le.sic_code_Invalid << 48 ) + ( le.record_id_Invalid << 49 ) + ( le.unit_flag_exp_Invalid << 50 ) + ( le.relationship_code_exp_Invalid << 51 ) + ( le.clean_phone_Invalid << 52 ) + ( le.clean_secondary_phone_Invalid << 53 ) + ( le.fname_Invalid << 54 ) + ( le.mname_Invalid << 55 ) + ( le.lname_Invalid << 56 ) + ( le.predir_Invalid << 57 ) + ( le.prim_name_Invalid << 58 ) + ( le.postdir_Invalid << 59 ) + ( le.p_city_name_Invalid << 60 ) + ( le.v_city_name_Invalid << 61 ) + ( le.st_Invalid << 62 ) + ( le.zip_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.zip4_Invalid << 0 ) + ( le.cart_Invalid << 1 ) + ( le.cr_sort_sz_Invalid << 2 ) + ( le.lot_Invalid << 3 ) + ( le.lot_order_Invalid << 4 ) + ( le.dbpc_Invalid << 5 ) + ( le.chk_digit_Invalid << 6 ) + ( le.rec_type_Invalid << 7 ) + ( le.fips_state_Invalid << 8 ) + ( le.fips_county_Invalid << 9 ) + ( le.geo_lat_Invalid << 10 ) + ( le.geo_long_Invalid << 11 ) + ( le.msa_Invalid << 12 ) + ( le.geo_blk_Invalid << 13 ) + ( le.geo_match_Invalid << 14 ) + ( le.err_stat_Invalid << 15 ) + ( le.raw_aid_Invalid << 16 ) + ( le.ace_aid_Invalid << 17 ) + ( le.prep_addr_line1_Invalid << 18 ) + ( le.prep_addr_line_last_Invalid << 19 ) + ( le.source_rec_id_Invalid << 20 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Layout_Frandx);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dotid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dotscore_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dotweight_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.empid_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.empscore_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.empweight_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.powid_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.powscore_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.powweight_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.proxid_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.proxscore_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.proxweight_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.selescore_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.seleweight_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.orgscore_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.orgweight_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.ultid_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.ultscore_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.ultweight_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.bdid_score_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.did_score_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.franchisee_id_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.brand_name_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.fruns_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.address1_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.zip_code_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.zip_code4_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.phone_extension_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.secondary_phone_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.unit_flag_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.relationship_code_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.f_units_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.industry_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.sector_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.industry_type_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.sic_code_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.record_id_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.unit_flag_exp_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.relationship_code_exp_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.clean_phone_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.clean_secondary_phone_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.cart_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.lot_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.lot_order_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.dbpc_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.chk_digit_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.rec_type_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.fips_state_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.fips_county_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.msa_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.geo_blk_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.geo_match_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.err_stat_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.raw_aid_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.ace_aid_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.prep_addr_line1_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.prep_addr_line_last_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.source_rec_id_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dotid_ENUM_ErrorCount := COUNT(GROUP,h.dotid_Invalid=1);
    dotscore_ENUM_ErrorCount := COUNT(GROUP,h.dotscore_Invalid=1);
    dotweight_ENUM_ErrorCount := COUNT(GROUP,h.dotweight_Invalid=1);
    empid_ENUM_ErrorCount := COUNT(GROUP,h.empid_Invalid=1);
    empscore_ENUM_ErrorCount := COUNT(GROUP,h.empscore_Invalid=1);
    empweight_ENUM_ErrorCount := COUNT(GROUP,h.empweight_Invalid=1);
    powid_CUSTOM_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    powscore_CUSTOM_ErrorCount := COUNT(GROUP,h.powscore_Invalid=1);
    powweight_CUSTOM_ErrorCount := COUNT(GROUP,h.powweight_Invalid=1);
    proxid_CUSTOM_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    proxscore_CUSTOM_ErrorCount := COUNT(GROUP,h.proxscore_Invalid=1);
    proxweight_CUSTOM_ErrorCount := COUNT(GROUP,h.proxweight_Invalid=1);
    seleid_CUSTOM_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    selescore_CUSTOM_ErrorCount := COUNT(GROUP,h.selescore_Invalid=1);
    seleweight_CUSTOM_ErrorCount := COUNT(GROUP,h.seleweight_Invalid=1);
    orgid_CUSTOM_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    orgscore_CUSTOM_ErrorCount := COUNT(GROUP,h.orgscore_Invalid=1);
    orgweight_CUSTOM_ErrorCount := COUNT(GROUP,h.orgweight_Invalid=1);
    ultid_CUSTOM_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    ultscore_CUSTOM_ErrorCount := COUNT(GROUP,h.ultscore_Invalid=1);
    ultweight_CUSTOM_ErrorCount := COUNT(GROUP,h.ultweight_Invalid=1);
    bdid_CUSTOM_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    bdid_score_CUSTOM_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=1);
    did_ENUM_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_score_ENUM_ErrorCount := COUNT(GROUP,h.did_score_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    franchisee_id_CUSTOM_ErrorCount := COUNT(GROUP,h.franchisee_id_Invalid=1);
    brand_name_CUSTOM_ErrorCount := COUNT(GROUP,h.brand_name_Invalid=1);
    fruns_CUSTOM_ErrorCount := COUNT(GROUP,h.fruns_Invalid=1);
    company_name_CUSTOM_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    address1_CUSTOM_ErrorCount := COUNT(GROUP,h.address1_Invalid=1);
    city_CUSTOM_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zip_code_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_code_Invalid=1);
    zip_code4_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_code4_Invalid=1);
    phone_CUSTOM_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_extension_ALLOW_ErrorCount := COUNT(GROUP,h.phone_extension_Invalid=1);
    secondary_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.secondary_phone_Invalid=1);
    unit_flag_CUSTOM_ErrorCount := COUNT(GROUP,h.unit_flag_Invalid=1);
    relationship_code_CUSTOM_ErrorCount := COUNT(GROUP,h.relationship_code_Invalid=1);
    f_units_CUSTOM_ErrorCount := COUNT(GROUP,h.f_units_Invalid=1);
    industry_CUSTOM_ErrorCount := COUNT(GROUP,h.industry_Invalid=1);
    sector_CUSTOM_ErrorCount := COUNT(GROUP,h.sector_Invalid=1);
    industry_type_CUSTOM_ErrorCount := COUNT(GROUP,h.industry_type_Invalid=1);
    sic_code_CUSTOM_ErrorCount := COUNT(GROUP,h.sic_code_Invalid=1);
    record_id_CUSTOM_ErrorCount := COUNT(GROUP,h.record_id_Invalid=1);
    unit_flag_exp_CUSTOM_ErrorCount := COUNT(GROUP,h.unit_flag_exp_Invalid=1);
    relationship_code_exp_CUSTOM_ErrorCount := COUNT(GROUP,h.relationship_code_exp_Invalid=1);
    clean_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=1);
    clean_secondary_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_secondary_phone_Invalid=1);
    fname_CUSTOM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    mname_CUSTOM_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    lname_CUSTOM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    predir_ENUM_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    postdir_ENUM_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    p_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    st_CUSTOM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    cart_CUSTOM_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cr_sort_sz_ENUM_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    lot_CUSTOM_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_order_ENUM_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    dbpc_CUSTOM_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=1);
    chk_digit_CUSTOM_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    rec_type_CUSTOM_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    fips_state_CUSTOM_ErrorCount := COUNT(GROUP,h.fips_state_Invalid=1);
    fips_county_CUSTOM_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=1);
    geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    msa_CUSTOM_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    geo_blk_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_match_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    err_stat_CUSTOM_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    raw_aid_CUSTOM_ErrorCount := COUNT(GROUP,h.raw_aid_Invalid=1);
    ace_aid_CUSTOM_ErrorCount := COUNT(GROUP,h.ace_aid_Invalid=1);
    prep_addr_line1_CUSTOM_ErrorCount := COUNT(GROUP,h.prep_addr_line1_Invalid=1);
    prep_addr_line_last_CUSTOM_ErrorCount := COUNT(GROUP,h.prep_addr_line_last_Invalid=1);
    source_rec_id_CUSTOM_ErrorCount := COUNT(GROUP,h.source_rec_id_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dotid_Invalid > 0 OR h.dotscore_Invalid > 0 OR h.dotweight_Invalid > 0 OR h.empid_Invalid > 0 OR h.empscore_Invalid > 0 OR h.empweight_Invalid > 0 OR h.powid_Invalid > 0 OR h.powscore_Invalid > 0 OR h.powweight_Invalid > 0 OR h.proxid_Invalid > 0 OR h.proxscore_Invalid > 0 OR h.proxweight_Invalid > 0 OR h.seleid_Invalid > 0 OR h.selescore_Invalid > 0 OR h.seleweight_Invalid > 0 OR h.orgid_Invalid > 0 OR h.orgscore_Invalid > 0 OR h.orgweight_Invalid > 0 OR h.ultid_Invalid > 0 OR h.ultscore_Invalid > 0 OR h.ultweight_Invalid > 0 OR h.bdid_Invalid > 0 OR h.bdid_score_Invalid > 0 OR h.did_Invalid > 0 OR h.did_score_Invalid > 0 OR h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.record_type_Invalid > 0 OR h.franchisee_id_Invalid > 0 OR h.brand_name_Invalid > 0 OR h.fruns_Invalid > 0 OR h.company_name_Invalid > 0 OR h.address1_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zip_code_Invalid > 0 OR h.zip_code4_Invalid > 0 OR h.phone_Invalid > 0 OR h.phone_extension_Invalid > 0 OR h.secondary_phone_Invalid > 0 OR h.unit_flag_Invalid > 0 OR h.relationship_code_Invalid > 0 OR h.f_units_Invalid > 0 OR h.industry_Invalid > 0 OR h.sector_Invalid > 0 OR h.industry_type_Invalid > 0 OR h.sic_code_Invalid > 0 OR h.record_id_Invalid > 0 OR h.unit_flag_exp_Invalid > 0 OR h.relationship_code_exp_Invalid > 0 OR h.clean_phone_Invalid > 0 OR h.clean_secondary_phone_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.postdir_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.cart_Invalid > 0 OR h.cr_sort_sz_Invalid > 0 OR h.lot_Invalid > 0 OR h.lot_order_Invalid > 0 OR h.dbpc_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.rec_type_Invalid > 0 OR h.fips_state_Invalid > 0 OR h.fips_county_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.msa_Invalid > 0 OR h.geo_blk_Invalid > 0 OR h.geo_match_Invalid > 0 OR h.err_stat_Invalid > 0 OR h.raw_aid_Invalid > 0 OR h.ace_aid_Invalid > 0 OR h.prep_addr_line1_Invalid > 0 OR h.prep_addr_line_last_Invalid > 0 OR h.source_rec_id_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dotid_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.empid_ENUM_ErrorCount > 0, 1, 0) + IF(le.empscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.empweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.powid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.powscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.powweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seleid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.selescore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seleweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_ENUM_ErrorCount > 0, 1, 0) + IF(le.did_score_ENUM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.franchisee_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.brand_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fruns_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_extension_ALLOW_ErrorCount > 0, 1, 0) + IF(le.secondary_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.unit_flag_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.relationship_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.f_units_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.industry_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sector_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.industry_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.unit_flag_exp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.relationship_code_exp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_secondary_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.predir_ENUM_ErrorCount > 0, 1, 0) + IF(le.prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.postdir_ENUM_ErrorCount > 0, 1, 0) + IF(le.p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cart_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ENUM_ErrorCount > 0, 1, 0) + IF(le.lot_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.dbpc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rec_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_blk_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_match_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.err_stat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.raw_aid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ace_aid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line_last_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dotid_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.empid_ENUM_ErrorCount > 0, 1, 0) + IF(le.empscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.empweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.powid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.powscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.powweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seleid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.selescore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seleweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_ENUM_ErrorCount > 0, 1, 0) + IF(le.did_score_ENUM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.franchisee_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.brand_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fruns_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_extension_ALLOW_ErrorCount > 0, 1, 0) + IF(le.secondary_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.unit_flag_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.relationship_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.f_units_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.industry_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sector_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.industry_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.unit_flag_exp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.relationship_code_exp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_secondary_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.predir_ENUM_ErrorCount > 0, 1, 0) + IF(le.prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.postdir_ENUM_ErrorCount > 0, 1, 0) + IF(le.p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cart_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ENUM_ErrorCount > 0, 1, 0) + IF(le.lot_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.dbpc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rec_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_blk_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_match_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.err_stat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.raw_aid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ace_aid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line_last_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dotid_Invalid,le.dotscore_Invalid,le.dotweight_Invalid,le.empid_Invalid,le.empscore_Invalid,le.empweight_Invalid,le.powid_Invalid,le.powscore_Invalid,le.powweight_Invalid,le.proxid_Invalid,le.proxscore_Invalid,le.proxweight_Invalid,le.seleid_Invalid,le.selescore_Invalid,le.seleweight_Invalid,le.orgid_Invalid,le.orgscore_Invalid,le.orgweight_Invalid,le.ultid_Invalid,le.ultscore_Invalid,le.ultweight_Invalid,le.bdid_Invalid,le.bdid_score_Invalid,le.did_Invalid,le.did_score_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.record_type_Invalid,le.franchisee_id_Invalid,le.brand_name_Invalid,le.fruns_Invalid,le.company_name_Invalid,le.address1_Invalid,le.city_Invalid,le.state_Invalid,le.zip_code_Invalid,le.zip_code4_Invalid,le.phone_Invalid,le.phone_extension_Invalid,le.secondary_phone_Invalid,le.unit_flag_Invalid,le.relationship_code_Invalid,le.f_units_Invalid,le.industry_Invalid,le.sector_Invalid,le.industry_type_Invalid,le.sic_code_Invalid,le.record_id_Invalid,le.unit_flag_exp_Invalid,le.relationship_code_exp_Invalid,le.clean_phone_Invalid,le.clean_secondary_phone_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.postdir_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dbpc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.fips_state_Invalid,le.fips_county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.raw_aid_Invalid,le.ace_aid_Invalid,le.prep_addr_line1_Invalid,le.prep_addr_line_last_Invalid,le.source_rec_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Fields.InvalidMessage_dotid(le.dotid_Invalid),Base_Fields.InvalidMessage_dotscore(le.dotscore_Invalid),Base_Fields.InvalidMessage_dotweight(le.dotweight_Invalid),Base_Fields.InvalidMessage_empid(le.empid_Invalid),Base_Fields.InvalidMessage_empscore(le.empscore_Invalid),Base_Fields.InvalidMessage_empweight(le.empweight_Invalid),Base_Fields.InvalidMessage_powid(le.powid_Invalid),Base_Fields.InvalidMessage_powscore(le.powscore_Invalid),Base_Fields.InvalidMessage_powweight(le.powweight_Invalid),Base_Fields.InvalidMessage_proxid(le.proxid_Invalid),Base_Fields.InvalidMessage_proxscore(le.proxscore_Invalid),Base_Fields.InvalidMessage_proxweight(le.proxweight_Invalid),Base_Fields.InvalidMessage_seleid(le.seleid_Invalid),Base_Fields.InvalidMessage_selescore(le.selescore_Invalid),Base_Fields.InvalidMessage_seleweight(le.seleweight_Invalid),Base_Fields.InvalidMessage_orgid(le.orgid_Invalid),Base_Fields.InvalidMessage_orgscore(le.orgscore_Invalid),Base_Fields.InvalidMessage_orgweight(le.orgweight_Invalid),Base_Fields.InvalidMessage_ultid(le.ultid_Invalid),Base_Fields.InvalidMessage_ultscore(le.ultscore_Invalid),Base_Fields.InvalidMessage_ultweight(le.ultweight_Invalid),Base_Fields.InvalidMessage_bdid(le.bdid_Invalid),Base_Fields.InvalidMessage_bdid_score(le.bdid_score_Invalid),Base_Fields.InvalidMessage_did(le.did_Invalid),Base_Fields.InvalidMessage_did_score(le.did_score_Invalid),Base_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Base_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Base_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Base_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Base_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_Fields.InvalidMessage_franchisee_id(le.franchisee_id_Invalid),Base_Fields.InvalidMessage_brand_name(le.brand_name_Invalid),Base_Fields.InvalidMessage_fruns(le.fruns_Invalid),Base_Fields.InvalidMessage_company_name(le.company_name_Invalid),Base_Fields.InvalidMessage_address1(le.address1_Invalid),Base_Fields.InvalidMessage_city(le.city_Invalid),Base_Fields.InvalidMessage_state(le.state_Invalid),Base_Fields.InvalidMessage_zip_code(le.zip_code_Invalid),Base_Fields.InvalidMessage_zip_code4(le.zip_code4_Invalid),Base_Fields.InvalidMessage_phone(le.phone_Invalid),Base_Fields.InvalidMessage_phone_extension(le.phone_extension_Invalid),Base_Fields.InvalidMessage_secondary_phone(le.secondary_phone_Invalid),Base_Fields.InvalidMessage_unit_flag(le.unit_flag_Invalid),Base_Fields.InvalidMessage_relationship_code(le.relationship_code_Invalid),Base_Fields.InvalidMessage_f_units(le.f_units_Invalid),Base_Fields.InvalidMessage_industry(le.industry_Invalid),Base_Fields.InvalidMessage_sector(le.sector_Invalid),Base_Fields.InvalidMessage_industry_type(le.industry_type_Invalid),Base_Fields.InvalidMessage_sic_code(le.sic_code_Invalid),Base_Fields.InvalidMessage_record_id(le.record_id_Invalid),Base_Fields.InvalidMessage_unit_flag_exp(le.unit_flag_exp_Invalid),Base_Fields.InvalidMessage_relationship_code_exp(le.relationship_code_exp_Invalid),Base_Fields.InvalidMessage_clean_phone(le.clean_phone_Invalid),Base_Fields.InvalidMessage_clean_secondary_phone(le.clean_secondary_phone_Invalid),Base_Fields.InvalidMessage_fname(le.fname_Invalid),Base_Fields.InvalidMessage_mname(le.mname_Invalid),Base_Fields.InvalidMessage_lname(le.lname_Invalid),Base_Fields.InvalidMessage_predir(le.predir_Invalid),Base_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Base_Fields.InvalidMessage_postdir(le.postdir_Invalid),Base_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Base_Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Base_Fields.InvalidMessage_st(le.st_Invalid),Base_Fields.InvalidMessage_zip(le.zip_Invalid),Base_Fields.InvalidMessage_zip4(le.zip4_Invalid),Base_Fields.InvalidMessage_cart(le.cart_Invalid),Base_Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Base_Fields.InvalidMessage_lot(le.lot_Invalid),Base_Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Base_Fields.InvalidMessage_dbpc(le.dbpc_Invalid),Base_Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Base_Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Base_Fields.InvalidMessage_fips_state(le.fips_state_Invalid),Base_Fields.InvalidMessage_fips_county(le.fips_county_Invalid),Base_Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Base_Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Base_Fields.InvalidMessage_msa(le.msa_Invalid),Base_Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Base_Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Base_Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Base_Fields.InvalidMessage_raw_aid(le.raw_aid_Invalid),Base_Fields.InvalidMessage_ace_aid(le.ace_aid_Invalid),Base_Fields.InvalidMessage_prep_addr_line1(le.prep_addr_line1_Invalid),Base_Fields.InvalidMessage_prep_addr_line_last(le.prep_addr_line_last_Invalid),Base_Fields.InvalidMessage_source_rec_id(le.source_rec_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dotid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dotscore_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dotweight_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.empid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.empscore_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.empweight_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.powid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.powscore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.powweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.proxscore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.proxweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.selescore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.seleweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orgscore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orgweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ultscore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ultweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bdid_score_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.franchisee_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.brand_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fruns_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_code4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_extension_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.secondary_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.unit_flag_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.relationship_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.f_units_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.industry_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sector_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.industry_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.unit_flag_exp_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.relationship_code_exp_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_secondary_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dbpc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fips_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fips_county_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.raw_aid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ace_aid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prep_addr_line1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prep_addr_line_last_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.source_rec_id_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','bdid','bdid_score','did','did_score','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','franchisee_id','brand_name','fruns','company_name','address1','city','state','zip_code','zip_code4','phone','phone_extension','secondary_phone','unit_flag','relationship_code','f_units','industry','sector','industry_type','sic_code','record_id','unit_flag_exp','relationship_code_exp','clean_phone','clean_secondary_phone','fname','mname','lname','predir','prim_name','postdir','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_addr_line1','prep_addr_line_last','source_rec_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_nonempty_number','invalid_percentage','invalid_nonempty_number','invalid_nonempty_number','invalid_percentage','invalid_nonempty_number','invalid_nonempty_number','invalid_percentage','invalid_nonempty_number','invalid_nonempty_number','invalid_percentage','invalid_nonempty_number','invalid_nonempty_number','invalid_percentage','invalid_nonempty_number','invalid_nonempty_number','invalid_percentage','invalid_zero_integer','invalid_zero_integer','invalid_pastdate08','invalid_pastdate08','invalid_pastdate8','invalid_pastdate8','invalid_record_type','invalid_franchisee_id','invalid_mandatory','invalid_fruns','invalid_company_name','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip_code','invalid_zip_code4','invalid_phone','invalid_numeric','invalid_secondary_phone','invalid_unit_flag','invalid_relationship_code','invalid_nonempty_number','invalid_mandatory','invalid_mandatory','invalid_industry_type','invalid_sic_code','invalid_nonempty_number','invalid_unit_flag_exp','invalid_relationship_code_exp','invalid_phone','invalid_secondary_phone','invalid_fname','invalid_mname','invalid_lname','invalid_direction','invalid_mandatory','invalid_direction','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip_code','invalid_zip_code4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dbpc','invalid_chk_digit','invalid_rec_type','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','invalid_raw_aid','invalid_ace_aid','invalid_mandatory','invalid_mandatory','invalid_source_rec_id','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.dotid,(SALT38.StrType)le.dotscore,(SALT38.StrType)le.dotweight,(SALT38.StrType)le.empid,(SALT38.StrType)le.empscore,(SALT38.StrType)le.empweight,(SALT38.StrType)le.powid,(SALT38.StrType)le.powscore,(SALT38.StrType)le.powweight,(SALT38.StrType)le.proxid,(SALT38.StrType)le.proxscore,(SALT38.StrType)le.proxweight,(SALT38.StrType)le.seleid,(SALT38.StrType)le.selescore,(SALT38.StrType)le.seleweight,(SALT38.StrType)le.orgid,(SALT38.StrType)le.orgscore,(SALT38.StrType)le.orgweight,(SALT38.StrType)le.ultid,(SALT38.StrType)le.ultscore,(SALT38.StrType)le.ultweight,(SALT38.StrType)le.bdid,(SALT38.StrType)le.bdid_score,(SALT38.StrType)le.did,(SALT38.StrType)le.did_score,(SALT38.StrType)le.dt_first_seen,(SALT38.StrType)le.dt_last_seen,(SALT38.StrType)le.dt_vendor_first_reported,(SALT38.StrType)le.dt_vendor_last_reported,(SALT38.StrType)le.record_type,(SALT38.StrType)le.franchisee_id,(SALT38.StrType)le.brand_name,(SALT38.StrType)le.fruns,(SALT38.StrType)le.company_name,(SALT38.StrType)le.address1,(SALT38.StrType)le.city,(SALT38.StrType)le.state,(SALT38.StrType)le.zip_code,(SALT38.StrType)le.zip_code4,(SALT38.StrType)le.phone,(SALT38.StrType)le.phone_extension,(SALT38.StrType)le.secondary_phone,(SALT38.StrType)le.unit_flag,(SALT38.StrType)le.relationship_code,(SALT38.StrType)le.f_units,(SALT38.StrType)le.industry,(SALT38.StrType)le.sector,(SALT38.StrType)le.industry_type,(SALT38.StrType)le.sic_code,(SALT38.StrType)le.record_id,(SALT38.StrType)le.unit_flag_exp,(SALT38.StrType)le.relationship_code_exp,(SALT38.StrType)le.clean_phone,(SALT38.StrType)le.clean_secondary_phone,(SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.lname,(SALT38.StrType)le.predir,(SALT38.StrType)le.prim_name,(SALT38.StrType)le.postdir,(SALT38.StrType)le.p_city_name,(SALT38.StrType)le.v_city_name,(SALT38.StrType)le.st,(SALT38.StrType)le.zip,(SALT38.StrType)le.zip4,(SALT38.StrType)le.cart,(SALT38.StrType)le.cr_sort_sz,(SALT38.StrType)le.lot,(SALT38.StrType)le.lot_order,(SALT38.StrType)le.dbpc,(SALT38.StrType)le.chk_digit,(SALT38.StrType)le.rec_type,(SALT38.StrType)le.fips_state,(SALT38.StrType)le.fips_county,(SALT38.StrType)le.geo_lat,(SALT38.StrType)le.geo_long,(SALT38.StrType)le.msa,(SALT38.StrType)le.geo_blk,(SALT38.StrType)le.geo_match,(SALT38.StrType)le.err_stat,(SALT38.StrType)le.raw_aid,(SALT38.StrType)le.ace_aid,(SALT38.StrType)le.prep_addr_line1,(SALT38.StrType)le.prep_addr_line_last,(SALT38.StrType)le.source_rec_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,85,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_Layout_Frandx) prevDS = DATASET([], Base_Layout_Frandx), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dotid:invalid_zero_integer:ENUM'
          ,'dotscore:invalid_zero_integer:ENUM'
          ,'dotweight:invalid_zero_integer:ENUM'
          ,'empid:invalid_zero_integer:ENUM'
          ,'empscore:invalid_zero_integer:ENUM'
          ,'empweight:invalid_zero_integer:ENUM'
          ,'powid:invalid_nonempty_number:CUSTOM'
          ,'powscore:invalid_percentage:CUSTOM'
          ,'powweight:invalid_nonempty_number:CUSTOM'
          ,'proxid:invalid_nonempty_number:CUSTOM'
          ,'proxscore:invalid_percentage:CUSTOM'
          ,'proxweight:invalid_nonempty_number:CUSTOM'
          ,'seleid:invalid_nonempty_number:CUSTOM'
          ,'selescore:invalid_percentage:CUSTOM'
          ,'seleweight:invalid_nonempty_number:CUSTOM'
          ,'orgid:invalid_nonempty_number:CUSTOM'
          ,'orgscore:invalid_percentage:CUSTOM'
          ,'orgweight:invalid_nonempty_number:CUSTOM'
          ,'ultid:invalid_nonempty_number:CUSTOM'
          ,'ultscore:invalid_percentage:CUSTOM'
          ,'ultweight:invalid_nonempty_number:CUSTOM'
          ,'bdid:invalid_nonempty_number:CUSTOM'
          ,'bdid_score:invalid_percentage:CUSTOM'
          ,'did:invalid_zero_integer:ENUM'
          ,'did_score:invalid_zero_integer:ENUM'
          ,'dt_first_seen:invalid_pastdate08:CUSTOM'
          ,'dt_last_seen:invalid_pastdate08:CUSTOM'
          ,'dt_vendor_first_reported:invalid_pastdate8:CUSTOM'
          ,'dt_vendor_last_reported:invalid_pastdate8:CUSTOM'
          ,'record_type:invalid_record_type:ENUM'
          ,'franchisee_id:invalid_franchisee_id:CUSTOM'
          ,'brand_name:invalid_mandatory:CUSTOM'
          ,'fruns:invalid_fruns:CUSTOM'
          ,'company_name:invalid_company_name:CUSTOM'
          ,'address1:invalid_mandatory:CUSTOM'
          ,'city:invalid_mandatory:CUSTOM'
          ,'state:invalid_state:CUSTOM'
          ,'zip_code:invalid_zip_code:CUSTOM'
          ,'zip_code4:invalid_zip_code4:CUSTOM'
          ,'phone:invalid_phone:CUSTOM'
          ,'phone_extension:invalid_numeric:ALLOW'
          ,'secondary_phone:invalid_secondary_phone:CUSTOM'
          ,'unit_flag:invalid_unit_flag:CUSTOM'
          ,'relationship_code:invalid_relationship_code:CUSTOM'
          ,'f_units:invalid_nonempty_number:CUSTOM'
          ,'industry:invalid_mandatory:CUSTOM'
          ,'sector:invalid_mandatory:CUSTOM'
          ,'industry_type:invalid_industry_type:CUSTOM'
          ,'sic_code:invalid_sic_code:CUSTOM'
          ,'record_id:invalid_nonempty_number:CUSTOM'
          ,'unit_flag_exp:invalid_unit_flag_exp:CUSTOM'
          ,'relationship_code_exp:invalid_relationship_code_exp:CUSTOM'
          ,'clean_phone:invalid_phone:CUSTOM'
          ,'clean_secondary_phone:invalid_secondary_phone:CUSTOM'
          ,'fname:invalid_fname:CUSTOM'
          ,'mname:invalid_mname:CUSTOM'
          ,'lname:invalid_lname:CUSTOM'
          ,'predir:invalid_direction:ENUM'
          ,'prim_name:invalid_mandatory:CUSTOM'
          ,'postdir:invalid_direction:ENUM'
          ,'p_city_name:invalid_mandatory:CUSTOM'
          ,'v_city_name:invalid_mandatory:CUSTOM'
          ,'st:invalid_state:CUSTOM'
          ,'zip:invalid_zip_code:CUSTOM'
          ,'zip4:invalid_zip_code4:CUSTOM'
          ,'cart:invalid_cart:CUSTOM'
          ,'cr_sort_sz:invalid_cr_sort_sz:ENUM'
          ,'lot:invalid_lot:CUSTOM'
          ,'lot_order:invalid_lot_order:ENUM'
          ,'dbpc:invalid_dbpc:CUSTOM'
          ,'chk_digit:invalid_chk_digit:CUSTOM'
          ,'rec_type:invalid_rec_type:CUSTOM'
          ,'fips_state:invalid_fips_state:CUSTOM'
          ,'fips_county:invalid_fips_county:CUSTOM'
          ,'geo_lat:invalid_geo:ALLOW'
          ,'geo_long:invalid_geo:ALLOW'
          ,'msa:invalid_msa:CUSTOM'
          ,'geo_blk:invalid_geo_blk:CUSTOM'
          ,'geo_match:invalid_geo_match:CUSTOM'
          ,'err_stat:invalid_err_stat:CUSTOM'
          ,'raw_aid:invalid_raw_aid:CUSTOM'
          ,'ace_aid:invalid_ace_aid:CUSTOM'
          ,'prep_addr_line1:invalid_mandatory:CUSTOM'
          ,'prep_addr_line_last:invalid_mandatory:CUSTOM'
          ,'source_rec_id:invalid_source_rec_id:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Fields.InvalidMessage_dotid(1)
          ,Base_Fields.InvalidMessage_dotscore(1)
          ,Base_Fields.InvalidMessage_dotweight(1)
          ,Base_Fields.InvalidMessage_empid(1)
          ,Base_Fields.InvalidMessage_empscore(1)
          ,Base_Fields.InvalidMessage_empweight(1)
          ,Base_Fields.InvalidMessage_powid(1)
          ,Base_Fields.InvalidMessage_powscore(1)
          ,Base_Fields.InvalidMessage_powweight(1)
          ,Base_Fields.InvalidMessage_proxid(1)
          ,Base_Fields.InvalidMessage_proxscore(1)
          ,Base_Fields.InvalidMessage_proxweight(1)
          ,Base_Fields.InvalidMessage_seleid(1)
          ,Base_Fields.InvalidMessage_selescore(1)
          ,Base_Fields.InvalidMessage_seleweight(1)
          ,Base_Fields.InvalidMessage_orgid(1)
          ,Base_Fields.InvalidMessage_orgscore(1)
          ,Base_Fields.InvalidMessage_orgweight(1)
          ,Base_Fields.InvalidMessage_ultid(1)
          ,Base_Fields.InvalidMessage_ultscore(1)
          ,Base_Fields.InvalidMessage_ultweight(1)
          ,Base_Fields.InvalidMessage_bdid(1)
          ,Base_Fields.InvalidMessage_bdid_score(1)
          ,Base_Fields.InvalidMessage_did(1)
          ,Base_Fields.InvalidMessage_did_score(1)
          ,Base_Fields.InvalidMessage_dt_first_seen(1)
          ,Base_Fields.InvalidMessage_dt_last_seen(1)
          ,Base_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Base_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Base_Fields.InvalidMessage_record_type(1)
          ,Base_Fields.InvalidMessage_franchisee_id(1)
          ,Base_Fields.InvalidMessage_brand_name(1)
          ,Base_Fields.InvalidMessage_fruns(1)
          ,Base_Fields.InvalidMessage_company_name(1)
          ,Base_Fields.InvalidMessage_address1(1)
          ,Base_Fields.InvalidMessage_city(1)
          ,Base_Fields.InvalidMessage_state(1)
          ,Base_Fields.InvalidMessage_zip_code(1)
          ,Base_Fields.InvalidMessage_zip_code4(1)
          ,Base_Fields.InvalidMessage_phone(1)
          ,Base_Fields.InvalidMessage_phone_extension(1)
          ,Base_Fields.InvalidMessage_secondary_phone(1)
          ,Base_Fields.InvalidMessage_unit_flag(1)
          ,Base_Fields.InvalidMessage_relationship_code(1)
          ,Base_Fields.InvalidMessage_f_units(1)
          ,Base_Fields.InvalidMessage_industry(1)
          ,Base_Fields.InvalidMessage_sector(1)
          ,Base_Fields.InvalidMessage_industry_type(1)
          ,Base_Fields.InvalidMessage_sic_code(1)
          ,Base_Fields.InvalidMessage_record_id(1)
          ,Base_Fields.InvalidMessage_unit_flag_exp(1)
          ,Base_Fields.InvalidMessage_relationship_code_exp(1)
          ,Base_Fields.InvalidMessage_clean_phone(1)
          ,Base_Fields.InvalidMessage_clean_secondary_phone(1)
          ,Base_Fields.InvalidMessage_fname(1)
          ,Base_Fields.InvalidMessage_mname(1)
          ,Base_Fields.InvalidMessage_lname(1)
          ,Base_Fields.InvalidMessage_predir(1)
          ,Base_Fields.InvalidMessage_prim_name(1)
          ,Base_Fields.InvalidMessage_postdir(1)
          ,Base_Fields.InvalidMessage_p_city_name(1)
          ,Base_Fields.InvalidMessage_v_city_name(1)
          ,Base_Fields.InvalidMessage_st(1)
          ,Base_Fields.InvalidMessage_zip(1)
          ,Base_Fields.InvalidMessage_zip4(1)
          ,Base_Fields.InvalidMessage_cart(1)
          ,Base_Fields.InvalidMessage_cr_sort_sz(1)
          ,Base_Fields.InvalidMessage_lot(1)
          ,Base_Fields.InvalidMessage_lot_order(1)
          ,Base_Fields.InvalidMessage_dbpc(1)
          ,Base_Fields.InvalidMessage_chk_digit(1)
          ,Base_Fields.InvalidMessage_rec_type(1)
          ,Base_Fields.InvalidMessage_fips_state(1)
          ,Base_Fields.InvalidMessage_fips_county(1)
          ,Base_Fields.InvalidMessage_geo_lat(1)
          ,Base_Fields.InvalidMessage_geo_long(1)
          ,Base_Fields.InvalidMessage_msa(1)
          ,Base_Fields.InvalidMessage_geo_blk(1)
          ,Base_Fields.InvalidMessage_geo_match(1)
          ,Base_Fields.InvalidMessage_err_stat(1)
          ,Base_Fields.InvalidMessage_raw_aid(1)
          ,Base_Fields.InvalidMessage_ace_aid(1)
          ,Base_Fields.InvalidMessage_prep_addr_line1(1)
          ,Base_Fields.InvalidMessage_prep_addr_line_last(1)
          ,Base_Fields.InvalidMessage_source_rec_id(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dotid_ENUM_ErrorCount
          ,le.dotscore_ENUM_ErrorCount
          ,le.dotweight_ENUM_ErrorCount
          ,le.empid_ENUM_ErrorCount
          ,le.empscore_ENUM_ErrorCount
          ,le.empweight_ENUM_ErrorCount
          ,le.powid_CUSTOM_ErrorCount
          ,le.powscore_CUSTOM_ErrorCount
          ,le.powweight_CUSTOM_ErrorCount
          ,le.proxid_CUSTOM_ErrorCount
          ,le.proxscore_CUSTOM_ErrorCount
          ,le.proxweight_CUSTOM_ErrorCount
          ,le.seleid_CUSTOM_ErrorCount
          ,le.selescore_CUSTOM_ErrorCount
          ,le.seleweight_CUSTOM_ErrorCount
          ,le.orgid_CUSTOM_ErrorCount
          ,le.orgscore_CUSTOM_ErrorCount
          ,le.orgweight_CUSTOM_ErrorCount
          ,le.ultid_CUSTOM_ErrorCount
          ,le.ultscore_CUSTOM_ErrorCount
          ,le.ultweight_CUSTOM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.bdid_score_CUSTOM_ErrorCount
          ,le.did_ENUM_ErrorCount
          ,le.did_score_ENUM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.franchisee_id_CUSTOM_ErrorCount
          ,le.brand_name_CUSTOM_ErrorCount
          ,le.fruns_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.address1_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_code_CUSTOM_ErrorCount
          ,le.zip_code4_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.phone_extension_ALLOW_ErrorCount
          ,le.secondary_phone_CUSTOM_ErrorCount
          ,le.unit_flag_CUSTOM_ErrorCount
          ,le.relationship_code_CUSTOM_ErrorCount
          ,le.f_units_CUSTOM_ErrorCount
          ,le.industry_CUSTOM_ErrorCount
          ,le.sector_CUSTOM_ErrorCount
          ,le.industry_type_CUSTOM_ErrorCount
          ,le.sic_code_CUSTOM_ErrorCount
          ,le.record_id_CUSTOM_ErrorCount
          ,le.unit_flag_exp_CUSTOM_ErrorCount
          ,le.relationship_code_exp_CUSTOM_ErrorCount
          ,le.clean_phone_CUSTOM_ErrorCount
          ,le.clean_secondary_phone_CUSTOM_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.mname_CUSTOM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.predir_ENUM_ErrorCount
          ,le.prim_name_CUSTOM_ErrorCount
          ,le.postdir_ENUM_ErrorCount
          ,le.p_city_name_CUSTOM_ErrorCount
          ,le.v_city_name_CUSTOM_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.cart_CUSTOM_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_CUSTOM_ErrorCount
          ,le.lot_order_ENUM_ErrorCount
          ,le.dbpc_CUSTOM_ErrorCount
          ,le.chk_digit_CUSTOM_ErrorCount
          ,le.rec_type_CUSTOM_ErrorCount
          ,le.fips_state_CUSTOM_ErrorCount
          ,le.fips_county_CUSTOM_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.msa_CUSTOM_ErrorCount
          ,le.geo_blk_CUSTOM_ErrorCount
          ,le.geo_match_CUSTOM_ErrorCount
          ,le.err_stat_CUSTOM_ErrorCount
          ,le.raw_aid_CUSTOM_ErrorCount
          ,le.ace_aid_CUSTOM_ErrorCount
          ,le.prep_addr_line1_CUSTOM_ErrorCount
          ,le.prep_addr_line_last_CUSTOM_ErrorCount
          ,le.source_rec_id_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dotid_ENUM_ErrorCount
          ,le.dotscore_ENUM_ErrorCount
          ,le.dotweight_ENUM_ErrorCount
          ,le.empid_ENUM_ErrorCount
          ,le.empscore_ENUM_ErrorCount
          ,le.empweight_ENUM_ErrorCount
          ,le.powid_CUSTOM_ErrorCount
          ,le.powscore_CUSTOM_ErrorCount
          ,le.powweight_CUSTOM_ErrorCount
          ,le.proxid_CUSTOM_ErrorCount
          ,le.proxscore_CUSTOM_ErrorCount
          ,le.proxweight_CUSTOM_ErrorCount
          ,le.seleid_CUSTOM_ErrorCount
          ,le.selescore_CUSTOM_ErrorCount
          ,le.seleweight_CUSTOM_ErrorCount
          ,le.orgid_CUSTOM_ErrorCount
          ,le.orgscore_CUSTOM_ErrorCount
          ,le.orgweight_CUSTOM_ErrorCount
          ,le.ultid_CUSTOM_ErrorCount
          ,le.ultscore_CUSTOM_ErrorCount
          ,le.ultweight_CUSTOM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.bdid_score_CUSTOM_ErrorCount
          ,le.did_ENUM_ErrorCount
          ,le.did_score_ENUM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.franchisee_id_CUSTOM_ErrorCount
          ,le.brand_name_CUSTOM_ErrorCount
          ,le.fruns_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.address1_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_code_CUSTOM_ErrorCount
          ,le.zip_code4_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.phone_extension_ALLOW_ErrorCount
          ,le.secondary_phone_CUSTOM_ErrorCount
          ,le.unit_flag_CUSTOM_ErrorCount
          ,le.relationship_code_CUSTOM_ErrorCount
          ,le.f_units_CUSTOM_ErrorCount
          ,le.industry_CUSTOM_ErrorCount
          ,le.sector_CUSTOM_ErrorCount
          ,le.industry_type_CUSTOM_ErrorCount
          ,le.sic_code_CUSTOM_ErrorCount
          ,le.record_id_CUSTOM_ErrorCount
          ,le.unit_flag_exp_CUSTOM_ErrorCount
          ,le.relationship_code_exp_CUSTOM_ErrorCount
          ,le.clean_phone_CUSTOM_ErrorCount
          ,le.clean_secondary_phone_CUSTOM_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.mname_CUSTOM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.predir_ENUM_ErrorCount
          ,le.prim_name_CUSTOM_ErrorCount
          ,le.postdir_ENUM_ErrorCount
          ,le.p_city_name_CUSTOM_ErrorCount
          ,le.v_city_name_CUSTOM_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.cart_CUSTOM_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_CUSTOM_ErrorCount
          ,le.lot_order_ENUM_ErrorCount
          ,le.dbpc_CUSTOM_ErrorCount
          ,le.chk_digit_CUSTOM_ErrorCount
          ,le.rec_type_CUSTOM_ErrorCount
          ,le.fips_state_CUSTOM_ErrorCount
          ,le.fips_county_CUSTOM_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.msa_CUSTOM_ErrorCount
          ,le.geo_blk_CUSTOM_ErrorCount
          ,le.geo_match_CUSTOM_ErrorCount
          ,le.err_stat_CUSTOM_ErrorCount
          ,le.raw_aid_CUSTOM_ErrorCount
          ,le.ace_aid_CUSTOM_ErrorCount
          ,le.prep_addr_line1_CUSTOM_ErrorCount
          ,le.prep_addr_line_last_CUSTOM_ErrorCount
          ,le.source_rec_id_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := Base_hygiene(PROJECT(h, Base_Layout_Frandx));
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
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid_score:' + getFieldTypeText(h.bdid_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_score:' + getFieldTypeText(h.did_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'franchisee_id:' + getFieldTypeText(h.franchisee_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_name:' + getFieldTypeText(h.brand_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fruns:' + getFieldTypeText(h.fruns) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exec_full_name:' + getFieldTypeText(h.exec_full_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address1:' + getFieldTypeText(h.address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address2:' + getFieldTypeText(h.address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_code:' + getFieldTypeText(h.zip_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_code4:' + getFieldTypeText(h.zip_code4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_extension:' + getFieldTypeText(h.phone_extension) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'secondary_phone:' + getFieldTypeText(h.secondary_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_flag:' + getFieldTypeText(h.unit_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relationship_code:' + getFieldTypeText(h.relationship_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'f_units:' + getFieldTypeText(h.f_units) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'website_url:' + getFieldTypeText(h.website_url) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email:' + getFieldTypeText(h.email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'industry:' + getFieldTypeText(h.industry) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sector:' + getFieldTypeText(h.sector) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'industry_type:' + getFieldTypeText(h.industry_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic_code:' + getFieldTypeText(h.sic_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'frn_start_date:' + getFieldTypeText(h.frn_start_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_id:' + getFieldTypeText(h.record_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_flag_exp:' + getFieldTypeText(h.unit_flag_exp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relationship_code_exp:' + getFieldTypeText(h.relationship_code_exp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_phone:' + getFieldTypeText(h.clean_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_secondary_phone:' + getFieldTypeText(h.clean_secondary_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'dbpc:' + getFieldTypeText(h.dbpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_state:' + getFieldTypeText(h.fips_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_aid:' + getFieldTypeText(h.raw_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_aid:' + getFieldTypeText(h.ace_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_line1:' + getFieldTypeText(h.prep_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_line_last:' + getFieldTypeText(h.prep_addr_line_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_rec_id:' + getFieldTypeText(h.source_rec_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
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
          ,le.populated_bdid_cnt
          ,le.populated_bdid_score_cnt
          ,le.populated_did_cnt
          ,le.populated_did_score_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_record_type_cnt
          ,le.populated_franchisee_id_cnt
          ,le.populated_brand_name_cnt
          ,le.populated_fruns_cnt
          ,le.populated_company_name_cnt
          ,le.populated_exec_full_name_cnt
          ,le.populated_address1_cnt
          ,le.populated_address2_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_code_cnt
          ,le.populated_zip_code4_cnt
          ,le.populated_phone_cnt
          ,le.populated_phone_extension_cnt
          ,le.populated_secondary_phone_cnt
          ,le.populated_unit_flag_cnt
          ,le.populated_relationship_code_cnt
          ,le.populated_f_units_cnt
          ,le.populated_website_url_cnt
          ,le.populated_email_cnt
          ,le.populated_industry_cnt
          ,le.populated_sector_cnt
          ,le.populated_industry_type_cnt
          ,le.populated_sic_code_cnt
          ,le.populated_frn_start_date_cnt
          ,le.populated_record_id_cnt
          ,le.populated_unit_flag_exp_cnt
          ,le.populated_relationship_code_exp_cnt
          ,le.populated_clean_phone_cnt
          ,le.populated_clean_secondary_phone_cnt
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
          ,le.populated_dbpc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_fips_state_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_raw_aid_cnt
          ,le.populated_ace_aid_cnt
          ,le.populated_prep_addr_line1_cnt
          ,le.populated_prep_addr_line_last_cnt
          ,le.populated_source_rec_id_cnt,0);
      SELF.rulepcnt := CHOOSE(c
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
          ,le.populated_bdid_pcnt
          ,le.populated_bdid_score_pcnt
          ,le.populated_did_pcnt
          ,le.populated_did_score_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_franchisee_id_pcnt
          ,le.populated_brand_name_pcnt
          ,le.populated_fruns_pcnt
          ,le.populated_company_name_pcnt
          ,le.populated_exec_full_name_pcnt
          ,le.populated_address1_pcnt
          ,le.populated_address2_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_code_pcnt
          ,le.populated_zip_code4_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_phone_extension_pcnt
          ,le.populated_secondary_phone_pcnt
          ,le.populated_unit_flag_pcnt
          ,le.populated_relationship_code_pcnt
          ,le.populated_f_units_pcnt
          ,le.populated_website_url_pcnt
          ,le.populated_email_pcnt
          ,le.populated_industry_pcnt
          ,le.populated_sector_pcnt
          ,le.populated_industry_type_pcnt
          ,le.populated_sic_code_pcnt
          ,le.populated_frn_start_date_pcnt
          ,le.populated_record_id_pcnt
          ,le.populated_unit_flag_exp_pcnt
          ,le.populated_relationship_code_exp_pcnt
          ,le.populated_clean_phone_pcnt
          ,le.populated_clean_secondary_phone_pcnt
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
          ,le.populated_dbpc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_fips_state_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_raw_aid_pcnt
          ,le.populated_ace_aid_pcnt
          ,le.populated_prep_addr_line1_pcnt
          ,le.populated_prep_addr_line_last_pcnt
          ,le.populated_source_rec_id_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,97,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Base_Delta(prevDS, PROJECT(h, Base_Layout_Frandx));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),97,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_Layout_Frandx) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Frandx, Base_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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

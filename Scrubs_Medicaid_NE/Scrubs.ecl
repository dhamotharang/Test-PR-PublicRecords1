IMPORT ut,SALT31;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_INFile_)
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 bdid_score_Invalid;
    UNSIGNED1 best_dob_Invalid;
    UNSIGNED1 best_ssn_Invalid;
    UNSIGNED1 data_state_Invalid;
    UNSIGNED1 provider_name_Invalid;
    UNSIGNED1 license_number_Invalid;
    UNSIGNED1 npi_Invalid;
    UNSIGNED1 providertype_Invalid;
    UNSIGNED1 name_Invalid;
    UNSIGNED1 speciality_Invalid;
    UNSIGNED1 status_Invalid;
    UNSIGNED1 address1_Invalid;
    UNSIGNED1 address2_Invalid;
    UNSIGNED1 address3_Invalid;
    UNSIGNED1 officecity_Invalid;
    UNSIGNED1 officestate_Invalid;
    UNSIGNED1 officezipcode_Invalid;
    UNSIGNED1 entity_type_code_Invalid;
    UNSIGNED1 companyname_Invalid;
    UNSIGNED1 src_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 source_rid_Invalid;
    UNSIGNED1 lnpid_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 name_type_Invalid;
    UNSIGNED1 nid_Invalid;
    UNSIGNED1 clean_clinic_name_Invalid;
    UNSIGNED1 prepped_addr1_Invalid;
    UNSIGNED1 prepped_addr2_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 addr_suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_desig_Invalid;
    UNSIGNED1 sec_range_Invalid;
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
    UNSIGNED1 fips_st_Invalid;
    UNSIGNED1 fips_county_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 geo_blk_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
    UNSIGNED1 rawaid_Invalid;
    UNSIGNED1 aceaid_Invalid;
    UNSIGNED1 clean_phone_Invalid;
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
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_INFile_)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
    UNSIGNED8 ScrubsBits5;
  END;
EXPORT FromNone(DATASET(Layout_INFile_) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.did_Invalid := Fields.InValid_did((SALT31.StrType)le.did);
    SELF.did_score_Invalid := Fields.InValid_did_score((SALT31.StrType)le.did_score);
    SELF.bdid_Invalid := Fields.InValid_bdid((SALT31.StrType)le.bdid);
    SELF.bdid_score_Invalid := Fields.InValid_bdid_score((SALT31.StrType)le.bdid_score);
    SELF.best_dob_Invalid := Fields.InValid_best_dob((SALT31.StrType)le.best_dob);
    SELF.best_ssn_Invalid := Fields.InValid_best_ssn((SALT31.StrType)le.best_ssn);
    SELF.data_state_Invalid := Fields.InValid_data_state((SALT31.StrType)le.data_state);
    SELF.provider_name_Invalid := Fields.InValid_provider_name((SALT31.StrType)le.provider_name);
    SELF.license_number_Invalid := Fields.InValid_license_number((SALT31.StrType)le.license_number);
    SELF.npi_Invalid := Fields.InValid_npi((SALT31.StrType)le.npi);
    SELF.providertype_Invalid := Fields.InValid_providertype((SALT31.StrType)le.providertype);
    SELF.name_Invalid := Fields.InValid_name((SALT31.StrType)le.name);
    SELF.speciality_Invalid := Fields.InValid_speciality((SALT31.StrType)le.speciality);
    SELF.status_Invalid := Fields.InValid_status((SALT31.StrType)le.status);
    SELF.address1_Invalid := Fields.InValid_address1((SALT31.StrType)le.address1);
    SELF.address2_Invalid := Fields.InValid_address2((SALT31.StrType)le.address2);
    SELF.address3_Invalid := Fields.InValid_address3((SALT31.StrType)le.address3);
    SELF.officecity_Invalid := Fields.InValid_officecity((SALT31.StrType)le.officecity);
    SELF.officestate_Invalid := Fields.InValid_officestate((SALT31.StrType)le.officestate);
    SELF.officezipcode_Invalid := Fields.InValid_officezipcode((SALT31.StrType)le.officezipcode);
    SELF.entity_type_code_Invalid := Fields.InValid_entity_type_code((SALT31.StrType)le.entity_type_code);
    SELF.companyname_Invalid := Fields.InValid_companyname((SALT31.StrType)le.companyname);
    SELF.src_Invalid := Fields.InValid_src((SALT31.StrType)le.src);
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT31.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT31.StrType)le.dt_vendor_last_reported);
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT31.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT31.StrType)le.dt_last_seen);
    SELF.record_type_Invalid := Fields.InValid_record_type((SALT31.StrType)le.record_type);
    SELF.source_rid_Invalid := Fields.InValid_source_rid((SALT31.StrType)le.source_rid);
    SELF.lnpid_Invalid := Fields.InValid_lnpid((SALT31.StrType)le.lnpid);
    SELF.title_Invalid := Fields.InValid_title((SALT31.StrType)le.title);
    SELF.fname_Invalid := Fields.InValid_fname((SALT31.StrType)le.fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT31.StrType)le.mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT31.StrType)le.lname);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT31.StrType)le.name_suffix);
    SELF.name_type_Invalid := Fields.InValid_name_type((SALT31.StrType)le.name_type);
    SELF.nid_Invalid := Fields.InValid_nid((SALT31.StrType)le.nid);
    SELF.clean_clinic_name_Invalid := Fields.InValid_clean_clinic_name((SALT31.StrType)le.clean_clinic_name);
    SELF.prepped_addr1_Invalid := Fields.InValid_prepped_addr1((SALT31.StrType)le.prepped_addr1);
    SELF.prepped_addr2_Invalid := Fields.InValid_prepped_addr2((SALT31.StrType)le.prepped_addr2);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT31.StrType)le.prim_range);
    SELF.predir_Invalid := Fields.InValid_predir((SALT31.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT31.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT31.StrType)le.addr_suffix);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT31.StrType)le.postdir);
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT31.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT31.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT31.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT31.StrType)le.v_city_name);
    SELF.st_Invalid := Fields.InValid_st((SALT31.StrType)le.st);
    SELF.zip_Invalid := Fields.InValid_zip((SALT31.StrType)le.zip);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT31.StrType)le.zip4);
    SELF.cart_Invalid := Fields.InValid_cart((SALT31.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := Fields.InValid_cr_sort_sz((SALT31.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := Fields.InValid_lot((SALT31.StrType)le.lot);
    SELF.lot_order_Invalid := Fields.InValid_lot_order((SALT31.StrType)le.lot_order);
    SELF.dbpc_Invalid := Fields.InValid_dbpc((SALT31.StrType)le.dbpc);
    SELF.chk_digit_Invalid := Fields.InValid_chk_digit((SALT31.StrType)le.chk_digit);
    SELF.rec_type_Invalid := Fields.InValid_rec_type((SALT31.StrType)le.rec_type);
    SELF.fips_st_Invalid := Fields.InValid_fips_st((SALT31.StrType)le.fips_st);
    SELF.fips_county_Invalid := Fields.InValid_fips_county((SALT31.StrType)le.fips_county);
    SELF.geo_lat_Invalid := Fields.InValid_geo_lat((SALT31.StrType)le.geo_lat);
    SELF.geo_long_Invalid := Fields.InValid_geo_long((SALT31.StrType)le.geo_long);
    SELF.msa_Invalid := Fields.InValid_msa((SALT31.StrType)le.msa);
    SELF.geo_blk_Invalid := Fields.InValid_geo_blk((SALT31.StrType)le.geo_blk);
    SELF.geo_match_Invalid := Fields.InValid_geo_match((SALT31.StrType)le.geo_match);
    SELF.err_stat_Invalid := Fields.InValid_err_stat((SALT31.StrType)le.err_stat);
    SELF.rawaid_Invalid := Fields.InValid_rawaid((SALT31.StrType)le.rawaid);
    SELF.aceaid_Invalid := Fields.InValid_aceaid((SALT31.StrType)le.aceaid);
    SELF.clean_phone_Invalid := Fields.InValid_clean_phone((SALT31.StrType)le.clean_phone);
    SELF.dotid_Invalid := Fields.InValid_dotid((SALT31.StrType)le.dotid);
    SELF.dotscore_Invalid := Fields.InValid_dotscore((SALT31.StrType)le.dotscore);
    SELF.dotweight_Invalid := Fields.InValid_dotweight((SALT31.StrType)le.dotweight);
    SELF.empid_Invalid := Fields.InValid_empid((SALT31.StrType)le.empid);
    SELF.empscore_Invalid := Fields.InValid_empscore((SALT31.StrType)le.empscore);
    SELF.empweight_Invalid := Fields.InValid_empweight((SALT31.StrType)le.empweight);
    SELF.powid_Invalid := Fields.InValid_powid((SALT31.StrType)le.powid);
    SELF.powscore_Invalid := Fields.InValid_powscore((SALT31.StrType)le.powscore);
    SELF.powweight_Invalid := Fields.InValid_powweight((SALT31.StrType)le.powweight);
    SELF.proxid_Invalid := Fields.InValid_proxid((SALT31.StrType)le.proxid);
    SELF.proxscore_Invalid := Fields.InValid_proxscore((SALT31.StrType)le.proxscore);
    SELF.proxweight_Invalid := Fields.InValid_proxweight((SALT31.StrType)le.proxweight);
    SELF.seleid_Invalid := Fields.InValid_seleid((SALT31.StrType)le.seleid);
    SELF.selescore_Invalid := Fields.InValid_selescore((SALT31.StrType)le.selescore);
    SELF.seleweight_Invalid := Fields.InValid_seleweight((SALT31.StrType)le.seleweight);
    SELF.orgid_Invalid := Fields.InValid_orgid((SALT31.StrType)le.orgid);
    SELF.orgscore_Invalid := Fields.InValid_orgscore((SALT31.StrType)le.orgscore);
    SELF.orgweight_Invalid := Fields.InValid_orgweight((SALT31.StrType)le.orgweight);
    SELF.ultid_Invalid := Fields.InValid_ultid((SALT31.StrType)le.ultid);
    SELF.ultscore_Invalid := Fields.InValid_ultscore((SALT31.StrType)le.ultscore);
    SELF.ultweight_Invalid := Fields.InValid_ultweight((SALT31.StrType)le.ultweight);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.did_Invalid << 0 ) + ( le.did_score_Invalid << 3 ) + ( le.bdid_Invalid << 6 ) + ( le.bdid_score_Invalid << 9 ) + ( le.best_dob_Invalid << 12 ) + ( le.best_ssn_Invalid << 15 ) + ( le.data_state_Invalid << 18 ) + ( le.provider_name_Invalid << 21 ) + ( le.license_number_Invalid << 23 ) + ( le.npi_Invalid << 25 ) + ( le.providertype_Invalid << 28 ) + ( le.name_Invalid << 30 ) + ( le.speciality_Invalid << 32 ) + ( le.status_Invalid << 34 ) + ( le.address1_Invalid << 37 ) + ( le.address2_Invalid << 39 ) + ( le.address3_Invalid << 41 ) + ( le.officecity_Invalid << 44 ) + ( le.officestate_Invalid << 46 ) + ( le.officezipcode_Invalid << 49 ) + ( le.entity_type_code_Invalid << 52 ) + ( le.companyname_Invalid << 55 ) + ( le.src_Invalid << 57 ) + ( le.dt_vendor_first_reported_Invalid << 60 );
    SELF.ScrubsBits2 := ( le.dt_vendor_last_reported_Invalid << 0 ) + ( le.dt_first_seen_Invalid << 3 ) + ( le.dt_last_seen_Invalid << 6 ) + ( le.record_type_Invalid << 9 ) + ( le.source_rid_Invalid << 12 ) + ( le.lnpid_Invalid << 15 ) + ( le.title_Invalid << 18 ) + ( le.fname_Invalid << 21 ) + ( le.mname_Invalid << 23 ) + ( le.lname_Invalid << 26 ) + ( le.name_suffix_Invalid << 28 ) + ( le.name_type_Invalid << 31 ) + ( le.nid_Invalid << 34 ) + ( le.clean_clinic_name_Invalid << 37 ) + ( le.prepped_addr1_Invalid << 40 ) + ( le.prepped_addr2_Invalid << 42 ) + ( le.prim_range_Invalid << 44 ) + ( le.predir_Invalid << 47 ) + ( le.prim_name_Invalid << 50 ) + ( le.addr_suffix_Invalid << 53 ) + ( le.postdir_Invalid << 56 ) + ( le.unit_desig_Invalid << 59 );
    SELF.ScrubsBits3 := ( le.sec_range_Invalid << 0 ) + ( le.p_city_name_Invalid << 3 ) + ( le.v_city_name_Invalid << 5 ) + ( le.st_Invalid << 7 ) + ( le.zip_Invalid << 10 ) + ( le.zip4_Invalid << 13 ) + ( le.cart_Invalid << 16 ) + ( le.cr_sort_sz_Invalid << 19 ) + ( le.lot_Invalid << 22 ) + ( le.lot_order_Invalid << 25 ) + ( le.dbpc_Invalid << 28 ) + ( le.chk_digit_Invalid << 31 ) + ( le.rec_type_Invalid << 34 ) + ( le.fips_st_Invalid << 37 ) + ( le.fips_county_Invalid << 40 ) + ( le.geo_lat_Invalid << 43 ) + ( le.geo_long_Invalid << 46 ) + ( le.msa_Invalid << 49 ) + ( le.geo_blk_Invalid << 52 ) + ( le.geo_match_Invalid << 55 ) + ( le.err_stat_Invalid << 58 ) + ( le.rawaid_Invalid << 61 );
    SELF.ScrubsBits4 := ( le.aceaid_Invalid << 0 ) + ( le.clean_phone_Invalid << 3 ) + ( le.dotid_Invalid << 6 ) + ( le.dotscore_Invalid << 9 ) + ( le.dotweight_Invalid << 12 ) + ( le.empid_Invalid << 15 ) + ( le.empscore_Invalid << 18 ) + ( le.empweight_Invalid << 21 ) + ( le.powid_Invalid << 24 ) + ( le.powscore_Invalid << 27 ) + ( le.powweight_Invalid << 30 ) + ( le.proxid_Invalid << 33 ) + ( le.proxscore_Invalid << 36 ) + ( le.proxweight_Invalid << 39 ) + ( le.seleid_Invalid << 42 ) + ( le.selescore_Invalid << 45 ) + ( le.seleweight_Invalid << 48 ) + ( le.orgid_Invalid << 51 ) + ( le.orgscore_Invalid << 54 ) + ( le.orgweight_Invalid << 57 ) + ( le.ultid_Invalid << 60 );
    SELF.ScrubsBits5 := ( le.ultscore_Invalid << 0 ) + ( le.ultweight_Invalid << 3 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_INFile_);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.did_Invalid := (le.ScrubsBits1 >> 0) & 7;
    SELF.did_score_Invalid := (le.ScrubsBits1 >> 3) & 7;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 6) & 7;
    SELF.bdid_score_Invalid := (le.ScrubsBits1 >> 9) & 7;
    SELF.best_dob_Invalid := (le.ScrubsBits1 >> 12) & 7;
    SELF.best_ssn_Invalid := (le.ScrubsBits1 >> 15) & 7;
    SELF.data_state_Invalid := (le.ScrubsBits1 >> 18) & 7;
    SELF.provider_name_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.license_number_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.npi_Invalid := (le.ScrubsBits1 >> 25) & 7;
    SELF.providertype_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.name_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.speciality_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.status_Invalid := (le.ScrubsBits1 >> 34) & 7;
    SELF.address1_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.address2_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.address3_Invalid := (le.ScrubsBits1 >> 41) & 7;
    SELF.officecity_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.officestate_Invalid := (le.ScrubsBits1 >> 46) & 7;
    SELF.officezipcode_Invalid := (le.ScrubsBits1 >> 49) & 7;
    SELF.entity_type_code_Invalid := (le.ScrubsBits1 >> 52) & 7;
    SELF.companyname_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.src_Invalid := (le.ScrubsBits1 >> 57) & 7;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 60) & 7;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits2 >> 0) & 7;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits2 >> 3) & 7;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits2 >> 6) & 7;
    SELF.record_type_Invalid := (le.ScrubsBits2 >> 9) & 7;
    SELF.source_rid_Invalid := (le.ScrubsBits2 >> 12) & 7;
    SELF.lnpid_Invalid := (le.ScrubsBits2 >> 15) & 7;
    SELF.title_Invalid := (le.ScrubsBits2 >> 18) & 7;
    SELF.fname_Invalid := (le.ScrubsBits2 >> 21) & 3;
    SELF.mname_Invalid := (le.ScrubsBits2 >> 23) & 7;
    SELF.lname_Invalid := (le.ScrubsBits2 >> 26) & 3;
    SELF.name_suffix_Invalid := (le.ScrubsBits2 >> 28) & 7;
    SELF.name_type_Invalid := (le.ScrubsBits2 >> 31) & 7;
    SELF.nid_Invalid := (le.ScrubsBits2 >> 34) & 7;
    SELF.clean_clinic_name_Invalid := (le.ScrubsBits2 >> 37) & 7;
    SELF.prepped_addr1_Invalid := (le.ScrubsBits2 >> 40) & 3;
    SELF.prepped_addr2_Invalid := (le.ScrubsBits2 >> 42) & 3;
    SELF.prim_range_Invalid := (le.ScrubsBits2 >> 44) & 7;
    SELF.predir_Invalid := (le.ScrubsBits2 >> 47) & 7;
    SELF.prim_name_Invalid := (le.ScrubsBits2 >> 50) & 7;
    SELF.addr_suffix_Invalid := (le.ScrubsBits2 >> 53) & 7;
    SELF.postdir_Invalid := (le.ScrubsBits2 >> 56) & 7;
    SELF.unit_desig_Invalid := (le.ScrubsBits2 >> 59) & 7;
    SELF.sec_range_Invalid := (le.ScrubsBits3 >> 0) & 7;
    SELF.p_city_name_Invalid := (le.ScrubsBits3 >> 3) & 3;
    SELF.v_city_name_Invalid := (le.ScrubsBits3 >> 5) & 3;
    SELF.st_Invalid := (le.ScrubsBits3 >> 7) & 7;
    SELF.zip_Invalid := (le.ScrubsBits3 >> 10) & 7;
    SELF.zip4_Invalid := (le.ScrubsBits3 >> 13) & 7;
    SELF.cart_Invalid := (le.ScrubsBits3 >> 16) & 7;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits3 >> 19) & 7;
    SELF.lot_Invalid := (le.ScrubsBits3 >> 22) & 7;
    SELF.lot_order_Invalid := (le.ScrubsBits3 >> 25) & 7;
    SELF.dbpc_Invalid := (le.ScrubsBits3 >> 28) & 7;
    SELF.chk_digit_Invalid := (le.ScrubsBits3 >> 31) & 7;
    SELF.rec_type_Invalid := (le.ScrubsBits3 >> 34) & 7;
    SELF.fips_st_Invalid := (le.ScrubsBits3 >> 37) & 7;
    SELF.fips_county_Invalid := (le.ScrubsBits3 >> 40) & 7;
    SELF.geo_lat_Invalid := (le.ScrubsBits3 >> 43) & 7;
    SELF.geo_long_Invalid := (le.ScrubsBits3 >> 46) & 7;
    SELF.msa_Invalid := (le.ScrubsBits3 >> 49) & 7;
    SELF.geo_blk_Invalid := (le.ScrubsBits3 >> 52) & 7;
    SELF.geo_match_Invalid := (le.ScrubsBits3 >> 55) & 7;
    SELF.err_stat_Invalid := (le.ScrubsBits3 >> 58) & 7;
    SELF.rawaid_Invalid := (le.ScrubsBits3 >> 61) & 7;
    SELF.aceaid_Invalid := (le.ScrubsBits4 >> 0) & 7;
    SELF.clean_phone_Invalid := (le.ScrubsBits4 >> 3) & 7;
    SELF.dotid_Invalid := (le.ScrubsBits4 >> 6) & 7;
    SELF.dotscore_Invalid := (le.ScrubsBits4 >> 9) & 7;
    SELF.dotweight_Invalid := (le.ScrubsBits4 >> 12) & 7;
    SELF.empid_Invalid := (le.ScrubsBits4 >> 15) & 7;
    SELF.empscore_Invalid := (le.ScrubsBits4 >> 18) & 7;
    SELF.empweight_Invalid := (le.ScrubsBits4 >> 21) & 7;
    SELF.powid_Invalid := (le.ScrubsBits4 >> 24) & 7;
    SELF.powscore_Invalid := (le.ScrubsBits4 >> 27) & 7;
    SELF.powweight_Invalid := (le.ScrubsBits4 >> 30) & 7;
    SELF.proxid_Invalid := (le.ScrubsBits4 >> 33) & 7;
    SELF.proxscore_Invalid := (le.ScrubsBits4 >> 36) & 7;
    SELF.proxweight_Invalid := (le.ScrubsBits4 >> 39) & 7;
    SELF.seleid_Invalid := (le.ScrubsBits4 >> 42) & 7;
    SELF.selescore_Invalid := (le.ScrubsBits4 >> 45) & 7;
    SELF.seleweight_Invalid := (le.ScrubsBits4 >> 48) & 7;
    SELF.orgid_Invalid := (le.ScrubsBits4 >> 51) & 7;
    SELF.orgscore_Invalid := (le.ScrubsBits4 >> 54) & 7;
    SELF.orgweight_Invalid := (le.ScrubsBits4 >> 57) & 7;
    SELF.ultid_Invalid := (le.ScrubsBits4 >> 60) & 7;
    SELF.ultscore_Invalid := (le.ScrubsBits5 >> 0) & 7;
    SELF.ultweight_Invalid := (le.ScrubsBits5 >> 3) & 7;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    did_LEFTTRIM_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=2);
    did_LENGTH_ErrorCount := COUNT(GROUP,h.did_Invalid=3);
    did_WORDS_ErrorCount := COUNT(GROUP,h.did_Invalid=4);
    did_Total_ErrorCount := COUNT(GROUP,h.did_Invalid>0);
    did_score_LEFTTRIM_ErrorCount := COUNT(GROUP,h.did_score_Invalid=1);
    did_score_ALLOW_ErrorCount := COUNT(GROUP,h.did_score_Invalid=2);
    did_score_LENGTH_ErrorCount := COUNT(GROUP,h.did_score_Invalid=3);
    did_score_WORDS_ErrorCount := COUNT(GROUP,h.did_score_Invalid=4);
    did_score_Total_ErrorCount := COUNT(GROUP,h.did_score_Invalid>0);
    bdid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    bdid_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_Invalid=2);
    bdid_LENGTH_ErrorCount := COUNT(GROUP,h.bdid_Invalid=3);
    bdid_WORDS_ErrorCount := COUNT(GROUP,h.bdid_Invalid=4);
    bdid_Total_ErrorCount := COUNT(GROUP,h.bdid_Invalid>0);
    bdid_score_LEFTTRIM_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=1);
    bdid_score_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=2);
    bdid_score_LENGTH_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=3);
    bdid_score_WORDS_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=4);
    bdid_score_Total_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid>0);
    best_dob_LEFTTRIM_ErrorCount := COUNT(GROUP,h.best_dob_Invalid=1);
    best_dob_ALLOW_ErrorCount := COUNT(GROUP,h.best_dob_Invalid=2);
    best_dob_LENGTH_ErrorCount := COUNT(GROUP,h.best_dob_Invalid=3);
    best_dob_WORDS_ErrorCount := COUNT(GROUP,h.best_dob_Invalid=4);
    best_dob_Total_ErrorCount := COUNT(GROUP,h.best_dob_Invalid>0);
    best_ssn_LEFTTRIM_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=1);
    best_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=2);
    best_ssn_LENGTH_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=3);
    best_ssn_WORDS_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=4);
    best_ssn_Total_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid>0);
    data_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.data_state_Invalid=1);
    data_state_ALLOW_ErrorCount := COUNT(GROUP,h.data_state_Invalid=2);
    data_state_LENGTH_ErrorCount := COUNT(GROUP,h.data_state_Invalid=3);
    data_state_WORDS_ErrorCount := COUNT(GROUP,h.data_state_Invalid=4);
    data_state_Total_ErrorCount := COUNT(GROUP,h.data_state_Invalid>0);
    provider_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.provider_name_Invalid=1);
    provider_name_ALLOW_ErrorCount := COUNT(GROUP,h.provider_name_Invalid=2);
    provider_name_Total_ErrorCount := COUNT(GROUP,h.provider_name_Invalid>0);
    license_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.license_number_Invalid=1);
    license_number_ALLOW_ErrorCount := COUNT(GROUP,h.license_number_Invalid=2);
    license_number_WORDS_ErrorCount := COUNT(GROUP,h.license_number_Invalid=3);
    license_number_Total_ErrorCount := COUNT(GROUP,h.license_number_Invalid>0);
    npi_LEFTTRIM_ErrorCount := COUNT(GROUP,h.npi_Invalid=1);
    npi_ALLOW_ErrorCount := COUNT(GROUP,h.npi_Invalid=2);
    npi_LENGTH_ErrorCount := COUNT(GROUP,h.npi_Invalid=3);
    npi_WORDS_ErrorCount := COUNT(GROUP,h.npi_Invalid=4);
    npi_Total_ErrorCount := COUNT(GROUP,h.npi_Invalid>0);
    providertype_LEFTTRIM_ErrorCount := COUNT(GROUP,h.providertype_Invalid=1);
    providertype_ALLOW_ErrorCount := COUNT(GROUP,h.providertype_Invalid=2);
    providertype_Total_ErrorCount := COUNT(GROUP,h.providertype_Invalid>0);
    name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_Invalid=1);
    name_ALLOW_ErrorCount := COUNT(GROUP,h.name_Invalid=2);
    name_WORDS_ErrorCount := COUNT(GROUP,h.name_Invalid=3);
    name_Total_ErrorCount := COUNT(GROUP,h.name_Invalid>0);
    speciality_LEFTTRIM_ErrorCount := COUNT(GROUP,h.speciality_Invalid=1);
    speciality_ALLOW_ErrorCount := COUNT(GROUP,h.speciality_Invalid=2);
    speciality_Total_ErrorCount := COUNT(GROUP,h.speciality_Invalid>0);
    status_LEFTTRIM_ErrorCount := COUNT(GROUP,h.status_Invalid=1);
    status_ALLOW_ErrorCount := COUNT(GROUP,h.status_Invalid=2);
    status_LENGTH_ErrorCount := COUNT(GROUP,h.status_Invalid=3);
    status_WORDS_ErrorCount := COUNT(GROUP,h.status_Invalid=4);
    status_Total_ErrorCount := COUNT(GROUP,h.status_Invalid>0);
    address1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.address1_Invalid=1);
    address1_ALLOW_ErrorCount := COUNT(GROUP,h.address1_Invalid=2);
    address1_Total_ErrorCount := COUNT(GROUP,h.address1_Invalid>0);
    address2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.address2_Invalid=1);
    address2_ALLOW_ErrorCount := COUNT(GROUP,h.address2_Invalid=2);
    address2_Total_ErrorCount := COUNT(GROUP,h.address2_Invalid>0);
    address3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.address3_Invalid=1);
    address3_ALLOW_ErrorCount := COUNT(GROUP,h.address3_Invalid=2);
    address3_LENGTH_ErrorCount := COUNT(GROUP,h.address3_Invalid=3);
    address3_WORDS_ErrorCount := COUNT(GROUP,h.address3_Invalid=4);
    address3_Total_ErrorCount := COUNT(GROUP,h.address3_Invalid>0);
    officecity_LEFTTRIM_ErrorCount := COUNT(GROUP,h.officecity_Invalid=1);
    officecity_ALLOW_ErrorCount := COUNT(GROUP,h.officecity_Invalid=2);
    officecity_Total_ErrorCount := COUNT(GROUP,h.officecity_Invalid>0);
    officestate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.officestate_Invalid=1);
    officestate_ALLOW_ErrorCount := COUNT(GROUP,h.officestate_Invalid=2);
    officestate_LENGTH_ErrorCount := COUNT(GROUP,h.officestate_Invalid=3);
    officestate_WORDS_ErrorCount := COUNT(GROUP,h.officestate_Invalid=4);
    officestate_Total_ErrorCount := COUNT(GROUP,h.officestate_Invalid>0);
    officezipcode_LEFTTRIM_ErrorCount := COUNT(GROUP,h.officezipcode_Invalid=1);
    officezipcode_ALLOW_ErrorCount := COUNT(GROUP,h.officezipcode_Invalid=2);
    officezipcode_LENGTH_ErrorCount := COUNT(GROUP,h.officezipcode_Invalid=3);
    officezipcode_WORDS_ErrorCount := COUNT(GROUP,h.officezipcode_Invalid=4);
    officezipcode_Total_ErrorCount := COUNT(GROUP,h.officezipcode_Invalid>0);
    entity_type_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.entity_type_code_Invalid=1);
    entity_type_code_ALLOW_ErrorCount := COUNT(GROUP,h.entity_type_code_Invalid=2);
    entity_type_code_LENGTH_ErrorCount := COUNT(GROUP,h.entity_type_code_Invalid=3);
    entity_type_code_WORDS_ErrorCount := COUNT(GROUP,h.entity_type_code_Invalid=4);
    entity_type_code_Total_ErrorCount := COUNT(GROUP,h.entity_type_code_Invalid>0);
    companyname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.companyname_Invalid=1);
    companyname_ALLOW_ErrorCount := COUNT(GROUP,h.companyname_Invalid=2);
    companyname_Total_ErrorCount := COUNT(GROUP,h.companyname_Invalid>0);
    src_LEFTTRIM_ErrorCount := COUNT(GROUP,h.src_Invalid=1);
    src_ALLOW_ErrorCount := COUNT(GROUP,h.src_Invalid=2);
    src_LENGTH_ErrorCount := COUNT(GROUP,h.src_Invalid=3);
    src_WORDS_ErrorCount := COUNT(GROUP,h.src_Invalid=4);
    src_Total_ErrorCount := COUNT(GROUP,h.src_Invalid>0);
    dt_vendor_first_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=2);
    dt_vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=3);
    dt_vendor_first_reported_WORDS_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=4);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    dt_vendor_last_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=3);
    dt_vendor_last_reported_WORDS_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=4);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    dt_first_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=2);
    dt_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=3);
    dt_first_seen_WORDS_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=4);
    dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid>0);
    dt_last_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=2);
    dt_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=3);
    dt_last_seen_WORDS_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=4);
    dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid>0);
    record_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    record_type_ALLOW_ErrorCount := COUNT(GROUP,h.record_type_Invalid=2);
    record_type_LENGTH_ErrorCount := COUNT(GROUP,h.record_type_Invalid=3);
    record_type_WORDS_ErrorCount := COUNT(GROUP,h.record_type_Invalid=4);
    record_type_Total_ErrorCount := COUNT(GROUP,h.record_type_Invalid>0);
    source_rid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.source_rid_Invalid=1);
    source_rid_ALLOW_ErrorCount := COUNT(GROUP,h.source_rid_Invalid=2);
    source_rid_LENGTH_ErrorCount := COUNT(GROUP,h.source_rid_Invalid=3);
    source_rid_WORDS_ErrorCount := COUNT(GROUP,h.source_rid_Invalid=4);
    source_rid_Total_ErrorCount := COUNT(GROUP,h.source_rid_Invalid>0);
    lnpid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lnpid_Invalid=1);
    lnpid_ALLOW_ErrorCount := COUNT(GROUP,h.lnpid_Invalid=2);
    lnpid_LENGTH_ErrorCount := COUNT(GROUP,h.lnpid_Invalid=3);
    lnpid_WORDS_ErrorCount := COUNT(GROUP,h.lnpid_Invalid=4);
    lnpid_Total_ErrorCount := COUNT(GROUP,h.lnpid_Invalid>0);
    title_LEFTTRIM_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=2);
    title_LENGTH_ErrorCount := COUNT(GROUP,h.title_Invalid=3);
    title_WORDS_ErrorCount := COUNT(GROUP,h.title_Invalid=4);
    title_Total_ErrorCount := COUNT(GROUP,h.title_Invalid>0);
    fname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_WORDS_ErrorCount := COUNT(GROUP,h.fname_Invalid=3);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    mname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_LENGTH_ErrorCount := COUNT(GROUP,h.mname_Invalid=3);
    mname_WORDS_ErrorCount := COUNT(GROUP,h.mname_Invalid=4);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    lname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_WORDS_ErrorCount := COUNT(GROUP,h.lname_Invalid=3);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    name_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=3);
    name_suffix_WORDS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=4);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    name_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_type_Invalid=1);
    name_type_ALLOW_ErrorCount := COUNT(GROUP,h.name_type_Invalid=2);
    name_type_LENGTH_ErrorCount := COUNT(GROUP,h.name_type_Invalid=3);
    name_type_WORDS_ErrorCount := COUNT(GROUP,h.name_type_Invalid=4);
    name_type_Total_ErrorCount := COUNT(GROUP,h.name_type_Invalid>0);
    nid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.nid_Invalid=1);
    nid_ALLOW_ErrorCount := COUNT(GROUP,h.nid_Invalid=2);
    nid_LENGTH_ErrorCount := COUNT(GROUP,h.nid_Invalid=3);
    nid_WORDS_ErrorCount := COUNT(GROUP,h.nid_Invalid=4);
    nid_Total_ErrorCount := COUNT(GROUP,h.nid_Invalid>0);
    clean_clinic_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_clinic_name_Invalid=1);
    clean_clinic_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_clinic_name_Invalid=2);
    clean_clinic_name_LENGTH_ErrorCount := COUNT(GROUP,h.clean_clinic_name_Invalid=3);
    clean_clinic_name_WORDS_ErrorCount := COUNT(GROUP,h.clean_clinic_name_Invalid=4);
    clean_clinic_name_Total_ErrorCount := COUNT(GROUP,h.clean_clinic_name_Invalid>0);
    prepped_addr1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid=1);
    prepped_addr1_ALLOW_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid=2);
    prepped_addr1_WORDS_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid=3);
    prepped_addr1_Total_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid>0);
    prepped_addr2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid=1);
    prepped_addr2_ALLOW_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid=2);
    prepped_addr2_Total_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid>0);
    prim_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=2);
    prim_range_LENGTH_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=3);
    prim_range_WORDS_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=4);
    prim_range_Total_ErrorCount := COUNT(GROUP,h.prim_range_Invalid>0);
    predir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=2);
    predir_LENGTH_ErrorCount := COUNT(GROUP,h.predir_Invalid=3);
    predir_WORDS_ErrorCount := COUNT(GROUP,h.predir_Invalid=4);
    predir_Total_ErrorCount := COUNT(GROUP,h.predir_Invalid>0);
    prim_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=2);
    prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=3);
    prim_name_WORDS_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=4);
    prim_name_Total_ErrorCount := COUNT(GROUP,h.prim_name_Invalid>0);
    addr_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=2);
    addr_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=3);
    addr_suffix_WORDS_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=4);
    addr_suffix_Total_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid>0);
    postdir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=2);
    postdir_LENGTH_ErrorCount := COUNT(GROUP,h.postdir_Invalid=3);
    postdir_WORDS_ErrorCount := COUNT(GROUP,h.postdir_Invalid=4);
    postdir_Total_ErrorCount := COUNT(GROUP,h.postdir_Invalid>0);
    unit_desig_LEFTTRIM_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=2);
    unit_desig_LENGTH_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=3);
    unit_desig_WORDS_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=4);
    unit_desig_Total_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid>0);
    sec_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=2);
    sec_range_LENGTH_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=3);
    sec_range_WORDS_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=4);
    sec_range_Total_ErrorCount := COUNT(GROUP,h.sec_range_Invalid>0);
    p_city_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=2);
    p_city_name_WORDS_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=3);
    p_city_name_Total_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid>0);
    v_city_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=2);
    v_city_name_WORDS_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=3);
    v_city_name_Total_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid>0);
    st_LEFTTRIM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_LENGTH_ErrorCount := COUNT(GROUP,h.st_Invalid=3);
    st_WORDS_ErrorCount := COUNT(GROUP,h.st_Invalid=4);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_LENGTH_ErrorCount := COUNT(GROUP,h.zip_Invalid=3);
    zip_WORDS_ErrorCount := COUNT(GROUP,h.zip_Invalid=4);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    zip4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_LENGTH_ErrorCount := COUNT(GROUP,h.zip4_Invalid=3);
    zip4_WORDS_ErrorCount := COUNT(GROUP,h.zip4_Invalid=4);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    cart_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=2);
    cart_LENGTH_ErrorCount := COUNT(GROUP,h.cart_Invalid=3);
    cart_WORDS_ErrorCount := COUNT(GROUP,h.cart_Invalid=4);
    cart_Total_ErrorCount := COUNT(GROUP,h.cart_Invalid>0);
    cr_sort_sz_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=2);
    cr_sort_sz_LENGTH_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=3);
    cr_sort_sz_WORDS_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=4);
    cr_sort_sz_Total_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid>0);
    lot_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_ALLOW_ErrorCount := COUNT(GROUP,h.lot_Invalid=2);
    lot_LENGTH_ErrorCount := COUNT(GROUP,h.lot_Invalid=3);
    lot_WORDS_ErrorCount := COUNT(GROUP,h.lot_Invalid=4);
    lot_Total_ErrorCount := COUNT(GROUP,h.lot_Invalid>0);
    lot_order_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=2);
    lot_order_LENGTH_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=3);
    lot_order_WORDS_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=4);
    lot_order_Total_ErrorCount := COUNT(GROUP,h.lot_order_Invalid>0);
    dbpc_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=1);
    dbpc_ALLOW_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=2);
    dbpc_LENGTH_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=3);
    dbpc_WORDS_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=4);
    dbpc_Total_ErrorCount := COUNT(GROUP,h.dbpc_Invalid>0);
    chk_digit_LEFTTRIM_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=2);
    chk_digit_LENGTH_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=3);
    chk_digit_WORDS_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=4);
    chk_digit_Total_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid>0);
    rec_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    rec_type_ALLOW_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=2);
    rec_type_LENGTH_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=3);
    rec_type_WORDS_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=4);
    rec_type_Total_ErrorCount := COUNT(GROUP,h.rec_type_Invalid>0);
    fips_st_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fips_st_Invalid=1);
    fips_st_ALLOW_ErrorCount := COUNT(GROUP,h.fips_st_Invalid=2);
    fips_st_LENGTH_ErrorCount := COUNT(GROUP,h.fips_st_Invalid=3);
    fips_st_WORDS_ErrorCount := COUNT(GROUP,h.fips_st_Invalid=4);
    fips_st_Total_ErrorCount := COUNT(GROUP,h.fips_st_Invalid>0);
    fips_county_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=1);
    fips_county_ALLOW_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=2);
    fips_county_LENGTH_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=3);
    fips_county_WORDS_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=4);
    fips_county_Total_ErrorCount := COUNT(GROUP,h.fips_county_Invalid>0);
    geo_lat_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=2);
    geo_lat_LENGTH_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=3);
    geo_lat_WORDS_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=4);
    geo_lat_Total_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid>0);
    geo_long_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=2);
    geo_long_LENGTH_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=3);
    geo_long_WORDS_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=4);
    geo_long_Total_ErrorCount := COUNT(GROUP,h.geo_long_Invalid>0);
    msa_LEFTTRIM_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    msa_ALLOW_ErrorCount := COUNT(GROUP,h.msa_Invalid=2);
    msa_LENGTH_ErrorCount := COUNT(GROUP,h.msa_Invalid=3);
    msa_WORDS_ErrorCount := COUNT(GROUP,h.msa_Invalid=4);
    msa_Total_ErrorCount := COUNT(GROUP,h.msa_Invalid>0);
    geo_blk_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=2);
    geo_blk_LENGTH_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=3);
    geo_blk_WORDS_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=4);
    geo_blk_Total_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid>0);
    geo_match_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=2);
    geo_match_LENGTH_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=3);
    geo_match_WORDS_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=4);
    geo_match_Total_ErrorCount := COUNT(GROUP,h.geo_match_Invalid>0);
    err_stat_LEFTTRIM_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=2);
    err_stat_LENGTH_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=3);
    err_stat_WORDS_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=4);
    err_stat_Total_ErrorCount := COUNT(GROUP,h.err_stat_Invalid>0);
    rawaid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=1);
    rawaid_ALLOW_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=2);
    rawaid_LENGTH_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=3);
    rawaid_WORDS_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=4);
    rawaid_Total_ErrorCount := COUNT(GROUP,h.rawaid_Invalid>0);
    aceaid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.aceaid_Invalid=1);
    aceaid_ALLOW_ErrorCount := COUNT(GROUP,h.aceaid_Invalid=2);
    aceaid_LENGTH_ErrorCount := COUNT(GROUP,h.aceaid_Invalid=3);
    aceaid_WORDS_ErrorCount := COUNT(GROUP,h.aceaid_Invalid=4);
    aceaid_Total_ErrorCount := COUNT(GROUP,h.aceaid_Invalid>0);
    clean_phone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=1);
    clean_phone_ALLOW_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=2);
    clean_phone_LENGTH_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=3);
    clean_phone_WORDS_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=4);
    clean_phone_Total_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid>0);
    dotid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dotid_Invalid=1);
    dotid_ALLOW_ErrorCount := COUNT(GROUP,h.dotid_Invalid=2);
    dotid_LENGTH_ErrorCount := COUNT(GROUP,h.dotid_Invalid=3);
    dotid_WORDS_ErrorCount := COUNT(GROUP,h.dotid_Invalid=4);
    dotid_Total_ErrorCount := COUNT(GROUP,h.dotid_Invalid>0);
    dotscore_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dotscore_Invalid=1);
    dotscore_ALLOW_ErrorCount := COUNT(GROUP,h.dotscore_Invalid=2);
    dotscore_LENGTH_ErrorCount := COUNT(GROUP,h.dotscore_Invalid=3);
    dotscore_WORDS_ErrorCount := COUNT(GROUP,h.dotscore_Invalid=4);
    dotscore_Total_ErrorCount := COUNT(GROUP,h.dotscore_Invalid>0);
    dotweight_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dotweight_Invalid=1);
    dotweight_ALLOW_ErrorCount := COUNT(GROUP,h.dotweight_Invalid=2);
    dotweight_LENGTH_ErrorCount := COUNT(GROUP,h.dotweight_Invalid=3);
    dotweight_WORDS_ErrorCount := COUNT(GROUP,h.dotweight_Invalid=4);
    dotweight_Total_ErrorCount := COUNT(GROUP,h.dotweight_Invalid>0);
    empid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.empid_Invalid=1);
    empid_ALLOW_ErrorCount := COUNT(GROUP,h.empid_Invalid=2);
    empid_LENGTH_ErrorCount := COUNT(GROUP,h.empid_Invalid=3);
    empid_WORDS_ErrorCount := COUNT(GROUP,h.empid_Invalid=4);
    empid_Total_ErrorCount := COUNT(GROUP,h.empid_Invalid>0);
    empscore_LEFTTRIM_ErrorCount := COUNT(GROUP,h.empscore_Invalid=1);
    empscore_ALLOW_ErrorCount := COUNT(GROUP,h.empscore_Invalid=2);
    empscore_LENGTH_ErrorCount := COUNT(GROUP,h.empscore_Invalid=3);
    empscore_WORDS_ErrorCount := COUNT(GROUP,h.empscore_Invalid=4);
    empscore_Total_ErrorCount := COUNT(GROUP,h.empscore_Invalid>0);
    empweight_LEFTTRIM_ErrorCount := COUNT(GROUP,h.empweight_Invalid=1);
    empweight_ALLOW_ErrorCount := COUNT(GROUP,h.empweight_Invalid=2);
    empweight_LENGTH_ErrorCount := COUNT(GROUP,h.empweight_Invalid=3);
    empweight_WORDS_ErrorCount := COUNT(GROUP,h.empweight_Invalid=4);
    empweight_Total_ErrorCount := COUNT(GROUP,h.empweight_Invalid>0);
    powid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    powid_ALLOW_ErrorCount := COUNT(GROUP,h.powid_Invalid=2);
    powid_LENGTH_ErrorCount := COUNT(GROUP,h.powid_Invalid=3);
    powid_WORDS_ErrorCount := COUNT(GROUP,h.powid_Invalid=4);
    powid_Total_ErrorCount := COUNT(GROUP,h.powid_Invalid>0);
    powscore_LEFTTRIM_ErrorCount := COUNT(GROUP,h.powscore_Invalid=1);
    powscore_ALLOW_ErrorCount := COUNT(GROUP,h.powscore_Invalid=2);
    powscore_LENGTH_ErrorCount := COUNT(GROUP,h.powscore_Invalid=3);
    powscore_WORDS_ErrorCount := COUNT(GROUP,h.powscore_Invalid=4);
    powscore_Total_ErrorCount := COUNT(GROUP,h.powscore_Invalid>0);
    powweight_LEFTTRIM_ErrorCount := COUNT(GROUP,h.powweight_Invalid=1);
    powweight_ALLOW_ErrorCount := COUNT(GROUP,h.powweight_Invalid=2);
    powweight_LENGTH_ErrorCount := COUNT(GROUP,h.powweight_Invalid=3);
    powweight_WORDS_ErrorCount := COUNT(GROUP,h.powweight_Invalid=4);
    powweight_Total_ErrorCount := COUNT(GROUP,h.powweight_Invalid>0);
    proxid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    proxid_ALLOW_ErrorCount := COUNT(GROUP,h.proxid_Invalid=2);
    proxid_LENGTH_ErrorCount := COUNT(GROUP,h.proxid_Invalid=3);
    proxid_WORDS_ErrorCount := COUNT(GROUP,h.proxid_Invalid=4);
    proxid_Total_ErrorCount := COUNT(GROUP,h.proxid_Invalid>0);
    proxscore_LEFTTRIM_ErrorCount := COUNT(GROUP,h.proxscore_Invalid=1);
    proxscore_ALLOW_ErrorCount := COUNT(GROUP,h.proxscore_Invalid=2);
    proxscore_LENGTH_ErrorCount := COUNT(GROUP,h.proxscore_Invalid=3);
    proxscore_WORDS_ErrorCount := COUNT(GROUP,h.proxscore_Invalid=4);
    proxscore_Total_ErrorCount := COUNT(GROUP,h.proxscore_Invalid>0);
    proxweight_LEFTTRIM_ErrorCount := COUNT(GROUP,h.proxweight_Invalid=1);
    proxweight_ALLOW_ErrorCount := COUNT(GROUP,h.proxweight_Invalid=2);
    proxweight_LENGTH_ErrorCount := COUNT(GROUP,h.proxweight_Invalid=3);
    proxweight_WORDS_ErrorCount := COUNT(GROUP,h.proxweight_Invalid=4);
    proxweight_Total_ErrorCount := COUNT(GROUP,h.proxweight_Invalid>0);
    seleid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    seleid_ALLOW_ErrorCount := COUNT(GROUP,h.seleid_Invalid=2);
    seleid_LENGTH_ErrorCount := COUNT(GROUP,h.seleid_Invalid=3);
    seleid_WORDS_ErrorCount := COUNT(GROUP,h.seleid_Invalid=4);
    seleid_Total_ErrorCount := COUNT(GROUP,h.seleid_Invalid>0);
    selescore_LEFTTRIM_ErrorCount := COUNT(GROUP,h.selescore_Invalid=1);
    selescore_ALLOW_ErrorCount := COUNT(GROUP,h.selescore_Invalid=2);
    selescore_LENGTH_ErrorCount := COUNT(GROUP,h.selescore_Invalid=3);
    selescore_WORDS_ErrorCount := COUNT(GROUP,h.selescore_Invalid=4);
    selescore_Total_ErrorCount := COUNT(GROUP,h.selescore_Invalid>0);
    seleweight_LEFTTRIM_ErrorCount := COUNT(GROUP,h.seleweight_Invalid=1);
    seleweight_ALLOW_ErrorCount := COUNT(GROUP,h.seleweight_Invalid=2);
    seleweight_LENGTH_ErrorCount := COUNT(GROUP,h.seleweight_Invalid=3);
    seleweight_WORDS_ErrorCount := COUNT(GROUP,h.seleweight_Invalid=4);
    seleweight_Total_ErrorCount := COUNT(GROUP,h.seleweight_Invalid>0);
    orgid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    orgid_ALLOW_ErrorCount := COUNT(GROUP,h.orgid_Invalid=2);
    orgid_LENGTH_ErrorCount := COUNT(GROUP,h.orgid_Invalid=3);
    orgid_WORDS_ErrorCount := COUNT(GROUP,h.orgid_Invalid=4);
    orgid_Total_ErrorCount := COUNT(GROUP,h.orgid_Invalid>0);
    orgscore_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orgscore_Invalid=1);
    orgscore_ALLOW_ErrorCount := COUNT(GROUP,h.orgscore_Invalid=2);
    orgscore_LENGTH_ErrorCount := COUNT(GROUP,h.orgscore_Invalid=3);
    orgscore_WORDS_ErrorCount := COUNT(GROUP,h.orgscore_Invalid=4);
    orgscore_Total_ErrorCount := COUNT(GROUP,h.orgscore_Invalid>0);
    orgweight_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orgweight_Invalid=1);
    orgweight_ALLOW_ErrorCount := COUNT(GROUP,h.orgweight_Invalid=2);
    orgweight_LENGTH_ErrorCount := COUNT(GROUP,h.orgweight_Invalid=3);
    orgweight_WORDS_ErrorCount := COUNT(GROUP,h.orgweight_Invalid=4);
    orgweight_Total_ErrorCount := COUNT(GROUP,h.orgweight_Invalid>0);
    ultid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    ultid_ALLOW_ErrorCount := COUNT(GROUP,h.ultid_Invalid=2);
    ultid_LENGTH_ErrorCount := COUNT(GROUP,h.ultid_Invalid=3);
    ultid_WORDS_ErrorCount := COUNT(GROUP,h.ultid_Invalid=4);
    ultid_Total_ErrorCount := COUNT(GROUP,h.ultid_Invalid>0);
    ultscore_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ultscore_Invalid=1);
    ultscore_ALLOW_ErrorCount := COUNT(GROUP,h.ultscore_Invalid=2);
    ultscore_LENGTH_ErrorCount := COUNT(GROUP,h.ultscore_Invalid=3);
    ultscore_WORDS_ErrorCount := COUNT(GROUP,h.ultscore_Invalid=4);
    ultscore_Total_ErrorCount := COUNT(GROUP,h.ultscore_Invalid>0);
    ultweight_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ultweight_Invalid=1);
    ultweight_ALLOW_ErrorCount := COUNT(GROUP,h.ultweight_Invalid=2);
    ultweight_LENGTH_ErrorCount := COUNT(GROUP,h.ultweight_Invalid=3);
    ultweight_WORDS_ErrorCount := COUNT(GROUP,h.ultweight_Invalid=4);
    ultweight_Total_ErrorCount := COUNT(GROUP,h.ultweight_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT31.StrType ErrorMessage;
    SALT31.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.did_Invalid,le.did_score_Invalid,le.bdid_Invalid,le.bdid_score_Invalid,le.best_dob_Invalid,le.best_ssn_Invalid,le.data_state_Invalid,le.provider_name_Invalid,le.license_number_Invalid,le.npi_Invalid,le.providertype_Invalid,le.name_Invalid,le.speciality_Invalid,le.status_Invalid,le.address1_Invalid,le.address2_Invalid,le.address3_Invalid,le.officecity_Invalid,le.officestate_Invalid,le.officezipcode_Invalid,le.entity_type_code_Invalid,le.companyname_Invalid,le.src_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.record_type_Invalid,le.source_rid_Invalid,le.lnpid_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.name_type_Invalid,le.nid_Invalid,le.clean_clinic_name_Invalid,le.prepped_addr1_Invalid,le.prepped_addr2_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dbpc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.fips_st_Invalid,le.fips_county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.rawaid_Invalid,le.aceaid_Invalid,le.clean_phone_Invalid,le.dotid_Invalid,le.dotscore_Invalid,le.dotweight_Invalid,le.empid_Invalid,le.empscore_Invalid,le.empweight_Invalid,le.powid_Invalid,le.powscore_Invalid,le.powweight_Invalid,le.proxid_Invalid,le.proxscore_Invalid,le.proxweight_Invalid,le.seleid_Invalid,le.selescore_Invalid,le.seleweight_Invalid,le.orgid_Invalid,le.orgscore_Invalid,le.orgweight_Invalid,le.ultid_Invalid,le.ultscore_Invalid,le.ultweight_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_did(le.did_Invalid),Fields.InvalidMessage_did_score(le.did_score_Invalid),Fields.InvalidMessage_bdid(le.bdid_Invalid),Fields.InvalidMessage_bdid_score(le.bdid_score_Invalid),Fields.InvalidMessage_best_dob(le.best_dob_Invalid),Fields.InvalidMessage_best_ssn(le.best_ssn_Invalid),Fields.InvalidMessage_data_state(le.data_state_Invalid),Fields.InvalidMessage_provider_name(le.provider_name_Invalid),Fields.InvalidMessage_license_number(le.license_number_Invalid),Fields.InvalidMessage_npi(le.npi_Invalid),Fields.InvalidMessage_providertype(le.providertype_Invalid),Fields.InvalidMessage_name(le.name_Invalid),Fields.InvalidMessage_speciality(le.speciality_Invalid),Fields.InvalidMessage_status(le.status_Invalid),Fields.InvalidMessage_address1(le.address1_Invalid),Fields.InvalidMessage_address2(le.address2_Invalid),Fields.InvalidMessage_address3(le.address3_Invalid),Fields.InvalidMessage_officecity(le.officecity_Invalid),Fields.InvalidMessage_officestate(le.officestate_Invalid),Fields.InvalidMessage_officezipcode(le.officezipcode_Invalid),Fields.InvalidMessage_entity_type_code(le.entity_type_code_Invalid),Fields.InvalidMessage_companyname(le.companyname_Invalid),Fields.InvalidMessage_src(le.src_Invalid),Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_record_type(le.record_type_Invalid),Fields.InvalidMessage_source_rid(le.source_rid_Invalid),Fields.InvalidMessage_lnpid(le.lnpid_Invalid),Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_name_type(le.name_type_Invalid),Fields.InvalidMessage_nid(le.nid_Invalid),Fields.InvalidMessage_clean_clinic_name(le.clean_clinic_name_Invalid),Fields.InvalidMessage_prepped_addr1(le.prepped_addr1_Invalid),Fields.InvalidMessage_prepped_addr2(le.prepped_addr2_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_cart(le.cart_Invalid),Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Fields.InvalidMessage_lot(le.lot_Invalid),Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Fields.InvalidMessage_dbpc(le.dbpc_Invalid),Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_fips_st(le.fips_st_Invalid),Fields.InvalidMessage_fips_county(le.fips_county_Invalid),Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Fields.InvalidMessage_msa(le.msa_Invalid),Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Fields.InvalidMessage_rawaid(le.rawaid_Invalid),Fields.InvalidMessage_aceaid(le.aceaid_Invalid),Fields.InvalidMessage_clean_phone(le.clean_phone_Invalid),Fields.InvalidMessage_dotid(le.dotid_Invalid),Fields.InvalidMessage_dotscore(le.dotscore_Invalid),Fields.InvalidMessage_dotweight(le.dotweight_Invalid),Fields.InvalidMessage_empid(le.empid_Invalid),Fields.InvalidMessage_empscore(le.empscore_Invalid),Fields.InvalidMessage_empweight(le.empweight_Invalid),Fields.InvalidMessage_powid(le.powid_Invalid),Fields.InvalidMessage_powscore(le.powscore_Invalid),Fields.InvalidMessage_powweight(le.powweight_Invalid),Fields.InvalidMessage_proxid(le.proxid_Invalid),Fields.InvalidMessage_proxscore(le.proxscore_Invalid),Fields.InvalidMessage_proxweight(le.proxweight_Invalid),Fields.InvalidMessage_seleid(le.seleid_Invalid),Fields.InvalidMessage_selescore(le.selescore_Invalid),Fields.InvalidMessage_seleweight(le.seleweight_Invalid),Fields.InvalidMessage_orgid(le.orgid_Invalid),Fields.InvalidMessage_orgscore(le.orgscore_Invalid),Fields.InvalidMessage_orgweight(le.orgweight_Invalid),Fields.InvalidMessage_ultid(le.ultid_Invalid),Fields.InvalidMessage_ultscore(le.ultscore_Invalid),Fields.InvalidMessage_ultweight(le.ultweight_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.did_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.bdid_score_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.best_dob_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.best_ssn_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.data_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.provider_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.license_number_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.npi_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.providertype_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.name_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.speciality_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.status_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.address1_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.address2_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.address3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.officecity_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.officestate_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.officezipcode_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.entity_type_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.companyname_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.src_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.source_rid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lnpid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.name_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.nid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_clinic_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.prepped_addr1_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.prepped_addr2_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dbpc_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.fips_st_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.fips_county_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.rawaid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.aceaid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_phone_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dotid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dotscore_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dotweight_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.empid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.empscore_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.empweight_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.powid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.powscore_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.powweight_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.proxscore_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.proxweight_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.selescore_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.seleweight_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orgscore_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orgweight_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ultscore_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ultweight_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'did','did_score','bdid','bdid_score','best_dob','best_ssn','data_state','provider_name','license_number','npi','providertype','name','speciality','status','address1','address2','address3','officecity','officestate','officezipcode','entity_type_code','companyname','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','record_type','source_rid','lnpid','title','fname','mname','lname','name_suffix','name_type','nid','clean_clinic_name','prepped_addr1','prepped_addr2','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','clean_phone','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'did','did_score','bdid','bdid_score','best_dob','best_ssn','data_state','provider_name','license_number','npi','providertype','name','speciality','status','address1','address2','address3','officecity','officestate','officezipcode','entity_type_code','companyname','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','record_type','source_rid','lnpid','title','fname','mname','lname','name_suffix','name_type','nid','clean_clinic_name','prepped_addr1','prepped_addr2','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','clean_phone','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.did,(SALT31.StrType)le.did_score,(SALT31.StrType)le.bdid,(SALT31.StrType)le.bdid_score,(SALT31.StrType)le.best_dob,(SALT31.StrType)le.best_ssn,(SALT31.StrType)le.data_state,(SALT31.StrType)le.provider_name,(SALT31.StrType)le.license_number,(SALT31.StrType)le.npi,(SALT31.StrType)le.providertype,(SALT31.StrType)le.name,(SALT31.StrType)le.speciality,(SALT31.StrType)le.status,(SALT31.StrType)le.address1,(SALT31.StrType)le.address2,(SALT31.StrType)le.address3,(SALT31.StrType)le.officecity,(SALT31.StrType)le.officestate,(SALT31.StrType)le.officezipcode,(SALT31.StrType)le.entity_type_code,(SALT31.StrType)le.companyname,(SALT31.StrType)le.src,(SALT31.StrType)le.dt_vendor_first_reported,(SALT31.StrType)le.dt_vendor_last_reported,(SALT31.StrType)le.dt_first_seen,(SALT31.StrType)le.dt_last_seen,(SALT31.StrType)le.record_type,(SALT31.StrType)le.source_rid,(SALT31.StrType)le.lnpid,(SALT31.StrType)le.title,(SALT31.StrType)le.fname,(SALT31.StrType)le.mname,(SALT31.StrType)le.lname,(SALT31.StrType)le.name_suffix,(SALT31.StrType)le.name_type,(SALT31.StrType)le.nid,(SALT31.StrType)le.clean_clinic_name,(SALT31.StrType)le.prepped_addr1,(SALT31.StrType)le.prepped_addr2,(SALT31.StrType)le.prim_range,(SALT31.StrType)le.predir,(SALT31.StrType)le.prim_name,(SALT31.StrType)le.addr_suffix,(SALT31.StrType)le.postdir,(SALT31.StrType)le.unit_desig,(SALT31.StrType)le.sec_range,(SALT31.StrType)le.p_city_name,(SALT31.StrType)le.v_city_name,(SALT31.StrType)le.st,(SALT31.StrType)le.zip,(SALT31.StrType)le.zip4,(SALT31.StrType)le.cart,(SALT31.StrType)le.cr_sort_sz,(SALT31.StrType)le.lot,(SALT31.StrType)le.lot_order,(SALT31.StrType)le.dbpc,(SALT31.StrType)le.chk_digit,(SALT31.StrType)le.rec_type,(SALT31.StrType)le.fips_st,(SALT31.StrType)le.fips_county,(SALT31.StrType)le.geo_lat,(SALT31.StrType)le.geo_long,(SALT31.StrType)le.msa,(SALT31.StrType)le.geo_blk,(SALT31.StrType)le.geo_match,(SALT31.StrType)le.err_stat,(SALT31.StrType)le.rawaid,(SALT31.StrType)le.aceaid,(SALT31.StrType)le.clean_phone,(SALT31.StrType)le.dotid,(SALT31.StrType)le.dotscore,(SALT31.StrType)le.dotweight,(SALT31.StrType)le.empid,(SALT31.StrType)le.empscore,(SALT31.StrType)le.empweight,(SALT31.StrType)le.powid,(SALT31.StrType)le.powscore,(SALT31.StrType)le.powweight,(SALT31.StrType)le.proxid,(SALT31.StrType)le.proxscore,(SALT31.StrType)le.proxweight,(SALT31.StrType)le.seleid,(SALT31.StrType)le.selescore,(SALT31.StrType)le.seleweight,(SALT31.StrType)le.orgid,(SALT31.StrType)le.orgscore,(SALT31.StrType)le.orgweight,(SALT31.StrType)le.ultid,(SALT31.StrType)le.ultscore,(SALT31.StrType)le.ultweight,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,91,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT31.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'did:did:LEFTTRIM','did:did:ALLOW','did:did:LENGTH','did:did:WORDS'
          ,'did_score:did_score:LEFTTRIM','did_score:did_score:ALLOW','did_score:did_score:LENGTH','did_score:did_score:WORDS'
          ,'bdid:bdid:LEFTTRIM','bdid:bdid:ALLOW','bdid:bdid:LENGTH','bdid:bdid:WORDS'
          ,'bdid_score:bdid_score:LEFTTRIM','bdid_score:bdid_score:ALLOW','bdid_score:bdid_score:LENGTH','bdid_score:bdid_score:WORDS'
          ,'best_dob:best_dob:LEFTTRIM','best_dob:best_dob:ALLOW','best_dob:best_dob:LENGTH','best_dob:best_dob:WORDS'
          ,'best_ssn:best_ssn:LEFTTRIM','best_ssn:best_ssn:ALLOW','best_ssn:best_ssn:LENGTH','best_ssn:best_ssn:WORDS'
          ,'data_state:data_state:LEFTTRIM','data_state:data_state:ALLOW','data_state:data_state:LENGTH','data_state:data_state:WORDS'
          ,'provider_name:provider_name:LEFTTRIM','provider_name:provider_name:ALLOW'
          ,'license_number:license_number:LEFTTRIM','license_number:license_number:ALLOW','license_number:license_number:WORDS'
          ,'npi:npi:LEFTTRIM','npi:npi:ALLOW','npi:npi:LENGTH','npi:npi:WORDS'
          ,'providertype:providertype:LEFTTRIM','providertype:providertype:ALLOW'
          ,'name:name:LEFTTRIM','name:name:ALLOW','name:name:WORDS'
          ,'speciality:speciality:LEFTTRIM','speciality:speciality:ALLOW'
          ,'status:status:LEFTTRIM','status:status:ALLOW','status:status:LENGTH','status:status:WORDS'
          ,'address1:address1:LEFTTRIM','address1:address1:ALLOW'
          ,'address2:address2:LEFTTRIM','address2:address2:ALLOW'
          ,'address3:address3:LEFTTRIM','address3:address3:ALLOW','address3:address3:LENGTH','address3:address3:WORDS'
          ,'officecity:officecity:LEFTTRIM','officecity:officecity:ALLOW'
          ,'officestate:officestate:LEFTTRIM','officestate:officestate:ALLOW','officestate:officestate:LENGTH','officestate:officestate:WORDS'
          ,'officezipcode:officezipcode:LEFTTRIM','officezipcode:officezipcode:ALLOW','officezipcode:officezipcode:LENGTH','officezipcode:officezipcode:WORDS'
          ,'entity_type_code:entity_type_code:LEFTTRIM','entity_type_code:entity_type_code:ALLOW','entity_type_code:entity_type_code:LENGTH','entity_type_code:entity_type_code:WORDS'
          ,'companyname:companyname:LEFTTRIM','companyname:companyname:ALLOW'
          ,'src:src:LEFTTRIM','src:src:ALLOW','src:src:LENGTH','src:src:WORDS'
          ,'dt_vendor_first_reported:dt_vendor_first_reported:LEFTTRIM','dt_vendor_first_reported:dt_vendor_first_reported:ALLOW','dt_vendor_first_reported:dt_vendor_first_reported:LENGTH','dt_vendor_first_reported:dt_vendor_first_reported:WORDS'
          ,'dt_vendor_last_reported:dt_vendor_last_reported:LEFTTRIM','dt_vendor_last_reported:dt_vendor_last_reported:ALLOW','dt_vendor_last_reported:dt_vendor_last_reported:LENGTH','dt_vendor_last_reported:dt_vendor_last_reported:WORDS'
          ,'dt_first_seen:dt_first_seen:LEFTTRIM','dt_first_seen:dt_first_seen:ALLOW','dt_first_seen:dt_first_seen:LENGTH','dt_first_seen:dt_first_seen:WORDS'
          ,'dt_last_seen:dt_last_seen:LEFTTRIM','dt_last_seen:dt_last_seen:ALLOW','dt_last_seen:dt_last_seen:LENGTH','dt_last_seen:dt_last_seen:WORDS'
          ,'record_type:record_type:LEFTTRIM','record_type:record_type:ALLOW','record_type:record_type:LENGTH','record_type:record_type:WORDS'
          ,'source_rid:source_rid:LEFTTRIM','source_rid:source_rid:ALLOW','source_rid:source_rid:LENGTH','source_rid:source_rid:WORDS'
          ,'lnpid:lnpid:LEFTTRIM','lnpid:lnpid:ALLOW','lnpid:lnpid:LENGTH','lnpid:lnpid:WORDS'
          ,'title:title:LEFTTRIM','title:title:ALLOW','title:title:LENGTH','title:title:WORDS'
          ,'fname:fname:LEFTTRIM','fname:fname:ALLOW','fname:fname:WORDS'
          ,'mname:mname:LEFTTRIM','mname:mname:ALLOW','mname:mname:LENGTH','mname:mname:WORDS'
          ,'lname:lname:LEFTTRIM','lname:lname:ALLOW','lname:lname:WORDS'
          ,'name_suffix:name_suffix:LEFTTRIM','name_suffix:name_suffix:ALLOW','name_suffix:name_suffix:LENGTH','name_suffix:name_suffix:WORDS'
          ,'name_type:name_type:LEFTTRIM','name_type:name_type:ALLOW','name_type:name_type:LENGTH','name_type:name_type:WORDS'
          ,'nid:nid:LEFTTRIM','nid:nid:ALLOW','nid:nid:LENGTH','nid:nid:WORDS'
          ,'clean_clinic_name:clean_clinic_name:LEFTTRIM','clean_clinic_name:clean_clinic_name:ALLOW','clean_clinic_name:clean_clinic_name:LENGTH','clean_clinic_name:clean_clinic_name:WORDS'
          ,'prepped_addr1:prepped_addr1:LEFTTRIM','prepped_addr1:prepped_addr1:ALLOW','prepped_addr1:prepped_addr1:WORDS'
          ,'prepped_addr2:prepped_addr2:LEFTTRIM','prepped_addr2:prepped_addr2:ALLOW'
          ,'prim_range:prim_range:LEFTTRIM','prim_range:prim_range:ALLOW','prim_range:prim_range:LENGTH','prim_range:prim_range:WORDS'
          ,'predir:predir:LEFTTRIM','predir:predir:ALLOW','predir:predir:LENGTH','predir:predir:WORDS'
          ,'prim_name:prim_name:LEFTTRIM','prim_name:prim_name:ALLOW','prim_name:prim_name:LENGTH','prim_name:prim_name:WORDS'
          ,'addr_suffix:addr_suffix:LEFTTRIM','addr_suffix:addr_suffix:ALLOW','addr_suffix:addr_suffix:LENGTH','addr_suffix:addr_suffix:WORDS'
          ,'postdir:postdir:LEFTTRIM','postdir:postdir:ALLOW','postdir:postdir:LENGTH','postdir:postdir:WORDS'
          ,'unit_desig:unit_desig:LEFTTRIM','unit_desig:unit_desig:ALLOW','unit_desig:unit_desig:LENGTH','unit_desig:unit_desig:WORDS'
          ,'sec_range:sec_range:LEFTTRIM','sec_range:sec_range:ALLOW','sec_range:sec_range:LENGTH','sec_range:sec_range:WORDS'
          ,'p_city_name:p_city_name:LEFTTRIM','p_city_name:p_city_name:ALLOW','p_city_name:p_city_name:WORDS'
          ,'v_city_name:v_city_name:LEFTTRIM','v_city_name:v_city_name:ALLOW','v_city_name:v_city_name:WORDS'
          ,'st:st:LEFTTRIM','st:st:ALLOW','st:st:LENGTH','st:st:WORDS'
          ,'zip:zip:LEFTTRIM','zip:zip:ALLOW','zip:zip:LENGTH','zip:zip:WORDS'
          ,'zip4:zip4:LEFTTRIM','zip4:zip4:ALLOW','zip4:zip4:LENGTH','zip4:zip4:WORDS'
          ,'cart:cart:LEFTTRIM','cart:cart:ALLOW','cart:cart:LENGTH','cart:cart:WORDS'
          ,'cr_sort_sz:cr_sort_sz:LEFTTRIM','cr_sort_sz:cr_sort_sz:ALLOW','cr_sort_sz:cr_sort_sz:LENGTH','cr_sort_sz:cr_sort_sz:WORDS'
          ,'lot:lot:LEFTTRIM','lot:lot:ALLOW','lot:lot:LENGTH','lot:lot:WORDS'
          ,'lot_order:lot_order:LEFTTRIM','lot_order:lot_order:ALLOW','lot_order:lot_order:LENGTH','lot_order:lot_order:WORDS'
          ,'dbpc:dbpc:LEFTTRIM','dbpc:dbpc:ALLOW','dbpc:dbpc:LENGTH','dbpc:dbpc:WORDS'
          ,'chk_digit:chk_digit:LEFTTRIM','chk_digit:chk_digit:ALLOW','chk_digit:chk_digit:LENGTH','chk_digit:chk_digit:WORDS'
          ,'rec_type:rec_type:LEFTTRIM','rec_type:rec_type:ALLOW','rec_type:rec_type:LENGTH','rec_type:rec_type:WORDS'
          ,'fips_st:fips_st:LEFTTRIM','fips_st:fips_st:ALLOW','fips_st:fips_st:LENGTH','fips_st:fips_st:WORDS'
          ,'fips_county:fips_county:LEFTTRIM','fips_county:fips_county:ALLOW','fips_county:fips_county:LENGTH','fips_county:fips_county:WORDS'
          ,'geo_lat:geo_lat:LEFTTRIM','geo_lat:geo_lat:ALLOW','geo_lat:geo_lat:LENGTH','geo_lat:geo_lat:WORDS'
          ,'geo_long:geo_long:LEFTTRIM','geo_long:geo_long:ALLOW','geo_long:geo_long:LENGTH','geo_long:geo_long:WORDS'
          ,'msa:msa:LEFTTRIM','msa:msa:ALLOW','msa:msa:LENGTH','msa:msa:WORDS'
          ,'geo_blk:geo_blk:LEFTTRIM','geo_blk:geo_blk:ALLOW','geo_blk:geo_blk:LENGTH','geo_blk:geo_blk:WORDS'
          ,'geo_match:geo_match:LEFTTRIM','geo_match:geo_match:ALLOW','geo_match:geo_match:LENGTH','geo_match:geo_match:WORDS'
          ,'err_stat:err_stat:LEFTTRIM','err_stat:err_stat:ALLOW','err_stat:err_stat:LENGTH','err_stat:err_stat:WORDS'
          ,'rawaid:rawaid:LEFTTRIM','rawaid:rawaid:ALLOW','rawaid:rawaid:LENGTH','rawaid:rawaid:WORDS'
          ,'aceaid:aceaid:LEFTTRIM','aceaid:aceaid:ALLOW','aceaid:aceaid:LENGTH','aceaid:aceaid:WORDS'
          ,'clean_phone:clean_phone:LEFTTRIM','clean_phone:clean_phone:ALLOW','clean_phone:clean_phone:LENGTH','clean_phone:clean_phone:WORDS'
          ,'dotid:dotid:LEFTTRIM','dotid:dotid:ALLOW','dotid:dotid:LENGTH','dotid:dotid:WORDS'
          ,'dotscore:dotscore:LEFTTRIM','dotscore:dotscore:ALLOW','dotscore:dotscore:LENGTH','dotscore:dotscore:WORDS'
          ,'dotweight:dotweight:LEFTTRIM','dotweight:dotweight:ALLOW','dotweight:dotweight:LENGTH','dotweight:dotweight:WORDS'
          ,'empid:empid:LEFTTRIM','empid:empid:ALLOW','empid:empid:LENGTH','empid:empid:WORDS'
          ,'empscore:empscore:LEFTTRIM','empscore:empscore:ALLOW','empscore:empscore:LENGTH','empscore:empscore:WORDS'
          ,'empweight:empweight:LEFTTRIM','empweight:empweight:ALLOW','empweight:empweight:LENGTH','empweight:empweight:WORDS'
          ,'powid:powid:LEFTTRIM','powid:powid:ALLOW','powid:powid:LENGTH','powid:powid:WORDS'
          ,'powscore:powscore:LEFTTRIM','powscore:powscore:ALLOW','powscore:powscore:LENGTH','powscore:powscore:WORDS'
          ,'powweight:powweight:LEFTTRIM','powweight:powweight:ALLOW','powweight:powweight:LENGTH','powweight:powweight:WORDS'
          ,'proxid:proxid:LEFTTRIM','proxid:proxid:ALLOW','proxid:proxid:LENGTH','proxid:proxid:WORDS'
          ,'proxscore:proxscore:LEFTTRIM','proxscore:proxscore:ALLOW','proxscore:proxscore:LENGTH','proxscore:proxscore:WORDS'
          ,'proxweight:proxweight:LEFTTRIM','proxweight:proxweight:ALLOW','proxweight:proxweight:LENGTH','proxweight:proxweight:WORDS'
          ,'seleid:seleid:LEFTTRIM','seleid:seleid:ALLOW','seleid:seleid:LENGTH','seleid:seleid:WORDS'
          ,'selescore:selescore:LEFTTRIM','selescore:selescore:ALLOW','selescore:selescore:LENGTH','selescore:selescore:WORDS'
          ,'seleweight:seleweight:LEFTTRIM','seleweight:seleweight:ALLOW','seleweight:seleweight:LENGTH','seleweight:seleweight:WORDS'
          ,'orgid:orgid:LEFTTRIM','orgid:orgid:ALLOW','orgid:orgid:LENGTH','orgid:orgid:WORDS'
          ,'orgscore:orgscore:LEFTTRIM','orgscore:orgscore:ALLOW','orgscore:orgscore:LENGTH','orgscore:orgscore:WORDS'
          ,'orgweight:orgweight:LEFTTRIM','orgweight:orgweight:ALLOW','orgweight:orgweight:LENGTH','orgweight:orgweight:WORDS'
          ,'ultid:ultid:LEFTTRIM','ultid:ultid:ALLOW','ultid:ultid:LENGTH','ultid:ultid:WORDS'
          ,'ultscore:ultscore:LEFTTRIM','ultscore:ultscore:ALLOW','ultscore:ultscore:LENGTH','ultscore:ultscore:WORDS'
          ,'ultweight:ultweight:LEFTTRIM','ultweight:ultweight:ALLOW','ultweight:ultweight:LENGTH','ultweight:ultweight:WORDS','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_did(1),Fields.InvalidMessage_did(2),Fields.InvalidMessage_did(3),Fields.InvalidMessage_did(4)
          ,Fields.InvalidMessage_did_score(1),Fields.InvalidMessage_did_score(2),Fields.InvalidMessage_did_score(3),Fields.InvalidMessage_did_score(4)
          ,Fields.InvalidMessage_bdid(1),Fields.InvalidMessage_bdid(2),Fields.InvalidMessage_bdid(3),Fields.InvalidMessage_bdid(4)
          ,Fields.InvalidMessage_bdid_score(1),Fields.InvalidMessage_bdid_score(2),Fields.InvalidMessage_bdid_score(3),Fields.InvalidMessage_bdid_score(4)
          ,Fields.InvalidMessage_best_dob(1),Fields.InvalidMessage_best_dob(2),Fields.InvalidMessage_best_dob(3),Fields.InvalidMessage_best_dob(4)
          ,Fields.InvalidMessage_best_ssn(1),Fields.InvalidMessage_best_ssn(2),Fields.InvalidMessage_best_ssn(3),Fields.InvalidMessage_best_ssn(4)
          ,Fields.InvalidMessage_data_state(1),Fields.InvalidMessage_data_state(2),Fields.InvalidMessage_data_state(3),Fields.InvalidMessage_data_state(4)
          ,Fields.InvalidMessage_provider_name(1),Fields.InvalidMessage_provider_name(2)
          ,Fields.InvalidMessage_license_number(1),Fields.InvalidMessage_license_number(2),Fields.InvalidMessage_license_number(3)
          ,Fields.InvalidMessage_npi(1),Fields.InvalidMessage_npi(2),Fields.InvalidMessage_npi(3),Fields.InvalidMessage_npi(4)
          ,Fields.InvalidMessage_providertype(1),Fields.InvalidMessage_providertype(2)
          ,Fields.InvalidMessage_name(1),Fields.InvalidMessage_name(2),Fields.InvalidMessage_name(3)
          ,Fields.InvalidMessage_speciality(1),Fields.InvalidMessage_speciality(2)
          ,Fields.InvalidMessage_status(1),Fields.InvalidMessage_status(2),Fields.InvalidMessage_status(3),Fields.InvalidMessage_status(4)
          ,Fields.InvalidMessage_address1(1),Fields.InvalidMessage_address1(2)
          ,Fields.InvalidMessage_address2(1),Fields.InvalidMessage_address2(2)
          ,Fields.InvalidMessage_address3(1),Fields.InvalidMessage_address3(2),Fields.InvalidMessage_address3(3),Fields.InvalidMessage_address3(4)
          ,Fields.InvalidMessage_officecity(1),Fields.InvalidMessage_officecity(2)
          ,Fields.InvalidMessage_officestate(1),Fields.InvalidMessage_officestate(2),Fields.InvalidMessage_officestate(3),Fields.InvalidMessage_officestate(4)
          ,Fields.InvalidMessage_officezipcode(1),Fields.InvalidMessage_officezipcode(2),Fields.InvalidMessage_officezipcode(3),Fields.InvalidMessage_officezipcode(4)
          ,Fields.InvalidMessage_entity_type_code(1),Fields.InvalidMessage_entity_type_code(2),Fields.InvalidMessage_entity_type_code(3),Fields.InvalidMessage_entity_type_code(4)
          ,Fields.InvalidMessage_companyname(1),Fields.InvalidMessage_companyname(2)
          ,Fields.InvalidMessage_src(1),Fields.InvalidMessage_src(2),Fields.InvalidMessage_src(3),Fields.InvalidMessage_src(4)
          ,Fields.InvalidMessage_dt_vendor_first_reported(1),Fields.InvalidMessage_dt_vendor_first_reported(2),Fields.InvalidMessage_dt_vendor_first_reported(3),Fields.InvalidMessage_dt_vendor_first_reported(4)
          ,Fields.InvalidMessage_dt_vendor_last_reported(1),Fields.InvalidMessage_dt_vendor_last_reported(2),Fields.InvalidMessage_dt_vendor_last_reported(3),Fields.InvalidMessage_dt_vendor_last_reported(4)
          ,Fields.InvalidMessage_dt_first_seen(1),Fields.InvalidMessage_dt_first_seen(2),Fields.InvalidMessage_dt_first_seen(3),Fields.InvalidMessage_dt_first_seen(4)
          ,Fields.InvalidMessage_dt_last_seen(1),Fields.InvalidMessage_dt_last_seen(2),Fields.InvalidMessage_dt_last_seen(3),Fields.InvalidMessage_dt_last_seen(4)
          ,Fields.InvalidMessage_record_type(1),Fields.InvalidMessage_record_type(2),Fields.InvalidMessage_record_type(3),Fields.InvalidMessage_record_type(4)
          ,Fields.InvalidMessage_source_rid(1),Fields.InvalidMessage_source_rid(2),Fields.InvalidMessage_source_rid(3),Fields.InvalidMessage_source_rid(4)
          ,Fields.InvalidMessage_lnpid(1),Fields.InvalidMessage_lnpid(2),Fields.InvalidMessage_lnpid(3),Fields.InvalidMessage_lnpid(4)
          ,Fields.InvalidMessage_title(1),Fields.InvalidMessage_title(2),Fields.InvalidMessage_title(3),Fields.InvalidMessage_title(4)
          ,Fields.InvalidMessage_fname(1),Fields.InvalidMessage_fname(2),Fields.InvalidMessage_fname(3)
          ,Fields.InvalidMessage_mname(1),Fields.InvalidMessage_mname(2),Fields.InvalidMessage_mname(3),Fields.InvalidMessage_mname(4)
          ,Fields.InvalidMessage_lname(1),Fields.InvalidMessage_lname(2),Fields.InvalidMessage_lname(3)
          ,Fields.InvalidMessage_name_suffix(1),Fields.InvalidMessage_name_suffix(2),Fields.InvalidMessage_name_suffix(3),Fields.InvalidMessage_name_suffix(4)
          ,Fields.InvalidMessage_name_type(1),Fields.InvalidMessage_name_type(2),Fields.InvalidMessage_name_type(3),Fields.InvalidMessage_name_type(4)
          ,Fields.InvalidMessage_nid(1),Fields.InvalidMessage_nid(2),Fields.InvalidMessage_nid(3),Fields.InvalidMessage_nid(4)
          ,Fields.InvalidMessage_clean_clinic_name(1),Fields.InvalidMessage_clean_clinic_name(2),Fields.InvalidMessage_clean_clinic_name(3),Fields.InvalidMessage_clean_clinic_name(4)
          ,Fields.InvalidMessage_prepped_addr1(1),Fields.InvalidMessage_prepped_addr1(2),Fields.InvalidMessage_prepped_addr1(3)
          ,Fields.InvalidMessage_prepped_addr2(1),Fields.InvalidMessage_prepped_addr2(2)
          ,Fields.InvalidMessage_prim_range(1),Fields.InvalidMessage_prim_range(2),Fields.InvalidMessage_prim_range(3),Fields.InvalidMessage_prim_range(4)
          ,Fields.InvalidMessage_predir(1),Fields.InvalidMessage_predir(2),Fields.InvalidMessage_predir(3),Fields.InvalidMessage_predir(4)
          ,Fields.InvalidMessage_prim_name(1),Fields.InvalidMessage_prim_name(2),Fields.InvalidMessage_prim_name(3),Fields.InvalidMessage_prim_name(4)
          ,Fields.InvalidMessage_addr_suffix(1),Fields.InvalidMessage_addr_suffix(2),Fields.InvalidMessage_addr_suffix(3),Fields.InvalidMessage_addr_suffix(4)
          ,Fields.InvalidMessage_postdir(1),Fields.InvalidMessage_postdir(2),Fields.InvalidMessage_postdir(3),Fields.InvalidMessage_postdir(4)
          ,Fields.InvalidMessage_unit_desig(1),Fields.InvalidMessage_unit_desig(2),Fields.InvalidMessage_unit_desig(3),Fields.InvalidMessage_unit_desig(4)
          ,Fields.InvalidMessage_sec_range(1),Fields.InvalidMessage_sec_range(2),Fields.InvalidMessage_sec_range(3),Fields.InvalidMessage_sec_range(4)
          ,Fields.InvalidMessage_p_city_name(1),Fields.InvalidMessage_p_city_name(2),Fields.InvalidMessage_p_city_name(3)
          ,Fields.InvalidMessage_v_city_name(1),Fields.InvalidMessage_v_city_name(2),Fields.InvalidMessage_v_city_name(3)
          ,Fields.InvalidMessage_st(1),Fields.InvalidMessage_st(2),Fields.InvalidMessage_st(3),Fields.InvalidMessage_st(4)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2),Fields.InvalidMessage_zip(3),Fields.InvalidMessage_zip(4)
          ,Fields.InvalidMessage_zip4(1),Fields.InvalidMessage_zip4(2),Fields.InvalidMessage_zip4(3),Fields.InvalidMessage_zip4(4)
          ,Fields.InvalidMessage_cart(1),Fields.InvalidMessage_cart(2),Fields.InvalidMessage_cart(3),Fields.InvalidMessage_cart(4)
          ,Fields.InvalidMessage_cr_sort_sz(1),Fields.InvalidMessage_cr_sort_sz(2),Fields.InvalidMessage_cr_sort_sz(3),Fields.InvalidMessage_cr_sort_sz(4)
          ,Fields.InvalidMessage_lot(1),Fields.InvalidMessage_lot(2),Fields.InvalidMessage_lot(3),Fields.InvalidMessage_lot(4)
          ,Fields.InvalidMessage_lot_order(1),Fields.InvalidMessage_lot_order(2),Fields.InvalidMessage_lot_order(3),Fields.InvalidMessage_lot_order(4)
          ,Fields.InvalidMessage_dbpc(1),Fields.InvalidMessage_dbpc(2),Fields.InvalidMessage_dbpc(3),Fields.InvalidMessage_dbpc(4)
          ,Fields.InvalidMessage_chk_digit(1),Fields.InvalidMessage_chk_digit(2),Fields.InvalidMessage_chk_digit(3),Fields.InvalidMessage_chk_digit(4)
          ,Fields.InvalidMessage_rec_type(1),Fields.InvalidMessage_rec_type(2),Fields.InvalidMessage_rec_type(3),Fields.InvalidMessage_rec_type(4)
          ,Fields.InvalidMessage_fips_st(1),Fields.InvalidMessage_fips_st(2),Fields.InvalidMessage_fips_st(3),Fields.InvalidMessage_fips_st(4)
          ,Fields.InvalidMessage_fips_county(1),Fields.InvalidMessage_fips_county(2),Fields.InvalidMessage_fips_county(3),Fields.InvalidMessage_fips_county(4)
          ,Fields.InvalidMessage_geo_lat(1),Fields.InvalidMessage_geo_lat(2),Fields.InvalidMessage_geo_lat(3),Fields.InvalidMessage_geo_lat(4)
          ,Fields.InvalidMessage_geo_long(1),Fields.InvalidMessage_geo_long(2),Fields.InvalidMessage_geo_long(3),Fields.InvalidMessage_geo_long(4)
          ,Fields.InvalidMessage_msa(1),Fields.InvalidMessage_msa(2),Fields.InvalidMessage_msa(3),Fields.InvalidMessage_msa(4)
          ,Fields.InvalidMessage_geo_blk(1),Fields.InvalidMessage_geo_blk(2),Fields.InvalidMessage_geo_blk(3),Fields.InvalidMessage_geo_blk(4)
          ,Fields.InvalidMessage_geo_match(1),Fields.InvalidMessage_geo_match(2),Fields.InvalidMessage_geo_match(3),Fields.InvalidMessage_geo_match(4)
          ,Fields.InvalidMessage_err_stat(1),Fields.InvalidMessage_err_stat(2),Fields.InvalidMessage_err_stat(3),Fields.InvalidMessage_err_stat(4)
          ,Fields.InvalidMessage_rawaid(1),Fields.InvalidMessage_rawaid(2),Fields.InvalidMessage_rawaid(3),Fields.InvalidMessage_rawaid(4)
          ,Fields.InvalidMessage_aceaid(1),Fields.InvalidMessage_aceaid(2),Fields.InvalidMessage_aceaid(3),Fields.InvalidMessage_aceaid(4)
          ,Fields.InvalidMessage_clean_phone(1),Fields.InvalidMessage_clean_phone(2),Fields.InvalidMessage_clean_phone(3),Fields.InvalidMessage_clean_phone(4)
          ,Fields.InvalidMessage_dotid(1),Fields.InvalidMessage_dotid(2),Fields.InvalidMessage_dotid(3),Fields.InvalidMessage_dotid(4)
          ,Fields.InvalidMessage_dotscore(1),Fields.InvalidMessage_dotscore(2),Fields.InvalidMessage_dotscore(3),Fields.InvalidMessage_dotscore(4)
          ,Fields.InvalidMessage_dotweight(1),Fields.InvalidMessage_dotweight(2),Fields.InvalidMessage_dotweight(3),Fields.InvalidMessage_dotweight(4)
          ,Fields.InvalidMessage_empid(1),Fields.InvalidMessage_empid(2),Fields.InvalidMessage_empid(3),Fields.InvalidMessage_empid(4)
          ,Fields.InvalidMessage_empscore(1),Fields.InvalidMessage_empscore(2),Fields.InvalidMessage_empscore(3),Fields.InvalidMessage_empscore(4)
          ,Fields.InvalidMessage_empweight(1),Fields.InvalidMessage_empweight(2),Fields.InvalidMessage_empweight(3),Fields.InvalidMessage_empweight(4)
          ,Fields.InvalidMessage_powid(1),Fields.InvalidMessage_powid(2),Fields.InvalidMessage_powid(3),Fields.InvalidMessage_powid(4)
          ,Fields.InvalidMessage_powscore(1),Fields.InvalidMessage_powscore(2),Fields.InvalidMessage_powscore(3),Fields.InvalidMessage_powscore(4)
          ,Fields.InvalidMessage_powweight(1),Fields.InvalidMessage_powweight(2),Fields.InvalidMessage_powweight(3),Fields.InvalidMessage_powweight(4)
          ,Fields.InvalidMessage_proxid(1),Fields.InvalidMessage_proxid(2),Fields.InvalidMessage_proxid(3),Fields.InvalidMessage_proxid(4)
          ,Fields.InvalidMessage_proxscore(1),Fields.InvalidMessage_proxscore(2),Fields.InvalidMessage_proxscore(3),Fields.InvalidMessage_proxscore(4)
          ,Fields.InvalidMessage_proxweight(1),Fields.InvalidMessage_proxweight(2),Fields.InvalidMessage_proxweight(3),Fields.InvalidMessage_proxweight(4)
          ,Fields.InvalidMessage_seleid(1),Fields.InvalidMessage_seleid(2),Fields.InvalidMessage_seleid(3),Fields.InvalidMessage_seleid(4)
          ,Fields.InvalidMessage_selescore(1),Fields.InvalidMessage_selescore(2),Fields.InvalidMessage_selescore(3),Fields.InvalidMessage_selescore(4)
          ,Fields.InvalidMessage_seleweight(1),Fields.InvalidMessage_seleweight(2),Fields.InvalidMessage_seleweight(3),Fields.InvalidMessage_seleweight(4)
          ,Fields.InvalidMessage_orgid(1),Fields.InvalidMessage_orgid(2),Fields.InvalidMessage_orgid(3),Fields.InvalidMessage_orgid(4)
          ,Fields.InvalidMessage_orgscore(1),Fields.InvalidMessage_orgscore(2),Fields.InvalidMessage_orgscore(3),Fields.InvalidMessage_orgscore(4)
          ,Fields.InvalidMessage_orgweight(1),Fields.InvalidMessage_orgweight(2),Fields.InvalidMessage_orgweight(3),Fields.InvalidMessage_orgweight(4)
          ,Fields.InvalidMessage_ultid(1),Fields.InvalidMessage_ultid(2),Fields.InvalidMessage_ultid(3),Fields.InvalidMessage_ultid(4)
          ,Fields.InvalidMessage_ultscore(1),Fields.InvalidMessage_ultscore(2),Fields.InvalidMessage_ultscore(3),Fields.InvalidMessage_ultscore(4)
          ,Fields.InvalidMessage_ultweight(1),Fields.InvalidMessage_ultweight(2),Fields.InvalidMessage_ultweight(3),Fields.InvalidMessage_ultweight(4),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount,le.did_LENGTH_ErrorCount,le.did_WORDS_ErrorCount
          ,le.did_score_LEFTTRIM_ErrorCount,le.did_score_ALLOW_ErrorCount,le.did_score_LENGTH_ErrorCount,le.did_score_WORDS_ErrorCount
          ,le.bdid_LEFTTRIM_ErrorCount,le.bdid_ALLOW_ErrorCount,le.bdid_LENGTH_ErrorCount,le.bdid_WORDS_ErrorCount
          ,le.bdid_score_LEFTTRIM_ErrorCount,le.bdid_score_ALLOW_ErrorCount,le.bdid_score_LENGTH_ErrorCount,le.bdid_score_WORDS_ErrorCount
          ,le.best_dob_LEFTTRIM_ErrorCount,le.best_dob_ALLOW_ErrorCount,le.best_dob_LENGTH_ErrorCount,le.best_dob_WORDS_ErrorCount
          ,le.best_ssn_LEFTTRIM_ErrorCount,le.best_ssn_ALLOW_ErrorCount,le.best_ssn_LENGTH_ErrorCount,le.best_ssn_WORDS_ErrorCount
          ,le.data_state_LEFTTRIM_ErrorCount,le.data_state_ALLOW_ErrorCount,le.data_state_LENGTH_ErrorCount,le.data_state_WORDS_ErrorCount
          ,le.provider_name_LEFTTRIM_ErrorCount,le.provider_name_ALLOW_ErrorCount
          ,le.license_number_LEFTTRIM_ErrorCount,le.license_number_ALLOW_ErrorCount,le.license_number_WORDS_ErrorCount
          ,le.npi_LEFTTRIM_ErrorCount,le.npi_ALLOW_ErrorCount,le.npi_LENGTH_ErrorCount,le.npi_WORDS_ErrorCount
          ,le.providertype_LEFTTRIM_ErrorCount,le.providertype_ALLOW_ErrorCount
          ,le.name_LEFTTRIM_ErrorCount,le.name_ALLOW_ErrorCount,le.name_WORDS_ErrorCount
          ,le.speciality_LEFTTRIM_ErrorCount,le.speciality_ALLOW_ErrorCount
          ,le.status_LEFTTRIM_ErrorCount,le.status_ALLOW_ErrorCount,le.status_LENGTH_ErrorCount,le.status_WORDS_ErrorCount
          ,le.address1_LEFTTRIM_ErrorCount,le.address1_ALLOW_ErrorCount
          ,le.address2_LEFTTRIM_ErrorCount,le.address2_ALLOW_ErrorCount
          ,le.address3_LEFTTRIM_ErrorCount,le.address3_ALLOW_ErrorCount,le.address3_LENGTH_ErrorCount,le.address3_WORDS_ErrorCount
          ,le.officecity_LEFTTRIM_ErrorCount,le.officecity_ALLOW_ErrorCount
          ,le.officestate_LEFTTRIM_ErrorCount,le.officestate_ALLOW_ErrorCount,le.officestate_LENGTH_ErrorCount,le.officestate_WORDS_ErrorCount
          ,le.officezipcode_LEFTTRIM_ErrorCount,le.officezipcode_ALLOW_ErrorCount,le.officezipcode_LENGTH_ErrorCount,le.officezipcode_WORDS_ErrorCount
          ,le.entity_type_code_LEFTTRIM_ErrorCount,le.entity_type_code_ALLOW_ErrorCount,le.entity_type_code_LENGTH_ErrorCount,le.entity_type_code_WORDS_ErrorCount
          ,le.companyname_LEFTTRIM_ErrorCount,le.companyname_ALLOW_ErrorCount
          ,le.src_LEFTTRIM_ErrorCount,le.src_ALLOW_ErrorCount,le.src_LENGTH_ErrorCount,le.src_WORDS_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount,le.dt_vendor_first_reported_WORDS_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount,le.dt_vendor_last_reported_WORDS_ErrorCount
          ,le.dt_first_seen_LEFTTRIM_ErrorCount,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount,le.dt_first_seen_WORDS_ErrorCount
          ,le.dt_last_seen_LEFTTRIM_ErrorCount,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount,le.dt_last_seen_WORDS_ErrorCount
          ,le.record_type_LEFTTRIM_ErrorCount,le.record_type_ALLOW_ErrorCount,le.record_type_LENGTH_ErrorCount,le.record_type_WORDS_ErrorCount
          ,le.source_rid_LEFTTRIM_ErrorCount,le.source_rid_ALLOW_ErrorCount,le.source_rid_LENGTH_ErrorCount,le.source_rid_WORDS_ErrorCount
          ,le.lnpid_LEFTTRIM_ErrorCount,le.lnpid_ALLOW_ErrorCount,le.lnpid_LENGTH_ErrorCount,le.lnpid_WORDS_ErrorCount
          ,le.title_LEFTTRIM_ErrorCount,le.title_ALLOW_ErrorCount,le.title_LENGTH_ErrorCount,le.title_WORDS_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_WORDS_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount,le.mname_WORDS_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_WORDS_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.name_type_LEFTTRIM_ErrorCount,le.name_type_ALLOW_ErrorCount,le.name_type_LENGTH_ErrorCount,le.name_type_WORDS_ErrorCount
          ,le.nid_LEFTTRIM_ErrorCount,le.nid_ALLOW_ErrorCount,le.nid_LENGTH_ErrorCount,le.nid_WORDS_ErrorCount
          ,le.clean_clinic_name_LEFTTRIM_ErrorCount,le.clean_clinic_name_ALLOW_ErrorCount,le.clean_clinic_name_LENGTH_ErrorCount,le.clean_clinic_name_WORDS_ErrorCount
          ,le.prepped_addr1_LEFTTRIM_ErrorCount,le.prepped_addr1_ALLOW_ErrorCount,le.prepped_addr1_WORDS_ErrorCount
          ,le.prepped_addr2_LEFTTRIM_ErrorCount,le.prepped_addr2_ALLOW_ErrorCount
          ,le.prim_range_LEFTTRIM_ErrorCount,le.prim_range_ALLOW_ErrorCount,le.prim_range_LENGTH_ErrorCount,le.prim_range_WORDS_ErrorCount
          ,le.predir_LEFTTRIM_ErrorCount,le.predir_ALLOW_ErrorCount,le.predir_LENGTH_ErrorCount,le.predir_WORDS_ErrorCount
          ,le.prim_name_LEFTTRIM_ErrorCount,le.prim_name_ALLOW_ErrorCount,le.prim_name_LENGTH_ErrorCount,le.prim_name_WORDS_ErrorCount
          ,le.addr_suffix_LEFTTRIM_ErrorCount,le.addr_suffix_ALLOW_ErrorCount,le.addr_suffix_LENGTH_ErrorCount,le.addr_suffix_WORDS_ErrorCount
          ,le.postdir_LEFTTRIM_ErrorCount,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTH_ErrorCount,le.postdir_WORDS_ErrorCount
          ,le.unit_desig_LEFTTRIM_ErrorCount,le.unit_desig_ALLOW_ErrorCount,le.unit_desig_LENGTH_ErrorCount,le.unit_desig_WORDS_ErrorCount
          ,le.sec_range_LEFTTRIM_ErrorCount,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTH_ErrorCount,le.sec_range_WORDS_ErrorCount
          ,le.p_city_name_LEFTTRIM_ErrorCount,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_WORDS_ErrorCount
          ,le.v_city_name_LEFTTRIM_ErrorCount,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_WORDS_ErrorCount
          ,le.st_LEFTTRIM_ErrorCount,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount,le.st_WORDS_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount,le.zip_WORDS_ErrorCount
          ,le.zip4_LEFTTRIM_ErrorCount,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount,le.zip4_WORDS_ErrorCount
          ,le.cart_LEFTTRIM_ErrorCount,le.cart_ALLOW_ErrorCount,le.cart_LENGTH_ErrorCount,le.cart_WORDS_ErrorCount
          ,le.cr_sort_sz_LEFTTRIM_ErrorCount,le.cr_sort_sz_ALLOW_ErrorCount,le.cr_sort_sz_LENGTH_ErrorCount,le.cr_sort_sz_WORDS_ErrorCount
          ,le.lot_LEFTTRIM_ErrorCount,le.lot_ALLOW_ErrorCount,le.lot_LENGTH_ErrorCount,le.lot_WORDS_ErrorCount
          ,le.lot_order_LEFTTRIM_ErrorCount,le.lot_order_ALLOW_ErrorCount,le.lot_order_LENGTH_ErrorCount,le.lot_order_WORDS_ErrorCount
          ,le.dbpc_LEFTTRIM_ErrorCount,le.dbpc_ALLOW_ErrorCount,le.dbpc_LENGTH_ErrorCount,le.dbpc_WORDS_ErrorCount
          ,le.chk_digit_LEFTTRIM_ErrorCount,le.chk_digit_ALLOW_ErrorCount,le.chk_digit_LENGTH_ErrorCount,le.chk_digit_WORDS_ErrorCount
          ,le.rec_type_LEFTTRIM_ErrorCount,le.rec_type_ALLOW_ErrorCount,le.rec_type_LENGTH_ErrorCount,le.rec_type_WORDS_ErrorCount
          ,le.fips_st_LEFTTRIM_ErrorCount,le.fips_st_ALLOW_ErrorCount,le.fips_st_LENGTH_ErrorCount,le.fips_st_WORDS_ErrorCount
          ,le.fips_county_LEFTTRIM_ErrorCount,le.fips_county_ALLOW_ErrorCount,le.fips_county_LENGTH_ErrorCount,le.fips_county_WORDS_ErrorCount
          ,le.geo_lat_LEFTTRIM_ErrorCount,le.geo_lat_ALLOW_ErrorCount,le.geo_lat_LENGTH_ErrorCount,le.geo_lat_WORDS_ErrorCount
          ,le.geo_long_LEFTTRIM_ErrorCount,le.geo_long_ALLOW_ErrorCount,le.geo_long_LENGTH_ErrorCount,le.geo_long_WORDS_ErrorCount
          ,le.msa_LEFTTRIM_ErrorCount,le.msa_ALLOW_ErrorCount,le.msa_LENGTH_ErrorCount,le.msa_WORDS_ErrorCount
          ,le.geo_blk_LEFTTRIM_ErrorCount,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTH_ErrorCount,le.geo_blk_WORDS_ErrorCount
          ,le.geo_match_LEFTTRIM_ErrorCount,le.geo_match_ALLOW_ErrorCount,le.geo_match_LENGTH_ErrorCount,le.geo_match_WORDS_ErrorCount
          ,le.err_stat_LEFTTRIM_ErrorCount,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTH_ErrorCount,le.err_stat_WORDS_ErrorCount
          ,le.rawaid_LEFTTRIM_ErrorCount,le.rawaid_ALLOW_ErrorCount,le.rawaid_LENGTH_ErrorCount,le.rawaid_WORDS_ErrorCount
          ,le.aceaid_LEFTTRIM_ErrorCount,le.aceaid_ALLOW_ErrorCount,le.aceaid_LENGTH_ErrorCount,le.aceaid_WORDS_ErrorCount
          ,le.clean_phone_LEFTTRIM_ErrorCount,le.clean_phone_ALLOW_ErrorCount,le.clean_phone_LENGTH_ErrorCount,le.clean_phone_WORDS_ErrorCount
          ,le.dotid_LEFTTRIM_ErrorCount,le.dotid_ALLOW_ErrorCount,le.dotid_LENGTH_ErrorCount,le.dotid_WORDS_ErrorCount
          ,le.dotscore_LEFTTRIM_ErrorCount,le.dotscore_ALLOW_ErrorCount,le.dotscore_LENGTH_ErrorCount,le.dotscore_WORDS_ErrorCount
          ,le.dotweight_LEFTTRIM_ErrorCount,le.dotweight_ALLOW_ErrorCount,le.dotweight_LENGTH_ErrorCount,le.dotweight_WORDS_ErrorCount
          ,le.empid_LEFTTRIM_ErrorCount,le.empid_ALLOW_ErrorCount,le.empid_LENGTH_ErrorCount,le.empid_WORDS_ErrorCount
          ,le.empscore_LEFTTRIM_ErrorCount,le.empscore_ALLOW_ErrorCount,le.empscore_LENGTH_ErrorCount,le.empscore_WORDS_ErrorCount
          ,le.empweight_LEFTTRIM_ErrorCount,le.empweight_ALLOW_ErrorCount,le.empweight_LENGTH_ErrorCount,le.empweight_WORDS_ErrorCount
          ,le.powid_LEFTTRIM_ErrorCount,le.powid_ALLOW_ErrorCount,le.powid_LENGTH_ErrorCount,le.powid_WORDS_ErrorCount
          ,le.powscore_LEFTTRIM_ErrorCount,le.powscore_ALLOW_ErrorCount,le.powscore_LENGTH_ErrorCount,le.powscore_WORDS_ErrorCount
          ,le.powweight_LEFTTRIM_ErrorCount,le.powweight_ALLOW_ErrorCount,le.powweight_LENGTH_ErrorCount,le.powweight_WORDS_ErrorCount
          ,le.proxid_LEFTTRIM_ErrorCount,le.proxid_ALLOW_ErrorCount,le.proxid_LENGTH_ErrorCount,le.proxid_WORDS_ErrorCount
          ,le.proxscore_LEFTTRIM_ErrorCount,le.proxscore_ALLOW_ErrorCount,le.proxscore_LENGTH_ErrorCount,le.proxscore_WORDS_ErrorCount
          ,le.proxweight_LEFTTRIM_ErrorCount,le.proxweight_ALLOW_ErrorCount,le.proxweight_LENGTH_ErrorCount,le.proxweight_WORDS_ErrorCount
          ,le.seleid_LEFTTRIM_ErrorCount,le.seleid_ALLOW_ErrorCount,le.seleid_LENGTH_ErrorCount,le.seleid_WORDS_ErrorCount
          ,le.selescore_LEFTTRIM_ErrorCount,le.selescore_ALLOW_ErrorCount,le.selescore_LENGTH_ErrorCount,le.selescore_WORDS_ErrorCount
          ,le.seleweight_LEFTTRIM_ErrorCount,le.seleweight_ALLOW_ErrorCount,le.seleweight_LENGTH_ErrorCount,le.seleweight_WORDS_ErrorCount
          ,le.orgid_LEFTTRIM_ErrorCount,le.orgid_ALLOW_ErrorCount,le.orgid_LENGTH_ErrorCount,le.orgid_WORDS_ErrorCount
          ,le.orgscore_LEFTTRIM_ErrorCount,le.orgscore_ALLOW_ErrorCount,le.orgscore_LENGTH_ErrorCount,le.orgscore_WORDS_ErrorCount
          ,le.orgweight_LEFTTRIM_ErrorCount,le.orgweight_ALLOW_ErrorCount,le.orgweight_LENGTH_ErrorCount,le.orgweight_WORDS_ErrorCount
          ,le.ultid_LEFTTRIM_ErrorCount,le.ultid_ALLOW_ErrorCount,le.ultid_LENGTH_ErrorCount,le.ultid_WORDS_ErrorCount
          ,le.ultscore_LEFTTRIM_ErrorCount,le.ultscore_ALLOW_ErrorCount,le.ultscore_LENGTH_ErrorCount,le.ultscore_WORDS_ErrorCount
          ,le.ultweight_LEFTTRIM_ErrorCount,le.ultweight_ALLOW_ErrorCount,le.ultweight_LENGTH_ErrorCount,le.ultweight_WORDS_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount,le.did_LENGTH_ErrorCount,le.did_WORDS_ErrorCount
          ,le.did_score_LEFTTRIM_ErrorCount,le.did_score_ALLOW_ErrorCount,le.did_score_LENGTH_ErrorCount,le.did_score_WORDS_ErrorCount
          ,le.bdid_LEFTTRIM_ErrorCount,le.bdid_ALLOW_ErrorCount,le.bdid_LENGTH_ErrorCount,le.bdid_WORDS_ErrorCount
          ,le.bdid_score_LEFTTRIM_ErrorCount,le.bdid_score_ALLOW_ErrorCount,le.bdid_score_LENGTH_ErrorCount,le.bdid_score_WORDS_ErrorCount
          ,le.best_dob_LEFTTRIM_ErrorCount,le.best_dob_ALLOW_ErrorCount,le.best_dob_LENGTH_ErrorCount,le.best_dob_WORDS_ErrorCount
          ,le.best_ssn_LEFTTRIM_ErrorCount,le.best_ssn_ALLOW_ErrorCount,le.best_ssn_LENGTH_ErrorCount,le.best_ssn_WORDS_ErrorCount
          ,le.data_state_LEFTTRIM_ErrorCount,le.data_state_ALLOW_ErrorCount,le.data_state_LENGTH_ErrorCount,le.data_state_WORDS_ErrorCount
          ,le.provider_name_LEFTTRIM_ErrorCount,le.provider_name_ALLOW_ErrorCount
          ,le.license_number_LEFTTRIM_ErrorCount,le.license_number_ALLOW_ErrorCount,le.license_number_WORDS_ErrorCount
          ,le.npi_LEFTTRIM_ErrorCount,le.npi_ALLOW_ErrorCount,le.npi_LENGTH_ErrorCount,le.npi_WORDS_ErrorCount
          ,le.providertype_LEFTTRIM_ErrorCount,le.providertype_ALLOW_ErrorCount
          ,le.name_LEFTTRIM_ErrorCount,le.name_ALLOW_ErrorCount,le.name_WORDS_ErrorCount
          ,le.speciality_LEFTTRIM_ErrorCount,le.speciality_ALLOW_ErrorCount
          ,le.status_LEFTTRIM_ErrorCount,le.status_ALLOW_ErrorCount,le.status_LENGTH_ErrorCount,le.status_WORDS_ErrorCount
          ,le.address1_LEFTTRIM_ErrorCount,le.address1_ALLOW_ErrorCount
          ,le.address2_LEFTTRIM_ErrorCount,le.address2_ALLOW_ErrorCount
          ,le.address3_LEFTTRIM_ErrorCount,le.address3_ALLOW_ErrorCount,le.address3_LENGTH_ErrorCount,le.address3_WORDS_ErrorCount
          ,le.officecity_LEFTTRIM_ErrorCount,le.officecity_ALLOW_ErrorCount
          ,le.officestate_LEFTTRIM_ErrorCount,le.officestate_ALLOW_ErrorCount,le.officestate_LENGTH_ErrorCount,le.officestate_WORDS_ErrorCount
          ,le.officezipcode_LEFTTRIM_ErrorCount,le.officezipcode_ALLOW_ErrorCount,le.officezipcode_LENGTH_ErrorCount,le.officezipcode_WORDS_ErrorCount
          ,le.entity_type_code_LEFTTRIM_ErrorCount,le.entity_type_code_ALLOW_ErrorCount,le.entity_type_code_LENGTH_ErrorCount,le.entity_type_code_WORDS_ErrorCount
          ,le.companyname_LEFTTRIM_ErrorCount,le.companyname_ALLOW_ErrorCount
          ,le.src_LEFTTRIM_ErrorCount,le.src_ALLOW_ErrorCount,le.src_LENGTH_ErrorCount,le.src_WORDS_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount,le.dt_vendor_first_reported_WORDS_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount,le.dt_vendor_last_reported_WORDS_ErrorCount
          ,le.dt_first_seen_LEFTTRIM_ErrorCount,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount,le.dt_first_seen_WORDS_ErrorCount
          ,le.dt_last_seen_LEFTTRIM_ErrorCount,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount,le.dt_last_seen_WORDS_ErrorCount
          ,le.record_type_LEFTTRIM_ErrorCount,le.record_type_ALLOW_ErrorCount,le.record_type_LENGTH_ErrorCount,le.record_type_WORDS_ErrorCount
          ,le.source_rid_LEFTTRIM_ErrorCount,le.source_rid_ALLOW_ErrorCount,le.source_rid_LENGTH_ErrorCount,le.source_rid_WORDS_ErrorCount
          ,le.lnpid_LEFTTRIM_ErrorCount,le.lnpid_ALLOW_ErrorCount,le.lnpid_LENGTH_ErrorCount,le.lnpid_WORDS_ErrorCount
          ,le.title_LEFTTRIM_ErrorCount,le.title_ALLOW_ErrorCount,le.title_LENGTH_ErrorCount,le.title_WORDS_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_WORDS_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount,le.mname_WORDS_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_WORDS_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.name_type_LEFTTRIM_ErrorCount,le.name_type_ALLOW_ErrorCount,le.name_type_LENGTH_ErrorCount,le.name_type_WORDS_ErrorCount
          ,le.nid_LEFTTRIM_ErrorCount,le.nid_ALLOW_ErrorCount,le.nid_LENGTH_ErrorCount,le.nid_WORDS_ErrorCount
          ,le.clean_clinic_name_LEFTTRIM_ErrorCount,le.clean_clinic_name_ALLOW_ErrorCount,le.clean_clinic_name_LENGTH_ErrorCount,le.clean_clinic_name_WORDS_ErrorCount
          ,le.prepped_addr1_LEFTTRIM_ErrorCount,le.prepped_addr1_ALLOW_ErrorCount,le.prepped_addr1_WORDS_ErrorCount
          ,le.prepped_addr2_LEFTTRIM_ErrorCount,le.prepped_addr2_ALLOW_ErrorCount
          ,le.prim_range_LEFTTRIM_ErrorCount,le.prim_range_ALLOW_ErrorCount,le.prim_range_LENGTH_ErrorCount,le.prim_range_WORDS_ErrorCount
          ,le.predir_LEFTTRIM_ErrorCount,le.predir_ALLOW_ErrorCount,le.predir_LENGTH_ErrorCount,le.predir_WORDS_ErrorCount
          ,le.prim_name_LEFTTRIM_ErrorCount,le.prim_name_ALLOW_ErrorCount,le.prim_name_LENGTH_ErrorCount,le.prim_name_WORDS_ErrorCount
          ,le.addr_suffix_LEFTTRIM_ErrorCount,le.addr_suffix_ALLOW_ErrorCount,le.addr_suffix_LENGTH_ErrorCount,le.addr_suffix_WORDS_ErrorCount
          ,le.postdir_LEFTTRIM_ErrorCount,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTH_ErrorCount,le.postdir_WORDS_ErrorCount
          ,le.unit_desig_LEFTTRIM_ErrorCount,le.unit_desig_ALLOW_ErrorCount,le.unit_desig_LENGTH_ErrorCount,le.unit_desig_WORDS_ErrorCount
          ,le.sec_range_LEFTTRIM_ErrorCount,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTH_ErrorCount,le.sec_range_WORDS_ErrorCount
          ,le.p_city_name_LEFTTRIM_ErrorCount,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_WORDS_ErrorCount
          ,le.v_city_name_LEFTTRIM_ErrorCount,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_WORDS_ErrorCount
          ,le.st_LEFTTRIM_ErrorCount,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount,le.st_WORDS_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount,le.zip_WORDS_ErrorCount
          ,le.zip4_LEFTTRIM_ErrorCount,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount,le.zip4_WORDS_ErrorCount
          ,le.cart_LEFTTRIM_ErrorCount,le.cart_ALLOW_ErrorCount,le.cart_LENGTH_ErrorCount,le.cart_WORDS_ErrorCount
          ,le.cr_sort_sz_LEFTTRIM_ErrorCount,le.cr_sort_sz_ALLOW_ErrorCount,le.cr_sort_sz_LENGTH_ErrorCount,le.cr_sort_sz_WORDS_ErrorCount
          ,le.lot_LEFTTRIM_ErrorCount,le.lot_ALLOW_ErrorCount,le.lot_LENGTH_ErrorCount,le.lot_WORDS_ErrorCount
          ,le.lot_order_LEFTTRIM_ErrorCount,le.lot_order_ALLOW_ErrorCount,le.lot_order_LENGTH_ErrorCount,le.lot_order_WORDS_ErrorCount
          ,le.dbpc_LEFTTRIM_ErrorCount,le.dbpc_ALLOW_ErrorCount,le.dbpc_LENGTH_ErrorCount,le.dbpc_WORDS_ErrorCount
          ,le.chk_digit_LEFTTRIM_ErrorCount,le.chk_digit_ALLOW_ErrorCount,le.chk_digit_LENGTH_ErrorCount,le.chk_digit_WORDS_ErrorCount
          ,le.rec_type_LEFTTRIM_ErrorCount,le.rec_type_ALLOW_ErrorCount,le.rec_type_LENGTH_ErrorCount,le.rec_type_WORDS_ErrorCount
          ,le.fips_st_LEFTTRIM_ErrorCount,le.fips_st_ALLOW_ErrorCount,le.fips_st_LENGTH_ErrorCount,le.fips_st_WORDS_ErrorCount
          ,le.fips_county_LEFTTRIM_ErrorCount,le.fips_county_ALLOW_ErrorCount,le.fips_county_LENGTH_ErrorCount,le.fips_county_WORDS_ErrorCount
          ,le.geo_lat_LEFTTRIM_ErrorCount,le.geo_lat_ALLOW_ErrorCount,le.geo_lat_LENGTH_ErrorCount,le.geo_lat_WORDS_ErrorCount
          ,le.geo_long_LEFTTRIM_ErrorCount,le.geo_long_ALLOW_ErrorCount,le.geo_long_LENGTH_ErrorCount,le.geo_long_WORDS_ErrorCount
          ,le.msa_LEFTTRIM_ErrorCount,le.msa_ALLOW_ErrorCount,le.msa_LENGTH_ErrorCount,le.msa_WORDS_ErrorCount
          ,le.geo_blk_LEFTTRIM_ErrorCount,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTH_ErrorCount,le.geo_blk_WORDS_ErrorCount
          ,le.geo_match_LEFTTRIM_ErrorCount,le.geo_match_ALLOW_ErrorCount,le.geo_match_LENGTH_ErrorCount,le.geo_match_WORDS_ErrorCount
          ,le.err_stat_LEFTTRIM_ErrorCount,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTH_ErrorCount,le.err_stat_WORDS_ErrorCount
          ,le.rawaid_LEFTTRIM_ErrorCount,le.rawaid_ALLOW_ErrorCount,le.rawaid_LENGTH_ErrorCount,le.rawaid_WORDS_ErrorCount
          ,le.aceaid_LEFTTRIM_ErrorCount,le.aceaid_ALLOW_ErrorCount,le.aceaid_LENGTH_ErrorCount,le.aceaid_WORDS_ErrorCount
          ,le.clean_phone_LEFTTRIM_ErrorCount,le.clean_phone_ALLOW_ErrorCount,le.clean_phone_LENGTH_ErrorCount,le.clean_phone_WORDS_ErrorCount
          ,le.dotid_LEFTTRIM_ErrorCount,le.dotid_ALLOW_ErrorCount,le.dotid_LENGTH_ErrorCount,le.dotid_WORDS_ErrorCount
          ,le.dotscore_LEFTTRIM_ErrorCount,le.dotscore_ALLOW_ErrorCount,le.dotscore_LENGTH_ErrorCount,le.dotscore_WORDS_ErrorCount
          ,le.dotweight_LEFTTRIM_ErrorCount,le.dotweight_ALLOW_ErrorCount,le.dotweight_LENGTH_ErrorCount,le.dotweight_WORDS_ErrorCount
          ,le.empid_LEFTTRIM_ErrorCount,le.empid_ALLOW_ErrorCount,le.empid_LENGTH_ErrorCount,le.empid_WORDS_ErrorCount
          ,le.empscore_LEFTTRIM_ErrorCount,le.empscore_ALLOW_ErrorCount,le.empscore_LENGTH_ErrorCount,le.empscore_WORDS_ErrorCount
          ,le.empweight_LEFTTRIM_ErrorCount,le.empweight_ALLOW_ErrorCount,le.empweight_LENGTH_ErrorCount,le.empweight_WORDS_ErrorCount
          ,le.powid_LEFTTRIM_ErrorCount,le.powid_ALLOW_ErrorCount,le.powid_LENGTH_ErrorCount,le.powid_WORDS_ErrorCount
          ,le.powscore_LEFTTRIM_ErrorCount,le.powscore_ALLOW_ErrorCount,le.powscore_LENGTH_ErrorCount,le.powscore_WORDS_ErrorCount
          ,le.powweight_LEFTTRIM_ErrorCount,le.powweight_ALLOW_ErrorCount,le.powweight_LENGTH_ErrorCount,le.powweight_WORDS_ErrorCount
          ,le.proxid_LEFTTRIM_ErrorCount,le.proxid_ALLOW_ErrorCount,le.proxid_LENGTH_ErrorCount,le.proxid_WORDS_ErrorCount
          ,le.proxscore_LEFTTRIM_ErrorCount,le.proxscore_ALLOW_ErrorCount,le.proxscore_LENGTH_ErrorCount,le.proxscore_WORDS_ErrorCount
          ,le.proxweight_LEFTTRIM_ErrorCount,le.proxweight_ALLOW_ErrorCount,le.proxweight_LENGTH_ErrorCount,le.proxweight_WORDS_ErrorCount
          ,le.seleid_LEFTTRIM_ErrorCount,le.seleid_ALLOW_ErrorCount,le.seleid_LENGTH_ErrorCount,le.seleid_WORDS_ErrorCount
          ,le.selescore_LEFTTRIM_ErrorCount,le.selescore_ALLOW_ErrorCount,le.selescore_LENGTH_ErrorCount,le.selescore_WORDS_ErrorCount
          ,le.seleweight_LEFTTRIM_ErrorCount,le.seleweight_ALLOW_ErrorCount,le.seleweight_LENGTH_ErrorCount,le.seleweight_WORDS_ErrorCount
          ,le.orgid_LEFTTRIM_ErrorCount,le.orgid_ALLOW_ErrorCount,le.orgid_LENGTH_ErrorCount,le.orgid_WORDS_ErrorCount
          ,le.orgscore_LEFTTRIM_ErrorCount,le.orgscore_ALLOW_ErrorCount,le.orgscore_LENGTH_ErrorCount,le.orgscore_WORDS_ErrorCount
          ,le.orgweight_LEFTTRIM_ErrorCount,le.orgweight_ALLOW_ErrorCount,le.orgweight_LENGTH_ErrorCount,le.orgweight_WORDS_ErrorCount
          ,le.ultid_LEFTTRIM_ErrorCount,le.ultid_ALLOW_ErrorCount,le.ultid_LENGTH_ErrorCount,le.ultid_WORDS_ErrorCount
          ,le.ultscore_LEFTTRIM_ErrorCount,le.ultscore_ALLOW_ErrorCount,le.ultscore_LENGTH_ErrorCount,le.ultscore_WORDS_ErrorCount
          ,le.ultweight_LEFTTRIM_ErrorCount,le.ultweight_ALLOW_ErrorCount,le.ultweight_LENGTH_ErrorCount,le.ultweight_WORDS_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,341,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT31.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT31.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;

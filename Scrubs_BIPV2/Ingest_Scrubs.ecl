IMPORT SALT311,STD;
IMPORT Scrubs_BIPV2,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Ingest_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 93;
  EXPORT NumRulesFromFieldType := 93;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 93;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Ingest_Layout_BIPV2)
    UNSIGNED1 source_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 rcid_Invalid;
    UNSIGNED1 company_bdid_Invalid;
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 company_name_type_raw_Invalid;
    UNSIGNED1 company_rawaid_Invalid;
    UNSIGNED1 company_address_predir_Invalid;
    UNSIGNED1 company_address_prim_name_Invalid;
    UNSIGNED1 company_address_postdir_Invalid;
    UNSIGNED1 company_address_p_city_name_Invalid;
    UNSIGNED1 company_address_v_city_name_Invalid;
    UNSIGNED1 company_address_st_Invalid;
    UNSIGNED1 company_address_zip_Invalid;
    UNSIGNED1 company_address_zip4_Invalid;
    UNSIGNED1 company_address_cart_Invalid;
    UNSIGNED1 company_address_cr_sort_sz_Invalid;
    UNSIGNED1 company_address_lot_Invalid;
    UNSIGNED1 company_address_lot_order_Invalid;
    UNSIGNED1 company_address_dbpc_Invalid;
    UNSIGNED1 company_address_chk_digit_Invalid;
    UNSIGNED1 company_address_rec_type_Invalid;
    UNSIGNED1 company_address_fips_state_Invalid;
    UNSIGNED1 company_address_fips_county_Invalid;
    UNSIGNED1 company_address_geo_lat_Invalid;
    UNSIGNED1 company_address_geo_long_Invalid;
    UNSIGNED1 company_address_msa_Invalid;
    UNSIGNED1 company_address_geo_blk_Invalid;
    UNSIGNED1 company_address_geo_match_Invalid;
    UNSIGNED1 company_address_err_stat_Invalid;
    UNSIGNED1 company_address_type_raw_Invalid;
    UNSIGNED1 company_fein_Invalid;
    UNSIGNED1 best_fein_indicator_Invalid;
    UNSIGNED1 company_phone_Invalid;
    UNSIGNED1 phone_type_Invalid;
    UNSIGNED1 company_org_structure_raw_Invalid;
    UNSIGNED1 company_incorporation_date_Invalid;
    UNSIGNED1 company_sic_code1_Invalid;
    UNSIGNED1 company_sic_code2_Invalid;
    UNSIGNED1 company_sic_code3_Invalid;
    UNSIGNED1 company_sic_code4_Invalid;
    UNSIGNED1 company_sic_code5_Invalid;
    UNSIGNED1 company_naics_code1_Invalid;
    UNSIGNED1 company_naics_code2_Invalid;
    UNSIGNED1 company_naics_code3_Invalid;
    UNSIGNED1 company_naics_code4_Invalid;
    UNSIGNED1 company_naics_code5_Invalid;
    UNSIGNED1 company_ticker_Invalid;
    UNSIGNED1 company_ticker_exchange_Invalid;
    UNSIGNED1 company_foreign_domestic_Invalid;
    UNSIGNED1 company_url_Invalid;
    UNSIGNED1 company_inc_state_Invalid;
    UNSIGNED1 company_filing_date_Invalid;
    UNSIGNED1 company_status_date_Invalid;
    UNSIGNED1 company_foreign_date_Invalid;
    UNSIGNED1 event_filing_date_Invalid;
    UNSIGNED1 company_name_status_raw_Invalid;
    UNSIGNED1 company_status_raw_Invalid;
    UNSIGNED1 dt_first_seen_company_name_Invalid;
    UNSIGNED1 dt_last_seen_company_name_Invalid;
    UNSIGNED1 dt_first_seen_company_address_Invalid;
    UNSIGNED1 dt_last_seen_company_address_Invalid;
    UNSIGNED1 vl_id_Invalid;
    UNSIGNED1 current_Invalid;
    UNSIGNED1 source_record_id_Invalid;
    UNSIGNED1 glb_Invalid;
    UNSIGNED1 dppa_Invalid;
    UNSIGNED1 duns_number_Invalid;
    UNSIGNED1 is_contact_Invalid;
    UNSIGNED1 dt_first_seen_contact_Invalid;
    UNSIGNED1 dt_last_seen_contact_Invalid;
    UNSIGNED1 contact_did_Invalid;
    UNSIGNED1 contact_name_fname_Invalid;
    UNSIGNED1 contact_name_lname_Invalid;
    UNSIGNED1 contact_name_name_score_Invalid;
    UNSIGNED1 contact_type_raw_Invalid;
    UNSIGNED1 contact_job_title_raw_Invalid;
    UNSIGNED1 contact_ssn_Invalid;
    UNSIGNED1 contact_dob_Invalid;
    UNSIGNED1 contact_status_raw_Invalid;
    UNSIGNED1 contact_phone_Invalid;
    UNSIGNED1 from_hdr_Invalid;
    UNSIGNED1 company_name_type_derived_Invalid;
    UNSIGNED1 company_address_type_derived_Invalid;
    UNSIGNED1 company_org_structure_derived_Invalid;
    UNSIGNED1 company_name_status_derived_Invalid;
    UNSIGNED1 company_status_derived_Invalid;
    UNSIGNED1 contact_type_derived_Invalid;
    UNSIGNED1 contact_job_title_derived_Invalid;
    UNSIGNED1 contact_status_derived_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Ingest_Layout_BIPV2)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Ingest_Layout_BIPV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.source_Invalid := Ingest_Fields.InValid_source((SALT311.StrType)le.source);
    SELF.dt_first_seen_Invalid := Ingest_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen);
    SELF.dt_last_seen_Invalid := Ingest_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Ingest_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported);
    SELF.dt_vendor_last_reported_Invalid := Ingest_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported);
    SELF.rcid_Invalid := Ingest_Fields.InValid_rcid((SALT311.StrType)le.rcid);
    SELF.company_bdid_Invalid := Ingest_Fields.InValid_company_bdid((SALT311.StrType)le.company_bdid);
    SELF.company_name_Invalid := Ingest_Fields.InValid_company_name((SALT311.StrType)le.company_name);
    SELF.company_name_type_raw_Invalid := Ingest_Fields.InValid_company_name_type_raw((SALT311.StrType)le.company_name_type_raw,(SALT311.StrType)le.company_name_type_derived);
    SELF.company_rawaid_Invalid := Ingest_Fields.InValid_company_rawaid((SALT311.StrType)le.company_rawaid);
    SELF.company_address_predir_Invalid := Ingest_Fields.InValid_company_address_predir((SALT311.StrType)le.company_address_predir);
    SELF.company_address_prim_name_Invalid := Ingest_Fields.InValid_company_address_prim_name((SALT311.StrType)le.company_address_prim_name);
    SELF.company_address_postdir_Invalid := Ingest_Fields.InValid_company_address_postdir((SALT311.StrType)le.company_address_postdir);
    SELF.company_address_p_city_name_Invalid := Ingest_Fields.InValid_company_address_p_city_name((SALT311.StrType)le.company_address_p_city_name,(SALT311.StrType)le.company_address_v_city_name);
    SELF.company_address_v_city_name_Invalid := Ingest_Fields.InValid_company_address_v_city_name((SALT311.StrType)le.company_address_v_city_name,(SALT311.StrType)le.company_address_p_city_name);
    SELF.company_address_st_Invalid := Ingest_Fields.InValid_company_address_st((SALT311.StrType)le.company_address_st);
    SELF.company_address_zip_Invalid := Ingest_Fields.InValid_company_address_zip((SALT311.StrType)le.company_address_zip);
    SELF.company_address_zip4_Invalid := Ingest_Fields.InValid_company_address_zip4((SALT311.StrType)le.company_address_zip4);
    SELF.company_address_cart_Invalid := Ingest_Fields.InValid_company_address_cart((SALT311.StrType)le.company_address_cart);
    SELF.company_address_cr_sort_sz_Invalid := Ingest_Fields.InValid_company_address_cr_sort_sz((SALT311.StrType)le.company_address_cr_sort_sz);
    SELF.company_address_lot_Invalid := Ingest_Fields.InValid_company_address_lot((SALT311.StrType)le.company_address_lot);
    SELF.company_address_lot_order_Invalid := Ingest_Fields.InValid_company_address_lot_order((SALT311.StrType)le.company_address_lot_order);
    SELF.company_address_dbpc_Invalid := Ingest_Fields.InValid_company_address_dbpc((SALT311.StrType)le.company_address_dbpc);
    SELF.company_address_chk_digit_Invalid := Ingest_Fields.InValid_company_address_chk_digit((SALT311.StrType)le.company_address_chk_digit);
    SELF.company_address_rec_type_Invalid := Ingest_Fields.InValid_company_address_rec_type((SALT311.StrType)le.company_address_rec_type);
    SELF.company_address_fips_state_Invalid := Ingest_Fields.InValid_company_address_fips_state((SALT311.StrType)le.company_address_fips_state);
    SELF.company_address_fips_county_Invalid := Ingest_Fields.InValid_company_address_fips_county((SALT311.StrType)le.company_address_fips_county);
    SELF.company_address_geo_lat_Invalid := Ingest_Fields.InValid_company_address_geo_lat((SALT311.StrType)le.company_address_geo_lat);
    SELF.company_address_geo_long_Invalid := Ingest_Fields.InValid_company_address_geo_long((SALT311.StrType)le.company_address_geo_long);
    SELF.company_address_msa_Invalid := Ingest_Fields.InValid_company_address_msa((SALT311.StrType)le.company_address_msa);
    SELF.company_address_geo_blk_Invalid := Ingest_Fields.InValid_company_address_geo_blk((SALT311.StrType)le.company_address_geo_blk);
    SELF.company_address_geo_match_Invalid := Ingest_Fields.InValid_company_address_geo_match((SALT311.StrType)le.company_address_geo_match);
    SELF.company_address_err_stat_Invalid := Ingest_Fields.InValid_company_address_err_stat((SALT311.StrType)le.company_address_err_stat);
    SELF.company_address_type_raw_Invalid := Ingest_Fields.InValid_company_address_type_raw((SALT311.StrType)le.company_address_type_raw,(SALT311.StrType)le.company_address_type_derived);
    SELF.company_fein_Invalid := Ingest_Fields.InValid_company_fein((SALT311.StrType)le.company_fein);
    SELF.best_fein_indicator_Invalid := Ingest_Fields.InValid_best_fein_indicator((SALT311.StrType)le.best_fein_indicator);
    SELF.company_phone_Invalid := Ingest_Fields.InValid_company_phone((SALT311.StrType)le.company_phone);
    SELF.phone_type_Invalid := Ingest_Fields.InValid_phone_type((SALT311.StrType)le.phone_type);
    SELF.company_org_structure_raw_Invalid := Ingest_Fields.InValid_company_org_structure_raw((SALT311.StrType)le.company_org_structure_raw,(SALT311.StrType)le.company_org_structure_derived);
    SELF.company_incorporation_date_Invalid := Ingest_Fields.InValid_company_incorporation_date((SALT311.StrType)le.company_incorporation_date);
    SELF.company_sic_code1_Invalid := Ingest_Fields.InValid_company_sic_code1((SALT311.StrType)le.company_sic_code1);
    SELF.company_sic_code2_Invalid := Ingest_Fields.InValid_company_sic_code2((SALT311.StrType)le.company_sic_code2);
    SELF.company_sic_code3_Invalid := Ingest_Fields.InValid_company_sic_code3((SALT311.StrType)le.company_sic_code3);
    SELF.company_sic_code4_Invalid := Ingest_Fields.InValid_company_sic_code4((SALT311.StrType)le.company_sic_code4);
    SELF.company_sic_code5_Invalid := Ingest_Fields.InValid_company_sic_code5((SALT311.StrType)le.company_sic_code5);
    SELF.company_naics_code1_Invalid := Ingest_Fields.InValid_company_naics_code1((SALT311.StrType)le.company_naics_code1);
    SELF.company_naics_code2_Invalid := Ingest_Fields.InValid_company_naics_code2((SALT311.StrType)le.company_naics_code2);
    SELF.company_naics_code3_Invalid := Ingest_Fields.InValid_company_naics_code3((SALT311.StrType)le.company_naics_code3);
    SELF.company_naics_code4_Invalid := Ingest_Fields.InValid_company_naics_code4((SALT311.StrType)le.company_naics_code4);
    SELF.company_naics_code5_Invalid := Ingest_Fields.InValid_company_naics_code5((SALT311.StrType)le.company_naics_code5);
    SELF.company_ticker_Invalid := Ingest_Fields.InValid_company_ticker((SALT311.StrType)le.company_ticker,(SALT311.StrType)le.company_ticker_exchange);
    SELF.company_ticker_exchange_Invalid := Ingest_Fields.InValid_company_ticker_exchange((SALT311.StrType)le.company_ticker_exchange,(SALT311.StrType)le.company_ticker);
    SELF.company_foreign_domestic_Invalid := Ingest_Fields.InValid_company_foreign_domestic((SALT311.StrType)le.company_foreign_domestic);
    SELF.company_url_Invalid := Ingest_Fields.InValid_company_url((SALT311.StrType)le.company_url);
    SELF.company_inc_state_Invalid := Ingest_Fields.InValid_company_inc_state((SALT311.StrType)le.company_inc_state);
    SELF.company_filing_date_Invalid := Ingest_Fields.InValid_company_filing_date((SALT311.StrType)le.company_filing_date);
    SELF.company_status_date_Invalid := Ingest_Fields.InValid_company_status_date((SALT311.StrType)le.company_status_date);
    SELF.company_foreign_date_Invalid := Ingest_Fields.InValid_company_foreign_date((SALT311.StrType)le.company_foreign_date);
    SELF.event_filing_date_Invalid := Ingest_Fields.InValid_event_filing_date((SALT311.StrType)le.event_filing_date);
    SELF.company_name_status_raw_Invalid := Ingest_Fields.InValid_company_name_status_raw((SALT311.StrType)le.company_name_status_raw);
    SELF.company_status_raw_Invalid := Ingest_Fields.InValid_company_status_raw((SALT311.StrType)le.company_status_raw,(SALT311.StrType)le.company_status_derived);
    SELF.dt_first_seen_company_name_Invalid := Ingest_Fields.InValid_dt_first_seen_company_name((SALT311.StrType)le.dt_first_seen_company_name);
    SELF.dt_last_seen_company_name_Invalid := Ingest_Fields.InValid_dt_last_seen_company_name((SALT311.StrType)le.dt_last_seen_company_name);
    SELF.dt_first_seen_company_address_Invalid := Ingest_Fields.InValid_dt_first_seen_company_address((SALT311.StrType)le.dt_first_seen_company_address);
    SELF.dt_last_seen_company_address_Invalid := Ingest_Fields.InValid_dt_last_seen_company_address((SALT311.StrType)le.dt_last_seen_company_address);
    SELF.vl_id_Invalid := Ingest_Fields.InValid_vl_id((SALT311.StrType)le.vl_id);
    SELF.current_Invalid := Ingest_Fields.InValid_current((SALT311.StrType)le.current);
    SELF.source_record_id_Invalid := Ingest_Fields.InValid_source_record_id((SALT311.StrType)le.source_record_id);
    SELF.glb_Invalid := Ingest_Fields.InValid_glb((SALT311.StrType)le.glb);
    SELF.dppa_Invalid := Ingest_Fields.InValid_dppa((SALT311.StrType)le.dppa);
    SELF.duns_number_Invalid := Ingest_Fields.InValid_duns_number((SALT311.StrType)le.duns_number);
    SELF.is_contact_Invalid := Ingest_Fields.InValid_is_contact((SALT311.StrType)le.is_contact,(SALT311.StrType)le.contact_name_fname,(SALT311.StrType)le.contact_name_lname);
    SELF.dt_first_seen_contact_Invalid := Ingest_Fields.InValid_dt_first_seen_contact((SALT311.StrType)le.dt_first_seen_contact);
    SELF.dt_last_seen_contact_Invalid := Ingest_Fields.InValid_dt_last_seen_contact((SALT311.StrType)le.dt_last_seen_contact);
    SELF.contact_did_Invalid := Ingest_Fields.InValid_contact_did((SALT311.StrType)le.contact_did,(SALT311.StrType)le.contact_name_fname,(SALT311.StrType)le.contact_name_lname);
    SELF.contact_name_fname_Invalid := Ingest_Fields.InValid_contact_name_fname((SALT311.StrType)le.contact_name_fname,(SALT311.StrType)le.contact_name_lname);
    SELF.contact_name_lname_Invalid := Ingest_Fields.InValid_contact_name_lname((SALT311.StrType)le.contact_name_lname,(SALT311.StrType)le.contact_name_fname);
    SELF.contact_name_name_score_Invalid := Ingest_Fields.InValid_contact_name_name_score((SALT311.StrType)le.contact_name_name_score);
    SELF.contact_type_raw_Invalid := Ingest_Fields.InValid_contact_type_raw((SALT311.StrType)le.contact_type_raw,(SALT311.StrType)le.contact_type_derived);
    SELF.contact_job_title_raw_Invalid := Ingest_Fields.InValid_contact_job_title_raw((SALT311.StrType)le.contact_job_title_raw,(SALT311.StrType)le.contact_job_title_derived);
    SELF.contact_ssn_Invalid := Ingest_Fields.InValid_contact_ssn((SALT311.StrType)le.contact_ssn);
    SELF.contact_dob_Invalid := Ingest_Fields.InValid_contact_dob((SALT311.StrType)le.contact_dob);
    SELF.contact_status_raw_Invalid := Ingest_Fields.InValid_contact_status_raw((SALT311.StrType)le.contact_status_raw);
    SELF.contact_phone_Invalid := Ingest_Fields.InValid_contact_phone((SALT311.StrType)le.contact_phone);
    SELF.from_hdr_Invalid := Ingest_Fields.InValid_from_hdr((SALT311.StrType)le.from_hdr);
    SELF.company_name_type_derived_Invalid := Ingest_Fields.InValid_company_name_type_derived((SALT311.StrType)le.company_name_type_derived,(SALT311.StrType)le.company_name_type_raw);
    SELF.company_address_type_derived_Invalid := Ingest_Fields.InValid_company_address_type_derived((SALT311.StrType)le.company_address_type_derived,(SALT311.StrType)le.company_address_type_raw);
    SELF.company_org_structure_derived_Invalid := Ingest_Fields.InValid_company_org_structure_derived((SALT311.StrType)le.company_org_structure_derived,(SALT311.StrType)le.company_org_structure_raw);
    SELF.company_name_status_derived_Invalid := Ingest_Fields.InValid_company_name_status_derived((SALT311.StrType)le.company_name_status_derived,(SALT311.StrType)le.company_name_status_raw);
    SELF.company_status_derived_Invalid := Ingest_Fields.InValid_company_status_derived((SALT311.StrType)le.company_status_derived,(SALT311.StrType)le.company_status_raw);
    SELF.contact_type_derived_Invalid := Ingest_Fields.InValid_contact_type_derived((SALT311.StrType)le.contact_type_derived,(SALT311.StrType)le.contact_type_raw);
    SELF.contact_job_title_derived_Invalid := Ingest_Fields.InValid_contact_job_title_derived((SALT311.StrType)le.contact_job_title_derived,(SALT311.StrType)le.contact_job_title_raw);
    SELF.contact_status_derived_Invalid := Ingest_Fields.InValid_contact_status_derived((SALT311.StrType)le.contact_status_derived,(SALT311.StrType)le.contact_status_raw);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Ingest_Layout_BIPV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.source_Invalid << 0 ) + ( le.dt_first_seen_Invalid << 1 ) + ( le.dt_last_seen_Invalid << 2 ) + ( le.dt_vendor_first_reported_Invalid << 3 ) + ( le.dt_vendor_last_reported_Invalid << 4 ) + ( le.rcid_Invalid << 5 ) + ( le.company_bdid_Invalid << 6 ) + ( le.company_name_Invalid << 7 ) + ( le.company_name_type_raw_Invalid << 8 ) + ( le.company_rawaid_Invalid << 9 ) + ( le.company_address_predir_Invalid << 10 ) + ( le.company_address_prim_name_Invalid << 11 ) + ( le.company_address_postdir_Invalid << 12 ) + ( le.company_address_p_city_name_Invalid << 13 ) + ( le.company_address_v_city_name_Invalid << 14 ) + ( le.company_address_st_Invalid << 15 ) + ( le.company_address_zip_Invalid << 16 ) + ( le.company_address_zip4_Invalid << 17 ) + ( le.company_address_cart_Invalid << 18 ) + ( le.company_address_cr_sort_sz_Invalid << 19 ) + ( le.company_address_lot_Invalid << 20 ) + ( le.company_address_lot_order_Invalid << 21 ) + ( le.company_address_dbpc_Invalid << 22 ) + ( le.company_address_chk_digit_Invalid << 23 ) + ( le.company_address_rec_type_Invalid << 24 ) + ( le.company_address_fips_state_Invalid << 25 ) + ( le.company_address_fips_county_Invalid << 26 ) + ( le.company_address_geo_lat_Invalid << 27 ) + ( le.company_address_geo_long_Invalid << 28 ) + ( le.company_address_msa_Invalid << 29 ) + ( le.company_address_geo_blk_Invalid << 30 ) + ( le.company_address_geo_match_Invalid << 31 ) + ( le.company_address_err_stat_Invalid << 32 ) + ( le.company_address_type_raw_Invalid << 33 ) + ( le.company_fein_Invalid << 34 ) + ( le.best_fein_indicator_Invalid << 35 ) + ( le.company_phone_Invalid << 36 ) + ( le.phone_type_Invalid << 37 ) + ( le.company_org_structure_raw_Invalid << 38 ) + ( le.company_incorporation_date_Invalid << 39 ) + ( le.company_sic_code1_Invalid << 40 ) + ( le.company_sic_code2_Invalid << 41 ) + ( le.company_sic_code3_Invalid << 42 ) + ( le.company_sic_code4_Invalid << 43 ) + ( le.company_sic_code5_Invalid << 44 ) + ( le.company_naics_code1_Invalid << 45 ) + ( le.company_naics_code2_Invalid << 46 ) + ( le.company_naics_code3_Invalid << 47 ) + ( le.company_naics_code4_Invalid << 48 ) + ( le.company_naics_code5_Invalid << 49 ) + ( le.company_ticker_Invalid << 50 ) + ( le.company_ticker_exchange_Invalid << 51 ) + ( le.company_foreign_domestic_Invalid << 52 ) + ( le.company_url_Invalid << 53 ) + ( le.company_inc_state_Invalid << 54 ) + ( le.company_filing_date_Invalid << 55 ) + ( le.company_status_date_Invalid << 56 ) + ( le.company_foreign_date_Invalid << 57 ) + ( le.event_filing_date_Invalid << 58 ) + ( le.company_name_status_raw_Invalid << 59 ) + ( le.company_status_raw_Invalid << 60 ) + ( le.dt_first_seen_company_name_Invalid << 61 ) + ( le.dt_last_seen_company_name_Invalid << 62 ) + ( le.dt_first_seen_company_address_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.dt_last_seen_company_address_Invalid << 0 ) + ( le.vl_id_Invalid << 1 ) + ( le.current_Invalid << 2 ) + ( le.source_record_id_Invalid << 3 ) + ( le.glb_Invalid << 4 ) + ( le.dppa_Invalid << 5 ) + ( le.duns_number_Invalid << 6 ) + ( le.is_contact_Invalid << 7 ) + ( le.dt_first_seen_contact_Invalid << 8 ) + ( le.dt_last_seen_contact_Invalid << 9 ) + ( le.contact_did_Invalid << 10 ) + ( le.contact_name_fname_Invalid << 11 ) + ( le.contact_name_lname_Invalid << 12 ) + ( le.contact_name_name_score_Invalid << 13 ) + ( le.contact_type_raw_Invalid << 14 ) + ( le.contact_job_title_raw_Invalid << 15 ) + ( le.contact_ssn_Invalid << 16 ) + ( le.contact_dob_Invalid << 17 ) + ( le.contact_status_raw_Invalid << 18 ) + ( le.contact_phone_Invalid << 19 ) + ( le.from_hdr_Invalid << 20 ) + ( le.company_name_type_derived_Invalid << 21 ) + ( le.company_address_type_derived_Invalid << 22 ) + ( le.company_org_structure_derived_Invalid << 23 ) + ( le.company_name_status_derived_Invalid << 24 ) + ( le.company_status_derived_Invalid << 25 ) + ( le.contact_type_derived_Invalid << 26 ) + ( le.contact_job_title_derived_Invalid << 27 ) + ( le.contact_status_derived_Invalid << 28 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Ingest_Layout_BIPV2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.source_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.rcid_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.company_bdid_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.company_name_type_raw_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.company_rawaid_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.company_address_predir_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.company_address_prim_name_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.company_address_postdir_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.company_address_p_city_name_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.company_address_v_city_name_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.company_address_st_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.company_address_zip_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.company_address_zip4_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.company_address_cart_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.company_address_cr_sort_sz_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.company_address_lot_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.company_address_lot_order_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.company_address_dbpc_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.company_address_chk_digit_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.company_address_rec_type_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.company_address_fips_state_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.company_address_fips_county_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.company_address_geo_lat_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.company_address_geo_long_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.company_address_msa_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.company_address_geo_blk_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.company_address_geo_match_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.company_address_err_stat_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.company_address_type_raw_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.company_fein_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.best_fein_indicator_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.company_phone_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.phone_type_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.company_org_structure_raw_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.company_incorporation_date_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.company_sic_code1_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.company_sic_code2_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.company_sic_code3_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.company_sic_code4_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.company_sic_code5_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.company_naics_code1_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.company_naics_code2_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.company_naics_code3_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.company_naics_code4_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.company_naics_code5_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.company_ticker_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.company_ticker_exchange_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.company_foreign_domestic_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.company_url_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.company_inc_state_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.company_filing_date_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.company_status_date_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.company_foreign_date_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.event_filing_date_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.company_name_status_raw_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.company_status_raw_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.dt_first_seen_company_name_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.dt_last_seen_company_name_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.dt_first_seen_company_address_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.dt_last_seen_company_address_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.vl_id_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.current_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.source_record_id_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.glb_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.dppa_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.duns_number_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.is_contact_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.dt_first_seen_contact_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.dt_last_seen_contact_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.contact_did_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.contact_name_fname_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.contact_name_lname_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.contact_name_name_score_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.contact_type_raw_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.contact_job_title_raw_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.contact_ssn_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.contact_dob_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.contact_status_raw_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.contact_phone_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.from_hdr_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.company_name_type_derived_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.company_address_type_derived_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.company_org_structure_derived_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.company_name_status_derived_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.company_status_derived_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.contact_type_derived_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.contact_job_title_derived_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.contact_status_derived_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.source_expanded) source_expanded := IF(Glob, '', h.source_expanded);
    TotalCnt := COUNT(GROUP); // Number of records in total
    source_CUSTOM_ErrorCount := COUNT(GROUP,h.source_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    rcid_ENUM_ErrorCount := COUNT(GROUP,h.rcid_Invalid=1);
    company_bdid_CUSTOM_ErrorCount := COUNT(GROUP,h.company_bdid_Invalid=1);
    company_name_CUSTOM_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    company_name_type_raw_CUSTOM_ErrorCount := COUNT(GROUP,h.company_name_type_raw_Invalid=1);
    company_rawaid_CUSTOM_ErrorCount := COUNT(GROUP,h.company_rawaid_Invalid=1);
    company_address_predir_ALLOW_ErrorCount := COUNT(GROUP,h.company_address_predir_Invalid=1);
    company_address_prim_name_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_prim_name_Invalid=1);
    company_address_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.company_address_postdir_Invalid=1);
    company_address_p_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_p_city_name_Invalid=1);
    company_address_v_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_v_city_name_Invalid=1);
    company_address_st_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_st_Invalid=1);
    company_address_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_zip_Invalid=1);
    company_address_zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_zip4_Invalid=1);
    company_address_cart_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_cart_Invalid=1);
    company_address_cr_sort_sz_ENUM_ErrorCount := COUNT(GROUP,h.company_address_cr_sort_sz_Invalid=1);
    company_address_lot_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_lot_Invalid=1);
    company_address_lot_order_ENUM_ErrorCount := COUNT(GROUP,h.company_address_lot_order_Invalid=1);
    company_address_dbpc_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_dbpc_Invalid=1);
    company_address_chk_digit_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_chk_digit_Invalid=1);
    company_address_rec_type_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_rec_type_Invalid=1);
    company_address_fips_state_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_fips_state_Invalid=1);
    company_address_fips_county_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_fips_county_Invalid=1);
    company_address_geo_lat_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_geo_lat_Invalid=1);
    company_address_geo_long_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_geo_long_Invalid=1);
    company_address_msa_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_msa_Invalid=1);
    company_address_geo_blk_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_geo_blk_Invalid=1);
    company_address_geo_match_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_geo_match_Invalid=1);
    company_address_err_stat_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_err_stat_Invalid=1);
    company_address_type_raw_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_type_raw_Invalid=1);
    company_fein_CUSTOM_ErrorCount := COUNT(GROUP,h.company_fein_Invalid=1);
    best_fein_indicator_ENUM_ErrorCount := COUNT(GROUP,h.best_fein_indicator_Invalid=1);
    company_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.company_phone_Invalid=1);
    phone_type_ENUM_ErrorCount := COUNT(GROUP,h.phone_type_Invalid=1);
    company_org_structure_raw_CUSTOM_ErrorCount := COUNT(GROUP,h.company_org_structure_raw_Invalid=1);
    company_incorporation_date_CUSTOM_ErrorCount := COUNT(GROUP,h.company_incorporation_date_Invalid=1);
    company_sic_code1_CUSTOM_ErrorCount := COUNT(GROUP,h.company_sic_code1_Invalid=1);
    company_sic_code2_CUSTOM_ErrorCount := COUNT(GROUP,h.company_sic_code2_Invalid=1);
    company_sic_code3_CUSTOM_ErrorCount := COUNT(GROUP,h.company_sic_code3_Invalid=1);
    company_sic_code4_CUSTOM_ErrorCount := COUNT(GROUP,h.company_sic_code4_Invalid=1);
    company_sic_code5_CUSTOM_ErrorCount := COUNT(GROUP,h.company_sic_code5_Invalid=1);
    company_naics_code1_CUSTOM_ErrorCount := COUNT(GROUP,h.company_naics_code1_Invalid=1);
    company_naics_code2_CUSTOM_ErrorCount := COUNT(GROUP,h.company_naics_code2_Invalid=1);
    company_naics_code3_CUSTOM_ErrorCount := COUNT(GROUP,h.company_naics_code3_Invalid=1);
    company_naics_code4_CUSTOM_ErrorCount := COUNT(GROUP,h.company_naics_code4_Invalid=1);
    company_naics_code5_CUSTOM_ErrorCount := COUNT(GROUP,h.company_naics_code5_Invalid=1);
    company_ticker_CUSTOM_ErrorCount := COUNT(GROUP,h.company_ticker_Invalid=1);
    company_ticker_exchange_CUSTOM_ErrorCount := COUNT(GROUP,h.company_ticker_exchange_Invalid=1);
    company_foreign_domestic_ENUM_ErrorCount := COUNT(GROUP,h.company_foreign_domestic_Invalid=1);
    company_url_CUSTOM_ErrorCount := COUNT(GROUP,h.company_url_Invalid=1);
    company_inc_state_CUSTOM_ErrorCount := COUNT(GROUP,h.company_inc_state_Invalid=1);
    company_filing_date_CUSTOM_ErrorCount := COUNT(GROUP,h.company_filing_date_Invalid=1);
    company_status_date_CUSTOM_ErrorCount := COUNT(GROUP,h.company_status_date_Invalid=1);
    company_foreign_date_CUSTOM_ErrorCount := COUNT(GROUP,h.company_foreign_date_Invalid=1);
    event_filing_date_CUSTOM_ErrorCount := COUNT(GROUP,h.event_filing_date_Invalid=1);
    company_name_status_raw_CUSTOM_ErrorCount := COUNT(GROUP,h.company_name_status_raw_Invalid=1);
    company_status_raw_CUSTOM_ErrorCount := COUNT(GROUP,h.company_status_raw_Invalid=1);
    dt_first_seen_company_name_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_company_name_Invalid=1);
    dt_last_seen_company_name_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_company_name_Invalid=1);
    dt_first_seen_company_address_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_company_address_Invalid=1);
    dt_last_seen_company_address_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_company_address_Invalid=1);
    vl_id_CUSTOM_ErrorCount := COUNT(GROUP,h.vl_id_Invalid=1);
    current_ENUM_ErrorCount := COUNT(GROUP,h.current_Invalid=1);
    source_record_id_CUSTOM_ErrorCount := COUNT(GROUP,h.source_record_id_Invalid=1);
    glb_ENUM_ErrorCount := COUNT(GROUP,h.glb_Invalid=1);
    dppa_ENUM_ErrorCount := COUNT(GROUP,h.dppa_Invalid=1);
    duns_number_CUSTOM_ErrorCount := COUNT(GROUP,h.duns_number_Invalid=1);
    is_contact_CUSTOM_ErrorCount := COUNT(GROUP,h.is_contact_Invalid=1);
    dt_first_seen_contact_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_contact_Invalid=1);
    dt_last_seen_contact_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_contact_Invalid=1);
    contact_did_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_did_Invalid=1);
    contact_name_fname_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_name_fname_Invalid=1);
    contact_name_lname_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_name_lname_Invalid=1);
    contact_name_name_score_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_name_name_score_Invalid=1);
    contact_type_raw_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_type_raw_Invalid=1);
    contact_job_title_raw_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_job_title_raw_Invalid=1);
    contact_ssn_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_ssn_Invalid=1);
    contact_dob_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_dob_Invalid=1);
    contact_status_raw_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_status_raw_Invalid=1);
    contact_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_phone_Invalid=1);
    from_hdr_ENUM_ErrorCount := COUNT(GROUP,h.from_hdr_Invalid=1);
    company_name_type_derived_CUSTOM_ErrorCount := COUNT(GROUP,h.company_name_type_derived_Invalid=1);
    company_address_type_derived_CUSTOM_ErrorCount := COUNT(GROUP,h.company_address_type_derived_Invalid=1);
    company_org_structure_derived_CUSTOM_ErrorCount := COUNT(GROUP,h.company_org_structure_derived_Invalid=1);
    company_name_status_derived_CUSTOM_ErrorCount := COUNT(GROUP,h.company_name_status_derived_Invalid=1);
    company_status_derived_CUSTOM_ErrorCount := COUNT(GROUP,h.company_status_derived_Invalid=1);
    contact_type_derived_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_type_derived_Invalid=1);
    contact_job_title_derived_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_job_title_derived_Invalid=1);
    contact_status_derived_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_status_derived_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.source_Invalid > 0 OR h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.rcid_Invalid > 0 OR h.company_bdid_Invalid > 0 OR h.company_name_Invalid > 0 OR h.company_name_type_raw_Invalid > 0 OR h.company_rawaid_Invalid > 0 OR h.company_address_predir_Invalid > 0 OR h.company_address_prim_name_Invalid > 0 OR h.company_address_postdir_Invalid > 0 OR h.company_address_p_city_name_Invalid > 0 OR h.company_address_v_city_name_Invalid > 0 OR h.company_address_st_Invalid > 0 OR h.company_address_zip_Invalid > 0 OR h.company_address_zip4_Invalid > 0 OR h.company_address_cart_Invalid > 0 OR h.company_address_cr_sort_sz_Invalid > 0 OR h.company_address_lot_Invalid > 0 OR h.company_address_lot_order_Invalid > 0 OR h.company_address_dbpc_Invalid > 0 OR h.company_address_chk_digit_Invalid > 0 OR h.company_address_rec_type_Invalid > 0 OR h.company_address_fips_state_Invalid > 0 OR h.company_address_fips_county_Invalid > 0 OR h.company_address_geo_lat_Invalid > 0 OR h.company_address_geo_long_Invalid > 0 OR h.company_address_msa_Invalid > 0 OR h.company_address_geo_blk_Invalid > 0 OR h.company_address_geo_match_Invalid > 0 OR h.company_address_err_stat_Invalid > 0 OR h.company_address_type_raw_Invalid > 0 OR h.company_fein_Invalid > 0 OR h.best_fein_indicator_Invalid > 0 OR h.company_phone_Invalid > 0 OR h.phone_type_Invalid > 0 OR h.company_org_structure_raw_Invalid > 0 OR h.company_incorporation_date_Invalid > 0 OR h.company_sic_code1_Invalid > 0 OR h.company_sic_code2_Invalid > 0 OR h.company_sic_code3_Invalid > 0 OR h.company_sic_code4_Invalid > 0 OR h.company_sic_code5_Invalid > 0 OR h.company_naics_code1_Invalid > 0 OR h.company_naics_code2_Invalid > 0 OR h.company_naics_code3_Invalid > 0 OR h.company_naics_code4_Invalid > 0 OR h.company_naics_code5_Invalid > 0 OR h.company_ticker_Invalid > 0 OR h.company_ticker_exchange_Invalid > 0 OR h.company_foreign_domestic_Invalid > 0 OR h.company_url_Invalid > 0 OR h.company_inc_state_Invalid > 0 OR h.company_filing_date_Invalid > 0 OR h.company_status_date_Invalid > 0 OR h.company_foreign_date_Invalid > 0 OR h.event_filing_date_Invalid > 0 OR h.company_name_status_raw_Invalid > 0 OR h.company_status_raw_Invalid > 0 OR h.dt_first_seen_company_name_Invalid > 0 OR h.dt_last_seen_company_name_Invalid > 0 OR h.dt_first_seen_company_address_Invalid > 0 OR h.dt_last_seen_company_address_Invalid > 0 OR h.vl_id_Invalid > 0 OR h.current_Invalid > 0 OR h.source_record_id_Invalid > 0 OR h.glb_Invalid > 0 OR h.dppa_Invalid > 0 OR h.duns_number_Invalid > 0 OR h.is_contact_Invalid > 0 OR h.dt_first_seen_contact_Invalid > 0 OR h.dt_last_seen_contact_Invalid > 0 OR h.contact_did_Invalid > 0 OR h.contact_name_fname_Invalid > 0 OR h.contact_name_lname_Invalid > 0 OR h.contact_name_name_score_Invalid > 0 OR h.contact_type_raw_Invalid > 0 OR h.contact_job_title_raw_Invalid > 0 OR h.contact_ssn_Invalid > 0 OR h.contact_dob_Invalid > 0 OR h.contact_status_raw_Invalid > 0 OR h.contact_phone_Invalid > 0 OR h.from_hdr_Invalid > 0 OR h.company_name_type_derived_Invalid > 0 OR h.company_address_type_derived_Invalid > 0 OR h.company_org_structure_derived_Invalid > 0 OR h.company_name_status_derived_Invalid > 0 OR h.company_status_derived_Invalid > 0 OR h.contact_type_derived_Invalid > 0 OR h.contact_job_title_derived_Invalid > 0 OR h.contact_status_derived_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,source_expanded,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.source_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rcid_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_type_raw_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_rawaid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_address_prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_address_p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_cart_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_cr_sort_sz_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_address_lot_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_address_dbpc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_rec_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_fips_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_fips_county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_geo_blk_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_geo_match_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_err_stat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_type_raw_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_fein_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.best_fein_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_org_structure_raw_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_incorporation_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_sic_code1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_sic_code2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_sic_code3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_sic_code4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_sic_code5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_naics_code1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_naics_code2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_naics_code3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_naics_code4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_naics_code5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_ticker_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_ticker_exchange_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_foreign_domestic_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_url_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_inc_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_filing_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_status_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_foreign_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.event_filing_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_status_raw_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_status_raw_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_company_address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_company_address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vl_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_ENUM_ErrorCount > 0, 1, 0) + IF(le.source_record_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.glb_ENUM_ErrorCount > 0, 1, 0) + IF(le.dppa_ENUM_ErrorCount > 0, 1, 0) + IF(le.duns_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.is_contact_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_contact_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_contact_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_did_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_name_fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_name_lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_name_name_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_type_raw_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_job_title_raw_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_ssn_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_status_raw_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.from_hdr_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_name_type_derived_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_type_derived_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_org_structure_derived_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_status_derived_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_status_derived_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_type_derived_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_job_title_derived_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_status_derived_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.source_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rcid_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_type_raw_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_rawaid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_address_prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_address_p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_cart_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_cr_sort_sz_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_address_lot_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_address_dbpc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_rec_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_fips_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_fips_county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_geo_blk_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_geo_match_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_err_stat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_type_raw_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_fein_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.best_fein_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_org_structure_raw_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_incorporation_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_sic_code1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_sic_code2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_sic_code3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_sic_code4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_sic_code5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_naics_code1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_naics_code2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_naics_code3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_naics_code4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_naics_code5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_ticker_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_ticker_exchange_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_foreign_domestic_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_url_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_inc_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_filing_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_status_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_foreign_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.event_filing_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_status_raw_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_status_raw_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_company_address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_company_address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vl_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_ENUM_ErrorCount > 0, 1, 0) + IF(le.source_record_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.glb_ENUM_ErrorCount > 0, 1, 0) + IF(le.dppa_ENUM_ErrorCount > 0, 1, 0) + IF(le.duns_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.is_contact_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_contact_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_contact_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_did_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_name_fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_name_lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_name_name_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_type_raw_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_job_title_raw_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_ssn_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_status_raw_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.from_hdr_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_name_type_derived_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_address_type_derived_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_org_structure_derived_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_status_derived_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_status_derived_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_type_derived_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_job_title_derived_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contact_status_derived_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.source_expanded;
    UNSIGNED1 ErrNum := CHOOSE(c,le.source_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.rcid_Invalid,le.company_bdid_Invalid,le.company_name_Invalid,le.company_name_type_raw_Invalid,le.company_rawaid_Invalid,le.company_address_predir_Invalid,le.company_address_prim_name_Invalid,le.company_address_postdir_Invalid,le.company_address_p_city_name_Invalid,le.company_address_v_city_name_Invalid,le.company_address_st_Invalid,le.company_address_zip_Invalid,le.company_address_zip4_Invalid,le.company_address_cart_Invalid,le.company_address_cr_sort_sz_Invalid,le.company_address_lot_Invalid,le.company_address_lot_order_Invalid,le.company_address_dbpc_Invalid,le.company_address_chk_digit_Invalid,le.company_address_rec_type_Invalid,le.company_address_fips_state_Invalid,le.company_address_fips_county_Invalid,le.company_address_geo_lat_Invalid,le.company_address_geo_long_Invalid,le.company_address_msa_Invalid,le.company_address_geo_blk_Invalid,le.company_address_geo_match_Invalid,le.company_address_err_stat_Invalid,le.company_address_type_raw_Invalid,le.company_fein_Invalid,le.best_fein_indicator_Invalid,le.company_phone_Invalid,le.phone_type_Invalid,le.company_org_structure_raw_Invalid,le.company_incorporation_date_Invalid,le.company_sic_code1_Invalid,le.company_sic_code2_Invalid,le.company_sic_code3_Invalid,le.company_sic_code4_Invalid,le.company_sic_code5_Invalid,le.company_naics_code1_Invalid,le.company_naics_code2_Invalid,le.company_naics_code3_Invalid,le.company_naics_code4_Invalid,le.company_naics_code5_Invalid,le.company_ticker_Invalid,le.company_ticker_exchange_Invalid,le.company_foreign_domestic_Invalid,le.company_url_Invalid,le.company_inc_state_Invalid,le.company_filing_date_Invalid,le.company_status_date_Invalid,le.company_foreign_date_Invalid,le.event_filing_date_Invalid,le.company_name_status_raw_Invalid,le.company_status_raw_Invalid,le.dt_first_seen_company_name_Invalid,le.dt_last_seen_company_name_Invalid,le.dt_first_seen_company_address_Invalid,le.dt_last_seen_company_address_Invalid,le.vl_id_Invalid,le.current_Invalid,le.source_record_id_Invalid,le.glb_Invalid,le.dppa_Invalid,le.duns_number_Invalid,le.is_contact_Invalid,le.dt_first_seen_contact_Invalid,le.dt_last_seen_contact_Invalid,le.contact_did_Invalid,le.contact_name_fname_Invalid,le.contact_name_lname_Invalid,le.contact_name_name_score_Invalid,le.contact_type_raw_Invalid,le.contact_job_title_raw_Invalid,le.contact_ssn_Invalid,le.contact_dob_Invalid,le.contact_status_raw_Invalid,le.contact_phone_Invalid,le.from_hdr_Invalid,le.company_name_type_derived_Invalid,le.company_address_type_derived_Invalid,le.company_org_structure_derived_Invalid,le.company_name_status_derived_Invalid,le.company_status_derived_Invalid,le.contact_type_derived_Invalid,le.contact_job_title_derived_Invalid,le.contact_status_derived_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Ingest_Fields.InvalidMessage_source(le.source_Invalid),Ingest_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Ingest_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Ingest_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Ingest_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Ingest_Fields.InvalidMessage_rcid(le.rcid_Invalid),Ingest_Fields.InvalidMessage_company_bdid(le.company_bdid_Invalid),Ingest_Fields.InvalidMessage_company_name(le.company_name_Invalid),Ingest_Fields.InvalidMessage_company_name_type_raw(le.company_name_type_raw_Invalid),Ingest_Fields.InvalidMessage_company_rawaid(le.company_rawaid_Invalid),Ingest_Fields.InvalidMessage_company_address_predir(le.company_address_predir_Invalid),Ingest_Fields.InvalidMessage_company_address_prim_name(le.company_address_prim_name_Invalid),Ingest_Fields.InvalidMessage_company_address_postdir(le.company_address_postdir_Invalid),Ingest_Fields.InvalidMessage_company_address_p_city_name(le.company_address_p_city_name_Invalid),Ingest_Fields.InvalidMessage_company_address_v_city_name(le.company_address_v_city_name_Invalid),Ingest_Fields.InvalidMessage_company_address_st(le.company_address_st_Invalid),Ingest_Fields.InvalidMessage_company_address_zip(le.company_address_zip_Invalid),Ingest_Fields.InvalidMessage_company_address_zip4(le.company_address_zip4_Invalid),Ingest_Fields.InvalidMessage_company_address_cart(le.company_address_cart_Invalid),Ingest_Fields.InvalidMessage_company_address_cr_sort_sz(le.company_address_cr_sort_sz_Invalid),Ingest_Fields.InvalidMessage_company_address_lot(le.company_address_lot_Invalid),Ingest_Fields.InvalidMessage_company_address_lot_order(le.company_address_lot_order_Invalid),Ingest_Fields.InvalidMessage_company_address_dbpc(le.company_address_dbpc_Invalid),Ingest_Fields.InvalidMessage_company_address_chk_digit(le.company_address_chk_digit_Invalid),Ingest_Fields.InvalidMessage_company_address_rec_type(le.company_address_rec_type_Invalid),Ingest_Fields.InvalidMessage_company_address_fips_state(le.company_address_fips_state_Invalid),Ingest_Fields.InvalidMessage_company_address_fips_county(le.company_address_fips_county_Invalid),Ingest_Fields.InvalidMessage_company_address_geo_lat(le.company_address_geo_lat_Invalid),Ingest_Fields.InvalidMessage_company_address_geo_long(le.company_address_geo_long_Invalid),Ingest_Fields.InvalidMessage_company_address_msa(le.company_address_msa_Invalid),Ingest_Fields.InvalidMessage_company_address_geo_blk(le.company_address_geo_blk_Invalid),Ingest_Fields.InvalidMessage_company_address_geo_match(le.company_address_geo_match_Invalid),Ingest_Fields.InvalidMessage_company_address_err_stat(le.company_address_err_stat_Invalid),Ingest_Fields.InvalidMessage_company_address_type_raw(le.company_address_type_raw_Invalid),Ingest_Fields.InvalidMessage_company_fein(le.company_fein_Invalid),Ingest_Fields.InvalidMessage_best_fein_indicator(le.best_fein_indicator_Invalid),Ingest_Fields.InvalidMessage_company_phone(le.company_phone_Invalid),Ingest_Fields.InvalidMessage_phone_type(le.phone_type_Invalid),Ingest_Fields.InvalidMessage_company_org_structure_raw(le.company_org_structure_raw_Invalid),Ingest_Fields.InvalidMessage_company_incorporation_date(le.company_incorporation_date_Invalid),Ingest_Fields.InvalidMessage_company_sic_code1(le.company_sic_code1_Invalid),Ingest_Fields.InvalidMessage_company_sic_code2(le.company_sic_code2_Invalid),Ingest_Fields.InvalidMessage_company_sic_code3(le.company_sic_code3_Invalid),Ingest_Fields.InvalidMessage_company_sic_code4(le.company_sic_code4_Invalid),Ingest_Fields.InvalidMessage_company_sic_code5(le.company_sic_code5_Invalid),Ingest_Fields.InvalidMessage_company_naics_code1(le.company_naics_code1_Invalid),Ingest_Fields.InvalidMessage_company_naics_code2(le.company_naics_code2_Invalid),Ingest_Fields.InvalidMessage_company_naics_code3(le.company_naics_code3_Invalid),Ingest_Fields.InvalidMessage_company_naics_code4(le.company_naics_code4_Invalid),Ingest_Fields.InvalidMessage_company_naics_code5(le.company_naics_code5_Invalid),Ingest_Fields.InvalidMessage_company_ticker(le.company_ticker_Invalid),Ingest_Fields.InvalidMessage_company_ticker_exchange(le.company_ticker_exchange_Invalid),Ingest_Fields.InvalidMessage_company_foreign_domestic(le.company_foreign_domestic_Invalid),Ingest_Fields.InvalidMessage_company_url(le.company_url_Invalid),Ingest_Fields.InvalidMessage_company_inc_state(le.company_inc_state_Invalid),Ingest_Fields.InvalidMessage_company_filing_date(le.company_filing_date_Invalid),Ingest_Fields.InvalidMessage_company_status_date(le.company_status_date_Invalid),Ingest_Fields.InvalidMessage_company_foreign_date(le.company_foreign_date_Invalid),Ingest_Fields.InvalidMessage_event_filing_date(le.event_filing_date_Invalid),Ingest_Fields.InvalidMessage_company_name_status_raw(le.company_name_status_raw_Invalid),Ingest_Fields.InvalidMessage_company_status_raw(le.company_status_raw_Invalid),Ingest_Fields.InvalidMessage_dt_first_seen_company_name(le.dt_first_seen_company_name_Invalid),Ingest_Fields.InvalidMessage_dt_last_seen_company_name(le.dt_last_seen_company_name_Invalid),Ingest_Fields.InvalidMessage_dt_first_seen_company_address(le.dt_first_seen_company_address_Invalid),Ingest_Fields.InvalidMessage_dt_last_seen_company_address(le.dt_last_seen_company_address_Invalid),Ingest_Fields.InvalidMessage_vl_id(le.vl_id_Invalid),Ingest_Fields.InvalidMessage_current(le.current_Invalid),Ingest_Fields.InvalidMessage_source_record_id(le.source_record_id_Invalid),Ingest_Fields.InvalidMessage_glb(le.glb_Invalid),Ingest_Fields.InvalidMessage_dppa(le.dppa_Invalid),Ingest_Fields.InvalidMessage_duns_number(le.duns_number_Invalid),Ingest_Fields.InvalidMessage_is_contact(le.is_contact_Invalid),Ingest_Fields.InvalidMessage_dt_first_seen_contact(le.dt_first_seen_contact_Invalid),Ingest_Fields.InvalidMessage_dt_last_seen_contact(le.dt_last_seen_contact_Invalid),Ingest_Fields.InvalidMessage_contact_did(le.contact_did_Invalid),Ingest_Fields.InvalidMessage_contact_name_fname(le.contact_name_fname_Invalid),Ingest_Fields.InvalidMessage_contact_name_lname(le.contact_name_lname_Invalid),Ingest_Fields.InvalidMessage_contact_name_name_score(le.contact_name_name_score_Invalid),Ingest_Fields.InvalidMessage_contact_type_raw(le.contact_type_raw_Invalid),Ingest_Fields.InvalidMessage_contact_job_title_raw(le.contact_job_title_raw_Invalid),Ingest_Fields.InvalidMessage_contact_ssn(le.contact_ssn_Invalid),Ingest_Fields.InvalidMessage_contact_dob(le.contact_dob_Invalid),Ingest_Fields.InvalidMessage_contact_status_raw(le.contact_status_raw_Invalid),Ingest_Fields.InvalidMessage_contact_phone(le.contact_phone_Invalid),Ingest_Fields.InvalidMessage_from_hdr(le.from_hdr_Invalid),Ingest_Fields.InvalidMessage_company_name_type_derived(le.company_name_type_derived_Invalid),Ingest_Fields.InvalidMessage_company_address_type_derived(le.company_address_type_derived_Invalid),Ingest_Fields.InvalidMessage_company_org_structure_derived(le.company_org_structure_derived_Invalid),Ingest_Fields.InvalidMessage_company_name_status_derived(le.company_name_status_derived_Invalid),Ingest_Fields.InvalidMessage_company_status_derived(le.company_status_derived_Invalid),Ingest_Fields.InvalidMessage_contact_type_derived(le.contact_type_derived_Invalid),Ingest_Fields.InvalidMessage_contact_job_title_derived(le.contact_job_title_derived_Invalid),Ingest_Fields.InvalidMessage_contact_status_derived(le.contact_status_derived_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.source_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rcid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.company_bdid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_name_type_raw_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_rawaid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_address_prim_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_address_p_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_v_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_cart_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_cr_sort_sz_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.company_address_lot_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_lot_order_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.company_address_dbpc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_chk_digit_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_rec_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_fips_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_fips_county_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_geo_lat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_geo_long_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_msa_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_geo_blk_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_geo_match_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_err_stat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_type_raw_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_fein_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.best_fein_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.company_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.company_org_structure_raw_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_incorporation_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_sic_code1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_sic_code2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_sic_code3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_sic_code4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_sic_code5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_naics_code1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_naics_code2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_naics_code3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_naics_code4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_naics_code5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_ticker_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_ticker_exchange_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_foreign_domestic_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.company_url_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_inc_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_filing_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_status_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_foreign_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.event_filing_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_name_status_raw_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_status_raw_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_company_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_company_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_company_address_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_company_address_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.vl_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.current_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.source_record_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.glb_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dppa_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.duns_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.is_contact_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_contact_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_contact_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contact_did_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contact_name_fname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contact_name_lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contact_name_name_score_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contact_type_raw_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contact_job_title_raw_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contact_ssn_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contact_dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contact_status_raw_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contact_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.from_hdr_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.company_name_type_derived_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_address_type_derived_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_org_structure_derived_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_name_status_derived_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_status_derived_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contact_type_derived_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contact_job_title_derived_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contact_status_derived_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'source','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','rcid','company_bdid','company_name','company_name_type_raw','company_rawaid','company_address_predir','company_address_prim_name','company_address_postdir','company_address_p_city_name','company_address_v_city_name','company_address_st','company_address_zip','company_address_zip4','company_address_cart','company_address_cr_sort_sz','company_address_lot','company_address_lot_order','company_address_dbpc','company_address_chk_digit','company_address_rec_type','company_address_fips_state','company_address_fips_county','company_address_geo_lat','company_address_geo_long','company_address_msa','company_address_geo_blk','company_address_geo_match','company_address_err_stat','company_address_type_raw','company_fein','best_fein_indicator','company_phone','phone_type','company_org_structure_raw','company_incorporation_date','company_sic_code1','company_sic_code2','company_sic_code3','company_sic_code4','company_sic_code5','company_naics_code1','company_naics_code2','company_naics_code3','company_naics_code4','company_naics_code5','company_ticker','company_ticker_exchange','company_foreign_domestic','company_url','company_inc_state','company_filing_date','company_status_date','company_foreign_date','event_filing_date','company_name_status_raw','company_status_raw','dt_first_seen_company_name','dt_last_seen_company_name','dt_first_seen_company_address','dt_last_seen_company_address','vl_id','current','source_record_id','glb','dppa','duns_number','is_contact','dt_first_seen_contact','dt_last_seen_contact','contact_did','contact_name_fname','contact_name_lname','contact_name_name_score','contact_type_raw','contact_job_title_raw','contact_ssn','contact_dob','contact_status_raw','contact_phone','from_hdr','company_name_type_derived','company_address_type_derived','company_org_structure_derived','company_name_status_derived','company_status_derived','contact_type_derived','contact_job_title_derived','contact_status_derived','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_source','invalid_dt_first_seen','invalid_opt_pastdate8','invalid_dt_vendor_first_reported','invalid_pastdate8','invalid_empty','invalid_mandatory','invalid_mandatory','invalid_company_name_type_raw','invalid_company_rawaid','invalid_direction','invalid_mandatory','invalid_direction','invalid_company_address_p_city_name','invalid_company_address_v_city_name','invalid_st','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_rec_type','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','invalid_company_address_type_raw','invalid_company_fein','invalid_best_fein_indicator','invalid_company_phone','invalid_phone_type','invalid_company_org_structure_raw','invalid_opt_pastdate8','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_company_ticker','invalid_company_ticker_exchange','invalid_company_foreign_domestic','invalid_company_url','invalid_company_inc_state','invalid_opt_pastdate8','invalid_opt_pastdate8','invalid_opt_pastdate8','invalid_opt_pastdate8','invalid_company_name_status_raw','invalid_company_status_raw','invalid_opt_pastdate8','invalid_opt_pastdate8','invalid_opt_pastdate8','invalid_opt_pastdate8','invalid_mandatory','invalid_boolean_1','invalid_mandatory_numeric','invalid_boolean_1','invalid_boolean_1','invalid_duns_number','invalid_is_contact','invalid_opt_pastdate8','invalid_opt_pastdate8','invalid_contact_did','invalid_contact_name_fname','invalid_contact_name_lname','invalid_percentage','invalid_contact_type_raw','invalid_contact_job_title_raw','invalid_contact_ssn','invalid_contact_dob','invalid_contact_status_raw','invalid_contact_phone','invalid_boolean','invalid_company_name_type_derived','invalid_company_address_type_derived','invalid_company_org_structure_derived','invalid_company_name_status_derived','invalid_company_status_derived','invalid_contact_type_derived','invalid_contact_job_title_derived','invalid_contact_status_derived','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.source,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.rcid,(SALT311.StrType)le.company_bdid,(SALT311.StrType)le.company_name,(SALT311.StrType)le.company_name_type_raw,(SALT311.StrType)le.company_rawaid,(SALT311.StrType)le.company_address_predir,(SALT311.StrType)le.company_address_prim_name,(SALT311.StrType)le.company_address_postdir,(SALT311.StrType)le.company_address_p_city_name,(SALT311.StrType)le.company_address_v_city_name,(SALT311.StrType)le.company_address_st,(SALT311.StrType)le.company_address_zip,(SALT311.StrType)le.company_address_zip4,(SALT311.StrType)le.company_address_cart,(SALT311.StrType)le.company_address_cr_sort_sz,(SALT311.StrType)le.company_address_lot,(SALT311.StrType)le.company_address_lot_order,(SALT311.StrType)le.company_address_dbpc,(SALT311.StrType)le.company_address_chk_digit,(SALT311.StrType)le.company_address_rec_type,(SALT311.StrType)le.company_address_fips_state,(SALT311.StrType)le.company_address_fips_county,(SALT311.StrType)le.company_address_geo_lat,(SALT311.StrType)le.company_address_geo_long,(SALT311.StrType)le.company_address_msa,(SALT311.StrType)le.company_address_geo_blk,(SALT311.StrType)le.company_address_geo_match,(SALT311.StrType)le.company_address_err_stat,(SALT311.StrType)le.company_address_type_raw,(SALT311.StrType)le.company_fein,(SALT311.StrType)le.best_fein_indicator,(SALT311.StrType)le.company_phone,(SALT311.StrType)le.phone_type,(SALT311.StrType)le.company_org_structure_raw,(SALT311.StrType)le.company_incorporation_date,(SALT311.StrType)le.company_sic_code1,(SALT311.StrType)le.company_sic_code2,(SALT311.StrType)le.company_sic_code3,(SALT311.StrType)le.company_sic_code4,(SALT311.StrType)le.company_sic_code5,(SALT311.StrType)le.company_naics_code1,(SALT311.StrType)le.company_naics_code2,(SALT311.StrType)le.company_naics_code3,(SALT311.StrType)le.company_naics_code4,(SALT311.StrType)le.company_naics_code5,(SALT311.StrType)le.company_ticker,(SALT311.StrType)le.company_ticker_exchange,(SALT311.StrType)le.company_foreign_domestic,(SALT311.StrType)le.company_url,(SALT311.StrType)le.company_inc_state,(SALT311.StrType)le.company_filing_date,(SALT311.StrType)le.company_status_date,(SALT311.StrType)le.company_foreign_date,(SALT311.StrType)le.event_filing_date,(SALT311.StrType)le.company_name_status_raw,(SALT311.StrType)le.company_status_raw,(SALT311.StrType)le.dt_first_seen_company_name,(SALT311.StrType)le.dt_last_seen_company_name,(SALT311.StrType)le.dt_first_seen_company_address,(SALT311.StrType)le.dt_last_seen_company_address,(SALT311.StrType)le.vl_id,(SALT311.StrType)le.current,(SALT311.StrType)le.source_record_id,(SALT311.StrType)le.glb,(SALT311.StrType)le.dppa,(SALT311.StrType)le.duns_number,(SALT311.StrType)le.is_contact,(SALT311.StrType)le.dt_first_seen_contact,(SALT311.StrType)le.dt_last_seen_contact,(SALT311.StrType)le.contact_did,(SALT311.StrType)le.contact_name_fname,(SALT311.StrType)le.contact_name_lname,(SALT311.StrType)le.contact_name_name_score,(SALT311.StrType)le.contact_type_raw,(SALT311.StrType)le.contact_job_title_raw,(SALT311.StrType)le.contact_ssn,(SALT311.StrType)le.contact_dob,(SALT311.StrType)le.contact_status_raw,(SALT311.StrType)le.contact_phone,(SALT311.StrType)le.from_hdr,(SALT311.StrType)le.company_name_type_derived,(SALT311.StrType)le.company_address_type_derived,(SALT311.StrType)le.company_org_structure_derived,(SALT311.StrType)le.company_name_status_derived,(SALT311.StrType)le.company_status_derived,(SALT311.StrType)le.contact_type_derived,(SALT311.StrType)le.contact_job_title_derived,(SALT311.StrType)le.contact_status_derived,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,93,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Ingest_Layout_BIPV2) prevDS = DATASET([], Ingest_Layout_BIPV2)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source_expanded;
      SELF.ruledesc := CHOOSE(c
          ,'source:invalid_source:CUSTOM'
          ,'dt_first_seen:invalid_dt_first_seen:CUSTOM'
          ,'dt_last_seen:invalid_opt_pastdate8:CUSTOM'
          ,'dt_vendor_first_reported:invalid_dt_vendor_first_reported:CUSTOM'
          ,'dt_vendor_last_reported:invalid_pastdate8:CUSTOM'
          ,'rcid:invalid_empty:ENUM'
          ,'company_bdid:invalid_mandatory:CUSTOM'
          ,'company_name:invalid_mandatory:CUSTOM'
          ,'company_name_type_raw:invalid_company_name_type_raw:CUSTOM'
          ,'company_rawaid:invalid_company_rawaid:CUSTOM'
          ,'company_address_predir:invalid_direction:ALLOW'
          ,'company_address_prim_name:invalid_mandatory:CUSTOM'
          ,'company_address_postdir:invalid_direction:ALLOW'
          ,'company_address_p_city_name:invalid_company_address_p_city_name:CUSTOM'
          ,'company_address_v_city_name:invalid_company_address_v_city_name:CUSTOM'
          ,'company_address_st:invalid_st:CUSTOM'
          ,'company_address_zip:invalid_zip5:CUSTOM'
          ,'company_address_zip4:invalid_zip4:CUSTOM'
          ,'company_address_cart:invalid_cart:CUSTOM'
          ,'company_address_cr_sort_sz:invalid_cr_sort_sz:ENUM'
          ,'company_address_lot:invalid_lot:CUSTOM'
          ,'company_address_lot_order:invalid_lot_order:ENUM'
          ,'company_address_dbpc:invalid_dpbc:CUSTOM'
          ,'company_address_chk_digit:invalid_chk_digit:CUSTOM'
          ,'company_address_rec_type:invalid_rec_type:CUSTOM'
          ,'company_address_fips_state:invalid_fips_state:CUSTOM'
          ,'company_address_fips_county:invalid_fips_county:CUSTOM'
          ,'company_address_geo_lat:invalid_geo:CUSTOM'
          ,'company_address_geo_long:invalid_geo:CUSTOM'
          ,'company_address_msa:invalid_msa:CUSTOM'
          ,'company_address_geo_blk:invalid_geo_blk:CUSTOM'
          ,'company_address_geo_match:invalid_geo_match:CUSTOM'
          ,'company_address_err_stat:invalid_err_stat:CUSTOM'
          ,'company_address_type_raw:invalid_company_address_type_raw:CUSTOM'
          ,'company_fein:invalid_company_fein:CUSTOM'
          ,'best_fein_indicator:invalid_best_fein_indicator:ENUM'
          ,'company_phone:invalid_company_phone:CUSTOM'
          ,'phone_type:invalid_phone_type:ENUM'
          ,'company_org_structure_raw:invalid_company_org_structure_raw:CUSTOM'
          ,'company_incorporation_date:invalid_opt_pastdate8:CUSTOM'
          ,'company_sic_code1:invalid_sic:CUSTOM'
          ,'company_sic_code2:invalid_sic:CUSTOM'
          ,'company_sic_code3:invalid_sic:CUSTOM'
          ,'company_sic_code4:invalid_sic:CUSTOM'
          ,'company_sic_code5:invalid_sic:CUSTOM'
          ,'company_naics_code1:invalid_naics:CUSTOM'
          ,'company_naics_code2:invalid_naics:CUSTOM'
          ,'company_naics_code3:invalid_naics:CUSTOM'
          ,'company_naics_code4:invalid_naics:CUSTOM'
          ,'company_naics_code5:invalid_naics:CUSTOM'
          ,'company_ticker:invalid_company_ticker:CUSTOM'
          ,'company_ticker_exchange:invalid_company_ticker_exchange:CUSTOM'
          ,'company_foreign_domestic:invalid_company_foreign_domestic:ENUM'
          ,'company_url:invalid_company_url:CUSTOM'
          ,'company_inc_state:invalid_company_inc_state:CUSTOM'
          ,'company_filing_date:invalid_opt_pastdate8:CUSTOM'
          ,'company_status_date:invalid_opt_pastdate8:CUSTOM'
          ,'company_foreign_date:invalid_opt_pastdate8:CUSTOM'
          ,'event_filing_date:invalid_opt_pastdate8:CUSTOM'
          ,'company_name_status_raw:invalid_company_name_status_raw:CUSTOM'
          ,'company_status_raw:invalid_company_status_raw:CUSTOM'
          ,'dt_first_seen_company_name:invalid_opt_pastdate8:CUSTOM'
          ,'dt_last_seen_company_name:invalid_opt_pastdate8:CUSTOM'
          ,'dt_first_seen_company_address:invalid_opt_pastdate8:CUSTOM'
          ,'dt_last_seen_company_address:invalid_opt_pastdate8:CUSTOM'
          ,'vl_id:invalid_mandatory:CUSTOM'
          ,'current:invalid_boolean_1:ENUM'
          ,'source_record_id:invalid_mandatory_numeric:CUSTOM'
          ,'glb:invalid_boolean_1:ENUM'
          ,'dppa:invalid_boolean_1:ENUM'
          ,'duns_number:invalid_duns_number:CUSTOM'
          ,'is_contact:invalid_is_contact:CUSTOM'
          ,'dt_first_seen_contact:invalid_opt_pastdate8:CUSTOM'
          ,'dt_last_seen_contact:invalid_opt_pastdate8:CUSTOM'
          ,'contact_did:invalid_contact_did:CUSTOM'
          ,'contact_name_fname:invalid_contact_name_fname:CUSTOM'
          ,'contact_name_lname:invalid_contact_name_lname:CUSTOM'
          ,'contact_name_name_score:invalid_percentage:CUSTOM'
          ,'contact_type_raw:invalid_contact_type_raw:CUSTOM'
          ,'contact_job_title_raw:invalid_contact_job_title_raw:CUSTOM'
          ,'contact_ssn:invalid_contact_ssn:CUSTOM'
          ,'contact_dob:invalid_contact_dob:CUSTOM'
          ,'contact_status_raw:invalid_contact_status_raw:CUSTOM'
          ,'contact_phone:invalid_contact_phone:CUSTOM'
          ,'from_hdr:invalid_boolean:ENUM'
          ,'company_name_type_derived:invalid_company_name_type_derived:CUSTOM'
          ,'company_address_type_derived:invalid_company_address_type_derived:CUSTOM'
          ,'company_org_structure_derived:invalid_company_org_structure_derived:CUSTOM'
          ,'company_name_status_derived:invalid_company_name_status_derived:CUSTOM'
          ,'company_status_derived:invalid_company_status_derived:CUSTOM'
          ,'contact_type_derived:invalid_contact_type_derived:CUSTOM'
          ,'contact_job_title_derived:invalid_contact_job_title_derived:CUSTOM'
          ,'contact_status_derived:invalid_contact_status_derived:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Ingest_Fields.InvalidMessage_source(1)
          ,Ingest_Fields.InvalidMessage_dt_first_seen(1)
          ,Ingest_Fields.InvalidMessage_dt_last_seen(1)
          ,Ingest_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Ingest_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Ingest_Fields.InvalidMessage_rcid(1)
          ,Ingest_Fields.InvalidMessage_company_bdid(1)
          ,Ingest_Fields.InvalidMessage_company_name(1)
          ,Ingest_Fields.InvalidMessage_company_name_type_raw(1)
          ,Ingest_Fields.InvalidMessage_company_rawaid(1)
          ,Ingest_Fields.InvalidMessage_company_address_predir(1)
          ,Ingest_Fields.InvalidMessage_company_address_prim_name(1)
          ,Ingest_Fields.InvalidMessage_company_address_postdir(1)
          ,Ingest_Fields.InvalidMessage_company_address_p_city_name(1)
          ,Ingest_Fields.InvalidMessage_company_address_v_city_name(1)
          ,Ingest_Fields.InvalidMessage_company_address_st(1)
          ,Ingest_Fields.InvalidMessage_company_address_zip(1)
          ,Ingest_Fields.InvalidMessage_company_address_zip4(1)
          ,Ingest_Fields.InvalidMessage_company_address_cart(1)
          ,Ingest_Fields.InvalidMessage_company_address_cr_sort_sz(1)
          ,Ingest_Fields.InvalidMessage_company_address_lot(1)
          ,Ingest_Fields.InvalidMessage_company_address_lot_order(1)
          ,Ingest_Fields.InvalidMessage_company_address_dbpc(1)
          ,Ingest_Fields.InvalidMessage_company_address_chk_digit(1)
          ,Ingest_Fields.InvalidMessage_company_address_rec_type(1)
          ,Ingest_Fields.InvalidMessage_company_address_fips_state(1)
          ,Ingest_Fields.InvalidMessage_company_address_fips_county(1)
          ,Ingest_Fields.InvalidMessage_company_address_geo_lat(1)
          ,Ingest_Fields.InvalidMessage_company_address_geo_long(1)
          ,Ingest_Fields.InvalidMessage_company_address_msa(1)
          ,Ingest_Fields.InvalidMessage_company_address_geo_blk(1)
          ,Ingest_Fields.InvalidMessage_company_address_geo_match(1)
          ,Ingest_Fields.InvalidMessage_company_address_err_stat(1)
          ,Ingest_Fields.InvalidMessage_company_address_type_raw(1)
          ,Ingest_Fields.InvalidMessage_company_fein(1)
          ,Ingest_Fields.InvalidMessage_best_fein_indicator(1)
          ,Ingest_Fields.InvalidMessage_company_phone(1)
          ,Ingest_Fields.InvalidMessage_phone_type(1)
          ,Ingest_Fields.InvalidMessage_company_org_structure_raw(1)
          ,Ingest_Fields.InvalidMessage_company_incorporation_date(1)
          ,Ingest_Fields.InvalidMessage_company_sic_code1(1)
          ,Ingest_Fields.InvalidMessage_company_sic_code2(1)
          ,Ingest_Fields.InvalidMessage_company_sic_code3(1)
          ,Ingest_Fields.InvalidMessage_company_sic_code4(1)
          ,Ingest_Fields.InvalidMessage_company_sic_code5(1)
          ,Ingest_Fields.InvalidMessage_company_naics_code1(1)
          ,Ingest_Fields.InvalidMessage_company_naics_code2(1)
          ,Ingest_Fields.InvalidMessage_company_naics_code3(1)
          ,Ingest_Fields.InvalidMessage_company_naics_code4(1)
          ,Ingest_Fields.InvalidMessage_company_naics_code5(1)
          ,Ingest_Fields.InvalidMessage_company_ticker(1)
          ,Ingest_Fields.InvalidMessage_company_ticker_exchange(1)
          ,Ingest_Fields.InvalidMessage_company_foreign_domestic(1)
          ,Ingest_Fields.InvalidMessage_company_url(1)
          ,Ingest_Fields.InvalidMessage_company_inc_state(1)
          ,Ingest_Fields.InvalidMessage_company_filing_date(1)
          ,Ingest_Fields.InvalidMessage_company_status_date(1)
          ,Ingest_Fields.InvalidMessage_company_foreign_date(1)
          ,Ingest_Fields.InvalidMessage_event_filing_date(1)
          ,Ingest_Fields.InvalidMessage_company_name_status_raw(1)
          ,Ingest_Fields.InvalidMessage_company_status_raw(1)
          ,Ingest_Fields.InvalidMessage_dt_first_seen_company_name(1)
          ,Ingest_Fields.InvalidMessage_dt_last_seen_company_name(1)
          ,Ingest_Fields.InvalidMessage_dt_first_seen_company_address(1)
          ,Ingest_Fields.InvalidMessage_dt_last_seen_company_address(1)
          ,Ingest_Fields.InvalidMessage_vl_id(1)
          ,Ingest_Fields.InvalidMessage_current(1)
          ,Ingest_Fields.InvalidMessage_source_record_id(1)
          ,Ingest_Fields.InvalidMessage_glb(1)
          ,Ingest_Fields.InvalidMessage_dppa(1)
          ,Ingest_Fields.InvalidMessage_duns_number(1)
          ,Ingest_Fields.InvalidMessage_is_contact(1)
          ,Ingest_Fields.InvalidMessage_dt_first_seen_contact(1)
          ,Ingest_Fields.InvalidMessage_dt_last_seen_contact(1)
          ,Ingest_Fields.InvalidMessage_contact_did(1)
          ,Ingest_Fields.InvalidMessage_contact_name_fname(1)
          ,Ingest_Fields.InvalidMessage_contact_name_lname(1)
          ,Ingest_Fields.InvalidMessage_contact_name_name_score(1)
          ,Ingest_Fields.InvalidMessage_contact_type_raw(1)
          ,Ingest_Fields.InvalidMessage_contact_job_title_raw(1)
          ,Ingest_Fields.InvalidMessage_contact_ssn(1)
          ,Ingest_Fields.InvalidMessage_contact_dob(1)
          ,Ingest_Fields.InvalidMessage_contact_status_raw(1)
          ,Ingest_Fields.InvalidMessage_contact_phone(1)
          ,Ingest_Fields.InvalidMessage_from_hdr(1)
          ,Ingest_Fields.InvalidMessage_company_name_type_derived(1)
          ,Ingest_Fields.InvalidMessage_company_address_type_derived(1)
          ,Ingest_Fields.InvalidMessage_company_org_structure_derived(1)
          ,Ingest_Fields.InvalidMessage_company_name_status_derived(1)
          ,Ingest_Fields.InvalidMessage_company_status_derived(1)
          ,Ingest_Fields.InvalidMessage_contact_type_derived(1)
          ,Ingest_Fields.InvalidMessage_contact_job_title_derived(1)
          ,Ingest_Fields.InvalidMessage_contact_status_derived(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.source_CUSTOM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.rcid_ENUM_ErrorCount
          ,le.company_bdid_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.company_name_type_raw_CUSTOM_ErrorCount
          ,le.company_rawaid_CUSTOM_ErrorCount
          ,le.company_address_predir_ALLOW_ErrorCount
          ,le.company_address_prim_name_CUSTOM_ErrorCount
          ,le.company_address_postdir_ALLOW_ErrorCount
          ,le.company_address_p_city_name_CUSTOM_ErrorCount
          ,le.company_address_v_city_name_CUSTOM_ErrorCount
          ,le.company_address_st_CUSTOM_ErrorCount
          ,le.company_address_zip_CUSTOM_ErrorCount
          ,le.company_address_zip4_CUSTOM_ErrorCount
          ,le.company_address_cart_CUSTOM_ErrorCount
          ,le.company_address_cr_sort_sz_ENUM_ErrorCount
          ,le.company_address_lot_CUSTOM_ErrorCount
          ,le.company_address_lot_order_ENUM_ErrorCount
          ,le.company_address_dbpc_CUSTOM_ErrorCount
          ,le.company_address_chk_digit_CUSTOM_ErrorCount
          ,le.company_address_rec_type_CUSTOM_ErrorCount
          ,le.company_address_fips_state_CUSTOM_ErrorCount
          ,le.company_address_fips_county_CUSTOM_ErrorCount
          ,le.company_address_geo_lat_CUSTOM_ErrorCount
          ,le.company_address_geo_long_CUSTOM_ErrorCount
          ,le.company_address_msa_CUSTOM_ErrorCount
          ,le.company_address_geo_blk_CUSTOM_ErrorCount
          ,le.company_address_geo_match_CUSTOM_ErrorCount
          ,le.company_address_err_stat_CUSTOM_ErrorCount
          ,le.company_address_type_raw_CUSTOM_ErrorCount
          ,le.company_fein_CUSTOM_ErrorCount
          ,le.best_fein_indicator_ENUM_ErrorCount
          ,le.company_phone_CUSTOM_ErrorCount
          ,le.phone_type_ENUM_ErrorCount
          ,le.company_org_structure_raw_CUSTOM_ErrorCount
          ,le.company_incorporation_date_CUSTOM_ErrorCount
          ,le.company_sic_code1_CUSTOM_ErrorCount
          ,le.company_sic_code2_CUSTOM_ErrorCount
          ,le.company_sic_code3_CUSTOM_ErrorCount
          ,le.company_sic_code4_CUSTOM_ErrorCount
          ,le.company_sic_code5_CUSTOM_ErrorCount
          ,le.company_naics_code1_CUSTOM_ErrorCount
          ,le.company_naics_code2_CUSTOM_ErrorCount
          ,le.company_naics_code3_CUSTOM_ErrorCount
          ,le.company_naics_code4_CUSTOM_ErrorCount
          ,le.company_naics_code5_CUSTOM_ErrorCount
          ,le.company_ticker_CUSTOM_ErrorCount
          ,le.company_ticker_exchange_CUSTOM_ErrorCount
          ,le.company_foreign_domestic_ENUM_ErrorCount
          ,le.company_url_CUSTOM_ErrorCount
          ,le.company_inc_state_CUSTOM_ErrorCount
          ,le.company_filing_date_CUSTOM_ErrorCount
          ,le.company_status_date_CUSTOM_ErrorCount
          ,le.company_foreign_date_CUSTOM_ErrorCount
          ,le.event_filing_date_CUSTOM_ErrorCount
          ,le.company_name_status_raw_CUSTOM_ErrorCount
          ,le.company_status_raw_CUSTOM_ErrorCount
          ,le.dt_first_seen_company_name_CUSTOM_ErrorCount
          ,le.dt_last_seen_company_name_CUSTOM_ErrorCount
          ,le.dt_first_seen_company_address_CUSTOM_ErrorCount
          ,le.dt_last_seen_company_address_CUSTOM_ErrorCount
          ,le.vl_id_CUSTOM_ErrorCount
          ,le.current_ENUM_ErrorCount
          ,le.source_record_id_CUSTOM_ErrorCount
          ,le.glb_ENUM_ErrorCount
          ,le.dppa_ENUM_ErrorCount
          ,le.duns_number_CUSTOM_ErrorCount
          ,le.is_contact_CUSTOM_ErrorCount
          ,le.dt_first_seen_contact_CUSTOM_ErrorCount
          ,le.dt_last_seen_contact_CUSTOM_ErrorCount
          ,le.contact_did_CUSTOM_ErrorCount
          ,le.contact_name_fname_CUSTOM_ErrorCount
          ,le.contact_name_lname_CUSTOM_ErrorCount
          ,le.contact_name_name_score_CUSTOM_ErrorCount
          ,le.contact_type_raw_CUSTOM_ErrorCount
          ,le.contact_job_title_raw_CUSTOM_ErrorCount
          ,le.contact_ssn_CUSTOM_ErrorCount
          ,le.contact_dob_CUSTOM_ErrorCount
          ,le.contact_status_raw_CUSTOM_ErrorCount
          ,le.contact_phone_CUSTOM_ErrorCount
          ,le.from_hdr_ENUM_ErrorCount
          ,le.company_name_type_derived_CUSTOM_ErrorCount
          ,le.company_address_type_derived_CUSTOM_ErrorCount
          ,le.company_org_structure_derived_CUSTOM_ErrorCount
          ,le.company_name_status_derived_CUSTOM_ErrorCount
          ,le.company_status_derived_CUSTOM_ErrorCount
          ,le.contact_type_derived_CUSTOM_ErrorCount
          ,le.contact_job_title_derived_CUSTOM_ErrorCount
          ,le.contact_status_derived_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.source_CUSTOM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.rcid_ENUM_ErrorCount
          ,le.company_bdid_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.company_name_type_raw_CUSTOM_ErrorCount
          ,le.company_rawaid_CUSTOM_ErrorCount
          ,le.company_address_predir_ALLOW_ErrorCount
          ,le.company_address_prim_name_CUSTOM_ErrorCount
          ,le.company_address_postdir_ALLOW_ErrorCount
          ,le.company_address_p_city_name_CUSTOM_ErrorCount
          ,le.company_address_v_city_name_CUSTOM_ErrorCount
          ,le.company_address_st_CUSTOM_ErrorCount
          ,le.company_address_zip_CUSTOM_ErrorCount
          ,le.company_address_zip4_CUSTOM_ErrorCount
          ,le.company_address_cart_CUSTOM_ErrorCount
          ,le.company_address_cr_sort_sz_ENUM_ErrorCount
          ,le.company_address_lot_CUSTOM_ErrorCount
          ,le.company_address_lot_order_ENUM_ErrorCount
          ,le.company_address_dbpc_CUSTOM_ErrorCount
          ,le.company_address_chk_digit_CUSTOM_ErrorCount
          ,le.company_address_rec_type_CUSTOM_ErrorCount
          ,le.company_address_fips_state_CUSTOM_ErrorCount
          ,le.company_address_fips_county_CUSTOM_ErrorCount
          ,le.company_address_geo_lat_CUSTOM_ErrorCount
          ,le.company_address_geo_long_CUSTOM_ErrorCount
          ,le.company_address_msa_CUSTOM_ErrorCount
          ,le.company_address_geo_blk_CUSTOM_ErrorCount
          ,le.company_address_geo_match_CUSTOM_ErrorCount
          ,le.company_address_err_stat_CUSTOM_ErrorCount
          ,le.company_address_type_raw_CUSTOM_ErrorCount
          ,le.company_fein_CUSTOM_ErrorCount
          ,le.best_fein_indicator_ENUM_ErrorCount
          ,le.company_phone_CUSTOM_ErrorCount
          ,le.phone_type_ENUM_ErrorCount
          ,le.company_org_structure_raw_CUSTOM_ErrorCount
          ,le.company_incorporation_date_CUSTOM_ErrorCount
          ,le.company_sic_code1_CUSTOM_ErrorCount
          ,le.company_sic_code2_CUSTOM_ErrorCount
          ,le.company_sic_code3_CUSTOM_ErrorCount
          ,le.company_sic_code4_CUSTOM_ErrorCount
          ,le.company_sic_code5_CUSTOM_ErrorCount
          ,le.company_naics_code1_CUSTOM_ErrorCount
          ,le.company_naics_code2_CUSTOM_ErrorCount
          ,le.company_naics_code3_CUSTOM_ErrorCount
          ,le.company_naics_code4_CUSTOM_ErrorCount
          ,le.company_naics_code5_CUSTOM_ErrorCount
          ,le.company_ticker_CUSTOM_ErrorCount
          ,le.company_ticker_exchange_CUSTOM_ErrorCount
          ,le.company_foreign_domestic_ENUM_ErrorCount
          ,le.company_url_CUSTOM_ErrorCount
          ,le.company_inc_state_CUSTOM_ErrorCount
          ,le.company_filing_date_CUSTOM_ErrorCount
          ,le.company_status_date_CUSTOM_ErrorCount
          ,le.company_foreign_date_CUSTOM_ErrorCount
          ,le.event_filing_date_CUSTOM_ErrorCount
          ,le.company_name_status_raw_CUSTOM_ErrorCount
          ,le.company_status_raw_CUSTOM_ErrorCount
          ,le.dt_first_seen_company_name_CUSTOM_ErrorCount
          ,le.dt_last_seen_company_name_CUSTOM_ErrorCount
          ,le.dt_first_seen_company_address_CUSTOM_ErrorCount
          ,le.dt_last_seen_company_address_CUSTOM_ErrorCount
          ,le.vl_id_CUSTOM_ErrorCount
          ,le.current_ENUM_ErrorCount
          ,le.source_record_id_CUSTOM_ErrorCount
          ,le.glb_ENUM_ErrorCount
          ,le.dppa_ENUM_ErrorCount
          ,le.duns_number_CUSTOM_ErrorCount
          ,le.is_contact_CUSTOM_ErrorCount
          ,le.dt_first_seen_contact_CUSTOM_ErrorCount
          ,le.dt_last_seen_contact_CUSTOM_ErrorCount
          ,le.contact_did_CUSTOM_ErrorCount
          ,le.contact_name_fname_CUSTOM_ErrorCount
          ,le.contact_name_lname_CUSTOM_ErrorCount
          ,le.contact_name_name_score_CUSTOM_ErrorCount
          ,le.contact_type_raw_CUSTOM_ErrorCount
          ,le.contact_job_title_raw_CUSTOM_ErrorCount
          ,le.contact_ssn_CUSTOM_ErrorCount
          ,le.contact_dob_CUSTOM_ErrorCount
          ,le.contact_status_raw_CUSTOM_ErrorCount
          ,le.contact_phone_CUSTOM_ErrorCount
          ,le.from_hdr_ENUM_ErrorCount
          ,le.company_name_type_derived_CUSTOM_ErrorCount
          ,le.company_address_type_derived_CUSTOM_ErrorCount
          ,le.company_org_structure_derived_CUSTOM_ErrorCount
          ,le.company_name_status_derived_CUSTOM_ErrorCount
          ,le.company_status_derived_CUSTOM_ErrorCount
          ,le.contact_type_derived_CUSTOM_ErrorCount
          ,le.contact_job_title_derived_CUSTOM_ErrorCount
          ,le.contact_status_derived_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    jGlob := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    jSrc := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    j := IF(Glob, jGlob, jSrc);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Ingest_hygiene(PROJECT(h, Ingest_Layout_BIPV2));
    hygiene_summaryStats := mod_hygiene.Summary('', Glob);
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := CHOOSE(c
          ,'source_expanded:' + getFieldTypeText(h.source_expanded) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source:' + getFieldTypeText(h.source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rcid:' + getFieldTypeText(h.rcid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_bdid:' + getFieldTypeText(h.company_bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name_type_raw:' + getFieldTypeText(h.company_name_type_raw) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_rawaid:' + getFieldTypeText(h.company_rawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_prim_range:' + getFieldTypeText(h.company_address_prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_predir:' + getFieldTypeText(h.company_address_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_prim_name:' + getFieldTypeText(h.company_address_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_addr_suffix:' + getFieldTypeText(h.company_address_addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_postdir:' + getFieldTypeText(h.company_address_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_unit_desig:' + getFieldTypeText(h.company_address_unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_sec_range:' + getFieldTypeText(h.company_address_sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_p_city_name:' + getFieldTypeText(h.company_address_p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_v_city_name:' + getFieldTypeText(h.company_address_v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_st:' + getFieldTypeText(h.company_address_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_zip:' + getFieldTypeText(h.company_address_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_zip4:' + getFieldTypeText(h.company_address_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_cart:' + getFieldTypeText(h.company_address_cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_cr_sort_sz:' + getFieldTypeText(h.company_address_cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_lot:' + getFieldTypeText(h.company_address_lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_lot_order:' + getFieldTypeText(h.company_address_lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_dbpc:' + getFieldTypeText(h.company_address_dbpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_chk_digit:' + getFieldTypeText(h.company_address_chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_rec_type:' + getFieldTypeText(h.company_address_rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_fips_state:' + getFieldTypeText(h.company_address_fips_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_fips_county:' + getFieldTypeText(h.company_address_fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_geo_lat:' + getFieldTypeText(h.company_address_geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_geo_long:' + getFieldTypeText(h.company_address_geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_msa:' + getFieldTypeText(h.company_address_msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_geo_blk:' + getFieldTypeText(h.company_address_geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_geo_match:' + getFieldTypeText(h.company_address_geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_err_stat:' + getFieldTypeText(h.company_address_err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_type_raw:' + getFieldTypeText(h.company_address_type_raw) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_category:' + getFieldTypeText(h.company_address_category) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_country_code:' + getFieldTypeText(h.company_address_country_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_fein:' + getFieldTypeText(h.company_fein) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'best_fein_indicator:' + getFieldTypeText(h.best_fein_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_phone:' + getFieldTypeText(h.company_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_type:' + getFieldTypeText(h.phone_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_org_structure_raw:' + getFieldTypeText(h.company_org_structure_raw) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_incorporation_date:' + getFieldTypeText(h.company_incorporation_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_sic_code1:' + getFieldTypeText(h.company_sic_code1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_sic_code2:' + getFieldTypeText(h.company_sic_code2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_sic_code3:' + getFieldTypeText(h.company_sic_code3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_sic_code4:' + getFieldTypeText(h.company_sic_code4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_sic_code5:' + getFieldTypeText(h.company_sic_code5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_naics_code1:' + getFieldTypeText(h.company_naics_code1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_naics_code2:' + getFieldTypeText(h.company_naics_code2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_naics_code3:' + getFieldTypeText(h.company_naics_code3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_naics_code4:' + getFieldTypeText(h.company_naics_code4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_naics_code5:' + getFieldTypeText(h.company_naics_code5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_ticker:' + getFieldTypeText(h.company_ticker) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_ticker_exchange:' + getFieldTypeText(h.company_ticker_exchange) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_foreign_domestic:' + getFieldTypeText(h.company_foreign_domestic) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_url:' + getFieldTypeText(h.company_url) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_inc_state:' + getFieldTypeText(h.company_inc_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_charter_number:' + getFieldTypeText(h.company_charter_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_filing_date:' + getFieldTypeText(h.company_filing_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_status_date:' + getFieldTypeText(h.company_status_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_foreign_date:' + getFieldTypeText(h.company_foreign_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'event_filing_date:' + getFieldTypeText(h.event_filing_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name_status_raw:' + getFieldTypeText(h.company_name_status_raw) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_status_raw:' + getFieldTypeText(h.company_status_raw) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen_company_name:' + getFieldTypeText(h.dt_first_seen_company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen_company_name:' + getFieldTypeText(h.dt_last_seen_company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen_company_address:' + getFieldTypeText(h.dt_first_seen_company_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen_company_address:' + getFieldTypeText(h.dt_last_seen_company_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vl_id:' + getFieldTypeText(h.vl_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current:' + getFieldTypeText(h.current) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_record_id:' + getFieldTypeText(h.source_record_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'glb:' + getFieldTypeText(h.glb) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dppa:' + getFieldTypeText(h.dppa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_score:' + getFieldTypeText(h.phone_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'match_company_name:' + getFieldTypeText(h.match_company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'match_branch_city:' + getFieldTypeText(h.match_branch_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'match_geo_city:' + getFieldTypeText(h.match_geo_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'duns_number:' + getFieldTypeText(h.duns_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_docid:' + getFieldTypeText(h.source_docid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'is_contact:' + getFieldTypeText(h.is_contact) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen_contact:' + getFieldTypeText(h.dt_first_seen_contact) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen_contact:' + getFieldTypeText(h.dt_last_seen_contact) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_did:' + getFieldTypeText(h.contact_did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_name_title:' + getFieldTypeText(h.contact_name_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_name_fname:' + getFieldTypeText(h.contact_name_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_name_lname:' + getFieldTypeText(h.contact_name_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_name_name_suffix:' + getFieldTypeText(h.contact_name_name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_name_name_score:' + getFieldTypeText(h.contact_name_name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_type_raw:' + getFieldTypeText(h.contact_type_raw) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_job_title_raw:' + getFieldTypeText(h.contact_job_title_raw) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_ssn:' + getFieldTypeText(h.contact_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_dob:' + getFieldTypeText(h.contact_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_status_raw:' + getFieldTypeText(h.contact_status_raw) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_email:' + getFieldTypeText(h.contact_email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_email_username:' + getFieldTypeText(h.contact_email_username) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_email_domain:' + getFieldTypeText(h.contact_email_domain) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_phone:' + getFieldTypeText(h.contact_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cid:' + getFieldTypeText(h.cid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_score:' + getFieldTypeText(h.contact_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'from_hdr:' + getFieldTypeText(h.from_hdr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_department:' + getFieldTypeText(h.company_department) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_aceaid:' + getFieldTypeText(h.company_aceaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name_type_derived:' + getFieldTypeText(h.company_name_type_derived) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_address_type_derived:' + getFieldTypeText(h.company_address_type_derived) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_org_structure_derived:' + getFieldTypeText(h.company_org_structure_derived) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name_status_derived:' + getFieldTypeText(h.company_name_status_derived) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_status_derived:' + getFieldTypeText(h.company_status_derived) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxid_status_private:' + getFieldTypeText(h.proxid_status_private) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powid_status_private:' + getFieldTypeText(h.powid_status_private) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleid_status_private:' + getFieldTypeText(h.seleid_status_private) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid_status_private:' + getFieldTypeText(h.orgid_status_private) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultid_status_private:' + getFieldTypeText(h.ultid_status_private) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxid_status_public:' + getFieldTypeText(h.proxid_status_public) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powid_status_public:' + getFieldTypeText(h.powid_status_public) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleid_status_public:' + getFieldTypeText(h.seleid_status_public) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid_status_public:' + getFieldTypeText(h.orgid_status_public) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultid_status_public:' + getFieldTypeText(h.ultid_status_public) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_type_derived:' + getFieldTypeText(h.contact_type_derived) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_job_title_derived:' + getFieldTypeText(h.contact_job_title_derived) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_status_derived:' + getFieldTypeText(h.contact_status_derived) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_type_derived:' + getFieldTypeText(h.address_type_derived) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'is_vanity_name_derived:' + getFieldTypeText(h.is_vanity_name_derived) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_source_expanded_cnt
          ,le.populated_source_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_rcid_cnt
          ,le.populated_company_bdid_cnt
          ,le.populated_company_name_cnt
          ,le.populated_company_name_type_raw_cnt
          ,le.populated_company_rawaid_cnt
          ,le.populated_company_address_prim_range_cnt
          ,le.populated_company_address_predir_cnt
          ,le.populated_company_address_prim_name_cnt
          ,le.populated_company_address_addr_suffix_cnt
          ,le.populated_company_address_postdir_cnt
          ,le.populated_company_address_unit_desig_cnt
          ,le.populated_company_address_sec_range_cnt
          ,le.populated_company_address_p_city_name_cnt
          ,le.populated_company_address_v_city_name_cnt
          ,le.populated_company_address_st_cnt
          ,le.populated_company_address_zip_cnt
          ,le.populated_company_address_zip4_cnt
          ,le.populated_company_address_cart_cnt
          ,le.populated_company_address_cr_sort_sz_cnt
          ,le.populated_company_address_lot_cnt
          ,le.populated_company_address_lot_order_cnt
          ,le.populated_company_address_dbpc_cnt
          ,le.populated_company_address_chk_digit_cnt
          ,le.populated_company_address_rec_type_cnt
          ,le.populated_company_address_fips_state_cnt
          ,le.populated_company_address_fips_county_cnt
          ,le.populated_company_address_geo_lat_cnt
          ,le.populated_company_address_geo_long_cnt
          ,le.populated_company_address_msa_cnt
          ,le.populated_company_address_geo_blk_cnt
          ,le.populated_company_address_geo_match_cnt
          ,le.populated_company_address_err_stat_cnt
          ,le.populated_company_address_type_raw_cnt
          ,le.populated_company_address_category_cnt
          ,le.populated_company_address_country_code_cnt
          ,le.populated_company_fein_cnt
          ,le.populated_best_fein_indicator_cnt
          ,le.populated_company_phone_cnt
          ,le.populated_phone_type_cnt
          ,le.populated_company_org_structure_raw_cnt
          ,le.populated_company_incorporation_date_cnt
          ,le.populated_company_sic_code1_cnt
          ,le.populated_company_sic_code2_cnt
          ,le.populated_company_sic_code3_cnt
          ,le.populated_company_sic_code4_cnt
          ,le.populated_company_sic_code5_cnt
          ,le.populated_company_naics_code1_cnt
          ,le.populated_company_naics_code2_cnt
          ,le.populated_company_naics_code3_cnt
          ,le.populated_company_naics_code4_cnt
          ,le.populated_company_naics_code5_cnt
          ,le.populated_company_ticker_cnt
          ,le.populated_company_ticker_exchange_cnt
          ,le.populated_company_foreign_domestic_cnt
          ,le.populated_company_url_cnt
          ,le.populated_company_inc_state_cnt
          ,le.populated_company_charter_number_cnt
          ,le.populated_company_filing_date_cnt
          ,le.populated_company_status_date_cnt
          ,le.populated_company_foreign_date_cnt
          ,le.populated_event_filing_date_cnt
          ,le.populated_company_name_status_raw_cnt
          ,le.populated_company_status_raw_cnt
          ,le.populated_dt_first_seen_company_name_cnt
          ,le.populated_dt_last_seen_company_name_cnt
          ,le.populated_dt_first_seen_company_address_cnt
          ,le.populated_dt_last_seen_company_address_cnt
          ,le.populated_vl_id_cnt
          ,le.populated_current_cnt
          ,le.populated_source_record_id_cnt
          ,le.populated_glb_cnt
          ,le.populated_dppa_cnt
          ,le.populated_phone_score_cnt
          ,le.populated_match_company_name_cnt
          ,le.populated_match_branch_city_cnt
          ,le.populated_match_geo_city_cnt
          ,le.populated_duns_number_cnt
          ,le.populated_source_docid_cnt
          ,le.populated_is_contact_cnt
          ,le.populated_dt_first_seen_contact_cnt
          ,le.populated_dt_last_seen_contact_cnt
          ,le.populated_contact_did_cnt
          ,le.populated_contact_name_title_cnt
          ,le.populated_contact_name_fname_cnt
          ,le.populated_contact_name_lname_cnt
          ,le.populated_contact_name_name_suffix_cnt
          ,le.populated_contact_name_name_score_cnt
          ,le.populated_contact_type_raw_cnt
          ,le.populated_contact_job_title_raw_cnt
          ,le.populated_contact_ssn_cnt
          ,le.populated_contact_dob_cnt
          ,le.populated_contact_status_raw_cnt
          ,le.populated_contact_email_cnt
          ,le.populated_contact_email_username_cnt
          ,le.populated_contact_email_domain_cnt
          ,le.populated_contact_phone_cnt
          ,le.populated_cid_cnt
          ,le.populated_contact_score_cnt
          ,le.populated_from_hdr_cnt
          ,le.populated_company_department_cnt
          ,le.populated_company_aceaid_cnt
          ,le.populated_company_name_type_derived_cnt
          ,le.populated_company_address_type_derived_cnt
          ,le.populated_company_org_structure_derived_cnt
          ,le.populated_company_name_status_derived_cnt
          ,le.populated_company_status_derived_cnt
          ,le.populated_proxid_status_private_cnt
          ,le.populated_powid_status_private_cnt
          ,le.populated_seleid_status_private_cnt
          ,le.populated_orgid_status_private_cnt
          ,le.populated_ultid_status_private_cnt
          ,le.populated_proxid_status_public_cnt
          ,le.populated_powid_status_public_cnt
          ,le.populated_seleid_status_public_cnt
          ,le.populated_orgid_status_public_cnt
          ,le.populated_ultid_status_public_cnt
          ,le.populated_contact_type_derived_cnt
          ,le.populated_contact_job_title_derived_cnt
          ,le.populated_contact_status_derived_cnt
          ,le.populated_address_type_derived_cnt
          ,le.populated_is_vanity_name_derived_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_source_expanded_pcnt
          ,le.populated_source_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_rcid_pcnt
          ,le.populated_company_bdid_pcnt
          ,le.populated_company_name_pcnt
          ,le.populated_company_name_type_raw_pcnt
          ,le.populated_company_rawaid_pcnt
          ,le.populated_company_address_prim_range_pcnt
          ,le.populated_company_address_predir_pcnt
          ,le.populated_company_address_prim_name_pcnt
          ,le.populated_company_address_addr_suffix_pcnt
          ,le.populated_company_address_postdir_pcnt
          ,le.populated_company_address_unit_desig_pcnt
          ,le.populated_company_address_sec_range_pcnt
          ,le.populated_company_address_p_city_name_pcnt
          ,le.populated_company_address_v_city_name_pcnt
          ,le.populated_company_address_st_pcnt
          ,le.populated_company_address_zip_pcnt
          ,le.populated_company_address_zip4_pcnt
          ,le.populated_company_address_cart_pcnt
          ,le.populated_company_address_cr_sort_sz_pcnt
          ,le.populated_company_address_lot_pcnt
          ,le.populated_company_address_lot_order_pcnt
          ,le.populated_company_address_dbpc_pcnt
          ,le.populated_company_address_chk_digit_pcnt
          ,le.populated_company_address_rec_type_pcnt
          ,le.populated_company_address_fips_state_pcnt
          ,le.populated_company_address_fips_county_pcnt
          ,le.populated_company_address_geo_lat_pcnt
          ,le.populated_company_address_geo_long_pcnt
          ,le.populated_company_address_msa_pcnt
          ,le.populated_company_address_geo_blk_pcnt
          ,le.populated_company_address_geo_match_pcnt
          ,le.populated_company_address_err_stat_pcnt
          ,le.populated_company_address_type_raw_pcnt
          ,le.populated_company_address_category_pcnt
          ,le.populated_company_address_country_code_pcnt
          ,le.populated_company_fein_pcnt
          ,le.populated_best_fein_indicator_pcnt
          ,le.populated_company_phone_pcnt
          ,le.populated_phone_type_pcnt
          ,le.populated_company_org_structure_raw_pcnt
          ,le.populated_company_incorporation_date_pcnt
          ,le.populated_company_sic_code1_pcnt
          ,le.populated_company_sic_code2_pcnt
          ,le.populated_company_sic_code3_pcnt
          ,le.populated_company_sic_code4_pcnt
          ,le.populated_company_sic_code5_pcnt
          ,le.populated_company_naics_code1_pcnt
          ,le.populated_company_naics_code2_pcnt
          ,le.populated_company_naics_code3_pcnt
          ,le.populated_company_naics_code4_pcnt
          ,le.populated_company_naics_code5_pcnt
          ,le.populated_company_ticker_pcnt
          ,le.populated_company_ticker_exchange_pcnt
          ,le.populated_company_foreign_domestic_pcnt
          ,le.populated_company_url_pcnt
          ,le.populated_company_inc_state_pcnt
          ,le.populated_company_charter_number_pcnt
          ,le.populated_company_filing_date_pcnt
          ,le.populated_company_status_date_pcnt
          ,le.populated_company_foreign_date_pcnt
          ,le.populated_event_filing_date_pcnt
          ,le.populated_company_name_status_raw_pcnt
          ,le.populated_company_status_raw_pcnt
          ,le.populated_dt_first_seen_company_name_pcnt
          ,le.populated_dt_last_seen_company_name_pcnt
          ,le.populated_dt_first_seen_company_address_pcnt
          ,le.populated_dt_last_seen_company_address_pcnt
          ,le.populated_vl_id_pcnt
          ,le.populated_current_pcnt
          ,le.populated_source_record_id_pcnt
          ,le.populated_glb_pcnt
          ,le.populated_dppa_pcnt
          ,le.populated_phone_score_pcnt
          ,le.populated_match_company_name_pcnt
          ,le.populated_match_branch_city_pcnt
          ,le.populated_match_geo_city_pcnt
          ,le.populated_duns_number_pcnt
          ,le.populated_source_docid_pcnt
          ,le.populated_is_contact_pcnt
          ,le.populated_dt_first_seen_contact_pcnt
          ,le.populated_dt_last_seen_contact_pcnt
          ,le.populated_contact_did_pcnt
          ,le.populated_contact_name_title_pcnt
          ,le.populated_contact_name_fname_pcnt
          ,le.populated_contact_name_lname_pcnt
          ,le.populated_contact_name_name_suffix_pcnt
          ,le.populated_contact_name_name_score_pcnt
          ,le.populated_contact_type_raw_pcnt
          ,le.populated_contact_job_title_raw_pcnt
          ,le.populated_contact_ssn_pcnt
          ,le.populated_contact_dob_pcnt
          ,le.populated_contact_status_raw_pcnt
          ,le.populated_contact_email_pcnt
          ,le.populated_contact_email_username_pcnt
          ,le.populated_contact_email_domain_pcnt
          ,le.populated_contact_phone_pcnt
          ,le.populated_cid_pcnt
          ,le.populated_contact_score_pcnt
          ,le.populated_from_hdr_pcnt
          ,le.populated_company_department_pcnt
          ,le.populated_company_aceaid_pcnt
          ,le.populated_company_name_type_derived_pcnt
          ,le.populated_company_address_type_derived_pcnt
          ,le.populated_company_org_structure_derived_pcnt
          ,le.populated_company_name_status_derived_pcnt
          ,le.populated_company_status_derived_pcnt
          ,le.populated_proxid_status_private_pcnt
          ,le.populated_powid_status_private_pcnt
          ,le.populated_seleid_status_private_pcnt
          ,le.populated_orgid_status_private_pcnt
          ,le.populated_ultid_status_private_pcnt
          ,le.populated_proxid_status_public_pcnt
          ,le.populated_powid_status_public_pcnt
          ,le.populated_seleid_status_public_pcnt
          ,le.populated_orgid_status_public_pcnt
          ,le.populated_ultid_status_public_pcnt
          ,le.populated_contact_type_derived_pcnt
          ,le.populated_contact_job_title_derived_pcnt
          ,le.populated_contact_status_derived_pcnt
          ,le.populated_address_type_derived_pcnt
          ,le.populated_is_vanity_name_derived_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,127,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Ingest_Delta(prevDS, PROJECT(h, Ingest_Layout_BIPV2));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),127,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Ingest_Layout_BIPV2) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_BIPV2, Ingest_Fields, 'RECORDOF(scrubsSummaryOverall)', 'source_expanded');
  scrubsSummaryPerSource_Standard := NORMALIZE(scrubsSummaryPerSource, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsPerSource := mod_fromexpandedPerSource.AllErrors;
  tErrsPerSource := TABLE(DISTRIBUTE(allErrsPerSource, HASH(src, FieldName, ErrorType)), {src, FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, src, FieldName, ErrorType, FieldContents, LOCAL);
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryPerSource_Standard_addErr := IF(doErrorPerSrc,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryPerSource_Standard, HASH(source, field, ruletype)), source, field, ruletype, LOCAL),
  	                                                       SORT(tErrsPerSource, src, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.source = RIGHT.src AND LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryPerSource_Standard_GeneralErrs := IF(doErrorPerSrc, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryPerSource, source_expanded, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryPerSource_Standard_addErr & scrubsSummaryPerSource_Standard_GeneralErrs & scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;

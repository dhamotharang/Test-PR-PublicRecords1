IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
  EXPORT InValidMessage_invalid_dob_dates(UNSIGNED1 wh) := CHOOSE(wh, 'dob_Invalid', 'process_date_Invalid', 'dob_process_date_Condition_Invalid');
  EXPORT InValidMessage_invalid_dod_dates(UNSIGNED1 wh) := CHOOSE(wh, 'dod_Invalid', 'process_date_Invalid', 'dod_process_date_Condition_Invalid');
  EXPORT InValidMessage_invalid_age_dates(UNSIGNED1 wh) := CHOOSE(wh, 'dob_Invalid', 'dod_Invalid', 'dob_dod_Condition_Invalid');
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_Death_Master_Supplemental)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 source_state_Invalid;
    UNSIGNED1 certificate_vol_no_Invalid;
    UNSIGNED1 certificate_vol_year_Invalid;
    UNSIGNED1 publication_Invalid;
    UNSIGNED1 decedent_name_Invalid;
    UNSIGNED1 decedent_race_Invalid;
    UNSIGNED1 decedent_origin_Invalid;
    UNSIGNED1 decedent_sex_Invalid;
    UNSIGNED1 decedent_age_Invalid;
    UNSIGNED1 education_Invalid;
    UNSIGNED1 occupation_Invalid;
    UNSIGNED1 where_worked_Invalid;
    UNSIGNED1 cause_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 dod_Invalid;
    UNSIGNED1 birthplace_Invalid;
    UNSIGNED1 marital_status_Invalid;
    UNSIGNED1 father_Invalid;
    UNSIGNED1 mother_Invalid;
    UNSIGNED1 filed_date_Invalid;
    UNSIGNED1 year_Invalid;
    UNSIGNED1 county_residence_Invalid;
    UNSIGNED1 county_death_Invalid;
    UNSIGNED1 address_Invalid;
    UNSIGNED1 autopsy_Invalid;
    UNSIGNED1 autopsy_findings_Invalid;
    UNSIGNED1 primary_cause_of_death_Invalid;
    UNSIGNED1 underlying_cause_of_death_Invalid;
    UNSIGNED1 med_exam_Invalid;
    UNSIGNED1 est_lic_no_Invalid;
    UNSIGNED1 disposition_Invalid;
    UNSIGNED1 disposition_date_Invalid;
    UNSIGNED1 work_injury_Invalid;
    UNSIGNED1 injury_date_Invalid;
    UNSIGNED1 injury_type_Invalid;
    UNSIGNED1 injury_location_Invalid;
    UNSIGNED1 surg_performed_Invalid;
    UNSIGNED1 surgery_date_Invalid;
    UNSIGNED1 hospital_status_Invalid;
    UNSIGNED1 pregnancy_Invalid;
    UNSIGNED1 facility_death_Invalid;
    UNSIGNED1 embalmer_lic_no_Invalid;
    UNSIGNED1 death_type_Invalid;
    UNSIGNED1 time_death_Invalid;
    UNSIGNED1 birth_cert_Invalid;
    UNSIGNED1 certifier_Invalid;
    UNSIGNED1 cert_number_Invalid;
    UNSIGNED1 birth_vol_year_Invalid;
    UNSIGNED1 local_file_no_Invalid;
    UNSIGNED1 vdi_Invalid;
    UNSIGNED1 cite_id_Invalid;
    UNSIGNED1 file_id_Invalid;
    UNSIGNED1 date_last_trans_Invalid;
    UNSIGNED1 amendment_code_Invalid;
    UNSIGNED1 amendment_year_Invalid;
    UNSIGNED1 _on_lexis_Invalid;
    UNSIGNED1 _fs_profile_Invalid;
    UNSIGNED1 us_armed_forces_Invalid;
    UNSIGNED1 place_of_death_Invalid;
    UNSIGNED1 state_death_id_Invalid;
    UNSIGNED1 state_death_flag_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 name_score_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 addr_suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_desig_Invalid;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip5_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 cart_Invalid;
    UNSIGNED1 cr_sort_sz_Invalid;
    UNSIGNED1 lot_Invalid;
    UNSIGNED1 lot_order_Invalid;
    UNSIGNED1 dpbc_Invalid;
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
    UNSIGNED1 rawaid_Invalid;
    UNSIGNED1 orig_address1_Invalid;
    UNSIGNED1 orig_address2_Invalid;
    UNSIGNED1 statefn_Invalid;
    UNSIGNED1 lf_Invalid;
    UNSIGNED1 invalid_dob_dates_Invalid;
    UNSIGNED1 invalid_dod_dates_Invalid;
    UNSIGNED1 invalid_age_dates_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Death_Master_Supplemental)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
  END;
EXPORT FromNone(DATASET(Layout_Death_Master_Supplemental) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT30.StrType)le.process_date);
    SELF.source_state_Invalid := Fields.InValid_source_state((SALT30.StrType)le.source_state);
    SELF.certificate_vol_no_Invalid := Fields.InValid_certificate_vol_no((SALT30.StrType)le.certificate_vol_no);
    SELF.certificate_vol_year_Invalid := Fields.InValid_certificate_vol_year((SALT30.StrType)le.certificate_vol_year);
    SELF.publication_Invalid := Fields.InValid_publication((SALT30.StrType)le.publication);
    SELF.decedent_name_Invalid := Fields.InValid_decedent_name((SALT30.StrType)le.decedent_name);
    SELF.decedent_race_Invalid := Fields.InValid_decedent_race((SALT30.StrType)le.decedent_race);
    SELF.decedent_origin_Invalid := Fields.InValid_decedent_origin((SALT30.StrType)le.decedent_origin);
    SELF.decedent_sex_Invalid := Fields.InValid_decedent_sex((SALT30.StrType)le.decedent_sex);
    SELF.decedent_age_Invalid := Fields.InValid_decedent_age((SALT30.StrType)le.decedent_age);
    SELF.education_Invalid := Fields.InValid_education((SALT30.StrType)le.education);
    SELF.occupation_Invalid := Fields.InValid_occupation((SALT30.StrType)le.occupation);
    SELF.where_worked_Invalid := Fields.InValid_where_worked((SALT30.StrType)le.where_worked);
    SELF.cause_Invalid := Fields.InValid_cause((SALT30.StrType)le.cause);
    SELF.ssn_Invalid := Fields.InValid_ssn((SALT30.StrType)le.ssn);
    SELF.dob_Invalid := Fields.InValid_dob((SALT30.StrType)le.dob);
    SELF.dod_Invalid := Fields.InValid_dod((SALT30.StrType)le.dod);
    SELF.birthplace_Invalid := Fields.InValid_birthplace((SALT30.StrType)le.birthplace);
    SELF.marital_status_Invalid := Fields.InValid_marital_status((SALT30.StrType)le.marital_status);
    SELF.father_Invalid := Fields.InValid_father((SALT30.StrType)le.father);
    SELF.mother_Invalid := Fields.InValid_mother((SALT30.StrType)le.mother);
    SELF.filed_date_Invalid := Fields.InValid_filed_date((SALT30.StrType)le.filed_date);
    SELF.year_Invalid := Fields.InValid_year((SALT30.StrType)le.year);
    SELF.county_residence_Invalid := Fields.InValid_county_residence((SALT30.StrType)le.county_residence);
    SELF.county_death_Invalid := Fields.InValid_county_death((SALT30.StrType)le.county_death);
    SELF.address_Invalid := Fields.InValid_address((SALT30.StrType)le.address);
    SELF.autopsy_Invalid := Fields.InValid_autopsy((SALT30.StrType)le.autopsy);
    SELF.autopsy_findings_Invalid := Fields.InValid_autopsy_findings((SALT30.StrType)le.autopsy_findings);
    SELF.primary_cause_of_death_Invalid := Fields.InValid_primary_cause_of_death((SALT30.StrType)le.primary_cause_of_death);
    SELF.underlying_cause_of_death_Invalid := Fields.InValid_underlying_cause_of_death((SALT30.StrType)le.underlying_cause_of_death);
    SELF.med_exam_Invalid := Fields.InValid_med_exam((SALT30.StrType)le.med_exam);
    SELF.est_lic_no_Invalid := Fields.InValid_est_lic_no((SALT30.StrType)le.est_lic_no);
    SELF.disposition_Invalid := Fields.InValid_disposition((SALT30.StrType)le.disposition);
    SELF.disposition_date_Invalid := Fields.InValid_disposition_date((SALT30.StrType)le.disposition_date);
    SELF.work_injury_Invalid := Fields.InValid_work_injury((SALT30.StrType)le.work_injury);
    SELF.injury_date_Invalid := Fields.InValid_injury_date((SALT30.StrType)le.injury_date);
    SELF.injury_type_Invalid := Fields.InValid_injury_type((SALT30.StrType)le.injury_type);
    SELF.injury_location_Invalid := Fields.InValid_injury_location((SALT30.StrType)le.injury_location);
    SELF.surg_performed_Invalid := Fields.InValid_surg_performed((SALT30.StrType)le.surg_performed);
    SELF.surgery_date_Invalid := Fields.InValid_surgery_date((SALT30.StrType)le.surgery_date);
    SELF.hospital_status_Invalid := Fields.InValid_hospital_status((SALT30.StrType)le.hospital_status);
    SELF.pregnancy_Invalid := Fields.InValid_pregnancy((SALT30.StrType)le.pregnancy);
    SELF.facility_death_Invalid := Fields.InValid_facility_death((SALT30.StrType)le.facility_death);
    SELF.embalmer_lic_no_Invalid := Fields.InValid_embalmer_lic_no((SALT30.StrType)le.embalmer_lic_no);
    SELF.death_type_Invalid := Fields.InValid_death_type((SALT30.StrType)le.death_type);
    SELF.time_death_Invalid := Fields.InValid_time_death((SALT30.StrType)le.time_death);
    SELF.birth_cert_Invalid := Fields.InValid_birth_cert((SALT30.StrType)le.birth_cert);
    SELF.certifier_Invalid := Fields.InValid_certifier((SALT30.StrType)le.certifier);
    SELF.cert_number_Invalid := Fields.InValid_cert_number((SALT30.StrType)le.cert_number);
    SELF.birth_vol_year_Invalid := Fields.InValid_birth_vol_year((SALT30.StrType)le.birth_vol_year);
    SELF.local_file_no_Invalid := Fields.InValid_local_file_no((SALT30.StrType)le.local_file_no);
    SELF.vdi_Invalid := Fields.InValid_vdi((SALT30.StrType)le.vdi);
    SELF.cite_id_Invalid := Fields.InValid_cite_id((SALT30.StrType)le.cite_id);
    SELF.file_id_Invalid := Fields.InValid_file_id((SALT30.StrType)le.file_id);
    SELF.date_last_trans_Invalid := Fields.InValid_date_last_trans((SALT30.StrType)le.date_last_trans);
    SELF.amendment_code_Invalid := Fields.InValid_amendment_code((SALT30.StrType)le.amendment_code);
    SELF.amendment_year_Invalid := Fields.InValid_amendment_year((SALT30.StrType)le.amendment_year);
    SELF._on_lexis_Invalid := Fields.InValid__on_lexis((SALT30.StrType)le._on_lexis);
    SELF._fs_profile_Invalid := Fields.InValid__fs_profile((SALT30.StrType)le._fs_profile);
    SELF.us_armed_forces_Invalid := Fields.InValid_us_armed_forces((SALT30.StrType)le.us_armed_forces);
    SELF.place_of_death_Invalid := Fields.InValid_place_of_death((SALT30.StrType)le.place_of_death);
    SELF.state_death_id_Invalid := Fields.InValid_state_death_id((SALT30.StrType)le.state_death_id);
    SELF.state_death_flag_Invalid := Fields.InValid_state_death_flag((SALT30.StrType)le.state_death_flag);
    SELF.title_Invalid := Fields.InValid_title((SALT30.StrType)le.title);
    SELF.fname_Invalid := Fields.InValid_fname((SALT30.StrType)le.fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT30.StrType)le.mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT30.StrType)le.lname);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT30.StrType)le.name_suffix);
    SELF.name_score_Invalid := Fields.InValid_name_score((SALT30.StrType)le.name_score);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT30.StrType)le.prim_range);
    SELF.predir_Invalid := Fields.InValid_predir((SALT30.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT30.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT30.StrType)le.addr_suffix);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT30.StrType)le.postdir);
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT30.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT30.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT30.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT30.StrType)le.v_city_name);
    SELF.state_Invalid := Fields.InValid_state((SALT30.StrType)le.state);
    SELF.zip5_Invalid := Fields.InValid_zip5((SALT30.StrType)le.zip5);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT30.StrType)le.zip4);
    SELF.cart_Invalid := Fields.InValid_cart((SALT30.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := Fields.InValid_cr_sort_sz((SALT30.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := Fields.InValid_lot((SALT30.StrType)le.lot);
    SELF.lot_order_Invalid := Fields.InValid_lot_order((SALT30.StrType)le.lot_order);
    SELF.dpbc_Invalid := Fields.InValid_dpbc((SALT30.StrType)le.dpbc);
    SELF.chk_digit_Invalid := Fields.InValid_chk_digit((SALT30.StrType)le.chk_digit);
    SELF.rec_type_Invalid := Fields.InValid_rec_type((SALT30.StrType)le.rec_type);
    SELF.fips_state_Invalid := Fields.InValid_fips_state((SALT30.StrType)le.fips_state);
    SELF.fips_county_Invalid := Fields.InValid_fips_county((SALT30.StrType)le.fips_county);
    SELF.geo_lat_Invalid := Fields.InValid_geo_lat((SALT30.StrType)le.geo_lat);
    SELF.geo_long_Invalid := Fields.InValid_geo_long((SALT30.StrType)le.geo_long);
    SELF.msa_Invalid := Fields.InValid_msa((SALT30.StrType)le.msa);
    SELF.geo_blk_Invalid := Fields.InValid_geo_blk((SALT30.StrType)le.geo_blk);
    SELF.geo_match_Invalid := Fields.InValid_geo_match((SALT30.StrType)le.geo_match);
    SELF.err_stat_Invalid := Fields.InValid_err_stat((SALT30.StrType)le.err_stat);
    SELF.rawaid_Invalid := Fields.InValid_rawaid((SALT30.StrType)le.rawaid);
    SELF.orig_address1_Invalid := Fields.InValid_orig_address1((SALT30.StrType)le.orig_address1);
    SELF.orig_address2_Invalid := Fields.InValid_orig_address2((SALT30.StrType)le.orig_address2);
    SELF.statefn_Invalid := Fields.InValid_statefn((SALT30.StrType)le.statefn);
    SELF.lf_Invalid := Fields.InValid_lf((SALT30.StrType)le.lf);
    SELF.invalid_dob_dates_Invalid := WHICH(Fields.InValid_dob((SALT30.StrType)le.dob)>0, Fields.InValid_process_date((SALT30.StrType)le.process_date)>0, NOT(le.dob < le.process_date));
    SELF.invalid_dod_dates_Invalid := WHICH(Fields.InValid_dod((SALT30.StrType)le.dod)>0, Fields.InValid_process_date((SALT30.StrType)le.process_date)>0, NOT(le.dod < le.process_date));
    SELF.invalid_age_dates_Invalid := IF( ((SALT30.StrType)le.dod = ''), WHICH(Fields.InValid_dob((SALT30.StrType)le.dob)>0, Fields.InValid_dod((SALT30.StrType)le.dod)>0, NOT(le.dob < le.dod)), 0);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.source_state_Invalid << 2 ) + ( le.certificate_vol_no_Invalid << 4 ) + ( le.certificate_vol_year_Invalid << 6 ) + ( le.publication_Invalid << 8 ) + ( le.decedent_name_Invalid << 9 ) + ( le.decedent_race_Invalid << 11 ) + ( le.decedent_origin_Invalid << 12 ) + ( le.decedent_sex_Invalid << 13 ) + ( le.decedent_age_Invalid << 14 ) + ( le.education_Invalid << 15 ) + ( le.occupation_Invalid << 16 ) + ( le.where_worked_Invalid << 17 ) + ( le.cause_Invalid << 18 ) + ( le.ssn_Invalid << 19 ) + ( le.dob_Invalid << 21 ) + ( le.dod_Invalid << 22 ) + ( le.birthplace_Invalid << 23 ) + ( le.marital_status_Invalid << 24 ) + ( le.father_Invalid << 25 ) + ( le.mother_Invalid << 26 ) + ( le.filed_date_Invalid << 27 ) + ( le.year_Invalid << 28 ) + ( le.county_residence_Invalid << 30 ) + ( le.county_death_Invalid << 31 ) + ( le.address_Invalid << 32 ) + ( le.autopsy_Invalid << 33 ) + ( le.autopsy_findings_Invalid << 34 ) + ( le.primary_cause_of_death_Invalid << 35 ) + ( le.underlying_cause_of_death_Invalid << 37 ) + ( le.med_exam_Invalid << 38 ) + ( le.est_lic_no_Invalid << 39 ) + ( le.disposition_Invalid << 41 ) + ( le.disposition_date_Invalid << 42 ) + ( le.work_injury_Invalid << 43 ) + ( le.injury_date_Invalid << 44 ) + ( le.injury_type_Invalid << 46 ) + ( le.injury_location_Invalid << 47 ) + ( le.surg_performed_Invalid << 48 ) + ( le.surgery_date_Invalid << 49 ) + ( le.hospital_status_Invalid << 50 ) + ( le.pregnancy_Invalid << 51 ) + ( le.facility_death_Invalid << 52 ) + ( le.embalmer_lic_no_Invalid << 53 ) + ( le.death_type_Invalid << 55 ) + ( le.time_death_Invalid << 56 ) + ( le.birth_cert_Invalid << 57 ) + ( le.certifier_Invalid << 58 ) + ( le.cert_number_Invalid << 59 ) + ( le.birth_vol_year_Invalid << 61 );
    SELF.ScrubsBits2 := ( le.local_file_no_Invalid << 0 ) + ( le.vdi_Invalid << 2 ) + ( le.cite_id_Invalid << 3 ) + ( le.file_id_Invalid << 4 ) + ( le.date_last_trans_Invalid << 6 ) + ( le.amendment_code_Invalid << 7 ) + ( le.amendment_year_Invalid << 9 ) + ( le._on_lexis_Invalid << 11 ) + ( le._fs_profile_Invalid << 13 ) + ( le.us_armed_forces_Invalid << 15 ) + ( le.place_of_death_Invalid << 16 ) + ( le.state_death_id_Invalid << 17 ) + ( le.state_death_flag_Invalid << 19 ) + ( le.title_Invalid << 21 ) + ( le.fname_Invalid << 22 ) + ( le.mname_Invalid << 23 ) + ( le.lname_Invalid << 24 ) + ( le.name_suffix_Invalid << 25 ) + ( le.name_score_Invalid << 26 ) + ( le.prim_range_Invalid << 27 ) + ( le.predir_Invalid << 28 ) + ( le.prim_name_Invalid << 30 ) + ( le.addr_suffix_Invalid << 31 ) + ( le.postdir_Invalid << 32 ) + ( le.unit_desig_Invalid << 34 ) + ( le.sec_range_Invalid << 35 ) + ( le.p_city_name_Invalid << 36 ) + ( le.v_city_name_Invalid << 37 ) + ( le.state_Invalid << 38 ) + ( le.zip5_Invalid << 40 ) + ( le.zip4_Invalid << 42 ) + ( le.cart_Invalid << 44 ) + ( le.cr_sort_sz_Invalid << 46 ) + ( le.lot_Invalid << 48 ) + ( le.lot_order_Invalid << 50 ) + ( le.dpbc_Invalid << 52 ) + ( le.chk_digit_Invalid << 54 ) + ( le.rec_type_Invalid << 56 ) + ( le.fips_state_Invalid << 58 ) + ( le.fips_county_Invalid << 60 ) + ( le.geo_lat_Invalid << 62 );
    SELF.ScrubsBits3 := ( le.geo_long_Invalid << 0 ) + ( le.msa_Invalid << 2 ) + ( le.geo_blk_Invalid << 4 ) + ( le.geo_match_Invalid << 6 ) + ( le.err_stat_Invalid << 8 ) + ( le.rawaid_Invalid << 10 ) + ( le.orig_address1_Invalid << 12 ) + ( le.orig_address2_Invalid << 13 ) + ( le.statefn_Invalid << 14 ) + ( le.lf_Invalid << 15 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Death_Master_Supplemental);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.source_state_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.certificate_vol_no_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.certificate_vol_year_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.publication_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.decedent_name_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.decedent_race_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.decedent_origin_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.decedent_sex_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.decedent_age_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.education_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.occupation_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.where_worked_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.cause_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.dod_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.birthplace_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.marital_status_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.father_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.mother_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.filed_date_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.year_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.county_residence_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.county_death_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.address_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.autopsy_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.autopsy_findings_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.primary_cause_of_death_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.underlying_cause_of_death_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.med_exam_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.est_lic_no_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.disposition_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.disposition_date_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.work_injury_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.injury_date_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.injury_type_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.injury_location_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.surg_performed_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.surgery_date_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.hospital_status_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.pregnancy_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.facility_death_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.embalmer_lic_no_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.death_type_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.time_death_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.birth_cert_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.certifier_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.cert_number_Invalid := (le.ScrubsBits1 >> 59) & 3;
    SELF.birth_vol_year_Invalid := (le.ScrubsBits1 >> 61) & 3;
    SELF.local_file_no_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.vdi_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.cite_id_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.file_id_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.date_last_trans_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.amendment_code_Invalid := (le.ScrubsBits2 >> 7) & 3;
    SELF.amendment_year_Invalid := (le.ScrubsBits2 >> 9) & 3;
    SELF._on_lexis_Invalid := (le.ScrubsBits2 >> 11) & 3;
    SELF._fs_profile_Invalid := (le.ScrubsBits2 >> 13) & 3;
    SELF.us_armed_forces_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.place_of_death_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.state_death_id_Invalid := (le.ScrubsBits2 >> 17) & 3;
    SELF.state_death_flag_Invalid := (le.ScrubsBits2 >> 19) & 3;
    SELF.title_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.fname_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.mname_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.lname_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.name_score_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.predir_Invalid := (le.ScrubsBits2 >> 28) & 3;
    SELF.prim_name_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.addr_suffix_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits2 >> 32) & 3;
    SELF.unit_desig_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits2 >> 37) & 1;
    SELF.state_Invalid := (le.ScrubsBits2 >> 38) & 3;
    SELF.zip5_Invalid := (le.ScrubsBits2 >> 40) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits2 >> 42) & 3;
    SELF.cart_Invalid := (le.ScrubsBits2 >> 44) & 3;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits2 >> 46) & 3;
    SELF.lot_Invalid := (le.ScrubsBits2 >> 48) & 3;
    SELF.lot_order_Invalid := (le.ScrubsBits2 >> 50) & 3;
    SELF.dpbc_Invalid := (le.ScrubsBits2 >> 52) & 3;
    SELF.chk_digit_Invalid := (le.ScrubsBits2 >> 54) & 3;
    SELF.rec_type_Invalid := (le.ScrubsBits2 >> 56) & 3;
    SELF.fips_state_Invalid := (le.ScrubsBits2 >> 58) & 3;
    SELF.fips_county_Invalid := (le.ScrubsBits2 >> 60) & 3;
    SELF.geo_lat_Invalid := (le.ScrubsBits2 >> 62) & 3;
    SELF.geo_long_Invalid := (le.ScrubsBits3 >> 0) & 3;
    SELF.msa_Invalid := (le.ScrubsBits3 >> 2) & 3;
    SELF.geo_blk_Invalid := (le.ScrubsBits3 >> 4) & 3;
    SELF.geo_match_Invalid := (le.ScrubsBits3 >> 6) & 3;
    SELF.err_stat_Invalid := (le.ScrubsBits3 >> 8) & 3;
    SELF.rawaid_Invalid := (le.ScrubsBits3 >> 10) & 3;
    SELF.orig_address1_Invalid := (le.ScrubsBits3 >> 12) & 1;
    SELF.orig_address2_Invalid := (le.ScrubsBits3 >> 13) & 1;
    SELF.statefn_Invalid := (le.ScrubsBits3 >> 14) & 1;
    SELF.lf_Invalid := (le.ScrubsBits3 >> 15) & 1;
    SELF.invalid_dob_dates_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.invalid_dod_dates_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.invalid_age_dates_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.source_state;
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_ALLOW_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_LENGTH_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    source_state_ALLOW_ErrorCount := COUNT(GROUP,h.source_state_Invalid=1);
    source_state_LENGTH_ErrorCount := COUNT(GROUP,h.source_state_Invalid=2);
    source_state_Total_ErrorCount := COUNT(GROUP,h.source_state_Invalid>0);
    certificate_vol_no_ALLOW_ErrorCount := COUNT(GROUP,h.certificate_vol_no_Invalid=1);
    certificate_vol_no_LENGTH_ErrorCount := COUNT(GROUP,h.certificate_vol_no_Invalid=2);
    certificate_vol_no_Total_ErrorCount := COUNT(GROUP,h.certificate_vol_no_Invalid>0);
    certificate_vol_year_ALLOW_ErrorCount := COUNT(GROUP,h.certificate_vol_year_Invalid=1);
    certificate_vol_year_LENGTH_ErrorCount := COUNT(GROUP,h.certificate_vol_year_Invalid=2);
    certificate_vol_year_Total_ErrorCount := COUNT(GROUP,h.certificate_vol_year_Invalid>0);
    publication_ALLOW_ErrorCount := COUNT(GROUP,h.publication_Invalid=1);
    decedent_name_ALLOW_ErrorCount := COUNT(GROUP,h.decedent_name_Invalid=1);
    decedent_name_LENGTH_ErrorCount := COUNT(GROUP,h.decedent_name_Invalid=2);
    decedent_name_Total_ErrorCount := COUNT(GROUP,h.decedent_name_Invalid>0);
    decedent_race_ALLOW_ErrorCount := COUNT(GROUP,h.decedent_race_Invalid=1);
    decedent_origin_ALLOW_ErrorCount := COUNT(GROUP,h.decedent_origin_Invalid=1);
    decedent_sex_ENUM_ErrorCount := COUNT(GROUP,h.decedent_sex_Invalid=1);
    decedent_age_ALLOW_ErrorCount := COUNT(GROUP,h.decedent_age_Invalid=1);
    education_ALLOW_ErrorCount := COUNT(GROUP,h.education_Invalid=1);
    occupation_ALLOW_ErrorCount := COUNT(GROUP,h.occupation_Invalid=1);
    where_worked_ALLOW_ErrorCount := COUNT(GROUP,h.where_worked_Invalid=1);
    cause_ALLOW_ErrorCount := COUNT(GROUP,h.cause_Invalid=1);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    ssn_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_Invalid=2);
    ssn_Total_ErrorCount := COUNT(GROUP,h.ssn_Invalid>0);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dod_ALLOW_ErrorCount := COUNT(GROUP,h.dod_Invalid=1);
    birthplace_ALLOW_ErrorCount := COUNT(GROUP,h.birthplace_Invalid=1);
    marital_status_ALLOW_ErrorCount := COUNT(GROUP,h.marital_status_Invalid=1);
    father_ALLOW_ErrorCount := COUNT(GROUP,h.father_Invalid=1);
    mother_ALLOW_ErrorCount := COUNT(GROUP,h.mother_Invalid=1);
    filed_date_ALLOW_ErrorCount := COUNT(GROUP,h.filed_date_Invalid=1);
    year_ALLOW_ErrorCount := COUNT(GROUP,h.year_Invalid=1);
    year_LENGTH_ErrorCount := COUNT(GROUP,h.year_Invalid=2);
    year_Total_ErrorCount := COUNT(GROUP,h.year_Invalid>0);
    county_residence_ALLOW_ErrorCount := COUNT(GROUP,h.county_residence_Invalid=1);
    county_death_ALLOW_ErrorCount := COUNT(GROUP,h.county_death_Invalid=1);
    address_ALLOW_ErrorCount := COUNT(GROUP,h.address_Invalid=1);
    autopsy_ENUM_ErrorCount := COUNT(GROUP,h.autopsy_Invalid=1);
    autopsy_findings_ALLOW_ErrorCount := COUNT(GROUP,h.autopsy_findings_Invalid=1);
    primary_cause_of_death_ALLOW_ErrorCount := COUNT(GROUP,h.primary_cause_of_death_Invalid=1);
    primary_cause_of_death_LENGTH_ErrorCount := COUNT(GROUP,h.primary_cause_of_death_Invalid=2);
    primary_cause_of_death_Total_ErrorCount := COUNT(GROUP,h.primary_cause_of_death_Invalid>0);
    underlying_cause_of_death_ALLOW_ErrorCount := COUNT(GROUP,h.underlying_cause_of_death_Invalid=1);
    med_exam_ENUM_ErrorCount := COUNT(GROUP,h.med_exam_Invalid=1);
    est_lic_no_ALLOW_ErrorCount := COUNT(GROUP,h.est_lic_no_Invalid=1);
    est_lic_no_LENGTH_ErrorCount := COUNT(GROUP,h.est_lic_no_Invalid=2);
    est_lic_no_Total_ErrorCount := COUNT(GROUP,h.est_lic_no_Invalid>0);
    disposition_ALLOW_ErrorCount := COUNT(GROUP,h.disposition_Invalid=1);
    disposition_date_ALLOW_ErrorCount := COUNT(GROUP,h.disposition_date_Invalid=1);
    work_injury_ENUM_ErrorCount := COUNT(GROUP,h.work_injury_Invalid=1);
    injury_date_ALLOW_ErrorCount := COUNT(GROUP,h.injury_date_Invalid=1);
    injury_date_LENGTH_ErrorCount := COUNT(GROUP,h.injury_date_Invalid=2);
    injury_date_Total_ErrorCount := COUNT(GROUP,h.injury_date_Invalid>0);
    injury_type_ALLOW_ErrorCount := COUNT(GROUP,h.injury_type_Invalid=1);
    injury_location_ALLOW_ErrorCount := COUNT(GROUP,h.injury_location_Invalid=1);
    surg_performed_ENUM_ErrorCount := COUNT(GROUP,h.surg_performed_Invalid=1);
    surgery_date_ALLOW_ErrorCount := COUNT(GROUP,h.surgery_date_Invalid=1);
    hospital_status_ALLOW_ErrorCount := COUNT(GROUP,h.hospital_status_Invalid=1);
    pregnancy_ALLOW_ErrorCount := COUNT(GROUP,h.pregnancy_Invalid=1);
    facility_death_ALLOW_ErrorCount := COUNT(GROUP,h.facility_death_Invalid=1);
    embalmer_lic_no_ALLOW_ErrorCount := COUNT(GROUP,h.embalmer_lic_no_Invalid=1);
    embalmer_lic_no_LENGTH_ErrorCount := COUNT(GROUP,h.embalmer_lic_no_Invalid=2);
    embalmer_lic_no_Total_ErrorCount := COUNT(GROUP,h.embalmer_lic_no_Invalid>0);
    death_type_ALLOW_ErrorCount := COUNT(GROUP,h.death_type_Invalid=1);
    time_death_ALLOW_ErrorCount := COUNT(GROUP,h.time_death_Invalid=1);
    birth_cert_ALLOW_ErrorCount := COUNT(GROUP,h.birth_cert_Invalid=1);
    certifier_ALLOW_ErrorCount := COUNT(GROUP,h.certifier_Invalid=1);
    cert_number_ALLOW_ErrorCount := COUNT(GROUP,h.cert_number_Invalid=1);
    cert_number_LENGTH_ErrorCount := COUNT(GROUP,h.cert_number_Invalid=2);
    cert_number_Total_ErrorCount := COUNT(GROUP,h.cert_number_Invalid>0);
    birth_vol_year_ALLOW_ErrorCount := COUNT(GROUP,h.birth_vol_year_Invalid=1);
    birth_vol_year_LENGTH_ErrorCount := COUNT(GROUP,h.birth_vol_year_Invalid=2);
    birth_vol_year_Total_ErrorCount := COUNT(GROUP,h.birth_vol_year_Invalid>0);
    local_file_no_ALLOW_ErrorCount := COUNT(GROUP,h.local_file_no_Invalid=1);
    local_file_no_LENGTH_ErrorCount := COUNT(GROUP,h.local_file_no_Invalid=2);
    local_file_no_Total_ErrorCount := COUNT(GROUP,h.local_file_no_Invalid>0);
    vdi_ALLOW_ErrorCount := COUNT(GROUP,h.vdi_Invalid=1);
    cite_id_ALLOW_ErrorCount := COUNT(GROUP,h.cite_id_Invalid=1);
    file_id_ALLOW_ErrorCount := COUNT(GROUP,h.file_id_Invalid=1);
    file_id_LENGTH_ErrorCount := COUNT(GROUP,h.file_id_Invalid=2);
    file_id_Total_ErrorCount := COUNT(GROUP,h.file_id_Invalid>0);
    date_last_trans_ALLOW_ErrorCount := COUNT(GROUP,h.date_last_trans_Invalid=1);
    amendment_code_ALLOW_ErrorCount := COUNT(GROUP,h.amendment_code_Invalid=1);
    amendment_code_LENGTH_ErrorCount := COUNT(GROUP,h.amendment_code_Invalid=2);
    amendment_code_Total_ErrorCount := COUNT(GROUP,h.amendment_code_Invalid>0);
    amendment_year_ALLOW_ErrorCount := COUNT(GROUP,h.amendment_year_Invalid=1);
    amendment_year_LENGTH_ErrorCount := COUNT(GROUP,h.amendment_year_Invalid=2);
    amendment_year_Total_ErrorCount := COUNT(GROUP,h.amendment_year_Invalid>0);
    _on_lexis_ALLOW_ErrorCount := COUNT(GROUP,h._on_lexis_Invalid=1);
    _on_lexis_LENGTH_ErrorCount := COUNT(GROUP,h._on_lexis_Invalid=2);
    _on_lexis_Total_ErrorCount := COUNT(GROUP,h._on_lexis_Invalid>0);
    _fs_profile_ALLOW_ErrorCount := COUNT(GROUP,h._fs_profile_Invalid=1);
    _fs_profile_LENGTH_ErrorCount := COUNT(GROUP,h._fs_profile_Invalid=2);
    _fs_profile_Total_ErrorCount := COUNT(GROUP,h._fs_profile_Invalid>0);
    us_armed_forces_ENUM_ErrorCount := COUNT(GROUP,h.us_armed_forces_Invalid=1);
    place_of_death_ALLOW_ErrorCount := COUNT(GROUP,h.place_of_death_Invalid=1);
    state_death_id_ALLOW_ErrorCount := COUNT(GROUP,h.state_death_id_Invalid=1);
    state_death_id_LENGTH_ErrorCount := COUNT(GROUP,h.state_death_id_Invalid=2);
    state_death_id_Total_ErrorCount := COUNT(GROUP,h.state_death_id_Invalid>0);
    state_death_flag_ENUM_ErrorCount := COUNT(GROUP,h.state_death_flag_Invalid=1);
    state_death_flag_LENGTH_ErrorCount := COUNT(GROUP,h.state_death_flag_Invalid=2);
    state_death_flag_Total_ErrorCount := COUNT(GROUP,h.state_death_flag_Invalid>0);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_score_ALLOW_ErrorCount := COUNT(GROUP,h.name_score_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    predir_LENGTH_ErrorCount := COUNT(GROUP,h.predir_Invalid=2);
    predir_Total_ErrorCount := COUNT(GROUP,h.predir_Invalid>0);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    postdir_LENGTH_ErrorCount := COUNT(GROUP,h.postdir_Invalid=2);
    postdir_Total_ErrorCount := COUNT(GROUP,h.postdir_Invalid>0);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LENGTH_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zip5_ALLOW_ErrorCount := COUNT(GROUP,h.zip5_Invalid=1);
    zip5_LENGTH_ErrorCount := COUNT(GROUP,h.zip5_Invalid=2);
    zip5_Total_ErrorCount := COUNT(GROUP,h.zip5_Invalid>0);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_LENGTH_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cart_LENGTH_ErrorCount := COUNT(GROUP,h.cart_Invalid=2);
    cart_Total_ErrorCount := COUNT(GROUP,h.cart_Invalid>0);
    cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    cr_sort_sz_LENGTH_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=2);
    cr_sort_sz_Total_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid>0);
    lot_ALLOW_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_LENGTH_ErrorCount := COUNT(GROUP,h.lot_Invalid=2);
    lot_Total_ErrorCount := COUNT(GROUP,h.lot_Invalid>0);
    lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    lot_order_LENGTH_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=2);
    lot_order_Total_ErrorCount := COUNT(GROUP,h.lot_order_Invalid>0);
    dpbc_ALLOW_ErrorCount := COUNT(GROUP,h.dpbc_Invalid=1);
    dpbc_LENGTH_ErrorCount := COUNT(GROUP,h.dpbc_Invalid=2);
    dpbc_Total_ErrorCount := COUNT(GROUP,h.dpbc_Invalid>0);
    chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    chk_digit_LENGTH_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=2);
    chk_digit_Total_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid>0);
    rec_type_ALLOW_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    rec_type_LENGTH_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=2);
    rec_type_Total_ErrorCount := COUNT(GROUP,h.rec_type_Invalid>0);
    fips_state_ALLOW_ErrorCount := COUNT(GROUP,h.fips_state_Invalid=1);
    fips_state_LENGTH_ErrorCount := COUNT(GROUP,h.fips_state_Invalid=2);
    fips_state_Total_ErrorCount := COUNT(GROUP,h.fips_state_Invalid>0);
    fips_county_ALLOW_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=1);
    fips_county_LENGTH_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=2);
    fips_county_Total_ErrorCount := COUNT(GROUP,h.fips_county_Invalid>0);
    geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_lat_LENGTH_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=2);
    geo_lat_Total_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid>0);
    geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    geo_long_LENGTH_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=2);
    geo_long_Total_ErrorCount := COUNT(GROUP,h.geo_long_Invalid>0);
    msa_ALLOW_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    msa_LENGTH_ErrorCount := COUNT(GROUP,h.msa_Invalid=2);
    msa_Total_ErrorCount := COUNT(GROUP,h.msa_Invalid>0);
    geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_blk_LENGTH_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=2);
    geo_blk_Total_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid>0);
    geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    geo_match_LENGTH_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=2);
    geo_match_Total_ErrorCount := COUNT(GROUP,h.geo_match_Invalid>0);
    err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    err_stat_LENGTH_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=2);
    err_stat_Total_ErrorCount := COUNT(GROUP,h.err_stat_Invalid>0);
    rawaid_ALLOW_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=1);
    rawaid_LENGTH_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=2);
    rawaid_Total_ErrorCount := COUNT(GROUP,h.rawaid_Invalid>0);
    orig_address1_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address1_Invalid=1);
    orig_address2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address2_Invalid=1);
    statefn_ALLOW_ErrorCount := COUNT(GROUP,h.statefn_Invalid=1);
    lf_LENGTH_ErrorCount := COUNT(GROUP,h.lf_Invalid=1);
    invalid_dob_dates_dob_Invalid_ErrorCount := COUNT(GROUP,h.invalid_dob_dates_Invalid=1);
    invalid_dob_dates_process_date_Invalid_ErrorCount := COUNT(GROUP,h.invalid_dob_dates_Invalid=2);
    invalid_dob_dates_dob_process_date_Condition_Invalid_ErrorCount := COUNT(GROUP,h.invalid_dob_dates_Invalid=3);
    invalid_dob_dates_Total_ErrorCount := COUNT(GROUP,h.invalid_dob_dates_Invalid>0);
    invalid_dod_dates_dod_Invalid_ErrorCount := COUNT(GROUP,h.invalid_dod_dates_Invalid=1);
    invalid_dod_dates_process_date_Invalid_ErrorCount := COUNT(GROUP,h.invalid_dod_dates_Invalid=2);
    invalid_dod_dates_dod_process_date_Condition_Invalid_ErrorCount := COUNT(GROUP,h.invalid_dod_dates_Invalid=3);
    invalid_dod_dates_Total_ErrorCount := COUNT(GROUP,h.invalid_dod_dates_Invalid>0);
    invalid_age_dates_dob_Invalid_ErrorCount := COUNT(GROUP,h.invalid_age_dates_Invalid=1);
    invalid_age_dates_dod_Invalid_ErrorCount := COUNT(GROUP,h.invalid_age_dates_Invalid=2);
    invalid_age_dates_dob_dod_Condition_Invalid_ErrorCount := COUNT(GROUP,h.invalid_age_dates_Invalid=3);
    invalid_age_dates_Total_ErrorCount := COUNT(GROUP,h.invalid_age_dates_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r,source_state,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.source_state;
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.source_state_Invalid,le.certificate_vol_no_Invalid,le.certificate_vol_year_Invalid,le.publication_Invalid,le.decedent_name_Invalid,le.decedent_race_Invalid,le.decedent_origin_Invalid,le.decedent_sex_Invalid,le.decedent_age_Invalid,le.education_Invalid,le.occupation_Invalid,le.where_worked_Invalid,le.cause_Invalid,le.ssn_Invalid,le.dob_Invalid,le.dod_Invalid,le.birthplace_Invalid,le.marital_status_Invalid,le.father_Invalid,le.mother_Invalid,le.filed_date_Invalid,le.year_Invalid,le.county_residence_Invalid,le.county_death_Invalid,le.address_Invalid,le.autopsy_Invalid,le.autopsy_findings_Invalid,le.primary_cause_of_death_Invalid,le.underlying_cause_of_death_Invalid,le.med_exam_Invalid,le.est_lic_no_Invalid,le.disposition_Invalid,le.disposition_date_Invalid,le.work_injury_Invalid,le.injury_date_Invalid,le.injury_type_Invalid,le.injury_location_Invalid,le.surg_performed_Invalid,le.surgery_date_Invalid,le.hospital_status_Invalid,le.pregnancy_Invalid,le.facility_death_Invalid,le.embalmer_lic_no_Invalid,le.death_type_Invalid,le.time_death_Invalid,le.birth_cert_Invalid,le.certifier_Invalid,le.cert_number_Invalid,le.birth_vol_year_Invalid,le.local_file_no_Invalid,le.vdi_Invalid,le.cite_id_Invalid,le.file_id_Invalid,le.date_last_trans_Invalid,le.amendment_code_Invalid,le.amendment_year_Invalid,le._on_lexis_Invalid,le._fs_profile_Invalid,le.us_armed_forces_Invalid,le.place_of_death_Invalid,le.state_death_id_Invalid,le.state_death_flag_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.name_score_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.state_Invalid,le.zip5_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dpbc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.fips_state_Invalid,le.fips_county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.rawaid_Invalid,le.orig_address1_Invalid,le.orig_address2_Invalid,le.statefn_Invalid,le.lf_Invalid,le.invalid_dob_dates_Invalid,le.invalid_dod_dates_Invalid,le.invalid_age_dates_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_source_state(le.source_state_Invalid),Fields.InvalidMessage_certificate_vol_no(le.certificate_vol_no_Invalid),Fields.InvalidMessage_certificate_vol_year(le.certificate_vol_year_Invalid),Fields.InvalidMessage_publication(le.publication_Invalid),Fields.InvalidMessage_decedent_name(le.decedent_name_Invalid),Fields.InvalidMessage_decedent_race(le.decedent_race_Invalid),Fields.InvalidMessage_decedent_origin(le.decedent_origin_Invalid),Fields.InvalidMessage_decedent_sex(le.decedent_sex_Invalid),Fields.InvalidMessage_decedent_age(le.decedent_age_Invalid),Fields.InvalidMessage_education(le.education_Invalid),Fields.InvalidMessage_occupation(le.occupation_Invalid),Fields.InvalidMessage_where_worked(le.where_worked_Invalid),Fields.InvalidMessage_cause(le.cause_Invalid),Fields.InvalidMessage_ssn(le.ssn_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_dod(le.dod_Invalid),Fields.InvalidMessage_birthplace(le.birthplace_Invalid),Fields.InvalidMessage_marital_status(le.marital_status_Invalid),Fields.InvalidMessage_father(le.father_Invalid),Fields.InvalidMessage_mother(le.mother_Invalid),Fields.InvalidMessage_filed_date(le.filed_date_Invalid),Fields.InvalidMessage_year(le.year_Invalid),Fields.InvalidMessage_county_residence(le.county_residence_Invalid),Fields.InvalidMessage_county_death(le.county_death_Invalid),Fields.InvalidMessage_address(le.address_Invalid),Fields.InvalidMessage_autopsy(le.autopsy_Invalid),Fields.InvalidMessage_autopsy_findings(le.autopsy_findings_Invalid),Fields.InvalidMessage_primary_cause_of_death(le.primary_cause_of_death_Invalid),Fields.InvalidMessage_underlying_cause_of_death(le.underlying_cause_of_death_Invalid),Fields.InvalidMessage_med_exam(le.med_exam_Invalid),Fields.InvalidMessage_est_lic_no(le.est_lic_no_Invalid),Fields.InvalidMessage_disposition(le.disposition_Invalid),Fields.InvalidMessage_disposition_date(le.disposition_date_Invalid),Fields.InvalidMessage_work_injury(le.work_injury_Invalid),Fields.InvalidMessage_injury_date(le.injury_date_Invalid),Fields.InvalidMessage_injury_type(le.injury_type_Invalid),Fields.InvalidMessage_injury_location(le.injury_location_Invalid),Fields.InvalidMessage_surg_performed(le.surg_performed_Invalid),Fields.InvalidMessage_surgery_date(le.surgery_date_Invalid),Fields.InvalidMessage_hospital_status(le.hospital_status_Invalid),Fields.InvalidMessage_pregnancy(le.pregnancy_Invalid),Fields.InvalidMessage_facility_death(le.facility_death_Invalid),Fields.InvalidMessage_embalmer_lic_no(le.embalmer_lic_no_Invalid),Fields.InvalidMessage_death_type(le.death_type_Invalid),Fields.InvalidMessage_time_death(le.time_death_Invalid),Fields.InvalidMessage_birth_cert(le.birth_cert_Invalid),Fields.InvalidMessage_certifier(le.certifier_Invalid),Fields.InvalidMessage_cert_number(le.cert_number_Invalid),Fields.InvalidMessage_birth_vol_year(le.birth_vol_year_Invalid),Fields.InvalidMessage_local_file_no(le.local_file_no_Invalid),Fields.InvalidMessage_vdi(le.vdi_Invalid),Fields.InvalidMessage_cite_id(le.cite_id_Invalid),Fields.InvalidMessage_file_id(le.file_id_Invalid),Fields.InvalidMessage_date_last_trans(le.date_last_trans_Invalid),Fields.InvalidMessage_amendment_code(le.amendment_code_Invalid),Fields.InvalidMessage_amendment_year(le.amendment_year_Invalid),Fields.InvalidMessage__on_lexis(le._on_lexis_Invalid),Fields.InvalidMessage__fs_profile(le._fs_profile_Invalid),Fields.InvalidMessage_us_armed_forces(le.us_armed_forces_Invalid),Fields.InvalidMessage_place_of_death(le.place_of_death_Invalid),Fields.InvalidMessage_state_death_id(le.state_death_id_Invalid),Fields.InvalidMessage_state_death_flag(le.state_death_flag_Invalid),Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_name_score(le.name_score_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zip5(le.zip5_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_cart(le.cart_Invalid),Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Fields.InvalidMessage_lot(le.lot_Invalid),Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Fields.InvalidMessage_dpbc(le.dpbc_Invalid),Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_fips_state(le.fips_state_Invalid),Fields.InvalidMessage_fips_county(le.fips_county_Invalid),Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Fields.InvalidMessage_msa(le.msa_Invalid),Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Fields.InvalidMessage_rawaid(le.rawaid_Invalid),Fields.InvalidMessage_orig_address1(le.orig_address1_Invalid),Fields.InvalidMessage_orig_address2(le.orig_address2_Invalid),Fields.InvalidMessage_statefn(le.statefn_Invalid),Fields.InvalidMessage_lf(le.lf_Invalid),InvalidMessage_invalid_dob_dates(le.invalid_dob_dates_Invalid),InvalidMessage_invalid_dod_dates(le.invalid_dod_dates_Invalid),InvalidMessage_invalid_age_dates(le.invalid_age_dates_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.source_state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.certificate_vol_no_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.certificate_vol_year_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.publication_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.decedent_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.decedent_race_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.decedent_origin_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.decedent_sex_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.decedent_age_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.education_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.occupation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.where_worked_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cause_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dod_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.birthplace_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.marital_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.father_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mother_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.filed_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.year_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.county_residence_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.county_death_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.autopsy_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.autopsy_findings_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.primary_cause_of_death_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.underlying_cause_of_death_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.med_exam_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.est_lic_no_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.disposition_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.disposition_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.work_injury_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.injury_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.injury_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.injury_location_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.surg_performed_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.surgery_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.hospital_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pregnancy_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.facility_death_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.embalmer_lic_no_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.death_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.time_death_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.birth_cert_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certifier_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cert_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.birth_vol_year_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.local_file_no_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.vdi_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cite_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.file_id_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_last_trans_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.amendment_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.amendment_year_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le._on_lexis_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le._fs_profile_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.us_armed_forces_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.place_of_death_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_death_id_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.state_death_flag_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip5_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dpbc_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fips_state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fips_county_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.rawaid_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_address1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_address2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statefn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lf_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.invalid_dob_dates_Invalid,'dob_Invalid','process_date_Invalid','dob_process_date_Condition_Invalid','UNKNOWN')
          ,CHOOSE(le.invalid_dod_dates_Invalid,'dod_Invalid','process_date_Invalid','dod_process_date_Condition_Invalid','UNKNOWN')
          ,CHOOSE(le.invalid_age_dates_Invalid,'dob_Invalid','dod_Invalid','dob_dod_Condition_Invalid','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','source_state','certificate_vol_no','certificate_vol_year','publication','decedent_name','decedent_race','decedent_origin','decedent_sex','decedent_age','education','occupation','where_worked','cause','ssn','dob','dod','birthplace','marital_status','father','mother','filed_date','year','county_residence','county_death','address','autopsy','autopsy_findings','primary_cause_of_death','underlying_cause_of_death','med_exam','est_lic_no','disposition','disposition_date','work_injury','injury_date','injury_type','injury_location','surg_performed','surgery_date','hospital_status','pregnancy','facility_death','embalmer_lic_no','death_type','time_death','birth_cert','certifier','cert_number','birth_vol_year','local_file_no','vdi','cite_id','file_id','date_last_trans','amendment_code','amendment_year','_on_lexis','_fs_profile','us_armed_forces','place_of_death','state_death_id','state_death_flag','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','state','zip5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','orig_address1','orig_address2','statefn','lf','invalid_dob_dates','invalid_dod_dates','invalid_age_dates','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_process_date','invalid_source_state','invalid_certificate_vol_no','invalid_certificate_vol_year','invalid_publication','invalid_decedent_name','invalid_decedent_race','invalid_decedent_origin','invalid_decedent_sex','invalid_decedent_age','invalid_education','invalid_occupation','invalid_where_worked','invalid_cause','invalid_ssn','invalid_date','invalid_date','invalid_birthplace','invalid_marital_status','invalid_parent_name','invalid_parent_name','invalid_date','invalid_year','invalid_county_residence','invalid_county_death','invalid_address','invalid_autopsy','invalid_autopsy_findings','invalid_primary_cause_of_death','invalid_underlying_cause_of_death','invalid_med_exam','invalid_est_lic_no','invalid_disposition','invalid_date','invalid_work_injury','invalid_injury_date','invalid_injury_type','invalid_injury_location','invalid_surg_performed','invalid_date','invalid_hospital_status','invalid_pregnancy','invalid_facility_death','invalid_embalmer_lic_no','invalid_death_type','invalid_time_death','invalid_birth_cert','invalid_certifier','invalid_cert_number','invalid_year','invalid_local_file_no','invalid_vdi','invalid_cite_id','invalid_file_id','invalid_date','invalid_amendment_code','invalid_amendment_year','invalid__on_lexis','invalid__fs_profile','invalid_us_armed_forces','invalid_place_of_death','invalid_state_death_id','invalid_state_death_flag','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name_score','invalid_prim_range','invalid_predir','invalid_prim_name','invalid_addr_suffix','invalid_postdir','invalid_unit_desig','invalid_sec_range','invalid_p_city_name','invalid_v_city_name','invalid_state','invalid_zip','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_rec_type','invalid_fipsstate','invalid_fipscounty','invalid_geo_lat','invalid_geo_long','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','invalid_rawaid','invalid_address','invalid_address','invalid_statefn','invalid_lf','RECORDTYPE','RECORDTYPE','RECORDTYPE','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.process_date,(SALT30.StrType)le.source_state,(SALT30.StrType)le.certificate_vol_no,(SALT30.StrType)le.certificate_vol_year,(SALT30.StrType)le.publication,(SALT30.StrType)le.decedent_name,(SALT30.StrType)le.decedent_race,(SALT30.StrType)le.decedent_origin,(SALT30.StrType)le.decedent_sex,(SALT30.StrType)le.decedent_age,(SALT30.StrType)le.education,(SALT30.StrType)le.occupation,(SALT30.StrType)le.where_worked,(SALT30.StrType)le.cause,(SALT30.StrType)le.ssn,(SALT30.StrType)le.dob,(SALT30.StrType)le.dod,(SALT30.StrType)le.birthplace,(SALT30.StrType)le.marital_status,(SALT30.StrType)le.father,(SALT30.StrType)le.mother,(SALT30.StrType)le.filed_date,(SALT30.StrType)le.year,(SALT30.StrType)le.county_residence,(SALT30.StrType)le.county_death,(SALT30.StrType)le.address,(SALT30.StrType)le.autopsy,(SALT30.StrType)le.autopsy_findings,(SALT30.StrType)le.primary_cause_of_death,(SALT30.StrType)le.underlying_cause_of_death,(SALT30.StrType)le.med_exam,(SALT30.StrType)le.est_lic_no,(SALT30.StrType)le.disposition,(SALT30.StrType)le.disposition_date,(SALT30.StrType)le.work_injury,(SALT30.StrType)le.injury_date,(SALT30.StrType)le.injury_type,(SALT30.StrType)le.injury_location,(SALT30.StrType)le.surg_performed,(SALT30.StrType)le.surgery_date,(SALT30.StrType)le.hospital_status,(SALT30.StrType)le.pregnancy,(SALT30.StrType)le.facility_death,(SALT30.StrType)le.embalmer_lic_no,(SALT30.StrType)le.death_type,(SALT30.StrType)le.time_death,(SALT30.StrType)le.birth_cert,(SALT30.StrType)le.certifier,(SALT30.StrType)le.cert_number,(SALT30.StrType)le.birth_vol_year,(SALT30.StrType)le.local_file_no,(SALT30.StrType)le.vdi,(SALT30.StrType)le.cite_id,(SALT30.StrType)le.file_id,(SALT30.StrType)le.date_last_trans,(SALT30.StrType)le.amendment_code,(SALT30.StrType)le.amendment_year,(SALT30.StrType)le._on_lexis,(SALT30.StrType)le._fs_profile,(SALT30.StrType)le.us_armed_forces,(SALT30.StrType)le.place_of_death,(SALT30.StrType)le.state_death_id,(SALT30.StrType)le.state_death_flag,(SALT30.StrType)le.title,(SALT30.StrType)le.fname,(SALT30.StrType)le.mname,(SALT30.StrType)le.lname,(SALT30.StrType)le.name_suffix,(SALT30.StrType)le.name_score,(SALT30.StrType)le.prim_range,(SALT30.StrType)le.predir,(SALT30.StrType)le.prim_name,(SALT30.StrType)le.addr_suffix,(SALT30.StrType)le.postdir,(SALT30.StrType)le.unit_desig,(SALT30.StrType)le.sec_range,(SALT30.StrType)le.p_city_name,(SALT30.StrType)le.v_city_name,(SALT30.StrType)le.state,(SALT30.StrType)le.zip5,(SALT30.StrType)le.zip4,(SALT30.StrType)le.cart,(SALT30.StrType)le.cr_sort_sz,(SALT30.StrType)le.lot,(SALT30.StrType)le.lot_order,(SALT30.StrType)le.dpbc,(SALT30.StrType)le.chk_digit,(SALT30.StrType)le.rec_type,(SALT30.StrType)le.fips_state,(SALT30.StrType)le.fips_county,(SALT30.StrType)le.geo_lat,(SALT30.StrType)le.geo_long,(SALT30.StrType)le.msa,(SALT30.StrType)le.geo_blk,(SALT30.StrType)le.geo_match,(SALT30.StrType)le.err_stat,(SALT30.StrType)le.rawaid,(SALT30.StrType)le.orig_address1,(SALT30.StrType)le.orig_address2,(SALT30.StrType)le.statefn,(SALT30.StrType)le.lf,(SALT30.StrType)le.dob+':'+(SALT30.StrType)le.process_date+':'+(SALT30.StrType)le.dob+'<'+(SALT30.StrType)le.process_date,(SALT30.StrType)le.dod+':'+(SALT30.StrType)le.process_date+':'+(SALT30.StrType)le.dod+'<'+(SALT30.StrType)le.process_date,(SALT30.StrType)le.dob+':'+(SALT30.StrType)le.dod+':'+(SALT30.StrType)le.dob+'<'+(SALT30.StrType)le.dod,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,104,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source_state;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:invalid_process_date:ALLOW','process_date:invalid_process_date:LENGTH'
          ,'source_state:invalid_source_state:ALLOW','source_state:invalid_source_state:LENGTH'
          ,'certificate_vol_no:invalid_certificate_vol_no:ALLOW','certificate_vol_no:invalid_certificate_vol_no:LENGTH'
          ,'certificate_vol_year:invalid_certificate_vol_year:ALLOW','certificate_vol_year:invalid_certificate_vol_year:LENGTH'
          ,'publication:invalid_publication:ALLOW'
          ,'decedent_name:invalid_decedent_name:ALLOW','decedent_name:invalid_decedent_name:LENGTH'
          ,'decedent_race:invalid_decedent_race:ALLOW'
          ,'decedent_origin:invalid_decedent_origin:ALLOW'
          ,'decedent_sex:invalid_decedent_sex:ENUM'
          ,'decedent_age:invalid_decedent_age:ALLOW'
          ,'education:invalid_education:ALLOW'
          ,'occupation:invalid_occupation:ALLOW'
          ,'where_worked:invalid_where_worked:ALLOW'
          ,'cause:invalid_cause:ALLOW'
          ,'ssn:invalid_ssn:ALLOW','ssn:invalid_ssn:LENGTH'
          ,'dob:invalid_date:ALLOW'
          ,'dod:invalid_date:ALLOW'
          ,'birthplace:invalid_birthplace:ALLOW'
          ,'marital_status:invalid_marital_status:ALLOW'
          ,'father:invalid_parent_name:ALLOW'
          ,'mother:invalid_parent_name:ALLOW'
          ,'filed_date:invalid_date:ALLOW'
          ,'year:invalid_year:ALLOW','year:invalid_year:LENGTH'
          ,'county_residence:invalid_county_residence:ALLOW'
          ,'county_death:invalid_county_death:ALLOW'
          ,'address:invalid_address:ALLOW'
          ,'autopsy:invalid_autopsy:ENUM'
          ,'autopsy_findings:invalid_autopsy_findings:ALLOW'
          ,'primary_cause_of_death:invalid_primary_cause_of_death:ALLOW','primary_cause_of_death:invalid_primary_cause_of_death:LENGTH'
          ,'underlying_cause_of_death:invalid_underlying_cause_of_death:ALLOW'
          ,'med_exam:invalid_med_exam:ENUM'
          ,'est_lic_no:invalid_est_lic_no:ALLOW','est_lic_no:invalid_est_lic_no:LENGTH'
          ,'disposition:invalid_disposition:ALLOW'
          ,'disposition_date:invalid_date:ALLOW'
          ,'work_injury:invalid_work_injury:ENUM'
          ,'injury_date:invalid_injury_date:ALLOW','injury_date:invalid_injury_date:LENGTH'
          ,'injury_type:invalid_injury_type:ALLOW'
          ,'injury_location:invalid_injury_location:ALLOW'
          ,'surg_performed:invalid_surg_performed:ENUM'
          ,'surgery_date:invalid_date:ALLOW'
          ,'hospital_status:invalid_hospital_status:ALLOW'
          ,'pregnancy:invalid_pregnancy:ALLOW'
          ,'facility_death:invalid_facility_death:ALLOW'
          ,'embalmer_lic_no:invalid_embalmer_lic_no:ALLOW','embalmer_lic_no:invalid_embalmer_lic_no:LENGTH'
          ,'death_type:invalid_death_type:ALLOW'
          ,'time_death:invalid_time_death:ALLOW'
          ,'birth_cert:invalid_birth_cert:ALLOW'
          ,'certifier:invalid_certifier:ALLOW'
          ,'cert_number:invalid_cert_number:ALLOW','cert_number:invalid_cert_number:LENGTH'
          ,'birth_vol_year:invalid_year:ALLOW','birth_vol_year:invalid_year:LENGTH'
          ,'local_file_no:invalid_local_file_no:ALLOW','local_file_no:invalid_local_file_no:LENGTH'
          ,'vdi:invalid_vdi:ALLOW'
          ,'cite_id:invalid_cite_id:ALLOW'
          ,'file_id:invalid_file_id:ALLOW','file_id:invalid_file_id:LENGTH'
          ,'date_last_trans:invalid_date:ALLOW'
          ,'amendment_code:invalid_amendment_code:ALLOW','amendment_code:invalid_amendment_code:LENGTH'
          ,'amendment_year:invalid_amendment_year:ALLOW','amendment_year:invalid_amendment_year:LENGTH'
          ,'_on_lexis:invalid__on_lexis:ALLOW','_on_lexis:invalid__on_lexis:LENGTH'
          ,'_fs_profile:invalid__fs_profile:ALLOW','_fs_profile:invalid__fs_profile:LENGTH'
          ,'us_armed_forces:invalid_us_armed_forces:ENUM'
          ,'place_of_death:invalid_place_of_death:ALLOW'
          ,'state_death_id:invalid_state_death_id:ALLOW','state_death_id:invalid_state_death_id:LENGTH'
          ,'state_death_flag:invalid_state_death_flag:ENUM','state_death_flag:invalid_state_death_flag:LENGTH'
          ,'title:invalid_name:ALLOW'
          ,'fname:invalid_name:ALLOW'
          ,'mname:invalid_name:ALLOW'
          ,'lname:invalid_name:ALLOW'
          ,'name_suffix:invalid_name:ALLOW'
          ,'name_score:invalid_name_score:ALLOW'
          ,'prim_range:invalid_prim_range:ALLOW'
          ,'predir:invalid_predir:ALLOW','predir:invalid_predir:LENGTH'
          ,'prim_name:invalid_prim_name:ALLOW'
          ,'addr_suffix:invalid_addr_suffix:ALLOW'
          ,'postdir:invalid_postdir:ALLOW','postdir:invalid_postdir:LENGTH'
          ,'unit_desig:invalid_unit_desig:ALLOW'
          ,'sec_range:invalid_sec_range:ALLOW'
          ,'p_city_name:invalid_p_city_name:ALLOW'
          ,'v_city_name:invalid_v_city_name:ALLOW'
          ,'state:invalid_state:ALLOW','state:invalid_state:LENGTH'
          ,'zip5:invalid_zip:ALLOW','zip5:invalid_zip:LENGTH'
          ,'zip4:invalid_zip4:ALLOW','zip4:invalid_zip4:LENGTH'
          ,'cart:invalid_cart:ALLOW','cart:invalid_cart:LENGTH'
          ,'cr_sort_sz:invalid_cr_sort_sz:ALLOW','cr_sort_sz:invalid_cr_sort_sz:LENGTH'
          ,'lot:invalid_lot:ALLOW','lot:invalid_lot:LENGTH'
          ,'lot_order:invalid_lot_order:ALLOW','lot_order:invalid_lot_order:LENGTH'
          ,'dpbc:invalid_dpbc:ALLOW','dpbc:invalid_dpbc:LENGTH'
          ,'chk_digit:invalid_chk_digit:ALLOW','chk_digit:invalid_chk_digit:LENGTH'
          ,'rec_type:invalid_rec_type:ALLOW','rec_type:invalid_rec_type:LENGTH'
          ,'fips_state:invalid_fipsstate:ALLOW','fips_state:invalid_fipsstate:LENGTH'
          ,'fips_county:invalid_fipscounty:ALLOW','fips_county:invalid_fipscounty:LENGTH'
          ,'geo_lat:invalid_geo_lat:ALLOW','geo_lat:invalid_geo_lat:LENGTH'
          ,'geo_long:invalid_geo_long:ALLOW','geo_long:invalid_geo_long:LENGTH'
          ,'msa:invalid_msa:ALLOW','msa:invalid_msa:LENGTH'
          ,'geo_blk:invalid_geo_blk:ALLOW','geo_blk:invalid_geo_blk:LENGTH'
          ,'geo_match:invalid_geo_match:ALLOW','geo_match:invalid_geo_match:LENGTH'
          ,'err_stat:invalid_err_stat:ALLOW','err_stat:invalid_err_stat:LENGTH'
          ,'rawaid:invalid_rawaid:ALLOW','rawaid:invalid_rawaid:LENGTH'
          ,'orig_address1:invalid_address:ALLOW'
          ,'orig_address2:invalid_address:ALLOW'
          ,'statefn:invalid_statefn:ALLOW'
          ,'lf:invalid_lf:LENGTH'
          ,'invalid_dob_dates:RECORDTYPE:dob_Invalid','invalid_dob_dates:RECORDTYPE:process_date_Invalid','invalid_dob_dates:RECORDTYPE:dob_process_date_Condition_Invalid'
          ,'invalid_dod_dates:RECORDTYPE:dod_Invalid','invalid_dod_dates:RECORDTYPE:process_date_Invalid','invalid_dod_dates:RECORDTYPE:dod_process_date_Condition_Invalid'
          ,'invalid_age_dates:RECORDTYPE:dob_Invalid','invalid_age_dates:RECORDTYPE:dod_Invalid','invalid_age_dates:RECORDTYPE:dob_dod_Condition_Invalid','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.source_state_ALLOW_ErrorCount,le.source_state_LENGTH_ErrorCount
          ,le.certificate_vol_no_ALLOW_ErrorCount,le.certificate_vol_no_LENGTH_ErrorCount
          ,le.certificate_vol_year_ALLOW_ErrorCount,le.certificate_vol_year_LENGTH_ErrorCount
          ,le.publication_ALLOW_ErrorCount
          ,le.decedent_name_ALLOW_ErrorCount,le.decedent_name_LENGTH_ErrorCount
          ,le.decedent_race_ALLOW_ErrorCount
          ,le.decedent_origin_ALLOW_ErrorCount
          ,le.decedent_sex_ENUM_ErrorCount
          ,le.decedent_age_ALLOW_ErrorCount
          ,le.education_ALLOW_ErrorCount
          ,le.occupation_ALLOW_ErrorCount
          ,le.where_worked_ALLOW_ErrorCount
          ,le.cause_ALLOW_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTH_ErrorCount
          ,le.dob_ALLOW_ErrorCount
          ,le.dod_ALLOW_ErrorCount
          ,le.birthplace_ALLOW_ErrorCount
          ,le.marital_status_ALLOW_ErrorCount
          ,le.father_ALLOW_ErrorCount
          ,le.mother_ALLOW_ErrorCount
          ,le.filed_date_ALLOW_ErrorCount
          ,le.year_ALLOW_ErrorCount,le.year_LENGTH_ErrorCount
          ,le.county_residence_ALLOW_ErrorCount
          ,le.county_death_ALLOW_ErrorCount
          ,le.address_ALLOW_ErrorCount
          ,le.autopsy_ENUM_ErrorCount
          ,le.autopsy_findings_ALLOW_ErrorCount
          ,le.primary_cause_of_death_ALLOW_ErrorCount,le.primary_cause_of_death_LENGTH_ErrorCount
          ,le.underlying_cause_of_death_ALLOW_ErrorCount
          ,le.med_exam_ENUM_ErrorCount
          ,le.est_lic_no_ALLOW_ErrorCount,le.est_lic_no_LENGTH_ErrorCount
          ,le.disposition_ALLOW_ErrorCount
          ,le.disposition_date_ALLOW_ErrorCount
          ,le.work_injury_ENUM_ErrorCount
          ,le.injury_date_ALLOW_ErrorCount,le.injury_date_LENGTH_ErrorCount
          ,le.injury_type_ALLOW_ErrorCount
          ,le.injury_location_ALLOW_ErrorCount
          ,le.surg_performed_ENUM_ErrorCount
          ,le.surgery_date_ALLOW_ErrorCount
          ,le.hospital_status_ALLOW_ErrorCount
          ,le.pregnancy_ALLOW_ErrorCount
          ,le.facility_death_ALLOW_ErrorCount
          ,le.embalmer_lic_no_ALLOW_ErrorCount,le.embalmer_lic_no_LENGTH_ErrorCount
          ,le.death_type_ALLOW_ErrorCount
          ,le.time_death_ALLOW_ErrorCount
          ,le.birth_cert_ALLOW_ErrorCount
          ,le.certifier_ALLOW_ErrorCount
          ,le.cert_number_ALLOW_ErrorCount,le.cert_number_LENGTH_ErrorCount
          ,le.birth_vol_year_ALLOW_ErrorCount,le.birth_vol_year_LENGTH_ErrorCount
          ,le.local_file_no_ALLOW_ErrorCount,le.local_file_no_LENGTH_ErrorCount
          ,le.vdi_ALLOW_ErrorCount
          ,le.cite_id_ALLOW_ErrorCount
          ,le.file_id_ALLOW_ErrorCount,le.file_id_LENGTH_ErrorCount
          ,le.date_last_trans_ALLOW_ErrorCount
          ,le.amendment_code_ALLOW_ErrorCount,le.amendment_code_LENGTH_ErrorCount
          ,le.amendment_year_ALLOW_ErrorCount,le.amendment_year_LENGTH_ErrorCount
          ,le._on_lexis_ALLOW_ErrorCount,le._on_lexis_LENGTH_ErrorCount
          ,le._fs_profile_ALLOW_ErrorCount,le._fs_profile_LENGTH_ErrorCount
          ,le.us_armed_forces_ENUM_ErrorCount
          ,le.place_of_death_ALLOW_ErrorCount
          ,le.state_death_id_ALLOW_ErrorCount,le.state_death_id_LENGTH_ErrorCount
          ,le.state_death_flag_ENUM_ErrorCount,le.state_death_flag_LENGTH_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.name_score_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount,le.predir_LENGTH_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTH_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.cart_ALLOW_ErrorCount,le.cart_LENGTH_ErrorCount
          ,le.cr_sort_sz_ALLOW_ErrorCount,le.cr_sort_sz_LENGTH_ErrorCount
          ,le.lot_ALLOW_ErrorCount,le.lot_LENGTH_ErrorCount
          ,le.lot_order_ALLOW_ErrorCount,le.lot_order_LENGTH_ErrorCount
          ,le.dpbc_ALLOW_ErrorCount,le.dpbc_LENGTH_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount,le.chk_digit_LENGTH_ErrorCount
          ,le.rec_type_ALLOW_ErrorCount,le.rec_type_LENGTH_ErrorCount
          ,le.fips_state_ALLOW_ErrorCount,le.fips_state_LENGTH_ErrorCount
          ,le.fips_county_ALLOW_ErrorCount,le.fips_county_LENGTH_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount,le.geo_lat_LENGTH_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount,le.geo_long_LENGTH_ErrorCount
          ,le.msa_ALLOW_ErrorCount,le.msa_LENGTH_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTH_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount,le.geo_match_LENGTH_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTH_ErrorCount
          ,le.rawaid_ALLOW_ErrorCount,le.rawaid_LENGTH_ErrorCount
          ,le.orig_address1_ALLOW_ErrorCount
          ,le.orig_address2_ALLOW_ErrorCount
          ,le.statefn_ALLOW_ErrorCount
          ,le.lf_LENGTH_ErrorCount
          ,le.invalid_dob_dates_dob_Invalid_ErrorCount,le.invalid_dob_dates_process_date_Invalid_ErrorCount,le.invalid_dob_dates_dob_process_date_Condition_Invalid_ErrorCount
          ,le.invalid_dod_dates_dod_Invalid_ErrorCount,le.invalid_dod_dates_process_date_Invalid_ErrorCount,le.invalid_dod_dates_dod_process_date_Condition_Invalid_ErrorCount
          ,le.invalid_age_dates_dob_Invalid_ErrorCount,le.invalid_age_dates_dod_Invalid_ErrorCount,le.invalid_age_dates_dob_dod_Condition_Invalid_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.source_state_ALLOW_ErrorCount,le.source_state_LENGTH_ErrorCount
          ,le.certificate_vol_no_ALLOW_ErrorCount,le.certificate_vol_no_LENGTH_ErrorCount
          ,le.certificate_vol_year_ALLOW_ErrorCount,le.certificate_vol_year_LENGTH_ErrorCount
          ,le.publication_ALLOW_ErrorCount
          ,le.decedent_name_ALLOW_ErrorCount,le.decedent_name_LENGTH_ErrorCount
          ,le.decedent_race_ALLOW_ErrorCount
          ,le.decedent_origin_ALLOW_ErrorCount
          ,le.decedent_sex_ENUM_ErrorCount
          ,le.decedent_age_ALLOW_ErrorCount
          ,le.education_ALLOW_ErrorCount
          ,le.occupation_ALLOW_ErrorCount
          ,le.where_worked_ALLOW_ErrorCount
          ,le.cause_ALLOW_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTH_ErrorCount
          ,le.dob_ALLOW_ErrorCount
          ,le.dod_ALLOW_ErrorCount
          ,le.birthplace_ALLOW_ErrorCount
          ,le.marital_status_ALLOW_ErrorCount
          ,le.father_ALLOW_ErrorCount
          ,le.mother_ALLOW_ErrorCount
          ,le.filed_date_ALLOW_ErrorCount
          ,le.year_ALLOW_ErrorCount,le.year_LENGTH_ErrorCount
          ,le.county_residence_ALLOW_ErrorCount
          ,le.county_death_ALLOW_ErrorCount
          ,le.address_ALLOW_ErrorCount
          ,le.autopsy_ENUM_ErrorCount
          ,le.autopsy_findings_ALLOW_ErrorCount
          ,le.primary_cause_of_death_ALLOW_ErrorCount,le.primary_cause_of_death_LENGTH_ErrorCount
          ,le.underlying_cause_of_death_ALLOW_ErrorCount
          ,le.med_exam_ENUM_ErrorCount
          ,le.est_lic_no_ALLOW_ErrorCount,le.est_lic_no_LENGTH_ErrorCount
          ,le.disposition_ALLOW_ErrorCount
          ,le.disposition_date_ALLOW_ErrorCount
          ,le.work_injury_ENUM_ErrorCount
          ,le.injury_date_ALLOW_ErrorCount,le.injury_date_LENGTH_ErrorCount
          ,le.injury_type_ALLOW_ErrorCount
          ,le.injury_location_ALLOW_ErrorCount
          ,le.surg_performed_ENUM_ErrorCount
          ,le.surgery_date_ALLOW_ErrorCount
          ,le.hospital_status_ALLOW_ErrorCount
          ,le.pregnancy_ALLOW_ErrorCount
          ,le.facility_death_ALLOW_ErrorCount
          ,le.embalmer_lic_no_ALLOW_ErrorCount,le.embalmer_lic_no_LENGTH_ErrorCount
          ,le.death_type_ALLOW_ErrorCount
          ,le.time_death_ALLOW_ErrorCount
          ,le.birth_cert_ALLOW_ErrorCount
          ,le.certifier_ALLOW_ErrorCount
          ,le.cert_number_ALLOW_ErrorCount,le.cert_number_LENGTH_ErrorCount
          ,le.birth_vol_year_ALLOW_ErrorCount,le.birth_vol_year_LENGTH_ErrorCount
          ,le.local_file_no_ALLOW_ErrorCount,le.local_file_no_LENGTH_ErrorCount
          ,le.vdi_ALLOW_ErrorCount
          ,le.cite_id_ALLOW_ErrorCount
          ,le.file_id_ALLOW_ErrorCount,le.file_id_LENGTH_ErrorCount
          ,le.date_last_trans_ALLOW_ErrorCount
          ,le.amendment_code_ALLOW_ErrorCount,le.amendment_code_LENGTH_ErrorCount
          ,le.amendment_year_ALLOW_ErrorCount,le.amendment_year_LENGTH_ErrorCount
          ,le._on_lexis_ALLOW_ErrorCount,le._on_lexis_LENGTH_ErrorCount
          ,le._fs_profile_ALLOW_ErrorCount,le._fs_profile_LENGTH_ErrorCount
          ,le.us_armed_forces_ENUM_ErrorCount
          ,le.place_of_death_ALLOW_ErrorCount
          ,le.state_death_id_ALLOW_ErrorCount,le.state_death_id_LENGTH_ErrorCount
          ,le.state_death_flag_ENUM_ErrorCount,le.state_death_flag_LENGTH_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.name_score_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount,le.predir_LENGTH_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTH_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.cart_ALLOW_ErrorCount,le.cart_LENGTH_ErrorCount
          ,le.cr_sort_sz_ALLOW_ErrorCount,le.cr_sort_sz_LENGTH_ErrorCount
          ,le.lot_ALLOW_ErrorCount,le.lot_LENGTH_ErrorCount
          ,le.lot_order_ALLOW_ErrorCount,le.lot_order_LENGTH_ErrorCount
          ,le.dpbc_ALLOW_ErrorCount,le.dpbc_LENGTH_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount,le.chk_digit_LENGTH_ErrorCount
          ,le.rec_type_ALLOW_ErrorCount,le.rec_type_LENGTH_ErrorCount
          ,le.fips_state_ALLOW_ErrorCount,le.fips_state_LENGTH_ErrorCount
          ,le.fips_county_ALLOW_ErrorCount,le.fips_county_LENGTH_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount,le.geo_lat_LENGTH_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount,le.geo_long_LENGTH_ErrorCount
          ,le.msa_ALLOW_ErrorCount,le.msa_LENGTH_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTH_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount,le.geo_match_LENGTH_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTH_ErrorCount
          ,le.rawaid_ALLOW_ErrorCount,le.rawaid_LENGTH_ErrorCount
          ,le.orig_address1_ALLOW_ErrorCount
          ,le.orig_address2_ALLOW_ErrorCount
          ,le.statefn_ALLOW_ErrorCount
          ,le.lf_LENGTH_ErrorCount
          ,le.invalid_dob_dates_dob_Invalid_ErrorCount,le.invalid_dob_dates_process_date_Invalid_ErrorCount,le.invalid_dob_dates_dob_process_date_Condition_Invalid_ErrorCount
          ,le.invalid_dod_dates_dod_Invalid_ErrorCount,le.invalid_dod_dates_process_date_Invalid_ErrorCount,le.invalid_dod_dates_dod_process_date_Condition_Invalid_ErrorCount
          ,le.invalid_age_dates_dob_Invalid_ErrorCount,le.invalid_age_dates_dod_Invalid_ErrorCount,le.invalid_age_dates_dob_dod_Condition_Invalid_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,152,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      SALT30.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT30.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;

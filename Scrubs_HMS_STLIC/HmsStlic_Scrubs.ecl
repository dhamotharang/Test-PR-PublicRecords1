IMPORT ut,SALT31;
EXPORT HmsStlic_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(HmsStlic_Layout_HmsStlic)
    UNSIGNED1 ln_key_Invalid;
    UNSIGNED1 hms_src_Invalid;
    UNSIGNED1 key_Invalid;
    UNSIGNED1 id_Invalid;
    UNSIGNED1 entityid_Invalid;
    UNSIGNED1 license_number_Invalid;
    UNSIGNED1 license_class_type_Invalid;
    UNSIGNED1 license_state_Invalid;
    UNSIGNED1 status_Invalid;
    UNSIGNED1 issue_date_Invalid;
    UNSIGNED1 expiration_date_Invalid;
    UNSIGNED1 qualifier1_Invalid;
    UNSIGNED1 qualifier2_Invalid;
    UNSIGNED1 qualifier3_Invalid;
    UNSIGNED1 qualifier4_Invalid;
    UNSIGNED1 qualifier5_Invalid;
    UNSIGNED1 rawclass_Invalid;
    UNSIGNED1 rawissue_date_Invalid;
    UNSIGNED1 rawexpiration_date_Invalid;
    UNSIGNED1 rawstatus_Invalid;
    UNSIGNED1 raw_number_Invalid;
    UNSIGNED1 name_Invalid;
    UNSIGNED1 first_Invalid;
    UNSIGNED1 middle_Invalid;
    UNSIGNED1 last_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 cred_Invalid;
    UNSIGNED1 age_Invalid;
    UNSIGNED1 dateofbirth_Invalid;
    UNSIGNED1 email_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 dateofdeath_Invalid;
    UNSIGNED1 firmname_Invalid;
    UNSIGNED1 street1_Invalid;
    UNSIGNED1 street2_Invalid;
    UNSIGNED1 street3_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 address_state_Invalid;
    UNSIGNED1 orig_zip_Invalid;
    UNSIGNED1 orig_county_Invalid;
    UNSIGNED1 country_Invalid;
    UNSIGNED1 address_type_Invalid;
    UNSIGNED1 phone1_Invalid;
    UNSIGNED1 phone2_Invalid;
    UNSIGNED1 phone3_Invalid;
    UNSIGNED1 fax1_Invalid;
    UNSIGNED1 fax2_Invalid;
    UNSIGNED1 fax3_Invalid;
    UNSIGNED1 other_phone1_Invalid;
    UNSIGNED1 description_Invalid;
    UNSIGNED1 specialty_class_type_Invalid;
    UNSIGNED1 phone_number_Invalid;
    UNSIGNED1 phone_type_Invalid;
    UNSIGNED1 language_Invalid;
    UNSIGNED1 graduated_Invalid;
    UNSIGNED1 school_Invalid;
    UNSIGNED1 location_Invalid;
    UNSIGNED1 board_Invalid;
    UNSIGNED1 offense_Invalid;
    UNSIGNED1 offense_date_Invalid;
    UNSIGNED1 action_Invalid;
    UNSIGNED1 action_date_Invalid;
    UNSIGNED1 action_start_Invalid;
    UNSIGNED1 action_end_Invalid;
    UNSIGNED1 npi_number_Invalid;
    UNSIGNED1 csr_number_Invalid;
    UNSIGNED1 dea_number_Invalid;
    UNSIGNED1 prepped_addr1_Invalid;
    UNSIGNED1 prepped_addr2_Invalid;
    UNSIGNED1 clean_phone_Invalid;
    UNSIGNED1 clean_phone1_Invalid;
    UNSIGNED1 clean_phone2_Invalid;
    UNSIGNED1 clean_phone3_Invalid;
    UNSIGNED1 clean_fax1_Invalid;
    UNSIGNED1 clean_fax2_Invalid;
    UNSIGNED1 clean_fax3_Invalid;
    UNSIGNED1 clean_other_phone1_Invalid;
    UNSIGNED1 clean_dateofbirth_Invalid;
    UNSIGNED1 clean_dateofdeath_Invalid;
    UNSIGNED1 clean_company_name_Invalid;
    UNSIGNED1 clean_issue_date_Invalid;
    UNSIGNED1 clean_expiration_date_Invalid;
    UNSIGNED1 clean_offense_date_Invalid;
    UNSIGNED1 clean_action_date_Invalid;
    UNSIGNED1 src_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 bdid_score_Invalid;
    UNSIGNED1 lnpid_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 in_state_Invalid;
    UNSIGNED1 in_class_Invalid;
    UNSIGNED1 in_status_Invalid;
    UNSIGNED1 in_qualifier1_Invalid;
    UNSIGNED1 in_qualifier2_Invalid;
    UNSIGNED1 mapped_class_Invalid;
    UNSIGNED1 mapped_status_Invalid;
    UNSIGNED1 mapped_qualifier1_Invalid;
    UNSIGNED1 mapped_qualifier2_Invalid;
    UNSIGNED1 mapped_pdma_Invalid;
    UNSIGNED1 mapped_pract_type_Invalid;
    UNSIGNED1 source_code_Invalid;
    UNSIGNED1 taxonomy_code_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(HmsStlic_Layout_HmsStlic)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
    UNSIGNED8 ScrubsBits5;
  END;
EXPORT FromNone(DATASET(HmsStlic_Layout_HmsStlic) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ln_key_Invalid := HmsStlic_Fields.InValid_ln_key((SALT31.StrType)le.ln_key);
    SELF.hms_src_Invalid := HmsStlic_Fields.InValid_hms_src((SALT31.StrType)le.hms_src);
    SELF.key_Invalid := HmsStlic_Fields.InValid_key((SALT31.StrType)le.key);
    SELF.id_Invalid := HmsStlic_Fields.InValid_id((SALT31.StrType)le.id);
    SELF.entityid_Invalid := HmsStlic_Fields.InValid_entityid((SALT31.StrType)le.entityid);
    SELF.license_number_Invalid := HmsStlic_Fields.InValid_license_number((SALT31.StrType)le.license_number);
    SELF.license_class_type_Invalid := HmsStlic_Fields.InValid_license_class_type((SALT31.StrType)le.license_class_type);
    SELF.license_state_Invalid := HmsStlic_Fields.InValid_license_state((SALT31.StrType)le.license_state);
    SELF.status_Invalid := HmsStlic_Fields.InValid_status((SALT31.StrType)le.status);
    SELF.issue_date_Invalid := HmsStlic_Fields.InValid_issue_date((SALT31.StrType)le.issue_date);
    SELF.expiration_date_Invalid := HmsStlic_Fields.InValid_expiration_date((SALT31.StrType)le.expiration_date);
    SELF.qualifier1_Invalid := HmsStlic_Fields.InValid_qualifier1((SALT31.StrType)le.qualifier1);
    SELF.qualifier2_Invalid := HmsStlic_Fields.InValid_qualifier2((SALT31.StrType)le.qualifier2);
    SELF.qualifier3_Invalid := HmsStlic_Fields.InValid_qualifier3((SALT31.StrType)le.qualifier3);
    SELF.qualifier4_Invalid := HmsStlic_Fields.InValid_qualifier4((SALT31.StrType)le.qualifier4);
    SELF.qualifier5_Invalid := HmsStlic_Fields.InValid_qualifier5((SALT31.StrType)le.qualifier5);
    SELF.rawclass_Invalid := HmsStlic_Fields.InValid_rawclass((SALT31.StrType)le.rawclass);
    SELF.rawissue_date_Invalid := HmsStlic_Fields.InValid_rawissue_date((SALT31.StrType)le.rawissue_date);
    SELF.rawexpiration_date_Invalid := HmsStlic_Fields.InValid_rawexpiration_date((SALT31.StrType)le.rawexpiration_date);
    SELF.rawstatus_Invalid := HmsStlic_Fields.InValid_rawstatus((SALT31.StrType)le.rawstatus);
    SELF.raw_number_Invalid := HmsStlic_Fields.InValid_raw_number((SALT31.StrType)le.raw_number);
    SELF.name_Invalid := HmsStlic_Fields.InValid_name((SALT31.StrType)le.name);
    SELF.first_Invalid := HmsStlic_Fields.InValid_first((SALT31.StrType)le.first);
    SELF.middle_Invalid := HmsStlic_Fields.InValid_middle((SALT31.StrType)le.middle);
    SELF.last_Invalid := HmsStlic_Fields.InValid_last((SALT31.StrType)le.last);
    SELF.suffix_Invalid := HmsStlic_Fields.InValid_suffix((SALT31.StrType)le.suffix);
    SELF.cred_Invalid := HmsStlic_Fields.InValid_cred((SALT31.StrType)le.cred);
    SELF.age_Invalid := HmsStlic_Fields.InValid_age((SALT31.StrType)le.age);
    SELF.dateofbirth_Invalid := HmsStlic_Fields.InValid_dateofbirth((SALT31.StrType)le.dateofbirth);
    SELF.email_Invalid := HmsStlic_Fields.InValid_email((SALT31.StrType)le.email);
    SELF.gender_Invalid := HmsStlic_Fields.InValid_gender((SALT31.StrType)le.gender);
    SELF.dateofdeath_Invalid := HmsStlic_Fields.InValid_dateofdeath((SALT31.StrType)le.dateofdeath);
    SELF.firmname_Invalid := HmsStlic_Fields.InValid_firmname((SALT31.StrType)le.firmname);
    SELF.street1_Invalid := HmsStlic_Fields.InValid_street1((SALT31.StrType)le.street1);
    SELF.street2_Invalid := HmsStlic_Fields.InValid_street2((SALT31.StrType)le.street2);
    SELF.street3_Invalid := HmsStlic_Fields.InValid_street3((SALT31.StrType)le.street3);
    SELF.city_Invalid := HmsStlic_Fields.InValid_city((SALT31.StrType)le.city);
    SELF.address_state_Invalid := HmsStlic_Fields.InValid_address_state((SALT31.StrType)le.address_state);
    SELF.orig_zip_Invalid := HmsStlic_Fields.InValid_orig_zip((SALT31.StrType)le.orig_zip);
    SELF.orig_county_Invalid := HmsStlic_Fields.InValid_orig_county((SALT31.StrType)le.orig_county);
    SELF.country_Invalid := HmsStlic_Fields.InValid_country((SALT31.StrType)le.country);
    SELF.address_type_Invalid := HmsStlic_Fields.InValid_address_type((SALT31.StrType)le.address_type);
    SELF.phone1_Invalid := HmsStlic_Fields.InValid_phone1((SALT31.StrType)le.phone1);
    SELF.phone2_Invalid := HmsStlic_Fields.InValid_phone2((SALT31.StrType)le.phone2);
    SELF.phone3_Invalid := HmsStlic_Fields.InValid_phone3((SALT31.StrType)le.phone3);
    SELF.fax1_Invalid := HmsStlic_Fields.InValid_fax1((SALT31.StrType)le.fax1);
    SELF.fax2_Invalid := HmsStlic_Fields.InValid_fax2((SALT31.StrType)le.fax2);
    SELF.fax3_Invalid := HmsStlic_Fields.InValid_fax3((SALT31.StrType)le.fax3);
    SELF.other_phone1_Invalid := HmsStlic_Fields.InValid_other_phone1((SALT31.StrType)le.other_phone1);
    SELF.description_Invalid := HmsStlic_Fields.InValid_description((SALT31.StrType)le.description);
    SELF.specialty_class_type_Invalid := HmsStlic_Fields.InValid_specialty_class_type((SALT31.StrType)le.specialty_class_type);
    SELF.phone_number_Invalid := HmsStlic_Fields.InValid_phone_number((SALT31.StrType)le.phone_number);
    SELF.phone_type_Invalid := HmsStlic_Fields.InValid_phone_type((SALT31.StrType)le.phone_type);
    SELF.language_Invalid := HmsStlic_Fields.InValid_language((SALT31.StrType)le.language);
    SELF.graduated_Invalid := HmsStlic_Fields.InValid_graduated((SALT31.StrType)le.graduated);
    SELF.school_Invalid := HmsStlic_Fields.InValid_school((SALT31.StrType)le.school);
    SELF.location_Invalid := HmsStlic_Fields.InValid_location((SALT31.StrType)le.location);
    SELF.board_Invalid := HmsStlic_Fields.InValid_board((SALT31.StrType)le.board);
    SELF.offense_Invalid := HmsStlic_Fields.InValid_offense((SALT31.StrType)le.offense);
    SELF.offense_date_Invalid := HmsStlic_Fields.InValid_offense_date((SALT31.StrType)le.offense_date);
    SELF.action_Invalid := HmsStlic_Fields.InValid_action((SALT31.StrType)le.action);
    SELF.action_date_Invalid := HmsStlic_Fields.InValid_action_date((SALT31.StrType)le.action_date);
    SELF.action_start_Invalid := HmsStlic_Fields.InValid_action_start((SALT31.StrType)le.action_start);
    SELF.action_end_Invalid := HmsStlic_Fields.InValid_action_end((SALT31.StrType)le.action_end);
    SELF.npi_number_Invalid := HmsStlic_Fields.InValid_npi_number((SALT31.StrType)le.npi_number);
    SELF.csr_number_Invalid := HmsStlic_Fields.InValid_csr_number((SALT31.StrType)le.csr_number);
    SELF.dea_number_Invalid := HmsStlic_Fields.InValid_dea_number((SALT31.StrType)le.dea_number);
    SELF.prepped_addr1_Invalid := HmsStlic_Fields.InValid_prepped_addr1((SALT31.StrType)le.prepped_addr1);
    SELF.prepped_addr2_Invalid := HmsStlic_Fields.InValid_prepped_addr2((SALT31.StrType)le.prepped_addr2);
    SELF.clean_phone_Invalid := HmsStlic_Fields.InValid_clean_phone((SALT31.StrType)le.clean_phone);
    SELF.clean_phone1_Invalid := HmsStlic_Fields.InValid_clean_phone1((SALT31.StrType)le.clean_phone1);
    SELF.clean_phone2_Invalid := HmsStlic_Fields.InValid_clean_phone2((SALT31.StrType)le.clean_phone2);
    SELF.clean_phone3_Invalid := HmsStlic_Fields.InValid_clean_phone3((SALT31.StrType)le.clean_phone3);
    SELF.clean_fax1_Invalid := HmsStlic_Fields.InValid_clean_fax1((SALT31.StrType)le.clean_fax1);
    SELF.clean_fax2_Invalid := HmsStlic_Fields.InValid_clean_fax2((SALT31.StrType)le.clean_fax2);
    SELF.clean_fax3_Invalid := HmsStlic_Fields.InValid_clean_fax3((SALT31.StrType)le.clean_fax3);
    SELF.clean_other_phone1_Invalid := HmsStlic_Fields.InValid_clean_other_phone1((SALT31.StrType)le.clean_other_phone1);
    SELF.clean_dateofbirth_Invalid := HmsStlic_Fields.InValid_clean_dateofbirth((SALT31.StrType)le.clean_dateofbirth);
    SELF.clean_dateofdeath_Invalid := HmsStlic_Fields.InValid_clean_dateofdeath((SALT31.StrType)le.clean_dateofdeath);
    SELF.clean_company_name_Invalid := HmsStlic_Fields.InValid_clean_company_name((SALT31.StrType)le.clean_company_name);
    SELF.clean_issue_date_Invalid := HmsStlic_Fields.InValid_clean_issue_date((SALT31.StrType)le.clean_issue_date);
    SELF.clean_expiration_date_Invalid := HmsStlic_Fields.InValid_clean_expiration_date((SALT31.StrType)le.clean_expiration_date);
    SELF.clean_offense_date_Invalid := HmsStlic_Fields.InValid_clean_offense_date((SALT31.StrType)le.clean_offense_date);
    SELF.clean_action_date_Invalid := HmsStlic_Fields.InValid_clean_action_date((SALT31.StrType)le.clean_action_date);
    SELF.src_Invalid := HmsStlic_Fields.InValid_src((SALT31.StrType)le.src);
    SELF.zip_Invalid := HmsStlic_Fields.InValid_zip((SALT31.StrType)le.zip);
    SELF.zip4_Invalid := HmsStlic_Fields.InValid_zip4((SALT31.StrType)le.zip4);
    SELF.bdid_Invalid := HmsStlic_Fields.InValid_bdid((SALT31.StrType)le.bdid);
    SELF.bdid_score_Invalid := HmsStlic_Fields.InValid_bdid_score((SALT31.StrType)le.bdid_score);
    SELF.lnpid_Invalid := HmsStlic_Fields.InValid_lnpid((SALT31.StrType)le.lnpid);
    SELF.did_Invalid := HmsStlic_Fields.InValid_did((SALT31.StrType)le.did);
    SELF.did_score_Invalid := HmsStlic_Fields.InValid_did_score((SALT31.StrType)le.did_score);
    SELF.dt_vendor_first_reported_Invalid := HmsStlic_Fields.InValid_dt_vendor_first_reported((SALT31.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := HmsStlic_Fields.InValid_dt_vendor_last_reported((SALT31.StrType)le.dt_vendor_last_reported);
    SELF.in_state_Invalid := HmsStlic_Fields.InValid_in_state((SALT31.StrType)le.in_state);
    SELF.in_class_Invalid := HmsStlic_Fields.InValid_in_class((SALT31.StrType)le.in_class);
    SELF.in_status_Invalid := HmsStlic_Fields.InValid_in_status((SALT31.StrType)le.in_status);
    SELF.in_qualifier1_Invalid := HmsStlic_Fields.InValid_in_qualifier1((SALT31.StrType)le.in_qualifier1);
    SELF.in_qualifier2_Invalid := HmsStlic_Fields.InValid_in_qualifier2((SALT31.StrType)le.in_qualifier2);
    SELF.mapped_class_Invalid := HmsStlic_Fields.InValid_mapped_class((SALT31.StrType)le.mapped_class);
    SELF.mapped_status_Invalid := HmsStlic_Fields.InValid_mapped_status((SALT31.StrType)le.mapped_status);
    SELF.mapped_qualifier1_Invalid := HmsStlic_Fields.InValid_mapped_qualifier1((SALT31.StrType)le.mapped_qualifier1);
    SELF.mapped_qualifier2_Invalid := HmsStlic_Fields.InValid_mapped_qualifier2((SALT31.StrType)le.mapped_qualifier2);
    SELF.mapped_pdma_Invalid := HmsStlic_Fields.InValid_mapped_pdma((SALT31.StrType)le.mapped_pdma);
    SELF.mapped_pract_type_Invalid := HmsStlic_Fields.InValid_mapped_pract_type((SALT31.StrType)le.mapped_pract_type);
    SELF.source_code_Invalid := HmsStlic_Fields.InValid_source_code((SALT31.StrType)le.source_code);
    SELF.taxonomy_code_Invalid := HmsStlic_Fields.InValid_taxonomy_code((SALT31.StrType)le.taxonomy_code);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ln_key_Invalid << 0 ) + ( le.hms_src_Invalid << 3 ) + ( le.key_Invalid << 6 ) + ( le.id_Invalid << 9 ) + ( le.entityid_Invalid << 12 ) + ( le.license_number_Invalid << 15 ) + ( le.license_class_type_Invalid << 18 ) + ( le.license_state_Invalid << 21 ) + ( le.status_Invalid << 24 ) + ( le.issue_date_Invalid << 27 ) + ( le.expiration_date_Invalid << 30 ) + ( le.qualifier1_Invalid << 33 ) + ( le.qualifier2_Invalid << 35 ) + ( le.qualifier3_Invalid << 37 ) + ( le.qualifier4_Invalid << 39 ) + ( le.qualifier5_Invalid << 41 ) + ( le.rawclass_Invalid << 43 ) + ( le.rawissue_date_Invalid << 46 ) + ( le.rawexpiration_date_Invalid << 49 ) + ( le.rawstatus_Invalid << 52 ) + ( le.raw_number_Invalid << 55 ) + ( le.name_Invalid << 58 ) + ( le.first_Invalid << 60 ) + ( le.middle_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.last_Invalid << 0 ) + ( le.suffix_Invalid << 2 ) + ( le.cred_Invalid << 4 ) + ( le.age_Invalid << 6 ) + ( le.dateofbirth_Invalid << 9 ) + ( le.email_Invalid << 12 ) + ( le.gender_Invalid << 15 ) + ( le.dateofdeath_Invalid << 18 ) + ( le.firmname_Invalid << 21 ) + ( le.street1_Invalid << 23 ) + ( le.street2_Invalid << 25 ) + ( le.street3_Invalid << 27 ) + ( le.city_Invalid << 29 ) + ( le.address_state_Invalid << 31 ) + ( le.orig_zip_Invalid << 34 ) + ( le.orig_county_Invalid << 37 ) + ( le.country_Invalid << 39 ) + ( le.address_type_Invalid << 41 ) + ( le.phone1_Invalid << 43 ) + ( le.phone2_Invalid << 46 ) + ( le.phone3_Invalid << 49 ) + ( le.fax1_Invalid << 52 ) + ( le.fax2_Invalid << 55 ) + ( le.fax3_Invalid << 58 ) + ( le.other_phone1_Invalid << 61 );
    SELF.ScrubsBits3 := ( le.description_Invalid << 0 ) + ( le.specialty_class_type_Invalid << 2 ) + ( le.phone_number_Invalid << 5 ) + ( le.phone_type_Invalid << 8 ) + ( le.language_Invalid << 11 ) + ( le.graduated_Invalid << 13 ) + ( le.school_Invalid << 15 ) + ( le.location_Invalid << 17 ) + ( le.board_Invalid << 19 ) + ( le.offense_Invalid << 21 ) + ( le.offense_date_Invalid << 23 ) + ( le.action_Invalid << 26 ) + ( le.action_date_Invalid << 29 ) + ( le.action_start_Invalid << 32 ) + ( le.action_end_Invalid << 35 ) + ( le.npi_number_Invalid << 38 ) + ( le.csr_number_Invalid << 41 ) + ( le.dea_number_Invalid << 44 ) + ( le.prepped_addr1_Invalid << 47 ) + ( le.prepped_addr2_Invalid << 49 ) + ( le.clean_phone_Invalid << 51 ) + ( le.clean_phone1_Invalid << 54 ) + ( le.clean_phone2_Invalid << 57 ) + ( le.clean_phone3_Invalid << 60 );
    SELF.ScrubsBits4 := ( le.clean_fax1_Invalid << 0 ) + ( le.clean_fax2_Invalid << 3 ) + ( le.clean_fax3_Invalid << 6 ) + ( le.clean_other_phone1_Invalid << 9 ) + ( le.clean_dateofbirth_Invalid << 12 ) + ( le.clean_dateofdeath_Invalid << 15 ) + ( le.clean_company_name_Invalid << 18 ) + ( le.clean_issue_date_Invalid << 21 ) + ( le.clean_expiration_date_Invalid << 24 ) + ( le.clean_offense_date_Invalid << 27 ) + ( le.clean_action_date_Invalid << 30 ) + ( le.src_Invalid << 33 ) + ( le.zip_Invalid << 36 ) + ( le.zip4_Invalid << 39 ) + ( le.bdid_Invalid << 42 ) + ( le.bdid_score_Invalid << 45 ) + ( le.lnpid_Invalid << 48 ) + ( le.did_Invalid << 51 ) + ( le.did_score_Invalid << 54 ) + ( le.dt_vendor_first_reported_Invalid << 57 ) + ( le.dt_vendor_last_reported_Invalid << 60 );
    SELF.ScrubsBits5 := ( le.in_state_Invalid << 0 ) + ( le.in_class_Invalid << 2 ) + ( le.in_status_Invalid << 4 ) + ( le.in_qualifier1_Invalid << 6 ) + ( le.in_qualifier2_Invalid << 8 ) + ( le.mapped_class_Invalid << 10 ) + ( le.mapped_status_Invalid << 12 ) + ( le.mapped_qualifier1_Invalid << 14 ) + ( le.mapped_qualifier2_Invalid << 16 ) + ( le.mapped_pdma_Invalid << 18 ) + ( le.mapped_pract_type_Invalid << 20 ) + ( le.source_code_Invalid << 22 ) + ( le.taxonomy_code_Invalid << 24 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,HmsStlic_Layout_HmsStlic);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ln_key_Invalid := (le.ScrubsBits1 >> 0) & 7;
    SELF.hms_src_Invalid := (le.ScrubsBits1 >> 3) & 7;
    SELF.key_Invalid := (le.ScrubsBits1 >> 6) & 7;
    SELF.id_Invalid := (le.ScrubsBits1 >> 9) & 7;
    SELF.entityid_Invalid := (le.ScrubsBits1 >> 12) & 7;
    SELF.license_number_Invalid := (le.ScrubsBits1 >> 15) & 7;
    SELF.license_class_type_Invalid := (le.ScrubsBits1 >> 18) & 7;
    SELF.license_state_Invalid := (le.ScrubsBits1 >> 21) & 7;
    SELF.status_Invalid := (le.ScrubsBits1 >> 24) & 7;
    SELF.issue_date_Invalid := (le.ScrubsBits1 >> 27) & 7;
    SELF.expiration_date_Invalid := (le.ScrubsBits1 >> 30) & 7;
    SELF.qualifier1_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.qualifier2_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.qualifier3_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.qualifier4_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.qualifier5_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.rawclass_Invalid := (le.ScrubsBits1 >> 43) & 7;
    SELF.rawissue_date_Invalid := (le.ScrubsBits1 >> 46) & 7;
    SELF.rawexpiration_date_Invalid := (le.ScrubsBits1 >> 49) & 7;
    SELF.rawstatus_Invalid := (le.ScrubsBits1 >> 52) & 7;
    SELF.raw_number_Invalid := (le.ScrubsBits1 >> 55) & 7;
    SELF.name_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.first_Invalid := (le.ScrubsBits1 >> 60) & 3;
    SELF.middle_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.last_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.suffix_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.cred_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.age_Invalid := (le.ScrubsBits2 >> 6) & 7;
    SELF.dateofbirth_Invalid := (le.ScrubsBits2 >> 9) & 7;
    SELF.email_Invalid := (le.ScrubsBits2 >> 12) & 7;
    SELF.gender_Invalid := (le.ScrubsBits2 >> 15) & 7;
    SELF.dateofdeath_Invalid := (le.ScrubsBits2 >> 18) & 7;
    SELF.firmname_Invalid := (le.ScrubsBits2 >> 21) & 3;
    SELF.street1_Invalid := (le.ScrubsBits2 >> 23) & 3;
    SELF.street2_Invalid := (le.ScrubsBits2 >> 25) & 3;
    SELF.street3_Invalid := (le.ScrubsBits2 >> 27) & 3;
    SELF.city_Invalid := (le.ScrubsBits2 >> 29) & 3;
    SELF.address_state_Invalid := (le.ScrubsBits2 >> 31) & 7;
    SELF.orig_zip_Invalid := (le.ScrubsBits2 >> 34) & 7;
    SELF.orig_county_Invalid := (le.ScrubsBits2 >> 37) & 3;
    SELF.country_Invalid := (le.ScrubsBits2 >> 39) & 3;
    SELF.address_type_Invalid := (le.ScrubsBits2 >> 41) & 3;
    SELF.phone1_Invalid := (le.ScrubsBits2 >> 43) & 7;
    SELF.phone2_Invalid := (le.ScrubsBits2 >> 46) & 7;
    SELF.phone3_Invalid := (le.ScrubsBits2 >> 49) & 7;
    SELF.fax1_Invalid := (le.ScrubsBits2 >> 52) & 7;
    SELF.fax2_Invalid := (le.ScrubsBits2 >> 55) & 7;
    SELF.fax3_Invalid := (le.ScrubsBits2 >> 58) & 7;
    SELF.other_phone1_Invalid := (le.ScrubsBits2 >> 61) & 7;
    SELF.description_Invalid := (le.ScrubsBits3 >> 0) & 3;
    SELF.specialty_class_type_Invalid := (le.ScrubsBits3 >> 2) & 7;
    SELF.phone_number_Invalid := (le.ScrubsBits3 >> 5) & 7;
    SELF.phone_type_Invalid := (le.ScrubsBits3 >> 8) & 7;
    SELF.language_Invalid := (le.ScrubsBits3 >> 11) & 3;
    SELF.graduated_Invalid := (le.ScrubsBits3 >> 13) & 3;
    SELF.school_Invalid := (le.ScrubsBits3 >> 15) & 3;
    SELF.location_Invalid := (le.ScrubsBits3 >> 17) & 3;
    SELF.board_Invalid := (le.ScrubsBits3 >> 19) & 3;
    SELF.offense_Invalid := (le.ScrubsBits3 >> 21) & 3;
    SELF.offense_date_Invalid := (le.ScrubsBits3 >> 23) & 7;
    SELF.action_Invalid := (le.ScrubsBits3 >> 26) & 7;
    SELF.action_date_Invalid := (le.ScrubsBits3 >> 29) & 7;
    SELF.action_start_Invalid := (le.ScrubsBits3 >> 32) & 7;
    SELF.action_end_Invalid := (le.ScrubsBits3 >> 35) & 7;
    SELF.npi_number_Invalid := (le.ScrubsBits3 >> 38) & 7;
    SELF.csr_number_Invalid := (le.ScrubsBits3 >> 41) & 7;
    SELF.dea_number_Invalid := (le.ScrubsBits3 >> 44) & 7;
    SELF.prepped_addr1_Invalid := (le.ScrubsBits3 >> 47) & 3;
    SELF.prepped_addr2_Invalid := (le.ScrubsBits3 >> 49) & 3;
    SELF.clean_phone_Invalid := (le.ScrubsBits3 >> 51) & 7;
    SELF.clean_phone1_Invalid := (le.ScrubsBits3 >> 54) & 7;
    SELF.clean_phone2_Invalid := (le.ScrubsBits3 >> 57) & 7;
    SELF.clean_phone3_Invalid := (le.ScrubsBits3 >> 60) & 7;
    SELF.clean_fax1_Invalid := (le.ScrubsBits4 >> 0) & 7;
    SELF.clean_fax2_Invalid := (le.ScrubsBits4 >> 3) & 7;
    SELF.clean_fax3_Invalid := (le.ScrubsBits4 >> 6) & 7;
    SELF.clean_other_phone1_Invalid := (le.ScrubsBits4 >> 9) & 7;
    SELF.clean_dateofbirth_Invalid := (le.ScrubsBits4 >> 12) & 7;
    SELF.clean_dateofdeath_Invalid := (le.ScrubsBits4 >> 15) & 7;
    SELF.clean_company_name_Invalid := (le.ScrubsBits4 >> 18) & 7;
    SELF.clean_issue_date_Invalid := (le.ScrubsBits4 >> 21) & 7;
    SELF.clean_expiration_date_Invalid := (le.ScrubsBits4 >> 24) & 7;
    SELF.clean_offense_date_Invalid := (le.ScrubsBits4 >> 27) & 7;
    SELF.clean_action_date_Invalid := (le.ScrubsBits4 >> 30) & 7;
    SELF.src_Invalid := (le.ScrubsBits4 >> 33) & 7;
    SELF.zip_Invalid := (le.ScrubsBits4 >> 36) & 7;
    SELF.zip4_Invalid := (le.ScrubsBits4 >> 39) & 7;
    SELF.bdid_Invalid := (le.ScrubsBits4 >> 42) & 7;
    SELF.bdid_score_Invalid := (le.ScrubsBits4 >> 45) & 7;
    SELF.lnpid_Invalid := (le.ScrubsBits4 >> 48) & 7;
    SELF.did_Invalid := (le.ScrubsBits4 >> 51) & 7;
    SELF.did_score_Invalid := (le.ScrubsBits4 >> 54) & 7;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits4 >> 57) & 7;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits4 >> 60) & 7;
    SELF.in_state_Invalid := (le.ScrubsBits5 >> 0) & 3;
    SELF.in_class_Invalid := (le.ScrubsBits5 >> 2) & 3;
    SELF.in_status_Invalid := (le.ScrubsBits5 >> 4) & 3;
    SELF.in_qualifier1_Invalid := (le.ScrubsBits5 >> 6) & 3;
    SELF.in_qualifier2_Invalid := (le.ScrubsBits5 >> 8) & 3;
    SELF.mapped_class_Invalid := (le.ScrubsBits5 >> 10) & 3;
    SELF.mapped_status_Invalid := (le.ScrubsBits5 >> 12) & 3;
    SELF.mapped_qualifier1_Invalid := (le.ScrubsBits5 >> 14) & 3;
    SELF.mapped_qualifier2_Invalid := (le.ScrubsBits5 >> 16) & 3;
    SELF.mapped_pdma_Invalid := (le.ScrubsBits5 >> 18) & 3;
    SELF.mapped_pract_type_Invalid := (le.ScrubsBits5 >> 20) & 3;
    SELF.source_code_Invalid := (le.ScrubsBits5 >> 22) & 3;
    SELF.taxonomy_code_Invalid := (le.ScrubsBits5 >> 24) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ln_key_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ln_key_Invalid=1);
    ln_key_ALLOW_ErrorCount := COUNT(GROUP,h.ln_key_Invalid=2);
    ln_key_LENGTH_ErrorCount := COUNT(GROUP,h.ln_key_Invalid=3);
    ln_key_WORDS_ErrorCount := COUNT(GROUP,h.ln_key_Invalid=4);
    ln_key_Total_ErrorCount := COUNT(GROUP,h.ln_key_Invalid>0);
    hms_src_LEFTTRIM_ErrorCount := COUNT(GROUP,h.hms_src_Invalid=1);
    hms_src_ALLOW_ErrorCount := COUNT(GROUP,h.hms_src_Invalid=2);
    hms_src_LENGTH_ErrorCount := COUNT(GROUP,h.hms_src_Invalid=3);
    hms_src_WORDS_ErrorCount := COUNT(GROUP,h.hms_src_Invalid=4);
    hms_src_Total_ErrorCount := COUNT(GROUP,h.hms_src_Invalid>0);
    key_LEFTTRIM_ErrorCount := COUNT(GROUP,h.key_Invalid=1);
    key_ALLOW_ErrorCount := COUNT(GROUP,h.key_Invalid=2);
    key_LENGTH_ErrorCount := COUNT(GROUP,h.key_Invalid=3);
    key_WORDS_ErrorCount := COUNT(GROUP,h.key_Invalid=4);
    key_Total_ErrorCount := COUNT(GROUP,h.key_Invalid>0);
    id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.id_Invalid=1);
    id_ALLOW_ErrorCount := COUNT(GROUP,h.id_Invalid=2);
    id_LENGTH_ErrorCount := COUNT(GROUP,h.id_Invalid=3);
    id_WORDS_ErrorCount := COUNT(GROUP,h.id_Invalid=4);
    id_Total_ErrorCount := COUNT(GROUP,h.id_Invalid>0);
    entityid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.entityid_Invalid=1);
    entityid_ALLOW_ErrorCount := COUNT(GROUP,h.entityid_Invalid=2);
    entityid_LENGTH_ErrorCount := COUNT(GROUP,h.entityid_Invalid=3);
    entityid_WORDS_ErrorCount := COUNT(GROUP,h.entityid_Invalid=4);
    entityid_Total_ErrorCount := COUNT(GROUP,h.entityid_Invalid>0);
    license_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.license_number_Invalid=1);
    license_number_ALLOW_ErrorCount := COUNT(GROUP,h.license_number_Invalid=2);
    license_number_LENGTH_ErrorCount := COUNT(GROUP,h.license_number_Invalid=3);
    license_number_WORDS_ErrorCount := COUNT(GROUP,h.license_number_Invalid=4);
    license_number_Total_ErrorCount := COUNT(GROUP,h.license_number_Invalid>0);
    license_class_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.license_class_type_Invalid=1);
    license_class_type_ALLOW_ErrorCount := COUNT(GROUP,h.license_class_type_Invalid=2);
    license_class_type_LENGTH_ErrorCount := COUNT(GROUP,h.license_class_type_Invalid=3);
    license_class_type_WORDS_ErrorCount := COUNT(GROUP,h.license_class_type_Invalid=4);
    license_class_type_Total_ErrorCount := COUNT(GROUP,h.license_class_type_Invalid>0);
    license_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.license_state_Invalid=1);
    license_state_ALLOW_ErrorCount := COUNT(GROUP,h.license_state_Invalid=2);
    license_state_LENGTH_ErrorCount := COUNT(GROUP,h.license_state_Invalid=3);
    license_state_WORDS_ErrorCount := COUNT(GROUP,h.license_state_Invalid=4);
    license_state_Total_ErrorCount := COUNT(GROUP,h.license_state_Invalid>0);
    status_LEFTTRIM_ErrorCount := COUNT(GROUP,h.status_Invalid=1);
    status_ALLOW_ErrorCount := COUNT(GROUP,h.status_Invalid=2);
    status_LENGTH_ErrorCount := COUNT(GROUP,h.status_Invalid=3);
    status_WORDS_ErrorCount := COUNT(GROUP,h.status_Invalid=4);
    status_Total_ErrorCount := COUNT(GROUP,h.status_Invalid>0);
    issue_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.issue_date_Invalid=1);
    issue_date_ALLOW_ErrorCount := COUNT(GROUP,h.issue_date_Invalid=2);
    issue_date_LENGTH_ErrorCount := COUNT(GROUP,h.issue_date_Invalid=3);
    issue_date_WORDS_ErrorCount := COUNT(GROUP,h.issue_date_Invalid=4);
    issue_date_Total_ErrorCount := COUNT(GROUP,h.issue_date_Invalid>0);
    expiration_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid=1);
    expiration_date_ALLOW_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid=2);
    expiration_date_LENGTH_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid=3);
    expiration_date_WORDS_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid=4);
    expiration_date_Total_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid>0);
    qualifier1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.qualifier1_Invalid=1);
    qualifier1_ALLOW_ErrorCount := COUNT(GROUP,h.qualifier1_Invalid=2);
    qualifier1_WORDS_ErrorCount := COUNT(GROUP,h.qualifier1_Invalid=3);
    qualifier1_Total_ErrorCount := COUNT(GROUP,h.qualifier1_Invalid>0);
    qualifier2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.qualifier2_Invalid=1);
    qualifier2_ALLOW_ErrorCount := COUNT(GROUP,h.qualifier2_Invalid=2);
    qualifier2_WORDS_ErrorCount := COUNT(GROUP,h.qualifier2_Invalid=3);
    qualifier2_Total_ErrorCount := COUNT(GROUP,h.qualifier2_Invalid>0);
    qualifier3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.qualifier3_Invalid=1);
    qualifier3_ALLOW_ErrorCount := COUNT(GROUP,h.qualifier3_Invalid=2);
    qualifier3_WORDS_ErrorCount := COUNT(GROUP,h.qualifier3_Invalid=3);
    qualifier3_Total_ErrorCount := COUNT(GROUP,h.qualifier3_Invalid>0);
    qualifier4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.qualifier4_Invalid=1);
    qualifier4_ALLOW_ErrorCount := COUNT(GROUP,h.qualifier4_Invalid=2);
    qualifier4_WORDS_ErrorCount := COUNT(GROUP,h.qualifier4_Invalid=3);
    qualifier4_Total_ErrorCount := COUNT(GROUP,h.qualifier4_Invalid>0);
    qualifier5_LEFTTRIM_ErrorCount := COUNT(GROUP,h.qualifier5_Invalid=1);
    qualifier5_ALLOW_ErrorCount := COUNT(GROUP,h.qualifier5_Invalid=2);
    qualifier5_WORDS_ErrorCount := COUNT(GROUP,h.qualifier5_Invalid=3);
    qualifier5_Total_ErrorCount := COUNT(GROUP,h.qualifier5_Invalid>0);
    rawclass_LEFTTRIM_ErrorCount := COUNT(GROUP,h.rawclass_Invalid=1);
    rawclass_ALLOW_ErrorCount := COUNT(GROUP,h.rawclass_Invalid=2);
    rawclass_LENGTH_ErrorCount := COUNT(GROUP,h.rawclass_Invalid=3);
    rawclass_WORDS_ErrorCount := COUNT(GROUP,h.rawclass_Invalid=4);
    rawclass_Total_ErrorCount := COUNT(GROUP,h.rawclass_Invalid>0);
    rawissue_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.rawissue_date_Invalid=1);
    rawissue_date_ALLOW_ErrorCount := COUNT(GROUP,h.rawissue_date_Invalid=2);
    rawissue_date_LENGTH_ErrorCount := COUNT(GROUP,h.rawissue_date_Invalid=3);
    rawissue_date_WORDS_ErrorCount := COUNT(GROUP,h.rawissue_date_Invalid=4);
    rawissue_date_Total_ErrorCount := COUNT(GROUP,h.rawissue_date_Invalid>0);
    rawexpiration_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.rawexpiration_date_Invalid=1);
    rawexpiration_date_ALLOW_ErrorCount := COUNT(GROUP,h.rawexpiration_date_Invalid=2);
    rawexpiration_date_LENGTH_ErrorCount := COUNT(GROUP,h.rawexpiration_date_Invalid=3);
    rawexpiration_date_WORDS_ErrorCount := COUNT(GROUP,h.rawexpiration_date_Invalid=4);
    rawexpiration_date_Total_ErrorCount := COUNT(GROUP,h.rawexpiration_date_Invalid>0);
    rawstatus_LEFTTRIM_ErrorCount := COUNT(GROUP,h.rawstatus_Invalid=1);
    rawstatus_ALLOW_ErrorCount := COUNT(GROUP,h.rawstatus_Invalid=2);
    rawstatus_LENGTH_ErrorCount := COUNT(GROUP,h.rawstatus_Invalid=3);
    rawstatus_WORDS_ErrorCount := COUNT(GROUP,h.rawstatus_Invalid=4);
    rawstatus_Total_ErrorCount := COUNT(GROUP,h.rawstatus_Invalid>0);
    raw_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.raw_number_Invalid=1);
    raw_number_ALLOW_ErrorCount := COUNT(GROUP,h.raw_number_Invalid=2);
    raw_number_LENGTH_ErrorCount := COUNT(GROUP,h.raw_number_Invalid=3);
    raw_number_WORDS_ErrorCount := COUNT(GROUP,h.raw_number_Invalid=4);
    raw_number_Total_ErrorCount := COUNT(GROUP,h.raw_number_Invalid>0);
    name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_Invalid=1);
    name_ALLOW_ErrorCount := COUNT(GROUP,h.name_Invalid=2);
    name_WORDS_ErrorCount := COUNT(GROUP,h.name_Invalid=3);
    name_Total_ErrorCount := COUNT(GROUP,h.name_Invalid>0);
    first_LEFTTRIM_ErrorCount := COUNT(GROUP,h.first_Invalid=1);
    first_ALLOW_ErrorCount := COUNT(GROUP,h.first_Invalid=2);
    first_WORDS_ErrorCount := COUNT(GROUP,h.first_Invalid=3);
    first_Total_ErrorCount := COUNT(GROUP,h.first_Invalid>0);
    middle_LEFTTRIM_ErrorCount := COUNT(GROUP,h.middle_Invalid=1);
    middle_ALLOW_ErrorCount := COUNT(GROUP,h.middle_Invalid=2);
    middle_WORDS_ErrorCount := COUNT(GROUP,h.middle_Invalid=3);
    middle_Total_ErrorCount := COUNT(GROUP,h.middle_Invalid>0);
    last_LEFTTRIM_ErrorCount := COUNT(GROUP,h.last_Invalid=1);
    last_ALLOW_ErrorCount := COUNT(GROUP,h.last_Invalid=2);
    last_WORDS_ErrorCount := COUNT(GROUP,h.last_Invalid=3);
    last_Total_ErrorCount := COUNT(GROUP,h.last_Invalid>0);
    suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=2);
    suffix_WORDS_ErrorCount := COUNT(GROUP,h.suffix_Invalid=3);
    suffix_Total_ErrorCount := COUNT(GROUP,h.suffix_Invalid>0);
    cred_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cred_Invalid=1);
    cred_ALLOW_ErrorCount := COUNT(GROUP,h.cred_Invalid=2);
    cred_WORDS_ErrorCount := COUNT(GROUP,h.cred_Invalid=3);
    cred_Total_ErrorCount := COUNT(GROUP,h.cred_Invalid>0);
    age_LEFTTRIM_ErrorCount := COUNT(GROUP,h.age_Invalid=1);
    age_ALLOW_ErrorCount := COUNT(GROUP,h.age_Invalid=2);
    age_LENGTH_ErrorCount := COUNT(GROUP,h.age_Invalid=3);
    age_WORDS_ErrorCount := COUNT(GROUP,h.age_Invalid=4);
    age_Total_ErrorCount := COUNT(GROUP,h.age_Invalid>0);
    dateofbirth_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dateofbirth_Invalid=1);
    dateofbirth_ALLOW_ErrorCount := COUNT(GROUP,h.dateofbirth_Invalid=2);
    dateofbirth_LENGTH_ErrorCount := COUNT(GROUP,h.dateofbirth_Invalid=3);
    dateofbirth_WORDS_ErrorCount := COUNT(GROUP,h.dateofbirth_Invalid=4);
    dateofbirth_Total_ErrorCount := COUNT(GROUP,h.dateofbirth_Invalid>0);
    email_LEFTTRIM_ErrorCount := COUNT(GROUP,h.email_Invalid=1);
    email_ALLOW_ErrorCount := COUNT(GROUP,h.email_Invalid=2);
    email_LENGTH_ErrorCount := COUNT(GROUP,h.email_Invalid=3);
    email_WORDS_ErrorCount := COUNT(GROUP,h.email_Invalid=4);
    email_Total_ErrorCount := COUNT(GROUP,h.email_Invalid>0);
    gender_LEFTTRIM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    gender_ALLOW_ErrorCount := COUNT(GROUP,h.gender_Invalid=2);
    gender_LENGTH_ErrorCount := COUNT(GROUP,h.gender_Invalid=3);
    gender_WORDS_ErrorCount := COUNT(GROUP,h.gender_Invalid=4);
    gender_Total_ErrorCount := COUNT(GROUP,h.gender_Invalid>0);
    dateofdeath_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dateofdeath_Invalid=1);
    dateofdeath_ALLOW_ErrorCount := COUNT(GROUP,h.dateofdeath_Invalid=2);
    dateofdeath_LENGTH_ErrorCount := COUNT(GROUP,h.dateofdeath_Invalid=3);
    dateofdeath_WORDS_ErrorCount := COUNT(GROUP,h.dateofdeath_Invalid=4);
    dateofdeath_Total_ErrorCount := COUNT(GROUP,h.dateofdeath_Invalid>0);
    firmname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.firmname_Invalid=1);
    firmname_ALLOW_ErrorCount := COUNT(GROUP,h.firmname_Invalid=2);
    firmname_WORDS_ErrorCount := COUNT(GROUP,h.firmname_Invalid=3);
    firmname_Total_ErrorCount := COUNT(GROUP,h.firmname_Invalid>0);
    street1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.street1_Invalid=1);
    street1_ALLOW_ErrorCount := COUNT(GROUP,h.street1_Invalid=2);
    street1_WORDS_ErrorCount := COUNT(GROUP,h.street1_Invalid=3);
    street1_Total_ErrorCount := COUNT(GROUP,h.street1_Invalid>0);
    street2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.street2_Invalid=1);
    street2_ALLOW_ErrorCount := COUNT(GROUP,h.street2_Invalid=2);
    street2_WORDS_ErrorCount := COUNT(GROUP,h.street2_Invalid=3);
    street2_Total_ErrorCount := COUNT(GROUP,h.street2_Invalid>0);
    street3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.street3_Invalid=1);
    street3_ALLOW_ErrorCount := COUNT(GROUP,h.street3_Invalid=2);
    street3_WORDS_ErrorCount := COUNT(GROUP,h.street3_Invalid=3);
    street3_Total_ErrorCount := COUNT(GROUP,h.street3_Invalid>0);
    city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=2);
    city_WORDS_ErrorCount := COUNT(GROUP,h.city_Invalid=3);
    city_Total_ErrorCount := COUNT(GROUP,h.city_Invalid>0);
    address_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.address_state_Invalid=1);
    address_state_ALLOW_ErrorCount := COUNT(GROUP,h.address_state_Invalid=2);
    address_state_LENGTH_ErrorCount := COUNT(GROUP,h.address_state_Invalid=3);
    address_state_WORDS_ErrorCount := COUNT(GROUP,h.address_state_Invalid=4);
    address_state_Total_ErrorCount := COUNT(GROUP,h.address_state_Invalid>0);
    orig_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=1);
    orig_zip_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=2);
    orig_zip_LENGTH_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=3);
    orig_zip_WORDS_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=4);
    orig_zip_Total_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid>0);
    orig_county_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_county_Invalid=1);
    orig_county_ALLOW_ErrorCount := COUNT(GROUP,h.orig_county_Invalid=2);
    orig_county_WORDS_ErrorCount := COUNT(GROUP,h.orig_county_Invalid=3);
    orig_county_Total_ErrorCount := COUNT(GROUP,h.orig_county_Invalid>0);
    country_LEFTTRIM_ErrorCount := COUNT(GROUP,h.country_Invalid=1);
    country_ALLOW_ErrorCount := COUNT(GROUP,h.country_Invalid=2);
    country_WORDS_ErrorCount := COUNT(GROUP,h.country_Invalid=3);
    country_Total_ErrorCount := COUNT(GROUP,h.country_Invalid>0);
    address_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.address_type_Invalid=1);
    address_type_ALLOW_ErrorCount := COUNT(GROUP,h.address_type_Invalid=2);
    address_type_WORDS_ErrorCount := COUNT(GROUP,h.address_type_Invalid=3);
    address_type_Total_ErrorCount := COUNT(GROUP,h.address_type_Invalid>0);
    phone1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phone1_Invalid=1);
    phone1_ALLOW_ErrorCount := COUNT(GROUP,h.phone1_Invalid=2);
    phone1_LENGTH_ErrorCount := COUNT(GROUP,h.phone1_Invalid=3);
    phone1_WORDS_ErrorCount := COUNT(GROUP,h.phone1_Invalid=4);
    phone1_Total_ErrorCount := COUNT(GROUP,h.phone1_Invalid>0);
    phone2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phone2_Invalid=1);
    phone2_ALLOW_ErrorCount := COUNT(GROUP,h.phone2_Invalid=2);
    phone2_LENGTH_ErrorCount := COUNT(GROUP,h.phone2_Invalid=3);
    phone2_WORDS_ErrorCount := COUNT(GROUP,h.phone2_Invalid=4);
    phone2_Total_ErrorCount := COUNT(GROUP,h.phone2_Invalid>0);
    phone3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phone3_Invalid=1);
    phone3_ALLOW_ErrorCount := COUNT(GROUP,h.phone3_Invalid=2);
    phone3_LENGTH_ErrorCount := COUNT(GROUP,h.phone3_Invalid=3);
    phone3_WORDS_ErrorCount := COUNT(GROUP,h.phone3_Invalid=4);
    phone3_Total_ErrorCount := COUNT(GROUP,h.phone3_Invalid>0);
    fax1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fax1_Invalid=1);
    fax1_ALLOW_ErrorCount := COUNT(GROUP,h.fax1_Invalid=2);
    fax1_LENGTH_ErrorCount := COUNT(GROUP,h.fax1_Invalid=3);
    fax1_WORDS_ErrorCount := COUNT(GROUP,h.fax1_Invalid=4);
    fax1_Total_ErrorCount := COUNT(GROUP,h.fax1_Invalid>0);
    fax2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fax2_Invalid=1);
    fax2_ALLOW_ErrorCount := COUNT(GROUP,h.fax2_Invalid=2);
    fax2_LENGTH_ErrorCount := COUNT(GROUP,h.fax2_Invalid=3);
    fax2_WORDS_ErrorCount := COUNT(GROUP,h.fax2_Invalid=4);
    fax2_Total_ErrorCount := COUNT(GROUP,h.fax2_Invalid>0);
    fax3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fax3_Invalid=1);
    fax3_ALLOW_ErrorCount := COUNT(GROUP,h.fax3_Invalid=2);
    fax3_LENGTH_ErrorCount := COUNT(GROUP,h.fax3_Invalid=3);
    fax3_WORDS_ErrorCount := COUNT(GROUP,h.fax3_Invalid=4);
    fax3_Total_ErrorCount := COUNT(GROUP,h.fax3_Invalid>0);
    other_phone1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_phone1_Invalid=1);
    other_phone1_ALLOW_ErrorCount := COUNT(GROUP,h.other_phone1_Invalid=2);
    other_phone1_LENGTH_ErrorCount := COUNT(GROUP,h.other_phone1_Invalid=3);
    other_phone1_WORDS_ErrorCount := COUNT(GROUP,h.other_phone1_Invalid=4);
    other_phone1_Total_ErrorCount := COUNT(GROUP,h.other_phone1_Invalid>0);
    description_LEFTTRIM_ErrorCount := COUNT(GROUP,h.description_Invalid=1);
    description_ALLOW_ErrorCount := COUNT(GROUP,h.description_Invalid=2);
    description_WORDS_ErrorCount := COUNT(GROUP,h.description_Invalid=3);
    description_Total_ErrorCount := COUNT(GROUP,h.description_Invalid>0);
    specialty_class_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.specialty_class_type_Invalid=1);
    specialty_class_type_ALLOW_ErrorCount := COUNT(GROUP,h.specialty_class_type_Invalid=2);
    specialty_class_type_LENGTH_ErrorCount := COUNT(GROUP,h.specialty_class_type_Invalid=3);
    specialty_class_type_WORDS_ErrorCount := COUNT(GROUP,h.specialty_class_type_Invalid=4);
    specialty_class_type_Total_ErrorCount := COUNT(GROUP,h.specialty_class_type_Invalid>0);
    phone_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=1);
    phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=2);
    phone_number_LENGTH_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=3);
    phone_number_WORDS_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=4);
    phone_number_Total_ErrorCount := COUNT(GROUP,h.phone_number_Invalid>0);
    phone_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phone_type_Invalid=1);
    phone_type_ALLOW_ErrorCount := COUNT(GROUP,h.phone_type_Invalid=2);
    phone_type_LENGTH_ErrorCount := COUNT(GROUP,h.phone_type_Invalid=3);
    phone_type_WORDS_ErrorCount := COUNT(GROUP,h.phone_type_Invalid=4);
    phone_type_Total_ErrorCount := COUNT(GROUP,h.phone_type_Invalid>0);
    language_LEFTTRIM_ErrorCount := COUNT(GROUP,h.language_Invalid=1);
    language_ALLOW_ErrorCount := COUNT(GROUP,h.language_Invalid=2);
    language_WORDS_ErrorCount := COUNT(GROUP,h.language_Invalid=3);
    language_Total_ErrorCount := COUNT(GROUP,h.language_Invalid>0);
    graduated_LEFTTRIM_ErrorCount := COUNT(GROUP,h.graduated_Invalid=1);
    graduated_ALLOW_ErrorCount := COUNT(GROUP,h.graduated_Invalid=2);
    graduated_WORDS_ErrorCount := COUNT(GROUP,h.graduated_Invalid=3);
    graduated_Total_ErrorCount := COUNT(GROUP,h.graduated_Invalid>0);
    school_LEFTTRIM_ErrorCount := COUNT(GROUP,h.school_Invalid=1);
    school_ALLOW_ErrorCount := COUNT(GROUP,h.school_Invalid=2);
    school_WORDS_ErrorCount := COUNT(GROUP,h.school_Invalid=3);
    school_Total_ErrorCount := COUNT(GROUP,h.school_Invalid>0);
    location_LEFTTRIM_ErrorCount := COUNT(GROUP,h.location_Invalid=1);
    location_ALLOW_ErrorCount := COUNT(GROUP,h.location_Invalid=2);
    location_WORDS_ErrorCount := COUNT(GROUP,h.location_Invalid=3);
    location_Total_ErrorCount := COUNT(GROUP,h.location_Invalid>0);
    board_LEFTTRIM_ErrorCount := COUNT(GROUP,h.board_Invalid=1);
    board_ALLOW_ErrorCount := COUNT(GROUP,h.board_Invalid=2);
    board_WORDS_ErrorCount := COUNT(GROUP,h.board_Invalid=3);
    board_Total_ErrorCount := COUNT(GROUP,h.board_Invalid>0);
    offense_LEFTTRIM_ErrorCount := COUNT(GROUP,h.offense_Invalid=1);
    offense_ALLOW_ErrorCount := COUNT(GROUP,h.offense_Invalid=2);
    offense_WORDS_ErrorCount := COUNT(GROUP,h.offense_Invalid=3);
    offense_Total_ErrorCount := COUNT(GROUP,h.offense_Invalid>0);
    offense_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.offense_date_Invalid=1);
    offense_date_ALLOW_ErrorCount := COUNT(GROUP,h.offense_date_Invalid=2);
    offense_date_LENGTH_ErrorCount := COUNT(GROUP,h.offense_date_Invalid=3);
    offense_date_WORDS_ErrorCount := COUNT(GROUP,h.offense_date_Invalid=4);
    offense_date_Total_ErrorCount := COUNT(GROUP,h.offense_date_Invalid>0);
    action_LEFTTRIM_ErrorCount := COUNT(GROUP,h.action_Invalid=1);
    action_ALLOW_ErrorCount := COUNT(GROUP,h.action_Invalid=2);
    action_LENGTH_ErrorCount := COUNT(GROUP,h.action_Invalid=3);
    action_WORDS_ErrorCount := COUNT(GROUP,h.action_Invalid=4);
    action_Total_ErrorCount := COUNT(GROUP,h.action_Invalid>0);
    action_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.action_date_Invalid=1);
    action_date_ALLOW_ErrorCount := COUNT(GROUP,h.action_date_Invalid=2);
    action_date_LENGTH_ErrorCount := COUNT(GROUP,h.action_date_Invalid=3);
    action_date_WORDS_ErrorCount := COUNT(GROUP,h.action_date_Invalid=4);
    action_date_Total_ErrorCount := COUNT(GROUP,h.action_date_Invalid>0);
    action_start_LEFTTRIM_ErrorCount := COUNT(GROUP,h.action_start_Invalid=1);
    action_start_ALLOW_ErrorCount := COUNT(GROUP,h.action_start_Invalid=2);
    action_start_LENGTH_ErrorCount := COUNT(GROUP,h.action_start_Invalid=3);
    action_start_WORDS_ErrorCount := COUNT(GROUP,h.action_start_Invalid=4);
    action_start_Total_ErrorCount := COUNT(GROUP,h.action_start_Invalid>0);
    action_end_LEFTTRIM_ErrorCount := COUNT(GROUP,h.action_end_Invalid=1);
    action_end_ALLOW_ErrorCount := COUNT(GROUP,h.action_end_Invalid=2);
    action_end_LENGTH_ErrorCount := COUNT(GROUP,h.action_end_Invalid=3);
    action_end_WORDS_ErrorCount := COUNT(GROUP,h.action_end_Invalid=4);
    action_end_Total_ErrorCount := COUNT(GROUP,h.action_end_Invalid>0);
    npi_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.npi_number_Invalid=1);
    npi_number_ALLOW_ErrorCount := COUNT(GROUP,h.npi_number_Invalid=2);
    npi_number_LENGTH_ErrorCount := COUNT(GROUP,h.npi_number_Invalid=3);
    npi_number_WORDS_ErrorCount := COUNT(GROUP,h.npi_number_Invalid=4);
    npi_number_Total_ErrorCount := COUNT(GROUP,h.npi_number_Invalid>0);
    csr_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.csr_number_Invalid=1);
    csr_number_ALLOW_ErrorCount := COUNT(GROUP,h.csr_number_Invalid=2);
    csr_number_LENGTH_ErrorCount := COUNT(GROUP,h.csr_number_Invalid=3);
    csr_number_WORDS_ErrorCount := COUNT(GROUP,h.csr_number_Invalid=4);
    csr_number_Total_ErrorCount := COUNT(GROUP,h.csr_number_Invalid>0);
    dea_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dea_number_Invalid=1);
    dea_number_ALLOW_ErrorCount := COUNT(GROUP,h.dea_number_Invalid=2);
    dea_number_LENGTH_ErrorCount := COUNT(GROUP,h.dea_number_Invalid=3);
    dea_number_WORDS_ErrorCount := COUNT(GROUP,h.dea_number_Invalid=4);
    dea_number_Total_ErrorCount := COUNT(GROUP,h.dea_number_Invalid>0);
    prepped_addr1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid=1);
    prepped_addr1_ALLOW_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid=2);
    prepped_addr1_WORDS_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid=3);
    prepped_addr1_Total_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid>0);
    prepped_addr2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid=1);
    prepped_addr2_ALLOW_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid=2);
    prepped_addr2_WORDS_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid=3);
    prepped_addr2_Total_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid>0);
    clean_phone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=1);
    clean_phone_ALLOW_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=2);
    clean_phone_LENGTH_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=3);
    clean_phone_WORDS_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=4);
    clean_phone_Total_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid>0);
    clean_phone1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_phone1_Invalid=1);
    clean_phone1_ALLOW_ErrorCount := COUNT(GROUP,h.clean_phone1_Invalid=2);
    clean_phone1_LENGTH_ErrorCount := COUNT(GROUP,h.clean_phone1_Invalid=3);
    clean_phone1_WORDS_ErrorCount := COUNT(GROUP,h.clean_phone1_Invalid=4);
    clean_phone1_Total_ErrorCount := COUNT(GROUP,h.clean_phone1_Invalid>0);
    clean_phone2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_phone2_Invalid=1);
    clean_phone2_ALLOW_ErrorCount := COUNT(GROUP,h.clean_phone2_Invalid=2);
    clean_phone2_LENGTH_ErrorCount := COUNT(GROUP,h.clean_phone2_Invalid=3);
    clean_phone2_WORDS_ErrorCount := COUNT(GROUP,h.clean_phone2_Invalid=4);
    clean_phone2_Total_ErrorCount := COUNT(GROUP,h.clean_phone2_Invalid>0);
    clean_phone3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_phone3_Invalid=1);
    clean_phone3_ALLOW_ErrorCount := COUNT(GROUP,h.clean_phone3_Invalid=2);
    clean_phone3_LENGTH_ErrorCount := COUNT(GROUP,h.clean_phone3_Invalid=3);
    clean_phone3_WORDS_ErrorCount := COUNT(GROUP,h.clean_phone3_Invalid=4);
    clean_phone3_Total_ErrorCount := COUNT(GROUP,h.clean_phone3_Invalid>0);
    clean_fax1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_fax1_Invalid=1);
    clean_fax1_ALLOW_ErrorCount := COUNT(GROUP,h.clean_fax1_Invalid=2);
    clean_fax1_LENGTH_ErrorCount := COUNT(GROUP,h.clean_fax1_Invalid=3);
    clean_fax1_WORDS_ErrorCount := COUNT(GROUP,h.clean_fax1_Invalid=4);
    clean_fax1_Total_ErrorCount := COUNT(GROUP,h.clean_fax1_Invalid>0);
    clean_fax2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_fax2_Invalid=1);
    clean_fax2_ALLOW_ErrorCount := COUNT(GROUP,h.clean_fax2_Invalid=2);
    clean_fax2_LENGTH_ErrorCount := COUNT(GROUP,h.clean_fax2_Invalid=3);
    clean_fax2_WORDS_ErrorCount := COUNT(GROUP,h.clean_fax2_Invalid=4);
    clean_fax2_Total_ErrorCount := COUNT(GROUP,h.clean_fax2_Invalid>0);
    clean_fax3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_fax3_Invalid=1);
    clean_fax3_ALLOW_ErrorCount := COUNT(GROUP,h.clean_fax3_Invalid=2);
    clean_fax3_LENGTH_ErrorCount := COUNT(GROUP,h.clean_fax3_Invalid=3);
    clean_fax3_WORDS_ErrorCount := COUNT(GROUP,h.clean_fax3_Invalid=4);
    clean_fax3_Total_ErrorCount := COUNT(GROUP,h.clean_fax3_Invalid>0);
    clean_other_phone1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_other_phone1_Invalid=1);
    clean_other_phone1_ALLOW_ErrorCount := COUNT(GROUP,h.clean_other_phone1_Invalid=2);
    clean_other_phone1_LENGTH_ErrorCount := COUNT(GROUP,h.clean_other_phone1_Invalid=3);
    clean_other_phone1_WORDS_ErrorCount := COUNT(GROUP,h.clean_other_phone1_Invalid=4);
    clean_other_phone1_Total_ErrorCount := COUNT(GROUP,h.clean_other_phone1_Invalid>0);
    clean_dateofbirth_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_dateofbirth_Invalid=1);
    clean_dateofbirth_ALLOW_ErrorCount := COUNT(GROUP,h.clean_dateofbirth_Invalid=2);
    clean_dateofbirth_LENGTH_ErrorCount := COUNT(GROUP,h.clean_dateofbirth_Invalid=3);
    clean_dateofbirth_WORDS_ErrorCount := COUNT(GROUP,h.clean_dateofbirth_Invalid=4);
    clean_dateofbirth_Total_ErrorCount := COUNT(GROUP,h.clean_dateofbirth_Invalid>0);
    clean_dateofdeath_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_dateofdeath_Invalid=1);
    clean_dateofdeath_ALLOW_ErrorCount := COUNT(GROUP,h.clean_dateofdeath_Invalid=2);
    clean_dateofdeath_LENGTH_ErrorCount := COUNT(GROUP,h.clean_dateofdeath_Invalid=3);
    clean_dateofdeath_WORDS_ErrorCount := COUNT(GROUP,h.clean_dateofdeath_Invalid=4);
    clean_dateofdeath_Total_ErrorCount := COUNT(GROUP,h.clean_dateofdeath_Invalid>0);
    clean_company_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_company_name_Invalid=1);
    clean_company_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_company_name_Invalid=2);
    clean_company_name_LENGTH_ErrorCount := COUNT(GROUP,h.clean_company_name_Invalid=3);
    clean_company_name_WORDS_ErrorCount := COUNT(GROUP,h.clean_company_name_Invalid=4);
    clean_company_name_Total_ErrorCount := COUNT(GROUP,h.clean_company_name_Invalid>0);
    clean_issue_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_issue_date_Invalid=1);
    clean_issue_date_ALLOW_ErrorCount := COUNT(GROUP,h.clean_issue_date_Invalid=2);
    clean_issue_date_LENGTH_ErrorCount := COUNT(GROUP,h.clean_issue_date_Invalid=3);
    clean_issue_date_WORDS_ErrorCount := COUNT(GROUP,h.clean_issue_date_Invalid=4);
    clean_issue_date_Total_ErrorCount := COUNT(GROUP,h.clean_issue_date_Invalid>0);
    clean_expiration_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_expiration_date_Invalid=1);
    clean_expiration_date_ALLOW_ErrorCount := COUNT(GROUP,h.clean_expiration_date_Invalid=2);
    clean_expiration_date_LENGTH_ErrorCount := COUNT(GROUP,h.clean_expiration_date_Invalid=3);
    clean_expiration_date_WORDS_ErrorCount := COUNT(GROUP,h.clean_expiration_date_Invalid=4);
    clean_expiration_date_Total_ErrorCount := COUNT(GROUP,h.clean_expiration_date_Invalid>0);
    clean_offense_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_offense_date_Invalid=1);
    clean_offense_date_ALLOW_ErrorCount := COUNT(GROUP,h.clean_offense_date_Invalid=2);
    clean_offense_date_LENGTH_ErrorCount := COUNT(GROUP,h.clean_offense_date_Invalid=3);
    clean_offense_date_WORDS_ErrorCount := COUNT(GROUP,h.clean_offense_date_Invalid=4);
    clean_offense_date_Total_ErrorCount := COUNT(GROUP,h.clean_offense_date_Invalid>0);
    clean_action_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_action_date_Invalid=1);
    clean_action_date_ALLOW_ErrorCount := COUNT(GROUP,h.clean_action_date_Invalid=2);
    clean_action_date_LENGTH_ErrorCount := COUNT(GROUP,h.clean_action_date_Invalid=3);
    clean_action_date_WORDS_ErrorCount := COUNT(GROUP,h.clean_action_date_Invalid=4);
    clean_action_date_Total_ErrorCount := COUNT(GROUP,h.clean_action_date_Invalid>0);
    src_LEFTTRIM_ErrorCount := COUNT(GROUP,h.src_Invalid=1);
    src_ALLOW_ErrorCount := COUNT(GROUP,h.src_Invalid=2);
    src_LENGTH_ErrorCount := COUNT(GROUP,h.src_Invalid=3);
    src_WORDS_ErrorCount := COUNT(GROUP,h.src_Invalid=4);
    src_Total_ErrorCount := COUNT(GROUP,h.src_Invalid>0);
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
    lnpid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lnpid_Invalid=1);
    lnpid_ALLOW_ErrorCount := COUNT(GROUP,h.lnpid_Invalid=2);
    lnpid_LENGTH_ErrorCount := COUNT(GROUP,h.lnpid_Invalid=3);
    lnpid_WORDS_ErrorCount := COUNT(GROUP,h.lnpid_Invalid=4);
    lnpid_Total_ErrorCount := COUNT(GROUP,h.lnpid_Invalid>0);
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
    in_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.in_state_Invalid=1);
    in_state_ALLOW_ErrorCount := COUNT(GROUP,h.in_state_Invalid=2);
    in_state_WORDS_ErrorCount := COUNT(GROUP,h.in_state_Invalid=3);
    in_state_Total_ErrorCount := COUNT(GROUP,h.in_state_Invalid>0);
    in_class_LEFTTRIM_ErrorCount := COUNT(GROUP,h.in_class_Invalid=1);
    in_class_ALLOW_ErrorCount := COUNT(GROUP,h.in_class_Invalid=2);
    in_class_WORDS_ErrorCount := COUNT(GROUP,h.in_class_Invalid=3);
    in_class_Total_ErrorCount := COUNT(GROUP,h.in_class_Invalid>0);
    in_status_LEFTTRIM_ErrorCount := COUNT(GROUP,h.in_status_Invalid=1);
    in_status_ALLOW_ErrorCount := COUNT(GROUP,h.in_status_Invalid=2);
    in_status_WORDS_ErrorCount := COUNT(GROUP,h.in_status_Invalid=3);
    in_status_Total_ErrorCount := COUNT(GROUP,h.in_status_Invalid>0);
    in_qualifier1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.in_qualifier1_Invalid=1);
    in_qualifier1_ALLOW_ErrorCount := COUNT(GROUP,h.in_qualifier1_Invalid=2);
    in_qualifier1_WORDS_ErrorCount := COUNT(GROUP,h.in_qualifier1_Invalid=3);
    in_qualifier1_Total_ErrorCount := COUNT(GROUP,h.in_qualifier1_Invalid>0);
    in_qualifier2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.in_qualifier2_Invalid=1);
    in_qualifier2_ALLOW_ErrorCount := COUNT(GROUP,h.in_qualifier2_Invalid=2);
    in_qualifier2_WORDS_ErrorCount := COUNT(GROUP,h.in_qualifier2_Invalid=3);
    in_qualifier2_Total_ErrorCount := COUNT(GROUP,h.in_qualifier2_Invalid>0);
    mapped_class_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mapped_class_Invalid=1);
    mapped_class_ALLOW_ErrorCount := COUNT(GROUP,h.mapped_class_Invalid=2);
    mapped_class_WORDS_ErrorCount := COUNT(GROUP,h.mapped_class_Invalid=3);
    mapped_class_Total_ErrorCount := COUNT(GROUP,h.mapped_class_Invalid>0);
    mapped_status_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mapped_status_Invalid=1);
    mapped_status_ALLOW_ErrorCount := COUNT(GROUP,h.mapped_status_Invalid=2);
    mapped_status_WORDS_ErrorCount := COUNT(GROUP,h.mapped_status_Invalid=3);
    mapped_status_Total_ErrorCount := COUNT(GROUP,h.mapped_status_Invalid>0);
    mapped_qualifier1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mapped_qualifier1_Invalid=1);
    mapped_qualifier1_ALLOW_ErrorCount := COUNT(GROUP,h.mapped_qualifier1_Invalid=2);
    mapped_qualifier1_WORDS_ErrorCount := COUNT(GROUP,h.mapped_qualifier1_Invalid=3);
    mapped_qualifier1_Total_ErrorCount := COUNT(GROUP,h.mapped_qualifier1_Invalid>0);
    mapped_qualifier2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mapped_qualifier2_Invalid=1);
    mapped_qualifier2_ALLOW_ErrorCount := COUNT(GROUP,h.mapped_qualifier2_Invalid=2);
    mapped_qualifier2_WORDS_ErrorCount := COUNT(GROUP,h.mapped_qualifier2_Invalid=3);
    mapped_qualifier2_Total_ErrorCount := COUNT(GROUP,h.mapped_qualifier2_Invalid>0);
    mapped_pdma_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mapped_pdma_Invalid=1);
    mapped_pdma_ALLOW_ErrorCount := COUNT(GROUP,h.mapped_pdma_Invalid=2);
    mapped_pdma_WORDS_ErrorCount := COUNT(GROUP,h.mapped_pdma_Invalid=3);
    mapped_pdma_Total_ErrorCount := COUNT(GROUP,h.mapped_pdma_Invalid>0);
    mapped_pract_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mapped_pract_type_Invalid=1);
    mapped_pract_type_ALLOW_ErrorCount := COUNT(GROUP,h.mapped_pract_type_Invalid=2);
    mapped_pract_type_WORDS_ErrorCount := COUNT(GROUP,h.mapped_pract_type_Invalid=3);
    mapped_pract_type_Total_ErrorCount := COUNT(GROUP,h.mapped_pract_type_Invalid>0);
    source_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.source_code_Invalid=1);
    source_code_ALLOW_ErrorCount := COUNT(GROUP,h.source_code_Invalid=2);
    source_code_WORDS_ErrorCount := COUNT(GROUP,h.source_code_Invalid=3);
    source_code_Total_ErrorCount := COUNT(GROUP,h.source_code_Invalid>0);
    taxonomy_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.taxonomy_code_Invalid=1);
    taxonomy_code_ALLOW_ErrorCount := COUNT(GROUP,h.taxonomy_code_Invalid=2);
    taxonomy_code_WORDS_ErrorCount := COUNT(GROUP,h.taxonomy_code_Invalid=3);
    taxonomy_code_Total_ErrorCount := COUNT(GROUP,h.taxonomy_code_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ln_key_Invalid,le.hms_src_Invalid,le.key_Invalid,le.id_Invalid,le.entityid_Invalid,le.license_number_Invalid,le.license_class_type_Invalid,le.license_state_Invalid,le.status_Invalid,le.issue_date_Invalid,le.expiration_date_Invalid,le.qualifier1_Invalid,le.qualifier2_Invalid,le.qualifier3_Invalid,le.qualifier4_Invalid,le.qualifier5_Invalid,le.rawclass_Invalid,le.rawissue_date_Invalid,le.rawexpiration_date_Invalid,le.rawstatus_Invalid,le.raw_number_Invalid,le.name_Invalid,le.first_Invalid,le.middle_Invalid,le.last_Invalid,le.suffix_Invalid,le.cred_Invalid,le.age_Invalid,le.dateofbirth_Invalid,le.email_Invalid,le.gender_Invalid,le.dateofdeath_Invalid,le.firmname_Invalid,le.street1_Invalid,le.street2_Invalid,le.street3_Invalid,le.city_Invalid,le.address_state_Invalid,le.orig_zip_Invalid,le.orig_county_Invalid,le.country_Invalid,le.address_type_Invalid,le.phone1_Invalid,le.phone2_Invalid,le.phone3_Invalid,le.fax1_Invalid,le.fax2_Invalid,le.fax3_Invalid,le.other_phone1_Invalid,le.description_Invalid,le.specialty_class_type_Invalid,le.phone_number_Invalid,le.phone_type_Invalid,le.language_Invalid,le.graduated_Invalid,le.school_Invalid,le.location_Invalid,le.board_Invalid,le.offense_Invalid,le.offense_date_Invalid,le.action_Invalid,le.action_date_Invalid,le.action_start_Invalid,le.action_end_Invalid,le.npi_number_Invalid,le.csr_number_Invalid,le.dea_number_Invalid,le.prepped_addr1_Invalid,le.prepped_addr2_Invalid,le.clean_phone_Invalid,le.clean_phone1_Invalid,le.clean_phone2_Invalid,le.clean_phone3_Invalid,le.clean_fax1_Invalid,le.clean_fax2_Invalid,le.clean_fax3_Invalid,le.clean_other_phone1_Invalid,le.clean_dateofbirth_Invalid,le.clean_dateofdeath_Invalid,le.clean_company_name_Invalid,le.clean_issue_date_Invalid,le.clean_expiration_date_Invalid,le.clean_offense_date_Invalid,le.clean_action_date_Invalid,le.src_Invalid,le.zip_Invalid,le.zip4_Invalid,le.bdid_Invalid,le.bdid_score_Invalid,le.lnpid_Invalid,le.did_Invalid,le.did_score_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.in_state_Invalid,le.in_class_Invalid,le.in_status_Invalid,le.in_qualifier1_Invalid,le.in_qualifier2_Invalid,le.mapped_class_Invalid,le.mapped_status_Invalid,le.mapped_qualifier1_Invalid,le.mapped_qualifier2_Invalid,le.mapped_pdma_Invalid,le.mapped_pract_type_Invalid,le.source_code_Invalid,le.taxonomy_code_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,HmsStlic_Fields.InvalidMessage_ln_key(le.ln_key_Invalid),HmsStlic_Fields.InvalidMessage_hms_src(le.hms_src_Invalid),HmsStlic_Fields.InvalidMessage_key(le.key_Invalid),HmsStlic_Fields.InvalidMessage_id(le.id_Invalid),HmsStlic_Fields.InvalidMessage_entityid(le.entityid_Invalid),HmsStlic_Fields.InvalidMessage_license_number(le.license_number_Invalid),HmsStlic_Fields.InvalidMessage_license_class_type(le.license_class_type_Invalid),HmsStlic_Fields.InvalidMessage_license_state(le.license_state_Invalid),HmsStlic_Fields.InvalidMessage_status(le.status_Invalid),HmsStlic_Fields.InvalidMessage_issue_date(le.issue_date_Invalid),HmsStlic_Fields.InvalidMessage_expiration_date(le.expiration_date_Invalid),HmsStlic_Fields.InvalidMessage_qualifier1(le.qualifier1_Invalid),HmsStlic_Fields.InvalidMessage_qualifier2(le.qualifier2_Invalid),HmsStlic_Fields.InvalidMessage_qualifier3(le.qualifier3_Invalid),HmsStlic_Fields.InvalidMessage_qualifier4(le.qualifier4_Invalid),HmsStlic_Fields.InvalidMessage_qualifier5(le.qualifier5_Invalid),HmsStlic_Fields.InvalidMessage_rawclass(le.rawclass_Invalid),HmsStlic_Fields.InvalidMessage_rawissue_date(le.rawissue_date_Invalid),HmsStlic_Fields.InvalidMessage_rawexpiration_date(le.rawexpiration_date_Invalid),HmsStlic_Fields.InvalidMessage_rawstatus(le.rawstatus_Invalid),HmsStlic_Fields.InvalidMessage_raw_number(le.raw_number_Invalid),HmsStlic_Fields.InvalidMessage_name(le.name_Invalid),HmsStlic_Fields.InvalidMessage_first(le.first_Invalid),HmsStlic_Fields.InvalidMessage_middle(le.middle_Invalid),HmsStlic_Fields.InvalidMessage_last(le.last_Invalid),HmsStlic_Fields.InvalidMessage_suffix(le.suffix_Invalid),HmsStlic_Fields.InvalidMessage_cred(le.cred_Invalid),HmsStlic_Fields.InvalidMessage_age(le.age_Invalid),HmsStlic_Fields.InvalidMessage_dateofbirth(le.dateofbirth_Invalid),HmsStlic_Fields.InvalidMessage_email(le.email_Invalid),HmsStlic_Fields.InvalidMessage_gender(le.gender_Invalid),HmsStlic_Fields.InvalidMessage_dateofdeath(le.dateofdeath_Invalid),HmsStlic_Fields.InvalidMessage_firmname(le.firmname_Invalid),HmsStlic_Fields.InvalidMessage_street1(le.street1_Invalid),HmsStlic_Fields.InvalidMessage_street2(le.street2_Invalid),HmsStlic_Fields.InvalidMessage_street3(le.street3_Invalid),HmsStlic_Fields.InvalidMessage_city(le.city_Invalid),HmsStlic_Fields.InvalidMessage_address_state(le.address_state_Invalid),HmsStlic_Fields.InvalidMessage_orig_zip(le.orig_zip_Invalid),HmsStlic_Fields.InvalidMessage_orig_county(le.orig_county_Invalid),HmsStlic_Fields.InvalidMessage_country(le.country_Invalid),HmsStlic_Fields.InvalidMessage_address_type(le.address_type_Invalid),HmsStlic_Fields.InvalidMessage_phone1(le.phone1_Invalid),HmsStlic_Fields.InvalidMessage_phone2(le.phone2_Invalid),HmsStlic_Fields.InvalidMessage_phone3(le.phone3_Invalid),HmsStlic_Fields.InvalidMessage_fax1(le.fax1_Invalid),HmsStlic_Fields.InvalidMessage_fax2(le.fax2_Invalid),HmsStlic_Fields.InvalidMessage_fax3(le.fax3_Invalid),HmsStlic_Fields.InvalidMessage_other_phone1(le.other_phone1_Invalid),HmsStlic_Fields.InvalidMessage_description(le.description_Invalid),HmsStlic_Fields.InvalidMessage_specialty_class_type(le.specialty_class_type_Invalid),HmsStlic_Fields.InvalidMessage_phone_number(le.phone_number_Invalid),HmsStlic_Fields.InvalidMessage_phone_type(le.phone_type_Invalid),HmsStlic_Fields.InvalidMessage_language(le.language_Invalid),HmsStlic_Fields.InvalidMessage_graduated(le.graduated_Invalid),HmsStlic_Fields.InvalidMessage_school(le.school_Invalid),HmsStlic_Fields.InvalidMessage_location(le.location_Invalid),HmsStlic_Fields.InvalidMessage_board(le.board_Invalid),HmsStlic_Fields.InvalidMessage_offense(le.offense_Invalid),HmsStlic_Fields.InvalidMessage_offense_date(le.offense_date_Invalid),HmsStlic_Fields.InvalidMessage_action(le.action_Invalid),HmsStlic_Fields.InvalidMessage_action_date(le.action_date_Invalid),HmsStlic_Fields.InvalidMessage_action_start(le.action_start_Invalid),HmsStlic_Fields.InvalidMessage_action_end(le.action_end_Invalid),HmsStlic_Fields.InvalidMessage_npi_number(le.npi_number_Invalid),HmsStlic_Fields.InvalidMessage_csr_number(le.csr_number_Invalid),HmsStlic_Fields.InvalidMessage_dea_number(le.dea_number_Invalid),HmsStlic_Fields.InvalidMessage_prepped_addr1(le.prepped_addr1_Invalid),HmsStlic_Fields.InvalidMessage_prepped_addr2(le.prepped_addr2_Invalid),HmsStlic_Fields.InvalidMessage_clean_phone(le.clean_phone_Invalid),HmsStlic_Fields.InvalidMessage_clean_phone1(le.clean_phone1_Invalid),HmsStlic_Fields.InvalidMessage_clean_phone2(le.clean_phone2_Invalid),HmsStlic_Fields.InvalidMessage_clean_phone3(le.clean_phone3_Invalid),HmsStlic_Fields.InvalidMessage_clean_fax1(le.clean_fax1_Invalid),HmsStlic_Fields.InvalidMessage_clean_fax2(le.clean_fax2_Invalid),HmsStlic_Fields.InvalidMessage_clean_fax3(le.clean_fax3_Invalid),HmsStlic_Fields.InvalidMessage_clean_other_phone1(le.clean_other_phone1_Invalid),HmsStlic_Fields.InvalidMessage_clean_dateofbirth(le.clean_dateofbirth_Invalid),HmsStlic_Fields.InvalidMessage_clean_dateofdeath(le.clean_dateofdeath_Invalid),HmsStlic_Fields.InvalidMessage_clean_company_name(le.clean_company_name_Invalid),HmsStlic_Fields.InvalidMessage_clean_issue_date(le.clean_issue_date_Invalid),HmsStlic_Fields.InvalidMessage_clean_expiration_date(le.clean_expiration_date_Invalid),HmsStlic_Fields.InvalidMessage_clean_offense_date(le.clean_offense_date_Invalid),HmsStlic_Fields.InvalidMessage_clean_action_date(le.clean_action_date_Invalid),HmsStlic_Fields.InvalidMessage_src(le.src_Invalid),HmsStlic_Fields.InvalidMessage_zip(le.zip_Invalid),HmsStlic_Fields.InvalidMessage_zip4(le.zip4_Invalid),HmsStlic_Fields.InvalidMessage_bdid(le.bdid_Invalid),HmsStlic_Fields.InvalidMessage_bdid_score(le.bdid_score_Invalid),HmsStlic_Fields.InvalidMessage_lnpid(le.lnpid_Invalid),HmsStlic_Fields.InvalidMessage_did(le.did_Invalid),HmsStlic_Fields.InvalidMessage_did_score(le.did_score_Invalid),HmsStlic_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),HmsStlic_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),HmsStlic_Fields.InvalidMessage_in_state(le.in_state_Invalid),HmsStlic_Fields.InvalidMessage_in_class(le.in_class_Invalid),HmsStlic_Fields.InvalidMessage_in_status(le.in_status_Invalid),HmsStlic_Fields.InvalidMessage_in_qualifier1(le.in_qualifier1_Invalid),HmsStlic_Fields.InvalidMessage_in_qualifier2(le.in_qualifier2_Invalid),HmsStlic_Fields.InvalidMessage_mapped_class(le.mapped_class_Invalid),HmsStlic_Fields.InvalidMessage_mapped_status(le.mapped_status_Invalid),HmsStlic_Fields.InvalidMessage_mapped_qualifier1(le.mapped_qualifier1_Invalid),HmsStlic_Fields.InvalidMessage_mapped_qualifier2(le.mapped_qualifier2_Invalid),HmsStlic_Fields.InvalidMessage_mapped_pdma(le.mapped_pdma_Invalid),HmsStlic_Fields.InvalidMessage_mapped_pract_type(le.mapped_pract_type_Invalid),HmsStlic_Fields.InvalidMessage_source_code(le.source_code_Invalid),HmsStlic_Fields.InvalidMessage_taxonomy_code(le.taxonomy_code_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ln_key_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.hms_src_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.key_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.id_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.entityid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.license_number_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.license_class_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.license_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.status_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.issue_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.expiration_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.qualifier1_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.qualifier2_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.qualifier3_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.qualifier4_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.qualifier5_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.rawclass_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.rawissue_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.rawexpiration_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.rawstatus_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.raw_number_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.name_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.first_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.middle_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.last_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.cred_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.age_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dateofbirth_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.email_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dateofdeath_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.firmname_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.street1_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.street2_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.street3_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.address_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_county_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.country_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.address_type_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.phone1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phone2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phone3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.fax1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.fax2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.fax3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_phone1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.description_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.specialty_class_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phone_number_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phone_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.language_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.graduated_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.school_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.location_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.board_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.offense_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.offense_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.action_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.action_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.action_start_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.action_end_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.npi_number_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.csr_number_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dea_number_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.prepped_addr1_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.prepped_addr2_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_phone_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_phone1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_phone2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_phone3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_fax1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_fax2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_fax3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_other_phone1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_dateofbirth_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_dateofdeath_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_company_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_issue_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_expiration_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_offense_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_action_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.src_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.bdid_score_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lnpid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.in_state_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.in_class_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.in_status_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.in_qualifier1_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.in_qualifier2_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.mapped_class_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.mapped_status_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.mapped_qualifier1_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.mapped_qualifier2_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.mapped_pdma_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.mapped_pract_type_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.source_code_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.taxonomy_code_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ln_key','hms_src','key','id','entityid','license_number','license_class_type','license_state','status','issue_date','expiration_date','qualifier1','qualifier2','qualifier3','qualifier4','qualifier5','rawclass','rawissue_date','rawexpiration_date','rawstatus','raw_number','name','first','middle','last','suffix','cred','age','dateofbirth','email','gender','dateofdeath','firmname','street1','street2','street3','city','address_state','orig_zip','orig_county','country','address_type','phone1','phone2','phone3','fax1','fax2','fax3','other_phone1','description','specialty_class_type','phone_number','phone_type','language','graduated','school','location','board','offense','offense_date','action','action_date','action_start','action_end','npi_number','csr_number','dea_number','prepped_addr1','prepped_addr2','clean_phone','clean_phone1','clean_phone2','clean_phone3','clean_fax1','clean_fax2','clean_fax3','clean_other_phone1','clean_dateofbirth','clean_dateofdeath','clean_company_name','clean_issue_date','clean_expiration_date','clean_offense_date','clean_action_date','src','zip','zip4','bdid','bdid_score','lnpid','did','did_score','dt_vendor_first_reported','dt_vendor_last_reported','in_state','in_class','in_status','in_qualifier1','in_qualifier2','mapped_class','mapped_status','mapped_qualifier1','mapped_qualifier2','mapped_pdma','mapped_pract_type','source_code','taxonomy_code','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'ln_key','hms_src','key','id','entityid','license_number','license_class_type','license_state','status','issue_date','expiration_date','qualifier1','qualifier2','qualifier3','qualifier4','qualifier5','rawclass','rawissue_date','rawexpiration_date','rawstatus','raw_number','name','first','middle','last','suffix','cred','age','dateofbirth','email','gender','dateofdeath','firmname','street1','street2','street3','city','address_state','orig_zip','orig_county','country','address_type','phone1','phone2','phone3','fax1','fax2','fax3','other_phone1','description','specialty_class_type','phone_number','phone_type','language','graduated','school','location','board','offense','offense_date','action','action_date','action_start','action_end','npi_number','csr_number','dea_number','prepped_addr1','prepped_addr2','clean_phone','clean_phone1','clean_phone2','clean_phone3','clean_fax1','clean_fax2','clean_fax3','clean_other_phone1','clean_dateofbirth','clean_dateofdeath','clean_company_name','clean_issue_date','clean_expiration_date','clean_offense_date','clean_action_date','src','zip','zip4','bdid','bdid_score','lnpid','did','did_score','dt_vendor_first_reported','dt_vendor_last_reported','in_state','in_class','in_status','in_qualifier1','in_qualifier2','mapped_class','mapped_status','mapped_qualifier1','mapped_qualifier2','mapped_pdma','mapped_pract_type','source_code','taxonomy_code','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.ln_key,(SALT31.StrType)le.hms_src,(SALT31.StrType)le.key,(SALT31.StrType)le.id,(SALT31.StrType)le.entityid,(SALT31.StrType)le.license_number,(SALT31.StrType)le.license_class_type,(SALT31.StrType)le.license_state,(SALT31.StrType)le.status,(SALT31.StrType)le.issue_date,(SALT31.StrType)le.expiration_date,(SALT31.StrType)le.qualifier1,(SALT31.StrType)le.qualifier2,(SALT31.StrType)le.qualifier3,(SALT31.StrType)le.qualifier4,(SALT31.StrType)le.qualifier5,(SALT31.StrType)le.rawclass,(SALT31.StrType)le.rawissue_date,(SALT31.StrType)le.rawexpiration_date,(SALT31.StrType)le.rawstatus,(SALT31.StrType)le.raw_number,(SALT31.StrType)le.name,(SALT31.StrType)le.first,(SALT31.StrType)le.middle,(SALT31.StrType)le.last,(SALT31.StrType)le.suffix,(SALT31.StrType)le.cred,(SALT31.StrType)le.age,(SALT31.StrType)le.dateofbirth,(SALT31.StrType)le.email,(SALT31.StrType)le.gender,(SALT31.StrType)le.dateofdeath,(SALT31.StrType)le.firmname,(SALT31.StrType)le.street1,(SALT31.StrType)le.street2,(SALT31.StrType)le.street3,(SALT31.StrType)le.city,(SALT31.StrType)le.address_state,(SALT31.StrType)le.orig_zip,(SALT31.StrType)le.orig_county,(SALT31.StrType)le.country,(SALT31.StrType)le.address_type,(SALT31.StrType)le.phone1,(SALT31.StrType)le.phone2,(SALT31.StrType)le.phone3,(SALT31.StrType)le.fax1,(SALT31.StrType)le.fax2,(SALT31.StrType)le.fax3,(SALT31.StrType)le.other_phone1,(SALT31.StrType)le.description,(SALT31.StrType)le.specialty_class_type,(SALT31.StrType)le.phone_number,(SALT31.StrType)le.phone_type,(SALT31.StrType)le.language,(SALT31.StrType)le.graduated,(SALT31.StrType)le.school,(SALT31.StrType)le.location,(SALT31.StrType)le.board,(SALT31.StrType)le.offense,(SALT31.StrType)le.offense_date,(SALT31.StrType)le.action,(SALT31.StrType)le.action_date,(SALT31.StrType)le.action_start,(SALT31.StrType)le.action_end,(SALT31.StrType)le.npi_number,(SALT31.StrType)le.csr_number,(SALT31.StrType)le.dea_number,(SALT31.StrType)le.prepped_addr1,(SALT31.StrType)le.prepped_addr2,(SALT31.StrType)le.clean_phone,(SALT31.StrType)le.clean_phone1,(SALT31.StrType)le.clean_phone2,(SALT31.StrType)le.clean_phone3,(SALT31.StrType)le.clean_fax1,(SALT31.StrType)le.clean_fax2,(SALT31.StrType)le.clean_fax3,(SALT31.StrType)le.clean_other_phone1,(SALT31.StrType)le.clean_dateofbirth,(SALT31.StrType)le.clean_dateofdeath,(SALT31.StrType)le.clean_company_name,(SALT31.StrType)le.clean_issue_date,(SALT31.StrType)le.clean_expiration_date,(SALT31.StrType)le.clean_offense_date,(SALT31.StrType)le.clean_action_date,(SALT31.StrType)le.src,(SALT31.StrType)le.zip,(SALT31.StrType)le.zip4,(SALT31.StrType)le.bdid,(SALT31.StrType)le.bdid_score,(SALT31.StrType)le.lnpid,(SALT31.StrType)le.did,(SALT31.StrType)le.did_score,(SALT31.StrType)le.dt_vendor_first_reported,(SALT31.StrType)le.dt_vendor_last_reported,(SALT31.StrType)le.in_state,(SALT31.StrType)le.in_class,(SALT31.StrType)le.in_status,(SALT31.StrType)le.in_qualifier1,(SALT31.StrType)le.in_qualifier2,(SALT31.StrType)le.mapped_class,(SALT31.StrType)le.mapped_status,(SALT31.StrType)le.mapped_qualifier1,(SALT31.StrType)le.mapped_qualifier2,(SALT31.StrType)le.mapped_pdma,(SALT31.StrType)le.mapped_pract_type,(SALT31.StrType)le.source_code,(SALT31.StrType)le.taxonomy_code,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,107,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT31.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ln_key:ln_key:LEFTTRIM','ln_key:ln_key:ALLOW','ln_key:ln_key:LENGTH','ln_key:ln_key:WORDS'
          ,'hms_src:hms_src:LEFTTRIM','hms_src:hms_src:ALLOW','hms_src:hms_src:LENGTH','hms_src:hms_src:WORDS'
          ,'key:key:LEFTTRIM','key:key:ALLOW','key:key:LENGTH','key:key:WORDS'
          ,'id:id:LEFTTRIM','id:id:ALLOW','id:id:LENGTH','id:id:WORDS'
          ,'entityid:entityid:LEFTTRIM','entityid:entityid:ALLOW','entityid:entityid:LENGTH','entityid:entityid:WORDS'
          ,'license_number:license_number:LEFTTRIM','license_number:license_number:ALLOW','license_number:license_number:LENGTH','license_number:license_number:WORDS'
          ,'license_class_type:license_class_type:LEFTTRIM','license_class_type:license_class_type:ALLOW','license_class_type:license_class_type:LENGTH','license_class_type:license_class_type:WORDS'
          ,'license_state:license_state:LEFTTRIM','license_state:license_state:ALLOW','license_state:license_state:LENGTH','license_state:license_state:WORDS'
          ,'status:status:LEFTTRIM','status:status:ALLOW','status:status:LENGTH','status:status:WORDS'
          ,'issue_date:issue_date:LEFTTRIM','issue_date:issue_date:ALLOW','issue_date:issue_date:LENGTH','issue_date:issue_date:WORDS'
          ,'expiration_date:expiration_date:LEFTTRIM','expiration_date:expiration_date:ALLOW','expiration_date:expiration_date:LENGTH','expiration_date:expiration_date:WORDS'
          ,'qualifier1:qualifier1:LEFTTRIM','qualifier1:qualifier1:ALLOW','qualifier1:qualifier1:WORDS'
          ,'qualifier2:qualifier2:LEFTTRIM','qualifier2:qualifier2:ALLOW','qualifier2:qualifier2:WORDS'
          ,'qualifier3:qualifier3:LEFTTRIM','qualifier3:qualifier3:ALLOW','qualifier3:qualifier3:WORDS'
          ,'qualifier4:qualifier4:LEFTTRIM','qualifier4:qualifier4:ALLOW','qualifier4:qualifier4:WORDS'
          ,'qualifier5:qualifier5:LEFTTRIM','qualifier5:qualifier5:ALLOW','qualifier5:qualifier5:WORDS'
          ,'rawclass:rawclass:LEFTTRIM','rawclass:rawclass:ALLOW','rawclass:rawclass:LENGTH','rawclass:rawclass:WORDS'
          ,'rawissue_date:rawissue_date:LEFTTRIM','rawissue_date:rawissue_date:ALLOW','rawissue_date:rawissue_date:LENGTH','rawissue_date:rawissue_date:WORDS'
          ,'rawexpiration_date:rawexpiration_date:LEFTTRIM','rawexpiration_date:rawexpiration_date:ALLOW','rawexpiration_date:rawexpiration_date:LENGTH','rawexpiration_date:rawexpiration_date:WORDS'
          ,'rawstatus:rawstatus:LEFTTRIM','rawstatus:rawstatus:ALLOW','rawstatus:rawstatus:LENGTH','rawstatus:rawstatus:WORDS'
          ,'raw_number:raw_number:LEFTTRIM','raw_number:raw_number:ALLOW','raw_number:raw_number:LENGTH','raw_number:raw_number:WORDS'
          ,'name:name:LEFTTRIM','name:name:ALLOW','name:name:WORDS'
          ,'first:first:LEFTTRIM','first:first:ALLOW','first:first:WORDS'
          ,'middle:middle:LEFTTRIM','middle:middle:ALLOW','middle:middle:WORDS'
          ,'last:last:LEFTTRIM','last:last:ALLOW','last:last:WORDS'
          ,'suffix:suffix:LEFTTRIM','suffix:suffix:ALLOW','suffix:suffix:WORDS'
          ,'cred:cred:LEFTTRIM','cred:cred:ALLOW','cred:cred:WORDS'
          ,'age:age:LEFTTRIM','age:age:ALLOW','age:age:LENGTH','age:age:WORDS'
          ,'dateofbirth:dateofbirth:LEFTTRIM','dateofbirth:dateofbirth:ALLOW','dateofbirth:dateofbirth:LENGTH','dateofbirth:dateofbirth:WORDS'
          ,'email:email:LEFTTRIM','email:email:ALLOW','email:email:LENGTH','email:email:WORDS'
          ,'gender:gender:LEFTTRIM','gender:gender:ALLOW','gender:gender:LENGTH','gender:gender:WORDS'
          ,'dateofdeath:dateofdeath:LEFTTRIM','dateofdeath:dateofdeath:ALLOW','dateofdeath:dateofdeath:LENGTH','dateofdeath:dateofdeath:WORDS'
          ,'firmname:firmname:LEFTTRIM','firmname:firmname:ALLOW','firmname:firmname:WORDS'
          ,'street1:street1:LEFTTRIM','street1:street1:ALLOW','street1:street1:WORDS'
          ,'street2:street2:LEFTTRIM','street2:street2:ALLOW','street2:street2:WORDS'
          ,'street3:street3:LEFTTRIM','street3:street3:ALLOW','street3:street3:WORDS'
          ,'city:city:LEFTTRIM','city:city:ALLOW','city:city:WORDS'
          ,'address_state:address_state:LEFTTRIM','address_state:address_state:ALLOW','address_state:address_state:LENGTH','address_state:address_state:WORDS'
          ,'orig_zip:orig_zip:LEFTTRIM','orig_zip:orig_zip:ALLOW','orig_zip:orig_zip:LENGTH','orig_zip:orig_zip:WORDS'
          ,'orig_county:orig_county:LEFTTRIM','orig_county:orig_county:ALLOW','orig_county:orig_county:WORDS'
          ,'country:country:LEFTTRIM','country:country:ALLOW','country:country:WORDS'
          ,'address_type:address_type:LEFTTRIM','address_type:address_type:ALLOW','address_type:address_type:WORDS'
          ,'phone1:phone1:LEFTTRIM','phone1:phone1:ALLOW','phone1:phone1:LENGTH','phone1:phone1:WORDS'
          ,'phone2:phone2:LEFTTRIM','phone2:phone2:ALLOW','phone2:phone2:LENGTH','phone2:phone2:WORDS'
          ,'phone3:phone3:LEFTTRIM','phone3:phone3:ALLOW','phone3:phone3:LENGTH','phone3:phone3:WORDS'
          ,'fax1:fax1:LEFTTRIM','fax1:fax1:ALLOW','fax1:fax1:LENGTH','fax1:fax1:WORDS'
          ,'fax2:fax2:LEFTTRIM','fax2:fax2:ALLOW','fax2:fax2:LENGTH','fax2:fax2:WORDS'
          ,'fax3:fax3:LEFTTRIM','fax3:fax3:ALLOW','fax3:fax3:LENGTH','fax3:fax3:WORDS'
          ,'other_phone1:other_phone1:LEFTTRIM','other_phone1:other_phone1:ALLOW','other_phone1:other_phone1:LENGTH','other_phone1:other_phone1:WORDS'
          ,'description:description:LEFTTRIM','description:description:ALLOW','description:description:WORDS'
          ,'specialty_class_type:specialty_class_type:LEFTTRIM','specialty_class_type:specialty_class_type:ALLOW','specialty_class_type:specialty_class_type:LENGTH','specialty_class_type:specialty_class_type:WORDS'
          ,'phone_number:phone_number:LEFTTRIM','phone_number:phone_number:ALLOW','phone_number:phone_number:LENGTH','phone_number:phone_number:WORDS'
          ,'phone_type:phone_type:LEFTTRIM','phone_type:phone_type:ALLOW','phone_type:phone_type:LENGTH','phone_type:phone_type:WORDS'
          ,'language:language:LEFTTRIM','language:language:ALLOW','language:language:WORDS'
          ,'graduated:graduated:LEFTTRIM','graduated:graduated:ALLOW','graduated:graduated:WORDS'
          ,'school:school:LEFTTRIM','school:school:ALLOW','school:school:WORDS'
          ,'location:location:LEFTTRIM','location:location:ALLOW','location:location:WORDS'
          ,'board:board:LEFTTRIM','board:board:ALLOW','board:board:WORDS'
          ,'offense:offense:LEFTTRIM','offense:offense:ALLOW','offense:offense:WORDS'
          ,'offense_date:offense_date:LEFTTRIM','offense_date:offense_date:ALLOW','offense_date:offense_date:LENGTH','offense_date:offense_date:WORDS'
          ,'action:action:LEFTTRIM','action:action:ALLOW','action:action:LENGTH','action:action:WORDS'
          ,'action_date:action_date:LEFTTRIM','action_date:action_date:ALLOW','action_date:action_date:LENGTH','action_date:action_date:WORDS'
          ,'action_start:action_start:LEFTTRIM','action_start:action_start:ALLOW','action_start:action_start:LENGTH','action_start:action_start:WORDS'
          ,'action_end:action_end:LEFTTRIM','action_end:action_end:ALLOW','action_end:action_end:LENGTH','action_end:action_end:WORDS'
          ,'npi_number:npi_number:LEFTTRIM','npi_number:npi_number:ALLOW','npi_number:npi_number:LENGTH','npi_number:npi_number:WORDS'
          ,'csr_number:csr_number:LEFTTRIM','csr_number:csr_number:ALLOW','csr_number:csr_number:LENGTH','csr_number:csr_number:WORDS'
          ,'dea_number:dea_number:LEFTTRIM','dea_number:dea_number:ALLOW','dea_number:dea_number:LENGTH','dea_number:dea_number:WORDS'
          ,'prepped_addr1:prepped_addr1:LEFTTRIM','prepped_addr1:prepped_addr1:ALLOW','prepped_addr1:prepped_addr1:WORDS'
          ,'prepped_addr2:prepped_addr2:LEFTTRIM','prepped_addr2:prepped_addr2:ALLOW','prepped_addr2:prepped_addr2:WORDS'
          ,'clean_phone:clean_phone:LEFTTRIM','clean_phone:clean_phone:ALLOW','clean_phone:clean_phone:LENGTH','clean_phone:clean_phone:WORDS'
          ,'clean_phone1:clean_phone1:LEFTTRIM','clean_phone1:clean_phone1:ALLOW','clean_phone1:clean_phone1:LENGTH','clean_phone1:clean_phone1:WORDS'
          ,'clean_phone2:clean_phone2:LEFTTRIM','clean_phone2:clean_phone2:ALLOW','clean_phone2:clean_phone2:LENGTH','clean_phone2:clean_phone2:WORDS'
          ,'clean_phone3:clean_phone3:LEFTTRIM','clean_phone3:clean_phone3:ALLOW','clean_phone3:clean_phone3:LENGTH','clean_phone3:clean_phone3:WORDS'
          ,'clean_fax1:clean_fax1:LEFTTRIM','clean_fax1:clean_fax1:ALLOW','clean_fax1:clean_fax1:LENGTH','clean_fax1:clean_fax1:WORDS'
          ,'clean_fax2:clean_fax2:LEFTTRIM','clean_fax2:clean_fax2:ALLOW','clean_fax2:clean_fax2:LENGTH','clean_fax2:clean_fax2:WORDS'
          ,'clean_fax3:clean_fax3:LEFTTRIM','clean_fax3:clean_fax3:ALLOW','clean_fax3:clean_fax3:LENGTH','clean_fax3:clean_fax3:WORDS'
          ,'clean_other_phone1:clean_other_phone1:LEFTTRIM','clean_other_phone1:clean_other_phone1:ALLOW','clean_other_phone1:clean_other_phone1:LENGTH','clean_other_phone1:clean_other_phone1:WORDS'
          ,'clean_dateofbirth:clean_dateofbirth:LEFTTRIM','clean_dateofbirth:clean_dateofbirth:ALLOW','clean_dateofbirth:clean_dateofbirth:LENGTH','clean_dateofbirth:clean_dateofbirth:WORDS'
          ,'clean_dateofdeath:clean_dateofdeath:LEFTTRIM','clean_dateofdeath:clean_dateofdeath:ALLOW','clean_dateofdeath:clean_dateofdeath:LENGTH','clean_dateofdeath:clean_dateofdeath:WORDS'
          ,'clean_company_name:clean_company_name:LEFTTRIM','clean_company_name:clean_company_name:ALLOW','clean_company_name:clean_company_name:LENGTH','clean_company_name:clean_company_name:WORDS'
          ,'clean_issue_date:clean_issue_date:LEFTTRIM','clean_issue_date:clean_issue_date:ALLOW','clean_issue_date:clean_issue_date:LENGTH','clean_issue_date:clean_issue_date:WORDS'
          ,'clean_expiration_date:clean_expiration_date:LEFTTRIM','clean_expiration_date:clean_expiration_date:ALLOW','clean_expiration_date:clean_expiration_date:LENGTH','clean_expiration_date:clean_expiration_date:WORDS'
          ,'clean_offense_date:clean_offense_date:LEFTTRIM','clean_offense_date:clean_offense_date:ALLOW','clean_offense_date:clean_offense_date:LENGTH','clean_offense_date:clean_offense_date:WORDS'
          ,'clean_action_date:clean_action_date:LEFTTRIM','clean_action_date:clean_action_date:ALLOW','clean_action_date:clean_action_date:LENGTH','clean_action_date:clean_action_date:WORDS'
          ,'src:src:LEFTTRIM','src:src:ALLOW','src:src:LENGTH','src:src:WORDS'
          ,'zip:zip:LEFTTRIM','zip:zip:ALLOW','zip:zip:LENGTH','zip:zip:WORDS'
          ,'zip4:zip4:LEFTTRIM','zip4:zip4:ALLOW','zip4:zip4:LENGTH','zip4:zip4:WORDS'
          ,'bdid:bdid:LEFTTRIM','bdid:bdid:ALLOW','bdid:bdid:LENGTH','bdid:bdid:WORDS'
          ,'bdid_score:bdid_score:LEFTTRIM','bdid_score:bdid_score:ALLOW','bdid_score:bdid_score:LENGTH','bdid_score:bdid_score:WORDS'
          ,'lnpid:lnpid:LEFTTRIM','lnpid:lnpid:ALLOW','lnpid:lnpid:LENGTH','lnpid:lnpid:WORDS'
          ,'did:did:LEFTTRIM','did:did:ALLOW','did:did:LENGTH','did:did:WORDS'
          ,'did_score:did_score:LEFTTRIM','did_score:did_score:ALLOW','did_score:did_score:LENGTH','did_score:did_score:WORDS'
          ,'dt_vendor_first_reported:dt_vendor_first_reported:LEFTTRIM','dt_vendor_first_reported:dt_vendor_first_reported:ALLOW','dt_vendor_first_reported:dt_vendor_first_reported:LENGTH','dt_vendor_first_reported:dt_vendor_first_reported:WORDS'
          ,'dt_vendor_last_reported:dt_vendor_last_reported:LEFTTRIM','dt_vendor_last_reported:dt_vendor_last_reported:ALLOW','dt_vendor_last_reported:dt_vendor_last_reported:LENGTH','dt_vendor_last_reported:dt_vendor_last_reported:WORDS'
          ,'in_state:in_state:LEFTTRIM','in_state:in_state:ALLOW','in_state:in_state:WORDS'
          ,'in_class:in_class:LEFTTRIM','in_class:in_class:ALLOW','in_class:in_class:WORDS'
          ,'in_status:in_status:LEFTTRIM','in_status:in_status:ALLOW','in_status:in_status:WORDS'
          ,'in_qualifier1:in_qualifier1:LEFTTRIM','in_qualifier1:in_qualifier1:ALLOW','in_qualifier1:in_qualifier1:WORDS'
          ,'in_qualifier2:in_qualifier2:LEFTTRIM','in_qualifier2:in_qualifier2:ALLOW','in_qualifier2:in_qualifier2:WORDS'
          ,'mapped_class:mapped_class:LEFTTRIM','mapped_class:mapped_class:ALLOW','mapped_class:mapped_class:WORDS'
          ,'mapped_status:mapped_status:LEFTTRIM','mapped_status:mapped_status:ALLOW','mapped_status:mapped_status:WORDS'
          ,'mapped_qualifier1:mapped_qualifier1:LEFTTRIM','mapped_qualifier1:mapped_qualifier1:ALLOW','mapped_qualifier1:mapped_qualifier1:WORDS'
          ,'mapped_qualifier2:mapped_qualifier2:LEFTTRIM','mapped_qualifier2:mapped_qualifier2:ALLOW','mapped_qualifier2:mapped_qualifier2:WORDS'
          ,'mapped_pdma:mapped_pdma:LEFTTRIM','mapped_pdma:mapped_pdma:ALLOW','mapped_pdma:mapped_pdma:WORDS'
          ,'mapped_pract_type:mapped_pract_type:LEFTTRIM','mapped_pract_type:mapped_pract_type:ALLOW','mapped_pract_type:mapped_pract_type:WORDS'
          ,'source_code:source_code:LEFTTRIM','source_code:source_code:ALLOW','source_code:source_code:WORDS'
          ,'taxonomy_code:taxonomy_code:LEFTTRIM','taxonomy_code:taxonomy_code:ALLOW','taxonomy_code:taxonomy_code:WORDS','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,HmsStlic_Fields.InvalidMessage_ln_key(1),HmsStlic_Fields.InvalidMessage_ln_key(2),HmsStlic_Fields.InvalidMessage_ln_key(3),HmsStlic_Fields.InvalidMessage_ln_key(4)
          ,HmsStlic_Fields.InvalidMessage_hms_src(1),HmsStlic_Fields.InvalidMessage_hms_src(2),HmsStlic_Fields.InvalidMessage_hms_src(3),HmsStlic_Fields.InvalidMessage_hms_src(4)
          ,HmsStlic_Fields.InvalidMessage_key(1),HmsStlic_Fields.InvalidMessage_key(2),HmsStlic_Fields.InvalidMessage_key(3),HmsStlic_Fields.InvalidMessage_key(4)
          ,HmsStlic_Fields.InvalidMessage_id(1),HmsStlic_Fields.InvalidMessage_id(2),HmsStlic_Fields.InvalidMessage_id(3),HmsStlic_Fields.InvalidMessage_id(4)
          ,HmsStlic_Fields.InvalidMessage_entityid(1),HmsStlic_Fields.InvalidMessage_entityid(2),HmsStlic_Fields.InvalidMessage_entityid(3),HmsStlic_Fields.InvalidMessage_entityid(4)
          ,HmsStlic_Fields.InvalidMessage_license_number(1),HmsStlic_Fields.InvalidMessage_license_number(2),HmsStlic_Fields.InvalidMessage_license_number(3),HmsStlic_Fields.InvalidMessage_license_number(4)
          ,HmsStlic_Fields.InvalidMessage_license_class_type(1),HmsStlic_Fields.InvalidMessage_license_class_type(2),HmsStlic_Fields.InvalidMessage_license_class_type(3),HmsStlic_Fields.InvalidMessage_license_class_type(4)
          ,HmsStlic_Fields.InvalidMessage_license_state(1),HmsStlic_Fields.InvalidMessage_license_state(2),HmsStlic_Fields.InvalidMessage_license_state(3),HmsStlic_Fields.InvalidMessage_license_state(4)
          ,HmsStlic_Fields.InvalidMessage_status(1),HmsStlic_Fields.InvalidMessage_status(2),HmsStlic_Fields.InvalidMessage_status(3),HmsStlic_Fields.InvalidMessage_status(4)
          ,HmsStlic_Fields.InvalidMessage_issue_date(1),HmsStlic_Fields.InvalidMessage_issue_date(2),HmsStlic_Fields.InvalidMessage_issue_date(3),HmsStlic_Fields.InvalidMessage_issue_date(4)
          ,HmsStlic_Fields.InvalidMessage_expiration_date(1),HmsStlic_Fields.InvalidMessage_expiration_date(2),HmsStlic_Fields.InvalidMessage_expiration_date(3),HmsStlic_Fields.InvalidMessage_expiration_date(4)
          ,HmsStlic_Fields.InvalidMessage_qualifier1(1),HmsStlic_Fields.InvalidMessage_qualifier1(2),HmsStlic_Fields.InvalidMessage_qualifier1(3)
          ,HmsStlic_Fields.InvalidMessage_qualifier2(1),HmsStlic_Fields.InvalidMessage_qualifier2(2),HmsStlic_Fields.InvalidMessage_qualifier2(3)
          ,HmsStlic_Fields.InvalidMessage_qualifier3(1),HmsStlic_Fields.InvalidMessage_qualifier3(2),HmsStlic_Fields.InvalidMessage_qualifier3(3)
          ,HmsStlic_Fields.InvalidMessage_qualifier4(1),HmsStlic_Fields.InvalidMessage_qualifier4(2),HmsStlic_Fields.InvalidMessage_qualifier4(3)
          ,HmsStlic_Fields.InvalidMessage_qualifier5(1),HmsStlic_Fields.InvalidMessage_qualifier5(2),HmsStlic_Fields.InvalidMessage_qualifier5(3)
          ,HmsStlic_Fields.InvalidMessage_rawclass(1),HmsStlic_Fields.InvalidMessage_rawclass(2),HmsStlic_Fields.InvalidMessage_rawclass(3),HmsStlic_Fields.InvalidMessage_rawclass(4)
          ,HmsStlic_Fields.InvalidMessage_rawissue_date(1),HmsStlic_Fields.InvalidMessage_rawissue_date(2),HmsStlic_Fields.InvalidMessage_rawissue_date(3),HmsStlic_Fields.InvalidMessage_rawissue_date(4)
          ,HmsStlic_Fields.InvalidMessage_rawexpiration_date(1),HmsStlic_Fields.InvalidMessage_rawexpiration_date(2),HmsStlic_Fields.InvalidMessage_rawexpiration_date(3),HmsStlic_Fields.InvalidMessage_rawexpiration_date(4)
          ,HmsStlic_Fields.InvalidMessage_rawstatus(1),HmsStlic_Fields.InvalidMessage_rawstatus(2),HmsStlic_Fields.InvalidMessage_rawstatus(3),HmsStlic_Fields.InvalidMessage_rawstatus(4)
          ,HmsStlic_Fields.InvalidMessage_raw_number(1),HmsStlic_Fields.InvalidMessage_raw_number(2),HmsStlic_Fields.InvalidMessage_raw_number(3),HmsStlic_Fields.InvalidMessage_raw_number(4)
          ,HmsStlic_Fields.InvalidMessage_name(1),HmsStlic_Fields.InvalidMessage_name(2),HmsStlic_Fields.InvalidMessage_name(3)
          ,HmsStlic_Fields.InvalidMessage_first(1),HmsStlic_Fields.InvalidMessage_first(2),HmsStlic_Fields.InvalidMessage_first(3)
          ,HmsStlic_Fields.InvalidMessage_middle(1),HmsStlic_Fields.InvalidMessage_middle(2),HmsStlic_Fields.InvalidMessage_middle(3)
          ,HmsStlic_Fields.InvalidMessage_last(1),HmsStlic_Fields.InvalidMessage_last(2),HmsStlic_Fields.InvalidMessage_last(3)
          ,HmsStlic_Fields.InvalidMessage_suffix(1),HmsStlic_Fields.InvalidMessage_suffix(2),HmsStlic_Fields.InvalidMessage_suffix(3)
          ,HmsStlic_Fields.InvalidMessage_cred(1),HmsStlic_Fields.InvalidMessage_cred(2),HmsStlic_Fields.InvalidMessage_cred(3)
          ,HmsStlic_Fields.InvalidMessage_age(1),HmsStlic_Fields.InvalidMessage_age(2),HmsStlic_Fields.InvalidMessage_age(3),HmsStlic_Fields.InvalidMessage_age(4)
          ,HmsStlic_Fields.InvalidMessage_dateofbirth(1),HmsStlic_Fields.InvalidMessage_dateofbirth(2),HmsStlic_Fields.InvalidMessage_dateofbirth(3),HmsStlic_Fields.InvalidMessage_dateofbirth(4)
          ,HmsStlic_Fields.InvalidMessage_email(1),HmsStlic_Fields.InvalidMessage_email(2),HmsStlic_Fields.InvalidMessage_email(3),HmsStlic_Fields.InvalidMessage_email(4)
          ,HmsStlic_Fields.InvalidMessage_gender(1),HmsStlic_Fields.InvalidMessage_gender(2),HmsStlic_Fields.InvalidMessage_gender(3),HmsStlic_Fields.InvalidMessage_gender(4)
          ,HmsStlic_Fields.InvalidMessage_dateofdeath(1),HmsStlic_Fields.InvalidMessage_dateofdeath(2),HmsStlic_Fields.InvalidMessage_dateofdeath(3),HmsStlic_Fields.InvalidMessage_dateofdeath(4)
          ,HmsStlic_Fields.InvalidMessage_firmname(1),HmsStlic_Fields.InvalidMessage_firmname(2),HmsStlic_Fields.InvalidMessage_firmname(3)
          ,HmsStlic_Fields.InvalidMessage_street1(1),HmsStlic_Fields.InvalidMessage_street1(2),HmsStlic_Fields.InvalidMessage_street1(3)
          ,HmsStlic_Fields.InvalidMessage_street2(1),HmsStlic_Fields.InvalidMessage_street2(2),HmsStlic_Fields.InvalidMessage_street2(3)
          ,HmsStlic_Fields.InvalidMessage_street3(1),HmsStlic_Fields.InvalidMessage_street3(2),HmsStlic_Fields.InvalidMessage_street3(3)
          ,HmsStlic_Fields.InvalidMessage_city(1),HmsStlic_Fields.InvalidMessage_city(2),HmsStlic_Fields.InvalidMessage_city(3)
          ,HmsStlic_Fields.InvalidMessage_address_state(1),HmsStlic_Fields.InvalidMessage_address_state(2),HmsStlic_Fields.InvalidMessage_address_state(3),HmsStlic_Fields.InvalidMessage_address_state(4)
          ,HmsStlic_Fields.InvalidMessage_orig_zip(1),HmsStlic_Fields.InvalidMessage_orig_zip(2),HmsStlic_Fields.InvalidMessage_orig_zip(3),HmsStlic_Fields.InvalidMessage_orig_zip(4)
          ,HmsStlic_Fields.InvalidMessage_orig_county(1),HmsStlic_Fields.InvalidMessage_orig_county(2),HmsStlic_Fields.InvalidMessage_orig_county(3)
          ,HmsStlic_Fields.InvalidMessage_country(1),HmsStlic_Fields.InvalidMessage_country(2),HmsStlic_Fields.InvalidMessage_country(3)
          ,HmsStlic_Fields.InvalidMessage_address_type(1),HmsStlic_Fields.InvalidMessage_address_type(2),HmsStlic_Fields.InvalidMessage_address_type(3)
          ,HmsStlic_Fields.InvalidMessage_phone1(1),HmsStlic_Fields.InvalidMessage_phone1(2),HmsStlic_Fields.InvalidMessage_phone1(3),HmsStlic_Fields.InvalidMessage_phone1(4)
          ,HmsStlic_Fields.InvalidMessage_phone2(1),HmsStlic_Fields.InvalidMessage_phone2(2),HmsStlic_Fields.InvalidMessage_phone2(3),HmsStlic_Fields.InvalidMessage_phone2(4)
          ,HmsStlic_Fields.InvalidMessage_phone3(1),HmsStlic_Fields.InvalidMessage_phone3(2),HmsStlic_Fields.InvalidMessage_phone3(3),HmsStlic_Fields.InvalidMessage_phone3(4)
          ,HmsStlic_Fields.InvalidMessage_fax1(1),HmsStlic_Fields.InvalidMessage_fax1(2),HmsStlic_Fields.InvalidMessage_fax1(3),HmsStlic_Fields.InvalidMessage_fax1(4)
          ,HmsStlic_Fields.InvalidMessage_fax2(1),HmsStlic_Fields.InvalidMessage_fax2(2),HmsStlic_Fields.InvalidMessage_fax2(3),HmsStlic_Fields.InvalidMessage_fax2(4)
          ,HmsStlic_Fields.InvalidMessage_fax3(1),HmsStlic_Fields.InvalidMessage_fax3(2),HmsStlic_Fields.InvalidMessage_fax3(3),HmsStlic_Fields.InvalidMessage_fax3(4)
          ,HmsStlic_Fields.InvalidMessage_other_phone1(1),HmsStlic_Fields.InvalidMessage_other_phone1(2),HmsStlic_Fields.InvalidMessage_other_phone1(3),HmsStlic_Fields.InvalidMessage_other_phone1(4)
          ,HmsStlic_Fields.InvalidMessage_description(1),HmsStlic_Fields.InvalidMessage_description(2),HmsStlic_Fields.InvalidMessage_description(3)
          ,HmsStlic_Fields.InvalidMessage_specialty_class_type(1),HmsStlic_Fields.InvalidMessage_specialty_class_type(2),HmsStlic_Fields.InvalidMessage_specialty_class_type(3),HmsStlic_Fields.InvalidMessage_specialty_class_type(4)
          ,HmsStlic_Fields.InvalidMessage_phone_number(1),HmsStlic_Fields.InvalidMessage_phone_number(2),HmsStlic_Fields.InvalidMessage_phone_number(3),HmsStlic_Fields.InvalidMessage_phone_number(4)
          ,HmsStlic_Fields.InvalidMessage_phone_type(1),HmsStlic_Fields.InvalidMessage_phone_type(2),HmsStlic_Fields.InvalidMessage_phone_type(3),HmsStlic_Fields.InvalidMessage_phone_type(4)
          ,HmsStlic_Fields.InvalidMessage_language(1),HmsStlic_Fields.InvalidMessage_language(2),HmsStlic_Fields.InvalidMessage_language(3)
          ,HmsStlic_Fields.InvalidMessage_graduated(1),HmsStlic_Fields.InvalidMessage_graduated(2),HmsStlic_Fields.InvalidMessage_graduated(3)
          ,HmsStlic_Fields.InvalidMessage_school(1),HmsStlic_Fields.InvalidMessage_school(2),HmsStlic_Fields.InvalidMessage_school(3)
          ,HmsStlic_Fields.InvalidMessage_location(1),HmsStlic_Fields.InvalidMessage_location(2),HmsStlic_Fields.InvalidMessage_location(3)
          ,HmsStlic_Fields.InvalidMessage_board(1),HmsStlic_Fields.InvalidMessage_board(2),HmsStlic_Fields.InvalidMessage_board(3)
          ,HmsStlic_Fields.InvalidMessage_offense(1),HmsStlic_Fields.InvalidMessage_offense(2),HmsStlic_Fields.InvalidMessage_offense(3)
          ,HmsStlic_Fields.InvalidMessage_offense_date(1),HmsStlic_Fields.InvalidMessage_offense_date(2),HmsStlic_Fields.InvalidMessage_offense_date(3),HmsStlic_Fields.InvalidMessage_offense_date(4)
          ,HmsStlic_Fields.InvalidMessage_action(1),HmsStlic_Fields.InvalidMessage_action(2),HmsStlic_Fields.InvalidMessage_action(3),HmsStlic_Fields.InvalidMessage_action(4)
          ,HmsStlic_Fields.InvalidMessage_action_date(1),HmsStlic_Fields.InvalidMessage_action_date(2),HmsStlic_Fields.InvalidMessage_action_date(3),HmsStlic_Fields.InvalidMessage_action_date(4)
          ,HmsStlic_Fields.InvalidMessage_action_start(1),HmsStlic_Fields.InvalidMessage_action_start(2),HmsStlic_Fields.InvalidMessage_action_start(3),HmsStlic_Fields.InvalidMessage_action_start(4)
          ,HmsStlic_Fields.InvalidMessage_action_end(1),HmsStlic_Fields.InvalidMessage_action_end(2),HmsStlic_Fields.InvalidMessage_action_end(3),HmsStlic_Fields.InvalidMessage_action_end(4)
          ,HmsStlic_Fields.InvalidMessage_npi_number(1),HmsStlic_Fields.InvalidMessage_npi_number(2),HmsStlic_Fields.InvalidMessage_npi_number(3),HmsStlic_Fields.InvalidMessage_npi_number(4)
          ,HmsStlic_Fields.InvalidMessage_csr_number(1),HmsStlic_Fields.InvalidMessage_csr_number(2),HmsStlic_Fields.InvalidMessage_csr_number(3),HmsStlic_Fields.InvalidMessage_csr_number(4)
          ,HmsStlic_Fields.InvalidMessage_dea_number(1),HmsStlic_Fields.InvalidMessage_dea_number(2),HmsStlic_Fields.InvalidMessage_dea_number(3),HmsStlic_Fields.InvalidMessage_dea_number(4)
          ,HmsStlic_Fields.InvalidMessage_prepped_addr1(1),HmsStlic_Fields.InvalidMessage_prepped_addr1(2),HmsStlic_Fields.InvalidMessage_prepped_addr1(3)
          ,HmsStlic_Fields.InvalidMessage_prepped_addr2(1),HmsStlic_Fields.InvalidMessage_prepped_addr2(2),HmsStlic_Fields.InvalidMessage_prepped_addr2(3)
          ,HmsStlic_Fields.InvalidMessage_clean_phone(1),HmsStlic_Fields.InvalidMessage_clean_phone(2),HmsStlic_Fields.InvalidMessage_clean_phone(3),HmsStlic_Fields.InvalidMessage_clean_phone(4)
          ,HmsStlic_Fields.InvalidMessage_clean_phone1(1),HmsStlic_Fields.InvalidMessage_clean_phone1(2),HmsStlic_Fields.InvalidMessage_clean_phone1(3),HmsStlic_Fields.InvalidMessage_clean_phone1(4)
          ,HmsStlic_Fields.InvalidMessage_clean_phone2(1),HmsStlic_Fields.InvalidMessage_clean_phone2(2),HmsStlic_Fields.InvalidMessage_clean_phone2(3),HmsStlic_Fields.InvalidMessage_clean_phone2(4)
          ,HmsStlic_Fields.InvalidMessage_clean_phone3(1),HmsStlic_Fields.InvalidMessage_clean_phone3(2),HmsStlic_Fields.InvalidMessage_clean_phone3(3),HmsStlic_Fields.InvalidMessage_clean_phone3(4)
          ,HmsStlic_Fields.InvalidMessage_clean_fax1(1),HmsStlic_Fields.InvalidMessage_clean_fax1(2),HmsStlic_Fields.InvalidMessage_clean_fax1(3),HmsStlic_Fields.InvalidMessage_clean_fax1(4)
          ,HmsStlic_Fields.InvalidMessage_clean_fax2(1),HmsStlic_Fields.InvalidMessage_clean_fax2(2),HmsStlic_Fields.InvalidMessage_clean_fax2(3),HmsStlic_Fields.InvalidMessage_clean_fax2(4)
          ,HmsStlic_Fields.InvalidMessage_clean_fax3(1),HmsStlic_Fields.InvalidMessage_clean_fax3(2),HmsStlic_Fields.InvalidMessage_clean_fax3(3),HmsStlic_Fields.InvalidMessage_clean_fax3(4)
          ,HmsStlic_Fields.InvalidMessage_clean_other_phone1(1),HmsStlic_Fields.InvalidMessage_clean_other_phone1(2),HmsStlic_Fields.InvalidMessage_clean_other_phone1(3),HmsStlic_Fields.InvalidMessage_clean_other_phone1(4)
          ,HmsStlic_Fields.InvalidMessage_clean_dateofbirth(1),HmsStlic_Fields.InvalidMessage_clean_dateofbirth(2),HmsStlic_Fields.InvalidMessage_clean_dateofbirth(3),HmsStlic_Fields.InvalidMessage_clean_dateofbirth(4)
          ,HmsStlic_Fields.InvalidMessage_clean_dateofdeath(1),HmsStlic_Fields.InvalidMessage_clean_dateofdeath(2),HmsStlic_Fields.InvalidMessage_clean_dateofdeath(3),HmsStlic_Fields.InvalidMessage_clean_dateofdeath(4)
          ,HmsStlic_Fields.InvalidMessage_clean_company_name(1),HmsStlic_Fields.InvalidMessage_clean_company_name(2),HmsStlic_Fields.InvalidMessage_clean_company_name(3),HmsStlic_Fields.InvalidMessage_clean_company_name(4)
          ,HmsStlic_Fields.InvalidMessage_clean_issue_date(1),HmsStlic_Fields.InvalidMessage_clean_issue_date(2),HmsStlic_Fields.InvalidMessage_clean_issue_date(3),HmsStlic_Fields.InvalidMessage_clean_issue_date(4)
          ,HmsStlic_Fields.InvalidMessage_clean_expiration_date(1),HmsStlic_Fields.InvalidMessage_clean_expiration_date(2),HmsStlic_Fields.InvalidMessage_clean_expiration_date(3),HmsStlic_Fields.InvalidMessage_clean_expiration_date(4)
          ,HmsStlic_Fields.InvalidMessage_clean_offense_date(1),HmsStlic_Fields.InvalidMessage_clean_offense_date(2),HmsStlic_Fields.InvalidMessage_clean_offense_date(3),HmsStlic_Fields.InvalidMessage_clean_offense_date(4)
          ,HmsStlic_Fields.InvalidMessage_clean_action_date(1),HmsStlic_Fields.InvalidMessage_clean_action_date(2),HmsStlic_Fields.InvalidMessage_clean_action_date(3),HmsStlic_Fields.InvalidMessage_clean_action_date(4)
          ,HmsStlic_Fields.InvalidMessage_src(1),HmsStlic_Fields.InvalidMessage_src(2),HmsStlic_Fields.InvalidMessage_src(3),HmsStlic_Fields.InvalidMessage_src(4)
          ,HmsStlic_Fields.InvalidMessage_zip(1),HmsStlic_Fields.InvalidMessage_zip(2),HmsStlic_Fields.InvalidMessage_zip(3),HmsStlic_Fields.InvalidMessage_zip(4)
          ,HmsStlic_Fields.InvalidMessage_zip4(1),HmsStlic_Fields.InvalidMessage_zip4(2),HmsStlic_Fields.InvalidMessage_zip4(3),HmsStlic_Fields.InvalidMessage_zip4(4)
          ,HmsStlic_Fields.InvalidMessage_bdid(1),HmsStlic_Fields.InvalidMessage_bdid(2),HmsStlic_Fields.InvalidMessage_bdid(3),HmsStlic_Fields.InvalidMessage_bdid(4)
          ,HmsStlic_Fields.InvalidMessage_bdid_score(1),HmsStlic_Fields.InvalidMessage_bdid_score(2),HmsStlic_Fields.InvalidMessage_bdid_score(3),HmsStlic_Fields.InvalidMessage_bdid_score(4)
          ,HmsStlic_Fields.InvalidMessage_lnpid(1),HmsStlic_Fields.InvalidMessage_lnpid(2),HmsStlic_Fields.InvalidMessage_lnpid(3),HmsStlic_Fields.InvalidMessage_lnpid(4)
          ,HmsStlic_Fields.InvalidMessage_did(1),HmsStlic_Fields.InvalidMessage_did(2),HmsStlic_Fields.InvalidMessage_did(3),HmsStlic_Fields.InvalidMessage_did(4)
          ,HmsStlic_Fields.InvalidMessage_did_score(1),HmsStlic_Fields.InvalidMessage_did_score(2),HmsStlic_Fields.InvalidMessage_did_score(3),HmsStlic_Fields.InvalidMessage_did_score(4)
          ,HmsStlic_Fields.InvalidMessage_dt_vendor_first_reported(1),HmsStlic_Fields.InvalidMessage_dt_vendor_first_reported(2),HmsStlic_Fields.InvalidMessage_dt_vendor_first_reported(3),HmsStlic_Fields.InvalidMessage_dt_vendor_first_reported(4)
          ,HmsStlic_Fields.InvalidMessage_dt_vendor_last_reported(1),HmsStlic_Fields.InvalidMessage_dt_vendor_last_reported(2),HmsStlic_Fields.InvalidMessage_dt_vendor_last_reported(3),HmsStlic_Fields.InvalidMessage_dt_vendor_last_reported(4)
          ,HmsStlic_Fields.InvalidMessage_in_state(1),HmsStlic_Fields.InvalidMessage_in_state(2),HmsStlic_Fields.InvalidMessage_in_state(3)
          ,HmsStlic_Fields.InvalidMessage_in_class(1),HmsStlic_Fields.InvalidMessage_in_class(2),HmsStlic_Fields.InvalidMessage_in_class(3)
          ,HmsStlic_Fields.InvalidMessage_in_status(1),HmsStlic_Fields.InvalidMessage_in_status(2),HmsStlic_Fields.InvalidMessage_in_status(3)
          ,HmsStlic_Fields.InvalidMessage_in_qualifier1(1),HmsStlic_Fields.InvalidMessage_in_qualifier1(2),HmsStlic_Fields.InvalidMessage_in_qualifier1(3)
          ,HmsStlic_Fields.InvalidMessage_in_qualifier2(1),HmsStlic_Fields.InvalidMessage_in_qualifier2(2),HmsStlic_Fields.InvalidMessage_in_qualifier2(3)
          ,HmsStlic_Fields.InvalidMessage_mapped_class(1),HmsStlic_Fields.InvalidMessage_mapped_class(2),HmsStlic_Fields.InvalidMessage_mapped_class(3)
          ,HmsStlic_Fields.InvalidMessage_mapped_status(1),HmsStlic_Fields.InvalidMessage_mapped_status(2),HmsStlic_Fields.InvalidMessage_mapped_status(3)
          ,HmsStlic_Fields.InvalidMessage_mapped_qualifier1(1),HmsStlic_Fields.InvalidMessage_mapped_qualifier1(2),HmsStlic_Fields.InvalidMessage_mapped_qualifier1(3)
          ,HmsStlic_Fields.InvalidMessage_mapped_qualifier2(1),HmsStlic_Fields.InvalidMessage_mapped_qualifier2(2),HmsStlic_Fields.InvalidMessage_mapped_qualifier2(3)
          ,HmsStlic_Fields.InvalidMessage_mapped_pdma(1),HmsStlic_Fields.InvalidMessage_mapped_pdma(2),HmsStlic_Fields.InvalidMessage_mapped_pdma(3)
          ,HmsStlic_Fields.InvalidMessage_mapped_pract_type(1),HmsStlic_Fields.InvalidMessage_mapped_pract_type(2),HmsStlic_Fields.InvalidMessage_mapped_pract_type(3)
          ,HmsStlic_Fields.InvalidMessage_source_code(1),HmsStlic_Fields.InvalidMessage_source_code(2),HmsStlic_Fields.InvalidMessage_source_code(3)
          ,HmsStlic_Fields.InvalidMessage_taxonomy_code(1),HmsStlic_Fields.InvalidMessage_taxonomy_code(2),HmsStlic_Fields.InvalidMessage_taxonomy_code(3),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.ln_key_LEFTTRIM_ErrorCount,le.ln_key_ALLOW_ErrorCount,le.ln_key_LENGTH_ErrorCount,le.ln_key_WORDS_ErrorCount
          ,le.hms_src_LEFTTRIM_ErrorCount,le.hms_src_ALLOW_ErrorCount,le.hms_src_LENGTH_ErrorCount,le.hms_src_WORDS_ErrorCount
          ,le.key_LEFTTRIM_ErrorCount,le.key_ALLOW_ErrorCount,le.key_LENGTH_ErrorCount,le.key_WORDS_ErrorCount
          ,le.id_LEFTTRIM_ErrorCount,le.id_ALLOW_ErrorCount,le.id_LENGTH_ErrorCount,le.id_WORDS_ErrorCount
          ,le.entityid_LEFTTRIM_ErrorCount,le.entityid_ALLOW_ErrorCount,le.entityid_LENGTH_ErrorCount,le.entityid_WORDS_ErrorCount
          ,le.license_number_LEFTTRIM_ErrorCount,le.license_number_ALLOW_ErrorCount,le.license_number_LENGTH_ErrorCount,le.license_number_WORDS_ErrorCount
          ,le.license_class_type_LEFTTRIM_ErrorCount,le.license_class_type_ALLOW_ErrorCount,le.license_class_type_LENGTH_ErrorCount,le.license_class_type_WORDS_ErrorCount
          ,le.license_state_LEFTTRIM_ErrorCount,le.license_state_ALLOW_ErrorCount,le.license_state_LENGTH_ErrorCount,le.license_state_WORDS_ErrorCount
          ,le.status_LEFTTRIM_ErrorCount,le.status_ALLOW_ErrorCount,le.status_LENGTH_ErrorCount,le.status_WORDS_ErrorCount
          ,le.issue_date_LEFTTRIM_ErrorCount,le.issue_date_ALLOW_ErrorCount,le.issue_date_LENGTH_ErrorCount,le.issue_date_WORDS_ErrorCount
          ,le.expiration_date_LEFTTRIM_ErrorCount,le.expiration_date_ALLOW_ErrorCount,le.expiration_date_LENGTH_ErrorCount,le.expiration_date_WORDS_ErrorCount
          ,le.qualifier1_LEFTTRIM_ErrorCount,le.qualifier1_ALLOW_ErrorCount,le.qualifier1_WORDS_ErrorCount
          ,le.qualifier2_LEFTTRIM_ErrorCount,le.qualifier2_ALLOW_ErrorCount,le.qualifier2_WORDS_ErrorCount
          ,le.qualifier3_LEFTTRIM_ErrorCount,le.qualifier3_ALLOW_ErrorCount,le.qualifier3_WORDS_ErrorCount
          ,le.qualifier4_LEFTTRIM_ErrorCount,le.qualifier4_ALLOW_ErrorCount,le.qualifier4_WORDS_ErrorCount
          ,le.qualifier5_LEFTTRIM_ErrorCount,le.qualifier5_ALLOW_ErrorCount,le.qualifier5_WORDS_ErrorCount
          ,le.rawclass_LEFTTRIM_ErrorCount,le.rawclass_ALLOW_ErrorCount,le.rawclass_LENGTH_ErrorCount,le.rawclass_WORDS_ErrorCount
          ,le.rawissue_date_LEFTTRIM_ErrorCount,le.rawissue_date_ALLOW_ErrorCount,le.rawissue_date_LENGTH_ErrorCount,le.rawissue_date_WORDS_ErrorCount
          ,le.rawexpiration_date_LEFTTRIM_ErrorCount,le.rawexpiration_date_ALLOW_ErrorCount,le.rawexpiration_date_LENGTH_ErrorCount,le.rawexpiration_date_WORDS_ErrorCount
          ,le.rawstatus_LEFTTRIM_ErrorCount,le.rawstatus_ALLOW_ErrorCount,le.rawstatus_LENGTH_ErrorCount,le.rawstatus_WORDS_ErrorCount
          ,le.raw_number_LEFTTRIM_ErrorCount,le.raw_number_ALLOW_ErrorCount,le.raw_number_LENGTH_ErrorCount,le.raw_number_WORDS_ErrorCount
          ,le.name_LEFTTRIM_ErrorCount,le.name_ALLOW_ErrorCount,le.name_WORDS_ErrorCount
          ,le.first_LEFTTRIM_ErrorCount,le.first_ALLOW_ErrorCount,le.first_WORDS_ErrorCount
          ,le.middle_LEFTTRIM_ErrorCount,le.middle_ALLOW_ErrorCount,le.middle_WORDS_ErrorCount
          ,le.last_LEFTTRIM_ErrorCount,le.last_ALLOW_ErrorCount,le.last_WORDS_ErrorCount
          ,le.suffix_LEFTTRIM_ErrorCount,le.suffix_ALLOW_ErrorCount,le.suffix_WORDS_ErrorCount
          ,le.cred_LEFTTRIM_ErrorCount,le.cred_ALLOW_ErrorCount,le.cred_WORDS_ErrorCount
          ,le.age_LEFTTRIM_ErrorCount,le.age_ALLOW_ErrorCount,le.age_LENGTH_ErrorCount,le.age_WORDS_ErrorCount
          ,le.dateofbirth_LEFTTRIM_ErrorCount,le.dateofbirth_ALLOW_ErrorCount,le.dateofbirth_LENGTH_ErrorCount,le.dateofbirth_WORDS_ErrorCount
          ,le.email_LEFTTRIM_ErrorCount,le.email_ALLOW_ErrorCount,le.email_LENGTH_ErrorCount,le.email_WORDS_ErrorCount
          ,le.gender_LEFTTRIM_ErrorCount,le.gender_ALLOW_ErrorCount,le.gender_LENGTH_ErrorCount,le.gender_WORDS_ErrorCount
          ,le.dateofdeath_LEFTTRIM_ErrorCount,le.dateofdeath_ALLOW_ErrorCount,le.dateofdeath_LENGTH_ErrorCount,le.dateofdeath_WORDS_ErrorCount
          ,le.firmname_LEFTTRIM_ErrorCount,le.firmname_ALLOW_ErrorCount,le.firmname_WORDS_ErrorCount
          ,le.street1_LEFTTRIM_ErrorCount,le.street1_ALLOW_ErrorCount,le.street1_WORDS_ErrorCount
          ,le.street2_LEFTTRIM_ErrorCount,le.street2_ALLOW_ErrorCount,le.street2_WORDS_ErrorCount
          ,le.street3_LEFTTRIM_ErrorCount,le.street3_ALLOW_ErrorCount,le.street3_WORDS_ErrorCount
          ,le.city_LEFTTRIM_ErrorCount,le.city_ALLOW_ErrorCount,le.city_WORDS_ErrorCount
          ,le.address_state_LEFTTRIM_ErrorCount,le.address_state_ALLOW_ErrorCount,le.address_state_LENGTH_ErrorCount,le.address_state_WORDS_ErrorCount
          ,le.orig_zip_LEFTTRIM_ErrorCount,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_LENGTH_ErrorCount,le.orig_zip_WORDS_ErrorCount
          ,le.orig_county_LEFTTRIM_ErrorCount,le.orig_county_ALLOW_ErrorCount,le.orig_county_WORDS_ErrorCount
          ,le.country_LEFTTRIM_ErrorCount,le.country_ALLOW_ErrorCount,le.country_WORDS_ErrorCount
          ,le.address_type_LEFTTRIM_ErrorCount,le.address_type_ALLOW_ErrorCount,le.address_type_WORDS_ErrorCount
          ,le.phone1_LEFTTRIM_ErrorCount,le.phone1_ALLOW_ErrorCount,le.phone1_LENGTH_ErrorCount,le.phone1_WORDS_ErrorCount
          ,le.phone2_LEFTTRIM_ErrorCount,le.phone2_ALLOW_ErrorCount,le.phone2_LENGTH_ErrorCount,le.phone2_WORDS_ErrorCount
          ,le.phone3_LEFTTRIM_ErrorCount,le.phone3_ALLOW_ErrorCount,le.phone3_LENGTH_ErrorCount,le.phone3_WORDS_ErrorCount
          ,le.fax1_LEFTTRIM_ErrorCount,le.fax1_ALLOW_ErrorCount,le.fax1_LENGTH_ErrorCount,le.fax1_WORDS_ErrorCount
          ,le.fax2_LEFTTRIM_ErrorCount,le.fax2_ALLOW_ErrorCount,le.fax2_LENGTH_ErrorCount,le.fax2_WORDS_ErrorCount
          ,le.fax3_LEFTTRIM_ErrorCount,le.fax3_ALLOW_ErrorCount,le.fax3_LENGTH_ErrorCount,le.fax3_WORDS_ErrorCount
          ,le.other_phone1_LEFTTRIM_ErrorCount,le.other_phone1_ALLOW_ErrorCount,le.other_phone1_LENGTH_ErrorCount,le.other_phone1_WORDS_ErrorCount
          ,le.description_LEFTTRIM_ErrorCount,le.description_ALLOW_ErrorCount,le.description_WORDS_ErrorCount
          ,le.specialty_class_type_LEFTTRIM_ErrorCount,le.specialty_class_type_ALLOW_ErrorCount,le.specialty_class_type_LENGTH_ErrorCount,le.specialty_class_type_WORDS_ErrorCount
          ,le.phone_number_LEFTTRIM_ErrorCount,le.phone_number_ALLOW_ErrorCount,le.phone_number_LENGTH_ErrorCount,le.phone_number_WORDS_ErrorCount
          ,le.phone_type_LEFTTRIM_ErrorCount,le.phone_type_ALLOW_ErrorCount,le.phone_type_LENGTH_ErrorCount,le.phone_type_WORDS_ErrorCount
          ,le.language_LEFTTRIM_ErrorCount,le.language_ALLOW_ErrorCount,le.language_WORDS_ErrorCount
          ,le.graduated_LEFTTRIM_ErrorCount,le.graduated_ALLOW_ErrorCount,le.graduated_WORDS_ErrorCount
          ,le.school_LEFTTRIM_ErrorCount,le.school_ALLOW_ErrorCount,le.school_WORDS_ErrorCount
          ,le.location_LEFTTRIM_ErrorCount,le.location_ALLOW_ErrorCount,le.location_WORDS_ErrorCount
          ,le.board_LEFTTRIM_ErrorCount,le.board_ALLOW_ErrorCount,le.board_WORDS_ErrorCount
          ,le.offense_LEFTTRIM_ErrorCount,le.offense_ALLOW_ErrorCount,le.offense_WORDS_ErrorCount
          ,le.offense_date_LEFTTRIM_ErrorCount,le.offense_date_ALLOW_ErrorCount,le.offense_date_LENGTH_ErrorCount,le.offense_date_WORDS_ErrorCount
          ,le.action_LEFTTRIM_ErrorCount,le.action_ALLOW_ErrorCount,le.action_LENGTH_ErrorCount,le.action_WORDS_ErrorCount
          ,le.action_date_LEFTTRIM_ErrorCount,le.action_date_ALLOW_ErrorCount,le.action_date_LENGTH_ErrorCount,le.action_date_WORDS_ErrorCount
          ,le.action_start_LEFTTRIM_ErrorCount,le.action_start_ALLOW_ErrorCount,le.action_start_LENGTH_ErrorCount,le.action_start_WORDS_ErrorCount
          ,le.action_end_LEFTTRIM_ErrorCount,le.action_end_ALLOW_ErrorCount,le.action_end_LENGTH_ErrorCount,le.action_end_WORDS_ErrorCount
          ,le.npi_number_LEFTTRIM_ErrorCount,le.npi_number_ALLOW_ErrorCount,le.npi_number_LENGTH_ErrorCount,le.npi_number_WORDS_ErrorCount
          ,le.csr_number_LEFTTRIM_ErrorCount,le.csr_number_ALLOW_ErrorCount,le.csr_number_LENGTH_ErrorCount,le.csr_number_WORDS_ErrorCount
          ,le.dea_number_LEFTTRIM_ErrorCount,le.dea_number_ALLOW_ErrorCount,le.dea_number_LENGTH_ErrorCount,le.dea_number_WORDS_ErrorCount
          ,le.prepped_addr1_LEFTTRIM_ErrorCount,le.prepped_addr1_ALLOW_ErrorCount,le.prepped_addr1_WORDS_ErrorCount
          ,le.prepped_addr2_LEFTTRIM_ErrorCount,le.prepped_addr2_ALLOW_ErrorCount,le.prepped_addr2_WORDS_ErrorCount
          ,le.clean_phone_LEFTTRIM_ErrorCount,le.clean_phone_ALLOW_ErrorCount,le.clean_phone_LENGTH_ErrorCount,le.clean_phone_WORDS_ErrorCount
          ,le.clean_phone1_LEFTTRIM_ErrorCount,le.clean_phone1_ALLOW_ErrorCount,le.clean_phone1_LENGTH_ErrorCount,le.clean_phone1_WORDS_ErrorCount
          ,le.clean_phone2_LEFTTRIM_ErrorCount,le.clean_phone2_ALLOW_ErrorCount,le.clean_phone2_LENGTH_ErrorCount,le.clean_phone2_WORDS_ErrorCount
          ,le.clean_phone3_LEFTTRIM_ErrorCount,le.clean_phone3_ALLOW_ErrorCount,le.clean_phone3_LENGTH_ErrorCount,le.clean_phone3_WORDS_ErrorCount
          ,le.clean_fax1_LEFTTRIM_ErrorCount,le.clean_fax1_ALLOW_ErrorCount,le.clean_fax1_LENGTH_ErrorCount,le.clean_fax1_WORDS_ErrorCount
          ,le.clean_fax2_LEFTTRIM_ErrorCount,le.clean_fax2_ALLOW_ErrorCount,le.clean_fax2_LENGTH_ErrorCount,le.clean_fax2_WORDS_ErrorCount
          ,le.clean_fax3_LEFTTRIM_ErrorCount,le.clean_fax3_ALLOW_ErrorCount,le.clean_fax3_LENGTH_ErrorCount,le.clean_fax3_WORDS_ErrorCount
          ,le.clean_other_phone1_LEFTTRIM_ErrorCount,le.clean_other_phone1_ALLOW_ErrorCount,le.clean_other_phone1_LENGTH_ErrorCount,le.clean_other_phone1_WORDS_ErrorCount
          ,le.clean_dateofbirth_LEFTTRIM_ErrorCount,le.clean_dateofbirth_ALLOW_ErrorCount,le.clean_dateofbirth_LENGTH_ErrorCount,le.clean_dateofbirth_WORDS_ErrorCount
          ,le.clean_dateofdeath_LEFTTRIM_ErrorCount,le.clean_dateofdeath_ALLOW_ErrorCount,le.clean_dateofdeath_LENGTH_ErrorCount,le.clean_dateofdeath_WORDS_ErrorCount
          ,le.clean_company_name_LEFTTRIM_ErrorCount,le.clean_company_name_ALLOW_ErrorCount,le.clean_company_name_LENGTH_ErrorCount,le.clean_company_name_WORDS_ErrorCount
          ,le.clean_issue_date_LEFTTRIM_ErrorCount,le.clean_issue_date_ALLOW_ErrorCount,le.clean_issue_date_LENGTH_ErrorCount,le.clean_issue_date_WORDS_ErrorCount
          ,le.clean_expiration_date_LEFTTRIM_ErrorCount,le.clean_expiration_date_ALLOW_ErrorCount,le.clean_expiration_date_LENGTH_ErrorCount,le.clean_expiration_date_WORDS_ErrorCount
          ,le.clean_offense_date_LEFTTRIM_ErrorCount,le.clean_offense_date_ALLOW_ErrorCount,le.clean_offense_date_LENGTH_ErrorCount,le.clean_offense_date_WORDS_ErrorCount
          ,le.clean_action_date_LEFTTRIM_ErrorCount,le.clean_action_date_ALLOW_ErrorCount,le.clean_action_date_LENGTH_ErrorCount,le.clean_action_date_WORDS_ErrorCount
          ,le.src_LEFTTRIM_ErrorCount,le.src_ALLOW_ErrorCount,le.src_LENGTH_ErrorCount,le.src_WORDS_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount,le.zip_WORDS_ErrorCount
          ,le.zip4_LEFTTRIM_ErrorCount,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount,le.zip4_WORDS_ErrorCount
          ,le.bdid_LEFTTRIM_ErrorCount,le.bdid_ALLOW_ErrorCount,le.bdid_LENGTH_ErrorCount,le.bdid_WORDS_ErrorCount
          ,le.bdid_score_LEFTTRIM_ErrorCount,le.bdid_score_ALLOW_ErrorCount,le.bdid_score_LENGTH_ErrorCount,le.bdid_score_WORDS_ErrorCount
          ,le.lnpid_LEFTTRIM_ErrorCount,le.lnpid_ALLOW_ErrorCount,le.lnpid_LENGTH_ErrorCount,le.lnpid_WORDS_ErrorCount
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount,le.did_LENGTH_ErrorCount,le.did_WORDS_ErrorCount
          ,le.did_score_LEFTTRIM_ErrorCount,le.did_score_ALLOW_ErrorCount,le.did_score_LENGTH_ErrorCount,le.did_score_WORDS_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount,le.dt_vendor_first_reported_WORDS_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount,le.dt_vendor_last_reported_WORDS_ErrorCount
          ,le.in_state_LEFTTRIM_ErrorCount,le.in_state_ALLOW_ErrorCount,le.in_state_WORDS_ErrorCount
          ,le.in_class_LEFTTRIM_ErrorCount,le.in_class_ALLOW_ErrorCount,le.in_class_WORDS_ErrorCount
          ,le.in_status_LEFTTRIM_ErrorCount,le.in_status_ALLOW_ErrorCount,le.in_status_WORDS_ErrorCount
          ,le.in_qualifier1_LEFTTRIM_ErrorCount,le.in_qualifier1_ALLOW_ErrorCount,le.in_qualifier1_WORDS_ErrorCount
          ,le.in_qualifier2_LEFTTRIM_ErrorCount,le.in_qualifier2_ALLOW_ErrorCount,le.in_qualifier2_WORDS_ErrorCount
          ,le.mapped_class_LEFTTRIM_ErrorCount,le.mapped_class_ALLOW_ErrorCount,le.mapped_class_WORDS_ErrorCount
          ,le.mapped_status_LEFTTRIM_ErrorCount,le.mapped_status_ALLOW_ErrorCount,le.mapped_status_WORDS_ErrorCount
          ,le.mapped_qualifier1_LEFTTRIM_ErrorCount,le.mapped_qualifier1_ALLOW_ErrorCount,le.mapped_qualifier1_WORDS_ErrorCount
          ,le.mapped_qualifier2_LEFTTRIM_ErrorCount,le.mapped_qualifier2_ALLOW_ErrorCount,le.mapped_qualifier2_WORDS_ErrorCount
          ,le.mapped_pdma_LEFTTRIM_ErrorCount,le.mapped_pdma_ALLOW_ErrorCount,le.mapped_pdma_WORDS_ErrorCount
          ,le.mapped_pract_type_LEFTTRIM_ErrorCount,le.mapped_pract_type_ALLOW_ErrorCount,le.mapped_pract_type_WORDS_ErrorCount
          ,le.source_code_LEFTTRIM_ErrorCount,le.source_code_ALLOW_ErrorCount,le.source_code_WORDS_ErrorCount
          ,le.taxonomy_code_LEFTTRIM_ErrorCount,le.taxonomy_code_ALLOW_ErrorCount,le.taxonomy_code_WORDS_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.ln_key_LEFTTRIM_ErrorCount,le.ln_key_ALLOW_ErrorCount,le.ln_key_LENGTH_ErrorCount,le.ln_key_WORDS_ErrorCount
          ,le.hms_src_LEFTTRIM_ErrorCount,le.hms_src_ALLOW_ErrorCount,le.hms_src_LENGTH_ErrorCount,le.hms_src_WORDS_ErrorCount
          ,le.key_LEFTTRIM_ErrorCount,le.key_ALLOW_ErrorCount,le.key_LENGTH_ErrorCount,le.key_WORDS_ErrorCount
          ,le.id_LEFTTRIM_ErrorCount,le.id_ALLOW_ErrorCount,le.id_LENGTH_ErrorCount,le.id_WORDS_ErrorCount
          ,le.entityid_LEFTTRIM_ErrorCount,le.entityid_ALLOW_ErrorCount,le.entityid_LENGTH_ErrorCount,le.entityid_WORDS_ErrorCount
          ,le.license_number_LEFTTRIM_ErrorCount,le.license_number_ALLOW_ErrorCount,le.license_number_LENGTH_ErrorCount,le.license_number_WORDS_ErrorCount
          ,le.license_class_type_LEFTTRIM_ErrorCount,le.license_class_type_ALLOW_ErrorCount,le.license_class_type_LENGTH_ErrorCount,le.license_class_type_WORDS_ErrorCount
          ,le.license_state_LEFTTRIM_ErrorCount,le.license_state_ALLOW_ErrorCount,le.license_state_LENGTH_ErrorCount,le.license_state_WORDS_ErrorCount
          ,le.status_LEFTTRIM_ErrorCount,le.status_ALLOW_ErrorCount,le.status_LENGTH_ErrorCount,le.status_WORDS_ErrorCount
          ,le.issue_date_LEFTTRIM_ErrorCount,le.issue_date_ALLOW_ErrorCount,le.issue_date_LENGTH_ErrorCount,le.issue_date_WORDS_ErrorCount
          ,le.expiration_date_LEFTTRIM_ErrorCount,le.expiration_date_ALLOW_ErrorCount,le.expiration_date_LENGTH_ErrorCount,le.expiration_date_WORDS_ErrorCount
          ,le.qualifier1_LEFTTRIM_ErrorCount,le.qualifier1_ALLOW_ErrorCount,le.qualifier1_WORDS_ErrorCount
          ,le.qualifier2_LEFTTRIM_ErrorCount,le.qualifier2_ALLOW_ErrorCount,le.qualifier2_WORDS_ErrorCount
          ,le.qualifier3_LEFTTRIM_ErrorCount,le.qualifier3_ALLOW_ErrorCount,le.qualifier3_WORDS_ErrorCount
          ,le.qualifier4_LEFTTRIM_ErrorCount,le.qualifier4_ALLOW_ErrorCount,le.qualifier4_WORDS_ErrorCount
          ,le.qualifier5_LEFTTRIM_ErrorCount,le.qualifier5_ALLOW_ErrorCount,le.qualifier5_WORDS_ErrorCount
          ,le.rawclass_LEFTTRIM_ErrorCount,le.rawclass_ALLOW_ErrorCount,le.rawclass_LENGTH_ErrorCount,le.rawclass_WORDS_ErrorCount
          ,le.rawissue_date_LEFTTRIM_ErrorCount,le.rawissue_date_ALLOW_ErrorCount,le.rawissue_date_LENGTH_ErrorCount,le.rawissue_date_WORDS_ErrorCount
          ,le.rawexpiration_date_LEFTTRIM_ErrorCount,le.rawexpiration_date_ALLOW_ErrorCount,le.rawexpiration_date_LENGTH_ErrorCount,le.rawexpiration_date_WORDS_ErrorCount
          ,le.rawstatus_LEFTTRIM_ErrorCount,le.rawstatus_ALLOW_ErrorCount,le.rawstatus_LENGTH_ErrorCount,le.rawstatus_WORDS_ErrorCount
          ,le.raw_number_LEFTTRIM_ErrorCount,le.raw_number_ALLOW_ErrorCount,le.raw_number_LENGTH_ErrorCount,le.raw_number_WORDS_ErrorCount
          ,le.name_LEFTTRIM_ErrorCount,le.name_ALLOW_ErrorCount,le.name_WORDS_ErrorCount
          ,le.first_LEFTTRIM_ErrorCount,le.first_ALLOW_ErrorCount,le.first_WORDS_ErrorCount
          ,le.middle_LEFTTRIM_ErrorCount,le.middle_ALLOW_ErrorCount,le.middle_WORDS_ErrorCount
          ,le.last_LEFTTRIM_ErrorCount,le.last_ALLOW_ErrorCount,le.last_WORDS_ErrorCount
          ,le.suffix_LEFTTRIM_ErrorCount,le.suffix_ALLOW_ErrorCount,le.suffix_WORDS_ErrorCount
          ,le.cred_LEFTTRIM_ErrorCount,le.cred_ALLOW_ErrorCount,le.cred_WORDS_ErrorCount
          ,le.age_LEFTTRIM_ErrorCount,le.age_ALLOW_ErrorCount,le.age_LENGTH_ErrorCount,le.age_WORDS_ErrorCount
          ,le.dateofbirth_LEFTTRIM_ErrorCount,le.dateofbirth_ALLOW_ErrorCount,le.dateofbirth_LENGTH_ErrorCount,le.dateofbirth_WORDS_ErrorCount
          ,le.email_LEFTTRIM_ErrorCount,le.email_ALLOW_ErrorCount,le.email_LENGTH_ErrorCount,le.email_WORDS_ErrorCount
          ,le.gender_LEFTTRIM_ErrorCount,le.gender_ALLOW_ErrorCount,le.gender_LENGTH_ErrorCount,le.gender_WORDS_ErrorCount
          ,le.dateofdeath_LEFTTRIM_ErrorCount,le.dateofdeath_ALLOW_ErrorCount,le.dateofdeath_LENGTH_ErrorCount,le.dateofdeath_WORDS_ErrorCount
          ,le.firmname_LEFTTRIM_ErrorCount,le.firmname_ALLOW_ErrorCount,le.firmname_WORDS_ErrorCount
          ,le.street1_LEFTTRIM_ErrorCount,le.street1_ALLOW_ErrorCount,le.street1_WORDS_ErrorCount
          ,le.street2_LEFTTRIM_ErrorCount,le.street2_ALLOW_ErrorCount,le.street2_WORDS_ErrorCount
          ,le.street3_LEFTTRIM_ErrorCount,le.street3_ALLOW_ErrorCount,le.street3_WORDS_ErrorCount
          ,le.city_LEFTTRIM_ErrorCount,le.city_ALLOW_ErrorCount,le.city_WORDS_ErrorCount
          ,le.address_state_LEFTTRIM_ErrorCount,le.address_state_ALLOW_ErrorCount,le.address_state_LENGTH_ErrorCount,le.address_state_WORDS_ErrorCount
          ,le.orig_zip_LEFTTRIM_ErrorCount,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_LENGTH_ErrorCount,le.orig_zip_WORDS_ErrorCount
          ,le.orig_county_LEFTTRIM_ErrorCount,le.orig_county_ALLOW_ErrorCount,le.orig_county_WORDS_ErrorCount
          ,le.country_LEFTTRIM_ErrorCount,le.country_ALLOW_ErrorCount,le.country_WORDS_ErrorCount
          ,le.address_type_LEFTTRIM_ErrorCount,le.address_type_ALLOW_ErrorCount,le.address_type_WORDS_ErrorCount
          ,le.phone1_LEFTTRIM_ErrorCount,le.phone1_ALLOW_ErrorCount,le.phone1_LENGTH_ErrorCount,le.phone1_WORDS_ErrorCount
          ,le.phone2_LEFTTRIM_ErrorCount,le.phone2_ALLOW_ErrorCount,le.phone2_LENGTH_ErrorCount,le.phone2_WORDS_ErrorCount
          ,le.phone3_LEFTTRIM_ErrorCount,le.phone3_ALLOW_ErrorCount,le.phone3_LENGTH_ErrorCount,le.phone3_WORDS_ErrorCount
          ,le.fax1_LEFTTRIM_ErrorCount,le.fax1_ALLOW_ErrorCount,le.fax1_LENGTH_ErrorCount,le.fax1_WORDS_ErrorCount
          ,le.fax2_LEFTTRIM_ErrorCount,le.fax2_ALLOW_ErrorCount,le.fax2_LENGTH_ErrorCount,le.fax2_WORDS_ErrorCount
          ,le.fax3_LEFTTRIM_ErrorCount,le.fax3_ALLOW_ErrorCount,le.fax3_LENGTH_ErrorCount,le.fax3_WORDS_ErrorCount
          ,le.other_phone1_LEFTTRIM_ErrorCount,le.other_phone1_ALLOW_ErrorCount,le.other_phone1_LENGTH_ErrorCount,le.other_phone1_WORDS_ErrorCount
          ,le.description_LEFTTRIM_ErrorCount,le.description_ALLOW_ErrorCount,le.description_WORDS_ErrorCount
          ,le.specialty_class_type_LEFTTRIM_ErrorCount,le.specialty_class_type_ALLOW_ErrorCount,le.specialty_class_type_LENGTH_ErrorCount,le.specialty_class_type_WORDS_ErrorCount
          ,le.phone_number_LEFTTRIM_ErrorCount,le.phone_number_ALLOW_ErrorCount,le.phone_number_LENGTH_ErrorCount,le.phone_number_WORDS_ErrorCount
          ,le.phone_type_LEFTTRIM_ErrorCount,le.phone_type_ALLOW_ErrorCount,le.phone_type_LENGTH_ErrorCount,le.phone_type_WORDS_ErrorCount
          ,le.language_LEFTTRIM_ErrorCount,le.language_ALLOW_ErrorCount,le.language_WORDS_ErrorCount
          ,le.graduated_LEFTTRIM_ErrorCount,le.graduated_ALLOW_ErrorCount,le.graduated_WORDS_ErrorCount
          ,le.school_LEFTTRIM_ErrorCount,le.school_ALLOW_ErrorCount,le.school_WORDS_ErrorCount
          ,le.location_LEFTTRIM_ErrorCount,le.location_ALLOW_ErrorCount,le.location_WORDS_ErrorCount
          ,le.board_LEFTTRIM_ErrorCount,le.board_ALLOW_ErrorCount,le.board_WORDS_ErrorCount
          ,le.offense_LEFTTRIM_ErrorCount,le.offense_ALLOW_ErrorCount,le.offense_WORDS_ErrorCount
          ,le.offense_date_LEFTTRIM_ErrorCount,le.offense_date_ALLOW_ErrorCount,le.offense_date_LENGTH_ErrorCount,le.offense_date_WORDS_ErrorCount
          ,le.action_LEFTTRIM_ErrorCount,le.action_ALLOW_ErrorCount,le.action_LENGTH_ErrorCount,le.action_WORDS_ErrorCount
          ,le.action_date_LEFTTRIM_ErrorCount,le.action_date_ALLOW_ErrorCount,le.action_date_LENGTH_ErrorCount,le.action_date_WORDS_ErrorCount
          ,le.action_start_LEFTTRIM_ErrorCount,le.action_start_ALLOW_ErrorCount,le.action_start_LENGTH_ErrorCount,le.action_start_WORDS_ErrorCount
          ,le.action_end_LEFTTRIM_ErrorCount,le.action_end_ALLOW_ErrorCount,le.action_end_LENGTH_ErrorCount,le.action_end_WORDS_ErrorCount
          ,le.npi_number_LEFTTRIM_ErrorCount,le.npi_number_ALLOW_ErrorCount,le.npi_number_LENGTH_ErrorCount,le.npi_number_WORDS_ErrorCount
          ,le.csr_number_LEFTTRIM_ErrorCount,le.csr_number_ALLOW_ErrorCount,le.csr_number_LENGTH_ErrorCount,le.csr_number_WORDS_ErrorCount
          ,le.dea_number_LEFTTRIM_ErrorCount,le.dea_number_ALLOW_ErrorCount,le.dea_number_LENGTH_ErrorCount,le.dea_number_WORDS_ErrorCount
          ,le.prepped_addr1_LEFTTRIM_ErrorCount,le.prepped_addr1_ALLOW_ErrorCount,le.prepped_addr1_WORDS_ErrorCount
          ,le.prepped_addr2_LEFTTRIM_ErrorCount,le.prepped_addr2_ALLOW_ErrorCount,le.prepped_addr2_WORDS_ErrorCount
          ,le.clean_phone_LEFTTRIM_ErrorCount,le.clean_phone_ALLOW_ErrorCount,le.clean_phone_LENGTH_ErrorCount,le.clean_phone_WORDS_ErrorCount
          ,le.clean_phone1_LEFTTRIM_ErrorCount,le.clean_phone1_ALLOW_ErrorCount,le.clean_phone1_LENGTH_ErrorCount,le.clean_phone1_WORDS_ErrorCount
          ,le.clean_phone2_LEFTTRIM_ErrorCount,le.clean_phone2_ALLOW_ErrorCount,le.clean_phone2_LENGTH_ErrorCount,le.clean_phone2_WORDS_ErrorCount
          ,le.clean_phone3_LEFTTRIM_ErrorCount,le.clean_phone3_ALLOW_ErrorCount,le.clean_phone3_LENGTH_ErrorCount,le.clean_phone3_WORDS_ErrorCount
          ,le.clean_fax1_LEFTTRIM_ErrorCount,le.clean_fax1_ALLOW_ErrorCount,le.clean_fax1_LENGTH_ErrorCount,le.clean_fax1_WORDS_ErrorCount
          ,le.clean_fax2_LEFTTRIM_ErrorCount,le.clean_fax2_ALLOW_ErrorCount,le.clean_fax2_LENGTH_ErrorCount,le.clean_fax2_WORDS_ErrorCount
          ,le.clean_fax3_LEFTTRIM_ErrorCount,le.clean_fax3_ALLOW_ErrorCount,le.clean_fax3_LENGTH_ErrorCount,le.clean_fax3_WORDS_ErrorCount
          ,le.clean_other_phone1_LEFTTRIM_ErrorCount,le.clean_other_phone1_ALLOW_ErrorCount,le.clean_other_phone1_LENGTH_ErrorCount,le.clean_other_phone1_WORDS_ErrorCount
          ,le.clean_dateofbirth_LEFTTRIM_ErrorCount,le.clean_dateofbirth_ALLOW_ErrorCount,le.clean_dateofbirth_LENGTH_ErrorCount,le.clean_dateofbirth_WORDS_ErrorCount
          ,le.clean_dateofdeath_LEFTTRIM_ErrorCount,le.clean_dateofdeath_ALLOW_ErrorCount,le.clean_dateofdeath_LENGTH_ErrorCount,le.clean_dateofdeath_WORDS_ErrorCount
          ,le.clean_company_name_LEFTTRIM_ErrorCount,le.clean_company_name_ALLOW_ErrorCount,le.clean_company_name_LENGTH_ErrorCount,le.clean_company_name_WORDS_ErrorCount
          ,le.clean_issue_date_LEFTTRIM_ErrorCount,le.clean_issue_date_ALLOW_ErrorCount,le.clean_issue_date_LENGTH_ErrorCount,le.clean_issue_date_WORDS_ErrorCount
          ,le.clean_expiration_date_LEFTTRIM_ErrorCount,le.clean_expiration_date_ALLOW_ErrorCount,le.clean_expiration_date_LENGTH_ErrorCount,le.clean_expiration_date_WORDS_ErrorCount
          ,le.clean_offense_date_LEFTTRIM_ErrorCount,le.clean_offense_date_ALLOW_ErrorCount,le.clean_offense_date_LENGTH_ErrorCount,le.clean_offense_date_WORDS_ErrorCount
          ,le.clean_action_date_LEFTTRIM_ErrorCount,le.clean_action_date_ALLOW_ErrorCount,le.clean_action_date_LENGTH_ErrorCount,le.clean_action_date_WORDS_ErrorCount
          ,le.src_LEFTTRIM_ErrorCount,le.src_ALLOW_ErrorCount,le.src_LENGTH_ErrorCount,le.src_WORDS_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount,le.zip_WORDS_ErrorCount
          ,le.zip4_LEFTTRIM_ErrorCount,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount,le.zip4_WORDS_ErrorCount
          ,le.bdid_LEFTTRIM_ErrorCount,le.bdid_ALLOW_ErrorCount,le.bdid_LENGTH_ErrorCount,le.bdid_WORDS_ErrorCount
          ,le.bdid_score_LEFTTRIM_ErrorCount,le.bdid_score_ALLOW_ErrorCount,le.bdid_score_LENGTH_ErrorCount,le.bdid_score_WORDS_ErrorCount
          ,le.lnpid_LEFTTRIM_ErrorCount,le.lnpid_ALLOW_ErrorCount,le.lnpid_LENGTH_ErrorCount,le.lnpid_WORDS_ErrorCount
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount,le.did_LENGTH_ErrorCount,le.did_WORDS_ErrorCount
          ,le.did_score_LEFTTRIM_ErrorCount,le.did_score_ALLOW_ErrorCount,le.did_score_LENGTH_ErrorCount,le.did_score_WORDS_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount,le.dt_vendor_first_reported_WORDS_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount,le.dt_vendor_last_reported_WORDS_ErrorCount
          ,le.in_state_LEFTTRIM_ErrorCount,le.in_state_ALLOW_ErrorCount,le.in_state_WORDS_ErrorCount
          ,le.in_class_LEFTTRIM_ErrorCount,le.in_class_ALLOW_ErrorCount,le.in_class_WORDS_ErrorCount
          ,le.in_status_LEFTTRIM_ErrorCount,le.in_status_ALLOW_ErrorCount,le.in_status_WORDS_ErrorCount
          ,le.in_qualifier1_LEFTTRIM_ErrorCount,le.in_qualifier1_ALLOW_ErrorCount,le.in_qualifier1_WORDS_ErrorCount
          ,le.in_qualifier2_LEFTTRIM_ErrorCount,le.in_qualifier2_ALLOW_ErrorCount,le.in_qualifier2_WORDS_ErrorCount
          ,le.mapped_class_LEFTTRIM_ErrorCount,le.mapped_class_ALLOW_ErrorCount,le.mapped_class_WORDS_ErrorCount
          ,le.mapped_status_LEFTTRIM_ErrorCount,le.mapped_status_ALLOW_ErrorCount,le.mapped_status_WORDS_ErrorCount
          ,le.mapped_qualifier1_LEFTTRIM_ErrorCount,le.mapped_qualifier1_ALLOW_ErrorCount,le.mapped_qualifier1_WORDS_ErrorCount
          ,le.mapped_qualifier2_LEFTTRIM_ErrorCount,le.mapped_qualifier2_ALLOW_ErrorCount,le.mapped_qualifier2_WORDS_ErrorCount
          ,le.mapped_pdma_LEFTTRIM_ErrorCount,le.mapped_pdma_ALLOW_ErrorCount,le.mapped_pdma_WORDS_ErrorCount
          ,le.mapped_pract_type_LEFTTRIM_ErrorCount,le.mapped_pract_type_ALLOW_ErrorCount,le.mapped_pract_type_WORDS_ErrorCount
          ,le.source_code_LEFTTRIM_ErrorCount,le.source_code_ALLOW_ErrorCount,le.source_code_WORDS_ErrorCount
          ,le.taxonomy_code_LEFTTRIM_ErrorCount,le.taxonomy_code_ALLOW_ErrorCount,le.taxonomy_code_WORDS_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,387,Into(LEFT,COUNTER));
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

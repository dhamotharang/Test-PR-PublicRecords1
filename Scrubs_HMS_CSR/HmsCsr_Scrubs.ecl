IMPORT ut,SALT31;
EXPORT HmsCsr_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(HmsCsr_Layout_HmsCsr)
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
    UNSIGNED1 renewal_date_Invalid;
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
    UNSIGNED1 prefix_Invalid;
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
    UNSIGNED1 degree_Invalid;
    UNSIGNED1 graduated_Invalid;
    UNSIGNED1 school_Invalid;
    UNSIGNED1 location_Invalid;
    UNSIGNED1 fine_Invalid;
    UNSIGNED1 board_Invalid;
    UNSIGNED1 offense_Invalid;
    UNSIGNED1 offense_date_Invalid;
    UNSIGNED1 action_Invalid;
    UNSIGNED1 action_date_Invalid;
    UNSIGNED1 action_start_Invalid;
    UNSIGNED1 action_end_Invalid;
    UNSIGNED1 npi_number_Invalid;
    UNSIGNED1 replacement_number_Invalid;
    UNSIGNED1 enumeration_date_Invalid;
    UNSIGNED1 last_update_date_Invalid;
    UNSIGNED1 deactivation_date_Invalid;
    UNSIGNED1 reactivation_date_Invalid;
    UNSIGNED1 deactivation_reason_Invalid;
    UNSIGNED1 csr_number_Invalid;
    UNSIGNED1 credential_type_Invalid;
    UNSIGNED1 csr_status_Invalid;
    UNSIGNED1 sub_status_Invalid;
    UNSIGNED1 csr_state_Invalid;
    UNSIGNED1 csr_issue_date_Invalid;
    UNSIGNED1 effective_date_Invalid;
    UNSIGNED1 csr_expiration_date_Invalid;
    UNSIGNED1 discipline_Invalid;
    UNSIGNED1 all_schedules_Invalid;
    UNSIGNED1 dea_expiration_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(HmsCsr_Layout_HmsCsr)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
  END;
EXPORT FromNone(DATASET(HmsCsr_Layout_HmsCsr) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ln_key_Invalid := HmsCsr_Fields.InValid_ln_key((SALT31.StrType)le.ln_key);
    SELF.hms_src_Invalid := HmsCsr_Fields.InValid_hms_src((SALT31.StrType)le.hms_src);
    SELF.key_Invalid := HmsCsr_Fields.InValid_key((SALT31.StrType)le.key);
    SELF.id_Invalid := HmsCsr_Fields.InValid_id((SALT31.StrType)le.id);
    SELF.entityid_Invalid := HmsCsr_Fields.InValid_entityid((SALT31.StrType)le.entityid);
    SELF.license_number_Invalid := HmsCsr_Fields.InValid_license_number((SALT31.StrType)le.license_number);
    SELF.license_class_type_Invalid := HmsCsr_Fields.InValid_license_class_type((SALT31.StrType)le.license_class_type);
    SELF.license_state_Invalid := HmsCsr_Fields.InValid_license_state((SALT31.StrType)le.license_state);
    SELF.status_Invalid := HmsCsr_Fields.InValid_status((SALT31.StrType)le.status);
    SELF.issue_date_Invalid := HmsCsr_Fields.InValid_issue_date((SALT31.StrType)le.issue_date);
    SELF.renewal_date_Invalid := HmsCsr_Fields.InValid_renewal_date((SALT31.StrType)le.renewal_date);
    SELF.expiration_date_Invalid := HmsCsr_Fields.InValid_expiration_date((SALT31.StrType)le.expiration_date);
    SELF.qualifier1_Invalid := HmsCsr_Fields.InValid_qualifier1((SALT31.StrType)le.qualifier1);
    SELF.qualifier2_Invalid := HmsCsr_Fields.InValid_qualifier2((SALT31.StrType)le.qualifier2);
    SELF.qualifier3_Invalid := HmsCsr_Fields.InValid_qualifier3((SALT31.StrType)le.qualifier3);
    SELF.qualifier4_Invalid := HmsCsr_Fields.InValid_qualifier4((SALT31.StrType)le.qualifier4);
    SELF.qualifier5_Invalid := HmsCsr_Fields.InValid_qualifier5((SALT31.StrType)le.qualifier5);
    SELF.rawclass_Invalid := HmsCsr_Fields.InValid_rawclass((SALT31.StrType)le.rawclass);
    SELF.rawissue_date_Invalid := HmsCsr_Fields.InValid_rawissue_date((SALT31.StrType)le.rawissue_date);
    SELF.rawexpiration_date_Invalid := HmsCsr_Fields.InValid_rawexpiration_date((SALT31.StrType)le.rawexpiration_date);
    SELF.rawstatus_Invalid := HmsCsr_Fields.InValid_rawstatus((SALT31.StrType)le.rawstatus);
    SELF.raw_number_Invalid := HmsCsr_Fields.InValid_raw_number((SALT31.StrType)le.raw_number);
    SELF.name_Invalid := HmsCsr_Fields.InValid_name((SALT31.StrType)le.name);
    SELF.prefix_Invalid := HmsCsr_Fields.InValid_prefix((SALT31.StrType)le.prefix);
    SELF.first_Invalid := HmsCsr_Fields.InValid_first((SALT31.StrType)le.first);
    SELF.middle_Invalid := HmsCsr_Fields.InValid_middle((SALT31.StrType)le.middle);
    SELF.last_Invalid := HmsCsr_Fields.InValid_last((SALT31.StrType)le.last);
    SELF.suffix_Invalid := HmsCsr_Fields.InValid_suffix((SALT31.StrType)le.suffix);
    SELF.cred_Invalid := HmsCsr_Fields.InValid_cred((SALT31.StrType)le.cred);
    SELF.age_Invalid := HmsCsr_Fields.InValid_age((SALT31.StrType)le.age);
    SELF.dateofbirth_Invalid := HmsCsr_Fields.InValid_dateofbirth((SALT31.StrType)le.dateofbirth);
    SELF.email_Invalid := HmsCsr_Fields.InValid_email((SALT31.StrType)le.email);
    SELF.gender_Invalid := HmsCsr_Fields.InValid_gender((SALT31.StrType)le.gender);
    SELF.dateofdeath_Invalid := HmsCsr_Fields.InValid_dateofdeath((SALT31.StrType)le.dateofdeath);
    SELF.firmname_Invalid := HmsCsr_Fields.InValid_firmname((SALT31.StrType)le.firmname);
    SELF.street1_Invalid := HmsCsr_Fields.InValid_street1((SALT31.StrType)le.street1);
    SELF.street2_Invalid := HmsCsr_Fields.InValid_street2((SALT31.StrType)le.street2);
    SELF.street3_Invalid := HmsCsr_Fields.InValid_street3((SALT31.StrType)le.street3);
    SELF.city_Invalid := HmsCsr_Fields.InValid_city((SALT31.StrType)le.city);
    SELF.address_state_Invalid := HmsCsr_Fields.InValid_address_state((SALT31.StrType)le.address_state);
    SELF.orig_zip_Invalid := HmsCsr_Fields.InValid_orig_zip((SALT31.StrType)le.orig_zip);
    SELF.orig_county_Invalid := HmsCsr_Fields.InValid_orig_county((SALT31.StrType)le.orig_county);
    SELF.country_Invalid := HmsCsr_Fields.InValid_country((SALT31.StrType)le.country);
    SELF.address_type_Invalid := HmsCsr_Fields.InValid_address_type((SALT31.StrType)le.address_type);
    SELF.phone1_Invalid := HmsCsr_Fields.InValid_phone1((SALT31.StrType)le.phone1);
    SELF.phone2_Invalid := HmsCsr_Fields.InValid_phone2((SALT31.StrType)le.phone2);
    SELF.phone3_Invalid := HmsCsr_Fields.InValid_phone3((SALT31.StrType)le.phone3);
    SELF.fax1_Invalid := HmsCsr_Fields.InValid_fax1((SALT31.StrType)le.fax1);
    SELF.fax2_Invalid := HmsCsr_Fields.InValid_fax2((SALT31.StrType)le.fax2);
    SELF.fax3_Invalid := HmsCsr_Fields.InValid_fax3((SALT31.StrType)le.fax3);
    SELF.other_phone1_Invalid := HmsCsr_Fields.InValid_other_phone1((SALT31.StrType)le.other_phone1);
    SELF.description_Invalid := HmsCsr_Fields.InValid_description((SALT31.StrType)le.description);
    SELF.specialty_class_type_Invalid := HmsCsr_Fields.InValid_specialty_class_type((SALT31.StrType)le.specialty_class_type);
    SELF.phone_number_Invalid := HmsCsr_Fields.InValid_phone_number((SALT31.StrType)le.phone_number);
    SELF.phone_type_Invalid := HmsCsr_Fields.InValid_phone_type((SALT31.StrType)le.phone_type);
    SELF.language_Invalid := HmsCsr_Fields.InValid_language((SALT31.StrType)le.language);
    SELF.degree_Invalid := HmsCsr_Fields.InValid_degree((SALT31.StrType)le.degree);
    SELF.graduated_Invalid := HmsCsr_Fields.InValid_graduated((SALT31.StrType)le.graduated);
    SELF.school_Invalid := HmsCsr_Fields.InValid_school((SALT31.StrType)le.school);
    SELF.location_Invalid := HmsCsr_Fields.InValid_location((SALT31.StrType)le.location);
    SELF.fine_Invalid := HmsCsr_Fields.InValid_fine((SALT31.StrType)le.fine);
    SELF.board_Invalid := HmsCsr_Fields.InValid_board((SALT31.StrType)le.board);
    SELF.offense_Invalid := HmsCsr_Fields.InValid_offense((SALT31.StrType)le.offense);
    SELF.offense_date_Invalid := HmsCsr_Fields.InValid_offense_date((SALT31.StrType)le.offense_date);
    SELF.action_Invalid := HmsCsr_Fields.InValid_action((SALT31.StrType)le.action);
    SELF.action_date_Invalid := HmsCsr_Fields.InValid_action_date((SALT31.StrType)le.action_date);
    SELF.action_start_Invalid := HmsCsr_Fields.InValid_action_start((SALT31.StrType)le.action_start);
    SELF.action_end_Invalid := HmsCsr_Fields.InValid_action_end((SALT31.StrType)le.action_end);
    SELF.npi_number_Invalid := HmsCsr_Fields.InValid_npi_number((SALT31.StrType)le.npi_number);
    SELF.replacement_number_Invalid := HmsCsr_Fields.InValid_replacement_number((SALT31.StrType)le.replacement_number);
    SELF.enumeration_date_Invalid := HmsCsr_Fields.InValid_enumeration_date((SALT31.StrType)le.enumeration_date);
    SELF.last_update_date_Invalid := HmsCsr_Fields.InValid_last_update_date((SALT31.StrType)le.last_update_date);
    SELF.deactivation_date_Invalid := HmsCsr_Fields.InValid_deactivation_date((SALT31.StrType)le.deactivation_date);
    SELF.reactivation_date_Invalid := HmsCsr_Fields.InValid_reactivation_date((SALT31.StrType)le.reactivation_date);
    SELF.deactivation_reason_Invalid := HmsCsr_Fields.InValid_deactivation_reason((SALT31.StrType)le.deactivation_reason);
    SELF.csr_number_Invalid := HmsCsr_Fields.InValid_csr_number((SALT31.StrType)le.csr_number);
    SELF.credential_type_Invalid := HmsCsr_Fields.InValid_credential_type((SALT31.StrType)le.credential_type);
    SELF.csr_status_Invalid := HmsCsr_Fields.InValid_csr_status((SALT31.StrType)le.csr_status);
    SELF.sub_status_Invalid := HmsCsr_Fields.InValid_sub_status((SALT31.StrType)le.sub_status);
    SELF.csr_state_Invalid := HmsCsr_Fields.InValid_csr_state((SALT31.StrType)le.csr_state);
    SELF.csr_issue_date_Invalid := HmsCsr_Fields.InValid_csr_issue_date((SALT31.StrType)le.csr_issue_date);
    SELF.effective_date_Invalid := HmsCsr_Fields.InValid_effective_date((SALT31.StrType)le.effective_date);
    SELF.csr_expiration_date_Invalid := HmsCsr_Fields.InValid_csr_expiration_date((SALT31.StrType)le.csr_expiration_date);
    SELF.discipline_Invalid := HmsCsr_Fields.InValid_discipline((SALT31.StrType)le.discipline);
    SELF.all_schedules_Invalid := HmsCsr_Fields.InValid_all_schedules((SALT31.StrType)le.all_schedules);
    SELF.dea_expiration_date_Invalid := HmsCsr_Fields.InValid_dea_expiration_date((SALT31.StrType)le.dea_expiration_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ln_key_Invalid << 0 ) + ( le.hms_src_Invalid << 3 ) + ( le.key_Invalid << 6 ) + ( le.id_Invalid << 9 ) + ( le.entityid_Invalid << 12 ) + ( le.license_number_Invalid << 15 ) + ( le.license_class_type_Invalid << 18 ) + ( le.license_state_Invalid << 21 ) + ( le.status_Invalid << 24 ) + ( le.issue_date_Invalid << 27 ) + ( le.renewal_date_Invalid << 30 ) + ( le.expiration_date_Invalid << 33 ) + ( le.qualifier1_Invalid << 36 ) + ( le.qualifier2_Invalid << 38 ) + ( le.qualifier3_Invalid << 40 ) + ( le.qualifier4_Invalid << 42 ) + ( le.qualifier5_Invalid << 44 ) + ( le.rawclass_Invalid << 46 ) + ( le.rawissue_date_Invalid << 49 ) + ( le.rawexpiration_date_Invalid << 52 ) + ( le.rawstatus_Invalid << 55 ) + ( le.raw_number_Invalid << 58 ) + ( le.name_Invalid << 61 );
    SELF.ScrubsBits2 := ( le.prefix_Invalid << 0 ) + ( le.first_Invalid << 3 ) + ( le.middle_Invalid << 5 ) + ( le.last_Invalid << 7 ) + ( le.suffix_Invalid << 9 ) + ( le.cred_Invalid << 11 ) + ( le.age_Invalid << 13 ) + ( le.dateofbirth_Invalid << 16 ) + ( le.email_Invalid << 19 ) + ( le.gender_Invalid << 22 ) + ( le.dateofdeath_Invalid << 25 ) + ( le.firmname_Invalid << 28 ) + ( le.street1_Invalid << 30 ) + ( le.street2_Invalid << 32 ) + ( le.street3_Invalid << 34 ) + ( le.city_Invalid << 36 ) + ( le.address_state_Invalid << 38 ) + ( le.orig_zip_Invalid << 41 ) + ( le.orig_county_Invalid << 44 ) + ( le.country_Invalid << 46 ) + ( le.address_type_Invalid << 48 ) + ( le.phone1_Invalid << 50 ) + ( le.phone2_Invalid << 53 ) + ( le.phone3_Invalid << 56 ) + ( le.fax1_Invalid << 59 );
    SELF.ScrubsBits3 := ( le.fax2_Invalid << 0 ) + ( le.fax3_Invalid << 3 ) + ( le.other_phone1_Invalid << 6 ) + ( le.description_Invalid << 9 ) + ( le.specialty_class_type_Invalid << 12 ) + ( le.phone_number_Invalid << 15 ) + ( le.phone_type_Invalid << 18 ) + ( le.language_Invalid << 21 ) + ( le.degree_Invalid << 24 ) + ( le.graduated_Invalid << 27 ) + ( le.school_Invalid << 30 ) + ( le.location_Invalid << 33 ) + ( le.fine_Invalid << 36 ) + ( le.board_Invalid << 39 ) + ( le.offense_Invalid << 42 ) + ( le.offense_date_Invalid << 45 ) + ( le.action_Invalid << 48 ) + ( le.action_date_Invalid << 51 ) + ( le.action_start_Invalid << 54 ) + ( le.action_end_Invalid << 57 ) + ( le.npi_number_Invalid << 60 );
    SELF.ScrubsBits4 := ( le.replacement_number_Invalid << 0 ) + ( le.enumeration_date_Invalid << 3 ) + ( le.last_update_date_Invalid << 6 ) + ( le.deactivation_date_Invalid << 9 ) + ( le.reactivation_date_Invalid << 12 ) + ( le.deactivation_reason_Invalid << 15 ) + ( le.csr_number_Invalid << 18 ) + ( le.credential_type_Invalid << 21 ) + ( le.csr_status_Invalid << 24 ) + ( le.sub_status_Invalid << 27 ) + ( le.csr_state_Invalid << 30 ) + ( le.csr_issue_date_Invalid << 33 ) + ( le.effective_date_Invalid << 36 ) + ( le.csr_expiration_date_Invalid << 39 ) + ( le.discipline_Invalid << 42 ) + ( le.all_schedules_Invalid << 45 ) + ( le.dea_expiration_date_Invalid << 48 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,HmsCsr_Layout_HmsCsr);
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
    SELF.renewal_date_Invalid := (le.ScrubsBits1 >> 30) & 7;
    SELF.expiration_date_Invalid := (le.ScrubsBits1 >> 33) & 7;
    SELF.qualifier1_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.qualifier2_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.qualifier3_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.qualifier4_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.qualifier5_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.rawclass_Invalid := (le.ScrubsBits1 >> 46) & 7;
    SELF.rawissue_date_Invalid := (le.ScrubsBits1 >> 49) & 7;
    SELF.rawexpiration_date_Invalid := (le.ScrubsBits1 >> 52) & 7;
    SELF.rawstatus_Invalid := (le.ScrubsBits1 >> 55) & 7;
    SELF.raw_number_Invalid := (le.ScrubsBits1 >> 58) & 7;
    SELF.name_Invalid := (le.ScrubsBits1 >> 61) & 3;
    SELF.prefix_Invalid := (le.ScrubsBits2 >> 0) & 7;
    SELF.first_Invalid := (le.ScrubsBits2 >> 3) & 3;
    SELF.middle_Invalid := (le.ScrubsBits2 >> 5) & 3;
    SELF.last_Invalid := (le.ScrubsBits2 >> 7) & 3;
    SELF.suffix_Invalid := (le.ScrubsBits2 >> 9) & 3;
    SELF.cred_Invalid := (le.ScrubsBits2 >> 11) & 3;
    SELF.age_Invalid := (le.ScrubsBits2 >> 13) & 7;
    SELF.dateofbirth_Invalid := (le.ScrubsBits2 >> 16) & 7;
    SELF.email_Invalid := (le.ScrubsBits2 >> 19) & 7;
    SELF.gender_Invalid := (le.ScrubsBits2 >> 22) & 7;
    SELF.dateofdeath_Invalid := (le.ScrubsBits2 >> 25) & 7;
    SELF.firmname_Invalid := (le.ScrubsBits2 >> 28) & 3;
    SELF.street1_Invalid := (le.ScrubsBits2 >> 30) & 3;
    SELF.street2_Invalid := (le.ScrubsBits2 >> 32) & 3;
    SELF.street3_Invalid := (le.ScrubsBits2 >> 34) & 3;
    SELF.city_Invalid := (le.ScrubsBits2 >> 36) & 3;
    SELF.address_state_Invalid := (le.ScrubsBits2 >> 38) & 7;
    SELF.orig_zip_Invalid := (le.ScrubsBits2 >> 41) & 7;
    SELF.orig_county_Invalid := (le.ScrubsBits2 >> 44) & 3;
    SELF.country_Invalid := (le.ScrubsBits2 >> 46) & 3;
    SELF.address_type_Invalid := (le.ScrubsBits2 >> 48) & 3;
    SELF.phone1_Invalid := (le.ScrubsBits2 >> 50) & 7;
    SELF.phone2_Invalid := (le.ScrubsBits2 >> 53) & 7;
    SELF.phone3_Invalid := (le.ScrubsBits2 >> 56) & 7;
    SELF.fax1_Invalid := (le.ScrubsBits2 >> 59) & 7;
    SELF.fax2_Invalid := (le.ScrubsBits3 >> 0) & 7;
    SELF.fax3_Invalid := (le.ScrubsBits3 >> 3) & 7;
    SELF.other_phone1_Invalid := (le.ScrubsBits3 >> 6) & 7;
    SELF.description_Invalid := (le.ScrubsBits3 >> 9) & 7;
    SELF.specialty_class_type_Invalid := (le.ScrubsBits3 >> 12) & 7;
    SELF.phone_number_Invalid := (le.ScrubsBits3 >> 15) & 7;
    SELF.phone_type_Invalid := (le.ScrubsBits3 >> 18) & 7;
    SELF.language_Invalid := (le.ScrubsBits3 >> 21) & 7;
    SELF.degree_Invalid := (le.ScrubsBits3 >> 24) & 7;
    SELF.graduated_Invalid := (le.ScrubsBits3 >> 27) & 7;
    SELF.school_Invalid := (le.ScrubsBits3 >> 30) & 7;
    SELF.location_Invalid := (le.ScrubsBits3 >> 33) & 7;
    SELF.fine_Invalid := (le.ScrubsBits3 >> 36) & 7;
    SELF.board_Invalid := (le.ScrubsBits3 >> 39) & 7;
    SELF.offense_Invalid := (le.ScrubsBits3 >> 42) & 7;
    SELF.offense_date_Invalid := (le.ScrubsBits3 >> 45) & 7;
    SELF.action_Invalid := (le.ScrubsBits3 >> 48) & 7;
    SELF.action_date_Invalid := (le.ScrubsBits3 >> 51) & 7;
    SELF.action_start_Invalid := (le.ScrubsBits3 >> 54) & 7;
    SELF.action_end_Invalid := (le.ScrubsBits3 >> 57) & 7;
    SELF.npi_number_Invalid := (le.ScrubsBits3 >> 60) & 7;
    SELF.replacement_number_Invalid := (le.ScrubsBits4 >> 0) & 7;
    SELF.enumeration_date_Invalid := (le.ScrubsBits4 >> 3) & 7;
    SELF.last_update_date_Invalid := (le.ScrubsBits4 >> 6) & 7;
    SELF.deactivation_date_Invalid := (le.ScrubsBits4 >> 9) & 7;
    SELF.reactivation_date_Invalid := (le.ScrubsBits4 >> 12) & 7;
    SELF.deactivation_reason_Invalid := (le.ScrubsBits4 >> 15) & 7;
    SELF.csr_number_Invalid := (le.ScrubsBits4 >> 18) & 7;
    SELF.credential_type_Invalid := (le.ScrubsBits4 >> 21) & 7;
    SELF.csr_status_Invalid := (le.ScrubsBits4 >> 24) & 7;
    SELF.sub_status_Invalid := (le.ScrubsBits4 >> 27) & 7;
    SELF.csr_state_Invalid := (le.ScrubsBits4 >> 30) & 7;
    SELF.csr_issue_date_Invalid := (le.ScrubsBits4 >> 33) & 7;
    SELF.effective_date_Invalid := (le.ScrubsBits4 >> 36) & 7;
    SELF.csr_expiration_date_Invalid := (le.ScrubsBits4 >> 39) & 7;
    SELF.discipline_Invalid := (le.ScrubsBits4 >> 42) & 7;
    SELF.all_schedules_Invalid := (le.ScrubsBits4 >> 45) & 7;
    SELF.dea_expiration_date_Invalid := (le.ScrubsBits4 >> 48) & 7;
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
    renewal_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.renewal_date_Invalid=1);
    renewal_date_ALLOW_ErrorCount := COUNT(GROUP,h.renewal_date_Invalid=2);
    renewal_date_LENGTH_ErrorCount := COUNT(GROUP,h.renewal_date_Invalid=3);
    renewal_date_WORDS_ErrorCount := COUNT(GROUP,h.renewal_date_Invalid=4);
    renewal_date_Total_ErrorCount := COUNT(GROUP,h.renewal_date_Invalid>0);
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
    prefix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prefix_Invalid=1);
    prefix_ALLOW_ErrorCount := COUNT(GROUP,h.prefix_Invalid=2);
    prefix_LENGTH_ErrorCount := COUNT(GROUP,h.prefix_Invalid=3);
    prefix_WORDS_ErrorCount := COUNT(GROUP,h.prefix_Invalid=4);
    prefix_Total_ErrorCount := COUNT(GROUP,h.prefix_Invalid>0);
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
    description_LENGTH_ErrorCount := COUNT(GROUP,h.description_Invalid=3);
    description_WORDS_ErrorCount := COUNT(GROUP,h.description_Invalid=4);
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
    language_LENGTH_ErrorCount := COUNT(GROUP,h.language_Invalid=3);
    language_WORDS_ErrorCount := COUNT(GROUP,h.language_Invalid=4);
    language_Total_ErrorCount := COUNT(GROUP,h.language_Invalid>0);
    degree_LEFTTRIM_ErrorCount := COUNT(GROUP,h.degree_Invalid=1);
    degree_ALLOW_ErrorCount := COUNT(GROUP,h.degree_Invalid=2);
    degree_LENGTH_ErrorCount := COUNT(GROUP,h.degree_Invalid=3);
    degree_WORDS_ErrorCount := COUNT(GROUP,h.degree_Invalid=4);
    degree_Total_ErrorCount := COUNT(GROUP,h.degree_Invalid>0);
    graduated_LEFTTRIM_ErrorCount := COUNT(GROUP,h.graduated_Invalid=1);
    graduated_ALLOW_ErrorCount := COUNT(GROUP,h.graduated_Invalid=2);
    graduated_LENGTH_ErrorCount := COUNT(GROUP,h.graduated_Invalid=3);
    graduated_WORDS_ErrorCount := COUNT(GROUP,h.graduated_Invalid=4);
    graduated_Total_ErrorCount := COUNT(GROUP,h.graduated_Invalid>0);
    school_LEFTTRIM_ErrorCount := COUNT(GROUP,h.school_Invalid=1);
    school_ALLOW_ErrorCount := COUNT(GROUP,h.school_Invalid=2);
    school_LENGTH_ErrorCount := COUNT(GROUP,h.school_Invalid=3);
    school_WORDS_ErrorCount := COUNT(GROUP,h.school_Invalid=4);
    school_Total_ErrorCount := COUNT(GROUP,h.school_Invalid>0);
    location_LEFTTRIM_ErrorCount := COUNT(GROUP,h.location_Invalid=1);
    location_ALLOW_ErrorCount := COUNT(GROUP,h.location_Invalid=2);
    location_LENGTH_ErrorCount := COUNT(GROUP,h.location_Invalid=3);
    location_WORDS_ErrorCount := COUNT(GROUP,h.location_Invalid=4);
    location_Total_ErrorCount := COUNT(GROUP,h.location_Invalid>0);
    fine_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fine_Invalid=1);
    fine_ALLOW_ErrorCount := COUNT(GROUP,h.fine_Invalid=2);
    fine_LENGTH_ErrorCount := COUNT(GROUP,h.fine_Invalid=3);
    fine_WORDS_ErrorCount := COUNT(GROUP,h.fine_Invalid=4);
    fine_Total_ErrorCount := COUNT(GROUP,h.fine_Invalid>0);
    board_LEFTTRIM_ErrorCount := COUNT(GROUP,h.board_Invalid=1);
    board_ALLOW_ErrorCount := COUNT(GROUP,h.board_Invalid=2);
    board_LENGTH_ErrorCount := COUNT(GROUP,h.board_Invalid=3);
    board_WORDS_ErrorCount := COUNT(GROUP,h.board_Invalid=4);
    board_Total_ErrorCount := COUNT(GROUP,h.board_Invalid>0);
    offense_LEFTTRIM_ErrorCount := COUNT(GROUP,h.offense_Invalid=1);
    offense_ALLOW_ErrorCount := COUNT(GROUP,h.offense_Invalid=2);
    offense_LENGTH_ErrorCount := COUNT(GROUP,h.offense_Invalid=3);
    offense_WORDS_ErrorCount := COUNT(GROUP,h.offense_Invalid=4);
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
    replacement_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.replacement_number_Invalid=1);
    replacement_number_ALLOW_ErrorCount := COUNT(GROUP,h.replacement_number_Invalid=2);
    replacement_number_LENGTH_ErrorCount := COUNT(GROUP,h.replacement_number_Invalid=3);
    replacement_number_WORDS_ErrorCount := COUNT(GROUP,h.replacement_number_Invalid=4);
    replacement_number_Total_ErrorCount := COUNT(GROUP,h.replacement_number_Invalid>0);
    enumeration_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.enumeration_date_Invalid=1);
    enumeration_date_ALLOW_ErrorCount := COUNT(GROUP,h.enumeration_date_Invalid=2);
    enumeration_date_LENGTH_ErrorCount := COUNT(GROUP,h.enumeration_date_Invalid=3);
    enumeration_date_WORDS_ErrorCount := COUNT(GROUP,h.enumeration_date_Invalid=4);
    enumeration_date_Total_ErrorCount := COUNT(GROUP,h.enumeration_date_Invalid>0);
    last_update_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.last_update_date_Invalid=1);
    last_update_date_ALLOW_ErrorCount := COUNT(GROUP,h.last_update_date_Invalid=2);
    last_update_date_LENGTH_ErrorCount := COUNT(GROUP,h.last_update_date_Invalid=3);
    last_update_date_WORDS_ErrorCount := COUNT(GROUP,h.last_update_date_Invalid=4);
    last_update_date_Total_ErrorCount := COUNT(GROUP,h.last_update_date_Invalid>0);
    deactivation_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.deactivation_date_Invalid=1);
    deactivation_date_ALLOW_ErrorCount := COUNT(GROUP,h.deactivation_date_Invalid=2);
    deactivation_date_LENGTH_ErrorCount := COUNT(GROUP,h.deactivation_date_Invalid=3);
    deactivation_date_WORDS_ErrorCount := COUNT(GROUP,h.deactivation_date_Invalid=4);
    deactivation_date_Total_ErrorCount := COUNT(GROUP,h.deactivation_date_Invalid>0);
    reactivation_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.reactivation_date_Invalid=1);
    reactivation_date_ALLOW_ErrorCount := COUNT(GROUP,h.reactivation_date_Invalid=2);
    reactivation_date_LENGTH_ErrorCount := COUNT(GROUP,h.reactivation_date_Invalid=3);
    reactivation_date_WORDS_ErrorCount := COUNT(GROUP,h.reactivation_date_Invalid=4);
    reactivation_date_Total_ErrorCount := COUNT(GROUP,h.reactivation_date_Invalid>0);
    deactivation_reason_LEFTTRIM_ErrorCount := COUNT(GROUP,h.deactivation_reason_Invalid=1);
    deactivation_reason_ALLOW_ErrorCount := COUNT(GROUP,h.deactivation_reason_Invalid=2);
    deactivation_reason_LENGTH_ErrorCount := COUNT(GROUP,h.deactivation_reason_Invalid=3);
    deactivation_reason_WORDS_ErrorCount := COUNT(GROUP,h.deactivation_reason_Invalid=4);
    deactivation_reason_Total_ErrorCount := COUNT(GROUP,h.deactivation_reason_Invalid>0);
    csr_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.csr_number_Invalid=1);
    csr_number_ALLOW_ErrorCount := COUNT(GROUP,h.csr_number_Invalid=2);
    csr_number_LENGTH_ErrorCount := COUNT(GROUP,h.csr_number_Invalid=3);
    csr_number_WORDS_ErrorCount := COUNT(GROUP,h.csr_number_Invalid=4);
    csr_number_Total_ErrorCount := COUNT(GROUP,h.csr_number_Invalid>0);
    credential_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.credential_type_Invalid=1);
    credential_type_ALLOW_ErrorCount := COUNT(GROUP,h.credential_type_Invalid=2);
    credential_type_LENGTH_ErrorCount := COUNT(GROUP,h.credential_type_Invalid=3);
    credential_type_WORDS_ErrorCount := COUNT(GROUP,h.credential_type_Invalid=4);
    credential_type_Total_ErrorCount := COUNT(GROUP,h.credential_type_Invalid>0);
    csr_status_LEFTTRIM_ErrorCount := COUNT(GROUP,h.csr_status_Invalid=1);
    csr_status_ALLOW_ErrorCount := COUNT(GROUP,h.csr_status_Invalid=2);
    csr_status_LENGTH_ErrorCount := COUNT(GROUP,h.csr_status_Invalid=3);
    csr_status_WORDS_ErrorCount := COUNT(GROUP,h.csr_status_Invalid=4);
    csr_status_Total_ErrorCount := COUNT(GROUP,h.csr_status_Invalid>0);
    sub_status_LEFTTRIM_ErrorCount := COUNT(GROUP,h.sub_status_Invalid=1);
    sub_status_ALLOW_ErrorCount := COUNT(GROUP,h.sub_status_Invalid=2);
    sub_status_LENGTH_ErrorCount := COUNT(GROUP,h.sub_status_Invalid=3);
    sub_status_WORDS_ErrorCount := COUNT(GROUP,h.sub_status_Invalid=4);
    sub_status_Total_ErrorCount := COUNT(GROUP,h.sub_status_Invalid>0);
    csr_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.csr_state_Invalid=1);
    csr_state_ALLOW_ErrorCount := COUNT(GROUP,h.csr_state_Invalid=2);
    csr_state_LENGTH_ErrorCount := COUNT(GROUP,h.csr_state_Invalid=3);
    csr_state_WORDS_ErrorCount := COUNT(GROUP,h.csr_state_Invalid=4);
    csr_state_Total_ErrorCount := COUNT(GROUP,h.csr_state_Invalid>0);
    csr_issue_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.csr_issue_date_Invalid=1);
    csr_issue_date_ALLOW_ErrorCount := COUNT(GROUP,h.csr_issue_date_Invalid=2);
    csr_issue_date_LENGTH_ErrorCount := COUNT(GROUP,h.csr_issue_date_Invalid=3);
    csr_issue_date_WORDS_ErrorCount := COUNT(GROUP,h.csr_issue_date_Invalid=4);
    csr_issue_date_Total_ErrorCount := COUNT(GROUP,h.csr_issue_date_Invalid>0);
    effective_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.effective_date_Invalid=1);
    effective_date_ALLOW_ErrorCount := COUNT(GROUP,h.effective_date_Invalid=2);
    effective_date_LENGTH_ErrorCount := COUNT(GROUP,h.effective_date_Invalid=3);
    effective_date_WORDS_ErrorCount := COUNT(GROUP,h.effective_date_Invalid=4);
    effective_date_Total_ErrorCount := COUNT(GROUP,h.effective_date_Invalid>0);
    csr_expiration_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.csr_expiration_date_Invalid=1);
    csr_expiration_date_ALLOW_ErrorCount := COUNT(GROUP,h.csr_expiration_date_Invalid=2);
    csr_expiration_date_LENGTH_ErrorCount := COUNT(GROUP,h.csr_expiration_date_Invalid=3);
    csr_expiration_date_WORDS_ErrorCount := COUNT(GROUP,h.csr_expiration_date_Invalid=4);
    csr_expiration_date_Total_ErrorCount := COUNT(GROUP,h.csr_expiration_date_Invalid>0);
    discipline_LEFTTRIM_ErrorCount := COUNT(GROUP,h.discipline_Invalid=1);
    discipline_ALLOW_ErrorCount := COUNT(GROUP,h.discipline_Invalid=2);
    discipline_LENGTH_ErrorCount := COUNT(GROUP,h.discipline_Invalid=3);
    discipline_WORDS_ErrorCount := COUNT(GROUP,h.discipline_Invalid=4);
    discipline_Total_ErrorCount := COUNT(GROUP,h.discipline_Invalid>0);
    all_schedules_LEFTTRIM_ErrorCount := COUNT(GROUP,h.all_schedules_Invalid=1);
    all_schedules_ALLOW_ErrorCount := COUNT(GROUP,h.all_schedules_Invalid=2);
    all_schedules_LENGTH_ErrorCount := COUNT(GROUP,h.all_schedules_Invalid=3);
    all_schedules_WORDS_ErrorCount := COUNT(GROUP,h.all_schedules_Invalid=4);
    all_schedules_Total_ErrorCount := COUNT(GROUP,h.all_schedules_Invalid>0);
    dea_expiration_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dea_expiration_date_Invalid=1);
    dea_expiration_date_ALLOW_ErrorCount := COUNT(GROUP,h.dea_expiration_date_Invalid=2);
    dea_expiration_date_LENGTH_ErrorCount := COUNT(GROUP,h.dea_expiration_date_Invalid=3);
    dea_expiration_date_WORDS_ErrorCount := COUNT(GROUP,h.dea_expiration_date_Invalid=4);
    dea_expiration_date_Total_ErrorCount := COUNT(GROUP,h.dea_expiration_date_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ln_key_Invalid,le.hms_src_Invalid,le.key_Invalid,le.id_Invalid,le.entityid_Invalid,le.license_number_Invalid,le.license_class_type_Invalid,le.license_state_Invalid,le.status_Invalid,le.issue_date_Invalid,le.renewal_date_Invalid,le.expiration_date_Invalid,le.qualifier1_Invalid,le.qualifier2_Invalid,le.qualifier3_Invalid,le.qualifier4_Invalid,le.qualifier5_Invalid,le.rawclass_Invalid,le.rawissue_date_Invalid,le.rawexpiration_date_Invalid,le.rawstatus_Invalid,le.raw_number_Invalid,le.name_Invalid,le.prefix_Invalid,le.first_Invalid,le.middle_Invalid,le.last_Invalid,le.suffix_Invalid,le.cred_Invalid,le.age_Invalid,le.dateofbirth_Invalid,le.email_Invalid,le.gender_Invalid,le.dateofdeath_Invalid,le.firmname_Invalid,le.street1_Invalid,le.street2_Invalid,le.street3_Invalid,le.city_Invalid,le.address_state_Invalid,le.orig_zip_Invalid,le.orig_county_Invalid,le.country_Invalid,le.address_type_Invalid,le.phone1_Invalid,le.phone2_Invalid,le.phone3_Invalid,le.fax1_Invalid,le.fax2_Invalid,le.fax3_Invalid,le.other_phone1_Invalid,le.description_Invalid,le.specialty_class_type_Invalid,le.phone_number_Invalid,le.phone_type_Invalid,le.language_Invalid,le.degree_Invalid,le.graduated_Invalid,le.school_Invalid,le.location_Invalid,le.fine_Invalid,le.board_Invalid,le.offense_Invalid,le.offense_date_Invalid,le.action_Invalid,le.action_date_Invalid,le.action_start_Invalid,le.action_end_Invalid,le.npi_number_Invalid,le.replacement_number_Invalid,le.enumeration_date_Invalid,le.last_update_date_Invalid,le.deactivation_date_Invalid,le.reactivation_date_Invalid,le.deactivation_reason_Invalid,le.csr_number_Invalid,le.credential_type_Invalid,le.csr_status_Invalid,le.sub_status_Invalid,le.csr_state_Invalid,le.csr_issue_date_Invalid,le.effective_date_Invalid,le.csr_expiration_date_Invalid,le.discipline_Invalid,le.all_schedules_Invalid,le.dea_expiration_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,HmsCsr_Fields.InvalidMessage_ln_key(le.ln_key_Invalid),HmsCsr_Fields.InvalidMessage_hms_src(le.hms_src_Invalid),HmsCsr_Fields.InvalidMessage_key(le.key_Invalid),HmsCsr_Fields.InvalidMessage_id(le.id_Invalid),HmsCsr_Fields.InvalidMessage_entityid(le.entityid_Invalid),HmsCsr_Fields.InvalidMessage_license_number(le.license_number_Invalid),HmsCsr_Fields.InvalidMessage_license_class_type(le.license_class_type_Invalid),HmsCsr_Fields.InvalidMessage_license_state(le.license_state_Invalid),HmsCsr_Fields.InvalidMessage_status(le.status_Invalid),HmsCsr_Fields.InvalidMessage_issue_date(le.issue_date_Invalid),HmsCsr_Fields.InvalidMessage_renewal_date(le.renewal_date_Invalid),HmsCsr_Fields.InvalidMessage_expiration_date(le.expiration_date_Invalid),HmsCsr_Fields.InvalidMessage_qualifier1(le.qualifier1_Invalid),HmsCsr_Fields.InvalidMessage_qualifier2(le.qualifier2_Invalid),HmsCsr_Fields.InvalidMessage_qualifier3(le.qualifier3_Invalid),HmsCsr_Fields.InvalidMessage_qualifier4(le.qualifier4_Invalid),HmsCsr_Fields.InvalidMessage_qualifier5(le.qualifier5_Invalid),HmsCsr_Fields.InvalidMessage_rawclass(le.rawclass_Invalid),HmsCsr_Fields.InvalidMessage_rawissue_date(le.rawissue_date_Invalid),HmsCsr_Fields.InvalidMessage_rawexpiration_date(le.rawexpiration_date_Invalid),HmsCsr_Fields.InvalidMessage_rawstatus(le.rawstatus_Invalid),HmsCsr_Fields.InvalidMessage_raw_number(le.raw_number_Invalid),HmsCsr_Fields.InvalidMessage_name(le.name_Invalid),HmsCsr_Fields.InvalidMessage_prefix(le.prefix_Invalid),HmsCsr_Fields.InvalidMessage_first(le.first_Invalid),HmsCsr_Fields.InvalidMessage_middle(le.middle_Invalid),HmsCsr_Fields.InvalidMessage_last(le.last_Invalid),HmsCsr_Fields.InvalidMessage_suffix(le.suffix_Invalid),HmsCsr_Fields.InvalidMessage_cred(le.cred_Invalid),HmsCsr_Fields.InvalidMessage_age(le.age_Invalid),HmsCsr_Fields.InvalidMessage_dateofbirth(le.dateofbirth_Invalid),HmsCsr_Fields.InvalidMessage_email(le.email_Invalid),HmsCsr_Fields.InvalidMessage_gender(le.gender_Invalid),HmsCsr_Fields.InvalidMessage_dateofdeath(le.dateofdeath_Invalid),HmsCsr_Fields.InvalidMessage_firmname(le.firmname_Invalid),HmsCsr_Fields.InvalidMessage_street1(le.street1_Invalid),HmsCsr_Fields.InvalidMessage_street2(le.street2_Invalid),HmsCsr_Fields.InvalidMessage_street3(le.street3_Invalid),HmsCsr_Fields.InvalidMessage_city(le.city_Invalid),HmsCsr_Fields.InvalidMessage_address_state(le.address_state_Invalid),HmsCsr_Fields.InvalidMessage_orig_zip(le.orig_zip_Invalid),HmsCsr_Fields.InvalidMessage_orig_county(le.orig_county_Invalid),HmsCsr_Fields.InvalidMessage_country(le.country_Invalid),HmsCsr_Fields.InvalidMessage_address_type(le.address_type_Invalid),HmsCsr_Fields.InvalidMessage_phone1(le.phone1_Invalid),HmsCsr_Fields.InvalidMessage_phone2(le.phone2_Invalid),HmsCsr_Fields.InvalidMessage_phone3(le.phone3_Invalid),HmsCsr_Fields.InvalidMessage_fax1(le.fax1_Invalid),HmsCsr_Fields.InvalidMessage_fax2(le.fax2_Invalid),HmsCsr_Fields.InvalidMessage_fax3(le.fax3_Invalid),HmsCsr_Fields.InvalidMessage_other_phone1(le.other_phone1_Invalid),HmsCsr_Fields.InvalidMessage_description(le.description_Invalid),HmsCsr_Fields.InvalidMessage_specialty_class_type(le.specialty_class_type_Invalid),HmsCsr_Fields.InvalidMessage_phone_number(le.phone_number_Invalid),HmsCsr_Fields.InvalidMessage_phone_type(le.phone_type_Invalid),HmsCsr_Fields.InvalidMessage_language(le.language_Invalid),HmsCsr_Fields.InvalidMessage_degree(le.degree_Invalid),HmsCsr_Fields.InvalidMessage_graduated(le.graduated_Invalid),HmsCsr_Fields.InvalidMessage_school(le.school_Invalid),HmsCsr_Fields.InvalidMessage_location(le.location_Invalid),HmsCsr_Fields.InvalidMessage_fine(le.fine_Invalid),HmsCsr_Fields.InvalidMessage_board(le.board_Invalid),HmsCsr_Fields.InvalidMessage_offense(le.offense_Invalid),HmsCsr_Fields.InvalidMessage_offense_date(le.offense_date_Invalid),HmsCsr_Fields.InvalidMessage_action(le.action_Invalid),HmsCsr_Fields.InvalidMessage_action_date(le.action_date_Invalid),HmsCsr_Fields.InvalidMessage_action_start(le.action_start_Invalid),HmsCsr_Fields.InvalidMessage_action_end(le.action_end_Invalid),HmsCsr_Fields.InvalidMessage_npi_number(le.npi_number_Invalid),HmsCsr_Fields.InvalidMessage_replacement_number(le.replacement_number_Invalid),HmsCsr_Fields.InvalidMessage_enumeration_date(le.enumeration_date_Invalid),HmsCsr_Fields.InvalidMessage_last_update_date(le.last_update_date_Invalid),HmsCsr_Fields.InvalidMessage_deactivation_date(le.deactivation_date_Invalid),HmsCsr_Fields.InvalidMessage_reactivation_date(le.reactivation_date_Invalid),HmsCsr_Fields.InvalidMessage_deactivation_reason(le.deactivation_reason_Invalid),HmsCsr_Fields.InvalidMessage_csr_number(le.csr_number_Invalid),HmsCsr_Fields.InvalidMessage_credential_type(le.credential_type_Invalid),HmsCsr_Fields.InvalidMessage_csr_status(le.csr_status_Invalid),HmsCsr_Fields.InvalidMessage_sub_status(le.sub_status_Invalid),HmsCsr_Fields.InvalidMessage_csr_state(le.csr_state_Invalid),HmsCsr_Fields.InvalidMessage_csr_issue_date(le.csr_issue_date_Invalid),HmsCsr_Fields.InvalidMessage_effective_date(le.effective_date_Invalid),HmsCsr_Fields.InvalidMessage_csr_expiration_date(le.csr_expiration_date_Invalid),HmsCsr_Fields.InvalidMessage_discipline(le.discipline_Invalid),HmsCsr_Fields.InvalidMessage_all_schedules(le.all_schedules_Invalid),HmsCsr_Fields.InvalidMessage_dea_expiration_date(le.dea_expiration_date_Invalid),'UNKNOWN'));
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
          ,CHOOSE(le.renewal_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
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
          ,CHOOSE(le.prefix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
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
          ,CHOOSE(le.description_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.specialty_class_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phone_number_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phone_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.language_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.degree_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.graduated_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.school_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.location_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.fine_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.board_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.offense_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.offense_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.action_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.action_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.action_start_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.action_end_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.npi_number_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.replacement_number_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.enumeration_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.last_update_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.deactivation_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.reactivation_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.deactivation_reason_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.csr_number_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.credential_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.csr_status_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.sub_status_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.csr_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.csr_issue_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.effective_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.csr_expiration_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.discipline_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.all_schedules_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dea_expiration_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ln_key','hms_src','key','id','entityid','license_number','license_class_type','license_state','status','issue_date','renewal_date','expiration_date','qualifier1','qualifier2','qualifier3','qualifier4','qualifier5','rawclass','rawissue_date','rawexpiration_date','rawstatus','raw_number','name','prefix','first','middle','last','suffix','cred','age','dateofbirth','email','gender','dateofdeath','firmname','street1','street2','street3','city','address_state','orig_zip','orig_county','country','address_type','phone1','phone2','phone3','fax1','fax2','fax3','other_phone1','description','specialty_class_type','phone_number','phone_type','language','degree','graduated','school','location','fine','board','offense','offense_date','action','action_date','action_start','action_end','npi_number','replacement_number','enumeration_date','last_update_date','deactivation_date','reactivation_date','deactivation_reason','csr_number','credential_type','csr_status','sub_status','csr_state','csr_issue_date','effective_date','csr_expiration_date','discipline','all_schedules','dea_expiration_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'ln_key','hms_src','key','id','entityid','license_number','license_class_type','license_state','status','issue_date','renewal_date','expiration_date','qualifier1','qualifier2','qualifier3','qualifier4','qualifier5','rawclass','rawissue_date','rawexpiration_date','rawstatus','raw_number','name','prefix','first','middle','last','suffix','cred','age','dateofbirth','email','gender','dateofdeath','firmname','street1','street2','street3','city','address_state','orig_zip','orig_county','country','address_type','phone1','phone2','phone3','fax1','fax2','fax3','other_phone1','description','specialty_class_type','phone_number','phone_type','language','degree','graduated','school','location','fine','board','offense','offense_date','action','action_date','action_start','action_end','npi_number','replacement_number','enumeration_date','last_update_date','deactivation_date','reactivation_date','deactivation_reason','csr_number','credential_type','csr_status','sub_status','csr_state','csr_issue_date','effective_date','csr_expiration_date','discipline','all_schedules','dea_expiration_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.ln_key,(SALT31.StrType)le.hms_src,(SALT31.StrType)le.key,(SALT31.StrType)le.id,(SALT31.StrType)le.entityid,(SALT31.StrType)le.license_number,(SALT31.StrType)le.license_class_type,(SALT31.StrType)le.license_state,(SALT31.StrType)le.status,(SALT31.StrType)le.issue_date,(SALT31.StrType)le.renewal_date,(SALT31.StrType)le.expiration_date,(SALT31.StrType)le.qualifier1,(SALT31.StrType)le.qualifier2,(SALT31.StrType)le.qualifier3,(SALT31.StrType)le.qualifier4,(SALT31.StrType)le.qualifier5,(SALT31.StrType)le.rawclass,(SALT31.StrType)le.rawissue_date,(SALT31.StrType)le.rawexpiration_date,(SALT31.StrType)le.rawstatus,(SALT31.StrType)le.raw_number,(SALT31.StrType)le.name,(SALT31.StrType)le.prefix,(SALT31.StrType)le.first,(SALT31.StrType)le.middle,(SALT31.StrType)le.last,(SALT31.StrType)le.suffix,(SALT31.StrType)le.cred,(SALT31.StrType)le.age,(SALT31.StrType)le.dateofbirth,(SALT31.StrType)le.email,(SALT31.StrType)le.gender,(SALT31.StrType)le.dateofdeath,(SALT31.StrType)le.firmname,(SALT31.StrType)le.street1,(SALT31.StrType)le.street2,(SALT31.StrType)le.street3,(SALT31.StrType)le.city,(SALT31.StrType)le.address_state,(SALT31.StrType)le.orig_zip,(SALT31.StrType)le.orig_county,(SALT31.StrType)le.country,(SALT31.StrType)le.address_type,(SALT31.StrType)le.phone1,(SALT31.StrType)le.phone2,(SALT31.StrType)le.phone3,(SALT31.StrType)le.fax1,(SALT31.StrType)le.fax2,(SALT31.StrType)le.fax3,(SALT31.StrType)le.other_phone1,(SALT31.StrType)le.description,(SALT31.StrType)le.specialty_class_type,(SALT31.StrType)le.phone_number,(SALT31.StrType)le.phone_type,(SALT31.StrType)le.language,(SALT31.StrType)le.degree,(SALT31.StrType)le.graduated,(SALT31.StrType)le.school,(SALT31.StrType)le.location,(SALT31.StrType)le.fine,(SALT31.StrType)le.board,(SALT31.StrType)le.offense,(SALT31.StrType)le.offense_date,(SALT31.StrType)le.action,(SALT31.StrType)le.action_date,(SALT31.StrType)le.action_start,(SALT31.StrType)le.action_end,(SALT31.StrType)le.npi_number,(SALT31.StrType)le.replacement_number,(SALT31.StrType)le.enumeration_date,(SALT31.StrType)le.last_update_date,(SALT31.StrType)le.deactivation_date,(SALT31.StrType)le.reactivation_date,(SALT31.StrType)le.deactivation_reason,(SALT31.StrType)le.csr_number,(SALT31.StrType)le.credential_type,(SALT31.StrType)le.csr_status,(SALT31.StrType)le.sub_status,(SALT31.StrType)le.csr_state,(SALT31.StrType)le.csr_issue_date,(SALT31.StrType)le.effective_date,(SALT31.StrType)le.csr_expiration_date,(SALT31.StrType)le.discipline,(SALT31.StrType)le.all_schedules,(SALT31.StrType)le.dea_expiration_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,86,Into(LEFT,COUNTER));
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
          ,'renewal_date:renewal_date:LEFTTRIM','renewal_date:renewal_date:ALLOW','renewal_date:renewal_date:LENGTH','renewal_date:renewal_date:WORDS'
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
          ,'prefix:prefix:LEFTTRIM','prefix:prefix:ALLOW','prefix:prefix:LENGTH','prefix:prefix:WORDS'
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
          ,'description:description:LEFTTRIM','description:description:ALLOW','description:description:LENGTH','description:description:WORDS'
          ,'specialty_class_type:specialty_class_type:LEFTTRIM','specialty_class_type:specialty_class_type:ALLOW','specialty_class_type:specialty_class_type:LENGTH','specialty_class_type:specialty_class_type:WORDS'
          ,'phone_number:phone_number:LEFTTRIM','phone_number:phone_number:ALLOW','phone_number:phone_number:LENGTH','phone_number:phone_number:WORDS'
          ,'phone_type:phone_type:LEFTTRIM','phone_type:phone_type:ALLOW','phone_type:phone_type:LENGTH','phone_type:phone_type:WORDS'
          ,'language:language:LEFTTRIM','language:language:ALLOW','language:language:LENGTH','language:language:WORDS'
          ,'degree:degree:LEFTTRIM','degree:degree:ALLOW','degree:degree:LENGTH','degree:degree:WORDS'
          ,'graduated:graduated:LEFTTRIM','graduated:graduated:ALLOW','graduated:graduated:LENGTH','graduated:graduated:WORDS'
          ,'school:school:LEFTTRIM','school:school:ALLOW','school:school:LENGTH','school:school:WORDS'
          ,'location:location:LEFTTRIM','location:location:ALLOW','location:location:LENGTH','location:location:WORDS'
          ,'fine:fine:LEFTTRIM','fine:fine:ALLOW','fine:fine:LENGTH','fine:fine:WORDS'
          ,'board:board:LEFTTRIM','board:board:ALLOW','board:board:LENGTH','board:board:WORDS'
          ,'offense:offense:LEFTTRIM','offense:offense:ALLOW','offense:offense:LENGTH','offense:offense:WORDS'
          ,'offense_date:offense_date:LEFTTRIM','offense_date:offense_date:ALLOW','offense_date:offense_date:LENGTH','offense_date:offense_date:WORDS'
          ,'action:action:LEFTTRIM','action:action:ALLOW','action:action:LENGTH','action:action:WORDS'
          ,'action_date:action_date:LEFTTRIM','action_date:action_date:ALLOW','action_date:action_date:LENGTH','action_date:action_date:WORDS'
          ,'action_start:action_start:LEFTTRIM','action_start:action_start:ALLOW','action_start:action_start:LENGTH','action_start:action_start:WORDS'
          ,'action_end:action_end:LEFTTRIM','action_end:action_end:ALLOW','action_end:action_end:LENGTH','action_end:action_end:WORDS'
          ,'npi_number:npi_number:LEFTTRIM','npi_number:npi_number:ALLOW','npi_number:npi_number:LENGTH','npi_number:npi_number:WORDS'
          ,'replacement_number:replacement_number:LEFTTRIM','replacement_number:replacement_number:ALLOW','replacement_number:replacement_number:LENGTH','replacement_number:replacement_number:WORDS'
          ,'enumeration_date:enumeration_date:LEFTTRIM','enumeration_date:enumeration_date:ALLOW','enumeration_date:enumeration_date:LENGTH','enumeration_date:enumeration_date:WORDS'
          ,'last_update_date:last_update_date:LEFTTRIM','last_update_date:last_update_date:ALLOW','last_update_date:last_update_date:LENGTH','last_update_date:last_update_date:WORDS'
          ,'deactivation_date:deactivation_date:LEFTTRIM','deactivation_date:deactivation_date:ALLOW','deactivation_date:deactivation_date:LENGTH','deactivation_date:deactivation_date:WORDS'
          ,'reactivation_date:reactivation_date:LEFTTRIM','reactivation_date:reactivation_date:ALLOW','reactivation_date:reactivation_date:LENGTH','reactivation_date:reactivation_date:WORDS'
          ,'deactivation_reason:deactivation_reason:LEFTTRIM','deactivation_reason:deactivation_reason:ALLOW','deactivation_reason:deactivation_reason:LENGTH','deactivation_reason:deactivation_reason:WORDS'
          ,'csr_number:csr_number:LEFTTRIM','csr_number:csr_number:ALLOW','csr_number:csr_number:LENGTH','csr_number:csr_number:WORDS'
          ,'credential_type:credential_type:LEFTTRIM','credential_type:credential_type:ALLOW','credential_type:credential_type:LENGTH','credential_type:credential_type:WORDS'
          ,'csr_status:csr_status:LEFTTRIM','csr_status:csr_status:ALLOW','csr_status:csr_status:LENGTH','csr_status:csr_status:WORDS'
          ,'sub_status:sub_status:LEFTTRIM','sub_status:sub_status:ALLOW','sub_status:sub_status:LENGTH','sub_status:sub_status:WORDS'
          ,'csr_state:csr_state:LEFTTRIM','csr_state:csr_state:ALLOW','csr_state:csr_state:LENGTH','csr_state:csr_state:WORDS'
          ,'csr_issue_date:csr_issue_date:LEFTTRIM','csr_issue_date:csr_issue_date:ALLOW','csr_issue_date:csr_issue_date:LENGTH','csr_issue_date:csr_issue_date:WORDS'
          ,'effective_date:effective_date:LEFTTRIM','effective_date:effective_date:ALLOW','effective_date:effective_date:LENGTH','effective_date:effective_date:WORDS'
          ,'csr_expiration_date:csr_expiration_date:LEFTTRIM','csr_expiration_date:csr_expiration_date:ALLOW','csr_expiration_date:csr_expiration_date:LENGTH','csr_expiration_date:csr_expiration_date:WORDS'
          ,'discipline:discipline:LEFTTRIM','discipline:discipline:ALLOW','discipline:discipline:LENGTH','discipline:discipline:WORDS'
          ,'all_schedules:all_schedules:LEFTTRIM','all_schedules:all_schedules:ALLOW','all_schedules:all_schedules:LENGTH','all_schedules:all_schedules:WORDS'
          ,'dea_expiration_date:dea_expiration_date:LEFTTRIM','dea_expiration_date:dea_expiration_date:ALLOW','dea_expiration_date:dea_expiration_date:LENGTH','dea_expiration_date:dea_expiration_date:WORDS','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,HmsCsr_Fields.InvalidMessage_ln_key(1),HmsCsr_Fields.InvalidMessage_ln_key(2),HmsCsr_Fields.InvalidMessage_ln_key(3),HmsCsr_Fields.InvalidMessage_ln_key(4)
          ,HmsCsr_Fields.InvalidMessage_hms_src(1),HmsCsr_Fields.InvalidMessage_hms_src(2),HmsCsr_Fields.InvalidMessage_hms_src(3),HmsCsr_Fields.InvalidMessage_hms_src(4)
          ,HmsCsr_Fields.InvalidMessage_key(1),HmsCsr_Fields.InvalidMessage_key(2),HmsCsr_Fields.InvalidMessage_key(3),HmsCsr_Fields.InvalidMessage_key(4)
          ,HmsCsr_Fields.InvalidMessage_id(1),HmsCsr_Fields.InvalidMessage_id(2),HmsCsr_Fields.InvalidMessage_id(3),HmsCsr_Fields.InvalidMessage_id(4)
          ,HmsCsr_Fields.InvalidMessage_entityid(1),HmsCsr_Fields.InvalidMessage_entityid(2),HmsCsr_Fields.InvalidMessage_entityid(3),HmsCsr_Fields.InvalidMessage_entityid(4)
          ,HmsCsr_Fields.InvalidMessage_license_number(1),HmsCsr_Fields.InvalidMessage_license_number(2),HmsCsr_Fields.InvalidMessage_license_number(3),HmsCsr_Fields.InvalidMessage_license_number(4)
          ,HmsCsr_Fields.InvalidMessage_license_class_type(1),HmsCsr_Fields.InvalidMessage_license_class_type(2),HmsCsr_Fields.InvalidMessage_license_class_type(3),HmsCsr_Fields.InvalidMessage_license_class_type(4)
          ,HmsCsr_Fields.InvalidMessage_license_state(1),HmsCsr_Fields.InvalidMessage_license_state(2),HmsCsr_Fields.InvalidMessage_license_state(3),HmsCsr_Fields.InvalidMessage_license_state(4)
          ,HmsCsr_Fields.InvalidMessage_status(1),HmsCsr_Fields.InvalidMessage_status(2),HmsCsr_Fields.InvalidMessage_status(3),HmsCsr_Fields.InvalidMessage_status(4)
          ,HmsCsr_Fields.InvalidMessage_issue_date(1),HmsCsr_Fields.InvalidMessage_issue_date(2),HmsCsr_Fields.InvalidMessage_issue_date(3),HmsCsr_Fields.InvalidMessage_issue_date(4)
          ,HmsCsr_Fields.InvalidMessage_renewal_date(1),HmsCsr_Fields.InvalidMessage_renewal_date(2),HmsCsr_Fields.InvalidMessage_renewal_date(3),HmsCsr_Fields.InvalidMessage_renewal_date(4)
          ,HmsCsr_Fields.InvalidMessage_expiration_date(1),HmsCsr_Fields.InvalidMessage_expiration_date(2),HmsCsr_Fields.InvalidMessage_expiration_date(3),HmsCsr_Fields.InvalidMessage_expiration_date(4)
          ,HmsCsr_Fields.InvalidMessage_qualifier1(1),HmsCsr_Fields.InvalidMessage_qualifier1(2),HmsCsr_Fields.InvalidMessage_qualifier1(3)
          ,HmsCsr_Fields.InvalidMessage_qualifier2(1),HmsCsr_Fields.InvalidMessage_qualifier2(2),HmsCsr_Fields.InvalidMessage_qualifier2(3)
          ,HmsCsr_Fields.InvalidMessage_qualifier3(1),HmsCsr_Fields.InvalidMessage_qualifier3(2),HmsCsr_Fields.InvalidMessage_qualifier3(3)
          ,HmsCsr_Fields.InvalidMessage_qualifier4(1),HmsCsr_Fields.InvalidMessage_qualifier4(2),HmsCsr_Fields.InvalidMessage_qualifier4(3)
          ,HmsCsr_Fields.InvalidMessage_qualifier5(1),HmsCsr_Fields.InvalidMessage_qualifier5(2),HmsCsr_Fields.InvalidMessage_qualifier5(3)
          ,HmsCsr_Fields.InvalidMessage_rawclass(1),HmsCsr_Fields.InvalidMessage_rawclass(2),HmsCsr_Fields.InvalidMessage_rawclass(3),HmsCsr_Fields.InvalidMessage_rawclass(4)
          ,HmsCsr_Fields.InvalidMessage_rawissue_date(1),HmsCsr_Fields.InvalidMessage_rawissue_date(2),HmsCsr_Fields.InvalidMessage_rawissue_date(3),HmsCsr_Fields.InvalidMessage_rawissue_date(4)
          ,HmsCsr_Fields.InvalidMessage_rawexpiration_date(1),HmsCsr_Fields.InvalidMessage_rawexpiration_date(2),HmsCsr_Fields.InvalidMessage_rawexpiration_date(3),HmsCsr_Fields.InvalidMessage_rawexpiration_date(4)
          ,HmsCsr_Fields.InvalidMessage_rawstatus(1),HmsCsr_Fields.InvalidMessage_rawstatus(2),HmsCsr_Fields.InvalidMessage_rawstatus(3),HmsCsr_Fields.InvalidMessage_rawstatus(4)
          ,HmsCsr_Fields.InvalidMessage_raw_number(1),HmsCsr_Fields.InvalidMessage_raw_number(2),HmsCsr_Fields.InvalidMessage_raw_number(3),HmsCsr_Fields.InvalidMessage_raw_number(4)
          ,HmsCsr_Fields.InvalidMessage_name(1),HmsCsr_Fields.InvalidMessage_name(2),HmsCsr_Fields.InvalidMessage_name(3)
          ,HmsCsr_Fields.InvalidMessage_prefix(1),HmsCsr_Fields.InvalidMessage_prefix(2),HmsCsr_Fields.InvalidMessage_prefix(3),HmsCsr_Fields.InvalidMessage_prefix(4)
          ,HmsCsr_Fields.InvalidMessage_first(1),HmsCsr_Fields.InvalidMessage_first(2),HmsCsr_Fields.InvalidMessage_first(3)
          ,HmsCsr_Fields.InvalidMessage_middle(1),HmsCsr_Fields.InvalidMessage_middle(2),HmsCsr_Fields.InvalidMessage_middle(3)
          ,HmsCsr_Fields.InvalidMessage_last(1),HmsCsr_Fields.InvalidMessage_last(2),HmsCsr_Fields.InvalidMessage_last(3)
          ,HmsCsr_Fields.InvalidMessage_suffix(1),HmsCsr_Fields.InvalidMessage_suffix(2),HmsCsr_Fields.InvalidMessage_suffix(3)
          ,HmsCsr_Fields.InvalidMessage_cred(1),HmsCsr_Fields.InvalidMessage_cred(2),HmsCsr_Fields.InvalidMessage_cred(3)
          ,HmsCsr_Fields.InvalidMessage_age(1),HmsCsr_Fields.InvalidMessage_age(2),HmsCsr_Fields.InvalidMessage_age(3),HmsCsr_Fields.InvalidMessage_age(4)
          ,HmsCsr_Fields.InvalidMessage_dateofbirth(1),HmsCsr_Fields.InvalidMessage_dateofbirth(2),HmsCsr_Fields.InvalidMessage_dateofbirth(3),HmsCsr_Fields.InvalidMessage_dateofbirth(4)
          ,HmsCsr_Fields.InvalidMessage_email(1),HmsCsr_Fields.InvalidMessage_email(2),HmsCsr_Fields.InvalidMessage_email(3),HmsCsr_Fields.InvalidMessage_email(4)
          ,HmsCsr_Fields.InvalidMessage_gender(1),HmsCsr_Fields.InvalidMessage_gender(2),HmsCsr_Fields.InvalidMessage_gender(3),HmsCsr_Fields.InvalidMessage_gender(4)
          ,HmsCsr_Fields.InvalidMessage_dateofdeath(1),HmsCsr_Fields.InvalidMessage_dateofdeath(2),HmsCsr_Fields.InvalidMessage_dateofdeath(3),HmsCsr_Fields.InvalidMessage_dateofdeath(4)
          ,HmsCsr_Fields.InvalidMessage_firmname(1),HmsCsr_Fields.InvalidMessage_firmname(2),HmsCsr_Fields.InvalidMessage_firmname(3)
          ,HmsCsr_Fields.InvalidMessage_street1(1),HmsCsr_Fields.InvalidMessage_street1(2),HmsCsr_Fields.InvalidMessage_street1(3)
          ,HmsCsr_Fields.InvalidMessage_street2(1),HmsCsr_Fields.InvalidMessage_street2(2),HmsCsr_Fields.InvalidMessage_street2(3)
          ,HmsCsr_Fields.InvalidMessage_street3(1),HmsCsr_Fields.InvalidMessage_street3(2),HmsCsr_Fields.InvalidMessage_street3(3)
          ,HmsCsr_Fields.InvalidMessage_city(1),HmsCsr_Fields.InvalidMessage_city(2),HmsCsr_Fields.InvalidMessage_city(3)
          ,HmsCsr_Fields.InvalidMessage_address_state(1),HmsCsr_Fields.InvalidMessage_address_state(2),HmsCsr_Fields.InvalidMessage_address_state(3),HmsCsr_Fields.InvalidMessage_address_state(4)
          ,HmsCsr_Fields.InvalidMessage_orig_zip(1),HmsCsr_Fields.InvalidMessage_orig_zip(2),HmsCsr_Fields.InvalidMessage_orig_zip(3),HmsCsr_Fields.InvalidMessage_orig_zip(4)
          ,HmsCsr_Fields.InvalidMessage_orig_county(1),HmsCsr_Fields.InvalidMessage_orig_county(2),HmsCsr_Fields.InvalidMessage_orig_county(3)
          ,HmsCsr_Fields.InvalidMessage_country(1),HmsCsr_Fields.InvalidMessage_country(2),HmsCsr_Fields.InvalidMessage_country(3)
          ,HmsCsr_Fields.InvalidMessage_address_type(1),HmsCsr_Fields.InvalidMessage_address_type(2),HmsCsr_Fields.InvalidMessage_address_type(3)
          ,HmsCsr_Fields.InvalidMessage_phone1(1),HmsCsr_Fields.InvalidMessage_phone1(2),HmsCsr_Fields.InvalidMessage_phone1(3),HmsCsr_Fields.InvalidMessage_phone1(4)
          ,HmsCsr_Fields.InvalidMessage_phone2(1),HmsCsr_Fields.InvalidMessage_phone2(2),HmsCsr_Fields.InvalidMessage_phone2(3),HmsCsr_Fields.InvalidMessage_phone2(4)
          ,HmsCsr_Fields.InvalidMessage_phone3(1),HmsCsr_Fields.InvalidMessage_phone3(2),HmsCsr_Fields.InvalidMessage_phone3(3),HmsCsr_Fields.InvalidMessage_phone3(4)
          ,HmsCsr_Fields.InvalidMessage_fax1(1),HmsCsr_Fields.InvalidMessage_fax1(2),HmsCsr_Fields.InvalidMessage_fax1(3),HmsCsr_Fields.InvalidMessage_fax1(4)
          ,HmsCsr_Fields.InvalidMessage_fax2(1),HmsCsr_Fields.InvalidMessage_fax2(2),HmsCsr_Fields.InvalidMessage_fax2(3),HmsCsr_Fields.InvalidMessage_fax2(4)
          ,HmsCsr_Fields.InvalidMessage_fax3(1),HmsCsr_Fields.InvalidMessage_fax3(2),HmsCsr_Fields.InvalidMessage_fax3(3),HmsCsr_Fields.InvalidMessage_fax3(4)
          ,HmsCsr_Fields.InvalidMessage_other_phone1(1),HmsCsr_Fields.InvalidMessage_other_phone1(2),HmsCsr_Fields.InvalidMessage_other_phone1(3),HmsCsr_Fields.InvalidMessage_other_phone1(4)
          ,HmsCsr_Fields.InvalidMessage_description(1),HmsCsr_Fields.InvalidMessage_description(2),HmsCsr_Fields.InvalidMessage_description(3),HmsCsr_Fields.InvalidMessage_description(4)
          ,HmsCsr_Fields.InvalidMessage_specialty_class_type(1),HmsCsr_Fields.InvalidMessage_specialty_class_type(2),HmsCsr_Fields.InvalidMessage_specialty_class_type(3),HmsCsr_Fields.InvalidMessage_specialty_class_type(4)
          ,HmsCsr_Fields.InvalidMessage_phone_number(1),HmsCsr_Fields.InvalidMessage_phone_number(2),HmsCsr_Fields.InvalidMessage_phone_number(3),HmsCsr_Fields.InvalidMessage_phone_number(4)
          ,HmsCsr_Fields.InvalidMessage_phone_type(1),HmsCsr_Fields.InvalidMessage_phone_type(2),HmsCsr_Fields.InvalidMessage_phone_type(3),HmsCsr_Fields.InvalidMessage_phone_type(4)
          ,HmsCsr_Fields.InvalidMessage_language(1),HmsCsr_Fields.InvalidMessage_language(2),HmsCsr_Fields.InvalidMessage_language(3),HmsCsr_Fields.InvalidMessage_language(4)
          ,HmsCsr_Fields.InvalidMessage_degree(1),HmsCsr_Fields.InvalidMessage_degree(2),HmsCsr_Fields.InvalidMessage_degree(3),HmsCsr_Fields.InvalidMessage_degree(4)
          ,HmsCsr_Fields.InvalidMessage_graduated(1),HmsCsr_Fields.InvalidMessage_graduated(2),HmsCsr_Fields.InvalidMessage_graduated(3),HmsCsr_Fields.InvalidMessage_graduated(4)
          ,HmsCsr_Fields.InvalidMessage_school(1),HmsCsr_Fields.InvalidMessage_school(2),HmsCsr_Fields.InvalidMessage_school(3),HmsCsr_Fields.InvalidMessage_school(4)
          ,HmsCsr_Fields.InvalidMessage_location(1),HmsCsr_Fields.InvalidMessage_location(2),HmsCsr_Fields.InvalidMessage_location(3),HmsCsr_Fields.InvalidMessage_location(4)
          ,HmsCsr_Fields.InvalidMessage_fine(1),HmsCsr_Fields.InvalidMessage_fine(2),HmsCsr_Fields.InvalidMessage_fine(3),HmsCsr_Fields.InvalidMessage_fine(4)
          ,HmsCsr_Fields.InvalidMessage_board(1),HmsCsr_Fields.InvalidMessage_board(2),HmsCsr_Fields.InvalidMessage_board(3),HmsCsr_Fields.InvalidMessage_board(4)
          ,HmsCsr_Fields.InvalidMessage_offense(1),HmsCsr_Fields.InvalidMessage_offense(2),HmsCsr_Fields.InvalidMessage_offense(3),HmsCsr_Fields.InvalidMessage_offense(4)
          ,HmsCsr_Fields.InvalidMessage_offense_date(1),HmsCsr_Fields.InvalidMessage_offense_date(2),HmsCsr_Fields.InvalidMessage_offense_date(3),HmsCsr_Fields.InvalidMessage_offense_date(4)
          ,HmsCsr_Fields.InvalidMessage_action(1),HmsCsr_Fields.InvalidMessage_action(2),HmsCsr_Fields.InvalidMessage_action(3),HmsCsr_Fields.InvalidMessage_action(4)
          ,HmsCsr_Fields.InvalidMessage_action_date(1),HmsCsr_Fields.InvalidMessage_action_date(2),HmsCsr_Fields.InvalidMessage_action_date(3),HmsCsr_Fields.InvalidMessage_action_date(4)
          ,HmsCsr_Fields.InvalidMessage_action_start(1),HmsCsr_Fields.InvalidMessage_action_start(2),HmsCsr_Fields.InvalidMessage_action_start(3),HmsCsr_Fields.InvalidMessage_action_start(4)
          ,HmsCsr_Fields.InvalidMessage_action_end(1),HmsCsr_Fields.InvalidMessage_action_end(2),HmsCsr_Fields.InvalidMessage_action_end(3),HmsCsr_Fields.InvalidMessage_action_end(4)
          ,HmsCsr_Fields.InvalidMessage_npi_number(1),HmsCsr_Fields.InvalidMessage_npi_number(2),HmsCsr_Fields.InvalidMessage_npi_number(3),HmsCsr_Fields.InvalidMessage_npi_number(4)
          ,HmsCsr_Fields.InvalidMessage_replacement_number(1),HmsCsr_Fields.InvalidMessage_replacement_number(2),HmsCsr_Fields.InvalidMessage_replacement_number(3),HmsCsr_Fields.InvalidMessage_replacement_number(4)
          ,HmsCsr_Fields.InvalidMessage_enumeration_date(1),HmsCsr_Fields.InvalidMessage_enumeration_date(2),HmsCsr_Fields.InvalidMessage_enumeration_date(3),HmsCsr_Fields.InvalidMessage_enumeration_date(4)
          ,HmsCsr_Fields.InvalidMessage_last_update_date(1),HmsCsr_Fields.InvalidMessage_last_update_date(2),HmsCsr_Fields.InvalidMessage_last_update_date(3),HmsCsr_Fields.InvalidMessage_last_update_date(4)
          ,HmsCsr_Fields.InvalidMessage_deactivation_date(1),HmsCsr_Fields.InvalidMessage_deactivation_date(2),HmsCsr_Fields.InvalidMessage_deactivation_date(3),HmsCsr_Fields.InvalidMessage_deactivation_date(4)
          ,HmsCsr_Fields.InvalidMessage_reactivation_date(1),HmsCsr_Fields.InvalidMessage_reactivation_date(2),HmsCsr_Fields.InvalidMessage_reactivation_date(3),HmsCsr_Fields.InvalidMessage_reactivation_date(4)
          ,HmsCsr_Fields.InvalidMessage_deactivation_reason(1),HmsCsr_Fields.InvalidMessage_deactivation_reason(2),HmsCsr_Fields.InvalidMessage_deactivation_reason(3),HmsCsr_Fields.InvalidMessage_deactivation_reason(4)
          ,HmsCsr_Fields.InvalidMessage_csr_number(1),HmsCsr_Fields.InvalidMessage_csr_number(2),HmsCsr_Fields.InvalidMessage_csr_number(3),HmsCsr_Fields.InvalidMessage_csr_number(4)
          ,HmsCsr_Fields.InvalidMessage_credential_type(1),HmsCsr_Fields.InvalidMessage_credential_type(2),HmsCsr_Fields.InvalidMessage_credential_type(3),HmsCsr_Fields.InvalidMessage_credential_type(4)
          ,HmsCsr_Fields.InvalidMessage_csr_status(1),HmsCsr_Fields.InvalidMessage_csr_status(2),HmsCsr_Fields.InvalidMessage_csr_status(3),HmsCsr_Fields.InvalidMessage_csr_status(4)
          ,HmsCsr_Fields.InvalidMessage_sub_status(1),HmsCsr_Fields.InvalidMessage_sub_status(2),HmsCsr_Fields.InvalidMessage_sub_status(3),HmsCsr_Fields.InvalidMessage_sub_status(4)
          ,HmsCsr_Fields.InvalidMessage_csr_state(1),HmsCsr_Fields.InvalidMessage_csr_state(2),HmsCsr_Fields.InvalidMessage_csr_state(3),HmsCsr_Fields.InvalidMessage_csr_state(4)
          ,HmsCsr_Fields.InvalidMessage_csr_issue_date(1),HmsCsr_Fields.InvalidMessage_csr_issue_date(2),HmsCsr_Fields.InvalidMessage_csr_issue_date(3),HmsCsr_Fields.InvalidMessage_csr_issue_date(4)
          ,HmsCsr_Fields.InvalidMessage_effective_date(1),HmsCsr_Fields.InvalidMessage_effective_date(2),HmsCsr_Fields.InvalidMessage_effective_date(3),HmsCsr_Fields.InvalidMessage_effective_date(4)
          ,HmsCsr_Fields.InvalidMessage_csr_expiration_date(1),HmsCsr_Fields.InvalidMessage_csr_expiration_date(2),HmsCsr_Fields.InvalidMessage_csr_expiration_date(3),HmsCsr_Fields.InvalidMessage_csr_expiration_date(4)
          ,HmsCsr_Fields.InvalidMessage_discipline(1),HmsCsr_Fields.InvalidMessage_discipline(2),HmsCsr_Fields.InvalidMessage_discipline(3),HmsCsr_Fields.InvalidMessage_discipline(4)
          ,HmsCsr_Fields.InvalidMessage_all_schedules(1),HmsCsr_Fields.InvalidMessage_all_schedules(2),HmsCsr_Fields.InvalidMessage_all_schedules(3),HmsCsr_Fields.InvalidMessage_all_schedules(4)
          ,HmsCsr_Fields.InvalidMessage_dea_expiration_date(1),HmsCsr_Fields.InvalidMessage_dea_expiration_date(2),HmsCsr_Fields.InvalidMessage_dea_expiration_date(3),HmsCsr_Fields.InvalidMessage_dea_expiration_date(4),'UNKNOWN');
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
          ,le.renewal_date_LEFTTRIM_ErrorCount,le.renewal_date_ALLOW_ErrorCount,le.renewal_date_LENGTH_ErrorCount,le.renewal_date_WORDS_ErrorCount
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
          ,le.prefix_LEFTTRIM_ErrorCount,le.prefix_ALLOW_ErrorCount,le.prefix_LENGTH_ErrorCount,le.prefix_WORDS_ErrorCount
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
          ,le.description_LEFTTRIM_ErrorCount,le.description_ALLOW_ErrorCount,le.description_LENGTH_ErrorCount,le.description_WORDS_ErrorCount
          ,le.specialty_class_type_LEFTTRIM_ErrorCount,le.specialty_class_type_ALLOW_ErrorCount,le.specialty_class_type_LENGTH_ErrorCount,le.specialty_class_type_WORDS_ErrorCount
          ,le.phone_number_LEFTTRIM_ErrorCount,le.phone_number_ALLOW_ErrorCount,le.phone_number_LENGTH_ErrorCount,le.phone_number_WORDS_ErrorCount
          ,le.phone_type_LEFTTRIM_ErrorCount,le.phone_type_ALLOW_ErrorCount,le.phone_type_LENGTH_ErrorCount,le.phone_type_WORDS_ErrorCount
          ,le.language_LEFTTRIM_ErrorCount,le.language_ALLOW_ErrorCount,le.language_LENGTH_ErrorCount,le.language_WORDS_ErrorCount
          ,le.degree_LEFTTRIM_ErrorCount,le.degree_ALLOW_ErrorCount,le.degree_LENGTH_ErrorCount,le.degree_WORDS_ErrorCount
          ,le.graduated_LEFTTRIM_ErrorCount,le.graduated_ALLOW_ErrorCount,le.graduated_LENGTH_ErrorCount,le.graduated_WORDS_ErrorCount
          ,le.school_LEFTTRIM_ErrorCount,le.school_ALLOW_ErrorCount,le.school_LENGTH_ErrorCount,le.school_WORDS_ErrorCount
          ,le.location_LEFTTRIM_ErrorCount,le.location_ALLOW_ErrorCount,le.location_LENGTH_ErrorCount,le.location_WORDS_ErrorCount
          ,le.fine_LEFTTRIM_ErrorCount,le.fine_ALLOW_ErrorCount,le.fine_LENGTH_ErrorCount,le.fine_WORDS_ErrorCount
          ,le.board_LEFTTRIM_ErrorCount,le.board_ALLOW_ErrorCount,le.board_LENGTH_ErrorCount,le.board_WORDS_ErrorCount
          ,le.offense_LEFTTRIM_ErrorCount,le.offense_ALLOW_ErrorCount,le.offense_LENGTH_ErrorCount,le.offense_WORDS_ErrorCount
          ,le.offense_date_LEFTTRIM_ErrorCount,le.offense_date_ALLOW_ErrorCount,le.offense_date_LENGTH_ErrorCount,le.offense_date_WORDS_ErrorCount
          ,le.action_LEFTTRIM_ErrorCount,le.action_ALLOW_ErrorCount,le.action_LENGTH_ErrorCount,le.action_WORDS_ErrorCount
          ,le.action_date_LEFTTRIM_ErrorCount,le.action_date_ALLOW_ErrorCount,le.action_date_LENGTH_ErrorCount,le.action_date_WORDS_ErrorCount
          ,le.action_start_LEFTTRIM_ErrorCount,le.action_start_ALLOW_ErrorCount,le.action_start_LENGTH_ErrorCount,le.action_start_WORDS_ErrorCount
          ,le.action_end_LEFTTRIM_ErrorCount,le.action_end_ALLOW_ErrorCount,le.action_end_LENGTH_ErrorCount,le.action_end_WORDS_ErrorCount
          ,le.npi_number_LEFTTRIM_ErrorCount,le.npi_number_ALLOW_ErrorCount,le.npi_number_LENGTH_ErrorCount,le.npi_number_WORDS_ErrorCount
          ,le.replacement_number_LEFTTRIM_ErrorCount,le.replacement_number_ALLOW_ErrorCount,le.replacement_number_LENGTH_ErrorCount,le.replacement_number_WORDS_ErrorCount
          ,le.enumeration_date_LEFTTRIM_ErrorCount,le.enumeration_date_ALLOW_ErrorCount,le.enumeration_date_LENGTH_ErrorCount,le.enumeration_date_WORDS_ErrorCount
          ,le.last_update_date_LEFTTRIM_ErrorCount,le.last_update_date_ALLOW_ErrorCount,le.last_update_date_LENGTH_ErrorCount,le.last_update_date_WORDS_ErrorCount
          ,le.deactivation_date_LEFTTRIM_ErrorCount,le.deactivation_date_ALLOW_ErrorCount,le.deactivation_date_LENGTH_ErrorCount,le.deactivation_date_WORDS_ErrorCount
          ,le.reactivation_date_LEFTTRIM_ErrorCount,le.reactivation_date_ALLOW_ErrorCount,le.reactivation_date_LENGTH_ErrorCount,le.reactivation_date_WORDS_ErrorCount
          ,le.deactivation_reason_LEFTTRIM_ErrorCount,le.deactivation_reason_ALLOW_ErrorCount,le.deactivation_reason_LENGTH_ErrorCount,le.deactivation_reason_WORDS_ErrorCount
          ,le.csr_number_LEFTTRIM_ErrorCount,le.csr_number_ALLOW_ErrorCount,le.csr_number_LENGTH_ErrorCount,le.csr_number_WORDS_ErrorCount
          ,le.credential_type_LEFTTRIM_ErrorCount,le.credential_type_ALLOW_ErrorCount,le.credential_type_LENGTH_ErrorCount,le.credential_type_WORDS_ErrorCount
          ,le.csr_status_LEFTTRIM_ErrorCount,le.csr_status_ALLOW_ErrorCount,le.csr_status_LENGTH_ErrorCount,le.csr_status_WORDS_ErrorCount
          ,le.sub_status_LEFTTRIM_ErrorCount,le.sub_status_ALLOW_ErrorCount,le.sub_status_LENGTH_ErrorCount,le.sub_status_WORDS_ErrorCount
          ,le.csr_state_LEFTTRIM_ErrorCount,le.csr_state_ALLOW_ErrorCount,le.csr_state_LENGTH_ErrorCount,le.csr_state_WORDS_ErrorCount
          ,le.csr_issue_date_LEFTTRIM_ErrorCount,le.csr_issue_date_ALLOW_ErrorCount,le.csr_issue_date_LENGTH_ErrorCount,le.csr_issue_date_WORDS_ErrorCount
          ,le.effective_date_LEFTTRIM_ErrorCount,le.effective_date_ALLOW_ErrorCount,le.effective_date_LENGTH_ErrorCount,le.effective_date_WORDS_ErrorCount
          ,le.csr_expiration_date_LEFTTRIM_ErrorCount,le.csr_expiration_date_ALLOW_ErrorCount,le.csr_expiration_date_LENGTH_ErrorCount,le.csr_expiration_date_WORDS_ErrorCount
          ,le.discipline_LEFTTRIM_ErrorCount,le.discipline_ALLOW_ErrorCount,le.discipline_LENGTH_ErrorCount,le.discipline_WORDS_ErrorCount
          ,le.all_schedules_LEFTTRIM_ErrorCount,le.all_schedules_ALLOW_ErrorCount,le.all_schedules_LENGTH_ErrorCount,le.all_schedules_WORDS_ErrorCount
          ,le.dea_expiration_date_LEFTTRIM_ErrorCount,le.dea_expiration_date_ALLOW_ErrorCount,le.dea_expiration_date_LENGTH_ErrorCount,le.dea_expiration_date_WORDS_ErrorCount,0);
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
          ,le.renewal_date_LEFTTRIM_ErrorCount,le.renewal_date_ALLOW_ErrorCount,le.renewal_date_LENGTH_ErrorCount,le.renewal_date_WORDS_ErrorCount
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
          ,le.prefix_LEFTTRIM_ErrorCount,le.prefix_ALLOW_ErrorCount,le.prefix_LENGTH_ErrorCount,le.prefix_WORDS_ErrorCount
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
          ,le.description_LEFTTRIM_ErrorCount,le.description_ALLOW_ErrorCount,le.description_LENGTH_ErrorCount,le.description_WORDS_ErrorCount
          ,le.specialty_class_type_LEFTTRIM_ErrorCount,le.specialty_class_type_ALLOW_ErrorCount,le.specialty_class_type_LENGTH_ErrorCount,le.specialty_class_type_WORDS_ErrorCount
          ,le.phone_number_LEFTTRIM_ErrorCount,le.phone_number_ALLOW_ErrorCount,le.phone_number_LENGTH_ErrorCount,le.phone_number_WORDS_ErrorCount
          ,le.phone_type_LEFTTRIM_ErrorCount,le.phone_type_ALLOW_ErrorCount,le.phone_type_LENGTH_ErrorCount,le.phone_type_WORDS_ErrorCount
          ,le.language_LEFTTRIM_ErrorCount,le.language_ALLOW_ErrorCount,le.language_LENGTH_ErrorCount,le.language_WORDS_ErrorCount
          ,le.degree_LEFTTRIM_ErrorCount,le.degree_ALLOW_ErrorCount,le.degree_LENGTH_ErrorCount,le.degree_WORDS_ErrorCount
          ,le.graduated_LEFTTRIM_ErrorCount,le.graduated_ALLOW_ErrorCount,le.graduated_LENGTH_ErrorCount,le.graduated_WORDS_ErrorCount
          ,le.school_LEFTTRIM_ErrorCount,le.school_ALLOW_ErrorCount,le.school_LENGTH_ErrorCount,le.school_WORDS_ErrorCount
          ,le.location_LEFTTRIM_ErrorCount,le.location_ALLOW_ErrorCount,le.location_LENGTH_ErrorCount,le.location_WORDS_ErrorCount
          ,le.fine_LEFTTRIM_ErrorCount,le.fine_ALLOW_ErrorCount,le.fine_LENGTH_ErrorCount,le.fine_WORDS_ErrorCount
          ,le.board_LEFTTRIM_ErrorCount,le.board_ALLOW_ErrorCount,le.board_LENGTH_ErrorCount,le.board_WORDS_ErrorCount
          ,le.offense_LEFTTRIM_ErrorCount,le.offense_ALLOW_ErrorCount,le.offense_LENGTH_ErrorCount,le.offense_WORDS_ErrorCount
          ,le.offense_date_LEFTTRIM_ErrorCount,le.offense_date_ALLOW_ErrorCount,le.offense_date_LENGTH_ErrorCount,le.offense_date_WORDS_ErrorCount
          ,le.action_LEFTTRIM_ErrorCount,le.action_ALLOW_ErrorCount,le.action_LENGTH_ErrorCount,le.action_WORDS_ErrorCount
          ,le.action_date_LEFTTRIM_ErrorCount,le.action_date_ALLOW_ErrorCount,le.action_date_LENGTH_ErrorCount,le.action_date_WORDS_ErrorCount
          ,le.action_start_LEFTTRIM_ErrorCount,le.action_start_ALLOW_ErrorCount,le.action_start_LENGTH_ErrorCount,le.action_start_WORDS_ErrorCount
          ,le.action_end_LEFTTRIM_ErrorCount,le.action_end_ALLOW_ErrorCount,le.action_end_LENGTH_ErrorCount,le.action_end_WORDS_ErrorCount
          ,le.npi_number_LEFTTRIM_ErrorCount,le.npi_number_ALLOW_ErrorCount,le.npi_number_LENGTH_ErrorCount,le.npi_number_WORDS_ErrorCount
          ,le.replacement_number_LEFTTRIM_ErrorCount,le.replacement_number_ALLOW_ErrorCount,le.replacement_number_LENGTH_ErrorCount,le.replacement_number_WORDS_ErrorCount
          ,le.enumeration_date_LEFTTRIM_ErrorCount,le.enumeration_date_ALLOW_ErrorCount,le.enumeration_date_LENGTH_ErrorCount,le.enumeration_date_WORDS_ErrorCount
          ,le.last_update_date_LEFTTRIM_ErrorCount,le.last_update_date_ALLOW_ErrorCount,le.last_update_date_LENGTH_ErrorCount,le.last_update_date_WORDS_ErrorCount
          ,le.deactivation_date_LEFTTRIM_ErrorCount,le.deactivation_date_ALLOW_ErrorCount,le.deactivation_date_LENGTH_ErrorCount,le.deactivation_date_WORDS_ErrorCount
          ,le.reactivation_date_LEFTTRIM_ErrorCount,le.reactivation_date_ALLOW_ErrorCount,le.reactivation_date_LENGTH_ErrorCount,le.reactivation_date_WORDS_ErrorCount
          ,le.deactivation_reason_LEFTTRIM_ErrorCount,le.deactivation_reason_ALLOW_ErrorCount,le.deactivation_reason_LENGTH_ErrorCount,le.deactivation_reason_WORDS_ErrorCount
          ,le.csr_number_LEFTTRIM_ErrorCount,le.csr_number_ALLOW_ErrorCount,le.csr_number_LENGTH_ErrorCount,le.csr_number_WORDS_ErrorCount
          ,le.credential_type_LEFTTRIM_ErrorCount,le.credential_type_ALLOW_ErrorCount,le.credential_type_LENGTH_ErrorCount,le.credential_type_WORDS_ErrorCount
          ,le.csr_status_LEFTTRIM_ErrorCount,le.csr_status_ALLOW_ErrorCount,le.csr_status_LENGTH_ErrorCount,le.csr_status_WORDS_ErrorCount
          ,le.sub_status_LEFTTRIM_ErrorCount,le.sub_status_ALLOW_ErrorCount,le.sub_status_LENGTH_ErrorCount,le.sub_status_WORDS_ErrorCount
          ,le.csr_state_LEFTTRIM_ErrorCount,le.csr_state_ALLOW_ErrorCount,le.csr_state_LENGTH_ErrorCount,le.csr_state_WORDS_ErrorCount
          ,le.csr_issue_date_LEFTTRIM_ErrorCount,le.csr_issue_date_ALLOW_ErrorCount,le.csr_issue_date_LENGTH_ErrorCount,le.csr_issue_date_WORDS_ErrorCount
          ,le.effective_date_LEFTTRIM_ErrorCount,le.effective_date_ALLOW_ErrorCount,le.effective_date_LENGTH_ErrorCount,le.effective_date_WORDS_ErrorCount
          ,le.csr_expiration_date_LEFTTRIM_ErrorCount,le.csr_expiration_date_ALLOW_ErrorCount,le.csr_expiration_date_LENGTH_ErrorCount,le.csr_expiration_date_WORDS_ErrorCount
          ,le.discipline_LEFTTRIM_ErrorCount,le.discipline_ALLOW_ErrorCount,le.discipline_LENGTH_ErrorCount,le.discipline_WORDS_ErrorCount
          ,le.all_schedules_LEFTTRIM_ErrorCount,le.all_schedules_ALLOW_ErrorCount,le.all_schedules_LENGTH_ErrorCount,le.all_schedules_WORDS_ErrorCount
          ,le.dea_expiration_date_LEFTTRIM_ErrorCount,le.dea_expiration_date_ALLOW_ErrorCount,le.dea_expiration_date_LENGTH_ErrorCount,le.dea_expiration_date_WORDS_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,325,Into(LEFT,COUNTER));
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

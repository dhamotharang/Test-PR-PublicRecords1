IMPORT ut,SALT34;
IMPORT Scrubs_DCA; // Import modules for FieldTypes attribute definitions
EXPORT Base_Companies_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Base_Companies_Layout_DCA)
    UNSIGNED1 src_rid_Invalid;
    UNSIGNED1 rid_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 powid_Invalid;
    UNSIGNED1 proxid_Invalid;
    UNSIGNED1 seleid_Invalid;
    UNSIGNED1 orgid_Invalid;
    UNSIGNED1 ultid_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
    UNSIGNED1 physical_rawaid_Invalid;
    UNSIGNED1 physical_aceaid_Invalid;
    UNSIGNED1 mailing_rawaid_Invalid;
    UNSIGNED1 mailing_aceaid_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 file_type_Invalid;
    UNSIGNED1 lncagid_Invalid;
    UNSIGNED1 lncaghid_Invalid;
    UNSIGNED1 lncaiid_Invalid;
    UNSIGNED1 rawfields_enterprise_num_Invalid;
    UNSIGNED1 rawfields_parent_enterprise_number_Invalid;
    UNSIGNED1 rawfields_ultimate_enterprise_number_Invalid;
    UNSIGNED1 rawfields_company_type_Invalid;
    UNSIGNED1 rawfields_name_Invalid;
    UNSIGNED1 rawfields_e_mail_Invalid;
    UNSIGNED1 rawfields_url_Invalid;
    UNSIGNED1 rawfields_incorp_Invalid;
    UNSIGNED1 rawfields_sic1_Invalid;
    UNSIGNED1 rawfields_sic2_Invalid;
    UNSIGNED1 rawfields_sic3_Invalid;
    UNSIGNED1 rawfields_sic4_Invalid;
    UNSIGNED1 rawfields_sic5_Invalid;
    UNSIGNED1 rawfields_sic6_Invalid;
    UNSIGNED1 rawfields_sic7_Invalid;
    UNSIGNED1 rawfields_sic8_Invalid;
    UNSIGNED1 rawfields_sic9_Invalid;
    UNSIGNED1 rawfields_sic10_Invalid;
    UNSIGNED1 rawfields_naics1_Invalid;
    UNSIGNED1 rawfields_naics2_Invalid;
    UNSIGNED1 rawfields_naics3_Invalid;
    UNSIGNED1 rawfields_naics4_Invalid;
    UNSIGNED1 rawfields_naics5_Invalid;
    UNSIGNED1 rawfields_naics6_Invalid;
    UNSIGNED1 rawfields_naics7_Invalid;
    UNSIGNED1 rawfields_naics8_Invalid;
    UNSIGNED1 rawfields_naics9_Invalid;
    UNSIGNED1 rawfields_naics10_Invalid;
    UNSIGNED1 physical_address_prim_name_Invalid;
    UNSIGNED1 physical_address_p_city_name_Invalid;
    UNSIGNED1 physical_address_v_city_name_Invalid;
    UNSIGNED1 physical_address_st_Invalid;
    UNSIGNED1 physical_address_zip_Invalid;
    UNSIGNED1 mailing_address_prim_name_Invalid;
    UNSIGNED1 mailing_address_p_city_name_Invalid;
    UNSIGNED1 mailing_address_v_city_name_Invalid;
    UNSIGNED1 mailing_address_st_Invalid;
    UNSIGNED1 mailing_address_zip_Invalid;
    UNSIGNED1 clean_phones_phone_Invalid;
    UNSIGNED1 clean_phones_fax_Invalid;
    UNSIGNED1 clean_phones_telex_Invalid;
    UNSIGNED1 clean_dates_update_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Companies_Layout_DCA)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_Companies_Layout_DCA) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.src_rid_Invalid := Base_Companies_Fields.InValid_src_rid((SALT34.StrType)le.src_rid);
    SELF.rid_Invalid := Base_Companies_Fields.InValid_rid((SALT34.StrType)le.rid);
    SELF.bdid_Invalid := Base_Companies_Fields.InValid_bdid((SALT34.StrType)le.bdid);
    SELF.powid_Invalid := Base_Companies_Fields.InValid_powid((SALT34.StrType)le.powid);
    SELF.proxid_Invalid := Base_Companies_Fields.InValid_proxid((SALT34.StrType)le.proxid);
    SELF.seleid_Invalid := Base_Companies_Fields.InValid_seleid((SALT34.StrType)le.seleid);
    SELF.orgid_Invalid := Base_Companies_Fields.InValid_orgid((SALT34.StrType)le.orgid);
    SELF.ultid_Invalid := Base_Companies_Fields.InValid_ultid((SALT34.StrType)le.ultid);
    SELF.date_first_seen_Invalid := Base_Companies_Fields.InValid_date_first_seen((SALT34.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Base_Companies_Fields.InValid_date_last_seen((SALT34.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Base_Companies_Fields.InValid_date_vendor_first_reported((SALT34.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Base_Companies_Fields.InValid_date_vendor_last_reported((SALT34.StrType)le.date_vendor_last_reported);
    SELF.physical_rawaid_Invalid := Base_Companies_Fields.InValid_physical_rawaid((SALT34.StrType)le.physical_rawaid);
    SELF.physical_aceaid_Invalid := Base_Companies_Fields.InValid_physical_aceaid((SALT34.StrType)le.physical_aceaid);
    SELF.mailing_rawaid_Invalid := Base_Companies_Fields.InValid_mailing_rawaid((SALT34.StrType)le.mailing_rawaid);
    SELF.mailing_aceaid_Invalid := Base_Companies_Fields.InValid_mailing_aceaid((SALT34.StrType)le.mailing_aceaid);
    SELF.record_type_Invalid := Base_Companies_Fields.InValid_record_type((SALT34.StrType)le.record_type);
    SELF.file_type_Invalid := Base_Companies_Fields.InValid_file_type((SALT34.StrType)le.file_type);
    SELF.lncagid_Invalid := Base_Companies_Fields.InValid_lncagid((SALT34.StrType)le.lncagid);
    SELF.lncaghid_Invalid := Base_Companies_Fields.InValid_lncaghid((SALT34.StrType)le.lncaghid);
    SELF.lncaiid_Invalid := Base_Companies_Fields.InValid_lncaiid((SALT34.StrType)le.lncaiid);
    SELF.rawfields_enterprise_num_Invalid := Base_Companies_Fields.InValid_rawfields_enterprise_num((SALT34.StrType)le.rawfields_enterprise_num);
    SELF.rawfields_parent_enterprise_number_Invalid := Base_Companies_Fields.InValid_rawfields_parent_enterprise_number((SALT34.StrType)le.rawfields_parent_enterprise_number);
    SELF.rawfields_ultimate_enterprise_number_Invalid := Base_Companies_Fields.InValid_rawfields_ultimate_enterprise_number((SALT34.StrType)le.rawfields_ultimate_enterprise_number);
    SELF.rawfields_company_type_Invalid := Base_Companies_Fields.InValid_rawfields_company_type((SALT34.StrType)le.rawfields_company_type);
    SELF.rawfields_name_Invalid := Base_Companies_Fields.InValid_rawfields_name((SALT34.StrType)le.rawfields_name);
    SELF.rawfields_e_mail_Invalid := Base_Companies_Fields.InValid_rawfields_e_mail((SALT34.StrType)le.rawfields_e_mail);
    SELF.rawfields_url_Invalid := Base_Companies_Fields.InValid_rawfields_url((SALT34.StrType)le.rawfields_url);
    SELF.rawfields_incorp_Invalid := Base_Companies_Fields.InValid_rawfields_incorp((SALT34.StrType)le.rawfields_incorp);
    SELF.rawfields_sic1_Invalid := Base_Companies_Fields.InValid_rawfields_sic1((SALT34.StrType)le.rawfields_sic1);
    SELF.rawfields_sic2_Invalid := Base_Companies_Fields.InValid_rawfields_sic2((SALT34.StrType)le.rawfields_sic2);
    SELF.rawfields_sic3_Invalid := Base_Companies_Fields.InValid_rawfields_sic3((SALT34.StrType)le.rawfields_sic3);
    SELF.rawfields_sic4_Invalid := Base_Companies_Fields.InValid_rawfields_sic4((SALT34.StrType)le.rawfields_sic4);
    SELF.rawfields_sic5_Invalid := Base_Companies_Fields.InValid_rawfields_sic5((SALT34.StrType)le.rawfields_sic5);
    SELF.rawfields_sic6_Invalid := Base_Companies_Fields.InValid_rawfields_sic6((SALT34.StrType)le.rawfields_sic6);
    SELF.rawfields_sic7_Invalid := Base_Companies_Fields.InValid_rawfields_sic7((SALT34.StrType)le.rawfields_sic7);
    SELF.rawfields_sic8_Invalid := Base_Companies_Fields.InValid_rawfields_sic8((SALT34.StrType)le.rawfields_sic8);
    SELF.rawfields_sic9_Invalid := Base_Companies_Fields.InValid_rawfields_sic9((SALT34.StrType)le.rawfields_sic9);
    SELF.rawfields_sic10_Invalid := Base_Companies_Fields.InValid_rawfields_sic10((SALT34.StrType)le.rawfields_sic10);
    SELF.rawfields_naics1_Invalid := Base_Companies_Fields.InValid_rawfields_naics1((SALT34.StrType)le.rawfields_naics1);
    SELF.rawfields_naics2_Invalid := Base_Companies_Fields.InValid_rawfields_naics2((SALT34.StrType)le.rawfields_naics2);
    SELF.rawfields_naics3_Invalid := Base_Companies_Fields.InValid_rawfields_naics3((SALT34.StrType)le.rawfields_naics3);
    SELF.rawfields_naics4_Invalid := Base_Companies_Fields.InValid_rawfields_naics4((SALT34.StrType)le.rawfields_naics4);
    SELF.rawfields_naics5_Invalid := Base_Companies_Fields.InValid_rawfields_naics5((SALT34.StrType)le.rawfields_naics5);
    SELF.rawfields_naics6_Invalid := Base_Companies_Fields.InValid_rawfields_naics6((SALT34.StrType)le.rawfields_naics6);
    SELF.rawfields_naics7_Invalid := Base_Companies_Fields.InValid_rawfields_naics7((SALT34.StrType)le.rawfields_naics7);
    SELF.rawfields_naics8_Invalid := Base_Companies_Fields.InValid_rawfields_naics8((SALT34.StrType)le.rawfields_naics8);
    SELF.rawfields_naics9_Invalid := Base_Companies_Fields.InValid_rawfields_naics9((SALT34.StrType)le.rawfields_naics9);
    SELF.rawfields_naics10_Invalid := Base_Companies_Fields.InValid_rawfields_naics10((SALT34.StrType)le.rawfields_naics10);
    SELF.physical_address_prim_name_Invalid := Base_Companies_Fields.InValid_physical_address_prim_name((SALT34.StrType)le.physical_address_prim_name);
    SELF.physical_address_p_city_name_Invalid := Base_Companies_Fields.InValid_physical_address_p_city_name((SALT34.StrType)le.physical_address_p_city_name);
    SELF.physical_address_v_city_name_Invalid := Base_Companies_Fields.InValid_physical_address_v_city_name((SALT34.StrType)le.physical_address_v_city_name);
    SELF.physical_address_st_Invalid := Base_Companies_Fields.InValid_physical_address_st((SALT34.StrType)le.physical_address_st);
    SELF.physical_address_zip_Invalid := Base_Companies_Fields.InValid_physical_address_zip((SALT34.StrType)le.physical_address_zip);
    SELF.mailing_address_prim_name_Invalid := Base_Companies_Fields.InValid_mailing_address_prim_name((SALT34.StrType)le.mailing_address_prim_name);
    SELF.mailing_address_p_city_name_Invalid := Base_Companies_Fields.InValid_mailing_address_p_city_name((SALT34.StrType)le.mailing_address_p_city_name);
    SELF.mailing_address_v_city_name_Invalid := Base_Companies_Fields.InValid_mailing_address_v_city_name((SALT34.StrType)le.mailing_address_v_city_name);
    SELF.mailing_address_st_Invalid := Base_Companies_Fields.InValid_mailing_address_st((SALT34.StrType)le.mailing_address_st);
    SELF.mailing_address_zip_Invalid := Base_Companies_Fields.InValid_mailing_address_zip((SALT34.StrType)le.mailing_address_zip);
    SELF.clean_phones_phone_Invalid := Base_Companies_Fields.InValid_clean_phones_phone((SALT34.StrType)le.clean_phones_phone);
    SELF.clean_phones_fax_Invalid := Base_Companies_Fields.InValid_clean_phones_fax((SALT34.StrType)le.clean_phones_fax);
    SELF.clean_phones_telex_Invalid := Base_Companies_Fields.InValid_clean_phones_telex((SALT34.StrType)le.clean_phones_telex);
    SELF.clean_dates_update_date_Invalid := Base_Companies_Fields.InValid_clean_dates_update_date((SALT34.StrType)le.clean_dates_update_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Companies_Layout_DCA);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.src_rid_Invalid << 0 ) + ( le.rid_Invalid << 1 ) + ( le.bdid_Invalid << 2 ) + ( le.powid_Invalid << 3 ) + ( le.proxid_Invalid << 4 ) + ( le.seleid_Invalid << 5 ) + ( le.orgid_Invalid << 6 ) + ( le.ultid_Invalid << 7 ) + ( le.date_first_seen_Invalid << 8 ) + ( le.date_last_seen_Invalid << 9 ) + ( le.date_vendor_first_reported_Invalid << 10 ) + ( le.date_vendor_last_reported_Invalid << 11 ) + ( le.physical_rawaid_Invalid << 12 ) + ( le.physical_aceaid_Invalid << 13 ) + ( le.mailing_rawaid_Invalid << 14 ) + ( le.mailing_aceaid_Invalid << 15 ) + ( le.record_type_Invalid << 16 ) + ( le.file_type_Invalid << 17 ) + ( le.lncagid_Invalid << 18 ) + ( le.lncaghid_Invalid << 19 ) + ( le.lncaiid_Invalid << 20 ) + ( le.rawfields_enterprise_num_Invalid << 21 ) + ( le.rawfields_parent_enterprise_number_Invalid << 22 ) + ( le.rawfields_ultimate_enterprise_number_Invalid << 23 ) + ( le.rawfields_company_type_Invalid << 24 ) + ( le.rawfields_name_Invalid << 25 ) + ( le.rawfields_e_mail_Invalid << 26 ) + ( le.rawfields_url_Invalid << 27 ) + ( le.rawfields_incorp_Invalid << 28 ) + ( le.rawfields_sic1_Invalid << 29 ) + ( le.rawfields_sic2_Invalid << 30 ) + ( le.rawfields_sic3_Invalid << 31 ) + ( le.rawfields_sic4_Invalid << 32 ) + ( le.rawfields_sic5_Invalid << 33 ) + ( le.rawfields_sic6_Invalid << 34 ) + ( le.rawfields_sic7_Invalid << 35 ) + ( le.rawfields_sic8_Invalid << 36 ) + ( le.rawfields_sic9_Invalid << 37 ) + ( le.rawfields_sic10_Invalid << 38 ) + ( le.rawfields_naics1_Invalid << 39 ) + ( le.rawfields_naics2_Invalid << 40 ) + ( le.rawfields_naics3_Invalid << 41 ) + ( le.rawfields_naics4_Invalid << 42 ) + ( le.rawfields_naics5_Invalid << 43 ) + ( le.rawfields_naics6_Invalid << 44 ) + ( le.rawfields_naics7_Invalid << 45 ) + ( le.rawfields_naics8_Invalid << 46 ) + ( le.rawfields_naics9_Invalid << 47 ) + ( le.rawfields_naics10_Invalid << 48 ) + ( le.physical_address_prim_name_Invalid << 49 ) + ( le.physical_address_p_city_name_Invalid << 50 ) + ( le.physical_address_v_city_name_Invalid << 51 ) + ( le.physical_address_st_Invalid << 52 ) + ( le.physical_address_zip_Invalid << 53 ) + ( le.mailing_address_prim_name_Invalid << 54 ) + ( le.mailing_address_p_city_name_Invalid << 55 ) + ( le.mailing_address_v_city_name_Invalid << 56 ) + ( le.mailing_address_st_Invalid << 57 ) + ( le.mailing_address_zip_Invalid << 58 ) + ( le.clean_phones_phone_Invalid << 59 ) + ( le.clean_phones_fax_Invalid << 60 ) + ( le.clean_phones_telex_Invalid << 61 ) + ( le.clean_dates_update_date_Invalid << 62 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Companies_Layout_DCA);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.src_rid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.rid_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.powid_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.proxid_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.ultid_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.physical_rawaid_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.physical_aceaid_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.mailing_rawaid_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.mailing_aceaid_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.file_type_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.lncagid_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.lncaghid_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.lncaiid_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.rawfields_enterprise_num_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.rawfields_parent_enterprise_number_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.rawfields_ultimate_enterprise_number_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.rawfields_company_type_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.rawfields_name_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.rawfields_e_mail_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.rawfields_url_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.rawfields_incorp_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.rawfields_sic1_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.rawfields_sic2_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.rawfields_sic3_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.rawfields_sic4_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.rawfields_sic5_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.rawfields_sic6_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.rawfields_sic7_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.rawfields_sic8_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.rawfields_sic9_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.rawfields_sic10_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.rawfields_naics1_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.rawfields_naics2_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.rawfields_naics3_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.rawfields_naics4_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.rawfields_naics5_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.rawfields_naics6_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.rawfields_naics7_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.rawfields_naics8_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.rawfields_naics9_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.rawfields_naics10_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.physical_address_prim_name_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.physical_address_p_city_name_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.physical_address_v_city_name_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.physical_address_st_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.physical_address_zip_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.mailing_address_prim_name_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.mailing_address_p_city_name_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.mailing_address_v_city_name_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.mailing_address_st_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.mailing_address_zip_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.clean_phones_phone_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.clean_phones_fax_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.clean_phones_telex_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.clean_dates_update_date_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    src_rid_CUSTOM_ErrorCount := COUNT(GROUP,h.src_rid_Invalid=1);
    rid_CUSTOM_ErrorCount := COUNT(GROUP,h.rid_Invalid=1);
    bdid_CUSTOM_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    powid_CUSTOM_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    proxid_CUSTOM_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    seleid_CUSTOM_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    orgid_CUSTOM_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    ultid_CUSTOM_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    physical_rawaid_CUSTOM_ErrorCount := COUNT(GROUP,h.physical_rawaid_Invalid=1);
    physical_aceaid_CUSTOM_ErrorCount := COUNT(GROUP,h.physical_aceaid_Invalid=1);
    mailing_rawaid_CUSTOM_ErrorCount := COUNT(GROUP,h.mailing_rawaid_Invalid=1);
    mailing_aceaid_CUSTOM_ErrorCount := COUNT(GROUP,h.mailing_aceaid_Invalid=1);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    file_type_ENUM_ErrorCount := COUNT(GROUP,h.file_type_Invalid=1);
    lncagid_CUSTOM_ErrorCount := COUNT(GROUP,h.lncagid_Invalid=1);
    lncaghid_CUSTOM_ErrorCount := COUNT(GROUP,h.lncaghid_Invalid=1);
    lncaiid_CUSTOM_ErrorCount := COUNT(GROUP,h.lncaiid_Invalid=1);
    rawfields_enterprise_num_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_enterprise_num_Invalid=1);
    rawfields_parent_enterprise_number_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_parent_enterprise_number_Invalid=1);
    rawfields_ultimate_enterprise_number_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_ultimate_enterprise_number_Invalid=1);
    rawfields_company_type_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_company_type_Invalid=1);
    rawfields_name_LENGTH_ErrorCount := COUNT(GROUP,h.rawfields_name_Invalid=1);
    rawfields_e_mail_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_e_mail_Invalid=1);
    rawfields_url_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_url_Invalid=1);
    rawfields_incorp_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_incorp_Invalid=1);
    rawfields_sic1_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_sic1_Invalid=1);
    rawfields_sic2_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_sic2_Invalid=1);
    rawfields_sic3_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_sic3_Invalid=1);
    rawfields_sic4_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_sic4_Invalid=1);
    rawfields_sic5_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_sic5_Invalid=1);
    rawfields_sic6_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_sic6_Invalid=1);
    rawfields_sic7_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_sic7_Invalid=1);
    rawfields_sic8_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_sic8_Invalid=1);
    rawfields_sic9_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_sic9_Invalid=1);
    rawfields_sic10_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_sic10_Invalid=1);
    rawfields_naics1_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_naics1_Invalid=1);
    rawfields_naics2_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_naics2_Invalid=1);
    rawfields_naics3_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_naics3_Invalid=1);
    rawfields_naics4_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_naics4_Invalid=1);
    rawfields_naics5_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_naics5_Invalid=1);
    rawfields_naics6_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_naics6_Invalid=1);
    rawfields_naics7_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_naics7_Invalid=1);
    rawfields_naics8_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_naics8_Invalid=1);
    rawfields_naics9_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_naics9_Invalid=1);
    rawfields_naics10_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_naics10_Invalid=1);
    physical_address_prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.physical_address_prim_name_Invalid=1);
    physical_address_p_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.physical_address_p_city_name_Invalid=1);
    physical_address_v_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.physical_address_v_city_name_Invalid=1);
    physical_address_st_LENGTH_ErrorCount := COUNT(GROUP,h.physical_address_st_Invalid=1);
    physical_address_zip_LENGTH_ErrorCount := COUNT(GROUP,h.physical_address_zip_Invalid=1);
    mailing_address_prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.mailing_address_prim_name_Invalid=1);
    mailing_address_p_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.mailing_address_p_city_name_Invalid=1);
    mailing_address_v_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.mailing_address_v_city_name_Invalid=1);
    mailing_address_st_LENGTH_ErrorCount := COUNT(GROUP,h.mailing_address_st_Invalid=1);
    mailing_address_zip_LENGTH_ErrorCount := COUNT(GROUP,h.mailing_address_zip_Invalid=1);
    clean_phones_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_phones_phone_Invalid=1);
    clean_phones_fax_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_phones_fax_Invalid=1);
    clean_phones_telex_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_phones_telex_Invalid=1);
    clean_dates_update_date_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_dates_update_date_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT34.StrType ErrorMessage;
    SALT34.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.src_rid_Invalid,le.rid_Invalid,le.bdid_Invalid,le.powid_Invalid,le.proxid_Invalid,le.seleid_Invalid,le.orgid_Invalid,le.ultid_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,le.physical_rawaid_Invalid,le.physical_aceaid_Invalid,le.mailing_rawaid_Invalid,le.mailing_aceaid_Invalid,le.record_type_Invalid,le.file_type_Invalid,le.lncagid_Invalid,le.lncaghid_Invalid,le.lncaiid_Invalid,le.rawfields_enterprise_num_Invalid,le.rawfields_parent_enterprise_number_Invalid,le.rawfields_ultimate_enterprise_number_Invalid,le.rawfields_company_type_Invalid,le.rawfields_name_Invalid,le.rawfields_e_mail_Invalid,le.rawfields_url_Invalid,le.rawfields_incorp_Invalid,le.rawfields_sic1_Invalid,le.rawfields_sic2_Invalid,le.rawfields_sic3_Invalid,le.rawfields_sic4_Invalid,le.rawfields_sic5_Invalid,le.rawfields_sic6_Invalid,le.rawfields_sic7_Invalid,le.rawfields_sic8_Invalid,le.rawfields_sic9_Invalid,le.rawfields_sic10_Invalid,le.rawfields_naics1_Invalid,le.rawfields_naics2_Invalid,le.rawfields_naics3_Invalid,le.rawfields_naics4_Invalid,le.rawfields_naics5_Invalid,le.rawfields_naics6_Invalid,le.rawfields_naics7_Invalid,le.rawfields_naics8_Invalid,le.rawfields_naics9_Invalid,le.rawfields_naics10_Invalid,le.physical_address_prim_name_Invalid,le.physical_address_p_city_name_Invalid,le.physical_address_v_city_name_Invalid,le.physical_address_st_Invalid,le.physical_address_zip_Invalid,le.mailing_address_prim_name_Invalid,le.mailing_address_p_city_name_Invalid,le.mailing_address_v_city_name_Invalid,le.mailing_address_st_Invalid,le.mailing_address_zip_Invalid,le.clean_phones_phone_Invalid,le.clean_phones_fax_Invalid,le.clean_phones_telex_Invalid,le.clean_dates_update_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Companies_Fields.InvalidMessage_src_rid(le.src_rid_Invalid),Base_Companies_Fields.InvalidMessage_rid(le.rid_Invalid),Base_Companies_Fields.InvalidMessage_bdid(le.bdid_Invalid),Base_Companies_Fields.InvalidMessage_powid(le.powid_Invalid),Base_Companies_Fields.InvalidMessage_proxid(le.proxid_Invalid),Base_Companies_Fields.InvalidMessage_seleid(le.seleid_Invalid),Base_Companies_Fields.InvalidMessage_orgid(le.orgid_Invalid),Base_Companies_Fields.InvalidMessage_ultid(le.ultid_Invalid),Base_Companies_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Base_Companies_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Base_Companies_Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Base_Companies_Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),Base_Companies_Fields.InvalidMessage_physical_rawaid(le.physical_rawaid_Invalid),Base_Companies_Fields.InvalidMessage_physical_aceaid(le.physical_aceaid_Invalid),Base_Companies_Fields.InvalidMessage_mailing_rawaid(le.mailing_rawaid_Invalid),Base_Companies_Fields.InvalidMessage_mailing_aceaid(le.mailing_aceaid_Invalid),Base_Companies_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_Companies_Fields.InvalidMessage_file_type(le.file_type_Invalid),Base_Companies_Fields.InvalidMessage_lncagid(le.lncagid_Invalid),Base_Companies_Fields.InvalidMessage_lncaghid(le.lncaghid_Invalid),Base_Companies_Fields.InvalidMessage_lncaiid(le.lncaiid_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_enterprise_num(le.rawfields_enterprise_num_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_parent_enterprise_number(le.rawfields_parent_enterprise_number_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_ultimate_enterprise_number(le.rawfields_ultimate_enterprise_number_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_company_type(le.rawfields_company_type_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_name(le.rawfields_name_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_e_mail(le.rawfields_e_mail_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_url(le.rawfields_url_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_incorp(le.rawfields_incorp_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_sic1(le.rawfields_sic1_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_sic2(le.rawfields_sic2_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_sic3(le.rawfields_sic3_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_sic4(le.rawfields_sic4_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_sic5(le.rawfields_sic5_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_sic6(le.rawfields_sic6_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_sic7(le.rawfields_sic7_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_sic8(le.rawfields_sic8_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_sic9(le.rawfields_sic9_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_sic10(le.rawfields_sic10_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_naics1(le.rawfields_naics1_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_naics2(le.rawfields_naics2_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_naics3(le.rawfields_naics3_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_naics4(le.rawfields_naics4_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_naics5(le.rawfields_naics5_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_naics6(le.rawfields_naics6_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_naics7(le.rawfields_naics7_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_naics8(le.rawfields_naics8_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_naics9(le.rawfields_naics9_Invalid),Base_Companies_Fields.InvalidMessage_rawfields_naics10(le.rawfields_naics10_Invalid),Base_Companies_Fields.InvalidMessage_physical_address_prim_name(le.physical_address_prim_name_Invalid),Base_Companies_Fields.InvalidMessage_physical_address_p_city_name(le.physical_address_p_city_name_Invalid),Base_Companies_Fields.InvalidMessage_physical_address_v_city_name(le.physical_address_v_city_name_Invalid),Base_Companies_Fields.InvalidMessage_physical_address_st(le.physical_address_st_Invalid),Base_Companies_Fields.InvalidMessage_physical_address_zip(le.physical_address_zip_Invalid),Base_Companies_Fields.InvalidMessage_mailing_address_prim_name(le.mailing_address_prim_name_Invalid),Base_Companies_Fields.InvalidMessage_mailing_address_p_city_name(le.mailing_address_p_city_name_Invalid),Base_Companies_Fields.InvalidMessage_mailing_address_v_city_name(le.mailing_address_v_city_name_Invalid),Base_Companies_Fields.InvalidMessage_mailing_address_st(le.mailing_address_st_Invalid),Base_Companies_Fields.InvalidMessage_mailing_address_zip(le.mailing_address_zip_Invalid),Base_Companies_Fields.InvalidMessage_clean_phones_phone(le.clean_phones_phone_Invalid),Base_Companies_Fields.InvalidMessage_clean_phones_fax(le.clean_phones_fax_Invalid),Base_Companies_Fields.InvalidMessage_clean_phones_telex(le.clean_phones_telex_Invalid),Base_Companies_Fields.InvalidMessage_clean_dates_update_date(le.clean_dates_update_date_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.src_rid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.powid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.physical_rawaid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.physical_aceaid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mailing_rawaid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mailing_aceaid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.file_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.lncagid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lncaghid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lncaiid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_enterprise_num_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_parent_enterprise_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_ultimate_enterprise_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_company_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.rawfields_e_mail_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_url_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_incorp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_sic1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_sic2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_sic3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_sic4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_sic5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_sic6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_sic7_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_sic8_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_sic9_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_sic10_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_naics1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_naics2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_naics3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_naics4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_naics5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_naics6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_naics7_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_naics8_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_naics9_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_naics10_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.physical_address_prim_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.physical_address_p_city_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.physical_address_v_city_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.physical_address_st_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.physical_address_zip_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.mailing_address_prim_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.mailing_address_p_city_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.mailing_address_v_city_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.mailing_address_st_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.mailing_address_zip_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_phones_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_phones_fax_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_phones_telex_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_dates_update_date_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'src_rid','rid','bdid','powid','proxid','seleid','orgid','ultid','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','physical_rawaid','physical_aceaid','mailing_rawaid','mailing_aceaid','record_type','file_type','lncagid','lncaghid','lncaiid','rawfields_enterprise_num','rawfields_parent_enterprise_number','rawfields_ultimate_enterprise_number','rawfields_company_type','rawfields_name','rawfields_e_mail','rawfields_url','rawfields_incorp','rawfields_sic1','rawfields_sic2','rawfields_sic3','rawfields_sic4','rawfields_sic5','rawfields_sic6','rawfields_sic7','rawfields_sic8','rawfields_sic9','rawfields_sic10','rawfields_naics1','rawfields_naics2','rawfields_naics3','rawfields_naics4','rawfields_naics5','rawfields_naics6','rawfields_naics7','rawfields_naics8','rawfields_naics9','rawfields_naics10','physical_address_prim_name','physical_address_p_city_name','physical_address_v_city_name','physical_address_st','physical_address_zip','mailing_address_prim_name','mailing_address_p_city_name','mailing_address_v_city_name','mailing_address_st','mailing_address_zip','clean_phones_phone','clean_phones_fax','clean_phones_telex','clean_dates_update_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_src_rid','invalid_rid','invalid_bdid','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_record_type','invalid_file_type','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_company_type','invalid_mandatory','invalid_email','invalid_url','invalid_alphablank','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_phone','invalid_phone','invalid_phone','invalid_pastdate','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT34.StrType)le.src_rid,(SALT34.StrType)le.rid,(SALT34.StrType)le.bdid,(SALT34.StrType)le.powid,(SALT34.StrType)le.proxid,(SALT34.StrType)le.seleid,(SALT34.StrType)le.orgid,(SALT34.StrType)le.ultid,(SALT34.StrType)le.date_first_seen,(SALT34.StrType)le.date_last_seen,(SALT34.StrType)le.date_vendor_first_reported,(SALT34.StrType)le.date_vendor_last_reported,(SALT34.StrType)le.physical_rawaid,(SALT34.StrType)le.physical_aceaid,(SALT34.StrType)le.mailing_rawaid,(SALT34.StrType)le.mailing_aceaid,(SALT34.StrType)le.record_type,(SALT34.StrType)le.file_type,(SALT34.StrType)le.lncagid,(SALT34.StrType)le.lncaghid,(SALT34.StrType)le.lncaiid,(SALT34.StrType)le.rawfields_enterprise_num,(SALT34.StrType)le.rawfields_parent_enterprise_number,(SALT34.StrType)le.rawfields_ultimate_enterprise_number,(SALT34.StrType)le.rawfields_company_type,(SALT34.StrType)le.rawfields_name,(SALT34.StrType)le.rawfields_e_mail,(SALT34.StrType)le.rawfields_url,(SALT34.StrType)le.rawfields_incorp,(SALT34.StrType)le.rawfields_sic1,(SALT34.StrType)le.rawfields_sic2,(SALT34.StrType)le.rawfields_sic3,(SALT34.StrType)le.rawfields_sic4,(SALT34.StrType)le.rawfields_sic5,(SALT34.StrType)le.rawfields_sic6,(SALT34.StrType)le.rawfields_sic7,(SALT34.StrType)le.rawfields_sic8,(SALT34.StrType)le.rawfields_sic9,(SALT34.StrType)le.rawfields_sic10,(SALT34.StrType)le.rawfields_naics1,(SALT34.StrType)le.rawfields_naics2,(SALT34.StrType)le.rawfields_naics3,(SALT34.StrType)le.rawfields_naics4,(SALT34.StrType)le.rawfields_naics5,(SALT34.StrType)le.rawfields_naics6,(SALT34.StrType)le.rawfields_naics7,(SALT34.StrType)le.rawfields_naics8,(SALT34.StrType)le.rawfields_naics9,(SALT34.StrType)le.rawfields_naics10,(SALT34.StrType)le.physical_address_prim_name,(SALT34.StrType)le.physical_address_p_city_name,(SALT34.StrType)le.physical_address_v_city_name,(SALT34.StrType)le.physical_address_st,(SALT34.StrType)le.physical_address_zip,(SALT34.StrType)le.mailing_address_prim_name,(SALT34.StrType)le.mailing_address_p_city_name,(SALT34.StrType)le.mailing_address_v_city_name,(SALT34.StrType)le.mailing_address_st,(SALT34.StrType)le.mailing_address_zip,(SALT34.StrType)le.clean_phones_phone,(SALT34.StrType)le.clean_phones_fax,(SALT34.StrType)le.clean_phones_telex,(SALT34.StrType)le.clean_dates_update_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,63,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT34.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'src_rid:invalid_src_rid:CUSTOM'
          ,'rid:invalid_rid:CUSTOM'
          ,'bdid:invalid_bdid:CUSTOM'
          ,'powid:invalid_numeric:CUSTOM'
          ,'proxid:invalid_numeric:CUSTOM'
          ,'seleid:invalid_numeric:CUSTOM'
          ,'orgid:invalid_numeric:CUSTOM'
          ,'ultid:invalid_numeric:CUSTOM'
          ,'date_first_seen:invalid_pastdate:CUSTOM'
          ,'date_last_seen:invalid_pastdate:CUSTOM'
          ,'date_vendor_first_reported:invalid_pastdate:CUSTOM'
          ,'date_vendor_last_reported:invalid_pastdate:CUSTOM'
          ,'physical_rawaid:invalid_numeric_or_blank:CUSTOM'
          ,'physical_aceaid:invalid_numeric_or_blank:CUSTOM'
          ,'mailing_rawaid:invalid_numeric_or_blank:CUSTOM'
          ,'mailing_aceaid:invalid_numeric_or_blank:CUSTOM'
          ,'record_type:invalid_record_type:ENUM'
          ,'file_type:invalid_file_type:ENUM'
          ,'lncagid:invalid_numeric_or_blank:CUSTOM'
          ,'lncaghid:invalid_numeric_or_blank:CUSTOM'
          ,'lncaiid:invalid_numeric_or_blank:CUSTOM'
          ,'rawfields_enterprise_num:invalid_numeric_or_blank:CUSTOM'
          ,'rawfields_parent_enterprise_number:invalid_numeric_or_blank:CUSTOM'
          ,'rawfields_ultimate_enterprise_number:invalid_numeric_or_blank:CUSTOM'
          ,'rawfields_company_type:invalid_company_type:ALLOW'
          ,'rawfields_name:invalid_mandatory:LENGTH'
          ,'rawfields_e_mail:invalid_email:ALLOW'
          ,'rawfields_url:invalid_url:CUSTOM'
          ,'rawfields_incorp:invalid_alphablank:ALLOW'
          ,'rawfields_sic1:invalid_sic:CUSTOM'
          ,'rawfields_sic2:invalid_sic:CUSTOM'
          ,'rawfields_sic3:invalid_sic:CUSTOM'
          ,'rawfields_sic4:invalid_sic:CUSTOM'
          ,'rawfields_sic5:invalid_sic:CUSTOM'
          ,'rawfields_sic6:invalid_sic:CUSTOM'
          ,'rawfields_sic7:invalid_sic:CUSTOM'
          ,'rawfields_sic8:invalid_sic:CUSTOM'
          ,'rawfields_sic9:invalid_sic:CUSTOM'
          ,'rawfields_sic10:invalid_sic:CUSTOM'
          ,'rawfields_naics1:invalid_naics:CUSTOM'
          ,'rawfields_naics2:invalid_naics:CUSTOM'
          ,'rawfields_naics3:invalid_naics:CUSTOM'
          ,'rawfields_naics4:invalid_naics:CUSTOM'
          ,'rawfields_naics5:invalid_naics:CUSTOM'
          ,'rawfields_naics6:invalid_naics:CUSTOM'
          ,'rawfields_naics7:invalid_naics:CUSTOM'
          ,'rawfields_naics8:invalid_naics:CUSTOM'
          ,'rawfields_naics9:invalid_naics:CUSTOM'
          ,'rawfields_naics10:invalid_naics:CUSTOM'
          ,'physical_address_prim_name:invalid_mandatory:LENGTH'
          ,'physical_address_p_city_name:invalid_mandatory:LENGTH'
          ,'physical_address_v_city_name:invalid_mandatory:LENGTH'
          ,'physical_address_st:invalid_mandatory:LENGTH'
          ,'physical_address_zip:invalid_mandatory:LENGTH'
          ,'mailing_address_prim_name:invalid_mandatory:LENGTH'
          ,'mailing_address_p_city_name:invalid_mandatory:LENGTH'
          ,'mailing_address_v_city_name:invalid_mandatory:LENGTH'
          ,'mailing_address_st:invalid_mandatory:LENGTH'
          ,'mailing_address_zip:invalid_mandatory:LENGTH'
          ,'clean_phones_phone:invalid_phone:CUSTOM'
          ,'clean_phones_fax:invalid_phone:CUSTOM'
          ,'clean_phones_telex:invalid_phone:CUSTOM'
          ,'clean_dates_update_date:invalid_pastdate:CUSTOM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Companies_Fields.InvalidMessage_src_rid(1)
          ,Base_Companies_Fields.InvalidMessage_rid(1)
          ,Base_Companies_Fields.InvalidMessage_bdid(1)
          ,Base_Companies_Fields.InvalidMessage_powid(1)
          ,Base_Companies_Fields.InvalidMessage_proxid(1)
          ,Base_Companies_Fields.InvalidMessage_seleid(1)
          ,Base_Companies_Fields.InvalidMessage_orgid(1)
          ,Base_Companies_Fields.InvalidMessage_ultid(1)
          ,Base_Companies_Fields.InvalidMessage_date_first_seen(1)
          ,Base_Companies_Fields.InvalidMessage_date_last_seen(1)
          ,Base_Companies_Fields.InvalidMessage_date_vendor_first_reported(1)
          ,Base_Companies_Fields.InvalidMessage_date_vendor_last_reported(1)
          ,Base_Companies_Fields.InvalidMessage_physical_rawaid(1)
          ,Base_Companies_Fields.InvalidMessage_physical_aceaid(1)
          ,Base_Companies_Fields.InvalidMessage_mailing_rawaid(1)
          ,Base_Companies_Fields.InvalidMessage_mailing_aceaid(1)
          ,Base_Companies_Fields.InvalidMessage_record_type(1)
          ,Base_Companies_Fields.InvalidMessage_file_type(1)
          ,Base_Companies_Fields.InvalidMessage_lncagid(1)
          ,Base_Companies_Fields.InvalidMessage_lncaghid(1)
          ,Base_Companies_Fields.InvalidMessage_lncaiid(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_enterprise_num(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_parent_enterprise_number(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_ultimate_enterprise_number(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_company_type(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_name(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_e_mail(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_url(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_incorp(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_sic1(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_sic2(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_sic3(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_sic4(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_sic5(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_sic6(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_sic7(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_sic8(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_sic9(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_sic10(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_naics1(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_naics2(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_naics3(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_naics4(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_naics5(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_naics6(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_naics7(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_naics8(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_naics9(1)
          ,Base_Companies_Fields.InvalidMessage_rawfields_naics10(1)
          ,Base_Companies_Fields.InvalidMessage_physical_address_prim_name(1)
          ,Base_Companies_Fields.InvalidMessage_physical_address_p_city_name(1)
          ,Base_Companies_Fields.InvalidMessage_physical_address_v_city_name(1)
          ,Base_Companies_Fields.InvalidMessage_physical_address_st(1)
          ,Base_Companies_Fields.InvalidMessage_physical_address_zip(1)
          ,Base_Companies_Fields.InvalidMessage_mailing_address_prim_name(1)
          ,Base_Companies_Fields.InvalidMessage_mailing_address_p_city_name(1)
          ,Base_Companies_Fields.InvalidMessage_mailing_address_v_city_name(1)
          ,Base_Companies_Fields.InvalidMessage_mailing_address_st(1)
          ,Base_Companies_Fields.InvalidMessage_mailing_address_zip(1)
          ,Base_Companies_Fields.InvalidMessage_clean_phones_phone(1)
          ,Base_Companies_Fields.InvalidMessage_clean_phones_fax(1)
          ,Base_Companies_Fields.InvalidMessage_clean_phones_telex(1)
          ,Base_Companies_Fields.InvalidMessage_clean_dates_update_date(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.src_rid_CUSTOM_ErrorCount
          ,le.rid_CUSTOM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.powid_CUSTOM_ErrorCount
          ,le.proxid_CUSTOM_ErrorCount
          ,le.seleid_CUSTOM_ErrorCount
          ,le.orgid_CUSTOM_ErrorCount
          ,le.ultid_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.date_vendor_first_reported_CUSTOM_ErrorCount
          ,le.date_vendor_last_reported_CUSTOM_ErrorCount
          ,le.physical_rawaid_CUSTOM_ErrorCount
          ,le.physical_aceaid_CUSTOM_ErrorCount
          ,le.mailing_rawaid_CUSTOM_ErrorCount
          ,le.mailing_aceaid_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.file_type_ENUM_ErrorCount
          ,le.lncagid_CUSTOM_ErrorCount
          ,le.lncaghid_CUSTOM_ErrorCount
          ,le.lncaiid_CUSTOM_ErrorCount
          ,le.rawfields_enterprise_num_CUSTOM_ErrorCount
          ,le.rawfields_parent_enterprise_number_CUSTOM_ErrorCount
          ,le.rawfields_ultimate_enterprise_number_CUSTOM_ErrorCount
          ,le.rawfields_company_type_ALLOW_ErrorCount
          ,le.rawfields_name_LENGTH_ErrorCount
          ,le.rawfields_e_mail_ALLOW_ErrorCount
          ,le.rawfields_url_CUSTOM_ErrorCount
          ,le.rawfields_incorp_ALLOW_ErrorCount
          ,le.rawfields_sic1_CUSTOM_ErrorCount
          ,le.rawfields_sic2_CUSTOM_ErrorCount
          ,le.rawfields_sic3_CUSTOM_ErrorCount
          ,le.rawfields_sic4_CUSTOM_ErrorCount
          ,le.rawfields_sic5_CUSTOM_ErrorCount
          ,le.rawfields_sic6_CUSTOM_ErrorCount
          ,le.rawfields_sic7_CUSTOM_ErrorCount
          ,le.rawfields_sic8_CUSTOM_ErrorCount
          ,le.rawfields_sic9_CUSTOM_ErrorCount
          ,le.rawfields_sic10_CUSTOM_ErrorCount
          ,le.rawfields_naics1_CUSTOM_ErrorCount
          ,le.rawfields_naics2_CUSTOM_ErrorCount
          ,le.rawfields_naics3_CUSTOM_ErrorCount
          ,le.rawfields_naics4_CUSTOM_ErrorCount
          ,le.rawfields_naics5_CUSTOM_ErrorCount
          ,le.rawfields_naics6_CUSTOM_ErrorCount
          ,le.rawfields_naics7_CUSTOM_ErrorCount
          ,le.rawfields_naics8_CUSTOM_ErrorCount
          ,le.rawfields_naics9_CUSTOM_ErrorCount
          ,le.rawfields_naics10_CUSTOM_ErrorCount
          ,le.physical_address_prim_name_LENGTH_ErrorCount
          ,le.physical_address_p_city_name_LENGTH_ErrorCount
          ,le.physical_address_v_city_name_LENGTH_ErrorCount
          ,le.physical_address_st_LENGTH_ErrorCount
          ,le.physical_address_zip_LENGTH_ErrorCount
          ,le.mailing_address_prim_name_LENGTH_ErrorCount
          ,le.mailing_address_p_city_name_LENGTH_ErrorCount
          ,le.mailing_address_v_city_name_LENGTH_ErrorCount
          ,le.mailing_address_st_LENGTH_ErrorCount
          ,le.mailing_address_zip_LENGTH_ErrorCount
          ,le.clean_phones_phone_CUSTOM_ErrorCount
          ,le.clean_phones_fax_CUSTOM_ErrorCount
          ,le.clean_phones_telex_CUSTOM_ErrorCount
          ,le.clean_dates_update_date_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.src_rid_CUSTOM_ErrorCount
          ,le.rid_CUSTOM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.powid_CUSTOM_ErrorCount
          ,le.proxid_CUSTOM_ErrorCount
          ,le.seleid_CUSTOM_ErrorCount
          ,le.orgid_CUSTOM_ErrorCount
          ,le.ultid_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.date_vendor_first_reported_CUSTOM_ErrorCount
          ,le.date_vendor_last_reported_CUSTOM_ErrorCount
          ,le.physical_rawaid_CUSTOM_ErrorCount
          ,le.physical_aceaid_CUSTOM_ErrorCount
          ,le.mailing_rawaid_CUSTOM_ErrorCount
          ,le.mailing_aceaid_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.file_type_ENUM_ErrorCount
          ,le.lncagid_CUSTOM_ErrorCount
          ,le.lncaghid_CUSTOM_ErrorCount
          ,le.lncaiid_CUSTOM_ErrorCount
          ,le.rawfields_enterprise_num_CUSTOM_ErrorCount
          ,le.rawfields_parent_enterprise_number_CUSTOM_ErrorCount
          ,le.rawfields_ultimate_enterprise_number_CUSTOM_ErrorCount
          ,le.rawfields_company_type_ALLOW_ErrorCount
          ,le.rawfields_name_LENGTH_ErrorCount
          ,le.rawfields_e_mail_ALLOW_ErrorCount
          ,le.rawfields_url_CUSTOM_ErrorCount
          ,le.rawfields_incorp_ALLOW_ErrorCount
          ,le.rawfields_sic1_CUSTOM_ErrorCount
          ,le.rawfields_sic2_CUSTOM_ErrorCount
          ,le.rawfields_sic3_CUSTOM_ErrorCount
          ,le.rawfields_sic4_CUSTOM_ErrorCount
          ,le.rawfields_sic5_CUSTOM_ErrorCount
          ,le.rawfields_sic6_CUSTOM_ErrorCount
          ,le.rawfields_sic7_CUSTOM_ErrorCount
          ,le.rawfields_sic8_CUSTOM_ErrorCount
          ,le.rawfields_sic9_CUSTOM_ErrorCount
          ,le.rawfields_sic10_CUSTOM_ErrorCount
          ,le.rawfields_naics1_CUSTOM_ErrorCount
          ,le.rawfields_naics2_CUSTOM_ErrorCount
          ,le.rawfields_naics3_CUSTOM_ErrorCount
          ,le.rawfields_naics4_CUSTOM_ErrorCount
          ,le.rawfields_naics5_CUSTOM_ErrorCount
          ,le.rawfields_naics6_CUSTOM_ErrorCount
          ,le.rawfields_naics7_CUSTOM_ErrorCount
          ,le.rawfields_naics8_CUSTOM_ErrorCount
          ,le.rawfields_naics9_CUSTOM_ErrorCount
          ,le.rawfields_naics10_CUSTOM_ErrorCount
          ,le.physical_address_prim_name_LENGTH_ErrorCount
          ,le.physical_address_p_city_name_LENGTH_ErrorCount
          ,le.physical_address_v_city_name_LENGTH_ErrorCount
          ,le.physical_address_st_LENGTH_ErrorCount
          ,le.physical_address_zip_LENGTH_ErrorCount
          ,le.mailing_address_prim_name_LENGTH_ErrorCount
          ,le.mailing_address_p_city_name_LENGTH_ErrorCount
          ,le.mailing_address_v_city_name_LENGTH_ErrorCount
          ,le.mailing_address_st_LENGTH_ErrorCount
          ,le.mailing_address_zip_LENGTH_ErrorCount
          ,le.clean_phones_phone_CUSTOM_ErrorCount
          ,le.clean_phones_fax_CUSTOM_ErrorCount
          ,le.clean_phones_telex_CUSTOM_ErrorCount
          ,le.clean_dates_update_date_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,63,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT34.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT34.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;

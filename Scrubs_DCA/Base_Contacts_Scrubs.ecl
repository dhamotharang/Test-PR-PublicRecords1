IMPORT ut,SALT34;
IMPORT Scrubs_DCA; // Import modules for FieldTypes attribute definitions
EXPORT Base_Contacts_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Base_Contacts_Layout_DCA)
    UNSIGNED1 rid_Invalid;
    UNSIGNED1 did_Invalid;
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
    UNSIGNED1 rawfields_name_Invalid;
    UNSIGNED1 rawfields_executive_name_Invalid;
    UNSIGNED1 rawfields_executive_title_Invalid;
    UNSIGNED1 rawfields_executive_code_Invalid;
    UNSIGNED1 clean_name_title_Invalid;
    UNSIGNED1 clean_name_lname_Invalid;
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
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Contacts_Layout_DCA)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_Contacts_Layout_DCA) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.rid_Invalid := Base_Contacts_Fields.InValid_rid((SALT34.StrType)le.rid);
    SELF.did_Invalid := Base_Contacts_Fields.InValid_did((SALT34.StrType)le.did);
    SELF.bdid_Invalid := Base_Contacts_Fields.InValid_bdid((SALT34.StrType)le.bdid);
    SELF.powid_Invalid := Base_Contacts_Fields.InValid_powid((SALT34.StrType)le.powid);
    SELF.proxid_Invalid := Base_Contacts_Fields.InValid_proxid((SALT34.StrType)le.proxid);
    SELF.seleid_Invalid := Base_Contacts_Fields.InValid_seleid((SALT34.StrType)le.seleid);
    SELF.orgid_Invalid := Base_Contacts_Fields.InValid_orgid((SALT34.StrType)le.orgid);
    SELF.ultid_Invalid := Base_Contacts_Fields.InValid_ultid((SALT34.StrType)le.ultid);
    SELF.date_first_seen_Invalid := Base_Contacts_Fields.InValid_date_first_seen((SALT34.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Base_Contacts_Fields.InValid_date_last_seen((SALT34.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Base_Contacts_Fields.InValid_date_vendor_first_reported((SALT34.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Base_Contacts_Fields.InValid_date_vendor_last_reported((SALT34.StrType)le.date_vendor_last_reported);
    SELF.physical_rawaid_Invalid := Base_Contacts_Fields.InValid_physical_rawaid((SALT34.StrType)le.physical_rawaid);
    SELF.physical_aceaid_Invalid := Base_Contacts_Fields.InValid_physical_aceaid((SALT34.StrType)le.physical_aceaid);
    SELF.mailing_rawaid_Invalid := Base_Contacts_Fields.InValid_mailing_rawaid((SALT34.StrType)le.mailing_rawaid);
    SELF.mailing_aceaid_Invalid := Base_Contacts_Fields.InValid_mailing_aceaid((SALT34.StrType)le.mailing_aceaid);
    SELF.record_type_Invalid := Base_Contacts_Fields.InValid_record_type((SALT34.StrType)le.record_type);
    SELF.file_type_Invalid := Base_Contacts_Fields.InValid_file_type((SALT34.StrType)le.file_type);
    SELF.lncagid_Invalid := Base_Contacts_Fields.InValid_lncagid((SALT34.StrType)le.lncagid);
    SELF.lncaghid_Invalid := Base_Contacts_Fields.InValid_lncaghid((SALT34.StrType)le.lncaghid);
    SELF.lncaiid_Invalid := Base_Contacts_Fields.InValid_lncaiid((SALT34.StrType)le.lncaiid);
    SELF.rawfields_enterprise_num_Invalid := Base_Contacts_Fields.InValid_rawfields_enterprise_num((SALT34.StrType)le.rawfields_enterprise_num);
    SELF.rawfields_name_Invalid := Base_Contacts_Fields.InValid_rawfields_name((SALT34.StrType)le.rawfields_name);
    SELF.rawfields_executive_name_Invalid := Base_Contacts_Fields.InValid_rawfields_executive_name((SALT34.StrType)le.rawfields_executive_name);
    SELF.rawfields_executive_title_Invalid := Base_Contacts_Fields.InValid_rawfields_executive_title((SALT34.StrType)le.rawfields_executive_title);
    SELF.rawfields_executive_code_Invalid := Base_Contacts_Fields.InValid_rawfields_executive_code((SALT34.StrType)le.rawfields_executive_code);
    SELF.clean_name_title_Invalid := Base_Contacts_Fields.InValid_clean_name_title((SALT34.StrType)le.clean_name_title);
    SELF.clean_name_lname_Invalid := Base_Contacts_Fields.InValid_clean_name_lname((SALT34.StrType)le.clean_name_lname);
    SELF.physical_address_prim_name_Invalid := Base_Contacts_Fields.InValid_physical_address_prim_name((SALT34.StrType)le.physical_address_prim_name);
    SELF.physical_address_p_city_name_Invalid := Base_Contacts_Fields.InValid_physical_address_p_city_name((SALT34.StrType)le.physical_address_p_city_name);
    SELF.physical_address_v_city_name_Invalid := Base_Contacts_Fields.InValid_physical_address_v_city_name((SALT34.StrType)le.physical_address_v_city_name);
    SELF.physical_address_st_Invalid := Base_Contacts_Fields.InValid_physical_address_st((SALT34.StrType)le.physical_address_st);
    SELF.physical_address_zip_Invalid := Base_Contacts_Fields.InValid_physical_address_zip((SALT34.StrType)le.physical_address_zip);
    SELF.mailing_address_prim_name_Invalid := Base_Contacts_Fields.InValid_mailing_address_prim_name((SALT34.StrType)le.mailing_address_prim_name);
    SELF.mailing_address_p_city_name_Invalid := Base_Contacts_Fields.InValid_mailing_address_p_city_name((SALT34.StrType)le.mailing_address_p_city_name);
    SELF.mailing_address_v_city_name_Invalid := Base_Contacts_Fields.InValid_mailing_address_v_city_name((SALT34.StrType)le.mailing_address_v_city_name);
    SELF.mailing_address_st_Invalid := Base_Contacts_Fields.InValid_mailing_address_st((SALT34.StrType)le.mailing_address_st);
    SELF.mailing_address_zip_Invalid := Base_Contacts_Fields.InValid_mailing_address_zip((SALT34.StrType)le.mailing_address_zip);
    SELF.clean_phones_phone_Invalid := Base_Contacts_Fields.InValid_clean_phones_phone((SALT34.StrType)le.clean_phones_phone);
    SELF.clean_phones_fax_Invalid := Base_Contacts_Fields.InValid_clean_phones_fax((SALT34.StrType)le.clean_phones_fax);
    SELF.clean_phones_telex_Invalid := Base_Contacts_Fields.InValid_clean_phones_telex((SALT34.StrType)le.clean_phones_telex);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Contacts_Layout_DCA);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.rid_Invalid << 0 ) + ( le.did_Invalid << 1 ) + ( le.bdid_Invalid << 2 ) + ( le.powid_Invalid << 3 ) + ( le.proxid_Invalid << 4 ) + ( le.seleid_Invalid << 5 ) + ( le.orgid_Invalid << 6 ) + ( le.ultid_Invalid << 7 ) + ( le.date_first_seen_Invalid << 8 ) + ( le.date_last_seen_Invalid << 9 ) + ( le.date_vendor_first_reported_Invalid << 10 ) + ( le.date_vendor_last_reported_Invalid << 11 ) + ( le.physical_rawaid_Invalid << 12 ) + ( le.physical_aceaid_Invalid << 13 ) + ( le.mailing_rawaid_Invalid << 14 ) + ( le.mailing_aceaid_Invalid << 15 ) + ( le.record_type_Invalid << 16 ) + ( le.file_type_Invalid << 17 ) + ( le.lncagid_Invalid << 18 ) + ( le.lncaghid_Invalid << 19 ) + ( le.lncaiid_Invalid << 20 ) + ( le.rawfields_enterprise_num_Invalid << 21 ) + ( le.rawfields_name_Invalid << 22 ) + ( le.rawfields_executive_name_Invalid << 23 ) + ( le.rawfields_executive_title_Invalid << 24 ) + ( le.rawfields_executive_code_Invalid << 25 ) + ( le.clean_name_title_Invalid << 26 ) + ( le.clean_name_lname_Invalid << 27 ) + ( le.physical_address_prim_name_Invalid << 28 ) + ( le.physical_address_p_city_name_Invalid << 29 ) + ( le.physical_address_v_city_name_Invalid << 30 ) + ( le.physical_address_st_Invalid << 31 ) + ( le.physical_address_zip_Invalid << 32 ) + ( le.mailing_address_prim_name_Invalid << 33 ) + ( le.mailing_address_p_city_name_Invalid << 34 ) + ( le.mailing_address_v_city_name_Invalid << 35 ) + ( le.mailing_address_st_Invalid << 36 ) + ( le.mailing_address_zip_Invalid << 37 ) + ( le.clean_phones_phone_Invalid << 38 ) + ( le.clean_phones_fax_Invalid << 39 ) + ( le.clean_phones_telex_Invalid << 40 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Contacts_Layout_DCA);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.rid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 1) & 1;
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
    SELF.rawfields_name_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.rawfields_executive_name_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.rawfields_executive_title_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.rawfields_executive_code_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.clean_name_title_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.clean_name_lname_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.physical_address_prim_name_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.physical_address_p_city_name_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.physical_address_v_city_name_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.physical_address_st_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.physical_address_zip_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.mailing_address_prim_name_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.mailing_address_p_city_name_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.mailing_address_v_city_name_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.mailing_address_st_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.mailing_address_zip_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.clean_phones_phone_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.clean_phones_fax_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.clean_phones_telex_Invalid := (le.ScrubsBits1 >> 40) & 1;
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
    rawfields_name_LENGTH_ErrorCount := COUNT(GROUP,h.rawfields_name_Invalid=1);
    rawfields_executive_name_LENGTH_ErrorCount := COUNT(GROUP,h.rawfields_executive_name_Invalid=1);
    rawfields_executive_title_LENGTH_ErrorCount := COUNT(GROUP,h.rawfields_executive_title_Invalid=1);
    rawfields_executive_code_LENGTH_ErrorCount := COUNT(GROUP,h.rawfields_executive_code_Invalid=1);
    clean_name_title_LENGTH_ErrorCount := COUNT(GROUP,h.clean_name_title_Invalid=1);
    clean_name_lname_LENGTH_ErrorCount := COUNT(GROUP,h.clean_name_lname_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.rid_Invalid,le.did_Invalid,le.bdid_Invalid,le.powid_Invalid,le.proxid_Invalid,le.seleid_Invalid,le.orgid_Invalid,le.ultid_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,le.physical_rawaid_Invalid,le.physical_aceaid_Invalid,le.mailing_rawaid_Invalid,le.mailing_aceaid_Invalid,le.record_type_Invalid,le.file_type_Invalid,le.lncagid_Invalid,le.lncaghid_Invalid,le.lncaiid_Invalid,le.rawfields_enterprise_num_Invalid,le.rawfields_name_Invalid,le.rawfields_executive_name_Invalid,le.rawfields_executive_title_Invalid,le.rawfields_executive_code_Invalid,le.clean_name_title_Invalid,le.clean_name_lname_Invalid,le.physical_address_prim_name_Invalid,le.physical_address_p_city_name_Invalid,le.physical_address_v_city_name_Invalid,le.physical_address_st_Invalid,le.physical_address_zip_Invalid,le.mailing_address_prim_name_Invalid,le.mailing_address_p_city_name_Invalid,le.mailing_address_v_city_name_Invalid,le.mailing_address_st_Invalid,le.mailing_address_zip_Invalid,le.clean_phones_phone_Invalid,le.clean_phones_fax_Invalid,le.clean_phones_telex_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Contacts_Fields.InvalidMessage_rid(le.rid_Invalid),Base_Contacts_Fields.InvalidMessage_did(le.did_Invalid),Base_Contacts_Fields.InvalidMessage_bdid(le.bdid_Invalid),Base_Contacts_Fields.InvalidMessage_powid(le.powid_Invalid),Base_Contacts_Fields.InvalidMessage_proxid(le.proxid_Invalid),Base_Contacts_Fields.InvalidMessage_seleid(le.seleid_Invalid),Base_Contacts_Fields.InvalidMessage_orgid(le.orgid_Invalid),Base_Contacts_Fields.InvalidMessage_ultid(le.ultid_Invalid),Base_Contacts_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Base_Contacts_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Base_Contacts_Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Base_Contacts_Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),Base_Contacts_Fields.InvalidMessage_physical_rawaid(le.physical_rawaid_Invalid),Base_Contacts_Fields.InvalidMessage_physical_aceaid(le.physical_aceaid_Invalid),Base_Contacts_Fields.InvalidMessage_mailing_rawaid(le.mailing_rawaid_Invalid),Base_Contacts_Fields.InvalidMessage_mailing_aceaid(le.mailing_aceaid_Invalid),Base_Contacts_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_Contacts_Fields.InvalidMessage_file_type(le.file_type_Invalid),Base_Contacts_Fields.InvalidMessage_lncagid(le.lncagid_Invalid),Base_Contacts_Fields.InvalidMessage_lncaghid(le.lncaghid_Invalid),Base_Contacts_Fields.InvalidMessage_lncaiid(le.lncaiid_Invalid),Base_Contacts_Fields.InvalidMessage_rawfields_enterprise_num(le.rawfields_enterprise_num_Invalid),Base_Contacts_Fields.InvalidMessage_rawfields_name(le.rawfields_name_Invalid),Base_Contacts_Fields.InvalidMessage_rawfields_executive_name(le.rawfields_executive_name_Invalid),Base_Contacts_Fields.InvalidMessage_rawfields_executive_title(le.rawfields_executive_title_Invalid),Base_Contacts_Fields.InvalidMessage_rawfields_executive_code(le.rawfields_executive_code_Invalid),Base_Contacts_Fields.InvalidMessage_clean_name_title(le.clean_name_title_Invalid),Base_Contacts_Fields.InvalidMessage_clean_name_lname(le.clean_name_lname_Invalid),Base_Contacts_Fields.InvalidMessage_physical_address_prim_name(le.physical_address_prim_name_Invalid),Base_Contacts_Fields.InvalidMessage_physical_address_p_city_name(le.physical_address_p_city_name_Invalid),Base_Contacts_Fields.InvalidMessage_physical_address_v_city_name(le.physical_address_v_city_name_Invalid),Base_Contacts_Fields.InvalidMessage_physical_address_st(le.physical_address_st_Invalid),Base_Contacts_Fields.InvalidMessage_physical_address_zip(le.physical_address_zip_Invalid),Base_Contacts_Fields.InvalidMessage_mailing_address_prim_name(le.mailing_address_prim_name_Invalid),Base_Contacts_Fields.InvalidMessage_mailing_address_p_city_name(le.mailing_address_p_city_name_Invalid),Base_Contacts_Fields.InvalidMessage_mailing_address_v_city_name(le.mailing_address_v_city_name_Invalid),Base_Contacts_Fields.InvalidMessage_mailing_address_st(le.mailing_address_st_Invalid),Base_Contacts_Fields.InvalidMessage_mailing_address_zip(le.mailing_address_zip_Invalid),Base_Contacts_Fields.InvalidMessage_clean_phones_phone(le.clean_phones_phone_Invalid),Base_Contacts_Fields.InvalidMessage_clean_phones_fax(le.clean_phones_fax_Invalid),Base_Contacts_Fields.InvalidMessage_clean_phones_telex(le.clean_phones_telex_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.rid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'CUSTOM','UNKNOWN')
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
          ,CHOOSE(le.rawfields_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.rawfields_executive_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.rawfields_executive_title_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.rawfields_executive_code_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_name_title_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_name_lname_Invalid,'LENGTH','UNKNOWN')
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
          ,CHOOSE(le.clean_phones_telex_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'rid','did','bdid','powid','proxid','seleid','orgid','ultid','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','physical_rawaid','physical_aceaid','mailing_rawaid','mailing_aceaid','record_type','file_type','lncagid','lncaghid','lncaiid','rawfields_enterprise_num','rawfields_name','rawfields_executive_name','rawfields_executive_title','rawfields_executive_code','clean_name_title','clean_name_lname','physical_address_prim_name','physical_address_p_city_name','physical_address_v_city_name','physical_address_st','physical_address_zip','mailing_address_prim_name','mailing_address_p_city_name','mailing_address_v_city_name','mailing_address_st','mailing_address_zip','clean_phones_phone','clean_phones_fax','clean_phones_telex','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_rid','invalid_numeric','invalid_bdid','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_record_type','invalid_file_type','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_phone','invalid_phone','invalid_phone','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT34.StrType)le.rid,(SALT34.StrType)le.did,(SALT34.StrType)le.bdid,(SALT34.StrType)le.powid,(SALT34.StrType)le.proxid,(SALT34.StrType)le.seleid,(SALT34.StrType)le.orgid,(SALT34.StrType)le.ultid,(SALT34.StrType)le.date_first_seen,(SALT34.StrType)le.date_last_seen,(SALT34.StrType)le.date_vendor_first_reported,(SALT34.StrType)le.date_vendor_last_reported,(SALT34.StrType)le.physical_rawaid,(SALT34.StrType)le.physical_aceaid,(SALT34.StrType)le.mailing_rawaid,(SALT34.StrType)le.mailing_aceaid,(SALT34.StrType)le.record_type,(SALT34.StrType)le.file_type,(SALT34.StrType)le.lncagid,(SALT34.StrType)le.lncaghid,(SALT34.StrType)le.lncaiid,(SALT34.StrType)le.rawfields_enterprise_num,(SALT34.StrType)le.rawfields_name,(SALT34.StrType)le.rawfields_executive_name,(SALT34.StrType)le.rawfields_executive_title,(SALT34.StrType)le.rawfields_executive_code,(SALT34.StrType)le.clean_name_title,(SALT34.StrType)le.clean_name_lname,(SALT34.StrType)le.physical_address_prim_name,(SALT34.StrType)le.physical_address_p_city_name,(SALT34.StrType)le.physical_address_v_city_name,(SALT34.StrType)le.physical_address_st,(SALT34.StrType)le.physical_address_zip,(SALT34.StrType)le.mailing_address_prim_name,(SALT34.StrType)le.mailing_address_p_city_name,(SALT34.StrType)le.mailing_address_v_city_name,(SALT34.StrType)le.mailing_address_st,(SALT34.StrType)le.mailing_address_zip,(SALT34.StrType)le.clean_phones_phone,(SALT34.StrType)le.clean_phones_fax,(SALT34.StrType)le.clean_phones_telex,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,41,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT34.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'rid:invalid_rid:CUSTOM'
          ,'did:invalid_numeric:CUSTOM'
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
          ,'rawfields_name:invalid_mandatory:LENGTH'
          ,'rawfields_executive_name:invalid_mandatory:LENGTH'
          ,'rawfields_executive_title:invalid_mandatory:LENGTH'
          ,'rawfields_executive_code:invalid_mandatory:LENGTH'
          ,'clean_name_title:invalid_mandatory:LENGTH'
          ,'clean_name_lname:invalid_mandatory:LENGTH'
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
          ,'clean_phones_telex:invalid_phone:CUSTOM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Contacts_Fields.InvalidMessage_rid(1)
          ,Base_Contacts_Fields.InvalidMessage_did(1)
          ,Base_Contacts_Fields.InvalidMessage_bdid(1)
          ,Base_Contacts_Fields.InvalidMessage_powid(1)
          ,Base_Contacts_Fields.InvalidMessage_proxid(1)
          ,Base_Contacts_Fields.InvalidMessage_seleid(1)
          ,Base_Contacts_Fields.InvalidMessage_orgid(1)
          ,Base_Contacts_Fields.InvalidMessage_ultid(1)
          ,Base_Contacts_Fields.InvalidMessage_date_first_seen(1)
          ,Base_Contacts_Fields.InvalidMessage_date_last_seen(1)
          ,Base_Contacts_Fields.InvalidMessage_date_vendor_first_reported(1)
          ,Base_Contacts_Fields.InvalidMessage_date_vendor_last_reported(1)
          ,Base_Contacts_Fields.InvalidMessage_physical_rawaid(1)
          ,Base_Contacts_Fields.InvalidMessage_physical_aceaid(1)
          ,Base_Contacts_Fields.InvalidMessage_mailing_rawaid(1)
          ,Base_Contacts_Fields.InvalidMessage_mailing_aceaid(1)
          ,Base_Contacts_Fields.InvalidMessage_record_type(1)
          ,Base_Contacts_Fields.InvalidMessage_file_type(1)
          ,Base_Contacts_Fields.InvalidMessage_lncagid(1)
          ,Base_Contacts_Fields.InvalidMessage_lncaghid(1)
          ,Base_Contacts_Fields.InvalidMessage_lncaiid(1)
          ,Base_Contacts_Fields.InvalidMessage_rawfields_enterprise_num(1)
          ,Base_Contacts_Fields.InvalidMessage_rawfields_name(1)
          ,Base_Contacts_Fields.InvalidMessage_rawfields_executive_name(1)
          ,Base_Contacts_Fields.InvalidMessage_rawfields_executive_title(1)
          ,Base_Contacts_Fields.InvalidMessage_rawfields_executive_code(1)
          ,Base_Contacts_Fields.InvalidMessage_clean_name_title(1)
          ,Base_Contacts_Fields.InvalidMessage_clean_name_lname(1)
          ,Base_Contacts_Fields.InvalidMessage_physical_address_prim_name(1)
          ,Base_Contacts_Fields.InvalidMessage_physical_address_p_city_name(1)
          ,Base_Contacts_Fields.InvalidMessage_physical_address_v_city_name(1)
          ,Base_Contacts_Fields.InvalidMessage_physical_address_st(1)
          ,Base_Contacts_Fields.InvalidMessage_physical_address_zip(1)
          ,Base_Contacts_Fields.InvalidMessage_mailing_address_prim_name(1)
          ,Base_Contacts_Fields.InvalidMessage_mailing_address_p_city_name(1)
          ,Base_Contacts_Fields.InvalidMessage_mailing_address_v_city_name(1)
          ,Base_Contacts_Fields.InvalidMessage_mailing_address_st(1)
          ,Base_Contacts_Fields.InvalidMessage_mailing_address_zip(1)
          ,Base_Contacts_Fields.InvalidMessage_clean_phones_phone(1)
          ,Base_Contacts_Fields.InvalidMessage_clean_phones_fax(1)
          ,Base_Contacts_Fields.InvalidMessage_clean_phones_telex(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.rid_CUSTOM_ErrorCount
          ,le.did_CUSTOM_ErrorCount
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
          ,le.rawfields_name_LENGTH_ErrorCount
          ,le.rawfields_executive_name_LENGTH_ErrorCount
          ,le.rawfields_executive_title_LENGTH_ErrorCount
          ,le.rawfields_executive_code_LENGTH_ErrorCount
          ,le.clean_name_title_LENGTH_ErrorCount
          ,le.clean_name_lname_LENGTH_ErrorCount
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
          ,le.clean_phones_telex_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.rid_CUSTOM_ErrorCount
          ,le.did_CUSTOM_ErrorCount
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
          ,le.rawfields_name_LENGTH_ErrorCount
          ,le.rawfields_executive_name_LENGTH_ErrorCount
          ,le.rawfields_executive_title_LENGTH_ErrorCount
          ,le.rawfields_executive_code_LENGTH_ErrorCount
          ,le.clean_name_title_LENGTH_ErrorCount
          ,le.clean_name_lname_LENGTH_ErrorCount
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
          ,le.clean_phones_telex_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,41,Into(LEFT,COUNTER));
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

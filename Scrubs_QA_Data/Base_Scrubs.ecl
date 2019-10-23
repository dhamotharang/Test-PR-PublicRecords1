IMPORT ut,SALT34;
IMPORT Scrubs_QA_Data; // Import modules for FieldTypes attribute definitions
EXPORT Base_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Base_Layout_QA_Data)
    UNSIGNED1 powid_Invalid;
    UNSIGNED1 proxid_Invalid;
    UNSIGNED1 seleid_Invalid;
    UNSIGNED1 orgid_Invalid;
    UNSIGNED1 ultid_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 rawtrans_masteraddressid_Invalid;
    UNSIGNED1 rawtrans_date_Invalid;
    UNSIGNED1 rawtrans_category_Invalid;
    UNSIGNED1 rawaddr_databasematchcode_Invalid;
    UNSIGNED1 rawaddr_homebusinessflag_Invalid;
    UNSIGNED1 rawaddr_masteraddressid_Invalid;
    UNSIGNED1 prep_trans_line1_Invalid;
    UNSIGNED1 prep_trans_line_last_Invalid;
    UNSIGNED1 prep_addr_line1_Invalid;
    UNSIGNED1 prep_addr_line_last_Invalid;
    UNSIGNED1 trans_address_prim_name_Invalid;
    UNSIGNED1 trans_address_p_city_name_Invalid;
    UNSIGNED1 trans_address_v_city_name_Invalid;
    UNSIGNED1 trans_address_st_Invalid;
    UNSIGNED1 trans_address_zip_Invalid;
    UNSIGNED1 addr_address_prim_name_Invalid;
    UNSIGNED1 addr_address_p_city_name_Invalid;
    UNSIGNED1 addr_address_v_city_name_Invalid;
    UNSIGNED1 addr_address_st_Invalid;
    UNSIGNED1 addr_address_zip_Invalid;
    UNSIGNED1 clean_person_type_Invalid;
    UNSIGNED1 clean_person_name_fname_Invalid;
    UNSIGNED1 clean_person_name_lname_Invalid;
    UNSIGNED1 clean_phone_Invalid;
    UNSIGNED1 clean_company_Invalid;
    UNSIGNED1 nametype_Invalid;
    UNSIGNED1 source_rec_id_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Layout_QA_Data)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_Layout_QA_Data) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.powid_Invalid := Base_Fields.InValid_powid((SALT34.StrType)le.powid);
    SELF.proxid_Invalid := Base_Fields.InValid_proxid((SALT34.StrType)le.proxid);
    SELF.seleid_Invalid := Base_Fields.InValid_seleid((SALT34.StrType)le.seleid);
    SELF.orgid_Invalid := Base_Fields.InValid_orgid((SALT34.StrType)le.orgid);
    SELF.ultid_Invalid := Base_Fields.InValid_ultid((SALT34.StrType)le.ultid);
    SELF.did_Invalid := Base_Fields.InValid_did((SALT34.StrType)le.did);
    SELF.dt_first_seen_Invalid := Base_Fields.InValid_dt_first_seen((SALT34.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Base_Fields.InValid_dt_last_seen((SALT34.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Base_Fields.InValid_dt_vendor_first_reported((SALT34.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Base_Fields.InValid_dt_vendor_last_reported((SALT34.StrType)le.dt_vendor_last_reported);
    SELF.record_type_Invalid := Base_Fields.InValid_record_type((SALT34.StrType)le.record_type);
    SELF.rawtrans_masteraddressid_Invalid := Base_Fields.InValid_rawtrans_masteraddressid((SALT34.StrType)le.rawtrans_masteraddressid);
    SELF.rawtrans_date_Invalid := Base_Fields.InValid_rawtrans_date((SALT34.StrType)le.rawtrans_date);
    SELF.rawtrans_category_Invalid := Base_Fields.InValid_rawtrans_category((SALT34.StrType)le.rawtrans_category);
    SELF.rawaddr_databasematchcode_Invalid := Base_Fields.InValid_rawaddr_databasematchcode((SALT34.StrType)le.rawaddr_databasematchcode);
    SELF.rawaddr_homebusinessflag_Invalid := Base_Fields.InValid_rawaddr_homebusinessflag((SALT34.StrType)le.rawaddr_homebusinessflag);
    SELF.rawaddr_masteraddressid_Invalid := Base_Fields.InValid_rawaddr_masteraddressid((SALT34.StrType)le.rawaddr_masteraddressid);
    SELF.prep_trans_line1_Invalid := Base_Fields.InValid_prep_trans_line1((SALT34.StrType)le.prep_trans_line1);
    SELF.prep_trans_line_last_Invalid := Base_Fields.InValid_prep_trans_line_last((SALT34.StrType)le.prep_trans_line_last);
    SELF.prep_addr_line1_Invalid := Base_Fields.InValid_prep_addr_line1((SALT34.StrType)le.prep_addr_line1);
    SELF.prep_addr_line_last_Invalid := Base_Fields.InValid_prep_addr_line_last((SALT34.StrType)le.prep_addr_line_last);
    SELF.trans_address_prim_name_Invalid := Base_Fields.InValid_trans_address_prim_name((SALT34.StrType)le.trans_address_prim_name);
    SELF.trans_address_p_city_name_Invalid := Base_Fields.InValid_trans_address_p_city_name((SALT34.StrType)le.trans_address_p_city_name);
    SELF.trans_address_v_city_name_Invalid := Base_Fields.InValid_trans_address_v_city_name((SALT34.StrType)le.trans_address_v_city_name);
    SELF.trans_address_st_Invalid := Base_Fields.InValid_trans_address_st((SALT34.StrType)le.trans_address_st);
    SELF.trans_address_zip_Invalid := Base_Fields.InValid_trans_address_zip((SALT34.StrType)le.trans_address_zip);
    SELF.addr_address_prim_name_Invalid := Base_Fields.InValid_addr_address_prim_name((SALT34.StrType)le.addr_address_prim_name);
    SELF.addr_address_p_city_name_Invalid := Base_Fields.InValid_addr_address_p_city_name((SALT34.StrType)le.addr_address_p_city_name);
    SELF.addr_address_v_city_name_Invalid := Base_Fields.InValid_addr_address_v_city_name((SALT34.StrType)le.addr_address_v_city_name);
    SELF.addr_address_st_Invalid := Base_Fields.InValid_addr_address_st((SALT34.StrType)le.addr_address_st);
    SELF.addr_address_zip_Invalid := Base_Fields.InValid_addr_address_zip((SALT34.StrType)le.addr_address_zip);
    SELF.clean_person_type_Invalid := Base_Fields.InValid_clean_person_type((SALT34.StrType)le.clean_person_type);
    SELF.clean_person_name_fname_Invalid := Base_Fields.InValid_clean_person_name_fname((SALT34.StrType)le.clean_person_name_fname);
    SELF.clean_person_name_lname_Invalid := Base_Fields.InValid_clean_person_name_lname((SALT34.StrType)le.clean_person_name_lname);
    SELF.clean_phone_Invalid := Base_Fields.InValid_clean_phone((SALT34.StrType)le.clean_phone);
    SELF.clean_company_Invalid := Base_Fields.InValid_clean_company((SALT34.StrType)le.clean_company);
    SELF.nametype_Invalid := Base_Fields.InValid_nametype((SALT34.StrType)le.nametype);
    SELF.source_rec_id_Invalid := Base_Fields.InValid_source_rec_id((SALT34.StrType)le.source_rec_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Layout_QA_Data);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.powid_Invalid << 0 ) + ( le.proxid_Invalid << 1 ) + ( le.seleid_Invalid << 2 ) + ( le.orgid_Invalid << 3 ) + ( le.ultid_Invalid << 4 ) + ( le.did_Invalid << 5 ) + ( le.dt_first_seen_Invalid << 6 ) + ( le.dt_last_seen_Invalid << 7 ) + ( le.dt_vendor_first_reported_Invalid << 8 ) + ( le.dt_vendor_last_reported_Invalid << 9 ) + ( le.record_type_Invalid << 10 ) + ( le.rawtrans_masteraddressid_Invalid << 11 ) + ( le.rawtrans_date_Invalid << 12 ) + ( le.rawtrans_category_Invalid << 13 ) + ( le.rawaddr_databasematchcode_Invalid << 14 ) + ( le.rawaddr_homebusinessflag_Invalid << 15 ) + ( le.rawaddr_masteraddressid_Invalid << 16 ) + ( le.prep_trans_line1_Invalid << 17 ) + ( le.prep_trans_line_last_Invalid << 18 ) + ( le.prep_addr_line1_Invalid << 19 ) + ( le.prep_addr_line_last_Invalid << 20 ) + ( le.trans_address_prim_name_Invalid << 21 ) + ( le.trans_address_p_city_name_Invalid << 22 ) + ( le.trans_address_v_city_name_Invalid << 23 ) + ( le.trans_address_st_Invalid << 24 ) + ( le.trans_address_zip_Invalid << 25 ) + ( le.addr_address_prim_name_Invalid << 26 ) + ( le.addr_address_p_city_name_Invalid << 27 ) + ( le.addr_address_v_city_name_Invalid << 28 ) + ( le.addr_address_st_Invalid << 29 ) + ( le.addr_address_zip_Invalid << 30 ) + ( le.clean_person_type_Invalid << 31 ) + ( le.clean_person_name_fname_Invalid << 32 ) + ( le.clean_person_name_lname_Invalid << 33 ) + ( le.clean_phone_Invalid << 34 ) + ( le.clean_company_Invalid << 35 ) + ( le.nametype_Invalid << 36 ) + ( le.source_rec_id_Invalid << 37 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Layout_QA_Data);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.powid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.proxid_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.ultid_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.rawtrans_masteraddressid_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.rawtrans_date_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.rawtrans_category_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.rawaddr_databasematchcode_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.rawaddr_homebusinessflag_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.rawaddr_masteraddressid_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.prep_trans_line1_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.prep_trans_line_last_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.prep_addr_line1_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.prep_addr_line_last_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.trans_address_prim_name_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.trans_address_p_city_name_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.trans_address_v_city_name_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.trans_address_st_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.trans_address_zip_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.addr_address_prim_name_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.addr_address_p_city_name_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.addr_address_v_city_name_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.addr_address_st_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.addr_address_zip_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.clean_person_type_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.clean_person_name_fname_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.clean_person_name_lname_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.clean_phone_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.clean_company_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.nametype_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.source_rec_id_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    powid_LENGTH_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    proxid_LENGTH_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    seleid_LENGTH_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    orgid_LENGTH_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    ultid_LENGTH_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    did_LENGTH_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    rawtrans_masteraddressid_CUSTOM_ErrorCount := COUNT(GROUP,h.rawtrans_masteraddressid_Invalid=1);
    rawtrans_date_CUSTOM_ErrorCount := COUNT(GROUP,h.rawtrans_date_Invalid=1);
    rawtrans_category_LENGTH_ErrorCount := COUNT(GROUP,h.rawtrans_category_Invalid=1);
    rawaddr_databasematchcode_ENUM_ErrorCount := COUNT(GROUP,h.rawaddr_databasematchcode_Invalid=1);
    rawaddr_homebusinessflag_ENUM_ErrorCount := COUNT(GROUP,h.rawaddr_homebusinessflag_Invalid=1);
    rawaddr_masteraddressid_CUSTOM_ErrorCount := COUNT(GROUP,h.rawaddr_masteraddressid_Invalid=1);
    prep_trans_line1_LENGTH_ErrorCount := COUNT(GROUP,h.prep_trans_line1_Invalid=1);
    prep_trans_line_last_LENGTH_ErrorCount := COUNT(GROUP,h.prep_trans_line_last_Invalid=1);
    prep_addr_line1_LENGTH_ErrorCount := COUNT(GROUP,h.prep_addr_line1_Invalid=1);
    prep_addr_line_last_LENGTH_ErrorCount := COUNT(GROUP,h.prep_addr_line_last_Invalid=1);
    trans_address_prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.trans_address_prim_name_Invalid=1);
    trans_address_p_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.trans_address_p_city_name_Invalid=1);
    trans_address_v_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.trans_address_v_city_name_Invalid=1);
    trans_address_st_CUSTOM_ErrorCount := COUNT(GROUP,h.trans_address_st_Invalid=1);
    trans_address_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.trans_address_zip_Invalid=1);
    addr_address_prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.addr_address_prim_name_Invalid=1);
    addr_address_p_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.addr_address_p_city_name_Invalid=1);
    addr_address_v_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.addr_address_v_city_name_Invalid=1);
    addr_address_st_CUSTOM_ErrorCount := COUNT(GROUP,h.addr_address_st_Invalid=1);
    addr_address_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.addr_address_zip_Invalid=1);
    clean_person_type_ENUM_ErrorCount := COUNT(GROUP,h.clean_person_type_Invalid=1);
    clean_person_name_fname_ALLOW_ErrorCount := COUNT(GROUP,h.clean_person_name_fname_Invalid=1);
    clean_person_name_lname_ALLOW_ErrorCount := COUNT(GROUP,h.clean_person_name_lname_Invalid=1);
    clean_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=1);
    clean_company_LENGTH_ErrorCount := COUNT(GROUP,h.clean_company_Invalid=1);
    nametype_ENUM_ErrorCount := COUNT(GROUP,h.nametype_Invalid=1);
    source_rec_id_CUSTOM_ErrorCount := COUNT(GROUP,h.source_rec_id_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.powid_Invalid,le.proxid_Invalid,le.seleid_Invalid,le.orgid_Invalid,le.ultid_Invalid,le.did_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.record_type_Invalid,le.rawtrans_masteraddressid_Invalid,le.rawtrans_date_Invalid,le.rawtrans_category_Invalid,le.rawaddr_databasematchcode_Invalid,le.rawaddr_homebusinessflag_Invalid,le.rawaddr_masteraddressid_Invalid,le.prep_trans_line1_Invalid,le.prep_trans_line_last_Invalid,le.prep_addr_line1_Invalid,le.prep_addr_line_last_Invalid,le.trans_address_prim_name_Invalid,le.trans_address_p_city_name_Invalid,le.trans_address_v_city_name_Invalid,le.trans_address_st_Invalid,le.trans_address_zip_Invalid,le.addr_address_prim_name_Invalid,le.addr_address_p_city_name_Invalid,le.addr_address_v_city_name_Invalid,le.addr_address_st_Invalid,le.addr_address_zip_Invalid,le.clean_person_type_Invalid,le.clean_person_name_fname_Invalid,le.clean_person_name_lname_Invalid,le.clean_phone_Invalid,le.clean_company_Invalid,le.nametype_Invalid,le.source_rec_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Fields.InvalidMessage_powid(le.powid_Invalid),Base_Fields.InvalidMessage_proxid(le.proxid_Invalid),Base_Fields.InvalidMessage_seleid(le.seleid_Invalid),Base_Fields.InvalidMessage_orgid(le.orgid_Invalid),Base_Fields.InvalidMessage_ultid(le.ultid_Invalid),Base_Fields.InvalidMessage_did(le.did_Invalid),Base_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Base_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Base_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Base_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Base_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_Fields.InvalidMessage_rawtrans_masteraddressid(le.rawtrans_masteraddressid_Invalid),Base_Fields.InvalidMessage_rawtrans_date(le.rawtrans_date_Invalid),Base_Fields.InvalidMessage_rawtrans_category(le.rawtrans_category_Invalid),Base_Fields.InvalidMessage_rawaddr_databasematchcode(le.rawaddr_databasematchcode_Invalid),Base_Fields.InvalidMessage_rawaddr_homebusinessflag(le.rawaddr_homebusinessflag_Invalid),Base_Fields.InvalidMessage_rawaddr_masteraddressid(le.rawaddr_masteraddressid_Invalid),Base_Fields.InvalidMessage_prep_trans_line1(le.prep_trans_line1_Invalid),Base_Fields.InvalidMessage_prep_trans_line_last(le.prep_trans_line_last_Invalid),Base_Fields.InvalidMessage_prep_addr_line1(le.prep_addr_line1_Invalid),Base_Fields.InvalidMessage_prep_addr_line_last(le.prep_addr_line_last_Invalid),Base_Fields.InvalidMessage_trans_address_prim_name(le.trans_address_prim_name_Invalid),Base_Fields.InvalidMessage_trans_address_p_city_name(le.trans_address_p_city_name_Invalid),Base_Fields.InvalidMessage_trans_address_v_city_name(le.trans_address_v_city_name_Invalid),Base_Fields.InvalidMessage_trans_address_st(le.trans_address_st_Invalid),Base_Fields.InvalidMessage_trans_address_zip(le.trans_address_zip_Invalid),Base_Fields.InvalidMessage_addr_address_prim_name(le.addr_address_prim_name_Invalid),Base_Fields.InvalidMessage_addr_address_p_city_name(le.addr_address_p_city_name_Invalid),Base_Fields.InvalidMessage_addr_address_v_city_name(le.addr_address_v_city_name_Invalid),Base_Fields.InvalidMessage_addr_address_st(le.addr_address_st_Invalid),Base_Fields.InvalidMessage_addr_address_zip(le.addr_address_zip_Invalid),Base_Fields.InvalidMessage_clean_person_type(le.clean_person_type_Invalid),Base_Fields.InvalidMessage_clean_person_name_fname(le.clean_person_name_fname_Invalid),Base_Fields.InvalidMessage_clean_person_name_lname(le.clean_person_name_lname_Invalid),Base_Fields.InvalidMessage_clean_phone(le.clean_phone_Invalid),Base_Fields.InvalidMessage_clean_company(le.clean_company_Invalid),Base_Fields.InvalidMessage_nametype(le.nametype_Invalid),Base_Fields.InvalidMessage_source_rec_id(le.source_rec_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.powid_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.rawtrans_masteraddressid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawtrans_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawtrans_category_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.rawaddr_databasematchcode_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.rawaddr_homebusinessflag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.rawaddr_masteraddressid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prep_trans_line1_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prep_trans_line_last_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prep_addr_line1_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prep_addr_line_last_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.trans_address_prim_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.trans_address_p_city_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.trans_address_v_city_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.trans_address_st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.trans_address_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.addr_address_prim_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.addr_address_p_city_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.addr_address_v_city_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.addr_address_st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.addr_address_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_person_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.clean_person_name_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_person_name_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_company_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.nametype_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.source_rec_id_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'powid','proxid','seleid','orgid','ultid','did','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','rawtrans_masteraddressid','rawtrans_date','rawtrans_category','rawaddr_databasematchcode','rawaddr_homebusinessflag','rawaddr_masteraddressid','prep_trans_line1','prep_trans_line_last','prep_addr_line1','prep_addr_line_last','trans_address_prim_name','trans_address_p_city_name','trans_address_v_city_name','trans_address_st','trans_address_zip','addr_address_prim_name','addr_address_p_city_name','addr_address_v_city_name','addr_address_st','addr_address_zip','clean_person_type','clean_person_name_fname','clean_person_name_lname','clean_phone','clean_company','nametype','source_rec_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_record_type','invalid_numeric_or_blank','invalid_date_time','invalid_mandatory','invalid_db_match','invalid_home_business','invalid_numeric','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_st','invalid_zip5','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_st','invalid_zip5','invalid_person_type','invalid_alphanum_specials','invalid_alphanum_specials','invalid_phone','invalid_mandatory','invalid_nametype','invalid_src_rid','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT34.StrType)le.powid,(SALT34.StrType)le.proxid,(SALT34.StrType)le.seleid,(SALT34.StrType)le.orgid,(SALT34.StrType)le.ultid,(SALT34.StrType)le.did,(SALT34.StrType)le.dt_first_seen,(SALT34.StrType)le.dt_last_seen,(SALT34.StrType)le.dt_vendor_first_reported,(SALT34.StrType)le.dt_vendor_last_reported,(SALT34.StrType)le.record_type,(SALT34.StrType)le.rawtrans_masteraddressid,(SALT34.StrType)le.rawtrans_date,(SALT34.StrType)le.rawtrans_category,(SALT34.StrType)le.rawaddr_databasematchcode,(SALT34.StrType)le.rawaddr_homebusinessflag,(SALT34.StrType)le.rawaddr_masteraddressid,(SALT34.StrType)le.prep_trans_line1,(SALT34.StrType)le.prep_trans_line_last,(SALT34.StrType)le.prep_addr_line1,(SALT34.StrType)le.prep_addr_line_last,(SALT34.StrType)le.trans_address_prim_name,(SALT34.StrType)le.trans_address_p_city_name,(SALT34.StrType)le.trans_address_v_city_name,(SALT34.StrType)le.trans_address_st,(SALT34.StrType)le.trans_address_zip,(SALT34.StrType)le.addr_address_prim_name,(SALT34.StrType)le.addr_address_p_city_name,(SALT34.StrType)le.addr_address_v_city_name,(SALT34.StrType)le.addr_address_st,(SALT34.StrType)le.addr_address_zip,(SALT34.StrType)le.clean_person_type,(SALT34.StrType)le.clean_person_name_fname,(SALT34.StrType)le.clean_person_name_lname,(SALT34.StrType)le.clean_phone,(SALT34.StrType)le.clean_company,(SALT34.StrType)le.nametype,(SALT34.StrType)le.source_rec_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,38,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT34.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'powid:invalid_mandatory:LENGTH'
          ,'proxid:invalid_mandatory:LENGTH'
          ,'seleid:invalid_mandatory:LENGTH'
          ,'orgid:invalid_mandatory:LENGTH'
          ,'ultid:invalid_mandatory:LENGTH'
          ,'did:invalid_mandatory:LENGTH'
          ,'dt_first_seen:invalid_pastdate8:CUSTOM'
          ,'dt_last_seen:invalid_pastdate8:CUSTOM'
          ,'dt_vendor_first_reported:invalid_pastdate8:CUSTOM'
          ,'dt_vendor_last_reported:invalid_pastdate8:CUSTOM'
          ,'record_type:invalid_record_type:ENUM'
          ,'rawtrans_masteraddressid:invalid_numeric_or_blank:CUSTOM'
          ,'rawtrans_date:invalid_date_time:CUSTOM'
          ,'rawtrans_category:invalid_mandatory:LENGTH'
          ,'rawaddr_databasematchcode:invalid_db_match:ENUM'
          ,'rawaddr_homebusinessflag:invalid_home_business:ENUM'
          ,'rawaddr_masteraddressid:invalid_numeric:CUSTOM'
          ,'prep_trans_line1:invalid_mandatory:LENGTH'
          ,'prep_trans_line_last:invalid_mandatory:LENGTH'
          ,'prep_addr_line1:invalid_mandatory:LENGTH'
          ,'prep_addr_line_last:invalid_mandatory:LENGTH'
          ,'trans_address_prim_name:invalid_mandatory:LENGTH'
          ,'trans_address_p_city_name:invalid_mandatory:LENGTH'
          ,'trans_address_v_city_name:invalid_mandatory:LENGTH'
          ,'trans_address_st:invalid_st:CUSTOM'
          ,'trans_address_zip:invalid_zip5:CUSTOM'
          ,'addr_address_prim_name:invalid_mandatory:LENGTH'
          ,'addr_address_p_city_name:invalid_mandatory:LENGTH'
          ,'addr_address_v_city_name:invalid_mandatory:LENGTH'
          ,'addr_address_st:invalid_st:CUSTOM'
          ,'addr_address_zip:invalid_zip5:CUSTOM'
          ,'clean_person_type:invalid_person_type:ENUM'
          ,'clean_person_name_fname:invalid_alphanum_specials:ALLOW'
          ,'clean_person_name_lname:invalid_alphanum_specials:ALLOW'
          ,'clean_phone:invalid_phone:CUSTOM'
          ,'clean_company:invalid_mandatory:LENGTH'
          ,'nametype:invalid_nametype:ENUM'
          ,'source_rec_id:invalid_src_rid:CUSTOM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Fields.InvalidMessage_powid(1)
          ,Base_Fields.InvalidMessage_proxid(1)
          ,Base_Fields.InvalidMessage_seleid(1)
          ,Base_Fields.InvalidMessage_orgid(1)
          ,Base_Fields.InvalidMessage_ultid(1)
          ,Base_Fields.InvalidMessage_did(1)
          ,Base_Fields.InvalidMessage_dt_first_seen(1)
          ,Base_Fields.InvalidMessage_dt_last_seen(1)
          ,Base_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Base_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Base_Fields.InvalidMessage_record_type(1)
          ,Base_Fields.InvalidMessage_rawtrans_masteraddressid(1)
          ,Base_Fields.InvalidMessage_rawtrans_date(1)
          ,Base_Fields.InvalidMessage_rawtrans_category(1)
          ,Base_Fields.InvalidMessage_rawaddr_databasematchcode(1)
          ,Base_Fields.InvalidMessage_rawaddr_homebusinessflag(1)
          ,Base_Fields.InvalidMessage_rawaddr_masteraddressid(1)
          ,Base_Fields.InvalidMessage_prep_trans_line1(1)
          ,Base_Fields.InvalidMessage_prep_trans_line_last(1)
          ,Base_Fields.InvalidMessage_prep_addr_line1(1)
          ,Base_Fields.InvalidMessage_prep_addr_line_last(1)
          ,Base_Fields.InvalidMessage_trans_address_prim_name(1)
          ,Base_Fields.InvalidMessage_trans_address_p_city_name(1)
          ,Base_Fields.InvalidMessage_trans_address_v_city_name(1)
          ,Base_Fields.InvalidMessage_trans_address_st(1)
          ,Base_Fields.InvalidMessage_trans_address_zip(1)
          ,Base_Fields.InvalidMessage_addr_address_prim_name(1)
          ,Base_Fields.InvalidMessage_addr_address_p_city_name(1)
          ,Base_Fields.InvalidMessage_addr_address_v_city_name(1)
          ,Base_Fields.InvalidMessage_addr_address_st(1)
          ,Base_Fields.InvalidMessage_addr_address_zip(1)
          ,Base_Fields.InvalidMessage_clean_person_type(1)
          ,Base_Fields.InvalidMessage_clean_person_name_fname(1)
          ,Base_Fields.InvalidMessage_clean_person_name_lname(1)
          ,Base_Fields.InvalidMessage_clean_phone(1)
          ,Base_Fields.InvalidMessage_clean_company(1)
          ,Base_Fields.InvalidMessage_nametype(1)
          ,Base_Fields.InvalidMessage_source_rec_id(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.powid_LENGTH_ErrorCount
          ,le.proxid_LENGTH_ErrorCount
          ,le.seleid_LENGTH_ErrorCount
          ,le.orgid_LENGTH_ErrorCount
          ,le.ultid_LENGTH_ErrorCount
          ,le.did_LENGTH_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.rawtrans_masteraddressid_CUSTOM_ErrorCount
          ,le.rawtrans_date_CUSTOM_ErrorCount
          ,le.rawtrans_category_LENGTH_ErrorCount
          ,le.rawaddr_databasematchcode_ENUM_ErrorCount
          ,le.rawaddr_homebusinessflag_ENUM_ErrorCount
          ,le.rawaddr_masteraddressid_CUSTOM_ErrorCount
          ,le.prep_trans_line1_LENGTH_ErrorCount
          ,le.prep_trans_line_last_LENGTH_ErrorCount
          ,le.prep_addr_line1_LENGTH_ErrorCount
          ,le.prep_addr_line_last_LENGTH_ErrorCount
          ,le.trans_address_prim_name_LENGTH_ErrorCount
          ,le.trans_address_p_city_name_LENGTH_ErrorCount
          ,le.trans_address_v_city_name_LENGTH_ErrorCount
          ,le.trans_address_st_CUSTOM_ErrorCount
          ,le.trans_address_zip_CUSTOM_ErrorCount
          ,le.addr_address_prim_name_LENGTH_ErrorCount
          ,le.addr_address_p_city_name_LENGTH_ErrorCount
          ,le.addr_address_v_city_name_LENGTH_ErrorCount
          ,le.addr_address_st_CUSTOM_ErrorCount
          ,le.addr_address_zip_CUSTOM_ErrorCount
          ,le.clean_person_type_ENUM_ErrorCount
          ,le.clean_person_name_fname_ALLOW_ErrorCount
          ,le.clean_person_name_lname_ALLOW_ErrorCount
          ,le.clean_phone_CUSTOM_ErrorCount
          ,le.clean_company_LENGTH_ErrorCount
          ,le.nametype_ENUM_ErrorCount
          ,le.source_rec_id_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.powid_LENGTH_ErrorCount
          ,le.proxid_LENGTH_ErrorCount
          ,le.seleid_LENGTH_ErrorCount
          ,le.orgid_LENGTH_ErrorCount
          ,le.ultid_LENGTH_ErrorCount
          ,le.did_LENGTH_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.rawtrans_masteraddressid_CUSTOM_ErrorCount
          ,le.rawtrans_date_CUSTOM_ErrorCount
          ,le.rawtrans_category_LENGTH_ErrorCount
          ,le.rawaddr_databasematchcode_ENUM_ErrorCount
          ,le.rawaddr_homebusinessflag_ENUM_ErrorCount
          ,le.rawaddr_masteraddressid_CUSTOM_ErrorCount
          ,le.prep_trans_line1_LENGTH_ErrorCount
          ,le.prep_trans_line_last_LENGTH_ErrorCount
          ,le.prep_addr_line1_LENGTH_ErrorCount
          ,le.prep_addr_line_last_LENGTH_ErrorCount
          ,le.trans_address_prim_name_LENGTH_ErrorCount
          ,le.trans_address_p_city_name_LENGTH_ErrorCount
          ,le.trans_address_v_city_name_LENGTH_ErrorCount
          ,le.trans_address_st_CUSTOM_ErrorCount
          ,le.trans_address_zip_CUSTOM_ErrorCount
          ,le.addr_address_prim_name_LENGTH_ErrorCount
          ,le.addr_address_p_city_name_LENGTH_ErrorCount
          ,le.addr_address_v_city_name_LENGTH_ErrorCount
          ,le.addr_address_st_CUSTOM_ErrorCount
          ,le.addr_address_zip_CUSTOM_ErrorCount
          ,le.clean_person_type_ENUM_ErrorCount
          ,le.clean_person_name_fname_ALLOW_ErrorCount
          ,le.clean_person_name_lname_ALLOW_ErrorCount
          ,le.clean_phone_CUSTOM_ErrorCount
          ,le.clean_company_LENGTH_ErrorCount
          ,le.nametype_ENUM_ErrorCount
          ,le.source_rec_id_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,38,Into(LEFT,COUNTER));
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

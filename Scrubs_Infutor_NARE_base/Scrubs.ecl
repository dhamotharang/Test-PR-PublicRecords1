IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_Infutor_NARE_base)
    UNSIGNED1 idnum_Invalid;
    UNSIGNED1 firstname_Invalid;
    UNSIGNED1 middlename_Invalid;
    UNSIGNED1 lastname_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 zipcode_Invalid;
    UNSIGNED1 zipplus4_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 phone2_Invalid;
    UNSIGNED1 datefirstseen_Invalid;
    UNSIGNED1 datelastseen_Invalid;
    UNSIGNED1 filedate_Invalid;
    UNSIGNED1 age_Invalid;
    UNSIGNED1 clean_title_Invalid;
    UNSIGNED1 clean_fname_Invalid;
    UNSIGNED1 clean_mname_Invalid;
    UNSIGNED1 clean_lname_Invalid;
    UNSIGNED1 clean_name_suffix_Invalid;
    UNSIGNED1 clean_prim_range_Invalid;
    UNSIGNED1 clean_predir_Invalid;
    UNSIGNED1 clean_prim_name_Invalid;
    UNSIGNED1 clean_addr_suffix_Invalid;
    UNSIGNED1 clean_postdir_Invalid;
    UNSIGNED1 clean_p_city_name_Invalid;
    UNSIGNED1 clean_v_city_name_Invalid;
    UNSIGNED1 clean_st_Invalid;
    UNSIGNED1 clean_zip_Invalid;
    UNSIGNED1 clean_zip4_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Infutor_NARE_base)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Layout_Infutor_NARE_base) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.idnum_Invalid := Fields.InValid_idnum((SALT30.StrType)le.idnum);
    SELF.firstname_Invalid := Fields.InValid_firstname((SALT30.StrType)le.firstname);
    SELF.middlename_Invalid := Fields.InValid_middlename((SALT30.StrType)le.middlename);
    SELF.lastname_Invalid := Fields.InValid_lastname((SALT30.StrType)le.lastname);
    SELF.suffix_Invalid := Fields.InValid_suffix((SALT30.StrType)le.suffix);
    SELF.gender_Invalid := Fields.InValid_gender((SALT30.StrType)le.gender);
    SELF.dob_Invalid := Fields.InValid_dob((SALT30.StrType)le.dob);
    SELF.zipcode_Invalid := Fields.InValid_zipcode((SALT30.StrType)le.zipcode);
    SELF.zipplus4_Invalid := Fields.InValid_zipplus4((SALT30.StrType)le.zipplus4);
    SELF.phone_Invalid := Fields.InValid_phone((SALT30.StrType)le.phone);
    SELF.phone2_Invalid := Fields.InValid_phone2((SALT30.StrType)le.phone2);
    SELF.datefirstseen_Invalid := Fields.InValid_datefirstseen((SALT30.StrType)le.datefirstseen);
    SELF.datelastseen_Invalid := Fields.InValid_datelastseen((SALT30.StrType)le.datelastseen);
    SELF.filedate_Invalid := Fields.InValid_filedate((SALT30.StrType)le.filedate);
    SELF.age_Invalid := Fields.InValid_age((SALT30.StrType)le.age);
    SELF.clean_title_Invalid := Fields.InValid_clean_title((SALT30.StrType)le.clean_title);
    SELF.clean_fname_Invalid := Fields.InValid_clean_fname((SALT30.StrType)le.clean_fname);
    SELF.clean_mname_Invalid := Fields.InValid_clean_mname((SALT30.StrType)le.clean_mname);
    SELF.clean_lname_Invalid := Fields.InValid_clean_lname((SALT30.StrType)le.clean_lname);
    SELF.clean_name_suffix_Invalid := Fields.InValid_clean_name_suffix((SALT30.StrType)le.clean_name_suffix);
    SELF.clean_prim_range_Invalid := Fields.InValid_clean_prim_range((SALT30.StrType)le.clean_prim_range);
    SELF.clean_predir_Invalid := Fields.InValid_clean_predir((SALT30.StrType)le.clean_predir);
    SELF.clean_prim_name_Invalid := Fields.InValid_clean_prim_name((SALT30.StrType)le.clean_prim_name);
    SELF.clean_addr_suffix_Invalid := Fields.InValid_clean_addr_suffix((SALT30.StrType)le.clean_addr_suffix);
    SELF.clean_postdir_Invalid := Fields.InValid_clean_postdir((SALT30.StrType)le.clean_postdir);
    SELF.clean_p_city_name_Invalid := Fields.InValid_clean_p_city_name((SALT30.StrType)le.clean_p_city_name);
    SELF.clean_v_city_name_Invalid := Fields.InValid_clean_v_city_name((SALT30.StrType)le.clean_v_city_name);
    SELF.clean_st_Invalid := Fields.InValid_clean_st((SALT30.StrType)le.clean_st);
    SELF.clean_zip_Invalid := Fields.InValid_clean_zip((SALT30.StrType)le.clean_zip);
    SELF.clean_zip4_Invalid := Fields.InValid_clean_zip4((SALT30.StrType)le.clean_zip4);
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT30.StrType)le.process_date);
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT30.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT30.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT30.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT30.StrType)le.date_vendor_last_reported);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.idnum_Invalid << 0 ) + ( le.firstname_Invalid << 2 ) + ( le.middlename_Invalid << 4 ) + ( le.lastname_Invalid << 6 ) + ( le.suffix_Invalid << 8 ) + ( le.gender_Invalid << 10 ) + ( le.dob_Invalid << 12 ) + ( le.zipcode_Invalid << 14 ) + ( le.zipplus4_Invalid << 16 ) + ( le.phone_Invalid << 18 ) + ( le.phone2_Invalid << 20 ) + ( le.datefirstseen_Invalid << 22 ) + ( le.datelastseen_Invalid << 24 ) + ( le.filedate_Invalid << 26 ) + ( le.age_Invalid << 28 ) + ( le.clean_title_Invalid << 30 ) + ( le.clean_fname_Invalid << 32 ) + ( le.clean_mname_Invalid << 34 ) + ( le.clean_lname_Invalid << 36 ) + ( le.clean_name_suffix_Invalid << 38 ) + ( le.clean_prim_range_Invalid << 40 ) + ( le.clean_predir_Invalid << 42 ) + ( le.clean_prim_name_Invalid << 44 ) + ( le.clean_addr_suffix_Invalid << 46 ) + ( le.clean_postdir_Invalid << 48 ) + ( le.clean_p_city_name_Invalid << 50 ) + ( le.clean_v_city_name_Invalid << 52 ) + ( le.clean_st_Invalid << 54 ) + ( le.clean_zip_Invalid << 56 ) + ( le.clean_zip4_Invalid << 58 ) + ( le.process_date_Invalid << 60 ) + ( le.date_first_seen_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.date_last_seen_Invalid << 0 ) + ( le.date_vendor_first_reported_Invalid << 2 ) + ( le.date_vendor_last_reported_Invalid << 4 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Infutor_NARE_base);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.idnum_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.firstname_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.middlename_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.lastname_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.zipcode_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.zipplus4_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.phone2_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.datefirstseen_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.datelastseen_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.filedate_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.age_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.clean_title_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.clean_fname_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.clean_mname_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.clean_lname_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.clean_name_suffix_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.clean_prim_range_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.clean_predir_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.clean_prim_name_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.clean_addr_suffix_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.clean_postdir_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.clean_p_city_name_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.clean_v_city_name_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.clean_st_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.clean_zip_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.clean_zip4_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 60) & 3;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.date_last_seen_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    idnum_ALLOW_ErrorCount := COUNT(GROUP,h.idnum_Invalid=1);
    idnum_LENGTH_ErrorCount := COUNT(GROUP,h.idnum_Invalid=2);
    idnum_Total_ErrorCount := COUNT(GROUP,h.idnum_Invalid>0);
    firstname_ALLOW_ErrorCount := COUNT(GROUP,h.firstname_Invalid=1);
    firstname_LENGTH_ErrorCount := COUNT(GROUP,h.firstname_Invalid=2);
    firstname_Total_ErrorCount := COUNT(GROUP,h.firstname_Invalid>0);
    middlename_ALLOW_ErrorCount := COUNT(GROUP,h.middlename_Invalid=1);
    middlename_LENGTH_ErrorCount := COUNT(GROUP,h.middlename_Invalid=2);
    middlename_Total_ErrorCount := COUNT(GROUP,h.middlename_Invalid>0);
    lastname_ALLOW_ErrorCount := COUNT(GROUP,h.lastname_Invalid=1);
    lastname_LENGTH_ErrorCount := COUNT(GROUP,h.lastname_Invalid=2);
    lastname_Total_ErrorCount := COUNT(GROUP,h.lastname_Invalid>0);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    suffix_LENGTH_ErrorCount := COUNT(GROUP,h.suffix_Invalid=2);
    suffix_Total_ErrorCount := COUNT(GROUP,h.suffix_Invalid>0);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    gender_LENGTH_ErrorCount := COUNT(GROUP,h.gender_Invalid=2);
    gender_Total_ErrorCount := COUNT(GROUP,h.gender_Invalid>0);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_LENGTH_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    zipcode_ALLOW_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=1);
    zipcode_LENGTH_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=2);
    zipcode_Total_ErrorCount := COUNT(GROUP,h.zipcode_Invalid>0);
    zipplus4_ALLOW_ErrorCount := COUNT(GROUP,h.zipplus4_Invalid=1);
    zipplus4_LENGTH_ErrorCount := COUNT(GROUP,h.zipplus4_Invalid=2);
    zipplus4_Total_ErrorCount := COUNT(GROUP,h.zipplus4_Invalid>0);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_LENGTH_ErrorCount := COUNT(GROUP,h.phone_Invalid=2);
    phone_Total_ErrorCount := COUNT(GROUP,h.phone_Invalid>0);
    phone2_ALLOW_ErrorCount := COUNT(GROUP,h.phone2_Invalid=1);
    phone2_LENGTH_ErrorCount := COUNT(GROUP,h.phone2_Invalid=2);
    phone2_Total_ErrorCount := COUNT(GROUP,h.phone2_Invalid>0);
    datefirstseen_ALLOW_ErrorCount := COUNT(GROUP,h.datefirstseen_Invalid=1);
    datefirstseen_LENGTH_ErrorCount := COUNT(GROUP,h.datefirstseen_Invalid=2);
    datefirstseen_Total_ErrorCount := COUNT(GROUP,h.datefirstseen_Invalid>0);
    datelastseen_ALLOW_ErrorCount := COUNT(GROUP,h.datelastseen_Invalid=1);
    datelastseen_LENGTH_ErrorCount := COUNT(GROUP,h.datelastseen_Invalid=2);
    datelastseen_Total_ErrorCount := COUNT(GROUP,h.datelastseen_Invalid>0);
    filedate_ALLOW_ErrorCount := COUNT(GROUP,h.filedate_Invalid=1);
    filedate_LENGTH_ErrorCount := COUNT(GROUP,h.filedate_Invalid=2);
    filedate_Total_ErrorCount := COUNT(GROUP,h.filedate_Invalid>0);
    age_ALLOW_ErrorCount := COUNT(GROUP,h.age_Invalid=1);
    age_LENGTH_ErrorCount := COUNT(GROUP,h.age_Invalid=2);
    age_Total_ErrorCount := COUNT(GROUP,h.age_Invalid>0);
    clean_title_ALLOW_ErrorCount := COUNT(GROUP,h.clean_title_Invalid=1);
    clean_title_LENGTH_ErrorCount := COUNT(GROUP,h.clean_title_Invalid=2);
    clean_title_Total_ErrorCount := COUNT(GROUP,h.clean_title_Invalid>0);
    clean_fname_ALLOW_ErrorCount := COUNT(GROUP,h.clean_fname_Invalid=1);
    clean_fname_LENGTH_ErrorCount := COUNT(GROUP,h.clean_fname_Invalid=2);
    clean_fname_Total_ErrorCount := COUNT(GROUP,h.clean_fname_Invalid>0);
    clean_mname_ALLOW_ErrorCount := COUNT(GROUP,h.clean_mname_Invalid=1);
    clean_mname_LENGTH_ErrorCount := COUNT(GROUP,h.clean_mname_Invalid=2);
    clean_mname_Total_ErrorCount := COUNT(GROUP,h.clean_mname_Invalid>0);
    clean_lname_ALLOW_ErrorCount := COUNT(GROUP,h.clean_lname_Invalid=1);
    clean_lname_LENGTH_ErrorCount := COUNT(GROUP,h.clean_lname_Invalid=2);
    clean_lname_Total_ErrorCount := COUNT(GROUP,h.clean_lname_Invalid>0);
    clean_name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.clean_name_suffix_Invalid=1);
    clean_name_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.clean_name_suffix_Invalid=2);
    clean_name_suffix_Total_ErrorCount := COUNT(GROUP,h.clean_name_suffix_Invalid>0);
    clean_prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.clean_prim_range_Invalid=1);
    clean_prim_range_LENGTH_ErrorCount := COUNT(GROUP,h.clean_prim_range_Invalid=2);
    clean_prim_range_Total_ErrorCount := COUNT(GROUP,h.clean_prim_range_Invalid>0);
    clean_predir_ALLOW_ErrorCount := COUNT(GROUP,h.clean_predir_Invalid=1);
    clean_predir_LENGTH_ErrorCount := COUNT(GROUP,h.clean_predir_Invalid=2);
    clean_predir_Total_ErrorCount := COUNT(GROUP,h.clean_predir_Invalid>0);
    clean_prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_prim_name_Invalid=1);
    clean_prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.clean_prim_name_Invalid=2);
    clean_prim_name_Total_ErrorCount := COUNT(GROUP,h.clean_prim_name_Invalid>0);
    clean_addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.clean_addr_suffix_Invalid=1);
    clean_addr_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.clean_addr_suffix_Invalid=2);
    clean_addr_suffix_Total_ErrorCount := COUNT(GROUP,h.clean_addr_suffix_Invalid>0);
    clean_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.clean_postdir_Invalid=1);
    clean_postdir_LENGTH_ErrorCount := COUNT(GROUP,h.clean_postdir_Invalid=2);
    clean_postdir_Total_ErrorCount := COUNT(GROUP,h.clean_postdir_Invalid>0);
    clean_p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_city_name_Invalid=1);
    clean_p_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.clean_p_city_name_Invalid=2);
    clean_p_city_name_Total_ErrorCount := COUNT(GROUP,h.clean_p_city_name_Invalid>0);
    clean_v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_v_city_name_Invalid=1);
    clean_v_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.clean_v_city_name_Invalid=2);
    clean_v_city_name_Total_ErrorCount := COUNT(GROUP,h.clean_v_city_name_Invalid>0);
    clean_st_ALLOW_ErrorCount := COUNT(GROUP,h.clean_st_Invalid=1);
    clean_st_LENGTH_ErrorCount := COUNT(GROUP,h.clean_st_Invalid=2);
    clean_st_Total_ErrorCount := COUNT(GROUP,h.clean_st_Invalid>0);
    clean_zip_ALLOW_ErrorCount := COUNT(GROUP,h.clean_zip_Invalid=1);
    clean_zip_LENGTH_ErrorCount := COUNT(GROUP,h.clean_zip_Invalid=2);
    clean_zip_Total_ErrorCount := COUNT(GROUP,h.clean_zip_Invalid>0);
    clean_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.clean_zip4_Invalid=1);
    clean_zip4_LENGTH_ErrorCount := COUNT(GROUP,h.clean_zip4_Invalid=2);
    clean_zip4_Total_ErrorCount := COUNT(GROUP,h.clean_zip4_Invalid>0);
    process_date_ALLOW_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_LENGTH_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    date_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=2);
    date_first_seen_Total_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid>0);
    date_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=2);
    date_last_seen_Total_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid>0);
    date_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=2);
    date_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid>0);
    date_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    date_vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=2);
    date_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.idnum_Invalid,le.firstname_Invalid,le.middlename_Invalid,le.lastname_Invalid,le.suffix_Invalid,le.gender_Invalid,le.dob_Invalid,le.zipcode_Invalid,le.zipplus4_Invalid,le.phone_Invalid,le.phone2_Invalid,le.datefirstseen_Invalid,le.datelastseen_Invalid,le.filedate_Invalid,le.age_Invalid,le.clean_title_Invalid,le.clean_fname_Invalid,le.clean_mname_Invalid,le.clean_lname_Invalid,le.clean_name_suffix_Invalid,le.clean_prim_range_Invalid,le.clean_predir_Invalid,le.clean_prim_name_Invalid,le.clean_addr_suffix_Invalid,le.clean_postdir_Invalid,le.clean_p_city_name_Invalid,le.clean_v_city_name_Invalid,le.clean_st_Invalid,le.clean_zip_Invalid,le.clean_zip4_Invalid,le.process_date_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_idnum(le.idnum_Invalid),Fields.InvalidMessage_firstname(le.firstname_Invalid),Fields.InvalidMessage_middlename(le.middlename_Invalid),Fields.InvalidMessage_lastname(le.lastname_Invalid),Fields.InvalidMessage_suffix(le.suffix_Invalid),Fields.InvalidMessage_gender(le.gender_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_zipcode(le.zipcode_Invalid),Fields.InvalidMessage_zipplus4(le.zipplus4_Invalid),Fields.InvalidMessage_phone(le.phone_Invalid),Fields.InvalidMessage_phone2(le.phone2_Invalid),Fields.InvalidMessage_datefirstseen(le.datefirstseen_Invalid),Fields.InvalidMessage_datelastseen(le.datelastseen_Invalid),Fields.InvalidMessage_filedate(le.filedate_Invalid),Fields.InvalidMessage_age(le.age_Invalid),Fields.InvalidMessage_clean_title(le.clean_title_Invalid),Fields.InvalidMessage_clean_fname(le.clean_fname_Invalid),Fields.InvalidMessage_clean_mname(le.clean_mname_Invalid),Fields.InvalidMessage_clean_lname(le.clean_lname_Invalid),Fields.InvalidMessage_clean_name_suffix(le.clean_name_suffix_Invalid),Fields.InvalidMessage_clean_prim_range(le.clean_prim_range_Invalid),Fields.InvalidMessage_clean_predir(le.clean_predir_Invalid),Fields.InvalidMessage_clean_prim_name(le.clean_prim_name_Invalid),Fields.InvalidMessage_clean_addr_suffix(le.clean_addr_suffix_Invalid),Fields.InvalidMessage_clean_postdir(le.clean_postdir_Invalid),Fields.InvalidMessage_clean_p_city_name(le.clean_p_city_name_Invalid),Fields.InvalidMessage_clean_v_city_name(le.clean_v_city_name_Invalid),Fields.InvalidMessage_clean_st(le.clean_st_Invalid),Fields.InvalidMessage_clean_zip(le.clean_zip_Invalid),Fields.InvalidMessage_clean_zip4(le.clean_zip4_Invalid),Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.idnum_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.firstname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.middlename_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lastname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zipcode_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zipplus4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phone2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.datefirstseen_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.datelastseen_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.filedate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.age_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_title_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_fname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_mname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_lname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_name_suffix_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_prim_range_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_predir_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_prim_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_addr_suffix_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_postdir_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_p_city_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_v_city_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_st_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'idnum','firstname','middlename','lastname','suffix','gender','dob','zipcode','zipplus4','phone','phone2','datefirstseen','datelastseen','filedate','age','clean_title','clean_fname','clean_mname','clean_lname','clean_name_suffix','clean_prim_range','clean_predir','clean_prim_name','clean_addr_suffix','clean_postdir','clean_p_city_name','clean_v_city_name','clean_st','clean_zip','clean_zip4','process_date','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_name','invalid_name','invalid_name','invalid_name','invalid_gender','invalid_dob','invalid_zip','invalid_numeric','invalid_phone','invalid_phone','invalid_date','invalid_date','invalid_date','invalid_numeric','invalid_alnum','invalid_alnum','invalid_alnum','invalid_alnum','invalid_alnum','invalid_alnum','invalid_alnum','invalid_alnum','invalid_alnum','invalid_alnum','invalid_alnum','invalid_alnum','invalid_state','invalid_zip','invalid_numeric','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.idnum,(SALT30.StrType)le.firstname,(SALT30.StrType)le.middlename,(SALT30.StrType)le.lastname,(SALT30.StrType)le.suffix,(SALT30.StrType)le.gender,(SALT30.StrType)le.dob,(SALT30.StrType)le.zipcode,(SALT30.StrType)le.zipplus4,(SALT30.StrType)le.phone,(SALT30.StrType)le.phone2,(SALT30.StrType)le.datefirstseen,(SALT30.StrType)le.datelastseen,(SALT30.StrType)le.filedate,(SALT30.StrType)le.age,(SALT30.StrType)le.clean_title,(SALT30.StrType)le.clean_fname,(SALT30.StrType)le.clean_mname,(SALT30.StrType)le.clean_lname,(SALT30.StrType)le.clean_name_suffix,(SALT30.StrType)le.clean_prim_range,(SALT30.StrType)le.clean_predir,(SALT30.StrType)le.clean_prim_name,(SALT30.StrType)le.clean_addr_suffix,(SALT30.StrType)le.clean_postdir,(SALT30.StrType)le.clean_p_city_name,(SALT30.StrType)le.clean_v_city_name,(SALT30.StrType)le.clean_st,(SALT30.StrType)le.clean_zip,(SALT30.StrType)le.clean_zip4,(SALT30.StrType)le.process_date,(SALT30.StrType)le.date_first_seen,(SALT30.StrType)le.date_last_seen,(SALT30.StrType)le.date_vendor_first_reported,(SALT30.StrType)le.date_vendor_last_reported,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,35,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'idnum:invalid_numeric:ALLOW','idnum:invalid_numeric:LENGTH'
          ,'firstname:invalid_name:ALLOW','firstname:invalid_name:LENGTH'
          ,'middlename:invalid_name:ALLOW','middlename:invalid_name:LENGTH'
          ,'lastname:invalid_name:ALLOW','lastname:invalid_name:LENGTH'
          ,'suffix:invalid_name:ALLOW','suffix:invalid_name:LENGTH'
          ,'gender:invalid_gender:ENUM','gender:invalid_gender:LENGTH'
          ,'dob:invalid_dob:ALLOW','dob:invalid_dob:LENGTH'
          ,'zipcode:invalid_zip:ALLOW','zipcode:invalid_zip:LENGTH'
          ,'zipplus4:invalid_numeric:ALLOW','zipplus4:invalid_numeric:LENGTH'
          ,'phone:invalid_phone:ALLOW','phone:invalid_phone:LENGTH'
          ,'phone2:invalid_phone:ALLOW','phone2:invalid_phone:LENGTH'
          ,'datefirstseen:invalid_date:ALLOW','datefirstseen:invalid_date:LENGTH'
          ,'datelastseen:invalid_date:ALLOW','datelastseen:invalid_date:LENGTH'
          ,'filedate:invalid_date:ALLOW','filedate:invalid_date:LENGTH'
          ,'age:invalid_numeric:ALLOW','age:invalid_numeric:LENGTH'
          ,'clean_title:invalid_alnum:ALLOW','clean_title:invalid_alnum:LENGTH'
          ,'clean_fname:invalid_alnum:ALLOW','clean_fname:invalid_alnum:LENGTH'
          ,'clean_mname:invalid_alnum:ALLOW','clean_mname:invalid_alnum:LENGTH'
          ,'clean_lname:invalid_alnum:ALLOW','clean_lname:invalid_alnum:LENGTH'
          ,'clean_name_suffix:invalid_alnum:ALLOW','clean_name_suffix:invalid_alnum:LENGTH'
          ,'clean_prim_range:invalid_alnum:ALLOW','clean_prim_range:invalid_alnum:LENGTH'
          ,'clean_predir:invalid_alnum:ALLOW','clean_predir:invalid_alnum:LENGTH'
          ,'clean_prim_name:invalid_alnum:ALLOW','clean_prim_name:invalid_alnum:LENGTH'
          ,'clean_addr_suffix:invalid_alnum:ALLOW','clean_addr_suffix:invalid_alnum:LENGTH'
          ,'clean_postdir:invalid_alnum:ALLOW','clean_postdir:invalid_alnum:LENGTH'
          ,'clean_p_city_name:invalid_alnum:ALLOW','clean_p_city_name:invalid_alnum:LENGTH'
          ,'clean_v_city_name:invalid_alnum:ALLOW','clean_v_city_name:invalid_alnum:LENGTH'
          ,'clean_st:invalid_state:ALLOW','clean_st:invalid_state:LENGTH'
          ,'clean_zip:invalid_zip:ALLOW','clean_zip:invalid_zip:LENGTH'
          ,'clean_zip4:invalid_numeric:ALLOW','clean_zip4:invalid_numeric:LENGTH'
          ,'process_date:invalid_date:ALLOW','process_date:invalid_date:LENGTH'
          ,'date_first_seen:invalid_date:ALLOW','date_first_seen:invalid_date:LENGTH'
          ,'date_last_seen:invalid_date:ALLOW','date_last_seen:invalid_date:LENGTH'
          ,'date_vendor_first_reported:invalid_date:ALLOW','date_vendor_first_reported:invalid_date:LENGTH'
          ,'date_vendor_last_reported:invalid_date:ALLOW','date_vendor_last_reported:invalid_date:LENGTH','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.idnum_ALLOW_ErrorCount,le.idnum_LENGTH_ErrorCount
          ,le.firstname_ALLOW_ErrorCount,le.firstname_LENGTH_ErrorCount
          ,le.middlename_ALLOW_ErrorCount,le.middlename_LENGTH_ErrorCount
          ,le.lastname_ALLOW_ErrorCount,le.lastname_LENGTH_ErrorCount
          ,le.suffix_ALLOW_ErrorCount,le.suffix_LENGTH_ErrorCount
          ,le.gender_ENUM_ErrorCount,le.gender_LENGTH_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.zipcode_ALLOW_ErrorCount,le.zipcode_LENGTH_ErrorCount
          ,le.zipplus4_ALLOW_ErrorCount,le.zipplus4_LENGTH_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTH_ErrorCount
          ,le.phone2_ALLOW_ErrorCount,le.phone2_LENGTH_ErrorCount
          ,le.datefirstseen_ALLOW_ErrorCount,le.datefirstseen_LENGTH_ErrorCount
          ,le.datelastseen_ALLOW_ErrorCount,le.datelastseen_LENGTH_ErrorCount
          ,le.filedate_ALLOW_ErrorCount,le.filedate_LENGTH_ErrorCount
          ,le.age_ALLOW_ErrorCount,le.age_LENGTH_ErrorCount
          ,le.clean_title_ALLOW_ErrorCount,le.clean_title_LENGTH_ErrorCount
          ,le.clean_fname_ALLOW_ErrorCount,le.clean_fname_LENGTH_ErrorCount
          ,le.clean_mname_ALLOW_ErrorCount,le.clean_mname_LENGTH_ErrorCount
          ,le.clean_lname_ALLOW_ErrorCount,le.clean_lname_LENGTH_ErrorCount
          ,le.clean_name_suffix_ALLOW_ErrorCount,le.clean_name_suffix_LENGTH_ErrorCount
          ,le.clean_prim_range_ALLOW_ErrorCount,le.clean_prim_range_LENGTH_ErrorCount
          ,le.clean_predir_ALLOW_ErrorCount,le.clean_predir_LENGTH_ErrorCount
          ,le.clean_prim_name_ALLOW_ErrorCount,le.clean_prim_name_LENGTH_ErrorCount
          ,le.clean_addr_suffix_ALLOW_ErrorCount,le.clean_addr_suffix_LENGTH_ErrorCount
          ,le.clean_postdir_ALLOW_ErrorCount,le.clean_postdir_LENGTH_ErrorCount
          ,le.clean_p_city_name_ALLOW_ErrorCount,le.clean_p_city_name_LENGTH_ErrorCount
          ,le.clean_v_city_name_ALLOW_ErrorCount,le.clean_v_city_name_LENGTH_ErrorCount
          ,le.clean_st_ALLOW_ErrorCount,le.clean_st_LENGTH_ErrorCount
          ,le.clean_zip_ALLOW_ErrorCount,le.clean_zip_LENGTH_ErrorCount
          ,le.clean_zip4_ALLOW_ErrorCount,le.clean_zip4_LENGTH_ErrorCount
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTH_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTH_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.idnum_ALLOW_ErrorCount,le.idnum_LENGTH_ErrorCount
          ,le.firstname_ALLOW_ErrorCount,le.firstname_LENGTH_ErrorCount
          ,le.middlename_ALLOW_ErrorCount,le.middlename_LENGTH_ErrorCount
          ,le.lastname_ALLOW_ErrorCount,le.lastname_LENGTH_ErrorCount
          ,le.suffix_ALLOW_ErrorCount,le.suffix_LENGTH_ErrorCount
          ,le.gender_ENUM_ErrorCount,le.gender_LENGTH_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.zipcode_ALLOW_ErrorCount,le.zipcode_LENGTH_ErrorCount
          ,le.zipplus4_ALLOW_ErrorCount,le.zipplus4_LENGTH_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTH_ErrorCount
          ,le.phone2_ALLOW_ErrorCount,le.phone2_LENGTH_ErrorCount
          ,le.datefirstseen_ALLOW_ErrorCount,le.datefirstseen_LENGTH_ErrorCount
          ,le.datelastseen_ALLOW_ErrorCount,le.datelastseen_LENGTH_ErrorCount
          ,le.filedate_ALLOW_ErrorCount,le.filedate_LENGTH_ErrorCount
          ,le.age_ALLOW_ErrorCount,le.age_LENGTH_ErrorCount
          ,le.clean_title_ALLOW_ErrorCount,le.clean_title_LENGTH_ErrorCount
          ,le.clean_fname_ALLOW_ErrorCount,le.clean_fname_LENGTH_ErrorCount
          ,le.clean_mname_ALLOW_ErrorCount,le.clean_mname_LENGTH_ErrorCount
          ,le.clean_lname_ALLOW_ErrorCount,le.clean_lname_LENGTH_ErrorCount
          ,le.clean_name_suffix_ALLOW_ErrorCount,le.clean_name_suffix_LENGTH_ErrorCount
          ,le.clean_prim_range_ALLOW_ErrorCount,le.clean_prim_range_LENGTH_ErrorCount
          ,le.clean_predir_ALLOW_ErrorCount,le.clean_predir_LENGTH_ErrorCount
          ,le.clean_prim_name_ALLOW_ErrorCount,le.clean_prim_name_LENGTH_ErrorCount
          ,le.clean_addr_suffix_ALLOW_ErrorCount,le.clean_addr_suffix_LENGTH_ErrorCount
          ,le.clean_postdir_ALLOW_ErrorCount,le.clean_postdir_LENGTH_ErrorCount
          ,le.clean_p_city_name_ALLOW_ErrorCount,le.clean_p_city_name_LENGTH_ErrorCount
          ,le.clean_v_city_name_ALLOW_ErrorCount,le.clean_v_city_name_LENGTH_ErrorCount
          ,le.clean_st_ALLOW_ErrorCount,le.clean_st_LENGTH_ErrorCount
          ,le.clean_zip_ALLOW_ErrorCount,le.clean_zip_LENGTH_ErrorCount
          ,le.clean_zip4_ALLOW_ErrorCount,le.clean_zip4_LENGTH_ErrorCount
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTH_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTH_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,70,Into(LEFT,COUNTER));
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

IMPORT ut,SALT33;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_OKC_Student_List)
    UNSIGNED1 cleanaddr1_Invalid;
    UNSIGNED1 cleanaddr2_Invalid;
    UNSIGNED1 cleancity_Invalid;
    UNSIGNED1 cleanstate_Invalid;
    UNSIGNED1 cleandob_Invalid;
    UNSIGNED1 cleanupdatedte_Invalid;
    UNSIGNED1 cleanemail_Invalid;
    UNSIGNED1 cleancollegeID_Invalid;
    UNSIGNED1 cleanfirstname_Invalid;
    UNSIGNED1 cleanmidname_Invalid;
    UNSIGNED1 cleanlastname_Invalid;
    UNSIGNED1 cleansuffixname_Invalid;
    UNSIGNED1 cleanzip_Invalid;
    UNSIGNED1 cleanphone_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 vendor_first_reported_Invalid;
    UNSIGNED1 vendor_last_reported_Invalid;
    UNSIGNED1 dateupdated_Invalid;
    UNSIGNED1 studentid_Invalid;
    UNSIGNED1 dartid_Invalid;
    UNSIGNED1 projectsource_Invalid;
    UNSIGNED1 college_Invalid;
    UNSIGNED1 semester_Invalid;
    UNSIGNED1 year_Invalid;
    UNSIGNED1 dateofbirth_Invalid;
    UNSIGNED1 dob_formatted_Invalid;
    UNSIGNED1 addresstype_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 phonetyp_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 addr_suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_desig_Invalid;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 telephone_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_OKC_Student_List)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Layout_OKC_Student_List) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.cleanaddr1_Invalid := Fields.InValid_cleanaddr1((SALT33.StrType)le.cleanaddr1);
    SELF.cleanaddr2_Invalid := Fields.InValid_cleanaddr2((SALT33.StrType)le.cleanaddr2);
    SELF.cleancity_Invalid := Fields.InValid_cleancity((SALT33.StrType)le.cleancity);
    SELF.cleanstate_Invalid := Fields.InValid_cleanstate((SALT33.StrType)le.cleanstate);
    SELF.cleandob_Invalid := Fields.InValid_cleandob((SALT33.StrType)le.cleandob);
    SELF.cleanupdatedte_Invalid := Fields.InValid_cleanupdatedte((SALT33.StrType)le.cleanupdatedte);
    SELF.cleanemail_Invalid := Fields.InValid_cleanemail((SALT33.StrType)le.cleanemail);
    SELF.cleancollegeID_Invalid := Fields.InValid_cleancollegeID((SALT33.StrType)le.cleancollegeID);
    SELF.cleanfirstname_Invalid := Fields.InValid_cleanfirstname((SALT33.StrType)le.cleanfirstname);
    SELF.cleanmidname_Invalid := Fields.InValid_cleanmidname((SALT33.StrType)le.cleanmidname);
    SELF.cleanlastname_Invalid := Fields.InValid_cleanlastname((SALT33.StrType)le.cleanlastname);
    SELF.cleansuffixname_Invalid := Fields.InValid_cleansuffixname((SALT33.StrType)le.cleansuffixname);
    SELF.cleanzip_Invalid := Fields.InValid_cleanzip((SALT33.StrType)le.cleanzip);
    SELF.cleanphone_Invalid := Fields.InValid_cleanphone((SALT33.StrType)le.cleanphone);
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT33.StrType)le.process_date);
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT33.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT33.StrType)le.date_last_seen);
    SELF.vendor_first_reported_Invalid := Fields.InValid_vendor_first_reported((SALT33.StrType)le.date_vendor_first_reported);
    SELF.vendor_last_reported_Invalid := Fields.InValid_vendor_last_reported((SALT33.StrType)le.date_vendor_last_reported);
    SELF.dateupdated_Invalid := Fields.InValid_dateupdated((SALT33.StrType)le.dateupdated);
    SELF.studentid_Invalid := Fields.InValid_studentid((SALT33.StrType)le.studentid);
    SELF.dartid_Invalid := Fields.InValid_dartid((SALT33.StrType)le.dartid);
    SELF.projectsource_Invalid := Fields.InValid_projectsource((SALT33.StrType)le.projectsource);
    SELF.college_Invalid := Fields.InValid_college((SALT33.StrType)le.college);
    SELF.semester_Invalid := Fields.InValid_semester((SALT33.StrType)le.semester);
    SELF.year_Invalid := Fields.InValid_year((SALT33.StrType)le.year);
    SELF.dateofbirth_Invalid := Fields.InValid_dateofbirth((SALT33.StrType)le.dateofbirth);
    SELF.dob_formatted_Invalid := Fields.InValid_dob_formatted((SALT33.StrType)le.dob_formatted);
    SELF.addresstype_Invalid := Fields.InValid_addresstype((SALT33.StrType)le.addresstype);
    SELF.zip_Invalid := Fields.InValid_zip((SALT33.StrType)le.zip);
    SELF.phonetyp_Invalid := Fields.InValid_phonetyp((SALT33.StrType)le.phonetyp);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT33.StrType)le.name_suffix);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT33.StrType)le.prim_range);
    SELF.predir_Invalid := Fields.InValid_predir((SALT33.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT33.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT33.StrType)le.addr_suffix);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT33.StrType)le.postdir);
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT33.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT33.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT33.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT33.StrType)le.v_city_name);
    SELF.telephone_Invalid := Fields.InValid_telephone((SALT33.StrType)le.telephone);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_OKC_Student_List);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.cleanaddr1_Invalid << 0 ) + ( le.cleanaddr2_Invalid << 2 ) + ( le.cleancity_Invalid << 4 ) + ( le.cleanstate_Invalid << 5 ) + ( le.cleandob_Invalid << 7 ) + ( le.cleanupdatedte_Invalid << 9 ) + ( le.cleanemail_Invalid << 11 ) + ( le.cleancollegeID_Invalid << 12 ) + ( le.cleanfirstname_Invalid << 14 ) + ( le.cleanmidname_Invalid << 16 ) + ( le.cleanlastname_Invalid << 18 ) + ( le.cleansuffixname_Invalid << 20 ) + ( le.cleanzip_Invalid << 22 ) + ( le.cleanphone_Invalid << 24 ) + ( le.process_date_Invalid << 26 ) + ( le.date_first_seen_Invalid << 28 ) + ( le.date_last_seen_Invalid << 30 ) + ( le.vendor_first_reported_Invalid << 32 ) + ( le.vendor_last_reported_Invalid << 34 ) + ( le.dateupdated_Invalid << 36 ) + ( le.studentid_Invalid << 38 ) + ( le.dartid_Invalid << 40 ) + ( le.projectsource_Invalid << 41 ) + ( le.college_Invalid << 42 ) + ( le.semester_Invalid << 43 ) + ( le.year_Invalid << 45 ) + ( le.dateofbirth_Invalid << 46 ) + ( le.dob_formatted_Invalid << 48 ) + ( le.addresstype_Invalid << 50 ) + ( le.zip_Invalid << 51 ) + ( le.phonetyp_Invalid << 53 ) + ( le.name_suffix_Invalid << 54 ) + ( le.prim_range_Invalid << 55 ) + ( le.predir_Invalid << 56 ) + ( le.prim_name_Invalid << 57 ) + ( le.addr_suffix_Invalid << 58 ) + ( le.postdir_Invalid << 59 ) + ( le.unit_desig_Invalid << 60 ) + ( le.sec_range_Invalid << 61 ) + ( le.p_city_name_Invalid << 62 ) + ( le.v_city_name_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.telephone_Invalid << 0 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_OKC_Student_List);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.cleanaddr1_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.cleanaddr2_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.cleancity_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.cleanstate_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.cleandob_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.cleanupdatedte_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.cleanemail_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.cleancollegeID_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.cleanfirstname_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.cleanmidname_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.cleanlastname_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.cleansuffixname_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.cleanzip_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.cleanphone_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.vendor_first_reported_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.vendor_last_reported_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.dateupdated_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.studentid_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.dartid_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.projectsource_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.college_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.semester_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.year_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.dateofbirth_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.dob_formatted_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.addresstype_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 51) & 3;
    SELF.phonetyp_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.addr_suffix_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.telephone_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.cleancollegeid;
    TotalCnt := COUNT(GROUP); // Number of records in total
    cleanaddr1_ALLOW_ErrorCount := COUNT(GROUP,h.cleanaddr1_Invalid=1);
    cleanaddr1_LENGTH_ErrorCount := COUNT(GROUP,h.cleanaddr1_Invalid=2);
    cleanaddr1_Total_ErrorCount := COUNT(GROUP,h.cleanaddr1_Invalid>0);
    cleanaddr2_ALLOW_ErrorCount := COUNT(GROUP,h.cleanaddr2_Invalid=1);
    cleanaddr2_LENGTH_ErrorCount := COUNT(GROUP,h.cleanaddr2_Invalid=2);
    cleanaddr2_Total_ErrorCount := COUNT(GROUP,h.cleanaddr2_Invalid>0);
    cleancity_ALLOW_ErrorCount := COUNT(GROUP,h.cleancity_Invalid=1);
    cleanstate_ALLOW_ErrorCount := COUNT(GROUP,h.cleanstate_Invalid=1);
    cleanstate_LENGTH_ErrorCount := COUNT(GROUP,h.cleanstate_Invalid=2);
    cleanstate_Total_ErrorCount := COUNT(GROUP,h.cleanstate_Invalid>0);
    cleandob_ALLOW_ErrorCount := COUNT(GROUP,h.cleandob_Invalid=1);
    cleandob_LENGTH_ErrorCount := COUNT(GROUP,h.cleandob_Invalid=2);
    cleandob_Total_ErrorCount := COUNT(GROUP,h.cleandob_Invalid>0);
    cleanupdatedte_ALLOW_ErrorCount := COUNT(GROUP,h.cleanupdatedte_Invalid=1);
    cleanupdatedte_LENGTH_ErrorCount := COUNT(GROUP,h.cleanupdatedte_Invalid=2);
    cleanupdatedte_Total_ErrorCount := COUNT(GROUP,h.cleanupdatedte_Invalid>0);
    cleanemail_ALLOW_ErrorCount := COUNT(GROUP,h.cleanemail_Invalid=1);
    cleancollegeID_ALLOW_ErrorCount := COUNT(GROUP,h.cleancollegeID_Invalid=1);
    cleancollegeID_LENGTH_ErrorCount := COUNT(GROUP,h.cleancollegeID_Invalid=2);
    cleancollegeID_Total_ErrorCount := COUNT(GROUP,h.cleancollegeID_Invalid>0);
    cleanfirstname_ALLOW_ErrorCount := COUNT(GROUP,h.cleanfirstname_Invalid=1);
    cleanfirstname_LENGTH_ErrorCount := COUNT(GROUP,h.cleanfirstname_Invalid=2);
    cleanfirstname_Total_ErrorCount := COUNT(GROUP,h.cleanfirstname_Invalid>0);
    cleanmidname_ALLOW_ErrorCount := COUNT(GROUP,h.cleanmidname_Invalid=1);
    cleanmidname_LENGTH_ErrorCount := COUNT(GROUP,h.cleanmidname_Invalid=2);
    cleanmidname_Total_ErrorCount := COUNT(GROUP,h.cleanmidname_Invalid>0);
    cleanlastname_ALLOW_ErrorCount := COUNT(GROUP,h.cleanlastname_Invalid=1);
    cleanlastname_LENGTH_ErrorCount := COUNT(GROUP,h.cleanlastname_Invalid=2);
    cleanlastname_Total_ErrorCount := COUNT(GROUP,h.cleanlastname_Invalid>0);
    cleansuffixname_ALLOW_ErrorCount := COUNT(GROUP,h.cleansuffixname_Invalid=1);
    cleansuffixname_LENGTH_ErrorCount := COUNT(GROUP,h.cleansuffixname_Invalid=2);
    cleansuffixname_Total_ErrorCount := COUNT(GROUP,h.cleansuffixname_Invalid>0);
    cleanzip_ALLOW_ErrorCount := COUNT(GROUP,h.cleanzip_Invalid=1);
    cleanzip_LENGTH_ErrorCount := COUNT(GROUP,h.cleanzip_Invalid=2);
    cleanzip_Total_ErrorCount := COUNT(GROUP,h.cleanzip_Invalid>0);
    cleanphone_ALLOW_ErrorCount := COUNT(GROUP,h.cleanphone_Invalid=1);
    cleanphone_LENGTH_ErrorCount := COUNT(GROUP,h.cleanphone_Invalid=2);
    cleanphone_Total_ErrorCount := COUNT(GROUP,h.cleanphone_Invalid>0);
    process_date_ALLOW_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_LENGTH_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    date_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=2);
    date_first_seen_Total_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid>0);
    date_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=2);
    date_last_seen_Total_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid>0);
    vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_first_reported_Invalid=1);
    vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.vendor_first_reported_Invalid=2);
    vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.vendor_first_reported_Invalid>0);
    vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_last_reported_Invalid=1);
    vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.vendor_last_reported_Invalid=2);
    vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.vendor_last_reported_Invalid>0);
    dateupdated_ALLOW_ErrorCount := COUNT(GROUP,h.dateupdated_Invalid=1);
    dateupdated_LENGTH_ErrorCount := COUNT(GROUP,h.dateupdated_Invalid=2);
    dateupdated_Total_ErrorCount := COUNT(GROUP,h.dateupdated_Invalid>0);
    studentid_ALLOW_ErrorCount := COUNT(GROUP,h.studentid_Invalid=1);
    studentid_LENGTH_ErrorCount := COUNT(GROUP,h.studentid_Invalid=2);
    studentid_Total_ErrorCount := COUNT(GROUP,h.studentid_Invalid>0);
    dartid_ALLOW_ErrorCount := COUNT(GROUP,h.dartid_Invalid=1);
    projectsource_LENGTH_ErrorCount := COUNT(GROUP,h.projectsource_Invalid=1);
    college_ALLOW_ErrorCount := COUNT(GROUP,h.college_Invalid=1);
    semester_ENUM_ErrorCount := COUNT(GROUP,h.semester_Invalid=1);
    semester_LENGTH_ErrorCount := COUNT(GROUP,h.semester_Invalid=2);
    semester_Total_ErrorCount := COUNT(GROUP,h.semester_Invalid>0);
    year_ALLOW_ErrorCount := COUNT(GROUP,h.year_Invalid=1);
    dateofbirth_ALLOW_ErrorCount := COUNT(GROUP,h.dateofbirth_Invalid=1);
    dateofbirth_LENGTH_ErrorCount := COUNT(GROUP,h.dateofbirth_Invalid=2);
    dateofbirth_Total_ErrorCount := COUNT(GROUP,h.dateofbirth_Invalid>0);
    dob_formatted_ALLOW_ErrorCount := COUNT(GROUP,h.dob_formatted_Invalid=1);
    dob_formatted_LENGTH_ErrorCount := COUNT(GROUP,h.dob_formatted_Invalid=2);
    dob_formatted_Total_ErrorCount := COUNT(GROUP,h.dob_formatted_Invalid>0);
    addresstype_ENUM_ErrorCount := COUNT(GROUP,h.addresstype_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTH_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    phonetyp_ENUM_ErrorCount := COUNT(GROUP,h.phonetyp_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    telephone_ALLOW_ErrorCount := COUNT(GROUP,h.telephone_Invalid=1);
    telephone_LENGTH_ErrorCount := COUNT(GROUP,h.telephone_Invalid=2);
    telephone_Total_ErrorCount := COUNT(GROUP,h.telephone_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r,cleancollegeid,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.cleancollegeid;
    UNSIGNED1 ErrNum := CHOOSE(c,le.cleanaddr1_Invalid,le.cleanaddr2_Invalid,le.cleancity_Invalid,le.cleanstate_Invalid,le.cleandob_Invalid,le.cleanupdatedte_Invalid,le.cleanemail_Invalid,le.cleancollegeID_Invalid,le.cleanfirstname_Invalid,le.cleanmidname_Invalid,le.cleanlastname_Invalid,le.cleansuffixname_Invalid,le.cleanzip_Invalid,le.cleanphone_Invalid,le.process_date_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.vendor_first_reported_Invalid,le.vendor_last_reported_Invalid,le.dateupdated_Invalid,le.studentid_Invalid,le.dartid_Invalid,le.projectsource_Invalid,le.college_Invalid,le.semester_Invalid,le.year_Invalid,le.dateofbirth_Invalid,le.dob_formatted_Invalid,le.addresstype_Invalid,le.zip_Invalid,le.phonetyp_Invalid,le.name_suffix_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.telephone_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_cleanaddr1(le.cleanaddr1_Invalid),Fields.InvalidMessage_cleanaddr2(le.cleanaddr2_Invalid),Fields.InvalidMessage_cleancity(le.cleancity_Invalid),Fields.InvalidMessage_cleanstate(le.cleanstate_Invalid),Fields.InvalidMessage_cleandob(le.cleandob_Invalid),Fields.InvalidMessage_cleanupdatedte(le.cleanupdatedte_Invalid),Fields.InvalidMessage_cleanemail(le.cleanemail_Invalid),Fields.InvalidMessage_cleancollegeID(le.cleancollegeID_Invalid),Fields.InvalidMessage_cleanfirstname(le.cleanfirstname_Invalid),Fields.InvalidMessage_cleanmidname(le.cleanmidname_Invalid),Fields.InvalidMessage_cleanlastname(le.cleanlastname_Invalid),Fields.InvalidMessage_cleansuffixname(le.cleansuffixname_Invalid),Fields.InvalidMessage_cleanzip(le.cleanzip_Invalid),Fields.InvalidMessage_cleanphone(le.cleanphone_Invalid),Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Fields.InvalidMessage_vendor_first_reported(le.vendor_first_reported_Invalid),Fields.InvalidMessage_vendor_last_reported(le.vendor_last_reported_Invalid),Fields.InvalidMessage_dateupdated(le.dateupdated_Invalid),Fields.InvalidMessage_studentid(le.studentid_Invalid),Fields.InvalidMessage_dartid(le.dartid_Invalid),Fields.InvalidMessage_projectsource(le.projectsource_Invalid),Fields.InvalidMessage_college(le.college_Invalid),Fields.InvalidMessage_semester(le.semester_Invalid),Fields.InvalidMessage_year(le.year_Invalid),Fields.InvalidMessage_dateofbirth(le.dateofbirth_Invalid),Fields.InvalidMessage_dob_formatted(le.dob_formatted_Invalid),Fields.InvalidMessage_addresstype(le.addresstype_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_phonetyp(le.phonetyp_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_telephone(le.telephone_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.cleanaddr1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cleanaddr2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cleancity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cleanstate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cleandob_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cleanupdatedte_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cleanemail_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cleancollegeID_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cleanfirstname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cleanmidname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cleanlastname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cleansuffixname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cleanzip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cleanphone_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.vendor_first_reported_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.vendor_last_reported_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dateupdated_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.studentid_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dartid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.projectsource_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.college_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.semester_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.year_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dateofbirth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dob_formatted_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.addresstype_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phonetyp_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.telephone_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'cleanaddr1','cleanaddr2','cleancity','cleanstate','cleandob','cleanupdatedte','cleanemail','cleancollegeID','cleanfirstname','cleanmidname','cleanlastname','cleansuffixname','cleanzip','cleanphone','process_date','date_first_seen','date_last_seen','vendor_first_reported','vendor_last_reported','dateupdated','studentid','dartid','projectsource','college','semester','year','dateofbirth','dob_formatted','addresstype','zip','phonetyp','name_suffix','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','telephone','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_cleanaddress','invalid_cleanaddress','invalid_city','invalid_state','invalid_date','invalid_date','invalid_email','invalid_collegeid','invalid_firstname','invalid_name','invalid_lastname','invalid_name','invalid_zip','invalid_phone','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_studentID','nums','invalid_projectsource','invalid_college','invalid_semester','nums','invalid_date','invalid_date','invalid_addresstype','invalid_zip','invalid_phonetyp','invalid_suffix','invalid_address','invalid_address','invalid_mandatory','invalid_address','invalid_address','invalid_address','invalid_address','invalid_city','invalid_city','invalid_phone','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.cleanaddr1,(SALT33.StrType)le.cleanaddr2,(SALT33.StrType)le.cleancity,(SALT33.StrType)le.cleanstate,(SALT33.StrType)le.cleandob,(SALT33.StrType)le.cleanupdatedte,(SALT33.StrType)le.cleanemail,(SALT33.StrType)le.cleancollegeID,(SALT33.StrType)le.cleanfirstname,(SALT33.StrType)le.cleanmidname,(SALT33.StrType)le.cleanlastname,(SALT33.StrType)le.cleansuffixname,(SALT33.StrType)le.cleanzip,(SALT33.StrType)le.cleanphone,(SALT33.StrType)le.process_date,(SALT33.StrType)le.date_first_seen,(SALT33.StrType)le.date_last_seen,(SALT33.StrType)le.date_vendor_first_reported,(SALT33.StrType)le.date_vendor_last_reported,(SALT33.StrType)le.dateupdated,(SALT33.StrType)le.studentid,(SALT33.StrType)le.dartid,(SALT33.StrType)le.projectsource,(SALT33.StrType)le.college,(SALT33.StrType)le.semester,(SALT33.StrType)le.year,(SALT33.StrType)le.dateofbirth,(SALT33.StrType)le.dob_formatted,(SALT33.StrType)le.addresstype,(SALT33.StrType)le.zip,(SALT33.StrType)le.phonetyp,(SALT33.StrType)le.name_suffix,(SALT33.StrType)le.prim_range,(SALT33.StrType)le.predir,(SALT33.StrType)le.prim_name,(SALT33.StrType)le.addr_suffix,(SALT33.StrType)le.postdir,(SALT33.StrType)le.unit_desig,(SALT33.StrType)le.sec_range,(SALT33.StrType)le.p_city_name,(SALT33.StrType)le.v_city_name,(SALT33.StrType)le.telephone,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,42,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.cleancollegeid;
      SELF.ruledesc := CHOOSE(c
          ,'cleanaddr1:invalid_cleanaddress:ALLOW','cleanaddr1:invalid_cleanaddress:LENGTH'
          ,'cleanaddr2:invalid_cleanaddress:ALLOW','cleanaddr2:invalid_cleanaddress:LENGTH'
          ,'cleancity:invalid_city:ALLOW'
          ,'cleanstate:invalid_state:ALLOW','cleanstate:invalid_state:LENGTH'
          ,'cleandob:invalid_date:ALLOW','cleandob:invalid_date:LENGTH'
          ,'cleanupdatedte:invalid_date:ALLOW','cleanupdatedte:invalid_date:LENGTH'
          ,'cleanemail:invalid_email:ALLOW'
          ,'cleancollegeID:invalid_collegeid:ALLOW','cleancollegeID:invalid_collegeid:LENGTH'
          ,'cleanfirstname:invalid_firstname:ALLOW','cleanfirstname:invalid_firstname:LENGTH'
          ,'cleanmidname:invalid_name:ALLOW','cleanmidname:invalid_name:LENGTH'
          ,'cleanlastname:invalid_lastname:ALLOW','cleanlastname:invalid_lastname:LENGTH'
          ,'cleansuffixname:invalid_name:ALLOW','cleansuffixname:invalid_name:LENGTH'
          ,'cleanzip:invalid_zip:ALLOW','cleanzip:invalid_zip:LENGTH'
          ,'cleanphone:invalid_phone:ALLOW','cleanphone:invalid_phone:LENGTH'
          ,'process_date:invalid_date:ALLOW','process_date:invalid_date:LENGTH'
          ,'date_first_seen:invalid_date:ALLOW','date_first_seen:invalid_date:LENGTH'
          ,'date_last_seen:invalid_date:ALLOW','date_last_seen:invalid_date:LENGTH'
          ,'vendor_first_reported:invalid_date:ALLOW','vendor_first_reported:invalid_date:LENGTH'
          ,'vendor_last_reported:invalid_date:ALLOW','vendor_last_reported:invalid_date:LENGTH'
          ,'dateupdated:invalid_date:ALLOW','dateupdated:invalid_date:LENGTH'
          ,'studentid:invalid_studentID:ALLOW','studentid:invalid_studentID:LENGTH'
          ,'dartid:nums:ALLOW'
          ,'projectsource:invalid_projectsource:LENGTH'
          ,'college:invalid_college:ALLOW'
          ,'semester:invalid_semester:ENUM','semester:invalid_semester:LENGTH'
          ,'year:nums:ALLOW'
          ,'dateofbirth:invalid_date:ALLOW','dateofbirth:invalid_date:LENGTH'
          ,'dob_formatted:invalid_date:ALLOW','dob_formatted:invalid_date:LENGTH'
          ,'addresstype:invalid_addresstype:ENUM'
          ,'zip:invalid_zip:ALLOW','zip:invalid_zip:LENGTH'
          ,'phonetyp:invalid_phonetyp:ENUM'
          ,'name_suffix:invalid_suffix:ALLOW'
          ,'prim_range:invalid_address:ALLOW'
          ,'predir:invalid_address:ALLOW'
          ,'prim_name:invalid_mandatory:LENGTH'
          ,'addr_suffix:invalid_address:ALLOW'
          ,'postdir:invalid_address:ALLOW'
          ,'unit_desig:invalid_address:ALLOW'
          ,'sec_range:invalid_address:ALLOW'
          ,'p_city_name:invalid_city:ALLOW'
          ,'v_city_name:invalid_city:ALLOW'
          ,'telephone:invalid_phone:ALLOW','telephone:invalid_phone:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_cleanaddr1(1),Fields.InvalidMessage_cleanaddr1(2)
          ,Fields.InvalidMessage_cleanaddr2(1),Fields.InvalidMessage_cleanaddr2(2)
          ,Fields.InvalidMessage_cleancity(1)
          ,Fields.InvalidMessage_cleanstate(1),Fields.InvalidMessage_cleanstate(2)
          ,Fields.InvalidMessage_cleandob(1),Fields.InvalidMessage_cleandob(2)
          ,Fields.InvalidMessage_cleanupdatedte(1),Fields.InvalidMessage_cleanupdatedte(2)
          ,Fields.InvalidMessage_cleanemail(1)
          ,Fields.InvalidMessage_cleancollegeID(1),Fields.InvalidMessage_cleancollegeID(2)
          ,Fields.InvalidMessage_cleanfirstname(1),Fields.InvalidMessage_cleanfirstname(2)
          ,Fields.InvalidMessage_cleanmidname(1),Fields.InvalidMessage_cleanmidname(2)
          ,Fields.InvalidMessage_cleanlastname(1),Fields.InvalidMessage_cleanlastname(2)
          ,Fields.InvalidMessage_cleansuffixname(1),Fields.InvalidMessage_cleansuffixname(2)
          ,Fields.InvalidMessage_cleanzip(1),Fields.InvalidMessage_cleanzip(2)
          ,Fields.InvalidMessage_cleanphone(1),Fields.InvalidMessage_cleanphone(2)
          ,Fields.InvalidMessage_process_date(1),Fields.InvalidMessage_process_date(2)
          ,Fields.InvalidMessage_date_first_seen(1),Fields.InvalidMessage_date_first_seen(2)
          ,Fields.InvalidMessage_date_last_seen(1),Fields.InvalidMessage_date_last_seen(2)
          ,Fields.InvalidMessage_vendor_first_reported(1),Fields.InvalidMessage_vendor_first_reported(2)
          ,Fields.InvalidMessage_vendor_last_reported(1),Fields.InvalidMessage_vendor_last_reported(2)
          ,Fields.InvalidMessage_dateupdated(1),Fields.InvalidMessage_dateupdated(2)
          ,Fields.InvalidMessage_studentid(1),Fields.InvalidMessage_studentid(2)
          ,Fields.InvalidMessage_dartid(1)
          ,Fields.InvalidMessage_projectsource(1)
          ,Fields.InvalidMessage_college(1)
          ,Fields.InvalidMessage_semester(1),Fields.InvalidMessage_semester(2)
          ,Fields.InvalidMessage_year(1)
          ,Fields.InvalidMessage_dateofbirth(1),Fields.InvalidMessage_dateofbirth(2)
          ,Fields.InvalidMessage_dob_formatted(1),Fields.InvalidMessage_dob_formatted(2)
          ,Fields.InvalidMessage_addresstype(1)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2)
          ,Fields.InvalidMessage_phonetyp(1)
          ,Fields.InvalidMessage_name_suffix(1)
          ,Fields.InvalidMessage_prim_range(1)
          ,Fields.InvalidMessage_predir(1)
          ,Fields.InvalidMessage_prim_name(1)
          ,Fields.InvalidMessage_addr_suffix(1)
          ,Fields.InvalidMessage_postdir(1)
          ,Fields.InvalidMessage_unit_desig(1)
          ,Fields.InvalidMessage_sec_range(1)
          ,Fields.InvalidMessage_p_city_name(1)
          ,Fields.InvalidMessage_v_city_name(1)
          ,Fields.InvalidMessage_telephone(1),Fields.InvalidMessage_telephone(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.cleanaddr1_ALLOW_ErrorCount,le.cleanaddr1_LENGTH_ErrorCount
          ,le.cleanaddr2_ALLOW_ErrorCount,le.cleanaddr2_LENGTH_ErrorCount
          ,le.cleancity_ALLOW_ErrorCount
          ,le.cleanstate_ALLOW_ErrorCount,le.cleanstate_LENGTH_ErrorCount
          ,le.cleandob_ALLOW_ErrorCount,le.cleandob_LENGTH_ErrorCount
          ,le.cleanupdatedte_ALLOW_ErrorCount,le.cleanupdatedte_LENGTH_ErrorCount
          ,le.cleanemail_ALLOW_ErrorCount
          ,le.cleancollegeID_ALLOW_ErrorCount,le.cleancollegeID_LENGTH_ErrorCount
          ,le.cleanfirstname_ALLOW_ErrorCount,le.cleanfirstname_LENGTH_ErrorCount
          ,le.cleanmidname_ALLOW_ErrorCount,le.cleanmidname_LENGTH_ErrorCount
          ,le.cleanlastname_ALLOW_ErrorCount,le.cleanlastname_LENGTH_ErrorCount
          ,le.cleansuffixname_ALLOW_ErrorCount,le.cleansuffixname_LENGTH_ErrorCount
          ,le.cleanzip_ALLOW_ErrorCount,le.cleanzip_LENGTH_ErrorCount
          ,le.cleanphone_ALLOW_ErrorCount,le.cleanphone_LENGTH_ErrorCount
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTH_ErrorCount
          ,le.vendor_first_reported_ALLOW_ErrorCount,le.vendor_first_reported_LENGTH_ErrorCount
          ,le.vendor_last_reported_ALLOW_ErrorCount,le.vendor_last_reported_LENGTH_ErrorCount
          ,le.dateupdated_ALLOW_ErrorCount,le.dateupdated_LENGTH_ErrorCount
          ,le.studentid_ALLOW_ErrorCount,le.studentid_LENGTH_ErrorCount
          ,le.dartid_ALLOW_ErrorCount
          ,le.projectsource_LENGTH_ErrorCount
          ,le.college_ALLOW_ErrorCount
          ,le.semester_ENUM_ErrorCount,le.semester_LENGTH_ErrorCount
          ,le.year_ALLOW_ErrorCount
          ,le.dateofbirth_ALLOW_ErrorCount,le.dateofbirth_LENGTH_ErrorCount
          ,le.dob_formatted_ALLOW_ErrorCount,le.dob_formatted_LENGTH_ErrorCount
          ,le.addresstype_ENUM_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.phonetyp_ENUM_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_LENGTH_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.telephone_ALLOW_ErrorCount,le.telephone_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.cleanaddr1_ALLOW_ErrorCount,le.cleanaddr1_LENGTH_ErrorCount
          ,le.cleanaddr2_ALLOW_ErrorCount,le.cleanaddr2_LENGTH_ErrorCount
          ,le.cleancity_ALLOW_ErrorCount
          ,le.cleanstate_ALLOW_ErrorCount,le.cleanstate_LENGTH_ErrorCount
          ,le.cleandob_ALLOW_ErrorCount,le.cleandob_LENGTH_ErrorCount
          ,le.cleanupdatedte_ALLOW_ErrorCount,le.cleanupdatedte_LENGTH_ErrorCount
          ,le.cleanemail_ALLOW_ErrorCount
          ,le.cleancollegeID_ALLOW_ErrorCount,le.cleancollegeID_LENGTH_ErrorCount
          ,le.cleanfirstname_ALLOW_ErrorCount,le.cleanfirstname_LENGTH_ErrorCount
          ,le.cleanmidname_ALLOW_ErrorCount,le.cleanmidname_LENGTH_ErrorCount
          ,le.cleanlastname_ALLOW_ErrorCount,le.cleanlastname_LENGTH_ErrorCount
          ,le.cleansuffixname_ALLOW_ErrorCount,le.cleansuffixname_LENGTH_ErrorCount
          ,le.cleanzip_ALLOW_ErrorCount,le.cleanzip_LENGTH_ErrorCount
          ,le.cleanphone_ALLOW_ErrorCount,le.cleanphone_LENGTH_ErrorCount
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTH_ErrorCount
          ,le.vendor_first_reported_ALLOW_ErrorCount,le.vendor_first_reported_LENGTH_ErrorCount
          ,le.vendor_last_reported_ALLOW_ErrorCount,le.vendor_last_reported_LENGTH_ErrorCount
          ,le.dateupdated_ALLOW_ErrorCount,le.dateupdated_LENGTH_ErrorCount
          ,le.studentid_ALLOW_ErrorCount,le.studentid_LENGTH_ErrorCount
          ,le.dartid_ALLOW_ErrorCount
          ,le.projectsource_LENGTH_ErrorCount
          ,le.college_ALLOW_ErrorCount
          ,le.semester_ENUM_ErrorCount,le.semester_LENGTH_ErrorCount
          ,le.year_ALLOW_ErrorCount
          ,le.dateofbirth_ALLOW_ErrorCount,le.dateofbirth_LENGTH_ErrorCount
          ,le.dob_formatted_ALLOW_ErrorCount,le.dob_formatted_LENGTH_ErrorCount
          ,le.addresstype_ENUM_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.phonetyp_ENUM_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_LENGTH_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.telephone_ALLOW_ErrorCount,le.telephone_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,66,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT33.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT33.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;

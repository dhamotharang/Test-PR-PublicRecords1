IMPORT SALT311,STD;
IMPORT Scrubs_OKC_Student_List_V2; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 60;
  EXPORT NumRulesFromFieldType := 60;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 41;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_OKC_Student_List)
    UNSIGNED1 cleanaddr1_Invalid;
    UNSIGNED1 cleanaddr2_Invalid;
    UNSIGNED1 cleancity_Invalid;
    UNSIGNED1 cleanstate_Invalid;
    UNSIGNED1 cleandob_Invalid;
    UNSIGNED1 cleanupdatedte_Invalid;
    UNSIGNED1 cleanemail_Invalid;
    UNSIGNED1 cleanfirstname_Invalid;
    UNSIGNED1 cleanmidname_Invalid;
    UNSIGNED1 cleanlastname_Invalid;
    UNSIGNED1 cleansuffixname_Invalid;
    UNSIGNED1 cleanphone_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
    UNSIGNED1 dateadded_Invalid;
    UNSIGNED1 dateupdated_Invalid;
    UNSIGNED1 studentid_Invalid;
    UNSIGNED1 dartid_Invalid;
    UNSIGNED1 college_Invalid;
    UNSIGNED1 semester_Invalid;
    UNSIGNED1 year_Invalid;
    UNSIGNED1 dateofbirth_Invalid;
    UNSIGNED1 dob_formatted_Invalid;
    UNSIGNED1 addresstype_Invalid;
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
    UNSIGNED1 college_major_Invalid;
    UNSIGNED1 new_college_major_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_OKC_Student_List)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_OKC_Student_List) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.cleanaddr1_Invalid := Fields.InValid_cleanaddr1((SALT311.StrType)le.cleanaddr1);
    SELF.cleanaddr2_Invalid := Fields.InValid_cleanaddr2((SALT311.StrType)le.cleanaddr2);
    SELF.cleancity_Invalid := Fields.InValid_cleancity((SALT311.StrType)le.cleancity);
    SELF.cleanstate_Invalid := Fields.InValid_cleanstate((SALT311.StrType)le.cleanstate);
    SELF.cleandob_Invalid := Fields.InValid_cleandob((SALT311.StrType)le.cleandob);
    SELF.cleanupdatedte_Invalid := Fields.InValid_cleanupdatedte((SALT311.StrType)le.cleanupdatedte);
    SELF.cleanemail_Invalid := Fields.InValid_cleanemail((SALT311.StrType)le.cleanemail);
    SELF.cleanfirstname_Invalid := Fields.InValid_cleanfirstname((SALT311.StrType)le.cleanfirstname);
    SELF.cleanmidname_Invalid := Fields.InValid_cleanmidname((SALT311.StrType)le.cleanmidname);
    SELF.cleanlastname_Invalid := Fields.InValid_cleanlastname((SALT311.StrType)le.cleanlastname);
    SELF.cleansuffixname_Invalid := Fields.InValid_cleansuffixname((SALT311.StrType)le.cleansuffixname);
    SELF.cleanphone_Invalid := Fields.InValid_cleanphone((SALT311.StrType)le.cleanphone);
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT311.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT311.StrType)le.date_vendor_last_reported);
    SELF.dateadded_Invalid := Fields.InValid_dateadded((SALT311.StrType)le.dateadded);
    SELF.dateupdated_Invalid := Fields.InValid_dateupdated((SALT311.StrType)le.dateupdated);
    SELF.studentid_Invalid := Fields.InValid_studentid((SALT311.StrType)le.studentid);
    SELF.dartid_Invalid := Fields.InValid_dartid((SALT311.StrType)le.dartid);
    SELF.college_Invalid := Fields.InValid_college((SALT311.StrType)le.college);
    SELF.semester_Invalid := Fields.InValid_semester((SALT311.StrType)le.semester);
    SELF.year_Invalid := Fields.InValid_year((SALT311.StrType)le.year);
    SELF.dateofbirth_Invalid := Fields.InValid_dateofbirth((SALT311.StrType)le.dateofbirth);
    SELF.dob_formatted_Invalid := Fields.InValid_dob_formatted((SALT311.StrType)le.dob_formatted);
    SELF.addresstype_Invalid := Fields.InValid_addresstype((SALT311.StrType)le.addresstype);
    SELF.phonetyp_Invalid := Fields.InValid_phonetyp((SALT311.StrType)le.phonetyp);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT311.StrType)le.prim_range);
    SELF.predir_Invalid := Fields.InValid_predir((SALT311.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT311.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT311.StrType)le.postdir);
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT311.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name);
    SELF.telephone_Invalid := Fields.InValid_telephone((SALT311.StrType)le.telephone);
    SELF.college_major_Invalid := Fields.InValid_college_major((SALT311.StrType)le.college_major);
    SELF.new_college_major_Invalid := Fields.InValid_new_college_major((SALT311.StrType)le.new_college_major);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_OKC_Student_List);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.cleanaddr1_Invalid << 0 ) + ( le.cleanaddr2_Invalid << 1 ) + ( le.cleancity_Invalid << 2 ) + ( le.cleanstate_Invalid << 3 ) + ( le.cleandob_Invalid << 5 ) + ( le.cleanupdatedte_Invalid << 7 ) + ( le.cleanemail_Invalid << 9 ) + ( le.cleanfirstname_Invalid << 10 ) + ( le.cleanmidname_Invalid << 12 ) + ( le.cleanlastname_Invalid << 14 ) + ( le.cleansuffixname_Invalid << 16 ) + ( le.cleanphone_Invalid << 18 ) + ( le.process_date_Invalid << 20 ) + ( le.date_first_seen_Invalid << 22 ) + ( le.date_last_seen_Invalid << 24 ) + ( le.date_vendor_first_reported_Invalid << 26 ) + ( le.date_vendor_last_reported_Invalid << 28 ) + ( le.dateadded_Invalid << 30 ) + ( le.dateupdated_Invalid << 32 ) + ( le.studentid_Invalid << 34 ) + ( le.dartid_Invalid << 35 ) + ( le.college_Invalid << 36 ) + ( le.semester_Invalid << 37 ) + ( le.year_Invalid << 39 ) + ( le.dateofbirth_Invalid << 40 ) + ( le.dob_formatted_Invalid << 42 ) + ( le.addresstype_Invalid << 44 ) + ( le.phonetyp_Invalid << 45 ) + ( le.name_suffix_Invalid << 46 ) + ( le.prim_range_Invalid << 47 ) + ( le.predir_Invalid << 48 ) + ( le.prim_name_Invalid << 49 ) + ( le.addr_suffix_Invalid << 50 ) + ( le.postdir_Invalid << 51 ) + ( le.unit_desig_Invalid << 52 ) + ( le.sec_range_Invalid << 53 ) + ( le.p_city_name_Invalid << 54 ) + ( le.v_city_name_Invalid << 55 ) + ( le.telephone_Invalid << 56 ) + ( le.college_major_Invalid << 58 ) + ( le.new_college_major_Invalid << 59 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_OKC_Student_List);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.cleanaddr1_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.cleanaddr2_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.cleancity_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.cleanstate_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.cleandob_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.cleanupdatedte_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.cleanemail_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.cleanfirstname_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.cleanmidname_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.cleanlastname_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.cleansuffixname_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.cleanphone_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.dateadded_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.dateupdated_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.studentid_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.dartid_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.college_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.semester_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.year_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.dateofbirth_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.dob_formatted_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.addresstype_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.phonetyp_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.addr_suffix_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.telephone_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.college_major_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.new_college_major_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.cleancollegeid) cleancollegeid := IF(Glob, '', h.cleancollegeid);
    TotalCnt := COUNT(GROUP); // Number of records in total
    cleanaddr1_ALLOW_ErrorCount := COUNT(GROUP,h.cleanaddr1_Invalid=1);
    cleanaddr2_ALLOW_ErrorCount := COUNT(GROUP,h.cleanaddr2_Invalid=1);
    cleancity_ALLOW_ErrorCount := COUNT(GROUP,h.cleancity_Invalid=1);
    cleanstate_ALLOW_ErrorCount := COUNT(GROUP,h.cleanstate_Invalid=1);
    cleanstate_LENGTHS_ErrorCount := COUNT(GROUP,h.cleanstate_Invalid=2);
    cleanstate_Total_ErrorCount := COUNT(GROUP,h.cleanstate_Invalid>0);
    cleandob_ALLOW_ErrorCount := COUNT(GROUP,h.cleandob_Invalid=1);
    cleandob_LENGTHS_ErrorCount := COUNT(GROUP,h.cleandob_Invalid=2);
    cleandob_Total_ErrorCount := COUNT(GROUP,h.cleandob_Invalid>0);
    cleanupdatedte_ALLOW_ErrorCount := COUNT(GROUP,h.cleanupdatedte_Invalid=1);
    cleanupdatedte_LENGTHS_ErrorCount := COUNT(GROUP,h.cleanupdatedte_Invalid=2);
    cleanupdatedte_Total_ErrorCount := COUNT(GROUP,h.cleanupdatedte_Invalid>0);
    cleanemail_ALLOW_ErrorCount := COUNT(GROUP,h.cleanemail_Invalid=1);
    cleanfirstname_ALLOW_ErrorCount := COUNT(GROUP,h.cleanfirstname_Invalid=1);
    cleanfirstname_LENGTHS_ErrorCount := COUNT(GROUP,h.cleanfirstname_Invalid=2);
    cleanfirstname_Total_ErrorCount := COUNT(GROUP,h.cleanfirstname_Invalid>0);
    cleanmidname_ALLOW_ErrorCount := COUNT(GROUP,h.cleanmidname_Invalid=1);
    cleanmidname_LENGTHS_ErrorCount := COUNT(GROUP,h.cleanmidname_Invalid=2);
    cleanmidname_Total_ErrorCount := COUNT(GROUP,h.cleanmidname_Invalid>0);
    cleanlastname_ALLOW_ErrorCount := COUNT(GROUP,h.cleanlastname_Invalid=1);
    cleanlastname_LENGTHS_ErrorCount := COUNT(GROUP,h.cleanlastname_Invalid=2);
    cleanlastname_Total_ErrorCount := COUNT(GROUP,h.cleanlastname_Invalid>0);
    cleansuffixname_ALLOW_ErrorCount := COUNT(GROUP,h.cleansuffixname_Invalid=1);
    cleansuffixname_LENGTHS_ErrorCount := COUNT(GROUP,h.cleansuffixname_Invalid=2);
    cleansuffixname_Total_ErrorCount := COUNT(GROUP,h.cleansuffixname_Invalid>0);
    cleanphone_ALLOW_ErrorCount := COUNT(GROUP,h.cleanphone_Invalid=1);
    cleanphone_LENGTHS_ErrorCount := COUNT(GROUP,h.cleanphone_Invalid=2);
    cleanphone_Total_ErrorCount := COUNT(GROUP,h.cleanphone_Invalid>0);
    process_date_ALLOW_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_LENGTHS_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    date_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_first_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=2);
    date_first_seen_Total_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid>0);
    date_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_last_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=2);
    date_last_seen_Total_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid>0);
    date_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_first_reported_LENGTHS_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=2);
    date_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid>0);
    date_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    date_vendor_last_reported_LENGTHS_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=2);
    date_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid>0);
    dateadded_ALLOW_ErrorCount := COUNT(GROUP,h.dateadded_Invalid=1);
    dateadded_LENGTHS_ErrorCount := COUNT(GROUP,h.dateadded_Invalid=2);
    dateadded_Total_ErrorCount := COUNT(GROUP,h.dateadded_Invalid>0);
    dateupdated_ALLOW_ErrorCount := COUNT(GROUP,h.dateupdated_Invalid=1);
    dateupdated_LENGTHS_ErrorCount := COUNT(GROUP,h.dateupdated_Invalid=2);
    dateupdated_Total_ErrorCount := COUNT(GROUP,h.dateupdated_Invalid>0);
    studentid_ALLOW_ErrorCount := COUNT(GROUP,h.studentid_Invalid=1);
    dartid_ALLOW_ErrorCount := COUNT(GROUP,h.dartid_Invalid=1);
    college_ALLOW_ErrorCount := COUNT(GROUP,h.college_Invalid=1);
    semester_ENUM_ErrorCount := COUNT(GROUP,h.semester_Invalid=1);
    semester_LENGTHS_ErrorCount := COUNT(GROUP,h.semester_Invalid=2);
    semester_Total_ErrorCount := COUNT(GROUP,h.semester_Invalid>0);
    year_ALLOW_ErrorCount := COUNT(GROUP,h.year_Invalid=1);
    dateofbirth_ALLOW_ErrorCount := COUNT(GROUP,h.dateofbirth_Invalid=1);
    dateofbirth_LENGTHS_ErrorCount := COUNT(GROUP,h.dateofbirth_Invalid=2);
    dateofbirth_Total_ErrorCount := COUNT(GROUP,h.dateofbirth_Invalid>0);
    dob_formatted_ALLOW_ErrorCount := COUNT(GROUP,h.dob_formatted_Invalid=1);
    dob_formatted_LENGTHS_ErrorCount := COUNT(GROUP,h.dob_formatted_Invalid=2);
    dob_formatted_Total_ErrorCount := COUNT(GROUP,h.dob_formatted_Invalid>0);
    addresstype_ENUM_ErrorCount := COUNT(GROUP,h.addresstype_Invalid=1);
    phonetyp_ENUM_ErrorCount := COUNT(GROUP,h.phonetyp_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    telephone_ALLOW_ErrorCount := COUNT(GROUP,h.telephone_Invalid=1);
    telephone_LENGTHS_ErrorCount := COUNT(GROUP,h.telephone_Invalid=2);
    telephone_Total_ErrorCount := COUNT(GROUP,h.telephone_Invalid>0);
    college_major_ALLOW_ErrorCount := COUNT(GROUP,h.college_major_Invalid=1);
    new_college_major_CUSTOM_ErrorCount := COUNT(GROUP,h.new_college_major_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.cleanaddr1_Invalid > 0 OR h.cleanaddr2_Invalid > 0 OR h.cleancity_Invalid > 0 OR h.cleanstate_Invalid > 0 OR h.cleandob_Invalid > 0 OR h.cleanupdatedte_Invalid > 0 OR h.cleanemail_Invalid > 0 OR h.cleanfirstname_Invalid > 0 OR h.cleanmidname_Invalid > 0 OR h.cleanlastname_Invalid > 0 OR h.cleansuffixname_Invalid > 0 OR h.cleanphone_Invalid > 0 OR h.process_date_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.date_vendor_first_reported_Invalid > 0 OR h.date_vendor_last_reported_Invalid > 0 OR h.dateadded_Invalid > 0 OR h.dateupdated_Invalid > 0 OR h.studentid_Invalid > 0 OR h.dartid_Invalid > 0 OR h.college_Invalid > 0 OR h.semester_Invalid > 0 OR h.year_Invalid > 0 OR h.dateofbirth_Invalid > 0 OR h.dob_formatted_Invalid > 0 OR h.addresstype_Invalid > 0 OR h.phonetyp_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.addr_suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.telephone_Invalid > 0 OR h.college_major_Invalid > 0 OR h.new_college_major_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,cleancollegeid,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.cleanaddr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cleanaddr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cleancity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cleanstate_Total_ErrorCount > 0, 1, 0) + IF(le.cleandob_Total_ErrorCount > 0, 1, 0) + IF(le.cleanupdatedte_Total_ErrorCount > 0, 1, 0) + IF(le.cleanemail_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cleanfirstname_Total_ErrorCount > 0, 1, 0) + IF(le.cleanmidname_Total_ErrorCount > 0, 1, 0) + IF(le.cleanlastname_Total_ErrorCount > 0, 1, 0) + IF(le.cleansuffixname_Total_ErrorCount > 0, 1, 0) + IF(le.cleanphone_Total_ErrorCount > 0, 1, 0) + IF(le.process_date_Total_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_Total_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_Total_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_Total_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_Total_ErrorCount > 0, 1, 0) + IF(le.dateadded_Total_ErrorCount > 0, 1, 0) + IF(le.dateupdated_Total_ErrorCount > 0, 1, 0) + IF(le.studentid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dartid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.college_ALLOW_ErrorCount > 0, 1, 0) + IF(le.semester_Total_ErrorCount > 0, 1, 0) + IF(le.year_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateofbirth_Total_ErrorCount > 0, 1, 0) + IF(le.dob_formatted_Total_ErrorCount > 0, 1, 0) + IF(le.addresstype_ENUM_ErrorCount > 0, 1, 0) + IF(le.phonetyp_ENUM_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.telephone_Total_ErrorCount > 0, 1, 0) + IF(le.college_major_ALLOW_ErrorCount > 0, 1, 0) + IF(le.new_college_major_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.cleanaddr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cleanaddr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cleancity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cleanstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cleanstate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cleandob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cleandob_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cleanupdatedte_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cleanupdatedte_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cleanemail_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cleanfirstname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cleanfirstname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cleanmidname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cleanmidname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cleanlastname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cleanlastname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cleansuffixname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cleansuffixname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cleanphone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cleanphone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.process_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.process_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dateadded_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateadded_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dateupdated_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateupdated_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.studentid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dartid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.college_ALLOW_ErrorCount > 0, 1, 0) + IF(le.semester_ENUM_ErrorCount > 0, 1, 0) + IF(le.semester_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.year_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateofbirth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateofbirth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dob_formatted_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_formatted_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.addresstype_ENUM_ErrorCount > 0, 1, 0) + IF(le.phonetyp_ENUM_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.telephone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.telephone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.college_major_ALLOW_ErrorCount > 0, 1, 0) + IF(le.new_college_major_CUSTOM_ErrorCount > 0, 1, 0);
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
    SELF.Src :=  le.cleancollegeid;
    UNSIGNED1 ErrNum := CHOOSE(c,le.cleanaddr1_Invalid,le.cleanaddr2_Invalid,le.cleancity_Invalid,le.cleanstate_Invalid,le.cleandob_Invalid,le.cleanupdatedte_Invalid,le.cleanemail_Invalid,le.cleanfirstname_Invalid,le.cleanmidname_Invalid,le.cleanlastname_Invalid,le.cleansuffixname_Invalid,le.cleanphone_Invalid,le.process_date_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,le.dateadded_Invalid,le.dateupdated_Invalid,le.studentid_Invalid,le.dartid_Invalid,le.college_Invalid,le.semester_Invalid,le.year_Invalid,le.dateofbirth_Invalid,le.dob_formatted_Invalid,le.addresstype_Invalid,le.phonetyp_Invalid,le.name_suffix_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.telephone_Invalid,le.college_major_Invalid,le.new_college_major_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_cleanaddr1(le.cleanaddr1_Invalid),Fields.InvalidMessage_cleanaddr2(le.cleanaddr2_Invalid),Fields.InvalidMessage_cleancity(le.cleancity_Invalid),Fields.InvalidMessage_cleanstate(le.cleanstate_Invalid),Fields.InvalidMessage_cleandob(le.cleandob_Invalid),Fields.InvalidMessage_cleanupdatedte(le.cleanupdatedte_Invalid),Fields.InvalidMessage_cleanemail(le.cleanemail_Invalid),Fields.InvalidMessage_cleanfirstname(le.cleanfirstname_Invalid),Fields.InvalidMessage_cleanmidname(le.cleanmidname_Invalid),Fields.InvalidMessage_cleanlastname(le.cleanlastname_Invalid),Fields.InvalidMessage_cleansuffixname(le.cleansuffixname_Invalid),Fields.InvalidMessage_cleanphone(le.cleanphone_Invalid),Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),Fields.InvalidMessage_dateadded(le.dateadded_Invalid),Fields.InvalidMessage_dateupdated(le.dateupdated_Invalid),Fields.InvalidMessage_studentid(le.studentid_Invalid),Fields.InvalidMessage_dartid(le.dartid_Invalid),Fields.InvalidMessage_college(le.college_Invalid),Fields.InvalidMessage_semester(le.semester_Invalid),Fields.InvalidMessage_year(le.year_Invalid),Fields.InvalidMessage_dateofbirth(le.dateofbirth_Invalid),Fields.InvalidMessage_dob_formatted(le.dob_formatted_Invalid),Fields.InvalidMessage_addresstype(le.addresstype_Invalid),Fields.InvalidMessage_phonetyp(le.phonetyp_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_telephone(le.telephone_Invalid),Fields.InvalidMessage_college_major(le.college_major_Invalid),Fields.InvalidMessage_new_college_major(le.new_college_major_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.cleanaddr1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cleanaddr2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cleancity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cleanstate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.cleandob_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.cleanupdatedte_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.cleanemail_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cleanfirstname_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.cleanmidname_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.cleanlastname_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.cleansuffixname_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.cleanphone_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dateadded_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dateupdated_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.studentid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dartid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.college_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.semester_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.year_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dateofbirth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dob_formatted_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.addresstype_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phonetyp_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.telephone_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.college_major_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.new_college_major_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'cleanaddr1','cleanaddr2','cleancity','cleanstate','cleandob','cleanupdatedte','cleanemail','cleanfirstname','cleanmidname','cleanlastname','cleansuffixname','cleanphone','process_date','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','dateadded','dateupdated','studentid','dartid','college','semester','year','dateofbirth','dob_formatted','addresstype','phonetyp','name_suffix','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','telephone','college_major','new_college_major','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_address','invalid_address','invalid_city','invalid_state','invalid_date','invalid_date','invalid_email','invalid_name','invalid_name','invalid_name','invalid_name','invalid_phone','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','nums','nums','invalid_college','invalid_semester','nums','invalid_date','invalid_date','invalid_addresstype','invalid_phonetyp','invalid_suffix','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_city','invalid_city','invalid_phone','invalid_MajorCode','invalid_NewMajorCode','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.cleanaddr1,(SALT311.StrType)le.cleanaddr2,(SALT311.StrType)le.cleancity,(SALT311.StrType)le.cleanstate,(SALT311.StrType)le.cleandob,(SALT311.StrType)le.cleanupdatedte,(SALT311.StrType)le.cleanemail,(SALT311.StrType)le.cleanfirstname,(SALT311.StrType)le.cleanmidname,(SALT311.StrType)le.cleanlastname,(SALT311.StrType)le.cleansuffixname,(SALT311.StrType)le.cleanphone,(SALT311.StrType)le.process_date,(SALT311.StrType)le.date_first_seen,(SALT311.StrType)le.date_last_seen,(SALT311.StrType)le.date_vendor_first_reported,(SALT311.StrType)le.date_vendor_last_reported,(SALT311.StrType)le.dateadded,(SALT311.StrType)le.dateupdated,(SALT311.StrType)le.studentid,(SALT311.StrType)le.dartid,(SALT311.StrType)le.college,(SALT311.StrType)le.semester,(SALT311.StrType)le.year,(SALT311.StrType)le.dateofbirth,(SALT311.StrType)le.dob_formatted,(SALT311.StrType)le.addresstype,(SALT311.StrType)le.phonetyp,(SALT311.StrType)le.name_suffix,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.addr_suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.p_city_name,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.telephone,(SALT311.StrType)le.college_major,(SALT311.StrType)le.new_college_major,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,41,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_OKC_Student_List) prevDS = DATASET([], Layout_OKC_Student_List)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.cleancollegeid;
      SELF.ruledesc := CHOOSE(c
          ,'cleanaddr1:invalid_address:ALLOW'
          ,'cleanaddr2:invalid_address:ALLOW'
          ,'cleancity:invalid_city:ALLOW'
          ,'cleanstate:invalid_state:ALLOW','cleanstate:invalid_state:LENGTHS'
          ,'cleandob:invalid_date:ALLOW','cleandob:invalid_date:LENGTHS'
          ,'cleanupdatedte:invalid_date:ALLOW','cleanupdatedte:invalid_date:LENGTHS'
          ,'cleanemail:invalid_email:ALLOW'
          ,'cleanfirstname:invalid_name:ALLOW','cleanfirstname:invalid_name:LENGTHS'
          ,'cleanmidname:invalid_name:ALLOW','cleanmidname:invalid_name:LENGTHS'
          ,'cleanlastname:invalid_name:ALLOW','cleanlastname:invalid_name:LENGTHS'
          ,'cleansuffixname:invalid_name:ALLOW','cleansuffixname:invalid_name:LENGTHS'
          ,'cleanphone:invalid_phone:ALLOW','cleanphone:invalid_phone:LENGTHS'
          ,'process_date:invalid_date:ALLOW','process_date:invalid_date:LENGTHS'
          ,'date_first_seen:invalid_date:ALLOW','date_first_seen:invalid_date:LENGTHS'
          ,'date_last_seen:invalid_date:ALLOW','date_last_seen:invalid_date:LENGTHS'
          ,'date_vendor_first_reported:invalid_date:ALLOW','date_vendor_first_reported:invalid_date:LENGTHS'
          ,'date_vendor_last_reported:invalid_date:ALLOW','date_vendor_last_reported:invalid_date:LENGTHS'
          ,'dateadded:invalid_date:ALLOW','dateadded:invalid_date:LENGTHS'
          ,'dateupdated:invalid_date:ALLOW','dateupdated:invalid_date:LENGTHS'
          ,'studentid:nums:ALLOW'
          ,'dartid:nums:ALLOW'
          ,'college:invalid_college:ALLOW'
          ,'semester:invalid_semester:ENUM','semester:invalid_semester:LENGTHS'
          ,'year:nums:ALLOW'
          ,'dateofbirth:invalid_date:ALLOW','dateofbirth:invalid_date:LENGTHS'
          ,'dob_formatted:invalid_date:ALLOW','dob_formatted:invalid_date:LENGTHS'
          ,'addresstype:invalid_addresstype:ENUM'
          ,'phonetyp:invalid_phonetyp:ENUM'
          ,'name_suffix:invalid_suffix:ALLOW'
          ,'prim_range:invalid_address:ALLOW'
          ,'predir:invalid_address:ALLOW'
          ,'prim_name:invalid_address:ALLOW'
          ,'addr_suffix:invalid_address:ALLOW'
          ,'postdir:invalid_address:ALLOW'
          ,'unit_desig:invalid_address:ALLOW'
          ,'sec_range:invalid_address:ALLOW'
          ,'p_city_name:invalid_city:ALLOW'
          ,'v_city_name:invalid_city:ALLOW'
          ,'telephone:invalid_phone:ALLOW','telephone:invalid_phone:LENGTHS'
          ,'college_major:invalid_MajorCode:ALLOW'
          ,'new_college_major:invalid_NewMajorCode:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_cleanaddr1(1)
          ,Fields.InvalidMessage_cleanaddr2(1)
          ,Fields.InvalidMessage_cleancity(1)
          ,Fields.InvalidMessage_cleanstate(1),Fields.InvalidMessage_cleanstate(2)
          ,Fields.InvalidMessage_cleandob(1),Fields.InvalidMessage_cleandob(2)
          ,Fields.InvalidMessage_cleanupdatedte(1),Fields.InvalidMessage_cleanupdatedte(2)
          ,Fields.InvalidMessage_cleanemail(1)
          ,Fields.InvalidMessage_cleanfirstname(1),Fields.InvalidMessage_cleanfirstname(2)
          ,Fields.InvalidMessage_cleanmidname(1),Fields.InvalidMessage_cleanmidname(2)
          ,Fields.InvalidMessage_cleanlastname(1),Fields.InvalidMessage_cleanlastname(2)
          ,Fields.InvalidMessage_cleansuffixname(1),Fields.InvalidMessage_cleansuffixname(2)
          ,Fields.InvalidMessage_cleanphone(1),Fields.InvalidMessage_cleanphone(2)
          ,Fields.InvalidMessage_process_date(1),Fields.InvalidMessage_process_date(2)
          ,Fields.InvalidMessage_date_first_seen(1),Fields.InvalidMessage_date_first_seen(2)
          ,Fields.InvalidMessage_date_last_seen(1),Fields.InvalidMessage_date_last_seen(2)
          ,Fields.InvalidMessage_date_vendor_first_reported(1),Fields.InvalidMessage_date_vendor_first_reported(2)
          ,Fields.InvalidMessage_date_vendor_last_reported(1),Fields.InvalidMessage_date_vendor_last_reported(2)
          ,Fields.InvalidMessage_dateadded(1),Fields.InvalidMessage_dateadded(2)
          ,Fields.InvalidMessage_dateupdated(1),Fields.InvalidMessage_dateupdated(2)
          ,Fields.InvalidMessage_studentid(1)
          ,Fields.InvalidMessage_dartid(1)
          ,Fields.InvalidMessage_college(1)
          ,Fields.InvalidMessage_semester(1),Fields.InvalidMessage_semester(2)
          ,Fields.InvalidMessage_year(1)
          ,Fields.InvalidMessage_dateofbirth(1),Fields.InvalidMessage_dateofbirth(2)
          ,Fields.InvalidMessage_dob_formatted(1),Fields.InvalidMessage_dob_formatted(2)
          ,Fields.InvalidMessage_addresstype(1)
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
          ,Fields.InvalidMessage_telephone(1),Fields.InvalidMessage_telephone(2)
          ,Fields.InvalidMessage_college_major(1)
          ,Fields.InvalidMessage_new_college_major(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.cleanaddr1_ALLOW_ErrorCount
          ,le.cleanaddr2_ALLOW_ErrorCount
          ,le.cleancity_ALLOW_ErrorCount
          ,le.cleanstate_ALLOW_ErrorCount,le.cleanstate_LENGTHS_ErrorCount
          ,le.cleandob_ALLOW_ErrorCount,le.cleandob_LENGTHS_ErrorCount
          ,le.cleanupdatedte_ALLOW_ErrorCount,le.cleanupdatedte_LENGTHS_ErrorCount
          ,le.cleanemail_ALLOW_ErrorCount
          ,le.cleanfirstname_ALLOW_ErrorCount,le.cleanfirstname_LENGTHS_ErrorCount
          ,le.cleanmidname_ALLOW_ErrorCount,le.cleanmidname_LENGTHS_ErrorCount
          ,le.cleanlastname_ALLOW_ErrorCount,le.cleanlastname_LENGTHS_ErrorCount
          ,le.cleansuffixname_ALLOW_ErrorCount,le.cleansuffixname_LENGTHS_ErrorCount
          ,le.cleanphone_ALLOW_ErrorCount,le.cleanphone_LENGTHS_ErrorCount
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTHS_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTHS_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTHS_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTHS_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTHS_ErrorCount
          ,le.dateadded_ALLOW_ErrorCount,le.dateadded_LENGTHS_ErrorCount
          ,le.dateupdated_ALLOW_ErrorCount,le.dateupdated_LENGTHS_ErrorCount
          ,le.studentid_ALLOW_ErrorCount
          ,le.dartid_ALLOW_ErrorCount
          ,le.college_ALLOW_ErrorCount
          ,le.semester_ENUM_ErrorCount,le.semester_LENGTHS_ErrorCount
          ,le.year_ALLOW_ErrorCount
          ,le.dateofbirth_ALLOW_ErrorCount,le.dateofbirth_LENGTHS_ErrorCount
          ,le.dob_formatted_ALLOW_ErrorCount,le.dob_formatted_LENGTHS_ErrorCount
          ,le.addresstype_ENUM_ErrorCount
          ,le.phonetyp_ENUM_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.telephone_ALLOW_ErrorCount,le.telephone_LENGTHS_ErrorCount
          ,le.college_major_ALLOW_ErrorCount
          ,le.new_college_major_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.cleanaddr1_ALLOW_ErrorCount
          ,le.cleanaddr2_ALLOW_ErrorCount
          ,le.cleancity_ALLOW_ErrorCount
          ,le.cleanstate_ALLOW_ErrorCount,le.cleanstate_LENGTHS_ErrorCount
          ,le.cleandob_ALLOW_ErrorCount,le.cleandob_LENGTHS_ErrorCount
          ,le.cleanupdatedte_ALLOW_ErrorCount,le.cleanupdatedte_LENGTHS_ErrorCount
          ,le.cleanemail_ALLOW_ErrorCount
          ,le.cleanfirstname_ALLOW_ErrorCount,le.cleanfirstname_LENGTHS_ErrorCount
          ,le.cleanmidname_ALLOW_ErrorCount,le.cleanmidname_LENGTHS_ErrorCount
          ,le.cleanlastname_ALLOW_ErrorCount,le.cleanlastname_LENGTHS_ErrorCount
          ,le.cleansuffixname_ALLOW_ErrorCount,le.cleansuffixname_LENGTHS_ErrorCount
          ,le.cleanphone_ALLOW_ErrorCount,le.cleanphone_LENGTHS_ErrorCount
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTHS_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTHS_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTHS_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTHS_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTHS_ErrorCount
          ,le.dateadded_ALLOW_ErrorCount,le.dateadded_LENGTHS_ErrorCount
          ,le.dateupdated_ALLOW_ErrorCount,le.dateupdated_LENGTHS_ErrorCount
          ,le.studentid_ALLOW_ErrorCount
          ,le.dartid_ALLOW_ErrorCount
          ,le.college_ALLOW_ErrorCount
          ,le.semester_ENUM_ErrorCount,le.semester_LENGTHS_ErrorCount
          ,le.year_ALLOW_ErrorCount
          ,le.dateofbirth_ALLOW_ErrorCount,le.dateofbirth_LENGTHS_ErrorCount
          ,le.dob_formatted_ALLOW_ErrorCount,le.dob_formatted_LENGTHS_ErrorCount
          ,le.addresstype_ENUM_ErrorCount
          ,le.phonetyp_ENUM_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.telephone_ALLOW_ErrorCount,le.telephone_LENGTHS_ErrorCount
          ,le.college_major_ALLOW_ErrorCount
          ,le.new_college_major_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_OKC_Student_List));
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
          ,'cleanaddr1:' + getFieldTypeText(h.cleanaddr1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleanaddr2:' + getFieldTypeText(h.cleanaddr2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleanattendancedte:' + getFieldTypeText(h.cleanattendancedte) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleancity:' + getFieldTypeText(h.cleancity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleanstate:' + getFieldTypeText(h.cleanstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleanzip:' + getFieldTypeText(h.cleanzip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleanzip4:' + getFieldTypeText(h.cleanzip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleanfulladdr:' + getFieldTypeText(h.cleanfulladdr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleandob:' + getFieldTypeText(h.cleandob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleanupdatedte:' + getFieldTypeText(h.cleanupdatedte) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleanemail:' + getFieldTypeText(h.cleanemail) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_email_username:' + getFieldTypeText(h.append_email_username) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_domain:' + getFieldTypeText(h.append_domain) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_domain_type:' + getFieldTypeText(h.append_domain_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_domain_root:' + getFieldTypeText(h.append_domain_root) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_domain_ext:' + getFieldTypeText(h.append_domain_ext) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_is_tld_state:' + getFieldTypeText(h.append_is_tld_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_is_tld_generic:' + getFieldTypeText(h.append_is_tld_generic) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_is_tld_country:' + getFieldTypeText(h.append_is_tld_country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_is_valid_domain_ext:' + getFieldTypeText(h.append_is_valid_domain_ext) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleantitle:' + getFieldTypeText(h.cleantitle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleanfirstname:' + getFieldTypeText(h.cleanfirstname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleanmidname:' + getFieldTypeText(h.cleanmidname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleanlastname:' + getFieldTypeText(h.cleanlastname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleansuffixname:' + getFieldTypeText(h.cleansuffixname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleanmajor:' + getFieldTypeText(h.cleanmajor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleanphone:' + getFieldTypeText(h.cleanphone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_first_seen:' + getFieldTypeText(h.date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_last_seen:' + getFieldTypeText(h.date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_first_reported:' + getFieldTypeText(h.date_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_last_reported:' + getFieldTypeText(h.date_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateadded:' + getFieldTypeText(h.dateadded) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateupdated:' + getFieldTypeText(h.dateupdated) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'studentid:' + getFieldTypeText(h.studentid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dartid:' + getFieldTypeText(h.dartid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'collegeid:' + getFieldTypeText(h.collegeid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'projectsource:' + getFieldTypeText(h.projectsource) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'collegestate:' + getFieldTypeText(h.collegestate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college:' + getFieldTypeText(h.college) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'semester:' + getFieldTypeText(h.semester) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'year:' + getFieldTypeText(h.year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firstname:' + getFieldTypeText(h.firstname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'middlename:' + getFieldTypeText(h.middlename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lastname:' + getFieldTypeText(h.lastname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'major:' + getFieldTypeText(h.major) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'grade:' + getFieldTypeText(h.grade) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email:' + getFieldTypeText(h.email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateofbirth:' + getFieldTypeText(h.dateofbirth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob_formatted:' + getFieldTypeText(h.dob_formatted) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attendancedate:' + getFieldTypeText(h.attendancedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'enrollmentstatus:' + getFieldTypeText(h.enrollmentstatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addresstype:' + getFieldTypeText(h.addresstype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_1:' + getFieldTypeText(h.address_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_2:' + getFieldTypeText(h.address_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'z5:' + getFieldTypeText(h.z5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'z4:' + getFieldTypeText(h.z4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phonetyp:' + getFieldTypeText(h.phonetyp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phonenumber:' + getFieldTypeText(h.phonenumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tier:' + getFieldTypeText(h.tier) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'school_size_code:' + getFieldTypeText(h.school_size_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'competitive_code:' + getFieldTypeText(h.competitive_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tuition_code:' + getFieldTypeText(h.tuition_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_score:' + getFieldTypeText(h.name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawaid:' + getFieldTypeText(h.rawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix:' + getFieldTypeText(h.addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpbc:' + getFieldTypeText(h.dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_state:' + getFieldTypeText(h.fips_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'telephone:' + getFieldTypeText(h.telephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tier2:' + getFieldTypeText(h.tier2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source:' + getFieldTypeText(h.source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'key:' + getFieldTypeText(h.key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn:' + getFieldTypeText(h.ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'historical_flag:' + getFieldTypeText(h.historical_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'full_name:' + getFieldTypeText(h.full_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_class:' + getFieldTypeText(h.college_class) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_name:' + getFieldTypeText(h.college_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_college_name:' + getFieldTypeText(h.ln_college_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_major:' + getFieldTypeText(h.college_major) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'new_college_major:' + getFieldTypeText(h.new_college_major) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_code:' + getFieldTypeText(h.college_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_code_exploded:' + getFieldTypeText(h.college_code_exploded) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_type:' + getFieldTypeText(h.college_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_type_exploded:' + getFieldTypeText(h.college_type_exploded) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_type:' + getFieldTypeText(h.file_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'collegeupdate:' + getFieldTypeText(h.collegeupdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_cleanaddr1_cnt
          ,le.populated_cleanaddr2_cnt
          ,le.populated_cleanattendancedte_cnt
          ,le.populated_cleancity_cnt
          ,le.populated_cleanstate_cnt
          ,le.populated_cleanzip_cnt
          ,le.populated_cleanzip4_cnt
          ,le.populated_cleanfulladdr_cnt
          ,le.populated_cleandob_cnt
          ,le.populated_cleanupdatedte_cnt
          ,le.populated_cleanemail_cnt
          ,le.populated_append_email_username_cnt
          ,le.populated_append_domain_cnt
          ,le.populated_append_domain_type_cnt
          ,le.populated_append_domain_root_cnt
          ,le.populated_append_domain_ext_cnt
          ,le.populated_append_is_tld_state_cnt
          ,le.populated_append_is_tld_generic_cnt
          ,le.populated_append_is_tld_country_cnt
          ,le.populated_append_is_valid_domain_ext_cnt
          ,le.populated_cleantitle_cnt
          ,le.populated_cleanfirstname_cnt
          ,le.populated_cleanmidname_cnt
          ,le.populated_cleanlastname_cnt
          ,le.populated_cleansuffixname_cnt
          ,le.populated_cleanmajor_cnt
          ,le.populated_cleanphone_cnt
          ,le.populated_did_cnt
          ,le.populated_process_date_cnt
          ,le.populated_date_first_seen_cnt
          ,le.populated_date_last_seen_cnt
          ,le.populated_date_vendor_first_reported_cnt
          ,le.populated_date_vendor_last_reported_cnt
          ,le.populated_dateadded_cnt
          ,le.populated_dateupdated_cnt
          ,le.populated_studentid_cnt
          ,le.populated_dartid_cnt
          ,le.populated_collegeid_cnt
          ,le.populated_projectsource_cnt
          ,le.populated_collegestate_cnt
          ,le.populated_college_cnt
          ,le.populated_semester_cnt
          ,le.populated_year_cnt
          ,le.populated_firstname_cnt
          ,le.populated_middlename_cnt
          ,le.populated_lastname_cnt
          ,le.populated_suffix_cnt
          ,le.populated_major_cnt
          ,le.populated_grade_cnt
          ,le.populated_email_cnt
          ,le.populated_dateofbirth_cnt
          ,le.populated_dob_formatted_cnt
          ,le.populated_attendancedate_cnt
          ,le.populated_enrollmentstatus_cnt
          ,le.populated_addresstype_cnt
          ,le.populated_address_1_cnt
          ,le.populated_address_2_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_z5_cnt
          ,le.populated_z4_cnt
          ,le.populated_phonetyp_cnt
          ,le.populated_phonenumber_cnt
          ,le.populated_tier_cnt
          ,le.populated_school_size_code_cnt
          ,le.populated_competitive_code_cnt
          ,le.populated_tuition_code_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_name_score_cnt
          ,le.populated_rawaid_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_addr_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dpbc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_county_cnt
          ,le.populated_fips_state_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_telephone_cnt
          ,le.populated_tier2_cnt
          ,le.populated_source_cnt
          ,le.populated_key_cnt
          ,le.populated_ssn_cnt
          ,le.populated_historical_flag_cnt
          ,le.populated_full_name_cnt
          ,le.populated_college_class_cnt
          ,le.populated_college_name_cnt
          ,le.populated_ln_college_name_cnt
          ,le.populated_college_major_cnt
          ,le.populated_new_college_major_cnt
          ,le.populated_college_code_cnt
          ,le.populated_college_code_exploded_cnt
          ,le.populated_college_type_cnt
          ,le.populated_college_type_exploded_cnt
          ,le.populated_file_type_cnt
          ,le.populated_collegeupdate_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_cleanaddr1_pcnt
          ,le.populated_cleanaddr2_pcnt
          ,le.populated_cleanattendancedte_pcnt
          ,le.populated_cleancity_pcnt
          ,le.populated_cleanstate_pcnt
          ,le.populated_cleanzip_pcnt
          ,le.populated_cleanzip4_pcnt
          ,le.populated_cleanfulladdr_pcnt
          ,le.populated_cleandob_pcnt
          ,le.populated_cleanupdatedte_pcnt
          ,le.populated_cleanemail_pcnt
          ,le.populated_append_email_username_pcnt
          ,le.populated_append_domain_pcnt
          ,le.populated_append_domain_type_pcnt
          ,le.populated_append_domain_root_pcnt
          ,le.populated_append_domain_ext_pcnt
          ,le.populated_append_is_tld_state_pcnt
          ,le.populated_append_is_tld_generic_pcnt
          ,le.populated_append_is_tld_country_pcnt
          ,le.populated_append_is_valid_domain_ext_pcnt
          ,le.populated_cleantitle_pcnt
          ,le.populated_cleanfirstname_pcnt
          ,le.populated_cleanmidname_pcnt
          ,le.populated_cleanlastname_pcnt
          ,le.populated_cleansuffixname_pcnt
          ,le.populated_cleanmajor_pcnt
          ,le.populated_cleanphone_pcnt
          ,le.populated_did_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_date_first_seen_pcnt
          ,le.populated_date_last_seen_pcnt
          ,le.populated_date_vendor_first_reported_pcnt
          ,le.populated_date_vendor_last_reported_pcnt
          ,le.populated_dateadded_pcnt
          ,le.populated_dateupdated_pcnt
          ,le.populated_studentid_pcnt
          ,le.populated_dartid_pcnt
          ,le.populated_collegeid_pcnt
          ,le.populated_projectsource_pcnt
          ,le.populated_collegestate_pcnt
          ,le.populated_college_pcnt
          ,le.populated_semester_pcnt
          ,le.populated_year_pcnt
          ,le.populated_firstname_pcnt
          ,le.populated_middlename_pcnt
          ,le.populated_lastname_pcnt
          ,le.populated_suffix_pcnt
          ,le.populated_major_pcnt
          ,le.populated_grade_pcnt
          ,le.populated_email_pcnt
          ,le.populated_dateofbirth_pcnt
          ,le.populated_dob_formatted_pcnt
          ,le.populated_attendancedate_pcnt
          ,le.populated_enrollmentstatus_pcnt
          ,le.populated_addresstype_pcnt
          ,le.populated_address_1_pcnt
          ,le.populated_address_2_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_z5_pcnt
          ,le.populated_z4_pcnt
          ,le.populated_phonetyp_pcnt
          ,le.populated_phonenumber_pcnt
          ,le.populated_tier_pcnt
          ,le.populated_school_size_code_pcnt
          ,le.populated_competitive_code_pcnt
          ,le.populated_tuition_code_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_name_score_pcnt
          ,le.populated_rawaid_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_addr_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dpbc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_county_pcnt
          ,le.populated_fips_state_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_telephone_pcnt
          ,le.populated_tier2_pcnt
          ,le.populated_source_pcnt
          ,le.populated_key_pcnt
          ,le.populated_ssn_pcnt
          ,le.populated_historical_flag_pcnt
          ,le.populated_full_name_pcnt
          ,le.populated_college_class_pcnt
          ,le.populated_college_name_pcnt
          ,le.populated_ln_college_name_pcnt
          ,le.populated_college_major_pcnt
          ,le.populated_new_college_major_pcnt
          ,le.populated_college_code_pcnt
          ,le.populated_college_code_exploded_pcnt
          ,le.populated_college_type_pcnt
          ,le.populated_college_type_exploded_pcnt
          ,le.populated_file_type_pcnt
          ,le.populated_collegeupdate_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,120,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_OKC_Student_List));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),120,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_OKC_Student_List) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_OKC_Student_List_V2, Fields, 'RECORDOF(scrubsSummaryOverall)', 'cleancollegeid');
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
  scrubsSummaryPerSource_Standard_GeneralErrs := IF(doErrorPerSrc, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryPerSource, cleancollegeid, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryPerSource_Standard_addErr & scrubsSummaryPerSource_Standard_GeneralErrs & scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;

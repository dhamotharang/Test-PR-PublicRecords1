IMPORT SALT39,STD;
EXPORT InquiryLogs_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 45;
  EXPORT NumRulesFromFieldType := 45;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 24;
  EXPORT NumFieldsWithPossibleEdits := 9;
  EXPORT NumRulesWithPossibleEdits := 26;
  EXPORT Expanded_Layout := RECORD(InquiryLogs_Layout_InquiryLogs)
    UNSIGNED1 transaction_id_Invalid;
    UNSIGNED1 datetime_Invalid;
    BOOLEAN datetime_wouldClean;
    UNSIGNED1 full_name_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 ssn_Invalid;
    BOOLEAN ssn_wouldClean;
    UNSIGNED1 appended_ssn_Invalid;
    BOOLEAN appended_ssn_wouldClean;
    UNSIGNED1 address_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    BOOLEAN state_wouldClean;
    UNSIGNED1 zip_Invalid;
    BOOLEAN zip_wouldClean;
    UNSIGNED1 fips_county_Invalid;
    UNSIGNED1 personal_phone_Invalid;
    BOOLEAN personal_phone_wouldClean;
    UNSIGNED1 dob_Invalid;
    BOOLEAN dob_wouldClean;
    UNSIGNED1 email_address_Invalid;
    UNSIGNED1 dl_st_Invalid;
    BOOLEAN dl_st_wouldClean;
    UNSIGNED1 dl_Invalid;
    UNSIGNED1 ipaddr_Invalid;
    BOOLEAN ipaddr_wouldClean;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 Source_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(InquiryLogs_Layout_InquiryLogs)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(InquiryLogs_Layout_InquiryLogs) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.transaction_id_Invalid := InquiryLogs_Fields.InValid_transaction_id((SALT39.StrType)le.transaction_id);
    SELF.datetime_Invalid := InquiryLogs_Fields.InValid_datetime((SALT39.StrType)le.datetime);
    SELF.datetime := IF(SELF.datetime_Invalid=0 OR NOT withOnfail, le.datetime, (TYPEOF(le.datetime))''); // ONFAIL(BLANK)
    SELF.datetime_wouldClean :=  SELF.datetime_Invalid > 0;
    SELF.full_name_Invalid := InquiryLogs_Fields.InValid_full_name((SALT39.StrType)le.full_name);
    SELF.title_Invalid := InquiryLogs_Fields.InValid_title((SALT39.StrType)le.title);
    SELF.fname_Invalid := InquiryLogs_Fields.InValid_fname((SALT39.StrType)le.fname);
    SELF.mname_Invalid := InquiryLogs_Fields.InValid_mname((SALT39.StrType)le.mname);
    SELF.lname_Invalid := InquiryLogs_Fields.InValid_lname((SALT39.StrType)le.lname);
    SELF.name_suffix_Invalid := InquiryLogs_Fields.InValid_name_suffix((SALT39.StrType)le.name_suffix);
    SELF.ssn_Invalid := InquiryLogs_Fields.InValid_ssn((SALT39.StrType)le.ssn);
    SELF.ssn := IF(SELF.ssn_Invalid=0 OR NOT withOnfail, le.ssn, (TYPEOF(le.ssn))''); // ONFAIL(BLANK)
    SELF.ssn_wouldClean :=  SELF.ssn_Invalid > 0;
    SELF.appended_ssn_Invalid := InquiryLogs_Fields.InValid_appended_ssn((SALT39.StrType)le.appended_ssn);
    SELF.appended_ssn := IF(SELF.appended_ssn_Invalid=0 OR NOT withOnfail, le.appended_ssn, (TYPEOF(le.appended_ssn))''); // ONFAIL(BLANK)
    SELF.appended_ssn_wouldClean :=  SELF.appended_ssn_Invalid > 0;
    SELF.address_Invalid := InquiryLogs_Fields.InValid_address((SALT39.StrType)le.address);
    SELF.city_Invalid := InquiryLogs_Fields.InValid_city((SALT39.StrType)le.city);
    SELF.state_Invalid := InquiryLogs_Fields.InValid_state((SALT39.StrType)le.state);
    SELF.state := IF(SELF.state_Invalid=0 OR NOT withOnfail, le.state, (TYPEOF(le.state))''); // ONFAIL(BLANK)
    SELF.state_wouldClean :=  SELF.state_Invalid > 0;
    SELF.zip_Invalid := InquiryLogs_Fields.InValid_zip((SALT39.StrType)le.zip);
    SELF.zip := IF(SELF.zip_Invalid=0 OR NOT withOnfail, le.zip, (TYPEOF(le.zip))''); // ONFAIL(BLANK)
    SELF.zip_wouldClean :=  SELF.zip_Invalid > 0;
    SELF.fips_county_Invalid := InquiryLogs_Fields.InValid_fips_county((SALT39.StrType)le.fips_county);
    SELF.personal_phone_Invalid := InquiryLogs_Fields.InValid_personal_phone((SALT39.StrType)le.personal_phone);
    SELF.personal_phone := IF(SELF.personal_phone_Invalid=0 OR NOT withOnfail, le.personal_phone, (TYPEOF(le.personal_phone))''); // ONFAIL(BLANK)
    SELF.personal_phone_wouldClean :=  SELF.personal_phone_Invalid > 0;
    SELF.dob_Invalid := InquiryLogs_Fields.InValid_dob((SALT39.StrType)le.dob);
    SELF.dob := IF(SELF.dob_Invalid=0 OR NOT withOnfail, le.dob, (TYPEOF(le.dob))''); // ONFAIL(BLANK)
    SELF.dob_wouldClean :=  SELF.dob_Invalid > 0;
    SELF.email_address_Invalid := InquiryLogs_Fields.InValid_email_address((SALT39.StrType)le.email_address);
    SELF.dl_st_Invalid := InquiryLogs_Fields.InValid_dl_st((SALT39.StrType)le.dl_st);
    SELF.dl_st := IF(SELF.dl_st_Invalid=0 OR NOT withOnfail, le.dl_st, (TYPEOF(le.dl_st))''); // ONFAIL(BLANK)
    SELF.dl_st_wouldClean :=  SELF.dl_st_Invalid > 0;
    SELF.dl_Invalid := InquiryLogs_Fields.InValid_dl((SALT39.StrType)le.dl);
    SELF.ipaddr_Invalid := InquiryLogs_Fields.InValid_ipaddr((SALT39.StrType)le.ipaddr);
    SELF.ipaddr := IF(SELF.ipaddr_Invalid=0 OR NOT withOnfail, le.ipaddr, (TYPEOF(le.ipaddr))''); // ONFAIL(BLANK)
    SELF.ipaddr_wouldClean :=  SELF.ipaddr_Invalid > 0;
    SELF.geo_lat_Invalid := InquiryLogs_Fields.InValid_geo_lat((SALT39.StrType)le.geo_lat);
    SELF.geo_long_Invalid := InquiryLogs_Fields.InValid_geo_long((SALT39.StrType)le.geo_long);
    SELF.Source_Invalid := InquiryLogs_Fields.InValid_Source((SALT39.StrType)le.Source);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),InquiryLogs_Layout_InquiryLogs);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.transaction_id_Invalid << 0 ) + ( le.datetime_Invalid << 1 ) + ( le.full_name_Invalid << 3 ) + ( le.title_Invalid << 5 ) + ( le.fname_Invalid << 6 ) + ( le.mname_Invalid << 8 ) + ( le.lname_Invalid << 10 ) + ( le.name_suffix_Invalid << 12 ) + ( le.ssn_Invalid << 13 ) + ( le.appended_ssn_Invalid << 15 ) + ( le.address_Invalid << 17 ) + ( le.city_Invalid << 18 ) + ( le.state_Invalid << 19 ) + ( le.zip_Invalid << 21 ) + ( le.fips_county_Invalid << 23 ) + ( le.personal_phone_Invalid << 24 ) + ( le.dob_Invalid << 26 ) + ( le.email_address_Invalid << 28 ) + ( le.dl_st_Invalid << 29 ) + ( le.dl_Invalid << 31 ) + ( le.ipaddr_Invalid << 32 ) + ( le.geo_lat_Invalid << 34 ) + ( le.geo_long_Invalid << 35 ) + ( le.Source_Invalid << 36 );
    SELF.ScrubsCleanBits1 := ( IF(le.datetime_wouldClean, 1, 0) << 0 ) + ( IF(le.ssn_wouldClean, 1, 0) << 1 ) + ( IF(le.appended_ssn_wouldClean, 1, 0) << 2 ) + ( IF(le.state_wouldClean, 1, 0) << 3 ) + ( IF(le.zip_wouldClean, 1, 0) << 4 ) + ( IF(le.personal_phone_wouldClean, 1, 0) << 5 ) + ( IF(le.dob_wouldClean, 1, 0) << 6 ) + ( IF(le.dl_st_wouldClean, 1, 0) << 7 ) + ( IF(le.ipaddr_wouldClean, 1, 0) << 8 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,InquiryLogs_Layout_InquiryLogs);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.transaction_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.datetime_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.full_name_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.title_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.appended_ssn_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.address_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.fips_county_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.personal_phone_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.email_address_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.dl_st_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.dl_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.ipaddr_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.geo_lat_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.Source_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.datetime_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.ssn_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.appended_ssn_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.state_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.zip_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.personal_phone_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.dob_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.dl_st_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.ipaddr_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    transaction_id_ALLOW_ErrorCount := COUNT(GROUP,h.transaction_id_Invalid=1);
    datetime_LEFTTRIM_ErrorCount := COUNT(GROUP,h.datetime_Invalid=1);
    datetime_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.datetime_Invalid=1 AND h.datetime_wouldClean);
    datetime_ALLOW_ErrorCount := COUNT(GROUP,h.datetime_Invalid=2);
    datetime_ALLOW_WouldModifyCount := COUNT(GROUP,h.datetime_Invalid=2 AND h.datetime_wouldClean);
    datetime_LENGTHS_ErrorCount := COUNT(GROUP,h.datetime_Invalid=3);
    datetime_LENGTHS_WouldModifyCount := COUNT(GROUP,h.datetime_Invalid=3 AND h.datetime_wouldClean);
    datetime_Total_ErrorCount := COUNT(GROUP,h.datetime_Invalid>0);
    full_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.full_name_Invalid=1);
    full_name_ALLOW_ErrorCount := COUNT(GROUP,h.full_name_Invalid=2);
    full_name_Total_ErrorCount := COUNT(GROUP,h.full_name_Invalid>0);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    fname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    mname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    lname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    ssn_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    ssn_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.ssn_Invalid=1 AND h.ssn_wouldClean);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=2);
    ssn_ALLOW_WouldModifyCount := COUNT(GROUP,h.ssn_Invalid=2 AND h.ssn_wouldClean);
    ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.ssn_Invalid=3);
    ssn_LENGTHS_WouldModifyCount := COUNT(GROUP,h.ssn_Invalid=3 AND h.ssn_wouldClean);
    ssn_Total_ErrorCount := COUNT(GROUP,h.ssn_Invalid>0);
    appended_ssn_LEFTTRIM_ErrorCount := COUNT(GROUP,h.appended_ssn_Invalid=1);
    appended_ssn_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.appended_ssn_Invalid=1 AND h.appended_ssn_wouldClean);
    appended_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.appended_ssn_Invalid=2);
    appended_ssn_ALLOW_WouldModifyCount := COUNT(GROUP,h.appended_ssn_Invalid=2 AND h.appended_ssn_wouldClean);
    appended_ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.appended_ssn_Invalid=3);
    appended_ssn_LENGTHS_WouldModifyCount := COUNT(GROUP,h.appended_ssn_Invalid=3 AND h.appended_ssn_wouldClean);
    appended_ssn_Total_ErrorCount := COUNT(GROUP,h.appended_ssn_Invalid>0);
    address_ALLOW_ErrorCount := COUNT(GROUP,h.address_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.state_Invalid=1 AND h.state_wouldClean);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_ALLOW_WouldModifyCount := COUNT(GROUP,h.state_Invalid=2 AND h.state_wouldClean);
    state_LENGTHS_ErrorCount := COUNT(GROUP,h.state_Invalid=3);
    state_LENGTHS_WouldModifyCount := COUNT(GROUP,h.state_Invalid=3 AND h.state_wouldClean);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.zip_Invalid=1 AND h.zip_wouldClean);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_ALLOW_WouldModifyCount := COUNT(GROUP,h.zip_Invalid=2 AND h.zip_wouldClean);
    zip_LENGTHS_ErrorCount := COUNT(GROUP,h.zip_Invalid=3);
    zip_LENGTHS_WouldModifyCount := COUNT(GROUP,h.zip_Invalid=3 AND h.zip_wouldClean);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    fips_county_ALLOW_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=1);
    personal_phone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.personal_phone_Invalid=1);
    personal_phone_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.personal_phone_Invalid=1 AND h.personal_phone_wouldClean);
    personal_phone_ALLOW_ErrorCount := COUNT(GROUP,h.personal_phone_Invalid=2);
    personal_phone_ALLOW_WouldModifyCount := COUNT(GROUP,h.personal_phone_Invalid=2 AND h.personal_phone_wouldClean);
    personal_phone_LENGTHS_ErrorCount := COUNT(GROUP,h.personal_phone_Invalid=3);
    personal_phone_LENGTHS_WouldModifyCount := COUNT(GROUP,h.personal_phone_Invalid=3 AND h.personal_phone_wouldClean);
    personal_phone_Total_ErrorCount := COUNT(GROUP,h.personal_phone_Invalid>0);
    dob_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.dob_Invalid=1 AND h.dob_wouldClean);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_ALLOW_WouldModifyCount := COUNT(GROUP,h.dob_Invalid=2 AND h.dob_wouldClean);
    dob_LENGTHS_ErrorCount := COUNT(GROUP,h.dob_Invalid=3);
    dob_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dob_Invalid=3 AND h.dob_wouldClean);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    email_address_ALLOW_ErrorCount := COUNT(GROUP,h.email_address_Invalid=1);
    dl_st_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dl_st_Invalid=1);
    dl_st_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.dl_st_Invalid=1 AND h.dl_st_wouldClean);
    dl_st_ALLOW_ErrorCount := COUNT(GROUP,h.dl_st_Invalid=2);
    dl_st_ALLOW_WouldModifyCount := COUNT(GROUP,h.dl_st_Invalid=2 AND h.dl_st_wouldClean);
    dl_st_LENGTHS_ErrorCount := COUNT(GROUP,h.dl_st_Invalid=3);
    dl_st_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dl_st_Invalid=3 AND h.dl_st_wouldClean);
    dl_st_Total_ErrorCount := COUNT(GROUP,h.dl_st_Invalid>0);
    dl_ALLOW_ErrorCount := COUNT(GROUP,h.dl_Invalid=1);
    ipaddr_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ipaddr_Invalid=1);
    ipaddr_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.ipaddr_Invalid=1 AND h.ipaddr_wouldClean);
    ipaddr_ALLOW_ErrorCount := COUNT(GROUP,h.ipaddr_Invalid=2);
    ipaddr_ALLOW_WouldModifyCount := COUNT(GROUP,h.ipaddr_Invalid=2 AND h.ipaddr_wouldClean);
    ipaddr_Total_ErrorCount := COUNT(GROUP,h.ipaddr_Invalid>0);
    geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    Source_ALLOW_ErrorCount := COUNT(GROUP,h.Source_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.transaction_id_Invalid > 0 OR h.datetime_Invalid > 0 OR h.full_name_Invalid > 0 OR h.title_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.ssn_Invalid > 0 OR h.appended_ssn_Invalid > 0 OR h.address_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zip_Invalid > 0 OR h.fips_county_Invalid > 0 OR h.personal_phone_Invalid > 0 OR h.dob_Invalid > 0 OR h.email_address_Invalid > 0 OR h.dl_st_Invalid > 0 OR h.dl_Invalid > 0 OR h.ipaddr_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.Source_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.datetime_wouldClean OR h.ssn_wouldClean OR h.appended_ssn_wouldClean OR h.state_wouldClean OR h.zip_wouldClean OR h.personal_phone_wouldClean OR h.dob_wouldClean OR h.dl_st_wouldClean OR h.ipaddr_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.transaction_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.datetime_Total_ErrorCount > 0, 1, 0) + IF(le.full_name_Total_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_Total_ErrorCount > 0, 1, 0) + IF(le.mname_Total_ErrorCount > 0, 1, 0) + IF(le.lname_Total_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_Total_ErrorCount > 0, 1, 0) + IF(le.appended_ssn_Total_ErrorCount > 0, 1, 0) + IF(le.address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.zip_Total_ErrorCount > 0, 1, 0) + IF(le.fips_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.personal_phone_Total_ErrorCount > 0, 1, 0) + IF(le.dob_Total_ErrorCount > 0, 1, 0) + IF(le.email_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dl_st_Total_ErrorCount > 0, 1, 0) + IF(le.dl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ipaddr_Total_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Source_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.transaction_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.datetime_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.datetime_ALLOW_ErrorCount > 0, 1, 0) + IF(le.datetime_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.full_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.full_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.appended_ssn_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.appended_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.appended_ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fips_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.personal_phone_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.personal_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.personal_phone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dob_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.email_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dl_st_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.dl_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dl_st_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ipaddr_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ipaddr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Source_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.datetime_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.datetime_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.datetime_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.ssn_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.ssn_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.ssn_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.appended_ssn_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.appended_ssn_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.appended_ssn_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.state_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.state_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.state_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.zip_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.zip_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.zip_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.personal_phone_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.personal_phone_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.personal_phone_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dob_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.dob_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dob_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dl_st_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.dl_st_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dl_st_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.ipaddr_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.ipaddr_ALLOW_WouldModifyCount > 0, 1, 0);
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT39.StrType ErrorMessage;
    SALT39.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.transaction_id_Invalid,le.datetime_Invalid,le.full_name_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.ssn_Invalid,le.appended_ssn_Invalid,le.address_Invalid,le.city_Invalid,le.state_Invalid,le.zip_Invalid,le.fips_county_Invalid,le.personal_phone_Invalid,le.dob_Invalid,le.email_address_Invalid,le.dl_st_Invalid,le.dl_Invalid,le.ipaddr_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.Source_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,InquiryLogs_Fields.InvalidMessage_transaction_id(le.transaction_id_Invalid),InquiryLogs_Fields.InvalidMessage_datetime(le.datetime_Invalid),InquiryLogs_Fields.InvalidMessage_full_name(le.full_name_Invalid),InquiryLogs_Fields.InvalidMessage_title(le.title_Invalid),InquiryLogs_Fields.InvalidMessage_fname(le.fname_Invalid),InquiryLogs_Fields.InvalidMessage_mname(le.mname_Invalid),InquiryLogs_Fields.InvalidMessage_lname(le.lname_Invalid),InquiryLogs_Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),InquiryLogs_Fields.InvalidMessage_ssn(le.ssn_Invalid),InquiryLogs_Fields.InvalidMessage_appended_ssn(le.appended_ssn_Invalid),InquiryLogs_Fields.InvalidMessage_address(le.address_Invalid),InquiryLogs_Fields.InvalidMessage_city(le.city_Invalid),InquiryLogs_Fields.InvalidMessage_state(le.state_Invalid),InquiryLogs_Fields.InvalidMessage_zip(le.zip_Invalid),InquiryLogs_Fields.InvalidMessage_fips_county(le.fips_county_Invalid),InquiryLogs_Fields.InvalidMessage_personal_phone(le.personal_phone_Invalid),InquiryLogs_Fields.InvalidMessage_dob(le.dob_Invalid),InquiryLogs_Fields.InvalidMessage_email_address(le.email_address_Invalid),InquiryLogs_Fields.InvalidMessage_dl_st(le.dl_st_Invalid),InquiryLogs_Fields.InvalidMessage_dl(le.dl_Invalid),InquiryLogs_Fields.InvalidMessage_ipaddr(le.ipaddr_Invalid),InquiryLogs_Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),InquiryLogs_Fields.InvalidMessage_geo_long(le.geo_long_Invalid),InquiryLogs_Fields.InvalidMessage_Source(le.Source_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.transaction_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.datetime_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.full_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.appended_ssn_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fips_county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.personal_phone_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.email_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dl_st_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dl_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ipaddr_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Source_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'transaction_id','datetime','full_name','title','fname','mname','lname','name_suffix','ssn','appended_ssn','address','city','state','zip','fips_county','personal_phone','dob','email_address','dl_st','dl','ipaddr','geo_lat','geo_long','Source','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_alphanumeric','invalid_date','invalid_name','invalid_alphanumeric','invalid_name','invalid_name','invalid_name','invalid_alphanumeric','invalid_ssn','invalid_ssn','invalid_alphanumeric','invalid_alphanumeric','invalid_state','invalid_zip','invalid_alphanumeric','invalid_phone','invalid_date','invalid_email','invalid_state','invalid_alphanumeric','invalid_ip','invalid_decimal','invalid_decimal','invalid_alphanumeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.transaction_id,(SALT39.StrType)le.datetime,(SALT39.StrType)le.full_name,(SALT39.StrType)le.title,(SALT39.StrType)le.fname,(SALT39.StrType)le.mname,(SALT39.StrType)le.lname,(SALT39.StrType)le.name_suffix,(SALT39.StrType)le.ssn,(SALT39.StrType)le.appended_ssn,(SALT39.StrType)le.address,(SALT39.StrType)le.city,(SALT39.StrType)le.state,(SALT39.StrType)le.zip,(SALT39.StrType)le.fips_county,(SALT39.StrType)le.personal_phone,(SALT39.StrType)le.dob,(SALT39.StrType)le.email_address,(SALT39.StrType)le.dl_st,(SALT39.StrType)le.dl,(SALT39.StrType)le.ipaddr,(SALT39.StrType)le.geo_lat,(SALT39.StrType)le.geo_long,(SALT39.StrType)le.Source,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,24,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(InquiryLogs_Layout_InquiryLogs) prevDS = DATASET([], InquiryLogs_Layout_InquiryLogs), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'transaction_id:invalid_alphanumeric:ALLOW'
          ,'datetime:invalid_date:LEFTTRIM','datetime:invalid_date:ALLOW','datetime:invalid_date:LENGTHS'
          ,'full_name:invalid_name:LEFTTRIM','full_name:invalid_name:ALLOW'
          ,'title:invalid_alphanumeric:ALLOW'
          ,'fname:invalid_name:LEFTTRIM','fname:invalid_name:ALLOW'
          ,'mname:invalid_name:LEFTTRIM','mname:invalid_name:ALLOW'
          ,'lname:invalid_name:LEFTTRIM','lname:invalid_name:ALLOW'
          ,'name_suffix:invalid_alphanumeric:ALLOW'
          ,'ssn:invalid_ssn:LEFTTRIM','ssn:invalid_ssn:ALLOW','ssn:invalid_ssn:LENGTHS'
          ,'appended_ssn:invalid_ssn:LEFTTRIM','appended_ssn:invalid_ssn:ALLOW','appended_ssn:invalid_ssn:LENGTHS'
          ,'address:invalid_alphanumeric:ALLOW'
          ,'city:invalid_alphanumeric:ALLOW'
          ,'state:invalid_state:LEFTTRIM','state:invalid_state:ALLOW','state:invalid_state:LENGTHS'
          ,'zip:invalid_zip:LEFTTRIM','zip:invalid_zip:ALLOW','zip:invalid_zip:LENGTHS'
          ,'fips_county:invalid_alphanumeric:ALLOW'
          ,'personal_phone:invalid_phone:LEFTTRIM','personal_phone:invalid_phone:ALLOW','personal_phone:invalid_phone:LENGTHS'
          ,'dob:invalid_date:LEFTTRIM','dob:invalid_date:ALLOW','dob:invalid_date:LENGTHS'
          ,'email_address:invalid_email:ALLOW'
          ,'dl_st:invalid_state:LEFTTRIM','dl_st:invalid_state:ALLOW','dl_st:invalid_state:LENGTHS'
          ,'dl:invalid_alphanumeric:ALLOW'
          ,'ipaddr:invalid_ip:LEFTTRIM','ipaddr:invalid_ip:ALLOW'
          ,'geo_lat:invalid_decimal:ALLOW'
          ,'geo_long:invalid_decimal:ALLOW'
          ,'Source:invalid_alphanumeric:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY'
          ,'record:Number_Edited_Records:SUMMARY'
          ,'rule:Number_Edited_Rules:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,InquiryLogs_Fields.InvalidMessage_transaction_id(1)
          ,InquiryLogs_Fields.InvalidMessage_datetime(1),InquiryLogs_Fields.InvalidMessage_datetime(2),InquiryLogs_Fields.InvalidMessage_datetime(3)
          ,InquiryLogs_Fields.InvalidMessage_full_name(1),InquiryLogs_Fields.InvalidMessage_full_name(2)
          ,InquiryLogs_Fields.InvalidMessage_title(1)
          ,InquiryLogs_Fields.InvalidMessage_fname(1),InquiryLogs_Fields.InvalidMessage_fname(2)
          ,InquiryLogs_Fields.InvalidMessage_mname(1),InquiryLogs_Fields.InvalidMessage_mname(2)
          ,InquiryLogs_Fields.InvalidMessage_lname(1),InquiryLogs_Fields.InvalidMessage_lname(2)
          ,InquiryLogs_Fields.InvalidMessage_name_suffix(1)
          ,InquiryLogs_Fields.InvalidMessage_ssn(1),InquiryLogs_Fields.InvalidMessage_ssn(2),InquiryLogs_Fields.InvalidMessage_ssn(3)
          ,InquiryLogs_Fields.InvalidMessage_appended_ssn(1),InquiryLogs_Fields.InvalidMessage_appended_ssn(2),InquiryLogs_Fields.InvalidMessage_appended_ssn(3)
          ,InquiryLogs_Fields.InvalidMessage_address(1)
          ,InquiryLogs_Fields.InvalidMessage_city(1)
          ,InquiryLogs_Fields.InvalidMessage_state(1),InquiryLogs_Fields.InvalidMessage_state(2),InquiryLogs_Fields.InvalidMessage_state(3)
          ,InquiryLogs_Fields.InvalidMessage_zip(1),InquiryLogs_Fields.InvalidMessage_zip(2),InquiryLogs_Fields.InvalidMessage_zip(3)
          ,InquiryLogs_Fields.InvalidMessage_fips_county(1)
          ,InquiryLogs_Fields.InvalidMessage_personal_phone(1),InquiryLogs_Fields.InvalidMessage_personal_phone(2),InquiryLogs_Fields.InvalidMessage_personal_phone(3)
          ,InquiryLogs_Fields.InvalidMessage_dob(1),InquiryLogs_Fields.InvalidMessage_dob(2),InquiryLogs_Fields.InvalidMessage_dob(3)
          ,InquiryLogs_Fields.InvalidMessage_email_address(1)
          ,InquiryLogs_Fields.InvalidMessage_dl_st(1),InquiryLogs_Fields.InvalidMessage_dl_st(2),InquiryLogs_Fields.InvalidMessage_dl_st(3)
          ,InquiryLogs_Fields.InvalidMessage_dl(1)
          ,InquiryLogs_Fields.InvalidMessage_ipaddr(1),InquiryLogs_Fields.InvalidMessage_ipaddr(2)
          ,InquiryLogs_Fields.InvalidMessage_geo_lat(1)
          ,InquiryLogs_Fields.InvalidMessage_geo_long(1)
          ,InquiryLogs_Fields.InvalidMessage_Source(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors'
          ,'Edited records'
          ,'Rules leading to edits','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.transaction_id_ALLOW_ErrorCount
          ,le.datetime_LEFTTRIM_ErrorCount,le.datetime_ALLOW_ErrorCount,le.datetime_LENGTHS_ErrorCount
          ,le.full_name_LEFTTRIM_ErrorCount,le.full_name_ALLOW_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.ssn_LEFTTRIM_ErrorCount,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTHS_ErrorCount
          ,le.appended_ssn_LEFTTRIM_ErrorCount,le.appended_ssn_ALLOW_ErrorCount,le.appended_ssn_LENGTHS_ErrorCount
          ,le.address_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.fips_county_ALLOW_ErrorCount
          ,le.personal_phone_LEFTTRIM_ErrorCount,le.personal_phone_ALLOW_ErrorCount,le.personal_phone_LENGTHS_ErrorCount
          ,le.dob_LEFTTRIM_ErrorCount,le.dob_ALLOW_ErrorCount,le.dob_LENGTHS_ErrorCount
          ,le.email_address_ALLOW_ErrorCount
          ,le.dl_st_LEFTTRIM_ErrorCount,le.dl_st_ALLOW_ErrorCount,le.dl_st_LENGTHS_ErrorCount
          ,le.dl_ALLOW_ErrorCount
          ,le.ipaddr_LEFTTRIM_ErrorCount,le.ipaddr_ALLOW_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.Source_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount
          ,le.AnyRule_WithEditsCount
          ,le.Rules_WithEdits,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.transaction_id_ALLOW_ErrorCount
          ,le.datetime_LEFTTRIM_ErrorCount,le.datetime_ALLOW_ErrorCount,le.datetime_LENGTHS_ErrorCount
          ,le.full_name_LEFTTRIM_ErrorCount,le.full_name_ALLOW_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.ssn_LEFTTRIM_ErrorCount,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTHS_ErrorCount
          ,le.appended_ssn_LEFTTRIM_ErrorCount,le.appended_ssn_ALLOW_ErrorCount,le.appended_ssn_LENGTHS_ErrorCount
          ,le.address_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.fips_county_ALLOW_ErrorCount
          ,le.personal_phone_LEFTTRIM_ErrorCount,le.personal_phone_ALLOW_ErrorCount,le.personal_phone_LENGTHS_ErrorCount
          ,le.dob_LEFTTRIM_ErrorCount,le.dob_ALLOW_ErrorCount,le.dob_LENGTHS_ErrorCount
          ,le.email_address_ALLOW_ErrorCount
          ,le.dl_st_LEFTTRIM_ErrorCount,le.dl_st_ALLOW_ErrorCount,le.dl_st_LENGTHS_ErrorCount
          ,le.dl_ALLOW_ErrorCount
          ,le.ipaddr_LEFTTRIM_ErrorCount,le.ipaddr_ALLOW_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.Source_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithEditsCount/SELF.recordstotal * 100)
          ,IF(NumRulesWithPossibleEdits = 0, 0, le.Rules_WithEdits/NumRulesWithPossibleEdits * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 9,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT39.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT39.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := InquiryLogs_hygiene(PROJECT(h, InquiryLogs_Layout_InquiryLogs));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT39.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'transaction_id:' + getFieldTypeText(h.transaction_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'datetime:' + getFieldTypeText(h.datetime) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'full_name:' + getFieldTypeText(h.full_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn:' + getFieldTypeText(h.ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'appended_ssn:' + getFieldTypeText(h.appended_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address:' + getFieldTypeText(h.address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'personal_phone:' + getFieldTypeText(h.personal_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email_address:' + getFieldTypeText(h.email_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dl_st:' + getFieldTypeText(h.dl_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dl:' + getFieldTypeText(h.dl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ipaddr:' + getFieldTypeText(h.ipaddr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Source:' + getFieldTypeText(h.Source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_transaction_id_cnt
          ,le.populated_datetime_cnt
          ,le.populated_full_name_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_ssn_cnt
          ,le.populated_appended_ssn_cnt
          ,le.populated_address_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_personal_phone_cnt
          ,le.populated_dob_cnt
          ,le.populated_email_address_cnt
          ,le.populated_dl_st_cnt
          ,le.populated_dl_cnt
          ,le.populated_ipaddr_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_Source_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_transaction_id_pcnt
          ,le.populated_datetime_pcnt
          ,le.populated_full_name_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_ssn_pcnt
          ,le.populated_appended_ssn_pcnt
          ,le.populated_address_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_personal_phone_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_email_address_pcnt
          ,le.populated_dl_st_pcnt
          ,le.populated_dl_pcnt
          ,le.populated_ipaddr_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_Source_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,24,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT39.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := InquiryLogs_Delta(prevDS, PROJECT(h, InquiryLogs_Layout_InquiryLogs));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),24,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(InquiryLogs_Layout_InquiryLogs) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_FraudGov, InquiryLogs_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT39.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT39.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;

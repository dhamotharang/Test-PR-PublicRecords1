IMPORT SALT311,STD;
IMPORT Scrubs_SKA; // Import modules for FieldTypes attribute definitions
EXPORT Base_Nixie_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 32;
  EXPORT NumRulesFromFieldType := 32;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 32;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_Nixie_Layout_SKA)
    UNSIGNED1 id_ska_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 t1_Invalid;
    UNSIGNED1 dept_code_Invalid;
    UNSIGNED1 dept_expl_Invalid;
    UNSIGNED1 spec_Invalid;
    UNSIGNED1 spec_expl_Invalid;
    UNSIGNED1 company1_Invalid;
    UNSIGNED1 address1_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 area_code_Invalid;
    UNSIGNED1 number_Invalid;
    UNSIGNED1 persid_Invalid;
    UNSIGNED1 nixie_date_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 mail_predir_Invalid;
    UNSIGNED1 mail_prim_name_Invalid;
    UNSIGNED1 mail_postdir_Invalid;
    UNSIGNED1 mail_p_city_name_Invalid;
    UNSIGNED1 mail_v_city_name_Invalid;
    UNSIGNED1 mail_st_Invalid;
    UNSIGNED1 mail_zip_Invalid;
    UNSIGNED1 mail_zip4_Invalid;
    UNSIGNED1 mail_ace_fips_state_Invalid;
    UNSIGNED1 mail_geo_lat_Invalid;
    UNSIGNED1 mail_geo_long_Invalid;
    UNSIGNED1 source_rec_id_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Nixie_Layout_SKA)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_Nixie_Layout_SKA) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.id_ska_Invalid := Base_Nixie_Fields.InValid_id_ska((SALT311.StrType)le.id_ska);
    SELF.bdid_Invalid := Base_Nixie_Fields.InValid_bdid((SALT311.StrType)le.bdid);
    SELF.first_name_Invalid := Base_Nixie_Fields.InValid_first_name((SALT311.StrType)le.first_name);
    SELF.last_name_Invalid := Base_Nixie_Fields.InValid_last_name((SALT311.StrType)le.last_name);
    SELF.t1_Invalid := Base_Nixie_Fields.InValid_t1((SALT311.StrType)le.t1);
    SELF.dept_code_Invalid := Base_Nixie_Fields.InValid_dept_code((SALT311.StrType)le.dept_code);
    SELF.dept_expl_Invalid := Base_Nixie_Fields.InValid_dept_expl((SALT311.StrType)le.dept_expl,(SALT311.StrType)le.dept_code);
    SELF.spec_Invalid := Base_Nixie_Fields.InValid_spec((SALT311.StrType)le.spec);
    SELF.spec_expl_Invalid := Base_Nixie_Fields.InValid_spec_expl((SALT311.StrType)le.spec_expl,(SALT311.StrType)le.spec);
    SELF.company1_Invalid := Base_Nixie_Fields.InValid_company1((SALT311.StrType)le.company1);
    SELF.address1_Invalid := Base_Nixie_Fields.InValid_address1((SALT311.StrType)le.address1);
    SELF.city_Invalid := Base_Nixie_Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_Invalid := Base_Nixie_Fields.InValid_state((SALT311.StrType)le.state);
    SELF.zip_Invalid := Base_Nixie_Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.area_code_Invalid := Base_Nixie_Fields.InValid_area_code((SALT311.StrType)le.area_code);
    SELF.number_Invalid := Base_Nixie_Fields.InValid_number((SALT311.StrType)le.number);
    SELF.persid_Invalid := Base_Nixie_Fields.InValid_persid((SALT311.StrType)le.persid);
    SELF.nixie_date_Invalid := Base_Nixie_Fields.InValid_nixie_date((SALT311.StrType)le.nixie_date);
    SELF.fname_Invalid := Base_Nixie_Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.lname_Invalid := Base_Nixie_Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.mail_predir_Invalid := Base_Nixie_Fields.InValid_mail_predir((SALT311.StrType)le.mail_predir);
    SELF.mail_prim_name_Invalid := Base_Nixie_Fields.InValid_mail_prim_name((SALT311.StrType)le.mail_prim_name);
    SELF.mail_postdir_Invalid := Base_Nixie_Fields.InValid_mail_postdir((SALT311.StrType)le.mail_postdir);
    SELF.mail_p_city_name_Invalid := Base_Nixie_Fields.InValid_mail_p_city_name((SALT311.StrType)le.mail_p_city_name,(SALT311.StrType)le.mail_v_city_name);
    SELF.mail_v_city_name_Invalid := Base_Nixie_Fields.InValid_mail_v_city_name((SALT311.StrType)le.mail_v_city_name,(SALT311.StrType)le.mail_p_city_name);
    SELF.mail_st_Invalid := Base_Nixie_Fields.InValid_mail_st((SALT311.StrType)le.mail_st);
    SELF.mail_zip_Invalid := Base_Nixie_Fields.InValid_mail_zip((SALT311.StrType)le.mail_zip);
    SELF.mail_zip4_Invalid := Base_Nixie_Fields.InValid_mail_zip4((SALT311.StrType)le.mail_zip4);
    SELF.mail_ace_fips_state_Invalid := Base_Nixie_Fields.InValid_mail_ace_fips_state((SALT311.StrType)le.mail_ace_fips_state);
    SELF.mail_geo_lat_Invalid := Base_Nixie_Fields.InValid_mail_geo_lat((SALT311.StrType)le.mail_geo_lat);
    SELF.mail_geo_long_Invalid := Base_Nixie_Fields.InValid_mail_geo_long((SALT311.StrType)le.mail_geo_long);
    SELF.source_rec_id_Invalid := Base_Nixie_Fields.InValid_source_rec_id((SALT311.StrType)le.source_rec_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Nixie_Layout_SKA);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.id_ska_Invalid << 0 ) + ( le.bdid_Invalid << 1 ) + ( le.first_name_Invalid << 2 ) + ( le.last_name_Invalid << 3 ) + ( le.t1_Invalid << 4 ) + ( le.dept_code_Invalid << 5 ) + ( le.dept_expl_Invalid << 6 ) + ( le.spec_Invalid << 7 ) + ( le.spec_expl_Invalid << 8 ) + ( le.company1_Invalid << 9 ) + ( le.address1_Invalid << 10 ) + ( le.city_Invalid << 11 ) + ( le.state_Invalid << 12 ) + ( le.zip_Invalid << 13 ) + ( le.area_code_Invalid << 14 ) + ( le.number_Invalid << 15 ) + ( le.persid_Invalid << 16 ) + ( le.nixie_date_Invalid << 17 ) + ( le.fname_Invalid << 18 ) + ( le.lname_Invalid << 19 ) + ( le.mail_predir_Invalid << 20 ) + ( le.mail_prim_name_Invalid << 21 ) + ( le.mail_postdir_Invalid << 22 ) + ( le.mail_p_city_name_Invalid << 23 ) + ( le.mail_v_city_name_Invalid << 24 ) + ( le.mail_st_Invalid << 25 ) + ( le.mail_zip_Invalid << 26 ) + ( le.mail_zip4_Invalid << 27 ) + ( le.mail_ace_fips_state_Invalid << 28 ) + ( le.mail_geo_lat_Invalid << 29 ) + ( le.mail_geo_long_Invalid << 30 ) + ( le.source_rec_id_Invalid << 31 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Nixie_Layout_SKA);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.id_ska_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.t1_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.dept_code_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.dept_expl_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.spec_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.spec_expl_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.company1_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.address1_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.area_code_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.number_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.persid_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.nixie_date_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.mail_predir_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.mail_prim_name_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.mail_postdir_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.mail_p_city_name_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.mail_v_city_name_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.mail_st_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.mail_zip_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.mail_zip4_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.mail_ace_fips_state_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.mail_geo_lat_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.mail_geo_long_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.source_rec_id_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    id_ska_CUSTOM_ErrorCount := COUNT(GROUP,h.id_ska_Invalid=1);
    bdid_CUSTOM_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    first_name_CUSTOM_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    last_name_CUSTOM_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    t1_CUSTOM_ErrorCount := COUNT(GROUP,h.t1_Invalid=1);
    dept_code_CUSTOM_ErrorCount := COUNT(GROUP,h.dept_code_Invalid=1);
    dept_expl_CUSTOM_ErrorCount := COUNT(GROUP,h.dept_expl_Invalid=1);
    spec_CUSTOM_ErrorCount := COUNT(GROUP,h.spec_Invalid=1);
    spec_expl_CUSTOM_ErrorCount := COUNT(GROUP,h.spec_expl_Invalid=1);
    company1_CUSTOM_ErrorCount := COUNT(GROUP,h.company1_Invalid=1);
    address1_CUSTOM_ErrorCount := COUNT(GROUP,h.address1_Invalid=1);
    city_CUSTOM_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zip_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    area_code_CUSTOM_ErrorCount := COUNT(GROUP,h.area_code_Invalid=1);
    number_CUSTOM_ErrorCount := COUNT(GROUP,h.number_Invalid=1);
    persid_CUSTOM_ErrorCount := COUNT(GROUP,h.persid_Invalid=1);
    nixie_date_CUSTOM_ErrorCount := COUNT(GROUP,h.nixie_date_Invalid=1);
    fname_CUSTOM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    lname_CUSTOM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    mail_predir_ALLOW_ErrorCount := COUNT(GROUP,h.mail_predir_Invalid=1);
    mail_prim_name_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_prim_name_Invalid=1);
    mail_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.mail_postdir_Invalid=1);
    mail_p_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_p_city_name_Invalid=1);
    mail_v_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_v_city_name_Invalid=1);
    mail_st_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_st_Invalid=1);
    mail_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_zip_Invalid=1);
    mail_zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_zip4_Invalid=1);
    mail_ace_fips_state_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_ace_fips_state_Invalid=1);
    mail_geo_lat_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_geo_lat_Invalid=1);
    mail_geo_long_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_geo_long_Invalid=1);
    source_rec_id_CUSTOM_ErrorCount := COUNT(GROUP,h.source_rec_id_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.id_ska_Invalid > 0 OR h.bdid_Invalid > 0 OR h.first_name_Invalid > 0 OR h.last_name_Invalid > 0 OR h.t1_Invalid > 0 OR h.dept_code_Invalid > 0 OR h.dept_expl_Invalid > 0 OR h.spec_Invalid > 0 OR h.spec_expl_Invalid > 0 OR h.company1_Invalid > 0 OR h.address1_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zip_Invalid > 0 OR h.area_code_Invalid > 0 OR h.number_Invalid > 0 OR h.persid_Invalid > 0 OR h.nixie_date_Invalid > 0 OR h.fname_Invalid > 0 OR h.lname_Invalid > 0 OR h.mail_predir_Invalid > 0 OR h.mail_prim_name_Invalid > 0 OR h.mail_postdir_Invalid > 0 OR h.mail_p_city_name_Invalid > 0 OR h.mail_v_city_name_Invalid > 0 OR h.mail_st_Invalid > 0 OR h.mail_zip_Invalid > 0 OR h.mail_zip4_Invalid > 0 OR h.mail_ace_fips_state_Invalid > 0 OR h.mail_geo_lat_Invalid > 0 OR h.mail_geo_long_Invalid > 0 OR h.source_rec_id_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.id_ska_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.t1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dept_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dept_expl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spec_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spec_expl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.area_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.persid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.nixie_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_ace_fips_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.id_ska_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.t1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dept_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dept_expl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spec_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spec_expl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.area_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.persid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.nixie_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_ace_fips_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_CUSTOM_ErrorCount > 0, 1, 0);
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
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.id_ska_Invalid,le.bdid_Invalid,le.first_name_Invalid,le.last_name_Invalid,le.t1_Invalid,le.dept_code_Invalid,le.dept_expl_Invalid,le.spec_Invalid,le.spec_expl_Invalid,le.company1_Invalid,le.address1_Invalid,le.city_Invalid,le.state_Invalid,le.zip_Invalid,le.area_code_Invalid,le.number_Invalid,le.persid_Invalid,le.nixie_date_Invalid,le.fname_Invalid,le.lname_Invalid,le.mail_predir_Invalid,le.mail_prim_name_Invalid,le.mail_postdir_Invalid,le.mail_p_city_name_Invalid,le.mail_v_city_name_Invalid,le.mail_st_Invalid,le.mail_zip_Invalid,le.mail_zip4_Invalid,le.mail_ace_fips_state_Invalid,le.mail_geo_lat_Invalid,le.mail_geo_long_Invalid,le.source_rec_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Nixie_Fields.InvalidMessage_id_ska(le.id_ska_Invalid),Base_Nixie_Fields.InvalidMessage_bdid(le.bdid_Invalid),Base_Nixie_Fields.InvalidMessage_first_name(le.first_name_Invalid),Base_Nixie_Fields.InvalidMessage_last_name(le.last_name_Invalid),Base_Nixie_Fields.InvalidMessage_t1(le.t1_Invalid),Base_Nixie_Fields.InvalidMessage_dept_code(le.dept_code_Invalid),Base_Nixie_Fields.InvalidMessage_dept_expl(le.dept_expl_Invalid),Base_Nixie_Fields.InvalidMessage_spec(le.spec_Invalid),Base_Nixie_Fields.InvalidMessage_spec_expl(le.spec_expl_Invalid),Base_Nixie_Fields.InvalidMessage_company1(le.company1_Invalid),Base_Nixie_Fields.InvalidMessage_address1(le.address1_Invalid),Base_Nixie_Fields.InvalidMessage_city(le.city_Invalid),Base_Nixie_Fields.InvalidMessage_state(le.state_Invalid),Base_Nixie_Fields.InvalidMessage_zip(le.zip_Invalid),Base_Nixie_Fields.InvalidMessage_area_code(le.area_code_Invalid),Base_Nixie_Fields.InvalidMessage_number(le.number_Invalid),Base_Nixie_Fields.InvalidMessage_persid(le.persid_Invalid),Base_Nixie_Fields.InvalidMessage_nixie_date(le.nixie_date_Invalid),Base_Nixie_Fields.InvalidMessage_fname(le.fname_Invalid),Base_Nixie_Fields.InvalidMessage_lname(le.lname_Invalid),Base_Nixie_Fields.InvalidMessage_mail_predir(le.mail_predir_Invalid),Base_Nixie_Fields.InvalidMessage_mail_prim_name(le.mail_prim_name_Invalid),Base_Nixie_Fields.InvalidMessage_mail_postdir(le.mail_postdir_Invalid),Base_Nixie_Fields.InvalidMessage_mail_p_city_name(le.mail_p_city_name_Invalid),Base_Nixie_Fields.InvalidMessage_mail_v_city_name(le.mail_v_city_name_Invalid),Base_Nixie_Fields.InvalidMessage_mail_st(le.mail_st_Invalid),Base_Nixie_Fields.InvalidMessage_mail_zip(le.mail_zip_Invalid),Base_Nixie_Fields.InvalidMessage_mail_zip4(le.mail_zip4_Invalid),Base_Nixie_Fields.InvalidMessage_mail_ace_fips_state(le.mail_ace_fips_state_Invalid),Base_Nixie_Fields.InvalidMessage_mail_geo_lat(le.mail_geo_lat_Invalid),Base_Nixie_Fields.InvalidMessage_mail_geo_long(le.mail_geo_long_Invalid),Base_Nixie_Fields.InvalidMessage_source_rec_id(le.source_rec_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.id_ska_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.t1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dept_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dept_expl_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spec_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spec_expl_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.area_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.persid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.nixie_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_prim_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_p_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_v_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_ace_fips_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_geo_lat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_geo_long_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.source_rec_id_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'id_ska','bdid','first_name','last_name','t1','dept_code','dept_expl','spec','spec_expl','company1','address1','city','state','zip','area_code','number','persid','nixie_date','fname','lname','mail_predir','mail_prim_name','mail_postdir','mail_p_city_name','mail_v_city_name','mail_st','mail_zip','mail_zip4','mail_ace_fips_state','mail_geo_lat','mail_geo_long','source_rec_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_numeric','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_dept_code','invalid_dept_expl','invalid_spec','invalid_spec_expl','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip','invalid_area_code','invalid_number','invalid_numeric','invalid_pastdate8','invalid_mandatory','invalid_mandatory','invalid_direction','invalid_mandatory','invalid_direction','invalid_mail_p_city_name','invalid_mail_v_city_name','invalid_mail_st','invalid_mail_zip','invalid_mail_zip4','invalid_mail_ace_fips_state','invalid_geo_coord','invalid_geo_coord','invalid_numeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.id_ska,(SALT311.StrType)le.bdid,(SALT311.StrType)le.first_name,(SALT311.StrType)le.last_name,(SALT311.StrType)le.t1,(SALT311.StrType)le.dept_code,(SALT311.StrType)le.dept_expl,(SALT311.StrType)le.spec,(SALT311.StrType)le.spec_expl,(SALT311.StrType)le.company1,(SALT311.StrType)le.address1,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.zip,(SALT311.StrType)le.area_code,(SALT311.StrType)le.number,(SALT311.StrType)le.persid,(SALT311.StrType)le.nixie_date,(SALT311.StrType)le.fname,(SALT311.StrType)le.lname,(SALT311.StrType)le.mail_predir,(SALT311.StrType)le.mail_prim_name,(SALT311.StrType)le.mail_postdir,(SALT311.StrType)le.mail_p_city_name,(SALT311.StrType)le.mail_v_city_name,(SALT311.StrType)le.mail_st,(SALT311.StrType)le.mail_zip,(SALT311.StrType)le.mail_zip4,(SALT311.StrType)le.mail_ace_fips_state,(SALT311.StrType)le.mail_geo_lat,(SALT311.StrType)le.mail_geo_long,(SALT311.StrType)le.source_rec_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,32,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_Nixie_Layout_SKA) prevDS = DATASET([], Base_Nixie_Layout_SKA), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'id_ska:invalid_numeric:CUSTOM'
          ,'bdid:invalid_numeric:CUSTOM'
          ,'first_name:invalid_mandatory:CUSTOM'
          ,'last_name:invalid_mandatory:CUSTOM'
          ,'t1:invalid_mandatory:CUSTOM'
          ,'dept_code:invalid_dept_code:CUSTOM'
          ,'dept_expl:invalid_dept_expl:CUSTOM'
          ,'spec:invalid_spec:CUSTOM'
          ,'spec_expl:invalid_spec_expl:CUSTOM'
          ,'company1:invalid_mandatory:CUSTOM'
          ,'address1:invalid_mandatory:CUSTOM'
          ,'city:invalid_mandatory:CUSTOM'
          ,'state:invalid_state:CUSTOM'
          ,'zip:invalid_zip:CUSTOM'
          ,'area_code:invalid_area_code:CUSTOM'
          ,'number:invalid_number:CUSTOM'
          ,'persid:invalid_numeric:CUSTOM'
          ,'nixie_date:invalid_pastdate8:CUSTOM'
          ,'fname:invalid_mandatory:CUSTOM'
          ,'lname:invalid_mandatory:CUSTOM'
          ,'mail_predir:invalid_direction:ALLOW'
          ,'mail_prim_name:invalid_mandatory:CUSTOM'
          ,'mail_postdir:invalid_direction:ALLOW'
          ,'mail_p_city_name:invalid_mail_p_city_name:CUSTOM'
          ,'mail_v_city_name:invalid_mail_v_city_name:CUSTOM'
          ,'mail_st:invalid_mail_st:CUSTOM'
          ,'mail_zip:invalid_mail_zip:CUSTOM'
          ,'mail_zip4:invalid_mail_zip4:CUSTOM'
          ,'mail_ace_fips_state:invalid_mail_ace_fips_state:CUSTOM'
          ,'mail_geo_lat:invalid_geo_coord:CUSTOM'
          ,'mail_geo_long:invalid_geo_coord:CUSTOM'
          ,'source_rec_id:invalid_numeric:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Nixie_Fields.InvalidMessage_id_ska(1)
          ,Base_Nixie_Fields.InvalidMessage_bdid(1)
          ,Base_Nixie_Fields.InvalidMessage_first_name(1)
          ,Base_Nixie_Fields.InvalidMessage_last_name(1)
          ,Base_Nixie_Fields.InvalidMessage_t1(1)
          ,Base_Nixie_Fields.InvalidMessage_dept_code(1)
          ,Base_Nixie_Fields.InvalidMessage_dept_expl(1)
          ,Base_Nixie_Fields.InvalidMessage_spec(1)
          ,Base_Nixie_Fields.InvalidMessage_spec_expl(1)
          ,Base_Nixie_Fields.InvalidMessage_company1(1)
          ,Base_Nixie_Fields.InvalidMessage_address1(1)
          ,Base_Nixie_Fields.InvalidMessage_city(1)
          ,Base_Nixie_Fields.InvalidMessage_state(1)
          ,Base_Nixie_Fields.InvalidMessage_zip(1)
          ,Base_Nixie_Fields.InvalidMessage_area_code(1)
          ,Base_Nixie_Fields.InvalidMessage_number(1)
          ,Base_Nixie_Fields.InvalidMessage_persid(1)
          ,Base_Nixie_Fields.InvalidMessage_nixie_date(1)
          ,Base_Nixie_Fields.InvalidMessage_fname(1)
          ,Base_Nixie_Fields.InvalidMessage_lname(1)
          ,Base_Nixie_Fields.InvalidMessage_mail_predir(1)
          ,Base_Nixie_Fields.InvalidMessage_mail_prim_name(1)
          ,Base_Nixie_Fields.InvalidMessage_mail_postdir(1)
          ,Base_Nixie_Fields.InvalidMessage_mail_p_city_name(1)
          ,Base_Nixie_Fields.InvalidMessage_mail_v_city_name(1)
          ,Base_Nixie_Fields.InvalidMessage_mail_st(1)
          ,Base_Nixie_Fields.InvalidMessage_mail_zip(1)
          ,Base_Nixie_Fields.InvalidMessage_mail_zip4(1)
          ,Base_Nixie_Fields.InvalidMessage_mail_ace_fips_state(1)
          ,Base_Nixie_Fields.InvalidMessage_mail_geo_lat(1)
          ,Base_Nixie_Fields.InvalidMessage_mail_geo_long(1)
          ,Base_Nixie_Fields.InvalidMessage_source_rec_id(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.id_ska_CUSTOM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.first_name_CUSTOM_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.t1_CUSTOM_ErrorCount
          ,le.dept_code_CUSTOM_ErrorCount
          ,le.dept_expl_CUSTOM_ErrorCount
          ,le.spec_CUSTOM_ErrorCount
          ,le.spec_expl_CUSTOM_ErrorCount
          ,le.company1_CUSTOM_ErrorCount
          ,le.address1_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.area_code_CUSTOM_ErrorCount
          ,le.number_CUSTOM_ErrorCount
          ,le.persid_CUSTOM_ErrorCount
          ,le.nixie_date_CUSTOM_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.mail_predir_ALLOW_ErrorCount
          ,le.mail_prim_name_CUSTOM_ErrorCount
          ,le.mail_postdir_ALLOW_ErrorCount
          ,le.mail_p_city_name_CUSTOM_ErrorCount
          ,le.mail_v_city_name_CUSTOM_ErrorCount
          ,le.mail_st_CUSTOM_ErrorCount
          ,le.mail_zip_CUSTOM_ErrorCount
          ,le.mail_zip4_CUSTOM_ErrorCount
          ,le.mail_ace_fips_state_CUSTOM_ErrorCount
          ,le.mail_geo_lat_CUSTOM_ErrorCount
          ,le.mail_geo_long_CUSTOM_ErrorCount
          ,le.source_rec_id_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.id_ska_CUSTOM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.first_name_CUSTOM_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.t1_CUSTOM_ErrorCount
          ,le.dept_code_CUSTOM_ErrorCount
          ,le.dept_expl_CUSTOM_ErrorCount
          ,le.spec_CUSTOM_ErrorCount
          ,le.spec_expl_CUSTOM_ErrorCount
          ,le.company1_CUSTOM_ErrorCount
          ,le.address1_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.area_code_CUSTOM_ErrorCount
          ,le.number_CUSTOM_ErrorCount
          ,le.persid_CUSTOM_ErrorCount
          ,le.nixie_date_CUSTOM_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.mail_predir_ALLOW_ErrorCount
          ,le.mail_prim_name_CUSTOM_ErrorCount
          ,le.mail_postdir_ALLOW_ErrorCount
          ,le.mail_p_city_name_CUSTOM_ErrorCount
          ,le.mail_v_city_name_CUSTOM_ErrorCount
          ,le.mail_st_CUSTOM_ErrorCount
          ,le.mail_zip_CUSTOM_ErrorCount
          ,le.mail_zip4_CUSTOM_ErrorCount
          ,le.mail_ace_fips_state_CUSTOM_ErrorCount
          ,le.mail_geo_lat_CUSTOM_ErrorCount
          ,le.mail_geo_long_CUSTOM_ErrorCount
          ,le.source_rec_id_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Base_Nixie_hygiene(PROJECT(h, Base_Nixie_Layout_SKA));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'id_ska:' + getFieldTypeText(h.id_ska) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ttl:' + getFieldTypeText(h.ttl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_name:' + getFieldTypeText(h.first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'middle:' + getFieldTypeText(h.middle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_name:' + getFieldTypeText(h.last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'t1:' + getFieldTypeText(h.t1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dept_code:' + getFieldTypeText(h.dept_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dept_expl:' + getFieldTypeText(h.dept_expl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spec:' + getFieldTypeText(h.spec) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spec_expl:' + getFieldTypeText(h.spec_expl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dept_file:' + getFieldTypeText(h.dept_file) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company1:' + getFieldTypeText(h.company1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address1:' + getFieldTypeText(h.address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'area_code:' + getFieldTypeText(h.area_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'number:' + getFieldTypeText(h.number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'persid:' + getFieldTypeText(h.persid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nixie_date:' + getFieldTypeText(h.nixie_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_score:' + getFieldTypeText(h.name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_prim_range:' + getFieldTypeText(h.mail_prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_predir:' + getFieldTypeText(h.mail_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_prim_name:' + getFieldTypeText(h.mail_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_addr_suffix:' + getFieldTypeText(h.mail_addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_postdir:' + getFieldTypeText(h.mail_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_unit_desig:' + getFieldTypeText(h.mail_unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_sec_range:' + getFieldTypeText(h.mail_sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_p_city_name:' + getFieldTypeText(h.mail_p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_v_city_name:' + getFieldTypeText(h.mail_v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_st:' + getFieldTypeText(h.mail_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_zip:' + getFieldTypeText(h.mail_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_zip4:' + getFieldTypeText(h.mail_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_cart:' + getFieldTypeText(h.mail_cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_cr_sort_sz:' + getFieldTypeText(h.mail_cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_lot:' + getFieldTypeText(h.mail_lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_lot_order:' + getFieldTypeText(h.mail_lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_dbpc:' + getFieldTypeText(h.mail_dbpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_chk_digit:' + getFieldTypeText(h.mail_chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_rec_type:' + getFieldTypeText(h.mail_rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_ace_fips_state:' + getFieldTypeText(h.mail_ace_fips_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_county:' + getFieldTypeText(h.mail_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_geo_lat:' + getFieldTypeText(h.mail_geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_geo_long:' + getFieldTypeText(h.mail_geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_msa:' + getFieldTypeText(h.mail_msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_geo_blk:' + getFieldTypeText(h.mail_geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_geo_match:' + getFieldTypeText(h.mail_geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_err_stat:' + getFieldTypeText(h.mail_err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotid:' + getFieldTypeText(h.dotid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotscore:' + getFieldTypeText(h.dotscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotweight:' + getFieldTypeText(h.dotweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empid:' + getFieldTypeText(h.empid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empscore:' + getFieldTypeText(h.empscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empweight:' + getFieldTypeText(h.empweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powid:' + getFieldTypeText(h.powid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powscore:' + getFieldTypeText(h.powscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powweight:' + getFieldTypeText(h.powweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxid:' + getFieldTypeText(h.proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxscore:' + getFieldTypeText(h.proxscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxweight:' + getFieldTypeText(h.proxweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleid:' + getFieldTypeText(h.seleid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'selescore:' + getFieldTypeText(h.selescore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleweight:' + getFieldTypeText(h.seleweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid:' + getFieldTypeText(h.orgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgscore:' + getFieldTypeText(h.orgscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgweight:' + getFieldTypeText(h.orgweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultid:' + getFieldTypeText(h.ultid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultscore:' + getFieldTypeText(h.ultscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultweight:' + getFieldTypeText(h.ultweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_rec_id:' + getFieldTypeText(h.source_rec_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_id_ska_cnt
          ,le.populated_bdid_cnt
          ,le.populated_ttl_cnt
          ,le.populated_first_name_cnt
          ,le.populated_middle_cnt
          ,le.populated_last_name_cnt
          ,le.populated_t1_cnt
          ,le.populated_dept_code_cnt
          ,le.populated_dept_expl_cnt
          ,le.populated_spec_cnt
          ,le.populated_spec_expl_cnt
          ,le.populated_dept_file_cnt
          ,le.populated_company1_cnt
          ,le.populated_address1_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_cnt
          ,le.populated_area_code_cnt
          ,le.populated_number_cnt
          ,le.populated_persid_cnt
          ,le.populated_nixie_date_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_name_score_cnt
          ,le.populated_mail_prim_range_cnt
          ,le.populated_mail_predir_cnt
          ,le.populated_mail_prim_name_cnt
          ,le.populated_mail_addr_suffix_cnt
          ,le.populated_mail_postdir_cnt
          ,le.populated_mail_unit_desig_cnt
          ,le.populated_mail_sec_range_cnt
          ,le.populated_mail_p_city_name_cnt
          ,le.populated_mail_v_city_name_cnt
          ,le.populated_mail_st_cnt
          ,le.populated_mail_zip_cnt
          ,le.populated_mail_zip4_cnt
          ,le.populated_mail_cart_cnt
          ,le.populated_mail_cr_sort_sz_cnt
          ,le.populated_mail_lot_cnt
          ,le.populated_mail_lot_order_cnt
          ,le.populated_mail_dbpc_cnt
          ,le.populated_mail_chk_digit_cnt
          ,le.populated_mail_rec_type_cnt
          ,le.populated_mail_ace_fips_state_cnt
          ,le.populated_mail_county_cnt
          ,le.populated_mail_geo_lat_cnt
          ,le.populated_mail_geo_long_cnt
          ,le.populated_mail_msa_cnt
          ,le.populated_mail_geo_blk_cnt
          ,le.populated_mail_geo_match_cnt
          ,le.populated_mail_err_stat_cnt
          ,le.populated_dotid_cnt
          ,le.populated_dotscore_cnt
          ,le.populated_dotweight_cnt
          ,le.populated_empid_cnt
          ,le.populated_empscore_cnt
          ,le.populated_empweight_cnt
          ,le.populated_powid_cnt
          ,le.populated_powscore_cnt
          ,le.populated_powweight_cnt
          ,le.populated_proxid_cnt
          ,le.populated_proxscore_cnt
          ,le.populated_proxweight_cnt
          ,le.populated_seleid_cnt
          ,le.populated_selescore_cnt
          ,le.populated_seleweight_cnt
          ,le.populated_orgid_cnt
          ,le.populated_orgscore_cnt
          ,le.populated_orgweight_cnt
          ,le.populated_ultid_cnt
          ,le.populated_ultscore_cnt
          ,le.populated_ultweight_cnt
          ,le.populated_source_rec_id_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_id_ska_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_ttl_pcnt
          ,le.populated_first_name_pcnt
          ,le.populated_middle_pcnt
          ,le.populated_last_name_pcnt
          ,le.populated_t1_pcnt
          ,le.populated_dept_code_pcnt
          ,le.populated_dept_expl_pcnt
          ,le.populated_spec_pcnt
          ,le.populated_spec_expl_pcnt
          ,le.populated_dept_file_pcnt
          ,le.populated_company1_pcnt
          ,le.populated_address1_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_area_code_pcnt
          ,le.populated_number_pcnt
          ,le.populated_persid_pcnt
          ,le.populated_nixie_date_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_name_score_pcnt
          ,le.populated_mail_prim_range_pcnt
          ,le.populated_mail_predir_pcnt
          ,le.populated_mail_prim_name_pcnt
          ,le.populated_mail_addr_suffix_pcnt
          ,le.populated_mail_postdir_pcnt
          ,le.populated_mail_unit_desig_pcnt
          ,le.populated_mail_sec_range_pcnt
          ,le.populated_mail_p_city_name_pcnt
          ,le.populated_mail_v_city_name_pcnt
          ,le.populated_mail_st_pcnt
          ,le.populated_mail_zip_pcnt
          ,le.populated_mail_zip4_pcnt
          ,le.populated_mail_cart_pcnt
          ,le.populated_mail_cr_sort_sz_pcnt
          ,le.populated_mail_lot_pcnt
          ,le.populated_mail_lot_order_pcnt
          ,le.populated_mail_dbpc_pcnt
          ,le.populated_mail_chk_digit_pcnt
          ,le.populated_mail_rec_type_pcnt
          ,le.populated_mail_ace_fips_state_pcnt
          ,le.populated_mail_county_pcnt
          ,le.populated_mail_geo_lat_pcnt
          ,le.populated_mail_geo_long_pcnt
          ,le.populated_mail_msa_pcnt
          ,le.populated_mail_geo_blk_pcnt
          ,le.populated_mail_geo_match_pcnt
          ,le.populated_mail_err_stat_pcnt
          ,le.populated_dotid_pcnt
          ,le.populated_dotscore_pcnt
          ,le.populated_dotweight_pcnt
          ,le.populated_empid_pcnt
          ,le.populated_empscore_pcnt
          ,le.populated_empweight_pcnt
          ,le.populated_powid_pcnt
          ,le.populated_powscore_pcnt
          ,le.populated_powweight_pcnt
          ,le.populated_proxid_pcnt
          ,le.populated_proxscore_pcnt
          ,le.populated_proxweight_pcnt
          ,le.populated_seleid_pcnt
          ,le.populated_selescore_pcnt
          ,le.populated_seleweight_pcnt
          ,le.populated_orgid_pcnt
          ,le.populated_orgscore_pcnt
          ,le.populated_orgweight_pcnt
          ,le.populated_ultid_pcnt
          ,le.populated_ultscore_pcnt
          ,le.populated_ultweight_pcnt
          ,le.populated_source_rec_id_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,76,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Base_Nixie_Delta(prevDS, PROJECT(h, Base_Nixie_Layout_SKA));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),76,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_Nixie_Layout_SKA) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_SKA, Base_Nixie_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;

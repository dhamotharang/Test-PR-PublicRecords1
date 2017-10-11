IMPORT SALT38,STD;
IMPORT Scrubs_Certegy; // Import modules for FieldTypes attribute definitions
EXPORT raw_file_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 28;
  EXPORT NumRulesFromFieldType := 28;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 28;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(raw_file_Layout_Certegy)
    UNSIGNED1 dl_state_Invalid;
    UNSIGNED1 dl_num_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 dl_issue_dte_Invalid;
    UNSIGNED1 dl_expire_dte_Invalid;
    UNSIGNED1 house_bldg_num_Invalid;
    UNSIGNED1 street_suffix_Invalid;
    UNSIGNED1 apt_num_Invalid;
    UNSIGNED1 unit_desc_Invalid;
    UNSIGNED1 street_post_dir_Invalid;
    UNSIGNED1 street_pre_dir_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 deceased_dte_Invalid;
    UNSIGNED1 home_tel_area_Invalid;
    UNSIGNED1 home_tel_num_Invalid;
    UNSIGNED1 work_tel_area_Invalid;
    UNSIGNED1 work_tel_num_Invalid;
    UNSIGNED1 work_tel_ext_Invalid;
    UNSIGNED1 upd_dte_time_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 mid_name_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 gen_delivery_Invalid;
    UNSIGNED1 street_name_Invalid;
    UNSIGNED1 city_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(raw_file_Layout_Certegy)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(raw_file_Layout_Certegy) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dl_state_Invalid := raw_file_Fields.InValid_dl_state((SALT38.StrType)le.dl_state);
    SELF.dl_num_Invalid := raw_file_Fields.InValid_dl_num((SALT38.StrType)le.dl_num);
    SELF.ssn_Invalid := raw_file_Fields.InValid_ssn((SALT38.StrType)le.ssn);
    SELF.dl_issue_dte_Invalid := raw_file_Fields.InValid_dl_issue_dte((SALT38.StrType)le.dl_issue_dte);
    SELF.dl_expire_dte_Invalid := raw_file_Fields.InValid_dl_expire_dte((SALT38.StrType)le.dl_expire_dte);
    SELF.house_bldg_num_Invalid := raw_file_Fields.InValid_house_bldg_num((SALT38.StrType)le.house_bldg_num);
    SELF.street_suffix_Invalid := raw_file_Fields.InValid_street_suffix((SALT38.StrType)le.street_suffix);
    SELF.apt_num_Invalid := raw_file_Fields.InValid_apt_num((SALT38.StrType)le.apt_num);
    SELF.unit_desc_Invalid := raw_file_Fields.InValid_unit_desc((SALT38.StrType)le.unit_desc);
    SELF.street_post_dir_Invalid := raw_file_Fields.InValid_street_post_dir((SALT38.StrType)le.street_post_dir);
    SELF.street_pre_dir_Invalid := raw_file_Fields.InValid_street_pre_dir((SALT38.StrType)le.street_pre_dir);
    SELF.state_Invalid := raw_file_Fields.InValid_state((SALT38.StrType)le.state);
    SELF.zip_Invalid := raw_file_Fields.InValid_zip((SALT38.StrType)le.zip);
    SELF.zip4_Invalid := raw_file_Fields.InValid_zip4((SALT38.StrType)le.zip4);
    SELF.dob_Invalid := raw_file_Fields.InValid_dob((SALT38.StrType)le.dob);
    SELF.deceased_dte_Invalid := raw_file_Fields.InValid_deceased_dte((SALT38.StrType)le.deceased_dte,(SALT38.StrType)le.deceased_dte,(SALT38.StrType)le.dob);
    SELF.home_tel_area_Invalid := raw_file_Fields.InValid_home_tel_area((SALT38.StrType)le.home_tel_area,(SALT38.StrType)le.home_tel_area,(SALT38.StrType)le.home_tel_num);
    SELF.home_tel_num_Invalid := raw_file_Fields.InValid_home_tel_num((SALT38.StrType)le.home_tel_num,(SALT38.StrType)le.home_tel_area,(SALT38.StrType)le.home_tel_num);
    SELF.work_tel_area_Invalid := raw_file_Fields.InValid_work_tel_area((SALT38.StrType)le.work_tel_area,(SALT38.StrType)le.work_tel_area,(SALT38.StrType)le.work_tel_num);
    SELF.work_tel_num_Invalid := raw_file_Fields.InValid_work_tel_num((SALT38.StrType)le.work_tel_num,(SALT38.StrType)le.work_tel_area,(SALT38.StrType)le.work_tel_num);
    SELF.work_tel_ext_Invalid := raw_file_Fields.InValid_work_tel_ext((SALT38.StrType)le.work_tel_ext,(SALT38.StrType)le.work_tel_ext);
    SELF.upd_dte_time_Invalid := raw_file_Fields.InValid_upd_dte_time((SALT38.StrType)le.upd_dte_time);
    SELF.first_name_Invalid := raw_file_Fields.InValid_first_name((SALT38.StrType)le.first_name,(SALT38.StrType)le.first_name,(SALT38.StrType)le.mid_name,(SALT38.StrType)le.last_name);
    SELF.mid_name_Invalid := raw_file_Fields.InValid_mid_name((SALT38.StrType)le.mid_name,(SALT38.StrType)le.first_name,(SALT38.StrType)le.mid_name,(SALT38.StrType)le.last_name);
    SELF.last_name_Invalid := raw_file_Fields.InValid_last_name((SALT38.StrType)le.last_name,(SALT38.StrType)le.first_name,(SALT38.StrType)le.mid_name,(SALT38.StrType)le.last_name);
    SELF.gen_delivery_Invalid := raw_file_Fields.InValid_gen_delivery((SALT38.StrType)le.gen_delivery);
    SELF.street_name_Invalid := raw_file_Fields.InValid_street_name((SALT38.StrType)le.street_name);
    SELF.city_Invalid := raw_file_Fields.InValid_city((SALT38.StrType)le.city);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),raw_file_Layout_Certegy);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dl_state_Invalid << 0 ) + ( le.dl_num_Invalid << 1 ) + ( le.ssn_Invalid << 2 ) + ( le.dl_issue_dte_Invalid << 3 ) + ( le.dl_expire_dte_Invalid << 4 ) + ( le.house_bldg_num_Invalid << 5 ) + ( le.street_suffix_Invalid << 6 ) + ( le.apt_num_Invalid << 7 ) + ( le.unit_desc_Invalid << 8 ) + ( le.street_post_dir_Invalid << 9 ) + ( le.street_pre_dir_Invalid << 10 ) + ( le.state_Invalid << 11 ) + ( le.zip_Invalid << 12 ) + ( le.zip4_Invalid << 13 ) + ( le.dob_Invalid << 14 ) + ( le.deceased_dte_Invalid << 15 ) + ( le.home_tel_area_Invalid << 16 ) + ( le.home_tel_num_Invalid << 17 ) + ( le.work_tel_area_Invalid << 18 ) + ( le.work_tel_num_Invalid << 19 ) + ( le.work_tel_ext_Invalid << 20 ) + ( le.upd_dte_time_Invalid << 21 ) + ( le.first_name_Invalid << 22 ) + ( le.mid_name_Invalid << 23 ) + ( le.last_name_Invalid << 24 ) + ( le.gen_delivery_Invalid << 25 ) + ( le.street_name_Invalid << 26 ) + ( le.city_Invalid << 27 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,raw_file_Layout_Certegy);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dl_state_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dl_num_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dl_issue_dte_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.dl_expire_dte_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.house_bldg_num_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.street_suffix_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.apt_num_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.unit_desc_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.street_post_dir_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.street_pre_dir_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.deceased_dte_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.home_tel_area_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.home_tel_num_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.work_tel_area_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.work_tel_num_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.work_tel_ext_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.upd_dte_time_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.mid_name_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.gen_delivery_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.street_name_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dl_state_CUSTOM_ErrorCount := COUNT(GROUP,h.dl_state_Invalid=1);
    dl_num_ALLOW_ErrorCount := COUNT(GROUP,h.dl_num_Invalid=1);
    ssn_CUSTOM_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    dl_issue_dte_CUSTOM_ErrorCount := COUNT(GROUP,h.dl_issue_dte_Invalid=1);
    dl_expire_dte_CUSTOM_ErrorCount := COUNT(GROUP,h.dl_expire_dte_Invalid=1);
    house_bldg_num_ALLOW_ErrorCount := COUNT(GROUP,h.house_bldg_num_Invalid=1);
    street_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.street_suffix_Invalid=1);
    apt_num_ALLOW_ErrorCount := COUNT(GROUP,h.apt_num_Invalid=1);
    unit_desc_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desc_Invalid=1);
    street_post_dir_ALLOW_ErrorCount := COUNT(GROUP,h.street_post_dir_Invalid=1);
    street_pre_dir_ALLOW_ErrorCount := COUNT(GROUP,h.street_pre_dir_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zip_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    dob_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    deceased_dte_CUSTOM_ErrorCount := COUNT(GROUP,h.deceased_dte_Invalid=1);
    home_tel_area_CUSTOM_ErrorCount := COUNT(GROUP,h.home_tel_area_Invalid=1);
    home_tel_num_CUSTOM_ErrorCount := COUNT(GROUP,h.home_tel_num_Invalid=1);
    work_tel_area_CUSTOM_ErrorCount := COUNT(GROUP,h.work_tel_area_Invalid=1);
    work_tel_num_CUSTOM_ErrorCount := COUNT(GROUP,h.work_tel_num_Invalid=1);
    work_tel_ext_CUSTOM_ErrorCount := COUNT(GROUP,h.work_tel_ext_Invalid=1);
    upd_dte_time_CUSTOM_ErrorCount := COUNT(GROUP,h.upd_dte_time_Invalid=1);
    first_name_CUSTOM_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    mid_name_CUSTOM_ErrorCount := COUNT(GROUP,h.mid_name_Invalid=1);
    last_name_CUSTOM_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    gen_delivery_CUSTOM_ErrorCount := COUNT(GROUP,h.gen_delivery_Invalid=1);
    street_name_ALLOW_ErrorCount := COUNT(GROUP,h.street_name_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dl_state_Invalid > 0 OR h.dl_num_Invalid > 0 OR h.ssn_Invalid > 0 OR h.dl_issue_dte_Invalid > 0 OR h.dl_expire_dte_Invalid > 0 OR h.house_bldg_num_Invalid > 0 OR h.street_suffix_Invalid > 0 OR h.apt_num_Invalid > 0 OR h.unit_desc_Invalid > 0 OR h.street_post_dir_Invalid > 0 OR h.street_pre_dir_Invalid > 0 OR h.state_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.dob_Invalid > 0 OR h.deceased_dte_Invalid > 0 OR h.home_tel_area_Invalid > 0 OR h.home_tel_num_Invalid > 0 OR h.work_tel_area_Invalid > 0 OR h.work_tel_num_Invalid > 0 OR h.work_tel_ext_Invalid > 0 OR h.upd_dte_time_Invalid > 0 OR h.first_name_Invalid > 0 OR h.mid_name_Invalid > 0 OR h.last_name_Invalid > 0 OR h.gen_delivery_Invalid > 0 OR h.street_name_Invalid > 0 OR h.city_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dl_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dl_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dl_issue_dte_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dl_expire_dte_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.house_bldg_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.apt_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_post_dir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_pre_dir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deceased_dte_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.home_tel_area_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.home_tel_num_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.work_tel_area_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.work_tel_num_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.work_tel_ext_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.upd_dte_time_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mid_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.gen_delivery_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.street_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dl_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dl_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dl_issue_dte_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dl_expire_dte_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.house_bldg_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.apt_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_post_dir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_pre_dir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deceased_dte_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.home_tel_area_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.home_tel_num_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.work_tel_area_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.work_tel_num_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.work_tel_ext_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.upd_dte_time_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mid_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.gen_delivery_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.street_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT38.StrType ErrorMessage;
    SALT38.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.dl_state_Invalid,le.dl_num_Invalid,le.ssn_Invalid,le.dl_issue_dte_Invalid,le.dl_expire_dte_Invalid,le.house_bldg_num_Invalid,le.street_suffix_Invalid,le.apt_num_Invalid,le.unit_desc_Invalid,le.street_post_dir_Invalid,le.street_pre_dir_Invalid,le.state_Invalid,le.zip_Invalid,le.zip4_Invalid,le.dob_Invalid,le.deceased_dte_Invalid,le.home_tel_area_Invalid,le.home_tel_num_Invalid,le.work_tel_area_Invalid,le.work_tel_num_Invalid,le.work_tel_ext_Invalid,le.upd_dte_time_Invalid,le.first_name_Invalid,le.mid_name_Invalid,le.last_name_Invalid,le.gen_delivery_Invalid,le.street_name_Invalid,le.city_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,raw_file_Fields.InvalidMessage_dl_state(le.dl_state_Invalid),raw_file_Fields.InvalidMessage_dl_num(le.dl_num_Invalid),raw_file_Fields.InvalidMessage_ssn(le.ssn_Invalid),raw_file_Fields.InvalidMessage_dl_issue_dte(le.dl_issue_dte_Invalid),raw_file_Fields.InvalidMessage_dl_expire_dte(le.dl_expire_dte_Invalid),raw_file_Fields.InvalidMessage_house_bldg_num(le.house_bldg_num_Invalid),raw_file_Fields.InvalidMessage_street_suffix(le.street_suffix_Invalid),raw_file_Fields.InvalidMessage_apt_num(le.apt_num_Invalid),raw_file_Fields.InvalidMessage_unit_desc(le.unit_desc_Invalid),raw_file_Fields.InvalidMessage_street_post_dir(le.street_post_dir_Invalid),raw_file_Fields.InvalidMessage_street_pre_dir(le.street_pre_dir_Invalid),raw_file_Fields.InvalidMessage_state(le.state_Invalid),raw_file_Fields.InvalidMessage_zip(le.zip_Invalid),raw_file_Fields.InvalidMessage_zip4(le.zip4_Invalid),raw_file_Fields.InvalidMessage_dob(le.dob_Invalid),raw_file_Fields.InvalidMessage_deceased_dte(le.deceased_dte_Invalid),raw_file_Fields.InvalidMessage_home_tel_area(le.home_tel_area_Invalid),raw_file_Fields.InvalidMessage_home_tel_num(le.home_tel_num_Invalid),raw_file_Fields.InvalidMessage_work_tel_area(le.work_tel_area_Invalid),raw_file_Fields.InvalidMessage_work_tel_num(le.work_tel_num_Invalid),raw_file_Fields.InvalidMessage_work_tel_ext(le.work_tel_ext_Invalid),raw_file_Fields.InvalidMessage_upd_dte_time(le.upd_dte_time_Invalid),raw_file_Fields.InvalidMessage_first_name(le.first_name_Invalid),raw_file_Fields.InvalidMessage_mid_name(le.mid_name_Invalid),raw_file_Fields.InvalidMessage_last_name(le.last_name_Invalid),raw_file_Fields.InvalidMessage_gen_delivery(le.gen_delivery_Invalid),raw_file_Fields.InvalidMessage_street_name(le.street_name_Invalid),raw_file_Fields.InvalidMessage_city(le.city_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dl_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dl_num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dl_issue_dte_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dl_expire_dte_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.house_bldg_num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.street_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.apt_num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.street_post_dir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.street_pre_dir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.deceased_dte_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.home_tel_area_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.home_tel_num_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.work_tel_area_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.work_tel_num_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.work_tel_ext_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.upd_dte_time_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mid_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.gen_delivery_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.street_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dl_state','dl_num','ssn','dl_issue_dte','dl_expire_dte','house_bldg_num','street_suffix','apt_num','unit_desc','street_post_dir','street_pre_dir','state','zip','zip4','dob','deceased_dte','home_tel_area','home_tel_num','work_tel_area','work_tel_num','work_tel_ext','upd_dte_time','first_name','mid_name','last_name','gen_delivery','street_name','city','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_dl_state','invalid_dl_num','invalid_ssn','invalid_dl_issue_dte','invalid_dl_expire_dte','invalid_house_bldg_num','invalid_street_suffix','invalid_apt_num','invalid_unit_desc','invalid_street_post_dir','invalid_street_pre_dir','invalid_state','invalid_zip','invalid_zip4','invalid_dob','invalid_deceased_dte','invalid_home_tel_area','invalid_home_tel_num','invalid_work_tel_area','invalid_work_tel_num','invalid_work_tel_ext','invalid_upd_dte_time','invalid_first_name','invalid_mid_name','invalid_last_name','invalid_gen_delivery','invalid_street_name','invalid_city','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.dl_state,(SALT38.StrType)le.dl_num,(SALT38.StrType)le.ssn,(SALT38.StrType)le.dl_issue_dte,(SALT38.StrType)le.dl_expire_dte,(SALT38.StrType)le.house_bldg_num,(SALT38.StrType)le.street_suffix,(SALT38.StrType)le.apt_num,(SALT38.StrType)le.unit_desc,(SALT38.StrType)le.street_post_dir,(SALT38.StrType)le.street_pre_dir,(SALT38.StrType)le.state,(SALT38.StrType)le.zip,(SALT38.StrType)le.zip4,(SALT38.StrType)le.dob,(SALT38.StrType)le.deceased_dte,(SALT38.StrType)le.home_tel_area,(SALT38.StrType)le.home_tel_num,(SALT38.StrType)le.work_tel_area,(SALT38.StrType)le.work_tel_num,(SALT38.StrType)le.work_tel_ext,(SALT38.StrType)le.upd_dte_time,(SALT38.StrType)le.first_name,(SALT38.StrType)le.mid_name,(SALT38.StrType)le.last_name,(SALT38.StrType)le.gen_delivery,(SALT38.StrType)le.street_name,(SALT38.StrType)le.city,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,28,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(raw_file_Layout_Certegy) prevDS = DATASET([], raw_file_Layout_Certegy), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dl_state:invalid_dl_state:CUSTOM'
          ,'dl_num:invalid_dl_num:ALLOW'
          ,'ssn:invalid_ssn:CUSTOM'
          ,'dl_issue_dte:invalid_dl_issue_dte:CUSTOM'
          ,'dl_expire_dte:invalid_dl_expire_dte:CUSTOM'
          ,'house_bldg_num:invalid_house_bldg_num:ALLOW'
          ,'street_suffix:invalid_street_suffix:ALLOW'
          ,'apt_num:invalid_apt_num:ALLOW'
          ,'unit_desc:invalid_unit_desc:ALLOW'
          ,'street_post_dir:invalid_street_post_dir:ALLOW'
          ,'street_pre_dir:invalid_street_pre_dir:ALLOW'
          ,'state:invalid_state:CUSTOM'
          ,'zip:invalid_zip:CUSTOM'
          ,'zip4:invalid_zip4:CUSTOM'
          ,'dob:invalid_dob:CUSTOM'
          ,'deceased_dte:invalid_deceased_dte:CUSTOM'
          ,'home_tel_area:invalid_home_tel_area:CUSTOM'
          ,'home_tel_num:invalid_home_tel_num:CUSTOM'
          ,'work_tel_area:invalid_work_tel_area:CUSTOM'
          ,'work_tel_num:invalid_work_tel_num:CUSTOM'
          ,'work_tel_ext:invalid_work_tel_ext:CUSTOM'
          ,'upd_dte_time:invalid_upd_dte_time:CUSTOM'
          ,'first_name:invalid_first_name:CUSTOM'
          ,'mid_name:invalid_mid_name:CUSTOM'
          ,'last_name:invalid_last_name:CUSTOM'
          ,'gen_delivery:invalid_gen_delivery:CUSTOM'
          ,'street_name:invalid_street_name:ALLOW'
          ,'city:invalid_city:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,raw_file_Fields.InvalidMessage_dl_state(1)
          ,raw_file_Fields.InvalidMessage_dl_num(1)
          ,raw_file_Fields.InvalidMessage_ssn(1)
          ,raw_file_Fields.InvalidMessage_dl_issue_dte(1)
          ,raw_file_Fields.InvalidMessage_dl_expire_dte(1)
          ,raw_file_Fields.InvalidMessage_house_bldg_num(1)
          ,raw_file_Fields.InvalidMessage_street_suffix(1)
          ,raw_file_Fields.InvalidMessage_apt_num(1)
          ,raw_file_Fields.InvalidMessage_unit_desc(1)
          ,raw_file_Fields.InvalidMessage_street_post_dir(1)
          ,raw_file_Fields.InvalidMessage_street_pre_dir(1)
          ,raw_file_Fields.InvalidMessage_state(1)
          ,raw_file_Fields.InvalidMessage_zip(1)
          ,raw_file_Fields.InvalidMessage_zip4(1)
          ,raw_file_Fields.InvalidMessage_dob(1)
          ,raw_file_Fields.InvalidMessage_deceased_dte(1)
          ,raw_file_Fields.InvalidMessage_home_tel_area(1)
          ,raw_file_Fields.InvalidMessage_home_tel_num(1)
          ,raw_file_Fields.InvalidMessage_work_tel_area(1)
          ,raw_file_Fields.InvalidMessage_work_tel_num(1)
          ,raw_file_Fields.InvalidMessage_work_tel_ext(1)
          ,raw_file_Fields.InvalidMessage_upd_dte_time(1)
          ,raw_file_Fields.InvalidMessage_first_name(1)
          ,raw_file_Fields.InvalidMessage_mid_name(1)
          ,raw_file_Fields.InvalidMessage_last_name(1)
          ,raw_file_Fields.InvalidMessage_gen_delivery(1)
          ,raw_file_Fields.InvalidMessage_street_name(1)
          ,raw_file_Fields.InvalidMessage_city(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dl_state_CUSTOM_ErrorCount
          ,le.dl_num_ALLOW_ErrorCount
          ,le.ssn_CUSTOM_ErrorCount
          ,le.dl_issue_dte_CUSTOM_ErrorCount
          ,le.dl_expire_dte_CUSTOM_ErrorCount
          ,le.house_bldg_num_ALLOW_ErrorCount
          ,le.street_suffix_ALLOW_ErrorCount
          ,le.apt_num_ALLOW_ErrorCount
          ,le.unit_desc_ALLOW_ErrorCount
          ,le.street_post_dir_ALLOW_ErrorCount
          ,le.street_pre_dir_ALLOW_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.deceased_dte_CUSTOM_ErrorCount
          ,le.home_tel_area_CUSTOM_ErrorCount
          ,le.home_tel_num_CUSTOM_ErrorCount
          ,le.work_tel_area_CUSTOM_ErrorCount
          ,le.work_tel_num_CUSTOM_ErrorCount
          ,le.work_tel_ext_CUSTOM_ErrorCount
          ,le.upd_dte_time_CUSTOM_ErrorCount
          ,le.first_name_CUSTOM_ErrorCount
          ,le.mid_name_CUSTOM_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.gen_delivery_CUSTOM_ErrorCount
          ,le.street_name_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dl_state_CUSTOM_ErrorCount
          ,le.dl_num_ALLOW_ErrorCount
          ,le.ssn_CUSTOM_ErrorCount
          ,le.dl_issue_dte_CUSTOM_ErrorCount
          ,le.dl_expire_dte_CUSTOM_ErrorCount
          ,le.house_bldg_num_ALLOW_ErrorCount
          ,le.street_suffix_ALLOW_ErrorCount
          ,le.apt_num_ALLOW_ErrorCount
          ,le.unit_desc_ALLOW_ErrorCount
          ,le.street_post_dir_ALLOW_ErrorCount
          ,le.street_pre_dir_ALLOW_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.deceased_dte_CUSTOM_ErrorCount
          ,le.home_tel_area_CUSTOM_ErrorCount
          ,le.home_tel_num_CUSTOM_ErrorCount
          ,le.work_tel_area_CUSTOM_ErrorCount
          ,le.work_tel_num_CUSTOM_ErrorCount
          ,le.work_tel_ext_CUSTOM_ErrorCount
          ,le.upd_dte_time_CUSTOM_ErrorCount
          ,le.first_name_CUSTOM_ErrorCount
          ,le.mid_name_CUSTOM_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.gen_delivery_CUSTOM_ErrorCount
          ,le.street_name_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
      SALT38.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT38.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := raw_file_hygiene(PROJECT(h, raw_file_Layout_Certegy));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT38.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dl_state:' + getFieldTypeText(h.dl_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dl_num:' + getFieldTypeText(h.dl_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn:' + getFieldTypeText(h.ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dl_issue_dte:' + getFieldTypeText(h.dl_issue_dte) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dl_expire_dte:' + getFieldTypeText(h.dl_expire_dte) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'house_bldg_num:' + getFieldTypeText(h.house_bldg_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_suffix:' + getFieldTypeText(h.street_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'apt_num:' + getFieldTypeText(h.apt_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desc:' + getFieldTypeText(h.unit_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_post_dir:' + getFieldTypeText(h.street_post_dir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_pre_dir:' + getFieldTypeText(h.street_pre_dir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deceased_dte:' + getFieldTypeText(h.deceased_dte) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'home_tel_area:' + getFieldTypeText(h.home_tel_area) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'home_tel_num:' + getFieldTypeText(h.home_tel_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'work_tel_area:' + getFieldTypeText(h.work_tel_area) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'work_tel_num:' + getFieldTypeText(h.work_tel_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'work_tel_ext:' + getFieldTypeText(h.work_tel_ext) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'upd_dte_time:' + getFieldTypeText(h.upd_dte_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_name:' + getFieldTypeText(h.first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mid_name:' + getFieldTypeText(h.mid_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_name:' + getFieldTypeText(h.last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gen_delivery:' + getFieldTypeText(h.gen_delivery) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_name:' + getFieldTypeText(h.street_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'foreign_cntry:' + getFieldTypeText(h.foreign_cntry) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dl_state_cnt
          ,le.populated_dl_num_cnt
          ,le.populated_ssn_cnt
          ,le.populated_dl_issue_dte_cnt
          ,le.populated_dl_expire_dte_cnt
          ,le.populated_house_bldg_num_cnt
          ,le.populated_street_suffix_cnt
          ,le.populated_apt_num_cnt
          ,le.populated_unit_desc_cnt
          ,le.populated_street_post_dir_cnt
          ,le.populated_street_pre_dir_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_dob_cnt
          ,le.populated_deceased_dte_cnt
          ,le.populated_home_tel_area_cnt
          ,le.populated_home_tel_num_cnt
          ,le.populated_work_tel_area_cnt
          ,le.populated_work_tel_num_cnt
          ,le.populated_work_tel_ext_cnt
          ,le.populated_upd_dte_time_cnt
          ,le.populated_first_name_cnt
          ,le.populated_mid_name_cnt
          ,le.populated_last_name_cnt
          ,le.populated_gen_delivery_cnt
          ,le.populated_street_name_cnt
          ,le.populated_city_cnt
          ,le.populated_foreign_cntry_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dl_state_pcnt
          ,le.populated_dl_num_pcnt
          ,le.populated_ssn_pcnt
          ,le.populated_dl_issue_dte_pcnt
          ,le.populated_dl_expire_dte_pcnt
          ,le.populated_house_bldg_num_pcnt
          ,le.populated_street_suffix_pcnt
          ,le.populated_apt_num_pcnt
          ,le.populated_unit_desc_pcnt
          ,le.populated_street_post_dir_pcnt
          ,le.populated_street_pre_dir_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_deceased_dte_pcnt
          ,le.populated_home_tel_area_pcnt
          ,le.populated_home_tel_num_pcnt
          ,le.populated_work_tel_area_pcnt
          ,le.populated_work_tel_num_pcnt
          ,le.populated_work_tel_ext_pcnt
          ,le.populated_upd_dte_time_pcnt
          ,le.populated_first_name_pcnt
          ,le.populated_mid_name_pcnt
          ,le.populated_last_name_pcnt
          ,le.populated_gen_delivery_pcnt
          ,le.populated_street_name_pcnt
          ,le.populated_city_pcnt
          ,le.populated_foreign_cntry_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,29,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT38.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := raw_file_Delta(prevDS, PROJECT(h, raw_file_Layout_Certegy));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),29,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(raw_file_Layout_Certegy) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Certegy, raw_file_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT38.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT38.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;

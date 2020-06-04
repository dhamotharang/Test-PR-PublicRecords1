IMPORT SALT311,STD;
IMPORT Scrubs_DL_CT; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 33;
  EXPORT NumRulesFromFieldType := 33;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 33;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_In_CT)
    UNSIGNED1 append_process_date_Invalid;
    UNSIGNED1 credentialstate_Invalid;
    UNSIGNED1 credentialnumber_Invalid;
    UNSIGNED1 lastname_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 height_Invalid;
    UNSIGNED1 eyecolor_Invalid;
    UNSIGNED1 date_birth_Invalid;
    UNSIGNED1 resiaddrstreet_Invalid;
    UNSIGNED1 residencycity_Invalid;
    UNSIGNED1 residencystate_Invalid;
    UNSIGNED1 residencyzip_Invalid;
    UNSIGNED1 mailaddrstreet_Invalid;
    UNSIGNED1 mailingcity_Invalid;
    UNSIGNED1 mailingstate_Invalid;
    UNSIGNED1 mailingzip_Invalid;
    UNSIGNED1 credentialtype_Invalid;
    UNSIGNED1 credential_class_Invalid;
    UNSIGNED1 endorsements_Invalid;
    UNSIGNED1 restrictions_Invalid;
    UNSIGNED1 expdate_Invalid;
    UNSIGNED1 lastissuerenewaldate_Invalid;
    UNSIGNED1 date_noncdl_Invalid;
    UNSIGNED1 originaldate_cdl_Invalid;
    UNSIGNED1 statusnoncdl_Invalid;
    UNSIGNED1 licensestatuscdl_Invalid;
    UNSIGNED1 originaldate_lp_Invalid;
    UNSIGNED1 originaldate_id_Invalid;
    UNSIGNED1 cancelstate_Invalid;
    UNSIGNED1 canceldate_Invalid;
    UNSIGNED1 cdlmedicertissuedate_Invalid;
    UNSIGNED1 cdlmedicertexpdate_Invalid;
    UNSIGNED1 clean_name_last_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_In_CT)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_In_CT) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.append_process_date_Invalid := Fields.InValid_append_process_date((SALT311.StrType)le.append_process_date);
    SELF.credentialstate_Invalid := Fields.InValid_credentialstate((SALT311.StrType)le.credentialstate);
    SELF.credentialnumber_Invalid := Fields.InValid_credentialnumber((SALT311.StrType)le.credentialnumber);
    SELF.lastname_Invalid := Fields.InValid_lastname((SALT311.StrType)le.lastname,(SALT311.StrType)le.firstname,(SALT311.StrType)le.middleinitial);
    SELF.gender_Invalid := Fields.InValid_gender((SALT311.StrType)le.gender);
    SELF.height_Invalid := Fields.InValid_height((SALT311.StrType)le.height);
    SELF.eyecolor_Invalid := Fields.InValid_eyecolor((SALT311.StrType)le.eyecolor);
    SELF.date_birth_Invalid := Fields.InValid_date_birth((SALT311.StrType)le.date_birth);
    SELF.resiaddrstreet_Invalid := Fields.InValid_resiaddrstreet((SALT311.StrType)le.resiaddrstreet);
    SELF.residencycity_Invalid := Fields.InValid_residencycity((SALT311.StrType)le.residencycity);
    SELF.residencystate_Invalid := Fields.InValid_residencystate((SALT311.StrType)le.residencystate);
    SELF.residencyzip_Invalid := Fields.InValid_residencyzip((SALT311.StrType)le.residencyzip);
    SELF.mailaddrstreet_Invalid := Fields.InValid_mailaddrstreet((SALT311.StrType)le.mailaddrstreet);
    SELF.mailingcity_Invalid := Fields.InValid_mailingcity((SALT311.StrType)le.mailingcity);
    SELF.mailingstate_Invalid := Fields.InValid_mailingstate((SALT311.StrType)le.mailingstate);
    SELF.mailingzip_Invalid := Fields.InValid_mailingzip((SALT311.StrType)le.mailingzip);
    SELF.credentialtype_Invalid := Fields.InValid_credentialtype((SALT311.StrType)le.credentialtype);
    SELF.credential_class_Invalid := Fields.InValid_credential_class((SALT311.StrType)le.credential_class);
    SELF.endorsements_Invalid := Fields.InValid_endorsements((SALT311.StrType)le.endorsements);
    SELF.restrictions_Invalid := Fields.InValid_restrictions((SALT311.StrType)le.restrictions);
    SELF.expdate_Invalid := Fields.InValid_expdate((SALT311.StrType)le.expdate);
    SELF.lastissuerenewaldate_Invalid := Fields.InValid_lastissuerenewaldate((SALT311.StrType)le.lastissuerenewaldate);
    SELF.date_noncdl_Invalid := Fields.InValid_date_noncdl((SALT311.StrType)le.date_noncdl);
    SELF.originaldate_cdl_Invalid := Fields.InValid_originaldate_cdl((SALT311.StrType)le.originaldate_cdl);
    SELF.statusnoncdl_Invalid := Fields.InValid_statusnoncdl((SALT311.StrType)le.statusnoncdl);
    SELF.licensestatuscdl_Invalid := Fields.InValid_licensestatuscdl((SALT311.StrType)le.licensestatuscdl);
    SELF.originaldate_lp_Invalid := Fields.InValid_originaldate_lp((SALT311.StrType)le.originaldate_lp);
    SELF.originaldate_id_Invalid := Fields.InValid_originaldate_id((SALT311.StrType)le.originaldate_id);
    SELF.cancelstate_Invalid := Fields.InValid_cancelstate((SALT311.StrType)le.cancelstate);
    SELF.canceldate_Invalid := Fields.InValid_canceldate((SALT311.StrType)le.canceldate);
    SELF.cdlmedicertissuedate_Invalid := Fields.InValid_cdlmedicertissuedate((SALT311.StrType)le.cdlmedicertissuedate);
    SELF.cdlmedicertexpdate_Invalid := Fields.InValid_cdlmedicertexpdate((SALT311.StrType)le.cdlmedicertexpdate);
    SELF.clean_name_last_Invalid := Fields.InValid_clean_name_last((SALT311.StrType)le.clean_name_last,(SALT311.StrType)le.clean_name_first,(SALT311.StrType)le.clean_name_middle);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_CT);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.append_process_date_Invalid << 0 ) + ( le.credentialstate_Invalid << 1 ) + ( le.credentialnumber_Invalid << 2 ) + ( le.lastname_Invalid << 3 ) + ( le.gender_Invalid << 4 ) + ( le.height_Invalid << 5 ) + ( le.eyecolor_Invalid << 6 ) + ( le.date_birth_Invalid << 7 ) + ( le.resiaddrstreet_Invalid << 8 ) + ( le.residencycity_Invalid << 9 ) + ( le.residencystate_Invalid << 10 ) + ( le.residencyzip_Invalid << 11 ) + ( le.mailaddrstreet_Invalid << 12 ) + ( le.mailingcity_Invalid << 13 ) + ( le.mailingstate_Invalid << 14 ) + ( le.mailingzip_Invalid << 15 ) + ( le.credentialtype_Invalid << 16 ) + ( le.credential_class_Invalid << 17 ) + ( le.endorsements_Invalid << 18 ) + ( le.restrictions_Invalid << 19 ) + ( le.expdate_Invalid << 20 ) + ( le.lastissuerenewaldate_Invalid << 21 ) + ( le.date_noncdl_Invalid << 22 ) + ( le.originaldate_cdl_Invalid << 23 ) + ( le.statusnoncdl_Invalid << 24 ) + ( le.licensestatuscdl_Invalid << 25 ) + ( le.originaldate_lp_Invalid << 26 ) + ( le.originaldate_id_Invalid << 27 ) + ( le.cancelstate_Invalid << 28 ) + ( le.canceldate_Invalid << 29 ) + ( le.cdlmedicertissuedate_Invalid << 30 ) + ( le.cdlmedicertexpdate_Invalid << 31 ) + ( le.clean_name_last_Invalid << 32 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_CT);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.append_process_date_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.credentialstate_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.credentialnumber_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.lastname_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.height_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.eyecolor_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.date_birth_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.resiaddrstreet_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.residencycity_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.residencystate_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.residencyzip_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.mailaddrstreet_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.mailingcity_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.mailingstate_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.mailingzip_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.credentialtype_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.credential_class_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.endorsements_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.restrictions_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.expdate_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.lastissuerenewaldate_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.date_noncdl_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.originaldate_cdl_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.statusnoncdl_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.licensestatuscdl_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.originaldate_lp_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.originaldate_id_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.cancelstate_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.canceldate_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.cdlmedicertissuedate_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.cdlmedicertexpdate_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.clean_name_last_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    append_process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.append_process_date_Invalid=1);
    credentialstate_ENUM_ErrorCount := COUNT(GROUP,h.credentialstate_Invalid=1);
    credentialnumber_CUSTOM_ErrorCount := COUNT(GROUP,h.credentialnumber_Invalid=1);
    lastname_CUSTOM_ErrorCount := COUNT(GROUP,h.lastname_Invalid=1);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    height_CUSTOM_ErrorCount := COUNT(GROUP,h.height_Invalid=1);
    eyecolor_CUSTOM_ErrorCount := COUNT(GROUP,h.eyecolor_Invalid=1);
    date_birth_CUSTOM_ErrorCount := COUNT(GROUP,h.date_birth_Invalid=1);
    resiaddrstreet_ALLOW_ErrorCount := COUNT(GROUP,h.resiaddrstreet_Invalid=1);
    residencycity_ALLOW_ErrorCount := COUNT(GROUP,h.residencycity_Invalid=1);
    residencystate_CUSTOM_ErrorCount := COUNT(GROUP,h.residencystate_Invalid=1);
    residencyzip_CUSTOM_ErrorCount := COUNT(GROUP,h.residencyzip_Invalid=1);
    mailaddrstreet_ALLOW_ErrorCount := COUNT(GROUP,h.mailaddrstreet_Invalid=1);
    mailingcity_ALLOW_ErrorCount := COUNT(GROUP,h.mailingcity_Invalid=1);
    mailingstate_CUSTOM_ErrorCount := COUNT(GROUP,h.mailingstate_Invalid=1);
    mailingzip_CUSTOM_ErrorCount := COUNT(GROUP,h.mailingzip_Invalid=1);
    credentialtype_ENUM_ErrorCount := COUNT(GROUP,h.credentialtype_Invalid=1);
    credential_class_CUSTOM_ErrorCount := COUNT(GROUP,h.credential_class_Invalid=1);
    endorsements_ALLOW_ErrorCount := COUNT(GROUP,h.endorsements_Invalid=1);
    restrictions_ALLOW_ErrorCount := COUNT(GROUP,h.restrictions_Invalid=1);
    expdate_CUSTOM_ErrorCount := COUNT(GROUP,h.expdate_Invalid=1);
    lastissuerenewaldate_CUSTOM_ErrorCount := COUNT(GROUP,h.lastissuerenewaldate_Invalid=1);
    date_noncdl_CUSTOM_ErrorCount := COUNT(GROUP,h.date_noncdl_Invalid=1);
    originaldate_cdl_CUSTOM_ErrorCount := COUNT(GROUP,h.originaldate_cdl_Invalid=1);
    statusnoncdl_CUSTOM_ErrorCount := COUNT(GROUP,h.statusnoncdl_Invalid=1);
    licensestatuscdl_CUSTOM_ErrorCount := COUNT(GROUP,h.licensestatuscdl_Invalid=1);
    originaldate_lp_CUSTOM_ErrorCount := COUNT(GROUP,h.originaldate_lp_Invalid=1);
    originaldate_id_CUSTOM_ErrorCount := COUNT(GROUP,h.originaldate_id_Invalid=1);
    cancelstate_CUSTOM_ErrorCount := COUNT(GROUP,h.cancelstate_Invalid=1);
    canceldate_CUSTOM_ErrorCount := COUNT(GROUP,h.canceldate_Invalid=1);
    cdlmedicertissuedate_CUSTOM_ErrorCount := COUNT(GROUP,h.cdlmedicertissuedate_Invalid=1);
    cdlmedicertexpdate_CUSTOM_ErrorCount := COUNT(GROUP,h.cdlmedicertexpdate_Invalid=1);
    clean_name_last_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_name_last_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.append_process_date_Invalid > 0 OR h.credentialstate_Invalid > 0 OR h.credentialnumber_Invalid > 0 OR h.lastname_Invalid > 0 OR h.gender_Invalid > 0 OR h.height_Invalid > 0 OR h.eyecolor_Invalid > 0 OR h.date_birth_Invalid > 0 OR h.resiaddrstreet_Invalid > 0 OR h.residencycity_Invalid > 0 OR h.residencystate_Invalid > 0 OR h.residencyzip_Invalid > 0 OR h.mailaddrstreet_Invalid > 0 OR h.mailingcity_Invalid > 0 OR h.mailingstate_Invalid > 0 OR h.mailingzip_Invalid > 0 OR h.credentialtype_Invalid > 0 OR h.credential_class_Invalid > 0 OR h.endorsements_Invalid > 0 OR h.restrictions_Invalid > 0 OR h.expdate_Invalid > 0 OR h.lastissuerenewaldate_Invalid > 0 OR h.date_noncdl_Invalid > 0 OR h.originaldate_cdl_Invalid > 0 OR h.statusnoncdl_Invalid > 0 OR h.licensestatuscdl_Invalid > 0 OR h.originaldate_lp_Invalid > 0 OR h.originaldate_id_Invalid > 0 OR h.cancelstate_Invalid > 0 OR h.canceldate_Invalid > 0 OR h.cdlmedicertissuedate_Invalid > 0 OR h.cdlmedicertexpdate_Invalid > 0 OR h.clean_name_last_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.append_process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.credentialstate_ENUM_ErrorCount > 0, 1, 0) + IF(le.credentialnumber_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lastname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.height_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.eyecolor_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_birth_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.resiaddrstreet_ALLOW_ErrorCount > 0, 1, 0) + IF(le.residencycity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.residencystate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.residencyzip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailaddrstreet_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailingcity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailingstate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailingzip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.credentialtype_ENUM_ErrorCount > 0, 1, 0) + IF(le.credential_class_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.endorsements_ALLOW_ErrorCount > 0, 1, 0) + IF(le.restrictions_ALLOW_ErrorCount > 0, 1, 0) + IF(le.expdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lastissuerenewaldate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_noncdl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.originaldate_cdl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.statusnoncdl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.licensestatuscdl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.originaldate_lp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.originaldate_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cancelstate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.canceldate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cdlmedicertissuedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cdlmedicertexpdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_name_last_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.append_process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.credentialstate_ENUM_ErrorCount > 0, 1, 0) + IF(le.credentialnumber_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lastname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.height_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.eyecolor_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_birth_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.resiaddrstreet_ALLOW_ErrorCount > 0, 1, 0) + IF(le.residencycity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.residencystate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.residencyzip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailaddrstreet_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailingcity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailingstate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailingzip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.credentialtype_ENUM_ErrorCount > 0, 1, 0) + IF(le.credential_class_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.endorsements_ALLOW_ErrorCount > 0, 1, 0) + IF(le.restrictions_ALLOW_ErrorCount > 0, 1, 0) + IF(le.expdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lastissuerenewaldate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_noncdl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.originaldate_cdl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.statusnoncdl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.licensestatuscdl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.originaldate_lp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.originaldate_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cancelstate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.canceldate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cdlmedicertissuedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cdlmedicertexpdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_name_last_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.append_process_date_Invalid,le.credentialstate_Invalid,le.credentialnumber_Invalid,le.lastname_Invalid,le.gender_Invalid,le.height_Invalid,le.eyecolor_Invalid,le.date_birth_Invalid,le.resiaddrstreet_Invalid,le.residencycity_Invalid,le.residencystate_Invalid,le.residencyzip_Invalid,le.mailaddrstreet_Invalid,le.mailingcity_Invalid,le.mailingstate_Invalid,le.mailingzip_Invalid,le.credentialtype_Invalid,le.credential_class_Invalid,le.endorsements_Invalid,le.restrictions_Invalid,le.expdate_Invalid,le.lastissuerenewaldate_Invalid,le.date_noncdl_Invalid,le.originaldate_cdl_Invalid,le.statusnoncdl_Invalid,le.licensestatuscdl_Invalid,le.originaldate_lp_Invalid,le.originaldate_id_Invalid,le.cancelstate_Invalid,le.canceldate_Invalid,le.cdlmedicertissuedate_Invalid,le.cdlmedicertexpdate_Invalid,le.clean_name_last_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_append_process_date(le.append_process_date_Invalid),Fields.InvalidMessage_credentialstate(le.credentialstate_Invalid),Fields.InvalidMessage_credentialnumber(le.credentialnumber_Invalid),Fields.InvalidMessage_lastname(le.lastname_Invalid),Fields.InvalidMessage_gender(le.gender_Invalid),Fields.InvalidMessage_height(le.height_Invalid),Fields.InvalidMessage_eyecolor(le.eyecolor_Invalid),Fields.InvalidMessage_date_birth(le.date_birth_Invalid),Fields.InvalidMessage_resiaddrstreet(le.resiaddrstreet_Invalid),Fields.InvalidMessage_residencycity(le.residencycity_Invalid),Fields.InvalidMessage_residencystate(le.residencystate_Invalid),Fields.InvalidMessage_residencyzip(le.residencyzip_Invalid),Fields.InvalidMessage_mailaddrstreet(le.mailaddrstreet_Invalid),Fields.InvalidMessage_mailingcity(le.mailingcity_Invalid),Fields.InvalidMessage_mailingstate(le.mailingstate_Invalid),Fields.InvalidMessage_mailingzip(le.mailingzip_Invalid),Fields.InvalidMessage_credentialtype(le.credentialtype_Invalid),Fields.InvalidMessage_credential_class(le.credential_class_Invalid),Fields.InvalidMessage_endorsements(le.endorsements_Invalid),Fields.InvalidMessage_restrictions(le.restrictions_Invalid),Fields.InvalidMessage_expdate(le.expdate_Invalid),Fields.InvalidMessage_lastissuerenewaldate(le.lastissuerenewaldate_Invalid),Fields.InvalidMessage_date_noncdl(le.date_noncdl_Invalid),Fields.InvalidMessage_originaldate_cdl(le.originaldate_cdl_Invalid),Fields.InvalidMessage_statusnoncdl(le.statusnoncdl_Invalid),Fields.InvalidMessage_licensestatuscdl(le.licensestatuscdl_Invalid),Fields.InvalidMessage_originaldate_lp(le.originaldate_lp_Invalid),Fields.InvalidMessage_originaldate_id(le.originaldate_id_Invalid),Fields.InvalidMessage_cancelstate(le.cancelstate_Invalid),Fields.InvalidMessage_canceldate(le.canceldate_Invalid),Fields.InvalidMessage_cdlmedicertissuedate(le.cdlmedicertissuedate_Invalid),Fields.InvalidMessage_cdlmedicertexpdate(le.cdlmedicertexpdate_Invalid),Fields.InvalidMessage_clean_name_last(le.clean_name_last_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.append_process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.credentialstate_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.credentialnumber_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lastname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.height_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.eyecolor_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_birth_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.resiaddrstreet_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.residencycity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.residencystate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.residencyzip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mailaddrstreet_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailingcity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailingstate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mailingzip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.credentialtype_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.credential_class_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.endorsements_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.restrictions_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.expdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lastissuerenewaldate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_noncdl_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.originaldate_cdl_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.statusnoncdl_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.licensestatuscdl_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.originaldate_lp_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.originaldate_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cancelstate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.canceldate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cdlmedicertissuedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cdlmedicertexpdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_name_last_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'append_process_date','credentialstate','credentialnumber','lastname','gender','height','eyecolor','date_birth','resiaddrstreet','residencycity','residencystate','residencyzip','mailaddrstreet','mailingcity','mailingstate','mailingzip','credentialtype','credential_class','endorsements','restrictions','expdate','lastissuerenewaldate','date_noncdl','originaldate_cdl','statusnoncdl','licensestatuscdl','originaldate_lp','originaldate_id','cancelstate','canceldate','cdlmedicertissuedate','cdlmedicertexpdate','clean_name_last','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_past_date','invalid_credentialstate','invalid_credentialnumber','invalid_name','invalid_sex','invalid_height','invalid_eye_color','invalid_past_date','invalid_street','invalid_city','invalid_state','invalid_zip','invalid_street','invalid_city','invalid_state','invalid_zip','invalid_credentialtype','invalid_class','invalid_endorsements','invalid_restrictions','invalid_general_date','invalid_past_date','invalid_past_date','invalid_past_date','invalid_status','invalid_status_cdl','invalid_past_date','invalid_past_date','invalid_state','invalid_past_date','invalid_past_date','invalid_general_date','invalid_clean_name','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.append_process_date,(SALT311.StrType)le.credentialstate,(SALT311.StrType)le.credentialnumber,(SALT311.StrType)le.lastname,(SALT311.StrType)le.gender,(SALT311.StrType)le.height,(SALT311.StrType)le.eyecolor,(SALT311.StrType)le.date_birth,(SALT311.StrType)le.resiaddrstreet,(SALT311.StrType)le.residencycity,(SALT311.StrType)le.residencystate,(SALT311.StrType)le.residencyzip,(SALT311.StrType)le.mailaddrstreet,(SALT311.StrType)le.mailingcity,(SALT311.StrType)le.mailingstate,(SALT311.StrType)le.mailingzip,(SALT311.StrType)le.credentialtype,(SALT311.StrType)le.credential_class,(SALT311.StrType)le.endorsements,(SALT311.StrType)le.restrictions,(SALT311.StrType)le.expdate,(SALT311.StrType)le.lastissuerenewaldate,(SALT311.StrType)le.date_noncdl,(SALT311.StrType)le.originaldate_cdl,(SALT311.StrType)le.statusnoncdl,(SALT311.StrType)le.licensestatuscdl,(SALT311.StrType)le.originaldate_lp,(SALT311.StrType)le.originaldate_id,(SALT311.StrType)le.cancelstate,(SALT311.StrType)le.canceldate,(SALT311.StrType)le.cdlmedicertissuedate,(SALT311.StrType)le.cdlmedicertexpdate,(SALT311.StrType)le.clean_name_last,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,33,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_In_CT) prevDS = DATASET([], Layout_In_CT), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'append_process_date:invalid_past_date:CUSTOM'
          ,'credentialstate:invalid_credentialstate:ENUM'
          ,'credentialnumber:invalid_credentialnumber:CUSTOM'
          ,'lastname:invalid_name:CUSTOM'
          ,'gender:invalid_sex:ENUM'
          ,'height:invalid_height:CUSTOM'
          ,'eyecolor:invalid_eye_color:CUSTOM'
          ,'date_birth:invalid_past_date:CUSTOM'
          ,'resiaddrstreet:invalid_street:ALLOW'
          ,'residencycity:invalid_city:ALLOW'
          ,'residencystate:invalid_state:CUSTOM'
          ,'residencyzip:invalid_zip:CUSTOM'
          ,'mailaddrstreet:invalid_street:ALLOW'
          ,'mailingcity:invalid_city:ALLOW'
          ,'mailingstate:invalid_state:CUSTOM'
          ,'mailingzip:invalid_zip:CUSTOM'
          ,'credentialtype:invalid_credentialtype:ENUM'
          ,'credential_class:invalid_class:CUSTOM'
          ,'endorsements:invalid_endorsements:ALLOW'
          ,'restrictions:invalid_restrictions:ALLOW'
          ,'expdate:invalid_general_date:CUSTOM'
          ,'lastissuerenewaldate:invalid_past_date:CUSTOM'
          ,'date_noncdl:invalid_past_date:CUSTOM'
          ,'originaldate_cdl:invalid_past_date:CUSTOM'
          ,'statusnoncdl:invalid_status:CUSTOM'
          ,'licensestatuscdl:invalid_status_cdl:CUSTOM'
          ,'originaldate_lp:invalid_past_date:CUSTOM'
          ,'originaldate_id:invalid_past_date:CUSTOM'
          ,'cancelstate:invalid_state:CUSTOM'
          ,'canceldate:invalid_past_date:CUSTOM'
          ,'cdlmedicertissuedate:invalid_past_date:CUSTOM'
          ,'cdlmedicertexpdate:invalid_general_date:CUSTOM'
          ,'clean_name_last:invalid_clean_name:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_append_process_date(1)
          ,Fields.InvalidMessage_credentialstate(1)
          ,Fields.InvalidMessage_credentialnumber(1)
          ,Fields.InvalidMessage_lastname(1)
          ,Fields.InvalidMessage_gender(1)
          ,Fields.InvalidMessage_height(1)
          ,Fields.InvalidMessage_eyecolor(1)
          ,Fields.InvalidMessage_date_birth(1)
          ,Fields.InvalidMessage_resiaddrstreet(1)
          ,Fields.InvalidMessage_residencycity(1)
          ,Fields.InvalidMessage_residencystate(1)
          ,Fields.InvalidMessage_residencyzip(1)
          ,Fields.InvalidMessage_mailaddrstreet(1)
          ,Fields.InvalidMessage_mailingcity(1)
          ,Fields.InvalidMessage_mailingstate(1)
          ,Fields.InvalidMessage_mailingzip(1)
          ,Fields.InvalidMessage_credentialtype(1)
          ,Fields.InvalidMessage_credential_class(1)
          ,Fields.InvalidMessage_endorsements(1)
          ,Fields.InvalidMessage_restrictions(1)
          ,Fields.InvalidMessage_expdate(1)
          ,Fields.InvalidMessage_lastissuerenewaldate(1)
          ,Fields.InvalidMessage_date_noncdl(1)
          ,Fields.InvalidMessage_originaldate_cdl(1)
          ,Fields.InvalidMessage_statusnoncdl(1)
          ,Fields.InvalidMessage_licensestatuscdl(1)
          ,Fields.InvalidMessage_originaldate_lp(1)
          ,Fields.InvalidMessage_originaldate_id(1)
          ,Fields.InvalidMessage_cancelstate(1)
          ,Fields.InvalidMessage_canceldate(1)
          ,Fields.InvalidMessage_cdlmedicertissuedate(1)
          ,Fields.InvalidMessage_cdlmedicertexpdate(1)
          ,Fields.InvalidMessage_clean_name_last(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.append_process_date_CUSTOM_ErrorCount
          ,le.credentialstate_ENUM_ErrorCount
          ,le.credentialnumber_CUSTOM_ErrorCount
          ,le.lastname_CUSTOM_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.height_CUSTOM_ErrorCount
          ,le.eyecolor_CUSTOM_ErrorCount
          ,le.date_birth_CUSTOM_ErrorCount
          ,le.resiaddrstreet_ALLOW_ErrorCount
          ,le.residencycity_ALLOW_ErrorCount
          ,le.residencystate_CUSTOM_ErrorCount
          ,le.residencyzip_CUSTOM_ErrorCount
          ,le.mailaddrstreet_ALLOW_ErrorCount
          ,le.mailingcity_ALLOW_ErrorCount
          ,le.mailingstate_CUSTOM_ErrorCount
          ,le.mailingzip_CUSTOM_ErrorCount
          ,le.credentialtype_ENUM_ErrorCount
          ,le.credential_class_CUSTOM_ErrorCount
          ,le.endorsements_ALLOW_ErrorCount
          ,le.restrictions_ALLOW_ErrorCount
          ,le.expdate_CUSTOM_ErrorCount
          ,le.lastissuerenewaldate_CUSTOM_ErrorCount
          ,le.date_noncdl_CUSTOM_ErrorCount
          ,le.originaldate_cdl_CUSTOM_ErrorCount
          ,le.statusnoncdl_CUSTOM_ErrorCount
          ,le.licensestatuscdl_CUSTOM_ErrorCount
          ,le.originaldate_lp_CUSTOM_ErrorCount
          ,le.originaldate_id_CUSTOM_ErrorCount
          ,le.cancelstate_CUSTOM_ErrorCount
          ,le.canceldate_CUSTOM_ErrorCount
          ,le.cdlmedicertissuedate_CUSTOM_ErrorCount
          ,le.cdlmedicertexpdate_CUSTOM_ErrorCount
          ,le.clean_name_last_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.append_process_date_CUSTOM_ErrorCount
          ,le.credentialstate_ENUM_ErrorCount
          ,le.credentialnumber_CUSTOM_ErrorCount
          ,le.lastname_CUSTOM_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.height_CUSTOM_ErrorCount
          ,le.eyecolor_CUSTOM_ErrorCount
          ,le.date_birth_CUSTOM_ErrorCount
          ,le.resiaddrstreet_ALLOW_ErrorCount
          ,le.residencycity_ALLOW_ErrorCount
          ,le.residencystate_CUSTOM_ErrorCount
          ,le.residencyzip_CUSTOM_ErrorCount
          ,le.mailaddrstreet_ALLOW_ErrorCount
          ,le.mailingcity_ALLOW_ErrorCount
          ,le.mailingstate_CUSTOM_ErrorCount
          ,le.mailingzip_CUSTOM_ErrorCount
          ,le.credentialtype_ENUM_ErrorCount
          ,le.credential_class_CUSTOM_ErrorCount
          ,le.endorsements_ALLOW_ErrorCount
          ,le.restrictions_ALLOW_ErrorCount
          ,le.expdate_CUSTOM_ErrorCount
          ,le.lastissuerenewaldate_CUSTOM_ErrorCount
          ,le.date_noncdl_CUSTOM_ErrorCount
          ,le.originaldate_cdl_CUSTOM_ErrorCount
          ,le.statusnoncdl_CUSTOM_ErrorCount
          ,le.licensestatuscdl_CUSTOM_ErrorCount
          ,le.originaldate_lp_CUSTOM_ErrorCount
          ,le.originaldate_id_CUSTOM_ErrorCount
          ,le.cancelstate_CUSTOM_ErrorCount
          ,le.canceldate_CUSTOM_ErrorCount
          ,le.cdlmedicertissuedate_CUSTOM_ErrorCount
          ,le.cdlmedicertexpdate_CUSTOM_ErrorCount
          ,le.clean_name_last_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_In_CT));
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
          ,'append_process_date:' + getFieldTypeText(h.append_process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'credentialstate:' + getFieldTypeText(h.credentialstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'credentialnumber:' + getFieldTypeText(h.credentialnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lastname:' + getFieldTypeText(h.lastname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firstname:' + getFieldTypeText(h.firstname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'middleinitial:' + getFieldTypeText(h.middleinitial) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'height:' + getFieldTypeText(h.height) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eyecolor:' + getFieldTypeText(h.eyecolor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_birth:' + getFieldTypeText(h.date_birth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'resiaddrstreet:' + getFieldTypeText(h.resiaddrstreet) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'residencycity:' + getFieldTypeText(h.residencycity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'residencystate:' + getFieldTypeText(h.residencystate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'residencyzip:' + getFieldTypeText(h.residencyzip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailaddrstreet:' + getFieldTypeText(h.mailaddrstreet) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailingcity:' + getFieldTypeText(h.mailingcity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailingstate:' + getFieldTypeText(h.mailingstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailingzip:' + getFieldTypeText(h.mailingzip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'credentialtype:' + getFieldTypeText(h.credentialtype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'credential_class:' + getFieldTypeText(h.credential_class) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'endorsements:' + getFieldTypeText(h.endorsements) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'restrictions:' + getFieldTypeText(h.restrictions) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'expdate:' + getFieldTypeText(h.expdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lastissuerenewaldate:' + getFieldTypeText(h.lastissuerenewaldate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_noncdl:' + getFieldTypeText(h.date_noncdl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'originaldate_cdl:' + getFieldTypeText(h.originaldate_cdl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'statusnoncdl:' + getFieldTypeText(h.statusnoncdl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licensestatuscdl:' + getFieldTypeText(h.licensestatuscdl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'originaldate_lp:' + getFieldTypeText(h.originaldate_lp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'originaldate_id:' + getFieldTypeText(h.originaldate_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cancelstate:' + getFieldTypeText(h.cancelstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'canceldate:' + getFieldTypeText(h.canceldate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cdlmedicertissuedate:' + getFieldTypeText(h.cdlmedicertissuedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cdlmedicertexpdate:' + getFieldTypeText(h.cdlmedicertexpdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_prefix:' + getFieldTypeText(h.clean_name_prefix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_first:' + getFieldTypeText(h.clean_name_first) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_middle:' + getFieldTypeText(h.clean_name_middle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_last:' + getFieldTypeText(h.clean_name_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_suffix:' + getFieldTypeText(h.clean_name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_score:' + getFieldTypeText(h.clean_name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_append_process_date_cnt
          ,le.populated_credentialstate_cnt
          ,le.populated_credentialnumber_cnt
          ,le.populated_lastname_cnt
          ,le.populated_firstname_cnt
          ,le.populated_middleinitial_cnt
          ,le.populated_gender_cnt
          ,le.populated_height_cnt
          ,le.populated_eyecolor_cnt
          ,le.populated_date_birth_cnt
          ,le.populated_resiaddrstreet_cnt
          ,le.populated_residencycity_cnt
          ,le.populated_residencystate_cnt
          ,le.populated_residencyzip_cnt
          ,le.populated_mailaddrstreet_cnt
          ,le.populated_mailingcity_cnt
          ,le.populated_mailingstate_cnt
          ,le.populated_mailingzip_cnt
          ,le.populated_credentialtype_cnt
          ,le.populated_credential_class_cnt
          ,le.populated_endorsements_cnt
          ,le.populated_restrictions_cnt
          ,le.populated_expdate_cnt
          ,le.populated_lastissuerenewaldate_cnt
          ,le.populated_date_noncdl_cnt
          ,le.populated_originaldate_cdl_cnt
          ,le.populated_statusnoncdl_cnt
          ,le.populated_licensestatuscdl_cnt
          ,le.populated_originaldate_lp_cnt
          ,le.populated_originaldate_id_cnt
          ,le.populated_cancelstate_cnt
          ,le.populated_canceldate_cnt
          ,le.populated_cdlmedicertissuedate_cnt
          ,le.populated_cdlmedicertexpdate_cnt
          ,le.populated_clean_name_prefix_cnt
          ,le.populated_clean_name_first_cnt
          ,le.populated_clean_name_middle_cnt
          ,le.populated_clean_name_last_cnt
          ,le.populated_clean_name_suffix_cnt
          ,le.populated_clean_name_score_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_append_process_date_pcnt
          ,le.populated_credentialstate_pcnt
          ,le.populated_credentialnumber_pcnt
          ,le.populated_lastname_pcnt
          ,le.populated_firstname_pcnt
          ,le.populated_middleinitial_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_height_pcnt
          ,le.populated_eyecolor_pcnt
          ,le.populated_date_birth_pcnt
          ,le.populated_resiaddrstreet_pcnt
          ,le.populated_residencycity_pcnt
          ,le.populated_residencystate_pcnt
          ,le.populated_residencyzip_pcnt
          ,le.populated_mailaddrstreet_pcnt
          ,le.populated_mailingcity_pcnt
          ,le.populated_mailingstate_pcnt
          ,le.populated_mailingzip_pcnt
          ,le.populated_credentialtype_pcnt
          ,le.populated_credential_class_pcnt
          ,le.populated_endorsements_pcnt
          ,le.populated_restrictions_pcnt
          ,le.populated_expdate_pcnt
          ,le.populated_lastissuerenewaldate_pcnt
          ,le.populated_date_noncdl_pcnt
          ,le.populated_originaldate_cdl_pcnt
          ,le.populated_statusnoncdl_pcnt
          ,le.populated_licensestatuscdl_pcnt
          ,le.populated_originaldate_lp_pcnt
          ,le.populated_originaldate_id_pcnt
          ,le.populated_cancelstate_pcnt
          ,le.populated_canceldate_pcnt
          ,le.populated_cdlmedicertissuedate_pcnt
          ,le.populated_cdlmedicertexpdate_pcnt
          ,le.populated_clean_name_prefix_pcnt
          ,le.populated_clean_name_first_pcnt
          ,le.populated_clean_name_middle_pcnt
          ,le.populated_clean_name_last_pcnt
          ,le.populated_clean_name_suffix_pcnt
          ,le.populated_clean_name_score_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,40,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_In_CT));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),40,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_In_CT) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_DL_CT, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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

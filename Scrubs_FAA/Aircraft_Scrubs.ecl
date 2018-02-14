IMPORT SALT38,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Aircraft_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 26;
  EXPORT NumRulesFromFieldType := 26;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 24;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Aircraft_Layout_FAA)
    UNSIGNED1 d_score_Invalid;
    UNSIGNED1 best_ssn_Invalid;
    UNSIGNED1 did_out_Invalid;
    UNSIGNED1 bdid_out_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 current_flag_Invalid;
    UNSIGNED1 n_number_Invalid;
    UNSIGNED1 serial_number_Invalid;
    UNSIGNED1 mfr_mdl_code_Invalid;
    UNSIGNED1 eng_mfr_mdl_Invalid;
    UNSIGNED1 year_mfr_Invalid;
    UNSIGNED1 type_registrant_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 region_Invalid;
    UNSIGNED1 orig_county_Invalid;
    UNSIGNED1 country_Invalid;
    UNSIGNED1 last_action_date_Invalid;
    UNSIGNED1 cert_issue_date_Invalid;
    UNSIGNED1 certification_Invalid;
    UNSIGNED1 type_aircraft_Invalid;
    UNSIGNED1 type_engine_Invalid;
    UNSIGNED1 status_code_Invalid;
    UNSIGNED1 mode_s_code_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Aircraft_Layout_FAA)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Aircraft_Layout_FAA) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.d_score_Invalid := Aircraft_Fields.InValid_d_score((SALT38.StrType)le.d_score);
    SELF.best_ssn_Invalid := Aircraft_Fields.InValid_best_ssn((SALT38.StrType)le.best_ssn);
    SELF.did_out_Invalid := Aircraft_Fields.InValid_did_out((SALT38.StrType)le.did_out);
    SELF.bdid_out_Invalid := Aircraft_Fields.InValid_bdid_out((SALT38.StrType)le.bdid_out);
    SELF.date_first_seen_Invalid := Aircraft_Fields.InValid_date_first_seen((SALT38.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Aircraft_Fields.InValid_date_last_seen((SALT38.StrType)le.date_last_seen);
    SELF.current_flag_Invalid := Aircraft_Fields.InValid_current_flag((SALT38.StrType)le.current_flag);
    SELF.n_number_Invalid := Aircraft_Fields.InValid_n_number((SALT38.StrType)le.n_number);
    SELF.serial_number_Invalid := Aircraft_Fields.InValid_serial_number((SALT38.StrType)le.serial_number);
    SELF.mfr_mdl_code_Invalid := Aircraft_Fields.InValid_mfr_mdl_code((SALT38.StrType)le.mfr_mdl_code);
    SELF.eng_mfr_mdl_Invalid := Aircraft_Fields.InValid_eng_mfr_mdl((SALT38.StrType)le.eng_mfr_mdl);
    SELF.year_mfr_Invalid := Aircraft_Fields.InValid_year_mfr((SALT38.StrType)le.year_mfr);
    SELF.type_registrant_Invalid := Aircraft_Fields.InValid_type_registrant((SALT38.StrType)le.type_registrant);
    SELF.state_Invalid := Aircraft_Fields.InValid_state((SALT38.StrType)le.state);
    SELF.region_Invalid := Aircraft_Fields.InValid_region((SALT38.StrType)le.region);
    SELF.orig_county_Invalid := Aircraft_Fields.InValid_orig_county((SALT38.StrType)le.orig_county);
    SELF.country_Invalid := Aircraft_Fields.InValid_country((SALT38.StrType)le.country);
    SELF.last_action_date_Invalid := Aircraft_Fields.InValid_last_action_date((SALT38.StrType)le.last_action_date);
    SELF.cert_issue_date_Invalid := Aircraft_Fields.InValid_cert_issue_date((SALT38.StrType)le.cert_issue_date);
    SELF.certification_Invalid := Aircraft_Fields.InValid_certification((SALT38.StrType)le.certification);
    SELF.type_aircraft_Invalid := Aircraft_Fields.InValid_type_aircraft((SALT38.StrType)le.type_aircraft);
    SELF.type_engine_Invalid := Aircraft_Fields.InValid_type_engine((SALT38.StrType)le.type_engine);
    SELF.status_code_Invalid := Aircraft_Fields.InValid_status_code((SALT38.StrType)le.status_code);
    SELF.mode_s_code_Invalid := Aircraft_Fields.InValid_mode_s_code((SALT38.StrType)le.mode_s_code);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Aircraft_Layout_FAA);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.d_score_Invalid << 0 ) + ( le.best_ssn_Invalid << 1 ) + ( le.did_out_Invalid << 3 ) + ( le.bdid_out_Invalid << 4 ) + ( le.date_first_seen_Invalid << 5 ) + ( le.date_last_seen_Invalid << 6 ) + ( le.current_flag_Invalid << 7 ) + ( le.n_number_Invalid << 8 ) + ( le.serial_number_Invalid << 9 ) + ( le.mfr_mdl_code_Invalid << 10 ) + ( le.eng_mfr_mdl_Invalid << 11 ) + ( le.year_mfr_Invalid << 12 ) + ( le.type_registrant_Invalid << 14 ) + ( le.state_Invalid << 15 ) + ( le.region_Invalid << 16 ) + ( le.orig_county_Invalid << 17 ) + ( le.country_Invalid << 18 ) + ( le.last_action_date_Invalid << 19 ) + ( le.cert_issue_date_Invalid << 20 ) + ( le.certification_Invalid << 21 ) + ( le.type_aircraft_Invalid << 22 ) + ( le.type_engine_Invalid << 23 ) + ( le.status_code_Invalid << 24 ) + ( le.mode_s_code_Invalid << 25 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Aircraft_Layout_FAA);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.d_score_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.best_ssn_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.did_out_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.bdid_out_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.current_flag_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.n_number_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.serial_number_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.mfr_mdl_code_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.eng_mfr_mdl_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.year_mfr_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.type_registrant_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.region_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.orig_county_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.country_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.last_action_date_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.cert_issue_date_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.certification_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.type_aircraft_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.type_engine_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.status_code_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.mode_s_code_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    d_score_ALLOW_ErrorCount := COUNT(GROUP,h.d_score_Invalid=1);
    best_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=1);
    best_ssn_LENGTH_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=2);
    best_ssn_Total_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid>0);
    did_out_ALLOW_ErrorCount := COUNT(GROUP,h.did_out_Invalid=1);
    bdid_out_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_out_Invalid=1);
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    current_flag_ENUM_ErrorCount := COUNT(GROUP,h.current_flag_Invalid=1);
    n_number_ALLOW_ErrorCount := COUNT(GROUP,h.n_number_Invalid=1);
    serial_number_LENGTH_ErrorCount := COUNT(GROUP,h.serial_number_Invalid=1);
    mfr_mdl_code_ALLOW_ErrorCount := COUNT(GROUP,h.mfr_mdl_code_Invalid=1);
    eng_mfr_mdl_ALLOW_ErrorCount := COUNT(GROUP,h.eng_mfr_mdl_Invalid=1);
    year_mfr_ALLOW_ErrorCount := COUNT(GROUP,h.year_mfr_Invalid=1);
    year_mfr_LENGTH_ErrorCount := COUNT(GROUP,h.year_mfr_Invalid=2);
    year_mfr_Total_ErrorCount := COUNT(GROUP,h.year_mfr_Invalid>0);
    type_registrant_ENUM_ErrorCount := COUNT(GROUP,h.type_registrant_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    region_ALLOW_ErrorCount := COUNT(GROUP,h.region_Invalid=1);
    orig_county_ALLOW_ErrorCount := COUNT(GROUP,h.orig_county_Invalid=1);
    country_ALLOW_ErrorCount := COUNT(GROUP,h.country_Invalid=1);
    last_action_date_CUSTOM_ErrorCount := COUNT(GROUP,h.last_action_date_Invalid=1);
    cert_issue_date_CUSTOM_ErrorCount := COUNT(GROUP,h.cert_issue_date_Invalid=1);
    certification_ALLOW_ErrorCount := COUNT(GROUP,h.certification_Invalid=1);
    type_aircraft_ENUM_ErrorCount := COUNT(GROUP,h.type_aircraft_Invalid=1);
    type_engine_ENUM_ErrorCount := COUNT(GROUP,h.type_engine_Invalid=1);
    status_code_ALLOW_ErrorCount := COUNT(GROUP,h.status_code_Invalid=1);
    mode_s_code_ALLOW_ErrorCount := COUNT(GROUP,h.mode_s_code_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.d_score_Invalid > 0 OR h.best_ssn_Invalid > 0 OR h.did_out_Invalid > 0 OR h.bdid_out_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.current_flag_Invalid > 0 OR h.n_number_Invalid > 0 OR h.serial_number_Invalid > 0 OR h.mfr_mdl_code_Invalid > 0 OR h.eng_mfr_mdl_Invalid > 0 OR h.year_mfr_Invalid > 0 OR h.type_registrant_Invalid > 0 OR h.state_Invalid > 0 OR h.region_Invalid > 0 OR h.orig_county_Invalid > 0 OR h.country_Invalid > 0 OR h.last_action_date_Invalid > 0 OR h.cert_issue_date_Invalid > 0 OR h.certification_Invalid > 0 OR h.type_aircraft_Invalid > 0 OR h.type_engine_Invalid > 0 OR h.status_code_Invalid > 0 OR h.mode_s_code_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.d_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.best_ssn_Total_ErrorCount > 0, 1, 0) + IF(le.did_out_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bdid_out_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.n_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.serial_number_LENGTH_ErrorCount > 0, 1, 0) + IF(le.mfr_mdl_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eng_mfr_mdl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.year_mfr_Total_ErrorCount > 0, 1, 0) + IF(le.type_registrant_ENUM_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.region_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.country_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_action_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cert_issue_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certification_ALLOW_ErrorCount > 0, 1, 0) + IF(le.type_aircraft_ENUM_ErrorCount > 0, 1, 0) + IF(le.type_engine_ENUM_ErrorCount > 0, 1, 0) + IF(le.status_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mode_s_code_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.d_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.best_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.best_ssn_LENGTH_ErrorCount > 0, 1, 0) + IF(le.did_out_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bdid_out_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.n_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.serial_number_LENGTH_ErrorCount > 0, 1, 0) + IF(le.mfr_mdl_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eng_mfr_mdl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.year_mfr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.year_mfr_LENGTH_ErrorCount > 0, 1, 0) + IF(le.type_registrant_ENUM_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.region_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.country_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_action_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cert_issue_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certification_ALLOW_ErrorCount > 0, 1, 0) + IF(le.type_aircraft_ENUM_ErrorCount > 0, 1, 0) + IF(le.type_engine_ENUM_ErrorCount > 0, 1, 0) + IF(le.status_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mode_s_code_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.d_score_Invalid,le.best_ssn_Invalid,le.did_out_Invalid,le.bdid_out_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.current_flag_Invalid,le.n_number_Invalid,le.serial_number_Invalid,le.mfr_mdl_code_Invalid,le.eng_mfr_mdl_Invalid,le.year_mfr_Invalid,le.type_registrant_Invalid,le.state_Invalid,le.region_Invalid,le.orig_county_Invalid,le.country_Invalid,le.last_action_date_Invalid,le.cert_issue_date_Invalid,le.certification_Invalid,le.type_aircraft_Invalid,le.type_engine_Invalid,le.status_code_Invalid,le.mode_s_code_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Aircraft_Fields.InvalidMessage_d_score(le.d_score_Invalid),Aircraft_Fields.InvalidMessage_best_ssn(le.best_ssn_Invalid),Aircraft_Fields.InvalidMessage_did_out(le.did_out_Invalid),Aircraft_Fields.InvalidMessage_bdid_out(le.bdid_out_Invalid),Aircraft_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Aircraft_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Aircraft_Fields.InvalidMessage_current_flag(le.current_flag_Invalid),Aircraft_Fields.InvalidMessage_n_number(le.n_number_Invalid),Aircraft_Fields.InvalidMessage_serial_number(le.serial_number_Invalid),Aircraft_Fields.InvalidMessage_mfr_mdl_code(le.mfr_mdl_code_Invalid),Aircraft_Fields.InvalidMessage_eng_mfr_mdl(le.eng_mfr_mdl_Invalid),Aircraft_Fields.InvalidMessage_year_mfr(le.year_mfr_Invalid),Aircraft_Fields.InvalidMessage_type_registrant(le.type_registrant_Invalid),Aircraft_Fields.InvalidMessage_state(le.state_Invalid),Aircraft_Fields.InvalidMessage_region(le.region_Invalid),Aircraft_Fields.InvalidMessage_orig_county(le.orig_county_Invalid),Aircraft_Fields.InvalidMessage_country(le.country_Invalid),Aircraft_Fields.InvalidMessage_last_action_date(le.last_action_date_Invalid),Aircraft_Fields.InvalidMessage_cert_issue_date(le.cert_issue_date_Invalid),Aircraft_Fields.InvalidMessage_certification(le.certification_Invalid),Aircraft_Fields.InvalidMessage_type_aircraft(le.type_aircraft_Invalid),Aircraft_Fields.InvalidMessage_type_engine(le.type_engine_Invalid),Aircraft_Fields.InvalidMessage_status_code(le.status_code_Invalid),Aircraft_Fields.InvalidMessage_mode_s_code(le.mode_s_code_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.d_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.best_ssn_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.did_out_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bdid_out_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.current_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.n_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.serial_number_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.mfr_mdl_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.eng_mfr_mdl_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.year_mfr_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.type_registrant_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.region_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.last_action_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cert_issue_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.certification_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.type_aircraft_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.type_engine_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.status_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mode_s_code_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'d_score','best_ssn','did_out','bdid_out','date_first_seen','date_last_seen','current_flag','n_number','serial_number','mfr_mdl_code','eng_mfr_mdl','year_mfr','type_registrant','state','region','orig_county','country','last_action_date','cert_issue_date','certification','type_aircraft','type_engine','status_code','mode_s_code','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_SSN','Invalid_Num','Invalid_Num','Invalid_Date','Invalid_Date','Invalid_Flag','Invalid_AlphaNum','Invalid_AlphaNumPunct','Invalid_AlphaNum','Invalid_Num','Invalid_Year','Invalid_Type','Invalid_Letter','Invalid_AlphaNum','Invalid_Num','Invalid_Letter','Invalid_Date','Invalid_Date','Invalid_AlphaNum','Invalid_Type','Invalid_Type','Invalid_AlphaNum','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.d_score,(SALT38.StrType)le.best_ssn,(SALT38.StrType)le.did_out,(SALT38.StrType)le.bdid_out,(SALT38.StrType)le.date_first_seen,(SALT38.StrType)le.date_last_seen,(SALT38.StrType)le.current_flag,(SALT38.StrType)le.n_number,(SALT38.StrType)le.serial_number,(SALT38.StrType)le.mfr_mdl_code,(SALT38.StrType)le.eng_mfr_mdl,(SALT38.StrType)le.year_mfr,(SALT38.StrType)le.type_registrant,(SALT38.StrType)le.state,(SALT38.StrType)le.region,(SALT38.StrType)le.orig_county,(SALT38.StrType)le.country,(SALT38.StrType)le.last_action_date,(SALT38.StrType)le.cert_issue_date,(SALT38.StrType)le.certification,(SALT38.StrType)le.type_aircraft,(SALT38.StrType)le.type_engine,(SALT38.StrType)le.status_code,(SALT38.StrType)le.mode_s_code,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,24,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Aircraft_Layout_FAA) prevDS = DATASET([], Aircraft_Layout_FAA), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'d_score:Invalid_Num:ALLOW'
          ,'best_ssn:Invalid_SSN:ALLOW','best_ssn:Invalid_SSN:LENGTH'
          ,'did_out:Invalid_Num:ALLOW'
          ,'bdid_out:Invalid_Num:ALLOW'
          ,'date_first_seen:Invalid_Date:CUSTOM'
          ,'date_last_seen:Invalid_Date:CUSTOM'
          ,'current_flag:Invalid_Flag:ENUM'
          ,'n_number:Invalid_AlphaNum:ALLOW'
          ,'serial_number:Invalid_AlphaNumPunct:LENGTH'
          ,'mfr_mdl_code:Invalid_AlphaNum:ALLOW'
          ,'eng_mfr_mdl:Invalid_Num:ALLOW'
          ,'year_mfr:Invalid_Year:ALLOW','year_mfr:Invalid_Year:LENGTH'
          ,'type_registrant:Invalid_Type:ENUM'
          ,'state:Invalid_Letter:ALLOW'
          ,'region:Invalid_AlphaNum:ALLOW'
          ,'orig_county:Invalid_Num:ALLOW'
          ,'country:Invalid_Letter:ALLOW'
          ,'last_action_date:Invalid_Date:CUSTOM'
          ,'cert_issue_date:Invalid_Date:CUSTOM'
          ,'certification:Invalid_AlphaNum:ALLOW'
          ,'type_aircraft:Invalid_Type:ENUM'
          ,'type_engine:Invalid_Type:ENUM'
          ,'status_code:Invalid_AlphaNum:ALLOW'
          ,'mode_s_code:Invalid_Num:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Aircraft_Fields.InvalidMessage_d_score(1)
          ,Aircraft_Fields.InvalidMessage_best_ssn(1),Aircraft_Fields.InvalidMessage_best_ssn(2)
          ,Aircraft_Fields.InvalidMessage_did_out(1)
          ,Aircraft_Fields.InvalidMessage_bdid_out(1)
          ,Aircraft_Fields.InvalidMessage_date_first_seen(1)
          ,Aircraft_Fields.InvalidMessage_date_last_seen(1)
          ,Aircraft_Fields.InvalidMessage_current_flag(1)
          ,Aircraft_Fields.InvalidMessage_n_number(1)
          ,Aircraft_Fields.InvalidMessage_serial_number(1)
          ,Aircraft_Fields.InvalidMessage_mfr_mdl_code(1)
          ,Aircraft_Fields.InvalidMessage_eng_mfr_mdl(1)
          ,Aircraft_Fields.InvalidMessage_year_mfr(1),Aircraft_Fields.InvalidMessage_year_mfr(2)
          ,Aircraft_Fields.InvalidMessage_type_registrant(1)
          ,Aircraft_Fields.InvalidMessage_state(1)
          ,Aircraft_Fields.InvalidMessage_region(1)
          ,Aircraft_Fields.InvalidMessage_orig_county(1)
          ,Aircraft_Fields.InvalidMessage_country(1)
          ,Aircraft_Fields.InvalidMessage_last_action_date(1)
          ,Aircraft_Fields.InvalidMessage_cert_issue_date(1)
          ,Aircraft_Fields.InvalidMessage_certification(1)
          ,Aircraft_Fields.InvalidMessage_type_aircraft(1)
          ,Aircraft_Fields.InvalidMessage_type_engine(1)
          ,Aircraft_Fields.InvalidMessage_status_code(1)
          ,Aircraft_Fields.InvalidMessage_mode_s_code(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.d_score_ALLOW_ErrorCount
          ,le.best_ssn_ALLOW_ErrorCount,le.best_ssn_LENGTH_ErrorCount
          ,le.did_out_ALLOW_ErrorCount
          ,le.bdid_out_ALLOW_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.current_flag_ENUM_ErrorCount
          ,le.n_number_ALLOW_ErrorCount
          ,le.serial_number_LENGTH_ErrorCount
          ,le.mfr_mdl_code_ALLOW_ErrorCount
          ,le.eng_mfr_mdl_ALLOW_ErrorCount
          ,le.year_mfr_ALLOW_ErrorCount,le.year_mfr_LENGTH_ErrorCount
          ,le.type_registrant_ENUM_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.region_ALLOW_ErrorCount
          ,le.orig_county_ALLOW_ErrorCount
          ,le.country_ALLOW_ErrorCount
          ,le.last_action_date_CUSTOM_ErrorCount
          ,le.cert_issue_date_CUSTOM_ErrorCount
          ,le.certification_ALLOW_ErrorCount
          ,le.type_aircraft_ENUM_ErrorCount
          ,le.type_engine_ENUM_ErrorCount
          ,le.status_code_ALLOW_ErrorCount
          ,le.mode_s_code_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.d_score_ALLOW_ErrorCount
          ,le.best_ssn_ALLOW_ErrorCount,le.best_ssn_LENGTH_ErrorCount
          ,le.did_out_ALLOW_ErrorCount
          ,le.bdid_out_ALLOW_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.current_flag_ENUM_ErrorCount
          ,le.n_number_ALLOW_ErrorCount
          ,le.serial_number_LENGTH_ErrorCount
          ,le.mfr_mdl_code_ALLOW_ErrorCount
          ,le.eng_mfr_mdl_ALLOW_ErrorCount
          ,le.year_mfr_ALLOW_ErrorCount,le.year_mfr_LENGTH_ErrorCount
          ,le.type_registrant_ENUM_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.region_ALLOW_ErrorCount
          ,le.orig_county_ALLOW_ErrorCount
          ,le.country_ALLOW_ErrorCount
          ,le.last_action_date_CUSTOM_ErrorCount
          ,le.cert_issue_date_CUSTOM_ErrorCount
          ,le.certification_ALLOW_ErrorCount
          ,le.type_aircraft_ENUM_ErrorCount
          ,le.type_engine_ENUM_ErrorCount
          ,le.status_code_ALLOW_ErrorCount
          ,le.mode_s_code_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := Aircraft_hygiene(PROJECT(h, Aircraft_Layout_FAA));
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
          ,'d_score:' + getFieldTypeText(h.d_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'best_ssn:' + getFieldTypeText(h.best_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_out:' + getFieldTypeText(h.did_out) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid_out:' + getFieldTypeText(h.bdid_out) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_first_seen:' + getFieldTypeText(h.date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_last_seen:' + getFieldTypeText(h.date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_flag:' + getFieldTypeText(h.current_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'n_number:' + getFieldTypeText(h.n_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'serial_number:' + getFieldTypeText(h.serial_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfr_mdl_code:' + getFieldTypeText(h.mfr_mdl_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eng_mfr_mdl:' + getFieldTypeText(h.eng_mfr_mdl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'year_mfr:' + getFieldTypeText(h.year_mfr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'type_registrant:' + getFieldTypeText(h.type_registrant) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name:' + getFieldTypeText(h.name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street:' + getFieldTypeText(h.street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street2:' + getFieldTypeText(h.street2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_code:' + getFieldTypeText(h.zip_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'region:' + getFieldTypeText(h.region) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_county:' + getFieldTypeText(h.orig_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'country:' + getFieldTypeText(h.country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_action_date:' + getFieldTypeText(h.last_action_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cert_issue_date:' + getFieldTypeText(h.cert_issue_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certification:' + getFieldTypeText(h.certification) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'type_aircraft:' + getFieldTypeText(h.type_aircraft) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'type_engine:' + getFieldTypeText(h.type_engine) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'status_code:' + getFieldTypeText(h.status_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mode_s_code:' + getFieldTypeText(h.mode_s_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fract_owner:' + getFieldTypeText(h.fract_owner) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aircraft_mfr_name:' + getFieldTypeText(h.aircraft_mfr_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'model_name:' + getFieldTypeText(h.model_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'z4:' + getFieldTypeText(h.z4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpbc:' + getFieldTypeText(h.dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_st:' + getFieldTypeText(h.ace_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'compname:' + getFieldTypeText(h.compname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lf:' + getFieldTypeText(h.lf) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_rec_id:' + getFieldTypeText(h.source_rec_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'ultweight:' + getFieldTypeText(h.ultweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_d_score_cnt
          ,le.populated_best_ssn_cnt
          ,le.populated_did_out_cnt
          ,le.populated_bdid_out_cnt
          ,le.populated_date_first_seen_cnt
          ,le.populated_date_last_seen_cnt
          ,le.populated_current_flag_cnt
          ,le.populated_n_number_cnt
          ,le.populated_serial_number_cnt
          ,le.populated_mfr_mdl_code_cnt
          ,le.populated_eng_mfr_mdl_cnt
          ,le.populated_year_mfr_cnt
          ,le.populated_type_registrant_cnt
          ,le.populated_name_cnt
          ,le.populated_street_cnt
          ,le.populated_street2_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_code_cnt
          ,le.populated_region_cnt
          ,le.populated_orig_county_cnt
          ,le.populated_country_cnt
          ,le.populated_last_action_date_cnt
          ,le.populated_cert_issue_date_cnt
          ,le.populated_certification_cnt
          ,le.populated_type_aircraft_cnt
          ,le.populated_type_engine_cnt
          ,le.populated_status_code_cnt
          ,le.populated_mode_s_code_cnt
          ,le.populated_fract_owner_cnt
          ,le.populated_aircraft_mfr_name_cnt
          ,le.populated_model_name_cnt
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
          ,le.populated_z4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dpbc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_ace_fips_st_cnt
          ,le.populated_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_compname_cnt
          ,le.populated_lf_cnt
          ,le.populated_source_rec_id_cnt
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
          ,le.populated_ultweight_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_d_score_pcnt
          ,le.populated_best_ssn_pcnt
          ,le.populated_did_out_pcnt
          ,le.populated_bdid_out_pcnt
          ,le.populated_date_first_seen_pcnt
          ,le.populated_date_last_seen_pcnt
          ,le.populated_current_flag_pcnt
          ,le.populated_n_number_pcnt
          ,le.populated_serial_number_pcnt
          ,le.populated_mfr_mdl_code_pcnt
          ,le.populated_eng_mfr_mdl_pcnt
          ,le.populated_year_mfr_pcnt
          ,le.populated_type_registrant_pcnt
          ,le.populated_name_pcnt
          ,le.populated_street_pcnt
          ,le.populated_street2_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_code_pcnt
          ,le.populated_region_pcnt
          ,le.populated_orig_county_pcnt
          ,le.populated_country_pcnt
          ,le.populated_last_action_date_pcnt
          ,le.populated_cert_issue_date_pcnt
          ,le.populated_certification_pcnt
          ,le.populated_type_aircraft_pcnt
          ,le.populated_type_engine_pcnt
          ,le.populated_status_code_pcnt
          ,le.populated_mode_s_code_pcnt
          ,le.populated_fract_owner_pcnt
          ,le.populated_aircraft_mfr_name_pcnt
          ,le.populated_model_name_pcnt
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
          ,le.populated_z4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dpbc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_ace_fips_st_pcnt
          ,le.populated_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_compname_pcnt
          ,le.populated_lf_pcnt
          ,le.populated_source_rec_id_pcnt
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
          ,le.populated_ultweight_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,88,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Aircraft_Delta(prevDS, PROJECT(h, Aircraft_Layout_FAA));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),88,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Aircraft_Layout_FAA) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_FAA, Aircraft_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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

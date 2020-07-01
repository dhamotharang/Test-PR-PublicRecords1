IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT RSIH_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 15;
  EXPORT NumRulesFromFieldType := 15;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 13;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(RSIH_Layout_Debt_Settlement)
    UNSIGNED1 avdanumber_Invalid;
    UNSIGNED1 attorneyname_Invalid;
    UNSIGNED1 businessname_Invalid;
    UNSIGNED1 address1_Invalid;
    UNSIGNED1 address2_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 email_Invalid;
    UNSIGNED1 primary_range_cln_Invalid;
    UNSIGNED1 primary_name_cln_Invalid;
    UNSIGNED1 sec_range_cln_Invalid;
    UNSIGNED1 zip_cln_Invalid;
    UNSIGNED1 did_header_addr_count_Invalid;
    UNSIGNED1 did_header_phone_count_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(RSIH_Layout_Debt_Settlement)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(RSIH_Layout_Debt_Settlement) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.avdanumber_Invalid := RSIH_Fields.InValid_avdanumber((SALT311.StrType)le.avdanumber);
    SELF.attorneyname_Invalid := RSIH_Fields.InValid_attorneyname((SALT311.StrType)le.attorneyname);
    SELF.businessname_Invalid := RSIH_Fields.InValid_businessname((SALT311.StrType)le.businessname);
    SELF.address1_Invalid := RSIH_Fields.InValid_address1((SALT311.StrType)le.address1);
    SELF.address2_Invalid := RSIH_Fields.InValid_address2((SALT311.StrType)le.address2);
    SELF.phone_Invalid := RSIH_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.email_Invalid := RSIH_Fields.InValid_email((SALT311.StrType)le.email);
    SELF.primary_range_cln_Invalid := RSIH_Fields.InValid_primary_range_cln((SALT311.StrType)le.primary_range_cln);
    SELF.primary_name_cln_Invalid := RSIH_Fields.InValid_primary_name_cln((SALT311.StrType)le.primary_name_cln);
    SELF.sec_range_cln_Invalid := RSIH_Fields.InValid_sec_range_cln((SALT311.StrType)le.sec_range_cln);
    SELF.zip_cln_Invalid := RSIH_Fields.InValid_zip_cln((SALT311.StrType)le.zip_cln);
    SELF.did_header_addr_count_Invalid := RSIH_Fields.InValid_did_header_addr_count((SALT311.StrType)le.did_header_addr_count);
    SELF.did_header_phone_count_Invalid := RSIH_Fields.InValid_did_header_phone_count((SALT311.StrType)le.did_header_phone_count);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),RSIH_Layout_Debt_Settlement);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.avdanumber_Invalid << 0 ) + ( le.attorneyname_Invalid << 2 ) + ( le.businessname_Invalid << 4 ) + ( le.address1_Invalid << 5 ) + ( le.address2_Invalid << 6 ) + ( le.phone_Invalid << 7 ) + ( le.email_Invalid << 8 ) + ( le.primary_range_cln_Invalid << 9 ) + ( le.primary_name_cln_Invalid << 10 ) + ( le.sec_range_cln_Invalid << 11 ) + ( le.zip_cln_Invalid << 12 ) + ( le.did_header_addr_count_Invalid << 13 ) + ( le.did_header_phone_count_Invalid << 14 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,RSIH_Layout_Debt_Settlement);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.avdanumber_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.attorneyname_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.businessname_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.address1_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.address2_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.email_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.primary_range_cln_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.primary_name_cln_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.sec_range_cln_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.zip_cln_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.did_header_addr_count_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.did_header_phone_count_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    avdanumber_ALLOW_ErrorCount := COUNT(GROUP,h.avdanumber_Invalid=1);
    avdanumber_LENGTHS_ErrorCount := COUNT(GROUP,h.avdanumber_Invalid=2);
    avdanumber_Total_ErrorCount := COUNT(GROUP,h.avdanumber_Invalid>0);
    attorneyname_CUSTOM_ErrorCount := COUNT(GROUP,h.attorneyname_Invalid=1);
    attorneyname_LENGTHS_ErrorCount := COUNT(GROUP,h.attorneyname_Invalid=2);
    attorneyname_Total_ErrorCount := COUNT(GROUP,h.attorneyname_Invalid>0);
    businessname_CUSTOM_ErrorCount := COUNT(GROUP,h.businessname_Invalid=1);
    address1_CUSTOM_ErrorCount := COUNT(GROUP,h.address1_Invalid=1);
    address2_CUSTOM_ErrorCount := COUNT(GROUP,h.address2_Invalid=1);
    phone_CUSTOM_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    email_CUSTOM_ErrorCount := COUNT(GROUP,h.email_Invalid=1);
    primary_range_cln_CUSTOM_ErrorCount := COUNT(GROUP,h.primary_range_cln_Invalid=1);
    primary_name_cln_CUSTOM_ErrorCount := COUNT(GROUP,h.primary_name_cln_Invalid=1);
    sec_range_cln_CUSTOM_ErrorCount := COUNT(GROUP,h.sec_range_cln_Invalid=1);
    zip_cln_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_cln_Invalid=1);
    did_header_addr_count_CUSTOM_ErrorCount := COUNT(GROUP,h.did_header_addr_count_Invalid=1);
    did_header_phone_count_CUSTOM_ErrorCount := COUNT(GROUP,h.did_header_phone_count_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.avdanumber_Invalid > 0 OR h.attorneyname_Invalid > 0 OR h.businessname_Invalid > 0 OR h.address1_Invalid > 0 OR h.address2_Invalid > 0 OR h.phone_Invalid > 0 OR h.email_Invalid > 0 OR h.primary_range_cln_Invalid > 0 OR h.primary_name_cln_Invalid > 0 OR h.sec_range_cln_Invalid > 0 OR h.zip_cln_Invalid > 0 OR h.did_header_addr_count_Invalid > 0 OR h.did_header_phone_count_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.avdanumber_Total_ErrorCount > 0, 1, 0) + IF(le.attorneyname_Total_ErrorCount > 0, 1, 0) + IF(le.businessname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.email_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primary_range_cln_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primary_name_cln_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sec_range_cln_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_cln_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_header_addr_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_header_phone_count_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.avdanumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.avdanumber_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.attorneyname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.attorneyname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.businessname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.email_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primary_range_cln_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primary_name_cln_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sec_range_cln_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_cln_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_header_addr_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_header_phone_count_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.avdanumber_Invalid,le.attorneyname_Invalid,le.businessname_Invalid,le.address1_Invalid,le.address2_Invalid,le.phone_Invalid,le.email_Invalid,le.primary_range_cln_Invalid,le.primary_name_cln_Invalid,le.sec_range_cln_Invalid,le.zip_cln_Invalid,le.did_header_addr_count_Invalid,le.did_header_phone_count_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,RSIH_Fields.InvalidMessage_avdanumber(le.avdanumber_Invalid),RSIH_Fields.InvalidMessage_attorneyname(le.attorneyname_Invalid),RSIH_Fields.InvalidMessage_businessname(le.businessname_Invalid),RSIH_Fields.InvalidMessage_address1(le.address1_Invalid),RSIH_Fields.InvalidMessage_address2(le.address2_Invalid),RSIH_Fields.InvalidMessage_phone(le.phone_Invalid),RSIH_Fields.InvalidMessage_email(le.email_Invalid),RSIH_Fields.InvalidMessage_primary_range_cln(le.primary_range_cln_Invalid),RSIH_Fields.InvalidMessage_primary_name_cln(le.primary_name_cln_Invalid),RSIH_Fields.InvalidMessage_sec_range_cln(le.sec_range_cln_Invalid),RSIH_Fields.InvalidMessage_zip_cln(le.zip_cln_Invalid),RSIH_Fields.InvalidMessage_did_header_addr_count(le.did_header_addr_count_Invalid),RSIH_Fields.InvalidMessage_did_header_phone_count(le.did_header_phone_count_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.avdanumber_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.attorneyname_Invalid,'CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.businessname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.email_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.primary_range_cln_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.primary_name_cln_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sec_range_cln_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_cln_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.did_header_addr_count_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.did_header_phone_count_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'avdanumber','attorneyname','businessname','address1','address2','phone','email','primary_range_cln','primary_name_cln','sec_range_cln','zip_cln','did_header_addr_count','did_header_phone_count','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_avdanum','Invalid_mandatory_alpha','Invalid_alpha','Invalid_alpha','Invalid_alpha','Invalid_Phone','Invalid_alpha','Invalid_alpha','Invalid_alpha','Invalid_alpha','Invalid_numeric','Invalid_numeric','Invalid_numeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.avdanumber,(SALT311.StrType)le.attorneyname,(SALT311.StrType)le.businessname,(SALT311.StrType)le.address1,(SALT311.StrType)le.address2,(SALT311.StrType)le.phone,(SALT311.StrType)le.email,(SALT311.StrType)le.primary_range_cln,(SALT311.StrType)le.primary_name_cln,(SALT311.StrType)le.sec_range_cln,(SALT311.StrType)le.zip_cln,(SALT311.StrType)le.did_header_addr_count,(SALT311.StrType)le.did_header_phone_count,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,13,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(RSIH_Layout_Debt_Settlement) prevDS = DATASET([], RSIH_Layout_Debt_Settlement), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'avdanumber:Invalid_avdanum:ALLOW','avdanumber:Invalid_avdanum:LENGTHS'
          ,'attorneyname:Invalid_mandatory_alpha:CUSTOM','attorneyname:Invalid_mandatory_alpha:LENGTHS'
          ,'businessname:Invalid_alpha:CUSTOM'
          ,'address1:Invalid_alpha:CUSTOM'
          ,'address2:Invalid_alpha:CUSTOM'
          ,'phone:Invalid_Phone:CUSTOM'
          ,'email:Invalid_alpha:CUSTOM'
          ,'primary_range_cln:Invalid_alpha:CUSTOM'
          ,'primary_name_cln:Invalid_alpha:CUSTOM'
          ,'sec_range_cln:Invalid_alpha:CUSTOM'
          ,'zip_cln:Invalid_numeric:CUSTOM'
          ,'did_header_addr_count:Invalid_numeric:CUSTOM'
          ,'did_header_phone_count:Invalid_numeric:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,RSIH_Fields.InvalidMessage_avdanumber(1),RSIH_Fields.InvalidMessage_avdanumber(2)
          ,RSIH_Fields.InvalidMessage_attorneyname(1),RSIH_Fields.InvalidMessage_attorneyname(2)
          ,RSIH_Fields.InvalidMessage_businessname(1)
          ,RSIH_Fields.InvalidMessage_address1(1)
          ,RSIH_Fields.InvalidMessage_address2(1)
          ,RSIH_Fields.InvalidMessage_phone(1)
          ,RSIH_Fields.InvalidMessage_email(1)
          ,RSIH_Fields.InvalidMessage_primary_range_cln(1)
          ,RSIH_Fields.InvalidMessage_primary_name_cln(1)
          ,RSIH_Fields.InvalidMessage_sec_range_cln(1)
          ,RSIH_Fields.InvalidMessage_zip_cln(1)
          ,RSIH_Fields.InvalidMessage_did_header_addr_count(1)
          ,RSIH_Fields.InvalidMessage_did_header_phone_count(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.avdanumber_ALLOW_ErrorCount,le.avdanumber_LENGTHS_ErrorCount
          ,le.attorneyname_CUSTOM_ErrorCount,le.attorneyname_LENGTHS_ErrorCount
          ,le.businessname_CUSTOM_ErrorCount
          ,le.address1_CUSTOM_ErrorCount
          ,le.address2_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.email_CUSTOM_ErrorCount
          ,le.primary_range_cln_CUSTOM_ErrorCount
          ,le.primary_name_cln_CUSTOM_ErrorCount
          ,le.sec_range_cln_CUSTOM_ErrorCount
          ,le.zip_cln_CUSTOM_ErrorCount
          ,le.did_header_addr_count_CUSTOM_ErrorCount
          ,le.did_header_phone_count_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.avdanumber_ALLOW_ErrorCount,le.avdanumber_LENGTHS_ErrorCount
          ,le.attorneyname_CUSTOM_ErrorCount,le.attorneyname_LENGTHS_ErrorCount
          ,le.businessname_CUSTOM_ErrorCount
          ,le.address1_CUSTOM_ErrorCount
          ,le.address2_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.email_CUSTOM_ErrorCount
          ,le.primary_range_cln_CUSTOM_ErrorCount
          ,le.primary_name_cln_CUSTOM_ErrorCount
          ,le.sec_range_cln_CUSTOM_ErrorCount
          ,le.zip_cln_CUSTOM_ErrorCount
          ,le.did_header_addr_count_CUSTOM_ErrorCount
          ,le.did_header_phone_count_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := RSIH_hygiene(PROJECT(h, RSIH_Layout_Debt_Settlement));
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
          ,'avdanumber:' + getFieldTypeText(h.avdanumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attorneyname:' + getFieldTypeText(h.attorneyname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businessname:' + getFieldTypeText(h.businessname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address1:' + getFieldTypeText(h.address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address2:' + getFieldTypeText(h.address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email:' + getFieldTypeText(h.email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary_range_cln:' + getFieldTypeText(h.primary_range_cln) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary_name_cln:' + getFieldTypeText(h.primary_name_cln) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range_cln:' + getFieldTypeText(h.sec_range_cln) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_cln:' + getFieldTypeText(h.zip_cln) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_header_addr_count:' + getFieldTypeText(h.did_header_addr_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_header_phone_count:' + getFieldTypeText(h.did_header_phone_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_phoneplus_gongphone_count:' + getFieldTypeText(h.did_phoneplus_gongphone_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_avdanumber_cnt
          ,le.populated_attorneyname_cnt
          ,le.populated_businessname_cnt
          ,le.populated_address1_cnt
          ,le.populated_address2_cnt
          ,le.populated_phone_cnt
          ,le.populated_email_cnt
          ,le.populated_primary_range_cln_cnt
          ,le.populated_primary_name_cln_cnt
          ,le.populated_sec_range_cln_cnt
          ,le.populated_zip_cln_cnt
          ,le.populated_did_header_addr_count_cnt
          ,le.populated_did_header_phone_count_cnt
          ,le.populated_did_phoneplus_gongphone_count_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_avdanumber_pcnt
          ,le.populated_attorneyname_pcnt
          ,le.populated_businessname_pcnt
          ,le.populated_address1_pcnt
          ,le.populated_address2_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_email_pcnt
          ,le.populated_primary_range_cln_pcnt
          ,le.populated_primary_name_cln_pcnt
          ,le.populated_sec_range_cln_pcnt
          ,le.populated_zip_cln_pcnt
          ,le.populated_did_header_addr_count_pcnt
          ,le.populated_did_header_phone_count_pcnt
          ,le.populated_did_phoneplus_gongphone_count_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,14,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := RSIH_Delta(prevDS, PROJECT(h, RSIH_Layout_Debt_Settlement));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),14,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(RSIH_Layout_Debt_Settlement) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Debt_Settlement, RSIH_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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

IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 18;
  EXPORT NumRulesFromFieldType := 18;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 13;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_File_Neustar)
    UNSIGNED1 ACTION_CODE_Invalid;
    UNSIGNED1 RECORD_TYPE_Invalid;
    UNSIGNED1 TELEPHONE_Invalid;
    UNSIGNED1 LISTING_TYPE_Invalid;
    UNSIGNED1 INDENT_Invalid;
    UNSIGNED1 PRE_DIR_Invalid;
    UNSIGNED1 PRIMARY_STREET_NAME_Invalid;
    UNSIGNED1 POST_DIR_Invalid;
    UNSIGNED1 STATE_Invalid;
    UNSIGNED1 ZIP_CODE_Invalid;
    UNSIGNED1 ZIP_PLUS4_Invalid;
    UNSIGNED1 ADD_DATE_Invalid;
    UNSIGNED1 OMIT_ADDRESS_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_File_Neustar)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Layout_File_Neustar)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'ACTION_CODE:ActionCodes:ALLOW'
          ,'RECORD_TYPE:RecordTypes:ALLOW'
          ,'TELEPHONE:phone:ALLOW','TELEPHONE:phone:LENGTHS'
          ,'LISTING_TYPE:PublishCodes:ALLOW'
          ,'INDENT:Numeric:ALLOW'
          ,'PRE_DIR:Directional:ENUM'
          ,'PRIMARY_STREET_NAME:primname:ALLOW'
          ,'POST_DIR:Directional:ENUM'
          ,'STATE:StateAbrv:CAPS','STATE:StateAbrv:ALLOW','STATE:StateAbrv:LENGTHS'
          ,'ZIP_CODE:zip:ALLOW','ZIP_CODE:zip:LENGTHS'
          ,'ZIP_PLUS4:zip4:ALLOW','ZIP_PLUS4:zip4:LENGTHS'
          ,'ADD_DATE:Invalid_Date:CUSTOM'
          ,'OMIT_ADDRESS:YesNo:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_ACTION_CODE(1)
          ,Fields.InvalidMessage_RECORD_TYPE(1)
          ,Fields.InvalidMessage_TELEPHONE(1),Fields.InvalidMessage_TELEPHONE(2)
          ,Fields.InvalidMessage_LISTING_TYPE(1)
          ,Fields.InvalidMessage_INDENT(1)
          ,Fields.InvalidMessage_PRE_DIR(1)
          ,Fields.InvalidMessage_PRIMARY_STREET_NAME(1)
          ,Fields.InvalidMessage_POST_DIR(1)
          ,Fields.InvalidMessage_STATE(1),Fields.InvalidMessage_STATE(2),Fields.InvalidMessage_STATE(3)
          ,Fields.InvalidMessage_ZIP_CODE(1),Fields.InvalidMessage_ZIP_CODE(2)
          ,Fields.InvalidMessage_ZIP_PLUS4(1),Fields.InvalidMessage_ZIP_PLUS4(2)
          ,Fields.InvalidMessage_ADD_DATE(1)
          ,Fields.InvalidMessage_OMIT_ADDRESS(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_File_Neustar) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ACTION_CODE_Invalid := Fields.InValid_ACTION_CODE((SALT311.StrType)le.ACTION_CODE);
    SELF.RECORD_TYPE_Invalid := Fields.InValid_RECORD_TYPE((SALT311.StrType)le.RECORD_TYPE);
    SELF.TELEPHONE_Invalid := Fields.InValid_TELEPHONE((SALT311.StrType)le.TELEPHONE);
    SELF.LISTING_TYPE_Invalid := Fields.InValid_LISTING_TYPE((SALT311.StrType)le.LISTING_TYPE);
    SELF.INDENT_Invalid := Fields.InValid_INDENT((SALT311.StrType)le.INDENT);
    SELF.PRE_DIR_Invalid := Fields.InValid_PRE_DIR((SALT311.StrType)le.PRE_DIR);
    SELF.PRIMARY_STREET_NAME_Invalid := Fields.InValid_PRIMARY_STREET_NAME((SALT311.StrType)le.PRIMARY_STREET_NAME);
    SELF.POST_DIR_Invalid := Fields.InValid_POST_DIR((SALT311.StrType)le.POST_DIR);
    SELF.STATE_Invalid := Fields.InValid_STATE((SALT311.StrType)le.STATE);
    SELF.ZIP_CODE_Invalid := Fields.InValid_ZIP_CODE((SALT311.StrType)le.ZIP_CODE);
    SELF.ZIP_PLUS4_Invalid := Fields.InValid_ZIP_PLUS4((SALT311.StrType)le.ZIP_PLUS4);
    SELF.ADD_DATE_Invalid := Fields.InValid_ADD_DATE((SALT311.StrType)le.ADD_DATE);
    SELF.OMIT_ADDRESS_Invalid := Fields.InValid_OMIT_ADDRESS((SALT311.StrType)le.OMIT_ADDRESS);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_File_Neustar);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ACTION_CODE_Invalid << 0 ) + ( le.RECORD_TYPE_Invalid << 1 ) + ( le.TELEPHONE_Invalid << 2 ) + ( le.LISTING_TYPE_Invalid << 4 ) + ( le.INDENT_Invalid << 5 ) + ( le.PRE_DIR_Invalid << 6 ) + ( le.PRIMARY_STREET_NAME_Invalid << 7 ) + ( le.POST_DIR_Invalid << 8 ) + ( le.STATE_Invalid << 9 ) + ( le.ZIP_CODE_Invalid << 11 ) + ( le.ZIP_PLUS4_Invalid << 13 ) + ( le.ADD_DATE_Invalid << 15 ) + ( le.OMIT_ADDRESS_Invalid << 16 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_File_Neustar);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ACTION_CODE_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.RECORD_TYPE_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.TELEPHONE_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.LISTING_TYPE_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.INDENT_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.PRE_DIR_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.PRIMARY_STREET_NAME_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.POST_DIR_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.STATE_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.ZIP_CODE_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.ZIP_PLUS4_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.ADD_DATE_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.OMIT_ADDRESS_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ACTION_CODE_ALLOW_ErrorCount := COUNT(GROUP,h.ACTION_CODE_Invalid=1);
    RECORD_TYPE_ALLOW_ErrorCount := COUNT(GROUP,h.RECORD_TYPE_Invalid=1);
    TELEPHONE_ALLOW_ErrorCount := COUNT(GROUP,h.TELEPHONE_Invalid=1);
    TELEPHONE_LENGTHS_ErrorCount := COUNT(GROUP,h.TELEPHONE_Invalid=2);
    TELEPHONE_Total_ErrorCount := COUNT(GROUP,h.TELEPHONE_Invalid>0);
    LISTING_TYPE_ALLOW_ErrorCount := COUNT(GROUP,h.LISTING_TYPE_Invalid=1);
    INDENT_ALLOW_ErrorCount := COUNT(GROUP,h.INDENT_Invalid=1);
    PRE_DIR_ENUM_ErrorCount := COUNT(GROUP,h.PRE_DIR_Invalid=1);
    PRIMARY_STREET_NAME_ALLOW_ErrorCount := COUNT(GROUP,h.PRIMARY_STREET_NAME_Invalid=1);
    POST_DIR_ENUM_ErrorCount := COUNT(GROUP,h.POST_DIR_Invalid=1);
    STATE_CAPS_ErrorCount := COUNT(GROUP,h.STATE_Invalid=1);
    STATE_ALLOW_ErrorCount := COUNT(GROUP,h.STATE_Invalid=2);
    STATE_LENGTHS_ErrorCount := COUNT(GROUP,h.STATE_Invalid=3);
    STATE_Total_ErrorCount := COUNT(GROUP,h.STATE_Invalid>0);
    ZIP_CODE_ALLOW_ErrorCount := COUNT(GROUP,h.ZIP_CODE_Invalid=1);
    ZIP_CODE_LENGTHS_ErrorCount := COUNT(GROUP,h.ZIP_CODE_Invalid=2);
    ZIP_CODE_Total_ErrorCount := COUNT(GROUP,h.ZIP_CODE_Invalid>0);
    ZIP_PLUS4_ALLOW_ErrorCount := COUNT(GROUP,h.ZIP_PLUS4_Invalid=1);
    ZIP_PLUS4_LENGTHS_ErrorCount := COUNT(GROUP,h.ZIP_PLUS4_Invalid=2);
    ZIP_PLUS4_Total_ErrorCount := COUNT(GROUP,h.ZIP_PLUS4_Invalid>0);
    ADD_DATE_CUSTOM_ErrorCount := COUNT(GROUP,h.ADD_DATE_Invalid=1);
    OMIT_ADDRESS_ALLOW_ErrorCount := COUNT(GROUP,h.OMIT_ADDRESS_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.ACTION_CODE_Invalid > 0 OR h.RECORD_TYPE_Invalid > 0 OR h.TELEPHONE_Invalid > 0 OR h.LISTING_TYPE_Invalid > 0 OR h.INDENT_Invalid > 0 OR h.PRE_DIR_Invalid > 0 OR h.PRIMARY_STREET_NAME_Invalid > 0 OR h.POST_DIR_Invalid > 0 OR h.STATE_Invalid > 0 OR h.ZIP_CODE_Invalid > 0 OR h.ZIP_PLUS4_Invalid > 0 OR h.ADD_DATE_Invalid > 0 OR h.OMIT_ADDRESS_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.ACTION_CODE_ALLOW_ErrorCount > 0, 1, 0) + IF(le.RECORD_TYPE_ALLOW_ErrorCount > 0, 1, 0) + IF(le.TELEPHONE_Total_ErrorCount > 0, 1, 0) + IF(le.LISTING_TYPE_ALLOW_ErrorCount > 0, 1, 0) + IF(le.INDENT_ALLOW_ErrorCount > 0, 1, 0) + IF(le.PRE_DIR_ENUM_ErrorCount > 0, 1, 0) + IF(le.PRIMARY_STREET_NAME_ALLOW_ErrorCount > 0, 1, 0) + IF(le.POST_DIR_ENUM_ErrorCount > 0, 1, 0) + IF(le.STATE_Total_ErrorCount > 0, 1, 0) + IF(le.ZIP_CODE_Total_ErrorCount > 0, 1, 0) + IF(le.ZIP_PLUS4_Total_ErrorCount > 0, 1, 0) + IF(le.ADD_DATE_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.OMIT_ADDRESS_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.ACTION_CODE_ALLOW_ErrorCount > 0, 1, 0) + IF(le.RECORD_TYPE_ALLOW_ErrorCount > 0, 1, 0) + IF(le.TELEPHONE_ALLOW_ErrorCount > 0, 1, 0) + IF(le.TELEPHONE_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.LISTING_TYPE_ALLOW_ErrorCount > 0, 1, 0) + IF(le.INDENT_ALLOW_ErrorCount > 0, 1, 0) + IF(le.PRE_DIR_ENUM_ErrorCount > 0, 1, 0) + IF(le.PRIMARY_STREET_NAME_ALLOW_ErrorCount > 0, 1, 0) + IF(le.POST_DIR_ENUM_ErrorCount > 0, 1, 0) + IF(le.STATE_CAPS_ErrorCount > 0, 1, 0) + IF(le.STATE_ALLOW_ErrorCount > 0, 1, 0) + IF(le.STATE_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ZIP_CODE_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ZIP_CODE_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ZIP_PLUS4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ZIP_PLUS4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ADD_DATE_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.OMIT_ADDRESS_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ACTION_CODE_Invalid,le.RECORD_TYPE_Invalid,le.TELEPHONE_Invalid,le.LISTING_TYPE_Invalid,le.INDENT_Invalid,le.PRE_DIR_Invalid,le.PRIMARY_STREET_NAME_Invalid,le.POST_DIR_Invalid,le.STATE_Invalid,le.ZIP_CODE_Invalid,le.ZIP_PLUS4_Invalid,le.ADD_DATE_Invalid,le.OMIT_ADDRESS_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_ACTION_CODE(le.ACTION_CODE_Invalid),Fields.InvalidMessage_RECORD_TYPE(le.RECORD_TYPE_Invalid),Fields.InvalidMessage_TELEPHONE(le.TELEPHONE_Invalid),Fields.InvalidMessage_LISTING_TYPE(le.LISTING_TYPE_Invalid),Fields.InvalidMessage_INDENT(le.INDENT_Invalid),Fields.InvalidMessage_PRE_DIR(le.PRE_DIR_Invalid),Fields.InvalidMessage_PRIMARY_STREET_NAME(le.PRIMARY_STREET_NAME_Invalid),Fields.InvalidMessage_POST_DIR(le.POST_DIR_Invalid),Fields.InvalidMessage_STATE(le.STATE_Invalid),Fields.InvalidMessage_ZIP_CODE(le.ZIP_CODE_Invalid),Fields.InvalidMessage_ZIP_PLUS4(le.ZIP_PLUS4_Invalid),Fields.InvalidMessage_ADD_DATE(le.ADD_DATE_Invalid),Fields.InvalidMessage_OMIT_ADDRESS(le.OMIT_ADDRESS_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ACTION_CODE_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.RECORD_TYPE_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.TELEPHONE_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.LISTING_TYPE_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.INDENT_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.PRE_DIR_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.PRIMARY_STREET_NAME_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.POST_DIR_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.STATE_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ZIP_CODE_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ZIP_PLUS4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ADD_DATE_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.OMIT_ADDRESS_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ACTION_CODE','RECORD_TYPE','TELEPHONE','LISTING_TYPE','INDENT','PRE_DIR','PRIMARY_STREET_NAME','POST_DIR','STATE','ZIP_CODE','ZIP_PLUS4','ADD_DATE','OMIT_ADDRESS','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'ActionCodes','RecordTypes','phone','PublishCodes','Numeric','Directional','primname','Directional','StateAbrv','zip','zip4','Invalid_Date','YesNo','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.ACTION_CODE,(SALT311.StrType)le.RECORD_TYPE,(SALT311.StrType)le.TELEPHONE,(SALT311.StrType)le.LISTING_TYPE,(SALT311.StrType)le.INDENT,(SALT311.StrType)le.PRE_DIR,(SALT311.StrType)le.PRIMARY_STREET_NAME,(SALT311.StrType)le.POST_DIR,(SALT311.StrType)le.STATE,(SALT311.StrType)le.ZIP_CODE,(SALT311.StrType)le.ZIP_PLUS4,(SALT311.StrType)le.ADD_DATE,(SALT311.StrType)le.OMIT_ADDRESS,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,13,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_File_Neustar) prevDS = DATASET([], Layout_File_Neustar), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.ACTION_CODE_ALLOW_ErrorCount
          ,le.RECORD_TYPE_ALLOW_ErrorCount
          ,le.TELEPHONE_ALLOW_ErrorCount,le.TELEPHONE_LENGTHS_ErrorCount
          ,le.LISTING_TYPE_ALLOW_ErrorCount
          ,le.INDENT_ALLOW_ErrorCount
          ,le.PRE_DIR_ENUM_ErrorCount
          ,le.PRIMARY_STREET_NAME_ALLOW_ErrorCount
          ,le.POST_DIR_ENUM_ErrorCount
          ,le.STATE_CAPS_ErrorCount,le.STATE_ALLOW_ErrorCount,le.STATE_LENGTHS_ErrorCount
          ,le.ZIP_CODE_ALLOW_ErrorCount,le.ZIP_CODE_LENGTHS_ErrorCount
          ,le.ZIP_PLUS4_ALLOW_ErrorCount,le.ZIP_PLUS4_LENGTHS_ErrorCount
          ,le.ADD_DATE_CUSTOM_ErrorCount
          ,le.OMIT_ADDRESS_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.ACTION_CODE_ALLOW_ErrorCount
          ,le.RECORD_TYPE_ALLOW_ErrorCount
          ,le.TELEPHONE_ALLOW_ErrorCount,le.TELEPHONE_LENGTHS_ErrorCount
          ,le.LISTING_TYPE_ALLOW_ErrorCount
          ,le.INDENT_ALLOW_ErrorCount
          ,le.PRE_DIR_ENUM_ErrorCount
          ,le.PRIMARY_STREET_NAME_ALLOW_ErrorCount
          ,le.POST_DIR_ENUM_ErrorCount
          ,le.STATE_CAPS_ErrorCount,le.STATE_ALLOW_ErrorCount,le.STATE_LENGTHS_ErrorCount
          ,le.ZIP_CODE_ALLOW_ErrorCount,le.ZIP_CODE_LENGTHS_ErrorCount
          ,le.ZIP_PLUS4_ALLOW_ErrorCount,le.ZIP_PLUS4_LENGTHS_ErrorCount
          ,le.ADD_DATE_CUSTOM_ErrorCount
          ,le.OMIT_ADDRESS_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_File_Neustar));
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
          ,'ACTION_CODE:' + getFieldTypeText(h.ACTION_CODE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'RECORD_ID:' + getFieldTypeText(h.RECORD_ID) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'RECORD_TYPE:' + getFieldTypeText(h.RECORD_TYPE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'TELEPHONE:' + getFieldTypeText(h.TELEPHONE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'LISTING_TYPE:' + getFieldTypeText(h.LISTING_TYPE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'BUSINESS_NAME:' + getFieldTypeText(h.BUSINESS_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'BUSINESS_CAPTIONS:' + getFieldTypeText(h.BUSINESS_CAPTIONS) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'CATEGORY:' + getFieldTypeText(h.CATEGORY) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'INDENT:' + getFieldTypeText(h.INDENT) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'LAST_NAME:' + getFieldTypeText(h.LAST_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SUFFIX_NAME:' + getFieldTypeText(h.SUFFIX_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'FIRST_NAME:' + getFieldTypeText(h.FIRST_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'MIDDLE_NAME:' + getFieldTypeText(h.MIDDLE_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'PRIMARY_STREET_NUMBER:' + getFieldTypeText(h.PRIMARY_STREET_NUMBER) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'PRE_DIR:' + getFieldTypeText(h.PRE_DIR) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'PRIMARY_STREET_NAME:' + getFieldTypeText(h.PRIMARY_STREET_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'PRIMARY_STREET_SUFFIX:' + getFieldTypeText(h.PRIMARY_STREET_SUFFIX) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'POST_DIR:' + getFieldTypeText(h.POST_DIR) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SECONDARY_ADDRESS_TYPE:' + getFieldTypeText(h.SECONDARY_ADDRESS_TYPE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SECONDARY_RANGE:' + getFieldTypeText(h.SECONDARY_RANGE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'CITY:' + getFieldTypeText(h.CITY) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'STATE:' + getFieldTypeText(h.STATE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ZIP_CODE:' + getFieldTypeText(h.ZIP_CODE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ZIP_PLUS4:' + getFieldTypeText(h.ZIP_PLUS4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'LATITUDE:' + getFieldTypeText(h.LATITUDE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'LONGITUDE:' + getFieldTypeText(h.LONGITUDE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'LAT_LONG_MATCH_LEVEL:' + getFieldTypeText(h.LAT_LONG_MATCH_LEVEL) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'UNLICENSED:' + getFieldTypeText(h.UNLICENSED) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ADD_DATE:' + getFieldTypeText(h.ADD_DATE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'OMIT_ADDRESS:' + getFieldTypeText(h.OMIT_ADDRESS) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DATA_SOURCE:' + getFieldTypeText(h.DATA_SOURCE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unknownField:' + getFieldTypeText(h.unknownField) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'TransactionID:' + getFieldTypeText(h.TransactionID) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Original_Suffix:' + getFieldTypeText(h.Original_Suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Original_First_Name:' + getFieldTypeText(h.Original_First_Name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Original_Middle_Name:' + getFieldTypeText(h.Original_Middle_Name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Original_Last_Name:' + getFieldTypeText(h.Original_Last_Name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Original_Address:' + getFieldTypeText(h.Original_Address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Original_Last_Line:' + getFieldTypeText(h.Original_Last_Line) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filename:' + getFieldTypeText(h.filename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_ACTION_CODE_cnt
          ,le.populated_RECORD_ID_cnt
          ,le.populated_RECORD_TYPE_cnt
          ,le.populated_TELEPHONE_cnt
          ,le.populated_LISTING_TYPE_cnt
          ,le.populated_BUSINESS_NAME_cnt
          ,le.populated_BUSINESS_CAPTIONS_cnt
          ,le.populated_CATEGORY_cnt
          ,le.populated_INDENT_cnt
          ,le.populated_LAST_NAME_cnt
          ,le.populated_SUFFIX_NAME_cnt
          ,le.populated_FIRST_NAME_cnt
          ,le.populated_MIDDLE_NAME_cnt
          ,le.populated_PRIMARY_STREET_NUMBER_cnt
          ,le.populated_PRE_DIR_cnt
          ,le.populated_PRIMARY_STREET_NAME_cnt
          ,le.populated_PRIMARY_STREET_SUFFIX_cnt
          ,le.populated_POST_DIR_cnt
          ,le.populated_SECONDARY_ADDRESS_TYPE_cnt
          ,le.populated_SECONDARY_RANGE_cnt
          ,le.populated_CITY_cnt
          ,le.populated_STATE_cnt
          ,le.populated_ZIP_CODE_cnt
          ,le.populated_ZIP_PLUS4_cnt
          ,le.populated_LATITUDE_cnt
          ,le.populated_LONGITUDE_cnt
          ,le.populated_LAT_LONG_MATCH_LEVEL_cnt
          ,le.populated_UNLICENSED_cnt
          ,le.populated_ADD_DATE_cnt
          ,le.populated_OMIT_ADDRESS_cnt
          ,le.populated_DATA_SOURCE_cnt
          ,le.populated_unknownField_cnt
          ,le.populated_TransactionID_cnt
          ,le.populated_Original_Suffix_cnt
          ,le.populated_Original_First_Name_cnt
          ,le.populated_Original_Middle_Name_cnt
          ,le.populated_Original_Last_Name_cnt
          ,le.populated_Original_Address_cnt
          ,le.populated_Original_Last_Line_cnt
          ,le.populated_filename_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_ACTION_CODE_pcnt
          ,le.populated_RECORD_ID_pcnt
          ,le.populated_RECORD_TYPE_pcnt
          ,le.populated_TELEPHONE_pcnt
          ,le.populated_LISTING_TYPE_pcnt
          ,le.populated_BUSINESS_NAME_pcnt
          ,le.populated_BUSINESS_CAPTIONS_pcnt
          ,le.populated_CATEGORY_pcnt
          ,le.populated_INDENT_pcnt
          ,le.populated_LAST_NAME_pcnt
          ,le.populated_SUFFIX_NAME_pcnt
          ,le.populated_FIRST_NAME_pcnt
          ,le.populated_MIDDLE_NAME_pcnt
          ,le.populated_PRIMARY_STREET_NUMBER_pcnt
          ,le.populated_PRE_DIR_pcnt
          ,le.populated_PRIMARY_STREET_NAME_pcnt
          ,le.populated_PRIMARY_STREET_SUFFIX_pcnt
          ,le.populated_POST_DIR_pcnt
          ,le.populated_SECONDARY_ADDRESS_TYPE_pcnt
          ,le.populated_SECONDARY_RANGE_pcnt
          ,le.populated_CITY_pcnt
          ,le.populated_STATE_pcnt
          ,le.populated_ZIP_CODE_pcnt
          ,le.populated_ZIP_PLUS4_pcnt
          ,le.populated_LATITUDE_pcnt
          ,le.populated_LONGITUDE_pcnt
          ,le.populated_LAT_LONG_MATCH_LEVEL_pcnt
          ,le.populated_UNLICENSED_pcnt
          ,le.populated_ADD_DATE_pcnt
          ,le.populated_OMIT_ADDRESS_pcnt
          ,le.populated_DATA_SOURCE_pcnt
          ,le.populated_unknownField_pcnt
          ,le.populated_TransactionID_pcnt
          ,le.populated_Original_Suffix_pcnt
          ,le.populated_Original_First_Name_pcnt
          ,le.populated_Original_Middle_Name_pcnt
          ,le.populated_Original_Last_Name_pcnt
          ,le.populated_Original_Address_pcnt
          ,le.populated_Original_Last_Line_pcnt
          ,le.populated_filename_pcnt,0);
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_File_Neustar));
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
 
EXPORT StandardStats(DATASET(Layout_File_Neustar) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Gong, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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

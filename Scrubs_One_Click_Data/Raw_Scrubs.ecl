IMPORT SALT311,STD;
IMPORT Scrubs_One_Click_Data,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Raw_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 15;
  EXPORT NumRulesFromFieldType := 15;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 13;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Raw_Layout_One_Click_Data)
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 firstname_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 homeaddress_Invalid;
    UNSIGNED1 homecity_Invalid;
    UNSIGNED1 homestate_Invalid;
    UNSIGNED1 homezip_Invalid;
    UNSIGNED1 homephone_Invalid;
    UNSIGNED1 mobilephone_Invalid;
    UNSIGNED1 workname_Invalid;
    UNSIGNED1 workphone_Invalid;
    UNSIGNED1 ref1phone_Invalid;
    UNSIGNED1 lastinquirydate_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Raw_Layout_One_Click_Data)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Raw_Layout_One_Click_Data) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ssn_Invalid := Raw_Fields.InValid_ssn((SALT311.StrType)le.ssn);
    SELF.firstname_Invalid := Raw_Fields.InValid_firstname((SALT311.StrType)le.firstname,(SALT311.StrType)le.lastname);
    SELF.dob_Invalid := Raw_Fields.InValid_dob((SALT311.StrType)le.dob);
    SELF.homeaddress_Invalid := Raw_Fields.InValid_homeaddress((SALT311.StrType)le.homeaddress);
    SELF.homecity_Invalid := Raw_Fields.InValid_homecity((SALT311.StrType)le.homecity);
    SELF.homestate_Invalid := Raw_Fields.InValid_homestate((SALT311.StrType)le.homestate);
    SELF.homezip_Invalid := Raw_Fields.InValid_homezip((SALT311.StrType)le.homezip);
    SELF.homephone_Invalid := Raw_Fields.InValid_homephone((SALT311.StrType)le.homephone);
    SELF.mobilephone_Invalid := Raw_Fields.InValid_mobilephone((SALT311.StrType)le.mobilephone);
    SELF.workname_Invalid := Raw_Fields.InValid_workname((SALT311.StrType)le.workname);
    SELF.workphone_Invalid := Raw_Fields.InValid_workphone((SALT311.StrType)le.workphone);
    SELF.ref1phone_Invalid := Raw_Fields.InValid_ref1phone((SALT311.StrType)le.ref1phone);
    SELF.lastinquirydate_Invalid := Raw_Fields.InValid_lastinquirydate((SALT311.StrType)le.lastinquirydate);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Raw_Layout_One_Click_Data);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ssn_Invalid << 0 ) + ( le.firstname_Invalid << 1 ) + ( le.dob_Invalid << 2 ) + ( le.homeaddress_Invalid << 3 ) + ( le.homecity_Invalid << 5 ) + ( le.homestate_Invalid << 6 ) + ( le.homezip_Invalid << 7 ) + ( le.homephone_Invalid << 8 ) + ( le.mobilephone_Invalid << 9 ) + ( le.workname_Invalid << 10 ) + ( le.workphone_Invalid << 12 ) + ( le.ref1phone_Invalid << 13 ) + ( le.lastinquirydate_Invalid << 14 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Raw_Layout_One_Click_Data);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.firstname_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.homeaddress_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.homecity_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.homestate_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.homezip_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.homephone_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.mobilephone_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.workname_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.workphone_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.ref1phone_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.lastinquirydate_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ssn_CUSTOM_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    firstname_CUSTOM_ErrorCount := COUNT(GROUP,h.firstname_Invalid=1);
    dob_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    homeaddress_CUSTOM_ErrorCount := COUNT(GROUP,h.homeaddress_Invalid=1);
    homeaddress_LENGTHS_ErrorCount := COUNT(GROUP,h.homeaddress_Invalid=2);
    homeaddress_Total_ErrorCount := COUNT(GROUP,h.homeaddress_Invalid>0);
    homecity_CUSTOM_ErrorCount := COUNT(GROUP,h.homecity_Invalid=1);
    homestate_CUSTOM_ErrorCount := COUNT(GROUP,h.homestate_Invalid=1);
    homezip_CUSTOM_ErrorCount := COUNT(GROUP,h.homezip_Invalid=1);
    homephone_CUSTOM_ErrorCount := COUNT(GROUP,h.homephone_Invalid=1);
    mobilephone_CUSTOM_ErrorCount := COUNT(GROUP,h.mobilephone_Invalid=1);
    workname_CUSTOM_ErrorCount := COUNT(GROUP,h.workname_Invalid=1);
    workname_LENGTHS_ErrorCount := COUNT(GROUP,h.workname_Invalid=2);
    workname_Total_ErrorCount := COUNT(GROUP,h.workname_Invalid>0);
    workphone_CUSTOM_ErrorCount := COUNT(GROUP,h.workphone_Invalid=1);
    ref1phone_CUSTOM_ErrorCount := COUNT(GROUP,h.ref1phone_Invalid=1);
    lastinquirydate_CUSTOM_ErrorCount := COUNT(GROUP,h.lastinquirydate_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.ssn_Invalid > 0 OR h.firstname_Invalid > 0 OR h.dob_Invalid > 0 OR h.homeaddress_Invalid > 0 OR h.homecity_Invalid > 0 OR h.homestate_Invalid > 0 OR h.homezip_Invalid > 0 OR h.homephone_Invalid > 0 OR h.mobilephone_Invalid > 0 OR h.workname_Invalid > 0 OR h.workphone_Invalid > 0 OR h.ref1phone_Invalid > 0 OR h.lastinquirydate_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.ssn_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.firstname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.homeaddress_Total_ErrorCount > 0, 1, 0) + IF(le.homecity_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.homestate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.homezip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.homephone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mobilephone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.workname_Total_ErrorCount > 0, 1, 0) + IF(le.workphone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ref1phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lastinquirydate_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.ssn_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.firstname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.homeaddress_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.homeaddress_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.homecity_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.homestate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.homezip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.homephone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mobilephone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.workname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.workname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.workphone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ref1phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lastinquirydate_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ssn_Invalid,le.firstname_Invalid,le.dob_Invalid,le.homeaddress_Invalid,le.homecity_Invalid,le.homestate_Invalid,le.homezip_Invalid,le.homephone_Invalid,le.mobilephone_Invalid,le.workname_Invalid,le.workphone_Invalid,le.ref1phone_Invalid,le.lastinquirydate_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Raw_Fields.InvalidMessage_ssn(le.ssn_Invalid),Raw_Fields.InvalidMessage_firstname(le.firstname_Invalid),Raw_Fields.InvalidMessage_dob(le.dob_Invalid),Raw_Fields.InvalidMessage_homeaddress(le.homeaddress_Invalid),Raw_Fields.InvalidMessage_homecity(le.homecity_Invalid),Raw_Fields.InvalidMessage_homestate(le.homestate_Invalid),Raw_Fields.InvalidMessage_homezip(le.homezip_Invalid),Raw_Fields.InvalidMessage_homephone(le.homephone_Invalid),Raw_Fields.InvalidMessage_mobilephone(le.mobilephone_Invalid),Raw_Fields.InvalidMessage_workname(le.workname_Invalid),Raw_Fields.InvalidMessage_workphone(le.workphone_Invalid),Raw_Fields.InvalidMessage_ref1phone(le.ref1phone_Invalid),Raw_Fields.InvalidMessage_lastinquirydate(le.lastinquirydate_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ssn_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.firstname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.homeaddress_Invalid,'CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.homecity_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.homestate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.homezip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.homephone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mobilephone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.workname_Invalid,'CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.workphone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ref1phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lastinquirydate_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ssn','firstname','dob','homeaddress','homecity','homestate','homezip','homephone','mobilephone','workname','workphone','ref1phone','lastinquirydate','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_SSN','Invalid_fName','Invalid_Dob','Invalid_mandatory_Alpha','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_Phone','Invalid_Phone','Invalid_mandatory_Alpha','Invalid_Phone','Invalid_Phone','Invalid_pastDate','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.ssn,(SALT311.StrType)le.firstname,(SALT311.StrType)le.dob,(SALT311.StrType)le.homeaddress,(SALT311.StrType)le.homecity,(SALT311.StrType)le.homestate,(SALT311.StrType)le.homezip,(SALT311.StrType)le.homephone,(SALT311.StrType)le.mobilephone,(SALT311.StrType)le.workname,(SALT311.StrType)le.workphone,(SALT311.StrType)le.ref1phone,(SALT311.StrType)le.lastinquirydate,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,13,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Raw_Layout_One_Click_Data) prevDS = DATASET([], Raw_Layout_One_Click_Data), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ssn:Invalid_SSN:CUSTOM'
          ,'firstname:Invalid_fName:CUSTOM'
          ,'dob:Invalid_Dob:CUSTOM'
          ,'homeaddress:Invalid_mandatory_Alpha:CUSTOM','homeaddress:Invalid_mandatory_Alpha:LENGTHS'
          ,'homecity:Invalid_Alpha:CUSTOM'
          ,'homestate:Invalid_State:CUSTOM'
          ,'homezip:Invalid_Zip:CUSTOM'
          ,'homephone:Invalid_Phone:CUSTOM'
          ,'mobilephone:Invalid_Phone:CUSTOM'
          ,'workname:Invalid_mandatory_Alpha:CUSTOM','workname:Invalid_mandatory_Alpha:LENGTHS'
          ,'workphone:Invalid_Phone:CUSTOM'
          ,'ref1phone:Invalid_Phone:CUSTOM'
          ,'lastinquirydate:Invalid_pastDate:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Raw_Fields.InvalidMessage_ssn(1)
          ,Raw_Fields.InvalidMessage_firstname(1)
          ,Raw_Fields.InvalidMessage_dob(1)
          ,Raw_Fields.InvalidMessage_homeaddress(1),Raw_Fields.InvalidMessage_homeaddress(2)
          ,Raw_Fields.InvalidMessage_homecity(1)
          ,Raw_Fields.InvalidMessage_homestate(1)
          ,Raw_Fields.InvalidMessage_homezip(1)
          ,Raw_Fields.InvalidMessage_homephone(1)
          ,Raw_Fields.InvalidMessage_mobilephone(1)
          ,Raw_Fields.InvalidMessage_workname(1),Raw_Fields.InvalidMessage_workname(2)
          ,Raw_Fields.InvalidMessage_workphone(1)
          ,Raw_Fields.InvalidMessage_ref1phone(1)
          ,Raw_Fields.InvalidMessage_lastinquirydate(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.ssn_CUSTOM_ErrorCount
          ,le.firstname_CUSTOM_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.homeaddress_CUSTOM_ErrorCount,le.homeaddress_LENGTHS_ErrorCount
          ,le.homecity_CUSTOM_ErrorCount
          ,le.homestate_CUSTOM_ErrorCount
          ,le.homezip_CUSTOM_ErrorCount
          ,le.homephone_CUSTOM_ErrorCount
          ,le.mobilephone_CUSTOM_ErrorCount
          ,le.workname_CUSTOM_ErrorCount,le.workname_LENGTHS_ErrorCount
          ,le.workphone_CUSTOM_ErrorCount
          ,le.ref1phone_CUSTOM_ErrorCount
          ,le.lastinquirydate_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.ssn_CUSTOM_ErrorCount
          ,le.firstname_CUSTOM_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.homeaddress_CUSTOM_ErrorCount,le.homeaddress_LENGTHS_ErrorCount
          ,le.homecity_CUSTOM_ErrorCount
          ,le.homestate_CUSTOM_ErrorCount
          ,le.homezip_CUSTOM_ErrorCount
          ,le.homephone_CUSTOM_ErrorCount
          ,le.mobilephone_CUSTOM_ErrorCount
          ,le.workname_CUSTOM_ErrorCount,le.workname_LENGTHS_ErrorCount
          ,le.workphone_CUSTOM_ErrorCount
          ,le.ref1phone_CUSTOM_ErrorCount
          ,le.lastinquirydate_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Raw_hygiene(PROJECT(h, Raw_Layout_One_Click_Data));
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
          ,'ssn:' + getFieldTypeText(h.ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firstname:' + getFieldTypeText(h.firstname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lastname:' + getFieldTypeText(h.lastname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'homeaddress:' + getFieldTypeText(h.homeaddress) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'homecity:' + getFieldTypeText(h.homecity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'homestate:' + getFieldTypeText(h.homestate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'homezip:' + getFieldTypeText(h.homezip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'homephone:' + getFieldTypeText(h.homephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mobilephone:' + getFieldTypeText(h.mobilephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'emailaddress:' + getFieldTypeText(h.emailaddress) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workname:' + getFieldTypeText(h.workname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workaddress:' + getFieldTypeText(h.workaddress) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workcity:' + getFieldTypeText(h.workcity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workstate:' + getFieldTypeText(h.workstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workzip:' + getFieldTypeText(h.workzip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workphone:' + getFieldTypeText(h.workphone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ref1firstname:' + getFieldTypeText(h.ref1firstname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ref1lastname:' + getFieldTypeText(h.ref1lastname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ref1phone:' + getFieldTypeText(h.ref1phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lastinquirydate:' + getFieldTypeText(h.lastinquirydate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ip:' + getFieldTypeText(h.ip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_ssn_cnt
          ,le.populated_firstname_cnt
          ,le.populated_lastname_cnt
          ,le.populated_dob_cnt
          ,le.populated_homeaddress_cnt
          ,le.populated_homecity_cnt
          ,le.populated_homestate_cnt
          ,le.populated_homezip_cnt
          ,le.populated_homephone_cnt
          ,le.populated_mobilephone_cnt
          ,le.populated_emailaddress_cnt
          ,le.populated_workname_cnt
          ,le.populated_workaddress_cnt
          ,le.populated_workcity_cnt
          ,le.populated_workstate_cnt
          ,le.populated_workzip_cnt
          ,le.populated_workphone_cnt
          ,le.populated_ref1firstname_cnt
          ,le.populated_ref1lastname_cnt
          ,le.populated_ref1phone_cnt
          ,le.populated_lastinquirydate_cnt
          ,le.populated_ip_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_ssn_pcnt
          ,le.populated_firstname_pcnt
          ,le.populated_lastname_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_homeaddress_pcnt
          ,le.populated_homecity_pcnt
          ,le.populated_homestate_pcnt
          ,le.populated_homezip_pcnt
          ,le.populated_homephone_pcnt
          ,le.populated_mobilephone_pcnt
          ,le.populated_emailaddress_pcnt
          ,le.populated_workname_pcnt
          ,le.populated_workaddress_pcnt
          ,le.populated_workcity_pcnt
          ,le.populated_workstate_pcnt
          ,le.populated_workzip_pcnt
          ,le.populated_workphone_pcnt
          ,le.populated_ref1firstname_pcnt
          ,le.populated_ref1lastname_pcnt
          ,le.populated_ref1phone_pcnt
          ,le.populated_lastinquirydate_pcnt
          ,le.populated_ip_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,22,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Raw_Delta(prevDS, PROJECT(h, Raw_Layout_One_Click_Data));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),22,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Raw_Layout_One_Click_Data) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_One_Click_Data, Raw_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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

IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 28;
  EXPORT NumRulesFromFieldType := 28;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 20;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_BKMortgage_Assignments)
    UNSIGNED1 ln_filedate_Invalid;
    UNSIGNED1 rectype_Invalid;
    UNSIGNED1 documenttype_Invalid;
    UNSIGNED1 fipscode_Invalid;
    UNSIGNED1 assigrecdate_Invalid;
    UNSIGNED1 assigeffecdate_Invalid;
    UNSIGNED1 origdotrecdate_Invalid;
    UNSIGNED1 origdotcontractdate_Invalid;
    UNSIGNED1 origlenderben_Invalid;
    UNSIGNED1 assignorname_Invalid;
    UNSIGNED1 assignee_Invalid;
    UNSIGNED1 mers_Invalid;
    UNSIGNED1 borrowername_Invalid;
    UNSIGNED1 apn_Invalid;
    UNSIGNED1 propertyfulladd_Invalid;
    UNSIGNED1 propertycity_Invalid;
    UNSIGNED1 propertystate_Invalid;
    UNSIGNED1 propertyzip_Invalid;
    UNSIGNED1 propertyzip4_Invalid;
    UNSIGNED1 pid_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_BKMortgage_Assignments)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_BKMortgage_Assignments) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ln_filedate_Invalid := Fields.InValid_ln_filedate((SALT311.StrType)le.ln_filedate);
    SELF.rectype_Invalid := Fields.InValid_rectype((SALT311.StrType)le.rectype);
    SELF.documenttype_Invalid := Fields.InValid_documenttype((SALT311.StrType)le.documenttype);
    SELF.fipscode_Invalid := Fields.InValid_fipscode((SALT311.StrType)le.fipscode);
    SELF.assigrecdate_Invalid := Fields.InValid_assigrecdate((SALT311.StrType)le.assigrecdate);
    SELF.assigeffecdate_Invalid := Fields.InValid_assigeffecdate((SALT311.StrType)le.assigeffecdate);
    SELF.origdotrecdate_Invalid := Fields.InValid_origdotrecdate((SALT311.StrType)le.origdotrecdate);
    SELF.origdotcontractdate_Invalid := Fields.InValid_origdotcontractdate((SALT311.StrType)le.origdotcontractdate);
    SELF.origlenderben_Invalid := Fields.InValid_origlenderben((SALT311.StrType)le.origlenderben);
    SELF.assignorname_Invalid := Fields.InValid_assignorname((SALT311.StrType)le.assignorname);
    SELF.assignee_Invalid := Fields.InValid_assignee((SALT311.StrType)le.assignee);
    SELF.mers_Invalid := Fields.InValid_mers((SALT311.StrType)le.mers);
    SELF.borrowername_Invalid := Fields.InValid_borrowername((SALT311.StrType)le.borrowername);
    SELF.apn_Invalid := Fields.InValid_apn((SALT311.StrType)le.apn);
    SELF.propertyfulladd_Invalid := Fields.InValid_propertyfulladd((SALT311.StrType)le.propertyfulladd);
    SELF.propertycity_Invalid := Fields.InValid_propertycity((SALT311.StrType)le.propertycity);
    SELF.propertystate_Invalid := Fields.InValid_propertystate((SALT311.StrType)le.propertystate);
    SELF.propertyzip_Invalid := Fields.InValid_propertyzip((SALT311.StrType)le.propertyzip);
    SELF.propertyzip4_Invalid := Fields.InValid_propertyzip4((SALT311.StrType)le.propertyzip4);
    SELF.pid_Invalid := Fields.InValid_pid((SALT311.StrType)le.pid);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_BKMortgage_Assignments);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ln_filedate_Invalid << 0 ) + ( le.rectype_Invalid << 2 ) + ( le.documenttype_Invalid << 3 ) + ( le.fipscode_Invalid << 4 ) + ( le.assigrecdate_Invalid << 5 ) + ( le.assigeffecdate_Invalid << 7 ) + ( le.origdotrecdate_Invalid << 9 ) + ( le.origdotcontractdate_Invalid << 11 ) + ( le.origlenderben_Invalid << 13 ) + ( le.assignorname_Invalid << 14 ) + ( le.assignee_Invalid << 15 ) + ( le.mers_Invalid << 16 ) + ( le.borrowername_Invalid << 17 ) + ( le.apn_Invalid << 18 ) + ( le.propertyfulladd_Invalid << 19 ) + ( le.propertycity_Invalid << 20 ) + ( le.propertystate_Invalid << 21 ) + ( le.propertyzip_Invalid << 23 ) + ( le.propertyzip4_Invalid << 25 ) + ( le.pid_Invalid << 27 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_BKMortgage_Assignments);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ln_filedate_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.rectype_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.documenttype_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.fipscode_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.assigrecdate_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.assigeffecdate_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.origdotrecdate_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.origdotcontractdate_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.origlenderben_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.assignorname_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.assignee_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.mers_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.borrowername_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.apn_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.propertyfulladd_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.propertycity_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.propertystate_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.propertyzip_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.propertyzip4_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.pid_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ln_filedate_ALLOW_ErrorCount := COUNT(GROUP,h.ln_filedate_Invalid=1);
    ln_filedate_LENGTHS_ErrorCount := COUNT(GROUP,h.ln_filedate_Invalid=2);
    ln_filedate_Total_ErrorCount := COUNT(GROUP,h.ln_filedate_Invalid>0);
    rectype_ENUM_ErrorCount := COUNT(GROUP,h.rectype_Invalid=1);
    documenttype_ENUM_ErrorCount := COUNT(GROUP,h.documenttype_Invalid=1);
    fipscode_ALLOW_ErrorCount := COUNT(GROUP,h.fipscode_Invalid=1);
    assigrecdate_ALLOW_ErrorCount := COUNT(GROUP,h.assigrecdate_Invalid=1);
    assigrecdate_LENGTHS_ErrorCount := COUNT(GROUP,h.assigrecdate_Invalid=2);
    assigrecdate_Total_ErrorCount := COUNT(GROUP,h.assigrecdate_Invalid>0);
    assigeffecdate_ALLOW_ErrorCount := COUNT(GROUP,h.assigeffecdate_Invalid=1);
    assigeffecdate_LENGTHS_ErrorCount := COUNT(GROUP,h.assigeffecdate_Invalid=2);
    assigeffecdate_Total_ErrorCount := COUNT(GROUP,h.assigeffecdate_Invalid>0);
    origdotrecdate_ALLOW_ErrorCount := COUNT(GROUP,h.origdotrecdate_Invalid=1);
    origdotrecdate_LENGTHS_ErrorCount := COUNT(GROUP,h.origdotrecdate_Invalid=2);
    origdotrecdate_Total_ErrorCount := COUNT(GROUP,h.origdotrecdate_Invalid>0);
    origdotcontractdate_ALLOW_ErrorCount := COUNT(GROUP,h.origdotcontractdate_Invalid=1);
    origdotcontractdate_LENGTHS_ErrorCount := COUNT(GROUP,h.origdotcontractdate_Invalid=2);
    origdotcontractdate_Total_ErrorCount := COUNT(GROUP,h.origdotcontractdate_Invalid>0);
    origlenderben_ALLOW_ErrorCount := COUNT(GROUP,h.origlenderben_Invalid=1);
    assignorname_ALLOW_ErrorCount := COUNT(GROUP,h.assignorname_Invalid=1);
    assignee_ALLOW_ErrorCount := COUNT(GROUP,h.assignee_Invalid=1);
    mers_ALLOW_ErrorCount := COUNT(GROUP,h.mers_Invalid=1);
    borrowername_ALLOW_ErrorCount := COUNT(GROUP,h.borrowername_Invalid=1);
    apn_ALLOW_ErrorCount := COUNT(GROUP,h.apn_Invalid=1);
    propertyfulladd_ALLOW_ErrorCount := COUNT(GROUP,h.propertyfulladd_Invalid=1);
    propertycity_ALLOW_ErrorCount := COUNT(GROUP,h.propertycity_Invalid=1);
    propertystate_ALLOW_ErrorCount := COUNT(GROUP,h.propertystate_Invalid=1);
    propertystate_LENGTHS_ErrorCount := COUNT(GROUP,h.propertystate_Invalid=2);
    propertystate_Total_ErrorCount := COUNT(GROUP,h.propertystate_Invalid>0);
    propertyzip_ALLOW_ErrorCount := COUNT(GROUP,h.propertyzip_Invalid=1);
    propertyzip_LENGTHS_ErrorCount := COUNT(GROUP,h.propertyzip_Invalid=2);
    propertyzip_Total_ErrorCount := COUNT(GROUP,h.propertyzip_Invalid>0);
    propertyzip4_ALLOW_ErrorCount := COUNT(GROUP,h.propertyzip4_Invalid=1);
    propertyzip4_LENGTHS_ErrorCount := COUNT(GROUP,h.propertyzip4_Invalid=2);
    propertyzip4_Total_ErrorCount := COUNT(GROUP,h.propertyzip4_Invalid>0);
    pid_ALLOW_ErrorCount := COUNT(GROUP,h.pid_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.ln_filedate_Invalid > 0 OR h.rectype_Invalid > 0 OR h.documenttype_Invalid > 0 OR h.fipscode_Invalid > 0 OR h.assigrecdate_Invalid > 0 OR h.assigeffecdate_Invalid > 0 OR h.origdotrecdate_Invalid > 0 OR h.origdotcontractdate_Invalid > 0 OR h.origlenderben_Invalid > 0 OR h.assignorname_Invalid > 0 OR h.assignee_Invalid > 0 OR h.mers_Invalid > 0 OR h.borrowername_Invalid > 0 OR h.apn_Invalid > 0 OR h.propertyfulladd_Invalid > 0 OR h.propertycity_Invalid > 0 OR h.propertystate_Invalid > 0 OR h.propertyzip_Invalid > 0 OR h.propertyzip4_Invalid > 0 OR h.pid_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.ln_filedate_Total_ErrorCount > 0, 1, 0) + IF(le.rectype_ENUM_ErrorCount > 0, 1, 0) + IF(le.documenttype_ENUM_ErrorCount > 0, 1, 0) + IF(le.fipscode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assigrecdate_Total_ErrorCount > 0, 1, 0) + IF(le.assigeffecdate_Total_ErrorCount > 0, 1, 0) + IF(le.origdotrecdate_Total_ErrorCount > 0, 1, 0) + IF(le.origdotcontractdate_Total_ErrorCount > 0, 1, 0) + IF(le.origlenderben_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assignorname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assignee_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mers_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrowername_ALLOW_ErrorCount > 0, 1, 0) + IF(le.apn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertyfulladd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertycity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertystate_Total_ErrorCount > 0, 1, 0) + IF(le.propertyzip_Total_ErrorCount > 0, 1, 0) + IF(le.propertyzip4_Total_ErrorCount > 0, 1, 0) + IF(le.pid_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.ln_filedate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ln_filedate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rectype_ENUM_ErrorCount > 0, 1, 0) + IF(le.documenttype_ENUM_ErrorCount > 0, 1, 0) + IF(le.fipscode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assigrecdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assigrecdate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.assigeffecdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assigeffecdate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.origdotrecdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.origdotrecdate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.origdotcontractdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.origdotcontractdate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.origlenderben_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assignorname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assignee_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mers_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrowername_ALLOW_ErrorCount > 0, 1, 0) + IF(le.apn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertyfulladd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertycity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertystate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertystate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.propertyzip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertyzip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.propertyzip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propertyzip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.pid_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ln_filedate_Invalid,le.rectype_Invalid,le.documenttype_Invalid,le.fipscode_Invalid,le.assigrecdate_Invalid,le.assigeffecdate_Invalid,le.origdotrecdate_Invalid,le.origdotcontractdate_Invalid,le.origlenderben_Invalid,le.assignorname_Invalid,le.assignee_Invalid,le.mers_Invalid,le.borrowername_Invalid,le.apn_Invalid,le.propertyfulladd_Invalid,le.propertycity_Invalid,le.propertystate_Invalid,le.propertyzip_Invalid,le.propertyzip4_Invalid,le.pid_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_ln_filedate(le.ln_filedate_Invalid),Fields.InvalidMessage_rectype(le.rectype_Invalid),Fields.InvalidMessage_documenttype(le.documenttype_Invalid),Fields.InvalidMessage_fipscode(le.fipscode_Invalid),Fields.InvalidMessage_assigrecdate(le.assigrecdate_Invalid),Fields.InvalidMessage_assigeffecdate(le.assigeffecdate_Invalid),Fields.InvalidMessage_origdotrecdate(le.origdotrecdate_Invalid),Fields.InvalidMessage_origdotcontractdate(le.origdotcontractdate_Invalid),Fields.InvalidMessage_origlenderben(le.origlenderben_Invalid),Fields.InvalidMessage_assignorname(le.assignorname_Invalid),Fields.InvalidMessage_assignee(le.assignee_Invalid),Fields.InvalidMessage_mers(le.mers_Invalid),Fields.InvalidMessage_borrowername(le.borrowername_Invalid),Fields.InvalidMessage_apn(le.apn_Invalid),Fields.InvalidMessage_propertyfulladd(le.propertyfulladd_Invalid),Fields.InvalidMessage_propertycity(le.propertycity_Invalid),Fields.InvalidMessage_propertystate(le.propertystate_Invalid),Fields.InvalidMessage_propertyzip(le.propertyzip_Invalid),Fields.InvalidMessage_propertyzip4(le.propertyzip4_Invalid),Fields.InvalidMessage_pid(le.pid_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ln_filedate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rectype_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.documenttype_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.fipscode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.assigrecdate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.assigeffecdate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.origdotrecdate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.origdotcontractdate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.origlenderben_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.assignorname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.assignee_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mers_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.borrowername_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.apn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.propertyfulladd_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.propertycity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.propertystate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.propertyzip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.propertyzip4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.pid_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ln_filedate','rectype','documenttype','fipscode','assigrecdate','assigeffecdate','origdotrecdate','origdotcontractdate','origlenderben','assignorname','assignee','mers','borrowername','apn','propertyfulladd','propertycity','propertystate','propertyzip','propertyzip4','pid','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','Invalid_RecType','Invalid_DocType','invalid_number','invalid_date','invalid_date','invalid_date','invalid_date','invalid_name','invalid_name','invalid_name','invalid_mers','invalid_name','invalid_apn','invalid_AlphaNum','invalid_AlphaNum','invalid_state','invalid_zip','invalid_zip','invalid_number','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.ln_filedate,(SALT311.StrType)le.rectype,(SALT311.StrType)le.documenttype,(SALT311.StrType)le.fipscode,(SALT311.StrType)le.assigrecdate,(SALT311.StrType)le.assigeffecdate,(SALT311.StrType)le.origdotrecdate,(SALT311.StrType)le.origdotcontractdate,(SALT311.StrType)le.origlenderben,(SALT311.StrType)le.assignorname,(SALT311.StrType)le.assignee,(SALT311.StrType)le.mers,(SALT311.StrType)le.borrowername,(SALT311.StrType)le.apn,(SALT311.StrType)le.propertyfulladd,(SALT311.StrType)le.propertycity,(SALT311.StrType)le.propertystate,(SALT311.StrType)le.propertyzip,(SALT311.StrType)le.propertyzip4,(SALT311.StrType)le.pid,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,20,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_BKMortgage_Assignments) prevDS = DATASET([], Layout_BKMortgage_Assignments), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ln_filedate:invalid_date:ALLOW','ln_filedate:invalid_date:LENGTHS'
          ,'rectype:Invalid_RecType:ENUM'
          ,'documenttype:Invalid_DocType:ENUM'
          ,'fipscode:invalid_number:ALLOW'
          ,'assigrecdate:invalid_date:ALLOW','assigrecdate:invalid_date:LENGTHS'
          ,'assigeffecdate:invalid_date:ALLOW','assigeffecdate:invalid_date:LENGTHS'
          ,'origdotrecdate:invalid_date:ALLOW','origdotrecdate:invalid_date:LENGTHS'
          ,'origdotcontractdate:invalid_date:ALLOW','origdotcontractdate:invalid_date:LENGTHS'
          ,'origlenderben:invalid_name:ALLOW'
          ,'assignorname:invalid_name:ALLOW'
          ,'assignee:invalid_name:ALLOW'
          ,'mers:invalid_mers:ALLOW'
          ,'borrowername:invalid_name:ALLOW'
          ,'apn:invalid_apn:ALLOW'
          ,'propertyfulladd:invalid_AlphaNum:ALLOW'
          ,'propertycity:invalid_AlphaNum:ALLOW'
          ,'propertystate:invalid_state:ALLOW','propertystate:invalid_state:LENGTHS'
          ,'propertyzip:invalid_zip:ALLOW','propertyzip:invalid_zip:LENGTHS'
          ,'propertyzip4:invalid_zip:ALLOW','propertyzip4:invalid_zip:LENGTHS'
          ,'pid:invalid_number:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_ln_filedate(1),Fields.InvalidMessage_ln_filedate(2)
          ,Fields.InvalidMessage_rectype(1)
          ,Fields.InvalidMessage_documenttype(1)
          ,Fields.InvalidMessage_fipscode(1)
          ,Fields.InvalidMessage_assigrecdate(1),Fields.InvalidMessage_assigrecdate(2)
          ,Fields.InvalidMessage_assigeffecdate(1),Fields.InvalidMessage_assigeffecdate(2)
          ,Fields.InvalidMessage_origdotrecdate(1),Fields.InvalidMessage_origdotrecdate(2)
          ,Fields.InvalidMessage_origdotcontractdate(1),Fields.InvalidMessage_origdotcontractdate(2)
          ,Fields.InvalidMessage_origlenderben(1)
          ,Fields.InvalidMessage_assignorname(1)
          ,Fields.InvalidMessage_assignee(1)
          ,Fields.InvalidMessage_mers(1)
          ,Fields.InvalidMessage_borrowername(1)
          ,Fields.InvalidMessage_apn(1)
          ,Fields.InvalidMessage_propertyfulladd(1)
          ,Fields.InvalidMessage_propertycity(1)
          ,Fields.InvalidMessage_propertystate(1),Fields.InvalidMessage_propertystate(2)
          ,Fields.InvalidMessage_propertyzip(1),Fields.InvalidMessage_propertyzip(2)
          ,Fields.InvalidMessage_propertyzip4(1),Fields.InvalidMessage_propertyzip4(2)
          ,Fields.InvalidMessage_pid(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.ln_filedate_ALLOW_ErrorCount,le.ln_filedate_LENGTHS_ErrorCount
          ,le.rectype_ENUM_ErrorCount
          ,le.documenttype_ENUM_ErrorCount
          ,le.fipscode_ALLOW_ErrorCount
          ,le.assigrecdate_ALLOW_ErrorCount,le.assigrecdate_LENGTHS_ErrorCount
          ,le.assigeffecdate_ALLOW_ErrorCount,le.assigeffecdate_LENGTHS_ErrorCount
          ,le.origdotrecdate_ALLOW_ErrorCount,le.origdotrecdate_LENGTHS_ErrorCount
          ,le.origdotcontractdate_ALLOW_ErrorCount,le.origdotcontractdate_LENGTHS_ErrorCount
          ,le.origlenderben_ALLOW_ErrorCount
          ,le.assignorname_ALLOW_ErrorCount
          ,le.assignee_ALLOW_ErrorCount
          ,le.mers_ALLOW_ErrorCount
          ,le.borrowername_ALLOW_ErrorCount
          ,le.apn_ALLOW_ErrorCount
          ,le.propertyfulladd_ALLOW_ErrorCount
          ,le.propertycity_ALLOW_ErrorCount
          ,le.propertystate_ALLOW_ErrorCount,le.propertystate_LENGTHS_ErrorCount
          ,le.propertyzip_ALLOW_ErrorCount,le.propertyzip_LENGTHS_ErrorCount
          ,le.propertyzip4_ALLOW_ErrorCount,le.propertyzip4_LENGTHS_ErrorCount
          ,le.pid_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.ln_filedate_ALLOW_ErrorCount,le.ln_filedate_LENGTHS_ErrorCount
          ,le.rectype_ENUM_ErrorCount
          ,le.documenttype_ENUM_ErrorCount
          ,le.fipscode_ALLOW_ErrorCount
          ,le.assigrecdate_ALLOW_ErrorCount,le.assigrecdate_LENGTHS_ErrorCount
          ,le.assigeffecdate_ALLOW_ErrorCount,le.assigeffecdate_LENGTHS_ErrorCount
          ,le.origdotrecdate_ALLOW_ErrorCount,le.origdotrecdate_LENGTHS_ErrorCount
          ,le.origdotcontractdate_ALLOW_ErrorCount,le.origdotcontractdate_LENGTHS_ErrorCount
          ,le.origlenderben_ALLOW_ErrorCount
          ,le.assignorname_ALLOW_ErrorCount
          ,le.assignee_ALLOW_ErrorCount
          ,le.mers_ALLOW_ErrorCount
          ,le.borrowername_ALLOW_ErrorCount
          ,le.apn_ALLOW_ErrorCount
          ,le.propertyfulladd_ALLOW_ErrorCount
          ,le.propertycity_ALLOW_ErrorCount
          ,le.propertystate_ALLOW_ErrorCount,le.propertystate_LENGTHS_ErrorCount
          ,le.propertyzip_ALLOW_ErrorCount,le.propertyzip_LENGTHS_ErrorCount
          ,le.propertyzip4_ALLOW_ErrorCount,le.propertyzip4_LENGTHS_ErrorCount
          ,le.pid_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_BKMortgage_Assignments));
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
          ,'ln_filedate:' + getFieldTypeText(h.ln_filedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bk_infile_type:' + getFieldTypeText(h.bk_infile_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rectype:' + getFieldTypeText(h.rectype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'documenttype:' + getFieldTypeText(h.documenttype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fipscode:' + getFieldTypeText(h.fipscode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mersindicator:' + getFieldTypeText(h.mersindicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mainaddendum:' + getFieldTypeText(h.mainaddendum) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assigrecdate:' + getFieldTypeText(h.assigrecdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assigeffecdate:' + getFieldTypeText(h.assigeffecdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assigdoc:' + getFieldTypeText(h.assigdoc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assigbk:' + getFieldTypeText(h.assigbk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assigpg:' + getFieldTypeText(h.assigpg) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'multiplepageimage:' + getFieldTypeText(h.multiplepageimage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bkfsimageid:' + getFieldTypeText(h.bkfsimageid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'origdotrecdate:' + getFieldTypeText(h.origdotrecdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'origdotcontractdate:' + getFieldTypeText(h.origdotcontractdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'origdotdoc:' + getFieldTypeText(h.origdotdoc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'origdotbk:' + getFieldTypeText(h.origdotbk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'origdotpg:' + getFieldTypeText(h.origdotpg) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'origlenderben:' + getFieldTypeText(h.origlenderben) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'origloanamnt:' + getFieldTypeText(h.origloanamnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assignorname:' + getFieldTypeText(h.assignorname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loannumber:' + getFieldTypeText(h.loannumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assignee:' + getFieldTypeText(h.assignee) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mers:' + getFieldTypeText(h.mers) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mersvalidation:' + getFieldTypeText(h.mersvalidation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assigneepool:' + getFieldTypeText(h.assigneepool) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mspsvcrloan:' + getFieldTypeText(h.mspsvcrloan) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'borrowername:' + getFieldTypeText(h.borrowername) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'apn:' + getFieldTypeText(h.apn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'multiapncode:' + getFieldTypeText(h.multiapncode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'taxacctid:' + getFieldTypeText(h.taxacctid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'propertyfulladd:' + getFieldTypeText(h.propertyfulladd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'propertyunit:' + getFieldTypeText(h.propertyunit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'propertycity:' + getFieldTypeText(h.propertycity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'propertystate:' + getFieldTypeText(h.propertystate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'propertyzip:' + getFieldTypeText(h.propertyzip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'propertyzip4:' + getFieldTypeText(h.propertyzip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dataentrydate:' + getFieldTypeText(h.dataentrydate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dataentryopercode:' + getFieldTypeText(h.dataentryopercode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendorsourcecode:' + getFieldTypeText(h.vendorsourcecode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hids_recordingflag:' + getFieldTypeText(h.hids_recordingflag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hids_docnumber:' + getFieldTypeText(h.hids_docnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transfercertificateoftitle:' + getFieldTypeText(h.transfercertificateoftitle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hi_condo_cpr_hpr:' + getFieldTypeText(h.hi_condo_cpr_hpr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hi_situs_unit_number:' + getFieldTypeText(h.hi_situs_unit_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hids_previous_docnumber:' + getFieldTypeText(h.hids_previous_docnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prevtransfercertificateoftitle:' + getFieldTypeText(h.prevtransfercertificateoftitle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pid:' + getFieldTypeText(h.pid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'matchedororphan:' + getFieldTypeText(h.matchedororphan) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deed_pid:' + getFieldTypeText(h.deed_pid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sam_pid:' + getFieldTypeText(h.sam_pid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorparcelnumber_matched:' + getFieldTypeText(h.assessorparcelnumber_matched) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorpropertyfulladd:' + getFieldTypeText(h.assessorpropertyfulladd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorpropertyunittype:' + getFieldTypeText(h.assessorpropertyunittype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorpropertyunit:' + getFieldTypeText(h.assessorpropertyunit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorpropertycity:' + getFieldTypeText(h.assessorpropertycity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorpropertystate:' + getFieldTypeText(h.assessorpropertystate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorpropertyzip:' + getFieldTypeText(h.assessorpropertyzip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorpropertyzip4:' + getFieldTypeText(h.assessorpropertyzip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessorpropertyaddrsource:' + getFieldTypeText(h.assessorpropertyaddrsource) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_file_name:' + getFieldTypeText(h.raw_file_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_ln_filedate_cnt
          ,le.populated_bk_infile_type_cnt
          ,le.populated_rectype_cnt
          ,le.populated_documenttype_cnt
          ,le.populated_fipscode_cnt
          ,le.populated_mersindicator_cnt
          ,le.populated_mainaddendum_cnt
          ,le.populated_assigrecdate_cnt
          ,le.populated_assigeffecdate_cnt
          ,le.populated_assigdoc_cnt
          ,le.populated_assigbk_cnt
          ,le.populated_assigpg_cnt
          ,le.populated_multiplepageimage_cnt
          ,le.populated_bkfsimageid_cnt
          ,le.populated_origdotrecdate_cnt
          ,le.populated_origdotcontractdate_cnt
          ,le.populated_origdotdoc_cnt
          ,le.populated_origdotbk_cnt
          ,le.populated_origdotpg_cnt
          ,le.populated_origlenderben_cnt
          ,le.populated_origloanamnt_cnt
          ,le.populated_assignorname_cnt
          ,le.populated_loannumber_cnt
          ,le.populated_assignee_cnt
          ,le.populated_mers_cnt
          ,le.populated_mersvalidation_cnt
          ,le.populated_assigneepool_cnt
          ,le.populated_mspsvcrloan_cnt
          ,le.populated_borrowername_cnt
          ,le.populated_apn_cnt
          ,le.populated_multiapncode_cnt
          ,le.populated_taxacctid_cnt
          ,le.populated_propertyfulladd_cnt
          ,le.populated_propertyunit_cnt
          ,le.populated_propertycity_cnt
          ,le.populated_propertystate_cnt
          ,le.populated_propertyzip_cnt
          ,le.populated_propertyzip4_cnt
          ,le.populated_dataentrydate_cnt
          ,le.populated_dataentryopercode_cnt
          ,le.populated_vendorsourcecode_cnt
          ,le.populated_hids_recordingflag_cnt
          ,le.populated_hids_docnumber_cnt
          ,le.populated_transfercertificateoftitle_cnt
          ,le.populated_hi_condo_cpr_hpr_cnt
          ,le.populated_hi_situs_unit_number_cnt
          ,le.populated_hids_previous_docnumber_cnt
          ,le.populated_prevtransfercertificateoftitle_cnt
          ,le.populated_pid_cnt
          ,le.populated_matchedororphan_cnt
          ,le.populated_deed_pid_cnt
          ,le.populated_sam_pid_cnt
          ,le.populated_assessorparcelnumber_matched_cnt
          ,le.populated_assessorpropertyfulladd_cnt
          ,le.populated_assessorpropertyunittype_cnt
          ,le.populated_assessorpropertyunit_cnt
          ,le.populated_assessorpropertycity_cnt
          ,le.populated_assessorpropertystate_cnt
          ,le.populated_assessorpropertyzip_cnt
          ,le.populated_assessorpropertyzip4_cnt
          ,le.populated_assessorpropertyaddrsource_cnt
          ,le.populated_raw_file_name_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_ln_filedate_pcnt
          ,le.populated_bk_infile_type_pcnt
          ,le.populated_rectype_pcnt
          ,le.populated_documenttype_pcnt
          ,le.populated_fipscode_pcnt
          ,le.populated_mersindicator_pcnt
          ,le.populated_mainaddendum_pcnt
          ,le.populated_assigrecdate_pcnt
          ,le.populated_assigeffecdate_pcnt
          ,le.populated_assigdoc_pcnt
          ,le.populated_assigbk_pcnt
          ,le.populated_assigpg_pcnt
          ,le.populated_multiplepageimage_pcnt
          ,le.populated_bkfsimageid_pcnt
          ,le.populated_origdotrecdate_pcnt
          ,le.populated_origdotcontractdate_pcnt
          ,le.populated_origdotdoc_pcnt
          ,le.populated_origdotbk_pcnt
          ,le.populated_origdotpg_pcnt
          ,le.populated_origlenderben_pcnt
          ,le.populated_origloanamnt_pcnt
          ,le.populated_assignorname_pcnt
          ,le.populated_loannumber_pcnt
          ,le.populated_assignee_pcnt
          ,le.populated_mers_pcnt
          ,le.populated_mersvalidation_pcnt
          ,le.populated_assigneepool_pcnt
          ,le.populated_mspsvcrloan_pcnt
          ,le.populated_borrowername_pcnt
          ,le.populated_apn_pcnt
          ,le.populated_multiapncode_pcnt
          ,le.populated_taxacctid_pcnt
          ,le.populated_propertyfulladd_pcnt
          ,le.populated_propertyunit_pcnt
          ,le.populated_propertycity_pcnt
          ,le.populated_propertystate_pcnt
          ,le.populated_propertyzip_pcnt
          ,le.populated_propertyzip4_pcnt
          ,le.populated_dataentrydate_pcnt
          ,le.populated_dataentryopercode_pcnt
          ,le.populated_vendorsourcecode_pcnt
          ,le.populated_hids_recordingflag_pcnt
          ,le.populated_hids_docnumber_pcnt
          ,le.populated_transfercertificateoftitle_pcnt
          ,le.populated_hi_condo_cpr_hpr_pcnt
          ,le.populated_hi_situs_unit_number_pcnt
          ,le.populated_hids_previous_docnumber_pcnt
          ,le.populated_prevtransfercertificateoftitle_pcnt
          ,le.populated_pid_pcnt
          ,le.populated_matchedororphan_pcnt
          ,le.populated_deed_pid_pcnt
          ,le.populated_sam_pid_pcnt
          ,le.populated_assessorparcelnumber_matched_pcnt
          ,le.populated_assessorpropertyfulladd_pcnt
          ,le.populated_assessorpropertyunittype_pcnt
          ,le.populated_assessorpropertyunit_pcnt
          ,le.populated_assessorpropertycity_pcnt
          ,le.populated_assessorpropertystate_pcnt
          ,le.populated_assessorpropertyzip_pcnt
          ,le.populated_assessorpropertyzip4_pcnt
          ,le.populated_assessorpropertyaddrsource_pcnt
          ,le.populated_raw_file_name_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,62,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_BKMortgage_Assignments));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),62,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_BKMortgage_Assignments) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_BKMortgage_Assignments, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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

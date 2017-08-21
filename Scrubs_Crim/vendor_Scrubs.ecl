IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT vendor_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(vendor_Layout_crim)
    UNSIGNED1 recordid_Invalid;
    UNSIGNED1 statecode_Invalid;
    UNSIGNED1 caseid_Invalid;
    UNSIGNED1 casestatusdate_Invalid;
    UNSIGNED1 fileddate_Invalid;
    UNSIGNED1 offensedate_Invalid;
    UNSIGNED1 dispositiondate_Invalid;
    UNSIGNED1 finaloffensedate_Invalid;
    UNSIGNED1 victimunder18_Invalid;
    UNSIGNED1 initialpleadate_Invalid;
    UNSIGNED1 finalrulingdate_Invalid;
    UNSIGNED1 appealdate_Invalid;
    UNSIGNED1 courtdate_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 deceaseddate_Invalid;
    UNSIGNED1 sexoffenderregexpirationdate_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(vendor_Layout_crim)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(vendor_Layout_crim) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.recordid_Invalid := vendor_Fields.InValid_recordid((SALT33.StrType)le.recordid);
    SELF.statecode_Invalid := vendor_Fields.InValid_statecode((SALT33.StrType)le.statecode);
    SELF.caseid_Invalid := vendor_Fields.InValid_caseid((SALT33.StrType)le.caseid);
    SELF.casestatusdate_Invalid := vendor_Fields.InValid_casestatusdate((SALT33.StrType)le.casestatusdate);
    SELF.fileddate_Invalid := vendor_Fields.InValid_fileddate((SALT33.StrType)le.fileddate);
    SELF.offensedate_Invalid := vendor_Fields.InValid_offensedate((SALT33.StrType)le.offensedate);
    SELF.dispositiondate_Invalid := vendor_Fields.InValid_dispositiondate((SALT33.StrType)le.dispositiondate);
    SELF.finaloffensedate_Invalid := vendor_Fields.InValid_finaloffensedate((SALT33.StrType)le.finaloffensedate);
    SELF.victimunder18_Invalid := vendor_Fields.InValid_victimunder18((SALT33.StrType)le.victimunder18);
    SELF.initialpleadate_Invalid := vendor_Fields.InValid_initialpleadate((SALT33.StrType)le.initialpleadate);
    SELF.finalrulingdate_Invalid := vendor_Fields.InValid_finalrulingdate((SALT33.StrType)le.finalrulingdate);
    SELF.appealdate_Invalid := vendor_Fields.InValid_appealdate((SALT33.StrType)le.appealdate);
    SELF.courtdate_Invalid := vendor_Fields.InValid_courtdate((SALT33.StrType)le.courtdate);
    SELF.zip_Invalid := vendor_Fields.InValid_zip((SALT33.StrType)le.zip);
    SELF.deceaseddate_Invalid := vendor_Fields.InValid_deceaseddate((SALT33.StrType)le.deceaseddate);
    SELF.sexoffenderregexpirationdate_Invalid := vendor_Fields.InValid_sexoffenderregexpirationdate((SALT33.StrType)le.sexoffenderregexpirationdate);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),vendor_Layout_crim);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.recordid_Invalid << 0 ) + ( le.statecode_Invalid << 1 ) + ( le.caseid_Invalid << 2 ) + ( le.casestatusdate_Invalid << 3 ) + ( le.fileddate_Invalid << 4 ) + ( le.offensedate_Invalid << 5 ) + ( le.dispositiondate_Invalid << 6 ) + ( le.finaloffensedate_Invalid << 7 ) + ( le.victimunder18_Invalid << 8 ) + ( le.initialpleadate_Invalid << 9 ) + ( le.finalrulingdate_Invalid << 10 ) + ( le.appealdate_Invalid << 11 ) + ( le.courtdate_Invalid << 12 ) + ( le.zip_Invalid << 13 ) + ( le.deceaseddate_Invalid << 14 ) + ( le.sexoffenderregexpirationdate_Invalid << 15 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,vendor_Layout_crim);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.recordid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.statecode_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.caseid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.casestatusdate_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.fileddate_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.offensedate_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.dispositiondate_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.finaloffensedate_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.victimunder18_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.initialpleadate_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.finalrulingdate_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.appealdate_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.courtdate_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.deceaseddate_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.sexoffenderregexpirationdate_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    recordid_ALLOW_ErrorCount := COUNT(GROUP,h.recordid_Invalid=1);
    statecode_ALLOW_ErrorCount := COUNT(GROUP,h.statecode_Invalid=1);
    caseid_LENGTH_ErrorCount := COUNT(GROUP,h.caseid_Invalid=1);
    casestatusdate_CUSTOM_ErrorCount := COUNT(GROUP,h.casestatusdate_Invalid=1);
    fileddate_CUSTOM_ErrorCount := COUNT(GROUP,h.fileddate_Invalid=1);
    offensedate_CUSTOM_ErrorCount := COUNT(GROUP,h.offensedate_Invalid=1);
    dispositiondate_CUSTOM_ErrorCount := COUNT(GROUP,h.dispositiondate_Invalid=1);
    finaloffensedate_CUSTOM_ErrorCount := COUNT(GROUP,h.finaloffensedate_Invalid=1);
    victimunder18_ENUM_ErrorCount := COUNT(GROUP,h.victimunder18_Invalid=1);
    initialpleadate_CUSTOM_ErrorCount := COUNT(GROUP,h.initialpleadate_Invalid=1);
    finalrulingdate_CUSTOM_ErrorCount := COUNT(GROUP,h.finalrulingdate_Invalid=1);
    appealdate_CUSTOM_ErrorCount := COUNT(GROUP,h.appealdate_Invalid=1);
    courtdate_CUSTOM_ErrorCount := COUNT(GROUP,h.courtdate_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    deceaseddate_CUSTOM_ErrorCount := COUNT(GROUP,h.deceaseddate_Invalid=1);
    sexoffenderregexpirationdate_CUSTOM_ErrorCount := COUNT(GROUP,h.sexoffenderregexpirationdate_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.recordid_Invalid,le.statecode_Invalid,le.caseid_Invalid,le.casestatusdate_Invalid,le.fileddate_Invalid,le.offensedate_Invalid,le.dispositiondate_Invalid,le.finaloffensedate_Invalid,le.victimunder18_Invalid,le.initialpleadate_Invalid,le.finalrulingdate_Invalid,le.appealdate_Invalid,le.courtdate_Invalid,le.zip_Invalid,le.deceaseddate_Invalid,le.sexoffenderregexpirationdate_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,vendor_Fields.InvalidMessage_recordid(le.recordid_Invalid),vendor_Fields.InvalidMessage_statecode(le.statecode_Invalid),vendor_Fields.InvalidMessage_caseid(le.caseid_Invalid),vendor_Fields.InvalidMessage_casestatusdate(le.casestatusdate_Invalid),vendor_Fields.InvalidMessage_fileddate(le.fileddate_Invalid),vendor_Fields.InvalidMessage_offensedate(le.offensedate_Invalid),vendor_Fields.InvalidMessage_dispositiondate(le.dispositiondate_Invalid),vendor_Fields.InvalidMessage_finaloffensedate(le.finaloffensedate_Invalid),vendor_Fields.InvalidMessage_victimunder18(le.victimunder18_Invalid),vendor_Fields.InvalidMessage_initialpleadate(le.initialpleadate_Invalid),vendor_Fields.InvalidMessage_finalrulingdate(le.finalrulingdate_Invalid),vendor_Fields.InvalidMessage_appealdate(le.appealdate_Invalid),vendor_Fields.InvalidMessage_courtdate(le.courtdate_Invalid),vendor_Fields.InvalidMessage_zip(le.zip_Invalid),vendor_Fields.InvalidMessage_deceaseddate(le.deceaseddate_Invalid),vendor_Fields.InvalidMessage_sexoffenderregexpirationdate(le.sexoffenderregexpirationdate_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.recordid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statecode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.caseid_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.casestatusdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fileddate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.offensedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dispositiondate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.finaloffensedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.victimunder18_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.initialpleadate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.finalrulingdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.appealdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.courtdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.deceaseddate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sexoffenderregexpirationdate_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'recordid','statecode','caseid','casestatusdate','fileddate','offensedate','dispositiondate','finaloffensedate','victimunder18','initialpleadate','finalrulingdate','appealdate','courtdate','zip','deceaseddate','sexoffenderregexpirationdate','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Record_ID','Invalid_Char','Non_Blank','Invalid_Current_Date','Invalid_Current_Date','Invalid_Current_Date','Invalid_Current_Date','Invalid_Current_Date','Invalid_VictimUnder18','Invalid_Current_Date','Invalid_Current_Date','Invalid_Current_Date','Invalid_Current_Date','Invalid_Num','Invalid_Current_Date','Invalid_Current_Date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.recordid,(SALT33.StrType)le.statecode,(SALT33.StrType)le.caseid,(SALT33.StrType)le.casestatusdate,(SALT33.StrType)le.fileddate,(SALT33.StrType)le.offensedate,(SALT33.StrType)le.dispositiondate,(SALT33.StrType)le.finaloffensedate,(SALT33.StrType)le.victimunder18,(SALT33.StrType)le.initialpleadate,(SALT33.StrType)le.finalrulingdate,(SALT33.StrType)le.appealdate,(SALT33.StrType)le.courtdate,(SALT33.StrType)le.zip,(SALT33.StrType)le.deceaseddate,(SALT33.StrType)le.sexoffenderregexpirationdate,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,16,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'recordid:Invalid_Record_ID:ALLOW'
          ,'statecode:Invalid_Char:ALLOW'
          ,'caseid:Non_Blank:LENGTH'
          ,'casestatusdate:Invalid_Current_Date:CUSTOM'
          ,'fileddate:Invalid_Current_Date:CUSTOM'
          ,'offensedate:Invalid_Current_Date:CUSTOM'
          ,'dispositiondate:Invalid_Current_Date:CUSTOM'
          ,'finaloffensedate:Invalid_Current_Date:CUSTOM'
          ,'victimunder18:Invalid_VictimUnder18:ENUM'
          ,'initialpleadate:Invalid_Current_Date:CUSTOM'
          ,'finalrulingdate:Invalid_Current_Date:CUSTOM'
          ,'appealdate:Invalid_Current_Date:CUSTOM'
          ,'courtdate:Invalid_Current_Date:CUSTOM'
          ,'zip:Invalid_Num:ALLOW'
          ,'deceaseddate:Invalid_Current_Date:CUSTOM'
          ,'sexoffenderregexpirationdate:Invalid_Current_Date:CUSTOM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,vendor_Fields.InvalidMessage_recordid(1)
          ,vendor_Fields.InvalidMessage_statecode(1)
          ,vendor_Fields.InvalidMessage_caseid(1)
          ,vendor_Fields.InvalidMessage_casestatusdate(1)
          ,vendor_Fields.InvalidMessage_fileddate(1)
          ,vendor_Fields.InvalidMessage_offensedate(1)
          ,vendor_Fields.InvalidMessage_dispositiondate(1)
          ,vendor_Fields.InvalidMessage_finaloffensedate(1)
          ,vendor_Fields.InvalidMessage_victimunder18(1)
          ,vendor_Fields.InvalidMessage_initialpleadate(1)
          ,vendor_Fields.InvalidMessage_finalrulingdate(1)
          ,vendor_Fields.InvalidMessage_appealdate(1)
          ,vendor_Fields.InvalidMessage_courtdate(1)
          ,vendor_Fields.InvalidMessage_zip(1)
          ,vendor_Fields.InvalidMessage_deceaseddate(1)
          ,vendor_Fields.InvalidMessage_sexoffenderregexpirationdate(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.caseid_LENGTH_ErrorCount
          ,le.casestatusdate_CUSTOM_ErrorCount
          ,le.fileddate_CUSTOM_ErrorCount
          ,le.offensedate_CUSTOM_ErrorCount
          ,le.dispositiondate_CUSTOM_ErrorCount
          ,le.finaloffensedate_CUSTOM_ErrorCount
          ,le.victimunder18_ENUM_ErrorCount
          ,le.initialpleadate_CUSTOM_ErrorCount
          ,le.finalrulingdate_CUSTOM_ErrorCount
          ,le.appealdate_CUSTOM_ErrorCount
          ,le.courtdate_CUSTOM_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.deceaseddate_CUSTOM_ErrorCount
          ,le.sexoffenderregexpirationdate_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.caseid_LENGTH_ErrorCount
          ,le.casestatusdate_CUSTOM_ErrorCount
          ,le.fileddate_CUSTOM_ErrorCount
          ,le.offensedate_CUSTOM_ErrorCount
          ,le.dispositiondate_CUSTOM_ErrorCount
          ,le.finaloffensedate_CUSTOM_ErrorCount
          ,le.victimunder18_ENUM_ErrorCount
          ,le.initialpleadate_CUSTOM_ErrorCount
          ,le.finalrulingdate_CUSTOM_ErrorCount
          ,le.appealdate_CUSTOM_ErrorCount
          ,le.courtdate_CUSTOM_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.deceaseddate_CUSTOM_ErrorCount
          ,le.sexoffenderregexpirationdate_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,16,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT33.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT33.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;

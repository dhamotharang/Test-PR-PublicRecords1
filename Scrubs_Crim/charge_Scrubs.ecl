IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT charge_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(charge_Layout_crim)
    UNSIGNED1 recordid_Invalid;
    UNSIGNED1 statecode_Invalid;
    UNSIGNED1 caseid_Invalid;
    UNSIGNED1 arrestdate_Invalid;
    UNSIGNED1 bookingdate_Invalid;
    UNSIGNED1 custodydate_Invalid;
    UNSIGNED1 initialchargedate_Invalid;
    UNSIGNED1 chargedisposeddate_Invalid;
    UNSIGNED1 amendedchargedate_Invalid;
    UNSIGNED1 sourceid_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(charge_Layout_crim)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(charge_Layout_crim) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.recordid_Invalid := charge_Fields.InValid_recordid((SALT33.StrType)le.recordid);
    SELF.statecode_Invalid := charge_Fields.InValid_statecode((SALT33.StrType)le.statecode);
    SELF.caseid_Invalid := charge_Fields.InValid_caseid((SALT33.StrType)le.caseid);
    SELF.arrestdate_Invalid := charge_Fields.InValid_arrestdate((SALT33.StrType)le.arrestdate);
    SELF.bookingdate_Invalid := charge_Fields.InValid_bookingdate((SALT33.StrType)le.bookingdate);
    SELF.custodydate_Invalid := charge_Fields.InValid_custodydate((SALT33.StrType)le.custodydate);
    SELF.initialchargedate_Invalid := charge_Fields.InValid_initialchargedate((SALT33.StrType)le.initialchargedate);
    SELF.chargedisposeddate_Invalid := charge_Fields.InValid_chargedisposeddate((SALT33.StrType)le.chargedisposeddate);
    SELF.amendedchargedate_Invalid := charge_Fields.InValid_amendedchargedate((SALT33.StrType)le.amendedchargedate);
    SELF.sourceid_Invalid := charge_Fields.InValid_sourceid((SALT33.StrType)le.sourceid);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),charge_Layout_crim);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.recordid_Invalid << 0 ) + ( le.statecode_Invalid << 1 ) + ( le.caseid_Invalid << 2 ) + ( le.arrestdate_Invalid << 3 ) + ( le.bookingdate_Invalid << 4 ) + ( le.custodydate_Invalid << 5 ) + ( le.initialchargedate_Invalid << 6 ) + ( le.chargedisposeddate_Invalid << 7 ) + ( le.amendedchargedate_Invalid << 8 ) + ( le.sourceid_Invalid << 9 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,charge_Layout_crim);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.recordid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.statecode_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.caseid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.arrestdate_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.bookingdate_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.custodydate_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.initialchargedate_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.chargedisposeddate_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.amendedchargedate_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.sourceid_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.vendor;
    TotalCnt := COUNT(GROUP); // Number of records in total
    recordid_ALLOW_ErrorCount := COUNT(GROUP,h.recordid_Invalid=1);
    statecode_ALLOW_ErrorCount := COUNT(GROUP,h.statecode_Invalid=1);
    caseid_ALLOW_ErrorCount := COUNT(GROUP,h.caseid_Invalid=1);
    arrestdate_CUSTOM_ErrorCount := COUNT(GROUP,h.arrestdate_Invalid=1);
    bookingdate_CUSTOM_ErrorCount := COUNT(GROUP,h.bookingdate_Invalid=1);
    custodydate_CUSTOM_ErrorCount := COUNT(GROUP,h.custodydate_Invalid=1);
    initialchargedate_CUSTOM_ErrorCount := COUNT(GROUP,h.initialchargedate_Invalid=1);
    chargedisposeddate_CUSTOM_ErrorCount := COUNT(GROUP,h.chargedisposeddate_Invalid=1);
    amendedchargedate_CUSTOM_ErrorCount := COUNT(GROUP,h.amendedchargedate_Invalid=1);
    sourceid_ALLOW_ErrorCount := COUNT(GROUP,h.sourceid_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,vendor,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.vendor;
    UNSIGNED1 ErrNum := CHOOSE(c,le.recordid_Invalid,le.statecode_Invalid,le.caseid_Invalid,le.arrestdate_Invalid,le.bookingdate_Invalid,le.custodydate_Invalid,le.initialchargedate_Invalid,le.chargedisposeddate_Invalid,le.amendedchargedate_Invalid,le.sourceid_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,charge_Fields.InvalidMessage_recordid(le.recordid_Invalid),charge_Fields.InvalidMessage_statecode(le.statecode_Invalid),charge_Fields.InvalidMessage_caseid(le.caseid_Invalid),charge_Fields.InvalidMessage_arrestdate(le.arrestdate_Invalid),charge_Fields.InvalidMessage_bookingdate(le.bookingdate_Invalid),charge_Fields.InvalidMessage_custodydate(le.custodydate_Invalid),charge_Fields.InvalidMessage_initialchargedate(le.initialchargedate_Invalid),charge_Fields.InvalidMessage_chargedisposeddate(le.chargedisposeddate_Invalid),charge_Fields.InvalidMessage_amendedchargedate(le.amendedchargedate_Invalid),charge_Fields.InvalidMessage_sourceid(le.sourceid_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.recordid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statecode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.caseid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.arrestdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bookingdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.custodydate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.initialchargedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.chargedisposeddate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.amendedchargedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sourceid_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'recordid','statecode','caseid','arrestdate','bookingdate','custodydate','initialchargedate','chargedisposeddate','amendedchargedate','sourceid','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Record_ID','Invalid_State','Invalid_Case_ID','Invalid_Current_Date','Invalid_Future_Date','Invalid_Current_Date','Invalid_Current_Date','Invalid_Future_Date','Invalid_Current_Date','Invalid_Source_ID','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.recordid,(SALT33.StrType)le.statecode,(SALT33.StrType)le.caseid,(SALT33.StrType)le.arrestdate,(SALT33.StrType)le.bookingdate,(SALT33.StrType)le.custodydate,(SALT33.StrType)le.initialchargedate,(SALT33.StrType)le.chargedisposeddate,(SALT33.StrType)le.amendedchargedate,(SALT33.StrType)le.sourceid,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.vendor;
      SELF.ruledesc := CHOOSE(c
          ,'recordid:Invalid_Record_ID:ALLOW'
          ,'statecode:Invalid_State:ALLOW'
          ,'caseid:Invalid_Case_ID:ALLOW'
          ,'arrestdate:Invalid_Current_Date:CUSTOM'
          ,'bookingdate:Invalid_Future_Date:CUSTOM'
          ,'custodydate:Invalid_Current_Date:CUSTOM'
          ,'initialchargedate:Invalid_Current_Date:CUSTOM'
          ,'chargedisposeddate:Invalid_Future_Date:CUSTOM'
          ,'amendedchargedate:Invalid_Current_Date:CUSTOM'
          ,'sourceid:Invalid_Source_ID:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,charge_Fields.InvalidMessage_recordid(1)
          ,charge_Fields.InvalidMessage_statecode(1)
          ,charge_Fields.InvalidMessage_caseid(1)
          ,charge_Fields.InvalidMessage_arrestdate(1)
          ,charge_Fields.InvalidMessage_bookingdate(1)
          ,charge_Fields.InvalidMessage_custodydate(1)
          ,charge_Fields.InvalidMessage_initialchargedate(1)
          ,charge_Fields.InvalidMessage_chargedisposeddate(1)
          ,charge_Fields.InvalidMessage_amendedchargedate(1)
          ,charge_Fields.InvalidMessage_sourceid(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.caseid_ALLOW_ErrorCount
          ,le.arrestdate_CUSTOM_ErrorCount
          ,le.bookingdate_CUSTOM_ErrorCount
          ,le.custodydate_CUSTOM_ErrorCount
          ,le.initialchargedate_CUSTOM_ErrorCount
          ,le.chargedisposeddate_CUSTOM_ErrorCount
          ,le.amendedchargedate_CUSTOM_ErrorCount
          ,le.sourceid_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.caseid_ALLOW_ErrorCount
          ,le.arrestdate_CUSTOM_ErrorCount
          ,le.bookingdate_CUSTOM_ErrorCount
          ,le.custodydate_CUSTOM_ErrorCount
          ,le.initialchargedate_CUSTOM_ErrorCount
          ,le.chargedisposeddate_CUSTOM_ErrorCount
          ,le.amendedchargedate_CUSTOM_ErrorCount
          ,le.sourceid_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,10,Into(LEFT,COUNTER));
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

IMPORT ut,SALT33;
IMPORT Scrubs,Scrubs_Crim; // Import modules for FieldTypes attribute definitions
EXPORT alias_doc_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(alias_doc_Layout_crim)
    UNSIGNED1 recordid_Invalid;
    UNSIGNED1 statecode_Invalid;
    UNSIGNED1 akaname_Invalid;
    UNSIGNED1 akalastname_Invalid;
    UNSIGNED1 akafirstname_Invalid;
    UNSIGNED1 akamiddlename_Invalid;
    UNSIGNED1 akadob_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(alias_doc_Layout_crim)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(alias_doc_Layout_crim) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.recordid_Invalid := alias_doc_Fields.InValid_recordid((SALT33.StrType)le.recordid);
    SELF.statecode_Invalid := alias_doc_Fields.InValid_statecode((SALT33.StrType)le.statecode);
    SELF.akaname_Invalid := alias_doc_Fields.InValid_akaname((SALT33.StrType)le.akaname);
    SELF.akalastname_Invalid := alias_doc_Fields.InValid_akalastname((SALT33.StrType)le.akalastname);
    SELF.akafirstname_Invalid := alias_doc_Fields.InValid_akafirstname((SALT33.StrType)le.akafirstname);
    SELF.akamiddlename_Invalid := alias_doc_Fields.InValid_akamiddlename((SALT33.StrType)le.akamiddlename);
    SELF.akadob_Invalid := alias_doc_Fields.InValid_akadob((SALT33.StrType)le.akadob);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),alias_doc_Layout_crim);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.recordid_Invalid << 0 ) + ( le.statecode_Invalid << 1 ) + ( le.akaname_Invalid << 2 ) + ( le.akalastname_Invalid << 3 ) + ( le.akafirstname_Invalid << 4 ) + ( le.akamiddlename_Invalid << 5 ) + ( le.akadob_Invalid << 6 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,alias_doc_Layout_crim);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.recordid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.statecode_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.akaname_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.akalastname_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.akafirstname_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.akamiddlename_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.akadob_Invalid := (le.ScrubsBits1 >> 6) & 1;
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
    akaname_CUSTOM_ErrorCount := COUNT(GROUP,h.akaname_Invalid=1);
    akalastname_CUSTOM_ErrorCount := COUNT(GROUP,h.akalastname_Invalid=1);
    akafirstname_CUSTOM_ErrorCount := COUNT(GROUP,h.akafirstname_Invalid=1);
    akamiddlename_CUSTOM_ErrorCount := COUNT(GROUP,h.akamiddlename_Invalid=1);
    akadob_CUSTOM_ErrorCount := COUNT(GROUP,h.akadob_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.recordid_Invalid,le.statecode_Invalid,le.akaname_Invalid,le.akalastname_Invalid,le.akafirstname_Invalid,le.akamiddlename_Invalid,le.akadob_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,alias_doc_Fields.InvalidMessage_recordid(le.recordid_Invalid),alias_doc_Fields.InvalidMessage_statecode(le.statecode_Invalid),alias_doc_Fields.InvalidMessage_akaname(le.akaname_Invalid),alias_doc_Fields.InvalidMessage_akalastname(le.akalastname_Invalid),alias_doc_Fields.InvalidMessage_akafirstname(le.akafirstname_Invalid),alias_doc_Fields.InvalidMessage_akamiddlename(le.akamiddlename_Invalid),alias_doc_Fields.InvalidMessage_akadob(le.akadob_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.recordid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statecode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.akaname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.akalastname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.akafirstname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.akamiddlename_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.akadob_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'recordid','statecode','akaname','akalastname','akafirstname','akamiddlename','akadob','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Record_ID','Invalid_State','AKA_Search','AKA_Search','AKA_Search','AKA_Search','Invalid_Date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.recordid,(SALT33.StrType)le.statecode,(SALT33.StrType)le.akaname,(SALT33.StrType)le.akalastname,(SALT33.StrType)le.akafirstname,(SALT33.StrType)le.akamiddlename,(SALT33.StrType)le.akadob,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,7,Into(LEFT,COUNTER));
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
          ,'akaname:AKA_Search:CUSTOM'
          ,'akalastname:AKA_Search:CUSTOM'
          ,'akafirstname:AKA_Search:CUSTOM'
          ,'akamiddlename:AKA_Search:CUSTOM'
          ,'akadob:Invalid_Date:CUSTOM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,alias_doc_Fields.InvalidMessage_recordid(1)
          ,alias_doc_Fields.InvalidMessage_statecode(1)
          ,alias_doc_Fields.InvalidMessage_akaname(1)
          ,alias_doc_Fields.InvalidMessage_akalastname(1)
          ,alias_doc_Fields.InvalidMessage_akafirstname(1)
          ,alias_doc_Fields.InvalidMessage_akamiddlename(1)
          ,alias_doc_Fields.InvalidMessage_akadob(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.akaname_CUSTOM_ErrorCount
          ,le.akalastname_CUSTOM_ErrorCount
          ,le.akafirstname_CUSTOM_ErrorCount
          ,le.akamiddlename_CUSTOM_ErrorCount
          ,le.akadob_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.akaname_CUSTOM_ErrorCount
          ,le.akalastname_CUSTOM_ErrorCount
          ,le.akafirstname_CUSTOM_ErrorCount
          ,le.akamiddlename_CUSTOM_ErrorCount
          ,le.akadob_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,7,Into(LEFT,COUNTER));
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

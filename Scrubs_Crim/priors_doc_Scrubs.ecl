IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT priors_doc_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(priors_doc_Layout_crim)
    UNSIGNED1 recordid_Invalid;
    UNSIGNED1 statecode_Invalid;
    UNSIGNED1 caseid_Invalid;
    UNSIGNED1 offensedate_Invalid;
    UNSIGNED1 dispositiondate_Invalid;
    UNSIGNED1 sentencedate_Invalid;
    UNSIGNED1 sentencebegindate_Invalid;
    UNSIGNED1 sentenceenddate_Invalid;
    UNSIGNED1 sentencemaxyears_Invalid;
    UNSIGNED1 sentencemaxmonths_Invalid;
    UNSIGNED1 sentencemaxdays_Invalid;
    UNSIGNED1 sentenceminyears_Invalid;
    UNSIGNED1 sentenceminmonths_Invalid;
    UNSIGNED1 sentencemindays_Invalid;
    UNSIGNED1 scheduledreleasedate_Invalid;
    UNSIGNED1 actualreleasedate_Invalid;
    UNSIGNED1 communitysupervisionyears_Invalid;
    UNSIGNED1 communitysupervisionmonths_Invalid;
    UNSIGNED1 communitysupervisiondays_Invalid;
    UNSIGNED1 sourcename_Invalid;
    UNSIGNED1 sourceid_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(priors_doc_Layout_crim)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(priors_doc_Layout_crim) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.recordid_Invalid := priors_doc_Fields.InValid_recordid((SALT33.StrType)le.recordid);
    SELF.statecode_Invalid := priors_doc_Fields.InValid_statecode((SALT33.StrType)le.statecode);
    SELF.caseid_Invalid := priors_doc_Fields.InValid_caseid((SALT33.StrType)le.caseid);
    SELF.offensedate_Invalid := priors_doc_Fields.InValid_offensedate((SALT33.StrType)le.offensedate);
    SELF.dispositiondate_Invalid := priors_doc_Fields.InValid_dispositiondate((SALT33.StrType)le.dispositiondate);
    SELF.sentencedate_Invalid := priors_doc_Fields.InValid_sentencedate((SALT33.StrType)le.sentencedate);
    SELF.sentencebegindate_Invalid := priors_doc_Fields.InValid_sentencebegindate((SALT33.StrType)le.sentencebegindate);
    SELF.sentenceenddate_Invalid := priors_doc_Fields.InValid_sentenceenddate((SALT33.StrType)le.sentenceenddate);
    SELF.sentencemaxyears_Invalid := priors_doc_Fields.InValid_sentencemaxyears((SALT33.StrType)le.sentencemaxyears);
    SELF.sentencemaxmonths_Invalid := priors_doc_Fields.InValid_sentencemaxmonths((SALT33.StrType)le.sentencemaxmonths);
    SELF.sentencemaxdays_Invalid := priors_doc_Fields.InValid_sentencemaxdays((SALT33.StrType)le.sentencemaxdays);
    SELF.sentenceminyears_Invalid := priors_doc_Fields.InValid_sentenceminyears((SALT33.StrType)le.sentenceminyears);
    SELF.sentenceminmonths_Invalid := priors_doc_Fields.InValid_sentenceminmonths((SALT33.StrType)le.sentenceminmonths);
    SELF.sentencemindays_Invalid := priors_doc_Fields.InValid_sentencemindays((SALT33.StrType)le.sentencemindays);
    SELF.scheduledreleasedate_Invalid := priors_doc_Fields.InValid_scheduledreleasedate((SALT33.StrType)le.scheduledreleasedate);
    SELF.actualreleasedate_Invalid := priors_doc_Fields.InValid_actualreleasedate((SALT33.StrType)le.actualreleasedate);
    SELF.communitysupervisionyears_Invalid := priors_doc_Fields.InValid_communitysupervisionyears((SALT33.StrType)le.communitysupervisionyears);
    SELF.communitysupervisionmonths_Invalid := priors_doc_Fields.InValid_communitysupervisionmonths((SALT33.StrType)le.communitysupervisionmonths);
    SELF.communitysupervisiondays_Invalid := priors_doc_Fields.InValid_communitysupervisiondays((SALT33.StrType)le.communitysupervisiondays);
    SELF.sourcename_Invalid := priors_doc_Fields.InValid_sourcename((SALT33.StrType)le.sourcename);
    SELF.sourceid_Invalid := priors_doc_Fields.InValid_sourceid((SALT33.StrType)le.sourceid);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),priors_doc_Layout_crim);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.recordid_Invalid << 0 ) + ( le.statecode_Invalid << 1 ) + ( le.caseid_Invalid << 2 ) + ( le.offensedate_Invalid << 3 ) + ( le.dispositiondate_Invalid << 4 ) + ( le.sentencedate_Invalid << 5 ) + ( le.sentencebegindate_Invalid << 6 ) + ( le.sentenceenddate_Invalid << 7 ) + ( le.sentencemaxyears_Invalid << 8 ) + ( le.sentencemaxmonths_Invalid << 9 ) + ( le.sentencemaxdays_Invalid << 10 ) + ( le.sentenceminyears_Invalid << 11 ) + ( le.sentenceminmonths_Invalid << 12 ) + ( le.sentencemindays_Invalid << 13 ) + ( le.scheduledreleasedate_Invalid << 14 ) + ( le.actualreleasedate_Invalid << 15 ) + ( le.communitysupervisionyears_Invalid << 16 ) + ( le.communitysupervisionmonths_Invalid << 17 ) + ( le.communitysupervisiondays_Invalid << 18 ) + ( le.sourcename_Invalid << 19 ) + ( le.sourceid_Invalid << 20 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,priors_doc_Layout_crim);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.recordid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.statecode_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.caseid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.offensedate_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.dispositiondate_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.sentencedate_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.sentencebegindate_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.sentenceenddate_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.sentencemaxyears_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.sentencemaxmonths_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.sentencemaxdays_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.sentenceminyears_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.sentenceminmonths_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.sentencemindays_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.scheduledreleasedate_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.actualreleasedate_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.communitysupervisionyears_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.communitysupervisionmonths_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.communitysupervisiondays_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.sourcename_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.sourceid_Invalid := (le.ScrubsBits1 >> 20) & 1;
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
    caseid_LENGTH_ErrorCount := COUNT(GROUP,h.caseid_Invalid=1);
    offensedate_CUSTOM_ErrorCount := COUNT(GROUP,h.offensedate_Invalid=1);
    dispositiondate_CUSTOM_ErrorCount := COUNT(GROUP,h.dispositiondate_Invalid=1);
    sentencedate_CUSTOM_ErrorCount := COUNT(GROUP,h.sentencedate_Invalid=1);
    sentencebegindate_CUSTOM_ErrorCount := COUNT(GROUP,h.sentencebegindate_Invalid=1);
    sentenceenddate_CUSTOM_ErrorCount := COUNT(GROUP,h.sentenceenddate_Invalid=1);
    sentencemaxyears_ALLOW_ErrorCount := COUNT(GROUP,h.sentencemaxyears_Invalid=1);
    sentencemaxmonths_ALLOW_ErrorCount := COUNT(GROUP,h.sentencemaxmonths_Invalid=1);
    sentencemaxdays_ALLOW_ErrorCount := COUNT(GROUP,h.sentencemaxdays_Invalid=1);
    sentenceminyears_ALLOW_ErrorCount := COUNT(GROUP,h.sentenceminyears_Invalid=1);
    sentenceminmonths_ALLOW_ErrorCount := COUNT(GROUP,h.sentenceminmonths_Invalid=1);
    sentencemindays_ALLOW_ErrorCount := COUNT(GROUP,h.sentencemindays_Invalid=1);
    scheduledreleasedate_CUSTOM_ErrorCount := COUNT(GROUP,h.scheduledreleasedate_Invalid=1);
    actualreleasedate_CUSTOM_ErrorCount := COUNT(GROUP,h.actualreleasedate_Invalid=1);
    communitysupervisionyears_ALLOW_ErrorCount := COUNT(GROUP,h.communitysupervisionyears_Invalid=1);
    communitysupervisionmonths_ALLOW_ErrorCount := COUNT(GROUP,h.communitysupervisionmonths_Invalid=1);
    communitysupervisiondays_ALLOW_ErrorCount := COUNT(GROUP,h.communitysupervisiondays_Invalid=1);
    sourcename_LENGTH_ErrorCount := COUNT(GROUP,h.sourcename_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.recordid_Invalid,le.statecode_Invalid,le.caseid_Invalid,le.offensedate_Invalid,le.dispositiondate_Invalid,le.sentencedate_Invalid,le.sentencebegindate_Invalid,le.sentenceenddate_Invalid,le.sentencemaxyears_Invalid,le.sentencemaxmonths_Invalid,le.sentencemaxdays_Invalid,le.sentenceminyears_Invalid,le.sentenceminmonths_Invalid,le.sentencemindays_Invalid,le.scheduledreleasedate_Invalid,le.actualreleasedate_Invalid,le.communitysupervisionyears_Invalid,le.communitysupervisionmonths_Invalid,le.communitysupervisiondays_Invalid,le.sourcename_Invalid,le.sourceid_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,priors_doc_Fields.InvalidMessage_recordid(le.recordid_Invalid),priors_doc_Fields.InvalidMessage_statecode(le.statecode_Invalid),priors_doc_Fields.InvalidMessage_caseid(le.caseid_Invalid),priors_doc_Fields.InvalidMessage_offensedate(le.offensedate_Invalid),priors_doc_Fields.InvalidMessage_dispositiondate(le.dispositiondate_Invalid),priors_doc_Fields.InvalidMessage_sentencedate(le.sentencedate_Invalid),priors_doc_Fields.InvalidMessage_sentencebegindate(le.sentencebegindate_Invalid),priors_doc_Fields.InvalidMessage_sentenceenddate(le.sentenceenddate_Invalid),priors_doc_Fields.InvalidMessage_sentencemaxyears(le.sentencemaxyears_Invalid),priors_doc_Fields.InvalidMessage_sentencemaxmonths(le.sentencemaxmonths_Invalid),priors_doc_Fields.InvalidMessage_sentencemaxdays(le.sentencemaxdays_Invalid),priors_doc_Fields.InvalidMessage_sentenceminyears(le.sentenceminyears_Invalid),priors_doc_Fields.InvalidMessage_sentenceminmonths(le.sentenceminmonths_Invalid),priors_doc_Fields.InvalidMessage_sentencemindays(le.sentencemindays_Invalid),priors_doc_Fields.InvalidMessage_scheduledreleasedate(le.scheduledreleasedate_Invalid),priors_doc_Fields.InvalidMessage_actualreleasedate(le.actualreleasedate_Invalid),priors_doc_Fields.InvalidMessage_communitysupervisionyears(le.communitysupervisionyears_Invalid),priors_doc_Fields.InvalidMessage_communitysupervisionmonths(le.communitysupervisionmonths_Invalid),priors_doc_Fields.InvalidMessage_communitysupervisiondays(le.communitysupervisiondays_Invalid),priors_doc_Fields.InvalidMessage_sourcename(le.sourcename_Invalid),priors_doc_Fields.InvalidMessage_sourceid(le.sourceid_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.recordid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statecode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.caseid_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.offensedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dispositiondate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sentencedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sentencebegindate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sentenceenddate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sentencemaxyears_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sentencemaxmonths_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sentencemaxdays_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sentenceminyears_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sentenceminmonths_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sentencemindays_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.scheduledreleasedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.actualreleasedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.communitysupervisionyears_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.communitysupervisionmonths_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.communitysupervisiondays_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sourcename_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.sourceid_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'recordid','statecode','caseid','offensedate','dispositiondate','sentencedate','sentencebegindate','sentenceenddate','sentencemaxyears','sentencemaxmonths','sentencemaxdays','sentenceminyears','sentenceminmonths','sentencemindays','scheduledreleasedate','actualreleasedate','communitysupervisionyears','communitysupervisionmonths','communitysupervisiondays','sourcename','sourceid','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Record_ID','Invalid_Char','Non_Blank','Invalid_Current_Date','Invalid_Current_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Future_Date','Invalid_Future_Date','Invalid_Num','Invalid_Num','Invalid_Num','Non_Blank','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.recordid,(SALT33.StrType)le.statecode,(SALT33.StrType)le.caseid,(SALT33.StrType)le.offensedate,(SALT33.StrType)le.dispositiondate,(SALT33.StrType)le.sentencedate,(SALT33.StrType)le.sentencebegindate,(SALT33.StrType)le.sentenceenddate,(SALT33.StrType)le.sentencemaxyears,(SALT33.StrType)le.sentencemaxmonths,(SALT33.StrType)le.sentencemaxdays,(SALT33.StrType)le.sentenceminyears,(SALT33.StrType)le.sentenceminmonths,(SALT33.StrType)le.sentencemindays,(SALT33.StrType)le.scheduledreleasedate,(SALT33.StrType)le.actualreleasedate,(SALT33.StrType)le.communitysupervisionyears,(SALT33.StrType)le.communitysupervisionmonths,(SALT33.StrType)le.communitysupervisiondays,(SALT33.StrType)le.sourcename,(SALT33.StrType)le.sourceid,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,21,Into(LEFT,COUNTER));
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
          ,'statecode:Invalid_Char:ALLOW'
          ,'caseid:Non_Blank:LENGTH'
          ,'offensedate:Invalid_Current_Date:CUSTOM'
          ,'dispositiondate:Invalid_Current_Date:CUSTOM'
          ,'sentencedate:Invalid_Future_Date:CUSTOM'
          ,'sentencebegindate:Invalid_Future_Date:CUSTOM'
          ,'sentenceenddate:Invalid_Future_Date:CUSTOM'
          ,'sentencemaxyears:Invalid_Num:ALLOW'
          ,'sentencemaxmonths:Invalid_Num:ALLOW'
          ,'sentencemaxdays:Invalid_Num:ALLOW'
          ,'sentenceminyears:Invalid_Num:ALLOW'
          ,'sentenceminmonths:Invalid_Num:ALLOW'
          ,'sentencemindays:Invalid_Num:ALLOW'
          ,'scheduledreleasedate:Invalid_Future_Date:CUSTOM'
          ,'actualreleasedate:Invalid_Future_Date:CUSTOM'
          ,'communitysupervisionyears:Invalid_Num:ALLOW'
          ,'communitysupervisionmonths:Invalid_Num:ALLOW'
          ,'communitysupervisiondays:Invalid_Num:ALLOW'
          ,'sourcename:Non_Blank:LENGTH'
          ,'sourceid:Invalid_Num:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,priors_doc_Fields.InvalidMessage_recordid(1)
          ,priors_doc_Fields.InvalidMessage_statecode(1)
          ,priors_doc_Fields.InvalidMessage_caseid(1)
          ,priors_doc_Fields.InvalidMessage_offensedate(1)
          ,priors_doc_Fields.InvalidMessage_dispositiondate(1)
          ,priors_doc_Fields.InvalidMessage_sentencedate(1)
          ,priors_doc_Fields.InvalidMessage_sentencebegindate(1)
          ,priors_doc_Fields.InvalidMessage_sentenceenddate(1)
          ,priors_doc_Fields.InvalidMessage_sentencemaxyears(1)
          ,priors_doc_Fields.InvalidMessage_sentencemaxmonths(1)
          ,priors_doc_Fields.InvalidMessage_sentencemaxdays(1)
          ,priors_doc_Fields.InvalidMessage_sentenceminyears(1)
          ,priors_doc_Fields.InvalidMessage_sentenceminmonths(1)
          ,priors_doc_Fields.InvalidMessage_sentencemindays(1)
          ,priors_doc_Fields.InvalidMessage_scheduledreleasedate(1)
          ,priors_doc_Fields.InvalidMessage_actualreleasedate(1)
          ,priors_doc_Fields.InvalidMessage_communitysupervisionyears(1)
          ,priors_doc_Fields.InvalidMessage_communitysupervisionmonths(1)
          ,priors_doc_Fields.InvalidMessage_communitysupervisiondays(1)
          ,priors_doc_Fields.InvalidMessage_sourcename(1)
          ,priors_doc_Fields.InvalidMessage_sourceid(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.caseid_LENGTH_ErrorCount
          ,le.offensedate_CUSTOM_ErrorCount
          ,le.dispositiondate_CUSTOM_ErrorCount
          ,le.sentencedate_CUSTOM_ErrorCount
          ,le.sentencebegindate_CUSTOM_ErrorCount
          ,le.sentenceenddate_CUSTOM_ErrorCount
          ,le.sentencemaxyears_ALLOW_ErrorCount
          ,le.sentencemaxmonths_ALLOW_ErrorCount
          ,le.sentencemaxdays_ALLOW_ErrorCount
          ,le.sentenceminyears_ALLOW_ErrorCount
          ,le.sentenceminmonths_ALLOW_ErrorCount
          ,le.sentencemindays_ALLOW_ErrorCount
          ,le.scheduledreleasedate_CUSTOM_ErrorCount
          ,le.actualreleasedate_CUSTOM_ErrorCount
          ,le.communitysupervisionyears_ALLOW_ErrorCount
          ,le.communitysupervisionmonths_ALLOW_ErrorCount
          ,le.communitysupervisiondays_ALLOW_ErrorCount
          ,le.sourcename_LENGTH_ErrorCount
          ,le.sourceid_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.caseid_LENGTH_ErrorCount
          ,le.offensedate_CUSTOM_ErrorCount
          ,le.dispositiondate_CUSTOM_ErrorCount
          ,le.sentencedate_CUSTOM_ErrorCount
          ,le.sentencebegindate_CUSTOM_ErrorCount
          ,le.sentenceenddate_CUSTOM_ErrorCount
          ,le.sentencemaxyears_ALLOW_ErrorCount
          ,le.sentencemaxmonths_ALLOW_ErrorCount
          ,le.sentencemaxdays_ALLOW_ErrorCount
          ,le.sentenceminyears_ALLOW_ErrorCount
          ,le.sentenceminmonths_ALLOW_ErrorCount
          ,le.sentencemindays_ALLOW_ErrorCount
          ,le.scheduledreleasedate_CUSTOM_ErrorCount
          ,le.actualreleasedate_CUSTOM_ErrorCount
          ,le.communitysupervisionyears_ALLOW_ErrorCount
          ,le.communitysupervisionmonths_ALLOW_ErrorCount
          ,le.communitysupervisiondays_ALLOW_ErrorCount
          ,le.sourcename_LENGTH_ErrorCount
          ,le.sourceid_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,21,Into(LEFT,COUNTER));
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

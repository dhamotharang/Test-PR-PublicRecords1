IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT incident_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(incident_Layout_SANCTNKeys)
    UNSIGNED1 batch_number_Invalid;
    UNSIGNED1 incident_number_Invalid;
    UNSIGNED1 party_number_Invalid;
    UNSIGNED1 order_number_Invalid;
    UNSIGNED1 incident_date_Invalid;
    UNSIGNED1 fcr_date_Invalid;
    UNSIGNED1 modified_date_Invalid;
    UNSIGNED1 load_date_Invalid;
    UNSIGNED1 incident_date_clean_Invalid;
    UNSIGNED1 fcr_date_clean_Invalid;
    UNSIGNED1 cln_modified_date_Invalid;
    UNSIGNED1 cln_load_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(incident_Layout_SANCTNKeys)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(incident_Layout_SANCTNKeys) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.batch_number_Invalid := incident_Fields.InValid_batch_number((SALT33.StrType)le.batch_number);
    SELF.incident_number_Invalid := incident_Fields.InValid_incident_number((SALT33.StrType)le.incident_number);
    SELF.party_number_Invalid := incident_Fields.InValid_party_number((SALT33.StrType)le.party_number);
    SELF.order_number_Invalid := incident_Fields.InValid_order_number((SALT33.StrType)le.order_number);
    SELF.incident_date_Invalid := incident_Fields.InValid_incident_date((SALT33.StrType)le.incident_date);
    SELF.fcr_date_Invalid := incident_Fields.InValid_fcr_date((SALT33.StrType)le.fcr_date);
    SELF.modified_date_Invalid := incident_Fields.InValid_modified_date((SALT33.StrType)le.modified_date);
    SELF.load_date_Invalid := incident_Fields.InValid_load_date((SALT33.StrType)le.load_date);
    SELF.incident_date_clean_Invalid := incident_Fields.InValid_incident_date_clean((SALT33.StrType)le.incident_date_clean);
    SELF.fcr_date_clean_Invalid := incident_Fields.InValid_fcr_date_clean((SALT33.StrType)le.fcr_date_clean);
    SELF.cln_modified_date_Invalid := incident_Fields.InValid_cln_modified_date((SALT33.StrType)le.cln_modified_date);
    SELF.cln_load_date_Invalid := incident_Fields.InValid_cln_load_date((SALT33.StrType)le.cln_load_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),incident_Layout_SANCTNKeys);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.batch_number_Invalid << 0 ) + ( le.incident_number_Invalid << 2 ) + ( le.party_number_Invalid << 3 ) + ( le.order_number_Invalid << 4 ) + ( le.incident_date_Invalid << 5 ) + ( le.fcr_date_Invalid << 6 ) + ( le.modified_date_Invalid << 7 ) + ( le.load_date_Invalid << 8 ) + ( le.incident_date_clean_Invalid << 9 ) + ( le.fcr_date_clean_Invalid << 10 ) + ( le.cln_modified_date_Invalid << 11 ) + ( le.cln_load_date_Invalid << 12 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,incident_Layout_SANCTNKeys);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.batch_number_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.incident_number_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.party_number_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.order_number_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.incident_date_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.fcr_date_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.modified_date_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.load_date_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.incident_date_clean_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.fcr_date_clean_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.cln_modified_date_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.cln_load_date_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    batch_number_ALLOW_ErrorCount := COUNT(GROUP,h.batch_number_Invalid=1);
    batch_number_LENGTH_ErrorCount := COUNT(GROUP,h.batch_number_Invalid=2);
    batch_number_Total_ErrorCount := COUNT(GROUP,h.batch_number_Invalid>0);
    incident_number_ALLOW_ErrorCount := COUNT(GROUP,h.incident_number_Invalid=1);
    party_number_ALLOW_ErrorCount := COUNT(GROUP,h.party_number_Invalid=1);
    order_number_ALLOW_ErrorCount := COUNT(GROUP,h.order_number_Invalid=1);
    incident_date_ALLOW_ErrorCount := COUNT(GROUP,h.incident_date_Invalid=1);
    fcr_date_ALLOW_ErrorCount := COUNT(GROUP,h.fcr_date_Invalid=1);
    modified_date_ALLOW_ErrorCount := COUNT(GROUP,h.modified_date_Invalid=1);
    load_date_ALLOW_ErrorCount := COUNT(GROUP,h.load_date_Invalid=1);
    incident_date_clean_CUSTOM_ErrorCount := COUNT(GROUP,h.incident_date_clean_Invalid=1);
    fcr_date_clean_CUSTOM_ErrorCount := COUNT(GROUP,h.fcr_date_clean_Invalid=1);
    cln_modified_date_CUSTOM_ErrorCount := COUNT(GROUP,h.cln_modified_date_Invalid=1);
    cln_load_date_CUSTOM_ErrorCount := COUNT(GROUP,h.cln_load_date_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.batch_number_Invalid,le.incident_number_Invalid,le.party_number_Invalid,le.order_number_Invalid,le.incident_date_Invalid,le.fcr_date_Invalid,le.modified_date_Invalid,le.load_date_Invalid,le.incident_date_clean_Invalid,le.fcr_date_clean_Invalid,le.cln_modified_date_Invalid,le.cln_load_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,incident_Fields.InvalidMessage_batch_number(le.batch_number_Invalid),incident_Fields.InvalidMessage_incident_number(le.incident_number_Invalid),incident_Fields.InvalidMessage_party_number(le.party_number_Invalid),incident_Fields.InvalidMessage_order_number(le.order_number_Invalid),incident_Fields.InvalidMessage_incident_date(le.incident_date_Invalid),incident_Fields.InvalidMessage_fcr_date(le.fcr_date_Invalid),incident_Fields.InvalidMessage_modified_date(le.modified_date_Invalid),incident_Fields.InvalidMessage_load_date(le.load_date_Invalid),incident_Fields.InvalidMessage_incident_date_clean(le.incident_date_clean_Invalid),incident_Fields.InvalidMessage_fcr_date_clean(le.fcr_date_clean_Invalid),incident_Fields.InvalidMessage_cln_modified_date(le.cln_modified_date_Invalid),incident_Fields.InvalidMessage_cln_load_date(le.cln_load_date_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.batch_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.incident_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.party_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.order_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.incident_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fcr_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.modified_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.load_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.incident_date_clean_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fcr_date_clean_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cln_modified_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cln_load_date_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'batch_number','incident_number','party_number','order_number','incident_date','fcr_date','modified_date','load_date','incident_date_clean','fcr_date_clean','cln_modified_date','cln_load_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Batch','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_CleanDate','Invalid_CleanDate','Invalid_CleanDate','Invalid_CleanDate','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.batch_number,(SALT33.StrType)le.incident_number,(SALT33.StrType)le.party_number,(SALT33.StrType)le.order_number,(SALT33.StrType)le.incident_date,(SALT33.StrType)le.fcr_date,(SALT33.StrType)le.modified_date,(SALT33.StrType)le.load_date,(SALT33.StrType)le.incident_date_clean,(SALT33.StrType)le.fcr_date_clean,(SALT33.StrType)le.cln_modified_date,(SALT33.StrType)le.cln_load_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,12,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'batch_number:Invalid_Batch:ALLOW','batch_number:Invalid_Batch:LENGTH'
          ,'incident_number:Invalid_Num:ALLOW'
          ,'party_number:Invalid_Num:ALLOW'
          ,'order_number:Invalid_Num:ALLOW'
          ,'incident_date:Invalid_Date:ALLOW'
          ,'fcr_date:Invalid_Date:ALLOW'
          ,'modified_date:Invalid_Date:ALLOW'
          ,'load_date:Invalid_Date:ALLOW'
          ,'incident_date_clean:Invalid_CleanDate:CUSTOM'
          ,'fcr_date_clean:Invalid_CleanDate:CUSTOM'
          ,'cln_modified_date:Invalid_CleanDate:CUSTOM'
          ,'cln_load_date:Invalid_CleanDate:CUSTOM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,incident_Fields.InvalidMessage_batch_number(1),incident_Fields.InvalidMessage_batch_number(2)
          ,incident_Fields.InvalidMessage_incident_number(1)
          ,incident_Fields.InvalidMessage_party_number(1)
          ,incident_Fields.InvalidMessage_order_number(1)
          ,incident_Fields.InvalidMessage_incident_date(1)
          ,incident_Fields.InvalidMessage_fcr_date(1)
          ,incident_Fields.InvalidMessage_modified_date(1)
          ,incident_Fields.InvalidMessage_load_date(1)
          ,incident_Fields.InvalidMessage_incident_date_clean(1)
          ,incident_Fields.InvalidMessage_fcr_date_clean(1)
          ,incident_Fields.InvalidMessage_cln_modified_date(1)
          ,incident_Fields.InvalidMessage_cln_load_date(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.batch_number_ALLOW_ErrorCount,le.batch_number_LENGTH_ErrorCount
          ,le.incident_number_ALLOW_ErrorCount
          ,le.party_number_ALLOW_ErrorCount
          ,le.order_number_ALLOW_ErrorCount
          ,le.incident_date_ALLOW_ErrorCount
          ,le.fcr_date_ALLOW_ErrorCount
          ,le.modified_date_ALLOW_ErrorCount
          ,le.load_date_ALLOW_ErrorCount
          ,le.incident_date_clean_CUSTOM_ErrorCount
          ,le.fcr_date_clean_CUSTOM_ErrorCount
          ,le.cln_modified_date_CUSTOM_ErrorCount
          ,le.cln_load_date_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.batch_number_ALLOW_ErrorCount,le.batch_number_LENGTH_ErrorCount
          ,le.incident_number_ALLOW_ErrorCount
          ,le.party_number_ALLOW_ErrorCount
          ,le.order_number_ALLOW_ErrorCount
          ,le.incident_date_ALLOW_ErrorCount
          ,le.fcr_date_ALLOW_ErrorCount
          ,le.modified_date_ALLOW_ErrorCount
          ,le.load_date_ALLOW_ErrorCount
          ,le.incident_date_clean_CUSTOM_ErrorCount
          ,le.fcr_date_clean_CUSTOM_ErrorCount
          ,le.cln_modified_date_CUSTOM_ErrorCount
          ,le.cln_load_date_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,13,Into(LEFT,COUNTER));
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

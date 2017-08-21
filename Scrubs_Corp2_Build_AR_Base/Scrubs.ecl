IMPORT ut,SALT30;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(layout_in_file)
    UNSIGNED1 corp_key_Invalid;
    UNSIGNED1 corp_vendor_Invalid;
    UNSIGNED1 corp_state_origin_Invalid;
    UNSIGNED1 corp_process_date_Invalid;
    UNSIGNED1 ar_mailed_dt_Invalid;
    UNSIGNED1 ar_due_dt_Invalid;
    UNSIGNED1 ar_report_dt_Invalid;
    UNSIGNED1 ar_franchise_tax_paid_dt_Invalid;
    UNSIGNED1 ar_delinquent_dt_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(layout_in_file)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(layout_in_file) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.corp_key_Invalid := Fields.InValid_corp_key((SALT30.StrType)le.corp_key);
    SELF.corp_vendor_Invalid := Fields.InValid_corp_vendor((SALT30.StrType)le.corp_vendor);
    SELF.corp_state_origin_Invalid := Fields.InValid_corp_state_origin((SALT30.StrType)le.corp_state_origin);
    SELF.corp_process_date_Invalid := Fields.InValid_corp_process_date((SALT30.StrType)le.corp_process_date);
    SELF.ar_mailed_dt_Invalid := Fields.InValid_ar_mailed_dt((SALT30.StrType)le.ar_mailed_dt);
    SELF.ar_due_dt_Invalid := Fields.InValid_ar_due_dt((SALT30.StrType)le.ar_due_dt);
    SELF.ar_report_dt_Invalid := Fields.InValid_ar_report_dt((SALT30.StrType)le.ar_report_dt);
    SELF.ar_franchise_tax_paid_dt_Invalid := Fields.InValid_ar_franchise_tax_paid_dt((SALT30.StrType)le.ar_franchise_tax_paid_dt);
    SELF.ar_delinquent_dt_Invalid := Fields.InValid_ar_delinquent_dt((SALT30.StrType)le.ar_delinquent_dt);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.corp_key_Invalid << 0 ) + ( le.corp_vendor_Invalid << 1 ) + ( le.corp_state_origin_Invalid << 3 ) + ( le.corp_process_date_Invalid << 5 ) + ( le.ar_mailed_dt_Invalid << 7 ) + ( le.ar_due_dt_Invalid << 9 ) + ( le.ar_report_dt_Invalid << 11 ) + ( le.ar_franchise_tax_paid_dt_Invalid << 13 ) + ( le.ar_delinquent_dt_Invalid << 15 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,layout_in_file);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.corp_key_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.corp_vendor_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.corp_state_origin_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.corp_process_date_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.ar_mailed_dt_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.ar_due_dt_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.ar_report_dt_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.ar_franchise_tax_paid_dt_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.ar_delinquent_dt_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    corp_key_LENGTH_ErrorCount := COUNT(GROUP,h.corp_key_Invalid=1);
    corp_vendor_ALLOW_ErrorCount := COUNT(GROUP,h.corp_vendor_Invalid=1);
    corp_vendor_LENGTH_ErrorCount := COUNT(GROUP,h.corp_vendor_Invalid=2);
    corp_vendor_Total_ErrorCount := COUNT(GROUP,h.corp_vendor_Invalid>0);
    corp_state_origin_ALLOW_ErrorCount := COUNT(GROUP,h.corp_state_origin_Invalid=1);
    corp_state_origin_LENGTH_ErrorCount := COUNT(GROUP,h.corp_state_origin_Invalid=2);
    corp_state_origin_Total_ErrorCount := COUNT(GROUP,h.corp_state_origin_Invalid>0);
    corp_process_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=1);
    corp_process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=2);
    corp_process_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=3);
    corp_process_date_Total_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid>0);
    ar_mailed_dt_ALLOW_ErrorCount := COUNT(GROUP,h.ar_mailed_dt_Invalid=1);
    ar_mailed_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.ar_mailed_dt_Invalid=2);
    ar_mailed_dt_LENGTH_ErrorCount := COUNT(GROUP,h.ar_mailed_dt_Invalid=3);
    ar_mailed_dt_Total_ErrorCount := COUNT(GROUP,h.ar_mailed_dt_Invalid>0);
    ar_due_dt_ALLOW_ErrorCount := COUNT(GROUP,h.ar_due_dt_Invalid=1);
    ar_due_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.ar_due_dt_Invalid=2);
    ar_due_dt_LENGTH_ErrorCount := COUNT(GROUP,h.ar_due_dt_Invalid=3);
    ar_due_dt_Total_ErrorCount := COUNT(GROUP,h.ar_due_dt_Invalid>0);
    ar_report_dt_ALLOW_ErrorCount := COUNT(GROUP,h.ar_report_dt_Invalid=1);
    ar_report_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.ar_report_dt_Invalid=2);
    ar_report_dt_LENGTH_ErrorCount := COUNT(GROUP,h.ar_report_dt_Invalid=3);
    ar_report_dt_Total_ErrorCount := COUNT(GROUP,h.ar_report_dt_Invalid>0);
    ar_franchise_tax_paid_dt_ALLOW_ErrorCount := COUNT(GROUP,h.ar_franchise_tax_paid_dt_Invalid=1);
    ar_franchise_tax_paid_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.ar_franchise_tax_paid_dt_Invalid=2);
    ar_franchise_tax_paid_dt_LENGTH_ErrorCount := COUNT(GROUP,h.ar_franchise_tax_paid_dt_Invalid=3);
    ar_franchise_tax_paid_dt_Total_ErrorCount := COUNT(GROUP,h.ar_franchise_tax_paid_dt_Invalid>0);
    ar_delinquent_dt_ALLOW_ErrorCount := COUNT(GROUP,h.ar_delinquent_dt_Invalid=1);
    ar_delinquent_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.ar_delinquent_dt_Invalid=2);
    ar_delinquent_dt_LENGTH_ErrorCount := COUNT(GROUP,h.ar_delinquent_dt_Invalid=3);
    ar_delinquent_dt_Total_ErrorCount := COUNT(GROUP,h.ar_delinquent_dt_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.corp_key_Invalid,le.corp_vendor_Invalid,le.corp_state_origin_Invalid,le.corp_process_date_Invalid,le.ar_mailed_dt_Invalid,le.ar_due_dt_Invalid,le.ar_report_dt_Invalid,le.ar_franchise_tax_paid_dt_Invalid,le.ar_delinquent_dt_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_corp_key(le.corp_key_Invalid),Fields.InvalidMessage_corp_vendor(le.corp_vendor_Invalid),Fields.InvalidMessage_corp_state_origin(le.corp_state_origin_Invalid),Fields.InvalidMessage_corp_process_date(le.corp_process_date_Invalid),Fields.InvalidMessage_ar_mailed_dt(le.ar_mailed_dt_Invalid),Fields.InvalidMessage_ar_due_dt(le.ar_due_dt_Invalid),Fields.InvalidMessage_ar_report_dt(le.ar_report_dt_Invalid),Fields.InvalidMessage_ar_franchise_tax_paid_dt(le.ar_franchise_tax_paid_dt_Invalid),Fields.InvalidMessage_ar_delinquent_dt(le.ar_delinquent_dt_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.corp_key_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_vendor_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_state_origin_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_process_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.ar_mailed_dt_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.ar_due_dt_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.ar_report_dt_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.ar_franchise_tax_paid_dt_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.ar_delinquent_dt_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'corp_key','corp_vendor','corp_state_origin','corp_process_date','ar_mailed_dt','ar_due_dt','ar_report_dt','ar_franchise_tax_paid_dt','ar_delinquent_dt','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.corp_key,(SALT30.StrType)le.corp_vendor,(SALT30.StrType)le.corp_state_origin,(SALT30.StrType)le.corp_process_date,(SALT30.StrType)le.ar_mailed_dt,(SALT30.StrType)le.ar_due_dt,(SALT30.StrType)le.ar_report_dt,(SALT30.StrType)le.ar_franchise_tax_paid_dt,(SALT30.StrType)le.ar_delinquent_dt,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,9,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'corp_key:invalid_corp_key:LENGTH'
          ,'corp_vendor:invalid_corp_vendor:ALLOW','corp_vendor:invalid_corp_vendor:LENGTH'
          ,'corp_state_origin:invalid_state_origin:ALLOW','corp_state_origin:invalid_state_origin:LENGTH'
          ,'corp_process_date:invalid_date:ALLOW','corp_process_date:invalid_date:CUSTOM','corp_process_date:invalid_date:LENGTH'
          ,'ar_mailed_dt:invalid_date:ALLOW','ar_mailed_dt:invalid_date:CUSTOM','ar_mailed_dt:invalid_date:LENGTH'
          ,'ar_due_dt:invalid_date:ALLOW','ar_due_dt:invalid_date:CUSTOM','ar_due_dt:invalid_date:LENGTH'
          ,'ar_report_dt:invalid_date:ALLOW','ar_report_dt:invalid_date:CUSTOM','ar_report_dt:invalid_date:LENGTH'
          ,'ar_franchise_tax_paid_dt:invalid_date:ALLOW','ar_franchise_tax_paid_dt:invalid_date:CUSTOM','ar_franchise_tax_paid_dt:invalid_date:LENGTH'
          ,'ar_delinquent_dt:invalid_date:ALLOW','ar_delinquent_dt:invalid_date:CUSTOM','ar_delinquent_dt:invalid_date:LENGTH','UNKNOWN');
      SELF.ErrorMessage := '';
      SELF.rulecnt := CHOOSE(c
          ,le.corp_key_LENGTH_ErrorCount
          ,le.corp_vendor_ALLOW_ErrorCount,le.corp_vendor_LENGTH_ErrorCount
          ,le.corp_state_origin_ALLOW_ErrorCount,le.corp_state_origin_LENGTH_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount,le.corp_process_date_LENGTH_ErrorCount
          ,le.ar_mailed_dt_ALLOW_ErrorCount,le.ar_mailed_dt_CUSTOM_ErrorCount,le.ar_mailed_dt_LENGTH_ErrorCount
          ,le.ar_due_dt_ALLOW_ErrorCount,le.ar_due_dt_CUSTOM_ErrorCount,le.ar_due_dt_LENGTH_ErrorCount
          ,le.ar_report_dt_ALLOW_ErrorCount,le.ar_report_dt_CUSTOM_ErrorCount,le.ar_report_dt_LENGTH_ErrorCount
          ,le.ar_franchise_tax_paid_dt_ALLOW_ErrorCount,le.ar_franchise_tax_paid_dt_CUSTOM_ErrorCount,le.ar_franchise_tax_paid_dt_LENGTH_ErrorCount
          ,le.ar_delinquent_dt_ALLOW_ErrorCount,le.ar_delinquent_dt_CUSTOM_ErrorCount,le.ar_delinquent_dt_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.corp_key_LENGTH_ErrorCount
          ,le.corp_vendor_ALLOW_ErrorCount,le.corp_vendor_LENGTH_ErrorCount
          ,le.corp_state_origin_ALLOW_ErrorCount,le.corp_state_origin_LENGTH_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount,le.corp_process_date_LENGTH_ErrorCount
          ,le.ar_mailed_dt_ALLOW_ErrorCount,le.ar_mailed_dt_CUSTOM_ErrorCount,le.ar_mailed_dt_LENGTH_ErrorCount
          ,le.ar_due_dt_ALLOW_ErrorCount,le.ar_due_dt_CUSTOM_ErrorCount,le.ar_due_dt_LENGTH_ErrorCount
          ,le.ar_report_dt_ALLOW_ErrorCount,le.ar_report_dt_CUSTOM_ErrorCount,le.ar_report_dt_LENGTH_ErrorCount
          ,le.ar_franchise_tax_paid_dt_ALLOW_ErrorCount,le.ar_franchise_tax_paid_dt_CUSTOM_ErrorCount,le.ar_franchise_tax_paid_dt_LENGTH_ErrorCount
          ,le.ar_delinquent_dt_ALLOW_ErrorCount,le.ar_delinquent_dt_CUSTOM_ErrorCount,le.ar_delinquent_dt_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,23,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT30.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT30.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF.ErrorMessage := ri.ErrorMessage;
   SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;

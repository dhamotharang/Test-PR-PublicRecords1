IMPORT SALT37;
EXPORT MarketAppend_Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(MarketAppend_Layout_MarketAppend)
    UNSIGNED1 company_id_Invalid;
    UNSIGNED1 app_type_Invalid;
    UNSIGNED1 market_Invalid;
    UNSIGNED1 sub_market_Invalid;
    UNSIGNED1 vertical_Invalid;
    UNSIGNED1 main_country_code_Invalid;
    UNSIGNED1 bill_country_code_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(MarketAppend_Layout_MarketAppend)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(MarketAppend_Layout_MarketAppend) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.company_id_Invalid := MarketAppend_Fields.InValid_company_id((SALT37.StrType)le.company_id);
    SELF.app_type_Invalid := MarketAppend_Fields.InValid_app_type((SALT37.StrType)le.app_type);
    SELF.market_Invalid := MarketAppend_Fields.InValid_market((SALT37.StrType)le.market);
    SELF.sub_market_Invalid := MarketAppend_Fields.InValid_sub_market((SALT37.StrType)le.sub_market);
    SELF.vertical_Invalid := MarketAppend_Fields.InValid_vertical((SALT37.StrType)le.vertical);
    SELF.main_country_code_Invalid := MarketAppend_Fields.InValid_main_country_code((SALT37.StrType)le.main_country_code);
    SELF.bill_country_code_Invalid := MarketAppend_Fields.InValid_bill_country_code((SALT37.StrType)le.bill_country_code);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),MarketAppend_Layout_MarketAppend);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.company_id_Invalid << 0 ) + ( le.app_type_Invalid << 1 ) + ( le.market_Invalid << 2 ) + ( le.sub_market_Invalid << 3 ) + ( le.vertical_Invalid << 4 ) + ( le.main_country_code_Invalid << 5 ) + ( le.bill_country_code_Invalid << 6 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,MarketAppend_Layout_MarketAppend);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.company_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.app_type_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.market_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.sub_market_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.vertical_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.main_country_code_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.bill_country_code_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    company_id_ALLOW_ErrorCount := COUNT(GROUP,h.company_id_Invalid=1);
    app_type_ALLOW_ErrorCount := COUNT(GROUP,h.app_type_Invalid=1);
    market_ALLOW_ErrorCount := COUNT(GROUP,h.market_Invalid=1);
    sub_market_ALLOW_ErrorCount := COUNT(GROUP,h.sub_market_Invalid=1);
    vertical_ALLOW_ErrorCount := COUNT(GROUP,h.vertical_Invalid=1);
    main_country_code_ALLOW_ErrorCount := COUNT(GROUP,h.main_country_code_Invalid=1);
    bill_country_code_ALLOW_ErrorCount := COUNT(GROUP,h.bill_country_code_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT37.StrType ErrorMessage;
    SALT37.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.company_id_Invalid,le.app_type_Invalid,le.market_Invalid,le.sub_market_Invalid,le.vertical_Invalid,le.main_country_code_Invalid,le.bill_country_code_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,MarketAppend_Fields.InvalidMessage_company_id(le.company_id_Invalid),MarketAppend_Fields.InvalidMessage_app_type(le.app_type_Invalid),MarketAppend_Fields.InvalidMessage_market(le.market_Invalid),MarketAppend_Fields.InvalidMessage_sub_market(le.sub_market_Invalid),MarketAppend_Fields.InvalidMessage_vertical(le.vertical_Invalid),MarketAppend_Fields.InvalidMessage_main_country_code(le.main_country_code_Invalid),MarketAppend_Fields.InvalidMessage_bill_country_code(le.bill_country_code_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.company_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.app_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.market_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sub_market_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vertical_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.main_country_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bill_country_code_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'company_id','app_type','market','sub_market','vertical','main_country_code','bill_country_code','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.company_id,(SALT37.StrType)le.app_type,(SALT37.StrType)le.market,(SALT37.StrType)le.sub_market,(SALT37.StrType)le.vertical,(SALT37.StrType)le.main_country_code,(SALT37.StrType)le.bill_country_code,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,7,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'company_id:invalid_alphanumeric:ALLOW'
          ,'app_type:invalid_alphanumeric:ALLOW'
          ,'market:invalid_alphanumeric:ALLOW'
          ,'sub_market:invalid_alphanumeric:ALLOW'
          ,'vertical:invalid_alphanumeric:ALLOW'
          ,'main_country_code:invalid_alphanumeric:ALLOW'
          ,'bill_country_code:invalid_alphanumeric:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,MarketAppend_Fields.InvalidMessage_company_id(1)
          ,MarketAppend_Fields.InvalidMessage_app_type(1)
          ,MarketAppend_Fields.InvalidMessage_market(1)
          ,MarketAppend_Fields.InvalidMessage_sub_market(1)
          ,MarketAppend_Fields.InvalidMessage_vertical(1)
          ,MarketAppend_Fields.InvalidMessage_main_country_code(1)
          ,MarketAppend_Fields.InvalidMessage_bill_country_code(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.company_id_ALLOW_ErrorCount
          ,le.app_type_ALLOW_ErrorCount
          ,le.market_ALLOW_ErrorCount
          ,le.sub_market_ALLOW_ErrorCount
          ,le.vertical_ALLOW_ErrorCount
          ,le.main_country_code_ALLOW_ErrorCount
          ,le.bill_country_code_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.company_id_ALLOW_ErrorCount
          ,le.app_type_ALLOW_ErrorCount
          ,le.market_ALLOW_ErrorCount
          ,le.sub_market_ALLOW_ErrorCount
          ,le.vertical_ALLOW_ErrorCount
          ,le.main_country_code_ALLOW_ErrorCount
          ,le.bill_country_code_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT37.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT37.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;

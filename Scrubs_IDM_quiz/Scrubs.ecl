IMPORT ut,SALT32;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_IN_QUIZ)
    UNSIGNED1 UNIQUE_IDENTITY_COUNT_Invalid;
    UNSIGNED1 SELECTED_SSN_Invalid;
    UNSIGNED1 AUTH_SCORE_Invalid;
    UNSIGNED1 AUTH_FAIL_Invalid;
    UNSIGNED1 NAME_Invalid;
    UNSIGNED1 AUTH_STATUS_Invalid;
    UNSIGNED1 VERIF_STATUS_Invalid;
    UNSIGNED1 QUIZ_STATUS_Invalid;
    UNSIGNED1 ID_DISCOVERY_LINK_ID_Invalid;
    UNSIGNED1 PROID_LINK_ID_Invalid;
    UNSIGNED1 SUB_PRODUCT_NAME_Invalid;
    UNSIGNED1 AUTH_FAIL_STATUS_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_IN_QUIZ)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_IN_QUIZ) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.UNIQUE_IDENTITY_COUNT_Invalid := Fields.InValid_UNIQUE_IDENTITY_COUNT((SALT32.StrType)le.UNIQUE_IDENTITY_COUNT);
    SELF.SELECTED_SSN_Invalid := Fields.InValid_SELECTED_SSN((SALT32.StrType)le.SELECTED_SSN);
    SELF.AUTH_SCORE_Invalid := Fields.InValid_AUTH_SCORE((SALT32.StrType)le.AUTH_SCORE);
    SELF.AUTH_FAIL_Invalid := Fields.InValid_AUTH_FAIL((SALT32.StrType)le.AUTH_FAIL);
    SELF.NAME_Invalid := Fields.InValid_NAME((SALT32.StrType)le.NAME);
    SELF.AUTH_STATUS_Invalid := Fields.InValid_AUTH_STATUS((SALT32.StrType)le.AUTH_STATUS);
    SELF.VERIF_STATUS_Invalid := Fields.InValid_VERIF_STATUS((SALT32.StrType)le.VERIF_STATUS);
    SELF.QUIZ_STATUS_Invalid := Fields.InValid_QUIZ_STATUS((SALT32.StrType)le.QUIZ_STATUS);
    SELF.ID_DISCOVERY_LINK_ID_Invalid := Fields.InValid_ID_DISCOVERY_LINK_ID((SALT32.StrType)le.ID_DISCOVERY_LINK_ID);
    SELF.PROID_LINK_ID_Invalid := Fields.InValid_PROID_LINK_ID((SALT32.StrType)le.PROID_LINK_ID);
    SELF.SUB_PRODUCT_NAME_Invalid := Fields.InValid_SUB_PRODUCT_NAME((SALT32.StrType)le.SUB_PRODUCT_NAME);
    SELF.AUTH_FAIL_STATUS_Invalid := Fields.InValid_AUTH_FAIL_STATUS((SALT32.StrType)le.AUTH_FAIL_STATUS);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_IN_QUIZ);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.UNIQUE_IDENTITY_COUNT_Invalid << 0 ) + ( le.SELECTED_SSN_Invalid << 2 ) + ( le.AUTH_SCORE_Invalid << 4 ) + ( le.AUTH_FAIL_Invalid << 6 ) + ( le.NAME_Invalid << 8 ) + ( le.AUTH_STATUS_Invalid << 9 ) + ( le.VERIF_STATUS_Invalid << 11 ) + ( le.QUIZ_STATUS_Invalid << 13 ) + ( le.ID_DISCOVERY_LINK_ID_Invalid << 15 ) + ( le.PROID_LINK_ID_Invalid << 17 ) + ( le.SUB_PRODUCT_NAME_Invalid << 19 ) + ( le.AUTH_FAIL_STATUS_Invalid << 20 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_IN_QUIZ);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.UNIQUE_IDENTITY_COUNT_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.SELECTED_SSN_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.AUTH_SCORE_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.AUTH_FAIL_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.NAME_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.AUTH_STATUS_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.VERIF_STATUS_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.QUIZ_STATUS_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.ID_DISCOVERY_LINK_ID_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.PROID_LINK_ID_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.SUB_PRODUCT_NAME_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.AUTH_FAIL_STATUS_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    UNIQUE_IDENTITY_COUNT_ALLOW_ErrorCount := COUNT(GROUP,h.UNIQUE_IDENTITY_COUNT_Invalid=1);
    UNIQUE_IDENTITY_COUNT_LENGTH_ErrorCount := COUNT(GROUP,h.UNIQUE_IDENTITY_COUNT_Invalid=2);
    UNIQUE_IDENTITY_COUNT_Total_ErrorCount := COUNT(GROUP,h.UNIQUE_IDENTITY_COUNT_Invalid>0);
    SELECTED_SSN_ALLOW_ErrorCount := COUNT(GROUP,h.SELECTED_SSN_Invalid=1);
    SELECTED_SSN_LENGTH_ErrorCount := COUNT(GROUP,h.SELECTED_SSN_Invalid=2);
    SELECTED_SSN_Total_ErrorCount := COUNT(GROUP,h.SELECTED_SSN_Invalid>0);
    AUTH_SCORE_ALLOW_ErrorCount := COUNT(GROUP,h.AUTH_SCORE_Invalid=1);
    AUTH_SCORE_LENGTH_ErrorCount := COUNT(GROUP,h.AUTH_SCORE_Invalid=2);
    AUTH_SCORE_Total_ErrorCount := COUNT(GROUP,h.AUTH_SCORE_Invalid>0);
    AUTH_FAIL_ALLOW_ErrorCount := COUNT(GROUP,h.AUTH_FAIL_Invalid=1);
    AUTH_FAIL_LENGTH_ErrorCount := COUNT(GROUP,h.AUTH_FAIL_Invalid=2);
    AUTH_FAIL_Total_ErrorCount := COUNT(GROUP,h.AUTH_FAIL_Invalid>0);
    NAME_ALLOW_ErrorCount := COUNT(GROUP,h.NAME_Invalid=1);
    AUTH_STATUS_ALLOW_ErrorCount := COUNT(GROUP,h.AUTH_STATUS_Invalid=1);
    AUTH_STATUS_LENGTH_ErrorCount := COUNT(GROUP,h.AUTH_STATUS_Invalid=2);
    AUTH_STATUS_Total_ErrorCount := COUNT(GROUP,h.AUTH_STATUS_Invalid>0);
    VERIF_STATUS_ALLOW_ErrorCount := COUNT(GROUP,h.VERIF_STATUS_Invalid=1);
    VERIF_STATUS_LENGTH_ErrorCount := COUNT(GROUP,h.VERIF_STATUS_Invalid=2);
    VERIF_STATUS_Total_ErrorCount := COUNT(GROUP,h.VERIF_STATUS_Invalid>0);
    QUIZ_STATUS_ALLOW_ErrorCount := COUNT(GROUP,h.QUIZ_STATUS_Invalid=1);
    QUIZ_STATUS_LENGTH_ErrorCount := COUNT(GROUP,h.QUIZ_STATUS_Invalid=2);
    QUIZ_STATUS_Total_ErrorCount := COUNT(GROUP,h.QUIZ_STATUS_Invalid>0);
    ID_DISCOVERY_LINK_ID_ALLOW_ErrorCount := COUNT(GROUP,h.ID_DISCOVERY_LINK_ID_Invalid=1);
    ID_DISCOVERY_LINK_ID_LENGTH_ErrorCount := COUNT(GROUP,h.ID_DISCOVERY_LINK_ID_Invalid=2);
    ID_DISCOVERY_LINK_ID_Total_ErrorCount := COUNT(GROUP,h.ID_DISCOVERY_LINK_ID_Invalid>0);
    PROID_LINK_ID_ALLOW_ErrorCount := COUNT(GROUP,h.PROID_LINK_ID_Invalid=1);
    PROID_LINK_ID_LENGTH_ErrorCount := COUNT(GROUP,h.PROID_LINK_ID_Invalid=2);
    PROID_LINK_ID_Total_ErrorCount := COUNT(GROUP,h.PROID_LINK_ID_Invalid>0);
    SUB_PRODUCT_NAME_ALLOW_ErrorCount := COUNT(GROUP,h.SUB_PRODUCT_NAME_Invalid=1);
    AUTH_FAIL_STATUS_ALLOW_ErrorCount := COUNT(GROUP,h.AUTH_FAIL_STATUS_Invalid=1);
    AUTH_FAIL_STATUS_LENGTH_ErrorCount := COUNT(GROUP,h.AUTH_FAIL_STATUS_Invalid=2);
    AUTH_FAIL_STATUS_Total_ErrorCount := COUNT(GROUP,h.AUTH_FAIL_STATUS_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT32.StrType ErrorMessage;
    SALT32.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.UNIQUE_IDENTITY_COUNT_Invalid,le.SELECTED_SSN_Invalid,le.AUTH_SCORE_Invalid,le.AUTH_FAIL_Invalid,le.NAME_Invalid,le.AUTH_STATUS_Invalid,le.VERIF_STATUS_Invalid,le.QUIZ_STATUS_Invalid,le.ID_DISCOVERY_LINK_ID_Invalid,le.PROID_LINK_ID_Invalid,le.SUB_PRODUCT_NAME_Invalid,le.AUTH_FAIL_STATUS_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_UNIQUE_IDENTITY_COUNT(le.UNIQUE_IDENTITY_COUNT_Invalid),Fields.InvalidMessage_SELECTED_SSN(le.SELECTED_SSN_Invalid),Fields.InvalidMessage_AUTH_SCORE(le.AUTH_SCORE_Invalid),Fields.InvalidMessage_AUTH_FAIL(le.AUTH_FAIL_Invalid),Fields.InvalidMessage_NAME(le.NAME_Invalid),Fields.InvalidMessage_AUTH_STATUS(le.AUTH_STATUS_Invalid),Fields.InvalidMessage_VERIF_STATUS(le.VERIF_STATUS_Invalid),Fields.InvalidMessage_QUIZ_STATUS(le.QUIZ_STATUS_Invalid),Fields.InvalidMessage_ID_DISCOVERY_LINK_ID(le.ID_DISCOVERY_LINK_ID_Invalid),Fields.InvalidMessage_PROID_LINK_ID(le.PROID_LINK_ID_Invalid),Fields.InvalidMessage_SUB_PRODUCT_NAME(le.SUB_PRODUCT_NAME_Invalid),Fields.InvalidMessage_AUTH_FAIL_STATUS(le.AUTH_FAIL_STATUS_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.UNIQUE_IDENTITY_COUNT_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.SELECTED_SSN_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.AUTH_SCORE_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.AUTH_FAIL_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.NAME_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.AUTH_STATUS_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.VERIF_STATUS_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.QUIZ_STATUS_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ID_DISCOVERY_LINK_ID_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.PROID_LINK_ID_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.SUB_PRODUCT_NAME_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.AUTH_FAIL_STATUS_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'UNIQUE_IDENTITY_COUNT','SELECTED_SSN','AUTH_SCORE','AUTH_FAIL','NAME','AUTH_STATUS','VERIF_STATUS','QUIZ_STATUS','ID_DISCOVERY_LINK_ID','PROID_LINK_ID','SUB_PRODUCT_NAME','AUTH_FAIL_STATUS','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'INVALID_UNIQUE_IDENTITY_COUNT','INVALID_SSN','INVALID_auth_score','INVALID_Auth_Fail','INVALID_name','invalid_AUTH_STATUS','invalid_VERIF_STATUS','invalid_QUIZ_STATUS','INVALID_ID_DISCOVERY_Link_ID','INVALID_PROID_Link_ID','INVALID_SUB_PRODUCT_NAME','INVALID_AUTH_FAIL_STATUS','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT32.StrType)le.UNIQUE_IDENTITY_COUNT,(SALT32.StrType)le.SELECTED_SSN,(SALT32.StrType)le.AUTH_SCORE,(SALT32.StrType)le.AUTH_FAIL,(SALT32.StrType)le.NAME,(SALT32.StrType)le.AUTH_STATUS,(SALT32.StrType)le.VERIF_STATUS,(SALT32.StrType)le.QUIZ_STATUS,(SALT32.StrType)le.ID_DISCOVERY_LINK_ID,(SALT32.StrType)le.PROID_LINK_ID,(SALT32.StrType)le.SUB_PRODUCT_NAME,(SALT32.StrType)le.AUTH_FAIL_STATUS,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,12,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT32.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'UNIQUE_IDENTITY_COUNT:INVALID_UNIQUE_IDENTITY_COUNT:ALLOW','UNIQUE_IDENTITY_COUNT:INVALID_UNIQUE_IDENTITY_COUNT:LENGTH'
          ,'SELECTED_SSN:INVALID_SSN:ALLOW','SELECTED_SSN:INVALID_SSN:LENGTH'
          ,'AUTH_SCORE:INVALID_auth_score:ALLOW','AUTH_SCORE:INVALID_auth_score:LENGTH'
          ,'AUTH_FAIL:INVALID_Auth_Fail:ALLOW','AUTH_FAIL:INVALID_Auth_Fail:LENGTH'
          ,'NAME:INVALID_name:ALLOW'
          ,'AUTH_STATUS:invalid_AUTH_STATUS:ALLOW','AUTH_STATUS:invalid_AUTH_STATUS:LENGTH'
          ,'VERIF_STATUS:invalid_VERIF_STATUS:ALLOW','VERIF_STATUS:invalid_VERIF_STATUS:LENGTH'
          ,'QUIZ_STATUS:invalid_QUIZ_STATUS:ALLOW','QUIZ_STATUS:invalid_QUIZ_STATUS:LENGTH'
          ,'ID_DISCOVERY_LINK_ID:INVALID_ID_DISCOVERY_Link_ID:ALLOW','ID_DISCOVERY_LINK_ID:INVALID_ID_DISCOVERY_Link_ID:LENGTH'
          ,'PROID_LINK_ID:INVALID_PROID_Link_ID:ALLOW','PROID_LINK_ID:INVALID_PROID_Link_ID:LENGTH'
          ,'SUB_PRODUCT_NAME:INVALID_SUB_PRODUCT_NAME:ALLOW'
          ,'AUTH_FAIL_STATUS:INVALID_AUTH_FAIL_STATUS:ALLOW','AUTH_FAIL_STATUS:INVALID_AUTH_FAIL_STATUS:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_UNIQUE_IDENTITY_COUNT(1),Fields.InvalidMessage_UNIQUE_IDENTITY_COUNT(2)
          ,Fields.InvalidMessage_SELECTED_SSN(1),Fields.InvalidMessage_SELECTED_SSN(2)
          ,Fields.InvalidMessage_AUTH_SCORE(1),Fields.InvalidMessage_AUTH_SCORE(2)
          ,Fields.InvalidMessage_AUTH_FAIL(1),Fields.InvalidMessage_AUTH_FAIL(2)
          ,Fields.InvalidMessage_NAME(1)
          ,Fields.InvalidMessage_AUTH_STATUS(1),Fields.InvalidMessage_AUTH_STATUS(2)
          ,Fields.InvalidMessage_VERIF_STATUS(1),Fields.InvalidMessage_VERIF_STATUS(2)
          ,Fields.InvalidMessage_QUIZ_STATUS(1),Fields.InvalidMessage_QUIZ_STATUS(2)
          ,Fields.InvalidMessage_ID_DISCOVERY_LINK_ID(1),Fields.InvalidMessage_ID_DISCOVERY_LINK_ID(2)
          ,Fields.InvalidMessage_PROID_LINK_ID(1),Fields.InvalidMessage_PROID_LINK_ID(2)
          ,Fields.InvalidMessage_SUB_PRODUCT_NAME(1)
          ,Fields.InvalidMessage_AUTH_FAIL_STATUS(1),Fields.InvalidMessage_AUTH_FAIL_STATUS(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.UNIQUE_IDENTITY_COUNT_ALLOW_ErrorCount,le.UNIQUE_IDENTITY_COUNT_LENGTH_ErrorCount
          ,le.SELECTED_SSN_ALLOW_ErrorCount,le.SELECTED_SSN_LENGTH_ErrorCount
          ,le.AUTH_SCORE_ALLOW_ErrorCount,le.AUTH_SCORE_LENGTH_ErrorCount
          ,le.AUTH_FAIL_ALLOW_ErrorCount,le.AUTH_FAIL_LENGTH_ErrorCount
          ,le.NAME_ALLOW_ErrorCount
          ,le.AUTH_STATUS_ALLOW_ErrorCount,le.AUTH_STATUS_LENGTH_ErrorCount
          ,le.VERIF_STATUS_ALLOW_ErrorCount,le.VERIF_STATUS_LENGTH_ErrorCount
          ,le.QUIZ_STATUS_ALLOW_ErrorCount,le.QUIZ_STATUS_LENGTH_ErrorCount
          ,le.ID_DISCOVERY_LINK_ID_ALLOW_ErrorCount,le.ID_DISCOVERY_LINK_ID_LENGTH_ErrorCount
          ,le.PROID_LINK_ID_ALLOW_ErrorCount,le.PROID_LINK_ID_LENGTH_ErrorCount
          ,le.SUB_PRODUCT_NAME_ALLOW_ErrorCount
          ,le.AUTH_FAIL_STATUS_ALLOW_ErrorCount,le.AUTH_FAIL_STATUS_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.UNIQUE_IDENTITY_COUNT_ALLOW_ErrorCount,le.UNIQUE_IDENTITY_COUNT_LENGTH_ErrorCount
          ,le.SELECTED_SSN_ALLOW_ErrorCount,le.SELECTED_SSN_LENGTH_ErrorCount
          ,le.AUTH_SCORE_ALLOW_ErrorCount,le.AUTH_SCORE_LENGTH_ErrorCount
          ,le.AUTH_FAIL_ALLOW_ErrorCount,le.AUTH_FAIL_LENGTH_ErrorCount
          ,le.NAME_ALLOW_ErrorCount
          ,le.AUTH_STATUS_ALLOW_ErrorCount,le.AUTH_STATUS_LENGTH_ErrorCount
          ,le.VERIF_STATUS_ALLOW_ErrorCount,le.VERIF_STATUS_LENGTH_ErrorCount
          ,le.QUIZ_STATUS_ALLOW_ErrorCount,le.QUIZ_STATUS_LENGTH_ErrorCount
          ,le.ID_DISCOVERY_LINK_ID_ALLOW_ErrorCount,le.ID_DISCOVERY_LINK_ID_LENGTH_ErrorCount
          ,le.PROID_LINK_ID_ALLOW_ErrorCount,le.PROID_LINK_ID_LENGTH_ErrorCount
          ,le.SUB_PRODUCT_NAME_ALLOW_ErrorCount
          ,le.AUTH_FAIL_STATUS_ALLOW_ErrorCount,le.AUTH_FAIL_STATUS_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,22,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT32.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT32.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;

IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_bk_main)
    UNSIGNED1 date_created_Invalid;
    UNSIGNED1 case_number_Invalid;
    UNSIGNED1 orig_case_number_Invalid;
    UNSIGNED1 date_filed_Invalid;
    UNSIGNED1 orig_filing_date_Invalid;
    UNSIGNED1 reopen_date_Invalid;
    UNSIGNED1 case_closing_date_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_bk_main)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_bk_main) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.date_created_Invalid := Fields.InValid_date_created((SALT30.StrType)le.date_created);
    SELF.case_number_Invalid := Fields.InValid_case_number((SALT30.StrType)le.case_number);
    SELF.orig_case_number_Invalid := Fields.InValid_orig_case_number((SALT30.StrType)le.orig_case_number);
    SELF.date_filed_Invalid := Fields.InValid_date_filed((SALT30.StrType)le.date_filed);
    SELF.orig_filing_date_Invalid := Fields.InValid_orig_filing_date((SALT30.StrType)le.orig_filing_date);
    SELF.reopen_date_Invalid := Fields.InValid_reopen_date((SALT30.StrType)le.reopen_date);
    SELF.case_closing_date_Invalid := Fields.InValid_case_closing_date((SALT30.StrType)le.case_closing_date);
    SELF.fname_Invalid := Fields.InValid_fname((SALT30.StrType)le.fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT30.StrType)le.mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT30.StrType)le.lname);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.date_created_Invalid << 0 ) + ( le.case_number_Invalid << 2 ) + ( le.orig_case_number_Invalid << 4 ) + ( le.date_filed_Invalid << 6 ) + ( le.orig_filing_date_Invalid << 8 ) + ( le.reopen_date_Invalid << 10 ) + ( le.case_closing_date_Invalid << 12 ) + ( le.fname_Invalid << 14 ) + ( le.mname_Invalid << 16 ) + ( le.lname_Invalid << 18 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_bk_main);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.date_created_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.case_number_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.orig_case_number_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.date_filed_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.orig_filing_date_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.reopen_date_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.case_closing_date_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.source;
    TotalCnt := COUNT(GROUP); // Number of records in total
    date_created_ALLOW_ErrorCount := COUNT(GROUP,h.date_created_Invalid=1);
    date_created_LENGTH_ErrorCount := COUNT(GROUP,h.date_created_Invalid=2);
    date_created_Total_ErrorCount := COUNT(GROUP,h.date_created_Invalid>0);
    case_number_ALLOW_ErrorCount := COUNT(GROUP,h.case_number_Invalid=1);
    case_number_LENGTH_ErrorCount := COUNT(GROUP,h.case_number_Invalid=2);
    case_number_Total_ErrorCount := COUNT(GROUP,h.case_number_Invalid>0);
    orig_case_number_ALLOW_ErrorCount := COUNT(GROUP,h.orig_case_number_Invalid=1);
    orig_case_number_LENGTH_ErrorCount := COUNT(GROUP,h.orig_case_number_Invalid=2);
    orig_case_number_Total_ErrorCount := COUNT(GROUP,h.orig_case_number_Invalid>0);
    date_filed_ALLOW_ErrorCount := COUNT(GROUP,h.date_filed_Invalid=1);
    date_filed_LENGTH_ErrorCount := COUNT(GROUP,h.date_filed_Invalid=2);
    date_filed_Total_ErrorCount := COUNT(GROUP,h.date_filed_Invalid>0);
    orig_filing_date_ALLOW_ErrorCount := COUNT(GROUP,h.orig_filing_date_Invalid=1);
    orig_filing_date_LENGTH_ErrorCount := COUNT(GROUP,h.orig_filing_date_Invalid=2);
    orig_filing_date_Total_ErrorCount := COUNT(GROUP,h.orig_filing_date_Invalid>0);
    reopen_date_ALLOW_ErrorCount := COUNT(GROUP,h.reopen_date_Invalid=1);
    reopen_date_LENGTH_ErrorCount := COUNT(GROUP,h.reopen_date_Invalid=2);
    reopen_date_Total_ErrorCount := COUNT(GROUP,h.reopen_date_Invalid>0);
    case_closing_date_ALLOW_ErrorCount := COUNT(GROUP,h.case_closing_date_Invalid=1);
    case_closing_date_LENGTH_ErrorCount := COUNT(GROUP,h.case_closing_date_Invalid=2);
    case_closing_date_Total_ErrorCount := COUNT(GROUP,h.case_closing_date_Invalid>0);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_LENGTH_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_LENGTH_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_LENGTH_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r,source,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.source;
    UNSIGNED1 ErrNum := CHOOSE(c,le.date_created_Invalid,le.case_number_Invalid,le.orig_case_number_Invalid,le.date_filed_Invalid,le.orig_filing_date_Invalid,le.reopen_date_Invalid,le.case_closing_date_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_date_created(le.date_created_Invalid),Fields.InvalidMessage_case_number(le.case_number_Invalid),Fields.InvalidMessage_orig_case_number(le.orig_case_number_Invalid),Fields.InvalidMessage_date_filed(le.date_filed_Invalid),Fields.InvalidMessage_orig_filing_date(le.orig_filing_date_Invalid),Fields.InvalidMessage_reopen_date(le.reopen_date_Invalid),Fields.InvalidMessage_case_closing_date(le.case_closing_date_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.date_created_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.case_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_case_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_filed_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_filing_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.reopen_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.case_closing_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'date_created','case_number','orig_case_number','date_filed','orig_filing_date','reopen_date','case_closing_date','fname','mname','lname','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_alnum','invalid_alnum','invalid_date','invalid_date','invalid_date','invalid_date','invalid_name','invalid_name','invalid_name','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.date_created,(SALT30.StrType)le.case_number,(SALT30.StrType)le.orig_case_number,(SALT30.StrType)le.date_filed,(SALT30.StrType)le.orig_filing_date,(SALT30.StrType)le.reopen_date,(SALT30.StrType)le.case_closing_date,(SALT30.StrType)le.fname,(SALT30.StrType)le.mname,(SALT30.StrType)le.lname,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source;
      SELF.ruledesc := CHOOSE(c
          ,'date_created:invalid_date:ALLOW','date_created:invalid_date:LENGTH'
          ,'case_number:invalid_alnum:ALLOW','case_number:invalid_alnum:LENGTH'
          ,'orig_case_number:invalid_alnum:ALLOW','orig_case_number:invalid_alnum:LENGTH'
          ,'date_filed:invalid_date:ALLOW','date_filed:invalid_date:LENGTH'
          ,'orig_filing_date:invalid_date:ALLOW','orig_filing_date:invalid_date:LENGTH'
          ,'reopen_date:invalid_date:ALLOW','reopen_date:invalid_date:LENGTH'
          ,'case_closing_date:invalid_date:ALLOW','case_closing_date:invalid_date:LENGTH'
          ,'fname:invalid_name:ALLOW','fname:invalid_name:LENGTH'
          ,'mname:invalid_name:ALLOW','mname:invalid_name:LENGTH'
          ,'lname:invalid_name:ALLOW','lname:invalid_name:LENGTH','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.date_created_ALLOW_ErrorCount,le.date_created_LENGTH_ErrorCount
          ,le.case_number_ALLOW_ErrorCount,le.case_number_LENGTH_ErrorCount
          ,le.orig_case_number_ALLOW_ErrorCount,le.orig_case_number_LENGTH_ErrorCount
          ,le.date_filed_ALLOW_ErrorCount,le.date_filed_LENGTH_ErrorCount
          ,le.orig_filing_date_ALLOW_ErrorCount,le.orig_filing_date_LENGTH_ErrorCount
          ,le.reopen_date_ALLOW_ErrorCount,le.reopen_date_LENGTH_ErrorCount
          ,le.case_closing_date_ALLOW_ErrorCount,le.case_closing_date_LENGTH_ErrorCount
          ,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount
          ,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount
          ,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.date_created_ALLOW_ErrorCount,le.date_created_LENGTH_ErrorCount
          ,le.case_number_ALLOW_ErrorCount,le.case_number_LENGTH_ErrorCount
          ,le.orig_case_number_ALLOW_ErrorCount,le.orig_case_number_LENGTH_ErrorCount
          ,le.date_filed_ALLOW_ErrorCount,le.date_filed_LENGTH_ErrorCount
          ,le.orig_filing_date_ALLOW_ErrorCount,le.orig_filing_date_LENGTH_ErrorCount
          ,le.reopen_date_ALLOW_ErrorCount,le.reopen_date_LENGTH_ErrorCount
          ,le.case_closing_date_ALLOW_ErrorCount,le.case_closing_date_LENGTH_ErrorCount
          ,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount
          ,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount
          ,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,20,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      SALT30.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT30.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;

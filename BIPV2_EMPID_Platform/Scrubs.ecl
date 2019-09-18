IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_EmpID)
    UNSIGNED1 isCorpEnhanced_Invalid;
    UNSIGNED1 contact_job_title_derived_Invalid;
    UNSIGNED1 cname_devanitize_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_EmpID)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_EmpID) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.isCorpEnhanced_Invalid := Fields.InValid_isCorpEnhanced((SALT30.StrType)le.isCorpEnhanced);
    SELF.contact_job_title_derived_Invalid := Fields.InValid_contact_job_title_derived((SALT30.StrType)le.contact_job_title_derived);
    SELF.cname_devanitize_Invalid := Fields.InValid_cname_devanitize((SALT30.StrType)le.cname_devanitize);
    SELF.zip_Invalid := Fields.InValid_zip((SALT30.StrType)le.zip);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT30.StrType)le.zip4);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.isCorpEnhanced_Invalid << 0 ) + ( le.contact_job_title_derived_Invalid << 2 ) + ( le.cname_devanitize_Invalid << 3 ) + ( le.zip_Invalid << 5 ) + ( le.zip4_Invalid << 6 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_EmpID);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.isCorpEnhanced_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.contact_job_title_derived_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.cname_devanitize_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.rcid=RIGHT.rcid AND (LEFT.isCorpEnhanced_Invalid <> RIGHT.isCorpEnhanced_Invalid OR LEFT.contact_job_title_derived_Invalid <> RIGHT.contact_job_title_derived_Invalid OR LEFT.cname_devanitize_Invalid <> RIGHT.cname_devanitize_Invalid OR LEFT.zip_Invalid <> RIGHT.zip_Invalid OR LEFT.zip4_Invalid <> RIGHT.zip4_Invalid),TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.source;
    TotalCnt := COUNT(GROUP); // Number of records in total
    isCorpEnhanced_ALLOW_ErrorCount := COUNT(GROUP,h.isCorpEnhanced_Invalid=1);
    isCorpEnhanced_LENGTH_ErrorCount := COUNT(GROUP,h.isCorpEnhanced_Invalid=2);
    isCorpEnhanced_Total_ErrorCount := COUNT(GROUP,h.isCorpEnhanced_Invalid>0);
    contact_job_title_derived_ENUM_ErrorCount := COUNT(GROUP,h.contact_job_title_derived_Invalid=1);
    cname_devanitize_CAPS_ErrorCount := COUNT(GROUP,h.cname_devanitize_Invalid=1);
    cname_devanitize_ALLOW_ErrorCount := COUNT(GROUP,h.cname_devanitize_Invalid=2);
    cname_devanitize_Total_ErrorCount := COUNT(GROUP,h.cname_devanitize_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_LENGTH_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.isCorpEnhanced_Invalid,le.contact_job_title_derived_Invalid,le.cname_devanitize_Invalid,le.zip_Invalid,le.zip4_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_isCorpEnhanced(le.isCorpEnhanced_Invalid),Fields.InvalidMessage_contact_job_title_derived(le.contact_job_title_derived_Invalid),Fields.InvalidMessage_cname_devanitize(le.cname_devanitize_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.isCorpEnhanced_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.contact_job_title_derived_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.cname_devanitize_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'isCorpEnhanced','contact_job_title_derived','cname_devanitize','zip','zip4','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'isNoCorp','isOwner','multiword','number','hasZip4','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.isCorpEnhanced,(SALT30.StrType)le.contact_job_title_derived,(SALT30.StrType)le.cname_devanitize,(SALT30.StrType)le.zip,(SALT30.StrType)le.zip4,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,5,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source;
      SELF.ruledesc := CHOOSE(c
          ,'isCorpEnhanced:isNoCorp:ALLOW','isCorpEnhanced:isNoCorp:LENGTH'
          ,'contact_job_title_derived:isOwner:ENUM'
          ,'cname_devanitize:multiword:CAPS','cname_devanitize:multiword:ALLOW'
          ,'zip:number:ALLOW'
          ,'zip4:hasZip4:ALLOW','zip4:hasZip4:LENGTH','UNKNOWN');
      SELF.ErrorMessage := '';
      SELF.rulecnt := CHOOSE(c
          ,le.isCorpEnhanced_ALLOW_ErrorCount,le.isCorpEnhanced_LENGTH_ErrorCount
          ,le.contact_job_title_derived_ENUM_ErrorCount
          ,le.cname_devanitize_CAPS_ErrorCount,le.cname_devanitize_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.isCorpEnhanced_ALLOW_ErrorCount,le.isCorpEnhanced_LENGTH_ErrorCount
          ,le.contact_job_title_derived_ENUM_ErrorCount
          ,le.cname_devanitize_CAPS_ErrorCount,le.cname_devanitize_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,8,Into(LEFT,COUNTER));
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

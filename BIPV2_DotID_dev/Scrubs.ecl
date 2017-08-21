IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_DOT)
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 contact_ssn_Invalid;
    UNSIGNED1 contact_email_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_DOT)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_DOT) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.company_name_Invalid := Fields.InValid_company_name((SALT30.StrType)le.company_name);
    SELF.st_Invalid := Fields.InValid_st((SALT30.StrType)le.st);
    SELF.zip_Invalid := Fields.InValid_zip((SALT30.StrType)le.zip);
    SELF.contact_ssn_Invalid := Fields.InValid_contact_ssn((SALT30.StrType)le.contact_ssn);
    SELF.contact_email_Invalid := Fields.InValid_contact_email((SALT30.StrType)le.contact_email);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.company_name_Invalid << 0 ) + ( le.st_Invalid << 2 ) + ( le.zip_Invalid << 4 ) + ( le.contact_ssn_Invalid << 5 ) + ( le.contact_email_Invalid << 6 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_DOT);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.st_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.contact_ssn_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.contact_email_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.rcid=RIGHT.rcid AND (LEFT.company_name_Invalid <> RIGHT.company_name_Invalid OR LEFT.st_Invalid <> RIGHT.st_Invalid OR LEFT.zip_Invalid <> RIGHT.zip_Invalid OR LEFT.contact_ssn_Invalid <> RIGHT.contact_ssn_Invalid OR LEFT.contact_email_Invalid <> RIGHT.contact_email_Invalid),TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.source;
    TotalCnt := COUNT(GROUP); // Number of records in total
    company_name_CAPS_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    company_name_ALLOW_ErrorCount := COUNT(GROUP,h.company_name_Invalid=2);
    company_name_CUSTOM_ErrorCount := COUNT(GROUP,h.company_name_Invalid=3);
    company_name_Total_ErrorCount := COUNT(GROUP,h.company_name_Invalid>0);
    st_CAPS_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    contact_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.contact_ssn_Invalid=1);
    contact_email_CAPS_ErrorCount := COUNT(GROUP,h.contact_email_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.company_name_Invalid,le.st_Invalid,le.zip_Invalid,le.contact_ssn_Invalid,le.contact_email_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_company_name(le.company_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_contact_ssn(le.contact_ssn_Invalid),Fields.InvalidMessage_contact_email(le.contact_email_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.company_name_Invalid,'CAPS','ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_ssn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_email_Invalid,'CAPS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'company_name','st','zip','contact_ssn','contact_email','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'cname','alpha','number','number','upper','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.company_name,(SALT30.StrType)le.st,(SALT30.StrType)le.zip,(SALT30.StrType)le.contact_ssn,(SALT30.StrType)le.contact_email,'***SALTBUG***');
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
          ,'company_name:cname:CAPS','company_name:cname:ALLOW','company_name:cname:CUSTOM'
          ,'st:alpha:CAPS','st:alpha:ALLOW'
          ,'zip:number:ALLOW'
          ,'contact_ssn:number:ALLOW'
          ,'contact_email:upper:CAPS','UNKNOWN');
      SELF.ErrorMessage := '';
      SELF.rulecnt := CHOOSE(c
          ,le.company_name_CAPS_ErrorCount,le.company_name_ALLOW_ErrorCount,le.company_name_CUSTOM_ErrorCount
          ,le.st_CAPS_ErrorCount,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.contact_ssn_ALLOW_ErrorCount
          ,le.contact_email_CAPS_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.company_name_CAPS_ErrorCount,le.company_name_ALLOW_ErrorCount,le.company_name_CUSTOM_ErrorCount
          ,le.st_CAPS_ErrorCount,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.contact_ssn_ALLOW_ErrorCount
          ,le.contact_email_CAPS_ErrorCount,0) / le.TotalCnt + 0.5;
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

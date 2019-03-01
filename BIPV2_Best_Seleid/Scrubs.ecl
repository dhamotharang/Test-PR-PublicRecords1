IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_Base)
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 company_fein_Invalid;
    UNSIGNED1 company_phone_Invalid;
    UNSIGNED1 duns_number_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 fips_state_Invalid;
    UNSIGNED1 fips_county_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Base)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_Base) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.company_name_Invalid := Fields.InValid_company_name((SALT30.StrType)le.company_name);
    SELF.company_fein_Invalid := Fields.InValid_company_fein((SALT30.StrType)le.company_fein);
    SELF.company_phone_Invalid := Fields.InValid_company_phone((SALT30.StrType)le.company_phone);
    SELF.duns_number_Invalid := Fields.InValid_duns_number((SALT30.StrType)le.duns_number);
    SELF.st_Invalid := Fields.InValid_st((SALT30.StrType)le.st);
    SELF.zip_Invalid := Fields.InValid_zip((SALT30.StrType)le.zip);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT30.StrType)le.zip4);
    SELF.fips_state_Invalid := Fields.InValid_fips_state((SALT30.StrType)le.fips_state);
    SELF.fips_county_Invalid := Fields.InValid_fips_county((SALT30.StrType)le.fips_county);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.company_name_Invalid << 0 ) + ( le.company_fein_Invalid << 1 ) + ( le.company_phone_Invalid << 2 ) + ( le.duns_number_Invalid << 3 ) + ( le.st_Invalid << 4 ) + ( le.zip_Invalid << 6 ) + ( le.zip4_Invalid << 7 ) + ( le.fips_state_Invalid << 8 ) + ( le.fips_county_Invalid << 9 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Base);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.company_fein_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.company_phone_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.duns_number_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.fips_state_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.fips_county_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.rcid=RIGHT.rcid AND (LEFT.company_name_Invalid <> RIGHT.company_name_Invalid OR LEFT.company_fein_Invalid <> RIGHT.company_fein_Invalid OR LEFT.company_phone_Invalid <> RIGHT.company_phone_Invalid OR LEFT.duns_number_Invalid <> RIGHT.duns_number_Invalid OR LEFT.st_Invalid <> RIGHT.st_Invalid OR LEFT.zip_Invalid <> RIGHT.zip_Invalid OR LEFT.zip4_Invalid <> RIGHT.zip4_Invalid OR LEFT.fips_state_Invalid <> RIGHT.fips_state_Invalid OR LEFT.fips_county_Invalid <> RIGHT.fips_county_Invalid),TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.source_for_votes;
    TotalCnt := COUNT(GROUP); // Number of records in total
    company_name_CAPS_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    company_fein_ALLOW_ErrorCount := COUNT(GROUP,h.company_fein_Invalid=1);
    company_phone_ALLOW_ErrorCount := COUNT(GROUP,h.company_phone_Invalid=1);
    duns_number_ALLOW_ErrorCount := COUNT(GROUP,h.duns_number_Invalid=1);
    st_CAPS_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    fips_state_ALLOW_ErrorCount := COUNT(GROUP,h.fips_state_Invalid=1);
    fips_county_ALLOW_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,source_for_votes,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.source_for_votes;
    UNSIGNED1 ErrNum := CHOOSE(c,le.company_name_Invalid,le.company_fein_Invalid,le.company_phone_Invalid,le.duns_number_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.fips_state_Invalid,le.fips_county_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_company_name(le.company_name_Invalid),Fields.InvalidMessage_company_fein(le.company_fein_Invalid),Fields.InvalidMessage_company_phone(le.company_phone_Invalid),Fields.InvalidMessage_duns_number(le.duns_number_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_fips_state(le.fips_state_Invalid),Fields.InvalidMessage_fips_county(le.fips_county_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.company_name_Invalid,'CAPS','UNKNOWN')
          ,CHOOSE(le.company_fein_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.duns_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fips_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fips_county_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'company_name','company_fein','company_phone','duns_number','st','zip','zip4','fips_state','fips_county','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'cname','number','number','number','alpha','number','number','number','number','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.company_name,(SALT30.StrType)le.company_fein,(SALT30.StrType)le.company_phone,(SALT30.StrType)le.duns_number,(SALT30.StrType)le.st,(SALT30.StrType)le.zip,(SALT30.StrType)le.zip4,(SALT30.StrType)le.fips_state,(SALT30.StrType)le.fips_county,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,9,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source_for_votes;
      SELF.ruledesc := CHOOSE(c
          ,'company_name:cname:CAPS'
          ,'company_fein:number:ALLOW'
          ,'company_phone:number:ALLOW'
          ,'duns_number:number:ALLOW'
          ,'st:alpha:CAPS','st:alpha:ALLOW'
          ,'zip:number:ALLOW'
          ,'zip4:number:ALLOW'
          ,'fips_state:number:ALLOW'
          ,'fips_county:number:ALLOW','UNKNOWN');
      SELF.ErrorMessage := '';
      SELF.rulecnt := CHOOSE(c
          ,le.company_name_CAPS_ErrorCount
          ,le.company_fein_ALLOW_ErrorCount
          ,le.company_phone_ALLOW_ErrorCount
          ,le.duns_number_ALLOW_ErrorCount
          ,le.st_CAPS_ErrorCount,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.fips_state_ALLOW_ErrorCount
          ,le.fips_county_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.company_name_CAPS_ErrorCount
          ,le.company_fein_ALLOW_ErrorCount
          ,le.company_phone_ALLOW_ErrorCount
          ,le.duns_number_ALLOW_ErrorCount
          ,le.st_CAPS_ErrorCount,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.fips_state_ALLOW_ErrorCount
          ,le.fips_county_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,10,Into(LEFT,COUNTER));
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

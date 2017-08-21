IMPORT ut,SALT35;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_BASE)
    UNSIGNED1 isContact_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 company_fein_Invalid;
    UNSIGNED1 company_phone_Invalid;
    UNSIGNED1 contact_ssn_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_BASE)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_BASE) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.isContact_Invalid := Fields.InValid_isContact((SALT35.StrType)le.isContact);
    SELF.fname_Invalid := Fields.InValid_fname((SALT35.StrType)le.fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT35.StrType)le.mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT35.StrType)le.lname);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT35.StrType)le.name_suffix);
    SELF.company_name_Invalid := Fields.InValid_company_name((SALT35.StrType)le.company_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT35.StrType)le.v_city_name);
    SELF.st_Invalid := Fields.InValid_st((SALT35.StrType)le.st);
    SELF.zip_Invalid := Fields.InValid_zip((SALT35.StrType)le.zip);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT35.StrType)le.zip4);
    SELF.company_fein_Invalid := Fields.InValid_company_fein((SALT35.StrType)le.company_fein);
    SELF.company_phone_Invalid := Fields.InValid_company_phone((SALT35.StrType)le.company_phone);
    SELF.contact_ssn_Invalid := Fields.InValid_contact_ssn((SALT35.StrType)le.contact_ssn);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_BASE);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.isContact_Invalid << 0 ) + ( le.fname_Invalid << 2 ) + ( le.mname_Invalid << 3 ) + ( le.lname_Invalid << 4 ) + ( le.name_suffix_Invalid << 5 ) + ( le.company_name_Invalid << 6 ) + ( le.v_city_name_Invalid << 7 ) + ( le.st_Invalid << 9 ) + ( le.zip_Invalid << 11 ) + ( le.zip4_Invalid << 13 ) + ( le.company_fein_Invalid << 15 ) + ( le.company_phone_Invalid << 16 ) + ( le.contact_ssn_Invalid << 17 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_BASE);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.isContact_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.st_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.company_fein_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.company_phone_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.contact_ssn_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.rcid=RIGHT.rcid AND (LEFT.isContact_Invalid <> RIGHT.isContact_Invalid OR LEFT.fname_Invalid <> RIGHT.fname_Invalid OR LEFT.mname_Invalid <> RIGHT.mname_Invalid OR LEFT.lname_Invalid <> RIGHT.lname_Invalid OR LEFT.name_suffix_Invalid <> RIGHT.name_suffix_Invalid OR LEFT.company_name_Invalid <> RIGHT.company_name_Invalid OR LEFT.v_city_name_Invalid <> RIGHT.v_city_name_Invalid OR LEFT.st_Invalid <> RIGHT.st_Invalid OR LEFT.zip_Invalid <> RIGHT.zip_Invalid OR LEFT.zip4_Invalid <> RIGHT.zip4_Invalid OR LEFT.company_fein_Invalid <> RIGHT.company_fein_Invalid OR LEFT.company_phone_Invalid <> RIGHT.company_phone_Invalid OR LEFT.contact_ssn_Invalid <> RIGHT.contact_ssn_Invalid),TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.source;
    TotalCnt := COUNT(GROUP); // Number of records in total
    isContact_ALLOW_ErrorCount := COUNT(GROUP,h.isContact_Invalid=1);
    isContact_LENGTH_ErrorCount := COUNT(GROUP,h.isContact_Invalid=2);
    isContact_Total_ErrorCount := COUNT(GROUP,h.isContact_Invalid>0);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    company_name_LENGTH_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    v_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=2);
    v_city_name_Total_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid>0);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_LENGTH_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTH_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_LENGTH_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    company_fein_ALLOW_ErrorCount := COUNT(GROUP,h.company_fein_Invalid=1);
    company_phone_ALLOW_ErrorCount := COUNT(GROUP,h.company_phone_Invalid=1);
    contact_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.contact_ssn_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,source,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT35.StrType ErrorMessage;
    SALT35.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.source;
    UNSIGNED1 ErrNum := CHOOSE(c,le.isContact_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.company_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.company_fein_Invalid,le.company_phone_Invalid,le.contact_ssn_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_isContact(le.isContact_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_company_name(le.company_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_company_fein(le.company_fein_Invalid),Fields.InvalidMessage_company_phone(le.company_phone_Invalid),Fields.InvalidMessage_contact_ssn(le.contact_ssn_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.isContact_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.company_fein_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_ssn_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'isContact','fname','mname','lname','name_suffix','company_name','v_city_name','st','zip','zip4','company_fein','company_phone','contact_ssn','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'fld_contact','NAME','NAME','NAME','NAME','Noblanks','CITY','alpha_st','zip5','hasZip4','number','number','number','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT35.StrType)le.isContact,(SALT35.StrType)le.fname,(SALT35.StrType)le.mname,(SALT35.StrType)le.lname,(SALT35.StrType)le.name_suffix,(SALT35.StrType)le.company_name,(SALT35.StrType)le.v_city_name,(SALT35.StrType)le.st,(SALT35.StrType)le.zip,(SALT35.StrType)le.zip4,(SALT35.StrType)le.company_fein,(SALT35.StrType)le.company_phone,(SALT35.StrType)le.contact_ssn,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,13,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT35.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source;
      SELF.ruledesc := CHOOSE(c
          ,'isContact:fld_contact:ALLOW','isContact:fld_contact:LENGTH'
          ,'fname:NAME:ALLOW'
          ,'mname:NAME:ALLOW'
          ,'lname:NAME:ALLOW'
          ,'name_suffix:NAME:ALLOW'
          ,'company_name:Noblanks:LENGTH'
          ,'v_city_name:CITY:ALLOW','v_city_name:CITY:LENGTH'
          ,'st:alpha_st:ALLOW','st:alpha_st:LENGTH'
          ,'zip:zip5:ALLOW','zip:zip5:LENGTH'
          ,'zip4:hasZip4:ALLOW','zip4:hasZip4:LENGTH'
          ,'company_fein:number:ALLOW'
          ,'company_phone:number:ALLOW'
          ,'contact_ssn:number:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_isContact(1),Fields.InvalidMessage_isContact(2)
          ,Fields.InvalidMessage_fname(1)
          ,Fields.InvalidMessage_mname(1)
          ,Fields.InvalidMessage_lname(1)
          ,Fields.InvalidMessage_name_suffix(1)
          ,Fields.InvalidMessage_company_name(1)
          ,Fields.InvalidMessage_v_city_name(1),Fields.InvalidMessage_v_city_name(2)
          ,Fields.InvalidMessage_st(1),Fields.InvalidMessage_st(2)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2)
          ,Fields.InvalidMessage_zip4(1),Fields.InvalidMessage_zip4(2)
          ,Fields.InvalidMessage_company_fein(1)
          ,Fields.InvalidMessage_company_phone(1)
          ,Fields.InvalidMessage_contact_ssn(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.isContact_ALLOW_ErrorCount,le.isContact_LENGTH_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.company_name_LENGTH_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTH_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.company_fein_ALLOW_ErrorCount
          ,le.company_phone_ALLOW_ErrorCount
          ,le.contact_ssn_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.isContact_ALLOW_ErrorCount,le.isContact_LENGTH_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.company_name_LENGTH_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTH_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.company_fein_ALLOW_ErrorCount
          ,le.company_phone_ALLOW_ErrorCount
          ,le.contact_ssn_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,18,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT35.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT35.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;

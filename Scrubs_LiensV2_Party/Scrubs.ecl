IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_Liens_Party)
    UNSIGNED1 orig_full_debtorname_Invalid;
    UNSIGNED1 orig_name_Invalid;
    UNSIGNED1 orig_lname_Invalid;
    UNSIGNED1 orig_suffix_Invalid;
    UNSIGNED1 tax_id_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 orig_address1_Invalid;
    UNSIGNED1 orig_address2_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 orig_zip5_Invalid;
    UNSIGNED1 orig_county_Invalid;
    UNSIGNED1 orig_country_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Liens_Party)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_Liens_Party) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.orig_full_debtorname_Invalid := Fields.InValid_orig_full_debtorname((SALT30.StrType)le.orig_full_debtorname);
    SELF.orig_name_Invalid := Fields.InValid_orig_name((SALT30.StrType)le.orig_name);
    SELF.orig_lname_Invalid := Fields.InValid_orig_lname((SALT30.StrType)le.orig_lname);
    SELF.orig_suffix_Invalid := Fields.InValid_orig_suffix((SALT30.StrType)le.orig_suffix);
    SELF.tax_id_Invalid := Fields.InValid_tax_id((SALT30.StrType)le.tax_id);
    SELF.ssn_Invalid := Fields.InValid_ssn((SALT30.StrType)le.ssn);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT30.StrType)le.name_suffix);
    SELF.orig_address1_Invalid := Fields.InValid_orig_address1((SALT30.StrType)le.orig_address1);
    SELF.orig_address2_Invalid := Fields.InValid_orig_address2((SALT30.StrType)le.orig_address2);
    SELF.orig_city_Invalid := Fields.InValid_orig_city((SALT30.StrType)le.orig_city);
    SELF.orig_state_Invalid := Fields.InValid_orig_state((SALT30.StrType)le.orig_state);
    SELF.orig_zip5_Invalid := Fields.InValid_orig_zip5((SALT30.StrType)le.orig_zip5);
    SELF.orig_county_Invalid := Fields.InValid_orig_county((SALT30.StrType)le.orig_county);
    SELF.orig_country_Invalid := Fields.InValid_orig_country((SALT30.StrType)le.orig_country);
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT30.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT30.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT30.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT30.StrType)le.date_vendor_last_reported);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.orig_full_debtorname_Invalid << 0 ) + ( le.orig_name_Invalid << 1 ) + ( le.orig_lname_Invalid << 2 ) + ( le.orig_suffix_Invalid << 4 ) + ( le.tax_id_Invalid << 5 ) + ( le.ssn_Invalid << 6 ) + ( le.name_suffix_Invalid << 7 ) + ( le.orig_address1_Invalid << 8 ) + ( le.orig_address2_Invalid << 9 ) + ( le.orig_city_Invalid << 10 ) + ( le.orig_state_Invalid << 11 ) + ( le.orig_zip5_Invalid << 12 ) + ( le.orig_county_Invalid << 14 ) + ( le.orig_country_Invalid << 15 ) + ( le.date_first_seen_Invalid << 16 ) + ( le.date_last_seen_Invalid << 18 ) + ( le.date_vendor_first_reported_Invalid << 20 ) + ( le.date_vendor_last_reported_Invalid << 22 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Liens_Party);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.orig_full_debtorname_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.orig_name_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.orig_lname_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.orig_suffix_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.tax_id_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.orig_address1_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.orig_address2_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.orig_zip5_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.orig_county_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.orig_country_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.source_file;
    TotalCnt := COUNT(GROUP); // Number of records in total
    orig_full_debtorname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_full_debtorname_Invalid=1);
    orig_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_name_Invalid=1);
    orig_lname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=1);
    orig_lname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=2);
    orig_lname_Total_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid>0);
    orig_suffix_ENUM_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid=1);
    tax_id_ALLOW_ErrorCount := COUNT(GROUP,h.tax_id_Invalid=1);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    name_suffix_ENUM_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    orig_address1_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address1_Invalid=1);
    orig_address2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address2_Invalid=1);
    orig_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_state_ALLOW_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_zip5_QUOTES_ErrorCount := COUNT(GROUP,h.orig_zip5_Invalid=1);
    orig_zip5_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip5_Invalid=2);
    orig_zip5_LENGTH_ErrorCount := COUNT(GROUP,h.orig_zip5_Invalid=3);
    orig_zip5_Total_ErrorCount := COUNT(GROUP,h.orig_zip5_Invalid>0);
    orig_county_ALLOW_ErrorCount := COUNT(GROUP,h.orig_county_Invalid=1);
    orig_country_ALLOW_ErrorCount := COUNT(GROUP,h.orig_country_Invalid=1);
    date_first_seen_QUOTES_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=2);
    date_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=3);
    date_first_seen_Total_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid>0);
    date_last_seen_QUOTES_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=2);
    date_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=3);
    date_last_seen_Total_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid>0);
    date_vendor_first_reported_QUOTES_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=2);
    date_vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=3);
    date_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid>0);
    date_vendor_last_reported_QUOTES_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    date_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=2);
    date_vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=3);
    date_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r,source_file,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.source_file;
    UNSIGNED1 ErrNum := CHOOSE(c,le.orig_full_debtorname_Invalid,le.orig_name_Invalid,le.orig_lname_Invalid,le.orig_suffix_Invalid,le.tax_id_Invalid,le.ssn_Invalid,le.name_suffix_Invalid,le.orig_address1_Invalid,le.orig_address2_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.orig_zip5_Invalid,le.orig_county_Invalid,le.orig_country_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_orig_full_debtorname(le.orig_full_debtorname_Invalid),Fields.InvalidMessage_orig_name(le.orig_name_Invalid),Fields.InvalidMessage_orig_lname(le.orig_lname_Invalid),Fields.InvalidMessage_orig_suffix(le.orig_suffix_Invalid),Fields.InvalidMessage_tax_id(le.tax_id_Invalid),Fields.InvalidMessage_ssn(le.ssn_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_orig_address1(le.orig_address1_Invalid),Fields.InvalidMessage_orig_address2(le.orig_address2_Invalid),Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Fields.InvalidMessage_orig_zip5(le.orig_zip5_Invalid),Fields.InvalidMessage_orig_county(le.orig_county_Invalid),Fields.InvalidMessage_orig_country(le.orig_country_Invalid),Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.orig_full_debtorname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_lname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_suffix_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.tax_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_address1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_address2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_zip5_Invalid,'QUOTES','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'QUOTES','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'QUOTES','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'QUOTES','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'QUOTES','ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'orig_full_debtorname','orig_name','orig_lname','orig_suffix','tax_id','ssn','name_suffix','orig_address1','orig_address2','orig_city','orig_state','orig_zip5','orig_county','orig_country','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_alpha','invalid_alpha','invalid_name','invalid_name_suffix','invalid_ssn','invalid_ssn','invalid_name_suffix','invalid_alpha','invalid_alpha','invalid_only_alpha','invalid_only_alpha','invalid_zip','invalid_only_alpha','invalid_only_alpha','invalid_date','invalid_date','invalid_date','invalid_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.orig_full_debtorname,(SALT30.StrType)le.orig_name,(SALT30.StrType)le.orig_lname,(SALT30.StrType)le.orig_suffix,(SALT30.StrType)le.tax_id,(SALT30.StrType)le.ssn,(SALT30.StrType)le.name_suffix,(SALT30.StrType)le.orig_address1,(SALT30.StrType)le.orig_address2,(SALT30.StrType)le.orig_city,(SALT30.StrType)le.orig_state,(SALT30.StrType)le.orig_zip5,(SALT30.StrType)le.orig_county,(SALT30.StrType)le.orig_country,(SALT30.StrType)le.date_first_seen,(SALT30.StrType)le.date_last_seen,(SALT30.StrType)le.date_vendor_first_reported,(SALT30.StrType)le.date_vendor_last_reported,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,18,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source_file;
      SELF.ruledesc := CHOOSE(c
          ,'orig_full_debtorname:invalid_alpha:ALLOW'
          ,'orig_name:invalid_alpha:ALLOW'
          ,'orig_lname:invalid_name:ALLOW','orig_lname:invalid_name:LENGTH'
          ,'orig_suffix:invalid_name_suffix:ENUM'
          ,'tax_id:invalid_ssn:ALLOW'
          ,'ssn:invalid_ssn:ALLOW'
          ,'name_suffix:invalid_name_suffix:ENUM'
          ,'orig_address1:invalid_alpha:ALLOW'
          ,'orig_address2:invalid_alpha:ALLOW'
          ,'orig_city:invalid_only_alpha:ALLOW'
          ,'orig_state:invalid_only_alpha:ALLOW'
          ,'orig_zip5:invalid_zip:QUOTES','orig_zip5:invalid_zip:ALLOW','orig_zip5:invalid_zip:LENGTH'
          ,'orig_county:invalid_only_alpha:ALLOW'
          ,'orig_country:invalid_only_alpha:ALLOW'
          ,'date_first_seen:invalid_date:QUOTES','date_first_seen:invalid_date:ALLOW','date_first_seen:invalid_date:LENGTH'
          ,'date_last_seen:invalid_date:QUOTES','date_last_seen:invalid_date:ALLOW','date_last_seen:invalid_date:LENGTH'
          ,'date_vendor_first_reported:invalid_date:QUOTES','date_vendor_first_reported:invalid_date:ALLOW','date_vendor_first_reported:invalid_date:LENGTH'
          ,'date_vendor_last_reported:invalid_date:QUOTES','date_vendor_last_reported:invalid_date:ALLOW','date_vendor_last_reported:invalid_date:LENGTH','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.orig_full_debtorname_ALLOW_ErrorCount
          ,le.orig_name_ALLOW_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_LENGTH_ErrorCount
          ,le.orig_suffix_ENUM_ErrorCount
          ,le.tax_id_ALLOW_ErrorCount
          ,le.ssn_ALLOW_ErrorCount
          ,le.name_suffix_ENUM_ErrorCount
          ,le.orig_address1_ALLOW_ErrorCount
          ,le.orig_address2_ALLOW_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount
          ,le.orig_state_ALLOW_ErrorCount
          ,le.orig_zip5_QUOTES_ErrorCount,le.orig_zip5_ALLOW_ErrorCount,le.orig_zip5_LENGTH_ErrorCount
          ,le.orig_county_ALLOW_ErrorCount
          ,le.orig_country_ALLOW_ErrorCount
          ,le.date_first_seen_QUOTES_ErrorCount,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.date_last_seen_QUOTES_ErrorCount,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTH_ErrorCount
          ,le.date_vendor_first_reported_QUOTES_ErrorCount,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTH_ErrorCount
          ,le.date_vendor_last_reported_QUOTES_ErrorCount,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.orig_full_debtorname_ALLOW_ErrorCount
          ,le.orig_name_ALLOW_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_LENGTH_ErrorCount
          ,le.orig_suffix_ENUM_ErrorCount
          ,le.tax_id_ALLOW_ErrorCount
          ,le.ssn_ALLOW_ErrorCount
          ,le.name_suffix_ENUM_ErrorCount
          ,le.orig_address1_ALLOW_ErrorCount
          ,le.orig_address2_ALLOW_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount
          ,le.orig_state_ALLOW_ErrorCount
          ,le.orig_zip5_QUOTES_ErrorCount,le.orig_zip5_ALLOW_ErrorCount,le.orig_zip5_LENGTH_ErrorCount
          ,le.orig_county_ALLOW_ErrorCount
          ,le.orig_country_ALLOW_ErrorCount
          ,le.date_first_seen_QUOTES_ErrorCount,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.date_last_seen_QUOTES_ErrorCount,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTH_ErrorCount
          ,le.date_vendor_first_reported_QUOTES_ErrorCount,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTH_ErrorCount
          ,le.date_vendor_last_reported_QUOTES_ErrorCount,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,29,Into(LEFT,COUNTER));
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

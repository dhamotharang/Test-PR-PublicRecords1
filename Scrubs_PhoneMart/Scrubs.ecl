IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_PhoneMart)
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 cid_number_Invalid;
    UNSIGNED1 csd_ref_number_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zipcode_Invalid;
    UNSIGNED1 history_flag_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_PhoneMart)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_PhoneMart) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.phone_Invalid := Fields.InValid_phone((SALT30.StrType)le.phone);
    SELF.did_Invalid := Fields.InValid_did((SALT30.StrType)le.did);
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT30.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT30.StrType)le.dt_vendor_last_reported);
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT30.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT30.StrType)le.dt_last_seen);
    SELF.record_type_Invalid := Fields.InValid_record_type((SALT30.StrType)le.record_type);
    SELF.cid_number_Invalid := Fields.InValid_cid_number((SALT30.StrType)le.cid_number);
    SELF.csd_ref_number_Invalid := Fields.InValid_csd_ref_number((SALT30.StrType)le.csd_ref_number);
    SELF.ssn_Invalid := Fields.InValid_ssn((SALT30.StrType)le.ssn);
    SELF.city_Invalid := Fields.InValid_city((SALT30.StrType)le.city);
    SELF.state_Invalid := Fields.InValid_state((SALT30.StrType)le.state);
    SELF.zipcode_Invalid := Fields.InValid_zipcode((SALT30.StrType)le.zipcode);
    SELF.history_flag_Invalid := Fields.InValid_history_flag((SALT30.StrType)le.history_flag);
    SELF.title_Invalid := Fields.InValid_title((SALT30.StrType)le.title);
    SELF.fname_Invalid := Fields.InValid_fname((SALT30.StrType)le.fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT30.StrType)le.mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT30.StrType)le.lname);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT30.StrType)le.name_suffix);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.phone_Invalid << 0 ) + ( le.did_Invalid << 2 ) + ( le.dt_vendor_first_reported_Invalid << 3 ) + ( le.dt_vendor_last_reported_Invalid << 4 ) + ( le.dt_first_seen_Invalid << 5 ) + ( le.dt_last_seen_Invalid << 6 ) + ( le.record_type_Invalid << 7 ) + ( le.cid_number_Invalid << 9 ) + ( le.csd_ref_number_Invalid << 11 ) + ( le.ssn_Invalid << 12 ) + ( le.city_Invalid << 14 ) + ( le.state_Invalid << 16 ) + ( le.zipcode_Invalid << 18 ) + ( le.history_flag_Invalid << 20 ) + ( le.title_Invalid << 21 ) + ( le.fname_Invalid << 23 ) + ( le.mname_Invalid << 25 ) + ( le.lname_Invalid << 27 ) + ( le.name_suffix_Invalid << 29 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_PhoneMart);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.phone_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.did_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.cid_number_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.csd_ref_number_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.city_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.state_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.zipcode_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.history_flag_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.title_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_LENGTH_ErrorCount := COUNT(GROUP,h.phone_Invalid=2);
    phone_Total_ErrorCount := COUNT(GROUP,h.phone_Invalid>0);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    dt_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    record_type_LENGTH_ErrorCount := COUNT(GROUP,h.record_type_Invalid=2);
    record_type_Total_ErrorCount := COUNT(GROUP,h.record_type_Invalid>0);
    cid_number_CAPS_ErrorCount := COUNT(GROUP,h.cid_number_Invalid=1);
    cid_number_ALLOW_ErrorCount := COUNT(GROUP,h.cid_number_Invalid=2);
    cid_number_Total_ErrorCount := COUNT(GROUP,h.cid_number_Invalid>0);
    csd_ref_number_ALLOW_ErrorCount := COUNT(GROUP,h.csd_ref_number_Invalid=1);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    ssn_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_Invalid=2);
    ssn_Total_ErrorCount := COUNT(GROUP,h.ssn_Invalid>0);
    city_CAPS_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=2);
    city_Total_ErrorCount := COUNT(GROUP,h.city_Invalid>0);
    state_CAPS_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_LENGTH_ErrorCount := COUNT(GROUP,h.state_Invalid=3);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zipcode_ALLOW_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=1);
    zipcode_LENGTH_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=2);
    zipcode_Total_ErrorCount := COUNT(GROUP,h.zipcode_Invalid>0);
    history_flag_LENGTH_ErrorCount := COUNT(GROUP,h.history_flag_Invalid=1);
    title_CAPS_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=2);
    title_Total_ErrorCount := COUNT(GROUP,h.title_Invalid>0);
    fname_CAPS_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    mname_CAPS_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    lname_CAPS_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    name_suffix_CAPS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.phone_Invalid,le.did_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.record_type_Invalid,le.cid_number_Invalid,le.csd_ref_number_Invalid,le.ssn_Invalid,le.city_Invalid,le.state_Invalid,le.zipcode_Invalid,le.history_flag_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_phone(le.phone_Invalid),Fields.InvalidMessage_did(le.did_Invalid),Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_record_type(le.record_type_Invalid),Fields.InvalidMessage_cid_number(le.cid_number_Invalid),Fields.InvalidMessage_csd_ref_number(le.csd_ref_number_Invalid),Fields.InvalidMessage_ssn(le.ssn_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zipcode(le.zipcode_Invalid),Fields.InvalidMessage_history_flag(le.history_flag_Invalid),Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.phone_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.cid_number_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.csd_ref_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zipcode_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.history_flag_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'CAPS','ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'phone','did','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','record_type','cid_number','csd_ref_number','ssn','city','state','zipcode','history_flag','title','fname','mname','lname','name_suffix','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_phone','invalid_number','invalid_date','invalid_date','invalid_date','invalid_date','invalid_record_type','invalid_alpha_numeric','invalid_number','invalid_ssn','invalid_alpha','invalid_state','invalid_zip5','invalid_history_flag','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.phone,(SALT30.StrType)le.did,(SALT30.StrType)le.dt_vendor_first_reported,(SALT30.StrType)le.dt_vendor_last_reported,(SALT30.StrType)le.dt_first_seen,(SALT30.StrType)le.dt_last_seen,(SALT30.StrType)le.record_type,(SALT30.StrType)le.cid_number,(SALT30.StrType)le.csd_ref_number,(SALT30.StrType)le.ssn,(SALT30.StrType)le.city,(SALT30.StrType)le.state,(SALT30.StrType)le.zipcode,(SALT30.StrType)le.history_flag,(SALT30.StrType)le.title,(SALT30.StrType)le.fname,(SALT30.StrType)le.mname,(SALT30.StrType)le.lname,(SALT30.StrType)le.name_suffix,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,19,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'phone:invalid_phone:ALLOW','phone:invalid_phone:LENGTH'
          ,'did:invalid_number:ALLOW'
          ,'dt_vendor_first_reported:invalid_date:ALLOW'
          ,'dt_vendor_last_reported:invalid_date:ALLOW'
          ,'dt_first_seen:invalid_date:ALLOW'
          ,'dt_last_seen:invalid_date:ALLOW'
          ,'record_type:invalid_record_type:ENUM','record_type:invalid_record_type:LENGTH'
          ,'cid_number:invalid_alpha_numeric:CAPS','cid_number:invalid_alpha_numeric:ALLOW'
          ,'csd_ref_number:invalid_number:ALLOW'
          ,'ssn:invalid_ssn:ALLOW','ssn:invalid_ssn:LENGTH'
          ,'city:invalid_alpha:CAPS','city:invalid_alpha:ALLOW'
          ,'state:invalid_state:CAPS','state:invalid_state:ALLOW','state:invalid_state:LENGTH'
          ,'zipcode:invalid_zip5:ALLOW','zipcode:invalid_zip5:LENGTH'
          ,'history_flag:invalid_history_flag:LENGTH'
          ,'title:invalid_alpha:CAPS','title:invalid_alpha:ALLOW'
          ,'fname:invalid_alpha:CAPS','fname:invalid_alpha:ALLOW'
          ,'mname:invalid_alpha:CAPS','mname:invalid_alpha:ALLOW'
          ,'lname:invalid_alpha:CAPS','lname:invalid_alpha:ALLOW'
          ,'name_suffix:invalid_alpha:CAPS','name_suffix:invalid_alpha:ALLOW','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTH_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount
          ,le.record_type_ENUM_ErrorCount,le.record_type_LENGTH_ErrorCount
          ,le.cid_number_CAPS_ErrorCount,le.cid_number_ALLOW_ErrorCount
          ,le.csd_ref_number_ALLOW_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTH_ErrorCount
          ,le.city_CAPS_ErrorCount,le.city_ALLOW_ErrorCount
          ,le.state_CAPS_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.zipcode_ALLOW_ErrorCount,le.zipcode_LENGTH_ErrorCount
          ,le.history_flag_LENGTH_ErrorCount
          ,le.title_CAPS_ErrorCount,le.title_ALLOW_ErrorCount
          ,le.fname_CAPS_ErrorCount,le.fname_ALLOW_ErrorCount
          ,le.mname_CAPS_ErrorCount,le.mname_ALLOW_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_CAPS_ErrorCount,le.name_suffix_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTH_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount
          ,le.record_type_ENUM_ErrorCount,le.record_type_LENGTH_ErrorCount
          ,le.cid_number_CAPS_ErrorCount,le.cid_number_ALLOW_ErrorCount
          ,le.csd_ref_number_ALLOW_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTH_ErrorCount
          ,le.city_CAPS_ErrorCount,le.city_ALLOW_ErrorCount
          ,le.state_CAPS_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.zipcode_ALLOW_ErrorCount,le.zipcode_LENGTH_ErrorCount
          ,le.history_flag_LENGTH_ErrorCount
          ,le.title_CAPS_ErrorCount,le.title_ALLOW_ErrorCount
          ,le.fname_CAPS_ErrorCount,le.fname_ALLOW_ErrorCount
          ,le.mname_CAPS_ErrorCount,le.mname_ALLOW_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_CAPS_ErrorCount,le.name_suffix_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,32,Into(LEFT,COUNTER));
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

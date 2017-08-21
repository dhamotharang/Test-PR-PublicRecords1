IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT base_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(base_Layout_Experian_Phones)
    UNSIGNED1 score_Invalid;
    UNSIGNED1 encrypted_experian_pin_Invalid;
    UNSIGNED1 phone_pos_Invalid;
    UNSIGNED1 phone_digits_Invalid;
    UNSIGNED1 phone_type_Invalid;
    UNSIGNED1 phone_source_Invalid;
    UNSIGNED1 phone_last_updt_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 pin_did_Invalid;
    UNSIGNED1 pin_title_Invalid;
    UNSIGNED1 pin_fname_Invalid;
    UNSIGNED1 pin_mname_Invalid;
    UNSIGNED1 pin_lname_Invalid;
    UNSIGNED1 pin_name_suffix_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
    UNSIGNED1 rec_type_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(base_Layout_Experian_Phones)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(base_Layout_Experian_Phones) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.score_Invalid := base_Fields.InValid_score((SALT33.StrType)le.score);
    SELF.encrypted_experian_pin_Invalid := base_Fields.InValid_encrypted_experian_pin((SALT33.StrType)le.encrypted_experian_pin);
    SELF.phone_pos_Invalid := base_Fields.InValid_phone_pos((SALT33.StrType)le.phone_pos);
    SELF.phone_digits_Invalid := base_Fields.InValid_phone_digits((SALT33.StrType)le.phone_digits);
    SELF.phone_type_Invalid := base_Fields.InValid_phone_type((SALT33.StrType)le.phone_type);
    SELF.phone_source_Invalid := base_Fields.InValid_phone_source((SALT33.StrType)le.phone_source);
    SELF.phone_last_updt_Invalid := base_Fields.InValid_phone_last_updt((SALT33.StrType)le.phone_last_updt);
    SELF.did_Invalid := base_Fields.InValid_did((SALT33.StrType)le.did);
    SELF.did_score_Invalid := base_Fields.InValid_did_score((SALT33.StrType)le.did_score);
    SELF.pin_did_Invalid := base_Fields.InValid_pin_did((SALT33.StrType)le.pin_did);
    SELF.pin_title_Invalid := base_Fields.InValid_pin_title((SALT33.StrType)le.pin_title);
    SELF.pin_fname_Invalid := base_Fields.InValid_pin_fname((SALT33.StrType)le.pin_fname);
    SELF.pin_mname_Invalid := base_Fields.InValid_pin_mname((SALT33.StrType)le.pin_mname);
    SELF.pin_lname_Invalid := base_Fields.InValid_pin_lname((SALT33.StrType)le.pin_lname);
    SELF.pin_name_suffix_Invalid := base_Fields.InValid_pin_name_suffix((SALT33.StrType)le.pin_name_suffix);
    SELF.date_first_seen_Invalid := base_Fields.InValid_date_first_seen((SALT33.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := base_Fields.InValid_date_last_seen((SALT33.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := base_Fields.InValid_date_vendor_first_reported((SALT33.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := base_Fields.InValid_date_vendor_last_reported((SALT33.StrType)le.date_vendor_last_reported);
    SELF.rec_type_Invalid := base_Fields.InValid_rec_type((SALT33.StrType)le.rec_type);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),base_Layout_Experian_Phones);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.score_Invalid << 0 ) + ( le.encrypted_experian_pin_Invalid << 1 ) + ( le.phone_pos_Invalid << 2 ) + ( le.phone_digits_Invalid << 3 ) + ( le.phone_type_Invalid << 4 ) + ( le.phone_source_Invalid << 5 ) + ( le.phone_last_updt_Invalid << 6 ) + ( le.did_Invalid << 7 ) + ( le.did_score_Invalid << 8 ) + ( le.pin_did_Invalid << 9 ) + ( le.pin_title_Invalid << 10 ) + ( le.pin_fname_Invalid << 11 ) + ( le.pin_mname_Invalid << 12 ) + ( le.pin_lname_Invalid << 13 ) + ( le.pin_name_suffix_Invalid << 14 ) + ( le.date_first_seen_Invalid << 15 ) + ( le.date_last_seen_Invalid << 16 ) + ( le.date_vendor_first_reported_Invalid << 17 ) + ( le.date_vendor_last_reported_Invalid << 18 ) + ( le.rec_type_Invalid << 19 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,base_Layout_Experian_Phones);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.score_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.encrypted_experian_pin_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.phone_pos_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.phone_digits_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.phone_type_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.phone_source_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.phone_last_updt_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.did_score_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.pin_did_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.pin_title_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.pin_fname_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.pin_mname_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.pin_lname_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.pin_name_suffix_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.rec_type_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    score_ALLOW_ErrorCount := COUNT(GROUP,h.score_Invalid=1);
    encrypted_experian_pin_ALLOW_ErrorCount := COUNT(GROUP,h.encrypted_experian_pin_Invalid=1);
    phone_pos_ALLOW_ErrorCount := COUNT(GROUP,h.phone_pos_Invalid=1);
    phone_digits_ALLOW_ErrorCount := COUNT(GROUP,h.phone_digits_Invalid=1);
    phone_type_ENUM_ErrorCount := COUNT(GROUP,h.phone_type_Invalid=1);
    phone_source_ENUM_ErrorCount := COUNT(GROUP,h.phone_source_Invalid=1);
    phone_last_updt_ALLOW_ErrorCount := COUNT(GROUP,h.phone_last_updt_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_score_ALLOW_ErrorCount := COUNT(GROUP,h.did_score_Invalid=1);
    pin_did_ALLOW_ErrorCount := COUNT(GROUP,h.pin_did_Invalid=1);
    pin_title_ALLOW_ErrorCount := COUNT(GROUP,h.pin_title_Invalid=1);
    pin_fname_ALLOW_ErrorCount := COUNT(GROUP,h.pin_fname_Invalid=1);
    pin_mname_ALLOW_ErrorCount := COUNT(GROUP,h.pin_mname_Invalid=1);
    pin_lname_ALLOW_ErrorCount := COUNT(GROUP,h.pin_lname_Invalid=1);
    pin_name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.pin_name_suffix_Invalid=1);
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    rec_type_ENUM_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.score_Invalid,le.encrypted_experian_pin_Invalid,le.phone_pos_Invalid,le.phone_digits_Invalid,le.phone_type_Invalid,le.phone_source_Invalid,le.phone_last_updt_Invalid,le.did_Invalid,le.did_score_Invalid,le.pin_did_Invalid,le.pin_title_Invalid,le.pin_fname_Invalid,le.pin_mname_Invalid,le.pin_lname_Invalid,le.pin_name_suffix_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,le.rec_type_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,base_Fields.InvalidMessage_score(le.score_Invalid),base_Fields.InvalidMessage_encrypted_experian_pin(le.encrypted_experian_pin_Invalid),base_Fields.InvalidMessage_phone_pos(le.phone_pos_Invalid),base_Fields.InvalidMessage_phone_digits(le.phone_digits_Invalid),base_Fields.InvalidMessage_phone_type(le.phone_type_Invalid),base_Fields.InvalidMessage_phone_source(le.phone_source_Invalid),base_Fields.InvalidMessage_phone_last_updt(le.phone_last_updt_Invalid),base_Fields.InvalidMessage_did(le.did_Invalid),base_Fields.InvalidMessage_did_score(le.did_score_Invalid),base_Fields.InvalidMessage_pin_did(le.pin_did_Invalid),base_Fields.InvalidMessage_pin_title(le.pin_title_Invalid),base_Fields.InvalidMessage_pin_fname(le.pin_fname_Invalid),base_Fields.InvalidMessage_pin_mname(le.pin_mname_Invalid),base_Fields.InvalidMessage_pin_lname(le.pin_lname_Invalid),base_Fields.InvalidMessage_pin_name_suffix(le.pin_name_suffix_Invalid),base_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),base_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),base_Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),base_Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),base_Fields.InvalidMessage_rec_type(le.rec_type_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.encrypted_experian_pin_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_pos_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_digits_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phone_source_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phone_last_updt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pin_did_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pin_title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pin_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pin_mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pin_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pin_name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'score','encrypted_experian_pin','phone_pos','phone_digits','phone_type','phone_source','phone_last_updt','did','did_score','pin_did','pin_title','pin_fname','pin_mname','pin_lname','pin_name_suffix','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','rec_type','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_Pin','Invalid_Num','Invalid_Num','Invalid_Type','Invalid_Source','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_RecType','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.score,(SALT33.StrType)le.encrypted_experian_pin,(SALT33.StrType)le.phone_pos,(SALT33.StrType)le.phone_digits,(SALT33.StrType)le.phone_type,(SALT33.StrType)le.phone_source,(SALT33.StrType)le.phone_last_updt,(SALT33.StrType)le.did,(SALT33.StrType)le.did_score,(SALT33.StrType)le.pin_did,(SALT33.StrType)le.pin_title,(SALT33.StrType)le.pin_fname,(SALT33.StrType)le.pin_mname,(SALT33.StrType)le.pin_lname,(SALT33.StrType)le.pin_name_suffix,(SALT33.StrType)le.date_first_seen,(SALT33.StrType)le.date_last_seen,(SALT33.StrType)le.date_vendor_first_reported,(SALT33.StrType)le.date_vendor_last_reported,(SALT33.StrType)le.rec_type,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,20,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'score:Invalid_Num:ALLOW'
          ,'encrypted_experian_pin:Invalid_Pin:ALLOW'
          ,'phone_pos:Invalid_Num:ALLOW'
          ,'phone_digits:Invalid_Num:ALLOW'
          ,'phone_type:Invalid_Type:ENUM'
          ,'phone_source:Invalid_Source:ENUM'
          ,'phone_last_updt:Invalid_Num:ALLOW'
          ,'did:Invalid_Num:ALLOW'
          ,'did_score:Invalid_Num:ALLOW'
          ,'pin_did:Invalid_Num:ALLOW'
          ,'pin_title:Invalid_Char:ALLOW'
          ,'pin_fname:Invalid_Char:ALLOW'
          ,'pin_mname:Invalid_Char:ALLOW'
          ,'pin_lname:Invalid_Char:ALLOW'
          ,'pin_name_suffix:Invalid_Char:ALLOW'
          ,'date_first_seen:Invalid_Date:CUSTOM'
          ,'date_last_seen:Invalid_Date:CUSTOM'
          ,'date_vendor_first_reported:Invalid_Date:CUSTOM'
          ,'date_vendor_last_reported:Invalid_Date:CUSTOM'
          ,'rec_type:Invalid_RecType:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,base_Fields.InvalidMessage_score(1)
          ,base_Fields.InvalidMessage_encrypted_experian_pin(1)
          ,base_Fields.InvalidMessage_phone_pos(1)
          ,base_Fields.InvalidMessage_phone_digits(1)
          ,base_Fields.InvalidMessage_phone_type(1)
          ,base_Fields.InvalidMessage_phone_source(1)
          ,base_Fields.InvalidMessage_phone_last_updt(1)
          ,base_Fields.InvalidMessage_did(1)
          ,base_Fields.InvalidMessage_did_score(1)
          ,base_Fields.InvalidMessage_pin_did(1)
          ,base_Fields.InvalidMessage_pin_title(1)
          ,base_Fields.InvalidMessage_pin_fname(1)
          ,base_Fields.InvalidMessage_pin_mname(1)
          ,base_Fields.InvalidMessage_pin_lname(1)
          ,base_Fields.InvalidMessage_pin_name_suffix(1)
          ,base_Fields.InvalidMessage_date_first_seen(1)
          ,base_Fields.InvalidMessage_date_last_seen(1)
          ,base_Fields.InvalidMessage_date_vendor_first_reported(1)
          ,base_Fields.InvalidMessage_date_vendor_last_reported(1)
          ,base_Fields.InvalidMessage_rec_type(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.score_ALLOW_ErrorCount
          ,le.encrypted_experian_pin_ALLOW_ErrorCount
          ,le.phone_pos_ALLOW_ErrorCount
          ,le.phone_digits_ALLOW_ErrorCount
          ,le.phone_type_ENUM_ErrorCount
          ,le.phone_source_ENUM_ErrorCount
          ,le.phone_last_updt_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.pin_did_ALLOW_ErrorCount
          ,le.pin_title_ALLOW_ErrorCount
          ,le.pin_fname_ALLOW_ErrorCount
          ,le.pin_mname_ALLOW_ErrorCount
          ,le.pin_lname_ALLOW_ErrorCount
          ,le.pin_name_suffix_ALLOW_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.date_vendor_first_reported_CUSTOM_ErrorCount
          ,le.date_vendor_last_reported_CUSTOM_ErrorCount
          ,le.rec_type_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.score_ALLOW_ErrorCount
          ,le.encrypted_experian_pin_ALLOW_ErrorCount
          ,le.phone_pos_ALLOW_ErrorCount
          ,le.phone_digits_ALLOW_ErrorCount
          ,le.phone_type_ENUM_ErrorCount
          ,le.phone_source_ENUM_ErrorCount
          ,le.phone_last_updt_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.pin_did_ALLOW_ErrorCount
          ,le.pin_title_ALLOW_ErrorCount
          ,le.pin_fname_ALLOW_ErrorCount
          ,le.pin_mname_ALLOW_ErrorCount
          ,le.pin_lname_ALLOW_ErrorCount
          ,le.pin_name_suffix_ALLOW_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.date_vendor_first_reported_CUSTOM_ErrorCount
          ,le.date_vendor_last_reported_CUSTOM_ErrorCount
          ,le.rec_type_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,20,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT33.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT33.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;

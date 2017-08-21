IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_Email_Data)
    UNSIGNED1 email_rec_key_Invalid;
    UNSIGNED1 email_src_Invalid;
    UNSIGNED1 orig_login_date_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 best_ssn_Invalid;
    UNSIGNED1 best_dob_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 activecode_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Email_Data)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_Email_Data) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.email_rec_key_Invalid := Fields.InValid_email_rec_key((SALT30.StrType)le.email_rec_key);
    SELF.email_src_Invalid := Fields.InValid_email_src((SALT30.StrType)le.email_src);
    SELF.orig_login_date_Invalid := Fields.InValid_orig_login_date((SALT30.StrType)le.orig_login_date);
    SELF.title_Invalid := Fields.InValid_title((SALT30.StrType)le.title);
    SELF.fname_Invalid := Fields.InValid_fname((SALT30.StrType)le.fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT30.StrType)le.mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT30.StrType)le.lname);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT30.StrType)le.name_suffix);
    SELF.predir_Invalid := Fields.InValid_predir((SALT30.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT30.StrType)le.prim_name);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT30.StrType)le.postdir);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT30.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT30.StrType)le.v_city_name);
    SELF.st_Invalid := Fields.InValid_st((SALT30.StrType)le.st);
    SELF.zip_Invalid := Fields.InValid_zip((SALT30.StrType)le.zip);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT30.StrType)le.zip4);
    SELF.best_ssn_Invalid := Fields.InValid_best_ssn((SALT30.StrType)le.best_ssn);
    SELF.best_dob_Invalid := Fields.InValid_best_dob((SALT30.StrType)le.best_dob);
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT30.StrType)le.process_date);
    SELF.activecode_Invalid := Fields.InValid_activecode((SALT30.StrType)le.activecode);
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT30.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT30.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT30.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT30.StrType)le.date_vendor_last_reported);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.email_rec_key_Invalid << 0 ) + ( le.email_src_Invalid << 2 ) + ( le.orig_login_date_Invalid << 3 ) + ( le.title_Invalid << 5 ) + ( le.fname_Invalid << 7 ) + ( le.mname_Invalid << 9 ) + ( le.lname_Invalid << 11 ) + ( le.name_suffix_Invalid << 13 ) + ( le.predir_Invalid << 15 ) + ( le.prim_name_Invalid << 16 ) + ( le.postdir_Invalid << 18 ) + ( le.p_city_name_Invalid << 19 ) + ( le.v_city_name_Invalid << 21 ) + ( le.st_Invalid << 23 ) + ( le.zip_Invalid << 25 ) + ( le.zip4_Invalid << 27 ) + ( le.best_ssn_Invalid << 29 ) + ( le.best_dob_Invalid << 31 ) + ( le.process_date_Invalid << 33 ) + ( le.activecode_Invalid << 35 ) + ( le.date_first_seen_Invalid << 37 ) + ( le.date_last_seen_Invalid << 39 ) + ( le.date_vendor_first_reported_Invalid << 41 ) + ( le.date_vendor_last_reported_Invalid << 43 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Email_Data);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.email_rec_key_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.email_src_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orig_login_date_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.title_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.st_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.best_ssn_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.best_dob_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.activecode_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.email_src;
    TotalCnt := COUNT(GROUP); // Number of records in total
    email_rec_key_ALLOW_ErrorCount := COUNT(GROUP,h.email_rec_key_Invalid=1);
    email_rec_key_LENGTH_ErrorCount := COUNT(GROUP,h.email_rec_key_Invalid=2);
    email_rec_key_Total_ErrorCount := COUNT(GROUP,h.email_rec_key_Invalid>0);
    email_src_ENUM_ErrorCount := COUNT(GROUP,h.email_src_Invalid=1);
    orig_login_date_ALLOW_ErrorCount := COUNT(GROUP,h.orig_login_date_Invalid=1);
    orig_login_date_LENGTH_ErrorCount := COUNT(GROUP,h.orig_login_date_Invalid=2);
    orig_login_date_Total_ErrorCount := COUNT(GROUP,h.orig_login_date_Invalid>0);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    title_LENGTH_ErrorCount := COUNT(GROUP,h.title_Invalid=2);
    title_Total_ErrorCount := COUNT(GROUP,h.title_Invalid>0);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_LENGTH_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_LENGTH_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_LENGTH_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    predir_ENUM_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=2);
    prim_name_Total_ErrorCount := COUNT(GROUP,h.prim_name_Invalid>0);
    postdir_ENUM_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    p_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=2);
    p_city_name_Total_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid>0);
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
    best_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=1);
    best_ssn_LENGTH_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=2);
    best_ssn_Total_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid>0);
    best_dob_ALLOW_ErrorCount := COUNT(GROUP,h.best_dob_Invalid=1);
    best_dob_LENGTH_ErrorCount := COUNT(GROUP,h.best_dob_Invalid=2);
    best_dob_Total_ErrorCount := COUNT(GROUP,h.best_dob_Invalid>0);
    process_date_ALLOW_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_LENGTH_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    activecode_ENUM_ErrorCount := COUNT(GROUP,h.activecode_Invalid=1);
    activecode_LENGTH_ErrorCount := COUNT(GROUP,h.activecode_Invalid=2);
    activecode_Total_ErrorCount := COUNT(GROUP,h.activecode_Invalid>0);
    date_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=2);
    date_first_seen_Total_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid>0);
    date_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=2);
    date_last_seen_Total_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid>0);
    date_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=2);
    date_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid>0);
    date_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    date_vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=2);
    date_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r,email_src,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.email_src;
    UNSIGNED1 ErrNum := CHOOSE(c,le.email_rec_key_Invalid,le.email_src_Invalid,le.orig_login_date_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.postdir_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.best_ssn_Invalid,le.best_dob_Invalid,le.process_date_Invalid,le.activecode_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_email_rec_key(le.email_rec_key_Invalid),Fields.InvalidMessage_email_src(le.email_src_Invalid),Fields.InvalidMessage_orig_login_date(le.orig_login_date_Invalid),Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_best_ssn(le.best_ssn_Invalid),Fields.InvalidMessage_best_dob(le.best_dob_Invalid),Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_activecode(le.activecode_Invalid),Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.email_rec_key_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.email_src_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_login_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.best_ssn_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.best_dob_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.activecode_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'email_rec_key','email_src','orig_login_date','title','fname','mname','lname','name_suffix','predir','prim_name','postdir','p_city_name','v_city_name','st','zip','zip4','best_ssn','best_dob','process_date','activecode','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_source','invalid_date','invalid_alpha','invalid_name','invalid_name','invalid_name','invalid_alnum','invalid_dir','invalid_address','invalid_dir','invalid_alpha','invalid_alpha','invalid_state','invalid_zip','invalid_numeric','invalid_ssn','invalid_dob','invalid_date','invalid_activecode','invalid_date','invalid_date','invalid_date','invalid_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.email_rec_key,(SALT30.StrType)le.email_src,(SALT30.StrType)le.orig_login_date,(SALT30.StrType)le.title,(SALT30.StrType)le.fname,(SALT30.StrType)le.mname,(SALT30.StrType)le.lname,(SALT30.StrType)le.name_suffix,(SALT30.StrType)le.predir,(SALT30.StrType)le.prim_name,(SALT30.StrType)le.postdir,(SALT30.StrType)le.p_city_name,(SALT30.StrType)le.v_city_name,(SALT30.StrType)le.st,(SALT30.StrType)le.zip,(SALT30.StrType)le.zip4,(SALT30.StrType)le.best_ssn,(SALT30.StrType)le.best_dob,(SALT30.StrType)le.process_date,(SALT30.StrType)le.activecode,(SALT30.StrType)le.date_first_seen,(SALT30.StrType)le.date_last_seen,(SALT30.StrType)le.date_vendor_first_reported,(SALT30.StrType)le.date_vendor_last_reported,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,24,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.email_src;
      SELF.ruledesc := CHOOSE(c
          ,'email_rec_key:invalid_numeric:ALLOW','email_rec_key:invalid_numeric:LENGTH'
          ,'email_src:invalid_source:ENUM'
          ,'orig_login_date:invalid_date:ALLOW','orig_login_date:invalid_date:LENGTH'
          ,'title:invalid_alpha:ALLOW','title:invalid_alpha:LENGTH'
          ,'fname:invalid_name:ALLOW','fname:invalid_name:LENGTH'
          ,'mname:invalid_name:ALLOW','mname:invalid_name:LENGTH'
          ,'lname:invalid_name:ALLOW','lname:invalid_name:LENGTH'
          ,'name_suffix:invalid_alnum:ALLOW','name_suffix:invalid_alnum:LENGTH'
          ,'predir:invalid_dir:ENUM'
          ,'prim_name:invalid_address:ALLOW','prim_name:invalid_address:LENGTH'
          ,'postdir:invalid_dir:ENUM'
          ,'p_city_name:invalid_alpha:ALLOW','p_city_name:invalid_alpha:LENGTH'
          ,'v_city_name:invalid_alpha:ALLOW','v_city_name:invalid_alpha:LENGTH'
          ,'st:invalid_state:ALLOW','st:invalid_state:LENGTH'
          ,'zip:invalid_zip:ALLOW','zip:invalid_zip:LENGTH'
          ,'zip4:invalid_numeric:ALLOW','zip4:invalid_numeric:LENGTH'
          ,'best_ssn:invalid_ssn:ALLOW','best_ssn:invalid_ssn:LENGTH'
          ,'best_dob:invalid_dob:ALLOW','best_dob:invalid_dob:LENGTH'
          ,'process_date:invalid_date:ALLOW','process_date:invalid_date:LENGTH'
          ,'activecode:invalid_activecode:ENUM','activecode:invalid_activecode:LENGTH'
          ,'date_first_seen:invalid_date:ALLOW','date_first_seen:invalid_date:LENGTH'
          ,'date_last_seen:invalid_date:ALLOW','date_last_seen:invalid_date:LENGTH'
          ,'date_vendor_first_reported:invalid_date:ALLOW','date_vendor_first_reported:invalid_date:LENGTH'
          ,'date_vendor_last_reported:invalid_date:ALLOW','date_vendor_last_reported:invalid_date:LENGTH','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.email_rec_key_ALLOW_ErrorCount,le.email_rec_key_LENGTH_ErrorCount
          ,le.email_src_ENUM_ErrorCount
          ,le.orig_login_date_ALLOW_ErrorCount,le.orig_login_date_LENGTH_ErrorCount
          ,le.title_ALLOW_ErrorCount,le.title_LENGTH_ErrorCount
          ,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount
          ,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount
          ,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount
          ,le.predir_ENUM_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount,le.prim_name_LENGTH_ErrorCount
          ,le.postdir_ENUM_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_LENGTH_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTH_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.best_ssn_ALLOW_ErrorCount,le.best_ssn_LENGTH_ErrorCount
          ,le.best_dob_ALLOW_ErrorCount,le.best_dob_LENGTH_ErrorCount
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.activecode_ENUM_ErrorCount,le.activecode_LENGTH_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTH_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTH_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.email_rec_key_ALLOW_ErrorCount,le.email_rec_key_LENGTH_ErrorCount
          ,le.email_src_ENUM_ErrorCount
          ,le.orig_login_date_ALLOW_ErrorCount,le.orig_login_date_LENGTH_ErrorCount
          ,le.title_ALLOW_ErrorCount,le.title_LENGTH_ErrorCount
          ,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount
          ,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount
          ,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount
          ,le.predir_ENUM_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount,le.prim_name_LENGTH_ErrorCount
          ,le.postdir_ENUM_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_LENGTH_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTH_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.best_ssn_ALLOW_ErrorCount,le.best_ssn_LENGTH_ErrorCount
          ,le.best_dob_ALLOW_ErrorCount,le.best_dob_LENGTH_ErrorCount
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.activecode_ENUM_ErrorCount,le.activecode_LENGTH_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTH_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTH_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,45,Into(LEFT,COUNTER));
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

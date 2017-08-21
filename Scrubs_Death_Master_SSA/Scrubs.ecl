IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_Death_Master_SSA)
    UNSIGNED1 filedate_Invalid;
    UNSIGNED1 rec_type_Invalid;
    UNSIGNED1 rec_type_orig_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 vorp_code_Invalid;
    UNSIGNED1 dod8_Invalid;
    UNSIGNED1 dob8_Invalid;
    UNSIGNED1 st_country_code_Invalid;
    UNSIGNED1 zip_lastres_Invalid;
    UNSIGNED1 zip_lastpayment_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 fipscounty_Invalid;
    UNSIGNED1 clean_title_Invalid;
    UNSIGNED1 clean_fname_Invalid;
    UNSIGNED1 clean_mname_Invalid;
    UNSIGNED1 clean_lname_Invalid;
    UNSIGNED1 clean_name_suffix_Invalid;
    UNSIGNED1 clean_name_score_Invalid;
    UNSIGNED1 invalid_dob8_dates_Invalid;
    UNSIGNED1 invalid_dod8_dates_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Death_Master_SSA)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_Death_Master_SSA) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.filedate_Invalid := Fields.InValid_filedate((SALT30.StrType)le.filedate);
    SELF.rec_type_Invalid := Fields.InValid_rec_type((SALT30.StrType)le.rec_type);
    SELF.rec_type_orig_Invalid := Fields.InValid_rec_type_orig((SALT30.StrType)le.rec_type_orig);
    SELF.ssn_Invalid := Fields.InValid_ssn((SALT30.StrType)le.ssn);
    SELF.lname_Invalid := Fields.InValid_lname((SALT30.StrType)le.lname);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT30.StrType)le.name_suffix);
    SELF.fname_Invalid := Fields.InValid_fname((SALT30.StrType)le.fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT30.StrType)le.mname);
    SELF.vorp_code_Invalid := Fields.InValid_vorp_code((SALT30.StrType)le.vorp_code);
    SELF.dod8_Invalid := Fields.InValid_dod8((SALT30.StrType)le.dod8);
    SELF.dob8_Invalid := Fields.InValid_dob8((SALT30.StrType)le.dob8);
    SELF.st_country_code_Invalid := Fields.InValid_st_country_code((SALT30.StrType)le.st_country_code);
    SELF.zip_lastres_Invalid := Fields.InValid_zip_lastres((SALT30.StrType)le.zip_lastres);
    SELF.zip_lastpayment_Invalid := Fields.InValid_zip_lastpayment((SALT30.StrType)le.zip_lastpayment);
    SELF.state_Invalid := Fields.InValid_state((SALT30.StrType)le.state);
    SELF.fipscounty_Invalid := Fields.InValid_fipscounty((SALT30.StrType)le.fipscounty);
    SELF.clean_title_Invalid := Fields.InValid_clean_title((SALT30.StrType)le.clean_title);
    SELF.clean_fname_Invalid := Fields.InValid_clean_fname((SALT30.StrType)le.clean_fname);
    SELF.clean_mname_Invalid := Fields.InValid_clean_mname((SALT30.StrType)le.clean_mname);
    SELF.clean_lname_Invalid := Fields.InValid_clean_lname((SALT30.StrType)le.clean_lname);
    SELF.clean_name_suffix_Invalid := Fields.InValid_clean_name_suffix((SALT30.StrType)le.clean_name_suffix);
    SELF.clean_name_score_Invalid := Fields.InValid_clean_name_score((SALT30.StrType)le.clean_name_score);
    SELF.invalid_dob8_dates_Invalid := WHICH(Fields.InValid_dob8((SALT30.StrType)le.dob8)>0, Fields.InValid_filedate((SALT30.StrType)le.filedate)>0, NOT(le.dob8 < le.filedate));
    SELF.invalid_dod8_dates_Invalid := WHICH(Fields.InValid_dod8((SALT30.StrType)le.dod8)>0, Fields.InValid_filedate((SALT30.StrType)le.filedate)>0, NOT(le.dod8 < le.filedate));
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.filedate_Invalid << 0 ) + ( le.rec_type_Invalid << 2 ) + ( le.rec_type_orig_Invalid << 4 ) + ( le.ssn_Invalid << 6 ) + ( le.lname_Invalid << 8 ) + ( le.name_suffix_Invalid << 10 ) + ( le.fname_Invalid << 12 ) + ( le.mname_Invalid << 14 ) + ( le.vorp_code_Invalid << 16 ) + ( le.dod8_Invalid << 18 ) + ( le.dob8_Invalid << 20 ) + ( le.st_country_code_Invalid << 22 ) + ( le.zip_lastres_Invalid << 24 ) + ( le.zip_lastpayment_Invalid << 26 ) + ( le.state_Invalid << 28 ) + ( le.fipscounty_Invalid << 30 ) + ( le.clean_title_Invalid << 32 ) + ( le.clean_fname_Invalid << 34 ) + ( le.clean_mname_Invalid << 36 ) + ( le.clean_lname_Invalid << 38 ) + ( le.clean_name_suffix_Invalid << 40 ) + ( le.clean_name_score_Invalid << 42 ) + ( le.invalid_dob8_dates_Invalid << 43 ) + ( le.invalid_dod8_dates_Invalid << 44 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Death_Master_SSA);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.filedate_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.rec_type_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.rec_type_orig_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.vorp_code_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.dod8_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.dob8_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.st_country_code_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.zip_lastres_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.zip_lastpayment_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.state_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.fipscounty_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.clean_title_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.clean_fname_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.clean_mname_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.clean_lname_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.clean_name_suffix_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.clean_name_score_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.invalid_dob8_dates_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.invalid_dod8_dates_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.rec_type;
    TotalCnt := COUNT(GROUP); // Number of records in total
    filedate_ALLOW_ErrorCount := COUNT(GROUP,h.filedate_Invalid=1);
    filedate_LENGTH_ErrorCount := COUNT(GROUP,h.filedate_Invalid=2);
    filedate_Total_ErrorCount := COUNT(GROUP,h.filedate_Invalid>0);
    rec_type_ENUM_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    rec_type_LENGTH_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=2);
    rec_type_Total_ErrorCount := COUNT(GROUP,h.rec_type_Invalid>0);
    rec_type_orig_ENUM_ErrorCount := COUNT(GROUP,h.rec_type_orig_Invalid=1);
    rec_type_orig_LENGTH_ErrorCount := COUNT(GROUP,h.rec_type_orig_Invalid=2);
    rec_type_orig_Total_ErrorCount := COUNT(GROUP,h.rec_type_orig_Invalid>0);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    ssn_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_Invalid=2);
    ssn_Total_ErrorCount := COUNT(GROUP,h.ssn_Invalid>0);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_LENGTH_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_LENGTH_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_LENGTH_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    vorp_code_ENUM_ErrorCount := COUNT(GROUP,h.vorp_code_Invalid=1);
    vorp_code_LENGTH_ErrorCount := COUNT(GROUP,h.vorp_code_Invalid=2);
    vorp_code_Total_ErrorCount := COUNT(GROUP,h.vorp_code_Invalid>0);
    dod8_ALLOW_ErrorCount := COUNT(GROUP,h.dod8_Invalid=1);
    dod8_LENGTH_ErrorCount := COUNT(GROUP,h.dod8_Invalid=2);
    dod8_Total_ErrorCount := COUNT(GROUP,h.dod8_Invalid>0);
    dob8_ALLOW_ErrorCount := COUNT(GROUP,h.dob8_Invalid=1);
    dob8_LENGTH_ErrorCount := COUNT(GROUP,h.dob8_Invalid=2);
    dob8_Total_ErrorCount := COUNT(GROUP,h.dob8_Invalid>0);
    st_country_code_ALLOW_ErrorCount := COUNT(GROUP,h.st_country_code_Invalid=1);
    st_country_code_LENGTH_ErrorCount := COUNT(GROUP,h.st_country_code_Invalid=2);
    st_country_code_Total_ErrorCount := COUNT(GROUP,h.st_country_code_Invalid>0);
    zip_lastres_ALLOW_ErrorCount := COUNT(GROUP,h.zip_lastres_Invalid=1);
    zip_lastres_LENGTH_ErrorCount := COUNT(GROUP,h.zip_lastres_Invalid=2);
    zip_lastres_Total_ErrorCount := COUNT(GROUP,h.zip_lastres_Invalid>0);
    zip_lastpayment_ALLOW_ErrorCount := COUNT(GROUP,h.zip_lastpayment_Invalid=1);
    zip_lastpayment_LENGTH_ErrorCount := COUNT(GROUP,h.zip_lastpayment_Invalid=2);
    zip_lastpayment_Total_ErrorCount := COUNT(GROUP,h.zip_lastpayment_Invalid>0);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LENGTH_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    fipscounty_ALLOW_ErrorCount := COUNT(GROUP,h.fipscounty_Invalid=1);
    fipscounty_LENGTH_ErrorCount := COUNT(GROUP,h.fipscounty_Invalid=2);
    fipscounty_Total_ErrorCount := COUNT(GROUP,h.fipscounty_Invalid>0);
    clean_title_ALLOW_ErrorCount := COUNT(GROUP,h.clean_title_Invalid=1);
    clean_title_LENGTH_ErrorCount := COUNT(GROUP,h.clean_title_Invalid=2);
    clean_title_Total_ErrorCount := COUNT(GROUP,h.clean_title_Invalid>0);
    clean_fname_ALLOW_ErrorCount := COUNT(GROUP,h.clean_fname_Invalid=1);
    clean_fname_LENGTH_ErrorCount := COUNT(GROUP,h.clean_fname_Invalid=2);
    clean_fname_Total_ErrorCount := COUNT(GROUP,h.clean_fname_Invalid>0);
    clean_mname_ALLOW_ErrorCount := COUNT(GROUP,h.clean_mname_Invalid=1);
    clean_mname_LENGTH_ErrorCount := COUNT(GROUP,h.clean_mname_Invalid=2);
    clean_mname_Total_ErrorCount := COUNT(GROUP,h.clean_mname_Invalid>0);
    clean_lname_ALLOW_ErrorCount := COUNT(GROUP,h.clean_lname_Invalid=1);
    clean_lname_LENGTH_ErrorCount := COUNT(GROUP,h.clean_lname_Invalid=2);
    clean_lname_Total_ErrorCount := COUNT(GROUP,h.clean_lname_Invalid>0);
    clean_name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.clean_name_suffix_Invalid=1);
    clean_name_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.clean_name_suffix_Invalid=2);
    clean_name_suffix_Total_ErrorCount := COUNT(GROUP,h.clean_name_suffix_Invalid>0);
    clean_name_score_ALLOW_ErrorCount := COUNT(GROUP,h.clean_name_score_Invalid=1);
    invalid_dob8_dates_RECORDTYPE_ErrorCount := COUNT(GROUP,h.invalid_dob8_dates_Invalid=1);
    invalid_dod8_dates_RECORDTYPE_ErrorCount := COUNT(GROUP,h.invalid_dod8_dates_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,rec_type,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.rec_type;
    UNSIGNED1 ErrNum := CHOOSE(c,le.filedate_Invalid,le.rec_type_Invalid,le.rec_type_orig_Invalid,le.ssn_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.fname_Invalid,le.mname_Invalid,le.vorp_code_Invalid,le.dod8_Invalid,le.dob8_Invalid,le.st_country_code_Invalid,le.zip_lastres_Invalid,le.zip_lastpayment_Invalid,le.state_Invalid,le.fipscounty_Invalid,le.clean_title_Invalid,le.clean_fname_Invalid,le.clean_mname_Invalid,le.clean_lname_Invalid,le.clean_name_suffix_Invalid,le.clean_name_score_Invalid,le.invalid_dob8_dates_Invalid,le.invalid_dod8_dates_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_filedate(le.filedate_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_rec_type_orig(le.rec_type_orig_Invalid),Fields.InvalidMessage_ssn(le.ssn_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_vorp_code(le.vorp_code_Invalid),Fields.InvalidMessage_dod8(le.dod8_Invalid),Fields.InvalidMessage_dob8(le.dob8_Invalid),Fields.InvalidMessage_st_country_code(le.st_country_code_Invalid),Fields.InvalidMessage_zip_lastres(le.zip_lastres_Invalid),Fields.InvalidMessage_zip_lastpayment(le.zip_lastpayment_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_fipscounty(le.fipscounty_Invalid),Fields.InvalidMessage_clean_title(le.clean_title_Invalid),Fields.InvalidMessage_clean_fname(le.clean_fname_Invalid),Fields.InvalidMessage_clean_mname(le.clean_mname_Invalid),Fields.InvalidMessage_clean_lname(le.clean_lname_Invalid),Fields.InvalidMessage_clean_name_suffix(le.clean_name_suffix_Invalid),Fields.InvalidMessage_clean_name_score(le.clean_name_score_Invalid),'invalid_dob8_dates RECORDTYPE Invalid','invalid_dod8_dates RECORDTYPE Invalid','UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.filedate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.rec_type_orig_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.vorp_code_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dod8_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dob8_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.st_country_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip_lastres_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip_lastpayment_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fipscounty_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_title_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_fname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_mname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_lname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_name_suffix_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_name_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.invalid_dob8_dates_Invalid,'RECORDTYPE','UNKNOWN')
          ,CHOOSE(le.invalid_dod8_dates_Invalid,'RECORDTYPE','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'filedate','rec_type','rec_type_orig','ssn','lname','name_suffix','fname','mname','vorp_code','dod8','dob8','st_country_code','zip_lastres','zip_lastpayment','state','fipscounty','clean_title','clean_fname','clean_mname','clean_lname','clean_name_suffix','clean_name_score','invalid_dob8_dates','invalid_dod8_dates','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_rec_type','invalid_rec_type','invalid_ssn','invalid_name','invalid_name','invalid_name','invalid_name','invalid_vorp_code','invalid_date','invalid_date','invalid_st_country_code','invalid_zip','invalid_zip','invalid_state','invalid_fipscounty','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name_score','RECORDTYPE','RECORDTYPE','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.filedate,(SALT30.StrType)le.rec_type,(SALT30.StrType)le.rec_type_orig,(SALT30.StrType)le.ssn,(SALT30.StrType)le.lname,(SALT30.StrType)le.name_suffix,(SALT30.StrType)le.fname,(SALT30.StrType)le.mname,(SALT30.StrType)le.vorp_code,(SALT30.StrType)le.dod8,(SALT30.StrType)le.dob8,(SALT30.StrType)le.st_country_code,(SALT30.StrType)le.zip_lastres,(SALT30.StrType)le.zip_lastpayment,(SALT30.StrType)le.state,(SALT30.StrType)le.fipscounty,(SALT30.StrType)le.clean_title,(SALT30.StrType)le.clean_fname,(SALT30.StrType)le.clean_mname,(SALT30.StrType)le.clean_lname,(SALT30.StrType)le.clean_name_suffix,(SALT30.StrType)le.clean_name_score,(SALT30.StrType)'RECORDTYPE',(SALT30.StrType)'RECORDTYPE','***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,24,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.rec_type;
      SELF.ruledesc := CHOOSE(c
          ,'filedate:invalid_date:ALLOW','filedate:invalid_date:LENGTH'
          ,'rec_type:invalid_rec_type:ENUM','rec_type:invalid_rec_type:LENGTH'
          ,'rec_type_orig:invalid_rec_type:ENUM','rec_type_orig:invalid_rec_type:LENGTH'
          ,'ssn:invalid_ssn:ALLOW','ssn:invalid_ssn:LENGTH'
          ,'lname:invalid_name:ALLOW','lname:invalid_name:LENGTH'
          ,'name_suffix:invalid_name:ALLOW','name_suffix:invalid_name:LENGTH'
          ,'fname:invalid_name:ALLOW','fname:invalid_name:LENGTH'
          ,'mname:invalid_name:ALLOW','mname:invalid_name:LENGTH'
          ,'vorp_code:invalid_vorp_code:ENUM','vorp_code:invalid_vorp_code:LENGTH'
          ,'dod8:invalid_date:ALLOW','dod8:invalid_date:LENGTH'
          ,'dob8:invalid_date:ALLOW','dob8:invalid_date:LENGTH'
          ,'st_country_code:invalid_st_country_code:ALLOW','st_country_code:invalid_st_country_code:LENGTH'
          ,'zip_lastres:invalid_zip:ALLOW','zip_lastres:invalid_zip:LENGTH'
          ,'zip_lastpayment:invalid_zip:ALLOW','zip_lastpayment:invalid_zip:LENGTH'
          ,'state:invalid_state:ALLOW','state:invalid_state:LENGTH'
          ,'fipscounty:invalid_fipscounty:ALLOW','fipscounty:invalid_fipscounty:LENGTH'
          ,'clean_title:invalid_name:ALLOW','clean_title:invalid_name:LENGTH'
          ,'clean_fname:invalid_name:ALLOW','clean_fname:invalid_name:LENGTH'
          ,'clean_mname:invalid_name:ALLOW','clean_mname:invalid_name:LENGTH'
          ,'clean_lname:invalid_name:ALLOW','clean_lname:invalid_name:LENGTH'
          ,'clean_name_suffix:invalid_name:ALLOW','clean_name_suffix:invalid_name:LENGTH'
          ,'clean_name_score:invalid_name_score:ALLOW'
          ,'invalid_dob8_dates:RECORDTYPE:RECORDTYPE'
          ,'invalid_dod8_dates:RECORDTYPE:RECORDTYPE','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.filedate_ALLOW_ErrorCount,le.filedate_LENGTH_ErrorCount
          ,le.rec_type_ENUM_ErrorCount,le.rec_type_LENGTH_ErrorCount
          ,le.rec_type_orig_ENUM_ErrorCount,le.rec_type_orig_LENGTH_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTH_ErrorCount
          ,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount
          ,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount
          ,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount
          ,le.vorp_code_ENUM_ErrorCount,le.vorp_code_LENGTH_ErrorCount
          ,le.dod8_ALLOW_ErrorCount,le.dod8_LENGTH_ErrorCount
          ,le.dob8_ALLOW_ErrorCount,le.dob8_LENGTH_ErrorCount
          ,le.st_country_code_ALLOW_ErrorCount,le.st_country_code_LENGTH_ErrorCount
          ,le.zip_lastres_ALLOW_ErrorCount,le.zip_lastres_LENGTH_ErrorCount
          ,le.zip_lastpayment_ALLOW_ErrorCount,le.zip_lastpayment_LENGTH_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.fipscounty_ALLOW_ErrorCount,le.fipscounty_LENGTH_ErrorCount
          ,le.clean_title_ALLOW_ErrorCount,le.clean_title_LENGTH_ErrorCount
          ,le.clean_fname_ALLOW_ErrorCount,le.clean_fname_LENGTH_ErrorCount
          ,le.clean_mname_ALLOW_ErrorCount,le.clean_mname_LENGTH_ErrorCount
          ,le.clean_lname_ALLOW_ErrorCount,le.clean_lname_LENGTH_ErrorCount
          ,le.clean_name_suffix_ALLOW_ErrorCount,le.clean_name_suffix_LENGTH_ErrorCount
          ,le.clean_name_score_ALLOW_ErrorCount
          ,le.invalid_dob8_dates_RECORDTYPE_ErrorCount
          ,le.invalid_dod8_dates_RECORDTYPE_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.filedate_ALLOW_ErrorCount,le.filedate_LENGTH_ErrorCount
          ,le.rec_type_ENUM_ErrorCount,le.rec_type_LENGTH_ErrorCount
          ,le.rec_type_orig_ENUM_ErrorCount,le.rec_type_orig_LENGTH_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTH_ErrorCount
          ,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount
          ,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount
          ,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount
          ,le.vorp_code_ENUM_ErrorCount,le.vorp_code_LENGTH_ErrorCount
          ,le.dod8_ALLOW_ErrorCount,le.dod8_LENGTH_ErrorCount
          ,le.dob8_ALLOW_ErrorCount,le.dob8_LENGTH_ErrorCount
          ,le.st_country_code_ALLOW_ErrorCount,le.st_country_code_LENGTH_ErrorCount
          ,le.zip_lastres_ALLOW_ErrorCount,le.zip_lastres_LENGTH_ErrorCount
          ,le.zip_lastpayment_ALLOW_ErrorCount,le.zip_lastpayment_LENGTH_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.fipscounty_ALLOW_ErrorCount,le.fipscounty_LENGTH_ErrorCount
          ,le.clean_title_ALLOW_ErrorCount,le.clean_title_LENGTH_ErrorCount
          ,le.clean_fname_ALLOW_ErrorCount,le.clean_fname_LENGTH_ErrorCount
          ,le.clean_mname_ALLOW_ErrorCount,le.clean_mname_LENGTH_ErrorCount
          ,le.clean_lname_ALLOW_ErrorCount,le.clean_lname_LENGTH_ErrorCount
          ,le.clean_name_suffix_ALLOW_ErrorCount,le.clean_name_suffix_LENGTH_ErrorCount
          ,le.clean_name_score_ALLOW_ErrorCount
          ,le.invalid_dob8_dates_RECORDTYPE_ErrorCount
          ,le.invalid_dod8_dates_RECORDTYPE_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,43,Into(LEFT,COUNTER));
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

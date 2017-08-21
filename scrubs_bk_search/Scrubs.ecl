IMPORT ut,SALT33;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_bk_search)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 case_number_Invalid;
    UNSIGNED1 orig_case_number_Invalid;
    UNSIGNED1 converted_date_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 statusdate_Invalid;
    UNSIGNED1 datevacated_Invalid;
    UNSIGNED1 datetransferred_Invalid;
    UNSIGNED1 orig_name_Invalid;
    UNSIGNED1 orig_fname_Invalid;
    UNSIGNED1 orig_mname_Invalid;
    UNSIGNED1 orig_lname_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
    UNSIGNED1 date_filed_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_bk_search)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_bk_search) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT33.StrType)le.process_date);
    SELF.case_number_Invalid := Fields.InValid_case_number((SALT33.StrType)le.case_number);
    SELF.orig_case_number_Invalid := Fields.InValid_orig_case_number((SALT33.StrType)le.orig_case_number);
    SELF.converted_date_Invalid := Fields.InValid_converted_date((SALT33.StrType)le.converted_date);
    SELF.ssn_Invalid := Fields.InValid_ssn((SALT33.StrType)le.ssn);
    SELF.statusdate_Invalid := Fields.InValid_statusdate((SALT33.StrType)le.statusdate);
    SELF.datevacated_Invalid := Fields.InValid_datevacated((SALT33.StrType)le.datevacated);
    SELF.datetransferred_Invalid := Fields.InValid_datetransferred((SALT33.StrType)le.datetransferred);
    SELF.orig_name_Invalid := Fields.InValid_orig_name((SALT33.StrType)le.orig_name);
    SELF.orig_fname_Invalid := Fields.InValid_orig_fname((SALT33.StrType)le.orig_fname);
    SELF.orig_mname_Invalid := Fields.InValid_orig_mname((SALT33.StrType)le.orig_mname);
    SELF.orig_lname_Invalid := Fields.InValid_orig_lname((SALT33.StrType)le.orig_lname);
    SELF.fname_Invalid := Fields.InValid_fname((SALT33.StrType)le.fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT33.StrType)le.mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT33.StrType)le.lname);
    SELF.st_Invalid := Fields.InValid_st((SALT33.StrType)le.st);
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT33.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT33.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT33.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT33.StrType)le.date_vendor_last_reported);
    SELF.date_filed_Invalid := Fields.InValid_date_filed((SALT33.StrType)le.date_filed);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_bk_search);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.case_number_Invalid << 2 ) + ( le.orig_case_number_Invalid << 4 ) + ( le.converted_date_Invalid << 6 ) + ( le.ssn_Invalid << 8 ) + ( le.statusdate_Invalid << 10 ) + ( le.datevacated_Invalid << 12 ) + ( le.datetransferred_Invalid << 14 ) + ( le.orig_name_Invalid << 16 ) + ( le.orig_fname_Invalid << 18 ) + ( le.orig_mname_Invalid << 20 ) + ( le.orig_lname_Invalid << 22 ) + ( le.fname_Invalid << 24 ) + ( le.mname_Invalid << 26 ) + ( le.lname_Invalid << 28 ) + ( le.st_Invalid << 30 ) + ( le.date_first_seen_Invalid << 32 ) + ( le.date_last_seen_Invalid << 34 ) + ( le.date_vendor_first_reported_Invalid << 36 ) + ( le.date_vendor_last_reported_Invalid << 38 ) + ( le.date_filed_Invalid << 40 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_bk_search);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.case_number_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.orig_case_number_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.converted_date_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.statusdate_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.datevacated_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.datetransferred_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.orig_name_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.orig_fname_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.orig_mname_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.orig_lname_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.st_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.date_filed_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.sourcecode;
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_ALLOW_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_LENGTH_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    case_number_ALLOW_ErrorCount := COUNT(GROUP,h.case_number_Invalid=1);
    case_number_LENGTH_ErrorCount := COUNT(GROUP,h.case_number_Invalid=2);
    case_number_Total_ErrorCount := COUNT(GROUP,h.case_number_Invalid>0);
    orig_case_number_ALLOW_ErrorCount := COUNT(GROUP,h.orig_case_number_Invalid=1);
    orig_case_number_LENGTH_ErrorCount := COUNT(GROUP,h.orig_case_number_Invalid=2);
    orig_case_number_Total_ErrorCount := COUNT(GROUP,h.orig_case_number_Invalid>0);
    converted_date_ALLOW_ErrorCount := COUNT(GROUP,h.converted_date_Invalid=1);
    converted_date_LENGTH_ErrorCount := COUNT(GROUP,h.converted_date_Invalid=2);
    converted_date_Total_ErrorCount := COUNT(GROUP,h.converted_date_Invalid>0);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    ssn_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_Invalid=2);
    ssn_Total_ErrorCount := COUNT(GROUP,h.ssn_Invalid>0);
    statusdate_ALLOW_ErrorCount := COUNT(GROUP,h.statusdate_Invalid=1);
    statusdate_LENGTH_ErrorCount := COUNT(GROUP,h.statusdate_Invalid=2);
    statusdate_Total_ErrorCount := COUNT(GROUP,h.statusdate_Invalid>0);
    datevacated_ALLOW_ErrorCount := COUNT(GROUP,h.datevacated_Invalid=1);
    datevacated_LENGTH_ErrorCount := COUNT(GROUP,h.datevacated_Invalid=2);
    datevacated_Total_ErrorCount := COUNT(GROUP,h.datevacated_Invalid>0);
    datetransferred_ALLOW_ErrorCount := COUNT(GROUP,h.datetransferred_Invalid=1);
    datetransferred_LENGTH_ErrorCount := COUNT(GROUP,h.datetransferred_Invalid=2);
    datetransferred_Total_ErrorCount := COUNT(GROUP,h.datetransferred_Invalid>0);
    orig_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_name_Invalid=1);
    orig_name_LENGTH_ErrorCount := COUNT(GROUP,h.orig_name_Invalid=2);
    orig_name_Total_ErrorCount := COUNT(GROUP,h.orig_name_Invalid>0);
    orig_fname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=1);
    orig_fname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=2);
    orig_fname_Total_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid>0);
    orig_mname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=1);
    orig_mname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=2);
    orig_mname_Total_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid>0);
    orig_lname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=1);
    orig_lname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=2);
    orig_lname_Total_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid>0);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_LENGTH_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_LENGTH_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_LENGTH_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_LENGTH_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
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
    date_filed_ALLOW_ErrorCount := COUNT(GROUP,h.date_filed_Invalid=1);
    date_filed_LENGTH_ErrorCount := COUNT(GROUP,h.date_filed_Invalid=2);
    date_filed_Total_ErrorCount := COUNT(GROUP,h.date_filed_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r,sourcecode,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.sourcecode;
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.case_number_Invalid,le.orig_case_number_Invalid,le.converted_date_Invalid,le.ssn_Invalid,le.statusdate_Invalid,le.datevacated_Invalid,le.datetransferred_Invalid,le.orig_name_Invalid,le.orig_fname_Invalid,le.orig_mname_Invalid,le.orig_lname_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.st_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,le.date_filed_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_case_number(le.case_number_Invalid),Fields.InvalidMessage_orig_case_number(le.orig_case_number_Invalid),Fields.InvalidMessage_converted_date(le.converted_date_Invalid),Fields.InvalidMessage_ssn(le.ssn_Invalid),Fields.InvalidMessage_statusdate(le.statusdate_Invalid),Fields.InvalidMessage_datevacated(le.datevacated_Invalid),Fields.InvalidMessage_datetransferred(le.datetransferred_Invalid),Fields.InvalidMessage_orig_name(le.orig_name_Invalid),Fields.InvalidMessage_orig_fname(le.orig_fname_Invalid),Fields.InvalidMessage_orig_mname(le.orig_mname_Invalid),Fields.InvalidMessage_orig_lname(le.orig_lname_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),Fields.InvalidMessage_date_filed(le.date_filed_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.case_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_case_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.converted_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.statusdate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.datevacated_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.datetransferred_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_fname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_mname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_lname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_filed_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','case_number','orig_case_number','converted_date','ssn','statusdate','datevacated','datetransferred','orig_name','orig_fname','orig_mname','orig_lname','fname','mname','lname','st','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','date_filed','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_alnum','invalid_alnum','invalid_date','invalid_ssn','invalid_date','invalid_date','invalid_date','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_state','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.process_date,(SALT33.StrType)le.case_number,(SALT33.StrType)le.orig_case_number,(SALT33.StrType)le.converted_date,(SALT33.StrType)le.ssn,(SALT33.StrType)le.statusdate,(SALT33.StrType)le.datevacated,(SALT33.StrType)le.datetransferred,(SALT33.StrType)le.orig_name,(SALT33.StrType)le.orig_fname,(SALT33.StrType)le.orig_mname,(SALT33.StrType)le.orig_lname,(SALT33.StrType)le.fname,(SALT33.StrType)le.mname,(SALT33.StrType)le.lname,(SALT33.StrType)le.st,(SALT33.StrType)le.date_first_seen,(SALT33.StrType)le.date_last_seen,(SALT33.StrType)le.date_vendor_first_reported,(SALT33.StrType)le.date_vendor_last_reported,(SALT33.StrType)le.date_filed,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,21,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.sourcecode;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:invalid_date:ALLOW','process_date:invalid_date:LENGTH'
          ,'case_number:invalid_alnum:ALLOW','case_number:invalid_alnum:LENGTH'
          ,'orig_case_number:invalid_alnum:ALLOW','orig_case_number:invalid_alnum:LENGTH'
          ,'converted_date:invalid_date:ALLOW','converted_date:invalid_date:LENGTH'
          ,'ssn:invalid_ssn:ALLOW','ssn:invalid_ssn:LENGTH'
          ,'statusdate:invalid_date:ALLOW','statusdate:invalid_date:LENGTH'
          ,'datevacated:invalid_date:ALLOW','datevacated:invalid_date:LENGTH'
          ,'datetransferred:invalid_date:ALLOW','datetransferred:invalid_date:LENGTH'
          ,'orig_name:invalid_name:ALLOW','orig_name:invalid_name:LENGTH'
          ,'orig_fname:invalid_name:ALLOW','orig_fname:invalid_name:LENGTH'
          ,'orig_mname:invalid_name:ALLOW','orig_mname:invalid_name:LENGTH'
          ,'orig_lname:invalid_name:ALLOW','orig_lname:invalid_name:LENGTH'
          ,'fname:invalid_name:ALLOW','fname:invalid_name:LENGTH'
          ,'mname:invalid_name:ALLOW','mname:invalid_name:LENGTH'
          ,'lname:invalid_name:ALLOW','lname:invalid_name:LENGTH'
          ,'st:invalid_state:ALLOW','st:invalid_state:LENGTH'
          ,'date_first_seen:invalid_date:ALLOW','date_first_seen:invalid_date:LENGTH'
          ,'date_last_seen:invalid_date:ALLOW','date_last_seen:invalid_date:LENGTH'
          ,'date_vendor_first_reported:invalid_date:ALLOW','date_vendor_first_reported:invalid_date:LENGTH'
          ,'date_vendor_last_reported:invalid_date:ALLOW','date_vendor_last_reported:invalid_date:LENGTH'
          ,'date_filed:invalid_date:ALLOW','date_filed:invalid_date:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_process_date(1),Fields.InvalidMessage_process_date(2)
          ,Fields.InvalidMessage_case_number(1),Fields.InvalidMessage_case_number(2)
          ,Fields.InvalidMessage_orig_case_number(1),Fields.InvalidMessage_orig_case_number(2)
          ,Fields.InvalidMessage_converted_date(1),Fields.InvalidMessage_converted_date(2)
          ,Fields.InvalidMessage_ssn(1),Fields.InvalidMessage_ssn(2)
          ,Fields.InvalidMessage_statusdate(1),Fields.InvalidMessage_statusdate(2)
          ,Fields.InvalidMessage_datevacated(1),Fields.InvalidMessage_datevacated(2)
          ,Fields.InvalidMessage_datetransferred(1),Fields.InvalidMessage_datetransferred(2)
          ,Fields.InvalidMessage_orig_name(1),Fields.InvalidMessage_orig_name(2)
          ,Fields.InvalidMessage_orig_fname(1),Fields.InvalidMessage_orig_fname(2)
          ,Fields.InvalidMessage_orig_mname(1),Fields.InvalidMessage_orig_mname(2)
          ,Fields.InvalidMessage_orig_lname(1),Fields.InvalidMessage_orig_lname(2)
          ,Fields.InvalidMessage_fname(1),Fields.InvalidMessage_fname(2)
          ,Fields.InvalidMessage_mname(1),Fields.InvalidMessage_mname(2)
          ,Fields.InvalidMessage_lname(1),Fields.InvalidMessage_lname(2)
          ,Fields.InvalidMessage_st(1),Fields.InvalidMessage_st(2)
          ,Fields.InvalidMessage_date_first_seen(1),Fields.InvalidMessage_date_first_seen(2)
          ,Fields.InvalidMessage_date_last_seen(1),Fields.InvalidMessage_date_last_seen(2)
          ,Fields.InvalidMessage_date_vendor_first_reported(1),Fields.InvalidMessage_date_vendor_first_reported(2)
          ,Fields.InvalidMessage_date_vendor_last_reported(1),Fields.InvalidMessage_date_vendor_last_reported(2)
          ,Fields.InvalidMessage_date_filed(1),Fields.InvalidMessage_date_filed(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.case_number_ALLOW_ErrorCount,le.case_number_LENGTH_ErrorCount
          ,le.orig_case_number_ALLOW_ErrorCount,le.orig_case_number_LENGTH_ErrorCount
          ,le.converted_date_ALLOW_ErrorCount,le.converted_date_LENGTH_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTH_ErrorCount
          ,le.statusdate_ALLOW_ErrorCount,le.statusdate_LENGTH_ErrorCount
          ,le.datevacated_ALLOW_ErrorCount,le.datevacated_LENGTH_ErrorCount
          ,le.datetransferred_ALLOW_ErrorCount,le.datetransferred_LENGTH_ErrorCount
          ,le.orig_name_ALLOW_ErrorCount,le.orig_name_LENGTH_ErrorCount
          ,le.orig_fname_ALLOW_ErrorCount,le.orig_fname_LENGTH_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount,le.orig_mname_LENGTH_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_LENGTH_ErrorCount
          ,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount
          ,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount
          ,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTH_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTH_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTH_ErrorCount
          ,le.date_filed_ALLOW_ErrorCount,le.date_filed_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.case_number_ALLOW_ErrorCount,le.case_number_LENGTH_ErrorCount
          ,le.orig_case_number_ALLOW_ErrorCount,le.orig_case_number_LENGTH_ErrorCount
          ,le.converted_date_ALLOW_ErrorCount,le.converted_date_LENGTH_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTH_ErrorCount
          ,le.statusdate_ALLOW_ErrorCount,le.statusdate_LENGTH_ErrorCount
          ,le.datevacated_ALLOW_ErrorCount,le.datevacated_LENGTH_ErrorCount
          ,le.datetransferred_ALLOW_ErrorCount,le.datetransferred_LENGTH_ErrorCount
          ,le.orig_name_ALLOW_ErrorCount,le.orig_name_LENGTH_ErrorCount
          ,le.orig_fname_ALLOW_ErrorCount,le.orig_fname_LENGTH_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount,le.orig_mname_LENGTH_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_LENGTH_ErrorCount
          ,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount
          ,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount
          ,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTH_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTH_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTH_ErrorCount
          ,le.date_filed_ALLOW_ErrorCount,le.date_filed_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,42,Into(LEFT,COUNTER));
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

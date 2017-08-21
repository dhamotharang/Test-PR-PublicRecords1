IMPORT ut,SALT32,Corp2_Mapping;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Corp2_Mapping.LayoutsCommon.Main)
    UNSIGNED1 corp_key_Invalid;
    UNSIGNED1 corp_orig_sos_charter_nbr_Invalid;
    UNSIGNED1 corp_legal_name_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 corp_process_date_Invalid;
    UNSIGNED1 corp_ra_dt_first_seen_Invalid;
    UNSIGNED1 corp_ra_dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 corp_trademark_first_use_date_Invalid;
    UNSIGNED1 corp_trademark_first_use_date_in_state_Invalid;
    UNSIGNED1 corp_trademark_expiration_date_Invalid;
    UNSIGNED1 corp_trademark_filing_date_Invalid;
    UNSIGNED1 corp_vendor_Invalid;
    UNSIGNED1 corp_state_origin_Invalid;
    UNSIGNED1 corp_inc_state_Invalid;
    UNSIGNED1 corp_trademark_status_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Corp2_Mapping.LayoutsCommon.Main)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Corp2_Mapping.LayoutsCommon.Main) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.corp_key_Invalid := Fields.InValid_corp_key((SALT32.StrType)le.corp_key);
    SELF.corp_orig_sos_charter_nbr_Invalid := Fields.InValid_corp_orig_sos_charter_nbr((SALT32.StrType)le.corp_orig_sos_charter_nbr);
    SELF.corp_legal_name_Invalid := Fields.InValid_corp_legal_name((SALT32.StrType)le.corp_legal_name);
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT32.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT32.StrType)le.dt_last_seen);
    SELF.corp_process_date_Invalid := Fields.InValid_corp_process_date((SALT32.StrType)le.corp_process_date);
    SELF.corp_ra_dt_first_seen_Invalid := Fields.InValid_corp_ra_dt_first_seen((SALT32.StrType)le.corp_ra_dt_first_seen);
    SELF.corp_ra_dt_last_seen_Invalid := Fields.InValid_corp_ra_dt_last_seen((SALT32.StrType)le.corp_ra_dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT32.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT32.StrType)le.dt_vendor_last_reported);
    SELF.corp_trademark_first_use_date_Invalid := Fields.InValid_corp_trademark_first_use_date((SALT32.StrType)le.corp_trademark_first_use_date);
    SELF.corp_trademark_first_use_date_in_state_Invalid := Fields.InValid_corp_trademark_first_use_date_in_state((SALT32.StrType)le.corp_trademark_first_use_date_in_state);
    SELF.corp_trademark_expiration_date_Invalid := Fields.InValid_corp_trademark_expiration_date((SALT32.StrType)le.corp_trademark_expiration_date);
    SELF.corp_trademark_filing_date_Invalid := Fields.InValid_corp_trademark_filing_date((SALT32.StrType)le.corp_trademark_filing_date);
    SELF.corp_vendor_Invalid := Fields.InValid_corp_vendor((SALT32.StrType)le.corp_vendor);
    SELF.corp_state_origin_Invalid := Fields.InValid_corp_state_origin((SALT32.StrType)le.corp_state_origin);
    SELF.corp_inc_state_Invalid := Fields.InValid_corp_inc_state((SALT32.StrType)le.corp_inc_state);
    SELF.corp_trademark_status_Invalid := Fields.InValid_corp_trademark_status((SALT32.StrType)le.corp_trademark_status);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE)) : independent;
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Corp2_Mapping.LayoutsCommon.Main);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.corp_key_Invalid << 0 ) + ( le.corp_orig_sos_charter_nbr_Invalid << 2 ) + ( le.corp_legal_name_Invalid << 4 ) + ( le.dt_first_seen_Invalid << 5 ) + ( le.dt_last_seen_Invalid << 7 ) + ( le.corp_process_date_Invalid << 9 ) + ( le.corp_ra_dt_first_seen_Invalid << 11 ) + ( le.corp_ra_dt_last_seen_Invalid << 13 ) + ( le.dt_vendor_first_reported_Invalid << 15 ) + ( le.dt_vendor_last_reported_Invalid << 17 ) + ( le.corp_trademark_first_use_date_Invalid << 19 ) + ( le.corp_trademark_first_use_date_in_state_Invalid << 21 ) + ( le.corp_trademark_expiration_date_Invalid << 23 ) + ( le.corp_trademark_filing_date_Invalid << 25 ) + ( le.corp_vendor_Invalid << 27 ) + ( le.corp_state_origin_Invalid << 28 ) + ( le.corp_inc_state_Invalid << 29 ) + ( le.corp_trademark_status_Invalid << 30 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Corp2_Mapping.LayoutsCommon.Main);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.corp_key_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.corp_orig_sos_charter_nbr_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.corp_legal_name_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.corp_process_date_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.corp_ra_dt_first_seen_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.corp_ra_dt_last_seen_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.corp_trademark_first_use_date_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.corp_trademark_first_use_date_in_state_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.corp_trademark_expiration_date_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.corp_trademark_filing_date_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.corp_vendor_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.corp_state_origin_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.corp_inc_state_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.corp_trademark_status_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    corp_key_ALLOW_ErrorCount := COUNT(GROUP,h.corp_key_Invalid=1);
    corp_key_LENGTH_ErrorCount := COUNT(GROUP,h.corp_key_Invalid=2);
    corp_key_Total_ErrorCount := COUNT(GROUP,h.corp_key_Invalid>0);
    corp_orig_sos_charter_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.corp_orig_sos_charter_nbr_Invalid=1);
    corp_orig_sos_charter_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.corp_orig_sos_charter_nbr_Invalid=2);
    corp_orig_sos_charter_nbr_Total_ErrorCount := COUNT(GROUP,h.corp_orig_sos_charter_nbr_Invalid>0);
    corp_legal_name_LENGTH_ErrorCount := COUNT(GROUP,h.corp_legal_name_Invalid=1);
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=2);
    dt_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=3);
    dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid>0);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=2);
    dt_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=3);
    dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid>0);
    corp_process_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=1);
    corp_process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=2);
    corp_process_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=3);
    corp_process_date_Total_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid>0);
    corp_ra_dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid=1);
    corp_ra_dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid=2);
    corp_ra_dt_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid=3);
    corp_ra_dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid>0);
    corp_ra_dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid=1);
    corp_ra_dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid=2);
    corp_ra_dt_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid=3);
    corp_ra_dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid>0);
    dt_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=2);
    dt_vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=3);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=3);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    corp_trademark_first_use_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_Invalid=1);
    corp_trademark_first_use_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_Invalid=2);
    corp_trademark_first_use_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_Invalid=3);
    corp_trademark_first_use_date_Total_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_Invalid>0);
    corp_trademark_first_use_date_in_state_ALLOW_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_in_state_Invalid=1);
    corp_trademark_first_use_date_in_state_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_in_state_Invalid=2);
    corp_trademark_first_use_date_in_state_LENGTH_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_in_state_Invalid=3);
    corp_trademark_first_use_date_in_state_Total_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_in_state_Invalid>0);
    corp_trademark_expiration_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_trademark_expiration_date_Invalid=1);
    corp_trademark_expiration_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_trademark_expiration_date_Invalid=2);
    corp_trademark_expiration_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_trademark_expiration_date_Invalid=3);
    corp_trademark_expiration_date_Total_ErrorCount := COUNT(GROUP,h.corp_trademark_expiration_date_Invalid>0);
    corp_trademark_filing_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_trademark_filing_date_Invalid=1);
    corp_trademark_filing_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_trademark_filing_date_Invalid=2);
    corp_trademark_filing_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_trademark_filing_date_Invalid=3);
    corp_trademark_filing_date_Total_ErrorCount := COUNT(GROUP,h.corp_trademark_filing_date_Invalid>0);
    corp_vendor_ENUM_ErrorCount := COUNT(GROUP,h.corp_vendor_Invalid=1);
    corp_state_origin_ENUM_ErrorCount := COUNT(GROUP,h.corp_state_origin_Invalid=1);
    corp_inc_state_ENUM_ErrorCount := COUNT(GROUP,h.corp_inc_state_Invalid=1);
    corp_trademark_status_ENUM_ErrorCount := COUNT(GROUP,h.corp_trademark_status_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r) : independent;
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT32.StrType ErrorMessage;
    SALT32.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.corp_key_Invalid,le.corp_orig_sos_charter_nbr_Invalid,le.corp_legal_name_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.corp_process_date_Invalid,le.corp_ra_dt_first_seen_Invalid,le.corp_ra_dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.corp_trademark_first_use_date_Invalid,le.corp_trademark_first_use_date_in_state_Invalid,le.corp_trademark_expiration_date_Invalid,le.corp_trademark_filing_date_Invalid,le.corp_vendor_Invalid,le.corp_state_origin_Invalid,le.corp_inc_state_Invalid,le.corp_trademark_status_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_corp_key(le.corp_key_Invalid),Fields.InvalidMessage_corp_orig_sos_charter_nbr(le.corp_orig_sos_charter_nbr_Invalid),Fields.InvalidMessage_corp_legal_name(le.corp_legal_name_Invalid),Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_corp_process_date(le.corp_process_date_Invalid),Fields.InvalidMessage_corp_ra_dt_first_seen(le.corp_ra_dt_first_seen_Invalid),Fields.InvalidMessage_corp_ra_dt_last_seen(le.corp_ra_dt_last_seen_Invalid),Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_corp_trademark_first_use_date(le.corp_trademark_first_use_date_Invalid),Fields.InvalidMessage_corp_trademark_first_use_date_in_state(le.corp_trademark_first_use_date_in_state_Invalid),Fields.InvalidMessage_corp_trademark_expiration_date(le.corp_trademark_expiration_date_Invalid),Fields.InvalidMessage_corp_trademark_filing_date(le.corp_trademark_filing_date_Invalid),Fields.InvalidMessage_corp_vendor(le.corp_vendor_Invalid),Fields.InvalidMessage_corp_state_origin(le.corp_state_origin_Invalid),Fields.InvalidMessage_corp_inc_state(le.corp_inc_state_Invalid),Fields.InvalidMessage_corp_trademark_status(le.corp_trademark_status_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.corp_key_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_orig_sos_charter_nbr_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_legal_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_process_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_ra_dt_first_seen_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_ra_dt_last_seen_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_trademark_first_use_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_trademark_first_use_date_in_state_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_trademark_expiration_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_trademark_filing_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_vendor_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_state_origin_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_inc_state_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_trademark_status_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'corp_key','corp_orig_sos_charter_nbr','corp_legal_name','dt_first_seen','dt_last_seen','corp_process_date','corp_ra_dt_first_seen','corp_ra_dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','corp_trademark_first_use_date','corp_trademark_first_use_date_in_state','corp_trademark_expiration_date','corp_trademark_filing_date','corp_vendor','corp_state_origin','corp_inc_state','corp_trademark_status','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_corp_key','invalid_charter','invalid_mandatory','invalid_date','invalid_date','invalid_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_corp_vendor','invalid_state_origin','invalid_state_origin','invalid_trademark_status','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT32.StrType)le.corp_key,(SALT32.StrType)le.corp_orig_sos_charter_nbr,(SALT32.StrType)le.corp_legal_name,(SALT32.StrType)le.dt_first_seen,(SALT32.StrType)le.dt_last_seen,(SALT32.StrType)le.corp_process_date,(SALT32.StrType)le.corp_ra_dt_first_seen,(SALT32.StrType)le.corp_ra_dt_last_seen,(SALT32.StrType)le.dt_vendor_first_reported,(SALT32.StrType)le.dt_vendor_last_reported,(SALT32.StrType)le.corp_trademark_first_use_date,(SALT32.StrType)le.corp_trademark_first_use_date_in_state,(SALT32.StrType)le.corp_trademark_expiration_date,(SALT32.StrType)le.corp_trademark_filing_date,(SALT32.StrType)le.corp_vendor,(SALT32.StrType)le.corp_state_origin,(SALT32.StrType)le.corp_inc_state,(SALT32.StrType)le.corp_trademark_status,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,18,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT32.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'corp_key:invalid_corp_key:ALLOW','corp_key:invalid_corp_key:LENGTH'
          ,'corp_orig_sos_charter_nbr:invalid_charter:ALLOW','corp_orig_sos_charter_nbr:invalid_charter:LENGTH'
          ,'corp_legal_name:invalid_mandatory:LENGTH'
          ,'dt_first_seen:invalid_date:ALLOW','dt_first_seen:invalid_date:CUSTOM','dt_first_seen:invalid_date:LENGTH'
          ,'dt_last_seen:invalid_date:ALLOW','dt_last_seen:invalid_date:CUSTOM','dt_last_seen:invalid_date:LENGTH'
          ,'corp_process_date:invalid_date:ALLOW','corp_process_date:invalid_date:CUSTOM','corp_process_date:invalid_date:LENGTH'
          ,'corp_ra_dt_first_seen:invalid_optional_date:ALLOW','corp_ra_dt_first_seen:invalid_optional_date:CUSTOM','corp_ra_dt_first_seen:invalid_optional_date:LENGTH'
          ,'corp_ra_dt_last_seen:invalid_optional_date:ALLOW','corp_ra_dt_last_seen:invalid_optional_date:CUSTOM','corp_ra_dt_last_seen:invalid_optional_date:LENGTH'
          ,'dt_vendor_first_reported:invalid_optional_date:ALLOW','dt_vendor_first_reported:invalid_optional_date:CUSTOM','dt_vendor_first_reported:invalid_optional_date:LENGTH'
          ,'dt_vendor_last_reported:invalid_optional_date:ALLOW','dt_vendor_last_reported:invalid_optional_date:CUSTOM','dt_vendor_last_reported:invalid_optional_date:LENGTH'
          ,'corp_trademark_first_use_date:invalid_optional_date:ALLOW','corp_trademark_first_use_date:invalid_optional_date:CUSTOM','corp_trademark_first_use_date:invalid_optional_date:LENGTH'
          ,'corp_trademark_first_use_date_in_state:invalid_optional_date:ALLOW','corp_trademark_first_use_date_in_state:invalid_optional_date:CUSTOM','corp_trademark_first_use_date_in_state:invalid_optional_date:LENGTH'
          ,'corp_trademark_expiration_date:invalid_optional_date:ALLOW','corp_trademark_expiration_date:invalid_optional_date:CUSTOM','corp_trademark_expiration_date:invalid_optional_date:LENGTH'
          ,'corp_trademark_filing_date:invalid_optional_date:ALLOW','corp_trademark_filing_date:invalid_optional_date:CUSTOM','corp_trademark_filing_date:invalid_optional_date:LENGTH'
          ,'corp_vendor:invalid_corp_vendor:ENUM'
          ,'corp_state_origin:invalid_state_origin:ENUM'
          ,'corp_inc_state:invalid_state_origin:ENUM'
          ,'corp_trademark_status:invalid_trademark_status:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_corp_key(1),Fields.InvalidMessage_corp_key(2)
          ,Fields.InvalidMessage_corp_orig_sos_charter_nbr(1),Fields.InvalidMessage_corp_orig_sos_charter_nbr(2)
          ,Fields.InvalidMessage_corp_legal_name(1)
          ,Fields.InvalidMessage_dt_first_seen(1),Fields.InvalidMessage_dt_first_seen(2),Fields.InvalidMessage_dt_first_seen(3)
          ,Fields.InvalidMessage_dt_last_seen(1),Fields.InvalidMessage_dt_last_seen(2),Fields.InvalidMessage_dt_last_seen(3)
          ,Fields.InvalidMessage_corp_process_date(1),Fields.InvalidMessage_corp_process_date(2),Fields.InvalidMessage_corp_process_date(3)
          ,Fields.InvalidMessage_corp_ra_dt_first_seen(1),Fields.InvalidMessage_corp_ra_dt_first_seen(2),Fields.InvalidMessage_corp_ra_dt_first_seen(3)
          ,Fields.InvalidMessage_corp_ra_dt_last_seen(1),Fields.InvalidMessage_corp_ra_dt_last_seen(2),Fields.InvalidMessage_corp_ra_dt_last_seen(3)
          ,Fields.InvalidMessage_dt_vendor_first_reported(1),Fields.InvalidMessage_dt_vendor_first_reported(2),Fields.InvalidMessage_dt_vendor_first_reported(3)
          ,Fields.InvalidMessage_dt_vendor_last_reported(1),Fields.InvalidMessage_dt_vendor_last_reported(2),Fields.InvalidMessage_dt_vendor_last_reported(3)
          ,Fields.InvalidMessage_corp_trademark_first_use_date(1),Fields.InvalidMessage_corp_trademark_first_use_date(2),Fields.InvalidMessage_corp_trademark_first_use_date(3)
          ,Fields.InvalidMessage_corp_trademark_first_use_date_in_state(1),Fields.InvalidMessage_corp_trademark_first_use_date_in_state(2),Fields.InvalidMessage_corp_trademark_first_use_date_in_state(3)
          ,Fields.InvalidMessage_corp_trademark_expiration_date(1),Fields.InvalidMessage_corp_trademark_expiration_date(2),Fields.InvalidMessage_corp_trademark_expiration_date(3)
          ,Fields.InvalidMessage_corp_trademark_filing_date(1),Fields.InvalidMessage_corp_trademark_filing_date(2),Fields.InvalidMessage_corp_trademark_filing_date(3)
          ,Fields.InvalidMessage_corp_vendor(1)
          ,Fields.InvalidMessage_corp_state_origin(1)
          ,Fields.InvalidMessage_corp_inc_state(1)
          ,Fields.InvalidMessage_corp_trademark_status(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTH_ErrorCount
          ,le.corp_orig_sos_charter_nbr_ALLOW_ErrorCount,le.corp_orig_sos_charter_nbr_LENGTH_ErrorCount
          ,le.corp_legal_name_LENGTH_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_CUSTOM_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_CUSTOM_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount,le.corp_process_date_LENGTH_ErrorCount
          ,le.corp_ra_dt_first_seen_ALLOW_ErrorCount,le.corp_ra_dt_first_seen_CUSTOM_ErrorCount,le.corp_ra_dt_first_seen_LENGTH_ErrorCount
          ,le.corp_ra_dt_last_seen_ALLOW_ErrorCount,le.corp_ra_dt_last_seen_CUSTOM_ErrorCount,le.corp_ra_dt_last_seen_LENGTH_ErrorCount
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_CUSTOM_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_CUSTOM_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount
          ,le.corp_trademark_first_use_date_ALLOW_ErrorCount,le.corp_trademark_first_use_date_CUSTOM_ErrorCount,le.corp_trademark_first_use_date_LENGTH_ErrorCount
          ,le.corp_trademark_first_use_date_in_state_ALLOW_ErrorCount,le.corp_trademark_first_use_date_in_state_CUSTOM_ErrorCount,le.corp_trademark_first_use_date_in_state_LENGTH_ErrorCount
          ,le.corp_trademark_expiration_date_ALLOW_ErrorCount,le.corp_trademark_expiration_date_CUSTOM_ErrorCount,le.corp_trademark_expiration_date_LENGTH_ErrorCount
          ,le.corp_trademark_filing_date_ALLOW_ErrorCount,le.corp_trademark_filing_date_CUSTOM_ErrorCount,le.corp_trademark_filing_date_LENGTH_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_inc_state_ENUM_ErrorCount
          ,le.corp_trademark_status_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTH_ErrorCount
          ,le.corp_orig_sos_charter_nbr_ALLOW_ErrorCount,le.corp_orig_sos_charter_nbr_LENGTH_ErrorCount
          ,le.corp_legal_name_LENGTH_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_CUSTOM_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_CUSTOM_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount,le.corp_process_date_LENGTH_ErrorCount
          ,le.corp_ra_dt_first_seen_ALLOW_ErrorCount,le.corp_ra_dt_first_seen_CUSTOM_ErrorCount,le.corp_ra_dt_first_seen_LENGTH_ErrorCount
          ,le.corp_ra_dt_last_seen_ALLOW_ErrorCount,le.corp_ra_dt_last_seen_CUSTOM_ErrorCount,le.corp_ra_dt_last_seen_LENGTH_ErrorCount
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_CUSTOM_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_CUSTOM_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount
          ,le.corp_trademark_first_use_date_ALLOW_ErrorCount,le.corp_trademark_first_use_date_CUSTOM_ErrorCount,le.corp_trademark_first_use_date_LENGTH_ErrorCount
          ,le.corp_trademark_first_use_date_in_state_ALLOW_ErrorCount,le.corp_trademark_first_use_date_in_state_CUSTOM_ErrorCount,le.corp_trademark_first_use_date_in_state_LENGTH_ErrorCount
          ,le.corp_trademark_expiration_date_ALLOW_ErrorCount,le.corp_trademark_expiration_date_CUSTOM_ErrorCount,le.corp_trademark_expiration_date_LENGTH_ErrorCount
          ,le.corp_trademark_filing_date_ALLOW_ErrorCount,le.corp_trademark_filing_date_CUSTOM_ErrorCount,le.corp_trademark_filing_date_LENGTH_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_inc_state_ENUM_ErrorCount
          ,le.corp_trademark_status_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,42,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT32.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT32.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;

IMPORT ut,SALT35;
IMPORT Scrubs,Scrubs_DL_MI; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_In_MI)
    UNSIGNED1 append_process_date_Invalid;
    UNSIGNED1 orig_reccode_Invalid;
    UNSIGNED1 orig_clientidnum_Invalid;
    UNSIGNED1 orig_dlnum_Invalid;
    UNSIGNED1 orig_personalidnum_Invalid;
    UNSIGNED1 orig_name_Invalid;
    UNSIGNED1 orig_street_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 orig_zip_Invalid;
    UNSIGNED1 orig_dob_Invalid;
    UNSIGNED1 orig_sex_Invalid;
    UNSIGNED1 orig_county_Invalid;
    UNSIGNED1 orig_dlnorpidindicator_Invalid;
    UNSIGNED1 orig_mailingstreet_Invalid;
    UNSIGNED1 orig_mailingcity_Invalid;
    UNSIGNED1 orig_mailingstate_Invalid;
    UNSIGNED1 orig_mailingzip_Invalid;
    UNSIGNED1 clean_name_prefix_Invalid;
    UNSIGNED1 clean_name_first_Invalid;
    UNSIGNED1 clean_name_middle_Invalid;
    UNSIGNED1 clean_name_last_Invalid;
    UNSIGNED1 clean_name_suffix_Invalid;
    UNSIGNED1 addr_type_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_In_MI)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_In_MI) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.append_process_date_Invalid := Fields.InValid_append_process_date((SALT35.StrType)le.append_process_date);
    SELF.orig_reccode_Invalid := Fields.InValid_orig_reccode((SALT35.StrType)le.orig_reccode);
    SELF.orig_clientidnum_Invalid := Fields.InValid_orig_clientidnum((SALT35.StrType)le.orig_clientidnum);
    SELF.orig_dlnum_Invalid := Fields.InValid_orig_dlnum((SALT35.StrType)le.orig_dlnum);
    SELF.orig_personalidnum_Invalid := Fields.InValid_orig_personalidnum((SALT35.StrType)le.orig_personalidnum);
    SELF.orig_name_Invalid := Fields.InValid_orig_name((SALT35.StrType)le.orig_name);
    SELF.orig_street_Invalid := Fields.InValid_orig_street((SALT35.StrType)le.orig_street);
    SELF.orig_city_Invalid := Fields.InValid_orig_city((SALT35.StrType)le.orig_city);
    SELF.orig_state_Invalid := Fields.InValid_orig_state((SALT35.StrType)le.orig_state);
    SELF.orig_zip_Invalid := Fields.InValid_orig_zip((SALT35.StrType)le.orig_zip);
    SELF.orig_dob_Invalid := Fields.InValid_orig_dob((SALT35.StrType)le.orig_dob);
    SELF.orig_sex_Invalid := Fields.InValid_orig_sex((SALT35.StrType)le.orig_sex);
    SELF.orig_county_Invalid := Fields.InValid_orig_county((SALT35.StrType)le.orig_county);
    SELF.orig_dlnorpidindicator_Invalid := Fields.InValid_orig_dlnorpidindicator((SALT35.StrType)le.orig_dlnorpidindicator,(SALT35.StrType)le.orig_dlnum,(SALT35.StrType)le.orig_personalidnum);
    SELF.orig_mailingstreet_Invalid := Fields.InValid_orig_mailingstreet((SALT35.StrType)le.orig_mailingstreet);
    SELF.orig_mailingcity_Invalid := Fields.InValid_orig_mailingcity((SALT35.StrType)le.orig_mailingcity);
    SELF.orig_mailingstate_Invalid := Fields.InValid_orig_mailingstate((SALT35.StrType)le.orig_mailingstate);
    SELF.orig_mailingzip_Invalid := Fields.InValid_orig_mailingzip((SALT35.StrType)le.orig_mailingzip);
    SELF.clean_name_prefix_Invalid := Fields.InValid_clean_name_prefix((SALT35.StrType)le.clean_name_prefix);
    SELF.clean_name_first_Invalid := Fields.InValid_clean_name_first((SALT35.StrType)le.clean_name_first);
    SELF.clean_name_middle_Invalid := Fields.InValid_clean_name_middle((SALT35.StrType)le.clean_name_middle);
    SELF.clean_name_last_Invalid := Fields.InValid_clean_name_last((SALT35.StrType)le.clean_name_last,(SALT35.StrType)le.clean_name_first,(SALT35.StrType)le.clean_name_middle);
    SELF.clean_name_suffix_Invalid := Fields.InValid_clean_name_suffix((SALT35.StrType)le.clean_name_suffix);
    SELF.addr_type_Invalid := Fields.InValid_addr_type((SALT35.StrType)le.addr_type);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_MI);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.append_process_date_Invalid << 0 ) + ( le.orig_reccode_Invalid << 2 ) + ( le.orig_clientidnum_Invalid << 3 ) + ( le.orig_dlnum_Invalid << 5 ) + ( le.orig_personalidnum_Invalid << 7 ) + ( le.orig_name_Invalid << 9 ) + ( le.orig_street_Invalid << 10 ) + ( le.orig_city_Invalid << 12 ) + ( le.orig_state_Invalid << 13 ) + ( le.orig_zip_Invalid << 14 ) + ( le.orig_dob_Invalid << 16 ) + ( le.orig_sex_Invalid << 18 ) + ( le.orig_county_Invalid << 19 ) + ( le.orig_dlnorpidindicator_Invalid << 21 ) + ( le.orig_mailingstreet_Invalid << 22 ) + ( le.orig_mailingcity_Invalid << 24 ) + ( le.orig_mailingstate_Invalid << 25 ) + ( le.orig_mailingzip_Invalid << 26 ) + ( le.clean_name_prefix_Invalid << 28 ) + ( le.clean_name_first_Invalid << 29 ) + ( le.clean_name_middle_Invalid << 31 ) + ( le.clean_name_last_Invalid << 33 ) + ( le.clean_name_suffix_Invalid << 34 ) + ( le.addr_type_Invalid << 36 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_MI);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.append_process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.orig_reccode_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orig_clientidnum_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.orig_dlnum_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.orig_personalidnum_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.orig_name_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.orig_street_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.orig_zip_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.orig_dob_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.orig_sex_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.orig_county_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.orig_dlnorpidindicator_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.orig_mailingstreet_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.orig_mailingcity_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.orig_mailingstate_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.orig_mailingzip_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.clean_name_prefix_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.clean_name_first_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.clean_name_middle_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.clean_name_last_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.clean_name_suffix_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.addr_type_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    append_process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.append_process_date_Invalid=1);
    append_process_date_LENGTH_ErrorCount := COUNT(GROUP,h.append_process_date_Invalid=2);
    append_process_date_Total_ErrorCount := COUNT(GROUP,h.append_process_date_Invalid>0);
    orig_reccode_ENUM_ErrorCount := COUNT(GROUP,h.orig_reccode_Invalid=1);
    orig_clientidnum_ALLOW_ErrorCount := COUNT(GROUP,h.orig_clientidnum_Invalid=1);
    orig_clientidnum_LENGTH_ErrorCount := COUNT(GROUP,h.orig_clientidnum_Invalid=2);
    orig_clientidnum_Total_ErrorCount := COUNT(GROUP,h.orig_clientidnum_Invalid>0);
    orig_dlnum_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dlnum_Invalid=1);
    orig_dlnum_LENGTH_ErrorCount := COUNT(GROUP,h.orig_dlnum_Invalid=2);
    orig_dlnum_Total_ErrorCount := COUNT(GROUP,h.orig_dlnum_Invalid>0);
    orig_personalidnum_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_personalidnum_Invalid=1);
    orig_personalidnum_LENGTH_ErrorCount := COUNT(GROUP,h.orig_personalidnum_Invalid=2);
    orig_personalidnum_Total_ErrorCount := COUNT(GROUP,h.orig_personalidnum_Invalid>0);
    orig_name_LENGTH_ErrorCount := COUNT(GROUP,h.orig_name_Invalid=1);
    orig_street_CAPS_ErrorCount := COUNT(GROUP,h.orig_street_Invalid=1);
    orig_street_ALLOW_ErrorCount := COUNT(GROUP,h.orig_street_Invalid=2);
    orig_street_Total_ErrorCount := COUNT(GROUP,h.orig_street_Invalid>0);
    orig_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_state_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_zip_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=1);
    orig_zip_LENGTH_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=2);
    orig_zip_Total_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid>0);
    orig_dob_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=1);
    orig_dob_LENGTH_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=2);
    orig_dob_Total_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid>0);
    orig_sex_ENUM_ErrorCount := COUNT(GROUP,h.orig_sex_Invalid=1);
    orig_county_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_county_Invalid=1);
    orig_county_LENGTH_ErrorCount := COUNT(GROUP,h.orig_county_Invalid=2);
    orig_county_Total_ErrorCount := COUNT(GROUP,h.orig_county_Invalid>0);
    orig_dlnorpidindicator_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dlnorpidindicator_Invalid=1);
    orig_mailingstreet_CAPS_ErrorCount := COUNT(GROUP,h.orig_mailingstreet_Invalid=1);
    orig_mailingstreet_ALLOW_ErrorCount := COUNT(GROUP,h.orig_mailingstreet_Invalid=2);
    orig_mailingstreet_Total_ErrorCount := COUNT(GROUP,h.orig_mailingstreet_Invalid>0);
    orig_mailingcity_ALLOW_ErrorCount := COUNT(GROUP,h.orig_mailingcity_Invalid=1);
    orig_mailingstate_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_mailingstate_Invalid=1);
    orig_mailingzip_ALLOW_ErrorCount := COUNT(GROUP,h.orig_mailingzip_Invalid=1);
    orig_mailingzip_LENGTH_ErrorCount := COUNT(GROUP,h.orig_mailingzip_Invalid=2);
    orig_mailingzip_Total_ErrorCount := COUNT(GROUP,h.orig_mailingzip_Invalid>0);
    clean_name_prefix_ALLOW_ErrorCount := COUNT(GROUP,h.clean_name_prefix_Invalid=1);
    clean_name_first_CAPS_ErrorCount := COUNT(GROUP,h.clean_name_first_Invalid=1);
    clean_name_first_ALLOW_ErrorCount := COUNT(GROUP,h.clean_name_first_Invalid=2);
    clean_name_first_Total_ErrorCount := COUNT(GROUP,h.clean_name_first_Invalid>0);
    clean_name_middle_CAPS_ErrorCount := COUNT(GROUP,h.clean_name_middle_Invalid=1);
    clean_name_middle_ALLOW_ErrorCount := COUNT(GROUP,h.clean_name_middle_Invalid=2);
    clean_name_middle_Total_ErrorCount := COUNT(GROUP,h.clean_name_middle_Invalid>0);
    clean_name_last_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_name_last_Invalid=1);
    clean_name_suffix_CAPS_ErrorCount := COUNT(GROUP,h.clean_name_suffix_Invalid=1);
    clean_name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.clean_name_suffix_Invalid=2);
    clean_name_suffix_Total_ErrorCount := COUNT(GROUP,h.clean_name_suffix_Invalid>0);
    addr_type_ALLOW_ErrorCount := COUNT(GROUP,h.addr_type_Invalid=1);
    addr_type_LENGTH_ErrorCount := COUNT(GROUP,h.addr_type_Invalid=2);
    addr_type_Total_ErrorCount := COUNT(GROUP,h.addr_type_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT35.StrType ErrorMessage;
    SALT35.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.append_process_date_Invalid,le.orig_reccode_Invalid,le.orig_clientidnum_Invalid,le.orig_dlnum_Invalid,le.orig_personalidnum_Invalid,le.orig_name_Invalid,le.orig_street_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.orig_zip_Invalid,le.orig_dob_Invalid,le.orig_sex_Invalid,le.orig_county_Invalid,le.orig_dlnorpidindicator_Invalid,le.orig_mailingstreet_Invalid,le.orig_mailingcity_Invalid,le.orig_mailingstate_Invalid,le.orig_mailingzip_Invalid,le.clean_name_prefix_Invalid,le.clean_name_first_Invalid,le.clean_name_middle_Invalid,le.clean_name_last_Invalid,le.clean_name_suffix_Invalid,le.addr_type_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_append_process_date(le.append_process_date_Invalid),Fields.InvalidMessage_orig_reccode(le.orig_reccode_Invalid),Fields.InvalidMessage_orig_clientidnum(le.orig_clientidnum_Invalid),Fields.InvalidMessage_orig_dlnum(le.orig_dlnum_Invalid),Fields.InvalidMessage_orig_personalidnum(le.orig_personalidnum_Invalid),Fields.InvalidMessage_orig_name(le.orig_name_Invalid),Fields.InvalidMessage_orig_street(le.orig_street_Invalid),Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Fields.InvalidMessage_orig_zip(le.orig_zip_Invalid),Fields.InvalidMessage_orig_dob(le.orig_dob_Invalid),Fields.InvalidMessage_orig_sex(le.orig_sex_Invalid),Fields.InvalidMessage_orig_county(le.orig_county_Invalid),Fields.InvalidMessage_orig_dlnorpidindicator(le.orig_dlnorpidindicator_Invalid),Fields.InvalidMessage_orig_mailingstreet(le.orig_mailingstreet_Invalid),Fields.InvalidMessage_orig_mailingcity(le.orig_mailingcity_Invalid),Fields.InvalidMessage_orig_mailingstate(le.orig_mailingstate_Invalid),Fields.InvalidMessage_orig_mailingzip(le.orig_mailingzip_Invalid),Fields.InvalidMessage_clean_name_prefix(le.clean_name_prefix_Invalid),Fields.InvalidMessage_clean_name_first(le.clean_name_first_Invalid),Fields.InvalidMessage_clean_name_middle(le.clean_name_middle_Invalid),Fields.InvalidMessage_clean_name_last(le.clean_name_last_Invalid),Fields.InvalidMessage_clean_name_suffix(le.clean_name_suffix_Invalid),Fields.InvalidMessage_addr_type(le.addr_type_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.append_process_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_reccode_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_clientidnum_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_dlnum_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_personalidnum_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_street_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_dob_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_sex_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_county_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_dlnorpidindicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_mailingstreet_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_mailingcity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_mailingstate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_mailingzip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_name_prefix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_name_first_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_name_middle_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_name_last_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_name_suffix_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_type_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'append_process_date','orig_reccode','orig_clientidnum','orig_dlnum','orig_personalidnum','orig_name','orig_street','orig_city','orig_state','orig_zip','orig_dob','orig_sex','orig_county','orig_dlnorpidindicator','orig_mailingstreet','orig_mailingcity','orig_mailingstate','orig_mailingzip','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','addr_type','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_8pastdate','invalid_orig_reccode','invalid_orig_clientidnum','invalid_dlnum_pid','invalid_dlnum_pid','invalid_orig_name','invalid_wordbag','invalid_alpha_specials','invalid_state','invalid_zip','invalid_orig_dob','invalid_orig_sex','invalid_orig_county','invalid_orig_dlnorpidindicator','invalid_wordbag','invalid_alpha_specials','invalid_state','invalid_zip','invalid_alpha_specials','invalid_wordbag','invalid_wordbag','invalid_clean_name','invalid_wordbag','invalid_addr_type','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT35.StrType)le.append_process_date,(SALT35.StrType)le.orig_reccode,(SALT35.StrType)le.orig_clientidnum,(SALT35.StrType)le.orig_dlnum,(SALT35.StrType)le.orig_personalidnum,(SALT35.StrType)le.orig_name,(SALT35.StrType)le.orig_street,(SALT35.StrType)le.orig_city,(SALT35.StrType)le.orig_state,(SALT35.StrType)le.orig_zip,(SALT35.StrType)le.orig_dob,(SALT35.StrType)le.orig_sex,(SALT35.StrType)le.orig_county,(SALT35.StrType)le.orig_dlnorpidindicator,(SALT35.StrType)le.orig_mailingstreet,(SALT35.StrType)le.orig_mailingcity,(SALT35.StrType)le.orig_mailingstate,(SALT35.StrType)le.orig_mailingzip,(SALT35.StrType)le.clean_name_prefix,(SALT35.StrType)le.clean_name_first,(SALT35.StrType)le.clean_name_middle,(SALT35.StrType)le.clean_name_last,(SALT35.StrType)le.clean_name_suffix,(SALT35.StrType)le.addr_type,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,24,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT35.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'append_process_date:invalid_8pastdate:CUSTOM','append_process_date:invalid_8pastdate:LENGTH'
          ,'orig_reccode:invalid_orig_reccode:ENUM'
          ,'orig_clientidnum:invalid_orig_clientidnum:ALLOW','orig_clientidnum:invalid_orig_clientidnum:LENGTH'
          ,'orig_dlnum:invalid_dlnum_pid:CUSTOM','orig_dlnum:invalid_dlnum_pid:LENGTH'
          ,'orig_personalidnum:invalid_dlnum_pid:CUSTOM','orig_personalidnum:invalid_dlnum_pid:LENGTH'
          ,'orig_name:invalid_orig_name:LENGTH'
          ,'orig_street:invalid_wordbag:CAPS','orig_street:invalid_wordbag:ALLOW'
          ,'orig_city:invalid_alpha_specials:ALLOW'
          ,'orig_state:invalid_state:CUSTOM'
          ,'orig_zip:invalid_zip:ALLOW','orig_zip:invalid_zip:LENGTH'
          ,'orig_dob:invalid_orig_dob:CUSTOM','orig_dob:invalid_orig_dob:LENGTH'
          ,'orig_sex:invalid_orig_sex:ENUM'
          ,'orig_county:invalid_orig_county:CUSTOM','orig_county:invalid_orig_county:LENGTH'
          ,'orig_dlnorpidindicator:invalid_orig_dlnorpidindicator:CUSTOM'
          ,'orig_mailingstreet:invalid_wordbag:CAPS','orig_mailingstreet:invalid_wordbag:ALLOW'
          ,'orig_mailingcity:invalid_alpha_specials:ALLOW'
          ,'orig_mailingstate:invalid_state:CUSTOM'
          ,'orig_mailingzip:invalid_zip:ALLOW','orig_mailingzip:invalid_zip:LENGTH'
          ,'clean_name_prefix:invalid_alpha_specials:ALLOW'
          ,'clean_name_first:invalid_wordbag:CAPS','clean_name_first:invalid_wordbag:ALLOW'
          ,'clean_name_middle:invalid_wordbag:CAPS','clean_name_middle:invalid_wordbag:ALLOW'
          ,'clean_name_last:invalid_clean_name:CUSTOM'
          ,'clean_name_suffix:invalid_wordbag:CAPS','clean_name_suffix:invalid_wordbag:ALLOW'
          ,'addr_type:invalid_addr_type:ALLOW','addr_type:invalid_addr_type:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_append_process_date(1),Fields.InvalidMessage_append_process_date(2)
          ,Fields.InvalidMessage_orig_reccode(1)
          ,Fields.InvalidMessage_orig_clientidnum(1),Fields.InvalidMessage_orig_clientidnum(2)
          ,Fields.InvalidMessage_orig_dlnum(1),Fields.InvalidMessage_orig_dlnum(2)
          ,Fields.InvalidMessage_orig_personalidnum(1),Fields.InvalidMessage_orig_personalidnum(2)
          ,Fields.InvalidMessage_orig_name(1)
          ,Fields.InvalidMessage_orig_street(1),Fields.InvalidMessage_orig_street(2)
          ,Fields.InvalidMessage_orig_city(1)
          ,Fields.InvalidMessage_orig_state(1)
          ,Fields.InvalidMessage_orig_zip(1),Fields.InvalidMessage_orig_zip(2)
          ,Fields.InvalidMessage_orig_dob(1),Fields.InvalidMessage_orig_dob(2)
          ,Fields.InvalidMessage_orig_sex(1)
          ,Fields.InvalidMessage_orig_county(1),Fields.InvalidMessage_orig_county(2)
          ,Fields.InvalidMessage_orig_dlnorpidindicator(1)
          ,Fields.InvalidMessage_orig_mailingstreet(1),Fields.InvalidMessage_orig_mailingstreet(2)
          ,Fields.InvalidMessage_orig_mailingcity(1)
          ,Fields.InvalidMessage_orig_mailingstate(1)
          ,Fields.InvalidMessage_orig_mailingzip(1),Fields.InvalidMessage_orig_mailingzip(2)
          ,Fields.InvalidMessage_clean_name_prefix(1)
          ,Fields.InvalidMessage_clean_name_first(1),Fields.InvalidMessage_clean_name_first(2)
          ,Fields.InvalidMessage_clean_name_middle(1),Fields.InvalidMessage_clean_name_middle(2)
          ,Fields.InvalidMessage_clean_name_last(1)
          ,Fields.InvalidMessage_clean_name_suffix(1),Fields.InvalidMessage_clean_name_suffix(2)
          ,Fields.InvalidMessage_addr_type(1),Fields.InvalidMessage_addr_type(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.append_process_date_CUSTOM_ErrorCount,le.append_process_date_LENGTH_ErrorCount
          ,le.orig_reccode_ENUM_ErrorCount
          ,le.orig_clientidnum_ALLOW_ErrorCount,le.orig_clientidnum_LENGTH_ErrorCount
          ,le.orig_dlnum_CUSTOM_ErrorCount,le.orig_dlnum_LENGTH_ErrorCount
          ,le.orig_personalidnum_CUSTOM_ErrorCount,le.orig_personalidnum_LENGTH_ErrorCount
          ,le.orig_name_LENGTH_ErrorCount
          ,le.orig_street_CAPS_ErrorCount,le.orig_street_ALLOW_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_LENGTH_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount,le.orig_dob_LENGTH_ErrorCount
          ,le.orig_sex_ENUM_ErrorCount
          ,le.orig_county_CUSTOM_ErrorCount,le.orig_county_LENGTH_ErrorCount
          ,le.orig_dlnorpidindicator_CUSTOM_ErrorCount
          ,le.orig_mailingstreet_CAPS_ErrorCount,le.orig_mailingstreet_ALLOW_ErrorCount
          ,le.orig_mailingcity_ALLOW_ErrorCount
          ,le.orig_mailingstate_CUSTOM_ErrorCount
          ,le.orig_mailingzip_ALLOW_ErrorCount,le.orig_mailingzip_LENGTH_ErrorCount
          ,le.clean_name_prefix_ALLOW_ErrorCount
          ,le.clean_name_first_CAPS_ErrorCount,le.clean_name_first_ALLOW_ErrorCount
          ,le.clean_name_middle_CAPS_ErrorCount,le.clean_name_middle_ALLOW_ErrorCount
          ,le.clean_name_last_CUSTOM_ErrorCount
          ,le.clean_name_suffix_CAPS_ErrorCount,le.clean_name_suffix_ALLOW_ErrorCount
          ,le.addr_type_ALLOW_ErrorCount,le.addr_type_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.append_process_date_CUSTOM_ErrorCount,le.append_process_date_LENGTH_ErrorCount
          ,le.orig_reccode_ENUM_ErrorCount
          ,le.orig_clientidnum_ALLOW_ErrorCount,le.orig_clientidnum_LENGTH_ErrorCount
          ,le.orig_dlnum_CUSTOM_ErrorCount,le.orig_dlnum_LENGTH_ErrorCount
          ,le.orig_personalidnum_CUSTOM_ErrorCount,le.orig_personalidnum_LENGTH_ErrorCount
          ,le.orig_name_LENGTH_ErrorCount
          ,le.orig_street_CAPS_ErrorCount,le.orig_street_ALLOW_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_LENGTH_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount,le.orig_dob_LENGTH_ErrorCount
          ,le.orig_sex_ENUM_ErrorCount
          ,le.orig_county_CUSTOM_ErrorCount,le.orig_county_LENGTH_ErrorCount
          ,le.orig_dlnorpidindicator_CUSTOM_ErrorCount
          ,le.orig_mailingstreet_CAPS_ErrorCount,le.orig_mailingstreet_ALLOW_ErrorCount
          ,le.orig_mailingcity_ALLOW_ErrorCount
          ,le.orig_mailingstate_CUSTOM_ErrorCount
          ,le.orig_mailingzip_ALLOW_ErrorCount,le.orig_mailingzip_LENGTH_ErrorCount
          ,le.clean_name_prefix_ALLOW_ErrorCount
          ,le.clean_name_first_CAPS_ErrorCount,le.clean_name_first_ALLOW_ErrorCount
          ,le.clean_name_middle_CAPS_ErrorCount,le.clean_name_middle_ALLOW_ErrorCount
          ,le.clean_name_last_CUSTOM_ErrorCount
          ,le.clean_name_suffix_CAPS_ErrorCount,le.clean_name_suffix_ALLOW_ErrorCount
          ,le.addr_type_ALLOW_ErrorCount,le.addr_type_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,38,Into(LEFT,COUNTER));
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

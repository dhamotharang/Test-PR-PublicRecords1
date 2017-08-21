IMPORT ut,SALT30;
IMPORT Scrubs_LiensV2_Main; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_Liens_Main)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 record_code_Invalid;
    UNSIGNED1 date_vendor_removed_Invalid;
    UNSIGNED1 orig_filing_type_Invalid;
    UNSIGNED1 orig_filing_date_Invalid;
    UNSIGNED1 orig_filing_time_Invalid;
    UNSIGNED1 filing_type_desc_Invalid;
    UNSIGNED1 filing_date_Invalid;
    UNSIGNED1 filing_time_Invalid;
    UNSIGNED1 vendor_entry_date_Invalid;
    UNSIGNED1 release_date_Invalid;
    UNSIGNED1 eviction_Invalid;
    UNSIGNED1 judg_satisfied_date_Invalid;
    UNSIGNED1 judg_vacated_date_Invalid;
    UNSIGNED1 effective_date_Invalid;
    UNSIGNED1 lapse_date_Invalid;
    UNSIGNED1 accident_date_Invalid;
    UNSIGNED1 expiration_date_Invalid;
    UNSIGNED1 agency_city_Invalid;
    UNSIGNED1 agency_state_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Liens_Main)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_Liens_Main) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT30.StrType)le.process_date);
    SELF.record_code_Invalid := Fields.InValid_record_code((SALT30.StrType)le.record_code);
    SELF.date_vendor_removed_Invalid := Fields.InValid_date_vendor_removed((SALT30.StrType)le.date_vendor_removed);
    SELF.orig_filing_type_Invalid := Fields.InValid_orig_filing_type((SALT30.StrType)le.orig_filing_type);
    SELF.orig_filing_date_Invalid := Fields.InValid_orig_filing_date((SALT30.StrType)le.orig_filing_date);
    SELF.orig_filing_time_Invalid := Fields.InValid_orig_filing_time((SALT30.StrType)le.orig_filing_time);
    SELF.filing_type_desc_Invalid := Fields.InValid_filing_type_desc((SALT30.StrType)le.filing_type_desc);
    SELF.filing_date_Invalid := Fields.InValid_filing_date((SALT30.StrType)le.filing_date);
    SELF.filing_time_Invalid := Fields.InValid_filing_time((SALT30.StrType)le.filing_time);
    SELF.vendor_entry_date_Invalid := Fields.InValid_vendor_entry_date((SALT30.StrType)le.vendor_entry_date);
    SELF.release_date_Invalid := Fields.InValid_release_date((SALT30.StrType)le.release_date);
    SELF.eviction_Invalid := Fields.InValid_eviction((SALT30.StrType)le.eviction);
    SELF.judg_satisfied_date_Invalid := Fields.InValid_judg_satisfied_date((SALT30.StrType)le.judg_satisfied_date);
    SELF.judg_vacated_date_Invalid := Fields.InValid_judg_vacated_date((SALT30.StrType)le.judg_vacated_date);
    SELF.effective_date_Invalid := Fields.InValid_effective_date((SALT30.StrType)le.effective_date);
    SELF.lapse_date_Invalid := Fields.InValid_lapse_date((SALT30.StrType)le.lapse_date);
    SELF.accident_date_Invalid := Fields.InValid_accident_date((SALT30.StrType)le.accident_date);
    SELF.expiration_date_Invalid := Fields.InValid_expiration_date((SALT30.StrType)le.expiration_date);
    SELF.agency_city_Invalid := Fields.InValid_agency_city((SALT30.StrType)le.agency_city);
    SELF.agency_state_Invalid := Fields.InValid_agency_state((SALT30.StrType)le.agency_state);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.record_code_Invalid << 2 ) + ( le.date_vendor_removed_Invalid << 3 ) + ( le.orig_filing_type_Invalid << 5 ) + ( le.orig_filing_date_Invalid << 6 ) + ( le.orig_filing_time_Invalid << 8 ) + ( le.filing_type_desc_Invalid << 9 ) + ( le.filing_date_Invalid << 10 ) + ( le.filing_time_Invalid << 12 ) + ( le.vendor_entry_date_Invalid << 13 ) + ( le.release_date_Invalid << 15 ) + ( le.eviction_Invalid << 17 ) + ( le.judg_satisfied_date_Invalid << 18 ) + ( le.judg_vacated_date_Invalid << 20 ) + ( le.effective_date_Invalid << 22 ) + ( le.lapse_date_Invalid << 24 ) + ( le.accident_date_Invalid << 26 ) + ( le.expiration_date_Invalid << 28 ) + ( le.agency_city_Invalid << 30 ) + ( le.agency_state_Invalid << 32 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Liens_Main);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.record_code_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.date_vendor_removed_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.orig_filing_type_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.orig_filing_date_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.orig_filing_time_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.filing_type_desc_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.filing_date_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.filing_time_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.vendor_entry_date_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.release_date_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.eviction_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.judg_satisfied_date_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.judg_vacated_date_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.effective_date_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.lapse_date_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.accident_date_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.expiration_date_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.agency_city_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.agency_state_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.source_file;
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_QUOTES_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_ALLOW_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_LENGTH_ErrorCount := COUNT(GROUP,h.process_date_Invalid=3);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    record_code_ENUM_ErrorCount := COUNT(GROUP,h.record_code_Invalid=1);
    date_vendor_removed_QUOTES_ErrorCount := COUNT(GROUP,h.date_vendor_removed_Invalid=1);
    date_vendor_removed_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_removed_Invalid=2);
    date_vendor_removed_LENGTH_ErrorCount := COUNT(GROUP,h.date_vendor_removed_Invalid=3);
    date_vendor_removed_Total_ErrorCount := COUNT(GROUP,h.date_vendor_removed_Invalid>0);
    orig_filing_type_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_filing_type_Invalid=1);
    orig_filing_date_QUOTES_ErrorCount := COUNT(GROUP,h.orig_filing_date_Invalid=1);
    orig_filing_date_ALLOW_ErrorCount := COUNT(GROUP,h.orig_filing_date_Invalid=2);
    orig_filing_date_LENGTH_ErrorCount := COUNT(GROUP,h.orig_filing_date_Invalid=3);
    orig_filing_date_Total_ErrorCount := COUNT(GROUP,h.orig_filing_date_Invalid>0);
    orig_filing_time_ALLOW_ErrorCount := COUNT(GROUP,h.orig_filing_time_Invalid=1);
    filing_type_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_type_desc_Invalid=1);
    filing_date_QUOTES_ErrorCount := COUNT(GROUP,h.filing_date_Invalid=1);
    filing_date_ALLOW_ErrorCount := COUNT(GROUP,h.filing_date_Invalid=2);
    filing_date_LENGTH_ErrorCount := COUNT(GROUP,h.filing_date_Invalid=3);
    filing_date_Total_ErrorCount := COUNT(GROUP,h.filing_date_Invalid>0);
    filing_time_ALLOW_ErrorCount := COUNT(GROUP,h.filing_time_Invalid=1);
    vendor_entry_date_QUOTES_ErrorCount := COUNT(GROUP,h.vendor_entry_date_Invalid=1);
    vendor_entry_date_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_entry_date_Invalid=2);
    vendor_entry_date_LENGTH_ErrorCount := COUNT(GROUP,h.vendor_entry_date_Invalid=3);
    vendor_entry_date_Total_ErrorCount := COUNT(GROUP,h.vendor_entry_date_Invalid>0);
    release_date_QUOTES_ErrorCount := COUNT(GROUP,h.release_date_Invalid=1);
    release_date_ALLOW_ErrorCount := COUNT(GROUP,h.release_date_Invalid=2);
    release_date_LENGTH_ErrorCount := COUNT(GROUP,h.release_date_Invalid=3);
    release_date_Total_ErrorCount := COUNT(GROUP,h.release_date_Invalid>0);
    eviction_ENUM_ErrorCount := COUNT(GROUP,h.eviction_Invalid=1);
    judg_satisfied_date_QUOTES_ErrorCount := COUNT(GROUP,h.judg_satisfied_date_Invalid=1);
    judg_satisfied_date_ALLOW_ErrorCount := COUNT(GROUP,h.judg_satisfied_date_Invalid=2);
    judg_satisfied_date_LENGTH_ErrorCount := COUNT(GROUP,h.judg_satisfied_date_Invalid=3);
    judg_satisfied_date_Total_ErrorCount := COUNT(GROUP,h.judg_satisfied_date_Invalid>0);
    judg_vacated_date_QUOTES_ErrorCount := COUNT(GROUP,h.judg_vacated_date_Invalid=1);
    judg_vacated_date_ALLOW_ErrorCount := COUNT(GROUP,h.judg_vacated_date_Invalid=2);
    judg_vacated_date_LENGTH_ErrorCount := COUNT(GROUP,h.judg_vacated_date_Invalid=3);
    judg_vacated_date_Total_ErrorCount := COUNT(GROUP,h.judg_vacated_date_Invalid>0);
    effective_date_QUOTES_ErrorCount := COUNT(GROUP,h.effective_date_Invalid=1);
    effective_date_ALLOW_ErrorCount := COUNT(GROUP,h.effective_date_Invalid=2);
    effective_date_LENGTH_ErrorCount := COUNT(GROUP,h.effective_date_Invalid=3);
    effective_date_Total_ErrorCount := COUNT(GROUP,h.effective_date_Invalid>0);
    lapse_date_QUOTES_ErrorCount := COUNT(GROUP,h.lapse_date_Invalid=1);
    lapse_date_ALLOW_ErrorCount := COUNT(GROUP,h.lapse_date_Invalid=2);
    lapse_date_LENGTH_ErrorCount := COUNT(GROUP,h.lapse_date_Invalid=3);
    lapse_date_Total_ErrorCount := COUNT(GROUP,h.lapse_date_Invalid>0);
    accident_date_QUOTES_ErrorCount := COUNT(GROUP,h.accident_date_Invalid=1);
    accident_date_ALLOW_ErrorCount := COUNT(GROUP,h.accident_date_Invalid=2);
    accident_date_LENGTH_ErrorCount := COUNT(GROUP,h.accident_date_Invalid=3);
    accident_date_Total_ErrorCount := COUNT(GROUP,h.accident_date_Invalid>0);
    expiration_date_QUOTES_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid=1);
    expiration_date_ALLOW_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid=2);
    expiration_date_LENGTH_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid=3);
    expiration_date_Total_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid>0);
    agency_city_ALLOW_ErrorCount := COUNT(GROUP,h.agency_city_Invalid=1);
    agency_city_LENGTH_ErrorCount := COUNT(GROUP,h.agency_city_Invalid=2);
    agency_city_Total_ErrorCount := COUNT(GROUP,h.agency_city_Invalid>0);
    agency_state_ALLOW_ErrorCount := COUNT(GROUP,h.agency_state_Invalid=1);
    agency_state_LENGTH_ErrorCount := COUNT(GROUP,h.agency_state_Invalid=2);
    agency_state_Total_ErrorCount := COUNT(GROUP,h.agency_state_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.record_code_Invalid,le.date_vendor_removed_Invalid,le.orig_filing_type_Invalid,le.orig_filing_date_Invalid,le.orig_filing_time_Invalid,le.filing_type_desc_Invalid,le.filing_date_Invalid,le.filing_time_Invalid,le.vendor_entry_date_Invalid,le.release_date_Invalid,le.eviction_Invalid,le.judg_satisfied_date_Invalid,le.judg_vacated_date_Invalid,le.effective_date_Invalid,le.lapse_date_Invalid,le.accident_date_Invalid,le.expiration_date_Invalid,le.agency_city_Invalid,le.agency_state_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_record_code(le.record_code_Invalid),Fields.InvalidMessage_date_vendor_removed(le.date_vendor_removed_Invalid),Fields.InvalidMessage_orig_filing_type(le.orig_filing_type_Invalid),Fields.InvalidMessage_orig_filing_date(le.orig_filing_date_Invalid),Fields.InvalidMessage_orig_filing_time(le.orig_filing_time_Invalid),Fields.InvalidMessage_filing_type_desc(le.filing_type_desc_Invalid),Fields.InvalidMessage_filing_date(le.filing_date_Invalid),Fields.InvalidMessage_filing_time(le.filing_time_Invalid),Fields.InvalidMessage_vendor_entry_date(le.vendor_entry_date_Invalid),Fields.InvalidMessage_release_date(le.release_date_Invalid),Fields.InvalidMessage_eviction(le.eviction_Invalid),Fields.InvalidMessage_judg_satisfied_date(le.judg_satisfied_date_Invalid),Fields.InvalidMessage_judg_vacated_date(le.judg_vacated_date_Invalid),Fields.InvalidMessage_effective_date(le.effective_date_Invalid),Fields.InvalidMessage_lapse_date(le.lapse_date_Invalid),Fields.InvalidMessage_accident_date(le.accident_date_Invalid),Fields.InvalidMessage_expiration_date(le.expiration_date_Invalid),Fields.InvalidMessage_agency_city(le.agency_city_Invalid),Fields.InvalidMessage_agency_state(le.agency_state_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'QUOTES','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.record_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.date_vendor_removed_Invalid,'QUOTES','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_filing_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_filing_date_Invalid,'QUOTES','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_filing_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.filing_type_desc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filing_date_Invalid,'QUOTES','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.filing_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendor_entry_date_Invalid,'QUOTES','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.release_date_Invalid,'QUOTES','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.eviction_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.judg_satisfied_date_Invalid,'QUOTES','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.judg_vacated_date_Invalid,'QUOTES','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.effective_date_Invalid,'QUOTES','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lapse_date_Invalid,'QUOTES','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.accident_date_Invalid,'QUOTES','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.expiration_date_Invalid,'QUOTES','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.agency_city_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.agency_state_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','record_code','date_vendor_removed','orig_filing_type','orig_filing_date','orig_filing_time','filing_type_desc','filing_date','filing_time','vendor_entry_date','release_date','eviction','judg_satisfied_date','judg_vacated_date','effective_date','lapse_date','accident_date','expiration_date','agency_city','agency_state','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_record_code','invalid_date','invalid_filing_type','invalid_date','invalid_number','invalid_filing_desc','invalid_date','invalid_number','invalid_date','invalid_date','invalid_eviction_ind','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_alpha','invalid_alpha','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.process_date,(SALT30.StrType)le.record_code,(SALT30.StrType)le.date_vendor_removed,(SALT30.StrType)le.orig_filing_type,(SALT30.StrType)le.orig_filing_date,(SALT30.StrType)le.orig_filing_time,(SALT30.StrType)le.filing_type_desc,(SALT30.StrType)le.filing_date,(SALT30.StrType)le.filing_time,(SALT30.StrType)le.vendor_entry_date,(SALT30.StrType)le.release_date,(SALT30.StrType)le.eviction,(SALT30.StrType)le.judg_satisfied_date,(SALT30.StrType)le.judg_vacated_date,(SALT30.StrType)le.effective_date,(SALT30.StrType)le.lapse_date,(SALT30.StrType)le.accident_date,(SALT30.StrType)le.expiration_date,(SALT30.StrType)le.agency_city,(SALT30.StrType)le.agency_state,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,20,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source_file;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:invalid_date:QUOTES','process_date:invalid_date:ALLOW','process_date:invalid_date:LENGTH'
          ,'record_code:invalid_record_code:ENUM'
          ,'date_vendor_removed:invalid_date:QUOTES','date_vendor_removed:invalid_date:ALLOW','date_vendor_removed:invalid_date:LENGTH'
          ,'orig_filing_type:invalid_filing_type:CUSTOM'
          ,'orig_filing_date:invalid_date:QUOTES','orig_filing_date:invalid_date:ALLOW','orig_filing_date:invalid_date:LENGTH'
          ,'orig_filing_time:invalid_number:ALLOW'
          ,'filing_type_desc:invalid_filing_desc:CUSTOM'
          ,'filing_date:invalid_date:QUOTES','filing_date:invalid_date:ALLOW','filing_date:invalid_date:LENGTH'
          ,'filing_time:invalid_number:ALLOW'
          ,'vendor_entry_date:invalid_date:QUOTES','vendor_entry_date:invalid_date:ALLOW','vendor_entry_date:invalid_date:LENGTH'
          ,'release_date:invalid_date:QUOTES','release_date:invalid_date:ALLOW','release_date:invalid_date:LENGTH'
          ,'eviction:invalid_eviction_ind:ENUM'
          ,'judg_satisfied_date:invalid_date:QUOTES','judg_satisfied_date:invalid_date:ALLOW','judg_satisfied_date:invalid_date:LENGTH'
          ,'judg_vacated_date:invalid_date:QUOTES','judg_vacated_date:invalid_date:ALLOW','judg_vacated_date:invalid_date:LENGTH'
          ,'effective_date:invalid_date:QUOTES','effective_date:invalid_date:ALLOW','effective_date:invalid_date:LENGTH'
          ,'lapse_date:invalid_date:QUOTES','lapse_date:invalid_date:ALLOW','lapse_date:invalid_date:LENGTH'
          ,'accident_date:invalid_date:QUOTES','accident_date:invalid_date:ALLOW','accident_date:invalid_date:LENGTH'
          ,'expiration_date:invalid_date:QUOTES','expiration_date:invalid_date:ALLOW','expiration_date:invalid_date:LENGTH'
          ,'agency_city:invalid_alpha:ALLOW','agency_city:invalid_alpha:LENGTH'
          ,'agency_state:invalid_alpha:ALLOW','agency_state:invalid_alpha:LENGTH','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_QUOTES_ErrorCount,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.record_code_ENUM_ErrorCount
          ,le.date_vendor_removed_QUOTES_ErrorCount,le.date_vendor_removed_ALLOW_ErrorCount,le.date_vendor_removed_LENGTH_ErrorCount
          ,le.orig_filing_type_CUSTOM_ErrorCount
          ,le.orig_filing_date_QUOTES_ErrorCount,le.orig_filing_date_ALLOW_ErrorCount,le.orig_filing_date_LENGTH_ErrorCount
          ,le.orig_filing_time_ALLOW_ErrorCount
          ,le.filing_type_desc_CUSTOM_ErrorCount
          ,le.filing_date_QUOTES_ErrorCount,le.filing_date_ALLOW_ErrorCount,le.filing_date_LENGTH_ErrorCount
          ,le.filing_time_ALLOW_ErrorCount
          ,le.vendor_entry_date_QUOTES_ErrorCount,le.vendor_entry_date_ALLOW_ErrorCount,le.vendor_entry_date_LENGTH_ErrorCount
          ,le.release_date_QUOTES_ErrorCount,le.release_date_ALLOW_ErrorCount,le.release_date_LENGTH_ErrorCount
          ,le.eviction_ENUM_ErrorCount
          ,le.judg_satisfied_date_QUOTES_ErrorCount,le.judg_satisfied_date_ALLOW_ErrorCount,le.judg_satisfied_date_LENGTH_ErrorCount
          ,le.judg_vacated_date_QUOTES_ErrorCount,le.judg_vacated_date_ALLOW_ErrorCount,le.judg_vacated_date_LENGTH_ErrorCount
          ,le.effective_date_QUOTES_ErrorCount,le.effective_date_ALLOW_ErrorCount,le.effective_date_LENGTH_ErrorCount
          ,le.lapse_date_QUOTES_ErrorCount,le.lapse_date_ALLOW_ErrorCount,le.lapse_date_LENGTH_ErrorCount
          ,le.accident_date_QUOTES_ErrorCount,le.accident_date_ALLOW_ErrorCount,le.accident_date_LENGTH_ErrorCount
          ,le.expiration_date_QUOTES_ErrorCount,le.expiration_date_ALLOW_ErrorCount,le.expiration_date_LENGTH_ErrorCount
          ,le.agency_city_ALLOW_ErrorCount,le.agency_city_LENGTH_ErrorCount
          ,le.agency_state_ALLOW_ErrorCount,le.agency_state_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.process_date_QUOTES_ErrorCount,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.record_code_ENUM_ErrorCount
          ,le.date_vendor_removed_QUOTES_ErrorCount,le.date_vendor_removed_ALLOW_ErrorCount,le.date_vendor_removed_LENGTH_ErrorCount
          ,le.orig_filing_type_CUSTOM_ErrorCount
          ,le.orig_filing_date_QUOTES_ErrorCount,le.orig_filing_date_ALLOW_ErrorCount,le.orig_filing_date_LENGTH_ErrorCount
          ,le.orig_filing_time_ALLOW_ErrorCount
          ,le.filing_type_desc_CUSTOM_ErrorCount
          ,le.filing_date_QUOTES_ErrorCount,le.filing_date_ALLOW_ErrorCount,le.filing_date_LENGTH_ErrorCount
          ,le.filing_time_ALLOW_ErrorCount
          ,le.vendor_entry_date_QUOTES_ErrorCount,le.vendor_entry_date_ALLOW_ErrorCount,le.vendor_entry_date_LENGTH_ErrorCount
          ,le.release_date_QUOTES_ErrorCount,le.release_date_ALLOW_ErrorCount,le.release_date_LENGTH_ErrorCount
          ,le.eviction_ENUM_ErrorCount
          ,le.judg_satisfied_date_QUOTES_ErrorCount,le.judg_satisfied_date_ALLOW_ErrorCount,le.judg_satisfied_date_LENGTH_ErrorCount
          ,le.judg_vacated_date_QUOTES_ErrorCount,le.judg_vacated_date_ALLOW_ErrorCount,le.judg_vacated_date_LENGTH_ErrorCount
          ,le.effective_date_QUOTES_ErrorCount,le.effective_date_ALLOW_ErrorCount,le.effective_date_LENGTH_ErrorCount
          ,le.lapse_date_QUOTES_ErrorCount,le.lapse_date_ALLOW_ErrorCount,le.lapse_date_LENGTH_ErrorCount
          ,le.accident_date_QUOTES_ErrorCount,le.accident_date_ALLOW_ErrorCount,le.accident_date_LENGTH_ErrorCount
          ,le.expiration_date_QUOTES_ErrorCount,le.expiration_date_ALLOW_ErrorCount,le.expiration_date_LENGTH_ErrorCount
          ,le.agency_city_ALLOW_ErrorCount,le.agency_city_LENGTH_ErrorCount
          ,le.agency_state_ALLOW_ErrorCount,le.agency_state_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,46,Into(LEFT,COUNTER));
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

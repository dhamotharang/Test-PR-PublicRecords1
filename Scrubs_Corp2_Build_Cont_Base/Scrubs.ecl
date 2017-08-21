IMPORT ut,SALT30;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(layout_in_file)
    UNSIGNED1 corp_key_Invalid;
    UNSIGNED1 corp_vendor_Invalid;
    UNSIGNED1 corp_state_origin_Invalid;
    UNSIGNED1 corp_process_date_Invalid;
    UNSIGNED1 corp_legal_name_Invalid;
    UNSIGNED1 corp_phone_number_Invalid;
    UNSIGNED1 corp_fax_nbr_Invalid;
    UNSIGNED1 cont_filing_date_Invalid;
    UNSIGNED1 cont_dob_Invalid;
    UNSIGNED1 cont_effective_date_Invalid;
    UNSIGNED1 cont_address_effective_date_Invalid;
    UNSIGNED1 cont_phone_number_Invalid;
    UNSIGNED1 cont_fax_nbr_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(layout_in_file)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(layout_in_file) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.corp_key_Invalid := Fields.InValid_corp_key((SALT30.StrType)le.corp_key);
    SELF.corp_vendor_Invalid := Fields.InValid_corp_vendor((SALT30.StrType)le.corp_vendor);
    SELF.corp_state_origin_Invalid := Fields.InValid_corp_state_origin((SALT30.StrType)le.corp_state_origin);
    SELF.corp_process_date_Invalid := Fields.InValid_corp_process_date((SALT30.StrType)le.corp_process_date);
    SELF.corp_legal_name_Invalid := Fields.InValid_corp_legal_name((SALT30.StrType)le.corp_legal_name);
    SELF.corp_phone_number_Invalid := Fields.InValid_corp_phone_number((SALT30.StrType)le.corp_phone_number);
    SELF.corp_fax_nbr_Invalid := Fields.InValid_corp_fax_nbr((SALT30.StrType)le.corp_fax_nbr);
    SELF.cont_filing_date_Invalid := Fields.InValid_cont_filing_date((SALT30.StrType)le.cont_filing_date);
    SELF.cont_dob_Invalid := Fields.InValid_cont_dob((SALT30.StrType)le.cont_dob);
    SELF.cont_effective_date_Invalid := Fields.InValid_cont_effective_date((SALT30.StrType)le.cont_effective_date);
    SELF.cont_address_effective_date_Invalid := Fields.InValid_cont_address_effective_date((SALT30.StrType)le.cont_address_effective_date);
    SELF.cont_phone_number_Invalid := Fields.InValid_cont_phone_number((SALT30.StrType)le.cont_phone_number);
    SELF.cont_fax_nbr_Invalid := Fields.InValid_cont_fax_nbr((SALT30.StrType)le.cont_fax_nbr);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.corp_key_Invalid << 0 ) + ( le.corp_vendor_Invalid << 1 ) + ( le.corp_state_origin_Invalid << 3 ) + ( le.corp_process_date_Invalid << 5 ) + ( le.corp_legal_name_Invalid << 7 ) + ( le.corp_phone_number_Invalid << 8 ) + ( le.corp_fax_nbr_Invalid << 10 ) + ( le.cont_filing_date_Invalid << 12 ) + ( le.cont_dob_Invalid << 14 ) + ( le.cont_effective_date_Invalid << 16 ) + ( le.cont_address_effective_date_Invalid << 18 ) + ( le.cont_phone_number_Invalid << 20 ) + ( le.cont_fax_nbr_Invalid << 22 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,layout_in_file);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.corp_key_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.corp_vendor_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.corp_state_origin_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.corp_process_date_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.corp_legal_name_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.corp_phone_number_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.corp_fax_nbr_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.cont_filing_date_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.cont_dob_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.cont_effective_date_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.cont_address_effective_date_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.cont_phone_number_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.cont_fax_nbr_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    corp_key_LENGTH_ErrorCount := COUNT(GROUP,h.corp_key_Invalid=1);
    corp_vendor_ALLOW_ErrorCount := COUNT(GROUP,h.corp_vendor_Invalid=1);
    corp_vendor_LENGTH_ErrorCount := COUNT(GROUP,h.corp_vendor_Invalid=2);
    corp_vendor_Total_ErrorCount := COUNT(GROUP,h.corp_vendor_Invalid>0);
    corp_state_origin_ALLOW_ErrorCount := COUNT(GROUP,h.corp_state_origin_Invalid=1);
    corp_state_origin_LENGTH_ErrorCount := COUNT(GROUP,h.corp_state_origin_Invalid=2);
    corp_state_origin_Total_ErrorCount := COUNT(GROUP,h.corp_state_origin_Invalid>0);
    corp_process_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=1);
    corp_process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=2);
    corp_process_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=3);
    corp_process_date_Total_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid>0);
    corp_legal_name_LENGTH_ErrorCount := COUNT(GROUP,h.corp_legal_name_Invalid=1);
    corp_phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.corp_phone_number_Invalid=1);
    corp_phone_number_LENGTH_ErrorCount := COUNT(GROUP,h.corp_phone_number_Invalid=2);
    corp_phone_number_Total_ErrorCount := COUNT(GROUP,h.corp_phone_number_Invalid>0);
    corp_fax_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.corp_fax_nbr_Invalid=1);
    corp_fax_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.corp_fax_nbr_Invalid=2);
    corp_fax_nbr_Total_ErrorCount := COUNT(GROUP,h.corp_fax_nbr_Invalid>0);
    cont_filing_date_ALLOW_ErrorCount := COUNT(GROUP,h.cont_filing_date_Invalid=1);
    cont_filing_date_CUSTOM_ErrorCount := COUNT(GROUP,h.cont_filing_date_Invalid=2);
    cont_filing_date_LENGTH_ErrorCount := COUNT(GROUP,h.cont_filing_date_Invalid=3);
    cont_filing_date_Total_ErrorCount := COUNT(GROUP,h.cont_filing_date_Invalid>0);
    cont_dob_ALLOW_ErrorCount := COUNT(GROUP,h.cont_dob_Invalid=1);
    cont_dob_CUSTOM_ErrorCount := COUNT(GROUP,h.cont_dob_Invalid=2);
    cont_dob_LENGTH_ErrorCount := COUNT(GROUP,h.cont_dob_Invalid=3);
    cont_dob_Total_ErrorCount := COUNT(GROUP,h.cont_dob_Invalid>0);
    cont_effective_date_ALLOW_ErrorCount := COUNT(GROUP,h.cont_effective_date_Invalid=1);
    cont_effective_date_CUSTOM_ErrorCount := COUNT(GROUP,h.cont_effective_date_Invalid=2);
    cont_effective_date_LENGTH_ErrorCount := COUNT(GROUP,h.cont_effective_date_Invalid=3);
    cont_effective_date_Total_ErrorCount := COUNT(GROUP,h.cont_effective_date_Invalid>0);
    cont_address_effective_date_ALLOW_ErrorCount := COUNT(GROUP,h.cont_address_effective_date_Invalid=1);
    cont_address_effective_date_CUSTOM_ErrorCount := COUNT(GROUP,h.cont_address_effective_date_Invalid=2);
    cont_address_effective_date_LENGTH_ErrorCount := COUNT(GROUP,h.cont_address_effective_date_Invalid=3);
    cont_address_effective_date_Total_ErrorCount := COUNT(GROUP,h.cont_address_effective_date_Invalid>0);
    cont_phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.cont_phone_number_Invalid=1);
    cont_phone_number_LENGTH_ErrorCount := COUNT(GROUP,h.cont_phone_number_Invalid=2);
    cont_phone_number_Total_ErrorCount := COUNT(GROUP,h.cont_phone_number_Invalid>0);
    cont_fax_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.cont_fax_nbr_Invalid=1);
    cont_fax_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.cont_fax_nbr_Invalid=2);
    cont_fax_nbr_Total_ErrorCount := COUNT(GROUP,h.cont_fax_nbr_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.corp_key_Invalid,le.corp_vendor_Invalid,le.corp_state_origin_Invalid,le.corp_process_date_Invalid,le.corp_legal_name_Invalid,le.corp_phone_number_Invalid,le.corp_fax_nbr_Invalid,le.cont_filing_date_Invalid,le.cont_dob_Invalid,le.cont_effective_date_Invalid,le.cont_address_effective_date_Invalid,le.cont_phone_number_Invalid,le.cont_fax_nbr_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_corp_key(le.corp_key_Invalid),Fields.InvalidMessage_corp_vendor(le.corp_vendor_Invalid),Fields.InvalidMessage_corp_state_origin(le.corp_state_origin_Invalid),Fields.InvalidMessage_corp_process_date(le.corp_process_date_Invalid),Fields.InvalidMessage_corp_legal_name(le.corp_legal_name_Invalid),Fields.InvalidMessage_corp_phone_number(le.corp_phone_number_Invalid),Fields.InvalidMessage_corp_fax_nbr(le.corp_fax_nbr_Invalid),Fields.InvalidMessage_cont_filing_date(le.cont_filing_date_Invalid),Fields.InvalidMessage_cont_dob(le.cont_dob_Invalid),Fields.InvalidMessage_cont_effective_date(le.cont_effective_date_Invalid),Fields.InvalidMessage_cont_address_effective_date(le.cont_address_effective_date_Invalid),Fields.InvalidMessage_cont_phone_number(le.cont_phone_number_Invalid),Fields.InvalidMessage_cont_fax_nbr(le.cont_fax_nbr_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.corp_key_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_vendor_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_state_origin_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_process_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_legal_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_phone_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_fax_nbr_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cont_filing_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.cont_dob_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.cont_effective_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.cont_address_effective_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.cont_phone_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cont_fax_nbr_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'corp_key','corp_vendor','corp_state_origin','corp_process_date','corp_legal_name','corp_phone_number','corp_fax_nbr','cont_filing_date','cont_dob','cont_effective_date','cont_address_effective_date','cont_phone_number','cont_fax_nbr','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_date','invalid_mandatory','invalid_phone','invalid_phone','invalid_date','invalid_date','invalid_date','invalid_date','invalid_phone','invalid_phone','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.corp_key,(SALT30.StrType)le.corp_vendor,(SALT30.StrType)le.corp_state_origin,(SALT30.StrType)le.corp_process_date,(SALT30.StrType)le.corp_legal_name,(SALT30.StrType)le.corp_phone_number,(SALT30.StrType)le.corp_fax_nbr,(SALT30.StrType)le.cont_filing_date,(SALT30.StrType)le.cont_dob,(SALT30.StrType)le.cont_effective_date,(SALT30.StrType)le.cont_address_effective_date,(SALT30.StrType)le.cont_phone_number,(SALT30.StrType)le.cont_fax_nbr,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,13,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'corp_key:invalid_corp_key:LENGTH'
          ,'corp_vendor:invalid_corp_vendor:ALLOW','corp_vendor:invalid_corp_vendor:LENGTH'
          ,'corp_state_origin:invalid_state_origin:ALLOW','corp_state_origin:invalid_state_origin:LENGTH'
          ,'corp_process_date:invalid_date:ALLOW','corp_process_date:invalid_date:CUSTOM','corp_process_date:invalid_date:LENGTH'
          ,'corp_legal_name:invalid_mandatory:LENGTH'
          ,'corp_phone_number:invalid_phone:ALLOW','corp_phone_number:invalid_phone:LENGTH'
          ,'corp_fax_nbr:invalid_phone:ALLOW','corp_fax_nbr:invalid_phone:LENGTH'
          ,'cont_filing_date:invalid_date:ALLOW','cont_filing_date:invalid_date:CUSTOM','cont_filing_date:invalid_date:LENGTH'
          ,'cont_dob:invalid_date:ALLOW','cont_dob:invalid_date:CUSTOM','cont_dob:invalid_date:LENGTH'
          ,'cont_effective_date:invalid_date:ALLOW','cont_effective_date:invalid_date:CUSTOM','cont_effective_date:invalid_date:LENGTH'
          ,'cont_address_effective_date:invalid_date:ALLOW','cont_address_effective_date:invalid_date:CUSTOM','cont_address_effective_date:invalid_date:LENGTH'
          ,'cont_phone_number:invalid_phone:ALLOW','cont_phone_number:invalid_phone:LENGTH'
          ,'cont_fax_nbr:invalid_phone:ALLOW','cont_fax_nbr:invalid_phone:LENGTH','UNKNOWN');
      SELF.ErrorMessage := '';
      SELF.rulecnt := CHOOSE(c
          ,le.corp_key_LENGTH_ErrorCount
          ,le.corp_vendor_ALLOW_ErrorCount,le.corp_vendor_LENGTH_ErrorCount
          ,le.corp_state_origin_ALLOW_ErrorCount,le.corp_state_origin_LENGTH_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount,le.corp_process_date_LENGTH_ErrorCount
          ,le.corp_legal_name_LENGTH_ErrorCount
          ,le.corp_phone_number_ALLOW_ErrorCount,le.corp_phone_number_LENGTH_ErrorCount
          ,le.corp_fax_nbr_ALLOW_ErrorCount,le.corp_fax_nbr_LENGTH_ErrorCount
          ,le.cont_filing_date_ALLOW_ErrorCount,le.cont_filing_date_CUSTOM_ErrorCount,le.cont_filing_date_LENGTH_ErrorCount
          ,le.cont_dob_ALLOW_ErrorCount,le.cont_dob_CUSTOM_ErrorCount,le.cont_dob_LENGTH_ErrorCount
          ,le.cont_effective_date_ALLOW_ErrorCount,le.cont_effective_date_CUSTOM_ErrorCount,le.cont_effective_date_LENGTH_ErrorCount
          ,le.cont_address_effective_date_ALLOW_ErrorCount,le.cont_address_effective_date_CUSTOM_ErrorCount,le.cont_address_effective_date_LENGTH_ErrorCount
          ,le.cont_phone_number_ALLOW_ErrorCount,le.cont_phone_number_LENGTH_ErrorCount
          ,le.cont_fax_nbr_ALLOW_ErrorCount,le.cont_fax_nbr_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.corp_key_LENGTH_ErrorCount
          ,le.corp_vendor_ALLOW_ErrorCount,le.corp_vendor_LENGTH_ErrorCount
          ,le.corp_state_origin_ALLOW_ErrorCount,le.corp_state_origin_LENGTH_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount,le.corp_process_date_LENGTH_ErrorCount
          ,le.corp_legal_name_LENGTH_ErrorCount
          ,le.corp_phone_number_ALLOW_ErrorCount,le.corp_phone_number_LENGTH_ErrorCount
          ,le.corp_fax_nbr_ALLOW_ErrorCount,le.corp_fax_nbr_LENGTH_ErrorCount
          ,le.cont_filing_date_ALLOW_ErrorCount,le.cont_filing_date_CUSTOM_ErrorCount,le.cont_filing_date_LENGTH_ErrorCount
          ,le.cont_dob_ALLOW_ErrorCount,le.cont_dob_CUSTOM_ErrorCount,le.cont_dob_LENGTH_ErrorCount
          ,le.cont_effective_date_ALLOW_ErrorCount,le.cont_effective_date_CUSTOM_ErrorCount,le.cont_effective_date_LENGTH_ErrorCount
          ,le.cont_address_effective_date_ALLOW_ErrorCount,le.cont_address_effective_date_CUSTOM_ErrorCount,le.cont_address_effective_date_LENGTH_ErrorCount
          ,le.cont_phone_number_ALLOW_ErrorCount,le.cont_phone_number_LENGTH_ErrorCount
          ,le.cont_fax_nbr_ALLOW_ErrorCount,le.cont_fax_nbr_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,29,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT30.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT30.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF.ErrorMessage := ri.ErrorMessage;
   SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;

IMPORT CORP2_MAPPING,SALT32,UT;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Corp2_Mapping.LayoutsCommon.AR)
    UNSIGNED1 corp_key_Invalid;
    UNSIGNED1 corp_vendor_Invalid;
    UNSIGNED1 corp_state_origin_Invalid;
    UNSIGNED1 corp_process_date_Invalid;
    UNSIGNED1 corp_sos_charter_nbr_Invalid;
    UNSIGNED1 ar_year_Invalid;
    UNSIGNED1 ar_tax_amount_paid_Invalid;
    UNSIGNED1 ar_comment_Invalid;
    UNSIGNED1 ar_exempt_Invalid;
    UNSIGNED1 ar_license_tax_amount_Invalid;
    UNSIGNED1 ar_status_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Corp2_Mapping.LayoutsCommon.AR)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Corp2_Mapping.LayoutsCommon.AR) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.corp_key_Invalid := Fields.InValid_corp_key((SALT32.StrType)le.corp_key);
    SELF.corp_vendor_Invalid := Fields.InValid_corp_vendor((SALT32.StrType)le.corp_vendor);
    SELF.corp_state_origin_Invalid := Fields.InValid_corp_state_origin((SALT32.StrType)le.corp_state_origin);
    SELF.corp_process_date_Invalid := Fields.InValid_corp_process_date((SALT32.StrType)le.corp_process_date);
    SELF.corp_sos_charter_nbr_Invalid := Fields.InValid_corp_sos_charter_nbr((SALT32.StrType)le.corp_sos_charter_nbr);
    SELF.ar_year_Invalid := Fields.InValid_ar_year((SALT32.StrType)le.ar_year);
    SELF.ar_tax_amount_paid_Invalid := Fields.InValid_ar_tax_amount_paid((SALT32.StrType)le.ar_tax_amount_paid);
    SELF.ar_comment_Invalid := Fields.InValid_ar_comment((SALT32.StrType)le.ar_comment);
    SELF.ar_exempt_Invalid := Fields.InValid_ar_exempt((SALT32.StrType)le.ar_exempt);
    SELF.ar_license_tax_amount_Invalid := Fields.InValid_ar_license_tax_amount((SALT32.StrType)le.ar_license_tax_amount);
    SELF.ar_status_Invalid := Fields.InValid_ar_status((SALT32.StrType)le.ar_status);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Corp2_Mapping.LayoutsCommon.AR);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.corp_key_Invalid << 0 ) + ( le.corp_vendor_Invalid << 2 ) + ( le.corp_state_origin_Invalid << 3 ) + ( le.corp_process_date_Invalid << 4 ) + ( le.corp_sos_charter_nbr_Invalid << 6 ) + ( le.ar_year_Invalid << 8 ) + ( le.ar_tax_amount_paid_Invalid << 9 ) + ( le.ar_comment_Invalid << 10 ) + ( le.ar_exempt_Invalid << 11 ) + ( le.ar_license_tax_amount_Invalid << 12 ) + ( le.ar_status_Invalid << 13 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Corp2_Mapping.LayoutsCommon.AR);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.corp_key_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.corp_vendor_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.corp_state_origin_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.corp_process_date_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.corp_sos_charter_nbr_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.ar_year_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.ar_tax_amount_paid_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.ar_comment_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.ar_exempt_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.ar_license_tax_amount_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.ar_status_Invalid := (le.ScrubsBits1 >> 13) & 1;
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
    corp_vendor_ENUM_ErrorCount := COUNT(GROUP,h.corp_vendor_Invalid=1);
    corp_state_origin_ENUM_ErrorCount := COUNT(GROUP,h.corp_state_origin_Invalid=1);
    corp_process_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=1);
    corp_process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=2);
    corp_process_date_Total_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid>0);
    corp_sos_charter_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.corp_sos_charter_nbr_Invalid=1);
    corp_sos_charter_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.corp_sos_charter_nbr_Invalid=2);
    corp_sos_charter_nbr_Total_ErrorCount := COUNT(GROUP,h.corp_sos_charter_nbr_Invalid>0);
    ar_year_ALLOW_ErrorCount := COUNT(GROUP,h.ar_year_Invalid=1);
    ar_tax_amount_paid_ALLOW_ErrorCount := COUNT(GROUP,h.ar_tax_amount_paid_Invalid=1);
    ar_comment_ALLOW_ErrorCount := COUNT(GROUP,h.ar_comment_Invalid=1);
    ar_exempt_ENUM_ErrorCount := COUNT(GROUP,h.ar_exempt_Invalid=1);
    ar_license_tax_amount_ALLOW_ErrorCount := COUNT(GROUP,h.ar_license_tax_amount_Invalid=1);
    ar_status_ALLOW_ErrorCount := COUNT(GROUP,h.ar_status_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.corp_key_Invalid,le.corp_vendor_Invalid,le.corp_state_origin_Invalid,le.corp_process_date_Invalid,le.corp_sos_charter_nbr_Invalid,le.ar_year_Invalid,le.ar_tax_amount_paid_Invalid,le.ar_comment_Invalid,le.ar_exempt_Invalid,le.ar_license_tax_amount_Invalid,le.ar_status_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_corp_key(le.corp_key_Invalid),Fields.InvalidMessage_corp_vendor(le.corp_vendor_Invalid),Fields.InvalidMessage_corp_state_origin(le.corp_state_origin_Invalid),Fields.InvalidMessage_corp_process_date(le.corp_process_date_Invalid),Fields.InvalidMessage_corp_sos_charter_nbr(le.corp_sos_charter_nbr_Invalid),Fields.InvalidMessage_ar_year(le.ar_year_Invalid),Fields.InvalidMessage_ar_tax_amount_paid(le.ar_tax_amount_paid_Invalid),Fields.InvalidMessage_ar_comment(le.ar_comment_Invalid),Fields.InvalidMessage_ar_exempt(le.ar_exempt_Invalid),Fields.InvalidMessage_ar_license_tax_amount(le.ar_license_tax_amount_Invalid),Fields.InvalidMessage_ar_status(le.ar_status_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.corp_key_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_vendor_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_state_origin_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_process_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_sos_charter_nbr_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ar_year_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ar_tax_amount_paid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ar_comment_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ar_exempt_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ar_license_tax_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ar_status_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'corp_key','corp_vendor','corp_state_origin','corp_process_date','corp_sos_charter_nbr','ar_year','ar_tax_amount_paid','ar_comment','ar_exempt','ar_license_tax_amount','ar_status','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_date','invalid_charter_nbr','invalid_numeric','invalid_dollar_amt','invalid_alphaspec_chars','invalid_Y_N','invalid_dollar_amt','invalid_alphaspec_chars','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT32.StrType)le.corp_key,(SALT32.StrType)le.corp_vendor,(SALT32.StrType)le.corp_state_origin,(SALT32.StrType)le.corp_process_date,(SALT32.StrType)le.corp_sos_charter_nbr,(SALT32.StrType)le.ar_year,(SALT32.StrType)le.ar_tax_amount_paid,(SALT32.StrType)le.ar_comment,(SALT32.StrType)le.ar_exempt,(SALT32.StrType)le.ar_license_tax_amount,(SALT32.StrType)le.ar_status,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,11,Into(LEFT,COUNTER));
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
          ,'corp_vendor:invalid_corp_vendor:ENUM'
          ,'corp_state_origin:invalid_state_origin:ENUM'
          ,'corp_process_date:invalid_date:ALLOW','corp_process_date:invalid_date:CUSTOM'
          ,'corp_sos_charter_nbr:invalid_charter_nbr:ALLOW','corp_sos_charter_nbr:invalid_charter_nbr:LENGTH'
          ,'ar_year:invalid_numeric:ALLOW'
          ,'ar_tax_amount_paid:invalid_dollar_amt:ALLOW'
          ,'ar_comment:invalid_alphaspec_chars:ALLOW'
          ,'ar_exempt:invalid_Y_N:ENUM'
          ,'ar_license_tax_amount:invalid_dollar_amt:ALLOW'
          ,'ar_status:invalid_alphaspec_chars:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_corp_key(1),Fields.InvalidMessage_corp_key(2)
          ,Fields.InvalidMessage_corp_vendor(1)
          ,Fields.InvalidMessage_corp_state_origin(1)
          ,Fields.InvalidMessage_corp_process_date(1),Fields.InvalidMessage_corp_process_date(2)
          ,Fields.InvalidMessage_corp_sos_charter_nbr(1),Fields.InvalidMessage_corp_sos_charter_nbr(2)
          ,Fields.InvalidMessage_ar_year(1)
          ,Fields.InvalidMessage_ar_tax_amount_paid(1)
          ,Fields.InvalidMessage_ar_comment(1)
          ,Fields.InvalidMessage_ar_exempt(1)
          ,Fields.InvalidMessage_ar_license_tax_amount(1)
          ,Fields.InvalidMessage_ar_status(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTH_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount
          ,le.corp_sos_charter_nbr_ALLOW_ErrorCount,le.corp_sos_charter_nbr_LENGTH_ErrorCount
          ,le.ar_year_ALLOW_ErrorCount
          ,le.ar_tax_amount_paid_ALLOW_ErrorCount
          ,le.ar_comment_ALLOW_ErrorCount
          ,le.ar_exempt_ENUM_ErrorCount
          ,le.ar_license_tax_amount_ALLOW_ErrorCount
          ,le.ar_status_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTH_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount
          ,le.corp_sos_charter_nbr_ALLOW_ErrorCount,le.corp_sos_charter_nbr_LENGTH_ErrorCount
          ,le.ar_year_ALLOW_ErrorCount
          ,le.ar_tax_amount_paid_ALLOW_ErrorCount
          ,le.ar_comment_ALLOW_ErrorCount
          ,le.ar_exempt_ENUM_ErrorCount
          ,le.ar_license_tax_amount_ALLOW_ErrorCount
          ,le.ar_status_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,14,Into(LEFT,COUNTER));
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

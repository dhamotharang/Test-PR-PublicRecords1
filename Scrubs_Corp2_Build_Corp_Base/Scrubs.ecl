IMPORT ut,SALT30;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_in_file)
    UNSIGNED1 corp_key_Invalid;
    UNSIGNED1 corp_vendor_Invalid;
    UNSIGNED1 corp_state_origin_Invalid;
    UNSIGNED1 corp_process_date_Invalid;
    UNSIGNED1 corp_orig_sos_charter_nbr_Invalid;
    UNSIGNED1 corp_sos_charter_nbr_Invalid;
    UNSIGNED1 corp_legal_name_Invalid;
    UNSIGNED1 corp_phone_number_Invalid;
    UNSIGNED1 corp_fax_nbr_Invalid;
    UNSIGNED1 corp_status_date_Invalid;
    UNSIGNED1 corp_standing_Invalid;
    UNSIGNED1 corp_inc_state_Invalid;
    UNSIGNED1 corp_inc_date_Invalid;
    UNSIGNED1 corp_foreign_domestic_ind_Invalid;
    UNSIGNED1 corp_for_profit_ind_Invalid;
    UNSIGNED1 corp_public_or_private_ind_Invalid;
    UNSIGNED1 corp_ra_phone_number_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_in_file)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_in_file) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.corp_key_Invalid := Fields.InValid_corp_key((SALT30.StrType)le.corp_key);
    SELF.corp_vendor_Invalid := Fields.InValid_corp_vendor((SALT30.StrType)le.corp_vendor);
    SELF.corp_state_origin_Invalid := Fields.InValid_corp_state_origin((SALT30.StrType)le.corp_state_origin);
    SELF.corp_process_date_Invalid := Fields.InValid_corp_process_date((SALT30.StrType)le.corp_process_date);
    SELF.corp_orig_sos_charter_nbr_Invalid := Fields.InValid_corp_orig_sos_charter_nbr((SALT30.StrType)le.corp_orig_sos_charter_nbr);
    SELF.corp_sos_charter_nbr_Invalid := Fields.InValid_corp_sos_charter_nbr((SALT30.StrType)le.corp_sos_charter_nbr);
    SELF.corp_legal_name_Invalid := Fields.InValid_corp_legal_name((SALT30.StrType)le.corp_legal_name);
    SELF.corp_phone_number_Invalid := Fields.InValid_corp_phone_number((SALT30.StrType)le.corp_phone_number);
    SELF.corp_fax_nbr_Invalid := Fields.InValid_corp_fax_nbr((SALT30.StrType)le.corp_fax_nbr);
    SELF.corp_status_date_Invalid := Fields.InValid_corp_status_date((SALT30.StrType)le.corp_status_date);
    SELF.corp_standing_Invalid := Fields.InValid_corp_standing((SALT30.StrType)le.corp_standing);
    SELF.corp_inc_state_Invalid := Fields.InValid_corp_inc_state((SALT30.StrType)le.corp_inc_state);
    SELF.corp_inc_date_Invalid := Fields.InValid_corp_inc_date((SALT30.StrType)le.corp_inc_date);
    SELF.corp_foreign_domestic_ind_Invalid := Fields.InValid_corp_foreign_domestic_ind((SALT30.StrType)le.corp_foreign_domestic_ind);
    SELF.corp_for_profit_ind_Invalid := Fields.InValid_corp_for_profit_ind((SALT30.StrType)le.corp_for_profit_ind);
    SELF.corp_public_or_private_ind_Invalid := Fields.InValid_corp_public_or_private_ind((SALT30.StrType)le.corp_public_or_private_ind);
    SELF.corp_ra_phone_number_Invalid := Fields.InValid_corp_ra_phone_number((SALT30.StrType)le.corp_ra_phone_number);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.corp_key_Invalid << 0 ) + ( le.corp_vendor_Invalid << 1 ) + ( le.corp_state_origin_Invalid << 3 ) + ( le.corp_process_date_Invalid << 5 ) + ( le.corp_orig_sos_charter_nbr_Invalid << 7 ) + ( le.corp_sos_charter_nbr_Invalid << 8 ) + ( le.corp_legal_name_Invalid << 9 ) + ( le.corp_phone_number_Invalid << 10 ) + ( le.corp_fax_nbr_Invalid << 12 ) + ( le.corp_status_date_Invalid << 14 ) + ( le.corp_standing_Invalid << 16 ) + ( le.corp_inc_state_Invalid << 17 ) + ( le.corp_inc_date_Invalid << 19 ) + ( le.corp_foreign_domestic_ind_Invalid << 21 ) + ( le.corp_for_profit_ind_Invalid << 22 ) + ( le.corp_public_or_private_ind_Invalid << 23 ) + ( le.corp_ra_phone_number_Invalid << 24 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_in_file);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.corp_key_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.corp_vendor_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.corp_state_origin_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.corp_process_date_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.corp_orig_sos_charter_nbr_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.corp_sos_charter_nbr_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.corp_legal_name_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.corp_phone_number_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.corp_fax_nbr_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.corp_status_date_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.corp_standing_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.corp_inc_state_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.corp_inc_date_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.corp_foreign_domestic_ind_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.corp_for_profit_ind_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.corp_public_or_private_ind_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.corp_ra_phone_number_Invalid := (le.ScrubsBits1 >> 24) & 3;
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
    corp_orig_sos_charter_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.corp_orig_sos_charter_nbr_Invalid=1);
    corp_sos_charter_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.corp_sos_charter_nbr_Invalid=1);
    corp_legal_name_LENGTH_ErrorCount := COUNT(GROUP,h.corp_legal_name_Invalid=1);
    corp_phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.corp_phone_number_Invalid=1);
    corp_phone_number_LENGTH_ErrorCount := COUNT(GROUP,h.corp_phone_number_Invalid=2);
    corp_phone_number_Total_ErrorCount := COUNT(GROUP,h.corp_phone_number_Invalid>0);
    corp_fax_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.corp_fax_nbr_Invalid=1);
    corp_fax_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.corp_fax_nbr_Invalid=2);
    corp_fax_nbr_Total_ErrorCount := COUNT(GROUP,h.corp_fax_nbr_Invalid>0);
    corp_status_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_status_date_Invalid=1);
    corp_status_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_status_date_Invalid=2);
    corp_status_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_status_date_Invalid=3);
    corp_status_date_Total_ErrorCount := COUNT(GROUP,h.corp_status_date_Invalid>0);
    corp_standing_ENUM_ErrorCount := COUNT(GROUP,h.corp_standing_Invalid=1);
    corp_inc_state_ALLOW_ErrorCount := COUNT(GROUP,h.corp_inc_state_Invalid=1);
    corp_inc_state_LENGTH_ErrorCount := COUNT(GROUP,h.corp_inc_state_Invalid=2);
    corp_inc_state_Total_ErrorCount := COUNT(GROUP,h.corp_inc_state_Invalid>0);
    corp_inc_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid=1);
    corp_inc_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid=2);
    corp_inc_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid=3);
    corp_inc_date_Total_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid>0);
    corp_foreign_domestic_ind_ENUM_ErrorCount := COUNT(GROUP,h.corp_foreign_domestic_ind_Invalid=1);
    corp_for_profit_ind_ENUM_ErrorCount := COUNT(GROUP,h.corp_for_profit_ind_Invalid=1);
    corp_public_or_private_ind_ENUM_ErrorCount := COUNT(GROUP,h.corp_public_or_private_ind_Invalid=1);
    corp_ra_phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.corp_ra_phone_number_Invalid=1);
    corp_ra_phone_number_LENGTH_ErrorCount := COUNT(GROUP,h.corp_ra_phone_number_Invalid=2);
    corp_ra_phone_number_Total_ErrorCount := COUNT(GROUP,h.corp_ra_phone_number_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.corp_key_Invalid,le.corp_vendor_Invalid,le.corp_state_origin_Invalid,le.corp_process_date_Invalid,le.corp_orig_sos_charter_nbr_Invalid,le.corp_sos_charter_nbr_Invalid,le.corp_legal_name_Invalid,le.corp_phone_number_Invalid,le.corp_fax_nbr_Invalid,le.corp_status_date_Invalid,le.corp_standing_Invalid,le.corp_inc_state_Invalid,le.corp_inc_date_Invalid,le.corp_foreign_domestic_ind_Invalid,le.corp_for_profit_ind_Invalid,le.corp_public_or_private_ind_Invalid,le.corp_ra_phone_number_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_corp_key(le.corp_key_Invalid),Fields.InvalidMessage_corp_vendor(le.corp_vendor_Invalid),Fields.InvalidMessage_corp_state_origin(le.corp_state_origin_Invalid),Fields.InvalidMessage_corp_process_date(le.corp_process_date_Invalid),Fields.InvalidMessage_corp_orig_sos_charter_nbr(le.corp_orig_sos_charter_nbr_Invalid),Fields.InvalidMessage_corp_sos_charter_nbr(le.corp_sos_charter_nbr_Invalid),Fields.InvalidMessage_corp_legal_name(le.corp_legal_name_Invalid),Fields.InvalidMessage_corp_phone_number(le.corp_phone_number_Invalid),Fields.InvalidMessage_corp_fax_nbr(le.corp_fax_nbr_Invalid),Fields.InvalidMessage_corp_status_date(le.corp_status_date_Invalid),Fields.InvalidMessage_corp_standing(le.corp_standing_Invalid),Fields.InvalidMessage_corp_inc_state(le.corp_inc_state_Invalid),Fields.InvalidMessage_corp_inc_date(le.corp_inc_date_Invalid),Fields.InvalidMessage_corp_foreign_domestic_ind(le.corp_foreign_domestic_ind_Invalid),Fields.InvalidMessage_corp_for_profit_ind(le.corp_for_profit_ind_Invalid),Fields.InvalidMessage_corp_public_or_private_ind(le.corp_public_or_private_ind_Invalid),Fields.InvalidMessage_corp_ra_phone_number(le.corp_ra_phone_number_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.corp_key_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_vendor_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_state_origin_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_process_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_orig_sos_charter_nbr_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_sos_charter_nbr_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_legal_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_phone_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_fax_nbr_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_status_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_standing_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_inc_state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_inc_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_foreign_domestic_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_for_profit_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_public_or_private_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_ra_phone_number_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'corp_key','corp_vendor','corp_state_origin','corp_process_date','corp_orig_sos_charter_nbr','corp_sos_charter_nbr','corp_legal_name','corp_phone_number','corp_fax_nbr','corp_status_date','corp_standing','corp_inc_state','corp_inc_date','corp_foreign_domestic_ind','corp_for_profit_ind','corp_public_or_private_ind','corp_ra_phone_number','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_phone','invalid_phone','invalid_date','invalid_flag_code','invalid_state_origin','invalid_date','invalid_forgn_dom_code','invalid_flag_code','invalid_flag_code','invalid_phone','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.corp_key,(SALT30.StrType)le.corp_vendor,(SALT30.StrType)le.corp_state_origin,(SALT30.StrType)le.corp_process_date,(SALT30.StrType)le.corp_orig_sos_charter_nbr,(SALT30.StrType)le.corp_sos_charter_nbr,(SALT30.StrType)le.corp_legal_name,(SALT30.StrType)le.corp_phone_number,(SALT30.StrType)le.corp_fax_nbr,(SALT30.StrType)le.corp_status_date,(SALT30.StrType)le.corp_standing,(SALT30.StrType)le.corp_inc_state,(SALT30.StrType)le.corp_inc_date,(SALT30.StrType)le.corp_foreign_domestic_ind,(SALT30.StrType)le.corp_for_profit_ind,(SALT30.StrType)le.corp_public_or_private_ind,(SALT30.StrType)le.corp_ra_phone_number,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,17,Into(LEFT,COUNTER));
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
          ,'corp_orig_sos_charter_nbr:invalid_mandatory:LENGTH'
          ,'corp_sos_charter_nbr:invalid_mandatory:LENGTH'
          ,'corp_legal_name:invalid_mandatory:LENGTH'
          ,'corp_phone_number:invalid_phone:ALLOW','corp_phone_number:invalid_phone:LENGTH'
          ,'corp_fax_nbr:invalid_phone:ALLOW','corp_fax_nbr:invalid_phone:LENGTH'
          ,'corp_status_date:invalid_date:ALLOW','corp_status_date:invalid_date:CUSTOM','corp_status_date:invalid_date:LENGTH'
          ,'corp_standing:invalid_flag_code:ENUM'
          ,'corp_inc_state:invalid_state_origin:ALLOW','corp_inc_state:invalid_state_origin:LENGTH'
          ,'corp_inc_date:invalid_date:ALLOW','corp_inc_date:invalid_date:CUSTOM','corp_inc_date:invalid_date:LENGTH'
          ,'corp_foreign_domestic_ind:invalid_forgn_dom_code:ENUM'
          ,'corp_for_profit_ind:invalid_flag_code:ENUM'
          ,'corp_public_or_private_ind:invalid_flag_code:ENUM'
          ,'corp_ra_phone_number:invalid_phone:ALLOW','corp_ra_phone_number:invalid_phone:LENGTH','UNKNOWN');
      SELF.ErrorMessage := '';
      SELF.rulecnt := CHOOSE(c
          ,le.corp_key_LENGTH_ErrorCount
          ,le.corp_vendor_ALLOW_ErrorCount,le.corp_vendor_LENGTH_ErrorCount
          ,le.corp_state_origin_ALLOW_ErrorCount,le.corp_state_origin_LENGTH_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount,le.corp_process_date_LENGTH_ErrorCount
          ,le.corp_orig_sos_charter_nbr_LENGTH_ErrorCount
          ,le.corp_sos_charter_nbr_LENGTH_ErrorCount
          ,le.corp_legal_name_LENGTH_ErrorCount
          ,le.corp_phone_number_ALLOW_ErrorCount,le.corp_phone_number_LENGTH_ErrorCount
          ,le.corp_fax_nbr_ALLOW_ErrorCount,le.corp_fax_nbr_LENGTH_ErrorCount
          ,le.corp_status_date_ALLOW_ErrorCount,le.corp_status_date_CUSTOM_ErrorCount,le.corp_status_date_LENGTH_ErrorCount
          ,le.corp_standing_ENUM_ErrorCount
          ,le.corp_inc_state_ALLOW_ErrorCount,le.corp_inc_state_LENGTH_ErrorCount
          ,le.corp_inc_date_ALLOW_ErrorCount,le.corp_inc_date_CUSTOM_ErrorCount,le.corp_inc_date_LENGTH_ErrorCount
          ,le.corp_foreign_domestic_ind_ENUM_ErrorCount
          ,le.corp_for_profit_ind_ENUM_ErrorCount
          ,le.corp_public_or_private_ind_ENUM_ErrorCount
          ,le.corp_ra_phone_number_ALLOW_ErrorCount,le.corp_ra_phone_number_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.corp_key_LENGTH_ErrorCount
          ,le.corp_vendor_ALLOW_ErrorCount,le.corp_vendor_LENGTH_ErrorCount
          ,le.corp_state_origin_ALLOW_ErrorCount,le.corp_state_origin_LENGTH_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount,le.corp_process_date_LENGTH_ErrorCount
          ,le.corp_orig_sos_charter_nbr_LENGTH_ErrorCount
          ,le.corp_sos_charter_nbr_LENGTH_ErrorCount
          ,le.corp_legal_name_LENGTH_ErrorCount
          ,le.corp_phone_number_ALLOW_ErrorCount,le.corp_phone_number_LENGTH_ErrorCount
          ,le.corp_fax_nbr_ALLOW_ErrorCount,le.corp_fax_nbr_LENGTH_ErrorCount
          ,le.corp_status_date_ALLOW_ErrorCount,le.corp_status_date_CUSTOM_ErrorCount,le.corp_status_date_LENGTH_ErrorCount
          ,le.corp_standing_ENUM_ErrorCount
          ,le.corp_inc_state_ALLOW_ErrorCount,le.corp_inc_state_LENGTH_ErrorCount
          ,le.corp_inc_date_ALLOW_ErrorCount,le.corp_inc_date_CUSTOM_ErrorCount,le.corp_inc_date_LENGTH_ErrorCount
          ,le.corp_foreign_domestic_ind_ENUM_ErrorCount
          ,le.corp_for_profit_ind_ENUM_ErrorCount
          ,le.corp_public_or_private_ind_ENUM_ErrorCount
          ,le.corp_ra_phone_number_ALLOW_ErrorCount,le.corp_ra_phone_number_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
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

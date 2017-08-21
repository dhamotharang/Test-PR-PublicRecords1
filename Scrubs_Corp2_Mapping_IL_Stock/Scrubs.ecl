IMPORT CORP2_MAPPING,SALT34,UT;
IMPORT Scrubs,Scrubs_Corp2_Mapping_IL_Stock; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(corp2_mapping.layoutscommon.stock)
    UNSIGNED1 corp_key_Invalid;
    UNSIGNED1 corp_vendor_Invalid;
    UNSIGNED1 corp_state_origin_Invalid;
    UNSIGNED1 corp_process_date_Invalid;
    UNSIGNED1 corp_sos_charter_nbr_Invalid;
    UNSIGNED1 stock_class_Invalid;
    UNSIGNED1 stock_shares_issued_Invalid;
    UNSIGNED1 stock_authorized_nbr_Invalid;
    UNSIGNED1 stock_par_value_Invalid;
    UNSIGNED1 stock_change_ind_Invalid;
    UNSIGNED1 stock_change_date_Invalid;
    UNSIGNED1 stock_change_in_cap_Invalid;
    UNSIGNED1 stock_tax_capital_Invalid;
    UNSIGNED1 stock_total_capital_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(corp2_mapping.layoutscommon.stock)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(corp2_mapping.layoutscommon.stock) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.corp_key_Invalid := Fields.InValid_corp_key((SALT34.StrType)le.corp_key);
    SELF.corp_vendor_Invalid := Fields.InValid_corp_vendor((SALT34.StrType)le.corp_vendor);
    SELF.corp_state_origin_Invalid := Fields.InValid_corp_state_origin((SALT34.StrType)le.corp_state_origin);
    SELF.corp_process_date_Invalid := Fields.InValid_corp_process_date((SALT34.StrType)le.corp_process_date);
    SELF.corp_sos_charter_nbr_Invalid := Fields.InValid_corp_sos_charter_nbr((SALT34.StrType)le.corp_sos_charter_nbr);
    SELF.stock_class_Invalid := Fields.InValid_stock_class((SALT34.StrType)le.stock_class);
    SELF.stock_shares_issued_Invalid := Fields.InValid_stock_shares_issued((SALT34.StrType)le.stock_shares_issued);
    SELF.stock_authorized_nbr_Invalid := Fields.InValid_stock_authorized_nbr((SALT34.StrType)le.stock_authorized_nbr);
    SELF.stock_par_value_Invalid := Fields.InValid_stock_par_value((SALT34.StrType)le.stock_par_value);
    SELF.stock_change_ind_Invalid := Fields.InValid_stock_change_ind((SALT34.StrType)le.stock_change_ind);
    SELF.stock_change_date_Invalid := Fields.InValid_stock_change_date((SALT34.StrType)le.stock_change_date);
    SELF.stock_change_in_cap_Invalid := Fields.InValid_stock_change_in_cap((SALT34.StrType)le.stock_change_in_cap);
    SELF.stock_tax_capital_Invalid := Fields.InValid_stock_tax_capital((SALT34.StrType)le.stock_tax_capital);
    SELF.stock_total_capital_Invalid := Fields.InValid_stock_total_capital((SALT34.StrType)le.stock_total_capital);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),corp2_mapping.layoutscommon.stock);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.corp_key_Invalid << 0 ) + ( le.corp_vendor_Invalid << 2 ) + ( le.corp_state_origin_Invalid << 3 ) + ( le.corp_process_date_Invalid << 4 ) + ( le.corp_sos_charter_nbr_Invalid << 6 ) + ( le.stock_class_Invalid << 8 ) + ( le.stock_shares_issued_Invalid << 9 ) + ( le.stock_authorized_nbr_Invalid << 10 ) + ( le.stock_par_value_Invalid << 11 ) + ( le.stock_change_ind_Invalid << 12 ) + ( le.stock_change_date_Invalid << 13 ) + ( le.stock_change_in_cap_Invalid << 15 ) + ( le.stock_tax_capital_Invalid << 16 ) + ( le.stock_total_capital_Invalid << 17 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,corp2_mapping.layoutscommon.stock);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.corp_key_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.corp_vendor_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.corp_state_origin_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.corp_process_date_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.corp_sos_charter_nbr_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.stock_class_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.stock_shares_issued_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.stock_authorized_nbr_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.stock_par_value_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.stock_change_ind_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.stock_change_date_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.stock_change_in_cap_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.stock_tax_capital_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.stock_total_capital_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT)) : independent;
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
    stock_class_CUSTOM_ErrorCount := COUNT(GROUP,h.stock_class_Invalid=1);
    stock_shares_issued_CUSTOM_ErrorCount := COUNT(GROUP,h.stock_shares_issued_Invalid=1);
    stock_authorized_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.stock_authorized_nbr_Invalid=1);
    stock_par_value_CUSTOM_ErrorCount := COUNT(GROUP,h.stock_par_value_Invalid=1);
    stock_change_ind_ENUM_ErrorCount := COUNT(GROUP,h.stock_change_ind_Invalid=1);
    stock_change_date_ALLOW_ErrorCount := COUNT(GROUP,h.stock_change_date_Invalid=1);
    stock_change_date_CUSTOM_ErrorCount := COUNT(GROUP,h.stock_change_date_Invalid=2);
    stock_change_date_Total_ErrorCount := COUNT(GROUP,h.stock_change_date_Invalid>0);
    stock_change_in_cap_ALLOW_ErrorCount := COUNT(GROUP,h.stock_change_in_cap_Invalid=1);
    stock_tax_capital_CUSTOM_ErrorCount := COUNT(GROUP,h.stock_tax_capital_Invalid=1);
    stock_total_capital_CUSTOM_ErrorCount := COUNT(GROUP,h.stock_total_capital_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r) : independent;
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT34.StrType ErrorMessage;
    SALT34.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.corp_key_Invalid,le.corp_vendor_Invalid,le.corp_state_origin_Invalid,le.corp_process_date_Invalid,le.corp_sos_charter_nbr_Invalid,le.stock_class_Invalid,le.stock_shares_issued_Invalid,le.stock_authorized_nbr_Invalid,le.stock_par_value_Invalid,le.stock_change_ind_Invalid,le.stock_change_date_Invalid,le.stock_change_in_cap_Invalid,le.stock_tax_capital_Invalid,le.stock_total_capital_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_corp_key(le.corp_key_Invalid),Fields.InvalidMessage_corp_vendor(le.corp_vendor_Invalid),Fields.InvalidMessage_corp_state_origin(le.corp_state_origin_Invalid),Fields.InvalidMessage_corp_process_date(le.corp_process_date_Invalid),Fields.InvalidMessage_corp_sos_charter_nbr(le.corp_sos_charter_nbr_Invalid),Fields.InvalidMessage_stock_class(le.stock_class_Invalid),Fields.InvalidMessage_stock_shares_issued(le.stock_shares_issued_Invalid),Fields.InvalidMessage_stock_authorized_nbr(le.stock_authorized_nbr_Invalid),Fields.InvalidMessage_stock_par_value(le.stock_par_value_Invalid),Fields.InvalidMessage_stock_change_ind(le.stock_change_ind_Invalid),Fields.InvalidMessage_stock_change_date(le.stock_change_date_Invalid),Fields.InvalidMessage_stock_change_in_cap(le.stock_change_in_cap_Invalid),Fields.InvalidMessage_stock_tax_capital(le.stock_tax_capital_Invalid),Fields.InvalidMessage_stock_total_capital(le.stock_total_capital_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.corp_key_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_vendor_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_state_origin_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_process_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_sos_charter_nbr_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.stock_class_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.stock_shares_issued_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.stock_authorized_nbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.stock_par_value_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.stock_change_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.stock_change_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.stock_change_in_cap_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.stock_tax_capital_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.stock_total_capital_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'corp_key','corp_vendor','corp_state_origin','corp_process_date','corp_sos_charter_nbr','stock_class','stock_shares_issued','stock_authorized_nbr','stock_par_value','stock_change_ind','stock_change_date','stock_change_in_cap','stock_tax_capital','stock_total_capital','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_date','invalid_charter_nbr','invalid_class','invalid_shares','invalid_numeric','invalid_money','invalid_Y_N','invalid_date','invalid_numeric','invalid_money','invalid_money','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT34.StrType)le.corp_key,(SALT34.StrType)le.corp_vendor,(SALT34.StrType)le.corp_state_origin,(SALT34.StrType)le.corp_process_date,(SALT34.StrType)le.corp_sos_charter_nbr,(SALT34.StrType)le.stock_class,(SALT34.StrType)le.stock_shares_issued,(SALT34.StrType)le.stock_authorized_nbr,(SALT34.StrType)le.stock_par_value,(SALT34.StrType)le.stock_change_ind,(SALT34.StrType)le.stock_change_date,(SALT34.StrType)le.stock_change_in_cap,(SALT34.StrType)le.stock_tax_capital,(SALT34.StrType)le.stock_total_capital,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,14,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT34.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'corp_key:invalid_corp_key:ALLOW','corp_key:invalid_corp_key:LENGTH'
          ,'corp_vendor:invalid_corp_vendor:ENUM'
          ,'corp_state_origin:invalid_state_origin:ENUM'
          ,'corp_process_date:invalid_date:ALLOW','corp_process_date:invalid_date:CUSTOM'
          ,'corp_sos_charter_nbr:invalid_charter_nbr:ALLOW','corp_sos_charter_nbr:invalid_charter_nbr:LENGTH'
          ,'stock_class:invalid_class:CUSTOM'
          ,'stock_shares_issued:invalid_shares:CUSTOM'
          ,'stock_authorized_nbr:invalid_numeric:ALLOW'
          ,'stock_par_value:invalid_money:CUSTOM'
          ,'stock_change_ind:invalid_Y_N:ENUM'
          ,'stock_change_date:invalid_date:ALLOW','stock_change_date:invalid_date:CUSTOM'
          ,'stock_change_in_cap:invalid_numeric:ALLOW'
          ,'stock_tax_capital:invalid_money:CUSTOM'
          ,'stock_total_capital:invalid_money:CUSTOM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_corp_key(1),Fields.InvalidMessage_corp_key(2)
          ,Fields.InvalidMessage_corp_vendor(1)
          ,Fields.InvalidMessage_corp_state_origin(1)
          ,Fields.InvalidMessage_corp_process_date(1),Fields.InvalidMessage_corp_process_date(2)
          ,Fields.InvalidMessage_corp_sos_charter_nbr(1),Fields.InvalidMessage_corp_sos_charter_nbr(2)
          ,Fields.InvalidMessage_stock_class(1)
          ,Fields.InvalidMessage_stock_shares_issued(1)
          ,Fields.InvalidMessage_stock_authorized_nbr(1)
          ,Fields.InvalidMessage_stock_par_value(1)
          ,Fields.InvalidMessage_stock_change_ind(1)
          ,Fields.InvalidMessage_stock_change_date(1),Fields.InvalidMessage_stock_change_date(2)
          ,Fields.InvalidMessage_stock_change_in_cap(1)
          ,Fields.InvalidMessage_stock_tax_capital(1)
          ,Fields.InvalidMessage_stock_total_capital(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTH_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount
          ,le.corp_sos_charter_nbr_ALLOW_ErrorCount,le.corp_sos_charter_nbr_LENGTH_ErrorCount
          ,le.stock_class_CUSTOM_ErrorCount
          ,le.stock_shares_issued_CUSTOM_ErrorCount
          ,le.stock_authorized_nbr_ALLOW_ErrorCount
          ,le.stock_par_value_CUSTOM_ErrorCount
          ,le.stock_change_ind_ENUM_ErrorCount
          ,le.stock_change_date_ALLOW_ErrorCount,le.stock_change_date_CUSTOM_ErrorCount
          ,le.stock_change_in_cap_ALLOW_ErrorCount
          ,le.stock_tax_capital_CUSTOM_ErrorCount
          ,le.stock_total_capital_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTH_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount
          ,le.corp_sos_charter_nbr_ALLOW_ErrorCount,le.corp_sos_charter_nbr_LENGTH_ErrorCount
          ,le.stock_class_CUSTOM_ErrorCount
          ,le.stock_shares_issued_CUSTOM_ErrorCount
          ,le.stock_authorized_nbr_ALLOW_ErrorCount
          ,le.stock_par_value_CUSTOM_ErrorCount
          ,le.stock_change_ind_ENUM_ErrorCount
          ,le.stock_change_date_ALLOW_ErrorCount,le.stock_change_date_CUSTOM_ErrorCount
          ,le.stock_change_in_cap_ALLOW_ErrorCount
          ,le.stock_tax_capital_CUSTOM_ErrorCount
          ,le.stock_total_capital_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,18,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT34.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT34.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;

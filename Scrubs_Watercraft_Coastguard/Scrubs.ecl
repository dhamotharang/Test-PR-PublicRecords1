IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_Watercraft_Coastguard)
    UNSIGNED1 watercraft_key_Invalid;
    UNSIGNED1 state_origin_Invalid;
    UNSIGNED1 source_code_Invalid;
    UNSIGNED1 hull_number_Invalid;
    UNSIGNED1 hull_identification_number_Invalid;
    UNSIGNED1 registered_gross_tons_Invalid;
    UNSIGNED1 registered_net_tons_Invalid;
    UNSIGNED1 registered_length_Invalid;
    UNSIGNED1 registered_breadth_Invalid;
    UNSIGNED1 registered_depth_Invalid;
    UNSIGNED1 itc_gross_tons_Invalid;
    UNSIGNED1 itc_net_tons_Invalid;
    UNSIGNED1 itc_length_Invalid;
    UNSIGNED1 itc_breadth_Invalid;
    UNSIGNED1 itc_depth_Invalid;
    UNSIGNED1 date_issued_Invalid;
    UNSIGNED1 date_expires_Invalid;
    UNSIGNED1 persistent_record_id_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Watercraft_Coastguard)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_Watercraft_Coastguard) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.watercraft_key_Invalid := Fields.InValid_watercraft_key((SALT30.StrType)le.watercraft_key);
    SELF.state_origin_Invalid := Fields.InValid_state_origin((SALT30.StrType)le.state_origin);
    SELF.source_code_Invalid := Fields.InValid_source_code((SALT30.StrType)le.source_code);
    SELF.hull_number_Invalid := Fields.InValid_hull_number((SALT30.StrType)le.hull_number);
    SELF.hull_identification_number_Invalid := Fields.InValid_hull_identification_number((SALT30.StrType)le.hull_identification_number);
    SELF.registered_gross_tons_Invalid := Fields.InValid_registered_gross_tons((SALT30.StrType)le.registered_gross_tons);
    SELF.registered_net_tons_Invalid := Fields.InValid_registered_net_tons((SALT30.StrType)le.registered_net_tons);
    SELF.registered_length_Invalid := Fields.InValid_registered_length((SALT30.StrType)le.registered_length);
    SELF.registered_breadth_Invalid := Fields.InValid_registered_breadth((SALT30.StrType)le.registered_breadth);
    SELF.registered_depth_Invalid := Fields.InValid_registered_depth((SALT30.StrType)le.registered_depth);
    SELF.itc_gross_tons_Invalid := Fields.InValid_itc_gross_tons((SALT30.StrType)le.itc_gross_tons);
    SELF.itc_net_tons_Invalid := Fields.InValid_itc_net_tons((SALT30.StrType)le.itc_net_tons);
    SELF.itc_length_Invalid := Fields.InValid_itc_length((SALT30.StrType)le.itc_length);
    SELF.itc_breadth_Invalid := Fields.InValid_itc_breadth((SALT30.StrType)le.itc_breadth);
    SELF.itc_depth_Invalid := Fields.InValid_itc_depth((SALT30.StrType)le.itc_depth);
    SELF.date_issued_Invalid := Fields.InValid_date_issued((SALT30.StrType)le.date_issued);
    SELF.date_expires_Invalid := Fields.InValid_date_expires((SALT30.StrType)le.date_expires);
    SELF.persistent_record_id_Invalid := Fields.InValid_persistent_record_id((SALT30.StrType)le.persistent_record_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.watercraft_key_Invalid << 0 ) + ( le.state_origin_Invalid << 1 ) + ( le.source_code_Invalid << 3 ) + ( le.hull_number_Invalid << 5 ) + ( le.hull_identification_number_Invalid << 7 ) + ( le.registered_gross_tons_Invalid << 9 ) + ( le.registered_net_tons_Invalid << 11 ) + ( le.registered_length_Invalid << 13 ) + ( le.registered_breadth_Invalid << 15 ) + ( le.registered_depth_Invalid << 17 ) + ( le.itc_gross_tons_Invalid << 19 ) + ( le.itc_net_tons_Invalid << 21 ) + ( le.itc_length_Invalid << 23 ) + ( le.itc_breadth_Invalid << 25 ) + ( le.itc_depth_Invalid << 27 ) + ( le.date_issued_Invalid << 29 ) + ( le.date_expires_Invalid << 31 ) + ( le.persistent_record_id_Invalid << 33 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Watercraft_Coastguard);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.watercraft_key_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.state_origin_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.source_code_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.hull_number_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.hull_identification_number_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.registered_gross_tons_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.registered_net_tons_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.registered_length_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.registered_breadth_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.registered_depth_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.itc_gross_tons_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.itc_net_tons_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.itc_length_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.itc_breadth_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.itc_depth_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.date_issued_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.date_expires_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.persistent_record_id_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.source_code;
    TotalCnt := COUNT(GROUP); // Number of records in total
    watercraft_key_LENGTH_ErrorCount := COUNT(GROUP,h.watercraft_key_Invalid=1);
    state_origin_ALLOW_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=1);
    state_origin_LENGTH_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=2);
    state_origin_Total_ErrorCount := COUNT(GROUP,h.state_origin_Invalid>0);
    source_code_ALLOW_ErrorCount := COUNT(GROUP,h.source_code_Invalid=1);
    source_code_LENGTH_ErrorCount := COUNT(GROUP,h.source_code_Invalid=2);
    source_code_Total_ErrorCount := COUNT(GROUP,h.source_code_Invalid>0);
    hull_number_ALLOW_ErrorCount := COUNT(GROUP,h.hull_number_Invalid=1);
    hull_number_LENGTH_ErrorCount := COUNT(GROUP,h.hull_number_Invalid=2);
    hull_number_Total_ErrorCount := COUNT(GROUP,h.hull_number_Invalid>0);
    hull_identification_number_ALLOW_ErrorCount := COUNT(GROUP,h.hull_identification_number_Invalid=1);
    hull_identification_number_LENGTH_ErrorCount := COUNT(GROUP,h.hull_identification_number_Invalid=2);
    hull_identification_number_Total_ErrorCount := COUNT(GROUP,h.hull_identification_number_Invalid>0);
    registered_gross_tons_ALLOW_ErrorCount := COUNT(GROUP,h.registered_gross_tons_Invalid=1);
    registered_gross_tons_LENGTH_ErrorCount := COUNT(GROUP,h.registered_gross_tons_Invalid=2);
    registered_gross_tons_Total_ErrorCount := COUNT(GROUP,h.registered_gross_tons_Invalid>0);
    registered_net_tons_ALLOW_ErrorCount := COUNT(GROUP,h.registered_net_tons_Invalid=1);
    registered_net_tons_LENGTH_ErrorCount := COUNT(GROUP,h.registered_net_tons_Invalid=2);
    registered_net_tons_Total_ErrorCount := COUNT(GROUP,h.registered_net_tons_Invalid>0);
    registered_length_ALLOW_ErrorCount := COUNT(GROUP,h.registered_length_Invalid=1);
    registered_length_LENGTH_ErrorCount := COUNT(GROUP,h.registered_length_Invalid=2);
    registered_length_Total_ErrorCount := COUNT(GROUP,h.registered_length_Invalid>0);
    registered_breadth_ALLOW_ErrorCount := COUNT(GROUP,h.registered_breadth_Invalid=1);
    registered_breadth_LENGTH_ErrorCount := COUNT(GROUP,h.registered_breadth_Invalid=2);
    registered_breadth_Total_ErrorCount := COUNT(GROUP,h.registered_breadth_Invalid>0);
    registered_depth_ALLOW_ErrorCount := COUNT(GROUP,h.registered_depth_Invalid=1);
    registered_depth_LENGTH_ErrorCount := COUNT(GROUP,h.registered_depth_Invalid=2);
    registered_depth_Total_ErrorCount := COUNT(GROUP,h.registered_depth_Invalid>0);
    itc_gross_tons_ALLOW_ErrorCount := COUNT(GROUP,h.itc_gross_tons_Invalid=1);
    itc_gross_tons_LENGTH_ErrorCount := COUNT(GROUP,h.itc_gross_tons_Invalid=2);
    itc_gross_tons_Total_ErrorCount := COUNT(GROUP,h.itc_gross_tons_Invalid>0);
    itc_net_tons_ALLOW_ErrorCount := COUNT(GROUP,h.itc_net_tons_Invalid=1);
    itc_net_tons_LENGTH_ErrorCount := COUNT(GROUP,h.itc_net_tons_Invalid=2);
    itc_net_tons_Total_ErrorCount := COUNT(GROUP,h.itc_net_tons_Invalid>0);
    itc_length_ALLOW_ErrorCount := COUNT(GROUP,h.itc_length_Invalid=1);
    itc_length_LENGTH_ErrorCount := COUNT(GROUP,h.itc_length_Invalid=2);
    itc_length_Total_ErrorCount := COUNT(GROUP,h.itc_length_Invalid>0);
    itc_breadth_ALLOW_ErrorCount := COUNT(GROUP,h.itc_breadth_Invalid=1);
    itc_breadth_LENGTH_ErrorCount := COUNT(GROUP,h.itc_breadth_Invalid=2);
    itc_breadth_Total_ErrorCount := COUNT(GROUP,h.itc_breadth_Invalid>0);
    itc_depth_ALLOW_ErrorCount := COUNT(GROUP,h.itc_depth_Invalid=1);
    itc_depth_LENGTH_ErrorCount := COUNT(GROUP,h.itc_depth_Invalid=2);
    itc_depth_Total_ErrorCount := COUNT(GROUP,h.itc_depth_Invalid>0);
    date_issued_ALLOW_ErrorCount := COUNT(GROUP,h.date_issued_Invalid=1);
    date_issued_LENGTH_ErrorCount := COUNT(GROUP,h.date_issued_Invalid=2);
    date_issued_Total_ErrorCount := COUNT(GROUP,h.date_issued_Invalid>0);
    date_expires_ALLOW_ErrorCount := COUNT(GROUP,h.date_expires_Invalid=1);
    date_expires_LENGTH_ErrorCount := COUNT(GROUP,h.date_expires_Invalid=2);
    date_expires_Total_ErrorCount := COUNT(GROUP,h.date_expires_Invalid>0);
    persistent_record_id_LENGTH_ErrorCount := COUNT(GROUP,h.persistent_record_id_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,source_code,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.source_code;
    UNSIGNED1 ErrNum := CHOOSE(c,le.watercraft_key_Invalid,le.state_origin_Invalid,le.source_code_Invalid,le.hull_number_Invalid,le.hull_identification_number_Invalid,le.registered_gross_tons_Invalid,le.registered_net_tons_Invalid,le.registered_length_Invalid,le.registered_breadth_Invalid,le.registered_depth_Invalid,le.itc_gross_tons_Invalid,le.itc_net_tons_Invalid,le.itc_length_Invalid,le.itc_breadth_Invalid,le.itc_depth_Invalid,le.date_issued_Invalid,le.date_expires_Invalid,le.persistent_record_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_watercraft_key(le.watercraft_key_Invalid),Fields.InvalidMessage_state_origin(le.state_origin_Invalid),Fields.InvalidMessage_source_code(le.source_code_Invalid),Fields.InvalidMessage_hull_number(le.hull_number_Invalid),Fields.InvalidMessage_hull_identification_number(le.hull_identification_number_Invalid),Fields.InvalidMessage_registered_gross_tons(le.registered_gross_tons_Invalid),Fields.InvalidMessage_registered_net_tons(le.registered_net_tons_Invalid),Fields.InvalidMessage_registered_length(le.registered_length_Invalid),Fields.InvalidMessage_registered_breadth(le.registered_breadth_Invalid),Fields.InvalidMessage_registered_depth(le.registered_depth_Invalid),Fields.InvalidMessage_itc_gross_tons(le.itc_gross_tons_Invalid),Fields.InvalidMessage_itc_net_tons(le.itc_net_tons_Invalid),Fields.InvalidMessage_itc_length(le.itc_length_Invalid),Fields.InvalidMessage_itc_breadth(le.itc_breadth_Invalid),Fields.InvalidMessage_itc_depth(le.itc_depth_Invalid),Fields.InvalidMessage_date_issued(le.date_issued_Invalid),Fields.InvalidMessage_date_expires(le.date_expires_Invalid),Fields.InvalidMessage_persistent_record_id(le.persistent_record_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.watercraft_key_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.state_origin_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.source_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.hull_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.hull_identification_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.registered_gross_tons_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.registered_net_tons_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.registered_length_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.registered_breadth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.registered_depth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.itc_gross_tons_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.itc_net_tons_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.itc_length_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.itc_breadth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.itc_depth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_issued_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_expires_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.persistent_record_id_Invalid,'LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'watercraft_key','state_origin','source_code','hull_number','hull_identification_number','registered_gross_tons','registered_net_tons','registered_length','registered_breadth','registered_depth','itc_gross_tons','itc_net_tons','itc_length','itc_breadth','itc_depth','date_issued','date_expires','persistent_record_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_blank','invalid_state','invalid_source_code','invalid_hullnum','invalid_hullnum','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_date','invalid_date','invalid_blank','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.watercraft_key,(SALT30.StrType)le.state_origin,(SALT30.StrType)le.source_code,(SALT30.StrType)le.hull_number,(SALT30.StrType)le.hull_identification_number,(SALT30.StrType)le.registered_gross_tons,(SALT30.StrType)le.registered_net_tons,(SALT30.StrType)le.registered_length,(SALT30.StrType)le.registered_breadth,(SALT30.StrType)le.registered_depth,(SALT30.StrType)le.itc_gross_tons,(SALT30.StrType)le.itc_net_tons,(SALT30.StrType)le.itc_length,(SALT30.StrType)le.itc_breadth,(SALT30.StrType)le.itc_depth,(SALT30.StrType)le.date_issued,(SALT30.StrType)le.date_expires,(SALT30.StrType)le.persistent_record_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,18,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source_code;
      SELF.ruledesc := CHOOSE(c
          ,'watercraft_key:invalid_blank:LENGTH'
          ,'state_origin:invalid_state:ALLOW','state_origin:invalid_state:LENGTH'
          ,'source_code:invalid_source_code:ALLOW','source_code:invalid_source_code:LENGTH'
          ,'hull_number:invalid_hullnum:ALLOW','hull_number:invalid_hullnum:LENGTH'
          ,'hull_identification_number:invalid_hullnum:ALLOW','hull_identification_number:invalid_hullnum:LENGTH'
          ,'registered_gross_tons:invalid_numeric:ALLOW','registered_gross_tons:invalid_numeric:LENGTH'
          ,'registered_net_tons:invalid_numeric:ALLOW','registered_net_tons:invalid_numeric:LENGTH'
          ,'registered_length:invalid_numeric:ALLOW','registered_length:invalid_numeric:LENGTH'
          ,'registered_breadth:invalid_numeric:ALLOW','registered_breadth:invalid_numeric:LENGTH'
          ,'registered_depth:invalid_numeric:ALLOW','registered_depth:invalid_numeric:LENGTH'
          ,'itc_gross_tons:invalid_numeric:ALLOW','itc_gross_tons:invalid_numeric:LENGTH'
          ,'itc_net_tons:invalid_numeric:ALLOW','itc_net_tons:invalid_numeric:LENGTH'
          ,'itc_length:invalid_numeric:ALLOW','itc_length:invalid_numeric:LENGTH'
          ,'itc_breadth:invalid_numeric:ALLOW','itc_breadth:invalid_numeric:LENGTH'
          ,'itc_depth:invalid_numeric:ALLOW','itc_depth:invalid_numeric:LENGTH'
          ,'date_issued:invalid_date:ALLOW','date_issued:invalid_date:LENGTH'
          ,'date_expires:invalid_date:ALLOW','date_expires:invalid_date:LENGTH'
          ,'persistent_record_id:invalid_blank:LENGTH','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.watercraft_key_LENGTH_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount,le.state_origin_LENGTH_ErrorCount
          ,le.source_code_ALLOW_ErrorCount,le.source_code_LENGTH_ErrorCount
          ,le.hull_number_ALLOW_ErrorCount,le.hull_number_LENGTH_ErrorCount
          ,le.hull_identification_number_ALLOW_ErrorCount,le.hull_identification_number_LENGTH_ErrorCount
          ,le.registered_gross_tons_ALLOW_ErrorCount,le.registered_gross_tons_LENGTH_ErrorCount
          ,le.registered_net_tons_ALLOW_ErrorCount,le.registered_net_tons_LENGTH_ErrorCount
          ,le.registered_length_ALLOW_ErrorCount,le.registered_length_LENGTH_ErrorCount
          ,le.registered_breadth_ALLOW_ErrorCount,le.registered_breadth_LENGTH_ErrorCount
          ,le.registered_depth_ALLOW_ErrorCount,le.registered_depth_LENGTH_ErrorCount
          ,le.itc_gross_tons_ALLOW_ErrorCount,le.itc_gross_tons_LENGTH_ErrorCount
          ,le.itc_net_tons_ALLOW_ErrorCount,le.itc_net_tons_LENGTH_ErrorCount
          ,le.itc_length_ALLOW_ErrorCount,le.itc_length_LENGTH_ErrorCount
          ,le.itc_breadth_ALLOW_ErrorCount,le.itc_breadth_LENGTH_ErrorCount
          ,le.itc_depth_ALLOW_ErrorCount,le.itc_depth_LENGTH_ErrorCount
          ,le.date_issued_ALLOW_ErrorCount,le.date_issued_LENGTH_ErrorCount
          ,le.date_expires_ALLOW_ErrorCount,le.date_expires_LENGTH_ErrorCount
          ,le.persistent_record_id_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.watercraft_key_LENGTH_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount,le.state_origin_LENGTH_ErrorCount
          ,le.source_code_ALLOW_ErrorCount,le.source_code_LENGTH_ErrorCount
          ,le.hull_number_ALLOW_ErrorCount,le.hull_number_LENGTH_ErrorCount
          ,le.hull_identification_number_ALLOW_ErrorCount,le.hull_identification_number_LENGTH_ErrorCount
          ,le.registered_gross_tons_ALLOW_ErrorCount,le.registered_gross_tons_LENGTH_ErrorCount
          ,le.registered_net_tons_ALLOW_ErrorCount,le.registered_net_tons_LENGTH_ErrorCount
          ,le.registered_length_ALLOW_ErrorCount,le.registered_length_LENGTH_ErrorCount
          ,le.registered_breadth_ALLOW_ErrorCount,le.registered_breadth_LENGTH_ErrorCount
          ,le.registered_depth_ALLOW_ErrorCount,le.registered_depth_LENGTH_ErrorCount
          ,le.itc_gross_tons_ALLOW_ErrorCount,le.itc_gross_tons_LENGTH_ErrorCount
          ,le.itc_net_tons_ALLOW_ErrorCount,le.itc_net_tons_LENGTH_ErrorCount
          ,le.itc_length_ALLOW_ErrorCount,le.itc_length_LENGTH_ErrorCount
          ,le.itc_breadth_ALLOW_ErrorCount,le.itc_breadth_LENGTH_ErrorCount
          ,le.itc_depth_ALLOW_ErrorCount,le.itc_depth_LENGTH_ErrorCount
          ,le.date_issued_ALLOW_ErrorCount,le.date_issued_LENGTH_ErrorCount
          ,le.date_expires_ALLOW_ErrorCount,le.date_expires_LENGTH_ErrorCount
          ,le.persistent_record_id_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,34,Into(LEFT,COUNTER));
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

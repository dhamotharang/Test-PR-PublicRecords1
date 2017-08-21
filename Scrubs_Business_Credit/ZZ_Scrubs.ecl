IMPORT ut,SALT33;
EXPORT ZZ_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(ZZ_Layout_Business_Credit)
    UNSIGNED1 segment_identifier_Invalid;
    UNSIGNED1 file_sequence_number_Invalid;
    UNSIGNED1 parent_sequence_number_Invalid;
    UNSIGNED1 total_ab_segments_Invalid;
    UNSIGNED1 total_ma_segments_Invalid;
    UNSIGNED1 total_ad_segments_Invalid;
    UNSIGNED1 total_pn_segments_Invalid;
    UNSIGNED1 total_ti_segments_Invalid;
    UNSIGNED1 total_is_segments_Invalid;
    UNSIGNED1 total_bs_segments_Invalid;
    UNSIGNED1 total_bi_segments_Invalid;
    UNSIGNED1 total_cl_segments_Invalid;
    UNSIGNED1 total_ms_segments_Invalid;
    UNSIGNED1 total_ah_segments_Invalid;
    UNSIGNED1 sum_of_balance_amounts_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(ZZ_Layout_Business_Credit)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(ZZ_Layout_Business_Credit) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.segment_identifier_Invalid := ZZ_Fields.InValid_segment_identifier((SALT33.StrType)le.segment_identifier);
    SELF.file_sequence_number_Invalid := ZZ_Fields.InValid_file_sequence_number((SALT33.StrType)le.file_sequence_number);
    SELF.parent_sequence_number_Invalid := ZZ_Fields.InValid_parent_sequence_number((SALT33.StrType)le.parent_sequence_number);
    SELF.total_ab_segments_Invalid := ZZ_Fields.InValid_total_ab_segments((SALT33.StrType)le.total_ab_segments);
    SELF.total_ma_segments_Invalid := ZZ_Fields.InValid_total_ma_segments((SALT33.StrType)le.total_ma_segments);
    SELF.total_ad_segments_Invalid := ZZ_Fields.InValid_total_ad_segments((SALT33.StrType)le.total_ad_segments);
    SELF.total_pn_segments_Invalid := ZZ_Fields.InValid_total_pn_segments((SALT33.StrType)le.total_pn_segments);
    SELF.total_ti_segments_Invalid := ZZ_Fields.InValid_total_ti_segments((SALT33.StrType)le.total_ti_segments);
    SELF.total_is_segments_Invalid := ZZ_Fields.InValid_total_is_segments((SALT33.StrType)le.total_is_segments);
    SELF.total_bs_segments_Invalid := ZZ_Fields.InValid_total_bs_segments((SALT33.StrType)le.total_bs_segments);
    SELF.total_bi_segments_Invalid := ZZ_Fields.InValid_total_bi_segments((SALT33.StrType)le.total_bi_segments);
    SELF.total_cl_segments_Invalid := ZZ_Fields.InValid_total_cl_segments((SALT33.StrType)le.total_cl_segments);
    SELF.total_ms_segments_Invalid := ZZ_Fields.InValid_total_ms_segments((SALT33.StrType)le.total_ms_segments);
    SELF.total_ah_segments_Invalid := ZZ_Fields.InValid_total_ah_segments((SALT33.StrType)le.total_ah_segments);
    SELF.sum_of_balance_amounts_Invalid := ZZ_Fields.InValid_sum_of_balance_amounts((SALT33.StrType)le.sum_of_balance_amounts);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),ZZ_Layout_Business_Credit);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.segment_identifier_Invalid << 0 ) + ( le.file_sequence_number_Invalid << 1 ) + ( le.parent_sequence_number_Invalid << 3 ) + ( le.total_ab_segments_Invalid << 5 ) + ( le.total_ma_segments_Invalid << 7 ) + ( le.total_ad_segments_Invalid << 8 ) + ( le.total_pn_segments_Invalid << 9 ) + ( le.total_ti_segments_Invalid << 10 ) + ( le.total_is_segments_Invalid << 11 ) + ( le.total_bs_segments_Invalid << 12 ) + ( le.total_bi_segments_Invalid << 13 ) + ( le.total_cl_segments_Invalid << 14 ) + ( le.total_ms_segments_Invalid << 15 ) + ( le.total_ah_segments_Invalid << 16 ) + ( le.sum_of_balance_amounts_Invalid << 17 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,ZZ_Layout_Business_Credit);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.file_sequence_number_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.parent_sequence_number_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.total_ab_segments_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.total_ma_segments_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.total_ad_segments_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.total_pn_segments_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.total_ti_segments_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.total_is_segments_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.total_bs_segments_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.total_bi_segments_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.total_cl_segments_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.total_ms_segments_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.total_ah_segments_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.sum_of_balance_amounts_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    segment_identifier_ENUM_ErrorCount := COUNT(GROUP,h.segment_identifier_Invalid=1);
    file_sequence_number_ALLOW_ErrorCount := COUNT(GROUP,h.file_sequence_number_Invalid=1);
    file_sequence_number_LENGTH_ErrorCount := COUNT(GROUP,h.file_sequence_number_Invalid=2);
    file_sequence_number_Total_ErrorCount := COUNT(GROUP,h.file_sequence_number_Invalid>0);
    parent_sequence_number_ALLOW_ErrorCount := COUNT(GROUP,h.parent_sequence_number_Invalid=1);
    parent_sequence_number_LENGTH_ErrorCount := COUNT(GROUP,h.parent_sequence_number_Invalid=2);
    parent_sequence_number_Total_ErrorCount := COUNT(GROUP,h.parent_sequence_number_Invalid>0);
    total_ab_segments_ALLOW_ErrorCount := COUNT(GROUP,h.total_ab_segments_Invalid=1);
    total_ab_segments_LENGTH_ErrorCount := COUNT(GROUP,h.total_ab_segments_Invalid=2);
    total_ab_segments_Total_ErrorCount := COUNT(GROUP,h.total_ab_segments_Invalid>0);
    total_ma_segments_ALLOW_ErrorCount := COUNT(GROUP,h.total_ma_segments_Invalid=1);
    total_ad_segments_ALLOW_ErrorCount := COUNT(GROUP,h.total_ad_segments_Invalid=1);
    total_pn_segments_ALLOW_ErrorCount := COUNT(GROUP,h.total_pn_segments_Invalid=1);
    total_ti_segments_ALLOW_ErrorCount := COUNT(GROUP,h.total_ti_segments_Invalid=1);
    total_is_segments_ALLOW_ErrorCount := COUNT(GROUP,h.total_is_segments_Invalid=1);
    total_bs_segments_ALLOW_ErrorCount := COUNT(GROUP,h.total_bs_segments_Invalid=1);
    total_bi_segments_ALLOW_ErrorCount := COUNT(GROUP,h.total_bi_segments_Invalid=1);
    total_cl_segments_ALLOW_ErrorCount := COUNT(GROUP,h.total_cl_segments_Invalid=1);
    total_ms_segments_ALLOW_ErrorCount := COUNT(GROUP,h.total_ms_segments_Invalid=1);
    total_ah_segments_ALLOW_ErrorCount := COUNT(GROUP,h.total_ah_segments_Invalid=1);
    sum_of_balance_amounts_ALLOW_ErrorCount := COUNT(GROUP,h.sum_of_balance_amounts_Invalid=1);
    sum_of_balance_amounts_LENGTH_ErrorCount := COUNT(GROUP,h.sum_of_balance_amounts_Invalid=2);
    sum_of_balance_amounts_Total_ErrorCount := COUNT(GROUP,h.sum_of_balance_amounts_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.segment_identifier_Invalid,le.file_sequence_number_Invalid,le.parent_sequence_number_Invalid,le.total_ab_segments_Invalid,le.total_ma_segments_Invalid,le.total_ad_segments_Invalid,le.total_pn_segments_Invalid,le.total_ti_segments_Invalid,le.total_is_segments_Invalid,le.total_bs_segments_Invalid,le.total_bi_segments_Invalid,le.total_cl_segments_Invalid,le.total_ms_segments_Invalid,le.total_ah_segments_Invalid,le.sum_of_balance_amounts_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,ZZ_Fields.InvalidMessage_segment_identifier(le.segment_identifier_Invalid),ZZ_Fields.InvalidMessage_file_sequence_number(le.file_sequence_number_Invalid),ZZ_Fields.InvalidMessage_parent_sequence_number(le.parent_sequence_number_Invalid),ZZ_Fields.InvalidMessage_total_ab_segments(le.total_ab_segments_Invalid),ZZ_Fields.InvalidMessage_total_ma_segments(le.total_ma_segments_Invalid),ZZ_Fields.InvalidMessage_total_ad_segments(le.total_ad_segments_Invalid),ZZ_Fields.InvalidMessage_total_pn_segments(le.total_pn_segments_Invalid),ZZ_Fields.InvalidMessage_total_ti_segments(le.total_ti_segments_Invalid),ZZ_Fields.InvalidMessage_total_is_segments(le.total_is_segments_Invalid),ZZ_Fields.InvalidMessage_total_bs_segments(le.total_bs_segments_Invalid),ZZ_Fields.InvalidMessage_total_bi_segments(le.total_bi_segments_Invalid),ZZ_Fields.InvalidMessage_total_cl_segments(le.total_cl_segments_Invalid),ZZ_Fields.InvalidMessage_total_ms_segments(le.total_ms_segments_Invalid),ZZ_Fields.InvalidMessage_total_ah_segments(le.total_ah_segments_Invalid),ZZ_Fields.InvalidMessage_sum_of_balance_amounts(le.sum_of_balance_amounts_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.segment_identifier_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.file_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.parent_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_ab_segments_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_ma_segments_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.total_ad_segments_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.total_pn_segments_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.total_ti_segments_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.total_is_segments_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.total_bs_segments_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.total_bi_segments_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.total_cl_segments_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.total_ms_segments_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.total_ah_segments_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sum_of_balance_amounts_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'segment_identifier','file_sequence_number','parent_sequence_number','total_ab_segments','total_ma_segments','total_ad_segments','total_pn_segments','total_ti_segments','total_is_segments','total_bs_segments','total_bi_segments','total_cl_segments','total_ms_segments','total_ah_segments','sum_of_balance_amounts','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_segment_identifier','invalid_zz_file_sequence_number','invalid_parent_sequence_number','invalid_total_ab_segments','invalid_total_segments','invalid_total_segments','invalid_total_segments','invalid_total_segments','invalid_total_segments','invalid_total_segments','invalid_total_segments','invalid_total_segments','invalid_total_segments','invalid_total_segments','invalid_sum_of_balance_amounts','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.segment_identifier,(SALT33.StrType)le.file_sequence_number,(SALT33.StrType)le.parent_sequence_number,(SALT33.StrType)le.total_ab_segments,(SALT33.StrType)le.total_ma_segments,(SALT33.StrType)le.total_ad_segments,(SALT33.StrType)le.total_pn_segments,(SALT33.StrType)le.total_ti_segments,(SALT33.StrType)le.total_is_segments,(SALT33.StrType)le.total_bs_segments,(SALT33.StrType)le.total_bi_segments,(SALT33.StrType)le.total_cl_segments,(SALT33.StrType)le.total_ms_segments,(SALT33.StrType)le.total_ah_segments,(SALT33.StrType)le.sum_of_balance_amounts,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,15,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'segment_identifier:invalid_segment_identifier:ENUM'
          ,'file_sequence_number:invalid_zz_file_sequence_number:ALLOW','file_sequence_number:invalid_zz_file_sequence_number:LENGTH'
          ,'parent_sequence_number:invalid_parent_sequence_number:ALLOW','parent_sequence_number:invalid_parent_sequence_number:LENGTH'
          ,'total_ab_segments:invalid_total_ab_segments:ALLOW','total_ab_segments:invalid_total_ab_segments:LENGTH'
          ,'total_ma_segments:invalid_total_segments:ALLOW'
          ,'total_ad_segments:invalid_total_segments:ALLOW'
          ,'total_pn_segments:invalid_total_segments:ALLOW'
          ,'total_ti_segments:invalid_total_segments:ALLOW'
          ,'total_is_segments:invalid_total_segments:ALLOW'
          ,'total_bs_segments:invalid_total_segments:ALLOW'
          ,'total_bi_segments:invalid_total_segments:ALLOW'
          ,'total_cl_segments:invalid_total_segments:ALLOW'
          ,'total_ms_segments:invalid_total_segments:ALLOW'
          ,'total_ah_segments:invalid_total_segments:ALLOW'
          ,'sum_of_balance_amounts:invalid_sum_of_balance_amounts:ALLOW','sum_of_balance_amounts:invalid_sum_of_balance_amounts:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,ZZ_Fields.InvalidMessage_segment_identifier(1)
          ,ZZ_Fields.InvalidMessage_file_sequence_number(1),ZZ_Fields.InvalidMessage_file_sequence_number(2)
          ,ZZ_Fields.InvalidMessage_parent_sequence_number(1),ZZ_Fields.InvalidMessage_parent_sequence_number(2)
          ,ZZ_Fields.InvalidMessage_total_ab_segments(1),ZZ_Fields.InvalidMessage_total_ab_segments(2)
          ,ZZ_Fields.InvalidMessage_total_ma_segments(1)
          ,ZZ_Fields.InvalidMessage_total_ad_segments(1)
          ,ZZ_Fields.InvalidMessage_total_pn_segments(1)
          ,ZZ_Fields.InvalidMessage_total_ti_segments(1)
          ,ZZ_Fields.InvalidMessage_total_is_segments(1)
          ,ZZ_Fields.InvalidMessage_total_bs_segments(1)
          ,ZZ_Fields.InvalidMessage_total_bi_segments(1)
          ,ZZ_Fields.InvalidMessage_total_cl_segments(1)
          ,ZZ_Fields.InvalidMessage_total_ms_segments(1)
          ,ZZ_Fields.InvalidMessage_total_ah_segments(1)
          ,ZZ_Fields.InvalidMessage_sum_of_balance_amounts(1),ZZ_Fields.InvalidMessage_sum_of_balance_amounts(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.total_ab_segments_ALLOW_ErrorCount,le.total_ab_segments_LENGTH_ErrorCount
          ,le.total_ma_segments_ALLOW_ErrorCount
          ,le.total_ad_segments_ALLOW_ErrorCount
          ,le.total_pn_segments_ALLOW_ErrorCount
          ,le.total_ti_segments_ALLOW_ErrorCount
          ,le.total_is_segments_ALLOW_ErrorCount
          ,le.total_bs_segments_ALLOW_ErrorCount
          ,le.total_bi_segments_ALLOW_ErrorCount
          ,le.total_cl_segments_ALLOW_ErrorCount
          ,le.total_ms_segments_ALLOW_ErrorCount
          ,le.total_ah_segments_ALLOW_ErrorCount
          ,le.sum_of_balance_amounts_ALLOW_ErrorCount,le.sum_of_balance_amounts_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.total_ab_segments_ALLOW_ErrorCount,le.total_ab_segments_LENGTH_ErrorCount
          ,le.total_ma_segments_ALLOW_ErrorCount
          ,le.total_ad_segments_ALLOW_ErrorCount
          ,le.total_pn_segments_ALLOW_ErrorCount
          ,le.total_ti_segments_ALLOW_ErrorCount
          ,le.total_is_segments_ALLOW_ErrorCount
          ,le.total_bs_segments_ALLOW_ErrorCount
          ,le.total_bi_segments_ALLOW_ErrorCount
          ,le.total_cl_segments_ALLOW_ErrorCount
          ,le.total_ms_segments_ALLOW_ErrorCount
          ,le.total_ah_segments_ALLOW_ErrorCount
          ,le.sum_of_balance_amounts_ALLOW_ErrorCount,le.sum_of_balance_amounts_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,19,Into(LEFT,COUNTER));
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

IMPORT ut,SALT33;
EXPORT ZZ_hygiene(dataset(ZZ_layout_Business_Credit) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_segment_identifier_pcnt := AVE(GROUP,IF(h.segment_identifier = (TYPEOF(h.segment_identifier))'',0,100));
    maxlength_segment_identifier := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.segment_identifier)));
    avelength_segment_identifier := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.segment_identifier)),h.segment_identifier<>(typeof(h.segment_identifier))'');
    populated_file_sequence_number_pcnt := AVE(GROUP,IF(h.file_sequence_number = (TYPEOF(h.file_sequence_number))'',0,100));
    maxlength_file_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.file_sequence_number)));
    avelength_file_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.file_sequence_number)),h.file_sequence_number<>(typeof(h.file_sequence_number))'');
    populated_parent_sequence_number_pcnt := AVE(GROUP,IF(h.parent_sequence_number = (TYPEOF(h.parent_sequence_number))'',0,100));
    maxlength_parent_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.parent_sequence_number)));
    avelength_parent_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.parent_sequence_number)),h.parent_sequence_number<>(typeof(h.parent_sequence_number))'');
    populated_total_ab_segments_pcnt := AVE(GROUP,IF(h.total_ab_segments = (TYPEOF(h.total_ab_segments))'',0,100));
    maxlength_total_ab_segments := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_ab_segments)));
    avelength_total_ab_segments := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_ab_segments)),h.total_ab_segments<>(typeof(h.total_ab_segments))'');
    populated_total_ma_segments_pcnt := AVE(GROUP,IF(h.total_ma_segments = (TYPEOF(h.total_ma_segments))'',0,100));
    maxlength_total_ma_segments := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_ma_segments)));
    avelength_total_ma_segments := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_ma_segments)),h.total_ma_segments<>(typeof(h.total_ma_segments))'');
    populated_total_ad_segments_pcnt := AVE(GROUP,IF(h.total_ad_segments = (TYPEOF(h.total_ad_segments))'',0,100));
    maxlength_total_ad_segments := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_ad_segments)));
    avelength_total_ad_segments := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_ad_segments)),h.total_ad_segments<>(typeof(h.total_ad_segments))'');
    populated_total_pn_segments_pcnt := AVE(GROUP,IF(h.total_pn_segments = (TYPEOF(h.total_pn_segments))'',0,100));
    maxlength_total_pn_segments := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_pn_segments)));
    avelength_total_pn_segments := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_pn_segments)),h.total_pn_segments<>(typeof(h.total_pn_segments))'');
    populated_total_ti_segments_pcnt := AVE(GROUP,IF(h.total_ti_segments = (TYPEOF(h.total_ti_segments))'',0,100));
    maxlength_total_ti_segments := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_ti_segments)));
    avelength_total_ti_segments := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_ti_segments)),h.total_ti_segments<>(typeof(h.total_ti_segments))'');
    populated_total_is_segments_pcnt := AVE(GROUP,IF(h.total_is_segments = (TYPEOF(h.total_is_segments))'',0,100));
    maxlength_total_is_segments := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_is_segments)));
    avelength_total_is_segments := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_is_segments)),h.total_is_segments<>(typeof(h.total_is_segments))'');
    populated_total_bs_segments_pcnt := AVE(GROUP,IF(h.total_bs_segments = (TYPEOF(h.total_bs_segments))'',0,100));
    maxlength_total_bs_segments := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_bs_segments)));
    avelength_total_bs_segments := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_bs_segments)),h.total_bs_segments<>(typeof(h.total_bs_segments))'');
    populated_total_bi_segments_pcnt := AVE(GROUP,IF(h.total_bi_segments = (TYPEOF(h.total_bi_segments))'',0,100));
    maxlength_total_bi_segments := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_bi_segments)));
    avelength_total_bi_segments := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_bi_segments)),h.total_bi_segments<>(typeof(h.total_bi_segments))'');
    populated_total_cl_segments_pcnt := AVE(GROUP,IF(h.total_cl_segments = (TYPEOF(h.total_cl_segments))'',0,100));
    maxlength_total_cl_segments := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_cl_segments)));
    avelength_total_cl_segments := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_cl_segments)),h.total_cl_segments<>(typeof(h.total_cl_segments))'');
    populated_total_ms_segments_pcnt := AVE(GROUP,IF(h.total_ms_segments = (TYPEOF(h.total_ms_segments))'',0,100));
    maxlength_total_ms_segments := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_ms_segments)));
    avelength_total_ms_segments := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_ms_segments)),h.total_ms_segments<>(typeof(h.total_ms_segments))'');
    populated_total_ah_segments_pcnt := AVE(GROUP,IF(h.total_ah_segments = (TYPEOF(h.total_ah_segments))'',0,100));
    maxlength_total_ah_segments := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_ah_segments)));
    avelength_total_ah_segments := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_ah_segments)),h.total_ah_segments<>(typeof(h.total_ah_segments))'');
    populated_sum_of_balance_amounts_pcnt := AVE(GROUP,IF(h.sum_of_balance_amounts = (TYPEOF(h.sum_of_balance_amounts))'',0,100));
    maxlength_sum_of_balance_amounts := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sum_of_balance_amounts)));
    avelength_sum_of_balance_amounts := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sum_of_balance_amounts)),h.sum_of_balance_amounts<>(typeof(h.sum_of_balance_amounts))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_segment_identifier_pcnt *   0.00 / 100 + T.Populated_file_sequence_number_pcnt *   0.00 / 100 + T.Populated_parent_sequence_number_pcnt *   0.00 / 100 + T.Populated_total_ab_segments_pcnt *   0.00 / 100 + T.Populated_total_ma_segments_pcnt *   0.00 / 100 + T.Populated_total_ad_segments_pcnt *   0.00 / 100 + T.Populated_total_pn_segments_pcnt *   0.00 / 100 + T.Populated_total_ti_segments_pcnt *   0.00 / 100 + T.Populated_total_is_segments_pcnt *   0.00 / 100 + T.Populated_total_bs_segments_pcnt *   0.00 / 100 + T.Populated_total_bi_segments_pcnt *   0.00 / 100 + T.Populated_total_cl_segments_pcnt *   0.00 / 100 + T.Populated_total_ms_segments_pcnt *   0.00 / 100 + T.Populated_total_ah_segments_pcnt *   0.00 / 100 + T.Populated_sum_of_balance_amounts_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT33.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'segment_identifier','file_sequence_number','parent_sequence_number','total_ab_segments','total_ma_segments','total_ad_segments','total_pn_segments','total_ti_segments','total_is_segments','total_bs_segments','total_bi_segments','total_cl_segments','total_ms_segments','total_ah_segments','sum_of_balance_amounts');
  SELF.populated_pcnt := CHOOSE(C,le.populated_segment_identifier_pcnt,le.populated_file_sequence_number_pcnt,le.populated_parent_sequence_number_pcnt,le.populated_total_ab_segments_pcnt,le.populated_total_ma_segments_pcnt,le.populated_total_ad_segments_pcnt,le.populated_total_pn_segments_pcnt,le.populated_total_ti_segments_pcnt,le.populated_total_is_segments_pcnt,le.populated_total_bs_segments_pcnt,le.populated_total_bi_segments_pcnt,le.populated_total_cl_segments_pcnt,le.populated_total_ms_segments_pcnt,le.populated_total_ah_segments_pcnt,le.populated_sum_of_balance_amounts_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_segment_identifier,le.maxlength_file_sequence_number,le.maxlength_parent_sequence_number,le.maxlength_total_ab_segments,le.maxlength_total_ma_segments,le.maxlength_total_ad_segments,le.maxlength_total_pn_segments,le.maxlength_total_ti_segments,le.maxlength_total_is_segments,le.maxlength_total_bs_segments,le.maxlength_total_bi_segments,le.maxlength_total_cl_segments,le.maxlength_total_ms_segments,le.maxlength_total_ah_segments,le.maxlength_sum_of_balance_amounts);
  SELF.avelength := CHOOSE(C,le.avelength_segment_identifier,le.avelength_file_sequence_number,le.avelength_parent_sequence_number,le.avelength_total_ab_segments,le.avelength_total_ma_segments,le.avelength_total_ad_segments,le.avelength_total_pn_segments,le.avelength_total_ti_segments,le.avelength_total_is_segments,le.avelength_total_bs_segments,le.avelength_total_bi_segments,le.avelength_total_cl_segments,le.avelength_total_ms_segments,le.avelength_total_ah_segments,le.avelength_sum_of_balance_amounts);
END;
EXPORT invSummary := NORMALIZE(summary0, 15, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.segment_identifier),TRIM((SALT33.StrType)le.file_sequence_number),TRIM((SALT33.StrType)le.parent_sequence_number),TRIM((SALT33.StrType)le.total_ab_segments),TRIM((SALT33.StrType)le.total_ma_segments),TRIM((SALT33.StrType)le.total_ad_segments),TRIM((SALT33.StrType)le.total_pn_segments),TRIM((SALT33.StrType)le.total_ti_segments),TRIM((SALT33.StrType)le.total_is_segments),TRIM((SALT33.StrType)le.total_bs_segments),TRIM((SALT33.StrType)le.total_bi_segments),TRIM((SALT33.StrType)le.total_cl_segments),TRIM((SALT33.StrType)le.total_ms_segments),TRIM((SALT33.StrType)le.total_ah_segments),TRIM((SALT33.StrType)le.sum_of_balance_amounts)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,15,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 15);
  SELF.FldNo2 := 1 + (C % 15);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.segment_identifier),TRIM((SALT33.StrType)le.file_sequence_number),TRIM((SALT33.StrType)le.parent_sequence_number),TRIM((SALT33.StrType)le.total_ab_segments),TRIM((SALT33.StrType)le.total_ma_segments),TRIM((SALT33.StrType)le.total_ad_segments),TRIM((SALT33.StrType)le.total_pn_segments),TRIM((SALT33.StrType)le.total_ti_segments),TRIM((SALT33.StrType)le.total_is_segments),TRIM((SALT33.StrType)le.total_bs_segments),TRIM((SALT33.StrType)le.total_bi_segments),TRIM((SALT33.StrType)le.total_cl_segments),TRIM((SALT33.StrType)le.total_ms_segments),TRIM((SALT33.StrType)le.total_ah_segments),TRIM((SALT33.StrType)le.sum_of_balance_amounts)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.segment_identifier),TRIM((SALT33.StrType)le.file_sequence_number),TRIM((SALT33.StrType)le.parent_sequence_number),TRIM((SALT33.StrType)le.total_ab_segments),TRIM((SALT33.StrType)le.total_ma_segments),TRIM((SALT33.StrType)le.total_ad_segments),TRIM((SALT33.StrType)le.total_pn_segments),TRIM((SALT33.StrType)le.total_ti_segments),TRIM((SALT33.StrType)le.total_is_segments),TRIM((SALT33.StrType)le.total_bs_segments),TRIM((SALT33.StrType)le.total_bi_segments),TRIM((SALT33.StrType)le.total_cl_segments),TRIM((SALT33.StrType)le.total_ms_segments),TRIM((SALT33.StrType)le.total_ah_segments),TRIM((SALT33.StrType)le.sum_of_balance_amounts)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),15*15,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'segment_identifier'}
      ,{2,'file_sequence_number'}
      ,{3,'parent_sequence_number'}
      ,{4,'total_ab_segments'}
      ,{5,'total_ma_segments'}
      ,{6,'total_ad_segments'}
      ,{7,'total_pn_segments'}
      ,{8,'total_ti_segments'}
      ,{9,'total_is_segments'}
      ,{10,'total_bs_segments'}
      ,{11,'total_bi_segments'}
      ,{12,'total_cl_segments'}
      ,{13,'total_ms_segments'}
      ,{14,'total_ah_segments'}
      ,{15,'sum_of_balance_amounts'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    ZZ_Fields.InValid_segment_identifier((SALT33.StrType)le.segment_identifier),
    ZZ_Fields.InValid_file_sequence_number((SALT33.StrType)le.file_sequence_number),
    ZZ_Fields.InValid_parent_sequence_number((SALT33.StrType)le.parent_sequence_number),
    ZZ_Fields.InValid_total_ab_segments((SALT33.StrType)le.total_ab_segments),
    ZZ_Fields.InValid_total_ma_segments((SALT33.StrType)le.total_ma_segments),
    ZZ_Fields.InValid_total_ad_segments((SALT33.StrType)le.total_ad_segments),
    ZZ_Fields.InValid_total_pn_segments((SALT33.StrType)le.total_pn_segments),
    ZZ_Fields.InValid_total_ti_segments((SALT33.StrType)le.total_ti_segments),
    ZZ_Fields.InValid_total_is_segments((SALT33.StrType)le.total_is_segments),
    ZZ_Fields.InValid_total_bs_segments((SALT33.StrType)le.total_bs_segments),
    ZZ_Fields.InValid_total_bi_segments((SALT33.StrType)le.total_bi_segments),
    ZZ_Fields.InValid_total_cl_segments((SALT33.StrType)le.total_cl_segments),
    ZZ_Fields.InValid_total_ms_segments((SALT33.StrType)le.total_ms_segments),
    ZZ_Fields.InValid_total_ah_segments((SALT33.StrType)le.total_ah_segments),
    ZZ_Fields.InValid_sum_of_balance_amounts((SALT33.StrType)le.sum_of_balance_amounts),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,15,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := ZZ_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_segment_identifier','invalid_zz_file_sequence_number','invalid_parent_sequence_number','invalid_total_ab_segments','invalid_total_segments','invalid_total_segments','invalid_total_segments','invalid_total_segments','invalid_total_segments','invalid_total_segments','invalid_total_segments','invalid_total_segments','invalid_total_segments','invalid_total_segments','invalid_sum_of_balance_amounts');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,ZZ_Fields.InValidMessage_segment_identifier(TotalErrors.ErrorNum),ZZ_Fields.InValidMessage_file_sequence_number(TotalErrors.ErrorNum),ZZ_Fields.InValidMessage_parent_sequence_number(TotalErrors.ErrorNum),ZZ_Fields.InValidMessage_total_ab_segments(TotalErrors.ErrorNum),ZZ_Fields.InValidMessage_total_ma_segments(TotalErrors.ErrorNum),ZZ_Fields.InValidMessage_total_ad_segments(TotalErrors.ErrorNum),ZZ_Fields.InValidMessage_total_pn_segments(TotalErrors.ErrorNum),ZZ_Fields.InValidMessage_total_ti_segments(TotalErrors.ErrorNum),ZZ_Fields.InValidMessage_total_is_segments(TotalErrors.ErrorNum),ZZ_Fields.InValidMessage_total_bs_segments(TotalErrors.ErrorNum),ZZ_Fields.InValidMessage_total_bi_segments(TotalErrors.ErrorNum),ZZ_Fields.InValidMessage_total_cl_segments(TotalErrors.ErrorNum),ZZ_Fields.InValidMessage_total_ms_segments(TotalErrors.ErrorNum),ZZ_Fields.InValidMessage_total_ah_segments(TotalErrors.ErrorNum),ZZ_Fields.InValidMessage_sum_of_balance_amounts(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;

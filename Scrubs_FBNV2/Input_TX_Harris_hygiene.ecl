IMPORT SALT37;
EXPORT Input_TX_Harris_hygiene(dataset(Input_TX_Harris_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_name1_pcnt := AVE(GROUP,IF(h.name1 = (TYPEOF(h.name1))'',0,100));
    maxlength_name1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name1)));
    avelength_name1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name1)),h.name1<>(typeof(h.name1))'');
    populated_name2_pcnt := AVE(GROUP,IF(h.name2 = (TYPEOF(h.name2))'',0,100));
    maxlength_name2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.name2)));
    avelength_name2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.name2)),h.name2<>(typeof(h.name2))'');
    populated_date_filed_pcnt := AVE(GROUP,IF(h.date_filed = (TYPEOF(h.date_filed))'',0,100));
    maxlength_date_filed := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.date_filed)));
    avelength_date_filed := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.date_filed)),h.date_filed<>(typeof(h.date_filed))'');
    populated_file_number_pcnt := AVE(GROUP,IF(h.file_number = (TYPEOF(h.file_number))'',0,100));
    maxlength_file_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_number)));
    avelength_file_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_number)),h.file_number<>(typeof(h.file_number))'');
    populated_prep_addr1_line1_pcnt := AVE(GROUP,IF(h.prep_addr1_line1 = (TYPEOF(h.prep_addr1_line1))'',0,100));
    maxlength_prep_addr1_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr1_line1)));
    avelength_prep_addr1_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr1_line1)),h.prep_addr1_line1<>(typeof(h.prep_addr1_line1))'');
    populated_prep_addr1_line_last_pcnt := AVE(GROUP,IF(h.prep_addr1_line_last = (TYPEOF(h.prep_addr1_line_last))'',0,100));
    maxlength_prep_addr1_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr1_line_last)));
    avelength_prep_addr1_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr1_line_last)),h.prep_addr1_line_last<>(typeof(h.prep_addr1_line_last))'');
    populated_prep_addr2_line1_pcnt := AVE(GROUP,IF(h.prep_addr2_line1 = (TYPEOF(h.prep_addr2_line1))'',0,100));
    maxlength_prep_addr2_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr2_line1)));
    avelength_prep_addr2_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr2_line1)),h.prep_addr2_line1<>(typeof(h.prep_addr2_line1))'');
    populated_prep_addr2_line_last_pcnt := AVE(GROUP,IF(h.prep_addr2_line_last = (TYPEOF(h.prep_addr2_line_last))'',0,100));
    maxlength_prep_addr2_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr2_line_last)));
    avelength_prep_addr2_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr2_line_last)),h.prep_addr2_line_last<>(typeof(h.prep_addr2_line_last))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_name1_pcnt *   0.00 / 100 + T.Populated_name2_pcnt *   0.00 / 100 + T.Populated_date_filed_pcnt *   0.00 / 100 + T.Populated_file_number_pcnt *   0.00 / 100 + T.Populated_prep_addr1_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr1_line_last_pcnt *   0.00 / 100 + T.Populated_prep_addr2_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr2_line_last_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT37.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'name1','name2','date_filed','file_number','prep_addr1_line1','prep_addr1_line_last','prep_addr2_line1','prep_addr2_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_name1_pcnt,le.populated_name2_pcnt,le.populated_date_filed_pcnt,le.populated_file_number_pcnt,le.populated_prep_addr1_line1_pcnt,le.populated_prep_addr1_line_last_pcnt,le.populated_prep_addr2_line1_pcnt,le.populated_prep_addr2_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_name1,le.maxlength_name2,le.maxlength_date_filed,le.maxlength_file_number,le.maxlength_prep_addr1_line1,le.maxlength_prep_addr1_line_last,le.maxlength_prep_addr2_line1,le.maxlength_prep_addr2_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_name1,le.avelength_name2,le.avelength_date_filed,le.avelength_file_number,le.avelength_prep_addr1_line1,le.avelength_prep_addr1_line_last,le.avelength_prep_addr2_line1,le.avelength_prep_addr2_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 8, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.name1),TRIM((SALT37.StrType)le.name2),TRIM((SALT37.StrType)le.date_filed),TRIM((SALT37.StrType)le.file_number),TRIM((SALT37.StrType)le.prep_addr1_line1),TRIM((SALT37.StrType)le.prep_addr1_line_last),TRIM((SALT37.StrType)le.prep_addr2_line1),TRIM((SALT37.StrType)le.prep_addr2_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,8,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 8);
  SELF.FldNo2 := 1 + (C % 8);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.name1),TRIM((SALT37.StrType)le.name2),TRIM((SALT37.StrType)le.date_filed),TRIM((SALT37.StrType)le.file_number),TRIM((SALT37.StrType)le.prep_addr1_line1),TRIM((SALT37.StrType)le.prep_addr1_line_last),TRIM((SALT37.StrType)le.prep_addr2_line1),TRIM((SALT37.StrType)le.prep_addr2_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.name1),TRIM((SALT37.StrType)le.name2),TRIM((SALT37.StrType)le.date_filed),TRIM((SALT37.StrType)le.file_number),TRIM((SALT37.StrType)le.prep_addr1_line1),TRIM((SALT37.StrType)le.prep_addr1_line_last),TRIM((SALT37.StrType)le.prep_addr2_line1),TRIM((SALT37.StrType)le.prep_addr2_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),8*8,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'name1'}
      ,{2,'name2'}
      ,{3,'date_filed'}
      ,{4,'file_number'}
      ,{5,'prep_addr1_line1'}
      ,{6,'prep_addr1_line_last'}
      ,{7,'prep_addr2_line1'}
      ,{8,'prep_addr2_line_last'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_TX_Harris_Fields.InValid_name1((SALT37.StrType)le.name1),
    Input_TX_Harris_Fields.InValid_name2((SALT37.StrType)le.name2),
    Input_TX_Harris_Fields.InValid_date_filed((SALT37.StrType)le.date_filed),
    Input_TX_Harris_Fields.InValid_file_number((SALT37.StrType)le.file_number),
    Input_TX_Harris_Fields.InValid_prep_addr1_line1((SALT37.StrType)le.prep_addr1_line1),
    Input_TX_Harris_Fields.InValid_prep_addr1_line_last((SALT37.StrType)le.prep_addr1_line_last),
    Input_TX_Harris_Fields.InValid_prep_addr2_line1((SALT37.StrType)le.prep_addr2_line1),
    Input_TX_Harris_Fields.InValid_prep_addr2_line_last((SALT37.StrType)le.prep_addr2_line_last),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,8,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_TX_Harris_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_general_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_TX_Harris_Fields.InValidMessage_name1(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_name2(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_date_filed(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_file_number(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_prep_addr1_line1(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_prep_addr1_line_last(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_prep_addr2_line1(TotalErrors.ErrorNum),Input_TX_Harris_Fields.InValidMessage_prep_addr2_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;

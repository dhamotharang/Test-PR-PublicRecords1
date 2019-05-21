IMPORT SALT37;
EXPORT Input_FL_Filing_hygiene(dataset(Input_FL_Filing_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_fic_fil_name_pcnt := AVE(GROUP,IF(h.fic_fil_name = (TYPEOF(h.fic_fil_name))'',0,100));
    maxlength_fic_fil_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_fil_name)));
    avelength_fic_fil_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_fil_name)),h.fic_fil_name<>(typeof(h.fic_fil_name))'');
    populated_fic_owner_name_pcnt := AVE(GROUP,IF(h.fic_owner_name = (TYPEOF(h.fic_owner_name))'',0,100));
    maxlength_fic_owner_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_owner_name)));
    avelength_fic_owner_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_owner_name)),h.fic_owner_name<>(typeof(h.fic_owner_name))'');
    populated_fic_fil_date_pcnt := AVE(GROUP,IF(h.fic_fil_date = (TYPEOF(h.fic_fil_date))'',0,100));
    maxlength_fic_fil_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_fil_date)));
    avelength_fic_fil_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_fil_date)),h.fic_fil_date<>(typeof(h.fic_fil_date))'');
    populated_fic_fil_doc_num_pcnt := AVE(GROUP,IF(h.fic_fil_doc_num = (TYPEOF(h.fic_fil_doc_num))'',0,100));
    maxlength_fic_fil_doc_num := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_fil_doc_num)));
    avelength_fic_fil_doc_num := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_fil_doc_num)),h.fic_fil_doc_num<>(typeof(h.fic_fil_doc_num))'');
    populated_fic_owner_doc_num_pcnt := AVE(GROUP,IF(h.fic_owner_doc_num = (TYPEOF(h.fic_owner_doc_num))'',0,100));
    maxlength_fic_owner_doc_num := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_owner_doc_num)));
    avelength_fic_owner_doc_num := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fic_owner_doc_num)),h.fic_owner_doc_num<>(typeof(h.fic_owner_doc_num))'');
    populated_p_owner_name_pcnt := AVE(GROUP,IF(h.p_owner_name = (TYPEOF(h.p_owner_name))'',0,100));
    maxlength_p_owner_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.p_owner_name)));
    avelength_p_owner_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.p_owner_name)),h.p_owner_name<>(typeof(h.p_owner_name))'');
    populated_c_owner_name_pcnt := AVE(GROUP,IF(h.c_owner_name = (TYPEOF(h.c_owner_name))'',0,100));
    maxlength_c_owner_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.c_owner_name)));
    avelength_c_owner_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.c_owner_name)),h.c_owner_name<>(typeof(h.c_owner_name))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_addr_line_last = (TYPEOF(h.prep_addr_line_last))'',0,100));
    maxlength_prep_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line_last)));
    avelength_prep_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line_last)),h.prep_addr_line_last<>(typeof(h.prep_addr_line_last))'');
    populated_prep_owner_addr_line1_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line1 = (TYPEOF(h.prep_owner_addr_line1))'',0,100));
    maxlength_prep_owner_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line1)));
    avelength_prep_owner_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line1)),h.prep_owner_addr_line1<>(typeof(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line_last = (TYPEOF(h.prep_owner_addr_line_last))'',0,100));
    maxlength_prep_owner_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line_last)));
    avelength_prep_owner_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line_last)),h.prep_owner_addr_line_last<>(typeof(h.prep_owner_addr_line_last))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_fic_fil_name_pcnt *   0.00 / 100 + T.Populated_fic_owner_name_pcnt *   0.00 / 100 + T.Populated_fic_fil_date_pcnt *   0.00 / 100 + T.Populated_fic_fil_doc_num_pcnt *   0.00 / 100 + T.Populated_fic_owner_doc_num_pcnt *   0.00 / 100 + T.Populated_p_owner_name_pcnt *   0.00 / 100 + T.Populated_c_owner_name_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_line_last_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line_last_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'fic_fil_name','fic_owner_name','fic_fil_date','fic_fil_doc_num','fic_owner_doc_num','p_owner_name','c_owner_name','prep_addr_line1','prep_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_fic_fil_name_pcnt,le.populated_fic_owner_name_pcnt,le.populated_fic_fil_date_pcnt,le.populated_fic_fil_doc_num_pcnt,le.populated_fic_owner_doc_num_pcnt,le.populated_p_owner_name_pcnt,le.populated_c_owner_name_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_line_last_pcnt,le.populated_prep_owner_addr_line1_pcnt,le.populated_prep_owner_addr_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_fic_fil_name,le.maxlength_fic_owner_name,le.maxlength_fic_fil_date,le.maxlength_fic_fil_doc_num,le.maxlength_fic_owner_doc_num,le.maxlength_p_owner_name,le.maxlength_c_owner_name,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_line_last,le.maxlength_prep_owner_addr_line1,le.maxlength_prep_owner_addr_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_fic_fil_name,le.avelength_fic_owner_name,le.avelength_fic_fil_date,le.avelength_fic_fil_doc_num,le.avelength_fic_owner_doc_num,le.avelength_p_owner_name,le.avelength_c_owner_name,le.avelength_prep_addr_line1,le.avelength_prep_addr_line_last,le.avelength_prep_owner_addr_line1,le.avelength_prep_owner_addr_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 11, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.fic_fil_name),TRIM((SALT37.StrType)le.fic_owner_name),TRIM((SALT37.StrType)le.fic_fil_date),TRIM((SALT37.StrType)le.fic_fil_doc_num),TRIM((SALT37.StrType)le.fic_owner_doc_num),TRIM((SALT37.StrType)le.p_owner_name),TRIM((SALT37.StrType)le.c_owner_name),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,11,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 11);
  SELF.FldNo2 := 1 + (C % 11);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.fic_fil_name),TRIM((SALT37.StrType)le.fic_owner_name),TRIM((SALT37.StrType)le.fic_fil_date),TRIM((SALT37.StrType)le.fic_fil_doc_num),TRIM((SALT37.StrType)le.fic_owner_doc_num),TRIM((SALT37.StrType)le.p_owner_name),TRIM((SALT37.StrType)le.c_owner_name),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.fic_fil_name),TRIM((SALT37.StrType)le.fic_owner_name),TRIM((SALT37.StrType)le.fic_fil_date),TRIM((SALT37.StrType)le.fic_fil_doc_num),TRIM((SALT37.StrType)le.fic_owner_doc_num),TRIM((SALT37.StrType)le.p_owner_name),TRIM((SALT37.StrType)le.c_owner_name),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),11*11,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'fic_fil_name'}
      ,{2,'fic_owner_name'}
      ,{3,'fic_fil_date'}
      ,{4,'fic_fil_doc_num'}
      ,{5,'fic_owner_doc_num'}
      ,{6,'p_owner_name'}
      ,{7,'c_owner_name'}
      ,{8,'prep_addr_line1'}
      ,{9,'prep_addr_line_last'}
      ,{10,'prep_owner_addr_line1'}
      ,{11,'prep_owner_addr_line_last'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_FL_Filing_Fields.InValid_fic_fil_name((SALT37.StrType)le.fic_fil_name),
    Input_FL_Filing_Fields.InValid_fic_owner_name((SALT37.StrType)le.fic_owner_name),
    Input_FL_Filing_Fields.InValid_fic_fil_date((SALT37.StrType)le.fic_fil_date),
    Input_FL_Filing_Fields.InValid_fic_fil_doc_num((SALT37.StrType)le.fic_fil_doc_num),
    Input_FL_Filing_Fields.InValid_fic_owner_doc_num((SALT37.StrType)le.fic_owner_doc_num),
    Input_FL_Filing_Fields.InValid_p_owner_name((SALT37.StrType)le.p_owner_name),
    Input_FL_Filing_Fields.InValid_c_owner_name((SALT37.StrType)le.c_owner_name),
    Input_FL_Filing_Fields.InValid_prep_addr_line1((SALT37.StrType)le.prep_addr_line1),
    Input_FL_Filing_Fields.InValid_prep_addr_line_last((SALT37.StrType)le.prep_addr_line_last),
    Input_FL_Filing_Fields.InValid_prep_owner_addr_line1((SALT37.StrType)le.prep_owner_addr_line1),
    Input_FL_Filing_Fields.InValid_prep_owner_addr_line_last((SALT37.StrType)le.prep_owner_addr_line_last),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,11,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_FL_Filing_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_general_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_FL_Filing_Fields.InValidMessage_fic_fil_name(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_fic_owner_name(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_fic_fil_date(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_fic_fil_doc_num(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_fic_owner_doc_num(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_p_owner_name(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_c_owner_name(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_prep_addr_line_last(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_prep_owner_addr_line1(TotalErrors.ErrorNum),Input_FL_Filing_Fields.InValidMessage_prep_owner_addr_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;

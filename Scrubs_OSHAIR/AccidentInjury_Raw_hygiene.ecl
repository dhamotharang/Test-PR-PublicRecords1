IMPORT SALT311,STD;
EXPORT AccidentInjury_Raw_hygiene(dataset(AccidentInjury_Raw_Layout) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_summary_nr_cnt := COUNT(GROUP,h.summary_nr <> (TYPEOF(h.summary_nr))'');
    populated_summary_nr_pcnt := AVE(GROUP,IF(h.summary_nr = (TYPEOF(h.summary_nr))'',0,100));
    maxlength_summary_nr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.summary_nr)));
    avelength_summary_nr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.summary_nr)),h.summary_nr<>(typeof(h.summary_nr))'');
    populated_rel_insp_nr_cnt := COUNT(GROUP,h.rel_insp_nr <> (TYPEOF(h.rel_insp_nr))'');
    populated_rel_insp_nr_pcnt := AVE(GROUP,IF(h.rel_insp_nr = (TYPEOF(h.rel_insp_nr))'',0,100));
    maxlength_rel_insp_nr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rel_insp_nr)));
    avelength_rel_insp_nr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rel_insp_nr)),h.rel_insp_nr<>(typeof(h.rel_insp_nr))'');
    populated_age_cnt := COUNT(GROUP,h.age <> (TYPEOF(h.age))'');
    populated_age_pcnt := AVE(GROUP,IF(h.age = (TYPEOF(h.age))'',0,100));
    maxlength_age := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.age)));
    avelength_age := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.age)),h.age<>(typeof(h.age))'');
    populated_sex_cnt := COUNT(GROUP,h.sex <> (TYPEOF(h.sex))'');
    populated_sex_pcnt := AVE(GROUP,IF(h.sex = (TYPEOF(h.sex))'',0,100));
    maxlength_sex := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sex)));
    avelength_sex := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sex)),h.sex<>(typeof(h.sex))'');
    populated_nature_of_inj_cnt := COUNT(GROUP,h.nature_of_inj <> (TYPEOF(h.nature_of_inj))'');
    populated_nature_of_inj_pcnt := AVE(GROUP,IF(h.nature_of_inj = (TYPEOF(h.nature_of_inj))'',0,100));
    maxlength_nature_of_inj := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nature_of_inj)));
    avelength_nature_of_inj := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nature_of_inj)),h.nature_of_inj<>(typeof(h.nature_of_inj))'');
    populated_part_of_body_cnt := COUNT(GROUP,h.part_of_body <> (TYPEOF(h.part_of_body))'');
    populated_part_of_body_pcnt := AVE(GROUP,IF(h.part_of_body = (TYPEOF(h.part_of_body))'',0,100));
    maxlength_part_of_body := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.part_of_body)));
    avelength_part_of_body := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.part_of_body)),h.part_of_body<>(typeof(h.part_of_body))'');
    populated_src_of_injury_cnt := COUNT(GROUP,h.src_of_injury <> (TYPEOF(h.src_of_injury))'');
    populated_src_of_injury_pcnt := AVE(GROUP,IF(h.src_of_injury = (TYPEOF(h.src_of_injury))'',0,100));
    maxlength_src_of_injury := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_of_injury)));
    avelength_src_of_injury := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_of_injury)),h.src_of_injury<>(typeof(h.src_of_injury))'');
    populated_event_type_cnt := COUNT(GROUP,h.event_type <> (TYPEOF(h.event_type))'');
    populated_event_type_pcnt := AVE(GROUP,IF(h.event_type = (TYPEOF(h.event_type))'',0,100));
    maxlength_event_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.event_type)));
    avelength_event_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.event_type)),h.event_type<>(typeof(h.event_type))'');
    populated_evn_factor_cnt := COUNT(GROUP,h.evn_factor <> (TYPEOF(h.evn_factor))'');
    populated_evn_factor_pcnt := AVE(GROUP,IF(h.evn_factor = (TYPEOF(h.evn_factor))'',0,100));
    maxlength_evn_factor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.evn_factor)));
    avelength_evn_factor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.evn_factor)),h.evn_factor<>(typeof(h.evn_factor))'');
    populated_hum_factor_cnt := COUNT(GROUP,h.hum_factor <> (TYPEOF(h.hum_factor))'');
    populated_hum_factor_pcnt := AVE(GROUP,IF(h.hum_factor = (TYPEOF(h.hum_factor))'',0,100));
    maxlength_hum_factor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hum_factor)));
    avelength_hum_factor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hum_factor)),h.hum_factor<>(typeof(h.hum_factor))'');
    populated_occ_code_cnt := COUNT(GROUP,h.occ_code <> (TYPEOF(h.occ_code))'');
    populated_occ_code_pcnt := AVE(GROUP,IF(h.occ_code = (TYPEOF(h.occ_code))'',0,100));
    maxlength_occ_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.occ_code)));
    avelength_occ_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.occ_code)),h.occ_code<>(typeof(h.occ_code))'');
    populated_degree_of_inj_cnt := COUNT(GROUP,h.degree_of_inj <> (TYPEOF(h.degree_of_inj))'');
    populated_degree_of_inj_pcnt := AVE(GROUP,IF(h.degree_of_inj = (TYPEOF(h.degree_of_inj))'',0,100));
    maxlength_degree_of_inj := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.degree_of_inj)));
    avelength_degree_of_inj := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.degree_of_inj)),h.degree_of_inj<>(typeof(h.degree_of_inj))'');
    populated_task_assigned_cnt := COUNT(GROUP,h.task_assigned <> (TYPEOF(h.task_assigned))'');
    populated_task_assigned_pcnt := AVE(GROUP,IF(h.task_assigned = (TYPEOF(h.task_assigned))'',0,100));
    maxlength_task_assigned := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.task_assigned)));
    avelength_task_assigned := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.task_assigned)),h.task_assigned<>(typeof(h.task_assigned))'');
    populated_hazsub_cnt := COUNT(GROUP,h.hazsub <> (TYPEOF(h.hazsub))'');
    populated_hazsub_pcnt := AVE(GROUP,IF(h.hazsub = (TYPEOF(h.hazsub))'',0,100));
    maxlength_hazsub := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hazsub)));
    avelength_hazsub := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hazsub)),h.hazsub<>(typeof(h.hazsub))'');
    populated_const_op_cnt := COUNT(GROUP,h.const_op <> (TYPEOF(h.const_op))'');
    populated_const_op_pcnt := AVE(GROUP,IF(h.const_op = (TYPEOF(h.const_op))'',0,100));
    maxlength_const_op := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.const_op)));
    avelength_const_op := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.const_op)),h.const_op<>(typeof(h.const_op))'');
    populated_const_op_cause_cnt := COUNT(GROUP,h.const_op_cause <> (TYPEOF(h.const_op_cause))'');
    populated_const_op_cause_pcnt := AVE(GROUP,IF(h.const_op_cause = (TYPEOF(h.const_op_cause))'',0,100));
    maxlength_const_op_cause := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.const_op_cause)));
    avelength_const_op_cause := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.const_op_cause)),h.const_op_cause<>(typeof(h.const_op_cause))'');
    populated_fat_cause_cnt := COUNT(GROUP,h.fat_cause <> (TYPEOF(h.fat_cause))'');
    populated_fat_cause_pcnt := AVE(GROUP,IF(h.fat_cause = (TYPEOF(h.fat_cause))'',0,100));
    maxlength_fat_cause := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fat_cause)));
    avelength_fat_cause := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fat_cause)),h.fat_cause<>(typeof(h.fat_cause))'');
    populated_fall_distance_cnt := COUNT(GROUP,h.fall_distance <> (TYPEOF(h.fall_distance))'');
    populated_fall_distance_pcnt := AVE(GROUP,IF(h.fall_distance = (TYPEOF(h.fall_distance))'',0,100));
    maxlength_fall_distance := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fall_distance)));
    avelength_fall_distance := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fall_distance)),h.fall_distance<>(typeof(h.fall_distance))'');
    populated_fall_ht_cnt := COUNT(GROUP,h.fall_ht <> (TYPEOF(h.fall_ht))'');
    populated_fall_ht_pcnt := AVE(GROUP,IF(h.fall_ht = (TYPEOF(h.fall_ht))'',0,100));
    maxlength_fall_ht := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fall_ht)));
    avelength_fall_ht := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fall_ht)),h.fall_ht<>(typeof(h.fall_ht))'');
    populated_injury_line_nr_cnt := COUNT(GROUP,h.injury_line_nr <> (TYPEOF(h.injury_line_nr))'');
    populated_injury_line_nr_pcnt := AVE(GROUP,IF(h.injury_line_nr = (TYPEOF(h.injury_line_nr))'',0,100));
    maxlength_injury_line_nr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.injury_line_nr)));
    avelength_injury_line_nr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.injury_line_nr)),h.injury_line_nr<>(typeof(h.injury_line_nr))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_summary_nr_pcnt *   0.00 / 100 + T.Populated_rel_insp_nr_pcnt *   0.00 / 100 + T.Populated_age_pcnt *   0.00 / 100 + T.Populated_sex_pcnt *   0.00 / 100 + T.Populated_nature_of_inj_pcnt *   0.00 / 100 + T.Populated_part_of_body_pcnt *   0.00 / 100 + T.Populated_src_of_injury_pcnt *   0.00 / 100 + T.Populated_event_type_pcnt *   0.00 / 100 + T.Populated_evn_factor_pcnt *   0.00 / 100 + T.Populated_hum_factor_pcnt *   0.00 / 100 + T.Populated_occ_code_pcnt *   0.00 / 100 + T.Populated_degree_of_inj_pcnt *   0.00 / 100 + T.Populated_task_assigned_pcnt *   0.00 / 100 + T.Populated_hazsub_pcnt *   0.00 / 100 + T.Populated_const_op_pcnt *   0.00 / 100 + T.Populated_const_op_cause_pcnt *   0.00 / 100 + T.Populated_fat_cause_pcnt *   0.00 / 100 + T.Populated_fall_distance_pcnt *   0.00 / 100 + T.Populated_fall_ht_pcnt *   0.00 / 100 + T.Populated_injury_line_nr_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'summary_nr','rel_insp_nr','age','sex','nature_of_inj','part_of_body','src_of_injury','event_type','evn_factor','hum_factor','occ_code','degree_of_inj','task_assigned','hazsub','const_op','const_op_cause','fat_cause','fall_distance','fall_ht','injury_line_nr');
  SELF.populated_pcnt := CHOOSE(C,le.populated_summary_nr_pcnt,le.populated_rel_insp_nr_pcnt,le.populated_age_pcnt,le.populated_sex_pcnt,le.populated_nature_of_inj_pcnt,le.populated_part_of_body_pcnt,le.populated_src_of_injury_pcnt,le.populated_event_type_pcnt,le.populated_evn_factor_pcnt,le.populated_hum_factor_pcnt,le.populated_occ_code_pcnt,le.populated_degree_of_inj_pcnt,le.populated_task_assigned_pcnt,le.populated_hazsub_pcnt,le.populated_const_op_pcnt,le.populated_const_op_cause_pcnt,le.populated_fat_cause_pcnt,le.populated_fall_distance_pcnt,le.populated_fall_ht_pcnt,le.populated_injury_line_nr_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_summary_nr,le.maxlength_rel_insp_nr,le.maxlength_age,le.maxlength_sex,le.maxlength_nature_of_inj,le.maxlength_part_of_body,le.maxlength_src_of_injury,le.maxlength_event_type,le.maxlength_evn_factor,le.maxlength_hum_factor,le.maxlength_occ_code,le.maxlength_degree_of_inj,le.maxlength_task_assigned,le.maxlength_hazsub,le.maxlength_const_op,le.maxlength_const_op_cause,le.maxlength_fat_cause,le.maxlength_fall_distance,le.maxlength_fall_ht,le.maxlength_injury_line_nr);
  SELF.avelength := CHOOSE(C,le.avelength_summary_nr,le.avelength_rel_insp_nr,le.avelength_age,le.avelength_sex,le.avelength_nature_of_inj,le.avelength_part_of_body,le.avelength_src_of_injury,le.avelength_event_type,le.avelength_evn_factor,le.avelength_hum_factor,le.avelength_occ_code,le.avelength_degree_of_inj,le.avelength_task_assigned,le.avelength_hazsub,le.avelength_const_op,le.avelength_const_op_cause,le.avelength_fat_cause,le.avelength_fall_distance,le.avelength_fall_ht,le.avelength_injury_line_nr);
END;
EXPORT invSummary := NORMALIZE(summary0, 20, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.summary_nr),TRIM((SALT311.StrType)le.rel_insp_nr),TRIM((SALT311.StrType)le.age),TRIM((SALT311.StrType)le.sex),TRIM((SALT311.StrType)le.nature_of_inj),TRIM((SALT311.StrType)le.part_of_body),TRIM((SALT311.StrType)le.src_of_injury),TRIM((SALT311.StrType)le.event_type),TRIM((SALT311.StrType)le.evn_factor),TRIM((SALT311.StrType)le.hum_factor),TRIM((SALT311.StrType)le.occ_code),TRIM((SALT311.StrType)le.degree_of_inj),TRIM((SALT311.StrType)le.task_assigned),TRIM((SALT311.StrType)le.hazsub),TRIM((SALT311.StrType)le.const_op),TRIM((SALT311.StrType)le.const_op_cause),TRIM((SALT311.StrType)le.fat_cause),TRIM((SALT311.StrType)le.fall_distance),TRIM((SALT311.StrType)le.fall_ht),TRIM((SALT311.StrType)le.injury_line_nr)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,20,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 20);
  SELF.FldNo2 := 1 + (C % 20);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.summary_nr),TRIM((SALT311.StrType)le.rel_insp_nr),TRIM((SALT311.StrType)le.age),TRIM((SALT311.StrType)le.sex),TRIM((SALT311.StrType)le.nature_of_inj),TRIM((SALT311.StrType)le.part_of_body),TRIM((SALT311.StrType)le.src_of_injury),TRIM((SALT311.StrType)le.event_type),TRIM((SALT311.StrType)le.evn_factor),TRIM((SALT311.StrType)le.hum_factor),TRIM((SALT311.StrType)le.occ_code),TRIM((SALT311.StrType)le.degree_of_inj),TRIM((SALT311.StrType)le.task_assigned),TRIM((SALT311.StrType)le.hazsub),TRIM((SALT311.StrType)le.const_op),TRIM((SALT311.StrType)le.const_op_cause),TRIM((SALT311.StrType)le.fat_cause),TRIM((SALT311.StrType)le.fall_distance),TRIM((SALT311.StrType)le.fall_ht),TRIM((SALT311.StrType)le.injury_line_nr)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.summary_nr),TRIM((SALT311.StrType)le.rel_insp_nr),TRIM((SALT311.StrType)le.age),TRIM((SALT311.StrType)le.sex),TRIM((SALT311.StrType)le.nature_of_inj),TRIM((SALT311.StrType)le.part_of_body),TRIM((SALT311.StrType)le.src_of_injury),TRIM((SALT311.StrType)le.event_type),TRIM((SALT311.StrType)le.evn_factor),TRIM((SALT311.StrType)le.hum_factor),TRIM((SALT311.StrType)le.occ_code),TRIM((SALT311.StrType)le.degree_of_inj),TRIM((SALT311.StrType)le.task_assigned),TRIM((SALT311.StrType)le.hazsub),TRIM((SALT311.StrType)le.const_op),TRIM((SALT311.StrType)le.const_op_cause),TRIM((SALT311.StrType)le.fat_cause),TRIM((SALT311.StrType)le.fall_distance),TRIM((SALT311.StrType)le.fall_ht),TRIM((SALT311.StrType)le.injury_line_nr)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),20*20,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'summary_nr'}
      ,{2,'rel_insp_nr'}
      ,{3,'age'}
      ,{4,'sex'}
      ,{5,'nature_of_inj'}
      ,{6,'part_of_body'}
      ,{7,'src_of_injury'}
      ,{8,'event_type'}
      ,{9,'evn_factor'}
      ,{10,'hum_factor'}
      ,{11,'occ_code'}
      ,{12,'degree_of_inj'}
      ,{13,'task_assigned'}
      ,{14,'hazsub'}
      ,{15,'const_op'}
      ,{16,'const_op_cause'}
      ,{17,'fat_cause'}
      ,{18,'fall_distance'}
      ,{19,'fall_ht'}
      ,{20,'injury_line_nr'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    AccidentInjury_Raw_Fields.InValid_summary_nr((SALT311.StrType)le.summary_nr),
    AccidentInjury_Raw_Fields.InValid_rel_insp_nr((SALT311.StrType)le.rel_insp_nr),
    AccidentInjury_Raw_Fields.InValid_age((SALT311.StrType)le.age),
    AccidentInjury_Raw_Fields.InValid_sex((SALT311.StrType)le.sex),
    AccidentInjury_Raw_Fields.InValid_nature_of_inj((SALT311.StrType)le.nature_of_inj),
    AccidentInjury_Raw_Fields.InValid_part_of_body((SALT311.StrType)le.part_of_body),
    AccidentInjury_Raw_Fields.InValid_src_of_injury((SALT311.StrType)le.src_of_injury),
    AccidentInjury_Raw_Fields.InValid_event_type((SALT311.StrType)le.event_type),
    AccidentInjury_Raw_Fields.InValid_evn_factor((SALT311.StrType)le.evn_factor),
    AccidentInjury_Raw_Fields.InValid_hum_factor((SALT311.StrType)le.hum_factor),
    AccidentInjury_Raw_Fields.InValid_occ_code((SALT311.StrType)le.occ_code),
    AccidentInjury_Raw_Fields.InValid_degree_of_inj((SALT311.StrType)le.degree_of_inj),
    AccidentInjury_Raw_Fields.InValid_task_assigned((SALT311.StrType)le.task_assigned),
    AccidentInjury_Raw_Fields.InValid_hazsub((SALT311.StrType)le.hazsub),
    AccidentInjury_Raw_Fields.InValid_const_op((SALT311.StrType)le.const_op),
    AccidentInjury_Raw_Fields.InValid_const_op_cause((SALT311.StrType)le.const_op_cause),
    AccidentInjury_Raw_Fields.InValid_fat_cause((SALT311.StrType)le.fat_cause),
    AccidentInjury_Raw_Fields.InValid_fall_distance((SALT311.StrType)le.fall_distance),
    AccidentInjury_Raw_Fields.InValid_fall_ht((SALT311.StrType)le.fall_ht),
    AccidentInjury_Raw_Fields.InValid_injury_line_nr((SALT311.StrType)le.injury_line_nr),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,20,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := AccidentInjury_Raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_numeric','invalid_numeric','invalid_sex','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric_blank','invalid_degree_of_inj','invalid_task_assigned','invalid_alpha_numeric','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,AccidentInjury_Raw_Fields.InValidMessage_summary_nr(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_rel_insp_nr(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_age(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_sex(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_nature_of_inj(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_part_of_body(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_src_of_injury(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_event_type(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_evn_factor(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_hum_factor(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_occ_code(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_degree_of_inj(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_task_assigned(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_hazsub(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_const_op(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_const_op_cause(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_fat_cause(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_fall_distance(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_fall_ht(TotalErrors.ErrorNum),AccidentInjury_Raw_Fields.InValidMessage_injury_line_nr(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OSHAIR, AccidentInjury_Raw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

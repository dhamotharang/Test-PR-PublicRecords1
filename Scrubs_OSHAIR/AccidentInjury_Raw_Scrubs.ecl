IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_OSHAIR; // Import modules for FieldTypes attribute definitions
EXPORT AccidentInjury_Raw_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 20;
  EXPORT NumRulesFromFieldType := 20;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 20;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(AccidentInjury_Raw_Layout)
    UNSIGNED1 summary_nr_Invalid;
    UNSIGNED1 rel_insp_nr_Invalid;
    UNSIGNED1 age_Invalid;
    UNSIGNED1 sex_Invalid;
    UNSIGNED1 nature_of_inj_Invalid;
    UNSIGNED1 part_of_body_Invalid;
    UNSIGNED1 src_of_injury_Invalid;
    UNSIGNED1 event_type_Invalid;
    UNSIGNED1 evn_factor_Invalid;
    UNSIGNED1 hum_factor_Invalid;
    UNSIGNED1 occ_code_Invalid;
    UNSIGNED1 degree_of_inj_Invalid;
    UNSIGNED1 task_assigned_Invalid;
    UNSIGNED1 hazsub_Invalid;
    UNSIGNED1 const_op_Invalid;
    UNSIGNED1 const_op_cause_Invalid;
    UNSIGNED1 fat_cause_Invalid;
    UNSIGNED1 fall_distance_Invalid;
    UNSIGNED1 fall_ht_Invalid;
    UNSIGNED1 injury_line_nr_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(AccidentInjury_Raw_Layout)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(AccidentInjury_Raw_Layout) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.summary_nr_Invalid := AccidentInjury_Raw_Fields.InValid_summary_nr((SALT311.StrType)le.summary_nr);
    SELF.rel_insp_nr_Invalid := AccidentInjury_Raw_Fields.InValid_rel_insp_nr((SALT311.StrType)le.rel_insp_nr);
    SELF.age_Invalid := AccidentInjury_Raw_Fields.InValid_age((SALT311.StrType)le.age);
    SELF.sex_Invalid := AccidentInjury_Raw_Fields.InValid_sex((SALT311.StrType)le.sex);
    SELF.nature_of_inj_Invalid := AccidentInjury_Raw_Fields.InValid_nature_of_inj((SALT311.StrType)le.nature_of_inj);
    SELF.part_of_body_Invalid := AccidentInjury_Raw_Fields.InValid_part_of_body((SALT311.StrType)le.part_of_body);
    SELF.src_of_injury_Invalid := AccidentInjury_Raw_Fields.InValid_src_of_injury((SALT311.StrType)le.src_of_injury);
    SELF.event_type_Invalid := AccidentInjury_Raw_Fields.InValid_event_type((SALT311.StrType)le.event_type);
    SELF.evn_factor_Invalid := AccidentInjury_Raw_Fields.InValid_evn_factor((SALT311.StrType)le.evn_factor);
    SELF.hum_factor_Invalid := AccidentInjury_Raw_Fields.InValid_hum_factor((SALT311.StrType)le.hum_factor);
    SELF.occ_code_Invalid := AccidentInjury_Raw_Fields.InValid_occ_code((SALT311.StrType)le.occ_code);
    SELF.degree_of_inj_Invalid := AccidentInjury_Raw_Fields.InValid_degree_of_inj((SALT311.StrType)le.degree_of_inj);
    SELF.task_assigned_Invalid := AccidentInjury_Raw_Fields.InValid_task_assigned((SALT311.StrType)le.task_assigned);
    SELF.hazsub_Invalid := AccidentInjury_Raw_Fields.InValid_hazsub((SALT311.StrType)le.hazsub);
    SELF.const_op_Invalid := AccidentInjury_Raw_Fields.InValid_const_op((SALT311.StrType)le.const_op);
    SELF.const_op_cause_Invalid := AccidentInjury_Raw_Fields.InValid_const_op_cause((SALT311.StrType)le.const_op_cause);
    SELF.fat_cause_Invalid := AccidentInjury_Raw_Fields.InValid_fat_cause((SALT311.StrType)le.fat_cause);
    SELF.fall_distance_Invalid := AccidentInjury_Raw_Fields.InValid_fall_distance((SALT311.StrType)le.fall_distance);
    SELF.fall_ht_Invalid := AccidentInjury_Raw_Fields.InValid_fall_ht((SALT311.StrType)le.fall_ht);
    SELF.injury_line_nr_Invalid := AccidentInjury_Raw_Fields.InValid_injury_line_nr((SALT311.StrType)le.injury_line_nr);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),AccidentInjury_Raw_Layout);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.summary_nr_Invalid << 0 ) + ( le.rel_insp_nr_Invalid << 1 ) + ( le.age_Invalid << 2 ) + ( le.sex_Invalid << 3 ) + ( le.nature_of_inj_Invalid << 4 ) + ( le.part_of_body_Invalid << 5 ) + ( le.src_of_injury_Invalid << 6 ) + ( le.event_type_Invalid << 7 ) + ( le.evn_factor_Invalid << 8 ) + ( le.hum_factor_Invalid << 9 ) + ( le.occ_code_Invalid << 10 ) + ( le.degree_of_inj_Invalid << 11 ) + ( le.task_assigned_Invalid << 12 ) + ( le.hazsub_Invalid << 13 ) + ( le.const_op_Invalid << 14 ) + ( le.const_op_cause_Invalid << 15 ) + ( le.fat_cause_Invalid << 16 ) + ( le.fall_distance_Invalid << 17 ) + ( le.fall_ht_Invalid << 18 ) + ( le.injury_line_nr_Invalid << 19 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,AccidentInjury_Raw_Layout);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.summary_nr_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.rel_insp_nr_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.age_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.sex_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.nature_of_inj_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.part_of_body_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.src_of_injury_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.event_type_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.evn_factor_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.hum_factor_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.occ_code_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.degree_of_inj_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.task_assigned_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.hazsub_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.const_op_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.const_op_cause_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.fat_cause_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.fall_distance_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.fall_ht_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.injury_line_nr_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    summary_nr_CUSTOM_ErrorCount := COUNT(GROUP,h.summary_nr_Invalid=1);
    rel_insp_nr_CUSTOM_ErrorCount := COUNT(GROUP,h.rel_insp_nr_Invalid=1);
    age_CUSTOM_ErrorCount := COUNT(GROUP,h.age_Invalid=1);
    sex_CUSTOM_ErrorCount := COUNT(GROUP,h.sex_Invalid=1);
    nature_of_inj_CUSTOM_ErrorCount := COUNT(GROUP,h.nature_of_inj_Invalid=1);
    part_of_body_CUSTOM_ErrorCount := COUNT(GROUP,h.part_of_body_Invalid=1);
    src_of_injury_CUSTOM_ErrorCount := COUNT(GROUP,h.src_of_injury_Invalid=1);
    event_type_CUSTOM_ErrorCount := COUNT(GROUP,h.event_type_Invalid=1);
    evn_factor_CUSTOM_ErrorCount := COUNT(GROUP,h.evn_factor_Invalid=1);
    hum_factor_CUSTOM_ErrorCount := COUNT(GROUP,h.hum_factor_Invalid=1);
    occ_code_CUSTOM_ErrorCount := COUNT(GROUP,h.occ_code_Invalid=1);
    degree_of_inj_CUSTOM_ErrorCount := COUNT(GROUP,h.degree_of_inj_Invalid=1);
    task_assigned_CUSTOM_ErrorCount := COUNT(GROUP,h.task_assigned_Invalid=1);
    hazsub_CUSTOM_ErrorCount := COUNT(GROUP,h.hazsub_Invalid=1);
    const_op_CUSTOM_ErrorCount := COUNT(GROUP,h.const_op_Invalid=1);
    const_op_cause_CUSTOM_ErrorCount := COUNT(GROUP,h.const_op_cause_Invalid=1);
    fat_cause_CUSTOM_ErrorCount := COUNT(GROUP,h.fat_cause_Invalid=1);
    fall_distance_CUSTOM_ErrorCount := COUNT(GROUP,h.fall_distance_Invalid=1);
    fall_ht_CUSTOM_ErrorCount := COUNT(GROUP,h.fall_ht_Invalid=1);
    injury_line_nr_CUSTOM_ErrorCount := COUNT(GROUP,h.injury_line_nr_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.summary_nr_Invalid > 0 OR h.rel_insp_nr_Invalid > 0 OR h.age_Invalid > 0 OR h.sex_Invalid > 0 OR h.nature_of_inj_Invalid > 0 OR h.part_of_body_Invalid > 0 OR h.src_of_injury_Invalid > 0 OR h.event_type_Invalid > 0 OR h.evn_factor_Invalid > 0 OR h.hum_factor_Invalid > 0 OR h.occ_code_Invalid > 0 OR h.degree_of_inj_Invalid > 0 OR h.task_assigned_Invalid > 0 OR h.hazsub_Invalid > 0 OR h.const_op_Invalid > 0 OR h.const_op_cause_Invalid > 0 OR h.fat_cause_Invalid > 0 OR h.fall_distance_Invalid > 0 OR h.fall_ht_Invalid > 0 OR h.injury_line_nr_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.summary_nr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rel_insp_nr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.age_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sex_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.nature_of_inj_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.part_of_body_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_of_injury_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.event_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.evn_factor_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hum_factor_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.occ_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.degree_of_inj_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.task_assigned_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hazsub_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.const_op_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.const_op_cause_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fat_cause_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fall_distance_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fall_ht_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.injury_line_nr_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.summary_nr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rel_insp_nr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.age_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sex_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.nature_of_inj_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.part_of_body_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_of_injury_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.event_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.evn_factor_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hum_factor_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.occ_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.degree_of_inj_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.task_assigned_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hazsub_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.const_op_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.const_op_cause_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fat_cause_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fall_distance_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fall_ht_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.injury_line_nr_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.summary_nr_Invalid,le.rel_insp_nr_Invalid,le.age_Invalid,le.sex_Invalid,le.nature_of_inj_Invalid,le.part_of_body_Invalid,le.src_of_injury_Invalid,le.event_type_Invalid,le.evn_factor_Invalid,le.hum_factor_Invalid,le.occ_code_Invalid,le.degree_of_inj_Invalid,le.task_assigned_Invalid,le.hazsub_Invalid,le.const_op_Invalid,le.const_op_cause_Invalid,le.fat_cause_Invalid,le.fall_distance_Invalid,le.fall_ht_Invalid,le.injury_line_nr_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,AccidentInjury_Raw_Fields.InvalidMessage_summary_nr(le.summary_nr_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_rel_insp_nr(le.rel_insp_nr_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_age(le.age_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_sex(le.sex_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_nature_of_inj(le.nature_of_inj_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_part_of_body(le.part_of_body_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_src_of_injury(le.src_of_injury_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_event_type(le.event_type_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_evn_factor(le.evn_factor_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_hum_factor(le.hum_factor_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_occ_code(le.occ_code_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_degree_of_inj(le.degree_of_inj_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_task_assigned(le.task_assigned_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_hazsub(le.hazsub_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_const_op(le.const_op_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_const_op_cause(le.const_op_cause_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_fat_cause(le.fat_cause_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_fall_distance(le.fall_distance_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_fall_ht(le.fall_ht_Invalid),AccidentInjury_Raw_Fields.InvalidMessage_injury_line_nr(le.injury_line_nr_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.summary_nr_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rel_insp_nr_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.age_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sex_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.nature_of_inj_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.part_of_body_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_of_injury_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.event_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.evn_factor_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.hum_factor_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.occ_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.degree_of_inj_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.task_assigned_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.hazsub_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.const_op_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.const_op_cause_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fat_cause_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fall_distance_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fall_ht_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.injury_line_nr_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'summary_nr','rel_insp_nr','age','sex','nature_of_inj','part_of_body','src_of_injury','event_type','evn_factor','hum_factor','occ_code','degree_of_inj','task_assigned','hazsub','const_op','const_op_cause','fat_cause','fall_distance','fall_ht','injury_line_nr','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_numeric','invalid_numeric','invalid_sex','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric_blank','invalid_degree_of_inj','invalid_task_assigned','invalid_alpha_numeric','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric_blank','invalid_numeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.summary_nr,(SALT311.StrType)le.rel_insp_nr,(SALT311.StrType)le.age,(SALT311.StrType)le.sex,(SALT311.StrType)le.nature_of_inj,(SALT311.StrType)le.part_of_body,(SALT311.StrType)le.src_of_injury,(SALT311.StrType)le.event_type,(SALT311.StrType)le.evn_factor,(SALT311.StrType)le.hum_factor,(SALT311.StrType)le.occ_code,(SALT311.StrType)le.degree_of_inj,(SALT311.StrType)le.task_assigned,(SALT311.StrType)le.hazsub,(SALT311.StrType)le.const_op,(SALT311.StrType)le.const_op_cause,(SALT311.StrType)le.fat_cause,(SALT311.StrType)le.fall_distance,(SALT311.StrType)le.fall_ht,(SALT311.StrType)le.injury_line_nr,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,20,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(AccidentInjury_Raw_Layout) prevDS = DATASET([], AccidentInjury_Raw_Layout), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'summary_nr:invalid_numeric:CUSTOM'
          ,'rel_insp_nr:invalid_numeric:CUSTOM'
          ,'age:invalid_numeric:CUSTOM'
          ,'sex:invalid_sex:CUSTOM'
          ,'nature_of_inj:invalid_numeric_blank:CUSTOM'
          ,'part_of_body:invalid_numeric_blank:CUSTOM'
          ,'src_of_injury:invalid_numeric_blank:CUSTOM'
          ,'event_type:invalid_numeric_blank:CUSTOM'
          ,'evn_factor:invalid_numeric_blank:CUSTOM'
          ,'hum_factor:invalid_numeric_blank:CUSTOM'
          ,'occ_code:invalid_numeric_blank:CUSTOM'
          ,'degree_of_inj:invalid_degree_of_inj:CUSTOM'
          ,'task_assigned:invalid_task_assigned:CUSTOM'
          ,'hazsub:invalid_alpha_numeric:CUSTOM'
          ,'const_op:invalid_numeric_blank:CUSTOM'
          ,'const_op_cause:invalid_numeric_blank:CUSTOM'
          ,'fat_cause:invalid_numeric_blank:CUSTOM'
          ,'fall_distance:invalid_numeric_blank:CUSTOM'
          ,'fall_ht:invalid_numeric_blank:CUSTOM'
          ,'injury_line_nr:invalid_numeric:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,AccidentInjury_Raw_Fields.InvalidMessage_summary_nr(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_rel_insp_nr(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_age(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_sex(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_nature_of_inj(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_part_of_body(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_src_of_injury(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_event_type(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_evn_factor(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_hum_factor(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_occ_code(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_degree_of_inj(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_task_assigned(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_hazsub(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_const_op(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_const_op_cause(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_fat_cause(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_fall_distance(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_fall_ht(1)
          ,AccidentInjury_Raw_Fields.InvalidMessage_injury_line_nr(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.summary_nr_CUSTOM_ErrorCount
          ,le.rel_insp_nr_CUSTOM_ErrorCount
          ,le.age_CUSTOM_ErrorCount
          ,le.sex_CUSTOM_ErrorCount
          ,le.nature_of_inj_CUSTOM_ErrorCount
          ,le.part_of_body_CUSTOM_ErrorCount
          ,le.src_of_injury_CUSTOM_ErrorCount
          ,le.event_type_CUSTOM_ErrorCount
          ,le.evn_factor_CUSTOM_ErrorCount
          ,le.hum_factor_CUSTOM_ErrorCount
          ,le.occ_code_CUSTOM_ErrorCount
          ,le.degree_of_inj_CUSTOM_ErrorCount
          ,le.task_assigned_CUSTOM_ErrorCount
          ,le.hazsub_CUSTOM_ErrorCount
          ,le.const_op_CUSTOM_ErrorCount
          ,le.const_op_cause_CUSTOM_ErrorCount
          ,le.fat_cause_CUSTOM_ErrorCount
          ,le.fall_distance_CUSTOM_ErrorCount
          ,le.fall_ht_CUSTOM_ErrorCount
          ,le.injury_line_nr_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.summary_nr_CUSTOM_ErrorCount
          ,le.rel_insp_nr_CUSTOM_ErrorCount
          ,le.age_CUSTOM_ErrorCount
          ,le.sex_CUSTOM_ErrorCount
          ,le.nature_of_inj_CUSTOM_ErrorCount
          ,le.part_of_body_CUSTOM_ErrorCount
          ,le.src_of_injury_CUSTOM_ErrorCount
          ,le.event_type_CUSTOM_ErrorCount
          ,le.evn_factor_CUSTOM_ErrorCount
          ,le.hum_factor_CUSTOM_ErrorCount
          ,le.occ_code_CUSTOM_ErrorCount
          ,le.degree_of_inj_CUSTOM_ErrorCount
          ,le.task_assigned_CUSTOM_ErrorCount
          ,le.hazsub_CUSTOM_ErrorCount
          ,le.const_op_CUSTOM_ErrorCount
          ,le.const_op_cause_CUSTOM_ErrorCount
          ,le.fat_cause_CUSTOM_ErrorCount
          ,le.fall_distance_CUSTOM_ErrorCount
          ,le.fall_ht_CUSTOM_ErrorCount
          ,le.injury_line_nr_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := AccidentInjury_Raw_hygiene(PROJECT(h, AccidentInjury_Raw_Layout));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'summary_nr:' + getFieldTypeText(h.summary_nr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rel_insp_nr:' + getFieldTypeText(h.rel_insp_nr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'age:' + getFieldTypeText(h.age) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sex:' + getFieldTypeText(h.sex) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nature_of_inj:' + getFieldTypeText(h.nature_of_inj) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'part_of_body:' + getFieldTypeText(h.part_of_body) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_of_injury:' + getFieldTypeText(h.src_of_injury) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'event_type:' + getFieldTypeText(h.event_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'evn_factor:' + getFieldTypeText(h.evn_factor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hum_factor:' + getFieldTypeText(h.hum_factor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'occ_code:' + getFieldTypeText(h.occ_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'degree_of_inj:' + getFieldTypeText(h.degree_of_inj) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'task_assigned:' + getFieldTypeText(h.task_assigned) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hazsub:' + getFieldTypeText(h.hazsub) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'const_op:' + getFieldTypeText(h.const_op) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'const_op_cause:' + getFieldTypeText(h.const_op_cause) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fat_cause:' + getFieldTypeText(h.fat_cause) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fall_distance:' + getFieldTypeText(h.fall_distance) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fall_ht:' + getFieldTypeText(h.fall_ht) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'injury_line_nr:' + getFieldTypeText(h.injury_line_nr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_summary_nr_cnt
          ,le.populated_rel_insp_nr_cnt
          ,le.populated_age_cnt
          ,le.populated_sex_cnt
          ,le.populated_nature_of_inj_cnt
          ,le.populated_part_of_body_cnt
          ,le.populated_src_of_injury_cnt
          ,le.populated_event_type_cnt
          ,le.populated_evn_factor_cnt
          ,le.populated_hum_factor_cnt
          ,le.populated_occ_code_cnt
          ,le.populated_degree_of_inj_cnt
          ,le.populated_task_assigned_cnt
          ,le.populated_hazsub_cnt
          ,le.populated_const_op_cnt
          ,le.populated_const_op_cause_cnt
          ,le.populated_fat_cause_cnt
          ,le.populated_fall_distance_cnt
          ,le.populated_fall_ht_cnt
          ,le.populated_injury_line_nr_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_summary_nr_pcnt
          ,le.populated_rel_insp_nr_pcnt
          ,le.populated_age_pcnt
          ,le.populated_sex_pcnt
          ,le.populated_nature_of_inj_pcnt
          ,le.populated_part_of_body_pcnt
          ,le.populated_src_of_injury_pcnt
          ,le.populated_event_type_pcnt
          ,le.populated_evn_factor_pcnt
          ,le.populated_hum_factor_pcnt
          ,le.populated_occ_code_pcnt
          ,le.populated_degree_of_inj_pcnt
          ,le.populated_task_assigned_pcnt
          ,le.populated_hazsub_pcnt
          ,le.populated_const_op_pcnt
          ,le.populated_const_op_cause_pcnt
          ,le.populated_fat_cause_pcnt
          ,le.populated_fall_distance_pcnt
          ,le.populated_fall_ht_pcnt
          ,le.populated_injury_line_nr_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,20,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := AccidentInjury_Raw_Delta(prevDS, PROJECT(h, AccidentInjury_Raw_Layout));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),20,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(AccidentInjury_Raw_Layout) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_OSHAIR, AccidentInjury_Raw_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;

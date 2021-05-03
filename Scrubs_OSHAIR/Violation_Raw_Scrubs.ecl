IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_Oshair; // Import modules for FieldTypes attribute definitions
EXPORT Violation_Raw_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 26;
  EXPORT NumRulesFromFieldType := 26;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 26;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Violation_Raw_Layout)
    UNSIGNED1 activity_nr_Invalid;
    UNSIGNED1 citation_id_Invalid;
    UNSIGNED1 delete_flag_Invalid;
    UNSIGNED1 viol_type_Invalid;
    UNSIGNED1 issuance_date_Invalid;
    UNSIGNED1 abate_date_Invalid;
    UNSIGNED1 current_penalty_Invalid;
    UNSIGNED1 initial_penalty_Invalid;
    UNSIGNED1 contest_date_Invalid;
    UNSIGNED1 final_order_date_Invalid;
    UNSIGNED1 nr_instances_Invalid;
    UNSIGNED1 nr_exposed_Invalid;
    UNSIGNED1 rec_Invalid;
    UNSIGNED1 gravity_Invalid;
    UNSIGNED1 emphasis_Invalid;
    UNSIGNED1 hazcat_Invalid;
    UNSIGNED1 fta_insp_nr_Invalid;
    UNSIGNED1 fta_issuance_date_Invalid;
    UNSIGNED1 fta_penalty_Invalid;
    UNSIGNED1 fta_contest_date_Invalid;
    UNSIGNED1 fta_final_order_date_Invalid;
    UNSIGNED1 hazsub1_Invalid;
    UNSIGNED1 hazsub2_Invalid;
    UNSIGNED1 hazsub3_Invalid;
    UNSIGNED1 hazsub4_Invalid;
    UNSIGNED1 hazsub5_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Violation_Raw_Layout)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Violation_Raw_Layout) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.activity_nr_Invalid := Violation_Raw_Fields.InValid_activity_nr((SALT311.StrType)le.activity_nr);
    SELF.citation_id_Invalid := Violation_Raw_Fields.InValid_citation_id((SALT311.StrType)le.citation_id);
    SELF.delete_flag_Invalid := Violation_Raw_Fields.InValid_delete_flag((SALT311.StrType)le.delete_flag);
    SELF.viol_type_Invalid := Violation_Raw_Fields.InValid_viol_type((SALT311.StrType)le.viol_type);
    SELF.issuance_date_Invalid := Violation_Raw_Fields.InValid_issuance_date((SALT311.StrType)le.issuance_date);
    SELF.abate_date_Invalid := Violation_Raw_Fields.InValid_abate_date((SALT311.StrType)le.abate_date);
    SELF.current_penalty_Invalid := Violation_Raw_Fields.InValid_current_penalty((SALT311.StrType)le.current_penalty);
    SELF.initial_penalty_Invalid := Violation_Raw_Fields.InValid_initial_penalty((SALT311.StrType)le.initial_penalty);
    SELF.contest_date_Invalid := Violation_Raw_Fields.InValid_contest_date((SALT311.StrType)le.contest_date);
    SELF.final_order_date_Invalid := Violation_Raw_Fields.InValid_final_order_date((SALT311.StrType)le.final_order_date);
    SELF.nr_instances_Invalid := Violation_Raw_Fields.InValid_nr_instances((SALT311.StrType)le.nr_instances);
    SELF.nr_exposed_Invalid := Violation_Raw_Fields.InValid_nr_exposed((SALT311.StrType)le.nr_exposed);
    SELF.rec_Invalid := Violation_Raw_Fields.InValid_rec((SALT311.StrType)le.rec);
    SELF.gravity_Invalid := Violation_Raw_Fields.InValid_gravity((SALT311.StrType)le.gravity);
    SELF.emphasis_Invalid := Violation_Raw_Fields.InValid_emphasis((SALT311.StrType)le.emphasis);
    SELF.hazcat_Invalid := Violation_Raw_Fields.InValid_hazcat((SALT311.StrType)le.hazcat);
    SELF.fta_insp_nr_Invalid := Violation_Raw_Fields.InValid_fta_insp_nr((SALT311.StrType)le.fta_insp_nr);
    SELF.fta_issuance_date_Invalid := Violation_Raw_Fields.InValid_fta_issuance_date((SALT311.StrType)le.fta_issuance_date);
    SELF.fta_penalty_Invalid := Violation_Raw_Fields.InValid_fta_penalty((SALT311.StrType)le.fta_penalty);
    SELF.fta_contest_date_Invalid := Violation_Raw_Fields.InValid_fta_contest_date((SALT311.StrType)le.fta_contest_date);
    SELF.fta_final_order_date_Invalid := Violation_Raw_Fields.InValid_fta_final_order_date((SALT311.StrType)le.fta_final_order_date);
    SELF.hazsub1_Invalid := Violation_Raw_Fields.InValid_hazsub1((SALT311.StrType)le.hazsub1);
    SELF.hazsub2_Invalid := Violation_Raw_Fields.InValid_hazsub2((SALT311.StrType)le.hazsub2);
    SELF.hazsub3_Invalid := Violation_Raw_Fields.InValid_hazsub3((SALT311.StrType)le.hazsub3);
    SELF.hazsub4_Invalid := Violation_Raw_Fields.InValid_hazsub4((SALT311.StrType)le.hazsub4);
    SELF.hazsub5_Invalid := Violation_Raw_Fields.InValid_hazsub5((SALT311.StrType)le.hazsub5);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Violation_Raw_Layout);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.activity_nr_Invalid << 0 ) + ( le.citation_id_Invalid << 1 ) + ( le.delete_flag_Invalid << 2 ) + ( le.viol_type_Invalid << 3 ) + ( le.issuance_date_Invalid << 4 ) + ( le.abate_date_Invalid << 5 ) + ( le.current_penalty_Invalid << 6 ) + ( le.initial_penalty_Invalid << 7 ) + ( le.contest_date_Invalid << 8 ) + ( le.final_order_date_Invalid << 9 ) + ( le.nr_instances_Invalid << 10 ) + ( le.nr_exposed_Invalid << 11 ) + ( le.rec_Invalid << 12 ) + ( le.gravity_Invalid << 13 ) + ( le.emphasis_Invalid << 14 ) + ( le.hazcat_Invalid << 15 ) + ( le.fta_insp_nr_Invalid << 16 ) + ( le.fta_issuance_date_Invalid << 17 ) + ( le.fta_penalty_Invalid << 18 ) + ( le.fta_contest_date_Invalid << 19 ) + ( le.fta_final_order_date_Invalid << 20 ) + ( le.hazsub1_Invalid << 21 ) + ( le.hazsub2_Invalid << 22 ) + ( le.hazsub3_Invalid << 23 ) + ( le.hazsub4_Invalid << 24 ) + ( le.hazsub5_Invalid << 25 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Violation_Raw_Layout);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.activity_nr_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.citation_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.delete_flag_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.viol_type_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.issuance_date_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.abate_date_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.current_penalty_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.initial_penalty_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.contest_date_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.final_order_date_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.nr_instances_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.nr_exposed_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.rec_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.gravity_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.emphasis_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.hazcat_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.fta_insp_nr_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.fta_issuance_date_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.fta_penalty_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.fta_contest_date_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.fta_final_order_date_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.hazsub1_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.hazsub2_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.hazsub3_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.hazsub4_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.hazsub5_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    activity_nr_CUSTOM_ErrorCount := COUNT(GROUP,h.activity_nr_Invalid=1);
    citation_id_CUSTOM_ErrorCount := COUNT(GROUP,h.citation_id_Invalid=1);
    delete_flag_ENUM_ErrorCount := COUNT(GROUP,h.delete_flag_Invalid=1);
    viol_type_ENUM_ErrorCount := COUNT(GROUP,h.viol_type_Invalid=1);
    issuance_date_CUSTOM_ErrorCount := COUNT(GROUP,h.issuance_date_Invalid=1);
    abate_date_CUSTOM_ErrorCount := COUNT(GROUP,h.abate_date_Invalid=1);
    current_penalty_CUSTOM_ErrorCount := COUNT(GROUP,h.current_penalty_Invalid=1);
    initial_penalty_CUSTOM_ErrorCount := COUNT(GROUP,h.initial_penalty_Invalid=1);
    contest_date_CUSTOM_ErrorCount := COUNT(GROUP,h.contest_date_Invalid=1);
    final_order_date_CUSTOM_ErrorCount := COUNT(GROUP,h.final_order_date_Invalid=1);
    nr_instances_CUSTOM_ErrorCount := COUNT(GROUP,h.nr_instances_Invalid=1);
    nr_exposed_CUSTOM_ErrorCount := COUNT(GROUP,h.nr_exposed_Invalid=1);
    rec_ENUM_ErrorCount := COUNT(GROUP,h.rec_Invalid=1);
    gravity_CUSTOM_ErrorCount := COUNT(GROUP,h.gravity_Invalid=1);
    emphasis_ENUM_ErrorCount := COUNT(GROUP,h.emphasis_Invalid=1);
    hazcat_CUSTOM_ErrorCount := COUNT(GROUP,h.hazcat_Invalid=1);
    fta_insp_nr_CUSTOM_ErrorCount := COUNT(GROUP,h.fta_insp_nr_Invalid=1);
    fta_issuance_date_CUSTOM_ErrorCount := COUNT(GROUP,h.fta_issuance_date_Invalid=1);
    fta_penalty_CUSTOM_ErrorCount := COUNT(GROUP,h.fta_penalty_Invalid=1);
    fta_contest_date_CUSTOM_ErrorCount := COUNT(GROUP,h.fta_contest_date_Invalid=1);
    fta_final_order_date_CUSTOM_ErrorCount := COUNT(GROUP,h.fta_final_order_date_Invalid=1);
    hazsub1_CUSTOM_ErrorCount := COUNT(GROUP,h.hazsub1_Invalid=1);
    hazsub2_CUSTOM_ErrorCount := COUNT(GROUP,h.hazsub2_Invalid=1);
    hazsub3_CUSTOM_ErrorCount := COUNT(GROUP,h.hazsub3_Invalid=1);
    hazsub4_CUSTOM_ErrorCount := COUNT(GROUP,h.hazsub4_Invalid=1);
    hazsub5_CUSTOM_ErrorCount := COUNT(GROUP,h.hazsub5_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.activity_nr_Invalid > 0 OR h.citation_id_Invalid > 0 OR h.delete_flag_Invalid > 0 OR h.viol_type_Invalid > 0 OR h.issuance_date_Invalid > 0 OR h.abate_date_Invalid > 0 OR h.current_penalty_Invalid > 0 OR h.initial_penalty_Invalid > 0 OR h.contest_date_Invalid > 0 OR h.final_order_date_Invalid > 0 OR h.nr_instances_Invalid > 0 OR h.nr_exposed_Invalid > 0 OR h.rec_Invalid > 0 OR h.gravity_Invalid > 0 OR h.emphasis_Invalid > 0 OR h.hazcat_Invalid > 0 OR h.fta_insp_nr_Invalid > 0 OR h.fta_issuance_date_Invalid > 0 OR h.fta_penalty_Invalid > 0 OR h.fta_contest_date_Invalid > 0 OR h.fta_final_order_date_Invalid > 0 OR h.hazsub1_Invalid > 0 OR h.hazsub2_Invalid > 0 OR h.hazsub3_Invalid > 0 OR h.hazsub4_Invalid > 0 OR h.hazsub5_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.activity_nr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.citation_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.delete_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.viol_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.issuance_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.abate_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_penalty_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.initial_penalty_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contest_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.final_order_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.nr_instances_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.nr_exposed_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rec_ENUM_ErrorCount > 0, 1, 0) + IF(le.gravity_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.emphasis_ENUM_ErrorCount > 0, 1, 0) + IF(le.hazcat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fta_insp_nr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fta_issuance_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fta_penalty_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fta_contest_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fta_final_order_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hazsub1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hazsub2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hazsub3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hazsub4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hazsub5_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.activity_nr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.citation_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.delete_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.viol_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.issuance_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.abate_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_penalty_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.initial_penalty_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contest_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.final_order_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.nr_instances_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.nr_exposed_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rec_ENUM_ErrorCount > 0, 1, 0) + IF(le.gravity_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.emphasis_ENUM_ErrorCount > 0, 1, 0) + IF(le.hazcat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fta_insp_nr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fta_issuance_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fta_penalty_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fta_contest_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fta_final_order_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hazsub1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hazsub2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hazsub3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hazsub4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hazsub5_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.activity_nr_Invalid,le.citation_id_Invalid,le.delete_flag_Invalid,le.viol_type_Invalid,le.issuance_date_Invalid,le.abate_date_Invalid,le.current_penalty_Invalid,le.initial_penalty_Invalid,le.contest_date_Invalid,le.final_order_date_Invalid,le.nr_instances_Invalid,le.nr_exposed_Invalid,le.rec_Invalid,le.gravity_Invalid,le.emphasis_Invalid,le.hazcat_Invalid,le.fta_insp_nr_Invalid,le.fta_issuance_date_Invalid,le.fta_penalty_Invalid,le.fta_contest_date_Invalid,le.fta_final_order_date_Invalid,le.hazsub1_Invalid,le.hazsub2_Invalid,le.hazsub3_Invalid,le.hazsub4_Invalid,le.hazsub5_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Violation_Raw_Fields.InvalidMessage_activity_nr(le.activity_nr_Invalid),Violation_Raw_Fields.InvalidMessage_citation_id(le.citation_id_Invalid),Violation_Raw_Fields.InvalidMessage_delete_flag(le.delete_flag_Invalid),Violation_Raw_Fields.InvalidMessage_viol_type(le.viol_type_Invalid),Violation_Raw_Fields.InvalidMessage_issuance_date(le.issuance_date_Invalid),Violation_Raw_Fields.InvalidMessage_abate_date(le.abate_date_Invalid),Violation_Raw_Fields.InvalidMessage_current_penalty(le.current_penalty_Invalid),Violation_Raw_Fields.InvalidMessage_initial_penalty(le.initial_penalty_Invalid),Violation_Raw_Fields.InvalidMessage_contest_date(le.contest_date_Invalid),Violation_Raw_Fields.InvalidMessage_final_order_date(le.final_order_date_Invalid),Violation_Raw_Fields.InvalidMessage_nr_instances(le.nr_instances_Invalid),Violation_Raw_Fields.InvalidMessage_nr_exposed(le.nr_exposed_Invalid),Violation_Raw_Fields.InvalidMessage_rec(le.rec_Invalid),Violation_Raw_Fields.InvalidMessage_gravity(le.gravity_Invalid),Violation_Raw_Fields.InvalidMessage_emphasis(le.emphasis_Invalid),Violation_Raw_Fields.InvalidMessage_hazcat(le.hazcat_Invalid),Violation_Raw_Fields.InvalidMessage_fta_insp_nr(le.fta_insp_nr_Invalid),Violation_Raw_Fields.InvalidMessage_fta_issuance_date(le.fta_issuance_date_Invalid),Violation_Raw_Fields.InvalidMessage_fta_penalty(le.fta_penalty_Invalid),Violation_Raw_Fields.InvalidMessage_fta_contest_date(le.fta_contest_date_Invalid),Violation_Raw_Fields.InvalidMessage_fta_final_order_date(le.fta_final_order_date_Invalid),Violation_Raw_Fields.InvalidMessage_hazsub1(le.hazsub1_Invalid),Violation_Raw_Fields.InvalidMessage_hazsub2(le.hazsub2_Invalid),Violation_Raw_Fields.InvalidMessage_hazsub3(le.hazsub3_Invalid),Violation_Raw_Fields.InvalidMessage_hazsub4(le.hazsub4_Invalid),Violation_Raw_Fields.InvalidMessage_hazsub5(le.hazsub5_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.activity_nr_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.citation_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.delete_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.viol_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.issuance_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.abate_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.current_penalty_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.initial_penalty_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contest_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.final_order_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.nr_instances_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.nr_exposed_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rec_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.gravity_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.emphasis_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.hazcat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fta_insp_nr_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fta_issuance_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fta_penalty_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fta_contest_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fta_final_order_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.hazsub1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.hazsub2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.hazsub3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.hazsub4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.hazsub5_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'activity_nr','citation_id','delete_flag','viol_type','issuance_date','abate_date','current_penalty','initial_penalty','contest_date','final_order_date','nr_instances','nr_exposed','rec','gravity','emphasis','hazcat','fta_insp_nr','fta_issuance_date','fta_penalty','fta_contest_date','fta_final_order_date','hazsub1','hazsub2','hazsub3','hazsub4','hazsub5','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_alpha_numeric','Invalid_X','Invalid_viol_type','invalid_date_ccyymm','invalid_date_future','invalid_numeric_or_period','invalid_numeric_or_period','invalid_date_ccyymm','invalid_date_future','invalid_numeric_blank','invalid_numeric_blank','Invalid_rec','invalid_numeric_blank','Invalid_X','invalid_alpha_blank','invalid_numeric_blank','invalid_date_ccyymm','invalid_numeric_or_period','invalid_date_ccyymm','invalid_date_ccyymm','Invalid_alpha_Numeric_blank','Invalid_alpha_Numeric_blank','Invalid_alpha_Numeric_blank','Invalid_alpha_Numeric_blank','Invalid_alpha_Numeric_blank','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.activity_nr,(SALT311.StrType)le.citation_id,(SALT311.StrType)le.delete_flag,(SALT311.StrType)le.viol_type,(SALT311.StrType)le.issuance_date,(SALT311.StrType)le.abate_date,(SALT311.StrType)le.current_penalty,(SALT311.StrType)le.initial_penalty,(SALT311.StrType)le.contest_date,(SALT311.StrType)le.final_order_date,(SALT311.StrType)le.nr_instances,(SALT311.StrType)le.nr_exposed,(SALT311.StrType)le.rec,(SALT311.StrType)le.gravity,(SALT311.StrType)le.emphasis,(SALT311.StrType)le.hazcat,(SALT311.StrType)le.fta_insp_nr,(SALT311.StrType)le.fta_issuance_date,(SALT311.StrType)le.fta_penalty,(SALT311.StrType)le.fta_contest_date,(SALT311.StrType)le.fta_final_order_date,(SALT311.StrType)le.hazsub1,(SALT311.StrType)le.hazsub2,(SALT311.StrType)le.hazsub3,(SALT311.StrType)le.hazsub4,(SALT311.StrType)le.hazsub5,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,26,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Violation_Raw_Layout) prevDS = DATASET([], Violation_Raw_Layout), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'activity_nr:invalid_numeric:CUSTOM'
          ,'citation_id:invalid_alpha_numeric:CUSTOM'
          ,'delete_flag:Invalid_X:ENUM'
          ,'viol_type:Invalid_viol_type:ENUM'
          ,'issuance_date:invalid_date_ccyymm:CUSTOM'
          ,'abate_date:invalid_date_future:CUSTOM'
          ,'current_penalty:invalid_numeric_or_period:CUSTOM'
          ,'initial_penalty:invalid_numeric_or_period:CUSTOM'
          ,'contest_date:invalid_date_ccyymm:CUSTOM'
          ,'final_order_date:invalid_date_future:CUSTOM'
          ,'nr_instances:invalid_numeric_blank:CUSTOM'
          ,'nr_exposed:invalid_numeric_blank:CUSTOM'
          ,'rec:Invalid_rec:ENUM'
          ,'gravity:invalid_numeric_blank:CUSTOM'
          ,'emphasis:Invalid_X:ENUM'
          ,'hazcat:invalid_alpha_blank:CUSTOM'
          ,'fta_insp_nr:invalid_numeric_blank:CUSTOM'
          ,'fta_issuance_date:invalid_date_ccyymm:CUSTOM'
          ,'fta_penalty:invalid_numeric_or_period:CUSTOM'
          ,'fta_contest_date:invalid_date_ccyymm:CUSTOM'
          ,'fta_final_order_date:invalid_date_ccyymm:CUSTOM'
          ,'hazsub1:Invalid_alpha_Numeric_blank:CUSTOM'
          ,'hazsub2:Invalid_alpha_Numeric_blank:CUSTOM'
          ,'hazsub3:Invalid_alpha_Numeric_blank:CUSTOM'
          ,'hazsub4:Invalid_alpha_Numeric_blank:CUSTOM'
          ,'hazsub5:Invalid_alpha_Numeric_blank:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Violation_Raw_Fields.InvalidMessage_activity_nr(1)
          ,Violation_Raw_Fields.InvalidMessage_citation_id(1)
          ,Violation_Raw_Fields.InvalidMessage_delete_flag(1)
          ,Violation_Raw_Fields.InvalidMessage_viol_type(1)
          ,Violation_Raw_Fields.InvalidMessage_issuance_date(1)
          ,Violation_Raw_Fields.InvalidMessage_abate_date(1)
          ,Violation_Raw_Fields.InvalidMessage_current_penalty(1)
          ,Violation_Raw_Fields.InvalidMessage_initial_penalty(1)
          ,Violation_Raw_Fields.InvalidMessage_contest_date(1)
          ,Violation_Raw_Fields.InvalidMessage_final_order_date(1)
          ,Violation_Raw_Fields.InvalidMessage_nr_instances(1)
          ,Violation_Raw_Fields.InvalidMessage_nr_exposed(1)
          ,Violation_Raw_Fields.InvalidMessage_rec(1)
          ,Violation_Raw_Fields.InvalidMessage_gravity(1)
          ,Violation_Raw_Fields.InvalidMessage_emphasis(1)
          ,Violation_Raw_Fields.InvalidMessage_hazcat(1)
          ,Violation_Raw_Fields.InvalidMessage_fta_insp_nr(1)
          ,Violation_Raw_Fields.InvalidMessage_fta_issuance_date(1)
          ,Violation_Raw_Fields.InvalidMessage_fta_penalty(1)
          ,Violation_Raw_Fields.InvalidMessage_fta_contest_date(1)
          ,Violation_Raw_Fields.InvalidMessage_fta_final_order_date(1)
          ,Violation_Raw_Fields.InvalidMessage_hazsub1(1)
          ,Violation_Raw_Fields.InvalidMessage_hazsub2(1)
          ,Violation_Raw_Fields.InvalidMessage_hazsub3(1)
          ,Violation_Raw_Fields.InvalidMessage_hazsub4(1)
          ,Violation_Raw_Fields.InvalidMessage_hazsub5(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.activity_nr_CUSTOM_ErrorCount
          ,le.citation_id_CUSTOM_ErrorCount
          ,le.delete_flag_ENUM_ErrorCount
          ,le.viol_type_ENUM_ErrorCount
          ,le.issuance_date_CUSTOM_ErrorCount
          ,le.abate_date_CUSTOM_ErrorCount
          ,le.current_penalty_CUSTOM_ErrorCount
          ,le.initial_penalty_CUSTOM_ErrorCount
          ,le.contest_date_CUSTOM_ErrorCount
          ,le.final_order_date_CUSTOM_ErrorCount
          ,le.nr_instances_CUSTOM_ErrorCount
          ,le.nr_exposed_CUSTOM_ErrorCount
          ,le.rec_ENUM_ErrorCount
          ,le.gravity_CUSTOM_ErrorCount
          ,le.emphasis_ENUM_ErrorCount
          ,le.hazcat_CUSTOM_ErrorCount
          ,le.fta_insp_nr_CUSTOM_ErrorCount
          ,le.fta_issuance_date_CUSTOM_ErrorCount
          ,le.fta_penalty_CUSTOM_ErrorCount
          ,le.fta_contest_date_CUSTOM_ErrorCount
          ,le.fta_final_order_date_CUSTOM_ErrorCount
          ,le.hazsub1_CUSTOM_ErrorCount
          ,le.hazsub2_CUSTOM_ErrorCount
          ,le.hazsub3_CUSTOM_ErrorCount
          ,le.hazsub4_CUSTOM_ErrorCount
          ,le.hazsub5_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.activity_nr_CUSTOM_ErrorCount
          ,le.citation_id_CUSTOM_ErrorCount
          ,le.delete_flag_ENUM_ErrorCount
          ,le.viol_type_ENUM_ErrorCount
          ,le.issuance_date_CUSTOM_ErrorCount
          ,le.abate_date_CUSTOM_ErrorCount
          ,le.current_penalty_CUSTOM_ErrorCount
          ,le.initial_penalty_CUSTOM_ErrorCount
          ,le.contest_date_CUSTOM_ErrorCount
          ,le.final_order_date_CUSTOM_ErrorCount
          ,le.nr_instances_CUSTOM_ErrorCount
          ,le.nr_exposed_CUSTOM_ErrorCount
          ,le.rec_ENUM_ErrorCount
          ,le.gravity_CUSTOM_ErrorCount
          ,le.emphasis_ENUM_ErrorCount
          ,le.hazcat_CUSTOM_ErrorCount
          ,le.fta_insp_nr_CUSTOM_ErrorCount
          ,le.fta_issuance_date_CUSTOM_ErrorCount
          ,le.fta_penalty_CUSTOM_ErrorCount
          ,le.fta_contest_date_CUSTOM_ErrorCount
          ,le.fta_final_order_date_CUSTOM_ErrorCount
          ,le.hazsub1_CUSTOM_ErrorCount
          ,le.hazsub2_CUSTOM_ErrorCount
          ,le.hazsub3_CUSTOM_ErrorCount
          ,le.hazsub4_CUSTOM_ErrorCount
          ,le.hazsub5_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Violation_Raw_hygiene(PROJECT(h, Violation_Raw_Layout));
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
          ,'activity_nr:' + getFieldTypeText(h.activity_nr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'citation_id:' + getFieldTypeText(h.citation_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'delete_flag:' + getFieldTypeText(h.delete_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'viol_type:' + getFieldTypeText(h.viol_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'issuance_date:' + getFieldTypeText(h.issuance_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'abate_date:' + getFieldTypeText(h.abate_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_penalty:' + getFieldTypeText(h.current_penalty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'initial_penalty:' + getFieldTypeText(h.initial_penalty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contest_date:' + getFieldTypeText(h.contest_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'final_order_date:' + getFieldTypeText(h.final_order_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nr_instances:' + getFieldTypeText(h.nr_instances) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nr_exposed:' + getFieldTypeText(h.nr_exposed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec:' + getFieldTypeText(h.rec) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gravity:' + getFieldTypeText(h.gravity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'emphasis:' + getFieldTypeText(h.emphasis) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hazcat:' + getFieldTypeText(h.hazcat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fta_insp_nr:' + getFieldTypeText(h.fta_insp_nr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fta_issuance_date:' + getFieldTypeText(h.fta_issuance_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fta_penalty:' + getFieldTypeText(h.fta_penalty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fta_contest_date:' + getFieldTypeText(h.fta_contest_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fta_final_order_date:' + getFieldTypeText(h.fta_final_order_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hazsub1:' + getFieldTypeText(h.hazsub1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hazsub2:' + getFieldTypeText(h.hazsub2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hazsub3:' + getFieldTypeText(h.hazsub3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hazsub4:' + getFieldTypeText(h.hazsub4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hazsub5:' + getFieldTypeText(h.hazsub5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_activity_nr_cnt
          ,le.populated_citation_id_cnt
          ,le.populated_delete_flag_cnt
          ,le.populated_viol_type_cnt
          ,le.populated_issuance_date_cnt
          ,le.populated_abate_date_cnt
          ,le.populated_current_penalty_cnt
          ,le.populated_initial_penalty_cnt
          ,le.populated_contest_date_cnt
          ,le.populated_final_order_date_cnt
          ,le.populated_nr_instances_cnt
          ,le.populated_nr_exposed_cnt
          ,le.populated_rec_cnt
          ,le.populated_gravity_cnt
          ,le.populated_emphasis_cnt
          ,le.populated_hazcat_cnt
          ,le.populated_fta_insp_nr_cnt
          ,le.populated_fta_issuance_date_cnt
          ,le.populated_fta_penalty_cnt
          ,le.populated_fta_contest_date_cnt
          ,le.populated_fta_final_order_date_cnt
          ,le.populated_hazsub1_cnt
          ,le.populated_hazsub2_cnt
          ,le.populated_hazsub3_cnt
          ,le.populated_hazsub4_cnt
          ,le.populated_hazsub5_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_activity_nr_pcnt
          ,le.populated_citation_id_pcnt
          ,le.populated_delete_flag_pcnt
          ,le.populated_viol_type_pcnt
          ,le.populated_issuance_date_pcnt
          ,le.populated_abate_date_pcnt
          ,le.populated_current_penalty_pcnt
          ,le.populated_initial_penalty_pcnt
          ,le.populated_contest_date_pcnt
          ,le.populated_final_order_date_pcnt
          ,le.populated_nr_instances_pcnt
          ,le.populated_nr_exposed_pcnt
          ,le.populated_rec_pcnt
          ,le.populated_gravity_pcnt
          ,le.populated_emphasis_pcnt
          ,le.populated_hazcat_pcnt
          ,le.populated_fta_insp_nr_pcnt
          ,le.populated_fta_issuance_date_pcnt
          ,le.populated_fta_penalty_pcnt
          ,le.populated_fta_contest_date_pcnt
          ,le.populated_fta_final_order_date_pcnt
          ,le.populated_hazsub1_pcnt
          ,le.populated_hazsub2_pcnt
          ,le.populated_hazsub3_pcnt
          ,le.populated_hazsub4_pcnt
          ,le.populated_hazsub5_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,26,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Violation_Raw_Delta(prevDS, PROJECT(h, Violation_Raw_Layout));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),26,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Violation_Raw_Layout) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_OSHAIR, Violation_Raw_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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

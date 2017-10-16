IMPORT SALT37;
EXPORT MBS_Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(MBS_Layout_MBS)
    UNSIGNED1 fdn_file_info_id_Invalid;
    UNSIGNED1 fdn_file_code_Invalid;
    UNSIGNED1 gc_id_Invalid;
    UNSIGNED1 file_type_Invalid;
    UNSIGNED1 description_Invalid;
    UNSIGNED1 primary_source_entity_Invalid;
    UNSIGNED1 ind_type_Invalid;
    UNSIGNED1 update_freq_Invalid;
    UNSIGNED1 expiration_days_Invalid;
    UNSIGNED1 post_contract_expiration_days_Invalid;
    UNSIGNED1 status_Invalid;
    UNSIGNED1 product_include_Invalid;
    UNSIGNED1 expectation_of_victim_entities_Invalid;
    UNSIGNED1 workflow_stage_committed_Invalid;
    UNSIGNED1 workflow_stage_detected_Invalid;
    UNSIGNED1 channels_Invalid;
    UNSIGNED1 threat_Invalid;
    UNSIGNED1 alert_level_Invalid;
    UNSIGNED1 entity_type_Invalid;
    UNSIGNED1 entity_sub_type_Invalid;
    UNSIGNED1 role_Invalid;
    UNSIGNED1 evidence_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(MBS_Layout_MBS)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(MBS_Layout_MBS) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.fdn_file_info_id_Invalid := MBS_Fields.InValid_fdn_file_info_id((SALT37.StrType)le.fdn_file_info_id);
    SELF.fdn_file_code_Invalid := MBS_Fields.InValid_fdn_file_code((SALT37.StrType)le.fdn_file_code);
    SELF.gc_id_Invalid := MBS_Fields.InValid_gc_id((SALT37.StrType)le.gc_id);
    SELF.file_type_Invalid := MBS_Fields.InValid_file_type((SALT37.StrType)le.file_type);
    SELF.description_Invalid := MBS_Fields.InValid_description((SALT37.StrType)le.description);
    SELF.primary_source_entity_Invalid := MBS_Fields.InValid_primary_source_entity((SALT37.StrType)le.primary_source_entity);
    SELF.ind_type_Invalid := MBS_Fields.InValid_ind_type((SALT37.StrType)le.ind_type);
    SELF.update_freq_Invalid := MBS_Fields.InValid_update_freq((SALT37.StrType)le.update_freq);
    SELF.expiration_days_Invalid := MBS_Fields.InValid_expiration_days((SALT37.StrType)le.expiration_days);
    SELF.post_contract_expiration_days_Invalid := MBS_Fields.InValid_post_contract_expiration_days((SALT37.StrType)le.post_contract_expiration_days);
    SELF.status_Invalid := MBS_Fields.InValid_status((SALT37.StrType)le.status);
    SELF.product_include_Invalid := MBS_Fields.InValid_product_include((SALT37.StrType)le.product_include);
    SELF.expectation_of_victim_entities_Invalid := MBS_Fields.InValid_expectation_of_victim_entities((SALT37.StrType)le.expectation_of_victim_entities);
    SELF.workflow_stage_committed_Invalid := MBS_Fields.InValid_workflow_stage_committed((SALT37.StrType)le.workflow_stage_committed);
    SELF.workflow_stage_detected_Invalid := MBS_Fields.InValid_workflow_stage_detected((SALT37.StrType)le.workflow_stage_detected);
    SELF.channels_Invalid := MBS_Fields.InValid_channels((SALT37.StrType)le.channels);
    SELF.threat_Invalid := MBS_Fields.InValid_threat((SALT37.StrType)le.threat);
    SELF.alert_level_Invalid := MBS_Fields.InValid_alert_level((SALT37.StrType)le.alert_level);
    SELF.entity_type_Invalid := MBS_Fields.InValid_entity_type((SALT37.StrType)le.entity_type);
    SELF.entity_sub_type_Invalid := MBS_Fields.InValid_entity_sub_type((SALT37.StrType)le.entity_sub_type);
    SELF.role_Invalid := MBS_Fields.InValid_role((SALT37.StrType)le.role);
    SELF.evidence_Invalid := MBS_Fields.InValid_evidence((SALT37.StrType)le.evidence);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),MBS_Layout_MBS);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.fdn_file_info_id_Invalid << 0 ) + ( le.fdn_file_code_Invalid << 1 ) + ( le.gc_id_Invalid << 2 ) + ( le.file_type_Invalid << 3 ) + ( le.description_Invalid << 4 ) + ( le.primary_source_entity_Invalid << 5 ) + ( le.ind_type_Invalid << 6 ) + ( le.update_freq_Invalid << 7 ) + ( le.expiration_days_Invalid << 8 ) + ( le.post_contract_expiration_days_Invalid << 9 ) + ( le.status_Invalid << 10 ) + ( le.product_include_Invalid << 11 ) + ( le.expectation_of_victim_entities_Invalid << 12 ) + ( le.workflow_stage_committed_Invalid << 13 ) + ( le.workflow_stage_detected_Invalid << 14 ) + ( le.channels_Invalid << 15 ) + ( le.threat_Invalid << 16 ) + ( le.alert_level_Invalid << 17 ) + ( le.entity_type_Invalid << 18 ) + ( le.entity_sub_type_Invalid << 19 ) + ( le.role_Invalid << 20 ) + ( le.evidence_Invalid << 21 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,MBS_Layout_MBS);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.fdn_file_info_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.fdn_file_code_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.gc_id_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.file_type_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.description_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.primary_source_entity_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.ind_type_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.update_freq_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.expiration_days_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.post_contract_expiration_days_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.status_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.product_include_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.expectation_of_victim_entities_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.workflow_stage_committed_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.workflow_stage_detected_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.channels_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.threat_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.alert_level_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.entity_type_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.entity_sub_type_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.role_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.evidence_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    fdn_file_info_id_ALLOW_ErrorCount := COUNT(GROUP,h.fdn_file_info_id_Invalid=1);
    fdn_file_code_ALLOW_ErrorCount := COUNT(GROUP,h.fdn_file_code_Invalid=1);
    gc_id_ALLOW_ErrorCount := COUNT(GROUP,h.gc_id_Invalid=1);
    file_type_ALLOW_ErrorCount := COUNT(GROUP,h.file_type_Invalid=1);
    description_ALLOW_ErrorCount := COUNT(GROUP,h.description_Invalid=1);
    primary_source_entity_ALLOW_ErrorCount := COUNT(GROUP,h.primary_source_entity_Invalid=1);
    ind_type_ALLOW_ErrorCount := COUNT(GROUP,h.ind_type_Invalid=1);
    update_freq_ALLOW_ErrorCount := COUNT(GROUP,h.update_freq_Invalid=1);
    expiration_days_ALLOW_ErrorCount := COUNT(GROUP,h.expiration_days_Invalid=1);
    post_contract_expiration_days_ALLOW_ErrorCount := COUNT(GROUP,h.post_contract_expiration_days_Invalid=1);
    status_ALLOW_ErrorCount := COUNT(GROUP,h.status_Invalid=1);
    product_include_ALLOW_ErrorCount := COUNT(GROUP,h.product_include_Invalid=1);
    expectation_of_victim_entities_ALLOW_ErrorCount := COUNT(GROUP,h.expectation_of_victim_entities_Invalid=1);
    workflow_stage_committed_ALLOW_ErrorCount := COUNT(GROUP,h.workflow_stage_committed_Invalid=1);
    workflow_stage_detected_ALLOW_ErrorCount := COUNT(GROUP,h.workflow_stage_detected_Invalid=1);
    channels_ALLOW_ErrorCount := COUNT(GROUP,h.channels_Invalid=1);
    threat_ALLOW_ErrorCount := COUNT(GROUP,h.threat_Invalid=1);
    alert_level_ALLOW_ErrorCount := COUNT(GROUP,h.alert_level_Invalid=1);
    entity_type_ALLOW_ErrorCount := COUNT(GROUP,h.entity_type_Invalid=1);
    entity_sub_type_ALLOW_ErrorCount := COUNT(GROUP,h.entity_sub_type_Invalid=1);
    role_ALLOW_ErrorCount := COUNT(GROUP,h.role_Invalid=1);
    evidence_ALLOW_ErrorCount := COUNT(GROUP,h.evidence_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT37.StrType ErrorMessage;
    SALT37.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.fdn_file_info_id_Invalid,le.fdn_file_code_Invalid,le.gc_id_Invalid,le.file_type_Invalid,le.description_Invalid,le.primary_source_entity_Invalid,le.ind_type_Invalid,le.update_freq_Invalid,le.expiration_days_Invalid,le.post_contract_expiration_days_Invalid,le.status_Invalid,le.product_include_Invalid,le.expectation_of_victim_entities_Invalid,le.workflow_stage_committed_Invalid,le.workflow_stage_detected_Invalid,le.channels_Invalid,le.threat_Invalid,le.alert_level_Invalid,le.entity_type_Invalid,le.entity_sub_type_Invalid,le.role_Invalid,le.evidence_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,MBS_Fields.InvalidMessage_fdn_file_info_id(le.fdn_file_info_id_Invalid),MBS_Fields.InvalidMessage_fdn_file_code(le.fdn_file_code_Invalid),MBS_Fields.InvalidMessage_gc_id(le.gc_id_Invalid),MBS_Fields.InvalidMessage_file_type(le.file_type_Invalid),MBS_Fields.InvalidMessage_description(le.description_Invalid),MBS_Fields.InvalidMessage_primary_source_entity(le.primary_source_entity_Invalid),MBS_Fields.InvalidMessage_ind_type(le.ind_type_Invalid),MBS_Fields.InvalidMessage_update_freq(le.update_freq_Invalid),MBS_Fields.InvalidMessage_expiration_days(le.expiration_days_Invalid),MBS_Fields.InvalidMessage_post_contract_expiration_days(le.post_contract_expiration_days_Invalid),MBS_Fields.InvalidMessage_status(le.status_Invalid),MBS_Fields.InvalidMessage_product_include(le.product_include_Invalid),MBS_Fields.InvalidMessage_expectation_of_victim_entities(le.expectation_of_victim_entities_Invalid),MBS_Fields.InvalidMessage_workflow_stage_committed(le.workflow_stage_committed_Invalid),MBS_Fields.InvalidMessage_workflow_stage_detected(le.workflow_stage_detected_Invalid),MBS_Fields.InvalidMessage_channels(le.channels_Invalid),MBS_Fields.InvalidMessage_threat(le.threat_Invalid),MBS_Fields.InvalidMessage_alert_level(le.alert_level_Invalid),MBS_Fields.InvalidMessage_entity_type(le.entity_type_Invalid),MBS_Fields.InvalidMessage_entity_sub_type(le.entity_sub_type_Invalid),MBS_Fields.InvalidMessage_role(le.role_Invalid),MBS_Fields.InvalidMessage_evidence(le.evidence_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.fdn_file_info_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fdn_file_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.gc_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.file_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.description_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.primary_source_entity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ind_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.update_freq_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.expiration_days_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.post_contract_expiration_days_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.product_include_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.expectation_of_victim_entities_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.workflow_stage_committed_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.workflow_stage_detected_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.channels_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.threat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alert_level_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.entity_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.entity_sub_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.role_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.evidence_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'fdn_file_info_id','fdn_file_code','gc_id','file_type','description','primary_source_entity','ind_type','update_freq','expiration_days','post_contract_expiration_days','status','product_include','expectation_of_victim_entities','workflow_stage_committed','workflow_stage_detected','channels','threat','alert_level','entity_type','entity_sub_type','role','evidence','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_alphanumeric','invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.fdn_file_info_id,(SALT37.StrType)le.fdn_file_code,(SALT37.StrType)le.gc_id,(SALT37.StrType)le.file_type,(SALT37.StrType)le.description,(SALT37.StrType)le.primary_source_entity,(SALT37.StrType)le.ind_type,(SALT37.StrType)le.update_freq,(SALT37.StrType)le.expiration_days,(SALT37.StrType)le.post_contract_expiration_days,(SALT37.StrType)le.status,(SALT37.StrType)le.product_include,(SALT37.StrType)le.expectation_of_victim_entities,(SALT37.StrType)le.workflow_stage_committed,(SALT37.StrType)le.workflow_stage_detected,(SALT37.StrType)le.channels,(SALT37.StrType)le.threat,(SALT37.StrType)le.alert_level,(SALT37.StrType)le.entity_type,(SALT37.StrType)le.entity_sub_type,(SALT37.StrType)le.role,(SALT37.StrType)le.evidence,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,22,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'fdn_file_info_id:invalid_numeric:ALLOW'
          ,'fdn_file_code:invalid_alphanumeric:ALLOW'
          ,'gc_id:invalid_numeric:ALLOW'
          ,'file_type:invalid_numeric:ALLOW'
          ,'description:invalid_alphanumeric:ALLOW'
          ,'primary_source_entity:invalid_numeric:ALLOW'
          ,'ind_type:invalid_numeric:ALLOW'
          ,'update_freq:invalid_numeric:ALLOW'
          ,'expiration_days:invalid_numeric:ALLOW'
          ,'post_contract_expiration_days:invalid_numeric:ALLOW'
          ,'status:invalid_numeric:ALLOW'
          ,'product_include:invalid_numeric:ALLOW'
          ,'expectation_of_victim_entities:invalid_numeric:ALLOW'
          ,'workflow_stage_committed:invalid_numeric:ALLOW'
          ,'workflow_stage_detected:invalid_numeric:ALLOW'
          ,'channels:invalid_numeric:ALLOW'
          ,'threat:invalid_numeric:ALLOW'
          ,'alert_level:invalid_numeric:ALLOW'
          ,'entity_type:invalid_numeric:ALLOW'
          ,'entity_sub_type:invalid_numeric:ALLOW'
          ,'role:invalid_numeric:ALLOW'
          ,'evidence:invalid_numeric:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,MBS_Fields.InvalidMessage_fdn_file_info_id(1)
          ,MBS_Fields.InvalidMessage_fdn_file_code(1)
          ,MBS_Fields.InvalidMessage_gc_id(1)
          ,MBS_Fields.InvalidMessage_file_type(1)
          ,MBS_Fields.InvalidMessage_description(1)
          ,MBS_Fields.InvalidMessage_primary_source_entity(1)
          ,MBS_Fields.InvalidMessage_ind_type(1)
          ,MBS_Fields.InvalidMessage_update_freq(1)
          ,MBS_Fields.InvalidMessage_expiration_days(1)
          ,MBS_Fields.InvalidMessage_post_contract_expiration_days(1)
          ,MBS_Fields.InvalidMessage_status(1)
          ,MBS_Fields.InvalidMessage_product_include(1)
          ,MBS_Fields.InvalidMessage_expectation_of_victim_entities(1)
          ,MBS_Fields.InvalidMessage_workflow_stage_committed(1)
          ,MBS_Fields.InvalidMessage_workflow_stage_detected(1)
          ,MBS_Fields.InvalidMessage_channels(1)
          ,MBS_Fields.InvalidMessage_threat(1)
          ,MBS_Fields.InvalidMessage_alert_level(1)
          ,MBS_Fields.InvalidMessage_entity_type(1)
          ,MBS_Fields.InvalidMessage_entity_sub_type(1)
          ,MBS_Fields.InvalidMessage_role(1)
          ,MBS_Fields.InvalidMessage_evidence(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.fdn_file_info_id_ALLOW_ErrorCount
          ,le.fdn_file_code_ALLOW_ErrorCount
          ,le.gc_id_ALLOW_ErrorCount
          ,le.file_type_ALLOW_ErrorCount
          ,le.description_ALLOW_ErrorCount
          ,le.primary_source_entity_ALLOW_ErrorCount
          ,le.ind_type_ALLOW_ErrorCount
          ,le.update_freq_ALLOW_ErrorCount
          ,le.expiration_days_ALLOW_ErrorCount
          ,le.post_contract_expiration_days_ALLOW_ErrorCount
          ,le.status_ALLOW_ErrorCount
          ,le.product_include_ALLOW_ErrorCount
          ,le.expectation_of_victim_entities_ALLOW_ErrorCount
          ,le.workflow_stage_committed_ALLOW_ErrorCount
          ,le.workflow_stage_detected_ALLOW_ErrorCount
          ,le.channels_ALLOW_ErrorCount
          ,le.threat_ALLOW_ErrorCount
          ,le.alert_level_ALLOW_ErrorCount
          ,le.entity_type_ALLOW_ErrorCount
          ,le.entity_sub_type_ALLOW_ErrorCount
          ,le.role_ALLOW_ErrorCount
          ,le.evidence_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.fdn_file_info_id_ALLOW_ErrorCount
          ,le.fdn_file_code_ALLOW_ErrorCount
          ,le.gc_id_ALLOW_ErrorCount
          ,le.file_type_ALLOW_ErrorCount
          ,le.description_ALLOW_ErrorCount
          ,le.primary_source_entity_ALLOW_ErrorCount
          ,le.ind_type_ALLOW_ErrorCount
          ,le.update_freq_ALLOW_ErrorCount
          ,le.expiration_days_ALLOW_ErrorCount
          ,le.post_contract_expiration_days_ALLOW_ErrorCount
          ,le.status_ALLOW_ErrorCount
          ,le.product_include_ALLOW_ErrorCount
          ,le.expectation_of_victim_entities_ALLOW_ErrorCount
          ,le.workflow_stage_committed_ALLOW_ErrorCount
          ,le.workflow_stage_detected_ALLOW_ErrorCount
          ,le.channels_ALLOW_ErrorCount
          ,le.threat_ALLOW_ErrorCount
          ,le.alert_level_ALLOW_ErrorCount
          ,le.entity_type_ALLOW_ErrorCount
          ,le.entity_sub_type_ALLOW_ErrorCount
          ,le.role_ALLOW_ErrorCount
          ,le.evidence_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,22,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT37.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT37.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;

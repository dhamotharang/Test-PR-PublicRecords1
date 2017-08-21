
EXPORT Filter := MODULE

	//Has text (not empty)
	SHARED BOOLEAN hasTxt(STRING str) := TRIM(str)<>'';
	//Has natural value
	SHARED BOOLEAN hasNat(UNSIGNED nbr) := nbr>0;

	EXPORT filterRecs(
    DATASET(FraudDefenseNetwork_Services.Layouts.Raw_Payload_rec) ds_raw_recs_in
  ) := FUNCTION

    fdrReportedDate := ds_raw_recs_in(IF(hasTxt(filterby_StartingReportedDate) AND hasTxt(filterby_EndingReportedDate), reported_date BETWEEN filterby_StartingReportedDate AND filterby_EndingReportedDate, IF(hasTxt(filterby_StartingReportedDate), reported_date >= filterby_StartingReportedDate, reported_date >= filterby_EndingReportedDate)));
		fdrEventDate := fdrReportedDate(IF(hasTxt(filterby_StartingEventDate) AND hasTxt(filterby_EndingEventDate), event_date BETWEEN filterby_StartingEventDate AND filterby_EndingEventDate, IF(hasTxt(filterby_StartingEventDate), event_date >= filterby_StartingEventDate, event_date >= filterby_EndingEventDate)));
		fdrDisposition := fdrEventDate(IF(hasTxt(filterby_Disposition), disposition=filterby_Disposition, disposition >= ''));			
		fdrMitigated := fdrDisposition(IF(hasTxt(filterby_Mitigated), mitigated=filterby_Mitigated, mitigated >=''));
		fdrNameType := fdrMitigated(IF(hasTxt(filterby_NameType), name_type=filterby_NameType, name_type >= ''));																														
		fdrState := fdrNameType(IF(hasTxt(filterby_State), State= filterby_State or clean_address.st= filterby_state, State >= ''));																														
		fdrPhoneNumber := fdrState(IF(hasTxt(filterby_PhoneNumber), Phone_Number = filterby_PhoneNumber, Phone_Number >= ''));																														
		fdrInService := fdrPhoneNumber(IF(hasTxt(filterby_InService), in_service= filterby_InService, in_service >= ''));
		fdrProfessionType := fdrInService(IF(hasTxt(filterby_ProfessionType), profession_type= filterby_ProfessionType, profession_type >= ''));
		fdrLicensedPrState := fdrProfessionType(IF(hasTxt(filterby_LicensedPrState), licensed_pr_state= filterby_LicensedPrState, licensed_pr_state >= ''));
		fdrSourceTypeId := fdrLicensedPrState(IF(hasNat(filterby_SourceTypeId), classification_source.source_type_id = filterby_SourceTypeId, classification_source.source_type_id >= 0));
		fdrPrimarySourceEntityId := fdrSourceTypeId(IF(hasNat(filterby_PrimarySourceEntityId), classification_source.primary_source_entity_id = filterby_PrimarySourceEntityId, classification_source.primary_source_entity_id >= 0));
		fdrExpectationOfVictimEntitiesId := fdrPrimarySourceEntityId(IF(hasNat(filterby_ExpectationOfVictimEntitiesId), classification_source.expectation_of_victim_entities_id = filterby_ExpectationOfVictimEntitiesId, classification_source.expectation_of_victim_entities_id >= 0));
		fdrIndustrySegment := fdrExpectationOfVictimEntitiesId(IF(hasTxt(filterby_IndustrySegment), classification_source.industry_segment = filterby_IndustrySegment, classification_source.industry_segment >= ''));
		fdrSuspectedDiscrepancyId := fdrIndustrySegment(IF(hasNat(filterby_SuspectedDiscrepancyId), classification_activity.suspected_discrepancy_id = filterby_SuspectedDiscrepancyId, classification_activity.suspected_discrepancy_id >= 0));
		fdrConfidenceThatActivityWasDeceitfulId := fdrSuspectedDiscrepancyId(IF(hasNat(filterby_ConfidenceThatActivityWasDeceitfulId), classification_activity.confidence_that_activity_was_deceitful_id = filterby_ConfidenceThatActivityWasDeceitfulId, classification_activity.confidence_that_activity_was_deceitful_id >= 0));
		fdrWorkflowStageCommittedId := fdrConfidenceThatActivityWasDeceitfulId(IF(hasNat(filterby_WorkflowStageCommittedId), classification_activity.workflow_stage_committed_id = filterby_WorkflowStageCommittedId, classification_activity.workflow_stage_committed_id >= 0)); 		
		fdrWorkflowStageDetectedId := fdrWorkflowStageCommittedId(IF(hasNat(filterby_WorkflowStageDetectedId), classification_activity.workflow_stage_detected_id = filterby_WorkflowStageDetectedId, classification_activity.workflow_stage_detected_id >= 0));																															
		fdrChannelsId := fdrWorkflowStageDetectedId(IF(hasNat(filterby_ChannelsId), classification_activity.channels_id = filterby_ChannelsId, classification_activity.channels_id >= 0));
		fdrCategoryOrFraudtype := fdrChannelsId(IF(hasTxt(filterby_CategoryOrFraudtype), classification_activity.category_or_fraudtype = filterby_CategoryOrFraudtype, classification_activity.category_or_fraudtype >= ''));
		fdrThreatId := fdrCategoryOrFraudtype(IF(hasNat(filterby_ThreatId), classification_activity.threat_id = filterby_ThreatId, classification_activity.threat_id >= 0));
		fdrAlertLevelId := fdrThreatId(IF(hasNat(filterby_AlertLevelId), classification_activity.alert_level_id = filterby_AlertLevelId, classification_activity.alert_level_id >= 0));	
		fdrEntityTypeId := fdrAlertLevelId(IF(hasNat(filterby_EntityTypeId), classification_entity.entity_type_id = filterby_EntityTypeId, classification_entity.entity_type_id >= 0));
		fdrEntitySubTypeId := fdrEntityTypeId(IF(hasNat(filterby_EntitySubTypeId), classification_entity.entity_sub_type_id = filterby_EntitySubTypeId, classification_entity.entity_sub_type_id >= 0));																															
		fdrRoleId := fdrEntitySubTypeId(IF(hasNat(filterby_RoleId), classification_entity.role_id = filterby_RoleId, classification_entity.role_id >= 0));																															
		fdrEvidenceId := fdrRoleId(IF(hasNat(filterby_EvidenceId), classification_entity.evidence_id = filterby_EvidenceId, classification_entity.evidence_id >= 0));																															
		fdrFileType := fdrEvidenceId(IF(hasNat(filterby_FileType), classification_permissible_use_access.file_type = filterby_FileType, classification_permissible_use_access.file_type >= 0));																															
		fdrDid := fdrFileType(IF(hasNat(filterby_Did), (did=filterby_Did), did >= 0));
			
		// Output(fdrEventDate,named('fdrEventDate'));
		// Output(fdrNameType,named('fdrNameType'));
		// Output(fdrState,named('fdrState'));
		// Output(fdrPhoneNumber,named('fdrPhoneNumber'));
		// Output(fdrInService,named('fdrInService'));
		// Output(ds_raw_recs_in,named('ds_raw_recs_in'));
		// Output(fdrDid,named('fdrDid'));
		RETURN fdrDid;
	END;
		
END;
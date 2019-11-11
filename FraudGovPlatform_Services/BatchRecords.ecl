IMPORT FraudShared_Services, FraudGovPlatform_Services, IDLexternalLinking, InsuranceHeader_xlink, SALT37;

EXPORT BatchRecords(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
										FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION
		
		ds_payload := FraudGovPlatform_Services.Raw_Records(ds_batch_in, batch_params, isBatch:=TRUE);
		
		//**
		//** Velocities goes here
		//**
		ds_payload_IDDT := ds_payload(classification_Permissible_use_access.file_type = FraudGovPlatform_Services.Constants.PayloadFileTypeEnum.IdentityActivity);
		ds_Velocities := FraudGovPlatform_Services.Functions.getVelocityRecs(ds_batch_in, batch_params, ds_payload_IDDT);

		ds_batch_in_knfd := PROJECT(ds_batch_in, TRANSFORM(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw,
																									SELF.batchin_rec := LEFT;
																									SELF := LEFT;
																									SELF := [];
																									));
																													
		//**
		//** Validate input LexIDs
		//**
		ds_batch_in_didValidation := IDLexternalLinking.did_getAllRecs_batch(ds_batch_in_knfd,batchin_rec.did,acctno);

		//**
		//** Assemble the pieces
		//**
		
		
		ds_results_w_velocities := DENORMALIZE(ds_batch_in_knfd, ds_Velocities, 
																						LEFT.acctno = RIGHT.acctno,
																						GROUP,
																						FraudGovPlatform_Services.Transforms.xfm_w_velocities(LEFT, ROWS(RIGHT)),
																						LEFT OUTER);
																						
    ds_results_w_velocities_validDids := JOIN(ds_results_w_velocities,ds_batch_in_didValidation,
																							LEFT.acctno = RIGHT.acctno AND Right.did > 0,
																							TRANSFORM(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw,
																												SELF.identity_resolved := IF(RIGHT.did <> 0, 'Y', 'N'),
																												SELF := LEFT),
																							LEFT OUTER,
																							KEEP(1),
																							LIMIT(0));
		
		//Creating the tree_uid and entity_context_uid for fetching scores from kel keys. 
		ds_entityNameUID := PROJECT(ds_results_w_velocities_validDids, 
													TRANSFORM(FraudGovPlatform_Services.Layouts.elementNidentity_uid_recs,
														SELF.acctno := LEFT.acctno,
														SELF.entity_name := FraudGovPlatform_Services.Constants.Fragment_Types.PERSON_FRAGMENT, 
														SELF.entity_value := (string) LEFT.LexID,
														SELF.tree_uid := FraudGovPlatform_Services.Constants.KelEntityIdentifier._LEXID + (string) LEFT.LexID;
														SELF := []));

		/* Returning Score for records for which identity_resolved = Y*/
		ds_raw_cluster_recs := FraudGovPlatform_Services.Functions.getClusterDetails(ds_entityNameUID, batch_params, TRUE);
		ds_cluster_recs_scores := ds_raw_cluster_recs(entity_context_uid_ = tree_uid_);

																
		ds_results_w_scores := JOIN(ds_results_w_velocities_validDids, ds_cluster_recs_scores, 
																LEFT.acctno = RIGHT.acctno,
																	TRANSFORM(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw, 
																		SELF.risk_score := RIGHT.Score_,
																		SELF.risk_level := FraudGovPlatform_Services.Utilities.GetRiskLevel(RIGHT.Score_),
																		SELF := LEFT),
																		LEFT OUTER
																);
																
		ds_realtime_recs := JOIN(ds_results_w_velocities_validDids(identity_resolved = 'Y'), ds_cluster_recs_scores, 
																LEFT.acctno = RIGHT.acctno,
																	TRANSFORM(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw, 
																		SELF.identity_resolved := FraudGovPlatform_Services.Constants.IDENTITY_RESOLVED_REALTIME;
																		SELF := LEFT),
																		LEFT ONLY
																);
																
		
		ds_batch_w_ExternalServices := IF(EXISTS(ds_realtime_recs(batchin_rec.did > 0)),
																			FraudGovPlatform_Services.Functions.getExternalServicesRecs(ds_batch_in, batch_params),
																			DATASET([], FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw));
																			
		ds_realtime_recs_w_externalServices := JOIN(ds_realtime_recs, ds_batch_w_ExternalServices, 
																								LEFT.acctno = RIGHT.acctno,
																								TRANSFORM(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw,
																								  SELF.batchin_rec := LEFT.batchin_rec,
																									SELF.identity_resolved := LEFT.identity_resolved,
																									SELF := RIGHT));
		
		ds_realtime_w_score := IF(EXISTS(ds_realtime_recs_w_externalServices(batchin_rec.did > 0)),
															FraudGovPlatform_Services.mod_RealTimeScoring(ds_realtime_recs_w_externalServices, batch_params).ds_w_realTimeScore,
															DATASET([],FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw));
		
		ds_results := JOIN(ds_results_w_scores, ds_realtime_w_score,
															LEFT.acctno = RIGHT.acctno,
															TRANSFORM(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw,
																				SELF.risk_score := IF(RIGHT.identity_resolved = FraudGovPlatform_Services.Constants.IDENTITY_RESOLVED_REALTIME,
																															RIGHT.risk_score,
																															LEFT.risk_score),
																				SELF.risk_level := IF(RIGHT.identity_resolved = FraudGovPlatform_Services.Constants.IDENTITY_RESOLVED_REALTIME,
																															FraudGovPlatform_Services.Utilities.GetRiskLevel(RIGHT.risk_score),
																															FraudGovPlatform_Services.Utilities.GetRiskLevel(LEFT.risk_score)),
																				SELF.identity_resolved := IF(RIGHT.identity_resolved = FraudGovPlatform_Services.Constants.IDENTITY_RESOLVED_REALTIME,
																																		 RIGHT.identity_resolved, 
																																		 LEFT.identity_resolved),
																				SELF.childRecs_Velocities := LEFT.childRecs_Velocities,
																				SELF := IF(RIGHT.identity_resolved = FraudGovPlatform_Services.Constants.IDENTITY_RESOLVED_REALTIME,RIGHT,LEFT)),
															LEFT OUTER);
		
		// OUTPUT(ds_reportFromBatchServices,named('ds_reportFromBatchServices'));
		// OUTPUT(ds_batch_in_didTest,named('ds_batch_in_didTest'));
		// OUTPUT(ds_batch_in_didTest_dedup,named('ds_batch_in_didTest_dedup'));
		// OUTPUT(ds_reportFromBatchServices_validDids,named('ds_reportFromBatchServices_validDids'));
		
		// OUTPUT(ds_raw_cluster_recs,named('ds_raw_cluster_recs'));
		// OUTPUT(ds_cluster_recs_scores,named('ds_cluster_recs_scores'));
		
		// OUTPUT(ds_results_w_scores,named('ds_results_w_scores'));
		// OUTPUT(ds_realtime_recs,named('ds_realtime_recs'));
		
		return ds_results;
		
END;
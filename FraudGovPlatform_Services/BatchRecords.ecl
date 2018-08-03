IMPORT FraudShared_Services, FraudGovPlatform_Services;

EXPORT BatchRecords(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
										FraudGovPlatform_Services.IParam.BatchParams batch_params) := MODULE

		//**
		//** Collect external batch services data if IsOnline is FALSE
		//**
		SHARED ds_reportFromBatchServices := IF(~batch_params.IsOnline,
																						FraudGovPlatform_Services.Functions.getExternalServicesRecs(ds_batch_in, batch_params),
																						PROJECT(ds_batch_in,TRANSFORM(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw,
																																				SELF.batchin_rec := LEFT,
																																				SELF := [])
																									)
																						);
		
		//**
		EXPORT ds_payload := FraudGovPlatform_Services.Raw_Records(ds_batch_in, batch_params.GlobalCompanyId, batch_params.IndustryType, batch_params.ProductCode);
		//**
		
		//**
		//** Known Frauds
		//**
		SHARED ds_payload_KNFD := ds_payload(classification_Permissible_use_access.file_type = FraudGovPlatform_Services.Constants.PayloadFileTypeEnum.KnownFraud); 
		SHARED ds_reportKnownFrauds := FraudGovPlatform_Services.Functions.getKnownFraudRecs(ds_batch_in, batch_params, ds_payload_KNFD);

		//**
		//** Velocities goes here
		//**
		SHARED ds_payload_IDDT := ds_payload(classification_Permissible_use_access.file_type = FraudGovPlatform_Services.Constants.PayloadFileTypeEnum.IdentityActivity);
		SHARED ds_Velocities := FraudGovPlatform_Services.Functions.getVelocityRecs(ds_batch_in, batch_params, ds_payload_IDDT);

		//**
		//** Assemble the pieces
		//**
		FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw xfm_w_knownfraud(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw  L,
																																				  FraudGovPlatform_Services.Layouts.KnownFrauds_rec R) := TRANSFORM

			SELF.childRecs_KnownFrauds_raw := PROJECT(R, TRANSFORM(FraudGovPlatform_Services.Layouts.KnownFrauds_rec, SELF := LEFT));
			SELF := L;
			SELF := [];
		END;

		ds_w_known_frauds := JOIN(ds_reportFromBatchServices, ds_reportKnownFrauds,
														LEFT.acctno = RIGHT.acctno,
														xfm_w_knownfraud(LEFT,RIGHT),
														LEFT OUTER);
														
		FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw xfm_w_velocities(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw L,
																																				   DATASET(FraudGovPlatform_Services.Layouts.velocities) R) := TRANSFORM
			SELF.LexID := L.batchin_rec.did;
			SELF.identity_resolved := IF(L.batchin_rec.did <> 0 , 'Y', 'N');			
			SELF.batchin_rec := L;
			SELF.childRecs_Velocities := R;
			SELF := L; 
			SELF := [];
		END;
		
		ds_results_w_velocities := DENORMALIZE(ds_w_known_frauds, ds_Velocities, 
																						LEFT.acctno = RIGHT.acctno,
																						GROUP,
																						xfm_w_velocities(LEFT, ROWS(RIGHT)),
																						LEFT OUTER);

		//Creating the tree_uid and entity_context_uid for fetching scores from kel keys. 
		ds_entityNameUID := PROJECT(ds_results_w_velocities(identity_resolved = 'Y'), 
													TRANSFORM(FraudGovPlatform_Services.Layouts.elementNidentity_uid_recs,
														SELF.acctno := LEFT.acctno,
														SELF.entity_name := FraudGovPlatform_Services.Constants.Fragment_Types.PERSON_FRAGMENT, 
														SELF.entity_value := (string) LEFT.LexID,
														// SELF.record_id := '';
														SELF.tree_uid := FraudGovPlatform_Services.Constants.KelEntityIdentifier._LEXID + (string) LEFT.LexID;
														SELF.entity_context_uid := FraudGovPlatform_Services.Constants.KelEntityIdentifier._LEXID + (string) LEFT.LexID,
														SELF := []));

		/* Returning Score for records for which identity_resolved = Y*/
		ds_raw_cluster_recs := FraudGovPlatform_Services.Functions.getClusterDetails(ds_entityNameUID, batch_params, FALSE);
		ds_cluster_recs_scores := ds_raw_cluster_recs(entity_context_uid_ = tree_uid_);

		ds_results_w_scores := JOIN(ds_results_w_velocities, ds_cluster_recs_scores, 
																LEFT.acctno = RIGHT.acctno,
																	TRANSFORM(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw, 
																		SELF.risk_score := RIGHT.Score_,
																		SELF.risk_level := FraudGovPlatform_Services.Utilities.GetRiskLevel(RIGHT.Score_),
																		SELF := LEFT),
																		LEFT OUTER
																);
		
		EXPORT ds_results := ds_results_w_scores;
END;
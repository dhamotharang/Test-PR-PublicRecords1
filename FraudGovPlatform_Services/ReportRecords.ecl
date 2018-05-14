IMPORT DidVille, FraudShared_Services, iesp, Royalty;

EXPORT ReportRecords(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
                     FraudGovPlatform_Services.IParam.BatchParams batch_params,
										 INTEGER MaxVelocities,
										 INTEGER MaxKnownFrauds,
										 BOOLEAN IsIdentityTestRequest,
										 BOOLEAN IsElementTestRequest) := MODULE
                
		SHARED ds_batch := FraudGovPlatform_Services.BatchRecords(ds_batch_in, batch_params);
		
		SHARED all_knownfrauds := FraudGovPlatform_Services.Functions.getKnownFrauds(ds_batch);
		SHARED fdn_knownfrauds := all_knownfrauds(event_type = 'FDN');
		
		//Getting all the known frauds
		knownfraud_temp_rec := RECORD
				INTEGER KnownRiskCount := COUNT(GROUP);
				DATASET(iesp.share.t_StringArrayItem) KnownRiskReasons := PROJECT(all_knownfrauds, TRANSFORM({iesp.share.t_StringArrayItem}, SELF.value := LEFT.known_risk_reason));
		END;

		SHARED all_knownfrauds_slimmed := TABLE(all_knownfrauds, knownfraud_temp_rec);
		SHARED all_knownfrauds_final := PROJECT(all_knownfrauds_slimmed, TRANSFORM(iesp.fraudgovreport.t_FraudGovKnownRisk,
																																					SELF.KnownRiskCount := LEFT.KnownRiskCount,
																																					SELF.KnownRiskReasons := CHOOSEN(LEFT.KnownRiskReasons, MaxKnownFrauds)));
		
		/* Filling up IdentityCardDetails && GovernmentBest for IDENTITY record. */
			//* For A Lexid that is provided as input *//
		ds_dids := PROJECT(ds_batch_in (did > 0) , TRANSFORM(DidVille.Layout_Did_OutBatch, SELF.Seq := COUNTER, SELF.did := LEFT.did, SELF := []));
		ds_GovBest := FraudGovPlatform_Services.Functions.getGovernmentBest(ds_dids, batch_params)[1];
		ds_contributoryBest := FraudGovPlatform_Services.Functions.getContributedBest(ds_dids, FraudGovPlatform_Services.Constants.FRAUD_PLATFORM)[1];
		
		
		
    iesp.fraudgovreport.t_FraudGovRecord xform_response() := TRANSFORM
      SELF.RiskScore := ds_batch[1].risk_score;
      SELF.RiskLevel := ds_batch[1].risk_level;
      SELF.IdentityResolved := ds_batch[1].identity_resolved;
      SELF.LexID := ds_batch[1].lexid;

      SELF.Deceased := ROW(FraudGovPlatform_Services.Transforms.xform_deceased(ds_batch.childRecs_Death[1]));
			
      SELF.Criminals :=	PROJECT(CHOOSEN(ds_batch.childRecs_Criminal, iesp.constants.FraudGov.MAX_COUNT_CRIMINAL), 
																						FraudGovPlatform_Services.Transforms.xform_criminal(LEFT, COUNTER));

      SELF.RedFlags :=	PROJECT(CHOOSEN(ds_batch.childRecs_RedFlag, iesp.constants.FraudGov.MAX_COUNT_RED_FLAG),
																						FraudGovPlatform_Services.Transforms.xform_red_flag(LEFT));
																											
      SELF.GlobalWatchlists :=	PROJECT(CHOOSEN(ds_batch.childRecs_Patriot, iesp.constants.FraudGov.MAX_COUNT_GLOBAL_WATCHLIST), 
																						FraudGovPlatform_Services.Transforms.xform_global_watchlist(LEFT, COUNTER));
																															
      SELF.Velocities :=	PROJECT(CHOOSEN(ds_batch.childRecs_velocities, MaxVelocities),
																						FraudGovPlatform_Services.Transforms.xform_velocities(LEFT));
			
			SELF.KnownRisks := all_knownfrauds_final;

			SELF.IdentityCardDetails := PROJECT(ds_contributoryBest	, TRANSFORM(LEFT));
			SELF.GovernmentBest := PROJECT(ds_GovBest, TRANSFORM(LEFT));

			SELF := [];
		END;
	  	
	  SELF.KnownRisks := all_knownfrauds_final;
	  
	  //If either test flags are set, return mock data, if not, then return empty dataset until we get the RAMPS query
	  SELF.IndicatorAttributes := IF(IsIdentityTestRequest OR IsElementTestRequest,
	  								fn_GetTestRecords.GetTestIndicatorAttributes(),
									DATASET([],iesp.fraudgovreport.t_FraudGovIndicatorAttribute));

	  SELF.ScoreBreakdown := IF(IsIdentityTestRequest OR IsElementTestRequest,
	  								fn_GetTestRecords.GetTestScoreBreakdowns(),
									DATASET([],iesp.fraudgovreport.t_FraudGovScoreBreakdown));

	  SELF.AssociatedIdentities := IF(IsElementTestRequest,
	  								fn_GetTestRecords.GetTestAssociatedIdentities(),
									DATASET([],iesp.fraudgovreport.t_FraudGovIdentityCardDetails));
	  
	  SELF.AssociatedAddresses := IF(IsIdentityTestRequest OR IsElementTestRequest,
	  								fn_GetTestRecords.GetTestAssociatedAddresses(),
									DATASET([],iesp.fraudgovreport.t_FraudGovAssociatedAddress));

	  SELF.RelatedClusters := IF(IsIdentityTestRequest OR IsElementTestRequest,
	  							fn_GetTestRecords.GetTestClusters(),
								DATASET([],iesp.fraudgovreport.t_FraudGovClusterCardDetails));

	  SELF.TimeLineDetails := IF(IsIdentityTestRequest OR IsElementTestRequest,
	  							fn_GetTestRecords.GetTestTimelineDetails(),
								DATASET([],iesp.fraudgovreport.t_FraudGovTimeLineDetails));

	  SELF := [];
	END;
		
		EXPORT esdl_out := DATASET([xform_response()]);
		EXPORT ds_royalties := Royalty.RoyaltyFDNCoRR.GetOnlineRoyalties(fdn_knownfrauds, true);
END;
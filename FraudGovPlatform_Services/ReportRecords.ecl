IMPORT FraudShared_Services, iesp;

EXPORT ReportRecords(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
                     FraudGovPlatform_Services.IParam.BatchParams batch_params,
										 INTEGER MaxVelocities,
										 INTEGER MaxKnownFrauds) := FUNCTION
                
		ds_batch := FraudGovPlatform_Services.BatchRecords(ds_batch_in, batch_params);
		
		all_knownfrauds := FraudGovPlatform_Services.Functions.getKnownFrauds(ds_batch);
		
		//Getting all the known frauds
		knownfraud_temp_rec := RECORD
				INTEGER KnownRiskCount := COUNT(GROUP);
				DATASET(iesp.share.t_StringArrayItem) KnownRiskReasons := PROJECT(all_knownfrauds, TRANSFORM({iesp.share.t_StringArrayItem}, SELF.value := LEFT.known_risk_reason));
		END;

		all_knownfrauds_slimmed := TABLE(all_knownfrauds, knownfraud_temp_rec);
		all_knownfrauds_final := PROJECT(all_knownfrauds_slimmed, TRANSFORM(iesp.fraudgovplatform.t_FraudGovKnownRisk,
																																					SELF.KnownRiskCount := LEFT.KnownRiskCount,
																																					SELF.KnownRiskReasons := CHOOSEN(LEFT.KnownRiskReasons, MaxKnownFrauds)));

    iesp.fraudgovplatform.t_FraudGovRecord xform_response() := TRANSFORM
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
																															
      SELF.VelocityCounts :=	PROJECT(CHOOSEN(ds_batch.childRecs_velocities, MaxVelocities),
																						FraudGovPlatform_Services.Transforms.xform_velocities(LEFT));
			
			SELF.KnownRisks := all_knownfrauds_final;
		END;
     
		// output(MaxVelocities, named('MaxVelocities'));
		// output(MaxKnownFrauds, named('MaxKnownFrauds'));
		// output(all_knownfrauds_final, named('all_knownfrauds_final'));
		
		esdl_out := DATASET([xform_response()]);
                                                                                                                                                               
   RETURN esdl_out;
	 
END;
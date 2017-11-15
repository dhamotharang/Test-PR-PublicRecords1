IMPORT FraudShared_Services, iesp;

EXPORT ReportRecords(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
                     FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION
                
    ds_batch := FraudGovPlatform_Services.BatchRecords(ds_batch_in, batch_params);

    iesp.fraudgovplatform.t_FraudGovRecord xform_response() := TRANSFORM
      SELF.RiskScore := ds_batch[1].risk_score;
      SELF.RiskLevel := ds_batch[1].risk_level;
      SELF.IdentityResolved := ds_batch[1].identity_resolved;
      SELF.LexID := ds_batch[1].lexid;
      SELF.Deceased := ROW(FraudGovPlatform_Services.Transforms.xform_deceased(ds_batch.childRecs_Death[1]));
      SELF.Criminals := PROJECT(CHOOSEN(ds_batch.childRecs_Criminal, iesp.constants.FraudGov.MAX_COUNT_CRIMINAL), 
																											FraudGovPlatform_Services.Transforms.xform_criminal(LEFT, COUNTER));
      SELF.RedFlags := PROJECT(CHOOSEN(ds_batch.childRecs_RedFlag, iesp.constants.FraudGov.MAX_COUNT_RED_FLAG),
																											FraudGovPlatform_Services.Transforms.xform_red_flag(LEFT));
      SELF.GlobalWatchlists := PROJECT(CHOOSEN(ds_batch.childRecs_Patriot, iesp.constants.FraudGov.MAX_COUNT_GLOBAL_WATCHLIST), 
																																		FraudGovPlatform_Services.Transforms.xform_global_watchlist(LEFT, COUNTER));
      SELF.VelocityCounts := PROJECT(CHOOSEN(ds_batch.childRecs_velocities, iesp.constants.FraudGov.MAX_COUNT_VELOCITY), 
																																	FraudGovPlatform_Services.Transforms.xform_velocities(LEFT));
      SELF.KnownRisks := PROJECT(CHOOSEN(ds_batch.childRecs_KnownFrauds_raw, iesp.Constants.FraudGov.MAX_COUNT_KNOWN_RISK), 
																													FraudGovPlatform_Services.Transforms.xform_known_frauds(LEFT));
   END; //transform
     
			esdl_out := DATASET([xform_response()]);
                                                                                                                                                               
   RETURN esdl_out;
END;


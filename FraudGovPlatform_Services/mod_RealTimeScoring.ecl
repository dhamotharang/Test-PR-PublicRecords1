IMPORT BatchShare, FraudGovPlatform_Analytics, FraudGovPlatform_Services;

EXPORT mod_RealTimeScoring(DATASET(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw) ds_in, 
																FraudGovPlatform_services.IParam.BatchParams batch_params) := MODULE
	
		scoringInput := FraudGovPlatform_Analytics.Functions.projectToEventScoringLayout(ds_in, batch_params);
		
		//Step 3. Append the weights and UI descriptions - these are the indicator attributes that need to be returned in 
		EXPORT WeightedResult := (FraudGovPlatform_Analytics.BasicScoringFunctions.MacWeightedResult(scoringInput))(RiskLevel != -1);

		//Step 4. Compute the score breakdown aggregates - this is the score breakdown that will need to be returned as well
		EXPORT ScoreBreakdownAggregate := FraudGovPlatform_Analytics.BasicScoringFunctions.MacScoreBreakdownAggregate(WeightedResult, 'acctno,lexid');

		//Step 5. Get the event risk score - this is the dynamic score
		EventScore := FraudGovPlatform_Analytics.BasicScoringFunctions.MacCalculateScore(ScoreBreakdownAggregate,'acctno,lexid');

		//Step 6. Join Back to the 'roxieInput' to append the score
		EXPORT ds_w_realTimeScore := JOIN(ds_in, EventScore,
			LEFT.acctno = RIGHT.acctno,
			TRANSFORM(RECORDOF(LEFT),
				SELF.risk_score := RIGHT.score,
				SELF.risk_level := FraudGovPlatform_Services.Utilities.GetRiskLevel(RIGHT.score),
				SELF.lexid := RIGHT.lexid;
				SELF := LEFT),
			LEFT OUTER);
			
END;
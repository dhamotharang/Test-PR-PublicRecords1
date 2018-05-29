IMPORT DidVille, FraudShared_Services, iesp, Royalty, std;

EXPORT ReportRecords(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
                     FraudGovPlatform_Services.IParam.BatchParams batch_params,
										 INTEGER MaxVelocities,
										 INTEGER MaxKnownFrauds,
										 BOOLEAN IsIdentityTestRequest,
										 BOOLEAN IsElementTestRequest) := MODULE
										 
		SHARED BOOLEAN returnMockupData := IsIdentityTestRequest OR IsElementTestRequest;
                
		SHARED ds_batch := FraudGovPlatform_Services.BatchRecords(ds_batch_in, batch_params).ds_results_w_velocities;
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
		
		/* Filling up the Element Card for Element record*/
			//* For A Element that's passed as input to report service. *//
		ds_payload := FraudGovPlatform_Services.BatchRecords(ds_batch_in, batch_params).ds_payload;	
		
		File_Type_Const := FraudGovPlatform_Services.Constants.PayloadFileTypeEnum;
		TodaysDate := std.date.today();
		YesterdayDate := TodaysDate - 1;		

		ds_batch_in_extended := PROJECT(ds_batch_in, FraudShared_Services.Layouts.BatchInExtended_rec);
		
		ds_fragment_recs_w_value := FraudGovPlatform_Services.Functions.GetFragmentRecs(ds_batch_in_extended, ds_payload, batch_params);

		FraudGovPlatform_Services.Layouts.fragment_w_value_recs do_Rollup(FraudGovPlatform_Services.Layouts.fragment_w_value_recs L, dataset(FraudGovPlatform_Services.Layouts.fragment_w_value_recs) R) := TRANSFORM
			identity_recs := R(file_type = File_Type_Const.IdentityActivity);
			knownrisk_recs := R(file_type = File_Type_Const.KnownFraud);
			SELF.LastActivityDate := MAX(identity_recs[1].date);
			SELF.LastKnownRiskDate := MAX(knownrisk_recs[1].date);
			SELF := L;
		END;	

		ds_fragment_recs_sorted := SORT(ds_fragment_recs_w_value, fragment_value, fragment, file_type -date);
		ds_fragment_recs_grouped := GROUP(ds_fragment_recs_sorted, fragment_value, fragment);
		ds_fragment_recs_rolled := ROLLUP(ds_fragment_recs_grouped, GROUP, do_Rollup(LEFT, ROWS(LEFT)));		
		
		ds_ElementCardDetails := PROJECT(ds_fragment_recs_rolled, TRANSFORM(iesp.fraudgovreport.t_FraudGovElementCardDetails, 
																																SELF.ScoreDetails.RecordType := FraudGovPlatform_Services.Constants.RecordType.ELEMENT,
																																SELF.ScoreDetails.ElementType := LEFT.fragment,
																																SELF.ScoreDetails.ElementValue := LEFT.fragment_value,
																																// SELF.ScoreDetails.Score := , to be filled in later when analytics keys are available.
																																SELF := [];
																																))[1];
																																
		//* Returning the Timeline Data */
		ds_timeline := PROJECT(ds_payload, FraudGovPlatform_Services.Transforms.xform_timeline_details(LEFT));
																																
		//* Transforming the report response, by assembling all the pieces together */
		iesp.fraudgovreport.t_FraudGovRecord xform_response() := TRANSFORM
			SELF.RiskScore := ds_batch[1].risk_score;
			SELF.RiskLevel := ds_batch[1].risk_level;
			SELF.IdentityResolved := ds_batch[1].identity_resolved;
			SELF.LexID := ds_batch[1].lexid;

			SELF.Deceased := IF(batch_params.IsOnline, 
													ROW(FraudGovPlatform_Services.Transforms.xform_deceased(ds_batch.childRecs_Death[1])),
													ROW([], iesp.fraudgovreport.t_FraudGovDeceased));
			
			SELF.Criminals :=	IF(batch_params.IsOnline, 
													PROJECT(CHOOSEN(ds_batch.childRecs_Criminal, iesp.constants.FraudGov.MAX_COUNT_CRIMINAL), 
														FraudGovPlatform_Services.Transforms.xform_criminal(LEFT, COUNTER)),
													DATASET([], iesp.fraudgovreport.t_FraudGovCriminal));

			SELF.RedFlags :=	IF(batch_params.IsOnline, 
													PROJECT(CHOOSEN(ds_batch.childRecs_RedFlag, iesp.constants.FraudGov.MAX_COUNT_RED_FLAG), 
														FraudGovPlatform_Services.Transforms.xform_red_flag(LEFT)),
													DATASET([], iesp.fraudgovreport.t_FraudGovRedFlag));
													
			SELF.GlobalWatchlists :=	IF(batch_params.IsOnline, 
																	PROJECT(CHOOSEN(ds_batch.childRecs_Patriot, iesp.constants.FraudGov.MAX_COUNT_GLOBAL_WATCHLIST),
																		FraudGovPlatform_Services.Transforms.xform_global_watchlist(LEFT, COUNTER)),
																	DATASET([], iesp.fraudgovreport.t_FraudGovGlobalWatchlist));
																															
			SELF.Velocities :=	IF(batch_params.IsOnline, 
														PROJECT(CHOOSEN(ds_batch.childRecs_velocities, MaxVelocities), 
															FraudGovPlatform_Services.Transforms.xform_velocities(LEFT)),
														DATASET([], iesp.fraudgovreport.t_FraudGovVelocity));
			
			SELF.KnownRisks := IF(batch_params.IsOnline, 
														all_knownfrauds_final, 
														DATASET([], iesp.fraudgovreport.t_FraudGovKnownRisk));

			SELF.IdentityCardDetails := IF(batch_params.IsOnline, 
																		ds_contributoryBest, 
																		ROW([], iesp.fraudgovreport.t_FraudGovIdentityCardDetails));

			SELF.GovernmentBest := IF(batch_params.IsOnline, 
																PROJECT(ds_GovBest, TRANSFORM(LEFT)), 
																ROW([], iesp.fraudgovplatform.t_FraudGovBestInfo));
																
			SELF.ElementCardDetails := ds_ElementCardDetails;

			//If either test flags are set, return mock data, if not, then return empty dataset until we get the RAMPS query
			SELF.IndicatorAttributes := IF(batch_params.IsOnline AND returnMockupData,
																		fn_GetTestRecords.GetTestIndicatorAttributes(),
																		DATASET([],iesp.fraudgovreport.t_FraudGovIndicatorAttribute));

			SELF.ScoreBreakdown := IF(batch_params.IsOnline AND returnMockupData,
																fn_GetTestRecords.GetTestScoreBreakdowns(),
																DATASET([],iesp.fraudgovreport.t_FraudGovScoreBreakdown));

			SELF.AssociatedIdentities := IF(batch_params.IsOnline AND IsElementTestRequest,
																			fn_GetTestRecords.GetTestAssociatedIdentities(),
																			DATASET([],iesp.fraudgovreport.t_FraudGovIdentityCardDetails));
			
			SELF.AssociatedAddresses := IF(batch_params.IsOnline AND returnMockupData,
																			fn_GetTestRecords.GetTestAssociatedAddresses(),
																			DATASET([],iesp.fraudgovreport.t_FraudGovAssociatedAddress));

			SELF.RelatedClusters := IF(batch_params.IsOnline AND returnMockupData,
																	fn_GetTestRecords.GetTestClusters(),
																	DATASET([],iesp.fraudgovreport.t_FraudGovClusterCardDetails));

			SELF.TimeLineDetails := IF(batch_params.IsOnline,
																CHOOSEN(ds_timeline, iesp.constants.FraudGov.MAX_COUNT_TIMELINE_DETAILS),
																DATASET([],iesp.fraudgovreport.t_FraudGovTimeLineDetails));
			SELF := [];
		END;
		
		// output(ds_batch_in, named('ds_batch_in'));
		// output(ds_batch, named('ds_batch'));
		// output(all_knownfrauds, named('all_knownfrauds'));
		// output(all_knownfrauds_final, named('all_knownfrauds_final'));
		// output(ds_batch.childRecs_velocities, named('childRecs_velocities'));
		// output(ds_payload, named('ds_payload__ReportRecords'));
		// output(ds_fragment_recs_w_value, named('ds_fragment_recs_w_value'));
		// output(ds_fragment_recs_sorted, named('ds_fragment_recs_sorted'));
		// output(ds_fragment_recs_grouped, named('ds_fragment_recs_grouped'));
		// output(ds_fragment_recs_rolled, named('ds_fragment_recs_rolled'));
		
		EXPORT esdl_out := DATASET([xform_response()]);
		EXPORT ds_royalties := Royalty.RoyaltyFDNCoRR.GetOnlineRoyalties(fdn_knownfrauds, true);
END;
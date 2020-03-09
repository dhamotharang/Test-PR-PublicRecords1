IMPORT DeathV2_Services, DidVille, FraudShared, FraudShared_Services, iesp, Royalty;

EXPORT ReportRecords(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_in,
                     FraudGovPlatform_Services.IParam.BatchParams batch_params,
										 BOOLEAN IsIdentityTestRequest,
										 BOOLEAN IsElementTestRequest) := MODULE
										 
		SHARED FraudGovConst_ := FraudGovPlatform_Services.Constants;
		SHARED FraudGovKelConst_ := FraudGovConst_.KEL_ENTITY_TYPE;
		SHARED FraudGovFragConst_ := FraudGovConst_.Fragment_Types;
		SHARED File_Type_Const := FraudGovConst_.PayloadFileTypeEnum;		

		/* For A Element that's passed as input to report service. */
		ds_payload_raw := FraudGovPlatform_Services.Raw_Records(ds_in, batch_params);
		
		//Filter payload records which do not have same routing number as input. 
		ds_bank_routing_number_ids := FraudShared.Key_BankRoutingNumber(batch_params.FraudPlatform)
																		(KEYED(bank_routing_number = ds_in[1].bank_routing_number));
		
		SHARED ds_payload := IF(batch_params.IsOnline AND ds_in[1].bank_routing_number <> '',
														JOIN(ds_payload_raw, ds_bank_routing_number_ids,
															LEFT.record_id = RIGHT.record_id,
															TRANSFORM(LEFT)),
														ds_payload_raw);
		//**
		//** Velocities goes here
		//**
		ds_payload_IDDT := ds_payload(classification_Permissible_use_access.file_type = FraudGovPlatform_Services.Constants.PayloadFileTypeEnum.IdentityActivity);
		ds_Velocities := FraudGovPlatform_Services.Functions.getVelocityRecs(ds_in, batch_params, ds_payload_IDDT);

		//**
		//** Assemble the pieces
		//**
		ds_batch_in_knfd := PROJECT(ds_in, TRANSFORM(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw,
																									SELF.batchin_rec := LEFT;
																									SELF := LEFT;
																									SELF := [];
																									));
														
		SHARED ds_w_velocities := DENORMALIZE(ds_batch_in_knfd, ds_Velocities, 
																						LEFT.acctno = RIGHT.acctno,
																						GROUP,
																						FraudGovPlatform_Services.Transforms.xfm_w_velocities(LEFT, ROWS(RIGHT)),
																						LEFT OUTER);
																				
		SHARED ds_batch_in_extended := PROJECT(ds_in, FraudShared_Services.Layouts.BatchInExtended_rec);
		
		ds_fragment_recs_w_value := FraudGovPlatform_Services.Functions.GetFragmentRecs(ds_batch_in_extended, ds_payload, batch_params);

		FraudGovPlatform_Services.Layouts.fragment_w_value_recs do_Rollup(FraudGovPlatform_Services.Layouts.fragment_w_value_recs L, dataset(FraudGovPlatform_Services.Layouts.fragment_w_value_recs) R) := TRANSFORM
			identity_recs := R(file_type = File_Type_Const.IdentityActivity);
			knownrisk_recs := R(file_type = File_Type_Const.KnownFraud);
			SELF.LastActivityDate := identity_recs[1].date;
			SELF.LastKnownRiskDate := knownrisk_recs[1].date;
			SELF := L;
		END;	

		ds_fragment_recs_sorted := SORT(ds_fragment_recs_w_value, fragment_value, fragment, file_type, -date);
		ds_fragment_recs_grouped := GROUP(ds_fragment_recs_sorted, fragment_value, fragment);
		
		SHARED ds_fragment_recs_rolled := ROLLUP(ds_fragment_recs_grouped, GROUP, do_Rollup(LEFT, ROWS(LEFT)));
	
		SHARED ds_entityNameUID := IF(batch_params.IsOnline, 
																	FraudGovPlatform_Services.Utilities.getAnalyticsUID(ds_fragment_recs_rolled),
																	FraudGovPlatform_Services.Utilities.getAnalyticsUID(ds_fragment_recs_rolled(fragment=FraudGovPlatform_Services.Constants.Fragment_Types.PERSON_FRAGMENT)));

		/* Returning Element or Identity Score and related clusters and related identities. */
		SHARED ds_raw_cluster_recs := FraudGovPlatform_Services.Functions.getClusterDetails(ds_entityNameUID, batch_params, FALSE);

		/* Getting the element and identity socre where Identity or Element is center of their cluster. */
		SHARED ds_cluster_recs_scores := ds_raw_cluster_recs(entity_context_uid_ = tree_uid_);
		
		SHARED ds_api_results_w_scores := JOIN(ds_w_velocities, ds_cluster_recs_scores(entity_name=FraudGovFragConst_.PERSON_FRAGMENT), 
																LEFT.acctno = RIGHT.acctno,
																	TRANSFORM(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw, 
																		SELF.risk_score := RIGHT.Score_,
																		SELF.risk_level := FraudGovPlatform_Services.Utilities.GetRiskLevel(RIGHT.Score_),
																		SELF := LEFT),
																		LEFT OUTER
																);
																				
		ds_delta_recentActivity := FraudGovPlatform_Services.mod_Deltabase_Functions(batch_params).getDeltabaseReportRecords(ds_batch_in_extended);

		SHARED ds_recentTransactions_sorted := IF(batch_params.IsOnline AND batch_params.UseAllSearchFields,
																	SORT(ds_delta_recentActivity(UniqueId = (STRING)ds_in[1].did),-eventDate.year, -eventDate.Month, -eventDate.day),
																	SORT(ds_delta_recentActivity,-eventDate.year, -eventDate.Month, -eventDate.day));
																	
		/* Returning the Timeline Data */
		ds_timeline := PROJECT(ds_payload, FraudGovPlatform_Services.Transforms.xform_timeline_details(LEFT)) + ds_recentTransactions_sorted;
		SHARED ds_timeline_sorted := SORT(ds_timeline, -IsRecentActivity, FileType, -ReportedDateTime.Year,-ReportedDateTime.Month, 
																-ReportedDateTime.Day,-ReportedDateTime.Hour24,-ReportedDateTime.Minute,-ReportedDateTime.Second,
																-EventDate.Year, -EventDate.Month, -EventDate.Day,
																record);
																
		first_recentActivity_date := FraudGovPlatform_Services.Functions.GetLastRecentActivityDate();
		
		/*GRP-3682: New recent transactions definition is last 30 days (including Deltabase and payload) */
		SHARED numOfDeltabaseTransactions := COUNT(ds_timeline_sorted(iesp.ECL2ESP.DateToInteger(ReportedDateTime) > first_recentActivity_date));	
		
		SHARED ds_ElementcardDetail_w_score := JOIN(ds_fragment_recs_rolled, ds_cluster_recs_scores,
																			LEFT.fragment = RIGHT.entity_name AND
																			LEFT.fragment_value = RIGHT.entity_value, 
																			TRANSFORM(iesp.fraudgovreport.t_FraudGovElementCardDetails, 
																				SELF.ScoreDetails.RecordType := FraudGovConst_.RecordType.ELEMENT,
																				SELF.ScoreDetails.ElementType := LEFT.fragment,
																				SELF.ScoreDetails.ElementValue := MAP(LEFT.fragment = FraudGovFragConst_.PHYSICAL_ADDRESS_FRAGMENT 
																																								=> FraudGovPlatform_Services.Functions.GetCleanAddressFragmentValue(LEFT.fragment_value),
																																							LEFT.fragment = FraudGovFragConst_.BANK_ACCOUNT_NUMBER_FRAGMENT
																																								=> FraudGovPlatform_Services.Functions.GetCleanFragmentValue(LEFT.fragment_value, 2),
																																							LEFT.fragment = FraudGovFragConst_.DRIVERS_LICENSE_NUMBER_FRAGMENT
																																								=> FraudGovPlatform_Services.Functions.GetCleanFragmentValue(LEFT.fragment_value, 1),
																																							LEFT.fragment_value);
																				SELF.ScoreDetails.Score := RIGHT.Score_,
																				SELF.NoOfIdentities := (integer) RIGHT.flags(indicator = 'identity_count_')[1].value,
																				SELF.NoOfRecentTransactions := numOfDeltabaseTransactions,
																				SELF.NoOfClusters := COUNT(ds_raw_cluster_recs( entity_name = LEFT.fragment AND  
																																												entity_value = LEFT.fragment_value)),
																				SELF.LastActivityDate := IF(numOfDeltabaseTransactions = 0,
																											iesp.ECL2ESP.toDate(LEFT.LastActivityDate),
																											ds_recentTransactions_sorted[1].EventDate),
																				SELF.ElementNVPs := PROJECT(RIGHT.flags, TRANSFORM(iesp.share.t_NameValuePair,
																																									SELF.Name := LEFT.indicator,
																																									SELF.Value := LEFT.value))),
																				LIMIT(FraudGovConst_.Limits.MAX_JOIN_LIMIT, SKIP));
																				
		/* Getting the related clusters */
		ds_cluster_proj := PROJECT(ds_raw_cluster_recs, 
												TRANSFORM(FraudGovPlatform_Services.Layouts.elementNidentity_uid_recs,
													SELF.entity_name := LEFT.entity_name,
													SELF.entity_value := LEFT.entity_value,
													SELF.tree_uid := LEFT.tree_uid_,
													SELF.entity_context_uid := LEFT.entity_context_uid_,
													SELF.acctno := '',
													SELF.record_id := 0));
																										
		ds_cluster_details := FraudGovPlatform_Services.Functions.getClusterDetails(ds_cluster_proj, batch_params, TRUE);
		
		/* Getting the element and identity socre where Identity or Element is center of their cluster. */
		SHARED ds_center_clusterdetails := ds_cluster_details(tree_uid_ = entity_context_uid_);
		
		ds_related_clusters := PROJECT(ds_center_clusterdetails, 
														TRANSFORM(iesp.fraudgovreport.t_FraudGovClusterCardDetails,
															SELF.AnalyticsRecordId := LEFT.tree_uid_,
															SELF.ScoreDetails.RecordType := FraudGovConst_.RecordType.CLUSTER,
															SELF.ScoreDetails.ElementType := 
																MAP(LEFT.entity_type_ = FraudGovKelConst_.ENTITY_TYPE_LEXID => FraudGovFragConst_.PERSON_FRAGMENT,
																		LEFT.entity_type_ = FraudGovKelConst_.ENTITY_TYPE_PHYSICAL_ADDRESS => FraudGovFragConst_.PHYSICAL_ADDRESS_FRAGMENT,
																		LEFT.entity_type_ = FraudGovKelConst_.ENTITY_TYPE_SSN => FraudGovFragConst_.SSN_FRAGMENT,
																		LEFT.entity_type_ = FraudGovKelConst_.ENTITY_TYPE_PHONENO => FraudGovFragConst_.PHONE_FRAGMENT,
																		LEFT.entity_type_ = FraudGovKelConst_.ENTITY_TYPE_IPADDRESS => FraudGovFragConst_.IP_ADDRESS_FRAGMENT,
																		LEFT.entity_type_ = FraudGovKelConst_.ENTITY_TYPE_EMAIL=> FraudGovFragConst_.EMAIL_FRAGMENT,
																		LEFT.entity_type_ = FraudGovKelConst_.ENTITY_TYPE_BANKACCOUNT=> FraudGovFragConst_.BANK_ACCOUNT_NUMBER_FRAGMENT,
																		LEFT.entity_type_ = FraudGovKelConst_.ENTITY_TYPE_DLNUMBER=> FraudGovFragConst_.DRIVERS_LICENSE_NUMBER_FRAGMENT,
																		''), 
															SELF.ScoreDetails.ElementValue := IF(	LEFT.entity_type_ = FraudGovKelConst_.ENTITY_TYPE_LEXID,
																																		LEFT.tree_uid_[4..],
																																		LEFT.label_), 
															SELF.ScoreDetails.Score := LEFT.cluster_score_,
															SELF.NoOfIdentities := (integer) LEFT.flags(indicator = 'cl_identity_count_')[1].value,
															SELF.ClusterName := LEFT.label_,
															SELF.ClusterNVPs := PROJECT(LEFT.flags, 
																										TRANSFORM(iesp.share.t_NameValuePair,
																											SELF.Name := LEFT.indicator,
																											SELF.Value := LEFT.value))
																			));
		
		SHARED ds_related_clusters_sorted := SORT(ds_related_clusters, -ScoreDetails.Score, ScoreDetails.ElementValue, -NoOfIdentities, RECORD);
		
		/* Getting the related identities*/			
		SHARED ds_associated_identities_raw := ds_center_clusterdetails(entity_type_ = FraudGovKelConst_.ENTITY_TYPE_LEXID);
		
		ds_associated_identities_dids := PROJECT(ds_associated_identities_raw,  
																			TRANSFORM(FraudShared_Services.Layouts.BatchIn_rec,
																				//[4..] because Entitiy Context uid in RAMPS/KEL keys has following format for lexid
																				// Calculation goes like => '_01' + DID_Value.
																				SELF.DID := (unsigned6) LEFT.entity_context_uid_[4..],
																				SELF := []));

		/* Returning IdentityCardDetails & GovernmentBest for IDENTITY record. */
		/* For A Lexid that is provided as input + Related Identities.*/
		ds_combined_non_zero_dids := (ds_in + ds_associated_identities_dids)(did > 0);
		ds_combined_dids := DEDUP(SORT(ds_combined_non_zero_dids, did), did);
		SHARED ds_dids := PROJECT(ds_combined_dids, TRANSFORM(DidVille.Layout_Did_OutBatch, 
																					SELF.Seq := COUNTER, 
																					SELF.did := LEFT.did, 
																					SELF := []));
		SHARED ds_GovBest := FraudGovPlatform_Services.Functions.getGovernmentBest(ds_dids, batch_params);
		SHARED ds_contributoryBest := FraudGovPlatform_Services.Functions.getContributedBest(ds_dids, FraudGovConst_.FRAUD_PLATFORM, batch_params);
		
		SHARED IsRealTime := IF(batch_params.IsOnline, 
										batch_params.UseAllSearchFields, 
										ds_api_results_w_scores[1].identity_resolved = 'Y' AND NOT EXISTS(ds_contributoryBest) AND 
										(ds_ElementcardDetail_w_score[1].ScoreDetails.ElementType = FraudGovConst_.Fragment_Types.PERSON_FRAGMENT
										OR ds_ElementcardDetail_w_score[1].ScoreDetails.ElementType = ''));
		/*
			Following function returns the Dummy Government Information when Options.AppendBest is set to False,
			This will help Sales/Product folks to not show actual PII info when demo'ing the MVP to customers. 
			More details can be found at https://jira.rsi.lexisnexis.com/browse/GRP-1025
		*/
		
		/* Append scores to ds_contributoryBest */	
		ds_contributoryBest_w_scores := JOIN(ds_contributoryBest, ds_associated_identities_raw,
																			LEFT.ContributedBest.UniqueId	= RIGHT.entity_context_uid_[4..], 
																			TRANSFORM(iesp.fraudgovreport.t_FraudGovIdentityCardDetails,
																				SELF.ScoreDetails.RecordType := FraudGovConst_.RecordType.IDENTITY,
																				SELF.ScoreDetails.ElementType := FraudGovFragConst_.PERSON_FRAGMENT, 
																				SELF.ScoreDetails.ElementValue := LEFT.ContributedBest.UniqueId, 
																				SELF.ScoreDetails.Score := RIGHT.score_,
																				SELF := LEFT),
																			LEFT OUTER, LIMIT(FraudGovConst_.Limits.MAX_JOIN_LIMIT, SKIP));
		
		SHARED ds_contributoryBest_w_scores_sorted := SORT(ds_contributoryBest_w_scores, -ScoreDetails.Score, ScoreDetails.ElementValue, 
																									 RECORD);
		
		SHARED ds_dummyGovBest := FraudGovPlatform_Services.fn_GetTestRecords.GetDummyGovBestInfo(ds_contributoryBest);
		
	  SHARED ds_batch_w_ExternalServices := IF(IsRealTime,FraudGovPlatform_Services.Functions.getExternalServicesRecs(ds_in, batch_params),
																							DATASET([], FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw));
																							
		SHARED ds_death := MAP(batch_params.IsOnline AND ~IsRealTime => FraudGovPlatform_Services.Raw(ds_in, batch_params).GetDeath(),
													batch_params.IsOnline AND IsRealTime => ds_batch_w_ExternalServices[1].childrecs_death,
													DATASET([],DeathV2_Services.layouts.BatchOut));
																						
		SHARED ds_realtime_tmp := FraudGovPlatform_Services.mod_RealTimeScoring(ds_batch_w_ExternalServices, batch_params);

		SHARED ds_indicatorAttributes_realtime_raw := ds_realtime_tmp.WeightedResult;
		SHARED ds_scoreBreakdown_realtime_raw := ds_realtime_tmp.ScoreBreakdownAggregate;
		SHARED ds_realtimeScore_raw := ds_realtime_tmp.ds_w_realTimeScore;
		
		ds_realtime := PROJECT(ds_realtimeScore_raw,TRANSFORM(iesp.fraudgovreport.t_FraudGovIdentityCardDetails,
																				SELF.ScoreDetails.RecordType := FraudGovConst_.RecordType.IDENTITY,
																				SELF.ScoreDetails.ElementType := FraudGovFragConst_.PERSON_FRAGMENT, 
																				SELF.ScoreDetails.ElementValue := (STRING)LEFT.lexid, 
																				SELF.ScoreDetails.Score := LEFT.risk_score,
																				SELF := []));
		
		/* Returning the Associated Address Data  - This is based on the Timeline Records found above */
		ds_associated_addresses := FraudGovPlatform_Services.Functions.getAssociatedAddresses(ds_payload);
		
		/* Returning the Indicator Attributes */
		ds_indicator_attribute_raw :=	FraudGovPlatform_Services.Functions.GetIndicatorAttributes(ds_entityNameUID, batch_params);
		
		ds_indicator_attribute := PROJECT(ds_indicator_attribute_raw,iesp.fraudgovreport.t_FraudGovIndicatorAttribute);
																
																																							
		ds_indicator_attribute_realtime := PROJECT(ds_indicatorAttributes_realtime_raw,TRANSFORM(iesp.fraudgovreport.t_FraudGovIndicatorAttribute,
																																							SELF.IndicatorTypeCode := LEFT.indicatortype,
																																							SELF.IndicatorTypeDescription := LEFT.indicatordescription,
																																							SELF.DataType := LEFT.fieldtype,
																																							SELF.RiskLevel := (STRING)LEFT.risklevel,
																																							SELF.DescriptionCode := LEFT.field,
																																							SELF.Description := LEFT.label,
																																							SELF.DescriptionValue := LEFT.value,
																																							SELF.EventDate.Year := 0,
																																							SELF.EventDate.Month := 0,
																																							SELF.EventDate.Day := 0));
		
		/* Returning the Score Breakdown for Online Report */
		ds_score_breakdown := FraudGovPlatform_Services.Functions.GetScoreBreakDown(ds_entityNameUID, batch_params);
														
		ds_score_breakdown_realtime := PROJECT(ds_scoreBreakdown_realtime_raw, TRANSFORM(iesp.fraudgovreport.t_FraudGovScoreBreakdown,
																																							SELF.IndicatorTypeCode := LEFT.indicatortype,
																																							SELF.IndicatorTypeDescription := LEFT.IndicatorDescription,
																																							SELF.RiskLevel := (STRING)LEFT.risklevel,
																																							SELF.PopulationType := LEFT.populationtype,
																																							SELF.Value := LEFT.value));
																																							
		/*  Getting all the known frauds */
		indicator_attribute_for_kfnd := ds_indicator_attribute(IndicatorTypeCode IN ['KR','ID']);
		knownfraud_temp_rec := RECORD
				INTEGER KnownRiskCount := COUNT(GROUP);
				DATASET(iesp.share.t_StringArrayItem) KnownRiskReasons := PROJECT(indicator_attribute_for_kfnd, TRANSFORM({iesp.share.t_StringArrayItem}, SELF.value := LEFT.Description));
		END;

		ds_contrib_known_frauds_slimmed := TABLE(indicator_attribute_for_kfnd, knownfraud_temp_rec);
		
		ds_contrib_known_frauds_final := PROJECT(ds_contrib_known_frauds_slimmed, 
																			TRANSFORM(iesp.fraudgovreport.t_FraudGovKnownRisk,
																				SELF.KnownRiskCount := LEFT.KnownRiskCount,
																				SELF.KnownRiskReasons := CHOOSEN(LEFT.KnownRiskReasons, batch_params.MaxKnownFrauds)));
																				
		/*  Getting all the known frauds for real-time */
		knownfraud_rt_temp_rec := RECORD
				INTEGER KnownRiskCount := COUNT(GROUP);
				DATASET(iesp.share.t_StringArrayItem) KnownRiskReasons := PROJECT(ds_indicator_attribute_realtime, TRANSFORM({iesp.share.t_StringArrayItem}, SELF.value := LEFT.Description));
		END;

		ds_rt_known_frauds_slimmed := TABLE(ds_indicator_attribute_realtime, knownfraud_rt_temp_rec);
		
		ds_rt_known_frauds_final := PROJECT(ds_rt_known_frauds_slimmed, 
																			TRANSFORM(iesp.fraudgovreport.t_FraudGovKnownRisk,
																				SELF.KnownRiskCount := LEFT.KnownRiskCount,
																				SELF.KnownRiskReasons := CHOOSEN(LEFT.KnownRiskReasons, batch_params.MaxKnownFrauds)));
																				
		all_knownfrauds_final := IF(isRealTime, ds_rt_known_frauds_final, ds_contrib_known_frauds_final);

		/* Transforming the report response, by assembling all the pieces together */
		iesp.fraudgovreport.t_FraudGovRecord xform_response() := TRANSFORM
			SELF.RiskScore := IF(~IsRealTime, ds_api_results_w_scores[1].risk_score, ds_realtimeScore_raw[1].risk_score);
			SELF.RiskLevel := IF(~IsRealTime, ds_api_results_w_scores[1].risk_level, ds_realtimeScore_raw[1].risk_level);
			SELF.IdentityResolved := IF(~IsRealTime,ds_api_results_w_scores[1].identity_resolved,FraudGovConst_.IDENTITY_RESOLVED_REALTIME);
			SELF.LexID := ds_api_results_w_scores[1].lexid;

			SELF.Deceased := ROW(FraudGovPlatform_Services.Transforms.xform_deceased(ds_death[1]));
			
			SELF.Criminals :=	IF(~batch_params.IsOnline,
													PROJECT(CHOOSEN(ds_api_results_w_scores.childRecs_Criminal, batch_params.MaxCriminals),
																		FraudGovPlatform_Services.Transforms.xform_criminal(LEFT, COUNTER)),
													DATASET([], iesp.fraudgovreport.t_FraudGovCriminal));

			SELF.RedFlags := IF(~batch_params.IsOnline,
												PROJECT(CHOOSEN(ds_api_results_w_scores.childRecs_RedFlag, batch_params.MaxRedFlags), 
																	FraudGovPlatform_Services.Transforms.xform_red_flag(LEFT)),
												DATASET([], iesp.fraudgovreport.t_FraudGovRedFlag));
													
			SELF.GlobalWatchlists := IF(~batch_params.IsOnline, 
																	PROJECT(CHOOSEN(ds_api_results_w_scores.childRecs_Patriot, batch_params.MaxGlobalWatchlists),
																					FraudGovPlatform_Services.Transforms.xform_global_watchlist(LEFT, COUNTER)),
																	DATASET([], iesp.fraudgovreport.t_FraudGovGlobalWatchlist));
																															
			SELF.Velocities :=	IF(~batch_params.IsOnline, 
														PROJECT(CHOOSEN(ds_api_results_w_scores.childRecs_velocities, batch_params.MaxVelocities), 
																		FraudGovPlatform_Services.Transforms.xform_velocities(LEFT)),
														DATASET([], iesp.fraudgovreport.t_FraudGovVelocity));
			
			SELF.KnownRisks := IF(~batch_params.IsOnline, all_knownfrauds_final, DATASET([], iesp.fraudgovreport.t_FraudGovKnownRisk));

			SELF.IdentityCardDetails := MAP(batch_params.IsOnline AND IsRealTime => ds_realtime[1],
																			batch_params.IsOnline AND ~IsRealTime => 
																				ds_contributoryBest_w_scores_sorted(ContributedBest.UniqueId = (STRING)ds_in[1].did)[1],
																		ROW([], iesp.fraudgovreport.t_FraudGovIdentityCardDetails));
			
			SELF.GovernmentBest := IF(batch_params.IsOnline,
																IF(batch_params.AppendBest OR IsRealTime,
																		ds_GovBest(UniqueId = (STRING)ds_in[1].did)[1],
																		ds_dummyGovBest(UniqueId = (STRING)ds_in[1].did)[1]),
																ROW([], iesp.fraudgovplatform.t_FraudGovBestInfo));
																
			SELF.ElementCardDetails := IF(batch_params.IsOnline, ds_ElementcardDetail_w_score[1] , ROW([], iesp.fraudgovreport.t_FraudGovElementCardDetails));

			SELF.IndicatorAttributes := MAP(batch_params.IsOnline AND IsRealTime => 
																				CHOOSEN(ds_indicator_attribute_realtime, batch_params.MaxIndicatorAttributes),
																			batch_params.IsOnline AND ~IsRealTime => 
																				CHOOSEN(ds_indicator_attribute, batch_params.MaxIndicatorAttributes),
																		DATASET([],iesp.fraudgovreport.t_FraudGovIndicatorAttribute));

			SELF.ScoreBreakdown := MAP(batch_params.IsOnline AND IsRealTime =>
																		CHOOSEN(ds_score_breakdown_realtime, batch_params.MaxScoreBreakdown),
																batch_params.IsOnline AND ~IsRealTime =>
																		CHOOSEN(ds_score_breakdown,batch_params.MaxScoreBreakdown),
																DATASET([],iesp.fraudgovreport.t_FraudGovScoreBreakdown));

			SELF.AssociatedIdentities := IF(batch_params.IsOnline AND ~IsRealTime,
																			CHOOSEN(ds_contributoryBest_w_scores_sorted, batch_params.MaxAssociatedIdentities),
																			DATASET([],iesp.fraudgovreport.t_FraudGovIdentityCardDetails));
			
			SELF.AssociatedAddresses := IF(batch_params.IsOnline AND ~IsRealTime,
																			CHOOSEN(ds_associated_addresses, batch_params.MaxAssociatedAddresses),
																			DATASET([],iesp.fraudgovreport.t_FraudGovAssociatedAddress));

			SELF.RelatedClusters := IF(batch_params.IsOnline AND ~IsRealTime, 
																	CHOOSEN(ds_related_clusters_sorted, batch_params.MaxRelatedClusters),
																	DATASET([],iesp.fraudgovreport.t_FraudGovClusterCardDetails));
																
			SELF.TimeLineDetails := MAP(batch_params.IsOnline  AND ~IsRealTime => 
																					CHOOSEN(ds_timeline_sorted, batch_params.MaxTimelineDetails), 
																 batch_params.IsOnline  AND IsRealTime =>
																					CHOOSEN(ds_recentTransactions_sorted, batch_params.MaxTimelineDetails),
																DATASET([],iesp.fraudgovreport.t_FraudGovTimeLineDetails));
		END;
		
		// output(batch_params,named('batch_params'));
		// output(ds_in,named('ds_in'));
		// output(ds_w_velocities,named('ds_w_velocities'));
		// output(ds_recentTransactions_sorted,named('ds_recentTransactions_sorted'));
		// output(ds_batch_w_ExternalServices,named('ds_batch_w_ExternalServices'));
		// output(ds_realtimeScore_raw,named('ds_realtimeScore'));
		// output(ds_realtime,named('ds_realtime'));
		// output(ds_indicator_attribute,named('ds_indicator_attribute'));
		// output(ds_score_breakdown_realtime,named('ds_score_breakdown_realtime'));
		// output(ds_in, named('ds_in'));
		// output(ds_batch, named('ds_batch'));
		// output(all_knownfrauds, named('all_knownfrauds'));
		// output(all_knownfrauds_final, named('all_knownfrauds_final'));
		// output(ds_batch.childRecs_velocities, named('childRecs_velocities'));
		// output(ds_payload, named('ds_payload__ReportRecords'));
		// output(ds_fragment_recs_w_value, named('ds_fragment_recs_w_value'));
		// output(ds_fragment_recs_sorted, named('ds_fragment_recs_sorted'));
		// output(ds_fragment_recs_grouped, named('ds_fragment_recs_grouped'));
		// output(ds_fragment_recs_rolled, named('ds_fragment_recs_rolled'));
		// output(ds_entityNameUID, named('ds_entityNameUID'));
		// output(ds_raw_cluster_recs, named('ds_raw_cluster_recs'));
		// output(ds_cluster_recs_scores, named('ds_cluster_recs_scores'));
		// output(ds_ElementcardDetail_w_score, named('ds_ElementcardDetail_w_score'));
		// output(ds_cluster_proj, named('ds_cluster_proj'));
		// output(ds_cluster_details, named('ds_cluster_details'));
		// output(ds_center_clusterdetails, named('ds_center_clusterdetails'));
		// output(ds_related_clusters, named('ds_related_clusters'));
		// output(ds_dids, named('ds_dids'));
		// output(ds_GovBest, named('ds_GovBest'));
		// output(ds_contributoryBest, named('ds_contributoryBest'));
		// output(ds_dummyGovBest, named('ds_dummyGovBest'));
		// output(ds_associated_identities_raw, named('ds_associated_identities_raw'));
		// output(ds_contributoryBest_w_scores, named('ds_contributoryBest_w_scores'));
		// output(ds_timeline_sorted, named('ds_timeline_sorted'));
		// output(ds_associated_addresses, named('ds_associated_addresses'));
		
		EXPORT esdl_out := DATASET([xform_response()]);
		
		fdn_knownfrauds := DATASET([],iesp.fraudgovreport.t_FraudGovKnownRisk);
		EXPORT ds_royalties := Royalty.RoyaltyFDNCoRR.GetOnlineRoyalties(fdn_knownfrauds, true);
END;

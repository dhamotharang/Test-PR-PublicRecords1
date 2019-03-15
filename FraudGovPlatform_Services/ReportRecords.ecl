IMPORT DidVille, FraudShared_Services, iesp, Royalty;

EXPORT ReportRecords(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_in,
                     FraudGovPlatform_Services.IParam.BatchParams batch_params,
										 BOOLEAN IsIdentityTestRequest,
										 BOOLEAN IsElementTestRequest) := MODULE
										 
		SHARED FraudGovConst_ := FraudGovPlatform_Services.Constants;
		SHARED FraudGovKelConst_ := FraudGovConst_.KEL_ENTITY_TYPE;
		SHARED FraudGovFragConst_ := FraudGovConst_.Fragment_Types;
		SHARED File_Type_Const := FraudGovConst_.PayloadFileTypeEnum;		
		                
		SHARED ds_batch := FraudGovPlatform_Services.BatchRecords(ds_in, batch_params).ds_results_report;
		
		SHARED all_knownfrauds := FraudGovPlatform_Services.Functions.getKnownFrauds(ds_batch);
		SHARED fdn_knownfrauds := all_knownfrauds(event_type = FraudShared_Services.Constants.Platform.FDN);
		
		SHARED ds_batch_w_ExternalServices := FraudGovPlatform_Services.BatchRecords(ds_in, batch_params).ds_reportFromBatchServices;
		SHARED ds_realtime_tmp := mod_RealTimeScoring(ds_batch_w_ExternalServices, batch_params);
		
		SHARED ds_indicatorAttributes_realtime_raw := ds_realtime_tmp.WeightedResult;
		SHARED ds_scoreBreakdown_realtime_raw := ds_realtime_tmp.ScoreBreakdownAggregate;
		SHARED ds_realtimeScore_raw := ds_realtime_tmp.ds_w_realTimeScore;
		
		/*  Getting all the known frauds */
		knownfraud_temp_rec := RECORD
				INTEGER KnownRiskCount := COUNT(GROUP);
				DATASET(iesp.share.t_StringArrayItem) KnownRiskReasons := PROJECT(all_knownfrauds, TRANSFORM({iesp.share.t_StringArrayItem}, SELF.value := LEFT.known_risk_reason));
		END;

		SHARED all_knownfrauds_slimmed := TABLE(all_knownfrauds, knownfraud_temp_rec);
		SHARED all_knownfrauds_final := PROJECT(all_knownfrauds_slimmed, 
																			TRANSFORM(iesp.fraudgovreport.t_FraudGovKnownRisk,
																				SELF.KnownRiskCount := LEFT.KnownRiskCount,
																				SELF.KnownRiskReasons := CHOOSEN(LEFT.KnownRiskReasons, batch_params.MaxKnownFrauds)));

		/* For A Element that's passed as input to report service. */
		ds_payload := FraudGovPlatform_Services.BatchRecords(ds_in, batch_params).ds_payload;

		ds_batch_in_extended := PROJECT(ds_in, FraudShared_Services.Layouts.BatchInExtended_rec);
		
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
		ds_fragment_recs_rolled := ROLLUP(ds_fragment_recs_grouped, GROUP, do_Rollup(LEFT, ROWS(LEFT)));
	
		ds_entityNameUID := FraudGovPlatform_Services.Utilities.getAnalyticsUID(ds_fragment_recs_rolled);

		ds_delta_recentActivity := FraudGovPlatform_Services.mod_Deltabase_Functions(batch_params).getDeltabaseReportRecords(ds_batch_in_extended);

		ds_recentTransactions_sorted := IF(batch_params.IsOnline AND batch_params.UseAllSearchFields,
																	SORT(ds_delta_recentActivity(UniqueId = (STRING)ds_in[1].did),-eventDate.year, -eventDate.Month, -eventDate.day),
																	SORT(ds_delta_recentActivity,-eventDate.year, -eventDate.Month, -eventDate.day));

		numOfDeltabaseTransactions := COUNT(ds_recentTransactions_sorted);	

		/* Returning Element or Identity Score and related clusters and related identities. */
		ds_raw_cluster_recs := FraudGovPlatform_Services.Functions.getClusterDetails(ds_entityNameUID, batch_params, FALSE);

		/* Getting the element and identity socre where Identity or Element is center of their cluster. */
		ds_cluster_recs_scores := ds_raw_cluster_recs(entity_context_uid_ = tree_uid_);
		
		ds_ElementcardDetail_w_score := JOIN(ds_fragment_recs_rolled, ds_cluster_recs_scores,
																			LEFT.fragment = RIGHT.entity_name AND
																			LEFT.fragment_value = RIGHT.entity_value, 
																			TRANSFORM(iesp.fraudgovreport.t_FraudGovElementCardDetails, 
																				SELF.ScoreDetails.RecordType := FraudGovConst_.RecordType.ELEMENT,
																				SELF.ScoreDetails.ElementType := LEFT.fragment,
																				SELF.ScoreDetails.ElementValue := MAP(LEFT.fragment = FraudGovFragConst_.PHYSICAL_ADDRESS_FRAGMENT 
																																								=> FraudGovPlatform_Services.Functions.GetCleanAddressFragmentValue(LEFT.fragment_value),
																																							LEFT.fragment = FraudGovFragConst_.BANK_ACCOUNT_NUMBER_FRAGMENT
																																								=> FraudGovPlatform_Services.Functions.GetCleanBankAccountFragmentValue(LEFT.fragment_value),
																																							LEFT.fragment_value);
																				SELF.ScoreDetails.Score := RIGHT.Score_,
																				SELF.NoOfIdentities := RIGHT.cl_identity_count_,
																				SELF.NoOfRecentTransactions := numOfDeltabaseTransactions,
																				SELF.NoOfClusters := COUNT(ds_raw_cluster_recs( entity_name = LEFT.fragment AND  
																																												entity_value = LEFT.fragment_value)),
																				SELF.LastActivityDate := IF(numOfDeltabaseTransactions = 0,
																											iesp.ECL2ESP.toDate(LEFT.LastActivityDate),
																											ds_recentTransactions_sorted[1].EventDate),
																				SELF.ElementNVPs := PROJECT(RIGHT.flags, TRANSFORM(iesp.share.t_NameValuePair,
																																									SELF.Name := LEFT.indicator,
																																									SELF.Value := LEFT.value)),
																				SELF := LEFT,
																				SELF := []),
																				LEFT OUTER,
																				LIMIT(FraudGovPlatform_Services.Constants.Limits.MAX_JOIN_LIMIT, SKIP));
																				
		/* Getting the related clusters */
		ds_cluster_proj := PROJECT(ds_raw_cluster_recs, 
												TRANSFORM(FraudGovPlatform_Services.Layouts.elementNidentity_uid_recs,
													SELF.entity_name := LEFT.entity_name,
													SELF.entity_value := LEFT.entity_value,
													SELF.tree_uid := LEFT.tree_uid_,
													SELF.entity_context_uid := LEFT.entity_context_uid_,
													SELF := []));
																										
		ds_cluster_details := FraudGovPlatform_Services.Functions.getClusterDetails(ds_cluster_proj, batch_params, TRUE);
		
		/* Getting the element and identity socre where Identity or Element is center of their cluster. */
		ds_center_clusterdetails := ds_cluster_details(tree_uid_ = entity_context_uid_);
		
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
															SELF.NoOfIdentities := LEFT.cl_identity_count_,
															SELF.ClusterName := LEFT.label_,
															SELF.ClusterNVPs := PROJECT(LEFT.flags, 
																										TRANSFORM(iesp.share.t_NameValuePair,
																											SELF.Name := LEFT.indicator,
																											SELF.Value := LEFT.value)),
															SELF := []));
		
		ds_related_clusters_sorted := SORT(ds_related_clusters, -ScoreDetails.Score, ScoreDetails.ElementValue, 
																							-NoOfIdentities, RECORD);
		
		/* Getting the related identities*/			
		ds_associated_identities_raw := ds_center_clusterdetails(entity_type_ = FraudGovKelConst_.ENTITY_TYPE_LEXID);
		
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
		ds_dids := PROJECT(ds_combined_dids, TRANSFORM(DidVille.Layout_Did_OutBatch, 
																					SELF.Seq := COUNTER, 
																					SELF.did := LEFT.did, 
																					SELF := []));
		ds_GovBest := FraudGovPlatform_Services.Functions.getGovernmentBest(ds_dids, batch_params);
		ds_contributoryBest := FraudGovPlatform_Services.Functions.getContributedBest(ds_dids, FraudGovConst_.FRAUD_PLATFORM);
		
		IsRealTime := IF(batch_params.IsOnline, 
										batch_params.UseAllSearchFields, 
										ds_batch[1].identity_resolved = 'Y' AND NOT EXISTS(ds_contributoryBest) AND 
										(ds_ElementcardDetail_w_score[1].ScoreDetails.ElementType = FraudGovPlatform_Services.Constants.Fragment_Types.PERSON_FRAGMENT
										OR ds_ElementcardDetail_w_score[1].ScoreDetails.ElementType = ''));
		/*
			Following function returns the Dummy Government Information when Options.AppendBest is set to False,
			This will help Sales/Product folks to not show actual PII info when demo'ing the MVP to customers. 
			More details can be found at https://jira.rsi.lexisnexis.com/browse/GRP-1025
		*/
		ds_dummyGovBest := FraudGovPlatform_Services.fn_GetTestRecords.GetDummyGovBestInfo(ds_contributoryBest);
		
		/* Append scores to ds_contributoryBest */	
		ds_contributoryBest_w_scores := JOIN(ds_contributoryBest, ds_associated_identities_raw,
																			LEFT.ContributedBest.UniqueId	= RIGHT.entity_context_uid_[4..], 
																			TRANSFORM(iesp.fraudgovreport.t_FraudGovIdentityCardDetails,
																				SELF.ScoreDetails.RecordType := FraudGovConst_.RecordType.IDENTITY,
																				SELF.ScoreDetails.ElementType := FraudGovFragConst_.PERSON_FRAGMENT, 
																				SELF.ScoreDetails.ElementValue := LEFT.ContributedBest.UniqueId, 
																				SELF.ScoreDetails.Score := RIGHT.score_,
																				SELF := LEFT),
																			LEFT OUTER, LIMIT(FraudGovPlatform_Services.Constants.Limits.MAX_JOIN_LIMIT, SKIP));
		
		ds_contributoryBest_w_scores_sorted := SORT(ds_contributoryBest_w_scores, -ScoreDetails.Score, ScoreDetails.ElementValue, 
																									 RECORD);
		
		ds_realtime := PROJECT(ds_realtimeScore_raw,TRANSFORM(iesp.fraudgovreport.t_FraudGovIdentityCardDetails,
																				SELF.ScoreDetails.RecordType := FraudGovConst_.RecordType.IDENTITY,
																				SELF.ScoreDetails.ElementType := FraudGovFragConst_.PERSON_FRAGMENT, 
																				SELF.ScoreDetails.ElementValue := (STRING)LEFT.lexid, 
																				SELF.ScoreDetails.Score := LEFT.risk_score,
																				SELF := []));
		
		/* Returning the Timeline Data */
		ds_timeline := PROJECT(ds_payload, FraudGovPlatform_Services.Transforms.xform_timeline_details(LEFT)) + ds_recentTransactions_sorted;
		ds_timeline_sorted := SORT(ds_timeline, -IsRecentActivity, FileType, -ReportedDateTime.Year,-ReportedDateTime.Month, 
																-ReportedDateTime.Day,-ReportedDateTime.Hour24,-ReportedDateTime.Minute,-ReportedDateTime.Second,
																-EventDate.Year, -EventDate.Month, -EventDate.Day,
																record);
		
		/* Returning the Associated Address Data  - This is based on the Timeline Records found above */
		ds_associated_addresses := FraudGovPlatform_Services.Functions.getAssociatedAddresses(ds_payload);
		
		/* Returning the Indicator Attributes for Online Report */
		ds_indicator_attribute :=	FraudGovPlatform_Services.Functions.GetIndicatorAttributes(ds_entityNameUID, batch_params);
																
																																							
		ds_indicator_attribute_realtime := PROJECT(ds_indicatorAttributes_realtime_raw,TRANSFORM(iesp.fraudgovreport.t_FraudGovIndicatorAttribute,
																																							SELF.IndicatorTypeCode := LEFT.indicatortype,
																																							SELF.IndicatorTypeDescription := LEFT.indicatordescription,
																																							SELF.DataType := LEFT.fieldtype,
																																							SELF.RiskLevel := (STRING)LEFT.risklevel,
																																							SELF.DescriptionCode := LEFT.field,
																																							SELF.Description := LEFT.label,
																																							SELF.DescriptionValue := LEFT.value,
																																							SELF := []));
		
		/* Returning the Score Breakdown for Online Report */
		ds_score_breakdown := FraudGovPlatform_Services.Functions.GetScoreBreakDown(ds_entityNameUID, batch_params);
														
		ds_score_breakdown_realtime := PROJECT(ds_scoreBreakdown_realtime_raw, TRANSFORM(iesp.fraudgovreport.t_FraudGovScoreBreakdown,
																																							SELF.IndicatorTypeCode := LEFT.indicatortype,
																																							SELF.IndicatorTypeDescription := LEFT.IndicatorDescription,
																																							SELF.RiskLevel := (STRING)LEFT.risklevel,
																																							SELF.PopulationType := LEFT.populationtype,
																																							SELF.Value := LEFT.value));

		/* Transforming the report response, by assembling all the pieces together */
		iesp.fraudgovreport.t_FraudGovRecord xform_response() := TRANSFORM
			SELF.RiskScore := IF(~IsRealTime, ds_batch[1].risk_score, ds_realtimeScore_raw[1].risk_score);
			SELF.RiskLevel := IF(~IsRealTime, ds_batch[1].risk_level, ds_realtimeScore_raw[1].risk_level);
			SELF.IdentityResolved := IF(~IsRealTime,ds_batch[1].identity_resolved,FraudGovPlatform_Services.Constants.IDENTITY_RESOLVED_REALTIME);
			SELF.LexID := ds_batch[1].lexid;

			SELF.Deceased := IF(~batch_params.IsOnline, 
													ROW(FraudGovPlatform_Services.Transforms.xform_deceased(ds_batch.childRecs_Death[1])), 
													ROW([], iesp.fraudgovreport.t_FraudGovDeceased));
			
			SELF.Criminals :=	IF(~batch_params.IsOnline,
													PROJECT(CHOOSEN(ds_batch.childRecs_Criminal, batch_params.MaxCriminals),
																		FraudGovPlatform_Services.Transforms.xform_criminal(LEFT, COUNTER)),
													DATASET([], iesp.fraudgovreport.t_FraudGovCriminal));

			SELF.RedFlags := IF(~batch_params.IsOnline,
												PROJECT(CHOOSEN(ds_batch.childRecs_RedFlag, batch_params.MaxRedFlags), 
																	FraudGovPlatform_Services.Transforms.xform_red_flag(LEFT)),
												DATASET([], iesp.fraudgovreport.t_FraudGovRedFlag));
													
			SELF.GlobalWatchlists := IF(~batch_params.IsOnline, 
																	PROJECT(CHOOSEN(ds_batch.childRecs_Patriot, batch_params.MaxGlobalWatchlists),
																					FraudGovPlatform_Services.Transforms.xform_global_watchlist(LEFT, COUNTER)),
																	DATASET([], iesp.fraudgovreport.t_FraudGovGlobalWatchlist));
																															
			SELF.Velocities :=	IF(~batch_params.IsOnline, 
														PROJECT(CHOOSEN(ds_batch.childRecs_velocities, batch_params.MaxVelocities), 
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

			SELF.AssociatedIdentities := IF(batch_params.IsOnline,
																			CHOOSEN(ds_contributoryBest_w_scores_sorted, batch_params.MaxAssociatedIdentities),
																			DATASET([],iesp.fraudgovreport.t_FraudGovIdentityCardDetails));
			
			SELF.AssociatedAddresses := IF(batch_params.IsOnline,
																			CHOOSEN(ds_associated_addresses, batch_params.MaxAssociatedAddresses),
																			DATASET([],iesp.fraudgovreport.t_FraudGovAssociatedAddress));

			SELF.RelatedClusters := IF(batch_params.IsOnline, 
																	CHOOSEN(ds_related_clusters_sorted, batch_params.MaxRelatedClusters),
																	DATASET([],iesp.fraudgovreport.t_FraudGovClusterCardDetails));
																
			SELF.TimeLineDetails := IF(batch_params.IsOnline, 
																CHOOSEN(ds_timeline_sorted, batch_params.MaxTimelineDetails), 
																DATASET([],iesp.fraudgovreport.t_FraudGovTimeLineDetails));
			SELF := [];
		END;
		
		// output(batch_params,named('batch_params'));
		// output(ds_in,named('ds_in'));
		// output(ds_delta_recentActivity,named('ds_delta_recentActivity'));
		// output(ds_recentTransactions_sorted,named('ds_recentTransactions_sorted'));
		// output(ds_realtimeEventScore,named('ds_realtimeEventScore'));
		// output(ds_realtimeScore_raw,named('ds_realtimeScore'));
		// output(ds_realtime,named('ds_realtime'));
		// output(ds_indicator_attribute_realtime,named('ds_indicator_attribute_realtime'));
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
		EXPORT ds_royalties := Royalty.RoyaltyFDNCoRR.GetOnlineRoyalties(fdn_knownfrauds, true);
END;

IMPORT BatchShare, FraudGovPlatform_Services, FraudShared_Services, iesp, std;

EXPORT SearchRecords(DATASET(FraudShared_Services.Layouts.BatchInExtended_rec) ds_batch_in,
                     FraudGovPlatform_Services.IParam.BatchParams batch_params,
										 BOOLEAN IsTestRequest = FALSE) := FUNCTION
	
	//Defining the constants to be used later.
	Fragment_Types_const := FraudGovPlatform_Services.Constants.Fragment_Types;
	File_Type_Const := FraudGovPlatform_Services.Constants.PayloadFileTypeEnum;
	
	TodaysDate := STD.date.today();
	YesterdayDate := STD.Date.AdjustDate(TodaysDate,0,0,-1);
	
	// ***random_no_of_identities*** is temporary placeholder and will be repalced by Logic when we know how and where to get the actual values. 
	random_no_of_identities_ds := DATASET([{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}] , {unsigned1 num}); 
	random_no_of_identities := ROUNDUP(count(random_no_of_identities_ds) * (((RANDOM()%100000)+1)/100000));
	// ***random_scores ends***	

	// ***random_scores*** is temporary placeholder and will be repalced by Logic when we know how and where to get the actual score. 
	random_scores_ds := DATASET([{35}, {40}, {49}, {79}, {85}, {89}, {95}, {99}] , {unsigned1 num}); 
	random_score := ROUNDUP(count(random_scores_ds) * (((RANDOM()%100000)+1)/100000));
	// ***random_scores ends***
	
	// ***random_no_of_cluster*** is temporary placeholder and will be repalced by Logic when we know how and where to get the actual values. 
	random_no_of_cluster_ds := DATASET([{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}] , {unsigned1 num}); 
	random_no_of_cluster := ROUNDUP(count(random_no_of_cluster_ds) * (((RANDOM()%100000)+1)/100000));
	// ***random_scores ends***

	// **************************************************************************************
	// Getting the payload records from FraudGov Payload key.
	// **************************************************************************************
	ds_allPayloadRecs := FraudGovPlatform_Services.fn_getadvsearch_raw_recs(ds_batch_in,
																																					batch_params.GlobalCompanyId,
																																					batch_params.IndustryType,
																																					batch_params.ProductCode,
																																					IsOnline := batch_params.IsOnline);

	ds_clusters := FraudGovPlatform_Services.fn_getTestRecords.GetTestClusters();

	iesp.fraudgovsearch.t_FraudGovSearchRecord trans(iesp.fraudgovreport.t_FraudGovClusterCardDetails L) := TRANSFORM
		SELF.AnalyticsRecordId := L.AnalyticsRecordId;			
		SELF.RecordType := L.ScoreDetails.RecordType;
		SELF.ElementType := L.ScoreDetails.ElementType;
		SELF.ElementValue := L.ScoreDetails.ElementValue;
		SELF.Score := random_scores_ds[random_score].num;
		SELF.NoOfIdentities := random_no_of_identities_ds[random_no_of_identities].num;
		SELF.ClusterName := L.ClusterName;
		SELF := [];
	END;

	mockup_cluster := PROJECT(ds_clusters, trans(LEFT));

	
	// **************************************************************************************
	// Append DID for Input PII
	// **************************************************************************************	  
	ds_input_with_did := BatchShare.MAC_Get_Scored_DIDs(ds_batch_in, batch_params, usePhone:=TRUE);
	BOOLEAN did_exists := EXISTS(ds_input_with_did(did > 0));

	ds_input_best_in := PROJECT(ds_input_with_did, TRANSFORM(DidVille.Layout_Did_OutBatch,
																										SELF.fname	:= LEFT.name_first,
																										SELF.mname	:= LEFT.name_middle,
																										SELF.lname	:= LEFT.name_last,
																										SELF.suffix	:= LEFT.name_suffix,
																										SELF.phone10	:= LEFT.phoneno,
																										SELF	:= LEFT,
																										SELF	:= []));
	
	ds_payload_best_in := PROJECT(ds_allPayloadRecs , TRANSFORM(DidVille.Layout_Did_OutBatch,
																											SELF.Seq := (integer) LEFT.acctno,
																											SELF.did := LEFT.did,
																											SELF := []));

	ds_payload_best_in_dedup := DEDUP(SORT(ds_payload_best_in(did > 0), did), did);
	
	ds_best_in := IF(did_exists , ds_input_best_in , ds_payload_best_in_dedup);
	
	
	//Getting the PR best to fill Indentity Detail card.
	ds_GovBest := FraudGovPlatform_Services.Functions.getGovernmentBest(ds_best_in, batch_params);
	
	//Getting the Contributory best to fill Indentity Detail card.
	ds_contributoryBest := FraudGovPlatform_Services.Functions.getContributedBest(ds_best_in, FraudGovPlatform_Services.Constants.FRAUD_PLATFORM);
	
	//adding additional elements lexid's to ds_batch_in , so velocities can be calculated.
	ds_elements_dids := PROJECT(ds_payload_best_in_dedup, TRANSFORM(FraudShared_Services.Layouts.BatchInExtended_rec, 
																													SELF.acctno := (string) LEFT.Seq,
																													SELF.did := LEFT.did,
																													SELF := []));
	
	ds_combinedfreg_recs := IF(did_exists, ds_batch_in, ds_batch_in + ds_elements_dids);

	ds_fragment_recs_w_value := FraudGovPlatform_Services.Functions.GetFragmentRecs(ds_combinedfreg_recs, ds_allPayloadRecs, batch_params);
	
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

	ds_fragment_tab_Recs := RECORD
		ds_fragment_recs_sorted.fragment;
		ds_fragment_recs_sorted.fragment_value;
		unsigned2 NoOfTransactions := COUNT(GROUP, ds_fragment_recs_sorted.file_type = File_Type_Const.IdentityActivity);
		unsigned2 NoOfRecentTransactions := COUNT(GROUP , ds_fragment_recs_sorted(ds_fragment_recs_sorted.file_type = File_Type_Const.IdentityActivity).date >= YesterdayDate);
		unsigned2 NoOfKnownRisks := COUNT(GROUP , ds_fragment_recs_sorted.file_type = File_Type_Const.KnownFraud); 
	END;

	ds_fragment_recs_tab	:= TABLE(ds_fragment_recs_sorted,ds_fragment_tab_Recs, fragment_value, fragment);	

	iesp.fraudgovsearch.t_FraudGovSearchRecord ElementsNIdentities_trans (FraudGovPlatform_Services.Layouts.fragment_w_value_recs L, ds_fragment_tab_Recs R)  := TRANSFORM
		boolean populateBest := L.fragment = Fragment_Types_const.PERSON_FRAGMENT;
		gov_best_rec := ds_GovBest(ds_GovBest.UniqueId = L.fragment_value)[1];
		contri_best_rec := ds_contributoryBest(ContributedBest.UniqueId = L.fragment_value)[1];

		SELF.RecordType := MAP(	L.fragment = Fragment_Types_const.PERSON_FRAGMENT => FraudGovPlatform_Services.Constants.RecordType.IDENTITY,
														L.fragment In FraudGovPlatform_Services.Constants.RECORD_TYPE_ELEMENT_SET => FraudGovPlatform_Services.Constants.RecordType.ELEMENT,
														'');
		SELF.ElementType := L.fragment;
		SELF.ElementValue := L.fragment_value;
		SELF.Score := random_scores_ds[random_score].num;
		SELF.NoOfIdentities := random_no_of_identities_ds[random_no_of_identities].num;
		
		SELF.GovernmentBest := PROJECT(gov_best_rec, TRANSFORM(LEFT));
		SELF.ContributedBest := PROJECT(contri_best_rec.ContributedBest	, TRANSFORM(LEFT));
		SELF.EmailAddress :=  contri_best_rec.EmailAddress;
		
		SELF.NoOfClusters := random_no_of_cluster_ds[random_no_of_cluster].num;
		SELF.NoOfRecentTransactions := R.NoOfRecentTransactions; //Last 24 hours velocity count.
		SELF.NoOfTransactions := R.NoOfTransactions; //Total velocity count.
		SELF.NoOfKnownRisks := R.NoOfKnownRisks; //Total Known Risk count.
		SELF.LastActivityDate := iesp.ECL2ESP.toDate(L.LastActivityDate);
		SELF.LastKnownRiskDate := iesp.ECL2ESP.toDate(L.LastKnownRiskDate); //Highest Knownrisk date.
		SELF := [];
	END;
	
	ds_ElementsNIdentities := JOIN(ds_fragment_recs_rolled, ds_fragment_recs_tab,
																	LEFT.fragment_value = RIGHT.fragment_value AND
																	LEFT.fragment = RIGHT.fragment,
																	ElementsNIdentities_trans(LEFT, RIGHT));
																	
	ds_results := IF(IsTestRequest, ds_ElementsNIdentities + mockup_cluster, ds_ElementsNIdentities);
	
	// output(ds_batch_in, named('ds_batch_in'));
	// output(ds_allPayloadRecs, named('ds_allPayloadRecs'));
	// output(ds_combinedfreg_recs, named('ds_combinedfreg_recs'));
	// output(ds_fragment_recs_w_value, named('ds_fragment_recs_w_value'));
	// output(ds_results, named('ds_results'));
	
	RETURN ds_results;
END;
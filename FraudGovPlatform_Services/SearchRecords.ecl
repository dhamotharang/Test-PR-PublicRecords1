IMPORT Address, BatchShare, FraudGovPlatform_Services, FraudShared_Services, iesp, std;

EXPORT SearchRecords(DATASET(FraudShared_Services.Layouts.BatchInExtended_rec) ds_batch_in,
                     FraudGovPlatform_Services.IParam.BatchParams batch_params,
										 BOOLEAN IsTestRequest = FALSE) := FUNCTION
	
	//Defining the constants to be used later.
	Fragment_Types_const := FraudGovPlatform_Services.Constants.Fragment_Types;
	File_Type_Const := FraudGovPlatform_Services.Constants.PayloadFileTypeEnum;
	
	TodaysDate := STD.date.today();
	YesterdayDate := STD.Date.AdjustDate(TodaysDate,0,0,-1);

	// **************************************************************************************
	// Getting the payload records from FraudGov Payload key.
	// **************************************************************************************
	ds_allPayloadRecs := FraudGovPlatform_Services.fn_getadvsearch_raw_recs(ds_batch_in,
																																					batch_params.GlobalCompanyId,
																																					batch_params.IndustryType,
																																					batch_params.ProductCode,
																																					IsOnline := batch_params.IsOnline);

	// **************************************************************************************
	// Append DID for Input PII
	// **************************************************************************************	  
	ds_input_with_adl_did := BatchShare.MAC_Get_Scored_DIDs(ds_batch_in, batch_params, usePhone:=TRUE);
	BOOLEAN adlDIDFound := EXISTS(ds_input_with_adl_did(did > 0));

	ds_adl_in := PROJECT(ds_input_with_adl_did, 
												TRANSFORM(DidVille.Layout_Did_OutBatch,
													SELF.fname	:= LEFT.name_first,
													SELF.mname	:= LEFT.name_middle,
													SELF.lname	:= LEFT.name_last,
													SELF.suffix	:= LEFT.name_suffix,
													SELF.phone10	:= LEFT.phoneno,
													SELF	:= LEFT,
													SELF	:= []));
	
	ds_contributory_in := PROJECT(ds_allPayloadRecs , 
													TRANSFORM(DidVille.Layout_Did_OutBatch,
														SELF.Seq := (integer) LEFT.acctno,
														SELF.did := LEFT.did,
														SELF := []));

	ds_contributory_in_dedup := DEDUP(SORT(ds_contributory_in(did > 0), did), did);
	
	/* This is best on three step process defined in GRP-724 */
		/* 
		1.We should first use the search criteria and attempt to find a lexid,  if found then use that LEXID to find rows that match, 
			if at least 1 row matches then return an identity card for that lexid,  The identity card scorecard information should display the 
			latest non-blank values from the contributory records that matched that lexid.  If this approach is used then method 2 is not used, 
			whether we found matching rows or NOT.      
				Directly Proceed to stage 3 to find ELEMENTS.
		2.When stage 1 method does NOT result in resolving to a lexid, we run through the contributory data and bring back all the Identity cards for those 
			records that match ALL the search criteria. AKA: The all 'And' approach  (this means we have to find a row that matches ALL the search criteria).  
				Proceed to stage 3 to find ELEMENTS.
		3.Bring back ELEMENT cards (ONLY MVP SUPPORTED ELEMENTs),  for each ELEMENT in the Search Criteria,   
			when ALL ELEMENTS in the Search Criteria is found to match a single contributed row.
		*/
	ds_dids_to_use := IF(adlDIDFound , ds_adl_in , ds_contributory_in_dedup);
	
	//Getting the public records best to fill identity Detail card.
	ds_GovBest := FraudGovPlatform_Services.Functions.getGovernmentBest(ds_dids_to_use, batch_params);
	
	//Getting the Contributory best to fill identity Detail card.
	ds_contributoryBest := FraudGovPlatform_Services.Functions.getContributedBest(ds_dids_to_use, FraudGovPlatform_Services.Constants.FRAUD_PLATFORM);
	
	//adding additional elements lexid's to ds_batch_in , so velocities can be calculated.
	ds_elements_dids := PROJECT(ds_contributory_in_dedup, 
												TRANSFORM(FraudShared_Services.Layouts.BatchInExtended_rec, 
													SELF.acctno := (string) LEFT.Seq,
													SELF.did := LEFT.did,
													SELF := []));
	
	ds_combinedfreg_recs := IF(adlDIDFound, ds_batch_in, ds_batch_in + ds_elements_dids);

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
	
	//Getting the Cluster score for an element and the related cluster cards.
	ds_entityNameUID := FraudGovPlatform_Services.Utilities.getAnalyticsUID(ds_fragment_recs_rolled);
	ds_raw_cluster_recs := FraudGovPlatform_Services.Functions.getClusterDetails(ds_entityNameUID, batch_params, FALSE);
	
	//Checking with entity_context_uid_ = tree_uid_ only return those elemenet/identities which are center of their cluster. 
	ds_cluster_recs_scores := ds_raw_cluster_recs(entity_context_uid_ = tree_uid_);
	
	ds_fragment_recs_w_scores := 	JOIN(ds_fragment_recs_rolled, ds_cluster_recs_scores,
																	LEFT.fragment = RIGHT.entity_name AND
																	LEFT.fragment_value = RIGHT.entity_value , 
																	TRANSFORM (FraudGovPlatform_Services.Layouts.elementNidentity_score_recs,
																		SELF.AnalyticsRecordId := RIGHT.entity_context_uid_,
																		SELF.score := RIGHT.score_,
																		SELF.ClusterName := RIGHT.label_,
																		SELF.NumberOfClusters := COUNT(ds_raw_cluster_recs(	entity_name = LEFT.fragment AND
																																												entity_value = LEFT.fragment_value)),
																		SELF.NumberOfIdentities := RIGHT.cl_identity_count_,
																		SELF.NVPs := CHOOSEN( PROJECT(RIGHT.flags, 
																														TRANSFORM(iesp.share.t_NameValuePair,
																															SELF.Name := LEFT.indicator,
																															SELF.Value := LEFT.value)), iesp.Constants.FraudGov.MAX_COUNT_NVP),
																		SELF := LEFT,
																		SELF := []),
																		LEFT OUTER,
																		LIMIT(FraudGovPlatform_Services.Constants.Limits.MAX_JOIN_LIMIT, SKIP));
																		
	ds_clusters := PROJECT(ds_cluster_recs_scores, 
										TRANSFORM(iesp.fraudgovsearch.t_FraudGovSearchRecord,
											SELF.AnalyticsRecordId := LEFT.tree_uid_,
											SELF.RecordType := FraudGovPlatform_Services.Constants.RecordType.CLUSTER,																										
											SELF.ElementType := LEFT.entity_name,
											//Cleaning out @@@ from LEFT.entity_value when ELEMNT is of type address,
											// @@@ was addded to calcualte the matching HASH value for tree_uid
											SELF.ElementValue := IF(LEFT.entity_name = Fragment_Types_const.PHYSICAL_ADDRESS_FRAGMENT,
																							REGEXREPLACE('@@@',LEFT.entity_value,', '), 
																							LEFT.entity_value);
											SELF.score := LEFT.cluster_score_,
											SELF.ClusterName := LEFT.label_,
											SELF.NoOfIdentities := LEFT.cl_identity_count_,
											SELF.NVPs := CHOOSEN(PROJECT(LEFT.flags, 
																						TRANSFORM(iesp.share.t_NameValuePair,
																							SELF.Name := LEFT.indicator,
																							SELF.Value := LEFT.value)), iesp.Constants.FraudGov.MAX_COUNT_NVP),
											SELF := []));
												
	//Computing ElementInformation from the payload. 
	ds_elementsInformation := JOIN(ds_fragment_recs_rolled , ds_allPayloadRecs,
																	LEFT.record_id = RIGHT.record_id,
																	FraudGovPlatform_Services.Transforms.xform_elements_Information(LEFT, RIGHT),
																	LEFT OUTER,
																	LIMIT(FraudGovPlatform_Services.Constants.Limits.MAX_JOIN_LIMIT, SKIP));
	

	ds_delta_recentTransactions := mod_Deltabase_Functions.getDeltabaseSearchRecords(batch_params);											
																		
	//Assembling all the pieces together to form search response.	
	iesp.fraudgovsearch.t_FraudGovSearchRecord ElementsNIdentities_trans (FraudGovPlatform_Services.Layouts.elementNidentity_score_recs L, ds_fragment_tab_Recs R)  := TRANSFORM
		boolean populateBest := L.fragment = Fragment_Types_const.PERSON_FRAGMENT;
		gov_best_rec := ds_GovBest(ds_GovBest.UniqueId = L.fragment_value)[1];
		contri_best_rec := ds_contributoryBest(ContributedBest.UniqueId = L.fragment_value)[1];
		
		SELF.AnalyticsRecordId := L.AnalyticsRecordId;
		SELF.RecordType := MAP(	L.fragment = Fragment_Types_const.PERSON_FRAGMENT => FraudGovPlatform_Services.Constants.RecordType.IDENTITY,
														L.fragment In FraudGovPlatform_Services.Constants.RECORD_TYPE_ELEMENT_SET => FraudGovPlatform_Services.Constants.RecordType.ELEMENT,
														'');
		SELF.ElementType := L.fragment;
		//Cleaning out @@@ from LEFT.entity_value when ELEMENT is of type address,
		// @@@ was addded to calcualte the matching HASH value for tree_uid
		SELF.ElementValue := IF(L.fragment = Fragment_Types_const.PHYSICAL_ADDRESS_FRAGMENT,REGEXREPLACE('@@@',L.fragment_value,', '),L.fragment_value);
		
		SELF.ElementInformation := ds_elementsInformation(fragment_value = L.fragment_value)[1];
		
		SELF.Score := L.Score;
		SELF.NoOfIdentities := L.NumberOfIdentities;
		SELF.GovernmentBest := PROJECT(gov_best_rec, TRANSFORM(LEFT));
		SELF.ContributedBest := PROJECT(contri_best_rec.ContributedBest	, TRANSFORM(LEFT));
		SELF.EmailAddress :=  contri_best_rec.EmailAddress;
		SELF.NoOfClusters := L.NumberOfClusters;

		ds_recentTransactions := MAP( 
				 L.fragment = Fragment_Types_const.PERSON_FRAGMENT => ds_delta_recentTransactions(UniqueId = L.fragment_value),
				 L.fragment = Fragment_Types_const.SSN_FRAGMENT => ds_delta_recentTransactions(SSN = L.fragment_value),
				 L.fragment = Fragment_Types_const.NAME_FRAGMENT => 
															ds_delta_recentTransactions(
																		STD.Str.ToUpperCase(
																						Address.NameFromComponents(STD.Str.CleanSpaces(Name.First), '', 
																						STD.Str.CleanSpaces(Name.Last),'')) = STD.Str.ToUpperCase(STD.Str.CleanSpaces(L.fragment_value))),
																						
				 L.fragment = Fragment_Types_const.PHYSICAL_ADDRESS_FRAGMENT => 
															ds_delta_recentTransactions(
					  													STD.Str.ToUpperCase(
																		  STD.Str.CleanSpaces(PhysicalAddress.StreetAddress1) +'@@@' + 
															  					Address.Addr2FromComponents(STD.Str.CleanSPaces(PhysicalAddress.City), 
																											STD.Str.CleanSPaces(PhysicalAddress.State), 
																											STD.Str.CleanSPaces(PhysicalAddress.Zip5))
																						) = STD.Str.ToUpperCase(STD.Str.CleanSPaces(L.fragment_value))),
																		
				 L.fragment = Fragment_Types_const.PHONE_FRAGMENT => ds_delta_recentTransactions(Phones[1].PhoneNumber = L.fragment_value),
				 L.fragment = Fragment_Types_const.IP_ADDRESS_FRAGMENT => ds_delta_recentTransactions(IpAddress = L.fragment_value),
				 L.fragment = Fragment_Types_const.BANK_ACCOUNT_NUMBER_FRAGMENT => ds_delta_recentTransactions(BankInformation1.BankAccountNumber = L.fragment_value OR
				 																							   BankInformation2.BankAccountNumber = L.fragment_value),
				 L.fragment = Fragment_Types_const.DEVICE_ID_FRAGMENT => ds_delta_recentTransactions(DeviceId = L.fragment_value),
				 DATASET([], iesp.fraudgovreport.t_FraudGovTimelineDetails));

		ds_recentTransactions_sorted := SORT(ds_recentTransactions,-eventDate.year, -eventDate.Month, -eventDate.day);

		numOfDeltabaseTransactions := COUNT(ds_recentTransactions);
		
		SELF.NoOfRecentTransactions := numOfDeltabaseTransactions;
		SELF.NoOfTransactions := R.NoOfTransactions + numOfDeltabaseTransactions; //Total velocity count.
		SELF.NoOfKnownRisks := R.NoOfKnownRisks; //Total Known Risk count.
		SELF.LastActivityDate := IF(numOfDeltabaseTransactions = 0,
									iesp.ECL2ESP.toDate(L.LastActivityDate),
									ds_recentTransactions_sorted[1].EventDate);
		SELF.LastKnownRiskDate := iesp.ECL2ESP.toDate(L.LastKnownRiskDate); //Highest Knownrisk date.
		SELF.NVPs := CHOOSEN(L.NVPs, iesp.Constants.FraudGov.MAX_COUNT_NVP);
		SELF := [];
	END;
	
	ds_ElementsNIdentities := JOIN(ds_fragment_recs_w_scores, ds_fragment_recs_tab,
															LEFT.fragment_value = RIGHT.fragment_value AND
															LEFT.fragment = RIGHT.fragment,
															ElementsNIdentities_trans(LEFT, RIGHT),
														LIMIT(FraudGovPlatform_Services.Constants.Limits.MAX_JOIN_LIMIT, SKIP));
																		
	ds_results := SORT(ds_ElementsNIdentities + ds_clusters, ElementType, ElementValue);
	
	// output(ds_delta_recentTransactions,named('ds_delta_recentTransactions'));	
	// output(ds_allPayloadRecs, named('ds_allPayloadRecs'));
	// output(ds_input_with_adl_did, named('ds_input_with_adl_did'));
	// output(adlDIDFound, named('adlDIDFound'));
	// output(ds_adl_in, named('ds_adl_in'));
	// output(ds_contributory_in, named('ds_contributory_in'));
	// output(ds_contributory_in_dedup, named('ds_contributory_in_dedup'));
	// output(ds_dids_to_use, named('ds_dids_to_use'));
	// output(ds_GovBest, named('ds_GovBest'));
	// output(ds_contributoryBest, named('ds_contributoryBest'));
	// output(ds_elements_dids, named('ds_elements_dids'));
	// output(ds_combinedfreg_recs, named('ds_combinedfreg_recs'));
	// output(ds_fragment_recs_w_value, named('ds_fragment_recs_w_value'));
	// output(ds_ElementsNIdentities, named('ds_ElementsNIdentities'));
	// output(ds_fragment_recs_sorted, named('ds_fragment_recs_sorted'));
	// output(ds_fragment_recs_rolled, named('ds_fragment_recs_rolled'));
	// output(ds_raw_cluster_recs, named('ds_raw_cluster_recs'));
	 //output(ds_cluster_recs_scores, named('ds_cluster_recs_scores'));
	// output(ds_fragment_recs_tab, named('ds_fragment_recs_tab'));
	// output(ds_fragment_recs_w_scores, named('ds_fragment_recs_w_scores'));	

	RETURN ds_results;
END;
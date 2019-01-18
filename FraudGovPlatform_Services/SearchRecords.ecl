IMPORT Address, BatchShare, FraudGovPlatform_Services, FraudShared_Services, iesp, std;

EXPORT SearchRecords(DATASET(FraudShared_Services.Layouts.BatchInExtended_rec) ds_batch_in,
                     FraudGovPlatform_Services.IParam.BatchParams batch_params,
										 BOOLEAN IsTestRequest = FALSE) := MODULE
	
	//Defining the constants to be used later.
	SHARED Fragment_Types_const := FraudGovPlatform_Services.Constants.Fragment_Types;
	SHARED File_Type_Const := FraudGovPlatform_Services.Constants.PayloadFileTypeEnum;
	
	// **************************************************************************************
	// Getting the payload records from FraudGov Payload key.
	// **************************************************************************************
	SHARED ds_allPayloadRecs := FraudGovPlatform_Services.fn_getadvsearch_raw_recs( ds_batch_in,
																																									batch_params.GlobalCompanyId,
																																									batch_params.IndustryType,
																																									batch_params.ProductCode,
																																									IsOnline := batch_params.IsOnline);

	// **************************************************************************************
	// Append DID for Input PII
	// **************************************************************************************	  
	SHARED ds_input_with_adl_did := BatchShare.MAC_Get_Scored_DIDs(ds_batch_in, batch_params, usePhone:=TRUE);
	
	EXPORT BOOLEAN adlDIDFound := EXISTS(ds_input_with_adl_did(did > 0));

	EXPORT ds_adl_in := PROJECT(ds_input_with_adl_did, 
												TRANSFORM(DidVille.Layout_Did_OutBatch,
													SELF.fname	:= LEFT.name_first,
													SELF.mname	:= LEFT.name_middle,
													SELF.lname	:= LEFT.name_last,
													SELF.suffix	:= LEFT.name_suffix,
													SELF.phone10:= LEFT.phoneno,
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
	
	//adding additional elements lexid's to ds_batch_in , so velocities can be calculated.
	ds_elements_dids := PROJECT(ds_contributory_in_dedup, 
												TRANSFORM(FraudShared_Services.Layouts.BatchInExtended_rec, 
													SELF.acctno := (string) LEFT.Seq,
													SELF.did := LEFT.did,
													SELF := []));
	
	ds_combinedfreg_recs := IF(adlDIDFound, ds_batch_in, ds_batch_in + ds_elements_dids);

	ds_fragment_recs_w_value := FraudGovPlatform_Services.Functions.GetFragmentRecs(ds_combinedfreg_recs, ds_allPayloadRecs, batch_params, TRUE);
	
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

	ds_fragment_tab_Recs := RECORD
		ds_fragment_recs_sorted.fragment;
		ds_fragment_recs_sorted.fragment_value;
		unsigned2 NoOfTransactions := COUNT(GROUP, ds_fragment_recs_sorted.file_type = File_Type_Const.IdentityActivity);
		unsigned2 NoOfRecentTransactions := COUNT(GROUP , ds_fragment_recs_sorted(ds_fragment_recs_sorted.file_type = File_Type_Const.IdentityActivity).date >= FraudGovPlatform_Services.Utilities.yesterday);
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
											//Cleaning out @@@ from LEFT.entity_value when //ELEMENT is of type address OR BANK ACCOUNT NUMBER,
											// @@@ was addded to calcualte the matching HASH value for tree_uid
											SELF.ElementValue := MAP(LEFT.entity_name = Fragment_Types_const.PHYSICAL_ADDRESS_FRAGMENT 
																									=> FraudGovPlatform_Services.Functions.GetCleanAddressFragmentValue(LEFT.entity_value),
																							LEFT.entity_name = Fragment_Types_const.BANK_ACCOUNT_NUMBER_FRAGMENT
																									=> FraudGovPlatform_Services.Functions.GetCleanBankAccountFragmentValue(LEFT.entity_value),
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
	
	// getting the records from deltabase database.
	ds_delta_recentTransactions := FraudGovPlatform_Services.mod_Deltabase_Functions(batch_params).getDeltabaseSearchRecords();
	
	//Getting the public records best to fill identity Detail card.
	ds_GovBest := FraudGovPlatform_Services.Functions.getGovernmentBest(ds_dids_to_use, batch_params);
	
	//Getting the Contributory best to fill identity Detail card.
	ds_contributoryBest := FraudGovPlatform_Services.Functions.getContributedBest(ds_dids_to_use, FraudGovPlatform_Services.Constants.FRAUD_PLATFORM);

	//realtime record:
	BOOLEAN isRealtimeRecord := adlDIDFound AND COUNT(ds_contributoryBest) = 0;
	
	ds_batch_in_orig := PROJECT(ds_input_with_adl_did, FraudShared_Services.Layouts.BatchIn_rec);
	ds_ExternalServices_recs := IF(isRealtimeRecord, 
																	FraudGovPlatform_Services.Functions.getExternalServicesRecs(ds_batch_in_orig, batch_params),
																	DATASET([], FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw));
																		
	ds_realtimescoring_rec := FraudGovPlatform_Services.mod_RealTimeScoring(ds_ExternalServices_recs, batch_params).ds_w_realTimeScore;

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
		SELF.ElementValue := MAP(L.fragment = Fragment_Types_const.PHYSICAL_ADDRESS_FRAGMENT 
																=> FraudGovPlatform_Services.Functions.GetCleanAddressFragmentValue(L.fragment_value),
														L.fragment = Fragment_Types_const.BANK_ACCOUNT_NUMBER_FRAGMENT
																=> FraudGovPlatform_Services.Functions.GetCleanBankAccountFragmentValue(L.fragment_value),
														L.fragment_value);

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
				 L.fragment = Fragment_Types_const.BANK_ACCOUNT_NUMBER_FRAGMENT => 
															ds_delta_recentTransactions(BankInformation1.BankAccountNumber = 
																			FraudGovPlatform_Services.Functions.GetCleanBankAccountFragmentValue(L.fragment_value)),
				 L.fragment = Fragment_Types_const.EMAIL_FRAGMENT => ds_delta_recentTransactions(
																																		STD.Str.ToUpperCase(STD.Str.CleanSPaces(EmailAddress)) = 
																																		STD.Str.ToUpperCase(STD.Str.CleanSPaces(L.fragment_value))),																			
				 L.fragment = Fragment_Types_const.DRIVERS_LICENSE_NUMBER_FRAGMENT => 
															ds_delta_recentTransactions(DriversLicense.DriversLicenseNumber = L.fragment_value AND 
																													DriversLicense.DriversLicenseState = ds_batch_in[1].dl_state),
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
														
	ds_realtimerecord := 	PROJECT(ds_realtimescoring_rec, 
													TRANSFORM(iesp.fraudgovsearch.t_FraudGovSearchRecord,
														SELF.AnalyticsRecordId := FraudGovPlatform_Services.Constants.KelEntityIdentifier._LEXID + (string)LEFT.LexID,
														SELF.RecordType := FraudGovPlatform_Services.Constants.RecordType.IDENTITY,
														SELF.RecordSource := 'REALTIME',
														SELF.ElementType := Fragment_Types_const.PERSON_FRAGMENT,
														SELF.ElementValue := (string)LEFT.LexID,
														SELF.Score := LEFT.risk_score,
														SELF.GovernmentBest := ds_GovBest[1],
														SELF.NoOfRecentTransactions := COUNT(ds_delta_recentTransactions(UniqueId = (string)LEFT.LexID)),
														SELF := []));														

	// output(ds_allPayloadRecs, named('ds_allPayloadRecs'));
	// output(ds_input_with_adl_did, named('ds_input_with_adl_did'));
	// output(adlDIDFound, named('adlDIDFound'));
	// output(ds_adl_in, named('ds_adl_in'));
	// output(ds_contributory_in, named('ds_contributory_in'));
	// output(ds_contributory_in_dedup, named('ds_contributory_in_dedup'));
	// output(ds_dids_to_use, named('ds_dids_to_use'));
	// output(ds_elements_dids, named('ds_elements_dids'));
	// output(ds_combinedfreg_recs, named('ds_combinedfreg_recs'));
	// output(ds_fragment_recs_w_value, named('ds_fragment_recs_w_value'));
	// output(ds_ElementsNIdentities, named('ds_ElementsNIdentities'));
	// output(ds_fragment_recs_sorted, named('ds_fragment_recs_sorted'));
	// output(ds_fragment_recs_rolled, named('ds_fragment_recs_rolled'));
	// output(ds_entityNameUID, named('ds_entityNameUID'));
	// output(ds_raw_cluster_recs, named('ds_raw_cluster_recs'));
	// output(ds_clusters, named('ds_clusters'));
	// output(ds_elementsInformation, named('ds_elementsInformation'));
	// output(ds_delta_recentTransactions,named('ds_delta_recentTransactions'));
	// output(ds_GovBest, named('ds_GovBest'));
	// output(ds_contributoryBest, named('ds_contributoryBest'));
	// output(isRealtimeRecord, named('isRealtimeRecord'));
	// output(ds_realtimescoring_rec, named('ds_realtimescoring_rec'));
	// output(ds_realtimerecord, named('ds_realtimerecord'));
	// output(ds_fragment_recs_tab, named('ds_fragment_recs_tab'));
	// output(ds_fragment_recs_w_scores, named('ds_fragment_recs_w_scores'));	
	// output(ds_ExternalServices_recs, named('ds_ExternalServices_recs'));	
	// output(ds_realtimescoring_rec, named('ds_realtimescoring_rec'));	
	
	EXPORT ds_results := SORT(IF(~isRealtimeRecord, (ds_ElementsNIdentities + ds_clusters), ds_realtimerecord), ElementType, ElementValue);
END; 
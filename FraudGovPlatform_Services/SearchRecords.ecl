﻿IMPORT BatchShare, DidVille, FraudGovPlatform_Services, FraudShared_Services, iesp, std;

EXPORT SearchRecords(DATASET(FraudShared_Services.Layouts.BatchInExtended_rec) ds_batch_in,
                     FraudGovPlatform_Services.IParam.BatchParams batch_params,
										 BOOLEAN IsOnline = FALSE) := FUNCTION
	
	//Defining the constants to be used later.
	Fragment_Types_const := FraudGovPlatform_Services.Constants.Fragment_Types;
	File_Type_Const := FraudGovPlatform_Services.Constants.PayloadFileTypeEnum;
	
	TodaysDate := std.date.today();
	YesterdayDate := TodaysDate - 1;

	// ***random_scores*** is temporary placeholder and will be repalced by Logic when we know how and where to get the actual score. 
	random_scores_ds := DATASET([{35}, {40}, {49}, {79}, {85}, {89}, {95}, {99}] , {unsigned1 num}); 
	random_score := ROUNDUP(count(random_scores_ds) * (((RANDOM()%100000)+1)/100000));
	// ***random_scores ends***
	
	// ***random_no_of_cluster*** is temporary placeholder and will be repalced by Logic when we know how and where to get the actual values. 
	random_no_of_cluster_ds := DATASET([{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}] , {unsigned1 num}); 
	random_no_of_cluster := ROUNDUP(count(random_no_of_cluster_ds) * (((RANDOM()%100000)+1)/100000));
	// ***random_scores ends***

	// ***random_no_of_identities*** is temporary placeholder and will be repalced by Logic when we know how and where to get the actual values. 
	random_no_of_identities_ds := DATASET([{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}] , {unsigned1 num}); 
	random_no_of_identities := ROUNDUP(count(random_no_of_identities_ds) * (((RANDOM()%100000)+1)/100000));
	// ***random_scores ends***

	// **************************************************************************************
	// Getting the payload records from FraudGov Payload key.
	// **************************************************************************************
	ds_allPayloadRecs := FraudGovPlatform_Services.fn_getadvsearch_raw_recs(ds_batch_in,
																																					batch_params.GlobalCompanyId,
																																					batch_params.IndustryType,
																																					batch_params.ProductCode,
																																					IsOnline := IsOnline);	
	
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
																											SELF.Seq := COUNTER,
																											SELF.did := LEFT.did,
																											SELF := []));

	ds_payload_best_in_dedup := DEDUP(SORT(ds_payload_best_in(did > 0), did), did);
	
	ds_best_in := IF(did_exists , ds_input_best_in , ds_payload_best_in_dedup);

	ds_Best := DidVille.did_service_common_function(ds_best_in,
																									appends_value      := 'BEST_ALL,VERIFY_ALL',
																									verify_value       := 'BEST_ALL,VERIFY_ALL',
																									glb_flag           := TRUE,
																									glb_purpose_value  := (integer) batch_params.GLBPurpose,
																									appType            := batch_params.ApplicationType,
																									include_minors     := TRUE,
																									IndustryClass_val  := batch_params.IndustryClass,
																									DRM_val            := batch_params.DataRestrictionMask,
																									GetSSNBest         := TRUE);
		
	//adding additional elements lexid's to ds_batch_in , so velocities can be calculated.
	ds_elements_dids := PROJECT(ds_payload_best_in_dedup, TRANSFORM(FraudShared_Services.Layouts.BatchInExtended_rec, 
																													SELF.acctno := '1',
																													SELF.did := LEFT.did,
																													SELF := []));
	
	ds_combinedfreg_recs := IF(did_exists, ds_batch_in, ds_batch_in + ds_elements_dids);
	ds_fragment_recs := FraudShared_Services.Functions.getFragmentMatchTypes(ds_combinedfreg_recs, ds_allPayloadRecs, batch_params);
	
	fragment_w_value_recs := RECORD
		FraudShared_Services.layouts.layout_velocity_in;
		STRING50 Email_Address;
		STRING60 fragment_value;
		UNSIGNED3 file_type;
		UNSIGNED4	LastActivityDate := 0;
		UNSIGNED4	LastKnownRiskDate := 0;
	END;

	fragment_w_value_recs  ds_fragment_recs_w_trans(FraudShared_Services.layouts.layout_velocity_in L, 
																									FraudShared_Services.Layouts.Raw_Payload_rec R)  := TRANSFORM
																																																
		SELF.fragment_value := MAP(	L.fragment = Fragment_Types_const.BANK_ACCOUNT_NUMBER_FRAGMENT => (string) R.bank_account_number_1,
																L.fragment = Fragment_Types_const.DEVICE_ID_FRAGMENT => (string) R.device_id,
																L.fragment = Fragment_Types_const.DRIVERS_LICENSE_NUMBER_FRAGMENT => (string) R.drivers_license,
																// L.fragment = Fragment_Types_const.GEOLOCATION_FRAGMENT => R.geo_lat + ' ' R.geo_long;
																L.fragment = Fragment_Types_const.IP_ADDRESS_FRAGMENT => (string) R.ip_address	,
																L.fragment = Fragment_Types_const.MAILING_ADDRESS_FRAGMENT => (string) (R.address_1 + ' ' + R.address_2),
																L.fragment = Fragment_Types_const.NAME_FRAGMENT => (string) R.raw_full_name	,
																L.fragment = Fragment_Types_const.PERSON_FRAGMENT => (string) R.did,
																L.fragment = Fragment_Types_const.PHONE_FRAGMENT => (string) R.phone_number,
																L.fragment = Fragment_Types_const.PHYSICAL_ADDRESS_FRAGMENT => (string) (R.street_1 + ' ' +	R.street_2 + ' ' + R.city + ' ' +	R.state + ' ' +	R.zip),
																L.fragment = Fragment_Types_const.SSN_FRAGMENT => (string) R.ssn,
																'');
		SELF.file_type := R.classification_Permissible_use_access.file_type;
		SELF.Email_Address := R.Email_Address;
		SELF := L;
	END;

	ds_fragment_recs_w_value := JOIN(ds_fragment_recs, ds_allPayloadRecs,
																		LEFT.record_id = RIGHT.record_id,
																		ds_fragment_recs_w_trans(LEFT, RIGHT));

	fragment_w_value_recs do_Rollup(fragment_w_value_recs L, dataset(fragment_w_value_recs) R) := TRANSFORM
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

	iesp.fraudgovsearch.t_FraudGovSearchRecord ElementsNIdentities_trans (fragment_w_value_recs L, ds_fragment_tab_Recs R)  := TRANSFORM
		boolean populateBest := L.fragment = Fragment_Types_const.PERSON_FRAGMENT;
		best_rec := ds_Best(L.fragment_value = (string)ds_Best.did)[1];
		
		SELF.RecordType := MAP(	L.fragment = Fragment_Types_const.PERSON_FRAGMENT => 'IDENTITY',
														L.fragment In FraudGovPlatform_Services.Constants.RECORD_TYPE_ELEMENT_SET => 'ELEMENT',
														'');
		SELF.ElementType := L.fragment;
		SELF.ElementValue := L.fragment_value;
		SELF.Score := random_scores_ds[random_score].num;
		SELF.NoOfIdentities := random_no_of_identities_ds[random_no_of_identities].num;;
		SELF.GovernmentBest.UniqueId := IF(populateBest, (string) best_rec.did, '');  
		SELF.GovernmentBest.Name.Prefix := IF(populateBest, best_rec.best_title	, ''); 
		SELF.GovernmentBest.Name.First := IF(populateBest, best_rec.best_fname, ''); 
		SELF.GovernmentBest.Name.Middle := IF(populateBest, best_rec.best_mname, ''); 
		SELF.GovernmentBest.Name.Last := IF(populateBest, best_rec.best_lname, ''); 
		SELF.GovernmentBest.Name.Suffix := IF(populateBest, best_rec.best_name_suffix, '');
		SELF.GovernmentBest.SSN := IF(populateBest, (string) best_rec.best_ssn, '');
		SELF.GovernmentBest.DOB := IF(populateBest, iesp.ECL2ESP.toDate((integer)best_rec.best_dob));
		SELF.GovernmentBest.Address := IF(populateBest,  iesp.ECL2ESP.SetAddress('',
																																							'', 
																																							'', 
																																							'', 
																																							'', 
																																							'', 
																																							'',
																																							best_rec.best_city,
																																							best_rec.best_state, 
																																							best_rec.best_zip, 
																																							best_rec.best_zip4, 
																																							'',
																																							'',
																																							best_rec.best_addr1));
		SELF.GovernmentBest.Phone10 := IF(populateBest,(string) best_rec.best_phone	, '');
		SELF.EmailAddress := L.email_address;
		SELF.NoOfClusters := random_no_of_cluster_ds[random_no_of_cluster].num;
		SELF.NoOfRecentTransactions := R.NoOfRecentTransactions; //Last 24 hours velocity count.
		SELF.NoOfTransactions := R.NoOfTransactions; //Total velocity count.
		SELF.NoOfKnownRisks := R.NoOfKnownRisks; //Total Known Risk count.
		SELF.LastActivityDate := iesp.ECL2ESP.toDate(L.LastActivityDate);
		SELF.LastKnownRiskDate := iesp.ECL2ESP.toDate(L.LastKnownRiskDate); //Highest Knownrisk date.
		// SELF.DollarAmount := '';
		// SELF.ClusterName := '';
		// SELF.ClusterNumber := '';
		// SELF.RateofGrowth := '';
		SELF := [];
	END;
	
	ds_ElementsNIdentities := JOIN(ds_fragment_recs_rolled, ds_fragment_recs_tab,
																	LEFT.fragment_value = RIGHT.fragment_value AND
																	LEFT.fragment = RIGHT.fragment,
																	ElementsNIdentities_trans(LEFT, RIGHT));
											
	// output(ds_batch_in, named('ds_batch_in'));
	// output(ds_input_with_did, named('ds_input_with_did'));
	// output(ds_input_best_in, named('ds_input_best_in'));
	// output(ds_payload_best_in, named('ds_payload_best_in'));
	// output(ds_best_in, named('ds_best_in'));
	// output(ds_Best, named('ds_Best'));
	// output(ds_elements_dids, named('ds_elements_dids'));
	// output(ds_fragment_recs, named('ds_fragment_recs'));
	// output(ds_combinedfreg_recs, named('ds_combinedfreg_recs'));
	// output(ds_fragment_recs_w_value, named('ds_fragment_recs_w_value'));
	// output(ds_fragment_recs_tab, named('ds_fragment_recs_tab'));
	// output(ds_fragment_recs_rolled, named('ds_fragment_recs_rolled'));
	// output(ds_ElementsNIdentities, named('ds_ElementsNIdentities'));
	// output(ds_otherElementsIdentities, named('ds_otherElementsIdentities'));
	// output(ds_records, named('ds_records'));
	RETURN ds_ElementsNIdentities;
END;
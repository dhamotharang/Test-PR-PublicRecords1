IMPORT BatchShare, DidVille, FraudGovPlatform_Services, FraudShared_Services, iesp;


EXPORT SearchRecords(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
                     FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION

	Fragment_Types_const := FraudGovPlatform_Services.Constants.Fragment_Types;	

	// ***random_scores*** is temporary placeholder and will be repalced by Logic when we know how and where to get the actual score. 
	random_scores_ds := dataset([{35}, {40}, {49}, {79}, {85}, {89}, {95}, {99}] , {unsigned num}); 
	random_score := ROUNDUP(count(random_scores_ds) * (((RANDOM()%100000)+1)/100000));
	// ***random_scores ends***
	
	// **************************************************************************************
	// Append DID for Input PII
	// **************************************************************************************	  
	ds_batch_in_with_did := BatchShare.MAC_Get_Scored_DIDs(ds_batch_in, batch_params, usePhone:=TRUE);

	DidVille.Layout_Did_OutBatch trans_to_BestADL_batchIn(FraudShared_Services.Layouts.BatchIn_rec L) := TRANSFORM
		SELF.phone10    := L.phoneno;
		SELF.fname      := L.name_first;
		SELF.mname      := L.name_middle;
		SELF.lname      := L.name_last;
		SELF.suffix			:= L.name_suffix;
		SELF            := L;
		SELF            := [];
	END;

	ds_best_in := PROJECT(ds_batch_in_with_did, trans_to_BestADL_batchIn(LEFT));
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

	ds_allPayloadRecs := FraudGovPlatform_Services.Raw_Records(ds_batch_in_with_did,
																															batch_params.GlobalCompanyId, 
																															batch_params.IndustryType, 
																															batch_params.ProductCode); 
																																																												
	ds_fragment_recs := FraudShared_Services.Functions.getFragmentMatchTypes(ds_batch_in_with_did, ds_allPayloadRecs, batch_params);

	fragment_w_value_recs := RECORD
		FraudShared_Services.layouts.layout_velocity_in;
		string fragment_value;
	END;

	fragment_w_value_recs  ds_fragment_recs_w_trans(FraudShared_Services.layouts.layout_velocity_in L, 
																									FraudShared_Services.Layouts.Raw_Payload_rec R)  := TRANSFORM
																																																
		SELF.fragment_value := MAP(	L.fragment = Fragment_Types_const.BANK_ACCOUNT_NUMBER_FRAGMENT => (string) R.bank_account_number_1,
																L.fragment = Fragment_Types_const.DEVICE_ID_FRAGMENT => (string) R.device_id,
																L.fragment = Fragment_Types_const.DRIVERS_LICENSE_NUMBER_FRAGMENT => (string) R.drivers_license,
																// L.fragment = Fragment_Types_const.GEOLOCATION_FRAGMENT => ,
																L.fragment = Fragment_Types_const.IP_ADDRESS_FRAGMENT => (string) R.ip_address	,
																L.fragment = Fragment_Types_const.MAILING_ADDRESS_FRAGMENT => (string) (R.street_1 + ' ' +	R.street_2 + ' ' + R.city + ' ' +	R.state + ' ' +	R.zip),
																L.fragment = Fragment_Types_const.NAME_FRAGMENT => (string) R.raw_full_name	,
																L.fragment = Fragment_Types_const.PERSON_FRAGMENT => (string) R.did,
																L.fragment = Fragment_Types_const.PHONE_FRAGMENT => (string) R.phone_number,
																L.fragment = Fragment_Types_const.PHYSICAL_ADDRESS_FRAGMENT => (string) (R.street_1 + ' ' +	R.street_2 + ' ' + R.city + ' ' +	R.state + ' ' +	R.zip),
																L.fragment = Fragment_Types_const.SSN_FRAGMENT => (string) R.ssn,
																'');
		SELF := L;
	END;

	ds_fragment_recs_w_value := JOIN(ds_fragment_recs, ds_allPayloadRecs,
																		LEFT.record_id = RIGHT.record_id,
																		ds_fragment_recs_w_trans(LEFT, RIGHT));

	fragment_w_value_recs trans_Rollup(fragment_w_value_recs L, fragment_w_value_recs R) := TRANSFORM
		SELF.Date := MAX(L.date, R.date);
		SELF := L;
	END;

	ds_fragment_recs_sorted := SORT(ds_fragment_recs_w_value, fragment_value, fragment, -date);

	ds_fragment_recs_rolled := ROLLUP(ds_fragment_recs_sorted, trans_Rollup(LEFT, RIGHT), fragment_value, fragment);

	iesp.fraudgovsearch.t_FraudGovSearchRecords records_trans (fragment_w_value_recs L, FraudShared_Services.Layouts.Raw_Payload_rec R)  := TRANSFORM

		boolean populateBest := L.fragment = Fragment_Types_const.PERSON_FRAGMENT;
		best_rec := ds_Best(L.fragment_value = (string)ds_Best.did)[1];
		
		SELF.RecordType := MAP(	L.fragment = Fragment_Types_const.PERSON_FRAGMENT => 'IDENTITY',
														L.fragment In FraudGovPlatform_Services.Constants.RECORD_TYPE_ELEMENT_SET => 'ELEMENT',
														'');
		SELF.ElementType := L.fragment;
		SELF.ElementValue := L.fragment_value;
		SELF.Score := random_scores_ds[random_score].num;
		// SELF.NoOfIdentities := ;
		SELF.BestInformation.UniqueId := IF(populateBest, (string) best_rec.did, '');  
		SELF.BestInformation.Name.Prefix := IF(populateBest, best_rec.best_title	, ''); 
		SELF.BestInformation.Name.First := IF(populateBest, best_rec.best_fname, ''); 
		SELF.BestInformation.Name.Middle := IF(populateBest, best_rec.best_mname, ''); 
		SELF.BestInformation.Name.Last := IF(populateBest, best_rec.best_lname, ''); 
		SELF.BestInformation.Name.Suffix := IF(populateBest, best_rec.best_name_suffix, '');
		SELF.BestInformation.SSN := IF(populateBest, (string) best_rec.best_ssn, '');
		SELF.BestInformation.DOB := IF(populateBest, iesp.ECL2ESP.toDate((integer)best_rec.best_dob));
		SELF.BestInformation.Address := IF(populateBest,  iesp.ECL2ESP.SetAddress('',
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
		SELF.BestInformation.Phone10 := IF(populateBest,(string) best_rec.best_phone	, '');
		SELF.EmailAddress := R.email_address;
		// SELF.NoOfClusters 
		// SELF.NoOfRecentTransactions
		// SELF.NoOfTransactions
		// SELF.NoOfKnownRisks
		SELF.LastActivityDate := iesp.ECL2ESP.toDate(L.date);
		SELF.LastKnownRiskDate := iesp.ECL2ESP.toDate(L.date);
		// SELF.DollarAmount := '';
		// SELF.ClusterName := '';
		// SELF.ClusterNumber := '';
		// SELF.RateofGrowth := '';
		SELF := [];
	END;
	
	ds_records := JOIN(ds_fragment_recs_rolled, ds_allPayloadRecs,
											LEFT.record_id = RIGHT.record_id,
											records_trans(LEFT, RIGHT));
	RETURN ds_records;
END;
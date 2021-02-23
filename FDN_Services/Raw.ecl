IMPORT iesp, Suppress, FraudDefenseNetwork;

EXPORT Raw := MODULE

	EXPORT byRecSrch(
		 DATASET(FDN_Services.Layouts.RecidUid_rec) ds_ids = dataset([],FDN_Services.Layouts.RecidUid_rec),
		 DATASET(FDN_Services.Layouts.batch_search_rec) flatInput,
		 unsigned6 gc_id_in,
		 unsigned2 ind_type_in,
		 unsigned6 product_code_in,
		 dataset(iesp.frauddefensenetwork.t_FDNIndType) ds_industry_types_in,
		 dataset(iesp.frauddefensenetwork.t_FDNFileType) ds_file_types_in,
		 INTEGER DeltaUse = 0,
		 INTEGER DeltaStrict = 0
		 ) := FUNCTION

		// JOIN RECORD_ID and UID with Payload
		ds_payload_plus_filterby := JOIN(ds_ids, FraudDefenseNetwork.Keys().main.id.qa,
												KEYED(LEFT.RECORD_ID = RIGHT.RECORD_ID),
												TRANSFORM(FDN_Services.Layouts.raw_rec,
												SELF.acctno := LEFT.acctno,
												SELF := RIGHT,
												SELF := LEFT),
												LIMIT(Constants.MAX_RECS_ON_JOIN, SKIP));

		filtered:= FDN_Services.Filter.filterRecs(ds_payload_plus_filterby);

		// Don't return records for certain DIDs
		Suppress.MAC_Suppress(filtered,recs_pulled0,Suppress.Constants.ApplicationTypes.DEFAULT,Suppress.Constants.LinkTypes.DID,did);

		// Don't return records for certain SSNs
		Suppress.MAC_Suppress(recs_pulled0,recs_pulled1,Suppress.Constants.ApplicationTypes.DEFAULT,Suppress.Constants.LinkTypes.SSN,ssn);

		// Don't return records for certain FDN Record ID
		Suppress.MAC_Suppress(recs_pulled1,recs_pulled2,Suppress.Constants.ApplicationTypes.DEFAULT,,,Suppress.Constants.DocTypes.FDN_ID,Record_ID);

		// Supress criminal records
		Suppress.MAC_Suppress(recs_pulled2,recs_pulled,Suppress.Constants.ApplicationTypes.DEFAULT,,,Suppress.Constants.DocTypes.OffenderKey, offender_key);


	  //Calling deltabase if deltabase = 1
    deltabaseResult   := IF(DeltaUse = 1, FDN_Services.deltabase(flatInput, recs_pulled, ds_file_types_in, DeltaStrict));


	  //Appending Keys and Deltabase results
  	AppendDeltaKey := IF(EXISTS(deltabaseResult),
											   DEDUP((deltabaseResult + recs_pulled), classification_Permissible_use_access.fdn_file_info_id, Transaction_ID),
											   recs_pulled);

	  //Call filtering logic
	  FilterResult := FDN_Services.SearchByExclusion(AppendDeltaKey, gc_id_in, ind_type_in, product_code_in,
									  ds_industry_types_in, ds_file_types_in);


		  // OUTPUT(ds_payload_plus_filterby, NAMED('Before_Suppression'));
		  // OUTPUT(recs_pulled0, NAMED('After_DID_suppression'));
	    // Suppress.MAC_Suppress(ds_payload,just_SSN_pulled,Suppress.Constants.ApplicationTypes.DEFAULT,Suppress.Constants.LinkTypes.SSN,ssn);
			// OUTPUT(just_SSN_pulled, NAMED('Just_SSN_Suppression'));
		  // Suppress.MAC_Suppress(ds_payload,just_FDN_ID_pulled,Suppress.Constants.ApplicationTypes.DEFAULT,'','',Suppress.Constants.DocTypes.FDN_ID,record_id);
			// OUTPUT(just_FDN_ID_pulled, NAMED('Just_FDN_ID_Suppression'));
	    // OUTPUT(deltabaseResult, NAMED('Deltabase_Result'));
			// OUTPUT(AppendDeltaKey, NAMED('Append_DeltaKey'));
			// OUTPUT(filtered, NAMED('FilterResult'));
	 // OUTPUT(ds_payload_plus_filterby, NAMED('ds_payload_plus_filterby'));
	 RETURN FilterResult;
	END;
END;

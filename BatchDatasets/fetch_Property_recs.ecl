
IMPORT BatchServices, suppress;

/*
	NOTE: BatchServices.Property_BatchService_Records does not process a DID existing in the input.
	So, if you're interested in obtaining Property records that may be different than the	input 
	address, it's most helpful if you send as the ds_batch_in parameter only the acctno and ssn.
*/

EXPORT fetch_Property_recs( DATASET(Layouts.batch_in) ds_batch_in , 
                            unsigned1 nss =suppress.constants.NonSubjectSuppression.doNothing, 
                            boolean isFCRA=FALSE) :=
	FUNCTION  
		
		//generate based on stored values
		UNSIGNED PARTY_TYPE := BatchServices.Functions.LN_Property.return_party_types;
    SET OF STRING record_types := BatchServices.Functions.LN_Property.return_record_types;

		// Transform input to rec_inBatchMaster, get Property records, rejoin to acctnos, and return.
		data_in := PROJECT( ds_batch_in, Transforms.xfm_to_inBatchMaster(LEFT) );
		
		p := BatchServices.Property_BatchService_Records(data_in, record_types, party_type, nSS, isFCRA);
		
		ds_property_recs := 
			JOIN(
				p.ds_all_fares_ids, p.ds_property_recs,
				LEFT.ln_fares_id = RIGHT.ln_fares_id AND
				LEFT.search_did = RIGHT.search_did,
				TRANSFORM( BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos,
					SELF := LEFT,
					SELF := RIGHT
				),
				INNER,
				LIMIT(Constants.Limits.MAX_JOIN_LIMIT,SKIP)
			);
											 
		RETURN ds_property_recs;
	END;
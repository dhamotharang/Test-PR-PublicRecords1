
IMPORT BatchServices, Patriot;

EXPORT OFAC_BatchService_Records(GROUPED DATASET(Patriot.Layout_batch_in) ds_input_recs, unsigned1 ofac_version = 1, real threshold_value = 0.75) :=
	FUNCTION
		
		ds_recs := Patriot.Search_Batch_Function( ds_input_recs, 
																							ofaconly_value  := FALSE, 
																							threshold_value := threshold_value,
																							ofac_version := ofac_version,
																							include_ofac    := TRUE,
																							include_additional_watchlists := TRUE
																						 );
																						 
		RETURN PROJECT(ds_recs, BatchServices.xfm_OFAC_make_flat(LEFT));
		
	END;
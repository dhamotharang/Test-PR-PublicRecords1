
IMPORT BatchServices, Patriot;

EXPORT OFAC_BatchService_Records(GROUPED DATASET(Patriot.Layout_batch_in) ds_input_recs) :=
	FUNCTION
		
		ds_recs := Patriot.Search_Batch_Function( ds_input_recs, 
																							ofaconly_value  := FALSE, 
																							threshold_value := .75,
																							ofac_version    := 1,
																							include_ofac    := TRUE,
																							include_additional_watchlists := TRUE
																						 );
																						 
		RETURN PROJECT(ds_recs, BatchServices.xfm_OFAC_make_flat(LEFT));
		
	END;
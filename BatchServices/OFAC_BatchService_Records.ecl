
IMPORT BatchServices, Patriot, iesp;

EXPORT OFAC_BatchService_Records(GROUPED DATASET(Patriot.Layout_batch_in) ds_input_recs,  
																																	Boolean ofaconly_value = false, 
																																	Real threshold_value = 0.75, 
																																	unsigned1 ofac_version = 1, 
																																	Boolean include_ofac = True, 
																																	Boolean include_additonal_watchlists = True) :=
	FUNCTION

		ds_recs := Patriot.Search_Batch_Function( ds_input_recs, 
																							ofaconly_value, 
																							threshold_value,
																							ofac_version,
																							include_ofac,
																							include_additional_watchlists := include_additonal_watchlists,
																							dob_radius := -1,
																							watchlists_requested := dataset([], iesp.share.t_StringArrayItem),
																							exclude_aka := false,
																							exclude_weakaka := false
																						 );
																						 
		RETURN PROJECT(ds_recs, BatchServices.xfm_OFAC_make_flat(LEFT));
		
	END;
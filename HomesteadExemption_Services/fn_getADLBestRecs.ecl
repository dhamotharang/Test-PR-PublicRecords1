IMPORT Address, BatchDatasets, Didville;

EXPORT fn_getADLBestRecs(DATASET(HomesteadExemption_Services.Layouts.batch_in) ds_batch_in, HomesteadExemption_Services.IParams.BatchParams in_mod ) :=
	FUNCTION
		
		ds_batch_in_with_seq :=
			PROJECT(
				ds_batch_in,
				TRANSFORM( {INTEGER seq, HomesteadExemption_Services.Layouts.batch_in},
					SELF.seq := COUNTER,
					SELF := LEFT
				)
			);
			
		// 1. Fetch Best ADL records, filter, and retrieve the best_ssn and calculate age.
		Didville.Layout_Did_OutBatch
				ds_ADL_best_recs := BatchDatasets.fetch_ADLBest_recs(ds_batch_in, in_mod);
				
		ranked_best_addr := HomesteadExemption_Services.fn_getRankedAddrBestRecs(GROUP(ds_ADL_best_recs));
		
		ds_ADL_best_recs_filtered := ranked_best_addr(score >= in_mod.DIDScoreThreshold);

		ds_ADL_best_results := 
			JOIN(
				ds_batch_in_with_seq, ds_ADL_best_recs_filtered,
				LEFT.seq = RIGHT.seq,
				TRANSFORM( Layouts.layout_temp_ADLBest_recs,
					SELF.acctno    := LEFT.acctno,
					SELF.did       := RIGHT.did,
					SELF           := RIGHT // Best fields
				),
				LEFT OUTER,
				KEEP(1)
			);
		IF( in_mod.ViewDebugs, 
				OUTPUT( ds_ADL_best_recs, NAMED('ADL_best_results') ) );
				
		RETURN ds_ADL_best_results;
	END;
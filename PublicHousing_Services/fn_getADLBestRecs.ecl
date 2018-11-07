
IMPORT BatchDatasets, Didville;

EXPORT fn_getADLBestRecs(DATASET(Layouts.batch_in) ds_batch_in, IParams.BatchParams in_mod ) :=
	FUNCTION
		
		// 1. Add a sequence # for use in the join that follows, since BatchDatasets.fetch_ADLBest_recs
		// adds it also.
		ds_batch_in_with_seq := 
			PROJECT( 
				ds_batch_in, 
				TRANSFORM( {Layouts.batch_in, INTEGER seq},
					SELF.seq := COUNTER,
					SELF := LEFT
				)
			);
		
		// 2. Fetch Best ADL records, filter, and retrieve the best_ssn.
		didville.Layout_Did_OutBatch
				ds_ADL_best_recs := BatchDatasets.fetch_ADLBest_recs(ds_batch_in, in_mod);
		
		ds_ADL_best_recs_filtered := ds_ADL_best_recs(score >= Constants.Defaults.DIDScoreThreshold);
		
		ds_ADL_best_results := 
			JOIN(
				ds_batch_in_with_seq, ds_ADL_best_recs_filtered,
				LEFT.seq = RIGHT.seq,
				TRANSFORM( Layouts.rec_adl_best,
					SELF.acctno   := LEFT.acctno,
					SELF.LexID    := (STRING20)RIGHT.did,
					SELF.best_ssn := RIGHT.best_ssn
				),
				LEFT OUTER,
				KEEP(1)
			);
		
		IF( in_mod.ViewDebugs, 
				OUTPUT( ds_ADL_best_recs, NAMED('ADL_best_results') ) );
		
		RETURN ds_ADL_best_results;
	END;
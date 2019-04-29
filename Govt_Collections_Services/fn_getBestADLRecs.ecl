IMPORT BatchShare, Didville, Govt_Collections_Services;

EXPORT fn_getBestADLRecs(dataset(Govt_Collections_Services.Layouts.batch_working) ds_batch_in,
                        Govt_Collections_Services.IParams.BatchParams in_mod
												) := FUNCTION
		// Fulfills _documentation, Req. 4.1.11
		// Basis: DidVille.Did_Batch_Service_Raw
		// 1. Add seq # to input dataset and transform address data provided in ds_best_addrs.
		ds_batch_in_with_seq :=
			PROJECT(
				ds_batch_in,
				TRANSFORM(Govt_Collections_Services.Layouts.batch_working_plus_seq,
					SELF.seq := COUNTER,
					SELF     := LEFT
				)
			);

		data_in := PROJECT( ds_batch_in_with_seq, Transforms.xfm_to_BestADL_batchIn(LEFT) );
		
		// 3. Get Best records and filter on score...
		ds_ADL_best_recs := // call function
				DidVille.did_service_common_function(
					file_in            := data_in,
					appends_value      := 'BEST_ALL,VERIFY_ALL',
					verify_value       := 'BEST_ALL,VERIFY_ALL',
					glb_flag           := TRUE,
					glb_purpose_value  := in_mod.glb,
					appType            := in_mod.application_type,
					include_minors     := in_mod.show_minors,
					IndustryClass_val  := in_mod.industry_class,
					DRM_val            := in_mod.DataRestrictionMask,
					GetSSNBest         := in_mod.GetSSNBest
				);
		
		ds_ADL_best_recs_filtered := ds_ADL_best_recs(score >= in_mod.DIDScoreThreshold);
		
		// 4. ...and join back to batch_in and return.
		ds_best_adl_results := 
			JOIN(
				ds_batch_in_with_seq, ds_ADL_best_recs_filtered,
				LEFT.seq = RIGHT.seq,
				TRANSFORM( Govt_Collections_Services.Layouts.batch_working,
				  is_fuzzy_fname_match := BatchShare.Functions.fn_FuzzyFirstNameMatch(
																										LEFT.name_first, LEFT.name_middle, 
																										RIGHT.best_fname, RIGHT.best_mname);
					is_fuzzy_lname_match := BatchShare.Functions.fn_FuzzyLastNameMatch(
																										LEFT.name_middle, LEFT.name_last, 
																										RIGHT.best_mname, RIGHT.best_lname); 
					SELF.is_fuzzy_fname_match := is_fuzzy_fname_match;
					SELF.is_fuzzy_lname_match := is_fuzzy_lname_match;
					SELF.is_fuzzy_full_name_match := (is_fuzzy_fname_match AND is_fuzzy_lname_match) OR
																						(LEFT.name_first = RIGHT.best_lname AND 
																						 LEFT.name_last = RIGHT.best_fname); 
					SELF.best_fname := RIGHT.best_fname,
					SELF.best_lname := RIGHT.best_lname,
					SELF.lex_id     := IF( RIGHT.did > 0, (STRING20)RIGHT.did, '' ),
					SELF            := LEFT
				),
				LEFT OUTER,
				KEEP(1)
			);
		
		IF( in_mod.ViewDebugs, 
				OUTPUT( ds_ADL_best_recs, NAMED('ds_bestADL_intm_recs') ) );
			
		RETURN ds_best_adl_results;
		
	END;
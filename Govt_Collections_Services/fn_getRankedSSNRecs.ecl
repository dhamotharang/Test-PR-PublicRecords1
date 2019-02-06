IMPORT SSNBest_Services, Govt_Collections_Services;

EXPORT fn_getRankedSSNRecs(dataset(Govt_Collections_Services.Layouts.batch_working) ds_batch_in,
                           Govt_Collections_Services.IParams.BatchParams in_mod ) := FUNCTION
		
		working_rec := record
			Govt_Collections_Services.layouts.batch_working;
			INTEGER other_cnt := 0;
			INTEGER did;
		end;
				
		ds_ssn_in := PROJECT(ds_batch_in, TRANSFORM(working_rec, 
																				SELF.did := (INTEGER)LEFT.lex_id,
																				SELF := LEFT));

		mod_ssn_batch := MODULE (PROJECT (in_mod, SSNBest_Services.IParams.BatchParams, OPT)) END;
		ds_ranked_ssn_recs := SSNBest_Services.Functions.fetchSSNs(ds_ssn_in(did <> 0), mod_ssn_batch);
		
		// 4. Join back to batch_in and assign best ssn and the correct code to poss_shared_ssn--that's 
		// all we're doing here. Then return.			
		ds_ranked_ssn_results := JOIN(ds_batch_in, ds_ranked_ssn_recs, 
																	LEFT.acctno = RIGHT.acctno,
																			TRANSFORM(Govt_Collections_Services.layouts.batch_working,
																			SELF.best_ssn := RIGHT.best_ssn;
																			SELF.poss_shared_ssn := 
																						IF(RIGHT.other_cnt >= 4, 'Y', ''),
																			SELF.best_ssn_is_poss_shared := RIGHT.best_ssn != '' AND 
																																			RIGHT.other_cnt >= 4 AND 
																																			LEFT.expanded_ssn = '' AND 
																																			(LEFT.ssn = '' OR 
																																			(LENGTH(TRIM(LEFT.ssn)) != 9)),														
													
																			SELF.input_is_best_ssn :=  RIGHT.best_ssn <> '' AND 
																															   (LEFT.ssn = RIGHT.best_ssn OR 
																																		LEFT.expanded_ssn = RIGHT.best_ssn),
																			SELF := LEFT), LEFT OUTER);					
																	
		IF( in_mod.ViewDebugs, 
				OUTPUT( ds_ranked_ssn_recs, NAMED('ds_ranked_ssn_intm_recs') ) );

		RETURN ds_ranked_ssn_results;
		
	END;
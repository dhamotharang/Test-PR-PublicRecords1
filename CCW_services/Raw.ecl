import emerges, ccw_services, FCRA, ut, FFD;

export Raw := MODULE;
		
		//============================================================================
		// Attribute: ccw_raw.  Used by view source service and comp-report.
		// Function to get concealed weapon records by did.
		// Return value: dataset. Layout: rawrec
		//============================================================================
		// pass in a did and get back all information
		export 	byDIDs(dataset(ccw_services.Layouts.search_did) in_dids, boolean isFCRA = false) := function
		 
			deduped := dedup(sort(in_dids,did),did);
			//allow for using FCRA version of the key
			joinup := join(deduped,emerges.Key_ccw_did(isFCRA),keyed( left.did  = right.did_out6), 
											transform(ccw_services.Layouts.search_rid,
												self := right),limit(ut.limits.CCW_PER_DID, skip));
							 
			return joinup;
		end;

    // Note: at this point we do not have CCW batch services, so this code is exicuted for a single person;
    //       for example, there's no danger to link one person's consumer statement to another person.
		export  byRids(dataset(ccw_services.Layouts.search_rid) in_recs, boolean isFCRA = false, 
									 dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
									 dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
									 integer8 inFFDOptionsMask = 0,
									 boolean is_CNSMR = false
									 ) := function
		 
			boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
			boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);

			ccw_correct_rec_id := SET (flagfile (file_id = FCRA.FILE_ID.CCW), record_id);
			ccw_correct_ffid := SET (flagfile (file_id = FCRA.FILE_ID.CCW), flag_file_id);

			// join to payload key.
			recs_clean := join(in_recs, emerges.key_ccw_rid(isFCRA),
										keyed(left.rid = right.rid) and
			  						(~isFCRA or (string)right.persistent_record_id NOT IN ccw_correct_rec_id)
										and ~ccw_services.functions.isRestricted(is_CNSMR, right.Source_Code), // D2C - consumer restriction
				    			 transform( ccw_services.layouts.rawrec, self := right), 
									 keep(1), limit(0));

			// overrides
			recs_over := CHOOSEN (fcra.key_override_ccw.concealed_weapons(keyed (flag_file_id IN ccw_correct_ffid)),
														FCRA.compliance.MAX_OVERRIDE_LIMIT);

			// put overrides into same layout, combine main data and overrides;
			recs_override_final := project (recs_over, transform (ccw_services.layouts.rawrec, self.rid := 0,	Self := Left));
			
			recs_fcra := recs_clean + recs_override_final;
			
			// Supress disputed records and fill the statement_ids 				
			ccw_services.Layouts.rawrec xformStatements( recs_fcra l, FFD.Layouts.PersonContextBatchSlim r ) := transform,
			skip(( ~showDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))						
					self.StatementIDs := r.StatementIDs;
					self.iSDisputed := r.isDisputed;
					self := l;
			end;
			
			recs_final_fcra := join(recs_fcra, slim_pc_recs, 
				left.persistent_record_id = (integer) right.RecID1,
				xformStatements(left, right), 
				left outer, keep(1), limit(0));
																														
			recs := if (isFCRA, recs_final_fcra, recs_clean);		
			
			return recs;
		end;
end;		
		
		
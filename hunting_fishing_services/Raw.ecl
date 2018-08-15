import eMerges, FCRA, ut, Census_Data, FFD;

export Raw := MODULE
	export byDIDs(dataset(hunting_fishing_services.layouts.search_did) in_dids, boolean isFCRA = false) := function
			deduped := dedup(sort(in_dids,did),did);
			joinup := join(deduped,eMerges.Key_HuntFish_Did(isFCRA),
			               keyed(left.did=right.did),
										 transform(hunting_fishing_services.layouts.search,
															 self := right),LIMIT(ut.limits.HUNTERS_PER_DID)); 
			return joinup;
		end;
		
	 export  byRids(dataset(hunting_fishing_services.Layouts.search) in_recs, boolean isFCRA = false, 
									dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
									dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
									integer8 inFFDOptionsMask = 0) := function
		 
			boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
			boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);

			hunt_fish_correct_rec_id := SET (flagfile (file_id = FCRA.FILE_ID.HUNTING_FISHING), record_id);
			hunt_fish_correct_ffid   := SET (flagfile (file_id = FCRA.FILE_ID.HUNTING_FISHING), flag_file_id);

			// join to payload key.
			recs_1 := join(in_recs,eMerges.Key_HuntFish_Rid(isFCRA),
												(keyed(left.rid= right.rid)) and
												(~isFCRA or (string)right.persistent_record_id NOT IN hunt_fish_correct_rec_id),
												transform(hunting_fishing_services.Layouts.raw_rec,
																	self.StatementIds := [],
																	self:=left,
																	self:=right), limit(0), keep(1));
																
			// overrides
			recs_over := CHOOSEN (fcra.key_override_hunting_fishing.hunting_fishing(keyed (flag_file_id IN hunt_fish_correct_ffid)),
																FCRA.compliance.MAX_OVERRIDE_LIMIT);

			// put overrides into same layout, combine main data and overrides;
			recs_override_final := project (recs_over, transform (hunting_fishing_services.Layouts.raw_rec,
																																Self := Left, self.StatementIds := [], self.rid := 0));
						
			recs_fcra := recs_1 + recs_override_final;
										
			//add statementids  & add dispute indicators/remove disputed records
			
			hunting_fishing_services.Layouts.raw_rec xformStatements( hunting_fishing_services.Layouts.raw_rec l, 
																																FFD.Layouts.PersonContextBatchSlim r ) := transform,
			skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
					self.StatementIDs := r.StatementIDs;
					self.IsDisputed   := r.isDisputed;
					self := l;
			end;
			
			recs_final_ds := join(recs_fcra,slim_pc_recs,
															 left.persistent_record_id = (integer) right.RecID1,
															 xformStatements(left,right), 
															 left outer,
															 keep(1),
															 limit(0));
			
			
																							
			recs := if (isFCRA, recs_final_ds, recs_1);			
			
			recs_countyname := join (recs, Census_Data.Key_Fips2County,
												     left.mail_st = right.state_code and
												     left.mail_fipscounty  = right.county_fips,											 
														 transform(hunting_fishing_services.Layouts.raw_rec, 
																			 self.mail_county_name := right.county_name, 
																			 self := left),
														 LEFT OUTER, limit(0), keep(1));
									 
			return recs_countyname;
		end;

end;

IMPORT doxie, fcra, Prof_LicenseV2, ut, RiskView, riskwise;

EXPORT _Prof_License_data(dataset (doxie.layout_references) dids, dataset (fcra.Layout_override_flag) flag_file,
																						boolean isDirectToConsumerPurpose=false, unsigned1 year_limit = 0) := FUNCTION

		key_did := Prof_LicenseV2.Key_Proflic_Did (true);
		Layout_ProfLic := recordof(key_did);

		proflic_ffids := SET(flag_file(file_id = FCRA.FILE_ID.PROFLIC), flag_file_id );
		proflic_ids   := SET(flag_file(file_id = FCRA.FILE_ID.PROFLIC), record_id );

		proflic_main := join(dids,key_did,
			left.did<>0 and keyed(left.did=right.did) and right.prolic_key not in proflic_ids
			AND (isDirectToConsumerPurpose = false OR right.vendor <> RiskView.Constants.directToConsumerPL_sources),
			transform( layout_proflic, self := right ),
			KEEP(100), atmost(riskwise.max_atmost));

		proflic_deduped := dedup(sort(proflic_main,record),all);

		proflic_corr  := CHOOSEN(FCRA.key_override_proflic_ffid( keyed( flag_file_id in proflic_ffids ) ), FCRA.compliance.MAX_OVERRIDE_LIMIT );
		proflic_all  := proflic_deduped + PROJECT( proflic_corr(isDirectToConsumerPurpose = false OR  vendor <> RiskView.Constants.directToConsumerPL_sources),
				transform( Layout_Proflic,
					self.did := (integer)left.did,
					self.prolic_seq_id := 0,
					self := LEFT,
					self:= [] 				//RR-14824 CCPA Changes
				));
				
		prolic_grp := group( sort( proflic_all( prolic_key!=''), prolic_key, -date_last_seen ), prolic_key );
		proflic_recs1 := rollup( prolic_grp, true,
			transform( Layout_Proflic,
				self.date_first_seen := (string)min( (unsigned)left.date_first_seen, (unsigned)right.date_first_seen), // maintain an accurate date first seen
				self := left
			)
		);
		
		todaysdate := ut.GetDate;
		//if called from benefitassessment_batchservicefcra, we only want records from the last 7 years
		proflic_recs_filtered := proflic_recs1(ut.fn_date_is_ok(todaysdate, date_last_seen, year_limit));
		
		proflic_recs2 := if(year_limit=0, proflic_recs1, proflic_recs_filtered);

		proflic_recs := sort(proflic_recs2, -date_last_Seen, -date_first_seen);
		
		// output(flag_file,named('flag_file'));
		// ff_pl := flag_file(file_id = FCRA.FILE_ID.PROFLIC);
		// output(ff_pl,named('ff_pl'));
		// output(proflic_main,named('proflic_main'));
		// output(proflic_deduped,named('proflic_deduped'));
		// output(proflic_corr,named('proflic_corr'));
		// output(proflic_all,named('proflic_all'));
		// output(prolic_grp,named('prolic_grp'));
		// output(proflic_recs1,named('proflic_recs1'));
		// output(proflic_recs_filtered,named('proflic_recs_filtered'));
		// output(proflic_recs2,named('proflic_recs2'));
		// output(proflic_recs,named('proflic_recs'));
		
	return proflic_recs;
END;
//============================================================================
// Attribute: Hunt_raw.  Used by view source service and comp-report.
// Function to get hunting and fishing records by did.
// Return: dataset.  Layout: plusdid.
//============================================================================
import emerges, doxie_files, codes, Doxie, ut, Census_Data, suppress, FCRA, FFD;

export Hunt_Raw(dataset(Doxie.layout_references) dids,
								unsigned3 dateVal = 0,
								unsigned1 dppa_purpose = 0,
								unsigned1 glb_purpose = 0,
								string6 ssn_mask_value = 'NONE',
								boolean isFCRA = false,
								dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
								dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
								integer8 inFFDOptionsMask = 0
							) := FUNCTION

		boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
		boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
		// FCRA: overrides
		// persistent_record_id is used for identifying exactly a record which needs to be suppressed or corrected
		hunt_fish_correct_id := SET (flagfile (file_id = FCRA.FILE_ID.HUNTING_FISHING), record_id);
		hunt_fish_correct_ffid := SET (flagfile (file_id = FCRA.FILE_ID.HUNTING_FISHING), flag_file_id);
	 
		hunt_key := doxie_files.key_hunters_did(isFCRA); 
		
		out_rec := record(emerges.layout_hunters_out)
			unsigned6	did := 0;
			string20	home_state_name := '';
			string20	source_state_name := '';
			string10  gender_name := '';
			FFD.Layouts.CommonRawRecordElements;
		end;
		
		raw := join(dids, hunt_key, 
							 keyed (left.did=right.did) and
							 (dateVal = 0 OR (unsigned3)(right.date_first_seen[1..6]) <= dateVal)
							 and (~isFCRA or (string)right.persistent_record_id not in hunt_fish_correct_id),
							 transform(out_rec,
												 self.did := (unsigned6)right.did_out,
												 self.gender_name := CODES.GENERAL.GENDER(right.gender),
												 self := right)
								, LIMIT (ut.limits.HUNTERS_PER_DID, SKIP));
			
		// overrides
		hunt_override := CHOOSEN (fcra.key_override_hunting_fishing.hunting_fishing(keyed (flag_file_id IN hunt_fish_correct_ffid)),
														FCRA.compliance.MAX_OVERRIDE_LIMIT);

		// put overrides into same layout, combine main data and overrides;
		hunt_override_st := project (hunt_override, transform (out_rec, 
																											Self.did := (unsigned6) Left.did_out, 
																											Self := Left));
		hunt_fcra := raw + hunt_override_st;

		out_rec xformAddStatementIDs(out_rec l, FFD.Layouts.PersonContextBatchSlim r) := transform,
			skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
			self.StatementIDs := r.StatementIDs,
			self.isDisputed := r.isDisputed,
			self := l
		end;

		hunt_fcra_ffd := join(hunt_fcra, slim_pc_recs(datagroup = FFD.Constants.DataGroups.HUNTING_FISHING),
			 (string)left.persistent_record_id = right.RecID1 and
			 (((unsigned)left.did_out  = (unsigned) right.lexid) OR (right.acctno = FFD.Constants.SingleSearchAcctno))
			 , xformAddStatementIDs(left, right), 
			 left outer, keep(1), limit(0));

		hunt_raw := if (IsFCRA, hunt_fcra_ffd, raw);
				
		codes.mac_map_state(hunt_raw,homestate,home_state_name,w_home_state);
		codes.mac_map_state(w_home_state,source_state,source_state_name,w_sourcestate);
		census_data.MAC_Fips2County_Keyed(w_sourcestate,st,county,county_name,wcounty);

		out_f := sort(wcounty, whole record);

		doxie.MAC_PruneOldSSNs(out_f, out_f_pruned, best_ssn, did_out, isFCRA);
		suppress.MAC_Mask(out_f_pruned, out_mskd, best_ssn, blank, true, false);

		return out_mskd;

END;

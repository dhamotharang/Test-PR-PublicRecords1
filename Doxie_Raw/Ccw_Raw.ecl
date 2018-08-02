//============================================================================
// Attribute: ccw_raw.  Used by view source service and comp-report.
// Function to get concealed weapon records by did.
// Return value: dataset. Layout: plusdid.
//============================================================================

import emerges, doxie_files, codes, Doxie, ut, suppress, Census_Data, FCRA, FFD;

export Ccw_Raw(
							 dataset(Doxie.layout_references) dids,
							 unsigned3 dateVal = 0,
							 unsigned1 dppa_purpose = 0, // reserved
							 unsigned1 glb_purpose = 0, // reserved
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
   correct_ccw_id := SET (flagfile (file_id = FCRA.FILE_ID.CCW), record_id);
   correct_ccw_ffid := SET (flagfile (file_id = FCRA.FILE_ID.CCW), flag_file_id);
   
   ccw_key := doxie_files.key_ccw_did(isFCRA);
   
   out_rec := record
   	emerges.layout_ccw_out;
   	unsigned6	did;
   	string10	gender_mapped := '';
   	string10	race_mapped := '';
   	string10	source_state_name := '';
		FFD.Layouts.CommonRawRecordElements;
   end;
   
   raw := join(dids, ccw_key,
              keyed (left.did=right.did)
              and (dateVal = 0 OR (unsigned3)(right.date_first_seen[1..6]) <= dateVal)
									 and (~isFCRA or (string)right.persistent_record_id not in correct_ccw_id)
              ,transform(out_rec, self.did := (integer)right.did_out, self := right),
   					 LIMIT (ut.limits.CCW_PER_DID, SKIP));
   
   // overrides
   ccw_override := CHOOSEN (fcra.key_override_ccw.concealed_weapons(keyed (flag_file_id IN correct_ccw_ffid)),
                            FCRA.compliance.MAX_OVERRIDE_LIMIT);
   
   // put overrides into same layout, combine main data and overrides;
   ccw_override_st := project (ccw_override, transform (out_rec, 
																											Self.did := (unsigned6) Left.did_out, 
																											Self := Left));
   ccw_fcra := raw + ccw_override_st;
	 
	 out_rec addStatementIDs(out_rec L, FFD.Layouts.PersonContextBatchSlim R) := transform,
	 skip((~showDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
		self.StatementIDs := r.StatementIDs;
		self.isDisputed :=	r.isDisputed;
		self := L;
   end;
		
	 ccw_fcra_ffd := join(
		ccw_fcra, slim_pc_recs(datagroup = FFD.Constants.DataGroups.CCW),
		(string) left.persistent_record_id = right.recid1
		and (left.did = (unsigned) right.lexid OR right.acctno = FFD.Constants.SingleSearchAcctno),
		addStatementIDs(left, right), 
		left outer, keep(1), limit(0)
		);				 
	 
   ccw_raw := if (IsFCRA, ccw_fcra_ffd, raw);
   
   census_data.MAC_Fips2County_Keyed(ccw_raw,st,county,county_name,f2)
   codes.mac_map_gender(f2,gender,gender_mapped,f3)
   codes.mac_map_race(f3,race,race_mapped,f4)
   codes.mac_map_state(f4,source_state,source_state_name,fetched)
  
   out_f := sort(fetched, whole record);
   
   doxie.MAC_PruneOldSSNs(out_f, out_f_pruned, best_ssn, did_out, isFCRA);
   suppress.MAC_Mask(out_f_pruned, out_mskd, best_ssn, blank, true, false);
   
   return out_mskd;
   
END;

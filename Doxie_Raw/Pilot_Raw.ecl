//============================================================================
// Attribute: Pilot_Raw.  Used by view source service and comp-report.
// Function to get pilot records by did.
// Return value: Dataset of layout doxie_crs/layout_pilot_records.
//============================================================================

import faa, doxie_crs, doxie, ut, suppress, FCRA, FFD;

export Pilot_Raw(
    dataset(Doxie.layout_references) dids,
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0, //a place holder
    unsigned1 glb_purpose = 0, //a place holder
    string6 ssn_mask_value = 'NONE',
    boolean IsFCRA = false,
    dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
		dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim, 
		integer8 inFFDOptionsMask = 0
) := FUNCTION

boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

// FCRA: overrides
// persistent_record_id is used for identifying exactly a record which needs to be suppressed or corrected
correct_pilot_id := SET (flagfile (file_id = FCRA.FILE_ID.PILOT_REGISTRATION), record_id);
correct_pilot_ffid := SET (flagfile (file_id = FCRA.FILE_ID.PILOT_REGISTRATION), flag_file_id);

// did-key has full pilot's registration data 
did_key := faa.key_airmen_did (IsFCRA);

raw := join (dids, did_key,
             keyed(left.did=right.did) and
             (dateVal = 0 OR (unsigned3)(right.date_first_seen[1..6]) <= dateVal) and
             // suppress or override records on FCRA side
             (~IsFCRA or ((string)Right.persistent_record_id not in correct_pilot_id)),
             transform (doxie_crs.layout_pilot_records, Self := Right, self := []),
             LIMIT (ut.limits.AIRMAN_PER_DID, SKIP));


// overrides
pilot_override := CHOOSEN (fcra.key_override_faa.airmen_reg (keyed (flag_file_id IN correct_pilot_ffid)),
                           FCRA.compliance.MAX_OVERRIDE_LIMIT);

// put overrides into same layout, combine main data and overrides;
pilot_override_st := project (pilot_override, transform (doxie_crs.layout_pilot_records, 
                                                         Self.did := (unsigned6) Left.did_out, Self := Left, self := []));
pilot_fcra := raw + pilot_override_st;

doxie_crs.layout_pilot_records addStatementIDs(doxie_crs.layout_pilot_records L, FFD.Layouts.PersonContextBatchSlim R) := transform,
	skip((~showDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs))) 
		self.StatementIDs := r.StatementIDs;
		self.isDisputed :=	r.isDisputed;
		self := L;
	end;

pilot_fcra_ffd := join(
		pilot_fcra, slim_pc_recs(datagroup = FFD.Constants.DataGroups.PILOT_REGISTRATION),
		(string) left.persistent_record_id = right.recid1
		and (((unsigned)left.did_out = (unsigned) right.lexid) OR (right.acctno = FFD.Constants.SingleSearchAcctno)),
		addStatementIDs(left, right), 
		left outer, keep(1), limit(0)
	);			
		
pilot_raw := if (IsFCRA, pilot_fcra_ffd, raw);

out_f := sort (pilot_raw, did, current_flag != 'A', -date_last_seen, persistent_record_id);

doxie.MAC_PruneOldSSNs(out_f, out_f_pruned, best_ssn, did_out, IsFCRA);
suppress.MAC_Mask(out_f_pruned, out_mskd, best_ssn, blank, true, false);

return out_mskd;

END;
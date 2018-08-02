IMPORT doxie, watercraft, FCRA, ut, FFD;

EXPORT get_detail_records(
	dataset(WatercraftV2_Services.Layouts.search_watercraftkey) in_watercraftkeys,
	boolean isFCRA = false,
	dataset(FCRA.Layout_override_flag) flagfile = FCRA.compliance.blank_flagfile,
	dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0) := FUNCTION
	
	keyfile := watercraft.key_watercraft_wid (IsFCRA); // watercraft details
	layout_keyfile_plus := WatercraftV2_Services.Layouts.w_key_plus_rec;

	boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
	boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

	doxie.MAC_Header_Field_Declare(IsFCRA); //TODO: used only (!) for dateVal

	//get all original records by owner
	recs_orig := JOIN(
		in_watercraftkeys, keyfile,
		KEYED(LEFT.state_origin = RIGHT.state_origin)
			and KEYED(LEFT.watercraft_key = RIGHT.watercraft_key)
			and KEYED(LEFT.sequence_key = RIGHT.sequence_key)
			and (dateVal=0 or (unsigned3) RIGHT.purchase_date[1..6] <= dateVal),
		TRANSFORM (layout_keyfile_plus,
			SELF.subject_did := LEFT.subject_did, 
			SELF := RIGHT),
		LIMIT(ut.limits.MAX_DETAILS_PER_WATERCRAFT,SKIP));
					
	// overrides (FCRA only)
	flagfileMods := flagfile(file_id = FCRA.FILE_ID.WATERCRAFT_DETAILS);
	overrideKeyfile := FCRA.key_override_watercraft.wid;

	modificationRec := RECORD
		unsigned6 subject_did;
		boolean isOverride;
		recordof(keyfile);
	END;

	modificationRec xform_ModificationRec(FCRA.Layout_override_flag L, overrideKeyfile R) := TRANSFORM
		SELF.subject_did := (unsigned6)L.did;
		SELF.persistent_record_id := (unsigned8)L.record_id;
		SELF.isOverride := (L.flag_file_id = R.flag_file_id); //match found = override, not = suppression
		SELF := R;
		SELF := [];
	END;

	all_mods := JOIN(
		flagfileMods, overrideKeyfile,
		LEFT.flag_file_id = RIGHT.flag_file_id,
		xform_ModificationRec(LEFT, RIGHT),
		LEFT OUTER, LIMIT(FCRA.compliance.MAX_OVERRIDE_LIMIT));

	layout_keyfile_plus xform_FCRAKeepers(layout_keyfile_plus L, modificationRec R) := TRANSFORM, 
		SKIP(R.persistent_record_id <> 0 and ~R.isOverride)
		// Because of the LEFT OUTER that uses this transform below, the SKIP above is coded so that only actual suppression records get suppressed. 
		// I cannot use just (~R.isOverride) because the LEFT OUTER records that come thru will trigger a skip as well without the record_id check.
		SELF := IF(R.isOverride, ROW(R, layout_keyfile_plus), L);
	END;

	recs_FCRA := JOIN(
		recs_orig, all_mods,
		LEFT.persistent_record_id = RIGHT.persistent_record_id
			and LEFT.subject_did = RIGHT.subject_did,
		xform_FCRAKeepers(LEFT, RIGHT),
		LEFT OUTER);

	// FCRA FFD ----------------------------------------------------------------------------------------------------------------
	// Remove or mark Disputed rows & add StatementIDs
	layout_keyfile_plus xformDisp(layout_keyfile_plus L, FFD.Layouts.PersonContextBatchSlim R) := TRANSFORM,
		SKIP((~ShowDisputedRecords and R.isDisputed) or (~ShowConsumerStatements and exists(R.StatementIDs)))
		SELF.isDisputed :=  R.isDisputed;
		SELF.StatementIDs := R.StatementIDs;
		SELF := L;
	END;

	recs_disp := JOIN(recs_FCRA, slim_pc_recs,
		(string)LEFT.persistent_record_id = RIGHT.RecID1 
			and RIGHT.DataGroup = FFD.Constants.DataGroups.WATERCRAFT_DETAILS
			and LEFT.subject_did = (unsigned6)RIGHT.LexID,
		xformDisp(LEFT, RIGHT),
		LEFT OUTER, KEEP(1), LIMIT(0));
	// end of FCRA FFD ---------------------------------------------------------------------------------------------------------
			
	records := 	IF(isFCRA, recs_disp, recs_orig);

	// Prefix := 'get_detail_records';
	// OUTPUT(recs_orig, NAMED(Prefix + '__recs_orig'));
	// if(isFCRA, OUTPUT(all_mods, NAMED(Prefix + '__all_mods')));
	// if(isFCRA, OUTPUT(recs_FCRA, NAMED(Prefix + '__recs_FCRA')));
	// if(isFCRA, OUTPUT(recs_disp, NAMED(Prefix + '__recs_disp')));
	// OUTPUT(records, NAMED(Prefix + '__records'));
	
	RETURN records;
	
END;
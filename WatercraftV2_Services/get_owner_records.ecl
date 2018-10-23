IMPORT ut, watercraft, FCRA, MDR, doxie, FFD, D2C;

EXPORT get_owner_records(
	dataset(WatercraftV2_Services.Layouts.search_watercraftkey) in_watercraftkeys,
	boolean isFCRA = false,
	dataset(FCRA.Layout_override_flag) flagfile = FCRA.compliance.blank_flagfile,
	boolean include_non_regulated_sources = false,
	dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0) := FUNCTION
				
	owner_rec := WatercraftV2_Services.layouts.owner_raw_rec;

	include_non_regulated_data := include_non_regulated_sources and ~doxie.DataRestriction.InfutorWC;

	boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
	boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

	CNSMR_flag := ut.IndustryClass.is_Knowx;
	
	mac_sid_join_criteria := MACRO
					KEYED(LEFT.watercraft_key = RIGHT.watercraft_key) 
					and KEYED(LEFT.sequence_key='' OR LEFT.sequence_key = RIGHT.sequence_key)
					and KEYED(LEFT.state_origin ='' OR LEFT.state_origin = RIGHT.state_origin) 
					and (include_non_regulated_data or RIGHT.source_code != MDR.sourceTools.src_Infutor_Watercraft)
					and (~CNSMR_flag or right.source_code not in D2C.Constants.WatercraftRestrictedSources)
	ENDMACRO;
	
	// Get owner records from sid key
	recs_owner := JOIN(in_watercraftkeys,watercraft.key_watercraft_sid(isFCRA),
	                   mac_sid_join_criteria(),
										 TRANSFORM(owner_rec,
												SELF.isDeepDive := LEFT.isDeepDive,
												SELF.NonDMVSource := RIGHT.source_code in MDR.sourcetools.set_Infutor_Watercraft,
												SELF.subject_did := LEFT.subject_did,
												SELF := RIGHT,
												SELF := []),
										 LIMIT(0), KEEP(ut.limits.OWNERS_PER_WATERCRAFT));
	
	// For non fcra, append the linkids from sid_linkid keys
	recs_owner_wLinkids := JOIN(recs_owner,watercraft.key_watercraft_sid_linkids(isFCRA),
																mac_sid_join_criteria(),
																TRANSFORM(owner_rec,
																		SELF.dotid := RIGHT.dotid,
																		SELF.empid := RIGHT.empid,
																		SELF.powid := RIGHT.powid,
																		SELF.proxid := RIGHT.proxid,
																		SELF.seleid := RIGHT.seleid,
																		SELF.orgid := RIGHT.orgid,
																		SELF.ultid := RIGHT.ultid,
																		SELF := LEFT),
																LIMIT(0), KEEP(ut.limits.OWNERS_PER_WATERCRAFT),
																LEFT OUTER);
										
	recs_orig := IF(~isFCRA,recs_owner_wLinkids,recs_owner);
	
	// overrides (FCRA only)
	flagfileMods := flagfile(file_id = FCRA.FILE_ID.WATERCRAFT);
	overrideKeyfile := FCRA.key_override_watercraft.sid;

	modificationRec := RECORD
		unsigned6 subject_did;
		boolean isOverride;
		recordof(watercraft.key_watercraft_sid(isFCRA));
	END;

	modificationRec xform_ModificationRec(FCRA.Layout_override_flag L, overrideKeyfile R) := TRANSFORM
		SELF.subject_did := (unsigned6)L.did;
		SELF.persistent_record_id := (unsigned8)L.record_id;
		SELF.isOverride := (L.flag_file_id = R.flag_file_id); //match found = override, not = suppression
		SELF := R;
		SELF :=[];
	END;

	all_mods := JOIN(
		flagfileMods, overrideKeyfile,
		LEFT.flag_file_id = RIGHT.flag_file_id,
		xform_ModificationRec(LEFT, RIGHT),
		LEFT OUTER, LIMIT(FCRA.compliance.MAX_OVERRIDE_LIMIT));

	owner_rec xform_FCRAKeepers(owner_rec L, modificationRec R) := TRANSFORM, 
		SKIP(R.persistent_record_id <> 0 and ~R.isOverride)
		// Because of the LEFT OUTER that uses this transform below, the SKIP above is coded so that only actual suppression records get suppressed. 
		// I cannot use just (~R.isOverride) because the LEFT OUTER records that come thru will trigger a skip as well without the record_id check.
		SELF := IF(R.isOverride, ROW(R, TRANSFORM(owner_rec, SELF.NonDMVSource := false, SELF := LEFT, SELF:=[])), L);
	END;

	recs_FCRA := JOIN(
		recs_orig, all_mods,
		LEFT.persistent_record_id = RIGHT.persistent_record_id
			and LEFT.subject_did = RIGHT.subject_did,
		xform_FCRAKeepers(LEFT, RIGHT),
		LEFT ONLY);

	// FCRA FFD ----------------------------------------------------------------------------------------------------------------
	// Remove or mark Disputed rows & add StatementIDs
	owner_rec xformDs (owner_rec L, FFD.Layouts.PersonContextBatchSlim R) := TRANSFORM,
		skip((~ShowDisputedRecords and R.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs))) 
		SELF.isDisputed :=  r.isDisputed ;
		SELF.StatementIDs := r.StatementIDs;
		SELF := L;
	END;

	recs_ds  := join(recs_FCRA, slim_pc_recs,
		(string)LEFT.persistent_record_id = RIGHT.RecID1
			and RIGHT.DataGroup = FFD.Constants.DataGroups.WATERCRAFT
			and LEFT.subject_did = (unsigned6)RIGHT.LexID,
		xformDs(LEFT, RIGHT), 
		LEFT OUTER, KEEP(1), LIMIT(0));	
	// end of FCRA FFD ---------------------------------------------------------------------------------------------------------
				
	records := if(isFCRA, recs_ds, recs_orig);

	// Prefix := 'get_owner_records';
	// OUTPUT(recs_orig, NAMED(Prefix + '__recs_orig'));


	// if(isFCRA, OUTPUT(all_mods, NAMED(Prefix + '__all_mods')));
	// if(isFCRA, OUTPUT(recs_FCRA, NAMED(Prefix + '__recs_FCRA')));
	// if(isFCRA, OUTPUT(recs_disp, NAMED(Prefix + '__recs_disp')));
	// OUTPUT(records, NAMED(Prefix + '__records'));
	
	RETURN records;

END;

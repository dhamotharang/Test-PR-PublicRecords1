IMPORT doxie, watercraft, FCRA, ut, FFD;

EXPORT get_detail_records(
  DATASET(WatercraftV2_Services.Layouts.search_watercraftkey) in_watercraftkeys,
  BOOLEAN isFCRA = FALSE,
  DATASET(FCRA.Layout_override_flag) flagfile = FCRA.compliance.blank_flagfile,
  DATASET(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
  INTEGER8 inFFDOptionsMask = 0) := FUNCTION
  
  keyfile := watercraft.key_watercraft_wid (IsFCRA); // watercraft details
  layout_keyfile_plus := WatercraftV2_Services.Layouts.w_key_plus_rec;

  BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
  BOOLEAN ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

  doxie.MAC_Header_Field_Declare(IsFCRA); //TODO: used only (!) for dateVal

  //get all original records by owner
  recs_orig := JOIN(
    in_watercraftkeys, keyfile,
    KEYED(LEFT.state_origin = RIGHT.state_origin)
      AND KEYED(LEFT.watercraft_key = RIGHT.watercraft_key)
      AND KEYED(LEFT.sequence_key = RIGHT.sequence_key)
      AND (dateVal=0 OR (UNSIGNED3) RIGHT.purchase_date[1..6] <= dateVal),
    TRANSFORM (layout_keyfile_plus,
      SELF.subject_did := LEFT.subject_did,
      SELF := RIGHT),
    LIMIT(ut.limits.MAX_DETAILS_PER_WATERCRAFT,SKIP));
          
  // overrides (FCRA only)
  flagfileMods := flagfile(file_id = FCRA.FILE_ID.WATERCRAFT_DETAILS);
  overrideKeyfile := FCRA.key_override_watercraft.wid;

  modificationRec := RECORD
    UNSIGNED6 subject_did;
    BOOLEAN isOverride;
    RECORDOF(keyfile);
  END;

  modificationRec xform_ModificationRec(FCRA.Layout_override_flag L, overrideKeyfile R) := TRANSFORM
    SELF.subject_did := (UNSIGNED6) L.did;
    SELF.persistent_record_id := (UNSIGNED8) L.record_id;
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
    SKIP(R.persistent_record_id <> 0 AND ~R.isOverride)
    // Because of the LEFT OUTER that uses this transform below, the SKIP above is coded so that only actual suppression records get suppressed.
    // I cannot use just (~R.isOverride) because the LEFT OUTER records that come thru will trigger a skip as well without the record_id check.
    SELF := IF(R.isOverride, ROW(R, layout_keyfile_plus), L);
  END;

  recs_FCRA := JOIN(
    recs_orig, all_mods,
    LEFT.persistent_record_id = RIGHT.persistent_record_id
      AND LEFT.subject_did = RIGHT.subject_did,
    xform_FCRAKeepers(LEFT, RIGHT),
    LEFT OUTER);

  // FCRA FFD ----------------------------------------------------------------------------------------------------------------
  // Remove or mark Disputed rows & add StatementIDs
  layout_keyfile_plus xformDisp(layout_keyfile_plus L, FFD.Layouts.PersonContextBatchSlim R) := TRANSFORM,
    SKIP((~ShowDisputedRecords AND R.isDisputed) OR (~ShowConsumerStatements AND EXISTS(R.StatementIDs)))
    SELF.isDisputed := R.isDisputed;
    SELF.StatementIDs := R.StatementIDs;
    SELF := L;
  END;

  recs_disp := JOIN(recs_FCRA, slim_pc_recs,
    (STRING)LEFT.persistent_record_id = RIGHT.RecID1
      AND RIGHT.DataGroup = FFD.Constants.DataGroups.WATERCRAFT_DETAILS
      AND LEFT.subject_did = (UNSIGNED6)RIGHT.LexID,
    xformDisp(LEFT, RIGHT),
    LEFT OUTER, KEEP(1), LIMIT(0));
  // end of FCRA FFD ---------------------------------------------------------------------------------------------------------
      
  records := IF(isFCRA, recs_disp, recs_orig);
  
  RETURN records;
  
END;

IMPORT emerges, ccw_services, FCRA, ut, FFD;

EXPORT Raw := MODULE;
    
  //============================================================================
  // Attribute: ccw_raw. Used by view source service and comp-report.
  // Function to get concealed weapon records by did.
  // Return value: dataset. Layout: rawrec
  //============================================================================
  // pass in a did and get back all information
  EXPORT byDIDs(DATASET(ccw_services.Layouts.search_did) in_dids, BOOLEAN isFCRA = FALSE) := FUNCTION
    
    deduped := DEDUP(SORT(in_dids,did),did);
    //allow for using FCRA version of the key
    joinup := JOIN(deduped,emerges.Key_ccw_did(isFCRA), 
      KEYED( LEFT.did = RIGHT.did_out6),
      TRANSFORM(ccw_services.Layouts.search_rid,
        SELF := RIGHT),
      LIMIT(ut.limits.CCW_PER_DID, SKIP));
              
    RETURN joinup;
  END;

  // Note: at this point we do not have CCW batch services, so this code is exicuted for a single person;
  // for example, there's no danger to link one person's consumer statement to another person.
  EXPORT byRids(DATASET(ccw_services.Layouts.search_rid) in_recs, BOOLEAN isFCRA = FALSE,
                DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
                INTEGER8 inFFDOptionsMask = 0,
                BOOLEAN is_CNSMR = FALSE
                ) := FUNCTION
    
    BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
    BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);

    ccw_correct_rec_id := SET (flagfile (file_id = FCRA.FILE_ID.CCW), record_id);
    ccw_correct_ffid := SET (flagfile (file_id = FCRA.FILE_ID.CCW), flag_file_id);

    // join to payload key.
    recs_clean := JOIN(in_recs, emerges.key_ccw_rid(isFCRA),
      KEYED(LEFT.rid = RIGHT.rid) AND
      (~isFCRA OR (STRING)RIGHT.persistent_record_id NOT IN ccw_correct_rec_id)
      AND ~ccw_services.functions.isRestricted(is_CNSMR, RIGHT.Source_Code), // D2C - consumer restriction
      TRANSFORM( ccw_services.layouts.rawrec, SELF := RIGHT),
      KEEP(1), LIMIT(0));

    // overrides
    recs_over := CHOOSEN (fcra.key_override_ccw.concealed_weapons(KEYED (flag_file_id IN ccw_correct_ffid)),
      FCRA.compliance.MAX_OVERRIDE_LIMIT);

    // put overrides into same layout, combine main data and overrides;
    recs_override_final := PROJECT (recs_over, TRANSFORM (ccw_services.layouts.rawrec, 
      SELF.rid := 0; SELF := LEFT));
    
    recs_fcra := recs_clean + recs_override_final;
    
    // Supress disputed records and fill the statement_ids
    ccw_services.Layouts.rawrec xformStatements( recs_fcra l, FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
    SKIP(( ~showDisputedRecords AND r.isDisputed) OR (~ShowConsumerStatements AND EXISTS(r.StatementIDs)))
      SELF.StatementIDs := r.StatementIDs;
      SELF.iSDisputed := r.isDisputed;
      SELF := l;
    END;
    
    recs_final_fcra := JOIN(recs_fcra, slim_pc_recs,
      LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
      xformStatements(LEFT, RIGHT),
      LEFT OUTER, KEEP(1), LIMIT(0));
                                                          
    recs := IF (isFCRA, recs_final_fcra, recs_clean);
    
    RETURN recs;
  END;
END;

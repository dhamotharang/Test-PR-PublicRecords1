IMPORT STD, doxie, doxie_files, hygenics_crim, ut, FCRA, FFD, D2C;

MAX_OVERRIDE_LIMIT := FCRA.compliance.MAX_OVERRIDE_LIMIT;

EXPORT Raw := MODULE
  EXPORT getOffenderKeys := MODULE

    EXPORT byDIDs(DATASET(doxie.layout_references) in_dids,
                  BOOLEAN IsFCRA=FALSE,
                  DATASET (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile) := FUNCTION
      correct_ofk := SET (flagfile (file_id=FCRA.FILE_ID.OFFENDERS), record_id);
      correct_ffid := SET (flagfile (file_id=FCRA.FILE_ID.OFFENDERS), flag_file_id);
      deduped := DEDUP(SORT(in_dids,did),did);
      offenders_key := doxie_files.Key_Offenders(isFCRA);
      // FCRA: this function returns only IDs, which will be used for fetching raw data.
      ofks := JOIN(deduped, offenders_key,
                    KEYED(LEFT.did = RIGHT.sdid) AND
                    (~isFCRA OR
                    (STRING)RIGHT.offender_key NOT IN correct_ofk),
                    TRANSFORM(CriminalRecords_Services.layouts.l_search,SELF := RIGHT),
                    atmost(ut.limits.OFFENDERS_PER_DID));

      // overrides (FCRA side only)
      ofks_override := CHOOSEN (fcra.key_override_crim.offenders (KEYED (flag_file_id IN correct_ffid)), MAX_OVERRIDE_LIMIT);
      // combine main data and overrides; apply FCRA-filtering
      // available dates are: (process_date, file_date, case_date, record_setup_date)
      ofks_fcra := (ofks + PROJECT (ofks_override, CriminalRecords_Services.layouts.l_search));
      RETURN IF(isFCRA, ofks_fcra, ofks);
    END;

    EXPORT byDocNums(DATASET(CriminalRecords_Services.layouts.docnum_rec) in_docnums) := FUNCTION
      deduped := DEDUP(SORT(in_docnums,doc_number),doc_number);
      docnum_key := doxie_files.Key_offenders_docnum();
      ofks := JOIN(deduped, docnum_key,
                    KEYED(LEFT.doc_number=RIGHT.docnum),
                    TRANSFORM(CriminalRecords_Services.layouts.l_search,SELF:=RIGHT),
                    atmost(ut.limits.OFFENDERS_PER_DID));
      RETURN ofks;
    END;

    EXPORT byCaseNum(DATASET(CriminalRecords_Services.layouts.casenum_rec) in_casenums) := FUNCTION
      deduped := DEDUP(SORT(in_casenums, case_number), case_number);

      CriminalRecords_Services.layouts.casenum_rec clean_case_num(CriminalRecords_Services.layouts.casenum_rec le) := TRANSFORM
        SELF.case_number := hygenics_crim._functions.clean_case_number(le.case_number);
      END;

      deduped_cleaned := PROJECT(deduped, clean_case_num(LEFT));

      casenum_key := hygenics_crim.Key_offenders_casenumber();
      ofks := JOIN(deduped_cleaned, casenum_key,
                  KEYED(LEFT.case_number = RIGHT.case_num),
                  TRANSFORM(CriminalRecords_Services.layouts.l_search, SELF := RIGHT),
                  atmost(ut.limits.OFFENDERS_PER_DID));

      RETURN ofks;
    END;

    EXPORT byoffenderID(DATASET(CriminalRecords_Services.layouts.l_search) in_offenderid) := FUNCTION
      deduped := DEDUP(SORT(in_offenderid,offender_key),offender_key);
      offenderkey_key := doxie_files.Key_Offenders_OffenderKey();
      ofks_did := JOIN(deduped, offenderkey_key,
                        KEYED(LEFT.offender_key=RIGHT.ofk),
                        TRANSFORM(doxie.layout_references,SELF.did:=(UNSIGNED) RIGHT.did),
                        atmost(ut.limits.OFFENDERS_PER_DID));
      ofks:=byDIDs(ofks_did);
      RETURN DEDUP(SORT(ofks+in_offenderid,offender_key),offender_key);
    END;

  END; //end of getOffenderKeys module

  EXPORT getOffenderRaw(DATASET(CriminalRecords_Services.layouts.l_search) ids,
                        BOOLEAN IsFCRA = FALSE,
                        DATASET (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                        DATASET(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
                        INTEGER8 inFFDOptionsMask = 0,
                        BOOLEAN isCNSMR = FALSE) := FUNCTION

    BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
    BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);

    correct_puid := SET (flagfile (file_id=FCRA.FILE_ID.OFFENDERS_PLUS), record_id);
    correct_ofk_recid := SET (flagfile (file_id=FCRA.FILE_ID.OFFENDERS), record_id);
    correct_ffid := SET (flagfile (file_id=FCRA.FILE_ID.OFFENDERS_PLUS), flag_file_id);
    //here we identify offender_key values which are suppressions - flag_file_id is blank
    //we need them to support suppression of override records for cluster which is based on offender_key
    suppressed_ofk := SET (flagfile (file_id=FCRA.FILE_ID.OFFENDERS AND flag_file_id=''), record_id);
    correct_ofk := SET (flagfile (file_id=FCRA.FILE_ID.OFFENDERS), flag_file_id);
    offenderkey_key := doxie_files.Key_Offenders_OffenderKey(isFCRA);
    recs1 := JOIN(ids, offenderkey_key,
      KEYED(LEFT.offender_key=RIGHT.ofk) AND
      (~isFCRA OR
      (((STRING)RIGHT.offender_persistent_id NOT IN correct_puid
      AND (STRING)RIGHT.ofk NOT IN correct_ofk_recid)
      AND (RIGHT.data_type != '4')))
      AND (~isCNSMR OR (RIGHT.data_type NOT IN D2C.Constants.DOCRestrictedDataTypes AND RIGHT.vendor NOT IN D2C.Constants.DOCRestrictedVendors)) ,//Restricting access to arrest logs (data_type = 5) AND source vendor = MH (Minnesota) when industry class = CNSMR
      TRANSFORM(CriminalRecords_Services.layouts.l_raw,
      SELF:=LEFT,
      SELF :=RIGHT),
      ATMOST(ut.limits.OFFENDERS_MAX));

    // overrides (FCRA side only) - we have 2 indices for offenders overrides
    // we are making this change to now account for both
    // we check against suppressed_ofk to support suppression of overrides based on cluster
    ds_override_ofp := CHOOSEN (fcra.key_override_crim.offenders_plus (KEYED (flag_file_id IN correct_ffid)
                                AND offender_key NOT IN suppressed_ofk),
                                 MAX_OVERRIDE_LIMIT);
    ds_override_ofk := CHOOSEN (fcra.key_override_crim.offenders (KEYED (flag_file_id IN correct_ofk)
                                AND offender_key NOT IN suppressed_ofk),
                                MAX_OVERRIDE_LIMIT);

    ds_override := DEDUP(ds_override_ofp + ds_override_ofk, ALL);

    // combine main data and overrides; apply FCRA-filtering
    // available dates are: (process_date, file_date, case_date, record_setup_date)
    recs_fcra := (recs1 + PROJECT (ds_override, TRANSFORM(CriminalRecords_Services.layouts.l_raw, SELF := LEFT, SELF := []))) (
                FCRA.crim_is_ok ((STRING) STD.Date.Today(), fcra_date, fcra_conviction_flag, fcra_traffic_flag));

    CriminalRecords_Services.layouts.l_raw xformStatements( CriminalRecords_Services.layouts.l_raw l ,
                                                            FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
    SKIP((~ShowDisputedRecords AND r.isDisputed) OR (~ShowConsumerStatements AND EXISTS(r.StatementIDs)))
      SELF.StatementIDs := r.StatementIds;
      SELF.IsDisputed := r.IsDisputed;
      SELF := l;
    END;

    recs_ds := JOIN(recs_fcra, slim_pc_recs,
      (UNSIGNED)LEFT.did = (UNSIGNED) RIGHT.lexid
      AND
      ((RIGHT.DataGroup = FFD.Constants.DATAGROUPS.OFFENDERS_PLUS AND
        LEFT.offender_persistent_id = (INTEGER) RIGHT.RecID1)
        OR
        (RIGHT.DataGroup = FFD.Constants.DATAGROUPS.OFFENDERS AND
        LEFT.offender_key = RIGHT.RecId1)
      ),
      xformStatements(LEFT,RIGHT),
      LEFT OUTER,
      KEEP(1),LIMIT(0));
    recs := IF(isFCRA, recs_ds, recs1);

    RETURN recs;
  END;
END;

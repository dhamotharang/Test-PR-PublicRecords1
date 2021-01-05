IMPORT FCRA, FFD, ut, STD;

EXPORT fn_applyFcraOverrides(DATASET(LiensV2_Services.layout_lien_rollup) raw_rec,
                             DATASET(fcra.Layout_override_flag) flagfile,
                             STRING in_ssn_mask_value = '',
                             BOOLEAN includeCriminalIndicators = FALSE,
                             DATASET(FFD.Layouts.PersonContextBatchSlim) ds_slim_pc = FFD.Constants.BlankPersonContextBatchSlim,
                             INTEGER8 inFFDOptionsMask = 0) := FUNCTION
  
  // ============ OVERRIDES (FCRA-version only) ===============
  // The output is consisted of party- and main- liens files (both are indexed by tmsid/rmsid)
  // so that both corresponding overrides files should be used. Overrides "additions"
  // have to be processed (almost) the same way regular records have been processed
  // to comply with CRS output (common part is fcra-irrelevant, so it can be used in FCRA-side)

  // Get overrides records:
  // a) identifiers (unique for this datatype) showing which records are to be corrected;
  // b) pointers to corrected records ("right" by definition);
  liens_correct_tmsid_record_id := SET (flagfile (file_id = FCRA.FILE_ID.LIEN), record_id[1..50]); //there is no rmsid
  liens_correct_record_id := SET (flagfile (file_id = FCRA.FILE_ID.LIEN), record_id);
  liens_correct_ffid := SET (flagfile (file_id = FCRA.FILE_ID.LIEN), flag_file_id);

  // Get only "good" records (filtered out by both main- and party- override ids:
  LiensV2_Services.layout_lien_rollup xformCleanRecs(LiensV2_Services.layout_lien_rollup L) := TRANSFORM,
    SKIP(L.tmsid IN liens_correct_tmsid_record_id // old way of filtering records prior to 11/13/2012
      OR (STRING)L.persistent_record_id IN liens_correct_record_id
      OR EXISTS(L.debtors((STRING)persistent_record_id IN liens_correct_record_id))
      OR EXISTS(L.creditors((STRING)persistent_record_id IN liens_correct_record_id))
      OR EXISTS(L.attorneys((STRING)persistent_record_id IN liens_correct_record_id))
      OR EXISTS(L.thds((STRING)persistent_record_id IN liens_correct_record_id))
      OR EXISTS(L.filings((STRING)persistent_record_id IN liens_correct_record_id))) // new way, using the persistent_record_id
    SELF := L;
  END;
  ds_clean := PROJECT(raw_rec, xformCleanRecs(LEFT));
                        
  //get corrections (both for main- and search- files)
  ds_party_overrides := CHOOSEN (fcra.key_Override_liensv2_party_ffid (KEYED (flag_file_id IN liens_correct_ffid)), ut.limits.OVERRIDE_LIMIT);
  ds_party_corrections :=
    GROUP (SORT (PROJECT (ds_party_overrides,TRANSFORM(liensv2_services.layout_lien_party_raw,SELF:=LEFT,SELF:=[])), acctno), acctno);

  ds_main_overrides := CHOOSEN (fcra.key_Override_liensv2_main_ffid (KEYED (flag_file_id IN liens_correct_ffid)), ut.limits.OVERRIDE_LIMIT);

  liensv2_services.layout_liens_case_extended GetCase (ds_main_overrides r) := TRANSFORM
    SELF.acctno := ''; // becuse this attribute is only used by non-batch services
    SELF.filing_status := CHOOSEN(r.filing_status,10);
    SELF.filing_jurisdiction_name := LiensV2_Services.fn_get_filing_jurisdiction_name(r.filing_jurisdiction);
    SELF := r;
  END;
  ds_case_corrections := PROJECT (ds_main_overrides, GetCase (LEFT));


  liensv2_services.layout_liens_history_extended GetHistory (ds_main_overrides r) := TRANSFORM
    SELF.filings := DATASET ([
      {
        r.filing_number, 
        r.filing_type_desc, 
        r.orig_filing_date, 
        r.filing_date, 
        r.filing_time,
        r.filing_book,
        r.filing_page,
        r.agency,
        r.agency_state,
        r.agency_city,
        r.agency_county, 
        r.persistent_record_id, 
        DATASET([], FFD.Layouts.StatementIdRec), 
        FALSE, 
        r.bcbflag
      }
    ], liensv2_services.layout_lien_history_w_bcb);
    SELF.tmsid := r.tmsid;
    SELF.acctno := ''; // becuse this attribute is only used by non-batch services
  END;
  ds_history_corrections := PROJECT (ds_main_overrides, GetHistory (LEFT));

  // Run through amelioration process (fcra-neutral)
  ds_correct := LiensV2_Services.GetCRSOutput (ds_party_corrections, ds_case_corrections, ds_history_corrections,
                                               in_ssn_mask_value, TRUE,,,includeCriminalIndicators, ds_slim_pc,
                                               inFFDOptionsMask);

  // add user's (override) records; filter by fcra-date criteria
  ds_final := (ds_clean + ds_correct) (FCRA.lien_is_ok ((STRING)STD.Date.Today(), orig_filing_date));
    
  RETURN ds_final;
END;

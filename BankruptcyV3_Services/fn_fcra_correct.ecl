/*
 ***** FCRA Corrections *****
 implement fcra corrections/overrides for on main and search bk files
 based on doxie.bk_records (as of 2013.03.16)
*/

IMPORT $, bankruptcyv3, doxie, FCRA, FFD, Gateway, STD, ut;

EXPORT $.layouts.layout_rollup fn_fcra_correct(
  DATASET($.layouts.layout_rollup) ds,
  STRING6 in_ssn_mask = '') 
  := FUNCTION

  gateways := Gateway.Configuration.Get();

  unique_tmsids := DEDUP(PROJECT(ds, TRANSFORM({$.layouts.layout_rollup.tmsid}, SELF.tmsid := LEFT.tmsid)), ALL);

  dids4flag := NORMALIZE(ds, LEFT.debtors,
    TRANSFORM(doxie.layout_best,
      SELF.did := (UNSIGNED6) RIGHT.did,
      SELF.fname := RIGHT.names[1].fname,
      SELF.mname := RIGHT.names[1].mname,
      SELF.lname := RIGHT.names[1].lname,
      SELF.ssn := RIGHT.ssn,
      SELF := RIGHT));

  dids4pc := PROJECT(dids4flag, TRANSFORM(FFD.Layouts.DidBatch,
    SELF.did := LEFT.did,
    SELF.acctno := FFD.Constants.SingleSearchAcctno));

  // call person context to get LT suppression records
  // we are deliberately making additional call to person context here to keep changes as simple as possible
  pc_recs := FFD.FetchPersonContext(dids4pc, gateways, FFD.Constants.DataGroupSet.Bankruptcy);
  ds_flags := FFD.GetFlagFile(dids4flag, pc_recs);

  // Get overrides records:
  // a) identifiers (unique for this datatype) showing which records are to be corrected;
  // b) pointers to corrected records ("right" by definition);
  bk_cccn := SET (ds_flags (file_id = FCRA.FILE_ID.BANKRUPTCY), record_id);
  bk_ffid := SET (ds_flags (file_id = FCRA.FILE_ID.BANKRUPTCY), flag_file_id);

  // Get only "good" records (filtered out by both main and search override ids:
  bk_main_record_id := TRIM(ds.court_code) + TRIM(ds.case_number);
  bk_search_record_id_debtor_1 := TRIM(ds.tmsid) + BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR + TRIM(ds.debtors[1].did); // 'D' is hardcoded because only DEBTOR bk records are correctable while Attorney AND Judge records are NOT.
  bk_search_record_id_debtor_2 := TRIM(ds.tmsid) + BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR + TRIM(ds.debtors[2].did);
  ds_clean := ds((bk_main_record_id NOT IN bk_cccn) AND (bk_search_record_id_debtor_1 NOT IN bk_cccn) AND (bk_search_record_id_debtor_2 NOT IN bk_cccn));
  
  bk_main_key := bankruptcyv3.key_bankruptcyv3_main_full(TRUE);
  bk_party_key := bankruptcyv3.key_bankruptcyv3_search_full_bip(TRUE);

  // get corrections (both for main and search files)
  ds_main_override := CHOOSEN (fcra.key_Override_bkv3_main_ffid (KEYED (flag_file_id IN bk_ffid)), ut.limits.OVERRIDE_LIMIT);
  ds_main_corrections := PROJECT(ds_main_override, TRANSFORM(RECORDOF(bk_main_key),
    SELF := LEFT, SELF := []));

  ds_search_override := CHOOSEN (fcra.key_Override_bkv3_search_ffid (KEYED (flag_file_id IN bk_ffid)), ut.limits.OVERRIDE_LIMIT);
  ds_search_corrections := PROJECT (ds_search_override,
    TRANSFORM(BankruptcyV3_Services.Layout_key_bankruptcyV3_search_full_bip_plus_case_numbers,
      SELF := LEFT, SELF := []));

  // collect tmsids to check for divergence between search & main corrections (i.e. overide in main but not in party & vice versa)
  // note: divergence is expected and is not an anomaly
  tmsids_clean := SET(ds_clean, tmsid);
  tmsids_main_overrides := SET(ds_main_corrections, tmsid);
  tmsids_clean_and_main_overrides := tmsids_clean + tmsids_main_overrides;
  tmsids_search_overrides := SET(ds_search_corrections, tmsid);

  // missing main overrides = unique_tmsids (set diff.) (clean_tmsids + main_overrides)
  tmsids_missing_main_corrections := unique_tmsids(tmsid NOT IN tmsids_clean_and_main_overrides);
  ds_main_missing_corrections :=
    JOIN(tmsids_missing_main_corrections, bk_main_key,
      KEYED(LEFT.tmsid = RIGHT.tmsid)
      AND TRIM(RIGHT.court_code) + TRIM(RIGHT.case_number) NOT IN bk_cccn,
      TRANSFORM(RIGHT),
      KEEP(1), LIMIT(0));

  // missing search overrides = main_overrides (set diff.) search_overrides
  tmsids_missing_search_corrections := unique_tmsids(tmsid IN tmsids_main_overrides AND tmsid NOT IN tmsids_search_overrides);
  ds_search_refetch :=
    JOIN(tmsids_missing_search_corrections, bk_party_key,
      KEYED(LEFT.tmsid = RIGHT.tmsid)
      AND TRIM(LEFT.tmsid) + BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR + TRIM(RIGHT.did) NOT IN bk_cccn
      AND RIGHT.name_type[1]=BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR,
      TRANSFORM(bankruptcyv3_services.Layout_key_bankruptcyv3_search_full_bip_plus_case_numbers,
        SELF := RIGHT,
        SELF := []),
      LIMIT(0),
      KEEP(BankruptcyV3_Services.consts.KEEP_LIMIT));

  // now drop any re-fetched debtor if we actually do have an override
  ds_search_missing_corrections := JOIN(ds_search_refetch, ds_search_corrections,
    LEFT.tmsid = RIGHT.tmsid AND LEFT.did = RIGHT.did,
    LEFT only);

  // format overrides to BK V3 layout_rollup
  ds_main_rollup_correction := ds_main_corrections + ds_main_missing_corrections;
  ds_search_rollup_correction := ds_search_corrections + ds_search_missing_corrections;
  ds_correct := $.fn_rollup_corrections (ds_search_rollup_correction, ds_main_rollup_correction, in_ssn_mask,,TRUE);

  // add user's (override) records; filter by fcra-date criteria
  res_fcra := (ds_clean + ds_correct) (FCRA.bankrupt_is_ok ((STRING)STD.Date.Today(), date_filed));

  // OUTPUT(ds,NAMED('fetch_before_correction'));
  // OUTPUT(dids4flag,NAMED('dids4flag'));
  // OUTPUT(pc_recs,NAMED('pc_recs'));
  // OUTPUT(ds_flags,NAMED('ds_flags'));
  // OUTPUT(bk_cccn,NAMED('bk_cccn'));
  // OUTPUT(bk_ffid,NAMED('bk_ffid'));
  // OUTPUT(ds_main_corrections,NAMED('ds_main_corrections'));
  // OUTPUT(tmsids_missing_main_corrections, named('tmsids_missing_main_corrections'));
  // OUTPUT(ds_main_rollup_correction,NAMED('ds_main_rollup_correction'));
  // OUTPUT(ds_search_corrections,NAMED('ds_search_corrections'));
  // OUTPUT(tmsids_missing_search_corrections, named('tmsids_missing_search_corrections'));
  // OUTPUT(ds_search_rollup_correction,NAMED('ds_search_rollup_correction'));
  // OUTPUT(ds_clean,NAMED('ds_clean'));
  // OUTPUT(ds_correct,NAMED('ds_correct'));
  // OUTPUT(res_fcra,NAMED('res_fcra'));

  RETURN res_fcra;

END;

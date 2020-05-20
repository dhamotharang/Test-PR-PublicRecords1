/*
 ***** FCRA Corrections *****
 implement fcra corrections/overrides for on main and search bk files
 based on doxie.bk_records (as of 2013.03.16)
*/

import $, bankruptcyv3, doxie, FCRA, FFD, Gateway, STD, ut;

export $.layouts.layout_rollup fn_fcra_correct(dataset($.layouts.layout_rollup) ds,
                string6 in_ssn_mask = '') := function

  gateways := Gateway.Configuration.Get();

  unique_tmsids := dedup(project(ds, transform({$.layouts.layout_rollup.tmsid}, self.tmsid := left.tmsid)), all);

  dids4flag := normalize(ds, left.debtors,
    transform(doxie.layout_best,
      self.did := (unsigned6) right.did,
      self.fname := right.names[1].fname,
      self.mname := right.names[1].mname,
      self.lname := right.names[1].lname,
      self.ssn := right.ssn,
      self := right));

  dids4pc := project(dids4flag, transform(FFD.Layouts.DidBatch,
    self.did := left.did,
    self.acctno := FFD.Constants.SingleSearchAcctno));

  // call person context  to get LT suppression records
  // we are deliberately making additional call to person context here to keep changes as simple as possible
  pc_recs := FFD.FetchPersonContext(dids4pc, gateways, FFD.Constants.DataGroupSet.Bankruptcy);
  ds_flags := FFD.GetFlagFile(dids4flag, pc_recs);

  // Get overrides records:
  // a) identifiers (unique for this datatype) showing which records are to be corrected;
  // b) pointers to corrected records ("right" by definition);
  bk_cccn := SET (ds_flags (file_id = FCRA.FILE_ID.BANKRUPTCY), record_id);
  bk_ffid := SET (ds_flags (file_id = FCRA.FILE_ID.BANKRUPTCY), flag_file_id);

  // Get only "good" records (filtered out by both main and search override ids:
  bk_main_record_id   := TRIM(ds.court_code) + TRIM(ds.case_number);
  bk_search_record_id_debtor_1 := TRIM(ds.tmsid) + BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR + TRIM(ds.debtors[1].did); // 'D' is hardcoded because only DEBTOR bk records are correctable while Attorney and Judge records are not.
  bk_search_record_id_debtor_2 := TRIM(ds.tmsid) + BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR + TRIM(ds.debtors[2].did);
  ds_clean := ds((bk_main_record_id NOT IN bk_cccn) AND (bk_search_record_id_debtor_1 NOT IN bk_cccn) AND (bk_search_record_id_debtor_2 NOT IN bk_cccn));
  
  bk_main_key := bankruptcyv3.key_bankruptcyv3_main_full(true);
  bk_party_key := bankruptcyv3.key_bankruptcyv3_search_full_bip(true);

  // get corrections (both for main and search files)
  ds_main_override := CHOOSEN (fcra.key_Override_bkv3_main_ffid (keyed (flag_file_id IN bk_ffid)), ut.limits.OVERRIDE_LIMIT);
  ds_main_corrections := project(ds_main_override, transform(recordof(bk_main_key),
    self := left, self := []));

  ds_search_override := CHOOSEN (fcra.key_Override_bkv3_search_ffid (keyed (flag_file_id IN bk_ffid)), ut.limits.OVERRIDE_LIMIT);
  ds_search_corrections := project (ds_search_override,
    transform(BankruptcyV3_Services.Layout_key_bankruptcyV3_search_full_bip_plus_case_numbers,
      self := left, self := []));

  // collect tmsids to check for divergence between search & main corrections (i.e. overide in main but not in party & vice versa)
  // note: divergence is expected and is not an anomaly
  tmsids_clean := SET(ds_clean, tmsid);
  tmsids_main_overrides := SET(ds_main_corrections, tmsid);
  tmsids_clean_and_main_overrides := tmsids_clean + tmsids_main_overrides;
  tmsids_search_overrides := SET(ds_search_corrections, tmsid);

  // missing main overrides = unique_tmsids (set diff.) (clean_tmsids + main_overrides)
  tmsids_missing_main_corrections := unique_tmsids(tmsid not in tmsids_clean_and_main_overrides);
  ds_main_missing_corrections := 
    join(tmsids_missing_main_corrections, bk_main_key,
      keyed(left.tmsid = right.tmsid)
      and trim(right.court_code) + trim(right.case_number) not in bk_cccn,
      transform(right), 
      keep(1), limit(0));

  // missing search overrides = main_overrides (set diff.) search_overrides
  tmsids_missing_search_corrections := unique_tmsids(tmsid in tmsids_main_overrides and tmsid not in tmsids_search_overrides);
  ds_search_refetch := 
    join(tmsids_missing_search_corrections, bk_party_key,
      keyed(left.tmsid = right.tmsid)
      and trim(left.tmsid) + BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR + trim(right.did) not in bk_cccn
      and right.name_type[1]=BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR,
      transform(bankruptcyv3_services.Layout_key_bankruptcyv3_search_full_bip_plus_case_numbers,
        self := right,
        self := []),
      limit(0),
      keep(BankruptcyV3_Services.consts.KEEP_LIMIT));

  // now drop any re-fetched debtor if we actually do have an override
  ds_search_missing_corrections := join(ds_search_refetch, ds_search_corrections,
    left.tmsid = right.tmsid and left.did = right.did,
    left only);

  // format overrides to BK V3 layout_rollup
  ds_main_rollup_correction := ds_main_corrections + ds_main_missing_corrections;
  ds_search_rollup_correction := ds_search_corrections + ds_search_missing_corrections;
  ds_correct := $.fn_rollup_corrections (ds_search_rollup_correction, ds_main_rollup_correction, in_ssn_mask,,true);

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

  return res_fcra;

end;

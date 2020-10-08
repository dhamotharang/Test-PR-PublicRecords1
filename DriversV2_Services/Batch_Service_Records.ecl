IMPORT Address, Autokey_batch, AutokeyB2, AutoStandardI, BatchServices, Census_Data, doxie, DriversV2, DriversV2_Services, STD;

EXPORT Batch_Service_Records (DATASET(Autokey_batch.Layouts.rec_inBatchMaster) data_in,
                                                            DriversV2_Services.GetDLParams.batch_params cfgs,
                                                            BOOLEAN issuedByOrigState = FALSE) := FUNCTION

  // Key
  keyDLDID := DriversV2.Key_DL_DID;
  keyDLNUM := DriversV2.Key_DL_Number;
  keyDLSEQ := DriversV2.Key_DL_Seq;

  // Aliases
  Consts := DriversV2.Constants;
  AutoKeyBatchInput := Autokey_batch.Layouts.rec_inBatchMaster;
  PLRec := DriversV2.File_DL_base_for_Autokeys;
  Seq := DriversV2_Services.layouts.seq;
  ResultNarrow := DriversV2_Services.layouts.result_narrow;
  GetDLParams := DriversV2_Services.GetDLParams;

  // Constants
  STRING BLNK := '';
  STRING NOT_NUMBER := '\\D+';
  STRING AK_TYPE_STR := 'DL';
  UNSIGNED MaxDIDs := 100;
  UNSIGNED MaxDLs := 1000;

  BOOLEAN return_current_only := cfgs.return_current_only;
  currentDt := (UNSIGNED4) STD.Date.Today() : GLOBAL;

  // Functions
  trimBoth(STRING input) := TRIM(input, LEFT, RIGHT);
  toUpper(STRING input) := STD.STR.ToUpperCase(trimBoth(input));


  // Records/Transforms
  AutoKeyBatchInput cleanInput(AutoKeyBatchInput input) := TRANSFORM
    state_in := toUpper(input.st);
    dlstate_in := toUpper(input.dlstate);

    SELF.name_first := toUpper(input.name_first);
    SELF.name_middle := toUpper(input.name_middle);
    SELF.name_last := toUpper(input.name_last);
    SELF.name_suffix := toUpper(input.name_suffix);
    SELF.p_city_name := toUpper(input.p_city_name);
    SELF.st := IF(LENGTH(state_in) > 2, Address.Map_State_Name_To_Abbrev(state_in), state_in);
    SELF.ssn := REGEXREPLACE(NOT_NUMBER, input.ssn, BLNK);
    SELF.dl := toUpper(input.dl);
    SELF.dlstate := IF(LENGTH(dlstate_in) > 2, Address.Map_State_Name_To_Abbrev(dlstate_in), dlstate_in);
    SELF := input;
  END;

  AcctRec := RECORD(Seq)
    AutoKeyBatchInput.acctno;
    UNSIGNED6 did := 0;
    STRING24 dl_number := '';
    STRING2 dlstate := '';
  END;

  AcctRecWithInput := RECORD(AcctRec)
    AutoKeyBatchInput - [acctno, did, dlstate];
  END;

  OutRec := RECORD(ResultNarrow)
    AcctRec.acctno;
    STRING10 height_desc;
  END;

  // Search via AutoKey
  input_c := PROJECT(data_in, cleanInput(LEFT));
  fids := UNGROUP(Autokey_batch.get_fids(input_c, Consts.autokey_qa_Keyname, cfgs));
  AutokeyB2.mac_get_payload(fids, Consts.autokey_qa_Keyname, PLRec, with_pl, did, zero, AK_TYPE_STR);
  with_pl_x := PROJECT(with_pl, TRANSFORM(AcctRec, SELF := LEFT));
  fromAK := DEDUP(SORT(with_pl_x, acctno, dl_seq), acctno, dl_seq);

  // Search via DID lookup
  notFoundAccts := JOIN(input_c, fromAK, LEFT.acctno = RIGHT.acctno, TRANSFORM(LEFT), LEFT ONLY);
  dDidsAcctno := BatchServices.Functions.fn_find_dids_and_append_to_acctno(notFoundAccts);
  dWithDIDs := JOIN(notFoundAccts, dDidsAcctno,
    LEFT.acctno = RIGHT.acctno,
    TRANSFORM(AcctRec,
      SELF.did := RIGHT.did,
      SELF := LEFT,
      SELF.dl_seq := 0),
    LEFT OUTER);

  fromDIDLkup := JOIN(dWithDIDs, keyDLDID,
                      KEYED(LEFT.did = RIGHT.did),
                      TRANSFORM(AcctRec, SELF := RIGHT, SELF := LEFT));

  // Merge/Sort/Dedup
  m_s_d := DEDUP(SORT(fromAK + fromDIDLkup, acctno, dl_seq), acctno, dl_seq);

  // Make a choice
  did_acctno := IF(cfgs.RunDeepDive AND EXISTS(notFoundAccts), m_s_d, fromAK);

  // Search by using license number
  input_dl := input_c(trimBoth(dl) <> BLNK);
  withDLNUMInput := JOIN(input_dl, keyDLNUM,
                         KEYED(trimBoth(LEFT.dl) = RIGHT.s_dl),
                         TRANSFORM(AcctRec, SELF := RIGHT, SELF := LEFT),
                         LIMIT(MaxDLs, SKIP));
  num_acctno := DEDUP(SORT(withDLNUMInput, acctno, dl_seq), acctno, dl_seq);

  // Get matches and penalize them
  acctNos := DEDUP(SORT(did_acctno + num_acctno, acctno, dl_seq), acctno, dl_seq);

  acctNos_i := JOIN(acctNos, input_c,
                    LEFT.acctno = RIGHT.acctno,
                    TRANSFORM(AcctRecWithInput, SELF := RIGHT, SELF := LEFT),KEEP(1));

  Inrecs_With_DLrecs := RECORD(AcctRecWithInput)
    RECORDOF(keyDLSEQ) DL_seq_rec;
  END;

  Inrecs_With_DLrecs addDLrecs(acctNos_i L,keyDLSEQ R) := TRANSFORM
    SELF.dl_seq_rec.orig_state := IF(issuedByOrigState AND R.IssuedRecord = 'U', '', R.orig_state);
    SELF.DL_seq_rec := R;
    SELF := L;
  END;

  use_NonDMVSources := DriversV2_Services.input.incNonDMV AND ~doxie.DataRestriction.CY;

  //Bug:135855 - Performance improved JOIN to fetch based on SEQ (Taken out from Transform - toOutRec)
  dl_recs_with_ids := JOIN(acctNos_i, keyDLSEQ,
                        KEYED(LEFT.dl_seq = RIGHT.dl_seq)
                        AND (use_NonDMVSources OR (RIGHT.source_code NOT IN DriversV2.Constants.nonDMVSources)),
                        addDLrecs(LEFT,RIGHT),LIMIT(0),KEEP(1));

  OutRec toOutRec(dl_recs_with_ids l, UNSIGNED dateFltrVal) := TRANSFORM
    tmpParam := MODULE(PROJECT(AutoStandardI.GlobalModule(), GetDLParams.params, OPT))
      EXPORT city := l.p_city_name;
      EXPORT state := l.st;
      EXPORT z5 := l.z5;
      EXPORT predir := l.predir;
      EXPORT postdir := l.postdir;
      EXPORT suffix := l.addr_suffix;
      EXPORT prim_name := l.prim_name;
      EXPORT prim_range := l.prim_range;
      EXPORT sec_range := l.sec_range;
      EXPORT bdid := '';
      EXPORT company := l.comp_name;
      EXPORT county := '';
      EXPORT did := IF(l.DID > 0, (STRING) l.DID, BLNK);
      EXPORT fein := l.FEIN;
      EXPORT lastname := l.name_last;
      EXPORT middlename := l.name_middle;
      EXPORT firstname := l.name_first;
      EXPORT phone := l.homephone;
      EXPORT ssn := l.ssn;
      EXPORT dlState := l.dlstate;
      EXPORT dob := (INTEGER) l.dob;
    END;
  
    // bug: https://bugzilla.seisint.com/show_bug.cgi?id=56762 - Bug: 135855 will resolves this issue.
    DL_seq_recs := DATASET(L.DL_seq_rec);
    // Performance improved function - Seq Join and county Join brought out.
    tmplist := DriversV2_Services.DLRaw.by_DL_src(DL_seq_recs, tmpParam,TRUE);

    fltrd_nonTX_set := tmplist(st <> 'TX', expiration_date >= dateFltrVal);
    fltrd_TX_sorted := SORT(tmplist(st='TX'), did, -dt_last_seen, RECORD);
    fltrd := IF(dateFltrVal > 0, SORT (fltrd_nonTX_set, -expiration_date) + fltrd_TX_sorted, tmplist);

    //TODO: need to verify that the order of records in [fltrd] is detemenistic
    SELF.penalt := IF(EXISTS(fltrd), fltrd[1].penalt, 0xFFFF);
    SELF.height_desc := IF(EXISTS(fltrd), fltrd[1].height[1] + 'ft' + fltrd[1].height[2..] + 'in', '');
    SELF := fltrd[1];
    // SELF.dob := 0;
    SELF := l;
  END;

  dateRstrc := IF(return_current_only, currentDt, 0);
  filterbypenalty := PROJECT(dl_recs_with_ids,toOutRec(LEFT,dateRstrc))(penalt <= cfgs.PenaltThreshold);
    // County name filled here - Single hit rather than 1000 hits for batch.
  Census_Data.MAC_Fips2County_Keyed(filterbypenalty, st, county, county_name, matches_pnlt_all);

 matches_pnlt_TX := SORT(matches_pnlt_all(st = 'TX'), acctno, did, -dt_last_seen, RECORD);
  
  // rollup by did and keep 1 row
  OutRec rollup_xform(outrec le, outrec ri) := TRANSFORM
    SELF := le;
  END;
    
  current_rolled_up_TX := ROLLUP(matches_pnlt_TX, rollup_xform(LEFT, RIGHT),
                          (LEFT.acctno = RIGHT.acctno),
                          (LEFT.did = RIGHT.did AND toupper(history) NOT IN Consts.history_flag));
  
  // Remove Historical records from Texas rolled up results -- filtering only by the history field as
  // DriversV2_Services.Batch_Service eventually calls DriversV2_Services.fn_getDL_report and history_name
  // field is set by a transform within that function which is based on history field

  // When only want current returned, added the filter on non Texas records to NOT return historical records
  current_nonTX := matches_pnlt_all(st <> 'TX' AND toupper(history) NOT IN Consts.history_flag);
  
  matches_pnlt := IF (return_current_only, current_nonTX + current_rolled_up_TX, matches_pnlt_all);
  // Make output
  rsltByDLNum := DEDUP(SORT(matches_pnlt(dl_number <> BLNK), acctno, dl_number, -expiration_date),
                         acctno, dl_number, KEEP(2));
  rsltByDID := DEDUP(SORT(matches_pnlt(dl_number = BLNK AND did > 0),
                          acctno, did, -expiration_date),
                     acctno, did, KEEP(2));
  rslt := DEDUP(SORT(rsltByDLNum + rsltByDID, acctno, penalt),acctno,KEEP cfgs.MaxResultsPerAcct);


  RETURN rslt;

END;

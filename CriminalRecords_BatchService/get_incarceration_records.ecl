IMPORT $, Autokey_batch, CriminalRecords_Services, FCRA, FFD, STD;

EXPORT get_incarceration_records(
  DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in_common,
  $.IParam.batch_params configData,
  DATASET(FCRA.Layout_override_flag) flag_file = FCRA.compliance.blank_flagfile,
  DATASET(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
  BOOLEAN isFCRA = FALSE
) := FUNCTION

  fromAK := $.batchIds.PII_Ids(configData).AutokeyIds(ds_batch_in_common);

  notFoundAccts := JOIN(ds_batch_in_common, fromAK, LEFT.acctno = RIGHT.acctno, TRANSFORM(LEFT), LEFT ONLY);
  fromDID := $.BatchIds.PII_Ids(configData).IdsPIIByDID(IF(isFCRA, ds_batch_in_common, notFoundAccts), isFCRA);

  // Find out possible incarcerations
  // if isFCRA skip autokey search
  acctNos := IF(isFCRA, fromDID, fromAK + fromDID);
  acctNos_final := DEDUP(SORT(acctNos, acctno, did, offender_key), acctno, did, offender_key);

  // Fetch all punishment records and set incarceration flags accordingly.
  Layout_PII_Temp := RECORD
    $.Layouts.batch_pii_out_pre;
    UNSIGNED6 did;
  END;

  punishment_rec := $.Raw.getPIIPunishmentRecords(acctNos_final, isFCRA, flag_file, slim_pc_recs, configData.FFDOptionsMask);

  Layout_PII_Temp makeOutputPunishment(punishment_rec l) := TRANSFORM
    matchStr := IF(l.matchResult & $.Constants.V_MATCH_INTERNAL <> 0, $.Constants.STR_MATCH_INTERNAL, $.Constants.BLNK) +
                IF(l.matchResult & $.Constants.V_MATCH_NAME <> 0, $.Constants.STR_MATCH_NAME, $.Constants.BLNK) +
                IF(l.matchResult & $.Constants.V_MATCH_ADDR <> 0, $.Constants.STR_MATCH_ADDR, $.Constants.BLNK) +
                IF(l.matchResult & $.Constants.V_MATCH_CITY <> 0, $.Constants.STR_MATCH_CITY, $.Constants.BLNK) +
                IF(l.matchResult & $.Constants.V_MATCH_STATE <> 0, $.Constants.STR_MATCH_STATE, $.Constants.BLNK) +
                IF(l.matchResult & $.Constants.V_MATCH_ZIP <> 0, $.Constants.STR_MATCH_ZIP, $.Constants.BLNK) +
                IF(l.matchResult & $.Constants.V_MATCH_SSN <> 0, $.Constants.STR_MATCH_SSN, $.Constants.BLNK) +
                IF(l.matchResult & $.Constants.V_MATCH_DOB <> 0, $.Constants.STR_MATCH_DOB, $.Constants.BLNK);
    SELF.match_type := matchStr;
    punishment_disputes := IF(L.isDisputed,ROW(FFD.InitializeConsumerStatementBatch(
                                            FFD.Constants.BlankStatementid,
                                            FFD.Constants.RecordType.DR,
                                            '',
                                            FFD.Constants.DataGroups.PUNISHMENT,
                                            0,'',
                                            L.did)));
    punishment_statements := PROJECT (L.StatementIds,FFD.InitializeConsumerStatementBatch(
                              LEFT,
                              FFD.Constants.RecordType.RS,
                              '',
                              FFD.Constants.DataGroups.PUNISHMENT,
                              0,'',
                              L.did ));
    SELF.StatementsAndDisputes := punishment_disputes + punishment_statements;
    SELF := l;
    SELF := [];
  END;
  punishments := PROJECT(punishment_rec, makeOutputPunishment(LEFT));//JOIN(acctNos_final, keyPunishment, KEYED(LEFT.offender_key = RIGHT.ok), makeOutputPunishment(LEFT, RIGHT));
  CriminalRecords_Services.MAC_Incarceration_Filter(punishments, punishments_flagged, TRUE, TRUE, TRUE);
  punishments_inc := punishments_flagged(Incarceration_Flag='1');

  // BUG #97804 - Return Name and SSN
  Layout_PII_OffenderPNameSSN := $.Layouts.batch_pii_int_offender;

  // BUG #97804 - Return Name and SSN
  BOOLEAN is_Return_SSN := configData.ReturnSSN;
  BOOLEAN is_Return_DOC_Name := configData.ReturnDocName;
  UNSIGNED1 KeepN := IF(is_Return_DOC_Name, 10, 1);

  $.Layouts.batch_pii_out_pre makeOutputOffender(Layout_PII_Temp l, Layout_PII_OffenderPNameSSN r) := TRANSFORM
    SELF.INCR_doc_num := r.doc_num;
    SELF.INCR_state_origin := r.orig_state;
    SELF.INCR_dob := r.dob;
    SELF.INCR_did := r.did;
    SELF.INCR_ssn := IF(is_Return_SSN,IF(r.ssn = '', r.ssn_appended, r.ssn),'');
    SELF.INCR_fname := IF(is_Return_DOC_Name,r.fname,'');
    SELF.INCR_lname := IF(is_Return_DOC_Name,r.lname,'');

    offender_disputes := IF(R.isDisputed,ROW(FFD.InitializeConsumerStatementBatch(
                                          FFD.Constants.BlankStatementid,
                                          FFD.Constants.RecordType.DR,
                                          'incr',
                                          FFD.Constants.DataGroups.OFFENDERS_PLUS,
                                          0,'',
                                          (UNSIGNED)R.did)));
    offender_statements := PROJECT(R.StatementIds,FFD.InitializeConsumerStatementBatch(
                            LEFT,
                            FFD.Constants.RecordType.RS,
                            'incr',
                            FFD.Constants.DataGroups.OFFENDERS_PLUS,
                            0,'',
                            (UNSIGNED)R.did ));

    SELF.StatementsAndDisputes := offender_disputes + offender_statements + L.StatementsAndDisputes;
    SELF := l;
  END;

  // BUG #97804 - Prefered Name and SSN Logic
  Layout_PII_OffenderPNameSSN rollOutputOffenderPNameSSN(Layout_PII_OffenderPNameSSN L, Layout_PII_OffenderPNameSSN R) := TRANSFORM
    SELF.ssn := IF(L.ssn = '',R.ssn,L.ssn);
    SELF.ssn_appended := IF(L.ssn_appended = '',R.ssn_appended,L.ssn_appended);
    SELF.did := IF(L.did = '',R.did,L.did);
    use_L := L.ssn <> '' OR L.ssn_appended <> '';
    SELF.isDisputed := R.isDisputed OR (use_L AND L.isDisputed);
    SELF.StatementIds := R.StatementIds + IF(use_L,L.StatementIds);
    SELF := R;
  END;

  // BUG #97804 - Prefered Name and SSN Rollup Logic
  fn_OffenderPNameSSN_Rollup(DATASET(Layout_PII_OffenderPNameSSN) in_ds) := FUNCTION
    out_ds := ROLLUP(in_ds,
                    LEFT.ofk = RIGHT.ofk
                    AND (LEFT.lname = RIGHT.lname OR (TRIM(LEFT.lname) != '' AND STD.Str.Find(TRIM(RIGHT.lname),TRIM(LEFT.lname),1) > 0))
                    AND (LEFT.pfirst = RIGHT.pfirst
                          OR (LENGTH(TRIM(LEFT.pfirst)) = 1
                              AND LEFT.pfirst[1] = RIGHT.pfirst[1])),
                    rollOutputOffenderPNameSSN(LEFT,RIGHT));
    RETURN out_ds;
  END;
  // Send
  OffenderPNameSSN_Temp := $.Raw.getPIIOffenderRecords(acctNos_final, isFCRA, flag_file, slim_pc_recs, configData.FFDOptionsMask);
  OffenderPNameSSN_Rollup_LName := fn_OffenderPNameSSN_Rollup(SORT(OffenderPNameSSN_Temp, ofk, lname, pfirst, ssn, ssn_appended));
  OffenderPNameSSN_Rollup_FName := fn_OffenderPNameSSN_Rollup(SORT(OffenderPNameSSN_Rollup_LName, ofk, pfirst, lname, ssn, ssn_appended));
  OffenderPNameSSN := SORT(PROJECT(OffenderPNameSSN_Rollup_FName, $.Layouts.batch_pii_int_offender), ofk, -process_date, -ssn, -ssn_appended);

  // Change for RR-12139

  rslt_tmp := IF(is_Return_DOC_Name OR is_Return_SSN,
                JOIN(punishments_inc, OffenderPNameSSN, LEFT.offender_key = RIGHT.ofk, makeOutputOffender(LEFT, RIGHT), KEEP(KeepN), LIMIT(0)),
                JOIN(punishments_inc, OffenderPNameSSN_Temp, LEFT.offender_key = RIGHT.ofk, makeOutputOffender(LEFT, RIGHT), KEEP(1), LIMIT(0)));

  rslt_grp := GROUP(SORT(rslt_tmp,EXCEPT match_type),EXCEPT match_type);
  rslt_ungrp := UNGROUP(DEDUP(rslt_grp,
                              TRIM(RIGHT.match_type) != '' AND STD.Str.Contains(TRIM(LEFT.match_type), TRIM(RIGHT.match_type), TRUE),
                              ALL));
  rslt_srt := SORT(rslt_ungrp,acctno,Incarceration_Flag,INCR_state_origin,INCR_doc_num,INCR_dob,event_dt,punishment_type,sent_length,sent_length_desc,cur_stat_inm,cur_stat_inm_desc,cur_loc_inm,cur_sec_class_dt,cur_loc_sec,gain_time,gain_time_eff_dt,latest_adm_dt,sch_rel_dt,act_rel_dt,ctl_rel_dt,presump_par_rel_dt,match_type,-INCR_ssn,INCR_fname,INCR_lname);

  RETURN rslt_srt;

END;

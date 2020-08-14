/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $,BankruptcyV2,BankruptcyV3,BankruptcyV3_Services,ConsumerDisclosure,doxie,FCRA,FFD,Suppress,STD;

boolean IsFCRA := TRUE;

layout_Bankruptcy_main_raw := RECORD // recordof(BankruptcyV3.key_bankruptcyV3_main_full)
  BankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp_excludescrubs;
END;

layout_Bankruptcy_party_raw := RECORD // recordof(BankruptcyV3.key_bankruptcyv3_search_full_bip)
    BankruptcyV2.layout_bankruptcy_search_v3_supp_bip  - [ScrubsBits1];
END;

layout_Bankruptcy_withdraw_raw := RECORD //recordof(BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus)
  BankruptcyV3.Layout_BankruptcyV3_WithdrawnStatus.wsKey;
END;

layout_Bankruptcy_party_rawrec := RECORD
    $.Layouts.InternalMetadata;
    layout_Bankruptcy_party_raw;
    layout_Bankruptcy_withdraw_raw WithdrawnStatusInfo;
END;

layout_Bankruptcy_main_rawrec := RECORD
    $.Layouts.InternalMetadata;
    layout_Bankruptcy_main_raw;
END;

layout_bankruptcy_rawrec := RECORD
    unsigned6 subject_did;
    string50 tmsid;
    string5  court_code;
    string8	date_last_seen;
    string8	date_first_seen;
    dataset(layout_Bankruptcy_main_rawrec) main;
    dataset(layout_Bankruptcy_party_rawrec) parties;
END;


EXPORT RawBankruptcy := MODULE


  EXPORT layout_bankruptcy_party_out := RECORD($.Layouts.Metadata)
    layout_Bankruptcy_party_raw RawData;
    layout_Bankruptcy_withdraw_raw WithdrawnStatusInfo;
  END;

  EXPORT layout_bankruptcy_main_out := RECORD($.Layouts.Metadata)
    layout_Bankruptcy_main_raw RawData;
    BankruptcyV3.layout_courts courtinfo {xpath('CourtInfo')};
  END;

  EXPORT layout_bankruptcy_out := RECORD
    STRING50 tmsid;
    STRING8	date_last_seen;
    STRING8	date_first_seen;
    DATASET(layout_bankruptcy_main_out) main {xpath('Main/Row')};
    DATASET(layout_bankruptcy_party_out) parties {xpath('parties/Row')};
  END;


EXPORT GetData(dataset(doxie.layout_references) in_dids,
              dataset (FFD.Layouts.flag_ext_rec) flag_file,
              dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
              $.IParams.IParam in_mod) :=
FUNCTION
  boolean showDisputedRecords := in_mod.ReturnDisputed;
  string8 current_date := (string8) Std.Date.Today();

  flags := flag_file(file_id = FCRA.FILE_ID.BANKRUPTCY);

  tmsids :=
    join (in_dids, BankruptcyV3.key_bankruptcyV3_did(IsFCRA),
      left.did<>0 and keyed(left.did=right.did),
      transform(RIGHT),
      limit(0), keep($.Constants.Limits.MaxBankruptcyPerDID));

  // -------------  BANKRUPTCY SEARCH  -------------
  l_bk_search_tmp := record
    layout_Bankruptcy_party_rawrec;
    boolean inputIsDebtor;
  end;

  bk_search_raw :=
    join (tmsids, BankruptcyV3.key_bankruptcyv3_search_full_bip(IsFCRA),
      left.case_number<>'' and left.court_code<>'' and left.tmsid<>'' and
      keyed (left.tmsid = right.tmsid),
      transform (l_bk_search_tmp,
        self.subject_did := left.did;
        self.combined_record_id := trim (Right.tmsid) + trim(Right.name_type) + trim(right.did);
        self.inputIsDebtor := left.did=(unsigned6)right.did and right.name_type=BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR;
        self.record_ids.RecId1 := right.tmsid;
        self.record_ids.RecId2 := right.name_type;
        self.record_ids.RecId3 := right.did;
        self := right;
        self := []
      ),
      limit(0),keep($.Constants.Limits.MaxBKParties)); // left outer?

  bk_debtors := dedup(sort(bk_search_raw, tmsid, court_code, case_number, -inputIsDebtor), tmsid, court_code, case_number);

  bk_search_with_debtors :=
    join(bk_search_raw, bk_debtors,
      left.tmsid=right.tmsid and left.court_code=right.court_code and left.case_number=right.case_number and right.inputIsDebtor,
      transform(layout_Bankruptcy_party_rawrec,
        self.subject_did := left.subject_did,
        self := left
      ));

  // get corrections and suppressions
  bk_search_overrides :=
    join(flags, FCRA.key_override_bkv3_search_ffid,
      keyed (left.flag_file_id = right.flag_file_id),
        transform(layout_Bankruptcy_party_rawrec,
          _is_override := right.flag_file_id <> '' and left.flag_file_id = right.flag_file_id;
          // for overrides sometimes same flag_file_id is used for whole cluster of bk records including main and search, so we cannot rely on record_id from flag file for overrides; we still use record_id for LT suppression
          combined_rec_id := trim (Right.tmsid) + trim(Right.name_type) + trim(right.did);
          cluster_rec_id := trim(right.court_code)+trim(right.case_number);  // in case if overrides are on cluster they can only be suppressed based on cluster record id
          self.subject_did := (unsigned6) left.did;
          self.compliance_flags.IsOverride := LEFT.isOverride AND _is_override;
          self.compliance_flags.IsSuppressed := LEFT.isSuppressed AND (combined_rec_id='' OR combined_rec_id=left.record_id OR cluster_rec_id=left.record_id);
          self.WithdrawnStatusInfo := [];
          self.combined_record_id := if(combined_rec_id<>'', combined_rec_id, left.record_id);
          self.record_ids.RecId1 := right.tmsid;
          self.record_ids.RecId2 := right.name_type;
          self.record_ids.RecId3 := right.did;
          self := right;
          self := left;
          self:=[]
          ),
      left outer, keep(FCRA.compliance.MAX_OVERRIDE_limit), limit(0)); // any bk with more than 100 parties? if so, keep(100) may be a problem.

  rid_search_overrides := set(bk_search_overrides(compliance_flags.isOverride), combined_record_id);
  rid_search_suppressed := set(bk_search_overrides(compliance_flags.isSuppressed AND ~compliance_flags.isOverride), combined_record_id);

  bk_search_with_flags :=
    project(bk_search_with_debtors,
      transform(layout_Bankruptcy_party_rawrec,
        self.Compliance_Flags.isOverwritten := left.combined_record_id in rid_search_overrides,
        self.Compliance_Flags.isSuppressed := left.combined_record_id in rid_search_suppressed,
        self := left));

  bk_search_all := bk_search_with_flags + bk_search_overrides(Compliance_Flags.isOverride);

  // weed out old records (>10 years); debtor records now being returned (bug 68174)
  bk_search_filtered := bk_search_all(
    in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
    in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed,
    FCRA.bankrupt_is_ok(current_date, date_filed),
    in_mod.nss <> Suppress.Constants.NonSubjectSuppression.returnBlank or
    name_type<>BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR or
    subject_did =(unsigned) did
  );

  // add statements and disputes
  layout_Bankruptcy_party_rawrec xformPartyStatements(layout_Bankruptcy_party_rawrec l,	FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      skip(~ShowDisputedRecords and r.isDisputed)
          self.statement_ids := r.StatementIDs;
          self.compliance_flags.IsDisputed := r.isDisputed;
          self := l;
    end;

  bk_search :=
    join(bk_search_filtered, slim_pc_recs(Datagroup = FFD.Constants.DataGroups.BANKRUPTCY_SEARCH),
      left.tmsid = right.RecID1 and left.subject_did = (unsigned6) right.lexid and
        right.RecId2 = BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR and
        left.record_ids.RecId2 = right.RecId2 and
          (unsigned6) left.did = (unsigned6) right.RecId3,
        xformPartyStatements(left, right),
      left outer, keep(1), limit(0));

  // -------------  BANKRUPTCY WITHDRAW  -------------
  bk_search_plus_withdraw := JOIN(bk_search, BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus(isFCRA:= TRUE),
                        KEYED(LEFT.tmsid = RIGHT.tmsid AND LEFT.caseID = RIGHT.caseID  AND LEFT.DefendantID = RIGHT.DefendantID)
                        AND LEFT.name_type = BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR,
                        TRANSFORM(layout_Bankruptcy_party_rawrec,
                                  SELF.WithdrawnStatusInfo := RIGHT,
                                  SELF := LEFT),
                        LEFT OUTER,
                        KEEP(1), LIMIT(0));

    //--------------do non-subject suppression -------------
    layout_Bankruptcy_party_rawrec xformNSS(layout_Bankruptcy_party_rawrec L) := TRANSFORM
      isRestricted := (L.subject_did <> (unsigned6) L.did) and L.name_type=BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR;

      SELF.subject_did := L.subject_did;
      SELF.compliance_flags := L.compliance_flags;
      SELF.record_ids := L.record_ids;

      SELF.tmsid := L.tmsid;
      SELF.name_type := L.name_type;

      SELF.lname := IF (isRestricted, FCRA.Constants.FCRA_Restricted, L.lname);
      SELF := IF (~isRestricted, L);
      SELF := [];
    END;

    bk_search_nss := PROJECT(bk_search_plus_withdraw, xformNSS(LEFT));

    bk_search_final := IF(in_mod.nss = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription,
                        bk_search_nss, bk_search_plus_withdraw);

  // -------------  BANKRUPTCY  -------------

  // dedup the bankruptcy TMSIDs before joining to the main file
  bk_all_deduped := dedup(sort(bk_search, tmsid), tmsid);   // why it is based on filtered set, not bk_search_all?

  bk_main_raw :=
    join (bk_all_deduped, BankruptcyV3.key_bankruptcyV3_main_full(isFCRA),
      left.case_number<>'' AND left.court_code<>'' AND left.tmsid<>''
      and keyed (left.tmsid = right.tmsid),
      transform (layout_Bankruptcy_main_rawrec,
        self.subject_did := left.subject_did;
        self.combined_record_id := trim(right.court_code)+trim(right.case_number); // main record id = court_code + case_number
        self.record_ids.RecId1 := right.court_code;
        self.record_ids.RecId2 := right.case_number;
        self := right;
        self:=[]),
      keep(1), limit(0));

  // get corrections and suppressions
  bk_main_overrides :=
    join(flags, FCRA.key_override_bkv3_main_ffid,
      keyed (left.flag_file_id = right.flag_file_id),
        transform(layout_Bankruptcy_main_rawrec,
          _is_override := right.flag_file_id <> '' and left.flag_file_id = right.flag_file_id;
          // for overrides sometimes same flag_file_id is used for whole cluster of bk records including main and search, so we cannot rely on record_id for overrides from flag file
          combined_rec_id := trim(right.court_code)+trim(right.case_number);
          self.Compliance_Flags.IsOverride := LEFT.isOverride AND _is_override;
          self.Compliance_Flags.IsSuppressed := LEFT.IsSuppressed AND (combined_rec_id='' OR combined_rec_id=left.record_id);
          self.subject_did := (unsigned6) left.did;
          self.combined_record_id := if(combined_rec_id<>'', combined_rec_id, left.record_id); // main record id = court_code + case_number
          self.record_ids.RecId1 := right.court_code;
          self.record_ids.RecId2 := right.case_number;
          self := right;
          self := left;
          self:=[]),
        left outer, keep(FCRA.compliance.MAX_OVERRIDE_limit), limit(0));

  rid_main_overrides := set(bk_main_overrides(Compliance_Flags.isOverride), combined_record_id);
  rid_main_suppressed := set(bk_main_overrides(Compliance_Flags.IsSuppressed AND ~Compliance_Flags.isOverride), combined_record_id);

  bk_main_flags :=
    project(bk_main_raw,
      transform(layout_Bankruptcy_main_rawrec,
        self.compliance_flags.isOverwritten := left.combined_record_id in rid_main_overrides,
        self.compliance_flags.isSuppressed := left.combined_record_id in rid_main_suppressed,
        self := left));

  bk_main_all := bk_main_flags + bk_main_overrides(Compliance_Flags.isOverride);

  // filtering by fcra-date
  bk_main_filtered := bk_main_all(
    in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
    in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed,
    FCRA.bankrupt_is_ok(current_date, date_filed)
  );

  // add statements and disputes
  layout_Bankruptcy_main_rawrec xformMainStatements(layout_Bankruptcy_main_rawrec l,	FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      skip(~ShowDisputedRecords and r.isDisputed)
          self.statement_ids := r.StatementIDs;
          self.compliance_flags.IsDisputed := r.isDisputed;
          self := l;
    end;

  bk_main_statements_disputes :=
    join(bk_main_filtered, slim_pc_recs(Datagroup = FFD.Constants.DataGroups.BANKRUPTCY_MAIN),
      left.subject_did = (unsigned6) right.lexid and
      left.record_ids.RecId1 = right.RecID1 and
      left.record_ids.RecId2 = right.RecId2,
      xformMainStatements(left,right),
      left outer, keep(1), limit(0));

  layout_bankruptcy_rawrec
    xtRollMain(layout_Bankruptcy_main_rawrec l, dataset(layout_Bankruptcy_main_rawrec) all_rows) :=
  transform
    self.date_first_seen := l.date_first_seen;
    self.date_last_seen := l.date_last_seen;
    self.tmsid := l.tmsid;
    self.court_code := l.court_code;
    self.subject_did := l.subject_did;
    self.main := sort(all_rows, -compliance_flags.isOverride, compliance_flags.isSuppressed, compliance_flags.isOverwritten, -date_last_seen, -date_first_seen);
    self.parties := [];
  end;

  bk_main := rollup(group(sort(bk_main_statements_disputes, tmsid, -date_last_seen, -date_first_seen), tmsid), group, xtRollMain(left, ROWS(left)));

  layout_bankruptcy_rawrec
    xtAddParties(layout_bankruptcy_rawrec l, dataset(layout_Bankruptcy_party_rawrec) all_parties) :=
  transform
    self.parties := sort(all_parties, -compliance_flags.isOverride, compliance_flags.isSuppressed, compliance_flags.isOverwritten, -date_last_seen, -date_first_seen);
    self := l;
  end;

  bk_main_with_parties :=
    denormalize(bk_main, bk_search_final, left.tmsid = right.tmsid,
      group, xtAddParties(LEFT, ROWS(RIGHT)));

  // -------------  BANKRUPTCY COURTS  -------------

  layout_bankruptcy_out xtOut(layout_bankruptcy_rawrec l, recordof(BankruptcyV3.key_bankruptcyV3_courts) r) :=
  transform
    self.main := project(l.main, transform(layout_bankruptcy_main_out,
      self.Metadata := $.Functions.GetMetadataESDL(left.compliance_flags,
                                                left.record_ids,
                                                left.statement_IDs,
                                                left.subject_did,
                                                FFD.Constants.DataGroups.BANKRUPTCY_MAIN);
      self.CourtInfo := r;
      self.RawData := left;
      ));
    self.parties := project(l.parties, transform(layout_bankruptcy_party_out,
      self.Metadata := $.Functions.GetMetadataESDL(left.compliance_flags,
                                                left.record_ids,
                                                left.statement_IDs,
                                                left.subject_did,
                                                FFD.Constants.DataGroups.BANKRUPTCY_SEARCH);
      self.WithdrawnStatusInfo := left.WithdrawnStatusInfo;
      self.RawData := left;
      ));
    self.tmsid := l.tmsid;
    self.date_first_seen := l.date_first_seen;
    self.date_last_seen := l.date_last_seen;
  end;

  bk_out :=
    join(bk_main_with_parties, BankruptcyV3.key_bankruptcyV3_courts,
    keyed(left.court_code = right.moxie_court),
      xtOut(left, right),
    left outer, keep(1), limit(0));

  // -- search
  if(ConsumerDisclosure.Debug AND in_mod.IncludeBankruptcy, output(tmsids, named('bk_tmsids')));
  if(ConsumerDisclosure.Debug AND in_mod.IncludeBankruptcy, output(bk_search_raw, named('bk_search_raw')));
  if(ConsumerDisclosure.Debug AND in_mod.IncludeBankruptcy, output(bk_debtors, named('bk_debtors')));
  if(ConsumerDisclosure.Debug AND in_mod.IncludeBankruptcy, output(bk_search_with_debtors, named('bk_search_with_debtors')));
  if(ConsumerDisclosure.Debug AND in_mod.IncludeBankruptcy, output(bk_search_overrides, named('bk_search_overrides')));
  //if($.Debug AND in_mod.IncludeBankruptcy, output(rid_search_overrides, named('rid_search_overrides')));
  //if($.Debug AND in_mod.IncludeBankruptcy, output(rid_search_suppressed, named('rid_search_suppressed')));
  if(ConsumerDisclosure.Debug AND in_mod.IncludeBankruptcy, output(bk_search_with_flags, named('bk_search_with_flags')));
  // if($.Debug AND in_mod.IncludeBankruptcy, output(bk_search_filtered, named('bk_search_filtered')));
  if(ConsumerDisclosure.Debug AND in_mod.IncludeBankruptcy, output(bk_search, named('bk_search')));
  if(ConsumerDisclosure.Debug AND in_mod.IncludeBankruptcy, output(bk_search_plus_withdraw, named('bk_search_plus_withdraw')));
  // -- main
  if(ConsumerDisclosure.Debug AND in_mod.IncludeBankruptcy, output(bk_main_raw, named('bk_main_raw')));
  if(ConsumerDisclosure.Debug AND in_mod.IncludeBankruptcy, output(bk_main_overrides, named('bk_main_overrides')));
  //if($.Debug AND in_mod.IncludeBankruptcy, output(rid_main_overrides, named('rid_main_overrides')));
  //if($.Debug AND in_mod.IncludeBankruptcy, output(rid_main_suppressed, named('rid_main_suppressed')));
  if(ConsumerDisclosure.Debug AND in_mod.IncludeBankruptcy, output(bk_main_flags, named('bk_main_flags')));
  if(ConsumerDisclosure.Debug AND in_mod.IncludeBankruptcy, output(bk_main, named('bk_main')));
  // if($.Debug AND in_mod.IncludeBankruptcy, output(bk_main_filtered, named('bk_main_filtered')));
  if(ConsumerDisclosure.Debug AND in_mod.IncludeBankruptcy, output(bk_main_with_parties, named('bk_main_with_parties')));
  if(ConsumerDisclosure.Debug AND in_mod.IncludeBankruptcy, output(bk_out, named('bankruptcy_recs')));

  return sort(bk_out, -date_last_seen, -date_first_seen);
END;

END;

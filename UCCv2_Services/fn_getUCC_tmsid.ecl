// Get UCC data for a SET of tmsid records

// code modeled after LiensV2_Services/fn_get_liens_tmsid

IMPORT UCCv2, Address, doxie, doxie_raw, ut, fcra, STD, FFD;

MAX_OVERRIDE_LIMIT := FCRA.compliance.MAX_OVERRIDE_LIMIT;

EXPORT fn_getUCC_tmsid(
  DATASET(UCCv2_services.layout_tmsid) in_tmsids,
  STRING in_ssn_mask_type,
  BOOLEAN IsFCRA = FALSE,
  DATASET (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
  DATASET(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
  INTEGER8 inFFDOptionsMask = 0
) := FUNCTION
  
  BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
  BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
  
  doxie.MAC_Header_Field_Declare(IsFCRA); //only: DisplayMatchedParty_value, application_type_value
  k_main := UCCV2.Key_Rmsid_Main (IsFCRA);
  k_party := UCCV2.Key_Rmsid_Party (IsFCRA);
  
  t_tmsid := TYPEOF (UCCv2_Services.layout_rmsid.tmsid);
  t_rmsid := TYPEOF (UCCv2_Services.layout_rmsid.rmsid);

  // FCRA: overrides
  _party_puids := SET (flagfile (file_id = FCRA.FILE_ID.UCC_PARTY), record_id);
  _party_ffid := SET (flagfile (file_id = FCRA.FILE_ID.UCC_PARTY), flag_file_id);

  _main_puids := SET (flagfile (file_id = FCRA.FILE_ID.UCC), record_id);
  _main_ffid := SET (flagfile (file_id = FCRA.FILE_ID.UCC), flag_file_id);

  // GET PARTY INFO FIRST FOR PULL IDS
  uccv2_services.layout_ucc_party_raw xf_party_copy(k_party R) := TRANSFORM
    SELF.address1 := Address.Addr1FromComponents(
                            R.prim_range, R.predir, R.prim_name,
                            R.suffix, R.postdir, R.unit_desig, R.sec_range);
    SELF.address2 := Address.Addr2FromComponents(
                            R.v_city_name, R.st, R.zip5);
    SELF.addr_suffix := R.suffix;
    SELF := R;
  END;
  ds_party_data := JOIN (in_tmsids, k_party,
    KEYED (LEFT.tmsid = RIGHT.tmsid) AND
    (~IsFCRA OR ((STRING)RIGHT.persistent_record_id NOT in _party_puids)),
    xf_party_copy(RIGHT),
    LIMIT(10000,SKIP)
  );

  // overrides (FCRA side only)
  party_override := CHOOSEN (fcra.key_override_ucc.party (KEYED (flag_file_id IN _party_ffid)), MAX_OVERRIDE_LIMIT);
  // put overrides into same layout, combine main data and overrides;
  party_override_st := PROJECT (party_override, RECORDOF (k_party));
  party_fcra := ds_party_data + PROJECT (party_override_st, xf_party_copy (LEFT));// uccv2_services.layout_ucc_party_raw;

  uccv2_services.layout_ucc_party_raw addPartyStatementIDs(uccv2_services.layout_ucc_party_raw l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
    SKIP((~ShowDisputedRecords AND r.isDisputed) OR (~ShowConsumerStatements AND EXISTS(r.StatementIDs)))
    SELF.statementids := r.StatementIDs,
    SELF.isdisputed := r.isdisputed,
    SELF := l
  END;

  party_fcra_ffd := JOIN(party_fcra, slim_pc_recs(datagroup = FFD.Constants.DataGroups.UCC_PARTY),
    (STRING)LEFT.persistent_record_id = RIGHT.RecID1 AND
    (((UNSIGNED)LEFT.did = (UNSIGNED) RIGHT.lexid) OR (RIGHT.acctno = FFD.Constants.SingleSearchAcctno))
    , addPartyStatementIDs(LEFT, RIGHT),
    LEFT OUTER, KEEP(1), LIMIT(0));

  ds_party_raw := IF (IsFCRA, party_fcra_ffd, ds_party_data);
    
  l_k_main := RECORD
    k_main;
    FFD.Layouts.CommonRawRecordElements;
  END;

  // TODO: check if pulling allowed on FCRA side
  tmsids_pulled := fn_pullIDs(ds_party_raw,application_type_value);
  in_tmsids_pulled := PROJECT(tmsids_pulled, TRANSFORM(UCCv2_services.layout_tmsid, SELF := LEFT));

                          
  // ======================================================================= Retrieve filing info
  // join inputs to index to get raw data
  filing_raw_reg := JOIN (in_tmsids_pulled, k_main,
                          KEYED(LEFT.tmsid = RIGHT.tmsid) AND
    // keyed (~IsFCRA or (left.rmsid = right.rmsid)) and
                          (~IsFCRA OR ((STRING)RIGHT.persistent_record_id NOT in _main_puids)),
                          TRANSFORM(l_k_main,SELF := RIGHT),
                          LIMIT(10000,SKIP)
                      );
  Doxie_Raw.MAC_ENTRP_CLEAN(filing_raw_reg,filing_date,filing_raw_entrp);
  main_data := IF(ut.industryclass.is_Entrp,filing_raw_entrp,filing_raw_reg);

  // overrides (FCRA side only)
  main_override := CHOOSEN (fcra.key_override_ucc.main (KEYED (flag_file_id IN _main_ffid)), MAX_OVERRIDE_LIMIT);
  // put overrides into same layout, combine main data and overrides; TODO: apply FCRA-filtering
  main_override_st := PROJECT (main_override, l_k_main);
  main_fcra := (main_data + main_override_st)(fcra.compliance.ucc.is_ok ((STRING) STD.Date.Today(), orig_filing_date));

  l_k_main addMainStatementIDs(l_k_main l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
    SKIP((~ShowDisputedRecords AND r.isDisputed) OR (~ShowConsumerStatements AND EXISTS(r.StatementIDs)))
    SELF.statementids := r.StatementIDs,
    SELF.isdisputed := r.isdisputed,
    SELF := l
  END;

  main_fcra_ffd := JOIN(main_fcra, slim_pc_recs(datagroup = FFD.Constants.DataGroups.UCC),
    (STRING)LEFT.persistent_record_id = RIGHT.RecID1 AND
    ((RIGHT.acctno = FFD.Constants.SingleSearchAcctno)) // NOT batch safe
    , addMainStatementIDs(LEFT, RIGHT),
    LEFT OUTER, KEEP(1), LIMIT(0));

  filing_raw_ucc := IF (IsFCRA, main_fcra_ffd, main_data);


  // ======================================================================= Retrieve history data

  // Filings(history) section layout is now in grandfather/father/grandchild format.

  // First create a temp father dataset/layout from data on the key main file
  temp_father_layout := RECORD
    k_main.tmsid; //needed for the grandfather layout & linking to the party file
    k_main.orig_filing_number; //needed for checking to create boolean on the grandfather layout
    k_main.orig_filing_type; //needed for checking to create boolean on the grandfather layout
    k_main.orig_filing_date; //needed for checking to create boolean on the grandfather layout
    k_main.process_date; //needed for keeping most recent filing when matching filing numbers occur.
    uccv2_services.layout_ucc_hist; // data from main file neeed for final layout
    FFD.Layouts.CommonRawRecordElements;
  END;
  
  temp_father_layout xf_main_copy(l_k_main r) := TRANSFORM
    // Create empty "filing_parties" grandchild dataset for now
    SELF.filing_parties := DATASET([],UCCv2_Services.layout_ucc_hist_parties);
    SELF.isdisputed := r.isdisputed;
    SELF.statementids := r.statementids;
    // take rest of fields from right (k_main) file
    SELF := r;
  END;

  // Get history/filing records/data from main key file
  ds_history_temp_father := PROJECT(filing_raw_ucc, xf_main_copy (LEFT));

  // Next sort records by tmsid and filing date, number, etc.
  // and then dedup identical filings, preserving ones with greatest expiration date.
  ds_history_deduped_father := DEDUP(SORT(ds_history_temp_father, tmsid,
                                                                  filing_date,
                                                                   filing_number,
                                                                   filing_type,
                                                                  -process_date,
                                                                   -expiration_date,
                                                                   RECORD),
                                     tmsid, filing_date, filing_number, filing_type);

  // "Filing_Parties" grandchild dataset transform
  UCCv2_Services.layout_ucc_hist_parties xf_party(
                                   UCCv2_Services.layout_ucc_party_raw l) := TRANSFORM
     SELF.party_type_desc := MAP(l.party_type = 'A' => 'ASSN',
                                 l.party_type = 'C' OR
                                 l.party_type = 'S' => 'SECD',
                                 l.party_type = 'D' => 'DEBT',
                                 l.party_type);
     SELF.party_name := IF(l.company_name<>'',l.company_name,
                                STD.Str.CleanSpaces(l.fname + ' ' + l.mname + ' ' + l.lname + ' ' + l.name_suffix));
  END;

  temp_father_layout xf_father(temp_father_layout l, DATASET(UCCv2_Services.layout_ucc_party_raw) r) := TRANSFORM
    // since we keep here only party name and type, we need to remove duplicates:
    r_dedupped := DEDUP(
                        SORT(r,party_type,company_name,lname,fname,mname,name_suffix,RECORD),
                        party_type,company_name,lname,fname,mname,name_suffix);
   // Fill in "filing_parties" grandchild dataset
    SELF.filing_parties := PROJECT(
                           CHOOSEN(r_dedupped,UCCv2_Services.Constants.MAXCOUNT_FILING_PARTIES),
                           xf_party(LEFT));
    
    SELF.isdisputed := l.isdisputed;
    SELF.statementids := l.statementids;
    SELF := l;
  END;
    
  // Next use a denormalize/group to fill in the filing_parties info.
  ds_history_denormed_father := DENORMALIZE(ds_history_deduped_father,ds_party_raw,
                                          LEFT.tmsid = RIGHT.tmsid AND
                                          fn_remove_DNB_rmsid_seq(LEFT.rmsid,LEFT.tmsid) = RIGHT.rmsid,
                                          GROUP,
                                          xf_father(LEFT,rows(RIGHT)));
  
  // Re-sort after denormalize to put records back in proper order
  // by tmsid and recency (descending on filing date, number, etc.).
  ds_history_resorted_father := SORT(ds_history_denormed_father, tmsid,
                                                                 -filing_date,
                                                                  -filing_number,
                                                                  -filing_type,
                                                                  -expiration_date,
                                                                  RECORD);

  // Next create grandfather dataset/layout
  temp_hist_layout := RECORD
    BOOLEAN isValidFiling;
    k_main.tmsid;
    DATASET(uccv2_services.layout_ucc_hist) filings{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_RAW)};
    FFD.Layouts.CommonRawRecordElements;
  END;
  
  temp_hist_layout xf_history_copy(temp_father_layout r) := TRANSFORM
    SELF.isValidFiling := IF(
      r.filing_number <> '' OR r.filing_date <> '' OR r.filing_type <> '' OR
        r.orig_filing_number <> '' OR r.orig_filing_date <> '' OR r.orig_filing_type <> '',
      TRUE,
      SKIP
    );
    SELF.tmsid := r.tmsid;
    SELF.filings := DATASET(
      [{
        r.rmsid,
        r.filing_number,
        r.filing_type,
        r.filing_date,
        r.filing_status,
        r.status_type,
        r.page,
        r.expiration_date,
        r.contract_type,
        r.amount,
        r.irs_serial_number,
        r.effective_date,
        r.filing_parties
      }],
      uccv2_services.layout_ucc_hist);
    SELF.statementids := r.statementids;
    SELF.isdisputed := r.isdisputed;
  END;

  // Use project to create grandfather
  ds_history_sort := PROJECT(ds_history_resorted_father,xf_history_copy(LEFT));
  
  // Rollup by tmsid
  ds_history_sort xf_hist_rollup_1(ds_history_sort l, ds_history_sort r) := TRANSFORM
    SELF.filings := CHOOSEN(l.filings + r.filings,UCCv2_Services.Constants.MAXCOUNT_FILINGS);
    SELF.statementids := DEDUP(l.statementids + r.statementids, all);
    SELF.isdisputed := l.isdisputed OR r.isdisputed;
    SELF := l;
  END;
  
  ds_history_rolled := ROLLUP(
    ds_history_sort,
    LEFT.tmsid = RIGHT.tmsid,
    xf_hist_rollup_1(LEFT,RIGHT)
  );


  // ======================================================================= Retrieve signer data
  
  // Get signer records from key
  temp_signer_layout := RECORD
    k_main.tmsid;
    DATASET(uccv2_services.layout_ucc_signer) signers{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_SIGNERS)};
  END;
  temp_signer_layout xf_signer_copy(l_k_main r) := TRANSFORM
    SELF.tmsid := r.tmsid;
    SELF.signers := DATASET(
      [{
        r.signer_name,
        r.title
      }],
      uccv2_services.layout_ucc_signer);
  END;
  ds_signers_raw := PROJECT(filing_raw_reg, xf_signer_copy (LEFT));

  // Sort signer records by tmsid
  ds_signers_sort := SORT(ds_signers_raw, tmsid);

  // Rollup by tmsid
  ds_signers_sort xf_signer_rollup_1(ds_signers_sort l, ds_signers_sort r) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.signers := CHOOSEN(l.signers + r.signers,UCCv2_Services.Constants.MAXCOUNT_SIGNERS);
  END;
  ds_signers_roll := ROLLUP(
    ds_signers_sort,
    LEFT.tmsid = RIGHT.tmsid,
    xf_signer_rollup_1(LEFT,RIGHT)
  );
  
  // and dedup identical filings
  ds_signers_roll xf_signer_rollup_2(ds_signers_roll L) := TRANSFORM
    SELF.tmsid := L.tmsid;
    validSigners := L.signers(signer_name <> '' OR title <> '');
    SELF.signers := DEDUP( SORT(validSigners, RECORD) );
  END;
  ds_signers_rolled := PROJECT(ds_signers_roll, xf_signer_rollup_2(LEFT));


  // ======================================================================= Retrieve Filing Office data
  
  // Get filofc records from key
  temp_filofc_layout := RECORD
    k_main.tmsid;
    DATASET(uccv2_services.layout_ucc_filofc) filing_offices{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_FILING_OFFICES)};
  END;
  temp_filofc_layout xf_filofc_copy(l_k_main r) := TRANSFORM
    SELF.tmsid := r.tmsid;
    SELF.filing_offices := DATASET(
      [{
        r.filing_agency,
        r.address,
        r.city,
        r.state,
        r.county,
        r.zip
      }],
      uccv2_services.layout_ucc_filofc);
  END;
  ds_filofc_raw := PROJECT (filing_raw_reg, xf_filofc_copy (LEFT));

  // Sort filofc records by tmsid
  ds_filofc_sort := SORT(ds_filofc_raw, tmsid);

  // Rollup by tmsid
  ds_filofc_sort xf_filofc_rollup_1(ds_filofc_sort l, ds_filofc_sort r) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.filing_offices := CHOOSEN(l.filing_offices + r.filing_offices,UCCv2_Services.Constants.MAXCOUNT_FILING_OFFICES);
  END;
  ds_filofc_roll := ROLLUP(
    ds_filofc_sort,
    LEFT.tmsid = RIGHT.tmsid,
    xf_filofc_rollup_1(LEFT,RIGHT)
  );
  
  // and dedup identical filings
  ds_filofc_roll xf_filofc_rollup_2(ds_filofc_roll L) := TRANSFORM
    SELF.tmsid := L.tmsid;
    validOffices := L.filing_offices(
      filing_agency <> '' OR
        address <> '' OR
        city <> '' OR
        state <> '' OR
        county <> '' OR
        zip <> ''
    );
    SELF.filing_offices := DEDUP( SORT(validOffices, RECORD) );
  END;
  ds_filofc_rolled := PROJECT(ds_filofc_roll, xf_filofc_rollup_2(LEFT));


  // ======================================================================= Retrieve Collateral data
  
  // Get collateral records from key
  temp_coll_layout := RECORD
    k_main.tmsid;
    DATASET(uccv2_services.layout_ucc_coll) collateral{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_RAW)};
  END;
  temp_coll_layout xf_coll_copy(l_k_main r) := TRANSFORM
    SELF.tmsid := r.tmsid;
    SELF.collateral := DATASET(
      [{
        // Temp fix for bug 33695 to store the filing_date (formatted in mm/dd/yyyy format)
        // and filing_number at the front of collateral_desc field before the actual
        // collateral text.
        // Once ESP & WEB can handle the additional separate r.filing_number and
        // r.filing_date fields, this temp fix can be removed.
        IF(r.collateral_desc<>'',IF(r.filing_date<>'',r.filing_date[5..6] + '/' + //mm
                                                      r.filing_date[7..8] + '/' + //dd
                                                      r.filing_date[1..4] + ' ' + //yyyy
                                                      TRIM(r.filing_number,LEFT,RIGHT) +
                                                      ' - ' + r.collateral_desc,
                                                   IF(r.orig_filing_date<>'',
                                                      r.orig_filing_date[5..6] + '/' + //mm
                                                      r.orig_filing_date[7..8] + '/' + //dd
                                                      r.orig_filing_date[1..4] + ' ' + //yyyy
                                                      TRIM(r.orig_filing_number,LEFT,RIGHT) +
                                                      ' - ' + r.collateral_desc,
                                                      r.collateral_desc)),
                                    ''),
        /* Commented out line below is for future use once the ESP & WEB areas can handle
           the new r.filing_number & r.filing_date fields added below.
        r.collateral_desc,
        */
        r.collateral_count,
        r.serial_number,
        r.property_desc,
        r.collateral_address,
        IF(r.filing_number<>'',r.filing_number,r.orig_filing_number),
        IF(r.filing_date<>'',r.filing_date,r.orig_filing_date)
      }],
      uccv2_services.layout_ucc_coll);
  END;
  ds_coll_nonempty := filing_raw_reg (collateral_desc <> '' OR collateral_count <> '' OR
                                      serial_number <> '' OR property_desc <> '' OR
                                      collateral_address <> '');
  ds_coll_raw := PROJECT (ds_coll_nonempty, xf_coll_copy(LEFT));

  // Sort collateral records by tmsid and descending on filing_date then filing_number
  // then dedup on the same fields.
  ds_coll_sort := DEDUP(SORT(ds_coll_raw, tmsid,
                                          -collateral[1].filing_date,
                                          -collateral[1].filing_number,
                                          RECORD),
                        tmsid,collateral[1].filing_date,collateral[1].filing_number);

  // Rollup by tmsid
  ds_coll_sort xf_coll_rollup_1(ds_coll_sort l, ds_coll_sort r) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.collateral := CHOOSEN(l.collateral + r.collateral,UCCv2_Services.Constants.MAXCOUNT_COLLATERAL);
  END;
  
  ds_coll_rolled := ROLLUP(
    ds_coll_sort,
    LEFT.tmsid = RIGHT.tmsid,
    xf_coll_rollup_1(LEFT,RIGHT)
  );


  // ======================================================================= Format party data

  ds_debtor_formatted := fn_format_parties(ds_party_raw, 'D', in_ssn_mask_type, IsFCRA);
  ds_secured_formatted := fn_format_parties(ds_party_raw, 'S', in_ssn_mask_type, IsFCRA);
  ds_assignee_formatted := fn_format_parties(ds_party_raw, 'A', in_ssn_mask_type, IsFCRA);
  ds_creditor_formatted := fn_format_parties(ds_party_raw, 'C', in_ssn_mask_type, IsFCRA);

  layout_party := RECORD
    layout_ucc_party_raw_src.tmsid;
    DATASET(UCCv2_Services.layout_ucc_party) parties{MAXCOUNT(25)};
    UNSIGNED2 penalt;
  END;
  
  party_rec := RECORD
    STRING1 name_type;
    layout_party;
  END;
  
  party_rec xfm_partyType(layout_party l, STRING1 name_type) := TRANSFORM
    SELF.name_type := name_type;
    SELF := l;
  END;
  
  formatted_parties := DEDUP(SORT(PROJECT(ds_debtor_formatted,xfm_partyType(LEFT,'0'))
                                 +
                                 PROJECT(ds_secured_formatted,xfm_partyType(LEFT,'1'))
                                 +
                                 PROJECT(ds_assignee_formatted,xfm_partyType(LEFT,'2'))
                                 +
                                 PROJECT(ds_creditor_formatted,xfm_partyType(LEFT,'3'))
                                 ,tmsid,penalt,name_type,RECORD),tmsid);
  
  
    // TRANSFORM TO PRIME THE RESULT DATASET
  
  // ======================================================================= Assimilate data
  // First, rollup filings
  // define a temporary layout
  temp_filing_layout := RECORD
    uccv2_services.layout_ucc_filing;
    FFD.Layouts.CommonRawRecordElements;
  END;
  temp_filing_layout toFiling(l_k_main r) := TRANSFORM
    SELF.filing_jurisdiction_name := UCCv2_Services.jur2Name(r.filing_jurisdiction);
    SELF.filing_status := DATASET( [{ r.filing_status, r.status_type }], UCCv2_Services.layout_filing_status );
    SELF := r;
  END;

  Filing_raw := PROJECT(filing_raw_ucc,toFiling(LEFT));

  // sort by tmsid and recency
  filing_sort := SORT(filing_raw, tmsid, -orig_filing_date, -orig_filing_number, orig_filing_type);

  // rollup by tmsid (preferring recent data)
  filing_sort toRollup(filing_sort l, filing_sort r) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.filing_jurisdiction:= IF(l.filing_jurisdiction='', r.filing_jurisdiction, l.filing_jurisdiction);
    SELF.filing_jurisdiction_name:= IF(l.filing_jurisdiction_name='', r.filing_jurisdiction_name, l.filing_jurisdiction_name);
    SELF.orig_filing_number := IF(l.orig_filing_number='', r.orig_filing_number, l.orig_filing_number);
    SELF.orig_filing_type := IF(l.orig_filing_type='', r.orig_filing_type, l.orig_filing_type);
    SELF.orig_filing_date := IF(l.orig_filing_date='', r.orig_filing_date, l.orig_filing_date);
    SELF.filing_status := IF(EXISTS(l.filing_status), l.filing_status, r.filing_status);
    SELF.statementids := l.statementids + r.statementids;
    SELF.isdisputed := l.isdisputed OR r.isdisputed;
  END;
  ds_filing_rolled := ROLLUP(
    filing_sort,
    LEFT.tmsid = RIGHT.tmsid,
    toRollup(LEFT,RIGHT)
  );

  // Prime the result dataset
  uccv2_services.layout_ucc_rollup xf_project_filing_info(ds_filing_rolled L) := TRANSFORM
    SELF.penalt := uccPenalty.large;
    bp := formatted_parties(tmsid=l.tmsid)[1];
    SELF.matched_party.party_type := IF(DisplayMatchedParty_value,MAP(bp.name_type ='0' => 'D'
                                ,bp.name_type ='1' => 'S'
                                ,bp.name_type ='2' => 'A'
                                ,'C'),'');
    SELF.matched_party.parsed_party :=IF(DisplayMatchedParty_value
                                         ,PROJECT(bp.parties[1].parsed_parties
                                         ,UCCv2_Services.assorted_layouts.matched_party_name_rec)[1]
                                         );
    SELF.matched_party.address := IF(DisplayMatchedParty_value
                                    ,PROJECT(bp.parties[1].addresses
                                    ,UCCv2_Services.assorted_layouts.matched_party_address_rec)[1]);
    SELF.matched_party := IF(DisplayMatchedParty_value,bp.parties[1]);
    SELF.statementids := L.statementids;
    SELF.isdisputed := L.isdisputed;
    SELF := L;
    SELF := [];
  END;
  
  ds_primed_rollup := PROJECT(ds_filing_rolled, xf_project_filing_info(LEFT));
  
  // Join the debtor information
  ds_primed_rollup xf_join_debtors(ds_primed_rollup L, ds_debtor_formatted R) := TRANSFORM
    SELF.debtors := CHOOSEN(R.parties,25);
    UCCv2_Services.mac_PickPenalty()
    SELF := L;
  END;
  ds_primed_rollup_dXXXX := JOIN(
    ds_primed_rollup, ds_debtor_formatted,
    LEFT.tmsid = RIGHT.tmsid,
    xf_join_debtors(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(10000)
  );

  // Join the secured information
  ds_primed_rollup xf_join_secureds(ds_primed_rollup L, ds_secured_formatted R) := TRANSFORM
    SELF.secureds := CHOOSEN(R.parties,10);
    UCCv2_Services.mac_PickPenalty()
    SELF := L;
  END;
  ds_primed_rollup_dsXXX := JOIN(
    ds_primed_rollup_dXXXX, ds_secured_formatted,
    LEFT.tmsid = RIGHT.tmsid,
    xf_join_secureds(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(10000)
  );

  // Join the assignee information
  ds_primed_rollup xf_join_assignees(ds_primed_rollup L, ds_assignee_formatted R) := TRANSFORM
    SELF.assignees := CHOOSEN(R.parties,10);
    UCCv2_Services.mac_PickPenalty()
    SELF := L;
  END;
  ds_primed_rollup_dsaXX := JOIN(
    ds_primed_rollup_dsXXX, ds_assignee_formatted,
    LEFT.tmsid = RIGHT.tmsid,
    xf_join_assignees(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(10000)
  );

  // Join the creditor information
  ds_primed_rollup xf_join_creditors(ds_primed_rollup L, ds_creditor_formatted R) := TRANSFORM
    SELF.creditors := CHOOSEN(R.parties,10);
    UCCv2_Services.mac_PickPenalty()
    SELF := L;
  END;
  ds_primed_rollup_dsacX := JOIN(
    ds_primed_rollup_dsaXX, ds_creditor_formatted,
    LEFT.tmsid = RIGHT.tmsid,
    xf_join_creditors(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(10000)
  );

  // Join the history information
  ds_primed_rollup xf_join_history(ds_primed_rollup l, ds_history_rolled r) := TRANSFORM
    SELF.filings := CHOOSEN(r.filings,UCCv2_Services.Constants.MAXCOUNT_FILINGS);
    SELF := l;
  END;
  ds_primed_rollup_dsach := JOIN(
    ds_primed_rollup_dsacX, ds_history_rolled,
    LEFT.tmsid = RIGHT.tmsid,
    xf_join_history(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(10000)
  );

  // Join the signer information
  ds_primed_rollup xf_join_signers(ds_primed_rollup l, ds_signers_rolled r) := TRANSFORM
    SELF.signers := CHOOSEN(r.signers,UCCv2_Services.Constants.MAXCOUNT_SIGNERS);
    SELF := l;
  END;
  ds_primed_rollup_dsachs := JOIN(
    ds_primed_rollup_dsach, ds_signers_rolled,
    LEFT.tmsid = RIGHT.tmsid,
    xf_join_signers(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(10000)
  );

  // Join the filing office information
  ds_primed_rollup xf_join_filofc(ds_primed_rollup l, ds_filofc_rolled r) := TRANSFORM
    SELF.filing_offices := CHOOSEN(r.filing_offices,UCCv2_Services.Constants.MAXCOUNT_FILING_OFFICES);
    SELF := l;
  END;
  ds_primed_rollup_dsachsf := JOIN(
    ds_primed_rollup_dsachs, ds_filofc_rolled,
    LEFT.tmsid = RIGHT.tmsid,
    xf_join_filofc(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(10000)
  );
  
  // Join the collateral information
  ds_primed_rollup xf_join_coll(ds_primed_rollup l, ds_coll_rolled r) := TRANSFORM
    SELF.collateral := CHOOSEN(r.collateral,UCCv2_Services.Constants.MAXCOUNT_COLLATERAL);
    SELF := l;
  END;
  ds_primed_rollup_dsachsfc := JOIN(
    ds_primed_rollup_dsachsf, ds_coll_rolled,
    LEFT.tmsid = RIGHT.tmsid,
    xf_join_coll(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(10000)
  );

  // RETURN THE ROLLED UP DATA
  RETURN( SORT(ds_primed_rollup_dsachsfc,-orig_filing_date,RECORD) );
END;

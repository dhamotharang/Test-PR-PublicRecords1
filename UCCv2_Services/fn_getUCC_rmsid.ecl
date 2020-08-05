// Get UCC data for a set of rmsid records

// code modeled after LiensV2_Services.fn_get_liens_rmsid

IMPORT UCCv2, Address;

EXPORT fn_getUCC_rmsid(
  DATASET(UCCv2_services.layout_rmsid) in_rmsids,
  STRING in_ssn_mask_type,
  BOOLEAN return_multiple_pages = FALSE,
  STRING32 appType
) := FUNCTION

  in_tmsids := DEDUP( SORT( PROJECT(in_rmsids, UCCv2_services.layout_tmsid), RECORD ) );

  k_main := UCCV2.Key_Rmsid_Main ();
  k_party := UCCV2.Key_Rmsid_Party ();

  // GET PARTY INFO FIRST FOR PULL IDS
  uccv2_services.layout_ucc_party_raw_src xf_party_copy(k_party R) := TRANSFORM
    SELF.address1 := Address.Addr1FromComponents(
                            R.prim_range, R.predir, R.prim_name,
                            R.suffix, R.postdir, R.unit_desig, R.sec_range);
    SELF.address2 := Address.Addr2FromComponents(
                            R.v_city_name, R.st, R.zip5);
    SELF.addr_suffix := R.suffix;
    SELF := R;
  END;
  ds_party_raw := JOIN(
    in_tmsids, k_party,
    KEYED(LEFT.tmsid = RIGHT.tmsid),
    xf_party_copy(RIGHT),
    LIMIT(10000,SKIP)
  );

  tmsids_pulled := fn_pullIDs(PROJECT(ds_party_raw,uccv2_services.layout_ucc_party_raw),appType);
  in_tmsids_pulled := JOIN(in_tmsids, tmsids_pulled, LEFT.tmsid = RIGHT.tmsid,
                            TRANSFORM(UCCv2_services.layout_tmsid, SELF := LEFT));
  
  
  // ======================================================================= Retrieve filing info

  // define a temporary layout to allow sorting for most recent filing for a tmsid.
  k_main_lay := uccv2.layout_UCC_common.layout_ucc_new;
  temp_filing_layout := RECORD
      uccv2_services.layout_ucc_filing_src;
      k_main_lay.filing_number;
      k_main_lay.filing_type;
      k_main_lay.filing_date;
  END;

  temp_filing_layout toFiling(k_main r) := TRANSFORM
    SELF.filing_jurisdiction_name := UCCv2_Services.jur2Name(r.filing_jurisdiction);
    SELF.filing_status := DATASET( [{ r.filing_status, r.status_type }], UCCv2_Services.layout_filing_status );
    SELF := r;
  END;

  // join inputs to index to get raw data
  filing_raw := JOIN(
    in_tmsids_pulled, k_main,
    KEYED(LEFT.tmsid = RIGHT.tmsid),
    toFiling(RIGHT),
    LIMIT(10000,SKIP)
  );

  // sort by tmsid and recency
  filing_sort := SORT(filing_raw, tmsid, -filing_date, -filing_number, filing_type, RECORD);
  
  // rollup by tmsid (preferring recent data)
  filing_sort toRollup(filing_sort l, filing_sort r) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.filing_jurisdiction:= IF(l.filing_jurisdiction='', r.filing_jurisdiction, l.filing_jurisdiction);
    SELF.filing_jurisdiction_name:= IF(l.filing_jurisdiction_name='', r.filing_jurisdiction_name, l.filing_jurisdiction_name);
    SELF.orig_filing_number := IF(l.orig_filing_number='', r.orig_filing_number, l.orig_filing_number);
    SELF.orig_filing_type := IF(l.orig_filing_type='', r.orig_filing_type, l.orig_filing_type);
    SELF.orig_filing_date := IF(l.orig_filing_date='', r.orig_filing_date, l.orig_filing_date);
    SELF.orig_filing_time := IF(l.orig_filing_time='', r.orig_filing_time, l.orig_filing_time);
    SELF.filing_status := IF(EXISTS(l.filing_status), l.filing_status, r.filing_status);
    SELF.cmnt_effective_date:= IF(l.cmnt_effective_date='', r.cmnt_effective_date, l.cmnt_effective_date);
    SELF.description := IF(l.description='', r.description, l.description);
    SELF.filing_number := '';
    SELF.filing_type := '';
    SELF.filing_date := '';
  END;
  ds_filing_rolled := ROLLUP(
    filing_sort,
    LEFT.tmsid = RIGHT.tmsid,
    toRollup(LEFT,RIGHT)
  );


  // ======================================================================= Retrieve history data

  // Filings(history) section layout is now in grandfather/father/grandchild format.

  // First create a temp father dataset/layout from data on the key main file
  temp_father_layout := RECORD
    k_main.tmsid; //needed for the grandfather layout & linking to the party file
    k_main.orig_filing_number; //needed for checking to create BOOLEAN on the grandfather layout
    k_main.orig_filing_type; //needed for checking to create BOOLEAN on the grandfather layout
    k_main.orig_filing_date; //needed for checking to create BOOLEAN on the grandfather layout
    k_main.process_date; //needed for keeping most recent filing when matching filing numbers occur.
    uccv2_services.layout_ucc_hist_src; // data from main file neeed for final layout
  END;
  
  temp_father_layout xf_main_copy(k_main r) := TRANSFORM
    // Create empty "filing_parties" grandchild dataset for now
    SELF.filing_parties := DATASET([],UCCv2_Services.layout_ucc_hist_parties);
    // take rest of fields from right (k_main) file
    SELF := r;
  END;

  // Get history/filing records/data from main key file
  ds_history_temp_father := JOIN(
    in_tmsids_pulled, k_main,
    KEYED(LEFT.tmsid = RIGHT.tmsid),
    xf_main_copy(RIGHT),
    LIMIT(10000,SKIP)
  );

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
                                   UCCv2_Services.layout_ucc_party_raw_src l) := TRANSFORM
     SELF.party_type_desc := MAP(l.party_type = 'A' => 'ASSN',
                                 l.party_type = 'C' OR
                                 l.party_type = 'S' => 'SECD',
                                 l.party_type = 'D' => 'DEBT',
                                 l.party_type);
     SELF.party_name := IF(l.company_name<>'',l.company_name,
                                TRIM(TRIM(l.fname,LEFT,RIGHT) + ' ' +
                                     TRIM(l.mname,LEFT,RIGHT) + ' ' +
                                     TRIM(l.lname,LEFT,RIGHT) + ' ' +
                                     TRIM(l.name_suffix,LEFT,RIGHT),LEFT,RIGHT));
  END;

  temp_father_layout xf_father(temp_father_layout l, DATASET(UCCv2_Services.layout_ucc_party_raw_src) r) := TRANSFORM
   // Fill in "filing_parties" grandchild dataset
    SELF.filing_parties := PROJECT(
                           CHOOSEN(r,UCCv2_Services.Constants.MAXCOUNT_FILING_PARTIES),
                           xf_party(LEFT));
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
    DATASET(uccv2_services.layout_ucc_hist_src) filings{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_RAW)};
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
        r.filing_number_indc,
        r.filing_type,
        r.filing_date,
        r.filing_time,
        r.filing_status,
        r.status_type,
        r.page,
        r.expiration_date,
        r.contract_type,
        r.vendor_entry_date,
        r.vendor_upd_date,
        r.statements_filed,
        r.continuious_expiration,
        r.microfilm_number,
        r.amount,
        r.irs_serial_number,
        r.effective_date,
        r.filing_parties
      }],
      uccv2_services.layout_ucc_hist_src);
  END;

  // Use project to create grandfather
  ds_history_sort := PROJECT(ds_history_resorted_father,xf_history_copy(LEFT));

  // Rollup by tmsid
  ds_history_sort xf_hist_rollup_1(ds_history_sort l, ds_history_sort r) := TRANSFORM
    SELF.filings := CHOOSEN(l.filings + r.filings,UCCv2_Services.Constants.MAXCOUNT_FILINGS);
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
  temp_signer_layout xf_signer_copy(k_main r) := TRANSFORM
    SELF.tmsid := r.tmsid;
    SELF.signers := DATASET(
      [{
        r.signer_name,
        r.title
      }],
      uccv2_services.layout_ucc_signer);
  END;
  ds_signers_raw := JOIN(
    in_tmsids_pulled, k_main,
    KEYED(LEFT.tmsid = RIGHT.tmsid),
    xf_signer_copy(RIGHT),
    LIMIT(10000,SKIP)
  );

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
  temp_filofc_layout xf_filofc_copy(k_main r) := TRANSFORM
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
  ds_filofc_raw := JOIN(
    in_tmsids_pulled, k_main,
    KEYED(LEFT.tmsid = RIGHT.tmsid),
    xf_filofc_copy(RIGHT),
    LIMIT(10000,SKIP)
  );

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
    DATASET(uccv2_services.layout_ucc_coll_src) collateral{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_RAW)};
  END;

  temp_coll_layout xf_coll_copy(k_main r) := TRANSFORM
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
        r.prim_machine,
        r.sec_machine,
        r.manufacturer_code,
        r.manufacturer_name,
        r.model,
        r.model_year,
        r.model_desc,
        r.collateral_count,
        r.manufactured_year,
        r.new_used,
        r.serial_number,
        r.property_desc,
        r.borough,
        r.block,
        r.lot,
        r.collateral_address,
        r.air_rights_indc,
        r.subterranean_rights_indc,
        r.easment_indc,
        IF(r.filing_number<>'',r.filing_number,r.orig_filing_number),
        IF(r.filing_date<>'',r.filing_date,r.orig_filing_date)
      }],
      uccv2_services.layout_ucc_coll_src);
  END;

  ds_coll_raw := JOIN(
    in_tmsids_pulled, k_main,
    KEYED(LEFT.tmsid = RIGHT.tmsid)
    AND
    (RIGHT. collateral_desc <> '' OR
     RIGHT.collateral_count <> '' OR
     RIGHT.serial_number <> '' OR
     RIGHT.property_desc <> '' OR
     RIGHT.collateral_address <> ''),
    xf_coll_copy(RIGHT),
    LIMIT(10000,SKIP)
  );

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

  ds_coll_rolled := ROLLUP(ds_coll_sort, LEFT.tmsid = RIGHT.tmsid, xf_coll_rollup_1(LEFT,RIGHT));


  // ======================================================================= format party data
  ds_debtor_formatted := fn_format_parties_src(ds_party_raw, 'D', in_ssn_mask_type, UCCv2_Services.Constants.MAXCOUNT_DEBTORS, return_multiple_pages);
  ds_secured_formatted := fn_format_parties_src(ds_party_raw, 'S', in_ssn_mask_type, UCCv2_Services.Constants.MAXCOUNT_SECUREDS, return_multiple_pages);
  ds_assignee_formatted := fn_format_parties_src(ds_party_raw, 'A', in_ssn_mask_type, UCCv2_Services.Constants.MAXCOUNT_ASSIGNEES, return_multiple_pages);
  ds_creditor_formatted := fn_format_parties_src(ds_party_raw, 'C', in_ssn_mask_type, UCCv2_Services.Constants.MAXCOUNT_CREDITORS, return_multiple_pages);
  
  // ======================================================================= determine max pages

  // Determine the number of pages (i.e. records) that the system must return. We need to determine this
  // beforehand, since we'll be joining all of the record sections based on tmsid and page_no.
  
  rec_max_pages_per_filing := RECORD
    uccv2_services.layout_ucc_filing_src;
    INTEGER max_pages;
  END;

  rec_max_pages_per_filing xfm_determine_max_pages(ds_filing_rolled l) :=
    TRANSFORM
      SELF.max_pages := MAX( MAX(ds_debtor_formatted(tmsid = l.tmsid), page_no),
                             MAX(ds_secured_formatted(tmsid = l.tmsid), page_no),
                             MAX(ds_assignee_formatted(tmsid = l.tmsid), page_no),
                             MAX(ds_creditor_formatted(tmsid = l.tmsid), page_no)
                            );
      SELF := l;
    END;
    
  ds_tmsids_with_max_pages := PROJECT(ds_filing_rolled, xfm_determine_max_pages(LEFT));

  rec_filing_with_page_no := RECORD
    uccv2_services.layout_ucc_filing_src;
    INTEGER page_no;
  END;
  
  ds_party_recs_seed := NORMALIZE(ds_tmsids_with_max_pages,
                                 LEFT.max_pages,
                                 TRANSFORM(rec_filing_with_page_no,
                                           SELF.tmsid := LEFT.tmsid;
                                           SELF.page_no := COUNTER;
                                           SELF := LEFT;)
                                );

  // ======================================================================= Assimilate data

  layout_ucc_rollup_src_with_page_no := RECORD
    uccv2_services.layout_ucc_rollup_src;
    INTEGER page_no;
  END;
  
  // Prime the result dataset
  layout_ucc_rollup_src_with_page_no xf_project_filing_info(ds_party_recs_seed L, ds_filing_rolled R) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.page_no := l.page_no;
    SELF.penalt := uccPenalty.large;
    SELF := R;
    SELF := [];
  END;
  
  ds_primed_rollup_XXXXX := JOIN(ds_party_recs_seed, ds_filing_rolled,
                                  LEFT.tmsid = RIGHT.tmsid AND
                                  LEFT.page_no = 1,
                                  xf_project_filing_info(LEFT,RIGHT),
                                  LEFT OUTER,
                                  KEEP(10000));
  
  // Join the debtor information
  layout_ucc_rollup_src_with_page_no xf_join_debtors(layout_ucc_rollup_src_with_page_no L, ds_debtor_formatted R) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.page_no := l.page_no;
    SELF.debtors := R.parties;
    UCCv2_Services.mac_PickPenalty()
    SELF := L;
  END;
  ds_primed_rollup_dXXXX := JOIN(
    ds_primed_rollup_XXXXX, ds_debtor_formatted,
    LEFT.tmsid = RIGHT.tmsid AND
    LEFT.page_no = RIGHT.page_no,
    xf_join_debtors(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(10000)
  );

  // Join the secured information
  layout_ucc_rollup_src_with_page_no xf_join_secureds(layout_ucc_rollup_src_with_page_no L, ds_secured_formatted R) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.page_no := l.page_no;
    SELF.secureds := R.parties;
    UCCv2_Services.mac_PickPenalty()
    SELF := L;
  END;
  ds_primed_rollup_dsXXX := JOIN(
    ds_primed_rollup_dXXXX, ds_secured_formatted,
    LEFT.tmsid = RIGHT.tmsid AND
    LEFT.page_no = RIGHT.page_no,
    xf_join_secureds(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(10000)
  );

  // Join the assignee information
  layout_ucc_rollup_src_with_page_no xf_join_assignees(layout_ucc_rollup_src_with_page_no L, ds_assignee_formatted R) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.page_no := l.page_no;
    SELF.assignees := R.parties;
    UCCv2_Services.mac_PickPenalty()
    SELF := L;
  END;
  ds_primed_rollup_dsaXX := JOIN(
    ds_primed_rollup_dsXXX, ds_assignee_formatted,
    LEFT.tmsid = RIGHT.tmsid AND
    LEFT.page_no = RIGHT.page_no,
    xf_join_assignees(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(10000)
  );

  // Join the creditor information
  layout_ucc_rollup_src_with_page_no xf_join_creditors(layout_ucc_rollup_src_with_page_no L, ds_creditor_formatted R) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.page_no := l.page_no;
    SELF.creditors := R.parties;
    UCCv2_Services.mac_PickPenalty()
    SELF := L;
  END;
  ds_primed_rollup_dsacX := JOIN(
    ds_primed_rollup_dsaXX, ds_creditor_formatted,
    LEFT.tmsid = RIGHT.tmsid AND
    LEFT.page_no = RIGHT.page_no,
    xf_join_creditors(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(10000)
  );

  // Join the history information
  layout_ucc_rollup_src_with_page_no xf_join_history(layout_ucc_rollup_src_with_page_no l, ds_history_rolled r) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.page_no := l.page_no;
    SELF.filings := CHOOSEN(r.filings,UCCv2_Services.Constants.MAXCOUNT_FILINGS);
    SELF := l;
  END;
  ds_primed_rollup_dsach := JOIN(
    ds_primed_rollup_dsacX, ds_history_rolled,
    LEFT.tmsid = RIGHT.tmsid AND
    LEFT.page_no = 1,
    xf_join_history(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(10000)
  );

  // Join the signer information
  layout_ucc_rollup_src_with_page_no xf_join_signers(layout_ucc_rollup_src_with_page_no l, ds_signers_rolled r) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.page_no := l.page_no;
    SELF.signers := CHOOSEN(r.signers,UCCv2_Services.Constants.MAXCOUNT_SIGNERS);
    SELF := l;
  END;
  ds_primed_rollup_dsachs := JOIN(
    ds_primed_rollup_dsach, ds_signers_rolled,
    LEFT.tmsid = RIGHT.tmsid AND
    LEFT.page_no = 1,
    xf_join_signers(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(10000)
  );

  // Join the filing office information
  layout_ucc_rollup_src_with_page_no xf_join_filofc(layout_ucc_rollup_src_with_page_no l, ds_filofc_rolled r) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.page_no := l.page_no;
    SELF.filing_offices := CHOOSEN(r.filing_offices,UCCv2_Services.Constants.MAXCOUNT_FILING_OFFICES);
    SELF := l;
  END;
  ds_primed_rollup_dsachsf := JOIN(
    ds_primed_rollup_dsachs, ds_filofc_rolled,
    LEFT.tmsid = RIGHT.tmsid AND
    LEFT.page_no = 1,
    xf_join_filofc(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(10000)
  );
  
  // Join the collateral information
  layout_ucc_rollup_src_with_page_no xf_join_coll(layout_ucc_rollup_src_with_page_no l, ds_coll_rolled r) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.page_no := l.page_no;
    SELF.collateral := CHOOSEN(r.collateral,UCCv2_Services.Constants.MAXCOUNT_COLLATERAL);
    SELF := l;
  END;
  ds_primed_rollup_dsachsfc := JOIN(
    ds_primed_rollup_dsachsf, ds_coll_rolled,
    LEFT.tmsid = RIGHT.tmsid AND
    LEFT.page_no = 1,
    xf_join_coll(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(10000)
  );
  
  
  // Slim off the page_no.
  ds_rollup := PROJECT(ds_primed_rollup_dsachsfc, UCCv2_Services.layout_ucc_rollup_src) ;
  
  // RETURN THE ROLLED UP DATA
  RETURN( SORT(ds_rollup, -orig_filing_date, RECORD) );
  
END;

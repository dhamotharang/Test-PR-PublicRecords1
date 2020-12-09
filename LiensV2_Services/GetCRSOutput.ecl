IMPORT liensv2,doxie,CriminalRecords_Services, FFD, FCRA, ut, STD;

EXPORT GetCRSOutput (
  GROUPED DATASET (liensv2_services.layout_lien_party_raw) party_in, //JOIN with key_party_id
  DATASET (liensv2_services.layout_liens_case_extended) case_in,
  DATASET (liensv2_services.layout_liens_history_extended) history_in,
  STRING in_ssn_mask_type,
  BOOLEAN IsFCRA = FALSE,
  STRING filter_id = '',
  BOOLEAN return_multiple_pages = FALSE,
  BOOLEAN includeCriminalIndicators = FALSE,
  DATASET (FFD.Layouts.PersonContextBatchSlim) ds_slim_pc = FFD.Constants.BlankPersonContextBatchSlim,
  INTEGER8 inFFDOptionsMask = 0,
  INTEGER FCRAPurpose = FCRA.FCRAPurpose.NoValueProvided
) := FUNCTION

  doxie.MAC_Header_Field_Declare(IsFCRA); // only for DisplayMatchedParty_value !

  // FCRA FFD
  ds_ffd := LiensV2_Services.fn_doFcraCompliance(party_in, case_in,
    history_in, ds_slim_pc, inFFDOptionsMask);
  
  ds_party_raw_pre := IF(IsFCRA, GROUP(SORT(ds_ffd._party,acctno),acctno), party_in);
  ds_case_raw_pre := IF(IsFCRA, ds_ffd._case, case_in);
  ds_history_raw := IF(IsFCRA, ds_ffd._history, history_in);

  // We'll dedup and link cases by case_link_id if provided. If not, use tmsid
  ds_case_raw_pre_lnk := PROJECT(ds_case_raw_pre, TRANSFORM(liensv2_services.layout_liens_case_extended,
    SELF.case_link_id := IF(LEFT.case_link_id <> '', LEFT.case_link_id, LEFT.tmsid),
    SELF := LEFT));
  ds_history_raw_lnk := PROJECT(ds_history_raw, TRANSFORM(liensv2_services.layout_liens_history_extended,
    SELF.case_link_id := IF(LEFT.case_link_id <> '', LEFT.case_link_id, LEFT.tmsid),
    SELF := LEFT));
  
  // Populate insurance flag for parties
  rParty_w_ins_flag :=
  RECORD(liensv2_services.layout_lien_party_raw)
    STRING8 orig_filing_date;
    BOOLEAN bcbflag;
  END;
  
  rParty_w_ins_flag tInsuranceFlag(liensv2_services.layout_lien_party_raw l, liensv2_services.layout_liens_case_extended r) :=
  TRANSFORM
    SELF.orig_filing_date := r.orig_filing_date;
    SELF.bcbflag := r.bcbflag;
    SELF := l;
  END;
  
  ds_party_raw_w_ins_flag := JOIN(UNGROUP(ds_party_raw_pre),
                                  ds_case_raw_pre_lnk,
                                  LEFT.tmsid = RIGHT.tmsid AND
                                  LEFT.rmsid = RIGHT.rmsid,
                                  tInsuranceFlag(LEFT, RIGHT),
                                  LIMIT(0), KEEP(1));
  
  ds_party_raw_w_ins_flag_sort := GROUP(SORT(ds_party_raw_w_ins_flag, tmsid, orig_filing_date, rmsid, IF(bcbflag, 0, 1)), tmsid);
  
  rParty_w_ins_flag tIterate(rParty_w_ins_flag l, rParty_w_ins_flag r) :=
  TRANSFORM
    SELF.orig_filing_date := IF(l.orig_filing_date = '', r.orig_filing_date, l.orig_filing_date);
    SELF.bcbflag := IF(FCRA.lien_is_ok((STRING)STD.Date.Today(), SELF.orig_filing_date), r.bcbflag, FALSE);
    SELF := r;
  END;
  
  ds_party_raw_w_ins_flag_itr := UNGROUP(ITERATE(ds_party_raw_w_ins_flag_sort, tIterate(LEFT, RIGHT)));
  
  // Filter records for FCRA insurance
  ds_party_raw_filter := IF(isFCRA AND FCRA.FCRAPurpose.isInsuranceCreditApplication(FCRAPurpose),
                            GROUP(SORT(PROJECT(ds_party_raw_w_ins_flag_itr(bcbflag), liensv2_services.layout_lien_party_raw), acctno), acctno),
                            ds_party_raw_pre);
  
  ds_party_raw := PROJECT(ds_party_raw_filter, TRANSFORM(liensv2_services.layout_lien_party_raw, SELF.rmsid := '', SELF := LEFT));
  
  //===== ROLLUP CASE =====
  
  // SORT CASE DATA BY CASE LINK (OR TMSID), CASE_LINK_PRIORITY (IF PROVIDED) AND MOST RECENT FILING DATE
  ds_case_raw := PROJECT(ds_case_raw_pre_lnk, TRANSFORM(LiensV2_Services.layout_liens_case_extended, SELF.rmsid := '', SELF := LEFT));
  ds_case_sort := SORT (ds_case_raw, case_link_id, case_link_priority, orig_filing_date, -filing_number, filing_type_desc, RECORD);
  
  // TRANSFORM TO ROLL UP CASE INFO
  ds_case_sort xf_case_rollup(ds_case_sort l, ds_case_sort r) := TRANSFORM
    SELF.acctno := l.acctno;
    SELF.tmsid := l.tmsid;
    SELF.case_link_id := l.case_link_id;
    SELF.case_link_priority := l.case_link_priority;
    SELF.persistent_record_id:= l.persistent_record_id;
    SELF.filing_jurisdiction := IF(l.filing_jurisdiction = '',r.filing_jurisdiction,l.filing_jurisdiction);
    SELF.filing_jurisdiction_name := IF(l.filing_jurisdiction_name = '',r.filing_jurisdiction_name,l.filing_jurisdiction_name);
    SELF.filing_state := IF(l.filing_state = '',r.filing_state ,l.filing_state );
    SELF.orig_filing_number := IF(l.orig_filing_number = '',r.orig_filing_number ,l.orig_filing_number );
    SELF.orig_filing_type := IF(l.orig_filing_type = '',r.orig_filing_type ,l.orig_filing_type );
    SELF.orig_filing_date := IF(l.orig_filing_date = '',r.orig_filing_date ,l.orig_filing_date );
    SELF.filing_status := CHOOSEN((l.filing_status & r.filing_status)(filing_status <> '' OR filing_status_desc <> '' ),10);
    // We are changing the value for bcbflag deviating from the norm of not changing the vendor provided value for fcra services
    // In this case, it's fine since we are not returning the value back to the customer and also, it's happening inside a rollup
    SELF.bcbflag := IF(FCRA.lien_is_ok((STRING)STD.Date.Today(), SELF.orig_filing_date),
                                    IF(l.bcbflag, l.bcbflag, r.bcbflag), FALSE);
    SELF.case_number := IF(l.case_number = '',r.case_number ,l.case_number );
    SELF.release_date := IF(l.release_date = '',r.release_date ,l.release_date );
    SELF.amount := IF(l.amount = '',r.amount ,l.amount );
    SELF.eviction := IF(l.eviction = '',r.eviction ,l.eviction );
    SELF.judg_satisfied_date := IF(l.judg_satisfied_date = '',r.judg_satisfied_date,l.judg_satisfied_date);
    SELF.judg_vacated_date := IF(l.judg_vacated_date = '',r.judg_vacated_date ,l.judg_vacated_date );
    SELF.irs_serial_number := IF(l.irs_serial_number = '',r.irs_serial_number ,l.irs_serial_number );
    SELF.certificate_number := IF(l.certificate_number = '',r.certificate_number ,l.certificate_number );
    SELF.judge := IF(l.judge = '',r.judge ,l.judge );
    SELF.legal_lot := IF(l.legal_lot = '',r.legal_lot ,l.legal_lot );
    SELF.legal_block := IF(l.legal_block = '',r.legal_block ,l.legal_block );
    SELF.tax_code := IF(l.tax_code = '',r.tax_code ,l.tax_code );
    SELF.statementIds := l.statementIds + r.statementIds;
    SELF.IsDisputed := l.IsDisputed OR r.IsDisputed;
    SELF := [];
  END;
  
  // ROLLUP CASE INFORMATION
  ds_case_rolled := ROLLUP(ds_case_sort, LEFT.case_link_id = RIGHT.case_link_id, xf_case_rollup(LEFT,RIGHT));
  
  ds_case_filtered := ds_case_rolled(~IsFCRA OR (~FCRA.FCRAPurpose.isInsuranceCreditApplication(FCRAPurpose)) OR bcbflag); //IF FCRAPurpose is for isInsurance Applicatio RETURN only records with bcbflag SET to TRUE, else RETURN ALL.
  
  //===== ROLLUP HISTORY =====

  ds_history_sort := SORT(ds_history_raw_lnk, case_link_id, case_link_priority, RECORD);

  // TRANSFORM TO ROLL UP HISTORY INFO
  layout_liens_history_extended xf_hist_roll_1(ds_history_sort l, ds_history_sort r) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.acctno := l.acctno;
    SELF.case_link_id := l.case_link_id;
    SELF.case_link_priority := l.case_link_priority;
    // Choosen not good since we are doing a dedup later and should be restricting the number of records after that
    // And we need to know the oldest filing date and can't determine the value correctly if we only keep the first 15 records
    SELF.filings := CHOOSEN(l.filings & r.filings, 15);
  END;
  
  ds_hist_roll := ROLLUP(ds_history_sort, LEFT.case_link_id = RIGHT.case_link_id, xf_hist_roll_1(LEFT,RIGHT));

  layout_liens_history_extended xf_history_rollup(ds_hist_roll l) := TRANSFORM
    // FCRA - Insurance liens and judgments, check FCRAPurpose
    oldest_orig_filing_dt := MIN(l.filings, orig_filing_date);
    is_liens_ok := FCRA.lien_is_ok((STRING)STD.Date.Today(), oldest_orig_filing_dt);
    filings := IF(isFCRA AND FCRA.FCRAPurpose.isInsuranceCreditApplication(FCRAPurpose),
      IF(is_liens_ok, l.filings(bcbflag), DATASET([], LiensV2_Services.layout_lien_history_w_bcb)),
      l.filings);
    filings_d := DEDUP(SORT(filings,
      -filing_date,-orig_filing_date,-filing_number,filing_type_desc,-filing_book,-filing_page,RECORD),
      filing_date,orig_filing_date,filing_number,filing_type_desc)(filing_number <> '' OR filing_date <> '' OR filing_type_desc <> '');
      SELF.tmsid := l.tmsid;
    SELF.acctno := l.acctno;
    SELF.case_link_id := l.case_link_id;
    SELF.case_link_priority := l.case_link_priority;
    SELF.filings := SORT(filings_d, case_link_priority, -filing_date, -orig_filing_date);
  END;
  
  ds_history_rolled := PROJECT(ds_hist_roll,xf_history_rollup(LEFT));
  
  // ADD CRIM INDICATORS
  ds_recsIn := PROJECT(ds_party_raw,TRANSFORM({liensv2_services.layout_lien_party_raw,STRING12 UniqueId},SELF.UniqueId:=LEFT.did,SELF:=LEFT));
  CriminalRecords_Services.MAC_Indicators(ds_recsIn,ds_recsOut);
  ds_recs_party_raw := IF(includeCriminalIndicators,PROJECT(ds_recsOut,liensv2_services.layout_lien_party_raw),ds_party_raw);

  // PARTY COPY TRANSFORM
  ds_debtor_formatted := LiensV2_Services.fn_format_parties(ds_recs_party_raw(name_type = 'D'), in_ssn_mask_type, IsFCRA, return_multiple_pages);
  ds_creditor_formatted := LiensV2_Services.fn_format_parties(ds_recs_party_raw(name_type = 'C'), in_ssn_mask_type, IsFCRA, return_multiple_pages);
  ds_attorney_formatted := LiensV2_Services.fn_format_parties(ds_recs_party_raw(name_type = 'A'), in_ssn_mask_type, IsFCRA, return_multiple_pages);
  ds_thd_formatted := LiensV2_Services.fn_format_parties(ds_recs_party_raw(name_type = 'T'), in_ssn_mask_type, IsFCRA, return_multiple_pages);


  /* PICK the MATCHED PARTY*/

  layout_lien_rollup_with_page_no := RECORD
    liensv2_services.layout_lien_rollup;
    STRING case_link_id;
    INTEGER page_no;
  END;

  
  layout_parties_having_page_no := RECORD
    liensv2.layout_liens_party.tmsid;
    liensv2.layout_liens_party.rmsid;
    DATASET(liensv2_services.layout_lien_party) parties {MAXCOUNT(LiensV2.Constants.MAXCOUNT_PARTIES)};
    UNSIGNED2 penalt;
    INTEGER page_no;
  END;
  
  party_rec := RECORD
    STRING1 name_type;
    layout_parties_having_page_no;
  END;
  
  party_rec xfm_partyType(layout_parties_having_page_no l, STRING1 name_type) := TRANSFORM
    SELF.name_type := name_type;
    SELF := l;
  END;
  
  formatted_parties := DEDUP(SORT(PROJECT(ds_debtor_formatted,xfm_partyType(LEFT,'0'))
                                + PROJECT(ds_creditor_formatted,xfm_partyType(LEFT,'1'))
                                + PROJECT(ds_attorney_formatted,xfm_partyType(LEFT,'2'))
                                + PROJECT(ds_thd_formatted,xfm_partyType(LEFT,'3'))
                                 ,tmsid,penalt,name_type,RECORD),tmsid);

  // TRANSFORM TO PRIME THE RESULT DATASET
  
  layout_lien_rollup_with_page_no xf_project_case_info(ds_case_filtered l) := TRANSFORM

    bp := formatted_parties(tmsid = l.tmsid);

    SELF.tmsid := l.tmsid;
    SELF.case_link_id := l.case_link_id;
    SELF.matched_party.party_type := IF(DisplayMatchedParty_value,
                                        MAP(bp[1].name_type ='0' => 'D'
                                           ,bp[1].name_type ='1' => 'C'
                                           ,bp[1].name_type ='2' => 'A'
                                           ,bp[1].name_type ='3' => 'T'
                                           ,''),
                                        '');
                          
    SELF.matched_party.parsed_party := IF(DisplayMatchedParty_value
                                         ,PROJECT(bp.parties[1].parsed_parties,layout_lien_party_name)[1]);
    SELF.matched_party.address := IF(DisplayMatchedParty_value
                                    ,PROJECT(bp.parties[1].addresses,assorted_layouts.matched_party_address_rec)[1]);
    SELF := l;
    SELF := [];
  END;

  // PROJECT CASE INFO INTO ROLLUP LAYOUT
  ds_primed_rollup := PROJECT(ds_case_filtered, xf_project_case_info(LEFT));

  // Determine the number of pages (i.e. records) that the system must return. We need to determine this
  // beforehand, since we'll be joining all of the record sections based on tmsid and page_no.
  
  rec_max_pages_per_tmsid := RECORD
    layout_lien_rollup_with_page_no;
    INTEGER max_pages;
  END;

  rec_max_pages_per_tmsid xfm_determine_max_pages(ds_primed_rollup l) :=
    TRANSFORM
      SELF.tmsid := l.tmsid;
      SELF.case_link_id := l.case_link_id;
      SELF.max_pages := MAX( MAX(ds_debtor_formatted(tmsid = l.tmsid), page_no),
                             MAX(ds_creditor_formatted(tmsid = l.tmsid), page_no),
                             MAX(ds_attorney_formatted(tmsid = l.tmsid), page_no),
                             MAX(ds_thd_formatted(tmsid = l.tmsid), page_no)
                            );
      SELF := l;
    END;
    
  ds_tmsids_with_max_pages := PROJECT(ds_primed_rollup, xfm_determine_max_pages(LEFT));

  ds_party_recs_seed := NORMALIZE(ds_tmsids_with_max_pages,
                                 LEFT.max_pages,
                                 TRANSFORM(layout_lien_rollup_with_page_no,
                                           SELF.tmsid := LEFT.tmsid,
                                           SELF.case_link_id := LEFT.case_link_id,
                                           SELF.page_no := COUNTER,
                                           SELF := LEFT,
                                           SELF := [])
                                );

  // ***** Assemble the report by joining individual sections to the final ut.out layout. *****

  // TRANSFORM TO JOIN THE DEBTOR INFORMATION
  layout_lien_rollup_with_page_no xf_join_debtors(layout_lien_rollup_with_page_no l, ds_debtor_formatted r) := TRANSFORM
    SELF.tmsid := l.tmsid,
    SELF.page_no := l.page_no,
    SELF.multiple_debtor := COUNT(r.parties) > 1;
    SELF.debtors := r.parties(filter_id = '' OR EXISTS(parsed_parties(person_filter_id = filter_id)));
    liensv2_services.mac_pickPenalty()
    SELF := l;
  END;
  
  // TRANSFORM TO JOIN THE CREDITOR INFORMATION
  layout_lien_rollup_with_page_no xf_join_creditors(layout_lien_rollup_with_page_no l, ds_creditor_formatted r) := TRANSFORM
    SELF.tmsid := l.tmsid,
    SELF.page_no := l.page_no,
    SELF.creditors := r.parties;
    liensv2_services.mac_PickPenalty(l.penalt)
    SELF := l;
  END;
  
  // TRANSFORM TO JOIN THE ATTORNEY INFORMATION
  layout_lien_rollup_with_page_no xf_join_attorneys(layout_lien_rollup_with_page_no l, ds_attorney_formatted r) := TRANSFORM
    SELF.tmsid := l.tmsid,
    SELF.page_no := l.page_no,
    SELF.attorneys := r.parties;
    liensv2_services.mac_PickPenalty(l.penalt)
    SELF := l;
  END;
  
  // TRANSFORM TO JOIN THE THD INFORMATION
  layout_lien_rollup_with_page_no xf_join_thds(layout_lien_rollup_with_page_no l, ds_thd_formatted r) := TRANSFORM
    SELF.tmsid := l.tmsid,
    SELF.page_no := l.page_no,
    SELF.thds := r.parties;
    liensv2_services.mac_PickPenalty(l.penalt)
    SELF := l;
  END;
  
  // TRANSFORM TO JOIN THE HISTORY INFORMATION
  layout_lien_rollup_with_page_no xf_join_history(layout_lien_rollup_with_page_no l, ds_history_rolled r) := TRANSFORM
    SELF.tmsid := l.tmsid,
    SELF.page_no := l.page_no,
    SELF.filings := r.filings;
    SELF := l;
  END;
  
  // JOIN DEBTOR INFORMATION
  ds_primed_rollup_dxxxx := JOIN(ds_party_recs_seed /* ds_primed_rollup */, ds_debtor_formatted,
                                LEFT.tmsid = RIGHT.tmsid AND
                                LEFT.page_no = RIGHT.page_no,
                                xf_join_debtors(LEFT,RIGHT),
                                LEFT OUTER, KEEP(1000));
                                
  // JOIN CREDITOR INFORMATION
  ds_primed_rollup_dcxxx := JOIN(ds_primed_rollup_dxxxx, ds_creditor_formatted,
                                LEFT.tmsid = RIGHT.tmsid AND
                                LEFT.page_no = RIGHT.page_no,
                                xf_join_creditors(LEFT,RIGHT),
                                LEFT OUTER, KEEP(1000));
                                
  // JOIN ATTORNEY INFORMATION
  ds_primed_rollup_dcaxx := JOIN(ds_primed_rollup_dcxxx, ds_attorney_formatted,
                                LEFT.tmsid = RIGHT.tmsid AND
                                LEFT.page_no = RIGHT.page_no,
                                xf_join_attorneys(LEFT,RIGHT),
                                LEFT OUTER, KEEP(1000));
                                
  // JOIN THD INFORMATION
  ds_primed_rollup_dcatx := JOIN(ds_primed_rollup_dcaxx, ds_thd_formatted,
                                LEFT.tmsid = RIGHT.tmsid AND
                                LEFT.page_no = RIGHT.page_no,
                                xf_join_thds(LEFT,RIGHT),
                                LEFT OUTER, KEEP(1000));
                                
  // JOIN HISTORY INFORMATION ON CASE LINK ID (we're not paginating filing history)
  ds_primed_rollup_dcath := JOIN(ds_primed_rollup_dcatx, ds_history_rolled,
                                LEFT.case_link_id = RIGHT.case_link_id AND
                                LEFT.page_no = 1,
                                xf_join_history(LEFT,RIGHT),
                                LEFT OUTER, KEEP(1000));
  
  // Slim off page_no.
  ds_results := PROJECT(ds_primed_rollup_dcath,LiensV2_Services.layout_lien_rollup);
  
  //DEBUG
   // ut.out(case_in);
   // ut.out(history_in);
   // ut.out(ds_party_raw_pre);
   // ut.out(ds_case_raw_pre);
   // ut.out(ds_case_raw_pre_lnk);
   // ut.out(ds_case_raw);
   // ut.out(ds_history_raw);
   // ut.out(ds_history_raw_lnk);
   // ut.out(ds_hist_roll);
   // ut.out(ds_party_raw);
   // ut.out(ds_case_rolled);
   // ut.out(ds_case_filtered);
   // ut.out(ds_history_rolled);
   // ut.out(formatted_parties);
   // ut.out(ds_party_recs_seed);

  RETURN SORT(ds_results, -orig_filing_date, RECORD);

END;

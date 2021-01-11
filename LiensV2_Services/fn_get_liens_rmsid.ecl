// FUNCTION TO GET LIENS FROM A SET OF TMSID
IMPORT liensv2,CriminalRecords_Services;
EXPORT fn_get_liens_rmsid(
  GROUPED DATASET(liensv2_services.layout_rmsid) in_rmsids,
  STRING in_ssn_mask_type,
  STRING32 appType,
  BOOLEAN includeCriminalIndicators=FALSE
) := FUNCTION
  // RMSID INDEX INTO LIENS SEARCH FILE
  k_rmsid := liensv2.key_liens_main_id;
  k_rmsid_party := liensv2.key_liens_party_id;
  // TEMP CASE LAYOUT
  temp_case_layout := RECORD
    STRING8 filing_date;
    liensv2.Layout_liens_main_module.layout_liens_main.filing_number;
    STRING20 filing_type_desc;
    liensv2_services.layout_lien_case;
  END;
  // GET PARTY INFO FIRST FOR PULL IDS
  liensv2_services.layout_lien_party_raw xf_party_copy(k_rmsid_party r) := TRANSFORM
    SELF := r;
    SELF.hasCriminalConviction := FALSE;
    SELF.isSexualOffender := FALSE;
  END;
  ds_party_raw := JOIN(in_rmsids,k_rmsid_party,
                      KEYED(LEFT.tmsid = RIGHT.tmsid) AND
                      KEYED(LEFT.rmsid = RIGHT.rmsid),
                      xf_party_copy(RIGHT),
                      KEEP(10000));
  rmsids_cln := LiensV2_Services.fn_pullIDs(ds_party_raw,appType);

  // CASE INFO COPY TRANSFORM
  temp_case_layout xf_case_copy(k_rmsid r) := TRANSFORM
    SELF.filing_status := CHOOSEN(r.filing_status,10);
    SELF.filing_jurisdiction_name := LiensV2_Services.fn_get_filing_jurisdiction_name(r.filing_jurisdiction);
    SELF := r;
  END;
  // JOIN RMSID SET TO INDEX TO GET DATA
  ds_case_raw := JOIN(rmsids_cln,k_rmsid,
                      KEYED(LEFT.tmsid = RIGHT.tmsid) AND
                      KEYED(LEFT.rmsid = RIGHT.rmsid),
                      xf_case_copy(RIGHT),
                      KEEP(10000));
  // SORT CASE DATA BY RMSID AND MOST RECENT FILING DATE
  ds_case_sort := SORT(ds_case_raw,tmsid,rmsid,-filing_date,-filing_number,filing_type_desc,RECORD);
  // TRANSFORM TO ROLL UP CASE INFO
  ds_case_sort xf_case_rollup(ds_case_sort l, ds_case_sort r) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.rmsid := l.rmsid;
    SELF.filing_jurisdiction := IF(l.filing_jurisdiction = '',r.filing_jurisdiction,l.filing_jurisdiction);
    SELF.filing_jurisdiction_name := IF(l.filing_jurisdiction_name = '',r.filing_jurisdiction_name,l.filing_jurisdiction_name);
    SELF.filing_state := IF(l.filing_state = '',r.filing_state ,l.filing_state );
    SELF.orig_filing_number := IF(l.orig_filing_number = '',r.orig_filing_number ,l.orig_filing_number );
    SELF.orig_filing_type := IF(l.orig_filing_type = '',r.orig_filing_type ,l.orig_filing_type );
    SELF.orig_filing_date := IF(l.orig_filing_date = '',r.orig_filing_date ,l.orig_filing_date );
    SELF.filing_status := CHOOSEN(DEDUP(SORT((l.filing_status + r.filing_status)(filing_status <> '' OR filing_status_desc <> '' ),RECORD),RECORD),10);
    SELF.case_number := IF(l.case_number = '',r.case_number ,l.case_number );
    SELF.certificate_number := IF(l.certificate_number = '',r.certificate_number ,l.certificate_number );
    SELF.release_date := IF(l.release_date = '',r.release_date ,l.release_date );
    SELF.amount := IF(l.amount = '',r.amount ,l.amount );
    SELF.eviction := IF(l.eviction = '',r.eviction ,l.eviction );
    SELF.judg_satisfied_date := IF(l.judg_satisfied_date = '',r.judg_satisfied_date,l.judg_satisfied_date);
    SELF.judg_vacated_date := IF(l.judg_vacated_date = '',r.judg_vacated_date ,l.judg_vacated_date );
    SELF.judge := IF(l.judge = '',r.judge ,l.judge );
    SELF.tax_code := IF(l.tax_code = '',r.tax_code ,l.tax_code );
    SELF := [];
  END;
  // ROLLUP CASE INFORMATION
  ds_case_rolled := ROLLUP(ds_case_sort,LEFT.tmsid = RIGHT.tmsid AND LEFT.rmsid = RIGHT.rmsid,xf_case_rollup(LEFT,RIGHT));
  // FILING INFO COPY TRANSFORM
  temp_hist_layout := RECORD
    STRING50 tmsid;
    STRING50 rmsid;
    DATASET(liensv2_services.layout_lien_history) filings{MAXCOUNT(15)};
  END;
  temp_hist_layout xf_history_copy(k_rmsid r) := TRANSFORM
    SELF.filings := DATASET([{r.filing_number,r.filing_type_desc,r.orig_filing_date,r.filing_date,r.filing_time,r.filing_book,r.filing_page,r.agency,r.agency_state,r.agency_city,r.agency_county}],liensv2_services.layout_lien_history);
    SELF.tmsid := r.tmsid;
    SELF.rmsid := r.rmsid;
  END;
  // JOIN RMSID SET TO INDEX TO GET DATA
  ds_history_raw := 
    JOIN(rmsids_cln,k_rmsid,
      KEYED(LEFT.tmsid = RIGHT.tmsid) AND
      KEYED(LEFT.rmsid = RIGHT.rmsid),
      xf_history_copy(RIGHT),
      KEEP(10000));
  // SORT HISTORY DATA BY RMSID AND MOST RECENT FILING DATE
  ds_history_sort := SORT(ds_history_raw,tmsid,rmsid,RECORD);
  // TRANSFORM TO ROLL UP HISTORY INFO
  ds_history_sort xf_hist_roll_1(ds_history_sort l, ds_history_sort r) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.rmsid := l.rmsid;
    SELF.filings := CHOOSEN(l.filings & r.filings,15);
  END;
  ds_hist_roll := ROLLUP(ds_history_sort,LEFT.tmsid = RIGHT.tmsid AND LEFT.rmsid = RIGHT.rmsid,xf_hist_roll_1(LEFT,RIGHT));
  ds_hist_roll xf_history_rollup(ds_hist_roll l) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.rmsid := l.rmsid;
    SELF.filings := DEDUP(SORT(l.filings,-filing_date,-orig_filing_date,-filing_number,filing_type_desc,-filing_book,-filing_page,RECORD),filing_date,filing_number,filing_type_desc)(filing_number <> '' OR filing_date <> '' OR filing_type_desc <> '');
  END;
  // ROLLUP HISTORY INFORMATION
  ds_history_rolled := PROJECT(ds_hist_roll,xf_history_rollup(LEFT));
  // ADD CRIM INDICATORS
  ds_recsIn := PROJECT(ds_party_raw,TRANSFORM({liensv2_services.layout_lien_party_raw,STRING12 UniqueId},SELF.UniqueId:=LEFT.did,SELF:=LEFT));
  CriminalRecords_Services.MAC_Indicators(ds_recsIn,ds_recsOut);
  ds_recs_party_raw := IF(includeCriminalIndicators,PROJECT(ds_recsOut,liensv2_services.layout_lien_party_raw),ds_party_raw);
  // PARTY COPY TRANSFORM
  ds_debtor_formatted := fn_format_parties(ds_recs_party_raw(name_type = 'D'),in_ssn_mask_type);
  ds_creditor_formatted := fn_format_parties(ds_recs_party_raw(name_type = 'C'),in_ssn_mask_type);
  ds_attorney_formatted := fn_format_parties(ds_recs_party_raw(name_type = 'A'),in_ssn_mask_type);
  ds_thd_formatted := fn_format_parties(ds_recs_party_raw(name_type = 'T'),in_ssn_mask_type);
  // TRANSFORM TO PRIME THE RESULT DATASET
  liensv2_services.layout_lien_rollup xf_project_case_info(ds_case_rolled l) := TRANSFORM
    SELF.tmsid := l.tmsid;
    SELF.rmsid := l.rmsid;
    SELF := l;
    SELF := [];
  END;
  // PROJECT CASE INFO INTO ROLLUP LAYOUT
  ds_primed_rollup := PROJECT(ds_case_rolled,xf_project_case_info(LEFT));
  // TRANSFORM TO JOIN THE DEBTOR INFORMATION
  ds_primed_rollup xf_join_debtors(ds_primed_rollup l, ds_debtor_formatted r) := TRANSFORM
    SELF.debtors := CHOOSEN(r.parties,25);
    liensv2_services.mac_PickPenalty()
    SELF.multiple_debtor := COUNT(r.parties) > 1;
    SELF := l;
  END;
  // TRANSFORM TO JOIN THE CREDITOR INFORMATION
  ds_primed_rollup xf_join_creditors(ds_primed_rollup l, ds_creditor_formatted r) := TRANSFORM
    SELF.creditors := CHOOSEN(r.parties,10);
    liensv2_services.mac_PickPenalty(l.penalt)
    SELF := l;
  END;
  // TRANSFORM TO JOIN THE ATTORNEY INFORMATION
  ds_primed_rollup xf_join_attorneys(ds_primed_rollup l, ds_attorney_formatted r) := TRANSFORM
    SELF.attorneys := CHOOSEN(r.parties,10);
    liensv2_services.mac_PickPenalty(l.penalt)
    SELF := l;
  END;
  // TRANSFORM TO JOIN THE THD INFORMATION
  ds_primed_rollup xf_join_thds(ds_primed_rollup l, ds_thd_formatted r) := TRANSFORM
    SELF.thds := CHOOSEN(r.parties,10);
    liensv2_services.mac_PickPenalty(l.penalt)
    SELF := l;
  END;
  // TRANSFORM TO JOIN THE HISTORY INFORMATION
  ds_primed_rollup xf_join_history(ds_primed_rollup l, ds_history_rolled r) := TRANSFORM
    SELF.filings := CHOOSEN(r.filings,15);
    SELF := l;
  END;
  // JOIN DEBTOR INFORMATION
  ds_primed_rollup_dxxxx := 
    JOIN(ds_primed_rollup,ds_debtor_formatted,
      LEFT.tmsid = RIGHT.tmsid AND
      LEFT.rmsid = RIGHT.rmsid,
      xf_join_debtors(LEFT,RIGHT),
      LEFT OUTER);
  // JOIN CREDITOR INFORMATION
  ds_primed_rollup_dcxxx := 
    JOIN(ds_primed_rollup_dxxxx,ds_creditor_formatted,
      LEFT.tmsid = RIGHT.tmsid AND
      LEFT.rmsid = RIGHT.rmsid,
      xf_join_creditors(LEFT,RIGHT),
      LEFT OUTER);
  // JOIN ATTORNEY INFORMATION
  ds_primed_rollup_dcaxx := 
    JOIN(ds_primed_rollup_dcxxx,ds_attorney_formatted,
      LEFT.tmsid = RIGHT.tmsid AND
      LEFT.rmsid = RIGHT.rmsid,
      xf_join_attorneys(LEFT,RIGHT),
      LEFT OUTER);
  // JOIN THD INFORMATION
  ds_primed_rollup_dcatx := 
    JOIN(ds_primed_rollup_dcaxx,ds_thd_formatted,
      LEFT.tmsid = RIGHT.tmsid AND
      LEFT.rmsid = RIGHT.rmsid,
      xf_join_thds(LEFT,RIGHT),
      LEFT OUTER);
  // JOIN HISTORY INFORMATION
  ds_primed_rollup_dcath := 
    JOIN(ds_primed_rollup_dcatx,ds_history_rolled,
      LEFT.tmsid = RIGHT.tmsid AND
      LEFT.rmsid = RIGHT.rmsid,
      xf_join_history(LEFT,RIGHT),
      LEFT OUTER);
  // RETURN THE ROLLED UP DATA
  RETURN SORT(ds_primed_rollup_dcath,-orig_filing_date,RECORD);
END;

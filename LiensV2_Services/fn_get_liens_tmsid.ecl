// FUNCTION TO GET LIENS FROM A SET OF TMSID

//IMPORTANT FCRA-NOTE:
// Corresponding FCRA-compliant/neutral data are used here,
// fcra-corrections, if required by a service, should be applied to the output result by a caller

IMPORT liensv2, FFD, FCRA;
EXPORT fn_get_liens_tmsid(
  GROUPED DATASET(liensv2_services.layout_tmsid) in_tmsids, //GROUPED by 'accto'
  STRING in_ssn_mask_type,
  BOOLEAN IsFCRA = FALSE,
  STRING in_filing_jurisdiction = '',
  STRING person_filter_id = '',
  BOOLEAN return_multiple_pages = FALSE,
  STRING32 appType,
  BOOLEAN includeCriminalIndicators = FALSE,
  DATASET(FFD.Layouts.PersonContextBatchSlim) ds_slim_pc = FFD.Constants.BlankPersonContextBatchSlim,
  INTEGER8 inFFDOptionsMask = 0,
  INTEGER FCRAPurpose = FCRA.FCRAPurpose.NoValueProvided,
  BOOLEAN rollup_by_case_link = FALSE
) := FUNCTION

  // GET PARTY INFO FIRST FOR PULL IDS
  MAC_GetPartyInfo (trans_name, key_attr, out_file) := MACRO
  liensv2_services.layout_lien_party_raw trans_name (in_tmsids l, key_attr r) := TRANSFORM
    SELF.acctno := l.acctno;
    SELF.hasCriminalConviction := FALSE;
    SELF.isSexualOffender := FALSE;
    SELF := r;
  END;
  out_file := JOIN (in_tmsids, key_attr,
                    KEYED(LEFT.tmsid = RIGHT.tmsid),
                    trans_name (LEFT,RIGHT),
                    LIMIT(10000));
  ENDMACRO;
  MAC_GetPartyInfo (xf_party_copy, liensv2.key_liens_party_id, ds_party);
  MAC_GetPartyInfo (xf_party_copy_fcra, liensv2.key_liens_party_id_fcra, ds_party_fcra);
  ds_party_raw_pre := IF (IsFCRA, ds_party_fcra, ds_party);

  // cannot use pullSSN in fcra-side: overrides should be used for the same purpose
  ds_pulled := PROJECT(liensv2_services.fn_pullIDs(ds_party_raw_pre,appType), liensv2_services.layout_tmsid);
  tmsids_cln := DEDUP(SORT(IF (IsFCRA, UNGROUP (PROJECT(ds_party_raw_pre, liensv2_services.layout_tmsid)), ds_pulled),tmsid),tmsid);

  // Get the relevant key_liens_main_id(_fcra) info. We may wish to do case linking
  // and reduction prior to extracting case and history data
  fn_get_main_recs(main_key_in) := FUNCTIONMACRO
    local layout := { RECORDOF(liensv2.key_liens_main_id_fcra), STRING30 acctno };
    RETURN JOIN(tmsids_cln, main_key_in, KEYED(LEFT.tmsid = RIGHT.tmsid),
      TRANSFORM(layout, SELF.acctno := LEFT.acctno, SELF := RIGHT), LIMIT(10000));
  ENDMACRO;

  local_liens_main_recs := IF(IsFCRA, fn_get_main_recs(liensv2.key_liens_main_id_fcra),
    fn_get_main_recs(liensv2.key_liens_main_id));

  // Call fn_link_liens_cases to add case_link_id to the records
  local_linked_main_recs := LiensV2_Services.fn_link_liens_cases(local_liens_main_recs, TRUE, acctno);

  // incorporate case linking id and priority values in a common format
  local_liens_format := RECORD
    RECORDOF(local_liens_main_recs);
    STRING case_link_id := '';
    UNSIGNED case_link_priority := 0;
  END;
  local_proj_recs := PROJECT(local_linked_main_recs, TRANSFORM(local_liens_format,
    SELF.case_link_id := (STRING)LEFT.case_link_id,
    SELF := LEFT));

  // if we aren't doing case linking, we want blank case_link fields
  final_main_recs := IF(rollup_by_case_link, local_proj_recs,
    PROJECT(local_liens_main_recs, local_liens_format));

  // Get case data from our recs
  layout_liens_case_extended xf_case_copy(final_main_recs l) := TRANSFORM
    SELF.acctno := l.acctno;
    SELF.filing_status := CHOOSEN(l.filing_status,10);
    SELF.filing_jurisdiction_name := LiensV2_Services.fn_get_filing_jurisdiction_name(l.filing_jurisdiction);
    SELF := l;
  END;
  ds_case_raw := PROJECT(final_main_recs, xf_case_copy(LEFT));

  // filter by jurisdiction if provided
  // TODO: Jurisdiction filter may need to be applied to history records as well
  // (or to final_main_recs before case and history records are gathered)
  ds_case_filt := IF(in_filing_jurisdiction <> '',
    ds_case_raw(in_filing_jurisdiction IN [filing_jurisdiction,filing_state,agency_state]),
    ds_case_raw);

  // FILING INFO COPY TRANSFORM
  layout_liens_history_extended xf_history_copy(final_main_recs l) := TRANSFORM
    SELF.acctno := l.acctno;
    SELF.tmsid := l.tmsid;
    SELF.case_link_id := l.case_link_id;
    SELF.case_link_priority := l.case_link_priority;
    SELF.filings := DATASET([{l.filing_number, l.filing_type_desc, l.orig_filing_date, l.filing_date, l.filing_time, l.filing_book, l.filing_page,
      l.agency, l.agency_state, l.agency_city, l.agency_county, l.persistent_record_id,
      DATASET([], FFD.Layouts.StatementIdRec), FALSE, l.bcbflag, l.case_link_priority}],
      RECORDOF(layout_liens_history_extended.filings));
  END;
  ds_history_raw := PROJECT(final_main_recs, xf_history_copy(LEFT));
  
  RETURN LiensV2_Services.GetCRSOutput (ds_party_raw_pre, ds_case_filt, ds_history_raw, in_ssn_mask_type,
    IsFCRA, person_filter_id, return_multiple_pages,
    includeCriminalIndicators, ds_slim_pc, inFFDOptionsMask, FCRAPurpose);

END;

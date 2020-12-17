IMPORT BIPV2, doxie, doxie_cbrs, liensv2, suppress, ut, FFD, FCRA, STD;
// This module will provide liens data in different formats.

//IMPORTANT FCRA-NOTE:
// Corresponding FCRA-compliant/neutral data are used here,
// fcra-corrections, if required by a service, should be applied to the output result by a caller
EXPORT liens_raw := MODULE

  SHARED with_did := {liensv2_services.layout_rmsid OR doxie.layout_references};
  SHARED with_bdid := {liensv2_services.layout_rmsid OR doxie_cbrs.layout_references};

  // Gets RMSIDs from TMSIDs
  SHARED get_rmsids_from_tmsids(DATASET(liensv2_services.layout_tmsid) in_tmsids, BOOLEAN isFCRA=FALSE) := FUNCTION
    key := IF(isFCRA, LiensV2.key_liens_main_ID_FCRA, liensv2.key_liens_main_ID);
    res := JOIN(DEDUP(SORT(in_tmsids,tmsid),tmsid),key,
      KEYED(LEFT.tmsid = RIGHT.tmsid),
      TRANSFORM(liensv2_services.layout_rmsid,SELF := RIGHT),
      LIMIT(10000));
    RETURN DEDUP(SORT(res,tmsid,rmsid),tmsid,rmsid);
  END;

  // Gets RMSIDs from DIDs
  EXPORT get_rmsids_from_dids (DATASET(doxie.layout_references) in_dids,
                               BOOLEAN isMoxie = FALSE,
                               BOOLEAN IsFCRA = FALSE,
                               STRING1 in_party_type = '') := FUNCTION

    MAC_GetLiens (key_attr,key_attr2, out_file) := MACRO
      #uniquename (res1);
      %res1% := JOIN(DEDUP(SORT(in_dids,did),did), key_attr,
        KEYED(LEFT.did = RIGHT.did),
        TRANSFORM(with_did,SELF := LEFT,SELF := RIGHT),
        LIMIT(10000));

      #uniquename (party_checked);
      %party_checked% := JOIN(%res1%, key_attr2,
        KEYED(LEFT.tmsid = RIGHT.tmsid AND LEFT.rmsid = RIGHT.rmsid) AND
        LEFT.did = (UNSIGNED)RIGHT.did AND
        RIGHT.name_type[1] = STD.Str.ToUpperCase(in_party_type)[1],
        TRANSFORM(liensv2_services.layout_rmsid,SELF := RIGHT),
        LIMIT(10000));

      #uniquename (res_slim1);
      ut.MAC_Slim_Back(%res1%,liensv2_services.layout_rmsid,%res_slim1%);
      #uniquename (use_res);
      %use_res% := IF(in_party_type = '', %res_slim1%, %party_checked%);

      #uniquename (res2);
      // NB: when we hit the limit for DID, we SKIP all records,
      // because I assert that there should be no person with that many liens
      // Compare to bdid below
      %res2% := JOIN(DEDUP(SORT(in_dids,did),did),key_attr,
        KEYED(LEFT.did = RIGHT.did) AND
        (In_Party_Type = '' OR EXISTS(key_attr2((UNSIGNED)did = LEFT.did AND tmsid = RIGHT.tmsid AND rmsid=RIGHT.rmsid AND name_type[1] = STD.Str.ToUpperCase(In_Party_Type)[1]))),
        TRANSFORM(liensv2_services.layout_rmsid,SELF := RIGHT),
        LIMIT(200,SKIP));
      out_file := IF(isMoxie,%res2%,%use_res%);
    ENDMACRO;

    MAC_GetLiens (liensv2.key_liens_did,Liensv2.key_liens_party_id, res_reg);
    MAC_GetLiens (liensv2.key_liens_did_fcra,Liensv2.key_liens_party_id_FCRA, res_fcra);
    res := IF (IsFCRA, res_fcra, res_reg);

    RETURN DEDUP(SORT(res,tmsid,rmsid),tmsid,rmsid);
  END;

  // Gets RMSIDs from BDIDs
  EXPORT get_rmsids_from_bdids(DATASET(doxie_cbrs.layout_references) in_bdids,
                               UNSIGNED in_limit = 0,
                               BOOLEAN isMoxie = FALSE,
                               STRING1 in_party_type = '',
                               BOOLEAN isFCRA = FALSE) := FUNCTION

    key := IF(isFCRA, liensv2.Key_FCRA_Liens_BDID, liensv2.key_liens_bdid);

    res1 := JOIN(DEDUP(SORT(in_bdids,bdid),bdid),key,
      KEYED(LEFT.bdid = RIGHT.p_bdid),
      TRANSFORM(with_bdid,SELF := LEFT,SELF := RIGHT),
      KEEP(10000));

    party_checked1 := JOIN(res1, liensv2.key_liens_party_ID,
      KEYED(LEFT.tmsid = RIGHT.tmsid AND LEFT.rmsid = RIGHT.rmsid) AND
      LEFT.bdid = (UNSIGNED)RIGHT.bdid AND
      RIGHT.name_type[1] = STD.Str.ToUpperCase(in_party_type)[1],
      TRANSFORM(liensv2_services.layout_rmsid,SELF := RIGHT),
      KEEP(10000));

    ut.MAC_Slim_Back(res1,liensv2_services.layout_rmsid,res_slim1);
    use_res1 := IF(in_party_type = '', res_slim1, party_checked1);

    res2 := JOIN(DEDUP(SORT(in_bdids,bdid),bdid),key,
      KEYED(LEFT.bdid = RIGHT.p_bdid),
      TRANSFORM(with_bdid,SELF := LEFT,SELF := RIGHT),
      KEEP(500));

    party_checked2 := JOIN(res2, liensv2.key_liens_party_ID,
      KEYED(LEFT.tmsid = RIGHT.tmsid AND LEFT.rmsid = RIGHT.rmsid) AND
      LEFT.bdid = (UNSIGNED)RIGHT.bdid AND
      RIGHT.name_type[1] = STD.Str.ToUpperCase(in_party_type)[1],
      TRANSFORM(liensv2_services.layout_rmsid,SELF := RIGHT),
      KEEP(500));

    ut.MAC_Slim_Back(res2,liensv2_services.layout_rmsid,res_slim2);
    use_res2 := IF(in_party_type = '', res_slim2, party_checked2);

    use_res := IF(isMoxie,use_res2,use_res1);

    ded := DEDUP(SORT(use_res,tmsid,rmsid),tmsid,rmsid);

    RETURN IF(in_limit = 0,ded,CHOOSEN(ded,in_limit));
  END;

  // Get RMSIDs from 7 business ids
  EXPORT get_tmsids_from_bids(DATASET(BIPV2.IDlayouts.l_xlink_ids) in_bids,
                              STRING1 bid_fetch_level,
                              STRING1 in_party_type = '') := FUNCTION
    res1 := LiensV2.Key_LinkIds.KeyFetch(in_bids,bid_fetch_level);

    party_checked1 := JOIN(res1, liensv2.key_liens_party_ID,
      KEYED(LEFT.tmsid = RIGHT.tmsid AND LEFT.rmsid = RIGHT.rmsid) AND
      LEFT.ultid = RIGHT.ultid AND
      LEFT.orgid = RIGHT.orgid AND
      LEFT.seleid = RIGHT.seleid AND
      LEFT.proxid = RIGHT.proxid AND
      RIGHT.name_type[1] = STD.Str.ToUpperCase(in_party_type)[1],
      TRANSFORM(liensv2_services.layout_rmsid,SELF := RIGHT),
      KEEP(10000));

    ut.MAC_Slim_Back(res1,liensv2_services.layout_rmsid,res_slim1);

    use_res1 := IF(in_party_type = '', res_slim1, party_checked1);

    RETURN DEDUP(SORT(use_res1,tmsid,rmsid),tmsid,rmsid);
  END;

  // Gets RMSIDs from Casenumber ST
  EXPORT get_rmsids_from_casenumber_st(DATASET(LiensV2_Services.layout_casenumber_st) in_casenumber_st, BOOLEAN isFCRA=FALSE) := FUNCTION
    key := IF(isFCRA, liensv2.Key_FCRA_Liens_case_number, liensv2.key_liens_case_number);
    res := JOIN(DEDUP(SORT(in_casenumber_st,case_number,filing_state),case_number,filing_state),key,
      KEYED(TRIM(LEFT.case_number) = RIGHT.case_number) AND
      KEYED(LEFT.filing_state = '' OR TRIM(LEFT.filing_state) = RIGHT.filing_state),
      TRANSFORM(liensv2_services.layout_rmsid,SELF := RIGHT),
      KEEP(1000));
    RETURN DEDUP(SORT(res,tmsid,rmsid),tmsid,rmsid);
  END;

  // Gets RMSIDs from Filing Number
  EXPORT get_rmsids_from_Filing_Number(DATASET(liensv2_services.layout_filing_number) in_filing_number, BOOLEAN isFCRA=FALSE) := FUNCTION
    key := IF(isFCRA, LiensV2.Key_FCRA_Liens_Filing, LiensV2.key_liens_filing);
    res := JOIN(DEDUP(SORT(in_filing_number,filing_number,filing_state),filing_number,filing_state),key,
      KEYED(LEFT.filing_number = RIGHT.filing_number) AND
      KEYED(LEFT.filing_state = '' OR TRIM(LEFT.filing_state) = RIGHT.filing_state),
      TRANSFORM(liensv2_services.layout_rmsid,SELF := RIGHT),
      KEEP(1000));
    RETURN DEDUP(SORT(res,tmsid,rmsid),tmsid,rmsid);
  END;

  // Gets RMSIDs from IRS Serial Number
  EXPORT get_rmsids_from_IRS_Serial_Number(DATASET(liensv2_services.layout_irs_serial_number) in_serial_number, BOOLEAN isFCRA=FALSE) := FUNCTION
    key := IF(isFCRA, LiensV2.Key_FCRA_Liens_Irs_serial_number, LiensV2.key_liens_irs_serial_number);
    res := JOIN(DEDUP(SORT(in_serial_number,irs_serial_number),irs_serial_number),key,
      KEYED(LEFT.irs_serial_number = RIGHT.irs_serial_number),
      TRANSFORM(liensv2_services.layout_rmsid,SELF := RIGHT),
      KEEP(1000));
    RETURN DEDUP(SORT(res,tmsid,rmsid),tmsid,rmsid);
  END;

  // Gets RMSIDs from Certificate Number
  EXPORT get_rmsids_from_CertificateNumber(DATASET(liensv2_services.layout_CertificateNumber) in_CertificateNumber, BOOLEAN isFCRA=FALSE) := FUNCTION
    key := IF(isFCRA, LiensV2.Key_FCRA_Liens_Certificate_Number, LiensV2.key_liens_certificate_number);
    res := JOIN(DEDUP(SORT(in_CertificateNumber,certificate_number),certificate_number),key,
      KEYED(LEFT.certificate_number = RIGHT.certificate_number),
      TRANSFORM(liensv2_services.layout_rmsid,SELF := RIGHT),
      KEEP(1000));
    RETURN DEDUP(SORT(res,tmsid,rmsid),tmsid,rmsid);
  END;

  // Batch - Gets TMSIDs from DIDs
  // Note: TMSID suppressions not done here. They are being done in the report section
  // and is the responsibility of the caller to suppress them if not using the standard functions
  EXPORT get_tmsids_from_dids_batch(GROUPED DATASET(doxie.layout_references_acctno) in_dids,
                                    BOOLEAN IsFCRA = FALSE,
                                    STRING1 in_party_type = '') := FUNCTION
    res_reg := JOIN(DEDUP(SORT(in_dids,did),did),liensv2.key_liens_did,
      KEYED(LEFT.did = RIGHT.did),
      TRANSFORM(with_did,SELF := LEFT,SELF := RIGHT),
      KEEP(1000)); // actual number might be higher than that...

    res_reg_checked := JOIN(res_reg, liensv2.key_liens_party_ID,
      KEYED(LEFT.tmsid = RIGHT.tmsid) AND
      LEFT.did = (UNSIGNED)RIGHT.did AND
      RIGHT.name_type[1] = STD.Str.ToUpperCase(in_party_type)[1],
      TRANSFORM(liensv2_services.layout_tmsid,SELF.acctno := LEFT.acctno, SELF := RIGHT),
      KEEP(1000));

    ut.MAC_Slim_Back(res_reg,liensv2_services.layout_tmsid,res_reg_slim);
    use_res_reg := IF(in_party_type = '', res_reg_slim, res_reg_checked);

    res_fcra := JOIN(DEDUP(SORT(in_dids,did),did),liensv2.key_liens_did_fcra,
      KEYED(LEFT.did = RIGHT.did),
      TRANSFORM(with_did,SELF.acctno := LEFT.acctno,SELF := RIGHT),
      KEEP(1000)); // actual number might be higher than that...

    res_fcra_checked := JOIN(res_fcra, liensv2.key_liens_party_id_FCRA,
      KEYED(LEFT.tmsid = RIGHT.tmsid) AND
      LEFT.did = (UNSIGNED)RIGHT.did AND
      RIGHT.name_type[1] = STD.Str.ToUpperCase(in_party_type)[1],
      TRANSFORM(liensv2_services.layout_tmsid,SELF.acctno := LEFT.acctno,SELF := RIGHT),
      KEEP(1000));

    ut.MAC_Slim_Back(res_fcra,liensv2_services.layout_tmsid,res_fcra_slim);
    use_res_fcra := IF(in_party_type = '', res_fcra_slim, res_fcra_checked);

    res := IF (IsFCRA, use_res_fcra, use_res_reg);

    RETURN DEDUP(SORT(res,tmsid),tmsid);
  END;

  // Gets TMSIDs from DIDs
  // Note: TMSID suppressions not done here. They are being done in the report section
  // and is the responsibility of the caller to suppress them if not using the standard functions
  EXPORT get_tmsids_from_dids(DATASET(doxie.layout_references) in_dids,STRING1 in_party_type = '', BOOLEAN IsFCRA = FALSE) := FUNCTION

    RETURN UNGROUP(get_tmsids_from_dids_batch(GROUP(sorted(PROJECT(in_dids, doxie.layout_references_acctno), acctno), acctno),IsFCRA,in_party_type));
  END;

  // Note: TMSID suppressions not done here. They are being done in the report section
  // and is the responsibility of the caller to suppress them if not using the standard functions
  EXPORT get_tmsids_from_bdids_batch(DATASET(doxie_cbrs.layout_references_acctno) in_bdids,
                                     UNSIGNED in_limit = 0
                                     ) := FUNCTION
    res := JOIN(DEDUP(SORT(in_bdids, acctno, bdid), acctno, bdid), liensv2.key_liens_bdid,
      KEYED(LEFT.bdid = RIGHT.p_bdid),
      TRANSFORM(liensv2_services.layout_tmsid, SELF := RIGHT, SELF := LEFT),
      KEEP(1000));
    ded := DEDUP(SORT(res, acctno, tmsid), acctno, tmsid);

    RETURN IF( in_limit = 0, ded, CHOOSEN(ded,in_limit) );
  END;

  // Gets TMSIDs from BDIDs
  // Note: TMSID suppressions not done here. They are being done in the report section
  // and is the responsibility of the caller to suppress them if not using the standard functions
  EXPORT get_tmsids_from_bdids(DATASET(doxie_cbrs.layout_references) in_bdids,
                               UNSIGNED in_limit = 0,
                               STRING1 in_party_type = '',
                               BOOLEAN isFCRA=FALSE) := FUNCTION
    key := IF(isFCRA, liensv2.Key_FCRA_Liens_BDID, liensv2.key_liens_bdid);

    res := JOIN(DEDUP(SORT(in_bdids,bdid),bdid),key,
      KEYED(LEFT.bdid = RIGHT.p_bdid),
      TRANSFORM(with_bdid,SELF := LEFT,SELF := RIGHT),
      KEEP(1000));

    party_checked := JOIN(res, liensv2.key_liens_party_ID,
      KEYED(LEFT.tmsid = RIGHT.tmsid) AND
      LEFT.bdid = (UNSIGNED)RIGHT.bdid AND
      RIGHT.name_type[1] = STD.Str.ToUpperCase(in_party_type)[1],
      TRANSFORM(liensv2_services.layout_tmsid,SELF := RIGHT),
      KEEP(1000));

    ut.MAC_Slim_Back(res,liensv2_services.layout_tmsid,res_slim);
    use_res := IF(in_party_type = '', res_slim, party_checked);

    ded := DEDUP(SORT(use_res,tmsid),tmsid);
    RETURN IF(in_limit = 0,ded,CHOOSEN(ded,in_limit));
  END;

  // Gets TMSIDs from RMSIDs
  // Note: TMSID suppressions not done here. They are being done in the report section
  // and is the responsibility of the caller to suppress them if not using the standard functions
  EXPORT get_tmsids_from_rmsids(DATASET(liensv2_services.layout_rmsid) in_rmsids,
                                BOOLEAN isFCRA=FALSE
                                ) := FUNCTION
    key := IF(isFCRA, LiensV2.key_liens_RMSID_FCRA, liensv2.key_liens_rmsid);
    res := JOIN(DEDUP(SORT(in_rmsids,rmsid),rmsid),key,
      KEYED(LEFT.rmsid = RIGHT.rmsid),
      TRANSFORM(liensv2_services.layout_rmsid,SELF := RIGHT),
      KEEP(1000));

    RETURN DEDUP(SORT(res,tmsid,rmsid),tmsid,rmsid);
  END;

  // Gets TMSIDs from Casenumber ST
  // Note: TMSID suppressions not done here. They are being done in the report section
  // and is the responsibility of the caller to suppress them if not using the standard functions
  EXPORT get_tmsids_from_casenumber_st( DATASET(LiensV2_Services.layout_casenumber_st) in_casenumber_st) := FUNCTION
    key := liensv2.key_liens_case_number;
    res := JOIN(DEDUP(SORT(in_casenumber_st,case_number,filing_state),case_number,filing_state),key,
      KEYED(TRIM(LEFT.case_number) = RIGHT.case_number) AND
      KEYED(LEFT.filing_state = '' OR TRIM(LEFT.filing_state) = RIGHT.filing_state),
      TRANSFORM(liensv2_services.layout_tmsid,SELF := RIGHT),
      KEEP(1000));

    RETURN DEDUP(SORT(res,tmsid),tmsid);
  END;


  // ======================================================================
  // Returns the liens data in the report summary view (grouped and rolled up by TMSID)
  // ======================================================================
  EXPORT report_view := MODULE

    // Batch - Returns the liens data in the report summary view using TMSIDs as a lookup mechanism.
    EXPORT by_tmsid_batch(GROUPED DATASET(liensv2_services.layout_tmsid) in_tmsids,
      STRING in_ssn_mask_type = '',
      BOOLEAN IsFCRA = FALSE,
      STRING in_filing_jurisdiction = '',
      STRING person_filter_id = '',
      BOOLEAN return_multiple_pages = FALSE,
      STRING32 appType,
      BOOLEAN includeCriminalIndicators=FALSE,
      DATASET(FFD.Layouts.PersonContextBatchSlim) ds_slim_pc = FFD.Constants.BlankPersonContextBatchSlim,
      INTEGER8 inFFDOptionsMask = 0,
      INTEGER FCRAPurpose = FCRA.FCRAPurpose.NoValueProvided,
      BOOLEAN rollup_by_case_link = FALSE) := FUNCTION

      tmsidsgrpd := GROUP(SORT(in_tmsids,acctno,tmsid),acctno);

      RETURN liensv2_services.fn_get_liens_tmsid(tmsidsgrpd,in_ssn_mask_type,IsFCRA,in_filing_jurisdiction,
                                                person_filter_id,return_multiple_pages,appType,includeCriminalIndicators,
                                                ds_slim_pc,inFFDOptionsMask,FCRAPurpose,rollup_by_case_link);
    END;

    // Returns the liens data in the report summary view using TMSIDs as a lookup mechanism.
    EXPORT by_tmsid(
      DATASET(liensv2_services.layout_tmsid) in_tmsids,
      STRING in_ssn_mask_type = '',
      BOOLEAN IsFCRA = FALSE,
      STRING in_filing_jurisdiction = '',
      STRING person_filter_id = '',
      BOOLEAN return_multiple_pages = FALSE,
      STRING32 appType,
      BOOLEAN includeCriminalIndicators=FALSE,
      DATASET(FFD.Layouts.PersonContextBatchSlim) ds_slim_pc = FFD.Constants.BlankPersonContextBatchSlim,
      INTEGER8 inFFDOptionsMask = 0,
      INTEGER FCRAPurpose = FCRA.FCRAPurpose.NoValueProvided,
      BOOLEAN rollup_by_case_link = FALSE ) := FUNCTION
      RETURN UNGROUP(by_tmsid_batch(GROUP(sorted(in_tmsids, acctno), acctno),in_ssn_mask_type,
                                    IsFCRA,in_filing_jurisdiction,person_filter_id,
                                    return_multiple_pages,appType,includeCriminalIndicators,
                                    ds_slim_pc,inFFDOptionsMask,FCRAPurpose,rollup_by_case_link));
    END;

       // Batch - Returns the liens data in the report summary view using DIDs as a lookup mechanism.
       EXPORT by_did_batch(
        GROUPED DATASET(doxie.layout_references_acctno) in_dids,
        STRING in_ssn_mask_type = '',
        BOOLEAN IsFCRA = FALSE,
        STRING1 in_party_type = '',
        STRING32 appType,
        BOOLEAN includeCriminalIndicators=FALSE,
        DATASET(FFD.Layouts.PersonContextBatchSlim) ds_slim_pc = FFD.Constants.BlankPersonContextBatchSlim,
        INTEGER8 inFFDOptionsMask = 0,
        INTEGER FCRAPurpose = FCRA.FCRAPurpose.NoValueProvided,
        BOOLEAN rollup_by_case_link = FALSE ) := FUNCTION
         RETURN by_tmsid_batch(get_tmsids_from_dids_batch(in_dids, IsFCRA, in_party_type),
                  in_ssn_mask_type,IsFCRA,'','',FALSE,appType,includeCriminalIndicators,
                ds_slim_pc,inFFDOptionsMask,FCRAPurpose,rollup_by_case_link);
       END;


    // Returns the liens data in the report summary view using DIDs as a lookup mechanism.
    EXPORT by_did(DATASET(doxie.layout_references) in_dids,
                  STRING in_ssn_mask_type = '',
                  BOOLEAN IsFCRA = FALSE,
                  STRING1 in_party_type = '',
                  STRING32 appType,
                  BOOLEAN includeCriminalIndicators=FALSE,
                  DATASET(FFD.Layouts.PersonContextBatchSlim) ds_slim_pc = FFD.Constants.BlankPersonContextBatchSlim,
                  INTEGER8 inFFDOptionsMask = 0,
                  INTEGER FCRAPurpose = FCRA.FCRAPurpose.NoValueProvided,
                  BOOLEAN rollup_by_case_link = FALSE ) := FUNCTION
      ds_batch := GROUP(sorted(PROJECT(in_dids, doxie.layout_references_acctno), acctno), acctno);
      RETURN UNGROUP(by_did_batch(ds_batch,in_ssn_mask_type,IsFCRA,in_party_type,
                                    appType,includeCriminalIndicators,ds_slim_pc,
                      inFFDOptionsMask,FCRAPurpose,rollup_by_case_link));
    END;


    // Returns the liens data in the report summary view using BDIDs as a lookup mechanism.
    EXPORT by_bdid(DATASET(doxie_cbrs.layout_references) in_bdids,
                   UNSIGNED in_limit = 0,
                   STRING in_ssn_mask_type = '',
                   STRING1 in_party_type = '',
                   STRING32 appType,
                   BOOLEAN includeCriminalIndicators=FALSE,
                   DATASET(FFD.Layouts.PersonContextBatchSlim) ds_slim_pc = FFD.Constants.BlankPersonContextBatchSlim,
                   INTEGER8 inFFDOptionsMask = 0,
                   BOOLEAN rollup_by_case_link = FALSE) := FUNCTION
      RETURN by_tmsid(get_tmsids_from_bdids(in_bdids,in_limit,in_party_type),in_ssn_mask_type,FALSE,'','',
                    FALSE,appType,includeCriminalIndicators,ds_slim_pc,inFFDOptionsMask,,rollup_by_case_link);
    END;

  END;

  // ======================================================================
  // Returns non-FCRA liens data in the moxie view (ungrouped and not rolled up)
  // ======================================================================
  EXPORT moxie_view := MODULE

    // Returns the liens data in the moxie view using tmsids as a lookup mechanism.
    EXPORT by_rmsid(DATASET(liensv2_services.layout_rmsid) in_rmsids,
                    STRING in_ssn_mask_type, SET OF STRING1 name_types = ALL,
                    BOOLEAN isReport = FALSE, STRING32 appType='') := FUNCTION

      ds_dedup := DEDUP(SORT(in_rmsids,tmsid,rmsid),tmsid,rmsid);
      res_main := JOIN (ds_dedup, liensv2.key_liens_main_id,
                        KEYED(LEFT.tmsid = RIGHT.tmsid) AND KEYED(LEFT.rmsid = RIGHT.rmsid),
                        LIMIT(10000));

      // Get party; use penalty to retain or skip records depending on the query type
      liensv2.layout_liens_party GetParty (liensv2_services.layout_rmsid le, liensv2.key_liens_party_id ri) := TRANSFORM
          penaddr := doxie.FN_Tra_Penalty_addr(ri.predir,ri.prim_range,ri.prim_name,ri.addr_suffix,ri.postdir,ri.sec_range,ri.p_city_name,ri.st,ri.zip);

          dpenalt := penaddr +
                    doxie.FN_Tra_Penalty_DID(ri.did) +
                    doxie.FN_Tra_Penalty_SSN(ri.ssn) +
                    doxie.FN_Tra_Penalty_Name(ri.fname, ri.mname, ri.lname);
          bpenalt := penaddr +
                    doxie.FN_Tra_Penalty_BDID(ri.bdid) +
                    doxie.FN_Tra_Penalty_CName(ri.cname);

          ReportSkip := isReport AND ri.name_type='D' AND ~(doxie.FN_Tra_Penalty_BDID(ri.bdid) = 0 OR doxie.FN_Tra_Penalty_DID(ri.did) = 0);
          RegularSkip := ~isReport AND ri.name_type='D' AND dpenalt>0 AND bpenalt>0;

          SELF.rmsid := IF(ReportSkip OR RegularSkip,SKIP,ri.rmsid);
          SELF := ri;
      END;

      res_party := JOIN (ds_dedup, liensv2.key_liens_party_id,
                          KEYED(LEFT.tmsid = RIGHT.tmsid) AND KEYED(LEFT.rmsid = RIGHT.rmsid) AND
                          RIGHT.name_type IN name_types,
                          GetParty (LEFT,RIGHT), LIMIT(10000));

      res_joined := JOIN(res_main,res_party,LEFT.tmsid = RIGHT.tmsid AND LEFT.rmsid = RIGHT.rmsid,LEFT OUTER);

      // pull, mask
      Suppress.MAC_pullIDs_tmsid(res_joined, pulled,FALSE,TRUE,appType,'LIENS');
      Suppress.MAC_Mask(pulled, res_masked, ssn, null, TRUE, FALSE, maskVal:=in_ssn_mask_type);

      RETURN DEDUP(SORT(res_masked,RECORD),RECORD);
    END;

    // Returns the liens data in the moxie view using dids as a lookup mechanism.
    EXPORT by_did(DATASET(doxie.layout_references) in_dids,
                  STRING in_ssn_mask_type = '',
                  STRING1 in_party_type = '', BOOLEAN isReport = FALSE,STRING32 appType='') := FUNCTION
      RETURN by_rmsid(get_rmsids_from_dids(in_dids, , FALSE, in_party_type), in_ssn_mask_type, , isReport,appType);
    END;

    // Returns the liens data in the moxie view using bdids as a lookup mechanism.
    EXPORT by_bdid(DATASET(doxie_cbrs.layout_references) in_bdids,
                   STRING in_ssn_mask_type = '',
                   STRING1 in_party_type = '',
                   STRING32 appType='') := FUNCTION
      RETURN by_rmsid(get_rmsids_from_bdids(in_bdids, , , in_party_type),in_ssn_mask_type, , FALSE, appType);
    END;
  END;


  // ==========================================================================
  // Returns the liens data in the source view (grouped and rolled up by RMSID)
  // ==========================================================================
  EXPORT source_view := MODULE

    // Returns the liens data in the source view using rmsids as a lookup mechanism.
    SHARED by_rmsid(DATASET(liensv2_services.layout_rmsid) in_rmsids,
                    STRING in_ssn_mask_type,
                    STRING32 appType,
                    BOOLEAN includeCriminalIndicators=FALSE) := FUNCTION
      RETURN liensv2_services.fn_get_liens_rmsid(GROUP(sorted(in_rmsids, acctno), acctno),in_ssn_mask_type,appType,includeCriminalIndicators);
    END;

    // Returns the liens data in the source view using tmsids as a lookup mechanism.
    EXPORT by_tmsid(DATASET(liensv2_services.layout_tmsid) in_tmsids,
                    STRING in_ssn_mask_type = '',
                    STRING32 appType,
                    BOOLEAN includeCriminalIndicators=FALSE) := FUNCTION
      RETURN by_rmsid(get_rmsids_from_tmsids(in_tmsids),in_ssn_mask_type,appType,includeCriminalIndicators);
    END;

    // Returns the liens data in the source view using dids as a lookup mechanism.
    EXPORT by_did(DATASET(doxie.layout_references) in_dids,
                  STRING in_ssn_mask_type = '',
                  STRING1 in_party_type = '',
                  STRING32 appType,
                  BOOLEAN includeCriminalIndicators=FALSE) := FUNCTION
      RETURN by_rmsid(get_rmsids_from_dids(in_dids, , , in_party_type),in_ssn_mask_type,appType,includeCriminalIndicators);
    END;

    // Returns the liens data in the source view using bdids as a lookup mechanism.
    EXPORT by_bdid(DATASET(doxie_cbrs.layout_references) in_bdids,
                   UNSIGNED in_limit = 0,
                   STRING in_ssn_mask_type = '',
                   STRING1 in_party_type = '',
                   STRING32 appType,
                   BOOLEAN includeCriminalIndicators=FALSE) := FUNCTION
      RETURN by_rmsid(get_rmsids_from_bdids(in_bdids,in_limit, ,in_party_type),in_ssn_mask_type,appType,includeCriminalIndicators);
    END;
  END;
  // ==========================================================================
  // Returns a "flat" version of liens & judgment data (for fcra courtrunner)
  // IMPORTANT:
  // . overrides are not applied (court runner requirement).
  // . if using anywhere other than court-runner, you MUST change this function
  // to apply overrides.
  // ==========================================================================
  EXPORT Retrieval_view_fcra := MODULE

     EXPORT by_did(DATASET(doxie.layout_references) in_dids,
      DATASET (fcra.Layout_override_flag) flagfile,
      DATASET(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
      INTEGER8 inFFDOptionsMask,
      INTEGER FCRAPurpose
      ) := FUNCTION

      today := (STRING) STD.Date.Today();
      BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
      BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
      liens_correct_record_id := SET (flagfile (file_id = FCRA.FILE_ID.LIEN), record_id);

      tmsids := JOIN(DEDUP(SORT(in_dids,did),did), liensv2.key_liens_did_fcra,
        KEYED(LEFT.did = RIGHT.did),
        TRANSFORM(with_did, SELF := RIGHT),
        atmost(1000),
        KEEP(100));

      party_recs_raw := JOIN(tmsids, liensv2.key_liens_party_id_fcra,
        KEYED(LEFT.tmsid = RIGHT.tmsid)
        AND LEFT.did = (UNSIGNED6) RIGHT.did
        AND RIGHT.name_type[1] = 'D' // debtors only, RIGHT?
        AND TRIM((STRING)RIGHT.persistent_record_id) NOT IN liens_correct_record_id,
        TRANSFORM($.layout_liens_Retrieval.search_recs,
          SELF.tmsid := LEFT.tmsid;
          SELF.did := LEFT.did;
          SELF := RIGHT;
          SELF := [];
        ), atmost(1000), KEEP(100));

      $.layout_liens_retrieval.search_recs xformStatements($.layout_liens_Retrieval.search_recs l, FFD.Layouts.PersonContextBatchSlim r)
      := TRANSFORM, SKIP((~ShowDisputedRecords AND r.isDisputed) OR (~ShowConsumerStatements AND EXISTS(r.StatementIDs)))
        SELF.StatementIDs := r.StatementIDs;
        SELF.isDisputed := r.isDisputed;
        SELF := l;
      END;

      party_recs := JOIN(party_recs_raw, slim_pc_recs(datagroup = FFD.Constants.DataGroups.LIEN_PARTY),
        LEFT.did = (UNSIGNED6) RIGHT.lexid
        AND LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
        xformStatements(LEFT, RIGHT),
        LEFT OUTER,
        KEEP(1), atmost(1000));

      main_recs_raw := JOIN(DEDUP(SORT(party_recs, tmsid), tmsid), liensv2.key_liens_main_id_fcra,
        KEYED(LEFT.tmsid = RIGHT.tmsid)
        AND TRIM( (STRING) RIGHT.persistent_record_id) NOT IN liens_correct_record_id
        AND FCRA.lien_is_ok (today, RIGHT.orig_filing_date), // drop older records
        TRANSFORM($.layout_liens_retrieval.search_recs,
          SELF := RIGHT;
          SELF := LEFT;
        ), KEEP(100), atmost(1000));

    $.layout_liens_retrieval.search_recs xformStatements_Main($.layout_liens_Retrieval.search_recs l, FFD.Layouts.PersonContextBatchSlim r)
      := TRANSFORM, SKIP((~ShowDisputedRecords AND r.isDisputed) OR (~ShowConsumerStatements AND EXISTS(r.StatementIDs)))
        SELF.StatementIDs := r.StatementIDs;
        SELF.isDisputed := r.isDisputed;
        SELF := l;
      END;

      main_recs := JOIN(main_recs_raw, slim_pc_recs(datagroup = FFD.Constants.DataGroups.LIEN_MAIN),
        LEFT.did = (UNSIGNED6) RIGHT.lexid
        AND LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
        xformStatements_Main(LEFT, RIGHT),
        LEFT OUTER,
        KEEP(1), atmost(1000));

      RETURN main_recs;
    END;
  END;

END;

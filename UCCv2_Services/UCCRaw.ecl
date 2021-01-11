IMPORT BIPV2, doxie, doxie_cbrs, UCCv2, FCRA, FFD;

// This module provides UCC data in different formats.
EXPORT UCCRaw := MODULE

  // Gets RMSIDs from TMSIDs
  EXPORT get_rmsids_from_tmsids(DATASET(UCCv2_Services.layout_tmsid) in_tmsids) := FUNCTION
    key := UCCV2.Key_Rmsid_Main ();
    res := JOIN(DEDUP(SORT(in_tmsids,tmsid),tmsid),key,
                KEYED(LEFT.tmsid = RIGHT.tmsid),
                TRANSFORM(UCCv2_Services.layout_rmsid,SELF := RIGHT),
                LIMIT(10000,SKIP));
    RETURN DEDUP(SORT(res,tmsid,rmsid),tmsid,rmsid);
  END;
  
  // Gets RMSIDs from DIDs
  // FCRA: this function is for producing internal IDs, no overrides required
  EXPORT get_rmsids_from_dids(DATASET(doxie.layout_references) in_dids,STRING1 in_party_type = '') := FUNCTION
    key := uccv2.key_did_w_Type ();
    res := JOIN(DEDUP(SORT(in_dids,did),did),key,
                KEYED(LEFT.did = RIGHT.did) AND
                KEYED(in_party_type='' OR RIGHT.party_type=in_party_type),
                TRANSFORM(UCCv2_Services.layout_rmsid,SELF := RIGHT),
                LIMIT(10000,SKIP));
    RETURN DEDUP(SORT(res,tmsid,rmsid),tmsid,rmsid);
  END;

  // Gets RMSIDs from BDIDs
  EXPORT get_rmsids_from_bdids(DATASET(doxie_cbrs.layout_references) in_bdids,
                               UNSIGNED in_limit = 0, BOOLEAN isMoxie = FALSE,
                               STRING1 in_party_type = '') := FUNCTION
    key := UCCV2.Key_Bdid_w_Type;
    res_r := JOIN(DEDUP(SORT(in_bdids,bdid),bdid),key,
                KEYED(LEFT.bdid = RIGHT.bdid) AND
                KEYED(in_party_type='' OR RIGHT.party_type=in_party_type),
                TRANSFORM(UCCv2_Services.layout_rmsid,SELF := RIGHT),
                LIMIT(10000,SKIP));
    res_m := JOIN(DEDUP(SORT(in_bdids,bdid),bdid),key,
                KEYED(LEFT.bdid = RIGHT.bdid) AND
                KEYED(in_party_type='' OR RIGHT.party_type=in_party_type),
                TRANSFORM(UCCv2_Services.layout_rmsid,SELF := RIGHT),
                LIMIT(500,SKIP));
    res := IF(isMoxie,res_m,res_r);
    ded := DEDUP(SORT(res,tmsid,rmsid),tmsid,rmsid);
    RETURN IF(in_limit = 0,ded,CHOOSEN(ded,in_limit));
  END;

  // Gets RMSIDs from Filing Number
  EXPORT get_rmsids_from_Filing_Number(DATASET(UCCv2_Services.layout_filing_number) in_filing_number) := FUNCTION
    key := UCCV2.Key_filing_number;
    res := JOIN(DEDUP(SORT(in_filing_number,filing_number),filing_number),key,
                KEYED(LEFT.filing_number = RIGHT.filing_number),
                TRANSFORM(UCCv2_Services.layout_rmsid, SELF := RIGHT),
                LIMIT(1000,SKIP));
    RETURN DEDUP(SORT(res,tmsid,rmsid),tmsid,rmsid);
  END;

  // Gets RMSIDs from FEIN
  EXPORT get_rmsids_from_FEIN(DATASET(UCCv2_Services.layout_fein) in_fein) := FUNCTION
    key := UCCV2.Key_Fein;
    res := JOIN(DEDUP(SORT(in_fein,fein),fein),key,
                KEYED(LEFT.fein = RIGHT.fein),
                TRANSFORM(UCCv2_Services.layout_rmsid, SELF := RIGHT),
                LIMIT(1000,SKIP));
    RETURN DEDUP(SORT(res,tmsid,rmsid),tmsid,rmsid);
  END;
  
  // Gets TMSIDs from DIDs
  // FCRA: this function is for producing internal IDs, no overrides required
  // Note: TMSID suppressions not done here. They are being done in the report section
  // and is the responsibility of the caller to suppress them if not using the standard functions
  EXPORT get_tmsids_from_dids(DATASET(doxie.layout_references) in_dids,
                              STRING1 in_party_type = ''
                              ) := FUNCTION
    key := uccv2.key_did_w_Type ();
    res := JOIN(DEDUP(SORT(in_dids,did),did),key,
                KEYED(LEFT.did = RIGHT.did) AND
                KEYED(in_party_type='' OR RIGHT.party_type=in_party_type),
                TRANSFORM(UCCv2_Services.layout_tmsid, SELF := RIGHT),
                LIMIT(1000,SKIP));
    
    RETURN DEDUP(SORT(res,tmsid),tmsid);
  END;

  // Gets TMSIDs from BDIDs
  // Note: TMSID suppressions not done here. They are being done in the report section
  // and is the responsibility of the caller to suppress them if not using the standard functions
  EXPORT get_tmsids_from_bdids(DATASET(doxie_cbrs.layout_references) in_bdids,
                               UNSIGNED in_limit = 0,
                               STRING1 in_party_type = '') := FUNCTION
    key := UCCV2.Key_Bdid_w_Type;
    res := JOIN(DEDUP(SORT(in_bdids,bdid),bdid),key,
                KEYED(LEFT.bdid = RIGHT.bdid) AND
                KEYED(in_party_type='' OR RIGHT.party_type=in_party_type),
                TRANSFORM(UCCv2_Services.layout_tmsid, SELF := RIGHT),
                LIMIT(1000,SKIP));
    ded := DEDUP(SORT(res,tmsid),tmsid);
    
    RETURN IF(in_limit = 0,ded,CHOOSEN(ded,in_limit));
  END;

  EXPORT get_tmsids_from_linkIds(DATASET(BIPV2.IDlayouts.l_xlink_ids) in_linkIds,
                                 STRING1 businessIdFetchLevel,
                                 UNSIGNED in_limit = 0,
                                 STRING1 in_party_type = '') := FUNCTION

    // *** Key fetch to get ucc tmsids from linkids
    ds_ucclink := UCCv2.Key_LinkIds.KeyFetch(in_linkIds, businessIdFetchLevel);
                              
    ds_ucckeys := PROJECT(ds_ucclink(party_type != 'A'),
                                TRANSFORM(UCCv2_Services.layout_tmsid,
                                          SELF := LEFT));
                                          
                                          
    ded := DEDUP(SORT(ds_ucckeys, tmsid), tmsid);

    RETURN IF(in_limit = 0, ded, CHOOSEN(ded,in_limit));
  END;

  // Gets TMSIDs from RMSIDs
  // Note: TMSID suppressions not done here. They are being done in the report section
  // and is the responsibility of the caller to suppress them if not using the standard functions
  EXPORT get_tmsids_from_rmsids(DATASET(UCCv2_Services.layout_rmsid) in_rmsids) := FUNCTION
    key := UCCV2.Key_Rmsid;
    res := JOIN(DEDUP(SORT(in_rmsids,rmsid),rmsid),key,
                KEYED(LEFT.rmsid = RIGHT.rmsid),
                TRANSFORM(UCCv2_Services.layout_rmsid, SELF := RIGHT),
                LIMIT(1000,SKIP));
    
    RETURN DEDUP(SORT(res,tmsid,rmsid),tmsid,rmsid);
  END;
  
  // Returns UCC data in Legacy format (matches old-style UCC)
  EXPORT legacy_view := MODULE
  
    // ...using TMSIDs as the lookup mechanism.
    EXPORT raw_by_tmsid(
      DATASET(UCCv2_services.layout_tmsid) in_tmsids,
      STRING in_ssn_mask_type = ''
    ) := FUNCTION
      RETURN UCCv2_services.Legacy.fn_getUCC_legacy_raw(in_tmsids, in_ssn_mask_type);
    END;

    // ...using TMSIDs/Levels as the lookup mechanism.
    EXPORT raw_with_levels(
      DATASET(UCCv2_services.layout_legacy.level_rec) in_levels,
      STRING in_ssn_mask_type = ''
    ) := FUNCTION
      RETURN UCCv2_services.Legacy.fn_getUCC_legacy_rawLevels(in_levels, in_ssn_mask_type);
    END;

    // ...using TMSIDs as the lookup mechanism.
    EXPORT by_tmsid(
      DATASET(UCCv2_services.layout_tmsid) in_tmsids,
      STRING in_ssn_mask_type = ''
    ) := FUNCTION
      RETURN UCCv2_services.Legacy.fn_getUCC_legacy(in_tmsids, in_ssn_mask_type);
    END;

    // ...using DIDs as the lookup mechanism.
    EXPORT by_did(DATASET(doxie.layout_references) in_dids,
                  STRING in_ssn_mask_type = '',
                  STRING1 in_party_type = '') := FUNCTION
      RETURN by_tmsid(get_tmsids_from_dids(in_dids,in_party_type),in_ssn_mask_type);
    END;
    
    // ...using BDIDs as the lookup mechanism.
    EXPORT by_bdid(DATASET(doxie_cbrs.layout_references) in_bdids,
                   UNSIGNED in_limit = 0,
                   STRING in_ssn_mask_type = '',
                   STRING1 in_party_type = '') := FUNCTION
      RETURN by_tmsid(get_tmsids_from_bdids(in_bdids,in_limit,in_party_type),in_ssn_mask_type);
    END;
    
    // ...using both DIDs & BDIDs as the lookup mechanism.
    EXPORT by_both_ids(
      DATASET(doxie.layout_references) in_dids,
      DATASET(doxie_cbrs.layout_references) in_bdids,
      STRING in_ssn_mask_type = '',
      STRING1 in_party_type = '') := FUNCTION
      
      tmsids := DEDUP(
        get_tmsids_from_dids(in_dids,in_party_type)
          + get_tmsids_from_bdids(in_bdids,0,in_party_type),
        RECORD,
        all
      );
      
      RETURN by_tmsid(tmsids,in_ssn_mask_type);
    END;
  END;
  
  // Returns UCC data in the report summary view (grouped and rolled up by TMSID)
  EXPORT report_view := MODULE
  
    // ...using TMSIDs as the lookup mechanism.
    EXPORT by_tmsid(
      DATASET(UCCv2_services.layout_tmsid) in_tmsids,
      STRING in_ssn_mask_type = ''
    ) := FUNCTION
      RETURN UCCv2_services.fn_getUCC_tmsid (in_tmsids, in_ssn_mask_type);
    END;

    // ...using DIDs as the lookup mechanism.
    EXPORT by_did(DATASET(doxie.layout_references) in_dids,
                  STRING in_ssn_mask_type = '',
                  STRING1 in_party_type = ''
    ) := FUNCTION
      tmsids := get_tmsids_from_dids(in_dids,in_party_type);
      res := by_tmsid(tmsids,in_ssn_mask_type);
      RETURN res;
    END;

    // ...using BDIDs as the lookup mechanism.
    EXPORT by_bdid(DATASET(doxie_cbrs.layout_references) in_bdids,
                   UNSIGNED in_limit = 0,
                   STRING in_ssn_mask_type = '',
                   STRING1 in_party_type = ''
                   ) := FUNCTION
      RETURN by_tmsid(get_tmsids_from_bdids(in_bdids,in_limit,in_party_type),in_ssn_mask_type);
    END;
  END;

  // Returns UCC data in the source view (grouped and rolled up by RMSID)
  EXPORT source_view := MODULE
  
    // ...using rmsids as a lookup mechanism.
    EXPORT by_rmsid(
      DATASET(UCCv2_services.layout_rmsid) in_rmsids,
      STRING in_ssn_mask_type,
      BOOLEAN return_multiple_pages = FALSE,
      STRING32 appType
    ) := FUNCTION
      RETURN UCCv2_Services.fn_getUCC_rmsid(in_rmsids, in_ssn_mask_type, return_multiple_pages,appType);
    END;
    
    // ...using tmsids as a lookup mechanism.
    EXPORT by_tmsid(
      DATASET(UCCv2_services.layout_tmsid) in_tmsids,
      STRING in_ssn_mask_type = '',
      BOOLEAN return_multiple_pages = FALSE,
      STRING32 appType
    ) := FUNCTION
      RETURN by_rmsid(get_rmsids_from_tmsids(in_tmsids), in_ssn_mask_type, return_multiple_pages,appType);
    END;
    
    // ...using dids as a lookup mechanism.
    EXPORT by_did(
      DATASET(doxie.layout_references) in_dids,
      STRING in_ssn_mask_type = '',
      STRING1 in_party_type = '',
      STRING32 appType
    ) := FUNCTION
      RETURN by_rmsid(get_rmsids_from_dids(in_dids,in_party_type), in_ssn_mask_type, FALSE, appType);
    END;
    
    // ...using bdids as a lookup mechanism.
    EXPORT by_bdid(
      DATASET(doxie_cbrs.layout_references) in_bdids,
      UNSIGNED in_limit = 0,
      STRING in_ssn_mask_type = '',
      STRING1 in_party_type = '',
      STRING32 appType
    ) := FUNCTION
      RETURN by_rmsid(get_rmsids_from_bdids(in_bdids,in_limit,,in_party_type), in_ssn_mask_type, FALSE, appType);
    END;
  END;

END;

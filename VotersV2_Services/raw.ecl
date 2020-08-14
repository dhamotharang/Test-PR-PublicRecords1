// This MODULE provides voters data in different formats.
IMPORT VotersV2, doxie, suppress, ut, census_data, codes,AutoStandardI;

//IMPORTANT FCRA-NOTE: -- FCRA ISN't USED SO FAR, placeholders are reserved for future needs

EXPORT raw := MODULE

  // Batch - Gets voters' IDs from DIDs (grouped by acctno)
  EXPORT Get_vtids_from_dids_batch (GROUPED DATASET (doxie.layout_references_acctno) in_dids,
                                    BOOLEAN IsFCRA = FALSE) := FUNCTION

    res := JOIN (DEDUP (SORT (in_dids, did), did), VotersV2.key_voters_did,
      KEYED (LEFT.did = RIGHT.did),
      TRANSFORM (VotersV2_services.layout_vtid, SELF.acctno := LEFT.acctno, SELF.vtid := RIGHT.vtid),
      LIMIT (ut.limits.VOTERS_PER_DID, SKIP));

    RETURN DEDUP (SORT (res, vtid), vtid); //why sort???
  END;
  
  EXPORT Layout_vtid Get_vtids_from_dids (DATASET (Doxie.layout_references) dids) := FUNCTION
    dids_batch := GROUP (SORTED (PROJECT (dids, doxie.layout_references_acctno), acctno), acctno);
    RETURN UNGROUP (Get_vtids_from_dids_batch (dids_batch));
  END;


  // =============================================
  // Returns the voters data as part of the report
  // =============================================
  EXPORT REPORT_VIEW := MODULE

    // Batch - voters by vtids: this is main call - all other methods use this function
    EXPORT by_vtid_batch (GROUPED DATASET (VotersV2_Services.layout_vtid) in_vtids,
                          STRING in_ssn_mask_type = '',
                          BOOLEAN IsFCRA = FALSE) := FUNCTION
      res := VotersV2_Services.GetVotersByID (in_vtids, in_ssn_mask_type);
      RETURN PROJECT (res, layouts.EmbeddedOutput);
    END;

    // Batch - voters by dids
    EXPORT by_did_batch (GROUPED DATASET (doxie.layout_references_acctno) in_dids,
                         STRING in_ssn_mask_type = '',
                         BOOLEAN IsFCRA = FALSE) := FUNCTION
      RETURN by_vtid_batch (Get_vtids_from_dids_batch (in_dids, IsFCRA), in_ssn_mask_type, IsFCRA);
    END;


    // Returns voters by VTIDs
    EXPORT by_vtid (DATASET (VotersV2_services.layout_vtid) in_vtids,
                    STRING in_ssn_mask_type = '') := FUNCTION
      RETURN UNGROUP (by_vtid_batch (GROUP (SORTED (in_vtids, acctno), acctno),in_ssn_mask_type));
    END;
  
    // Returns voters by DIDs
    EXPORT by_did (DATASET (doxie.layout_references) in_dids,
                   STRING in_ssn_mask_type = '',
                   BOOLEAN IsFCRA = FALSE) := FUNCTION

      ds_batch := GROUP (SORTED (PROJECT (in_dids, doxie.layout_references_acctno), acctno), acctno);
      RETURN UNGROUP (by_did_batch (ds_batch, in_ssn_mask_type, IsFCRA));
    END;
  END;

  
  // ======================================================================
  // Returns the voters data in the moxie view
  // ======================================================================
  EXPORT MOXIE_VIEW := MODULE

    //here we use new data and return it in the old format (no child datasets)
    EXPORT by_vtid (DATASET (VotersV2_services.layout_vtid) in_vtids,
                    STRING in_ssn_mask_type = '',
                    BOOLEAN IsFCRA = FALSE) := FUNCTION

      // Get general info
      ds_voters := JOIN (in_vtids, VotersV2.Key_Voters_VTID,
        KEYED (LEFT.vtid = RIGHT.vtid),
        TRANSFORM (VotersV2.Layouts_Voters.Layout_Voters_base, SELF := RIGHT),
        //there can be more records per vtid than by did, but this constant is set to a safe threshhold
        LIMIT (ut.limits.VOTERS_PER_DID, SKIP));

      // masking, pulling
      appType := AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
      Suppress.MAC_Suppress(ds_voters,ds_pull_1,appType,Suppress.Constants.LinkTypes.DID,did);
      Suppress.MAC_Suppress(ds_pull_1,ds_pull_2,appType,Suppress.Constants.LinkTypes.SSN,ssn);

      doxie.MAC_PruneOldSSNs (ds_pull_2, ds_prunned, ssn, did);
      Suppress.MAC_Mask(ds_prunned, ds_mskd, ssn, null, TRUE, FALSE, maskVal:=in_ssn_mask_type);

      srt := SORT (ds_mskd, RECORD); // sorting is better after pulling
     
      // place into the old layout until we start using new layout for all customers (so far it is used only here)
      ds_old_format := GetVotersInOldFormat (srt);

      // mapping
      codes.mac_map_gender (ds_old_format, gender, gender_mapped, ds_map_1);
      codes.mac_map_race (ds_map_1, race, race_mapped, ds_map_2) // it's in the key, actually, with blank=unknown
      codes.mac_map_state (ds_map_2, source_state, source_state_mapped, ds_map_3);
      census_data.MAC_Fips2County_Keyed (ds_map_3, st, county, county_name, ds_map_4);

      RETURN ds_map_4;
    END;

    // by did
    EXPORT by_did (DATASET(doxie.layout_references) in_dids,
                   STRING in_ssn_mask_type = '',
                   BOOLEAN IsFCRA = FALSE) := FUNCTION
      RETURN by_vtid (Get_vtids_from_dids (in_dids), in_ssn_mask_type, IsFCRA);
    END;
  END;


  // ==========================================================================
  // Returns the voters data in search view
  // ==========================================================================
  EXPORT SEARCH_VIEW := MODULE
    //NB: FCRA rules, probably, are not applied to search; also there's no batch

    // Returns voters by VTIDs
    EXPORT by_vtid (DATASET (VotersV2_services.layout_vtid) in_vtids,
                    STRING in_ssn_mask_type = '') := FUNCTION

      vtids_grp := GROUP (SORTED (in_vtids, acctno), acctno);
      res := UNGROUP (VotersV2_Services.GetVotersByID (vtids_grp, in_ssn_mask_type));
      RETURN PROJECT (res, layouts.SearchOutput);
    END;
  END;

  
  // ================================================================
  // Returns the voters data in the stand-alone source or report view
  // ================================================================

  //TODO: check if batch is needed
  EXPORT SOURCE_VIEW := MODULE
    // by vtid
    EXPORT by_vtid (DATASET(VotersV2_services.layout_vtid) in_vtids,
                    STRING in_ssn_mask_type = '',
                    BOOLEAN IsFCRA = FALSE,
                    STRING32 appType) := FUNCTION

      // have to dedup in case of invalid input; grouping is formal (unless batch)
      ds_grp := GROUP (SORTED (DEDUP (in_vtids, ALL), acctno), acctno);
      //ds_grp := GROUP (SORTED (in_vtids, acctno), acctno); for deployment in SR < SR6

      ds_voters := VotersV2_services.GetVotersSourceByID (ds_grp, in_ssn_mask_type,,appType);
      RETURN UNGROUP (ds_voters);
    END;

    // by did
    EXPORT by_did (DATASET(doxie.layout_references) in_dids,
                   STRING in_ssn_mask_type = '',
                   BOOLEAN IsFCRA = FALSE,
                   STRING32 appType) := FUNCTION
      RETURN by_vtid (Get_vtids_from_dids (in_dids), in_ssn_mask_type, IsFCRA, AppType);
    END;
  END;

END;
